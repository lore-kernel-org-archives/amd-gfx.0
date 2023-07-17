Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84858C0015E
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 21:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D67DD10E04A;
	Mon, 17 Jul 2023 21:21:51 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E1D310E04A
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 21:21:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNqGyRGcHckuVURJ6WwioipTNFwo9XtMWNfX2ijNs2ON8+0hSVHXY1W40wFkmWbdb9HHYnpMe1GXicevuJC9OtiBGcTp0s1iN6vJvbT9Y7OljaFxSeWxCK0LFveF7eYzGZaM5AH06Ksh1BTYLYbnpHRslyfJvJQoCnjYoBUoOtQSwzQTlA303vxdyOg0fI5KXKyQN3aK/s5rI8YKv3y4P3oI5phby2+xDfmhOhREeNRsKLywMveiE0ulHpsi6Gnf1C8sveKcVeegSXCxfoO0lrwl9sRiVyaeRGCBchmsj6c/Eef5B0O9Y/FAedHcGrLOrfoNAxjz4AGMCdFInSeSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfBDXNisro0zQY/YutVBC3kwYRuzvWP0tJdInGIWsZA=;
 b=d8705AH5kM9rlnpr4OzOJeNKSXA6TzgRtB8urClHHtl86F/k1jBsY0fZLG5+k7pE2BNLbwrOzXQ7eK+29Z4A8ncox5Jd0PuZvC2MFuwna6xezLhjFoymGMHblU+LcoQw/0RzOqExDpyFV8oZayp0v/8cgM9UhOWmrrlMHDy5jxIkQTgflq1Xo6C41eR9CfbwHXL4r3kGNK9K+UTdZkYzQm2Yek7KSYUroqPPWT7DRHNLfoPiKd8KYkqQE/4XTooBZH3jayeS5tHxSg3gKJlNmBfb7aJdXakAWDOmdtI645TZAuvqmWdX7x/wZFU+S4/QQaGVP8WPsgxFMtEVsLj2GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfBDXNisro0zQY/YutVBC3kwYRuzvWP0tJdInGIWsZA=;
 b=mjLr5QojrZlH5n79oy39WIO8qJbMPPAoIPMGiT4gT0NsYm1FgBORP4kF+NACdp7jRvYn2PoA+/NkX85r89+n8X7J3kzZvaB1ffPxqu0LsBqNSIyJsiK358AbztDGiE4mSMHUAcgmURk06vQqaKW5PMAjPzPzPxEammFnMqsfnvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Mon, 17 Jul
 2023 21:21:47 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9fd8:53b3:2a30:5d93]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9fd8:53b3:2a30:5d93%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 21:21:47 +0000
