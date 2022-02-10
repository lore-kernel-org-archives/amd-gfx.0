Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B60C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 00:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A01210E6BF;
	Thu, 10 Feb 2022 00:25:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07A5510E6D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 00:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T76ByBcpMN/TBGZN9H+AVXsaZ4BsU1FS8k6qfjHIakMVBBMeJy+Zw5yvZmqt0p1I1Qa4uLPklM+mj0Qb04ZbAyWcELl4YZzGKq5mlExVb6Oi+8aEnDj6veFbCLEFXaY38rlB7j9ZrsA/J55WwWpwOqNF0qIG28UPMG83K5r+aSiEtvodvojpG4C63QZ3SLbGYnCRbP2nOe0DgbQReQkJGkcuUwKzzIIYmUIbL83ZAVK17WPbw1HDmgpNjfCBmHxxv5gax3tbIs+ObHRNNtBdDaYART0ej3SGs/Ey+GGHfwb72XX26t9tO3Wr0tczgNVjz+Y7+RP+56azGACkSXv45w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExuuZkuA63eWgd5NWgh3adS5oWrpY75W0bVcdQYeWYs=;
 b=XIbKXDuZlJQhWnmOXoRYNNf792hwI+2gGR16/02qiBavRLZCCdRVtSHxRL9+iVVOwfVqbftXmLN4RJiYYgNvoP3DQRzf8Grp5H4Td9hV9E1LplhPyvNiDQHcovwWjqJUlarZ0qe2D6F1e3syyklOSWtEbMJ+eK0EdvclIBqXxnCaYwB0weUcvyb0e0bHPyBufy2Do3aJdFq3jdoE1eAyIzhLM0HpT7CBajBpOabTWTTJa941Rv/QwAgolJadE/awTu1wkm2ryZR1FgoUA82FUFyTNOONWLYivx4hd2Yg4Y7EvtmJ58Y2e2qj/nfwHA/FZHOFjLX6A5A+XmDZRGpa8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExuuZkuA63eWgd5NWgh3adS5oWrpY75W0bVcdQYeWYs=;
 b=yaZZ6G6b4FQuzgn9Syn1CL2qj3srho/FIj7ZpoP7jta1puGX0pfYm+i8m8XAJQznRYEZOGps+eWWn/TCAyB0mu2J8W06ascc2YZm2aKz1jSmzFu30Zbtv83rTJv1c/1Z7Py1taqnLRuGIVDw0XDU0vduevOiboYGTT26bLztQnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by DM6PR12MB3564.namprd12.prod.outlook.com (2603:10b6:5:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 00:25:54 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::f071:728c:3813:3376]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::f071:728c:3813:3376%9]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 00:25:54 +0000
Message-ID: <79940982-6f9b-54ca-f1b7-2ccd98c1ea22@amd.com>
Date: Wed, 9 Feb 2022 19:25:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdkfd: map sdma queues onto extended engines for
 navi2x
