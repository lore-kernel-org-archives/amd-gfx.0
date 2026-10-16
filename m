Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADCACCA464
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 11:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E39AE1127AD;
	Fri, 16 Oct 2026 11:43:27 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011063.outbound.protection.outlook.com [52.101.57.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A71611127AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 11:43:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+9vCcEenNB+x0jYRFrM2WfQUG0WLdzhaTw3oqbY3jqZm8KKJbJYlApq8WuQ7PIpoXo4cOGTzjhtWxKYkjGcGIE7iWrEPoJZqxvirTqhnp9LW1Unp9u+u7HxORCJAmiKSDDU12vy77k5rV1nIIKp3AhbEEYJGeWA6IKIYEfbI66XoUh1zrLpUZIZmnYCmceiCSJZf+OhWfnFtF3gGsSsW756MYQ/mZsQGYF0tHOjld91oB2GhQyCGKu9qY+G7YK3LnDNG8OSiYTm7sp2in4/EQWDMjUq5YSAd01RRQwyYXPmb1Qfm4cptc9I51A3zMrSAa32Yk8W3U6CniI4PMjNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2unxHJdShX9oldzMu91CakzqEYRbEM2zNYPAr9PPrHs=;
 b=u8EKgqiHNgBOl2yWKhATq703lHdkDIS8AceZmaLrFHnsTb2MiuFUgkOodI6Q/FISvLtSKfIaqyJAWSTKRbvG2FrfBCg9MNr3Jpz/0m8zI+Oe6glI7LGeie3MP3SN07Q5d7niODLhN3mJQD9wyl1GTcN9tbP27QyRPAVlA7G8/FkhgGryN4tPnchoUKFhIWp+kbSRCN4agveEvXw4QFUHXMlO63HFF/6n2newsHc0CWwyfAmhuOkC4wL3l2ViPyzaBSqpWS0FhD7IHE4pJVVPSot3ZBp1GIJiUWIrOYqB7qFcqdO2QH3ntCiuHmwzNSzczhhry3I8LAc4VtoksJCywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2unxHJdShX9oldzMu91CakzqEYRbEM2zNYPAr9PPrHs=;
 b=JmOAlalh9hbql2LPesJn5Yu8InSQODrcSAwIoe7h3K68rjpGtQ90rRp6ekSDEMPYDnKJ3brPZcpDa9KgADck3SPYxh2dWQ9DDss20TYnLUgnsS6LyjKEJ7EcvfXH0G7VC8QS338CPh8ifRBYZpzcWUqb7AcgfjvaGNqIxUhA+Ks=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 11:43:19 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 11:43:18 +0000
Message-ID: <f261d2de-1d6f-47f2-b637-732fa8bec62c@amd.com>
Date: Fri, 16 Oct 2026 17:13:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm/amdgpu: bind the SPM VMID's page table to the
 reserving VM
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261013112112.1449531-1-sunil.khatri@amd.com>
 <e248e08e-a9c0-4a3e-bea9-ee682eb25be0@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <e248e08e-a9c0-4a3e-bea9-ee682eb25be0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::7) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b55dd48-7bdf-495d-6d62-08df2b7aac40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|22082099003|10067099003|18002099003|5023799004|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: vl1McIdL0UCK4v8XkQPTF20Edv6TjtLRcJ1JR2iUQOsAm1CO23CdCWcGrxlhtTY5KxIBuEJ+SPQ9g0rsdFG0usdXjbcDQ8xDocwSlhDfAf2vXIO8RnpASoAuaP9f5SWWC+0elbQC8SGZRhZOR41zjSHsCWFYa0LeevzBaUQI2DFZIr6DWR++KsWe9Ocdq93lekei9bnGuViN0oEvNY2Pn3475PF3B15DTpUpH/TrrVf/0QBjMPlDbwvZS9M+fVRNEny/0+y7yEpXLuuEj+txHY20EoayiBbiUWhVabdtxn7LlljCXZVaIX98t6RABgkLmPUIyHc1fMhJQA93CELb2Dirx4Ps/PeiAVOf2V+dF0oF0vRcOB1y9ajNaYlz/o48gKBDw7ImVEARXClR4Bu176lh2YYrJvRH2tbvAsQlZXKRfo+aK+O4mQ6U/MJr6Kx4oxgyRrTwkXnkwU7PqDL54Dk7vX3Fpq1dunDho7g7QCqAP5DmgDs8ocHtUWpbdf93i3Z/ETMFpfwY4kS79t/8nKooSP7kmC+PhnRRQY5ZRIc4qZ12LOz0Jbh7WYvy1epSqkBCd7b8v1o5jINbIl7fPU3KwuHaIM0rfcLBSg25TiFerT1AKDAmbvIdvWxzabSINNQP30U/sF7oLMOH5CuqNV3eObENcsjA9O8sINKmVkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(10067099003)(18002099003)(5023799004)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTBTTkI2clQ0UHhYRlVLUmFNYVNOTUIwU2REbWgveGRDTFQ5QWQ0MkV0NEw0?=
 =?utf-8?B?U1NKOGtoUXN6TUdiVWFtS05PNEVzTndTeVh2TXhZTWFIRUVFUlJpK2IyWmJT?=
 =?utf-8?B?cSszUXZ1ZUdxajJtYmFOQ3ZvTXVpeW85blhFZWIxS0dvYk1MMWF3TGJCZElE?=
 =?utf-8?B?V0czb2tLL1lOQVhRVTZUOGFuUDkyeDdzd2QyS1VpT01YejdnK0R6VWJONUto?=
 =?utf-8?B?aDB1K0l5WDJMVllMb29OTm1vY2s1Sk1sL0ZBU0JNZk9lSmRmcEV3aVhuNlg4?=
 =?utf-8?B?MUhMQitqeHM4dnFtUW5hUW9WaHMxWmRlNUVjVGNabFF1c0dxRm5YbW5DUE1G?=
 =?utf-8?B?UXZlUGdLT0c0Y2tKRVMycENaZFFVczNrSnJGSHdpM0d0NHpFam9Xc29DOTVV?=
 =?utf-8?B?MnRtSDgwMlE0NHdneHZpY05LcnRnZXFkcHI4dU1LeUdaYmtwSGd6U1VXTmV3?=
 =?utf-8?B?WGlTQUJiTWEwVDhmVGFYektlSjJRUzJBNFcrVSt3Y2hiN1lFaEVXeWw0MFpS?=
 =?utf-8?B?UjJkMm81K09iUFBMT0ZrQWEvVWNjRExOS1p6ZlBIMnIvU3R6MVowN2gvOXoy?=
 =?utf-8?B?REk0aGZKSTUwUXNQTWhMR3RTS3VZOURlc1A1cDd2MEdsa3VlTEVNK2tScjdn?=
 =?utf-8?B?MEdyWGIxK2IvQkQ2Y2grek5VSkxpcDVodExEY1prTXMxNUV0dFlNbWpaQ1Bj?=
 =?utf-8?B?NXlOV0lVT0x6WENqSnFXREdWNFloQXJSaXJ6ajlXOVcvOVhiaklPTEFSMlZp?=
 =?utf-8?B?WFJWRitHTkM2dEE3Y1ZQLzdHZUY2anlvOHVJRmVRN3JhOWwreEFtQWxucVBm?=
 =?utf-8?B?S2JMbHArN1ZyNW84bGJ2SEUxOGtGejZSKy9HNmdmc25sWkJlU1luMGhDQTRO?=
 =?utf-8?B?VDRHQmRnUXlaNFZZY3lUTXd4ZG1nQjFtbUpCNTZxdW83dkxzZHdPNTJZYVJw?=
 =?utf-8?B?bE9kK2tmTlZDMksvVXZzSjdDRU1jQThjSU1rWllaY2FDNFVRMlZ0VEwzNkJQ?=
 =?utf-8?B?b2NYYk85bWF5b29GWjVKU3owTjY3WDlaMzY5RmNvWC9XV1R6a0N5Mzl5TmNR?=
 =?utf-8?B?anNzQW5uMnErcS9oN0JtWHlvRjBpSzFQU2g5ZWg4VzVneDB5ZTFpVjNPYjRp?=
 =?utf-8?B?WTM2UFpaSDBtUDV4R3lxOTg1MnlOQnRRdkN4UkZKTVpsc2luUEhjSDZCTno4?=
 =?utf-8?B?TnFUUFRMRFBnQkxCd09KeVJHaDd2UDZTUC9YN3J3OWhRUEduTi8zWURwcXhq?=
 =?utf-8?B?bm41WStRVVlpT3Q3LzVBaGlQc1NoRU5VUnVrUUhSbEpIdmNqeDhSdENGWDYy?=
 =?utf-8?B?V2wrcmRtSnZBV1hGaU9OSmtZWjhlYmJlS2RvUVozZnNRVzdXaVpLVWJIOGZ3?=
 =?utf-8?B?S2RLbVYwQmdOaUlhRUNUSXFrZzFQYkQ1VTNjeFJKZXRIZzN0K3VSKzdhUXJN?=
 =?utf-8?B?MlRUUFllSWpiNDc4am5YYXNPbUcwTXYyMExKT2lzOTk5aDlLWkxaVktFTDRv?=
 =?utf-8?B?dU9QdWx2QU1kZTRsd0RVNTJkUlgybXMyNkczTS90dWZSTFNiZXR3cjEwZTRQ?=
 =?utf-8?B?QXdyWWNwbFBzZFJ3S1RkZC9NQ3JoU0lwVlhURGJYK2tWdGNJU05QSXQ0MzlN?=
 =?utf-8?B?SHhjdm9mdnYzQXRDUjV3OFA4WGJFbDFURVdPWEEyTG0xK0F1TDVSRVBGNGRq?=
 =?utf-8?B?RUNwYjU0bU9acjBMcWhKNGhWa2oxSWVYNWtZQm1pYTlOSG52UGgwaFRNa3p4?=
 =?utf-8?B?UVZYb0hMbElTRzB6ZHpLTnJpOHBRaEdPZlFGTW5vajY4V1hqWUczVDZ4emhV?=
 =?utf-8?B?OXQvS21GRVlZTXBWR1huNXBNMUhzNE1sUUhSSE5mL0kxNDZYRkhWR2tjZU12?=
 =?utf-8?B?QU5td3ZOUTMxZU0wWTV3UUxndFlwT1FBM2ErRmRUcmt6SXJCYTluUmVyY1Jo?=
 =?utf-8?B?emNaRW9yd2xCejI3b1g0ODdVc0R1Rk4vY0hOWG14WWJkKzcrT1ExR1Y1b2hV?=
 =?utf-8?B?aHhHSC95NUkvcGZ3bUE0VTBSMndPUzlucEpVSHA2ZXJqVmNhSVpPdHBOdDlO?=
 =?utf-8?B?cjNBRjVIUmcwRVVDM1pFK2hkTm5xR2YzSFAxZDJUWXBuY2lTRzk1Tm15U2Zz?=
 =?utf-8?B?MzVoVjcwei9vZERiY3JIZXJ1VEVIVlJjUkJzc1FUVU82dmhaSlNBeERFekh2?=
 =?utf-8?B?UkVWaGYrSm5DWXBlRXJyT3ZzRjN0eDJ6amg3RHBuUTlNdWZTblpad29vS0FS?=
 =?utf-8?B?NHFUSVJkMG5idlB1ZHllWUR4ODExRVh4cENnTHFFdXpNQ3pRY1FyNEdIOVV6?=
 =?utf-8?B?WDAxRHZNelZXZ3RBNXE2SkVXUXg1VksxejJBdTVvRzhaRTJLUU9NUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b55dd48-7bdf-495d-6d62-08df2b7aac40
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 11:43:18.8935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZjpcRn3/a+EY67QE5//BJ75onY6N6LnYsV98P/CWt/Lev4ERdg6zeI2+TsUOJR5L3rua4VRgzOoiq22eG3RHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833
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


