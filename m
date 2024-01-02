Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B594C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 16:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D1010E0CE;
	Tue,  2 Jan 2024 16:46:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DD2610E0CE
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 16:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFQ8NaTkKFZLwKgu4VdU7v1J/3qs0iwiUsNARp2NrC6NIX1ZvaX87kZlEswugSjc6/ndhbWZoI14E1MNTBnOSPkMZPSgbew487/ULw1CID8oX8pqNrcByEQBJYi6XDBI0o0mPuuWmMsM9crZOTfxgNg2fq9XWhii0XvvyxzhTmXyCQe79EvDsKIf2AKq25W7GWe4TAX2Y5DFS089QIoSRbwnvXVp2zcE2smD8r4yNB+KjYb4F3hzv+F+69mR5s1AloJW3i76NnGnO3W7XjZLxYhYPlsKtSqC1J0DvjzlhA3NmOzHw//M/KNImX+rfaXBsq7X4XayKKHU8MEJDXAu6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ft2pN95XoX4dGOzw0oriXz3tX+OEhf4WombG/OXO6rE=;
 b=gu/V7m24SPe5cegxwI1fg7/aAcronbrbog+Wogy+XpGGe7obzves4A+xbRs0GW2Iy4VtmtbqxWzpXj30U0KbP9WkxPi+Im0e8iOLNAhkB7TFfvUoXhxOziz9y34uSLaMd0AsS27Gh3hmFtmIRKI3VjNdbbcCtOo85yrOsT5uRrnrULKxyVN7Vm23915xFW3W72TXi8UkPW6HgbQFmNXyTUzFoRLOeepF52/aD5bJGJIMoG44bnzSD9suxeffWTTWHC5/VgZced043a5GJkyjC8ekx2rDLI1vy1mpYbiS3S02IwK94gOrct+ycaji31aOhjpuRHCLam/WA5zx1m3R0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ft2pN95XoX4dGOzw0oriXz3tX+OEhf4WombG/OXO6rE=;
 b=d8rZx6qTVKaCMXjnlNtdbiTaukXmCVvZgmxZhLzdJW+CmMNLhXPRTtCtQx4dqDcSHka7JbmMt9vacDModgUeM2eHiZoaw+LTE/3n53/YSvLd7oUMx+8NiwhU+JU7FMBSVoEZj81HLrH/kWhaQI5G5wm0Y9KgKmxLDlx5vCzdArY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 16:46:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7159.013; Tue, 2 Jan 2024
 16:46:16 +0000
