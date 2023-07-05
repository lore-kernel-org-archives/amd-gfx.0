Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241EBEB64DA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 18:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ECB710E3AB;
	Wed,  5 Jul 2023 18:41:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5394C10E3AB
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 18:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6BbAdHPG5U4e7lPPuXPkQufDKKDdlXVp/NvvvHjEnsbqj3aLD/5AUZTgzf0PpNW1enNUSdpuYET7IyTi+5hVKKHPzDjYJeE3iyY375JFf4HFmahbwc4lGikWC+LS/IpqEjWOedV+gQ5LlHs6JTorDpD3m0khHxvock12R/LndXnICcnT1zudMDWNEw/Ee7MuB+U8KikjnsLhW3EiWvtn2xRRkpPKjDF8FXGqYO1OGNLPMBc1grmzinKIdIQaRqTz0zrVNltwr+o7d+47Y0hTGdmfjV3FTKCl9w4dp6HfW/ruRSjFVOG2zYnwNsb0bmhq5yZHguoTtmWD2hMcQFayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yOutupuEZXSR3wTqWAz+0uje9AGGsTbZmARNUDPt6o=;
 b=ge+yQo24yBDItnfmb1vsZpuNbI1kEN2K0BBoE8Epfog7+3sZ5HnC+lAPRWpBOmdO4C5nkt/5nuFenefrxVyhG6yRqERzbXbOMSQo1GMaNuQyJrDJ3wpSnQkyPS26WYDEPQpQIz0vR0nZU54p8CYnQkysCGEyNtv6NcuS7GF4HNQCCY65oMFsQywcDPyHPd5uNCKA0s568KW70BWlBXKV4uc6GqpwQ/eMiWldVml4EHFdyDvSAcdzUuPEUjVQ5iU/R82/x/jWEVGMH70TV4CLt19gNKdM75RtJS5xPCLd0rS57MPbQmuaY1ZpzxqY/xRLuMRDxzY/fl9zRb6S5WZ2Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yOutupuEZXSR3wTqWAz+0uje9AGGsTbZmARNUDPt6o=;
 b=oTc5uNeFQtZYbVcAtyeed5gV5OeBdJqa8VZPN5KnV/VtCJ7CS3DycJlnk+K1FvgGf1j+QUY82I1xINsEcqf58QVvXQekhnmHkZUWtW66nhhcXX7uRHgurgq2zHGZy0xa/PAcUJHHVFHP2vuHgy0XLNfp5rTAbeSsuKFWbBTIECA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 18:40:55 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::68b9:3f7d:ca38:31ba]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::68b9:3f7d:ca38:31ba%6]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 18:40:55 +0000
