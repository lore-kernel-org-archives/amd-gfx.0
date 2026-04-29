Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B18CCFA13
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 13:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F5E10E3BE;
	Wed, 29 Apr 2026 13:49:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xp9Bl2+J";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013055.outbound.protection.outlook.com
 [40.93.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A16A10E3BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 13:49:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/VF7d4iSRziGsqVr7kIJxMFiqpsx2Pm7nWfgw3xSkp2W1QIVmGEZ6beCtZH9oBtrJSPSCCVrJS/bZ3/niSodAb9MC1lk/+cR5/E2CNnmwHDZGo9G7Vbzi1MhhJvzya+/0nz1PJO4D7dC0iNFkBPUmWpljJ0YhbCTuGlOGrZy2DERyA0tsShp3rg8aAr/Sc0w4Zj71MtS6ucc0+cXmGNXXBoQch4EvQzCtk/jiggsDaHfRXmcbdBS7IJzMFaIPqJ9sEm1qbUueQZ+oJ8FAXhPjdwUH8QjznnxCon8JkaTJ8c2/j2VKjGbK1U8lA2YnY3M/TQdkx0bdnMl8dS6c6MaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQuwiridMxjeqQWVraoYCcube01ln7pA73A1AfPpvug=;
 b=VGJXqs0w93mFfHsV9/qTwdCpARed2oQBG/i+zH2q3MM+6cZza5t8ujrY0Q9F7vf4Eqz8tPa2fb7NCvc07ZNl8b6C6WPCXpc9eucSdlHzBEJfV4He3dffyWxj1YGRG+Up4EeqeLSlPVgugT3zsff8AK/nWCJkxWtYwT7AMqs0FYa/BKBfj3qs675RBIbCm/p67X2h3Q3Ipfd1lSNbwOFtCjhKE6C9yet9Fw0+/XKcnYzFUls/7FU1fEky/hUn54oDGp2iyj/VUvukzM1ZNgBO00iPjtedLFlP3IKNVNwhp9yG/Aw2kvdep+U3tBusUJ+4Ody5QCaDl65VYWrhTTVjIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQuwiridMxjeqQWVraoYCcube01ln7pA73A1AfPpvug=;
 b=xp9Bl2+J5Xyf1m/650VDfmWuBNbI2CjahcdVVZSwPuac5nnswFZPWpB3KhBu6yrpP9cFeAqNohdSQyKASZg/QbdKgTi2/CyHbW5WuSnDT0ok9F4fvLzk0w3KeilBe9Ao3CV/tS0oZZ9X1BU2fQnlhVgwjDgxjerZ+IFzAuiPNko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 13:49:24 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 13:49:23 +0000
Message-ID: <055c7635-425f-443e-afc0-40c3e0eaee1f@amd.com>
Date: Wed, 29 Apr 2026 19:19:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Adjust GMCv10/11/12 gart size
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com,
 candice.li@amd.com
References: <20260429123745.3930780-1-lijo.lazar@amd.com>
 <25f247d0-8484-40f6-b751-1b5f259cfa71@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <25f247d0-8484-40f6-b751-1b5f259cfa71@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:266::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eef47f0-b839-49c9-4152-08dea5f61f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: ewth3WyolLP+NEgVx57IIb6TzfbyiakNG+aedeveIodbAnqC3kmthLtNvA/VKlA0X9EwbBWGtE1ZmgLQ74SDZ39IrUzbqcgIkAe/nCNpCAGRV2V4DcCzxFr15zL7cXXOoccbxm9tuPYNR9INnfmbc3vrLe9skqEBkcv+VJHhjR4GRNnp5tdR2Cdk9XT3OeLodkRFeQ+VYWEBT+pLMJ+YCEJpwCv8lgwuAbW2Ir2eXL182FnbwgOuQS62566X3NVV4vfKH+CMZ3FQlnBD6cqg3DeXhenUxio9s4ZYNKukMesu5g8kOdDep9fC1HN0JGroRcKenT/di84SWKNum037jeoh1hTdtid4CmziCEOrl2s9Jh4iuH9/1M7omrqM7WOGbLG3iQ7Y0kKwvt3QzZ4LC1qm0xcEHLidz/bDGdtIgOha31tcgUmQTegBNvieHBWp+liA/9Iaa6FQqLynsY37eQ5iysSqDAYDYOT29TE/vqg1k4ewDLU9azppwNGkH/y/RTseXKIlzvEmj8kZPV2f5aTslXWbiBuklZk89m6vJTuWan6tVhHR+FsqFAm5+vHZ1IM0/TEQ35mnnhnoU20Df+YreBbn83IlxLp9b2Ea80SUVq8jR+GbvcaVWcVlREQyOYzxUswLOYDvWsUknYwcbzreMLgx2Ip+4CtGOEZjT2VSwsxMw+1FCleaE3qiTRxk31gGBh3NtlhEgT4WhgzFgsqHE4vNInoE2xmmOj2uK44=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VSs1S2xaWmhhcHlkbG0reFJVK254MWdCSmJ3SURjTGsyeExlekZCaGxHS1ow?=
 =?utf-8?B?Q3BtWWVQQWt3a3VUb0xIYUsyS000NXNTLzhvbXFxYTJ1ZXF5WDV4MmFtOTNZ?=
 =?utf-8?B?czUwbTkwdVFMRXRQMGNOT2RlN2htTU13YzFxU0NzS1JHVjFwWUROZzNmTGdw?=
 =?utf-8?B?MmJFSGplU2FoWGNSQi9hQW9qLzBTM0VQTkpSS0JUUUhBWkNnY1IvS3NjV09v?=
 =?utf-8?B?YkVuY1JsQ3czYmpEQjA0SlhRVTBlNHVWZEwwYStESjFFTDhWT0pYUkFLSkUv?=
 =?utf-8?B?Nk42TG9YRndwVnBnUEJDeHVzZllIekZIU2N5TWFCcE9KcVExUDUvMjRGdmVz?=
 =?utf-8?B?M2l6WFFEWFdjUnBPYWpnWElKbEg3L3pRNWdOeS9hL2tvV290VjJzZ0FZYmRY?=
 =?utf-8?B?WllCN2IzQVVucndrYUlUTTQrSWRuZWdiSmpLQTZLNlBra1Q4bzRQazRRUXJi?=
 =?utf-8?B?Nm9IbTlzVHlMbDVzMDVhd3Q0Z3I3Rm5sNEN1WWNrTG44YSs2T09xVnVzVEww?=
 =?utf-8?B?dFh5VlVQTmc1aW5EWUpMNzh3ZGpCLys0SlVxckpWNnRSaVRIZis5b1BKUjdO?=
 =?utf-8?B?dlkva1VEaUpIM1JDQXNrQ0ZiR2R0OEp3RFRQMHI2ZklNczcya24vT1hZNUVa?=
 =?utf-8?B?MDFzTHRhelpHRTk2eGlpVkFHMXJibHBFNTZueUlSMkZwVEZBb085VzNBVGl1?=
 =?utf-8?B?VnlOQ1huN01hSHI1U2dHSlk3UG9MaXM3citwWlMrQm5CcnFDUzI2L05lbWZP?=
 =?utf-8?B?MGRycmo3MnNkcFJYWk5YUERrZUN1N2J2SHp0RE53ZzlBODAzcXJ3SW1uNDBV?=
 =?utf-8?B?bEZnS1hldzFub2pOSG1XYXorUTFEczFWWkhCaE83WThGVlNQaWJpTENpY2ly?=
 =?utf-8?B?SDVJdjFIZlkzMmJwVWorVWdKRkxhZE1tbkZHdXFZbk52OTBhZWpoNEI1MEx2?=
 =?utf-8?B?cGdjcXg1aEJlMisvNmlyRjhyOEVVVDhPaml5YUIxK1FYV1AxcUI5V3gvbjRR?=
 =?utf-8?B?a2dxSVhrMitOaTBTRStteEUzd0VKdWNYWmJGWGxDZ0NYRWdyQmVpeXJHWE5N?=
 =?utf-8?B?L25EbnNnN2o3a3dQRUVBVUN2OGlKblJUTDhmZUQ1OXQyMEk0MW82azcwVHVn?=
 =?utf-8?B?WjhRbHFkNDBQdkpubjBscXhJeDdNc1dSb25KN3YyODZ6bzI1UTNXWXVFYk50?=
 =?utf-8?B?UzdGTjQ1RUJUWkpNNjYwUTJpanVqeGhFejQ1RW9KRG5jRWkyRExTUjNGRlRI?=
 =?utf-8?B?UGdFMlYrd1R4eGVrNkdVN2pYMFo0RVhpMGFGRE9BRjRnQTJ1VTYyeVZVK29s?=
 =?utf-8?B?SHlQZElxV0lRMk1PWWQvZEgycVVHUXBkZ3h5elVDM3ZKbVhHYkJxK0RMRnVs?=
 =?utf-8?B?M1o5akVMVmNpcTU4elE0amdIaUpBSHpsd2p3Zm5JRHRvMnJNRkFENGd0S1g2?=
 =?utf-8?B?QlJkS1pGdE1ObFVUYlpZVStFKzNCTCswT3AwWnhTd1Fuck9mWVlaME1CYkxs?=
 =?utf-8?B?eExoT0FETUNHUlNyVUJjd0dTcVhPTDVuZCtWQkxKUFphclJMTVR5bWV2THNm?=
 =?utf-8?B?OXZFbmE2alhWcEJweTJpcHlDRWJJR3RCUlUrSGU5Z1JnSithQ1NRL0M3N2k1?=
 =?utf-8?B?MWRWaE9icGtuZDZsYTVENG9ORm1tbGJDWWNzVndTNUxJMmRrQW1wRUYyVWtk?=
 =?utf-8?B?SkV5ZFcrOGJGWmZZNnlsbkVYajBUOUVqRXE2VzJJL20rYzdTVzI2aXBHSERD?=
 =?utf-8?B?dkRIUy9Hamc1L2F3WVlnSS9HRUxOaE8vRG01b2JWVWVEV3JycUdEc1RoMUNs?=
 =?utf-8?B?bHYyOXpLVElzbVJ2VHB4S2U1aFlIZTU4L2dUMjdkUU5lVHcvdEl1ZmpsZG1s?=
 =?utf-8?B?TUVGUGZWd01iUlYweHU2Z0wyeWt4MGkwaGdOYmlwQ2laRWwrbkhMYlp5R2lM?=
 =?utf-8?B?N05HaVBscmh3Y01VQlM4aDRyWXdxVVdQa09xZWVJRFQrMXA4M0t2Y2UzU0R4?=
 =?utf-8?B?MEdBZ1psV1hNUUg2NFVUOERJRGllUkxMTnhibU1ub2hXd0FLSzBhNTBhVGFJ?=
 =?utf-8?B?NGJ2ZS96T2tiNXZLdS80alZ1TmttZEtTWVRuV2NVRmlPSnk4K1k3T0paMlMv?=
 =?utf-8?B?MnZ4cVVUQU9QbmprOHIyQlJiSFZZcHpFQXhnL0hYZmJhcFBHdWp2U3B5aVBY?=
 =?utf-8?B?RjRFMUVpY2QrUlZpbFgySTViOW1YN2ZJVnRoVUk0RVZQMzBMQ0NiVTdyR0Rh?=
 =?utf-8?B?c0ZpQVcwSlJuT25Vem5XOVF2ZWxVNURlU2ZXS01vSHFiZi9kYVBTVk1EREpN?=
 =?utf-8?B?cHU1V1RHbmRmUU0wZE9ENlF1allXMXBTcWV1ZG5GRkEvVmNidXpxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eef47f0-b839-49c9-4152-08dea5f61f0f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 13:49:23.7787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMUu/+39C9j497QUvCBI7Hq29fn7VUNGlLu8zEYw1qTQ/inn7a384OyH3aToy+lv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441
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



On 29-Apr-26 6:17 PM, Christian König wrote:
> On 4/29/26 14:37, Lijo Lazar wrote:
>> Adjust gart size to account for space required for firmware private
>> buffer allocation, if any.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 ++
>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 ++
>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 ++
>>   3 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index e1ace7d44ffd..1c32e653a9ad 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -723,6 +723,8 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
>>   		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
>>   	}
>>   
>> +	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
>> +
> 
> That is pretty much exactly what we don't want.
> 
> The SMU prv buffer size should *NOT* override the amdgpu_gart_size parameter.
> 
> Instead we should disable the SMU feature when the GART size isn't sufficient.
> 

This is not enabled by default. In normal cases, this size will be 0. 
This an extra allocation for additional logging from FW to system memory 
facilitated through a module parameter.

Thanks,
Lijo

> Regards,
> Christian.
> 
>>   	gmc_v10_0_vram_gtt_location(adev, &adev->gmc);
>>   
>>   	return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> index 94d6631ce0bc..2f6e338f2a35 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> @@ -714,6 +714,8 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
>>   	else
>>   		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
>>   
>> +	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
>> +
>>   	gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
>>   
>>   	return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> index 5bdd4b9b7893..e5096b9cdf50 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> @@ -770,6 +770,8 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *adev)
>>   	} else
>>   		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
>>   
>> +	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
>> +
>>   	gmc_v12_0_vram_gtt_location(adev, &adev->gmc);
>>   
>>   	return 0;
> 

