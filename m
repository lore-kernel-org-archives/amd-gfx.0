Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8719FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 09:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E6760FE8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 09:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 42E6760FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF8C36E245;
	Wed, 20 Oct 2021 09:53:21 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4304E6E245
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 09:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEt/Cf76PknukCRPA24OtMCY8cSZybQOn+XycVZ7kX3vU6388NXaG7K4YgiUvN1Ci04z0Ples/HxFHPDE9qN/nb90nR1w+WuWnvdjdUYABGuc0KPVBxR0X2W6g+qX+fUtKai8kvxXfnRyrf7VwMa/ox59xBITRSOY0+ncW6WkHe2egs9mRYKVKsfLiPGlha4PNSFpAsdFyW6Xz8MjizQYE6LR0Z2qfXT0H8ngxVCk2Ofb6ieVVvC3hR20QVjcCvMs2L1qJ9c+UOOTu1jcdMGuTXXUGJ3436t71i9OWVkXD00FcvcsdvVCf3eaTACD14A1LVS3yNemYTerJkcvO0NuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOMroduJdyEAfTb6b9azr1iz4mlGKCkBeutYt2Oxg5o=;
 b=EQ991ILT5/wUIK5hRcMNWTxFwB5Z9y0sZJiPT1she15CIRv3tLoANPs54RpOG7cd+0TccHfbGQGn9/MVtA2WLYz24wmbjfT9wYQK61s81lR9kek+gxHNrJ94FwSZpn4cKIc+A5IjtepsBGrMOnGzD4WWPaUOsg7AlAeEPs48Q/oiHlH3CjSrLIruot3Zx3LM6t+nzzOsqeR7cF+XyWdepjVXHjxeJG3kocm8cJ3pPw5LIJYXZfqfcZxcKNS0c/MGcqQbis/VEx1RhOafQWi1YOH08lLPg8sekIL1aG/as3UvKlA0WUmsDLM0sZykorHbNhQfp2AhJH3eVdoicfyW3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOMroduJdyEAfTb6b9azr1iz4mlGKCkBeutYt2Oxg5o=;
 b=ujlWAjbUvdxz3Sjr4Q4XdR5+Bc5LbUfB53FXNj32Fer/nTaxlYM9XA4q6++tiMePBoalHsR4t3QICW6jX1cn+zzE3yM/ts2uLOwNyg9H5RYnfjJ/0cyi0mgpAbdfQ2GTPx3mHeh2OLakMHpQLgac4XXRlHeC/HVxGaKoijn+gxQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 09:53:13 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 09:53:13 +0000
Message-ID: <2715b2e9-4f7e-a356-fbdf-48006985a252@amd.com>
Date: Wed, 20 Oct 2021 11:53:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/3] drm/amdgpu: recover gart table at resume
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, andrey.grodzovsky@amd.com
References: <20211019181449.12356-1-nirmoy.das@amd.com>
 <20211019181449.12356-3-nirmoy.das@amd.com>
 <10ad459a-01c3-1fa0-837d-42dfe33129d2@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
