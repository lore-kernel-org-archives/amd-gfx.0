Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40788C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 12:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01FC260E98
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 12:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 01FC260E98
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73F966FD4C;
	Tue,  2 Nov 2021 12:40:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8020B6FD4C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 12:40:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXt37huOEsCqYU0lI/q9w+HrDm6M509HnKjvWXsruvojOT3Y88N37fniLddUpBD/zaWr/xutwrCnbCjZLhfqa3ZMDItY92OVADSJ43AiGmjMSeWNtF5HWqXqe6437P/W+Y61yivCvGYBAS411sYVVhgu58+1SxyuvUnAbrtrj/sdOVH2b17B0JTaMsq0Bzws1YfJsLRSS5XknsScUmjjUpViVhZy5zaaAeyeap78TSm2Aw22JKgA0PNYNjjokBwoSVpNSXMrieCwiquMw144NQjpdyo5hGWtJuJ1wmsOMqe/X2uxm4aJt+jHlpK+TgjkDbjeROp0os1NR9bY62Rj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DJ/fDnhnxtzcrf6UV/Vh5E2SPl8EVC2Urj9Y8GefCs=;
 b=CuIiO24w/TP2aKNNUeuv3qcEO2JB5OnjtpmgQoygeLKb79C716b+s7wDHfgUsVn+by59rVyQssMBatZJFzcAv8efvzTeaLCLeNvGWITs56gJVt/8pKHFYiYxtOR5ugwz2x0D5NUbFb11tmMrZi4zNgbNe1sXbQsxNsqNTV5cIVjG7zBp5qAtjYCYIw2XaqlLWLhw0cq5Bu+KJRNIhZ/SyGBTQ/F1nhBG3pFTI3xnmUQuVWa4CVu7h2yROoUGNJQOnbpFWlGptvwELcou3DWutac7szSzquafAoCql4zCpI4UwFgvI8w4oyEAKS2AH+qx0wdv4sOZhKgakAbKRMsVOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DJ/fDnhnxtzcrf6UV/Vh5E2SPl8EVC2Urj9Y8GefCs=;
 b=YbGCuPEAYSxgSWwhfNuFb7/MTuuim2rOSy0EpMq8YILmr24fLjgQaBoFTJTyUIo7YM0lGy3Ebcfg6cUtxroC6ShhaKqMseiUxDmTescGa6LVKPSsBzmK7OHUJ8YWEKXhjEhHIOTioGVItPpY3XwsfLN+Hk8y7q3mzkKbb0ozjh4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5461.namprd12.prod.outlook.com (2603:10b6:8:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 12:40:12 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::e95d:8a23:c590:e07a]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::e95d:8a23:c590:e07a%7]) with mapi id 15.20.4649.017; Tue, 2 Nov 2021
 12:40:12 +0000
Message-ID: <e3aadb2c-320a-5101-cb11-1452a6256020@amd.com>
Date: Tue, 2 Nov 2021 13:40:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 1/1] drm/amdgpu: return early on error while setting bar0
 memtype
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20211029150917.4462-1-nirmoy.das@amd.com>
 <69967ca1-6482-7cd2-1c32-d4de5c8136eb@amd.com>
 <c807f013-1931-bf17-6942-28e7413bc627@amd.com>
 <7b1efea0-d937-c7e7-4d9d-7583cc9fa368@gmail.com>
 <f2b87f2d-fcd3-ba4b-3e3a-53ec20a4997c@amd.com>
 <25de3975-133c-f22c-d75a-eb943f8a9193@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
