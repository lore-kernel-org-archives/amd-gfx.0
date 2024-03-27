Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E164DC47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 06:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B38810F89F;
	Wed, 27 Mar 2024 06:21:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1sdFD+0I";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2100.outbound.protection.outlook.com [40.107.92.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FF0610F89E
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 06:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUFHhMrG3lYa73nvhFejot9EixsObHIyJhdNiROlgB25QPIvTWjzMjzipUs2AYBdq5TghwUCP4l/Z/nBh1Vs5xo1zS2EIrTsb1SHI2TxxjwOHtux20eR7DoF/eFC1/WbpKxvI/NJUX8T93QbMiS0SDU/fPSMRs5anmB6j45Ez1fuFHlPKdzBLuNXm6JEkU/0IUY+qQDiiyDNnARn2Xt5OLtn5s5BFM7xp6XLoXivEeF+tCCHDuVjha0m68zZOr3cTpusJUnD8mve4vJG+jpmvGDKVccuBJRR/4Jv+n97j76E2Xs10dtnzaumqfjXCbg2Bc9jDDtp8V/CS7nONWZL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0tAAkIIKNCjK0CXYjig5alqZPpiqiN4Y/gJtOPnVrI=;
 b=bGTuAzPGCM2kwKyehB5etDLPIIsfIk2U+lBzFMrFYO0yc6xcZ54ui7zXO7/00MU+uM74gMI0kzsQ5w2v5sYuuvF4hJQUBpWrRf1BMR2s0qW8Thf52Ch3UNjF0td5ONYM/KmT5TG6ctwytXrWJZnsNpRGTvKS7nno2xmZEQRAMjLSO17as+LkSbR5lmb44NH+Z3DHi70TG5aO9xY0rzbLK7rk55PoanmZhWiw+BOqHlnfGMarxFLMkkw9P1S9R2a4/+bVRucZjGO8nak/QymcdTF60tmyKPZQsr3rb/ArzisrNmp3gBg7nZGqIH1hs96KQIcH3IwrpCMr8R05AQ9YXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0tAAkIIKNCjK0CXYjig5alqZPpiqiN4Y/gJtOPnVrI=;
 b=1sdFD+0IS2DBt8FZo/AGMS1U6SVRDv3MiP4jTQE49IensK4p3AEmGwytWIyoeWUtLXy+VhKKBtIN4mw/xaQNeihi5yo/ByoTwzdGBuRL8IvrGg8PT/8eLVB8MeYgBrpH1PeBs/PrmviolnWPd+pxJ6XtxAzEYFkB0PGyrsnEUR0=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 06:21:46 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 06:21:46 +0000
Message-ID: <2c6fe582-abb3-40dd-8591-5040697eadf3@amd.com>
Date: Wed, 27 Mar 2024 11:51:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: make amdgpu device attr_update() function
 more efficient
