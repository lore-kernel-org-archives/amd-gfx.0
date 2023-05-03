Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EB0C77B7F
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 08:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE08E10E20A;
	Wed,  3 May 2023 08:50:53 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 664F410E20A
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 08:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihpzSHRu7KRQhgb+t/tr7A6k/ZpJW+cH4csxaABAEYx3MXlO8i4sb2ODXR7KHWNSTF/Cw95ACA1nZrsiQJCT4kuYNDqqmqRnl3YfVvqNoC8h6abhtouPQnTw+4vHTPaXDVy+4OS48NkKJgmJra4NpKwPbUyE0ZbvXq69hNBT6e+kXhOqVjug8vlKPejwMkaNE/K7d6oFuiRNA82FYZimXNpxR0knNOo+KqcqJrLR3KsSHUfjRQ0KK9e9jpVAepLgDOe2OUGXOG/vfdJtuaHNHHchp+3GqElsHDDSnKDFoGFR3zVU3tXWByiCcZfd7ia/4WxTRqZ6cGZMkofn4A0G9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3eJK8DBNrNINGSQv/jytoPNTewMvksLmStQ2VxJt54=;
 b=ZSW+E1+hmpMWHxRQyR/5NbNBL9BnBcbch3tM1p19NZjzM6+VIqi5BqFRVLRSsJlWpx2YL5KYtU9vrPTW9vv8uAavmZcrenVVKe6va4rBCy9n4rsJ99eo2tk5cE5RGGdRSWKljptm6fx2zNB9KdqrXPaBy5Y5wDhgtGz4rU4DODOv2UlAvNm/3JdR9r7TK33KPAPM0s1VnLQyqVvBXqsmRCMZ8oUnFeOE5gWeNjG83B/b6BM9Hh/5iadCL9sOANDMCeXSojaA51QKIBgZroSHAlAkK+MdQqctWX3CE2RI7vFSGKOiULuwg6BxfZeWde55GYawN0iuifrSv8Z/WtUQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3eJK8DBNrNINGSQv/jytoPNTewMvksLmStQ2VxJt54=;
 b=nW9jwS4seeFu1x6FOQSYBFDrvMGpZOZ3RPDmnmMdfDfHiW59xax0UAaTV4zOHeXSJymMr4nueADpzv0+zSiBIydL7wlEkYcftK5G+yRvD8PhH76pDxj3sxbooTajGdFf9vvE5wg8JYvmxURZyauFxu5VBawVtN/6eolGoWwHDKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 08:50:49 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 08:50:49 +0000
