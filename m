Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85620CCA464
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 11:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E2C2112789;
	Fri, 16 Oct 2026 11:42:11 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97099112789
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 11:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jilnEWiZgKf8raSCd6I3Y1nR16YozeUerWrVPq5rbZUMFAwRRp79gCDaeeODl8lnYt8nAovGiZ33Z2Fw1kfCU7K6lHkoCXzFck2MXqf0kDFA2lUNXDh9/43g7NjwF2yzjPGH8k0fE+RcPE5g/C6LFh1WeQCCGL4sX4efBqLYDVBlr9ZPx8h7dJSsAnDGHcaAKmK6naD+jS2uIZkHnnWf9H3l0ZMR/5IQsQOeze9Pl9naPBaNUFIzmcS3390iHnavX+vqifKboh7EsfLmxoB/uqZ1ahDssqoirwFueQayJ+SsaSlfYM55/tTTjbeet7ZT4JvJb0fREzQ1gPejC0pI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=336xMqQXDfS2kW3De/W188G1jhZnthSK54wsxHScBgM=;
 b=o+tjH+INuL2EUnwpwUREI8QtiwcNZV8fUV1g/mDyG56CBfw7ECjW3xUnLlPjV0RDFpohhlq0w21aIK4dP6Q2RSCabrew/UXz1gxcg1dNEI1HKnRAPdMF4EEkHduFoXr/4GYEYRUicj+dB619FJMb1d7F3TMSbWb8P68d/CSr+6XcAUTTdlguXiSbjZZjCwdesBTL/0udrdVXz1KqEw1kxGIUhWVSOCYV43HPAlSdDvoH0Kc31kOQXs6w/FqwgUPcfadTCSY/bpgO0Lmoq9Zy7buzpMT/CWGSO4incKrBQj/AWI4INaSwuRd80qbMetm3dxtsUSM2Cp27njPE2PcmFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=336xMqQXDfS2kW3De/W188G1jhZnthSK54wsxHScBgM=;
 b=xxzNmyfZdAxMEo/yitl9Gsu/fA/oDEaNehVviVcUj4bG3VG3gbh+Fhx1DSk4cc4UrTfgLY4hyWcBN/xEDqc7OWxM+FnYxb0VlG+uYveTT8r909ykZzyBvdFcezSQrFCNX/X78biDCoEl0XwxUBdg438cfJQvsGQyjayDUyYwUak=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 11:42:01 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 11:42:01 +0000
