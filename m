Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F59606A325
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gCZnGMNu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C109D10E2EA;
	Fri, 20 Nov 2026 14:19:02 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013001.outbound.protection.outlook.com
 [40.93.196.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1BF210E1CC
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 14:18:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcLE/szpPC5lCRbpQttMVPRXkigzHOC3zGbT40c7dO8cUzhcNjf+ko/1sTCrzOrn16jOXIQOHgio5GhBFO3MJGi3wvlpoTYUHzcXzWzlFaYjhS1yR+RgwCcYl+OJTKrShF7phPOGhwuS2DBs5TbRyUA/vXUPI2Rcxa0q64mQWWpxPkXFdZZ/IOvCRelzjPUzww4CE+lkNmqkvF88rVEhgdPS1K+kXZX2LfGxsz7UqscjZ+50x5f2pnLt/hD8oGxfSN4DVOJQYaMYpxEwRxtbEQHn5N/A00p7kS9s457qniAYLDqkI8lsnEpXfegspqmTSU4ykTmBo+96RM0tGoo5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S22TlI72tl9W+5oLOB8xbCsxnL1/CvyLahbJH5qBynI=;
 b=kMbK19oqKZsFpoQ1JyrQG/gz826IUX1GjbC0vSUtB99c5SQqmm1WizcW3IEUGD6bcNsVceqQDJksaM44KTRXhatGL5x24QVDx5dwH3lBaD4GXJ8r33XH7dvDWrXUMYRnGqhaO2WIlbn6rHpnvXgaIFa0WatXu+5kr4XX7YigSk5UA7I31rVk7A1mz9lBhtRXCGTC+rgwf81vjyJXZ04eNBkPQ12zkgFsv3SytIpRf86IZwf/GCeK3ESF5k4n4TOMa31v0cDfBWH4KvJYYtMQGVXe7Ie4Pr8IPsN/8kYk0rE3oDr7Bu2t1dte3tZrUNqp26QMInm6lw5jrh2f3+teFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S22TlI72tl9W+5oLOB8xbCsxnL1/CvyLahbJH5qBynI=;
 b=gCZnGMNu/tEM4lt/vtHzRbI45sWbyGvDLHTb/WJU4qJusKM1tvQzpDNThQ2PbcrJGFHG3g6/YYQh/d/Isku4y3XKBXC4L7EyCAwr1Ze6ng9yedvndXYxIhLaWUphn36HgoNQX3znFv+92kHxYpfEw3eBMfsM7UTJkT4l4AcqvHg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 14:18:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 14:18:54 +0000
Message-ID: <3840cd26-2fc7-4547-b5a2-ffaa45dddcdc@amd.com>
Date: Fri, 20 Nov 2026 15:18:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] drm/amdgpu/vm: stop using amdgpu_bo_fence
To: Benjamin Cheng <benjamin.cheng@amd.com>, sashiko-reviews@lists.linux.dev, 
 amd-gfx@lists.freedesktop.org
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-5-benjamin.cheng@amd.com>
 <sashiko-outbox-223337@kernel.org>
 <3a26430c-c8b1-4df1-a5dc-eb699a0fdd98@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <3a26430c-c8b1-4df1-a5dc-eb699a0fdd98@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9852b7-19c7-43e0-431e-08df471134d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|261021123027099003|10067099003|11063799006|56012099006|4143699003|261028144727099003|261102123227099003|261021121427099003|261026140227099003|261022105027099003|261026121527099003|261009223327099003|261009223027099003|261009221727099003|22082099003|18002099003|261009221227099003|261009220027099003;
