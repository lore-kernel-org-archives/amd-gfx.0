Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4172CCD6E55
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 14:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8E191133FE;
	Mon,  1 Jun 2026 14:29:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B+3YIleW";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2CE1133FE
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 14:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxPCBQcsyJgNRdYNrEYiQ2ZFSWZ3JQTWMUbAll5WkeOlVT0YbqIxTeTxwfwbES3qpggyDws43pnOck3T3tOIbl5whXVwauV2a+LPySCLc8MjZmfL5LB1jzAAaYyAzCSd1URfSCTAbN5Ec+yeN0eDvGqDc+KxoSpVyhyiUzCHmaeoAcc5zsnPH9ah9C3vMrnwKZ3W5hQJqhMtLEjTvMaf49R5Qem5mxlCKw4O6Pb+UpN2xPvm7Sk2eR+97xhGLXbBtqPWo0x8+g63FU/gnHCnIlaZkPGUAfNrWsEt09rIcNEAPOhUI9QGh3O0XiN887cvT2PVogZSGoLMCeL9Xr32sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpJj+oTDIzSKFcnBGT3HHNBcs/QtCcnqxvur0PoU/XY=;
 b=HvKuSeGymJHvxQExjgEU7bIDubdHt6Ke6V+Sbs85O9MFf1Ga0tnqkskECnWaenkUauA5kZw4sISWLv06w49aRTyFNrtawURVkhlVRBFQaP49djblfx1ZMA40nkP3k6z85bbToB1YNAZr7RG0vuaSSJ+jFTK8vMItL8vblU/DH8yXjhOfWCiZEsL8gWc0mdFTs4MklBGlArdVFKaM9sd5GRNNIyB60DZrHoJSO0AZctReYItnDOJ8QVM1tcngO7ABvluZCqKFvtZfYk7/rAMpQ/aS5GUP7bTWxZ/2FGbpAfzYZpAxsOSqgBrzomt7JOVhL4gOqkwMB1sIO6ipSpDWSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpJj+oTDIzSKFcnBGT3HHNBcs/QtCcnqxvur0PoU/XY=;
 b=B+3YIleWsOjg8IzJHnurIK7qiXyRVev3/3YW0yjuvLhuDYh8Skrt24cVDhtodsxeLnCNWmTm0cJuIbLPJY4ulyX4nYnP44Q1Hz7CzxSXuz2Qm+4xudNnVc14hhdjYKg/Zhm94CHSiCDa6CqIbl0L0xWF1eeYDo1nJC+LE1dBIao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7101.namprd12.prod.outlook.com (2603:10b6:806:29d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 14:29:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 14:29:18 +0000
Message-ID: <8d0c2203-d585-45e7-bbf0-be3885186ff4@amd.com>
Date: Mon, 1 Jun 2026 16:29:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [V2] drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 "Huang, Honglei1" <honghuan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Vitaly.Prosyak@amd.com,
 Jenny-Jing.Liu@amd.com
References: <20260529073544.614561-1-honghuan@amd.com>
 <5296dedf-df7f-43ca-9987-6e314fd90073@amd.com>
 <59558fba-db1f-4163-9e55-bd306112f0f2@amd.com>
 <365bf4c3-9c6e-4fd4-99e0-32094cb37847@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <365bf4c3-9c6e-4fd4-99e0-32094cb37847@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 538fc47d-c08d-4fb0-79cb-08debfea2a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|4143699003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: kv152XxAHR8zulGsQevSj4hI99seo4J8OS0vGPaGUnpy6Iqrv6gPqcn5NONfhk0KD/wxXeTLZvYkQw4SjdlMNz9xBLYaJyzU/OVGbdoU+6o7BvoChRycuEkVeDTMEFpKgaOpWJx+lMYq4WnKk8x8gVQ+XGMUkfX/eaHduZ/FU/cJjsNrF9tOsWAkW24eVf0f8J7lFq7CCqi0i0HKoxpP58lLWTeQK9bzzcoyYshSmvAg9mAEChE3oc45bCZeW1gyvp5YRSiFdlMAd0FZewE+OEiWsbyyYg2N9gPha1G7Xj7mOULsFyS5ogbxMBB588Qd3cxmgOI82DD+cBEUyQarXmZJzlNgUyfeLYQZ9h6QtS50zAFTVf9c30dLT2xuXzdXPapIMPw6bFOW40SZmUeHKAvFFnC9uuo7XHMXqbsCYzVjz8K3ZnzWOoUdy6QGOTs5ELur2LoMUH6ReyRD1TPJUWWkjj2iHkEoUt3vh+dMl6pjFdOiLGqnpN+Tbjx+K5+IeOrpRLJfivkTWujzSAZdy5xpXW7E4MjWezvSDPjUelaHzI3mCkJcdEcc4vRL5zMYjZwXW2IhbCUy5sXAQrcAu9X6lhU5BEq5DxfqxhWLzmo/nmxc7U2DlU16OF+uYqwWY9sgibhJjKBlO+C1JAik7/8/EpxPwvyC8JH47/SArVT7jkCPVwqL6M1YggmYpM5mDV1hoSUj0fD8nXGHpgPk8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(4143699003)(56012099006)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGkyQldzL0I2bVowTVFWMGRobm9WazU2N29ZbS9ab0c1TTZ3d05iWG1EbGdM?=
 =?utf-8?B?MTRIeXE3Y2lXQ0M3MkFJSWY3TFJ2WTFhbm1ac1ViMW5sSkJocWdGQXVsQ05r?=
 =?utf-8?B?ZFRzZWNoTW4vcFNqeU04bTFpTHhadCszamJ5T0U1Z1dIdlhLVU5oUkxhVkts?=
 =?utf-8?B?UldtRmFlN0hOcUtzZXlmSDBESm1mRzF0QWlIUkRrVlg5a2RHdUZoLzB2Qkor?=
 =?utf-8?B?OXQ0Q3A3RS9pVnFWSXRSSk9RcnBiUHE1dEpSOGQ2TDZYWGVCSGRXUWRZVTlz?=
 =?utf-8?B?RU1sbFZxTFIxTmpDOTVsVGtPeDJqR1dSajkwbDM2UUJDdlNKZ0NFYnkyVW1s?=
 =?utf-8?B?L1BKN2l1Z0dMT0hUMFUzUnZjTDZ1TCtZL21JZjZZdC9pdmNKQmRUb3JnYjBB?=
 =?utf-8?B?Z2lnS1phS1A4MVFSWVVDcm1mWVlkRm5xQnFBRWRvWXYzQzEwOGt1SzZTVDZl?=
 =?utf-8?B?ejFabldEZDlyMktobkMxNkNJa29tTHpkMmYyWk9PYzYybCtOVkY5TlpESWpH?=
 =?utf-8?B?K2VLeUV0aHAxdW1RVktJZGFBZHVXVk4wWDNnM08yRDNEQWRvTjNZbUY3M0Mr?=
 =?utf-8?B?YjdtZkxzYmxKbVpLeUQ2ckJmc091NXJJZ2NEdVBqc3Jva0FzcVVaQjhnbmlQ?=
 =?utf-8?B?OTVTWGM5VkxnN1JobUhOMDFjM2EyK0t5WHVaTHJUMWlTL01pSlZIemdFNFo3?=
 =?utf-8?B?ZmIrQVBIZU53eXZ6VWJBaUFzcGRORWg3Qmw1M1Y5ZWNCd0hESWkrRmVOaUxh?=
 =?utf-8?B?a3FFWFFnRlFCbUIrS3FpQnRwdm0wbnh1VUZlRmc0RUluQXV1STJzV0k2TG9P?=
 =?utf-8?B?c25SK2dRT0pFRHlMMkJNQ3FhSTROdWJkdUdOd1dBUUxqL2hJaVdkNkM0WTFV?=
 =?utf-8?B?d1R6bkhvd2FOS3hxNTdXY2dVK090WW5UM3hpamtWYjhHUkVzeHVvcGxHZlpQ?=
 =?utf-8?B?TkdjcWpXYUVzdUxMREE1V2N1aEJGUDl2WnNNYXpRdkJtaVlKa0s3bks5YXFU?=
 =?utf-8?B?dU82YXVQUWduWndaZ2ZFWUYxSFN3T0JvNE5XUWNnNGVFRDByYVUweWJEQ0Er?=
 =?utf-8?B?SDdJSXJrY0VIcHQ5QWkyOTlIT0x0Zml1TC9PUXEwdm1wWHNRR1NmUjU4TDhB?=
 =?utf-8?B?bThrZ0cwMlpxNFFhSmdMcXNndmg5OHJJdU5PenA0RURXekFJcDVwTmhwUWpu?=
 =?utf-8?B?Q25OM2dFNEw2MkMyWWI0WEJLVlVaVnJqQkF0NFZ0REtBNmFPVU1RSGxwUExt?=
 =?utf-8?B?VC80TndPMUlWNWRjbGpicVRLSDU2NEtLQXh4WEpCbkttSlVlMjNNUWVGVzVK?=
 =?utf-8?B?U3lNME9ad3plMWd6U2ZhQkhqeDZqZnhRd1BrVEplTW4vYzZLTTlXQWhQRnNT?=
 =?utf-8?B?dXJidTNIWDQ1SHQ4SEpOVWcxR0I3VEpla242MzMrZDVsNEovZVh5ZEE5S2RV?=
 =?utf-8?B?QUpXUkRycGhnMUFqQ3BxWitCOURyWWZ6cHl0WVp0NEJzNzl5elk4N0VQczhX?=
 =?utf-8?B?TU1veVI1YzJwQS9nc3R6b2NzYnBFc25uUmFsMW9BekJ0M0VxYjFNVnM3Rm9F?=
 =?utf-8?B?bitxOG11QUZmNm1Sd1ErS0hxT3lpbERGNmJ2VmRnYlRoRFN5S2d4M25hTjR6?=
 =?utf-8?B?Z0U0S1F2L1VPbERNODVScWZZczF5dXZSWW5hOFlUSFBKbmlrbkRQV1M5bmFp?=
 =?utf-8?B?WHN4WkpFbUM2NDhNNzVTZVJnL0U4ck5VMVdzbFgxWTdXbjJ4OWlNbWRKcW13?=
 =?utf-8?B?OHM5QWZidmFhUE51K2pldGlrRjNRNXo3N2RVeWZEMkJXVldRekkxVlJGNmdK?=
 =?utf-8?B?RjR0MGdET2lpcFE5ZkFUTGd3TFBXYlh0VjRGdXZaNCtHVlhoTHlPN083RjBW?=
 =?utf-8?B?Q0xiM0RIY2hmZzFscnhWbVRkcnJEWm9STDJFa0JmWGIxWVFDdjZGTVpaK3gw?=
 =?utf-8?B?UHpPbmRJNEJidXZUNUpua21UaW94c29QTnJ6OTR2YkRHaHU4eWpaL3d4cnBL?=
 =?utf-8?B?VU9CUUJPbGErS1FaVktyNE1iWE5OUmFIakI4dUViQXRrV1NURFoyaUNmdTQ0?=
 =?utf-8?B?T1gvVHMzbG1rSUtyck5RdTlwd1ZOZmdkU1RmZkx0ekI5eFZ3ckl4MVN2VXkx?=
 =?utf-8?B?V2Zhb2ZuQW1HOHVVdTFTbnNKSEN5QnJWaTZRQlNYcFF6NC81aTVTOXJJZEdl?=
 =?utf-8?B?WU1xdm0vYVYzOVFaeU1hV0JkNXFjanQvTmNndVl4M2xPbnd6NXFtWnpHdTVr?=
 =?utf-8?B?azhWSHEzUDR1bWk5VkN2Wm5ab3ROajhtV3dhQjNLOHl0RTdBampPVG83RFc1?=
 =?utf-8?Q?anaZCGz3C6VcdQc+cx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538fc47d-c08d-4fb0-79cb-08debfea2a19
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 14:29:18.5492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQAav90mZ9v/UOXhOje71ltlCBU3w6aF0al6N9ufBtQ8yOfwlq5M4elZ4S3/wp+4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7101
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

On 6/1/26 16:20, Chen, Xiaogang wrote:
> 
> On 5/31/2026 9:40 PM, Huang, Honglei1 wrote:
>>
>>
>> On 5/30/2026 2:35 AM, Chen, Xiaogang wrote:
>>>
>>> On 5/29/2026 2:35 AM, Honglei Huang wrote:
>>>> Since commit 144ba981783f ("drm/amdgpu: fix amdgpu_hmm_range_get_pages")
>>>> moved mmu_interval_read_begin() out of the per-chunk loop, the
>>>> captured notifier_seq is no longer refreshed across retries. As a
>>>> result, the existing -EBUSY retry path can never make progress:
>>> "retry" should come with mmu_interval_read_begin. The commit 144ba981783f move mmu_interval_read_begin out of loop, then "retry" should also be moved out loop with mmu_interval_read_begin.
>>>>    hmm_range_fault() returns -EBUSY only when
>>>>    mmu_interval_check_retry(notifier, notifier_seq) reports that the
>>>>    sequence is stale. Once the sequence has advanced, the stored seq
>>>>    will never match again, so every subsequent call within the same
>>>>    invocation returns -EBUSY immediately.
>>>>
>>>> The "goto retry" therefore degenerates into a busy spin that simply
>>>> burns CPU for the full HMM_RANGE_DEFAULT_TIMEOUT (~1s) window before
>>>> finally bailing out with -EAGAIN. This is pure latency with no chance
>>>> of recovery, and it actively hurts the KFD userptr stack: the caller
>>>> ends up blocked for a second while holding mmap_lock, only to return
>>>> -EAGAIN to the restore worker (or to userspace) which would have
>>>> re-driven the operation immediately anyway.
>>>>
>>>> Drop the retry/timeout entirely and let -EBUSY propagate straight to
>>>> out_free_pfns, where it is already translated to -EAGAIN. Recovery is
>>>> handled at a higher level: the KFD restore_userptr_worker reschedules
>>>> itself, and the userptr ioctl path returns -EAGAIN to userspace.
>>>>
>>>> No functional regression: the previous behaviour on -EBUSY was already
>>>> to fail with -EAGAIN after a 1s stall; we just skip the stall.
>>>>
>>>> Reviewed-by: Christian König<christian.koenig@amd.com>
>>>> Signed-off-by: Honglei Huang<honghuan@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 9 +--------
>>>>   1 file changed, 1 insertion(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>> index 5d72878c8..229c30867 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>> @@ -172,7 +172,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>>>       const u64 max_bytes = SZ_2G;
>>>>         struct hmm_range *hmm_range = &range->hmm_range;
>>>> -    unsigned long timeout;
>>>>       unsigned long *pfns;
>>>>       unsigned long end;
>>>>       int r;
>>>> @@ -199,15 +198,9 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>>>           pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
>>>>               hmm_range->start, hmm_range->end);
>>>>   -        timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>>>> -
>>>> -retry:
>>> If you remove "retry" here the callers including user space need to redo the thing. This function's work is memory validation. It should do that in its best before return to caller.
>>>
>>> If user space is the caller there would be a lot of user space from/to kernel space context switches. That will make the procedure even slower.
>>>
>>> I think we need keep "retry" inside this function, but move "retry" out of loop at mmu_interval_read_begin.
>>
>> This option has been discussed in previous:https://lore.kernel.org/amd-gfx/a8ded005-e2d8-4163-be35-f1b018cefe74@amd.com/#:~:text=%3E%3E%20What%20probably%20needs%20to%20happen%20is%20that%20we%20need%20to%20move%20the%20retry%20label%20or%20just%20completely%20stop%20retrying%20at%20all.
>>
>> Why drop the retry here is because to keep the behavior unchanged, the current code logic will always return -EBUSY when goto retry path (pages change when get pages).
> It is a regression introduced by  commit 144ba981783f. Why not do "the retry need to be moved to the start of do while loop, the entire fault path need to be done again"? It is same as I said here.

Retrying here is fundamentally wrong approach. Ideally a page fault retry should go all the way to userspace again so that we can eventually even handle signals and spend a couple of extra cycles doing something else than trying to hammer on the page tables.

>>
>> And there is a scenario of extreme conditions where a huge system buffer attempts to use this function, causing the function to retry indefinitely, for example, with a space of 60G, it will always gets retry again and again.
> 
> Having callers decide to do "retry" does not fix this problem. The callers have no idea what is going on inside low level code. This function(amdgpu_hmm_range_get_pages) knows more than callers, then better to let it make "retry" decision, ex: if amdgpu_hmm_range_get_pages has retried more than preset number of times or lasted more than preset time it can abort and return error.
> 
> If user space is the caller there will be a lot of user/kernel space context switches in the scenario you mentioned. That people want to avoid.

No, that overhead is wanted. It is actually intentional to go all the way back to userspace and re-try.

Regards,
Christian.

> 
> Removing "retry" from amdgpu_hmm_range_get_pages does not help since callers have to decide whether do "retry", but callers have no idea what happened, also it has performance penalty.
> 
> Regards
> 
> Xiaogang
> 
>>
>> Maybe it is about the overall architecture, the set of hmm function in amdgpu needs to be size limited or it needs to be cut into smaller pieces if the interval specified by the user is too large.
>>
>> Regards,
>> Honglei
>>
>>
>>>
>>> Regards
>>> Xiaogang
>>>
>>>>           r = hmm_range_fault(hmm_range);
>>>> -        if (unlikely(r)) {
>>>> -            if (r == -EBUSY && !time_after(jiffies, timeout))
>>>> -                goto retry;
>>>> +        if (unlikely(r))
>>>>               goto out_free_pfns;
>>>> -        }
>>>>             if (hmm_range->end == end)
>>>>               break;
>>

