Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF52BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jan 2022 21:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A5C910E38A;
	Wed,  5 Jan 2022 21:26:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C21BC10E38A
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jan 2022 21:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwgchxB/I02T1JKwqVRetfJqtO0G5zFwwawQDP+TeObXqG+acw09QhgiSDohDCBa7iHqaijxoCnsEJjUX+Q1CjCwQP1ZzY+KJa0tL8W7cWjdN2IhP5K87br04VOFLRjBGa57Bz+bccLpIP7cT1hCgMAMDT2keBS0I1EgvIvDOF373ON5dmHbvtaYEOGmshFfcxbRfOJXCU/YdZvHOzSMLQBNCA3W9x4i4f9O9CtDBsJeigMquIlzpc7VbQvhCMDQFcbdguXg/SN9r7aHEUfN0vsx5OGTC/Tb+fvlYJHRgYzgev/lG6KyLeTBk90jZ/xBrswHfzEZNoUgoULscy9A7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGwE3CTnCSUvc2spvs5GFB/dYd1qrXTCKSHb9yPq38o=;
 b=MHJGjY8ELTH0jbpnn3HSReQRM8zBQn7TssHvlfvQA+ZEQmb2t3OPN0i3jp0ekreB8+hOwFbnjAwncl8Bohjg8wumVOPSPFWM91O5xcdgt4it2iJVUB7VRgoRM87XicDVGaSOnVqnUmypMSwN9eU8uGmKwTs7JGYDWeb5op8CfJK8wHydmD0EAAZxiwwC3kQXqT3Z6pqy5Fc6ST5NJq+2aIFnfH52bA5qjW9c3VOZrV9clJr6zl4HBq6s/hUvHD62aIpf6RU9vkwW2dCYNIoPhuMzjRHnNFFhmYyoiNs3g0koE9vAZWzsTTUq2AiHJOzvTmVcE2ttNH3+I6HWfQ2iIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGwE3CTnCSUvc2spvs5GFB/dYd1qrXTCKSHb9yPq38o=;
 b=vOFQTX1WM92Kru9BqwjPnAtWBcCCb6GVK0QQ3qu5qF7ojSGIoDxDP4xTykVqqILQEdKFL+n1wZhwskmfNFibWhDweQ/JYubPMq2CzmqIcSngpDnS47XRGQel3pZk2hLXnZFrFHvlmtyuuc1Mlg6D++UCnvgTRJ2N30eEtBj1bWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5490.namprd12.prod.outlook.com (2603:10b6:303:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 21:26:20 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52%9]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 21:26:20 +0000
