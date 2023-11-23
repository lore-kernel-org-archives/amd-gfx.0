Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A53C61DF7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 23:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1940E10E36D;
	Thu, 23 Nov 2023 23:16:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06B4210E36D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 23:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y06YJXsuCgGg2VSe/xmrvauGsS7GOLDJeOnNt313xBJgaII7Byi/zbY/DPw6B65DTaCepk3VdQu+4Zg5YMZggdQzx7rGZ0i/awqucZv/aFEa+Ldff8pGGkd3c8HPc9JjmiGd+2JgaYEEsws70tWUvTiTOPTSbZVMRARZY5AjTF+rKzEuW5nzvu+g+4wUDDhCW6f5RrTMIB4mq8NOHFr2cVX3zuCFCUundmCa5YH3j8SKTeeZDabEsqcy1sAYVna9rcME1nT3l6NSQ9Fb6noMG3YYgx2X+eCwa4VrEoxYWDjB87+b120kAtDjvRYvVRt5gJpRdGX5J3B60NZUit+Qkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMMQci0Pw85MiY5aWwVDMbLs8R20/d4XInzIJPnqJHE=;
 b=FtEb3EIsAWyjTpLNIfhX1p+q0usQ5m+E6mlH++ZuJYpMb8zEAiCtQk+99ie+4c2Y0yUa99hUwtXwAFfTKGhs2Q5Vtds9mPMkK+5kMcpEQEAvh26Qc1WicpckJ86xGtjXD4M3eEWCPqxMMBZztHvwVn22ooTIxT4uWbC4G80rPZbL6d6zwajCjYuCB8QSnYMUdhOizCmuWZQWzfXheatmEoHU7G5LRvnEzjAx8j94D3kLeq9jUIbwoi20hX/bpcbxFHK6YirAr87nKyl7FaOXbESj0Xm0DTaZTWD2tWLcdMJ8haUJB4ds98vgzqVRQXsxTMfgH5QP6r5gTykrGaAVlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMMQci0Pw85MiY5aWwVDMbLs8R20/d4XInzIJPnqJHE=;
 b=2SNSHoPl+1XPSndKjLF9POzrjDvySlOntIrxfsztR04GvkP85m0s2joaWvLtyeVoc1BUWv7gqrJqGmgGDlIiaUZldFK0G/rF6Tw891zizyILYY4ugfrlmprqfAWBli6Bq6zaXnaUaZdr22TvaGgd1IgqfVSX5vdc5grLEUVqyxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 23:16:28 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 23:16:28 +0000
