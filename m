Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C126C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 14:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C5410E8A2;
	Thu, 10 Feb 2022 14:11:16 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA2410E8B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 14:11:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWid8BFmAbH9VX/jTDDatzuwUr4DooU8f9ng7giAfCMTZk5oCc9MsUXN5xXaf4mjfZK3EmlOAW3DKwxukqgK9za2OZIKE1i4fSFfb6nfAsn0wJqn2gQZqdazizdjvVFahcVAusZTNvPgRtRVfiw2p3rz4+qJgiIEtZios2xoYnN+tA8RymavMzBXnMHV6l/nbtEIA24ZChClzfKIDZ3RnzH+F2AV2lo4FH9OKWjPz5D6rRaWgVjbDgFmuXpokVa2LtR0pEpk7na6YKPu5pP34zYDa9VNwf2LNLHtFpp0fX6od9nccD2CTHYJisnAs5nVhZxn63EwkwY6iCYsLZuOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KapEQcP4wpMTJ2adaZWFVEp6GhgGrZ3fvK2KEGQL6J8=;
 b=it1CfunOy7QfD3Emwc5pKDRlMwv8Ht1h6AOK+lIhoirt6ZbiHMHo8lWdDe826yRfKelfBTYQuVBfcpraaAnrrMwYNVdgeKgwPR4l7crC6UKnQBslVEK9xE7QUXAvrJ/406trxNnV4N9Juh/fhXEGlTGDIKD68ipYjplxAMzXnk8gxCmgDn2Vy2Cc3t4gwo5cr6RjZNjVTAgFfmK5Lc+7Cj5QN+JIyBD+iQSAtrzYm1PLgOxUFCz2mkLifIqmFrvhFqy+xykIqmQLc76Ej5QERDswZ7h0a/QkTNMk+kYMchYOPqb9Vn2d8vxihJ7/VqhPNWudBu1WsKhPTRfMNey2/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KapEQcP4wpMTJ2adaZWFVEp6GhgGrZ3fvK2KEGQL6J8=;
 b=C2GhBjHDGIBAoL2PmzT6dkhTgRhqEd9sQCDzexeRaaZiAQa0V4y5ns2mYOLZFVdjCBQsPh6MKXO4IC392L/Dg4WKQD9ogmkHtjEMVKk7IJ4OsLeNbqxT0oFqzJveT3xbg+P2r9RQ6ZJ0e3O+k+ybUbmBmYt0jZbm/XkEQk1JFWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BL0PR12MB2561.namprd12.prod.outlook.com (2603:10b6:207:3e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Thu, 10 Feb
 2022 14:11:11 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 14:11:11 +0000
Message-ID: <3c2e5ce5-5535-017f-0ffa-a89e219050f4@amd.com>
Date: Thu, 10 Feb 2022 15:11:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: add reset register trace function on GPU
 reset
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
 <2c30cea6-7db0-92e9-b884-5967a9b95bd7@amd.com>
 <ef597684-c5e7-cea5-a502-ab1434b0094d@gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <ef597684-c5e7-cea5-a502-ab1434b0094d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR10CA0094.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::35) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 309b4757-acc5-4aca-d372-08d9ec9f308e
