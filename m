Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17A9C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Nov 2023 19:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A5810E3F0;
	Mon, 27 Nov 2023 19:14:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6528E10E3F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 19:14:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLT/4JHMnFldJXj5leDNpj5V2MrF8CQixJAFJKtH3Sct7K7MfS9otROxMIIso7+Vb2Cu/rosMYdQMMFjAmDZkiLsLJIc1qnfGkDzjp5OMdETaE9lL9kAa176qizbd/PlM5eGvnrmNxeBUApLhB/6shuXUkg93D5bx3C+V1dJw8rt7LPiNWWUXq1wTBkyRu5NM8/p3wC1j7kRQhasrMoUUQW5yCIyj4P34SXFe7TKLoHZhZT2aJsTnFQTezZed0e6Jcljs27cXJoqykaIwAQwvXrLSviAlQyzSZFbrWCR5e3bnKg9ikoqjEm9BFXDyJjiXR5wjmhVJ295YHmui8bk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKgEad93NwVGKrxptevkztNLWh6O2EKW2l9O5WbjKr0=;
 b=jLZnngaypyrrWjJohjigmKQibwz5hMkCFxGJVpZ4gN9MALRtwPGoLubTjIj1dNgLSNzrznEh4G6A3GiiR8k2MGWQ29r+jILz2nPSFQxHmCjva0X4mUNSOo9nj0RYZqeGPXWDsCF8E65vDDP51/oP8p1bRhvvr16VpG8ZpYUJXivGFgExzKDsVASwVBHoODVMMwOfzSVw9GTD2ASvPp4JJlZio2pWna6JVe8ORV0xSD8W6f1BE6gMTiQAH+d1b06nqOzbB/DVT3VDEeGaiNL4Sbi5DENSpO0CAPU2MKuVMO+BenN1zPJlFE5Qs+9omy/X+JFNePU3yyS3QmooOEtaGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKgEad93NwVGKrxptevkztNLWh6O2EKW2l9O5WbjKr0=;
 b=oZvJywrFMgaRyaUCUIcRFtTi7L7NEzXwTHhrKmCZ9rIhAHJGTmXjTEZXx3FrJllA6i+A9YMydL1AtpahYO37XV2TKNPFJ9MEmIuNiXFS9KZzsQG1d/WKu38MT37yFE6aflpvZKMLsiNE6vKCV9UMc9fOgQBBAIjBY95/0ES/prQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 19:14:26 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 19:14:26 +0000
Content-Type: multipart/alternative;
 boundary="------------d4wZMwdoXy7Hw6ac8MtC70qH"