Message-ID: <9fa4eabe-9e20-4f43-918f-58a792ca7710@amd.com>
Date: Thu, 23 Nov 2023 18:16:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/24] drm/amdkfd: add queue remapping
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
 "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-22-James.Zhu@amd.com>
 <dc13740d-666d-4296-8f77-062c6f32374a@amd.com>
 <f24bb157-8c36-44a8-9ffb-128c21377500@amd.com>
 <5c8d90e1-11aa-49fe-9cc0-96e5123294a5@amd.com>
 <809c2a1b-fe75-4068-baa1-728508dd789b@amd.com>
 <MW3PR12MB44897FEB401745DC7E898971F9B9A@MW3PR12MB4489.namprd12.prod.outlook.com>
 <b319ba78-e4d6-4ef7-bf29-4fbddec9fd5a@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <b319ba78-e4d6-4ef7-bf29-4fbddec9fd5a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0235.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::19) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 83dd159b-709f-4daa-ce85-08dbec7a3860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hxmdMKy9TwYf5qP/qBasJ65+zvYwg0kErYOyZwsSFpVQrHUFTbAqoU0Fs3BuvMeCk2cxp91EZz++J8sMsG26UxVdTmnQXfnOPud238cVGBUBWydD6Dtu418VWiceSRQZhSguNlQPtjF/DqdaioTizGpGYqt1KRz3+nrpMyVdw5IsTmMCduHI8DjxsIkg+nJ/eNT3azxLvLMpKxWg7VxXiQ3gPfv2dQkPuSZJcQjRaRm1uT2a5mvpmCntyCogsFvZLgeSZpq0ztnYeCTCo34Tfu2ddkoy7Vviqg2bwJcD6Xx7NiBn+K6SKrGPi72wY+RcZBYx4Di0TESPvGvms+3f63HX/ylM/pH8YrR+rKvCK2B8UwtHUHV5W/683S9coWLBxXFWpH3fdQtNhs+xWQR/hy+rirqr/RAU3cVh6VHZBFnxVSVMaEVJlKWml5hUNDCv5OzZkKTZHXP0jvrkbUZgjpCM1EAylgOk/nX/blVCg7YunLURKxAnw+jsvn1JrBHyctV/sGbVNHdDk3J3ZpS0FOjaxeJsI0jt+st4tSmD2g383ml9OrwT5TSqXKX6UGbRNN+P2DuYajtSuOtz9ZfOn8d79To5YvN9BqP1+HSi9ZDQ44PmVtcdwbo2phPOlehApX1SR6dKksxC6MwnZu9t8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66899024)(83380400001)(38100700002)(31696002)(36756003)(66556008)(316002)(66946007)(66476007)(8936002)(41300700001)(8676002)(4326008)(110136005)(5660300002)(4001150100001)(2906002)(31686004)(36916002)(53546011)(6512007)(26005)(2616005)(478600001)(6666004)(6486002)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amsyS0lJQWFLS3pXZDc2TFFUOW5yNWVGSWxHUHR5VUpGU2Q4NG1EeHc3RVJF?=
 =?utf-8?B?UlI4YXAzMytMQzBmSExTakZ2Q2FjeXFmd2h4bHlKWkFoYW16Mjdnd09KSmN1?=
 =?utf-8?B?QU9iaTJkOHlJZzZkdlU5Uis5R0Z0WWxPVmo5Z05Temh4U3JLVWhsYkYxTERt?=
 =?utf-8?B?RGg0Q01JY3lWdmllWEJla0hkemxuVlh3bGd5QVl4VVcwdjViRFl3OHNPZ3Qy?=
 =?utf-8?B?M1lOdWdCa3hUcll1Y3FldzI2S21EOUNJZmxHNEdBSHpQaE82YVZkNU92aEZp?=
 =?utf-8?B?T2tuclZPU3Q0bHAybWs5eW41Unh0eG1lajV0emNCcnpPMjZMNExNb3Rtck5W?=
 =?utf-8?B?ZjNEbWwzMnZHV1RzZm9DTk1aK0Q3WE4xZ05tRmVJTmZXb2VNUWgxUStvM3BQ?=
 =?utf-8?B?SFdYZE5PTEtiWHYxaGJ5MzRweHMvU1lwM1hiOE43QlFYTEZ0K3B0US93Rksv?=
 =?utf-8?B?UERhQ3JCTjN2MGRXRnVxblBraWJPUW5SSDlZOVoyT1hwM0dLRlk3ejZrTGZq?=
 =?utf-8?B?ZDJCOTlOQUN4bGl2elZPb2VrNlFHdlZKRmsvQ1dPcXc5Q1FMdUpQbDlVanNJ?=
 =?utf-8?B?dDhzM05DUk1pVHhleHZ0a20ybWZ4Z2JDeGI4MGtVb3p0Q1BmNUZJZEgvUDEr?=
 =?utf-8?B?UHEvUDYwNlVOV1N0N2Zhai8ra3VvS09FN0ZuUlB1RWE3M3cyeGVoN09HM21G?=
 =?utf-8?B?bzUrWkExbkwwaE5YV0I1VW9EanhRWVdNNnpSaTZCRjdNNndEVGk5NXRPWTNV?=
 =?utf-8?B?eXkramlPV0NSbklvRU9rdkVqcHNTcU1mQUdzWmIxNW56Ync2bU0xY3JHNzda?=
 =?utf-8?B?K0F3R3FDeTFyUEpZTExCKy9qV1NXWmtSZEVLZklUMDd1MUk1aFcvSWh0MkQ5?=
 =?utf-8?B?WVBuM0EvVHVIZXhUNU45Y2FWRk0yZk02eC9QdXNkNmtDbm9JNEZJbWNCQ3c2?=
 =?utf-8?B?ekFYVkxUcGxYV2xIdVg3SHlSV0xoaDhYb2RpV2NhUnJnakRnVzR1SVA3VUpX?=
 =?utf-8?B?bzZldkJVQ2NpMnJPZVozNHM4UnFmeEw0d1FZNVpjTHVoQ0xyS3MwSWtpY0ZM?=
 =?utf-8?B?dzlGalZqS3ZCTWo2djJjUHZUUVNrMEx3Rmh6YkZYbEwwT2hyUytCTTF3QWxj?=
 =?utf-8?B?eXdoTTMzYldBa1ZXYU1qVnVTTHBsQytrVFlFMlh1Q2xtZGZPZUJmdDd1MVJw?=
 =?utf-8?B?ejdpQmRhaGFORHA2SzAzSlBFMzcxRmRCR0g5aE8wOHdzVUthN1hMT0VRNUhx?=
 =?utf-8?B?WXdHK2IycS9Nb2wzODZxbEFXbnFjay8wVEFxVDMvU0x6am16dXFiUjJuaG1X?=
 =?utf-8?B?V1UyUURpK0l1b3IwcERrV1lHeTF0VkxLSkh6QVN6K3ZaR3NNMEVtdkVpT1lZ?=
 =?utf-8?B?RW9sRzdOSDVDM01yOVlrVU9YalBYdXN0c3BLeHdzSDI0Mzl2WEdhWlhxcTRs?=
 =?utf-8?B?ZlpBS2lnWXFXRXBRMzRKS2dhcnNHeDYwTEJVVE1SeEVwbFQ4ZVNXQXBWZkpT?=
 =?utf-8?B?WHZiUDk1eFdZZCtUUklPRmtYUXdBcTF3TEs2V0RacnJCa2VYVmxBVEhuYmVP?=
 =?utf-8?B?SHRwdHl4eGd6YmhoS1djZjJPVVBJN25zLzRqL3V6NkxmZ1dlRW1ZMWoya0FJ?=
 =?utf-8?B?alF0Q2REYVdnUUJZT3kzOEFmZkorUlFpUU1HT2VwWmF0b2NNS0R0b2RPU0U5?=
 =?utf-8?B?N3pQVzRMMXlka0VCL0d4RlpEOEpGUXE2L2ZkMTVaa0ZlcDRpMlFkTFJ1WTQv?=
 =?utf-8?B?VTFubndZanZ2bjZQenlxaFlSTHlkVXRmbjEwc0FIb3ZPTmdNUHYwOTNzamdU?=
 =?utf-8?B?UjkwbThZZzZ4QzQra2x4NlNTbi9kVm40RVFXeFFxVENWSzlVMFE5dFhrbzB3?=
 =?utf-8?B?YVJiUWFGa3FtS3VSR3cwZjhnK3hWWkhZRDRKaG9aKzZFZ0Z1TFNuT1Z0bmVX?=
 =?utf-8?B?QzFIVVlqMGExNTVlQkZmbjg1REJCZHJrYkM2QUFlZFY5SGFxUGlmM0FoY1N5?=
 =?utf-8?B?MDB4bGJrWlAvVXlDS0x6TDRiaThlWkRxME00a204dG13L25BMmlpWjFEMm0w?=
 =?utf-8?B?YVBYRUlaNGtqbEppbTZscWlyZWNYdno1eE9UQitTdGc2UnRnRFBvOCthYUJq?=
 =?utf-8?Q?+zZpCrb/sIEpmQpLqFBSpS26j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83dd159b-709f-4daa-ce85-08dbec7a3860
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 23:16:28.1414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vS5QeUIM50zptJetht/wABKYM/fyoU9eWho06QEzMPI4naY7kE/VgkWbeQ45y9qr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524
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


