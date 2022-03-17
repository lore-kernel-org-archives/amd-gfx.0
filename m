Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA56C43219
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 12:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CCE910EBAA;
	Thu, 17 Mar 2022 12:55:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB5A10EBAA
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 12:55:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ir2iDoIfETDGGh7IDXFAhVIo8ETlQZNEHPx1uG2KZb9IPK1FBUr0i0+kF8BtHlIhdop1iTjXnQwwVbpJSe7LnAlHB7EA4kmUm5WHJ/OjklmmDpFez31F4wZJpW+rrxiKB0p1jY9T6Ie/YEjy8wXG8qLfePFXS8H/DaoE3XlbVLEz82FGHqL+AooP1F6l/+OKilgoKlrbEAW7NKOSGyK33PeN7xjSDHB3Lx5hVrHj/Pg9qMLxSKcmuIAUt4xzV040hyl3aocB596rxnmpEfAFa/vOHlog6Rn96BS1a5Q8mJCgwW4XwMNBRMujVR+ogHkFVuqhpcVtImdoDtTmXyCtBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVNi7955nqI0nmguD2S6vWd8JINA/3YaGzfK15hhrxo=;
 b=KikHAwVtXKm4U20/CyayzoUw7KiakbRYE0mVYT2sWOgjSds802j3c4/yFTCGQXBaL9J9QJawPgixpwDf/T/ew9GAfwZYq6qmcBhiy3Fmu7ci+q88YF7ys+Qo+LlKJWJ8cXIfqM1kj/Re4s5/aZIsGig6mQXiEU/KcZ5BMx8hVikuJvY2FjKukPaaVkv9pq+Uh3CuDnDMlKf2ZRq/mN9MjDK3RzT8mR7k1976NHLs5tmgmZWL/2SKrWSw2LlmtQsAkiAvEAYY+TAI+pW+oXp8RXhsJudzTIf0JWvVrTAfnmdcVkuI+hkJt5Z0tK4Ngw36c9zeYGmlMerC9R+IdiI+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVNi7955nqI0nmguD2S6vWd8JINA/3YaGzfK15hhrxo=;
 b=W4PIJzK3xvAS7/m6O5NBromvtWZTvSF8i6BB3zP/pyTYEXT+vbE/YPp/2VkZ+QaDAPP1P84wxqcssfKAm3yJ9UTZFArywfF85NmFl+WBd9sMT4Q0p4UwrS183HmBHz95Ozt8V2ibry8mD5rG2XGxVSCWRt0kxGA++d+VkKqOVqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 12:55:30 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5081.015; Thu, 17 Mar 2022
 12:55:30 +0000
