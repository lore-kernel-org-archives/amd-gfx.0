Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995FE108B8F1
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 10:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3207210EAE3;
	Fri, 20 Mar 2026 10:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Jm7Pg0F";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E1110EAE3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 10:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUV1mSqSSD+Aip3IuXHFHh07HaK4Qdwr+iH73a1WDSx3gQl7HdFoNwMpLzS5G/Jzq/3vuTh3hkb6fZY7RXWC3EgFvb8DBYmhF1b5O6g0Y3OBGpD80AIJcSHMpgv/3JvYce7UO4fzYusTk82vAd/mFceDzjsmv7A6kuT0FkTKhAJurwOPYO0WNFxBb7q5gRvLsX+eCwDWhksvH/njuPZvZvrzOtDbX4bq3vnvGzxXNrJRsqMVjl8KfJYVMK8XEUM/jGYqWw5UqmJT2OHctQzj9eQMibWeR1fTjHBc30KYSF5pkgR5zFbErODlPXvPTQQIDKM6XJH2qzE5R5j5Kcflug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gD1V6CC1r5vueEWaYR8qPw4QhW1SklNCkNVWhbF4eqc=;
 b=YTPj92DxvaCcjQhIqvisk4wwsrR43o7fONy8Gp2qxSf1Rpw833MQzEfCT869EJ8keW0XeT3ozAoKy54UZW/KlLc4qkFhRTGedLXpEccJCvELrc8Kzi5KQj6atQqXdqYcz33TGDwFMN9mWoDhosx4n9XQZag+7PjPetHlQw+I1AZHe5ntpNBfoh7ug3IqDUiY3koq7CVYQpZGBUt8N3yeB+tEvZkT8sRNHxrRNV+6z+2+unTtkGU9sVjxPOpwnWrJjQWmXkBilS6nL53r4XZkXNcIKTUB5+tayras+nFPY0nXq2LpkjFYhBaSWsnbo5HOjf2/7atXlvxoyrMTItNk6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gD1V6CC1r5vueEWaYR8qPw4QhW1SklNCkNVWhbF4eqc=;
 b=5Jm7Pg0FfMgOKaLe+HAzXGM3LrVN+bFi1qXA2yTCSBL636dXsCT9U8vT97diqmzV5DF74BsSPHGEaICZ00o0ZLFDQMow7lLR9KoWQvbhomCuA9dVdILTUAl+vNIZb/N0aJB/69PAiilgesMkq12fbIhTacsLakQRQELbq3wJqI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 10:53:17 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::2c4e:287c:8da1:4be5]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::2c4e:287c:8da1:4be5%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 10:53:16 +0000
Message-ID: <78e16a87-de53-448d-94f6-13c7fa99596b@amd.com>
Date: Fri, 20 Mar 2026 16:23:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: add mutex lock/unlocked version of
 amdgpu_userq_put
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Liang@rtg-sunil-navi33.amd.com,
 Prike <Prike.Liang@amd.com>
