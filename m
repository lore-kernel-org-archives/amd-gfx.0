Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B4C606A320
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gbmSe92S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 802A310E0BE;
	Fri, 20 Nov 2026 14:09:14 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16F7610E0BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 14:09:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k57w4U5I1bGFvmsDPTIWqUMWcsLCxPnb+SurcNbO7ktZkT80gatQgu588fRGjq1tL+hQ8ueUZSmKC5X/SR0/TU/2exBHqKqDpPQFEfRYk5Bf0iUIe1Uzv+b3AczZRM4WdpXoSOWuSFil10bPYMk0C4G9YbTikrEAWw7rNfXSmiMu13MJkUwvT9oY9d9/aJqa+O6a+g3uqPGTGguMgBG+xMDLwg1/uVSV6D1si8fkZiIsaNsk4NXESVxuSyBvOy8qy235DiFXQsq0hDolOD7CCXWqhDh7AxmA6vUpmKZNm9KB/4ALXli+rgHY47tnLZRRerRVRayosFsP04F/GQ4IBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RGM5kq56v8G/LiH88p7djfQCfPV7zCV2rhx8qjyHjs=;
 b=CPMu+JWAAn1HflZR6+QTk5128Tk7XQL/+79dDS8EO0c7oUZ5p6gBmdLm/zfMwe/aYpCi070n/SMzRfUg5vXFuiqSFfi9H//U9Nb4DOT6r3EpKpiutIzEmYuV6uLvghJJURrvOJy5wNp80k7FDcN/K+PHZBtQZ8uAZU7ICkjhm3GB1Xkwx5+BKM/AV61d5zDiXdzMg4OUlB+dthYm+NFLoA31WPgcusy8KHpWsXWiUc/a9gyAnd/9fAMe1pQBcXFiQz1F6dl2gKK5l3vonf1e8HjU9aMueXCXVfbiC1m4iosNUoJR308Zbj5Z7bH3OeZdgt0SVlCof1SmMb+pBjRXEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RGM5kq56v8G/LiH88p7djfQCfPV7zCV2rhx8qjyHjs=;
 b=gbmSe92Sp0h8auhvNs1nT61bt5GeNbLi1lZBB2x7oT2fwUtEo1pi5Uj/YSZwMrIfU8tpj0BjealVaLN4niQfGTAfGCqk+tri55+He3B37diqTNkXEzqr9fgVNpDPEbosiBEBItQYIQ9djnX8gTqBfGBhDITj5IJNwMNeLYJ90no=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 14:08:58 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%6]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 14:08:58 +0000
