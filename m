Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48136C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 13:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A809E10E858;
	Thu, 10 Feb 2022 13:18:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE29510E858
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 13:18:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MojrsNQWNeLIiFqdDwody40shWyo6g0CQ0TfoR/JU/LKhOs0y7FqhqTzlTkw2plIK7HpYHSkI3vEoUqo3qDFw89Lo8ZQf9k/dD9kJhz2zctjxTqJXD75NDNeOcVWvDeUnJiig04TCUxMbEagQFmbJtprA6yc1ZQd7O2Q6ExURe8yv/DlUmgnDWHwdKkhfYlo0wNADV2e4hetHJtlLFY2q2sxraMxKpA61yyFSdv+2sOiBpyIppDS5ipqD6WDFEE4KazqMLk8l87tWaQXLL0WU+H1HkagEykoIFybLyGOTL71qhXIL+zYyhaOVqLHDB8VgrQ6jivU2gBqsgaP0ADHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQch+OD5JPFS3mWgOYmoVDl88F9gHHo64CXm4ZJp2fA=;
 b=cfCE7qNQzJUyBaUPQ42OBITDW6hDCJI8uUEGbsTYcSIOJ4roRxNvaz7RnNYGYjxzxAE4ervhloBG46LffpOsG/C5Yz6oqVrpdFisBXbOeDjwUYYRDt2a/UBpIFDMG/NKxzybBcAw0bcliyWgUTQpyeCnQjXV8GntEuA0NiIUMZau1Qp00UHB31MBeeq428gV8sdxhQ5q6cqKaCGaNKI+Z5FcFgDXUkWh84ut8j8X2WZygorwjuERWMP2ggzIaeto2M4/7v0j1ZZRMs357y7edAr+RgY5qdX0rjmLBR1e7nGZVmiUb7LxHXX4usiy5+ncq+63v9jxQAhtey61Ee2EiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQch+OD5JPFS3mWgOYmoVDl88F9gHHo64CXm4ZJp2fA=;
 b=JrhfmFBPoAgVPKQfrbEE9P96frjW5GYctbtKmFchUPnaxPYvy9y/HoXF4snifvlstzgTpAuZNPB+SWCmRyqJK33T31kSPdOWZRXsWe/I6ximFZzR+ldMXqh0xeyzYFCncpKGiOdIFHJ+Md29FJCr1LgcU15lqvGuHgncI91EWgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by LV2PR12MB5917.namprd12.prod.outlook.com (2603:10b6:408:175::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Thu, 10 Feb
 2022 13:18:55 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 13:18:55 +0000
Message-ID: <2c30cea6-7db0-92e9-b884-5967a9b95bd7@amd.com>
Date: Thu, 10 Feb 2022 14:18:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: add reset register trace function on GPU
 reset
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Somalapuram, Amaranath" <asomalap@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
References: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
 <20220208081647.3025-2-Amaranath.Somalapuram@amd.com>
 <CADnq5_Pun3UPKJsTKEf4pu3R=UbbHAZDW5-=+pekTDx4TWsAEw@mail.gmail.com>
 <6a7ca5ae-6d78-b8fd-cba8-cd2dca4418f4@amd.com>
 <49e24f9f-4657-d3ce-e84e-abbaa56d3181@amd.com>
 <1b79efe6-20e9-5543-4b2e-fa09f97c8e9a@amd.com>
 <01cbfbe8-c08a-e7a8-7e23-bc1ccc5c32f1@amd.com>
 <d2a93513-c199-c4f4-7564-da58f3bb2120@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <d2a93513-c199-c4f4-7564-da58f3bb2120@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0130.eurprd06.prod.outlook.com
 (2603:10a6:20b:467::17) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b31c1599-ab2b-4f6d-ca5f-08d9ec97e3aa
X-MS-TrafficTypeDiagnostic: LV2PR12MB5917:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB591789A38DBD3A803C44AE30F22F9@LV2PR12MB5917.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xvz2dRCjABjstzk9DAioBDF6daD2cxNB88tOnggg68YMHqFXhBPBeWYqatlIx7YHZE3zg5K9bWEuqjoa0zRFKlTFYhEO387dKoQTJEBwyOLNMDnJSeJjn0CJD3c43o0qpaepG8YmTKY0LIUSJ4aldAD4t+fBLdItH9LzXvwGQk/B2/uq5T+HfgnDP1EdX+ck1sRb3xyYBV3YNhthJkwukyOlJMsSuCQpBddJ/UerSAwRqaVvLkJukddVFXHBe/tdoV6JKX5RhjV0h3UkL/FJvot/lY1dtbrnl5KtX48da80OgkLj6M8XeGwYqSwcIbsiZcZxs+3J686LuOW/hhdHAd/g6DiFYEgjotMgn+FPSLrhF8cqjNqd7K3NVuQfN+0grMmcwR2COEpMrVhccxiR/N2KqoSsD1kE8HM89wlIl3zwzTtJT7QWK4qB13YYoeuE21s2OSR+tU0Ibm6WTUiVeyx4CxD9atd0WkJSwn2YzDdYGTBm4YZ0C5qzbTz/1L/lnDWPga95rQVBjpIyust1WFThnR1ZUCaD4B0YDeOZ7WxFaRzE/PO2nEeDdL2K0MIzYCjmzcf98EWqoOkKWuaVS9qmpiYBOUDnyZyQ/qkBIUbJC3S/DMSpf+7qCFW8CXrKWWDsTUwKaVaNtyHphXPrqW0a0GE9tJs5sFzO/PIp8BjiNpVoyz9aML5lls/x8p5vZqFmt4fOiPOAVuTkPf5rrynp1de4+H2nx2ezlQQZisRfiP7Ndon4+hYT4CuE7KL1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(31696002)(110136005)(38100700002)(186003)(2906002)(6636002)(54906003)(2616005)(83380400001)(316002)(5660300002)(508600001)(86362001)(66574015)(4326008)(31686004)(8936002)(6506007)(6486002)(26005)(66556008)(8676002)(66476007)(6512007)(66946007)(6666004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFhFMDh0VWNvV2tWUGN0M1RIVGlmMXVlemNMUERPZnVlUDh3STg5Vis3ZUIy?=
 =?utf-8?B?L2RxQW5BTDhPd3BXYjRLOUhxWmh6M2N3Tlk0QXdyMUpRZUpUaTkyMndxSjF4?=
 =?utf-8?B?aWYwRWsydm9LREF5enVZOGQzNFdzWDE1YmNoZHhFRDBLcWUzQUlDTmJKRHdN?=
 =?utf-8?B?RFJEb0MxUVd6Qk1UQVFncm1NTHFXOXE0M3p1b2Q4Y2ZTZ0pKTm1ISUtOUnJQ?=
 =?utf-8?B?RFpzRmRWcFN0aHJleVViWFdmZ2U2cnNMY1RQc1AzMUhmUTJVbTlNUysrR0FL?=
 =?utf-8?B?Q0lwY0taWTBTOXl0TWZrb1E2ay9pM0I0NkJyNnVpWmhiVU9FeG1vZTN4enFL?=
 =?utf-8?B?cTJQUlQzcU90c1VUS0MxbmU2MFBtb2FOVjRFTGpvWlJxM2xGRHBQMnVMWGNT?=
 =?utf-8?B?RWU2MlIrTzZFZjAwOVE2WVhhVVVJMmdJa0R2WG1uZUJBL1N4MWcvbnJGNmxY?=
 =?utf-8?B?YkhGNm4rdmd3WExoWmxWZUhXR25YZjlMdlJjQWh1SDR2djdoV3picmZMaTZC?=
 =?utf-8?B?c3p4R0syWEpuekZreUhqYnp6Ni9EQlVhM0Z5eWszbTJLbUhpZE9CM1huM2dJ?=
 =?utf-8?B?S1JtTUVPM3VxN0tIZGd4VFN0dDR4NEk0YldGNk5Ld1ZwTUViVm9MUXBoVi9r?=
 =?utf-8?B?Z2p2U1QyV0l1cjJjbmw3REJtM0tUQjlwVXEyajZHcXZCSWlLdzdKai9YVmFt?=
 =?utf-8?B?dTNEMTdwQlpuQmlqK2c3RHdTQXpCQkFkMVRETTgveHoyTUd0T2VlMUFuVDFk?=
 =?utf-8?B?RGZFMmZ4Rjh6aGhQYWhUZk9wa0lUbjlOSVJsYWprVVVXWDJBS0MwelVBOUlt?=
 =?utf-8?B?QWw2M0JxcGRXL3Jmd2xnb05qWStaVUxORENIa2lHN2JXemROMWhBRDFCVHVt?=
 =?utf-8?B?eCs2Z3pLS1lvcGxrVGduY3ZRNXZEU2w4ZDBudEtqOHJLVkt5TUR1c0F0eU5P?=
 =?utf-8?B?OC91THZhS2dQZlY4cDY3MUlNWXM3N3FxK1krTTB5K253K0QreHdIVWQrSUgx?=
 =?utf-8?B?RUoxSnFqRlhKdDlJN21PZ1YwaEhMZWpheTB0d2YwaW9vWng0OXIzajBJTVZX?=
 =?utf-8?B?YXEyd1FtUFJxUzhhZkpUemhVYXRSMlNxckNtVTluQ3JRczBDbHhDMDloU0dL?=
 =?utf-8?B?VHJlby90RmRLMFhtTkwxUlR5cVpVZEFkdUVSekdGNW4yQjFUSlBBYm1kSVFp?=
 =?utf-8?B?K1h0Y203SC9Qb053endVd3ZMMi9uaFpLQmozbEN3WGV1eGQxb01QeVpnS0M4?=
 =?utf-8?B?Y2lnYVFEMHIxb0ZIMkRUdy9FVVRBTUJrbWRpM2VBNzdkdDV1dVRDVmgwSUxy?=
 =?utf-8?B?bHd2V2VJUGFCSUZjVXZ6UnhIb2dDZTR1Q0tzSXpUbXhhUUNqeXRhWTBvczJ3?=
 =?utf-8?B?dUdUYW44aWFWeXk4U2VaVXVRbVRDditORFg4WDJSSjZaNHNaTDIyRk1LQ1BH?=
 =?utf-8?B?VmlBa0RhOXZINnlkTUt3R3I1Vnp3eDZlV3JTVi9IdjBMQVU1RUtQV3JrL0FW?=
 =?utf-8?B?OFFDNHVWN0o2MHByaFVhZThKLzdDZEMwK3F6RG5nOTN3VWYvdEkxanM4Vmo0?=
 =?utf-8?B?SFI5Wk5SUXowcEpwZmhnNEJpZHAxdXdvWGF2VHllSkdFbFd2Sk5oNlFVZGJK?=
 =?utf-8?B?WnhaN2k5TXBVa3c5U3I3ZXROeHpENlU0YzQ4bGZOME42SXZNMWtOVlFmLzcz?=
 =?utf-8?B?b0E1RnZhOWVid0srekpMUHhENlhJb3BoVG5temdPSnlXK0dJdS9iWTZKZFEw?=
 =?utf-8?B?a0R3cHBjeWtNK1JVTGptOHhNZm4wM0EvRm1XbmwxS28rMmxVNHU2czcwaDFM?=
 =?utf-8?B?VEZJakJOVlNydllHemxDeEZLdE9POUtZZnJwZXovc0lHdkswNFhoeHMxUnJo?=
 =?utf-8?B?Mlk1dmlNNVdSRnlwL3RXWWdML0ovOGFveDVsNkh0UVJwZWQ5ZnM0UnBiSWp6?=
 =?utf-8?B?ZFA1NFBCbHBzallIYnV3V3NLMXRvU0g1M256MjRyOEZrdEhXcXNxdGVpcWNS?=
 =?utf-8?B?QlZHL0VzSWVaQ0lOZ3RGNkVieFVsTDFtVjRSUVA1WWJLaFo2bkxENHo3Z2Qr?=
 =?utf-8?B?WnNGRUw5cVltL2x4OWJUWDBJMnhkekVxanA1bXJyUTVDRE1JY3pydmUxOW4z?=
 =?utf-8?B?K1NvQmNRTjk0YXJTajhOamo3L09PZ2pIVnYyT0s0YTJVVENNU3ViMmxJUk50?=
 =?utf-8?Q?8gc128RrOngBVWXgRveN+cM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b31c1599-ab2b-4f6d-ca5f-08d9ec97e3aa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 13:18:55.7211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vH/RDeK8XDkkbB7VozMx+WFZOhDPK2Z8e9pKCFnqPcc7A9y5Bjgpb+i8bFMoNZmR8mBnzX+FyJyte72bLUObtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5917
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/10/2022 8:38 AM, Christian König wrote:
> Am 10.02.22 um 08:34 schrieb Somalapuram, Amaranath:
>>
>> On 2/10/2022 12:39 PM, Christian König wrote:
>>> Am 10.02.22 um 06:29 schrieb Somalapuram, Amaranath:
>>>>
>>>> On 2/9/2022 1:17 PM, Christian König wrote:
>>>>> Am 08.02.22 um 16:28 schrieb Alex Deucher:
>>>>>> On Tue, Feb 8, 2022 at 3:17 AM Somalapuram Amaranath
>>>>>> <Amaranath.Somalapuram@amd.com> wrote:
>>>>>>> Dump the list of register values to trace event on GPU reset.
>>>>>>>
>>>>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 
>>>>>>> ++++++++++++++++++++-
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 19 
>>>>>>> +++++++++++++++++++
>>>>>>>   2 files changed, 39 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index 1e651b959141..057922fb7e37 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -4534,6 +4534,23 @@ int amdgpu_device_pre_asic_reset(struct 
>>>>>>> amdgpu_device *adev,
>>>>>>>          return r;
>>>>>>>   }
>>>>>>>
>>>>>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>>>> +{
>>>>>>> +       int i;
>>>>>>> +       uint32_t reg_value[128];
>>>>>>> +
>>>>>>> +       for (i = 0; adev->reset_dump_reg_list[i] != 0; i++) {
>>>>>>> +               if (adev->asic_type >= CHIP_NAVI10)
>>>>>> This check should be against CHIP_VEGA10.  Also, this only allows for
>>>>>> GC registers.  If we wanted to dump other registers, we'd need a
>>>>>> different macro.  Might be better to just use RREG32 here for
>>>>>> everything and then encode the full offset using
>>>>>> SOC15_REG_ENTRY_OFFSET() or a similar macro.  Also, we need to think
>>>>>> about how to handle gfxoff in this case.  gfxoff needs to be disabled
>>>>>> or we'll hang the chip if we try and read GC or SDMA registers via
>>>>>> MMIO which will adversely affect the hang signature.
>>>>>
>>>>> Well this should execute right before a GPU reset, so I think it 
>>>>> shouldn't matter if we hang the chip or not as long as the read 
>>>>> comes back correctly (I remember a very long UVD debug session 
>>>>> because of this).
>>>>>
>>>>> But in general I agree, we should just use RREG32() here and always 
>>>>> encode the full register offset.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>> Can I use something like this:
>>>>
>>>> +                       reg_value[i] = 
>>>> RREG32((adev->reg_offset[adev->reset_dump_reg_list[i][0]]
>>>> + [adev->reset_dump_reg_list[i][1]]
>>>> + [adev->reset_dump_reg_list[i][2]])
>>>> +                                 + adev->reset_dump_reg_list[i][3]);
>>>>
>>>> ip --> adev->reset_dump_reg_list[i][0]
>>>>
>>>> inst --> adev->reset_dump_reg_list[i][1]
>>>>
>>>> BASE_IDX--> adev->reset_dump_reg_list[i][2]
>>>>
>>>> reg --> adev->reset_dump_reg_list[i][3]
>>>
>>> No, that won't work.
>>>
>>> What you need to do is to use the full 32bit address of the register. 
>>> Userspace can worry about figuring out which ip, instance, base and 
>>> reg to resolve into that address.
>>>
>>> Regards,
>>> Christian.
>>>
>> Thanks Christian.
>>
>> should I consider using gfxoff like below code or not required:
>> amdgpu_gfx_off_ctrl(adev, false);
>> amdgpu_gfx_off_ctrl(adev, true);
> 
> That's a really good question I can't fully answer.
> 
> I think we don't want that because the GPU is stuck when the dump is 
> made, but better let Alex comment as well.
> 
> Regards,
> Christian.


I had a quick look at the function amdgpu_gfx_off_ctrl, and it locks 
this mutex internally:
mutex_lock(&adev->gfx.gfx_off_mutex);

and the reference state is tracked in:
adev->gfx.gfx_off_state

We can do something like this maybe:
- If (adev->gfx_off_state == 0) {
   trylock(gfx_off_mutex)
   read_regs_now;
   unlock_mutex();
}

How does it sounds ?

- Shashank
> 
>>
>>
>> Regards,
>>
>> S.Amarnath
>>>>
>>>> which requires 4 values in user space for each register.
>>>>
>>>> using any existing macro like RREG32_SOC15** will not be able to 
>>>> pass proper argument from user space (like ip##_HWIP or reg##_BASE_IDX)
>>>>
>>>>>
>>>>>>
>>>>>> Alex
>>>>>>
>>>>>>> + reg_value[i] = RREG32_SOC15_IP(GC, adev->reset_dump_reg_list[i]);
>>>>>>> +               else
>>>>>>> +                       reg_value[i] = 
>>>>>>> RREG32(adev->reset_dump_reg_list[i]);
>>>>>>> +       }
>>>>>>> +
>>>>>>> + trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list, 
>>>>>>> reg_value, i);
>>>>>>> +
>>>>>>> +       return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>>>                           struct amdgpu_reset_context 
>>>>>>> *reset_context)
>>>>>>>   {
>>>>>>> @@ -4567,8 +4584,10 @@ int amdgpu_do_asic_reset(struct list_head 
>>>>>>> *device_list_handle,
>>>>>>> tmp_adev->gmc.xgmi.pending_reset = false;
>>>>>>>                                  if 
>>>>>>> (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>>>>>>>                                          r = -EALREADY;
>>>>>>> -                       } else
>>>>>>> +                       } else {
>>>>>>> + amdgpu_reset_reg_dumps(tmp_adev);
>>>>>>>                                  r = amdgpu_asic_reset(tmp_adev);
>>>>>>> +                       }
>>>>>>>
>>>>>>>                          if (r) {
>>>>>>> dev_err(tmp_adev->dev, "ASIC reset failed with error, %d for drm 
>>>>>>> dev, %s",
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>>>> index d855cb53c7e0..3fe33de3564a 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>>>> @@ -537,6 +537,25 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>>>>>>>                        __entry->seqno)
>>>>>>>   );
>>>>>>>
>>>>>>> +TRACE_EVENT(amdgpu_reset_reg_dumps,
>>>>>>> +           TP_PROTO(long *address, uint32_t *value, int length),
>>>>>>> +           TP_ARGS(address, value, length),
>>>>>>> +           TP_STRUCT__entry(
>>>>>>> +                            __array(long, address, 128)
>>>>>>> +                            __array(uint32_t, value, 128)
>>>>>>> +                            __field(int, len)
>>>>>>> +                            ),
>>>>>>> +           TP_fast_assign(
>>>>>>> +                          memcpy(__entry->address, address, 128);
>>>>>>> +                          memcpy(__entry->value, value, 128);
>>>>>>> +                          __entry->len = length;
>>>>>>> +                          ),
>>>>>>> +           TP_printk("amdgpu register dump offset: %s value: %s ",
>>>>>>> +                     __print_array(__entry->address, 
>>>>>>> __entry->len, 8),
>>>>>>> +                     __print_array(__entry->value, __entry->len, 8)
>>>>>>> +                    )
>>>>>>> +);
>>>>>>> +
>>>>>>>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>>>>>>   #endif
>>>>>>>
>>>>>>> -- 
>>>>>>> 2.25.1
>>>>>>>
>>>>>
>>>
> 