References: <20260320094111.3640176-1-sunil.khatri@amd.com>
 <df195a01-e228-4f14-9e20-ecb63dc9d653@amd.com>
 <21c8b934-7973-47f7-9a13-77c7b18530d2@amd.com>
 <99f813b0-54e2-40d0-9fce-00d1f1f52641@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <99f813b0-54e2-40d0-9fce-00d1f1f52641@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::7) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|DM4PR12MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 6546c980-0622-4336-8a17-08de866ee442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 6iN9jflzWA8OUZN75h8w4USbCaH34APrTlvL4JaSj6BNCcz88FI0YrnzkBsBmDZ0kNN22TYVy1CxD71lZGRlNEiXRb4ILE+Qsze4LMJzISgAA7I2QhMY/HNwMvjDAYZoo9AyJalpd1mDdND5DyG7sdq9RApmAQyXnuhKeuYoGlxw2TE8AtfLps4z65sp7ZwKpOxMgRCSZ3Dh1fOgdfsaAzgQxEisWTrcgK6T5aX3h0EUhc6MJH073JAMGd37d6aVT6mNOFaKxtBzRUs1VBgACISOCYUOwxeQIUE3WlqYBvX8rhqDSFMUEnVUdIrT6WiRPkhw41RP3JYDBe8uRjqgkG1o8HVnBz7jlJ+8MWU9DiJDisw6vAQw0cLrmIDiB2db9ChvVCk59CMoUcKXaeiNOOp0XcKdSydTlCekczaO86gbwcE97OJZx+s/b1js6Gltw+ypHmDOhma3CQkndkcB6xCk3l61Uoi5XpvZ790MQt27U1ZwmKwF3PInRSW/rK3mG9c9z2cvAxZwrv6zSq/478P4zlMrxXnI7S5fJaNiJcOWoffFe0iClgPb2e44PaUHZD2rCj43vI8m5rIe+Cp3sJbTZuFL7Ebz0aW7FPEnFOsROyDGWEd1jkuIbR5moz6dbQOGl/rj8fBDePo9Ly8pAFDx0hN5IvCqX1bJc5Y6bn6JTRar6YVzaiAtJzhTJEviqdHcEMWwdaQy6/bW0+2wfvxxIifupZtEqdHdgIv8Er4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlNCRDhuTFlsMXRaMkJucUpaUFI5YkRXWm5kNjlPYjVOSHB1cUFGeDNiUzhZ?=
 =?utf-8?B?WnhnTHh5WCs4WmlrSDQ5aDF4R2c2KytFR1U0bWJZam1mTVhPQXhtK2EwOVBp?=
 =?utf-8?B?eU5QYnlnMFJ2UzRSdDdGREZhaU5PSWd1alFyL2lEQmlVRnBWOGc2elY4OFBR?=
 =?utf-8?B?NUpPZ0JMZURSTEFybncvWmw4enQxNVhxNnRDN0xkcmhwRXRlejhicUI2VGVJ?=
 =?utf-8?B?OW1UZldtSjU3QXUwTUhISHB2c0ZQVjREQ0VpaFJnUGNQMk81RXNreUFXZXhR?=
 =?utf-8?B?NTZ2Slh2dm9JNnFWSVY0QjdsT3RLd1ZBbHRrQmRuNjFROXV4ZzlxY0s5ZmxT?=
 =?utf-8?B?MG8yTFBXcWJzV1NWdWUyK05lMTZIdkRXZ2Y3V05jZU9lSmxHczU1djhKTHE0?=
 =?utf-8?B?cWhGeWhZOVppNmtubnNlUmlFZDY3dXoxTytjM3VqNFJwT0RLQjZBM3JtSzJm?=
 =?utf-8?B?Qi9jNnFEQU1ETHp5V1c0NEVjTkFHSm1qUjNvU3dwY1VOR0o4em5mSm9mUlVY?=
 =?utf-8?B?eEd2cUlGWjNNYTVrY2EveENTRE5GZ2VpbUh0VCtwZW1wczc2Q0M3SUN4dkQ3?=
 =?utf-8?B?bFllNllQd3p1S3lMUUlTeVdXVmpUTVBFOFZZSDgyNitrdUxvZGJqOWlIQ0FB?=
 =?utf-8?B?cHdDd2wrVWtXd040SHFzUXdVRjNtSXhBZ2p4bG9hSnAzWmhnUDhOY0Z5eTM3?=
 =?utf-8?B?NHZJTmFsTldubWVaa1FHNTNGb1RDUWpuZE9LdStQS0llc3FVUlNoeUdka3Fi?=
 =?utf-8?B?Zlp6S1BOS3AyV3o5SDJ2cGZlU2RNcTVVNDlSd01BYjRleUltbGZLL3FKUHFl?=
 =?utf-8?B?d1hxNDlVV2FJbWF4K2Q1TW9pWVJvSkFCTnFRVmdrOVA3ckd3c25BbEdTeDlN?=
 =?utf-8?B?NFloRVM3allzQjM4ektqRENCUXZEUnNxbUV3QituWTFTZGpzTmovS3A1VEJm?=
 =?utf-8?B?cXFuTGNmcVNiUElMWFNwM3lDRWthb21ZR0lDU1dPY1g2YXRBdUtsSld3bkVw?=
 =?utf-8?B?UHB2Z1hGNWh5TmdrbE1kTW10MnM0anZJUllyZXAzNkNvMDAxMVFVY2Y4TnNW?=
 =?utf-8?B?TUJzU3czVTFuOU1ETGpTK0lVWCtJNm5iZDdZMDdUOUs0eHJkNWVRSFlSOElN?=
 =?utf-8?B?U0dMZGlGNWVuVHBwOTFiaFB2L2pCblFscTZDYzZIWXA2RWcwNm9lOVdPRC8x?=
 =?utf-8?B?YUF2YVZIVWprV1gxb2E3T25FVWhCZks1ZzArTUVCdXpYR3phV3laWWJnZlhX?=
 =?utf-8?B?ZGFnZUVDbXpPaTF2dWo5cU9EYjdaMHp3a1FwaStkWEsvMVd4TWcwdzhaMTdu?=
 =?utf-8?B?ZHZLN0l6MU81SFdrMGlDRWxLNitWWFh6OXdrKzN0dXRtejZHK28yalFpU1N5?=
 =?utf-8?B?RFJCUzdrWjhLM21HaFhaNXByR3NPZHI3UjYxK0JsbW02R2x6RGVhdEV2cWlG?=
 =?utf-8?B?VlJzajdoYktzdXB0LzlWelNsejN0MjhudXh5NTFBQkRmM0Y2TG1lLzRZMzFs?=
 =?utf-8?B?aDlHTkdXQ1lJdGJNMlgwRHJWZWJYOFBPdlcvMHZyRHJzanZuNVhJamJYd0Nt?=
 =?utf-8?B?V3crOWNpQWJWNmp5RmZyYUFZMGFFUGFiYTIwbzFGemJmVUtrVUFaalRMYWlY?=
 =?utf-8?B?Q1hnUnJnS2N2MVRGOVBMWThSUHhudkdEV2l3VS9uL29lUmdQTHNOZ1VhU3NY?=
 =?utf-8?B?SWVFb3VybVE1bnNpZFFUNU5WdU0ydVhyOVM2czRCWnA0MjU1QjBZZS94bXhC?=
 =?utf-8?B?TW0zamtKdjE1d1dWbmtjcnRyVk5QemZPbisxY3h6VDFvUHo3Q3RmajVQOHRJ?=
 =?utf-8?B?dUlTays5cXlIR2o2em1FOTN4VEIwN2dlQTN3LzRjU1RHdnRGZVMrcjlSN0dq?=
 =?utf-8?B?ZUh2Y2Y5a2cxL2hLbWhsRktOTjFTSFdna0hkQVpDM1Y4Q29mNnNnWGJpamh1?=
 =?utf-8?B?RnhhVHdBVG83MTJqR2ZuZWdhLy9mVUxjalpsbFovdkFuWnlXN09aVXEwc0lH?=
 =?utf-8?B?S3d5NzlLVzlRU2gxMWlTWE1INHhmbUdLUmZlU2JpT3U1dktXRzhJUVZmT0Ns?=
 =?utf-8?B?bis2dXYzazk4YnVpSGRnSUNrcU9mLzc1djA5WDZxWGJKWmtiR2NJMFJkNndL?=
 =?utf-8?B?aUJTNUpGUGtQMC9xdjhhdHk0Vm94blVXbnFDWnd2NkgzeGcxZlE3WFBhV2hr?=
 =?utf-8?B?eXJkeVNMWXZvNEhZYmJKaVpSL0tKSHIrVU80dTI1dmhsVFFHSDIwL09nZXh5?=
 =?utf-8?B?N2JCQ2Jpb1kwWU5QcXJOVE94VEsrbTBjZzR4em9iYUthdldUL0Q5clRkQnhl?=
 =?utf-8?B?T1NTMUFPNGgzWXE1bU1idkpSM2VMMHRIaWM0U3IyTlpwZDFVSnpyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6546c980-0622-4336-8a17-08de866ee442
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 10:53:16.8712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6Bt47JBH9hxKRuJz+UXAx93BsHs6vsbDwoPfltuuwgpL0A3nX3jfirPt5EvAahopfDy85IPtAhziW/J+ZBuHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614
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


