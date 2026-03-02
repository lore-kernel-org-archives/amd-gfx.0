Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FB8EB362A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 18:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45676888D9;
	Mon,  2 Mar 2026 18:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X+b7mAOk";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013004.outbound.protection.outlook.com
 [40.107.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4739710E576
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 18:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqd4xtTMRi4IXj8mzFJgZYDbPl9QkPjYrLFpqaj64DMLRov9Hw9kWfGzpkKS0JQefRif+rV5NVLNcX9xtHkuQGeitgjvGM/EXmQ+IZs2gd6vW3tUQDZWszPsApySJXqu6tRx6Ipt9t5Xr7KwE9AnkJGRKluT0LIkVZ4sDqyuEitXqLlSagvuLnNGfeCpvXvpACamE5G2Ul9nYtRyC7OBxUaTPOCb6oQyzV0QsPGXx3jmssGSePDuiF0tf+UjRpA/EcLXhfV+HyZxlMXUVo2Cy1Ks6jLlSYaDqRfuxFLLRd6f2+w19foNzfOs0x3sBrzx8NzI1kLtEbG1CYSCZn0NQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gi0aulR+hhwA/AZH7m039ppND+1Q/uJD2UDLMJCqrVo=;
 b=noMHNhwIa6DfaiEvdXDroqo2IFZa35sOeoC8yOFl0q1R6RT8dTI2mFv+ngAg4F+/xWQQQW1SshhdW1rcYUPMWMH7CHtCVcPIyiq7Oj743FdKrfSuf20n5ZJyiG2e8NMlzYUzpJoB2+5kI7wEJypZGeWwqzbfIvNLXUXbEnrGUY4nAWBbBvOd/4zwYCMd/LY23Ml/MJ6wOf1e9VnopRcshVjMMhoxaDOF1EQEfVItslp/YeTI2cC85FeLgzdgzIjpajUSx2kDzAAiIffFynnb0Z1W++9FtS8JpR4aFythsIZ5v6QhSXAlprGwDh294D5qivXHIxncPwB7ArkVAn6Hug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gi0aulR+hhwA/AZH7m039ppND+1Q/uJD2UDLMJCqrVo=;
 b=X+b7mAOkuvFXGilYEm2UoGUWVzZLBn4Q4+J69wJBoGKJqg+tbwxEHkP78nzKuIEyCWKXjjzKrgg/ZrnerO1GK0P7+o0s3Jx2dhFl2dHq1XlIicD3R06471vxdwd7GtktTSVNLQ2t5DSFNhAntLi3Hf4qIg7waGmcGhqFSXF+qoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SA3PR12MB7999.namprd12.prod.outlook.com (2603:10b6:806:312::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 18:04:10 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 18:04:07 +0000
Message-ID: <a2de1919-a800-413c-8966-82a459ef034a@amd.com>
Date: Mon, 2 Mar 2026 23:34:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu/userq: refcount userqueues to avoid any
 race conditions
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260302133554.1233013-1-sunil.khatri@amd.com>
 <CADnq5_NBdpKBvuVGWe2=po-aKwvszS4EWhmCH8hOCZzxjKW=tg@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_NBdpKBvuVGWe2=po-aKwvszS4EWhmCH8hOCZzxjKW=tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0240.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::12) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SA3PR12MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 85245267-f761-4aaf-1d59-08de788618f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: qp+YJkfrZIxPCpgHzyHg+aGi3L+iwUedQw95uYBsA1mkZg0ccTd91dZjVjsfap7/f7U1xF7tIlckj3PQNrge3DfnKhkyySrPoIFDHPhBQABl6P2EaC04eX8wcimfHzMshBqgruV1bAcoyYjwCFZBvd0YC4wtR5lg5WwWPhX3qQkVfwliNQq51bJCQyvfLNo4U4CLuTwfkCHkpGIuUxCk2QDHuA5vdR73FypH/+srqwVZxa4+run4YoqwjgTWyCnlLwkonRz3kUAJ7PZnPwRMaFZreENmLVsgRp/kAsnYCPBtzd6gIuNd2nbocyxQZjtrBpVEq7m504a168xHihHG5UolPW9TBO04FXheLIrS36o/qWwWBChdMS7eF5I5L79u0fLNaDoSinN+QW4lTh3T2iQcgGOqhuMry2qFJHGt3GIQYpFz7cGcc/Kj4Z6DVQvoG0Gk+1RE46Kl6S3IlXYDbVt4//OUCaqtWnj0fcAVu6fnV8NKrwSeEx9A+M/PbOfdLJAtFKoOJAr4AQgRW6wg7GCyc5+npwfFYwohawFdDKLyoZBFVcViB7tucblzHobXWDT9Qq8aQMwNJqMCVBmZfk5pZ1twwG05FsQeiISik47xDT/zx0+2cLObAJIbDD9cho6+rScM7sBNUa0AjG8SR6rSXz8W6opprT2FoR/8tsmEu2yWegNPBiHzGSYkk/nOGMH+e679bDKCNgqta9nCaSRoAMTkGjsIla4YJLNep+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTRPRHNOdlhYeXp2c0dMWTVzaUp6L1B4T0lLcDVxQmRZbWZESC8rVGlRV0Zy?=
 =?utf-8?B?YTFPZC9mcTNiYTk5eEozNlBvZ3FrNzc5UStHTmpoSC9BZmllY0dPT0FlZzdy?=
 =?utf-8?B?c051b1JCNlp6SGJJQk1vZXFoSzBzL1V0SE1rRzY2QzNoV0lFZHp1RE1HeXJ6?=
 =?utf-8?B?UEVzRFQzc250ZFZnU3BGMzNxdHk0VFJ5ZjdIU0hhTkFwQXZBRUl3dkhwczBs?=
 =?utf-8?B?OFR0Uk4zN0JONEtwV0dTVjdjTjkyNVlBaUpyeENYSDV1WnRIN1FzQVBYTDI2?=
 =?utf-8?B?YUoxT0prMXZsZHRVMHg5TEoyT01ZZXZlNXJmZE02OVdWTjdQL0EzRHZXZy9j?=
 =?utf-8?B?aVI4dXpyL2VXWWVrbzJLWXN5dzYrc0c3OEMya2FDbDd1OWNubENSWXVpM0xT?=
 =?utf-8?B?UWlIS3hxZm14MFExSE84ZDVSN1lTVmljLzN0T2hvTTZEd25pZG1WVWhkRHhr?=
 =?utf-8?B?bnhjVXIzSmJxQUVtY25scDJBdU5VZnRLSHZER3VkaE1INSsva3d6cVJPeFZH?=
 =?utf-8?B?TjJqclZMR2QrQ2NqRklaemNrUnFqUUZJdXNlRWx1SHBLTnhmeE5zMEIrdkNY?=
 =?utf-8?B?d05NdnpXeEVadWxNbTh6KzltMGVjb1BycHN4eUFGNGVYc0hyUm1QQzRYWTdF?=
 =?utf-8?B?THJBNjYreDZsVmNhZmV1VlA1ZElEdEM2anFESmJTdFZFM09mSytOTG9OK3Nj?=
 =?utf-8?B?OEMrVG14aXNGN1Jqck9FK1pKQ1BVQUJzWGZyTGZYbDd5YW9KUlVSckxFOG5D?=
 =?utf-8?B?QzNZYjBaOWttSXNDbVBndXZKNXRXdko5dU5hT0lMRC9HMVdZcnJOaWhCeUZY?=
 =?utf-8?B?REQ5N2FCL216Y2x5SXlDWHZGVFBNNEtTdG1zSXkxUnhVazhBSDBUeTJUZXhJ?=
 =?utf-8?B?WFFNcUZuaXJhbWpOMm8rQ0JnYmxFRGEyOXN6c2dqSXJKbno4V0dvMDJ5WkZM?=
 =?utf-8?B?d0lBYXFHeDNZZzhpaktDb2ZFM0RBSWU3Vk5MdUV4Z1IvbU5aRFplamgxbDJr?=
 =?utf-8?B?SEg0ajduNzNFUnZQSVl5RVUvbjRDYkgwKzlSNkRpNXRtVmVhMUpBTTZIR0Z3?=
 =?utf-8?B?dVR3VXo4bFl3L1Fxdjd1WkUwbWxNM0psT2lXeVVBMWRoYWcySW91dUlGRENN?=
 =?utf-8?B?NlpMdGZkUVd3U1NOL1FMRTEydVh3c2RENUxtNHlqYjZRb3lsaThuNkRVMGhX?=
 =?utf-8?B?VWI4dnhGc2tjUDI2Sm1FS2tmUVo0eFprakp5ZUVEdUxhNW9Ja3hqYTRKL1d0?=
 =?utf-8?B?cm05OE1QUktBSmJ2elBHSDBWY0Yxb0I0bWM2bVdjM0I2US8rUGVKYUo0c3dS?=
 =?utf-8?B?bXYvbTkrdFl1WXBuOU8yUkpqd1o2a0prYWxjQThtejBkdUNmQ0pBR0piUFE4?=
 =?utf-8?B?SURGZkMwYlIrM3RqQmdCcTRHQk5nbjNNSWoxTUd5ZXpQOVgwSENLbVV5eHhh?=
 =?utf-8?B?OWptL3R4aVF0UFpvV1p6dnVhSGZxUDdmTWpDKzcyanN1bmFzcFJoZDRkdVFQ?=
 =?utf-8?B?c3dFcDlRMms4MlV4a3BmUDFhb1VpbUFGMGQ3dFVMMHpWL0ZkR2FnK3BtaWVD?=
 =?utf-8?B?SG8rYlJJU0I1RUlLajV1cW1abmlidnIvd3QzTHc0dG1hNmRYcGpISlVJVDdC?=
 =?utf-8?B?YXByQ3pwbnNlSEh1eTh2S3BlR2RZYU16VEg1Y1krUUpBUllhVDFpZFZ4WHg3?=
 =?utf-8?B?dmRnN05kZ1Iray8rSkFPYTV4NGd0WkIvWmt1bkpURHR4a0lXYi82c1NRbU5J?=
 =?utf-8?B?RkVpalUyQ2hyQnN0TEc1WjRkdmtFZzRXc1dqVXRzMnBPMzVuQzVwekgrdU1V?=
 =?utf-8?B?eUNRandNZmlCZi93bUV0L3RHdmNiazlmNnQwaUxYY0wxeE1IS0wxS05jSUIx?=
 =?utf-8?B?WnBNbHQ0a3gyUG5UWGdka2FGQllBUC9uUy8wMFp2NUNSZTI1dUR3eUpGcW1o?=
 =?utf-8?B?KzlpMGQ5cVgzNlVySDduSHB3V2tWNzRPbm5BaGh0Qk04ZGt6RkJET2dSazRI?=
 =?utf-8?B?a1RpaVdDWDRHV1N1bCtibHRzY0pYNnROelE5ekdTREdRV0NvTitaOWIwNkhX?=
 =?utf-8?B?bDB3UkRGaVlzSDBuNWtrWXVPdTk5Y1NuN0Y5alhLWG5YdDlmWnNSNDhkbmNq?=
 =?utf-8?B?VzhQU0NubTY3VkV0RHZyUUYyck5TODdoZ2Z0NjFzK1UzcWxMSjZUYWpESEVY?=
 =?utf-8?B?aTNqdWZlc0FQNmxkY3JvRzB2dUNtcmlWOUM5VkVXaVc0QmRzdHF3SlBFalNz?=
 =?utf-8?B?amtYWEw1S0RqNFpoQzUxMUQ1TytESUowN3lCWnk0RVU4MENXN3FzbGRmNEQw?=
 =?utf-8?B?bWNZcHNkelF3dCtqT2JnTXg5WkhNaHZmcjc4a3Jla1hHWTJSSjBIUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85245267-f761-4aaf-1d59-08de788618f3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 18:04:07.8242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kG4OdNZmFP4B8Zq9mYsT6YbPPCzGbpaEVz+ds1xqmZqp38cyaB9xjp26VF4vZdWnPDZjYaQWmqVdAdKDa486MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7999
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


On 02-03-2026 09:46 pm, Alex Deucher wrote:
> On Mon, Mar 2, 2026 at 8:36 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>> To avoid race condition and avoid UAF cases, implement kref
>> based queues and protect the below operations using xa lock
>> a. Getting a queue from xarray
>> b. Increment/Decrement it's refcount
>>
>> Every time some one want to access a queue, always get via
>> amdgpu_userq_get to make sure we have locks in place and get
>> the object if active.
>>
>> A userqueue is destroyed on the last refcount is dropped which
>> typically would be via IOCTL or during fini.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 85 ++++++++++++++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  4 +
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 10 ++-
>>   3 files changed, 76 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index e07b2082cf25..9eced6cad8fe 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -461,7 +461,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
>>          uq_funcs->mqd_destroy(queue);
>>          amdgpu_userq_fence_driver_free(queue);
>>          /* Use interrupt-safe locking since IRQ handlers may access these XArrays */
>> -       xa_erase_irq(&uq_mgr->userq_xa, queue_id);
>>          xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>>          queue->userq_mgr = NULL;
>>          list_del(&queue->userq_va_list);
>> @@ -470,12 +469,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
>>          up_read(&adev->reset_domain->sem);
>>   }
>>
>> -static struct amdgpu_usermode_queue *
>> -amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
>> -{
>> -       return xa_load(&uq_mgr->userq_xa, qid);
>> -}
>> -
>>   void
>>   amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>>                               struct amdgpu_eviction_fence_mgr *evf_mgr)
>> @@ -625,22 +618,14 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>   }
>>
>>   static int
>> -amdgpu_userq_destroy(struct drm_file *filp, u32 queue_id)
>> +amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue,
>> +                    u32 queue_id)
>>   {
>> -       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> -       struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>>          struct amdgpu_device *adev = uq_mgr->adev;
>> -       struct amdgpu_usermode_queue *queue;
>>          int r = 0;
>>
>>          cancel_delayed_work_sync(&uq_mgr->resume_work);
>>          mutex_lock(&uq_mgr->userq_mutex);
>> -       queue = amdgpu_userq_find(uq_mgr, queue_id);
>> -       if (!queue) {
>> -               drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queue id to destroy\n");
>> -               mutex_unlock(&uq_mgr->userq_mutex);
>> -               return -EINVAL;
>> -       }
>>          amdgpu_userq_wait_for_last_fence(queue);
>>          /* Cancel any pending hang detection work and cleanup */
>>          if (queue->hang_detect_fence) {
>> @@ -680,6 +665,38 @@ amdgpu_userq_destroy(struct drm_file *filp, u32 queue_id)
>>          return r;
>>   }
>>
>> +struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
>> +{
>> +       struct amdgpu_usermode_queue *queue;
>> +
>> +       xa_lock(&uq_mgr->userq_xa);
>> +       queue = xa_load(&uq_mgr->userq_xa, qid);
>> +       if (queue)
>> +               kref_get(&queue->refcount);
>> +
>> +       xa_unlock(&uq_mgr->userq_xa);
>> +       return queue;
>> +}
>> +
>> +void amdgpu_userq_put(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
>> +{
>> +       struct amdgpu_usermode_queue *queue;
>> +
>> +       xa_lock(&uq_mgr->userq_xa);
>> +       queue = xa_load(&uq_mgr->userq_xa, qid);
>> +
>> +       if (queue && refcount_dec_and_test(&queue->refcount.refcount)) {
>> +               __xa_erase(&uq_mgr->userq_xa, qid);
>> +               xa_unlock(&uq_mgr->userq_xa);
>> +
>> +               if (amdgpu_userq_destroy(uq_mgr, queue, qid))
>> +                       drm_file_err(uq_mgr->file, "Failed to destroy usermode queue\n");
>> +               return;
>> +       }
>> +
>> +       xa_unlock(&uq_mgr->userq_xa);
>> +}
>> +
>>   static int amdgpu_userq_priority_permit(struct drm_file *filp,
>>                                          int priority)
>>   {
>> @@ -891,6 +908,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>
>>          args->out.queue_id = qid;
>>          atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
>> +       /* drop this refcount during queue destroy */
>> +       kref_init(&queue->refcount);
>>
>>   unlock:
>>          mutex_unlock(&uq_mgr->userq_mutex);
>> @@ -1001,9 +1020,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>                  break;
>>
>>          case AMDGPU_USERQ_OP_FREE:
>> -               r = amdgpu_userq_destroy(filp, args->in.queue_id);
>> -               if (r)
>> -                       drm_file_err(filp, "Failed to destroy usermode queue\n");
>> +               struct amdgpu_fpriv *fpriv = filp->driver_priv;
> Some compiler may complain about mixed declarations and code if you
> don't put this block in { }.
I will move the declaration to the begining of the code.
>
>> +
>> +               amdgpu_userq_put(&fpriv->userq_mgr, args->in.queue_id);
>>                  break;
>>
>>          default:
>> @@ -1023,16 +1042,23 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>
>>          /* Resume all the queues for this process */
>>          xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>> +               queue = amdgpu_userq_get(uq_mgr, queue_id);
>> +               if (!queue)
>> +                       continue;
>> +
>>                  if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>>                          drm_file_err(uq_mgr->file,
>>                                       "trying restore queue without va mapping\n");
>>                          queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
>> +                       amdgpu_userq_put(uq_mgr, queue_id);
>>                          continue;
>>                  }
>>
>>                  r = amdgpu_userq_restore_helper(queue);
>>                  if (r)
>>                          ret = r;
>> +
>> +               amdgpu_userq_put(uq_mgr, queue_id);
>>          }
>>
>>          if (ret)
>> @@ -1266,9 +1292,13 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>>          amdgpu_userq_detect_and_reset_queues(uq_mgr);
>>          /* Try to unmap all the queues in this process ctx */
>>          xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>> +               queue = amdgpu_userq_get(uq_mgr, queue_id);
>> +               if (!queue)
>> +                       continue;
>>                  r = amdgpu_userq_preempt_helper(queue);
>>                  if (r)
>>                          ret = r;
>> +               amdgpu_userq_put(uq_mgr, queue_id);
>>          }
>>
>>          if (ret)
>> @@ -1301,14 +1331,21 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>>          int ret;
>>
>>          xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>> +               queue = amdgpu_userq_get(uq_mgr, queue_id);
>> +               if (!queue)
>> +                       continue;
>> +
>>                  struct dma_fence *f = queue->last_fence;
>>
>> -               if (!f || dma_fence_is_signaled(f))
>> +               if (!f || dma_fence_is_signaled(f)) {
>> +                       amdgpu_userq_put(uq_mgr, queue_id);
>>                          continue;
>> +               }
>>                  ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>>                  if (ret <= 0) {
>>                          drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>>                                       f->context, f->seqno);
>> +                       amdgpu_userq_put(uq_mgr, queue_id);
>>                          return -ETIMEDOUT;
>>                  }
> Do you need a put here as well?

