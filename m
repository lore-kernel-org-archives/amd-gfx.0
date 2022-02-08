Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F4BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 14:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044E610E289;
	Tue,  8 Feb 2022 14:32:01 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 081F610E289
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 14:31:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcT6W+x0/UI+LYMbRYbGQJpp1Et4l2jI9AU+5YjQfyVcbZZzYIwMgTNar+0LAaQ8B3beVAqn/PkCDQy7cwxdQfT3bbnJQ5yKAwEwmcEzZ+5cYuLIct9BGc+9lXxXABGv8mlBTnBZetHIK7yQygOiE9VeoPtC7M6Y4drpxQwhCie2t05sdmwUzDCAUCyxj/tM5XJoa95dtUGMTHxPaL4Tq9LhtlkTqKXKRFCgvLebIGewNwepl0JzpLSz0kt594853SK2l4UG/ocOr1C9os50cbxp0tpWh515dGG0pODwf4PLeDi6MTFWmYfpJmw3/3DAGF/hWgaylWtXEgavzyQIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYURS/8iS9AlbhBCKHwH9SeGxF49K/womA0DcC1FcPc=;
 b=hw2CHTZRu3AbWStVMus5dgldLKwMEJOr8sLY8BRr+GlPM8IgWat0PZ+N88x1D4JkZ1zBH4thjksj4Dd3W4HKJtqGh0Zk2sfRkz5CaJXMl2djkUCfdIaHbhegdkNkqx+PpGfG5lKss1t63JPPHpyIFZ+XcbUWjwLkGYN6IfwGO3VVYBjxRAxbGQS/15VGAwGkpoc0WveRFt8rdaWcyS7mx1UOO0Y9n62e+PI89L/OGwftgAiQBcZg7tpWn7JtYLMXAvqrjDHokPNrnZJcTyfB3JyUUYAi7E0I0dg15na+8T6PBHeI6tfvEtuX1h+bj0fAbsslGzM6ZnrXZLEmFjv8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYURS/8iS9AlbhBCKHwH9SeGxF49K/womA0DcC1FcPc=;
 b=ZYBPtU8MwWa60PcjWswh4/H6FAJa6gGJYbv5roghNbzlbqlPaimWJa/WWbRh0I2/67Opnep1auY+q9tipiNH6FDz3ZknOasfJzDcqDITX3ZGZi2TbXoGLoK+CoWiSOhqAu6E+l8vr1/IPUOiuVi6xRMSWHcawEX4AQDoN4m5zOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 8 Feb
 2022 14:31:56 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4951.018; Tue, 8 Feb 2022
 14:31:56 +0000
Message-ID: <48646543-ac47-bfc1-ee09-54c22fd5ac6c@amd.com>
Date: Tue, 8 Feb 2022 15:31:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
 <385688f4-2165-ba58-8928-5774a44044e7@amd.com>
 <e700ecfd-1935-7545-f962-b6decd4377c5@amd.com>
 <52c555ab-ec80-bcfc-5811-270b3b23c5c8@amd.com>
 <e92cd376-2cf3-f7ed-3dee-a39f0f5c7cbc@amd.com>
