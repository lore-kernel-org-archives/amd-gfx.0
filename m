Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CB1606A320
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=r3nB148m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB9B310E8F6;
	Fri, 20 Nov 2026 14:47:25 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013069.outbound.protection.outlook.com
 [40.93.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E8B510E90B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 14:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZOPNY6MPqcsmPNUgwG6BQMr6noa3fbdYLTAUmjg/sI7/hX5+asCufHj5GnVDxI27cMUblvJz7/WHtKdwqCddJxhjLIiR5uynQtNJ0dHZTkCFtFBAtEQGxYi02p7Iq8BaZL863SVTEob2FOUKkbvnXkH476Vv0yjoa9n2BPcrV5TYYwekpUb3Lvecxp3u3xlB3fgptit/UfXwTi/e2fMNdAQtPXL/ao+4ZVGYlppKJrQ11aVFWXbLyGlqDrn/dVuiEQ5JfQWh82uEpcY9hVL4d92Cw1xwQ90lotDoOcqjnUtfZDSNRrSQXTzBjIUnhWAVntW5wk230kdQ/jmNwe+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBQeBVlpEkwzBD2nfstGlfjMlV0dcHrZh0zjLGtemXk=;
 b=xJrp9Y7cLFk5o1k05QKzjc7JPiEe+YlWukGanVtTTR0P25XY0HdxocccetDOQzEYW68rkNRiBfmGvnC/V0aoGeBFIDsGCiGhVQj2m1rv7l+lWpKQ9NBUDfxIrYLEgRKY7M3EjmYnEKqpdNWVA42hmowOG39VctDdXo7uk21j+WaXfm0PvbaP4y8EI9c7TdmUTvjXqzkwIjWNdrUxViZSoXowxaycjWB+8AFcKWCGdm4p0JN/533KaR1C9Jx1FuWHL+VPIa9Ydw05JhsBa9lR+HpJsXNF5urAwPPjBjfgyOTLJSyMw0XjHCnvG6pbKD74TnICHyaGLeOgLyI6D5vcvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBQeBVlpEkwzBD2nfstGlfjMlV0dcHrZh0zjLGtemXk=;
 b=r3nB148miM6IvSlk1oqJSYljx9p2i85Mb0oPQEK8Q92jR5Yk1nyJLk4QrcXIT8GtqQLEGZHTxTnaHk4Rs6jbxBlcR5hFkR0jr3kkuMNLDDZMfGaaxcX3kA2hy75MFdVjKdlcrvbkHUTgCsk+Kwg0yIRG1DAFDzcMVFduLS50wDY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 14:47:16 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%6]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 14:47:16 +0000
