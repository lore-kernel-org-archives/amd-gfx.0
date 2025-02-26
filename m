Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11950C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 07:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B092810E86A;
	Wed, 26 Feb 2025 07:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QEDRuM6/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDA910E86A
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 07:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WO2AXMmbawTqrGCX+s2Ht69D9t2UvvjKUPQmNEZ8y6GjRtczymB/ztHuLT+T4KJeD4vJTVsdYy75DQyT1XQUJB7TwDQQfwHI0Zx71o3+xcy28LW+DjSdf5SjFOxGVUYInaxL3EzO1eQ5r8DEM4V3m6R/OB6Bi2f3iq9y0Vaj3uD+IXsa4fdLBG7WvMrHAmFYPSDGCIBDQOnGPw7MWlf06Xn2asWIbxcozww8dstBnswLrO2cdZma+GXZztnETXtL7Zilfae/FSj7XIKLyXUperFIKOz/gv4nhDtVsbFHCYVlg1pv3itADsEA+wQ0AlCxBTa7qusMUfwCq/9cNX0wWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4x52l7bYGwf1AulyjGNET1uL8nLclJgFMgpdaBUiX4=;
 b=uUuqyKnxtAyJh12viwGgI6mmLN+jJFLuCW/fI+XnTZHIHHCb+V7cEuX+3m8QvWJ4bta9fRY8BPS7uonxwKexHawk/ET6RlN8j6yOt6KmJFLE72EHGqwlewSjBofAnaKu6DiXgKBZow7TlGJqHjKYmTAqM+RdYcuPAAzi45OrXguj2rRsKS0Z7vVz8sWbaUXTevuENwlmQzFLzX0dw3ImALdfPbslnfjb4aG3zJkbJIslA6ExZxumTjHRD4VnQvq43XfyYFsnaSjzmp5tq/HYg8mZJ9ZzJ9GZu0XGvzs+871JjtAO7m126cWEJApeu+MD5kZS6OcSSsRPYU6ai43gqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4x52l7bYGwf1AulyjGNET1uL8nLclJgFMgpdaBUiX4=;
 b=QEDRuM6/sZfSKr5a+hf6NuWIJOqZIX7jNYNidJ+fb7NxWQQIE/51DQI0Zid29KGb+8J5vd7BUmYhHPMZuGMaODh7okJd0sV3+imJpkTObm8jiQ+d2Wc1Sn9/v/b6tFquPCGaa4TskglVbfdy/6Yq0Uqibwd1YXRmFvW2ofSD5TE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Wed, 26 Feb 2025 07:42:39 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 07:42:39 +0000
