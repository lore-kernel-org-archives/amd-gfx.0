Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA5CC5AD4C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 20:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0581C10E354;
	Thu, 23 Nov 2023 20:33:40 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3770310E354
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 20:33:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMeea1WpotJlfZ1/G5OPgNnR2kCMJlo0yCBM5VFlDMIO2DZep+dve2bZmmP9EowFbm+IXrgc0fDX5qLsx63akdLwj+a4u4j9hHG4QNwmy2AohllB64pLJGskc2A9V6UXcH3WE+sSrEf0ARslgCO+IfmC7kED/58DMLBhzIoG0hNAA116UqLdnwMy6gZzl/6BKGPm2S7LM3dnMmSvh7+yvVxhsNnggLKePv/hEtOI7YXwhxCBZuKR0Wj9YWWYPgiuZZ/Nb/pvTCfMqoRZ0J/TlkEQpUuVINY3WrxySVY316XPFSB8/WFx6HtapIMM9a5NVMn/SbA3ahcOcP18VyHpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+watKuAR7J8sYN5ZKjhxg9ioWtMJjzPizE+68HeTac=;
 b=Em/qoIz/gPWFcEOAfiDx1bdOnOEteZLBBhVtPnRpt+/gqoqDzrRV1RepbVO2h+pBM8/f4+AGl6TBNtEAs7gQzLPvp5/S71DNhDB9cVhZV17lDXbXWPy4wKg+nDwe61ltQlCfiLjnhJymZJVzIvQrd+3+YN+ciZbHtfaT0v9AfzkR7AdDLYwepcUCo6lUAK/CRso6D2KDYsM93Ih7mn0/LLCnpqoZ43SUuPPPPxYcHDtKTvANhoT3Im1MAQl08xzIgKrVTQzd8ppBehLlEo8dYDrg6GUxzNuDN+hWGdXLjDCVR3gf/gQm23M0angcENEID0FbBb0RgV0U/JH0nrRkoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+watKuAR7J8sYN5ZKjhxg9ioWtMJjzPizE+68HeTac=;
 b=yQ7yWTUjZPlVJ6gXQL2lY8u4KWd62RY/gJYfn8LnULzrj7zffttmF8XhJtITG8aWBZGCVu349Voihbj76rT5Kx0n8N4tK2HL447d/SPF/uSLVgQJt2nn8vPJETtzuECPjL/88sRVQNR5YafVQ7rlgVhzXY/IQnemlo/QG07Wm34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by DS0PR12MB6488.namprd12.prod.outlook.com (2603:10b6:8:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 20:33:33 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 20:33:33 +0000
Message-ID: <bca68f6c-4ff1-4962-8751-a42a7ab11f56@amd.com>
Date: Thu, 23 Nov 2023 15:33:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/24] drm/amdkfd/kfd_ioctl: add pc sampling support
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-2-James.Zhu@amd.com>
 <2667de7c-1840-4804-8099-ad143982098e@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <2667de7c-1840-4804-8099-ad143982098e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::27) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|DS0PR12MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: dc386bcd-4249-475d-fc76-08dbec6375d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xgNkq/MxSM8NSyJYcEczCXyj7s7X0XtDbvyzw5hrDT3UNUoUtaWhyoaRkcolzU9mC2U7yrlqD/p+FzIZNJVxbt7tvZOXjwPDL1KMSU89GaNFlK3XXTQyPpaug/QBSES4zjTU1CUfsox+7mhlHy2RbnsumMggLPK9SF/vtj7xpwz/gHZEBbhFf15jNz7FAjLbkLRQuAtaX2NYE/EP1vEo/ZmGyL/ts8kkGys9pAnlgadBmbmQMZ0hOVTaK6HcLAqXNgBrqxjUI4kpqzf6BlJFuBqvE6PWdiRSis/PZ8y7tYjf3ge4wi16BjfaRGlTkm5qlAq3AVhxp6sTfhI7qRbSsa33Oh5rO7Ve0LXummFOf2cPMyGHJNJCvRJdHMJbQfAbpT3N2Zk2NKHE6yYDZ+LfPloYAG0kcHNeU/9yNB3Of6TUwddRcv5u+ApEdFA+EK2tPEmhRMfZBNQg8PlTGugBi7fnM4VJ9Pc4aUgIBTvci5XONU8dDhcC3/EZqVaAPWUrPJM+PYfG0wlIbfSw7pumeOe6EQohEDflRfMJX4RGhltPuy1LxikuvtDgbE/PPp7vYGH2fkwjV4aj16rdjmsaurLv0Qr4+Dxy+mz5zWYREueo4++89/HBc/8oKHsShIzk6DOL0nhjRL7ZefkZNuyXng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(4001150100001)(31686004)(31696002)(8936002)(2906002)(5660300002)(83380400001)(4326008)(36756003)(26005)(66556008)(66476007)(316002)(38100700002)(110136005)(6486002)(2616005)(36916002)(8676002)(66946007)(6512007)(53546011)(478600001)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFFpUVBaU0FKRHBxd2plTE1EWENPVm1ORFFFWmh0bXk4MXBuQk1memE2bWpS?=
 =?utf-8?B?TWZXc3QxNElCMUJacG1KbmQ5SFRXVDVlREhzdUMzN25Fa1lqMnd0SDFHaFVG?=
 =?utf-8?B?YnBQNStnOVFhejRtWnQ0ZTMvb1VGcU5LOU8zUkxBZ1YxanFZRW1NQkFUdHMr?=
 =?utf-8?B?YXgydkRMbk9OSWFQa2t0Uyt6VkZ0V0YyZW1NMU1vZjliOHJqOVJkejQ0VnAv?=
 =?utf-8?B?OVk2Sm1tOURTWnlVMFkybVl3amt2RWNqSHB1SWp6b21OVEpnQ0U3NkNMQmFy?=
 =?utf-8?B?andxU2VLWkJMUDJ5VlpDd0h5K2VHc0V6cko1RkJuWUhRYmR5N0dlR25IZzFK?=
 =?utf-8?B?elFvOE1JWE9uRk9HN1NEaTFIMnRTSm9rL1B2Qk9CM2J0Ym9ReFhlVjloWVlJ?=
 =?utf-8?B?VFdWVXJFUytWSy9UQ3FJU0pmSWtlNXVEN3hiODVvMFQ4SmVKNlJ0TENSenlq?=
 =?utf-8?B?V2dNNU9Xc2JDRGpPcktzdGU0T05PdjdGK0JuNXNmcklYV1ZiUkdiWUh0dFpS?=
 =?utf-8?B?QkV1clYrTGZtVlQ3akNOZnE4Ym95Y0cwbngxbGJTRzl0c3ovUWVobm9yL0NO?=
 =?utf-8?B?TXBkSHRqaUJNNS9PV2dJM0Y1N3FHcFprQ2NRTk1td3JUVzA3Z0hpQldnRlMv?=
 =?utf-8?B?M3Y3eVRXVmV1a3JqblcxTU5YQ0p0K0hNOUcyaTQza0xQSEdnUVB2b0srWGpl?=
 =?utf-8?B?K3dEcm1TR2dHRERxS2hINjBta1crMWFEVzRnYzZxUkQ0ZEFQOXhnSm5Ka0xS?=
 =?utf-8?B?QUFHcC84UEVxcm4wSmxIK2FhVmhpSGROVGtQNXhGOTAvRVo2K0ZpRWRnWHBR?=
 =?utf-8?B?WFlHT2orRzRFOVNqQzE2UVVYZUFPRkkwWUxiYmhIR05lRVZkWnU2Zys5RGkw?=
 =?utf-8?B?czVWeWpQYmg0NFhBbjllWWxLNC9vWEtLRTVkdUVobTQ2MUwxR3FRMEFqY1NN?=
 =?utf-8?B?SXpkT0ppRE9JUmU4RHRTWGJKVktqQ3pER2w5VjZ1WnJSa2JrL0srUnFIeG8r?=
 =?utf-8?B?WllESFhmWWtDMUdUNVcwTlpmV2NFMUxsdXBBZmVvb21vN25DL25VRXRYcEhL?=
 =?utf-8?B?RzFaa3dBbzQzVlNNMGlpTWVVWDhPVVpqL2FWZ1h5ckRUU2t4d0lJZURsaGQ3?=
 =?utf-8?B?R3ZEQy9ieDZOaTVpQStJemM0NnB1OFd4WS9MS0Iwd2JEY1N1V3dQTk9jS0pw?=
 =?utf-8?B?RjA1Y3c5emRiS1l4bk1Iam1FeDZPc09WOHIwbkxWUFNxN2NKcXVCUjNoN1hK?=
 =?utf-8?B?anlWd3RsVlhOY1pUdGh5RjUva1dWT2tWaVdTUGFQOFg5V3h3RUxjVHZJL3k5?=
 =?utf-8?B?cUNNTHdjOWpkVG5HRmMvalgwOS94bEhPdTVvM21jckY3OUN2OTA1ZXRGRTJT?=
 =?utf-8?B?dDVVaThsSWFtNHJDc3BDZGF3YkdSQWo4VG5QYk9la3ZqaXFOWGhTcjF4a3BN?=
 =?utf-8?B?MVBSZnlEaTloR1FweTJsVUVtYldNL2dZZEdwQ2x0dzBWR3NmOG5DSFU0dmRY?=
 =?utf-8?B?RlcwcFJTQlU4RFVMRytkNXVvZHdnSCtjZll1K1FEWnl3cmVIVDM2U0VXS3Ft?=
 =?utf-8?B?VDJKZTdOU0lPcHUzVnErbEYrckxOekZwUTQ5akQ3VXZVVUhlQlJSQk1WZzFU?=
 =?utf-8?B?N2owOFhRcy9NZjJFNzdKUHlyNWFKcU94TWVkcnhnZGJZZmJ3L0duL01jSUpn?=
 =?utf-8?B?QzIwK0YzQ2ZNYWwxbmlTc05XR1o4eTVwbUJqMWdDejJzdjNFT3dGQ3cxVVVM?=
 =?utf-8?B?VFYvVVFZdFJ0Um5xNUxucCtSZ3VFMlI2UjVRV2xtNCs1ZXdhSVVCUmlBeG9a?=
 =?utf-8?B?bGIyMlVxRTRmMThjWGJvSVRFeElnN011NjRlZ3dQUTJWSDI0VzNQQk5mYlFx?=
 =?utf-8?B?VTY4SFhOREdEcmdCM0dJY2Q2NUl3dkw3b0x3a3BpOTF0djFFVTNmYnBoWUEr?=
 =?utf-8?B?aktLWmRrZzJ5Z0h1YldVUFcyN1c3SHpXZExVZ0JIZFpLbUdIc1pRQ1ZMVkN4?=
 =?utf-8?B?Yy9pRnFTTDFXMXBPeWEyT2lTd1dSQ2t6d3I1RGR6R1ltdjFFUmJrOTFtdXNG?=
 =?utf-8?B?YzIvelJvVzY4UGcyN055NEpMRGlobThPYUc2RzU3Z3kxTjBzQ0ZoRTA2eVZp?=
 =?utf-8?Q?YNXgKj9QshJmDhpS+B3W0AAdS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc386bcd-4249-475d-fc76-08dbec6375d4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 20:33:32.7174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWeJm1j6742eFjDvFSefntuHJ1ozJVEauBpI+qKje5SKcTk/QGhcAePrmMQ2GcmA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488
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
Cc: joseph.greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-22 16:14, Felix Kuehling wrote:
> On 2023-11-03 09:11, James Zhu wrote:
>> From: David Yat Sin <david.yatsin@amd.com>
>>
>> Add pc sampling support in kfd_ioctl.
>>
>> Co-developed-by: James Zhu <James.Zhu@amd.com>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> Signed-off-by: David Yat Sin <david.yatsin@amd.com>
>> ---
>>   include/uapi/linux/kfd_ioctl.h | 57 +++++++++++++++++++++++++++++++++-
>>   1 file changed, 56 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/kfd_ioctl.h 
>> b/include/uapi/linux/kfd_ioctl.h
>> index f0ed68974c54..5202e29c9560 100644
>> --- a/include/uapi/linux/kfd_ioctl.h
>> +++ b/include/uapi/linux/kfd_ioctl.h
>> @@ -1446,6 +1446,58 @@ struct kfd_ioctl_dbg_trap_args {
>>       };
>>   };
>>   +/**
>> + * kfd_ioctl_pc_sample_op - PC Sampling ioctl operations
>> + *
>> + * @KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES: Query device PC Sampling 
>> capabilities
>> + * @KFD_IOCTL_PCS_OP_CREATE:             Register this process with 
>> a per-device PC sampler instance
>> + * @KFD_IOCTL_PCS_OP_DESTROY:            Unregister from a 
>> previously registered PC sampler instance
>> + * @KFD_IOCTL_PCS_OP_START:              Process begins taking 
>> samples from a previously registered PC sampler instance
>> + * @KFD_IOCTL_PCS_OP_STOP:               Process stops taking 
>> samples from a previously registered PC sampler instance
>> + */
>> +enum kfd_ioctl_pc_sample_op {
>> +    KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES,
>> +    KFD_IOCTL_PCS_OP_CREATE,
>> +    KFD_IOCTL_PCS_OP_DESTROY,
>> +    KFD_IOCTL_PCS_OP_START,
>> +    KFD_IOCTL_PCS_OP_STOP,
>> +};
>> +
>> +/* Values have to be a power of 2*/
>> +#define KFD_IOCTL_PCS_FLAG_POWER_OF_2 0x00000001
>> +
>> +enum kfd_ioctl_pc_sample_method {
>> +    KFD_IOCTL_PCS_METHOD_HOSTTRAP = 1,
>> +    KFD_IOCTL_PCS_METHOD_STOCHASTIC,
>> +};
>> +
>> +enum kfd_ioctl_pc_sample_type {
>> +    KFD_IOCTL_PCS_TYPE_TIME_US,
>> +    KFD_IOCTL_PCS_TYPE_CLOCK_CYCLES,
>> +    KFD_IOCTL_PCS_TYPE_INSTRUCTIONS
>> +};
>> +
>> +struct kfd_pc_sample_info {
>> +    __u64 value;         /* [IN] if PCS_TYPE_INTERVAL_US: sample 
>> interval in us
>> +                          * if PCS_TYPE_CLOCK_CYCLES: sample 
>> interval in graphics core clk cycles
>> +                          * if PCS_TYPE_INSTRUCTIONS: sample 
>> interval in instructions issued by
>> +                          * graphics compute units
>
> I'd call this "interval". That's still generic enough to be a sampling 
> interval in a unit that depends on the PCS type. "value" is 
> misleading, because it sounds like it may be an actual sample.
[JZ] I am fine this interface name changes,
>
>
>> +                          */
>> +    __u64 value_min;     /* [OUT] */
>> +    __u64 value_max;     /* [OUT] */
>
> interval_min/max.
>
> Regards,
>   Felix
>
>
>> +    __u64 flags;         /* [OUT] indicate potential restrictions 
>> e.g FLAG_POWER_OF_2 */
>> +    __u32 method;        /* [IN/OUT] kfd_ioctl_pc_sample_method */
>> +    __u32 type;          /* [IN/OUT] kfd_ioctl_pc_sample_type */
>> +};
>> +
>> +struct kfd_ioctl_pc_sample_args {
>> +    __u64 sample_info_ptr;   /* array of kfd_pc_sample_info */
>> +    __u32 num_sample_info;
>> +    __u32 op;                /* kfd_ioctl_pc_sample_op */
>> +    __u32 gpu_id;
>> +    __u32 trace_id;
>> +};
>> +
>>   #define AMDKFD_IOCTL_BASE 'K'
>>   #define AMDKFD_IO(nr)            _IO(AMDKFD_IOCTL_BASE, nr)
>>   #define AMDKFD_IOR(nr, type)        _IOR(AMDKFD_IOCTL_BASE, nr, type)
>> @@ -1566,7 +1618,10 @@ struct kfd_ioctl_dbg_trap_args {
>>   #define AMDKFD_IOC_DBG_TRAP            \
>>           AMDKFD_IOWR(0x26, struct kfd_ioctl_dbg_trap_args)
>>   +#define AMDKFD_IOC_PC_SAMPLE        \
>> +        AMDKFD_IOWR(0x27, struct kfd_ioctl_pc_sample_args)
>> +
>>   #define AMDKFD_COMMAND_START        0x01
>> -#define AMDKFD_COMMAND_END        0x27
>> +#define AMDKFD_COMMAND_END        0x28
>>     #endif
