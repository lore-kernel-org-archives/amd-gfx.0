Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2DCC6FA82
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 18:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 530A410E161;
	Mon, 12 Sep 2022 18:48:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D74510E140
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 18:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxtDupy7baO9/zCrkR4p7yAaWXaRP/DkACuAPqHV2W7PqTRGmgCCJ9y3KjaWae2awjbcIJefdI9+oEJqqZI/GOOyIxo034C3c+YPz1xsuPy7Wiu1sLFz15kf7T7IGorRMOWatHyblo/YKVRFFXsiwNEa6p+hr8UuGSwasvypKQ8kS3g4B+p2iY+uEsuA2+T/fxjMVNtS/tDIshUOLTw+RsEBV/pxAVD9PaOfSP5FQjkfr1InHlsFdgezc+U2t9ppTAZlNofAEhrBhse1s3BfZWi1Y0IEr/7ww2QfopCkNuOZrHE8jO4FAGt49x/vrdM/SmF7ZqPbXARabtaa+3Mt7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21xIp22sirMukBP3OsAN4DHoO2L4chQ8ovumHCMXC6I=;
 b=Bk002jE3fs4KoCfAZ2yph6AWJq4pz+DuqE44Yc1MpEEZcnlz4UkFa4OuXmYCBgn2/e5NS/5fhTw8ZA9z9MI+6EAZonLNG94pbPdRWhDKlzRXUj1JB5N6q7yNcuXquto8t/dJriDy8CX/nP3fPlPSRLkpw2vPXUNUiv6b/aMuSIgl6cezOOCN+sSg8YDE0Oj3QpybLH/ntbofVZYQPMsJV7lbm/FlBM40jKitUE6N/0rBktOCw65q6PgjRrJBkIFpaSp00GpgtkPRZdNcyc/Lg1XaREHVl036oYlB8SI35+EslaImhrD4ULSymPmXaU29ZLMDkUnxzMP4QeXARRssMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21xIp22sirMukBP3OsAN4DHoO2L4chQ8ovumHCMXC6I=;
 b=VspNwkp5C5DcgCih02UAoiU7xXPm1gTWsIcl+SBikyTmJZ6NLgj3u4KtHaSBEJCfSBqT4VLQ2Jkrfmmab/Asi3gS78mn6kWKaoZO/3ebC0gcH7CxB+lpq4IkmWYqnsjiJ1G6PdpcWS+oLvhybK9XeTbVQw54Vs7jxmU/yF2uHhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 18:48:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 18:48:41 +0000
