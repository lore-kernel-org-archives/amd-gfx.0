Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EECB606A326
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RbK5CGS0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3BF510E07B;
	Mon,  2 Nov 2026 13:37:30 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E59B10E07B
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 13:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmSq02aZ2n2YAS26dQ+DLSbLG1Pxr8YMKOQrso2pi0WXaYH2ntJ9kgE0dW8frqrwtDXz/DoWsC6X1AFYjIsYKfJCnNe1cHgcy39YoF7Mjf32i6xoUq0gEabbryHrJKIcPfuNLdyA1w2WSA0KKi+qA/tWF/iXKEuT/7UMZeP7Us7oB0F+ZJ5VO0NDwlb7qamEjMr+DpqgnSMiVboT+cUWCQt5N0QC5Rw6NkCFRUXvdOLEBBIxccKh80E5DraDNOVVumE1fdnauUskzmDGqF+a+boAUo+m/BYp2eq1Pt2PyM0fl1wN7r1VxIA+qxk76HHFE+TomoCnGGr+GvGmcdVrag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEbv6hW5RLfsKFn6SQPhnFgjBn6+UFv5Yffpg7foWf8=;
 b=OHVb9xK4dS1Zhi2wnfNdj80zuKBqzCMEyMPYN9r5FOk0LFceTVgsDHCT5MdV66GK+0Uhi/+5onyMxYQxUm0ZcIk7HDhifFXUcAe1mUAEKWxdCuphC9uMfWuCv2lhtzHpuZR26GwX3pC4XnlGVJF9IEZLuWpVbvu81XJN1sU88B8I6XOoXaSE+YZU+5WAR6QPOC0+IaQGjhyHG/LwWaDqYGxXrfpZxsH0Xv2xiFwHxUkQPFxOG/oX9aTffDtzszjuoDbLUmZadV/m4TyA939e4hJ+ocDGYvrBoUe8R2EjDsDepXb+i2TPyVJPS2MI/dqY/EDTmCx8y2d8UR9JHOkc5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEbv6hW5RLfsKFn6SQPhnFgjBn6+UFv5Yffpg7foWf8=;
 b=RbK5CGS0XPHdgQD562Ajj3rO5gfspUny99Nl4y4vp+FvVIagGanVvc5snCm8JmMkvA2ZbSmgkqXxoDD7jQWats3IYf4LJFx3gMt46ttRfBsEQKFPyX0wmwdXXgh7BXKeGDLsn8ANhqpiTKw/6d8HpLNcKSGv7e/XE3tRHDtW94Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:37:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 13:37:21 +0000