On 20-03-2026 03:43 pm, Christian König wrote:
>
> On 3/20/26 11:02, Khatri, Sunil wrote:
>> On 20-03-2026 03:16 pm, Christian König wrote:
>>> On 3/20/26 10:41, Sunil Khatri wrote:
>>>> There is a possibility of deadlock when last reference to a queue is
>>>> put in certain situations where mutex is already help when calling
>>>> the amdgpu_userq_destroy.
>>>   From functions
>>> As far as I can see that is illegal to begin with. Why are we doing that?
>> This is to fix the deadlock that prike shared and many other places where deadlock could still be caused.
>> There is a possibility of amdgpu_userq_put being called for last reference from amdgpu_userq_restore_worker or amdgpu_eviction_fence_suspend_worker via amdgpu_evf_mgr_shutdown
>> and all these functions already hold the userq_mutex and on last reference when destroy is called it again takes userq_mutex and causing deadlock.
>>
>> Thats why when we are dropping the reference we pass the information of the handled could be called with lock already taken and hence the handling.
> Well that sounds like completely broken handling.
>
> Why are dropping an userqueu reference while holding the lock in the first place?
we are doing at withing the locked state in most of the place in the code.
few examples:
static void amdgpu_userq_restore_worker(struct work_struct *work)
{
     struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, 
resume_work.work);
     struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
     struct dma_fence *ev_fence;
     int ret;

     mutex_lock(&uq_mgr->userq_mutex);
     ev_fence = amdgpu_evf_mgr_get_fence(&fpriv->evf_mgr);
     if (!dma_fence_is_signaled(ev_fence))
         goto unlock;

     ret = amdgpu_userq_vm_validate(uq_mgr);
     if (ret) {
         drm_file_err(uq_mgr->file, "Failed to validate BOs to restore\n");
         goto unlock;
     }

     // Here the restore all is going through all the queues one bye one 
