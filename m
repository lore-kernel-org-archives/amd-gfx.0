Return-Path: <SRS0=QpD2=6M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5062BC83004
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 23:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E604B206D6
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 23:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SqAfgARZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E604B206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBA326EA05;
	Tue, 28 Apr 2020 23:24:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 580406E9E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2020 23:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSJsnyzMqptEg+tu1Sz6uypyVf8lYzq9xyBMiD2w8PxVheAtUuk4hPn1VnGKNPHglKVSfKJByJ/ibF60KUJnDS+QlUexRhZIBkn2HZT1C5LVk7hTznyHw0+GyUQSmhEl/yJkBkZITx3bDJ3yDL4Uu9xqiWTw3jjM3x6aZvOwreVT+y5ebbUa6r4WPwG7ZRKS9lpPEuENGevHvawrlGMiCwnCIxqOKyFye5qSBS+WDpRb1qbj9IxAn0MOBwqV8K0/sqo2MTNzWvFxdpI6KPsajzFo3tC5vHJ/SIwtiuA/2CU4Pxpfw7ei/+lzdjZSiJ+K7vWUl8QWksTFbxqfzIkuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHE3hGGcp9OjmbmFEndwRCEB6sHC7HAXiaPf7/XaUA8=;
 b=FYpalVkoX7AzLpDzlBzyKGoPsw+QesfzleykKM1ROsZMWlQNbCx/uskEndnq+AKsI7emtfdFnXKUriExgg+fzaPGvUn0Cm/2W3mXtAjKNOjew1PqESpmxt8lF/TSqw9ro5Ew6TlHbkIeuY6SAP+tBuWZdIIhHbuRtInaAtiesOkaqRoNXeVzKxvgFK/NoABoI7i050az8kziD52aaRL00zAkYpqEqyjxRxZ3y6XFy9D2maekRteeOgnywbIawMA+XOX4VDqm/d8ztiAPWNJpce+TFzeqF7/bK06prQAqzE5tEWHN/kkhsSFHr5Lm9v4pC2U4FxqBVzDeBqzeaGhukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHE3hGGcp9OjmbmFEndwRCEB6sHC7HAXiaPf7/XaUA8=;
 b=SqAfgARZzG6cWzuGKzNusEk52W2e6odtqGRrU7K0EpGxk9pjVBuuB3ZaoWhkzh+8mGRuLSkQaLo1V3MPJWO3qZKgEgjeMa9gLzAQdYWxvgHDiMgn3hDHRtV1wxxYQiJQbFZ6rkVyR3NqMIFzAEV22gG2d4aFPMMepmDHPj97CRg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2511.namprd12.prod.outlook.com (2603:10b6:802:23::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 23:24:56 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 23:24:56 +0000
Subject: Re: [PATCH v4] drm/amdkfd: Track GPU memory utilization per process
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200428024852.30130-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <1ef7e7d9-d258-c29f-ab14-b3202c71b56e@amd.com>
Date: Tue, 28 Apr 2020 19:24:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200428024852.30130-1-mukul.joshi@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::16) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Tue, 28 Apr 2020 23:24:54 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a7c2fe92-b025-4cc3-b612-08d7ebcb5bbc
X-MS-TrafficTypeDiagnostic: SN1PR12MB2511:|SN1PR12MB2511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25116AFE222313AEA4292B4692AC0@SN1PR12MB2511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(66946007)(186003)(478600001)(26005)(66476007)(66556008)(31686004)(86362001)(31696002)(8676002)(36756003)(2906002)(5660300002)(2616005)(52116002)(44832011)(16526019)(316002)(6486002)(30864003)(16576012)(956004)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNS9tNbfB36G36BUwJkHO2DHQQrEX8v85bOZfLKUJrvl2DLXXxDjYRL+gj6aft9Z5zbpi18Fqge6Xj0B1ux9LskJTK9AJvoT4+Z9muXdNuhRwq7XrPxsR08AtyvQDEwCCRwOifHOCKj3sm55ZpojbOChTBFsg3OfLVjSlnNKNm+e3VkcQSQp6VjNK2ayktiHao3jpwp25rZArYR3xf+mz+vhsvffWfM15XrUcqG3jne5BXDcs/jr8waPTzHglmzRSgdNAzaDjA7karFMlavMTtm1iV7VTNZMn29PH64dDfLyL94PnwldtXb4IGnseebam0lvI5qjYoLNWzip56Gf9Kxx2/N/YZ6BNNDOfeW46Nob+TFuV8YSPABar8MWGPtTQw1hUhxodtjhCEkfih7iLIxRnOBdB0WXHD/Xowq3hSztU5jz3u0VMfM8PDnFZIj/
X-MS-Exchange-AntiSpam-MessageData: O2fYeHNwSLn3GtEd1uEegoqGgnDSe8+BCA20QDeA4p0pAKMDEF51RhwgynpaJ2+YqaVXY9bLX7zjylAXo3qBIhYQVtb/c+No3VUBq9ca8dDSHrKxIJ3E7c3sPF5TnphkP8MnsRpIUXVHrK/8NkmcnfzPSLSuSZ6Qxi7iXrm5uckNn1sCEoVYVYirl4vjilW3DvjjmwP0OaUHg5uaV5oLV5xaKXNZ8Runo1Pv82f048UC5OZ8gc8xsnBtBXLEXArCfiMZ2VkpCcrWWDJxQfeFSq4mcDXomIQt2Ckb+I2u9NybwfK2Err0V/JkO1WyszuHRP53O0NB+O1Hsck0j000b2m3EWRuX8h/OpbcALUd52j06obovXIi30ShLKjXSgWlkxLwYqDR072criKQoMLj8tCgEvKxu4Ys9XRaKpyl+O52sEyQOpScPDjVN7I1IRWV9AIAmvU2Ea3AgN+sGsHkVEYVtUuNM4R23zl581xvXVNmqiEjX6xtRtVsABuHUGyhfzkTOyfC06zwoLzF4zjx0ekU6Kis2Zpq5W6A8vhB43tKIuKaS4ts/I29X1zp/yAXWscIrDwtZvrhPnFrDkDDnoCv24ZdPaTHaNX8Btt043e61udRW07bdk2b3mLljrnfI9nMZsJnq7E/9rsfMlqj7VFTBnCiI7asM9h5VSw3kMzC0yp2rhExBsev7jhnmnXscvo8DkgeDubT5uEtjVAyDgFhLRsbERC/rmFjCqzK2UfIO6Njevr5yOvIvaKwT9+4kGbDGYpvMKxvjfNfgeGmu4zPqfeXrWLWaB74hhEEp/c=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c2fe92-b025-4cc3-b612-08d7ebcb5bbc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 23:24:55.3952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KaSr73bPGnePmkaTmRjll08q198U5sW+wCKBrXsV1OBWX3CQQ0A2bXnPI/snsC9PyTVKG/zalDUOYTxx/oMYCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2511
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2020-04-27 um 10:48 p.m. schrieb Mukul Joshi:
> Track GPU VRAM usage on a per process basis and report it through
> sysfs.
>
> v2:
>    - Handle AMDGPU BO-specific details in
>      amdgpu_amdkfd_gpuvm_free_memory_of_gpu().
>    - Return size of VRAM BO being freed from
>      amdgpu_amdkfd_gpuvm_free_memory_of_gpu().
>    - Do not consider imported memory for VRAM
>      usage calculations.
>
> v3:
>    - Move handling of imported BO size from
>      kfd_ioctl_free_memory_of_gpu() to
>      amdgpu_amdkfd_gpuvm_free_memory_of_gpu().
>
> v4:
>    - Add READ_ONCE() and WRITE_ONCE() around 
>      reading and writing vram_usage count.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  3 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 16 +++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 13 ++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 57 ++++++++++++++++---
>  5 files changed, 84 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index d065c50582eb..a501026e829c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -65,6 +65,7 @@ struct kgd_mem {
>  	struct amdgpu_sync sync;
>  
>  	bool aql_queue;
> +	bool is_imported;
>  };
>  
>  /* KFD Memory Eviction */
> @@ -219,7 +220,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>  		void *vm, struct kgd_mem **mem,
>  		uint64_t *offset, uint32_t flags);
>  int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> -		struct kgd_dev *kgd, struct kgd_mem *mem);
> +		struct kgd_dev *kgd, struct kgd_mem *mem, uint64_t *size);
>  int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>  		struct kgd_dev *kgd, struct kgd_mem *mem, void *vm);
>  int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 0768b7eb7683..1247938b1ec1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1277,7 +1277,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>  }
>  
>  int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> -		struct kgd_dev *kgd, struct kgd_mem *mem)
> +		struct kgd_dev *kgd, struct kgd_mem *mem, uint64_t *size)
>  {
>  	struct amdkfd_process_info *process_info = mem->process_info;
>  	unsigned long bo_size = mem->bo->tbo.mem.size;
> @@ -1286,9 +1286,11 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>  	struct ttm_validate_buffer *bo_list_entry;
>  	unsigned int mapped_to_gpu_memory;
>  	int ret;
> +	bool is_imported = 0;
>  
>  	mutex_lock(&mem->lock);
>  	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
> +	is_imported = mem->is_imported;
>  	mutex_unlock(&mem->lock);
>  	/* lock is not needed after this, since mem is unused and will
>  	 * be freed anyway
> @@ -1340,6 +1342,17 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>  		kfree(mem->bo->tbo.sg);
>  	}
>  
> +	/* Update the size of the BO being freed if it was allocated from
> +	 * VRAM and is not imported.
> +	 */
> +	if (size) {
> +		if ((mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM) &&
> +		    (!is_imported))
> +			*size = bo_size;
> +		else
> +			*size = 0;
> +	}
> +
>  	/* Free the BO*/
>  	amdgpu_bo_unref(&mem->bo);
>  	mutex_destroy(&mem->lock);
> @@ -1694,6 +1707,7 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
>  	(*mem)->process_info = avm->process_info;
>  	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, false);
>  	amdgpu_sync_create(&(*mem)->sync);
> +	(*mem)->is_imported = true;
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index f8fa03a12add..72c5843d9861 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1322,6 +1322,10 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>  		goto err_free;
>  	}
>  
> +	/* Update the VRAM usage count */
> +	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
> +		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + args->size);
> +
>  	mutex_unlock(&p->mutex);
>  
>  	args->handle = MAKE_HANDLE(args->gpu_id, idr_handle);
> @@ -1337,7 +1341,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>  	return 0;
>  
>  err_free:
> -	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, (struct kgd_mem *)mem);
> +	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, (struct kgd_mem *)mem, NULL);
>  err_unlock:
>  	mutex_unlock(&p->mutex);
>  	return err;
> @@ -1351,6 +1355,7 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
>  	void *mem;
>  	struct kfd_dev *dev;
>  	int ret;
> +	uint64_t size = 0;
>  
>  	dev = kfd_device_by_id(GET_GPU_ID(args->handle));
>  	if (!dev)
> @@ -1373,7 +1378,7 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
>  	}
>  
>  	ret = amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd,
> -						(struct kgd_mem *)mem);
> +						(struct kgd_mem *)mem, &size);
>  
>  	/* If freeing the buffer failed, leave the handle in place for
>  	 * clean-up during process tear-down.
> @@ -1382,6 +1387,8 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
>  		kfd_process_device_remove_obj_handle(
>  			pdd, GET_IDR_HANDLE(args->handle));
>  
> +	WRITE_ONCE(pdd->vram_usage, pdd->vram_usage - size);
> +
>  err_unlock:
>  	mutex_unlock(&p->mutex);
>  	return ret;
> @@ -1726,7 +1733,7 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
>  	return 0;
>  
>  err_free:
> -	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, (struct kgd_mem *)mem);
> +	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, (struct kgd_mem *)mem, NULL);
>  err_unlock:
>  	mutex_unlock(&p->mutex);
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 43b888b311c7..e7918fc3cee5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -616,6 +616,8 @@ enum kfd_pdd_bound {
>  	PDD_BOUND_SUSPENDED,
>  };
>  
> +#define MAX_VRAM_FILENAME_LEN 11
> +
>  /* Data that is per-process-per device. */
>  struct kfd_process_device {
>  	/*
> @@ -658,6 +660,11 @@ struct kfd_process_device {
>  
>  	/* Is this process/pasid bound to this device? (amd_iommu_bind_pasid) */
>  	enum kfd_pdd_bound bound;
> +
> +	/* VRAM usage */
> +	uint64_t vram_usage;
> +	struct attribute attr_vram;
> +	char vram_filename[MAX_VRAM_FILENAME_LEN];
>  };
>  
>  #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index fe0cd49d4ea7..b626062c6232 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -79,18 +79,22 @@ static struct kfd_procfs_tree procfs;
>  static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
>  			       char *buffer)
>  {
> -	int val = 0;
> -
>  	if (strcmp(attr->name, "pasid") == 0) {
>  		struct kfd_process *p = container_of(attr, struct kfd_process,
>  						     attr_pasid);
> -		val = p->pasid;
> +
> +		return snprintf(buffer, PAGE_SIZE, "%d\n", p->pasid);
> +	} else if (strncmp(attr->name, "vram_", 5) == 0) {
> +		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
> +							      attr_vram);
> +		if (pdd)
> +			return snprintf(buffer, PAGE_SIZE, "%llu\n", READ_ONCE(pdd->vram_usage));
>  	} else {
>  		pr_err("Invalid attribute");
>  		return -EINVAL;
>  	}
>  
> -	return snprintf(buffer, PAGE_SIZE, "%d\n", val);
> +	return 0;
>  }
>  
>  static void kfd_procfs_kobj_release(struct kobject *kobj)
> @@ -206,6 +210,34 @@ int kfd_procfs_add_queue(struct queue *q)
>  	return 0;
>  }
>  
> +int kfd_procfs_add_vram_usage(struct kfd_process *p)
> +{
> +	int ret = 0;
> +	struct kfd_process_device *pdd;
> +
> +	if (!p)
> +		return -EINVAL;
> +
> +	if (!p->kobj)
> +		return -EFAULT;
> +
> +	/* Create proc/<pid>/vram_<gpuid> file for each GPU */
> +	list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
> +		snprintf(pdd->vram_filename, MAX_VRAM_FILENAME_LEN, "vram_%u",
> +			 pdd->dev->id);
> +		pdd->attr_vram.name = pdd->vram_filename;
> +		pdd->attr_vram.mode = KFD_SYSFS_FILE_MODE;
> +		sysfs_attr_init(&pdd->attr_vram);
> +		ret = sysfs_create_file(p->kobj, &pdd->attr_vram);
> +		if (ret)
> +			pr_warn("Creating vram usage for gpu id %d failed",
> +				(int)pdd->dev->id);
> +	}
> +
> +	return ret;
> +}
> +
> +
>  void kfd_procfs_del_queue(struct queue *q)
>  {
>  	if (!q)
> @@ -248,7 +280,7 @@ static void kfd_process_free_gpuvm(struct kgd_mem *mem,
>  	struct kfd_dev *dev = pdd->dev;
>  
>  	amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(dev->kgd, mem, pdd->vm);
> -	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, mem);
> +	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, mem, NULL);
>  }
>  
>  /* kfd_process_alloc_gpuvm - Allocate GPU VM for the KFD process
> @@ -312,7 +344,7 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
>  	return err;
>  
>  err_map_mem:
> -	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->kgd, mem);
> +	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->kgd, mem, NULL);
>  err_alloc_mem:
>  	*kptr = NULL;
>  	return err;
> @@ -411,6 +443,11 @@ struct kfd_process *kfd_create_process(struct file *filep)
>  							process->kobj);
>  		if (!process->kobj_queues)
>  			pr_warn("Creating KFD proc/queues folder failed");
> +
> +		ret = kfd_procfs_add_vram_usage(process);
> +		if (ret)
> +			pr_warn("Creating vram usage file for pid %d failed",
> +				(int)process->lead_thread->pid);
>  	}
>  out:
>  	if (!IS_ERR(process))
> @@ -488,7 +525,7 @@ static void kfd_process_device_free_bos(struct kfd_process_device *pdd)
>  				peer_pdd->dev->kgd, mem, peer_pdd->vm);
>  		}
>  
> -		amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->kgd, mem);
> +		amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->kgd, mem, NULL);
>  		kfd_process_device_remove_obj_handle(pdd, id);
>  	}
>  }
> @@ -551,6 +588,7 @@ static void kfd_process_wq_release(struct work_struct *work)
>  {
>  	struct kfd_process *p = container_of(work, struct kfd_process,
>  					     release_work);
> +	struct kfd_process_device *pdd;
>  
>  	/* Remove the procfs files */
>  	if (p->kobj) {
> @@ -558,6 +596,10 @@ static void kfd_process_wq_release(struct work_struct *work)
>  		kobject_del(p->kobj_queues);
>  		kobject_put(p->kobj_queues);
>  		p->kobj_queues = NULL;
> +
> +		list_for_each_entry(pdd, &p->per_device_data, per_device_list)
> +			sysfs_remove_file(p->kobj, &pdd->attr_vram);
> +
>  		kobject_del(p->kobj);
>  		kobject_put(p->kobj);
>  		p->kobj = NULL;
> @@ -862,6 +904,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>  	pdd->bound = PDD_UNBOUND;
>  	pdd->already_dequeued = false;
>  	pdd->runtime_inuse = false;
> +	pdd->vram_usage = 0;
>  	list_add(&pdd->per_device_list, &p->per_device_data);
>  
>  	/* Init idr used for memory handle translation */
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
