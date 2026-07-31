Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EFEC55173
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 19:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D86D910E22E;
	Fri, 31 Jul 2026 19:55:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vaj5E+Qc";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3454210E22E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 19:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbvIbasWTrK3yeuaDM8cBzX0rlxDMhzbl7+lsCLR5jXgTkJtTriHhytgi5LL+6LU/s9jBElUPUDP24l5DMsj4uujjYqv1dhbojBhCR68DOD6MmXRrHKrVNhjl0O3kFYEoltBP9yxd5fl1D8tnG9OKhuXloZ7N0Bb1/+wRpG8qTQz8aaDYsEzssJgzXGQW7Y8HeifeL0wHiJmU1ohbYR2sF2GELuY0YeFWMvugNdumjqsgHefolOZDRbsdmjCppUCizfiHHqXhZbCyKYxMYZ9gGAYjIXE2MXzes2VByND4ChPFV1LFFuAeXgdNMIcpsyLVJYnSACeDyGWzG6Z1Sb1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmCLpCvG0xocre2Kdy9eTZuCvk5wfdZH+pXukgMbJjA=;
 b=T2OAQdyYe2oMDoUzY0oJRIt9ngPODod6M6bkOlpD1DVmDYesFDqgmsQOW6yqs9p6KoAVmkk9BNgRrzOmJQBXEq/kh1O65o54UNC4YbMow91Q+ZhX5zAZl89HfxBJQ5Y3QWCSOOX2JCYEfWzsIAe973Wn3sFCoPvam7bVKCBsYBVwTULw7dvgXS3PKd49ImV2qIWNbm/UK+6mwc9FbRu28NiOgnx+x1xKrogpSiadNKvlXtR6gLGDkNJVQcOQI6liJQ7AxtKUqZ1w7OwoQkO4y6LAJcp9QyRwEmK/B/Zs27rks535wsFuschbbiUlZNY1txybmk88n9hHgcxVxV+C1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmCLpCvG0xocre2Kdy9eTZuCvk5wfdZH+pXukgMbJjA=;
 b=Vaj5E+QcSnFnNpKrJ3f/KevyM9EPfhAOADk/arh7IbQ7jfcn7C7eo6oNGHGPEYsqco7cKZnaMNiwXkbU6OonRjkumnveYVOnOqmY1CZy/wpbcn7KWCh6ctS6faBTiItuKeL6PUmJO2ci74Dj9R8tO4ADLravOkpttiHISjonShY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by LV8PR12MB9082.namprd12.prod.outlook.com (2603:10b6:408:180::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 19:55:07 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 19:55:06 +0000
Message-ID: <b04842fb-cf3c-4681-9a03-6bce7d58d2fb@amd.com>
Date: Fri, 31 Jul 2026 15:55:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/edid: parse HDMI 2.1 gaming (ALLM/VRR)
 capabilities from HF-VSDB
To: Fangzhi Zuo <jerry.zuo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
 Bernhard Berger <bernhard.berger@gmail.com>
References: <20260730171754.704049-1-jerry.zuo@amd.com>
 <20260730171754.704049-2-jerry.zuo@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260730171754.704049-2-jerry.zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::26) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|LV8PR12MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: a27579ba-33ef-4d77-2e68-08deef3d9ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|56012099006|5023799004|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WvCoTxiu9Ubrlftiz447pUwVdxyuVkgvS34/c9vpw6jSeR7svY2Bhq3pzPI8GY24dyABIGApSf+qa7o4UoP9PJjuI+C7WIhcSeEFbf43OryNEXdr81ZC3qgeH2DZpZgm8+kFkXTrs72+Jnfap9P/O/odBamy/C7ET2rYZbUWRqUsYFd0J+wivynhec3XbGS6LfbCD+xpjODMRdgIkW7Nxat72eWhjLrjxH743TFKi1ILQNlfL0Y063avtT0U44fJZMHSZcLQxUj/1JYppafL8Zh6VmWqJcFzeuw69YEOhPxxuje+xbbbQJPzqu1r7tDVpOj0zQd6r9bVJ1vkKgucnOANr1SUMaffAPuNtNInulBdrtbEGgr9LW5HcXCGrgU+UUgAE3cSw77LYi2Njh7/O7IMvlnSCqec3q0WtHs1g09FCLSzLTnEOPxyJkHtu2ZnwfrENK1IwjHk8GSmaXqJIgYAiHMakhruEO3tK66NUj+ACZeuJAUTqHBtM28cvtxLbd5gStL5XnTRXsx21kuTI6+oAR4GNeIA9zUQYOCxqle5j+/gCbpfexip02F0av7jRB7jxvJPuJghCV2aEriFTu+gQSPMbPE3sW1LhxBKjsu0uVzLgQkJXV7rvno+aGYKGHXtgRIhlVthYjF5bVlB0L88FDcsB95ESTXzb39x+3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmFtMmtjQmVRM215T1ZKcS9jZVVONWluTExmS0x1Mm8zWDdjWWZsY0JXbkkw?=
 =?utf-8?B?N2N1OFU4eE5Ec0VtTXJxZGRFRXlmZFg0SWJCUjl4Z3NRaWIrSnNNU3JxRTB2?=
 =?utf-8?B?N3Jkd3p6d0hpcFNKWDREMm41L01SdGJya0d1NzR6SlIwOVpqdnhYa3llSDVo?=
 =?utf-8?B?eVdpSmJrcWJ1UGtpd2Q4M1FwbHZRdkgyWXFScSs0NGN1RHNEbGpGWVQ0VUxu?=
 =?utf-8?B?Q3ZSZDFKS3dQZEJEL1ZlaDBZK0V5UmFWemVlYXhoMjcwa2ozSEpwemVSS3RG?=
 =?utf-8?B?VVMyQmphL0dIenRuMlF5NGkyZTFBUVNiWXBsc3ArUldWQjJTaEJHcXVtbnd1?=
 =?utf-8?B?Wk5EVUlIL1Jkd2xVY0UycXg3bTRDcnZvZWgrTmwrVW9RaTJKNXJFY2c0NGMz?=
 =?utf-8?B?b2FiY3hwbGJ4cUd3WFc3aWp6Vm12U1psRHljVXB2Z1ltQU91MHJYOE10cElj?=
 =?utf-8?B?OGVSUG9SRkFFZjhYTUNaUnpjYkVsWDI2REQ2Y0Q5STh2Q0Y5MnBQVk5PQ1U5?=
 =?utf-8?B?TDFTM25KUCt0NitYQThPYVc2RXFXK0FkVmdqbDhIM1hwSjVKd3YzQWFOK2VE?=
 =?utf-8?B?Y3grZGJrRDhtaWxRZEg0OWR2YlZhWmU4Z0xGdk9xZ2tQSGcxMVRJU1VqZnFB?=
 =?utf-8?B?UEhGSUNUVzdjcnNmRmRHdnl1TmdZTE1XeFVET3hEdkUydHFnWk5WaUVZa1hD?=
 =?utf-8?B?OVlwYUw3aVYzaC9MeS9FSGJxTEJoQzF6WlNJQWdCRDViTVV1VkdHUVkxVTF0?=
 =?utf-8?B?NFRYdkpjWjNjbGRtVm9PR2JISWFDd0VxYkoyb0FSb2dJNmtZZDhvWWZVdlpL?=
 =?utf-8?B?WW9KNDMwTEM2bGxhbTRBTzBUSEp1NlhudzdhZnRZanJDa09DWnhVWVhhcjVs?=
 =?utf-8?B?YU0xTWthNWJwUU45L2FCTUdFeUZiYUhLb3kzelBqL0NSencydU95QVo2dVBk?=
 =?utf-8?B?bmJPVUZnK1FPNDNRbzNuSzFZczIvZUJpK3NzcFR3WUl5QkFvU1VSaUFLMFQz?=
 =?utf-8?B?MjJOanYveEVNdXRhdy9EZnhXVlVuYUMxZ0FBMlczMCtzNDNTWjlZaUFia3Rt?=
 =?utf-8?B?UDA4dndjc3VLZ3gxRGZXblJDcG5WMDJiZlFCSXFVbVlWdmRWUWs3aUNobU0y?=
 =?utf-8?B?dHJBQlBHbHkxRTdoRUdIYXlQVjVBSUlPbk9neTlNTTA3NVpydTJ4OHlybnBw?=
 =?utf-8?B?bUYvYVUzN2s1NERPZ3dEdTRDOWxOOGRINjJwNk5GcTFKS3RORmdJdjFnYUZw?=
 =?utf-8?B?MW54K1g0UGhXVTNLUDUwRUVlaFlOMFpHNjlVYytpSzVSQUtQdnUxY2lMUXU4?=
 =?utf-8?B?SFU5RnpoWjVpZHRSWlhaSEw1a2ZVUXFxZ0poc0IzM0VvMXhua2pRQlBBQklU?=
 =?utf-8?B?Z1FEN2x0MU5HdkVkWkxBWE50d1J0aXpZWWhING5xYjN2L2JKNjlEVHVNQmFn?=
 =?utf-8?B?dUM5cmsrM2pWemlpNkRtNkFMcllHak5rQlBhQWVvak9VL28wVUhwK0IwTGsw?=
 =?utf-8?B?ejZ3UHFsRk11aWE1cndZRmdpcFp1d2l6d2VQdzBjQzRNVW4yTzJiTGw3TFgz?=
 =?utf-8?B?SlIxZVhCOC9NWmg5T0NHcnlzTzM1L3lab1J6WCsxcnRkeGdFTFZnS015YzZa?=
 =?utf-8?B?Tk51SkpkWWZQems0NUI1clRIblEySnRacWdqMjQ3Q3BSUDUzVlIveUJqUmZR?=
 =?utf-8?B?NTlSMTI5djZRS0YyeVFVbzN0REJvN1lYK1AyN1B0TXR5M3IyeFhpZC9INmI2?=
 =?utf-8?B?VWdNWThtQjZlc3hmTEJmdGtiSitQYmt6VGx6NDIvNTdMMDcrVnFrSTlhclN3?=
 =?utf-8?B?bzN6VjdUaVJkM2Yvc3VVT3RyWmtURUZMYXY2TXR1RDV4dk5JY1Z2V0orbEx3?=
 =?utf-8?B?UDZ4TmVQZDVDLzZqVHltaFcxWXJvOUowZ2RGSVZPc0JuUkM3c2FOS3czMS9Z?=
 =?utf-8?B?NS9vMUF0bkcvS3ZuYWtkOGJEVVBDK1N3b2VLUXRIMlFWQ2dtNlVGUW8vTDF5?=
 =?utf-8?B?OTlGSFJROUQ0V3plRWNiYnIvcTdUMkg2aUwxaU0rQjllN2I2QW1qb1Y4eFBo?=
 =?utf-8?B?RkR3b2p5a2ltajNFaGxseVRkbHFIT1kzd1FEL0g5YmFOZlRHYVdJeWQvUHZw?=
 =?utf-8?B?VFcrOWM2VzAwaXM3bDdld3VhVkVrMmhUNXVSdTAwZFdZUlpEaktoSEtmbkZU?=
 =?utf-8?B?OWVCWExSN3Rhb2FQNlNrZXNFa2xIQThJVWhyQ2I3U3BpMWt5NW9CWktNZWJy?=
 =?utf-8?B?V28zMEk5eHY4TlJBVnRoS0E5M0Q3eGtoYzl1b2NLMS9KM2YwZ1RSL1hTcFdG?=
 =?utf-8?B?dzg0L2s1OEFJMm9xVEV6aDhwWC9kbFFzNStOWEFxMXZqUGRvOXYvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27579ba-33ef-4d77-2e68-08deef3d9ea1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 19:55:06.8343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5WEdRfwceMxZWHW0chwfCIyF/OFIk+gKldq8W8Av1Hcifr90KpDhFukDCoHg4EUSoiajjQCB7WESaAF5a/SFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9082
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