X-MS-TrafficTypeDiagnostic: BL0PR12MB2561:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB256170266F837FBAD609C39DF22F9@BL0PR12MB2561.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oS0JdZi/ZnWxt12W27QJFiISWSDiPUJG7kvyWwB9hwW0O+eSbw/pRoNIVV6Bj/N6YicLOBgvde27tigRQT3sKw2cGsKFmTFegOI91g2AKEjtL9xvTQjwv4aXWr6Gd2ZcxyTsV8754WSPnfqyYanmB9koq/zlkCo7OMGqqWNkhFStGT0sb6In9i3UTumMIO6Y0gJZ/jjpni1d0gdLwOIa+Ag/kjNhi4TtGln9BHMzDzsO+Q2Iu7lsRT0/QtitPFCJeqLXMTk4PyshxmyKyb7IWFD6fd8TFcK4orhhl9Pulprj3M5mQXxX1b00oqEvKQN1GrrhvTSlySdPJ6737Cxn3wWN337XxcC+z+rWGAsIc2LxaJlDTgwTySkuLOd5RWcQi3HWZ7PzIYNdVZyHUDfbba7q2/gWUeajAewpfA0mlWoXiniFeLiLF5c/zSofuCjNmZ0UpxmgJnyq8W8RmJf297FiVR/EMxqSV0p5WpASQs16soMxAuMlnULIxagJLgVhdptOThSIRMpcg80z+TIlTvTRcbqbaUku2GWt/TBPM8jOXAmImdabFqqX0+eZXFf1gLeQuhhu8hi3w63auaxDZNlTx4UJS30/th/XJm3pp0a6OKJ3Ks+68WLyEV+OkA4XA5NsM9k1AF33MJ1Zxo6PfSxWIcLqG+FbIllK2P0oPd6LXbvxw8oD0sGE9h0/8Ub9eUHZT0za+v/6VP5zEUQgcMTK5+G5ZbSzAyYUZ/aj4TPZbRhSqWkPfaQmt9Ful2I7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(54906003)(508600001)(36756003)(2616005)(31696002)(31686004)(2906002)(6636002)(53546011)(86362001)(4326008)(316002)(66574015)(6512007)(110136005)(83380400001)(26005)(66946007)(66476007)(66556008)(5660300002)(8936002)(8676002)(38100700002)(6486002)(186003)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXdKTmdCSUhqc3g1MGlON1R1VDFvZ2VMTFAzYXY0TS9oOENKZTNEWW1xVng0?=
 =?utf-8?B?NGE2My8vZlJkS3ROejRmcFQwQTJDWXJSaWpGT3ZtcGxWTXRyNitRa0lLU2RT?=
 =?utf-8?B?dUJ5Vk5RdG15VDlRT1JzZ2tINXRnbEVMWDJLWUp6Snc4T3FOZkhOVERMM1h1?=
 =?utf-8?B?dzJjQjhiOWI2TEowSVFhZTBkcjBMSHZzalBpaE9WK25hc1prK2RHOVFCbVFz?=
 =?utf-8?B?cmJST3Bad1gvWFIrekVNdExzcnhFQU1DZkh1c0NzU3E1N05VeUN1WlJ3T0NM?=
 =?utf-8?B?TmdUM1B5bHE2OWZmQzdpYlQvMlBwVWFibVBtTEV1TG5zb3V5QmZ0UHgwMmpy?=
 =?utf-8?B?MHVHQzhuNitVNVgzRFUwM280aFNrYmZybmlsV0RpQUloUWMrNFlKZmJFaHVr?=
 =?utf-8?B?dzUwODliMG11ei9LWjRGbGV2VENOUDZ1UXN5cjNiRVFxSXBpNFpqajdtT0VU?=
 =?utf-8?B?QjlxaXpvZHRHVW9Eai9LNzZPTHZVVFRxNndXMzV6UEJ4ZDg4Vm9WTEJUbmxo?=
 =?utf-8?B?em4yVCtvQnlpa1pkVHZqb0I1RzR2dDdvSEV6SHhwMnllK0pwcEJ6ZUh2ZGpw?=
 =?utf-8?B?WWJyOTlpdlZwUDJiQUJYQmQxRFQvYXFqZ2ZKcjEyblBHcDQwcUlJR1hmTzA2?=
 =?utf-8?B?ME5EOURNdkZPdW1TUTc5SzZ4OVpDUFU4aFJjQVNkYUJrN0hQbzJYOHp0SERG?=
 =?utf-8?B?RWhrZFY0bTUyT0E0ZTJVdFQrZ2RyOU1pVmQ1RS9rbTY0alBFZ2VQUzFCWFAz?=
 =?utf-8?B?dWxzY3NwOTVwOXFFb3hpRnFOYkZrN0ErSE9tQ1BvRW5MRjhkVlpVdE1ISEVq?=
 =?utf-8?B?ajgrVTNFMlk5dHVVNjFGYWVxcDZuSEkxQkpINEtuL3NUdkZUMERqVHpEaXpO?=
 =?utf-8?B?V3IyMWtPLy9VNG8wSnBXWHVOZDZkRm40WStTTVNQZlJQRENpcVo3UllEaVU1?=
 =?utf-8?B?cGluMkNVbEp6TGdmbEQydWRvZmd5RzdVbERGSmdNTzlWMnlGRHNFZzdkWXR3?=
 =?utf-8?B?dS90cEZEQ0NjSW5JNHZlQ3RtVGdqd3dtZk9CY2ZKRHo5QmlycVdtS0dBL0lI?=
 =?utf-8?B?dytPUmtIZ3dBSzljNlAvOWlOZDMxZnUwM3dkcm1HeXRWU2JpelR5eGpkbGh5?=
 =?utf-8?B?SWo5NlkxbmU1UFNkOWFJZmZMQk1kZVZoM2NscmZCdUJvR0FBbzFuWXBmdldF?=
 =?utf-8?B?bFlld2tDZ3BqQnA2cHVlSGl6eStKcURQRTF6ZW5LWjdKbktnSWd1OTZ2c2ZD?=
 =?utf-8?B?TWgxQW9CU2FiN3pscnBNbXhOTFZtNncvRkZRVEx5SDlGQzJxUDJBZ2x2NGdj?=
 =?utf-8?B?NDloYlMveUZhSVQ4Mkl1RjREVzAvZmlvOUlBMnZTdExTQnhySUU0bDNzc2dh?=
 =?utf-8?B?TkVmNStheUhlTlIzMVJDVWdJZkZIZXF1aklmVVVyTVA5clVvYXdLajFpTW9I?=
 =?utf-8?B?VEIrYnA1VzNsMHB2YXRJN1ZBSzUxTSs4QXFsMjREVkx4K0IzK1JqdUVnTmQv?=
 =?utf-8?B?MGllL2dxRTNVOFZzQjQxZHBQL0dsbEJOSnk1ano0d0pXMVcrRTIwaHorRHdi?=
 =?utf-8?B?V0R0ems5YjBLcmRyd2d0dEhwWllRdm5kb1plb2JoQmVFQXlGUU50Z1JoTU5M?=
 =?utf-8?B?ZFBxMUdFVmp0NHZIb2k3Mm9JVnJuUWt3QzVrd3dJSEdLVm5YU2VvT1N1VVpk?=
 =?utf-8?B?a2xmVWVuQ1JRaUFUbmtDbjlhak9yKzFqSHNGa0RRaVJOOXQ4V1JiSTZ0L3VH?=
 =?utf-8?B?MlNKOVB3RGN4eW9GY0xWYnp6ZVJVZlVhT2xOSkhaSldKZXczOG12VkZjdmVK?=
 =?utf-8?B?Mk9WRit3TGdFaHpMUEtQRXlnZHlIcEdycHljYTNqQ25GKzRJRituMTE0Si9Q?=
 =?utf-8?B?Q3RBY2JDLytaaDRRcVFXM0g3YXJJd0NDbjdpa1hlMHZDOHg0VVFGZjcyV0VR?=
 =?utf-8?B?dkZYUVp6UEZ4QzFmdUtTL0RqMEIrbGhaVTNIZDhiTGxMTkRzZDU1RC9qdHBP?=
 =?utf-8?B?dlhsOGxpQXJISVRkTHRtQ3NxejBsdUppZzVRRS9VRk14UGJ2Z0toVlltdXZ5?=
 =?utf-8?B?OW5lNUdDOXhQaDRCcHhkNHhYZVNjYjRsbC9xUFAxc3VWS3RDaytCNmVKSWpu?=
 =?utf-8?B?SGs0QW14bjV4Z2RvSFdtOERHRVJMMXhjcHo5M3MycFVJUGZlTU1aZHg0RGJr?=
 =?utf-8?Q?SQTOmMh5K4rs7KU8uVtWfuI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309b4757-acc5-4aca-d372-08d9ec9f308e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 14:11:11.1069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/rtwWDU0SP8sj8ejZboglXyGujm0HlmyyN/pKy/J/kC4zYkn2Ih/YEv4/d00WHJWOavK2z7pOiO7iMueMNi0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2561
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



