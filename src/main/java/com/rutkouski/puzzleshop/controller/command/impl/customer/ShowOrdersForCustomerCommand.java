package com.rutkouski.puzzleshop.controller.command.impl.customer;

import com.rutkouski.puzzleshop.controller.Router;
import com.rutkouski.puzzleshop.controller.command.Command;
import com.rutkouski.puzzleshop.exception.CommandException;
import com.rutkouski.puzzleshop.exception.ServiceException;
import com.rutkouski.puzzleshop.model.entity.Order;
import com.rutkouski.puzzleshop.model.entity.User;
import com.rutkouski.puzzleshop.model.service.impl.OrderServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.List;

import static com.rutkouski.puzzleshop.controller.command.AttributeName.ALL_CUSTOMER_ORDERS;
import static com.rutkouski.puzzleshop.controller.command.AttributeName.SESSION_USER;
import static com.rutkouski.puzzleshop.controller.command.PagePath.CUSTOMER_ORDERS_LIST_PAGE;

/**
 * The command show all orders made by the {@link User}
 *
 * @see com.rutkouski.puzzleshop.controller.command.Command
 */
public class ShowOrdersForCustomerCommand implements Command {
    static Logger logger = LogManager.getLogger();
    private final OrderServiceImpl orderService = OrderServiceImpl.getInstance();

    @Override
    public Router execute(HttpServletRequest request) throws CommandException {
        Router router = new Router();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute(SESSION_USER);
        int customerId = user.getId();

        try {
            List<Order> orders = orderService.findAllOrdersByCustomerId(customerId);
            request.setAttribute(ALL_CUSTOMER_ORDERS, orders);
            router.setPagePath(CUSTOMER_ORDERS_LIST_PAGE);
        } catch (ServiceException e) {
            logger.error("Error occurred in ShowOrdersForCustomerCommand: ", e);
            throw new CommandException("Error occurred in ShowOrdersForCustomerCommand: " + e);
        }
        return router;
    }
}
