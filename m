Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85B8CD5BAC
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 16:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B7DC10E49C;
	Thu, 21 May 2026 16:09:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B6ANfUee";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 324EF10E49C
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 16:09:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMig81clujsY4bLnaknsFHE3Letty2SJPIGF0LF4xhvQOnnKF4dLSHJdi5jfRC9FPDvdmd4LGiEQrxoVtUMSGVZPq1YIg0/d6y+FefsnDGBMg4ehSS5RQ0d1CFUnR6ABemx8bFfMj9lwV7KRUqY7cjpGC+7MQuWIIBYzXo8kSVI7wnW3m685YW0MROuw026FTAgNWjcn+86QRbOrP58BmDhIdywiTLzVP9gsA6XaxlsZF8+xGNQLyVlfxKyYEGtYINw3w6gTxnJl5T+b83ztkhq4NCiMTU7rwL+XR4JXKXj59ywIP5jU0OoNrml50meP7ZmInBETub6lZllib8jutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8+NHD0skS9uRZLaS97OlEEW8TAvwdMwznS/Cd4A5h0=;
 b=dt0qRWjrqkJ190dIHyrG8oVHehg+5iQCg8OihC9hfHIRUB7ZyvnsJWZk7JeQC/WeaVmyeMPa+lOfe6sY9BJElsYh8RX4NSegFFp1xZuLO101GxUrfJqcV2Mm74PnUFmEqRp3Hu07FYa+d/xkM1C2sjoJrGeaadE3AjcS/HqFUIwXRq1L9Ne1MlBz35rSmoHwxElkYajbeO2K7d9CQwJmZzdTYyCy5/pk7TJjFZMGEqpLHwlof38zi0973ICeBrDN56vSxDsJmfLYGVEIifabFxNapV/vzIw4cNtFZZ2owfyVIBXZuVJVGGQzgpCizmx26vScJswKSzO7KXu3KA3T8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8+NHD0skS9uRZLaS97OlEEW8TAvwdMwznS/Cd4A5h0=;
 b=B6ANfUeenxB11/H8lH79fK6mJu7ynQtbW0/3jEuL42dl1xvfW9vpSn1LYwjTBJg3wWtyeU9GRobjwQo4/I+dMcjgypcFYqx2UWdKefdPeZ0ybriUKF0tEcO/rzFT64waxuP7fkv57cdg5Jn2C8RAKX/9TJDR344eB2eHQnyLeso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by SA1PR12MB7102.namprd12.prod.outlook.com (2603:10b6:806:29f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 16:09:41 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 16:09:41 +0000
Message-ID: <103d54bb-43e3-41eb-b615-0b05bfd5e07f@amd.com>
Date: Thu, 21 May 2026 12:09:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/15] drm/amd/display: Disable FRL and add module
 param to enable it
