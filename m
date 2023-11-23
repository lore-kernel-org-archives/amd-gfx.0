Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E944C61DF7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 23:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 561C910E366;
	Thu, 23 Nov 2023 23:01:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D151C10E366
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 23:01:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCj52WXZbQ3FS9vXt95hVlsG+veCmvwPQvo6TKUtGbq4qek3Xukvr/PxIPAFZ0haxjZdqYzi71pV8zXxxt0uC+C4R8Io5qDT3arWm/VGVCRPBHGDcLyJ1DTaVflEzWpfBNrqmxzf1NNmldF8z8Ck77QDolZ9mHQFe/xJ6kYvdS70mJl+D2g6/6BPoSZW9hlsqB/QZm8zTKB5QjxGmHuRGs4soFjEQD4efC3rgfVkN+2dsOED8RDg2+j6i1tMManPQ9pwJyGqg9xybiE5GGkuTOsKngm/h0WB5wTFFV2qwCkQNh9oqObev34LbOh3tScfQ03Q0Iqv4v5Ep4u2cjM43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OP9apsN4i6hs0gbGyUotAlWZmJZeGtkEuHDdNAj0p5c=;
 b=UDduRGLARbNygNQMu2BnJAIudOB9rYZnjxy3vgdeVQ9nV6xVs43BHoTEIeqLneUt32AIzI3Gm4Jiy6jR5H5xDYY1pXyZWpovOT9rjRqKHnqMMqyvMRJIVz2c30HcWZCUAyaY4J238tL3nh0ExaXSlEFIHPMGWh8qkjuI/iWZ3G7WIoJyyqYyBjTlbF9JuS52hMAz+BPQYiy7tVqiDZTtiuAQOEBHHWhASORlhgZx2pmtXZe3T5CZly6X2a3PboYuaUQuDM7qs0UNZwR7gN4StAkUqbSUCxAcSvJbwaBMSiYRFyBil0uqUxY9+PajJDQROeroFuMLnp/ALOlvE7Lbeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OP9apsN4i6hs0gbGyUotAlWZmJZeGtkEuHDdNAj0p5c=;
 b=wwzOy41EZrYDYEmvGR2SxqYlgSRhv6yQtEM4nPG2pj7IIVE+GSkScshvLI4/PbLd4qkKKuSYn0ZEiPKwHysFVFjaALAu+/oSEom+EMBduQy++xKOR7up/PL5aVFiGEcriSdL+TfLt50dFe4j/3zQ/nPL+RBB3jFYYAZxm3lrMWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 23:01:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 23:01:47 +0000