Content-Language: en-US
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com
References: <20240326090255.77211-1-kevinyang.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240326090255.77211-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN2PR12MB4207:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rNH7zqRXdS7rEhx/ymrMuinj/CqHtaYAcI0QbXdvr04fxpD7u06pZRGVs59LSrLzQVBo+Dr6IPdMT8citPSbKpyAg1us2O4/818Gbi05AVSkr/ks8MFN9+VY5Cleo8d0ZBLHFba+vrt2fyBKLGIPVrW4DGejtO3stSV53QEMiGpmp81BBSvzfg+9SgnlVXmTfdIq2bPgkewigMoYOZcEjfl46keO4T5Azf7D1RDS9s1yLSQuDzH2m54SrMl4oyMUsLY72Ybnc9Hi9snwIbH4K6y+Sxlw1Gne9s8jG0FAWN37Ue5lAL61f85BfWQLOUJ5m9CVPVn4wywBaRO0VfMZvqNFpsmjqRLtKUj7QrmQlNs7BoYQ44ZCV5tT9K9YXtal5R3BT6FUfXY1yNAwJ9tk84qx/F543iGfkRLSnbcyj3YwM9tkV5AESJz12Kdetdehtq3R+Y9TIm4ObrxGpjxYyXbg1kRz0SecmIJpRHxJMnDGUlXxOjP6v0SMi28oaAa8jzjC72IIcZyFsFlrzZs33G/MPS5t5ywe97UWwp4O0iiVxXixLrexTR3VAf3QU6YECaSIrX9Dih6tqHp2gSVRMyCL0qEE/gkJ9WF85gDVyHeS9wKpWqFi0ytAMyAnWow5qHi49KBucSy/vjQALGwTL0c1vTF1bhmegsPMIoroKG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUhtbCt2V3lNOWVZUi92bkxKaURFZlZaZ3FwZ0FJZmJURUdMZit0UVdoUmtW?=
 =?utf-8?B?bS9FalpUTDN2TTJqb1lxaXNQcVhQcy8yZms3SkpMeTlOME5nckRHOEVoNXdX?=
 =?utf-8?B?N2VnY3JwcFVnQkRwenIwUHJQS1M5VUdaU2ZvSmlBYmRvenU0QTNReGRhQ0kw?=
 =?utf-8?B?QWU4dE1ORTRqcGI0d0tBRlluU0tJYUc0NEppVkp1bldEakpzVktHMnVTVGph?=
 =?utf-8?B?YXJmNko0ZUtjUFRwd3QxdC9hcG5qYU8wRDhJbldxRTJlZ0V1bVd4T0VNd0RV?=
 =?utf-8?B?Wm81Z3dEZEg4ZlQ5NDJkVlZHNm1oODJDU0tHYTVRN0EwOTNFYTdjbFpnYXlP?=
 =?utf-8?B?YmQvOHVtVm1aMzRzQ2JZSkh0SzUxR3ZqNmp3azhYQXlRK01DVDUyanlsYjEr?=
 =?utf-8?B?NGZwZVZtTHdNN2tIcWw4bEY1Z2xPMkQ2OFM2QjZhSStkMDY3WmxId0JxeDZ0?=
 =?utf-8?B?aEhhZmNUVit6cm9FS1ZkakRBVjFseGdmQ0x0c2M2WXlDMHR0OGJLdVBUbTRy?=
 =?utf-8?B?MDBGb0tIVVUyZG1uYUU0Zm9CSGlsd0cxZHQzSXgySW5jTUpGTVVhWWtPdUxP?=
 =?utf-8?B?KzlUNzhIalpReGUwcmN4TkxWaFhGSnY1Z2tVSktyako5WDBJenNjQWJBUXNw?=
 =?utf-8?B?THJ5R05QbXlKMnpIOHhiMUhEQ0wxUTgvbUN6WjhYTkxHMTg1SDZaWXFPeFdE?=
 =?utf-8?B?MWhvU1NNeXBDenhvdmltNUg2S1pWU0ZpejFyMDRxeE1WWHVUbnRuMlU0dHg2?=
 =?utf-8?B?SGU0VUxkeVRxSmgybE9CNFhZZnRBRUVWU0JEL2c3VndhVVFubU96VDFYTlFp?=
 =?utf-8?B?R2FuRkp4ZVc4ektHaXhQRG9vU2pTdGdpZ0E1aVlTVVdaK0V0aFVYVmlyMHhC?=
 =?utf-8?B?RkxKYVBzbDk0UmJsMTZidkhlak1sRWdadnVxbmZ0OHBLclRMOWpSdlE4OGlW?=
 =?utf-8?B?c0JYdUd2S3QwcXU5YUlpWnA4cEgrV2x3VkZQSTNpT3NmR2loYkRmemlpUTZs?=
 =?utf-8?B?MHVKMjUzU04wZjRHSDZtWklPOGNSY0RqQjNYcWk3eldUUENGUXJjYmpwMTJx?=
 =?utf-8?B?ZU1WeE9hS0xOcHE5K0lTaHBsSTNoNklBbjRyTVZFR0dGN3d5TkJkMk9UZ2U0?=
 =?utf-8?B?UFRQdXp0cnIxcm9YWFdFWEVrMW03U3FvMmZRcUxmTmY2a0RKcDhxblNHZ0lH?=
 =?utf-8?B?UEs0NVZxUnFuL3Y2SWZsTGY5R1phSldzTTVUTy82T3loZXM5UVJnOW85OFZl?=
 =?utf-8?B?VVRSZG5GUEd5OVZiS3dvR05iWnY5SEQ1SjNPUHA1eXovK2orcnJwSm8rRk9Q?=
 =?utf-8?B?TGJldWw0WlFQem9qY2RMZnNpZ1dCSDZORHphRGY3S2g3OVlFZzAyL3VZYTB1?=
 =?utf-8?B?ZG9YUlF5eUxHallCZHV3ZytMT3hnUkp1UHVlYWxsaDNXa2piRzdqUDlQcEdW?=
 =?utf-8?B?L0htT1ppZy9ndWpYNDRjRkNmVDk2Nk8zT2ltZ1hJOGh3ZkJSQjRWajRMZTV5?=
 =?utf-8?B?RDQ2dW5JWFRkZXM5R0NxcVI2NjFRYnJsUlllTTNFWVlCOWRIYlRESkRSYWRp?=
 =?utf-8?B?bm9sTjd1a0t1eDBpcVpSU3dodGhOWFJrTWVvV2t0SVhNMUQyRDdwRytKajlB?=
 =?utf-8?B?K0MwejlPN1MvYXR0bjl3RTFwSkdmelBDTXdaQXppSmRqZUtxM21TUFNUNUlV?=
 =?utf-8?B?M3IyQXRqWDQvK0JRRXVJYlNEZEV0WHJIZlpaTTNqWkNoZ2wxUW1KNGR0bGlY?=
 =?utf-8?B?WDhKNHJkdkRtZWZsdnZncEd2SzBucnJrcUhqYlBxSUoyOWJVUE5mZ2c3VllH?=
 =?utf-8?B?S2pPT2JGY1l6Rkxyd0NBMktkRmxrREZzZlRUS1RwTHdVTDNtcE1uT1VCc3d5?=
 =?utf-8?B?aTlBR1h6Rk5hNmd2K2pkTDdQUVVIRUdsMmN3bXRWeEZlSVdIeWR4a3hGVjli?=
 =?utf-8?B?N09KOWFEb1NkbkVVUmFsaHE1L3ljQ1FhcFZRVVltN2NQVHZRL0R6a2YxVFFS?=
 =?utf-8?B?V1NMV0VQTG05cFRoQTloM3JONzBvT2NEWXdoZVFTeDA3bE5RTnhlckpBdVQ2?=
 =?utf-8?B?ME9HallCUnUwZitqMHZJSGJyUUxNdEtuYm9uWWlpa1RpU3J4eXphV0QrZWVn?=
 =?utf-8?Q?G7/kwCRAhlHcIiGXzGmY8qme2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8981234d-baba-4849-51c9-08dc4e262d7a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 06:21:46.2116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqYyuwu/lkLTD6mVvjtMK1MTnpQ6CmHaRErrV7ZQsy9QeyJQYLKBwInMrIyWatkM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
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



