Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A052CC433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jun 2022 02:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3A511131F8;
	Sat, 11 Jun 2022 02:38:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E7E1131F8
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jun 2022 02:38:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDIattYBrrXh4E//oOtOhHNKqMBP+HKP0CMkfxiTH9HZ4aHI5GJd376X8wOGItvUeFqre6Lh7JaYjWC/1mcp79MosXXAnqbNQutIOjxDQSAXYgFdcU13ZXASpTUCjvUUYscZnl4bXdfdd6FwrOM6gOxjDGxQktefu67lLRi9dLeoecb9V8IBdz2pmdHdOiYd02/uDj0T8WYeababW8XPZhhrlABAuT9wa/TSUsZ9ExmwNSneNaplEQO0L9aJQCOLSr+MSyTZPI+6A06urR3sfQCwjeLku/h9ImIntzotkOvP15F5qe0mNH+5N5aE/GPJRDTeG+g7cQ/IAbJA5mI5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S15LqdPbideUTQc53FOZ9bybzPaTaaBJkb3GVBuJuSA=;
 b=RoqpVg1S3LmSpvP5OplJrozZ6G1rs/cfQpXpMGa7DlpuKJwESPFB1REEl23JGfjJTVAe2CR3o+3KH5UpyPz29DJPknXRJYj1Yrop2klM1bqFzuRqA8xvaidQpvhKRc2/O3sS6y3B82d/ryCzX/pUgdAQxZAstHzqtl0CVGOe2fiU2p3Use1+OBjhqKs8BSNozToFQviyNBO8z3l5JfGZCbvGfxQxoSIxvB7HEiMwnCkiz+htLSyYjarvNHXfT+pyzmpAQwcejVQxj9bxp2e4uvReZzw+ki3VtYyw9CJqal3GIfmfF9YARRSVYQxK14LEZG434XtaFsZA6cRYer1VVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S15LqdPbideUTQc53FOZ9bybzPaTaaBJkb3GVBuJuSA=;
 b=ePAWAMp7eAT+rJOJs880+dFnOmcDlbyGO7XxKOU2V0rppGjexpeeWrUtt3DiSeoDof2poDxGWjJHfLxWE/uJAaeAsZW3sPmLaDik2jiO5+K7W98f++YyoGWUfbjiTDNggw7R9oo66QiijX4TvKHmcesazNucpOHy8fLgxXvnatw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 PH0PR12MB5401.namprd12.prod.outlook.com (2603:10b6:510:d4::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Sat, 11 Jun 2022 02:38:06 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5%4]) with mapi id 15.20.5332.015; Sat, 11 Jun 2022
 02:38:06 +0000
Date: Sat, 11 Jun 2022 10:37:56 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Graham Sider <Graham.Sider@amd.com>
Subject: Re: [PATCH v2 2/3] drm/amdkfd: Enable GFX11 usermode queue
 oversubscription
