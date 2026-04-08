Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E281073CBE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 13:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A95010E665;
	Wed,  8 Apr 2026 13:44:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VaW3xNSw";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 831C210E665
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 13:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVtmMkbt7uvesSTFkweLgmjPMONq55cH+aIp+q9cZEQcFa5R7dKEixW7AGkwp6htgfFPBzidYau0x7f5KJn4xgWshOHI5QSqdsXV4egexyGPiAM7c8bnEz4Ze0MtdpfCs6MkorbKl81JWBNqx2/ek77J7iaVxlAdAqDZHN4UgvS9olDIREcdjeksoAFVKX3t5wMnv78xP/6h1bvrLBfLKoPlpUYo4ffWwWVkLw8GaLpq531qEIZiqYWYD8/OWmvw/z9wk3PuCfUxXm6h6RqzDYZw/cbcYwEpqFSGmwq7bfT5pdB/N8fsmD8cKU2lHEKmB6ePUINE+kfrrKMkV4RHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1g81J0OQIwkCennBXxveLHltRF4kxAn+hR3N6GTFZkk=;
 b=c6PYRBdcs76wz0Ovf6gN1C/3EdAuzXS1LHa8mt3sLKZH+Txb6bJzIgh9IunMXdY14GUM3VmyEJUEg5F3LdzbIySKAF3nfLoDUrEECjY11FiBiR/Ykdrjck3Ls0pFb3h5JIwbCYX1QbAZX/RU+rDuO3l5myzJQSPUntcX2iQAGEoZAZ98E9II+7eDahmYG/h+sNqxZ6Bh8D8+ZxzmM8tOyLUOnJOuWv6oTCPs+Gdzj0B2GMuTiIxVH9ZEjtlk4GNM4xDP59uvXzE6TzPb88/ctkZLevb94f0HJ5vmLQqNcbkGIttLZwS/mxQowRp0RO1aogJPAokwG2IyMis0SASiyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1g81J0OQIwkCennBXxveLHltRF4kxAn+hR3N6GTFZkk=;
 b=VaW3xNSwVFj+N3+5M5P+1eur2VVR2pj8o1JABSAGndOw7ZfOy5FknglYlI+rfeiebyL+ug+YtPuqyDGxpyLDHvKOQnx8nOwFAxFFZ8UYeMtfGvYyVLa4tVIGMnFCRsmsSKG5P7Xx7g9Woo4vX63jp+FEz4Va88+lV3hVjF+n1G0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 13:44:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 13:44:18 +0000
Message-ID: <e9d81bec-acc2-4b39-bc27-214273790f0b@amd.com>
Date: Wed, 8 Apr 2026 15:44:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [[PATCH v6]] drm/amdgpu: gate VM CPU HDP flush on reset lock;
 force-complete KIQ before VF reset
To: Chenglei Xie <Chenglei.Xie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Lijo.Lazar@amd.com, Felix.Kuehling@amd.com, Alexander.Deucher@amd.com,
 jeffrey.chan@amd.com, zhigang.luo@amd.com, Harish.Kasiviswanathan@amd.com,
 Victor.Zhao@amd.com, David.YatSin@amd.com, Lokesh.Dhinakararam@amd.com
