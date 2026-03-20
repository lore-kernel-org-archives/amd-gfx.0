Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65901108B8E9
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 10:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3DE410E223;
	Fri, 20 Mar 2026 10:13:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3gmvE+Oa";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDBC210E223
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 10:13:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXvkPzNeLsssWXo6NUMSIWiNvYi/pOmgeoIJT9/FUYS5153zKoCs/NiFn04Exvs4YeDYped5svj4yqBjq/hj7AYV+hFsg1gVbjQ6mnAiuMWI5NBFlvh9IUuv0T9GtdcUqxfFRgmFxEzjiW/b4uehwtHYF2KzbguY9TtscU8eOKLQEzYqdymdJtk1j0TyE0dkFkxSvlqSfmWNkeFQYiZtuJN3Q5xhbEL4SbmE7p7H8wvezA4gVvcLFNwAnnNgVEe/YlLlnpsAjMLdn8kdfJh62tqnRezyutn1B94TFTN1LXmTzP3OGrS3qXVATUXMnPEVpJbQd3vM1QnYNq8CtFc+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00xqxJRWMNgXw1n5NtTwstKPRcLKHPVYMhjYEcJbb3Y=;
 b=VhQTJrNm1Od+dAS05+nERhKM5JrM58Cfqsn8juDpzCcON04k6GRNZ3fjdvmoG1SfzNEerBsk/hHxdc1PF79fCC7z0XLRykUckj9SoLckT9R8A3jBjT7M+78ofHZ+4yRCZHIG2MWoKBXAJx4AiaHm9D0DqUGzQxbTIysQEcBWsq+o/3FqeRdRTi+4ScUgzyuxRpSL8+l/S6HbzgLPkUEkGIiWh2107CSyB6PJQ2dLkbIW7vP+Ffzf3PmTIVewzfxzaNXJPgkx6u+VuqQSIWSkjEXkVT/fLtnFBF6bTMFyn1/qezxga5DfrgifbLLjXg6ZWOjCqmYoI9FhG95X8MobpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00xqxJRWMNgXw1n5NtTwstKPRcLKHPVYMhjYEcJbb3Y=;
 b=3gmvE+OadY2UNd5pGG+dBYOoU2VOf8R27Vbj8INJtwYRhE0goq6E7OsyVqrFlNyX02FhMMt8AiRcM1l85rYci3MllXMdGtf68Ptlimz/w6V9m3YW9R/zQ4MkuL+sEzUxFgxKBci0bIj8tf7ReLDgq6gEk05Hq9H5sp7tvWwECTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 10:13:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 10:13:33 +0000
Message-ID: <99f813b0-54e2-40d0-9fce-00d1f1f52641@amd.com>
Date: Fri, 20 Mar 2026 11:13:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: add mutex lock/unlocked version of
 amdgpu_userq_put
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Liang@rtg-sunil-navi33.amd.com,
 Prike <Prike.Liang@amd.com>
