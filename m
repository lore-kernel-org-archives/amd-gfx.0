Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63B6CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 09:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4054510E776;
	Tue, 13 Oct 2026 09:24:24 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010060.outbound.protection.outlook.com
 [52.101.193.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE5710E776
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 09:24:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncZSc6/1eOJOL4Ky8Liw+qIvz53TVFrmp5wgUA6Vzaz8gFF99ANR2RxQov2wjY1sH2LzOZTkv75jL7av8sYIU1yHrj8MqF2RpjNLUrQfgv3WjU1JUCykNKFqNWsbB4RbsbiiED546Z3tp6LzqDDptl/MmWSSg4JzpX6zxbrkK7kzrDVJNFqTOgH2I1pP/LDDwMWM5bywmv0pT43/Wr/GCTzwyGurqlPBfZLHEcX40PEqbH0JvRqSO1RyZ4y2GQQjIzCm3ZxFnBa09/twubqBT53Xk8ZaXIPT6nMJU321IlYa7/mS9OkwXHZDkyrOFLDsl0JUfB8CC2UZ/j4B/Xkbhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pT9l3xMCQ0azh5vtlQYD5sQv2OYivtT6aefIhqPBQ0=;
 b=arI9MVJD3U3ajE2nO7yF7VNquV1cmU6iJPlSFmtneqi21QwtZwSofTeiSpZIkc0rX16oy4AFY1/SlPsqzo6l+XXAvotIK+twZz/OHgJO9fWv4MglS7AjPKd1N3f+37n8udKzsG5tSXzZdKpFnP/KKk285kU4owvUWlUktSDJdNNR9yO8rG/0H12C+Ui8q4iRY8LCpTWWLXJAkUcjQxJ/o7rmOvmWGnAMpfNrUTeOL/2rek86ld4m1yv07Iabv29z2UgFJtQVAknUs3YdpQNDeJ33DxRgUzoCEOifeYntvUGKGaJ8Zew8miprmnYUNrg0+kpoIYeRn2RUsqC2FYlhpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pT9l3xMCQ0azh5vtlQYD5sQv2OYivtT6aefIhqPBQ0=;
 b=MdVWz+FiM+9fTdUise9eP0l3ojsiiur/I2x7eJWxe0RsH37iey5S61Hcej5I5C23Pw+Ev/qd4j3pD/GTAsn+30zIVpb41+qdZ8GU15tlIQcMJjEa3u1Ushyrk5Mxz4zF76PKBm6sAqfypIotWZ5EXA3iNQCWuUP35oBqyHbZDTs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Tue, 13 Oct
 2026 09:24:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 09:24:15 +0000
Message-ID: <2a9ed072-aaee-42fa-b5ff-0cc593a90828@amd.com>
Date: Tue, 13 Oct 2026 11:24:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] drm/amdgpu: bind the SPM VMID's page table to
 the reserving VM
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261013075644.775162-1-sunil.khatri@amd.com>
 <20261013075644.775162-13-sunil.khatri@amd.com>
 <3b271f03-2351-4d0d-91f8-407ec98d28ad@amd.com>
 <55ab744e-b178-4689-b0ca-30fdc400d082@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <55ab744e-b178-4689-b0ca-30fdc400d082@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: a3232b9a-47f5-4b18-6bdc-08df290bbfc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|4143699003|11063799006|56012099006|5023799004|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0TAYxvD5cV06qi2Lph/uuMLgmug5rxdYEYWbZkOMMLMXjKuljSA7xP6M/RE5hFdq05p+w1cRwrqaRgj0KbNQQQaCtf2LOSnckAV/QPSpPjiT8A8H096yt0NnrTtVgoRtIUZSM27/eM7UxfdQHTl8XZ7s4/X2Mf60eJ10J8acgo1s/Ec2DzCMA87UaADx3GYeWZYv7DQpWBsRVKc4lYmUd5u7LSYYx8ZN+UGmmLnhcCQXFa+x3j0cS41vFUlGfrbxcspVBzD9Vc9CTvhLEzuiebKWKkw0uNUdhpm+FkUiowEQUlj6EWXpUzoJg5sVya0Tq3UmyH7utVZH6VqNNX8QstwSKtux0/oYr05Rzqp0kzdb0hIQLy5+ZirmWbnHKytEQQFiyrotTtB4k4bD4UHNrdQDsugE/EqdCtn9awXAP0yybPEx+gXV6pxluyDBqFcHQ1cMrXSe9A2UROgOGgtUHSDumvmRQyUfhldddgaDNBCMmNWSkYo54gziJOrTQYw2V5Ej9MoerP6hxvkc/wL1x6/CrP+vl56WrLc1pPiMqJ3plpDdhyJulIEcGsVQFShT2/IELSyyevW+0s8yYdLgcgPaULBvUg6NR1+fom/3f04q3mH1kPzNK5W2hIX4T23RwPJTK7qPBFFFS1TO+NVr1wTIyE3DpOPOUFWe8w+I+oA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(5023799004)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUNWYldza2lFU0lxcGora2ZPRzU0RUw0VlI4blpqNFBhcTZCZW9kK2tIczY3?=
 =?utf-8?B?bkQyQ2k0cnNQUFhmMkNmM0J6dnlXSE5yZ213S04wUlpzeVFhRHZUQ3BVL3VI?=
 =?utf-8?B?WHlkZWsvVi92aFVDUDdZQm5GTGlwSVV0WUZjN05FZVJ3S09jRlFXVllLbUs4?=
 =?utf-8?B?QW1yOTFsYitqWXJOdFh1UmN6dFFmS2UyaDJMeDhqamRlaFE2VFkxQlcrdTlw?=
 =?utf-8?B?WGNwSzB6aUxWaitZTWNmejdCRFBZT0VHNHkzYkdySEZMaFVmNmhHT0dMT0Q0?=
 =?utf-8?B?RE83amxIZ3BOYTh3T2R1Q29VdHZaZDIxYUVqT2ZYdytlaEZCNmcycmR1RnVt?=
 =?utf-8?B?S2tycml0NW0vaWcxRWs5UEQzWDdQMmFneUFBcWh0TUhqZmo3RUl6UUxwcUNB?=
 =?utf-8?B?dG5Id2ZDSXpZNEplSi9WNUtoWnFrQzhDVjlKVEhRaHN5RmtBNTd5aFFaQXBm?=
 =?utf-8?B?cmJINUxyenZVQ0xZc2s4b0xKdmpwbG1OeU16emtvZ2xZK0I2d2ozL0F0ZTBy?=
 =?utf-8?B?czhyY2RKRE1QWHV4TENvSjU1ekdDY2IwN0x0UTdQZkwzdVc3YWpaNUErL2Z2?=
 =?utf-8?B?YzVxMFpJa2RLSjk5RyswRVIwUnBjVy85NDhuSTUzaGZnQ2x1NUhJS3J0ajh0?=
 =?utf-8?B?YWZQaEFkelNWeGZwMm5iL1N3VlM0VnFrSmpESGl4WFl6SzlLMDVDbjNTMWJ6?=
 =?utf-8?B?eHptWWNuZ2ZYUHVPd1ZnQjZkWklqY2Z6UVZ5VzNTYU9kVnFXSlVGZzdVU2Rt?=
 =?utf-8?B?WnZ4OWRCSHhMUkFobE5OekprRHNVTUsxY2hoL2RNb2J5dDFnRFVORzkxMnZO?=
 =?utf-8?B?MnA1cEd1YlNwbTBjeS9CbEhlWWY3Q2xBK3N2eTBqMHJUWHlRTWdKcm5uRXRI?=
 =?utf-8?B?K0hDRWVnQ1ZYYTdXZ3MzVmpoci9sKzRISW9FdDl3UmZDNlZCaG1uQy93c1dv?=
 =?utf-8?B?WUZmZUxiWFlvRWdkdGExWUZLZVlvd2R2M1o4bEx1NDhGdUxhQklCZWFYU3Ex?=
 =?utf-8?B?TnpKR2wxQ20waGJ2SjBqMXVsWFVzRDBQd2o4bStJaUxsUmRTOTIveVI3dGdQ?=
 =?utf-8?B?UklDQVByT0hFZVNUZk8yTDY1YmR3aXloUVBxaFRnQ0ZNL08rUmRtN2ZZRVRK?=
 =?utf-8?B?eDI4Mk5PT2V5YUJhSkpYWlhkMmdhMTJVUWR1VEg2cmMzU0dXcDdQSWRhckw3?=
 =?utf-8?B?d2RXWTM1TUlML04zbzlMYkFJSUF2YzFWd3A4Qk9IUE96VWNlcWJrRVhwbmRy?=
 =?utf-8?B?dzFaa3hxNUpkVnYxV3ZaWTVZYTViTW9kTUlmeHBYZWlQU3llb09LS04zNlEz?=
 =?utf-8?B?Si95MGRacUZxOENKdDBmWWsrODRqendpRXBGU1M0MVRsdU9SdmtXcXRpeUYy?=
 =?utf-8?B?ZEhURm5hdHhIL1NuNlhkVUpOaHZobUoyemdMRnJXWFVQL1NueEZFMm1qRUZG?=
 =?utf-8?B?VXpkS1FjbGR3WDlId28wV3BzWjN5Zm5OdVI4bGxzK0tPemVHNE1Ha0swOUxN?=
 =?utf-8?B?SGdnbCsxcXlMemFJUkR1SFJYc3R3RG5heGVJaTJtTGlwSy9yeGVKWW1TcVBJ?=
 =?utf-8?B?ZXo4bUJvTDdZNXF3UnpXSjN6SVVRSE1vcXB4dEZsd3M2U2FsTDMva0FjNy9o?=
 =?utf-8?B?MlcwWWVid1d5ZWFpckZseG5YRkxjWm1xYVUySG1sR09EZVFUOVRuYmRjaW0x?=
 =?utf-8?B?ODNwcnU3VllYWnM4MjVhSUZkYXRYdG4xclZqSmRNNzNFWVNLeTZEdG1KTDJC?=
 =?utf-8?B?ZGV1NlQ4Vm9JRXNNUkszWS9FMWpHQmp1QU9DRnBuWHFGQ3kyOE9sK3FPZ2NE?=
 =?utf-8?B?cW8xT0pQSUthK2RZU05FaTlYK3hPWWVqMkwwelRGWXJoUmpDUUpJL0hiVnE2?=
 =?utf-8?B?ODBMM3Q0b1FGREpDMXJOZ3drMVN1d1k4YXljdEZXcHFQeG9YMG5BTmRtVy93?=
 =?utf-8?B?YWpoL3VHZ1I4ZWc0UmhlMndSYTlpbXFYY20ybSttQUVsVmpQSDJ2bHZpYTcv?=
 =?utf-8?B?eHNlNFpvenU2ODdxdk8zZGswZGxMY2lERXpUendWZ3YwV1RLVGR1S2xSSUpX?=
 =?utf-8?B?YWlENE1oSElLc0V6STNFdzQyK0ZjTUxuOGRxWXZyUmZGazhwV0pUNEtZRGZM?=
 =?utf-8?B?YWZjUkh1VjllV2F2ZGVZRElmQUZQS3A4dHJhVHluVFNVRDV4WER1bmNLaDZK?=
 =?utf-8?B?YzIvMU1mWm5wR1ZZWklwbnR6QTFVZzc3YkFYMEQ4MEk5blE4ODltNlRvVk9t?=
 =?utf-8?B?aTFPWXc4NzU3Q1NTOGJuSjZYemg3OXN6TEJabzVjbktDWW5NZ0lkRmsvSElH?=
 =?utf-8?Q?bujAv3YYl5YQ+SMSGH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3232b9a-47f5-4b18-6bdc-08df290bbfc6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 09:24:15.1557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBp7mwGHd6Z5YGFMEjep/5DdRyFwLu5AfHN5zvZuKZiguTx28H34ZE6zXfcy4ECF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978
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



