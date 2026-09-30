Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8710CA5FB1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 11:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 730EA10F311;
	Wed, 30 Sep 2026 11:38:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2cb/TYZ3";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010016.outbound.protection.outlook.com
 [52.101.193.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6324910F309
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 11:38:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWzK9ok6KsbBSY4djRr0U/0FTfqz7EA9FrCf9zVRV/jphgxgJ1h2kxo37cwBjBJxtvVJh70Pz52mpZd1OBpDWnn+iblIUHcydv6qsOGcMtIIeYeUeRaFIvHphHSSVPkafcM0cHRxgJnDEsAeFlX5jqx22dUh9hxo1XtlHTx6aEyBvCOQPpEwGmXSAle0l6NYCMHzHl0WMhg8D57ezfBFXjsH77FPs+01tmSF21bhB0FDI4Q78x37zc2iG8OHg0GF4ln1+jjFvCoPq15pU6fDQ2kKPN1umKNL35vo4E0JZJfIDmdxyYhLDqBGbqzBK169pBZOdt0ZLaxRpjbJ5vDm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQqDNzPLSuduFp4zfsPtj4b4p1flhe043s4YGAERtJk=;
 b=GCBXt3pse4k9SfLxV5eZVTCc9Ypw/4jyMIAYwvQ8dk1lK+wF6iZJJdwMWZmctOKsNRfDnjfS0RJuJSco8KmnYstu5d0IkeR78WFqy6r8V63fyKJ3t4/t+BKMZRsXJJXzjE1INdmNYq5pBEX+hrq7Q4ndDH9W0I4zG4raT9PoZ6TQXWdc7/5jo2gGoKzAvijCmW+iMBErBzlEfATTTwESuU39edSC5HL0BmuwnL4OF7w+f5LXjYQ0gP5ZhX1r26kIhxKa57gMMrkwMi5C8+VBH6FOfdnRW0iBak4hL3peO5RePkMM/I3mbb/VU7ViOADGzEmjyNpmilXD1htxJ53HpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQqDNzPLSuduFp4zfsPtj4b4p1flhe043s4YGAERtJk=;
 b=2cb/TYZ3Zg8FPPWgWoT7xOenyJ/mda2rreH0NksupZ5R5zvGEdIx5CtsYL+CS3BPr7DPQ3OanIPrj/cL9W9rris7wPfSruTr1yhD7NMzPj8L1+noLLG8UKNvVtN9dyzoufrWzPvCpXCTqCXIiv21sVypNMwKtNzw1e++QGb8sK0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 30 Sep
 2026 11:35:51 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 11:35:51 +0000
Content-Type: multipart/alternative;
 boundary="------------hzX3BlPtRZSqicf7yhYASbsU"
Message-ID: <8939b352-899f-4327-a8ed-26e12e3b6c39@amd.com>
Date: Wed, 30 Sep 2026 17:05:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: move vmid_mask_gfxhub/vmid_mask_mmhub to
 vm_manager
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Zhu James <James.Zhu@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Ma Bing <Bing.Ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260930111601.3721001-1-sunil.khatri@amd.com>
 <2873ad31-7fd9-4fcd-96fa-7f4fff1c1934@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <2873ad31-7fd9-4fcd-96fa-7f4fff1c1934@amd.com>
X-ClientProxiedBy: PN2PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::17) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|PH0PR12MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f2f6d8-673e-423c-9434-08df1ee6faa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|4143699003|56012099006|8096899003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pM28wvlHsCvjH3hAazJqD3VZM1QlQrSE+0uN/Xs5qhxtBRa311cLPBONsBCm/S4NxxmbLyiTuvUZ7Pp3j8gi8hxfAdhSNYXSS5yLr74qxUZ6MLVhzadvj1GWfdZjGgagjdoVs43sxDtUD+tdAuM/Qdy6r8HJcyR90bt0gIUMAvE77xD3fGjMEtk9ygKXZlagNhHQ+9GaKgjDfFroo4zsfBI9wlYiJfd+nV8/osVNmcNFlNe1DxGmq9h1y191Kxis30wYvK2OJGmjCNI5hSWMiunnfNxjk4yJJWXnz0uGkhKA8w0VUEPruGzv2XlqYKSjV8AyjHC8UwbCKhR/tM6xWL4guxnhdnevPEyPiJ9bi0ZQLc5qL6ZihPPRkocSjOa+cdzY/XnWo5VCNtNULDHNVJB2xW+EUWqvrCzU8pOrohbfksjuPau6pkw24Bs5V0LCEGgIJWk0IRyqwlkvJNM16XRfGxhoc33s/da0mJTZi3GZFPnYsf/kLO8xnPeWO5doWJXshmbqnJh5S6VxUl/lmbzsq+oUYy7HiyLN7TrEOFEdeiHakSNJYguaPIvI1E6FANEVU5D3V7P5O8iV3PPXI2JHc7pi9DTBhVL4oRj1iqDWhNMZCJf1QO9QfVKcVOpev68r1rEwfa+pr2xIPPhbk9HH+P3SioUF6kc4800I+ps=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(8096899003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnBaT2Z2Wkt6c3kzSTEwa0x0YXQ4WUlrZTk3S3c0YnJrL2dkckYwWG1XODlG?=
 =?utf-8?B?eU9aN24yRm9PMnZ3TFQ5eGJzK2NrZnFIYm43RnpLOStaaWZybHR3R0NnaUlV?=
 =?utf-8?B?VFEvUlloRkhsUDNNZkNnVEJRakZVMWJsSGdLQ3VJWTViS3VSNVVxcThDY2lK?=
 =?utf-8?B?WGkvTWZ6eEh5eXNxNGRVOUw0TTI2aGJkNFpSS1lvQkwyQkcvejZGcVNpem5Z?=
 =?utf-8?B?UVE3QXhtSkRScFFFdFI3UzBoZnRMWXdHay9EeUN0UlJVQTREd01Xb2tpY3lh?=
 =?utf-8?B?SEU4ZlZaWmpNYmNSWHRNNDhTczZQK09iZjFmWHJRaHVwbStZUXpJRXBnY2Qr?=
 =?utf-8?B?OTAvbXBhWmNJSWdNa3F4MDQ1dEdvcGdveHp5WlRtT1lCWmVzT1RSYVZnTlJ2?=
 =?utf-8?B?ZEFqVWVtNlNzVHFWek54TzJweVpUbmN5Ym5TWm10ay9hV3JRM0FVVUo5V2dl?=
 =?utf-8?B?KzAzSDBsU2RIMUtzWS9ldjIzUzErV3IzMklVTUtmY3J6ZHQ0UzVLSkh0eWpx?=
 =?utf-8?B?emtkbHhRRENtamFLZjBhSTQyZVc1aFdOUlE5TFh4M2hHc21uR2o4Q0dhT3BH?=
 =?utf-8?B?L3VnZmg1cG0xUTRxSjdQYzNzOCtXdUx5Umw5dWR2ZGIvMDJ0dlZ2bW1IUVNV?=
 =?utf-8?B?dDhmZDRjcXowZjFhcGUrcmZxZjVIUTV6eGhoWUhZYTNsSDN5ZzBJQStOOVZq?=
 =?utf-8?B?Y0hzZTEwRW5DMFpGVkJPTjBOSmlhZU1qVzlMRTdvYmc1NUhkRnR1MUdHNC80?=
 =?utf-8?B?T3BSSUZaOVVwdC85dUxjUUV3MEZPK05ScDRodFB6OWJ2ZFR2NGZVMUlOUnpZ?=
 =?utf-8?B?a1pCRzhmZzluOGtncUEzNzVPK2xWN0JUOFZtWklIbjViU3ZhTnJXK0lnWkpw?=
 =?utf-8?B?Y1I5VFpRcCtkb2dMV2JKLzUxeDdnOVB6b29tSmE1bFF1dFZ1ZlZIZWI0TVNo?=
 =?utf-8?B?eFByWHptdzBuSnc1c0VFSXdPQzdhYml2RG80cDI4TVdTMFVRbDQ1TStOZ2hh?=
 =?utf-8?B?eUtSVGdGSk9NeDlCS0FMWkk0bEhUdlRRaGZhQUR2bTNFYkkxR3NmRjlGczl5?=
 =?utf-8?B?L3JrakcrS014RDJWUGQ2RXJ6bTd2L1FibWdWblIvVmg5NUhvNEVOOGY5YmQ1?=
 =?utf-8?B?RzQxdVBKcEd2dXJ0ZVNkN1B0TVB1TkNXalh2R3drbVhWTVRyY0VFblZPRVk5?=
 =?utf-8?B?dEZzZUJZSGtld2VDV0RoRU9udUZOUUJBbzJLNTIxRUVuNGtOV0ZBOXRXVC8x?=
 =?utf-8?B?ZisxbzZCN1ovTzJvYnJUZUR0YjFhMXNNOWREUjNlYkdLQ0duNDFYSmpDV3dC?=
 =?utf-8?B?UDdleDRMSllRZmsvSUN3b0ZOUmNSTUJYVDU5UUJUbnNORjdtcFYraWlqQ3h4?=
 =?utf-8?B?WkZSNmt6VkJoU2QxVGVPRitZUTNMUE1TV1JMN3lwN3E5MFZPbzltWnkzU09p?=
 =?utf-8?B?dnMvdjFRUmdtUXFrejUrbWdTR1Q5M2dycG9NdUtUQWZUVnptVzNuS3NEZjF6?=
 =?utf-8?B?WWxKU0VjSlFDdXFZejdEVmxKYU1wM2tqMEpyMFdlY3V4WFRMQmh5eXdhU3E2?=
 =?utf-8?B?MHl2dURmK29nR0RpUElwdG5yMU9iVHZhWnYwS09tU3lUTm5YVjBkTkxwVTRj?=
 =?utf-8?B?RGoySDdrajA0MkJtd3FIeTNPYVR3Tm53OFRSRVlIdWtORE5jZzhlejFLbC9W?=
 =?utf-8?B?bm1yN3RiWi9xVzNnWGY3akkzT0tGU1llR3dkZW5IeWxxYkNORXFOMms4OCtG?=
 =?utf-8?B?eXdpekNzUDFWZHRUMG16M2VqYzk0SFhWbWw2VmE1YWhnQ0pyNUVkdDM0UWNn?=
 =?utf-8?B?NloxaVhuOXdNSm9udW82OCtucW80WXNpcjB1bGFndmNXVkl4dkNrZEJ2Rm5y?=
 =?utf-8?B?Mm8rdHRCT2NHR01tWWNSNmZ3T3ozTVVIbkZQekhFT255MlJ0MXphMS9JOEh2?=
 =?utf-8?B?QWQ3Y1lxbUZCMEFBNWtSV2xIQmZDcGJJdGJqU0hmTndHY0pKcFhkcnRwRi9T?=
 =?utf-8?B?N09oajNOT0hFMTVXdWZDZm1MUjNSOE5YU0JzU3duTzV0d2lyelFwYkRqMlRH?=
 =?utf-8?B?M05LME56SzBHSDNNV01QK3kvWEVCUjRwREhHUXlYQnBOOW5CbXpnM002TmFq?=
 =?utf-8?B?QlZLMUJ6L0lXd25Nbm5hSnFrQUY2S01tcEFqUWdjNDBwWDN2TWRlVmtnS3pN?=
 =?utf-8?B?SmdZTU9qRlpFekFVZXV2S0c5KzVwclNyN1gvWDg0SFFBdXNYQjBuanl4Qkp2?=
 =?utf-8?B?cWRDSlJ3cXliZW1yT2ZkRzQxbkJ4L3liSjRhUU44Wk9NcU5rK0IzZWM1bWFm?=
 =?utf-8?B?eFM1SGdnYk0xUTlGcXNoYnlmTlJtLzRxN0diRzBrWllqQVpvcXpRUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f2f6d8-673e-423c-9434-08df1ee6faa8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:35:51.0811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQLHrcdSUEwj6psB7dVMW4t7+c/a+DRLsS6pkcIfC45f13tlzUt9bQnGwemfQGu36olwO9r7Y2vcc5tpAp3aVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863
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

--------------hzX3BlPtRZSqicf7yhYASbsU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 30-09-2026 05:01 pm, Christian König wrote:
> On 9/30/26 13:16, Sunil Khatri wrote:
>> vmid_mask_gfxhub/vmid_mask_mmhub makes more sense logically in
>> vm_manager than the mes ip struct.
> That's the VMID mask for the user queues, so I would name it vmid_mask_uq_gfxhub/vmid_mask_uq_mmhub.
>
> Apart from that looks good to me.
Noted. Another point here if that is the case then should i change that 
in MES HW layer too..
unionMESAPI_SET_HW_RESOURCES{
struct{
unionMES_API_HEADERheader;
uint32_tvmid_mask_mmhub;
uint32_tvmid_mask_gfxhub;

Should i update here too or this is fine ??

Regards
Sunil Khatri

>
> Regards,
> Christian.
>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 2 --
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 4 ++++
>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  | 4 ++--
>>   6 files changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index 5285c1d1fd4cb..9c36ccf5d5659 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -137,8 +137,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>   	total_vmid_mask = (u32)((1UL << 16) - 1);
>>   	reserved_vmid_mask = (u32)((1UL << adev->vm_manager.first_kfd_vmid) - 1);
>>   
>> -	adev->mes.vmid_mask_mmhub = 0xFF00;
>> -	adev->mes.vmid_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
>> +	adev->vm_manager.vmid_mask_mmhub = 0xFF00;
>> +	adev->vm_manager.vmid_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
>>   
>>   	num_pipes = adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
>>   	if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
>> @@ -184,8 +184,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>   
>>   	dev_info(adev->dev,
>>   			 "MES: vmid_mask_mmhub 0x%08x, vmid_mask_gfxhub 0x%08x\n",
>> -			 adev->mes.vmid_mask_mmhub,
>> -			 adev->mes.vmid_mask_gfxhub);
>> +			 adev->vm_manager.vmid_mask_mmhub,
>> +			 adev->vm_manager.vmid_mask_gfxhub);
>>   
>>   	dev_info(adev->dev,
>>   			 "MES: gfx_hqd_mask 0x%08x, compute_hqd_mask 0x%08x, sdma_hqd_mask 0x%08x\n",
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> index 594fb817e0a38..2b13a5b375393 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -122,8 +122,6 @@ struct amdgpu_mes {
>>   	void                            *mqd_backup[AMDGPU_MAX_MES_INST_PIPES];
>>   	struct amdgpu_irq_src	        irq[AMDGPU_MAX_MES_INST_PIPES];
>>   
>> -	uint32_t                        vmid_mask_gfxhub;
>> -	uint32_t                        vmid_mask_mmhub;
>>   	uint32_t                        gfx_hqd_mask[AMDGPU_MES_MAX_GFX_PIPES];
>>   	uint32_t                        compute_hqd_mask[AMDGPU_MES_MAX_COMPUTE_PIPES];
>>   	uint32_t                        sdma_hqd_mask[AMDGPU_MES_MAX_SDMA_PIPES];
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 98cdd7e3475fb..5f22c146e2339 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -413,6 +413,10 @@ struct amdgpu_vm_manager {
>>   	/* Global registration of recent page fault information */
>>   	struct amdgpu_vm_fault_info	fault_info;
>>   	unsigned int				npa_vmid;
>> +
>> +	/* VMID masks for GFXHUB and MMHUB */
>> +	uint32_t                        vmid_mask_gfxhub;
>> +	uint32_t                        vmid_mask_mmhub;
>>   };
>>   
>>   struct amdgpu_bo_va_mapping;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> index d1cd665ab301c..178ef8dfe6d61 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> @@ -1080,8 +1080,8 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>>   	mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC;
>>   	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>>   
>> -	mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
>> -	mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
>> +	mes_set_hw_res_pkt.vmid_mask_mmhub = adev->vm_manager.vmid_mask_mmhub;
>> +	mes_set_hw_res_pkt.vmid_mask_gfxhub = adev->vm_manager.vmid_mask_gfxhub;
>>   	mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
>>   	mes_set_hw_res_pkt.paging_vmid = 0;
>>   	mes_set_hw_res_pkt.g_sch_ctx_gpu_mc_ptr = mes->sch_ctx_gpu_addr[0];
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> index c0719d8fa63e9..f2dd4323ffd3e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> @@ -1042,8 +1042,8 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
>>   	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>>   
>>   	if (pipe == AMDGPU_MES_SCHED_PIPE) {
>> -		mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
>> -		mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
>> +		mes_set_hw_res_pkt.vmid_mask_mmhub = adev->vm_manager.vmid_mask_mmhub;
>> +		mes_set_hw_res_pkt.vmid_mask_gfxhub = adev->vm_manager.vmid_mask_gfxhub;
>>   		mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
>>   		mes_set_hw_res_pkt.paging_vmid = 0;
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>> index 20159fb9d6ea3..c3e1f9a746ce0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>> @@ -685,8 +685,8 @@ static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
>>   	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>>   
>>   	if (pipe == AMDGPU_MES_SCHED_PIPE) {
>> -		mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
>> -		mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
>> +		mes_set_hw_res_pkt.vmid_mask_mmhub = adev->vm_manager.vmid_mask_mmhub;
>> +		mes_set_hw_res_pkt.vmid_mask_gfxhub = adev->vm_manager.vmid_mask_gfxhub;
>>   		mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
>>   		mes_set_hw_res_pkt.paging_vmid = 0;
>>   
--------------hzX3BlPtRZSqicf7yhYASbsU
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 30-09-2026 05:01 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:2873ad31-7fd9-4fcd-96fa-7f4fff1c1934@amd.com">
      <pre wrap="" class="moz-quote-pre">On 9/30/26 13:16, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">vmid_mask_gfxhub/vmid_mask_mmhub makes more sense logically in
vm_manager than the mes ip struct.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That's the VMID mask for the user queues, so I would name it vmid_mask_uq_gfxhub/vmid_mask_uq_mmhub.

Apart from that looks good to me.</pre>
    </blockquote>
    Noted. Another point here if that is the case then should i change
    that in MES HW layer too..<br>
    <div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #569cd6;">union</span><span style="color: #cccccc;"> </span><span style="color: #4ec9b0;">MESAPI_SET_HW_RESOURCES</span><span style="color: #cccccc;"> {</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #569cd6;">struct</span><span style="color: #cccccc;"> {</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #569cd6;">union</span><span style="color: #cccccc;"> </span><span style="color: #4ec9b0;">MES_API_HEADER</span><span style="color: #cccccc;"> &nbsp; &nbsp;</span><span style="color: #9cdcfe;">header</span><span style="color: #cccccc;">;</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span s
 tyle="color: #4ec9b0;">uint32_t</span><span style="color: #cccccc;"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span><span style="color: #9cdcfe;">vmid_mask_mmhub</span><span style="color: #cccccc;">;</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #4ec9b0;">uint32_t</span><span style="color: #cccccc;"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span><span style="color: #9cdcfe;">vmid_mask_gfxhub</span><span style="color: #cccccc;">;</span></div></div>
    <br>
    <p>Should i update here too or this is fine ??</p>
    <p>Regards<br>
      Sunil Khatri</p>
    <blockquote type="cite" cite="mid:2873ad31-7fd9-4fcd-96fa-7f4fff1c1934@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 4 ++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  | 4 ++--
 6 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 5285c1d1fd4cb..9c36ccf5d5659 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -137,8 +137,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	total_vmid_mask = (u32)((1UL &lt;&lt; 16) - 1);
 	reserved_vmid_mask = (u32)((1UL &lt;&lt; adev-&gt;vm_manager.first_kfd_vmid) - 1);
 
-	adev-&gt;mes.vmid_mask_mmhub = 0xFF00;
-	adev-&gt;mes.vmid_mask_gfxhub = total_vmid_mask &amp; ~reserved_vmid_mask;
+	adev-&gt;vm_manager.vmid_mask_mmhub = 0xFF00;
+	adev-&gt;vm_manager.vmid_mask_gfxhub = total_vmid_mask &amp; ~reserved_vmid_mask;
 
 	num_pipes = adev-&gt;gfx.me.num_pipe_per_me * adev-&gt;gfx.me.num_me;
 	if (num_pipes &gt; AMDGPU_MES_MAX_GFX_PIPES)
@@ -184,8 +184,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 
 	dev_info(adev-&gt;dev,
 			 &quot;MES: vmid_mask_mmhub 0x%08x, vmid_mask_gfxhub 0x%08x\n&quot;,
-			 adev-&gt;mes.vmid_mask_mmhub,
-			 adev-&gt;mes.vmid_mask_gfxhub);
+			 adev-&gt;vm_manager.vmid_mask_mmhub,
+			 adev-&gt;vm_manager.vmid_mask_gfxhub);
 
 	dev_info(adev-&gt;dev,
 			 &quot;MES: gfx_hqd_mask 0x%08x, compute_hqd_mask 0x%08x, sdma_hqd_mask 0x%08x\n&quot;,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 594fb817e0a38..2b13a5b375393 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -122,8 +122,6 @@ struct amdgpu_mes {
 	void                            *mqd_backup[AMDGPU_MAX_MES_INST_PIPES];
 	struct amdgpu_irq_src	        irq[AMDGPU_MAX_MES_INST_PIPES];
 
-	uint32_t                        vmid_mask_gfxhub;
-	uint32_t                        vmid_mask_mmhub;
 	uint32_t                        gfx_hqd_mask[AMDGPU_MES_MAX_GFX_PIPES];
 	uint32_t                        compute_hqd_mask[AMDGPU_MES_MAX_COMPUTE_PIPES];
 	uint32_t                        sdma_hqd_mask[AMDGPU_MES_MAX_SDMA_PIPES];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 98cdd7e3475fb..5f22c146e2339 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -413,6 +413,10 @@ struct amdgpu_vm_manager {
 	/* Global registration of recent page fault information */
 	struct amdgpu_vm_fault_info	fault_info;
 	unsigned int				npa_vmid;
+
+	/* VMID masks for GFXHUB and MMHUB */
+	uint32_t                        vmid_mask_gfxhub;
+	uint32_t                        vmid_mask_mmhub;
 };
 
 struct amdgpu_bo_va_mapping;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index d1cd665ab301c..178ef8dfe6d61 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1080,8 +1080,8 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC;
 	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 
-	mes_set_hw_res_pkt.vmid_mask_mmhub = mes-&gt;vmid_mask_mmhub;
-	mes_set_hw_res_pkt.vmid_mask_gfxhub = mes-&gt;vmid_mask_gfxhub;
+	mes_set_hw_res_pkt.vmid_mask_mmhub = adev-&gt;vm_manager.vmid_mask_mmhub;
+	mes_set_hw_res_pkt.vmid_mask_gfxhub = adev-&gt;vm_manager.vmid_mask_gfxhub;
 	mes_set_hw_res_pkt.gds_size = adev-&gt;gds.gds_size;
 	mes_set_hw_res_pkt.paging_vmid = 0;
 	mes_set_hw_res_pkt.g_sch_ctx_gpu_mc_ptr = mes-&gt;sch_ctx_gpu_addr[0];
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index c0719d8fa63e9..f2dd4323ffd3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1042,8 +1042,8 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 
 	if (pipe == AMDGPU_MES_SCHED_PIPE) {
-		mes_set_hw_res_pkt.vmid_mask_mmhub = mes-&gt;vmid_mask_mmhub;
-		mes_set_hw_res_pkt.vmid_mask_gfxhub = mes-&gt;vmid_mask_gfxhub;
+		mes_set_hw_res_pkt.vmid_mask_mmhub = adev-&gt;vm_manager.vmid_mask_mmhub;
+		mes_set_hw_res_pkt.vmid_mask_gfxhub = adev-&gt;vm_manager.vmid_mask_gfxhub;
 		mes_set_hw_res_pkt.gds_size = adev-&gt;gds.gds_size;
 		mes_set_hw_res_pkt.paging_vmid = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 20159fb9d6ea3..c3e1f9a746ce0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -685,8 +685,8 @@ static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
 	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 
 	if (pipe == AMDGPU_MES_SCHED_PIPE) {
-		mes_set_hw_res_pkt.vmid_mask_mmhub = mes-&gt;vmid_mask_mmhub;
-		mes_set_hw_res_pkt.vmid_mask_gfxhub = mes-&gt;vmid_mask_gfxhub;
+		mes_set_hw_res_pkt.vmid_mask_mmhub = adev-&gt;vm_manager.vmid_mask_mmhub;
+		mes_set_hw_res_pkt.vmid_mask_gfxhub = adev-&gt;vm_manager.vmid_mask_gfxhub;
 		mes_set_hw_res_pkt.gds_size = adev-&gt;gds.gds_size;
 		mes_set_hw_res_pkt.paging_vmid = 0;
 
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------hzX3BlPtRZSqicf7yhYASbsU--