References: <20260320094111.3640176-1-sunil.khatri@amd.com>
 <df195a01-e228-4f14-9e20-ecb63dc9d653@amd.com>
 <21c8b934-7973-47f7-9a13-77c7b18530d2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <21c8b934-7973-47f7-9a13-77c7b18530d2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 2918d15e-56f1-4b1a-25ec-08de8669574a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: Q0i57CqTwuo4i1cnzf8rsHh1iXSpSB/MjfRHVQW70qtojEClTGwLMo2v5k+pBKrp3sNSZwxwOrC0mnAapL+dbSjGw3sydF9WH6PlX7OfGv0g0tSFE0dQPgyP5TRxVXCux86+XKynpCY5aqfv3FBWf309CSkWvT/wN3edphpL8tYySi6ApgvMeGLGeS5dvn75lvKBBxhqKXDOOtJbpaz3r1ga+ub5ZEhKITmudg06ZWqjRw0Of6bwSsNc6RbCnrM7nTvU9VilSa6E35hz0qA5dfEscdH0Z0/aPmUfwU87GPxrFtcJdxI2CiZZiGPZVfOZSQ10UKBKt3Ju+lmROEYeAspy9M86H+9II8ImLXZRAO/BE9iPEVX2pDvosBDcsgl9//6vM/L/GAgVTdz2tRNeNtoeqUB7TznPL07voQZ2ILhpCQyaZ2RmOk3re74ytzy4YuM2iLFqJUk2sz7HIjqBmuO3m+t6Skm+7Rv1yk6wo1LI40YRDw1Rc0atO8x3Nf4sBq0nfT0jLOyGO9RLDiqstWqNUuKJrkY3zNG3v0mNFT1hnwhAKjs5BwIEqF8pjM1l+hdjF5gettoiNhE7xnfu5Y9APB/tHEf3lpn5Hfra78Aq5RXi84CV/+nw95WWiUm/nzwazP0/LHBgfMxXyNA8B7TS4MkxkYXvfEzb6d7KsRXgQmVp7LetY4mEsVXhsisdVrXhFBU1aBDe61TEGmxDjld6ovII2FRRuJn4P0gaavQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWxRZTAzL251ckVRZngxUTVBTlB1NEF0R0I2d1dyMUlIanVUbW55aVRkMnFl?=
 =?utf-8?B?OC9Dd2oxYUdSZkxYLy9HOXByOHRNS01EMTlJVWc0d0JLNnMyekg2UEZuRXV5?=
 =?utf-8?B?WEg5YnZXbjNzV3dUMFB2cDhaZEFoQWRzWjdyYXFwQjNMeU4xc1g4a3dBbS9l?=
 =?utf-8?B?dlAwVEtVVm5OZUdVaTFqejNVYUthNVhvRXFTTDMyN29yeTQvUkdwbi9ILytx?=
 =?utf-8?B?K0crS3JlZGRTckgvR0FqZmh6aVpwcUtpa01ISjBHZUdRNWErKzFPM3lnWHI4?=
 =?utf-8?B?UTMvNi9vNGRsY3l2RkIwTzk3MTVyai9zMXcrYm1HRW84c2lqbDlwT0VHdzR1?=
 =?utf-8?B?cU9aNzV0d0xOZWpqWVphWjRoQzlLYmIyQm1uQWJ3L3hrNFo3QVMzSzBJNUFV?=
 =?utf-8?B?c1NTV0pHbTFidkhyTVQxZEN5bm40T0d4UFkraDc4cWFqbWJqSmIzTnpqQ1l1?=
 =?utf-8?B?aFNTb25nbDNudFROVEZGR0VJVmhTMWtxN3Y3TzlIekF0ZDZtTCs4S2dHSHNu?=
 =?utf-8?B?WmtNSmoraWpFMTVxK1F2dzNNdWk0LzA3S1h5SmNUMitvK0RQZFJ0YkN5dHgy?=
 =?utf-8?B?aFJ0SmJuV0FYZ2hnb3hSNjNJdTlZVHZpVjhUeHNBYVF1RWhzNkZSMjBTRGJF?=
 =?utf-8?B?MHloSE0rR2EyQjZMb3VJQUgrWWs0clRJMzF3cjYvb3NadkZJYU5mKytMcUtw?=
 =?utf-8?B?a0gwU2xSNVhyalRPVnd2SjhqTmZranY1SXN0dThMbDM3RFd6OVFoeFNhRWJU?=
 =?utf-8?B?ZGVWWHFHMkVwdjByaThIQk1RNlBpYVhZM21tQkliSkIyUFVDd2tOYk95ZXJl?=
 =?utf-8?B?b2htS1lsY1BuUGdDNFVWVGlkZnczS0VKUC9DNEoybk5CbGhGSmdHMmhIc0t3?=
 =?utf-8?B?RDF0cDNYNnJ2REJwdVUyT2NMdTdmbHNwSU5tLzNRamZ4TUxpTTE3bFdKNTc2?=
 =?utf-8?B?ajQyZmdIWHdRam51dTZUN3FOSTdydlhqUWNRNUh4ek0xVW9VSndpR1YyYTl1?=
 =?utf-8?B?TjFrbTdNc0pyUUlrTFhoVnByNUFhaUtTcXZ4K0tNeE14S1NZRUFxS0w5UU9p?=
 =?utf-8?B?Z24zZXdTNVhyNVlieDU2d3lqZXVkdXJXM3BtU0M2bkR0K3VlUHJZcTZzcnNo?=
 =?utf-8?B?Nmtmdkc5UDB2cXdhL0ZOUzNTQ21vSSs0cXhvWHArQTcrWUxtM2cwZjdBVFF1?=
 =?utf-8?B?aXZPaVNscmFiNUFpYmV5a3pmbFd5V0RDTGVrMlZsSXAraXVpY3pVcENFd2N2?=
 =?utf-8?B?NEpOS05MMy9SVTVUVndmNVZpRUNQYkgrTlNCY3hpSVZ5Rk9JVEk2cXdkMkZ3?=
 =?utf-8?B?ZHFTZ2poSU5qSU8wVW90cFl1b3hBM0xoK0FZclAybjdYRFBGVFpPekhsSjd3?=
 =?utf-8?B?SFN2dHdhS2dVR3NYN1hmK01FN2g4Z2N5b2JjTklDbkdPdzZ2R0tnS0hRdGVF?=
 =?utf-8?B?clhQanViMm9RNTJZb1NnbGd5bGhna2NBa29LdXNiWllNSTJBL2ZTOExtRHIv?=
 =?utf-8?B?bXMxOHBETERhRkNjODdKV0U1ajFoQ21pa3pnNElRVTM3bGZKbzlicmRQUUJu?=
 =?utf-8?B?Mk9hWWxZWkZlMnR6Y1R4NTRTNjZueUNzd1lUd0dHclhXdEFRSFBYREIxckVm?=
 =?utf-8?B?aURKZkxkcWJ6YlJmam1VcWlrQlFJUnRkd01SRVVwM3p3ck40aTNWZmVNc1lw?=
 =?utf-8?B?VmpKQmlNTXM3UTdvSU45bnQrY3NQaFNNazRXM3NReW9aMUplQjJkb29iZS9Z?=
 =?utf-8?B?WmxaOEthcWFzRit0ZHYxYVp4TFppcUc3anU0YVFsZ3NrNnF6MzNBaTRpT0ZJ?=
 =?utf-8?B?cDA2bzlPTlcrMkJ0djZIbCsvVWFBVUZuN0daczRsaWJnUGJuNVFyVHpPQU9i?=
 =?utf-8?B?VmNDTGFpM0pZS1hKeDZWemhHU3VtK2gwa3JhVGpRMU5mVE1oU1cvR0YvQ3hD?=
 =?utf-8?B?NlNWN0RtUWN3S1VPNkFPSHZlc2FwVHRqVVBUNERydHNFRHQvSnlveG4zc0lB?=
 =?utf-8?B?SGFPdmtDcTVYN1RNQ0hvRkh5eVRMbm5uVnh2NXhkbmp2ZmlzYVJsMmRsaHh0?=
 =?utf-8?B?MmMzeE56NjdsZExBUFJPdUYvT1NIZmYwOFhkejZGL1E1Z2N2MDlaQytkSWx5?=
 =?utf-8?B?WDFEeEFLZUhxMGRaanA0eG54dGpCckhCKzgwSkdEVkZkRzYzWW5GVDRRT2Fa?=
 =?utf-8?B?aCs2d3VWSk95YTVnR0RhdkREQzNHbml4c0JBWXhUTEpwclZ0RUVnRFNBVmFX?=
 =?utf-8?B?U3k4WUV3ZWNYQU55SXhCTE5ubllPcVAvWm14T2dMWXRWZzhVRm1TZWlrRk9J?=
 =?utf-8?Q?DGlwlTdQtmzR9iZl6s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2918d15e-56f1-4b1a-25ec-08de8669574a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 10:13:32.8632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9E6AU72VH23ykPTCtDrB+Apne2jn/VtD6Zqto3Thv+Skl4ncqkEhsKjtzJJpuof
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760
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



