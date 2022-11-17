Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C272CC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 22:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D8A510E6BA;
	Thu, 17 Nov 2022 22:48:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B55C10E6B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 22:48:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuxfEAzEfmKZwWs2tu3qCyBWfw5/S8mwmx3mxHc3pe8qFdFXOOab2amcr2L921MutYUHOMI3/6fcaDo3VVCmjaf2L0R1kPxWVAWjE7D3MjKzn67o+1HCFoxeN4jdgg2VQL0knZowNoneQ/q8tewUU0teVS4RMg0tUZj4IEObUQlWJ8hrvu4ofhthNzGCNdM2LgKfW0Qf0Pxny+7ySSuAif8H4lxeeCM4ZUDGWFRYTCDai3t6Eig/0epTha7VQHMdGmG5eV2DLcohpdPSqynM2Y9A17asVV1bmplwkXaCdmsblzcXiol1n3BwtJrOj0AIlrixZKc116hWnSEKmgvXHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YrgJDoNYDGQSvHrLiD9QBhwwhHbwLrzp0nd6sUG9y0=;
 b=gvNi7o7vVqoR/QGMu2trNZrvd9otsCsSxdi2KG055IeqMCPnaqBCg9Pe5nBaSt+DWzgV7iaIaHIRrnFTZXY0RICZ8UD9gqtuCQdgV6sFnpWQdzOz8Xl6l87N4gNf/tn7GM8j70E8fjDx+memEUsWdNxtbPAROfNRlediuZiwPlh1sYBoFSuXn0PooO2RvDXPOnMPEwTS9G6SH8ffgg54y85M4X+qCogxnhbEMmFVSU0YZlp2KmfIhFwuuLeh3wN8lxYEVRstIzLwbTg5XqzmYrE8/1OAkTg42cnM2NMnHhjIWrEtAfBoWcia67+cw7Q0hr5eB4kx4o41jdZX9bR1GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YrgJDoNYDGQSvHrLiD9QBhwwhHbwLrzp0nd6sUG9y0=;
 b=z2Scvg7V1jFlPFYz/3RIiB4ve4UxEAk9rcXCJ6iaxtiQY+SGDKAx6jr2NaLiNKTtAvtjDktPhIXJFpZlvychON0lP0A8A4i3nDnI/n9zG+pyRIvF9+28Di0RyxQ/5i6zN4wIS6rjUZUvZ4nDNO2/lfP244xdY4OaZEULGSb2xM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 22:48:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 22:48:39 +0000
