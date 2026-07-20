Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B73C44520
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2026 15:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B1610E1CD;
	Mon, 20 Jul 2026 15:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cJAeCl4/";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C214110E1CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 15:34:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaLiu5lrgrqVsbYLCDcL6j/S9KPPvVbTV2CVtnUOZA7oVopfPwrGl9nOv30xgwGFEBwY5MYUubWPyB/IRZnabZzVz6EF2i2iaVITLnAKjEXgCcIXsiO3w0UsDeFsLY3Bmj+0pHgnr+HVIqfvypmhKadjQDzELxBvLi9PHxIfSjdkyPAIKvVCDvipECYwBkEoZg/olBKS6WtIzwgjA8xfS4BhxHLuCLY3ViJSFqIM7snVRNNKR5uUkp3iSQYEeKRLowzcBakO8RKa06JDpkFllmlf7nhXgxSq9LHpTPcx8bIUlbmB1Hui9UxvVjhaspffRN6Z19YEYSlr6XfvHdRinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvUE1xBIkv7XSxQXfyQDP7+LzFRI0FZWStFoNGmT34s=;
 b=wrzJQN+IXbGyVgnNPwPN8/tSwySddybYH+aBTOaXWClMsJVbAYL4GZOYXytmxi5YYAgpTD1425BOtS3oRp5DifZazdre4eQoyrJK3Xfi8IXZLVM6MNgYEu6k1b8kSgiKvx5bGwYqqfHtzTI93v7X5lRsbUijtEzuqeq30g2NAuy/ne0B7EaSVOO0sZE62BMccCRroxZUN0lwcoekUauTqFxFuM07Y8NvPdIbdk4LhhY1Wo+AoiTXf6ZlN24Cdu/zliLN1zx83k/o02QPEhJYlXAfS5MI8ufSpj9mU0m4fnDMMXp2+dJlfke8cUNvf0UqRZW8NHhuA5iW8ad6OhHvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvUE1xBIkv7XSxQXfyQDP7+LzFRI0FZWStFoNGmT34s=;
 b=cJAeCl4/QndLuCAsEPDZHHhN27AeDZx5rHFjIYVOCzvB+speR+WO8DenXL/VGsDYnyiw62zwj+PolC4oCLYlv5EW0VAWQZ7LeJYBwktXnHeZkq5aigw7juivsIR3MfE2/IYTh5nxZJId/8QlAfeZQxZhbQm5nG+gegTbteLkGzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DM4PR12MB6255.namprd12.prod.outlook.com (2603:10b6:8:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 15:34:33 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 15:34:32 +0000
Message-ID: <bf360f35-d8dc-4b05-b48c-a411ba023cba@amd.com>
Date: Mon, 20 Jul 2026 10:34:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Reuse common IP firmwares for GC 11.7.1 from
 GC 11.7.0
Content-Language: en-US
To: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Pratik.Vishwakarma@amd.com, Lijo.Lazar@amd.com
References: <20260720071105.3214694-1-Kanala.RamalingeswaraReddy@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260720071105.3214694-1-Kanala.RamalingeswaraReddy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0135.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::13) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DM4PR12MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ececb10-b47e-4c66-d326-08dee674654b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: K3+shwQVD/xIsM/TV23H63FtiuZIETds5el6IJ+Qw6i1o8aG0sPyBAY/HyoC2XC2yoVIg89K3zhK/fZeHSFQaDiZ9zVMJhbDrBOXUwgULOzrHov0nRO/mB2FQW6y5s3iIoGKI/TsUBFSQVIlI/x8BF91Qy6maBlQ9rQh1tLYY+eyRgrElIz+q3G/V63SK1Gfh8LW/4wxbjtBDs0eYNXu5PmODBtY8DUC9m3JiUhJ4eGi8Y4RtVxXVVL/dXcASqZKiqmEjYeRc07uV5P3/52D2F23sSpbdO7apjASkdpWScpvsiB9UgFN5Rhz4r3leeqUVlJa1bgTCVXc4OZPR7o4XVK37Q21tiHIne7UkGoUcaT12X+MIjlDUMw81J3Yx86LLuTGmugKNU8fugkJR6mXHbzzkPQnB1Lo9KS7+zOn/LkcmUQq3obo7/xK7vyc76OS/96GFdmHIBd3Bs78RfzCg4y3vxjuTpbqIuYhyp02srSTC0xM32Mhg/80hO/XUp2fkOXY290vtZgssPUNSNF80cJV4ctTvZ1jF3scxEF+30LXNondW+vD7HMpftWj8riaDX8rCy2hKcmm8sXSAqzmpjVsFyVZOMMpZOMBGFzyhsznUbMS4hVZ3LTR6TB2UtWyk2CqciJ4+564SXvvd3OknaM8lNoZQvNAfdSQp+XMfBE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDdZam9lclVMR3pxMDEwLzh5MGthLzRzSHc1Nlc0U1g5N1JBWW41UU9MSEx3?=
 =?utf-8?B?RUlHVDZTRzlRQzMxQnZQc3V3Tnhlb1c1cGsweTdrYmFSeGd0TkF1V1gwR3pQ?=
 =?utf-8?B?M0xBY2MxMWcwZ2lSUkthNzRzZkNYYVZPS25tbmVVcHlkZ0NOWENQY3FXbytr?=
 =?utf-8?B?Zkg1VGFrTVBYRHNWdmhncllCTFh0NVprZGl3SXczZTNaZWU4VWI5RHN5S1lK?=
 =?utf-8?B?U0ZldXJFMG16UW1GUm1YVUV6NEN3aVZhbEk4NTNIalBHQUkzOUQvOXdBRkly?=
 =?utf-8?B?U2hCME9OYWJPU1Nmc1d4eU56RmJDZWVLOElUZmhiVExDY3hEQjJ0VVJ4aVRE?=
 =?utf-8?B?a0NFL1NaN0F6bEd1Rm9BTVBHRUdxY3QyQkNmclV2dGFzYkMvWll6aTQxRGgz?=
 =?utf-8?B?NWZpOXQreUlENCtSQ2NzVVFpeVNuSFRobWQyZmsvQXpUL2ZkM3VNZlZVRklw?=
 =?utf-8?B?dFh5NGpsY0FXV25uMHMwSFRmTjY2L2JhUlpQQllMNlJEOFUzSUpwdmw0alN5?=
 =?utf-8?B?cXUrNzJFZlpOMDh0Z3pTdVRLU0U4MUpyU2pzdGlNdFNPOEI2ajZ5UG81ZE96?=
 =?utf-8?B?bS9iUnArQjdSYXZ0VXduQXQ4RGl5dlNLZm5WQk5lWjgwcWRFQlBkR1NLdC9Q?=
 =?utf-8?B?R21tL295bjlnZmkycUVvYXBlWm9qSjNrUWRGWkRxQnpCWENRTFBITUgxZ0lO?=
 =?utf-8?B?LzBzTzY3ZWdmem56c2pYN3BEbDRZdm5ocEI5Rm5qbHJJcjZwMzh1TGVqZ2sz?=
 =?utf-8?B?T0VhUEpNUHBBTVd2VkxHU0k1Uk1Kb1NrK3FQQWFDVDZ5OEdiREVHTWtKZ0hW?=
 =?utf-8?B?RzQ3cW5qb1FxcWgvRkY0T281ejYyRjY4bUloNlF3TEdPTHNmNmVuSis0YnZj?=
 =?utf-8?B?MWp2ZEtrQ1NET0g0NVFKbHVTZVZldFdyaG84QXBZMTdpUnpsUzlhdDFsbzFn?=
 =?utf-8?B?Y295MTBzWGlSdUVFM2RSZU5XQ0hPRktBb3hWM1VUNnpvMTRKSkxBSjhJUmJV?=
 =?utf-8?B?c040ZWJrUWtjU2Fwc2JocWRjM3pncjllZWh3UkVIYTNGcVE3ZkNoQUFvSFc2?=
 =?utf-8?B?c0t3VHYwcnJhY3k1SnhvZ052ajBIZzRCS3kwRXhTTnk4cWt6TTcxaGYvQUlN?=
 =?utf-8?B?Yzh4eTdvU1dCc0FKYUh6b0RSTEdvVWFGUzFNRE1nUVN6WlIybkxaMHlnQUF2?=
 =?utf-8?B?T0dpcTZPYUU1dmI4dDB0SzBRVXZmVlhJYzd6UlM0WW5IcU1nYmtuNERWd05B?=
 =?utf-8?B?ZGhnM29WaXdEYlMwYVB4OTg0NFgyLzJ0bkVaRXJNaVZZazhhQUNPZmovT2ox?=
 =?utf-8?B?S3ByRDFGY0tuVFFzWWFyQmt1aTZhZE85dTB4SzgxS1VROXo4UFYwOWFLOWZ1?=
 =?utf-8?B?Y1puMXlodVJLcUQwOCtZblZKUDJSS2luckZqYVloczdRZk9WOXd5RjhVY2p1?=
 =?utf-8?B?ME81MHZNdE10cHUzb1V3T0hwN0ZrSDVybS9IdFNIdkZzNmRScHgzdFdhSjRK?=
 =?utf-8?B?NElvQjB3cmJrNVp3MGZjVVFRY09NUDU2dzFhL1BrUjJKY0VXTXI2UzdiWXpT?=
 =?utf-8?B?dHYzZnlmTG9NaXNWK3NwVmpSaUNrK2tIcHFMTG4zOWxENlJJbDdIVmZPUzY1?=
 =?utf-8?B?L3VTSUcyblBvL0lrMkFCNnhpMWF2ejRSaGozN0xRNXFjYlRwZzVKMFZZeXl4?=
 =?utf-8?B?TUlHQmI2S3hHUjVWMmNuNnN1NWJrWnBEMW53TEhXbVVlWmYxVkh2Tk43THln?=
 =?utf-8?B?dU5hY291c3lyKzJKLzhHOXhnWUxnSVhxeHlGZktucGtOaW9KR0c3dUJxZ2pm?=
 =?utf-8?B?SXJoNXBBVWlOS3hpcjdtME40NjIwelluYUd6aEZwalRXdWRIZytsOUZlcDNz?=
 =?utf-8?B?UlRkV2NxTlZwelN6SjdkbVd6WXlZendBVjRtM3dPbVJqbHdTK2pmZFN2UzFX?=
 =?utf-8?B?S3JGY0J5WW9sSGN5L2lETDlIWTFNQzlLOTJFeFBtNHVBQUgzYWM4cFMxSXZv?=
 =?utf-8?B?THZ4TTk1RGJUR2wzVmYxVVJrY0N0Slp2M1NPQUYxOFJCQStzbzRSNjBSUHRq?=
 =?utf-8?B?cU1DTDVEem14dXZxRi9IaTU0U1VNdENZYzhORmg5d3ZreTAvVG1GNm9OSzcw?=
 =?utf-8?B?ZXRpcmxCRjJreUVFTWYxV0FEckFMOGFwanNCZWtZYjl1TzZhdnczcG5pempS?=
 =?utf-8?B?VHhMemZSRlBMQWd6MGlJZVRJeEw2VEVQeDNVZ2ZJWExaN0xBelc3UmoyRlE5?=
 =?utf-8?B?a09XQ0p5NjNKZGdIeGUyRm9Nd0Jac25nVERJbit3UkozeE92L0FRTW9valRB?=
 =?utf-8?Q?FVrLWafmS3WPc+OzRd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ececb10-b47e-4c66-d326-08dee674654b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 15:34:32.5928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTStxZiQqBSJQBdl2DRnyboeeZYXcI4vCQlNLLH6NOH75nfi3Wynp22rEdPGDWecJLXvA37SFwkDaf5doOcfpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6255
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