In-Reply-To: <e92cd376-2cf3-f7ed-3dee-a39f0f5c7cbc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da54278d-4b17-464d-29b2-08d9eb0fc1f9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5380:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB53806AD594A36F912B7E2E3EF22D9@BL1PR12MB5380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0U9oLOLsfginnK30okaziZOT9wRtflvYlHsgvzeXBEB3S1ZILTVfMkEICjHrsjf1wc2HkRA0wzc610lY23CU1toiu+znwFdfhb5FLcurcrrimGoge2bI/YVQVLXphHFQuK/6tylwj2YWa43fFTIZ3qtOZ8Tcb0deKrBA3SvciAWKKrrUhico0u49HBquNI4jyivYsD+mEcjbPDaMj/8eS1vZbs0TjCmOLwOIQHOPCzInIItidsDQQMo2DjwXwevlVogjpswRNfObHtPQ8N/2SzyINrU7CWKnjxPwb3jw+M8EdqE191iWAb3U1pPeR+j/VrkmJXrhcecbZwJARH+RepYVlmL13kNzNFp3gBj3RjrS5MrqRE3jCZ6ueexBQ4Zfqd2CzWd+e9AQ7qjVxxoMQXEI320utGJ46dkqGEhzrRTb6tcSt8ZUz3x20tnO/oDDjiXb3YVZUxd+c7G/QbrnBIPrvSesXNJ8n1EicjugRHWkSRtF4LOi3jL9XJwOCXvqfaM/1LIAoFfgwClfF5fZR+psfK2KHfoqGXO9G+qC1ChO4FbMvUTIsl6HGO1QjNaz6xQ6mwUBYHoKQV7Kknn6MbNKvcVFC/ojGUilnUTX9E5uWL1xlKIxYWthQgN0rAs25R5cCTd6UGqxPZHpT8CpJH7KQZYfkN1Dw9PQ53pdsR406VXTAb9dd4gJzPOWzLIx7Q/QYX5wPLNOeVyEWB1Z9deiu71LW3inRAm2X0CC+TxRltXWMmgiawAuBusqG1z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(186003)(26005)(66556008)(66476007)(6506007)(66946007)(2616005)(4326008)(8676002)(53546011)(508600001)(36756003)(6666004)(110136005)(316002)(6486002)(6512007)(66574015)(83380400001)(31686004)(86362001)(31696002)(8936002)(5660300002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnZRZ0tMVmlYUFNTTkRzalpxVDgwSlVlMDNqQ05iN0RtbVoycnBJeTRRazBZ?=
 =?utf-8?B?RDlLM1B4U3JMNXdNbnducDNPS3pkNW9tZ01ETWdYLzhZZXdPQ292MXpRTXFw?=
 =?utf-8?B?Tmc1ajdwcDJYcEpNUDdTMEM3M0I2cDNrN0tYR1RhWC9PejJNL2RnQXBhdlZM?=
 =?utf-8?B?UmRvVTB5SXpFVHdLeHJaQTgzRUFuRVMxU29UenpmVlBTYjIyREExSlF4VmJK?=
 =?utf-8?B?WTdyaGNOUVRmNWRwYWVDQkd4VytuU003elhiUmZTUFJLTUFsMXJraUZrTHZO?=
 =?utf-8?B?UDhES0hhVW9qWmh2Uy8vMENkbHZzTHdTaFVwMGhGdEZwVFJnSVRWWTFlSC9R?=
 =?utf-8?B?OHM0Y2M1QUJyaVNhQWRDdzFWRmt4ZE1QYnVYQTZwNmdVSGhvWG9jUG85dmk5?=
 =?utf-8?B?NS8rSjljU2orK1FpZG5ZaU04RTVwTlowUDZNTnJsWW45T1JTTk90ak5iVkFz?=
 =?utf-8?B?ZjBIUzRXSjZwUDN4RVVyczlMbmFkSDFJdWlPZG5OQStEZkhmcm8wZ3ZEanlo?=
 =?utf-8?B?WGlSb1VlckpGVE5XUlViM3RwbEFwa05NRVhDMzFxZTRUaS9nR2Z1eWlEV3Nh?=
 =?utf-8?B?WUxNWmo1VERzMUJwZWVQa1Y2U1pSaktEYndIK2JkK2Vaa1JMay9wQzFxeHBI?=
 =?utf-8?B?S3FEcjRPTWc3NWtMdG8wc1BpUTZsU2szd05xdXJhZHQxZUZvaUZuVWMxMUdh?=
 =?utf-8?B?MGxuOWNWQ1pTMlgwZU93ekdINHFYMEFvRlVuaElNUmlEUk51SzFGeW4zL1JL?=
 =?utf-8?B?MnBiQzh4ZHFaRlF6MzBGUEZPSWVvV2xKU0dJdWRrenp0N1h1bzNTRFlOUk1l?=
 =?utf-8?B?d3E5NXJma211b2cvRG1ZTFRTSTdlWUROTjVrTS95WUJyZ09nWlhIU0l6cG1N?=
 =?utf-8?B?WkpwNFlGVytibUpDVXJlKzMxck9lbFVGYXVyUjlyVVZaMVdjTkRFd0d6MVdu?=
 =?utf-8?B?N1o1c3lZZHpDMGE3Q2pDdnQ5SHlIb3hWNnlNYlYwVE1aNDhqY2QyNW9RVFph?=
 =?utf-8?B?azJnUmZ1TFVaOW5hNmNCaFg5VFowYkxjUHhzdW8wRnllK1Q4REFUN0Q2QVdJ?=
 =?utf-8?B?aTZGMnNTR1BRN0pSRHZFOE1tQ3N6NlNheGNRVE1ZUjNtTkUzSDJhTTdJaXVq?=
 =?utf-8?B?ZUdpUXZsT1JXWVpXaU12SHpoSlRJeWUzVnlGUTE4Q3dCd2ZqL2FBK2NKTm5Y?=
 =?utf-8?B?ZWF1d3NOQnV5SUVoQ0Y3VWxZSnBtOE41WXZMcjhHRzZvSE0wYmtCVWVVZDJP?=
 =?utf-8?B?SCtueGxxREtNRUhPOUVjZDE1YnNRV1lsbFp6NVJVNHA1ck5GQVhqT3hqVFhP?=
 =?utf-8?B?ZEFmNVFMQmNGVnd3UXVNNUY4RFhMb0src2hEYVZkMEV3R1Rud0xtMjZwckJ4?=
 =?utf-8?B?eTUrQkpkL2grT3AzWUdlbFdjSWVWM2tyWFVoL3U4N0JBQk9YbWdWVXRlZ3ZF?=
 =?utf-8?B?Zm5pa1R5ZmZSNkkvTVlZWEswZjF1RFFrZGNQam9ySFRHd3pZUkpYN2V1VDB6?=
 =?utf-8?B?TWpoaWZVTDB0RjB5cWlkNWE0NjhYRnBQNjJZLzBqa01HaURxRVBENGV4WmZq?=
 =?utf-8?B?VkdNMXlETHhyaVBTczhPaXRKSkJvVzhva1ZLalJaUVBjZHd6S2FCN0ZnaWNz?=
 =?utf-8?B?MUlaRW93d0k3MkphUGQwMjEwWm5iTWliM3ZNa01uWlFDdE5MYlhKRDc4MnpV?=
 =?utf-8?B?eW5aYmU1VlZXZitvZnJYQktYMjZnZUhUVmVzeUloOFlZREhRcWVSbkpXenc2?=
 =?utf-8?B?cGRMN3BZVUZBdVpRaEZLaUVKQkxjcWhWRnFxd1RDRlFxTTlNenpPUHRmdDVz?=
 =?utf-8?B?bTF2MTFBQ3pqMFAyVmREWVVYQS9BZU1uekxOa09ibk01SU1pZmc0TDloVHk0?=
 =?utf-8?B?cG5sUkdiVW1kT2tVaEpiQnRKSEtxSWxjRHRydmxpVlgxRmU2enFjQkROMm1o?=
 =?utf-8?B?VlM4bjZqOW9pM0kzRTVZT01EdmMrc2RLcnpFTzJNVTJtS05zK1ZhWnc0cHMw?=
 =?utf-8?B?ais5NmZUODY5YlJiMHMxYXk0RjhmNWZyWDVlMVRDdG9COTdpWEZVOWdDbUov?=
 =?utf-8?B?S2Nrcy9DWGtKaXFnLzZwYjRQazU3a1pQV00yZGdka0FEM0Z5ZHRQY1dLbUIw?=
 =?utf-8?B?VndCNkVrNGNqUVF2THVzMThhWUtzeTBNd01adi9oWTFicE5uQ20vY0gwcHZ2?=
 =?utf-8?Q?a9aFNcv2guNnqK4GTprBwoc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da54278d-4b17-464d-29b2-08d9eb0fc1f9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 14:31:56.3347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5NuajyhTtEAKd3CRfHXhqOtcTCAEzsDyHCxI7QamVOitk24rjG77STz0qqPSp5Dl9XA+6YI+7J9u+60Z/rmCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 >> User only update the list of reg offsets on init, there is no
 >> predefined reg offset from kernel code.

I missed this comment in the last patch, and this makes me a bit 
confused. During the design phase, did we agree to have this whole list 
loaded from user ? which means that if user doesn't define the list at 
init, we will not send the trace_event().

Or was it kernel has a list, and user can modify if he wants to, and we 
will dump the values as per the register list.

@Christian ?

Regards
Shashank
On 2/8/2022 3:18 PM, Sharma, Shashank wrote:
> 
> 
> On 2/8/2022 2:39 PM, Somalapuram, Amaranath wrote:
>>
>>
>> On 2/8/2022 4:43 PM, Sharma, Shashank wrote:
>>> I thought we spoke and agreed about:
>>> - Not doing dynamic memory allocation during a reset call,
>> as there is a redesign debugfs call will happen during the application 
>> initialization and not during reset.
>>> - Not doing string operations, but just dumping register values by 
>>> index.
>> I think your referring to the second patch which happens during reset 
>> and no string operation in second patch.
> 
> Pls see my comment in the end.
> 
>>> NACK !
>>>
>>> - Shashank
>>>
>>> Amar,
>>> Apart from the long comment,there are a few more bugs in the patch, 
>>> which I have mentioned here inline. Please check them out.
>>>
>>> - Shashank
>>>
>>> On 2/8/2022 9:18 AM, Christian König wrote:
>>>> Am 08.02.22 um 09:16 schrieb Somalapuram Amaranath:
>>>>> List of register to be populated for dump collection during the GPU 
>>>>> reset.
>>>>>
>>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  3 ++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 60 
>>>>> +++++++++++++++++++++
>>>>>   2 files changed, 63 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> index b85b67a88a3d..78fa46f959c5 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> @@ -1097,6 +1097,9 @@ struct amdgpu_device {
>>>>>       struct amdgpu_reset_control     *reset_cntl;
>>>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>>>> +
>>>>> +    /* reset dump register */
>>>>> +    long            reset_dump_reg_list[128];
>>>>
>>>> I don't have time for a full review, but using long here certainly 
>>>> makes no sense.
>>>>
>>>> long is either 32bit or 64bit depending on the CPU architecture.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>> will change uint32_t.
>>>>>   };
>>>>>   static inline struct amdgpu_device *drm_to_adev(struct drm_device 
>>>>> *ddev)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> index 164d6a9e9fbb..dad268e8a81a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> @@ -1609,6 +1609,64 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>>> +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>>>>> +                char __user *buf, size_t size, loff_t *pos)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>> *)file_inode(f)->i_private;
>>>>> +    char *reg_offset;
>>>>> +    int i, r, len;
>>>>> +
>>>>> +    reg_offset = kmalloc(2048, GFP_KERNEL);
> 
> We also want to understand how does the value 2048 came into picture, 
> probably a macro which calculates the size preprocessing time will work 
> better.
> 
> #define #define N_REGS_DUMP_GPU_RESET 10
> #define BUFFER_SZ(N_REGS_DUMP_GPU_RESET * (sizeof uint64_t) + 1)
> 
> This first macro can be used later for the loop count for registers as 
> well.
> 
>>>>> +    memset(reg_offset,  0, 2048);
>>>>> +    for (i = 0; adev->reset_dump_reg_list[i] != 0; i++)
>>>
>>> This loop termination condition is incorrect, why are we running the 
>>> loop until adev->reset_dump_reg_list[i] != 0 ?
>>>
>>> What if I have 10 registers to dump, but my 4th register value is 0 ? 
>>> It will break the loop at 4 and we will not get all values.
>>>
>> agreed, i try to avoid one more variable in adev
> 
> Not by the cost of logic of course :).
> 
> Now you can run this loop here.
> 
> for (i = 0; i < N_REGS...; i++) {
>      register_value_copy_here;
> }
> 
>>>>> +        sprintf(reg_offset + strlen(reg_offset), "0x%lx ", 
>>>>> adev->reset_dump_reg_list[i]);
>>>>> +
> 
>>>>> +    sprintf(reg_offset + strlen(reg_offset), "\n");
>>>>> +    len = strlen(reg_offset);
>>>>> +
>>>>> +    if (*pos >=  len)
>>>>> +        return 0;
>>>>> +
>>>>> +    r = copy_to_user(buf, reg_offset, len);
>>>>> +    *pos += len - r;
>>>>> +    kfree(reg_offset);
>>>
>>> Also, why are we doing a dynamic memory allocation for reg_offest ? 
>>> We can simply use adev->reset_dump_reg_list[i] isnt't it ?
>>>
>>> simply
>>> for (i=0; i<num_of_regs;i++) {
>>>     copy_to_user(buf, adev->reg_list[i], sizeof(uint64_t));
>>> }
>>>
>>> Or without even a loop, simply:
>>> copy_to_user(buf, &adev->reg_list, num_regs * sizeof(uint64_t));
>>>
>>> - Shashank
>>
>> it will not be in user readable format for debugfs, (if non readable 
>> is acceptable I will change this)
>>
> 
> We are just adding 0x in front of the reg value, so honestly I don't see 
> a huge improvement in the user readability, but if you still want to do 
> the dynamic allocation of memory, add the register offset or name as 
> well, I mean then it should read like:
> 
> 0x1234 = 0xABCD
> 0x1238 = 0xFFFF
> 
> - Shashank
> 
>>> +
>>>>>
>>>>> +    return len - r;
>>>>> +}
>>>>> +
>>>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file 
>>>>> *f, const char __user *buf,
>>>>> +        size_t size, loff_t *pos)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>> *)file_inode(f)->i_private;
>>>>> +    char *reg_offset, *reg;
>>>>> +    int ret, i = 0;
>>>>> +
>>>>> +    reg_offset = kmalloc(size, GFP_KERNEL);
>>>>> +    memset(reg_offset,  0, size);
>>>>> +    ret = copy_from_user(reg_offset, buf, size);
>>>>> +
>>>
>>> We are not allowing user to write into the list, so this whole 
>>> function can just be a NOOP.
>>>
>>> - Shashank
>> User only update the list of reg offsets on init, there is no 
>> predefined reg offset from kernel code.
>>>
>>>>> +    if (ret)
>>>>> +        return -EFAULT;
>>>>> +
>>>>> +    while ((reg = strsep(&reg_offset, " ")) != NULL) {
>>>>> +        ret  = kstrtol(reg, 16, &adev->reset_dump_reg_list[i]);
>>>>> +        if (ret)
>>>>> +            return -EINVAL;
>>>>> +        i++;
>>>>> +    }
>>>>> +
>>>>> +    kfree(reg_offset);
>>>>> +
>>>>> +    return size;
>>>>> +}
>>>>> +
>>>>> +static const struct file_operations 
>>>>> amdgpu_reset_dump_register_list = {
>>>>> +    .owner = THIS_MODULE,
>>>>> +    .read = amdgpu_reset_dump_register_list_read,
>>>>> +    .write = amdgpu_reset_dump_register_list_write,
>>>>> +    .llseek = default_llseek
>>>>> +};
>>>>> +
>>>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>>>   {
>>>>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>>>> @@ -1672,6 +1730,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>>>> *adev)
>>>>>                   &amdgpu_debugfs_test_ib_fops);
>>>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>>>                   &amdgpu_debugfs_vm_info_fops);
>>>>> +    debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>>>> root, adev,
>>>>> +                &amdgpu_reset_dump_register_list);
>>>>>       adev->debugfs_vbios_blob.data = adev->bios;
>>>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>>>
