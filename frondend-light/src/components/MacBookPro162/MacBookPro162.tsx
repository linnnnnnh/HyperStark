import { memo } from 'react';
import type { FC } from 'react';

import resets from '../_resets.module.css';
import { AkarIconsDiscordFillIcon } from './AkarIconsDiscordFillIcon.js';
import { AkarIconsGithubFillIcon } from './AkarIconsGithubFillIcon.js';
import { ButtonAccuRewIcon } from './ButtonAccuRewIcon.js';
import { BxlTwitterIcon } from './BxlTwitterIcon.js';
import { Cell_TypeDefault } from './Cell_TypeDefault/Cell_TypeDefault.js';
import { GroupIcon } from './GroupIcon.js';
import classes from './MacBookPro162.module.css';
import { Rectangle3419Icon } from './Rectangle3419Icon.js';
import { Row } from './Row/Row.js';
import { VectorIcon2 } from './VectorIcon2.js';
import { VectorIcon3 } from './VectorIcon3.js';
import { VectorIcon4 } from './VectorIcon4.js';
import { VectorIcon } from './VectorIcon.js';

interface Props {
  className?: string;
}
/* @figmaId 140:46 */
export const MacBookPro162: FC<Props> = memo(function MacBookPro162(props = {}) {
  return (
    <div className={`${resets.clapyResets} ${classes.root}`}>
      <div className={classes.bytesizeMoon}></div>
      <div className={classes.vector}>
        <VectorIcon className={classes.icon} />
      </div>
      <div className={classes.docs}>Docs</div>
      <div className={classes.aboutUs}>About Us</div>
      <div className={classes.vector2}>
        <VectorIcon2 className={classes.icon2} />
      </div>
      <div className={classes.vector3}>
        <VectorIcon3 className={classes.icon3} />
      </div>
      <div className={classes.yourBestChoiceOfYieldOptimizer}>
        <div className={classes.textBlock}>Your Best Choice of Yield Optimizer</div>
        <div className={classes.textBlock2}>on Starknet</div>
      </div>
      <div className={classes.highlights}>Highlights</div>
      <div className={classes.behindTheScene}>Behind the Scene</div>
      <button className={classes.buttonStartNow}>
        <div className={classes.startNow}>
          <p className={classes.labelWrapper}>
            <span className={classes.label}>Start </span>
            <span className={classes.label2}>Now</span>
            <span className={classes.label3}>!</span>
          </p>
        </div>
      </button>
      <div className={classes.nostra}>
        <div className={classes.textBlock3}>Nostra</div>
        <div className={classes.textBlock4}>
          <p></p>
        </div>
      </div>
      <div className={classes.argent}>Argent</div>
      <div className={classes.integrations}>Integrations</div>
      <div className={classes.akarIconsGithubFill}>
        <AkarIconsGithubFillIcon className={classes.icon4} />
      </div>
      <div className={classes.akarIconsDiscordFill}>
        <AkarIconsDiscordFillIcon className={classes.icon5} />
      </div>
      <div className={classes.bxlTwitter}>
        <BxlTwitterIcon className={classes.icon6} />
      </div>
      <div className={classes.vector4}>
        <VectorIcon4 className={classes.icon7} />
      </div>
      <div className={classes.rectangle3413}></div>
      <div className={classes.rectangle3414}></div>
      <div className={classes.rectangle3415}></div>
      <button className={classes.buttonWhatSNext}>
        <div className={classes.whatSNext}>What’s next</div>
      </button>
      <button className={classes.buttonGetStarted}>
        <div className={classes.getStarted}>Get Started !</div>
      </button>
      <button className={classes.buttonLearnMore}>
        <div className={classes.learnMore}>Learn more</div>
      </button>
      <div className={classes.automatedHarvestingAndReinvest}>Automated Harvesting and Reinvesting</div>
      <div className={classes.userFriendly}>User Friendly</div>
      <div className={classes.continueGrowing}>Continue Growing</div>
      <div className={classes.simplifiedUserInterfaceEasyToH}>Simplified user interface, easy to hand-on</div>
      <div className={classes.ourTeamContinuesAddingMoreFunc}>
        Our team continues adding more functions &amp; service to it
      </div>
      <div className={classes.privacy}>Privacy</div>
      <div className={classes.termsAndConditions}>Terms and Conditions</div>
      <div className={classes.findUsOn}>Find us on:</div>
      <div className={classes.image46}></div>
      <div className={classes.image48}></div>
      <div className={classes.efficientAndOptimized}>efficient and optimized</div>
      <div className={classes.frame23}></div>
      <div className={classes.connectToWallet}>Connect to wallet</div>
      <div className={classes.automateCompoundingRewardsForU}>
        Automate compounding rewards for users who deposit tokens into liquidity pools on Starknet. By automating the
        harvesting and reinvesting of rewards, we simplify the user experience and boost yields.
      </div>
      <div className={classes.image49}></div>
      <div className={classes.hyperStarkServesAsAnIntermedia}>
        HyperStark serves as an intermediary, bridging users with Nostra. We operate our own Vault service where users
        can deposit tokens. These deposits are automatically transferred to Nostra&#39;s liquidity pool, and rewards
        from Nostra are seamlessly collected and reinvested through our Vault. This process maximizes user convenience
        by automating deposits, rewards, and reinvestments, effectively providing a restaking service.
      </div>
      <div className={classes.thisIsWhatHappensWhenYouInvest}>
        This is what happens when you invest $1000 in this strategy:
      </div>
      <div className={classes.table}>
        <Row
          classes={{ cell: classes.cell, cell2: classes.cell2, cell3: classes.cell3, cell4: classes.cell4 }}
          text={{
            text: <div className={classes.text}>Action</div>,
            text2: <div className={classes.text2}>Protocol</div>,
            text3: <div className={classes.text3}>Amount</div>,
            text4: <div className={classes.text4}>Yield</div>,
          }}
        />
        <div className={classes.frame45}>
          <Row
            className={classes.Row}
            swap={{
              cell: (
                <Cell_TypeDefault
                  className={classes.cell5}
                  classes={{ content: classes.content }}
                  text={{
                    text: <div className={classes.text5}>1) Supplies your STRK to Nostra</div>,
                  }}
                />
              ),
              cell2: (
                <Cell_TypeDefault
                  className={classes.cell6}
                  text={{
                    text: <div className={classes.text6}> STRK on Nostra</div>,
                  }}
                />
              ),
              cell3: (
                <Cell_TypeDefault
                  className={classes.cell7}
                  text={{
                    text: <div className={classes.text7}>$1,000</div>,
                  }}
                />
              ),
              cell4: (
                <Cell_TypeDefault
                  className={classes.cell8}
                  text={{
                    text: <div className={classes.text8}>15.63%</div>,
                  }}
                />
              ),
            }}
          />
        </div>
        <Row
          swap={{
            cell: (
              <Cell_TypeDefault
                className={classes.cell9}
                text={{
                  text: <div className={classes.text9}>2) Re-invest your STRK Rewards every 2 weeks</div>,
                }}
              />
            ),
            cell2: (
              <Cell_TypeDefault
                className={classes.cell10}
                text={{
                  text: <div className={classes.text10}> STRK on Nostra</div>,
                }}
              />
            ),
            cell3: (
              <Cell_TypeDefault
                className={classes.cell11}
                text={{
                  text: <div className={classes.text11}>$1,000</div>,
                }}
              />
            ),
            cell4: (
              <Cell_TypeDefault
                className={classes.cell12}
                text={{
                  text: <div className={classes.text12}>1.23%</div>,
                }}
              />
            ),
          }}
        />
      </div>
      <div className={classes.hyperStark}>HyperStark</div>
      <div className={classes.getStarted2}>Get Started !</div>
      <div className={classes.image50}></div>
      <div className={classes.frame40}>
        <div className={classes.frame36}>
          <div className={classes.buttonAccuRew}>
            <ButtonAccuRewIcon className={classes.icon8} />
          </div>
          <div className={classes.sTRK}>STRK</div>
          <div className={classes.image47}></div>
          <button className={classes.buttonDay}>
            <div className={classes.day}>Day</div>
          </button>
          <button className={classes.buttonWeek}>
            <div className={classes.week}>Week</div>
          </button>
          <button className={classes.buttonMonth}>
            <div className={classes.month}>Month</div>
          </button>
          <button className={classes.buttonYear}>
            <div className={classes.year}>Year</div>
          </button>
          <div className={classes.total}>Total</div>
        </div>
        <div className={classes.hyperStarkVault}>HyperStark Vault</div>
        <div className={classes.deposit}>Deposit</div>
        <div className={classes.withdraw}>Withdraw</div>
        <div className={classes.rectangle3418}></div>
        <div className={classes.balance}>Balance: 0</div>
        <div className={classes.insufficientBalance}>Insufficient balance</div>
        <div className={classes.transactionCost}>Transaction Cost</div>
        <div className={classes.nA}>N/A</div>
        <div className={classes.rectangle3417}></div>
        <button className={classes.buttonWithdraw}>
          <div className={classes.enterAmount}>Enter amount</div>
        </button>
        <button className={classes.buttonDeposit}>
          <div className={classes.enterAmount2}>Enter amount</div>
        </button>
        <div className={classes.balance2}>Balance: 0</div>
        <div className={classes.insufficientBalance2}>Insufficient balance</div>
        <div className={classes.transactionCost2}>Transaction Cost</div>
        <div className={classes.nA2}>N/A</div>
        <div className={classes.totalAccumulatedYearn}>Total Accumulated Yearn</div>
        <div className={classes.calculateApproximateYearn}>Calculate Approximate Yearn</div>
        <button className={classes.buttonApprxRew}>
          <div className={classes.rectangle3419}>
            <Rectangle3419Icon className={classes.icon9} />
          </div>
          <div className={classes.sTRK2}>STRK</div>
          <div className={classes.image472}></div>
          <div className={classes.buttonDay2}>
            <div className={classes.day2}>Day</div>
          </div>
          <div className={classes.buttonWeek2}>
            <div className={classes.week2}>Week</div>
          </div>
          <div className={classes.buttonMonth2}>
            <div className={classes.month2}>Month</div>
          </div>
          <div className={classes.buttonYear2}>
            <div className={classes.year2}>Year</div>
          </div>
          <div className={classes.total2}>Total</div>
        </button>
        <div className={classes.harvesting}>
          <div className={classes.textBlock5}>Harvesting</div>
          <div className={classes.textBlock6}>
            <p></p>
          </div>
        </div>
        <button className={classes.buttonApr}>
          <div className={classes.aPR143}>APR: 14.03%</div>
        </button>
        <button className={classes.buttonETH}>
          <div className={classes.image30}></div>
          <div className={classes.eTHMainet}>ETH Mainet</div>
        </button>
        <button className={classes.buttonContract}>
          <div className={classes.contract}>Contract</div>
          <div className={classes.group}>
            <GroupIcon className={classes.icon10} />
          </div>
        </button>
        <div className={classes.sTRK3}>STRK</div>
        <div className={classes.image492}></div>
      </div>
      <div className={classes.sTRK4}>STRK</div>
      <div className={classes.image473}></div>
    </div>
  );
});