On 7/20/26 02:11, Kanala Ramalingeswara Reddy wrote:
> RLC and PSP TOC firmwares are different, rest all firmwares are
> same for GC 11.7.0 and GC 11.7.1. Reuse VCN,VPE,SDMA,DMU,MES,PFP,
> ME,MEC,IMU and PSP TA firmwares for GC 11.7.1 from GC 11.7.0

They're the same right now, but will they always be the same, or is 
there a possibility that we might want to have the flexibility to change 
them independently later?

I say this because we can always control this from an upstream 
linux-firmware perspective with symlinks, but be afforded the 
flexibility to change one for a bug later if we desired if we don't 
adopt the code change below.

> 
> Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |  6 ++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 11 ++++++++---
>   drivers/gpu/drm/amd/amdgpu/imu_v11_0.c    |  1 -
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c    |  2 --
>   drivers/gpu/drm/amd/amdgpu/psp_v15_0.c    |  7 ++++++-
>   5 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 4f1c711df5bd..ee0b785b4a39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1458,6 +1458,12 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
>   	switch (block_type) {
>   	case GC_HWIP:
>   		ip_name = "gc";
> +		/*
> +		 *RLC fw is different and rest all fw are same for GC 11.7.0
> +		 *and GC 11.7.1
> +		 */
> +		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 7, 1))
> +			version = IP_VERSION(11, 7, 0);
>   		break;
>   	case SDMA0_HWIP:
>   		ip_name = "sdma";
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 0cbbdc3694f4..710bd195c4b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -137,9 +137,6 @@ MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_me.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc.bin");
> -MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp.bin");
> -MODULE_FIRMWARE("amdgpu/gc_11_7_1_me.bin");
> -MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc.bin");
>   
>   static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
> @@ -745,6 +742,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
>   	DRM_DEBUG("\n");
>   
>   	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
> +
>   	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
>   				   AMDGPU_UCODE_REQUIRED,
>   				   "amdgpu/%s_pfp.bin", ucode_prefix);
> @@ -786,6 +784,13 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
>   			err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
>   						   AMDGPU_UCODE_REQUIRED,
>   						   "amdgpu/%s_rlc_kicker.bin", ucode_prefix);
> +		/*
> +		 *RLC fw is different for GC 11.7.0 and GC 11.7.1
> +		 */
> +		else if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 7, 1))
> +			err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> +						   AMDGPU_UCODE_REQUIRED,
> +						   "amdgpu/gc_11_7_1_rlc.bin");
>   		else
>   			err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
>   						   AMDGPU_UCODE_REQUIRED,
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> index 09dc01a425d1..2fc2a8e4be98 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> @@ -44,7 +44,6 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu.bin");
> -MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu.bin");
>   
>   static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index b72da75dd851..988afc0631b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -62,8 +62,6 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes_2.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes1.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1.bin");
> -MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2.bin");
> -MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1.bin");
>   
>   static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block);
>   static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> index 2a4d91368ac6..c78a8f1e8c8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> @@ -34,7 +34,6 @@
>   MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc.bin");
> -MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta.bin");
>   
>   static int psp_v15_0_0_init_microcode(struct psp_context *psp)
>   {
> @@ -48,6 +47,12 @@ static int psp_v15_0_0_init_microcode(struct psp_context *psp)
>   	if (err)
>   		return err;
>   
> +	/*
> +	 *PSP ta FW is same for PSP v15_0_9 and PSP v15_0_0
> +	 */
> +	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(15, 0, 9))
> +		snprintf(ucode_prefix, sizeof(ucode_prefix), "%s", "psp_15_0_0");
> +
>   	err = psp_init_ta_microcode(psp, ucode_prefix);
>   	if (err)
>   		return err;

