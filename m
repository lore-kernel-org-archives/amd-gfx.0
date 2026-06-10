Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98144CD8CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 08:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE3DB10E7EC;
	Wed, 10 Jun 2026 08:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nhdz/g2z";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABE6510E7C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 08:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sgtnm7VPWByJolD7bl62lAysGakfQjxKuEKbal/IIArvXXJvPKwBmO9uSLiMqSO8xRV3Jv4fwI+ftN7i9+fv9xJp3434EVa4B+JMNBmh9KfQouZkPceqAnuhdfrcRZOg5F2sIgbcGQa2CF4kJG23h7PV1ThU1rF2UlPIxCmig8UjgNLo+pDb60izlnOn7vqhTHqPqeUse+ZnVYOd81GOdUJyka5BK46sLpz8Qzv+aphblR1raxTJfuSoNTYARAWqAR48IyGJ9l2wyH8vayJSjv17aablq9OWXTpdfmPfuIFV2z6tU9Z0JB4JjG7FfbbK2cFGBjLgLRQa9cmGwfTvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksFB0MWqPYnvSzu3BdYtGyi+UU5HRTqERIfb6R2s4KQ=;
 b=I5Ly63+ihG3DajcAjfrzZU6v02MNvDfEGNbF5woI5Q8kLcCZy1PvIXb0/AiNnyUUcvHihsBsvtRipGuCxMoUlMuH89vjmoZLxBVcUNLnKn61ucZTb6s5rXSxRjqMLZsqOUs5Crbi75bKDJosuRMSIxjiw7RyDl0OLRBwSut6+HpCwQ+5WVYUKavN7zBqq6ld4k6AYZbXeWB4wMUAfpyhQqFKiI09kZB9wTzovDEX5ZsI9Sa/4IoboREZd+t87Aka+pFeP7xlAhD6gKcEJscImDNOWaPqm19AvVvoXok2OgrxGvfZ4a+68Otm2Ogi2SLk/q31hQI3FSBx+3JulbkyOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksFB0MWqPYnvSzu3BdYtGyi+UU5HRTqERIfb6R2s4KQ=;
 b=Nhdz/g2z1IXuz63JfAeuOBGPXOQW0bL7hFz2M1gQyJqsooCul97hDqpvuW4mVOeDZSvwEtoVMDEpfehl4KYo+FaivZpcSu1ULYYiyc9ioRZIjmZ+66WC9LGHtzygQE1CIfRhpoMZbrt1EGsi1JQZbJWYZXAElS6D57/shIYPxxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 08:25:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Wed, 10 Jun 2026
 08:25:14 +0000
