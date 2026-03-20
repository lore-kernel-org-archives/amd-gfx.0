Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A15F108B911
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 12:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3961B10EA96;
	Fri, 20 Mar 2026 12:11:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vp3AOBpS";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44CB210EA96
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 12:11:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wI5BKIfNmAA4fgRY8sLeputbJuT2vCDxxf2S7a/zZAdFvYYH0GfmhhAnyBJtKRGweqQ+c15q0LD4KzL3xZKArqfEUV1Y8Mat8pzPnqfjY4DTp58qNvMZ2LCxvt1G6Bk0EmVKkiT1mDhoozjQx8lH5+ujpESXXH0v5WBwPU8QuEYmrHhrkysBd63LMxnzXWkNWy7F7bZD6w8c7cysJkTyPzDZ7PByrL+KmG0++nnanrr2UaThGxryGKfCZSnE8gbNIs5t5UDkKgQzkDiumM3ftWUdl3+Ded12O9d94lrhMmwF771gtcXzF6pqnZmJziOrsJRjUGYIwZlx8vfwn0cHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP9w5SM/3D50PIqGmYhzfeTFuP9oQISKC6lD+2G8xUg=;
 b=r3p2G9sfFWmvD86zDYN8H4yoYz3kFqmSkvGat3k3kU/HKy8je8GKt2eYp6gBVWMBipHo/PG64RvEH1A+fGAFxrpJvfFeX27jKxoaXs1E1k5OmpSLt43usE5qmG5bnoouRuvrKdoEmkgwnI5fXqL3+xlCmSJZGTqm2YWnOQmOPvmPPzdtbRGIqs83DelPOLvCjyZNauy8ffm5wJdjotS4/0ZduKq/tdzAgoiuGfSBkoF87/Z5483e+1PvoeYyM8M+F6iKHuzbwPMdhr9gMwcUmZx0Xis9vRF/bi75y26T8VDrF6eRCm7yHUs3CCn9WO8fucXTCI24IlMEOZ8GN5FN5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP9w5SM/3D50PIqGmYhzfeTFuP9oQISKC6lD+2G8xUg=;
 b=vp3AOBpSyC9uA3T0syDy3ACva7BqOkrhR1qrVA+ykbBEa4Z0uCfZ3AOx/K7wNI8n782Vfr0LtWTJPdQw0C9b2pQOV5cfZIIBSKRnO5nsZ8d1gEDzeleuR1N5xdMYXQrvlegRXmW0jDVBgdzJFL5qFPVBakT/+gqYiS8+HMhPaRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 20 Mar
 2026 12:11:01 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9745.012; Fri, 20 Mar 2026
 12:11:01 +0000
Message-ID: <8251843c-db9b-4841-a6d8-807bbd4e5fe6@amd.com>
Date: Fri, 20 Mar 2026 17:40:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: add mutex lock/unlocked version of
 amdgpu_userq_put
From: "Khatri, Sunil" <sukhatri@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Liang@rtg-sunil-navi33.amd.com,
 Prike <Prike.Liang@amd.com>
References: <20260320094111.3640176-1-sunil.khatri@amd.com>
 <df195a01-e228-4f14-9e20-ecb63dc9d653@amd.com>
 <21c8b934-7973-47f7-9a13-77c7b18530d2@amd.com>
 <99f813b0-54e2-40d0-9fce-00d1f1f52641@amd.com>
 <78e16a87-de53-448d-94f6-13c7fa99596b@amd.com>
 <9481ee5c-fc2d-4b65-b3bc-cdcdb3180136@amd.com>
 <df13f705-78c5-4e3a-86bf-8fc969b30d5c@amd.com>
