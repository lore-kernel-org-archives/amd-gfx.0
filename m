Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BACBECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 17:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B79F810E03D;
	Fri, 16 Sep 2022 17:49:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C975410E03D
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 17:48:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIJ0LjNm0skSwQWjzGWKTPPYYF/v2WEtE/1scusjxaFzO6wtgrLXRfSU5Wz1JqTJ3q9blzaQ5eET/l7JQVj0Uz2DVWPLENXQgThJXreUsQAtQ/RAlXCNwIHAONrVtoPLqWfRhopVYMeC7xLbwh5uzj/UqMWlJdpe91/Zdk9duCS8/2gMnHql7k0mp+Xe3ztTRRv4I5tCgl3Vd8Q7mL3LNsGqK8bteRdKYi+hu3YyaEjc757S+al5l1VFMjhmrAPt15/BAZJjSVy5gRjD4hZgWsa3MfAUxe1mQa+lXBbM78voiYBmoLhVAGMRTSsauoBf9zUsoCR48DEOjwCGzpzmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a445uvxw9rt3heDu3o9Nm/CBLOznDRYtNfQJ8JJFDrs=;
 b=GUmwT0pwV694yxSGAZbdDjw+W+8lk0i6qLhm/bx/BjASj4DaGiZ7c8QOntpGJnq0XFwHk+I+m5p6xeKaDDqdbAuqeF1JgFG9MKrkiemYMPGOYSvbVr9qRRDEtY/JyYrWUSG7AMv00EwsrYRVK212p7UhWrZp7Y/9v/KkWP+LFy6IBvBa38Nr819qaU7nkMvXGPP3LGkFhzxtaAQ9K8h2DL7DZKTKt4dfDiYlpAVF1Edf2fXROxoIgBcnintfk4R1gJLHtP/kVr0ZKZkp1STduTRUeqHL2cNvjmxO2dWAZ5SwOE6aEvcAOAiDq4ST/IfaHGyKje+z5hLfFq0QHxM9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a445uvxw9rt3heDu3o9Nm/CBLOznDRYtNfQJ8JJFDrs=;
 b=mm3tH0cBivm6BLMwbo4jnXGv0zhynF+g9qAgpxh8WFkEhE/WpEhQ4YUaWiYc+1IgvuIn47ChB7T3qAm8rw+gx0+B3nQwA9Whc7m829arCqaxjavdHPf0A54xYZj0CbdAYuC8KWT+BQ84xfEsssXyKa5yGygBq4s447NHclFrT78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Fri, 16 Sep
 2022 17:48:55 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5632.015; Fri, 16 Sep 2022
 17:48:55 +0000
