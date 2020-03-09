Return-Path: <SRS0=uBoY=42=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0197EC10F25
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 21:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0F5524649
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 21:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YzCTW4oG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F5524649
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73B5A6E5A4;
	Mon,  9 Mar 2020 21:45:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DB0B6E5A2
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2020 21:45:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ev0G7c27Kclm+jTNLDzjHVsDFjXuJr1T8kzbmH2xAZj6As8jfBs9ndSA7kWvD/7RE22IRl4wvRagRWXU4vymNI9EqcUQCpj2Vo/ANZHC0TsrcLNAiBGZOdgvJCoO9gT8SgcJEheECOXIfA0r561gPA6gc6QpBMQZlS5DUNkv8ou/G+x+25uG98IimmhAP5B0Xt3KBDRMlFmR6punjkPyZSIfrpMjlScthNCjYMR4fbLTfEktCovYEDFObLPHZYnjo5BB3jkW9gyDV6EWM+5SKvPSXGGrSTAStwUVVQKQ4ZZzSReg0IgFkXVTWfWugXLjcUoJSOvhOZtBqLDmfG5TDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KGziJfsgs6j+/XXLmhcYDAJ3BxmKlVvO2YbIYF+EnY=;
 b=Bjp+cY+MBg1qp3kljaHvc6H5KHpUWMr9eXaDHZ+RJpPwXD2XsUnQ3gDH3kDhFhJbmEm97bVnQB99H8ZoMU++e0J7tJNoXBhXZh3VYglc9ojNqI+U72Tfhr2EEATbwyE52htYOIDISRrGMfkAbgF3ZKv3qsoUwYpaXgdYJB2tz8D+revN4W+YJEHR73PY0bwqlr+2g0bETIlbr1yMfK9VpI8oUjk2m5T355cdWUFfWj2jiiG6n9fT2mQF9UWck4kAxmyOumUeuhyBhi435bkPs71Cbeglo5R6b8zuHl0AMAqW5VKtmrv2DS+LtGw/9k8nPT1LPmh2jlbKLU/BVsSSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KGziJfsgs6j+/XXLmhcYDAJ3BxmKlVvO2YbIYF+EnY=;
 b=YzCTW4oGJqKy/Qt5xZaMlTFn4pufqSBp3eos0s2ApluN9+bRzKpjsf5u0u+MKOvK53ulFapdSOVSRQa9PAb/6+dzeJkuFtTdPyZ/jpv/d6WQFuMoEnim19eVwquX7KL8fcWrIrhG1Yh4/sbINRmSZtEY8upHN3bGC2KfNPeXXfY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12)
 by DM5PR1201MB0122.namprd12.prod.outlook.com (2603:10b6:4:57::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Mon, 9 Mar
 2020 21:45:38 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 21:45:38 +0000
Subject: Re: [PATCH] drm/amdkfd: Consolidate duplicated bo alloc flags
To: Yong Zhao <Yong.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200306233059.26546-1-Yong.Zhao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <8705bf5d-4599-c06b-63b0-bab2997c21a7@amd.com>
Date: Mon, 9 Mar 2020 17:45:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200306233059.26546-1-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::18) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.229.252] (165.204.55.251) by
 YTXPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend
 Transport; Mon, 9 Mar 2020 21:45:38 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9fe7c6d-0006-4346-971e-08d7c47334b8
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0122:|DM5PR1201MB0122:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01229D02C8F7F53A890C2AC292FE0@DM5PR1201MB0122.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(189003)(199004)(5660300002)(2906002)(316002)(478600001)(31686004)(36756003)(16576012)(66946007)(81166006)(81156014)(66476007)(2616005)(956004)(31696002)(66556008)(53546011)(86362001)(8936002)(8676002)(52116002)(6486002)(16526019)(26005)(186003)(44832011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0122;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9fjBdvii1Kqdqmnxa0MgXfQIqKONhigym841r16HTIdVSgYoH7S0t8L6p81Q6b+JP7gWWgmMvPn95sIH8P241AUXKxmViZsJ9gMWqyjteJphSyhupUp3GLSftkM7bcsi176963qLgFsBurVVtgIOhb9oukEImbEDDNgFovr0WNtqyMPV5gaYKPzCGm9mWNz3tS+8wAk5X8zilb9bvIowSTDGFRkJTHnfFLoc0blxVEDBLQj1Z31U3Qd0ijNUHoyCiAe5JwbWXZLBFr0Bs4BWgykKtD9HTjFI1of1otN8V0sPvxp6OzGLQBxUqutGdn03p4PwjMm2aoX82VZv6HsDd0c8/ZyY/n/3108ukV3tdpUu69fEJFd4pZon/Tw2LvHB1MbXHRNX1LQPa+48yg+NyyZVTvZJFhfL1SF+0QZTlj0pFe7ueqA57cwxOvz+MCno
X-MS-Exchange-AntiSpam-MessageData: mcTlUgB6H3qaugESUFZMP82jNpgF6hHdPFpg9YAxjLJm3qHjL5MnuAPeXaMY18MfNxalxmG0KWdKEP2qzwN8PFfV6jg4KkvWqXYsTvMisNP9prLAhwyBnIUNz1NLXzN/c+3fVcxyz0WS5BV581GuRQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fe7c6d-0006-4346-971e-08d7c47334b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 21:45:38.3998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxKto4pvRE3GBTeI1CQHZ4IIp8ZxSTEZMzqI+lXQCchWP6SboGAyw+p94BhnGv7aUqCjQmjoajiuHWxBI7g9Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0122
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-03-06 18:30, Yong Zhao wrote:
> ALLOC_MEM_FLAGS_* used are the same as the KFD_IOC_ALLOC_MEM_FLAGS_*,
> but they are interweavedly used in kernel driver, resulting in bad
> readability. For example, KFD_IOC_ALLOC_MEM_FLAGS_COHERENT is not
> referenced in kernel, and it functions implicitly in kernel through
> ALLOC_MEM_FLAGS_COHERENT, causing unnecessary confusion.
>
> Replace all occurrences of ALLOC_MEM_FLAGS_* with
> KFD_IOC_ALLOC_MEM_FLAGS_* to solve the problem.
>
> Change-Id: Iced6ed3698167296c97b14e7e4569883859d619c
> Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  6 ++--
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 29 ++++++++++---------
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 13 +++++----
>   .../gpu/drm/amd/include/kgd_kfd_interface.h   | 21 --------------
>   4 files changed, 27 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 726c91ab6761..abfbe89e805e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -29,6 +29,7 @@
>   #include <linux/module.h>
>   #include <linux/dma-buf.h>
>   #include "amdgpu_xgmi.h"
> +#include <uapi/linux/kfd_ioctl.h>
>   
>   static const unsigned int compute_vmid_bitmap = 0xFF00;
>   
> @@ -501,10 +502,11 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
>   					   metadata_size, &metadata_flags);
>   	if (flags) {
>   		*flags = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
> -			ALLOC_MEM_FLAGS_VRAM : ALLOC_MEM_FLAGS_GTT;
> +				KFD_IOC_ALLOC_MEM_FLAGS_VRAM
> +				: KFD_IOC_ALLOC_MEM_FLAGS_GTT;
>   
>   		if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
> -			*flags |= ALLOC_MEM_FLAGS_PUBLIC;
> +			*flags |= KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC;
>   	}
>   
>   out_put:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index e4481caed648..9dff792c9290 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -29,6 +29,7 @@
>   #include "amdgpu_vm.h"
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu_dma_buf.h"
> +#include <uapi/linux/kfd_ioctl.h>
>   
>   /* BO flag to indicate a KFD userptr BO */
>   #define AMDGPU_AMDKFD_USERPTR_BO (1ULL << 63)
> @@ -400,18 +401,18 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct amdgpu_sync *sync)
>   static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
>   {
>   	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(mem->bo->tbo.bdev);
> -	bool coherent = mem->alloc_flags & ALLOC_MEM_FLAGS_COHERENT;
> +	bool coherent = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT;
>   	uint32_t mapping_flags;
>   
>   	mapping_flags = AMDGPU_VM_PAGE_READABLE;
> -	if (mem->alloc_flags & ALLOC_MEM_FLAGS_WRITABLE)
> +	if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE)
>   		mapping_flags |= AMDGPU_VM_PAGE_WRITEABLE;
> -	if (mem->alloc_flags & ALLOC_MEM_FLAGS_EXECUTABLE)
> +	if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE)
>   		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
>   
>   	switch (adev->asic_type) {
>   	case CHIP_ARCTURUS:
> -		if (mem->alloc_flags & ALLOC_MEM_FLAGS_VRAM) {
> +		if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>   			if (bo_adev == adev)
>   				mapping_flags |= coherent ?
>   					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
> @@ -1160,24 +1161,24 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	/*
>   	 * Check on which domain to allocate BO
>   	 */
> -	if (flags & ALLOC_MEM_FLAGS_VRAM) {
> +	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>   		domain = alloc_domain = AMDGPU_GEM_DOMAIN_VRAM;
>   		alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
> -		alloc_flags |= (flags & ALLOC_MEM_FLAGS_PUBLIC) ?
> +		alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
>   			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED :
>   			AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
> -	} else if (flags & ALLOC_MEM_FLAGS_GTT) {
> +	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
>   		domain = alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
>   		alloc_flags = 0;
> -	} else if (flags & ALLOC_MEM_FLAGS_USERPTR) {
> +	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>   		domain = AMDGPU_GEM_DOMAIN_GTT;
>   		alloc_domain = AMDGPU_GEM_DOMAIN_CPU;
>   		alloc_flags = 0;
>   		if (!offset || !*offset)
>   			return -EINVAL;
>   		user_addr = untagged_addr(*offset);
> -	} else if (flags & (ALLOC_MEM_FLAGS_DOORBELL |
> -			ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> +	} else if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +			KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
>   		domain = AMDGPU_GEM_DOMAIN_GTT;
>   		alloc_domain = AMDGPU_GEM_DOMAIN_CPU;
>   		bo_type = ttm_bo_type_sg;
> @@ -1198,7 +1199,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	}
>   	INIT_LIST_HEAD(&(*mem)->bo_va_list);
>   	mutex_init(&(*mem)->lock);
> -	(*mem)->aql_queue = !!(flags & ALLOC_MEM_FLAGS_AQL_QUEUE_MEM);
> +	(*mem)->aql_queue = !!(flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM);
>   
>   	/* Workaround for AQL queue wraparound bug. Map the same
>   	 * memory twice. That means we only actually allocate half
> @@ -1680,10 +1681,12 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
>   
>   	INIT_LIST_HEAD(&(*mem)->bo_va_list);
>   	mutex_init(&(*mem)->lock);
> +	
>   	(*mem)->alloc_flags =
>   		((bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
> -		 ALLOC_MEM_FLAGS_VRAM : ALLOC_MEM_FLAGS_GTT) |
> -		ALLOC_MEM_FLAGS_WRITABLE | ALLOC_MEM_FLAGS_EXECUTABLE;
> +		KFD_IOC_ALLOC_MEM_FLAGS_VRAM : KFD_IOC_ALLOC_MEM_FLAGS_GTT)
> +		| KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE
> +		| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
>   
>   	(*mem)->bo = amdgpu_bo_ref(bo);
>   	(*mem)->va = va;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 22abdbc6dfd7..1c7bfc842f06 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -327,10 +327,10 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
>   static int kfd_process_device_reserve_ib_mem(struct kfd_process_device *pdd)
>   {
>   	struct qcm_process_device *qpd = &pdd->qpd;
> -	uint32_t flags = ALLOC_MEM_FLAGS_GTT |
> -			 ALLOC_MEM_FLAGS_NO_SUBSTITUTE |
> -			 ALLOC_MEM_FLAGS_WRITABLE |
> -			 ALLOC_MEM_FLAGS_EXECUTABLE;
> +	uint32_t flags = KFD_IOC_ALLOC_MEM_FLAGS_GTT |
> +			KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE |
> +			KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE |
> +			KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
>   	void *kaddr;
>   	int ret;
>   
> @@ -692,8 +692,9 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>   {
>   	struct kfd_dev *dev = pdd->dev;
>   	struct qcm_process_device *qpd = &pdd->qpd;
> -	uint32_t flags = ALLOC_MEM_FLAGS_GTT |
> -		ALLOC_MEM_FLAGS_NO_SUBSTITUTE | ALLOC_MEM_FLAGS_EXECUTABLE;
> +	uint32_t flags = KFD_IOC_ALLOC_MEM_FLAGS_GTT
> +			| KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE
> +			| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
>   	void *kaddr;
>   	int ret;
>   
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index 0cee79d56075..a3c238c39ef5 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -167,27 +167,6 @@ struct tile_config {
>   
>   #define KFD_MAX_NUM_OF_QUEUES_PER_DEVICE_DEFAULT 4096
>   
> -/*
> - * Allocation flag domains
> - * NOTE: This must match the corresponding definitions in kfd_ioctl.h.
> - */
> -#define ALLOC_MEM_FLAGS_VRAM		(1 << 0)
> -#define ALLOC_MEM_FLAGS_GTT		(1 << 1)
> -#define ALLOC_MEM_FLAGS_USERPTR		(1 << 2)
> -#define ALLOC_MEM_FLAGS_DOORBELL	(1 << 3)
> -#define ALLOC_MEM_FLAGS_MMIO_REMAP	(1 << 4)
> -
> -/*
> - * Allocation flags attributes/access options.
> - * NOTE: This must match the corresponding definitions in kfd_ioctl.h.
> - */
> -#define ALLOC_MEM_FLAGS_WRITABLE	(1 << 31)
> -#define ALLOC_MEM_FLAGS_EXECUTABLE	(1 << 30)
> -#define ALLOC_MEM_FLAGS_PUBLIC		(1 << 29)
> -#define ALLOC_MEM_FLAGS_NO_SUBSTITUTE	(1 << 28) /* TODO */
> -#define ALLOC_MEM_FLAGS_AQL_QUEUE_MEM	(1 << 27)
> -#define ALLOC_MEM_FLAGS_COHERENT	(1 << 26) /* For GFXv9 or later */
> -
>   /**
>    * struct kfd2kgd_calls
>    *
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
