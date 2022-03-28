Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585C2C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 10:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8D5E899D6;
	Mon, 28 Mar 2022 10:11:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6783310E59B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 10:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBhU0GKKgqj/+5gr1bZUF9FF4+Ekuv3kPm4m9jnq3psHzdq17LJEqcO9t1SpRbTEnU+Q6nH7MVAnBXJnh1GI4WVkjoNL9H1dW6IX2K0m4q4nf7bTayYprKbv8v0Ti0MgZwHAEnBl2m718mtHGvwbkTMb4QKlUpLTq04fijN43rc8mhP2oW3aeN83qsp+NGqTmO4bt4C0LMHGwQquDlwgIXzRVdiYdN5GRYK7gKnZPJ4WcITSxln3ztwLGn82Nd9JhFUyb8JzpJMsO6YPqFHsLTAyHaIN/CuoGhLxp0loryMo2xnopi0UT7l2VqyJykKSiIiKMvGGe5Ge0EyVKGXQnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNu3mBAvqb1gK08KyQIxhUF9YonEGaZ5aNwNqDRbnaw=;
 b=XVgQExILxhIclPlpN1o4XqFMzTWGz4yFHnTtd7hziqYd1V2PMvL/vd9cwPvjDKTNws6SSpRHXaw+zu2mFfUG9EZgwB6r9b1InaSS4l8LM6+cGFYHgSERxVw8hC27C0OGZ5EFNMT7XJNrh+F3AivMER38fZ5WPligUNF0NWFiMu+xClm8yHrKeLPftg3f5vnp0bE2u2NjPBauNUU9Z9Agz5eezwyBmlHH+RkHK8+KY3GL1BczDfwsave6DtEDYe5dLH6CwgVQ5J4I8Z5gzdmkwpCjNYbH30F4c6NHf8pJib+t/kacV3NEOsWSicBlgFH0wSCV5/u5BiTqlOdrQ0l4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNu3mBAvqb1gK08KyQIxhUF9YonEGaZ5aNwNqDRbnaw=;
 b=b3cAfrt4fhZ/04/JkydQMRwVHvZr05o84USd+eUT+AGI7CxzQDoXyPo/j8KRFRjOdjCUfiknQbritvOLNw7zydShN8Kx5F4bD2CKMTeotv5KRwdpvC6EFCu8Koqhh6zrwvsMFJCrKOR5XaoeoAHmDp99BAmvUXttE1fc46a98lg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BYAPR12MB3591.namprd12.prod.outlook.com (2603:10b6:a03:dd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 10:11:33 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06%5]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 10:11:33 +0000
Message-ID: <7e5cba64-52ac-5c82-8551-3294d92eb36a@amd.com>
Date: Mon, 28 Mar 2022 15:41:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v4 5/6] drm/amdgpu/vcn: VCN ras error query support
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>,
 Tao Zhou <Tao.Zhou1@amd.com>
References: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
 <20220328062453.4156191-6-Mohammadzafar.ziya@amd.com>
 <DM5PR12MB17706851354758760795883DB01D9@DM5PR12MB1770.namprd12.prod.outlook.com>
 <3c80e4e5-97fc-9222-d9a3-f676125b0f5c@molgen.mpg.de>
 <PH0PR12MB545100117A4F02A2C98BCE0E981D9@PH0PR12MB5451.namprd12.prod.outlook.com>
 <92b220d2-1d1b-c673-f9f9-3636dc1ba804@molgen.mpg.de>
 <PH0PR12MB54519484FA4DFFBF63B0AE3C981D9@PH0PR12MB5451.namprd12.prod.outlook.com>
 <0fe2edfd-b9ba-fa08-17fb-ebbf678b1b51@molgen.mpg.de>
 <PH0PR12MB54514F94A327C6A5E12BEE67981D9@PH0PR12MB5451.namprd12.prod.outlook.com>
 <096971c4-6d7f-57bc-0dcc-9fd5f815d89f@molgen.mpg.de>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <096971c4-6d7f-57bc-0dcc-9fd5f815d89f@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0134.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::22) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 531263ec-76e2-4cb8-d272-08da10a35593