Message-ID: <4bf562c6-22fd-b30d-0c54-f5e336f575f2@amd.com>
Date: Fri, 16 Sep 2022 19:48:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 7/7] drm/amdgpu: Fix amdgpu_vm_pt_free warning
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220916150510.31321-1-Philip.Yang@amd.com>
 <20220916150510.31321-8-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220916150510.31321-8-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BY5PR12MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fab603-c242-42b1-2b8a-08da980bb9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gBF/8FobPatPgAlYqO7thlpUi4Bg4G3UTLZGwY2Bqy3zr/qPInI1FsWBTJ6f2b55VfXPvOJYNXOZAc6MQbIk7JY15W9j6mfUzTc32Qczz3oXL4AfLymiH/BNGQQOWgEnHtmseTChfFjTkX1XbfFN20NAzGyvLN3iNWKChAHw7V5dR4KH5eogPARf0j5f1uufYr53Wqm/zgZioHKRNhZEIm3PdOzS+btY/WRVu+E17wZ7MxwYzKoNlgovz+uLv3DYhG7ug27clw7T+UlMT1PShUyQZXTvg/24AbYQ3Mz1bHUEFUJPRCBA7YYM8+swlTSmHd4PHP6l8fkqxnq9v04gW1PdT8F3cCOrRM/JdlPp/3tMghgY3Nx19Oy5Lse+g2BWZzClAgLTNMXKx4tMqxnvwuvDiYpUOe+x8F8FJ7jJfVE7oW4e7LiN6wofjKJUPED1sZDdCWCS87PYhYL0kVAGgZAdUkUxlgzZB2OmfH7FDuE3YQ7SNUK9gkisSCrA2QDDpu6Wn6NGLZLZnUbqiQB/nHsjEQB8ZKmlpYlHkNvzL64qRx02rKrfT2PsKvt7VJvp3WTvAYz4+/x+oBBtaQvlN+XmXmwWWH7tl4sUYL4kB2eZJLlmo3LSsiHlFpmBi6MTCMCiaBmSiSLuhT/GmU+gkop8cKgHFhqsWro5QQ0mO143RxfgOOoHQxypDTd0ZJE050o6ex0Z6JBu7x4VakLo+nzCJXy+PENg8HzQS4z84ogiClzMmkkMSVXeAbRelvGOv5J4UJzTgezH4/3zkimZ7XOEffuk9D/GuvR/W58T1OM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(38100700002)(86362001)(31696002)(31686004)(36756003)(83380400001)(6512007)(2906002)(186003)(478600001)(41300700001)(6486002)(6506007)(2616005)(6666004)(66556008)(316002)(66946007)(8676002)(5660300002)(8936002)(4326008)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjAxaXh4aWJ6REJUSStWelhSY21IRTFxTENFT3VFSlRkT1FUM2NUWTZhdnJG?=
 =?utf-8?B?SXVETlJWeDRudUdxMFpraTh3cHJIc1FEZVdOd0tWeE1GSWN6eS82NERJSzhX?=
 =?utf-8?B?TFh4MzA4UEFFKzY2UmwxbnhxRGZ5UlNXampwRHY3ZE1HWHVlR1hjbjFqNDhU?=
 =?utf-8?B?blNmQnRrWHFpR1ZNemJrVHd6VDlnSGVIdGdEU3NGekNDRXhRMWVmRmhQWFp3?=
 =?utf-8?B?Qi9ncFZLYjljVTVpTC9uS0hRdUhiOHVTbW42aWZrQW5tc1cxU2wvdmNHZklU?=
 =?utf-8?B?UjlLdnEvN3dWSjdWanprYWxCY1hoRG9JOTBPSmZkS09jdmRYQVBHWDR3RW41?=
 =?utf-8?B?bmh0Mzd5NGhaay9xZllkem1kbnRYcHcvMjJLQ3NqeFJOK25yUEF0M05rZ2x4?=
 =?utf-8?B?MXNJWHN0U0dUWk9hM1Y2Q2c2dXVjVytHYnRIRmpzWFpUaE9XeXdDZnRRWjAw?=
 =?utf-8?B?RVU2V2hNYS9PVkxpTVZLS0tJL3owalh0M1Y2SzdjQzNBcnp5alEwTGtUNzUv?=
 =?utf-8?B?bU9VQUIvUGN3cEdabzJQZjY1b3paRmlGYkJsTmZsb1ZWUXd3NFJRUFBHNE9l?=
 =?utf-8?B?UnBYSWNLVXk0QkxJcCt3eGtKT3hLRkhOS0VVbmx4dnZDbko2ZjJJZy9oWFhZ?=
 =?utf-8?B?U1Z4RjBwVVl4cEtKSlF2RWtUZEVSUE5QTEx5em5lWGJOWlNRblJpODluZkRU?=
 =?utf-8?B?RWM0TUl5ZlRFUThOTzVUbFJUUXF0aE9hK2pLLzBsVzBrRGNCL3U2a3BxbThW?=
 =?utf-8?B?d1IxcjRaVXJIWjltZnpiaDZ4dkN2T1Iya1U0bFJBK1dlM0tjdE9vSHBwNlYx?=
 =?utf-8?B?alZDVlBwcUh0S0xYdDFmMlFnSTFiSlN5V2RVclFhYitCTDZabHF6dks3ODdr?=
 =?utf-8?B?UjNFNkRkeXZyNHdndENuUjZ6Wm1OaTNhL081WkJTaXRaNFU1QnBoM3JwRTg0?=
 =?utf-8?B?eEx6R1JTVUcwdFBhRW1IVm9Db1VQM3NmRE5RaVhpYTYwbFpKSzVrUFRmNWRq?=
 =?utf-8?B?OWl5YlNhNCtxcEQrY2FzUXRyVGVzeWFhd2xzUjlQUEpnbjZyRnpRRmdseTRF?=
 =?utf-8?B?K3huR2lJVkRsVGlNNlMwVmpoZEJsQjg4ZWtteTJwUTBVcDd1dmsxS0FHamc4?=
 =?utf-8?B?L01nWGFiWFNBMTBaYVNNYkRTQW9hT3pBTDJzUnorNElpMVcySWJPWHNFdG5T?=
 =?utf-8?B?WFRacUx0L281N0lTY2VEckZISVpyMm1QNG9ZVmxHOTNsZzhRQ1pBOUlqcnkz?=
 =?utf-8?B?dDZzN1RVdzA5b3M2YUNabXFrOWlMYjNmdGg0QU5zbm0rM2dwMkxrMkJTWlp4?=
 =?utf-8?B?Z0h4aStxMG9zNDNKVG1DU0s5RkNYOXVySkxvQm1vcjRUZUxtT1lkSzIxc0Vl?=
 =?utf-8?B?eGxJWmdCMWVWb0Z3bUQ2Y1haNTM4bFlMMEs2ZkRJbytEYXA0dXhzaWZIT05o?=
 =?utf-8?B?MEdaMTNMNVpGckxZb0xSaWdhVXFDQUxSNXRpRVpGK3kwb0prbGxHY1BjTVpy?=
 =?utf-8?B?NEw0K2RMSHhHcnhRYlByMVQ1NnMrTm9KcVJxemw1R0orbEplcXBHM0E1K0JF?=
 =?utf-8?B?VXIzcjRDZ2RidUYxNWhnaUtqZm5ObnQvNTgyU2tHK090UFM2bjNtT3VnVkpW?=
 =?utf-8?B?QUdES3JhOVJydTNib0ZzU2Z3dGdwcTR6MVpyN1FoNWxzdWU5bGRaNzQ2a1I2?=
 =?utf-8?B?SW5kM3p1YW8xTldEdG42R2lNY1A2Rk5TcFJ0WTk3WDU2Ri9Bb0lVSW5uNURw?=
 =?utf-8?B?cFBVNGNheTduK20zMkFxbExNNm95cGhRd3pRTXBEN25KcHZzbWxqWWdsMEVy?=
 =?utf-8?B?OVZMZ3Q3R2EydXJ2ZWhKaWpEUEY0WEk3ZTl2ZGFnZVFqSThnWVBnSDAvU2hz?=
 =?utf-8?B?T2lZanRNa0lBVkYzK05rcUVZUEtrWkVBTVAvR1IzWng3UjBVRS9aTnJ4VnlR?=
 =?utf-8?B?NGtuaStEcmZoWnhrVko4MytpaExXNjlHZnlzK1ZzZUdZakZOOFlSc0Z6emVH?=
 =?utf-8?B?RU4zVW1yQ3g0cjFYeWV5U3pIam5YeFlBQUdlRkpwM3MxVlJVUmcwNGNIS1Fi?=
 =?utf-8?B?aXllQWFCNGFRanJSQ3RuR0xsQTgwTGlLOW1GaVNOcFNKNEJWd0tENDhtMHZz?=
 =?utf-8?B?K1ZQcXdDQmwxNjlhT0RMRDdjT0thZDJPY3Y0LzNXMC9qQWZKQXorV3FDQnBB?=
 =?utf-8?Q?MPy7cdtCSr5TYZpN9Aj4R3eJxGUXaEOucTxnnIwg1N+w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fab603-c242-42b1-2b8a-08da980bb9a4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 17:48:55.5608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bU0voubhH8RNrLFONbSPGSHs1AbR6Ed8zW1O9JC/29DKUddCkuPZZ8vABDBvMqJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 16.09.22 um 17:05 schrieb Philip Yang:
> Free page table BO from vm resv unlocked context generate below
> warnings.
>
> Add a pt_free_work in vm to free page table BO from vm->pt_freed list.
> pass vm resv unlock status from page table update caller, and add vm_bo
> entry to vm->pt_freed list and schedule the pt_free_work if calling with
> vm resv unlocked.
>
> WARNING: CPU: 12 PID: 3238 at
> drivers/gpu/drm/ttm/ttm_bo.c:106 ttm_bo_set_bulk_move+0xa1/0xc0
> Call Trace:
>   amdgpu_vm_pt_free+0x42/0xd0 [amdgpu]
>   amdgpu_vm_pt_free_dfs+0xb3/0xf0 [amdgpu]
>   amdgpu_vm_ptes_update+0x52d/0x850 [amdgpu]
>   amdgpu_vm_update_range+0x2a6/0x640 [amdgpu]
>   svm_range_unmap_from_gpus+0x110/0x300 [amdgpu]
>   svm_range_cpu_invalidate_pagetables+0x535/0x600 [amdgpu]
>   __mmu_notifier_invalidate_range_start+0x1cd/0x230
>   unmap_vmas+0x9d/0x140
>   unmap_region+0xa8/0x110
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  5 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 41 +++++++++++++++++++++--
>   3 files changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 9d7f9b3670d7..3402fb62b4ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2057,6 +2057,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	spin_lock_init(&vm->status_lock);
>   	INIT_LIST_HEAD(&vm->freed);
>   	INIT_LIST_HEAD(&vm->done);
> +	INIT_LIST_HEAD(&vm->pt_freed);
> +	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>   
>   	/* create scheduler entities for page table updates */
>   	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
> @@ -2258,6 +2260,8 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>   
> +	flush_work(&vm->pt_free_work);
> +
>   	root = amdgpu_bo_ref(vm->root.bo);
>   	amdgpu_bo_reserve(root, true);
>   	amdgpu_vm_set_pasid(adev, vm, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 98895c8fef6c..2275c692d1ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -278,6 +278,10 @@ struct amdgpu_vm {
>   	/* BOs which are invalidated, has been updated in the PTs */
>   	struct list_head        done;
>   
> +	/* PT BOs scheduled to free and fill with zero if vm_resv is not hold */
> +	struct list_head	pt_freed;
> +	struct work_struct	pt_free_work;
> +
>   	/* contains the page directory */
>   	struct amdgpu_vm_bo_base     root;
>   	struct dma_fence	*last_update;
> @@ -473,6 +477,7 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
>   int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			  uint64_t start, uint64_t end,
>   			  uint64_t dst, uint64_t flags);
> +void amdgpu_vm_pt_free_work(struct work_struct *work);
>   
>   #if defined(CONFIG_DEBUG_FS)
>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 61a4b7182d44..25277380ef5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -644,6 +644,27 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   	amdgpu_bo_unref(&entry->bo);
>   }
>   
> +void amdgpu_vm_pt_free_work(struct work_struct *work)
> +{
> +	struct amdgpu_vm_bo_base *entry, *next;
> +	struct amdgpu_vm *vm;
> +	LIST_HEAD(pt_freed);
> +
> +	vm = container_of(work, struct amdgpu_vm, pt_free_work);
> +
> +	spin_lock(&vm->status_lock);
> +	list_splice_init(&vm->pt_freed, &pt_freed);
> +	spin_unlock(&vm->status_lock);
> +
> +	// flush_work in amdgpu_vm_fini ensure vm->root.bo is valid

Please no // style comments in kernel code.

Apart from that the whole series looks really good to me.

Thanks,
Christian.

> +	amdgpu_bo_reserve(vm->root.bo, true);
> +
> +	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
> +		amdgpu_vm_pt_free(entry);
> +
> +	amdgpu_bo_unreserve(vm->root.bo);
> +}
> +
>   /**
>    * amdgpu_vm_pt_free_dfs - free PD/PT levels
>    *
> @@ -655,11 +676,24 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>    */
>   static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>   				  struct amdgpu_vm *vm,
> -				  struct amdgpu_vm_pt_cursor *start)
> +				  struct amdgpu_vm_pt_cursor *start,
> +				  bool unlocked)
>   {
>   	struct amdgpu_vm_pt_cursor cursor;
>   	struct amdgpu_vm_bo_base *entry;
>   
> +	if (unlocked) {
> +		spin_lock(&vm->status_lock);
> +		for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
> +			list_move(&entry->vm_status, &vm->pt_freed);
> +
> +		if (start)
> +			list_move(&start->entry->vm_status, &vm->pt_freed);
> +		spin_unlock(&vm->status_lock);
> +		schedule_work(&vm->pt_free_work);
> +		return;
> +	}
> +
>   	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>   		amdgpu_vm_pt_free(entry);
>   
> @@ -676,7 +710,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>    */
>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	amdgpu_vm_pt_free_dfs(adev, vm, NULL);
> +	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>   }
>   
>   /**
> @@ -969,7 +1003,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   				if (cursor.entry->bo) {
>   					params->table_freed = true;
>   					amdgpu_vm_pt_free_dfs(adev, params->vm,
> -							      &cursor);
> +							      &cursor,
> +							      params->unlocked);
>   				}
>   				amdgpu_vm_pt_next(adev, &cursor);
>   			}