On 3/26/2024 2:32 PM, Yang Wang wrote:
> add a new enumeration type to identify device attribute node,
> this method is relatively more efficient compared with 'strcmp' in
> update_attr() function.
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c     |  4 +--
>  drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h | 41 ++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 85e935556d7d..04f53f2667fe 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2226,16 +2226,16 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>  			       uint32_t mask, enum amdgpu_device_attr_states *states)
>  {
>  	struct device_attribute *dev_attr = &attr->dev_attr;
> +	enum amdgpu_device_attr_type type = attr->type;
>  	uint32_t mp1_ver = amdgpu_ip_version(adev, MP1_HWIP, 0);
>  	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> -	const char *attr_name = dev_attr->attr.name;
>  
>  	if (!(attr->flags & mask)) {
>  		*states = ATTR_STATE_UNSUPPORTED;
>  		return 0;
>  	}
>  
> -#define DEVICE_ATTR_IS(_name)	(!strcmp(attr_name, #_name))
> +#define DEVICE_ATTR_IS(_name)		(type == device_attr_type__##_name)
>  
>  	if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
>  		if (gc_ver < IP_VERSION(9, 0, 0))
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> index eec816f0cbf9..157330c379be 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> @@ -43,8 +43,48 @@ enum amdgpu_device_attr_states {
>  	ATTR_STATE_SUPPORTED,
>  };
>  
> +enum amdgpu_device_attr_type {

Prefer id instead of type. That aside,

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
	
> +	device_attr_type__unknown = -1,
> +	device_attr_type__power_dpm_state = 0,
> +	device_attr_type__power_dpm_force_performance_level,
> +	device_attr_type__pp_num_states,
> +	device_attr_type__pp_cur_state,
> +	device_attr_type__pp_force_state,
> +	device_attr_type__pp_table,
> +	device_attr_type__pp_dpm_sclk,
> +	device_attr_type__pp_dpm_mclk,
> +	device_attr_type__pp_dpm_socclk,
> +	device_attr_type__pp_dpm_fclk,
> +	device_attr_type__pp_dpm_vclk,
> +	device_attr_type__pp_dpm_vclk1,
> +	device_attr_type__pp_dpm_dclk,
> +	device_attr_type__pp_dpm_dclk1,
> +	device_attr_type__pp_dpm_dcefclk,
> +	device_attr_type__pp_dpm_pcie,
> +	device_attr_type__pp_sclk_od,
> +	device_attr_type__pp_mclk_od,
> +	device_attr_type__pp_power_profile_mode,
> +	device_attr_type__pp_od_clk_voltage,
> +	device_attr_type__gpu_busy_percent,
> +	device_attr_type__mem_busy_percent,
> +	device_attr_type__vcn_busy_percent,
> +	device_attr_type__pcie_bw,
> +	device_attr_type__pp_features,
> +	device_attr_type__unique_id,
> +	device_attr_type__thermal_throttling_logging,
> +	device_attr_type__apu_thermal_cap,
> +	device_attr_type__gpu_metrics,
> +	device_attr_type__smartshift_apu_power,
> +	device_attr_type__smartshift_dgpu_power,
> +	device_attr_type__smartshift_bias,
> +	device_attr_type__xgmi_plpd_policy,
> +	device_attr_type__pm_metrics,
> +	device_attr_type__count,
> +};
> +
>  struct amdgpu_device_attr {
>  	struct device_attribute dev_attr;
> +	enum amdgpu_device_attr_type type;
>  	enum amdgpu_device_attr_flags flags;
>  	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
>  			   uint32_t mask, enum amdgpu_device_attr_states *states);
> @@ -61,6 +101,7 @@ struct amdgpu_device_attr_entry {
>  
>  #define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags, ...)	\
>  	{ .dev_attr = __ATTR(_name, _mode, _show, _store),		\
> +	  .type = device_attr_type__##_name,				\
>  	  .flags = _flags,						\
>  	  ##__VA_ARGS__, }
>  
