Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939C9C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 08:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28E6C10EBF5;
	Tue,  7 Jul 2026 08:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QkAm6nD3";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00FD110EBF5
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 08:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OteUfEFSJtwomu4OqZXvt7dz+ILdiz0RGWN83AZEPv0CnuCjG77EX/5vB+9MhqDN5KOTKTesOmwVT39Pu33JLQqydC2pknWfibkTLSuRFC9++ZpyC0b7crhSgZd29bFvWPzfMXLwiXr3j71VqB7f5TOfMNYHyva4fCTzo8eIJZqY1n6zstmu2m47w+7wB1Y/3f+zahXIdW+6+lgkI8eD0gzHBOam3glKvb+vHRwmwW4GHLHgFYiPwi14XVCj1dac2GL2l9GvvDnWwmLQI1iEvtBwKQmKFXkPbY0YdqiOnh12vId0TbAehXz+U0E5MM83V+UZxzKZMdCux4Oe98kYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/edykWmfSPPMFsZTdMf+IMoFsee74ueGeG/YI1GGAI=;
 b=Mk/IAVzJmPJicD966SXSH6DU6IPio8O0vBs0SRtq9mnKY4vhM8ZoanRm+9wNIB8aB9aheIpoz1mjwaowX+w6BMXdCsGy4y6bgdvYjG3m+kXB5df2BUFq/Rsmu4e4kAmwL6kogUpRpmA1kJkxeI6x41rFk4cRedBFJLoBkgGk7ndNp+Lc2MvgLU6gyTMAVJexyTmf5c0k+tyQ4iwwBaCClw7aptKqW/iM6hJJoV2V3JE/1RbyjF4ftPlJ0823QeGwFwmwYKwuVU4d0JlrnHlbVQ4hFoxMqTXb2nWTPRv1E8ucE9XusC0Vsyl3rZsPjsdVszJfqoG53+D2SCFpu0Kclg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/edykWmfSPPMFsZTdMf+IMoFsee74ueGeG/YI1GGAI=;
 b=QkAm6nD34GDabbeN1psZ+9dIseSslOLY+Jv7Ai2IijYEj3NTfqUYpOF4HeRBH/ZMJGiE+DvqOIuSeE2Q6PplwdrSQUBUXP/F1uzdDIGRa5e0RMkY+LaANzxA5/+132OnCjL0N+OL4FoejeN/OA6Bc3kbv2VnI8sS8tvrJzkkSl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by SA1PR12MB999086.namprd12.prod.outlook.com (2603:10b6:806:49f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 7 Jul
 2026 08:40:49 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 08:40:48 +0000
Message-ID: <dcad6367-3f26-4368-9982-a0ba07913f0d@amd.com>
Date: Tue, 7 Jul 2026 16:40:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] drm/amdgpu: add amdgpu_vm_update_leaves()
To: christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, natalie.vock@gmx.de,
 Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Philip.Yang@amd.com,
 timur.kristof@gmail.com, Huang Rui <Ray.Huang@amd.com>, honghuan@amd.com
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-7-christian.koenig@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <20260529114031.3714-7-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|SA1PR12MB999086:EE_
X-MS-Office365-Filtering-Correlation-Id: 2792e6a1-ad13-4d66-de42-08dedc0371ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|4143699003|22082099003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: qDy07T359jPAqf114qMW3xBeDUf7PLVApCriVSVaAsLsTu0oe5Yb7SrVh0Vw1Q+12p/6iGmO9YfHW2MFCM7rUXCAOH31NHKfnIEIEasArAbNhg/B2F0Ic0+9FrJ58VIuFJTcQ70u7yyrtl3Oeyj1M8YvpKEsEISu0m0yJhVlXttgEEkV/kN+4hkGe07Ior2HhFl61r42gpWzAbcoelMwF1RG/o2TnxZAuCfwpbPSExwrjwqPQJcLa+CRCx6OIn9DDyUxWP+4QH8nJidzuMnrUP2jS6fjv+EgayBLBXZ/D7OIvzakNExGeGgTR1QgFVR84a1HlUA4n6hUSu+/CBZMbjXzpZ65oYNfTfqBIHc3zlzw18yAlwDXGft4dYddu0mjdN94Fx1Rn1NgQ9+QtSoesdj6C1YsN5jwvGkjzC3RpjNymnuhFbJ4vRhb4Z6/Tzj8noBi9/vcZh6ZoHvug9U3dDEZAhk2/R7gpn2Lce8s61IYPbBSS6RGDXAcDjgtpKIChoxV9RYpLsuaLZLyMzBgcvT5xloc1UEZ2KsbNSWmT44rJVbw9b/maC5OPQ56J154VPTDHaSnwENdbhgq8E7+Wt3REKpxiKqwFM2OPGxFu1boVsTqbozPkIj23Y23wJrF1NZDW2zjH7WsgW7O9jUHmu4saV4nQ+aJgzuon9pKISs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGdlaHIwRE5kYzRRLzJTYUdoREIzbDlRakNuMXcxblRoYzlaQkpYbUVWNXlm?=
 =?utf-8?B?RUJSa3d1WnFTNllwYnpZOTlwL0FtWHRGRzJYd0RDVGxMQVIwMVNMd2V0YWhD?=
 =?utf-8?B?Q05DU0d2RTcwTjVQRUxXT3h2WGIvRUx5R0Z3Y1pEeU5nVHQ0WC9WR3RheGp0?=
 =?utf-8?B?RXp1cGJLQWppR3drR056WitPWHhKZEhIQWY1bFY1VnFRK0sySWx6RXBBLzZI?=
 =?utf-8?B?R0o3TjJiQWxLOURuT2pjNmV5WDdKcU90VEV0UVBLOUpWY1U4dGowZUlYS3p2?=
 =?utf-8?B?V29IWkpkUUwrc2E5OG1nUUtrRDRkU3pMV3k3UkNVYWdXbE42WUg2b2JOd0Ir?=
 =?utf-8?B?cWRvODZzc0hjZjFzK3pUcmU0aDR4NUpXWVUrNGZTMm9FektEZmFOcUV6cXdR?=
 =?utf-8?B?dkFFUmZONVlTR240dXJpcnlTQW9Gc0hyWHV0ZFdxNEJrdVhQazkxeCtSRFc1?=
 =?utf-8?B?WXFSbnZSRktScGpFeUdEM2JrT1Q0anI0bWIyUGlnSDFqczBWNEtFY3l1VlRm?=
 =?utf-8?B?aW52R0U5bnVPdHJXZ0RObU03b250R05mbVlRZmtUSjI1SVA1UG9yd3E5bjJL?=
 =?utf-8?B?RXFHdUZZKzJOcjNDVkxmVmJxWGMvdDcwZ1hjUElETkk0VWMrVVVTa0Ztd29G?=
 =?utf-8?B?ZnUzTDJDSEVHeFhXbDdadjJqZUVJR2NYMGovaDBqUm96TVBKeFM1bjhlWDE3?=
 =?utf-8?B?SGltQXUwZkd0bFd4Nm1wd0pxblZzVDJkeWVRakJmUzh0VFVxMTlqN2pQWklQ?=
 =?utf-8?B?RmxhMkk2Y2JPV2NJTmYvMUM0Y3gyaGZBdWt2cTlvbS93YU5FazVIbHRoenhP?=
 =?utf-8?B?NFhZVDJ1OWx0eXVRSnRFZG9ITUZVRndPdE5ZV1VzK2w5Uk9NaktRMHJxS2ZR?=
 =?utf-8?B?eGIxbG1PSDVCNlRjVjZWaEdFdk1vUnVPWmIyd0xQbnd4M1BRUHZqeWxtQ05m?=
 =?utf-8?B?dVpLMmVGT3Y5QXZudURsSFBZQ2xIQ20rY2tzY1FFMTlVRGNrYTR0VVJ4enNz?=
 =?utf-8?B?MVRMU2NuK25neTMrb2xna1BBSUs1ejhRb0g2eGFPcmhPL0lGNzkwU25rSkQ4?=
 =?utf-8?B?RVEzSUpSOUlJTmxXL2txVjhOS3hkMXh2Y1JOZS9TZFNrSTBpV0dWOFJFK1R6?=
 =?utf-8?B?VWJJTFQ4aHhwQSsvV0l4NWFlMXJiMENudGhuQStqckFlZkYrQ3NvR1ZwS0VN?=
 =?utf-8?B?d3JJTXpnRmhyK3ZNbm9aUzUyVlBFUTNGSFBNTXk2VUZtZXlDaUloNGRTdW1o?=
 =?utf-8?B?YkE5eEdLVWd4N3NiL293RnR0Z2JYYVJKY1UzbmFQWVRUbW5UVktVZFg3clFs?=
 =?utf-8?B?K0E5UFFvQ0k4Slc5QVBWTHhsa0JKVmhxNFBnTHpSSkVCdXFyVE9nUlRaU2Fv?=
 =?utf-8?B?cndJdS9wbGR4d0kvT0Z4cG1oSDdVMTVrRHByS0hHU0hBdE9ZakNxZEczTDhi?=
 =?utf-8?B?Rm1oOGVHWC9wZFQ3ZXc2SGZIb3BLMm5aRld5d1dJY1pGRDRqNTJ1Q3lDNmNi?=
 =?utf-8?B?WkVFc3RTUlBNS3VZVm1qaFBCUjEvSDltanFmcXcwNFJJQUV3VVRZaGU1NHVr?=
 =?utf-8?B?RnpGN0RhbFRNVlJPZC96dVI5UHgvaTB6ZWJnRVEyd1VMN25Xc0V0MC9oYXJv?=
 =?utf-8?B?aTlWUk1SZGUrNGg3TmRQdkQrdVhlanpIcnZyN0dKbTJPS1RzQiszMGZoQzFQ?=
 =?utf-8?B?STQvc0Vyc1pJTGlVanNuWFQyYmhsTGFqNXI1dzFURUZmZ2VCTlZEby9paWxy?=
 =?utf-8?B?NmsrWEFFSWVZNkx6VEFJRVhDaEkvM2FIWnpnaWFnZGIxUnlvNnZiQjR1MTFG?=
 =?utf-8?B?eDFzdkZpUXJEQWg5b0NyQ3NIVWdJdmk2dFlMcFI4MWp0Wkl3QzF4c3Y5Q1Fv?=
 =?utf-8?B?OTMxRlNrc2xTTjVTZ1U3WlBoamd2QTJ4djBEaGt1dHVOeXhPSXhONk9pZUh1?=
 =?utf-8?B?M2xobHlZcW9wN0s1T2REdHUyZ2g3azVzdlpRWXk5OG1ncHdxcFN1OTY1Q0ZL?=
 =?utf-8?B?NmhPT1FxS2lPTkFVdE55NExmR1lSaDlnQWJZWE5TdTFmbUpocThBK0hPVW9K?=
 =?utf-8?B?TmhIUFAwTzNqSEgxTWFOUmd5MXNhc0FKUlRlTkNtakxNSTR5WFVXYklsMzdI?=
 =?utf-8?B?MFZKUHYvR0MvRDl4QXplT254dW51bWNCeXRpZkZnaGt1WFVNcXZFWG1ERTBq?=
 =?utf-8?B?dlZGZDlEc0FCS0EwQUE1eHdPSTZGSHZSYXlOUHdCMTQ1dzdQMmtBZlcxWXlE?=
 =?utf-8?B?Rzc0eWhaT01hbVBPUy9QaU13MXZGYUVrTXNIRjJaVlVFU200eEF5MG1aLzBS?=
 =?utf-8?Q?i7AIoBe2B8KEZtcAFw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2792e6a1-ad13-4d66-de42-08dedc0371ba
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:40:48.7107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkuwWr/RUJc1fMBn/sCU9wsSeobUqEgtVeBR3lLl0Q7dd+hkhOfjldx5JNJR+pdkR1fz+2L3EYw5f6N9FwMOpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999086
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



