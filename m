Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8071FF885A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 08:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AADB10E028;
	Tue, 28 Apr 2026 08:15:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3LW4GJsc";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010026.outbound.protection.outlook.com
 [52.101.193.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49A4010E028
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 08:15:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtoGMORpsq3nUQ21QNI7clEO7VYlMlUzIs10/fq1h8uXl+/LIXfzV2YBBcg92OW/6y78IFyXSN1f57akVl98oFvM/DMTmVTK0eqJDKaSpEIeKxbimzZqyV2fWWrs6wG8L9xzLEfVcoKqOM3uV+fqsXePOcfgi6UXyEvx7jStvU0CVSatarvVgEFGOO1rgCoGJqdqwAg3cVBgwIO/GxzppOsRBCAxgqZpnOpq5UGK9G28t7FRrH067aJ8+W54Nc/+WNsu4xiNDfx43weSk9oK55odo/JxD6RVme7W0KPpievk4gh8EwVerFKOPYjOYWUNQHGGUmy5GyD/DWNvgXW+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9S/3+7ePZVJ1kVdaw2L0K/ec+4a3LJbomBA1ylM+mQ=;
 b=KHTmtiJEpIjLVnBdsr+ZeXN7MfXVtzZMmMFka7ssb+timSyhFg7XYOKlMffW4CkZwCSSvg7HQoqPdoZmeCxV/k9kg3isdfpdvnosyT86Tp4nYFfvnkiD79uVL3eeJZNwJGGIat1RvNEogxUyOqUCYiwh+h97jgvSjhvlRV1gY/hDMdZMrFs05R4aKHikx6LhNXMsqJzBa2PMRiPfU8Ex8Wq70PMF06p/qwUfWKrroLUMUhAIctJekI+njJHbHK0m3J+ooeCrkM8ipQGVngfGnOevMpYrDFpxWZKtiVySyU5pQeCpi/JMLRCi/NqHIzuPWoTia6pjzCy0CFLywWlDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9S/3+7ePZVJ1kVdaw2L0K/ec+4a3LJbomBA1ylM+mQ=;
 b=3LW4GJscSCG9SIEH6+YhVXJjq2rDZ63C3Fr2urWxc0kR+9jo9H1IcZ/+21rnflPazOJ+fYSZdOpuCH05q+d5NVn055lMonOjLeeZm0iklQQGF0b4SR4w9b46kmXqERz2Zh3kb7v3x2RQ1NYBGgG4tHU2KO4p3mXo4D7R6PsaZ2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 08:15:11 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 08:15:10 +0000
Message-ID: <6f57c56d-4e85-46f7-b245-fc95c8f1a899@amd.com>
Date: Tue, 28 Apr 2026 13:45:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] drm/amdgpu: remove deadlocks from
 amdgpu_userq_pre_reset
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260427182723.1715-1-christian.koenig@amd.com>
 <20260427182723.1715-2-christian.koenig@amd.com>
 <DS7PR12MB6005CC8E7AD16B551359D97DFB372@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <DS7PR12MB6005CC8E7AD16B551359D97DFB372@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0128.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::13) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 149660ea-532e-4dee-4b2a-08dea4fe43f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: H9OzXCjxYdbEoSe5uVTa02vKG3/FVjcYWJk+IhGlDA9Kb78EP3B9DGz5ksJF9dkTf3b/L6IXWlmv7dMpPlO7Cr0mY73xJtWXuNgMcX0YhkcXxOrvLQ6SZIlbpdl9jSlm11GLf46xTup5O8fU0I5jo4Xq/3wnarUf++gEd83UGi/5KdL+v5LSKwVFCfselURt2Y3SK6x9ARkSsrGeeuk1LwTvkYA5TbT5xTEm3mj6a0K3SbXpq9OfHmQFmC1DSmCo4Hhq4KzJheEnT0wGtkGteRBU9wBgSb+KVnFf/ZoGwFLIrf97yztKGKYXuotXeZipBX2GvOi5Fe1xSjA1qT1neBru527pdBTNExVdLEb3olzn+cLcw/7WdOJNMtYTpUmVbUfYt1nHKN4uSdzdP8sefppFvPWFurmosbCjhCLml0p8RGGsoUPbtVHrKGnR/6k8Gezepn+MetjI7moMkedG/H2jk3OCLx2Xy8qmo8GB3RYdXBrAZEQOYbzGHtsJMBqFZw1SyOmPcuyML4NLqaPubN/8dBcxjdmy1DEsexX67KYCO4Ut34baszK3NSZ2U4Ln/b1Bv0Ljn5HtrXirIMsk7U2G97y3LfYIbldZKdMoZrceAGpP4eU1mj321VGW06LLZCBfPvHvQNISGnKCvramKXezLhaWfI68IWjARnCsdKioqZ1kksxtcSN8FVqewFZtttqb4XvqEck3Veh7oUoTyJlzWpfcMZMifSQxXItec1KaPaibec6e1uKQO+gbR4O7tecRoo8aE/3p++DvOG14NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHJTZG5pT0V6U1FGcUY2UWxXZDkxRlZEVXl2MjlLOFVoZ2J0NzlhcFVkRzRC?=
 =?utf-8?B?RGFhMFZkK05hckhVenkxaU5TOFBPYWxUcFpSZDcwa1V5TWdIb2FGWmZUdGU2?=
 =?utf-8?B?V0tzR3h4dmFxNlVtN2JXYVQvTFg0UGJpL2d0SkxpZTNudm8wUHM0UnlwaFBT?=
 =?utf-8?B?b3lEVTVBbG5VWmtGaHExd09NemZaMEdVS3RWRSt4cnJDK0NUSSt6MTRtaFBl?=
 =?utf-8?B?ampSYzRiRTh5b2ZsWldWMXdnbnNLVW1NRi9XU1NvSGttcnpjTTBaSFZvNmRz?=
 =?utf-8?B?UzdhNm1INmoxRzNidEhVSm8wTXM4UFdteloyTU1KSHYwb0tlTVNSeUc0SXVN?=
 =?utf-8?B?WmpoMDg3Mm5OWi9EVHZWc3hSaTFWMUJ4aGpXOC9CNTVKaG5Dd2JSS2lqeXVi?=
 =?utf-8?B?YmVLaHBiYy9SbUIxM08zZGVxeEM0U09UU1EzdU1qU04vRk1PcmZFY2ZTeWNq?=
 =?utf-8?B?RmducGZkSllreFp2anBQQzArNTc0WHplY3NMeEhlQlJnY28yNTNtRXkxckNN?=
 =?utf-8?B?MUE0U0xBc0l2MWU5ck5FQUY3K1c0dzJrRTIzcktZMUoyWThUbE1xTW1Vb2JT?=
 =?utf-8?B?TWJraU05OTB0YldueUJEaTVaaVF2R21jRzc4Mk1SOEdBUlVISGc2N2U3bC8x?=
 =?utf-8?B?UGM2T1ZOTzJKaEI4MmJZbHRweWJCMlljbkg3Q2RQWXF6R2JFT1NaRTk0ZERY?=
 =?utf-8?B?QldnczM4a3BBWThGck9pa2JkY05DdkgwQkN6UkZ4a3pYVWN3VVo3QTc4UmQ0?=
 =?utf-8?B?SEV4YnhNakZLaUpldFZ3a0NiSjFrWE9QQXlBN2FHbit3S2hXa2lteVVMRmQ0?=
 =?utf-8?B?dWg1WllqNzlhSThuRHh1ZTk4SkM2bTFGa29ZZDNiUGhqN2hTYzlsOTE0WjlY?=
 =?utf-8?B?MTdSNW0vcnF3c1cvdlVtd0FTSmQybzcvT25MOVpoV1RKemVBWUE4UmRFbjUr?=
 =?utf-8?B?RkFONTZXN0NyU2ZSRXFvQXdId3RZRG1mVHh4UGcxT05VSzBZa3hZRW0wUjBF?=
 =?utf-8?B?dEJrY2h5NVpBWENaTVlMVjN5RDNCTlgycGNqRWJNSzNYZG8rNUtVV3F3SWJL?=
 =?utf-8?B?b3ptZDlLaTFXaG1BTjIrWGtHRFlSNmJmNnQ4UmlneTBiLzFibm5UN3ozSCt1?=
 =?utf-8?B?YlJxMC9rU1JnNS9vYldaV1paOFJtT1pDZHEwdmRWSmZUR1pDMUpyeDY5TVFU?=
 =?utf-8?B?OWpjNWdFK09sWksrOG52c29GYTVrVEwxQkFqdjVvc3BOL2w5MWJRVWhpYk12?=
 =?utf-8?B?Z2JiUWp4RVVXdVloOEwwNi9WNHdWTWFjVW9RVDZWSE5BTmxpY1drTVNuQVFJ?=
 =?utf-8?B?cFh1ZDRqT2dLYlJzTGZVOW93M1dWQmRxbjM2b0piSzk3REpNZjI4QklxMkNa?=
 =?utf-8?B?TlFTRlljOWw1OEltNjlaRlRiTmM3K1MwQnVUVHl6M0pWeE1POWZIajBlNGJn?=
 =?utf-8?B?UHg3R0d4VmsrbXZTaXBJMjlrVGlmSHE0YUJaZDRCanFBa1ExMUJUYktRZjBn?=
 =?utf-8?B?NmtYbE9CVmJEVmxQcHUrOTE3eGJ2K1dIV3c2V2sra0dNVkdpZkFlQXJpVVR1?=
 =?utf-8?B?S216MDRnUXRLckJoaUVVUk1GWWVSUjhub1l5ckdnT2lBbTBtS3NUYjNMZTgz?=
 =?utf-8?B?QmZQQXZrV0ptSEwwUnMwakwxODd2T3pQYVhJRXhoS3AzYnZVU3BoRWFjTDd6?=
 =?utf-8?B?OEphZjg0MmQ5SWVJVXgzTW8vMzZhRXhSNXdJVTNYeXB1dE1NcUVtNWpZeFY4?=
 =?utf-8?B?VVQzU1lmSWlnUHYwSjMvSXBOWGxyeUxEZHkxZDlKbVhvdDF6dGFvN3V1RXZW?=
 =?utf-8?B?NEhIeXA4aXB5VS9TcEk5YnQzelJFdTVoMlhjaWNUSGdTZ1FKMllXcVY4cTFv?=
 =?utf-8?B?RFJONC84N01ML3JtUFBsUTlKNnc5a2FnTW0yaVhGcEN2Y3dWY1RsRkx0bjFo?=
 =?utf-8?B?TXl3OEtoTnpEQno0RlQwTks3cE0rSU11Tk9jR0xja0xNRHRScTJYQSswbTYx?=
 =?utf-8?B?bU1RR2xUa1JpWm1qQ0hwdERrY0szcndzSU0yam01MUpvREFaYU8yYkRPbFht?=
 =?utf-8?B?VWRGdUF0b3pzS1RTclB0eVQ1Nk1iOEl3WG1ySTZCUDRVOGttWk1YQm1nSDhs?=
 =?utf-8?B?b0g0V1ErelNZQlB3ZG9CRlAwaHhrQWw1d0JocUI4NkxNWVhqWHlqdE8yMFpS?=
 =?utf-8?B?dlg0bVhwZkFyWGNrVEdDNkpqeit4Ym8zVWJiUXV0RDdkSk8zQmZ2Zi9mUXk1?=
 =?utf-8?B?OGlhaGUybzV1ZTdpVDJBdkhKU1c1S3dRM0h5WURZRmJGZ1YwaU9DY1dIMkM4?=
 =?utf-8?B?cXBHdytQTnloN3RCQ2pDR1JqVHEweGswRGdBZUJ1VVI5MmFsRitiZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149660ea-532e-4dee-4b2a-08dea4fe43f4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:15:10.6535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYu3R6JFmXFI+Y5WkhHZIYhhYfpHxPkIvzg0xaWpDBKZ2zXTL11GrJjySqzZGoKMXqgdK1kob6/B5NOzCP81Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203
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


