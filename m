Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C55C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 17:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE9BA10EE2F;
	Fri,  4 Feb 2022 17:07:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED6F910EE2F
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 17:07:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ak9FMfEvc+PaRi3hincxG/BolFTAsGJwOxeCRsyJXKy6ds+PYcExry8cLcQbZNFRKo/vGwPgEQx1dqqE0EvRRq9sd80v+SrDGMAdKzdJhlB2CA0ufjLpXPIWtno6PcHQl1/zmpM26i0j40iP/aoYvpFI1OlW+13tGhPzXcv9SUIoFTO6dsWpPJoFvDnui4Bizqa9MaD54X5jU2AU5KZpWiu+IyrNNqOV1mn45TjbOcal2Kb0OBiJc31BpX0nNt5NAWmZfj8AXK7NPn2gfaXsYn9Xr8J6b1psCOox38GJpAQNrUHIBqtis+ERB5DqeNpTTdK+RMBQVpMZ9dsRj3kINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XkjSi7CMcBEfoEglSXUrwlW10qa4P94hcBSy1VWAOA=;
 b=g2Ot0LWN+2DMLvLUwoS7qvSogbWIvpSi0A2DewSPwWWLPwvt1XerZBiDACrqzJkEZlWvyDLP+XtCZouKA62jX3hGclKHAgdTvvBrUZwWyI8JqU15QJMXxkF/HcPq+QmEl/5ffxUeQ4GhJKLYWDsq5UKxV4TXZlQqn3plaMDg2vueqlwQAzgl9ostAoEFU2tRdK6fh1v+XQ2LerwOW+GwJuNf79Gu+TXyUaSnXJJR3SU8Bk065X2ooIwL/RM/2SFrFxOxi1SF1vmJu/XYRI87eAgBlXXDw07nUQIVofkMvVFvAGKWuMzNisUlZRaAc3OivNAzVuVbmCv1NitwwcluDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XkjSi7CMcBEfoEglSXUrwlW10qa4P94hcBSy1VWAOA=;
 b=y429UqmOj4sujPD1j+WJ7f8p/2IDcSjrRWd8N0wuIg8u4HH/1/93cKnFnO757m1EPfr5kWXg5uMH3ccFtZ1p6qobu94L/oy0zojHhe08SDN8LQFE7A6agBQBskiakL4Dr4tOmGFjAJ54mNuhtU/OJ01qOceKoNvLw8JCtpPtoWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CY4PR12MB1141.namprd12.prod.outlook.com (2603:10b6:903:44::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Fri, 4 Feb
 2022 17:07:20 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 17:07:20 +0000
Message-ID: <77fd42df-be70-18bd-ebb8-503214ef6af8@amd.com>
Date: Fri, 4 Feb 2022 18:07:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Content-Language: en-US
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
 <a0693436-619c-efa1-b3f1-2fca6377e2fe@amd.com>
 <817df2c3-e7af-92cb-53f8-8bc70b69b988@amd.com>
 <BYAPR12MB46149A07EB030CB27FDA8B1397299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <8bada9e4-d6d5-e11a-45fe-aea7615f3356@amd.com>
 <BYAPR12MB4614325D69EACA459547E4F597299@BYAPR12MB4614.namprd12.prod.outlook.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <BYAPR12MB4614325D69EACA459547E4F597299@BYAPR12MB4614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0267.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::33) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8e2c561-5ea3-451f-9bf2-08d9e800cdca
