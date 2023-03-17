Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95491C6FD1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 21:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CCF10E142;
	Fri, 17 Mar 2023 21:16:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24F9A10E142
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 21:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIIK585+bmASLj202SCDt55wAbRXo3ib8JMJ8zX7iHzspOj4mTJcsTRbWa5T4K49ctSMhF+sHhpCJt0+gNlYsE6kuxgdHAp5pIxopCRy5dx34oLmHz+se2EyAPdE9rKPHdjZGqUyq1uFAdcM+cdvMkOrWDqIj1CpLDZzoWcKr2X/cppCx+c6xFJyQ4zgONtX7bxaQ7wIp3kPIRhr2M/aiMQy2JGyFRHobe5E49jm6t8Jz7oQ/aZMAlffsdhPL5O5MtyKEZg9atZIiNsgm2eRBwqdxGv4eevcioNmSizbcNp1u4Yd55cwcs7e+baSgawnLaagnkAgGh/mRObVeR7BxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnwEiRVi5o7L4sRXe9H78v8xUHQ+QbSSaxbxCOS3Hmo=;
 b=Yv8LO5GQ41gIafSP6xpEPBkNvf9rKZIVD2fX0tiXPp1PEzxUQM2Mnt/F2h/QLZB91mKblOsIKJrsh2h0fCohKVg3hdtwgsyhhtm16tnlXPndcmkQA45NS3vE87vU2/VnsAcQIP/O47VjIlfwSB0USsmyxl9jXwIw5fcaidvfy9iNIRWJ3l52tZ98DrI771eZ8y7XD4nTIKTfn3lCPmtkCGX1M10HlE8jaYLoZU6AbBwMHOJP5Lb8HEbmzKF8guHGd+qlCoinKGS1OH+yTiHJjF5XLmziUEVBFL+9kwQIsGUdJLV8Mvxrb/NhLjNCvz01I+4M9fgsGUW1AkE2MdRFig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnwEiRVi5o7L4sRXe9H78v8xUHQ+QbSSaxbxCOS3Hmo=;
 b=vQuLsYc4yjxu3wO9rn20L/V1M1q40w1z+xidRgd3L6RAxdnPGzBx+0oJd0y2QBtx3/PK1os28nRmW1Y5/IeG+Nvw6acAmS+6IBiQ6zLRirFCJRIpi17QwYvHPozC/M5UZU1f17y85M6xiC3jTbV/ZFDrEIclnxVaNcuVdWsL32M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB8822.namprd12.prod.outlook.com (2603:10b6:510:28d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Fri, 17 Mar
 2023 21:16:23 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e%4]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 21:16:23 +0000
