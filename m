Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6685C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88AF9610A4
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 88AF9610A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C0756E831;
	Thu, 26 Aug 2021 12:39:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE9596E831
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 12:39:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlxLdQiYyu+2hFlj4+GmA6GB0G9QDwr3e5NPRvBiCLLO4sJyXOHUXF80VmeFsZQASJwwtrd4wD9pUzPNAi8NN/Uc1MD0sY7nyOgabCuybQIiRS+4LEKq5Cw2I0C2jUJMqTy1EzfBOX5zmLa3tNYTdADoPdYMG2lSYJeRGdHZG0BCU8KpK2C30z8P5We1NGNtXauI7XokRHa9UFBC3Nk0qtlzwOX14bQzDqKV7g0HUN70iwioQt39865zSc5l1BToVeHS0J/pTKsvOfakoZqir5JMChYU3dZwjBt1GJVlNatB0ISTxj3Z//Z8ABPaWPco8RMQEqK4w+ERd3pU5WI+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyqGiLT0jbFgMI2lGDGUe0oiNsshlk62HOSXzLl/lks=;
 b=V1F7/jaKnoI4SB2NmJrenyPfEotkgaYQYBqWpgJp2wGshauTcSDaKuP+2n/H5CYF7U4L1A1+KvX8J8355+4Mlx8+vJerBA4syCaHCIbBgSpuiDSoOcFT4Sb0PFXNxF078tb1Ms9ykKHsnk48PEpVvhg8IN5VIbXRhBsCN3EPEe588FdFDkWlIu7p6cOJXCw5Kid++3XTeWqjSS0GwknzsTVWHGidvrR5HbV9RYIGyD3p9eqEisjEzbrU0xP/rUsUqfR1c1PuA//gXubFdvlL4eaARIHgjxdFYobB3NcsXmGF6J4EsspR+GbZqieJJz387AESdRnTnVAb4dHb4g9xTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyqGiLT0jbFgMI2lGDGUe0oiNsshlk62HOSXzLl/lks=;
 b=bIKzWx3teuC/ewoLFs7xlNTRNvXjasFytvA6+9GGvBd2EvlKqJmG7hVe3D0rfUWhQNbCUcJU9CZsfsTllgJppYK3BGZrumQ/2GmntuYPucSLpMRmhX/7EfbL9g5Tx40FekmZvAbuffFMdhOD5QYObIQoPEBrakuCm1RaIujsifw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5035.namprd12.prod.outlook.com (2603:10b6:408:134::8)
 by BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 12:39:00 +0000
