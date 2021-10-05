Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F22C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 16:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2504A61264
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 16:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2504A61264
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6CE46E42D;
	Tue,  5 Oct 2021 16:00:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A99E6E42D
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 16:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wt94Be7kjJ4HHGzH4htVK6hpBYWWWh3Kl602Mux/E+IuF3H+ZpgharkVzQ5BtkONFfoTSHHbgIraiJB4B04NRx4ZgScxoUvu5dN5vdlZfcr/RxH2UU/69ORv8QetAPXNfT5fZPsZBalqowym7nCpXphzGSvvYKe8EP6YyUvtfQ8YTM049dJPg0LzikOzNWhMuTAsZqgaN6PP9jloMLxi1PoiNwdV5nkqlxfHdw7Go8j7ysqaisN1eA/QqoYzz2E263MncENVJAtktqK1AzU4m63csBIKF6sC/rg+TU8G9zSWvr0d+ovgSV0qUDhX7r7z7syxs1e/yRyc8nCIzQyAlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfeE3bn/hwU/JaWEHZ1YTrte8mkJLZD9/iUth8zv0Es=;
 b=h0qKEJoVLmBb91qXPASdJyTQDI8LIsuC5feqFZfoqzh0OEgs+ep+1Zq81pNRzW4xo++y/a6sDl5yFSg7kjVrjRn1z4UkHC5WWSWtiyjXjAH+qOzGeBA3PZe1FEDajFIGPWjtdq9jBg+OHM3XatannsO12GKqWmshqvdtEGT0kSgfLbQDLhiB2bpFswSR94arwkCdUpWHQfItklOm/iHzL9UiVcoqFJBsgV2I6q8yWcqOz5MNynbG8h4FYfCxeRnx/PMPVonpCKoC7tLh6FwpL3yv75ip9UrQK1cOqKOdn13GmMAlOy+4+fFX6Ag7ZWrAc/Qo+8zeEiUMSLqeJKzeGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfeE3bn/hwU/JaWEHZ1YTrte8mkJLZD9/iUth8zv0Es=;
 b=u8am5I5D7FMiF6mHA+57DWtHHaH7Rfyk9JVJimD+PWeBVMkueD7p6Pbhegje69Fsr4lvNvoB8xPrXh+S03vaD756ZzfZ/um/OBeqxx3t5C1RW8lI4qW5bmulyJYo6hDFM9YndlPFs4Nb+tSKLkQUH/YExh0GEfZi0/YPEgYLlAA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5490.namprd12.prod.outlook.com (2603:10b6:303:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 5 Oct
 2021 16:00:02 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 16:00:02 +0000
Message-ID: <5bc240bb-ab20-2670-7d74-175dba72eb11@amd.com>
Date: Tue, 5 Oct 2021 11:59:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 08/23] drm/amd/display: Support USB4 when DP link
 training