In-Reply-To: <25de3975-133c-f22c-d75a-eb943f8a9193@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR01CA0037.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::14) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.88] (217.86.123.158) by
 AM6PR01CA0037.eurprd01.prod.exchangelabs.com (2603:10a6:20b:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18 via Frontend
 Transport; Tue, 2 Nov 2021 12:40:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1a8bdd5-e4a2-40be-8c51-08d99dfde987
X-MS-TrafficTypeDiagnostic: DM8PR12MB5461:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5461FE471DD745A2B49749EA8B8B9@DM8PR12MB5461.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/2+1NfoGNrqEZGkmVe/2xbadJRmgbEBuKzNLbSCPPrF1kUUJOYoyhr66A/MY81jJA0d82os1PDRnFAXcIoyvMatkJ+89w/fsUo34Kmqr5aDfnoPwoH1L5VyIXkeQ6LiIVFQpgPIMLm93UnTMmuZLN0kMYyquP7X6DsCJqHP+A1Kq/0o/pbf/ovaz3DS6Tdchp6yvpNh6iz+YPwTIW8TF2m3/m3n1sHFqQoBDyhmzFEsFtJUUlghrifQ3xBakDAcM0ccnjGxTrg3m0xBHjLXBEb2vtMIF1ayN06yvycbNfxYDPHhAaya3h9lsCUn22/GlIh3/dXKV6kY5YpPScjVMuDagXpDnTcOg/Az9rndUku09ZAGrXRh5+NQH2Ie32xleT+RsgeueeJ512kSPf0+c9RkSk84cY+b8OOpZUvg0U6vY8aoyHWPWvokJ79u5gOccN67MGzB/BG1BELWdYeGuh8F0TSfomxkZ0GYHXwq6Gb/MIfBG1l7PMg4BMIGjc1GN/5Ypvrf6+fpgSDnJ4rkECND01EBLkdoTlo/qG5Qc2SN7VwajlXtBCRmGPpzeCnl7bx+RDGFeczSyAspqJfnEmrWsX3viqXA/dQrUdVyAoM9kWzjqGwNKUPoCBQEapG+voWo1iTKjYK0PvHhz+6zZqMbtzIx6YN4RExwlSBaNiKYJaSKgfam8XrQCP72Kqi7HhARB4CkTpsJP8jxhOwcSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(186003)(508600001)(31686004)(16576012)(66556008)(66946007)(2906002)(53546011)(26005)(8936002)(316002)(5660300002)(66574015)(8676002)(36756003)(956004)(31696002)(83380400001)(6486002)(110136005)(86362001)(6666004)(2616005)(38100700002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW45RzNNZDB3d2U5bkU0T3htWFNCVUNVc2R3OWgrOHVaQlBUSmZ5ZzE5RUp3?=
 =?utf-8?B?OURQZUo2KzFYWDd1ZWZXWGN5T0FPcHQ4YmJwTnZTMnoyblJBUG9USHR4UHZs?=
 =?utf-8?B?cGozVk42dmpZeVJaMWJjenJxTDJSWU5YbHlDWDl0aG16d2dTT2psOThDWk1F?=
 =?utf-8?B?bXdMNmZyYWtnWXFLZHl0dGg1ZWhVMVp1RHViNy9GNGFRbXFONXgwczVCN1R4?=
 =?utf-8?B?cHBZdDBKaHhIeldleGJGMGhjMnRFT2JmNUYwcTZiVHZLcVloTnBYalVVelU3?=
 =?utf-8?B?a245R2FLcjJuM1FGRmJRem1WWlhyYWdMZm5zRlB2WXVzRDFSdG5PTW8za25Q?=
 =?utf-8?B?KzJpUEE1L1FwZ29HNVB3bkhPVHhCZ2dRRmQzSWcwZGZLeURxeHc5YUFhc0ZK?=
 =?utf-8?B?akw1Qm9QemxVeHpReGVuejRENFBvQWtQSEU4Sm1QampOanMxQWxXbjgyTmdv?=
 =?utf-8?B?WFd5N3RiWVRvQ2VxL3hweitXcytoQTh5T2NlM0JRSUp5dm5oMVFpbE1mNXlO?=
 =?utf-8?B?NDhyRzFxQloxayt5c2ZVM0JweGVTcHEyWDVEUDU3WGZHamlEUWhycjN6U3VU?=
 =?utf-8?B?UStMb2VqbHIra0xWajZWeHY0UGU5bjZmR1VGczV6YWNOZ093bDNiWXJCVVNn?=
 =?utf-8?B?TmlNYlZJS1dUSnFvc2VPZ2U5aktxcTRCbS9sV0EyeGpneFB6UVdzdGxYYU9H?=
 =?utf-8?B?eGtZd3hNUUs0ejBYU0lXNDRFeENuTnZDOGdNb0Y0OGtsY0dubUREbGVUN3Zm?=
 =?utf-8?B?T3E2N3Q0cGd4aWtmYzAwcGJCRzRHaVRKR3gwSWpVNVN0aGdQUnYyL0M1dGl6?=
 =?utf-8?B?MFVnNjZobzBtTmtqaXlnK1dIdUNMVC9samRiazI5R1hxdmVETlZBd2ZWcnI2?=
 =?utf-8?B?NFJJTFBDaTc1c21WdzlkcnBsdW1QNW5UNzVGcnQxTVN6dmJhcTdXY3lYNGNl?=
 =?utf-8?B?UEdMcHNSVDhwMXNCSDF2WFdaZFlRL3hsSGh6WE5GdzNNVDE1VU5iUzl3b2px?=
 =?utf-8?B?RkRMNzhVZ2VJcWxkbjZnSnVLL3pkZ0tiMExOV25tMzM5ckNwRGVObFpMNE13?=
 =?utf-8?B?d0NJbFpNSGJDRnpXcTNkUTJWT1MyRGFoYjN5aWZ6R0kycnU0Q0IyMnVIMWtB?=
 =?utf-8?B?Mll0dGFTSkE3YjRBcE5NaU9TVmMyZ3hCVUxpV0pJOC9MVDA0TmdwMGtrTjc2?=
 =?utf-8?B?RHlVSGZzekV6MEhxTE1ZOXUzUk9aUHZCTktRaHZKUHYzd01xQVA1VFZWclps?=
 =?utf-8?B?QlRYWXZ5UWJ1RGMvRFdqUWU5bXFvLzVhYVlnQVhTQ0ZRVXRUZUN2QmwxbUtX?=
 =?utf-8?B?dFpJNEs3U2RMM2NmS0JXY1ZkOVNDTmx1eXBiSG0xcndMN0lOVUJvK2NzZEE0?=
 =?utf-8?B?dlVsVjVoQXZPbnNsaDA4RmJpZXZYSkRvd0xmSGJjKzgxSWNRSzNoU3N6Rldh?=
 =?utf-8?B?TnZTeDVGMjBuNDhhaUhFTFQ3L2ltSjZIaWFpSjE1Ky9tR1llZEVLOWJFUjBO?=
 =?utf-8?B?SWZqVWtaU3Y1VDJub3BnWjJIUE42NHE1TUlYRFhBMTNWK1ZnQ3RvazE4NGw5?=
 =?utf-8?B?SWVRWUZ5M2QrQjl0NHR2c3hONDMzZlprNC9oME94V3RPMUVzQ2xkVXg3QXFT?=
 =?utf-8?B?UFlNbC95b0xsdWpZNWNtbTVPVm1HQjh1Y2VMb3J0UFhZdzhRU0hWYkJjR1ly?=
 =?utf-8?B?MFJIdWV3cUJ1c2lDbTRUbjFHdmZPMG5zd3NQbFJOM0lkeFNTREMrRk1FdDVw?=
 =?utf-8?B?aDBnRTk2KytnZkhnODdTVEtmR1Y5OFlpTm42alFxRjVlYVlOeFhZdjBWUWov?=
 =?utf-8?B?eEQ0WXplVFdYVjI4UC9XbEc3RVNMdEtOR0h6UkxUYm0wZ240bE5XcXF4WDRt?=
 =?utf-8?B?ZzdhOXVtNkRhYjNZWWdqV0JUeUczVHhqMEpOOVpkL1R4b3pleHRiclNvdlQ1?=
 =?utf-8?B?Y250TFB2ZG0xTTByWXN2aUV5cU10K0xEYVNMZ1dha2NlcHByVzhCZkd5L08z?=
 =?utf-8?B?b3Q3VDVkVXFNL0RkRmdsSXp0RkNtL2RQazkzVmtuaC81QzMzREVONnJ2a3ho?=
 =?utf-8?B?UzZPTm9helcrWmFZaWdLTThIUHRjeG5pWmlRK3FjOVVwL2lHd0ZCZU12SkJk?=
 =?utf-8?B?dWJ1ek41TXhlUGJ3SUVybEFLTnFZNzM1YWNJVTExb0p5QVp3WEpJeFlNQ25B?=
 =?utf-8?Q?R6KaFIZJhLdXuqlA341v9Rg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a8bdd5-e4a2-40be-8c51-08d99dfde987
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 12:40:12.2445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17za7NWcgDacIVOOPFWoyUtFtMXnxkia6LIsGTJHlr8KEXRG+4y8ldGCw0UPz50dURFudc+g55WobfNAGfiNXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5461
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


On 11/2/2021 12:33 PM, Christian König wrote:
> Am 02.11.21 um 12:18 schrieb Lazar, Lijo:
>>
>>
>> On 11/2/2021 4:39 PM, Christian König wrote:
>>> Am 02.11.21 um 11:11 schrieb Das, Nirmoy:
>>>>
>>>> On 11/2/2021 9:00 AM, Lazar, Lijo wrote:
>>>>>
>>>>>
>>>>> On 10/29/2021 8:39 PM, Nirmoy Das wrote:
>>>>>> We set WC memtype for aper_base but don't check return value
>>>>>> of arch_io_reserve_memtype_wc(). Be more defensive and return
>>>>>> early on error.
>>>>>>
>>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 7 ++++++-
>>>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> index 073ba2af0b9c..6b25982a9077 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> @@ -1032,9 +1032,14 @@ int amdgpu_bo_init(struct amdgpu_device 
>>>>>> *adev)
>>>>>>       /* On A+A platform, VRAM can be mapped as WB */
>>>>>>       if (!adev->gmc.xgmi.connected_to_cpu) {
>>>>>>           /* reserve PAT memory space to WC for VRAM */
>>>>>> - arch_io_reserve_memtype_wc(adev->gmc.aper_base,
>>>>>> +        int r = arch_io_reserve_memtype_wc(adev->gmc.aper_base,
>>>>>>                   adev->gmc.aper_size);
>>>>>
>>>>> BTW, isn't it more appropriate to use visible vram size? There are 
>>>>> cases where pci resize rounds aperture to the next higher size > 
>>>>> size of actual VRAM.
>>>>
>>>>
>>>> Good point, I will update this one and send again.
>>>
>>> Not a good idea at all.
>>>
>>> The aperture size is rounded up to the next power of two and that's 
>>> exactly what we should stick to if we don't want to get an error 
>>> code in return.
>>>
>> PCI rebar sizes have its restrictions. It jumps from 4G to 8G to 16G 
>> and so on. Why we need to map 16G for a card with 12G VRAM? BTW, how 
>> it increases the failure chance - this mapping happens in page sizes, 
>> right?
>>
>
> Exactly that's the point. This mapping usually happens in power of two 
> in the same way as the PCI BAR sizes. So we should use 16GiB even for 
> a 12GiB card here.
>
> Only some architectures work with page size mappings (e.g. x86 with 
> PAT enabled). Then we can indeed use the real VRAM size, but that is 
> absolutely not guaranteed as far as I know.


Thanks for clarifying this. I will push the patch with your suggested 
changes.


Regards,

Nirmoy

>
> Regards,
> Christian.
>
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>>
>>>> Regards,
>>>>
>>>> Nirmoy
>>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>>   +        if (r) {
>>>>>> +            DRM_ERROR("Unable to set WC memtype for the aperture 
>>>>>> base\n");
>>>>>> +            return r;
>>>>>> +        }
>>>>>> +
>>>>>>           /* Add an MTRR for the VRAM */
>>>>>>           adev->gmc.vram_mtrr = 
>>>>>> arch_phys_wc_add(adev->gmc.aper_base,
>>>>>>                   adev->gmc.aper_size);
>>>>>>
>>>
>
