Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E6FEB64DC
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 09:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1926410E420;
	Wed, 21 Jun 2023 09:10:14 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6981810E420
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 09:10:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NP7tSFnuNTOkmoE+4HYPBj0YmAjn7YvNr9TceL6JTC3ajAsfhndog/1//YWmpK9n8KzYKRhjHXoImSVS3V4/x4yW474aCmbRe49/++j0TGPAjzgwf0Hj/4bXvBKkeBlcgRImYVbOELuvVuk6nFRKQ0mWf9uCEQchMRDWAH8tro9cUs6p9+NHjCwzeOaQ4GGUDCHiy8MwNrMQr/02Dk+lgN1WvCQayDM3S+Pjp2OhAWz1eTUPCwoH3SEHVPX467mmqcAkF5DVIFbXY0YOl45eVLFB/hRUgLqEu7BVg7T4JBUY7WRUOPg2L7oEnoOMi+LLpk5KI/4/ph3vuftwD3Ja3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DTfpLcJ2LyEXdOnZ6XAXNCTHWa3uixkO389/EjGJ9I=;
 b=KinF7beCDmYNQMx4R0Y97mFkBBrhcVldL2HCvOFif2EetZ0LAqbb0G5rq9aPSZrZhT9lXAWNdTHNO1w8tiXMEzJ9qwymhPMpvY/ESr9zL+5No++B0vQS6k69Am9mb0j2TiHhx77uA6pXvEzV7etUJKEeqgDITnSnUlw2bTQHHjPeSheLL+9EYDxqmv+azreIVYBJvrZ97G0Wb0kPYIKqqtRwIG3jzibMEbBnFI3bPh6Qhe9tc82fmsADM9BpHHtcWaPmYApoDCRb1468XyGx6jVm61utwM97MKCw2JyOS+tPNY9lqkd2v1ub8szKKgL4jVykH+q5eW+nKPNJ7FxV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DTfpLcJ2LyEXdOnZ6XAXNCTHWa3uixkO389/EjGJ9I=;
 b=VFd5V41nrWiW2A9fEe44+FtrqWZkIWymuzbIXaj15WF6MeqNJL/Vl7Q86veKkinuuQCKU2zAGztCffS87bguYMXLDfkm1bmwd1el3KxZEiBs7N89lXtKwTL3amzDpj4e3Kd7UlSiI17budZUzkKRXOG19POGMu2ft1OVD8e8Gqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CYYPR12MB8703.namprd12.prod.outlook.com (2603:10b6:930:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 09:10:08 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 09:10:08 +0000
Message-ID: <37bae5be-b806-31c6-28f2-28c31b414dc6@amd.com>
Date: Wed, 21 Jun 2023 11:10:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 06/12] drm/amdgpu: create kernel doorbell pages
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230620171608.2131-1-shashank.sharma@amd.com>
 <20230620171608.2131-7-shashank.sharma@amd.com>
 <a794a151-dec5-436e-fd92-c9e49b3c744e@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <a794a151-dec5-436e-fd92-c9e49b3c744e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::19) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CYYPR12MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc2108d-b8b1-423a-05d9-08db72374ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uqoF87xOPkIP3mdQW0v5Hdf97gxtGf5bc1gEBRV7Q3CwAUMR5TEnYW05GfBZxF/WaCfvu+ezdNlmvtQoDaPLFwiJi1vVemxhAQA6twSHYKBJG1r46pvwlKBzvT4halfgdUJkz2umWkqMfTZ8Nr+90JgwXeLCfynHmPxDZPoXhs9h31IwpmM6otwh2XnXl6YP2k7fTYrZ32MFMzBkSQait4UXRHiY/1EUZxjH84OGNdNYXnsJyohwrEGX5Kcm4XA6MaV1KprW214prONftO8C0fikvA3lVat7PTBW9DqodLv4NINW6IOtHiFlIaGEQT3fhr1t6j61x/cvi0wubBvtdsCPLG/nhdv2g/71PdCBxU6yCnsS/HAgI6Fvn3SIMtFnSmu8/Yh/rWDs4hAT/1190r3K3dXj111fVVvg3UemI6TXElLVJD7fbu/YiTwl8cykx5uZ49IyUY7TqVYLzPu4TAzoBFSW1iWXnXl6h2KFjVjBmmc24E9u/QcqZAc1pYlC+XCUBrQ8sTOwv1vyLqWMRus6AqWxilD2QvqEVrthWCHOkU3iYIFdJvfpLxfKF1honj4R22ZBjMLTbFNtpDtxOyxDupKwNj2uPgygxBA/PymZ7KJ9LAf0/RxfNwTLvNmP/E1ayQJPGcDeY30uBysmdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(4326008)(66946007)(66556008)(66476007)(2616005)(53546011)(38100700002)(86362001)(186003)(6506007)(26005)(31696002)(6512007)(66574015)(83380400001)(36756003)(6486002)(478600001)(6666004)(2906002)(31686004)(41300700001)(5660300002)(8936002)(8676002)(44832011)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHI1emk2MFFhYlpmd1JwbWVUb3dMdHFlRVlIWG1PS0ZFdFJLd21vYTJoM3V0?=
 =?utf-8?B?LzQ5cVMrZU1yOFRNSXFXVk5qUHFZTit2V2lqcWRkLzNGUDk4U2xuYmNvYWkr?=
 =?utf-8?B?SG8xZDUxYVlrV2o5YmFKaGVQdnpFNkN6aU5sanlqbnRrUnlvNFZTdkhGM3pP?=
 =?utf-8?B?RUZ2OG9vYlFVYy83bngxYjlnMEJMdm1oZmtTKzN2ZGVVL2hpcmk1SEFjTjMx?=
 =?utf-8?B?TXVsTktjOUcvbkFYMGdJaHExb3lnYjJMejFjVURQeGQvRGhLRDF2MnlXOFEv?=
 =?utf-8?B?WWdCamx1bjJqZ1gvRXIyY09sK2JZTWNMVjZ1c0lJOHYydVNnWDFXOS82K3V5?=
 =?utf-8?B?SUgxU0lOM2ZrRGVMc1ZkOXZWdm92N2pVZ1JBRnpGbm5VbFFVNFd3WDJFazBT?=
 =?utf-8?B?amJlekNOYU94M0orSGFneXhuK1dHRWhJZHE3d09RMWw5NFl4V2NkOHNHZURW?=
 =?utf-8?B?ck9pM0NKdDlIYnNzVGlZNU50Z0lmWE9BbzhadEc4K3p2c0hHYzljb09ZVzUw?=
 =?utf-8?B?RjJGV1I3N3VnMkgwL0ZDYWJBdThhR21DZ0k1cVpoOTRnQXVhbG1VRjZReUN6?=
 =?utf-8?B?VlRMZS8vNTZaUXg1SnEzemZhWWpTbCtPazVYd01jOXlWTkdFcDNHeDVjajNL?=
 =?utf-8?B?TlNaOUZuaVV2bGNBQUxXK0VYSkQwY0JPZjdPejhpbjhUVUQwZU13SnRxZCtu?=
 =?utf-8?B?ZVhBcDhkTXcyRGdyNVZndkJFNVdEUU05QlUzVTVrY0hsUFQ4WGtGa21hZ1RI?=
 =?utf-8?B?OWNNQ3FsUVJ6eWtWU01yQStJeWRWc0k3VDc3SzhIUkZJeUNvckE1WDFOcHk2?=
 =?utf-8?B?c2VjUFZ1Y3I1Q0l1SitPaWdPN2huYmNIeUVxSERnYzMyM2RXekxESklYZWtN?=
 =?utf-8?B?NkhIckc0MUdBUFBrRHEvSCtMOEpaRmZYdlorSWhBaE4zeUlvaEFxRzh3aXNH?=
 =?utf-8?B?Z0hRbUxTbkhScE9wQUxpVVRqQzBMRTc4cnVwVitnU0xFdTd6UHpRYUV0Ym1u?=
 =?utf-8?B?Q2Rib2E3empMODJNM0IyOTZJVk9uTG9WZzRnaUxWU0d1bC9aSi9CYTFVTVpo?=
 =?utf-8?B?TzlOa2tLeWhPZHd3ZWU5L2RLeGZoQktkVHBvTERRcUV6eGZvOTVVSFFQRGNz?=
 =?utf-8?B?MCtEaUFnSmUyM2JhNWxhRTFtWDRENjBDLytVSWloYVZ0eC91VmRsL2I3QXhF?=
 =?utf-8?B?NzRMMDJyRlZHczN1aE1oV0tGOXlEejNOOHFWeDV5ZVVTYmVudVpwSWlEOUo3?=
 =?utf-8?B?M09MLzBoOFFYSEk0aWgwclJFQnlCd25YQjhoN1A2c2xKNWl4aU1iaTJKNVl5?=
 =?utf-8?B?c2M2RlJwYVJoY2lFcTNaVzVhdHFpQTNGb1lkanRWdncwcTNyQmpZNmRkN005?=
 =?utf-8?B?cCt3THBBazlCSGNYZk9KbDJFVllRd0VnKzhJWjdQTG1GdG9zb3lRS1huQmZj?=
 =?utf-8?B?TXdzVm84bWprbnRWa2tmQ1ZQUjRUVDFlNThONm85a1gxS3NaeUYwd1VYcHIx?=
 =?utf-8?B?TXc0UHo1T004M29IRkcyV1ZDSC9kOEVnbXFvR256OVIxTU5MMHhVdXdiTXJo?=
 =?utf-8?B?YzJLZStRMjZTWE03SmgycUxkTmJSck91dWJnTXpVQ1pFUitZWENIWGhsczZ5?=
 =?utf-8?B?TDZXZmF6emlZd3M1VWNTOTNmcG5LU1dDOVFzNjBDMGUvOFIwMG4yZE8ycVJS?=
 =?utf-8?B?ZlpEbDVsQ0VTMHlpTGNOUjRBZXRxamc4dCt1a1Z0OC9VcHA5cnR3TFRwSlYv?=
 =?utf-8?B?cFN0WDhmbFVaVkhnS2puZDYwNlloTEcvd0kvVklsR3U0VXFsWUhya1lnbCtG?=
 =?utf-8?B?bndhUDBQVGE5U3ZKUWFya1dlKzJXWktWSVdEVUEzSWxQQW1qNkJTd3JudS9p?=
 =?utf-8?B?Zkg1YkkzNERFeFV5Z0Z1bHd6RlYrSnAxcElnTzdNUzJCN2xLWjlaQzFQNzJs?=
 =?utf-8?B?enBIS1h6T1RSejgrMkJoVVhpQWtZM2lWUmhGd1RzeGozVW1JRzF2ZnhyeUMy?=
 =?utf-8?B?S002SkFNRmZqd3RpSHFicjdlSHE3eFdkWnBvcTV6NXFHcUVmY0lwOVFMUUZk?=
 =?utf-8?B?QlduUER2MHBqZENNSUxxVG1Ta0RBWWxoTUxEYkJYSUNNMFJvTlRQK0MrWHd6?=
 =?utf-8?Q?CsG944qhMIuTq1x9gDmmY5ciz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc2108d-b8b1-423a-05d9-08db72374ec7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 09:10:08.2722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90mHRVM063F9hA9UTsUo41jHh0NGUhNGylHglsqcVUzX92DLBoJU7dJGh7/av/boBn5fyddp0LEXbluQOixrZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8703
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Christian,