Message-ID: <4dcef83c-6ae7-4b6d-b0ac-4eae173bc83f@amd.com>
Date: Mon, 27 Nov 2023 14:14:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/24] drm/amdkfd/kfd_ioctl: add pc sampling support
To: Alex Deucher <alexdeucher@gmail.com>, James Zhu <James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-2-James.Zhu@amd.com>
 <CADnq5_MyXm+G3n=n9o8NJiHR9BtFZkN9+FSS1r3MkUvaPnzh7g@mail.gmail.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <CADnq5_MyXm+G3n=n9o8NJiHR9BtFZkN9+FSS1r3MkUvaPnzh7g@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0338.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::6) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 3517021b-e617-41d9-e4a3-08dbef7d1259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YXv98RGBEfLMwztxoBRgeE6/Wh/tPQHxMjG/yjM0Glr4EnyKKvBMc2PJgvE/OuYkrJkTbWrxwootWS7n1bc41ood4xPzdrzcftH5pzLyvGe86W9cFpH22ufYwLuKZt5niH6iPeoHjJNU64/Ij26pdNcTpHuR6yUNbT1RZVPOqJ7V9D4X+2KSLyCozi7oqqkHqPbxLqgw1miZ4KhlGprWdEfPO5w0DiN661e3TqUMcxOD9i38Vx2KImGUlV5g6+hy8beOtEyJ83bQQkU83poxga5A2EA+qp/wFf9Zu4O0ZJTVTRU/aYiBkO3pTkxxo7Kw161QnjRePAHMOAlkNa/MczJkhMQL46BSpoTtczzD7vk1j4xtzoDyJRI4SRTCXsvcSCw0MnHrLq83K01/bB4Ny3amVK1sT02eGPlP/cMWw5cHi2Qa9EXzE8/8vQxtxQok1Q7DSnXm8nSdcpdiL9U/RS/wH97K3WJK5ZOE94OPJlXJJ0eWJA0XAyuv5uWCjs2EL/gu3FutreOAtzABGG7F8uXZPMoyb/MiPE/req0tydupl4FIrGn4DkiqB/vOu6CBZLGjDj65W47wAToiaynwnJXjV21fnhr6y7fK0RA0Pn0yN7yM+YA0D41F5KFNQfmeKHVPqxKetvoj2S8Gg74Lrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39860400002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2616005)(26005)(6506007)(33964004)(36916002)(6666004)(8676002)(6512007)(31696002)(8936002)(4326008)(5660300002)(6486002)(478600001)(316002)(6636002)(110136005)(66476007)(66556008)(53546011)(66946007)(38100700002)(83380400001)(31686004)(2906002)(41300700001)(4001150100001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1FXZU9Ta2lYYzJxY3pKQWdVOFdReW82MTRGNWdKbHJBdFhTNUJrc1lYOHVZ?=
 =?utf-8?B?bDVuYWJ0bUVJNW9rYkwxd0ovNWs2TnhjOVhaTkttS2lxejN1VEcxWFZiUEpo?=
 =?utf-8?B?NlU1Z1V1WVF4OXRIczhEWW8zVWxpUkJYUGp4UlZEQ2xrSWFqeWpoZ0xmN3FI?=
 =?utf-8?B?VG9jZWFOcmw2ZkZybjBKaVdnZjdya29Oemg2NTZhcGVDMlY1ZkhVclJNOUNC?=
 =?utf-8?B?RmhGWm1EakxJTFhrZ2I3VVFjRm9GWWdjSm0vMWlWZlNVT0NIeVlkQlBWMWJi?=
 =?utf-8?B?Wm9DR3B0RCtmT1hxcnFxMkM0NHg5MENISG13Zk9vVGMzV3haQ0p4RW91Y3FE?=
 =?utf-8?B?UVJDMUp1OHFFeUNETUlHeUdCaUZ4QWpJRVdSK2wrdzlEQmp2SjVqTWhxVXh2?=
 =?utf-8?B?eWFwblcvOGJsK2hBajloUURtc0tBR0wwZTFXVWlLcE5iVEpCTHkzUFFMdzh1?=
 =?utf-8?B?OTFIaW00YkxYdHBzejFZeXFEQjZmZXFhV0VtSEtyNTNsaGFkV2UvZXlpUXdD?=
 =?utf-8?B?YjlBK0tPWXc0bFVJK1duNXdEUDRZcnRtL0VqWGNXV0h3VVA5NUhjS3JiVjlj?=
 =?utf-8?B?QXBGdGNDVWl5QUlYNDFvem5nVGNDRC9veUVkZmpoZFBSYk92ZGQ5WTVnV2cy?=
 =?utf-8?B?NCtaT3NVeXNRSSs1WXRjcjFpM1FiZ0RaQ1kxVExuQXBrK0hhY3FrK3QySzFZ?=
 =?utf-8?B?bk15bzdCL202eEZjUmk4NERNVENxbUxNUW1YaTlNbW10Vk1OUlhsMWNQY1JU?=
 =?utf-8?B?bXJkbmZNWTd1alMyNnZvMXVUS0MzSWszeE5qc3QydWcyTnhEZk05Q1JJZEhr?=
 =?utf-8?B?eEllcGxXWFdkZ1M0dDF2WVZNdTFDaXN3M2xTTzhIbEdwalRTZm91blNxK3U5?=
 =?utf-8?B?N2xtRXByQzREWlpLNUdMaThqMjZWV2FPWElRUXJNM2JVYVdhQ20rbE5yc1By?=
 =?utf-8?B?SnVLS0d5R1NaM1hvOWYxY2JUcGZZVGZUZGI4Sm9zeS85cmxMeVg4WTZiSzNT?=
 =?utf-8?B?WGEvcDEvb0NGVk1LMWRRY1U1c1d1NUNoZHNJMmZDK2V0NWlZQW5RQ09rR1py?=
 =?utf-8?B?UnRCVlQ0V1U2UzJrTjdmSXpYTnEvM2xscDVQc0N0WExBTU9Nck9PNVpWVW41?=
 =?utf-8?B?eFhhaGJrTTE0eEMzNkNpcWl4dmFRdUZpZXBuZFNhTG94STBrOTFQQ1BYZEg3?=
 =?utf-8?B?ZzkyRGdpalZZbkdOYXlTei96UVRibG9XTGVGSWZNWjJkakRFRWx2a3MwK0xV?=
 =?utf-8?B?bjVyVjdmQVJ3SDE5RnRnN2hFekFWam9Hdkp4bHhQTHlnZ0dXMnFoN3VpcVJQ?=
 =?utf-8?B?TGxWaTFZOTUwL3NDVG1uRDdlalVaRmJKZlVLYXlsOXFMakxSY0x4SStuQlJN?=
 =?utf-8?B?MXJhbHVHeTlVTU9rZk83VUxDdWVpbVZoWUpuZFVMejlDdmRqbkJvODJuTXc1?=
 =?utf-8?B?M04xbHlBeVlwWUNCOFViekV5Tk9JNkM1Y1dIK1BLYTBSdFBKV2p0Y2xXSmhu?=
 =?utf-8?B?ZjFPSzJJMGNxZ2M5U1pWQTlQaWR5VWFjcUpUR1B1TGQ5N0pEUzY3MC9BLzZ1?=
 =?utf-8?B?dDEvS0p6OTJEUytpQ05PM200TlJvaWQrVkZWM0JmS0NvbjkraXcyL1huV3o2?=
 =?utf-8?B?UXVRR0lRdlBwMCt0RFVURm1Xb0VQVmpQSWNodVR4RGdEM1AvNy81OVFYc1ds?=
 =?utf-8?B?ZXV3bXhOb2NMQTN2a2g3MjBSY0R6QXRsVGhvUjI0b1VDcGVjbEJsSWRZaXBG?=
 =?utf-8?B?UzJUcVMzTStWcWRnM01XaTBkejgvbFZTOFphTmNyc0xjbm1IYUcvK0ZlRkp5?=
 =?utf-8?B?MkRnRUo3TVVLRXg1MmkvcnI3TmYweFFrRVNGMEc5ZHZaa3Nub1lSa1kvWHFZ?=
 =?utf-8?B?L1RaMHdQWnVmeE11VjJVNUJQNzAvMHpIbmpNWkIvR1NEUXQzYzdpQ1BqbjA4?=
 =?utf-8?B?Zk8vYXRJZDkrT0t6YnNPcW8xcjk3eTRETUFNMEZWZm5PSkwrWmNHeXRIYm90?=
 =?utf-8?B?K2FTR0NzVXpoOG1LOFBORC9NYlI2L2ZXd2xmOFdtanN6d002bnBYR2pmQmJJ?=
 =?utf-8?B?cExTOG5nMnVPckVrK0VEYmNhM1RYREFTYUUyM3YvRTJYRGExanAwL2ZyRDB6?=
 =?utf-8?Q?LHu8a7NgiIrBGf665gaaWY/gC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3517021b-e617-41d9-e4a3-08dbef7d1259
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 19:14:26.2891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeAUG4I4e1dDilApcIrHjcq0LDqRNP2WAgaQzWcOuu2wlY1sQ56hbm4IPz7P6oOf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------d4wZMwdoXy7Hw6ac8MtC70qH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2023-11-27 14:11, Alex Deucher wrote:
> On Fri, Nov 3, 2023 at 9:22 AM James Zhu<James.Zhu@amd.com>  wrote:
>> From: David Yat Sin<david.yatsin@amd.com>
>>
>> Add pc sampling support in kfd_ioctl.
>>
>> Co-developed-by: James Zhu<James.Zhu@amd.com>
>> Signed-off-by: James Zhu<James.Zhu@amd.com>
>> Signed-off-by: David Yat Sin<david.yatsin@amd.com>
> For any new IOCTL interfaces, please provide a link to the user mode
> code branch which uses it in the patch description.
[JZ] will add, Thanks!
> Thanks,
>
> Alex
>
>> ---
>>   include/uapi/linux/kfd_ioctl.h | 57 +++++++++++++++++++++++++++++++++-
>>   1 file changed, 56 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
>> index f0ed68974c54..5202e29c9560 100644
>> --- a/include/uapi/linux/kfd_ioctl.h
>> +++ b/include/uapi/linux/kfd_ioctl.h
>> @@ -1446,6 +1446,58 @@ struct kfd_ioctl_dbg_trap_args {
>>          };
>>   };
>>
>> +/**
>> + * kfd_ioctl_pc_sample_op - PC Sampling ioctl operations
>> + *
>> + * @KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES: Query device PC Sampling capabilities
>> + * @KFD_IOCTL_PCS_OP_CREATE:             Register this process with a per-device PC sampler instance
>> + * @KFD_IOCTL_PCS_OP_DESTROY:            Unregister from a previously registered PC sampler instance
>> + * @KFD_IOCTL_PCS_OP_START:              Process begins taking samples from a previously registered PC sampler instance
>> + * @KFD_IOCTL_PCS_OP_STOP:               Process stops taking samples from a previously registered PC sampler instance
>> + */
>> +enum kfd_ioctl_pc_sample_op {
>> +       KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES,
>> +       KFD_IOCTL_PCS_OP_CREATE,
>> +       KFD_IOCTL_PCS_OP_DESTROY,
>> +       KFD_IOCTL_PCS_OP_START,
>> +       KFD_IOCTL_PCS_OP_STOP,
>> +};
>> +
>> +/* Values have to be a power of 2*/
>> +#define KFD_IOCTL_PCS_FLAG_POWER_OF_2 0x00000001
>> +
>> +enum kfd_ioctl_pc_sample_method {
>> +       KFD_IOCTL_PCS_METHOD_HOSTTRAP = 1,
>> +       KFD_IOCTL_PCS_METHOD_STOCHASTIC,
>> +};
>> +
>> +enum kfd_ioctl_pc_sample_type {
>> +       KFD_IOCTL_PCS_TYPE_TIME_US,
>> +       KFD_IOCTL_PCS_TYPE_CLOCK_CYCLES,
>> +       KFD_IOCTL_PCS_TYPE_INSTRUCTIONS
>> +};
>> +
>> +struct kfd_pc_sample_info {
>> +       __u64 value;         /* [IN] if PCS_TYPE_INTERVAL_US: sample interval in us
>> +                             * if PCS_TYPE_CLOCK_CYCLES: sample interval in graphics core clk cycles
>> +                             * if PCS_TYPE_INSTRUCTIONS: sample interval in instructions issued by
>> +                             * graphics compute units
>> +                             */
>> +       __u64 value_min;     /* [OUT] */
>> +       __u64 value_max;     /* [OUT] */
>> +       __u64 flags;         /* [OUT] indicate potential restrictions e.g FLAG_POWER_OF_2 */
>> +       __u32 method;        /* [IN/OUT] kfd_ioctl_pc_sample_method */
>> +       __u32 type;          /* [IN/OUT] kfd_ioctl_pc_sample_type */
>> +};
>> +
>> +struct kfd_ioctl_pc_sample_args {
>> +       __u64 sample_info_ptr;   /* array of kfd_pc_sample_info */
>> +       __u32 num_sample_info;
>> +       __u32 op;                /* kfd_ioctl_pc_sample_op */
>> +       __u32 gpu_id;
>> +       __u32 trace_id;
>> +};
>> +
>>   #define AMDKFD_IOCTL_BASE 'K'
>>   #define AMDKFD_IO(nr)                  _IO(AMDKFD_IOCTL_BASE, nr)
>>   #define AMDKFD_IOR(nr, type)           _IOR(AMDKFD_IOCTL_BASE, nr, type)
>> @@ -1566,7 +1618,10 @@ struct kfd_ioctl_dbg_trap_args {
>>   #define AMDKFD_IOC_DBG_TRAP                    \
>>                  AMDKFD_IOWR(0x26, struct kfd_ioctl_dbg_trap_args)
>>
>> +#define AMDKFD_IOC_PC_SAMPLE           \
>> +               AMDKFD_IOWR(0x27, struct kfd_ioctl_pc_sample_args)
>> +
>>   #define AMDKFD_COMMAND_START           0x01
>> -#define AMDKFD_COMMAND_END             0x27
>> +#define AMDKFD_COMMAND_END             0x28
>>
>>   #endif
>> --
>> 2.25.1
>>
--------------d4wZMwdoXy7Hw6ac8MtC70qH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-11-27 14:11, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_MyXm+G3n=n9o8NJiHR9BtFZkN9+FSS1r3MkUvaPnzh7g@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Fri, Nov 3, 2023 at 9:22 AM James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
From: David Yat Sin <a class="moz-txt-link-rfc2396E" href="mailto:david.yatsin@amd.com">&lt;david.yatsin@amd.com&gt;</a>

Add pc sampling support in kfd_ioctl.

Co-developed-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Signed-off-by: David Yat Sin <a class="moz-txt-link-rfc2396E" href="mailto:david.yatsin@amd.com">&lt;david.yatsin@amd.com&gt;</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
For any new IOCTL interfaces, please provide a link to the user mode
code branch which uses it in the patch description.
</pre>
    </blockquote>
    <span style="white-space: pre-wrap">[JZ] will add, Thanks!</span><br>
    <blockquote type="cite" cite="mid:CADnq5_MyXm+G3n=n9o8NJiHR9BtFZkN9+FSS1r3MkUvaPnzh7g@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">
Thanks,

Alex

</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:CADnq5_MyXm+G3n=n9o8NJiHR9BtFZkN9+FSS1r3MkUvaPnzh7g@mail.gmail.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">---
 include/uapi/linux/kfd_ioctl.h | 57 +++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index f0ed68974c54..5202e29c9560 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1446,6 +1446,58 @@ struct kfd_ioctl_dbg_trap_args {
        };
 };

