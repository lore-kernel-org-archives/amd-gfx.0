Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEE5C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 11:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2111610EC80;
	Tue,  7 Jul 2026 11:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R0upBV4b";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA7810EC85
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 11:56:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uty8ofeHPxGJD5xxoVO9J8VPzzFql+VSg1zW3MRs4GMNFVRkwZSJJOfNL7TpRQIalSt8uyElKF6z1P5otaFv2LQDzuyo01LBUaGTtgi4oNoQOk3QIqQthUED1872TUuW/CYGgQBZJMxJiHd+XlwGKChq+A9wwOGWqNrmT/PzltSIYbSy0plbh7sNJNfnu2aiZbqnrOkAbJMakR3znykm61refZhw1D2ctNGOiBlmRTmD4Fq0HClUEsZiTHJub1qxwHdHmqFEYMtJ1ZwYW0f/XhkQBbgUpiAZuCutPeAOOlv5HF+USFcMfeUSW3tAZjzX3fCORkkno77rxz0liFZbdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/+0yUX7HxYsaoAg/0CECg3HK8y5tgx14B67/iImpsI=;
 b=t9dGsrgpJjbSGnZwFUPxVSvn4Wvz+eLFd0/gd4FBx9u13ycs9875reJODHMxfZCd5uF4zMRAm3ru0EyXIIwHhsi6fY8YHocBTNMpqnKQLQPaEDBuZkzL9j9mlu4PbuKYcgOuttL8dp3uDSVrzSQIUc2PV2DSFirV4+f0ClLvg1AZnV/V4+V/E7cQu4t9Gtm9pGFKkKzUOMUKfozytKf9gdqyRr4ORW5T/BnFb1436NBaZoFisLp1wPMy1EmEUIZrzcEBmoAlBumgkFNcXbPv67wn2664pXgX9GctQaskI4Q+mk4wa6F40+1dZk/Jf+Q/xLXcb7/dlsowW2JoDMyAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/+0yUX7HxYsaoAg/0CECg3HK8y5tgx14B67/iImpsI=;
 b=R0upBV4beMDjtMqcxvVVcCPFmRODfWkkA2zK57vwJyr4hVIo2kaaGP816LJ3QCHXKyvR0oc6y84lHOac0pGVqvdNzQqIGxSBym/fKUYhiJtOYH3hp6NeC/7742C57e6qxb8a8g9SZSAPYMXjOHRurMbgkuuejQRNABGSVHa8NLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 11:55:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 11:55:58 +0000
Message-ID: <292b2854-8506-4186-acca-1f92bb34851d@amd.com>
Date: Tue, 7 Jul 2026 13:55:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: improve the amdgpu device init
 progress in sriov mode
To: chong li <chongli2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Emily.Deng@amd.com, HaiJun.Chang@amd.com, Victor.Skvortsov@amd.com,
 Cursor <cursoragent@cursor.com>