This is a core DRM patch and needs to be sent to dri-devel in
addition to amd-gfx.

On 2026-07-30 13:17, Fangzhi Zuo wrote:
> From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
> 
> Parse the HDMI 2.1 gaming-related capabilities advertised in the HDMI
> Forum VSDB (HF-VSDB) and expose them through struct drm_hdmi_info so
> drivers can consume them.
> 
> Add struct drm_hdmi_vrr_cap describing the sink's VRR capabilities: Fast
> VActive (Quick Frame Transport), Negative M VRR, Cinema VRR, MDelta, and
> the VRRmin/VRRmax range, together with a "supported" flag derived from
> that range. Add the fapa_start_location and allm (Auto Low Latency Mode)
> flags to struct drm_hdmi_info.
> 
> drm_parse_hdmi_gaming_info() reads byte 8 of the HF-VSDB for the
> FAPA/ALLM/FVA/CNMVRR/CinemaVRR/MDelta flags and bytes 9-10 for
> VRRmin/VRRmax. Per HDMI 2.1, VRR is considered supported when VRRmin is
> within 1-48 and VRRmax is either 0 (maximum based on the video mode) or
>> = 100. It is invoked from drm_parse_hdmi_forum_scds(), and the parsed
> values are logged for debugging.
> 
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
> Tested-by: Bernhard Berger <bernhard.berger@gmail.com>