Message-ID: <bbec68c3-a8f0-2fba-53ba-73f0c4f55d89@amd.com>
Date: Wed, 5 Jan 2022 16:26:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2] drm/amd/display: explicitly update clocks when DC is
 set to D3 in s0i3
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220105170656.2121-1-mario.limonciello@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220105170656.2121-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::23) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7db73b4b-0283-4518-1a77-08d9d09203cd
X-MS-TrafficTypeDiagnostic: CO6PR12MB5490:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5490BEAD36A105E2BA19AC618C4B9@CO6PR12MB5490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zh/WEOEnYYmCoSE5xGbRxxhrbOKyYU8zVACoVVbRzvyZIT/MQgnDn28W9ok6eRnzdNs3UiP8rm/sungq8b/KLW05Zoq/oweGpTVWjKObIsg53e5Q4fcLdgutJF/NklVjlUodr63o3eFhNJ3T224vJRDXZTfJVGjv/3QA0n0fUrgbWVLd4V6sXhwFHclmBZdFFlCmK8/f/A4Ha/ADHLotZjnt1PyYfzqzyiwBvCd7NPcFXkh3Sw77g7GCVnIBEhB763WTLZBFWIj1q/TMEYDHSGZ8MfM2haQIsvA55AGnskhDZgvK3kL7Efnp9JPuAIQNccZD/QHvhDnMX2jzuJDTO/Tq67rSlZ10Cg9On3/byANXixv1qO0jscFHvCydjyi5txjqhGsKazZg4tTvK6KN94/cRMtSPvFUGvHSJ1WwseyQ5Cz2kNfChqRis7ypIiAhYNlQ2nOigSSNyQHJWG/EiFPmJUBW4TyZiUq33oaGWjAdSYomJjgFa2kmtl91OOUpQzBj1hr9rzh30Qtp0+OnDjLO46MuyMdzslQbO9wyDp1eqf7FOx8gcMlatr64pBJ/x45bIaIJiv6BsXXlAQznJZTpPCrWX05ZS60IBUUU0d9sYYmAbkNOdjAH6ZNLDBzfPqZQkco01dDKSTlsviUXAKfFfQpPXloEwNc4mqM7ODL5MaJ7tIvFfXC0bdgmY6pNHC1Xy6juebCkL2Pqi06C1ZkC6DbJPyIOy8Yeym5WFgOcta0jaYgtiEZGQ/qV83yocrjnIzfE4vZY4p755unxI6k6krYK14qmKvoSSECE6DF0o7nnFTvCr05gUtd+sVRN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(15650500001)(31696002)(54906003)(316002)(6506007)(36756003)(66556008)(6512007)(5660300002)(86362001)(44832011)(2616005)(31686004)(66476007)(6486002)(2906002)(38100700002)(83380400001)(186003)(508600001)(966005)(4326008)(66946007)(8676002)(26005)(6666004)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RElwM0ZROG5GeCtNVVpKUzJnZHFwdUpQZWxWbi9jZXpzMy9wbTZmUmY2QlpO?=
 =?utf-8?B?NW9wQ2lPYXNrWEVhMThXUU54YzVOSzhaTG1rdjNMaWJsajZ3d1hMUGNHM2Qx?=
 =?utf-8?B?M2luN3RUeTNhaXFnVUZKR0JRZFJBcVdqcWhzSDhqaDdyNGdHbDh1bmtMeFZB?=
 =?utf-8?B?NmVOdmcraVJZY2pGenlnd1Q2VUpyYVlxTHg4R3UwMjYrTExlVlRzcHBadHF1?=
 =?utf-8?B?QVJHMTkvNlFydVdqcXdxK0dqeG1qM2gxbGFubmx6aThiVWtVVTh5bXZvbTg3?=
 =?utf-8?B?WDgrdG9kWk1OZ2pCSnFGeElxT21RSEdJd2JMem53bnkzV0t5ZG9hOVdMcFpr?=
 =?utf-8?B?cTVPVEl3NUhaSXFrT3VieURuV1hJanZtY3JyVDJIUzYzREJQWjIwZXdhRm4w?=
 =?utf-8?B?WlgyVjFKMnc4Yy94UWpsOVZ4OVl4b3lSQTJXbWhuMFk1S2diSEV3TE90czFW?=
 =?utf-8?B?MzhQZG9KZ080UnFYZTB5MEJzaXExck1ubW5OcVZ4R0lDOUN5ajhjd1hlRVVD?=
 =?utf-8?B?aW93QklGK2pvbC9PdzZObzFXbnRSZWhIVHNzbmpxNGNEZURJbTQ0U3FjRmIy?=
 =?utf-8?B?Z2hYbS9GNlFrUVZTcjFKcnV6dUNQQlBYNExFUTBTOHdzakJsVzhrUzZNMjJ3?=
 =?utf-8?B?OXBVeVNNQ0NWNHJNYnFUL0JBbkFVMDUzYWUrWmM1QTdZVHNISVhVZTREN2tH?=
 =?utf-8?B?MTVjdmlWMW1zdWhiNFU0bTVJcXVBUWV4QzZBRGxDNXlBMi9wVm81cGRFUlBu?=
 =?utf-8?B?WU1ubFYvMjV2TUNJZExiR3U0VE5tSHJyRjJsdjBUZzhBdDJpSzM4eVA0ZnBn?=
 =?utf-8?B?T2crTk0vL0JkSTM0N0ZVOFFXV0lteGhFRGp4SzA1SzJXeURYR2NheUNhUXlR?=
 =?utf-8?B?WWlIMUsrWmNSblZwdk1MbFFVeUxzQm45TDgrMVM1eHE1T3pvUVhLS0NiU29Q?=
 =?utf-8?B?VHZ2SER6Q1BZSVhaT3VXaEVsTVEvOHNuYmdBZnBQTUxPMEdtM1AwOU82NUN5?=
 =?utf-8?B?dmErQ1cxem9QcmNUdExsNDFzT3k5UzFRM1hFNUhOODVMVkhBMjBLNHNQT2VD?=
 =?utf-8?B?SGJzZThTUmRxOVYwemk1RXBiQU8wOVdxd0ljQ0ZVQXRQSURyYmxEWUNnU0N2?=
 =?utf-8?B?cFRNRFcxRWdDaTAxVXprS0R3Z2xpTjlqY0d1ZkRsZVJCVzVpeWR4M2Z3NkN2?=
 =?utf-8?B?TjQ4WktmQkhEMjVFcjN5bHM2ZjFidHVoejF4ZUNQZUp4czhiWmpBY0UxYjFF?=
 =?utf-8?B?ODJqZXI5V292RWVpTitLNE9xZ09CQ1g3QnQ2Vm14WHdXT0dqZGEzZTZQMHFj?=
 =?utf-8?B?a3hGR0duL2NST3dQd2ZpeDAvUVp5VXN4Q013UUlUVkR0U25BZlNnRWllQnFM?=
 =?utf-8?B?TDNLeE16TTlETFN3ZXRZQUtvbnFSOUk4NW51czdLN2JlcWxaeG96SSt4OCtk?=
 =?utf-8?B?ZDVvZVZ1bVJhaklSNEI3Y3N5dXdtSmdZY3NMRXM3ZjdYLzYzT3N0ajJNK2hu?=
 =?utf-8?B?dEh5b0NqZitJdWR6NlRWeUo2R2hlWmF5MVh2RHNWR3dyWm1lT1NDUHFKOEpy?=
 =?utf-8?B?bzNEK1Awc3NRWmI0R3J0c21RNFd3L0VkNDJTakwxWFNTU3FFZS95WUk5UWFG?=
 =?utf-8?B?TEtaYVh6MFJBV0VjUVcrTWwwZkdvbHZqTWxaVVYwamIzb3BwSGFrUzg1ekIr?=
 =?utf-8?B?S3gwV2ZXdFlsRExGd1pPOFZKd0VzODE2YjFZSGZDNTFSZmxpb2ZHTU9IWEl1?=
 =?utf-8?B?TGhvTVJvVlhVeHM4MGRRbjNNT0M2QzNsMk5DeVVRVktmYzRxemFHZm5YalBa?=
 =?utf-8?B?QW5vNytKOFl0cXN1ekNBR0JnTUY3dm1CRm03bXlNa2htZFBiMUhDYjRQdXJR?=
 =?utf-8?B?eUJRV3I3RlJIOWNYbkYzQng0Zkl3S1dXVk5OVVpRcHFWdkxmQStYdjlOeDUy?=
 =?utf-8?B?SlNuQ0s2bjBGaTZCanlvZHFDU1BFc09IWlAzWklJaENOVUtRQWMyOGEycDNr?=
 =?utf-8?B?THh3cC9zaDFxejFuU3JsdWp4bVhWTFJMZVQ5V2lvdnV5MGZWR3lGM3ArUEFW?=
 =?utf-8?B?R1BYYWF4aWZ2bWdDRTNEaTBDeE1iUkdjbTFhVUhoVDkvdWJkQ2FYQ0pFZjVT?=
 =?utf-8?B?Z2FoVkhrRmQzQmd2OEl1SDhyVWVIa1g4YnlpaFkyTHMwWVh4R0VQcUhIRXRl?=
 =?utf-8?Q?FJLqsOZLdFbRH+MHZ3cQ6vA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db73b4b-0283-4518-1a77-08d9d09203cd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 21:26:20.0192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Z4wwdW5os32mCRm+VW7CG3INpeTQUFOwjKQ/4Bo7gwNiA10LZFrRupD1Hu5jgnzGZIRp9zw7vYV7tE6I+opXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5490
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
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>, Scott Bruce <smbruce@gmail.com>,
 spasswolf@web.de, Chris Hixon <linux-kernel-bugs@hixontech.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-01-05 12:06, Mario Limonciello wrote:
