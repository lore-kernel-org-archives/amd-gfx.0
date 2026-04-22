Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9206FA1FFB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 21:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A2AC10E027;
	Wed, 22 Apr 2026 21:00:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ezicVtPi";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010031.outbound.protection.outlook.com
 [52.101.193.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 342C510E027
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 21:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGf+KGTjPwTHATqkr4nm1v626xukfUNR13KXeDlu3WbauEq2npkNWM+71NZppxJ0XZNkZqGlCg02kxDiI5VEKBBH3b6iVQkUPoPUSDb9d2+N5xDYC5XiUoFrJh99G+BsnPcN3gg8evQ5nc1C6z+vwyuxLniMV4fclVeleXKmurmwa3xoeIbkgEnEXaUIe6Zxiy9OcEDqoXsokFSvn9VUL7r/upPgp8/8nKOhQbCNQEtTCFCtKnG/CTe0N+J8Iyp81ybBtiryh+7D8h9RWxF+m7U08uM8Y47RrIpKiKIdkEEthFGjxpc+eN7jWMU5WXlueLT+khstjrZJ0EgCBGnklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1eowIuV40Mgys6+nEz26PyWsXeC4yxyVbtOGs91BvU=;
 b=r1X4hiLvqcAugffoom7AX7fM3ndlzB1hwdMSp1QwxKPb7asFCyWL7Y1TnsplabwIj7RbQYTuRvzWsraKE/42wjJUTV0p/KUSL2bEqkBKtYUFTOLJCt3qDyqIr6KF0s3rx+g/FNQrqnyk+d+u/4AOvN83Fo0VZtvN82W3jOsjkSne1u9nanQJuoZdT9OMJhUzj1b05tBaFk02qzWF0QD6WaIZRQjDVBn2aN4eGWz6MBLx/dhi8rxs0DO03pFlLkxlfN//tfctJtIZMB23qahbE3AtQyvB6EdO89+3TVkJnUfN55WBzCSu14c5XkrzF89lWMF9ZjJZJ0r/Y8a02tLFgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1eowIuV40Mgys6+nEz26PyWsXeC4yxyVbtOGs91BvU=;
 b=ezicVtPiGOxzHIdRtyWlQSBufyOG7u6N0i3pTmy/MfcanzNPTmTYKtuQPU6a1JeQJ5MPezorDP4MGvNtf6yaqZlONoQl0/3OtWmIb75mUx7DJdA40l0v5yAQXx6oBX7OAd1FSHdfydFOw80IcvKqFirgHPCj6J29Inlr81kpZVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6627.namprd12.prod.outlook.com (2603:10b6:208:3a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 21:00:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 21:00:53 +0000
Message-ID: <339fdaba-5649-4bf3-bd09-6bd20c197118@amd.com>
Date: Wed, 22 Apr 2026 17:00:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Terminate queues on surprise unplug with
 running processes
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Kent Russell <kent.russell@amd.com>
References: <20260112182925.347303-1-mario.limonciello@amd.com>
 <2b4d4476-97a6-42f8-b5cf-5599ac8d0035@kernel.org>
 <60e1e12d-7705-4531-ba15-c956f4d268d4@amd.com>
 <5fc35475-e7a2-483e-84d8-1de7226e1e59@amd.com>
 <43f46559-fb74-4a34-9cd6-16de02b4147b@amd.com>
 <fbfaf548-0c34-4c09-9674-8802224f9349@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <fbfaf548-0c34-4c09-9674-8802224f9349@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0401.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: da107e18-a64b-4fa9-ac40-08dea0b23d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: Zyki4ilyRIAOdas/i7utbjRg5P0dHYbKaL7SVtNa1BMUZbpD6Tv41ud2mxJFq+9ZLKAR7/PMIiLd45xw0fnF+MPnD/Oc+2fpXCojSUy10vnyQDyvyvj1T3qnetYSy25SS6LbZecT4YB7A2nucW0pprsPpEiUHVlsU9iGTmJITKn/aDv+kKzjbNG2LIT0VpBkSsj0NEqpnG8Zii5H+dyqvwA17mlL71837mkOjmrsdbnzb5NUkT8fFwQ7JmJ1CYW0h+p0Ya8FJP8yu6jrkRlFSb1bYNBX2oPn9dqCQ/A5gRNZKFi1m6ROc/p8oMdrPsX9OFwKPVkrqCZ7hHkV5EhuFEKds1fc5vb4ZPSy96K0Ox1f8wOD+cKQ9eaP5tWAa08IwuXdompLs+GQOw7nBxSUBTqZN9jZi9NmfzXdfNY1FZOpeVISKSrUUzSaB0FT4BoRdw9WOXpups+02cf68QzsLNVIBg3Pwv5j6tc3Aszg2BvSlp0ZT1XfcCnA2DOjAfaqd+qPmf/u6RYLT0hijQKKMg1x3sY9BNwjSj3ntnECX4hbzBnwpYkjmk/BHAG2adXuH0tkXbU8YjMAwtB7R7sHjFy6eWXh6zfbNEJwvZwj/EZmoXhxKLgYw3vC2FWkIrNdks+zSjthtWqNMiWvCykAgQ1Jr5nxPSV9tGRv/maztVkZldG+zhvMOt9DUsD7RW7qW1WQy3nltrWWwaxr2+UrgevXagKHJNaKhuCSvixFIxE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0poZ1pYenh4S1RMQmtHQktNRGRObWFaVG4zWHNoN0NDU2pId1A2am9sNjhi?=
 =?utf-8?B?dlJ2ZkkyOE13ZW5EbTFkUEg3N1oyN2pyZitFL21MR2d0dHFhQncwYUIyMnFT?=
 =?utf-8?B?NzJnR1JXNmRCYXlCR3RiRVFlaHBFTGRSWVJGN0I5eTM5NVFCQmcvZGhOZ2pU?=
 =?utf-8?B?NGNLSzJ6MW5iTkUwU3ZneVVBUC91c0Z3cVhoZ05ZZFQ1LzRxd21CTjNqOVVp?=
 =?utf-8?B?WS9QQjRpemoyc1huN3dCalB6TUZvaExNUmw5RGRkbjdwcG1Kc011TE43dFVM?=
 =?utf-8?B?NEVPQkRVa3JiQVhzdFdTZ1IzcXI5OExoVHI4dmsvTFNHT1laT3ltbk1aYWFn?=
 =?utf-8?B?V0dUWG1SWk9NT2J1UDR0aDA5NmRTYnlDNmFLeUpkZHJIczNrN2Q4VTNFenVq?=
 =?utf-8?B?VnpweTAwRTFESTJTMTRoQjlydHFnNFA2bjR2Q2JUWFQ5UklmWGpRQmYra0J6?=
 =?utf-8?B?WVA4eFFFbTAzdlhQYUZxMWo0OStmRmgvWUdNcStBV0dYa25HcjNPeWcxUm9m?=
 =?utf-8?B?RWhTcUlUblZTaGVmK2toNk15ZE9nWU5GaE1sNTVPUTlvcVRjMk5zc3FaWnlZ?=
 =?utf-8?B?amtBRmRwSmdaeVhZS1hvcXJRYXk5d0VIcDFxajF4bmd3M01CRnZQRlJQRThZ?=
 =?utf-8?B?akpMbzA3K0Yya05rQ2ZNY05BNm1DSjRqTVd0N0Y0eTNrd2RQUGFWeUM5UjJE?=
 =?utf-8?B?RXlNS3M3NjVXeG82bFFhS1BiUjlrclV4R0ljS1A1T3lXZXRVOHZBN0ZCSUZi?=
 =?utf-8?B?c0wweVIxNWpkY1dab1hRQ1BFSlBIcTNDd3FrWnpNQlhHek1GRGVUbU1seHBh?=
 =?utf-8?B?dkJZWEhJU0NHV2MyYVFxTHh3ZlpENWNlM3ZwSXdIdVR3Z0FXZmY3YlRHOXA2?=
 =?utf-8?B?a1A0aTlzWkxxVkQxcGNUS1kxMTBLQWMyV3RyWXp3aW4xbkhUZ09Ya2E0NDVX?=
 =?utf-8?B?bWRhbnV1ZjhIWkFwQUp0a3ZPMFF5WGFTREZmOTdhMkNCSkJyTjdrMk1UNmtw?=
 =?utf-8?B?cmF0dTZuRjExYlJablZmQjRtSjFsM2NTMXRLMnpURG5GL1A4OUUzV1NsOVp0?=
 =?utf-8?B?YkhKYlZGVTIxQmlaamtNRXRNeUZud0pmbHBaVTdncXU1ZHJXMGMzQWd0d2hp?=
 =?utf-8?B?eE5JdDNscktBcEhyU1IrVTdiL0lrM2E4bHVXRHBEUW9vUTRtRUJEbWRZbjFJ?=
 =?utf-8?B?aVZNM1ZUTDQvYU1rczdWNXBNbWZFWkp0TjJJeTlETWFmb0pSUjBpQWNqcDhW?=
 =?utf-8?B?ZDFMNmJMQ2cwZ2FtZ054c3RLbEZ1cnkxYlRzUUoxYzlwb0xLeXFUMHFObjVn?=
 =?utf-8?B?YzQ2RkxLK3FnYkk1R3FPWGJsTys1aksrSHBtMWN2U210a2l1bUh6QTVFRmFa?=
 =?utf-8?B?UnNvSFoxeTlIRGEvNHFJbUNvMlJIT0RtZDlUWWFjVHlTTUsrMkJTOG5aNDk4?=
 =?utf-8?B?b2lEM3VLZVRPbnFtWjFTWXNsQW9uZ1cwaXFXTGZnc0lkSnVNcGNXSlZDd2Zr?=
 =?utf-8?B?Nm9obXJjLzN0U3JMMitjVjM1S2V4QUUwcFVGUERWUVEvanVvSTBTTWpnS1dy?=
 =?utf-8?B?NU1raEdIcEY5b1dCNWp3WGFrSkFKd2JhOG5BYk1RaENaRlI0K2c0QWxQTDg5?=
 =?utf-8?B?U2o5OGFIMHJkZlMzendwYVErRk1YNUEvR2lEMlBxMW5FY1JoeERYZWVzNXlq?=
 =?utf-8?B?OUdYZlRRT1hrWktDcjBxbzdsaERqZ1dWOWJ5OVptdkR2d0hkdkNkYTRER3hO?=
 =?utf-8?B?NHdqbVNpNFFDRzNoenoyQnNTN1kraDg5TlFVT2hxTEh4Wi9iWFB0VEZHQVpI?=
 =?utf-8?B?cCtqSHBLQ3RYNEEvdGVyV1craktPTHNqQlcxRFdZRW1MbnNkaGRkNW9HQkpx?=
 =?utf-8?B?eWk4U3dMZUFoUWVBdS9WUXNYdytaOGJLdk1kWDVtZHAzRlJXWWo5Y2cvc2ZV?=
 =?utf-8?B?cW5HMFlrOTBhWkdCUGFmcTREaDArTEU2TjFpMHU0eEVITCtCK2hpejMxbU1C?=
 =?utf-8?B?WVQ1Vmd6YjJ6cGxLcjJodWdPdFJhbmw0WnRrMWFxeUYwRnVFYy9RNm1HdWxj?=
 =?utf-8?B?REtncitRZDN3QVdMMis0VnpVa29qRzMxc01pUmE5dEFUcDl1ZUEwcmFNeFdY?=
 =?utf-8?B?QkVkYThxd2JzNEFiSUw1V0FxRlhNWGU2NkRLTm93b0U4V3ZVZ0F5dUNQZGRC?=
 =?utf-8?B?UVVuQ1N1UytiZ1k4UFJrNmpGazZHRmsxWTlaZy9FM0swOVNJT0IyRUs4RzNh?=
 =?utf-8?B?QWdIYkRUbFA3bzNpaVZQQ3kwaXpwTTZnOWQ1R0lZSmxqY3BsWExVeVNZSklC?=
 =?utf-8?B?REd2NzRxN28zQzg3QWduWHFsQUowMFlZUnBWM2VjMzc4anYvQUk3QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da107e18-a64b-4fa9-ac40-08dea0b23d6b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 21:00:53.2435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxE9olXzrPld8QsJXZhj9T9KYU7lnm6sTRzGcW4ugPzWYPMSFQKdxB9UHkzr/mM8UVr27PMgtbmrPUJepkQb3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6627
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


On 2026-04-22 11:53, Chen, Xiaogang wrote:
>
> On 4/21/2026 8:56 PM, Kuehling, Felix wrote:
>>
>> On 2026-04-21 11:00, Chen, Xiaogang wrote:
>>>
>>> On 4/20/2026 4:25 PM, Mario Limonciello wrote:
>>>>
>>>>
>>>> On 3/7/26 06:49, Mario Limonciello wrote:
>>>>>
>>>>>
>>>>> On 1/12/26 12:29 PM, Mario Limonciello wrote:
>>>>>> When a surprise unplug occurs while a process has active KFD queues,
>>>>>> userspace never gets a chance to call kfd_ioctl_destroy_queue() to
>>>>>> properly clean them up. This leads to a WARN_ON in uninitialize()
>>>>>> complaining about active_queue_count or processes_count being 
>>>>>> non-zero.
>>>>>>
>>> During hot-unplug driver sends SIGBUS signal to all processes who 
>>> are using the unplugged device. It is expected that affected 
>>> processes will clean their workloads when get this signal.
>>>
>>> When a device got removed physically all sources from it will be 
>>> removed. It is unnecessary(in theory) to clean them up. I am not 
>>> surprised to see some software warnings due to hardware got 
>>> physically removed since it is unexpected behavior at run time.
>>>
>>> I think what we need worry about is if there is memory leak. Driver 
>>> also waits when an affected device is idle(by 
>>> kgd2kfd_check_device_idle(adev)) by checking/waiting if there is 
>>> process still using it. If there is no process using the being 
>>> removed device the processes should have been terminated by same 
>>> process termination logic from driver.
>>
>> The problem is, that a lot of the process termination stuff happens 
>> in a worker thread. It can happen after the hot-unplug is already 
>> done. That would lead to the cleanup worker accessing pointers to 
>> device structures that are no longer there (or used by something else).
>>
>> We'd need to ensure proper synchronization so that the process 
>> cleanup completes before the device unplug frees the device structures.
>
> How about at kgd2kfd_device_exit before doing any device clean up 
> check/waiting there is no any kfd process run on this 
> device(kgd2kfd_check_device_idle)?

Looks like this should already be happening in this call chain: 
amdgpu_device_ip_fini_early -> amdgpu_amdkfd_teardown_processes -> 
kgd2kfd_teardown_processes -> kgd2kfd_check_device_idle

Maybe whats missing at the end of kgd2kfd_teardown_processes is a 
flush_workqueue(kfd_process_wq) to make sure that all the cleanup work 
is done. After that, there should be no more process data structures 
referencing the device.

Regards,
   Felix


>
> Regards
>
> Xiaogang
>
>>
>> Regards,
>>   Felix
>>
>>
>>
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>>>> The issue is that during surprise unplug:
>>>>>> 1. amdgpu_device_fini_hw() checks drm_dev_is_unplugged()
>>>>>> 2. It calls amdgpu_amdkfd_device_fini_sw()
>>>>>> 3. This leads to kfd_cleanup_nodes() -> 
>>>>>> device_queue_manager_uninit()
>>>>>> 4. uninitialize() has: WARN_ON(dqm->active_queue_count > 0 ||
>>>>>>     dqm->processes_count > 0)
>>>>>>
>>>>>> The warning triggers because the queues were never destroyed - 
>>>>>> userspace
>>>>>> had no opportunity to clean them up before the device disappeared.
>>>>>>
>>>>>> Fix this by checking for device unplug in kfd_cleanup_nodes() and
>>>>>> calling process_termination for each affected process before
>>>>>> uninitializing the DQM. This mirrors what happens during normal 
>>>>>> process
>>>>>> shutdown (kfd_process_notifier_release_internal), ensuring queues 
>>>>>> are
>>>>>> properly cleaned up even during surprise removal.
>>>>>>
>>>>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>> Cc: Kent Russell <kent.russell@amd.com>
>>>>>> Cc: Xiaogang.chen@amd.com
>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>
>>>>> Ping?
>>>> Ping?
>>>>>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 32 
>>>>>> ++++++++++++++++++++++++
>>>>>>   1 file changed, 32 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>>>>> b/drivers/gpu/ drm/amd/amdkfd/kfd_device.c
>>>>>> index e9cfb80bd436..7727b66e6afb 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>> @@ -664,6 +664,38 @@ static void kfd_cleanup_nodes(struct kfd_dev 
>>>>>> *kfd, unsigned int num_nodes)
>>>>>>       flush_workqueue(kfd->ih_wq);
>>>>>>       destroy_workqueue(kfd->ih_wq);
>>>>>> +    /*
>>>>>> +     * For surprise unplugs with running processes, we need to 
>>>>>> clean up
>>>>>> +     * queues before uninitializing the DQM to avoid WARN in 
>>>>>> uninitialize.
>>>>>> +     * This handles the case where userspace can't destroy 
>>>>>> queues normally.
>>>>>> +     */
>>>>>> +    if (drm_dev_is_unplugged(adev_to_drm(kfd->adev))) {
>>>>>> +        struct kfd_process *p;
>>>>>> +        unsigned int temp;
>>>>>> +        int idx;
>>>>>> +
>>>>>> +        idx = srcu_read_lock(&kfd_processes_srcu);
>>>>>> +        hash_for_each_rcu(kfd_processes_table, temp, p, 
>>>>>> kfd_processes) {
>>>>>> +            int j;
>>>>>> +
>>>>>> +            for (j = 0; j < p->n_pdds; j++) {
>>>>>> +                struct kfd_process_device *pdd = p->pdds[j];
>>>>>> +
>>>>>> +                if (pdd->dev->kfd != kfd)
>>>>>> +                    continue;
>>>>>> +
>>>>>> +                dev_info(kfd_device,
>>>>>> +                     "Terminating queues for process %d on 
>>>>>> unplugged device\n",
>>>>>> +                     p->lead_thread->pid);
>>>>>> +
>>>>>> + pdd->dev->dqm->ops.process_termination(pdd->dev->dqm,
>>>>>> + &pdd->qpd);
>>>>>> +                pdd->already_dequeued = true;
>>>>>> +            }
>>>>>> +        }
>>>>>> +        srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>>> +    }
>>>>>> +
>>>>>>       for (i = 0; i < num_nodes; i++) {
>>>>>>           knode = kfd->nodes[i];
>>>>>>           device_queue_manager_uninit(knode->dqm);
>>>>>
>>>>>
>>>>