X-Microsoft-Antispam-Message-Info: cSEkysw3HOneyZIstEZDVN70rpQtw23nd3Q9lX9qFQjMMfC3o8XmVad8ZHV7NeNMQE+bMm1F8/DD5wuYq3OXJXKkJRHzcVH5JsWAm9SRU1MUGayRBOzt3bk/iDOClH2vV3EXgB6eJvqFFiKb/owdmfmX3QgZXbtN0ZyCC4wHU7HIYXVogKtYoeBLP6UewZGyrqO3kI22tacTTeCCXkjlg3HJ2HARNX3m/6pevqDOWLRmaUgSXpPwnlBZxMY2mVxc+QZ28weFWNYXfoN4ZdS3+hfw5m+yQZqJrshPuBo+ZyIcAHMpgBqfZzhwjnQYsq145FjuYg5J+YhK9KQiKAPlSRcnXLFhTfQrEL2mLt5RwMbT5KpiwjEOAaNwJ3RbVuCD+esAibbbLYKFM/xPc7OG3Qgu+NkLKBmoFokUMTgJdmIF/NoRZa0oDDOOqpf95PZAAePG0I6fFylRvM5GDnTaciKTiFmsd3cPH1o9FJQlMDEA6Sp1wRWBrWsO6tMBMkYf3Yw/xhsT4zU6DEsAZbOuVDij1w/9W8xAoLjCemjlrtC0GN8oQX7p41/wEgwcPqb1W0DXOqQq8EnYamU7GkBybxk2b7JK2x26SmlBcDLoY5OCGicWEIge4bZXEboFbc4YOv95QaBQh0OrxeU0ll3d3BDXz31ZpO3MdF1TbAtSNuc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(261021123027099003)(10067099003)(11063799006)(56012099006)(4143699003)(261028144727099003)(261102123227099003)(261021121427099003)(261026140227099003)(261022105027099003)(261026121527099003)(261009223327099003)(261009223027099003)(261009221727099003)(22082099003)(18002099003)(261009221227099003)(261009220027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjFZRm0zcHNkY3FXVmh5QzFDSXJxSGtzNFVvbUdxZUd5UE1lMDV5NVh1anpr?=
 =?utf-8?B?eXBrR0k0dTdFcjEvVytlVm5oTEE3aXEwV0RnYXJaT3c1WTdIVXVuemF1blVK?=
 =?utf-8?B?dWp1WTZFQ2RFakg4L3FLbGluY2tpNXdwQ2RtMDlqcnhGUkJyT0l3dDZGUlVs?=
 =?utf-8?B?M0cxcnNLSjFXYS8zVzRmM3ZNbXpEOGdaVlJmaDUrYkp4OW1PYlB0YTZGMnZx?=
 =?utf-8?B?Mm1CZGZvZ0QzSmxiWmZMNENyM3FncUxlMnBsV25ORW5kOHJMcnk1Ny9MTDJQ?=
 =?utf-8?B?M0hZNkNmbWZ0aDkvaURPZVhmRmNpby8xMlhGWUxZaDNHUGtJbGo3a1dRVm1H?=
 =?utf-8?B?eHkzUmo1UEFScXlRcnZsNytuakVIM0NFYkNtbklMSjN0cStmekFnbHgyUE55?=
 =?utf-8?B?Y1owdG5DQUdMejlSSVRMZUlKRzZZZm1Ld1ZtS0NPTHdzNjFlajJUZVlSdGNs?=
 =?utf-8?B?c1lxU1Q4SGlqS2licm5vMFpWYUdOb3NzYm42dE5OZXBidzdPZlFTOWp1eGQr?=
 =?utf-8?B?SUtFejB0bGUzOHcwU1FyakROWEx3NmV6TVVIM0x2bEs4U3RPQWxUSHJTNjVO?=
 =?utf-8?B?dWtNZEt0NXZVRTlpamwvbGtjN3kydytUaUdaK1p4eTZUMzI1N2x3L0k1UFh5?=
 =?utf-8?B?VVJkVE9xazliVlRLdDRkQk1vSnFwTDlsRmQwWDBBT0Zuby9XNmZSTHZUclJn?=
 =?utf-8?B?NFZJUHlMeEFLWjlsTXhMbndQaVZEYXoxd3BUdmJPUkZMS3BGdGNaS1YzbDNl?=
 =?utf-8?B?WlBFcStLZTJ6S2dXQWFTRHRwOEpoMXpSSldhVGhmV1BON3JFbjJoRXAxMUZC?=
 =?utf-8?B?UGNGQnNnc3owRTgvWnhSSW10bWtNYUh1cGc5SEROTGhOZlBETi9EQ2graVN5?=
 =?utf-8?B?bndQM3k5ZU5IeWh6cTRJWGRFZnB5UlUvSy9ndFY3VjM3RENTQWZuWDhQV2Y3?=
 =?utf-8?B?ck16bjc5b0hDek4wZlZwK09sc2R4amg1WHpFTkNQUGptWW81Wit1bWFsV0pq?=
 =?utf-8?B?M1FKdUdyQTlTV1dhb1ExRSswTjJxQ1l4SmJ6Wk1SSFlnbDV5M0M5QXJjSm1t?=
 =?utf-8?B?a0RYVTd6Nng4ZUN0MTNLWHgzcHF2RXp4Yk9WOVlsYnIzQ2YyZzA3RW5RdUNo?=
 =?utf-8?B?N3ppRlVqUzJaOFNkK1VvZ0Fid0JQNHBTVTRMZnBiSTBhZUp1dkpDKzNOQUVU?=
 =?utf-8?B?cjM5VjFiam8xYnVHUTlvYXNobVZ1bGxKVmlKN3BSOXZvV3RxTWEyZS9la0Jj?=
 =?utf-8?B?eVZKRm5RTzNkSHd3aE12ZTdvVmpqb3phZ0NmV1laUnRHM2lXaSs1cXlacTBG?=
 =?utf-8?B?SEZmZnRlSjQwVjBjS0hVYVBnUzRweUlVZll4UTlDaHB1VDRhRzE2RWFiaWV3?=
 =?utf-8?B?ZCtsRjZNanNwa2Y2U0dSaHMzN25PR0F2TGh6NThXUjhpeGpOeFBYOTJoWU9K?=
 =?utf-8?B?dGh3bEdoR09pamw4SjVVbFQzNUplREFzUkV6VVhhMVBsZ3dOcGtsWHppbnJI?=
 =?utf-8?B?amV0dHdFK2dML1FzV3ZYTWdmRjRHNW04UGMxWExFeWRhV1RyK2R3RXJ5Rk1k?=
 =?utf-8?B?d05GNXJGUlRHRGFERG1tUjJKZVZqdnkvYXZSZTBTekE4eFY2d1locDc3bTMw?=
 =?utf-8?B?aUIxK0ZXSGU1MzltUlltM3FOK0xuWmRSVHlBYTFNMWs5elpua1I3cnltU08x?=
 =?utf-8?B?cEhLZDQrMGdSVjJQT2lyTkhoWDJUV251aUo1UDZXUXQ2K3hDN1UwaGl1RHRu?=
 =?utf-8?B?TVVVQ01qSS85YzNaMmNWdm14WFZVRHc4bmJYUlhVS096SWxqMjVuVGd0c0Rh?=
 =?utf-8?B?RXcvcHVmVUxMcnk4S201c04yVzZJSC9TY0pkcTZDNThablJ1UTlkTEJ6ZFBD?=
 =?utf-8?B?V3JmUHlkSVFKTWVQTmdqcTYxazRGU29qbHppRGZRTDU2OE5aQ0EwaFY4MndS?=
 =?utf-8?B?WG9BcEpYZGYyRFBodWFlWml2K1hBNkpQMEFHanBjdGxXVVFtc2FBRktyTkxD?=
 =?utf-8?B?KzdHcGt1SnBIK211QjRPb1lmS3dZKzlDdnF1c216cWQrd3BPOFlPRGRuNnNl?=
 =?utf-8?B?dGU3a0IxT1lCdWR3dktjc29OelEzbGQ4Tk1ZNnVQY25uMncxVWJWYTlVSTNI?=
 =?utf-8?B?b3Z4RGJHeStkOHJ4dGp4T2NNOWZFRHlQR01vbHJhMk5VWURXRmtZbnRqN2dH?=
 =?utf-8?B?dEp4aUNhWEt5YXdYY2t6SU1PajdwcGFXb0NYQlU0WUtYbEZkT092RGlLOWZq?=
 =?utf-8?B?M1QyeWpNKzRsVEsvR0hHcWxtN1NsaUtTMlhYSmNCa1Q0VEJoaUdOdHU1ZWxo?=
 =?utf-8?Q?yZ+PSYwr6FBrE0PFEa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9852b7-19c7-43e0-431e-08df471134d5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 14:18:53.9135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90nn2sA5tQqH1zV53jcTPrZKqTNhVDMCQyUBf1/Js1pwTySDEBW0BTVs7jYB93Ya
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 15:08, Benjamin Cheng wrote:
> On 2026-11-19 10:04, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue to consider:
>> - [High] drm/amdgpu/vm: unreserved fence slot usage in
>>   amdgpu_vm_update_range()
>> --
>>
>> commit 62a2ba953c5e8b9b18301c84fc57052868fd3e60
>> Author: Benjamin Cheng <benjamin.cheng@amd.com>
>>
>> drm/amdgpu/vm: stop using amdgpu_bo_fence
>>
>> This commit replaces the amdgpu_bo_fence() call in amdgpu_vm_update_range()
>> with a direct dma_resv_add_fence() call using DMA_RESV_USAGE_BOOKKEEP.
>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index a0e6bb34ae0be..d4d8cb15ffd38 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1215,7 +1215,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>  	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
>>>  		struct dma_fence *tmp = dma_fence_get_stub();
>>>  
>>> -		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
>>> +		dma_resv_add_fence(vm->root.bo->tbo.base.resv, vm->last_unlocked,
>>> +				   DMA_RESV_USAGE_BOOKKEEP);
>>>  		swap(vm->last_unlocked, tmp);
>>>  		dma_fence_put(tmp);
>>>  	}
>> [Severity: High]
>> Can this dma_resv_add_fence() call consume an unreserved fence slot and
>> hit BUG_ON(fobj->num_fences >= fobj->max_fences) when vm->root.bo already
>> holds a newer fence from vm->delayed?
>>
>> Callers such as amdgpu_vm_lock_pd() and amdgpu_dma_buf_move_notify()
>> reserve only two fence slots for VM updates (one for vm->delayed and one
>> for the TLB flush fence), relying on vm->last_unlocked and locked SDMA
>> commits sharing the vm->delayed slot.  However, dma_resv_add_fence() only
>> replaces an unsignaled same-context slot when
>> dma_fence_is_later_or_same(fence, old) is true.
> 
> Hi Christian,
> 
> I think this edge-case deserves to be fixed in dma_resv_add_fence() right?

