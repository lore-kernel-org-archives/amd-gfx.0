Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83B4606A323
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IFYwXfoI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2F8112242;
	Thu, 26 Nov 2026 09:45:32 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A428111225D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:45:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmmgzP6ah7ht0uVw+ADb0TzO2Uk1BfAmey9dNWTFT0pJeKElViEYPuuiT/bKOpZovhpYmEnA73Dyd1UQDYRC45FD6bB3UJWJMONkLMQriag+RKOAOp3Av3XkaHCVlo6bTwSAV2Pt9G4r7XgGAXANKVnxZW21PojxDv4GvjarLawYYsdmxrqWarkvdkv0GE0w3JtbZjRr4gxKgtfMvX1yI/6FuIphFSIYTEuWOH5zrBpJl2hmAhmNApgvzG8tsgfPMF5rL3qLi2CK9/wAuOzvDu8+C/9zri8vG9rzYlSX4dQ6k2GHHAhdWdNHlxAjXSYuAo2/17zs2EOAlhk91gh6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJozg6D6A7A7RgrLH2mN5oiMfh4BkZv8xV7WFDIB6g0=;
 b=njx5RkkC/MFwuxFMXNKCGty/hujSpAaCwG2stMeQ5QmMSPJx7FGePU06bYK0VnheHZ/vem5YAmQCFl692rsFFwN6oOfaVtBvNRTWB6TnY8ISq0ll0Uh4bu5/R2vKftTsLWvTSozrc0NWR4TEAJOuAkkimq6GXurmCqzHUt0LYweZgMgRlpYdnWo+/OrYdfi+nd19j6kgk663vIk1NlCxaSwE7WBNtUvcHfM8wFuT48iWALFpQtkPrJD6MzF1fu2pQTC47gCXRJ6H1i2xGrx5JnRv3hm3XLoGHhNMY/BUTkSd2D12seXEjzuRDbwtBg8s5v/O+X9jNbZwn065txRhMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJozg6D6A7A7RgrLH2mN5oiMfh4BkZv8xV7WFDIB6g0=;
 b=IFYwXfoI6/TPWAYgzBMeq3eEGK6t6tR9+mS8/XCSl0oL6IJlC7fBhv1zUO9G9lnmxd7Wc9RXavJMoz4mlu9uaGcFuT9VEoHR+P5Qfpu87mAWgLcmV2VVCTCedAxJxymrrfo6dc+O/L56hfj34K8S1xoPkWLRnhd2VdKaGoW+QgI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7336.namprd12.prod.outlook.com (2603:10b6:303:21a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 09:45:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 09:45:22 +0000
Message-ID: <a1bb8bee-2c1e-4623-ab31-0bfbdf700b8b@amd.com>
Date: Thu, 26 Nov 2026 10:45:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: keep the address of cleared PDEs with
 translate further
To: Bob Zhou <bobzhou2@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Mukul.Joshi@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com
References: <20261126073232.2108102-1-bobzhou2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261126073232.2108102-1-bobzhou2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0336.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c825d86-cf80-4f77-92e6-08df4ba1fcb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|261022105027099003|10067099003|56012099006|11063799006|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ibKkZ2OkxjA+Zk+cOhLt3kesOrt1vlQrXEZKvf6lCFBBRwuamSNPKGbXyKrbbWF8DLecUfNLyHyZZwAr8jjeAWDOcrQzdjDymGnXpr2qZcjeJy+VZL80GdYfzHykQQGzoMOFQMU49EiakiSmbvTL0zCwINb6TIUqZgfpRMMAA+8uswxOemLlSvVr4EpCZDZQWH45Ev+WvFgEti+xeVXznXIZotT+JrDXrtul6gBrKTkRMFUpWx2cn/rP1UznX+pKcU/ojtzyHI6jA4p0Xx7M2VSFHJNuzQ9FArIqBZy12r0B4RXlWR7v9TTF43ZyPDuUL/5wn0XUIadtvlGu/6WzQwyh+is8EnOLokPo7jOPysmr7QegwlkYlXatEkNuXz5bkDFbU+2ls3V1l2fKHDxcB2Zifuu4Fi3Zfa+HCYDTVJ0hqpqX9xW4pyVvRTCueXuF55IF4WSbrhAqjVJOhWHjifuIBPovfIA0th0dQzo/e0vBEIPzar0gGeUC6Csv3TquyCulrpBP41Mv6aEc6GKo4rVU9bpwL4M75FD6JzWCuX9kPetYHglsxtpqwF9y9sPRzBCRhT3VFBFQYb03vbjKE4QqXHFyTgZggLO/tB7TZTrbmszhKgwi1mo3CeB3joarafthbkhss4/EHNGdNO3ZkgsURBo8ztOnAkmpgqXOGPc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261022105027099003)(10067099003)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlI2ZjVVbFNTZ2daaWRpOWtPbmU2amQrT2FvbHc4QkVtNGxkOGhxOVptV01H?=
 =?utf-8?B?Q0sveWw3WWRTQzh2WUJ3WTJyRGp2SGt4YnBGNVpjV0xMbFZ6TDQxL3hxYU9t?=
 =?utf-8?B?aUczY3dGNkcrWFRLN21sSG1zU3FXZk1qRjlwNTVSbld6Z1BCUkFvVjBOSTZ6?=
 =?utf-8?B?SmM2WmxmVTQ1bmFpbU1GMzZ6d2ZHNXd0cmUzN1N5V01rb2lrbVFJTkVkR0Z3?=
 =?utf-8?B?WEtKMHdQSlQzdTNLV25Cdzl3QjJnZjNYOCtMOGt0LzJaa0NHbVhLREhnYmlF?=
 =?utf-8?B?M1p2UWt1UHUzaGFWRlcvQVdXV1ZhMnR6dExzUjFvOVFvMjU2N2RPaHJQREQz?=
 =?utf-8?B?TE0yTkJhQXFTRWtnek5TU00yL3RsVUdPdFQ0WHhKNTNvTTc0UUdmOTZSbkNz?=
 =?utf-8?B?MVlSZlZ4ZmozOFVyTlVqY1J4YXZySFdxQTlXSXFMZTFxWStsNUM0SS9VQmJU?=
 =?utf-8?B?R1BId0VkTVhiRkVzRGRMRW0rTGY5NGU1RVBwU2NmbTlsMTRiTFhqaS9abGdl?=
 =?utf-8?B?VC9qVHhaOExncnVnQ1o1OS9DOGFhTkFKa2NBQnVUdUlBYm85TkpPY01KZytE?=
 =?utf-8?B?MkI2NDFrNm1SNGZRZlRrWTlkcUJEQm9DUzRpaldJUXJwUWtLV3Z2aXdFOHZ0?=
 =?utf-8?B?UGJqUS8yRHRqU0NBQkhOVWNLblY1NUZNL2x1cXUxSzFZZTNaVDZ5SzJEdHlw?=
 =?utf-8?B?VytRanJ5dGRXc3B3SFlXQVd1ZEUwMnBydnR1M0ZGUVdpdGxzNFdxTFpWY2t5?=
 =?utf-8?B?ajdvNDdDK3dGVC9BRzRvWWtIcngzK1dwMk1BZ0k5bkRsbytUSlk2Unc3RlM5?=
 =?utf-8?B?L2FPd0lzQnV2ZkEvd0pTaXpzWUFUdW1JV1A0cXVEOCthRWdKVTZkYnVCNTBk?=
 =?utf-8?B?SW1LQWdLNDN2UFZ1V1pIYnI2N1J1amtqRkpMOFJ4djgvWHFxWHdZTlZFeHV6?=
 =?utf-8?B?bDJ4TjR4Yk9qelRkckhtMmtCdHBvTm9BV3hoWWpKY2t3VEtOUkZta3ViQVpt?=
 =?utf-8?B?bkZnWFN3eWdDOE1LNUdEZElzVHlNSncrMnRRd1JFbEhndmRPNnM5S2VKZ3Fp?=
 =?utf-8?B?RmFyeTBHQjJ6bkJsMXZLRmFTcU9MMnJuYSttTGloWVZ6SkN0YUlFWWpLbXBr?=
 =?utf-8?B?OHpkKzQ1Mzl2MzZFZFJBL0FZRE5POXU1dWVuLzhtWmpYMlMwUTY1Y1NleUZa?=
 =?utf-8?B?RHZSNG1KWDhrSEdxZ2d2SHowM1EvZ1pFc001UXd3OHUzQ1I0UURGSEpXVnFt?=
 =?utf-8?B?UE81VDU3dEdtNk9EenRMMmplbkNkbi9yKzFkRDFEaXZVdEhzbHFxNnNTajdu?=
 =?utf-8?B?L012Sk0xZUxZS0J3cHo3YmRmZk9GMDdhc1NKRmo4bWp5RlJiRzVoVzZiTlhl?=
 =?utf-8?B?UVNvemh1WnBaKytFbDA4cDIvNzNvNldCZVFuWUFqUlpoMjB4d2lWbEVoa2Mx?=
 =?utf-8?B?NU9BazhlR3pMMS8zdXZiVHR2VmxFUXc0L3hnQUZkRUhGZEVxMC9nUlF5eGpI?=
 =?utf-8?B?Qm9rUUJUYTh1ODB1YW5rL0FMRlc2eFpzUHFjdmNHVjB6dWhNaC81L1g2WHh0?=
 =?utf-8?B?OEFzYzNlVWhiQXhiK3R1TEpIWU1vdC9Pa0ZiZ0p0aDI5a0FWOU5Ia0Z5SFhr?=
 =?utf-8?B?RWF0SlVsTmFIU2lOL09yR0RsYTcwbklhMDFGc1hvM3g1ZlY3ckE5NGNEVlR3?=
 =?utf-8?B?NUVXazB6ZVpuTE1QdDNXYVhXUWsrOGdPd2phVk8zRFJ6VFFNZWlOYTdiRFhB?=
 =?utf-8?B?TGpraWJLYVREK3ZoS0xrcjIra2JpTmk5R3hKVTZWQ0E2QTFLT093NlFMNnpy?=
 =?utf-8?B?Z0NUSlZwMlRPeEtpR0E2VVM0U2ZSNlF5SVBLZEE1Y3J3VHNGQlA0R2ZqTEEr?=
 =?utf-8?B?QlIyMVBXRzhVTEdFenRzUFp5N3NLRmtGdTByeEFDZWlxbzgrMFJRV1dwdjZC?=
 =?utf-8?B?UlllVFN1WXpJakJ5TkhRQjZuaFYxUzJhWU1CNURxaWlqZzN2KzRuUkFhS2Vt?=
 =?utf-8?B?ckR2ZFZDZkFldGNVWFBlTXdEU1dUbXUzWG85WUd1OVQ0cVNpVEJoU2Vnem44?=
 =?utf-8?B?VDA3Q0c0RXBraXBROVVycDBlSE9BZVVpeWlJSnlMQ2ZaK2pnM2drWmw3Y3VT?=
 =?utf-8?B?Vzh6V2NFRm44VWM4K0RGU0Fnd2JzU1h3K0cvNloyTVY3cyt4VGs2QVdzYVhh?=
 =?utf-8?B?cmVNeVhxeDkzMVpqeEV3RmpsV1lyVDZFS1R1QzIrWVg1SVU2WnRvM1E3K0dJ?=
 =?utf-8?B?ZWs1dGFMS1hQbXltL0lyZm5rTW4rcmo5SGllaFFaTDhXUTdwdWx0Y1kvY1RK?=
 =?utf-8?Q?c7Pm7EB/s6cCWwD9yB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c825d86-cf80-4f77-92e6-08df4ba1fcb8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 09:45:21.8560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LYzdocio2Btnlqane40xMgmQamLcEL+2FMrnKI5NSdRZDWUmTNvhRLlCN8fob0j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7336
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