by doing get and put and doing the restore of each queue. Now during put 
if its last reference due to race with another thread in putting we will
call the destroy with locks taken which causes deadlock.
     ret = amdgpu_userq_restore_all(uq_mgr);
     if (ret) {
         drm_file_err(uq_mgr->file, "Failed to restore all queues\n");
         goto unlock;
     }

unlock:
     mutex_unlock(&uq_mgr->userq_mutex);
     dma_fence_put(ev_fence);
}

Another example:
static void
amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
{
     struct amdgpu_eviction_fence_mgr *evf_mgr =
         container_of(work, struct amdgpu_eviction_fence_mgr,
                  suspend_work);
     struct amdgpu_fpriv *fpriv =
         container_of(evf_mgr, struct amdgpu_fpriv, evf_mgr);
     struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
     struct dma_fence *ev_fence;
     bool cookie;

     mutex_lock(&uq_mgr->userq_mutex);

     /*
      * This is intentionally after taking the userq_mutex since we do
      * allocate memory while holding this lock, but only after ensuring 
that
      * the eviction fence is signaled.
      */
     cookie = dma_fence_begin_signalling();

     ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);


/* Here in userq evict we do a ref get and put a various places while 
the mutex is already taken */

     amdgpu_userq_evict(uq_mgr, !evf_mgr->shutdown);

     /*
      * Signaling the eviction fence must be done while holding the
      * userq_mutex. Otherwise we won't resume the queues before issuing the
      * next fence.
      */
     dma_fence_signal(ev_fence);
     dma_fence_end_signalling(cookie);
     dma_fence_put(ev_fence);
     mutex_unlock(&uq_mgr->userq_mutex);

}

Regards
Sunil.