Message-ID: <YqQABPHltcA2awgp@lang-desktop>
References: <20220610171316.2668611-1-Graham.Sider@amd.com>
 <20220610171316.2668611-2-Graham.Sider@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610171316.2668611-2-Graham.Sider@amd.com>
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd215482-1a1c-4795-61db-08da4b536a00
X-MS-TrafficTypeDiagnostic: PH0PR12MB5401:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB54017008E9E1B3925954107FFBA99@PH0PR12MB5401.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wW11JMswXQeWSyD0JhPX8V5MX2Dw0UL/ieS9Up2l6r74of2fhHTfUhmwZeyIUY3wZXquZveZ+VwCaHiT0W6Wh/MmJmlc1/U4sshQqiup0CvkS90FWug3BArUphTmqPOVNVs92Zi3onT/2fXQXsJAH6tlDAfPfqSn5e/3VMdn78SPpppvnA78ItfFfvdxvjvjBrHVBEghR18EuOdNrpX88vRWCjxee2wDz8oUGwETyXMfCDckzUGrkwTrGiq3lgvWVoH/S84JaEHULVwm1tubWeZzFyPpbK+KAE7A0ccZZjNVFxmGQSZaqTOB3lADR2x/iTsqnn19shFZybdp+3lQ3MBX0JXtkG1XebTtIXMF2vsgjDZ9vXjo5kQscgebYkLUbO7B+FI9oqu0W6z7F2VxBftyn9CAymZlZEMiZRnoYxSgpRKjdz07/hDuDWtMEbXG0g+HgR+EdpZoHyf88tYqDKnjPYa64wrI2wMEDYM64YMcYGKQeSINyDH1AgRp+ljvszIPClkvzztyxxwO+HZRoz3JLTwm8aGVrSs6liSdKclx22LZWetmsVwNO9MpkyDKs1cOF+zqEhcOxhu93kYeuLecrDFrSs9H3rT9bDUPtDvpI6/DrSftRq53lKGUkFR05anA9yAuhHtI7NTSdAgkYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(7916004)(366004)(38100700002)(66476007)(66556008)(186003)(316002)(8676002)(4326008)(83380400001)(6636002)(66946007)(6862004)(6486002)(5660300002)(8936002)(508600001)(30864003)(9686003)(6512007)(26005)(6666004)(2906002)(33716001)(6506007)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MwMY9uT3HLEDzhy91EM1Rk0H1wOE0750ee5mb42YSg66fqfLC6e1VtGhfTh5?=
 =?us-ascii?Q?A/rUIw+ET35kMIu9oGO7Xy28MQ74XM/EC+dNottUMIYhpBGUPzFD5mEoI+of?=
 =?us-ascii?Q?GvgbRHF4VyQ05+W3PNsibQ4ofOQUOzvwYq9oku6M18TlS48Fs7jKoZ0OOmH4?=
 =?us-ascii?Q?nhFFBBddRlpLt1nSMU48fCs84X4BGxLgMon+OrHCGHY853Oc0lkaKX0vpk+3?=
 =?us-ascii?Q?bK5/JdppdnaYhYSDPajs71TazjcfGTNktwcOsFKgoN9l7ThMgU1fQ/1qTl22?=
 =?us-ascii?Q?mvHE+K81PicKgPBlhj/nqcidP+7VXSAlsoQKxIDdYxyNPhKxFEAD9UxPrSqi?=
 =?us-ascii?Q?G4zUmaHw/15X2x3TOiX8GpTh/owCL6fgotEEzZp6VZJTh6oWZqoUMwLnTtGh?=
 =?us-ascii?Q?SD2BJtynMVreOKfsQgKlHm2t/zhcJkxCc7Uipe5KLqexXIqKwWtm3ANCdmW2?=
 =?us-ascii?Q?b+QU8sgB3toyeVb1/pmpCeYD9DwzxrjiWxVQJGLrdlwQOke2x1Ff8sy5zUJB?=
 =?us-ascii?Q?PPPYEeWqsKiOe/OS3jM0xYF24WURAfuPIwTfHV7b+3IpCk/9GY1V3xzuJrlV?=
 =?us-ascii?Q?aHVtICaw/pa0Ho6MQo3CilHisCTA6EwOsBbK7JevoNjIMoqPVs2Xbj/Ovub2?=
 =?us-ascii?Q?x7rbdruaA4wuTBo1xbY08geJAZWe7iwrxjBlc+uMFo391nNO93inEcqv+bio?=
 =?us-ascii?Q?gtV4CtosVaKPjU5t0Nm6yZwSPHCKJraFKkYo1RS6iii+8054/UaCWL7RRgDe?=
 =?us-ascii?Q?IkjDNdHpWYmypN5RXWKVMihDflek9iF/O9kJ8QnI7KLf0FzdzHfBxN1Xwlbo?=
 =?us-ascii?Q?aM0AesNSmUIe1FhB/KxAi/9xCG8A3al8EUQAInRxlKiGIeT250j/YWD2Aizs?=
 =?us-ascii?Q?EOX/rB60q/IYFP55/5bZTGOtGFCajsgIZ85uAKkXk1GxM8ZS6yzCFihrDox7?=
 =?us-ascii?Q?su3H06G+kNWXdmGi0uUp4v3AcI6opAoI6n4cdYHP0l2u0xUrC8PilnFtWKeU?=
 =?us-ascii?Q?oya4mgIm8+KUzt4oauiev6s9jEgQaZjXyBE9AMvBW21CqO8MVs2nQSNNnEON?=
 =?us-ascii?Q?BDXg7F415ImrRZd0rB5w/LpUPx7/EeGngDzeYQsBmluXd+ND8nzuD/wBtjWp?=
 =?us-ascii?Q?DujJzWSHJfLTwBMrqCQDITZ0XNwC//ToYLg2GjeViV+ltG9Blh6yiESzqdcD?=
 =?us-ascii?Q?W6lgi3ly/vToOdK/CUmW+L0Gy6pgamz2rxhAk43+h73KS4dPZMaETrhmxWSD?=
 =?us-ascii?Q?rYWuWAX6LxE5mBYdrLN2LcsWN/NKrRRmQEjwj0UW3mJxrjxWriblr2PMCwTA?=
 =?us-ascii?Q?dnKDA+HI2joqJZ4Po/QpU6JsGxUc3aZbUZ2OEYUgPB5o6BtTXFMaxtSXFghv?=
 =?us-ascii?Q?Bo/l7yVxaAeogV+NyOatsCPxUNeu1jLO5B8Kig9wVMLYL4LKntyPn0vJAfYY?=
 =?us-ascii?Q?f2UaIV1/K4RRQ/KGM2/Qb4539pWCQy2mUK+C+tj80y0QchMRP4ptIvkwAxmU?=
 =?us-ascii?Q?ZXpLy8GuKk6HVNFGxuO3+Z1oMHiTLOd5baqBvuQctIlmmqCUDAWQRrSXG/i0?=
 =?us-ascii?Q?41QdxjiCBqJ60S47QnrF3hFtGuaPCr8StPj6Iv/WjP42I+NGayUSC+/1H0Zb?=
 =?us-ascii?Q?TvibYSfZ3x+5L/5vI9FKo5fWvD387xDBQooke5g3RhDO5lMpa87xYzqWN3H9?=
 =?us-ascii?Q?q/uaUoliNEczPpXBP0P4jmKm3ddCYykg4xRFGa9EEvPlc9D+ZMYOLenMgShS?=
 =?us-ascii?Q?73HD78lsHw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd215482-1a1c-4795-61db-08da4b536a00
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2022 02:38:06.3499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCaMRC1Moz5obI3q99+qs4AXDqLIH+3MQ73EIoIWSFzpmulFL5JfjI4OxnfIN3EIwqBuRPKSkRQUoYoVhEEe8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5401
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
Cc: Mukul.Joshi@amd.com, Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org,
 Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 06/10/ , Graham Sider wrote:
> Starting with GFX11, MES requires wptr BOs to be GTT allocated/mapped to
> GART for usermode queues in order to support oversubscription. In the
> case that work is submitted to an unmapped queue, MES must have a GART
> wptr address to determine whether the queue should be mapped.
> 
> This change is accompanied with changes in MES and is applicable for
> MES_VERSION >= 3.
> 
> v2: Update MES_VERSION check from 2 to 3.
> 
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 39 ++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 45 ++++++++++++++++++-
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 +++-
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 +
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
>  .../amd/amdkfd/kfd_process_queue_manager.c    | 19 +++++---
>  7 files changed, 110 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 429b16ba10bf..dba26d1e3be9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -301,6 +301,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
>  		struct kgd_mem *mem, void **kptr, uint64_t *size);
>  void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct amdgpu_device *adev,
>  		struct kgd_mem *mem);
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo);
>  
>  int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>  					    struct dma_fence **ef);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index efab923056f4..2d452655eb04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2030,6 +2030,45 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
>  	return ret;
>  }
>  
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
> +{
> +	int ret;
> +
> +	ret = amdgpu_bo_reserve(bo, true);
> +	if (ret) {
> +		pr_err("Failed to reserve bo. ret %d\n", ret);
> +		goto err_reserve_bo_failed;
> +	}
> +
> +	ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
> +	if (ret) {
> +		pr_err("Failed to pin bo. ret %d\n", ret);
> +		goto err_pin_bo_failed;
> +	}
> +
> +	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
> +	if (ret) {
> +		pr_err("Failed to bind bo to GART. ret %d\n", ret);
> +		goto err_map_bo_gart_failed;
> +	}
> +
> +	amdgpu_amdkfd_remove_eviction_fence(
> +		bo, bo->kfd_bo->process_info->eviction_fence);
> +	list_del_init(&bo->kfd_bo->validate_list.head);
> +
> +	amdgpu_bo_unreserve(bo);
> +
> +	return 0;
> +
> +err_map_bo_gart_failed:
> +	amdgpu_bo_unpin(bo);
> +err_pin_bo_failed:
> +	amdgpu_bo_unreserve(bo);
> +err_reserve_bo_failed:
> +
> +	return ret;
> +}
> +
>  int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
>  		struct kgd_mem *mem, void **kptr, uint64_t *size)
>  {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index e9766e165c38..58d5ebed1b32 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -290,6 +290,11 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>  	struct queue_properties q_properties;
>  	uint32_t doorbell_offset_in_process = 0;
>  
> +	struct amdgpu_bo_va_mapping *wptr_mapping;
> +	struct interval_tree_node *wptr_node;
> +	struct amdgpu_vm *wptr_vm;
> +	struct amdgpu_bo *wptr_bo = NULL;
> +
>  	memset(&q_properties, 0, sizeof(struct queue_properties));
>  
>  	pr_debug("Creating queue ioctl\n");
> @@ -316,12 +321,44 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>  		goto err_bind_process;
>  	}
>  
> +	/* Starting with GFX11, MES requires wptr BOs to be GTT allocated/mapped to
> +	 * GART for usermode queues in order to support oversubscription. In the
> +	 * case that work is submitted to an unmapped queue, MES must have a GART
> +	 * wptr address to determine whether the queue should be mapped.
> +	 */
> +	if (dev->shared_resources.enable_mes && (dev->adev->mes.sched_version & 0xff) >= 3) {
> +		wptr_vm = drm_priv_to_vm(pdd->drm_priv);
> +		err = amdgpu_bo_reserve(wptr_vm->root.bo, false);
> +		if (err)
> +			goto err_wptr_bo_reserve;
> +
> +		wptr_node = interval_tree_iter_first(&wptr_vm->va,
> +				args->write_pointer_address >> PAGE_SHIFT,
> +				args->write_pointer_address >> PAGE_SHIFT);
> +		if (!wptr_node) {
> +			pr_err("Failed to lookup wptr bo\n");
> +			err = -EINVAL;
> +			goto err_wptr_bo_lookup;
> +		}
> +
> +		wptr_mapping = container_of((struct rb_node *)wptr_node, struct amdgpu_bo_va_mapping, rb);

You can use amdgpu_vm_bo_lookup_mapping() to find a mapping by address.

Regards,
Lang

> +		wptr_bo = wptr_mapping->bo_va->base.bo;
> +
> +		amdgpu_bo_unreserve(wptr_vm->root.bo);
> +
> +		err = amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev, wptr_bo);
> +		if (err) {
> +			pr_err("Failed to map wptr bo to GART\n");
> +			goto err_wptr_bo_gart_map;
> +		}
> +	}
> +
>  	pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
>  			p->pasid,
>  			dev->id);
>  
> -	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, NULL, NULL, NULL,
> -			&doorbell_offset_in_process);
> +	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, wptr_bo,
> +			NULL, NULL, NULL, &doorbell_offset_in_process);
>  	if (err != 0)
>  		goto err_create_queue;
>  
> @@ -353,7 +390,11 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>  	kfd_dbg_ev_raise(KFD_EC_MASK(EC_QUEUE_NEW), p, dev, queue_id, false, NULL, 0);
>  	return 0;
>  
> +err_wptr_bo_lookup:
> +	amdgpu_bo_unreserve(wptr_vm->root.bo);
>  err_create_queue:
> +err_wptr_bo_gart_map:
> +err_wptr_bo_reserve:
>  err_bind_process:
>  err_pdd:
>  	mutex_unlock(&p->mutex);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index b39d89c52887..d8de2fbdfc7d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -208,6 +208,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>  	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>  	struct mes_add_queue_input queue_input;
>  	int r, queue_type;
> +	uint64_t wptr_addr_off;
>  
>  	if (dqm->is_hws_hang)
>  		return -EIO;
> @@ -227,7 +228,13 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>  					AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>  	queue_input.doorbell_offset = q->properties.doorbell_off;
>  	queue_input.mqd_addr = q->gart_mqd_addr;
> -	queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
> +
> +	if (q->wptr_bo) {
> +		wptr_addr_off = (uint64_t)q->properties.write_ptr - (uint64_t)q->wptr_bo->kfd_bo->va;
> +		queue_input.wptr_addr = ((uint64_t)q->wptr_bo->tbo.resource->start << PAGE_SHIFT) + wptr_addr_off;
> +	} else
> +		queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
> +
>  	queue_input.paging = false;
>  	queue_input.tba_addr = qpd->tba_addr;
>  	queue_input.tma_addr = qpd->tma_addr;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index f1654b4da856..35e74bdd81da 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -377,6 +377,8 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>  	m->sdmax_rlcx_rb_base_hi = upper_32_bits(q->queue_address >> 8);
>  	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits((uint64_t)q->read_ptr);
>  	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits((uint64_t)q->read_ptr);
> +	m->sdmax_rlcx_rb_wptr_poll_addr_lo = lower_32_bits((uint64_t)q->write_ptr);
> +	m->sdmax_rlcx_rb_wptr_poll_addr_hi = upper_32_bits((uint64_t)q->write_ptr);
>  	m->sdmax_rlcx_doorbell_offset =
>  		q->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index a5d3963537d7..dcddee0d6f06 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -639,6 +639,8 @@ struct queue {
>  	void *gang_ctx_bo;
>  	uint64_t gang_ctx_gpu_addr;
>  	void *gang_ctx_cpu_ptr;
> +
> +	struct amdgpu_bo *wptr_bo;
>  };
>  
>  enum KFD_MQD_TYPE {
> @@ -1404,6 +1406,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>  			    struct file *f,
>  			    struct queue_properties *properties,
>  			    unsigned int *qid,
> +			    struct amdgpu_bo *wptr_bo,
>  			    const struct kfd_criu_queue_priv_data *q_data,
>  			    const void *restore_mqd,
>  			    const void *restore_ctl_stack,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index f99e09dc43ea..ede1462a55c8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -190,7 +190,8 @@ void pqm_uninit(struct process_queue_manager *pqm)
>  static int init_user_queue(struct process_queue_manager *pqm,
>  				struct kfd_dev *dev, struct queue **q,
>  				struct queue_properties *q_properties,
> -				struct file *f, unsigned int qid)
> +				struct file *f, struct amdgpu_bo *wptr_bo,
> +				unsigned int qid)
>  {
>  	int retval;
>  
> @@ -221,6 +222,9 @@ static int init_user_queue(struct process_queue_manager *pqm,
>  			goto cleanup;
>  		}
>  		memset((*q)->gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE);
> +
> +		if (wptr_bo)
> +			(*q)->wptr_bo = amdgpu_bo_ref(wptr_bo);
>  	}
>  
>  	pr_debug("PQM After init queue");
> @@ -237,6 +241,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>  			    struct file *f,
>  			    struct queue_properties *properties,
>  			    unsigned int *qid,
> +			    struct amdgpu_bo *wptr_bo,
>  			    const struct kfd_criu_queue_priv_data *q_data,
>  			    const void *restore_mqd,
>  			    const void *restore_ctl_stack,
> @@ -299,7 +304,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>  		 * allocate_sdma_queue() in create_queue() has the
>  		 * corresponding check logic.
>  		 */
> -		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
> +		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
>  		if (retval != 0)
>  			goto err_create_queue;
>  		pqn->q = q;
> @@ -320,7 +325,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>  			goto err_create_queue;
>  		}
>  
> -		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
> +		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
>  		if (retval != 0)
>  			goto err_create_queue;
>  		pqn->q = q;
> @@ -457,9 +462,13 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>  			pdd->qpd.num_gws = 0;
>  		}
>  
> -		if (dev->shared_resources.enable_mes)
> +		if (dev->shared_resources.enable_mes) {
>  			amdgpu_amdkfd_free_gtt_mem(dev->adev,
>  						   pqn->q->gang_ctx_bo);
> +			if (pqn->q->wptr_bo)
> +				amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
> +
> +		}
>  		uninit_queue(pqn->q);
>  	}
>  
> @@ -900,7 +909,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>  
>  	print_queue_properties(&qp);
>  
> -	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, q_data, mqd, ctl_stack,
> +	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, NULL, q_data, mqd, ctl_stack,
>  				NULL);
>  	if (ret) {
>  		pr_err("Failed to create new queue err:%d\n", ret);
> -- 
> 2.25.1
> 
