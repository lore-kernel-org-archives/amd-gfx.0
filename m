Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5873EC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 11:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED50B2076B
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 11:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED50B2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E47B6E039;
	Wed, 27 Jan 2021 11:39:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 749E26E039
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 11:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcSUp2o9CcsZ3nPlY55k8P8jgHecMzyAn2y8XhLS+CCW4QYOvqHaAuNPP0upnEfNyOPS1BNYbt0ecz6MxTz1TO93J/AVBprYj+qf9OR9w16blbwqYyxh0FdpD7e+6d32nWE9bVKOYtNEP2E3GPki3s/lKA0kw69PdyykDhfmjaJifFtBVYv1QJXJLk9quToGHn75U3evZD4lZ9sPc6Zpzyt+AhYni3rWXbJ9+eJtsX8hgheZBikMm0HpyXPZJhfAuoqS+Z7uCgkZ5L5rKQlRVoVxI+je8U3v2oRpvBHj59BwIjdkGjZSyEfVEBUCVtnMGo/qdtp2EBL5qH5Gy6qgCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D0lSzqo69Csr78DjKKxE9BmBUn8d1pLAjRKiFR4sQA=;
 b=N/7Dm1E2WCveZ1e1IH3j/E6z3Ccizf+JT5NZt0J+0DTIEkSvxT3H/7xxKoRhvcPw75nNT+HM50FyIHiJKp6D/qoi5BCD6JH0uIL+fmhptLuy+4h+ziIPFrZhOeaELtT37apwOEA37+gYGr5yacA3OT5TfM6pHqQTjPCGkTG4fkHnlOvrbPc3JHAQcLs6nLg3L3txi36oSa/h5eQpkD7sC1l40L+zGnykNnRJxqfShOPDTnjfNzsRPdmJyNYF775u77Mw0eF0mUYRHk4tu1xMnDnnlQuTTXoHzIaeKLFRE0Js3XUGb+usuN80IXdYumGNp8UAlTKrODepYgt2Z3g35A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D0lSzqo69Csr78DjKKxE9BmBUn8d1pLAjRKiFR4sQA=;
 b=CUyu/fkLzMw74sCat0t3MgSF65CJ5yqr0d2kumdAv0+IlCsnYuJJEiExBa1H3VyR480UHm1w3+YNmQ4ESBqxDhUHs+ShD07vBbNoKuoJjPHpz6a7dz/jIrWjHjd8ox2F2TX/8VNMY+6nCKZItQkf5sZC57//m9g3rTsHB7PoC/U=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1855.namprd12.prod.outlook.com (2603:10b6:300:10e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 27 Jan
 2021 11:39:32 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3805.016; Wed, 27 Jan 2021
 11:39:31 +0000