On 21/06/2023 10:32, Christian König wrote:
> Am 20.06.23 um 19:16 schrieb Shashank Sharma:
>> This patch:
>> - creates a doorbell page for graphics driver usages.
>> - adds a few new varlables in adev->doorbell structure to
>>    keep track of kernel's doorbell-bo.
>> - removes the adev->doorbell.ptr variable, replaces it with
>>    kernel-doorbell-bo's cpu address.
>>
>> V2: - Create doorbell BO directly, no wrappe functions (Alex)
>>      - no additional doorbell structure (Alex, Christian)
>>      - Use doorbell_cpu_ptr, remove ioremap (Christian, Alex)
>>      - Allocate one extra page of doorbells for MES (Alex)
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  8 ++-
>>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 56 ++++++++++++++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  3 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
>>   4 files changed, 60 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> index 783e2b8b086c..002899edb9d7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> @@ -31,10 +31,15 @@ struct amdgpu_doorbell {
>>       /* doorbell mmio */
>>       resource_size_t        base;
>>       resource_size_t        size;
>> -    u32 __iomem        *ptr;
>>         /* Number of doorbells reserved for amdgpu kernel driver */
>>       u32 num_kernel_doorbells;
>> +
>> +    /* Kernel doorbells */
>> +    struct amdgpu_bo *kernel_doorbells;
>> +
>> +    /* For CPU access of doorbells */
>> +    uint32_t *cpu_addr;
>>   };
>>     /* Reserved doorbells for amdgpu (including multimedia).
>> @@ -311,6 +316,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device 
>> *adev, u32 index, u64 v);
>>    */
>>   int amdgpu_doorbell_init(struct amdgpu_device *adev);
>>   void amdgpu_doorbell_fini(struct amdgpu_device *adev);
>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device 
>> *adev);
>>     #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> index eb113e38f5e9..118f4bed32fd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> @@ -39,7 +39,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, 
>> u32 index)
>>           return 0;
>>         if (index < adev->doorbell.num_kernel_doorbells)
>> -        return readl(adev->doorbell.ptr + index);
>> +        return readl(adev->doorbell.cpu_addr + index);
>>         DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>>       return 0;
>> @@ -61,7 +61,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device 
>> *adev, u32 index, u32 v)
>>           return;
>>         if (index < adev->doorbell.num_kernel_doorbells)
>> -        writel(v, adev->doorbell.ptr + index);
>> +        writel(v, adev->doorbell.cpu_addr + index);
>>       else
>>           DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", 
>> index);
>>   }
>> @@ -81,7 +81,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device 
>> *adev, u32 index)
>>           return 0;
>>         if (index < adev->doorbell.num_kernel_doorbells)
>> -        return atomic64_read((atomic64_t *)(adev->doorbell.ptr + 
>> index));
>> +        return atomic64_read((atomic64_t *)(adev->doorbell.cpu_addr 
>> + index));
>>         DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>>       return 0;
>> @@ -103,11 +103,47 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device 
>> *adev, u32 index, u64 v)
>>           return;
>>         if (index < adev->doorbell.num_kernel_doorbells)
>> -        atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>> +        atomic64_set((atomic64_t *)(adev->doorbell.cpu_addr + 
>> index), v);
>>       else
>>           DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", 
>> index);
>>   }
>>   +/**
>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells 
>> for graphics
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * Creates doorbells for graphics driver usages.
>> + * returns 0 on success, error otherwise.
>> + */
>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev)
>> +{
>> +    int r;
>> +    int size;
>> +
>> +    /* Reserve first num_kernel_doorbells (page-aligned) for kernel 
>> ops */
>> +    size = ALIGN(adev->doorbell.num_kernel_doorbells * sizeof(u32), 
>> PAGE_SIZE);
>> +
>> +    /* Allocate an extra page for MES kernel usages (ring test) */
>> +    adev->mes.db_start_dw_offset = size / sizeof(u32);
>> +    size += PAGE_SIZE;
>
> This is initialized but not used, so I suspect it will temporary break 
> the MES test? Or is the MES just implicitly using the correct offset 
> somehow?

I am not sure if I understand this comment properly, can you please 
elaborate ?

If you are talking about 'size', its just used below while creating the 
doorbell BO.

If you mean adev->mes.db_start_dw_offset, its being used in 
amdgpu_mes_kernel_doorbell_get/free and amdgpu_mes_doorbell_init

So both of the variables are being used.

- Shashank

>
> Apart from that it looks good to me,
> Christian.
>
>> +
>> +    r = amdgpu_bo_create_kernel(adev,
>> +                    size,
>> +                    PAGE_SIZE,
>> +                    AMDGPU_GEM_DOMAIN_DOORBELL,
>> +                    &adev->doorbell.kernel_doorbells,
>> +                    NULL,
>> +                    (void **)&adev->doorbell.cpu_addr);
>> +    if (r) {
>> +        DRM_ERROR("Failed to allocate kernel doorbells, err=%d\n", r);
>> +        return r;
>> +    }
>> +
>> +    adev->doorbell.num_kernel_doorbells = size / sizeof(u32);
>> +    return 0;
>> +}
>> +
>>   /*
>>    * GPU doorbell aperture helpers function.
>>    */
>> @@ -127,7 +163,6 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
>>           adev->doorbell.base = 0;
>>           adev->doorbell.size = 0;
>>           adev->doorbell.num_kernel_doorbells = 0;
>> -        adev->doorbell.ptr = NULL;
>>           return 0;
>>       }
>>   @@ -156,12 +191,6 @@ int amdgpu_doorbell_init(struct amdgpu_device 
>> *adev)
>>       if (adev->asic_type >= CHIP_VEGA10)
>>           adev->doorbell.num_kernel_doorbells += 0x400;
>>   -    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>> -                     adev->doorbell.num_kernel_doorbells *
>> -                     sizeof(u32));
>> -    if (adev->doorbell.ptr == NULL)
>> -        return -ENOMEM;
>> -
>>       return 0;
>>   }
>>   @@ -174,6 +203,7 @@ int amdgpu_doorbell_init(struct amdgpu_device 
>> *adev)
>>    */
>>   void amdgpu_doorbell_fini(struct amdgpu_device *adev)
>>   {
>> -    iounmap(adev->doorbell.ptr);
>> -    adev->doorbell.ptr = NULL;
>> + amdgpu_bo_free_kernel(&adev->doorbell.kernel_doorbells,
>> +                  NULL,
>> +                  (void **)&adev->doorbell.cpu_addr);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> index 547ec35691fa..a403418d5eac 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -128,6 +128,9 @@ struct amdgpu_mes {
>>       int                             (*kiq_hw_init)(struct 
>> amdgpu_device *adev);
>>       int                             (*kiq_hw_fini)(struct 
>> amdgpu_device *adev);
>>   +    /* MES doorbells */
>> +    uint32_t            db_start_dw_offset;
>> +
>>       /* ip specific functions */
>>       const struct amdgpu_mes_funcs   *funcs;
>>   };
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 6d1587bbda52..c48e97646541 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -1854,6 +1854,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>           return r;
>>       }
>>   +    /* Create a boorbell page for kernel usages */
>> +    r = amdgpu_doorbell_create_kernel_doorbells(adev);
>> +    if (r) {
>> +        DRM_ERROR("Failed to initialize kernel doorbells.\n");
>> +        return r;
>> +    }
>> +
>>       /* Initialize preemptible memory pool */
>>       r = amdgpu_preempt_mgr_init(adev);
>>       if (r) {
>