Message-ID: <18c5e712-e670-0585-4e33-259e5ada90ff@amd.com>
Date: Thu, 17 Nov 2022 17:48:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: Add notifier lock for KFD userptrs
Content-Language: en-US
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20221103020028.832664-1-Felix.Kuehling@amd.com>
 <DM6PR12MB26029BD9044505B23BA1D088E3069@DM6PR12MB2602.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <DM6PR12MB26029BD9044505B23BA1D088E3069@DM6PR12MB2602.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 03cf5a5b-75cf-4cc4-0e33-08dac8edddad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFZfZRxOnQmBpCA598CiwM49Cy8Ruk7Ffi7Tn5Ha0vuq+rvCs8B7cIY3d0tSepQ2M4JxkJvjf/yvdBPyGhPMlpJUMpyLoz0DrjHBkm+/9xhhRcD+1C8hRN0TFIrQNS2bhLtXuV6ve56TBRlAeLFK2TVov67Ob02nl2/fDLEt894u+yvb1zE21BLvK/tFJrWyiju3Smr3fYcATQJCznF5AFLwftqI/EgE71COqE5luSRV2IUE0QGgWe8zpLjtt0EkVE94alqO/3RxnNRJnbJSWnaEzuEdSCzDTbhsOS2KD3Y5IHVCNiRbe6WKCTWjxMTeukD4LVErXTIxkPZd+qs9lE/LEJj8cBxRNLCe4E+hEobtAA7sbNczEmD1SBiArmLR5DVg0E04kb9JJBWsfw47vsLw9wHhVB2GVRUgfHNagBHEoSb/n0tHlnjQdIYpOR+6EYk+lVb5arwlAiY73EcLeyCTI5nB23cjRcskvsz1ERv0R4FfZ9jj5Q3otnuZ90KwftdFWAqF09HOs2dgp7f1/p5h1sGoczCJZDjX6DEyOMvinf0R9nQZ7fkWhnXHpjZYj8vN3mFM802wuVcWrnm4Cy/rieTWsVnt0ZscQ600KrDnOTyiNyg9htEqltJHqQQbVKXwUBLV9chS14wNtsh877rvMXN0BrgrF6+V+RkM519ijaGZjZF9xZYNRDcPmmLD9kG8I0p1jfT19KcdG5OFIVW9/FwoB1YEnira28Z1byjS3D4HwSJLp3D5OIjAYE/l
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199015)(31686004)(38100700002)(478600001)(83380400001)(86362001)(31696002)(53546011)(44832011)(30864003)(6486002)(2906002)(36756003)(6666004)(4001150100001)(8676002)(6506007)(5660300002)(66946007)(186003)(316002)(66476007)(26005)(8936002)(6512007)(2616005)(41300700001)(110136005)(66556008)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmJxTmt6d05JakFEdUIyc0lSK2EzQVFDanlDcHowM1RRdVV3UnpNYkJxOTlr?=
 =?utf-8?B?MXFhRG1uVExFbzVrQnpoOUxoVndrT043Y2NWSzNGcXk1dzllZGJlK0JmV1hq?=
 =?utf-8?B?azc4cUJrT0JEb3RralNPU1FPVlZjakRsNS80T1N0VkUvcDJYN0xkTUgxeW05?=
 =?utf-8?B?aDJVZnh0WlB2Y3dtNkttZzlteThydEdZRlBBOCtQck5RVEF2M20ycHBlWGsx?=
 =?utf-8?B?SStacEVleG1VbVovVGVjSTVNWGUyOVVqbHVSWUVBTHd5eFdYKzVPR3g4R3oz?=
 =?utf-8?B?WGxjODY5NWhSS1R4VmFJNlVIMHhXWk8ra1lBa1U0cXhCdlkzYmhmbjVycCtO?=
 =?utf-8?B?ZHRjYUVzNnkyWFJsV1RsWUhNdC9KeHg1bkYrRGdIRld3b0l2SHcxRmNNbUo1?=
 =?utf-8?B?bUxocm1rS2EvWWthL01hampCV00yWWd4VFlSSjlzalduVk93WFRTS2FIUVFJ?=
 =?utf-8?B?UFlNS3ZsUmRXRkdZd0pyUU5kM1pHY0JPWmxjQ1Jnc1RJOWd6R3N6dHpIQUhR?=
 =?utf-8?B?TVZKTVZNRGxralZlaUxwd1A2ZjZvTE8xQ2xuSGtXbnpnSjNsYjJhTjNDb1JX?=
 =?utf-8?B?aUxadUdNRVR3NWN0eU4xZTlNcVpuMi94MGt6UWJVMnpzZHYxY04yMHduRnJH?=
 =?utf-8?B?dGVuK1ZHYXNGNVFyVVd2am9oYXdPd2oyRFFTWnJlUDhPMkhWbEpiRHUxMmQ1?=
 =?utf-8?B?bjBhTzBpUjM1cTcvZlA4eWR5emxiQzdlUHBKeHgyUmtEamFHK20xNVJTUFhD?=
 =?utf-8?B?bktjMDVFVDJJRm56SXJGeC9ha2ZFMFhpVEtkbjdhajNWbXJ2eDRvUHU0MzM0?=
 =?utf-8?B?am5XZ0MzWVhVNUNqbmNWQ1BWYTFmdWc3Z3FQL2ZOMVo4bHFrWGFmV3VmWDh1?=
 =?utf-8?B?KzVhSGRXaWlXeTBrenE0ck5YZUFNQmF4ZnZDaU5qUHYvNjhFY1BrOHFoTHRE?=
 =?utf-8?B?RlVOS1FYUzhCRSszUnRNT3BEbFdQSGMxN2dQVEdMaFhCcVBhZTY3NWVnWHR6?=
 =?utf-8?B?dWtzUFJjVm80blE1eFprSjg1TkFRYTM1L1pRNHQ4LzFQT1JrR1UwNkZ3Sndj?=
 =?utf-8?B?SmVvRE1HcnB0MnJqcTBQUUQrUDdlMzd0cjJsNTNTR1ZsZkVlS094UUh4dnF2?=
 =?utf-8?B?NzFwaXF0Y3RsbzJCZXV2aWwyOW9HKzZFc3YxV3pINlhsSGY5NGV3Mk91TWND?=
 =?utf-8?B?QU8zOVk3ZjJreHBYUmxOZmtHbU1zL1NGczFLT0dpNlhZdWJXc1VpTzhZdDl5?=
 =?utf-8?B?bzFrckpHamVOWmNLVnJzOTRCUVIrREZZZVRkNjlqczl5dzJvaHVBUFlRdWNs?=
 =?utf-8?B?VjJSSGNwTllmczREQXQ0MEJGRkZZaldRV0hhMWVGNURmRFJWTlNpc09BY1RY?=
 =?utf-8?B?MlA2cGM2bnVURGJSL3VIY1E1cUlFbEFOQTl0S3ByQlVMRnZSSEtxNFpZRnhW?=
 =?utf-8?B?RDg1bmxuM2FxRUhVQmU0QVZxNnpCbUMxWU94aWNCNTFQb3M0NWpzWGh1K1hz?=
 =?utf-8?B?V21XeXdtVlhZTThOL3VKNmN5aXJUdHE5TlU3YU80ci9uZnFDNWF1Q0VLTnlD?=
 =?utf-8?B?OElmT1AyWTNBYW5QWURLQ3p3M2NGa2hWTVFSUklaaW5DSDNwU2lWU2E3MzFp?=
 =?utf-8?B?bnhJTWRVRStjRkxKVHJkWDhweEs5MWd4SDNFMWhVRnpnOHRLU3ZZWDF2TjNM?=
 =?utf-8?B?R21rQUoveWtWeDVEemJxZmlhSGNZSXprd1JwSHpyR3hsQ2RNSFczK3daUFpo?=
 =?utf-8?B?UDI2YzY4eVJ1QXFDVWRzSGxkSVhPOVBpc0ViS1lrbWpjckplYmhrREdINlJk?=
 =?utf-8?B?RkloS2owaUpPYmU1TWhidW96cWFnMFFERkg0aWpmcHQvclBDVXNWZnFya0lF?=
 =?utf-8?B?THNWOEtmZnV0QkUzcm45RG1mN0Nid1p3dTFEc3duWTYvbFRXWEZrNU9IR0kx?=
 =?utf-8?B?UDY4K3ZIdVU1eXNKUXRRRFJ1ZXk1dXdtTU9VUEtlY016UFpzMnN3czMzM3Za?=
 =?utf-8?B?VXh4Ry9DRElERE9TcVk0WnNGTlYwd2ZCcVhQSlppZzR5MUtSY0dSOTZUVHpM?=
 =?utf-8?B?VFI3ZnlsaFJNQXcvVFk0aW9HNlBKR3JNUEZJK0FVY2Nvc21PeVNnZExoSk4w?=
 =?utf-8?Q?4aDDZqYZoudEU73DNHHSTOYOC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cf5a5b-75cf-4cc4-0e33-08dac8edddad
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 22:48:39.4886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gBULOVFUkIX11PjLHn9mGPRsWuSl3w9cvpVXHbwQlfNV6SoeDndHsiXUEZHZp25xGSQg6ViM5ZeyP/gORTI7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
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


