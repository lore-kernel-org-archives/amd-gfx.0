Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C9AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 15:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64858611CB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 15:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 64858611CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 099816ECBD;
	Thu, 21 Oct 2021 15:58:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D3236ECBD
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 15:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl2zkLZSpthLBQSrbDYJKC5D9sKA5VpyKMn5mHABqsUwhF0y9enw3aauJamaAORO9hVYcU1rABYQzgLmgyc75L5kT7Lgo4A2FPRdDcl6CXDOs/BvgNR08AA+WyUruaATxCZG0ebSQG4Uny7b96B8JQlb6d5ZqPWez0X1vbg137Geziy9zCETWUlbSOcBcEqWp5nIqZWAuDtaiTduDmsrkZsi/40Vexl18UwcbNIx9GunQNXo6lUrW+XVMBmvCAk45lw25LH7xgzC9/rTLEbStTVFb5GZ08nfg5/auPTYZxaArNRQHAPh1SLkoX1Rcw7OLDZjh8zvuKHB6sFr+qViXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECy2NBi77c065L/Mj5z/UsSqVl0Mpy3mQ0QvmOviCU4=;
 b=WOODXam9Yx61g031+ss0TitDVm1o3wveaJsFMhsrDb2KK+LSJ+mpIrKuro+Vb6EoAfMQw+M/2lsexgEWl8VM8G8B2ImVjtE/nMX7KVH5QpS3v7Nj/8ZS3MS/rDXW8HyCWiWecDm0Rw22O354qU6jM5oWksVSLMyJE4L0iSt484MlfgWD0ty6MIEOOT84beyMXW2ESA9I03UiMXI9X3MAsxsSz7FxM7bWmdg+y5VbZ70MB5a5mpBD+70TPoVPc+5ZLhAmTr/qYTEf5dAxi7qgABcuf4LpDm+QjTn3x76vs6abvjvw2HeHoAUfV+eAUN2dLkcQ52iJtncHIHZxvCMRbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECy2NBi77c065L/Mj5z/UsSqVl0Mpy3mQ0QvmOviCU4=;
 b=LRE7IcReO9V3ceVfMC79kvk4viNLWekHH8mNKmltvUelDrcwwCQX3Ws9MXPtHSp1GXUzh+wux7TRuld6kmEgj3zuiymcduSA2PkPqcl8ho7DdQO77aeT1GHuwi+sndrI8XN/snTvUucGISsfxvIXsATGj63Byb4MlPjN5LKCg3w=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 15:58:54 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4608.019; Thu, 21 Oct 2021
 15:58:54 +0000
