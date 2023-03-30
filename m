Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974B3C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 11:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C9210E1DD;
	Thu, 30 Mar 2023 11:49:03 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76B7010E1DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 11:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyYiFplI/NRNEFwt9uSineQ+Hg1pwuGaUmvbtm3sPTFNqgtMn1aPY7M3IJVsAYOhGmr+AhCexcDSaSa9zsUb06wprDsjtr7YejY+jXWJaNzWaHiNPGHRy7uo/VHJJvgIlbqLL2RMyy/RcIOHyvg0uT9c1xgVOvt1+eWYCBtVIWU63beNuxcfdV2uySU63yxagz7yIaj4vPyr7G3jHB19F89Fn0YHOm5Ttg+MYvgJLXt//xHphYW/29Luyuzw3Q9MYW1OoYpPRqlaTv15xwoo8hMiwXsawXu5XCo4pLrdJWpM68djAEp16kmd//UQsGWWbp8xnvXg64WvKB7tV4CSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2HK1ScLF8mpEXvnU0bDImBQMUQAuJwTIXZIonG4A1M=;
 b=WR7fEaz8Rz4zQPrWC1eQU+aZcDE+PsxxyStGU4BmLbW2peNcphWUHJ67s6hLPEC9PmtyNmGqzK4nH7104qsaXIHNN2AGDSoUdkO64+X9c9VPoK96mBqAxYXV0YsAEDv8r6ViO1irHlxNBJ2mlYsuzUQACwssvieTPogWPBxHZOfSirp6t4ecc9z+XX9xae/DdntNKHgSUJs6PE6KASKEmw7iPDqajLqXVzQDRQk0/X2cNqTnIINQbMR8yXGKMyt0xlJCkMz0Fc3f77tHC5kDrmeDCtHKBocOejhphCd72p7d4IfsjFhPTQIa50NGVFpyfGv4YWXS7i87pYDSfScknQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2HK1ScLF8mpEXvnU0bDImBQMUQAuJwTIXZIonG4A1M=;
 b=y4oxI0XDkccf+XVVQZbbHHKB//lyS6RNT67NpC6pocQPTze0Z+3ebQr11QyI2w4Bz+Es0HDg25DfNKQrblDEszb/3U1uiBmiaZtZeYYkEcuVMsgN9u2is6aHMV9yzS0tG3Fypcorofxfz5D9rJkc8k9qTNk3CgIUsugn3Bd9xNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 11:48:58 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 11:48:58 +0000
