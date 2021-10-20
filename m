Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFF8C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 08:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C19F61057
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 08:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C19F61057
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD57C6E847;
	Wed, 20 Oct 2021 08:41:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFBD66E847
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 08:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RV1JzncGos9Rek8EE9AhrbnpfGuUwLMmry1Yjb1k9acd7WJDXkWyq0pfkeSujs/xyPHMgdGqDk48JsIDlAlTBVtwB7piRr/ctulgmtWewDQdnka8UDVKzDlhSJ3EuHOuT3IupodxBTyNqii81TeL1DkFGThhdSBYfFUCj7sjZ4XDtuwDP3AXLuxHpodOC6IC8yJT0UNCl2SmdxeNzC9yW+DEJM92pZ3QMlR2OTXDdLMuYckFfOmQnsjtj2PoY8OaVQ9DzIMqp9+L4HgkGMw7zLika1XeGZ09rqYjDtFgEMwsDhoE3RgbdmvL7vRKaaOKhcqIZkMN/7ozK61LY3Qqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sxjx5tEPn5uvEC9Q1+PPIiRK9aRfvpevyMbx1l11fME=;
 b=MS54tGPc3SPd2J1v3Ud4tGRmY7e6MUwGWwqWtEm/LDEZBQrbHhjuVlHfN6YBeGlX2gGl5+qIX1/UkrNCccvZzTGowTlUox5uAz9NTHjAvS11BtR6IHry00+2nia14lf+bFoSABLIDFspp6DzT5G5vcFTn4/SF0aSo+XdJff9EOEtr915hQtEzeVFZk37YCwtORJH5VTXEv8Rj/sWlEDYxNx+zM/vqyo28hyT0SooKVS4SEMRKeieB08JqhcIXe/TZpQrPaHx3JkpasT5ER79sJCo9VTnwPHm2MEb6ZQS+ISgHBVVHcaR0LhMGzlC3xFgAhizonKgjLJGhT1pXyO9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sxjx5tEPn5uvEC9Q1+PPIiRK9aRfvpevyMbx1l11fME=;
 b=FisF2ZwB6QaeKN9cltWl/rmkjsCIQAUALTjoql6zDp2KJbg+SA6dnDz+Q4Fw0sRkA8+uwFJNT4SPGYmACPClR7y7oqJRIDJY0e1KIbQYDzyjnJY9ZZ29KnkkZcUH8yQ/+fYxMokFj+jQyTnKHfronEOKcRsaqSS3aTCMlP7d6OY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 08:41:28 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 08:41:27 +0000
Message-ID: <64d8c7b9-74e9-81b2-9e8b-69bdf82b8e43@amd.com>
Date: Wed, 20 Oct 2021 10:41:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/3] drm/amdgpu: recover gart table at resume
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: andrey.grodzovsky@amd.com
References: <20211019181449.12356-1-nirmoy.das@amd.com>
 <20211019181449.12356-3-nirmoy.das@amd.com>
 <e80e95fa-5acc-1cc4-dc38-14c7469144a8@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
