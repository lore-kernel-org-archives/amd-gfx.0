Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4047C07E9D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 15:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3644810E6CD;
	Mon, 26 Sep 2022 15:05:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 619A810E6CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 15:05:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9TGaZmXamjNRN5aBrnknvEvmVDXz0uOtEoRC7WEfJEqPgC4GYlTvi23P8IoxFFg36QIrE8Z8aHichYaFezBXR9TlUzs8NrLFO+DfegY0GT4lLnyzaQ1JEhQpIT+E6q0GbiT3TSiKjCFR9YgwUlMzvJxyPwKcYrzHJ7X1FLZV1bbXe82CZtmc2DzVrGLtK+hdzs72mc2cXtDV+wkNb1EAJLNJhhvPYjsy5i9zbncu68GHtW4EYYRioG+PABKYo3yFVcY2TZFIxKI0QwLZ/+R2nT/Q5ZLVrWuZdEkVIF37mt2v7sq8jIMLbj13SIxt8WGyvK2qJOtNgdP/01LHx9z9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKDb9ZjXRQUfrGq0kl+5NewKzfXVYvqjNoKVsjIsPlI=;
 b=ktzRrvaRqwO4K2HAqo2x9KhTXB6RWQT7XEys/TlmIl7udKMkzGEOh7pxq2Rg8snsy1u5ORAMKYnwSyNbFY4jW5grejkgYiGFB+5Q63ti+t5CA32uZGXftDW9xMiCad58YlotLq6KOzdM4wtYqchFflpjex7O4sCqahD4Bh86dUxhuzkQAXpPc3t1LJAqiexxkD+TI8EATL1/mkHy+pEQFrhadADTg1708jQME3+QYMpiiaEuYs6oH2UlraZR872CZuaRS8PopUtlSOoJ5hzE011k+T/rRTAY916l9RArwBpgQbKpVl3KWGqnhEiSNuoPtgBhe84A3hSpqGpyrEZT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKDb9ZjXRQUfrGq0kl+5NewKzfXVYvqjNoKVsjIsPlI=;
 b=D8+7Q45GZDeJYG8lwOzS9iS42GJQDZC4W4EVkv1SNFT7DS6YmNs9XP53HgN2ZBAxIV4hP6YoWerVdkAM+a4KOqRqtc4V40Rdm5bNbvlfzas1i0+//kOvpbrMewL75RqHXWErKFPA4foIkoTP8/vfrEImKKCUXzcXj/ViH5GVD+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by BL1PR12MB5190.namprd12.prod.outlook.com (2603:10b6:208:31c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 15:05:02 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::597:967e:d8b8:8fb9]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::597:967e:d8b8:8fb9%3]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 15:05:02 +0000
