Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1C3D59F53
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 17:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4393010E08C;
	Wed,  6 Nov 2024 17:21:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZJ+dbRjK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7B210E08C
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 17:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdklFdlEuMzMCOs2zSa2Kh0wlqLowbfhFzNK0tFiKaaxg+o99uHhO2JANttLjM03HFRwE2Es/FmlNopb9sClV2s6nhxzP++z5l4K/VPp3d03SUvviakLzxQc7yibItsPJ0bnc+dL4Ksf1p7XaVAIatcjewxOyRbl8kwdmgQWQEOxHVSMVBbyqtkd1PyYiqAa6W9FBW558bF2NZZp554720MSBnYIIxqoCtLFVoCh/k+zKuMOoFbQrm+sXNWxkBajpb2LO3oQIO+eWFjGjYZrfdV7GRb+/COEBFtk7pyqLCEltHl8c73Az1ChGvFf4oFBydT26gqD+BfngC8VuK+9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3sVw5ChboI/V/CNPtPeCmtCtVGNiIP7lhH8ihag4uw=;
 b=xnUFK4vveO5+jRJnZBU1HBy9D7djPUwXxxws6ftHkeJQFIIdbw4GRd6IRfbjOeZV0FNttS5Js7ZTbFnNwDOV4NPj+UkoSdsqI0AbqpR99A/wp/zYcE5kmqMJBkDShzDXT2kzPeQ2sJF6Fqe8GXruxuC0G2JGzHX4WkCskPxVxkpYnDkJYQsesWkg7tBNUj0y8t7eltPJIupJrxfIKWuhoWGxTZN6aAG34AERspFrJTwPGeV0sfDL+R2/0t77j89FccjeWUSvAnh/OtcRJngbx0Pq+gNI/iNHIwgdhgYoFBSJZ1FEQiG1FJgQJH5AEEq+0+p6Temh3tBj8cn7hWGXPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3sVw5ChboI/V/CNPtPeCmtCtVGNiIP7lhH8ihag4uw=;
 b=ZJ+dbRjK3d9qQSrZwua1NqGcmJmhvxkP7jwyLxANVoIdNsMpWo6BJ9Y0Ov37l/+SYJn4Lw2Hr21+o7o1eIvSn6P1sElhA7kgO572iG18AyeTJxFAYUFOaeshL4KjsVYqoQik/SxY6dYBl89IuZbKTb3U1P8UmqNeiOKIUwNSX4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 17:21:46 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 17:21:46 +0000
