Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF785FAD3E7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 01:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7655710E2DE;
	Thu, 23 Apr 2026 01:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BDFQThT5";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAA9610E2DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 01:38:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxoCMts9ryYusPokzOZsR/T8V+Bb6GTdWq+D1v3ou93zFGMr11Uu/AbjLBxLM/meL8dlAsBJMrRJHPScrpAfnknDjTsBDWujCOpMrSSLUMwlJTGBc17XwTPFvjUzjwPibnDvzAyAOh4oFLrmv+zUeND4lfkmr53JrVdNzDd9KlNyyUS7tgt9m7sy+DPCh1cKi85N4hUqQEFjSm8dfBYBOdY+sFdkPULYoMt8p9Bpqoj5UHpOS67kytWPFTmndfg/OTP7Z5BWolemUglo1f2G+ShFpYiBhoRFiAyRwIZSGb7Q3rQkh5HpiajcfZJshOlyVMZ0oboRMKkD6al4yu1vfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hli9YZFid4Yn+TOPSRAHCNvbtp16n0ZVPgOox8SeoB8=;
 b=lesD3xTBpDCFBtFkqoNZ4BmkK5UYZcWnpbbb7H3rXQJ8wiQGdIDJnsXv7cUNWfNDfJw2kJ3mUzZAJxcU7o/9Ss7dhdUv6J5ywNXkD2+ePbAVht4EcosODi3yvb71Tp+juLE9ijHobB6mjlJPSuAMIVYnOc+eS6mWrLo+vHZ4+B93sUS0fWwwgoBKe8L/wPUNtdm1WZ8ObZnquqlB7dhJ5lUkh5kMFuVIAnTTbuTsKHNV0NXlBIVRosNWciv81+yVq1U+fezN3rSTJmKJ/S11P1/HvhKtzVHgRGCND3RA5LoEYMPgPuJyDAPaaUf7PaPYQu4DbM4l/cWif+xW4vIKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hli9YZFid4Yn+TOPSRAHCNvbtp16n0ZVPgOox8SeoB8=;
 b=BDFQThT5ltumuYHMmlAgiUjpc2YT1cN/O5HYlgp+c3ATjV10PXDWFfatUEsTDe2Y1IEWbIocT16bR1tVP6RAY3X5grR3irUHjSEbjwO7IFX+ZTCXvGECKlLhQRkDLnZTENnazv7Ar7pId5OxWckO8l0UCfxWdM865Bv6Pdi3yGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB999080.namprd12.prod.outlook.com (2603:10b6:8:2fe::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Thu, 23 Apr
 2026 01:38:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 01:38:30 +0000
Content-Type: multipart/alternative;
 boundary="------------9iJ061vf4UTBp9iGr2LgbUbu"
Message-ID: <48121b63-5551-4d54-882c-bb78271d07df@amd.com>
Date: Wed, 22 Apr 2026 21:38:29 -0400
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
 <339fdaba-5649-4bf3-bd09-6bd20c197118@amd.com>
 <59e14708-56db-4b49-be3a-d3b48e71c99b@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <59e14708-56db-4b49-be3a-d3b48e71c99b@amd.com>
X-ClientProxiedBy: YT4P288CA0021.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB999080:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4938ba-14fe-446e-58b6-08dea0d90623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: 9STN+BXaPXtk0nDsXz8/ebfUe+BUAFwHuZl7FrmhhabW/WMMttfAazKqNRy5ypivybiVBxWjTJmD/DsBl4aXMQwlAt7viy9X1pHxvo9L7gDLmIQ+9Vgf7w3LFFkLSwXpSjQwAl/XiVZls49uMM1Ql+rGGymW5CTkbX2AuyAvxqq5Ma/pJVfzXNhXAqpzwfTWS5jPuYVPE68+7KsC4vOEUqtTK8dKuXNXSNuSCmuNfH8i3q3mtrUBAWHlH4YWQTcSZ0QoKLggTiMPWS0UavCnMWfYWZ94AxHh/dzr2rBDu5EJKIOsUTOU1tsYXdfnCsVHDGk4aCgLJaVudOKVGrVM/+Qoa33sqQtGVsRfP0R41NooMCbfIyKSmVgc8uwbgl/acX2vGtY5som0iQuIVJ+JzuuR94jIEjRc00JT2N7Z2aXgLRvIihbtzgxAXY3WooZbjk8kKrKnBAWWsIxdRm0gRZRZXrni5Z8+rT2WUTIk5ZnmJK1ChipbibSMbiA6ixfTBwK+SFOi+RC4QVw4HX3IiqyLOtS0ZncKCJKD4KkUtqdeloacjb3Kyo2Th0OQh2UfJk516WYq5TvAx5eBfX0tUBhw7sqMv83WvDUqwUpeO8jqlv4yuc+eKghgP18A3m/mxw7cttIn3DtX3ZbQi2mXfhkdlDS9STYBXkF4pKzTJAsgrOQaLXNftJvte0cnOzZhTBjSPoZ9Kmix0p8O9HBcJJGCeg6DTsrDqqE+mLA/foQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEdCMGdxbkhIRlR4NGxZM1gyMzkxU25uWFdhWEMvZEI3Q29nUDR4aEp0Mlpi?=
 =?utf-8?B?c3BnS3RCa3RGV1VGNi9DcjkxSlBpeXM2c2ZSQnlkSFMzZXNUZ0NVeXhIVWhB?=
 =?utf-8?B?bDlmSXdqT0hmUXpkMGF3OFJ1M0JWRndjazN6TTNFOEZQbHJRY1E5b1lZZ05M?=
 =?utf-8?B?YkhUcnVPeFkrNU9ab1hGSElRaTRvdHQ5OWJzSEFqL1VsTk1yME9CSlNqMVU3?=
 =?utf-8?B?VmZ6NDl2bTJEcDVyVm01aEs5a0dqbWVwbmhzUHcwSlg0TTlZbjFFcExTbUli?=
 =?utf-8?B?RUFrNk0xSUFZQVpVd21rT2FQS0taeDcrQ1llOXZRY2Fxc2RrZUFNeTFaNzRX?=
 =?utf-8?B?MmR2U0JWY3Rlejg2WWFRQTg1TE0vWks0YllqMmxKdjlpQ1BZWkNnN25BQ1VB?=
 =?utf-8?B?RGo1NWJhQS9kbDZCWnFwOTJCV2pMVEhVVlNKZURtQVBPODgvU21zUitNaXM5?=
 =?utf-8?B?NnlZdTEzS2NCMGFBRnk3RHU1ZWZQaEN2djdmalRRYUNoY3IzajVvKy9WK05u?=
 =?utf-8?B?eDlSK000OGtnS2VaZktHbFljOFhvTVNSaUl5TDBiK1Z2OVZEN0lPeFNITytZ?=
 =?utf-8?B?S3lqdGl1OXgvTS8vY1dhUlFvSHQ2YVBkNzM4aWFjVUlPbFlPc3FHSW94Y05D?=
 =?utf-8?B?dENiZVdEeHhkNGd4amMrc1IvR2daUm14YlFwYmUwby9oVVRRNnlMMGJPYWlS?=
 =?utf-8?B?UUt2Q2ZqWXJlUzBNdExlSjRYUlJWN3hXa0doRHRZb3JDd2VQbEtiUWpQbUhv?=
 =?utf-8?B?bCt2bGZDc1JaUFZabnhwMWp5NUZ4eHdMVGtzakhDV25XdDZObnFBNjI0VUNY?=
 =?utf-8?B?bzZpbUZOVUNaSDkwQlI0andDYVNYNmEycGhNN3BENkFpNktMQ0R6Y24yaXBv?=
 =?utf-8?B?dVFVc1crUUxlS3BOdkt1ZG93TWFubFhjRGhnUmZnU3dIRER1MERaUWdSaEc4?=
 =?utf-8?B?bDIrWDUvTXREL3NVUDczSFdIMktsbVJUb3V1Zmd3ckRtcnNyVjNNZU53RzR4?=
 =?utf-8?B?Y1gzSU5VZFhIeDRqRitSbmROTGxwKzM4SXJZRDdWWmpoSVpRZWR4R01xdWp6?=
 =?utf-8?B?OFBiWmVGcW96U2gxUGRkN3ZiS0cvbExFeFpCSmYrNlNhMlRMSWlVTElMRWYv?=
 =?utf-8?B?V21wNHNSZlQ1MkdURFVZNGQyVTFoZUtZRWZMWHgySGpzbldvL2dtVlpuTlk1?=
 =?utf-8?B?NU11OHg1M0VLdGMzclNYVnd0NDlXaTFjdFdKSFdDU1UxRTZhM1hSeXBSWWVm?=
 =?utf-8?B?R1lJOTgxVVhnOWZoYlJaZ2Z0Mythbld6dW9VOUl2amFKTG9waE1LNVlmUFVi?=
 =?utf-8?B?a3ZvMWZJV0d2c2NpTFVxa25GRUZEb3FNY3JTNHByRndCMUdxM0NyOVovMXRY?=
 =?utf-8?B?MkNFZGtPUFA5NTI5S3V0cGoyU2pWa1VxQnZNMTJBSFpHcVlTQnNaUk5iV1BS?=
 =?utf-8?B?c0svQ0x6UXBHNlRmK2pnRENGbVdHOTBuUjM1dkNBUFM0Mkx1SlNJSVpEeFZ6?=
 =?utf-8?B?S0ljUzhudUZtNzVjR1loYWtqb0lyMUIyMW5qWnZIQjdBa3RmWTMzdkhtdm1F?=
 =?utf-8?B?M0h4ZE43SkxVSHpRUFRJYW4wQ2tGWnpTSUZDdzNiNDhTQldIN2JKaEl2aHZD?=
 =?utf-8?B?M3RWLzY3UnlPSFVhcW5acjZLMWFtTmxyN3dVWkFBZmVwOE1xbHlNU1ZiSUVm?=
 =?utf-8?B?UkRBak8zci9PV3dvSDE2QVZncUtGRmIrOHgzS2I1dkkzM2FCSjQrb3lGT2lU?=
 =?utf-8?B?Sy9uMTR2bFl2RlpHcjIwTHZHdkJFaGllVHplMm9WNlY2RXYrVVB4Vk9YYTVQ?=
 =?utf-8?B?M3QxZFhwM2NmRjZjb242WVBiVzlJbDRTOTdXZjZqOHQ4T1QrcTdnc2JPN21h?=
 =?utf-8?B?Mk9vV3hpUDgzSXozZDJUS3hnaUg1OC9tODNCRTBmMUtzL1Y5MXYyNGNLNE9s?=
 =?utf-8?B?VUw5NkdtbGJSc29QV2lSZWFJSEdEL1JZdUFJRWQ0WitDL3VGZmFrblZoVkoy?=
 =?utf-8?B?UlBwMFJONGRaTXhUNWxka1FwbTdRZjFVTVhHMUtLemhLTWx3V2tTcE15UFRG?=
 =?utf-8?B?SFRSNzVsOGpQdllzQk9JaHJhdFM5N21ESnltVHdjY1dGSVRKQ0F5SWFhUEFE?=
 =?utf-8?B?bXdOL1JsZm9JL1dkaUlwTHV3Nm9abFhlVE1QbE1TVE0yelVGK0p2ejdVRmd3?=
 =?utf-8?B?QVAraTczZnl5eGQ2OFJyVW45VFZMMTEwaXV4WkI2Q21hNkZ4bFJLNVBNKzhx?=
 =?utf-8?B?cWZ0Wm9CdlRDaWorZ3BDSWtIaUtDeHJaeldidStaajkwTUhVVTFGbnhMM1dF?=
 =?utf-8?B?QUQrRlJiT2pWSFVxK202N0NzM2JadzVFeG9GUVA2RjBFdy96aGZHZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4938ba-14fe-446e-58b6-08dea0d90623
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 01:38:30.8469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bo2LzKDz2ZMNIANXw1mK8y5IskEr/VsI6iEeD9xtia9l81Wj+mqdgkTFR7Gt3hC1mvAB6vmQGoDJuk/AdjC0vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999080
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

--------------9iJ061vf4UTBp9iGr2LgbUbu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-04-22 18:02, Chen, Xiaogang wrote:
>
> On 4/22/2026 4:00 PM, Felix Kuehling wrote:
>>
>> On 2026-04-22 11:53, Chen, Xiaogang wrote:
>>>
>>> On 4/21/2026 8:56 PM, Kuehling, Felix wrote:
>>>>
>>>> On 2026-04-21 11:00, Chen, Xiaogang wrote:
>>>>>
>>>>> On 4/20/2026 4:25 PM, Mario Limonciello wrote:
>>>>>>
>>>>>>
>>>>>> On 3/7/26 06:49, Mario Limonciello wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 1/12/26 12:29 PM, Mario Limonciello wrote:
>>>>>>>> When a surprise unplug occurs while a process has active KFD 
>>>>>>>> queues,
>>>>>>>> userspace never gets a chance to call kfd_ioctl_destroy_queue() to
>>>>>>>> properly clean them up. This leads to a WARN_ON in uninitialize()
>>>>>>>> complaining about active_queue_count or processes_count being 
>>>>>>>> non-zero.
>>>>>>>>
>>>>> During hot-unplug driver sends SIGBUS signal to all processes who 
>>>>> are using the unplugged device. It is expected that affected 
>>>>> processes will clean their workloads when get this signal.
>>>>>
>>>>> When a device got removed physically all sources from it will be 
>>>>> removed. It is unnecessary(in theory) to clean them up. I am not 
>>>>> surprised to see some software warnings due to hardware got 
>>>>> physically removed since it is unexpected behavior at run time.
>>>>>
>>>>> I think what we need worry about is if there is memory leak. 
>>>>> Driver also waits when an affected device is idle(by 
>>>>> kgd2kfd_check_device_idle(adev)) by checking/waiting if there is 
>>>>> process still using it. If there is no process using the being 
>>>>> removed device the processes should have been terminated by same 
>>>>> process termination logic from driver.
>>>>
>>>> The problem is, that a lot of the process termination stuff happens 
>>>> in a worker thread. It can happen after the hot-unplug is already 
>>>> done. That would lead to the cleanup worker accessing pointers to 
>>>> device structures that are no longer there (or used by something 
>>>> else).
>>>>
>>>> We'd need to ensure proper synchronization so that the process 
>>>> cleanup completes before the device unplug frees the device 
>>>> structures.
>>>
>>> How about at kgd2kfd_device_exit before doing any device clean up 
>>> check/waiting there is no any kfd process run on this 
>>> device(kgd2kfd_check_device_idle)?
>>
>> Looks like this should already be happening in this call chain: 
>> amdgpu_device_ip_fini_early -> amdgpu_amdkfd_teardown_processes -> 
>> kgd2kfd_teardown_processes -> kgd2kfd_check_device_idle
>>
>> Maybe whats missing at the end of kgd2kfd_teardown_processes is a 
>> flush_workqueue(kfd_process_wq) to make sure that all the cleanup 
>> work is done. After that, there should be no more process data 
>> structures referencing the device.
>>
> We send signal SIGBUS to affected kfd processes(who are using the 
> being removed device). The app signal handler will be executed 
> asynchronously. There is a delay for signal handler got run. If call 
> flush_workqueue immediately after sent the signal the 
> kfd_process_ref_release(from kfd_release->kfd_unref_process) will not 
> be got ran immediately after sent signal. Then flush_workqueue will 
> not take effect since kfd_process_wq is empty or no filled work item yet.

This loop at the end of kgd2kfd_teardown_processes waits until all 
processes using the GPU have terminated:

         /* wait all kfd processes use adev terminate */
         while (!kgd2kfd_check_device_idle(adev))
                 cond_resched();

After this time the processes are no longer in the kfd_processes_table. 
But their kfd_process_wq_release workers haven't necessarily run to 
completion yet. Adding a flush_workqueue after this should do the job.

Regards,
   Felix


>
> Regards
>
> Xiaogang
>
>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>
>>>>>
>>>>> Regards
>>>>>
>>>>> Xiaogang
>>>>>
>>>>>>>> The issue is that during surprise unplug:
>>>>>>>> 1. amdgpu_device_fini_hw() checks drm_dev_is_unplugged()
>>>>>>>> 2. It calls amdgpu_amdkfd_device_fini_sw()
>>>>>>>> 3. This leads to kfd_cleanup_nodes() -> 
>>>>>>>> device_queue_manager_uninit()
>>>>>>>> 4. uninitialize() has: WARN_ON(dqm->active_queue_count > 0 ||
>>>>>>>>     dqm->processes_count > 0)
>>>>>>>>
>>>>>>>> The warning triggers because the queues were never destroyed - 
>>>>>>>> userspace
>>>>>>>> had no opportunity to clean them up before the device disappeared.
>>>>>>>>
>>>>>>>> Fix this by checking for device unplug in kfd_cleanup_nodes() and
>>>>>>>> calling process_termination for each affected process before
>>>>>>>> uninitializing the DQM. This mirrors what happens during normal 
>>>>>>>> process
>>>>>>>> shutdown (kfd_process_notifier_release_internal), ensuring 
>>>>>>>> queues are
>>>>>>>> properly cleaned up even during surprise removal.
>>>>>>>>
>>>>>>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>>>> Cc: Kent Russell <kent.russell@amd.com>
>>>>>>>> Cc: Xiaogang.chen@amd.com
>>>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>>
>>>>>>> Ping?
>>>>>> Ping?
>>>>>>>
>>>>>>>> ---
>>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 32 
>>>>>>>> ++++++++++++++++++++++++
>>>>>>>>   1 file changed, 32 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>>>>>>> b/drivers/gpu/ drm/amd/amdkfd/kfd_device.c
>>>>>>>> index e9cfb80bd436..7727b66e6afb 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>> @@ -664,6 +664,38 @@ static void kfd_cleanup_nodes(struct 
>>>>>>>> kfd_dev *kfd, unsigned int num_nodes)
>>>>>>>>       flush_workqueue(kfd->ih_wq);
>>>>>>>>       destroy_workqueue(kfd->ih_wq);
>>>>>>>> +    /*
>>>>>>>> +     * For surprise unplugs with running processes, we need to 
>>>>>>>> clean up
>>>>>>>> +     * queues before uninitializing the DQM to avoid WARN in 
>>>>>>>> uninitialize.
>>>>>>>> +     * This handles the case where userspace can't destroy 
>>>>>>>> queues normally.
>>>>>>>> +     */
>>>>>>>> +    if (drm_dev_is_unplugged(adev_to_drm(kfd->adev))) {
>>>>>>>> +        struct kfd_process *p;
>>>>>>>> +        unsigned int temp;
>>>>>>>> +        int idx;
>>>>>>>> +
>>>>>>>> +        idx = srcu_read_lock(&kfd_processes_srcu);
>>>>>>>> +        hash_for_each_rcu(kfd_processes_table, temp, p, 
>>>>>>>> kfd_processes) {
>>>>>>>> +            int j;
>>>>>>>> +
>>>>>>>> +            for (j = 0; j < p->n_pdds; j++) {
>>>>>>>> +                struct kfd_process_device *pdd = p->pdds[j];
>>>>>>>> +
>>>>>>>> +                if (pdd->dev->kfd != kfd)
>>>>>>>> +                    continue;
>>>>>>>> +
>>>>>>>> +                dev_info(kfd_device,
>>>>>>>> +                     "Terminating queues for process %d on 
>>>>>>>> unplugged device\n",
>>>>>>>> +                     p->lead_thread->pid);
>>>>>>>> +
>>>>>>>> + pdd->dev->dqm->ops.process_termination(pdd->dev->dqm,
>>>>>>>> + &pdd->qpd);
>>>>>>>> +                pdd->already_dequeued = true;
>>>>>>>> +            }
>>>>>>>> +        }
>>>>>>>> +        srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>>       for (i = 0; i < num_nodes; i++) {
>>>>>>>>           knode = kfd->nodes[i];
>>>>>>>> device_queue_manager_uninit(knode->dqm);
>>>>>>>
>>>>>>>
>>>>>>
--------------9iJ061vf4UTBp9iGr2LgbUbu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026-04-22 18:02, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:59e14708-56db-4b49-be3a-d3b48e71c99b@amd.com">
      <br>
      On 4/22/2026 4:00 PM, Felix Kuehling wrote:
      <br>
      <blockquote type="cite">
        <br>
        On 2026-04-22 11:53, Chen, Xiaogang wrote:
        <br>
        <blockquote type="cite">
          <br>
          On 4/21/2026 8:56 PM, Kuehling, Felix wrote:
          <br>
          <blockquote type="cite">
            <br>
            On 2026-04-21 11:00, Chen, Xiaogang wrote:
            <br>
            <blockquote type="cite">
              <br>
              On 4/20/2026 4:25 PM, Mario Limonciello wrote:
              <br>
              <blockquote type="cite">
                <br>
                <br>
                On 3/7/26 06:49, Mario Limonciello wrote:
                <br>
                <blockquote type="cite">
                  <br>
                  <br>
                  On 1/12/26 12:29 PM, Mario Limonciello wrote:
                  <br>
                  <blockquote type="cite">When a surprise unplug occurs
                    while a process has active KFD queues,
                    <br>
                    userspace never gets a chance to call
                    kfd_ioctl_destroy_queue() to
                    <br>
                    properly clean them up. This leads to a WARN_ON in
                    uninitialize()
                    <br>
                    complaining about active_queue_count or
                    processes_count being non-zero.
                    <br>
                    <br>
                  </blockquote>
                </blockquote>
              </blockquote>
              During hot-unplug driver sends SIGBUS signal to all
              processes who are using the unplugged device. It is
              expected that affected processes will clean their
              workloads when get this signal.
              <br>
              <br>
              When a device got removed physically all sources from it
              will be removed. It is unnecessary(in theory) to clean
              them up. I am not surprised to see some software warnings
              due to hardware got physically removed since it is
              unexpected behavior at run time.
              <br>
              <br>
              I think what we need worry about is if there is memory
              leak. Driver also waits when an affected device is idle(by
              kgd2kfd_check_device_idle(adev)) by checking/waiting if
              there is process still using it. If there is no process
              using the being removed device the processes should have
              been terminated by same process termination logic from
              driver.
              <br>
            </blockquote>
            <br>
            The problem is, that a lot of the process termination stuff
            happens in a worker thread. It can happen after the
            hot-unplug is already done. That would lead to the cleanup
            worker accessing pointers to device structures that are no
            longer there (or used by something else).
            <br>
            <br>
            We'd need to ensure proper synchronization so that the
            process cleanup completes before the device unplug frees the
            device structures.
            <br>
          </blockquote>
          <br>
          How about at kgd2kfd_device_exit before doing any device clean
          up check/waiting there is no any kfd process run on this
          device(kgd2kfd_check_device_idle)?
          <br>
        </blockquote>
        <br>
        Looks like this should already be happening in this call chain:
        amdgpu_device_ip_fini_early -&gt;
        amdgpu_amdkfd_teardown_processes -&gt;
        kgd2kfd_teardown_processes -&gt; kgd2kfd_check_device_idle
        <br>
        <br>
        Maybe whats missing at the end of&nbsp;kgd2kfd_teardown_processes is
        a flush_workqueue(kfd_process_wq) to make sure that all the
        cleanup work is done. After that, there should be no more
        process data structures referencing the device.
        <br>
        <br>
      </blockquote>
      We send signal SIGBUS to affected kfd processes(who are using the
      being removed device). The app signal handler will be executed
      asynchronously. There is a delay for signal handler got run. If
      call flush_workqueue immediately after sent the signal the
      kfd_process_ref_release(from kfd_release-&gt;kfd_unref_process)
      will not be got ran immediately after sent signal. Then
      flush_workqueue will not take effect since kfd_process_wq is empty
      or no filled work item yet.&nbsp;<br>
    </blockquote>
    <p>This loop at the end of kgd2kfd_teardown_processes waits until
      all processes using the GPU have terminated:</p>
    <pre>        /* wait all kfd processes use adev terminate */
        while (!kgd2kfd_check_device_idle(adev))
                cond_resched();
</pre>
    <p>After this time the processes are no longer in the
      kfd_processes_table. But their kfd_process_wq_release workers
      haven't necessarily run to completion yet.&nbsp;Adding a
      flush_workqueue after this should do the job.</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:59e14708-56db-4b49-be3a-d3b48e71c99b@amd.com"><br>
      Regards
      <br>
      <br>
      Xiaogang
      <br>
      <br>
      <br>
      <blockquote type="cite">Regards,
        <br>
        &nbsp; Felix
        <br>
        <br>
        <br>
        <blockquote type="cite">
          <br>
          Regards
          <br>
          <br>
          Xiaogang
          <br>
          <br>
          <blockquote type="cite">
            <br>
            Regards,
            <br>
            &nbsp; Felix
            <br>
            <br>
            <br>
            <br>
            <blockquote type="cite">
              <br>
              Regards
              <br>
              <br>
              Xiaogang
              <br>
              <br>
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">The issue is that during
                    surprise unplug:
                    <br>
                    1. amdgpu_device_fini_hw() checks
                    drm_dev_is_unplugged()
                    <br>
                    2. It calls amdgpu_amdkfd_device_fini_sw()
                    <br>
                    3. This leads to kfd_cleanup_nodes() -&gt;
                    device_queue_manager_uninit()
                    <br>
                    4. uninitialize() has:
                    WARN_ON(dqm-&gt;active_queue_count &gt; 0 ||
                    <br>
                    &nbsp;&nbsp;&nbsp; dqm-&gt;processes_count &gt; 0)
                    <br>
                    <br>
                    The warning triggers because the queues were never
                    destroyed - userspace
                    <br>
                    had no opportunity to clean them up before the
                    device disappeared.
                    <br>
                    <br>
                    Fix this by checking for device unplug in
                    kfd_cleanup_nodes() and
                    <br>
                    calling process_termination for each affected
                    process before
                    <br>
                    uninitializing the DQM. This mirrors what happens
                    during normal process
                    <br>
                    shutdown (kfd_process_notifier_release_internal),
                    ensuring queues are
                    <br>
                    properly cleaned up even during surprise removal.
                    <br>
                    <br>
                    Cc: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
                    <br>
                    Cc: Kent Russell <a class="moz-txt-link-rfc2396E" href="mailto:kent.russell@amd.com">&lt;kent.russell@amd.com&gt;</a>
                    <br>
                    Cc: <a class="moz-txt-link-abbreviated" href="mailto:Xiaogang.chen@amd.com">Xiaogang.chen@amd.com</a>
                    <br>
                    Signed-off-by: Mario Limonciello
                    <a class="moz-txt-link-rfc2396E" href="mailto:mario.limonciello@amd.com">&lt;mario.limonciello@amd.com&gt;</a>
                    <br>
                  </blockquote>
                  <br>
                  Ping?
                  <br>
                </blockquote>
                Ping?
                <br>
                <blockquote type="cite">
                  <br>
                  <blockquote type="cite">---
                    <br>
                    &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device.c | 32
                    ++++++++++++++++++++++++
                    <br>
                    &nbsp; 1 file changed, 32 insertions(+)
                    <br>
                    <br>
                    diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
                    b/drivers/gpu/ drm/amd/amdkfd/kfd_device.c
                    <br>
                    index e9cfb80bd436..7727b66e6afb 100644
                    <br>
                    --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
                    <br>
                    +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
                    <br>
                    @@ -664,6 +664,38 @@ static void
                    kfd_cleanup_nodes(struct kfd_dev *kfd, unsigned int
                    num_nodes)
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_workqueue(kfd-&gt;ih_wq);
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; destroy_workqueue(kfd-&gt;ih_wq);
                    <br>
                    +&nbsp;&nbsp;&nbsp; /*
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp; * For surprise unplugs with running processes,
                    we need to clean up
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp; * queues before uninitializing the DQM to
                    avoid WARN in uninitialize.
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp; * This handles the case where userspace can't
                    destroy queues normally.
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp; */
                    <br>
                    +&nbsp;&nbsp;&nbsp; if
                    (drm_dev_is_unplugged(adev_to_drm(kfd-&gt;adev))) {
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p;
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int temp;
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int idx;
                    <br>
                    +
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idx =
                    srcu_read_lock(&amp;kfd_processes_srcu);
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hash_for_each_rcu(kfd_processes_table,
                    temp, p, kfd_processes) {
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int j;
                    <br>
                    +
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j = 0; j &lt; p-&gt;n_pdds; j++) {
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd =
                    p-&gt;pdds[j];
                    <br>
                    +
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pdd-&gt;dev-&gt;kfd != kfd)
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
                    <br>
                    +
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(kfd_device,
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Terminating queues for
                    process %d on unplugged device\n&quot;,
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;lead_thread-&gt;pid);
                    <br>
                    +
                    <br>
                    +
                    pdd-&gt;dev-&gt;dqm-&gt;ops.process_termination(pdd-&gt;dev-&gt;dqm,
                    <br>
                    + &amp;pdd-&gt;qpd);
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;already_dequeued = true;
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; srcu_read_unlock(&amp;kfd_processes_srcu,
                    idx);
                    <br>
                    +&nbsp;&nbsp;&nbsp; }
                    <br>
                    +
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; num_nodes; i++) {
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; knode = kfd-&gt;nodes[i];
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    device_queue_manager_uninit(knode-&gt;dqm);
                    <br>
                  </blockquote>
                  <br>
                  <br>
                </blockquote>
                <br>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------9iJ061vf4UTBp9iGr2LgbUbu--