On 2023-11-23 18:01, Felix Kuehling wrote:
> On 2023-11-23 17:41, Greathouse, Joseph wrote:
>> [Public]
>>
>>> -----Original Message-----
>>> From: Zhu, James <James.Zhu@amd.com>
>>> Sent: Thursday, November 23, 2023 1:49 PM
>>>
>>> On 2023-11-23 14:02, Felix Kuehling wrote:
>>>> On 2023-11-23 11:25, James Zhu wrote:
>>>>> On 2023-11-22 17:35, Felix Kuehling wrote:
>>>>>> On 2023-11-03 09:11, James Zhu wrote:
>>>>>>> Add queue remapping to force the waves in any running
>>>>>>> processes to complete a CWSR trap.
>>>>>> Please add an explanation why this is needed.
>>>>> [JZ] Even though the profiling-enabled bits is turned off, the CWSR
>>>>> trap handlers for some kernels with this process may still in running
>>>>> stage, this will
>>>>>
>>>>> force the waves in any running processes to complete a CWSR trap, and
>>>>> make sure pc sampling is completely stopped with this process.   I
>>>>> will add it later.
>>>> It may be confusing to talk specifically about "CWSR trap handler".
>>>> There is only one trap handler that is triggered by different events:
>>>> CWSR, host trap, s_trap instructions, exceptions, etc. When a new trap
>>>> triggers, it serializes with any currently running trap handler in
>>>> that wavefront. So it seems that you're using CWSR as a way to ensure
>>>> that any host trap has completed: CWSR will wait for previous traps to
>>>> finish before trapping again for CWSR, the HWS firmware waits for CWSR
>>>> completion and the driver waits for HWS to finish CWSR with a fence on
>>>> a HIQ QUERY_STATUS packet. Is that correct?
>>> [JZ] I think your explanation is more detail. Need Joseph to confirm.
>> Felix, your summary is correct. The reason we are trying to perform a 
>> queue unmap/map cycle as part of the PC sampling stop is to prevent 
>> the following:
>>
>> 1. A PC sampling request arrives to Wave X, sending it to 1st-level 
>> trap handler
>> 2. User thread asks KFD to stop sampling for this process, which 
>> leads to kfd_pc_sample_stop()
>> 3. kfd_pc_sample_stop() decrements the sampling refcent. If this is 
>> the last process to stop sampling, it stops any further sampling 
>> traps from being generated
>> 4. kfd_pc_sample_stop() sets this process's TMA flag to false so 
>> waves in the 1st-level trap handler know sampling is disabled
>>      4.1. Wave X may be in 1st-level handler and not yet checked the 
>> TMA flag. If so, it will exit the 1st-level handler when it sees flag 
>> is false
>>      4.2. Wave X may have already passed the 1st-level TMA flag check 
>> and entered the 2nd-level trap handler to do the PC sample
>> 5. kfd_pc_sample_stop() returns, eventually causing ioctl to return, 
>> back to user-space
>> 6. Because the stop ioctl has returned, user-land deallocates 
>> user-space buffer the 2nd level trap handler uses to output sample data
>> 7. Wave X that was in the 2nd-level handler tries to finish its 
>> sample output and writes to the now-freed location, causing a 
>> use-after-free
>>
>> Note that Step 3 does not always stop further traps from arriving -- 
>> if another process still wants to do sampling, the driver or HW might 
>> still send traps to every wave on the device after Step 3.
>> As such, to avoid going into the 2nd-level handler for non-sampled 
>> processes, all 1st-level handlers must check their TMA flag to see if 
>> they should allow the sample to flow to the 2nd-level handler.
>>
>> By removing the queue from the HW after Step 4, we can be sure that 
>> any existing waves from this process that entered the PC sampling 
>> 2nd-level handler before Step 4 are done.
>> Any waves that were still in the 1st-level handler at Step 4.1 will 
>> be filtered by the TMA flag being set to false. CWSR will wait until 
>> they exit.
>> Any waves that were already in the 2nd-level handler (4.2) must 
>> complete before the CWSR save will complete and allow this queue 
>> removal request to complete.
>> Any waves that enter the 1st-level trap handler after Step 4 won't go 
>> into the PC sampling logic in the 2nd-level handler because the TMA 
>> flag is set to false. CWSR will wait until they exit.
>>
>> When we then put the queue back on the hardware, any further traps 
>> that might show up (e.g. because another process is sampling) will 
>> get filtered by the TMA flag.
>>
>> So once the queue removal (and thus CWSR save cycle) has completed, 
>> we can be sure that no other traps to this process will try to use 
>> its PC sample data buffer, so it's safe to return to user-space and 
>> let them potentially free that buffer.
>>
>> I don't know how to summarize this nicely in a comment, but hopefully 
>> y'all can figure that out. :)
>
> My best summary: We need to ensure that any waves executing the PC 
> sampling part of the trap handler are done before kfd_pc_sample_stop 
> returns, and that no new waves enter that part of the trap handler 
> afterwards. This avoids race conditions that could lead to 
> use-after-free. Unmapping and remapping the queues either waits for 
> the waves to drain, or preempts them with CWSR, which itself executes 
> a trap and waits for previous traps to finish.

