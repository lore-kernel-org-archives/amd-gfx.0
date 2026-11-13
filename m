Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F2A606A33B
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZWJTnbTf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EEB410E569;
	Fri, 13 Nov 2026 16:05:22 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013014.outbound.protection.outlook.com
 [40.93.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2CD810E569
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 16:05:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9P0sdqHfWm5hE8EAxcW2gVokNE6yWiqeT2QD8Dbm73pTNFUlicfFbMGNqbWcecvECcwB/NhLDA3sJlWs5gCzS8v2iEXAYl7CHKTjOhg9mcyCO1YKG43sRtPXSozXV5xLaOoHe3iHai5wLgvmkDSVm13OGLoMF70sZkPHx+QIFWeD2NZlzIQOgi7T5O9Zx6SS5juofIjWjYXqHGtaKirBeF1rXHlNyLS74RBVb31lDqsqYYiYInf2lC4ZTbmR1vlxsfbnGMhYNNAtH6qZQhDlLUVIYSacnznsjyciRa5oPViaiR5wluDfVgbJRDJXm4RW0HmKqCl0R75Ih3vICHxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8uEhj2PK1X7YtzxvHE6F5YW9uxAMFuXCfqvmessXNw=;
 b=O3T66Z8WGkogoHPGjVCnJ8A5wQNwsXYVj+7KlC8/srhHaRh7wBeUfnu3enkx45k/+O9g1Sq2bOqKU8RxSDOah/KR6EDg5OG8GokqwMd80T/0aFkK+rWLk/XddfJOu+WQ9yNu76L9GHZep8/+JMfV7JrJe3u01D7Iq31lNe3mEDQpH2XfwABZjd3XzEK2xYR6Lc4EC8Qp5T5ejbcN+70WvlcOpFMWrIVasD+2vTK5Ur9pgpzO0Qr1om/h3e0GQdSRneaMCsTVm8YlVPbLAG/qlHEOSEeFakicswvnBSSJZNgIHkQi85t6dBx3YJCBSNfPTFQNwu3eEE6TteENHyJi8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8uEhj2PK1X7YtzxvHE6F5YW9uxAMFuXCfqvmessXNw=;
 b=ZWJTnbTfqk4xijFm7WHTNBI5PCyau0gseIiLb1HkNWCrYxpi9I68a41ygk2zYmgPkC51PlPns4JlFY4PdG0LQ+q3faOd6IyS5EeNci4ioCTF9feP/OwUVj4sPl5KpJbHzN8s4FylLv5MO//OXsISSx8A358fgZb2GinrduqIzNU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CY3PR12MB9680.namprd12.prod.outlook.com
 (2603:10b6:930:100::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 16:05:09 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 16:05:09 +0000
Message-ID: <283e9c84-ab35-4068-9fb2-c4a08e4b6671@amd.com>
Date: Fri, 13 Nov 2026 11:05:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clear root PT after setting vm->is_npa = true
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com
References: <20261113134017.2781893-1-shahyan.soltani@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261113134017.2781893-1-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::9) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CY3PR12MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: 233d2140-2f31-48fd-d2a0-08df419fe3fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|261009223027099003|5023799004|56012099006|10067099003|11063799006|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: mRdTIp+yKBmgOkeKaPd8XvFUAAqoP/GqnnGm0dvMs8FbR6UblrI0O7hMn/NHq5h8S1vyJRxnyizLaF1YWuiH3KL2R8YZlB4tGgygUFmU+UVheo2FhTE7bH2vELqYnD1kdRUbZtrjCvtkYjTl320+ekSsKETHAIBZ3K0yQxetiVYw2O0PJmyz5H8JVtC+hYCiYkaECrHCXkK0TAM89az70jUq+36CZsJPD2Ip8ZxhbLb6VXqVFq9MzmTD0X8SncYlayCWdkRaD3yqQngsZcxDAY4B6C7zNsac7hUlKqrWft887zsCrW+DylO7IvSQAeuvAApYYogWY5k53rO1cYrsR/rdZAxJgmzsiC8YRXqt9dyJdc/HslaKdAGb+VHDrVfpPXH9uRVdv/Yxa7DABzSOU/+5gsJFSABWb5y9MPFYokRevye3QHQsB78bTZmssNyh/vW8qd73lozTZazy5rzB0vhf1yuMfWFQm/s1z0y+5r/zF/UgPSzVIq7d6Jw6dA2oKABy8/u+suvMwnjzxtG9i4VN+s2zA2Jt7nSxRYGe50AbXV2gqzqII+YmOpX4qEq95q4iHbNWqkYnVvUZBiZYjT5PgXT5RmH5pi0h/3EZXU25M8kPLWCns/0aDSwXaCscK3xLMAfeuNeAEBUDUi7mtn3GuGXaRJd+3d1a7hjn4oE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(261009223027099003)(5023799004)(56012099006)(10067099003)(11063799006)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2dnNWtNdTcrMEJjZEZ4Nmp1VE5Od0lDRHA4Tk1adEtnTW9VbUU4UmEyNHRr?=
 =?utf-8?B?MlVwT3IvQmFZSCswcERvQkVHdFU5SGVBN2J0cklaY0piYktVUWd4VGJzOWFp?=
 =?utf-8?B?MndLbk5kRDI4UEN3T2tuWklFdzMyYzgvSm9INGlrZ1hhYWdlRTQ1eW9HNkw0?=
 =?utf-8?B?T0xPTzZWYWNhVzZ6SjNFRjVyL283T0drTGNkQlhqSTVXR2NnVkc1VFBnQVh1?=
 =?utf-8?B?TWJWK3lwWis3ZTM2Q3dmVC8rb21lOVFuQjhTbVF5eVhxVEFFQ1JURzdUcmhH?=
 =?utf-8?B?NHhHckRwMU9tdnJFM3dIWE04MjFUemlLZ0hVVmw1L0FSdmFRTVdUcjFrWkda?=
 =?utf-8?B?VjlmU1AvMTJGLzk5ZUdJN0t0VFFpSXpVdVIyS1FuQ21tN2JVbllyUGNBUTZF?=
 =?utf-8?B?SmdiQUtqdVpza2ZVZ3Q4ZjNKZmp3QzR0UG82eExLTHRwOWd1U3VlMTEwVEUw?=
 =?utf-8?B?bi8wZW5wZVJ1ancrUXg3SCs4RUdoRTJncExkem1hQlpzdHR1eEd0UHhhcW5S?=
 =?utf-8?B?WmdnK1dDVG1RS0pXanU0YzQzYmdwblJkayswYVdKYkZzMGVCSUdabXJMS0RX?=
 =?utf-8?B?V2dMbUFPOTNmL29BNzhWSytneWZWUUh5NG02cUU1bWNReVNPaHkyS2JVR0Uv?=
 =?utf-8?B?ZFQ0MldlVk9sUmlIaVdBdkc3ZGhLVzVFZDFqZWlHNUs4c0lQdzhqY092Nkdi?=
 =?utf-8?B?MDhwWHdVdStzTWNDZzliMDh5dVJVVWY1REQ5NHdlOCt0c2ZmWHRWSFRnRnpO?=
 =?utf-8?B?SWJKdWw1NmRmNTEwMnVDUHF2amlvZzdZTDFuS3MzT0tjOVlLWjdRMGxZL1Zy?=
 =?utf-8?B?TkdYbnJGVk5HczFLVWF0Rk9sY1lTZkY4dHRwWk1LaG40bmhveGlsWnpiZ2dG?=
 =?utf-8?B?K1g2WWE1Qk5hSEt6TXJCR1FMUjVIV2pIeWh5RE8rNFlRQTIyMloyN3FxbXov?=
 =?utf-8?B?ZUswWk1pTjhsRW52S0ZRU2l6MWx2UFB3ZzVUWHNsdDBldFlsMXNkaExDNnRY?=
 =?utf-8?B?MlRBdWJ3M2JlekxySk1HZGROWFVNQ2JCdFUyNVJ2Nk42bm1TMzlONzA0U1l3?=
 =?utf-8?B?WkprR0k1eVhCblZzQ1lhMGYvY0xBQkdWL3l5ZUYwZ1haUEo0NUxncWpRbnEr?=
 =?utf-8?B?VTNTS3B2dTdUQ2UwWnNiK1JsT2JZcEZwUStkTXF1WTcrWnY0Q3JEMWNxK05B?=
 =?utf-8?B?OTAzR21IRkszaU5lMnNLSjZRcFJybU1kdGVhelVNL25jSnFnNFduNkVxaUR1?=
 =?utf-8?B?cDFSUVQxOFVud2Y3Y2xrQkxCZnFRK2xKOU5sTFROajNkMG1hWFF6elpUei9t?=
 =?utf-8?B?SDhCcnhrQytWOUwxcnZycytjQlo0L0tlN044dFNIRDJEVUUvOXAyN2JySmpP?=
 =?utf-8?B?U05Vam1wWGRJSjBQZkQ0QmRlN3Nsc21QL1doeWhSajNjektHajhQZmxFSnNo?=
 =?utf-8?B?ZkhFYVFPODJuY2FvZlFHMnNDSTFxN1pFWHA2VmFIMkhTQWlhelVJSGc3dTlL?=
 =?utf-8?B?VFRHU0ZRUGNGQk1JMFowK3dqTVY2VGt2QXlNbHJTSGxSeGtjcGVVa21CODNn?=
 =?utf-8?B?b2ZCOFlScU01RitsREcwZUFYZUxhZVpUakxCSkdNTTFaWlNyL2NBYkgrL2VN?=
 =?utf-8?B?OGw0SUNJRFNkSDZzOHZHcVdCbEpVVU9XYnVSWW1YNUlNaWVka0prL01RTW0x?=
 =?utf-8?B?dUR5Qi94MWluTS96UTRTMmhHRFZWNzM1RVpLOFgyVy8vYyt0dlQvWjdzZ2lI?=
 =?utf-8?B?YUNtcGo5c05hUk9CbktwUDJDQ1ByZGdybDl2SUJDL0tRc2tBUFpGcGhKRzk0?=
 =?utf-8?B?ZDdCZVZySmNuVndQZGthSDJTWUFRbGgvVGNobXRXWi96NlJIbGkraFc1dDI0?=
 =?utf-8?B?VUxmZFdTZUpVa1lIb20yNEZOSTFQb1p3TEpLenY1akc0cUhSNGdsckxKMS9h?=
 =?utf-8?B?c2lISmNXdGFRU0tFbVpLTlF6QUovZnR6Szg5RzBzS3E1bzZGcmJZR3M4VnpC?=
 =?utf-8?B?UGZQR3JJT0poSE5UVncxakNic1M0bUIwZTAvcWlTZm1lNHZRK2dxODZzeWth?=
 =?utf-8?B?MTRpR0pXQUNtMTBRL2duM0UyVmZjUWc4QjBINEpzN0NkbjdtTGpOTDZRVklG?=
 =?utf-8?B?dDJyd3I1OHI3SVBURHF1VDdVeVFkK3hWaTE0WmNRdk82dGJ6emprR3BqZ2Jm?=
 =?utf-8?B?MmNaRmVKZDIrWG95QlE2MW53SmxDdEJ2WDRDMzBrS1FhMFF6a3puL05JdjF6?=
 =?utf-8?B?aGJVYndwdWZnZ3RrZDFoL1FvRlBIRWpaQ2kvVHFHaURTL2JlL1YyNThlS0pM?=
 =?utf-8?B?eHZEekpYbWxrUHcyMDR5WXJRc1psanUraEJ2aHpHRElBMlJxZHJXZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233d2140-2f31-48fd-d2a0-08df419fe3fb
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:05:09.3126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbXV0vKRY9+GKDASsjOj8yQS+ejRrplnRSjan3f7sxL42+liZhDj3L1d5+Fra1C8Bl0j09NQM/XXWdYFNdRutQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9680
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


On 2026-11-13 08:40, Shahyan Soltani wrote:
> Previously, the root pt was never cleared after setting vm->is_npa =
> true within amdgpu_vm_make_npa(). This resulted in the flag
> adev->gmc.no_retry_flags to never be applied for the NPA VMs.
>
> Call amdgpu_vm_pt_clear() after vm->is_npa = true is set and the bo has
> been pinned/validated. This allows the root PT of the NPA VM to be cleared
> with the correct value.
>
> Remove the redundant second setting of vm->is_npa = true.

Thanks. I'm don't know why that was set twice. Must have been a mistake 
when I made that original change. See inline.


>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 94b1cfe05e3e..bc5d4bfdd424 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2829,11 +2829,12 @@ int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	if (r)
>   		return r;

We should unset is_npa when the function returns an error. Or maybe set 
is_npa later in the function. But it has to be set before calling 
amdgpu_vm_pt_clear below.


>   	r = amdgpu_bo_pin(vm->root.bo, AMDGPU_GEM_DOMAIN_VRAM);
> +	if (!r)
> +		r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo), false);

I'd recommend adding a sanity check (WARN_ON) that nothing is mapped in 
the VM yet. Otherwise this will break existing VM mappings.


>   	amdgpu_bo_unreserve(vm->root.bo);
>   	if (r)
>   		return r;

Here we need to be careful that is_npa remains set only if pinning 
succeeded. Because this flag is used to decide whether to unpin the page 
tables later when the VM is destroyed. IOW, if pinning failed, unset 
is_npa. If pinning succeeded but pt_clear failed, leave it set.

Regards,
   Felix


>   
> -	vm->is_npa = true;
>   	vm->need_tlb_fence = false;
>   
>   	return 0;
