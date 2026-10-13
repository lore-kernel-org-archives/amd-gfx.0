Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37A7CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD4B210E77E;
	Tue, 13 Oct 2026 11:11:28 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AC0C10E77E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:11:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBbWwUWl87UzK1imDCRTjrAVV9avVkiqqDjXS53cLAStGdECvt9gu54KhGhBsGBEXOFyL1DOXAae8oM/dZU6RLQufaGPTr2tEehC83ofa1tLpWM+5X4zFzNOcGxEWZn7PtYcY7h34scy4vMtg9btKwG+MGnnLH1klwiQVFIFZUvZBSpIHluq6ePoD36/9DvYgXmnXROWNJN6f06uSgnxTHuUg09YW5s43vTsDjbEUGh4P3f8vACZirlG8bO4J1TqdGWPvcluxkqvjxx2cLagTaqpiRx/W3wbTJT7wkmHzYGTN4XKp8IX2sQlopYH+YO4u3RGarbqGiPdgJPurUyz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpGT3UuYPNguPgfNmLjMFQ4ZneQ+iIY2JnVFpcf1IeM=;
 b=Zbb2rl6oz2WyLGcIyBoBPs6cbDQ0g9AGav+DYS0rmAELa2HdCJeXC05J5GJERFck4Xp8c0WmPEHfhrJRW/D9GSZZeUiVqeaQrvCOSYbPZSYVcx692L+wujwP24W7xBvx9ocissl/Tg9rrVN6h6GTOTqlNrtQBHCKLuPW4uMhG3gxceamrvQgfGFtr+HTc/an0eKx0lZKvAGNfjYiyvb5DRU6IJvzwp7UjjW/cemdhgOWDk7UPKbqFeXT8PxLrqhAc977HNC/4ggsg14tGboQ/6FZ0krPIKEKnWw1qWh+Qu5ql37GlTuIkjeyiWIbub2cy+dkOOMmwklCwSCeDwGL4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpGT3UuYPNguPgfNmLjMFQ4ZneQ+iIY2JnVFpcf1IeM=;
 b=xpgPK0rThhRGpAbos5fhAi7JJpRDyz0cYozfcmrqzR6kgG+4lQhlc4PeuYxTwQQCX0ExXzHWAd2gibe6oi5HbbMEtqV/lb52UcrkZULM2xxGE2AK+JzXutbE/EZ9rHXdjwSPjwEWbMmmY2CDHPVBeV9FexTNcrjoJ755pIRIsZ4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:11:13 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 11:11:13 +0000