Received: from BN9PR12MB5035.namprd12.prod.outlook.com
 ([fe80::e8b5:25a3:551b:6fa7]) by BN9PR12MB5035.namprd12.prod.outlook.com
 ([fe80::e8b5:25a3:551b:6fa7%7]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 12:39:00 +0000
Subject: Re: [PATCH 2/5] drm/amdgpu/vcn:set vcn encode ring priority level
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, nirmoy.das@amd.com
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
 <20210826071307.136010-2-satyajit.sahu@amd.com>
 <2a818da4-dc8e-a9b6-c85e-9a6cfef8b537@amd.com>
 <82b91115-b2c8-f6bf-30bb-15da77e70d09@amd.com>
 <aa8797e7-175f-d5f4-969f-eacdaa23e65b@amd.com>
 <fc7fd983-483c-eff6-0129-9ea8e760edd0@amd.com>
 <499bdce8-4f01-1853-f564-a2cb3e90aa99@amd.com>
From: "Sahu, Satyajit" <satyajit.sahu@amd.com>
Message-ID: <5a394fcf-a002-032c-2ee9-7b1ad70c850a@amd.com>
Date: Thu, 26 Aug 2021 18:08:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <499bdce8-4f01-1853-f564-a2cb3e90aa99@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BM1PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::24) To BN9PR12MB5035.namprd12.prod.outlook.com
 (2603:10b6:408:134::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.254.217] (165.204.158.249) by
 BM1PR01CA0154.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.18 via Frontend Transport; Thu, 26 Aug 2021 12:38:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 247134a3-c5dc-4f5f-94e6-08d9688e7a4d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5324:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5324B63B372DE1F6C8E6F087F5C79@BN9PR12MB5324.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmVDEnhOiSSirxHQx4g/AZu/thmQJy6x4zFPoBU/38kHzJ/DLfqYdGFk+Vy7PKzYjNlgw1hJhKttamH+oQOQB6YQXbAYegIl904ELSoBAM14t3flnEmo0LakuzvGPrrhK68fRxTRfH8k8kZff2MicnigX0PqAaWwUZ3qtNNDjfG134OXEiydvCzgDb6rNmMHuFBc0H+gcWQHu2UUslU9eOw5iDwVqpyDcJbscxnB9+hDqtGoye7QFP0Nao2OTJUVy3Vl5QkNrR+9IcGeCTIEHqsFMJll4T3iUBvTj40IcYnSx2Pf5YkhSp/ki3B0gALXcyHIaMJpb6pKxpNZq/IeagRxcAtTLIx4N6gYctWk8zMaL1ywMDPwNlxa6euyzI5T0a4pAP/AFb/qSqdoyeTfiM7yLGeKou34TpFs20mqzUvL5fHCWIRq5e/pi2QctSO6kyrVSfSKKGRYIz8suV8H2qDaYZkjCVuYb3yDcB73gBjoHwuX+akyCO4bnylo+jIKGi8Hd+Q4G1yoTHGl6QpQgD8y/SRBov2JUQNRpbK6xH68M0/2CHrqYfXkJdI+Y2t78KFl/JSNxioqiqdXn/rNYskmcJEbW9zxjHxGiaIOkYOIGOduaAm6ui5HqXccoYpczUn/OhYYtkHOtZDxZkiSboKjdxO0qHVzt47FOsJJU9cY6e4okxIueM2BJ2Ik1RUA5D0KWIP6a9hjYeWRcDQSX/jBhN8X2jd/bW36V4lJXGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5035.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(26005)(31686004)(186003)(66476007)(2906002)(86362001)(83380400001)(38100700002)(66556008)(5660300002)(4326008)(66574015)(31696002)(36756003)(53546011)(956004)(2616005)(6666004)(16576012)(8936002)(66946007)(478600001)(316002)(6486002)(8676002)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sll3eHdqVWp6a25WYnEzUVpET24xN3laeVZKUE9reW0zTlR3d1hTTk96SkJP?=
 =?utf-8?B?cENrMEUrYmZvNXNSc3hSeDV4Q2pZRTFKSC8xQTBReDQyQXlpTmxYdlVRaUpO?=
 =?utf-8?B?QUx1TTFnVDZUTGxiVHpCNjUrNHl3dEpGZW43eXlIbHhjS2hWdmhTdkI3TDhX?=
 =?utf-8?B?TlhGODZ6ZzZvNUlYV05UQ01YNUlGdWl6V1lEQi9YRWJGRGR0bDhoNWdBRXdu?=
 =?utf-8?B?TzkwT1h0UFh3RFU5VFFjbFY4UlJEQVJHQjNMYTNhdUUySU16NkR6S0M1VWh5?=
 =?utf-8?B?TnJZRlVoWUVOU1Y1aHVqT1BOMTdpQXFHN0NDYm9Fend2TnZtSUsvMlJvTFNj?=
 =?utf-8?B?V1Y0T1N0Ri9yQnRTU2JkNFZCZUtKblZVV0hyOXJzTVhxaGcxNVd6Uk0yOFdM?=
 =?utf-8?B?dHNjeXpJbEtGUlZvK3dwRnpRNGx2bVdXTkRkR3RHQlFqN3JJK2VLcFlzUHBD?=
 =?utf-8?B?Z1pXUjFMOUdVWERDcTgzdG45bG9XdnFlbDl1VHEyb2NEUnh0MVJTS2svNHMw?=
 =?utf-8?B?azBpeXZHbWgyRGJLSURTT21lamVjWHZ1dHNKSGNvTElOaTZvWTBZQ2ZWcGIr?=
 =?utf-8?B?SEsrYVE0QmVpMFg2NUJpZGo1NmxHT1ZjTWlsRkJnblNyektaM3N1dFdveG0r?=
 =?utf-8?B?VWh6N2lOY2w2c2EwZHAwV0N5OU4zaEorczRpNUF2VmNlT1V0RlpBWjN1bUxs?=
 =?utf-8?B?UGYrdGZ5VlA0Tk1rREJUSnA1UUQ1RFFlRjZsK2tDMC8xeWhrZi9CSmZ3NmhN?=
 =?utf-8?B?MHZ0UUhqR1ZuU2NlQ01Pc1o2RHdkOVFIRG10emFEZVl3MGdLb0dWTTJaQTJK?=
 =?utf-8?B?OHRncjRzY0dseWx2MVpRQVdxaklENTJ4K3o4VEJSWHFneTdqeC9hSU9kNHI0?=
 =?utf-8?B?TDRYdlJ3QVE5dVBaOFRtWFdxOUhPenhmc0dic2ZyaTRKTlVyZFIrTkp0U2Zo?=
 =?utf-8?B?WVRFUXpCTStqdnVlby82VEpTZVdXcXBpak5QbzFVRTdKZjJzN25haW5oNXRv?=
 =?utf-8?B?UjFTanYxVG1IREIyQ1h3ZkpUdkVuOWU1RzdaQzFvYTZQbWpETW85LzRYNXQx?=
 =?utf-8?B?WHRBdTBJRno2K3daMVJrL2N6Q1RCSW9RZ2VBRWRKNDZ5TjZDaVRRdmNJb0NN?=
 =?utf-8?B?endyaTY4cGEvbVoyb0JtaEljeUlhSkhIc25NY0FSZFUvSk9RS3NySDZTUHla?=
 =?utf-8?B?YUZORWpGVHMySEtrekR6akFZMTNMTENYTlB1a3EyZ1ovYy9aMXhCY0ZtSnpK?=
 =?utf-8?B?ZFE3MjFtcXk3ZlhDMHhCbnBHK0lpQTVCV3B2UHFKd3oyMXBhN0hJYlNaTXR3?=
 =?utf-8?B?azQ2Zy9sR3oxeGpaalVRdlhFWjJtdWc1QUx5T2ZTcW03dHZ0RUlIZGFSNStJ?=
 =?utf-8?B?ZkdtQkQyTjN0NVJqTUhuOG5tRkZJT3czR2FTZFYzcll6ajY5KzV5NWdYNEhS?=
 =?utf-8?B?UFlDbGJiazYraWZxWmhCRDZ4Q3k0Ni9ITndSdzZBdTVHdjd0MTlTVWhJdWFQ?=
 =?utf-8?B?cjdGY3R2TlNWUCtvaVZXSVFUa0c2bE55MDVRcTJoeUI0SmR1L29IeHlWdlZy?=
 =?utf-8?B?b2J1NmkrWk4rcGdWVGRRZGZ0T3g1RG5relJsZWNLbDhRQU9FLzMwL3pZTld1?=
 =?utf-8?B?dDhZSjR3ajNQbjFMcGZpMnhMNUpaYlZwS0NjaEVGd1pSbkl4UDBmTTlCOUZ1?=
 =?utf-8?B?anFCWDgraS9xa2ltU3BlV012V1JKNUxqZ2Q0eEJMeEZkTmxDZFJETXhvRGZW?=
 =?utf-8?Q?VtaUhoqAIWjZS5buIlu1oLEy5cbrWmw0IMhbrVn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247134a3-c5dc-4f5f-94e6-08d9688e7a4d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 12:38:59.8564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgifEpN+rNU2nX16iD/u+pqZWoNW3Tr4e0yONNOlUU9ueN1p6qURGDcxqbKAdBgC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5324
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