Message-ID: <cec91f67-4881-dd11-7b11-512748f5803e@amd.com>
Date: Thu, 17 Mar 2022 13:55:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: move PDB bo release into a generic gmc
 function
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20220317112118.7411-1-guchun.chen@amd.com>
 <4b9f67aa-8cff-5e7d-7d01-a382dbfb5ae6@gmail.com>
 <DM5PR12MB24699CF6EC99DCE0BA4A5EB0F1129@DM5PR12MB2469.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM5PR12MB24699CF6EC99DCE0BA4A5EB0F1129@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0301CA0014.eurprd03.prod.outlook.com
 (2603:10a6:206:14::27) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb1b15d4-e6f6-489a-0d8b-08da08156a2c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5961:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB596138E57A6178A7D3F042C283129@DM4PR12MB5961.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NautEFIoEI2qpwrHrGMA0UBs+XxNkVSSuR2/QHj4D92AJedcs1qFbm8gJJjpESZHI4wAV8LmFk2aE55jRQGTCI8JRiRAHHTosh0ocmcyPOi/cwu+VxMOJBirUjZDA9CU3+UNzqJzbM4TQSDcfcdXvoq9IYLSU8+Fy9DPY2UhaWj3nVoZrxu4jxFMbmA22bsqdg7T5FxsB6gvBv1xduI3UQl4RVhvflbBdBQlliK5y/FWbZ5uX508DNw8oSrzfVTpOgbMF+htb+4UwvTC6PTWN6bON1G+DH2gSqBQaccRBnIMvp1VMei04M4WBXMTQ+w78DdWXLOsujCmbmp5ZjQcCiozUXw7WT2xiw1U4vg8p39VAt6NF5S1IXtS7bsx7F/0vgLOchCrE08AndVNdoEr1ctNVsMJdaGmP8NVzKZATWP1zx/CEE0gvx6okXA1NfqEYM94Z3GwnKmiD4gQiJZqHcNTQo9y1sp788OjydnMf7NOJwiwO0W5sXMK/LFTLMjEdWz6BsecobAw0Vkw46BX4xkIph0sx5jGNSY5no9V1yUIu1wNje+IdWOCCAm/7Lc4cS6BIa+9C8rg0HabjmO+3M5Cvp63q226AfiCOH6LcVhj3CNI3XZJ3gS32Ciwx7TyqFhXZJ+QMNXYeWYumolD/VqJzX1t3I0f1rDD2MKzD2/pdoPrwKGtHQDIlM7MKNvJ9XA5WFR5GqKl3o9mOkJmTMdQjHTPbrBmbt3+sc939DiyiY5/Co4R3rvvx4RxdtSoBfkay1PlgnRMUBTrrWz+k+ogZBiXEFoYi2u9nXNN7qQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(921005)(6636002)(36756003)(6486002)(316002)(6512007)(53546011)(110136005)(508600001)(31696002)(6666004)(6506007)(31686004)(8936002)(8676002)(66574015)(66946007)(86362001)(66476007)(66556008)(2616005)(186003)(26005)(5660300002)(2906002)(83380400001)(41533002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTBBSVRDcnVQWFJIblN5WVdMNStKWmZFa2dlUXhKMGFFYi9tcitpTlA4L2ZE?=
 =?utf-8?B?UmVFZjdIVHF4TGRRWVcwMVJxRkhqZlZJczVCcy9PNU90Vkx6N29SdHNrRGJK?=
 =?utf-8?B?WGQrbFNCUjVuaXpjbHhWa1hWQ28wOFFiVjJVaEFaNU5oSXI4eWsyUm9XT3hM?=
 =?utf-8?B?SzB2MG5jQlEvMko5TktuN0xpZnV4ZWpUYlY2dlMyQWZlVlNQWGJZdW5HazY1?=
 =?utf-8?B?UkNEanl5cXdLNllESEQ1czUrellhOGEyeFpFSjlrYWUxUlFBd3d2bTNYUnQ5?=
 =?utf-8?B?MzlNS0tXN3pRTzVWTlZTT2NNaWpLNVFRMzdWaENvd0V1NWVlekdyZjJ5OG5r?=
 =?utf-8?B?T2JzVTljR0lyT0tuVWc2d1J6SUppcXN1R09NQzI4TldtNlA4ZGxzSDB2UEcy?=
 =?utf-8?B?Y0JhUXhOMGFCZm5EdEZpVUhhZVU3T3p4VExXWUVya3FQQ1ZxSit4dGN6WVd3?=
 =?utf-8?B?K256UnVSclMwa3hGN1lDa01PSU95dmRVZFE4cjZUcGJ5ZUFRc3lEVk9jR1J0?=
 =?utf-8?B?eGNUaWxNVVRoQjlQc0FzcGRuNktLVzFsdmRUQ3l4d2VvZEZPNUVTNGVPQnpy?=
 =?utf-8?B?ZGkwejN1c0YySE41SktJRk1sTTRKTzYveUxkVnQrT1ZUYmQ5TmgyR2tlYito?=
 =?utf-8?B?OE1Zd0t1RkI1M1hkWXJRQlUvNnhMMkZLT0RPS21XRExjQVVpdTdETEpESEMz?=
 =?utf-8?B?VFV1NEdQeUVIT1ZJRXNRUjBaU3prS1J6ZEFkRE9EWFBGUFZqQkU5WTh6aUFX?=
 =?utf-8?B?V2NmZHlLZFJrajNZMHNmWnp2dytqalN4YUd6d0ZSSnQ1UGZ1aDM1eUFWMUxo?=
 =?utf-8?B?WVJhTit1VDVwRXVXWVJRbU00Y2VMZFAyTUpUenRWaE0zaUVJdTZyVldmYVRx?=
 =?utf-8?B?ZU8yVnRvYzZJdzR5N1NHVm5pemxPK0cvN3VycXF5UTE1U1pvc1c5Y1hKMmpr?=
 =?utf-8?B?UFFoZit6VStaaFNYRVhNcDNoZjBKemorZ0NzdnVyVzF5eHkyby9oUzFxbWVW?=
 =?utf-8?B?Sm0zMS9FVFY5c29UNWlZZ3ZtRkF6YVUzRE5QQkh6QU84VGlGL1JHdEdBYjBE?=
 =?utf-8?B?emlGRzcrL3M1bkp1K3FKT2VqdTJnMzNjVHpYYjZIZ3c3eGVacmJ2U2tUc3B3?=
 =?utf-8?B?MXBNRHBZaHZaRnhsWFoyeW5JOE5XS1RVOGdCNnE2UnJvZDdNdFVZNlNLNVdl?=
 =?utf-8?B?MVBWSURpcnNYbDkvTnRsTDQyUE5EUytuVGRqMW9PaTNZNE1aZXFUOHZFK3lz?=
 =?utf-8?B?Q3lYRTJIbTNZYWNmVkVXTFRqUlpvRUt2aTIwUnpicDRCYmxIdHBxMFdyZUN2?=
 =?utf-8?B?Z041ZjhRdmtHY0tHajRvYzhxTUlwdXJnSGxuUmFhNndmZHh5Tlp2VzFXZFVQ?=
 =?utf-8?B?RmtuSk5WTlRvbXFDQzA2L3RQWTNEZXFyeUkvL3ZDR2UwNHl6bXRSVEFVbUtw?=
 =?utf-8?B?V00yZUxXajdvVXNSYnBvVEg2SGVIeTRKa3pkS1RwcDNyZU1KN0l1OE02T0dL?=
 =?utf-8?B?QTlpTU9aMDFtYjlaQkduSjFQcE84RExuTjhUb3hSeXp5anJrdTZNL3R0YTVw?=
 =?utf-8?B?KzVOdWJ3STF3U0RsZ0kzRks1RGdDa0FNOTRuOEVBMmNTWlF1ZjBRSDl6dkc5?=
 =?utf-8?B?UVVYSElLWXRIK1VCVEpTUndTZmNDYVY4MmlsNWZodmFoK005Q1BtMVBGcTBo?=
 =?utf-8?B?V2JZM0tvaGdEbmVGakRySFlJMkVCWGxIMVNuNUZVeUUzY3ZlZlBlVVhQaTIr?=
 =?utf-8?B?RDV1WmFTbjgzNzY2YnhGM284YU85VHR2c3g1MVlrZVd0YUFxUUhtbjFRR2Rv?=
 =?utf-8?B?OWVnOUlEMmtiajNzcEdOYWhIRXY5M01RZG13czhwSStGbWdkWjVBNVRQQzd5?=
 =?utf-8?B?R2c2cGdzZkxQQU1qR2lYY09iRDE4Vk9VNlRuQWhYK21RdHg2TURWZXN5SWxU?=
 =?utf-8?Q?BonvCOuls+G0j07T6T2uQYt3DpPvlBb1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1b15d4-e6f6-489a-0d8b-08da08156a2c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 12:55:29.9641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KTB8j7QzArAHX6/JyldzzduGKR7U93wBN0xsQ2g+5SlncpTUxtKjzaqixMLx8KT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961
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

Mhm, actually that is indeed purely gmc 9 specific.

This is a workaround for a very specific hardware bug issue which will 
hopefully never happen again :)

