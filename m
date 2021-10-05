Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7152EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 15:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423296120A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 15:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 423296120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2B3B6E408;
	Tue,  5 Oct 2021 15:57:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 183E36E408
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 15:57:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTG8t9ODux3sj8CpsucYKGIhyfYaQdCW5Ix61VwJnkh1oqQ7DWfcDoMjjPVWgBiLSxh7OAxt9amHNVbYgK4e4G79BwORKakFrbW3mfZSCv2QwsD/5sCheeCMrePwNZYSHNjJ7pOkEdFTVAuTEFys3R79SohfpVOEiIYbd5CO087vNqN/WaqQ+wV9AOrovIb9IgEqv9i/Us76y/IkCLkgbH2mlcMbAj7hh/HA2Qd7EOc36TpKwmM2iF0MVFPgqnIXfJ0fklTv/7lZJUObhVtGaW00ch0UyYJqJzAFXYDIfOwaNrwGBuZQPfk2JeAnC2GvhzPOnszkv+6DdatoXr6A1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVg1NOBTex09krCoMvbcwdQRsEbJnBkz8aBBEOhnxgg=;
 b=XFHiwtz35dPIPIL+dzSQmzRTMdvHoAKQ9YXSUDPgbHPZXx47J4S9xSltkE1EMcqmT3B5I/iS4Q9yP5CUafXL71a9qex5VKERdlCy3LEmSXWwxwHQ3PjNX7qViUcIb/CdfipE/phyfuIn5hndZgS/4D0zhsLof3zdtPWCvh6k3kMpN6I23Jgzi+SJCwmx5dzcJWZvty3NNrrpnQA8FfW3GN8GTXW7ttAtB+gMZEwgCDO/V/9V+sp+oXal9Q7v0EitrCG1ysrLwAzzjG/jA3Q34He3QDUonWoYa8CQclm8i6SzBLrWivfzBVe6zQvIoCM8261u8fYLtsdwxk6zb7ReFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVg1NOBTex09krCoMvbcwdQRsEbJnBkz8aBBEOhnxgg=;
 b=m918/Lo2DNic5dYBJ1QVl5Vb1O4pAuIYZIzUclzfKQUPPUyAErgkKZCdO+Y4vCl+kfLm/nNWcgTqWZ51q8kFMAyzYUG2FsuFp5frk2FfIzxzkK7ii8tC/AwudNOVPDI+pwRmsbFOPHxfigwDOlJ6HKf8fyj+DbiQLSTd9jZOiD4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5426.namprd12.prod.outlook.com (2603:10b6:5:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 5 Oct
 2021 15:57:34 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 15:57:34 +0000
Message-ID: <bad6931f-b976-1129-35f9-20be019df900@amd.com>
Date: Tue, 5 Oct 2021 11:57:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 06/23] drm/amd/display: Support DP tunneling when DPRX
 detection
