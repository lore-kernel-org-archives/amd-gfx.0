Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A2606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 04:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Q8t3zkxn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D10810E136;
	Thu,  5 Nov 2026 04:25:35 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E78810E136
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 04:25:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NN7y5WBP9VhcQslqwZbi5UQe8i4CnRM6Y2xanrGJx+MuWtn05ZGH44TXCuHdk5TI3ATLqgseozUIsc17wjzWpjBxw3QsCxfXk3ycPlRyd/V6NxHzAx8hP2fng2wmESZNv6mxce46WpeMV5oOkSQ2zXdmvpyI8SE52vWF9oi5BRDqWC/s/cftuRj3stkHhCLzmYQEH4f9VIymf38KYpVKPMLJBIReaucqGXu5uNCOyTCpJgIIRtsc1IimnoEJ6QMSTxlsqIvqZ4K84Ptk3K/2uDxBkP3iWAHkrf3j1GlWRzrbM+ViE9YMNmUJ3SyRINvedBIx8X8AFcKAFuURIsq/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccM4MvHYKzXXGeDEuGdEyIwOu9xZ+FZ4bDuyDleq5N0=;
 b=OkLUAIjLmmKMtrjqSl7Xac+bEZoQRakFwjYSysWK1YtEK7ywkl70xq4HrWMO0OIFdr9s5cAOqw0dNklpkNl0ctq799MRyAs741SMp398O6HQsI7wMsjz25b7vFdaQyux9008EuQ5VUS3AG1SsYjIjQOpWAzqWbmsLn/1+Gkt6uuu9DOwpMLhyGHjqSAtS0FsSCITZ+Ou+cZN3FW/aSiF3zyOSWCgAbkQUBDArQrHvZwb6OKBHNlY2ObqBcrAr6PYPn/nykDVwhckr/31B5IUwxjyEy187yYC/f/RTqjrahXS/PMwb0IDPpGeAf+ko7qGPqCzh8bKn2Cx0bCP50I9CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccM4MvHYKzXXGeDEuGdEyIwOu9xZ+FZ4bDuyDleq5N0=;
 b=Q8t3zkxnS28xoeQJWJF1g9xTqh8CiBvwXb1A+RBTHApSQMsm07ZF5dfIyUfN1pG4uX6pNNApXndcMdni4wOQGYs0uuO/d7974Z21tezYfW0fpyWzMqWiV8Uw31AHsjIH42r4arNXM5V2ll4923b3251oPvF/geHbCVhUtEPkMsI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by LV2PR12MB999073.namprd12.prod.outlook.com (2603:10b6:408:352::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:25:25 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 04:25:25 +0000
Message-ID: <19bf8040-a9e3-469d-99bb-119eb333085e@amd.com>
Date: Thu, 5 Nov 2026 09:55:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: abort SPM VF init when the HBM
 aperture is missing
To: Chenglei Xie <Chenglei.Xie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Victor.Skvortsov@amd.com, Zhigang.Luo@amd.com
References: <20261022153132.211631-1-Chenglei.Xie@amd.com>
 <20261104162321.75300-1-Chenglei.Xie@amd.com>
 <20261104162321.75300-2-Chenglei.Xie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261104162321.75300-2-Chenglei.Xie@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0019.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|LV2PR12MB999073:EE_
X-MS-Office365-Filtering-Correlation-Id: b22957c7-290d-4660-6969-08df3af4d03b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006|4143699003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: h+C8mB2BDnM4WgKoWToCDY8eBZZOq4n1Ok9kcePAH/iaRyi6HAJKiMyVuCzbRQRYdT8E2TYkW7NuvJaVYavzbxBsery5dbBgI+2GSip6Nbsu/IKxdjN8fXlf7fzqwcD1R7avnCmSFolqTsh/d1YXxB/XEkvBA9fnhlIomq/fnmjvw/jfW9P5WHabaxQG/oN5L1AFe8mM7iIrogTHKu6FxVZtdbDeaPmzGTBcBdevlWpIeEUSVfvaPv6eNPPIlFtcG2xELnXwdTJ9WOThoArROJ6VOF7kIbRv0akQlzjghP8g/Pj92x/jR6HkLFtikQQatEHTJ4+h+zgw6C+qJoKTX7GqfSpXyAU0Yjm0yESRFrDFmG+5NYqkE3V71KmlVIJnB9DKQmyCkxf9L1xamIZjagSOYNt5gIIw+pRA7cjXtB9RX1fgyexXhqYLDM4jixJAsTp7KDLuXTI5aEhGnfLiEFg5O7DU7W06cUW/7X/mJCUryy4/nAx3KzfLTRcTgYzRMSpoCPQIPKkIWyfCK8RLsBC7+QAec1EdPttHMXMC1XYyZOTsQCpvFXbOycg75d3JYxIkyO8bznUe34BeRFKAh4WmufA7gbWvRuIqBtw2H27x+/V9TQ4mcJBs8xYQNu+B6tUV2hl8hyAgIFWShDCfoo0OMOOH3XSo1FmbYzc2KII=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261102123227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVViT0RnWWV2aW9VWUpueFZMOVBoTHBWWGh4WVF3VWxNb3JpM0Z3UmhkMU95?=
 =?utf-8?B?Tk9Eb3I5YWxQaWczZDlteVZ5Mms0RWlPTzNvY0hGNDIvcHZPWkFZcGw4MEt1?=
 =?utf-8?B?MEgySFhCR1JyUHBjZzhSVFBKK1VrSE5lVmxmM3lsRU4ybnZaUi9EZjlnM294?=
 =?utf-8?B?cmJDKzcyT3g2dWhZbHlOKzhOeFl1NzU4Ty9nQmRaMU85dFkyVXh6NHd1Tm9K?=
 =?utf-8?B?UTlJMWNna1NCNlJoNElUTmFXTWd6czZ1elBmL294TGRVTEVYMWpJalo3VDZk?=
 =?utf-8?B?SExucVFTRkV6a29YY2NtVFI1QWRrcjNrRjh0b2xwWlVBUUM1MGxZUGxUU0hp?=
 =?utf-8?B?SmZJOXZ0NDI0KzA2ZG1LdXo3dFBIWXUrTEs4OW91cGo5bndlT1pVUnVZSktt?=
 =?utf-8?B?MVZiVlBoUXpsaXYyLzhtVXBndnY3WWtNZXlXSW1DYm43TzZqMkFnMmlqdThJ?=
 =?utf-8?B?anZEUzI2eVVkZlBtTVIrYXJhT041RFlNVENacmZ2N20vemJ4RTZNN1BnMG9Q?=
 =?utf-8?B?VzM1cWVkV1J4dGdHRk9DZGhBeHcxdGxRdEQ2WjU3VWlzNG9wMVRXc1pvNG5j?=
 =?utf-8?B?dndqWUtySkxKdGpjcWI4STBUeUsyM0FxRjZMWldkRkcxWkJpMng3TzlxR0Jq?=
 =?utf-8?B?T05UWnNMSVI1OUIxaFZzTUlnUG5jY1NvemluL1h2dEk3cjZtMlVyV3Z1REh3?=
 =?utf-8?B?TkM5aFJPYlpJVnBnTmVvbVVISkNMWU9HeDRLV25WdXJQd0VFa25kVmZOQjR1?=
 =?utf-8?B?ZGc4aFJXZHB6MzloWitQK3ZYUjVjUzFCb2ZjcWF0d3VWWHY4c0RiNmVTU0hG?=
 =?utf-8?B?c3BOblBCSmJSakZNYkhIcE9aRUc2TFoxN09xOW9IT1BtQnV6b011S3hGVlRP?=
 =?utf-8?B?NzlTV1k1VDBvZmttMWpxSTV5NndxdDlrLysrZ09TR3VvM0J0Y3pOZW1ocks4?=
 =?utf-8?B?ODViUXQ2aVBub0Mya3dJZWZnMUxwS2lHenVYL29xSWZkU3IwNjVBL1FnS3V6?=
 =?utf-8?B?Zm11blBaSnR5MWVsRGlpdjJQL1dDYTRrQlNMUnROM0RNRnZaRTJNUWwzN3hh?=
 =?utf-8?B?UHRWbzRmSWx0dEVMYmUwbGJHQWIzcUlmZGwwUkhZQVMvRzZBdzdTcDVCY1ZN?=
 =?utf-8?B?VzFucTdlNUV6eFk0eFhTaHVUM3ZzTURSRHZDSkFIWXI1ZFlubkdCcHJFeFdR?=
 =?utf-8?B?VmxSMGpmTGVldGwrbHg1SHhNbEJFbXRacytoeUgxdWRhYTVkM0Vqa1dwYmdr?=
 =?utf-8?B?dEhSVGgveS9IN0E0d09peUZwSTdqWUg0QlNtZFlEZnBydCtkTWEzajNjRnpk?=
 =?utf-8?B?bzRlbnZ2N2F6ZGpXZExNVkFMTVh0aXE0K09lOTl3UkVocGNrempUTUEwOWlF?=
 =?utf-8?B?MXdkVWcvdGxoa2VhbUJMMEhER1p6Q2Z0bGJUMkVkNkpuVU83YkFIZGxYaDlQ?=
 =?utf-8?B?V1lKenVsS3lyOS90VnY1U1NiczJxTGVHVHdaWnJSWnhxQ2FRWE5GcGZGZ0Jk?=
 =?utf-8?B?VEQrQnFvMENYN3ovUlZhOEV4V2dzVzhnUlR0Nk5vRTdwNUdBWmlyNm5QVDVl?=
 =?utf-8?B?UjZoL0VHUjFCMkZvOWdTVTBFVzVxMFBvK1NGeHZsaHFQaTlaeXJxS2JZM3hQ?=
 =?utf-8?B?Vy92MFI1eUkwV00yVFJ2NDdPV1ZVZm41TEkzYmxxM1ZJOGliZ2lvRUFlVjZl?=
 =?utf-8?B?a3lrL2o0TUhLYlpVaThpWmkrdnlNbHNoNlFnZnllZ3Voc050Z0U1dC9QaWdu?=
 =?utf-8?B?eER6d0dFc1lDOWtxSHZieHRCbnhsTWQ2SmlKRFI5Sk5PTUtwVnVacHNlamhO?=
 =?utf-8?B?V1BQbkxyTzZ3Y0IrbFU0b0FiQWlkdzhTM3UzRzRkbXFZblZWQ0E0R3MyeE40?=
 =?utf-8?B?cUdlSFFuZTlldkcyZTJqcm4zZms2Zysvb04yTDFjL2RDNEVEL296ZVFYWlkz?=
 =?utf-8?B?VnlLRUhZcE5WOEtRSzI4WGJ4WGdwZWFSUWRQa3d3VHphaG5HV0NaWFlkelB0?=
 =?utf-8?B?UVprc0d2M2wrVlk1RUVVa3B2cGZPbTI5dnZ0eDFJdmNiU21RNmlPVkd1b0ZX?=
 =?utf-8?B?Q1RITmUwTE11YkM1c2x5aVBZbkhWU2pDWDREZjhrK0NGYS82N25UT3VETE1J?=
 =?utf-8?B?WlRDbWgzK0E5SjJTVlBiVkp0VzJjalNNdm0zRDlNT2cxVEhlTVh5RDZXQW1D?=
 =?utf-8?B?VDJrM2c5VWlGYVVXaTJyMFpIS3pGM1dzSjFrS0JGc2VWclJoM09TSWliYUcz?=
 =?utf-8?B?RnN0TnhTd0pBNmtjNVdkaTZDUTgyTEMvUDVRYTlnT2tIS1doQmY0M0pHVzNL?=
 =?utf-8?Q?iHZJ1Vjm/7u54uXL+Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22957c7-290d-4660-6969-08df3af4d03b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:25:25.0948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFNMl6REVU2wfuwSrW3SdBl6HPc9qUaPuG71Re38jA0nIlnmj6lx1ESHIa3S1Tul
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999073
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 04-Nov-26 9:53 PM, Chenglei Xie wrote:
> An SPM backed VF has no FB BAR0 and gets its HBM aperture from the ACPI
> SRAT. When that entry is missing, amdgpu_acpi_find_gpu_memory_in_srat()
> returns -ENOENT, which the early init IP loop treats as the GMC block
> being absent. Init keeps going and dies later with a confusing -ENOMEM
> instead of the real cause.
> 
> Return -ENODEV from gmc_v12_0_early_init() so the probe aborts at the
> point where the aperture is actually missing.
> 
> On a legacy host the VF already holds exclusive GPU access at this point,
> and the early init error paths returned directly without releasing it, so
> the host timed out and FLR'd the VF. Route these failures through a new
> err_release_full_gpu label that releases the access the host is waiting on.
> 
> Add amdgpu_virt_deactivate() to clear AMDGPU_SRIOV_CAPS_RUNTIME and drop
> adev->virt.ops, and call it from the same label, so the later fini path
> does not send a REQ_GPU_FINI that the host will never answer.
> 
> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
> ---
> v3: Route the initial full GPU access request failure through the
>      err_release_full_gpu label too, and gate the release on a new
>      full_access_held flag so both acquire failures are handled the same
>      way, per review.
> v2: Move the runtime cap and virt ops clearing into a new
>      amdgpu_virt_deactivate() helper and call it from the label. Drop the
>      redundant SRAT error log already emitted by
>      amdgpu_acpi_find_gpu_memory_in_srat().
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 55 ++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 12 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     |  7 ++-
>   4 files changed, 59 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3ced5c18daaa..a0b9cff01bbd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1977,7 +1977,7 @@ static void amdgpu_device_init_pcie_links(struct amdgpu_device *adev)
>   static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ip_block *ip_block;
> -	bool total, skip_bios, early_full_gpu_access = false;
> +	bool total, skip_bios, early_full_gpu_access = false, full_access_held = false;

<nit/style> reverse xmas tree order.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>   	uint32_t bios_flags;
>   	int i, r;
>   
> @@ -1994,12 +1994,13 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   		if (early_full_gpu_access) {
>   			r = amdgpu_virt_request_full_gpu(adev, true);
>   			if (r)
> -				return r;
> +				goto err_release_full_gpu;
> +			full_access_held = true;
>   		}
>   
>   		r = amdgpu_virt_init_critical_region(adev);
>   		if (r)
> -			return r;
> +			goto err_release_full_gpu;
>   	}
>   
>   	switch (adev->asic_type) {
> @@ -2012,7 +2013,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   		adev->family = AMDGPU_FAMILY_SI;
>   		r = si_set_ip_blocks(adev);
>   		if (r)
> -			return r;
> +			goto err_release_full_gpu;
>   		break;
>   #endif
>   #ifdef CONFIG_DRM_AMDGPU_CIK
> @@ -2028,7 +2029,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   
>   		r = cik_set_ip_blocks(adev);
>   		if (r)
> -			return r;
> +			goto err_release_full_gpu;
>   		break;
>   #endif
>   	case CHIP_TOPAZ:
> @@ -2047,13 +2048,13 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   
>   		r = vi_set_ip_blocks(adev);
>   		if (r)
> -			return r;
> +			goto err_release_full_gpu;
>   		break;
>   	default:
>   		r = amdgpu_discovery_set_ip_blocks(adev);
>   		if (r) {
>   			adev->num_ip_blocks = 0;
> -			return r;
> +			goto err_release_full_gpu;
>   		}
>   		break;
>   	}
> @@ -2062,7 +2063,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
>   	    !amdgpu_device_get_rev_id(adev)) {
>   		dev_err(adev->dev, "Unsupported A0 hardware\n");
> -		return -ENODEV;	/* device unsupported - no device error */
> +		r = -ENODEV;	/* device unsupported - no device error */
> +		goto err_release_full_gpu;
>   	}
>   
>   	if (amdgpu_has_atpx() &&
> @@ -2123,7 +2125,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
>   			r = amdgpu_device_parse_gpu_info_fw(adev);
>   			if (r)
> -				return r;
> +				goto err_release_full_gpu;
>   
>   			bios_flags = amdgpu_device_get_vbios_flags(adev);
>   			skip_bios = !!(bios_flags & AMDGPU_VBIOS_SKIP);
> @@ -2131,8 +2133,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   			if (!skip_bios) {
>   				bool optional =
>   					!!(bios_flags & AMDGPU_VBIOS_OPTIONAL);
> -				if (!amdgpu_get_bios(adev) && !optional)
> -					return -EINVAL;
> +				if (!amdgpu_get_bios(adev) && !optional) {
> +					r = -EINVAL;
> +					goto err_release_full_gpu;
> +				}
>   
>   				if (optional && !adev->bios)
>   					dev_info(
> @@ -2148,7 +2152,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   							adev,
>   							AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL,
>   							0, 0);
> -						return r;
> +						goto err_release_full_gpu;
>   					}
>   				}
>   			}
> @@ -2159,14 +2163,17 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   
>   		}
>   	}
> -	if (!total)
> -		return -ENODEV;
> +	if (!total) {
> +		r = -ENODEV;
> +		goto err_release_full_gpu;
> +	}
>   
>   	/* Request full GPU access only for the remaining SR-IOV init work. */
>   	if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>   		r = amdgpu_virt_request_full_gpu(adev, true);
>   		if (r)
> -			return r;
> +			goto err_release_full_gpu;
> +		full_access_held = true;
>   	}
>   
>   	if (adev->gmc.xgmi.supported)
> @@ -2184,6 +2191,24 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   	amdgpu_smu_early_init(adev);
>   
>   	return 0;
> +
> +err_release_full_gpu:
> +	if (amdgpu_sriov_vf(adev)) {
> +		/*
> +		 * Release the access the host is waiting on so it finishes the
> +		 * handshake instead of timing out and FLR'ing the VF.
> +		 */
> +		if (full_access_held)
> +			amdgpu_virt_release_full_gpu(adev, true);
> +
> +		/*
> +		 * Mark the VF inactive so the later fini path does not send a
> +		 * request the host will never answer.
> +		 */
> +		amdgpu_virt_deactivate(adev);
> +	}
> +
> +	return r;
>   }
>   
>   static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 576a818db522..a4dd0299fe11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -135,6 +135,18 @@ int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init)
>   	return 0;
>   }
>   
> +/*
> + * amdgpu_virt_deactivate - stop driving an SR-IOV VF after a failed init
> + *
> + * Clear the runtime capability and drop the virt ops so the teardown path
> + * does not issue host handshakes the host will never answer.
> + */
> +void amdgpu_virt_deactivate(struct amdgpu_device *adev)
> +{
> +	adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
> +	adev->virt.ops = NULL;
> +}
> +
>   /**
>    * amdgpu_virt_reset_gpu() - reset gpu
>    * @adev:	amdgpu device.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 3971bcc1ed11..3520af170278 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -471,6 +471,7 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
>   void amdgpu_virt_init_setting(struct amdgpu_device *adev);
>   int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
>   int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);
> +void amdgpu_virt_deactivate(struct amdgpu_device *adev);
>   int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
>   void amdgpu_virt_request_init_data(struct amdgpu_device *adev);
>   int amdgpu_virt_ptl_request(struct amdgpu_device *adev, u32 req_code,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index cd276a138e10..3bb13cfed92f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -667,8 +667,13 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
>   
>   		r = amdgpu_acpi_find_gpu_memory_in_srat(adev, &aper_base,
>   							&aper_size);
> +		/*
> +		 * An SPM VF has no FB BAR0 and cannot init without the HBM
> +		 * aperture from the SRAT. Abort this GPU probe instead of
> +		 * limping on as if the GMC block were absent.
> +		 */
>   		if (r)
> -			return r;
> +			return -ENODEV;
>   
>   		adev->gmc.aper_base = aper_base;
>   		adev->gmc.aper_size = aper_size;

