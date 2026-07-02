Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F980C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 08:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29C6910E49E;
	Thu,  2 Jul 2026 08:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1brKmmVb";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013023.outbound.protection.outlook.com
 [40.107.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C2B10E49E
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 08:10:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqNiHgkziKgVjP03qOO08giQFMmreUsN4Z8HiRQEV4FTiKUHjybM/NAQDMgSfHM8DxKPVaLOvd5KBODIHbS9ai4uTPqZtm24yVVDYmhiqlmWBwQxrkW+2QLNF+MLwwIset88DtdHeL8sW1xNQr/cjk97YOgzwZxmJtIv/VHhCYpdpQ0iPENeY+cFYq6okfU/aE5bakmTN9lgqmDhrwqfPmVaPEj9eyCV9l/RvvDgp+pVagB3hTtcS4IigCGYagH+mXEGO+yI4lp788nuH1DFbwQv9hl8wF/iEMF/S8QB0RJEI8SEEp8FysROfMeBZV2Zk6Vv3PnT1QFMarOpP8CT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6QRBYOPDkVI1+6BKYi+eOOkOqZGx4BaOxa+qYbO9QY=;
 b=V8SNOavP/g54hjUkPgVEoIKtqyRGJnLzTTYqmPqoqytZISYecBeIAAOXabbzwb6FkieMSWN2XAMikjQrdAGAQXbG03N3MzqQV/xkerpeULg7aHibMjtqDxgea6N8UZ6qiKt+GlnMVvZVU8/VgwbVS5gDcoDAAUQw9CokZwtZxfUEExIICzWcT0FwlGVHsqlCLZnGRaLnVrMqMgyMZrUbEZpGUfFqd1Q/lH7+3L2Chq+3tUj4WLbAccB7vZw+lU13egbvFEXysQlDdYTl8mAfAzBH8ERDJISnh+2+HVE0HFfGPk+jhY4CLtv4NX6v5ieQZTraaLul1ToFPeUP3QH2uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6QRBYOPDkVI1+6BKYi+eOOkOqZGx4BaOxa+qYbO9QY=;
 b=1brKmmVbMI5hkk8ZPA/uvhoE+TaPQ6B+E3BCAqjacYQh1bojmTAmk/f96KSKUW8NTRJFcXAz+Ac6etFNFOkjJn1COU2CBX9XVh2xu/U9qjqQQ+G7kAQjrSaoLyrOClwTJY7EFTwFEETriEkJ5TsVVBSfTD9Kk3I0FvK0GgXAu78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 08:10:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 08:10:17 +0000
Message-ID: <be24281a-465b-420b-9279-a749ebd79ba1@amd.com>
Date: Thu, 2 Jul 2026 10:10:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] drm/amdgpu/gfxhub: Enable retry fault interrupts
 when needed
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-3-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260701161721.85681-3-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c088d2-c819-4d1a-3009-08ded81159e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|4143699003|18002099003|56012099006|11063799006|22082099003|921020;
X-Microsoft-Antispam-Message-Info: q6YhJrwoVL2hweq1AShHH8Dh/0CCCJEkEJnsBBbHj+1/WvBV7YQ5+SykL06PYyVTy6MUCD+EB/rDoCL2Lg8Dp5re8FB05LIxF+jiwfJ5/mmaz9cA2fmAktZqQvLTJcOlX9xt0tmrMbEojcYhyiy2ioD5ac4xawkVs64VxaZuRhShSd2aL+d5KNXGm/c66xNFhRbP8IPGbVYDY32oJ50pHM7+afu16c9K69lymvU3iFybYPRXSjgcYDXlY82Cc8c3OAVMu6AuUjaQ2UrIlJjDHWyodC13D30LG7boopFihOY1gZXGV+PTGC0UpC0UmI3DoxWua6Y2jwnQW0Pwhb9MhyHMpOP11oJgxAW79legfm44o2cfnr04CDJkbipCzfYJqsQ8r4GKJ0kOW5WqH7zk4WnldyyF9rd7+WUCvdhT8MYhYq0aRDEcYHqF5CXo3qLPMDoa/fAVoBSoO/WLm6RHvA3mi5vlME8doXNLMV33LOMhLqCAitiHeQIVVr3RWAGR937qbMAOY5jan2etp22ARPjNRGwCBjsjx6J0wlylyghUf889hbm3bOA9GCysu5jP7u+0sndQbwdoC7qwHa/whBqAS1acCdo9IjMWbN0HPY8XZeoxg5GBF/Ir6wkdIrH+Khh1y4mb6S7EmQpiy/TwFsbkMW+dM52tCp0V2/WvMr5sWyax5SpYh7s6Ov63/Tie5Xlz8aHdsEua36J8WcSDhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(18002099003)(56012099006)(11063799006)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHRPU3p1Y01vSnFCV0IwakV6R2NpN2xhWkIvaHFTVnFpaXY0S0FqRGZHQnUw?=
 =?utf-8?B?YmYxUUc0VkJId0h2Nnk5d2RidmVDR1RDVDhLL3R2TlN3TWZMU1BNM21pQi94?=
 =?utf-8?B?U1FlWDdTU0JSSmxlSnhKTUxScEZpUCtlUmR3SmV2NWhJOTMrT1JaaXdBN2FX?=
 =?utf-8?B?SG9OYUp5KzRpTHNtT1Q4RDN0ZFprdEN1N21IWlJHYjVXdTBuMjFPZjBPUUts?=
 =?utf-8?B?UXVLK0MrY096S0w2MXM3eVJuTzcvNzVZa0hMekN5dFQ4MlV4b21LNUVoemVC?=
 =?utf-8?B?L3BpbkM1ZHB6VVNRSVlUUmZ1Rm45eEtleHRFekpCdTRkTGdQb2pFZ2lQajNu?=
 =?utf-8?B?RUU5aGZWd3BnLzRVMnNVcnlCclhzU00vUFVMbjd1VmJhOGZsOU9SSGtEWERP?=
 =?utf-8?B?UVk2d2ZFaXJWdTdiUno0bjVPUEZSVHVPYnQzUm02ZlkrNlFXNmtyN2dJM0lt?=
 =?utf-8?B?Z096cWVVL3Y1YW8zMHBuZ3VTMnZCYlhEb2paL2lVb1hhd0o1eFhyV3c3YUw4?=
 =?utf-8?B?bitGa09DR3E1Q1JYTWwvUkhoS0JPQm1BQXNMNENRRjJPc3REc1hZcURCSWZB?=
 =?utf-8?B?TTlNOTRWRzBpSnp6dnBzMnVYNzhzUkQrUnhLZUplT3VPYlg2RjgrUk4vSGdD?=
 =?utf-8?B?OFU5TDRaMnVLRjRIclhROXhINXc3Z3YvaWJjeHJLSkpRTC9OMTZhZm1CUnlD?=
 =?utf-8?B?aXNHZXNIUDk3K3RxNFh6T0dpVWVVdDgxeHRIK0ZqbzF1Z1RHOEdJTmI5VkZi?=
 =?utf-8?B?RDJkSHY5K1F0TFBIaGJqWWZPUnJXdWU2WmVxY2J5UmxaUFBOTEtWT3ZIeGM4?=
 =?utf-8?B?c2phbXdPcTlzZVEvUUltM2w5dFBScVUvK29xQ2prSHdSZ0J3MjdoK2FmZHdG?=
 =?utf-8?B?cW1oZ1JkQnZVbTdOSzZtcGxHRmx5c2VnUS9kNzJlanlucDFYV1o1VjBoSk5q?=
 =?utf-8?B?TVJPSGVPdy84WXZ2b2dTZEk5UVpwNmZqSjhOc2JscU1ocUExOTFIRklqT3ZZ?=
 =?utf-8?B?ZVgxQnVqckJHTlVIeUNBelFaMVVKRjlWbTZCb0wyRnhsd09zUHdGZ2ZaRktz?=
 =?utf-8?B?Zkg3SDRJMG1ZQXJrQW1mUkwxY0ROeklSU0xjSEVTaVpleWhIWmgvOXh6UUdT?=
 =?utf-8?B?dVhmdmdKbk5BSVFOQ0JyUEVaSWwzYkJjMXBpZWVXRTlEK3VtdVNGeEdVOU1p?=
 =?utf-8?B?MGFBS2tSWllRNHBTRlB4WUdXTjhXLzdaalNJc2lpOGljaklUcXFLRnlUczlr?=
 =?utf-8?B?ZlFJRFJ5Tjg5aTRoaCt2VGJBbkRnbHViSEo0cVV6am1tK3RCZ0s3MHBqWWhL?=
 =?utf-8?B?RGVtZGxHSSsrdEs1WVR3R0VIa2huYmlXT0p0Q2VRalpZVkNIazNyZS8wMVpO?=
 =?utf-8?B?OG51dWtPRHk3MVdCL3gvZ3B2T2xzUDNBamgvU3NsUUk5TGlCbHQwTkNvM1dj?=
 =?utf-8?B?Yy9JaWlCck5mbHgzc2dTdEtxL0wrVTFEUVZudnk2SHBoVnJQZVE5cHpBUnpy?=
 =?utf-8?B?SVhvcEhnTnhvVVJUak44RzZsOXBqb2NwMFZmclFpRzFmSGpzb0VMMm5yRDJp?=
 =?utf-8?B?R2JzUDJmTnl4NmxyZVRjMjBxb0N3b1hZQ0FPN08zN05lUWVKRFU3RGhwcDBR?=
 =?utf-8?B?WmUyTFFBY1JCckNwZFNZZjNDQUk3eXFsUzBEem5mNE0xUGlPcFhyaEhTMzdv?=
 =?utf-8?B?MWZWVFNhRWJmT2U3ZzRUVEJGVVlIZmh0K3kyMTlJY25rMkFZMC83cXhSOXpF?=
 =?utf-8?B?YzlUaHBOdjV6dTRpaEJTL3lvcGJVVjFNNDZvc2dCeUJlV2QwWWQ2aW9uc3N5?=
 =?utf-8?B?ak1TYlFTQnU5RDY1blk1eGZBc2djYlkwQ0hyWG1wQjdWK2xPWFpCQ08zSllR?=
 =?utf-8?B?djJCb2dQZS85ekh2cVV4TnNjdFRYMEQxbm5KdEdadjdxaWFVcDVmV0puTEdz?=
 =?utf-8?B?SU1WOWtCY3g2QnBTSStiKzQ3Rm1Vbk9kWHFvK1BJMG9lMCs5WStFTUxHdVdS?=
 =?utf-8?B?aUNKdXcvMTFldi9ydGZUR3duTXlwUlFnMS9hZWRtSFprNFN1cTVEREdmUVVj?=
 =?utf-8?B?VWFQazUwQ1ZtTnJwMkMrcmNZVGVPVUZrQW54aEQ5STZoa09LanU4L3Z3czU5?=
 =?utf-8?B?TkRTekdqSmRKM2pKNWtxaFJmeWt3T3llR05KS2ZrM0QwQnNIQ3QvYTU1VUtE?=
 =?utf-8?B?ZGZqaVNiU2lyNTVVUFlrYUNsb1BqbWNLNXR2Z1VNU0haTktqRktWb055SmN1?=
 =?utf-8?B?MHdlcVpSUSt6eitUdXJHcTJkdmVFNGpVYndGcnFBRkFUTDFOZ0RObVkwUElZ?=
 =?utf-8?Q?sQDI13z8EeHoKED9+r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c088d2-c819-4d1a-3009-08ded81159e1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:10:17.0101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ec+j6NFQy5qNYJD9FlW/LC+UCMh60obLWtPEojD89X47WguILk01bJt+lw785she
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8165
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