Message-ID: <9af6ca27-6d3d-45cf-82fc-1b3f54b88a6c@amd.com>
Date: Wed, 6 Nov 2024 11:21:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Differentiate logging message for driver
 oversubscription
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241028214014.59940-1-xiaogang.chen@amd.com>
 <db7208d0-f36b-4223-a6da-b8b050f7a074@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <db7208d0-f36b-4223-a6da-b8b050f7a074@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:806:f2::18) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 451eab25-69ea-44f0-850a-08dcfe877dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUx6UXFZcGhFRlFFZG9jUGkvRkVpeHpyT1lyV3dXY1RGbUloaVVnaTRhMThE?=
 =?utf-8?B?dE1xaVlORk9FYnBDMjRDT2JwUWwva3V6OWY5YlE1cG5Zc3dWT3FPS2JpZjBV?=
 =?utf-8?B?cktSNCtOYjhybGtCUTNsVUw1c2VLWjdXV2pjUjFzR3JUNTdtMUhveHUzUGRx?=
 =?utf-8?B?ZVk3OWJ4TytDUjBraUo3czVleUtudjA2UDhzajNqMjc2Y0pBQmNsWVMrVEpl?=
 =?utf-8?B?aFpaZm14dTRaZW1kNmFFZEJjRG00VUhsdHd5MUZlVEU4ckNxRkNlNVZGQXp4?=
 =?utf-8?B?TkxVejNDN1IrLzdJdEkxVXRsOGtYS1hGZUJuMnFaOFE4ZW1Kb0U0c1lBODh6?=
 =?utf-8?B?SFpUSk5NeWNSUGNWV3h5ODlpRkpNUWVXSlQvWVlsZEpkOThLbTFzWjVvN09E?=
 =?utf-8?B?ek95Kytvend3Q29ZYVNHMEdXODR5Rll0YjZBOHJkYk1IQklzU0JickRlVXFC?=
 =?utf-8?B?ZEdSTjJ6WnA5WWNFN2MyayszUVlHVGJ0clRPY21vZSswMGtUMGx0OTMvTkp5?=
 =?utf-8?B?M2xsRWRZWG5rNUZTa2xPTWVQZTB4aHl4TlV5cUxaY09nQmJodEVJOVFBVTNV?=
 =?utf-8?B?all6UjBxV2g4U1lKRnoyZk9SenE0QnppS1VKL0VlMUdCeWYzRk42ZkZtcEtL?=
 =?utf-8?B?Wi9oOWwxczBwbFl4S2E4MkkxR1p2Vjc5aHA3U3NKK1ExWDlOOG5EWjhaN3hY?=
 =?utf-8?B?QVB4eVhSdTFicE1YNHU5OUpnRlNncGdXLzQ5MG9qdVo1ekY3VjVoMEFxeFN3?=
 =?utf-8?B?eTBYWUluZlRISURjZ083Si9HQXB1V2JBdkdYaVRPb3p2bnZhYlE4UzJvaDNY?=
 =?utf-8?B?R0ZDT3pVc0IyYWUrVU1NUnc1T1EvK2FvZnk3VEJtdXZCTVF4cWVkV0JrUEc5?=
 =?utf-8?B?OXAzQmhIWllTRGw5cG9Gc0pwTmg2WTZMYTIwREN0UnBYSmpiN1dMNTJ1V0NY?=
 =?utf-8?B?UDEzaWtaSjRDSUl1MUpBblRGK3ZGYW5BTHdsMlhmOGNoemtZTHVEcWhZKy93?=
 =?utf-8?B?NGpLeS9oMU5OYXV2TTRqUzh3ajc2YktCejErMEhpYVB1REE4clVPV2dxbjBM?=
 =?utf-8?B?aXdPUEJCYTkxQ0k1Rm5SUU5kL0RnaCt0RDlHYXgzUGlwbUZ4T3RmMVJtY3ND?=
 =?utf-8?B?NjkyYXpFRng4V0tPK1l4SjFId1hqRXIvWVpHNDBSeFpDaWFEc1R0eXMvbWhG?=
 =?utf-8?B?a1h1OTNJWDBHQjlsakZKUUlmdWNoMG9YRHUvVTNjN1J0d2xXUG94eGxJaGN3?=
 =?utf-8?B?ZElaR2lGa01FOEdHTWxWOHNIdGVHTGIvK05HU1dydW5sUTlXcEhMNWRIRGMz?=
 =?utf-8?B?YlRka3Jvckk0TjVTbDRsejN1U1oyYjl3ZjVLVnI4YVkrazlVa3dKNUNXS3U0?=
 =?utf-8?B?NmFldGk4TFNYeFVxUEJrNDFscEJ5K1ozTk5IMG0wODRaR2UyWnJIMkR1bklQ?=
 =?utf-8?B?dkNPamRjYmRJMVV3aG8xNFpQZndab2ppQjVnczl2TTdIZnFTWURUNjVYWHV4?=
 =?utf-8?B?dXdxbm9wSDdOU2g5SXVXa3JRS1lBbzlOUWdWdFBQZHdlR2pUM2dZM094MVBa?=
 =?utf-8?B?VGxpTklEVmM0eURTK05wVFFLYWw3Ym5GRWxnbFpVWm1SWUlFc284MEtFMmJB?=
 =?utf-8?B?ZUkxM1ZrMCtob3lPVFQ5MVRtTjVFaldwTk96RndKN1NYWnc4bVVtTTdTVEVT?=
 =?utf-8?B?TmdhdU55QStYRkxkZnBpbHJOUlVyU1IyUjRrNVdhWnNzQjNVNFZKZVViTDlD?=
 =?utf-8?Q?ur2fWGwzVozl20xQwM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTQxdDBFYVBqZ1lHR0k3UEV5VEpDcXFwSUlNYytRbmN6L0xkVVgvMzQ5Mkwv?=
 =?utf-8?B?V0FLdHlaWUR0eVg2MUN1VlVQSkRSRkQ0VSt6bkNRWXNqa1lwU1p5RHd5ZGlE?=
 =?utf-8?B?dGI1dTNzdHhQc2dRTjkzMTlpd3hJSGtCRVF1amplalA2RmlCUGJRZzV6Rkgz?=
 =?utf-8?B?YzhqTEhLbFU4K08wbVBkeDlqejYyWEg4OTlBTHZPV01mWXg1VHQ4SWZDaEhh?=
 =?utf-8?B?UnN6VTZ4aThiQ2orSmVBeDByL1drcy9EdWFmS3ZRY2wxMnlCbFhNTjF4YWpZ?=
 =?utf-8?B?K3BMOWtoMk1nTVlzUU5PSW5YZ1d1YU1GVU5EcUx3QlRZMU9LRjcwUjhsVVJs?=
 =?utf-8?B?SmtzOGl1Tlk5aDNhalFzUmZ0VDV5MUU0di9CV25JVmFLM2VLem9Ua0s3Nk9x?=
 =?utf-8?B?Vyt3bUF5SW4wNUxQTGp4aHdiME5pcGhWRGNFbCtGTkxQL0JDbkgyQ2xyOWJB?=
 =?utf-8?B?Nm1CbDF3WlRhbzBnWnJ2WUJBb2RYRlBQZXFQL1VUMEl0K3R2MXdDazlOSGpm?=
 =?utf-8?B?cUp2bDFwdm9kaVQzbWR0TDlMTmhiSXVuOE14bXliSDBSd3RqbVptRjI5dWJk?=
 =?utf-8?B?N3F2UGdTTW0vbmxnRnV4Y1QrTkhtdUVVS2xoWnZCRzl5d2taL3dvYzhQTUpO?=
 =?utf-8?B?T3U5eVJPRlZHNDJDRkNjcnpzbkpOYUZTdGRkZm5xaHdZeW5sdkVNSWl1QTdK?=
 =?utf-8?B?QjZJK3VQb3poM2laZXZJK3JVRWcyUHBUMDhGY0EzL3VlNmlTb1JvZEtnemZX?=
 =?utf-8?B?cmpMNjFnOHZkNVo0VzNvOXR5WTgvN25MamFxMU45dWNmMUZvZDdQZ2NpekRs?=
 =?utf-8?B?MnhMRjFiMllTYTNhbzZ3eFRtZ2drQ08yK2l6WU1KdVp6R3FHOWpJZFpqNVlO?=
 =?utf-8?B?WDc1MXVISnNFSFQ5aXRYUVQxVVNuclVXd0k0SjdCTGMwNzVja0xyYkJvNmEr?=
 =?utf-8?B?V3A2b2tTVGQwTG9IR0xrcUhHRFVyRFRzMkJ4SU82SVFYdzByK2p0OGIxR1Ru?=
 =?utf-8?B?dENURUhyQkRGelc2MVo2NER0Wkt4TWNnZTBaL1k2YlRmK3c4QmVMc0E3Rnpn?=
 =?utf-8?B?NyttT0VZMmYxamYvckNpLzJpN3lBSVFrNXNlQmhnR0VrWE1PNmROVXRiVFRk?=
 =?utf-8?B?bVAwd3NwdFgvMXlsR1JqQWR0WS9ZQy9YMFRONzFuWGQ0dHl3aldYVm5lVUpQ?=
 =?utf-8?B?YnpIb2dZaHc3cFlCbGRQTGtuTS9IVmpxTFBrR0xzV2pHRmVSZUI4ZjVvNXZL?=
 =?utf-8?B?ejFPbzNyVjRxbmtRWVVJa2ZZV0JJSEJ5cU1CRG5lN0ltMmhaUk5IWHRaZis0?=
 =?utf-8?B?T2pJTGM0c2ErUWVvUTJkb2s3ZFIvMWtDRzZ0R24wb2RVbXdsNkFzM0VnSDZv?=
 =?utf-8?B?cVpUMmZkRytmTW5yUmZFbmFqaXRaMERwRWovK080U1dFWVhyakhQcm03WS80?=
 =?utf-8?B?cWRuWmNPcEF6L2hmSmNOc3dWMnJ5SXpYYkJkODkzQlRGanN2dHhDclRxdXVW?=
 =?utf-8?B?NlBNalBEaXFoQ2h2N3BLcGY0bU9WWFB1bVVNbmdTT0NHbFZPRHVrdlJ5NzhB?=
 =?utf-8?B?anduQ1lFYWFBRGFNQzJRUERnYTdNRmk3WnV5dmlGY1FpajEzMjhUN2VnRXdI?=
 =?utf-8?B?SnJxcHRaWHNFZS8rWlZhcVFtd2tnRStSeDhabit0clFEUHRJTmFkeVRmNDNh?=
 =?utf-8?B?YStyWk9VcklpaVdLb2hzeUg3S3p1bmJ1T2xJbkR4U0NseDR3anU3U2pzSndD?=
 =?utf-8?B?NkdvbndFZkhKNUVYUVV6Yndqc0h6U3l1SDdWQ29vdVM0djJGYUxxNHBRdGJB?=
 =?utf-8?B?U3BYdTc0KzRjZjdRdkNEOUpuZjRvV1JkcVFTSjd0V1p5alcxbGhNNWMrWmZP?=
 =?utf-8?B?MzY2OVZtckxobjd0YXM5YlQrOWxMTkJLTWlMTDhyS05kNmR4QVI5SHhlQndE?=
 =?utf-8?B?cVlBanY1eUl5QUpBT05paEVXbk5qc1M1QWo2MURJeXNyMEE2NmZwV2NYNzky?=
 =?utf-8?B?QzJaeFgyT2VJYjBnakhsbFF2YkplRU83ZDQ2NDR6c2NCRDFONXI4RzNhZDhv?=
 =?utf-8?B?cmZRVEk1UWdRYm0wZllBV2Jvc2hqWTRPQU1ObVhiQUpxcEk3NFNZWFZ2SmRT?=
 =?utf-8?Q?kHJE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451eab25-69ea-44f0-850a-08dcfe877dad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 17:21:46.4113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMMuitoIe5OTsHsR5OzyPjAHGTdYTjGbtH5Q42339L1tyo0n1NjYFBWJMWEVnrSX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470
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


