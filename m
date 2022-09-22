Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C1AC6FA82
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 17:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FC3C10E074;
	Thu, 22 Sep 2022 17:43:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B7BD10E074
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 17:43:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtM62Li0iCCsf2k6vz3oCFeSBoYRoNp7SptkuyccEbP8I0ybBINCMxlBNokfbBq7YGEOxmPggqFCiQ3egBoW1YwZDLNmjfzjO7W5xV40NCqa2CqGumWt0Qpe1MVTBxwrzgmKRSuod/hPPP8DfQ8Cd6okYtKcTyqVFKbX2vwsl9rJmDURribTwf1MgNQOBspGhg9SOBEKB0Dbt0716g0CMdYJ9FpcU4zKWSroiZn6oNXqRBNAu0R859gvI7rbNtgDkdNiKq5wLVqTRyCZqcy7QbXsfKFBJPOlBkU1YNDa3FqXGB2yPkIyXeX18LS5G0QdMtVn1kyE8cNQmAa6PXQ+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/RZif8cNJaeJYyf+3HmvGKK6tDOCmH97rJOFfPwwks=;
 b=iDsxVTHjCasRPP1msyOcHfseq0qpAzQTJ8dWapGNO0Y7aCtlVJywbGvGpVQ/jxfJ8dCHJoVaj869wgi/yoi6Ey8qOuCSw87HYBURarwU1pD9iSsz+74V68/rrvI1q8iOG3DbOYYG1U48RUnhlziy9SJKmOc2DmsATtQ7vrqCm/XLeq8XGr9OPpjkh5tad4m9dDR/4DCwPiC7/RUk//VmqwUKSjwqicRnQGgxLDiwV/EHzWhLZbnPKY6MVK2ivBlAKFXA3YbPwg2kubdT14H+IITFWU2U63ZpWrqTAbtfZA5bOEs5qwc/WnWObmlxBk0A/MQV6stRH+6eS/A5r8fatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/RZif8cNJaeJYyf+3HmvGKK6tDOCmH97rJOFfPwwks=;
 b=h8hhHMZCCoIrR9ML/MJgZBal6H54qGCTt76WyFG51UFKdxtoVHcqtdfbGKBmzGqzl6WHJTOqz3lCnHqBZSwAdsVsDNwFb5RCdf4NEp3Qcx+feBDNo1sE5tO48A7q2+mlTFF1c1ij2rdmwersciLjb8kCeAJPIFRwSTzj4k5guSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY8PR12MB7098.namprd12.prod.outlook.com (2603:10b6:930:62::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 17:43:23 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 17:43:23 +0000
Message-ID: <3ff52740-9336-661b-e008-8ab755adedd1@amd.com>
Date: Thu, 22 Sep 2022 19:43:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] drm/amdgpu: Fix VRAM BO swap issue
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220922152627.265948-1-Arunpravin.PaneerSelvam@amd.com>
 <807a60e1-7624-b824-dddc-31d532113b34@amd.com>