Message-ID: <cae7d9d8-9411-4ee6-ba0c-50455bdcc828@amd.com>
Date: Wed, 10 Jun 2026 10:25:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: add userq job and state transition trace
 events
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
References: <20260527122001.69831-1-Prike.Liang@amd.com>
 <20260527122001.69831-2-Prike.Liang@amd.com>
 <165b0fd0-32af-44e6-aea7-924432974268@amd.com>
 <DS7PR12MB6005BBFA89B45D040D443DF4FB1A2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005BBFA89B45D040D443DF4FB1A2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0058.namprd20.prod.outlook.com
 (2603:10b6:208:235::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: 3765d7dc-f189-47f1-fb58-08dec6c9cb98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: TzZIisQ3YzqB2eYct+cHKsbBT5p3DgpJS58p+g+J59xSWbFK9sUJ170HBibhd7fo8s9aHkumUWcGPtWO/x5SyLtY6ugetwNpMxR8/6ax7RDpuj8j+D9WCDDZdhXKQqXA6CTA6rqZr4SSv0tSqEzP15EIMASZPx0jNlhDT1bBLKtA/9EKhcf08FXazOikBkfRfqBOJlGceSCtJdQOMP71Zz0szZnGxxKksnV8qvrHDwuXvxWdIc2W5HllP5YVwxJM7LoXOvbRfbr7/laHv/BPbrJbooBaxM67HAYXWh7fSlMKjveq1B663flTkp04UVSMfI5J+T5PHbeXHbXlft/Z9eY4c+3XebUdN2q4vApJDj80MRNuLSdmshmv1GFoW0q18XFm7BjNlDbUbq3ng+EL78wnQKLUFCvM6NuXha81VUwfaHvaAVkDE+Gnirkldbg+avcd99osOW2F2Kxf+Y9CBlqB1AAMBz9sjbsy17H/18r7klvZTj/pvLM6Qb2Mr2EQMeu8/3dvdIis8BIoL73cKhNvIy28d5i/LTz/5AURu6gi5AxI/Fm5O1Z6c7U7it7oqRTryXj4EUutzUJEmmz+8OWn4sJdTk13PP7qk9H+Hf/qCVuEZkQsx1iJvT0rqgO/ej2o/LeiC7DVyrZCodzMR+YsG0CVkO8akUQtpc6gXNzpuX1rfKLHho6no2/Bh8qV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SERtWUlLM3p0aHV6Q1pQQ1VsMisyRE40emduakI5bThoQVlCeGNjWE9HUUlT?=
 =?utf-8?B?M0NoMTA5ZE9KK285Y1N6OS9vNTNhOXJXdlhVcUNiMEc3V3A2VldNRk5DL1R6?=
 =?utf-8?B?WVJ1MHMyZnpyZ1RwZTNhNWV1dzNEQWpNZHVVb3lwSnFZOXV1Smt0WHdCSjZM?=
 =?utf-8?B?cDZNWFRRRkpFd1djUFl0UXloS3gvOGJ2TXFXb3EwaG5OdkliUnowYlJoTmtN?=
 =?utf-8?B?R2l2VmFVbUtTaTFvRHFVbTU0SFJmOHJIdGpuS055cW1rVlJZWjZwSXB1akFC?=
 =?utf-8?B?bXJoMnVqWE8vVFZ5WTNkM1NMMmRNODZxTjN3cnFrM042dG1vNURCTGh5K0s3?=
 =?utf-8?B?dkwwOUZ0anFNcS9ydEdqeGxtODhzK094YUltaC9FZmkvSFcrajlsVktvUmVr?=
 =?utf-8?B?aXp6c1k3OEdBVnlnN2dEcHpTcXZiK0cvdWI2KzhBQVNLdW43NWlnRjFxTjRa?=
 =?utf-8?B?dmdpZ1cyQ2NobUxxSzgwVzRnK2Y1UHRUTGhBOStrL0c1MjFLajVkSkphU0Rj?=
 =?utf-8?B?SjhTbzVIRmo4K2NwcEtub0s5b0dYc3k0cVNWc0w5ck5RRjRGRi85S1hvSG8y?=
 =?utf-8?B?dEFTV21oZU1YMFVBZSttK01aSURZWDVvRm1oSkxMaksvbkdKalgvc2QzVE5H?=
 =?utf-8?B?YUpuam9ZMytibVpVZEhwdE5qNHRzTHRtUVVwalVHcHdxQnBZVDdtV3YvSlYw?=
 =?utf-8?B?ZHBGSDVlZEdjVktUOXhsVU1Na1lDL2NYcTdYNEdnR2FmWXhvWjVFM0l3U3R1?=
 =?utf-8?B?V3JyanQ4WUpLdHpxRkdlVnUzUVQ2NnkvUUZrQzFOamIxOWNjZXZpOEhXcHZE?=
 =?utf-8?B?SU5ac0pUcWlGenliTVFkdzBjNHpUaktYZk80NTlsa3BpdVdsZVk0ZUxWeW1q?=
 =?utf-8?B?emxXOG5kcVlSTzFyMzlNVUZnVVIwS1MvbzRHamJ0QjZvaHFud1N4RXNZZnJD?=
 =?utf-8?B?MWZMaHVyWDJiMVZQS0VjdlRWL296WWxJVGwvSDUwWDNvbldXSXNmWU91U1Y1?=
 =?utf-8?B?c2U1Y2xleTFKUUdqVlJvQ0c2VnY0dXVlbjFKTTJRZllNYmpkcGM1MmVmdGVN?=
 =?utf-8?B?UTVZOUM1L1Rzdlp5ZU52Z2VMWWtLL1RkUWpFVmk2WVVGUW9oTjd3eXFyWnk1?=
 =?utf-8?B?eDMzaG05Q1J2cldKNGFwWmZLZWQyb2JrM3E0b1FiVmI2NEJGVWVLdUVRYXFC?=
 =?utf-8?B?VU5ibFNiV0Z1YXI4bUxjLzNhNTZwc2tvTG1KUFZRN2FwYUVQdUJ4dmxiOFF1?=
 =?utf-8?B?RkU0ZWx6Z1BwQW0zSjFlWVJtSUVmdk9mVS9paXpzdXZZcnBiNTJuZ1gyRm1w?=
 =?utf-8?B?QUVpNUxjNW9MZmsyWFpsRFVTTlNZVzdOYnpXWS9Nd0gzSmhBZi9pQVFoSkJT?=
 =?utf-8?B?b2ZpSlo4eWpzTG95eXF5c1I4UEY5OXlJQ3RWcUsvZ05ORi9KR2h2aEIzTlVr?=
 =?utf-8?B?WkpUMFhFL1pZZS9DSVZNUVUyUG02ZkVrTE9oaEM0T1VtNXR6ckR3QjFyVEVI?=
 =?utf-8?B?a1hoTUozOEwrdUk2Q0wvb2FyN0VoY3FRL2xTMG5Sc1U3RHV3aHBMV3hTYjRV?=
 =?utf-8?B?Y1h4eGViNHNkMnd3b1hQT3M5SFNSUTRWK01TUnRBTVRoTnI5UTN4VTUvRVlo?=
 =?utf-8?B?dVU0OEtFWDlMbEVXbElOR3oyLy80czdtejYxK2xqSWg5ZnJ2UHFveE1yRitI?=
 =?utf-8?B?aW96dmthR1JGalhVTk1zS1ROaXB6K1RkSDZJTWtTeGZpOVFXMzRTbE9hYUJ4?=
 =?utf-8?B?M0hJU0ZJK1FYK2oxRzkvNUc0aFl4bklyZjJwemkvSkd5Mmlhc1hGeFNBQ3VZ?=
 =?utf-8?B?Y0E0VjZRdE1ZZGVnQm1Va2NIempCSzBERTg1OFRCK29ZU2FOZlh6eEtDakJy?=
 =?utf-8?B?Z1d0T3FNckNEZmlSc000czAvLytVUDZIS3pidmtjL2hPaUIxT0ZxSldQa2ln?=
 =?utf-8?B?aWNYVHZnSWxuT1BNazlhMmdEMVdvNlBUaFNLRWhzdDM5UlE3YTNNVks3VVZZ?=
 =?utf-8?B?NEpIMU5qenNPSXArazJZZzBqSjVDK3VpYWRNYUI2VTBXNWtRemFDQVJGVDhi?=
 =?utf-8?B?bWNwZk1wVGtvS2pmQVo2L1lOejVtbVExajZybWFHdDhEblYyTWl3dXIrZEhr?=
 =?utf-8?B?L2FZSUdyVm8rTmgzb0NYaG9TUG1CYTlHd01Sc29FWlg1QVp4ZkZtSTA1OGxv?=
 =?utf-8?B?QjNzSnRPanVEYU13ajV0WmRvZDhkVjFGNzZlb2pFZGU0czd5M1l6VUhrb3pX?=
 =?utf-8?B?WjNMK0hxeHhKM2h2OWN0N2JpbGgrR1l4TzhRZEcrOXdOSVRBRWVVanFpK0g1?=
 =?utf-8?Q?iGAf5IplCrV0kquf6U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3765d7dc-f189-47f1-fb58-08dec6c9cb98
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 08:25:14.1443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzc8w6iHnOPAFoAiD/hEfKv/1yV26GCUAKrGp7plr5r1LYYNQWFwxm/q7OXkVbCR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
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

On 6/10/26 10:18, Liang, Prike wrote:
> AMD General
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Monday, June 8, 2026 4:35 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Pelloux-Prayer, Pierre-
>> Eric <Pierre-eric.Pelloux-prayer@amd.com>
>> Subject: Re: [PATCH 2/2] drm/amdgpu: add userq job and state transition trace
>> events
>>
>> On 5/27/26 14:20, Prike Liang wrote:
>>> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>>
>>> Add ftrace events for tracking the userq fence emit, signal and queue
>>> state transition.
>>>
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer
>>> <pierre-eric.pelloux-prayer@amd.com>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 113 ++++++++++++++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  21 ++++
>>>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  12 +-
>>>  3 files changed, 143 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> index df98be22f1f5..ef6a1fb82ff3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> @@ -28,6 +28,8 @@
>>>  #include <linux/types.h>
>>>  #include <linux/tracepoint.h>
>>>
>>> +#include "amdgpu_userq_fence.h"
>>> +
>>>  #undef TRACE_SYSTEM
>>>  #define TRACE_SYSTEM amdgpu
>>>  #define TRACE_INCLUDE_FILE amdgpu_trace @@ -636,6 +638,117 @@
>>> DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
>>>          TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
>>>          TP_ARGS(queue, result));
>>>
>>> +TRACE_EVENT(amdgpu_userq_job_run,
>>
>> Please don't call this job_run.
>>
>> There is no concept of a "job" as in the DRM scheduler which gets submitted to the
>> HW.
> 
> How about converting the job trace name to userq_submission_start, *_run, and *_dep?

Goes into the right direction, but still a bit off.

Something like userq_wait_fences or userq_wait_deps and userq_signal_fence should do.

With userqueues the kernel just doesn't see jobs or submissions any more, all it sees are requests from userspace to wait on something or signal a protected fence.

Regards,
Christian.

> 
>> So just re-using the name from the scheduler is a clear NO-GO from my side.
>>
>> Regards,
>> Christian.
>>
>>> +       TP_PROTO(struct device *device, struct amdgpu_usermode_queue
>> *queue, struct amdgpu_userq_fence *fence),
>>> +       TP_ARGS(device, queue, fence),
>>> +       TP_STRUCT__entry(
>>> +                        __field(u64, fence_context)
>>> +                        __field(u64, fence_seqno)
>>> +                        __string(dev, dev_name(device))
>>> +                        __field(u64, doorbell_index)
>>> +                        __field(u64, client_id)
>>> +                        __field(u32, queue_type)
>>> +                        ),
>>> +       TP_fast_assign(
>>> +                      __entry->fence_context = fence->base.context;
>>> +                      __entry->fence_seqno = fence->base.seqno;
>>> +                      __assign_str(dev);
>>> +                      __entry->doorbell_index = queue->doorbell_index;
>>> +                      __entry->client_id = queue->userq_mgr->file->client_id;
>>> +                      __entry->queue_type = queue->queue_type;
>>> +                      ),
>>> +       TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu,
>> fence=%llu:%llu",
>>> +                 __get_str(dev), __entry->client_id, __entry->queue_type, __entry-
>>> doorbell_index,
>>> +                 __entry->fence_context,
>>> +                 __entry->fence_seqno)
>>> +);
>>> +
>>> +TRACE_EVENT(amdgpu_userq_job_queue,
>>> +       TP_PROTO(struct device *device,
>>> +                struct amdgpu_usermode_queue *queue),
>>> +       TP_ARGS(device, queue),
>>> +       TP_STRUCT__entry(__field(u64, context)
>>> +                        __string(dev, dev_name(device))
>>> +                        __field(u64, doorbell_index)
>>> +                        __field(u64, client_id)
>>> +                        __field(u32, queue_type)
>>> +                        ),
>>> +       TP_fast_assign(__assign_str(dev);
>>> +                      __entry->doorbell_index = queue->doorbell_index;
>>> +                      __entry->queue_type = queue->queue_type;
>>> +                      __entry->client_id = queue->userq_mgr->file->client_id;
>>> +                      __entry->context = queue->fence_drv->context;
>>> +                     ),
>>> +       TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu,
>> context=%llu",
>>> +                 __get_str(dev), __entry->client_id, __entry->queue_type,
>>> +                 __entry->doorbell_index, __entry->context) );
>>> +
>>> +TRACE_EVENT(amdgpu_userq_job_add_dep,
>>> +       TP_PROTO(struct device *device, struct amdgpu_usermode_queue
>> *queue, struct amdgpu_userq_fence *dep),
>>> +       TP_ARGS(device, queue, dep),
>>> +       TP_STRUCT__entry(
>>> +                        __field(u64, context)
>>> +                        __field(u64, dep_context)
>>> +                        __field(u64, dep_seqno)
>>> +                        __string(dev, dev_name(device))
>>> +                        __field(u64, doorbell_index)
>>> +                        __field(u64, client_id)
>>> +                        __field(u32, queue_type)
>>> +                        ),
>>> +       TP_fast_assign(
>>> +                      __assign_str(dev);
>>> +                      __entry->doorbell_index = queue->doorbell_index;
>>> +                      __entry->queue_type = queue->queue_type;
>>> +                      __entry->client_id = queue->userq_mgr->file->client_id;
>>> +                      __entry->context = queue->fence_drv->context;
>>> +                      __entry->dep_context = dep->base.context;
>>> +                      __entry->dep_seqno = dep->base.seqno;
>>> +                      ),
>>> +       TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu, context=%llu
>> depends on fence=%llu:%llu",
>>> +                 __get_str(dev), __entry->client_id, __entry->queue_type, __entry-
>>> doorbell_index, __entry->context,
>>> +                 __entry->dep_context,
>>> +                 __entry->dep_seqno)
>>> +);
>>> +
>>> +TRACE_EVENT(amdgpu_userq_state_start,
>>> +       TP_PROTO(struct amdgpu_usermode_queue *queue),
>>> +       TP_ARGS(queue),
>>> +       TP_STRUCT__entry(
>>> +                        __field(u64, doorbell_index)
>>> +                        __field(u64, client_id)
>>> +                        __field(u32, queue_type)
>>> +                        __field(u32, from)
>>> +                        ),
>>> +       TP_fast_assign(
>>> +                      __entry->doorbell_index = queue->doorbell_index;
>>> +                      __entry->queue_type = queue->queue_type;
>>> +                      __entry->client_id = queue->userq_mgr->file->client_id;
>>> +                      __entry->from = queue->state;
>>> +                      ),
>>> +       TP_printk("client_id=%llu, type=%u, doorbell=%llu, from=%d",
>>> +                 __entry->client_id, __entry->queue_type,
>>> +__entry->doorbell_index, __entry->from) );
>>> +
>>> +TRACE_EVENT(amdgpu_userq_state_changed,
>>> +       TP_PROTO(struct amdgpu_usermode_queue *queue, enum
>> amdgpu_userq_state new_state),
>>> +       TP_ARGS(queue, new_state),
>>> +       TP_STRUCT__entry(
>>> +                        __field(u64, doorbell_index)
>>> +                        __field(u64, client_id)
>>> +                        __field(u32, queue_type)
>>> +                        __field(u32, to)
>>> +                        ),
>>> +       TP_fast_assign(
>>> +                      __entry->doorbell_index = queue->doorbell_index;
>>> +                      __entry->queue_type = queue->queue_type;
>>> +                      __entry->client_id = queue->userq_mgr->file->client_id;
>>> +                      __entry->to = new_state;
>>> +                      ),
>>> +       TP_printk("client_id=%llu, type=%u, doorbell=%llu, to=%d",
>>> +                 __entry->client_id, __entry->queue_type,
>>> +__entry->doorbell_index, __entry->to) );
>>> +
>>>  #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>>  #endif
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 9dc6cb579ac7..536e73c7e9ef 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -296,11 +296,15 @@ static int amdgpu_userq_preempt_helper(struct
>> amdgpu_usermode_queue *queue)
>>>     int r;
>>>
>>>     if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
>>> +           trace_amdgpu_userq_state_start(queue);
>>> +
>>>             r = userq_funcs->preempt(queue);
>>>             if (r) {
>>> +                   trace_amdgpu_userq_state_changed(queue,
>> AMDGPU_USERQ_STATE_HUNG);
>>>                     queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>                     return r;
>>>             } else {
>>> +                   trace_amdgpu_userq_state_changed(queue,
>>> +AMDGPU_USERQ_STATE_PREEMPTED);
>>>                     queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
>>>             }
>>>     }
>>> @@ -316,10 +320,14 @@ static int amdgpu_userq_restore_helper(struct
>> amdgpu_usermode_queue *queue)
>>>     int r = 0;
>>>
>>>     if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
>>> +           trace_amdgpu_userq_state_start(queue);
>>> +
>>>             r = userq_funcs->restore(queue);
>>>             if (r) {
>>> +                   trace_amdgpu_userq_state_changed(queue,
>> AMDGPU_USERQ_STATE_HUNG);
>>>                     queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>             } else {
>>> +                   trace_amdgpu_userq_state_changed(queue,
>>> +AMDGPU_USERQ_STATE_MAPPED);
>>>                     queue->state = AMDGPU_USERQ_STATE_MAPPED;
>>>             }
>>>     }
>>> @@ -337,12 +345,15 @@ static int amdgpu_userq_unmap_helper(struct
>>> amdgpu_usermode_queue *queue)
>>>
>>>     if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
>>>         (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
>>> +           trace_amdgpu_userq_state_start(queue);
>>>
>>>             r = userq_funcs->unmap(queue);
>>>             if (r) {
>>> +                   trace_amdgpu_userq_state_changed(queue,
>> AMDGPU_USERQ_STATE_HUNG);
>>>                     queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>                     return r;
>>>             } else {
>>> +                   trace_amdgpu_userq_state_changed(queue,
>>> +AMDGPU_USERQ_STATE_UNMAPPED);
>>>                     queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
>>>             }
>>>     }
>>> @@ -359,11 +370,15 @@ static int amdgpu_userq_map_helper(struct
>> amdgpu_usermode_queue *queue)
>>>     int r;
>>>
>>>     if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
>>> +           trace_amdgpu_userq_state_start(queue);
>>> +
>>>             r = userq_funcs->map(queue);
>>>             if (r) {
>>> +                   trace_amdgpu_userq_state_changed(queue,
>> AMDGPU_USERQ_STATE_HUNG);
>>>                     queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>                     return r;
>>>             } else {
>>> +                   trace_amdgpu_userq_state_changed(queue,
>>> +AMDGPU_USERQ_STATE_MAPPED);
>>>                     queue->state = AMDGPU_USERQ_STATE_MAPPED;
>>>             }
>>>     }
>>> @@ -894,6 +909,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr
>> *uq_mgr)
>>>             if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>>>                     drm_file_err(uq_mgr->file,
>>>                                  "trying restore queue without va mapping\n");
>>> +                   trace_amdgpu_userq_state_changed(queue,
>>> +AMDGPU_USERQ_STATE_INVALID_VA);
>>>                     queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
>>>                     continue;
>>>             }
>>> @@ -1389,12 +1405,14 @@ void amdgpu_userq_pre_reset(struct
>> amdgpu_device *adev)
>>>             if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
>>>                     continue;
>>>
>>> +           trace_amdgpu_userq_state_start(queue);
>>>             userq_funcs = adev->userq_funcs[queue->queue_type];
>>>             userq_funcs->unmap(queue);
>>>             /* just mark all queues as hung at this point.
>>>              * if unmap succeeds, we could map again
>>>              * in amdgpu_userq_post_reset() if vram is not lost
>>>              */
>>> +           trace_amdgpu_userq_state_changed(queue,
>> AMDGPU_USERQ_STATE_HUNG);
>>>             queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>             amdgpu_userq_fence_driver_force_completion(queue);
>>>     }
>>> @@ -1413,6 +1431,8 @@ int amdgpu_userq_post_reset(struct amdgpu_device
>>> *adev, bool vram_lost)
>>>
>>>     xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>>>             if (queue->state == AMDGPU_USERQ_STATE_HUNG
>> && !vram_lost) {
>>> +                   trace_amdgpu_userq_state_start(queue);
>>> +
>>>                     userq_funcs = adev->userq_funcs[queue->queue_type];
>>>                     /* Re-map queue */
>>>                     r = userq_funcs->map(queue);
>>> @@ -1420,6 +1440,7 @@ int amdgpu_userq_post_reset(struct amdgpu_device
>> *adev, bool vram_lost)
>>>                             dev_err(adev->dev, "Failed to remap queue %ld\n",
>> queue_id);
>>>                             continue;
>>>                     }
>>> +                   trace_amdgpu_userq_state_changed(queue,
>>> +AMDGPU_USERQ_STATE_MAPPED);
>>>                     queue->state = AMDGPU_USERQ_STATE_MAPPED;
>>>             }
>>>     }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 008330a0d852..6071e83acd9e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -30,7 +30,7 @@
>>>  #include <drm/drm_syncobj.h>
>>>
>>>  #include "amdgpu.h"
>>> -#include "amdgpu_userq_fence.h"
>>> +#include "amdgpu_trace.h"
>>>
>>>  #define AMDGPU_USERQ_MAX_HANDLES   (1U << 16)
>>>
>>> @@ -528,6 +528,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev,
>> void *data,
>>>     /* Create the new fence */
>>>     amdgpu_userq_fence_init(queue, fence, wptr);
>>>
>>> +   trace_amdgpu_userq_job_run(dev->dev, queue, fence);
>>> +
>>>     mutex_unlock(&userq_mgr->userq_mutex);
>>>
>>>     /*
>>> @@ -701,7 +703,7 @@ amdgpu_userq_wait_add_fence(struct
>>> drm_amdgpu_userq_wait *wait_info,  }
>>>
>>>  static int
>>> -amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>> +amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct
>>> +drm_file *filp,
>>>                                 struct drm_amdgpu_userq_wait *wait_info,
>>>                                 u32 *syncobj_handles, u32 *timeline_points,
>>>                                 u32 *timeline_handles,
>>> @@ -835,6 +837,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file
>> *filp,
>>>             goto free_fences;
>>>     }
>>>
>>> +   trace_amdgpu_userq_job_queue(dev->dev, waitq);
>>> +
>>>     for (i = 0, cnt = 0; i < num_fences; i++) {
>>>             struct amdgpu_userq_fence_driver *fence_drv;
>>>             struct amdgpu_userq_fence *userq_fence; @@ -869,6 +873,8 @@
>>> amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>
>>>             amdgpu_userq_fence_driver_get(fence_drv);
>>>
>>> +           trace_amdgpu_userq_job_add_dep(dev->dev, waitq, userq_fence);
>>> +
>>>             /* Store drm syncobj's gpu va address and value */
>>>             fence_info[cnt].va = fence_drv->va;
>>>             fence_info[cnt].value = fences[i]->seqno; @@ -968,7 +974,7 @@ int
>>> amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>                                                gobj_write,
>>>                                                gobj_read);
>>>     } else {
>>> -           r = amdgpu_userq_wait_return_fence_info(filp, wait_info,
>>> +           r = amdgpu_userq_wait_return_fence_info(dev, filp, wait_info,
>>>                                                     syncobj_handles,
>>>                                                     timeline_points,
>>>                                                     timeline_handles,
> 