References: <20260707113423.159063-1-chongli2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260707113423.159063-1-chongli2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0055.namprd20.prod.outlook.com
 (2603:10b6:208:235::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf38b87-d5d2-424c-c046-08dedc1eb4b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: sm3F4LZpkC/sB2JrZZeGZioNCesFbwJr4tS6zjaqwEX/V0l2hT25bLsDUh82Q/0hs9N5XMpgTlaZtVWz53HzyNSGl/Mubc1TX+bQkoyG24rq87Wf6Xc6IxvWm3F9j/6m7IUbO8GMGoNtXDdX0QUjdJoObXaRY89H6Hgd2r/uEwiU8MgvS62pEGuEmJMdRUdUcSdZ5ASnH+1TXE2ML7+kEjZeOFugebkVfbJybTfuhBeuv3Mq0uGJJqADfBqhE8kmxwhWLBQ5u6adtCyGKhoD3ORC+z7bL/mLm7QZZhtV13jWiXYly69ROnW8i7+avqBMQfohwuAgihX+loX6SKEOJk0arTZUe7G/V2NC94fOjRtlp2a2xnuVXz6BGz/069JukDLXP3L6wqd7x/VA4pvGgAxb57HF6ZeHmoQHp+1F03MAd9HuJ1BaDM5xEaYiHfALHL6zm4ebXSE8YF4CVr0SepdMrHfdmOtWPYOsHWrZGVafD0JogEvmP7gchQIsvT80Gag1ygAwmLem8FXHsC/iOwiXy3wMl7/rjy/pRePM5GDN4tZLagfJtz6NBLzTyrbkapI3U/n5kHcXT6KNCDiwriTfYKCFMw8h797TpnWUOW9FvEOQ1PM8vyQSAXMoC5AjUpQXkk4lLn3hA9bDW6JbDbKOeS0jaPmM+UJdeeUKJcs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjRyazU2eHJWK3gvVzdVaWlRZUtHZThyekdZN1AzakZmM2Jha0RQdVF0bHZK?=
 =?utf-8?B?Umh3dGVKQUhqSDZUTm1ESGQxNzBWcjRUSVlDT053RWVZaDVaZ2JWV24wUmJH?=
 =?utf-8?B?cGdvVkVmWk14NTdydTIrdGlkelpUZmRNN3d4UFVONFIvWjBUQmxDSVlzaTkz?=
 =?utf-8?B?dWFtM25JUGRMUDBqdzRFSytBMitQUm9ySUJvWDYva0F5Uy9SUnZ1L3dnLzV4?=
 =?utf-8?B?ODJrWnp0eHpDaDFOcEFOWWN6eGpmempDZHpuYkZvK0I4M1h4TjlaR1FzNEJv?=
 =?utf-8?B?RHhweGhnMXRMZGZRTFp5cFpGVllDUnNLN0tCbzhKWnBEcWhUbDdiVW9ZMlVa?=
 =?utf-8?B?UmRxZC9yM3dIa1hCQ1JxcE4vREs1QnF5OVJWYzVKVzdkTHZzVW9HYmZMMlpJ?=
 =?utf-8?B?dTJsN054cjcvQmlIanVSUUlzWG1vSlg5YWNqNW5hL290SnRtaWdHdG13eTdH?=
 =?utf-8?B?YkFmTDNKdjhMZzJYUUdqeVg2WU5vN21HcmlQYjNVZDY4V2c4eDkvOTQ1elRo?=
 =?utf-8?B?Y25aenFuYlZWRXExMjN6Y2tDWnRZQmVmdjNMU3FEbjVkZ3B3Yi8wUTNXVmpN?=
 =?utf-8?B?djlXNTZjUDN5WlRvYURYRnpMYkMvdXpya3hlL1gvRjk2RU9NYlNJek1RVWxx?=
 =?utf-8?B?bnM3TnRwY1BmbkZwc3llOXVPb0VlaitzUHRIWThGVEVwNzBhV24yRkt5ajF6?=
 =?utf-8?B?ZTdtN0NMTGhmWWIvOGdQVHU1OHJRQzRkV0F5aE96MHR0WnJoRjh3WC91YzQv?=
 =?utf-8?B?OFc4ZE9ESzNiZW1OaWdvOHllUzNDQTdLNTVmVGcwekRRZFpXYmlDbURaS1Rl?=
 =?utf-8?B?OUxLYXJURkYyQVZQa2Z3ZjNoTWhzWWFlYkFaZ1lrNzVPMTArcTFOWHFRQnFE?=
 =?utf-8?B?RmRRdEhaMkYrc3hLZ0xhc2gyZ3A3QnRLRlVENDl0aE03ZUgxMFN2N0pzbk90?=
 =?utf-8?B?QXdHV0cybFlUSjhiUXBUS0dVN0FiYTh2QUQ5bTR3d0ErTWlmampubmZaZWpW?=
 =?utf-8?B?WUtJNEhWdnliU3VHU0pta3ZXU3pERkNCVDNsaVFEODFBM3B1dlcxMHcxUVIr?=
 =?utf-8?B?RUJlY2N2eHlRNVlIUWN6SmR6WnVHdXJObElwZGNYbVdkWkpSWDA2ZXdoT1lE?=
 =?utf-8?B?SGZ4Mkl5ZURzOHJGT3lOckVocDVKdDdKb2VlTVltOEptbjVhVU1OQXVmcnhw?=
 =?utf-8?B?MjJBSTd1d2JvT0ZDaHhSNDhtUGN3TklLVUVjTEhrNHp3TEtPRVZiV0J3am5u?=
 =?utf-8?B?N3RiYVN3K2tkcW4xK2IvY01nYnZrVjBxaFcyaVpYWnF4SnMzcWFXZFFZR2NV?=
 =?utf-8?B?d0pZaWhaREVFRHdwTFlIOCt2WXZjTngrSElVZHBKaEpBM05QRzBoSk1IczJK?=
 =?utf-8?B?UmROMVNIaFRrWUM1QzEzcWhOWlcreWFXRXh4VmhRMTJ4dGIwTDE1dUxDbjZQ?=
 =?utf-8?B?TjlLM3FBZndjSUtPWDRkMytLUW9lRmFaUllzdmhDdnBlT1FrcFVTcnZiZ3lu?=
 =?utf-8?B?Y3lONFNEVWEwSU8wKzZZZCsvTCtvVTRRU0tUS0cwTDNCNkl4UjYyRzNWL3Y4?=
 =?utf-8?B?Szk2Q2t1YSt6SHFrMVVQR0krSW9wNkdpTFNPVTFaL2o5L3plZEx0TWFwbHdE?=
 =?utf-8?B?ek85ayswNGV1QlNaanlYM3Jza3lTYnlRSDNuUEY5R2kvd0gxU0lNUTVVLzdY?=
 =?utf-8?B?aHRDTUtYVmlKRS8wVkxnZCszSUNnTllOMUVYalZRRUJ3cXRGejRQUnh3NmFY?=
 =?utf-8?B?TGtoY1orTktuOFNKK09aMS9VWm9RWm42MVh1TE94bzVaWlFiYXlBVVRMR25t?=
 =?utf-8?B?M0lscE9ad2hDUnFXQlFZMTkreVRtdFZ2MXNRemNDeXA3WXE1YWVlN0xxREls?=
 =?utf-8?B?YUp4US9rSWszNTAyZ2FyZWp6KzFlbUw2Sk1DODVUbmY4aWFrVUFMS3JWSCs5?=
 =?utf-8?B?aG83NW9Ydm9oNUgwd1BlS0JFQ0Q1VXN0OGQ0WVgweW53Q1QxanBQMTBYek5t?=
 =?utf-8?B?Vm15NWVvVXFYbG1CMm1uQ0FEa3BVbE14cWVqVmVSTGtFZS94V2pkTDV3ODM4?=
 =?utf-8?B?b3VXbkMxck9NaTZUNkJuZS9ENWgyMDlVMlhWWERxbkxGeDVWeE5ET2lJczRR?=
 =?utf-8?B?NjBJTjJWUHVlbDA3WW1PQkw4VFV3aWJZcDZHd3RNdEY4KytYNDVXSTBIRHJB?=
 =?utf-8?B?L0lObmswakdCWWFQWkVMV1E3ZWdqV0RUOWhDVFdDOTh1Nmx6Sml6WjJpWVMz?=
 =?utf-8?B?bWVUWTAvNnFvamxtMlVOT1NLRUJ6K2JVY1UyZkRUaDhXOEt2d294Y2t4T0tq?=
 =?utf-8?Q?e0xcfC5hgmYAdpvCi9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf38b87-d5d2-424c-c046-08dedc1eb4b4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 11:55:57.7802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yyfua68Jp/N82PT9p/6z86wyrazeOxa1cX2ZTsmHEtW4OmOIUsLAnqWF8n2pBkkh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085
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

On 7/7/26 13:30, chong li wrote:
> v2:
> Some legacy ASICs do not support amdgpu_virt_request_init_data().
> On platform ESXi, the PF can access VF VRAM only after the VF
> enters full gpu access mode.
> Only move the full access request later when the required conditions are met

This is adjusting the driver to the hypervisor and not the hypervisor to the driver.

If the existing init order doesn't work on ESXi then that is an ESXi problem and needs to be fixed there.

So still absolutely clear NAK.

> 
> v1:
> Move the initialization of non-GPU resources
> out of the full GPU access region during AMDGPU device initialization
> 
> background:
> 
> After the amdgpu driver sends GPU_INIT_DATA to the host SR-IOV driver,
> the host dumps the IP discovery/VBIOS/PF-VF exchange data into the VF FB.
> The VF can then read these data blocks without requesting full GPU access.
> This is the purpose of the GPU_INIT_DATA event in the SR-IOV init flow.
> 
> However, during ip_early_init, TTM is not initialized yet.
> The current amdgpu driver therefore falls back to reading these data
> through MM_INDEX/MM_DATA. That path requires register access,
> which still needs full GPU access.
> 
> As a result, even though amdgpu sends GPU_INIT_DATA and
> the host prepares the init data early,
> the full GPU access window is not reduced because
> the guest still needs full GPU access to copy the data.
> 
> To fix this, use amdgpu_device_read_fb_via_bar0() to copy
> the init data from VF FB before TTM is ready.
> For this early copy, the guest no longer needs full GPU access
> so the full GPU access request can be moved later.

You are just explaining the chicken and egg problem here instead of giving an actual justification.

Regards,
Christian.

> 
> Signed-off-by: chong li <chongli2@amd.com>
> Co-authored-by: Cursor <cursoragent@cursor.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 +++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  4 +--
>  2 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 610d82b79de3..ec353f4dd0d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -38,6 +38,10 @@
>  #include <linux/apple-gmux.h>
>  #include <linux/nospec.h>
>  
> +#ifdef CONFIG_X86
> +#include <asm/hypervisor.h>
> +#endif
> +
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_client_event.h>
>  #include <drm/drm_crtc_helper.h>
> @@ -1973,6 +1977,17 @@ static struct pci_dev *amdgpu_device_find_parent(struct amdgpu_device *adev)
>  	return parent;
>  }
>  
> +static bool amdgpu_device_delay_full_gpu_access(struct amdgpu_device *adev)
> +{
> +#ifdef CONFIG_X86
> +	return adev->virt.req_init_data_ver > 0 &&
> +		(hypervisor_is_type(X86_HYPER_VMWARE) ||
> +		hypervisor_is_type(X86_HYPER_MS_HYPERV));
> +#else
> +	return false;
> +#endif
> +}
> +
>  /**
>   * amdgpu_device_ip_early_init - run early init for hardware IPs
>   *
> @@ -1987,16 +2002,19 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_ip_block *ip_block;
>  	struct pci_dev *parent;
> -	bool total, skip_bios;
> +	bool total, skip_bios, delay_full_gpu_access = false;
>  	uint32_t bios_flags;
>  	int i, r;
>  
>  	amdgpu_device_enable_virtual_display(adev);
>  
>  	if (amdgpu_sriov_vf(adev)) {
> -		r = amdgpu_virt_request_full_gpu(adev, true);
> -		if (r)
> -			return r;
> +		delay_full_gpu_access = amdgpu_device_delay_full_gpu_access(adev);
> +		if (!delay_full_gpu_access) {
> +			r = amdgpu_virt_request_full_gpu(adev, true);
> +			if (r)
> +				return r;
> +		}
>  
>  		r = amdgpu_virt_init_critical_region(adev);
>  		if (r)
> @@ -2159,6 +2177,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>  	if (!total)
>  		return -ENODEV;
>  
> +	if (amdgpu_sriov_vf(adev) && delay_full_gpu_access) {
> +		r = amdgpu_virt_request_full_gpu(adev, true);
> +		if (r)
> +			return r;
> +	}
> +
>  	if (adev->gmc.xgmi.supported)
>  		amdgpu_xgmi_early_init(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index 9a40107a0869..340703d89d6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -185,8 +185,8 @@ static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
>  	} else if (req == IDH_REQ_GPU_INIT_DATA){
>  		/* Dummy REQ_GPU_INIT_DATA handling */
>  		r = xgpu_ai_poll_msg(adev, IDH_REQ_GPU_INIT_DATA_READY);
> -		/* version set to 0 since dummy */
> -		adev->virt.req_init_data_ver = 0;	
> +		/* Version is set to 1 since GPU_CRIT_REGION_V1 */
> +		adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
>  	}
>  
>  	return 0;