Content-Language: en-US
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, nicholas.kazlauskas@amd.com,
 Rodrigo.Siqueira@amd.com, stylon.wang@amd.com, jude.shih@amd.com,
 jimmy.kizito@amd.com, meenakshikumar.somasundaram@amd.com,
 Jun Lei <Jun.Lei@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
 <20211005075205.3467938-7-Wayne.Lin@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211005075205.3467938-7-Wayne.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0765.namprd03.prod.outlook.com
 (2603:10b6:408:13a::20) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.46.98] (165.204.84.11) by
 BN9PR03CA0765.namprd03.prod.outlook.com (2603:10b6:408:13a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend
 Transport; Tue, 5 Oct 2021 15:57:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6f1a81d-ff58-4214-4702-08d98818d81d
X-MS-TrafficTypeDiagnostic: CO6PR12MB5426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB54267E29714F9E2C1476284B8CAF9@CO6PR12MB5426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8S+4+2MwCm9SNa8QHcNuvI1GfULxISBAUdR95YvIIyiHUTRFn3SXXA7K0XW5GJNY2TjXDo3emwobzI7ZDF2w1RaoavsQVTIc7Qb9rd5Y9QDwlN2w2Gn+O1zAb5Um4+NUKThs/fMzQfVtySwRRDk8AjP+4CeTsyoiw33B9icJujikn6Dc4Qe118zgrTorWDd02e3Bmhp+aVCCwjjTkY0VRJ+BsQYlITpx2S9Vd/vvoZNHng/5yQcLCgwSEoKI+4igY1eaJFYziaaLEA6QVCZ12KJo77EolMrWxbLJBW5e5c9W0ddOvHa0Bnvya00vO6GXsCh51oNOxlxjF26yNKs9BaFl9LCHAcffu/vfK/leS0l5W30zkkegkh9Bk9EjFxDrT7tTrQIgcHXEZA2gLw1jSrjoN9yIZjfOwZfOGkphjyrVNrp1mCasB/5pTeWEL127NzH+ss87FQWXRCDkVe4wgDlrHmo9OVPM0/fuWRJt4l3dv6dvo8JaaxHDrVh7Rj9cg2zT/822Rh43m3VuK1PbyNvhRuP166U4UZkTE18w2ih9WLPth40J7r5BrbQCTlPS0uBXJVVPxkPlY2ZO7z8WI34qDQZXgAi4vebnskbcAPrfh99FGOQk3xvYJu8SEY0aIKty3pswLNgGhYVRUZfX5rAEJA3lm5eh6PP6zLo5fU3oq/6ZVaUbqTQ044oWhjudpvbktI8752WXKFSBrpvq9loN7HpE6z5raHKEv45N6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(66476007)(6486002)(38100700002)(86362001)(2906002)(66946007)(66556008)(5660300002)(508600001)(4326008)(8676002)(956004)(83380400001)(26005)(186003)(2616005)(31696002)(16576012)(316002)(36756003)(8936002)(53546011)(44832011)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjFjQ1Q5bEMzZVNsUyt0Y3NDVWErcjNnRFpsbmMxdnJoMFFqUmVnVWtWRWdD?=
 =?utf-8?B?UUd4S3JLNTVBMkdwOFB1MFpneE51V2lOclFLTm1XRjVPVC9QY2cvbG93Q05q?=
 =?utf-8?B?UEVTUWYxRWdSZis0cDJqTmFmT1NabmNPUTdoMndkOHlEb1hua2JJdjRXV3V5?=
 =?utf-8?B?UExtVWJqQkF4WVcra2J0TER0QnJTb1ozbXNpbmpYbG9tWXo2VGl1Uys4WnJO?=
 =?utf-8?B?MFJpVnZ5ajlZZTZNTzV5SWRJNW1aSjBUaVRUbmVucEZzaytnbUN1Q0psQWlL?=
 =?utf-8?B?R3laeXp6UUhKZkhLUGpsU3M0UXZWam5ZOHJSSjhHeDFBNDk4SDVSRHcvVkho?=
 =?utf-8?B?MVBFR00vWm9Yd2pMK1YvMVhXNWpKbHJoUDVqTDM5Rmd5RlZINEUwa1NqSWpW?=
 =?utf-8?B?WlRuUHEyeTFJajlIck4rVTZnV3cvREJaU1RJSVEyQWkxc3JYVnBMTndjN3hD?=
 =?utf-8?B?WFZPOW5waDZDL2NIOTdXMWw1UllGWSs0VzBzWkpYUnZVWnhMRkRpRTVCYW9X?=
 =?utf-8?B?eXY3RHRIU0VpeGJyYmVRdWxpeHR1TUNmeEhxdnR0TDI1OVdHVC8yMEU4SWtS?=
 =?utf-8?B?elo5UTRSTXJVcm1Uc3ZZWTJvTFRNeFU3WFB6UjBSSFFoT3l2OU1YV1B5bUE1?=
 =?utf-8?B?UHAvNk9UT3Y2SjlGb0ovTXk4cXUrbVQwazRJQlBIWk5LMEJ2SGRRaHdHT0JP?=
 =?utf-8?B?YndseFRMc3dYTnFudlllVjMwUzIzUUIvTnJ2T25GdklLZWMwRnQ2NjhtcE9W?=
 =?utf-8?B?emtYZFVLN20rUjdBNTMrKzk5dmtIRnlZN2k0SkNrWlJkOVpJd252SXdING5p?=
 =?utf-8?B?WTVXQURveHlGTUFyVVdIUVlhUVlLREpUbUJsRjYvSk5UZm94YnJ4L25TY2lG?=
 =?utf-8?B?Q0pKM2FFUk1EcmpyNS8wVUNMR2FHaFNUYkxWMWswamRFblFDd2tpNitrSHkv?=
 =?utf-8?B?UTUwbVZOYWYrK1BLa1k3UlVHYnFudXh2eUZKaUlBeWNPVURSRjFiWkZCamh1?=
 =?utf-8?B?bmJ6MjJINHlZRXlFbWQ0SW1ya2txbWtUK1hudGwxdWVMNVFEbWVXdkNUUzFa?=
 =?utf-8?B?MmpNYkZqSzFCUWdLU2NINEF5aE9pTUJKWmZod3JkUFo1SFlZNExQZHcxT2xp?=
 =?utf-8?B?ZSswV0ZBRTBBbVRKVk5MYWppSFhmYlNXemJJejl4YXR5RUllZ0dmanF3cDhW?=
 =?utf-8?B?azlkS3EyWVUzd25qb1pzTUpEU0NiRmljdm9IMUU1aVZFeHJ0RDZ3bnQyQW54?=
 =?utf-8?B?WEZJSVBLSmZZcGovVDNOelkydVIrYkN1SXZoSzROYnpvdE5nS2Zuci9wZ09l?=
 =?utf-8?B?S05SYjRMNUFQOE5OS3A3dVluRGlWYUdWMWNzWS9BTlFUYWc0TW1WamdtRUU0?=
 =?utf-8?B?d2h2aFNqNWhPL0RKbmtrTlJVR0h5TERXcjZwNjlGSnp5OENUbStVR1B2ZXpt?=
 =?utf-8?B?dFBnSzJqaHdCUXJ2d0RMVENtb0ZpRXhHMytMSkpkb2FaR3o1NVkxc0wzekV1?=
 =?utf-8?B?YnR4Q094TG01ekYxZldSdi9oNlFqTFcySm9RZVRQZ250V3JBbG1Oa3VzUlFs?=
 =?utf-8?B?RGljeXBDYzIrbE80Y0tqZnFZMWV3eENkUGF0dDRSS0NEcFhyLzdSdUUyaHha?=
 =?utf-8?B?eXpMYjVoODNCZUFiUVhXdVc5K0RYQnZKdklTM2dWQU5lZEliMk5lV1JqT3hF?=
 =?utf-8?B?N01WMitZN2RMSHpKOTUxejlMRGhnb2IxcEZhdDdleTU1ZVp6TVVxRXJxSjRB?=
 =?utf-8?Q?7N7Oa0LAhrg4Je7hS5J4guC/afIaCtmXSbiPnJs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f1a81d-ff58-4214-4702-08d98818d81d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 15:57:33.8594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEYwMU5Uzpnl5i2hxxaaEyXw4jt8giIzk7+dr4IV1SkdDnL7PfNFEWQgQixTTBPSo98+vpiKvU6cVDor7wnK6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5426
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
> [why & how]
> Add codes for commit "99732e52e7f8 drm/amd/display: Update DPRX detection"
> to support USB4 DP tunneling feature
> 

This patch does a few, seemingly unrelated, changes:
1. Add stub for getting tunneling device data
2. Add check for phy_repeater_cnt < 0xff to LTTPR check
3. Add two more bits of information to DPIA links

Does item 2 have potential to change existing LTTPR behavior? If so,
it might be better in a separate patch to ease potential regressions
in the future. Probably not a big deal here, though.

Suggested title: "Add stub to get DPIA tunneling device data"

Suggested description, something like:
1. Add stub for getting tunneling device data
2. Add check for phy_repeater_cnt < 0xff to LTTPR check
3. Add two more bits of information to DPIA links

Harry

> Reviewed-by: Jun Lei <Jun.Lei@amd.com>
> Acked-by: Wayne Lin <Wayne.Lin@amd.com>
> Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/Makefile       |  2 +-
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c |  2 +
>  .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  4 ++
>  .../drm/amd/display/dc/core/dc_link_dpia.c    | 34 +++++++++++++++++
>  .../gpu/drm/amd/display/dc/inc/dc_link_dpia.h | 38 +++++++++++++++++++
>  5 files changed, 79 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
> index 520f58538364..1a0e462bed42 100644
> --- a/drivers/gpu/drm/amd/display/dc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/Makefile
> @@ -61,7 +61,7 @@ include $(AMD_DC)
>  
>  DISPLAY_CORE = dc.o  dc_stat.o dc_link.o dc_resource.o dc_hw_sequencer.o dc_sink.o \
>  dc_surface.o dc_link_hwss.o dc_link_dp.o dc_link_ddc.o dc_debug.o dc_stream.o \
> -dc_link_enc_cfg.o dc_link_dpcd.o
> +dc_link_enc_cfg.o dc_link_dpia.o dc_link_dpcd.o
>  
>  ifdef CONFIG_DRM_AMD_DC_DCN
>  DISPLAY_CORE += dc_vm_helper.o
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 66182b8c217b..1c397d5551ba 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -1726,6 +1726,7 @@ static bool dc_link_construct_dpia(struct dc_link *link,
>  	/* Dummy Init for linkid */
>  	link->link_id.type = OBJECT_TYPE_CONNECTOR;
>  	link->link_id.id = CONNECTOR_ID_DISPLAY_PORT;
> +	link->link_id.enum_id = ENUM_ID_1 + init_params->connector_index;
>  	link->is_internal_display = false;
>  	link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
>  	LINK_INFO("Connector[%d] description:signal %d\n",
> @@ -1733,6 +1734,7 @@ static bool dc_link_construct_dpia(struct dc_link *link,
>  		  link->connector_signal);
>  
>  	link->ep_type = DISPLAY_ENDPOINT_USB4_DPIA;
> +	link->is_dig_mapping_flexible = true;
>  
>  	/* TODO: Initialize link : funcs->link_init */
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 4df71d728319..9bc5f49ea2ec 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -36,6 +36,7 @@
>  #include "dpcd_defs.h"
>  #include "dc_dmub_srv.h"
>  #include "dce/dmub_hw_lock_mgr.h"
> +#include "inc/dc_link_dpia.h"
>  #include "inc/link_enc_cfg.h"
>  
>  /*Travis*/
> @@ -4582,6 +4583,7 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
>  
>  		/* Attempt to train in LTTPR transparent mode if repeater count exceeds 8. */
>  		is_lttpr_present = (dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) != 0 &&
> +				link->dpcd_caps.lttpr_caps.phy_repeater_cnt < 0xff &&
>  				link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
>  				link->dpcd_caps.lttpr_caps.max_lane_count <= 4 &&
>  				link->dpcd_caps.lttpr_caps.revision.raw >= 0x14);
> @@ -4630,6 +4632,8 @@ static bool retrieve_link_cap(struct dc_link *link)
>  			LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD);
>  
>  	is_lttpr_present = dp_retrieve_lttpr_cap(link);
> +	/* Read DP tunneling information. */
> +	status = dpcd_get_tunneling_device_data(link);
>  
>  	status = core_link_read_dpcd(link, DP_SET_POWER,
>  			&dpcd_power_state, sizeof(dpcd_power_state));
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
> new file mode 100644
> index 000000000000..183601e300fe
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
> @@ -0,0 +1,34 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "dc_link_dpia.h"
> +#include "inc/core_status.h"
> +#include "dc_link.h"
> +
> +enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link)
> +{
> +	/** @todo Read corresponding DPCD region and update link caps. */
> +	return DC_OK;
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
> new file mode 100644
> index 000000000000..8ed0c9f6414b
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
> @@ -0,0 +1,38 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __DC_LINK_DPIA_H__
> +#define __DC_LINK_DPIA_H__
> +
> +/* This module implements functionality for training DPIA links. */
> +
> +struct dc_link;
> +
> +/* Read tunneling device capability from DPCD and update link capability
> + * accordingly.
> + */
> +enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link);
> +
> +#endif /* __DC_LINK_DPIA_H__ */
> 