> The WA from commit 5965280abd30 ("drm/amd/display: Apply w/a for
> hard hang on HPD") causes a regression in s0ix where the system will
> fail to resume properly.  This may be because an HPD was active the last
> time clocks were updated but clocks didn't get updated again during s0ix.
> 
> So add an extra call to update clocks as part of the suspend routine:
> dm_suspend->dc_set_power_state->clk_mgr_optimize_pwr_state
> 
> In case HPD is set during this time, also check if the call happened during
> suspend to allow overriding the WA.
> 
> Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
> Reported-by: Scott Bruce <smbruce@gmail.com>
> Reported-by: Chris Hixon <linux-kernel-bugs@hixontech.com>
> Reported-by: spasswolf@web.de
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215436
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1821
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1852
> Fixes: 5965280abd30 ("drm/amd/display: Apply w/a for hard hang on HPD")
> Fixes: 1bd3bc745e7f ("drm/amd/display: Extend w/a for hard hang on HPD to dcn20")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> changes from v1->v2:
>  * Add fallthrough statement
>  * Extend case to check if call was explicitly in s0ix since #1852 showed hpd_state
>    can be set at this time too
>  * Adjust commit message and title
>  * Add extra commit and bug fixed to metadata
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 5 ++++-
>  drivers/gpu/drm/amd/display/dc/core/dc.c                  | 3 +++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> index fbda42313bfe..fa5efe10b779 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> @@ -23,6 +23,8 @@
>   *
>   */
>  
> +#include "amdgpu.h"
> +
>  #include "dccg.h"
>  #include "clk_mgr_internal.h"
>  
> @@ -126,6 +128,7 @@ static void rn_update_clocks(struct clk_mgr *clk_mgr_base,
>  			bool safe_to_lower)
>  {
>  	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
> +	struct amdgpu_device *adev = clk_mgr_base->ctx->driver_context;

DC code is shared on other OSes. driver_context won't be an instance
of amdgpu_device in those cases.

If we need adev->in_s0ix we need to find a way to plumb it through
DC structs and interfaces.

Harry

>  	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
>  	struct dc *dc = clk_mgr_base->ctx->dc;
>  	int display_count;
> @@ -157,7 +160,7 @@ static void rn_update_clocks(struct clk_mgr *clk_mgr_base,
>  			}
>  
>  			/* if we can go lower, go lower */
> -			if (display_count == 0 && !hpd_state) {
> +			if (display_count == 0 && (adev->in_s0ix || !hpd_state)) {
>  				rn_vbios_smu_set_dcn_low_power_state(clk_mgr, DCN_PWR_STATE_LOW_POWER);
>  				/* update power state */
>  				clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 91c4874473d6..8e0c820f6892 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3299,6 +3299,9 @@ void dc_set_power_state(
>  		}
>  
>  		break;
> +	case DC_ACPI_CM_POWER_STATE_D3:
> +		clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
> +		fallthrough;
>  	default:
>  		ASSERT(dc->current_state->stream_count == 0);
>  		/* Zero out the current context so that on resume we start with