That's not an issue in the first place.

> I don't see any reason we need to add another fence to the resv if it already has a fence from the same context that is later-or-same and same-or-stronger usage.

Maybe, but we shouldn't add fences out of order without allocating an extra slot. The point is rather what the AI claims as problem is nonsense.

The last_unlocked fence is either the signaled stub fence in which case it won't be added or a unlocked update which is after the last update already added and before the update we want to create now.

So all fences from the same context are still added in order, but the AI doesn't seem to understand that.

Regards,
christian.

> 
> Thanks,
> 
> Ben
> 
> 
>> An unlocked update on vm->delayed can leave vm->last_unlocked with a
>> seqno older than the fence already in vm->root.bo->tbo.base.resv:
>>
>> CPU0 (locked update)              CPU1 (SVM MMU notifier)
>> amdgpu_vm_update_range()
>>   /* checks vm->last_unlocked */
>>   amdgpu_vm_ptes_update()
>>     amdgpu_vm_pt_alloc()
>>       amdgpu_vm_end_critical()
>>                                   svm_range_unmap_from_gpu()
>>                                     amdgpu_vm_update_range(unlocked=true)
>>                                       /* submits seqno N on vm->delayed */
>>                                       /* vm->last_unlocked = seqno N */
>>       amdgpu_vm_begin_critical()
>>   /* submits seqno N+1 on vm->delayed */
>>   /* adds seqno N+1 to vm->root.bo */
>>
>> amdgpu_vm_update_range()
>>   dma_resv_add_fence(..., vm->last_unlocked, ...)
>>     /* seqno N < seqno N+1: allocates a new slot */
>>     BUG_ON(fobj->num_fences >= fobj->max_fences)
>>
>> The same ordering can occur when an unlocked update sets
>> vm->last_unlocked before amdgpu_vm_update_pdes(), which submits on
>> vm->delayed and adds its fence to vm->root.bo without flushing
>> vm->last_unlocked.
>>

