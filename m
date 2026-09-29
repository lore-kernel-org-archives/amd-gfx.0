Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9536CCA5FA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 17:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1471810E156;
	Tue, 29 Sep 2026 17:40:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WmzIsrvj";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD01710E156
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 17:40:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPnEXDYavJRuD5QBG5N5ReJl6tD8MeOxeWcGphhJrpF/j+MWzBdwLddiQ9QkmAedAsqSG/vKl2XNsSWIDski2xXqZt13n6UBmGETSqtLQ0aoxjQbiYabKG4JipcJQwgUk+tiBUjgcfStTi42jMwmV5CfsUIOBgyfQmU0IsgI7JX4QQuGdE6izqOB7LTti6zF5rr0F9gvz/lhvD8JyH2jx9Yn1YViIWGufzKYfSxe00uu/KjI937MzMCEFioLavEm+j2k44kWVHDhMrC10UKQATKVvE/QjSqwLy/riHmOVwCX4wjRgaCDewBlIyhkrzmpjYAbxJUBE+K48HNtMhpOxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6vRj15TheZnvWQo9YkfuDgVCf+RFTuvJdZ6+hrp8Q8=;
 b=LW7bphEZD5swY4oCCEFAj8Wc2sMDmGAALz+lGzkz8piofhONeVy89nMUoxt3v397iegdpO8S003MS1oANrk/I6/9qR2+JnXHW3av7eXUA6uFunU1eShpMBenHU+zgB+l9u/OYAbjc8FpeLJzUubYCH2TqRfQbNNZu1aLLefLMBMSzMdotWp+qhsr3MNvY9XzF1WfWQ3YuUyVygz/RTyrEIqNR/UKqtASh9+MCB/f6xnuivQ8LQH+w4RxXQZ+NbnNo2Cih5/y7KpEBprgB7d8PQVwHpcXqdsH5AnPh8v3aY6GxNO+1TijoeHzliG/L/XV7epzPhAEIXam1WQefPoD6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6vRj15TheZnvWQo9YkfuDgVCf+RFTuvJdZ6+hrp8Q8=;
 b=WmzIsrvjwbZqEq5QjZA1jJmeVzt3dzXnQBn7i6rfsDhft25wv5UkdQT5GDKIyl1J5KXzHAplG0h8pfse2arFNaTsaEm9h+3zPRGMNfqAEc8VCJFSJiSGMB8T/EO4SbogBktL8t5WSHk/UWTg0+CxryZi3flwDBOJst4aoHuZ2VI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by DS5PPFA33D606F8.namprd12.prod.outlook.com (2603:10b6:f:fc00::65b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 17:40:03 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 17:40:02 +0000
Content-Type: multipart/alternative;
 boundary="------------mAWHaF9d8O2A0mTZv3GxAT6U"
Message-ID: <85c3809b-3bcb-4c53-ab6f-1d8482e88fce@amd.com>
Date: Tue, 29 Sep 2026 23:09:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] drm/amdgpu: add spm_vmid and exclude it from the
 MES and KFD pools
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Zhu James <James.Zhu@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Ma Bing <Bing.Ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260928185756.2382322-1-sunil.khatri@amd.com>
 <761b532e-8b5e-4929-9526-5d7a55213a88@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <761b532e-8b5e-4929-9526-5d7a55213a88@amd.com>
