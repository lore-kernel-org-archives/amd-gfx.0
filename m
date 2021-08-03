Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071A2C4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 15:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5A5360720
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 15:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B5A5360720
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D3CB89B84;
	Tue,  3 Aug 2021 15:02:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01DC789B84
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 15:02:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y02/5icNMLm5LNSJsodI0QwgHmd4GfyNd3JYTQj8SS2MA7Ty1iFencWXoZG3EZ176uhgtRTpDvKrVumyOD0PVth+PE9wSklr9Tsioh3PrfHNMcn3+pv1oIqYyVF9LVIdlFcMcq4SqC+Z42AbyY+JkjZMCr4/DvVNWwyJzniAUFW5fiK4uyiyLzRw79pBlhVYwQLQ30F5vWtEMK6XyuM4LKmNir0Pyn4wN+EBJgbD7KB+RC+D/7pKNkdrGEFjIuLyPIhR0QBT/cfOg7BhmibAY3y45zTccfGTt40CyP1r8hlrDgUJI1TqyA8dBrUPTMtuEun7OJhqx1BmEGVu+o/fWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbZtv6J49/MKZlesplHjPAVFFDWprE8IrnZlbCB3QbQ=;
 b=Xt5EAAenUYiiC5JhxMCYJHXbtnB95/MEeSF+zBtFXRRZvlQCwKG9PLxOiW0NxhcCkZ7s8tgwesJDewEpH6+am61zcoY8gIJwrva7us5j5thFJWSi4Q6tSIT3MTzdm6xkXCQsew+5ZpzoerJbC6Uk0sWIT9IYulmYzgL2B6+fmYOTWcOJknPT52IhMpoHslRWuknrt3tepj41L7bpn3CUarzLXX59bXSUZLvwPiVeXgwP2sGzTGlQII1GNJaEIpD9Zo+2jP0qMCd+b7duLggY/w6pYWfvYWOjrElX9YBay4uLoQ7g7kVQ2OEYfP4nO+XydFMAQEEjkCXOYOBVQFTNZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbZtv6J49/MKZlesplHjPAVFFDWprE8IrnZlbCB3QbQ=;
 b=3AH3I1H95W7vd/L3uHBkCjpon50on1GlxnvmkuVEqktPhOc6lUXfrn0PKeokP766aptGe/CpPONz2ldy1gpd9n8fc9E0NM41+soaqmMtUZJk8FfiJ4cgIkxVEKIYMP6UqkjfDYHrp5fxmNpOhWdgIoqnOPxVAK0ENzHb7C1V5gI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by BL0PR12MB5554.namprd12.prod.outlook.com (2603:10b6:208:1cd::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.22; Tue, 3 Aug
 2021 15:02:29 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d49:f837:16e3:9561]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d49:f837:16e3:9561%3]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 15:02:29 +0000
Subject: Re: [PATCH] drm/amdkfd: Restore all process on post reset
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210728173154.834263-1-jinhuieric.huang@amd.com>
 <feffbe5c-7400-a3f5-148d-03e7d128aece@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
Message-ID: <d7d80b78-21fa-1755-cd97-4c206d6f2667@amd.com>
Date: Tue, 3 Aug 2021 11:02:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <feffbe5c-7400-a3f5-148d-03e7d128aece@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::16) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2048:122:890e:34c4:757:cc76]
 (2607:9880:2048:122:890e:34c4:757:cc76) by
 YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Tue, 3 Aug 2021 15:02:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab3215f8-62c6-4631-c73f-08d9568fb63e
