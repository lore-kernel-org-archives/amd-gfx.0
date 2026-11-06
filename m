Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A7A606A326
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1GQfr7uU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88441128E9;
	Fri,  6 Nov 2026 08:55:50 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013049.outbound.protection.outlook.com
 [40.93.196.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C3F31128E9
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 08:55:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wfkuanl+1VMyOVeSY3Fb9GVd2Hq8rnCKdiyy8cbQhlWKe9F3wkPbZqSlUh8aS5u6ajR6GTZYQNatorHcWnrdw2ons/ndZKzBKNPvSU4YrVSwoHqU+bH9XPrVlzUvmPhH7DhAmVDBr7V6TTiAwGIpUYqs5ejnTu29Ee1Lp1VTSFAICUcFPA9TrvQpgJ1W+EzGeGp+vYYOXPBWXC1VEZSMm2KsZFiaJkaSAJr6b32h0/y/4L4b1PFSGtQzw/abl1LTIEJHf/uJnGUI8OQb4p8NnP1zqx/laqwDcbzLq5wg/dctoskK1sMF1ILnKRqJ6+hkDZYUHRuPEn3oRpzupsn6iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqjOUHmAQOM5HmlV8c6C6VNcy2NuPMPFK1VmfpVqk3g=;
 b=g8US6JFlCs6ykeENpPw9F6XlHUR1HiJl/p5B/bAmMRIzJxOtxJA0KbupEYfIIKBns4XNPFsHlvUk5FL4VKeJnVouJaquyv2oDYHwyA+ewUl/3Vh6KoE/OOa6st/3vRo8pLk37vUP3QxMFAfL/hx8FPaqKs6CWRpTqjz82crqV3J6wG+pemRkK8mn/0ftw6kI2qnsZ/AZr0xhDv0ODQVftGpkmc2/GwkVKR2BOn0uMbk//+UfDBZoAgaElFtRI1j7r5e/cYgVHpPnA6vLRvWGSLpYrIrgamD2Uy+Z/LYc01OiBJVWbJN/SBdEKYhLu+Vdf+HRppXPJnQj++U2jzHQTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqjOUHmAQOM5HmlV8c6C6VNcy2NuPMPFK1VmfpVqk3g=;
 b=1GQfr7uUwDNhWMJOFB6YOCOkLV1RdEg29aqYnT81LMDc5k/Aq4AtKMMpkftvwK06wu7JGRAZuxm4vzdeWrD1mgnLZHqSHnd0Qvf8xOBXZhpxuMKMrItN9tLc8GC6PHy/08BscnGo6o49KFl0ju//SFrPFx0sb3MMVrXhEE7GyWQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 08:55:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 08:55:39 +0000
Message-ID: <de2d1b55-bfad-47bd-843d-2ce98006103d@amd.com>
Date: Fri, 6 Nov 2026 09:55:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/vm: free pte update job on error
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Shahyan Soltani <shahyan.soltani@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261105210020.3852328-1-benjamin.cheng@amd.com>
 <20261105210020.3852328-2-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261105210020.3852328-2-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a95d963-1dda-43a7-8b0a-08df3be3bafe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|4143699003|56012099006|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: v0ZO/oOUvqGibFX5gwiN67tlZlU8Xt21Rnkv4CeI1kclrR74h7O9XPP6iwo04ZlhbZsnRNQdz3aDMcUG6CzkUCXGPftxBoboPaMy5O7hAsKvAq8QMrkzoAEENm469iRzanwCiuF6053uxUfbT5Ik2lSbaCSGH4kfnDDY603RR8WS5bW/6HMt6lnU6ot4YuzuDKYOv75j4MCgQSI4Ct60O46bG+ijPdbGJmw4QVRg1xXC8qVZabh4sJMnQ7jZrdG7X2pGuelnWpYWLynZdK1c4vyyevdbWMv7kASOVLYvpFLWHDQ7COSBB3VwdKB6NPbDxLDWfpt4GVNevdIaPYazPiWDFUhb7vQzaTsL6Emyr1pd3TEuMK2qZKlJlsKwRPIqfkB5KDwJ6i6cIPsnxVa8UZ0W/83PKGfbuhja7kyFSyU1RgYKxKPLNKFfxZU43R6BNcdR123jzD3TGVQMWFT6HGJq0VMBRNQTA1tJLMroidEdWOFnU2XjmSqOIRWWQA4G6Dyk4qxCwQJw0A18UPwHFKfEPi8n/FSUvXT6D+OfHQM7VAGfXeof5P+2dyZ3P4im7Lvgp1p3yRl05nFVD2MnezGOc8adAe37tZH5Oh63l0E9VOrE5tSJUWi5x9OiFSDx7B6YZpk7WE4Y/NcAPxAldaYVlIyzMhljRG/5sBdPbVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWdQT0tnNGRRWm41OHFTMUh3dWlEVUx5MTlMQWhnVUVmbU1VZDRyNzB6cVRo?=
 =?utf-8?B?RHJXZWZBbEtEazdCRGpLd3UxSHdRcThicGdJWmUrMnkxZ3NxYWZKMnFoZDh2?=
 =?utf-8?B?WXN1eStaeXRtT3B3MjIvODdwSXhreHFEb08rd1BObjdsaXN3MktnR3RHS0Ir?=
 =?utf-8?B?OVhqNmxqU081ZW5JL0t3NGx3Q0Z1WWVuOSszUm8vaE93UlUzSnZadUJEaHNB?=
 =?utf-8?B?ZDBSUUlQT1hGSWtpWHNIM3BsaFN1R0FSS3Zrc3lGd205RkxhbXk2NU1MSXA5?=
 =?utf-8?B?dnJjUVl2QkJuc3lEb3JydFJrUHJBRDNnVWtHajJuZnBMa1Yyam5WUUFlaFNV?=
 =?utf-8?B?eWNBR0hQV1ZvN05BN2YzdEhPYTJia1p2R1VXckR2dE91VXVGemk4SE9GWlBY?=
 =?utf-8?B?OERnVU1lUWJFbXFZSEVNZVFCcitFMHdIVElCdE9OQ2NrOXU3MXNtaVp1Qis1?=
 =?utf-8?B?Mk9TbGZ6Z1E1cmRJM1RidUJGQlRId2NYWElncW5scmp0eXlJYytseis1WkNr?=
 =?utf-8?B?akYvQzFHTi9BUHZzWDE0a0ZYZG92Nmd3K3VLcE1RM0JHbmU1ek5YR2RZTm1K?=
 =?utf-8?B?Zno5dTZZMVRDZ2lhcHJDTlRBYUtHNVVWVXh6L3gzVHQ5OGs5aDdWdzhRYVhn?=
 =?utf-8?B?ekNUcnIzWVJIQjQ5WStkMWR6aXRBYXR3ZDRWcE1lOVJNUWQvaDkvRS8xS3Iy?=
 =?utf-8?B?RFNrdjEwdEdraDJlaEZEWjRoMFRYQkl3TVBHdU1EKzdWQjJQQTlwRGNaMk0y?=
 =?utf-8?B?ZW9lZzVsMkFLN25DYkxCTFNWN0t2Um9DSkdIcnFQSW1WQWROR04rU0xoRU13?=
 =?utf-8?B?amdNTnBGeU9tcXl1cmhQMEt0Z0RZSHdFWmswQlg0Rytia3pIZGVOUmQwb2tj?=
 =?utf-8?B?VnV2Q2RPWjR2dEJZdVFXVi95dDJXR0dJRHJyOHA3dXFsNnR4M3Z5TUVxcDhq?=
 =?utf-8?B?ZkhXY3RaWG5GK2gvTkxSK3JoamZxUWhMVTkyMWVTSEh2Wjc2b2NxSmVVaTZi?=
 =?utf-8?B?eTNCYlhtYmE3NGMyT0NZTlNWMjR6RE93WWRHS0FFTXRZR0V4TTRpWlhhakJy?=
 =?utf-8?B?Mm1CbHA3OGJiQnhIQ2NIOU9OZU82UzVVMnY4TUR4WmRKUU92bXRWWU1zcjVa?=
 =?utf-8?B?d2ZKUE52WGxORVdCVkhINExQZVJSbkVXMVlFWk1xa1k0VXdUTUpzZW1Ya2t0?=
 =?utf-8?B?cFk2M01iYmNqYnRNRWNpcENYR3VoQ1d0TVArOVRkaWZzL1IrNHBtOWhxU2dU?=
 =?utf-8?B?bUswZFJ2M04yMUFUNmhEVDZQR1ZKQlZSNjNuMjZES2trYlVtbHhibUdGdWpj?=
 =?utf-8?B?VWpFbmEwNjliSVRxaEZKNHNQekpiRHJFRG1LMmVpTnZRc21YektYV0YvTi9j?=
 =?utf-8?B?S2swVEVvK29xV3BOSnlRbTJFM21JZ3Q5VEVJVFdYaGVSZVpBV3lHWThuc1o3?=
 =?utf-8?B?Ty9rRUxEa3hqK3Y1UGxzSDF0YVNYVnVrdm5NOW1OSTJzRmlROHYyWStpUUNG?=
 =?utf-8?B?TVc0bzUrcDB5K1JWTUF5bWlsM3paYndOdFA4YzllNHpjUW80OFBTb0R5a0ZL?=
 =?utf-8?B?ZDNHUlgxaldyOUVVTGRTSGdkUHd2cUZDYkpzY0JLMklXcUhYcXVCaWFUUWNO?=
 =?utf-8?B?aXYrME1sQmxNM3BFek5YenVVY3VtbWZKMXZ1Z3h5Yi9uZ2R1YWNDZ3k0MmVU?=
 =?utf-8?B?NVpDRk1zemw1bFpqTVo4RE53MWxUOUpmY3h4RjZtVVdlL0dCKzhRNlN4QXM1?=
 =?utf-8?B?NDQwOC9TN3lEcnNuM3pHYjJSMnY5a2MyNFJPRjYxTU9IWXNvQjNqL2pXWDR1?=
 =?utf-8?B?S09FNE44S1B4Q25xenVHTlBiZHgxOUQrQUN0VjNtbmFBcGR4eWlablo0OGJt?=
 =?utf-8?B?R25zWXM1cG83R1JNZW1XMkpLMEI2dEtDUkNYbzJZT3VUQnhHdzJYMVFTSVVa?=
 =?utf-8?B?dzFFMlZLdUx5Y3M2YmIzUDlLeXlnSmdFN3NSQ2Z2TmdwaWNzOU9LV3BRSTVn?=
 =?utf-8?B?bUZKM3pTV3l6ZWMwN0FCYkRyM2FEU3p1Zk1sWXY3VVJNeTJ3a2pac3FHV3N2?=
 =?utf-8?B?akNlZ3gzK1RGeEtFcnVSMHM3b3NKT044ajBpKytSc0RmTzdnTXJSZFE1RVZh?=
 =?utf-8?B?Z1RMOGhQRWIxNWs0SldKYktYenJBTEZtYk53OFBCUnF5d0lMazhReUJkekd5?=
 =?utf-8?B?SmlhMStUWU9uU0R4eXBxUzJWQi9NMVVUTVUwZFNJdGJFWHdjL01USk9Udysw?=
 =?utf-8?B?UmdMNkpKRTE3aUVtSGloVWVTV3Z2RnljckJWcWtaNk43SUpSMit3WlJNSlpq?=
 =?utf-8?Q?ck7S7wvbrHbqqv/pE0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a95d963-1dda-43a7-8b0a-08df3be3bafe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:55:39.4335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJIRbVr8Npgho8K3ea1PChlJ07a6zEOzq3U24klVnbro7lAPNsMkq34MSzpM9jgo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783
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

On 11/5/26 22:00, Benjamin Cheng wrote:
> In the happy path, the job gets freed when the job is submitted.
> However, if amdgpu_vm_ptes_update failed, we don't submit the job, so we
> would leak the job.

Yeah that was already brought up upstream as well, but that here is the wrong approach to fixing this.

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> came up with a few patches on the public mailing list to tackle this as well.

Essentially we need to commit PTE updates before we allocate any new PT, background is not only that allocating PTs can fail but also that we need to drop the lock for this and that can make the PTEs we already constructed in the SDMA IB invalid.

I wanted to get that fixed for weeks but couldn't find time for it. Can you guys together look into that?

Thanks in advance,
Christian.

> 
> Fixes: 009f401fb98b ("drm/amdgpu: move amdgpu_vm_bo_update() call into correct location")
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 2ba33212d507..f6cb2b5854dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1274,8 +1274,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  		tmp = start + num_entries;
>  		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
> -		if (r)
> +		if (r) {
> +			if (params.job)
> +				amdgpu_job_free(params.job);
>  			goto error_free;
> +		}
>  
>  		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
>  		start = tmp;