X-MS-TrafficTypeDiagnostic: BYAPR12MB3591:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3591F2D48B46B971C03FCEAE971D9@BYAPR12MB3591.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8uIYla6HllmihAocxxxU6MQpRWimd+QDC+6ZYU05INymEykZJAp+isPI4vyXMAllzh1JG5ny0kJMVJiCwT4tCl6B1hnfbM1v5uVB5/rXzhyg6/kEOC44HLLPRtrffrj/pQ+Hw0YHKW6CEp7p5Dfdd89gkT/e18QfeTwONXT7RaMh646/XgPM+1Z+YMuqAinHTY0FdQB437r6dYydboLrkHt+43UmrBKJMWw0+rpeJDuryPoonI5GhXoiq3CmXPXmo1xklLBllI5M4IAsgDIDSEhbJvC9pYCRk6pqL4tZ43/vs8UptE/6sFGmSg7+bcnG92INmy62XH3gTrnK3/wdvcL8vivNUwKGwpuT10WxsR7cIcay1bQB/b5tjhZY3NYsU5HwYi65a90ywDNt6qTpo0Lz9+qKshL4hbn12qlm/aKPzcBS3bAPuO7bOFoxZQNL4QqFcsYNDRYx8yns8kp91vmkGbuhKrUDNgk5VPkGSe4Ml3LwEeZHUsKIpo6MPueI1eGWd3oI/7hXsh1A2MJkwIbpeWVo7PjcTuKZr2noTFi6WIpPTSA8HvyvhjuPEsegb7PnF1muvVi1dYBRRLGkidQieOFTMS/KOR2MPvgp5j/L63feJUdN27aBldbOP9RHFuObMn5KlHS2EVEKyuAtITUSgb/oejIzEtJ1qPqDEWHiLhNXl3tGocI4IIsPtp9/ox9Xaed0ZchjlDYDGMKGviD9Ii6RdEuv/K8E+LgMfA24gNDN7Cm0K7Bp7sYPaeS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(6512007)(8676002)(6506007)(66476007)(31686004)(4326008)(110136005)(31696002)(316002)(66556008)(6486002)(508600001)(6666004)(66946007)(6636002)(53546011)(83380400001)(26005)(86362001)(38100700002)(5660300002)(186003)(36756003)(2906002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3ptQVpVUEZOQytmN25DK1R3TnJTWTNPN1JGcWE4RGxwYWUzK0RFSERva3ll?=
 =?utf-8?B?ZGgxWjhPT1NuNnR4ZzkrN2RHY25mcEdDN1lZOXpyTUJTQkoxUVA1NnV0ZDBi?=
 =?utf-8?B?dkVnL2lhdjBkb3cxbGdMbmRQekpBRUxkVSt0MEIwUDFPNkRTL3ZSY1ExR0F3?=
 =?utf-8?B?cjJuTHcwckRxbDluS1hacjBpcUNtUEU5UXA1SGJvdUQvZjF2bzVHY2J4NDdT?=
 =?utf-8?B?KzkzTGxKWjNhMlpia09WZWJqeWF1VXY2aHo3dWVNZk16K1hoWXpTTVBudnh5?=
 =?utf-8?B?RGtWSTNTbFRCOFlFK3lwMGs5SHVFNkZIQnJGbmJ2d0psYTJWMUU4UTkvMXRV?=
 =?utf-8?B?LzZQK2M4dkVQV21OK0JQVVYwdXQ1VWh6RmZEZWxsWkNiTWt2RHR1dVJVUHlx?=
 =?utf-8?B?Q1RtMUFxVVVaVk9CdDZYRjhMQmQ0QXZ1Y09Dcm9OZ2pBNmhFU0FZeVVuMytF?=
 =?utf-8?B?RW9KcHNRV3RKTXgvTCs0MDQwTjc5NnhNbFBCUmZZaHlvZFMzcVhKZGtWdFpP?=
 =?utf-8?B?UjZwbW9WQjZqTUpobytQaG1Pa3ZGUGhwZGFzUHFVdG9rL1JpSGZZangxeFZ6?=
 =?utf-8?B?UG8yelFVYlQzd1pDeWk1RHRYdkFGMnJ5VXRJTTlLN3FOZTUzMC9KNzZQQUwv?=
 =?utf-8?B?bmxhbFB1MnB1eDVTU0VHQW40Q3FiR09lREVDRm5xREhJOU0yZ2wxd1h3NnZh?=
 =?utf-8?B?QmQ1Vk9ITkxBZHdqajVSWlg3RmprdlRaNktnaC9kMVVCVGo0T2tLeXZWTU90?=
 =?utf-8?B?WE1jYjVBQk1aTUErMGRsU3c4Uk9PUlhwNHR4UlNKZkN5ZERSRGpJenh0MmRN?=
 =?utf-8?B?STZ5RW5rbmhSbklJWlZpMVg5ZXdjOU1aajN5TzF4VFVIb1FSeFlPWmp4YnBS?=
 =?utf-8?B?U3FXblBxR2J3d1ZFMzZxcXFZNklzL3J0TFkwUWdYcUhtOHRTS2NTRE1yRk04?=
 =?utf-8?B?OStaTkhDaExqNGsrdGNySW5QOVh2VFZnb3k3SXRBSjN2YVd3Y1FEMUw1M09B?=
 =?utf-8?B?UlVPV2dxYnpKWlFCOGNnSlh5L0E2eitpN2pUYUs4aWlsVkZVTE1UU25tQkxX?=
 =?utf-8?B?UmNGOEFsOGQ1RTAyUjI0V2hNaVg5bU41cGRNQS81LzV3VDBxS0x0WmwwR1ZX?=
 =?utf-8?B?MGdJUmxxYy8vV0ROOHd1YXFhdmQ3cjVvc2svQmNEQkh1RHZXWE5QMHBZQ0dy?=
 =?utf-8?B?Z2Nndk85WVFlVDFUUVdjRDV6NjFwQjN5RTNLc1oyOUxHQjYxbjQ2U09TUnZB?=
 =?utf-8?B?Y2pmUE1Oa1JPODVwTktFT21ZNnROZmlXbWpUNXdjVkdWV3hSTHJ4YThwK1NF?=
 =?utf-8?B?N3RQN1lSOWxqTGVrNGtOUmpUMGdJVkxkakNXdjR2OWE0UHFGbEZFR01lZ3Jo?=
 =?utf-8?B?V2RwY1lGVDhEbVB0THZmY2lCMTBaMmdsbktGcTBlRE15NzJRQnBPT1p3WS91?=
 =?utf-8?B?ZHNIWHN6TXpiMEFkMm9ZRWI2cEx2TzF1NlR4Z1VUQi9KOCtXcHRWTXltUG5w?=
 =?utf-8?B?QlF0R0ttVWZXVU5yNjlxbEd5UmhsdlR0YmdVSXQwQ21DQWFhQS9Tay8rbUFM?=
 =?utf-8?B?Zk8yc3pCanBQU3pEbFdzVWZUTER6S2p3M1JPL1d6dE5NRlBmRkZOYXl0YjZw?=
 =?utf-8?B?d0h4UGZpZndBQ1BCMUtKNXJIVTBnNEVSazdua2wzVmtxdzBHazZXZWZscjF2?=
 =?utf-8?B?S3Q2R29VaUQxMXRCRjJFTWRKMEhoQTg4YWkyakdGS2pGaGxjdHNNSHlmUTlC?=
 =?utf-8?B?Y0FOTWptWUozZFBoeTdySXh0R0dRNXZIVVRVczk4S21qYjVBOTZWZ0lveHVE?=
 =?utf-8?B?RDNpN2I4a0wwZ3lGRnNsYlljM050WkFib0E3OTdDeVgwcE82U3BHd0NudGww?=
 =?utf-8?B?RlZ6V2F0eE0xeVc5NWhzeTZLVDFmeGtlbEx1WHdoQkpUVFVUd3Q5bFVmK0E0?=
 =?utf-8?B?SW52MjZUK1hKNENCOE1vcC9xOWh0ck9xZ0Y0SnhkZmpscWZaWHQ2VVVpbVc5?=
 =?utf-8?B?b2NUbUxObHdvMGJXaHd1QzhTc01pV081c2dhcnI2NExoUE9WSHVaWllnRVdu?=
 =?utf-8?B?NlZYOGNDSE4reWJxVmRDT3J2WTRMUGdzQllmNG5tY3R3dDRNUldpdFdDa2Rs?=
 =?utf-8?B?RVF3dEFvajd4VHNEdUVDOE9tNStzTXpZcGs1NWszdXBUK1FMY2F3NUVub0dF?=
 =?utf-8?B?eWQ0NzM0QnVCRnA4WitCdTFZWHp4akt6MHY4WDY3ajdEbFN0UFB2bDBFWVpC?=
 =?utf-8?B?TVNQcG1PcWRnQXFzbUZwNlJqNTZNNzBqNGV1TG5paHhIa0E3b3ppU1ZjMFVr?=
 =?utf-8?B?eDNzRWdaVFZNdlBLZDhyeDlHT1g0d2x2MEV3V0hMYml0Q0gvTHhnUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531263ec-76e2-4cb8-d272-08da10a35593
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 10:11:33.2185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58Trd9Uu57PaoEVFPe5+dDjyiEmRRO9foxRz2OucUgUtLKDgjvgiUvYg41NUaZaj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3591
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
Cc: amd-gfx@lists.freedesktop.org, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/28/2022 3:25 PM, Paul Menzel wrote:
> Dear Mohammad,
> 
> 
> Am 28.03.22 um 11:49 schrieb Ziya, Mohammad zafar:
> 
>>> -----Original Message-----
>>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>>> Sent: Monday, March 28, 2022 3:08 PM
> 
>>> Am 28.03.22 um 10:47 schrieb Ziya, Mohammad zafar:
>>>
>>> […]
>>>
>>>>> -----Original Message-----
>>>>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>>>>> Sent: Monday, March 28, 2022 1:39 PM
>>>
>>>>> Am 28.03.22 um 10:00 schrieb Ziya, Mohammad zafar:
>>>>>
>>>>> […]
>>>>>
>>>>>>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>>>>>>> Sent: Monday, March 28, 2022 1:22 PM
>>>
>>>>>>> Am 28.03.22 um 09:43 schrieb Zhou1, Tao:
>>>>>>>> -----Original Message-----
>>>>>>>> From: Ziya, Mohammad zafar <Mohammadzafar.Ziya@amd.com>
>>>>>>>> Sent: Monday, March 28, 2022 2:25 PM
>>>>>
>>>>> […]
>>>>>
>>>>>>>> +static uint32_t vcn_v2_6_query_poison_by_instance(struct 
>>>>>>>> amdgpu_device *adev,
>>>>>>>> +            uint32_t instance, uint32_t sub_block) {
>>>>>>>> +    uint32_t poison_stat = 0, reg_value = 0;
>>>>>>>> +
>>>>>>>> +    switch (sub_block) {
>>>>>>>> +    case AMDGPU_VCN_V2_6_VCPU_VCODEC:
>>>>>>>> +        reg_value = RREG32_SOC15(VCN, instance, 
>>>>>>>> mmUVD_RAS_VCPU_VCODEC_STATUS);
>>>>>>>> +        poison_stat = REG_GET_FIELD(reg_value, 
>>>>>>>> UVD_RAS_VCPU_VCODEC_STATUS, POISONED_PF);
>>>>>>>> +        break;
>>>>>>>> +    default:
>>>>>>>> +        break;
>>>>>>>> +    };
>>>>>>>> +
>>>>>>>> +    if (poison_stat)
>>>>>>>> +        dev_info(adev->dev, "Poison detected in VCN%d, 
>>>>>>>> sub_block%d\n",
>>>>>>>> +            instance, sub_block);
>>>>>>>
>>>>>>> What should a user do with that information? Faulty hardware, …?
>>>>>>
>>>>>> [Mohammad]: This message will help to identify the faulty hardware,
>>>>>> the hardware ID will also log along with poison, help to identify
>>>>>> among multiple hardware installed on the system.
>>>>>
>>>>> Thank you for clarifying. If it’s indeed faulty hardware, should the
>>>>> log level be increased to be an error? Keep in mind, that normal
>>>>> ignorant users (like me) are reading the message, and it’d be great
>>>>> to guide them a little. They do not know what “Poison“ means I 
>>>>> guess. Maybe:
>>>>>
>>>>> A hardware corruption was found indicating the device might be faulty.
>>>>> (Poison detected in VCN%d, sub_block%d)\n
>>>>>
>>>>> (Keep in mind, I do not know anything about RAS.)
>>>>
>>>> [Mohammad]: It is an error condition, but this is just an information
>>>> message which could have been ignored as well because VCN just
>>>> consumed the poison, not created.
>>>
>>> Sorry, I have never seen these message in `dmesg`, so could you give an
>>> example log please, what the user would see?
>>>
>>
>> [Mohammad]: [  231.181316] amdgpu 0000:8a:00.0: amdgpu: Poison 
>> detected in VCN0, sub_block0
>>
>> Sample message from amdgpu " [  237.013029] amdgpu 0000:8a:00.0: 
>> amdgpu: HDCP: optional hdcp ta ucode is not available "
> 
> Hmm, that is six seconds later, so, if Linux logs other stuff in 
> between, no idea if the connection will be made.
> 
> Both messages read like debug message, with normal users not having a 
> clue what to do. Can that be improved by rewording them?
> 

Hi Paul,

In general, when this is detected there will be a subsequent recovery 
action done by amdgpu. The above message is mainly to identify why the 
recovery action happened. The steps to be done for recovery is a 
"work-in-progress".

The occurrence of such a thing is expected to be rare and a general user 
doesn't need to do anything on seeing this. If at all something really 
unexpected happens during such rare cases, this message in dmesg helps 
to identify what happened and whether proper action is taken by the driver.

Thanks,
Lijo

> 
> Kind regards,
> 
> Paul
