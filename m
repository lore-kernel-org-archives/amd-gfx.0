Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADFCC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 07:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE9EB10E747;
	Thu, 10 Feb 2022 07:38:32 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 701AD10E747
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 07:38:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuLeiIQ/2eb+K47S+mYlnFL1n3ztxsYpt670Mvj524cKZ3hbAUgCFp74PABY3toeNRQDvlnSzFi4ejbnj5LSREVzGA66RxgJWr5Vtid7B2GOu4PzH6+sp8WxzMELHWADyxK8bymMZjHHjpqP3IoNaIVcVEKyJJ+mtxLF3MGIU2pV2GoeDsqGiCZMUV9SjIypPF31SrE5mvGBI1meRUI9pCJTDtTWSW4GlG0ekq4xnew68dVJ4f2k8rrEBhGk7aKFzNMpyCI3QMzCnDraiQd1KQc7FOTkFrzoz8OrJeUakTLW4LyNo3vaVj6pZG6xtVFm7t5g0+IB4fD9l4HlHgNqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZKJnGkEKnllPGVeRU4AL5g3gwYmhs82bhvwsGGtGTk=;
 b=fngQjmjSWzH9JhcmuGQvuO/SUEdDDD0hucr76hAzxz5BHcJc3QTSnzdiwNBMCgnQaRhELCE3N/CXIiqPEX5cIG0aZ94ENI41BN74VcIGKicLvbXp6rL73s3+FMngVzcNqqLrURFXAkHTniTw1Uwx3YVmFeTe4Pg32sovVDnQHhKj2kVfDhVDfc6JbnsoceTPYt4RJDqYHPMBTXIJR35VxrafPdqv/b+szoJoGTQsPweQJRaIrSqswjYCQpONpkEIl0RQaL1/VGzUHHUFjvSeUJKaKZ1PgMCDWk5Ptt+i2YoQWPCdnnzmTJbwbujadd6/qmh0NDJ/dm37hFveW3xjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZKJnGkEKnllPGVeRU4AL5g3gwYmhs82bhvwsGGtGTk=;
 b=ZvOgCFuU7jTT+oLowTTNaFobBWiDxUFaHk9IAVEgWxcq8yrVHb4y6cS0y/chiXgwIDVGbocdtZWbiD+OD+MlFc+mfLg23BNCn2c4IeU2OB/vT4/YJambC1svHtqHcMkhPQGkqQGehdZnOWrh5ynnVmuFzJEc8UiXbLmTRNGNgTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN6PR12MB1889.namprd12.prod.outlook.com (2603:10b6:404:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 07:38:28 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3%3]) with mapi id 15.20.4975.012; Thu, 10 Feb 2022
 07:38:28 +0000
