Return-Path: <SRS0=l8SD=DP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195CDC43467
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2020 11:35:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D382145D
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2020 11:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BE6CMDmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D382145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB4256E3C4;
	Thu,  8 Oct 2020 11:35:29 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680066.outbound.protection.outlook.com [40.107.68.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84A146E3C4
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2020 11:35:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFl8z4yvImZAMWtQcW4BfBYHKWDDcrqEgvqamEIMa3wziD2Wr9sTNQiBiLHiIaMZDCWlrNQIbblh76x4hmvKS5ekofOiUcBPvvaxarVbWv/57FW1kkK43wO0wwcD+Oh+7s93SD+NxjEWXiMXEHj1zk8Bxd/JhXIdVWJLXK1P3dyzJVdgTdg40AwGRMmVndEkfOD36NUqroZwL80T9mTn2Xt8iGgwPqnA8b9W2ha5/24RGU3lFp3CuuZPKZzh/lvlWGAGl/gBklP3bem/75VzkUCne1PU4zRAfL0R0OSyb4BsnKZD5Fg/zWLw0Z18UnfCgsvTc507LWp3GkBQ2tMT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbADjKQSO7XjtkKdJi9qUvLcr3VFeWglPZem4Z5gqLY=;
 b=GGZiBeTVa4kXiTv/6fZugdNONuKvUJFtk4//V6MLfHHsyhvV29Z/cy7PqE8IKSH9s8HlTs8HJ5r3Nkl0PdbqMrNlAoZM5pXHqkgzbFmUHRpOjhbGyGTuYEJhOnCzZIcOb5pVro1RSejFzX8f+YddAynJZSJg1URqda/oDS9+pgHPcIk7QgTxCuBiPZ2CUjvzYspjbbxmEZmRCQ1jil6eTpsvFSIiGEuLlYvXSUElu8rcbMZ2mG09mLPGn/Oey/KY3y7ZFqwOZyB8zCe11QIb6STvRNNR07CxzHJC9PBAdhaBh0JnjbFQvBh24IfnRXm11TUJSc5uE0/dArTFDh+h7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbADjKQSO7XjtkKdJi9qUvLcr3VFeWglPZem4Z5gqLY=;
 b=BE6CMDmb3PqXdGnDh5v9BsWjKQyor3pgAhT6kqOKHYTXcrwlcay4hp7ENjkD0xgHtEXg6PXUEnabADvtrtJSrj7TNMyeBlATlqqMiV88qdXjwZenyHIVVMgBoFANHXgh+AtCa0f1FrMJ8b+ITq7UKMTHT1/mIc9IfyjeyxTMwd8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Thu, 8 Oct
 2020 11:35:26 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3455.024; Thu, 8 Oct 2020
 11:35:25 +0000
Subject: Re: [PATCH] drm/amdgpu: Add debugfs entry for printing VM info
To: Mihir Patel <mihir.patel@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201008111824.110811-1-mihir.patel@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7ffd97df-d3a9-1704-423a-da33d62b97d0@amd.com>
Date: Thu, 8 Oct 2020 13:35:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201008111824.110811-1-mihir.patel@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM3PR05CA0124.eurprd05.prod.outlook.com
 (2603:10a6:207:2::26) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR05CA0124.eurprd05.prod.outlook.com (2603:10a6:207:2::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 11:35:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d400b14-b06d-487f-6431-08d86b7e3fef
X-MS-TrafficTypeDiagnostic: MN2PR12MB4566:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4566CECD5A4CAE960F78F488830B0@MN2PR12MB4566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f98Yu4RvutRiIhMR39VqfUrDz641Q1DGNUJQdY2WmVvBSL1bnnl3J0zSkbyWnegGchV6enRZVXLc/d4RuApKy+U2vGTdxNejX0Vw8MYhbjMIugCJ0Ky7YU5FGO2SxYg289eaE6LnRAVIKHMlZgI7mcy11f2ojk4Q80Lvrh3w0CmgDVojg1vOflRO2aAxt2YA6F+R+yNFpC8DTrMmOWIKa86fFHDrWEwXB77rUVcpawPd0zeJ3jBbWQRcEhzQRdNry70IIsX37MFOrlOZbPF3buu18d7x+TE9Ay1uSEbyktJUuNPuDzY8e7J8pPzcLExoVwl+/8+9SewEntVIZbIBDIdrdAwqYZ+KlJyF25nmjnLbWtbN352y+yCrSuEeL+Fo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(478600001)(186003)(16526019)(66556008)(66476007)(66946007)(2906002)(86362001)(52116002)(316002)(83380400001)(36756003)(4326008)(8676002)(5660300002)(31696002)(6486002)(6666004)(2616005)(8936002)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ptxwKN/UiZGxfpVYfpBv4qg2ceHpn2cHkaqpO8LnTSLI2kA3CkC8e7czFV7bZUtj0VCyDQZTUmwz3mURtiUs6MHNvf2gj3OZQZvKOzenNogq+MD6ynpCy6lpTqNFiOYsqVaSnTdAO6Po2U6ocFTmoaB28I6PrCMQdHuELH+CWWSpGe0U5kHOkIUkg1y4D006X5fm3UQBErQX5dbIXbEZbkdwlJGDTWF5bWq0E57dTugPd82o6gyFNUN7v9Nu8U6fK8Mt/vlmlTNMc7NyYul1zAktlgQrxzmxIHmJ3TPpRWIoXnczkEQH1c0loG/sZIe/Vpd8qmr3RZmVYS6OhLRwvC/DPXWexsBAkF/8JaXu+mhptxJqSUY9VsANUFpGaxSF4UuUNmfIuYbtDnlbMHKijqgeXPMpAi1iogyYi0dCrS8kINOqXkBEk4rBB/qHAt2J52+WvnN531zLy+CNT1FnhFh7S/WJFsMEiDSshGu9xJm7e/He0AxPYrLtdkuNVOBCOWBB73LErC1T4yJlT0I5dmDHLmWXY7eUiN/sHyVgzfnYM9mpiWN+RbuVLzQA3a0vwiueSVaV9Jn1FBo+oxZAOOJkdxlt7OUp7JmwI1sjUhO6V4tOVh86IdBsQv1e41ocFFAsj0MWIZuMmzszmPvJsifcb9QjEHiCXU2mXMFhegR6P+wAErYHvUYDPkH/pjiY/DZREeVGBqbcjxYoxHzOGg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d400b14-b06d-487f-6431-08d86b7e3fef
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 11:35:25.7788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4eVYaFSTQz8RqiH4dMEV2jfE4oiKp9StzOP33o1GiCMv8i7yMNIVvqjVZ+9bx6kh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
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
Cc: Chauhan.Madhav@amd.com, alexander.deucher@amd.com, pkamliya@amd.com,
 ksurampa@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.10.20 um 13:18 schrieb Mihir Patel:
> From: Mihir Bhogilal Patel <Mihir.Patel@amd.com>
>
> Create new debugfs entry to print memory info using VM buffer
> objects.
>
> Note: Early upload for discussion and review
> Require work for:
> - Identifying correct list for swap information
> - Review on proper locking
> - Consolidated memory utilization info like total etc.

Well that looks like a good start to me, a few nit picks and a bigger 
locking issue below.

> Signed-off-by: Mihir Bhogilal Patel <Mihir.Patel@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  34 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 123 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   4 +
>   3 files changed, 161 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 2d125b8b15ee..74028b7d673c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1335,11 +1335,45 @@ static int amdgpu_debugfs_evict_gtt(struct seq_file *m, void *data)
>   	return 0;
>   }
>   
> +static int amdgpu_debugfs_vm_info(struct seq_file *m, void *data)
> +{
> +	struct drm_info_node *node = (struct drm_info_node *)m->private;
> +	struct drm_device *dev = node->minor->dev;
> +	struct drm_file *file;
> +	int r;
> +
> +#ifndef HAVE_DRM_DEVICE_FILELIST_MUTEX
> +	r = mutex_lock_interruptible(&dev->struct_mutex);
> +#else
> +	r = mutex_lock_interruptible(&dev->filelist_mutex);
> +#endif

Where is this coming from? On what branch have you based this patch?

In general we usually base new work on amd-staging-drm-next or something 
branched of from there, but this looks like some DKMS branch.

> +	if (r)
> +		return r;
> +
> +	list_for_each_entry(file, &dev->filelist, lhead) {
> +		struct amdgpu_fpriv *fpriv = file->driver_priv;
> +		struct amdgpu_vm *vm = &fpriv->vm;
> +
> +		seq_printf(m, "pid:%d\tProcess:%s ----------\n",
> +				vm->task_info.pid, vm->task_info.process_name);

We should probably add uid here as well, but this can come later.

> +		amdgpu_debugfs_vm_bo_info(vm, m);
> +	}
> +
> +#ifndef HAVE_DRM_DEVICE_FILELIST_MUTEX
> +	mutex_unlock(&dev->struct_mutex);
> +#else
> +	mutex_unlock(&dev->filelist_mutex);
> +#endif
> +
> +	return 0;
> +}
> +
>   static const struct drm_info_list amdgpu_debugfs_list[] = {
>   	{"amdgpu_vbios", amdgpu_debugfs_get_vbios_dump},
>   	{"amdgpu_test_ib", &amdgpu_debugfs_test_ib},
>   	{"amdgpu_evict_vram", &amdgpu_debugfs_evict_vram},
>   	{"amdgpu_evict_gtt", &amdgpu_debugfs_evict_gtt},
> +	{"amdgpu_vm_info", &amdgpu_debugfs_vm_info},
>   };
>   
>   static void amdgpu_ib_preempt_fences_swap(struct amdgpu_ring *ring,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3cd949aad500..f2f77fd3caa0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3392,3 +3392,126 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, unsigned int pasid,
>   
>   	return false;
>   }
> +
> +#if defined(CONFIG_DEBUG_FS)
> +#define amdgpu_debugfs_vm_bo_print_flag(m, bo, flag)		\
> +	do {							\
> +		if (bo->flags & (AMDGPU_GEM_CREATE_ ## flag)) {	\
> +			seq_printf((m), " " #flag);		\
> +		}						\
> +	} while (0)

We already have something very similar in amdgpu_gem.c.

I suggest to add a function amdgpu_bo_print_flags() into amdgpu_bo.c and 
then call both from here as well as from amdgpu_gem.

> +
> +/**
> + * amdgpu_debugfs_print_bo_info - print BO info in debugfs file
> + *
> + * @id: Index or Id of the BO
> + * @bo: Requested BO for printing info
> + * @data: debugfs file
> + *
> + * Print BO information in debugfs file
> + *
> + * Returns:
> + * Size of the BO in bytes.
> + */
> +static unsigned long amdgpu_debugfs_print_bo_info(int id, struct amdgpu_bo *bo, void *data)
> +{
> +	struct seq_file *m = data;
> +	struct dma_buf_attachment *attachment;
> +	struct dma_buf *dma_buf;
> +	unsigned int domain;
> +	const char *placement;
> +	unsigned int pin_count;
> +	unsigned long size;
> +
> +	domain = amdgpu_mem_type_to_domain(bo->tbo.mem.mem_type);
> +	switch (domain) {
> +	case AMDGPU_GEM_DOMAIN_VRAM:
> +		placement = "VRAM";
> +		break;
> +	case AMDGPU_GEM_DOMAIN_GTT:
> +		placement = " GTT";
> +		break;
> +	case AMDGPU_GEM_DOMAIN_CPU:
> +	default:
> +		placement = " CPU";
> +		break;
> +	}

Same thing as with the flags, we should have only one place for this.

> +
> +	size = amdgpu_bo_size(bo);
> +	seq_printf(m, "\t\t0x%08x: %12ld byte %s",
> +		   id++, size, placement);
> +
> +	pin_count = READ_ONCE(bo->pin_count);
> +	if (pin_count)
> +		seq_printf(m, " pin count %d", pin_count);
> +
> +	dma_buf = READ_ONCE(bo->tbo.base.dma_buf);
> +	attachment = READ_ONCE(bo->tbo.base.import_attach);
> +
> +	if (attachment)
> +		seq_printf(m, " imported from %p", dma_buf);
> +	else if (dma_buf)
> +		seq_printf(m, " exported as %p", dma_buf);
> +
> +	amdgpu_debugfs_vm_bo_print_flag(m, bo, CPU_ACCESS_REQUIRED);
> +	amdgpu_debugfs_vm_bo_print_flag(m, bo, NO_CPU_ACCESS);
> +	amdgpu_debugfs_vm_bo_print_flag(m, bo, CPU_GTT_USWC);
> +	amdgpu_debugfs_vm_bo_print_flag(m, bo, VRAM_CLEARED);
> +	amdgpu_debugfs_vm_bo_print_flag(m, bo, SHADOW);
> +	amdgpu_debugfs_vm_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
> +	amdgpu_debugfs_vm_bo_print_flag(m, bo, VM_ALWAYS_VALID);
> +	amdgpu_debugfs_vm_bo_print_flag(m, bo, EXPLICIT_SYNC);
> +
> +	seq_printf(m, "\n");
> +
> +	return size;
> +}
> +
> +/**
> + * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
> + *
> + * @vm: Requested VM for printing BO info
> + * @data: debugfs file
> + *
> + * Print BO information in debugfs file for the VM
> + */
> +void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, void *data)
> +{
> +	struct seq_file *m = data;
> +
> +	struct amdgpu_bo_va_mapping *mapping;
> +	struct amdgpu_bo_va *bo_va, *tmp;
> +	unsigned long long total_mapped_size = 0;
> +	unsigned long long total_idle_size = 0;
> +	unsigned int total_mapped_objs = 0;
> +	unsigned int total_idle_objs = 0;
> +	unsigned int id = 0;
> +
> +	spin_lock(&vm->invalidated_lock);

That isn't sufficient. You need to reserve the root page directory to 
make sure that nobody is modifying the list of BOs while we dump it here.

We usually do this outside of the VM code itself.

> +	/* Print BO info for all VA mappings */
> +	seq_printf(m, "\tMapped BOs:\n");
> +	for (mapping = amdgpu_vm_it_iter_first(&vm->va, 0, U64_MAX); mapping;
> +	     mapping = amdgpu_vm_it_iter_next(mapping, 0, U64_MAX)) {
> +		if (mapping->bo_va && mapping->bo_va->base.bo)
> +			total_mapped_size += amdgpu_debugfs_print_bo_info(id++,
> +							mapping->bo_va->base.bo, m);
> +	}
> +
> +	total_mapped_objs = id;
> +	id = 0;
> +	/* Print info for Idle BOs */
> +	seq_printf(m, "\tIdle BOs:\n");
> +	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
> +		if (bo_va && bo_va->base.bo)
> +			total_idle_size += amdgpu_debugfs_print_bo_info(id++,
> +								bo_va->base.bo, m);
> +	}

This is quite misleading. You should either print the mappings or the BO 
state, but not both.

I suggest to only use the BO state, but for this you need to handle 
evicted, relocated, moved, idle and invalidated. See amdgpu_vm.h for all 
the states.

Regards,
Christian.

> +	spin_unlock(&vm->invalidated_lock);
> +
> +	total_idle_objs = id;
> +	seq_printf(m, "\tTotal mapped size:  %12lld\n", total_mapped_size);
> +	seq_printf(m, "\tTotal mapped objs:  %12d\n", total_mapped_objs);
> +	seq_printf(m, "\tTotal idle size:    %12lld\n", total_idle_size);
> +	seq_printf(m, "\tTotal idle objs:    %12d\n", total_idle_objs);
> +}
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 7c46937c1c0e..a64465c72c9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -441,4 +441,8 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>   				struct amdgpu_vm *vm);
>   void amdgpu_vm_del_from_lru_notify(struct ttm_buffer_object *bo);
>   
> +#if defined(CONFIG_DEBUG_FS)
> +void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, void *data);
> +#endif
> +
>   #endif

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