Message-ID: <6e56e60a-7c44-1fd7-9797-2bf276949c24@amd.com>
Date: Wed, 5 Jul 2023 14:40:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] drm/amd/display: Do not set drr on pipe commit
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230705180752.2813978-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230705180752.2813978-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::20) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: a20792d2-7ee6-4e08-4a4a-08db7d875d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OaH8S+VOll6Gn3dRGrNt0hBzW/Su7iDxNuFowAqvbpQB2XhVEIfCfBPBFUOA/alfm7WDYYtc85RvyKrCEXvA2QhxOIJCmdVWU8zfuhZ0P2utrwaQJnCappRRqGXUemCfSUbOiFI/XrxlUdl1K35Mui5ZMRCurD43urRV2CwlJLZQUHcH626K8kyThx5F7A92V+mDotbqK8Yqpk6EEW/JjrODTzB3dsVPTgHms+OltSUofi16P0zb5PulRKUZ+1Rq+fHr8vqQRKv0ruDvRBFoBlJ3gx8N2I/816lDyz87My30IoE/BEv2U17lgQ0yuRAFt/qY7Dl4lYHX2wHPzRUkJFsAbzJTmqZLLXvQ+KMmR71jibYSAAz22ZOLnjpfdRaPTk8JSCEgvaDLsJAi02Pnq0li0nq5qd+57qeKcztQko2lHtZ/Sa7923UBtcp7un3AeR5YkW8ixsa3X1gt5j4JV1pGeOd2ShM6ozYiIQWYbMy8e86h8kRDxqMZdrgzS8Vx18rEeXPDBtZNsJiL38Ef80mGPXiZPzJiJGkEeqGJ0AdmY1c87NKCvO867OeZC6B5xwIhyVI2Kduyr86uYU7dv/Wk39JsOyPcoV5zFFF4y/L/J/9j2K1HhzEuntBFUbm9gTGhvFBMKICexKDJYisbYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(5660300002)(6506007)(26005)(31686004)(478600001)(6666004)(6512007)(86362001)(2616005)(31696002)(186003)(38100700002)(66556008)(54906003)(66476007)(53546011)(4326008)(66946007)(83380400001)(316002)(6486002)(8676002)(44832011)(8936002)(41300700001)(2906002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODFscDRocXYrYWN4ZnBQOWc2L0F6ZkJkTklKRzhDQVJ6WTlwWDBvUW5kVlpY?=
 =?utf-8?B?VHhTWDBwbFpuTWFEd0ZyWGJDRnJXZXIwbTFCWXkra3BiazVPdkNWSzZ0VERJ?=
 =?utf-8?B?SjhMbmhrcldGSDRuK2pDeFYvUXFFaFBJdWROOXVyY3I0ZjhZaWtuREhVTmoz?=
 =?utf-8?B?elh0d3dKL21jcGlzQUhkVHd5UXB1ck4yWUF4VUpxYmJaZlFFRXBvVFhoalZT?=
 =?utf-8?B?OGZmd3pQWWp1Sm9PTmJmRHp2UTN6YzVUaVlBbXJvek9BWGVMcmVBS1RQMWRT?=
 =?utf-8?B?SUJTeitLeDdNakNHMnVjTFB3N2FwdnlqUEFvK2MrL0x6d1hISmxkSGI2L3RY?=
 =?utf-8?B?MlVlT1hWbWlOZ0tRZFh5L09naE9IaEVTL0V5SW5LUkR2M3l3SStCZkxrWlZz?=
 =?utf-8?B?WGsrdjNBc1RzV3dqdlFTRERwc0RzTzJnN3RUSUNzV3JjU1ZrQTQvK3VsTERk?=
 =?utf-8?B?UjdacXAwSzdVMzZ6Uk9hWnIzTXVHci9maDIzK0xnTy90Q3IzQXIyRUZMRFJC?=
 =?utf-8?B?NVB0VTNWUEY1VG9DbnN6NjhpYzZORHZHbVp4Y0ZmSWcranpURkc1WUFMbGcr?=
 =?utf-8?B?SEovRlo2b0puU1lGNDJoQThmbVFVcGJ2VUZDZ2RrS2VBK2MrTDkzL09vS0FU?=
 =?utf-8?B?cCtXMXl3UTBvRml0Y3BEVUhlckx5VkJtTGN3RnhyTTB3T2FtTXZDYTFDcTZR?=
 =?utf-8?B?YU9XM2Nka3VKK1VrMzJWWnVxTU1KRGxWY21wSHpqVzhNNWIzVk44Z3NpNVZ2?=
 =?utf-8?B?M0pjRS9JMlRxVnhpZ0ZIWWg5MS9vRVRTL2FWOWdhWEFEbjRQV2FhdjdJOUdN?=
 =?utf-8?B?OHM3R2pNT1ZVN1cyd3FxZnd0MWIwb0UrVS9XOWI0YXZuMExjT1oyQTBrdDVz?=
 =?utf-8?B?NG4wSzJSbTVHUlhsblZjNTZQUG41c3FGQmpwWXRvMzMyNVU0bzFhTGc3ZFY5?=
 =?utf-8?B?c09pNllvY2NhOGRQYzFYVjlGRzJ2MGh1bWlXV1k1WEYrZ3BpVWdpandMOHVY?=
 =?utf-8?B?eDJrajVrL2tNYTdwZEZYdkhLeGczVStKcTZaWXBuSWU3K0ZMaGUrbEtJeTFy?=
 =?utf-8?B?U0JjclZoaXBoOFM1bjJJV1pWWkRLVDRzbDZ2RDVsN0dnVVdyUSs2QmVYcVlW?=
 =?utf-8?B?Mnp4QlZ2TDgrdFdmdFRFeXE4eitsNWtRMjNyOFFTSDNDMTFZWFlENHkzVTJo?=
 =?utf-8?B?M0kwTGg5Sm5IK3JmZ1kxd1E4bkRBN0Nscy9BYnV1N2h0c01xVVF4SjYzWDV2?=
 =?utf-8?B?c3NMK0cwa2g2ZXhwTXhzNHd2QmN1b1BZbWMrYUE2bmVLeHJGQXVmOXNtYXhW?=
 =?utf-8?B?SzUzdUd2MTJmdG4xSSt5cXNjY21ITE9EN2tZWDhiTC90WXhFUWxoSi9OVWpt?=
 =?utf-8?B?SGZiaFhQcHJnTjRpQUNxRTh4Sm1jRVJyR2F0Q21rRnZhbE1kVnZwUUJkZSts?=
 =?utf-8?B?eEJpOXNjVFA2eENYRFphYldnK3VmNk9tamlQQ2RLNHdhZVpqUGVRRnlNc2Uy?=
 =?utf-8?B?VlJDTG9xR0dXaEtRYllrNkFPTzl6RmZ3OW5IUkRpdzFiREJLU1lVSEQ1RXhE?=
 =?utf-8?B?SmpudkhtSU1oaElDaFdqMXNwYWtyR29wc0xEQVBTMmpwOFZPMXEvV3VYTGt1?=
 =?utf-8?B?T01CYjlOQ3IwTHA0ZEZCbXlxYTI3aDQrWFROUzUrcU01UmRmWTFVOFFtWHNT?=
 =?utf-8?B?OHk0Rllwd0t2UEpsQ0hHN0hPcDV6eUllQUpZeDRBYi9OMUJ2ZVhsdVUrNXYv?=
 =?utf-8?B?emM4V0NoNXYrTUhZMlBEY2Fjem9BRkt3R0lZby9hVVRHOTlhT2JDN3VqVUxJ?=
 =?utf-8?B?bk8zMVFROU1UaHVnSjlUazdWRGhmVEdjNGFwVUk2NFpMSnNJSUpMOGVRa2R2?=
 =?utf-8?B?N0ZIRm4rRW5xdlltSTJnL1Q3amVRQXhneTIvSWVLdkpEbFpBclJYMUxOamJB?=
 =?utf-8?B?YW1UQ1g2a1hFWTRmNW5OeWdCRm44RitVWSs3VlNac1pxR2ZnMmx6Y0JORjNi?=
 =?utf-8?B?SGd1Tmw5WkRCMEJlNFkwMzJ1dm1GckN2eG9ubnhRNUliNlQ3V1FaQXlCallu?=
 =?utf-8?B?a09oWldlbkVXM3BScXh0eTd1L3gvZW1hOW5TQXlhTURVTTdqSUtEdDNkRlZk?=
 =?utf-8?Q?Epm82YYHGjiuJ4DFBWxk2WsZi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20792d2-7ee6-4e08-4a4a-08db7d875d9d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 18:40:54.9426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tiZp0lDxTISenIMogcS7YzeKirvlFgd8eg0i5foFP8/Y44UDuTlFMXis/8rCkZfKC0m9GhnEhh8piGCQMHebA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, harry.wentland@amd.com,
 Wesley Chalmers <Wesley.Chalmers@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/5/23 14:07, Aurabindo Pillai wrote:
> From: Wesley Chalmers <Wesley.Chalmers@amd.com>
> 
> [WHY]
> Writing to DRR registers such as OTG_V_TOTAL_MIN on the same frame as a
> pipe commit can cause underflow.
> 
> [HOW]
> Move DMUB p-state delegate into optimze_bandwidth; enabling FAMS sets
> optimized_required.
> 
> This change expects that Freesync requests are blocked when
> optimized_required is true.
> 
> Fixes: de1da2f7fe25 ("drm/amd/display: Add monitor specific edid quirk")
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

This series is:

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 6 ++++++
>   drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 7 +++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> index 4492bc2392b6..dba7eab9a2c4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> @@ -2123,6 +2123,12 @@ void dcn20_optimize_bandwidth(
>   	if (hubbub->funcs->program_compbuf_size)
>   		hubbub->funcs->program_compbuf_size(hubbub, context->bw_ctx.bw.dcn.compbuf_size_kb, true);
>   
> +	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
> +		dc_dmub_srv_p_state_delegate(dc,
> +			true, context);
> +		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
> +	}
> +
>   	dc->clk_mgr->funcs->update_clocks(
>   			dc->clk_mgr,
>   			context,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> index bf8864bc8a99..7d38977f09a6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> @@ -951,11 +951,18 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
>   void dcn30_prepare_bandwidth(struct dc *dc,
>   			     struct dc_state *context)
>   {
> +	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
> +		dc->optimized_required = true;
> +		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
> +	}
> +
>   	if (dc->clk_mgr->dc_mode_softmax_enabled)
>   		if (dc->clk_mgr->clks.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
>   				context->bw_ctx.bw.dcn.clk.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
>   			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
>   
>   	dcn20_prepare_bandwidth(dc, context);
> +
> +	dc_dmub_srv_p_state_delegate(dc, false, context);
>   }
>   
-- 
Hamza

