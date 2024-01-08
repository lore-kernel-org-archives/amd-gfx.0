Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6A1C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 06:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC5310E178;
	Mon,  8 Jan 2024 06:40:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19A6A10E178
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 06:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XApLNp7jI9rJyE6IILwOu+OR98Zq9NKr5xb2L859FmTgA/ngeFzrXylZMzLrYd3goBHCNbSKcONA0SQMnhq+naXfMFgOAamFn7ROVKtJmnaIq5vxMjnCjmxoMXh4DvYSuAp9dRUbiZL7PWTTZd9PPvX6D0EH5psABh2ya4tHDGLE4zw0r/c37duKuJLNXPHwAU5x2LaPtj6AmtLkgOukDjZGs/mT5k1TqTqQMjlO4owVfVcuZBS15JiXwuqEaCvoqgiRlvYDKlzeFhXES1g1hn8nURWK2WVnaM1nlcmDgnZc28o7u4ZW9+OX5GED5dOoeTqoIdsVcM/0Zg/WKYYPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyJ54DRW4My7WIWrczqvI79G2uZ5BBA0EWGTOPtYQg8=;
 b=ddREtpT2HRxv13LTYtoOkCUg2WCPHkEVIYAIIwYa0dgVhEmNQTy+oeWrhb8mAwkZFgv48ZI8gnHYvt6oLUgS5boJbSZkl3LMJZ5WBXFLeZ13fKBHGq/4yxX0gqJ1ujqFaR+HoFou3P4mPlpUMz0UrBkt+pPMaLSGRSQs3y+nghP5NVI+FYznAnD7uuIyXh7eAyStdrufNOJdEhO3rQf4Y9fjvfZcGUBffLTuzuqRzYEHPmtoA9qVEe6awwTR4911rry2xr/WNHATW57iu43IXPJeFmBOT9WIPFENgK6CfQNUi2NM17p8x2n8J4X1DIDqvyuQEbxHiw7Nh//stKJE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyJ54DRW4My7WIWrczqvI79G2uZ5BBA0EWGTOPtYQg8=;
 b=kkSHZ+UMe9W6KM1Dsw6/+EH4L4cKifi4lYDD5ss8s2tyLaD5wbHO0H+V9gYQ5+hCQTn5RSvkzAIVaBIhLZ7nsmyquN1av91nlgMblSzFtbGiu8DM3TRZAZ/KEaXIqTqRcEAraaQTBref/9CVsKXSISyBWPP3bFZaNJxzah9ndpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 06:40:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 06:40:30 +0000