To: amd-gfx@lists.freedesktop.org
Cc: Jerry.Zuo@amd.com
References: <20260520202929.555119-1-harry.wentland@amd.com>
 <20260520202929.555119-16-harry.wentland@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260520202929.555119-16-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0300.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::29) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 50667f52-03ed-44b1-7354-08deb7535d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|5023799004|18002099003|56012099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: s0x/TM5ElC+k+xNXzMcfHR5MhHe+75oVA/7akVzzJl/H567ZqLPrmvNB50Y6/6adXnnr08e+8FR3sLD917GQafcsFQAkSJQWr5RyuuM86ExbmqVh+VYvprp8mXy7NkLfREaJzzZNLhNfvp/q1s372WmK2+slpwoNdKGVqf365161yUanJWVGpYyH0PmGhHqjzyk/iRT3acEFNbusFvpIIWz8k8fCtchEfb4SW/sCphVZIPd3cMosWuJnOcTQBpLvbrSyOeHYIKsPXxcK/azs/Yjs4E2D/9du0icqmbSkZ79XsFniSDhTgJ8rVM/WdREpb+lGmrhUAzk15Gcxy2MWpZhBMQu0GqwSR4BmNUGB8GGcB/+/cgsKpTKiGGFDxN/CmwloPXV2fmD6UabKDPSJQOvhNtMyOaC/+hgEqZ9ucBAa8FOC/KqosUC7Gh+va/4EcL7aRzlAPpIa+p5ET4pnKSrL5WEOrgs4v8SJ1rZoDIa3zPpJIZE+HA00eL/DfP/M9xh6OiS2w5PmHxUFWV35SLr70z8PdaDGZuZU7JQcMuRFTv7y8SrGQc+QCWRAluDfL4mr+dcN7Kja9gW632yGnZuyQHGe6M8DrdnNhgK7wq+M0NANZDPpbrFeL8vvna0wZsU/yeagg3Ebq8Ih+WkfTwx30VGk9YjkMrlQrNZCQd7/8QaBJNMtxxeIBJR7oj5P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(5023799004)(18002099003)(56012099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3ZpTE5FeThhRy8xa2VIbEw5c28xS2FRTkNhcTFZYW91UEVUbm9kdjNLVHgy?=
 =?utf-8?B?NmFYRU9Dcm9QcDZicW11Q3hRQ2l3aXBJdCtpa2RSQmtjbmsxTVZSVGlzbVU1?=
 =?utf-8?B?UGxoZ3pLaTh2L1l4OWdnMnRmakxITnd0Ni9jVUY1UFVPQ21lQzhGa2QyaGh4?=
 =?utf-8?B?R2FCZ3hqUWM2eTRaS21zcWxtdHlxc1QxMWVRczRLVGdsYkExSWxlMVJVVEVi?=
 =?utf-8?B?VUxTV1RFTG5NU1lQNDRkcXoydzJYbDNWZHI2UWtkQm81MFpUR2Q3Z1Rla3Rk?=
 =?utf-8?B?b081MEZzMGJEeS9xL3RlM292MXYrTTZSTjJyQ3hQVUpwWEFyanlRSG9vbDZN?=
 =?utf-8?B?RktMd1VFNHM5cENZc1A3K0pCNWxaRnpKYy9BRGJEOEdIUC9NSG1hYjFQUm0z?=
 =?utf-8?B?SDM3K3BVYURvYkEzTGtVTTNSUkVtU1Izam9FQzJuRmZ0MDNadGRJWVhpUkJm?=
 =?utf-8?B?SzR1eVA4ak05OTd3Z1E2SXczUjFkeVVJQk05OVpMTXBJWDhwRkV5d3Y1ZUcw?=
 =?utf-8?B?WG80bFFjNTJZVytIZWVPWlh0ZDNuUmVlelQxSXcraHA4V1dKZlF3dUdDTEpi?=
 =?utf-8?B?WnpuZ3VQcmV6ZFQzMHUvcVlERC8yQXhjRUhJZ3B6NWFBUVB2T3ZXcE0vSnh3?=
 =?utf-8?B?MDdhbzF6L3Q3YTlBejNpaTk2dmU5clFQTGlZakxKNTVWZnlBUktEUStsNkU3?=
 =?utf-8?B?ZmltT09lNWRQVVhoTGFad1VwZGdnVjhwQ1N0Um9UZWZNVTcxOUE1NHlUNUV1?=
 =?utf-8?B?RjdUeEw0ZDRlNG9ZZVhBL2FDSEJFejFPL2M5TnVVRjQxVUlzVTlXOGRTak92?=
 =?utf-8?B?aDF3cXMrL0lPd0FhOUZmSmNxSGtOUzRzRVNVbnc0bThScFdNdHBkS3ZiaTBR?=
 =?utf-8?B?S2lPZEZ1SnNTeG1tNXdlVzdWejhLanBoS1hXTkZONHBEVFRYVTJLTTRUalNF?=
 =?utf-8?B?VUF5Q09rcmlTeFU2Z29yUzVIbXVWdytrK0pJWGVDcHJ0eDJIaXluWlRMUzZS?=
 =?utf-8?B?SjNidy9VMTR3cnhiUjFIVElHanZZU1FFK3N2Q2NvTW1TZUpTSzF3VjVCaEZ4?=
 =?utf-8?B?TDV5K1Q5YmFOL1JLS01LeVdTSDdQV2xjaUNHQXhYRXNmMXZkc3BIQVg1ZHdM?=
 =?utf-8?B?RmM2cDFveU5ad3B0dGZXZ2VxNHViYnVUR29oVXUrUmlqNGtWS3VlcjNDbndS?=
 =?utf-8?B?b2hRZk5haEx5U0JmVEozZSs1dGY2VVNTZHc1UFk1TUtnTmhLQ3dDNWsrN1Fl?=
 =?utf-8?B?SUtiajFmbnU0SUVPTmFkY1VKNEVqTVVrdGdINVFNZEZoMzNyUkpIbXkwMlBX?=
 =?utf-8?B?TXhEVnpuMk9obDV4OHNKWENTaEgvKzVoOExzbzI2ejJvK3Zqc3hBN1Z5bW1S?=
 =?utf-8?B?TkVuTXBHWnNqZFR3aTlvbVNMTE5iUUhSS3Y4TXJCbzZsZDZDQ1ZGZTBWUm1O?=
 =?utf-8?B?MVRpRXdpZHRTMDRybklxa3k5cHJibWNMMG1nUm1ESU4vTldOdGZ6VmNXSHdz?=
 =?utf-8?B?NXdhbXQrZS85cGRibHVKejVIakJ4c0RpWjNWRS9QNHRmUHBuRWdQQ1Y3MW5r?=
 =?utf-8?B?d3RyOTUxazZoeGFmL2g4b0tuQ1lxWWR0UkRKOG1tRk8xUXpsRFFHMlRJdEpR?=
 =?utf-8?B?bTdPZ3RlWnBMQUUxYS9CbmVSU1ZRMjA4aTZ3bUJ2cWdScTZWRzQ5LzdOYlFH?=
 =?utf-8?B?bHA4cEs5SzdybTdOQ2hZYlV6WUZGTDdVanpKTzJJbUx5aUFhWThXRFhCRkow?=
 =?utf-8?B?cjhGeTVLYityWHdyQnpYWUwrd0NEUmJmZzVyV0FYYWVJMFQxcmJTZlBQYzdx?=
 =?utf-8?B?aDJGTUoyVTZkUmlHN1R1REpWSE13MjEvMW5IamdsT3RLY3E2TFZ0ZUY2YVpB?=
 =?utf-8?B?STNFQlltL29iVnNoSklsK0VtbEluZ0RjVThqNDl1T1VVelZRN0Q2aXJsY1dM?=
 =?utf-8?B?MUo2WHZTVFphMTE2MnF1RmVoSEdrNjU1alJpdG0rd0VGQmNXNkl3emtHdnJN?=
 =?utf-8?B?bzkzS1Fkek5kclE0YjJVM1c4eEZnK21Ca2xPLzVFVkIrL1NDZ2U5VjE2ajI4?=
 =?utf-8?B?WWtKUnJCSjlZYzErbTY3RHQvQjhXTWpiWWtYTTRHbnB3ejNsVHpSYXVXK3gr?=
 =?utf-8?B?c1pRMlV1Y0ROa0hLUXlSeTdJcGxFVHZuVklTeWhBY0crV1lZRzJWeGw2VllD?=
 =?utf-8?B?Ri9TUEtwQlhzUjU2N2o2Y1RkYXZPQ1hmeGhkbkpLOXYwclJZUWRzeXlsSENZ?=
 =?utf-8?B?dC9kZGd6VlB2ZFkyRTgzSEZ6ZFo4TmJpVDRMakVnKzFZSEYzWC9xcksrWHVB?=
 =?utf-8?B?NjJVQlFaa0lVMll2aVFrenkweGhibW4rVWt3STdRZXBscVUweHNaZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50667f52-03ed-44b1-7354-08deb7535d85
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:09:41.3281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vq6GlOPP/SOEX9WLN60a8ucTjStgQjpUpisNN2OxT0bsV+wn/wGY8fYPIAlEkZKcMhJmvxgz67Ak4jmvAQKZoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102
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



On 2026-05-20 16:29, Harry Wentland wrote:
> From: Fangzhi Zuo <Jerry.Zuo@amd.com>
> 
> FRL links don't yet support VRR. If we enable it by default
> users will see a functional regression when connected to an FRL
> capable display as the driver will now default to FRL and not
> allow VRR.
> 
> VRR support will come soon, so instead of making an elaborate
> TMDS fallback mechanism simply default FRL to disabled, but
> provide a dcfeaturemask of 0x400 to enable it if anyone wants
> to already try it out.
> 
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 ++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 30 ++++++++++---------
>  drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
>  drivers/gpu/drm/amd/include/amd_shared.h      |  4 +++
>  5 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 63fd63ea1310..15ebad9c9a76 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2081,6 +2081,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  	if (amdgpu_dc_feature_mask & DC_DISABLE_LTTPR_DP2_0)
>  		init_data.flags.allow_lttpr_non_transparent_mode.bits.DP2_0 = true;
>  
> +	if (amdgpu_dc_feature_mask & DC_FRL_MASK)
> +		init_data.flags.enable_frl = true;
> +
>  	init_data.flags.seamless_boot_edp_requested = false;
>  
>  	if (amdgpu_device_seamless_boot_supported(adev)) {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 5efbcf6eae86..7d37c1612131 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -1116,7 +1116,7 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
>  void amdgpu_dm_update_connector_after_detect(
>  		struct amdgpu_dm_connector *aconnector);
>  
> -void populate_hdmi_info_from_connector(struct drm_hdmi_info *info,
> +void populate_hdmi_info_from_connector(bool enable_frl, struct drm_hdmi_info *info,
>  				      struct dc_edid_caps *edid_caps);
>  
>  extern const struct drm_encoder_helper_funcs amdgpu_dm_encoder_helper_funcs;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index f9ec006e08c4..af32202f8c10 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -179,7 +179,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
>  	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
>  
>  	if (edid_caps->edid_hdmi) {
> -		populate_hdmi_info_from_connector(&connector->display_info.hdmi, edid_caps);
> +		populate_hdmi_info_from_connector(link->dc->config.enable_frl, &connector->display_info.hdmi, edid_caps);
>  		drm_dbg_driver(connector->dev, "%s: HDMI_FRL [%s] max_frl_rate %d\n", __func__, connector->name, edid_caps->max_frl_rate);
>  		if (edid_caps->frl_dsc_support)
>  			drm_dbg_driver(connector->dev, "%s: HDMI_FRL_DSC [%s] frl_dsc_10bpc %d, frl_dsc_12bpc %d, frl_dsc_all_bpp %d, frl_dsc_native_420 %d, frl_dsc_max_slices %d, frl_dsc_max_frl_rate %d, frl_dsc_total_chunk_kbytes %d\n",
> @@ -1124,21 +1124,23 @@ static uint8_t get_dsc_max_slices(uint8_t max_slices, int clk_per_slice)
>  	return dsc_max_slices;
>  }
>  
> -void populate_hdmi_info_from_connector(struct drm_hdmi_info *hdmi, struct dc_edid_caps *edid_caps)
> +void populate_hdmi_info_from_connector(bool enable_frl, struct drm_hdmi_info *hdmi, struct dc_edid_caps *edid_caps)
>  {
>  	edid_caps->scdc_present = hdmi->scdc.supported;
> -	edid_caps->max_frl_rate = get_max_frl_rate(hdmi->max_lanes, hdmi->max_frl_rate_per_lane);
> -	edid_caps->frl_dsc_support = hdmi->dsc_cap.v_1p2;
> -	if (edid_caps->frl_dsc_support) {
> -		if (hdmi->dsc_cap.bpc_supported == 10)
> -			edid_caps->frl_dsc_10bpc = true;
> -		else if (hdmi->dsc_cap.bpc_supported == 12)
> -			edid_caps->frl_dsc_12bpc = true;
> -		edid_caps->frl_dsc_all_bpp = hdmi->dsc_cap.all_bpp;
> -		edid_caps->frl_dsc_native_420 = hdmi->dsc_cap.native_420;
> -		edid_caps->frl_dsc_max_slices = get_dsc_max_slices(hdmi->dsc_cap.max_slices, hdmi->dsc_cap.clk_per_slice);
> -		edid_caps->frl_dsc_max_frl_rate = get_max_frl_rate(hdmi->dsc_cap.max_lanes, hdmi->dsc_cap.max_frl_rate_per_lane);
> -		edid_caps->frl_dsc_total_chunk_kbytes = hdmi->dsc_cap.total_chunk_kbytes;
> +	if (enable_frl) {
> +		edid_caps->max_frl_rate = get_max_frl_rate(hdmi->max_lanes, hdmi->max_frl_rate_per_lane);
> +		edid_caps->frl_dsc_support = hdmi->dsc_cap.v_1p2;
> +		if (edid_caps->frl_dsc_support) {
> +			if (hdmi->dsc_cap.bpc_supported == 10)
> +				edid_caps->frl_dsc_10bpc = true;
> +			else if (hdmi->dsc_cap.bpc_supported == 12)
> +				edid_caps->frl_dsc_12bpc = true;
> +			edid_caps->frl_dsc_all_bpp = hdmi->dsc_cap.all_bpp;
> +			edid_caps->frl_dsc_native_420 = hdmi->dsc_cap.native_420;
> +			edid_caps->frl_dsc_max_slices = get_dsc_max_slices(hdmi->dsc_cap.max_slices, hdmi->dsc_cap.clk_per_slice);
> +			edid_caps->frl_dsc_max_frl_rate = get_max_frl_rate(hdmi->dsc_cap.max_lanes, hdmi->dsc_cap.max_frl_rate_per_lane);
> +			edid_caps->frl_dsc_total_chunk_kbytes = hdmi->dsc_cap.total_chunk_kbytes;
> +		}
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index d3273709bb8d..907757a44da2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -589,6 +589,7 @@ struct dc_config {
>  	int smart_mux_version;
>  	bool ignore_dpref_ss;
>  	bool enable_mipi_converter_optimization;
> +	bool enable_frl;
>  	bool force_hdmi21_frl_enc_enable;
>  	bool skip_frl_pretraining;
>  	bool use_default_clock_table;
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index ac2d3701e2bd..3fd38323a88b 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -286,6 +286,10 @@ enum DC_FEATURE_MASK {
>  	 * @DC_REPLAY_MASK: (0x200) disabled by default for DCN < 3.1.4
>  	 */
>  	DC_REPLAY_MASK = (1 << 9),
> +	/**
> +	 * @DC_FRL_MASK: (0x400) disabled by default
> +	 */
> +	DC_FRL_MASK = (1 << 10),
>  };
>  
>  /**

