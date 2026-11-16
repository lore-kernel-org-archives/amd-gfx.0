Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD0606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yhtODU8h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94BCF10F030;
	Mon, 16 Nov 2026 12:41:08 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 343C310F046
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 12:41:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfVFgvtR6tJ96MAIcU+BqiLkgaJTo3e9Y4AmUPa0iFsSlScUKKdiCdHVhR4owqW6Nj8L7kUnOtUejSTo5heHHDw0n7H7qis7Al5oUws3pl7/GDx57VPmlLx32tGlq2VIG+/Uh17DZg59xuit6UkutXiDOk0GXIjHcG14qPuosLJOxOI5ZpF2InTRpRE4gzVc5pmVGYUndFk0BuyuNQDwYKNgyHNQFDOVChT92afYYhAAq+acF9ZgJCC1++nMP1o+XixjX6qio5UqUHqDl3Cy91gIEsqdjFWt4fEAU938ao3801lbIpx0/vOQv0HzgDyymPBXSp1+AiC3lR/eRJ2ndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2EEP9rM4FW4p99j2GQi1LLJ8RBuMMPITnBaErSQTMU=;
 b=RbJokFFLNNR67SKZfFFfnpKf+XSsD69TU8hedyZ0cEDCSAcXwBxO12/JEEjrVgnHqEQgN3KoUMehOc0f3pZ3RknQ3prfxg9lk2IzWpBDmGQ2jQeP/WRwcvnZGMS6md3aizMOkqavZ155ev8pcSnzUWk8ueqTpLfUr6KFJiCK5GZsasZPrU8ZJnbsDlALhmRgNRnmFePJ6QBADeFyeIAaQE/C8I/6K791B/x57X0OBHkGKF4YOK3r8FID+nxYXzu4lYjbhI3cuSa6yoLmnmZMghKkkfXcFefQt54daGw9Vd7fMAHOxNbKJZexOORSfJrQ/rBcEB/U/ti5Vr7T2NqS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2EEP9rM4FW4p99j2GQi1LLJ8RBuMMPITnBaErSQTMU=;
 b=yhtODU8hKodKERZJYwDgKTK5YMNV2upexT9HGYpDn6h+X7stU0I67AGmrPiawSgONBPbQlwEY9Xvg5QuEUmZodQTJ5umMlDKESkJg3FShOYXTTlelJWyPE7O2tGz9yksz4EFj8T5AA2q/0S2aRlqN9tme66IssFTyZxLL3vJy1I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 12:39:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 12:39:58 +0000