X-MS-TrafficTypeDiagnostic: BL0PR12MB5554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB555427E9988306627183A9FD82F09@BL0PR12MB5554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpzUo0erXJfbQD44PsHIbjF+nUYp543A4PxvBzQLM1JcYZjXf2vgn59IayVeqvoZb6+cIUHkGXfsQfuuDntUXNtQKnump1h6EYxqiqtu4SLZ/kW4CU/lZ5vK46QjbWtlLjbzUp/7vH2GwfYQvfRFJmgZ2hCGBZRBHi9pwjAmLlU48mMHiNiIJU5NAE6DYsDqFzf2RwxPPCZKf/p0ucaXxJdTsqKc4VPLRXuSNm606Kq2nwM4pA6xFIf4SFljcD7MmMGTKU+G5xj5a067EXBHN4Xjct+OjCRgxMS3tofJ73o8CINjRiqcuRjbwaPy0NnWhNyC5+Awp8tLZOJvh+Hj/3QfINx/Kks4479VItZ0FAECZqZ2IBCwX7lCNILL6xjPh/H0Fu8XyYu8jL/W0oaEKX6iHe6YWYQx7Tg/fLxert3WXbtyYasdgqynr6Ic44yWp5FOHLc+ihEX7YFIptPW4u0LcHR85juHPkk5gOheu61DAL3rvTOLoKoP7olUdjxAgU4O+W0FR/nf7yK5ReQX84JDkdMNW4QwA6puYyXkMdfMM/8dYr2r2ntR4WbNi73ergvRSrHO1GRGO+Z9cefOzWRUCMirjRHXuy7R66t+UzGcdagu9EQskp6YFL4Hd6iv573ljTnsGvVtXMtla28bYJ90RA+VD22y+1JCS9fM+09Y8F/7nm6Nd7Gq0m15g1+eTWbuTN773auf3ehrH90qGRaFtVtDUMZFC11RwvBLj3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(8936002)(186003)(31686004)(8676002)(83380400001)(508600001)(31696002)(2906002)(6486002)(66476007)(66556008)(53546011)(36756003)(66946007)(38100700002)(5660300002)(6666004)(2616005)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjRyaEt2b3Q2azU1cnR5YTBLOWxmdy9XR1lYTzN6WUtLNFdTRm9jS3FrWkJL?=
 =?utf-8?B?L0JYWGhCRWFyTEI3Z3JsSEFldW9CYnRVMWhpanRHOStrYXc1RkZld0FIanBB?=
 =?utf-8?B?RDFFNWIrUVhKQmlENk1yTzAwNjc1QllnWTBGYllWeGhBRSs4RGFONGcwUTg5?=
 =?utf-8?B?VVdrT2VhRDF4azFveGRpQUphSC85VTR3eFRpeFJqbDlnYWUvbWkzMWoyUVJY?=
 =?utf-8?B?L3dtSGJydml4N1FZYmlGMmNwd1doSlIvQ3RXd0R3RzJxV2d1eHlwNFZpSWp2?=
 =?utf-8?B?UWpqOU1McDJPYmd0UlJjYzE1STFVTWhFRndRb1BERTNGQXVDTlljc3pRaTls?=
 =?utf-8?B?Qy9jRXlJWTJvTUE4VklabGprbnppT2QrdytvUjFFOWcrSnBWS1JOaEIyOE96?=
 =?utf-8?B?S1FuKysrQmpOV2x0bEVVQk9mYWpVOW5BdW9Bc0FwQ014U3BrNFJFYzh3ZWRV?=
 =?utf-8?B?ekxHeEtCSnM3MnNlSk03cFhvMEI5MmEwamZmeU1jRWl6U1o4cUFmcTEzYkgx?=
 =?utf-8?B?U1ZCeVh5RllsOTVJYU9qang3b1lCU0ZnVjk0Tk5hbnpacTc4WmU1S01tU0RM?=
 =?utf-8?B?OVVZN08vTTljTWl4MGNINjNNNTl2QVkvak50U1JQbFpEVUVmc0NJT0QraWZE?=
 =?utf-8?B?eURiTkxmZmx2dDRqRzVndTNkdGFPOXFqd1V3Umwxa3ZvNW5pSGNkR0M0MkFH?=
 =?utf-8?B?NktlLzdEQlVUa3JPQzZHazVncjBXTmY0cGNFUWk5WHJWQzNoWUZyOE9tUCth?=
 =?utf-8?B?SWJ6YnIyYmFUajRKTk1vVlE0WFB4RnpYZWdyZWN3WE9XWm5KVTlSQnV1OFR6?=
 =?utf-8?B?cGoyakkxc3Q0QTJGWXBYSmovaWZhRUVQV1c3Q0poU09sbkNGdTNObUVITU5t?=
 =?utf-8?B?Y1lWdTEycHB5dmU3Qk1qNllkQ0ZJR0FMbnV0Z1JRVGs4L05LM3lUTUc4QlVL?=
 =?utf-8?B?cU8xQi9RVzFQdHhkbzhJcUNVeUpkY0pyOUUyTXBpTHBKd2dpeTNvOFVFMlNI?=
 =?utf-8?B?WmtjTUhoS2ZkZDcxa2NpUGZ4UEt4WU9qWFNSSE51V0dEZDdvMS8ydUQ5Rmdw?=
 =?utf-8?B?bDAxT2pIK0hsSG8wS0dTbTdoWFBKYmlKSUxhQkZYUmtOOTVDZHYrT2lyUVZD?=
 =?utf-8?B?QmRuNldScjhwbld6RUxMZnlISFpPa3o0TGxpVGJwSWhibFBDUkhlK2FGOEFX?=
 =?utf-8?B?Q0d0bWkvNXBiYmVvOEZuK01QZk1Sa3M5cDJoT2cybWVLaitCL2U1eEYrUjVH?=
 =?utf-8?B?dGYrenJzN3pobjhGOUJ0aHVqWG01NDZORlEvMXNHMldKTGxWdXlFVnU2M3Q0?=
 =?utf-8?B?NXhaN0wxZHhEQ3RkQUtoVjVOVndZcDRqSzBBZjg5S0dzNndJZ1hhaWxUVkxX?=
 =?utf-8?B?dENrenQyaGFTTjMzQURpcmQxZFlOdXdjN1FXRHh4Wk9UMlpJK1dFZHRUSE40?=
 =?utf-8?B?WU81YWtTYlJzcCtTdS9wMk1XMXFwYlJwVkhYbXRxYlNaeHExS0ttaGJKUW1C?=
 =?utf-8?B?b2NkRWtTRC9vVVc0cXZBSGxnU0g5dUduanJiY2RkeklLTEU3Vk1McWNPUVhy?=
 =?utf-8?B?a1RSMkVoZUhBdExmVUpLS08vVGwrK0d2QkRzeFZPYnNZU0ZwYXdhYTVKQnp2?=
 =?utf-8?B?MERWMm1PTE12S2FLWWlNNnpMNnlFc2ZjUkF2dmFsZ3ArRWhNNFdNbjVVcDk2?=
 =?utf-8?B?YTl6L0dyYmtTeFhYV0VveHJxWWd5TjVGakhBVmdBbUd5Mm9OaGoyM3k4Vy9p?=
 =?utf-8?B?blUzeDc4Z2pYb0lWVmJLWjg0SVlsMlo3MlhJaGMvM0ZHdnZuajVBV1o2OFBy?=
 =?utf-8?B?Y21NQ096NzFnUHpiekh3MjFSVXhCZng0dDBCTDNSam5GL2hOdFNkOFgzSXFD?=
 =?utf-8?Q?+UimCIfXvfmR6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3215f8-62c6-4631-c73f-08d9568fb63e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 15:02:29.0701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9ouZvjaEY9aigIJzXUzwTqEuWhFMvtOg914j0tj5U8dkxstTtNrUz8hxm8eHl3JXOoHYZrCkoRDsnI4vgSmLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5554
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



