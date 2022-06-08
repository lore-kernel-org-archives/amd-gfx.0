Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E04CC43334
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 18:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF6C8112E4A;
	Wed,  8 Jun 2022 18:03:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F38112E4E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 18:03:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVOmmquHAXPU91klAj24jdiXMeUllYJq5OCGZkMxl5BFdrS9x5FewhjdBOpfdZH2mjC4EDLpznmbSmPXVRZVuwaHzkA+k5bauaJB3oHw07T+/upvlbuEGITHw0oRqBZRFG2Wy+1K190e8Vq4Y/9RuzW/85j4LXlXF8UaKXp8zUjE7RrVa8+wHxqLRBeJIfdbN1HPedqUHuODAske//lWpZM7XjC5jVPhNSLwukgzgvPDpR7WnD0JxA55w2LDfoZ/3usz2CP3utug6ulEEho5i0mVECX/5pL1ssA0hPf6mgdfLFIXCt3lKh1NuEqfz5NuQonVBbWBlcRFLQEcU6a3Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ij/xAzSFKmXkpjD+HnG+AQzwlMJ0FgH+3RA0GnBZqTw=;
 b=M01aOnwNnEKXUR6aISyxQF8q2EVdDqHavEjaZJht96HQxq+axWUkK+aztHlfUGFbJqRNEVWfFkEjEeXZtKyjfbWjmUeksGlae/bkT5i2pJCFZSNk2rXInvXdrU3UBnz091jsDtw7zafKq2rLyHGj9piv/3MNkIbxsp4wTYBmbAjppqItJJmC4Kcj6lXH315wiwn8nQgLpk/qBguN+q0Pu1krjOECwG/aUFmwucovOIvAITvPiH3eVmnTeMcBqxSlwvaw98JNVBgtS0WeAucd13tsWaFUFc+UtW5D1U7wfzsjAE4+Bf+HRZ2iCB9m4HFkcQ+7ZFiJyEKMZzK2euHA2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ij/xAzSFKmXkpjD+HnG+AQzwlMJ0FgH+3RA0GnBZqTw=;
 b=veUmlbdSR3jYGbg/p69xjBnQZYUM5cH6piLZTUKUNcJr48i+OfT2DWlIdm8ouQ2m5fKRxvwIbFckZpPoP2MGElNTxDriQI7My1kIbIXjBouAsUjIVrOtiep/rZl+saclK7q/8wzvtPN/97aEVtPAkZQLLNh8ft6CT1siM4/fgA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 18:03:18 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 18:03:17 +0000
Message-ID: <d233a4db-140b-6a1f-a5c4-21aad71ca692@amd.com>
Date: Wed, 8 Jun 2022 14:02:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amd/display: Use pre-allocated temp struct for
 bounding box update