On 8/26/2021 6:06 PM, Sharma, Shashank wrote:
>
>
> On 8/26/2021 6:04 PM, Christian König wrote:
>>
>> Am 26.08.21 um 14:31 schrieb Sharma, Shashank:
>>> On 8/26/2021 5:54 PM, Christian König wrote:
>>>> Am 26.08.21 um 13:32 schrieb Sharma, Shashank:
>>>>> Hi Satyajit,
>>>>>
>>>>> On 8/26/2021 12:43 PM, Satyajit Sahu wrote:
>>>>>> There are multiple rings available in VCN encode. Map each ring
>>>>>> to different priority.
>>>>>>
>>>>>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 ++++++++++++++
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  9 +++++++++
>>>>>>   2 files changed, 23 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>> index 6780df0fb265..ce40e7a3ce05 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>> @@ -951,3 +951,17 @@ int amdgpu_vcn_enc_ring_test_ib(struct 
>>>>>> amdgpu_ring *ring, long timeout)
>>>>>>         return r;
>>>>>>   }
>>>>>> +
>>>>>> +enum vcn_enc_ring_priority amdgpu_vcn_get_enc_ring_prio(int index)
>>>>>> +{
>>>>>> +    switch(index) {
>>>>>> +    case 0:
>>>>>
>>>>> As discussed in the previous patches, its far better to have 
>>>>> MACROS or enums instead of having 0/1/2 cases. As a matter of 
>>>>> fact, we can always call it RING_0 RING_1 and so on.
>>>>
>>>> I strongly disagree. Adding macros or enums just to have names for 
>>>> the numbered rings doesn't gives you any advantage at all. That's 
>>>> just extra loc.
>>>>
>>>
>>> Honestly, when I just see case '0', its a magic number for me, and 
>>> is making code less readable, harder for review, and even harder to 
>>> debug. RING_0 tells me that we are mapping a ring to a priority, and 
>>> clarifies the intention.
>>
>> Well we should probably rename the variable then, e.g. like ring_idx 
>> or just ring.
>>
>> A switch on the variable named "ring" with a value of 0 has the same 
>> meaning than RING_0, it's just not so much code to maintain.
>>
>> Christian.
>
> Perfect, sounds as good as anything.
>
> - Shashank

I'll take care in v2.

regards,

Satyajit

>
>>
>>>
>>> - Shashank
>>>
>>>> We could use the ring pointers to identify a ring instead, but 
>>>> using the switch here which is then used inside the init loop is 
>>>> perfectly fine.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>>
>>>>> If this is being done just for the traditional reasons, we can 
>>>>> have a separate patch to replace it across the driver as well.
>>>>>
>>>>> - Shashank
>>>>>
>>>>>
>>>>>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>>>>>> +    case 1:
>>>>>> +        return AMDGPU_VCN_ENC_PRIO_HIGH;
>>>>>> +    case 2:
>>>>>> +        return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
>>>>>> +    default:
>>>>>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>>>>>> +    }
>>>>>> +}
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>> index d74c62b49795..938ee73dfbfc 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>> @@ -290,6 +290,13 @@ enum vcn_ring_type {
>>>>>>       VCN_UNIFIED_RING,
>>>>>>   };
>>>>>>   +enum vcn_enc_ring_priority {
>>>>>> +    AMDGPU_VCN_ENC_PRIO_NORMAL = 1,
>>>>>> +    AMDGPU_VCN_ENC_PRIO_HIGH,
>>>>>> +    AMDGPU_VCN_ENC_PRIO_VERY_HIGH,
>>>>>> +    AMDGPU_VCN_ENC_PRIO_MAX
>>>>>> +};
>>>>>> +
>>>>>>   int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
>>>>>>   int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
>>>>>>   int amdgpu_vcn_suspend(struct amdgpu_device *adev);
>>>>>> @@ -308,4 +315,6 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct 
>>>>>> amdgpu_ring *ring, long timeout);
>>>>>>   int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring);
>>>>>>   int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long 
>>>>>> timeout);
>>>>>>   +enum vcn_enc_ring_priority amdgpu_vcn_get_enc_ring_prio(int 
>>>>>> index);
>>>>>> +
>>>>>>   #endif
>>>>>>
>>>>
>>