Message-ID: <6e223900-7b8a-8ec6-e08d-aee0697a1aa0@amd.com>
Date: Mon, 12 Sep 2022 14:48:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/1] drm/amdgpu: fix amdgpu_vm_pt_free warning
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220912175817.17985-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220912175817.17985-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BN9PR12MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: cf6c20d3-1cb7-4c29-cc01-08da94ef6967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mvzHCddk1tsKcGkHtvzh++WvBw8XGadTF2uYCttkLIn3oXORFEgTUXaylKf0NO53bXUlLOS3+GpUUURQMxYBEFO0WJfqMNpKz4inSd7TQiSjQBJONfFzQd4n/r8nlXnqqUD6DMax4tcpLYoSF3ApDjUm4Y7zipBgMSe8IDwembra3cBsoaztOxIAqxNFT5nnTSvRfQQX+zqoiA10Kwt/wvANy/z+qO6p7f4vMLJPESTSpNR5mC19jO2xetQCPQuIxC4QvefnhBobHvCKnbUigzs4xF1mJCSjm8h7felajBb8bDZpag+w6+Lr2KjDZKNBzDKhKAJrEnlmwQQk1jBaczv9N2uPfauEHPCWKES73fE3E0M+oOPZtyqcLPDlfMviZqkMPOh8OyvpAXuEl2G9iQ01JfbtIRoW3kGeYIZNOZPzFEb6OFMSDnOCC68X61E5daNv3zU8M750z8Y5NcxvKzKK4GJZIjCJVL6cN85AF0Oj4UXMRRJPf/QMWhkPlpqVpkgPk9dWOp27ehfgOS/6FbL6ptkIUkNe3aX6tLHaTmDqio002P5Wxo9g/HeXMYKCigCff3zYNV2ZI0GcnBl/MOtKYrEWBfC6IwxbS7TB6tuyOeuQ+I647mknxOe6eAsbYozoE/Gn8UPLQk9k9rBIXPOSHC//zZRP59KuF/tEZ4M6qDE6wXNzdPdUH1x9Ogn7NGE1UMDXXAdui2ZQp5ZX+rolDL1/Yf7IzGBHoF0PozJ20OgbwFd/JfAzexINdFAQdzia2nkfqjXTv7/wxcIyBmVsbGGKsZ6cY9IPj/hxS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199015)(478600001)(2906002)(31686004)(6486002)(6506007)(36756003)(38100700002)(66476007)(26005)(41300700001)(66556008)(66946007)(86362001)(6512007)(4326008)(8936002)(186003)(31696002)(83380400001)(2616005)(44832011)(8676002)(5660300002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTRkVnZrd29ucXVJT21UZU1EdzVYOGNMOFppSTdoVVFmQVF2Ly9WZnJtQk1H?=
 =?utf-8?B?cloxTHFRTW9naEViNXByTERTS3NnVHZtcVZsR0lSZHoxOVlIS2dpS2hMMVNW?=
 =?utf-8?B?SDZoRjZCa2o4cG1vUXBKVzNMTlE0bWo1UGdBaGlLUGRyZGZWR3lOZ0pFNFFP?=
 =?utf-8?B?djUyYklXZFpqM3dkK3dmMnA5NmF5RHFPR0kxejc0SlhGT0xrYlh0VmxtNGZF?=
 =?utf-8?B?b3RzM2F4aklmOE8wUHd4aTFpd2l3NkJMdEpVVHoveFZaRDYrdW41dGx3WVJj?=
 =?utf-8?B?L21ISUlObEhCZ0tPVFQybUtEYzFmOW03MjM3b0Y0Wm1oT2pTdGttTGpBTUxz?=
 =?utf-8?B?MEluUzhiTkRxNXE5UUtRWUR4UW1KUEVnaVkxZ2QxODNVUUxYNFJ4L2pCTFla?=
 =?utf-8?B?aTlKSnIva1Nrc1d6azF0YWNBVEdBYzVaei9vdWtTdXlrNDdLcmNTODlTWWhR?=
 =?utf-8?B?bHJNY0hrZlhmUUlWK3FYQ3RLSGNPWVlGNTh6bXJxUU1vWnVOR3RLSDJ1aHJG?=
 =?utf-8?B?WGNuNmlQWlVxOG84cU1Kc2gzZGdvQStZaklGUWRzVnNSZDhSbjgyWnhvZm5T?=
 =?utf-8?B?SmFBUERWOHhYRXVrTUVQQnQ0ZEphNnpwMWxyejhHaDZDR1VkWDVrcEJSV1RG?=
 =?utf-8?B?dWZQelcyRlhIalJnTVNNb2ZMbmZYR3ZnZHRkcGNtcTB1ZndQRnBJS0ZaK0tC?=
 =?utf-8?B?czhNdUx4aHl1ZXNHM0IyV0IzNjZiSmI3bDRyMTJYaEJtNzVORzJobCsvejBu?=
 =?utf-8?B?bFdsV2F3NkxXTWMzM1FJeWdkNmJTa3VPTWFQTG92c2dxMWxKaFlNNFJoMmVV?=
 =?utf-8?B?RUtOQk9nb2FOYkROTjU4OFptRWRwTzcrcERjU0F0T3pQUTFHT010MFVrbWRS?=
 =?utf-8?B?bmVraVF5bTdlRW93TW9jTkJjeFhJMFpTN3hwYXRML1ptNC9GYzFwVHFNbnQ4?=
 =?utf-8?B?aGdZVkcwNi8yYzY1OWsrd2dPQVlSa0lrV2s4ZzFxRC9IcjJ3NUVBVXpUbTZw?=
 =?utf-8?B?UEwybFViM281aEpWMnFHZWRaMk1LQnpXbmdOcjdQQ2UyWFh2aVcrdi9Oc2R6?=
 =?utf-8?B?YjhSTlRReGFrWE56dGxrMkpRRHBTNWpNQ2FGdGtjUzlFR1NJK1lwL1JKZm5K?=
 =?utf-8?B?VE90dDk4VitFZC9pdmtBNTlEY3Uya0lVam51KzNLYXR2U0VKK2tIZ0pOTjlG?=
 =?utf-8?B?TVRrdkZ1RU1QbU5mM2lIaHdRbG9kSVF2M1JJczd2YXJBL2dvbEt3MVFTUGRS?=
 =?utf-8?B?MmREVjA4UEhCVEhXTnN3RGk5R3FiOGEzSUp2QjQ4eC9tSzVPOG93OXNzODcy?=
 =?utf-8?B?ckxEMTdySXZNUTNlblMzOGpUMkhQOWxPZWI2YUl2bEdxVlBQVFRwalh3dHdk?=
 =?utf-8?B?dzl0TE1Oblc0U2dGQ3pMTitlWW5XVXVQdHpOVW40dEZVdSt1cDNReXNacnNL?=
 =?utf-8?B?bHZlN29abWZURFFDdnpJNnlRMFBwZys0b0tDZ0J4cDJYRlMrRjludXJNVDla?=
 =?utf-8?B?YnUyQjNkT2NIUW9YMWRTSTJEbEFXSnhzRzI3MVFGZzhMUTJybU1WM2JjTm4y?=
 =?utf-8?B?UTZzdHAwVEhjT2ZsdEYwZHN1VEt1Y1c1cWRCSnFQU21ydUVlQXNXOGppUVlO?=
 =?utf-8?B?eUNOVUNBZHY0cVNkVU5iNUIrK3EzSEJmR2ZvOHE3VVk3b0sreDNydVh2SCtx?=
 =?utf-8?B?Z0k4SXh1enNrU2x5SDgzS1ZEZlBhQ1dZUGJKemRaVlZ1WHNpSUkvalgyQXRp?=
 =?utf-8?B?czZSSkNBcGw4TGdSTnVNcnJZRGRYLy9iS2VPMjRiSkVteTBXNE5mZFJDWXUw?=
 =?utf-8?B?ajBYdDF1Yms5S2dyTmVHcFNnNDZQRmtDN1dZRENYb3FwVEMvMHNpNHRlNzhK?=
 =?utf-8?B?bEVwTVhNcnY1UWFGSmRUZWlqMVIrRE1ZOWoxR01EL3pRNjR5YkpYamNLdm0v?=
 =?utf-8?B?QjhNVXhrNVZLVWtkL3RBcFpkaTBHY2t6LzRpb2VZWEJjcHNDQ0E2dHlJMHhz?=
 =?utf-8?B?Lyt6amZjUnMwM01aeWZJbUZISUpGUGlFa0Q4L3F3cmtEL3ZaQittWXpiVk1k?=
 =?utf-8?B?YSs2Tk0rVTFiZlZSTjNJMmE5TXhYMTlQY0U5YTZVVjl6K1BGVmZJTGh6dmsv?=
 =?utf-8?Q?vakIobIwjSeJHHSLHXFlMX2VZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6c20d3-1cb7-4c29-cc01-08da94ef6967
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 18:48:41.5026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2j7e9GhUq/uMxuYTuyVdzEIo/FURLXCU0Gss6/HaFPqvTVJ1hT+miZGtQAljEP7BtbGgJs7crzVYIiC46KOyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-09-12 um 13:58 schrieb Philip Yang:
> Free page table BO from vm resv unlocked context generate below
> warnings.
>
> Add a free_bo_work in vm to free page able BO from vm->bo_freed list.
> pass vm resv unlock status from page table update caller, and add vm_bo
> entry to vm->bo_freed_list and schedule the work if calling with vm resv
> unlocked.
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
> WARNING: CPU: 0 PID: 1475 at
> drivers/dma-buf/dma-resv.c:483 dma_resv_iter_next
> Call Trace:
>   dma_resv_iter_first+0x43/0xa0
>   amdgpu_vm_sdma_update+0x69/0x2d0 [amdgpu]
>   amdgpu_vm_ptes_update+0x29c/0x870 [amdgpu]
>   amdgpu_vm_update_range+0x2f6/0x6c0 [amdgpu]
>   svm_range_unmap_from_gpus+0x115/0x300 [amdgpu]
>   svm_range_cpu_invalidate_pagetables+0x510/0x5e0 [amdgpu]
>   __mmu_notifier_invalidate_range_start+0x1d3/0x230
>   unmap_vmas+0x140/0x150
>   unmap_region+0xa8/0x110
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 51 ++++++++++++++++++++---
>   3 files changed, 55 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 59cac347baa3..add3b08ffde9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2022,6 +2022,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	spin_lock_init(&vm->invalidated_lock);
>   	INIT_LIST_HEAD(&vm->freed);
>   	INIT_LIST_HEAD(&vm->done);
> +	INIT_LIST_HEAD(&vm->bo_freed);
> +	INIT_WORK(&vm->bo_free_work, amdgpu_vm_pt_free_work);
> +	spin_lock_init(&vm->bo_free_lock);
>   
>   	/* create scheduler entities for page table updates */
>   	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
> @@ -2244,6 +2247,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   		amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
>   	}
>   
> +	cancel_work_sync(&vm->bo_free_work);
>   	amdgpu_vm_pt_free_root(adev, vm);
>   	amdgpu_bo_unreserve(root);
>   	amdgpu_bo_unref(&root);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 9ecb7f663e19..c8c59c66ca2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -276,6 +276,11 @@ struct amdgpu_vm {
>   	/* BOs which are invalidated, has been updated in the PTs */
>   	struct list_head        done;
>   
> +	/* PT BOs scheduled to free and fill with zero if vm_resv is not hold */
> +	struct list_head	bo_freed;
> +	struct work_struct	bo_free_work;
> +	spinlock_t		bo_free_lock;
> +
>   	/* contains the page directory */
>   	struct amdgpu_vm_bo_base     root;
>   	struct dma_fence	*last_update;
> @@ -471,6 +476,7 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
>   int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			  uint64_t start, uint64_t end,
>   			  uint64_t dst, uint64_t flags);
> +void amdgpu_vm_pt_free_work(struct work_struct *work);
>   
>   #if defined(CONFIG_DEBUG_FS)
>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 88de9f0d4728..12471ef126a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -624,12 +624,22 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
>    *
>    * @entry: PDE to free
>    */
> -static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
> +static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry, bool unlocked)
>   {
>   	struct amdgpu_bo *shadow;
>   
>   	if (!entry->bo)
>   		return;
> +
> +	if (unlocked) {
> +		spin_lock(&entry->vm->bo_free_lock);
> +		list_move(&entry->vm_status, &entry->vm->bo_freed);
> +		spin_unlock(&entry->vm->bo_free_lock);
> +
> +		schedule_work(&entry->vm->bo_free_work);
> +		return;
> +	}
> +
>   	shadow = amdgpu_bo_shadowed(entry->bo);
>   	if (shadow) {
>   		ttm_bo_set_bulk_move(&shadow->tbo, NULL);
> @@ -641,6 +651,33 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   	amdgpu_bo_unref(&entry->bo);
>   }
>   
> +void amdgpu_vm_pt_free_work(struct work_struct *work)
> +{
> +	struct amdgpu_vm_bo_base *entry;
> +	struct amdgpu_vm *vm;
> +	struct amdgpu_bo *root;
> +
> +	vm = container_of(work, struct amdgpu_vm, bo_free_work);
> +
> +	root = amdgpu_bo_ref(vm->root.bo);
> +	amdgpu_bo_reserve(root, true);
> +
> +	spin_lock(&vm->bo_free_lock);
> +	while (!list_empty(&vm->bo_freed)) {
> +		entry = list_first_entry(&vm->bo_freed, struct amdgpu_vm_bo_base,
> +					 vm_status);

I don't see where you're removing the entry from the list. You need a 
list_del_init here.

If you're relying on the list_del call in amdgpu_vm_pt_free, that's not 
safe because it's outside the spinlock. This could end up corrupting the 
list if another thread is concurrently adding to the same list.

Regards,
   Felix


> +		spin_unlock(&vm->bo_free_lock);
> +
> +		amdgpu_vm_pt_free(entry, false);
> +
> +		spin_lock(&vm->bo_free_lock);
> +	}
> +	spin_unlock(&vm->bo_free_lock);
> +
> +	amdgpu_bo_unreserve(root);
> +	amdgpu_bo_unref(&root);
> +}
> +
>   /**
>    * amdgpu_vm_pt_free_dfs - free PD/PT levels
>    *
> @@ -652,16 +689,17 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
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
>   	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
> -		amdgpu_vm_pt_free(entry);
> +		amdgpu_vm_pt_free(entry, unlocked);
>   
>   	if (start)
> -		amdgpu_vm_pt_free(start->entry);
> +		amdgpu_vm_pt_free(start->entry, unlocked);
>   }
>   
>   /**
> @@ -673,7 +711,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>    */
>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	amdgpu_vm_pt_free_dfs(adev, vm, NULL);
> +	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>   }
>   
>   /**
> @@ -966,7 +1004,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   				if (cursor.entry->bo) {
>   					params->table_freed = true;
>   					amdgpu_vm_pt_free_dfs(adev, params->vm,
> -							      &cursor);
> +							      &cursor,
> +							      params->unlocked);
>   				}
>   				amdgpu_vm_pt_next(adev, &cursor);
>   			}