>
> Regards,
> Christian.
>
>> Regards
>> Sunil khatri
>>
>>> Regards,
>>> Christian.
>>>
>>>> So based on the thread where it could be
>>>> locked we pass the locked information in the destroy functionality
>>>> to avoid taking the lock again.
>>>>
>>>> Cc: Liang, Prike <Prike.Liang@amd.com>
>>>> Suggested-by: Liang, Prike <Prike.Liang@amd.com>
>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 52 +++++++++++++------
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  2 +-
>>>>    .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  4 +-
>>>>    3 files changed, 40 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> index ced9ade44be4..9482664e9c2c 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> @@ -617,13 +617,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>>>    }
>>>>      static int
>>>> -amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>>> +amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue,
>>>> +             bool locked)
>>>>    {
>>>>        struct amdgpu_device *adev = uq_mgr->adev;
>>>>        int r = 0;
>>>>    -    cancel_delayed_work_sync(&uq_mgr->resume_work);
>>>> +    /* It safe to unlock since we are in destroy and the queue ref is only this */
>>>> +    if (locked)
>>>> +        mutex_unlock(&uq_mgr->userq_mutex);
>>>>    +    cancel_delayed_work_sync(&uq_mgr->resume_work);
>>>>        /* Cancel any pending hang detection work and cleanup */
>>>>        cancel_delayed_work_sync(&queue->hang_detect_work);
>>>>    @@ -657,13 +661,27 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>>>>            queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>>        }
>>>>        amdgpu_userq_cleanup(queue);
>>>> -    mutex_unlock(&uq_mgr->userq_mutex);
>>>> +
>>>> +    if (!locked)
>>>> +        mutex_unlock(&uq_mgr->userq_mutex);
>>>>          pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>>          return r;
>>>>    }
>>>>    +static void amdgpu_userq_kref_destroy_locked(struct kref *kref)
>>>> +{
>>>> +    int r;
>>>> +    struct amdgpu_usermode_queue *queue =
>>>> +        container_of(kref, struct amdgpu_usermode_queue, refcount);
>>>> +    struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>>>> +
>>>> +    r = amdgpu_userq_destroy(uq_mgr, queue, true);
>>>> +    if (r)
>>>> +        drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
>>>> +}
>>>> +
>>>>    static void amdgpu_userq_kref_destroy(struct kref *kref)
>>>>    {
>>>>        int r;
>>>> @@ -671,7 +689,7 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
>>>>            container_of(kref, struct amdgpu_usermode_queue, refcount);
>>>>        struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>>>>    -    r = amdgpu_userq_destroy(uq_mgr, queue);
>>>> +    r = amdgpu_userq_destroy(uq_mgr, queue, false);
>>>>        if (r)
>>>>            drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
>>>>    }
>>>> @@ -689,10 +707,14 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
>>>>        return queue;
>>>>    }
>>>>    -void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
>>>> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue, bool locked)
>>>>    {
>>>> -    if (queue)
>>>> -        kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
>>>> +    if (queue) {
>>>> +        if (locked)
>>>> +            kref_put(&queue->refcount, amdgpu_userq_kref_destroy_locked);
>>>> +        else
>>>> +            kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
>>>> +    }
>>>>    }
>>>>      static int amdgpu_userq_priority_permit(struct drm_file *filp,
>>>> @@ -978,7 +1000,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>>>            if (!queue)
>>>>                return -ENOENT;
>>>>    -        amdgpu_userq_put(queue);
>>>> +        amdgpu_userq_put(queue, false);
>>>>            break;
>>>>        }
>>>>    @@ -1007,7 +1029,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>>>                drm_file_err(uq_mgr->file,
>>>>                         "trying restore queue without va mapping\n");
>>>>                queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
>>>> -            amdgpu_userq_put(queue);
>>>> +            amdgpu_userq_put(queue, true);
>>>>                continue;
>>>>            }
>>>>    @@ -1015,7 +1037,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>>>            if (r)
>>>>                ret = r;
>>>>    -        amdgpu_userq_put(queue);
>>>> +        amdgpu_userq_put(queue, true);
>>>>        }
>>>>          if (ret)
>>>> @@ -1258,7 +1280,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>>>>            r = amdgpu_userq_preempt_helper(queue);
>>>>            if (r)
>>>>                ret = r;
>>>> -        amdgpu_userq_put(queue);
>>>> +        amdgpu_userq_put(queue, true);
>>>>        }
>>>>          if (ret)
>>>> @@ -1298,17 +1320,17 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>>>>            struct dma_fence *f = queue->last_fence;
>>>>              if (!f || dma_fence_is_signaled(f)) {
>>>> -            amdgpu_userq_put(queue);
>>>> +            amdgpu_userq_put(queue, true);
>>>>                continue;
>>>>            }
>>>>            ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>>>>            if (ret <= 0) {
>>>>                drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>>>>                         f->context, f->seqno);
>>>> -            amdgpu_userq_put(queue);
>>>> +            amdgpu_userq_put(queue, true);
>>>>                return -ETIMEDOUT;
>>>>            }
>>>> -        amdgpu_userq_put(queue);
>>>> +        amdgpu_userq_put(queue, true);
>>>>        }
>>>>          return 0;
>>>> @@ -1366,7 +1388,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>>>            if (!queue)
>>>>                break;
>>>>    -        amdgpu_userq_put(queue);
>>>> +        amdgpu_userq_put(queue, false);
>>>>        }
>>>>          xa_destroy(&userq_mgr->userq_xa);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>> index f0abc16d02cc..2a496e74ec6a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>> @@ -116,7 +116,7 @@ struct amdgpu_db_info {
>>>>    };
>>>>      struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
>>>> -void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
>>>> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue, bool locked);
>>>>      int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>>>>    diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> index 18390d37a7e0..10e08cb6bd13 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> @@ -612,7 +612,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>>        kfree(syncobj_handles);
>>>>          if (queue)
>>>> -        amdgpu_userq_put(queue);
>>>> +        amdgpu_userq_put(queue, false);
>>>>          return r;
>>>>    }
>>>> @@ -914,7 +914,7 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>>            r = 0;
>>>>      put_waitq:
>>>> -    amdgpu_userq_put(waitq);
>>>> +    amdgpu_userq_put(waitq, false);
>>>>      free_fences:
>>>>        while (num_fences--)
