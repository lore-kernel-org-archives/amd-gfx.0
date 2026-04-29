Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23792FF8867
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 14:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A6710F03A;
	Wed, 29 Apr 2026 14:08:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VOlLI7z5";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010048.outbound.protection.outlook.com
 [52.101.193.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCC1D10F03A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 14:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJpPfYeKVQskwPqMRlnxIJZKfy+zYHUd+Bn2YO9vMGy6dez6h/g86UwtLukAUTUGkYBMnKeObpwMvv1zvHDtXPMj6f78TVtnFULbkX2hwkYUj8CTSl91abEZT27aSdu2aaLHyA5dqGAQvbFwO0/PzfbKLWic8QTKonVfN82xtH/9tQfTGiahoQHdFJjrA8xhBMm3ePyssNiV0xuGhSJnH7Ka2QLznyuR13BrdPVSbFRoPgA+laRWIDFL4gPoFNLd8KmF6M6vPE6T9UhzrPwdB4w1vxx2jNwmFUL0a5f2agYo/mS88x0WYg2DX1t6OFNbjwgtVe3VpopNJ0Yg3saDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVGzvfJI55nnUEYeegXJzHzM84yhwzCjXCUbIj92y8I=;
 b=H5LAulAMuRGJFy8D8tCv7mSqY+FhMiCtHm3vXRcWegmhS9MfTclyyDpjmu4YmLCl/JNALuNooucb2QyBkPDxijosiXbQRyrM+ve2kUIAQXlzRTGndn8wD+EAawR+Vjz9wjrGnAO/KKuLN1D1bw7TOaYJ+h0WvF7SfwP5LVHNzuJVb8Egsf5XSA2vUgLGFjuGM8OKk5joOu6XeLvKiGsDNfO6ONNuX6U8tvv1IGx+604FVruBZQkbDmZwbCaq6V60esJ0+hnaZkoixawROlJSvpKAOhU+u5JHN8gO1IUUd6/24xzcz96yvp1WvuZfHkdOxG4Oyfx6huUEdUVSUsiLmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVGzvfJI55nnUEYeegXJzHzM84yhwzCjXCUbIj92y8I=;
 b=VOlLI7z5YS+4ZT3SNdyr/4iOKgu8a6ZmijaKd2TwkFy4ZAUFzPGM1KADP1eHrOy0924kBJ4cmqaMeOVjqAnFntV1vfBQnB5Y2jvegp7Zj4k8JL57TsukN1K2UapvChnGekarkZP+xPLEWEcV9zKkOZcezxxj/7N7tka2JeN/bCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 14:08:36 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 14:08:36 +0000
Message-ID: <a27bede0-8d7a-4b59-927f-c1f43a61a753@amd.com>
Date: Wed, 29 Apr 2026 19:38:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Adjust GMCv10/11/12 gart size
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com,
 candice.li@amd.com
References: <20260429123745.3930780-1-lijo.lazar@amd.com>
 <25f247d0-8484-40f6-b751-1b5f259cfa71@amd.com>
 <055c7635-425f-443e-afc0-40c3e0eaee1f@amd.com>
 <89fbce96-8594-4847-8032-cdd6f17fdbec@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <89fbce96-8594-4847-8032-cdd6f17fdbec@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ddccf9d-4436-442b-e807-08dea5f8cde5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: qwUxLA11BNoIEv57Hmlpj04v18EBgkONX7bO91MJOeim5rKVcJImZRSkCLw7xyxVxmNEUo4O++4Ckto8YiBjtUOZ+bMe3OaJRBnIBzG0gVfdpNXD0nxVCOfjbyUoi1f6nv7clj72047I0zK9xmXyrHcF8jlHGjVDSl4ifp8ZTO1ztJe13QwlWL3Z6oQiLrUC6E9auM+dFiix4HpdTFC8zgLCz+29B/UCkHS5bofvx4r8tTBIHxKGxrHqiD88APOlWfAEeJCts9PFIONOxVeUZ8cUwOypl/BUq0H0E/GYL5HYbNU8teJkSA/yAh1Z3++ifofXGp87Ce1wnfFLKquhBRicS6wAwBiU9BzlsO/V8BESak691JjFSPV0LhfbJfRjwj5zu5cNhReEYD6p/rIDSmBxAOXj4YGyAjNPpkwk+WUn1B94HjwoPL00kxhkFMKrzNQ4McZDnWZ7d42awoKR2mj5Xf6Px/I4XkSgxrT0jPHdxx5b2zL+ucLJWBAkUmLsD+PN5rkywSa/zJRUUNo8c0Got2wO/9aac88sq/lrKjVehbw84uodZ55VXxb/w3l/aJCgBNGM9LCptSYKnHccT5qXDbWJEqkUPC2mMh17AfeypJIv3FmjYSLXEZ746LqKQhERqnVYpJrZiAU2MMQ4jtzYbsCRRmlOLt5PGQpjwguGG+k3i5BNf0o2CxktHzmE4VoilmehlWpInvTTmBUQJtPVtHxAxObv2EEO8k5lfns=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWZBTUdob3ZXY2J6a2dqZWRybXc3MmpNVVI5NVlHTmtGRHVJcHE3OEtHVnZW?=
 =?utf-8?B?T1ZpbXFIZGR0dG02OGxpYWptbHRJQVVLTG9SWjh2R0pzMDBkODJWRmFNV1lQ?=
 =?utf-8?B?Y1k0WVhyanhTejlzNU1KZEJDc1c3elV4OE93T0dCNkpFeGlRY1hUWHhHVk5n?=
 =?utf-8?B?UW5wUWt6Y2V3d1ZPK29qdllOc0d1anI5Q0k2bWZ2SjZWd1lUSHhPaENsYzJ6?=
 =?utf-8?B?UEFvNUdLSkRYUzVRYVNPaTVnZnNuV0xHVmJQaC80RWxBeEdhdkg1ZXhkYXhm?=
 =?utf-8?B?UWVQVFhlZmdxS1o5TlVaNFRlQmdTTXQ0T0pUZytzWjRYN1M2dWJkVHRBbTlS?=
 =?utf-8?B?YlA2aUUxd0pPNmxDaXFYaTRoTE1PWVcvbWpkTTMwWTd5c1l0MVJ6V2JnUTBU?=
 =?utf-8?B?bGM4NHVGUDUxcnFpVXpMbVh0NVZHNGx1bnVadnFjRHQzY1lCbnpRYmVJS2ZB?=
 =?utf-8?B?aDZpbjc2U01XMjIxRzdVdEZ2djE3MWIxVEROSEEwaXhQZDIwNm15TERCdFc4?=
 =?utf-8?B?RTBGenQ3S1pKUW1zTTNMeVdlOHpEbHRyUzdNeHh0MVh6MEp5NkYvRklzQjVo?=
 =?utf-8?B?dkFTWGFWK1U1eFIvdUpsZ0IvMmdUK3dkNVV0cHFNNGdweWxQYUptSnFkQTRE?=
 =?utf-8?B?NURIT1dCb3EzVnE0bFFsaDJXbC9BMG9tV2Fjd0xVSE1aMzZUeWgwMnNtSHRM?=
 =?utf-8?B?YSt1cUVKYjJRckJMSUl6a1VkVmVRTTdTdmpsMmpMNXEyeTU0MEJuTXNqWkxW?=
 =?utf-8?B?ZXlFeWFwdWFGeW0yZFhnbUExVmc2aGUvSkthNlVVNlVEL204SUVXKzY2dGZt?=
 =?utf-8?B?dE0rY3kzcHBCb0NRS256OFc0QitzM29xSEF5cUpja3FzZEszV2o2T1pSeGJT?=
 =?utf-8?B?NWxsb0VOYzYreC9KeW04V1hlSHJnNEhHZUtDZEpraHlEN1JoQXpGMDc4bnla?=
 =?utf-8?B?NEVxbGh2SldRNVJaYmd1d2MrTFhvdW1rdmNaZ1JlNTVDQndvbWt0czNsTUpG?=
 =?utf-8?B?a0J5SHE3OEE3U2Q2QUpMeGZKM255R0thcHE4Nm9URFdEQUNyRGNjL2RlQ1Fo?=
 =?utf-8?B?Sk05Uk8yUGlPSmtudEROVGI4TFpYaU12cDVtTGVOcmxUTlRIOTlJLzN3Y3JD?=
 =?utf-8?B?SHpCanVYS3VwOEdmNlJjVGF1dFVIaDRaSUJ6NlFuVWxhWCsrWXRqSnZ6aUxG?=
 =?utf-8?B?TXhlRDNwRXRiUytsZ1ljeWZYMFJPUHZtWW9UKy9IOVo0YnNSUWd3YkVvTVFL?=
 =?utf-8?B?WnNjSGlWRmY2Zk1EczNXSVdUanhDNjdlS3RCdVlxejZmbE1keXhXVFIzRkJY?=
 =?utf-8?B?ZW5ObUcrL1RGYWUrVldiTHJmak5SRlpqa0RlNG1kY2FsNmJndktnVnFhT29y?=
 =?utf-8?B?WEJDdVRpVGorZWpJM3hEQU5QVG9tQTI5Vkl2QktzTXJYQUhTaDdNcmNpTDJ3?=
 =?utf-8?B?a2U2N0Vrc0dkbDJYRDMzMTB6MmVoblBrdXg0UmRKVjVxbUx0TVZSM1R1OXd0?=
 =?utf-8?B?Y043OWxEcHF2L0RKMEpORHFSOElzNFFveTQwWWgxWWtVK1hlQXZ2aXpTWExT?=
 =?utf-8?B?NnVRZFZhd09LbjdjV3NaOWo2b3JxbUNMUjVpbFo1OEhGdVJheVhqT1g5bFMz?=
 =?utf-8?B?d2hVTVlvVVMvTStGQ0NmYlY4MkRRRmtUUC9YMEZ1d05uRmMweDNUZ3N0bjFW?=
 =?utf-8?B?TkhvR2NpUmhJOE1CK0FVOFV5RUd1YXhVSWxCUFRxTWl4Wkt4OEVrWWlaSUox?=
 =?utf-8?B?M1QySUxqVFhUdzIwUm1wMk9ZR0pjcXdEdFFIWEJnK3ArL29ZYkhQRnM1dTBC?=
 =?utf-8?B?MWc5cElRVGhna3pPMWRSM3NuZkNlSGpGMm1mak1Mb2c4S3J5MU91My9oMldw?=
 =?utf-8?B?WG1lSGZHa3hzNXpDT1FIazI0bWhjTXE1ZTRCWHJTTUY4LzI1ZmNBWURwYjB4?=
 =?utf-8?B?UFNVNUZ2Vm4wTmRYcGlacDBaRmgvbGpZNzZNak1UbCttb3JrOGxUVlQyaGtt?=
 =?utf-8?B?SUZPVmZLTWZmSG9NMEN3L2Q1NHpicHVFQ0RIbXVoS0NVWStzZ0hMbWU0VFBP?=
 =?utf-8?B?M0V6VTNaTFBRamhmMUY2ZCtoWGNQdnZHTEJOUlVnY2hTdGFOdktsVDk4dFNt?=
 =?utf-8?B?TUtBbkVTV3BPVkpLS29odFZlLzRyMzN0TzJ6UVVVc01VbkFZdGxLVUJPNHho?=
 =?utf-8?B?NHJ3bW5lYm5ERmwvZHA0bDF5YTBsajd5czI4TXN3VTZvUEpySThXNWdjNU9z?=
 =?utf-8?B?SWZpUXBjaHdhM2E2VTNHVkdvT0FrWjhLdG1HWWxzVkNvbG51VllvMHBKd0Iz?=
 =?utf-8?B?UEtEc3VSOWZvT3o5M0Y5RU9CejhnLzdRUFNITnVscDJaYXRsODdqdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddccf9d-4436-442b-e807-08dea5f8cde5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 14:08:35.9852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VG8kKyzPVDo0oaq7BoOXJmv/ngszPWCbHQCjuVWv5pl08cAu0pkT9cTP1n5c3pOl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
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



On 29-Apr-26 7:23 PM, Christian König wrote:
> On 4/29/26 15:49, Lazar, Lijo wrote:
>>
>>
>> On 29-Apr-26 6:17 PM, Christian König wrote:
>>> On 4/29/26 14:37, Lijo Lazar wrote:
>>>> Adjust gart size to account for space required for firmware private
>>>> buffer allocation, if any.
>>>>
>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 ++
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 ++
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 ++
>>>>    3 files changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>> index e1ace7d44ffd..1c32e653a9ad 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>> @@ -723,6 +723,8 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
>>>>            adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
>>>>        }
>>>>    +    adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
>>>> +
>>>
>>> That is pretty much exactly what we don't want.
>>>
>>> The SMU prv buffer size should *NOT* override the amdgpu_gart_size parameter.
>>>
>>> Instead we should disable the SMU feature when the GART size isn't sufficient.
>>>
>>
>> This is not enabled by default. In normal cases, this size will be 0. This an extra allocation for additional logging from FW to system memory facilitated through a module parameter.
> 
> Yeah I know. But we have cases were the GART size is explicitely specified for testing.
> 
> Overriding that because the SMU logging feature is enabled is a pretty big no-go.
> 
> When the user specifies contradicting module parameter we should fail to load the driver or at least disable the feature which causes problems.
> 

Do you mean to add allocation only when amdgpu_gart_size  = -1? When 
gart size is specified, it will simply fail driver load if there is not 
enough space.

Thanks,
Lijo

> Regards,
> Christian.
> 
>>
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> Christian.
>>>
>>>>        gmc_v10_0_vram_gtt_location(adev, &adev->gmc);
>>>>          return 0;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>> index 94d6631ce0bc..2f6e338f2a35 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>> @@ -714,6 +714,8 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
>>>>        else
>>>>            adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
>>>>    +    adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
>>>> +
>>>>        gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
>>>>          return 0;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>>> index 5bdd4b9b7893..e5096b9cdf50 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>>> @@ -770,6 +770,8 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *adev)
>>>>        } else
>>>>            adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
>>>>    +    adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
>>>> +
>>>>        gmc_v12_0_vram_gtt_location(adev, &adev->gmc);
>>>>          return 0;
>>>
>>
> 