In-Reply-To: <807a60e1-7624-b824-dddc-31d532113b34@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::22) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CY8PR12MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 83182787-6778-4b4b-dfd1-08da9cc1f267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7xvoTnLSJ7K+kHaDMO2jYMvZ4WHLDdDV4pYlIikn7GS/LD7KfXk8Uic8OQp1CmCJv38XB/FeQLnmpveD7tdFDUheTEk0oTskj3c+laSeImGziwqlVwk/LJL3bMPbKP1QmFeaQy9BVDzUDgGRpSANkX6YN67p3i0w+2K4AsxSgOduHai/bH6JRxdFR/Z3hy/eZkln+QlYvEFMMCZqf2KT9pesuTYIqsIs10rWf8Ze4e+ChoMVgZA2C3E2A0Id8eUAJGTn1d6Eh0Oyc6f8qpm3hBx8pZcX7KXFC8eNopwn4R6cYc+d+tO+BVaRklp5k3nVxclvzUKbRD8tO2mFma6bvrsgLo4dprmBOgmXZQotngjYzgG8SAShFQeiD+cSq63DDTY1e7bO7BI3ZL8NH6/zDtS5H67RxljV2OdKHF+NSYQCHSICurT85uUno05SXERSDrmSgPuUV2InTDO9tJESVRBui2R6UlsxritvBFF7lns07L12XS7s4Vt/n1My86LCDrwMkDmcJQVh1iHtESp78vAijPjRh6AoyoVTNE7D6NTotU2WIrNAx90KnSl3KGLuu/vF4QqJ25aunYOFebPQH/k47e80cjpiSL+E53VglJqi8zkHYOWnKPQ2z2fyI7b7T7VXbzbHSgOPmzEfuwDFVca3WYH5P5E4lP9hQNu/VxIyVdPexm7WHOCLIGz9Rv+B3iDclxCJfAfhlk/gPOlHz0yPbpQxWyIVPvqkCvZOC13MMLVIAP4LIAleA7G7/8FHXlTqpsoN8Hsymfiwjypo+9YkJB7XopUURbs3QJdDyc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199015)(31686004)(83380400001)(36756003)(38100700002)(31696002)(86362001)(4326008)(2906002)(8676002)(66476007)(66556008)(6666004)(41300700001)(66946007)(478600001)(6486002)(6506007)(66574015)(8936002)(5660300002)(6512007)(186003)(316002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWFXcEh0SG80cXVXM2h6dWxIWUgvR2pIejIxbHFLZk83dFpXMHRHams5ejVM?=
 =?utf-8?B?d2sxZ3UrN1BaRjhwN3VUQkNzMy8yRUlHRHhEUm11UjhsUmh1UzRNRzY0cUlv?=
 =?utf-8?B?bnR5cTd3Tm1sMVk0TU04Vzl2K1ZyVGY0Q2hkOG9OWTc5WElvQVIva0J1MlpE?=
 =?utf-8?B?aUF5SnlYUmR0Q2hsZDBSTmlITGMwTXhJZWpsdVdQZncxUE5tV01VRXNSOTZu?=
 =?utf-8?B?SlNCbDdPY1hxUDFZc2dtN2RDMkxoZW1nSU12cElRL3Y2eXBCWHVPRkJEUlhu?=
 =?utf-8?B?ZjVoaDI3YnlpUGl4U3dvTG5YOGszZzVtd0VUakcwZ1RCL0hXWFVEekF3ZTk2?=
 =?utf-8?B?dzdIaDB5dFNiZ1VhMTJjYWF4WkY3UldLczJ4MlR1R2VGeStmMy9LYUw3dnph?=
 =?utf-8?B?SENxZmdVbytabFlvOCs2cjhaQ1hmQVRGNXVzb1dRdkF1K0prWi9GYkNIakNv?=
 =?utf-8?B?K0RDVGxrZTcvekFFbENwSU9GcW1Ia2NTYndSay9KQ2V4V0lTWXNxdTlGRGd3?=
 =?utf-8?B?eXBWVGlCTjBFVld2OTRibjBWZmljdDFsSEh2UE00VXZvWE53dXh4SWlaSjFj?=
 =?utf-8?B?YTR4SHhwcnNycFJFTjE2R1ZUYzVIempmVmpJWjR1UVVINzhvYjZkU21RY0dF?=
 =?utf-8?B?bW04MEJrYVdSK1BnVHVjSElRUGNxYXE5UGRlbjh0c2doV1dXSDAwcTFMM1Y2?=
 =?utf-8?B?aSsvQ2U5ZFdyWnBKeXdiUWxMSHlyNEZGM0pXMU8zaUIwdHYxL3VWa1ZRTnBV?=
 =?utf-8?B?ZzZmdDU0aWlFMHEvRWppZzFkQ2xna0E1VGFvOXRFeEZWVXZUMnFQL25kU251?=
 =?utf-8?B?OWRCNlV4T1huTzdpZEhKUGc4N2FUS0NlMW5qdU91T2NaU3c0WEtNMVNHVEFW?=
 =?utf-8?B?RWc3blo5UmoycXZ0MHNONnpQdm1rbWxQUEk5cm9GQ21RMkZ5ZkQ2eXR0eE1k?=
 =?utf-8?B?ZXlteWpJeTRlMXRQeEN0L1dySFZTS3ArMUxZa0xVTkE3Y08xWGNWRmpRQnNF?=
 =?utf-8?B?MmxFazFYbFZ0S1U3REkyVUhKNzRxZFhuUFBUeW9mY3NlSm1MazBNbmgxSkhv?=
 =?utf-8?B?K3pYbTZWN2NiMG1UcUhGYlJ0dEx5OWgrb2JzQ2p5cDRXcmNSL1FjNVFDbXVl?=
 =?utf-8?B?STFIZ2liWGQ0UEdJR1hrZ1F6SHNzYjBvQ1FsZFFwcS9aMzdTcmRKN2VBRUJ5?=
 =?utf-8?B?eHBLVTRSOGUxaXhScDFocVVzdFAxaDVLOENsYXlzVUlUL1h2SWJMMzh6Rmlk?=
 =?utf-8?B?MWtRQ1E3ZkFYVGUvOWZ6UGJYcDlLcklaYStnbG9GZ0k5b2huS1h3dXU4TXNx?=
 =?utf-8?B?YlFIb0NIdWMyS1M5cEJYMStoaW9EV3dNdUZIMHl6cnFuVU5kMk45TTdDNVVy?=
 =?utf-8?B?a0JIRWhrN1B3UW5pMG1rYm5BbjZjQkRNZmNLWjZuRktOdHIvZUZJNXVac3cr?=
 =?utf-8?B?Mm5HYXpzMURielFzaDJXaFVwUHFsVG9GUUNPUmJrMjBrTnJNVHE0bkR2UXA1?=
 =?utf-8?B?dHh3aTlPM1k1b3ZweFd4aDAzd3FRSnlycmFIOGZqOU8rbDI2dFRWdFRNQ21m?=
 =?utf-8?B?YThQdFlhWDlZek5KUDZ1TFhPYnduR3Z6b2J4bVpRMmhBYXZSUk5iOFNBbTBW?=
 =?utf-8?B?bU9BOW1WaWp4eTVrbnU4a05XZ0VsckVnY1U3MnN0WklMdk53VWhpcnQ3c3RL?=
 =?utf-8?B?S3dWRFdaYWdmSUJXTi81UDhCZVVTVHZwelpGbE5BKzcrNjgxd1hTaHA2VzlS?=
 =?utf-8?B?NzJpbDNpcVBkZ3dnQlFUUkZEbVVMU3dabEJjUDdRcHByNjFnWXh1dEVuMDZv?=
 =?utf-8?B?aXNoK3MzdWY3RnhmMHByWGFic0NWcXZOSzJWdGJJbytxLzN6SVVnSldQMWtt?=
 =?utf-8?B?QTRmOTBYeFJ6VzhBaUJrM1dSSWNPcE9GaUtPOTd1eG1GUTAzRHMxTmlNdEVX?=
 =?utf-8?B?ODczbXlMY0Z3WFRJTlBETWhQZWdXRnBVS1dMTEdZV1BrYzFGelJqbm85R3lD?=
 =?utf-8?B?N2ZvbjJsZ3liQkhnYm1UY2s2by9CQWFvMnlsbURyZ3JrWHBvVllKeFN6TFZR?=
 =?utf-8?B?TzdFTEJIeUVnUFZNWFVMVlJxSE5Zc1laOGkrVGdEejB1SU9wRVZ2SlMwRW1r?=
 =?utf-8?B?RW5DVmNwTjNnNVIzOXZoVkZKdDhQZldQb1lib3dOUFhlWW5NZ2Jya1dSL3NW?=
 =?utf-8?Q?GmnxV8KCKLh3ObUTYakdR24tAAP3f19HO9hotu3QE0E0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83182787-6778-4b4b-dfd1-08da9cc1f267
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:43:23.7111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILkzwYIndeubC6SWu/GCsudpYgM1k0azDxjOmEqICcGOOAVYF7dIRJD1I/ct1NWH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7098
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
Cc: alexander.deucher@amd.com, Jun.Ma2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 22.09.22 um 19:14 schrieb Christian König:
>
>
> Am 22.09.22 um 17:26 schrieb Arunpravin Paneer Selvam:
>> DRM buddy manager allocates the contiguous memory requests in
>> a single block or multiple blocks. So for the ttm move operation
>> (incase of low vram memory) we should consider all the blocks to
>> compute the total memory size which compared with the struct
>> ttm_resource num_pages in order to verify that the blocks are
>> contiguous for the eviction process.
>>
>> v2: Added a Fixes tag
>>
>> Fixes: c9cad937c0c5 ("drm/amdgpu: add drm buddy support to amdgpu")
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 ++++++++++++++++++--
>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index b1c455329023..b1223c8e30c9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -426,6 +426,7 @@ static bool amdgpu_mem_visible(struct 
>> amdgpu_device *adev,
>>   {
>>       uint64_t mem_size = (u64)mem->num_pages << PAGE_SHIFT;
>>       struct amdgpu_res_cursor cursor;
>> +    u64 start, size, total_size = 0;
>>         if (mem->mem_type == TTM_PL_SYSTEM ||
>>           mem->mem_type == TTM_PL_TT)
>> @@ -435,8 +436,23 @@ static bool amdgpu_mem_visible(struct 
>> amdgpu_device *adev,
>>         amdgpu_res_first(mem, 0, mem_size, &cursor);
>>   -    /* ttm_resource_ioremap only supports contiguous memory */
>> -    if (cursor.size != mem_size)
>> +    do {
>> +        start = cursor.start;
>> +        size = cursor.size;
>> +
>> +        total_size += size;
>> +
>> +        amdgpu_res_next(&cursor, cursor.size);
>> +
>> +        if (!cursor.remaining)
>> +            break;
>> +
>> +        /* ttm_resource_ioremap only supports contiguous memory */
>> +        if (start + size != cursor.start)
>> +            return false;
>> +    } while (1);
>> +
>> +    if (total_size != mem_size)
>>           return false;
>
> I would completely drop this extra check.
>
>>       return cursor.start + cursor.size <= adev->gmc.visible_vram_size;
>
> Instead of this you should be able to do all of this in one go.
>
> Something like this here should work:
>
> amdgpu_res_first(...
> end = cursor.start + cursor.size;
> do (
>     amdgpu_res_next(....
>     if (end != cursor.start)
>         return false;
>     end = cursor.start + cursor.size;
> } while (cursor.remaining);

My fault, this should have been

while (cursor.remaining) {
...
}

Regards,
Christian.

>
> return end <= visible_vram_size;
>
> Saves a bit of extra calculations and variables.
>
> Regards,
> Christian.