On 11/5/2024 6:31 PM, Felix Kuehling wrote:
>
> On 2024-10-28 17:40, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> To allow user better understand the cause triggering runlist 
>> oversubscription.
>> No function change.
>>
>> Signed-off-by: Xiaogang Chen Xiaogang.Chen@amd.com
>> ---
>>   .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 55 ++++++++++++++-----
>>   1 file changed, 42 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>> index 37930629edc5..e22be6da23b7 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>> @@ -28,6 +28,10 @@
>>   #include "kfd_kernel_queue.h"
>>   #include "kfd_priv.h"
>>   +#define OVER_SUBSCRIPTION_PROCESS_COUNT 1 << 0
>> +#define OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT 1 << 1
>> +#define OVER_SUBSCRIPTION_GWS_QUEUE_COUNT 1 << 2
>> +
>>   static inline void inc_wptr(unsigned int *wptr, unsigned int 
>> increment_bytes,
>>                   unsigned int buffer_size_bytes)
>>   {
>> @@ -40,7 +44,7 @@ static inline void inc_wptr(unsigned int *wptr, 
>> unsigned int increment_bytes,
>>     static void pm_calc_rlib_size(struct packet_manager *pm,
>>                   unsigned int *rlib_size,
>> -                bool *over_subscription)
>> +                int *over_subscription)
>>   {
>>       unsigned int process_count, queue_count, compute_queue_count, 
>> gws_queue_count;
>>       unsigned int map_queue_size;
>> @@ -58,17 +62,20 @@ static void pm_calc_rlib_size(struct 
>> packet_manager *pm,
>>        * hws_max_conc_proc has been done in
>>        * kgd2kfd_device_init().
>>        */
>> -    *over_subscription = false;
>> +    *over_subscription = 0;
>>         if (node->max_proc_per_quantum > 1)
>>           max_proc_per_quantum = node->max_proc_per_quantum;
>>   -    if ((process_count > max_proc_per_quantum) ||
>> -        compute_queue_count > get_cp_queues_num(pm->dqm) ||
>> -        gws_queue_count > 1) {
>> -        *over_subscription = true;
>> +    if (process_count > max_proc_per_quantum)
>> +        *over_subscription = *over_subscription || 
>> OVER_SUBSCRIPTION_PROCESS_COUNT;
>> +    if (compute_queue_count > get_cp_queues_num(pm->dqm))
>> +        *over_subscription = *over_subscription || 
>> OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT;
>> +    if (gws_queue_count > 1)
>> +        *over_subscription = *over_subscription || 
>> OVER_SUBSCRIPTION_GWS_QUEUE_COUNT;
>> +
>> +    if (*over_subscription)
>>           dev_dbg(dev, "Over subscribed runlist\n");
>> -    }
>>         map_queue_size = pm->pmf->map_queues_size;
>>       /* calculate run list ib allocation size */
>> @@ -89,7 +96,7 @@ static int pm_allocate_runlist_ib(struct 
>> packet_manager *pm,
>>                   unsigned int **rl_buffer,
>>                   uint64_t *rl_gpu_buffer,
>>                   unsigned int *rl_buffer_size,
>> -                bool *is_over_subscription)
>> +                int *is_over_subscription)
>>   {
>>       struct kfd_node *node = pm->dqm->dev;
>>       struct device *dev = node->adev->dev;
>> @@ -134,7 +141,7 @@ static int pm_create_runlist_ib(struct 
>> packet_manager *pm,
>>       struct qcm_process_device *qpd;
>>       struct queue *q;
>>       struct kernel_queue *kq;
>> -    bool is_over_subscription;
>> +    int is_over_subscription;
>>         rl_wptr = retval = processes_mapped = 0;
>>   @@ -212,16 +219,38 @@ static int pm_create_runlist_ib(struct 
>> packet_manager *pm,
>>       dev_dbg(dev, "Finished map process and queues to runlist\n");
>>         if (is_over_subscription) {
>> -        if (!pm->is_over_subscription)
>> -            dev_warn(
>> +        if (!pm->is_over_subscription) {
>> +
>> +            if (is_over_subscription & 
>> OVER_SUBSCRIPTION_PROCESS_COUNT) {
>> +                dev_warn(
>>                   dev,
>> -                "Runlist is getting oversubscribed. Expect reduced 
>> ROCm performance.\n");
>> +                "process number is more than maximum number of 
>> processes that"
>> +                " HWS can schedule concurrently. Runlist is getting"
>> +                " oversubscribed. Expect reduced ROCm performance.\n");
>> +            }
>> +
>> +            if (is_over_subscription & 
>> OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT) {
>> +                dev_warn(
>> +                dev,
>> +                "compute queue number is more than assigned compute 
>> queues."
>> +                " Runlist is getting"
>> +                " oversubscribed. Expect reduced ROCm performance.\n");
>> +            }
>> +
>> +            if (is_over_subscription & 
>> OVER_SUBSCRIPTION_GWS_QUEUE_COUNT) {
>> +                dev_warn(
>> +                dev,
>> +                "compute queue for cooperative workgroup is more 
>> than allowed."
>> +                " Runlist is getting"
>> +                " oversubscribed. Expect reduced ROCm performance.\n");
>> +            }
>
> I like the concept of showing the cause of oversubscription. Maybe we 
> should add "process isolation mode" as a special case of "process count".
>
> The messages are overly verbose. There is a common part of the message 
> that could be printed if is_over_subscription is non-zero. Then just 
> print some extra info about the cause, e.g.:
>
>     if (is_over_subscription) {
>         dev_warn("Runlist is getting oversubscribed due to%s%s%s. 
> Expect reduced ROCm performance.\n",
>             is_over_subscription & OVER_SUBSCRIPTION_PROCESS_COUNT ? " 
> number-of-processes" : "",
>             is_over_subscription & 
> OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT ? " number-of-queues" : "",
>             is_over_subscription & OVER_SUBSCRIPTION_GWS_QUEUE_COUNT ? 
> " cooperative-launch" : "");
>     }

Yes, that makes code concise.

Regards

Xiaogang

>
> Regards,
>   Felix
>
>
>> +        }
>>           retval = pm->pmf->runlist(pm, &rl_buffer[rl_wptr],
>>                       *rl_gpu_addr,
>>                       alloc_size_bytes / sizeof(uint32_t),
>>                       true);
>>       }
>> -    pm->is_over_subscription = is_over_subscription;
>> +    pm->is_over_subscription = is_over_subscription ? true : false;
>>         for (i = 0; i < alloc_size_bytes / sizeof(uint32_t); i++)
>>           pr_debug("0x%2X ", rl_buffer[i]);