Content-Language: en-US
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
References: <20220608164856.1870594-1-sunpeng.li@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220608164856.1870594-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::21) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d13e9585-4036-402b-20a8-08da49792a4c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4341:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB43417AC0611A2BB97FD352E48CA49@MN2PR12MB4341.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sT21jzZlRuWMuo4p5+4CgwiA3VcdyyEiEeTjHf/PM9hwS/fwGPCSHiCfSagzTdsEY+hwqB9hiNqjtU2ngmUX9E3GBUPqaL44ROm3DZUsp4zdkWNSA/WMY0Wz83aY4jH+A/EFx0XdO/nnXaeKimKxHdltmTfY+avwe/yD1knf8ctF/wYSQcAsoXG0PMrL+b/oseDOV4hrYaEO4SbZ0d1Q+2Vieg9qbU6NHCfndPjCSUoDjcy+971SK13ObITyHGgz1wp+/1cv8uiI4B5x3lq1+ssGGiu9N6eO8dyk2L5AtN/ueSt2nsDfkm8YMSNiZJCqBUcLcfoh0NeNd2miDD1rhJhxkt3wfyP8HDQM5luCkD5GXE1age/0gW/pMCjZgCjIJaAScunB4CeO0UQS7KHTqBRyEm/R9RFQzCyxiKJssI3JhGgOu0LOurEEmtJnT9KIxdzOFHl3WmdrvCNktOCrKQC8LXxAaAInA4e7bQwt9Ug0nt8M35L4R/lpI2gsYDywqz7a/f2UHrSIAwPF9GLhIIbPtRBCbx1HzQiY4AFoyNpk0IknQyCQ4E6Gp2hKIGshfjpBCbUgAN7cJbKjpGZPrK+qGKPmmc8Z/8ew6uk0jJj6GtjlXI9hfYaCzuhJgGNu+p+Pk6LTbFGbBa5ArHxMoJoDqRBRRbcbHl+4ATPXidsaEQcXBfmI37by+tws9+3k9nyWh1EhssNEx2JzNo2PK0D0bjL1FEcEkF2UKoWlvY76HSvxtIUxfdCwR1xan0Tk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(36756003)(2906002)(186003)(44832011)(53546011)(66946007)(316002)(6666004)(5660300002)(31686004)(26005)(8936002)(83380400001)(8676002)(4326008)(31696002)(6512007)(38100700002)(6486002)(508600001)(66476007)(66556008)(30864003)(86362001)(15650500001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW5ucmpQNWNvLzMwT3pFY1gzcS9EeTc1WkZPSW96clhrbmd2VjZVVGZld2Fq?=
 =?utf-8?B?WDNHaWkwbjNuWCttdm9kTXRBZExvczhaQzMvSTMzcTRIUTBKSDBDYWpEc3Ri?=
 =?utf-8?B?MC8raVo3Y0xldHhRN0lPemZSdUZ3OGhXS3FNQ0wvbFJNckxiY2crdCthanhI?=
 =?utf-8?B?VUFyNjBXRUNQbU5RcWVER2NDdEttTTRVOGVXcFJobzNud2hwSm9IR1duQVFG?=
 =?utf-8?B?cjcrYitzZUtEZHpMNUxEQVNWVXpTdkZlR3JGUkJDSEpIVXFXVXBGQkFVN0Rp?=
 =?utf-8?B?YTdwWXByazZaRGs0dyt5YksyS1lkVE1yeDdMZ3ptTTZWT0JvZktKTllFS3RB?=
 =?utf-8?B?VXVmbkk1OHo1RjZoamxra1dpdGEzb0tReSt1dS9EVW1nSnhscE1CWXRFV3hI?=
 =?utf-8?B?V1JTeG1lclk3dzBhR2U0VkY1MHo3czNGSUxGOFI4ajl2N0d5czEyeDE4TWE3?=
 =?utf-8?B?aVFYenJINHBic0xHaHhWUDZOY0NFbVU2MVpJU0lhcmtYVU1lelQ2YXV1OW9K?=
 =?utf-8?B?aENtODB1TkErTi9sdlpwTm9TR0dxcXJQRmpnSXFscENsQjFqN005QjRaQ1d3?=
 =?utf-8?B?dkhzdk5JUm1IeWlqL01IV0VCUmMwdmFhbi9QUERBdm5MU3luWTI3cFMrOXV3?=
 =?utf-8?B?WGlDNjNjWFptWnk2dXJYYXNRN01YWTRsR3g2aFlqZGQzdEhKakhvM2UvQ2hi?=
 =?utf-8?B?dkpyU0M5RjhqcXl2UEpuYm5za2tTbGdEbVpCUEI5S1FQZnlxVVd4bnBBTEZT?=
 =?utf-8?B?VWJZSnFwUDhKSWNXejdwRmFLTTRzY1llTG9QYVdDMDZCUGtwTFA1V2lncDBj?=
 =?utf-8?B?RGRYYWRFYUxYZVNpZGJJSjlpQWFVeWcybjRBeGZYdjVpL2hiRXIxaSt0ZXdj?=
 =?utf-8?B?Tzdtak9OYVRleklQajJmcXduTGxUM3hTT2NldDQ0ZldlMXJ1N3ZnSFd4Rlkz?=
 =?utf-8?B?LzRiell6SVcya2FNMmpTSkpvbDh0S2w2MnNvL1RGTmtFTVpDWjZZVmFVdWlB?=
 =?utf-8?B?RG42S09SbmtRU2UrWkZGMXZPeUxEQ2UwTnlCa2lsSXZ5V0IzYjk1c0VWYlNh?=
 =?utf-8?B?b0UvZC9yOEhHZkcyR2Z3MUQ4V2tXNjY2aEZZRkE5YVYzMFMvaWJWd1BHZjMy?=
 =?utf-8?B?VXhIbjlzbXE2bkE2KzRxUklsaU5ZRkJzUFk0ZVFuQ0dZay9ESXJ2UWo0bWFl?=
 =?utf-8?B?TFhEOVFtbGx5cFhKYTQ5UG9jU2dseWhUTEVIeER2SFNBYkIyVGdTRVhuV2Z5?=
 =?utf-8?B?VjBrNnZHM2lkMEZtVWhlMUF3TDRITU9aNUgySkNsMkxNa2NCakhRVjhaZEF6?=
 =?utf-8?B?dXpDVWJ4ZE5kNmVReHdLMlcwM0RYRXR0ZEY0cVk2Wm1zWDVJTmxpQW1xb3RQ?=
 =?utf-8?B?VTZBY0U2TzZ4LzduTU9Zb2E3U0tpY2tUbzY5RlJ0SWdOTUxiWjlpVWJwT3ZU?=
 =?utf-8?B?V0QxSFdUczRMajNia0NNZXJERzhFRitjMGF1b2xQN2cvWWtBaXQ2L2dKNnZB?=
 =?utf-8?B?RytDY01zTGdzZ3k1NWljeHN6NTJEL0J0cTJwRlZOUmh6bEZtOG5zTmRrMmZY?=
 =?utf-8?B?eDlKZFptRXA3amNEV1pHYlBrV29IOW90ZzhOa2xGZCs5UEp3cktWanViQ1dp?=
 =?utf-8?B?Z3lGTWZJaG9UVmRhM3RDR3Z4dGN3Y0pwaEFxdHEydGl2UHNVTUFoLzRTQTlV?=
 =?utf-8?B?MysxOEo3TE5mekFhekhEck5iaDV0SzJ3YWNHYXZEUklnSUNyVnFVVmJ5ZE9B?=
 =?utf-8?B?SjdtbG4yMWl2cUtRQUhtWUNyUmkyVWVGN2gxd1FRZGorODNjNndjWXlBVWg2?=
 =?utf-8?B?clBMdFVrK0dxZ2w3T0dqVzZ2VGdNN2JJL0JuR0xDTHhySWxSSUlybHRkTW5B?=
 =?utf-8?B?bTltSDVHb0VHV2pORTQxMnpHNE50a2ttblhLVEZLSEtSQXh3RHRjVzBPR2ZH?=
 =?utf-8?B?a0Z3S1cxRUYwalppL2ZCUXJ5MnZJNjJtL3QwN0gyWHUxYXBKS1lVRWxZVWIy?=
 =?utf-8?B?ajdkS1JPNXFFdHJVNFJjaUloRk1VVnBUbjVacDBXWnQ4d2NzSTJQTHhzdlZm?=
 =?utf-8?B?eVI1eXQzRFN5dTVzdmg4dFdJNXVqRkI2S1hmSWNKblJBL29wUEZVcDVVTk5y?=
 =?utf-8?B?T05IZEdpU2pKUHdhTGoyM2hXMUNkV2x0S1d3cVl1SEtVK2JMZEZyMllCclFV?=
 =?utf-8?B?RW15YlI1S0hKVmRRSkJxbUNtTFNyaXZaRGF1SVlJbmJXMU9WcVNsVFNXMzZn?=
 =?utf-8?B?R3lCU2RlZEVqakZlOUFhQmRvditjVjlUUDNhL2w2UmVqNHVka1UxR3doMTRo?=
 =?utf-8?B?TnZSd3NwWkk3SEg5OUhWbjlwTlNnZEpTV2NwRmJkaG52Z0NhWVdFQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13e9585-4036-402b-20a8-08da49792a4c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 18:03:17.7580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FR2ye8AlkZ+SoP6EO7DTqVPeKZ+B/vBV/gTYbwOWdJZKb26GHKBiUOBVW5garCDLajjYHLUb1/EgJqK9qCNPxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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
Cc: aurabindo.pillai@amd.com, Rodrigo.Siqueira@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-08 12:48, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> [Why]
> 
> There is a theoretical problem in prior patches for reducing the stack
> size of *update_bw_bounding_box() functions.
> 
> By modifying the soc.clock_limits[n] struct directly, this can cause
> unintended behavior as the for loop attempts to swap rows in
> clock_limits[n]. A temporary struct is still required to make sure we
> stay functinoally equivalent.
> 
> [How]
> 
> Add a temporary clock_limits table to the SOC struct, and use it when
> swapping rows.
> 
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> ---
>  .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 33 +++++-----
>  .../amd/display/dc/dml/dcn301/dcn301_fpu.c    | 36 ++++++-----
>  .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 64 +++++++++++--------
>  .../amd/display/dc/dml/display_mode_structs.h |  5 ++
>  4 files changed, 82 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> index c2fec0d85da4..e247b2270b1d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> @@ -2015,9 +2015,8 @@ void dcn21_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
>  
>  	ASSERT(clk_table->num_entries);
>  	/* Copy dcn2_1_soc.clock_limits to clock_limits to avoid copying over null states later */
> -	for (i = 0; i < dcn2_1_soc.num_states + 1; i++) {
> -		dcn2_1_soc.clock_limits[i] = dcn2_1_soc.clock_limits[i];
> -	}

Hmm, this for loop didn't make sense. I gave my RB for the previous patch too quickly.

> +	memcpy(&dcn2_1_soc._clock_tmp, &dcn2_1_soc.clock_limits,
> +	       sizeof(dcn2_1_soc.clock_limits));
>  
>  	for (i = 0; i < clk_table->num_entries; i++) {
>  		/* loop backwards*/
> @@ -2032,22 +2031,26 @@ void dcn21_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
>  		if (i == 1)
>  			k++;
>  
> -		dcn2_1_soc.clock_limits[k].state = k;
> -		dcn2_1_soc.clock_limits[k].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
> -		dcn2_1_soc.clock_limits[k].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
> -		dcn2_1_soc.clock_limits[k].socclk_mhz = clk_table->entries[i].socclk_mhz;
> -		dcn2_1_soc.clock_limits[k].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
> +		dcn2_1_soc._clock_tmp[k].state = k;
> +		dcn2_1_soc._clock_tmp[k].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
> +		dcn2_1_soc._clock_tmp[k].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
> +		dcn2_1_soc._clock_tmp[k].socclk_mhz = clk_table->entries[i].socclk_mhz;
> +		dcn2_1_soc._clock_tmp[k].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
>  
> -		dcn2_1_soc.clock_limits[k].dispclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
> -		dcn2_1_soc.clock_limits[k].dppclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
> -		dcn2_1_soc.clock_limits[k].dram_bw_per_chan_gbps = dcn2_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
> -		dcn2_1_soc.clock_limits[k].dscclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
> -		dcn2_1_soc.clock_limits[k].dtbclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
> -		dcn2_1_soc.clock_limits[k].phyclk_d18_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
> -		dcn2_1_soc.clock_limits[k].phyclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
> +		dcn2_1_soc._clock_tmp[k].dispclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
> +		dcn2_1_soc._clock_tmp[k].dppclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
> +		dcn2_1_soc._clock_tmp[k].dram_bw_per_chan_gbps = dcn2_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
> +		dcn2_1_soc._clock_tmp[k].dscclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
> +		dcn2_1_soc._clock_tmp[k].dtbclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
> +		dcn2_1_soc._clock_tmp[k].phyclk_d18_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
> +		dcn2_1_soc._clock_tmp[k].phyclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
>  

I see why we need a tmp array and agree that we shouldn't allocate it inside DML
functions.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

>  		k++;
>  	}
> +
> +	memcpy(&dcn2_1_soc.clock_limits, &dcn2_1_soc._clock_tmp,
> +	       sizeof(dcn2_1_soc.clock_limits));
> +
>  	if (clk_table->num_entries) {
>  		dcn2_1_soc.num_states = clk_table->num_entries + 1;
>  		/* fill in min DF PState */
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
> index 62cf283d9f41..e4863f0bf0f6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
> @@ -254,6 +254,9 @@ void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
>  
>  	dc_assert_fp_enabled();
>  
> +	memcpy(&dcn3_01_soc._clock_tmp, &dcn3_01_soc.clock_limits,
> +	       sizeof(dcn3_01_soc.clock_limits));
> +
>  	/* Default clock levels are used for diags, which may lead to overclocking. */
>  	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
>  		dcn3_01_ip.max_num_otg = pool->base.res_cap->num_timing_generator;
> @@ -270,29 +273,32 @@ void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
>  				}
>  			}
>  
> -			dcn3_01_soc.clock_limits[i].state = i;
> -			dcn3_01_soc.clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
> -			dcn3_01_soc.clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
> -			dcn3_01_soc.clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
> -			dcn3_01_soc.clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
> -
> -			dcn3_01_soc.clock_limits[i].dispclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
> -			dcn3_01_soc.clock_limits[i].dppclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
> -			dcn3_01_soc.clock_limits[i].dram_bw_per_chan_gbps = dcn3_01_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
> -			dcn3_01_soc.clock_limits[i].dscclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
> -			dcn3_01_soc.clock_limits[i].dtbclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
> -			dcn3_01_soc.clock_limits[i].phyclk_d18_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
> -			dcn3_01_soc.clock_limits[i].phyclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
> +			dcn3_01_soc._clock_tmp[i].state = i;
> +			dcn3_01_soc._clock_tmp[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
> +			dcn3_01_soc._clock_tmp[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
> +			dcn3_01_soc._clock_tmp[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
> +			dcn3_01_soc._clock_tmp[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
> +
> +			dcn3_01_soc._clock_tmp[i].dispclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
> +			dcn3_01_soc._clock_tmp[i].dppclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
> +			dcn3_01_soc._clock_tmp[i].dram_bw_per_chan_gbps = dcn3_01_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
> +			dcn3_01_soc._clock_tmp[i].dscclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
> +			dcn3_01_soc._clock_tmp[i].dtbclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
> +			dcn3_01_soc._clock_tmp[i].phyclk_d18_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
> +			dcn3_01_soc._clock_tmp[i].phyclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
>  		}
>  
>  		if (clk_table->num_entries) {
>  			dcn3_01_soc.num_states = clk_table->num_entries;
>  			/* duplicate last level */
> -			dcn3_01_soc.clock_limits[dcn3_01_soc.num_states] = dcn3_01_soc.clock_limits[dcn3_01_soc.num_states - 1];
> -			dcn3_01_soc.clock_limits[dcn3_01_soc.num_states].state = dcn3_01_soc.num_states;
> +			dcn3_01_soc._clock_tmp[dcn3_01_soc.num_states] = dcn3_01_soc.clock_limits[dcn3_01_soc.num_states - 1];
> +			dcn3_01_soc._clock_tmp[dcn3_01_soc.num_states].state = dcn3_01_soc.num_states;
>  		}
>  	}
>  
> +	memcpy(&dcn3_01_soc.clock_limits, &dcn3_01_soc._clock_tmp,
> +	       sizeof(dcn3_01_soc.clock_limits));
> +
>  	dcn3_01_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
>  	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
> index 6da702923226..7be3476989ce 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
> @@ -580,6 +580,9 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
>  
>  	dc_assert_fp_enabled();
>  
> +	memcpy(&dcn3_1_soc._clock_tmp, &dcn3_1_soc.clock_limits,
> +	       sizeof(dcn3_1_soc.clock_limits));
> +
>  	// Default clock levels are used for diags, which may lead to overclocking.
>  	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
>  		int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
> @@ -607,32 +610,35 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
>  				}
>  			}
>  
> -			dcn3_1_soc.clock_limits[i].state = i;
> +			dcn3_1_soc._clock_tmp[i].state = i;
>  
>  			/* Clocks dependent on voltage level. */
> -			dcn3_1_soc.clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
> -			dcn3_1_soc.clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
> -			dcn3_1_soc.clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
> -			dcn3_1_soc.clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
> +			dcn3_1_soc._clock_tmp[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
> +			dcn3_1_soc._clock_tmp[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
> +			dcn3_1_soc._clock_tmp[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
> +			dcn3_1_soc._clock_tmp[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
>  
>  			/* Clocks independent of voltage level. */
> -			dcn3_1_soc.clock_limits[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
> +			dcn3_1_soc._clock_tmp[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
>  				dcn3_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
>  
> -			dcn3_1_soc.clock_limits[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
> +			dcn3_1_soc._clock_tmp[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
>  				dcn3_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
>  
> -			dcn3_1_soc.clock_limits[i].dram_bw_per_chan_gbps = dcn3_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
> -			dcn3_1_soc.clock_limits[i].dscclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
> -			dcn3_1_soc.clock_limits[i].dtbclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
> -			dcn3_1_soc.clock_limits[i].phyclk_d18_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
> -			dcn3_1_soc.clock_limits[i].phyclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
> +			dcn3_1_soc._clock_tmp[i].dram_bw_per_chan_gbps = dcn3_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
> +			dcn3_1_soc._clock_tmp[i].dscclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
> +			dcn3_1_soc._clock_tmp[i].dtbclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
> +			dcn3_1_soc._clock_tmp[i].phyclk_d18_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
> +			dcn3_1_soc._clock_tmp[i].phyclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
>  		}
>  		if (clk_table->num_entries) {
>  			dcn3_1_soc.num_states = clk_table->num_entries;
>  		}
>  	}
>  
> +	memcpy(&dcn3_1_soc.clock_limits, &dcn3_1_soc._clock_tmp,
> +	       sizeof(dcn3_1_soc.clock_limits));
> +
>  	dcn3_1_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
>  	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
>  
> @@ -705,6 +711,9 @@ void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
>  
>  	dc_assert_fp_enabled();
>  
> +	memcpy(&dcn3_16_soc._clock_tmp, &dcn3_16_soc.clock_limits,
> +	       sizeof(dcn3_16_soc.clock_limits));
> +
>  	// Default clock levels are used for diags, which may lead to overclocking.
>  	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
>  
> @@ -736,37 +745,40 @@ void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
>  				closest_clk_lvl = dcn3_16_soc.num_states - 1;
>  			}
>  
> -			dcn3_16_soc.clock_limits[i].state = i;
> +			dcn3_16_soc._clock_tmp[i].state = i;
>  
>  			/* Clocks dependent on voltage level. */
> -			dcn3_16_soc.clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
> +			dcn3_16_soc._clock_tmp[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
>  			if (clk_table->num_entries == 1 &&
> -				dcn3_16_soc.clock_limits[i].dcfclk_mhz < dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
> +			    dcn3_16_soc._clock_tmp[i].dcfclk_mhz < dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
>  				/*SMU fix not released yet*/
> -				dcn3_16_soc.clock_limits[i].dcfclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
> +				dcn3_16_soc._clock_tmp[i].dcfclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
>  			}
> -			dcn3_16_soc.clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
> -			dcn3_16_soc.clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
> -			dcn3_16_soc.clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
> +			dcn3_16_soc._clock_tmp[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
> +			dcn3_16_soc._clock_tmp[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
> +			dcn3_16_soc._clock_tmp[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
>  
>  			/* Clocks independent of voltage level. */
> -			dcn3_16_soc.clock_limits[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
> +			dcn3_16_soc._clock_tmp[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
>  				dcn3_16_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
>  
> -			dcn3_16_soc.clock_limits[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
> +			dcn3_16_soc._clock_tmp[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
>  				dcn3_16_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
>  
> -			dcn3_16_soc.clock_limits[i].dram_bw_per_chan_gbps = dcn3_16_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
> -			dcn3_16_soc.clock_limits[i].dscclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
> -			dcn3_16_soc.clock_limits[i].dtbclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
> -			dcn3_16_soc.clock_limits[i].phyclk_d18_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
> -			dcn3_16_soc.clock_limits[i].phyclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
> +			dcn3_16_soc._clock_tmp[i].dram_bw_per_chan_gbps = dcn3_16_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
> +			dcn3_16_soc._clock_tmp[i].dscclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
> +			dcn3_16_soc._clock_tmp[i].dtbclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
> +			dcn3_16_soc._clock_tmp[i].phyclk_d18_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
> +			dcn3_16_soc._clock_tmp[i].phyclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
>  		}
>  		if (clk_table->num_entries) {
>  			dcn3_16_soc.num_states = clk_table->num_entries;
>  		}
>  	}
>  
> +	memcpy(&dcn3_16_soc.clock_limits, &dcn3_16_soc._clock_tmp,
> +	       sizeof(dcn3_16_soc.clock_limits));
> +
>  	if (max_dispclk_mhz) {
>  		dcn3_16_soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
>  		dc->dml.soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
> index 74afa10e70f8..2bdf60846762 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
> @@ -161,6 +161,11 @@ struct _vcs_dpi_voltage_scaling_st {
>  
>  struct _vcs_dpi_soc_bounding_box_st {
>  	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
> +	/*
> +	 * This is a temporary stash for updating @clock_limits with the PMFW
> +	 * clock table. Do not use outside of *update_bw_boudning_box functions.
> +	 */
> +	struct _vcs_dpi_voltage_scaling_st _clock_tmp[DC__VOLTAGE_STATES];
>  	unsigned int num_states;
>  	double sr_exit_time_us;
>  	double sr_enter_plus_exit_time_us;