Message-ID: <1e854e58-2377-4201-99bc-8fa61852cf24@amd.com>
Date: Mon, 16 Nov 2026 13:39:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: don't take a per VM kernel BO for a page
 table
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Sunil Khatri <sunil.khatri@amd.com>
References: <20261109022419.2677141-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261109022419.2677141-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0190.namprd13.prod.outlook.com
 (2603:10b6:208:2be::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: fe9a70f2-681f-43ed-439c-08df43deb928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lSicjlca5pCyT3EKJRzPfGfxt7/fQ8deNUApC2unEzjbN0zfJ0QUC8vYLk/s1wJvc/NGwMalp39STrcQx7RxdfVezt7qqPGnRDDXFCGtOgE7dMefKmKRwCz1zojEG3/XEB/SXgvaSv17zvlCkAVoTsJ43b1Zk0lEzfJp4mRf0aX7VPwNN9+F99BQY5mQlJOmU8KPGfwv5vfKXUDWWRS6w3spvkZPpTgyTvTPTpH41rTOgQxlFzKhgUeRa4SDlLdplwXX2FdWO2Co34IFkbKtcz5XtqiIzklEMzgK8IY0Yy+bBTYFMszt7HO1LfNGGTuFYl8PysjKIuk7G8csZtMb0snJSUDa3iGgvxseSxRXsoeVwvJoJQUOH2gmvGDgx51AyLfYbdZbZoxnHmPA9K0lfNzF7EaluBSNcVh/yer4XdsO0pNFI3xkHbAPMkeS270SZu5Ltav6/wfv/1tjSTiV/fXoNXJgYhj7/TBghFpe3STwu77ZsO+7cN2VL4M4QAeM6ODZQKMzikCvJxKdrIPReRgZA0rkeefen3Bo1sCm8slin2S9z2eYDY24u5rCa7+2kTF8t0ur5ywLvohRNf+MwVpNqh67Kr4KQH+ApYtdGfge7RM6DGHCjWqSK4iP4/JTpKGjOWwKPw35F2eVGYEKIRDe5rKG7Pjgw/v721/6yUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDJHSWRjSkJMVjFTblVWWXIyb3p1RkJuT2xrYzIra2NnRWVSdVI2QldSNGxL?=
 =?utf-8?B?V3ppMXZic1BPTzIxLzRoLzIwWDFqTjc1ZEsrMTFtMFgvYWIyTmFJaS9GR2pS?=
 =?utf-8?B?TENwT2YraXV3YXFwaVJKV3o5N0NGL3QralpTdEwrMmRxQzdlYkwzbzdKWnhG?=
 =?utf-8?B?c29pNDhvaU5ENUI4WnoxRnBnazh5RE02RUZ3S3R2ZjJsbFBISXVEYlFoNmh5?=
 =?utf-8?B?WnYwK0hRM3NrY0JqWFpLOXNESXlwSVJCZldLZ2hucVZEcEQ4VVRJQkNGb25J?=
 =?utf-8?B?bmJLSEg1WjFJOWRQb29LdmdwODZWUEplbFhmN1pKUkJKSFcrTWhyODNnTE82?=
 =?utf-8?B?VVZVNlArcWcyNGlqeFhDOXlTaFg2c095eHZNY1dDall4em5yaFZQUkhsakd4?=
 =?utf-8?B?RjN4K3pCNVFnd01TKzRWcE5nZzQrTGc2cTViOUh4dmhOTm5nekxybFp5Zk5B?=
 =?utf-8?B?MmVNL3NKeUdseWs4VXBoK0RkR2g0SG1VckZJVlNzbHZjcUhPU3NiWldDVTNI?=
 =?utf-8?B?YzBSdHFHV0FPbzBuaVRzZG0zaE8xa05YRVIzd1htRmRWbkxRMUxTa0lLYkEz?=
 =?utf-8?B?OU0vK0RLeFQ4bjBBK3Z3Mm9Ga2NYK2FTMXlmMnZCc05oM29NMkwzWTlrQkQ2?=
 =?utf-8?B?UU9zN3YrL0kvdlJIb0lOOW9LdEJWNTkyb2dGbUxza3JqamswcG5aOFFIdm5R?=
 =?utf-8?B?ZFRXWlY5eVpxUysrQWVsS1Y1WmJvVW9Kem53bDc5VDRRYkFCcFc2bVQrMEsr?=
 =?utf-8?B?Tm1hWThmVnBiRWxtQ0lkN2NoeTZyWTNvdFAyQkF6SlJ5TnRxUmI0aGpDNWVT?=
 =?utf-8?B?NTVqZnd4L29oc0FsZ001OThJRHMzanJvUUY1T25NUUlZY2lqdFMxb00zeHJx?=
 =?utf-8?B?TlY0c2ROQTRvQ1NUTmVtTEg2NGd2aDQrQ0JvL1dLRzNCcTZ6QWNHcFY4YjRw?=
 =?utf-8?B?aDc1MU0zUUFZcU5SN2ZiZWlweGo2YjJEOTlXb3ZKUjlNbjNPZHQ1VTV4V3VQ?=
 =?utf-8?B?aDNhT01RdGp4SmtwU2tRbUJDRmltMW9sUDM0Z0N6ZGdsbjlKQjdlcVB0ZlBT?=
 =?utf-8?B?eXhHZnQ3eERsaFN4SWxIcGprbVdSYzBFSHlVL0E3MHhGdTBSVm5GdUFJeEhG?=
 =?utf-8?B?Q1BwTzVyUndBQmg0VElMMlBuQXZkTFlKelQyR3NmUmRtVTVRR09MYTBoQlFJ?=
 =?utf-8?B?TWs5ZndSeFBnWnZNTm50dC93dnZPczlyWXdwU2M4L2VoNGdDc3FIV3F4RDFY?=
 =?utf-8?B?NGNwbUxhaWZMZ3M1eGw5emVabTFRNTk3czRkSlRRbHFwbkh6dEcvRVlPdVhX?=
 =?utf-8?B?UGp3UVNOVVh0bXUvMlg2bkg1bkd1b0ErMUhxdjhjL1RldGl5NmZoYVNwOGJm?=
 =?utf-8?B?ZEhNZklNbTE0TzVWbXBDYWR0cG1FVjVlZ2x3VmFUSDQwaTdWZ0FhdmFkZXIx?=
 =?utf-8?B?M2g0R01ibm9NOEhIcE5JK0xDckdaRG4yQkE5d2Jza3VrYTAwbGhKa2lDbk53?=
 =?utf-8?B?MU1ZWk1NSXY0emJGZkx5V1lFeEU2M1hCSjl5N29YWUxFcmRqa0dIOXpTT0Mx?=
 =?utf-8?B?SExNdkNjbWVEZVVnSlpsd3BZU0VKSGJPWDRVY2JUMVZBZUkvTUd3U2RQYzVV?=
 =?utf-8?B?cVVZeVMrS3RDZjJUQXdpUkc0U0Y2OTBrOHZ5ZTFySGhyaG9nS2t6TkRwNkwr?=
 =?utf-8?B?L29YaUQyTjI3Tlc2dFZ4NHFVMkxZSndlMVVmY2hpY0p1TVJ0VWVBblNIVVJk?=
 =?utf-8?B?QnN2RmxjcGtsZ21HbFB3NHV0UDRWdjZ2cENvQi9OcXpiRW50ZFVyekpVQWRI?=
 =?utf-8?B?OWZQeUlmb2dNY2VIbFk4REwxeGpIVEdZblo1Y2tGcUswaFVzOXh5eXhRandL?=
 =?utf-8?B?RlNvUzU0bVU1SE1PREt3V1k2MzhpMFdRRTUwTmVsVjFwWERnSFc0bTFpNXhW?=
 =?utf-8?B?ZERNa3hZTHpOTEFwZFMxemRTcXhnVnlKVHhQZEJweEI0aFpFUy9lV25melZl?=
 =?utf-8?B?amFLOWVOeTlZNFNRVTBQZEJiMWZPNTZEd21xZHFGRmtrcUgvTXpSaWJaekFr?=
 =?utf-8?B?YUJpeXN2MGpITTFjVmIvYmFpeTU0YzkwQUczbk5YcXhCdS9JNVRMcGNUc04r?=
 =?utf-8?B?NG1sQ2xwR3k5SEd2UXJXdUVsSnRJVjJGS0toU0RCcFZWV1EyeGQ1THljSWxV?=
 =?utf-8?B?Qllnckh2WHNzYWlxMnl3ZXFmMUw5SEp1RXZRbE15QUFxSGFpdGRZUzVPcVpw?=
 =?utf-8?B?ZENCZDQwSEhTQThmTitYSDJRSzJBWm9uNUJ0cjd2bVUycStiTTRJeGRzL0dt?=
 =?utf-8?Q?ESkX0G4psP56o7bouN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9a70f2-681f-43ed-439c-08df43deb928
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 12:39:58.0537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jiji2M0a+TcnZ64gK6nd9LJsR/Uoc2bjFg3T6pbJyZegCNS5zQX+ZuUMqauft4Uw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992
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

On 11/9/26 03:23, Jesse Zhang wrote:
> amdgpu_vm_bo_lock_lists() puts every BO which shares the resv of the
> root PD and is a ttm_bo_type_kernel BO on the page table lists. The
> CWSR TMA BO which amdgpu_cwsr_alloc() creates for every opened render
> node is such a BO, so it is treated as a page table: after a VRAM
> losing reset its bo_va moves to the page tables needing an update, and
> amdgpu_vm_update_pdes() tries to write its PDE. It has no parent page
> directory, so that fails, and fails again on every following
> submission of the file.
> 
> On navi48, submitting on a render node, then amdgpu_gpu_recover and
> submitting again, also with a new context:
> 
>   amdgpu 0000:03:00.0: VRAM is lost due to GPU reset!
>   amdgpu 0000:03:00.0: GPU reset(1) succeeded!
>   WARNING: amdgpu_vm_pt.c:671 at amdgpu_vm_pde_update+0x329/0x5d0 [amdgpu], CPU#0: vmreinit/2629
>   Call Trace:
>    amdgpu_vm_update_pdes+0x262/0x5e0 [amdgpu]
>    amdgpu_cs_ioctl+0x35c9/0x7a00 [amdgpu]
>    drm_ioctl_kernel+0x180/0x320 [drm]
>    drm_ioctl+0x530/0xcb0 [drm]
> 
> and every command submission fails with -EINVAL from then on.
> 
> Don't look at the BO type. Give the PDs and PTs, which
> amdgpu_bo_create_vm() creates, a destroy function of their own and tell
> them by it, like the user and SVM BOs are told by theirs. The TMA BO
> stays a kernel BO which userspace can't mmap.
> 
> v2: Keep the TMA BO a kernel BO, userspace must not be able to mmap it
>     (Christian). Instead let the creator of the vm_bo tell whether it is
>     a PD/PT, with a page_table flag in struct amdgpu_vm_bo_base next to
>     the other bools, so the struct doesn't grow. Fixes the commit that
>     added the TMA BO.
> v3: Drop the flag, give the PDs/PTs a destroy function of their own and
>     identify them by it, like the user and SVM BOs (Christian).
> 
> Fixes: 8a93aae9896b ("drm/amdgpu: Add CWSR infrastructure for user queues")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  2 +-
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 6aa895f63aea..d4651f2d437c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -71,6 +71,12 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>  	kvfree(bo);
>  }
>  
> +/* A function of its own, the page tables are told apart by it */
> +static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
> +{
> +	amdgpu_bo_destroy(tbo);
> +}
> +
>  static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
>  {
>  	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
> @@ -94,6 +100,7 @@ static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
>  bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo)
>  {
>  	if (bo->destroy == &amdgpu_bo_destroy ||
> +	    bo->destroy == &amdgpu_bo_vm_destroy ||
>  	    bo->destroy == &amdgpu_bo_user_destroy ||
>  	    bo->destroy == &svm_range_bo_destroy)
>  		return true;
> @@ -101,6 +108,20 @@ bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo)
>  	return false;
>  }
>  
> +/**
> + * amdgpu_bo_is_vm_bo - check if the buffer object is a page directory or table
> + * @bo: buffer object to be checked
> + *
> + * Uses the destroy function amdgpu_bo_create_vm() sets for the object.
> + *
> + * Returns:
> + * true if the object is a PD or PT of a VM, false if not.
> + */
> +bool amdgpu_bo_is_vm_bo(struct amdgpu_bo *bo)
> +{
> +	return bo->tbo.destroy == &amdgpu_bo_vm_destroy;
> +}
> +
>  /**
>   * amdgpu_bo_placement_from_domain - set buffer's placement
>   * @abo: &amdgpu_bo buffer object whose placement is to be set
> @@ -813,6 +834,7 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
>  	 * num of amdgpu_vm_pt entries.
>  	 */
>  	BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo_vm));
> +	bp->destroy = &amdgpu_bo_vm_destroy;
>  	r = amdgpu_bo_create(adev, bp, &bo_ptr);
>  	if (r)
>  		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 2e6a8e6f577a..8e67a8e60572 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -254,6 +254,7 @@ static inline bool amdgpu_bo_encrypted(struct amdgpu_bo *bo)
>  }
>  
>  bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo);
> +bool amdgpu_bo_is_vm_bo(struct amdgpu_bo *bo);
>  void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain);
>  
>  int amdgpu_bo_create(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index a2814830dd2b..d5d9e2587661 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -162,7 +162,7 @@ amdgpu_vm_bo_lock_lists(struct amdgpu_vm_bo_base *vm_bo)
>  		/* No extra locking needed, protected by the root PD resv lock */
>  		amdgpu_vm_assert_locked(vm);
>  
> -		if (bo->tbo.type == ttm_bo_type_kernel)
> +		if (amdgpu_bo_is_vm_bo(bo))
>  			return &vm->kernel;
>  
>  		return &vm->always_valid;