Am 2022-11-17 um 17:30 schrieb Chen, Xiaogang:
> [AMD Official Use Only - General]
>
> This patch is:
> Reviewed-by: Xiaogang Chen<Xiaogang.Chen@amd.com>

Thanks, I'll need to rebase this on Christian's latest userptr patch. 
I'll send out an updated patch later.

Regards,
   Felix


>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix Kuehling
> Sent: Wednesday, November 2, 2022 9:00 PM
> To: amd-gfx@lists.freedesktop.org
> Subject: [PATCH] drm/amdgpu: Add notifier lock for KFD userptrs
>
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Add a per-process MMU notifier lock for processing notifiers from userptrs. Use that lock to properly synchronize page table updates with MMU notifiers.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  12 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 202 +++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c        |  12 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h        |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  18 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   4 +
>   6 files changed, 158 insertions(+), 93 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index f50e3ba4d7a5..1ca18a77818b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -29,6 +29,7 @@
>   #include <linux/mm.h>
>   #include <linux/kthread.h>
>   #include <linux/workqueue.h>
> +#include <linux/mmu_notifier.h>
>   #include <kgd_kfd_interface.h>
>   #include <drm/ttm/ttm_execbuf_util.h>
>   #include "amdgpu_sync.h"
> @@ -75,7 +76,7 @@ struct kgd_mem {
>
>          uint32_t alloc_flags;
>
> -       atomic_t invalid;
> +       uint32_t invalid;
>          struct amdkfd_process_info *process_info;
>
>          struct amdgpu_sync sync;
> @@ -131,7 +132,8 @@ struct amdkfd_process_info {
>          struct amdgpu_amdkfd_fence *eviction_fence;
>
>          /* MMU-notifier related fields */
> -       atomic_t evicted_bos;
> +       struct mutex notifier_lock;
> +       uint32_t evicted_bos;
>          struct delayed_work restore_userptr_work;
>          struct pid *pid;
>          bool block_mmu_notifications;
> @@ -180,7 +182,8 @@ int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void *data);  bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm);  struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f);  int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo); -int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem, struct mm_struct *mm);
> +int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
> +                               unsigned long cur_seq, struct kgd_mem
> +*mem);
>   #else
>   static inline
>   bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm) @@ -201,7 +204,8 @@ int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo)  }
>
>   static inline
> -int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem, struct mm_struct *mm)
> +int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
> +                               unsigned long cur_seq, struct kgd_mem
> +*mem)
>   {
>          return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 955fa8c8213b..5510b7c42ac7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -964,7 +964,9 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>                   * later stage when it is scheduled by another ioctl called by
>                   * CRIU master process for the target pid for restore.
>                   */
> -               atomic_inc(&mem->invalid);
> +               mutex_lock(&process_info->notifier_lock);
> +               mem->invalid++;
> +               mutex_unlock(&process_info->notifier_lock);
>                  mutex_unlock(&process_info->lock);
>                  return 0;
>          }
> @@ -1301,6 +1303,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>                          return -ENOMEM;
>
>                  mutex_init(&info->lock);
> +               mutex_init(&info->notifier_lock);
>                  INIT_LIST_HEAD(&info->vm_list_head);
>                  INIT_LIST_HEAD(&info->kfd_bo_list);
>                  INIT_LIST_HEAD(&info->userptr_valid_list);
> @@ -1317,7 +1320,6 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>                  }
>
>                  info->pid = get_task_pid(current->group_leader, PIDTYPE_PID);
> -               atomic_set(&info->evicted_bos, 0);
>                  INIT_DELAYED_WORK(&info->restore_userptr_work,
>                                    amdgpu_amdkfd_restore_userptr_worker);
>
> @@ -1372,6 +1374,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>                  put_pid(info->pid);
>   create_evict_fence_fail:
>                  mutex_destroy(&info->lock);
> +               mutex_destroy(&info->notifier_lock);
>                  kfree(info);
>          }
>          return ret;
> @@ -1496,6 +1499,7 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>                  cancel_delayed_work_sync(&process_info->restore_userptr_work);
>                  put_pid(process_info->pid);
>                  mutex_destroy(&process_info->lock);
> +               mutex_destroy(&process_info->notifier_lock);
>                  kfree(process_info);
>          }
>   }
> @@ -1548,7 +1552,9 @@ int amdgpu_amdkfd_criu_resume(void *p)
>
>          mutex_lock(&pinfo->lock);
>          pr_debug("scheduling work\n");
> -       atomic_inc(&pinfo->evicted_bos);
> +       mutex_lock(&pinfo->notifier_lock);
> +       pinfo->evicted_bos++;
> +       mutex_unlock(&pinfo->notifier_lock);
>          if (!READ_ONCE(pinfo->block_mmu_notifications)) {
>                  ret = -EINVAL;
>                  goto out_unlock;
> @@ -1773,8 +1779,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>          list_del(&bo_list_entry->head);
>          mutex_unlock(&process_info->lock);
>
> -       /* No more MMU notifiers */
> -       amdgpu_mn_unregister(mem->bo);
> +       /* Cleanup user pages and MMU notifiers */
> +       if (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm)) {
> +               amdgpu_mn_unregister(mem->bo);
> +               mutex_lock(&process_info->notifier_lock);
> +               amdgpu_ttm_tt_discard_user_pages(mem->bo->tbo.ttm);
> +               mutex_unlock(&process_info->notifier_lock);
> +       }
>
>          ret = reserve_bo_and_cond_vms(mem, NULL, BO_VM_ALL, &ctx);
>          if (unlikely(ret))
> @@ -1864,14 +1875,14 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>           */
>          mutex_lock(&mem->process_info->lock);
>
> -       /* Lock mmap-sem. If we find an invalid userptr BO, we can be
> +       /* Lock notifier lock. If we find an invalid userptr BO, we can
> + be
>           * sure that the MMU notifier is no longer running
>           * concurrently and the queues are actually stopped
>           */
>          if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm)) {
> -               mmap_write_lock(current->mm);
> -               is_invalid_userptr = atomic_read(&mem->invalid);
> -               mmap_write_unlock(current->mm);
> +               mutex_lock(&mem->process_info->notifier_lock);
> +               is_invalid_userptr = !!mem->invalid;
> +               mutex_unlock(&mem->process_info->notifier_lock);
>          }
>
>          mutex_lock(&mem->lock);
> @@ -2251,34 +2262,38 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
>    *
>    * Runs in MMU notifier, may be in RECLAIM_FS context. This means it
>    * cannot do any memory allocations, and cannot take any locks that
> - * are held elsewhere while allocating memory. Therefore this is as
> - * simple as possible, using atomic counters.
> + * are held elsewhere while allocating memory.
>    *
>    * It doesn't do anything to the BO itself. The real work happens in
>    * restore, where we get updated page addresses. This function only
>    * ensures that GPU access to the BO is stopped.
>    */
> -int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem,
> -                               struct mm_struct *mm)
> +int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
> +                               unsigned long cur_seq, struct kgd_mem
> +*mem)
>   {
>          struct amdkfd_process_info *process_info = mem->process_info;
> -       int evicted_bos;
>          int r = 0;
>
> -       /* Do not process MMU notifications until stage-4 IOCTL is received */
> +       /* Do not process MMU notifications during CRIU restore until
> +        * KFD_CRIU_OP_RESUME IOCTL is received
> +        */
>          if (READ_ONCE(process_info->block_mmu_notifications))
>                  return 0;
>
> -       atomic_inc(&mem->invalid);
> -       evicted_bos = atomic_inc_return(&process_info->evicted_bos);
> -       if (evicted_bos == 1) {
> +       mutex_lock(&process_info->notifier_lock);
> +       mmu_interval_set_seq(mni, cur_seq);
> +
> +       mem->invalid++;
> +       if (++process_info->evicted_bos == 1) {
>                  /* First eviction, stop the queues */
> -               r = kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
> +               r = kgd2kfd_quiesce_mm(mni->mm,
> +
> + KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
>                  if (r)
>                          pr_err("Failed to quiesce KFD\n");
>                  schedule_delayed_work(&process_info->restore_userptr_work,
>                          msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>          }
> +       mutex_unlock(&process_info->notifier_lock);
>
>          return r;
>   }
> @@ -2295,49 +2310,54 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>          struct kgd_mem *mem, *tmp_mem;
>          struct amdgpu_bo *bo;
>          struct ttm_operation_ctx ctx = { false, false };
> -       int invalid, ret;
> +       uint32_t invalid;
> +       int ret = 0;
>
> -       /* Move all invalidated BOs to the userptr_inval_list and
> -        * release their user pages by migration to the CPU domain
> -        */
> +       mutex_lock(&process_info->notifier_lock);
> +
> +       /* Move all invalidated BOs to the userptr_inval_list */
>          list_for_each_entry_safe(mem, tmp_mem,
>                                   &process_info->userptr_valid_list,
> -                                validate_list.head) {
> -               if (!atomic_read(&mem->invalid))
> -                       continue; /* BO is still valid */
> -
> -               bo = mem->bo;
> -
> -               if (amdgpu_bo_reserve(bo, true))
> -                       return -EAGAIN;
> -               amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
> -               ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -               amdgpu_bo_unreserve(bo);
> -               if (ret) {
> -                       pr_err("%s: Failed to invalidate userptr BO\n",
> -                              __func__);
> -                       return -EAGAIN;
> -               }
> -
> -               list_move_tail(&mem->validate_list.head,
> -                              &process_info->userptr_inval_list);
> -       }
> -
> -       if (list_empty(&process_info->userptr_inval_list))
> -               return 0; /* All evicted userptr BOs were freed */
> +                                validate_list.head)
> +               if (mem->invalid)
> +                       list_move_tail(&mem->validate_list.head,
> +
> + &process_info->userptr_inval_list);
>
>          /* Go through userptr_inval_list and update any invalid user_pages */
>          list_for_each_entry(mem, &process_info->userptr_inval_list,
>                              validate_list.head) {
> -               invalid = atomic_read(&mem->invalid);
> +               invalid = mem->invalid;
>                  if (!invalid)
>                          /* BO hasn't been invalidated since the last
> -                        * revalidation attempt. Keep its BO list.
> +                        * revalidation attempt. Keep its page list.
>                           */
>                          continue;
>
>                  bo = mem->bo;
>
> +               amdgpu_ttm_tt_discard_user_pages(bo->tbo.ttm);
> +
> +               /* BO reservations and getting user pages (hmm_range_fault)
> +                * must happen outside the notifier lock
> +                */
> +               mutex_unlock(&process_info->notifier_lock);
> +
> +               /* Move the BO to system (CPU) domain if necessary to unmap
> +                * and free the SG table
> +                */
> +               if (bo->tbo.resource->mem_type != TTM_PL_SYSTEM) {
> +                       if (amdgpu_bo_reserve(bo, true))
> +                               return -EAGAIN;
> +                       amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
> +                       ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +                       amdgpu_bo_unreserve(bo);
> +                       if (ret) {
> +                               pr_err("%s: Failed to invalidate userptr BO\n",
> +                                      __func__);
> +                               return -EAGAIN;
> +                       }
> +               }
> +
>                  /* Get updated user pages */
>                  ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages);
>                  if (ret) {
> @@ -2352,30 +2372,31 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>                           */
>                          if (ret != -EFAULT)
>                                  return ret;
> -               } else {
> -
> -                       /*
> -                        * FIXME: Cannot ignore the return code, must hold
> -                        * notifier_lock
> -                        */
> -                       amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
> +                       ret = 0;
>                  }
>
> +               mutex_lock(&process_info->notifier_lock);
> +
>                  /* Mark the BO as valid unless it was invalidated
>                   * again concurrently.
>                   */
> -               if (atomic_cmpxchg(&mem->invalid, invalid, 0) != invalid)
> -                       return -EAGAIN;
> +               if (mem->invalid != invalid) {
> +                       ret = -EAGAIN;
> +                       goto unlock_out;
> +               }
> +               mem->invalid = 0;
>          }
>
> -       return 0;
> +unlock_out:
> +       mutex_unlock(&process_info->notifier_lock);
> +
> +       return ret;
>   }
>
>   /* Validate invalid userptr BOs
>    *
> - * Validates BOs on the userptr_inval_list, and moves them back to the
> - * userptr_valid_list. Also updates GPUVM page tables with new page
> - * addresses and waits for the page table updates to complete.
> + * Validates BOs on the userptr_inval_list. Also updates GPUVM page
> + tables
> + * with new page addresses and waits for the page table updates to complete.
>    */
>   static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)  { @@ -2446,9 +2467,6 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
>                          }
>                  }
>
> -               list_move_tail(&mem->validate_list.head,
> -                              &process_info->userptr_valid_list);
> -
>                  /* Update mapping. If the BO was not validated
>                   * (because we couldn't get user pages), this will
>                   * clear the page table entries, which will result in @@ -2464,7 +2482,9 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
>                          if (ret) {
>                                  pr_err("%s: update PTE failed\n", __func__);
>                                  /* make sure this gets validated again */
> -                               atomic_inc(&mem->invalid);
> +                               mutex_lock(&process_info->notifier_lock);
> +                               mem->invalid++;
> +
> + mutex_unlock(&process_info->notifier_lock);
>                                  goto unreserve_out;
>                          }
>                  }
> @@ -2484,6 +2504,32 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
>          return ret;
>   }
>
> +/* Confirm that all user pages are valid while holding the notifier
> +lock
> + *
> + * Moves valid BOs from the userptr_inval_list back to userptr_val_list.
> + */
> +static int confirm_valid_user_pages_locked(struct amdkfd_process_info
> +*process_info) {
> +       struct kgd_mem *mem, *tmp_mem;
> +       int ret = 0;
> +
> +       list_for_each_entry_safe(mem, tmp_mem,
> +                                &process_info->userptr_inval_list,
> +                                validate_list.head) {
> +               if (!amdgpu_ttm_tt_get_user_pages_done(mem->bo->tbo.ttm)) {
> +                       WARN(!mem->invalid, "Invalid BO not marked invalid");
> +                       ret = -EAGAIN;
> +                       continue;
> +               }
> +               WARN(mem->invalid, "Valid BO is marked invalid");
> +
> +               list_move_tail(&mem->validate_list.head,
> +                              &process_info->userptr_valid_list);
> +       }
> +
> +       return ret;
> +}
> +
>   /* Worker callback to restore evicted userptr BOs
>    *
>    * Tries to update and validate all userptr BOs. If successful and no @@ -2498,9 +2544,11 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>                               restore_userptr_work);
>          struct task_struct *usertask;
>          struct mm_struct *mm;
> -       int evicted_bos;
> +       uint32_t evicted_bos;
>
> -       evicted_bos = atomic_read(&process_info->evicted_bos);
> +       mutex_lock(&process_info->notifier_lock);
> +       evicted_bos = process_info->evicted_bos;
> +       mutex_unlock(&process_info->notifier_lock);
>          if (!evicted_bos)
>                  return;
>
> @@ -2523,9 +2571,6 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>           * and we can just restart the queues.
>           */
>          if (!list_empty(&process_info->userptr_inval_list)) {
> -               if (atomic_read(&process_info->evicted_bos) != evicted_bos)
> -                       goto unlock_out; /* Concurrent eviction, try again */
> -
>                  if (validate_invalid_user_pages(process_info))
>                          goto unlock_out;
>          }
> @@ -2534,10 +2579,17 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>           * be a first eviction that calls quiesce_mm. The eviction
>           * reference counting inside KFD will handle this case.
>           */
> -       if (atomic_cmpxchg(&process_info->evicted_bos, evicted_bos, 0) !=
> -           evicted_bos)
> -               goto unlock_out;
> -       evicted_bos = 0;
> +       mutex_lock(&process_info->notifier_lock);
> +       if (process_info->evicted_bos != evicted_bos)
> +               goto unlock_notifier_out;
> +
> +       if (confirm_valid_user_pages_locked(process_info)) {
> +               WARN(1, "User pages unexpectedly invalid");
> +               goto unlock_notifier_out;
> +       }
> +
> +       process_info->evicted_bos = evicted_bos = 0;
> +
>          if (kgd2kfd_resume_mm(mm)) {
>                  pr_err("%s: Failed to resume KFD\n", __func__);
>                  /* No recovery from this failure. Probably the CP is @@ -2545,6 +2597,8 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>                   */
>          }
>
> +unlock_notifier_out:
> +       mutex_unlock(&process_info->notifier_lock);
>   unlock_out:
>          mutex_unlock(&process_info->lock);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> index b86c0b8252a5..93b6a2a7d64c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> @@ -102,17 +102,11 @@ static bool amdgpu_mn_invalidate_hsa(struct mmu_interval_notifier *mni,
>                                       unsigned long cur_seq)  {
>          struct amdgpu_bo *bo = container_of(mni, struct amdgpu_bo, notifier);
> -       struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>
>          if (!mmu_notifier_range_blockable(range))
>                  return false;
>
> -       mutex_lock(&adev->notifier_lock);
> -
> -       mmu_interval_set_seq(mni, cur_seq);
> -
> -       amdgpu_amdkfd_evict_userptr(bo->kfd_bo, bo->notifier.mm);
> -       mutex_unlock(&adev->notifier_lock);
> +       amdgpu_amdkfd_evict_userptr(mni, cur_seq, bo->kfd_bo);
>
>          return true;
>   }
> @@ -231,9 +225,9 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>          return r;
>   }
>
> -int amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range)
> +bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range)
>   {
> -       int r;
> +       bool r;
>
>          r = mmu_interval_read_retry(hmm_range->notifier,
>                                      hmm_range->notifier_seq); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
> index 14a3c1864085..b37fcf99baf1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
> @@ -29,13 +29,14 @@
>   #include <linux/rwsem.h>
>   #include <linux/workqueue.h>
>   #include <linux/interval_tree.h>
> +#include <linux/mmu_notifier.h>
>
>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>                                 struct mm_struct *mm, struct page **pages,
>                                 uint64_t start, uint64_t npages,
>                                 struct hmm_range **phmm_range, bool readonly,
>                                 bool mmap_locked, void *owner); -int amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
> +bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
>
>   #if defined(CONFIG_HMM_MIRROR)
>   int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 585460ab8dfd..5f2b87dd5732 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -706,8 +706,20 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>          return r;
>   }
>
> +/* amdgpu_ttm_tt_discard_user_pages - Discard range and pfn array
> +allocations  */ void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt
> +*ttm) {
> +       struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +
> +       if (gtt && gtt->userptr && gtt->range) {
> +               amdgpu_hmm_range_get_pages_done(gtt->range);
> +               gtt->range = NULL;
> +       }
> +}
> +
>   /*
> - * amdgpu_ttm_tt_userptr_range_done - stop HMM track the CPU page table change
> + * amdgpu_ttm_tt_get_user_pages_done - stop HMM track the CPU page
> + table change
>    * Check if the pages backing this ttm range have been invalidated
>    *
>    * Returns: true if pages are still valid @@ -727,10 +739,6 @@ bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
>                  "No user pages to check\n");
>
>          if (gtt->range) {
> -               /*
> -                * FIXME: Must always hold notifier_lock for this, and must
> -                * not ignore the return code.
> -                */
>                  r = amdgpu_hmm_range_get_pages_done(gtt->range);
>                  gtt->range = NULL;
>          }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 9120ae80ef52..58b70d862437 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -158,6 +158,7 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>
>   #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages);
> +void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm);
>   bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm);  #else  static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, @@ -165,6 +166,9 @@ static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,  {
>          return -EPERM;
>   }
> +static void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm) { }
>   static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)  {
>          return false;
> --
> 2.32.0