Message-ID: <eaefa0bf-f7c4-675c-72a0-377e681ce281@amd.com>
Date: Mon, 26 Sep 2022 20:34:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3] drm/amdgpu: Fix VRAM BO swap issue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220926052529.2586-1-Arunpravin.PaneerSelvam@amd.com>
 <799e07a5-435a-6608-bd54-6b48d6af85fa@gmail.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <799e07a5-435a-6608-bd54-6b48d6af85fa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::11) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|BL1PR12MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: aedf5901-e840-4009-6b53-08da9fd07c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12vXGYDAubjNo3RC8u780l5n587KQ2fDxYcDMhLvXELcqnGHha/xpsRknA46ayWksCA4skwNvn/65bWGiBwVkU2hCO0P7E36YZi0lKv7taGcoMdBxWARBUXri64iqZdGp65IUb0TVX4u/Vv/jz1+gDp4YByxG41yY5jlbSW8YSr5ilK8lgMXwAcVJ/HKeZVkF2L74OTKGt9DKwejXQq4touxa0KPiUxKFrxuYo9soKw3z9B9GI9mivPfOUy0P12UPIXtKXRIoni2Ln4LNzFOp8LI4Gkscg/K+TDM/0m+jo4JHAt7kaPJTj5u6q6yoE16fgwvO4FyhzXcurREmVj9x/C8MP/tb8ziHLcZXKZtiJKqX4OQqDRMwwV+12MF5J5s6JP73Nvsv10o/NZixortSMDK6WGDkdWeqQoPdHe9kk7Qi1S3mAqehPUmlN1UfADgT5NUhi4dbBSJ/ectSX5w9aPpfZojk8Z2oslpOUD6d9q5UcP5jQkNlEZFIrEqHrilM/bHE59aWAc7NzEEjxkvru1NRQWYtl8YFJhBcEYFvR+kRlm63W+yJv9PgyFM0CVLJywoV6DIL1N2EET5wTUsbGVFVjI2kUqVryKTD8t7BticqEEkyjy6tSRd42pdI2qBC+L2XZRbhlcxWm8qYV/GnJgaLD0XL00acFzv1fbOHQxbZKnwzdAWTx9utyo6A9a+UkrKeVwlk1cp0H5yzdTvFy8KYZ5BOGKifKlYskfFZ+VU4Cq9rhMu3+xqBlZD14F+7XMu/nia89Z9n8h8AjOnqmAhMWGCqP74tCf2AM6qRBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199015)(26005)(6512007)(5660300002)(6506007)(8936002)(53546011)(6666004)(83380400001)(41300700001)(186003)(36756003)(2616005)(38100700002)(2906002)(66574015)(31686004)(31696002)(86362001)(66946007)(4326008)(8676002)(6486002)(316002)(66556008)(478600001)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3hCVTI5Sk0vUzBZNWZLSjdXT2hpWXF5cE9OVm1SMUdTeFZtVk9XUk14K0NE?=
 =?utf-8?B?N21tL1UwSFNZQ1A5WVJTSmtCNVh0UFY2QTdPMzFpSTlvWnRCdWNDOGdIS3JY?=
 =?utf-8?B?emxhRFBzQ3IzS0hjck9pd1U5K3hoNE1BYktrZlNhWHZ6NHp5K05kSDdXOUFH?=
 =?utf-8?B?UUxHeVVCYkxyUWFTWG9IWXR1SmxaMnRiTkVqOU94UzI2aEY1aWlGT09OMkhT?=
 =?utf-8?B?NGh4d2NPd0kvVTJUVWd6UmFwUHVhWldhblZKZlBKZSsydVI3d0RLWjZKMmdW?=
 =?utf-8?B?bkRnWG1DM3ZiMG5Sa0ZXbWo2amtYc0hTcEFUYVF3Rzh0RUVzMjg2QWZhOEVT?=
 =?utf-8?B?bDIrdWFnQTBiaFNidmlSWkZhR3RzS0crNm9STXo2QVRSYzBJeERwNEZ2RmY0?=
 =?utf-8?B?aTlSNDgxWUFqeGZvZUxoSnBJTEE3NmhrRnJWZTQyOHFoQUExcmtOVWRyNU5h?=
 =?utf-8?B?WXFjRDNyM3hpQ25VanQvTkRzdjBNTE1oSmIvV04xSm5aTE96MC9FV2FHZ3FL?=
 =?utf-8?B?U2pKM3dvWXZqRnhVSnVJNmhKNHpLZVJoMlJpY3hSeUFCSm03ZXUrQXFoVG1j?=
 =?utf-8?B?d0R2K1BQR1QxalVGaVcveGpIc1dPK1A5ckNQQ3NUMWlnVFZubGlNanIwTkla?=
 =?utf-8?B?LzM0T2VnMUFhUS9CaWdQZUw2Q29JdmZIRnRIN2lqQ3dpbGtxSGlCK2NWTjRq?=
 =?utf-8?B?cjVhZmlGZjdxZjVEdWVMbEFWTTc5TFpHR21hcUd1MGVNcjdDYjRuTE14SkE3?=
 =?utf-8?B?SFJ5eFJWdy9DV1RPWTFYYk1CUFdVaXAvenhqdVoxKy8xNmE0TWVCT0o3Vmoz?=
 =?utf-8?B?UjBtRzA4RDZub251ajY0UStIZFl0QU1qMDcrMDBrRWdDTEtzL2FQaDZMTDFR?=
 =?utf-8?B?NU9Hd216ejZ0WSs3T28vam51OEVrNElHN1JmSjg0U2FZeVBYY1RDVUpwKzNu?=
 =?utf-8?B?YlhuaXJaZHhZTm9xWkM3SDl6dzZ4bW1yc3lCMmtrMW5SaXBGdEU5eUZQNnZm?=
 =?utf-8?B?S0VHMjRmVS9yYVBrdkM2b0poNTE4aC82M1MwaFdwcEI3cDZSendjYUk0RjA4?=
 =?utf-8?B?VXErVXdGM3RpWkkxWXhxQVduSmVoWjRqdC9yS2svZlhkdkRvVWk3NHU0TXdZ?=
 =?utf-8?B?c0xISGVNNFJndG8yWlNZeXl0Q2RDYUhEZktBQzJhTThIM3VVKyszeG9YNWVZ?=
 =?utf-8?B?UmZ6Zi9rMU9BbEsrT3RsVE9uOVRnengvVjIyQkRLK28wR2RMeWxncVhIN1Fk?=
 =?utf-8?B?NnhiNjhvVW9abjRrVnNIKzBkeFhHQ29LU3dJaitMUUdXV2VCVFNzZDFrazUz?=
 =?utf-8?B?cGdVYlNNMTJmWTdiNkJuNnpNaWI3THdMdXY5TXljWThNOTBuQ2tJclp3bSt6?=
 =?utf-8?B?TmtrNk9BZHlYMnRxcmpDN1VKbTBuVXM2RFhoTVkyN1UwUE8wU0hwMUFsakZZ?=
 =?utf-8?B?UUM2c2VoaFFTWWZzMUxjVWFGZFFkU0tRYW9kM2YxcWFzRWVJZms3MVBKRGxr?=
 =?utf-8?B?RGxLUUFjNWF0akFDMzFkSkEvYlhCSnkxejdDOUprRW15UEdkR2pLSGZ6NUdB?=
 =?utf-8?B?bVJsS05pTGFPcFo2VVNxdVI0TkcwRU5teDNHYkhsM3c5em9JeHpORUYyS2hX?=
 =?utf-8?B?THBHYjRsc25wMzVJc05ocVpCRXFFK2JJalJGQXZSNVc3MDlxKzY4V1c5TGhW?=
 =?utf-8?B?UmUzS01IYzA5bVZGbDFEOWE0NFcrME1XVzdldXlKODV3d0FPd3QyTmdjeE96?=
 =?utf-8?B?MXcyNWwzL1ZGOHV3THUwR1dCelZ5YjhkNVNWTFdPVDBML3VEajhjcnJyYXIy?=
 =?utf-8?B?VnhTZUhZaFF4M1FHKzBQMjZkMURQV3ZJa1BMak5LYWhsWTJrTGlGbzdibDVR?=
 =?utf-8?B?UnBiR0dhVU9YZmlHejhaRno5ZHhnTGpmbG1HbFprOU4wMklreUVsK0E5SWZI?=
 =?utf-8?B?NEs3R0ZPcXVnYUEyOXNFR0pTaG1PN0Y2ZHlFRUVvcjBONFN6M2NWTXpZbWZV?=
 =?utf-8?B?S2pwNlJhVW9oZkNKMXhtRkN1czVRWUpuU3hHaUc3MnNJSDh4bnd2VWYzVmUz?=
 =?utf-8?B?d0prekxTUi9WTFovUUk2S3pIR0R5TU1xRFp3NkYzYTQycCszd2gyZXFNVTJJ?=
 =?utf-8?Q?EZdQfmTf9p5Wyv3N7nnJBxquc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aedf5901-e840-4009-6b53-08da9fd07c70
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 15:05:02.0633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHPIOVe6RZdfqu5nJB6QwuCa0JE/cJvWhmZQJFG0OwEqT/2UPkX3asbYMDnboov+Dk2mw2Zd2c0SmWkFAz8JXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190
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
Cc: alexander.deucher@amd.com, Jun.Ma2@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/26/2022 12:01 PM, Christian König wrote:
> Am 26.09.22 um 07:25 schrieb Arunpravin Paneer Selvam:
>> DRM buddy manager allocates the contiguous memory requests in
>> a single block or multiple blocks. So for the ttm move operation
>> (incase of low vram memory) we should consider all the blocks to
>> compute the total memory size which compared with the struct
>> ttm_resource num_pages in order to verify that the blocks are
>> contiguous for the eviction process.
>>
>> v2: Added a Fixes tag
>> v3: Rewrite the code to save a bit of calculations and
>>      variables (Christian)
>>
>> Fixes: c9cad937c0c5 ("drm/amdgpu: add drm buddy support to amdgpu")
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>
> Reviewed-by: Christian König <christian.koenig@amd.com>

