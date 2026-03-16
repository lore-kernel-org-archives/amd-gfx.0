Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9C5F506C1
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 12:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A40110E3BC;
	Mon, 16 Mar 2026 12:37:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RQZs5wDh";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 579C910E3BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 12:37:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHC7MLHs/NuOb1Cc3mkOB9KpoNqQGtcKvK+f0eJYSiiy5uRoI4CjZpwo62HxJlEnpNfk38mQqGifyhmfc3yhaAYXDOfVcXMoAI1EUaf/TNmMRD9SZHhduD9PSx5Jdl5klhEaVPJzkWC/UISIqHE95WM6fNLFlfeloRk1PYnJIJsJE7TSK69juHM1r7LBzstCG4Od4w+phDuMl9onq0Um4dD/eqnZpvPzRnnO8c+ynn0C68gCbTaOPQvWADh/eck18f+sauk67I1iklCQUWJEdzjOMtEphnkCDvfKjMyUBACk+NoQLb6+eheb5GQShdFGsgooItB9cGXbj3WalszVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qovSKmh53ReoJaTPphM/XMfn7Uj6ns2fd7PnUwckIi4=;
 b=mVIlWSv9liiBRggQMXGLb49B5hewNPogU4yNPylao4UYbs/sPRN6bZU7/VtUGKvbbz/GbNQm7IrWA9IbY+dKKHgbtF5zeqA8lvPz+1Dho3FLeQh8x2ukoiZoAcoJAIkM2LlJLDhNrm1vw+2kYSA7UTGwVwjjUnChJAe+zydtgpEQcrxaxPJ228xIOs3B2IVEYQO45DWfxoYXhDOWqFLSr31kufdmZ7o4GMPCjHTo0lBvFKXodNFGYGp/mj1IGwEbJkyiCUrbeLj34tmxRU7WF1xigkWUtXWm9i6rVcfSEVcelrPC0G/k//+7ZEf3gWW66tZWHp3iep05OwLdwRSvTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qovSKmh53ReoJaTPphM/XMfn7Uj6ns2fd7PnUwckIi4=;
 b=RQZs5wDhMp252B8TTKTBCz54V361ytIuLjkEm0lbHdqbfjowD9No5zBsK3NV5giHdXY07RM2c60px4kwtM+Cp0Ylr0NNCIHkkoX8lXn72QnbqA64rrWgrc6DqMCFtnz9Uv2QgRDucRQwhZQauXZAgzrxshe3hUrTEihL4rxJGh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7778.namprd12.prod.outlook.com (2603:10b6:8:151::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 12:37:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 12:37:38 +0000
Message-ID: <cf41d26e-acba-4096-abc0-277d3434c565@amd.com>
Date: Mon, 16 Mar 2026 13:37:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: oops/null pointer in 0010:dma_fence_is_signaled+0x12/0x60 [amdgpu]
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <abdVX_LJiNvkm4tW@gallifrey>
 <41627fc7-a0d8-44bf-982d-334f548d9f88@amd.com> <abf48cuwzRBczbeA@gallifrey>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <abf48cuwzRBczbeA@gallifrey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN1PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:408:e0::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 902aee50-4318-46c5-119c-08de8358cebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: WJl1ZpznEwFLGnqplP9OQURMwWqHQYns9ru/HgQen0QV+0QyBK1uaN88RD1OdKdGtNU7dUK6+uU7cCV7eGkIgbZwjsliGPAHmqE5XRfBjsdLI0UIa5Jy7a+1T+zJw4HrN6RNQWNAv+16NTUOQET9llvn2HajjR38/9B05iF167GljrL5JJXILuKTkHzSi9xshYIlUJ0SEzeoS86mhsd3IQxBa8UjcOYFIhYrUZq5nLvXkp5Z8+8OGJn+KOQ/rK/nSIU8XUs+5jG/+drRaHv0mZK82kQMF9Up2t8rPWXpDc94Dh0q7maEqbpDT0EXHmoWkUVbNIEm/ABit7yZC4Ue7oJ1iZZkeirFkIKw5rZLUpu2fSxmJvcAqdDBm2QPdPMZLRul5H5TVEH1rUq3YSCAYrvpL2GrMChQeAEpRHkOSePlPx5CmQrpTPIIK1IVrrr/wfLzvafkW7kizHEqOjhZ6pmbS7EWnefotV8xQEN8zn7bGcnkQiocDIzlg8jhhpOjIrlvo5DR5NSENAD7lv+3vAxVh1RCIzO3j4AtaOlhM9W3RfRlJ2Dzh+UallVSCdXApYXUSjEkZGEpgjhJsiklpDI1RB3MbnQWpUNyAkWKNW3dCfV/ijpuD18TWvrGkHa42mfkLIr6/UiKviHXkKciPP7QpW5NwiGu46OuovnD8Tk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE41YzBSR090RjN5eVVrSTZjMlFXMjE0czZaQlcvT0YyTlpwd3Bpc0piN2hr?=
 =?utf-8?B?ek1rWC9KcWQ5ZVNKS1ZjRW1pSTBmM0tnMmdFL1YwZllWalhibEZtVTJNWjla?=
 =?utf-8?B?cHNybThuSnZPU2djNk1GVVAzMW1HR2VTdEFvNk5zT3Roei9lZjhUaGZwK2dZ?=
 =?utf-8?B?eEhzQW13RysrSVcrcS9sSkJaVzVHREpWckNoQktnWmVpRWpQV0dCMzdwVVBW?=
 =?utf-8?B?UVhRK3VoT3o0WEhnRWlQS3B5RGUwL1A0ckhFaFVabmIyNW5UaXpleEVsRVJa?=
 =?utf-8?B?dzUxQTh0R2d2MjNLY3ZhNWp3YmtuSVRMQ2lNenlhdE9FM0w2aDFhSE5LTHJt?=
 =?utf-8?B?eUp1Tk1qU250QTNhSVdsak5YRG40ZXozN2RObWF3SDVpRnlHQnBOdSt4cjBr?=
 =?utf-8?B?bGI5dGJENGlka1I2Ti9zVGVjOERLNmFNUWZOUk9xSThXNTJhaEtLQ0tCWEZW?=
 =?utf-8?B?bElKVnl2eFBNQ1ZmSGxwaGtwemxxNzJBSDBkUFZOZnBmZjU4T28xQXdkU3lJ?=
 =?utf-8?B?cnc3SjhBTWt6UWlIUVNkRHpLbVpGN3Z3TGpLVkE0eGN2RFNUcUg2cnpyN0t0?=
 =?utf-8?B?QU1XKzMxaVhUR3hpOHBDNVVseTJzcHE5RWJGbktMR2hVRHhmaThxU3ZrSk8y?=
 =?utf-8?B?V1RlZGlCQmRpZ0Ztb2ppWHk5S1dQelVtZ2hSS1Y3anc4dWx0UHJXd0tSMS9o?=
 =?utf-8?B?bHFLbkY2dFJhNG4vWUFTa200SmJ1c0hUL25hSmlvNjlvcWs3NnNXZE4vRVRQ?=
 =?utf-8?B?TmNOK0ZQL21nbFlFaEcxL3ZFNk9JRzROUXJmT3NyM1NYVzdOYjM5VUhBU3BF?=
 =?utf-8?B?Ry9SRVp0Y3FES2ZvVkVmUE1XaWc1dXU1bno4UkxaWEdiL0ROT2hjdkJteGpm?=
 =?utf-8?B?eFpvZVlwbndtUGNoZ2dvNms1VEU1MjVoSXZQaUhjVTNacmJzUG1uejR4QThX?=
 =?utf-8?B?dkRkVVRvZ0k3aHFLUlkxLzJhRisxUjVZbnhwZ3l6RlpMWUlKMzlUNDVZNm5C?=
 =?utf-8?B?Wk8zUWJFbFE4cUVtN2Z4V3ZDNHpad2c0M1Z5TzJZYjVxTDlCSUduZFlVUmhG?=
 =?utf-8?B?YUdmKzVKUTZET1FSam9TTjNDZFFMSmh1L1pxUEt5TGVlUHltU1JjNFdQQVgz?=
 =?utf-8?B?RGdYVGwxREI0emVaUk04eEtDbWNGU2Z0T0xzVnp5TWFDYlhiM0l6Y000MVU4?=
 =?utf-8?B?WS9IanMvS0hFZk92c3dtR0JvcS80QnRFZ3k4UmFDM1FZSHJyUmtPdndoWEtV?=
 =?utf-8?B?Q1hWU0k0eVR3aU1LdmIrSUluWHJ3VUkvbnExTGdKd1l0eUtmbFZMTk5uNjRk?=
 =?utf-8?B?V3E2QnUvQXhueWZFNS9CcEdna01YVnhMb2RXaFhtNys2dmRoNGpkTFdyVFRs?=
 =?utf-8?B?SnpKampNTFJCYXpJeWVYNnVjSmQzaHd2aDJHZ2JXZkpwbVZYVEtFeEliT216?=
 =?utf-8?B?WklKWFplN3d3OFdUM2Y0ODJYRWdFRkdDTHRZM2Rac01yUFlZbHJiOU5CL0lY?=
 =?utf-8?B?UndtWjZycGk3LzUxaWQ0TXlZQjNWc01QVTJUdHBLblBjTjN0eGhDRVc4SnlG?=
 =?utf-8?B?Z3dXZnJ1MC9JQTc0dk1kS2FWb0ZjNVRnQ05qeTNPTDAwUkdudkk1eVVXbVFx?=
 =?utf-8?B?RFJCTFZhOWdiU0xZZkVFQ2RvQVJ2U1VnbWdRNk9pR1FVaHIzUVFUUTJsVTNR?=
 =?utf-8?B?SGcvaVJxNnNsS0M4Y2Y1dkZTVENIek1zWGN6V3hSWjBFU1htOTQzNTJHT3lu?=
 =?utf-8?B?Z2tmVkoyVENDWjB5S255bDJHbDNoRTB3cmVIMTNheUhsZ3NZaUtGalYxSGhx?=
 =?utf-8?B?bmxVYm5qQ3o2TWdQZ2txNVZ1b2xyZUhQYlYxeHVQeHh1WGpCdFNqMTdMVmlU?=
 =?utf-8?B?YzVTenFvUlJmQ2l0akYrUnRZY0N1L3pNVWI4aFc1QlpWS0lTcGNQT0hBeVZD?=
 =?utf-8?B?UDFpUjNsR3hmK29BZFJNbzQ0bTdKOFZvVXU3TURnWENIS2pMRUhneWxSTlBu?=
 =?utf-8?B?eExDUW5IN3RjU2hnVytJWm5xRVRGNEw0QUs3MWdiY09Mck1hZGxQNENGdTJR?=
 =?utf-8?B?RmJNVE1aM2EwOGxJQWI4V3p5RVhaZm5nKzNsS0s4SzVUVEgvNEJtL0Y1Q3BP?=
 =?utf-8?B?QU5pRUlTbVJsSjFBaFhpT0w5OFc3TG9nMVdhd1pVKzBOQ3FHMWUyS3ZRMjBE?=
 =?utf-8?B?aVRGS0RBeEFlT0pDMjdOczF4TFZhVTAyNXArYllhckVjSmFzTi9uZUlySFJQ?=
 =?utf-8?B?bmJIeHBsM2RSYVhWK3VSRy84a2JBaVU0SEdBaHcxcTZmbmVGWFVyZ1R4RVRt?=
 =?utf-8?Q?NKcUqUrUi5WkUGiYZ8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902aee50-4318-46c5-119c-08de8358cebf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 12:37:38.4030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Vy+IaszNq45Lu0wEV3L+2iCM69CGCMHAJVL/qaEMRl+SjeEQbJASo/gYNBBA6Qy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7778
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

On 3/16/26 13:34, Dr. David Alan Gilbert wrote:
> * Christian König (christian.koenig@amd.com) wrote:
>> Hi,
>>
>> On 3/16/26 01:57, Dr. David Alan Gilbert wrote:
>>> Hi,
>>>   I'm not sure if this is repeatable, but I landed with a null
>>> pointer during a GPU reset, so thought I should probably
>>> report it:
>>>    6.19.7-300.fc44.x86_64
>>> Mar 16 00:24:39 dalek kernel: BUG: kernel NULL pointer dereference, address: 0000000000000018
>>> Mar 16 00:24:39 dalek kernel: #PF: supervisor read access in kernel mode
>>> ....
>>> Mar 16 00:24:39 dalek kernel: Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
>>> Mar 16 00:24:39 dalek kernel: RIP: 0010:dma_fence_is_signaled+0x12/0x60 [amdgpu]
>>>
>>> see full oops below;
>>>
>>> 09:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Lexa PRO [Radeon 540/540X/550/550X / RX 540X/550/550X] (rev c7)
>>> AMD Ryzen 9 3950X
>>>
>>> I suspect the timeout was real, and caused by a runaway llama, I forgot the
>>> flag to stop it trying to use the GPU for image encoding; but the null page
>>> seems unfortunate.  Impressively the audio still kept playing via it:
>>>
>>> I have the devcoredump copied if it's of interest
>>> (Note for self: ~/amd.core-2026-03-16)
>>
>>
>> Can you open up a bug report for that
> 
> Sure; on bugzilla.kernel.org ?

No, https://gitlab.freedesktop.org/

Sorry I though that this would be obvious.

Regards,
Christian.

>> and please provide what line of code amdgpu_device_gpu_recover.cold+0x244 decodes to.
> 
> Yeh, let me see what I can do with the Fedora symbol packages.
> 
> Dave
> 
>>
>> Thanks,
>> Christian.
>>
>>>
>>> Dave
>>>
>>>
>>> Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu: Dumping IP State
>>> Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu: Dumping IP State Completed
>>> Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu: [drm] AMDGPU device coredump file has been created
>>> Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu: [drm] Check your /sys/class/drm/card1/device/devcoredump/data
>>> Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu: ring gfx timeout, signaled seq=1705630, emitted seq=1705633
>>> Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu:  Process llama-mtmd-cli pid 299886 thread llama-mtmd-cli pid 299886
>>> Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu: GPU reset begin!. Source:  1
>>> Mar 16 00:24:32 dalek kernel: amdgpu 0000:09:00.0: amdgpu: failed to suspend display audio
>>> Mar 16 00:24:32 dalek kernel: amdgpu 0000:09:00.0: amdgpu: Guilty job already signaled, skipping HW reset
>>> Mar 16 00:24:32 dalek kernel: amdgpu 0000:09:00.0: amdgpu: GPU reset(1) succeeded!
>>> Mar 16 00:24:32 dalek kernel: amdgpu 0000:09:00.0: [drm] device wedged, but recovered through reset
>>> Mar 16 00:24:34 dalek lightdm[40555]: ATTENTION: default value of option mesa_glthread overridden by environment.
>>> Mar 16 00:24:34 dalek kernel: amdgpu 0000:09:00.0: amdgpu: Dumping IP State
>>> Mar 16 00:24:34 dalek kernel: amdgpu 0000:09:00.0: amdgpu: Dumping IP State Completed
>>> Mar 16 00:24:34 dalek kernel: amdgpu 0000:09:00.0: amdgpu: [drm] AMDGPU device coredump file has been created
>>> Mar 16 00:24:34 dalek kernel: amdgpu 0000:09:00.0: amdgpu: [drm] Check your /sys/class/drm/card1/device/devcoredump/data
>>> Mar 16 00:24:34 dalek kernel: amdgpu 0000:09:00.0: amdgpu: ring gfx timeout, signaled seq=1705632, emitted seq=1705637
>>> Mar 16 00:24:34 dalek kernel: amdgpu 0000:09:00.0: amdgpu: GPU reset begin!. Source:  1
>>> Mar 16 00:24:38 dalek kernel: amdgpu 0000:09:00.0: amdgpu: failed to suspend display audio
>>> Mar 16 00:24:39 dalek kernel: BUG: kernel NULL pointer dereference, address: 0000000000000018
>>> Mar 16 00:24:39 dalek kernel: #PF: supervisor read access in kernel mode
>>> Mar 16 00:24:39 dalek kernel: #PF: error_code(0x0000) - not-present page
>>> Mar 16 00:24:39 dalek kernel: PGD 849708067 P4D 849708067 PUD 15d277067 PMD 0
>>> Mar 16 00:24:39 dalek kernel: Oops: Oops: 0000 [#1] SMP NOPTI
>>> Mar 16 00:24:39 dalek kernel: CPU: 7 UID: 0 PID: 298062 Comm: kworker/u128:2 Not tainted 6.19.7-300.fc44.x86_64 #1 PREEMPT(lazy)
>>> Mar 16 00:24:39 dalek kernel: Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X570 Pro4, BIOS P3.10 07/13/2020
>>> Mar 16 00:24:39 dalek kernel: Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
>>> Mar 16 00:24:39 dalek kernel: RIP: 0010:dma_fence_is_signaled+0x12/0x60 [amdgpu]
>>> Mar 16 00:24:39 dalek kernel: Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 48 8b 47 30 48 d1 e8 89 c2 83 e2 01 75 2c 48 8b>
>>> Mar 16 00:24:39 dalek kernel: RSP: 0018:ffffcf349c553d20 EFLAGS: 00010246
>>> Mar 16 00:24:39 dalek kernel: RAX: 0000000000000000 RBX: ffffcf349c553da0 RCX: 0000000000000000
>>> Mar 16 00:24:39 dalek kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8bce4ecd4380
>>> Mar 16 00:24:39 dalek kernel: RBP: 0000000000000000 R08: 0000000010000020 R09: ffff8bc9c0400b68
>>> Mar 16 00:24:39 dalek kernel: R10: 0000000000000080 R11: ffffffffa16760a0 R12: ffff8bc9e9100000
>>> Mar 16 00:24:39 dalek kernel: R13: ffff8bca7ccab200 R14: 0000000000000000 R15: 0000000000000000
>>> Mar 16 00:24:39 dalek kernel: FS:  0000000000000000(0000) GS:ffff8bd90c066000(0000) knlGS:0000000000000000
>>> Mar 16 00:24:39 dalek kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> Mar 16 00:24:39 dalek kernel: CR2: 0000000000000018 CR3: 00000001c591f000 CR4: 0000000000350ef0
>>> Mar 16 00:24:39 dalek kernel: Call Trace:
>>> Mar 16 00:24:39 dalek kernel:  <TASK>
>>> Mar 16 00:24:39 dalek kernel:  amdgpu_device_gpu_recover.cold+0x244/0x2ec [amdgpu]
>>> Mar 16 00:24:39 dalek kernel:  amdgpu_job_timedout.cold+0x218/0x258 [amdgpu]
>>> Mar 16 00:24:39 dalek kernel:  ? srso_return_thunk+0x5/0x5f
>>> Mar 16 00:24:39 dalek kernel:  drm_sched_job_timedout+0x8b/0x190 [gpu_sched]
>>> Mar 16 00:24:39 dalek kernel:  ? srso_return_thunk+0x5/0x5f
>>> Mar 16 00:24:39 dalek kernel:  process_one_work+0x190/0x350
>>> Mar 16 00:24:39 dalek kernel:  worker_thread+0x18d/0x2f0
>>> Mar 16 00:24:39 dalek kernel:  ? __pfx_worker_thread+0x10/0x10
>>> Mar 16 00:24:39 dalek kernel:  kthread+0xfa/0x240
>>> Mar 16 00:24:39 dalek kernel:  ? finish_task_switch.isra.0+0x82/0x2a0
>>> Mar 16 00:24:39 dalek kernel:  ? __pfx_kthread+0x10/0x10
>>> Mar 16 00:24:39 dalek kernel:  ? __pfx_kthread+0x10/0x10
>>> Mar 16 00:24:39 dalek kernel:  ret_from_fork+0x130/0x1a0
>>> Mar 16 00:24:39 dalek kernel:  ? __pfx_kthread+0x10/0x10
>>> Mar 16 00:24:39 dalek kernel:  ret_from_fork_asm+0x1a/0x30
>>> Mar 16 00:24:39 dalek kernel:  </TASK>
>>> Mar 16 00:24:39 dalek kernel: Modules linked in: dm_crypt snd_seq_dummy snd_hrtimer nft_masq nft_reject_ipv4 act_csum cls_u32 sch_htb nf_nat_tftp nf_conntr>
>>> Mar 16 00:24:39 dalek kernel:  drm_panel_backlight_quirks gpu_sched drm_suballoc_helper video drm_buddy drm_display_helper nvme nvme_core cec ghash_clmulni>
>>> Mar 16 00:24:39 dalek kernel: CR2: 0000000000000018
>>> Mar 16 00:24:39 dalek kernel: ---[ end trace 0000000000000000 ]---
>>> Mar 16 00:24:39 dalek kernel: RIP: 0010:dma_fence_is_signaled+0x12/0x60 [amdgpu]
>>> Mar 16 00:24:39 dalek kernel: Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 48 8b 47 30 48 d1 e8 89 c2 83 e2 01 75 2c 48 8b>
>>> Mar 16 00:24:39 dalek kernel: RSP: 0018:ffffcf349c553d20 EFLAGS: 00010246
>>> Mar 16 00:24:39 dalek kernel: RAX: 0000000000000000 RBX: ffffcf349c553da0 RCX: 0000000000000000
>>> Mar 16 00:24:39 dalek kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8bce4ecd4380
>>> Mar 16 00:24:39 dalek kernel: RBP: 0000000000000000 R08: 0000000010000020 R09: ffff8bc9c0400b68
>>> Mar 16 00:24:39 dalek kernel: R10: 0000000000000080 R11: ffffffffa16760a0 R12: ffff8bc9e9100000
>>> Mar 16 00:24:39 dalek kernel: R13: ffff8bca7ccab200 R14: 0000000000000000 R15: 0000000000000000
>>> Mar 16 00:24:39 dalek kernel: FS:  0000000000000000(0000) GS:ffff8bd90c066000(0000) knlGS:0000000000000000
>>> Mar 16 00:24:39 dalek kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> Mar 16 00:24:39 dalek kernel: CR2: 0000000000000018 CR3: 00000001c591f000 CR4: 0000000000350ef0
>>> Mar 16 00:24:39 dalek kernel: note: kworker/u128:2[298062] exited with irqs disabled
>>>
>>> --
>>>  -----Open up your eyes, open up your mind, open up your code -------
>>> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
>>> \        dave @ treblig.org |                               | In Hex /
>>>  \ _________________________|_____ http://www.treblig.org   |_______/
>>