Content-Language: en-US
In-Reply-To: <df13f705-78c5-4e3a-86bf-8fc969b30d5c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0212.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::9) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a6226d2-f365-47e2-c1d2-08de8679c053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: gdBZu6VJsttsTocp7zTyTemH+zYvZUD9OrWHZ544IUuzCzc3X9IixKDeGKV+b2ISX/E9WB51ynzvmOvDTe/Re4JOZ0XgIacaSn8jnd31PxBN8y9oSK7bXrLYe8QkeLV+8Kq3Rle/0zDiF38PNxKJSQD/N1FqO+lXmHoI+oNoniJjv9BmlGuv4c7ExfR0GQIH3CauQ8OrNxtbN8gqKn1+2cnEpg/QOTif/fKHYA4/1oPd//HPRYSEwQRBtCYv80zhkdEKZ7GI35wlZQOd6QLrYR2yjtfQonjTrZQLx52bCDU2hJ8XuXJryXlP3Jjo1V2RNLgY1JhygB+iCWEWH2n9D00cmEegEAm95qTQe67OQT2XnEH8XJE9E3C4RkYbJTcEF7eIiYjjZZ97+STtrrtiSYuY8cmeTmlT1ip0t8Zdas8JBjlWvm12SvdPuDqlPrexkokjEJk8nb/Y8hoYzu0UQ40K3wVGzreWAIsVq8XpmsSnymRFHQ4uhLFQI51XOu1k58TG6Y7ZB1fTiO71DpTg2CJ9kKgdRfZzxMT0z+Pj+FKKt1XiiSBLSB+evvvCA4x10Fl+aDtKWYtztksX8SLHvawxwHvVjk0ftHhSJtlX2+1/W0GdAYg8xGiGJwNSxQV/dRwisPhlCzCGSRORgRrBWTUtD90FDmIozy9gBelfSsGGLoNePmw9k451L+ZmLzUW0AHTLM6Ga8QfXbH9d/o+PdcAHmpwO2l63l+rF4VPv9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkt1YjNERnhVQ295QnVZV21FR2sweE5TRzNXUUtGYjUrVjlZeElsdTU4NjZj?=
 =?utf-8?B?NmVNNUV4aWlXc1FKTUI4cHdOTVN5Q0pWZ3l5NTdYOXJrclphNmJBdnoxT2l2?=
 =?utf-8?B?VFdsdWJzdmN3Sm1GV3hZMmE5aCtEdFFJdmg2VEczREhFUU82NXNkbFJITS9t?=
 =?utf-8?B?U0pCUzBZbHhHWm9qNmtrUzk5M2JTTTdIM2l0VVFyWUVZVkJMZjdiMVB6bmU1?=
 =?utf-8?B?ZU84UUZXS2dLcStsM1hLbHJUbC9DNDlzN21XQ1Z1OGJ5R0ZET1dIb3JIK3pq?=
 =?utf-8?B?RDcxSmZlSjJMaXdsRXpTUVE3WFFYakJXemdzZURydm52SHJ0S3BUYzJ3QjBL?=
 =?utf-8?B?bGlkUitWdGcvQnpDeFlBSXZtOW5OSHdlZEdNbzFKZmMrbGJlZDJvT3pvT3o2?=
 =?utf-8?B?QWluMUFTU3pIMnM0eXN6MUFIUDI1MjVLVUJyWXk2a2FKM0o5OXlVUGJITHBV?=
 =?utf-8?B?U1RyMFNJR2pPS2xqdkJUSEZleU9nV3dOd1pDWnJKb2wvZ25JV2hyajNQN1Y0?=
 =?utf-8?B?eW4xVDMxdjhPNlVrZVdlUG9CazFOQWVWWVd4LzdwbTRjdDRUNnpqYiszTmw1?=
 =?utf-8?B?UEl1TWhSVktwdXJPcG9taVQrWVQzYzhhVlh2OU9hY2g3bEJPNjJRZklUTy9E?=
 =?utf-8?B?LzloT2VhT21Ia2tJM2pLZHlFVHBrVUNjeFptQUZwZ1BFdlM1a3VVa2VrbENB?=
 =?utf-8?B?SHNCSk1teUw3azVCeGdGMy9rOXBabVlJaWNzZ3N0NmlobVNMRCtCWDREak12?=
 =?utf-8?B?S2I4Q2kvOVc5d3M0Ymw0UElxeTZRUllXSUZJemdFTllxZjFselFUVDNZeklx?=
 =?utf-8?B?cEtiNmpKbVVGWXc3MVB5UHFoRUxJWHlNQXQzSm9SajVZUThoOC9nUkJ4VDVw?=
 =?utf-8?B?ZjBMSzdGR1RBcU9aRjAxOE9jY1FuQldwbnU0NGo3b1dscVZJSFgyZjdIS2FN?=
 =?utf-8?B?MU84UXpWQVB4ekljTlpzelVaalJDbXFqYVZxbVlkQ2FrV2dPNXZvVmg1bjVM?=
 =?utf-8?B?emZKbk1vRFdyN0ZIRUlXRU1mSDdnbUJUNy96QVgyQTBUa0RXK3dWNnR5MDhl?=
 =?utf-8?B?eTB4RmhMOU52RXlWMXZNWGt5RHFKZ2h3TzRCdytxMjJjV2s1SUk4aGszay9n?=
 =?utf-8?B?RmFKRWlYcTc5NS8yL2V4SVo5SDU0OExkMUZVWU04aWtRcGpSd3ZaR3Z5ZEdV?=
 =?utf-8?B?ODJYQVFYZ241UmtnY1RuSi94Q0tYWnBhV2ZmTGtIeWFOTlQzNzZTRmp6MUl5?=
 =?utf-8?B?T3grei90aWt0enRQdXl4UkYwNm5hbm1FMXdsaE83OCtpcm5kb1lQVnBEZ0VZ?=
 =?utf-8?B?V3VCeFExL0cvdkw3MkRUSHAzV3diOEVsdENPUitUbWlVVm9NTzJBR0ZhR284?=
 =?utf-8?B?VjJ4VEMrVVF1UTBMZFkyQk1DdkpTUVJaaEtKa3FIZzIrTXA3ZDBocitibnlL?=
 =?utf-8?B?cjUzSWhlY2cvcWozQ2RWTWdaK1c3bTVLNllaMWpYS2llTm1JWGdVQkZqQ2Z1?=
 =?utf-8?B?RWJWSmwzaFdnd2d5Q0FUeWxWbzF1bjhGMVN5a3ZNQytadWZHYjZEZ2dvNXVC?=
 =?utf-8?B?Nm9iakxjV3NnWktDUHBndkxTZEw0SFdMZXRzOVpoa1VFYVN1VWUzS2dhdDlq?=
 =?utf-8?B?ZmlXckNkU201OFJmUkpic291RzJoZDFQNG1XdkxrQzh4RGRiT3BIL3REeDlj?=
 =?utf-8?B?aG9uNlpzMVNmTkwzS3grVzh3MnVkYllUazRwdExuNmU4REZ1V1NHYVZ5a3lj?=
 =?utf-8?B?emVVUFFhdEY5eXlCVUlaYTJSVzVxUWtpd2dtdWk5OTcyQ1hQblJsTTBDekNS?=
 =?utf-8?B?dEk5cHZQSERWVm9IcnhONy9YMnY1MGZZaGs1Uk5UUllKSEo0WW5lN0lrdElN?=
 =?utf-8?B?V3dkaVJSQ0VhTjFYaW0vb2o2QkpKTUkzNU01bG5FY3BmaWgxdE1tbzVaREVE?=
 =?utf-8?B?WjBWMkk4YnZoTXZwcWhHM3RwTWpvTUcvNjIvK1g3cjhDd21iZ0dISkl6WlN4?=
 =?utf-8?B?OVZZQldBcm1na0VHTzdiNUp2V0VWTnUxaXhXQ1pQczZUWmdUT09FeGhhRUw2?=
 =?utf-8?B?YkRBK25XTENWa3RFQzN5bitQMzFSdE45U0ZxOFk2UTgzMXRHaXgvR3Yvc1FG?=
 =?utf-8?B?cEN3dmhOZnBLWW03TXRQRks4VTdST1U3blBOaEhKMVR2cjdaSGo5T0FrT1Aw?=
 =?utf-8?B?TjVKSDV6Mm9oSmxWQVVsYzVKUjBLQ3ZCNXZDeHJFWFhGUG45NHhVYnJWSlhB?=
 =?utf-8?B?M29pRnNpVTNMVUhncSt1cWlpTEsydVhDUHNUOTF0SmJNUS80ekUwcnJyRC9r?=
 =?utf-8?B?UG5vaHo3VE1pUDVXVktHY0tiOWdsbDd6UVlYTXpzdERPc0E3YWR5dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6226d2-f365-47e2-c1d2-08de8679c053
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 12:11:01.2807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aizqDKqcf6j3ZqR5+cGi1/jYyOzqjJFLjkjHh4S8QaTmujiwwGk2oYKhsPZE8og1KIqk+jHe+YIWVMyTFU1rEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742
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

