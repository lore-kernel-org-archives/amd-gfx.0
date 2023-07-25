Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195C6C0015E
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 20:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E0310E17C;
	Tue, 25 Jul 2023 20:24:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54DBE10E17C
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 20:24:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7s6c9ra6B6MdDrdI8BKZptmUz+9KUnFM6anmylFCRyF35cAe0JGXslUokWgoDiq7mB2D5hfjh7Nf7Xvh/ccZQJTBHD0QDPkgh8k4EVTCOvatB7kwMvd1vOyMFE9odBM+ZClMeBd88QCncxipky1QUS6Z2ClGdVgx9xLE/XmWr4or9ZXCYQuRWUoVaDU1nu53+2upsrW9pC1ZvLjSSYHH3gPZ7A17r7DArtjlkSOTs/1Tu4busyQdTJSlRkpe7hC0g0oEa9JMJwcYt8WpzqPIH3B/K87bdJcVKc9Lc+BbK8DDdUpDJXp9ArMuLvAt+uE11uc4UIWQGBG//7oF7Ea1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSPtYB2RBzFnlUH/okjyu1hK9MWCehc8qxI4RkLwsjE=;
 b=PYG0OtE6iHYOnyVbUblhZd0VdOAr1+f5b4sT8WdlqIhmNfssnSftUZN37HVl6CDIq6Wor6prSN80pQQ8fXaZwuJJCe38r2QgrFd3tpsGfMe+YCqAIx8LET37Nvf3xSDg5xnb+9VQ02FiueGC6+0reK80hBlt/X3NGW9btoCAh4dtC/yrHamKec5KxzB06mUifqo6OLapleqcuAeX0/wM3BtK1EzIaRhB1vQyjtdpjWgDEcRMTzivSff24JM9z6DiHbctWni12PKLDqU1WYx5sUfYkvlWmM/i3+XFf8E6h6NawJ9XDVx5tVgi4HpFP1MbeZViS3rwo6DZraC+1t9uDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSPtYB2RBzFnlUH/okjyu1hK9MWCehc8qxI4RkLwsjE=;
 b=X66UTGIsd9U5RFup87fPIbgCiiPMpiMWXIDIfzna8g/ujdmqBUp5MO6w2VoInuKG9N7QWtYSWug8Y1STLOqfuy8qRhsiBi/0lmhPW6AbE1T0Uzj6EFraxPJ5P0/Hy/5DeN3BwTOQI+4BpBUO+/rAMDWltzI/qJwrStYg9I2j2Zk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 20:24:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 20:24:01 +0000