Shall I push this patch into amd-staging-drm-next?

Thanks,
Arun.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 17 ++++++++++++-----
>>   1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index b1c455329023..dc262d2c2925 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -424,8 +424,9 @@ static int amdgpu_move_blit(struct 
>> ttm_buffer_object *bo,
>>   static bool amdgpu_mem_visible(struct amdgpu_device *adev,
>>                      struct ttm_resource *mem)
>>   {
>> -    uint64_t mem_size = (u64)mem->num_pages << PAGE_SHIFT;
>> +    u64 mem_size = (u64)mem->num_pages << PAGE_SHIFT;
>>       struct amdgpu_res_cursor cursor;
>> +    u64 end;
>>         if (mem->mem_type == TTM_PL_SYSTEM ||
>>           mem->mem_type == TTM_PL_TT)
>> @@ -434,12 +435,18 @@ static bool amdgpu_mem_visible(struct 
>> amdgpu_device *adev,
>>           return false;
>>         amdgpu_res_first(mem, 0, mem_size, &cursor);
>> +    end = cursor.start + cursor.size;
>> +    while (cursor.remaining) {
>> +        amdgpu_res_next(&cursor, cursor.size);
>>   -    /* ttm_resource_ioremap only supports contiguous memory */
>> -    if (cursor.size != mem_size)
>> -        return false;
>> +        /* ttm_resource_ioremap only supports contiguous memory */
>> +        if (end != cursor.start)
>> +            return false;
>> +
>> +        end = cursor.start + cursor.size;
>> +    }
>>   -    return cursor.start + cursor.size <= adev->gmc.visible_vram_size;
>> +    return end <= adev->gmc.visible_vram_size;
>>   }
>>     /*
>