Message-ID: <2e609df4-d7be-43ed-ae75-3857cf591885@amd.com>
Date: Fri, 20 Nov 2026 09:47:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] drm/amdgpu/vm: stop using amdgpu_bo_fence
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 sashiko-reviews@lists.linux.dev, amd-gfx@lists.freedesktop.org
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-5-benjamin.cheng@amd.com>
 <sashiko-outbox-223337@kernel.org>
 <3a26430c-c8b1-4df1-a5dc-eb699a0fdd98@amd.com>
 <3840cd26-2fc7-4547-b5a2-ffaa45dddcdc@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <3840cd26-2fc7-4547-b5a2-ffaa45dddcdc@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0166.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::28) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 64dfb651-8c18-4790-3b40-08df47152b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261022105027099003|10067099003|4143699003|11063799006|56012099006|261009221227099003|261009223027099003|261009223327099003|261102123227099003|261009220027099003|261021123027099003|261021121427099003|261009221727099003|261028144727099003|261026140227099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WJ3YMZY6Q5KKhYdeTDeogRCS/sLftk1EqrZcXfc/0kfxUpTO+Nl93jNXBwhJUDOyywBABOye/+17v6PJBabxWvs1Y+ZdTNE8rVs4MOS+NBCzA+Pl6q2Dfp8ZWTgub10KoWM9ZNoAv0+CdOrHVlbod/15526bl8SEOFhUWJTHJ7RAtDrDt2ZprSyTaoAVT/vmqFKPdlO9cNwK4s+kK4jPD23H3PYe4nNWp4ouwZyk9hrOJLWc9GdHyoFrcDa3pAgAvHOalznmp9RQc5WuiyvNnBNnP6vm+qNoczbiOtOKbPtgzvetNjPmYOUKK1jHFmKb5x7doffQIqjEXYg/y50hbogqgJ14X34PzTwQhjiTsTwbMC70KdFkfh5yPcMF3l9RoioHX8EMxsqN6MGzEZ92Lh3rgV+NQMKAdGJt+FmkwelpB9UuLeMnmoL8/2lcqhoME42m2vvUys7F3aCkBxYqQAE4K9XIaeizr9ORw0fkGB96ifWuwA6prWK4oYyV7H/g8+Sfl4zemVunDoQL1L7kKIFZz0g2vSI3m6NZN1zU4BKryuzQ9Ml5K9ypi/ZQ29R9iy/uBp6D+5gJ9tlQn8IRPB+Tujv3CLLHX5VLMpwWUI4DYigwE7ZKH9mXxFmuVpuhxvVd9IQL5KjOQJROYv5qiV5vRwJ95XLeeLYxxIBOG10=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261022105027099003)(10067099003)(4143699003)(11063799006)(56012099006)(261009221227099003)(261009223027099003)(261009223327099003)(261102123227099003)(261009220027099003)(261021123027099003)(261021121427099003)(261009221727099003)(261028144727099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHdlTnBHTmdFanpzNVhhN1prK0RtSUN2ZTRyWmo0VFoybmNBTzZuS25JOE9l?=
 =?utf-8?B?RzlUdFU3SUQwVW4yTmFaVE53d1VVYUEvRjAwdG5FUWtKdW1oUWpzRlRjMmVt?=
 =?utf-8?B?N3ZNWWh0cWlxY2t0NnY0SHYwWGdlT1BaVFRlaXQ5L2dvTjZ5a3hLRVdlYVJG?=
 =?utf-8?B?QmJqRXFCdXJlbmk3Z0hlVWwvd0VNQitjemZ2SDhidXU2VG1CY1d0UW1DeUJi?=
 =?utf-8?B?Zzk4c0w5WUxKdHlKZVNiaGl5N3lJSWRqaTcrZW9Mc0I3U2lOSGZWcFIxWWlk?=
 =?utf-8?B?UE4rb0NqbW44VGtIUHBzRlF1MThSRkJQazR5Q3BSNlY0QnEzTmxHY2s3VGVE?=
 =?utf-8?B?bTczODFZSnNBdkhDSmVtbVY1Z3R6OHkySE50TVVxTXE0c2hycko0c3RKbzJU?=
 =?utf-8?B?bXc4bWI2MTdybmpUZy8zNXF2R0VCRHRLdDRtVFVxWjZ4VTVsa3BvVlcrNGl5?=
 =?utf-8?B?VEFVN1ErN0J6d1ZQbS9jcGgrQnJ6RjFxU2c4c2twK2t3OFFhdDFISlUxZG12?=
 =?utf-8?B?S0F5UFBDTWFSdDJKNHFDc3B0ZmR0cUJQTkVzcUhGajdEZzV4RnJxOXNUdXFz?=
 =?utf-8?B?WGJoN2J0OERwN21Vb3I5RCtXNDd0RC9qTHRXWnlFMkovOGlrS1pkSHg1T3RN?=
 =?utf-8?B?TzRIc1QwYjlPSnpWY2lNamhsMkFtNWw3VXIzRW10MzNLcXdkV2ZTZmpTeXVj?=
 =?utf-8?B?UmwvV3EyZDBWRmJVeWd0UThNc1BRbk82dTJaNHFzeGlYQlhsSjVJMEY5bytT?=
 =?utf-8?B?a3hoYnkwMlZqRU9jRFpGWmdLZ3crdTI3ZUNmWVBNSWVHZkFVNnRMWVU4Y2xX?=
 =?utf-8?B?QkoxZUhzTUFHTzFYbEptQnFaT0g1cmhQbkVFMGwvTGhtcmh0WjM2UndEeE9N?=
 =?utf-8?B?Q0FGOXdTMFpST2lUaDBoeTVDbkdzNlRKM1E2aU5rK0ZNUFNZUUV3aG9qTEli?=
 =?utf-8?B?eWNmd3FaNkh5M0pPbGswWG1OUkh6Z3lNbEdLMnVRa2U0ck9pRFV6Z0k2NGVX?=
 =?utf-8?B?ZDlWSGk2T1AxT1lFMGtsR1JZcnJyQmI2bVI5SWFrTmNUcTl2Rjd0cVVFQ3Ey?=
 =?utf-8?B?dlNpL1RYQ3dJRlVGWERqeEtORnB5ZTNJUVVFRkxYNGNiTzhPN3NrOUN6S2hx?=
 =?utf-8?B?UE5meWtpL1EzV1kzY2YvK3ZCdzYvMDhoTENoRW51WkFnVnJ3ZjUvWU9OTDNX?=
 =?utf-8?B?TmhnRVN1bnJQUjBYekRkZE95NWg2bUZtRFAveHZhQUJ5WnEwQXJvVUhmV21t?=
 =?utf-8?B?TGd5NjdOYXdnWW1WLzd2R0JnNjV4OGd4VzdEOHBEdTFjTUhvWXd2dVJEb2ky?=
 =?utf-8?B?N05nc1lhczhOeVZKWHdWNGdFMHZZSURyVThJMnpNRG1wZUVOaUVFOHpEOThz?=
 =?utf-8?B?Y2dvUkdKbnJYK0pDc25oeEd5VmFSQmpZWTZLWlFsa3NQd0M5Yjh3aFJnZE02?=
 =?utf-8?B?UjN5WTlKaDJJbEdzd0xrbzZPZVJ6bENScW4xdmhVdlBteGFjbmdLaTk5dS93?=
 =?utf-8?B?ajFyY0xIdHM1QU9UamJpemJuUnV4dGt5Vm9nclhEcmovcG5Ha0pDT0JycnMx?=
 =?utf-8?B?SFFSUER4Rzg2clkwR2JoNjB5Y1hkN1RmTWExajVGRDJ0VHY1WGZYUzU3bUFj?=
 =?utf-8?B?bVJEOWU3UXdySWNSMFBza0l5SEpibEZKRXNqSk9kRGFxQnRXYURxMEJFV1NB?=
 =?utf-8?B?M2dOWGxjWGR0dXBTSmpQcHJLd1k4TFoybUw2ckdzbkJ6UktXc2dDT2NCaUM1?=
 =?utf-8?B?VXdIRFEySDNIS1J2eTRzS1JQTWRDT01ncTFXTkx2U2wxdW41TmlNWFVEL2tk?=
 =?utf-8?B?ZjcwZ3MrK3A4TUtFU200elRCWGR4RWtrWGgyK25jL0xhQllFYjVZUUNmYjlZ?=
 =?utf-8?B?LzBxc3FJMmtaZjdadWE0VWR1TnZEUDd0amxaQXQyS3duTkhQUndkR09hV21P?=
 =?utf-8?B?NHJNQ1dJQnZDNW5wUGVsbGV3aGpnb09rcEZPbkZmZWpLVjlHMHFNVitiRmxR?=
 =?utf-8?B?QjV5R0JTa2Z1TVV4S1B1bnRxODNPMkFtY04rY0dlWk9TQ2NuWXdnUXZvN0oz?=
 =?utf-8?B?RjhqM09JMEN5YWRhb3lqVlMrNG5KZjNNaktKN3RiU0ozZEYzLy9jUDBNQ05M?=
 =?utf-8?B?VHZGNUIyMExTSG1aL2RyYm04YzZSck5YRG9YaFhyL3pHam8vT2RzZ3ZzdDRv?=
 =?utf-8?B?Qm9reUUwRFRrRzdtdXB1My9GcUlGM2U3UXRUNllQOU1yVHphMHd2Y2pSaTFR?=
 =?utf-8?B?dGRxckt3cVRHSzgrZDdKRHNWK0xzdE96bG1sa2ZhK1NlSUlPR0RoNFphQW9E?=
 =?utf-8?B?V1hvL1NqRjdaMnZkN1loS2RTOGVueG12NlI5QWowZlhOOW9uMHMxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dfb651-8c18-4790-3b40-08df47152b6b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 14:47:15.9803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5uOEo+EekrZGRCuqCjQbqKPRf/2TIYydgU57S/rJOr9E9Jy9jRtu95ROk8VxYCs8kaQPuGLx4Fo33PP8YoEfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941
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


On 2026-11-20 09:18, Christian König wrote:
> On 11/20/26 15:08, Benjamin Cheng wrote:
>> On 2026-11-19 10:04, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential
>>> issue to consider:
>>> - [High] drm/amdgpu/vm: unreserved fence slot usage in
>>>   amdgpu_vm_update_range()
>>> --
>>>
>>> commit 62a2ba953c5e8b9b18301c84fc57052868fd3e60
>>> Author: Benjamin Cheng <benjamin.cheng@amd.com>
>>>
>>> drm/amdgpu/vm: stop using amdgpu_bo_fence
>>>
>>> This commit replaces the amdgpu_bo_fence() call in amdgpu_vm_update_range()
>>> with a direct dma_resv_add_fence() call using DMA_RESV_USAGE_BOOKKEEP.
>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index a0e6bb34ae0be..d4d8cb15ffd38 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -1215,7 +1215,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>  	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
>>>>  		struct dma_fence *tmp = dma_fence_get_stub();
>>>>  
>>>> -		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
>>>> +		dma_resv_add_fence(vm->root.bo->tbo.base.resv, vm->last_unlocked,
>>>> +				   DMA_RESV_USAGE_BOOKKEEP);
>>>>  		swap(vm->last_unlocked, tmp);
>>>>  		dma_fence_put(tmp);
>>>>  	}
>>> [Severity: High]
>>> Can this dma_resv_add_fence() call consume an unreserved fence slot and
>>> hit BUG_ON(fobj->num_fences >= fobj->max_fences) when vm->root.bo already
>>> holds a newer fence from vm->delayed?
>>>
>>> Callers such as amdgpu_vm_lock_pd() and amdgpu_dma_buf_move_notify()
>>> reserve only two fence slots for VM updates (one for vm->delayed and one
>>> for the TLB flush fence), relying on vm->last_unlocked and locked SDMA
>>> commits sharing the vm->delayed slot.  However, dma_resv_add_fence() only
>>> replaces an unsignaled same-context slot when
>>> dma_fence_is_later_or_same(fence, old) is true.
>> Hi Christian,
>>
>> I think this edge-case deserves to be fixed in dma_resv_add_fence() right?
> That's not an issue in the first place.
>
>> I don't see any reason we need to add another fence to the resv if it already has a fence from the same context that is later-or-same and same-or-stronger usage.
> Maybe, but we shouldn't add fences out of order without allocating an extra slot. The point is rather what the AI claims as problem is nonsense.
>
> The last_unlocked fence is either the signaled stub fence in which case it won't be added or a unlocked update which is after the last update already added and before the update we want to create now.