Message-ID: <7bdf01f2-a727-4fd7-8815-96c6d537b827@amd.com>
Date: Fri, 16 Oct 2026 17:11:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/amdgpu: rename amdgpu_vmid_alloc/free_reserved
 to _spm
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261013112112.1449531-1-sunil.khatri@amd.com>
 <20261013112112.1449531-2-sunil.khatri@amd.com>
 <a1676db3-7de7-4a49-a41a-433133fc4913@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <a1676db3-7de7-4a49-a41a-433133fc4913@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0280.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::13) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 98195a6d-643b-4595-411d-08df2b7a7df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|22082099003|10067099003|18002099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: LDk1DdL0jsDfr9Z1YyW825omhqQuBb3pE0Hi0vSbUS5Y+bDvQcz4I2prNbjlpO9HXc9jRcj+0g2x71wPggdSo8fKh8Drgad4t/b5fda1XOW5KyMBA6NATqrObIOuRcQ84tS5cTRg6SbsROhXyD9XvRkCQVsle0kEyiutKlISaYeYzypkPVlQ5bTWQWBL6MklM7eONwpg9qd6AOC/LOs5SSif8WLb8RaebjOJamzfAmq7Buq721qVqfLMP01KgY8rNME++tDplUd90sl2DV18j0nkW19MVcIF5zS+D7T+C2LdLraZEp25r0sDNuGUO2OTZoz0ajz1K1MES2X/riucEPfr5AhHtw6t3cjni1gjAOuR7tpqnfkhPaCV0QecESkUtaoCfSxHdBBQ/mi1RoTTvI6LdygJ4hSvpwmh+4MulMF6if0wWbFbyRZ6wxSy+otp6mbYAeuJDJShybK7aWLefAqi0Sy3puqKY3twC9hqdGbfL6nTKEYoWG/WCQcsXL0DXQtSVhtKBcmnMiEj794ruIZk3XaZfiQGdvn0dPb6Ksa7MqcXQiCQdBY8RcG/nqmtxxa3D9rQtk+5eEJn51rPuzDv1ojrjWCPjljUDvUqIYtIleVGjwePpin0TNSJQKBMo+5pKE/IwrpfCkytcJ+qzwYJmsO86/9E2+wQN9Aspwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(22082099003)(10067099003)(18002099003)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zjl6WExtQmJXR1hJTTNJWC9NdkxZS0xtaDg4bGpqbFhTbEtlMGFiZEJNV0hX?=
 =?utf-8?B?NytMeGlGakJ3b1VCN2JFTjFGSFZNMnVtVW5sS25ZUVA5dnM0ZDhxN0pEcDIz?=
 =?utf-8?B?dVprOVcwRVZ3ek41MlphSFcxTitabWRIRFBRQTZtVyt3UlloaVVSa3VvQzFV?=
 =?utf-8?B?cng0OVgwaUhXUWFDL3ZCU2RHMWgvOTNQTHlGdDZoaXVidWN3K0FmV210QmhN?=
 =?utf-8?B?K2p0ZGFKOHJGVzgrZkNQSHJTNmNVWmdMNnU0UG00ZUVuUEhwVkY2T0pOOXE4?=
 =?utf-8?B?WHdMcjZUVkxzM1drV0gyUjI5c0I4SXVuditlSUlnZld2dkJrNGRXOWhqK3gy?=
 =?utf-8?B?d3AvWDltMDlETkdiTkF6TzEyL2pESk53SUpsRHZSSEhWeGszUTBLaVBjNEZs?=
 =?utf-8?B?UEF2Ti92SmladTkydjdiQ2QxWW0rSEczR1F6L21qVTVWSDUxeE50Yi80bVFm?=
 =?utf-8?B?UE9CY0t5WFlMNHlYWnRTVzM2UkFQb0ZWVW9mUlNqRjJ3QWxFTUhIZENVT2x1?=
 =?utf-8?B?dktjMFdHRW13Nnl2L1pWanlDN21acnhYUHRtcURna2IvNnJmUlFwTjYwbWlQ?=
 =?utf-8?B?UFk0K2RJajJueTh3ZWRXS0pxQ0lvY3pFMlhIZ3BYcTRRWTlrQ1ZpZlVacFVO?=
 =?utf-8?B?dExzNGo4NEJhTXIrb0xJVXhrQzk1akkzNS9vcmsvZTdZYXJjMEdFaVBVTjB1?=
 =?utf-8?B?NGRoUVJsZk41T1BGRkIzS2hHamNWSjRWcDZES0dIcDBiNExUU21uNURLRTM3?=
 =?utf-8?B?djlDNGlyTmtFTStSNVcwMjM2SjQyT2lrd0kydCtPbnUzc1NxREp5L0gyNUVh?=
 =?utf-8?B?dlF0Zyt6bkZhNnBHRmF5NDUvakUyMnN4QWVkbmM4dUlZOUwycGR1V2xTcWxB?=
 =?utf-8?B?RVJsekN3eTdqNXdyZVZ3elFQajhXUmxyWERuVnZ3ZUtqSm5MNkdCcERPN1Bs?=
 =?utf-8?B?NFRad3FRQ2JORklzMi93cEw2TDJVRTFrQ09raE51NmxWQnFmRkRPYjdITjRn?=
 =?utf-8?B?R0t4aFNzVHZmV3BvRjZyM2FqK29lMjd1SDNNcHg1UHlKUWVoSjN6VnNjblZa?=
 =?utf-8?B?VXcxa2ZQRUROYlIyaFZncTJWbEJaQi85WFlrQnhmTzgxNnRtT1VZQUdSb3p3?=
 =?utf-8?B?RzZGYTlBYTZhcFg4RnpvTGRBTHpBc2NWVnRCT0dYL2xWZG0wL1Zma1hwREJK?=
 =?utf-8?B?WXBJZTZ3b3QvZGpHUTVZOXNMSGhBTUdLS1ljVVVnOUJoY1R1cXBtbTZsT0xn?=
 =?utf-8?B?Unl3Q0xEZTZYYmxEajA1NWRNRkp6Z2RkdTMwR01GelNRcE9nUFN0YmQwdUYx?=
 =?utf-8?B?VDhLbDF0RXVGYThDZGl1SldMNXY4dDdWN3dONnBDUXRSUS9GYUtZem1td2hH?=
 =?utf-8?B?eWZPUXRVZDNGbGJHK2M3OW1lNEdoendDdEpjMXBKZVI3VmpNY01ncXZqSXg0?=
 =?utf-8?B?SnlkVHRiMUQvRjhKSVNVRkl5ZmxOYS9BNEh1bVpzZFRoOG1rcXVkVjFmUk0r?=
 =?utf-8?B?WkJRZUZOYlRTdlFvazB0UGZRSmoxQUlxM2txaUZYUUVubGJLaFhGZXRXOGxO?=
 =?utf-8?B?aFNselk1cTdlcG9wTTNva1BFTnJaL2lkMG5yMmo3VFpIdmJXUjhpMjNVdWdm?=
 =?utf-8?B?bldlYWxKbDhXaFNiR3ZxWlp1ajBrNEMxc0tzZ0hpbUdDWDdMZFNVNkRGRkc1?=
 =?utf-8?B?RTk2UXJWSnBjNS9UTHErSEZtRWtKQStFNnpFamxYQXplaFdWWVZ6YnUwYm0z?=
 =?utf-8?B?NEw2T2lrTFBFUnVQbSszVVdBVzlvTXBzcnNpMW9qQkdCaGdzWExHemVJdVBO?=
 =?utf-8?B?NURvVjZsa1daRitCMWZwQjdzNWFVVXdwUkNoNEEwV3Bnb21yOGFxSGd4MnF5?=
 =?utf-8?B?TTBIS1dyamVjMkdSc3FkUEsvWXRmVWxMTUcveFFiWHBBYVR0MFo5d1RlOXVp?=
 =?utf-8?B?eENLdEZGTDIrTndUWnM2MFZQV2RPWUNGMndTYVcraWZkMm8xZGxad3dmQ3cv?=
 =?utf-8?B?QlhLNHUwNldvMk5lN3Z2L2F6bE4xL2pTT0FPY3F2eDhWdDhpTzBkZjVzNnJZ?=
 =?utf-8?B?ZXZoMDBnSDYwaEV5QnpRSWJQUGE2cmo2UzB1SkdKbldwS2VrWWduNXcxa3NB?=
 =?utf-8?B?ZnRVSytBNU1vWnlDMmJDa0pRak16YitjSGRYOXV1eVNwQVd1MEV6TUdjTGhC?=
 =?utf-8?B?VXlsSjNsTmNMTk9jb3M4NjJlNzJqWmtmWmlRcDZuMDhZeW1YZnFIVnpDbGFC?=
 =?utf-8?B?SWNMWE95YzBsTFFMNUhJTThlbUVIcCtsam5aWFNxUncvTytPMEExV0c0RlA3?=
 =?utf-8?B?dXc5c0FhSlFYb3dldHc4Z2UzYWxOZzgzdkJJVVcvc3Z6YVVXOWI0Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98195a6d-643b-4595-411d-08df2b7a7df4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 11:42:01.0551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dFog+vbSRjDXHC5o5JE3w+rD1p4mnY8TjbcRUf32L89RkXo4LOes0DkHFdec4wnMz+pzVBreBucnAIf8F0GKQ==
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