On 5/29/2026 7:24 PM, Christian König wrote:
> Add a new function amdgpu_vm_update_leaves() to avoid memory allocation
> on page faults.
> 
> The idea is to only update the leave PTEs to insert a dummy PRT PTE.
> 
> TODO: HW older than GMC v9 needs a different solution.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 40 ++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 71 ++++++++++++++++++++++-
>   3 files changed, 103 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index e5588346a03f..94632a660b79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2984,10 +2984,12 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   			    u32 vmid, u32 node_id, uint64_t addr,
>   			    uint64_t ts, bool write_fault)
>   {
> -	bool is_compute_context = false;
> +	struct amdgpu_vm_update_params params;
> +	bool is_compute_context;
>   	struct amdgpu_bo *root;
>   	uint64_t value, flags;
>   	struct amdgpu_vm *vm;
> +	unsigned int idx;
>   	int r;
>   
>   	vm = amdgpu_vm_lock_by_pasid(adev, &root, pasid);
> @@ -3029,24 +3031,46 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   		value = adev->dummy_page_addr;
>   		flags |= AMDGPU_PTE_EXECUTABLE | AMDGPU_PTE_READABLE |
>   			AMDGPU_PTE_WRITEABLE;
> -
> +		/* On +gfx9 we can use the PRT functionality instead */
> +		if (!adev->gmc.gmc_funcs->set_prt) {
> +			flags &= ~AMDGPU_PTE_VALID;
> +			flags |= AMDGPU_PTE_PRT;
> +		}
>   	} else {
>   		/* Let the hw retry silently on the PTE */
>   		value = 0;
>   	}
>   
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
> +		r = -ENODEV;
> +		goto error_unlock;
> +	}
> +
> +	amdgpu_vm_eviction_lock(vm);
> +	if (vm->evicting) {
> +		r = -EBUSY;
> +		goto error_dev_exit;
> +	}
> +
> +	memset(&params, 0, sizeof(params));
> +	params.adev = adev;
> +	params.vm = vm;
> +	params.immediate = true;
> +	params.pages_addr = NULL;
> +
>   	r = dma_resv_reserve_fences(root->tbo.base.resv, 1);
>   	if (r) {
>   		pr_debug("failed %d to reserve fence slot\n", r);
> -		goto error_unlock;
> +		goto error_eviction_lock;
>   	}
>   
> -	r = amdgpu_vm_update_range(adev, vm, true, false, false, false,
> -				   NULL, addr, addr, flags, value, 0, NULL, NULL, NULL);
> -	if (r)
> -		goto error_unlock;
> +	amdgpu_vm_update_leaves(&params, addr, addr, value, flags);