On 2021-07-30 5:26 p.m., Felix Kuehling wrote:
> Am 2021-07-28 um 1:31 p.m. schrieb Eric Huang:
>> It is to fix a bug of gpu_recovery on multiple GPUs,
>> When one gpu is reset, the application running on other
>> gpu hangs, because kfd post reset doesn't restore the
>> running process.
> This will resume all processes, even those that were affected by the GPU
> reset.
>
> The assumption we made here is, that KFD processes can use all GPUs. So
> when one GPU is reset, all processes are affected. If we want to refine
> that, we'll need some more complex logic to identify the processes
> affected by a GPU reset and keep only those processes suspended. This
> could be based on the GPUs that a process has created queues on, or
> allocated memory on.
>
> What we don't want, is processes continuing with bad data or
> inconsistent state after a GPU reset.
>
Current code doesn't take care of this assumption. When a GPU hangs, 
evicting queues will fail on it and roll back to restore all processes 
queues on other GPUs, and continue to running with unclear state and 
data after a GPU reset.

The original thought about this patch is to call 
kfd_suspend_all_processes and kfd_restore_all_processes in pair on 
pre_reset and post_reset. And It keeps the consistent behavior for both 
amdgpu_gpu_recover and hang_hws.
>>   And it also fixes a bug in the function
>> kfd_process_evict_queues, when one gpu hangs, process
>> running on other gpus can't be evicted.
> This should be a separate patch. The code you're removing was there as
> an attempt to make kfd_process_evict_queues transactional. That means,
> it either succeeds completely or it fails completely. I wanted to avoid
> putting the system into an unknown state where some queues are suspended
> and others are not and the caller has no idea how to proceed. So I roll
> back a partial queue eviction if something failed.
Can we let the caller to decide if roll-back is needed? because no all 
the callers need to roll back, e.g. kfd_suspend_all_processes and 
kgd2kfd_quiesce_mm.
>
> Your changing this to "try to evict as much as possible". Then a failure
> does not mean "eviction failed" but "eviction completed but something
> hung". Then the GPU reset can take care of the hanging part. I think
> that's a reasonable strategy. But we need to be sure that there are no
> other error conditions (other than hangs) that could cause a queue
> eviction to fail.
>
> There were some recent changes in pqm_destroy_queue that check the
> return value of dqm->ops.destroy_queue, which indirectly comes from
> execute_queues (sam as in the eviction case). -ETIME means a hang. Other
> errors are possible. Those other errors may still need the roll-back.
> Otherwise we'd leave stuff running on a non-hanging GPU after we
> promised that we evicted everything.
I think it depends on case scenario. GPU reset doesn't need to know the 
return state. Memory eviction may need. Does Memory notifier invalidate 
range need?
>
> See one more comment inline.
>
>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c  |  2 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 24 +-----------------------
>>   2 files changed, 2 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index 24b5e0aa1eac..daf1c19bd799 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -984,7 +984,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
>>   	if (!kfd->init_complete)
>>   		return 0;
>>   
>> -	ret = kfd_resume(kfd);
>> +	ret = kgd2kfd_resume(kfd, false, true);
> Which branch is this for? On amd-staging-drm-next kgd2kfd_resume only
> has two parameters.
Sorry, it is based on dkms staging 5.11. I didn't notice there is 
difference between two branches.