Content-Language: en-US
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, nicholas.kazlauskas@amd.com,
 Rodrigo.Siqueira@amd.com, stylon.wang@amd.com, jude.shih@amd.com,
 jimmy.kizito@amd.com, meenakshikumar.somasundaram@amd.com,
 Jun Lei <Jun.Lei@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
 <20211005075205.3467938-9-Wayne.Lin@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211005075205.3467938-9-Wayne.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR12CA0029.namprd12.prod.outlook.com
 (2603:10b6:408:60::42) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.46.98] (165.204.84.11) by
 BN8PR12CA0029.namprd12.prod.outlook.com (2603:10b6:408:60::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 16:00:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dcedb24-19cf-43e6-93ca-08d9881930cc
X-MS-TrafficTypeDiagnostic: CO6PR12MB5490:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5490C371C292F028D7BA1A098CAF9@CO6PR12MB5490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+0dwYV3HsCIhpvKMYoyaqFp+GrBO4wcq/h9wR+W8KMqlWktiKcM0SrkyHOQ2VUKD1a5rob6lcJQ8PD9LH+aykkFTHzmRLvnvWkSuwTdllhcdlxMK8bTjFkrUM6qdi/EycPsKl/wBNyL8s1yG6+2vt5/aVZb/KD1NggVM0lKql9GDkeNrlw17mTIzlNvTENvwrFfbE22y3R9V3/5nmQdSovXr6G0mgvWs+o0Y5CP/6BSjWF/LSKRruP9TUcb1smseSb1CGKTAcsVXI/ZQzh39ysn5l8/yOyXhFxdNhLt+IDoVk+8dE4Z8DDG1zi00DWYck4EzAlwC8ci2AC88dRN2yG85U/i3CzJ8DNShDdcmJVW/ycpduwovAsm6pXPXpC0MjOK9IzKBgqpQzDxpDyWbVouEVVxGvVFjn+gfjSXMa+BvSPORQuRG5u9MN8uB5re9hHhMMWkai7cumt+LlmigEQ/aReozo1keq4D80abnYfoE5jEq57s4L6rFPAGHufQKxoUPt3g6bfDNADsykyuK5U7YGJw9FvurU1Aro7Js/UXn8oBBxLDoEQ1lA3XpEr63+Tnf2MBT8IkMznr9xSIwvvzQ3lWcJis63tFmqxtHhcPHE7dhmuI0yUoDoHeKBgv8d+bJozUJjmSuaUV7qwtNSkUR8zbQEe5oA8+fqkHBxaGu/S8EllLUaqSsmheNxnSXsYzXE/jxAZ51F4a7HK7rkGYnwHjFR20Hv1KvydqXtI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(956004)(66476007)(66556008)(2616005)(6486002)(83380400001)(186003)(66946007)(4326008)(86362001)(36756003)(2906002)(31696002)(8936002)(8676002)(44832011)(53546011)(26005)(5660300002)(16576012)(316002)(508600001)(31686004)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmlrRGFoSmtTbWxHYWlNSzJkajRVaHc0aXFJcHY5bmhXV2xsMkw2cFFNZkZW?=
 =?utf-8?B?b3NWdTRPQ2VWL1pId1pSb2YyMjJ2QzR2bU81dDhFTGpUSlgxTkFrdjdHZFl2?=
 =?utf-8?B?RjF1VTFXSmg3SkY1YU52K3owNmJCZ0ZGWitmSUg5VXB0OTBMSllOLzNyT3RE?=
 =?utf-8?B?Z053bGhVa3A2WnlmcXR0Q2VsdXRKNnR0MjFhK0VTYkw4eWVaaUdEMnlkZy9Q?=
 =?utf-8?B?WnFiUzZybVVvYVhCR1dPbzkxM09zZnFTc1JJNnhGNFRpdDY4cFhUeE9tZkJw?=
 =?utf-8?B?RThmamk3M09GNUJsaVoxcmxPQVdacmpVaEVmMEVPOG5wSzBDU2NrNUd3MVQw?=
 =?utf-8?B?dWJkbCt4UHc3SHdDYTEwV01hdzU1cXF4UGFhcW9Eb2tCMXdSK0VrT2F5bmpi?=
 =?utf-8?B?MG9RQlB4NC9SKzNSTmlBaUJPUnQxRFJndkZkWE9VU1lqaGVzWXZQdnRIS0du?=
 =?utf-8?B?YnNPdElCenl6MTdjbzlHSmN0QUhBVzBudEpFVWR2NWNmRkdTNHIza3hGaU5x?=
 =?utf-8?B?MXYzWEJPUmQ5MDNjV3lWeVhnMWg1WlhIQTNBUDJpNWJnS1lrQkQxQTg4dWt2?=
 =?utf-8?B?aytiMTJKYWpMbURPeEtLMFlaYTJBbUtMTTVKUVRzVW40U1NGdk1GYTh2MTlX?=
 =?utf-8?B?ZDRGWVJxb0RxdEpxUjc0RzU3QkVmNUxIMkgyYnNXVUYxTE1WNDBlcnVIMEtD?=
 =?utf-8?B?N01EOFNiL05xbTRQWWRKUHJETlM5VzNaRFpXVWNtR3k1c3d6b3ZLNjYzYWtp?=
 =?utf-8?B?UHdBdDFjUml5dE5lNm16b2JOZzVCUEdTWWJnbDNTRlIvbXFXTmFqbU1uTnpF?=
 =?utf-8?B?aFZtYzFKcFB2SE9FZHRWckFQeHozUDhicllZSXViY1dLTXlWdzdmVzJFeERZ?=
 =?utf-8?B?SmdNa2ViTnozdCt1VHpORDFMYkgyZVZodTdxRU1VYVVmM1RWaGxPdDBpRUdm?=
 =?utf-8?B?UXlPa1ExbTg0OVpSK1pkNFhFc2YwWUVjNXVEdUppT25mcHowTjJhaFl6azk0?=
 =?utf-8?B?S21QQ1V6MEJVSU9FYnRTanZtUDBqbkNUbUlNUnRrRnl2aTVDTmZ5dUpqa2RU?=
 =?utf-8?B?aW0xS05iVStwcFNPZ09zZ21NeUJWR0xGZFJyT3ZyMXhWWHVBeG5wdGVudXlV?=
 =?utf-8?B?MXZ3M1I2RXI2RTdaVDBVRFpuTENwNjRrVVlkbnlUMGFVY0ZUY2EwYXlGSEtj?=
 =?utf-8?B?R2xtdnZVNzVKVnRqL29LLzEydTlkOVBGUFlCTWo2STBlbUg3L2w4Z2lKUmoy?=
 =?utf-8?B?TTl1SE5lUnNhaU5MczBFQ1BZM2tzSG5KR3p5WkdSSk5uaUJDOVBoci9LNGxP?=
 =?utf-8?B?dXBXSHdOcG44THpLWTFVUFV2MFpxQlcyT20xOVNiL294U1FaQVpxT3hzTHg2?=
 =?utf-8?B?Z2c2Y2NyQTNzWlQzem8zYXc5UlppVnc2WTlocWRTT0FLRng1ck9YNXo4akVj?=
 =?utf-8?B?REIwTmlocGtMZFBSZHFMdzZyaGhINjRPdXlNcU12dmtMU25Tclp3OE1EeWov?=
 =?utf-8?B?bWZOSDNUOVAwUjdUQ0swRmFMelZvSTZDcGtOMGM0YXdiWGtnMEdlR2ZTRDdN?=
 =?utf-8?B?d3FxUEFicTZ5Vm10dS9RUUhleUxXWWc1dXlkb1B2bGw0aVR2ZGFZRW1INVEw?=
 =?utf-8?B?bUFBSUNBTTJCWUxib0JDdWdIQW1tdGpRYTg1SzJCTlVpc1dwRmd4QUFlM0t1?=
 =?utf-8?B?NUxodEpER0xQUGlTTFVHdVZ5dlFsNTBqRmxXemo2MktjeHJ3RFpSZnViVGQy?=
 =?utf-8?Q?JKvuBLZx0eybHtLPf28vucjg3THMlYnruMMQtWJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcedb24-19cf-43e6-93ca-08d9881930cc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 16:00:02.6239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHb4qvWlbloDLqI1msY3tKeUjIxaognem7Wrr8L1prR3IwpZ3VUjHiv7f2X8BDa9DenaX2NiPCCarlfjq4SG4Q==
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-10-05 03:51, Wayne Lin wrote:
> From: Jimmy Kizito <Jimmy.Kizito@amd.com>
> 
> [Why & How]
> Add codes for commit "822536713066 drm/amd/display: Add fallback
> and abort paths for DP link training" to support USB4 DP tunneling
> feature
> 

Suggested title: "Train DPIA links with fallback"

Harry

> Reviewed-by: Jun Lei <Jun.Lei@amd.com>
> Acked-by: Wayne Lin <Wayne.Lin@amd.com>
> Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c    | 6 ++++++
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 1c397d5551ba..6b5ddf0a29c1 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -1862,6 +1862,12 @@ static enum dc_status enable_link_dp(struct dc_state *state,
>  	/* get link settings for video mode timing */
>  	decide_link_settings(stream, &link_settings);
>  
> +	/* Train with fallback when enabling DPIA link. Conventional links are
> +	 * trained with fallback during sink detection.
> +	 */
> +	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
> +		do_fallback = true;
> +
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>  	if (dp_get_link_encoding_format(&link_settings) == DP_128b_132b_ENCODING &&
>  			pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT) {
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index dd1d0262ba40..d7dddc0998db 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -2408,9 +2408,9 @@ bool perform_link_training_with_retries(
>  			dc_link_dp_perform_link_training_skip_aux(link, &current_setting);
>  			return true;
>  		} else {
> -			if (link->is_dig_mapping_flexible)
> +			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
>  				status = dc_link_dpia_perform_link_training(link,
> -									    link_setting,
> +									    &current_setting,
>  									    skip_video_pattern);
>  			else
>  				status = dc_link_dp_perform_link_training(link,
> 