Maybe need add prepare and commit flow?

see diff:

@@ -3118,6 +3118,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device 
*adev, u32 pasid,
         params.vm = vm;
         params.immediate = true;
         params.pages_addr = NULL;
+       INIT_LIST_HEAD(&params.tlb_flush_waitlist);

         r = amdgpu_vm_begin_critical(&params);
         if (r)
@@ -3129,9 +3130,16 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device 
*adev, u32 pasid,
                 goto error_end_critical;
         }

+       r = vm->update_funcs->prepare(&params, NULL,
+                                           AMDGPU_KERNEL_JOB_ID_VM_UPDATE);
+       if (r)
+               goto error_end_critical;
+
         /* update_leaves uses exclusive end; we want a single PTE at 
@addr */
         amdgpu_vm_update_leaves(&params, addr, addr + 1, value, flags);

+       r = vm->update_funcs->commit(&params, NULL);
+


Regards,
Honglei



>   
> -	r = amdgpu_vm_update_pdes(adev, vm, true);
> +error_eviction_lock:
> +	amdgpu_vm_eviction_unlock(vm);
> +
> +error_dev_exit:
> +	drm_dev_exit(idx);
>   
>   error_unlock:
>   	amdgpu_bo_unreserve(root);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index cc096c005e34..04b32accfa3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -613,6 +613,9 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
>   int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			  uint64_t start, uint64_t end,
>   			  uint64_t dst, uint64_t flags);
> +void amdgpu_vm_update_leaves(struct amdgpu_vm_update_params *params,
> +			     uint64_t start, uint64_t end,
> +			     int64_t dst, uint64_t flags);
>   void amdgpu_vm_pt_free_work(struct work_struct *work);
>   void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>   			    struct amdgpu_vm_update_params *params);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index e43a60d09808..9766b6b9aecc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -790,6 +790,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			  uint64_t dst, uint64_t flags)
>   {
>   	struct amdgpu_device *adev = params->adev;
> +	struct amdgpu_vm *vm = params->vm;
> +	pid_t tgid = vm->task_info ? vm->task_info->tgid : 0;
>   	struct amdgpu_vm_pt_cursor cursor;
>   	uint64_t frag_start = start, frag_end;
>   	unsigned int frag;
> @@ -881,7 +883,6 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   		entry_end = min(entry_end, end);
>   
>   		do {
> -			struct amdgpu_vm *vm = params->vm;
>   			uint64_t upd_end = min(entry_end, frag_end);
>   			unsigned int nptes = (upd_end - frag_start) >> shift;
>   			uint64_t upd_flags = flags | AMDGPU_PTE_FRAG(frag);
> @@ -893,8 +894,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   
>   			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
>   						    min(nptes, 32u), dst, incr,
> -						    upd_flags,
> -						    vm->task_info ? vm->task_info->tgid : 0,
> +						    upd_flags, tgid,
>   						    vm->immediate.fence_context);
>   			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
>   						   cursor.level, pe_start, dst,
> @@ -938,6 +938,71 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   	return 0;
>   }
>   
> +/**
> + * amdgpu_vm_update_leaves - update leave PDEs/PTEs
> + *
> + * @params: see amdgpu_vm_update_params definition
> + * @start: start of GPU address range
> + * @end: end of GPU address range
> + * @dst: destination address to insert into the leave PDEs/PTEs
> + * @flags: mapping flags
> + *
> + * Update the leave PDEs/PTEs in the range @start - @end without allocating or
> + * freeing page tables.
> + *
> + * Returns:
> + * 0 for success, negative error code for failure.
> + */
> +void amdgpu_vm_update_leaves(struct amdgpu_vm_update_params *params,
> +			     uint64_t start, uint64_t end,
> +			     int64_t dst, uint64_t flags)
> +{
> +	struct amdgpu_device *adev = params->adev;
> +	struct amdgpu_vm *vm = params->vm;
> +	pid_t tgid = vm->task_info ? vm->task_info->tgid : 0;
> +	struct amdgpu_vm_pt_cursor cursor;
> +
> +	amdgpu_vm_pt_start(adev, params->vm, start, &cursor);
> +	while (cursor.pfn < end) {
> +		unsigned int shift, mask;
> +		uint64_t entry_end, pe_start;
> +		struct amdgpu_bo *pt;
> +		unsigned int nptes;
> +
> +		/* Walk to the leave entries */
> +		if (amdgpu_vm_pt_descendant(adev, &cursor))
> +			continue;
> +
> +		pt = cursor.parent->bo;
> +		shift = amdgpu_vm_pt_level_shift(adev, cursor.level - 1);
> +		mask = amdgpu_vm_pt_entries_mask(adev, cursor.level - 1);
> +
> +		/* Looks good so far, calculate parameters for the update */
> +		pe_start = ((cursor.pfn >> shift) & mask) * 8;
> +
> +		entry_end = ((uint64_t)mask + 1) << shift;
> +		entry_end += cursor.pfn & ~(entry_end - 1);
> +		entry_end = min(entry_end, end);
> +
> +		nptes = (entry_end - cursor.pfn) >> shift;
> +		/*
> +		 * This can happen when we set higher level PDEs to unmap and/or
> +		 * silent to stop fault floods.
> +		 */
> +		nptes = max(nptes, 1u);
> +
> +		trace_amdgpu_vm_update_ptes(params, cursor.pfn, entry_end,
> +					    min(nptes, 32u), dst, 0, flags,
> +					    tgid,
> +					    vm->immediate.fence_context);
> +		amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
> +					   cursor.level - 1, pe_start, dst,
> +					   nptes, 0, flags);
> +
> +		amdgpu_vm_pt_next(adev, &cursor);
> +	}
> +}
> +
>   /**
>    * amdgpu_vm_pt_map_tables - have bo of root PD cpu accessible
>    * @adev: amdgpu device structure