Message-ID: <b319ba78-e4d6-4ef7-bf29-4fbddec9fd5a@amd.com>
Date: Thu, 23 Nov 2023 18:01:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/24] drm/amdkfd: add queue remapping
Content-Language: en-US
To: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
 "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-22-James.Zhu@amd.com>
 <dc13740d-666d-4296-8f77-062c6f32374a@amd.com>
 <f24bb157-8c36-44a8-9ffb-128c21377500@amd.com>
 <5c8d90e1-11aa-49fe-9cc0-96e5123294a5@amd.com>
 <809c2a1b-fe75-4068-baa1-728508dd789b@amd.com>
 <MW3PR12MB44897FEB401745DC7E898971F9B9A@MW3PR12MB4489.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <MW3PR12MB44897FEB401745DC7E898971F9B9A@MW3PR12MB4489.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0328.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad92db3-0821-453d-2d64-08dbec782b06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pnbl2fX8ZcK87/ZU1wdfIsY1iNvzk1EmWkc/M6O2gZi/G+M5LtpN6AVnOLfAIcTqkvWj0Skq5mhuIU0TmNYEmoHgLUr01EIDCOeQ6JeX/nfqIWEBNKlEadlRcejPUxp2FNF8gVmbKIQXuqqDDGduNOchg4tsCdMdArlHf0BjycdBXJye326M1/dG5j8t9N9/cUyJ+uPURXEz7jQIVffUZGOe1ITpGzJMSTg36wxWs71+a3Aah8UKKF/9+YS5tX3ALcCQRizi7f1GAVvFsrtOJlm3qlpGZgMuSi1gUgvklIQxoXXZkk3TIln0qkJdenrPoOW94hE0Ie7rMSMcM40a5DgOo3Xq4kt656IGkQ/wj8yoZ4dtxNu5T1vVkc6ag8WQ1QHRcflkXYRhdkrkVaQxw/nCnaM/gAfouGN9/NiqFM4JyFBA8G98nV5iPN2PshV35w8Tzio1+u9Jvev3CVBZ6bERPCRohGgOEJgYHp17gRKNZy1YnM27NKydahfeJaUcPLaTwAdsL3eer/Ut/PVVthfHNyokzjSOhftJ8ufLCCTcW+3mZBzUzDtMYTca4Wjq9ExZq+FqF06Y1kKKQpKH+de6IdCGOgUHH87Met0Zk3I/VsH0FUAMt8lNqh4iyenpN3fH6Kq9kHnjKLHm+qnk6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(31686004)(2906002)(4001150100001)(44832011)(41300700001)(8676002)(8936002)(4326008)(5660300002)(66899024)(316002)(6512007)(66556008)(66476007)(110136005)(86362001)(6486002)(2616005)(83380400001)(478600001)(36756003)(66946007)(53546011)(36916002)(6506007)(26005)(38100700002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzVvTTJ6ZGs3SG9LWE5XMXVIM0dhWG9zUHdvVFdML2NtNC9JSnc1NDc5bnIr?=
 =?utf-8?B?ZUg4MlJhTXhIYk5TNFlHUmRNeUZaN0ZIdGhkZ1N3R29oTEtVU3BKZTJjM09Y?=
 =?utf-8?B?bk9LTWFCam1QaytnR2JWV1U4QkJORjY3akc2NzMydVpJZVZBVXRPTUI5dkFN?=
 =?utf-8?B?QWI5NHR0OGczNjFPa09oV3h3ZHdHdGljZGYvRVZZQngyaWFobEVhckp5Uk52?=
 =?utf-8?B?QlFvdGZ4T3JHSENjeVJoVGd4dnNpNGtiTnJDVmUyU3VuRXgrNzFBUUdMc3Va?=
 =?utf-8?B?L05KQStBcThWemp0UGlxR01HQnFyUUFGSzRmNzdCVVVKcHEzZ04yVUo0VVJm?=
 =?utf-8?B?NU1wcklZekpCYzhRK1Z4d2hJbTR4VVdaNUY0aDdmRk1RMUJxSHNmRzFTRUlW?=
 =?utf-8?B?MFpQSGdESzBvSXdVM0lWU2grYVFsMmg0WkxYdEVGNmx1M2h1Und5R0t1M2FM?=
 =?utf-8?B?cVlPOFlyRGtKenFiRFlmdXYrdjd0ejVuVFc5Mkd0Rzg0Ym5WTC96UEZiM2Zv?=
 =?utf-8?B?Tk5icFVOZ1YvRXdaYjJSSkhkaWJ0TG1XNzAzSnNVN2orZElDc2VkWlhRUjhP?=
 =?utf-8?B?WDNVS25HcG9xSmhmcmNsdzVWTUFVZmllM2dFdVFhTkFxNnJGMXVTSHFtaERo?=
 =?utf-8?B?Z1hrNXFNSjBLT3hwQkloNGhNWXJRcE1GTzBrbXVDQzkxRTRCQVRxaUFuT1Vw?=
 =?utf-8?B?RStZcXljaG94T3d3TVVmNDJuUDc1Wng2bHUwM3FyeEx0Y0dnQ2QwQzZ5cTEw?=
 =?utf-8?B?YmYwWlE0SjVhOUNOQ2JXejkzUWxObk1ZMVdJaUZXc2pMbll5SHRYT2FpVWZP?=
 =?utf-8?B?Y1JYTHN1WDBDUmF6ay9QRVFyMUk1TUtObU54c01XTm5JZGRsVGorQTRlOEwz?=
 =?utf-8?B?QzhVaGd2eWcrM2E1UGRVY3R3T3JOUEpMcVZQL05xSzRZT1F6aGRDOG80Vnhh?=
 =?utf-8?B?ZFRVVmRWZUs3NFVuUUc3bXNTVFltYS83S0xyeUw1NkZwUEFpUjIyYVJ1QVQv?=
 =?utf-8?B?WnhMV1V0QjdRbDJtbExDT2o2b0hPZVFpNmljdXpFS1lYVzM4YUZmbzNYMXpH?=
 =?utf-8?B?UmlGUVk5Zy91bzV6WHdZUDdRY3Y4bWNzcDlpRzJKWXFrTllCQVJnZEx1NG9a?=
 =?utf-8?B?dGxVS1pZbXlYbmZ3b2N5MlpPSUNjald2MWM2QlZ0clM4ZTMwcS9CWEtJd2Z5?=
 =?utf-8?B?NHF5d2N1NWpPWEZyYldrcDB5NklzanlFRkcyZ3RhSG9aczNOSlMyTDg2OSs2?=
 =?utf-8?B?RXE0amw3a3E4MWtpbFc2NEtmYUtKODJ1bWlqMEs3ZnR2dndtd2hUckNObDJo?=
 =?utf-8?B?OW83S2hrYkllSWJVNlcrOG5pakFSdnVhcUFZUk1kSDVjdUFrWGE5UmpXUUhh?=
 =?utf-8?B?UUtzSnNFYnNYVUFCMzF3RmpQSzFIZ3FXYys0cEVSQXRJajUrUmtrdTQycHdN?=
 =?utf-8?B?QmtOTnNMVFdkUFBmTTNHVlRsR1pkS1dya0FjbFc2eVQ0dW1Cb0ttbTlwQUxj?=
 =?utf-8?B?M3IrMG9hTXgyYVJIbkxqaWM1R0J4aUFhMnFISGhGRSs1M09vZmRWMXc2QkJM?=
 =?utf-8?B?OVVpZHJ2SDdyQjFPSERmNEgzQzBscXNpdTE0c1o3a1JmRVkwSXZDb3FmM2l3?=
 =?utf-8?B?dFRhZERUbzVnRThtRU1nOGdLR1l2bWdNOFVwamNyLzh4ZlU1Y2dpbTB3UWVT?=
 =?utf-8?B?YVB6dDc2anhQRlNWTDRkT0JLVWZ4SnV2bUFQVmJEaExSUVQrdWVQUEx4blFj?=
 =?utf-8?B?b3dtOWpYeWN0QlJhSzZEelQ3NnA4b3VoK2dmREFaSEFvdUhXN1h0b290SFo4?=
 =?utf-8?B?c0hoMlgvc0QxQ3UzcitiVS9lWm51d1dvb3p2Q2FkNjVKNWRweWNKMUJHK1RJ?=
 =?utf-8?B?b2RXSXBQNTFEMXNjWTd6VXE1ODZFMkxZa0JQZExRakppb1lOQ1dUd3pjZWVs?=
 =?utf-8?B?ZWNQNy82WHNoa1pHSFB1bmkwZVlHTGdoTGJGYlRRODdsOGk2UEpnL1ZyeXZv?=
 =?utf-8?B?Rm5aM2E4UExMUTJ0eUFPd3dDcGYvK3ZjcEpKdXFLYWlBb2Nna0VtaHBkMk14?=
 =?utf-8?B?dWZhS0JlQVI2VTZyWUVLNXRuKzJrM0hia0dtRmNNbit5WWNkb21aSDlqVllq?=
 =?utf-8?Q?tq9tAp24Ntvsmucv6/NZpLCSw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad92db3-0821-453d-2d64-08dbec782b06
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 23:01:46.6512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGrZFmuLSh7kQDIYS3+Y8LXzGUpk4UEDwuh6IVYKRs7acwWQNb2hH3zWAnCgC8a47tS6y/lBM+rvISvhZ9jmfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395
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

On 2023-11-23 17:41, Greathouse, Joseph wrote:
> [Public]
>
>> -----Original Message-----
>> From: Zhu, James <James.Zhu@amd.com>
>> Sent: Thursday, November 23, 2023 1:49 PM
>>
>> On 2023-11-23 14:02, Felix Kuehling wrote:
>>> On 2023-11-23 11:25, James Zhu wrote:
>>>> On 2023-11-22 17:35, Felix Kuehling wrote:
>>>>> On 2023-11-03 09:11, James Zhu wrote:
>>>>>> Add queue remapping to force the waves in any running
>>>>>> processes to complete a CWSR trap.
>>>>> Please add an explanation why this is needed.
>>>> [JZ] Even though the profiling-enabled bits is turned off, the CWSR
>>>> trap handlers for some kernels with this process may still in running
>>>> stage, this will
>>>>
>>>> force the waves in any running processes to complete a CWSR trap, and
>>>> make sure pc sampling is completely stopped with this process.   I
>>>> will add it later.
>>> It may be confusing to talk specifically about "CWSR trap handler".
>>> There is only one trap handler that is triggered by different events:
>>> CWSR, host trap, s_trap instructions, exceptions, etc. When a new trap
>>> triggers, it serializes with any currently running trap handler in
>>> that wavefront. So it seems that you're using CWSR as a way to ensure
>>> that any host trap has completed: CWSR will wait for previous traps to
>>> finish before trapping again for CWSR, the HWS firmware waits for CWSR
>>> completion and the driver waits for HWS to finish CWSR with a fence on
>>> a HIQ QUERY_STATUS packet. Is that correct?
>> [JZ] I think your explanation is more detail. Need Joseph to confirm.
> Felix, your summary is correct. The reason we are trying to perform a queue unmap/map cycle as part of the PC sampling stop is to prevent the following:
>
> 1. A PC sampling request arrives to Wave X, sending it to 1st-level trap handler
> 2. User thread asks KFD to stop sampling for this process, which leads to kfd_pc_sample_stop()
> 3. kfd_pc_sample_stop() decrements the sampling refcent. If this is the last process to stop sampling, it stops any further sampling traps from being generated
> 4. kfd_pc_sample_stop() sets this process's TMA flag to false so waves in the 1st-level trap handler know sampling is disabled
>      4.1. Wave X may be in 1st-level handler and not yet checked the TMA flag. If so, it will exit the 1st-level handler when it sees flag is false
>      4.2. Wave X may have already passed the 1st-level TMA flag check and entered the 2nd-level trap handler to do the PC sample
> 5. kfd_pc_sample_stop() returns, eventually causing ioctl to return, back to user-space
> 6. Because the stop ioctl has returned, user-land deallocates user-space buffer the 2nd level trap handler uses to output sample data
> 7. Wave X that was in the 2nd-level handler tries to finish its sample output and writes to the now-freed location, causing a use-after-free
>
> Note that Step 3 does not always stop further traps from arriving -- if another process still wants to do sampling, the driver or HW might still send traps to every wave on the device after Step 3.
> As such, to avoid going into the 2nd-level handler for non-sampled processes, all 1st-level handlers must check their TMA flag to see if they should allow the sample to flow to the 2nd-level handler.
>
> By removing the queue from the HW after Step 4, we can be sure that any existing waves from this process that entered the PC sampling 2nd-level handler before Step 4 are done.
> Any waves that were still in the 1st-level handler at Step 4.1 will be filtered by the TMA flag being set to false. CWSR will wait until they exit.
> Any waves that were already in the 2nd-level handler (4.2) must complete before the CWSR save will complete and allow this queue removal request to complete.
> Any waves that enter the 1st-level trap handler after Step 4 won't go into the PC sampling logic in the 2nd-level handler because the TMA flag is set to false. CWSR will wait until they exit.
>
> When we then put the queue back on the hardware, any further traps that might show up (e.g. because another process is sampling) will get filtered by the TMA flag.
>
> So once the queue removal (and thus CWSR save cycle) has completed, we can be sure that no other traps to this process will try to use its PC sample data buffer, so it's safe to return to user-space and let them potentially free that buffer.
>
> I don't know how to summarize this nicely in a comment, but hopefully y'all can figure that out. :)