On 3/20/26 11:02, Khatri, Sunil wrote:
> 
> On 20-03-2026 03:16 pm, Christian König wrote:
>> On 3/20/26 10:41, Sunil Khatri wrote:
>>> There is a possibility of deadlock when last reference to a queue is
>>> put in certain situations where mutex is already help when calling
>>> the amdgpu_userq_destroy.
>>  From functions
>> As far as I can see that is illegal to begin with. Why are we doing that?
> This is to fix the deadlock that prike shared and many other places where deadlock could still be caused.
> There is a possibility of amdgpu_userq_put being called for last reference from amdgpu_userq_restore_worker or amdgpu_eviction_fence_suspend_worker via amdgpu_evf_mgr_shutdown
> and all these functions already hold the userq_mutex and on last reference when destroy is called it again takes userq_mutex and causing deadlock.
> 
> Thats why when we are dropping the reference we pass the information of the handled could be called with lock already taken and hence the handling.

Well that sounds like completely broken handling.

Why are dropping an userqueu reference while holding the lock in the first place?

Regards,
Christian.

> 
> Regards
> Sunil khatri
> 
>>
>> Regards,
>> Christian.
>>
>>> So based on the thread where it could be
>>> locked we pass the locked information in the destroy functionality
>>> to avoid taking the lock again.
>>>
>>> Cc: Liang, Prike <Prike.Liang@amd.com>
>>> Suggested-by: Liang, Prike <Prike.Liang@amd.com>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 52 +++++++++++++------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  2 +-
>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  4 +-
>>>   3 files changed, 40 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index ced9ade44be4..9482664e9c2c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -617,13 +617,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>>   }
>>>     static int
>>> -amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>> +amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue,
>>> +             bool locked)
>>>   {
>>>       struct amdgpu_device *adev = uq_mgr->adev;
>>>       int r = 0;
>>>   -    cancel_delayed_work_sync(&uq_mgr->resume_work);
>>> +    /* It safe to unlock since we are in destroy and the queue ref is only this */
>>> +    if (locked)
>>> +        mutex_unlock(&uq_mgr->userq_mutex);
>>>   +    cancel_delayed_work_sync(&uq_mgr->resume_work);
>>>       /* Cancel any pending hang detection work and cleanup */
>>>       cancel_delayed_work_sync(&queue->hang_detect_work);
>>>   @@ -657,13 +661,27 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>>>           queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>       }
>>>       amdgpu_userq_cleanup(queue);
>>> -    mutex_unlock(&uq_mgr->userq_mutex);
>>> +
>>> +    if (!locked)
>>> +        mutex_unlock(&uq_mgr->userq_mutex);
>>>         pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>         return r;
>>>   }
>>>   +static void amdgpu_userq_kref_destroy_locked(struct kref *kref)
>>> +{
>>> +    int r;
>>> +    struct amdgpu_usermode_queue *queue =
>>> +        container_of(kref, struct amdgpu_usermode_queue, refcount);
>>> +    struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>>> +
>>> +    r = amdgpu_userq_destroy(uq_mgr, queue, true);
>>> +    if (r)
>>> +        drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
>>> +}
>>> +
>>>   static void amdgpu_userq_kref_destroy(struct kref *kref)
>>>   {
>>>       int r;
>>> @@ -671,7 +689,7 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
>>>           container_of(kref, struct amdgpu_usermode_queue, refcount);
>>>       struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>>>   -    r = amdgpu_userq_destroy(uq_mgr, queue);
>>> +    r = amdgpu_userq_destroy(uq_mgr, queue, false);
>>>       if (r)
>>>           drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
>>>   }
>>> @@ -689,10 +707,14 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
>>>       return queue;
>>>   }
>>>   -void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
>>> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue, bool locked)
>>>   {
>>> -    if (queue)
>>> -        kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
>>> +    if (queue) {
>>> +        if (locked)
>>> +            kref_put(&queue->refcount, amdgpu_userq_kref_destroy_locked);
>>> +        else
>>> +            kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
>>> +    }
>>>   }
>>>     static int amdgpu_userq_priority_permit(struct drm_file *filp,
>>> @@ -978,7 +1000,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>>           if (!queue)
>>>               return -ENOENT;
>>>   -        amdgpu_userq_put(queue);
>>> +        amdgpu_userq_put(queue, false);
>>>           break;
>>>       }
>>>   @@ -1007,7 +1029,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>>               drm_file_err(uq_mgr->file,
>>>                        "trying restore queue without va mapping\n");
>>>               queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
>>> -            amdgpu_userq_put(queue);
>>> +            amdgpu_userq_put(queue, true);
>>>               continue;
>>>           }
>>>   @@ -1015,7 +1037,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>>           if (r)
>>>               ret = r;
>>>   -        amdgpu_userq_put(queue);
>>> +        amdgpu_userq_put(queue, true);
>>>       }
>>>         if (ret)
>>> @@ -1258,7 +1280,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>>>           r = amdgpu_userq_preempt_helper(queue);
>>>           if (r)
>>>               ret = r;
>>> -        amdgpu_userq_put(queue);
>>> +        amdgpu_userq_put(queue, true);
>>>       }
>>>         if (ret)
>>> @@ -1298,17 +1320,17 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>>>           struct dma_fence *f = queue->last_fence;
>>>             if (!f || dma_fence_is_signaled(f)) {
>>> -            amdgpu_userq_put(queue);
>>> +            amdgpu_userq_put(queue, true);
>>>               continue;
>>>           }
>>>           ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>>>           if (ret <= 0) {
>>>               drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>>>                        f->context, f->seqno);
>>> -            amdgpu_userq_put(queue);
>>> +            amdgpu_userq_put(queue, true);
>>>               return -ETIMEDOUT;
>>>           }
>>> -        amdgpu_userq_put(queue);
>>> +        amdgpu_userq_put(queue, true);
>>>       }
>>>         return 0;
>>> @@ -1366,7 +1388,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>>           if (!queue)
>>>               break;
>>>   -        amdgpu_userq_put(queue);
>>> +        amdgpu_userq_put(queue, false);
>>>       }
>>>         xa_destroy(&userq_mgr->userq_xa);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> index f0abc16d02cc..2a496e74ec6a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> @@ -116,7 +116,7 @@ struct amdgpu_db_info {
>>>   };
>>>     struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
>>> -void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
>>> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue, bool locked);
>>>     int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 18390d37a7e0..10e08cb6bd13 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -612,7 +612,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>       kfree(syncobj_handles);
>>>         if (queue)
>>> -        amdgpu_userq_put(queue);
>>> +        amdgpu_userq_put(queue, false);
>>>         return r;
>>>   }
>>> @@ -914,7 +914,7 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>           r = 0;
>>>     put_waitq:
>>> -    amdgpu_userq_put(waitq);
>>> +    amdgpu_userq_put(waitq, false);
>>>     free_fences:
>>>       while (num_fences--)

