import { memo, SVGProps } from 'react';

const GroupIcon = (props: SVGProps<SVGSVGElement>) => (
  <svg preserveAspectRatio='none' viewBox='0 0 30 30' fill='none' xmlns='http://www.w3.org/2000/svg' {...props}>
    <path
      d='M17.5732 12.427C16.2081 11.0624 14.3569 10.2959 12.4268 10.2959C10.4966 10.2959 8.64539 11.0624 7.28026 12.427L2.13209 17.5735C0.766936 18.9387 0 20.7902 0 22.7208C0 24.6515 0.766936 26.503 2.13209 27.8682C3.49725 29.2333 5.3488 30.0003 7.27942 30.0003C9.21005 30.0003 11.0616 29.2333 12.4268 27.8682L15 25.2949'
      stroke='#898989'
      strokeWidth={2}
      strokeLinecap='round'
      strokeLinejoin='round'
    />
    <path
      d='M12.4277 17.5732C13.7929 18.9378 15.644 19.7044 17.5742 19.7044C19.5044 19.7044 21.3556 18.9378 22.7207 17.5732L27.8689 12.4268C29.234 11.0616 30.001 9.21004 30.001 7.27942C30.001 5.3488 29.234 3.49725 27.8689 2.13209C26.5037 0.766936 24.6522 0 22.7216 0C20.7909 0 18.9394 0.766936 17.5742 2.13209L15.001 4.70534'
      stroke='#898989'
      strokeWidth={2}
      strokeLinecap='round'
      strokeLinejoin='round'
    />
  </svg>
);

const Memo = memo(GroupIcon);
export { Memo as GroupIcon };