Yeah, I see that now. Thanks a lot for the explanation.

> So all fences from the same context are still added in order, but the AI doesn't seem to understand that.
>
> Regards,
> christian.
>
>> Thanks,
>>
>> Ben
>>
>>
>>> An unlocked update on vm->delayed can leave vm->last_unlocked with a
>>> seqno older than the fence already in vm->root.bo->tbo.base.resv:
>>>
>>> CPU0 (locked update)              CPU1 (SVM MMU notifier)
>>> amdgpu_vm_update_range()
>>>   /* checks vm->last_unlocked */
>>>   amdgpu_vm_ptes_update()
>>>     amdgpu_vm_pt_alloc()
>>>       amdgpu_vm_end_critical()
>>>                                   svm_range_unmap_from_gpu()
>>>                                     amdgpu_vm_update_range(unlocked=true)
>>>                                       /* submits seqno N on vm->delayed */
>>>                                       /* vm->last_unlocked = seqno N */
>>>       amdgpu_vm_begin_critical()
>>>   /* submits seqno N+1 on vm->delayed */
>>>   /* adds seqno N+1 to vm->root.bo */
>>>
>>> amdgpu_vm_update_range()
>>>   dma_resv_add_fence(..., vm->last_unlocked, ...)
>>>     /* seqno N < seqno N+1: allocates a new slot */
>>>     BUG_ON(fobj->num_fences >= fobj->max_fences)
>>>
>>> The same ordering can occur when an unlocked update sets
>>> vm->last_unlocked before amdgpu_vm_update_pdes(), which submits on
>>> vm->delayed and adds its fence to vm->root.bo without flushing
>>> vm->last_unlocked.
>>>