We just implemented it in the common handler to be able to test it with 
gmc 8 before gmc 9 came out of production.

Do we have a generic amdgpu_gmc_sw_finit()? If yes I would put it there 
instead, if no we might want to create one.

Regards,
Christian.

Am 17.03.22 um 13:50 schrieb Chen, Guchun:
> Hi Christian,
>
> My intention is to use a paired generic gmc alloc/free function to proceed PDB bo. Current code is gmc v9 code calls amdgpu_gmc_pdb0_alloc to allocate PDB bo buffer, and release the bo directly in gmc_v9_0_sw_fini. I guess PDB bo is not a gmc v9 specific buffer, so it's better to use a release function from amdgpu_gem.c in fini. This may benefit the case that users do the same in GMC newer IP code.
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Thursday, March 17, 2022 8:14 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: move PDB bo release into a generic gmc function
>
> Am 17.03.22 um 12:21 schrieb Guchun Chen:
>> To pair with amdgpu_gmc_pdb0_alloc as a more generic handling in
>> amdgpu_gmc.c, no functional change.
>>
>> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 ++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 1 +
>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 2 +-
>>    3 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index 7021e8f390bd..36f6b321438f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -136,6 +136,12 @@ uint64_t amdgpu_gmc_pd_addr(struct amdgpu_bo *bo)
>>    	return pd_addr;
>>    }
>>    
>> +/* amdgpu_gmc_pdb0_free - free pdb0 vram */ void
>> +amdgpu_gmc_pdb0_free(struct amdgpu_device *adev) {
>> +	amdgpu_bo_free_kernel(&adev->gmc.pdb0_bo, NULL,
>> +&adev->gmc.ptr_pdb0); }
>> +
> Single line function usually doesn't look that useful to me.
>
> Why is that any improvement?
>
> Regards,
> Christian.
>
>>    /**
>>     * amdgpu_gmc_set_pte_pde - update the page tables using CPU
>>     *
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> index 032b0313f277..6f425e3a9b6e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> @@ -299,6 +299,7 @@ static inline uint64_t amdgpu_gmc_sign_extend(uint64_t addr)
>>    }
>>    
>>    int amdgpu_gmc_pdb0_alloc(struct amdgpu_device *adev);
>> +void amdgpu_gmc_pdb0_free(struct amdgpu_device *adev);
>>    void amdgpu_gmc_get_pde_for_bo(struct amdgpu_bo *bo, int level,
>>    			       uint64_t *addr, uint64_t *flags);
>>    int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 08ceabd6c853..ad600f72a51c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1721,7 +1721,7 @@ static int gmc_v9_0_sw_fini(void *handle)
>>    	amdgpu_gem_force_release(adev);
>>    	amdgpu_vm_manager_fini(adev);
>>    	amdgpu_gart_table_vram_free(adev);
>> -	amdgpu_bo_free_kernel(&adev->gmc.pdb0_bo, NULL, &adev->gmc.ptr_pdb0);
>> +	amdgpu_gmc_pdb0_free(adev);
>>    	amdgpu_bo_fini(adev);
>>    
>>    	return 0;