On 16-10-2026 05:03 pm, Christian König wrote:
> On 10/13/26 13:21, Sunil Khatri wrote:
>> MES userqueues bypass amdgpu_vm_flush(), so a reservation granted to a
>> userqueue never got its VMID's page table programmed. Add
>> amdgpu_vm_spm_update() to bind the fixed SPM VMID's page-table-base to
>> the reserving VM's root PD when that VM holds the reservation; it is a
>> no-op for every other VM. It is called right after a successful
>> AMDGPU_VM_OP_RESERVE_VMID (amdgpu_vm_ioctl(), under the root PD lock)
>> and from amdgpu_userq_vm_validate_and_restore_queue() (already locked
>> via drm_exec), the two paths that can actually change the binding.
>>
>> amdgpu_vmid_free_reserved() waits for all work that used the reserved
>> VMID to finish, then unbinds it to a dummy address under the same lock
>> that clears the reservation, so in-flight submissions don't suddenly
>> fault and stray SPM accesses afterward fault instead of racing a new
>> reservation's binding.
>>
>> Both binds go through the new amdgpu_gmc_bind_vmid() helper, which
>> pairs setup_vm_pt_regs() with the matching TLB flush for a VMID bound
>> outside the normal per-job VM flush path.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   | 24 ++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h   |  2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c   | 13 ++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  7 ++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 47 ++++++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  1 +
>>   6 files changed, 91 insertions(+), 3 deletions(-)
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
>> index 074c6942d83b0..e5d84a786c4f2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> @@ -633,16 +633,27 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>    * @adev: amdgpu device structure
>>    * @vm: the VM with the reserved ID
>>    * @vmhub: the VMHUB which should be used
>> + *
>> + * Waits for all work that used the reserved VMID to finish before unbinding
>> + * its page table, so submissions still in flight don't suddenly fault.
>>    */
>>   void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   			       unsigned vmhub)
>>   {
>>   	struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>> +	struct amdgpu_vmid *id;
>>   
>>   	mutex_lock(&id_mgr->lock);
>> -	if (vm->reserved_vmid[vmhub]) {
>> +	id = vm->reserved_vmid[vmhub];
>> +	if (id) {
>>   		vm->reserved_vmid[vmhub] = NULL;
>>   		id_mgr->reserved_vmid = false;
>> +
>> +		amdgpu_sync_wait(&id->active, false);
> amdgpu_sync_wait() intentionally excludes userqueues (both KFD and gfx). I think that is fine here, but we should probably add a comment.

Yes, in case it goes with kernel queues. I will add a comment that this 
only waits in case of kernel queues only.

Regards
Sunil Khatri

>
> With that done Reviewed-by: Christian König <christian.koenig@amd.com>.
>
> Regards,
> Christian.
>
>> +
>> +		if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs)
>> +			amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0),
>> +					     adev->vm_manager.spm_vmid, 0);
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
>> index de992405ed718..7fd6215510a94 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -568,6 +568,41 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
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
>> + *
>> + * @vm's root PD must be locked by the caller.
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
>> +	    &id_mgr->ids[adev->vm_manager.spm_vmid] || !amdgpu_vm_ready(vm)) {
>> +		mutex_unlock(&id_mgr->lock);
>> +		return;
>> +	}
>> +
>> +	pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
>> +	amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0), adev->vm_manager.spm_vmid, pd_addr);
>> +	mutex_unlock(&id_mgr->lock);
>> +}
>> +
>>   /**
>>    * amdgpu_vm_validate - validate evicted BOs tracked in the VM
>>    *
>> @@ -2958,9 +2993,17 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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
>> +		if (!r && !amdgpu_bo_reserve(vm->root.bo, true)) {
>> +			amdgpu_vm_spm_update(adev, vm);
>> +			amdgpu_bo_unreserve(vm->root.bo);
>> +		}
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