Message-ID: <b04e5657-9f41-204e-7b83-acbcfc462fe5@amd.com>
Date: Fri, 17 Mar 2023 17:16:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdgpu: add print for iommu translation mode
Content-Language: en-US
To: "Sider, Graham" <Graham.Sider@amd.com>,
 "Russell, Kent" <Kent.Russell@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230317194757.1336098-1-Graham.Sider@amd.com>
 <0509601d-8d7c-26e2-26c9-8f4757a92ca2@amd.com>
 <DM5PR12MB1308BF656CB0C75BA0B9CED885BD9@DM5PR12MB1308.namprd12.prod.outlook.com>
 <DM6PR12MB30674A9D4B81185DA913A2278ABD9@DM6PR12MB3067.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <DM6PR12MB30674A9D4B81185DA913A2278ABD9@DM6PR12MB3067.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0029.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB8822:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8b0887-5af7-48aa-7072-08db272cdc6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KFpLEIG5xNdKQkTGindADy2vY+tFTxsr89CTv+y3cqPt/tR5jXZUXlDQJWQqO7C+MUAJpZ83fXjuoEdkhQ9D3LmH8N1rQzlsWnJ52TrUefWbzpC+GTAnG/XjMFe2qyYjx6eF6MVKW9qLmtnZ3fP8pCwJ7qFXnTAc82MoLR7eT9SfcU5Me/ftF5ZYhqIuCv9QztQYNDRdiY69Ej7SjfkzgXTOF7QlDXbWlTh0i/6JEgUIer++6wYjINvM703p0jHwnkBQcmm3lq+WQD37wkeYMfCZl9P0UJrXE9BEkX279bLhK4acoolDDlHt/vzL5siqTVbMTPLLFtOPsSCJzf00A9AnT/6ww9ZNamHUEyQQuhV+ULcNJ8YkfND7tS7P0qZ+q5pgvQ3kKXYfnDg7tlZYcqpSZGVs2Yi2uICg8YvvbYDAa+bnrkYrMDS4n5fmwXHJjhUF/0c5s5mnxrxTerP2KVSG/M4xePH+ZWT6tMO0BeNl3CtkOrslBfmMzkqv6nbtO9eUcVhN87meQzp6Xff2BD9gHYw2q0ddkGo7Jo8+qIunTdUOgC49AMqbYjnGlZUEuFm6Goa5GUp4RQsckrmKf5FZw3+zFzcakNRNrYbD4XjKwirrOTuB38tH4vSkl8t80v1gBwys7ra2f/i+le7HOi4Sb3Zg1JpPEYz+hrE+txZK78ahKna6FPWmgp7h2LB2KV5DLyzP/WF1n2hAeiexsMyJ5yKrIlS2O6riATE7ics=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199018)(31696002)(86362001)(38100700002)(36756003)(8936002)(44832011)(41300700001)(5660300002)(66476007)(110136005)(26005)(6512007)(186003)(83380400001)(2616005)(6506007)(316002)(53546011)(2906002)(6486002)(8676002)(66946007)(478600001)(66556008)(36916002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE1TWW9Mbm1MTlpYbi9rbUhzazR0MTZlRkF6T2dFdXUyTFI4ZWcyWmI0SGNl?=
 =?utf-8?B?ajBDdVYxWUlRS0RxNkR1dmlkc3lSdDdlV256NmUzK2dXTENXUHdvbk1EUHRK?=
 =?utf-8?B?Y1oxbDFHTzUzV3hWcEpkb0NrS292UDJldTI5cElhbGorSTFzSmZCWjVMTlRO?=
 =?utf-8?B?cTVoNUQrWlVWcElVclF2bXFiTytiZzZ1Y25qb2twZUp5QzVuZ09vdVFBbEtN?=
 =?utf-8?B?c3kweVJiL0E2K0pJVDE4ZmtSb3ppR3JFM2ZUSVFaMTIrbmZ6RERHOTZkUTlv?=
 =?utf-8?B?bGJkSklUYk1EMktEQTIvQ1NnLzJpbXF3Q1RJbmlLTjlBRWxPV01ZRXR2SWlz?=
 =?utf-8?B?ckY2ZTFuUkhqczVJWU0wVVFzUVVHamJoWHk0RXkwVkhRd1d4NmxFRjRwY1BP?=
 =?utf-8?B?KzF6TUJmQ1JmOVNGRHVnT08zOTlyR2NINjNXNUw2N3FSMmo0N0U0ZTJoTktj?=
 =?utf-8?B?R1VUaFIwdHcvQmRYODA1bTlRWGora3RIVVJmRU8zMktPNU9rQ0YvYUczL2E4?=
 =?utf-8?B?VDh6K3NiTnRZR215akR0Y3ZzajFnUHB1REhuSFgyeGtYZHR2ZFc0RXA2RE9G?=
 =?utf-8?B?d2lqT01SbU1aN0ZBZEpuRHNvN2ZQdmc2NUJoZjd6d2hWbERSVFhJNUs3eXNK?=
 =?utf-8?B?cU9LczJheEdiR3VGSG4xUGh4LzJRRVhrN1QzT05rQnpjOVdOejMyTGJjQUJD?=
 =?utf-8?B?TVQyRFhaNEpTaUQ3WWx3RldTaUJaNm5FN2JWWlQ4Vk1Gdk5sMTJ1bWlCQzBL?=
 =?utf-8?B?V2c2OWlZL1NZdnBNRXM1OWo2NHFHNE81ZDh6MFJLbDR6cHRXa1BpK2ZyUFNW?=
 =?utf-8?B?NUdiTUMzWGVQejdhMGp1RWxUZmJ6VGI3YmtPZ2l3UENBVktIQUp4cGJQV0pW?=
 =?utf-8?B?NDNUc3NldTlpQ2RpVUxya1kvUnV5c1ZzaFBXNW9xMFl5MXppNDBGeE43TWVE?=
 =?utf-8?B?N2NhYmNlTlovdjV0TjRoRnZ1Q0hubWFVZ25JVVNwb2pQSFZkRTRrT1lBVEZ2?=
 =?utf-8?B?SWNqbUpaaVpqbGxkdmJJTUFDOStmY3R4aGJmS21USFlIalBFc2hpeDBmZjkz?=
 =?utf-8?B?M2YyV1RzVzBueWdKTm1ZSGxnNzFpWHQybENqVmM2OUV5MUpnSGROaXBMSWlp?=
 =?utf-8?B?Z2pPV1FwaWFIMXlPaGFTU2FYdlRjaCtlcjNYKzBkaEw5L1cwbmxsOFNFTTk2?=
 =?utf-8?B?ZkZQekVVZjdQMFhNUExPZFhjTjRtbzZ0MzhrK1Z6eUhWaGROaGpyNmZ0QzVL?=
 =?utf-8?B?anozOUJtZFpLR3lZbUZyb1lyQjF1Z1BRRDFwRlVUbURidjBmbjhFQWd2QXQw?=
 =?utf-8?B?d1BVKy9Dd3VvSkJrNFFBRytvOTFMTWhBMkFjTythU0FHd1h1NUw1OFlZWW1C?=
 =?utf-8?B?bFlaWmMxeVJpY0M4Wm9xL0lkTk41QXg5bXBhNHNlWTlnSnFrSm94Tnk5Wno3?=
 =?utf-8?B?NmN0SEIzUmllc3hsUTBIUnB3VEk5QTlhaTViTWpNOHJQejZKSWIwUlBJajcv?=
 =?utf-8?B?M0tZOFFPOTQrL1Zvd0Yxb1hMVmdiaGRlV0lhdEpQQVNEa1UzaHJscDRGdzFv?=
 =?utf-8?B?cTZlT29wVlJJMklxTFRnVHZzaHlrK3J1VWxCbkJDdlN2dkV3R2V2U3Nad2ZY?=
 =?utf-8?B?dmhrQThlcitXUk82bVo4S211ZzlEbkphdjVMU1EvUWo4REJGNk5hOHNYcS9k?=
 =?utf-8?B?cWtSRzlvQU9kaTFpcGFja24wOGZ1eEpVbVhBbjk3VW9vbWliZFJ0WXhjTXhB?=
 =?utf-8?B?Y1NyQ29reGt5MGVsVWVOT3ovMm1tTkU2RldiYUNMcUtzTStUYzk1MDNQQlds?=
 =?utf-8?B?Y0ZLekZOcm5xdzJwY1FSNDZrVjZOdHJYdFBwNTBQSWpoMVZXSXdzTlNjeExG?=
 =?utf-8?B?R0x4MURTU1ZPZFNaRGx4SnpDTEVGb2hRRFd6ekNiNDdZTDhUbzl3RHdNMnRw?=
 =?utf-8?B?RFpsT0Vod3RaV3AyaEJucGFzVXZvdDNHWnNOdjlGVFZGN2NieFd1VTlHWGYr?=
 =?utf-8?B?N2gvNWF5STl6NjViaHBiZnBaRmRBVXEzdnl6MC82NllEaDNBM0cxQW54N0tj?=
 =?utf-8?B?V29jWW00ZUZaaUZxQm02bzhVaXcxN1dRNk1GTWFqWnNHUDd2WXRKb3lvdFEx?=
 =?utf-8?Q?Xtx2pT3WHdix+OymZnppJP6so?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8b0887-5af7-48aa-7072-08db272cdc6e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 21:16:23.4732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQIHxgj5RI3dLSOvYbdaZyYiOBRsEflooMGXX1y6hxnpAZN91644R4KK56ORNotqDRoqkWo2MjoR+OdKBmlEIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8822
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

On 2023-03-17 16:04, Sider, Graham wrote:
> [AMD Official Use Only - General]
>
>
>
>> -----Original Message-----
>> From: Russell, Kent <Kent.Russell@amd.com>
>> Sent: Friday, March 17, 2023 3:58 PM
>> To: Mahfooz, Hamza <Hamza.Mahfooz@amd.com>; Sider, Graham
>> <Graham.Sider@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Subject: RE: [PATCH] drm/amdgpu: add print for iommu translation mode
>>
>> [AMD Official Use Only - General]
>>
>>
>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>> Hamza Mahfooz
>>> Sent: Friday, March 17, 2023 3:58 PM
>>> To: Sider, Graham <Graham.Sider@amd.com>;
>>> amd-gfx@lists.freedesktop.org
>>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: add print for iommu translation mode
>>>
>>>
>>> On 3/17/23 15:47, Graham Sider wrote:
>>>> Add log to display whether RAM is direct vs DMA mapped.
>>>>
>>>> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
>>> If this information is only useful for debugging purposes, please use
>>> drm_dbg() instead of pr_info().
> It's useful for more than just debug I would say. Just a quick way to grep whether IOMMU is off/pt vs device isolation mode.

I agree. The kernel log otherwise tells you the default IOMMU domain, 
but it may not match the domain actually used for the GPU. Without this 
message there is no easy way to tell from a kernel log. This will help 
with triaging issues from logs provided by external and internal users.


>
> Graham
>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 8bba5e6872a1..8797a9523244 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -3528,8 +3528,12 @@ static void
>>> amdgpu_device_check_iommu_direct_map(struct amdgpu_device *adev)
>>>>    	struct iommu_domain *domain;
>>>>
>>>>    	domain = iommu_get_domain_for_dev(adev->dev);
>>>> -	if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY)
>>>> +	if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY) {
>>>> +		pr_info("RAM is direct mapped to GPU (not traslated by

Use dev_info. That way you can tell which GPU the message applies to in 
a multi-GPU system.

Regards,
   Felix


>> traslated -> translated
>>
> Thanks, my keyboard keeps skipping the on the 'n' key lately :( time for a clean.
>
> Graham
>
>>   Kent
>>> IOMMU)\n");
>>>>    		adev->ram_is_direct_mapped = true;
>>>> +	} else {
>>>> +		pr_info("RAM is DMA mapped to GPU (translated by
>>> IOMMU)\n");
>>>> +	}
>>>>    }
>>>>
>>>>    static const struct attribute *amdgpu_dev_attributes[] = {
>>> --
>>> Hamza