> [JZ]  Thanks all!

> Regards,
>   Felix
>
>
>>
>> Thanks,
>> -Joe
>>
>>>> Regards,
>>>>    Felix
>>>>
>>>>
>>>>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>>>>> ---
>>>>>>> drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11
>>>>>>> +++++++++++
>>>>>>> drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h |  5 +++++
>>>>>>> drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c |  3 +++
>>>>>>>    3 files changed, 19 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>>>> index c0e71543389a..a3f57be63f4f 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>>>> @@ -3155,6 +3155,17 @@ int debug_refresh_runlist(struct
>>>>>>> device_queue_manager *dqm)
>>>>>>>        return debug_map_and_unlock(dqm);
>>>>>>>    }
>>>>>>>    +void remap_queue(struct device_queue_manager *dqm,
>>>>>>> +                enum kfd_unmap_queues_filter filter,
>>>>>>> +                uint32_t filter_param,
>>>>>>> +                uint32_t grace_period)
>>>>>> Not sure if you need the filter and grace period parameters in this
>>>>>> function. What's the point of exposing that to callers who just want
>>>>>> to trigger a CWSR? You could also change the function name to
>>>>>> reflect the purpose of the function, rather than the implementation.
>>>>> [JZ] Just want to create a general function in case that used by
>>>>> others. I am fine to remove passing filter_param/grace_period
>>>>>> Regards,
>>>>>>    Felix
>>>>>>
>>>>>>
>>>>>>> +{
>>>>>>> +    dqm_lock(dqm);
>>>>>>> +    if (!dqm->dev->kfd->shared_resources.enable_mes)
>>>>>>> +        execute_queues_cpsch(dqm, filter, filter_param,
>>>>>>> grace_period);
>>>>>>> +    dqm_unlock(dqm);
>>>>>>> +}
>>>>>>> +
>>>>>>>    #if defined(CONFIG_DEBUG_FS)
>>>>>>>      static void seq_reg_dump(struct seq_file *m,
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>>>>>> index cf7e182588f8..f8aae3747a36 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>>>>>> @@ -303,6 +303,11 @@ int debug_lock_and_unmap(struct
>>>>>>> device_queue_manager *dqm);
>>>>>>>    int debug_map_and_unlock(struct device_queue_manager *dqm);
>>>>>>>    int debug_refresh_runlist(struct device_queue_manager *dqm);
>>>>>>>    +void remap_queue(struct device_queue_manager *dqm,
>>>>>>> +                enum kfd_unmap_queues_filter filter,
>>>>>>> +                uint32_t filter_param,
>>>>>>> +                uint32_t grace_period);
>>>>>>> +
>>>>>>>    static inline unsigned int get_sh_mem_bases_32(struct
>>>>>>> kfd_process_device *pdd)
>>>>>>>    {
>>>>>>>        return (pdd->lds_base >> 16) & 0xFF;
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>>>>> index e8f0559b618e..66670cdb813a 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>>>>> @@ -24,6 +24,7 @@
>>>>>>>    #include "kfd_priv.h"
>>>>>>>    #include "amdgpu_amdkfd.h"
>>>>>>>    #include "kfd_pc_sampling.h"
>>>>>>> +#include "kfd_device_queue_manager.h"
>>>>>>>      struct supported_pc_sample_info {
>>>>>>>        uint32_t ip_version;
>>>>>>> @@ -164,6 +165,8 @@ static int kfd_pc_sample_stop(struct
>>>>>>> kfd_process_device *pdd,
>>>>>>> cancel_work_sync(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_work); 
>>>>>>>
>>>>>>>
>>>>>>> kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
>>>>>>> pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, 
>>>>>>> false);
>>>>>>> +        remap_queue(pdd->dev->dqm,
>>>>>>> +            KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
>>>>>>> USE_DEFAULT_GRACE_PERIOD);
>>>>>>> mutex_lock(&pdd->dev->pcs_data.mutex);
>>>>>>> pdd->dev->pcs_data.hosttrap_entry.base.target_simd = 0;
