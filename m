Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E45C04A6A
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 18:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A69D110E39E;
	Wed, 16 Aug 2023 18:07:24 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBD8010E39E
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 18:07:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHUROWsbIAXwVNBle5CZaIk8Y1L8rmKCaHLaCtPm97UuaKDjxBtXCO/8l+pC1xgMlYGwQGSDF/RL5lOsqs02RdZtJAYqKzLzJWzAERWW5GqLvosH15A/S5x4qinm6nG4zmKT1uq441MuDLfHSXo9yZPkTULKkL9oMEhnkXi4y6x9g62Txo61WFdXAQAnB61xL0FtzhmGRjVPo4Joon7NRRRwcDdnf3JjLQESrP+upb9vMgc5XuuStKnrl75S535u1wxEnzT4hmFP5qPyRHZk5ToS1kIb1HyOxG9o8pot70sAI5Qp0mbaBhM511oZiQI0ZVhkWakMrpE2E0hh221hOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRiChzZZ5hPUJvQR79o4eEfSFXHlH8RGiZYdgszpBCk=;
 b=IyUC6ftx7u8Cbq+HL99GoeJG717C5C6h4+XsFcGC4zcedMbsPw4HKEJiJl5bj4hlcWcYYNlYo6F8Sdy0e7q+/SBDj2hDxCcpU73S5leHzd/lDuirG6p+fnTpltO30t9q2IFtF9PmKkSQv6krvTG5CMBAwYRsIKNChOGRmTFc8/HHxpUQV4wdZQV/l3h7Wj5rfxU3m1H2kBYM6F/eFppev33JCLEGGGmdSJ5jWxIYpdCaSYmDGn9kRAgZksr6FuJogxWDl5uihW7r9Dq88HgIHKh3Ji8ZVFx+ggbvjR8EGMs2CRNxhw8pqbggr0pLmJAmhJiY/D/PqtmOSDZqOvTfkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRiChzZZ5hPUJvQR79o4eEfSFXHlH8RGiZYdgszpBCk=;
 b=f8Yp58AscSy0HW6z3TkpjGtThKexz3IfQqbCvx8W8ca4pACz3os0T1E8GuudaD2jjzOF+/nLFHRKUn5ia93CnTFX1LAGpGw3QIWzM3LDC68Zd7DJ1uKuiCXRkTaGyOpIK/rbv7YCqctG1LuIBVnaCMqN7/Ykg5I79xhfNrME29Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Wed, 16 Aug
 2023 18:07:20 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::1235:f914:17d7:825d]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::1235:f914:17d7:825d%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 18:07:20 +0000