Subject: Re: [PATCH v2] drm/amdkfd: Separate pinned BOs destruction from
 general routine
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
References: <20211015065447.2025572-1-lang.yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <b6f447b7-f615-28c2-d584-42e0be7397bd@amd.com>
Date: Thu, 21 Oct 2021 11:58:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211015065447.2025572-1-lang.yu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::12) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT1PR01CA0103.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.15 via Frontend Transport; Thu, 21 Oct 2021 15:58:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3d275e7-88a2-4eb9-5e34-08d994abaeb0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3737:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3737AC1064B6A64A21E00A8992BF9@DM6PR12MB3737.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgv1SQ8N8Av6c+Zry9+9xBP6PCZcnm95N4fVyQap83uX8xfpM/XXCCHzmzVZTun8jugal0D0px92V8Wy2FAYlciUDr+TPjNI6LVCtEKu4Po8c5fEwmV+bJwL4dzL+GQ/fboeUImBV/rhgKbPdw6OIb2lo51AxW2NhoJx7YZop+jmW1t/g6Xzz0jb9dnvlRr7wfvrQfDsMrjnoM1PX+ZzprjA7DtYVs+dQzelsEFrAQs7ID7X08uObs4IHK73t4rfPvPnwofnhWm1ZJw+TasnlLN5VHKwNl3wnSTj8po95M2SDbPtisLBlXVOKm1oIl02L6g55imqpJ2CE3ej7EI5+jbPPPkZyM7NwhVFVHiBKqPYYQwEhBJ7UYjuxpJlURL7nqQ6r2Ho2lTBZyCB97p3MZoAsGLX5In/RxgxhuhtHJa3lnM9iSO0xli8lSEqJWJ9el5pJN3xB/2YSmtWA441u3EMih68F+2po0e8y0UVV80hy/5WQ2vmzD5/IiiDmgEoL7rf6mCZOL2lCgF/KnLuNwoL1ZKJAvxG23EGbHILJJtXOlDZtdsm0yoJM6o/BZ9VTKrvHZs+Bi/itveWmSQbqv+vpY0rhi1QZrj+lpV3q8xM7GlO4tzRee+e//CE3MBj8s3+to5IDUoyUqLdetSDRsePv2Cf5H843KlqgC7gYKWwFILOPwJ9baTXTtWRkw7yOU8IklTcIAfbNX37R38dxG+qcpTkyiwIinr+lnSABFWLUOOITTB8waxbyRZwEBpF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(8676002)(8936002)(4001150100001)(5660300002)(38100700002)(31686004)(54906003)(4326008)(44832011)(16576012)(2616005)(26005)(956004)(83380400001)(30864003)(66556008)(66476007)(66946007)(6486002)(316002)(36756003)(186003)(508600001)(2906002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUExdjNJTVVHSGtjdExUZHhrZUFqa3FBTHRWK0Zsa1FQN1AyT1ZVeFZNU1g4?=
 =?utf-8?B?YWNTVFlSU2ZYUHlLL3ZnT3NQU0tnV3RkQXRkRmZTcVg5WE1xYjhkUDFJM2JS?=
 =?utf-8?B?SnpRZjZDeUdvMUdKc2hZMHpZY2ZicEEzNENFbDRzQk91WUxkVnBYcVd2TnF5?=
 =?utf-8?B?aHpSUllISThsWWRKeFlpUXlkYzcybHE2dFM0YTJzbDI2RW9LbHRxVzc1eE0r?=
 =?utf-8?B?MkZ2Mk0xdDlnZGJFUExDOFhjaDlPOWhkYkdWMVg3UEhMVG95RWM3eGd4ZFhE?=
 =?utf-8?B?QWQvTnVKREZDZHR4VjdkWUZFMFpWR3BUQXBjVzZrdEZ6YTBwYUhWUXVibjIr?=
 =?utf-8?B?bHppcjdhYkdlNkZLQi82di9COG8rV2w1QUpPa01IcjIxOEswUVhDM3FCaTdp?=
 =?utf-8?B?WG9CaUgreGQ5eGFCTEhkZjhHUWNBZE9DdHd3YllEQ0dQcnhpOWdXa3RQVVJy?=
 =?utf-8?B?VmpuL3ptY0I1dXZCY29yUVdoRFkwMWRlMmY3YVExRUFiaEduNGptS2p6c3da?=
 =?utf-8?B?d25pQ1IzK2drUlFReCtJRS9HRm1mMWtHVVRGR0FXKzBhc003N2pQTDMvWEgx?=
 =?utf-8?B?eUYxTlhoQXQ0bzNCZVhPVkgzZkhnUjFYaWkrcEFQZERoQkFpS0g5SFBBVXdC?=
 =?utf-8?B?M0tpaHVCQWVRNTFpanMxOTNQZmpNQ0srcnFyT1RSVEY1U1FvU1A1N0ZPdWpW?=
 =?utf-8?B?SWtrcWREM096TjZCMmZ0Zm5ya2p1ZGNSc214ZVZGemN1NHZWZXQwR1RuWlNv?=
 =?utf-8?B?ZGFMVEkyYTRtQ2ZUdFdZTU0vbnY0QjQ5ME5HcmNJbk1nTEhEMG1uZ0ZZSVFi?=
 =?utf-8?B?YStTOVdkWExIRWNaVm1HWnhjSjJZcTBTNFhTUjQ5REUvRm04L09BUjdIUUU2?=
 =?utf-8?B?MjV5Q2V6VDZKWHBqQXorZ0kzWDYyQkxUelJwU1FNakdyT3p6bTQzU2FLT21I?=
 =?utf-8?B?QkJPUGIwTW1mYWZtc3BiZXNoSzdGNkMwM3Z3TXBCWUpoVFloUnJ3eG90Z2Zv?=
 =?utf-8?B?dlIzbFlXVGhOdlk2NHd4WktjVGVYSmRrZHRyN0hwRFJJR042dFQxZmVobHIy?=
 =?utf-8?B?UGFtT2tPWGhTamR6c2dNMkl0V3k1VXJLdkczSFZCdDJsRjlNNnVBZ0FGTVJB?=
 =?utf-8?B?Wk9BdVhHWXBQZEtjMXFOM1VPL0JOSVpmK1JvSHJaaklLejRKTjk4UHpiR1hE?=
 =?utf-8?B?N014NGxjK3F3V1RVdVB0ek0yZzFMLzNKRE1KSUpYTFNjWG9qVEc1S1lHR29G?=
 =?utf-8?B?QWlDakNHd25UMXpDRTZKSGhSenA4U2pibHlEbnhXdUZVYTBjUG9qcTVUeGlk?=
 =?utf-8?B?QVpFVXNLODl2SHUvUlQyTWZ6UUNmeFkrUkdvWUNTQ0NGek0wREt2eVF3TTU3?=
 =?utf-8?B?ekNUby9SeVl3OVVid0QwNGMvN1lDbTF0Q29JRENsSUJOazFFcnZhMFpRaDJa?=
 =?utf-8?B?M2w4Q1EvT1lCNldDZFRTMHBxeE5iakpxdklQNjZRZUkzVmhKTzRURUZQY25D?=
 =?utf-8?B?Y3FtVnF4cWtWUzZvQk9nRjRoeFNhR0dGQjNjM3pXTUJwWWwyOWJuOWFOY0dY?=
 =?utf-8?B?ZVV6dDFBcHQwVVdLVUhjVFNncU00S29JQzR6OW04QXZaSjN0SnE3WWhiSDhX?=
 =?utf-8?B?SmpvQ001c1ZpSzkwYU4xeTVnTVpGT1ozL3orOW1DdG9DbXhPK1ZndnR0SDRo?=
 =?utf-8?B?ZUIzUjhQVnVPSkxkL2h6RUlva1U1c0tjRjJNeVZyNzVMUDBnYnBEa1JvVHdN?=
 =?utf-8?B?SGJjZEYrOGVRM0FXU0I5bzZOdktnS0dQbTgrdkVHZEIzNFk0Q2s5U0sram44?=
 =?utf-8?B?cDllUU9jVHFGdk1XaHB6dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d275e7-88a2-4eb9-5e34-08d994abaeb0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 15:58:54.2427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkuehlin@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
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