On 16-10-2026 05:04 pm, Christian König wrote:
>
> On 10/13/26 13:21, Sunil Khatri wrote:
>> These functions only ever hand out the dedicated SPM VMID now, not a
>> generic reserved VMID. Rename them to amdgpu_vmid_alloc_spm() and
>> amdgpu_vmid_free_spm() to say so. Pure rename, no functional change.
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 6 +++---
>>   3 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> index e5d84a786c4f2..f15702993eeab 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> @@ -589,7 +589,7 @@ bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
>>   }
>>   
>>   /*
>> - * amdgpu_vmid_alloc_reserved - reserve a specific VMID for this vm
>> + * amdgpu_vmid_alloc_spm - reserve a specific VMID for this vm
>>    * @adev: amdgpu device structure
>>    * @vm: the VM to reserve an ID for
>>    * @vmhub: the VMHUB which should be used
>> @@ -598,7 +598,7 @@ bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
>>    *
>>    * Returns: 0 for success, -ENOENT if an ID is already reserved.
>>    */
>> -int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>> +int amdgpu_vmid_alloc_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   			       unsigned vmhub)
> I think we also need to make sure that the hub is a graphics VMHUB.

amdgpu_vmid_free_spm/alloc passed explicitly AMDGPU_GFXHUB(0) only... i left the function deliberately to be generic but caller is within the kernel and we hold control to call with GFXHUB only4