Message-ID: <92f80ccd-37f3-4e9b-bd6e-489e1baf1be0@amd.com>
Date: Wed, 26 Feb 2025 13:12:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: disable gfxoff on the specific sku
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
Cc: kevinyang.wang@amd.com
References: <20250226073147.517561-1-kenneth.feng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250226073147.517561-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0213.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: f5722771-ec53-43a3-021e-08dd5639253a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZThUam5XSGhYMTJ3OFpTR1ZubDIvYVZLTkFaYkJ3c0EyWUVtNmp5U3lzcmQw?=
 =?utf-8?B?WlN0ZHJlWU9meDBMcy92Y09sVHVoSXozNGt4a2ZuYnovSVJNNmYydkEyR3ZV?=
 =?utf-8?B?TS9lSXk1MGhQS3pPRGpYenA3a0xnZ2E3ZzNLWnlhUkNkOTh0T2FxNGcrY1Fx?=
 =?utf-8?B?MUhkN01jVFRsTldyS0JORWF6MmJQVG4zOEI4MHVhNFJFYXVOYzNTMkxSbytM?=
 =?utf-8?B?SG5EaUF3L2g4VmtqaldvL2tQTTluaDdkV3hFR0JJT3JGc3k4R3BTZUlVYXFt?=
 =?utf-8?B?L2tVYS9UVjU5Y1VZdTF3Z0VGU3B3SVQ3ajJTNU9NS0w4VDdZY3ZEaHNyeDZ6?=
 =?utf-8?B?clcyYmpHN25haGJ6dmxmU3hkRXhtMXE2R0h6OExoWlJJUGVSdmVNZm16ekRX?=
 =?utf-8?B?dVIzY1RKZTRJejN0ZkdpSWdRTXgza3VRQmRGc1JHd0lQa01mWkRRd1U3Vkc0?=
 =?utf-8?B?NUZDS25xVmdUZkl2VFFsaGEwYkpUWWZZY2YrdXZ0VVI3cVM0WTlHV2pDOWZI?=
 =?utf-8?B?c1A2YTFBK2FzUCt5SldveWVqUlI0a0xDTWhuc2ZjT1ViNmRZOVNCeXdBZE52?=
 =?utf-8?B?SVhnZ01QRVJjTG1uSEExUkhBOW5Fc3hJaWpLZzVKbDl4RG91TUJHMEFIcGsz?=
 =?utf-8?B?QkY3bkZIR21VOWJJVVlDM3Q0ZWN4OFNFNmxBQk5xa0JsS1RhV3VBT1R1K1Jh?=
 =?utf-8?B?NG01d3lVTkFIc3pwNno4VEJIOWl6aHhQeW5pVzgzMnBYdnlESnMwcEovZWI0?=
 =?utf-8?B?Q0Y3dWFRc3FyMDkyQ0xJMVQzZkcvd011NXNhNzdoQkxrNG5mNEE3cU9mTlhu?=
 =?utf-8?B?Nk9qQ0VTdlYvVVVLZk5FWkRHRElldE9LMkNyZ29hREdmRlR2WGM2Q1hMRUJI?=
 =?utf-8?B?alZpWUNyK0cxQXJMODZPQ0FzN0pYczVqTDZKUWlrZkJySjdLMTNBWUp1M1kw?=
 =?utf-8?B?Qi9OZXU3clZOR3l3Q2VEVzFoaWdNbFUwWU1yOEp3ejEyVDJ5Y3VMRGVZanVm?=
 =?utf-8?B?b2lsQ21uaHRyMUx3MzVrdi9QU0FrTnBobXR0bXJyWmdLTFRtNVpuaTB4Zzlr?=
 =?utf-8?B?YzFBSUxpQjNXSkhGUVp0QlQycW5qTzhLRGkzRDQzd3BLSmRLYXFzK3htdVZu?=
 =?utf-8?B?b0J5UjFzTnVFNmRuai81WVpmZ3ZkVGZxSmNQWUJxd0FNclJDY24zQ2U1UTdE?=
 =?utf-8?B?NjU4TnkyTVNIZEVUaWpFSHJxUVJzalRKZTRlV0U2dnYvY2lOclpzY1YzYWRJ?=
 =?utf-8?B?U0Vpa1FnZk9mV1lYdmhWQ2NPU3hEQXFxUjR4MSthdDduaDIrMEZTQytuMFNj?=
 =?utf-8?B?S05YaGpJS0tkbFpIZnlDY0h3OWRJc1FCTk1YMlk5Nk8rOVZzMkJGT1p0dm1i?=
 =?utf-8?B?cHFGc3Q3YXhHdWIyb1VVN2xtcnE5a2dhRVJHbHFpeEkvUHc0dFBhaW9sWDAv?=
 =?utf-8?B?S3psZVBDejdldkM4L1kvWW9EK1hsOEtKZlVoeVJ6cE1OMDJDT2Vkc1hLbXA3?=
 =?utf-8?B?N2pSRjhvWTVKbmtwOUN3V0VJMnozWmhKZ0tFU2xHcFdOZ3RTM2tNNWVDSk54?=
 =?utf-8?B?Syt1cGJKQnhSUEFuMWZjSTdLNUY0UUpJdVgxcDNFN0xGYW1pd1VaOUNWeEpX?=
 =?utf-8?B?Z1RwMjB2ZXJ2NkdxODVLSGxZN0E2WWlrbnRBWWkra1NsTDE2WTVNa1BERDU5?=
 =?utf-8?B?dXpiQkVDaDZCL2MxOHo1ZlVEcHEyVitaWWxvVVZoTzRnNG9PS3plemtQY3Zi?=
 =?utf-8?B?TnQwckxQYUI4Y1VYeXM5TEtsR2h2ekdDb3ZOd2hrM1d1WEdWTHZoQm5xcU5m?=
 =?utf-8?B?cWhwZ1cvL29aVThKRytJUjBBWloxVStaeGQxK2ZzeTg2WlZMdys5R2UxdndL?=
 =?utf-8?Q?ToGx8YK2fD5cT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eisyWndld0xzb2xSaDVvbDIzTjhmZ2ZlMldpd0NTN0dtZWh4NXFwUS9wZWFh?=
 =?utf-8?B?ZkdRdUs3ZzErQWNHWU0xMit0aVJUZjZHTVNaemFsVEw2TkhrRnd6bWluTlZv?=
 =?utf-8?B?ay9XY21oSGQwRGUrNGdwcHFtQ0hhS1BKM2pqVFgzdlhNNnk0Y0s2Z3R5L01I?=
 =?utf-8?B?cFlTbHRNVVIrQUhqT0tUUi9aNDZiZzkyUG9pemxZcVRNeDRsa051bEZDbGdu?=
 =?utf-8?B?RmlLbHo2dDRyMTFzR1VxbUJveFJEMkxmVlhzS0xMdG9xVVNHNHBjUDdzNzh2?=
 =?utf-8?B?dGJJT3RYUytuOUdKT2hidXRwZTN3YzE0anEwNnZuTU0wYkhUcjlQVjJheXBp?=
 =?utf-8?B?WHhCOUZWWTBWL01GeHNuMWVUS3hBMi9vQ0JrSDErTXBFbXlTdHh6QXpnU0pO?=
 =?utf-8?B?RjdMdk9sU0d6bXJXZTVKanpKckNmeHdjY1FySzN1OUFFMUVrTU5TUG95ZElm?=
 =?utf-8?B?d3pWZlFIbnMxM1h0QXFHbVBOMVJHbk9vME85bVYyem50OVpHbEhsOXpucEJX?=
 =?utf-8?B?V1hMbDlzMGFxT2V4WjZYdkgwdXUwU1BOVWNYTjdlcHY3ZzZtdTNlWWY5SjdE?=
 =?utf-8?B?SXBYczF0QTJUOWdQUjdCd1BUS0RuRjA3Tk92bXRIUmhIT2RmbVhzNkZOTU5k?=
 =?utf-8?B?b0ZueWVSaVJCTUkvOUdwMmYxeFlrY0ZoM1ZncUd6bjdNaHRqWnRXc2g2dWI2?=
 =?utf-8?B?R2dNQlBNTHFodGp0REJlaUhUY0VjSFQ4WkxGZGlFTHpBd3JzR0NvNGhJSlh4?=
 =?utf-8?B?eUJ1empKc1paWFpxZzdSSml5bXBvcmxMTjZldVhkSzJVUEIybXJhT1dSUmlY?=
 =?utf-8?B?ajdZVU11UjBmUTdlbGI0aW81c2pGSm5jS3p1N1JLemVzRm1RRFpZUUhjK3Ay?=
 =?utf-8?B?MzBrUUViSHhLYmR4OUNaV1M5d1g4U1ZhY3lxeGZEOS81Nk1VQ1NwT3RFRnNl?=
 =?utf-8?B?bFNjRGV1Mml4YWZZNHdrbVcwZDF3K0lQZGI3ejlzM0l0OC9INERrMkpIR1dI?=
 =?utf-8?B?SzVFdGhiUU1QNlFGVFcyMjIxdkh5R3ZYZ2hJMExPeVZJekp3NmRJNnB1SEl0?=
 =?utf-8?B?WXFPQWpnUlR4amh3Rk40ekdxR1NVR3lPY082N0NBbWVKM2MwRmlXdzZZWFpm?=
 =?utf-8?B?SVhEYS9YTnhXbE5TWXBrdE5CUGxnN3kvOEoxc3FqUElPdzNLQ2lmZHgreE94?=
 =?utf-8?B?c2Q5eW5oWm4zTUM5ckVYN3hQRVdURkFPcS8wRWdaNVFCalhhSUdiSVAyREVG?=
 =?utf-8?B?Sko2MTV1WmJ4RDRCU2ZtY0VEcHNlQmpaRzBjVGFaTXo0aGUzUE1GYnFnaHIy?=
 =?utf-8?B?VkdJaUhaekRpVW1GdnMyd1ZTNmtyUHFaRWo3VzJiblVxV2JRQ2JKWU5EazBC?=
 =?utf-8?B?TE0xdkpHM29KWVVyYm54Mmx2aTJNbDdJMjU0ekg3aTY2NW01QTZLczM0MERm?=
 =?utf-8?B?VlVRMVlQVzlYZkdtRVAvOU5OeTdhQy9yaWo4aWRTTzgvdTRocmE0UWdXeStH?=
 =?utf-8?B?RDdCNjBnbC92UDRtR2FWaVc5QzVWNGhkbHBSNHIvbUFCMzdLMTQ4alJ0a3Q2?=
 =?utf-8?B?T1REcHdVNitiWVRoL0dMM0xmdEd4cERmVnpITjlteVk5a2NBTVA2T0JFbnJl?=
 =?utf-8?B?emwzemRramU4L0I3WHVxcWJ1MTZSekovTGlmNFlIQUUyOG5Tb1BpejdRcTlE?=
 =?utf-8?B?ZGhWYXEwaG9Oc0QwcHNuQmpXTzB2TmJPNGxGYTgwQk9BemFRZGhqUkl5Y0Fk?=
 =?utf-8?B?RHBDZElvMXhmdzA4WTBtdHB2c0dUWmxXQkJvc0M2TDNwTzdjMmJSZXpGczBk?=
 =?utf-8?B?cnVYNUEyK3ZLL2VxZDVQYzZjMHJMcG5EbmhXRnNINkNtS2phMmptQzhZWUJz?=
 =?utf-8?B?VS9DYVFyRmpEZzRJVFJ6VWxQY1ZlOEpKbE84V1dkOTVPdHBvVTd6Y0hRb2FF?=
 =?utf-8?B?SW43Q2JGWDA5TFFMNzVXTGhxTUFjaUVpRS9VRFBzYksxQmVKME5xUDhhbG5i?=
 =?utf-8?B?Ni8rMXVvRGlCN1JXbGdEMDJIdjJYSTZhdEVmckNEYUZTRGxEWTJRVysvamtY?=
 =?utf-8?B?MStjY0tCdnF5cThwdVk2MzN6UDV2U28wNGJLb3g2Tm9EcUc4NzlqUkU1ZDNo?=
 =?utf-8?Q?bwjDko9bRdGHGdfDk9gbe7due?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5722771-ec53-43a3-021e-08dd5639253a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 07:42:39.7462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDpw5tjfznihf8MRGgrEuZD3zLzVvVoPl+a+dU5Uyn2DTbTOIVIG8f4vOVV8Csd1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
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



On 2/26/2025 1:01 PM, Kenneth Feng wrote:
> disable gfxoff on the specific sku based on the requirement.
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 8cfb07549f54..bdff59026367 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -781,6 +781,12 @@ static int smu_early_init(struct amdgpu_ip_block *ip_block)
>  	r = smu_set_funcs(adev);
>  	if (r)
>  		return r;
> +
> +	if (amdgpu_ip_version(adev, MP1_HWIP, 0) ==
> +		IP_VERSION(13, 0, 10) &&
> +		!amdgpu_device_has_display_hardware(adev))
> +		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> +

Better to move this to smu_v13_0_0_set_ppt_funcs. That's the only IP
specific call at this stage.

Thanks,
Lijo

>  	return smu_init_microcode(smu);
>  }
>  

