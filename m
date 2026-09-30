Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB60CA5FB1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 09:02:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5292910F28C;
	Wed, 30 Sep 2026 09:02:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KJVnTQz6";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F9610F289
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 09:02:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0dExGrH9Kysez9lDJunnHQBmCoO7reD62acSESvIfe6d21gcRxEWOo49zgsWa3z4iEYJ9fNqeeyMD4BEhUbnifdS/IWpCCbWGxneGn4EPAltzO93wmQET5b7oVc5Ds6D/ws0UGJjt/tSIuxRRsLqy9H+wQxEL/a0ReXDTG9aws4OmZSFqjr08pGXSDRJpz9EVrB5QhkE/dSa3kxd2uh1xaoCeksoB1mqmvZrbqzqj/AQjGwrKZ/5fFjfOfsNEkrGMxwjCEgaLg7wwN+JwdVCmvCqTb6/u0vQsYsHvJ81Js9mBtESoIjGPNEatH/q6X+Q5u6kbVx89NfmwlhR49byA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9aMt2VUvA18z3/+6IQ7tMQOE3lXMg0zuZy5NiHD0rY=;
 b=u5LtSuSXa0KVjju+deKo7Km4ZyKSWULeL1KmM0obK84ximndDf4+igUCXr/3nCST460XPvWjv4ppdrPQvee5W3N/Zk+DTb2UMANbbAKPK15bItGavwh97O/IGgMSVn2r3ezd4k19QpEpUM7wmlnByjQ4WLKmHlq1B8+J5TlK4mgIqftxHQP0ld1MvY8nZYRc3eEb5gYHs89gKwgLtQhj8GKyGAKbi5GB8k4lSzwFlRaHiZm4rAXYivINALBEFU9oMR4ivEw3vAcnZ5lOGMBi7zkPzRa4/ry59yMiukYikl+jNXnlOxGj+4UQfcBNae2+f80lbDM/9MOWlFz2I/2yfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9aMt2VUvA18z3/+6IQ7tMQOE3lXMg0zuZy5NiHD0rY=;
 b=KJVnTQz6vxphB/WW/0QxCJ4IYP3zmHLjH/g5BcxLCyv/2CzOHMmNGCAlDs9cnbneewDLToQRmtcuUZGq/hyxg04urcFlaOajAQvWoshIAg47BEnxBzRlOAdzxlvw6e/60h1ioVATa3901ONR9t1fWwPt23QXTXnDqF6oTloFKDI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 09:02:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 09:02:34 +0000