Message-ID: <fac76aac-7b29-4f9d-ba1b-aa0e83c9a4d0@amd.com>
Date: Wed, 16 Aug 2023 12:07:16 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix useless else if in
 display_mode_vba_util_32.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20230816065109.697657-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230816065109.697657-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P222CA0027.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::32) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe82c2a-daa0-47a8-122a-08db9e83a219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FczkC0K2MsMP13/2VThCtSpBAwK/XCDPEzwdTx9kHYoCpGO7byRnR5q9HSpnVT3ROR/HjQF0puDPORFbO89yi+NHnWqOTpYg5aWggj4OVWKAfaS6gjLeclzSOROXI22RPdDpowajDH5+Ouja21zyubCA/gMo7XHErFq/9JGKnR0kA+hJTBL3qWHIUI/SO59Jqtoa9MmeIgT1PbkhhX2MD9BjjqVBFL0uJtuiplNxOBCTcVGQgbMZyTuRnt2V9gEzpz9k7Xoj5uIbNNrwz5bSmwxwOMJDZT/jLMHlPIH4+Y6EcJErJJ+SYpK/D3i6Tk1wPsJkSiewhNctuiHdSWgeffy0tMVUhDMkQl13NhYPuIURUT+BJGpztJ4oH/9y1d4CFKiknOGui0q07/URUioEQ8hS7kJ2U2nWbtjxvw7x3Q3Ej+sHcdAzD7i4YWZKst0ywybYG6zmb7FnNWpLGajsDLewviMbGM3gyEJaKJKiDQk8ZHey7kooyCaQn49NciOHuffgYepf1vNb5EhEoqokdfrhGfk/vZ1YnYiIT1+rm6stHK23SpbrnK3gfzuMyBmkAJilTVrNJ8ebiPXD5/qYRguLl6iEQLkR82C8WRW0/69dxTGA67yoFXSDSY7DSqqWNy6avpFmFFm2ENUC0PIABQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199024)(1800799009)(186009)(316002)(6636002)(66946007)(110136005)(66476007)(66556008)(41300700001)(5660300002)(66574015)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(83380400001)(478600001)(86362001)(6512007)(53546011)(31696002)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFlFUkdLZW9Kbk5vKzJ0MXAvMWV4N3FHZjQrcnRBZDVJMUJ4SWlCVWJWb0tt?=
 =?utf-8?B?UVhjU1VPVmdScHh1cjhrUVlSSGRrc0pLMHFRemVlV2FwaGNYM0dtL1JCZ0dp?=
 =?utf-8?B?OWUvSVcrbml4a3IwcmFyQnExNGVRTHpLVERkWmpFSXNGL1hVRWZPNGRwTzhX?=
 =?utf-8?B?c096WXJuR0xhYUl6VmVmS2pROS9TbjdLcnJlcnNWYmVpaVd1YnVYbWlJZmRY?=
 =?utf-8?B?QXJrVlRTSGk3SmNoQTE0amNkcHZOaXZsVE15UWtITzlQOHVuZU83bEYwV3JB?=
 =?utf-8?B?RHlQdDNORGpTcUE5cEkvNTN0YVpFV2VVT09MNTQxcEpjUGExRlcrTzBLTXlE?=
 =?utf-8?B?RDlBNk13aUlYZ2oydkxzMlo0UnpXNzF5UTBGTUtKNEpJWjFja0xtVzIvYjFO?=
 =?utf-8?B?c2NISGRFdVJlRDJJR3gwcGVNZTg0VzN3K0tLTHRQa0FHdExJcUxwek10ZVhq?=
 =?utf-8?B?Uk53VUlaYzlCemZRQWxxRmd0R0t5U0xwYWEwZ2ZRNXdoR01aMmt3UWtNY204?=
 =?utf-8?B?RGtzYzlYR1VFYlRvVzVIdFhNMWYyT2tkVEJOd3djYmF5dWMwcTFrQ1g2NkVh?=
 =?utf-8?B?dWFCTndaaUd2bW9zRFpuRGxzQWUyN1RoamlpWnFhSU16YkFHV2svYzVlQzdW?=
 =?utf-8?B?blo2NFgrckduclRCeFhSek53Q0JNQ1BlN3grbmVvK1h1TGw3bnJpeElxelg4?=
 =?utf-8?B?NE9FamJNOTR4UUlZTXhZWGdMNGxvb0J3TG5FRmRqdDRzNjNxVm1NYkdLUE9w?=
 =?utf-8?B?a00rb2VKSnVGVUtROUJxTlNaa1lhT1RsaVIybWNOWExvcVRuUHNyY29Fdko1?=
 =?utf-8?B?L3JtaGV3OVIycUoyYWZGVWdETFZGYlppeGp3cUh6TWliekhpbGxFZkg2UjFW?=
 =?utf-8?B?RnhBd0EvUGZUdlQ1QUpSOGJBMlNBMzRBOVpTKzZnZFFid2pyQzVOU2thcGQx?=
 =?utf-8?B?T1JJYWY1Um52dnJGalRsS05VNWd2YktWSmRLZW9UbFBFRU9QOHFWQnUrRlRE?=
 =?utf-8?B?V0hES2h3QTdBVktRSkVibG1rU0xrMnZVYkdyYTlqc0lpdFVBNjlwVVRZK29h?=
 =?utf-8?B?SXJPK3dySUxjV1ZQSDFZT1l3ajBybkYrNlJlYVhQUHVKR0s0WG9vWmRMRGdG?=
 =?utf-8?B?VXBkUWc0K0VwQnNXcG9OR25Wa2NlVnRHKzRDSE16bXlWNjRPb2lmayttUnAx?=
 =?utf-8?B?bzF4bDlUSWNhNGUvc0ZmNENiT1dvWXFxaTB6bm83ZXRmamt2UHhudW8xbWEr?=
 =?utf-8?B?dHYrOHhzVjd6b2ZFZDlmblNOdjBrbTZFWW1XVkhQbTIrWnc4NWs1anA0S2Jn?=
 =?utf-8?B?V2xhYnc4VHRGMWJ6cnNTVkw5QnJ5NVphalA2RVJKSXVlMkhWTE9ObkVLNjB6?=
 =?utf-8?B?dUkyN21oYTN2bmxBckVoN3VnYmdnQnoyZXpnRHhGRFZFZVp0SGlNRG1VSW90?=
 =?utf-8?B?OFBSYXFUVVo2RjM4UW1mbHJ1NGlSdTBobXJNUFBPVWNCSHNmQXRObklwYnN6?=
 =?utf-8?B?Q1RDMWVsVk9KbkZOdG5qWTQvUjhHZzBxVG1DRHVwYmRvaVdSU2x6b0NUNXQ3?=
 =?utf-8?B?SkdsVldhdWRTazdnNTk2SllTbmdEeHo4UG1zQUhsTlYwcjQzOGhvbE5oYVpj?=
 =?utf-8?B?Sm84cTNMSW91YTdLNlNrWDVNNnhmWmI0OFJ5aDlCaEtyS3Ztc1p2cGRwSFQ1?=
 =?utf-8?B?aTZSUnF6b2grZW8xaHNTYTBhM0lDaVpsWVVyMk8rUFZQWVJKdXF3Mmt1YTRZ?=
 =?utf-8?B?NFBWVlZGa05FclJRZGF4MkRLVmlaTzVhUjg3S0MwbjdPWkJoeWtyNnBXNG4v?=
 =?utf-8?B?NjI2dERUdGEwN3c0T0liNVk4SFptWGFvV2ExaG9NdTZ3b2RLV0w2TGhOZk5K?=
 =?utf-8?B?N0lqRGhseUI2ZEFFZzFkVWpUeWlRcURSZDk4RGl5OWc4QlBJRUpOQTBsVHBN?=
 =?utf-8?B?M0QvcUJQbnNnT3V0MWlXekUyQ0lQT2RnQ2NpclQwQmZtcm80YW9Kei94ZVNN?=
 =?utf-8?B?akdFNkZTMkVwYVBqWm42bTkzNzNUWDNDclJONEcwZi9vTkFpZStvRDVkSmNY?=
 =?utf-8?B?QjdhNnZOc0VhMDh6ZDNONEVyK0pMSjF3bFltbkRsYlpCS1N6V3ZMVEp2RFhv?=
 =?utf-8?B?MkVPT3hpZ0xJek4yRVBsVW9sWjAwVmN5bVQ0ZFQ4M1d6bzBwZTgvYkdFRWxF?=
 =?utf-8?Q?rvFlycOHQVbrm9Vea73PGHPtGr7ckvL+JoGawRIq7MQt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe82c2a-daa0-47a8-122a-08db9e83a219
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 18:07:20.2067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qMHvrPaVIiBwS5blroSp9a+IwpmhH404hUJg/DPD/B7nAJhFulUfMdlzMvk50C9E30BsjgiPmBnd0WIppi+Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/16/23 00:51, Srinivasan Shanmugam wrote:
> The assignment of the else if and else branches is the same, so the else if
> here is redundant, hence removed it.
> 
> Fixes the below:
> 
> drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c:4664:8-10: WARNING: possible condition with no effect (if == else)
> 
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c   | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> index ecea008f19d3..d940dfa5ae43 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> @@ -4661,10 +4661,6 @@ void dml32_CalculateMinAndMaxPrefetchMode(
>   	} else if (AllowForPStateChangeOrStutterInVBlankFinal == dm_prefetch_support_uclk_fclk_and_stutter) {
>   		*MinPrefetchMode = 0;
>   		*MaxPrefetchMode = 0;
> -	} else if (AllowForPStateChangeOrStutterInVBlankFinal ==
> -			dm_prefetch_support_uclk_fclk_and_stutter_if_possible) {
> -		*MinPrefetchMode = 0;
> -		*MaxPrefetchMode = 3;
>   	} else {
>   		*MinPrefetchMode = 0;
>   		*MaxPrefetchMode = 3;

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