Content-Language: en-US
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220209161149.347529-1-jonathan.kim@amd.com>
 <f29dbb45-5308-1ab6-481f-6ba9695703cc@amd.com>
 <DM6PR12MB3163056340F8EB2A37BF5746852F9@DM6PR12MB3163.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <DM6PR12MB3163056340F8EB2A37BF5746852F9@DM6PR12MB3163.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:610:33::34) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 991334e3-5d2e-497c-04f4-08d9ec2be61f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3564:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3564061506967D549CA95584922F9@DM6PR12MB3564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rJ5t9SDmwukvJToYpIkdzctjpvvTMKuIsi5z9fyZ9CNipPwCaxyJKvVw5RgWc+witYCFDUO4/Nczc4ilqxiyV3z8N4tMOrbN8t1qV+CXQr8VRl+BZuQj7AK+I99j9aFZltkNusemvTw/KJ745s/0MgFbrI9xLBdRjrje0qfvMWlLWXZv0k2mDQ8Axa1kXw9/FwQBrv89aymiuo0mIypD84uo1zMH/nKYcoBSpU3Gfoe+RWSJP+L6Ars6L6M/3EOfvfPPsVHMItuGgwrRZPdLWcBjlRss6ee52eTF/uTKI41FAmYfVmLHOjPhH8Tuoc/PEb6n4GM0R3Eudc55M5xBtKhHaNr6SurbeajAcTqoq3H2NDd1l7oh1wg1iiBvTkBe/EPRxcRGcXL8hTJtFEeH/unkuuJRrVwivXaIrkxW+0B4i8SXfUSLhZMFVKMP2OqJgeBqIu5lMXYBCfMFSI+ADM0yXPRPpOOCk2BOfrXJxE3rkFJ8JOfLebGNg4ngGfWkslOItLd8mzxGcEeLNu1HnBy20YAA+YBec5d5Opb6Uc4ncXjK3ibdXxBn00rVmXHg8vTlKpFxp6tlcBOasg3EBb7NoWnac0BMcnqQgtbwmU+wsINV9Kd5KHJ4V0CJAIshxLY98F+/FhG7JtqVppSGV2CMydQpCfItfPVq9GRxZy/9qwnoWx5Dnn3es6y0Qfqe7Dp/WtpdpLEhLG2CaUkXzRDo+9FKMEIKIzP0zhcykwmRLcXMCPg4npBV5ofH4p+6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(26005)(2616005)(8676002)(86362001)(31696002)(83380400001)(66556008)(44832011)(66476007)(8936002)(186003)(53546011)(2906002)(38100700002)(31686004)(36756003)(6512007)(508600001)(6486002)(6506007)(110136005)(36916002)(316002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDdrWjBaaHJNa1g3MU9WYlg2SERZYTltWjRVUVEzdERHYmV4ZG9KL29BSFNN?=
 =?utf-8?B?MzRxQ0V1TElQdmJiRXhnNE1wL2g4WGVUZXFjUUVqb1JRL0NoOEdHaGxUZmsy?=
 =?utf-8?B?anZObDNEMHBRcnBLUWo1R2hzRGU1QS9DQTJIdk1JTUNsRDdMZi9GMmRrcURq?=
 =?utf-8?B?Wi93VzVob3paWmd0S040TDA2TTN3SWtKNFA4bitnL0JPSDM0Vm9xT3JCL3Ay?=
 =?utf-8?B?WFUxQlNsN255NkpJNVdxTDdCc1dHRUoxcDFmWXgyU3JzcjN0eTNjZWxVYXpS?=
 =?utf-8?B?N0trMEY1bC9IYkJZZlZ0aDVsVXlrVUdyMTA4Y2xhZ2VRd1dia2dLbzc5VGcy?=
 =?utf-8?B?UjUwUUdaS0dwS3N1dEVkYVNiZHo4bGwwUElBVnRicVBFMzczZzltUW9OSmF1?=
 =?utf-8?B?TCs5cG1DRHpNSnpjQnQ2SVZERWtDRllsdXVpTlN5R0RBbVJHOTdvN1FkNDRC?=
 =?utf-8?B?eFdSTjI2WUNERjR3bEl4d0J6bWxnRUlPaGdKVmozM1hyOFVKcEhOUG8rdzl3?=
 =?utf-8?B?eDRsY0FleHVIWXJrU3lGK2d3c29VMkVwWFppUEJWMHZjZ2pIL2hlcjVUZ054?=
 =?utf-8?B?a0puYzdOSmhHcGVPT251NDIwWjZZSUV5eDFNOEVoQklwbEVzZ1Q2OFVvYjM1?=
 =?utf-8?B?a3VaaE9najZJZ25mdEdvbC82SmpXNFlPeWJRVFFmRzZwanNBT3h0cVRMTGxh?=
 =?utf-8?B?NnA2eGdFVW41UENNVjIyL2JOeXFiSjBwZ0JJRU43eGx3UStFaTZHV3NlektB?=
 =?utf-8?B?Y1N1K3JjYmhBNkJ4VXZlQ1BvelorcTF1OFloQmNKR0t0cmtNOW5kMjU5TWxZ?=
 =?utf-8?B?QzBzdzhuSXVnaE5qbkg4VnhRWkhNL1dlZnJEUDBFaGJ2Sy9zVXM4dDNiY2tX?=
 =?utf-8?B?WWRTOWNOUElxMm5aaWc4ZU1adU0zeml2T3QvcWZYVFdnTFBLTVpsOWt4eXk0?=
 =?utf-8?B?UkJDWlljM1lweWp0U2hKeEJiT2gzR1NENmE1K2ZKK08wejBPaUt5bWJmNTRj?=
 =?utf-8?B?bVZLY1J4ZmZWanJUK3UyR25pYnNiMUxMdWE4V25PWmFyeEovUytCcW5jUUtn?=
 =?utf-8?B?ZjlLRk1zZWtnM2Vwdm9tZzQzL0JXaHZLL2dXZ0N6bW93cUZwQzc0cW9IWVJV?=
 =?utf-8?B?WnpuN0FIRkZ3VFZuellEZDRBZ0I1bXRUdS9TenJWRDVHMEdBcEQrbTFCQlVR?=
 =?utf-8?B?M1p5T3JYTkhubE8rcTJ5YXRESVNQcTZSU3N6Vm5xdGFsN3U2dFJHOVA5THdo?=
 =?utf-8?B?L1NvbStiV0dPR3hvaW5oT1licFgxYlVKUFd2MnEwQmZ2VnVUdjVYcVlNVnpV?=
 =?utf-8?B?N0IyRHJGL0tkeHM3aHg3YkszOGNJeDBUUjluZTNVdG8rSWpzODJrNDFYelF0?=
 =?utf-8?B?RS9tWXFFUjV5TXZzTGswaHJNY0FTY1lqYTlYRTlWMGdQRHFUMElPVlZ3TXVN?=
 =?utf-8?B?MThSdU85T2xoa3M2MGZwSFAzYTJYMi9TTXhHbW9xR0ZoOGNtK1d5MVkvc0hp?=
 =?utf-8?B?NWNqODNXZ3Y3YTYwSTFEclpoVkkzYk1iZTVNYmQzV3VKRlJCbzVvNDJ6Rjhw?=
 =?utf-8?B?NVBodjNZb0J5NlZyV2ZjUkNtdCtzYUMySVdha2M2THRQS2lKUXd1emtQQ01X?=
 =?utf-8?B?cUlqMVViaG1Sc0M3MVRhWmE4NEh0SFRBanExQVhaRjI2bTdLMDQ2V0FnaW1V?=
 =?utf-8?B?dVBHUUYwYjlHYWNjR0RISGFWaTRQOTFGSFk5dFJuZEkzNng1cjcvRFVZcy9V?=
 =?utf-8?B?RFRvK2hmdlA1dVhBbHZmNGdJOHl6QlZRWFZXdVFGSGxvSnVwb3FuaFNFL1c2?=
 =?utf-8?B?ZW5oWlFyaUh1N0ZVOUtuOEF5Z3NkLzF0aldqOWpkTGJCVTFMaXc2MlhMZ3l4?=
 =?utf-8?B?c1JJa0xLSTNDYnhWOWlKSTZvL1Q2WlEvYUV3ekRRUWhLZ2FGUk1LN0VYcTZG?=
 =?utf-8?B?SHF6aHpVOXBQY3lHTjRsNTFQQS9NTFp6b1BoOUFSdkI2OStmKzB4MGJrTzlt?=
 =?utf-8?B?bVJtcWZySmx4SzNpUGtXV2o3YmVlOUErL0ROUCsvZGxpeEdmVjFpbXEzcWJN?=
 =?utf-8?B?by95cDZTWUNJeS8vTnRzSDdvNlBpUCtIc1ljMGkvMm5FcC9YS25NYkZoRENn?=
 =?utf-8?B?cnVMNUFaQjlVWG9OMU1zUEp2dDdVYytNVTd2WEJBM1ZnQkZoNWVtMEdLaTFm?=
 =?utf-8?Q?3bLgLsUKBKSALDIFLo3OHug=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991334e3-5d2e-497c-04f4-08d9ec2be61f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 00:25:54.6144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDYC2yfE7VVdDJ9P420ChabqmNHWFoWwEBjHqqkRLzTcwpNOi7UDVS39J15UlzjqeF5jAGJ/b+C+Y09xt4xCKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3564
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

On 2022-02-09 19:18, Kim, Jonathan wrote:
> [AMD Official Use Only]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: February 9, 2022 4:26 PM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdkfd: map sdma queues onto extended engines for
>> navi2x
>>
>>
>> On 2022-02-09 11:11, Jonathan Kim wrote:
>>> The hardware scheduler requires that all SDMA 5.2.x queues are put on
>>> the RUN_LIST through the extended engines.
>>>
>>> Make extended engine unmap available as well.
>>>
>>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>>>    drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c       | 5 +++--
>>>    drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c    | 8 +++++---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c    | 3 ++-
>>>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 5 +++--
>>>    5 files changed, 14 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> index 7f6f1a842b0b..f12e32335eb3 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -1555,7 +1555,7 @@ static int unmap_queues_cpsch(struct
>> device_queue_manager *dqm,
>>>              return retval;
>>>
>>>      retval = pm_send_unmap_queue(&dqm->packet_mgr,
>> KFD_QUEUE_TYPE_COMPUTE,
>>> -                   filter, filter_param, reset, 0);
>>> +                   filter, filter_param, reset, 0, false);
>> Does this still work correctly? We currently rely on HWS unmapping SDMA
>> queues when we request unmapping of compute queues. Is that still the case
>> with extended queue selection in map_queues?
> I wasn't aware of the implicit sdma unmap ...
> That makes much more sense.
>
> I followed up on the FW spec and apparently as long as extended_engine_select=0x1 (sdma0_sdma7),
> a single call to unmap all queues or all dynamic queues will unmap both compute
> queues mapped in legacy mode and sdma queues mapped in extended engine mode.
>
>> How would the caller know to set this to "true"? For mapping, this detail is
>> hidden in the packet-manager implementation. But for unmapping the caller
>> needs to know? That doesn't make sense. But we could probably remove the
>> SDMA filtering functionality from pm_send_unmap_queue completely. I don't
>> see any calls where we try to unmap specific SDMA queues. Since we always
>> have to replace the entire runlist anyway, there is not use case for it.
> Agreed.
> Aside from removing SDMA checks, maybe also pass the device itself through to pm_send_unmap_queue then?
> Or could it be the SDMA ip version?
> That way we can hide the check to toggle between extended_engine_select = 0x0 or 0x1 from the caller.

You can already get that from the struct packet_manager *pm. You can get 
the dqm with container_of and get the device with dqm->dev.

Or add a flag for SDMA extended mode in the pm structure itself and set 
it in pm_init.

Regards,
   Felix


>
> Thanks,
>
> Jon
>
>> Regards,
>>     Felix
>>
>>
>>>      if (retval)
>>>              return retval;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>>> index 1439420925a0..8694cfcd57d1 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>>> @@ -371,7 +371,8 @@ int pm_send_query_status(struct packet_manager
>> *pm, uint64_t fence_address,
>>>    int pm_send_unmap_queue(struct packet_manager *pm, enum
>> kfd_queue_type type,
>>>                      enum kfd_unmap_queues_filter filter,
>>>                      uint32_t filter_param, bool reset,
>>> -                   unsigned int sdma_engine)
>>> +                   unsigned int sdma_engine,
>>> +                   bool is_sdma_ext)
>>>    {
>>>      uint32_t *buffer, size;
>>>      int retval = 0;
>>> @@ -387,7 +388,7 @@ int pm_send_unmap_queue(struct packet_manager
>> *pm, enum kfd_queue_type type,
>>>      }
>>>
>>>      retval = pm->pmf->unmap_queues(pm, buffer, type, filter, filter_param,
>>> -                                  reset, sdma_engine);
>>> +                                  reset, sdma_engine, is_sdma_ext);
>>>      if (!retval)
>>>              kq_submit_packet(pm->priv_queue);
>>>      else
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>>> index 7ea3f671b325..08f736080b7e 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>>> @@ -183,6 +183,7 @@ static int pm_map_queues_v9(struct packet_manager
>> *pm, uint32_t *buffer,
>>>    {
>>>      struct pm4_mes_map_queues *packet;
>>>      bool use_static = is_static;
>>> +   bool is_sdma_ext = q->device->adev->ip_versions[SDMA0_HWIP][0] >=
>>> +IP_VERSION(5, 2, 0);
>>>
>>>      packet = (struct pm4_mes_map_queues *)buffer;
>>>      memset(buffer, 0, sizeof(struct pm4_mes_map_queues)); @@ -214,7
>>> +215,7 @@ static int pm_map_queues_v9(struct packet_manager *pm,
>> uint32_t *buffer,
>>>      case KFD_QUEUE_TYPE_SDMA:
>>>      case KFD_QUEUE_TYPE_SDMA_XGMI:
>>>              use_static = false; /* no static queues under SDMA */
>>> -           if (q->properties.sdma_engine_id < 2)
>>> +           if (q->properties.sdma_engine_id < 2 && !is_sdma_ext)
>>>                      packet->bitfields2.engine_sel = q-
>>> properties.sdma_engine_id +
>>>                              engine_sel__mes_map_queues__sdma0_vi;
>>>              else {
>>> @@ -249,7 +250,8 @@ static int pm_unmap_queues_v9(struct
>> packet_manager *pm, uint32_t *buffer,
>>>                      enum kfd_queue_type type,
>>>                      enum kfd_unmap_queues_filter filter,
>>>                      uint32_t filter_param, bool reset,
>>> -                   unsigned int sdma_engine)
>>> +                   unsigned int sdma_engine,
>>> +                   bool is_sdma_ext)
>>>    {
>>>      struct pm4_mes_unmap_queues *packet;
>>>
>>> @@ -268,7 +270,7 @@ static int pm_unmap_queues_v9(struct
>> packet_manager *pm, uint32_t *buffer,
>>>              break;
>>>      case KFD_QUEUE_TYPE_SDMA:
>>>      case KFD_QUEUE_TYPE_SDMA_XGMI:
>>> -           if (sdma_engine < 2) {
>>> +           if (sdma_engine < 2 && !is_sdma_ext) {
>>>                      packet->bitfields2.extended_engine_sel =
>>>
>>        extended_engine_sel__mes_unmap_queues__legacy_engine_sel;
>>>                      packet->bitfields2.engine_sel =
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
>>> index 3c0658e32e93..a83aa94972e7 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
>>> @@ -200,7 +200,8 @@ static int pm_unmap_queues_vi(struct
>> packet_manager *pm, uint32_t *buffer,
>>>                      enum kfd_queue_type type,
>>>                      enum kfd_unmap_queues_filter filter,
>>>                      uint32_t filter_param, bool reset,
>>> -                   unsigned int sdma_engine)
>>> +                   unsigned int sdma_engine,
>>> +                   bool is_sdma_ext)
>>>    {
>>>      struct pm4_mes_unmap_queues *packet;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index b6790a637f5c..b157ba0216f0 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -1249,7 +1249,8 @@ struct packet_manager_funcs {
>>>                      enum kfd_queue_type type,
>>>                      enum kfd_unmap_queues_filter mode,
>>>                      uint32_t filter_param, bool reset,
>>> -                   unsigned int sdma_engine);
>>> +                   unsigned int sdma_engine,
>>> +                   bool is_sdma_ext);
>>>      int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
>>>                      uint64_t fence_address, uint64_t fence_value);
>>>      int (*release_mem)(uint64_t gpu_addr, uint32_t *buffer); @@ -1279,7
>>> +1280,7 @@ int pm_send_query_status(struct packet_manager *pm, uint64_t
>> fence_address,
>>>    int pm_send_unmap_queue(struct packet_manager *pm, enum
>> kfd_queue_type type,
>>>                      enum kfd_unmap_queues_filter mode,
>>>                      uint32_t filter_param, bool reset,
>>> -                   unsigned int sdma_engine);
>>> +                   unsigned int sdma_engine, bool is_sdma_ext);
>>>
>>>    void pm_release_ib(struct packet_manager *pm);
>>>