My best summary: We need to ensure that any waves executing the PC 
sampling part of the trap handler are done before kfd_pc_sample_stop 
returns, and that no new waves enter that part of the trap handler 
afterwards. This avoids race conditions that could lead to 
use-after-free. Unmapping and remapping the queues either waits for the 
waves to drain, or preempts them with CWSR, which itself executes a trap 
and waits for previous traps to finish.

Regards,
   Felix


>
> Thanks,
> -Joe
>
>>> Regards,
>>>    Felix
>>>
>>>
>>>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11
>>>>>> +++++++++++
>>>>>>    drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h |  5 +++++
>>>>>>    drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c          |  3 +++
>>>>>>    3 files changed, 19 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>>> index c0e71543389a..a3f57be63f4f 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>>> @@ -3155,6 +3155,17 @@ int debug_refresh_runlist(struct
>>>>>> device_queue_manager *dqm)
>>>>>>        return debug_map_and_unlock(dqm);
>>>>>>    }
>>>>>>    +void remap_queue(struct device_queue_manager *dqm,
>>>>>> +                enum kfd_unmap_queues_filter filter,
>>>>>> +                uint32_t filter_param,
>>>>>> +                uint32_t grace_period)
>>>>> Not sure if you need the filter and grace period parameters in this
>>>>> function. What's the point of exposing that to callers who just want
>>>>> to trigger a CWSR? You could also change the function name to
>>>>> reflect the purpose of the function, rather than the implementation.
>>>> [JZ] Just want to create a general function in case that used by
>>>> others. I am fine to remove passing filter_param/grace_period
>>>>> Regards,
>>>>>    Felix
>>>>>
>>>>>
>>>>>> +{
>>>>>> +    dqm_lock(dqm);
>>>>>> +    if (!dqm->dev->kfd->shared_resources.enable_mes)
>>>>>> +        execute_queues_cpsch(dqm, filter, filter_param,
>>>>>> grace_period);
>>>>>> +    dqm_unlock(dqm);
>>>>>> +}
>>>>>> +
>>>>>>    #if defined(CONFIG_DEBUG_FS)
>>>>>>      static void seq_reg_dump(struct seq_file *m,
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>>>>> index cf7e182588f8..f8aae3747a36 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>>>>> @@ -303,6 +303,11 @@ int debug_lock_and_unmap(struct
>>>>>> device_queue_manager *dqm);
>>>>>>    int debug_map_and_unlock(struct device_queue_manager *dqm);
>>>>>>    int debug_refresh_runlist(struct device_queue_manager *dqm);
>>>>>>    +void remap_queue(struct device_queue_manager *dqm,
>>>>>> +                enum kfd_unmap_queues_filter filter,
>>>>>> +                uint32_t filter_param,
>>>>>> +                uint32_t grace_period);
>>>>>> +
>>>>>>    static inline unsigned int get_sh_mem_bases_32(struct
>>>>>> kfd_process_device *pdd)
>>>>>>    {
>>>>>>        return (pdd->lds_base >> 16) & 0xFF;
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>>>> index e8f0559b618e..66670cdb813a 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>>>> @@ -24,6 +24,7 @@
>>>>>>    #include "kfd_priv.h"
>>>>>>    #include "amdgpu_amdkfd.h"
>>>>>>    #include "kfd_pc_sampling.h"
>>>>>> +#include "kfd_device_queue_manager.h"
>>>>>>      struct supported_pc_sample_info {
>>>>>>        uint32_t ip_version;
>>>>>> @@ -164,6 +165,8 @@ static int kfd_pc_sample_stop(struct
>>>>>> kfd_process_device *pdd,
>>>>>> cancel_work_sync(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_work);
>>>>>>
>>>>>> kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
>>>>>> pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, false);
>>>>>> +        remap_queue(pdd->dev->dqm,
>>>>>> +            KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
>>>>>> USE_DEFAULT_GRACE_PERIOD);
>>>>>>              mutex_lock(&pdd->dev->pcs_data.mutex);
>>>>>> pdd->dev->pcs_data.hosttrap_entry.base.target_simd = 0;