On 28-04-2026 12:21 pm, Liang, Prike wrote:
> Public
>
> Regards,
>        Prike
>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Tuesday, April 28, 2026 2:27 AM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
>> <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Zhang,
>> Jesse(Jie) <Jesse.Zhang@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: [PATCH 2/8] drm/amdgpu: remove deadlocks from
>> amdgpu_userq_pre_reset
>>
>> The purpose of a GPU reset is to make sure that fence can be signaled again and
>> the signal and resume workers can make progress again.
>>
>> So waiting for the resume worker or any fence in the GPU reset path is just utterly
>> nonsense.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 26 +++++++++++------------
>>   1 file changed, 12 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 58b9477c0346..a34b1df513d3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -1510,23 +1510,21 @@ void amdgpu_userq_pre_reset(struct amdgpu_device
>> *adev)  {
>>        const struct amdgpu_userq_funcs *userq_funcs;
>>        struct amdgpu_usermode_queue *queue;
>> -     struct amdgpu_userq_mgr *uqm;
>>        unsigned long queue_id;
>>
>> +     /* TODO: We probably need a new lock for the queue state */
> It seems a new per-queue lock may can help locking the queue precisely than the process wide lock userq_mutex,
> so here prefer to create a new per-queue lock than reusing userq_mutex?
>
> To resolve the deadlock in the userq fence wait nesting, this patch is Reviewed-by: Prike Liang <Prike.Liang@amd.com>
>
>>        xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>> -             uqm = queue->userq_mgr;
>> -             cancel_delayed_work_sync(&uqm->resume_work);
>> -             if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
>> -                     amdgpu_userq_wait_for_last_fence(queue);
>> -                     userq_funcs = adev->userq_funcs[queue->queue_type];
>> -                     userq_funcs->unmap(queue);
>> -                     /* just mark all queues as hung at this point.
>> -                      * if unmap succeeds, we could map again
>> -                      * in amdgpu_userq_post_reset() if vram is not lost
>> -                      */
>> -                     queue->state = AMDGPU_USERQ_STATE_HUNG;
>> -                     amdgpu_userq_fence_driver_force_completion(queue);
>> -             }
>> +             if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
>> +                     continue;
>> +
>> +             userq_funcs = adev->userq_funcs[queue->queue_type];
>> +             userq_funcs->unmap(queue);
>> +             /* just mark all queues as hung at this point.
>> +              * if unmap succeeds, we could map again
>> +              * in amdgpu_userq_post_reset() if vram is not lost
>> +              */
>> +             queue->state = AMDGPU_USERQ_STATE_HUNG;
>> +             amdgpu_userq_fence_driver_force_completion(queue);
>>        }

My understanding here is: We are in this function after we tried and 
failed in per queue reset where we send request to fw to reset it. Now 
we have fallen to who GPU reset. Considering the scenario i shared is 
true, we better just call amdgpu_userq_fence_driver_force_completion and 
avoid calling unmap as it might be stuck again and makes no difference. 
So setting the state to HUNG and calling force completion sounds better.

Other than that the patch is fine and good to push
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

Regards
Sunil Khatri

>>   }
>>
>> --
>> 2.43.0