Message-ID: <3a26430c-c8b1-4df1-a5dc-eb699a0fdd98@amd.com>
Date: Fri, 20 Nov 2026 09:08:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] drm/amdgpu/vm: stop using amdgpu_bo_fence
To: sashiko-reviews@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-5-benjamin.cheng@amd.com>
 <sashiko-outbox-223337@kernel.org>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <sashiko-outbox-223337@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0004.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::17) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: d0de30b3-53cf-4ec7-693c-08df470fd196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|261009223027099003|261009221227099003|261009220027099003|261009223327099003|261009221727099003|11063799006|56012099006|4143699003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: RxrophvvZWufISk2/P4THBSWtEAhfiKwsP3A6I0ctfRVHdU3Wwh2GHj7KR9PpHU6aDP1d544iH3VQy2fj18jzJJaf791zezboLQbqHvagSckLRlYUGEZ9Rd1nrIlCOnmKNYrmhhL5CMZmFjyntpjWPOdxPD4ov+1ixIXaO2MctoYzyp47pAlhhe46EUKVy7d+BUDUl828T6xeXeErtf2mevAnALBEFOSocX5WqITTV703j/F/Bui8V49xLCOYMzK26Vrj8D6ndu/gzrjPbw2Ss3SDfu/O72wHvEWaLYIU5yBYM+u8WTAdrQrX14U4sgkeVjKskY2tmcYVQqARzMfXmJ24sPRIfQkmbmAOZc6ewcRyXnpbcHMq8KToN75lPAr9Xn1O/mX/qD0LNBK2vOu2buALS3eDaBvUwdlIRvBGnJDungfnh8yoE48VrNgGKHlSqgF/5sd+pZRh6JvzvZNxZvP+YmdelylQDJUkabYfSrRN3ZKIefRBJxmCrteFKUKow6Q1eBCDuopMm2o4JEwRyBDTWHQGxnpIx+bSUUI5yKL4PWK5HE9qkp2VN57r+v/K05sVYE+ZSygyF9UWOw97PL0Um27819GAXqyemgA24Q/FtZgVzfyPKD5RnHYSxbLJ+5hweHZdNcactSoi01WmIfeuPJ/uE+Z19bvWuB32/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(261009223027099003)(261009221227099003)(261009220027099003)(261009223327099003)(261009221727099003)(11063799006)(56012099006)(4143699003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmhhRDE0U0NVejIxdkpGZlI2cWk0T203b0pkNTBBRTVCdEc3VmpLYWdlMjJB?=
 =?utf-8?B?TjQxRWdueTQ5ZTVrcXROL0VvSWFHTEZUUnVzS2JWTStGUFhvaXdocEdYeTFQ?=
 =?utf-8?B?cisyWmE5VENWR1I5bXk0RUVkTzFScVVkVGdZdm96YU1oYUlWUTBkL21ua2xU?=
 =?utf-8?B?SkxkNThiWDZoVjdPclByVGxyeXZzYzY0NS94dkR1TkV4Zy92NDdsaWxtcU1Q?=
 =?utf-8?B?V1ZnZ1drbnBkalhpZythdzVWZXdqRDFNZzB0OG1HTnNtRldNRHl0UEdCc3ZJ?=
 =?utf-8?B?ZzltdUVVS04zaTNjeTFnQ3d5SUVXaytsVjNtNWN6ZnB0eW1sbUN3d2owbDBO?=
 =?utf-8?B?c3pRN0tGSGx0M2p5SWxWOENCczN4VGQ3Uzk5R2NGSW9LWnpKaHRJUWVjUjlY?=
 =?utf-8?B?Y1E5UXdxNnBRNzZKcktJTXNvc3FnSnNEWnB0ajZ3V3AxRUlLYTFCNG9aS1Np?=
 =?utf-8?B?Zm55K3hzSGpobzR3cUNwVDVkaXJNWkU4OENMS2F6ajNVczRYL2dTa21aUy9t?=
 =?utf-8?B?elVZaDQ0YmpvTDdONGZ3NjdmRFZFQlU2L1JpSDE0eTFzNUtJbHdNcGRsaG1j?=
 =?utf-8?B?ZjZZVUFUUmdZbTNWdlBhdGxmMnczbG5ENXFqWHVLekNNTm16RkMrSTZtMndt?=
 =?utf-8?B?VDhuTDhhcFVQQnIxL1Z3b0FiYmZYR3U0UTVFSlAycUlmOVFlNzE5RDV6Umg2?=
 =?utf-8?B?cG5VQ2hjcG1CdUZmWEo0Z0tnakdGZTZFWUxxOFdVcVlhMDNTSnRkNWE3azZQ?=
 =?utf-8?B?bldyK3RzUTIzTk5XS0ZHYmR6N0l4ekFIZU1JWE1FTWlkYWxSME9IdTFpcWJD?=
 =?utf-8?B?UmlpNHNTTjRyUFNOMlZIODd5NERkUTFQVC9QS3czQzFwb2s0WCtIa1N0ZDBV?=
 =?utf-8?B?Y25YV0xpZlYvcnR5YlZlakJuUVpaRVUrTXp0aC9vT2ZadGYwN2poeEdPeWM4?=
 =?utf-8?B?cWJaajhzN0taZ3V0OGVpN1lZVkx2MDJTS3BLaGFOWGlQWE5DOVZlaGkrMEg2?=
 =?utf-8?B?UHlQZmxUTTJ4R0JYMitWVU50NzBkUm4zeEVGcjl3d1c1VG9ncHQ4NGVJWnJV?=
 =?utf-8?B?eUhLVnBRZG5jb1dSWkhBWVVQUUUzbi9vYjY1cFNzN2RIOWpQTklwZHl1citU?=
 =?utf-8?B?RDM3OWROaHpWUnAxTE1hVlliM1pCckVYNzYyQ1JRUWdldExYM3pQZ1hYUEtC?=
 =?utf-8?B?SmxPSjVWV1FNUHZrTzZidWlkV1JaWjVJZW5OeGd5TFY1bWFnakVHNDV5bjgz?=
 =?utf-8?B?eTJxc09wREpwN2hvSzdYOUM0M2tJbHpuMUpuZ0hCeGY1NkVpb2gxV0Facmwz?=
 =?utf-8?B?eGYvN3hIdWQwNXJ1ZG9nWVRlQ0lSR2xNVStMS0JCMUVPOFRZUEJWbGt1T3pY?=
 =?utf-8?B?dDg5VE1ISTdlejhmYURrYjFJOG9sREYxK2paYUVJOUpBUm5QcEZPTU5OWnc0?=
 =?utf-8?B?S1JhNE5CZFUxdmlEOFN6RGhxNDBFNnRHd05keFpaVFJyNlYrRjhTWmJwUENj?=
 =?utf-8?B?cDdQME40N1dGS3lzSjRWbUpNaUM5YXJqZVNORGhHTzZkMGNIalpOSCt4RGVz?=
 =?utf-8?B?Kzd3SkFsSkNEdThnSkxPZDhYQ3ZDdjE4M2VYU1V1dGtVL2dBRUcxamZpTVpQ?=
 =?utf-8?B?aFhUUk1HY08ydjhVdEQzNWhWOVNONzBpZ01oNEt6M0tBV0ZFeU9FdHF4LzJX?=
 =?utf-8?B?L0pseGplNi81NlNJNTkvU244SnVycFl6TG1yMXN4TzU5SUV6UVNvUloyVkJt?=
 =?utf-8?B?VS9VbURjcG1zK3NtOW13WWxrKzdwZVp2UXF0aUtRY0h5dnJDeE5YbFZEUTIz?=
 =?utf-8?B?TlY2aTBJRStaeGNaOC91aXViOWRpaW5VclQ2SlhhVGVRQ2R2bUQ5dkdTekhy?=
 =?utf-8?B?SzYzNUIzd2dJSkl3NkxkTUQ1TzVlVnJ6MWVSaFU4eE5jN3JlMW9sMFNzTG5s?=
 =?utf-8?B?REpyRjFkMCtaT1hvNFNJRTBjNkcySlRPd3h5TDI0MEdVUjRLVG80WVlXMy8v?=
 =?utf-8?B?UkFJQzRaRkRtUlBzRjFSSERhUGM0aU5HemgvQW9Oem5sSVdXOVowWG51Vk9H?=
 =?utf-8?B?ZU9ZUEg3YjdzT0cvSXFXdVc1TWVabHFmRElyeHBicFRJQnlIUVVlb0xqeGs2?=
 =?utf-8?B?RUdOQ3RKRUl5dkdycTBDbEpQWG1TNnhaTFdNaTlNTThkL0JzT1VuTzg3QXdG?=
 =?utf-8?B?R2M3d0lXN0x1RkVkR1R3cG9qN0VNdGxsTXFLZmdPbXpqV1lNbFpBQmhvTHlF?=
 =?utf-8?B?d1lVMWcrYmw1Y2l1ME5icGVNRGxaYUkybi8rMTE3OUFyVnhMREJSQzJSLzhx?=
 =?utf-8?B?VTU0WkxGbytoeVhBb3R5U1pPVzRScWwrRUsvYnpZYUVYZjRTY1hKQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0de30b3-53cf-4ec7-693c-08df470fd196
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 14:08:58.0872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NEFps9C6TJYnF2Zzc9gfi5PZJ8tFp/chzqGyt3nGS+fTcwE65nGUkPV2G7uUbreg5B4ndIvg7LyVkcG/dSLaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 2026-11-19 10:04, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] drm/amdgpu/vm: unreserved fence slot usage in
>   amdgpu_vm_update_range()
> --
>
> commit 62a2ba953c5e8b9b18301c84fc57052868fd3e60
> Author: Benjamin Cheng <benjamin.cheng@amd.com>
>
> drm/amdgpu/vm: stop using amdgpu_bo_fence
>
> This commit replaces the amdgpu_bo_fence() call in amdgpu_vm_update_range()
> with a direct dma_resv_add_fence() call using DMA_RESV_USAGE_BOOKKEEP.
>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index a0e6bb34ae0be..d4d8cb15ffd38 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1215,7 +1215,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>  	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
>>  		struct dma_fence *tmp = dma_fence_get_stub();
>>  
>> -		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
>> +		dma_resv_add_fence(vm->root.bo->tbo.base.resv, vm->last_unlocked,
>> +				   DMA_RESV_USAGE_BOOKKEEP);
>>  		swap(vm->last_unlocked, tmp);
>>  		dma_fence_put(tmp);
>>  	}
> [Severity: High]
> Can this dma_resv_add_fence() call consume an unreserved fence slot and
> hit BUG_ON(fobj->num_fences >= fobj->max_fences) when vm->root.bo already
> holds a newer fence from vm->delayed?
>
> Callers such as amdgpu_vm_lock_pd() and amdgpu_dma_buf_move_notify()
> reserve only two fence slots for VM updates (one for vm->delayed and one
> for the TLB flush fence), relying on vm->last_unlocked and locked SDMA
> commits sharing the vm->delayed slot.  However, dma_resv_add_fence() only
> replaces an unsignaled same-context slot when
> dma_fence_is_later_or_same(fence, old) is true.