In-Reply-To: <e80e95fa-5acc-1cc4-dc38-14c7469144a8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0152.eurprd06.prod.outlook.com
 (2603:10a6:20b:45c::21) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.88] (217.86.117.49) by
 AS9PR06CA0152.eurprd06.prod.outlook.com (2603:10a6:20b:45c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Wed, 20 Oct 2021 08:41:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e5d6d48-c296-436f-fca7-08d993a5681f
X-MS-TrafficTypeDiagnostic: DM4PR12MB5296:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5296FBCC8A58573F704910658BBE9@DM4PR12MB5296.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULDlxcs4EAx6s/n8Sw7vyfMXvEACnJV9kHASd3bh5XYNVfOiZb1q1jQHx4c+x9KA9SpbOkRiLF9pDfnDEvVd5VNMSkLa/OkQttO4FTqKQNvibDNsbC33SQEcUrtSy9MPulmNmBtJ9180PeLVQKE4b4gn2XEDZ2+s6p/3lJdjk7Q8C5VwsbizCAxLnaqqZyidLxMP4Rp1NjEMlUq+KeM0p1G+txN76ZfI1aFsZkI6F5OuGd6L4Md+oM3EDRE8PVlKScUdsh+IW1fxZ9fh0pFGryBUP6xHI5Dh0PO0AuXzT1TR5+Tnzy2Z8u9UABvgP8hViOoHwIVVyGSRvn2nhkHyxC2X/wv00iZZZeUTZGwI5GYwoFBSdSTpN74L3oyHTqrtyjo86Oe4dwByBa0Z3SO8Ku9KCwgAJwshDdPYH6/zBKG2/yQSAb+zj0N1P06pOWtVHmpPItf5qeE1cOOSax3T0kuDIRCFp43ReDuZ4PDsC+2/Q1lC2HfzLmn1hwW/vgSnMneF5fOufOQf5ACr8GMFiykj6EkaVu8j9pmQVI366+nnbM0YBmnIS3cL106ZtyMXq+6JlnS8bJER0f3l75aDPjchCrgjP/3CODvMYzgDBaHVt52v2V/fVMqbZSu17JQJ8P3WuBCvPQ3tBwptBwfr6IOXn2SZkCUNmuHChgR3a/xQc9MoYGRACWx+AfjssyFhgRdVyoDJnxF1rfBZkeQQdks0k+8BgxgLJRUsVr8V67A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(316002)(6486002)(53546011)(31686004)(8936002)(38100700002)(2906002)(6666004)(16576012)(83380400001)(508600001)(4326008)(26005)(956004)(66946007)(5660300002)(31696002)(66556008)(2616005)(66476007)(86362001)(66574015)(8676002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGZxUGdCazRXM2U0VnU2UHZBTWxwbmI0WCtyUTl5RjRXaDA0N0dSbTZMWld6?=
 =?utf-8?B?WURVTEJqUEg5bCtCdm9iN0ZuWTF2bC85aTVTTlMrSXRpZUFnNkQ1MzlseVpl?=
 =?utf-8?B?OUtPU1BwRnkyVHMvSlF3Rm9pMTVVWUpmM1h5dDBXMy9yTnYreUlnTk1KMU5B?=
 =?utf-8?B?ZWFURTBOM2dVbUNOTEhEVElpeXdFNkdVOEN2WG1nb1dZR3AvSU9pcnVKTnZT?=
 =?utf-8?B?bnY2QUhXVEJRVmYzS3lRemtyM1o2UXh1WW44dEF4bjVtSDZaUjUvajRaOUVW?=
 =?utf-8?B?dVZvKzJ0WjB3K2lHVmwzTXQyMUYxNVNqYkRjUzBPZDRYaDYzZ1lNdnpVNDlk?=
 =?utf-8?B?RDFuRDBydUFRVXdmMjVyMjUxU21WS2dBS0VrUnhpZXJRYko3bUxzRWZmV2NC?=
 =?utf-8?B?alY1S0tMbThhVGR3dU1mazhNdnMxOVJtaGxyQ2owbDArSkQydExGbEMyRVpT?=
 =?utf-8?B?b2pha3A2UjdyRmdnbWV6SGRqaHlXR05ObUJsZ3AwS0ZocFVuSE5jUFA2SERz?=
 =?utf-8?B?VHpJZm5KZkQ2ZDAyak12MXhXRzB3OXJDRVdTaXBxNVN1OGhZa2RjTzJMbWtu?=
 =?utf-8?B?aThJWFJWT1pTZWlpNDhrNWxQY2pFWDZKdVlTNGU4eDdrRzZBdEtwcCtpOGNZ?=
 =?utf-8?B?N09KdGdvcnkzb1lQcHpqSnBzUU43TjlNNWUrRnBIUWc1SW9SZVNOU0RqbmN3?=
 =?utf-8?B?SytFQ1Rwc1hvbWZ1T2wzUURYRFpxQU45Q29QTWx3Z0FtZWl5dW5Nem5JZmt5?=
 =?utf-8?B?NkxZaU9GK1Rrd0tPV1M3cU5uT253ZFFKWHJ4c3VmOGpKQnFQSHBFQXVmUUFG?=
 =?utf-8?B?eVBVMW5sOEdVOHo4T3AxZE9EL213UEtib2JpaExkN3NLL2pucVd3WG4vVjE3?=
 =?utf-8?B?VDhVL29Xc1VUZnZ3N1YzQnIwU1dPUlZSdXVHT3RGaTVOdHFCcVE1S0dvenBM?=
 =?utf-8?B?N3hkbmYyV05aaFBXMjBZZmd5cjk1YmxuZFh4TnpjRU5ucUF5bDBBZ0pYS1ly?=
 =?utf-8?B?UkwxcEY2azRSdThzbFZXSGZIVVdBTkxZRGVhNFkxdTc3MElQQVlNd1RXOTRq?=
 =?utf-8?B?NThDeGNHd2x3dzlxVjJab24rOTlLZGs5MUxSenl0eWZCaDMwejN1OFk2KzFC?=
 =?utf-8?B?d3JHbms3cXhldWhZdWR2SlBLOFZTaXl5dVhjQW1BaTlNU0gxS0tmSTBPSE9v?=
 =?utf-8?B?aW5NZXNaSlNRM3p6UGdJMW91eXUvSzdEZklId21YNUVzQithelI5VUZOQkpu?=
 =?utf-8?B?T1Z2L29YVXp1TnpEanlKOXRMS2NJNlNBWXhRYzQyWHBhWTRVM1phM29pbUFM?=
 =?utf-8?B?NVRxelN0WjhvblJzRW0yWGlFVU9ONzdiWStGckN6ZEk0MUc2SGRZUDl5ZVBY?=
 =?utf-8?B?YkNMdkFWMWR6eTA2c2NCZXI0T0tnSElxcys2eDB1NkpXczkxblZLa3EyNE9H?=
 =?utf-8?B?amsxV2hIZ3NuVnJOS01GNnhzUnA0bkg3TzE1L05QVkJmbEFVWGpBRlNjYmFj?=
 =?utf-8?B?MHFrQ3NHam9pSEF3YlJDeVdTM0gvNDNUTFFxOFVzeXRGdzFpZXpJNWZKSHZi?=
 =?utf-8?B?NE9aamlQc3ZoT0Z2SFVvNDRzRlRwQ2FoRk9Gdy9rSitLVUNPNDl5OTMrejdJ?=
 =?utf-8?B?QzZpZ3UybC9zQWVoWkNnbkZxSjl6TUR5ejlTTUExRkI2eGYwbjJCWXZSRXA1?=
 =?utf-8?B?cHZkSkZrNThkZHJaSWRqd1BDS29JMDU1bzB4aEdMRE5YMXZVMitmemt2VjlQ?=
 =?utf-8?Q?x90+YJfofs0KWXtIdJG2mmswjLMQH0eeY0EyfI/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5d6d48-c296-436f-fca7-08d993a5681f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 08:41:27.8436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkCNTxdR+O9AMlxNq7GGAaV0/Mlwv23vXrHFaNuugEgDzd0C9lZ6VzBVldmIhfqEs3lG4mX8yhjH8b7ufHGk/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5296
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


On 10/20/2021 8:52 AM, Christian König wrote:
> Am 19.10.21 um 20:14 schrieb Nirmoy Das:
>> Get rid off pin/unpin of gart BO at resume/suspend and
>> instead pin only once and try to recover gart content
>> at resume time. This is much more stable in case there
>> is OOM situation at 2nd call to amdgpu_device_evict_resources()
>> while evicting GART table.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 42 ++++++++++++----------
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  9 ++---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 10 +++---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 10 +++---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  9 ++---
>>   6 files changed, 45 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 5807df52031c..f69e613805db 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3941,10 +3941,6 @@ int amdgpu_device_suspend(struct drm_device 
>> *dev, bool fbcon)
>>       amdgpu_fence_driver_hw_fini(adev);
>>
>>       amdgpu_device_ip_suspend_phase2(adev);
>> -    /* This second call to evict device resources is to evict
>> -     * the gart page table using the CPU.
>> -     */
>> -    amdgpu_device_evict_resources(adev);
>>
>>       return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> index d3e4203f6217..97a9f61fa106 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> @@ -107,33 +107,37 @@ void amdgpu_gart_dummy_page_fini(struct 
>> amdgpu_device *adev)
>>    *
>>    * @adev: amdgpu_device pointer
>>    *
>> - * Allocate video memory for GART page table
>> + * Allocate and pin video memory for GART page table
>>    * (pcie r4xx, r5xx+).  These asics require the
>>    * gart table to be in video memory.
>>    * Returns 0 for success, error for failure.
>>    */
>>   int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
>>   {
>> +    struct amdgpu_bo_param bp;
>>       int r;
>>
>> -    if (adev->gart.bo == NULL) {
>> -        struct amdgpu_bo_param bp;
>> -
>> -        memset(&bp, 0, sizeof(bp));
>> -        bp.size = adev->gart.table_size;
>> -        bp.byte_align = PAGE_SIZE;
>> -        bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>> -        bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>> -            AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>> -        bp.type = ttm_bo_type_kernel;
>> -        bp.resv = NULL;
>> -        bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>> -
>> -        r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
>> -        if (r) {
>> -            return r;
>> -        }
>> -    }
>> +    if (adev->gart.bo != NULL)
>> +        return 0;
>> +
>> +    memset(&bp, 0, sizeof(bp));
>> +    bp.size = adev->gart.table_size;
>> +    bp.byte_align = PAGE_SIZE;
>> +    bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>> +    bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>> +        AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>> +    bp.type = ttm_bo_type_kernel;
>> +    bp.resv = NULL;
>> +    bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>> +
>> +    r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
>> +    if (r)
>> +        return r;
>> +
>> +    r = amdgpu_gart_table_vram_pin(adev);
>> +    if (r)
>> +        return r;
>> +
>
> Instead of all this you should be able to use amdgpu_bo_create_kernel().


OK, with that we can remove amdgpu_gart_table_vram_pin() completely.


>
>>       return 0;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index 3ec5ff5a6dbe..75d584e1b0e9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -992,9 +992,11 @@ static int gmc_v10_0_gart_enable(struct 
>> amdgpu_device *adev)
>>           return -EINVAL;
>>       }
>>
>> -    r = amdgpu_gart_table_vram_pin(adev);
>> -    if (r)
>> -        return r;
>> +    if (adev->in_suspend) {
>> +        r = amdgpu_gtt_mgr_recover(adev);
>> +        if (r)
>> +            return r;
>> +    }
>
> Please drop the in_suspend check here.
>
> If I'm not completely mistaken the GTT domain should already be 
> initialized here and if it's not then we can easily check for that in 
> amdgpu_gtt_mgr_recover.


Yes it is. I will remove that.


Thanks,

Nirmoy


>
> Christian.
>
>>
>>       r = adev->gfxhub.funcs->gart_enable(adev);
>>       if (r)
>> @@ -1062,7 +1064,6 @@ static void gmc_v10_0_gart_disable(struct 
>> amdgpu_device *adev)
>>   {
>>       adev->gfxhub.funcs->gart_disable(adev);
>>       adev->mmhub.funcs->gart_disable(adev);
>> -    amdgpu_gart_table_vram_unpin(adev);
>>   }
>>
>>   static int gmc_v10_0_hw_fini(void *handle)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> index 0a50fdaced7e..02e90d9443c1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> @@ -620,9 +620,12 @@ static int gmc_v7_0_gart_enable(struct 
>> amdgpu_device *adev)
>>           dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>           return -EINVAL;
>>       }
>> -    r = amdgpu_gart_table_vram_pin(adev);
>> -    if (r)
>> -        return r;
>> +
>> +    if (adev->in_suspend) {
>> +        r = amdgpu_gtt_mgr_recover(adev);
>> +        if (r)
>> +            return r;
>> +    }
>>
>>       table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>
>> @@ -758,7 +761,6 @@ static void gmc_v7_0_gart_disable(struct 
>> amdgpu_device *adev)
>>       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>>       WREG32(mmVM_L2_CNTL, tmp);
>>       WREG32(mmVM_L2_CNTL2, 0);
>> -    amdgpu_gart_table_vram_unpin(adev);
>>   }
>>
>>   /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> index 492ebed2915b..dc2577e37688 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> @@ -837,9 +837,12 @@ static int gmc_v8_0_gart_enable(struct 
>> amdgpu_device *adev)
>>           dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>           return -EINVAL;
>>       }
>> -    r = amdgpu_gart_table_vram_pin(adev);
>> -    if (r)
>> -        return r;
>> +
>> +    if (adev->in_suspend) {
>> +        r = amdgpu_gtt_mgr_recover(adev);
>> +        if (r)
>> +            return r;
>> +    }
>>
>>       table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>
>> @@ -992,7 +995,6 @@ static void gmc_v8_0_gart_disable(struct 
>> amdgpu_device *adev)
>>       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>>       WREG32(mmVM_L2_CNTL, tmp);
>>       WREG32(mmVM_L2_CNTL2, 0);
>> -    amdgpu_gart_table_vram_unpin(adev);
>>   }
>>
>>   /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index cb82404df534..732d91dbf449 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1714,9 +1714,11 @@ static int gmc_v9_0_gart_enable(struct 
>> amdgpu_device *adev)
>>           return -EINVAL;
>>       }
>>
>> -    r = amdgpu_gart_table_vram_pin(adev);
>> -    if (r)
>> -        return r;
>> +    if (adev->in_suspend) {
>> +        r = amdgpu_gtt_mgr_recover(adev);
>> +        if (r)
>> +            return r;
>> +    }
>>
>>       r = adev->gfxhub.funcs->gart_enable(adev);
>>       if (r)
>> @@ -1793,7 +1795,6 @@ static void gmc_v9_0_gart_disable(struct 
>> amdgpu_device *adev)
>>   {
>>       adev->gfxhub.funcs->gart_disable(adev);
>>       adev->mmhub.funcs->gart_disable(adev);
>> -    amdgpu_gart_table_vram_unpin(adev);
>>   }
>>
>>   static int gmc_v9_0_hw_fini(void *handle)
>> -- 
>> 2.32.0
>>
>
