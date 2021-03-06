package com.rutkouski.puzzleshop.controller.command.impl.general;

import com.rutkouski.puzzleshop.controller.Router;
import com.rutkouski.puzzleshop.controller.command.Command;
import com.rutkouski.puzzleshop.exception.CommandException;
import com.rutkouski.puzzleshop.exception.ServiceException;
import com.rutkouski.puzzleshop.model.entity.Puzzle;
import com.rutkouski.puzzleshop.model.entity.User;
import com.rutkouski.puzzleshop.model.service.impl.PuzzleServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.List;

import static com.rutkouski.puzzleshop.controller.command.AttributeName.PUZZLES_LIST;
import static com.rutkouski.puzzleshop.controller.command.PagePath.GOODS_PAGE;
import static com.rutkouski.puzzleshop.controller.command.ParameterName.SELECTED_PUZZLE_DIFFICULTY;

/**
 * The command shows to {@link User}
 * list of puzzles chosen difficulty
 *
 * @see com.rutkouski.puzzleshop.controller.command.Command
 */
public class ShowPuzzlesByDifficultyLevelCommand implements Command {
    static Logger logger = LogManager.getLogger();
    private final PuzzleServiceImpl puzzleService = PuzzleServiceImpl.getInstance();

    @Override
    public Router execute(HttpServletRequest request) throws CommandException {
        Router router = new Router();
        int selectedPuzzleDifficulty = Integer.parseInt(request.getParameter(SELECTED_PUZZLE_DIFFICULTY));
        try {
            List<Puzzle> puzzles = puzzleService.findPuzzlesByDifficultyLevel(selectedPuzzleDifficulty);
            request.setAttribute(PUZZLES_LIST, puzzles);
            router.setPagePath(GOODS_PAGE);
        } catch (ServiceException e) {
            logger.error("Exception occurred in ShowPuzzleByDifficultyLevelCommand class", e);
            throw new CommandException("Exception occurred in ShowPuzzleByDifficultyLevelCommand class" + e);
        }
        return router;
    }
}