X-MS-TrafficTypeDiagnostic: CY4PR12MB1141:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB114195F7FFF6ECA927975472F2299@CY4PR12MB1141.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fHHJt4nylGMdNx4kZPHpXcpQ/VqRmXal6sy0PrLDnWAqi85ICUFqBko/bNrkmGzlrQNEIzAMn9bENRm76BkAqE8d0w5mQwL+7fe8oRP2+kaqJSr42kV4EgyNl7j9t85NJqI9vbfqar2uqNU6XrWdkFWYithKYd7QsnzDtesyWFaCgUfZB9q2EQ7PCCPymi8ATAFGcC14dAM9zEjBp0EgoHYybaval5G8gPJ63zKietdl++VSFrT422aTXlkjajReF+8eb1NjdtLNhRYkL5Wi7AovpauSCbdpDTZoSSBBiI7IVz9rVqVzxyo6RSGoSPdAghix2vwDA20yYZpx5SyHEC4rmueihS/nzatMp/JnM7Wb97r1SP0OoEA/cyw8+6MhTEqmITfAVbQMWxxhQLcc41PM1fQ3crjLQKsvxVaH49AfDjhPepB39da40QO/Zypwg42lrshGULJSnhA2Xr/emAfn1VxR9JeYaXElKy5lpK6k1CglD7dbgASPUKHsJuHka+XmUqIXnRgWqP9PYGEfZdaY1j/iZdiVSBMZML4zv1zEYVNCs8gZ3ylv7Vqr4kr3nN0QjYWq0xYruqJ/3KKUcGlAjBnmqhBn7qt+F8o05Hs2iGjRerhWyHsEczykL2UjBJqBR3M1ubDXCLo2FAqDueERf5Km6Ozb52M8UVzjB/N+qMU8kjzGTbktz6K2P7xecSajfANBfjKqEUNmBbYLGswQ3awRFegDdyDhz89ooXR/0InN9Thmau8tlgrdemj9LBVXUF80TIaR1mu206oGoEFlrlbV85vX1xYcPDI/voz8wE8dei50zkCq7psjjisx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(54906003)(316002)(86362001)(6506007)(6512007)(6666004)(83380400001)(966005)(8936002)(110136005)(26005)(186003)(2616005)(6486002)(53546011)(8676002)(31696002)(38100700002)(2906002)(31686004)(36756003)(66946007)(4326008)(66556008)(5660300002)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NndZZjdmQ0lOdEF3c3BQUmpiM29FWVBiWVRCaWk0YU5XWTlqbUNxUCtYdUVr?=
 =?utf-8?B?WHBYWXNpWjQ0dUZuWjF4c25ENlIrMCtrNmxGeU5OVFU1MndKbUF6NzhqVmNp?=
 =?utf-8?B?Qk1zd0d1dlZkZTJhajRoSEllYXE1R0FOaGw5QVhWeExObmlRTWpNeWhxUE04?=
 =?utf-8?B?enJacWR6ZnNYcWova2JaL1NsSlFxWDA5eUVjczdObVptRTBKSDQzc2UzNm1t?=
 =?utf-8?B?UXhJdXpnaitpenQrMHk0b3YrTWlhSWNNZk4wNEJqM2R6QnJHODl5K2hvZmx6?=
 =?utf-8?B?OThKb0s5b1ZNOEpNV0l1Q3Z2TGlYaWxtMVZWWGk0UmNhN3FhSk0vNTNld3J2?=
 =?utf-8?B?a3pYRWtnLzZuNzY5dy9kQkJpa2JldU15T29iSnNWRE1OMTdKdE15d2ltRVVW?=
 =?utf-8?B?R1JuQTZqekYyWlZIa3oxMzNQM1UrOWN0cVB3dDV2bS93QVpXL2pXekJ5MGpa?=
 =?utf-8?B?UGM0bDBnUW5aZ0ZYUE9YOWRhNnVNVFhxOVJ4Mm1scGQ1YmFGQzlkdU5TdWwv?=
 =?utf-8?B?dFdqV2U2TVExanVwRmQwMytJVy9kQU1VOGl6Yy9tQlRHcW9wMnh5R0JRVFVS?=
 =?utf-8?B?V0E4MDhtRkdFZzFxa0l3ZWE1OE9ZYzM5Rk84TXozY05xQW93b1JDR0ZoSU85?=
 =?utf-8?B?eS9qSHJ4Q2JKY29sMk1mcHJya2tiMlBaSlVIeVlSVy84NFp2dEVTQ0hLMVc4?=
 =?utf-8?B?d2E4ZXRRZUNZYVVkVnVZQ0pSK2V0ZDRiNzdNdCsrTEhDU2QySkE1KzJ2R0Yy?=
 =?utf-8?B?LzFvNXF5UDc0RUF4MVFHekVRUHVMY0psNkpDb2ZXM2FaZGNmZDNnbHZCSkdD?=
 =?utf-8?B?TFh6UHBGSWRjZVd2eFdCZ3NVbldod1RrUHJZU3pBY0lDeVBzaDB1cU1TR2Ev?=
 =?utf-8?B?R2o0K09NUlhpRnV3dURlWi9hMWxUbWU3Z2h5MkZQYXJIRWU2TmNwcU5GNTlL?=
 =?utf-8?B?ckJidkl0bUJ5R0U5SkdVYXNtRjc3OXB2cVJsSE1JNUI4a01CbzEvWUU4NXBq?=
 =?utf-8?B?dHFCSE9lamZyNEtrdm9UMDFXakplbHJTYTdZUzNCbzVCUkZCYU5hdjhtaVd2?=
 =?utf-8?B?bDdyckZteitVd25KVjBVYmZsOVlobE5CUVFRelkzTEtaOXh4bnQ1Q2M1Y0Qv?=
 =?utf-8?B?czBha1F3OHVvM0tpMzVLdG1CNmcrdUZBTURkNUdTdDdRZWI5czI3WFREWlhY?=
 =?utf-8?B?dU1DRXQ0WVE3ZUZzSUZSekF2WnVBOVhIVEtna1lXVXBreU1Oc0Z5TC9nMG4x?=
 =?utf-8?B?RXRsMXV1ektkT0VJcWRQVjc3OWw1QkpBRHB1RDQxMVBZY2IwclcxdjJYMS9n?=
 =?utf-8?B?ZkxBR1hmRDNDZC9ySVBTQkV6MHpVT3Vmc0IwS3V3MFkyclBVbUdiOTU2a0Zw?=
 =?utf-8?B?cGlLVFVRZlVDb0ZMQVVZY1VnallRTUZpaVhNNmJuczQrT082MktRZkUxN0ZM?=
 =?utf-8?B?WEhxK1NXNHZtdEFvSDBVYUtUNUxPRUs0eDhKVmtYQmNZWmtrMHIwVjVodlI4?=
 =?utf-8?B?bEZaOVhIZkdNRkx2dW5RQzBqekRUL0Q5U2gwNjlHMHZDcGdDSVFveUU1Znhx?=
 =?utf-8?B?VDRETHZTVVJ4SzkzeCtuOUhCcXZ6VmFWbDZsK2Q3dDhMQU9QL3dCY0RPR0JB?=
 =?utf-8?B?UVJDVUFUUFFmZmFKS0FmVFcrSFIrbE91RTcyQnRKR1pCaEtLb1hZVXdHcnVt?=
 =?utf-8?B?WmczRVhCQ0hkbGlETDhUb1A4ei9wRDZJcng1V0srUmZiMjlUSGJaSEtNSGZG?=
 =?utf-8?B?TFFBQmRwREVZMHZBL1JWQ3hrNW9IZXJZLzhabmVRRG5zdUVXaE9wZTVSU3R2?=
 =?utf-8?B?SGpXQ284NnBJM2ZCUThNcFpTSEVqcUFWSytXd2pHY1VBZnora1R4ZHdKanJR?=
 =?utf-8?B?RkdENkIvbUp6N0xyMXRhRTlmUmxER002dlRDTHFVbzJKaHF1czg1a1ZHd1gz?=
 =?utf-8?B?R1ZGRVVxR1I3SzI5emloVFE1TTZ5dDFnMWcxbzdZWGhiZ3RwbkZkMUJWY3JE?=
 =?utf-8?B?bm5EQ0w1MDVtODNNdThobUVaYkxJZStWKzlLWTMwdDVMNjY5YXRQbUVMNGdO?=
 =?utf-8?B?a2hINHM4TTVjVzVQTXltTGZ0WkN0SWI0QW9xdXgrOFJTSDU4UmREdkNIUGk0?=
 =?utf-8?B?SExTS2lWdmJUaTg4alBRNXAzQVdVdGw2SDVheVNNeVdWY3BwTm00MGJMMG04?=
 =?utf-8?Q?V+iOZYQo+TmA27IpYGElRJ4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e2c561-5ea3-451f-9bf2-08d9e800cdca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 17:07:20.2230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uuQtBHYH8CjUpv2hfPsTZTZgr/4xzGrlb+BSIShHUcQkI9o8XQm2rQRitOdALNEJsXecfr0ezZzm3Uak/vs+Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1141
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/4/2022 6:02 PM, Lazar, Lijo wrote:
> [Public]
> 
> The problem is app doesn't know why the reset happened. It just receives a bunch of registers to be read. On what basis an app can filter this out?
>