Message-ID: <d2a93513-c199-c4f4-7564-da58f3bb2120@amd.com>
Date: Thu, 10 Feb 2022 08:38:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: add reset register trace function on GPU
 reset
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
References: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
 <20220208081647.3025-2-Amaranath.Somalapuram@amd.com>
 <CADnq5_Pun3UPKJsTKEf4pu3R=UbbHAZDW5-=+pekTDx4TWsAEw@mail.gmail.com>
 <6a7ca5ae-6d78-b8fd-cba8-cd2dca4418f4@amd.com>
 <49e24f9f-4657-d3ce-e84e-abbaa56d3181@amd.com>
 <1b79efe6-20e9-5543-4b2e-fa09f97c8e9a@amd.com>
 <01cbfbe8-c08a-e7a8-7e23-bc1ccc5c32f1@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <01cbfbe8-c08a-e7a8-7e23-bc1ccc5c32f1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR1001CA0032.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::45) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0546f16-f3c0-4c27-989b-08d9ec6853d4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1889:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB188900C9D176C4A08278DDE9832F9@BN6PR12MB1889.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kNszxuc047vFYTq5AQ21fouDO1osCu1j5L9hy7mEOz5rxpSBUMOkr6MMrqd9wQKsxYoh6Wi/7I06UwyNDKr48WLypeuJvnjeWPPdPdibf1jkBBWKB/P3OxE3L5rbWQ2KW7eS96x6+Bh71Q3OWSgWAs1HNwILhPAiaq8VZFHKtfYNDlj3Yeb8N+R/401ExpXwy8H0UE4njCRT4XLW4wmxXpvOM004nU2/0i/GaxYyuAqjjb+T2FZhnIYP8a15gK/WwTnoEdGRjoPbD3XWo2IvQQYH9XpNZoEmj1MYRIB7XndGV/lMsQ/BE+9QxP9oIBVA2inG1+wGjpa0CarFr0cpvl7vPc+V5kJ1yTg2N9XkP4SiaMMsrFvBMDr3RnlQBV52zfwypP6SnzO9QxDgsPoZD5N02tf/2DjM9svnOI81d1N9URwO8wrmBJ2DmkWCReB9IU3uW3MRZ7H0ItX3Or4s0JdWQwbOHhrsj8e2jQwYe30gVqhQVw5qqPU3/5yTrKy+dMsNd8wLMXxYKpB19CscrZAZrO7u6zaNh8oScZSWgSb4pgO5KouORGDe8Hu3GaRVZ1OQhQ5JAEHE8r6WxADPEJeIiAS7WS14JjwTYO5oA5MDo5+cuvyh75kQbWI8GUasl4fE2r7q8Npi8XOq4TDpNCeAEUfHiF/U10hO/JrvmLo4+Cj+XOnZ7Ag88zI4G9M40CzrwQJudUQ6nmZgQAcE84vBl6WYg+CpgHnq5y2WpM8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(4326008)(66476007)(53546011)(86362001)(66574015)(8676002)(6666004)(31696002)(8936002)(6506007)(66946007)(83380400001)(66556008)(508600001)(38100700002)(5660300002)(26005)(186003)(36756003)(2906002)(54906003)(110136005)(6486002)(6636002)(2616005)(6512007)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym41c01oZUc0UU11b2wvbi91aU45elRJVDhJdVdqc3l1THQvOEVyUmRDejNL?=
 =?utf-8?B?OFVkTkJyZUZDbjZveUluUW5ncEpEOTFHVFpoMDBXU1M2ek41OHltODc1cnlx?=
 =?utf-8?B?bThUMGs1OWRMOGxraStveE0xQllDekY4UFpzN3lJY3NqcDEyOW9wR2ErcFB0?=
 =?utf-8?B?dXhHZkRmSlAzMXBwRjNkR2xTMDlXRTU2M3NtZmM1cmxqcisxRnlhMTlpT3Fh?=
 =?utf-8?B?WTdMWFY0RmlqMU9FYmwzdWRNTzJ2aXI1R2hvbkdid3V6VjdLcSs0K2VuK1BJ?=
 =?utf-8?B?QVloL2xQZDJWWm4wSjV6Z3dYdnFsMEhDNUI1anJBYWJHWHVWS1ByLzBwcVpT?=
 =?utf-8?B?amZFWFF1alptUWJKMjQ4NmphcHAwK0JvempuMEh0SzlIS2lNR00rZitSeEtO?=
 =?utf-8?B?alhwdVBUY0J4UzkrVUZEdlp1enRrSzBDRVByNFlMeU44SzlxQ0xEcmNoTVZJ?=
 =?utf-8?B?dUd6K2lnd3dzUGFLUTJFVjMyR1kwRnkrOEJkZUE1SzBWZHViNHFvSWdCWjNs?=
 =?utf-8?B?MDdSVThIbU0rZk1ZRHBLNW53Skl2VVVwWDdDOVhEeUFIbFhGSzV1UzRsWW96?=
 =?utf-8?B?NDZBWUZ2ZlgvczNqLzN3Q1JiV3EwSERMc2JLTkoweGZPN0JHdUdaZkJEWHF4?=
 =?utf-8?B?STBxb2U5dnhMeGpndFRZWk5UREZKeWg5bnNyaUIzMW9zcHZEOWl6SDB4QXpp?=
 =?utf-8?B?aVZXVkJjOVJGbFM3bmJqWFRYM29ld3NXTUN1VEVkQ1NESmVJeXhlTk8xL2ZC?=
 =?utf-8?B?bTJjMU9IbExMYmlibndQRTBJNXMxTU9wU1V4SlhNRXBpSUVjcHlTQlJiTjBy?=
 =?utf-8?B?cERoUGFMcGlybHNncGtWam9QalJSczRpbi9Vby9xY3hpOE9mN3o3bnIwWlA3?=
 =?utf-8?B?dnRwMTF4T2lqcnhUeDBCM2h3VTZ0MjBzQ1gvM0IrekVFdklycEdPdjhQbzJU?=
 =?utf-8?B?UDVQTXJKbk9IaFg0ZFFOaWFJdHdDVGFYYVk1ZVUzZTRVV0Q4RVpmaWJLZ2FR?=
 =?utf-8?B?UjFQMnM1em5YM0JRVlpzY1lJcnczd0Q5ek4wblpXZS9HVzhuamp3MWFMRFV5?=
 =?utf-8?B?NnN1N3F3SlQ5aXFQOWVEek5uRVozUnU4QWFjQ2liYW4xK0hMVjhIZ3N0MEZU?=
 =?utf-8?B?b0JqOVNITVkvQTdIZVlHSVBvbko2dWxHTVNSM084aTl4dHFveDUxUXl4U2dk?=
 =?utf-8?B?Q1ZlZ210ZHgxd0x2Q2xVamR5QUxmOUtIVHRxTEh4NnRxdTdnRnVDMjhnTEdZ?=
 =?utf-8?B?blA3T0Y2aGs0eVdxUTdGZlBMRlBtNFp0M01lTmMyaHhYdzhhWEFta2lIQzNU?=
 =?utf-8?B?L1JDdXNwRmc2NGZlYVEzcEs2ZXZldWpNZGVYV0RJNHhsVVFEakFhQy9hdU4y?=
 =?utf-8?B?V090RHcwQk5USHdrMEdrWnZodzhISlBZWHo0VWxoOHo3MmFzZ3FkWDh5em1M?=
 =?utf-8?B?MEo4WFFUODIxUFQ0bVRwREg4QTdndUxMM2NCeVMrcnd4M0VEeWF4K1hkWVpJ?=
 =?utf-8?B?S0NQaHBIOFJHVVFrNmJ6ODVMdW9Pc1dqYkN6b2RSMnlkaWJJWVZEaFlYcjV6?=
 =?utf-8?B?U0J3TVMrdnNieWJmQ0JhbjFDQ1kyRGczRFYveENsTmc3SFlFdXN0U0pQRjR6?=
 =?utf-8?B?L3ZBREN0cmdOOTlDcVYzUEg5OERjZ2RMNXNFWjFzY0I0NzF5cjRDWEpnRVpq?=
 =?utf-8?B?R2FXS3hLa1FkQmtrRGZxL1U3T0FMQ29OOUl4T3NSRFhsUFdJV3ltdWRrbUFT?=
 =?utf-8?B?T3RBQzBHRE5iUk4zakFId0JNazlnZWhnL2hJY1NyT2t5VXVhNHVtVDRYSHZT?=
 =?utf-8?B?MmwvYmZVN1d1RzUrTERQNmZuTWVOaFRDallhWG1BRGRTQmlUVmpNeWZmTUhl?=
 =?utf-8?B?QnIydVQxTlFOWC9wZVB2T2tTLzFjM3ZxOEl4QTVMSTM2U0NsOHNvVnprZzNO?=
 =?utf-8?B?NVhGbURnT1JzZWtyMndtZ3J3S2p5SFcvZGV6aXhCR0tFMVVBMDM2YUs0dzlS?=
 =?utf-8?B?YW5FQitKaVVUNlVQTFIzMFNXUUxjSkNGaWNpa0xPdzZUdzlESkVkZWkwWFMw?=
 =?utf-8?B?THhWaU1OMXk3NTNoWGFuUUQrM2NYdUZocHQ4Ump4YnkwUjVLdmNVV1NQVklj?=
 =?utf-8?Q?ejgY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0546f16-f3c0-4c27-989b-08d9ec6853d4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 07:38:27.9174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBP+0QA5+9TkWgmqrBIoiouk0D4fIaE1vELzuM+dXCeImLO9PSPWOlNNcts1ZgVV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1889
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.02.22 um 08:34 schrieb Somalapuram, Amaranath:
>
> On 2/10/2022 12:39 PM, Christian König wrote:
>> Am 10.02.22 um 06:29 schrieb Somalapuram, Amaranath:
>>>
>>> On 2/9/2022 1:17 PM, Christian König wrote:
>>>> Am 08.02.22 um 16:28 schrieb Alex Deucher:
>>>>> On Tue, Feb 8, 2022 at 3:17 AM Somalapuram Amaranath
>>>>> <Amaranath.Somalapuram@amd.com> wrote:
>>>>>> Dump the list of register values to trace event on GPU reset.
>>>>>>
>>>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 
>>>>>> ++++++++++++++++++++-
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 19 
>>>>>> +++++++++++++++++++
>>>>>>   2 files changed, 39 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index 1e651b959141..057922fb7e37 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -4534,6 +4534,23 @@ int amdgpu_device_pre_asic_reset(struct 
>>>>>> amdgpu_device *adev,
>>>>>>          return r;
>>>>>>   }
>>>>>>
>>>>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>>> +{
>>>>>> +       int i;
>>>>>> +       uint32_t reg_value[128];
>>>>>> +
>>>>>> +       for (i = 0; adev->reset_dump_reg_list[i] != 0; i++) {
>>>>>> +               if (adev->asic_type >= CHIP_NAVI10)
>>>>> This check should be against CHIP_VEGA10.  Also, this only allows for
>>>>> GC registers.  If we wanted to dump other registers, we'd need a
>>>>> different macro.  Might be better to just use RREG32 here for
>>>>> everything and then encode the full offset using
>>>>> SOC15_REG_ENTRY_OFFSET() or a similar macro.  Also, we need to think
>>>>> about how to handle gfxoff in this case.  gfxoff needs to be disabled
>>>>> or we'll hang the chip if we try and read GC or SDMA registers via
>>>>> MMIO which will adversely affect the hang signature.
>>>>
>>>> Well this should execute right before a GPU reset, so I think it 
>>>> shouldn't matter if we hang the chip or not as long as the read 
>>>> comes back correctly (I remember a very long UVD debug session 
>>>> because of this).
>>>>
>>>> But in general I agree, we should just use RREG32() here and always 
>>>> encode the full register offset.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>> Can I use something like this:
>>>
>>> +                       reg_value[i] = 
>>> RREG32((adev->reg_offset[adev->reset_dump_reg_list[i][0]]
>>> + [adev->reset_dump_reg_list[i][1]]
>>> + [adev->reset_dump_reg_list[i][2]])
>>> +                                 + adev->reset_dump_reg_list[i][3]);
>>>
>>> ip --> adev->reset_dump_reg_list[i][0]
>>>
>>> inst --> adev->reset_dump_reg_list[i][1]
>>>
>>> BASE_IDX--> adev->reset_dump_reg_list[i][2]
>>>
>>> reg --> adev->reset_dump_reg_list[i][3]
>>
>> No, that won't work.
>>
>> What you need to do is to use the full 32bit address of the register. 
>> Userspace can worry about figuring out which ip, instance, base and 
>> reg to resolve into that address.
>>
>> Regards,
>> Christian.
>>
> Thanks Christian.
>
> should I consider using gfxoff like below code or not required:
> amdgpu_gfx_off_ctrl(adev, false);
> amdgpu_gfx_off_ctrl(adev, true);

That's a really good question I can't fully answer.

I think we don't want that because the GPU is stuck when the dump is 
made, but better let Alex comment as well.

Regards,
Christian.

>
>
> Regards,
>
> S.Amarnath
>>>
>>> which requires 4 values in user space for each register.
>>>
>>> using any existing macro like RREG32_SOC15** will not be able to 
>>> pass proper argument from user space (like ip##_HWIP or reg##_BASE_IDX)
>>>
>>>>
>>>>>
>>>>> Alex
>>>>>
>>>>>> + reg_value[i] = RREG32_SOC15_IP(GC, adev->reset_dump_reg_list[i]);
>>>>>> +               else
>>>>>> +                       reg_value[i] = 
>>>>>> RREG32(adev->reset_dump_reg_list[i]);
>>>>>> +       }
>>>>>> +
>>>>>> + trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list, 
>>>>>> reg_value, i);
>>>>>> +
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +
>>>>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>>                           struct amdgpu_reset_context 
>>>>>> *reset_context)
>>>>>>   {
>>>>>> @@ -4567,8 +4584,10 @@ int amdgpu_do_asic_reset(struct list_head 
>>>>>> *device_list_handle,
>>>>>> tmp_adev->gmc.xgmi.pending_reset = false;
>>>>>>                                  if 
>>>>>> (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>>>>>>                                          r = -EALREADY;
>>>>>> -                       } else
>>>>>> +                       } else {
>>>>>> + amdgpu_reset_reg_dumps(tmp_adev);
>>>>>>                                  r = amdgpu_asic_reset(tmp_adev);
>>>>>> +                       }
>>>>>>
>>>>>>                          if (r) {
>>>>>> dev_err(tmp_adev->dev, "ASIC reset failed with error, %d for drm 
>>>>>> dev, %s",
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>>> index d855cb53c7e0..3fe33de3564a 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>>> @@ -537,6 +537,25 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>>>>>>                        __entry->seqno)
>>>>>>   );
>>>>>>
>>>>>> +TRACE_EVENT(amdgpu_reset_reg_dumps,
>>>>>> +           TP_PROTO(long *address, uint32_t *value, int length),
>>>>>> +           TP_ARGS(address, value, length),
>>>>>> +           TP_STRUCT__entry(
>>>>>> +                            __array(long, address, 128)
>>>>>> +                            __array(uint32_t, value, 128)
>>>>>> +                            __field(int, len)
>>>>>> +                            ),
>>>>>> +           TP_fast_assign(
>>>>>> +                          memcpy(__entry->address, address, 128);
>>>>>> +                          memcpy(__entry->value, value, 128);
>>>>>> +                          __entry->len = length;
>>>>>> +                          ),
>>>>>> +           TP_printk("amdgpu register dump offset: %s value: %s ",
>>>>>> +                     __print_array(__entry->address, 
>>>>>> __entry->len, 8),
>>>>>> +                     __print_array(__entry->value, __entry->len, 8)
>>>>>> +                    )
>>>>>> +);
>>>>>> +
>>>>>>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>>>>>   #endif
>>>>>>
>>>>>> -- 
>>>>>> 2.25.1
>>>>>>
>>>>
>>