Message-ID: <64bad53c-2bde-4277-ab41-548dca48eb05@amd.com>
Date: Mon, 8 Jan 2024 07:40:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Fix sparse __rcu annotation warnings
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240105230015.492870-1-felix.kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240105230015.492870-1-felix.kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0315.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d2a9c41-e682-4dc3-9fde-08dc1014b510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tC+FoZ3o0AxLPwc3IRQqSafQxTH/goMyKzYZpf7hbTeF+Cxzgmzh6HjhdL9W+rAtwiZ3kNrl1DrYexqJbD3V14yhOjxGVK7MdkX6/MOsXMlR+AH+FhW3wJlRsmFgvsZYsvNmBapl2IYYDE6FEZwvXQcKO7RTWT3grk9kg3G6tJd9BUPs7WLWjHGRHuJJ8d6uCCaktu+Wthw7v/LXDgMU1oghLJxCHCfXTQdknfxSHcYuDAjOLgSQBFQh9eo4kAj3797vrdq71R6BLENvW9MUdMXK8+sMF+GUcvCBhVZITyJaGN0Cp+ROP+amTCS9W/J6CRrH2bMR4uICWKmEWSmNqFitaqIPk4p+foCMrK27uVGrz22mjYY5zI2P48ICoc8q7ORNWyxB2p2H5844yYEKWfZuDOwzvg92GbebFmZKG+X0TQGLiSiZrTaMlc4qSf/AiOHMEdFx1CtrBPb6H6YeWgDyBgU65cC22RohL27kl13pzPPBJALG2hyGtush+9LzEcnMOqd2pzOxO4LALjOqoYl/oEWeAODCougGjIb2wrWXDGNgEhRnR10+nS+0wqL9s8sGHz1Z11ePx6e+gd5q8O8nfWePAMX2kyPppKh3eE4U7TXb/QYg03QmrHffANOTvlZVB1OtJ21MwZJYDJgKEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(346002)(376002)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(36756003)(8676002)(38100700002)(8936002)(316002)(66574015)(83380400001)(5660300002)(4326008)(966005)(478600001)(6506007)(6512007)(26005)(66946007)(66556008)(66476007)(6486002)(2616005)(41300700001)(2906002)(86362001)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDRFYUEzSlIvS1kxVEVVcHdUUmRNN1k4WmJMb21hb0NXeEZ2TDRkLzN6cE1p?=
 =?utf-8?B?TFFBWEVZSEluUHE5SkJBUDBSUXAxbDVVeS9jYWZxWFA5TkJzcWNDMnMwSUpo?=
 =?utf-8?B?ckQ4WnJJZ21DVlZkT0VVQVZrSVJJTGxEejF4S2RtbW1wMjA0Z3RXeHNES0M1?=
 =?utf-8?B?VXFqY2YrcUpiZTh0Z3RPZzVpQ3A2anpRQ0h1WWpIMDhyMFJzalZUWlFrS01D?=
 =?utf-8?B?T1U4VDZZMFcwMDBnc0E4eUlxYTBpdnA3Ny9CN3JoOFp5NFM4UDF6KzNjL1ZU?=
 =?utf-8?B?bEZiVW1TaTJZbk9na2ozNm8wemxEdGIxcFpWUkVCK0RCQitPNTdxbHZ0Z0Y3?=
 =?utf-8?B?Um4zNzkrdGtNRjFHTjFiUUhUY2pmaitibVNTYmxrWmFZR09DQUJaMHh1L2ZQ?=
 =?utf-8?B?UmlaMFpTOFhXblByam95d0g0cUZkWktCNGcveVM3dXFqWkF1QThZK2E4aFpl?=
 =?utf-8?B?WmV0aGhBK2VJT3RzWFg2U3EzYjFGNWxBcG54SU9wVmNEbktIWCsraTdHUVZO?=
 =?utf-8?B?bklwMERlR3RVcEtWbUxvbFRqUDdOSThKZFRkRzhmYXJQMzRneDVXWUxzSHZD?=
 =?utf-8?B?RVVjSUQ0OFdQL21TZFhUWWRBVk5yTnlaZStwR0twTXlXSFYrWWhvUWpEclFi?=
 =?utf-8?B?dzNOM3dWZERJbFR5U0s4czZIQ08rU3lZaWllL0ppeXBSOWx4Sm50cXI1b09X?=
 =?utf-8?B?czBBSGJMOHcwUWlzWEthYjB6STd1VUZDOFpNT0VmQnNNakV1Y00rYUJHbTIz?=
 =?utf-8?B?RzNEbjl2VnpWVVpiUlNnVWx0bTRhemRlb3Vha0RNdUNGbkN3L1BVTC92b0VG?=
 =?utf-8?B?TXI5NVJQMTZtWGZRc3JtMjhWaXY1VmdjSE9HREFuUFFQd3NvWkZlMHpJMWZk?=
 =?utf-8?B?NFFsc1g5eGxJN2tDU3NkMDhyN2ttWEttcUlwN1hGVGx2cEhPYzNXeVhreERM?=
 =?utf-8?B?dms4WlZRUGozLzM3Uy9oUFQzVnI0Mll5RXVUaXZ6ZHJKcm5MUFRmRUEranhk?=
 =?utf-8?B?WUN5VzZ4ci9vK051VHVlamhhUGlqTm1xaHdUTDg5dkNFRlYrUVFMakwxUTdF?=
 =?utf-8?B?d0gxYXNmRy95bXplL28yczd6L1Q0YUJHaW9FSTd5YnN1YVozTUI0dG5NTmpn?=
 =?utf-8?B?ODN4L3BIc3E3elRzMnR2TFdjcWw5KzgxN3Z6ZVdrV2VKb1YxU1JFN21HRnkr?=
 =?utf-8?B?WFd4WUdtcWw4SVgyM25CK2ZxTHM4Qmp6ZjZwaGwwVnRvRnRaOGQ1dm9ZU0RK?=
 =?utf-8?B?YTZjQlI3cGpXNEpOYmFuRzZvTXpBM0lMZlA2UkFmSlltMkVUbSs2ZTJiSHpm?=
 =?utf-8?B?VWM0a0tZdTFWLzMvZGREWFI5dVh3N1JuaHA4b2s1OUFmck1lanRzd1lUTEZy?=
 =?utf-8?B?d3FIOEVQVUNCUFd5dk9iWUFIcnVNMnFsSmdadTdIaUpkS2UyZUhyaDJlWTZO?=
 =?utf-8?B?VHJvMFNuK1pRaUE0dEl4bEVWeElUUCtKNjV6cmlVTDgxTmdEY040ZndCdHNw?=
 =?utf-8?B?bjZQKzRhMmpYOUVVUGlsbjhmZnFKRW84TjlNdDNYVmQrTXJaVURsb2IvejRC?=
 =?utf-8?B?K2c0SEJkb1pNYjVscjlPRW9pK2VheEpVcW5NUUNQbmxRUXdRSmV2RVdkTmVq?=
 =?utf-8?B?OVMyQ1RYUzRtdHpiTWREQStBUjJFdG02VWlKMFhvenJXQVZGNmxzUzNjeThH?=
 =?utf-8?B?bW1qQUFpdytOL1ZmaG44Mk9nQXNRRGgySnc5UmIrTE13Nytsamd0SlFlQmwr?=
 =?utf-8?B?RFVBSzZ1NkpRR1lhZ3gxK3hUY0VPbjlPeDY3bmM5Ym1ZalB6TTRVcmhtNitS?=
 =?utf-8?B?MURkT1pHWDNSdFJucC92TzRpdm9SMk44K1dkSjExRjh0ZmluWjk5N3VWTEJU?=
 =?utf-8?B?b09idmtWaE5CSEc5cVZFVjlZU203UnJyaTluU29QNGFwa0o1b0k2QmRMSXIv?=
 =?utf-8?B?NGszbXFJUGxRS0x1K3lUVzdDeThSWkVMYlZEUjZuS3ArVmcvaHVQMFh2NCtI?=
 =?utf-8?B?d3ozeExRSi9DckhZcFJ3cERSR3ZOYXZTaHpPUDV3QW5DVWVBNlhZSWJJQjdw?=
 =?utf-8?B?UXU5U2xXU2ppeWpBQWI5OVh3MTRWTGVGZGtTaCt6V3pqazBQeTBHbitLMUxj?=
 =?utf-8?Q?oiTgGKG4m837oZJDc2uKG3zOr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2a9c41-e682-4dc3-9fde-08dc1014b510
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 06:40:30.6040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BST29nup+9fDSCcRGzCcPBKYzJrHEV02DDTagMfRKdS2HrL86wRo0FilGEtvEihe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
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
Cc: linux-mm@kvack.org, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.01.24 um 00:00 schrieb Felix Kuehling:
> Properly mark kfd_process->ef as __rcu and consistently use the right
> accessor functions.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312052245.yFpBSgNH-lkp@intel.com/
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h            | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 7 +++++--
>   4 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index cf6ed5fce291..f262b9d89541 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -311,7 +311,7 @@ void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
>   int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo);
>   
>   int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
> -					    struct dma_fence **ef);
> +					    struct dma_fence __rcu **ef);
>   int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
>   					      struct kfd_vm_fault_info *info);
>   int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 48697b789342..5f445d856769 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2802,7 +2802,7 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>   	put_task_struct(usertask);
>   }
>   
> -static void replace_eviction_fence(struct dma_fence **ef,
> +static void replace_eviction_fence(struct dma_fence __rcu **ef,
>   				   struct dma_fence *new_ef)
>   {
>   	struct dma_fence *old_ef = rcu_replace_pointer(*ef, new_ef, true
> @@ -2837,7 +2837,7 @@ static void replace_eviction_fence(struct dma_fence **ef,
>    * 7.  Add fence to all PD and PT BOs.
>    * 8.  Unreserve all BOs
>    */
> -int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
> +int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu **ef)
>   {
>   	struct amdkfd_process_info *process_info = info;
>   	struct amdgpu_vm *peer_vm;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 745024b31340..17fbedbf3651 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -917,7 +917,7 @@ struct kfd_process {
>   	 * fence will be triggered during eviction and new one will be created
>   	 * during restore
>   	 */
> -	struct dma_fence *ef;
> +	struct dma_fence __rcu *ef;
>   
>   	/* Work items for evicting and restoring BOs */
>   	struct delayed_work eviction_work;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 71df51fcc1b0..717a60d7a4ea 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1110,6 +1110,7 @@ static void kfd_process_wq_release(struct work_struct *work)
>   {
>   	struct kfd_process *p = container_of(work, struct kfd_process,
>   					     release_work);
> +	struct dma_fence *ef;
>   
>   	kfd_process_dequeue_from_all_devices(p);
>   	pqm_uninit(&p->pqm);
> @@ -1118,7 +1119,9 @@ static void kfd_process_wq_release(struct work_struct *work)
>   	 * destroyed. This allows any BOs to be freed without
>   	 * triggering pointless evictions or waiting for fences.
>   	 */
> -	dma_fence_signal(p->ef);
> +	synchronize_rcu();
> +	ef = rcu_access_pointer(p->ef);
> +	dma_fence_signal(ef);
>   
>   	kfd_process_remove_sysfs(p);
>   
> @@ -1127,7 +1130,7 @@ static void kfd_process_wq_release(struct work_struct *work)
>   	svm_range_list_fini(p);
>   
>   	kfd_process_destroy_pdds(p);
> -	dma_fence_put(p->ef);
> +	dma_fence_put(ef);
>   
>   	kfd_event_free_process(p);
>   