Hi Christian,

I think this edge-case deserves to be fixed in dma_resv_add_fence() right?

I don't see any reason we need to add another fence to the resv if it already has a fence from the same context that is later-or-same and same-or-stronger usage.

Thanks,

Ben


> An unlocked update on vm->delayed can leave vm->last_unlocked with a
> seqno older than the fence already in vm->root.bo->tbo.base.resv:
>
> CPU0 (locked update)              CPU1 (SVM MMU notifier)
> amdgpu_vm_update_range()
>   /* checks vm->last_unlocked */
>   amdgpu_vm_ptes_update()
>     amdgpu_vm_pt_alloc()
>       amdgpu_vm_end_critical()
>                                   svm_range_unmap_from_gpu()
>                                     amdgpu_vm_update_range(unlocked=true)
>                                       /* submits seqno N on vm->delayed */
>                                       /* vm->last_unlocked = seqno N */
>       amdgpu_vm_begin_critical()
>   /* submits seqno N+1 on vm->delayed */
>   /* adds seqno N+1 to vm->root.bo */
>
> amdgpu_vm_update_range()
>   dma_resv_add_fence(..., vm->last_unlocked, ...)
>     /* seqno N < seqno N+1: allocates a new slot */
>     BUG_ON(fobj->num_fences >= fobj->max_fences)
>
> The same ordering can occur when an unlocked update sets
> vm->last_unlocked before amdgpu_vm_update_pdes(), which submits on
> vm->delayed and adds its fence to vm->root.bo without flushing
> vm->last_unlocked.
>
