Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E04DC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 19:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB66C60462
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 19:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB66C60462
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 918BD6EE33;
	Thu, 29 Jul 2021 19:23:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A7E6EE33
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 19:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+v8QBmUHvi+QEaVcWRPJnu7LThtkXM81tQt+0XM7h9aCald6EV4GPOqIz16FSGQiFXyvhy3vyPhnxcrug6h8HMf60k91zxU8KDt0BgBnwaxKNwhXkOhV/3akidk5FGHeDwUxlt9aaEORnmlGHH1eR7aNVgd8+tcwMN0D3EBA0EQ9IFaKn3e2TUCxHy9VrmLv8fn6aSknSlQ6pOCWZ7Tv/i+I6BCeQP8W9kG9d8/lgz8sy8hvNBn+bRjAMhcJGisSz9wiyEFRhN87yfI+AlAvtd5S8odRimrsAa4EcH6WCKuXAQhK2Mumx794rQ7XtWCHji2rlF8CamZoA12/aQv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lH5sAl/3tLarNIK3/0Q481rmU/aCvpRMu9fOsNIdB78=;
 b=L6XF0KQi75kYGk8KFqTEHW2tRbd8tZkMoiobemd/PqIijkPkOa0JLRNgPa6FoqjRP7ckMczx6e36EZPSiwx8ArwykxA/42fWZY49QuGqtqAwZToqscneNHptny2Aw90GabTtbtwy7j6ZXuMTBiYROo2TByKtjoA9l9LKM3WxFg7Lg59rXqkLYXv3M9ygWt4sltEaIirwPlbd4KdgkEqkS5m+VoCrL/7QYBoAKeUL7uEo5XTdvF8QMVOQSqG4Dyy39hVuw8m2fRcWBF5+SoQYRMJC9IwD9daNJbP/QyGzhsNw9CTvkKaYFR1G56A1Pp7Q8iiAeGZ9Tx6VzRfyHPgQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lH5sAl/3tLarNIK3/0Q481rmU/aCvpRMu9fOsNIdB78=;
 b=EMnsuSBwM7UaYcDBZY0+DfhWoFkTTkv3+JpIFDSXpEex3IkwTTxpgPzu2kXIjhlDsxSqryN3QfIWWNHvW4rLRWI81cPXU4+VeMd2zfVAHRVJxHvtpTgB/VLl3a+QWLRhbqrbHrZJbGDNVIxqAxgfgwXJOn/0n5gES6hsQEjKi68=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23)
 by SJ0PR12MB5488.namprd12.prod.outlook.com (2603:10b6:a03:3ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Thu, 29 Jul
 2021 19:23:32 +0000
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::384a:ae5d:717:8ba0]) by SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::384a:ae5d:717:8ba0%7]) with mapi id 15.20.4373.022; Thu, 29 Jul 2021
 19:23:32 +0000