Message-ID: <2a326be1-1779-b1dd-ed1a-70ad94290dc3@amd.com>
Date: Tue, 25 Jul 2023 16:23:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Checkpoint and Restore VRAM BOs without VA
Content-Language: en-US
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230724155721.1974726-1-Ramesh.Errabolu@amd.com>
 <7d3bdae7-817b-79e0-a404-096ab089400e@amd.com>
 <SN1PR12MB257513927F7396C5E57E7136E303A@SN1PR12MB2575.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <SN1PR12MB257513927F7396C5E57E7136E303A@SN1PR12MB2575.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 3657c087-4d53-4c0d-2c47-08db8d4d1531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFJOVGIu1yHIJ/AWED9S8le2xHOF6Gos//n2ITDQpwapVvmTr/au6s0PKh7OVkoveFQXjlA0oKGu3c8XksLEO7j4gP8TwLCiFStb0n4YUgXgNKRoHwDiAX2UjnUBYrXFddbHhFkfzxUuup4jex1s+dEie/fNzJz2uTUZQcLSc01KcFFN/8jJ5p9mLRDk4NyTbtH9gIzbdyebNMKIcajJLbUJiBwLALFSnDSlWdC0QW1Gzi/pTbfWfz17q3gmpfaN9pKwpeZwMck2ct52pB50KFL2JFlbvXAaYXQfyRRFhQtFruAX4WQJKTKp7U6mSKfGY/ZqyOMDbo3H//FXcasgmLehFZqcZIfR7KL2PFfRXWIxcars5iq6/8w4SLwJgJHjMvPJXZyO3AOTZsmXSNM/C+6LiVdc8/bfQFKX1aRWM3lGx063jNjhVLdPL8cLhw11zXMwkvi3NYl6jO4EiiCSJQp2fXcvIzb3+J8Y9SoXlsq6yeKuUNh4J0Yeldm5+XrVVYogTKRIDXcyrb7H87uAkHlnKNQg9YgHx2PZsi5vE+mrM5e4qOUqmXgPkNmhDNk3ssM5N3DcRFGWOMYHQ2UJXVAXJr8HKAENB+A42FTg3txurv7yfiH/HLCCyuMzXXG0nrR9IWQEzIVZ+nursZgI+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199021)(83380400001)(38100700002)(36756003)(31696002)(86362001)(110136005)(478600001)(2906002)(186003)(26005)(6506007)(6512007)(6666004)(6486002)(31686004)(8936002)(5660300002)(44832011)(8676002)(316002)(41300700001)(66556008)(66476007)(66946007)(53546011)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmVSVUczNlRWSGMrcERWMW1aUjRBUERpTWpSRnhHdnNPdTJOQU1rV0JGN01h?=
 =?utf-8?B?S3V2MExDaFJBVmJGRncrUWZaaFFpalVBNWgzdHR6dWRDS1JhdkRYb3BHOXJ1?=
 =?utf-8?B?dkR0NTRBN1pzWC9MTW0xODdIN21oemY4c3RZcmNiRDVtUTlhZlo5NWl3NWQz?=
 =?utf-8?B?amw4TGRaUElPK2Y0OGdwRkpNTitmU2NPRFgwamlyS1Y3UldZcTlkM0RBaTRE?=
 =?utf-8?B?ZWU5NVplZzRiK21KUnlYRENSL0VSZmR6SGlOU0YrVTgyZjFJRnZQREl0Sk5k?=
 =?utf-8?B?dDAyNVBYV21mS2x5b3hBMS93ams1d29iTkpUZmQ1TjVLRU43OWxmUy8vby9H?=
 =?utf-8?B?UjFSVGNjSWlGN0o0NWRrSkxuQml6M1N4TkhXcmdyT2NHM3puQnh4K0QzeEg4?=
 =?utf-8?B?N3VrSHNEMTN6V2dzdVh0TmxUYVhnd3NCanNzZjNadktYNGJlUTYrdzNZN0FB?=
 =?utf-8?B?dWtRNU1Mdzd4bG94QXYzOFltTWYrN2xLeUpySkxEMm9Ha09IODIzZE13aGpL?=
 =?utf-8?B?RnFPYzRjTnJsUFh3dzFsbFQ0NGpRV1BTYXM2alhRdkxZQ0NWN3hNUW1mdDJr?=
 =?utf-8?B?TVFsUStoK1YvdmJON1dTL0hwTWM1WS9ERW9DVldyRmpxVCtZbkdlTW9DL2RM?=
 =?utf-8?B?Uk1Cc3ozbUc3cWhyWSt2dmVqRTBUM25SRGh5TkVXV2NQVkRjM21pR2FQbFpp?=
 =?utf-8?B?Y1AyMkR6Y2NLUjUxV0dLbG9uaFdrS3ZYeHUxNFVkNXFjbEg0QUx4QUM4V21B?=
 =?utf-8?B?SElpb3g1Qk15TWE5L0ZudWxCUEhFRStkS3BMWDdBb3ErL3d6dStwRUF2aFJU?=
 =?utf-8?B?bDJTd3NnRktzR0NyaVNZMm9yWXNTZE1ucVJXaTFXTXNWY2FBNld1bnhNSUtj?=
 =?utf-8?B?eXZnTXVWcnE0WVREeFFLSnZYdExDTnlkREh1cFJWSll4UHplYjR1cWpSS2Rv?=
 =?utf-8?B?YXFocFBFVzVZRlpFd3AvSWRNMUlqZDQxNjlVa0lHMVVpRFAvbEE1UHNJZTZr?=
 =?utf-8?B?WlJhL09Ec01uUWg4WkFSTTUyODFCajExV1VzZ2xLa0R4SEdmNyszeDRwL1VP?=
 =?utf-8?B?enVHT1FQTGpsWjJ2Ry9Qb1FWOEsvSXFscHZnU0xBMGx1Y1djRmlSU1lFMlVw?=
 =?utf-8?B?Q3dIS2ZJM1huNys2UzcvQWUxdkI1WWlhVlBPVXFpY1UyRFNscklKVEdNRnQz?=
 =?utf-8?B?WTBDZ2pBWGw3WjEramJZam9tTXpocGgyZmVqY25lS3dFWk9PSUtNcmFBMXhl?=
 =?utf-8?B?VFJOcDhnZEZNUTdjMStsc0t6SStjdDZCbG0zeDlYMkl5NkRJbHEyUUlqckRJ?=
 =?utf-8?B?SUU3SzZCVTFsc21YbkFkVmtwdGsrL1padE5kbzh1R2E5KzRyV2pKeDZ0MnJX?=
 =?utf-8?B?M1BJRGdaWjJ6V2xSb285NkExNTRPYkYzcEFFNm0xeldmMFF5cmNRaDVWTDly?=
 =?utf-8?B?Q08xV1haRGFqeEt3QkRtSmlFKy9YVlNlWlNsVlBMZlkxYm5YaFNWZk1lejRP?=
 =?utf-8?B?RG5VN01PdFJpbUtnc1h2d1lqY0JSUlhTcUM1azlld25BUlhndi9rZmpDQkh1?=
 =?utf-8?B?dVJpS0t5Nk0rZG9tSFJBd3RVU2RzSHJMWVd1d1UwUlhoVVV6aWNZZ2hGRlJ2?=
 =?utf-8?B?bHNSdGtRbHp5R2tIcjU5ckdQcEcrVnBFbU9qK0Jkd0FXN3RxeXZmTTUrZ05y?=
 =?utf-8?B?aDV5WmhDM3poWW93S0RuQnR6VDFoL3V0dDFqV1B2cnZnR1pTeEh6TjRSSWpa?=
 =?utf-8?B?RlJiakFBa1BjakNrMk96MEw3Qy9aak9BeDdsbU9TZWRjU2gwTWZHSzlOdjY5?=
 =?utf-8?B?ME94cTRXODR3OFIwcWdXeU8rMUtxZVJnK09nWXBZNlEwUWFISWtCL1d6WW5V?=
 =?utf-8?B?TjljVFduZExBYzdVRFU4RytCTUovckZ2Nlo0b2o3c2Y5RUJmd0psdjBUcXNv?=
 =?utf-8?B?Qy9IalRXbjNaV00zVi9oSjZhSVFUSFoyMEs5c1dwYUNzbHptemxxVXE2YkE3?=
 =?utf-8?B?WlhkVk8yeXVYTld4dEJUOU15dUd3Rmx4QlFnNWZJYk1ZV1BVVFo2bkUwKzkz?=
 =?utf-8?B?VDhYc013ZC9iYUs0eDFHWlMvS3RnUm5XZkpyMGNaYjdTcHlNQkpCUGNGVnJL?=
 =?utf-8?Q?0RxKwAwWIXTAcBNugIebsTJ7x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3657c087-4d53-4c0d-2c47-08db8d4d1531
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 20:24:01.2343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAb2nw/Fv6G0dKoMPgqu5fiqPSdGb99GoJGhcDOZ9l7cNMZ2sA3cTW3lnHYMNmtq74GjSTQXc/3kFrEWQSOM9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6777
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

