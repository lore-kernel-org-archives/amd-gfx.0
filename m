Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28121C48295
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Feb 2024 23:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7583810F172;
	Fri,  2 Feb 2024 23:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LcGBDoDU";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C763B10F172
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Feb 2024 23:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4Y2lTOJ7u5527U3oMXscrLVGaEXcJhvZo6XrPZlQsN5IMNaudirCph/EnDYmZfYRUVzMcvlT4V03uGNR2rlFAms27n4ZFZFNuZu6w5AKD5V87ojVyVtWzwXtYaXIk6/aZO23S8q45yAvdf3GBCDNh//yTi9wKS3vjX1RmtTihxA4fnS2268SaxyEBiKSsH/RFIhJ2lXpGHddn3SzmOvfHSmE5KsneMEiX10XdLkWKqWeavysSk64VHyvRu5LW+rOcGLx+Xv89M05e3t10ferGVN9wNokYWDQzPRQBeLrMFgyMbTVrjqtS7m2cdy7erJWuvcDO4a/pa5+Ic1vg86/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUozwATo4CyBx5+wDPneu9U2y8kiyaf2faKq9VMlcj8=;
 b=KVLTg6Uk/hyhxWR/3m4/wNEkSXtFWtmUjvNHJJtaKpAWVZJMwPZH1ai4xH7fEy1B65CABsTr6Z9XeI6Cw/CIzaFapdykJfHgN0VDj89D8DAtIrow2F1ogfgNuOG1ch9LIYgmMXxatNot52NKxwtHFqekxETMvlKqqlreminwRaWhDc2rUisggd7Qj5dKjKHAM31v0/fVlBPyaYc3Xxjj1Ou0o//QHXZBy7kGjR3c+bZDsL4zBo3OBE5CwxMnBwXshVSL0Jx6SeKtfyCGK18AKTvZAQcyWrG03DyGl9wjXWep7upOj9K3L6Er7liFENCpJfOW4aKj+KfZfSpse8Ti3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUozwATo4CyBx5+wDPneu9U2y8kiyaf2faKq9VMlcj8=;
 b=LcGBDoDUMcXvc+YHnORqCOyCs5OS5z30BRW0UoAhkzNrPOYK1+XkCZ4Q5mpNiEx3CZrNhnT1EpBI/PBQpndI+6EH4qTXrJBuDT8iR3b3oBVZfWgA0L+AfptaZVBHW/NxSI8a/b8R2StMpAlND5xagHbsyh/khQy7AXuiD3HEnWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB8642.namprd12.prod.outlook.com (2603:10b6:806:383::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 23:51:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7228.036; Fri, 2 Feb 2024
 23:51:00 +0000
Message-ID: <cd82ea95-d41f-487b-bb5d-2729798ed453@amd.com>
Date: Fri, 2 Feb 2024 18:50:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Unmap only clear the page table leaves
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
References: <20240201165017.29789-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240201165017.29789-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB8642:EE_
X-MS-Office365-Filtering-Correlation-Id: 953b129c-408f-4948-6e45-08dc2449ceec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4pMp5Ju9hdNWXqAW+f+g2Gl9+EBb4TOqQZzUFIm5dQJ3Z7/Htc+iISMenM9QxThwnNSg16LQKuWCAHDlJQAUU491J2tadbot8Q7Qk9hDnw6UrVikVj103VStN54CakPtaI/Z5E9YJSBSr9yxYrMrHIcyqwRwnWy+hNeH3gEw6iT2DTgWAtrPKEkiR1j8ewHjAOWDGidEnM9FOtzfOnSnVkJnmXFwXAAI0ZsKurtPdH41KCBIAw6RIquz3zlMZE1tbGArAaAgjPtEULtgAUHemKAEIZ2xL2xE+zGpfBU7TrlZgk4GefODc8rZdiV85ZOe6kKBFYeIQ/uarekvEt1C3kn5g6IIDPo+TtM33dQAYmE7OrDJiOfTropUEHEPIese+9XQN3JdTForx5vetkvcToxEiCzU3RpMLo8eiXEy1FaxnRNVlqY3oIeqnbLMZ6PI5fNIygaLg1Z4K/k8A8mEIjFh+4FyZj04pXO4c7CCNDAK8X+nkcnLvJeujGGz6xTgQ5JOmq99quHyih0HPcbtOstlNeDmP8E5KmzRjEnwwwDoUPrH6EewZUkxe7dUcNvd3YCPSoo4mya5ydImPz3s5552las/OjLDqswaS4N83MYKfNvaU7Vd8p6lCjPKeWfbsKUriBG19SGJKXCuLRXPag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(31686004)(6512007)(6506007)(8676002)(2906002)(66476007)(83380400001)(53546011)(26005)(36916002)(478600001)(316002)(66556008)(8936002)(44832011)(4326008)(66946007)(6486002)(5660300002)(2616005)(31696002)(41300700001)(86362001)(38100700002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3htVmFMLzgwZHUvVTFldSthYmJiMEpWaVJKcXpqNDZtcWxET3JWUTdYdW5R?=
 =?utf-8?B?TlpHSityK05mbG9kdmdQZUxkbGx4SlhVS1VMVmtCcGhNU29qb0YrYTh5Y3Aw?=
 =?utf-8?B?SlJwSlVRQWtxaXMzcWg5aVdRUkR0dllzZi9pS0Nqbjg0K09BQnRRaWF6V0du?=
 =?utf-8?B?M0IrOFJXWnFIUFVTcHU4WUFSMnp4MTdXaDJTcEtSSmg0aXJ4VnJUMzQ0UkMv?=
 =?utf-8?B?QzJnSWNhc29na3NCQTFNYTRYc0QzQzg1YnM0dXFDWXlGRjNYbngvN2paRXVz?=
 =?utf-8?B?NE1yZDBDRUxLMlgzUjRTWWhDMUF2Yk4wWlFPS3lyWkJCWDRxaFNuYXFOQmNC?=
 =?utf-8?B?dXVCdHA2Z0Z3dnBZWDh6OWJ6ZmN0V3VLM3lOcVhFU0E2ZW5Oc0ltR3JEc1JC?=
 =?utf-8?B?SUM1cEFqOVp1MEw0K2FtMHJkeVdVczQ3ZjVpUEhyUFp6cHZqeFoxb0NmNkc0?=
 =?utf-8?B?SVVWc2Z3VC9lWFRWOXhiSW50RG9oT01rTjNTUlJDMVhVdUlZY2s0NkFBOWtX?=
 =?utf-8?B?OHhiMXdOQ0JkWC9UWmliTVozd3BYcUM1M0J6YWpKaHp2dHZIZ1pVYlVKbEY4?=
 =?utf-8?B?ZGhSVzE2dkoyaWh4bnFWU2daL25HWE1wUHBkUUJaRi9RUWV6UHNKbVpldXhV?=
 =?utf-8?B?MWxMSGhyZnJGZGpvLzlQMmsxVWk4WlVqbzN3dWhoSlRPSWs2TjVGaGtscUJB?=
 =?utf-8?B?L1piNm56Yy9FMFBvMlVuRmFDVlF3ai9IUGRpaGcxclNUclJMVWN0ZEs2Qkdo?=
 =?utf-8?B?TEQ0WFNycEpyZ0lGejJCa0NxYUZocnpTd0VrQkZqak9EMXVzcDZ5MktPbXg5?=
 =?utf-8?B?OTVlQkwxelBWQnFMaXNleFVCSHhocVN3RUxhbDgra2VmemFBTzlwaE9mdUt3?=
 =?utf-8?B?TXB4aEFYUEsvWjRoZGlHZGxWSDdOck9iSlNoSzcrQ3Z5UVRiNVdSQk5QRTdu?=
 =?utf-8?B?TVVmNGdEeGwzS0pVOFlvRFh1cmJ5TVhBT1JtS0JBVHZBYWxnbUsxWlFXTXJN?=
 =?utf-8?B?WWplMEREV3B6SUc1dG52NnBCZE9hckZoQ08xTmY4SU1sZEJpQVlLS0o0aHpL?=
 =?utf-8?B?R2cvQjNxOW9UclZKeS9RL245b0xuTERIMEVZd05OUjdzaGlWdVpsQ1RMK09D?=
 =?utf-8?B?a2tGeHpwR3NQWnp1Z05XdExUdWJreWtyQzdtcUFpT2ZEOFNtdERxZWozSEFG?=
 =?utf-8?B?MStHb3lxdnluWGRXOXE0aTRMY2cxL1VNRGUyczA3Wi9aME15YUhlTWVhQ3N0?=
 =?utf-8?B?WC9XdDMyRnorcEoxZ0ZtcUdPYW9ka25wNW4zejQyTklFT3VVWGtUNERjZmNB?=
 =?utf-8?B?MXdDQVRMSGhIdEMyTVNRcHppa3RnQW1VbFpKOHlnODJxa2J2bTRsKytQbE5T?=
 =?utf-8?B?S2hxSDRrRmd5N3BFV1FZVjd2ZXkwalRPYlE0Q1kwUGhYR2JUQU5aM25lS1No?=
 =?utf-8?B?UXgwdXk3WlB0Z0JOb1pzNDMreU1haHJPZnJaR3N5Qk02cXpyZmwrUkc4MzRv?=
 =?utf-8?B?U0F5VGUydmR2NkRUbGFXU2RtMCt6blR1elhENUlJWFlMZDlNWFd3MURFTFpF?=
 =?utf-8?B?VnpKZm9PbEp6SEg3bnFnZnFFMFE5QVJwU2dTTERRYkFvWXM3eWtGRXA1amtj?=
 =?utf-8?B?TGRCMVhXS2RNU1ZGbmdQaUJQVVUyNzVTQWJ0UlVxWWRmSlorL2M4UnBJUkJz?=
 =?utf-8?B?RnFLeldsbC93T3NiQ3NYRFVvWkNqNml6VkJkY3BQKzlyc1N4STVGdk1oZ1RX?=
 =?utf-8?B?N3BKeU9vNnhDdHJJaFM0V1lFUG5seG5SbUZySUthL3dreEc0OXo3NUdobldq?=
 =?utf-8?B?V0NFQ1NLL0t6UE9LRTZPZGV0c2x0MzhNZ1VyQTZqY1F0TDQzZWNseEg4NDVn?=
 =?utf-8?B?NGROb2lsQkNCdVJXcmhBMGVRQXVQR3Z4eHJtbkg5Ujl3TEt0TnNHbTcwVlZa?=
 =?utf-8?B?V21sM3JzV013SENSdTlYZXoyT1lTZnRDVDRTMWhQNSsxMzBBN3ViRVRKdnor?=
 =?utf-8?B?ZTE3bUdOTUxNRTcxSW8wQjRpRWh0SDNwNVBuOG00N3EvYktOOWo1Q1Z5Nk9F?=
 =?utf-8?B?K2pkSzVaODBMcDFNaDJzNVIxS0JqQ1gvaUVWRFF0NWpZUlo5N1IrdzFyclZq?=
 =?utf-8?Q?DHP51ocsCU6yLtR3g8nc+3D6m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953b129c-408f-4948-6e45-08dc2449ceec
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 23:51:00.3785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1XuK9JWFIPHe89Z3xIQBOnAwsnbSWHw6TbeVjrloyAnnX0ezmrewvTJIMhBjUyXaKvrQXbCt2tcQDhTMI0p6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8642
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


On 2024-02-01 11:50, Philip Yang wrote:
> SVM migration unmap pages from GPU and then update mapping to GPU to
> recover page fault. Currently unmap clears the PDE entry for range
> length >= huge page and free PTB bo, update mapping to alloc new PT bo.
> There is race bug that the freed entry bo maybe still on the pt_free
> list, reused when updating mapping and then freed, leave invalid PDE
> entry and cause GPU page fault.
>
> By setting the update to clear only one PDE entry or clear PTB, to
> avoid unmap to free PTE bo. This fixes the race bug and improve the
> unmap and map to GPU performance. Update mapping to huge page will
> still free the PTB bo.
>
> With this change, the vm->pt_freed list and work is not needed. Add
> WARN_ON(unlocked) in amdgpu_vm_pt_free_dfs to catch if unmap to free the
> PTB.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

As we discussed offline, I think this is the wrong approach. This can 
lead to resource leaks when lots of virtual address space is released 
bug the page tables remain allocated indefinitely.

I think we need some solution that either

* prevents reuse of page tables that are about to be free
* prevents reused page tables from being freed by the worker (e.g. a ref 
count or cancelling the work)

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  4 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 43 ++++++-----------------
>   3 files changed, 10 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 82e5fd66a10d..3bde77dfc63f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2256,8 +2256,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	spin_lock_init(&vm->status_lock);
>   	INIT_LIST_HEAD(&vm->freed);
>   	INIT_LIST_HEAD(&vm->done);
> -	INIT_LIST_HEAD(&vm->pt_freed);
> -	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>   	INIT_KFIFO(vm->faults);
>   
>   	r = amdgpu_vm_init_entities(adev, vm);
> @@ -2446,8 +2444,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>   
> -	flush_work(&vm->pt_free_work);
> -
>   	root = amdgpu_bo_ref(vm->root.bo);
>   	amdgpu_bo_reserve(root, true);
>   	amdgpu_vm_set_pasid(adev, vm, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index cdb61f1e7c35..74fe211b9ecd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -316,10 +316,6 @@ struct amdgpu_vm {
>   	/* BOs which are invalidated, has been updated in the PTs */
>   	struct list_head        done;
>   
> -	/* PT BOs scheduled to free and fill with zero if vm_resv is not hold */
> -	struct list_head	pt_freed;
> -	struct work_struct	pt_free_work;
> -
>   	/* contains the page directory */
>   	struct amdgpu_vm_bo_base     root;
>   	struct dma_fence	*last_update;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index a160265ddc07..a3d609655ce3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -657,27 +657,6 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   	amdgpu_bo_unref(&entry->bo);
>   }
>   
> -void amdgpu_vm_pt_free_work(struct work_struct *work)
> -{
> -	struct amdgpu_vm_bo_base *entry, *next;
> -	struct amdgpu_vm *vm;
> -	LIST_HEAD(pt_freed);
> -
> -	vm = container_of(work, struct amdgpu_vm, pt_free_work);
> -
> -	spin_lock(&vm->status_lock);
> -	list_splice_init(&vm->pt_freed, &pt_freed);
> -	spin_unlock(&vm->status_lock);
> -
> -	/* flush_work in amdgpu_vm_fini ensure vm->root.bo is valid. */
> -	amdgpu_bo_reserve(vm->root.bo, true);
> -
> -	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
> -		amdgpu_vm_pt_free(entry);
> -
> -	amdgpu_bo_unreserve(vm->root.bo);
> -}
> -
>   /**
>    * amdgpu_vm_pt_free_dfs - free PD/PT levels
>    *
> @@ -696,17 +675,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>   	struct amdgpu_vm_pt_cursor cursor;
>   	struct amdgpu_vm_bo_base *entry;
>   
> -	if (unlocked) {
> -		spin_lock(&vm->status_lock);
> -		for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
> -			list_move(&entry->vm_status, &vm->pt_freed);
> -
> -		if (start)
> -			list_move(&start->entry->vm_status, &vm->pt_freed);
> -		spin_unlock(&vm->status_lock);
> -		schedule_work(&vm->pt_free_work);
> -		return;
> -	}
> +	WARN_ON(unlocked);
>   
>   	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>   		amdgpu_vm_pt_free(entry);
> @@ -1009,7 +978,15 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   		incr = (uint64_t)AMDGPU_GPU_PAGE_SIZE << shift;
>   		mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
>   		pe_start = ((cursor.pfn >> shift) & mask) * 8;
> -		entry_end = ((uint64_t)mask + 1) << shift;
> +
> +		if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
> +			/*
> +			 * Unmap to clear one PDE entry, to avoid unmap to free
> +			 * PTB using pt_free work which has race condition.
> +			 */
> +			entry_end = 1ULL << shift;
> +		else
> +			entry_end = ((uint64_t)mask + 1) << shift;
>   		entry_end += cursor.pfn & ~(entry_end - 1);
>   		entry_end = min(entry_end, end);
>   