X-ClientProxiedBy: PN4PR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::6) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|DS5PPFA33D606F8:EE_
X-MS-Office365-Filtering-Correlation-Id: cfea42ed-daff-407b-2e20-08df1e50b082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|56012099006|11063799006|4143699003|8096899003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RLUFpCbanSoO9+aawAI7MyLCeOPyZ0C8lycjbFwEud+1t8G/Waf01Zi5MV00KAuGdVbi1wR9nO36L5/DduLcByELoUiGLwk5XhRhGeDklE6U3ND2THLetv3U/JhpGBu2qB+axt7AYGmWxGcrCXXzhdpkv7vFlS/jB+CK1HaKKXVEs3ifooXrpURTfS+L8FQXIek3jfLaDx8WJKbwGUQ0K71bl8E6IwAKS6NTxoItBW23m+W0Jxn4d+MZbgdUn8tcB28UL/DN+ckkggwsj6Eg1k3rTteFfPWMWGv12MalmrZUEUlRq3Q1ZaPL9/OpzNFBX1qBodb1BBPeoF3kc3BKKzKId9mvlHfM0IIeO738+I6b0az0/VUUGMWekwqwmeVuosq9SomVBsSBIIUAV3GoH4ATIMvCw+aCzX7fxffNSGE92zAEJm0vgoDyt07Tb55hURs0hG5xhYrt4ofLLOX12J/NFMByurw28Vzf+rFkpv+LxdDdYwu3GzHl5r1NEpwmEnaeBFKWDx+FlLywwesqy2fZ6Lq2joRoqTQWtpNgoECTmjbSaYOqjm5dUypr54Z4qkkk/vap4xOxWuE8x89Q8J8z1KRqpOtJYqhsbyIsTlMtO9v00lPR5aO/P6yvYqoph8AWlBNGhNdHnPrUFjwaEZDdZeL3Cz7jw9fOJ83J4Mg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(8096899003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnEwM1NZd2xSb3FYRkxWbTU3VVA2VG5HbUNEOTFxdzRFbkpzbmowZmVZU0lQ?=
 =?utf-8?B?elFWOHR4ZVVpUzVZYTY1SDIvT3NvQTBtV0JqZnZJU2hXSXp2MUZmNXk5c25L?=
 =?utf-8?B?ME1HQkNzck1GNk5pcWtiSGRYQ0c4bHdLQ2RCdVFUWHYycndUMEgxS2x3NHBp?=
 =?utf-8?B?U0plZDZFUWp1Z05yUnpRN2h4NlovaXJoU1RFeTJrYVVYQXh5QXFnaVpHaXVh?=
 =?utf-8?B?UFZ2MkxyRnFGN1dJWWIzSnhXQ3h5RXV1ekpiWDNpOFo4TXJzUXZEVUZkNEhV?=
 =?utf-8?B?bHV4MWZ2QVUvdVJkSjJLT2I4MXlsMlNGa0FRRXFIODNWOXE2N1RyeE5VQWx5?=
 =?utf-8?B?UmFQU2hTbXRxeHYzR1lkeWdCaHU4ZHJZcS9nMHdjWFVDeGJ0SGh5TFpmYTh4?=
 =?utf-8?B?UVV6VFoxNmw4c0NyV1NrRGlib2l5cHFQSUx6WmIwcjE1YWZsUER3aERyRUlq?=
 =?utf-8?B?dDJTb1NIZFF2SlFSQUxwVm9qK0lzNTBaRjY3eXE4YnEzSDFDMWdaR2x0V0pX?=
 =?utf-8?B?dHc0MWd1ejBpSEF1WnlJTElqS3l3RDZDVjZLanVMMzNhYUhLVVMwZkE4MTZW?=
 =?utf-8?B?Q2JjaVlwNGVFSE1OWmNiUlVGTzk2dmFVUjBIdkhEbnNKN294R2J5VFhVZi8r?=
 =?utf-8?B?KzJVemE1NjVZdUsxV0gySFlxdFowSE5IRmp4NXlvQ1YwaG5MSW02VGxqdytX?=
 =?utf-8?B?bmhuY3JkNXRhWVVpN0pLdUlMdnpPbGlEUFZVcVNIR3dqQUxFaS9TcDhwUytP?=
 =?utf-8?B?YUt4NjE3RXF4L21NZXlkSkRPdy92UXhzSm9QT3pDUFVpZUNMUlRJS05CdDJY?=
 =?utf-8?B?ckVCRWVmclJXdlIxSmZaNzRsQmZ4UWFMVWNCSzZqeHh0R3F2THV1TEEvTlFU?=
 =?utf-8?B?VjQ5SjRSQnRqdWlmM0NZdHFOZlR4ZHZhUDVSMUVoZGtWejFVQnNGTmVFb1Q0?=
 =?utf-8?B?dFpsNmpBdmpDVzNEeEhqMHg4MjZUYktMVjhWUVRySUZNT3NKMjIzSCtibG02?=
 =?utf-8?B?QjAvaktpbkltY3NBcitNc0xiS3pqdytvRmQ1VldBQkNLWG0xUTNZbGRWZ3lN?=
 =?utf-8?B?elZiaUFnOXZjV2FJeXpSYU9wYzFFNEM2YzB5d3BDamtjdGJUT2JZc21vRlFX?=
 =?utf-8?B?aXY4Z21hYjZQa2R4VEU3NFR6aTIrSm5Za1BwSlBibDhlc25zb3JRK0pHTDE4?=
 =?utf-8?B?L3o3blhrSnp0SFBocjlKV055NTVoRlJLdUJhajVSVmNzZ0tONjRHUXpUbThT?=
 =?utf-8?B?RnpvbHA5U1ZnbGdZZEQ3cU1xVHZhazJtOVdvSS9iSHJSUU1mdmQyWUszMGJH?=
 =?utf-8?B?cjF3M21LUFdBbzg4ejZLYUpmZHlnZVdHR1BpNmwzQlc1bEZUcy8vUjJCNzhj?=
 =?utf-8?B?SDBJQWc5SlhqQTNESGEvY2Flenk3QVlQbktUaGhqVUtLNWEzcllvbkJLSThX?=
 =?utf-8?B?M0FHQmgxMXowcS9sQnpKOWV4SjdOeXNkQldleklOSkhjb25IRmtFVG1rbUxE?=
 =?utf-8?B?REs1aEZpaUw0Nm9WcnVydGVYcGxsR2llQnY0R1JYVTJrekc3RGp2Y3Jyb2Iy?=
 =?utf-8?B?WWhoUzIrbm8xWHpiVkowT2lKYnhIbVVqenQxYkxKd1U3RG9SMmJ0S29VbWNY?=
 =?utf-8?B?cjFUakVKNmRuV2ZjT1N6ZW5oSEZ0N3dheHdrL3duOGFUQUxETUdpMUdkOVpC?=
 =?utf-8?B?THBWSnVNUnNqMDhuN2VjV2J6TlRmSmk5VGgwSlJybmd2aC9TeW5GdGhZOGtx?=
 =?utf-8?B?Z012enI5Zi9IRjA4M1lmTE81R1lvbUpidEl6eEcxSkFnWjdybEtnL3phd1FP?=
 =?utf-8?B?ZnBwWHBmOFR0NGVYNWRldmpiUE5IbVQ0K3FiZE05VmRzMDNBWGh3bmtUemEr?=
 =?utf-8?B?aWtGZjdrSFgrdmcyTXl5aEx5eUlkWE1FcVlodGUzdlV6YjNvQzJ0WkhzWUlP?=
 =?utf-8?B?OFNZc1J1c0xHNHNqZjFFaFhabWdjbmtWS3FrT3VNdjFXYkFxcU9ZcVNHSDRY?=
 =?utf-8?B?VE9vekpnVzRPckxKbEExYXI1aXNaaXgvQjRpbjJWS2o2NHAyYWtsVThENHQv?=
 =?utf-8?B?Z1RxVHNPZTZGdFpnUTd5U1FkN2RQWFAvbngrQ1lEb0RTT1EyczNOL0N1SElv?=
 =?utf-8?B?VzhjcU56K0dsd1RyeTVzbnVPYmpIN3ZqckhJbkRlTHNBd2JHSGVPNm5tVkhu?=
 =?utf-8?B?d0JyWDB4c2lpeGhXZzFqWW9QUkZ4b3IzRzdRcFc3ZkZQdS90WnY5Wjd1RWtY?=
 =?utf-8?B?cEgyMU5qMGdlRHVLR2RNeDZScHB5cW5WRmE0cXlMQnZqWEJTdG1FRnRXZmJw?=
 =?utf-8?B?VnVIR0xNYmRlNzl6b1dqNVRIcSt3NmJWK1JQdkovRmhrQ1R0SlllZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfea42ed-daff-407b-2e20-08df1e50b082
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:40:02.1202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6vMvkLdCmcTk7dzXP99uM/hTxmyF/2EOgBzEmmdWccfJC0RPgP7U4HO6mah15y/RAek8ApBT+7Ww/wyOVwscw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA33D606F8
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

--------------mAWHaF9d8O2A0mTZv3GxAT6U
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 29-09-2026 05:24 pm, Christian König wrote:
> On 9/28/26 20:57, Sunil Khatri wrote:
>> The SPM (Streaming Performance Monitor) path needs a VMID that is
>> isolated from other GPU contexts. Introduce vm_manager.spm_vmid to let a
>> GFXHUB dedicate a VMID to SPM.
>>
>> When spm_vmid is set, remove that VMID from the MES user-queue mask and
>> from the KFD compute pool so that neither MES firmware nor KFD ever maps
>> another context onto it. KFD derives its VMID range from the shared
>> compute_vmid_bitmap via ffs()/fls(), so clearing the bit there is
>> sufficient and needs no change inside the KFD subsystem.
>>
>> The field defaults to 0 (unused), so this is a no-op until a generation
>> opts in by setting spm_vmid.
>>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 ++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 3 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     | 2 ++
>>   3 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index afcfb92fb9f5f..71e47bdf11393 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -207,6 +207,10 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>>   		for (i = last_valid_bit; i < AMDGPU_MAX_QUEUES; ++i)
>>   			clear_bit(i, gpu_resources.cp_queue_bitmap);
>>   
>> +		if (adev->vm_manager.spm_vmid)
>> +			gpu_resources.compute_vmid_bitmap &=
>> +				~BIT(adev->vm_manager.spm_vmid);
>> +
> That is quite a mess.
I dint get that part clearly, i am just taking the bit 15th off the 
bitmap... Any inputs here ?
>>   		amdgpu_doorbell_get_kfd_info(adev,
>>   				&gpu_resources.doorbell_physical_address,
>>   				&gpu_resources.doorbell_aperture_size,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index 22ecb70fec2cd..afb56a2f9672b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -134,6 +134,9 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>   	adev->mes.vmid_mask_mmhub = 0xFF00;
>>   	adev->mes.vmid_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
>>   
>> +	if (adev->vm_manager.spm_vmid)
>> +		adev->mes.vmid_mask_gfxhub &= ~BIT(adev->vm_manager.spm_vmid);
> Please remove the vmid_mask_gfxhub field from the MES structure if possible and move all of that into adev->vm_manager or adev->vm_manager.id_mgr instead.

you mean both
     uint32_t                        vmid_mask_gfxhub;
     uint32_t                        vmid_mask_mmhub;

To be out from mes structure and move to adev->vm_manager->id_mgr[i].
The reason I think they are part of the mes as they are only use in the 
mes related files even if they are vm related fields. Whats your suggestion?

>
> Regards,
> Christian.
>
>> +
>>   	num_pipes = adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
>>   	if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
>>   		dev_warn(adev->dev, "more gfx pipes than supported by MES! (%d vs %d)\n",
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 0f6634b749746..57070da337750 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -414,6 +414,8 @@ struct amdgpu_vm_manager {
>>   	/* Global registration of recent page fault information */
>>   	struct amdgpu_vm_fault_info	fault_info;
>>   	unsigned int				npa_vmid;
>> +	/* VMID reserved for SPM, 0 if unused */
>> +	unsigned int				spm_vmid;
>>   };
>>   
>>   struct amdgpu_bo_va_mapping;
--------------mAWHaF9d8O2A0mTZv3GxAT6U
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 29-09-2026 05:24 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:761b532e-8b5e-4929-9526-5d7a55213a88@amd.com">
      <pre wrap="" class="moz-quote-pre">On 9/28/26 20:57, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The SPM (Streaming Performance Monitor) path needs a VMID that is
isolated from other GPU contexts. Introduce vm_manager.spm_vmid to let a
GFXHUB dedicate a VMID to SPM.

When spm_vmid is set, remove that VMID from the MES user-queue mask and
from the KFD compute pool so that neither MES firmware nor KFD ever maps
another context onto it. KFD derives its VMID range from the shared
compute_vmid_bitmap via ffs()/fls(), so clearing the bit there is
sufficient and needs no change inside the KFD subsystem.

The field defaults to 0 (unused), so this is a no-op until a generation
opts in by setting spm_vmid.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index afcfb92fb9f5f..71e47bdf11393 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -207,6 +207,10 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 		for (i = last_valid_bit; i &lt; AMDGPU_MAX_QUEUES; ++i)
 			clear_bit(i, gpu_resources.cp_queue_bitmap);
 
+		if (adev-&gt;vm_manager.spm_vmid)
+			gpu_resources.compute_vmid_bitmap &amp;=
+				~BIT(adev-&gt;vm_manager.spm_vmid);
+
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That is quite a mess.
</pre>
    </blockquote>
    <span style="white-space: pre-wrap">I dint get that part clearly, i am just taking the bit 15th off the bitmap... Any inputs here ?</span>
    <blockquote type="cite" cite="mid:761b532e-8b5e-4929-9526-5d7a55213a88@amd.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 		amdgpu_doorbell_get_kfd_info(adev,
 				&amp;gpu_resources.doorbell_physical_address,
 				&amp;gpu_resources.doorbell_aperture_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 22ecb70fec2cd..afb56a2f9672b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -134,6 +134,9 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	adev-&gt;mes.vmid_mask_mmhub = 0xFF00;
 	adev-&gt;mes.vmid_mask_gfxhub = total_vmid_mask &amp; ~reserved_vmid_mask;
 
+	if (adev-&gt;vm_manager.spm_vmid)
+		adev-&gt;mes.vmid_mask_gfxhub &amp;= ~BIT(adev-&gt;vm_manager.spm_vmid);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Please remove the vmid_mask_gfxhub field from the MES structure if possible and move all of that into adev-&gt;vm_manager or adev-&gt;vm_manager.id_mgr instead.</pre>
    </blockquote>
    <br>
    you mean both&nbsp;<br>
    &nbsp; &nbsp; uint32_t&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; vmid_mask_gfxhub;<br>
    &nbsp; &nbsp; uint32_t&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; vmid_mask_mmhub;<br>
    <br>
    <p>To be out from mes structure and move to
      adev-&gt;vm_manager-&gt;id_mgr[i].&nbsp;<br>
      The reason I think they are part of the mes as they are only use
      in the mes related files even if they are vm related fields. Whats
      your suggestion?</p>
    <blockquote type="cite" cite="mid:761b532e-8b5e-4929-9526-5d7a55213a88@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
 	num_pipes = adev-&gt;gfx.me.num_pipe_per_me * adev-&gt;gfx.me.num_me;
 	if (num_pipes &gt; AMDGPU_MES_MAX_GFX_PIPES)
 		dev_warn(adev-&gt;dev, &quot;more gfx pipes than supported by MES! (%d vs %d)\n&quot;,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 0f6634b749746..57070da337750 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -414,6 +414,8 @@ struct amdgpu_vm_manager {
 	/* Global registration of recent page fault information */
 	struct amdgpu_vm_fault_info	fault_info;
 	unsigned int				npa_vmid;
+	/* VMID reserved for SPM, 0 if unused */
+	unsigned int				spm_vmid;
 };
 
 struct amdgpu_bo_va_mapping;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------mAWHaF9d8O2A0mTZv3GxAT6U--