Am 2023-07-25 um 16:04 schrieb Errabolu, Ramesh:
> [AMD Official Use Only - General]
>
> Responses inline.
>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Monday, July 24, 2023 2:51 PM
> To: amd-gfx@lists.freedesktop.org; Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Checkpoint and Restore VRAM BOs without VA
>
>
> On 2023-07-24 11:57, Ramesh Errabolu wrote:
>> Extend checkpoint logic to allow inclusion of VRAM BOs that do not
>> have a VA attached
>>
>> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++--
>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 40ac093b5035..5cc00ff4b635 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1845,7 +1845,8 @@ static uint32_t get_process_num_bos(struct kfd_process *p)
>>                idr_for_each_entry(&pdd->alloc_idr, mem, id) {
>>                        struct kgd_mem *kgd_mem = (struct kgd_mem *)mem;
>>
>> -                     if ((uint64_t)kgd_mem->va > pdd->gpuvm_base)
>> +                     if (((uint64_t)kgd_mem->va > pdd->gpuvm_base) ||
>> +                         (kgd_mem->va == 0))
> I'm trying to remember what this condition is there to protect against, because it almost looks like we could drop the entire condition. I think it's there to avoid checkpointing the TMA/TBA BOs allocated by KFD itself.
>
> Ramesh: I am unsure as to how we can detect TMA/TBA BOs if we don't want them checkpointed. Alternatively we can checkpoint and restore TMA/TBA BOs without loss of function. If this o.k. we can drop the check that determines BO qualification.

It's OK. Currently they have a VA > 0 and < gpuvm_base. So this check 
will still work if you only allow BOs with VA == 0.

There is a patch in the works to move the TMA and TBA to the upper half 
of the virtual address space. Then we'll need to update this check to 
exclude anything that has bit 63 of the VA set.

Regards,
   Felix


>
> That said, you have some unnecessary parentheses in this expression. And just using !x to check for 0 is usually preferred in the kernel. This should work and is more readable IMO:
>
> +                       if ((uint64_t)kgd_mem->va > pdd->gpuvm_base || !kgd_mem->va)
>
>
>>                                num_of_bos++;
>>                }
>>        }
>> @@ -1917,7 +1918,8 @@ static int criu_checkpoint_bos(struct kfd_process *p,
>>                        kgd_mem = (struct kgd_mem *)mem;
>>                        dumper_bo = kgd_mem->bo;
>>
>> -                     if ((uint64_t)kgd_mem->va <= pdd->gpuvm_base)
>> +                     if (((uint64_t)kgd_mem->va <= pdd->gpuvm_base) &&
>> +                             !(kgd_mem->va == 0))
> Similar to above:
>
> +                       if (kgd_mem->va && (uint64_t)kgd_mem->va <= pdd->gpuvm_base)
>
> Regards,
>     Felix
>
>
>>                                continue;
>>
>>                        bo_bucket = &bo_buckets[bo_index];