On 11/26/26 08:32, Bob Zhou wrote:
> Commit 37a0bad677a7 ("drm/amdgpu: Update PTE flags with TF enabled")
> made gmc_v9_0_get_vm_pde() set bit 12 in the address of an invalid PDB0
> entry, because with translate further consecutive invalid entries which
> read as 0 are considered a fault.

^^ we should probably stop doing such hacks.

> 
> amdgpu_vm_pt_clear_flags() drops that address and amdgpu_vm_pt_clear()
> writes 0 instead.Hand the address back to the caller and write it again.
> 
> Fixes: 6250a8342784 ("drm/amdgpu: fix cleared PDE/PTE flag generation")
> Signed-off-by: Bob Zhou <bobzhou2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index a6d389c08524f..6aabd9f5291c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -349,7 +349,7 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device *adev,
>  /* Return the flags used for cleared PDEs/PTES */
>  static uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
>  					struct amdgpu_vm *vm,
> -					unsigned int level)
> +					unsigned int level, uint64_t *addr)

If we need multiple return values please make amdgpu_vm_pt_clear_flags() return void and give flags as parameter.

Apart from that looks good to me.

Thanks a lot for figuring that out,
Christian.

>  {
>  	uint64_t flags;
>  
> @@ -357,12 +357,10 @@ static uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
>  		return 0;
>  
>  	if (level != AMDGPU_VM_PTB) {
> -		uint64_t value = 0;
> -
>  		flags = AMDGPU_PDE_PTE_FLAG(adev);
>  		if (vm->is_npa)
>  			flags |= adev->gmc.noretry_flags;
> -		amdgpu_gmc_get_vm_pde(adev, level, &value, &flags);
> +		amdgpu_gmc_get_vm_pde(adev, level, addr, &flags);
>  	} else if (vm->is_npa) {
>  		flags = adev->gmc.noretry_flags;
>  	} else {
> @@ -395,7 +393,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	struct amdgpu_bo *ancestor = &vmbo->bo;
>  	struct amdgpu_bo *bo = &vmbo->bo;
>  	unsigned int entries;
> -	uint64_t flags;
> +	uint64_t value = 0, flags;
>  	int r, idx;
>  
>  	/* Figure out our place in the hierarchy */
> @@ -430,8 +428,9 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (r)
>  		goto exit;
>  
> -	flags = amdgpu_vm_pt_clear_flags(adev, vm, level);
> -	r = vm->update_funcs->update(&params, vmbo, 0, 0, entries, 0, flags);
> +	flags = amdgpu_vm_pt_clear_flags(adev, vm, level, &value);
> +	r = vm->update_funcs->update(&params, vmbo, 0, 0, entries, value,
> +				     flags);
>  	if (r)
>  		goto exit;
>  
> @@ -724,7 +723,8 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>  
>  	} else if (!(flags & AMDGPU_PTE_VALID) &&
>  		   !(flags & AMDGPU_PTE_PRT_FLAG(params->adev))) {
> -		flags |= amdgpu_vm_pt_clear_flags(adev, params->vm, level);
> +		flags |= amdgpu_vm_pt_clear_flags(adev, params->vm, level,
> +						  &addr);
>  	}
>  
>  	/*