+/**
+ * kfd_ioctl_pc_sample_op - PC Sampling ioctl operations
+ *
+ * @KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES: Query device PC Sampling capabilities
+ * @KFD_IOCTL_PCS_OP_CREATE:             Register this process with a per-device PC sampler instance
+ * @KFD_IOCTL_PCS_OP_DESTROY:            Unregister from a previously registered PC sampler instance
+ * @KFD_IOCTL_PCS_OP_START:              Process begins taking samples from a previously registered PC sampler instance
+ * @KFD_IOCTL_PCS_OP_STOP:               Process stops taking samples from a previously registered PC sampler instance
+ */
+enum kfd_ioctl_pc_sample_op {
+       KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES,
+       KFD_IOCTL_PCS_OP_CREATE,
+       KFD_IOCTL_PCS_OP_DESTROY,
+       KFD_IOCTL_PCS_OP_START,
+       KFD_IOCTL_PCS_OP_STOP,
+};
+
+/* Values have to be a power of 2*/
+#define KFD_IOCTL_PCS_FLAG_POWER_OF_2 0x00000001
+
+enum kfd_ioctl_pc_sample_method {
+       KFD_IOCTL_PCS_METHOD_HOSTTRAP = 1,
+       KFD_IOCTL_PCS_METHOD_STOCHASTIC,
+};
+
+enum kfd_ioctl_pc_sample_type {
+       KFD_IOCTL_PCS_TYPE_TIME_US,
+       KFD_IOCTL_PCS_TYPE_CLOCK_CYCLES,
+       KFD_IOCTL_PCS_TYPE_INSTRUCTIONS
+};
+
+struct kfd_pc_sample_info {
+       __u64 value;         /* [IN] if PCS_TYPE_INTERVAL_US: sample interval in us
+                             * if PCS_TYPE_CLOCK_CYCLES: sample interval in graphics core clk cycles
+                             * if PCS_TYPE_INSTRUCTIONS: sample interval in instructions issued by
+                             * graphics compute units
+                             */
+       __u64 value_min;     /* [OUT] */
+       __u64 value_max;     /* [OUT] */
+       __u64 flags;         /* [OUT] indicate potential restrictions e.g FLAG_POWER_OF_2 */
+       __u32 method;        /* [IN/OUT] kfd_ioctl_pc_sample_method */
+       __u32 type;          /* [IN/OUT] kfd_ioctl_pc_sample_type */
+};
+
+struct kfd_ioctl_pc_sample_args {
+       __u64 sample_info_ptr;   /* array of kfd_pc_sample_info */
+       __u32 num_sample_info;
+       __u32 op;                /* kfd_ioctl_pc_sample_op */
+       __u32 gpu_id;
+       __u32 trace_id;
+};
+
 #define AMDKFD_IOCTL_BASE 'K'
 #define AMDKFD_IO(nr)                  _IO(AMDKFD_IOCTL_BASE, nr)
 #define AMDKFD_IOR(nr, type)           _IOR(AMDKFD_IOCTL_BASE, nr, type)
@@ -1566,7 +1618,10 @@ struct kfd_ioctl_dbg_trap_args {
 #define AMDKFD_IOC_DBG_TRAP                    \
                AMDKFD_IOWR(0x26, struct kfd_ioctl_dbg_trap_args)

+#define AMDKFD_IOC_PC_SAMPLE           \
+               AMDKFD_IOWR(0x27, struct kfd_ioctl_pc_sample_args)
+
 #define AMDKFD_COMMAND_START           0x01
-#define AMDKFD_COMMAND_END             0x27
+#define AMDKFD_COMMAND_END             0x28

 #endif
--
2.25.1

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------d4wZMwdoXy7Hw6ac8MtC70qH--