Regards
Sunil Khatri

>
> There is really no use case for an MMHUB here.
>
> Apart from that looks good to me,
> Christian.
>
>>   {
>>   	struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>> @@ -629,7 +629,7 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   }
>>   
>>   /*
>> - * amdgpu_vmid_free_reserved - free up a reserved VMID again
>> + * amdgpu_vmid_free_spm - free up a reserved VMID again
>>    * @adev: amdgpu device structure
>>    * @vm: the VM with the reserved ID
>>    * @vmhub: the VMHUB which should be used
>> @@ -637,7 +637,7 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>    * Waits for all work that used the reserved VMID to finish before unbinding
>>    * its page table, so submissions still in flight don't suddenly fault.
>>    */
>> -void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>> +void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   			       unsigned vmhub)
>>   {
>>   	struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>> index b85aa2ee19b19..c134000eecfdc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>> @@ -125,9 +125,9 @@ void amdgpu_pasid_mgr_cleanup(void);
>>   bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
>>   			       struct amdgpu_vmid *id);
>>   bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub);
>> -int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>> +int amdgpu_vmid_alloc_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   			       unsigned vmhub);
>> -void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>> +void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   			       unsigned vmhub);
>>   int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>>   		     struct amdgpu_job *job, struct dma_fence **fence);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 7fd6215510a94..8d4c13f2ef7fb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2894,7 +2894,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>   	dma_fence_put(vm->last_update);
>>   
>>   	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
>> -		amdgpu_vmid_free_reserved(adev, vm, i);
>> +		amdgpu_vmid_free_spm(adev, vm, i);
>>   	}
>>   
>>   	ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
>> @@ -2997,7 +2997,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>   		int r;
>>   
>>   		/* We only have requirement to reserve vmid from gfxhub */
>> -		r = amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
>> +		r = amdgpu_vmid_alloc_spm(adev, vm, AMDGPU_GFXHUB(0));
>>   		if (!r && !amdgpu_bo_reserve(vm->root.bo, true)) {
>>   			amdgpu_vm_spm_update(adev, vm);
>>   			amdgpu_bo_unreserve(vm->root.bo);
>> @@ -3005,7 +3005,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>   		return r;
>>   	}
>>   	case AMDGPU_VM_OP_UNRESERVE_VMID:
>> -		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
>> +		amdgpu_vmid_free_spm(adev, vm, AMDGPU_GFXHUB(0));
>>   		break;
>>   	default:
>>   		return -EINVAL;