Message-ID: <4bdd68bf-9168-40db-8c00-0a82f86a532a@amd.com>
Date: Mon, 2 Nov 2026 14:37:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: rewrite all PTEs of the BOs after a VM reset
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20261102082510.2149814-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261102082510.2149814-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 01032632-26bc-4c7c-5815-08df38e66b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|11063799006|5023799004|10067099003|261028144727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: 7qePQxDi+lJp6ZXN/iv/tzyj1x3JqLfaDpyD8ORt0Wn5LhUKMR6nUPPzYzm5hePuT/uMRqm/YkF6Jth6QFkyonkEVKA+7Q6zxaksUG9dfD1zMj6B/5XAmZEwo7QhtJ50lusMnaqW+Wnq3aXI8oMDB4QLH8n2TDo2aGePizuQo4X1bqoViVaap+x44mX4wKSEfRLUJSZuI0cqjRcQpAnCBKZjtGKKkE8fZF9iFNnsLomgLiPWrUGAbFpBKi6WiiZ0B4N5eGcktx4wptGmfIbmqRu2156FsVNeOD+0XZ5jIeQGHrALIkbjQUiU0UlRJxDFEDAwvR+nV+ZaU5Powo71owg2dbzCn58mEu9VAPW1B6zTTec7UiNP9a7sjaRMILg4NkQQkWOYp7fT5R+6eqZlRv8tJmpbDcBuPYI+3v0Qvfa5w7ZErIipZ9LilLRiNq3vHr8MmNyc6dTtfczcNMs1JN7ryGqsij58B5IaZfHD8BwpjzM+m+5C2TwtP8iA24ULYwRQyqu6XlJKUC3FS/yAD0q22gdyMJb9xmMe0rRoPlAtbdf2rNBblywLB5+ilnT9d2wAJAVF7ByzHWzq5Hs1m+vxZkzfzSBkdRAtXGCCZlnKxlXmuIr2hRE/gIcb6+/n/LZuEBuwMcCQeM+P6BSCtN33qB9yizEOvrkzVkwGU6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(11063799006)(5023799004)(10067099003)(261028144727099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2hLZk0zUkNFVXozWEltYlkzVnZNbGdvRVByTUh4NzV3K2ZjK3Y0M2pISnN0?=
 =?utf-8?B?dytRcENaWG9HRUJrUWVjVU5DYmlZK3Nna0RIUkdKZllXaUNEWXpsZkY0bG9s?=
 =?utf-8?B?SzVVWUptTXBaRVEreHgwWDNhRE9pK0xUUW5kMUpDWnRBUE4xT3B3L0xlaCsw?=
 =?utf-8?B?SE4xTnhWQy9LSldXR1RuRkQ0c0JLSStIWnpuM2Y1R2tKSVFiVjgrdzdnOWtG?=
 =?utf-8?B?cm5sRE1BaERtZ2F5bWxwMjRPencwaE53dGlSeUZKK2xBbnpQa0NxL1pvY1Nm?=
 =?utf-8?B?WGRPSVlVYVlJMkI2d2xmUDRRcllrckg2VlhUUnNMdldqcW9wRk9SNEx2eEtu?=
 =?utf-8?B?dGI3OG5tbWZZcGlvNFhqQjBWU25sd3YrYkduVUZXQUlsSTVDZVRsWXQ2RzdG?=
 =?utf-8?B?RFFiT3BxRXFqTkZUL3FmNFExQWsyeVRFbElFRFpxaWJoYmN0Mzlaa3NpNU5E?=
 =?utf-8?B?ekxsRERVLzRQODFvT0dGUDJlNURLamEyRnJBVkJLN0NZWnpobzNOdWhXUDVV?=
 =?utf-8?B?eEVrUlR2TDV0UmZDcnlzWk5PbG1pVHBuUFQ2VmNrTldpaEdCYXZKVnBEWi80?=
 =?utf-8?B?akVoUkkzWDdjSHh5T1h2OHJEVUF0SGFiWERRYkNUeVFQY0kzZit3RnpHc3BX?=
 =?utf-8?B?bWp0b2lTbEZxbDRzZVZqUEc2T2lXVk01bHNyMWZwRjFhcitJeUZpY1NOeXUr?=
 =?utf-8?B?QUhCZDd1N1NMNFpUL1d4Uk40R0svTDZZQm9UL0pYS3NKWmgzYjMrNkcwZkRh?=
 =?utf-8?B?QllVZUUyNE5CVmRDV3lSanVqN3FXbDdiWDJ1WUNmZEw1UG45RHBhNXhMakpN?=
 =?utf-8?B?YVdnWjRCa01uUFBHYk54VUdKYWxVeDBxc2tSM2RseWZYdkx1ckp5RnR1VnN6?=
 =?utf-8?B?S3c3cy9WSzRpUXViQ0pHbFRZTlR1dms2K0F0QXBVZ3p2NWNwV0t4UzNoV0J4?=
 =?utf-8?B?RUgzaWxQcDFGNTFoZFVmaGlIdEVHb2RkWUg1UVU1d2dnUjI4ck12SUVQdURm?=
 =?utf-8?B?Sy8rN3dMUEttS0dWVjRuVGtnd2dsQ2FyY1N0Ym9zTzI4UFAzSjAyd0RZdVda?=
 =?utf-8?B?c3hGcTZBWUU1d1JnWXZDOCs2Q3VQZk1YZk1OL05BdXdNYWlYVnN4RW9udklW?=
 =?utf-8?B?a2lMcFlEZUFqSWJaRUhWcGZuOFNHNXVGTGVTQ3EvWVY0M0pwSWZveGZJMGFZ?=
 =?utf-8?B?YnF1MnRhM2pCL0htZ3BxOWwrWkw5MHNnc3crRXk3UkMxaDNjbnJmdmptWnpo?=
 =?utf-8?B?YmJuUmh1bWJoK3psZkdUbVpPVVJ6aXFHQTZGdW5zTTg2SXpKUmVxcHR1WU0r?=
 =?utf-8?B?SzMvTGJ1NGtkazB5YXNuYitpVExPcWhSZ1BaSk1sT1dYdUFmNGwvbWExa2Uw?=
 =?utf-8?B?VUV3cjZPV3R3Y3BOWGNJckdxek1qeEF1TmZNcldkUkU0K0JoeGhMK0RCT1BS?=
 =?utf-8?B?Sm1WN3U5RElOKzQ3WUhDdTFsa1ltOXNqSTBESS8yT3FDSkdPNWpUNnhzRFV4?=
 =?utf-8?B?cGh3a29QMDUrcE1Ld0gzbjJydnNRZW9zTnVYYXYwMHZ6WmpyS2ZNVy9Qa2VZ?=
 =?utf-8?B?bHVnOWF1UTZaWnh1ZHFUTmZPOXcxZC82VytkRjhZNkVGUHZpNkRPOXoyWFM1?=
 =?utf-8?B?dEE0R0VUQ1hmcVNla3dCbFNIdDBkbVZ3VW9WMFY4S091cmhtT1hzeHR0WUJl?=
 =?utf-8?B?TG5ZVmd3Sjl0NTlYa21qSGdEQXhqS0h3WFJweVozOFd1eEJ5L2ZZT0swR1kv?=
 =?utf-8?B?b0xybUlhTjlpby82Yisyd2ZpZEoybW9ac0tLMGdvbGdvUUdNSGdvcnVjL2hD?=
 =?utf-8?B?RE5odVA2Q3RLSjlwc0dqZmNteEhyZ1lucTNqUGxJL0krWHlOODVjcFg3Vk1o?=
 =?utf-8?B?ellJNm9rWGtERVR4ZFc5dVZ2dHo5c05tZ1hETThKYUxlbFRIU1drbURnWk5L?=
 =?utf-8?B?eU1jMktFaldUMVF0QThCZTZSelFueWlDWVV3bG5QTmxiVWYxWXdleEZKZFBI?=
 =?utf-8?B?MEpvVk1qaEQ0ZHVicU9tUitmdCs5TXdyZHJ1UmdVMGhhdllIRnpjQnl1U3RE?=
 =?utf-8?B?K0Y1b1NWNDlVSGo5V0ZZcjB6R2dacG4vQTlTbmNaTGF3ZlZtZWZZNU5iQldI?=
 =?utf-8?B?MUhZSjhiQXhaVkU5OFA0TnBER3F3Y2p5TkxibGhsc3pTRGNzQXM2UXBVUGcz?=
 =?utf-8?B?aDNqUGE3RjdMS05jejBSNGlhdERDZFBja0xqeUdBYksrK0kxU0pPVmc2ME8z?=
 =?utf-8?B?TkNCMTRLUW13OVJiWDdRR25mTXdCdVVuczVTeUNkSUE5R3c2SzlMbXN3RG9W?=
 =?utf-8?Q?4vxJ2dWMDqSG+IjCnW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01032632-26bc-4c7c-5815-08df38e66b65
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:37:21.0117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0J6idmSQFR4Nf670HFFHF7UtqD0tsWvMx75J9Taef5ogPpPMgJct5ecvaQG3/WI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/2/26 09:23, Jesse Zhang wrote:
> amdgpu_vm_bo_reset_state_machine() moves all idle vm_bos to needs_update
> so that their mappings are written again, e.g. after a GPU reset lost
> VRAM. Since commit 5be7f6720a0f ("drm/amdgpu: Only set bo->moved when
> the BO was actually moved") amdgpu_vm_bo_needs_update() no longer sets
> the moved flag, so amdgpu_vm_bo_update() writes nothing for the kernel
> and always valid BOs. The same applies to vm_bos already on a
> needs_update list, e.g. after an AMDGPU_VM_DELAY_UPDATE mapping, where
> only the new mapping gets written.
> 
> An SDMA write to an always valid BO after a VRAM-losing reset faults:
> 
>   amdgpu 0000:03:00.0: VRAM is lost due to GPU reset!
>   amdgpu 0000:03:00.0: [gfxhub] page fault (src_id:0 ring:40 vmid:7 pasid:9)
>   amdgpu 0000:03:00.0:   in page starting at address 0x0000000100000000 from client 10
> 
> Set the moved flag for all vm_bos on the needs_update lists after moving
> the idle ones there; the root PD still goes back to idle.
> 
> Fixes: 5be7f6720a0f ("drm/amdgpu: Only set bo->moved when the BO was actually moved")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 65974c0e7a16..2ba33212d507 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -271,19 +271,27 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>  
>  	/*
>  	 * Don't use list splice here, we need the special handling for the root
> -	 * PD and set the moved flag appropriately.
> +	 * PD. All mappings must be written again, also of the vm_bos which are
> +	 * already waiting for an update of some of them, e.g. after a map with
> +	 * a delayed update, so set the moved flag for everything that needs an
> +	 * update.
>  	 */
>  	amdgpu_vm_assert_locked(vm);
>  	list_for_each_entry_safe(vm_bo, tmp, &vm->kernel.idle, vm_status)
>  		amdgpu_vm_bo_needs_update(vm_bo);
> +	list_for_each_entry(vm_bo, &vm->kernel.needs_update, vm_status)
> +		vm_bo->moved = true;
> +
>  	list_for_each_entry_safe(vm_bo, tmp, &vm->always_valid.idle, vm_status)
>  		amdgpu_vm_bo_needs_update(vm_bo);
> +	list_for_each_entry(vm_bo, &vm->always_valid.needs_update, vm_status)
> +		vm_bo->moved = true;
>  
>  	spin_lock(&vm->individual_lock);
> -	list_for_each_entry_safe(vm_bo, tmp, &vm->individual.idle, vm_status) {
> -		vm_bo->moved = true;
> +	list_for_each_entry_safe(vm_bo, tmp, &vm->individual.idle, vm_status)
>  		list_move(&vm_bo->vm_status, &vm->individual.needs_update);
> -	}
> +	list_for_each_entry(vm_bo, &vm->individual.needs_update, vm_status)
> +		vm_bo->moved = true;
>  	spin_unlock(&vm->individual_lock);
>  }
>  