Message-ID: <36750b20-5587-4180-af55-d348eab17a69@amd.com>
Date: Tue, 13 Oct 2026 16:41:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/14] drm/amdgpu: bind the SPM VMID's page table to
 the reserving VM
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261013084937.972181-1-sunil.khatri@amd.com>
 <20261013084937.972181-13-sunil.khatri@amd.com>
 <070288cd-6e11-4477-ad0e-c6ce061ec362@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <070288cd-6e11-4477-ad0e-c6ce061ec362@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0112.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::15) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: d32c9ab0-1950-46d5-b828-08df291ab14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|10067099003|22082099003|11063799006|5023799004|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: HSWXCaFbfeg2AEu6vvccoBzx6IH/AYCiObzbxE/So6XapFyqMUVOfiImPdrtiuXdvx5lZ2uCnA4nT5x2wx9xHrmCLyaOWvDQ0+W8mfuKHnjJFy3i2mn3pK6kxNUUV9OUCIDRZI6ShVyEGjcVmAD24DpvV4o1b9uRZ0O8QGNLTbP8ABYIIQQbyTbyDLr7xFRr1LRjgsh0Uy7joqbOgA2sfsLYr5vn2gIvy6wQDVSM1521CP5xRs26SUbu/n1G5S75VDDfKRCJ78c29DelX3eZKKdoGy7zhQ8xoQ48df5COk9XYs5nQaMxtL+WdXAeH4WspwNe8TfdidX7UxCUQ88zBCE7bB5K13ERPNK/wE3TDsdEY2dsXq/keHpRpcheh2R0RR3uc3NsQA7g0aQoxJJHDhsdAJxtKFhTfFrlJHuWVKYONwtvKKXU0+LYNRLOYwVRV8GWIv4lgcepdzeus1ojLkiSIr3eo16FrJUPCmvnvJA5+eZch2PzYBwBBCXkItP5ogvGWpGhOGzd65EofwWYc7aSckPi4NjRvoa25/wQ/rZmjZNb6iiZb5SB8OU8RFtf2tqsXOndFZemJVdgLE4ZZzy4EAAZuImj/EDiYW3EpSjoZhs9QQej+eUt9/niLZH/DDb5h7ZQoVDhcM/A1eaF6Gv+Td22vy36WJMSggdaJOk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(10067099003)(22082099003)(11063799006)(5023799004)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnBlUUg1Y0xVU0V2bDUrek44TzF1TmtFeHhCamtmL09pUFhUOEt1eW9HUlNN?=
 =?utf-8?B?bEZuYVcweFg1MFJtK0VHK3NsMld0OHlzYS9EdmZyQTh6RjREVmtxeEU5ZHJx?=
 =?utf-8?B?c0l1eTZSWThuVDAxb0owK2lUNXVnN1g0YWJQdnZsM0JHWGZON3JJbUVndXlq?=
 =?utf-8?B?Tkd6Sk9IbkVtZnRQOGJ1MkVkbUQ5RlFLYVc4SWlHL2QzeUxiMHFFVkorMkxj?=
 =?utf-8?B?dDRGU2xJZ3kxQVJZZS8yTXFSWEFOc3NzcUdqYjFUZkNpT0JaNStYSHQ2V1la?=
 =?utf-8?B?SmdoZVBsZEMvRjBIa3J3VmVqMkQ2c2RSRk5uUmpPOTI5SS9HVjZCL2NWVDJk?=
 =?utf-8?B?ckhHTUk3bTV3RlRObUM4NGZiZ2FqRWt4R0VvWW14a2RZQ2huNmRUUjdFeHFs?=
 =?utf-8?B?TzJzVmpKSmtOa1kxKzZzTCt2akI3Z2FKWGdNQ2dIVVE2QTlrdFFSeFRiMGdl?=
 =?utf-8?B?cy9FV09WNkg5NnFKTk50Tk1WeHlmcEJNdHhnTmRyck1hd2x4MkQwNHlKL1lo?=
 =?utf-8?B?eXJyblRkU082dXgraGVMM1E4NUg3ZmZxSXBDaTdhOTN5VTRpSWNnckI1d0tj?=
 =?utf-8?B?R0NJUmRqMnhVSlFUbVBaOXhOb2tzdnJ6NDFWMTlZMFVYOTEzSFEwSUV3UmRh?=
 =?utf-8?B?cko4Z0tVY0RTeFZTakZKcWZUNHpQTzVKSHhaMVhUbGZhNDFvZWpNWlI2ZS9L?=
 =?utf-8?B?UEVYY3dlR2VYeGJLZFVWTS9lMVF2UzNocFhBNXdhN0dGV3dYWmtRM2s3WGJs?=
 =?utf-8?B?SXAzYWhXTHJMM2FDS3M3OXhyRUF2dldEZWNIL2dTUWZxZExNNTNjaXlMT2d3?=
 =?utf-8?B?QzlaYS91KzBaOWMyYkNmS2t5TEdCakY0d3hTNEluR0RvZXpOUzZjR1hBZGlj?=
 =?utf-8?B?Qkt6SmRmcGJxNGJneXY1SnJVS3VrdFNObFB5Q0NnOVRIVUhEQTFpMWM0WC9F?=
 =?utf-8?B?TFBuQU1WeDVqU0thNnZicS9qdmRTVXdab1JCREdmMWJxSzVMS2oyOVd5MDAy?=
 =?utf-8?B?eHd5QUphNkh1bG5XQ0FtM3dDSSttY2VQRkdZQTVVTm5Wa3g4TXBrTjNjcHQ0?=
 =?utf-8?B?M3NubUovWGY5cm9QeDFYbWNRWWk3YXBmRk5EQ2lqY21uQ3ZLNXUzb256d1lp?=
 =?utf-8?B?T1Z2RFN5OXl1cyt1UW9ITG9YR3RpYnNJamtuWWNpd2ljZmsxV0ZoR0RONnlu?=
 =?utf-8?B?czQ5VDg1T2hWdHJRNnhUSCtNNXdUSi9UQlRHY0ZRbXA1NlNNSDB1NGpvMEtt?=
 =?utf-8?B?M1pPbUdkSEdyWjhnb0JTaS84WUdVTHY1N3QxRmY4UmRGemg3NzZocHp6NlNX?=
 =?utf-8?B?dlkvNjRBQlB0ek5jSU9yMGlucUVBeXpFU1VuM3MxRWtENENNSXVzRm5pVlVB?=
 =?utf-8?B?Z1ExSnhaeENjTlA0ekNobFJXNHV6WW9NbXZBUjNhZHZJYjJsM2ZMYm5hRk9H?=
 =?utf-8?B?ZnM0eFdFeFFHa2lKdHRPRW5ycWVpYVZ5UDNzMUQrM0tobjM4TlRIU2pzNUIy?=
 =?utf-8?B?UEo5c3NTMlRYcHQ4YTY4S2NDaGFCL2l3alZSQWhsR0xUcDdOck9lS2dqbWw4?=
 =?utf-8?B?R1JNUjdHRVdKc1JlL0VYcGVSaHdOdWV6Nk00ZFRNemxYbHlCZmR1OHJFZkRu?=
 =?utf-8?B?WDVRTExDbnB5eFVmUnhEZmdhcnh3Qit4OFd2T1kyTXFYNUYvaWJqWlozK1hZ?=
 =?utf-8?B?MWNwN3FpUGh4VTd1Tm1GcG9rSGZqSCtqWEIwcG1td2dLWGJLWFU2c1dCdVNy?=
 =?utf-8?B?aGt5eDNMN2JTdXdiVExRbGhZMUx0RDVmV0xzVERPWkZCWE03ampjeWtXQnpk?=
 =?utf-8?B?OFVWbGJuNjZVanJKQzZiZlJ2RWorQTRobkp1M0g4aXg2b2JxRzdtVjR6SzRv?=
 =?utf-8?B?cXNXbEVjeDNYck5sekRkbXIvd2M1U3RMaVNvSi9LNUMxTmxyUEJxSDJyOVBp?=
 =?utf-8?B?L29OaEEwd0p5Z3FSK1c2UVNEeUloaUEzakdJMDZIMy9jQkhzL05xRWNsd0dm?=
 =?utf-8?B?V2xEbHlWdzdNYVNaQ2FXR214NTdoVzN3MXJSeGEwSnd0alhjYXR1cWxQS1FG?=
 =?utf-8?B?WFBTcHU1VE9ENjlUWXU2ZnZGeGZCaXF0aURYRVY5VXJveTVManF2a1JCbkZG?=
 =?utf-8?B?NHJSbm1qMFRqcUdpbmt2dkNiRWJzMWVVZE5xT1NPWGhBRnpjOTQ1bGp6MDlU?=
 =?utf-8?B?L0tyVGVuUlZUOXlwSEMrd1NSZHFnWjN0M0FEaFV1aXROZmd4bEVEY1JPMXB2?=
 =?utf-8?B?NHJsbEJtcWZGYWgwajkyMytsdllkRmR2Vmtyd0p0dDZsSUZSSWJ3MXFoSWRT?=
 =?utf-8?B?R2hZSEVWV25PU2Y1RnV5eDZrcHlzaytVb3Fjb1pTRkFWYkZVWDFUdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32c9ab0-1950-46d5-b828-08df291ab14c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:11:13.2736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okaPrpTUrB1YL4lASCvDChHrtgqHl8ptu34QYV+h5hlDcUeMw5alhHssWtOBrYHZJB3VjwBWscivddcDqFA47A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847
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