References: <20260408134237.459380-1-Chenglei.Xie@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260408134237.459380-1-Chenglei.Xie@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 310a0bdc-2eab-489b-1afb-08de9574ee7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: KNw425mS6yHuXNZdLPdxzrrvguXm6hRUUBZZMSgo5EKT8RZ39qygbMLIjEd0u5hSQpTgMdoXD7nBOPOvrjU13OaZTnzCnEaAT5BCELYKubgZt/d+oTd6VvXnzSKgh8JvHyjKRWEwh2AF1FiXDXQmBOfRBABtsemcRtwEDQjGn/8kmZ/QboN9rIPK5VAXZ2smspHXHW0M1kRvb0bAZlFPlH8xuEGjrUXM+G08yBzcdQBo9oAjmfxC5M8Hf0j7VU77r1qqOhsJqSuCWU8vYVP7og3mkZd8yjQ3KCrnKwL4HSM2+envcyQgXXEu99d3KIvI2OukoJC3TCT6EBfTzjYIi2j5VULkroSiCHZB7n+G7sDXiAJ1Lf1p3xwsh2L+RJuIhSn45wVNNFumOVucn1j5xtQp5Xeu7UvGjuUUa4inTSIQcuj7bZ9UWblRGhhZHaaF2VC69PE98FTpkCaHudjrzeyp4J5VqK5JvZnVs4U5vZ6PFzqPOvqIhLTQuY4Ak1Dw+ywbHxMvJrvBClhPx7OXuA1RwoDPH42xhRJRwNCRvYB0n3ahUmwuu/pCoCUqpOPdlozwovaWTGTkvyZc0fXPsQcl+EkTDP2BMSq70/rYDqAZJ1T/igXGMkgmQTP12pLNbFurP/BHl0Pb4XXd7DhQPEsaECZX80VvkLs4StEQd9npwI+ENStyddVH06FVpZSgiyUxeMLQxtDK2QSLwizevgCvv0XMBJQTFjkXUe4YcVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTVPN1ZaUmJOdGJWY1BHUWNrRWJaRnE4ME5RY2xiL28wWVRxOHQyV3BxV25w?=
 =?utf-8?B?STlzUnhKb3VlWHpBTjZFYlhYcGkxUDhRSnZkd21zOC83dFR1NjdHQmVHbHln?=
 =?utf-8?B?ckdiTXhEM01tZWh5ek1KZHdyMW96cXNJTXBKMVg2dHVZbnozbmlGZTE1eUhT?=
 =?utf-8?B?eFFoTnZvc2xkcS9pZUIzWDZ5VW9FbGs1WS8wNTdQTHozRHliLzJIN3hObDA3?=
 =?utf-8?B?QTlXbWtVZ0VKeWx3RDVmRjlpOGhsczFEc0EzTTkvZ3cwMEgvc2hoZWgrcGFs?=
 =?utf-8?B?czR1OUJtMFVUK25pMjJwQ2daZEJ2NmkxTUVLU3dKVElsc3hJZlBZV0hxYVRD?=
 =?utf-8?B?Wk84RWxvMUJBdnp1RFZPWm1WUlo5Ylg0OUNtRmdybDVCZlFOSnliMzBSd1lj?=
 =?utf-8?B?eXQrU0Q4bjE3R1NiVmNpcXJ2ZHZ4OTEzejREWlBLZHUvZGtJRzhwUHY2S2Vu?=
 =?utf-8?B?b2Q5bmpiQXplRWFaUlZQNUR1Vy9YSFpLTDRrSFlpZEorc1pDK2UvRUlmVDdj?=
 =?utf-8?B?b2pLMGpBb1hnUmpWeVhhcFVkWGZ4bXdTaXhFeFpBK2F0RXJ6N3hEV3FSTHB4?=
 =?utf-8?B?NXgvWFRVMWt3dmxZL1pVQ1NDRnUreGYzSEtZakNFTlE4V0tXMEJjbnZ0MFFo?=
 =?utf-8?B?TWlCWSt6WnNxYXlCclNOS1YyV29QdjVPTCtMRStjN1hvUXFOeXAxUGpZcS9Q?=
 =?utf-8?B?Y3V0LzN0bkxqL0ZuZTZZa0JHZUsxWUNTMnZuUE81VGQwYjRTd1ZHSVZjN052?=
 =?utf-8?B?YTk2eUt4MHQ1MXgzbG9PTUJydVlLdFJHaXhHeE54S2ZBZ2hncHNsdU83RTly?=
 =?utf-8?B?dkRaU0dNTzFyaEFFWlJXMEtzTk5iS2pWeitSOFVOYTREeWIzeklWQ3RPK2pH?=
 =?utf-8?B?REpnOWJUb1dNb1R1aFFWcFNHdi9mTGJKZDRwaCthN2drNzNkb3g1dlVBVCta?=
 =?utf-8?B?N2loRUtnM3VCWVllTCt2dUNneW4rUmtkNVMrVlJ3djdiZndPazdqMEdaYUVF?=
 =?utf-8?B?dWJVblVZVncwQW1XR1FwWng5enYzZXlTWjVNeDJ5SEtKM3lmanV4c1g4M1V2?=
 =?utf-8?B?UG1naFNlY1o4TThTbFA4czFJOWFYTmdXaWh0U2t0OFdJUW1HaVByTnBvOEtD?=
 =?utf-8?B?VnRuVjI4R3dQdDNvcUJFQUdtbFI3Z05SQlJkWXVSMVU3Rm5GSjIwWXJzdkYw?=
 =?utf-8?B?Sm9tczFEWGMvcHRkQ21HOTAwY0drN3AyOFFCeHlvZUUybW9OSGU1dTdpZXBT?=
 =?utf-8?B?WDdEcERWM0NlM09lcHdGeC8vNzVzVFhTdHJyMGhxc2FieitRQUt0ZFNva3pM?=
 =?utf-8?B?TkY5WWQzcCsxMFlqRllWdnNtcms3Z05lQ3c2QmZpTFZaOXJIcFJDRzB2TE9k?=
 =?utf-8?B?U1pGK3orOWNHQXF6d0dhNjZ0KytOSnBkaUR6c0xyYkk1R3JOSWE0RFplZWZw?=
 =?utf-8?B?dEpVOXVyUUxpbUhDRWgyQ0Y1R21WdTVtTFZhdXNwR2VsR1F0ZWNNK3oxc2tr?=
 =?utf-8?B?QUZ3aHl4VjlZVHpsUU5tajZSMm5oMEZRTWdhRmNjd3ZGbU9sajZ6T2plMG1X?=
 =?utf-8?B?M0VsVWVBUjU2eW1sekF1ejJGSStXR2Iydm1EMTRSQzZRM1IwbE85emNlK2NC?=
 =?utf-8?B?QkFxRWRTNlVUWjNVYmRQMWgvL3pjd3dlRHFuc0p3TmtKNUlOVnJlUjBZMkRu?=
 =?utf-8?B?NS9rM3IvcVNJOWJ4RzEvbHNmSEtYYnVuL0RNWmdxVG5zR1pDMURyWEFubFgy?=
 =?utf-8?B?OTl2dUpLRkM3ZG1kZjFNblhaZ2htTlV2MkJZY2NHT1NYZE5ZSk5BNXNxTVA1?=
 =?utf-8?B?S1F5b0FqRHBhRlg5d3R6MTRQV3NIV3lmcDBRR0VlNFFhZHNKbHhoT2hJQzI3?=
 =?utf-8?B?VVdIdnB2cUIxTTc3K291anZqdWxLL1lvN25wc3M0OC9nbWo0ZDVMU28rc3JM?=
 =?utf-8?B?ODF4R3NEU3hKb1J2clJ0SFVncVFJYXFMZ3VuYnJOSEp1cEVGN3M1S0ZhdVNM?=
 =?utf-8?B?RXRwMXZQRjhxVWpWdXh3ZVZZaU1BZHF3TWdTQmRvcmsxZDRhZElFMGRuOW5W?=
 =?utf-8?B?MHRCQURiQkY1eVJkRkZUY2E2L3NNVFkybU01TjNldnpPN1J1Y0lINi9yUVZo?=
 =?utf-8?B?dGFzTW93M0lSQWJtZ1dFOW4wZjUvQzhZZUIzNjlRRVZKVGp2bWVhaDFsTkhR?=
 =?utf-8?B?cXVYSXo5RkZKUHpqVGlSUXdweTVxZyt5cDdmWmxZWGxuWmpISkZxUlo3ZE01?=
 =?utf-8?B?WHlWa08vb3JHZmVEZmRUTEpCcStRcjRqRFN0ZDc5V09MQzZrQThrL2lyL1Vq?=
 =?utf-8?Q?nv8Iu3OwLocHdI5x0o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310a0bdc-2eab-489b-1afb-08de9574ee7d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 13:44:18.5791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9H51tj+3tF1nd8XQgt6UPGYwA2wLqpjN8bxBx4OxM0nFlq/bX77Zi1oqW/AKE102
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
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