Am 2021-10-15 um 2:54 a.m. schrieb Lang Yu:
> Currently, all kfd BOs use same destruction routine. But pinned
> BOs are not unpinned properly. Separate them from general routine.
>
> v2 (Felix):
> Add safeguard to prevent user space from freeing signal BO.
> Kunmap signal BO in the event of setting event page error.
> Just kunmap signal BO to avoid duplicating the code.
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   2 +
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  10 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  31 +++--
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   3 +
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 110 +++++++++++++-----
>  5 files changed, 119 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 69de31754907..751557af09bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -279,6 +279,8 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
>  		struct kgd_dev *kgd, struct kgd_mem *mem, bool intr);
>  int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_dev *kgd,
>  		struct kgd_mem *mem, void **kptr, uint64_t *size);
> +void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_dev *kgd, struct kgd_mem *mem);
> +
>  int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>  					    struct dma_fence **ef);
>  int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct kgd_dev *kgd,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index cdf46bd0d8d5..4969763c2e47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1871,6 +1871,16 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_dev *kgd,
>  	return ret;
>  }
>  
> +void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_dev *kgd, struct kgd_mem *mem)
> +{
> +	struct amdgpu_bo *bo = mem->bo;
> +
> +	amdgpu_bo_reserve(bo, true);
> +	amdgpu_bo_kunmap(bo);
> +	amdgpu_bo_unpin(bo);
> +	amdgpu_bo_unreserve(bo);
> +}
> +
>  int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct kgd_dev *kgd,
>  					      struct kfd_vm_fault_info *mem)
>  {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index f1e7edeb4e6b..9317a2e238d0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1011,11 +1011,6 @@ static int kfd_ioctl_create_event(struct file *filp, struct kfd_process *p,
>  		void *mem, *kern_addr;
>  		uint64_t size;
>  
> -		if (p->signal_page) {
> -			pr_err("Event page is already set\n");
> -			return -EINVAL;
> -		}
> -
>  		kfd = kfd_device_by_id(GET_GPU_ID(args->event_page_offset));
>  		if (!kfd) {
>  			pr_err("Getting device by id failed in %s\n", __func__);
> @@ -1023,6 +1018,13 @@ static int kfd_ioctl_create_event(struct file *filp, struct kfd_process *p,
>  		}
>  
>  		mutex_lock(&p->mutex);
> +
> +		if (p->signal_page) {
> +			pr_err("Event page is already set\n");
> +			err = -EINVAL;
> +			goto out_unlock;
> +		}
> +
>  		pdd = kfd_bind_process_to_device(kfd, p);
>  		if (IS_ERR(pdd)) {
>  			err = PTR_ERR(pdd);
> @@ -1037,20 +1039,24 @@ static int kfd_ioctl_create_event(struct file *filp, struct kfd_process *p,
>  			err = -EINVAL;
>  			goto out_unlock;
>  		}
> -		mutex_unlock(&p->mutex);
>  
>  		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kfd->kgd,
>  						mem, &kern_addr, &size);
>  		if (err) {
>  			pr_err("Failed to map event page to kernel\n");
> -			return err;
> +			goto out_unlock;
>  		}
>  
>  		err = kfd_event_page_set(p, kern_addr, size);
>  		if (err) {
>  			pr_err("Failed to set event page\n");
> -			return err;
> +			amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(kfd->kgd, mem);
> +			goto out_unlock;
>  		}
> +
> +		p->signal_handle = args->event_page_offset;
> +
> +		mutex_unlock(&p->mutex);
>  	}
>  
>  	err = kfd_event_create(filp, p, args->event_type,
> @@ -1368,6 +1374,15 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
>  		return -EINVAL;
>  
>  	mutex_lock(&p->mutex);
> +	/*
> +	 * Safeguard to prevent user space from freeing signal BO.
> +	 * It will be freed at process termination.
> +	 */
> +	if (p->signal_handle && (p->signal_handle == args->handle)) {
> +		pr_err("Free signal BO is not allowed\n");
> +		ret = -EPERM;
> +		goto err_unlock;
> +	}
>  
>  	pdd = kfd_get_process_device_data(dev, p);
>  	if (!pdd) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 6d8f9bb2d905..30f08f1606bb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -608,12 +608,14 @@ struct qcm_process_device {
>  	uint32_t sh_hidden_private_base;
>  
>  	/* CWSR memory */
> +	struct kgd_mem *cwsr_mem;
>  	void *cwsr_kaddr;
>  	uint64_t cwsr_base;
>  	uint64_t tba_addr;
>  	uint64_t tma_addr;
>  
>  	/* IB memory */
> +	struct kgd_mem *ib_mem;
>  	uint64_t ib_base;
>  	void *ib_kaddr;
>  
> @@ -808,6 +810,7 @@ struct kfd_process {
>  	/* Event ID allocator and lookup */
>  	struct idr event_idr;
>  	/* Event page */
> +	u64 signal_handle;
>  	struct kfd_signal_page *signal_page;
>  	size_t signal_mapped_size;
>  	size_t signal_event_count;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 21ec8a18cad2..26fc716a92c2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -72,6 +72,8 @@ static int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep);
>  static void evict_process_worker(struct work_struct *work);
>  static void restore_process_worker(struct work_struct *work);
>  
> +static void kfd_process_device_destroy_cwsr_dgpu(struct kfd_process_device *pdd);
> +
>  struct kfd_procfs_tree {
>  	struct kobject *kobj;
>  };
> @@ -685,10 +687,15 @@ void kfd_process_destroy_wq(void)
>  }
>  
>  static void kfd_process_free_gpuvm(struct kgd_mem *mem,
> -			struct kfd_process_device *pdd)
> +			struct kfd_process_device *pdd, void *kptr)
>  {
>  	struct kfd_dev *dev = pdd->dev;
>  
> +	if (kptr) {
> +		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(dev->kgd, mem);
> +		kptr = NULL;
> +	}
> +
>  	amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(dev->kgd, mem, pdd->drm_priv);
>  	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, mem, pdd->drm_priv,
>  					       NULL);
> @@ -702,63 +709,46 @@ static void kfd_process_free_gpuvm(struct kgd_mem *mem,
>   */
>  static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
>  				   uint64_t gpu_va, uint32_t size,
> -				   uint32_t flags, void **kptr)
> +				   uint32_t flags, struct kgd_mem **mem, void **kptr)
>  {
>  	struct kfd_dev *kdev = pdd->dev;
> -	struct kgd_mem *mem = NULL;
> -	int handle;
>  	int err;
>  
>  	err = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(kdev->kgd, gpu_va, size,
> -						 pdd->drm_priv, &mem, NULL, flags);
> +						 pdd->drm_priv, mem, NULL, flags);
>  	if (err)
>  		goto err_alloc_mem;
>  
> -	err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(kdev->kgd, mem,
> +	err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(kdev->kgd, *mem,
>  			pdd->drm_priv, NULL);
>  	if (err)
>  		goto err_map_mem;
>  
> -	err = amdgpu_amdkfd_gpuvm_sync_memory(kdev->kgd, mem, true);
> +	err = amdgpu_amdkfd_gpuvm_sync_memory(kdev->kgd, *mem, true);
>  	if (err) {
>  		pr_debug("Sync memory failed, wait interrupted by user signal\n");
>  		goto sync_memory_failed;
>  	}
>  
> -	/* Create an obj handle so kfd_process_device_remove_obj_handle
> -	 * will take care of the bo removal when the process finishes.
> -	 * We do not need to take p->mutex, because the process is just
> -	 * created and the ioctls have not had the chance to run.
> -	 */
> -	handle = kfd_process_device_create_obj_handle(pdd, mem);
> -
> -	if (handle < 0) {
> -		err = handle;
> -		goto free_gpuvm;
> -	}
> -
>  	if (kptr) {
>  		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kdev->kgd,
> -				(struct kgd_mem *)mem, kptr, NULL);
> +				(struct kgd_mem *)*mem, kptr, NULL);
>  		if (err) {
>  			pr_debug("Map GTT BO to kernel failed\n");
> -			goto free_obj_handle;
> +			goto sync_memory_failed;
>  		}
>  	}
>  
>  	return err;
>  
> -free_obj_handle:
> -	kfd_process_device_remove_obj_handle(pdd, handle);
> -free_gpuvm:
>  sync_memory_failed:
> -	kfd_process_free_gpuvm(mem, pdd);
> -	return err;
> +	amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(kdev->kgd, *mem, pdd->drm_priv);
>  
>  err_map_mem:
> -	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->kgd, mem, pdd->drm_priv,
> +	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->kgd, *mem, pdd->drm_priv,
>  					       NULL);
>  err_alloc_mem:
> +	*mem = NULL;
>  	*kptr = NULL;
>  	return err;
>  }
> @@ -776,6 +766,7 @@ static int kfd_process_device_reserve_ib_mem(struct kfd_process_device *pdd)
>  			KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE |
>  			KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE |
>  			KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
> +	struct kgd_mem *mem;
>  	void *kaddr;
>  	int ret;
>  
> @@ -784,15 +775,26 @@ static int kfd_process_device_reserve_ib_mem(struct kfd_process_device *pdd)
>  
>  	/* ib_base is only set for dGPU */
>  	ret = kfd_process_alloc_gpuvm(pdd, qpd->ib_base, PAGE_SIZE, flags,
> -				      &kaddr);
> +				      &mem, &kaddr);
>  	if (ret)
>  		return ret;
>  
> +	qpd->ib_mem = mem;
>  	qpd->ib_kaddr = kaddr;
>  
>  	return 0;
>  }
>  
> +static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
> +{
> +	struct qcm_process_device *qpd = &pdd->qpd;
> +
> +	if (!qpd->ib_kaddr || !qpd->ib_base)
> +		return;
> +
> +	kfd_process_free_gpuvm(qpd->ib_mem, pdd, qpd->ib_kaddr);
> +}
> +
>  struct kfd_process *kfd_create_process(struct file *filep)
>  {
>  	struct kfd_process *process;
> @@ -947,6 +949,38 @@ static void kfd_process_device_free_bos(struct kfd_process_device *pdd)
>  	}
>  }
>  
> +/*
> + * Just kunmap and unpin signal BO here. It will be freed in
> + * kfd_process_free_outstanding_kfd_bos()
> + */
> +static void kfd_process_kunmap_signal_bo(struct kfd_process *p)
> +{
> +	struct kfd_process_device *pdd;
> +	struct kfd_dev *kdev;
> +	void *mem;
> +	int i;
> +
> +	kdev = kfd_device_by_id(GET_GPU_ID(p->signal_handle));
> +	if (!kdev)
> +		return;
> +
> +	mutex_lock(&p->mutex);
> +
> +	pdd = kfd_get_process_device_data(kdev, p);
> +	if (!pdd)
> +		goto out;
> +
> +	mem = kfd_process_device_translate_handle(
> +		pdd, GET_IDR_HANDLE(p->signal_handle));
> +	if (!mem)
> +		goto out;
> +
> +	amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(kdev->kgd, mem);
> +
> +out:
> +	mutex_unlock(&p->mutex);
> +}
> +
>  static void kfd_process_free_outstanding_kfd_bos(struct kfd_process *p)
>  {
>  	int i;
> @@ -965,6 +999,9 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>  		pr_debug("Releasing pdd (topology id %d) for process (pasid 0x%x)\n",
>  				pdd->dev->id, p->pasid);
>  
> +		kfd_process_device_destroy_cwsr_dgpu(pdd);
> +		kfd_process_device_destroy_ib_mem(pdd);
> +
>  		if (pdd->drm_file) {
>  			amdgpu_amdkfd_gpuvm_release_process_vm(
>  					pdd->dev->kgd, pdd->drm_priv);
> @@ -1049,9 +1086,11 @@ static void kfd_process_wq_release(struct work_struct *work)
>  {
>  	struct kfd_process *p = container_of(work, struct kfd_process,
>  					     release_work);
> +
>  	kfd_process_remove_sysfs(p);
>  	kfd_iommu_unbind_process(p);
>  
> +	kfd_process_kunmap_signal_bo(p);
>  	kfd_process_free_outstanding_kfd_bos(p);
>  	svm_range_list_fini(p);
>  
> @@ -1198,6 +1237,7 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>  	uint32_t flags = KFD_IOC_ALLOC_MEM_FLAGS_GTT
>  			| KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE
>  			| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
> +	struct kgd_mem *mem;
>  	void *kaddr;
>  	int ret;
>  
> @@ -1206,10 +1246,11 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>  
>  	/* cwsr_base is only set for dGPU */
>  	ret = kfd_process_alloc_gpuvm(pdd, qpd->cwsr_base,
> -				      KFD_CWSR_TBA_TMA_SIZE, flags, &kaddr);
> +				      KFD_CWSR_TBA_TMA_SIZE, flags, &mem, &kaddr);
>  	if (ret)
>  		return ret;
>  
> +	qpd->cwsr_mem = mem;
>  	qpd->cwsr_kaddr = kaddr;
>  	qpd->tba_addr = qpd->cwsr_base;
>  
> @@ -1222,6 +1263,17 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>  	return 0;
>  }
>  
> +static void kfd_process_device_destroy_cwsr_dgpu(struct kfd_process_device *pdd)
> +{
> +	struct kfd_dev *dev = pdd->dev;
> +	struct qcm_process_device *qpd = &pdd->qpd;
> +
> +	if (!dev->cwsr_enabled || !qpd->cwsr_kaddr || !qpd->cwsr_base)
> +		return;
> +
> +	kfd_process_free_gpuvm(qpd->cwsr_mem, pdd, qpd->cwsr_kaddr);
> +}
> +
>  void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
>  				  uint64_t tba_addr,
>  				  uint64_t tma_addr)