Sent a different patch to fix the irrelevant get/put.
drm/amdgpu/userq: cleanup amdgpu_userq_get/put where not needed

regards
Sunil khatri

On 20-03-2026 04:44 pm, Khatri, Sunil wrote:
>
> On 20-03-2026 04:27 pm, Christian König wrote:
>> On 3/20/26 11:53, Khatri, Sunil wrote:
>>> On 20-03-2026 03:43 pm, Christian König wrote:
>>>> On 3/20/26 11:02, Khatri, Sunil wrote:
>>>>> On 20-03-2026 03:16 pm, Christian König wrote:
>>>>>> On 3/20/26 10:41, Sunil Khatri wrote:
>>>>>>> There is a possibility of deadlock when last reference to a 
>>>>>>> queue is
>>>>>>> put in certain situations where mutex is already help when calling
>>>>>>> the amdgpu_userq_destroy.
>>>>>>    From functions
>>>>>> As far as I can see that is illegal to begin with. Why are we 
>>>>>> doing that?
>>>>> This is to fix the deadlock that prike shared and many other 
>>>>> places where deadlock could still be caused.
>>>>> There is a possibility of amdgpu_userq_put being called for last 
>>>>> reference from amdgpu_userq_restore_worker or 
>>>>> amdgpu_eviction_fence_suspend_worker via amdgpu_evf_mgr_shutdown
>>>>> and all these functions already hold the userq_mutex and on last 
>>>>> reference when destroy is called it again takes userq_mutex and 
>>>>> causing deadlock.
>>>>>
>>>>> Thats why when we are dropping the reference we pass the 
>>>>> information of the handled could be called with lock already taken 
>>>>> and hence the handling.
>>>> Well that sounds like completely broken handling.
>>>>
>>>> Why are dropping an userqueu reference while holding the lock in 
>>>> the first place?
>>> we are doing at withing the locked state in most of the place in the 
>>> code.
>>> few examples:
>>> static void amdgpu_userq_restore_worker(struct work_struct *work)
>>> {
>>>      struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, 
>>> resume_work.work);
>>>      struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>>>      struct dma_fence *ev_fence;
>>>      int ret;
>>>
>>>      mutex_lock(&uq_mgr->userq_mutex);
>>>      ev_fence = amdgpu_evf_mgr_get_fence(&fpriv->evf_mgr);
>>>      if (!dma_fence_is_signaled(ev_fence))
>>>          goto unlock;
>>>
>>>      ret = amdgpu_userq_vm_validate(uq_mgr);
>>>      if (ret) {
>>>          drm_file_err(uq_mgr->file, "Failed to validate BOs to 
>>> restore\n");
>>>          goto unlock;
>>>      }
>>>
>>>      // Here the restore all is going through all the queues one bye 
>>> one by doing get and put
>> That is ok, the question is why the heck is doing that get/put? See 
>> we need get/put because we are *not* holding the lock.
>>
>> When we are holding the lock no get/put is needed at all.
> Got your point. In that case there is a bug in code and this could be 
> resolved with clean up or doing get/put where queue mutex is not locked.
> Will send the update here.
>
> Regards
> Sunil Khatri
>>
>> Regards,
>> Christian.
>>
>>> and doing the restore of each queue. Now during put if its last 
>>> reference due to race with another thread in putting we will
>>> call the destroy with locks taken which causes deadlock.
>>>      ret = amdgpu_userq_restore_all(uq_mgr);
>>>      if (ret) {
>>>          drm_file_err(uq_mgr->file, "Failed to restore all queues\n");
>>>          goto unlock;
>>>      }
>>>
>>> unlock:
>>>      mutex_unlock(&uq_mgr->userq_mutex);
>>>      dma_fence_put(ev_fence);
>>> }
>>>
>>> Another example:
>>> static void
>>> amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>>> {
>>>      struct amdgpu_eviction_fence_mgr *evf_mgr =
>>>          container_of(work, struct amdgpu_eviction_fence_mgr,
>>>                   suspend_work);
>>>      struct amdgpu_fpriv *fpriv =
>>>          container_of(evf_mgr, struct amdgpu_fpriv, evf_mgr);
>>>      struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>>>      struct dma_fence *ev_fence;
>>>      bool cookie;
>>>
>>>      mutex_lock(&uq_mgr->userq_mutex);
>>>
>>>      /*
>>>       * This is intentionally after taking the userq_mutex since we do
>>>       * allocate memory while holding this lock, but only after 
>>> ensuring that
>>>       * the eviction fence is signaled.
>>>       */
>>>      cookie = dma_fence_begin_signalling();
>>>
>>>      ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
>>>
>>>
>>> /* Here in userq evict we do a ref get and put a various places 
>>> while the mutex is already taken */
>>>
>>>      amdgpu_userq_evict(uq_mgr, !evf_mgr->shutdown);
>>>
>>>      /*
>>>       * Signaling the eviction fence must be done while holding the
>>>       * userq_mutex. Otherwise we won't resume the queues before 
>>> issuing the
>>>       * next fence.
>>>       */
>>>      dma_fence_signal(ev_fence);
>>>      dma_fence_end_signalling(cookie);
>>>      dma_fence_put(ev_fence);
>>>      mutex_unlock(&uq_mgr->userq_mutex);
>>>
>>> }
>>>
>>> Regards
>>> Sunil.
>>>
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Regards
>>>>> Sunil khatri
>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>> So based on the thread where it could be
>>>>>>> locked we pass the locked information in the destroy functionality
>>>>>>> to avoid taking the lock again.
>>>>>>>
>>>>>>> Cc: Liang, Prike <Prike.Liang@amd.com>
>>>>>>> Suggested-by: Liang, Prike <Prike.Liang@amd.com>
>>>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 52 
>>>>>>> +++++++++++++------
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  2 +-
>>>>>>>     .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  4 +-
>>>>>>>     3 files changed, 40 insertions(+), 18 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>>> index ced9ade44be4..9482664e9c2c 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>>> @@ -617,13 +617,17 @@ amdgpu_userq_get_doorbell_index(struct 
>>>>>>> amdgpu_userq_mgr *uq_mgr,
>>>>>>>     }
>>>>>>>       static int
>>>>>>> -amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct 
>>>>>>> amdgpu_usermode_queue *queue)
>>>>>>> +amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct 
>>>>>>> amdgpu_usermode_queue *queue,
>>>>>>> +             bool locked)
>>>>>>>     {
>>>>>>>         struct amdgpu_device *adev = uq_mgr->adev;
>>>>>>>         int r = 0;
>>>>>>>     - cancel_delayed_work_sync(&uq_mgr->resume_work);
>>>>>>> +    /* It safe to unlock since we are in destroy and the queue 
>>>>>>> ref is only this */
>>>>>>> +    if (locked)
>>>>>>> +        mutex_unlock(&uq_mgr->userq_mutex);
>>>>>>>     + cancel_delayed_work_sync(&uq_mgr->resume_work);
>>>>>>>         /* Cancel any pending hang detection work and cleanup */
>>>>>>> cancel_delayed_work_sync(&queue->hang_detect_work);
>>>>>>>     @@ -657,13 +661,27 @@ amdgpu_userq_destroy(struct 
>>>>>>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>>>>>>>             queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>>>>>         }
>>>>>>>         amdgpu_userq_cleanup(queue);
>>>>>>> -    mutex_unlock(&uq_mgr->userq_mutex);
>>>>>>> +
>>>>>>> +    if (!locked)
>>>>>>> +        mutex_unlock(&uq_mgr->userq_mutex);
>>>>>>> pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>>>>>           return r;
>>>>>>>     }
>>>>>>>     +static void amdgpu_userq_kref_destroy_locked(struct kref 
>>>>>>> *kref)
>>>>>>> +{
>>>>>>> +    int r;
>>>>>>> +    struct amdgpu_usermode_queue *queue =
>>>>>>> +        container_of(kref, struct amdgpu_usermode_queue, 
>>>>>>> refcount);
>>>>>>> +    struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>>>>>>> +
>>>>>>> +    r = amdgpu_userq_destroy(uq_mgr, queue, true);
>>>>>>> +    if (r)
>>>>>>> +        drm_file_err(uq_mgr->file, "Failed to destroy usermode 
>>>>>>> queue %d\n", r);
>>>>>>> +}
>>>>>>> +
>>>>>>>     static void amdgpu_userq_kref_destroy(struct kref *kref)
>>>>>>>     {
>>>>>>>         int r;
>>>>>>> @@ -671,7 +689,7 @@ static void amdgpu_userq_kref_destroy(struct 
>>>>>>> kref *kref)
>>>>>>>             container_of(kref, struct amdgpu_usermode_queue, 
>>>>>>> refcount);
>>>>>>>         struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>>>>>>>     -    r = amdgpu_userq_destroy(uq_mgr, queue);
>>>>>>> +    r = amdgpu_userq_destroy(uq_mgr, queue, false);
>>>>>>>         if (r)
>>>>>>>             drm_file_err(uq_mgr->file, "Failed to destroy 
>>>>>>> usermode queue %d\n", r);
>>>>>>>     }
>>>>>>> @@ -689,10 +707,14 @@ struct amdgpu_usermode_queue 
>>>>>>> *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
>>>>>>>         return queue;
>>>>>>>     }
>>>>>>>     -void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
>>>>>>> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue, bool 
>>>>>>> locked)
>>>>>>>     {
>>>>>>> -    if (queue)
>>>>>>> -        kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
>>>>>>> +    if (queue) {
>>>>>>> +        if (locked)
>>>>>>> +            kref_put(&queue->refcount, 
>>>>>>> amdgpu_userq_kref_destroy_locked);
>>>>>>> +        else
>>>>>>> +            kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
>>>>>>> +    }
>>>>>>>     }
>>>>>>>       static int amdgpu_userq_priority_permit(struct drm_file 
>>>>>>> *filp,
>>>>>>> @@ -978,7 +1000,7 @@ int amdgpu_userq_ioctl(struct drm_device 
>>>>>>> *dev, void *data,
>>>>>>>             if (!queue)
>>>>>>>                 return -ENOENT;
>>>>>>>     -        amdgpu_userq_put(queue);
>>>>>>> +        amdgpu_userq_put(queue, false);
>>>>>>>             break;
>>>>>>>         }
>>>>>>>     @@ -1007,7 +1029,7 @@ amdgpu_userq_restore_all(struct 
>>>>>>> amdgpu_userq_mgr *uq_mgr)
>>>>>>>                 drm_file_err(uq_mgr->file,
>>>>>>>                          "trying restore queue without va 
>>>>>>> mapping\n");
>>>>>>>                 queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
>>>>>>> -            amdgpu_userq_put(queue);
>>>>>>> +            amdgpu_userq_put(queue, true);
>>>>>>>                 continue;
>>>>>>>             }
>>>>>>>     @@ -1015,7 +1037,7 @@ amdgpu_userq_restore_all(struct 
>>>>>>> amdgpu_userq_mgr *uq_mgr)
>>>>>>>             if (r)
>>>>>>>                 ret = r;
>>>>>>>     -        amdgpu_userq_put(queue);
>>>>>>> +        amdgpu_userq_put(queue, true);
>>>>>>>         }
>>>>>>>           if (ret)
>>>>>>> @@ -1258,7 +1280,7 @@ amdgpu_userq_evict_all(struct 
>>>>>>> amdgpu_userq_mgr *uq_mgr)
>>>>>>>             r = amdgpu_userq_preempt_helper(queue);
>>>>>>>             if (r)
>>>>>>>                 ret = r;
>>>>>>> -        amdgpu_userq_put(queue);
>>>>>>> +        amdgpu_userq_put(queue, true);
>>>>>>>         }
>>>>>>>           if (ret)
>>>>>>> @@ -1298,17 +1320,17 @@ amdgpu_userq_wait_for_signal(struct 
>>>>>>> amdgpu_userq_mgr *uq_mgr)
>>>>>>>             struct dma_fence *f = queue->last_fence;
>>>>>>>               if (!f || dma_fence_is_signaled(f)) {
>>>>>>> -            amdgpu_userq_put(queue);
>>>>>>> +            amdgpu_userq_put(queue, true);
>>>>>>>                 continue;
>>>>>>>             }
>>>>>>>             ret = dma_fence_wait_timeout(f, true, 
>>>>>>> msecs_to_jiffies(100));
>>>>>>>             if (ret <= 0) {
>>>>>>>                 drm_file_err(uq_mgr->file, "Timed out waiting 
>>>>>>> for fence=%llu:%llu\n",
>>>>>>>                          f->context, f->seqno);
>>>>>>> -            amdgpu_userq_put(queue);
>>>>>>> +            amdgpu_userq_put(queue, true);
>>>>>>>                 return -ETIMEDOUT;
>>>>>>>             }
>>>>>>> -        amdgpu_userq_put(queue);
>>>>>>> +        amdgpu_userq_put(queue, true);
>>>>>>>         }
>>>>>>>           return 0;
>>>>>>> @@ -1366,7 +1388,7 @@ void amdgpu_userq_mgr_fini(struct 
>>>>>>> amdgpu_userq_mgr *userq_mgr)
>>>>>>>             if (!queue)
>>>>>>>                 break;
>>>>>>>     -        amdgpu_userq_put(queue);
>>>>>>> +        amdgpu_userq_put(queue, false);
>>>>>>>         }
>>>>>>>           xa_destroy(&userq_mgr->userq_xa);
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>>>> index f0abc16d02cc..2a496e74ec6a 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>>>> @@ -116,7 +116,7 @@ struct amdgpu_db_info {
>>>>>>>     };
>>>>>>>       struct amdgpu_usermode_queue *amdgpu_userq_get(struct 
>>>>>>> amdgpu_userq_mgr *uq_mgr, u32 qid);
>>>>>>> -void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
>>>>>>> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue, bool 
>>>>>>> locked);
>>>>>>>       int amdgpu_userq_ioctl(struct drm_device *dev, void *data, 
>>>>>>> struct drm_file *filp);
>>>>>>>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>>>> index 18390d37a7e0..10e08cb6bd13 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>>>> @@ -612,7 +612,7 @@ int amdgpu_userq_signal_ioctl(struct 
>>>>>>> drm_device *dev, void *data,
>>>>>>>         kfree(syncobj_handles);
>>>>>>>           if (queue)
>>>>>>> -        amdgpu_userq_put(queue);
>>>>>>> +        amdgpu_userq_put(queue, false);
>>>>>>>           return r;
>>>>>>>     }
>>>>>>> @@ -914,7 +914,7 @@ amdgpu_userq_wait_return_fence_info(struct 
>>>>>>> drm_file *filp,
>>>>>>>             r = 0;
>>>>>>>       put_waitq:
>>>>>>> -    amdgpu_userq_put(waitq);
>>>>>>> +    amdgpu_userq_put(waitq, false);
>>>>>>>       free_fences:
>>>>>>>         while (num_fences--)