On 4/8/26 15:42, Chenglei Xie wrote:
> During GPU reset, the application could still run CPU page table updates. Each commit called
> amdgpu_device_flush_hdp(), which on SR-IOV sends work through the KIQ ring.
> That can advance sync_seq while the GPU is being reset,
> leaving fence writeback out of sync and causing amdgpu_fence_emit_polling()
> to time out on later KIQ use.
> 
> Fix:
> amdgpu_vm_cpu_commit():
>   Take reset_domain->sem with down_read_trylock() before amdgpu_device_flush_hdp().
>   If the reset path holds the write lock, skip the HDP flush so no HDP-related HW
>   access (including KIQ) runs during reset; state is re-established after reset.
> 


> amdgpu_virt_pre_reset():
>   After stopping the data exchange thread and setting MP1 FLR state, call
>   amdgpu_fence_driver_force_completion() on each initialized KIQ ring so pending
>   fences are signalled and writeback is aligned before reset proceeds.

To make it clear: Absolute NAK to that. This is just nonsense.

Regards,
Christian.

> 
> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
> Change-Id: I938bce0cab93a794dbdb02fe3ca9e041f9ac1424
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 11 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c | 16 +++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 6974b1c5b56c2..0127b0d6c7277 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -1188,9 +1188,20 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
>  
>  void amdgpu_virt_pre_reset(struct amdgpu_device *adev)
>  {
> +	int i;
> +
>  	/* stop the data exchange thread */
>  	amdgpu_virt_fini_data_exchange(adev);
>  	amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_FLR);
> +
> +	/* Force completion on KIQ ring fences so pending fences are signalled. */
> +	for (i = 0; i < AMDGPU_MAX_GC_INSTANCES; i++) {
> +		struct amdgpu_ring *ring = &adev->gfx.kiq[i].ring;
> +
> +		if (!ring->fence_drv.initialized)
> +			continue;
> +		amdgpu_fence_driver_force_completion(ring);
> +	}
>  }
>  
>  void amdgpu_virt_post_reset(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> index 22e2e5b473415..a9e33b7e87406 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -21,6 +21,8 @@
>   */
>  
>  #include "amdgpu_vm.h"
> +#include "amdgpu.h"
> +#include "amdgpu_reset.h"
>  #include "amdgpu_object.h"
>  #include "amdgpu_trace.h"
>  
> @@ -108,11 +110,23 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
>  static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
>  				struct dma_fence **fence)
>  {
> +	struct amdgpu_device *adev = p->adev;
> +
>  	if (p->needs_flush)
>  		atomic64_inc(&p->vm->tlb_seq);
>  
>  	mb();
> -	amdgpu_device_flush_hdp(p->adev, NULL);
> +	/*
> +	 * While GPU reset holds reset_domain write lock, skip HDP flush entirely so
> +	 * no HDP-related HW access runs during reset;
> +	 * reset re-establishes consistent state afterward.
> +	 */
> +	if (!down_read_trylock(&adev->reset_domain->sem))
> +		return 0;
> +
> +	amdgpu_device_flush_hdp(adev, NULL);
> +	up_read(&adev->reset_domain->sem);
> +
>  	return 0;
>  }
>  

