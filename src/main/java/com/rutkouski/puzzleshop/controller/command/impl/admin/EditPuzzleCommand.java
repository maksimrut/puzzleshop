package com.rutkouski.puzzleshop.controller.command.impl.admin;

import com.rutkouski.puzzleshop.controller.Router;
import com.rutkouski.puzzleshop.controller.command.Command;
import com.rutkouski.puzzleshop.exception.CommandException;
import com.rutkouski.puzzleshop.exception.ServiceException;
import com.rutkouski.puzzleshop.model.service.impl.PuzzleServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.HashMap;
import java.util.Map;

import static com.rutkouski.puzzleshop.controller.command.AttributeName.ERROR_MESSAGE;
import static com.rutkouski.puzzleshop.controller.command.AttributeName.INVALID_INPUT;
import static com.rutkouski.puzzleshop.controller.command.PagePath.*;
import static com.rutkouski.puzzleshop.controller.command.ParameterName.*;

/**
 * The EditPuzzleCommand provides changing
 * puzzle data in database
 *
 * @see com.rutkouski.puzzleshop.controller.command.Command
 */
public class EditPuzzleCommand implements Command {
    static Logger logger = LogManager.getLogger();
    private final PuzzleServiceImpl puzzleService = PuzzleServiceImpl.getInstance();

    @Override
    public Router execute(HttpServletRequest request) throws CommandException {
        Router router = new Router();
        Map<String, String> formValues = new HashMap<>();
        String stringPuzzleId = request.getParameter(PUZZLE_ID);
        formValues.put(PUZZLE_ID, stringPuzzleId);
        formValues.put(NAME, request.getParameter(NAME));
        formValues.put(PRICE, request.getParameter(PRICE));
        formValues.put(DIFFICULTY_LEVEL, request.getParameter(DIFFICULTY_LEVEL));
        formValues.put(DESCRIPTION, request.getParameter(DESCRIPTION));
        formValues.put(PICTURE_PATH, request.getParameter(PICTURE_PATH));

        try {
            boolean result = puzzleService.updatePuzzle(formValues);
            if (result) {
                router.setPagePath(SHOW_ALL_GOODS_PAGE);
            } else {
                request.setAttribute(ERROR_MESSAGE, INVALID_INPUT);
                router.setPagePath(GO_TO_EDIT_PUZZLE_PAGE + stringPuzzleId);
            }
        } catch (ServiceException e) {
            logger.error("Puzzle can not be updated: ", e);
            throw new CommandException("Puzzle can not be updated: " + e);
        }
        logger.debug("EditPuzzleCommand (puzzle id={}) was successful", stringPuzzleId);
        return router;
    }
}