Message-ID: <cd5af67b-d2af-43a5-be86-216155f46ff8@amd.com>
Date: Wed, 30 Sep 2026 11:02:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/amdgpu: fix cleared PDE/PTE flag generation
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, cascardo@igalia.com,
 tvrtko.ursulin@igalia.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260928151041.1857-1-christian.koenig@amd.com>
 <20260928151041.1857-2-christian.koenig@amd.com>
 <P3WG6T-ATwauPO6Yp0bWtQ@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <P3WG6T-ATwauPO6Yp0bWtQ@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: dc65fe3c-6334-451d-29a5-08df1ed1912f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: qdLsA5Zdha7rqD6W2thYYjxclg0wfBzjYXU5EU/Ino/POkvzNxjwk4ML9JTfS/M3OXfbZV9a9WkIEOb+/V8xM1VACZE3iZEn8cACeKme4sA31n5AadR2MoIyU/qEH6QX0nrQ5Fk3k0x1bPk8BDtbtFf7/5dK3joMnJEu1JdVEmoWdharDDL3wADMr9d6dlm4CfXTotQ5ugLJDAoCjA/zecUJ1jtCSKvbPU/IP3OJk8ylS2wvRQ8BqeT0s0vVBlvnZfrBN6F6n92TNbF/6FmR1hMVaRUAb+vGLazStBTnt3pqOHQpEDrTbunICdN9T5pvh4r7Znwo6nY1YMN/zOyjl+rud/zJYle6MdXXYLeOZLhqp4ZODs1nHlqcWdHcTGjbpQv+rjhZ6UVkLU6vg9OVPCLgmXIczAHi5EI6u0xRniJ40egUyCycYEj2Y4Dy9lhHBQhNuL4KYoD4IzzHbTnnF5CZ6fgt0sSQyvraESDLGzen33/d/B9jhnbiGYEZr0+fik7PA7dRnPDIu6Vc1D+7zxliE7qdQKVwCbAeLE3XA1lVhb0NSqU0He+b9TKrNA222PRKDNJQqkS7j4Lm3up+17pG15QG0RPB9rqbaC8ORRwTDdjlDwRg7jP7GhA4eGm9CfFpEUfvySnb+fML+rGvoneWlNlvR8xghuSpBIsA+CI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjgwQ0l2ZEM2TnczaTUyNFl5NlF2MFpxK0s3QmZ1SWY3Y2k4WWErY0dDYUFx?=
 =?utf-8?B?eUR0RVI4S0lRT1VPVzFLeXpEQ2p0UXJac0p6MHNSbE5JRlNGdE0rVVNzanBP?=
 =?utf-8?B?U1l0d0UwTEtqdTFXa09TWEovenVTMGpNVTA2TWJCM2dVZm9FQXIxRmVsK0Fs?=
 =?utf-8?B?dHNLYXk4ZE5XcC9xcDlGemEwSTVvRGFuRlliVXdFbldiN2dpR0NsS2dORVBC?=
 =?utf-8?B?UHdEenl2Y0V3L3BMWTJSWFBmMFBmQ05wdWNTVnpIcklqWmJRVDY4SHl3YTBT?=
 =?utf-8?B?cjI1RHMvOGpYV05SM29YdEw3SHhYQzV2Q3hENkcvdFBzK1ZjeHh1cGg2K0tj?=
 =?utf-8?B?aU5OcWFsYUFQUzVNZkFxcTkyeUpRYXNZVUMzbXR3MDNVb1p3elRxelYrQmFS?=
 =?utf-8?B?dUlJQitoWThBSlhqKzB2a1FEWndzSkZlZUJEK2s4OXgxcXc5UWd4ejNuZ3BR?=
 =?utf-8?B?YkQzOTlOK0JIaUs0dExoU2FFTmljOW56MUdYUkhua1FGUVZFRjZFSG8zMmJu?=
 =?utf-8?B?cjQ2TlNvNjgrb054VGxWRE5XUit3L3NFdk5pNjdhNzFsYkwxSHIyRkZiRGtX?=
 =?utf-8?B?UmdFQXJWdlMvRkJDWlBQR1FWQzN1cWFkajE0TkJycitiVlB4VEl3Zko5VDZw?=
 =?utf-8?B?RFRWdWNZYytWekI0L0E5a0plRUdQYkU2czFnZmpncitFYXU1OUwrVHMvSEJq?=
 =?utf-8?B?VXZpRHgrOTdWeXJYV1NWMnYxaXdjd3cvODV0cVpFNnJHZlhTMXVYTnI3dFVs?=
 =?utf-8?B?d2o5Uzh3dzA3S3AxWEVnQUc5K3d2ZUhRWDFIeXdheEZuRVhrZHlMVXBibHYy?=
 =?utf-8?B?bEx0RTJEUlNmTnpISXV2SitNZ1dpN0FoQ2l4L01KQVUyQ0tVQkVJQnY5bXg5?=
 =?utf-8?B?UXdVa3JOUVVMYzNhMkhyZHhZKzJ3Y3czdXN3cEIwQURuVU9WbGxzamdSQTFl?=
 =?utf-8?B?bndIdmhvZ3VTVE4zb1F3UEk1Z25IaytEd285SEgxOEFUMTF1ZWFZSnduN2NM?=
 =?utf-8?B?c2ZRak1FbGttOW9sVU9YTHRGQ29SdEVxTkdjeHVJMkRpK0E2QUtDajVPb1BS?=
 =?utf-8?B?MkJDelppM3NUeU9JaURZbUptYlRjZHN1VUt6amU2dXNMc3JWY2pQeE4wL3BS?=
 =?utf-8?B?RXFYb1hKUzVZMktmSFdjaVJZRWhyaUZTVENPYTFmNytTd21ibk85RllNWm4r?=
 =?utf-8?B?eGtHR2xrNVlmaFlnYjVpTDNhM1pqTmM1NGZZbHZPV2d2eER4MEhUOUNNOHdB?=
 =?utf-8?B?alBXNkJXdEJnMExkMytvUThOVy9oZHMzRk9qd0RhQitCOUhPQ08wdjlob0ds?=
 =?utf-8?B?b0oyMHcwTk5ienpjSS9Zc2ZLQjFZWnQ0aTdMMitmN2JaYUI3dDgxMzFRU01Q?=
 =?utf-8?B?WU9FZW0vcGFrRk0vVnFPMEtiNGg3ZlVNaitRejdYUFFCU1REQ2xqNXhycDBP?=
 =?utf-8?B?b2graGlXSTRzVllFVjNhN3poY3RRejkwcnBTZGhlNVdRY2ZkVG5Vd0JLTlpW?=
 =?utf-8?B?dXZHOG01VDBFcnh2V0ZoZFdTMHdaaDVFdFRkaWRWazE5V0xUSS9nV3JkUVdH?=
 =?utf-8?B?SGQ3dWgrVU1oMGE5MUxLVEhOUXRzWW81ZWM3S0RNcys3Z2ZuNEhKS2dDYWRO?=
 =?utf-8?B?N25QSGtkOGhiRUJrdk45QnFJNUNmUjBYbldZV2NFRWVmL1pGVjBmTmE3dmQw?=
 =?utf-8?B?RSt1cWJqckpSeUx4Zjg5eEp5aU81bGZKcFphWDBCazU0UjUwanhENGdIa3JD?=
 =?utf-8?B?Q3ZQMTQ0RGtITGpXbWJFU296VWwzeG5lbFJkMjZaa3I1Yng4ZURDK2NXZHpY?=
 =?utf-8?B?b0xDaW5nWkxUbCtWaGU5SHlackpiR2pWRXBMdEN2WDlaTERjTis2ZTVKbHRu?=
 =?utf-8?B?WkZYMWFMWndXdWtWZ1g4akdLQ1pNVkVRVFV2b0FBdVZNMkxKM3luVlZCMHhF?=
 =?utf-8?B?ZmRsL2UwRndEWU5PNy8vbVBnWVdhUkFPeVNkQkFrWFdmZkVld0N1cC9oUnhJ?=
 =?utf-8?B?MFBZSk03c0diWXdXMEdjeDV1QWJlMElKaWZ5L1hxSFFYUjR6NzBGc1NIdzJ2?=
 =?utf-8?B?MWlCSHZsMW95elExajNEV1JXQnpJOGtJQ09vOWQ4SHM0Y0dDRkdTcXpwYzcw?=
 =?utf-8?B?NGhwMEdBdmVYRXlhSmFFN3RlSi8reFFFaTFQcE1wUnBXZ1AyVForK2tjQ2Fq?=
 =?utf-8?B?a0dodXlqcVpId1Vkbk52WW1RTFBnYWtEZFAyU0FlYjJkYkRrbCs2UXl0R2ty?=
 =?utf-8?B?M1dEM2pQY2FrUndROGhhdEFUclAvVDhKRzVSeWJxTUUxMHg2WWc3dWV1TGw5?=
 =?utf-8?Q?H3V33qqdzD9yBx7+4o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc65fe3c-6334-451d-29a5-08df1ed1912f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:02:34.4733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTlKtBj7IfwRcB1OgBgo5LsOkX2BDVopgJZscOU0mwpbbKak/nHVVtCzWPRyvmbU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
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