Date: Wed, 27 Jan 2021 19:39:24 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>
Subject: Re: [PATCH] drm/amd/amdkfd: adjust dummy functions ' placement
Message-ID: <20210127113924.GE610615@hr-amd>
References: <20210127101403.3059897-1-Lang.Yu@amd.com>
Content-Disposition: inline
In-Reply-To: <20210127101403.3059897-1-Lang.Yu@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0083.apcprd04.prod.outlook.com
 (2603:1096:202:15::27) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK2PR04CA0083.apcprd04.prod.outlook.com (2603:1096:202:15::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 11:39:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a46db238-8ef2-4cfc-0efe-08d8c2b83657
X-MS-TrafficTypeDiagnostic: MWHPR12MB1855:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1855F8A33514FB40F3B76968ECBB9@MWHPR12MB1855.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ixaKtPG39sqbcEp3oVOJB3X1XA4loT+88q3H7kihePd0+ivjsRzbvrrNCdl6QP0ncGAhguTJNde0MsSn+ycuZIW9v1WFxo5HAT81pf0/yFfK0iMDKbzk26qBaC6VBNYLMjd0FpjPeer2OUPgUZM2+xyIQKSRt/D1CuBp+AKkuW+iyNBNeJJ9/slLJ5PkNAj5BiXEsGYHawty6Kc/XkiYEb6JsHW3/q7StAG+KY1bv9+AF//dQ1N0q59paP0dnbEJg3rNkThyQ8BRmx94goC7AkqOsRXkkNs0mJK8JtIbZ9Ghikc3SHsIejfu79E1eGSI4aO1GwTGrhkzy72K9NlGMwMFFB7ljhjS6P+aDsJYtLQsnC4y/a+MquhXVrZbCazEFsmXpgolBVr/8OsmKnWRa2i769Ne0tcA+2ggXvAgfmuyGM2xrWhplpG/fcTw+jYnYvJH13Kx7Nm+ecia4h94EmYLYmeC5HkM6p23ij8OkD0qsONJI6VJ8R9PimL7T7vjMzBcUZS2GQrqLpYm6sdWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(4326008)(186003)(9686003)(16526019)(26005)(52116002)(55016002)(83380400001)(6666004)(6636002)(66476007)(1076003)(316002)(66946007)(6496006)(6862004)(66556008)(5660300002)(8936002)(956004)(33716001)(2906002)(8676002)(33656002)(478600001)(86362001)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Eb4dSAQNW0IuwkhtgynYD4Mu9XreH4j83vVu2l7tqy0/RNYRDx176oMyUq/b?=
 =?us-ascii?Q?fjNZSxSuQof60ZmURM19f1ZVZAqybTcakK4i+bnCzko5qwuf67loU7YUD8lq?=
 =?us-ascii?Q?pCEp6Aa6Bbv35OtSd811oHgTAaSI+QFRZaf23f8Clx6xk/kC3JVCUejO6lBt?=
 =?us-ascii?Q?UoNHaKCCBHM2e6ZwIaBZNkG+ZKpem4FynMIe6XT+aSeGSzsRJR4UFuxwfKbH?=
 =?us-ascii?Q?ZY9Z2HnWzZOF2IS9FBgOU1eDHhwqNna9syZpBr1Dz+wXrUjajB5xZ0FRMkzS?=
 =?us-ascii?Q?vbl0EJc7C9IU32CZKOnZJEmqcnYxgtu9Dks0CvTMp0NdtF+JlL7OJeuTK6ZK?=
 =?us-ascii?Q?rCwTecn5/HlMS/MdKYBOqbx/dovhe3O9WHdlEWjTuCao3zHWrBdLNFgzMb1i?=
 =?us-ascii?Q?/Ay4xE7euQ3u4swL/X+Yef7p8kS/mP1zZlLYool0PMRPSzaoWcilL3glCaOu?=
 =?us-ascii?Q?kqpN2U/1YJN6tmqn8aj5S08tkhpGQ9PKxKIOTh3QP2rB32vaY3r2rIRnWW44?=
 =?us-ascii?Q?zr8ClzclGIs/kLZNO5b5SbZ5ypdKDUpda3xM5jPzyPyi1pq/U5+6KTVl0l4s?=
 =?us-ascii?Q?1ybDFY3L4ELLCjf+fXsZQuM8ylyMC0fasABNZcHilvf0TMm7j0iy1ckkaiXb?=
 =?us-ascii?Q?dtupx6Cc5W0G7/hoLW6uLkxlbon5YOxy7lDcJ6aEzOKlBa61qOADig9JJpVL?=
 =?us-ascii?Q?iwW2VTMQvtHMcI9L6jv5gyRKpZWVGUHa8Yo2z6mHzG0sL3AYYblma7uiX2qI?=
 =?us-ascii?Q?iq9XGJ53HYuj1kOJt1XtxAUAG945AsMex+VWiYuwGEggTr7Eg08hodWNk5SE?=
 =?us-ascii?Q?y+YnG3oWx4i6I4xw0GlIhr43kyJ/pNE15MPpAq8FPbOElYeyUMEz/d67L+1H?=
 =?us-ascii?Q?9R2Rno4BnXl1lbfMUnp3ayEaUNkocupUGMwI7suNxelUQP13SCSYOv/AQgQN?=
 =?us-ascii?Q?mp4UY+wpUstFaNc7dP0G8wdfXBy08iUymK8IDY2lG6VRxq1cxVQWmTROtxYT?=
 =?us-ascii?Q?14tqTw0x4AXX1HGqPWwXVrwh6VPgY9Gns8gDCulC6vacQnUpp62AeGBUoZXv?=
 =?us-ascii?Q?atfg0NeMPNhEqDLVBIIf096j+ppQGg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46db238-8ef2-4cfc-0efe-08d8c2b83657
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 11:39:31.7479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WThFK+NcBuLj3kid7gghHihK9x0d64ej+WfVujpzg4nWz4nDVq2MwJMywfjZvqSM+yuZ/4tNWH8JfeQXi1n4yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1855
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 27, 2021 at 06:14:03PM +0800, Yu, Lang wrote:
> Move all the dummy functions in amdgpu_amdkfd.c to
> amdgpu_amdkfd.h as inline functions.
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  87 ------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 151 ++++++++++++++++++---
>  2 files changed, 130 insertions(+), 108 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index db96d69eb45e..c5343a5eecbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -47,12 +47,8 @@ int amdgpu_amdkfd_init(void)
>  	amdgpu_amdkfd_total_mem_size = si.totalram - si.totalhigh;
>  	amdgpu_amdkfd_total_mem_size *= si.mem_unit;
>  
> -#ifdef CONFIG_HSA_AMD
>  	ret = kgd2kfd_init();
>  	amdgpu_amdkfd_gpuvm_init_mem_limits();
> -#else
> -	ret = -ENOENT;
> -#endif
>  	kfd_initialized = !ret;
>  
>  	return ret;
> @@ -696,86 +692,3 @@ bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd)
>  
>  	return adev->have_atomics_support;
>  }
> -
> -#ifndef CONFIG_HSA_AMD
> -bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
> -{
> -	return false;
> -}
> -
> -void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo)
> -{
> -}
> -
> -int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo)
> -{
> -	return 0;
> -}
> -
> -void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
> -					struct amdgpu_vm *vm)
> -{
> -}
> -
> -struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
> -{
> -	return NULL;
> -}
> -
> -int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem, struct mm_struct *mm)
> -{
> -	return 0;
> -}
> -
> -struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, struct pci_dev *pdev,
> -			      unsigned int asic_type, bool vf)
> -{
> -	return NULL;
> -}
> -
> -bool kgd2kfd_device_init(struct kfd_dev *kfd,
> -			 struct drm_device *ddev,
> -			 const struct kgd2kfd_shared_resources *gpu_resources)
> -{
> -	return false;
> -}
> -
> -void kgd2kfd_device_exit(struct kfd_dev *kfd)
> -{
> -}
> -
> -void kgd2kfd_exit(void)
> -{
> -}
> -
> -void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
> -{
> -}
> -
> -int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
> -{
> -	return 0;
> -}
> -
> -int kgd2kfd_pre_reset(struct kfd_dev *kfd)
> -{
> -	return 0;
> -}
> -
> -int kgd2kfd_post_reset(struct kfd_dev *kfd)
> -{
> -	return 0;
> -}
> -
> -void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
> -{
> -}
> -
> -void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd)
> -{
> -}
> -
> -void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask)
> -{
> -}
> -#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index bc9f0e42e0a2..c3a51c0d54e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -94,11 +94,6 @@ enum kgd_engine_type {
>  	KGD_ENGINE_MAX
>  };
>  
> -struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
> -						       struct mm_struct *mm);
> -bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm);
> -struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f);
> -int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo);
>  
>  struct amdkfd_process_info {
>  	/* List head of all VMs that belong to a KFD process */
> @@ -132,8 +127,6 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>  void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
>  void amdgpu_amdkfd_device_init(struct amdgpu_device *adev);
>  void amdgpu_amdkfd_device_fini(struct amdgpu_device *adev);
> -
> -int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem, struct mm_struct *mm);
>  int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
>  				uint32_t vmid, uint64_t gpu_addr,
>  				uint32_t *ib_cmd, uint32_t ib_len);
> @@ -153,6 +146,38 @@ void amdgpu_amdkfd_gpu_reset(struct kgd_dev *kgd);
>  int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
>  					int queue_bit);
>  
> +struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
> +						       struct mm_struct *mm);
> +#if IS_ENABLED(CONFIG_HSA_AMD)
> +bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm);
> +struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f);
> +int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo);
> +int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem, struct mm_struct *mm);
> +#else
> +static inline
> +bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
> +{
> +	return false;
> +}
> +
> +static inline
> +struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
> +{
> +	return NULL;
> +}
> +
> +static inline
> +int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo)
> +{
> +	return 0;
> +}
> +
> +static inline
> +int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem, struct mm_struct *mm)
> +{
> +	return 0;
> +}
> +#endif
>  /* Shared API */
>  int amdgpu_amdkfd_alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
>  				void **mem_obj, uint64_t *gpu_addr,
> @@ -215,8 +240,6 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct kgd_dev *kgd,
>  					struct file *filp, unsigned int pasid,
>  					void **vm, void **process_info,
>  					struct dma_fence **ef);
> -void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
> -				struct amdgpu_vm *vm);
>  void amdgpu_amdkfd_gpuvm_destroy_process_vm(struct kgd_dev *kgd, void *vm);
>  void amdgpu_amdkfd_gpuvm_release_process_vm(struct kgd_dev *kgd, void *vm);
>  uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *vm);
> @@ -236,23 +259,46 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_dev *kgd,
>  		struct kgd_mem *mem, void **kptr, uint64_t *size);
>  int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>  					    struct dma_fence **ef);
> -
>  int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct kgd_dev *kgd,
>  					      struct kfd_vm_fault_info *info);
> -
>  int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
>  				      struct dma_buf *dmabuf,
>  				      uint64_t va, void *vm,
>  				      struct kgd_mem **mem, uint64_t *size,
>  				      uint64_t *mmap_offset);
> -
> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
> -void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo);
> -
>  int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,
>  				struct tile_config *config);
> -
> +#if IS_ENABLED(CONFIG_HSA_AMD)
> +void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
> +void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
> +				struct amdgpu_vm *vm);
> +void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo);
> +#else
> +static inline
> +void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
> +{
> +		return;
> +}
> +
> +static inline
> +void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
> +					struct amdgpu_vm *vm)
> +{
> +		return;
> +}
> +
> +static inline
> +void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo)
> +{
> +		return;
> +}
> +#endif
>  /* KGD2KFD callbacks */
> +int kgd2kfd_quiesce_mm(struct mm_struct *mm);
> +int kgd2kfd_resume_mm(struct mm_struct *mm);
> +int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
> +						struct dma_fence *fence);
> +#if IS_ENABLED(CONFIG_HSA_AMD)
>  int kgd2kfd_init(void);
>  void kgd2kfd_exit(void);
>  struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, struct pci_dev *pdev,
> @@ -266,11 +312,74 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
>  int kgd2kfd_pre_reset(struct kfd_dev *kfd);
>  int kgd2kfd_post_reset(struct kfd_dev *kfd);
>  void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
> -int kgd2kfd_quiesce_mm(struct mm_struct *mm);
> -int kgd2kfd_resume_mm(struct mm_struct *mm);
> -int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
> -					       struct dma_fence *fence);
>  void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
>  void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask);
> -
> +#else
> +static inline int kgd2kfd_init(void)
> +{
> +	return -ENOENT;
> +}
> +
> +static inline void kgd2kfd_exit(void)
> +{
> +		return;
> +}
> +
> +static inline
> +struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, struct pci_dev *pdev,
> +					unsigned int asic_type, bool vf)
> +{
> +	return NULL;
> +}
> +
> +static inline
> +bool kgd2kfd_device_init(struct kfd_dev *kfd, struct drm_device *ddev,
> +				const struct kgd2kfd_shared_resources *gpu_resources)
> +{
> +	return false;
> +}
> +
> +static inline void kgd2kfd_device_exit(struct kfd_dev *kfd)
> +{
> +		return;
> +}
> +
> +static inline void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
> +{
> +		return;
> +}
> +
> +static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
> +{
> +	return 0;
> +}
> +
> +static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
> +{
> +	return 0;
> +}
> +
> +static inline int kgd2kfd_post_reset(struct kfd_dev *kfd)
> +{
> +	return 0;
> +}
> +
> +static inline
> +void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
> +{
> +		return;
> +}
> +
> +static inline
> +void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd)
> +{
> +		return;
> +}
> +
> +static inline
> +void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask)
> +{
> +		return;
> +}
> +#endif
>  #endif /* AMDGPU_AMDKFD_H_INCLUDED */
> -- 
> 2.25.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