Message-ID: <505ede8c-c4f3-a7e3-3d28-47f0234c772e@amd.com>
Date: Wed, 3 May 2023 10:50:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amd/amdgpu: Fix errors & warnings in amdgpu _bios,
 _cs, _dma_buf, _fence.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230503084640.1460565-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230503084640.1460565-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd95bb3-d713-4d90-a8cc-08db4bb37e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yu3AMc6xvPxrpqlFkE+8tG/tZpI1zpwfMUBzHNq2SNZB4/oRn8c9cAdPErnoaALjyBJOuzMEv4iHWFN7zmd8uSZRKybo2RZ8G5Sx59EaBpSam+2OWCflpYLoUeFWw9gHg7oLBeYM8TM6PMNvFjfY5MmRJbvl1gbdkpYt4rVLMe9g0BjZ8iS+nPj/q3RKRYt3zlOM6W0ZP/35FNZ9Zyy2MuXErIsnD112QLkHC4pXxvrPTxADoruYWttKl3ss9VV4WwEwF/OR3arUlOIZ858WPfdmJ6tLHEBfhWBczw7TrsVYHsrMk94D4HvDamZRYLfYOTHGFKcA263H24nA+68xRjmyiazveGViOhJX1H8t0dn2SFVyyz7NdwAUDMOBF8ukzNKUvMIkb35JGN56agL8bowrm1RsA/56JdWpavp+SHoAOKGsEQ8IxzHAGtgcZE0+H3AmN0ciZKesw5jnm1W0V1iJQ5WGcjIItsUYqMt5EOIpV2FP0WM+aYvuMEa3RFGWIytAcAVtk5jBQNmJjn6FVrN7vVDnKaXs4Zp/W3npSaGghggjUXxYR2T4Ju3lfViRtafnNBY0Cq50Q7wixlqR9XNk1ppYAcp4xM5v16IaxbKEvnlUSxLhDLTjaC/seRBvKz52zSnUXpbZZALi8CzKp85aGNTITtCLMtVt/dVaJkg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199021)(31686004)(2906002)(5660300002)(36756003)(8676002)(8936002)(66476007)(41300700001)(66556008)(66946007)(86362001)(31696002)(478600001)(6666004)(110136005)(316002)(4326008)(6636002)(6486002)(66574015)(38100700002)(186003)(2616005)(83380400001)(6512007)(6506007)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWt2THZDeVZ1THFIUGQzMVl3ZVE2TjlZbUExSXJTS0VjVmo2MmNJN2p1cFhH?=
 =?utf-8?B?TWFYOVBCWk90T280dEhQN3BGOE8yRXZkZm9Gei9kVDQzOG1adENJbWlRbnFU?=
 =?utf-8?B?QlZFTFg4M3BSdTJRRVJyMHQrYTZZTS8wWVUzYWpLbnlFdmlWZk04UkRBZlpt?=
 =?utf-8?B?UTlKck40aUtyRFlrbmk4d05XZzdvTGMwLzl3RGtrQ3BPY0J1QzhhNHVKbUJo?=
 =?utf-8?B?NmdBSWRtN0oyRzFTdU8wdWFrZzUzQlkrY3RLbnFycXlXQlo4YjhFRkRvbC8v?=
 =?utf-8?B?V2FMYzhTN002Y01JenpuNVN2a3FOS3RmZXdlTXZrZDhYaEE4ZE5iejlsOVVO?=
 =?utf-8?B?L3lnT0xxRDY2SWp5ek9qcUZhckRVQTJZNGQ0Zjg0QWE3NDhxWkpkMldOWTlP?=
 =?utf-8?B?bFdlV2FLb3RpWHphMncvZ29IRFlwcUZCR1kwdGtOSlBvMitZTTUzZmNQWjI2?=
 =?utf-8?B?Nk56eHp0SEx5WGd0QjhiUUNnQ1crZXcrcTZXSHlLV3pjQ2labFNtQzdBcCsy?=
 =?utf-8?B?bHJvdE5ZNGpFZ3VySzJNVTJPdmx2VGJ4SGhCNnZlM1Z1SjFadHRKN0VPWXV2?=
 =?utf-8?B?RE4wRzF4M1RSTDdSY25IdldrSVNiS01oMm9EZUZZTXhhcFZ0V3ErV3hGWGY0?=
 =?utf-8?B?elllbVI4ZElwZm1JSEM5Q2xYeWlCQ3pUSVErYWNQN0JLRU51OWdBWEk0ZGlJ?=
 =?utf-8?B?UjVNR0RKKzhyd0J6cXpMM2ErS3ptTTNtcVVGSGFFUExlQ25rSWNCeUZaRDhO?=
 =?utf-8?B?bWJJSWF4eHlCVE5helVrK1VkbjZiaHZycGNoZ0NmL25vZTNhYXpwYzNMeWNK?=
 =?utf-8?B?aFA2azV2OWs2aHZRcDF3RVI0dUtCMUlJeTZNTXMrMiswaWdJaWhXQ1ZKN0Rs?=
 =?utf-8?B?ZWdSdnZSb01wanRMQlVxT25GNzFjSldMYXArL0o4UC9rZlpIaTMzT2M2bjBB?=
 =?utf-8?B?SGg0Sm1VYXMwbjRXMEJGbnZlL1VkUjZsOVBGTUJIaVpsQkI2WFdnaEpIeTdo?=
 =?utf-8?B?cmR1dVMxeUxrQnFGemU4clFmSGpTaDRhcjF6T3NjanFhZXByaUJsM0dTdVZj?=
 =?utf-8?B?QTE0VFdSUGVTeGZCa3JSdWQ5QytHWFQrb212SVAwcnZKcHczUDRxQjdhN0gz?=
 =?utf-8?B?YlVvRStIUTE5NVJ5YmlhSkFWR0FROSs1OGlOY1JET2grOEtKdzJueEt0L2V6?=
 =?utf-8?B?TW1wckhiK1B2V0Y0cDhsT0FVKzNQNUJBTDlQOVVVblNNc0xackQ4UzNDQlNI?=
 =?utf-8?B?c1JVUm1GQ2thdzhPcDlJYUVtL1NzYWE4L0kwK2t4V2REM0hwUlU5eGUvazNy?=
 =?utf-8?B?eUlGZFM5bkRhTDVDSTI0R1YyM21TbVZzSW5UUEJzUGtvN3JjWjNXcGd5b0lq?=
 =?utf-8?B?bi80dXJqNFRmVWJGUjd0RTVOQUtWQmdVdEhINmFHZzNvY1JkSWtXb1JZaURt?=
 =?utf-8?B?cnozVTBmaXJTUDFjajNOcmx5Vkc1UjRwU0gxZHpjLzBTRk9SWi9BNGFlUnk0?=
 =?utf-8?B?bXFvbDBkOHg3cmJJR0dpV0pMb252RFExaG9qMXBPYUlLSGtVb1FlRXdBTk9y?=
 =?utf-8?B?SzNVc20raTdNUFIrRWVJTk9yTHdWSmY3bWF5SEdBclRTYXpiQVVNejMyMHUz?=
 =?utf-8?B?bDFjZUYzVVp4VWsxVVFWVjhFOWt1YU14NGY2TmxZS2tVUkxFSUtNeWZJK0gv?=
 =?utf-8?B?MWxnQjNFN0U3T3V2alJxc0JIMGJUNENmSWYvdDJqNDBIL1lzYS9QZzJ4UUZ2?=
 =?utf-8?B?WDRGKzFJVTZndTBFbUNhYVJyOHk1emk4b2hpT1BYOER3UVhqZFhFRnBwSmVG?=
 =?utf-8?B?VFU1NlVhQ1lnd2prZ09lNGhYK3czZFlkYWxPT052bzkwdHVFWGQ1bEFmTi9k?=
 =?utf-8?B?RWlYZFJXUHFsVWRBeHhhd0hVZUNURnhiKzRONVZpSnd1UmpDZGhueVJHdXlC?=
 =?utf-8?B?M0EvcFg2NXpsbVlCcWI5UHIzdktXaDRJMXB0bFp2a0g1SkJqK0FoR1pGcVhJ?=
 =?utf-8?B?TGFlYnVaYVE0TytNd29rSDdYQkx5MFd0dVdidkYvMyttcUsvSzE3ZXJTajlT?=
 =?utf-8?B?dUtITFB4VXRTUnp3aklzcnBrOGNaQmtJNUZqS2NTSm4wMHFSM0JpT0h3c2NC?=
 =?utf-8?B?OUZrbitXSmdNdEEzZ1p1YXlQbEdpUm1FSDM4Snk4RlNYYmFCVWZSSlUxZXUv?=
 =?utf-8?Q?0s6lGZkf9m/HmrWMNTAqZUH895vpPTaJpiA5aL0ViBmS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd95bb3-d713-4d90-a8cc-08db4bb37e54
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 08:50:49.5764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCZdBIotPlMxw/ZrdCyZ9b1/SLBf1Oz0m4VZj/48V0ggIUqFmUVHaHbNNJXQN09L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.05.23 um 10:46 schrieb Srinivasan Shanmugam:
> The following checkpatch errors & warning is removed.
>
> ERROR: else should follow close brace '}'
> ERROR: trailing statements should be on next line
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> WARNING: Possible repeated word: 'Fences'
> WARNING: Missing a blank line after declarations
> WARNING: braces {} are not necessary for single statement blocks
> WARNING: Comparisons should place the constant on the right side of the test
> WARNING: printk() should include KERN_<LEVEL> facility level
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c    | 16 +++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 16 ++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 15 +++++++++------
>   4 files changed, 25 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index 30c28a69e847..b582b83c4984 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -104,9 +104,8 @@ static bool igp_read_bios_from_vram(struct amdgpu_device *adev)
>   	adev->bios = NULL;
>   	vram_base = pci_resource_start(adev->pdev, 0);
>   	bios = ioremap_wc(vram_base, size);
> -	if (!bios) {
> +	if (!bios)
>   		return false;
> -	}
>   
>   	adev->bios = kmalloc(size, GFP_KERNEL);
>   	if (!adev->bios) {
> @@ -133,9 +132,8 @@ bool amdgpu_read_bios(struct amdgpu_device *adev)
>   	adev->bios = NULL;
>   	/* XXX: some cards may return 0 for rom size? ddx has a workaround */
>   	bios = pci_map_rom(adev->pdev, &size);
> -	if (!bios) {
> +	if (!bios)
>   		return false;
> -	}
>   
>   	adev->bios = kzalloc(size, GFP_KERNEL);
>   	if (adev->bios == NULL) {
> @@ -168,9 +166,9 @@ static bool amdgpu_read_bios_from_rom(struct amdgpu_device *adev)
>   	header[AMD_VBIOS_SIGNATURE_END] = 0;
>   
>   	if ((!AMD_IS_VALID_VBIOS(header)) ||
> -	    0 != memcmp((char *)&header[AMD_VBIOS_SIGNATURE_OFFSET],
> -			AMD_VBIOS_SIGNATURE,
> -			strlen(AMD_VBIOS_SIGNATURE)))
> +		memcmp((char *)&header[AMD_VBIOS_SIGNATURE_OFFSET],
> +		       AMD_VBIOS_SIGNATURE,
> +		       strlen(AMD_VBIOS_SIGNATURE)) != 0)
>   		return false;
>   
>   	/* valid vbios, go on */
> @@ -264,7 +262,7 @@ static int amdgpu_atrm_call(acpi_handle atrm_handle, uint8_t *bios,
>   
>   	status = acpi_evaluate_object(atrm_handle, NULL, &atrm_arg, &buffer);
>   	if (ACPI_FAILURE(status)) {
> -		printk("failed to evaluate ATRM got %s\n", acpi_format_exception(status));
> +		DRM_ERROR("failed to evaluate ATRM got %s\n", acpi_format_exception(status));
>   		return -ENODEV;
>   	}
>   
> @@ -363,7 +361,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
>   	struct acpi_table_header *hdr;
>   	acpi_size tbl_size;
>   	UEFI_ACPI_VFCT *vfct;
> -	unsigned offset;
> +	unsigned int offset;
>   
>   	if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
>   		return false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index cb771c73cd07..c5521f9953a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -395,7 +395,7 @@ static int amdgpu_cs_p2_dependencies(struct amdgpu_cs_parser *p,
>   {
>   	struct drm_amdgpu_cs_chunk_dep *deps = chunk->kdata;
>   	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> -	unsigned num_deps;
> +	unsigned int num_deps;
>   	int i, r;
>   
>   	num_deps = chunk->length_dw * 4 /
> @@ -466,7 +466,7 @@ static int amdgpu_cs_p2_syncobj_in(struct amdgpu_cs_parser *p,
>   				   struct amdgpu_cs_chunk *chunk)
>   {
>   	struct drm_amdgpu_cs_chunk_sem *deps = chunk->kdata;
> -	unsigned num_deps;
> +	unsigned int num_deps;
>   	int i, r;
>   
>   	num_deps = chunk->length_dw * 4 /
> @@ -484,7 +484,7 @@ static int amdgpu_cs_p2_syncobj_timeline_wait(struct amdgpu_cs_parser *p,
>   					      struct amdgpu_cs_chunk *chunk)
>   {
>   	struct drm_amdgpu_cs_chunk_syncobj *syncobj_deps = chunk->kdata;
> -	unsigned num_deps;
> +	unsigned int num_deps;
>   	int i, r;
>   
>   	num_deps = chunk->length_dw * 4 /
> @@ -504,7 +504,7 @@ static int amdgpu_cs_p2_syncobj_out(struct amdgpu_cs_parser *p,
>   				    struct amdgpu_cs_chunk *chunk)
>   {
>   	struct drm_amdgpu_cs_chunk_sem *deps = chunk->kdata;
> -	unsigned num_deps;
> +	unsigned int num_deps;
>   	int i;
>   
>   	num_deps = chunk->length_dw * 4 /
> @@ -538,7 +538,7 @@ static int amdgpu_cs_p2_syncobj_timeline_signal(struct amdgpu_cs_parser *p,
>   						struct amdgpu_cs_chunk *chunk)
>   {
>   	struct drm_amdgpu_cs_chunk_syncobj *syncobj_deps = chunk->kdata;
> -	unsigned num_deps;
> +	unsigned int num_deps;
>   	int i;
>   
>   	num_deps = chunk->length_dw * 4 /
> @@ -756,6 +756,7 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
>   
>   		if (used_vis_vram < total_vis_vram) {
>   			u64 free_vis_vram = total_vis_vram - used_vis_vram;
> +
>   			adev->mm_stats.accum_us_vis = min(adev->mm_stats.accum_us_vis +
>   							  increment_us, us_upper_bound);
>   
> @@ -1074,9 +1075,8 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
>   
>   		/* the IB should be reserved at this point */
>   		r = amdgpu_bo_kmap(aobj, (void **)&kptr);
> -		if (r) {
> +		if (r)
>   			return r;
> -		}
>   
>   		kptr += va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);
>   
> @@ -1390,7 +1390,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   /* Cleanup the parser structure */
>   static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
>   {
> -	unsigned i;
> +	unsigned int i;
>   
>   	amdgpu_sync_free(&parser->sync);
>   	for (i = 0; i < parser->num_post_deps; i++) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 271e30e34d93..e97b1eef2c9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -148,7 +148,7 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>   	if (!bo->tbo.pin_count) {
>   		/* move buffer into GTT or VRAM */
>   		struct ttm_operation_ctx ctx = { false, false };
> -		unsigned domains = AMDGPU_GEM_DOMAIN_GTT;
> +		unsigned int domains = AMDGPU_GEM_DOMAIN_GTT;
>   
>   		if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM &&
>   		    attach->peer2peer) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index a7627cc0118d..d6e35a3904c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -43,7 +43,7 @@
>   
>   /*
>    * Fences
> - * Fences mark an event in the GPUs pipeline and are used
> + * mark an event in the GPUs pipeline and are used

Probably best to just make one line from that. E.g. "/* Fences mark an 
event...".

It looks like the original idea was to make the word "Fences" a caption, 
but that isn't really the style we use here.

Apart from that the patch looks good to me,
Christian.

>    * for GPU/CPU synchronization.  When the fence is written,
>    * it is expected that all buffers associated with that fence
>    * are no longer in use by the associated ring on the GPU and
> @@ -140,7 +140,7 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>    * Returns 0 on success, -ENOMEM on failure.
>    */
>   int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amdgpu_job *job,
> -		      unsigned flags)
> +		      unsigned int flags)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	struct dma_fence *fence;
> @@ -174,11 +174,11 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>   				       adev->fence_context + ring->idx, seq);
>   			/* Against remove in amdgpu_job_{free, free_cb} */
>   			dma_fence_get(fence);
> -		}
> -		else
> +		} else {
>   			dma_fence_init(fence, &amdgpu_fence_ops,
>   				       &ring->fence_drv.lock,
>   				       adev->fence_context + ring->idx, seq);
> +		}
>   	}
>   
>   	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> @@ -396,7 +396,7 @@ signed long amdgpu_fence_wait_polling(struct amdgpu_ring *ring,
>    * Returns the number of emitted fences on the ring.  Used by the
>    * dynpm code to ring track activity.
>    */
> -unsigned amdgpu_fence_count_emitted(struct amdgpu_ring *ring)
> +unsigned int amdgpu_fence_count_emitted(struct amdgpu_ring *ring)
>   {
>   	uint64_t emitted;
>   
> @@ -475,7 +475,7 @@ void amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring, uint32_t seq,
>    */
>   int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>   				   struct amdgpu_irq_src *irq_src,
> -				   unsigned irq_type)
> +				   unsigned int irq_type)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	uint64_t index;
> @@ -653,6 +653,7 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
>   
>   	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>   		struct amdgpu_ring *ring = adev->rings[i];
> +
>   		if (!ring || !ring->fence_drv.initialized)
>   			continue;
>   
> @@ -865,6 +866,7 @@ static int amdgpu_debugfs_fence_info_show(struct seq_file *m, void *unused)
>   
>   	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   		struct amdgpu_ring *ring = adev->rings[i];
> +
>   		if (!ring || !ring->fence_drv.initialized)
>   			continue;
>   
> @@ -938,6 +940,7 @@ static void amdgpu_debugfs_reset_work(struct work_struct *work)
>   						  reset_work);
>   
>   	struct amdgpu_reset_context reset_context;
> +
>   	memset(&reset_context, 0, sizeof(reset_context));
>   
>   	reset_context.method = AMD_RESET_METHOD_NONE;