On 13-10-2026 03:21 pm, Christian König wrote:
> On 10/13/26 10:49, Sunil Khatri wrote:
>> MES userqueues bypass amdgpu_vm_flush(), so a reservation granted to a
>> userqueue never got its VMID's page table programmed. Add
>> amdgpu_vm_spm_update() to bind the fixed SPM VMID's page-table-base to
>> the reserving VM's root PD when that VM holds the reservation; it is a
>> no-op for every other VM. It is called right after a successful
>> AMDGPU_VM_OP_RESERVE_VMID (amdgpu_vm_ioctl()) and from
>> amdgpu_userq_vm_validate_and_restore_queue(), the two paths that can
>> actually change the binding. amdgpu_vmid_free_reserved() unbinds it
>> directly to a dummy address under the same lock that clears the
>> reservation, so stray SPM accesses fault instead of racing a new
>> reservation's binding.
>>
>> Both binds go through the new amdgpu_gmc_bind_vmid() helper, which
>> pairs setup_vm_pt_regs() with the matching TLB flush for a VMID bound
>> outside the normal per-job VM flush path.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   | 24 +++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h   |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c   |  4 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  7 ++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 43 +++++++++++++++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  1 +
>>   6 files changed, 79 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index 5d4276cd0f7d3..4204c3c750a8d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -787,6 +787,30 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>   	dev_err(adev->dev, "Error flushing GPU TLB using the SDMA (%d)!\n", r);
>>   }
>>   
>> +/**
>> + * amdgpu_gmc_bind_vmid - bind a VMID's page table base and flush its TLB
>> + *
>> + * @adev: amdgpu device pointer
>> + * @vmhub: vmhub the VMID belongs to
>> + * @vmid: VMID to bind
>> + * @pd_addr: new page directory address, 0 to unbind to a faulting address
>> + *
>> + * For VMIDs that are bound directly to a VM's page table outside the
>> + * normal per-job VM flush path, e.g. a dedicated out-of-pool VMID.
>> + */
>> +void amdgpu_gmc_bind_vmid(struct amdgpu_device *adev, unsigned int vmhub,
>> +			  unsigned int vmid, uint64_t pd_addr)
>> +{
>> +	bool is_mmhub = AMDGPU_IS_MMHUB0(vmhub) || AMDGPU_IS_MMHUB1(vmhub);
>> +
>> +	if (is_mmhub)
>> +		adev->mmhub.funcs->setup_vm_pt_regs(adev, vmid, pd_addr);
>> +	else
>> +		adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, pd_addr);
>> +
>> +	amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, TLB_FLUSH_LEGACY);
>> +}
>> +
>>   static void amdgpu_gmc_flush_pasid_regs(struct amdgpu_device *adev, u16 pasid,
>>   					u32 flush_type, bool all_hub,
>>   					u32 inst)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> index 76e6f1f96913c..d17055d4c50a9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> @@ -444,6 +444,8 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev);
>>   int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
>>   void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>   			      uint32_t vmhub, uint32_t flush_type);
>> +void amdgpu_gmc_bind_vmid(struct amdgpu_device *adev, unsigned int vmhub,
>> +			  unsigned int vmid, uint64_t pd_addr);
>>   int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, u16 pasid,
>>   				   u32 flush_type, bool all_hub, u32 inst);
>>   int amdgpu_gmc_flush_gpu_tlb_pasid_xccs(struct amdgpu_device *adev, u16 pasid,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> index 992f7cb3a3102..8e60e5fdd210d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> @@ -581,6 +581,10 @@ void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   	if (vm->reserved_vmid[vmhub]) {
>>   		vm->reserved_vmid[vmhub] = NULL;
>>   		id_mgr->reserved_vmid = false;
>> +
>> +		if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs)
>> +			amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0),
>> +					     adev->vm_manager.spm_vmid, 0);
> Yeah that will break the uAPI and is not something we can do. The problem is that we need to wait for the VM to be idle.
>
> Is the VM locked when that is called? If yes we can just wait for it to be idle before calling this.
Sure i will add the wait for vm to be idle here there is 
amdgpu_sync_wait which make sure that this vmid all jobs are done and 
the next step is just setting pt to 0 and flush which doesnt depend 
upong the root pd here.
>
>>   	}
>>   	mutex_unlock(&id_mgr->lock);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index e29823ae8672e..d45357e092bb5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -1075,6 +1075,13 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
>>   		if (unlikely(ret))
>>   			goto unlock_all;
>>   
>> +		/*
>> +		 * Userqueues never go through amdgpu_vm_flush(), so this is
>> +		 * the only place that can rebind the SPM VMID's page table
>> +		 * for a userqueue-held reservation.
>> +		 */
>> +		amdgpu_vm_spm_update(adev, vm);
>> +
>>   		/* This locks and validates the remaining evicted BOs */
>>   		ret = amdgpu_userq_bo_validate(adev, &exec, vm);
>>   		drm_exec_retry_on_contention(&exec);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index de992405ed718..05358e7d81cb8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -568,6 +568,39 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>   	return result;
>>   }
>>   
>> +/**
>> + * amdgpu_vm_spm_update - bind the SPM VMID's page table base to @vm
>> + *
>> + * @adev: amdgpu device pointer
>> + * @vm: vm to check against the SPM reservation
>> + *
>> + * The SPM VMID is fixed (adev->vm_manager.spm_vmid), so its page-table-base
>> + * register must track whichever VM currently holds the reservation instead
>> + * of being set per-job like a normal VMID. Bind it to @vm's real root PD
>> + * address if @vm holds the reservation; otherwise do nothing, since @vm is
>> + * not the one that could legitimately change the current binding.
>> + */
>> +void amdgpu_vm_spm_update(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>> +{
>> +	struct amdgpu_kq_vmid_mgr *id_mgr =
>> +		&adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)];
>> +	uint64_t pd_addr;
>> +
>> +	if (!adev->vm_manager.spm_vmid || !adev->gfxhub.funcs)
>> +		return;
>> +
>> +	mutex_lock(&id_mgr->lock);
>> +	if (vm->reserved_vmid[AMDGPU_GFXHUB(0)] !=
>> +	    &id_mgr->ids[adev->vm_manager.spm_vmid] || !vm->root.bo) {
> Drop checking vm->root.bo, that makes no sense.
>
> Rather call amdgpu_vm_ready() to check if the VM is actually useable.
Noted
>
>> +		mutex_unlock(&id_mgr->lock);
>> +		return;
>> +	}
>> +
>> +	pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
> This will probably cause lockdep to warn that the VM isn't locked, but I'm not 100% sure.
VM is locked in this loop here in exec manager before making this call.
>
> Please double check if the VM is locked here.
>
> Regards,
> Christian.
>
>> +	amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0), adev->vm_manager.spm_vmid, pd_addr);
>> +	mutex_unlock(&id_mgr->lock);
>> +}
>> +
>>   /**
>>    * amdgpu_vm_validate - validate evicted BOs tracked in the VM
>>    *
>> @@ -2958,9 +2991,15 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>   		return -EINVAL;
>>   
>>   	switch (args->in.op) {
>> -	case AMDGPU_VM_OP_RESERVE_VMID:
>> +	case AMDGPU_VM_OP_RESERVE_VMID: {
>> +		int r;
>> +
>>   		/* We only have requirement to reserve vmid from gfxhub */
>> -		return amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
>> +		r = amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
>> +		if (!r)
>> +			amdgpu_vm_spm_update(adev, vm);
>> +		return r;
>> +	}
>>   	case AMDGPU_VM_OP_UNRESERVE_VMID:
>>   		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
>>   		break;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index b8aa45db1d844..2a2a2ccbaa2cc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -443,6 +443,7 @@ int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exec,
>>   			      unsigned int num_fences);
>>   bool amdgpu_vm_ready(struct amdgpu_vm *vm);
>>   uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>> +void amdgpu_vm_spm_update(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>>   int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   		       struct ww_acquire_ctx *ticket,
>>   		       int (*callback)(void *p, struct amdgpu_bo *bo),