Message-ID: <0ceb747c-d71f-a6ae-67e4-a53f136ca0bd@amd.com>
Date: Thu, 30 Mar 2023 13:48:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 09/16] drm/amdgpu: create kernel doorbell page
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-10-shashank.sharma@amd.com>
 <4c4776ea-c53c-a37a-ba4b-3a0be4e7645c@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <4c4776ea-c53c-a37a-ba4b-3a0be4e7645c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::12) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4b2243-c8cb-4e91-766f-08db3114bed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOmcr6o09ZNQUJ7Xeamk2hGhHjMh5OU1iuRRffhNer4ODQ1XCNDpOlN1Wf9blk+Vgo1Yr/MukjLDMdUng1qobtX9gdNK8OAbGqDq81pUmmZiJOjWk1vL3QJsDFTd9FlWbsPOUutf68xsFIhmHyoBhCFKVQEw8qOCzQSle7rSKtHRpEHr0ymj4O0xAg8QIdIE9FzKZp/8WwbI/IXzycfoupVBmUP6jv+dzpApnEqXaonVaQ+sJeMvoDIKxH0l22ZVc/ZQqmcsYA07tp0whCW9dkP6892Gvpl9RcVZsSEcIciWSF65HC7KLG8nyo7eF3IME66b6v4b/ooq89Dnliy18jSEodURXqZphOTRpW/6mdgPgAdW/MbQV30c8y1yZB8FRPdqHOtl8RFtSpOLHeRTWOlSjqaViuOGsWtZOpIY9hAZZL1fu/nnDtHoafe+Fj4e8qoPxyjahOy1WTzJJCHKpuFQWxYoliSF0bhJaYZtwuAWbag6qQ0f1iq8gO/3k8nDiDyl8BRiF5GTeRr9MvnXUc+l5UwymF3lzzc5YtAVMeiompHUdR27eVDCX0sGErTE6p9H/ekbBgNkrpMgNSfjU6YMHMgvXJ5ma6t6IyyF+RfB0++AaLm50kyGvaKUg02UXJhX6EeS3kLVV+AuUh/C7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(316002)(478600001)(54906003)(36756003)(31696002)(86362001)(8936002)(5660300002)(66556008)(4326008)(38100700002)(44832011)(66476007)(8676002)(2906002)(66946007)(41300700001)(6506007)(186003)(6666004)(53546011)(26005)(6512007)(83380400001)(31686004)(66574015)(2616005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlBRditUSHMwWmc1ZXc5dWY3aVljSFZpakdNYVBsQWdGUmc0b3BnaEFmUE94?=
 =?utf-8?B?MzNCK3Y3MmNEUTlyWE9lTVlXK3RFaW84WGZTWHpWam9SOHM1NHY0eVE5TkhH?=
 =?utf-8?B?ckN3Qk5sVmFyZ1ZsTFErVU80R0ZWbkF3REZ6UEdxL1VmMHY0c2lVblRkSCs0?=
 =?utf-8?B?RDVSNGZEbmdlWFE5Sy82TXoxSldWQ0I5a0VPY1d0aUQ5amN1WjRsTHdjdm9S?=
 =?utf-8?B?ZXFhTGN3RjNvckZZZ1hNck9BT3kxeS9wN3FKcWhuWnFIWHY2Ti95MlV6K0pN?=
 =?utf-8?B?QTQvazBzd09DQVFBTE1SUUhhU0NBNk5Dd3FrZmtSL0NSRUdCdDNmNHpTdmNR?=
 =?utf-8?B?UnNQOFAvam9IZjlHblZlZDVuM1dzWXRrU3dEMGZQUlBXSUpiY2VzT0s5OFNK?=
 =?utf-8?B?Ymt3MWRHRERZeVpqZzVuUUdZSHV2WEl3WnpyQlM3U2hPVkxCaGVEN3FVa1Aw?=
 =?utf-8?B?alc5cFJvQkYwQ0lEMkZvdkwxcHdzb3dsVFEvQ2xLL2pOdkJUVjRZU1JBOUQy?=
 =?utf-8?B?ek1QNTNodUpyQURNeGpUNm1ENWFJemhURWhaME9MZ1MxcEpQS2NrcU81RnNX?=
 =?utf-8?B?MXhyY3JNNkZlY21MRXZub0p0QlRDMy9Ic3pyT3dvbmxqcHZNQXBKSVBXRXdM?=
 =?utf-8?B?dXZUS1h1UWpCTlR2L2xxS1BpZ3ZjcW9jQUY0Ulh3ZHNxOXBjbFg2dkxBL3FQ?=
 =?utf-8?B?aThNUDNMaWlaZzhPaHNNdnY5ZmlJcEVkYmhMZ1lLV1FOcWNEVTU1U1Qxcjla?=
 =?utf-8?B?L05wNFFiM1MzNmlqZXhTVElUUHZPelF4aGxHR0wyay9vNlFpUDlOSFNUelhC?=
 =?utf-8?B?Nnh0OUQvZ0U5ano5MGN1eHRGL2VPV3gxN3NOaHhEeEZ5SW5CbDZYVDNnU0ow?=
 =?utf-8?B?S2Y4N2o0a0JJMTZ6b3lTOXdEbUhsZXFCL3BDSUJJUXZiNzhLS3Z3elQ5aDlW?=
 =?utf-8?B?azBNNTIvY1FIZG44S0t6azlnaWlEWjFtcUxNUUptdnJaRXM3Ykh2NVc3aVFV?=
 =?utf-8?B?WlFqekt5Nksyc2ovMmJRUWtQRWlIL2pKSDJhR2FpS0dHSVlEWC9yVTJOaVYz?=
 =?utf-8?B?dXRYUnIyWVg4a0Q0bmltc0p4ZHJQcVZTeHRTa1kxZ1FqN2tQMUIxS0VIaEZU?=
 =?utf-8?B?SzF1UGljazJhU2FNdjJIZS90djYzbExjMjVQbXFPMHZMcGdxZTB2TWJoNEc5?=
 =?utf-8?B?OW9lSFoxcGc2d3NYelJ3dzYrV1l3SDZlSWJSRVJ3cnVXMXJqa1ozUVN2WHg3?=
 =?utf-8?B?OVdLRlNsWUNucjFPSUJwMWpUQ2JTWElLM1JGUEVVSm9jWUNWUzZuam9uU200?=
 =?utf-8?B?M1JjRTJQWXRpSmhJSjlhbUwvSGwySDZESlhiT1QzeWJGa3JvU0NONGxEMzBN?=
 =?utf-8?B?TW9rYjNIQjJwZXVYQTZzbGczZUtsMHJrRkVkN0R3ck9BTUVGSkEraFJDa3o4?=
 =?utf-8?B?M092TW1yQnlteDBqeEFlU0ZiVTZRRGQrdXpLcTNiNjFnQUV6clQ3M0U2MWlW?=
 =?utf-8?B?dGlwRGtDeDFja3lKU1FNU3hXc0laS28rTS9uMmhmTTF0c3VpYnVvQ21uQTlw?=
 =?utf-8?B?RkpwRmYydXVVMmlKYUJ2UFNMV1FiU21GODJXVTVLRkpjbnVnQ2JvSFhRRWRZ?=
 =?utf-8?B?SHpUTHY5eExCQXNTVUl6dlJOODRLczF0YWRKTVhlVFlLaXpIc0ZsNjU4QUx0?=
 =?utf-8?B?em0zZG9ISzVTcWxHeTBiMnlmb28waGZ6bFJFc2JaSGVQK2MyOS8zdmZnc0Ns?=
 =?utf-8?B?K01iWGZqNlIzZlBlSUhrREZFSWpmNlBWUFdoRE9SVm9HZC9GNnY2Y1kvZ2Jv?=
 =?utf-8?B?V0pWdU44ZWQ5YmIydVh0NSsyYjhSejkxbnJyWWI0VGNzS1UwOFNsaUxDc0tp?=
 =?utf-8?B?MlhrdHEyVFYyeGFXV2V0OEQreGFRWEN5blZkeURDQUlXVktZSW9qM2hKOGRS?=
 =?utf-8?B?czF0WkgrcUN1S0xFSDhzRlNOcG45Z2dDa24xMUdmSW9rdld2UENFVXVxK3RK?=
 =?utf-8?B?MklzbFpjbXQwQXVrTllLc1RBYnF5U0xzajRxUGJpWVdsTWZEdHdERnh3eTZh?=
 =?utf-8?B?dUZIeUZZU3JTVFd4NUxNZk9DMHVTWkxQUXBKUjVnWjUyS2xGaFhuYnY3SUNr?=
 =?utf-8?Q?URRsiMVxFk315JB73ksF7Rr9g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4b2243-c8cb-4e91-766f-08db3114bed4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 11:48:57.9465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYpBEWbCx9B0VBv4wYYEwjCJ2W4Zx3YcWo/1/IqiohS1EA19qs7QVFr/ySQ5n8Z4hFAnZJLwbUpM+RfNrdrFSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 13:30, Christian König wrote:
>
>
> Am 29.03.23 um 17:47 schrieb Shashank Sharma:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> This patch:
>> - creates a doorbell page for graphics driver usages.
>> - removes the adev->doorbell.ptr variable, replaces it with
>>    kernel-doorbell-bo's cpu address.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 16 ++++++-
>>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 44 +++++++++++++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
>>   3 files changed, 57 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> index 6581b78fe438..10a9bb10e974 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> @@ -49,10 +49,13 @@ struct amdgpu_doorbell {
>>       /* doorbell mmio */
>>       resource_size_t        base;
>>       resource_size_t        size;
>> -    u32 __iomem        *ptr;
>> +    u32    __iomem        *ptr;
>
> This one can probably go away if we use the pointer from 
> amdgpu_bo_create_kernel().

We started like that, but later realized that the cpu_addr from 
create_kernel() will just limit us

to that object only, whereas we are keeping this ptr to ioremap the 
whole doorbell space in one shot.

- Shashank

>
>>         /* Number of doorbells reserved for amdgpu kernel driver */
>>       u32 num_kernel_doorbells;
>> +
>> +    /* For kernel doorbell pages */
>> +    struct amdgpu_doorbell_obj kernel_doorbells;
>>   };
>>     /* Reserved doorbells for amdgpu (including multimedia).
>> @@ -369,6 +372,17 @@ void amdgpu_doorbell_free_page(struct 
>> amdgpu_device *adev,
>>   int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>                   struct amdgpu_doorbell_obj *db_obj);
>>   +/**
>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells 
>> for graphics
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * Creates doorbells for graphics driver
>> + *
>> + * returns 0 on success, error otherwise.
>> + */
>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device 
>> *adev);
>> +
>>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>>   #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> index 8be15b82b545..b46fe8b1378d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> @@ -160,6 +160,38 @@ int amdgpu_doorbell_alloc_page(struct 
>> amdgpu_device *adev,
>>       return 0;
>>   }
>>   +/**
>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells 
>> for graphics
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * Creates doorbells for graphics driver
>> + *
>> + * returns 0 on success, error otherwise.
>> + */
>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev)
>> +{
>> +    int r;
>> +    struct amdgpu_doorbell_obj *kernel_doorbells = 
>> &adev->doorbell.kernel_doorbells;
>> +
>> +    kernel_doorbells->doorbell_bitmap = 
>> bitmap_zalloc(adev->doorbell.num_kernel_doorbells,
>> +                              GFP_KERNEL);
>> +    if (!kernel_doorbells->doorbell_bitmap) {
>> +        DRM_ERROR("Failed to create kernel doorbell bitmap\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    kernel_doorbells->size = adev->doorbell.num_kernel_doorbells * 
>> sizeof(u32);
>> +    r = amdgpu_doorbell_alloc_page(adev, kernel_doorbells);
>> +    if (r) {
>> +        bitmap_free(kernel_doorbells->doorbell_bitmap);
>> +        DRM_ERROR("Failed to allocate kernel doorbells, err=%d\n", r);
>> +        return r;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   /*
>>    * GPU doorbell aperture helpers function.
>>    */
>> @@ -179,7 +211,6 @@ int amdgpu_device_doorbell_init(struct 
>> amdgpu_device *adev)
>>           adev->doorbell.base = 0;
>>           adev->doorbell.size = 0;
>>           adev->doorbell.num_kernel_doorbells = 0;
>> -        adev->doorbell.ptr = NULL;
>>           return 0;
>>       }
>>   @@ -208,12 +239,7 @@ int amdgpu_device_doorbell_init(struct 
>> amdgpu_device *adev)
>>       if (adev->asic_type >= CHIP_VEGA10)
>>           adev->doorbell.num_kernel_doorbells += 0x400;
>>   -    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>> -                     adev->doorbell.num_kernel_doorbells *
>> -                     sizeof(u32));
>> -    if (adev->doorbell.ptr == NULL)
>> -        return -ENOMEM;
>> -
>> +    adev->doorbell.ptr = ioremap(adev->doorbell.base, 
>> adev->doorbell.size);
>>       return 0;
>>   }
>>   @@ -226,6 +252,6 @@ int amdgpu_device_doorbell_init(struct 
>> amdgpu_device *adev)
>>    */
>>   void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>>   {
>> -    iounmap(adev->doorbell.ptr);
>> -    adev->doorbell.ptr = NULL;
>> + bitmap_free(adev->doorbell.kernel_doorbells.doorbell_bitmap);
>> +    amdgpu_doorbell_free_page(adev, &adev->doorbell.kernel_doorbells);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 203d77a20507..75c6852845c4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -1866,6 +1866,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>           return r;
>>       }
>>   +    /* Create a boorbell page for kernel usages */
>> +    r = amdgpu_doorbell_create_kernel_doorbells(adev);
>> +    if (r) {
>> +        DRM_ERROR("Failed to initialize kernel doorbells. \n");
>> +        return r;
>> +    }
>> +
>>       /* Initialize preemptible memory pool */
>>       r = amdgpu_preempt_mgr_init(adev);
>>       if (r) {
>