Again, that is contextual analysis capability, which needs to be 
embedded in the reader app. Even if we filter out the S3/S4 resets in 
the kernel, the situation remains the same, isn't it ?

- Shashank

> Thanks,
> Lijo
> 
> -----Original Message-----
> From: Sharma, Shashank <Shashank.Sharma@amd.com>
> Sent: Friday, February 4, 2022 10:29 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
> 
> 
> 
> On 2/4/2022 5:50 PM, Lazar, Lijo wrote:
>> [AMD Official Use Only]
>>
>> To explain more -
>> 	It's an unconditional reset done by the kernel on every suspend (S3/S4). In such a case which process is going to receive the trace events?
>>
>> Most likely use case would be related to gpu recovery. Triggering a trace on every reset doesn't look like a good idea.
>>
> 
> If you observer carefully, we are just providing an infrastructure, the application's intention is unknown to us. In my opinion it's rather not a good idea to apply a filter in kernel, with our interpretation of intention.
> 
> For example if an app just wants to count how many resets are happening due to S3/S4 transition, this infra might become useless. It would rather be a better idea for the app to learn and ignore these scenarios which it is not interested in.
> 
> This could eventually be just difference in design philosophy maybe :)
> 
> - Shashank
> 
>> Thanks,
>> Lijo
>>
>> -----Original Message-----
>> From: Sharma, Shashank <Shashank.Sharma@amd.com>
>> Sent: Friday, February 4, 2022 10:09 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram,
>> Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
>>
>> Hey Lijo,
>> I somehow missed to respond on this comment, pls find inline:
>>
>> Regards
>> Shashank
>>
>> On 1/22/2022 7:42 AM, Lazar, Lijo wrote:
>>>
>>>
>>> On 1/22/2022 2:04 AM, Sharma, Shashank wrote:
>>>>    From 899ec6060eb7d8a3d4d56ab439e4e6cdd74190a4 Mon Sep 17 00:00:00
>>>> 2001
>>>> From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>> Date: Fri, 21 Jan 2022 14:19:42 +0530
>>>> Subject: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
>>>>
>>>> This patch adds a GPU reset handler for Navi ASIC family, which
>>>> typically dumps some of the registersand sends a trace event.
>>>>
>>>> V2: Accomodated call to work function to send uevent
>>>>
>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>     drivers/gpu/drm/amd/amdgpu/nv.c | 28 ++++++++++++++++++++++++++++
>>>>     1 file changed, 28 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> b/drivers/gpu/drm/amd/amdgpu/nv.c index 01efda4398e5..ada35d4c5245
>>>> 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> @@ -528,10 +528,38 @@ nv_asic_reset_method(struct amdgpu_device
>>>> *adev)
>>>>         }
>>>>     }
>>>>
>>>> +static void amdgpu_reset_dumps(struct amdgpu_device *adev) {
>>>> +    int r = 0, i;
>>>> +
>>>> +    /* original raven doesn't have full asic reset */
>>>> +    if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
>>>> +        !(adev->apu_flags & AMD_APU_IS_RAVEN2))
>>>> +        return;
>>>> +    for (i = 0; i < adev->num_ip_blocks; i++) {
>>>> +        if (!adev->ip_blocks[i].status.valid)
>>>> +            continue;
>>>> +        if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
>>>> +            continue;
>>>> +        r =
>>>> +adev->ip_blocks[i].version->funcs->reset_reg_dumps(adev);
>>>> +
>>>> +        if (r)
>>>> +            DRM_ERROR("reset_reg_dumps of IP block <%s> failed
>>>> +%d\n",
>>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>>> +    }
>>>> +
>>>> +    /* Schedule work to send uevent */
>>>> +    if (!queue_work(system_unbound_wq, &adev->gpu_reset_work))
>>>> +        DRM_ERROR("failed to add GPU reset work\n");
>>>> +
>>>> +    dump_stack();
>>>> +}
>>>> +
>>>>     static int nv_asic_reset(struct amdgpu_device *adev)
>>>>     {
>>>>         int ret = 0;
>>>>
>>>> +    amdgpu_reset_dumps(adev);
>>>
>>> Had a comment on this before. Now there are different reasons (or
>>> even no reason like a precautionary reset) to perform reset. A user
>>> would be interested in a trace only if the reason is valid.
>>>
>>> To clarify on why a work shouldn't be scheduled on every reset, check
>>> here -
>>>
>>> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/am
>>> d
>>> gpu/amdgpu_drv.c#L2188
>> In the example you pointed to, they have a criteria to decide what is a valid reset in their context, in the kernel side itself. So they can take a call if they want to do something about it or not.
>>
>> But, in our case, we want to send the trace_event to user with some register values on every reset, and it is actually up to the profiling app to interpret (along with what it wants to call a GPU reset). So I don't think this is causing a considerable overhead.
>>
>> - Shashank
>>>
>>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>>         switch (nv_asic_reset_method(adev)) {
>>>>         case AMD_RESET_METHOD_PCI:
>>>>             dev_info(adev->dev, "PCI reset\n");