Subject: Re: [PATCH] drm/amdgpu/display: protect
 dc_dsc_stream_bandwidth_in_kbps with CONFIG_DRM_AMD_DC_DCN
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210728203518.1460001-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <b635ac5a-dbd3-f714-cb5e-2fdae2042876@amd.com>
Date: Thu, 29 Jul 2021 15:23:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210728203518.1460001-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0174.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::17) To SJ0PR12MB5438.namprd12.prod.outlook.com
 (2603:10b6:a03:3ba::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (198.200.67.154) by
 YQBPR0101CA0174.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Thu, 29 Jul 2021 19:23:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec025b09-eda1-4e9a-13c4-08d952c65a3d
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5488D766DFCD80BDF5ADCDF48CEB9@SJ0PR12MB5488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZNTavU2ce5ppo+cjXxrThtkcgTz9BImusEYySBjDRAA9LUmpRr+USsG9U4U3Z8s28L5o4GO52glT/IutZEtOO4Wp2mxX9+JZtcCxkDWbfqFD888Q8xg2DoYcB3H6dKDxJ61YVe3vA/robtBekH74Vv1hCQRFGi7o3pOdfcxx6neT21e9oOBsaW7vQ95lbA1cCK0/2eirMTh0QrSMY94Aw1ESt8suBovFOs9oBwNrRTMovEsObYDYzsu8COe5lHSl+RKngkKjY1sDCV4pDeJxpvFQuC1p90xr3ki9958QZ5fWOn4HP5XTYAM1zsyQZQzf5oOa1fHNsnL4qiUKFTEysNJF5F5BslfVva7uWLFpxBhQ6I168IV6M2ZFSnaWxvk3PrmJ/uUyOjQdsc5//TX1pQT1K0BgpbVHZ5CAcabXFoostvrZcxIbPLbGnpVSObliBm0NLHanraKHMgiB+stY6aqVC5ca+/dYyEAHa5uxEImkLehTlpxUtCIsHv7CwHRdA88B01Vson5GRjvZq9TeilcdnoLGrSnlMCg4OzXkc+nB/OmRGStZnEVODAz/w+Ng/RQ+HiCpyUQOUkyXljZ0Q/lxasj84kx6agMRo5wZ8Zo2DvXN5qh8MK5DrYbgogfTMXdFZ2mdxGKAFSN8XW3KepxVitsetMyN2j85ZG7GGqUCgDZhO3J7B1sJ1/j33fdUJgTnRevKtznt71Mk98iBwWL6pOsw2CU4nJCu0PFNhnWr+GcZl97d8W+r7kUrYhk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5438.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(5660300002)(66476007)(6666004)(66946007)(66556008)(316002)(8936002)(26005)(38100700002)(6486002)(36756003)(44832011)(956004)(186003)(8676002)(53546011)(2616005)(31696002)(31686004)(86362001)(478600001)(2906002)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnlEemQxQ0JlWUtlVi8vUjFmME52TStKbnE1bnZSOTJCQTF2RXhyUWhwWWJ2?=
 =?utf-8?B?N241VW5NRCttL0tDZEx0WGN3VU53TDVCVE45MEd6WTlORzdFaExvdWFYZkxE?=
 =?utf-8?B?L3F4cmFZS2t4ZjJWSjlGQThnNnliUHFaTWFwNDZqamQvb0JpaVdrdmNBM002?=
 =?utf-8?B?c2lzMHM3dnhxMUwvclk2VkdLaHVCOWUzdHlKZUtpT2pDNVN0UjBqWEtucG14?=
 =?utf-8?B?QzNQSXZNem5vVVBxd2Jodm4wTUY2dkJTRVlWSGtDRzhJcTVuWlpKTFBvc0Rh?=
 =?utf-8?B?OThyeGdPTUtneVBicEMzc21ia1p6ZnBONWZNWFFHRTBQN012LzB3VXM4dVBl?=
 =?utf-8?B?ZXA4ZHhtME52cXJDS0tPY1VMbk52d1lzUHU1ZHpPQVNwS3BlV094Wm5rNFpx?=
 =?utf-8?B?alBjSnp3MDdmbFovSU1ESEdtREJqWHZyQjNrd3JXdGlodGVNRTI0eXhKSUJ5?=
 =?utf-8?B?S2VWMUhWT3pOQnA0TURXZ1liL2hKYytSWWpBbk1sbmIxM3p0d3dvZnZmRTRB?=
 =?utf-8?B?RWlzdHZWUTJMaEhvNjNlSzg5amhoejUyNWFCY0tkT29TU3B2TDlWNkRrbERW?=
 =?utf-8?B?NUlPMERVNDU4dUdkQ2o0OUdHT1AzYnJseVV0TnRiZjE1Q3Z3UjNsVWIyd1pT?=
 =?utf-8?B?QzVIUUNSR29aUFlCZEQ3QVdsNWJnbmxwR3o2MkQ1cUVxaU85dDVJendDUEVK?=
 =?utf-8?B?cWZFOXRINm5ZeHpYK2QvMUMxM21vb3hoc1VwcGJDNW9PeWJUR2xnclNuM0ls?=
 =?utf-8?B?R1FHUnFMcERhdHkyY3VacEhDZFdSK1R1VlZTUk1GZzRtdHRUUE9mNGtPM3Fl?=
 =?utf-8?B?ZDhYZnp4QVUrbkxPOWNaWm1JRGsyTjdGZy9oL3BRdXRqN2M3WEpJeEEwT2Rs?=
 =?utf-8?B?cjFtT1ZYa2hLZnl1NWNKaWhqV0xMcWg0bVpLNHR4QkcwRVpZMjhxUU91djFu?=
 =?utf-8?B?SnU4VEZ1T3V5VGhySDJPZFJCendUTTh6emxDeXgwZ3lBUGxkSU1BTnJ1dFFh?=
 =?utf-8?B?bGM0RlMxRlNRSE4rSTBYL3YrSUhFUnZWT0s5UldieW9tT1M3R2p1SU5LdmUx?=
 =?utf-8?B?SzVHdjFET3hNdHJFYU5QWmlkZUhiRDhwV210NHBmYkdYb3NFeHNMcTc2T0hz?=
 =?utf-8?B?Q2YrRFlyTHpieS83N3RhSEpYZHJnd1pUZiszUENRVFQ5bDhabEgrT2J6SndI?=
 =?utf-8?B?TXpBc2M1RXAxN2M2OEYzY2FwN1hJbkxQWEErSGh2dUUyM0tmMDgxRGltK1dE?=
 =?utf-8?B?VVR2d1ZZS3FVVjk4M2p4Mm9OQ1lVOVRYUm1QejlpdjVLNXVHNWpueXlzTlZn?=
 =?utf-8?B?Q0VrVUxFb2RGdzg2ZFBNbG1SY0k5NlF2VU5CZ0VUYk5sUDlUZkZqNDJDQTkw?=
 =?utf-8?B?YmN1WmNlODAvLzhsU3I3M0FvN2pzMGdJQlZaU1doTU10WDVDY3NPYlZyVkhX?=
 =?utf-8?B?Y3RBM09RMWxrZHh1dW10cE00YlpkdmJPWkpaQlAyY1UzOHpNb1dRVnNCVDNV?=
 =?utf-8?B?UjIyaVpjOGJzUk93ZmZSUXFCZ3lycjVUUk9ybUs2UDhVUWs0RjYxYlZpQWpJ?=
 =?utf-8?B?TjRBaGJZVW5UQ1l6dXFqQ3M0K0NBTEtZbjhqekdITkxDcGNreHZYbStGNXQz?=
 =?utf-8?B?aFlOQjNJRW42T3EySS84M2RLU1VHSUNJaU4yeG5OZThZMlJYRmVIdGlUNTky?=
 =?utf-8?B?MUxrME1kc1lxRERMalpQeXcrc1prY0dhWnk0RmdlS1dyUjVDcUFzN2dsc0FZ?=
 =?utf-8?Q?MRGNhQCckQCcizasvK2h/g9glA6L41waPAQsGPn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec025b09-eda1-4e9a-13c4-08d952c65a3d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5438.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 19:23:32.1675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gch1CUpkcKtU9GSDENL+dymQL6kbXn2/bKFXO3SiJbsAH+1075ze8P7Q5azpC0/b4TGF/icXpfLvyxFn8Vb6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5488
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-07-28 4:35 p.m., Alex Deucher wrote:
> It's only used and enabled with DCN, so protect it.
> 
> Fixes: b6b76b0315ed7b ("drm/amd/display: Fixed EdidUtility build errors")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 5be9d6c70ea6..8bd7f42a8053 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -3729,11 +3729,13 @@ uint32_t dc_bandwidth_in_kbps_from_timing(
>  	uint32_t bits_per_channel = 0;
>  	uint32_t kbps;
>  
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>  	if (timing->flags.DSC)
>  		return dc_dsc_stream_bandwidth_in_kbps(timing,
>  				timing->dsc_cfg.bits_per_pixel,
>  				timing->dsc_cfg.num_slices_h,
>  				timing->dsc_cfg.is_dp);
> +#endif
>  
>  	switch (timing->display_color_depth) {
>  	case COLOR_DEPTH_666:
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