Regards,
Eric
>
> Regards,
>    Felix
>
>
>>   	if (ret)
>>   		return ret;
>>   	atomic_dec(&kfd_locked);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 38a9dee40785..9272a12c1db8 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1879,36 +1879,14 @@ int kfd_process_evict_queues(struct kfd_process *p)
>>   {
>>   	int r = 0;
>>   	int i;
>> -	unsigned int n_evicted = 0;
>>   
>>   	for (i = 0; i < p->n_pdds; i++) {
>>   		struct kfd_process_device *pdd = p->pdds[i];
>>   
>>   		r = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
>>   							    &pdd->qpd);
>> -		if (r) {
>> +		if (r)
>>   			pr_err("Failed to evict process queues\n");
>> -			goto fail;
>> -		}
>> -		n_evicted++;
>> -	}
>> -
>> -	return r;
>> -
>> -fail:
>> -	/* To keep state consistent, roll back partial eviction by
>> -	 * restoring queues
>> -	 */
>> -	for (i = 0; i < p->n_pdds; i++) {
>> -		struct kfd_process_device *pdd = p->pdds[i];
>> -
>> -		if (n_evicted == 0)
>> -			break;
>> -		if (pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
>> -							      &pdd->qpd))
>> -			pr_err("Failed to restore queues\n");
>> -
>> -		n_evicted--;
>>   	}
>>   
>>   	return r;