Message-ID: <c01cc5bd-9a8d-db5a-abf4-32cb5899bac6@amd.com>
Date: Mon, 17 Jul 2023 17:25:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amd/display: remove an unused file
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230717210155.1714239-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230717210155.1714239-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0796.namprd03.prod.outlook.com
 (2603:10b6:408:13f::21) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: f98bdd44-2eae-4239-1b44-08db870bd3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GyRnYZLoWwtjpenL950fK11myZsjA3FN7fVa4ifT+B5KXCK6Lr3kQcEsMTZNh7YZlybIbcfNXu6zhX3Iq8IY+5vGRqRLKb23jHAXhTERHvVloF4HYwnnrKOFe37ykF4TCQ7MpNyCDxnwLYxDVdrQOSfvE2JO6N6Rz0Rb4jPq4MBI/wsAIUaDNHt0u/447t+LaAQB+b+SJ+hQQmuyZEqy8LMaEEhSTaB45Qw1az/W/FMM/tlpSU0o6nZSv6tcznOVnKQKfR9EEtwHQuAmzg7Nvdj/kSON91Fyfn6H0QK6JZ66jtzp/eSVaxmvf6CdFzFa11I7HPrZY6i22C+RnsZxx/zgEP2s+waGObikp1/xCyDhCASUtxFFNtg4CXY+RObsRhuY+Ks1OrUpYWNBg57e78bBSoWgs4xV83+aaW4j3k+SrNJmpLWjWNb1CwJ73BeQug9oLThdgL3hH+Lh4YJYOm3DYhd6ToSExuoUSzhzIyUAU3EApTlUtsPZlXwUHzGZLg1JSqawuUdIr9IRZHQA+clGXK03QXl/RKoRwZD/tXN9sCvFjC8/OOuDW8sjIcYrIfyDxnyAD++r8hWTLgkPT9sYnIQOlkPrNkd05DAiKtNBchdb85CGK4VLsF+7f7QniFgKPmz/qrl6YYHvh8Us9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199021)(66556008)(86362001)(66476007)(186003)(66946007)(4326008)(478600001)(66899021)(41300700001)(316002)(6512007)(6486002)(31686004)(6666004)(38100700002)(8676002)(8936002)(26005)(6506007)(2906002)(36756003)(2616005)(83380400001)(31696002)(53546011)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME52RjdYZFAxWHE1RzV6NFlQQ2FDNTFaQTVvQkluVUthbzRrUnJJa3JROWJL?=
 =?utf-8?B?YkhYWkYyVE9WLytOVlV5cU55UzFHSmVXTjFCb3BWYm1lcDZ5aEZsSURDQ1Q5?=
 =?utf-8?B?OG5haWZLTCtpdFduSUZ2NXp6WlJteTJ4a3J2NC96V2JLWDdWMHZ0aFN6bExI?=
 =?utf-8?B?K3kvYmZQK29hajZKRlptY2lIdmlPQUw2dFNrQWZaSzRBdmprY0MyeUtlQnRU?=
 =?utf-8?B?WGE1RzdFb1RTYUNRaUtSOWwrbythR1NxVlhZVTI1bC9kYXZSMFV2RGFmcjlx?=
 =?utf-8?B?MnBBdG4yREhUMFNxMUxVVlVDU25sWVBLQ1JkS0hJUFpuejJUSWEvdzI3QXd0?=
 =?utf-8?B?cng2L3lTNmo1U1M1UGJldmFtaDdLNGZUQVAzK09yUWdScVNPeEFjZ2p5blFj?=
 =?utf-8?B?U3AxZUowa05hTnNlcmdORkNFRVFvNHBIZHJoRUp6ZytoZTFnZlZqK3JmMFZB?=
 =?utf-8?B?cTRMZmRVQlB2NW9JOFlKenN5UWdHRHpMWGtDajIrbkdFYTRtVWFyWWhSOCtQ?=
 =?utf-8?B?YmkwSXh5bHZSS0RoeXJNem13ZGk2bjh1R0NSZHRZMnQvdzUycUs1ZlR6RFJO?=
 =?utf-8?B?Z2ZDT1R1VEhGVjN5Mk14WnVVRFVVWitvR0tvbVJCOGI3SmtiRlZlam5LREVu?=
 =?utf-8?B?cW9kY3BheWlqWVgyYllwOHRwR1JZUWhLWnNNODI4NTRrL29KOW8zSDFvU1k5?=
 =?utf-8?B?Z0NXdjRmcCtabWhUd3MxcVVJdEVCeUEvTGpzbVpkZmdab29POHc3QUcwM2g4?=
 =?utf-8?B?bWdtQjM4NVp2dnZ5UkprR0xVSjBneVh0VFdGN0UrNXFHNW5iRkRCTUNUa3Vr?=
 =?utf-8?B?eENEZWttb0x3ejFzN0xmVUNzaERIMEcySnk1MWdSYW9kQ2lpaDZrM0szdDZw?=
 =?utf-8?B?bmVIWlJwY2JTZElKV2NSK201VzlJblgxQ093L3gwb0lCN0kxSFJKL2gwTGNW?=
 =?utf-8?B?blBRcElqZUVBMU1raWd1c0N6Q1FqWWRiaHFSYmdLcXdHemJ1eFV1OHlEU3Q4?=
 =?utf-8?B?UGhCMm9wOGxYaGNhdkcxS3FwSkd0MHRWUzNEVFYwZW1HYXg2enR4TVptQldm?=
 =?utf-8?B?bjlFT1MzclBTM3JUMDRGUUZINVRpTnVSdzIyT2pQNm5hSWNua1NsbWt4Mk1x?=
 =?utf-8?B?L0IybjR2VFprcjVQelNoT0FoREpSMHRRTHhvMVlwM0lHR0JMV2dISUhPb1RI?=
 =?utf-8?B?NnlkcGhrNXdqWUlEVDlMZjY3Yis3c3hQL1Bzd0hxS0FJV3RtSkc0Tm1TL0Zu?=
 =?utf-8?B?RDkvdVJadGFGc0hVN3FFVnBKMU9WQ0t0OXJTVHRZNG9YK3ZBN1NlbVNnd2dX?=
 =?utf-8?B?MEw3bnJMUzM1MW8rVXcydVh4bXQrd2UxQ3Yxakw0SktMOTdNRDJGdmwzT3hn?=
 =?utf-8?B?UFJzaUNZSFV1ZFBjMGhMdmxldjRuQWVsRlJVWXdmMDBMZlFhN0tTMXZLaTNJ?=
 =?utf-8?B?czdyZENsaTMwNWp1UVptb1hveHMxNmF2VjhXSTlOYms3N3JUaDhqemRwK3JX?=
 =?utf-8?B?TW5PbCtPUWZ3QmhKUy93ekZYMTN6S0VQQVhoM2NOL3dwRWxwTVlrcDZURWxW?=
 =?utf-8?B?Nzk5bjQwNWdtd2pLM3EvZjV4YTBEVHE2Slg4Wi95T05BSnFtMWVoRU1ZaWVw?=
 =?utf-8?B?R3FkOVo1cE1RZ1FqZFpkdTJFSlhYOTBNUGlmWlNuWHcxcHVBemIvd1ZncVpH?=
 =?utf-8?B?U2xBV2Jmc3B0bndOSEVlQVVVSTA0aW44RENBSGkxN0Z2QjMwOEE0SmVnMmRC?=
 =?utf-8?B?bUZNN2Z3NnhyZTFUYXhGenoydERHT0FuN3J5NDVsSnMrdjAva3JzV3hzSlZr?=
 =?utf-8?B?cllrZXlSL3Jya0wwRFgxT3Z0WTN1cHlvQldESWFYT1NBL2FjY2c0bGpyU245?=
 =?utf-8?B?TXpZU0grK3JCRndNalpzbHJnV2VrdXFCM2NqR0pSa2I3WnhUblNzNEFPaHhG?=
 =?utf-8?B?Z2NUQ1VLZWYyYThMdW1YcEkzK2RUbnJ0TmFvS1BjZjZGQmFwcUNwVlZCQnlW?=
 =?utf-8?B?TS9iZVMwTzA2aGNBNDJHTjZsNDJZQThMYmFUYkZGRmR3YjFwWXR2UFdtdjNR?=
 =?utf-8?B?dCtUTXphSlo1UERRdnRPcjlNc0pWWitJdndFNlZ3aTAwc0UraG1QeFhlY09j?=
 =?utf-8?Q?sypCzEYAl6WTefyIX3KKDmexE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98bdd44-2eae-4239-1b44-08db870bd3ea
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 21:21:47.4823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzmqwF3q40OuIeC1LWQELnc4rluZq5oxqz5f9wlUtxq6axuGiePiZ9Gc1Qi2Ey+U9nOd0LFYgJBNyYF3hAKilg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
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
Cc: nicholas.kazlauskas@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/17/23 17:01, Aurabindo Pillai wrote:
> [Why&How]
> Internal subvp state is not referenced in driver code, so it can be removed.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |   2 -
>   .../amd/display/dmub/inc/dmub_subvp_state.h   | 183 ------------------
>   2 files changed, 185 deletions(-)
>   delete mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_subvp_state.h
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> index d52d5feeb311..a87afb796f47 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> @@ -47,11 +47,9 @@
>   #include "clk_mgr.h"
>   #include "dsc.h"
>   #include "dcn20/dcn20_optc.h"
> -#include "dmub_subvp_state.h"
>   #include "dce/dmub_hw_lock_mgr.h"
>   #include "dcn32_resource.h"
>   #include "link.h"
> -#include "dmub/inc/dmub_subvp_state.h"
>   
>   #define DC_LOGGER_INIT(logger)
>   
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_subvp_state.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_subvp_state.h
> deleted file mode 100644
> index 21b02bad696f..000000000000
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_subvp_state.h
> +++ /dev/null
> @@ -1,183 +0,0 @@
> -/*
> - * Copyright 2019 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - * Authors: AMD
> - *
> - */
> -
> -#ifndef DMUB_SUBVP_STATE_H
> -#define DMUB_SUBVP_STATE_H
> -
> -#include "dmub_cmd.h"
> -
> -#define DMUB_SUBVP_INST0 0
> -#define DMUB_SUBVP_INST1 1
> -#define SUBVP_MAX_WATERMARK 0xFFFF
> -
> -struct dmub_subvp_hubp_state {
> -	uint32_t CURSOR0_0_CURSOR_POSITION;
> -	uint32_t CURSOR0_0_CURSOR_HOT_SPOT;
> -	uint32_t CURSOR0_0_CURSOR_DST_OFFSET;
> -	uint32_t CURSOR0_0_CURSOR_SURFACE_ADDRESS_HIGH;
> -	uint32_t CURSOR0_0_CURSOR_SURFACE_ADDRESS;
> -	uint32_t CURSOR0_0_CURSOR_SIZE;
> -	uint32_t CURSOR0_0_CURSOR_CONTROL;
> -	uint32_t HUBPREQ0_CURSOR_SETTINGS;
> -	uint32_t HUBPREQ0_DCSURF_SURFACE_EARLIEST_INUSE_HIGH;
> -	uint32_t HUBPREQ0_DCSURF_SURFACE_EARLIEST_INUSE;
> -	uint32_t HUBPREQ0_DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH;
> -	uint32_t HUBPREQ0_DCSURF_PRIMARY_SURFACE_ADDRESS;
> -	uint32_t HUBPREQ0_DCSURF_PRIMARY_META_SURFACE_ADDRESS;
> -	uint32_t HUBPREQ0_DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH;
> -	uint32_t HUBPREQ0_DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C;
> -	uint32_t HUBPREQ0_DCSURF_PRIMARY_SURFACE_ADDRESS_C;
> -	uint32_t HUBPREQ0_DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH_C;
> -	uint32_t HUBPREQ0_DCSURF_PRIMARY_META_SURFACE_ADDRESS_C;
> -};
> -
> -enum subvp_error_code {
> -	DMUB_SUBVP_INVALID_STATE,
> -	DMUB_SUBVP_INVALID_TRANSITION,
> -};
> -
> -enum subvp_state {
> -	DMUB_SUBVP_DISABLED,
> -	DMUB_SUBVP_IDLE,
> -	DMUB_SUBVP_TRY_ACQUIRE_LOCKS,
> -	DMUB_SUBVP_WAIT_FOR_LOCKS,
> -	DMUB_SUBVP_PRECONFIGURE,
> -	DMUB_SUBVP_PREPARE,
> -	DMUB_SUBVP_ENABLE,
> -	DMUB_SUBVP_SWITCHING,
> -	DMUB_SUBVP_END,
> -	DMUB_SUBVP_RESTORE,
> -};
> -
> -/* Defines information for SUBVP to handle vertical interrupts. */
> -struct dmub_subvp_vertical_interrupt_event {
> -	/**
> -	 * @inst: Hardware instance of vertical interrupt.
> -	 */
> -	uint8_t otg_inst;
> -
> -	/**
> -	 * @pad: Align structure to 4 byte boundary.
> -	 */
> -	uint8_t pad[3];
> -
> -	enum subvp_state curr_state;
> -};
> -
> -struct dmub_subvp_vertical_interrupt_state {
> -	/**
> -	 * @events: Event list.
> -	 */
> -	struct dmub_subvp_vertical_interrupt_event events[DMUB_MAX_STREAMS];
> -};
> -
> -struct dmub_subvp_vline_interrupt_event {
> -
> -	uint8_t hubp_inst;
> -	uint8_t pad[3];
> -};
> -
> -struct dmub_subvp_vline_interrupt_state {
> -	struct dmub_subvp_vline_interrupt_event events[DMUB_MAX_PLANES];
> -};
> -
> -struct dmub_subvp_interrupt_ctx {
> -	struct dmub_subvp_vertical_interrupt_state vertical_int;
> -	struct dmub_subvp_vline_interrupt_state vline_int;
> -};
> -
> -struct dmub_subvp_pipe_state {
> -	uint32_t pix_clk_100hz;
> -	uint16_t main_vblank_start;
> -	uint16_t main_vblank_end;
> -	uint16_t mall_region_lines;
> -	uint16_t prefetch_lines;
> -	uint16_t prefetch_to_mall_start_lines;
> -	uint16_t processing_delay_lines;
> -	uint8_t main_pipe_index;
> -	uint8_t phantom_pipe_index;
> -	uint16_t htotal; // htotal for main / phantom pipe
> -	uint16_t vtotal;
> -	uint16_t optc_underflow_count;
> -	uint16_t hubp_underflow_count;
> -	uint8_t pad[2];
> -};
> -
> -/**
> - * struct dmub_subvp_vblank_drr_info - Store DRR state when handling
> - * SubVP + VBLANK with DRR multi-display case.
> - *
> - * The info stored in this struct is only valid if drr_in_use = 1.
> - */
> -struct dmub_subvp_vblank_drr_info {
> -	uint8_t drr_in_use;
> -	uint8_t drr_window_size_ms;	// DRR window size -- indicates largest VMIN/VMAX adjustment per frame
> -	uint16_t min_vtotal_supported;	// Min VTOTAL that supports switching in VBLANK
> -	uint16_t max_vtotal_supported;	// Max VTOTAL that can still support SubVP static scheduling requirements
> -	uint16_t prev_vmin;		// Store VMIN value before MCLK switch (used to restore after MCLK end)
> -	uint16_t prev_vmax;		// Store VMAX value before MCLK switch (used to restore after MCLK end)
> -	uint8_t use_ramping;		// Use ramping or not
> -	uint8_t pad[1];
> -};
> -
> -struct dmub_subvp_vblank_pipe_info {
> -	uint32_t pix_clk_100hz;
> -	uint16_t vblank_start;
> -	uint16_t vblank_end;
> -	uint16_t vstartup_start;
> -	uint16_t vtotal;
> -	uint16_t htotal;
> -	uint8_t pipe_index;
> -	uint8_t pad[1];
> -	struct dmub_subvp_vblank_drr_info drr_info;	// DRR considered as part of SubVP + VBLANK case
> -};
> -
> -enum subvp_switch_type {
> -	DMUB_SUBVP_ONLY, // Used for SubVP only, and SubVP + VACTIVE
> -	DMUB_SUBVP_AND_SUBVP, // 2 SubVP displays
> -	DMUB_SUBVP_AND_VBLANK,
> -	DMUB_SUBVP_AND_FPO,
> -};
> -
> -/* SubVP state. */
> -struct dmub_subvp_state {
> -	struct dmub_subvp_pipe_state pipe_state[DMUB_MAX_SUBVP_STREAMS];
> -	struct dmub_subvp_interrupt_ctx int_ctx;
> -	struct dmub_subvp_vblank_pipe_info vblank_info;
> -	enum subvp_state state; // current state
> -	enum subvp_switch_type switch_type; // enum take up 4 bytes (?)
> -	uint8_t mclk_pending;
> -	uint8_t num_subvp_streams;
> -	uint8_t vertical_int_margin_us;
> -	uint8_t pstate_allow_width_us;
> -	uint32_t subvp_mclk_switch_count;
> -	uint32_t subvp_wait_lock_count;
> -	uint32_t driver_wait_lock_count;
> -	uint32_t subvp_vblank_frame_count;
> -	uint16_t watermark_a_cache;
> -	uint8_t pad[2];
> -};
> -
> -#endif /* _DMUB_SUBVP_STATE_H_ */

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