On 7/1/26 18:17, Timur Kristóf wrote:
> Enable retry fault interrupts when initializing the GFXHUB
> system aperture registers according to whether retrying
> page faults is enabled in amdgpu (ie. amdgpu.noretry=0).
> 
> Needs to be done for each GFXHUB version at once,
> because none of them actually enabled this interrupt.

Thinking more about it we are clearly missing something here. The retry fault interrupt itself should be enabled all the time.

IIRC only the RETRY_PERMISSION_OR_INVALID_PAGE_FAULT bit in the VM_CONTEXT0_CNTL register should be set or cleared by the kernel driver or firmware to control if the HW retries the access or not.

Regards,
Christian.

> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 2 ++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 9 +++++++--
>  8 files changed, 51 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> index 652eea6eae4a..ef20eafd59ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> @@ -155,6 +155,7 @@ static void gfxhub_v11_5_0_init_gart_aperture_regs(struct amdgpu_device *adev)
>  static void gfxhub_v11_5_0_init_system_aperture_regs(struct amdgpu_device *adev)
>  {
>  	uint64_t value;
> +	u32 tmp;
>  
>  	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
>  	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
> @@ -180,8 +181,12 @@ static void gfxhub_v11_5_0_init_system_aperture_regs(struct amdgpu_device *adev)
>  	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>  		     (u32)((u64)adev->dummy_page_addr >> 44));
>  
> -	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
> -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
> +	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>  }
>  
>  static void gfxhub_v11_5_0_init_tlb_regs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> index 6cbf837d50dd..ec3ff4dec674 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> @@ -158,6 +158,7 @@ static void gfxhub_v12_0_init_gart_aperture_regs(struct amdgpu_device *adev)
>  static void gfxhub_v12_0_init_system_aperture_regs(struct amdgpu_device *adev)
>  {
>  	uint64_t value;
> +	u32 tmp;
>  
>  	/* Program the AGP BAR */
>  	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
> @@ -184,8 +185,12 @@ static void gfxhub_v12_0_init_system_aperture_regs(struct amdgpu_device *adev)
>  	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>  		     (u32)((u64)adev->dummy_page_addr >> 44));
>  
> -	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
> -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
> +	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>  }
>  
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> index bfe247b1a333..27d7f7cb903f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> @@ -91,6 +91,7 @@ static void gfxhub_v1_0_init_gart_aperture_regs(struct amdgpu_device *adev)
>  static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
>  {
>  	uint64_t value;
> +	u32 tmp;
>  
>  	if (!amdgpu_sriov_vf(adev) || adev->asic_type <= CHIP_VEGA10) {
>  		/* Program the AGP BAR */
> @@ -134,8 +135,12 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
>  		WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>  			     (u32)((u64)adev->dummy_page_addr >> 44));
>  
> -		WREG32_FIELD15(GC, 0, VM_L2_PROTECTION_FAULT_CNTL2,
> -			       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +		tmp = RREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL2);
> +		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
> +					 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
> +					 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
> +		WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>  	}
>  
>  	/* In the case squeezing vram into GART aperture, we don't use
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index fbdf46070b38..ed9a64bc5aaa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -176,6 +176,8 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
>  			tmp = RREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL2);
>  			tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
>  					    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +			tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
> +					    ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
>  			WREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>  		}
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> index 9ea593e2c719..152b2735d360 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -151,6 +151,7 @@ static void gfxhub_v2_0_init_gart_aperture_regs(struct amdgpu_device *adev)
>  static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
>  {
>  	uint64_t value;
> +	u32 tmp;
>  
>  	if (!amdgpu_sriov_vf(adev)) {
>  		/* Program the AGP BAR */
> @@ -178,8 +179,12 @@ static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
>  	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>  		     (u32)((u64)adev->dummy_page_addr >> 44));
>  
> -	WREG32_FIELD15(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
> -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
> +	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>  }
>  
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index 30b90d35abd0..83c2ddbbd292 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -154,6 +154,7 @@ static void gfxhub_v2_1_init_gart_aperture_regs(struct amdgpu_device *adev)
>  static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)
>  {
>  	uint64_t value;
> +	u32 tmp;
>  
>  	if (amdgpu_sriov_vf(adev))
>  		return;
> @@ -182,8 +183,12 @@ static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)
>  	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>  		     (u32)((u64)adev->dummy_page_addr >> 44));
>  
> -	WREG32_FIELD15(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
> -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
> +	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>  }
>  
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> index 9e6a6e13dec0..90bbb2fe4884 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> @@ -150,6 +150,7 @@ static void gfxhub_v3_0_init_gart_aperture_regs(struct amdgpu_device *adev)
>  static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
>  {
>  	uint64_t value;
> +	u32 tmp;
>  
>  	/* Program the AGP BAR */
>  	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
> @@ -176,8 +177,12 @@ static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
>  	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>  		     (u32)((u64)adev->dummy_page_addr >> 44));
>  
> -	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
> -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
> +	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>  }
>  
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> index b3b1085c7cd3..1b3c067ab48c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> @@ -153,6 +153,7 @@ static void gfxhub_v3_0_3_init_gart_aperture_regs(struct amdgpu_device *adev)
>  static void gfxhub_v3_0_3_init_system_aperture_regs(struct amdgpu_device *adev)
>  {
>  	uint64_t value;
> +	u32 tmp;
>  
>  	if (amdgpu_sriov_vf(adev))
>  		return;
> @@ -181,8 +182,12 @@ static void gfxhub_v3_0_3_init_system_aperture_regs(struct amdgpu_device *adev)
>  	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>  		     (u32)((u64)adev->dummy_page_addr >> 44));
>  
> -	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
> -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
> +	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>  }
>  
>  

