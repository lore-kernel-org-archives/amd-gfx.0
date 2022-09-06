Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA098ECAAD5
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 15:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61A8C10E6FA;
	Tue,  6 Sep 2022 15:57:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 310AC10E04D
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 15:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7IYSSzpz12pcdWpGxatdoJ4rYx6TgpmFg/gvP+1hhYVcuc9DMlPODCHjLS5P1aLk5DrBrk/24dMD7giv4KHqUYweezm2Uhb7cyWXrpbz8mtkSfPiGvhE+1jYmaPP7EhxZSSKhyv8FIqnZ5zReSUvMQYLkRv/40/kXFODv54F9kucaVZx6t7QbxzEEi8SaVQezYk68aWZ4UXbO55AQJOqVRNJGyxsY4id5Fs6IxLbaE6XmviWivwswImIvua3sURwzEp7EUqMbA7rarnQxcArBkQPKrumS6PexqSursK5MyaWro4F2jZAVXJ2CQEntKKimBKuiklZ4/d/jCZn6n3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEcnZcspbiaaIs7ny95wTybzbD9YHYiZt/KSjVa12uE=;
 b=PhIxeAidm5zW82CV9jQ/rKf47Z+XbcW8VW+cs1HlRfo4zjSWBlfiT7uNQxkv7BUNzE6LT63liJBOi05UkHp2rmwuR4RLmEcWChq1zgV1yy9bgmHULwNOh4FDlVegdkN6ndUrbz22VILkDaeJ3stAfv/Z1QJa53faOQXl/MEIEgnkWn5plKYjly5N8vMp/9Mx5OFGRzA4gIi+jN4SdV8LKCSdgrLdLP/aFRgxIhJgRl5nd/fySs/5zbO2XON8zev/3HP2lQlc+reIBt2fCTFd6RQj92yfUbZt1n/ACsbwzkBZhLlmTbMEny+Y+rDVuGm5N4BEbail9pQ5gfqtgHbpyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEcnZcspbiaaIs7ny95wTybzbD9YHYiZt/KSjVa12uE=;
 b=FLzcbq4DGLck1wYuJQyt2Q/RNYipeLBq7Gr+qFWDbry3EvpYg8IARH8XEw87ONJlGgrlE+mZBaI63ZkRZQMkRZPSNdjSg5qNXNTwIkEsuOE0u2Efo1S6BCo1jc3xIH9CowcpYDbNFEe/aqH65Ikaea6ibGWZ9pNZCr//51pljJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 15:56:58 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588c:ac12:d318:bfee]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588c:ac12:d318:bfee%7]) with mapi id 15.20.5588.015; Tue, 6 Sep 2022
 15:56:58 +0000