In-Reply-To: <10ad459a-01c3-1fa0-837d-42dfe33129d2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR02CA0018.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::31) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.88] (217.86.117.49) by
 AM6PR02CA0018.eurprd02.prod.outlook.com (2603:10a6:20b:6e::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 09:53:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c905be95-2bcc-4080-ddf5-08d993af6e86
X-MS-TrafficTypeDiagnostic: DM4PR12MB5214:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB521469E3426EC94307E778858BBE9@DM4PR12MB5214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0N2MfrNu6V9XZ/EKyLubs64RhKxavgMFEQ1jd7UGfbFMXjEKeCc/qcdTIa9mzQVm2UjPCNTmqiJ9+STGvcTm+uSJJFFqfDUtDo2r5Qhcb/f1tOMcz6A2TlzJ2WUCOSEAviBQacMt2UcrGXJF/JbHJn+dQo3M+a+LNITohOfSA9lsay+dBTDPPUbLGLeu07FfTQltwcOYbLeA1mZHCuNsHG7lVOhEVgVtrEhyMVO9jlXYRRZZLNW09ankGq0TaCVyn8wTqKiIfANjMIbi6Ln5zrffWHLKanoolWD7kL5Gib6KV6LsINLgmspPWw5zfWvopy3Qlw/ZO3padXNjPv9ewn7S7UtVfaJo0LkB8pvhfuWtPxQxyz53GNdA9BtwteVz/iLUggzh3LARK17xK9lsamJwzkKgTjs34/Z91Mtakhq9D0YC4rfPQn/7FCZpicvXQfVvAbSKRcYqQHrhX75HBj6sIBqfz8W4UoGb8m4HGhNGOlVjU+FLChfeaCoXFVXHVhK1+pumuzREDsLQHn325dtyNns1ZAnB5H3zHEzzy2spXFIE1MVqZuzYNLWGEYLu9dEoTa4lupiZp5vvnbDiLzWHH4tur+vM4GruKSuHqcT66XuaQS8XwjkZy506ErzS8SDv4ZIsydPtiFZCMj8iUxGRAQeH74CE7P43tuoDh+GA6NKvEeFlQKXRpkj06rbg3wHBcYYjV8DDaUcrj0C291cRFyo2zKBL7Y1XymPJ4/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(956004)(508600001)(83380400001)(66556008)(66946007)(2616005)(8936002)(53546011)(5660300002)(16576012)(31696002)(316002)(86362001)(8676002)(31686004)(6666004)(36756003)(38100700002)(2906002)(4326008)(26005)(6486002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnRoaHR5bWthSEsvMHdienNDWFhFaGlNanVPcy9NSFo3aGZiU1VIWXVNQ0s0?=
 =?utf-8?B?dDFsVUUvRDBUSlY3Z2xmRVZkMmZxOUxGUW5YN3dlSm1VSjViYk9GOWYybHFx?=
 =?utf-8?B?T1Yrb0FmUW0zS2hhcGFkbEwxTGtiYW9yR0E1cGVkcXJEQ2M1TERiS0k1Y0xX?=
 =?utf-8?B?Ly9PRVpFOUJaNDNJdXYwb1htckl6bE44VFNIVjE0TU1kclRabG1tejNUSmVp?=
 =?utf-8?B?TitZSGtwSjhBVzhXTXJBWExpdXI4RE5sUnBXZlYvRkYrbHF0eE1uRUlleU92?=
 =?utf-8?B?ZThJV2VTZjVRZ3F6bERrVG0xNlBMNlVqUTdaSjlBZzBmWFcyNFBYTUVOMktH?=
 =?utf-8?B?a2NHcnRUTDMyU2NLaUpVMDZJRDRqRHhQTmtLanBKMjA2U1ZsNGlNNHBpeXpH?=
 =?utf-8?B?TDZCd3Q3NDRXQ2UzelMzR2N4MzBieHcrRDZQTGw4aDdvSkI1UXNSK25VYVJh?=
 =?utf-8?B?dDU0N3JnZGFSb0NsTDcyeXRXRTNtaEtnY2Zpa2JHRUsrcEtGM1Y2VDdLdW9a?=
 =?utf-8?B?MC9QUUF0bkdtYlEyVVNXYTI5Wk1BYjQyRW1qU1hCTit6dGtuVmpBNnlMQTJQ?=
 =?utf-8?B?YlNMK3lqWFpPR0dWQjg3Z25YbUk1WWdCSHcyZkwxZlBCN291eFY4Q2diajN2?=
 =?utf-8?B?RnJ4OE9Fb2daVFE1eGE2ck15Rk5HaWRtTmNYYjNEb1djNENBTEFrMEd3SmNl?=
 =?utf-8?B?aUt4QjVveUVBbDczNndQajdOdHhtWW9VZXZQWEkxRXErOXR6L25sbnJ6UTNj?=
 =?utf-8?B?TDBEcThtVVhRZkpWVWNrUjB6b2FleldreXl6WWh1ejZPRUw5UFQvZWFWMUZn?=
 =?utf-8?B?VmR5TEY5RkhyckUyOEtBVmVoWktCMkt4bHV0QjdQdHExTS81VWFQNW9lQTl2?=
 =?utf-8?B?Lzl3RXR2RjFBV2NKMFBwSkRoTUlCS1MxcHNGaXRGUUN1TThCUlZaREtYOEFz?=
 =?utf-8?B?UDZuekFmNzZqNTh4VTZzTmRKd1hxN2FkUStLUmtabjlDNTFXTkQrQlpDMlpP?=
 =?utf-8?B?V0IzdUFYZ2xxenRVaFR3NTl1M1hpZS9kT3Q4NERHdGFrUU1xOGdhRW1tUG9S?=
 =?utf-8?B?VE1xRXZqZy9Qekswd1FuTm1IdkJFVXFPWEJFbCtIbzJ2V2NMMWswek9DbHZ0?=
 =?utf-8?B?K2RpelE4bHBOd1Y2YWE1cVVBdndxZVBFdWNlRXNrSnJ4UUJMNXdtRUFyb0lk?=
 =?utf-8?B?eTlRUDh1ZVVtMnN3ZkRtVTd5dlBSa3hTUVV5S1dZaStPV3ZrM3hJYUZvSUZG?=
 =?utf-8?B?bEJuWG9OalFpanJKMlNGNDlGdFNqb0RVcmNBRlpJaTVqcGhRWWtjSVgyUVNV?=
 =?utf-8?B?TGt0U29Yb1JoZm9OSW55ODVKV2ZQbUdkS2FhQ1NoMFc5UHIwY1NGazhSUk1m?=
 =?utf-8?B?eFpsSWIzbnNkd2ZEdVNoOHhMU2NXemMrUDhuUXkrV3E0Vyt6d2s1SDFJU2pu?=
 =?utf-8?B?Y3dNcGtabXFDYXB2OS9JcVdRR0xyN0F0QXpMelJYUHozVGUzMERvVWZubUlF?=
 =?utf-8?B?ZG1GOWwzazV5bWo5bVBUVk1iTGtmUkpySzNmZzRPWUE2VjgzdlVlOGcvM1N6?=
 =?utf-8?B?QlBHd0I5bkdSNDZiMTZaZ3JhSkxRZ3RZSkY1WjVmNnRaNDdvTU9aRGdhVWJX?=
 =?utf-8?B?UnVaQk5Ub0xraVIzRkxMNnQ5ZnNOOCtjUnVMa3A2b2pIOTdvVDhWd1lpb1la?=
 =?utf-8?B?SUtid0thM2J5OUdmOGZienNlRnBKd3JnQnFGYjBmZVVPQ0Z1dUJ6UTFFaVcx?=
 =?utf-8?Q?00+twofDJhwqM2jmcigKN/Jms+m+GfMZHEFXAHB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c905be95-2bcc-4080-ddf5-08d993af6e86
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 09:53:13.5256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wydmo0n2ECF1seesT3sidF9zWE9CqMRnicBT/i69rZPg5GKhURZ/b9sBRTa6q8AUSrAwYiMSUYHNgoj0q/qKtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
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


On 10/20/2021 11:11 AM, Lazar, Lijo wrote:
>
>
> On 10/19/2021 11:44 PM, Nirmoy Das wrote:
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
>
> When the existing usage of this function is checked, this is called 
> during reset recovery after ip resume phase1. Can't the same thing be 
> done in ip_resume() to place this after phase1 resume instead of 
> repeating in every IP version?


Placing amdgpu_gtt_mgr_recover() after phase1 generally works but  
gmc_v10_0_gart_enable() seems to be correct  place  to do this

gart specific work.


Regards,

Nirmoy



>
> Thanks,
> Lijo
>
>> +        if (r)
>> +            return r;
>> +    }
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