Oh yes, we need a put here as well for success case.

Regards
Sunil Khatri

>
> Alex
>
>>          }
>> @@ -1368,9 +1405,15 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>          mutex_lock(&userq_mgr->userq_mutex);
>>          amdgpu_userq_detect_and_reset_queues(userq_mgr);
>>          xa_for_each(&userq_mgr->userq_xa, queue_id, queue) {
>> +               queue = amdgpu_userq_get(userq_mgr, queue_id);
>> +               if (!queue)
>> +                       continue;
>>                  amdgpu_userq_wait_for_last_fence(queue);
>>                  amdgpu_userq_unmap_helper(queue);
>>                  amdgpu_userq_cleanup(queue, queue_id);
>> +               amdgpu_userq_put(userq_mgr, queue_id);
>> +               /* Second put is for the reference taken in this function itself */
>> +               amdgpu_userq_put(userq_mgr, queue_id);
>>          }
>>
>>          xa_destroy(&userq_mgr->userq_xa);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> index f4d1d46ae15e..ec3ce485626d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> @@ -74,6 +74,7 @@ struct amdgpu_usermode_queue {
>>          struct dentry           *debugfs_queue;
>>          struct delayed_work hang_detect_work;
>>          struct dma_fence *hang_detect_fence;
>> +       struct kref             refcount;
>>
>>          struct list_head        userq_va_list;
>>   };
>> @@ -114,6 +115,9 @@ struct amdgpu_db_info {
>>          struct amdgpu_userq_obj *db_obj;
>>   };
>>
>> +struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
>> +void amdgpu_userq_put(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
>> +
>>   int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>>
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 3c30512a6266..ba453361d2b4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -521,7 +521,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>                  goto put_gobj_read;
>>
>>          /* Retrieve the user queue */
>> -       queue = xa_load(&userq_mgr->userq_xa, args->queue_id);
>> +       queue = amdgpu_userq_get(userq_mgr, args->queue_id);
>>          if (!queue) {
>>                  r = -ENOENT;
>>                  goto put_gobj_write;
>> @@ -612,6 +612,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>   free_syncobj_handles:
>>          kfree(syncobj_handles);
>>
>> +       if (queue)
>> +               amdgpu_userq_put(userq_mgr, args->queue_id);
>> +
>>          return r;
>>   }
>>
>> @@ -863,7 +866,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>                   */
>>                  num_fences = dma_fence_dedup_array(fences, num_fences);
>>
>> -               waitq = xa_load(&userq_mgr->userq_xa, wait_info->waitq_id);
>> +               waitq = amdgpu_userq_get(userq_mgr, wait_info->waitq_id);
>>                  if (!waitq) {
>>                          r = -EINVAL;
>>                          goto free_fences;
>> @@ -947,5 +950,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>   free_syncobj_handles:
>>          kfree(syncobj_handles);
>>
>> +       if (waitq)
>> +               amdgpu_userq_put(userq_mgr, wait_info->waitq_id);
>> +
>>          return r;
>>   }
>> --
>> 2.34.1
>>