Message-ID: <80e61ba2-e888-9ecd-d32b-5abff09a5d02@amd.com>
Date: Tue, 6 Sep 2022 11:56:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] drm/amd/display: Fix register definitions for DCN32/321
Content-Language: en-US
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220901192736.1171423-1-aurabindo.pillai@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220901192736.1171423-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::35) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 608f89db-e882-4ae5-a6e3-08da90206cef
X-MS-TrafficTypeDiagnostic: DS7PR12MB6333:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8SQvux/SAhr4jZR5EXll2JhZCilcB3P/YdYQ4LZBicq4/BuT4cO2EDsSjAtTwPqvys5zG7foYuf6dt9UifWpjfbEQOw8uLvAU61vwHfbBo7W/SEJd5gxLuC+V4Wno3RK6PI+rilOeiO9N0IBVm157xPYYX0n+ohDCIm5C/sDLY/g5mR9+atu9EebyC8zYseqxkKxU7pxaYtVrfNsZP6NvrY3uJnaLCCBVBsqNzvhFokTqW18T6jH8/511NrQjGungT3ryI6vW8jYXBJcEfsm/YGxT5TK7ycUHJS3d9QJtIgOtejw9JujHwdB92cI7DiopXRkLJHdO3Kn7ufhztZKy+MF95l6/sSVYQZUYU89QYSem8K3gt1IYWcjxlSZs6dPemcW1gPrVu/ghTuk81DRQApZ7knOWHW+clo5F0YKSnMCX2VmWPqw7c0IK6Uj+5pLk2OmPXqrU5Y1NLsUhqPr/0oiuJtvVG/RsgRQ7TGyQGh45qsTxVAcESlzOH+Pfm9KUoqlef+FuCgQdykz858ry8GuvsMLzPqowvxz9vwFY8mL1OJQeec6FeLv9ZWKkawuGZ3klCTQjbb/JUAYVGKLs5/cu0fmqr8xBoMvhKzKN+r0GE0osQgI46Fz9i9uMwGFIfs0spzBbOKQutYbm+zBKhMGNJlhE9qPDkTpjlv/CF6XsFV/OLt5kPFVhl5rAS5T9LNI3ECpsLAv6tg0FhAHvSTEui2CGlr9D6Ic0hdfUN50ReQLDbyikxvId8NB0kPuoGjXy9Lx1DujSxE3NO9fd+E8/kP2fOSFMMS0iZ1S74=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(6512007)(6666004)(186003)(38100700002)(31686004)(36756003)(53546011)(30864003)(41300700001)(86362001)(6486002)(316002)(26005)(31696002)(66946007)(5660300002)(6506007)(478600001)(66476007)(2616005)(66556008)(2906002)(4326008)(8936002)(8676002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWJGNU0xVVRvTzUzb3VsZU1DU044NlY1N1J5cUJtNGJEME1FTzY4N05DbE91?=
 =?utf-8?B?bDJEQmlCK1VCZlFjT3ZCd0k2eFhaa2lsMXU0NS9iV0d6Wkh3ZGV0L0NSRTh5?=
 =?utf-8?B?SUtYQy9JanZDNkpza0xPTFpKYmdrUnFPY0FmekgrSitVLzNlWVlZbkhyc1RX?=
 =?utf-8?B?aHdSOEprUjBMcTJsdWdqSy9QbUM4b1ZKMzU3RVFhdXpNL0VOdVhDT1B4d0Ny?=
 =?utf-8?B?c2pUc3l0OWxnQndZNm15RVdWN2RpUjdyc0lGczhabzVkLzlhV1ZxdVlYTVVU?=
 =?utf-8?B?aVM3bEJ4U29aNThhbms3anlBaFhZYkVpbTI4V29uT0pMbUlod0pHNzBTSFZn?=
 =?utf-8?B?a1k3Yk5PY3NQNHR3NStBZUwrYTRSYzJOWkNLMG44TG52UEVvdjBoUFM0QTF1?=
 =?utf-8?B?UlYxQVFrcmYxZ0RjZTZQZjNjVHkxMHRPNUpPZHh2Ry8zZVpkWklVaFl6U3d5?=
 =?utf-8?B?RDg0VlVqUlg0NlFMVGlqS3RDWU5lczBEblJxcVJXQkVOdkZRcWlUVXhCMk1n?=
 =?utf-8?B?ZDZMclZ2Y1duNTdEN2ZRU0I1MFFFWEVxa0pBVFJqS21TQXZtK3ZWTGpNSFFU?=
 =?utf-8?B?VCtZK0F2bWl6Sk5LVjRqODZDVXZpMTd5SVVDa0EyVVNpdkk2b0JLQnR6Tk1C?=
 =?utf-8?B?azZEVEFnTll2T3pwVzZPSDNkNVdMWnRzb1NSbGh4cFUzRUgrNzZKQUlPSXJh?=
 =?utf-8?B?aWdTRTVXWVdoUXBBRzArc2NZbmZ1T3phL1lNdmV3Ky9YKzNnVWp1bXdRSXRW?=
 =?utf-8?B?M05XMXJPelh3dHRBNUd3ODBWbU5TOFpsMU9WajFqSytmRmJoVTRaSnAzTzZj?=
 =?utf-8?B?WStTUnJJMzVkV2UrR1FidkU1SVY2VitWVEZ5c2JHUzVWNW5JVlhCSE5yaFAv?=
 =?utf-8?B?SHEwWloyUWIrWE5Vbi9ZWXBsSEkwZ0hYZnErQ2RtQVV3WHowVnpFREJ6ZDMr?=
 =?utf-8?B?UWdhdFhYWkthUWlJOG82dUxMVkQwZzhDTStERkhLTk1XK0ZPZEd1cXp6RmNM?=
 =?utf-8?B?LzgySm5ITWFpQTIrV1hvcWh2ODhsWEZMc1JjZDhjREdXdkxuK2t4WVFVZDFw?=
 =?utf-8?B?VytXa0EzdlEyc0NDd2RFQVQxL2tIYmZVTVo3M1pzTWs5cElyQzVobzhoVUhI?=
 =?utf-8?B?ZE5UbFc5Uk1sVWhYc04veThRY0gxOURBUVVReGhpOG8xV3diYkExZHNtSVlB?=
 =?utf-8?B?Ynk0YlV0THQ0YW5Xbm5KVllZWmxtNDEyejcxQ01aaEd3TVEvcUkvaWJ1a0gv?=
 =?utf-8?B?R1NEa3NqSjNEYzBYVDRtSExNMWZpbk5oWkpxSkd4Qm9KcFMwRTdhK1pFdXNM?=
 =?utf-8?B?Y2ZtSm5meXpDd0FGNHhBSjFKR0JBUnNveUxJWFMrREIyVkMwRVorU0FPdVV2?=
 =?utf-8?B?ZGIxRTFFV2Nib0Yyd3NrKzhmL1JqeHVIdGN5cFppTUhLWDVyN29UZ29oWUVa?=
 =?utf-8?B?bTEzOG9EZi93ME9uZzg0Vk9wSC9laktLdHo1bWpoc0t6bE1aS3haZ2dZTVd5?=
 =?utf-8?B?TUxpUGJaQUVFUE1LZDFKY3pzZjhCUHh6a1FsaFdSbVJZWVl2eGg4WjFERGRH?=
 =?utf-8?B?bExXWnE2UUZxMmQ0aytENGl6NzRZR09WUUlKYktXVkRGakxBTEJiMEF0MFpZ?=
 =?utf-8?B?RmhDY3pxdlVKaHRDMk04MFZBYVdJSldVT1M1VWRCcEh3cWJPYUdNaWk2Z1dS?=
 =?utf-8?B?eWt0dUZoTlJMWklTYUdRNzZPZVVHNk12SUNhd08vWWhieVJpRnkwRWQ1QjJw?=
 =?utf-8?B?a3djQWhuUjFXV3l4L013TmNreEpzY24zUHNORmZJbWJxbWZHSGtDTVkvYjBw?=
 =?utf-8?B?VXY2SWNXMmdjS0R5cC9FVGgyS0ZkYlUxbGxrZkswaVpWaStKWW13bDZZRGp5?=
 =?utf-8?B?cmJRakZUT2hLeUhYUFE5RXFoZC9DejhtVXpFRmZ3VDNjeDdQYU5WNnV5UHVM?=
 =?utf-8?B?YUprZ1VQVlFnNHQ3Q0Q5ZGZVbHVHTnJTUnZKL3FRVkh1RGRYK2dkdzFGSE51?=
 =?utf-8?B?SDg4Q282dUNjeklZWUU2cm5HRXRpd3gwVDROUlo4dTNsRVl0enNsNXQyZWZa?=
 =?utf-8?B?dW9LeWZRVDdqOHNRV0ZPemxLTXNwWHdoNG9BcGQwcmp2RDBXaXZMMXR5R2tY?=
 =?utf-8?Q?j3GKQyuGw3EvrzM8zEvkc7469?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608f89db-e882-4ae5-a6e3-08da90206cef
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 15:56:58.2812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dv7H9zBf54rjDfKECTZ1jp8i4yAHjXuNrGYT5RUuBJWGepZL/xrvrYCY2wruf70VgWPqwnOBJOmNxr2TYLb9Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: alexander.deucher@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-09-01 15:27, Aurabindo Pillai wrote:
> [Why & How]
> Fix the instatiation sequence for MPC registers and add a few other
> missing register definitions that were ommited erroneously when copying
> them over to enable runtime initialization of reigster offsets for
> DCN32/321
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   .../drm/amd/display/dc/dcn32/dcn32_resource.c |  27 +--
>   .../drm/amd/display/dc/dcn32/dcn32_resource.h | 216 ++++++++++++------
>   .../amd/display/dc/dcn321/dcn321_resource.c   |  24 +-
>   3 files changed, 166 insertions(+), 101 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> index ef0a6d468a10..9d3b8568351e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> @@ -461,22 +461,17 @@ static const struct dcn20_dsc_mask dsc_mask = {
>   };
>   
>   static struct dcn30_mpc_registers mpc_regs;
> -#define dcn_mpc_regs_init()\
> -		( \
> -		MPC_REG_LIST_DCN3_0_RI(0),\
> -		MPC_REG_LIST_DCN3_0_RI(1),\
> -		MPC_REG_LIST_DCN3_0_RI(2),\
> -		MPC_REG_LIST_DCN3_0_RI(3),\
> -		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(0),\
> -		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1),\
> -		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2),\
> -		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3),\
> -		MPC_MCM_REG_LIST_DCN32_RI(0),\
> -		MPC_MCM_REG_LIST_DCN32_RI(1),\
> -		MPC_MCM_REG_LIST_DCN32_RI(2),\
> -		MPC_MCM_REG_LIST_DCN32_RI(3),\
> -		MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0)\
> -		)
> +
> +#define dcn_mpc_regs_init() \
> +	MPC_REG_LIST_DCN3_2_RI(0),\
> +	MPC_REG_LIST_DCN3_2_RI(1),\
> +	MPC_REG_LIST_DCN3_2_RI(2),\
> +	MPC_REG_LIST_DCN3_2_RI(3),\
> +	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(0),\
> +	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1),\
> +	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2),\
> +	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3),\
> +	MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0)
>   
>   static const struct dcn30_mpc_shift mpc_shift = {
>   	MPC_COMMON_MASK_SH_LIST_DCN32(__SHIFT)
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
> index 60d8fad16eee..4c931905223d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
> @@ -222,7 +222,8 @@ void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_par
>         SRI_ARR(DP_MSA_TIMING_PARAM4, DP, id),                                   \
>         SRI_ARR(DP_MSE_RATE_CNTL, DP, id), SRI_ARR(DP_MSE_RATE_UPDATE, DP, id),  \
>         SRI_ARR(DP_PIXEL_FORMAT, DP, id), SRI_ARR(DP_SEC_CNTL, DP, id),          \
> -      SRI_ARR(DP_SEC_CNTL2, DP, id), SRI_ARR(DP_SEC_CNTL6, DP, id),            \
> +      SRI_ARR(DP_SEC_CNTL1, DP, id), SRI_ARR(DP_SEC_CNTL2, DP, id),            \
> +      SRI_ARR(DP_SEC_CNTL5, DP, id), SRI_ARR(DP_SEC_CNTL6, DP, id),            \
>         SRI_ARR(DP_STEER_FIFO, DP, id), SRI_ARR(DP_VID_M, DP, id),               \
>         SRI_ARR(DP_VID_N, DP, id), SRI_ARR(DP_VID_STREAM_CNTL, DP, id),          \
>         SRI_ARR(DP_VID_TIMING, DP, id), SRI_ARR(DP_SEC_AUD_N, DP, id),           \
> @@ -735,75 +736,6 @@ void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_par
>   #define MPC_DWB_MUX_REG_LIST_DCN3_0_RI(inst)                                   \
>     SRII_DWB(DWB_MUX, MUX, MPC_DWB, inst)
>   
> -#define MPC_MCM_REG_LIST_DCN32_RI(inst)                                        \
> -  ( \
> -  SRII(MPCC_MCM_SHAPER_CONTROL, MPCC_MCM, inst),                               \
> -      SRII(MPCC_MCM_SHAPER_OFFSET_R, MPCC_MCM, inst),                          \
> -      SRII(MPCC_MCM_SHAPER_OFFSET_G, MPCC_MCM, inst),                          \
> -      SRII(MPCC_MCM_SHAPER_OFFSET_B, MPCC_MCM, inst),                          \
> -      SRII(MPCC_MCM_SHAPER_SCALE_R, MPCC_MCM, inst),                           \
> -      SRII(MPCC_MCM_SHAPER_SCALE_G_B, MPCC_MCM, inst),                         \
> -      SRII(MPCC_MCM_SHAPER_LUT_INDEX, MPCC_MCM, inst),                         \
> -      SRII(MPCC_MCM_SHAPER_LUT_DATA, MPCC_MCM, inst),                          \
> -      SRII(MPCC_MCM_SHAPER_LUT_WRITE_EN_MASK, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_B, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_G, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_R, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_B, MPCC_MCM, inst),                   \
> -      SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_G, MPCC_MCM, inst),                   \
> -      SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_R, MPCC_MCM, inst),                   \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_0_1, MPCC_MCM, inst),                   \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_2_3, MPCC_MCM, inst),                   \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_4_5, MPCC_MCM, inst),                   \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_6_7, MPCC_MCM, inst),                   \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_8_9, MPCC_MCM, inst),                   \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_10_11, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_12_13, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_14_15, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_16_17, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_18_19, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_20_21, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_22_23, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_24_25, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_26_27, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_28_29, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_30_31, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_32_33, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_B, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_G, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_R, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_B, MPCC_MCM, inst),                   \
> -      SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_G, MPCC_MCM, inst),                   \
> -      SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_R, MPCC_MCM, inst),                   \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_0_1, MPCC_MCM, inst),                   \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_2_3, MPCC_MCM, inst),                   \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_4_5, MPCC_MCM, inst),                   \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_6_7, MPCC_MCM, inst),                   \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_8_9, MPCC_MCM, inst),                   \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_10_11, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_12_13, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_14_15, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_16_17, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_18_19, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_20_21, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_22_23, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_24_25, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_26_27, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_28_29, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_30_31, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_32_33, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_3DLUT_MODE, MPCC_MCM, inst),                               \
> -      SRII(MPCC_MCM_3DLUT_INDEX, MPCC_MCM, inst),                              \
> -      SRII(MPCC_MCM_3DLUT_DATA, MPCC_MCM, inst),                               \
> -      SRII(MPCC_MCM_3DLUT_DATA_30BIT, MPCC_MCM, inst),                         \
> -      SRII(MPCC_MCM_3DLUT_READ_WRITE_CONTROL, MPCC_MCM, inst),                 \
> -      SRII(MPCC_MCM_3DLUT_OUT_NORM_FACTOR, MPCC_MCM, inst),                    \
> -      SRII(MPCC_MCM_3DLUT_OUT_OFFSET_R, MPCC_MCM, inst),                       \
> -      SRII(MPCC_MCM_3DLUT_OUT_OFFSET_G, MPCC_MCM, inst),                       \
> -      SRII(MPCC_MCM_3DLUT_OUT_OFFSET_B, MPCC_MCM, inst),                       \
> -      SRII(MPCC_MCM_MEM_PWR_CTRL, MPCC_MCM, inst)                              \
> -  )
> -
>   #define MPC_OUT_MUX_COMMON_REG_LIST_DCN1_0_RI(inst)                            \
>     ( \
>     SRII(MUX, MPC_OUT, inst), VUPDATE_SRII(CUR, VUPDATE_LOCK_SET, inst)          \
> @@ -887,6 +819,149 @@ void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_par
>         SRII(MPCC_OGAM_LUT_CONTROL, MPCC_OGAM, inst)                             \
>     )
>   
> +#define MPC_REG_LIST_DCN3_2_RI(inst) \
> +	MPC_REG_LIST_DCN3_0_RI(inst),\
> +	SRII(MPCC_MOVABLE_CM_LOCATION_CONTROL, MPCC, inst),\
> +	SRII(MPCC_MCM_SHAPER_CONTROL, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_OFFSET_R, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_OFFSET_G, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_OFFSET_B, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_SCALE_R, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_SCALE_G_B, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_LUT_INDEX, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_LUT_DATA, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_LUT_WRITE_EN_MASK, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_B, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_G, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_R, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_B, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_G, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_R, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_REGION_0_1, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_REGION_2_3, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_REGION_4_5, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_REGION_6_7, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_REGION_8_9, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_REGION_10_11, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_REGION_12_13, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_REGION_14_15, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_REGION_16_17, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_REGION_18_19, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_REGION_20_21, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_REGION_22_23, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_REGION_24_25, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_REGION_26_27, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_REGION_28_29, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_REGION_30_31, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMA_REGION_32_33, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_B, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_G, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_R, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_B, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_G, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_R, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_REGION_0_1, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_REGION_2_3, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_REGION_4_5, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_REGION_6_7, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_REGION_8_9, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_REGION_10_11, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_REGION_12_13, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_REGION_14_15, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_REGION_16_17, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_REGION_18_19, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_REGION_20_21, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_REGION_22_23, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_REGION_24_25, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_REGION_26_27, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_REGION_28_29, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_REGION_30_31, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_SHAPER_RAMB_REGION_32_33, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_3DLUT_MODE, MPCC_MCM, inst), /*TODO: may need to add other 3DLUT regs*/\
> +	SRII(MPCC_MCM_3DLUT_INDEX, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_3DLUT_DATA, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_3DLUT_DATA_30BIT, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_3DLUT_READ_WRITE_CONTROL, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_3DLUT_OUT_NORM_FACTOR, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_3DLUT_OUT_OFFSET_R, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_3DLUT_OUT_OFFSET_G, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_3DLUT_OUT_OFFSET_B, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_CONTROL, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_LUT_INDEX, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_LUT_DATA, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_LUT_CONTROL, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_START_CNTL_B, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_START_CNTL_G, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_START_CNTL_R, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_B, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_G, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_R, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_START_BASE_CNTL_B, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_START_BASE_CNTL_G, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_START_BASE_CNTL_R, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL1_B, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL2_B, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL1_G, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL2_G, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL1_R, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL2_R, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_OFFSET_B, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_OFFSET_G, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_OFFSET_R, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_REGION_0_1, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_REGION_2_3, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_REGION_4_5, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_REGION_6_7, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_REGION_8_9, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_REGION_10_11, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_REGION_12_13, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_REGION_14_15, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_REGION_16_17, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_REGION_18_19, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_REGION_20_21, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_REGION_22_23, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_REGION_24_25, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_REGION_26_27, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_REGION_28_29, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_REGION_30_31, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMA_REGION_32_33, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_START_CNTL_B, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_START_CNTL_G, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_START_CNTL_R, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_B, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_G, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_R, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_START_BASE_CNTL_B, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_START_BASE_CNTL_G, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_START_BASE_CNTL_R, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL1_B, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL2_B, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL1_G, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL2_G, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL1_R, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL2_R, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_OFFSET_B, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_OFFSET_G, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_OFFSET_R, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_REGION_0_1, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_REGION_2_3, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_REGION_4_5, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_REGION_6_7, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_REGION_8_9, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_REGION_10_11, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_REGION_12_13, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_REGION_14_15, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_REGION_16_17, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_REGION_18_19, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_REGION_20_21, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_REGION_22_23, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_REGION_24_25, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_REGION_26_27, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_REGION_28_29, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_REGION_30_31, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_1DLUT_RAMB_REGION_32_33, MPCC_MCM, inst),\
> +	SRII(MPCC_MCM_MEM_PWR_CTRL, MPCC_MCM, inst)
> +
>   /* OPTC */
>   
>   #define OPTC_COMMON_REG_LIST_DCN3_2_RI(inst)                                   \
> @@ -1121,6 +1196,7 @@ void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_par
>         SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D), SR(DCHUBBUB_DET0_CTRL),    \
>         SR(DCHUBBUB_DET1_CTRL), SR(DCHUBBUB_DET2_CTRL), SR(DCHUBBUB_DET3_CTRL),  \
>         SR(DCHUBBUB_COMPBUF_CTRL), SR(COMPBUF_RESERVED_SPACE),                   \
> +      SR(DCHUBBUB_DEBUG_CTRL_0),                                               \
>         SR(DCHUBBUB_ARB_USR_RETRAINING_CNTL),                                    \
>         SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_A),                             \
>         SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_B),                             \
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
> index a93dc00ebfb5..184997a5b464 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
> @@ -466,21 +466,15 @@ static const struct dcn20_dsc_mask dsc_mask = {
>   
>   static struct dcn30_mpc_registers mpc_regs;
>   #define dcn_mpc_regs_init()\
> -		( \
> -		MPC_REG_LIST_DCN3_0_RI(0),\
> -		MPC_REG_LIST_DCN3_0_RI(1),\
> -		MPC_REG_LIST_DCN3_0_RI(2),\
> -		MPC_REG_LIST_DCN3_0_RI(3),\
> -		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(0),\
> -		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1),\
> -		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2),\
> -		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3),\
> -		MPC_MCM_REG_LIST_DCN32_RI(0),\
> -		MPC_MCM_REG_LIST_DCN32_RI(1),\
> -		MPC_MCM_REG_LIST_DCN32_RI(2),\
> -		MPC_MCM_REG_LIST_DCN32_RI(3),\
> -		MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0)\
> -		)
> +	MPC_REG_LIST_DCN3_2_RI(0),\
> +	MPC_REG_LIST_DCN3_2_RI(1),\
> +	MPC_REG_LIST_DCN3_2_RI(2),\
> +	MPC_REG_LIST_DCN3_2_RI(3),\
> +	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(0),\
> +	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1),\
> +	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2),\
> +	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3),\
> +	MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0)
>   
>   static const struct dcn30_mpc_shift mpc_shift = {
>   	MPC_COMMON_MASK_SH_LIST_DCN32(__SHIFT)

LGTM,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

I asked Daniel to run a couple of tests with this patch. Let's wait for 
his result before we merge it.

Thanks
Siqueira