On 2/10/2022 3:05 PM, Christian König wrote:
> Am 10.02.22 um 14:18 schrieb Sharma, Shashank:
>>
>>
>> On 2/10/2022 8:38 AM, Christian König wrote:
>>> Am 10.02.22 um 08:34 schrieb Somalapuram, Amaranath:
>>>>
>>>> On 2/10/2022 12:39 PM, Christian König wrote:
>>>>> Am 10.02.22 um 06:29 schrieb Somalapuram, Amaranath:
>>>>>>
>>>>>> On 2/9/2022 1:17 PM, Christian König wrote:
>>>>>>> Am 08.02.22 um 16:28 schrieb Alex Deucher:
>>>>>>>> On Tue, Feb 8, 2022 at 3:17 AM Somalapuram Amaranath
>>>>>>>> <Amaranath.Somalapuram@amd.com> wrote:
>>>>>>>>> Dump the list of register values to trace event on GPU reset.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Somalapuram Amaranath 
>>>>>>>>> <Amaranath.Somalapuram@amd.com>
>>>>>>>>> ---
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 
>>>>>>>>> ++++++++++++++++++++-
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 19 
>>>>>>>>> +++++++++++++++++++
>>>>>>>>>   2 files changed, 39 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> index 1e651b959141..057922fb7e37 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> @@ -4534,6 +4534,23 @@ int amdgpu_device_pre_asic_reset(struct 
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>          return r;
>>>>>>>>>   }
>>>>>>>>>
>>>>>>>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>>>>>> +{
>>>>>>>>> +       int i;
>>>>>>>>> +       uint32_t reg_value[128];
>>>>>>>>> +
>>>>>>>>> +       for (i = 0; adev->reset_dump_reg_list[i] != 0; i++) {
>>>>>>>>> +               if (adev->asic_type >= CHIP_NAVI10)
>>>>>>>> This check should be against CHIP_VEGA10.  Also, this only 
>>>>>>>> allows for
>>>>>>>> GC registers.  If we wanted to dump other registers, we'd need a
>>>>>>>> different macro.  Might be better to just use RREG32 here for
>>>>>>>> everything and then encode the full offset using
>>>>>>>> SOC15_REG_ENTRY_OFFSET() or a similar macro.  Also, we need to 
>>>>>>>> think
>>>>>>>> about how to handle gfxoff in this case.  gfxoff needs to be 
>>>>>>>> disabled
>>>>>>>> or we'll hang the chip if we try and read GC or SDMA registers via
>>>>>>>> MMIO which will adversely affect the hang signature.
>>>>>>>
>>>>>>> Well this should execute right before a GPU reset, so I think it 
>>>>>>> shouldn't matter if we hang the chip or not as long as the read 
>>>>>>> comes back correctly (I remember a very long UVD debug session 
>>>>>>> because of this).
>>>>>>>
>>>>>>> But in general I agree, we should just use RREG32() here and 
>>>>>>> always encode the full register offset.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>> Can I use something like this:
>>>>>>
>>>>>> +                       reg_value[i] = 
>>>>>> RREG32((adev->reg_offset[adev->reset_dump_reg_list[i][0]]
>>>>>> + [adev->reset_dump_reg_list[i][1]]
>>>>>> + [adev->reset_dump_reg_list[i][2]])
>>>>>> +                                 + adev->reset_dump_reg_list[i][3]);
>>>>>>
>>>>>> ip --> adev->reset_dump_reg_list[i][0]
>>>>>>
>>>>>> inst --> adev->reset_dump_reg_list[i][1]
>>>>>>
>>>>>> BASE_IDX--> adev->reset_dump_reg_list[i][2]
>>>>>>
>>>>>> reg --> adev->reset_dump_reg_list[i][3]
>>>>>
>>>>> No, that won't work.
>>>>>
>>>>> What you need to do is to use the full 32bit address of the 
>>>>> register. Userspace can worry about figuring out which ip, 
>>>>> instance, base and reg to resolve into that address.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>> Thanks Christian.
>>>>
>>>> should I consider using gfxoff like below code or not required:
>>>> amdgpu_gfx_off_ctrl(adev, false);
>>>> amdgpu_gfx_off_ctrl(adev, true);
>>>
>>> That's a really good question I can't fully answer.
>>>
>>> I think we don't want that because the GPU is stuck when the dump is 
>>> made, but better let Alex comment as well.
>>>
>>> Regards,
>>> Christian.
>>
>>
>> I had a quick look at the function amdgpu_gfx_off_ctrl, and it locks 
>> this mutex internally:
>> mutex_lock(&adev->gfx.gfx_off_mutex);
>>
>> and the reference state is tracked in:
>> adev->gfx.gfx_off_state
>>
>> We can do something like this maybe:
>> - If (adev->gfx_off_state == 0) {
>>   trylock(gfx_off_mutex)
>>   read_regs_now;
>>   unlock_mutex();
>> }
>>
>> How does it sounds ?
> 
> As far as I know that won't work. GFX_off is only disabled intentionally 
> in very few places.
> 
> So we will probably never get a register trace with that.
> 

Ok, I don't know much about this feature, but due to the name I was 
udner the impression that gfx_off will be mostly disabled. But if it is 
hardly ever disabled, we need more infomrmation about it first, like 
when is this disabled and why ?

Alex ?

- Shashank

> Regards,
> Christian.
> 
>>
>> - Shashank
>>>
>>>>
>>>>
>>>> Regards,
>>>>
>>>> S.Amarnath
>>>>>>
>>>>>> which requires 4 values in user space for each register.
>>>>>>
>>>>>> using any existing macro like RREG32_SOC15** will not be able to 
>>>>>> pass proper argument from user space (like ip##_HWIP or 
>>>>>> reg##_BASE_IDX)
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Alex
>>>>>>>>
>>>>>>>>> + reg_value[i] = RREG32_SOC15_IP(GC, 
>>>>>>>>> adev->reset_dump_reg_list[i]);
>>>>>>>>> +               else
>>>>>>>>> +                       reg_value[i] = 
>>>>>>>>> RREG32(adev->reset_dump_reg_list[i]);
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> + trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list, 
>>>>>>>>> reg_value, i);
>>>>>>>>> +
>>>>>>>>> +       return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>>>>>                           struct amdgpu_reset_context 
>>>>>>>>> *reset_context)
>>>>>>>>>   {
>>>>>>>>> @@ -4567,8 +4584,10 @@ int amdgpu_do_asic_reset(struct 
>>>>>>>>> list_head *device_list_handle,
>>>>>>>>> tmp_adev->gmc.xgmi.pending_reset = false;
>>>>>>>>>                                  if 
>>>>>>>>> (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>>>>>>>>>                                          r = -EALREADY;
>>>>>>>>> -                       } else
>>>>>>>>> +                       } else {
>>>>>>>>> + amdgpu_reset_reg_dumps(tmp_adev);
>>>>>>>>>                                  r = amdgpu_asic_reset(tmp_adev);
>>>>>>>>> +                       }
>>>>>>>>>
>>>>>>>>>                          if (r) {
>>>>>>>>> dev_err(tmp_adev->dev, "ASIC reset failed with error, %d for 
>>>>>>>>> drm dev, %s",
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>>>>>> index d855cb53c7e0..3fe33de3564a 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>>>>>> @@ -537,6 +537,25 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>>>>>>>>>                        __entry->seqno)
>>>>>>>>>   );
>>>>>>>>>
>>>>>>>>> +TRACE_EVENT(amdgpu_reset_reg_dumps,
>>>>>>>>> +           TP_PROTO(long *address, uint32_t *value, int length),
>>>>>>>>> +           TP_ARGS(address, value, length),
>>>>>>>>> +           TP_STRUCT__entry(
>>>>>>>>> +                            __array(long, address, 128)
>>>>>>>>> +                            __array(uint32_t, value, 128)
>>>>>>>>> +                            __field(int, len)
>>>>>>>>> +                            ),
>>>>>>>>> +           TP_fast_assign(
>>>>>>>>> + memcpy(__entry->address, address, 128);
>>>>>>>>> +                          memcpy(__entry->value, value, 128);
>>>>>>>>> +                          __entry->len = length;
>>>>>>>>> +                          ),
>>>>>>>>> +           TP_printk("amdgpu register dump offset: %s value: 
>>>>>>>>> %s ",
>>>>>>>>> + __print_array(__entry->address, __entry->len, 8),
>>>>>>>>> + __print_array(__entry->value, __entry->len, 8)
>>>>>>>>> +                    )
>>>>>>>>> +);
>>>>>>>>> +
>>>>>>>>>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>>>>>>>>   #endif
>>>>>>>>>
>>>>>>>>> -- 
>>>>>>>>> 2.25.1
>>>>>>>>>
>>>>>>>
>>>>>
>>>
> 