Message-ID: <786e24cb-1bb8-44f9-aa31-f65279452e54@amd.com>
Date: Tue, 2 Jan 2024 11:46:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix lock dependency warning
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231221204004.830821-1-Felix.Kuehling@amd.com>
 <a4d70d39-4515-f1f3-ae0c-d7a4d0946db7@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <a4d70d39-4515-f1f3-ae0c-d7a4d0946db7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BY5PR12MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0ad3fe-6021-461b-c723-08dc0bb256a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sr8+6evq06VLRkfAghzrWgVIpGFPJWss6DNhNQmximv+Ya+6TERFC3ZtYHRAR61aKWQAgQww44WOFrCsdVbnFSV3jnLndtUT/ETJcaz8jT/hXcrryqvOJz4xN9LnXmPtKATn1OoWIw8yzuARIfBXffzZJHDg7ekLt9pH8AVXgRvOMnnFTgFKVlNvvRg3ch6mVDVmj2t5nQbbbiufmctEqEE40Lkvuxq6LMmMu7dX4yQ/bAuTJ7cFko9OK6jDva7I6p2+JOhXV7HCarw4u/Shko/bioNXcK4oZkXQAtOrZzlmu6tlHB39pz+4SRRulCXPxTLUML6j7e1xASOokQD0iKXMM9pI7ToGhLNLraqjxjoh2WdfjDqJg+t6ZexCL6mAr0oNrnXlRfStO3NvlUoNNY/8qqgSZyOCykucoiX+7DqHaSAvN5nA6ZZsUV/wg9C/EAWqsppVKj8bT5c5K24CYNwGED91o89XU/SHS2TP5BaJPdONwtGJfwKIoP8iwwps/zCq3hq6wApt1o1SvQShsKly1+xKIoL+etimVb5XWtwN+80dxJIVUg68nABvOJcT/lKakiW05XN4hR16bbgjf6DMvyDLJhXwOU/8e5q5ZI+c3q4HG8HHEGqBC30eXtLvGr6OaOwTR1f/jWQYc39YBe5EQkMVBHhDHHA0cdcDPwexmhxOYZvki3XsN8WACmYD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39850400004)(346002)(376002)(136003)(396003)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(64100799003)(1800799012)(4001150100001)(66899024)(478600001)(38100700002)(5660300002)(6506007)(2906002)(83380400001)(6486002)(6512007)(53546011)(41300700001)(26005)(2616005)(36916002)(316002)(86362001)(4326008)(66476007)(31696002)(36756003)(66556008)(66946007)(44832011)(8936002)(8676002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MndjdjFZZTlOb0R2UWYvL2hQanVxS2ZMN1RBSDBxMGVxYjdPL1B5dnlyZmVW?=
 =?utf-8?B?WGJ3NS9EZUVlaU45Qis0QS9MT2F0Zyt0M2JjdkZtNlpTL0IvR3dPeU94VjVT?=
 =?utf-8?B?Mm1yck5KUHhWd2dBZmFsSzRFakw2MTVXWklVZ0U2RjVDK0c3THhwM0xMR0k2?=
 =?utf-8?B?Nk1BNXQyUlNyRHk3dW50R1liRGpWTCtUcThKVXYzRU9icGF2NjRkUzdYcHF0?=
 =?utf-8?B?ejZZeGVwRDIwdkhFTkhGR25FUTJZODBLbXRnb2VHRC90bWM2ajRrWnFEc3B4?=
 =?utf-8?B?RHNVZFBTNFZzUHliY3BRc1g4SWZpdjhhN1FGU0I4Z21FMGEzbnFiek4wSTE2?=
 =?utf-8?B?NDhQMFB3dkxLbnVmOGpjNGMrL293azBtQmlwRmIxaHlocVgvUzBZVFNOOGo0?=
 =?utf-8?B?Zm9FWGIrelMrTVU1c3BPSENHOTgvWEwwWkd2bzFvQk1UaHVMYWQ3U3QvOWFr?=
 =?utf-8?B?Qkk5UkdqZEl4SjhPVDlGTDZUMkRIYlZLOWR3VFNvWFJ1bS9sRDFyYWdkdlVH?=
 =?utf-8?B?QjcydHc3ZDdvYit2d013NmIrb0h4RURxTTBMTWF5cDF5SnRpUzExNXJ1ZlM3?=
 =?utf-8?B?VnBVdUhUckF6Z3ZJYmlPaENZSjdRcU5sRE1xZTBuNEdNbU1vVi9QWlNrNHNK?=
 =?utf-8?B?KzlJVDVOTDYxK3RFblFFcHBqL2h4U3I3bElFVmJ6bG9tZlBsNmZRMjdyWHht?=
 =?utf-8?B?aWx5RWJwSEJZZUgwdy9WSmY1KzBJRmtrR1czU25uM2tzWEU3dzRrbVNrL0lj?=
 =?utf-8?B?RDFONDUxWUVIa0Z1OEQ5T0dMTGNtQndIQ2VncEU4N0t2TW1yM2N3eW0zd2h2?=
 =?utf-8?B?TGV1ZnJiQVJLZFNRMWd2RC9QMHFmTUhwTm5uOGNJdTF2NkJaRXlBOHRCUXJq?=
 =?utf-8?B?MmJ5VFZHMXFwRjFtLzBkRGJyamtHY1IwVzFoSzR0azFhK1ZDUStldUxEZnJM?=
 =?utf-8?B?cndEeTh3Y3ZnRDN5VE5KbVpZZjlKSVA0dGdGanJzSjBxNkMrSFh5YzNjdmJq?=
 =?utf-8?B?V2dsdEdDVkJYK3E5VCtsVUQ5Nkl5NC9nVkoxVXVQK3JDVjhZVXZ4c2xZYmh5?=
 =?utf-8?B?N1RqdG5oSHVhSUwzMmxtakUva2VmbTU0bFRPMkk0OEdBSlhsUlR6Tm9qSkpa?=
 =?utf-8?B?U1owME9yZTdXS1RndFFZd3ZLZnV3Qzdadm5TRVExbnVmZlRuMUJzdHJkaURZ?=
 =?utf-8?B?S1lJbVdZV2pFbktWNU5sSEVYckdKNUVPenNUNGxMN1BDaUZqWlVQQnBqYVpF?=
 =?utf-8?B?YllJeGJFa2R4RG5JV2w2MGpBNmt1NGZSOXdCb3R1VjlBQjFGaGdsQ2tjNDk1?=
 =?utf-8?B?VCs1RTB2anY1MUdjYnordVZQVnk4MEVRY3R2L2RaY0pQU1NZc2JvUlAvN1po?=
 =?utf-8?B?bWlKQWY4SW55R21GMUgxem9xcnNkZWhGcjFyL2pqK3dNeVE5YkxtTGZoWnB4?=
 =?utf-8?B?dHZtTVNJTis0bVJJNjVMbTFydWxBeTVSMWErWUVjQlo4UHZpblpLeWZKeUxS?=
 =?utf-8?B?MnIyR1pNMlg1ZDM3ZHhvQklSUWVWTEVad095Qk9rdXRlNVBiQ2kxZ0d6SnRH?=
 =?utf-8?B?Y1EyaVZ1ckcwVEdncjhaMnErVnZrdG1GZ3RlQWRKWUpMTWZlQlk3cDViSHBU?=
 =?utf-8?B?QXJKcjNtaEd5c3pBVTByVVpMaFd6bWVMRFB0dlgwNVduWTQvaTJyaU9ibk9s?=
 =?utf-8?B?dlJnM04xcDB5WHE1K1dvYkczWjVDb1dyVWhlaFJYWmlxQnc3N2lkcEVKNmVS?=
 =?utf-8?B?WmpzM0Z2Z3pEeTg0U3dNYmphRDdnR2ROa1VLSURmUXM2eTdPUjNtQWZhK21C?=
 =?utf-8?B?ZjZmVlJENkZqczIyM2RwVTFIK1kwMWlMUjZ3S0QwYTE0VW9raksvbTlTY3B5?=
 =?utf-8?B?ekEycGlKQlpSQmF6QmNnN28xSjUwRHdiWmFmNGVGWUVkb0gwVDdyTVN4RVVD?=
 =?utf-8?B?NkRDeWZCc091dWhkMlZvZGZ0M2UrN1NqaDBMaEpCOTI0ZEJEcEhEcjJkUm5h?=
 =?utf-8?B?OWd2eTV3dFRQV2dGWWUydUJ4aUlnYXZod1BHR3lMcHB1NGc2Q2V3aHBaeWgv?=
 =?utf-8?B?NktlYzJNME1uNU9uaWE3eWExLzVuQ2pMcmlnUFg2NWRneVBPZjJpa3NiVVg0?=
 =?utf-8?Q?9DI3XQKFSeomCMgVZHf3B3Xhk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0ad3fe-6021-461b-c723-08dc0bb256a7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 16:46:16.6905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ll5rszMaABnp1IL+bvIl/HAwKjiLzS6SvEczW2HoEAx1Wu6ym1jD/PchzOML3Wvbqg6nuGRx/Ilk2FYwtSd1yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225
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
Cc: alex.sierra@amd.com, philip.yang@amd.com, xiaogang.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-12-28 18:11, Philip Yang wrote:
>
>
> On 2023-12-21 15:40, Felix Kuehling wrote:
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 6.5.0-kfd-fkuehlin #276 Not tainted
>> ------------------------------------------------------
>> kworker/8:2/2676 is trying to acquire lock:
>> ffff9435aae95c88 ((work_completion)(&svm_bo->eviction_work)){+.+.}-{0:0}, at: __flush_work+0x52/0x550
>>
>> but task is already holding lock:
>> ffff9435cd8e1720 (&svms->lock){+.+.}-{3:3}, at: svm_range_deferred_list_work+0xe8/0x340 [amdgpu]
>>
>> which lock already depends on the new lock.
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #2 (&svms->lock){+.+.}-{3:3}:
>>         __mutex_lock+0x97/0xd30
>>         kfd_ioctl_alloc_memory_of_gpu+0x6d/0x3c0 [amdgpu]
>>         kfd_ioctl+0x1b2/0x5d0 [amdgpu]
>>         __x64_sys_ioctl+0x86/0xc0
>>         do_syscall_64+0x39/0x80
>>         entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> -> #1 (&mm->mmap_lock){++++}-{3:3}:
>>         down_read+0x42/0x160
>>         svm_range_evict_svm_bo_worker+0x8b/0x340 [amdgpu]
>>         process_one_work+0x27a/0x540
>>         worker_thread+0x53/0x3e0
>>         kthread+0xeb/0x120
>>         ret_from_fork+0x31/0x50
>>         ret_from_fork_asm+0x11/0x20
>>
>> -> #0 ((work_completion)(&svm_bo->eviction_work)){+.+.}-{0:0}:
>>         __lock_acquire+0x1426/0x2200
>>         lock_acquire+0xc1/0x2b0
>>         __flush_work+0x80/0x550
>>         __cancel_work_timer+0x109/0x190
>>         svm_range_bo_release+0xdc/0x1c0 [amdgpu]
>>         svm_range_free+0x175/0x180 [amdgpu]
>>         svm_range_deferred_list_work+0x15d/0x340 [amdgpu]
>>         process_one_work+0x27a/0x540
>>         worker_thread+0x53/0x3e0
>>         kthread+0xeb/0x120
>>         ret_from_fork+0x31/0x50
>>         ret_from_fork_asm+0x11/0x20
>>
>> other info that might help us debug this:
>>
>> Chain exists of:
>>    (work_completion)(&svm_bo->eviction_work) --> &mm->mmap_lock --> &svms->lock
>>
>>   Possible unsafe locking scenario:
>>
>>         CPU0                    CPU1
>>         ----                    ----
>>    lock(&svms->lock);
>>                                 lock(&mm->mmap_lock);
>>                                 lock(&svms->lock);
>>    lock((work_completion)(&svm_bo->eviction_work));
>>
>> I believe this cannot really lead to a deadlock in practice, because
>> svm_range_evict_svm_bo_worker only takes the mmap_read_lock if the BO
>> refcount is non-0. That means it's impossible that svm_range_bo_release
>> is running concurrently. However, there is no good way to annotate this.
>>
>> To avoid the problem, take a BO reference in
>> svm_range_schedule_evict_svm_bo instead of in the worker. That way it's
>> impossible for a BO to get freed while eviction work is pending and the
>> cancel_work_sync call in svm_range_bo_release can be eliminated.
>>
>> Signed-off-by: Felix Kuehling<Felix.Kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 ++++---------
>>   1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index afd98aace065..7683c96f0cbd 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -404,14 +404,9 @@ static void svm_range_bo_release(struct kref *kref)
>>   		spin_lock(&svm_bo->list_lock);
>>   	}
>>   	spin_unlock(&svm_bo->list_lock);
>> -	if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base)) {
>> -		/* We're not in the eviction worker.
>> -		 * Signal the fence and synchronize with any
>> -		 * pending eviction work.
>> -		 */
>> +	if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base))
>> +		/* We're not in the eviction worker. Signal the fence. */
>>   		dma_fence_signal(&svm_bo->eviction_fence->base);
>> -		cancel_work_sync(&svm_bo->eviction_work);
>> -	}
>>   	dma_fence_put(&svm_bo->eviction_fence->base);
>>   	amdgpu_bo_unref(&svm_bo->bo);
>>   	kfree(svm_bo);
>> @@ -3444,6 +3439,8 @@ int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence)
>>   		return 0;
>>   
>>   	if (fence->svm_bo) {
>> +		/* Reference is dropped in svm_range_evict_svm_bo_worker */
>> +		kref_get(&fence->svm_bo->kref);
>
> I think there maybe racing condition if bo is already releasing,  get 
> ref unless zero
>
If that's a concern, we should probably make sure that the fence->svm_bo 
pointer holds a reference itself. We shouldn't have eviction fences with 
dangling svm_bo pointers. And we should not let a BO refount go to 0 
while there exists an unsignaled eviction fence pointing to it. I'll 
look into that.


> 	/* if svm_bo is getting released, eviction fence will be signaled */
> 	if (!svm_bo_ref_unless_zero(svm_bo))
> 		return 0;
>
> Another solution is to call svm_range_bo_unref_async from svm_range_vram_node_free.

That's not ideal either. The eviction worker is already a worker thread. 
Then we'd need to schedule another worker to actually release the 
memory, adding more latency and scheduling overhead.

Regards,
   Felix


>
> Regards,
> Philip
>>   		WRITE_ONCE(fence->svm_bo->evicting, 1);
>>   		schedule_work(&fence->svm_bo->eviction_work);
>>   	}
>> @@ -3458,8 +3455,6 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>>   	int r = 0;
>>   
>>   	svm_bo = container_of(work, struct svm_range_bo, eviction_work);
>> -	if (!svm_bo_ref_unless_zero(svm_bo))
>> -		return; /* svm_bo was freed while eviction was pending */
>>   
>>   	if (mmget_not_zero(svm_bo->eviction_fence->mm)) {
>>   		mm = svm_bo->eviction_fence->mm;