On 10/13/26 10:21, Khatri, Sunil wrote:
> 
> On 13-10-2026 01:42 pm, Christian König wrote:
>> On 10/13/26 09:56, Sunil Khatri wrote:
>>> MES userqueues bypass amdgpu_vm_flush(), so a reservation granted to a
>>> userqueue never got its VMID's page table programmed. Add
>>> amdgpu_vm_spm_update(), called from amdgpu_vm_validate(), to bind the
>>> fixed SPM VMID's page-table-base to the reserving VM's root PD when
>>> that VM holds the reservation; it is a no-op for every other VM.
>>> amdgpu_vmid_free_reserved() unbinds it directly to a dummy address
>>> under the same lock that clears the reservation, so stray SPM accesses
>>> fault instead of racing a new reservation's binding.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c |  6 ++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 37 +++++++++++++++++++++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  1 +
>>>  3 files changed, 44 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> index 992f7cb3a3102..0ad94b09c6b46 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> @@ -581,6 +581,12 @@ void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>  	if (vm->reserved_vmid[vmhub]) {
>>>  		vm->reserved_vmid[vmhub] = NULL;
>>>  		id_mgr->reserved_vmid = false;
>>> +
>>> +		if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs) {
>>> +			adev->gfxhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.spm_vmid, 0);
>>> +			amdgpu_gmc_flush_gpu_tlb(adev, adev->vm_manager.spm_vmid,
>>> +						 AMDGPU_GFXHUB(0), TLB_FLUSH_LEGACY);
>>> +		}
>>>  	}
>>>  	mutex_unlock(&id_mgr->lock);
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index de992405ed718..3967dadb8d425 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -568,6 +568,41 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>>  	return result;
>>>  }
>>>  
>>> +/**
>>> + * amdgpu_vm_spm_update - bind the SPM VMID's page table base to @vm
>>> + *
>>> + * @adev: amdgpu device pointer
>>> + * @vm: vm to check against the SPM reservation
>>> + *
>>> + * The SPM VMID is fixed (adev->vm_manager.spm_vmid), so its page-table-base
>>> + * register must track whichever VM currently holds the reservation instead
>>> + * of being set per-job like a normal VMID. Bind it to @vm's real root PD
>>> + * address if @vm holds the reservation; otherwise do nothing, since @vm is
>>> + * not the one that could legitimately change the current binding.
>>> + */
>>> +void amdgpu_vm_spm_update(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>> +{
>>> +	struct amdgpu_kq_vmid_mgr *id_mgr =
>>> +		&adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)];
>>> +	uint64_t pd_addr;
>>> +
>>> +	if (!adev->vm_manager.spm_vmid || !adev->gfxhub.funcs)
>>> +		return;
>>> +
>>> +	mutex_lock(&id_mgr->lock);
>>> +	if (vm->reserved_vmid[AMDGPU_GFXHUB(0)] !=
>>> +	    &id_mgr->ids[adev->vm_manager.spm_vmid] || !vm->root.bo) {
>>> +		mutex_unlock(&id_mgr->lock);
>>> +		return;
>>> +	}
>>> +
>>> +	pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
>>> +	adev->gfxhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.spm_vmid, pd_addr);
>> That function seriously needs a wrapper in amdgpu_gmc.c.
> You mean to move this function totally in the amdgpu_gmc.c or let this be here and create a wrapper in gmc layet calling this function?