I didn't look at the HDMI spec myself, so can't vouch for the
correctness of the parser, but everything looks sane to me.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/drm_edid.c  | 42 +++++++++++++++++++++++++++++++++
>  include/drm/drm_connector.h | 47 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index a9d480981c8f..7f810b08a091 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -6182,6 +6182,33 @@ static void drm_parse_ycbcr420_deep_color_info(struct drm_connector *connector,
>  	hdmi->y420_dc_modes = dc_mask;
>  }
>  
> +static void drm_parse_hdmi_gaming_info(struct drm_hdmi_info *hdmi, const u8 *db)
> +{
> +	struct drm_hdmi_vrr_cap *vrr = &hdmi->vrr_cap;
> +
> +	if (cea_db_payload_len(db) < 8)
> +		return;
> +
> +	hdmi->fapa_start_location = db[8] & DRM_EDID_FAPA_START_LOCATION;
> +	hdmi->allm = db[8] & DRM_EDID_ALLM;
> +	vrr->fva = db[8] & DRM_EDID_FVA;
> +	vrr->cnmvrr = db[8] & DRM_EDID_CNMVRR;
> +	vrr->cinema_vrr = db[8] & DRM_EDID_CINEMA_VRR;
> +	vrr->mdelta = db[8] & DRM_EDID_MDELTA;
> +
> +	if (cea_db_payload_len(db) < 9)
> +		return;
> +
> +	vrr->vrr_min = db[9] & DRM_EDID_VRR_MIN_MASK;
> +	vrr->supported = (vrr->vrr_min > 0 && vrr->vrr_min <= 48);
> +
> +	if (cea_db_payload_len(db) < 10)
> +		return;
> +
> +	vrr->vrr_max = (db[9] & DRM_EDID_VRR_MAX_UPPER_MASK) << 2 | db[10];
> +	vrr->supported &= (vrr->vrr_max == 0 || vrr->vrr_max >= 100);
> +}
> +
>  static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
>  			       const u8 *hf_scds)
>  {
> @@ -6308,6 +6335,8 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
>  
>  	drm_parse_ycbcr420_deep_color_info(connector, hf_scds);
>  
> +	drm_parse_hdmi_gaming_info(&connector->display_info.hdmi, hf_scds);
> +
>  	if (cea_db_payload_len(hf_scds) >= 11 && hf_scds[11]) {
>  		drm_parse_dsc_info(hdmi_dsc, hf_scds);
>  		dsc_support = true;
> @@ -6317,6 +6346,19 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
>  		    "[CONNECTOR:%d:%s] HF-VSDB: max TMDS clock: %d KHz, HDMI 2.1 support: %s, DSC 1.2 support: %s\n",
>  		    connector->base.id, connector->name,
>  		    max_tmds_clock, str_yes_no(max_frl_rate), str_yes_no(dsc_support));
> +	drm_dbg_kms(connector->dev,
> +		    "[CONNECTOR:%d:%s] FAPA in blanking: %s, ALLM support: %s, Fast Vactive support: %s\n",
> +		    connector->base.id, connector->name, str_yes_no(hdmi->fapa_start_location),
> +		    str_yes_no(hdmi->allm), str_yes_no(hdmi->vrr_cap.fva));
> +	drm_dbg_kms(connector->dev,
> +		    "[CONNECTOR:%d:%s] Negative M VRR support: %s, CinemaVRR support: %s, Mdelta: %d\n",
> +		    connector->base.id, connector->name, str_yes_no(hdmi->vrr_cap.cnmvrr),
> +		    str_yes_no(hdmi->vrr_cap.cinema_vrr), hdmi->vrr_cap.mdelta);
> +	drm_dbg_kms(connector->dev,
> +		    "[CONNECTOR:%d:%s] VRRmin: %u, VRRmax: %u, VRR supported: %s\n",
> +		    connector->base.id, connector->name, hdmi->vrr_cap.vrr_min,
> +		    hdmi->vrr_cap.vrr_max, str_yes_no(hdmi->vrr_cap.supported));
> +
>  }
>  
>  static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 745cd917fe40..61ea6e866ea0 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -254,6 +254,44 @@ struct drm_scdc {
>  	struct drm_scrambling scrambling;
>  };
>  
> +/**
> + * struct drm_hdmi_vrr_cap - Information about VRR capabilities of a HDMI sink
> + *
> + * Describes the VRR support provided by HDMI 2.1 sink. The information is
> + * fetched fom additional HFVSDB blocks defined for HDMI 2.1.
> + */
> +struct drm_hdmi_vrr_cap {
> +	/** @fva: flag for Fast VActive (Quick Frame Transport) support */
> +	bool fva;
> +
> +	/** @mcnmvrr: flag for Negative M VRR support */
> +	bool cnmvrr;
> +
> +	/** @mcinema_vrr: flag for Cinema VRR support */
> +	bool cinema_vrr;
> +
> +	/** @mdelta: flag for limited frame-to-frame compensation support */
> +	bool mdelta;
> +
> +	/**
> +	 * @vrr_min : minimum supported variable refresh rate in Hz.
> +	 * Valid values only inide 1 - 48 range
> +	 */
> +	u16 vrr_min;
> +
> +	/**
> +	 * @vrr_max : maximum supported variable refresh rate in Hz (optional).
> +	 * Valid values are either 0 (max based on video mode) or >= 100
> +	 */
> +	u16 vrr_max;
> +
> +	/**
> +	 * @supported: flag for vrr support based on checking for VRRmin and
> +	 * VRRmax values having correct values.
> +	 */
> +	bool supported;
> +};
> +
>  /**
>   * struct drm_hdmi_dsc_cap - DSC capabilities of HDMI sink
>   *
> @@ -330,6 +368,15 @@ struct drm_hdmi_info {
>  	/** @max_lanes: supported by sink */
>  	u8 max_lanes;
>  
> +	/** @fapa_start_location: flag for the FAPA in blanking support */
> +	bool fapa_start_location;
> +
> +	/** @allm: flag for Auto Low Latency Mode support by sink */
> +	bool allm;
> +
> +	/** @vrr_cap: VRR capabilities of the sink */
> +	struct drm_hdmi_vrr_cap vrr_cap;
> +
>  	/** @dsc_cap: DSC capabilities of the sink */
>  	struct drm_hdmi_dsc_cap dsc_cap;
>  };