@Felix and @Philip any objections to this patch?

It is actually a bug fix for the NPA support.

Regards,
Christian.

On 9/28/26 21:08, Timur Kristóf wrote:
> On 2026. szeptember 28., hétfő 11:10:34 keleti államokbeli nyári idő Christian 
> König wrote:
>> That was broken since adding the NPA support.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
> 
> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
> 
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 64 ++++++++++++-----------
>>  1 file changed, 33 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c index
>> c03327f1242d3..e8f441e018839 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -346,6 +346,33 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device
>> *adev, amdgpu_vm_pt_continue_dfs((start), (entry));			
> \
>>  	     (entry) = (cursor).entry, amdgpu_vm_pt_next_dfs((adev), 
> &(cursor)))
>>
>> +/* Return the flags used for cleared PDEs/PTES */
>> +static uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
>> +					struct amdgpu_vm *vm,
>> +					unsigned int level)
>> +{
>> +	uint64_t flags;
>> +
>> +	if (adev->asic_type < CHIP_VEGA10)
>> +		return 0;
>> +
>> +	if (level != AMDGPU_VM_PTB) {
>> +		uint64_t value = 0;
>> +
>> +		flags = AMDGPU_PDE_PTE_FLAG(adev);
>> +		if (vm->is_npa)
>> +			flags |= adev->gmc.noretry_flags;
>> +		amdgpu_gmc_get_vm_pde(adev, level, &value, &flags);
>> +	} else if (vm->is_npa) {
>> +		flags = adev->gmc.noretry_flags;
>> +	} else {
>> +		/* Workaround for fault priority problem on GMC9 */
>> +		flags = AMDGPU_PTE_EXECUTABLE | adev->gmc.init_pte_flags;
>> +	}
>> +
>> +	return flags;
>> +}
>> +
>>  /**
>>   * amdgpu_vm_pt_clear - initially clear the PDs/PTs
>>   *
>> @@ -366,10 +393,9 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev,
>> struct amdgpu_vm *vm, struct ttm_operation_ctx ctx = { true, false };
>>  	struct amdgpu_vm_update_params params;
>>  	struct amdgpu_bo *ancestor = &vmbo->bo;
>> -	unsigned int entries;
>>  	struct amdgpu_bo *bo = &vmbo->bo;
>> -	uint64_t value = 0, flags = 0;
>> -	uint64_t addr;
>> +	unsigned int entries;
>> +	uint64_t flags;
>>  	int r, idx;
>>
>>  	/* Figure out our place in the hierarchy */
>> @@ -404,26 +430,8 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev,
>> struct amdgpu_vm *vm, if (r)
>>  		goto exit;
>>
>> -	addr = 0;
>> -
>> -	if (adev->asic_type >= CHIP_VEGA10) {
>> -		if (level != AMDGPU_VM_PTB) {
>> -			if (vm->is_npa)
>> -				flags = adev->gmc.noretry_flags;
>> -			/* Handle leaf PDEs as PTEs */
>> -			flags |= AMDGPU_PDE_PTE_FLAG(adev);
>> -			amdgpu_gmc_get_vm_pde(adev, level,
>> -					      &value, &flags);
>> -		} else if (vm->is_npa) {
>> -			flags = adev->gmc.noretry_flags;
>> -		} else {
>> -			/* Workaround for fault priority problem on 
> GMC9 */
>> -			flags = AMDGPU_PTE_EXECUTABLE | adev-
>> gmc.init_pte_flags;
>> -		}
>> -	}
>> -
>> -	r = vm->update_funcs->update(&params, vmbo, addr, 0, entries,
>> -				     value, flags);
>> +	flags = amdgpu_vm_pt_clear_flags(adev, vm, level);
>> +	r = vm->update_funcs->update(&params, vmbo, 0, 0, entries, 0, 
> flags);
>>  	if (r)
>>  		goto exit;
>>
>> @@ -712,15 +720,9 @@ static void amdgpu_vm_pte_update_flags(struct
>> amdgpu_vm_update_params *params, flags |=
>> AMDGPU_PDE_PTE_FLAG(params->adev);
>>  		amdgpu_gmc_get_vm_pde(adev, level, &addr, &flags);
>>
>> -	} else if (adev->asic_type >= CHIP_VEGA10 &&
>> -		   !(flags & AMDGPU_PTE_VALID) &&
>> +	} else if (!(flags & AMDGPU_PTE_VALID) &&
>>  		   !(flags & AMDGPU_PTE_PRT_FLAG(params->adev))) {
>> -
>> -		/* Workaround for fault priority problem on GMC9 and 
> GFX12,
>> -		 * EXECUTABLE for GMC9 fault priority and init_pte_flags
>> -		 * (e.g. AMDGPU_PTE_IS_PTE on GFX12)
>> -		 */
>> -		flags |= AMDGPU_PTE_EXECUTABLE | adev-
>> gmc.init_pte_flags;
>> +		flags |= amdgpu_vm_pt_clear_flags(adev, params->vm, 
> level);
>>  	}
>>
>>  	/*
> 
> 
> 
> 