Create a wrapper for this in the gmc layer and call that here.

>>> +	amdgpu_gmc_flush_gpu_tlb(adev, adev->vm_manager.spm_vmid, AMDGPU_GFXHUB(0),
>>> +				 TLB_FLUSH_LEGACY);
>>> +	mutex_unlock(&id_mgr->lock);
>>> +}
>>> +
>>>  /**
>>>   * amdgpu_vm_validate - validate evicted BOs tracked in the VM
>>>   *
>>> @@ -630,6 +665,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>  		amdgpu_vm_bo_needs_update(bo_base);
>>>  	}
>>>  
>>> +	amdgpu_vm_spm_update(adev, vm);
>>> +
>> Wrong place for that, this needs to be in the caller of amdgpu_vmid_alloc_reserved() and in amdgpu_userq_vm_validate_and_restore_queue().
> If i understood it correctly, amdgpu_vm_ioctl -> amdgpu_vmid_alloc_reserved after this call returns when we should call amdgpu_vm_spm_update? 

Yes.

> For the userqueues, 
> 
> amdgpu_userq_vm_validate_and_restore_queue { ...     ret = amdgpu_vm_update_pdes(adev, vm, false);     if (ret)         goto unlock_all; is it safe to add after this point ?  amdgpu_vm_spm_update(adev, vm);
> }

I think that should be before amdgpu_evf_mgr_rearm().

Regards,
Christian.

> 
>> And while at it please rename amdgpu_vmid_alloc_reserved() and amdgpu_vmid_free_reserved() into amdgpu_vmid_alloc_spm() and amdgpu_vmid_free_spm().
> 
> Noted
> 
> Regards
> Sunil Khatri
> 
>> Regards,
>> Christian.
>>
>>>  	if (!ticket)
>>>  		return 0;
>>>  
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index b8aa45db1d844..2a2a2ccbaa2cc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -443,6 +443,7 @@ int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exec,
>>>  			      unsigned int num_fences);
>>>  bool amdgpu_vm_ready(struct amdgpu_vm *vm);
>>>  uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>>> +void amdgpu_vm_spm_update(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>>>  int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>  		       struct ww_acquire_ctx *ticket,
>>>  		       int (*callback)(void *p, struct amdgpu_bo *bo),

