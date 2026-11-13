Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806CB606A323
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=k4R8fEO1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1348110E81B;
	Fri, 13 Nov 2026 19:48:50 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013037.outbound.protection.outlook.com
 [40.93.196.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47E5E10E81B
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 19:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSOJew+7koK5rkfwGSo8wTdbfcNZ9lUYTpCPZf3rky1YvCtn4j6RBj3t79HI/5c8IUGElwyDshJgsQkAyCMgFGIF+aBAlAjIaFpRW66M85lU8mRc3gGledhQ4KD6wmgLNPshPK2uwgmNSzOKBHEGx+1/6jnHIuMavvYHXNlkU/X9aASlSCsxAtBrXbiGXXVN9Gh5vttUhi/ptkwrMizU4UcHvsHtQRZw1X66pPzQ5c6dglQ3Utp4gGLAm8LkAnYsIYQlZ7drnBj1alktWyfKrW4Xda+m+1O1rYP+iZ6aocunAWgBM0m3APGqBj9aSbmZSADZWL4CaxZ4PSCIqYtJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/tpDTu9EVLXShAy1qUpbosD45rGbuf2QOyRzavMxn4=;
 b=wo3YEk6uoZ+4QgzgK+A7kaV3uqqapr3us9Tz/FKexnOF3HoIlaH3wSp6wz19nGJVqKsmZ++arkNBsrISgwPqXT90yEhlsg9Q+50tfrsZrINA6Kw1EJDaLsv9Dq0BCecSavg7OGewjY3MKen2psz5rlIbjTzzUkhtr4sMfpeR7QY1f+By4lt0AwXjfSCuB0VQORVOsbkQwNP+JNkiaPhUnyWti98WWFVmS1nG8fvQgZ2Dgw+m+qGiZcfqVCgHTAXVuvO3IJ2x4LIu3Z4TTbAc1PFR67I7cRq5n8gpc5C8nQtZa6nnAnbS4m4Vvx9m8FCry2SeBJyiw0Pnzcj5oqoWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/tpDTu9EVLXShAy1qUpbosD45rGbuf2QOyRzavMxn4=;
 b=k4R8fEO1S77wJUXs0+yEobR3haaGhxjPAKpMdT0EGrZTzhrh8GH4yldu15dMVxoQsbc7DZ64bIhMkapyyrbuElxp2b5a8I+2Dp0Zzjfoa4MmdyaZuKmhHMB/4SugMXiUqfV2SpZ8giEbQWMq1YL0vjU0wAIXoXvCJEyrt8f6/AA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by PH0PR12MB999087.namprd12.prod.outlook.com (2603:10b6:510:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 19:29:44 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 19:29:43 +0000
Content-Type: multipart/mixed; boundary="------------Nx4ALlExu7T307bC5j22FBWO"
Message-ID: <ecc35307-3332-4bee-bdd9-db66948caac9@amd.com>
Date: Fri, 13 Nov 2026 14:29:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/amdkfd: Enable HMM device-private THP
 migration in KFD SVM driver
To: amd-gfx@lists.freedesktop.org
References: <20261019133845.166916-1-xiaogang.chen@amd.com>
 <20261019133845.166916-4-xiaogang.chen@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261019133845.166916-4-xiaogang.chen@amd.com>
X-ClientProxiedBy: YT4PR01CA0205.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::27) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|PH0PR12MB999087:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee350d1-2ae3-44d6-0f0d-08df41bc77dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6049299003|18002099003|6133799003|22082099003|8096899003|4053099003|4143699003|261021121427099003|11063799006|261102123227099003|261026140227099003|56012099006|261028144727099003|261022105027099003|10067099003|261021123027099003|261009223027099003|261021135927099003|261022075727099003|261022113327099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: Bi1Kg3/SrXoQZUfVMItdqeTj8QF8rNx/60SFVtE2LJOwNS2W5VQ8PgpwZyUTF2WTBS6MuebKO3QI8BzP8MjSopGY68R2MeRyopCzLMM/iWw0Dx8OLhLgHiuSTwajXuadLe0sRMMLkRh/g/rrj220WE4of8HnHIjJOgYIM9trOsLrayS3tFOhCVOWslDEjtFhGlbecri9zTYxPxzJzpaTOKnOgno4AnPf1adaUIwS+8eePz635omzgOGIEpkdGU/xgbCb7Af1HyfdXSJQOMSr3v2pBYTguikMo0LF18SJy4IcnI9F4cqhXwY6wAYXmqWTJ8LN8hmzPyWf1072feY7cGMHkK+F2ncrMhwMMNZWlYq7gphPNn0oke8cqXXnv/FqmtSHw30O6owx41/S/Z4XU3G13tUCVyG/0QMa8wia11yut33rkJOyRMj+UXWV88ENYYnOYIniyGK4tbguMz/NHXmPbNvx77WyyBg9TaYSUSmT+dqq1kk3rbAmRovHXujovupDgQC2K4DGb8rbzn0LxFwVQPxpA8mrzE+/bwVrqErtMQQbNJoiJF1i6qe0CP3XSzmVdXclms66G9BkZSTHvlqyXSYGkOeyXc+3J9ScVTmSNp3t9xR6zRAZd+ZLwfgJlnQ3d9UBqMlfxSsOMn3PUmFHLwsYZ1uIW2Y4s5zEfAc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6049299003)(18002099003)(6133799003)(22082099003)(8096899003)(4053099003)(4143699003)(261021121427099003)(11063799006)(261102123227099003)(261026140227099003)(56012099006)(261028144727099003)(261022105027099003)(10067099003)(261021123027099003)(261009223027099003)(261021135927099003)(261022075727099003)(261022113327099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGhGcUt3cXJhZVI5WVpDOWV1TDhQd2xnVlpjQjVzalZEWXVOK1YwQmVHb1Z5?=
 =?utf-8?B?T0IvYjRHQnd6RmhUSzduMTJ1UFN3ZHNtS0JwdmxlVjhYQWl6bjFtNjlkZDN3?=
 =?utf-8?B?TldkMnlTMndDSytpMWNzSTdxM0srcUczOEFPTnRqUzVuZGl0ejJXaWtlL2Ir?=
 =?utf-8?B?STR3aXBCc3g2SFJpaExsWWl2M0pYNXpnNGc3dDIrQ0lYTzBiTzFiNGlBTmRr?=
 =?utf-8?B?cmU2aE5WTUlGbkZ4aVF3aGJrY3pBcGxWc2lEajd1YVIyaythYUY5cDBtZ0p1?=
 =?utf-8?B?a2lKMXhkZ3h3R3lNVC9JWGZuSEV5VWczMGFvbml1YkFvbUdSd2hIUitFNzJp?=
 =?utf-8?B?dTM1M29uLytNMUV4TVNsWVJnMmpYRldrdEFmMVpFOURnRzNjV2QwKzFURTYv?=
 =?utf-8?B?VUo0YTE3ZmpQUzhRUEt0bXFjU0F6d3NLTmVsVHhEN0ZLUmJkcnBnYzVoVGVS?=
 =?utf-8?B?VjhIV0ZJS0huTmsxdG9MWlNLMThTWmlpRzU0RFJVclFkQ1p2a1AwY2lMWUFw?=
 =?utf-8?B?OG5vQTNmbmJOVXc2K1lIVm96ZDhnM3pHS2k5cHFPOVBSSnZWQTh2TnZsS1Q2?=
 =?utf-8?B?T2RlazdkQ2U3dWxNaG85S2dlaDgzVlZPa2I2azEzSTM3L0JTcEdxdzBZcTdT?=
 =?utf-8?B?VHY2VEFVNTRGWWtaMWJZTnNpUmF2dDBXc1h1aXBmUmZkVFJzMmhmMFFsM09t?=
 =?utf-8?B?R0puZ096TXdUWDgySlZrZTl5aWNEa0RmQ2ZqN3hXRU9NUnZDVnd4c0llQklG?=
 =?utf-8?B?T2RTTEUrczRCTWdqSUgyUEFnSUdDSEZhOVJ0YklVMXdvUSt2QmJoanhleURr?=
 =?utf-8?B?d2M3Z3pBdUs2Qm00VXVRZWNRL2RkWndRTHYwNUQwN2dKaTdpV0xXTSswSy84?=
 =?utf-8?B?OXc4elVuTzkyVVhlOWpiN0pwYlZvd21BdzNRTVE4b3JQMnFQWmcvTis0aC91?=
 =?utf-8?B?Wjlxd2V3bnpCa3RrdmRhTXN6SmNvNHlUdEdjTjF1VzQ5TnFVaUhUWU13clkr?=
 =?utf-8?B?bEhnRFp2VWpCU3hQV0l1em44N1pkeXF1eE5uUzYrMmJvR1ZnMS8wcnhGS0tF?=
 =?utf-8?B?b0xmRWtsTUwxSVRSUCtOOVB3clZqc2hMZ2JIWTh3WUt6OU1tSzBnd1E0Z2pS?=
 =?utf-8?B?WFR1Y1g1QmY2MWY5NXhTSVErS2hyZzZRMFFZTWhnQnZJVEJpTW9zVzVHYXR0?=
 =?utf-8?B?SUczTlp5YnJ6SDg5Y3dFbTJaeHlwZFlwU0QyLzErMzFzalY2Y2RwRm1EVk4r?=
 =?utf-8?B?OGZzNFpyN0pRQTR1WVNsL01IRnprZzFaVXh2SnRBWkV3WnJsYnRZNHhLWFhp?=
 =?utf-8?B?bDNOclV6dCtOdlJKQUU1alVFZGZtb2RxMFFvaUo0UENYWTBuOVVuRFozVy9q?=
 =?utf-8?B?Y2NiM3d0TXowaU1ObkdCQ0EyanhmYmVMVEhmbjZWR3R2dDllT0oxT05wbU90?=
 =?utf-8?B?WmdxaWtrUThCSWcxU210N05mU0QzVFJINnZHc1A3cTZpR0R2dDNFTGgyd3Fs?=
 =?utf-8?B?dEgrRmtMVWxMc1F1Nkc4cVFzQTZsVlE5cXkwdWtFWU5HMVJpeE9qdnBSV1Ba?=
 =?utf-8?B?SVFYMkphR1J5Q2NKYUlxYjVvUFc1MGdVM0E5QWlxQTlBNWhOT1pOUzNsTHVF?=
 =?utf-8?B?TnIvaG02UjFEa1lzNTBPWTR6aCs0Q0h6blpaQTJIMnltcnFsNlllbWhpdmlS?=
 =?utf-8?B?VnB1YVAzbTJMR0R0TS9ra2YyOEFKU0cwRDczckRZMHdTN2M1azloVkpETnNR?=
 =?utf-8?B?M3JvUG84N3IrSHRMZ25VM2p1aDM5ZnRUelgwV1NpaFNzaE11cHFORkptZEN0?=
 =?utf-8?B?UFkxOXk1NExiK1hMUFA2dUw1OHVrZ3E0NlJGemJvNVRGNldYWHRIdERXMGxK?=
 =?utf-8?B?YXZ6U21ENU1OaTZ4TUlSUTFWcDZnRGxoV1lRcXpyZng3NUk5ZEJUL1RtR2RC?=
 =?utf-8?B?b3dpYkt2eDZDNTFMVUt2VnJVaVMrVG9VVDJHd2d0blU4aGNYZ1JpVkJWTFov?=
 =?utf-8?B?NlpwTTBEWlQ0azN6TUMxcVNuNGh1ajZQTkY2NHpmY2ZxUmkrTkZJUXRuK3Iv?=
 =?utf-8?B?WEpUNTROM2pMeGxLZUU0YUczMkk4bCt6K21SOUhNYnMwdTVZaEhUNjFqOFpO?=
 =?utf-8?B?SjN5U3RhaGV2RWJmT2JxTkpzbUNsVGZzYTUveldNeFkzSlZzbTJQWWhVaTVK?=
 =?utf-8?B?MytXVFBUZUd1dmFaS3VCZ0RRSjQ1U005N2daQXVYeXdndUhSK0dFejRFRldr?=
 =?utf-8?B?ZjBNdW5aSi9IVGJzTkIrQWNCQnZJeDNJa1hRRmZ4UXp0QWV0QUZ4U0NIZlBz?=
 =?utf-8?Q?ViDwhTtrTQZrPhSgnH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee350d1-2ae3-44d6-0f0d-08df41bc77dc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 19:29:43.3529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8NS8RLyPsWRTUHOrGyWK03Ki2hTngafn7pDBOF29Rlp6hA3P/XDpPmiBWRi/fQv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999087
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------Nx4ALlExu7T307bC5j22FBWO
Content-Type: multipart/alternative;
 boundary="------------sYuNFWILDnECY6TKTjUuk4kw"

--------------sYuNFWILDnECY6TKTjUuk4kw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-10-19 09:38, Xiaogang.Chen wrote:
> From: Xiaogang Chen<xiaogang.chen@amd.com>
>
> HMM migrates a PMD-mapped THP as one compound folio when
> migrate_vma_setup() is passed MIGRATE_VMA_SELECT_COMPOUND.
>
> Without that flag the collect path splits the source THP to 4K pages.
> If split_folio() fails because of extra refs or pins, those pages are
> skipped.
>
> Set SELECT_COMPOUND for device-private ranges whose migrate window is
> at least HPAGE_PMD_NR pages. The RAM<->VRAM copy path follows
> MIGRATE_PFN_COMPOUND in src[] (HPAGE_PMD_ORDER device folio, THP DMA)
> and keeps the existing 4K path otherwise.
>
> Coherent zone-device memory is unchanged.

The approach looks right - aligning the migrate window to the folio to 
handle both MIGRATE_PFN_COMPOUND THP migration and normal page migration.

I am attaching two cleanup patches on top of your patch, "drm/amdkfd: 
Simplify svm_migrate_copy_to_vram()" and "drm/amdkfd: Simplify 
svm_migrate_copy_to_ram()". They make no functional change, just making 
the code nicer, cleaner and simpler.

Please see the commit messages for the details of each patch, then 
squash, rework or drop them as you prefer.

Regards,
Philip
>
> Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 253 ++++++++++++++++++-----
>   1 file changed, 203 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 2febe3bb690e..5c98028bfe73 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -324,7 +324,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	u64 mpages = 0;
>   	dma_addr_t *src;
>   	u64 *dst;
> -	u64 i, j;
> +	u64 i, j, k, l, m;
>   	int r = 0;
>   
>   	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%llx]\n", prange->svms, prange->start,
> @@ -335,59 +335,155 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   
>   	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>   			 npages << PAGE_SHIFT, &cursor);
> -	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
> +	for (i = j = m = 0; (i < npages) && (mpages < migrate->cpages);) {
>   		struct page *spage;
> +		unsigned long cur_dst_pfn;
>   
> -		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
> -			dst[i] = cursor.start + (j << PAGE_SHIFT);
> -			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
> -			svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
> -			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
> +		cur_dst_pfn = svm_migrate_addr_to_pfn(adev,
> +						      cursor.start + (m << PAGE_SHIFT));
> +
> +		/* when migrate->src[i] has MIGRATE_PFN_COMPOUND set the src page
> +		 * is compound THP; its vm address is HPAGE_PMD_SIZE aligned and
> +		 * its MIGRATE_PFN_MIGRATE is set
> +		 */
> +		if ((m + HPAGE_PMD_NR) <= (cursor.size >> PAGE_SHIFT) &&
> +		    (i + HPAGE_PMD_NR) <= npages &&
> +		    (migrate->src[i] & MIGRATE_PFN_COMPOUND) &&
> +		    IS_ALIGNED(cur_dst_pfn, HPAGE_PMD_NR)) {
> +			k = HPAGE_PMD_NR;
> +		} else
> +			k = 1;
> +
> +		/* for THP src[0] alwas MIGRATE_PFN_MIGRATE
> +		 * just the first migrate->dst need be setup, others are zero
> +		 */
> +		if (k > 1) {
> +
> +			dst[i] = cursor.start + (m << PAGE_SHIFT);
> +			svm_migrate_get_vram_page(prange, cur_dst_pfn,
> +						  HPAGE_PMD_ORDER);
> +
> +			migrate->dst[i] = migrate_pfn(cur_dst_pfn);
> +			migrate->dst[i] |= MIGRATE_PFN_COMPOUND;
> +
> +			for (l = 1; l < k; l++)
> +				migrate->dst[i+l] = 0;
> +
> +			mpages++;
> +
> +		} else if ((migrate->src[i] & MIGRATE_PFN_MIGRATE)) {
> +			dst[i] = cursor.start + (m << PAGE_SHIFT);
> +			svm_migrate_get_vram_page(prange, cur_dst_pfn, 0);
> +			migrate->dst[i] = migrate_pfn(cur_dst_pfn);
>   			mpages++;
>   		}
> -		spage = migrate_pfn_to_page(migrate->src[i]);
> -		if (spage && !is_zone_device_page(spage)) {
> -			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
> -					      DMA_BIDIRECTIONAL);
> -			r = dma_mapping_error(dev, src[i]);
> -			if (r) {
> -				src[i] = 0;
> -				dev_err(dev, "%s: fail %d dma_map_page\n",
> -					__func__, r);
> -				goto out_free_vram_pages;
> +
> +		if (k > 1) {
> +			if (j) {
> +				/* migrate previous accumulated pages */
> +				r = svm_migrate_copy_memory_gart(
> +						adev, src + i - j,
> +						dst + i - j, j,
> +						FROM_RAM_TO_VRAM,
> +						mfence);
> +
> +				if (r)
> +					goto out_free_vram_pages;
> +
> +				j = 0;
> +			}
> +
> +			/* for THP check if the first src page is valid
> +			 * if not valid skip following HPAGE_PMD_NR - 1 pages
> +			 */
> +			spage = migrate_pfn_to_page(migrate->src[i]);
> +			if (spage && !is_zone_device_page(spage)) {
> +				/* dma_map continuous HPAGE_PMD_NR sys ram pages */
> +				src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE*HPAGE_PMD_NR,
> +						      DMA_BIDIRECTIONAL);
> +
> +				r = dma_mapping_error(dev, src[i]);
> +				if (r) {
> +					dev_err(dev, "%s: fail %d dma_map_page\n",
> +							__func__, r);
> +					goto out_free_vram_pages;
> +				}
> +
> +				/* get dma address for following HPAGE_PMD_NR-1 pages
> +				 * since src pages are continuous their dma addresses
> +				 * are continuous too.
> +				 */
> +				for (l = 1; l < k; l++)
> +					src[i + l] = src[i] + l*PAGE_SIZE;
> +
> +				/* migrate the HPAGE_PMD_NR pages above */
> +				r = svm_migrate_copy_memory_gart(
> +						adev, src + i,
> +						dst + i, HPAGE_PMD_NR,
> +						FROM_RAM_TO_VRAM,
> +						mfence);
> +
> +				/* mark head page dma mapping as THP, tail pages dma addr
> +				 * are set to 0 for following dma_unmap
> +				 */
> +				src[i] |= SVM_RANGE_DMA_THP;
> +				for (l = 1; l < k; l++)
> +					src[i + l] = 0;
> +
> +				if (r)
> +					goto out_free_vram_pages;
> +
> +				j = 0;
>   			}
>   		} else {
> -			if (j) {
> +			/* single normal page case */
> +			spage = migrate_pfn_to_page(migrate->src[i]);
> +			if (spage && !is_zone_device_page(spage)) {
> +				src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
> +						      DMA_BIDIRECTIONAL);
> +
> +				r = dma_mapping_error(dev, src[i]);
> +
> +				if (r) {
> +					dev_err(dev, "%s: fail %d dma_map_page\n",
> +							__func__, r);
> +					goto out_free_vram_pages;
> +				}
> +				j += 1;
> +
> +			} else if (j) {
>   				r = svm_migrate_copy_memory_gart(
>   						adev, src + i - j,
>   						dst + i - j, j,
>   						FROM_RAM_TO_VRAM,
>   						mfence);
> +
>   				if (r)
>   					goto out_free_vram_pages;
> -				amdgpu_res_next(&cursor, (j + 1) << PAGE_SHIFT);
> +
>   				j = 0;
> -			} else {
> -				amdgpu_res_next(&cursor, PAGE_SIZE);
>   			}
> -			continue;
>   		}
>   
> -		pr_debug_ratelimited("dma mapping src to 0x%llx, pfn 0x%lx\n",
> -				     src[i] >> PAGE_SHIFT, page_to_pfn(spage));
> +		pr_debug_ratelimited("dma mapping %lld pages, src to 0x%llx, pfn 0x%lx\n",
> +				     k, src[i] >> PAGE_SHIFT, migrate->src[i] >> MIGRATE_PFN_SHIFT);
> +		i += k;
> +		m += k;
> +
> +		if (m >= (cursor.size >> PAGE_SHIFT)) {
> +			if (j > 0) {
> +				r = svm_migrate_copy_memory_gart(adev, src + i - j,
> +								 dst + i - j, j,
> +								 FROM_RAM_TO_VRAM,
> +								 mfence);
> +				if (r)
> +					goto out_free_vram_pages;
> +			}
> +
> +			amdgpu_res_next(&cursor, m*PAGE_SIZE);
>   
> -		/* accumulated j + 1 pages reach end of current drm_buddy_block */
> -		if (j + 1 >= (cursor.size >> PAGE_SHIFT)) {
> -			r = svm_migrate_copy_memory_gart(adev, src + i - j,
> -							 dst + i - j, j + 1,
> -							 FROM_RAM_TO_VRAM,
> -							 mfence);
> -			if (r)
> -				goto out_free_vram_pages;
> -			amdgpu_res_next(&cursor, (j + 1) * PAGE_SIZE);
>   			j = 0;
> -		} else {
> -			j++;
> +			m = 0;
>   		}
>   	}
>   
> @@ -476,6 +572,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	struct kfd_process_device *pdd;
>   	struct dma_fence *mfence = NULL;
>   	struct migrate_vma migrate = { 0 };
> +	bool is_private_device = false;
>   	unsigned long cpages = 0;
>   	unsigned long mpages = 0;
>   	dma_addr_t *scratch;
> @@ -488,11 +585,17 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	if (svm_range_window_resident(node, prange, start, end))
>   		return 0;
>   
> +	is_private_device = svm_is_private_zone(adev);
> +
>   	memset(&migrate, 0, sizeof(migrate));
>   	migrate.vma = vma;
>   	migrate.start = start;
>   	migrate.end = end;
>   	migrate.flags = MIGRATE_VMA_SELECT_SYSTEM;
> +
> +	if (is_private_device && ((end - start) >> PAGE_SHIFT) >= HPAGE_PMD_NR)
> +		migrate.flags = migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;
> +
>   	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
>   
>   	buf = kvcalloc(npages,
> @@ -686,6 +789,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   	u64 i = 0, j;
>   	u64 addr;
>   	int r = 0;
> +	u64 l, k;
>   
>   	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
>   		 prange->last);
> @@ -694,8 +798,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   
>   	src = (u64 *)(scratch + npages);
>   	dst = scratch;
> -
> -	for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
> +	for (i = 0, j = 0, k = 1; i < npages; i += k, addr += k*PAGE_SIZE, k = 1) {
>   		struct page *spage;
>   
>   		spage = migrate_pfn_to_page(migrate->src[i]);
> @@ -711,6 +814,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   					goto out_oom;
>   				j = 0;
>   			}
> +
>   			continue;
>   		}
>   		src[i] = svm_migrate_addr(adev, spage);
> @@ -724,7 +828,19 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			j = 0;
>   		}
>   
> -		dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
> +		if (IS_ALIGNED(page_to_pfn(spage), HPAGE_PMD_NR) &&
> +		   (addr + HPAGE_PMD_SIZE) <= migrate->end &&
> +		   IS_ALIGNED(addr, HPAGE_PMD_SIZE) &&
> +		   migrate->src[i] & MIGRATE_PFN_COMPOUND) {
> +
> +			k = HPAGE_PMD_NR;
> +			dpage = svm_migrate_get_sys_page(migrate->vma, addr,
> +							 HPAGE_PMD_ORDER);
> +		} else {
> +			k = 1;
> +			dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
> +		}
> +
>   		if (!dpage) {
>   			pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
>   				 prange->svms, prange->start, prange->last);
> @@ -732,7 +848,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			goto out_oom;
>   		}
>   
> -		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
> +		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE*k, DMA_BIDIRECTIONAL);
>   		r = dma_mapping_error(dev, dst[i]);
>   		if (r) {
>   			dev_err(adev->dev, "%s: fail %d dma_map_page\n", __func__, r);
> @@ -740,13 +856,47 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			goto out_oom;
>   		}
>   
> -		pr_debug_ratelimited("dma mapping dst to 0x%llx, pfn 0x%lx\n",
> -				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
> -
>   		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
>   
> -		dpage = NULL;
> -		j++;
> +		if (k > 1) {
> +			migrate->dst[i] |= MIGRATE_PFN_COMPOUND;
> +			/* migrate previous accumulated pages */
> +			if (j) {
> +				r = svm_migrate_copy_memory_gart(adev, dst + i - j,
> +								 src + i - j, j, FROM_VRAM_TO_RAM, mfence);
> +				if (r)
> +					goto out_oom;
> +				j = 0;
> +			}
> +
> +			for (l = 1; l < k; l++) {
> +
> +				src[i + l] = src[i] + l*PAGE_SIZE;
> +				dst[i + l] = dst[i] + l*PAGE_SIZE;
> +				migrate->dst[i + l] = 0;
> +			}
> +
> +			/* migrate the HPAGE_PMD_NR pages above
> +			 * the migration is for 2MB THP
> +			 */
> +			r = svm_migrate_copy_memory_gart(
> +						adev, dst + i,
> +						src + i, HPAGE_PMD_NR,
> +						FROM_VRAM_TO_RAM,
> +						mfence);
> +
> +			/* mark head page dma mapping as THP, tail pages dma addr
> +			 * are set to 0 for following dma_unmap
> +			 */
> +			dst[i] |= SVM_RANGE_DMA_THP;
> +			for (l = 1; l < k; l++)
> +				dst[i + l] = 0;
> +
> +			if (r)
> +				goto out_oom;
> +
> +		} else
> +			j++;
>   	}
>   
>   	if (j > 0)
> @@ -765,12 +915,9 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   		/* release previous allocated sys pages and unmap dma address */
>   		while (i--) {
>   
> -			if (dst[i]) {
> -				dma_unmap_page(dev, dst[i], PAGE_SIZE,
> -					       DMA_BIDIRECTIONAL);
> -				dst[i] = 0;
> -			}
> -
> +			/* follwing svm_range_dma_unmap_dev will do dma unmap anyway
> +			 * not need do dma unmap here
> +			 */
>   			dpage = migrate_pfn_to_page(migrate->dst[i]);
>   			if (!dpage)
>   				continue;
> @@ -811,6 +958,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   	unsigned long cpages = 0;
>   	unsigned long mpages = 0;
>   	struct amdgpu_device *adev = node->adev;
> +	bool is_private_device = false;
>   	struct kfd_process_device *pdd;
>   	struct dma_fence *mfence = NULL;
>   	struct migrate_vma migrate = { 0 };
> @@ -818,6 +966,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   	void *buf;
>   	int r = -ENOMEM;
>   
> +	is_private_device = svm_is_private_zone(adev);
> +
>   	memset(&migrate, 0, sizeof(migrate));
>   	migrate.vma = vma;
>   	migrate.start = start;
> @@ -828,6 +978,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   	else
>   		migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
>   
> +	if (is_private_device && ((end - start) >> PAGE_SHIFT) >= HPAGE_PMD_NR)
> +		migrate.flags = migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;
> +
>   	buf = kvcalloc(npages,
>   		       2 * sizeof(*migrate.src) + sizeof(u64) + sizeof(dma_addr_t),
>   		       GFP_KERNEL);

--------------sYuNFWILDnECY6TKTjUuk4kw
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-10-19 09:38, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261019133845.166916-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

HMM migrates a PMD-mapped THP as one compound folio when
migrate_vma_setup() is passed MIGRATE_VMA_SELECT_COMPOUND.

Without that flag the collect path splits the source THP to 4K pages.
If split_folio() fails because of extra refs or pins, those pages are
skipped.

Set SELECT_COMPOUND for device-private ranges whose migrate window is
at least HPAGE_PMD_NR pages. The RAM&lt;-&gt;VRAM copy path follows
MIGRATE_PFN_COMPOUND in src[] (HPAGE_PMD_ORDER device folio, THP DMA)
and keeps the existing 4K path otherwise.

Coherent zone-device memory is unchanged.</pre>
    </blockquote>
    <br>
    The approach looks right - aligning the migrate window to the folio
    to handle both MIGRATE_PFN_COMPOUND THP migration and normal page
    migration.<br>
    <br>
    I am attaching two cleanup patches on top of your patch,
    &quot;drm/amdkfd: Simplify svm_migrate_copy_to_vram()&quot; and &quot;drm/amdkfd:
    Simplify svm_migrate_copy_to_ram()&quot;. They make no functional change,
    just making the code nicer, cleaner and simpler.<br>
    <br>
    Please see the commit messages for the details of each patch, then
    squash, rework or drop them as you prefer.<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:20261019133845.166916-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">

Signed-off-by: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 253 ++++++++++++++++++-----
 1 file changed, 203 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 2febe3bb690e..5c98028bfe73 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -324,7 +324,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	u64 mpages = 0;
 	dma_addr_t *src;
 	u64 *dst;
-	u64 i, j;
+	u64 i, j, k, l, m;
 	int r = 0;
 
 	pr_debug(&quot;svms 0x%p [0x%lx 0x%lx 0x%llx]\n&quot;, prange-&gt;svms, prange-&gt;start,
@@ -335,59 +335,155 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	amdgpu_res_first(prange-&gt;ttm_res, ttm_res_offset,
 			 npages &lt;&lt; PAGE_SHIFT, &amp;cursor);
-	for (i = j = 0; (i &lt; npages) &amp;&amp; (mpages &lt; migrate-&gt;cpages); i++) {
+	for (i = j = m = 0; (i &lt; npages) &amp;&amp; (mpages &lt; migrate-&gt;cpages);) {
 		struct page *spage;
+		unsigned long cur_dst_pfn;
 
-		if (migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) {
-			dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
-			migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-			svm_migrate_get_vram_page(prange, migrate-&gt;dst[i], 0);
-			migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
+		cur_dst_pfn = svm_migrate_addr_to_pfn(adev,
+						      cursor.start + (m &lt;&lt; PAGE_SHIFT));
+
+		/* when migrate-&gt;src[i] has MIGRATE_PFN_COMPOUND set the src page
+		 * is compound THP; its vm address is HPAGE_PMD_SIZE aligned and
+		 * its MIGRATE_PFN_MIGRATE is set
+		 */
+		if ((m + HPAGE_PMD_NR) &lt;= (cursor.size &gt;&gt; PAGE_SHIFT) &amp;&amp;
+		    (i + HPAGE_PMD_NR) &lt;= npages &amp;&amp;
+		    (migrate-&gt;src[i] &amp; MIGRATE_PFN_COMPOUND) &amp;&amp;
+		    IS_ALIGNED(cur_dst_pfn, HPAGE_PMD_NR)) {
+			k = HPAGE_PMD_NR;
+		} else
+			k = 1;
+
+		/* for THP src[0] alwas MIGRATE_PFN_MIGRATE
+		 * just the first migrate-&gt;dst need be setup, others are zero
+		 */
+		if (k &gt; 1) {
+
+			dst[i] = cursor.start + (m &lt;&lt; PAGE_SHIFT);
+			svm_migrate_get_vram_page(prange, cur_dst_pfn,
+						  HPAGE_PMD_ORDER);
+
+			migrate-&gt;dst[i] = migrate_pfn(cur_dst_pfn);
+			migrate-&gt;dst[i] |= MIGRATE_PFN_COMPOUND;
+
+			for (l = 1; l &lt; k; l++)
+				migrate-&gt;dst[i+l] = 0;
+
+			mpages++;
+
+		} else if ((migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE)) {
+			dst[i] = cursor.start + (m &lt;&lt; PAGE_SHIFT);
+			svm_migrate_get_vram_page(prange, cur_dst_pfn, 0);
+			migrate-&gt;dst[i] = migrate_pfn(cur_dst_pfn);
 			mpages++;
 		}
-		spage = migrate_pfn_to_page(migrate-&gt;src[i]);
-		if (spage &amp;&amp; !is_zone_device_page(spage)) {
-			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
-					      DMA_BIDIRECTIONAL);
-			r = dma_mapping_error(dev, src[i]);
-			if (r) {
-				src[i] = 0;
-				dev_err(dev, &quot;%s: fail %d dma_map_page\n&quot;,
-					__func__, r);
-				goto out_free_vram_pages;
+
+		if (k &gt; 1) {
+			if (j) {
+				/* migrate previous accumulated pages */
+				r = svm_migrate_copy_memory_gart(
+						adev, src + i - j,
+						dst + i - j, j,
+						FROM_RAM_TO_VRAM,
+						mfence);
+
+				if (r)
+					goto out_free_vram_pages;
+
+				j = 0;
+			}
+
+			/* for THP check if the first src page is valid
+			 * if not valid skip following HPAGE_PMD_NR - 1 pages
+			 */
+			spage = migrate_pfn_to_page(migrate-&gt;src[i]);
+			if (spage &amp;&amp; !is_zone_device_page(spage)) {
+				/* dma_map continuous HPAGE_PMD_NR sys ram pages */
+				src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE*HPAGE_PMD_NR,
+						      DMA_BIDIRECTIONAL);
+
+				r = dma_mapping_error(dev, src[i]);
+				if (r) {
+					dev_err(dev, &quot;%s: fail %d dma_map_page\n&quot;,
+							__func__, r);
+					goto out_free_vram_pages;
+				}
+
+				/* get dma address for following HPAGE_PMD_NR-1 pages
+				 * since src pages are continuous their dma addresses
+				 * are continuous too.
+				 */
+				for (l = 1; l &lt; k; l++)
+					src[i + l] = src[i] + l*PAGE_SIZE;
+
+				/* migrate the HPAGE_PMD_NR pages above */
+				r = svm_migrate_copy_memory_gart(
+						adev, src + i,
+						dst + i, HPAGE_PMD_NR,
+						FROM_RAM_TO_VRAM,
+						mfence);
+
+				/* mark head page dma mapping as THP, tail pages dma addr
+				 * are set to 0 for following dma_unmap
+				 */
+				src[i] |= SVM_RANGE_DMA_THP;
+				for (l = 1; l &lt; k; l++)
+					src[i + l] = 0;
+
+				if (r)
+					goto out_free_vram_pages;
+
+				j = 0;
 			}
 		} else {
-			if (j) {
+			/* single normal page case */
+			spage = migrate_pfn_to_page(migrate-&gt;src[i]);
+			if (spage &amp;&amp; !is_zone_device_page(spage)) {
+				src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
+						      DMA_BIDIRECTIONAL);
+
+				r = dma_mapping_error(dev, src[i]);
+
+				if (r) {
+					dev_err(dev, &quot;%s: fail %d dma_map_page\n&quot;,
+							__func__, r);
+					goto out_free_vram_pages;
+				}
+				j += 1;
+
+			} else if (j) {
 				r = svm_migrate_copy_memory_gart(
 						adev, src + i - j,
 						dst + i - j, j,
 						FROM_RAM_TO_VRAM,
 						mfence);
+
 				if (r)
 					goto out_free_vram_pages;
-				amdgpu_res_next(&amp;cursor, (j + 1) &lt;&lt; PAGE_SHIFT);
+
 				j = 0;
-			} else {
-				amdgpu_res_next(&amp;cursor, PAGE_SIZE);
 			}
-			continue;
 		}
 
-		pr_debug_ratelimited(&quot;dma mapping src to 0x%llx, pfn 0x%lx\n&quot;,
-				     src[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(spage));
+		pr_debug_ratelimited(&quot;dma mapping %lld pages, src to 0x%llx, pfn 0x%lx\n&quot;,
+				     k, src[i] &gt;&gt; PAGE_SHIFT, migrate-&gt;src[i] &gt;&gt; MIGRATE_PFN_SHIFT);
+		i += k;
+		m += k;
+
+		if (m &gt;= (cursor.size &gt;&gt; PAGE_SHIFT)) {
+			if (j &gt; 0) {
+				r = svm_migrate_copy_memory_gart(adev, src + i - j,
+								 dst + i - j, j,
+								 FROM_RAM_TO_VRAM,
+								 mfence);
+				if (r)
+					goto out_free_vram_pages;
+			}
+
+			amdgpu_res_next(&amp;cursor, m*PAGE_SIZE);
 
-		/* accumulated j + 1 pages reach end of current drm_buddy_block */
-		if (j + 1 &gt;= (cursor.size &gt;&gt; PAGE_SHIFT)) {
-			r = svm_migrate_copy_memory_gart(adev, src + i - j,
-							 dst + i - j, j + 1,
-							 FROM_RAM_TO_VRAM,
-							 mfence);
-			if (r)
-				goto out_free_vram_pages;
-			amdgpu_res_next(&amp;cursor, (j + 1) * PAGE_SIZE);
 			j = 0;
-		} else {
-			j++;
+			m = 0;
 		}
 	}
 
@@ -476,6 +572,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
+	bool is_private_device = false;
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	dma_addr_t *scratch;
@@ -488,11 +585,17 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	if (svm_range_window_resident(node, prange, start, end))
 		return 0;
 
+	is_private_device = svm_is_private_zone(adev);
+
 	memset(&amp;migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
 	migrate.start = start;
 	migrate.end = end;
 	migrate.flags = MIGRATE_VMA_SELECT_SYSTEM;
+
+	if (is_private_device &amp;&amp; ((end - start) &gt;&gt; PAGE_SHIFT) &gt;= HPAGE_PMD_NR)
+		migrate.flags = migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;
+
 	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
 
 	buf = kvcalloc(npages,
@@ -686,6 +789,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	u64 i = 0, j;
 	u64 addr;
 	int r = 0;
+	u64 l, k;
 
 	pr_debug(&quot;svms 0x%p [0x%lx 0x%lx]\n&quot;, prange-&gt;svms, prange-&gt;start,
 		 prange-&gt;last);
@@ -694,8 +798,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	src = (u64 *)(scratch + npages);
 	dst = scratch;
-
-	for (i = 0, j = 0; i &lt; npages; i++, addr += PAGE_SIZE) {
+	for (i = 0, j = 0, k = 1; i &lt; npages; i += k, addr += k*PAGE_SIZE, k = 1) {
 		struct page *spage;
 
 		spage = migrate_pfn_to_page(migrate-&gt;src[i]);
@@ -711,6 +814,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 					goto out_oom;
 				j = 0;
 			}
+
 			continue;
 		}
 		src[i] = svm_migrate_addr(adev, spage);
@@ -724,7 +828,19 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			j = 0;
 		}
 
-		dpage = svm_migrate_get_sys_page(migrate-&gt;vma, addr, 0);
+		if (IS_ALIGNED(page_to_pfn(spage), HPAGE_PMD_NR) &amp;&amp;
+		   (addr + HPAGE_PMD_SIZE) &lt;= migrate-&gt;end &amp;&amp;
+		   IS_ALIGNED(addr, HPAGE_PMD_SIZE) &amp;&amp;
+		   migrate-&gt;src[i] &amp; MIGRATE_PFN_COMPOUND) {
+
+			k = HPAGE_PMD_NR;
+			dpage = svm_migrate_get_sys_page(migrate-&gt;vma, addr,
+							 HPAGE_PMD_ORDER);
+		} else {
+			k = 1;
+			dpage = svm_migrate_get_sys_page(migrate-&gt;vma, addr, 0);
+		}
+
 		if (!dpage) {
 			pr_debug(&quot;failed get page svms 0x%p [0x%lx 0x%lx]\n&quot;,
 				 prange-&gt;svms, prange-&gt;start, prange-&gt;last);
@@ -732,7 +848,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			goto out_oom;
 		}
 
-		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
+		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE*k, DMA_BIDIRECTIONAL);
 		r = dma_mapping_error(dev, dst[i]);
 		if (r) {
 			dev_err(adev-&gt;dev, &quot;%s: fail %d dma_map_page\n&quot;, __func__, r);
@@ -740,13 +856,47 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			goto out_oom;
 		}
 
-		pr_debug_ratelimited(&quot;dma mapping dst to 0x%llx, pfn 0x%lx\n&quot;,
-				     dst[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(dpage));
-
 		migrate-&gt;dst[i] = migrate_pfn(page_to_pfn(dpage));
 
-		dpage = NULL;
-		j++;
+		if (k &gt; 1) {
+			migrate-&gt;dst[i] |= MIGRATE_PFN_COMPOUND;
+			/* migrate previous accumulated pages */
+			if (j) {
+				r = svm_migrate_copy_memory_gart(adev, dst + i - j,
+								 src + i - j, j, FROM_VRAM_TO_RAM, mfence);
+				if (r)
+					goto out_oom;
+				j = 0;
+			}
+
+			for (l = 1; l &lt; k; l++) {
+
+				src[i + l] = src[i] + l*PAGE_SIZE;
+				dst[i + l] = dst[i] + l*PAGE_SIZE;
+				migrate-&gt;dst[i + l] = 0;
+			}
+
+			/* migrate the HPAGE_PMD_NR pages above
+			 * the migration is for 2MB THP
+			 */
+			r = svm_migrate_copy_memory_gart(
+						adev, dst + i,
+						src + i, HPAGE_PMD_NR,
+						FROM_VRAM_TO_RAM,
+						mfence);
+
+			/* mark head page dma mapping as THP, tail pages dma addr
+			 * are set to 0 for following dma_unmap
+			 */
+			dst[i] |= SVM_RANGE_DMA_THP;
+			for (l = 1; l &lt; k; l++)
+				dst[i + l] = 0;
+
+			if (r)
+				goto out_oom;
+
+		} else
+			j++;
 	}
 
 	if (j &gt; 0)
@@ -765,12 +915,9 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		/* release previous allocated sys pages and unmap dma address */
 		while (i--) {
 
-			if (dst[i]) {
-				dma_unmap_page(dev, dst[i], PAGE_SIZE,
-					       DMA_BIDIRECTIONAL);
-				dst[i] = 0;
-			}
-
+			/* follwing svm_range_dma_unmap_dev will do dma unmap anyway
+			 * not need do dma unmap here
+			 */
 			dpage = migrate_pfn_to_page(migrate-&gt;dst[i]);
 			if (!dpage)
 				continue;
@@ -811,6 +958,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	struct amdgpu_device *adev = node-&gt;adev;
+	bool is_private_device = false;
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
@@ -818,6 +966,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	void *buf;
 	int r = -ENOMEM;
 
+	is_private_device = svm_is_private_zone(adev);
+
 	memset(&amp;migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
 	migrate.start = start;
@@ -828,6 +978,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	else
 		migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
 
+	if (is_private_device &amp;&amp; ((end - start) &gt;&gt; PAGE_SHIFT) &gt;= HPAGE_PMD_NR)
+		migrate.flags = migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;
+
 	buf = kvcalloc(npages,
 		       2 * sizeof(*migrate.src) + sizeof(u64) + sizeof(dma_addr_t),
 		       GFP_KERNEL);
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------sYuNFWILDnECY6TKTjUuk4kw--

--------------Nx4ALlExu7T307bC5j22FBWO
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-drm-amdkfd-Simplify-svm_migrate_copy_to_ram.patch"
Content-Disposition: attachment;
 filename="0002-drm-amdkfd-Simplify-svm_migrate_copy_to_ram.patch"
Content-Transfer-Encoding: base64

RnJvbSBiMjE0ZDBiMTlmODlmNjc0NTc4ZTA1YjI4OWY5ZWVkMDNhYThiODczIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgWWFuZyA8UGhpbGlwLllhbmdAYW1kLmNvbT4KRGF0
ZTogRnJpLCAxMyBOb3YgMjAyNiAxNDowNjo1MCAtMDUwMApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBk
cm0vYW1ka2ZkOiBTaW1wbGlmeSBzdm1fbWlncmF0ZV9jb3B5X3RvX3JhbSgpCgpGb2xkIHRoZSBU
SFAgYW5kIHRoZSBzaW5nbGUgcGFnZSBwYXRocyBpbnRvIG9uZSBmbG93LCB0aGUgc2FtZSB3YXkK
c3ZtX21pZ3JhdGVfY29weV90b192cmFtKCkgZG9lczoKCiAtIHJldXNlIHN2bV9taWdyYXRlX2Zs
dXNoX2JhdGNoKCkgZm9yIHRoZSBhY2N1bXVsYXRlZCBjb3B5LCBpdCB0YWtlcyB0aGUKICAgZGly
ZWN0aW9uIG5vdyBzbyBib3RoIG1pZ3JhdGlvbiBkaXJlY3Rpb25zIHNoYXJlIGl0LiBJdCBpcyBh
IG5vLW9wCiAgIHdoZW4gbm90aGluZyBpcyBwZW5kaW5nLCBzbyB0aGUgY2FsbGVycyBubyBsb25n
ZXIgbmVlZCB0byBndWFyZCBpdCBhbmQKICAgc3ZtX21pZ3JhdGVfY29weV9tZW1vcnlfZ2FydCgp
IGlzIGNhbGxlZCBmcm9tIHRoZXJlIG9ubHkuCiAtIHJlbmFtZSB0aGUgbG9vcCB2YXJpYWJsZXMg
dG8gaSBhbmQgYmF0Y2gsIGFuZCBkZXJpdmUgdGhlIHN0ZXAgbnIgZnJvbQogICBvcmRlciBzbyB0
aGF0IG9yZGVyIGNhbiBiZSBwYXNzZWQgdG8gc3ZtX21pZ3JhdGVfZ2V0X3N5c19wYWdlKCkKICAg
ZGlyZWN0bHkuCiAtIGZpbGwgdGhlIHRhaWwgZW50cmllcyB1bmNvbmRpdGlvbmFsbHksIHRoZSBs
b29wcyBhcmUgbm8tb3BzIGZvciBhbgogICBvcmRlciAwIHBhZ2UuCgpUaGUgYWNjdW11bGF0ZWQg
cGFnZXMgc3RpbGwgaGF2ZSB0byBzdGF5IGNvbnRpZ3VvdXMgaW4gVlJBTSwgYW5kIGEgVEhQIGlz
CnN0aWxsIGNvcGllZCBvbiBpdHMgb3duLCBzbyBib3RoIGRyYWluIHRoZSBiYXRjaCBmaXJzdC4K
ClRoaXMgYWxzbyBmaXhlcyBhIGRvdWJsZSBmcmVlIG9uIHRoZSBlcnJvciBwYXRocy4gZHBhZ2Ug
aXMgZGVjbGFyZWQKb3V0c2lkZSB0aGUgbG9vcCBhbmQgdGhlIGNsZWFudXAgcmVsZWFzZXMgaXQg
YmVmb3JlIHdhbGtpbmcKbWlncmF0ZS0+ZHN0W10sIHdoaWNoIGlzIG9ubHkgY29ycmVjdCB3aGVu
IGRtYV9tYXBfcGFnZSgpIGZhaWxlZC4gT24gYW55Cm90aGVyIGVycm9yLCBhIGZhaWxpbmcgY29w
eSBmb3IgaW5zdGFuY2UsIGRwYWdlIHN0aWxsIHBvaW50cyBhdCBhIHBhZ2Ugb2YKYW4gZWFybGll
ciBpdGVyYXRpb24gd2hpY2ggaXMgYWxyZWFkeSByZWNvcmRlZCBpbiBtaWdyYXRlLT5kc3RbXSwg
c28gdGhlCndhbGsgdW5sb2NrcyBhbmQgcHV0cyBpdCBhIHNlY29uZCB0aW1lLiBDbGVhciBkcGFn
ZSBvbmNlIHRoZSBwYWdlIGlzCnJlY29yZGVkLCBhbmQgYWR2YW5jZSBpIGJlZm9yZSB0aGUgVEhQ
IGNvcHkgc28gdGhhdCB0aGUgd2FsayBjb3ZlcnMgdGhlCmVudHJ5IHRoZSBjb3B5IGZhaWxlZCBv
bi4KCk5vIGZ1bmN0aW9uYWwgY2hhbmdlIG90aGVyd2lzZS4KClNpZ25lZC1vZmYtYnk6IFBoaWxp
cCBZYW5nIDxQaGlsaXAuWWFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9taWdyYXRlLmMgfCAxNTQgKysrKysrKysrKystLS0tLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCA3MSBpbnNlcnRpb25zKCspLCA4MyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0ZS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYwppbmRleCBiMmZlNDBiYzc1MTAuLjM1N2ZmODJmYmI2
NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0ZS5jCkBAIC0zMTQsMTYg
KzMxNCwxNyBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBzdm1fbWlncmF0ZV9zdWNjZXNzZnVsX3Bh
Z2VzKHN0cnVjdCBtaWdyYXRlX3ZtYSAqbWlncmF0ZSkKIAogLyogQ29weSB0aGUgcGFnZXMgYWNj
dW11bGF0ZWQgaW4gW2kgLSAqYmF0Y2gsIGkpIGFuZCByZXNldCB0aGUgYWNjdW11bGF0b3IuICov
CiBzdGF0aWMgaW50Ci1zdm1fbWlncmF0ZV9mbHVzaF9iYXRjaChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwgZG1hX2FkZHJfdCAqc3JjLCB1NjQgKmRzdCwKLQkJCXU2NCBpLCB1NjQgKmJhdGNo
LCBzdHJ1Y3QgZG1hX2ZlbmNlICoqbWZlbmNlKQorc3ZtX21pZ3JhdGVfZmx1c2hfYmF0Y2goc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGRtYV9hZGRyX3QgKnN5cywgdTY0ICp2cmFtLAorCQkJ
dTY0IGksIHU2NCAqYmF0Y2gsIGVudW0gTUlHUkFUSU9OX0NPUFlfRElSIGRpciwKKwkJCXN0cnVj
dCBkbWFfZmVuY2UgKiptZmVuY2UpCiB7CiAJaW50IHI7CiAKIAlpZiAoISpiYXRjaCkKIAkJcmV0
dXJuIDA7CiAKLQlyID0gc3ZtX21pZ3JhdGVfY29weV9tZW1vcnlfZ2FydChhZGV2LCBzcmMgKyBp
IC0gKmJhdGNoLCBkc3QgKyBpIC0gKmJhdGNoLAotCQkJCQkgKmJhdGNoLCBGUk9NX1JBTV9UT19W
UkFNLCBtZmVuY2UpOworCXIgPSBzdm1fbWlncmF0ZV9jb3B5X21lbW9yeV9nYXJ0KGFkZXYsIHN5
cyArIGkgLSAqYmF0Y2gsIHZyYW0gKyBpIC0gKmJhdGNoLAorCQkJCQkgKmJhdGNoLCBkaXIsIG1m
ZW5jZSk7CiAJKmJhdGNoID0gMDsKIAlyZXR1cm4gcjsKIH0KQEAgLTM5Niw3ICszOTcsOCBAQCBz
dm1fbWlncmF0ZV9jb3B5X3RvX3ZyYW0oc3RydWN0IGtmZF9ub2RlICpub2RlLCBzdHJ1Y3Qgc3Zt
X3JhbmdlICpwcmFuZ2UsCiAKIAkJLyogQSBUSFAgaXMgY29waWVkIG9uIGl0cyBvd24sIHNvIGRy
YWluIHdoYXRldmVyIHByZWNlZGVkIGl0LiAqLwogCQlpZiAob3JkZXIgfHwgIXNwYWdlKSB7Ci0J
CQlyID0gc3ZtX21pZ3JhdGVfZmx1c2hfYmF0Y2goYWRldiwgc3JjLCBkc3QsIGksICZiYXRjaCwg
bWZlbmNlKTsKKwkJCXIgPSBzdm1fbWlncmF0ZV9mbHVzaF9iYXRjaChhZGV2LCBzcmMsIGRzdCwg
aSwgJmJhdGNoLAorCQkJCQkJICAgIEZST01fUkFNX1RPX1ZSQU0sIG1mZW5jZSk7CiAJCQlpZiAo
cikKIAkJCQlnb3RvIG91dF9mcmVlX3ZyYW1fcGFnZXM7CiAJCX0KQEAgLTQyMCw3ICs0MjIsNyBA
QCBzdm1fbWlncmF0ZV9jb3B5X3RvX3ZyYW0oc3RydWN0IGtmZF9ub2RlICpub2RlLCBzdHJ1Y3Qg
c3ZtX3JhbmdlICpwcmFuZ2UsCiAKIAkJaWYgKG9yZGVyICYmIHNwYWdlKSB7CiAJCQlyID0gc3Zt
X21pZ3JhdGVfZmx1c2hfYmF0Y2goYWRldiwgc3JjLCBkc3QsIGkgKyBuciwgJmJhdGNoLAotCQkJ
CQkJICAgIG1mZW5jZSk7CisJCQkJCQkgICAgRlJPTV9SQU1fVE9fVlJBTSwgbWZlbmNlKTsKIAog
CQkJLyogTWFyayB0aGUgaGVhZCBzbyBzdm1fcmFuZ2VfZG1hX3VubWFwKCkgdW5tYXBzIHRoZSB3
aG9sZQogCQkJICogVEhQLCBhbmQgY2xlYXIgdGhlIHRhaWxzLgpAQCAtNDQxLDcgKzQ0Myw4IEBA
IHN2bV9taWdyYXRlX2NvcHlfdG9fdnJhbShzdHJ1Y3Qga2ZkX25vZGUgKm5vZGUsIHN0cnVjdCBz
dm1fcmFuZ2UgKnByYW5nZSwKIAkJb2ZmICs9IG5yOwogCiAJCWlmIChvZmYgPj0gKGN1cnNvci5z
aXplID4+IFBBR0VfU0hJRlQpKSB7Ci0JCQlyID0gc3ZtX21pZ3JhdGVfZmx1c2hfYmF0Y2goYWRl
diwgc3JjLCBkc3QsIGksICZiYXRjaCwgbWZlbmNlKTsKKwkJCXIgPSBzdm1fbWlncmF0ZV9mbHVz
aF9iYXRjaChhZGV2LCBzcmMsIGRzdCwgaSwgJmJhdGNoLAorCQkJCQkJICAgIEZST01fUkFNX1RP
X1ZSQU0sIG1mZW5jZSk7CiAJCQlpZiAocikKIAkJCQlnb3RvIG91dF9mcmVlX3ZyYW1fcGFnZXM7
CiAKQEAgLTQ1MCw3ICs0NTMsOCBAQCBzdm1fbWlncmF0ZV9jb3B5X3RvX3ZyYW0oc3RydWN0IGtm
ZF9ub2RlICpub2RlLCBzdHJ1Y3Qgc3ZtX3JhbmdlICpwcmFuZ2UsCiAJCX0KIAl9CiAKLQlyID0g
c3ZtX21pZ3JhdGVfZmx1c2hfYmF0Y2goYWRldiwgc3JjLCBkc3QsIGksICZiYXRjaCwgbWZlbmNl
KTsKKwlyID0gc3ZtX21pZ3JhdGVfZmx1c2hfYmF0Y2goYWRldiwgc3JjLCBkc3QsIGksICZiYXRj
aCwgRlJPTV9SQU1fVE9fVlJBTSwKKwkJCQkgICAgbWZlbmNlKTsKIAogb3V0X2ZyZWVfdnJhbV9w
YWdlczoKIAlpZiAocikgewpAQCAtNzQ2LDExICs3NTAsOCBAQCBzdm1fbWlncmF0ZV9jb3B5X3Rv
X3JhbShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IHN2bV9yYW5nZSAqcHJhbmdl
LAogCXN0cnVjdCBwYWdlICpkcGFnZSA9IE5VTEw7CiAJZG1hX2FkZHJfdCAqZHN0OwogCXU2NCAq
c3JjOwotCi0JdTY0IGkgPSAwLCBqOwotCXU2NCBhZGRyOworCXU2NCBpLCBiYXRjaCwgYWRkcjsK
IAlpbnQgciA9IDA7Ci0JdTY0IGwsIGs7CiAKIAlwcl9kZWJ1Zygic3ZtcyAweCVwIFsweCVseCAw
eCVseF1cbiIsIHByYW5nZS0+c3ZtcywgcHJhbmdlLT5zdGFydCwKIAkJIHByYW5nZS0+bGFzdCk7
CkBAIC03NTksNDkgKzc2MCw0NiBAQCBzdm1fbWlncmF0ZV9jb3B5X3RvX3JhbShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwgc3RydWN0IHN2bV9yYW5nZSAqcHJhbmdlLAogCiAJc3JjID0gKHU2
NCAqKShzY3JhdGNoICsgbnBhZ2VzKTsKIAlkc3QgPSBzY3JhdGNoOwotCWZvciAoaSA9IDAsIGog
PSAwLCBrID0gMTsgaSA8IG5wYWdlczsgaSArPSBrLCBhZGRyICs9IGsqUEFHRV9TSVpFLCBrID0g
MSkgewotCQlzdHJ1Y3QgcGFnZSAqc3BhZ2U7CiAKLQkJc3BhZ2UgPSBtaWdyYXRlX3Bmbl90b19w
YWdlKG1pZ3JhdGUtPnNyY1tpXSk7CisJZm9yIChpID0gYmF0Y2ggPSAwOyBpIDwgbnBhZ2VzOykg
eworCQlzdHJ1Y3QgcGFnZSAqc3BhZ2UgPSBtaWdyYXRlX3Bmbl90b19wYWdlKG1pZ3JhdGUtPnNy
Y1tpXSk7CisJCXVuc2lnbmVkIGludCBvcmRlciA9IDA7CisJCXU2NCBuciwgbjsKKwogCQlpZiAo
IXNwYWdlIHx8ICFpc196b25lX2RldmljZV9wYWdlKHNwYWdlKSkgewogCQkJcHJfZGVidWcoImlu
dmFsaWQgcGFnZS4gQ291bGQgYmUgaW4gQ1BVIGFscmVhZHkgc3ZtcyAweCVwIFsweCVseCAweCVs
eF1cbiIsCiAJCQkJIHByYW5nZS0+c3ZtcywgcHJhbmdlLT5zdGFydCwgcHJhbmdlLT5sYXN0KTsK
LQkJCWlmIChqKSB7Ci0JCQkJciA9IHN2bV9taWdyYXRlX2NvcHlfbWVtb3J5X2dhcnQoYWRldiwg
ZHN0ICsgaSAtIGosCi0JCQkJCQkJCSBzcmMgKyBpIC0gaiwgaiwKLQkJCQkJCQkJIEZST01fVlJB
TV9UT19SQU0sCi0JCQkJCQkJCSBtZmVuY2UpOwotCQkJCWlmIChyKQotCQkJCQlnb3RvIG91dF9v
b207Ci0JCQkJaiA9IDA7Ci0JCQl9CisJCQlyID0gc3ZtX21pZ3JhdGVfZmx1c2hfYmF0Y2goYWRl
diwgZHN0LCBzcmMsIGksICZiYXRjaCwKKwkJCQkJCSAgICBGUk9NX1ZSQU1fVE9fUkFNLCBtZmVu
Y2UpOworCQkJaWYgKHIpCisJCQkJZ290byBvdXRfb29tOwogCisJCQlpKys7CisJCQlhZGRyICs9
IFBBR0VfU0laRTsKIAkJCWNvbnRpbnVlOwogCQl9CisKIAkJc3JjW2ldID0gc3ZtX21pZ3JhdGVf
YWRkcihhZGV2LCBzcGFnZSk7Ci0JCWlmIChqID4gMCAmJiBzcmNbaV0gIT0gc3JjW2kgLSAxXSAr
IFBBR0VfU0laRSkgewotCQkJciA9IHN2bV9taWdyYXRlX2NvcHlfbWVtb3J5X2dhcnQoYWRldiwg
ZHN0ICsgaSAtIGosCi0JCQkJCQkJIHNyYyArIGkgLSBqLCBqLAotCQkJCQkJCSBGUk9NX1ZSQU1f
VE9fUkFNLAotCQkJCQkJCSBtZmVuY2UpOwotCQkJaWYgKHIpCi0JCQkJZ290byBvdXRfb29tOwot
CQkJaiA9IDA7Ci0JCX0KIAotCQlpZiAoSVNfQUxJR05FRChwYWdlX3RvX3BmbihzcGFnZSksIEhQ
QUdFX1BNRF9OUikgJiYKLQkJICAgKGFkZHIgKyBIUEFHRV9QTURfU0laRSkgPD0gbWlncmF0ZS0+
ZW5kICYmCi0JCSAgIElTX0FMSUdORUQoYWRkciwgSFBBR0VfUE1EX1NJWkUpICYmCi0JCSAgIG1p
Z3JhdGUtPnNyY1tpXSAmIE1JR1JBVEVfUEZOX0NPTVBPVU5EKSB7CisJCS8qIE1JR1JBVEVfUEZO
X0NPTVBPVU5EIG1lYW5zIHRoZSBzb3VyY2UgaXMgYSAyTUIgVlJBTSBmb2xpby4gKi8KKwkJaWYg
KChtaWdyYXRlLT5zcmNbaV0gJiBNSUdSQVRFX1BGTl9DT01QT1VORCkgJiYKKwkJICAgIElTX0FM
SUdORUQocGFnZV90b19wZm4oc3BhZ2UpLCBIUEFHRV9QTURfTlIpICYmCisJCSAgICBJU19BTElH
TkVEKGFkZHIsIEhQQUdFX1BNRF9TSVpFKSAmJgorCQkgICAgYWRkciArIEhQQUdFX1BNRF9TSVpF
IDw9IG1pZ3JhdGUtPmVuZCkKKwkJCW9yZGVyID0gSFBBR0VfUE1EX09SREVSOworCQluciA9IDFV
TEwgPDwgb3JkZXI7CiAKLQkJCWsgPSBIUEFHRV9QTURfTlI7Ci0JCQlkcGFnZSA9IHN2bV9taWdy
YXRlX2dldF9zeXNfcGFnZShtaWdyYXRlLT52bWEsIGFkZHIsCi0JCQkJCQkJIEhQQUdFX1BNRF9P
UkRFUik7Ci0JCX0gZWxzZSB7Ci0JCQlrID0gMTsKLQkJCWRwYWdlID0gc3ZtX21pZ3JhdGVfZ2V0
X3N5c19wYWdlKG1pZ3JhdGUtPnZtYSwgYWRkciwgMCk7CisJCS8qIFRoZSBhY2N1bXVsYXRlZCBw
YWdlcyBoYXZlIHRvIHN0YXkgY29udGlndW91cyBpbiBWUkFNLCBhbmQgYQorCQkgKiBUSFAgaXMg
Y29waWVkIG9uIGl0cyBvd24uCisJCSAqLworCQlpZiAob3JkZXIgfHwgKGJhdGNoICYmIHNyY1tp
XSAhPSBzcmNbaSAtIDFdICsgUEFHRV9TSVpFKSkgeworCQkJciA9IHN2bV9taWdyYXRlX2ZsdXNo
X2JhdGNoKGFkZXYsIGRzdCwgc3JjLCBpLCAmYmF0Y2gsCisJCQkJCQkgICAgRlJPTV9WUkFNX1RP
X1JBTSwgbWZlbmNlKTsKKwkJCWlmIChyKQorCQkJCWdvdG8gb3V0X29vbTsKIAkJfQogCisJCWRw
YWdlID0gc3ZtX21pZ3JhdGVfZ2V0X3N5c19wYWdlKG1pZ3JhdGUtPnZtYSwgYWRkciwgb3JkZXIp
OwogCQlpZiAoIWRwYWdlKSB7CiAJCQlwcl9kZWJ1ZygiZmFpbGVkIGdldCBwYWdlIHN2bXMgMHgl
cCBbMHglbHggMHglbHhdXG4iLAogCQkJCSBwcmFuZ2UtPnN2bXMsIHByYW5nZS0+c3RhcnQsIHBy
YW5nZS0+bGFzdCk7CkBAIC04MDksNjUgKzgwNyw1NSBAQCBzdm1fbWlncmF0ZV9jb3B5X3RvX3Jh
bShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IHN2bV9yYW5nZSAqcHJhbmdlLAog
CQkJZ290byBvdXRfb29tOwogCQl9CiAKLQkJZHN0W2ldID0gZG1hX21hcF9wYWdlKGRldiwgZHBh
Z2UsIDAsIFBBR0VfU0laRSprLCBETUFfQklESVJFQ1RJT05BTCk7CisJCWRzdFtpXSA9IGRtYV9t
YXBfcGFnZShkZXYsIGRwYWdlLCAwLCBuciA8PCBQQUdFX1NISUZULAorCQkJCSAgICAgIERNQV9C
SURJUkVDVElPTkFMKTsKIAkJciA9IGRtYV9tYXBwaW5nX2Vycm9yKGRldiwgZHN0W2ldKTsKIAkJ
aWYgKHIpIHsKLQkJCWRldl9lcnIoYWRldi0+ZGV2LCAiJXM6IGZhaWwgJWQgZG1hX21hcF9wYWdl
XG4iLCBfX2Z1bmNfXywgcik7CisJCQlkZXZfZXJyKGRldiwgIiVzOiBmYWlsICVkIGRtYV9tYXBf
cGFnZVxuIiwgX19mdW5jX18sIHIpOwogCQkJZHN0W2ldID0gMDsKIAkJCWdvdG8gb3V0X29vbTsK
IAkJfQogCi0JCW1pZ3JhdGUtPmRzdFtpXSA9IG1pZ3JhdGVfcGZuKHBhZ2VfdG9fcGZuKGRwYWdl
KSk7Ci0KLQkJaWYgKGsgPiAxKSB7Ci0JCQltaWdyYXRlLT5kc3RbaV0gfD0gTUlHUkFURV9QRk5f
Q09NUE9VTkQ7Ci0JCQkvKiBtaWdyYXRlIHByZXZpb3VzIGFjY3VtdWxhdGVkIHBhZ2VzICovCi0J
CQlpZiAoaikgewotCQkJCXIgPSBzdm1fbWlncmF0ZV9jb3B5X21lbW9yeV9nYXJ0KGFkZXYsIGRz
dCArIGkgLSBqLAotCQkJCQkJCQkgc3JjICsgaSAtIGosIGosIEZST01fVlJBTV9UT19SQU0sIG1m
ZW5jZSk7Ci0JCQkJaWYgKHIpCi0JCQkJCWdvdG8gb3V0X29vbTsKLQkJCQlqID0gMDsKLQkJCX0K
KwkJbWlncmF0ZS0+ZHN0W2ldID0gbWlncmF0ZV9wZm4ocGFnZV90b19wZm4oZHBhZ2UpKSB8CisJ
CQkJICAob3JkZXIgPyBNSUdSQVRFX1BGTl9DT01QT1VORCA6IDApOwogCi0JCQlmb3IgKGwgPSAx
OyBsIDwgazsgbCsrKSB7CisJCS8qIEJvdGggc2lkZXMgYXJlIGNvbnRpZ3VvdXMsIHNvIGFyZSB0
aGVpciBhZGRyZXNzZXMuICovCisJCWZvciAobiA9IDE7IG4gPCBucjsgbisrKSB7CisJCQlzcmNb
aSArIG5dID0gc3JjW2ldICsgKG4gPDwgUEFHRV9TSElGVCk7CisJCQlkc3RbaSArIG5dID0gZHN0
W2ldICsgKG4gPDwgUEFHRV9TSElGVCk7CisJCQltaWdyYXRlLT5kc3RbaSArIG5dID0gMDsKKwkJ
fQorCQliYXRjaCArPSBucjsKIAotCQkJCXNyY1tpICsgbF0gPSBzcmNbaV0gKyBsKlBBR0VfU0la
RTsKLQkJCQlkc3RbaSArIGxdID0gZHN0W2ldICsgbCpQQUdFX1NJWkU7Ci0JCQkJbWlncmF0ZS0+
ZHN0W2kgKyBsXSA9IDA7Ci0JCQl9CisJCS8qIGRwYWdlIGlzIG5vdyBvd25lZCBieSBtaWdyYXRl
LT5kc3RbXSwgb3V0X29vbSBmcmVlcyBpdCBmcm9tIHRoZXJlLiAqLworCQlkcGFnZSA9IE5VTEw7
CiAKLQkJCS8qIG1pZ3JhdGUgdGhlIEhQQUdFX1BNRF9OUiBwYWdlcyBhYm92ZQotCQkJICogdGhl
IG1pZ3JhdGlvbiBpcyBmb3IgMk1CIFRIUAotCQkJICovCi0JCQlyID0gc3ZtX21pZ3JhdGVfY29w
eV9tZW1vcnlfZ2FydCgKLQkJCQkJCWFkZXYsIGRzdCArIGksCi0JCQkJCQlzcmMgKyBpLCBIUEFH
RV9QTURfTlIsCi0JCQkJCQlGUk9NX1ZSQU1fVE9fUkFNLAotCQkJCQkJbWZlbmNlKTsKLQotCQkJ
LyogbWFyayBoZWFkIHBhZ2UgZG1hIG1hcHBpbmcgYXMgVEhQLCB0YWlsIHBhZ2VzIGRtYSBhZGRy
Ci0JCQkgKiBhcmUgc2V0IHRvIDAgZm9yIGZvbGxvd2luZyBkbWFfdW5tYXAKKwkJaSArPSBucjsK
KwkJYWRkciArPSBuciA8PCBQQUdFX1NISUZUOworCisJCWlmIChvcmRlcikgeworCQkJciA9IHN2
bV9taWdyYXRlX2ZsdXNoX2JhdGNoKGFkZXYsIGRzdCwgc3JjLCBpLCAmYmF0Y2gsCisJCQkJCQkg
ICAgRlJPTV9WUkFNX1RPX1JBTSwgbWZlbmNlKTsKKworCQkJLyogTWFyayB0aGUgaGVhZCBzbyBz
dm1fcmFuZ2VfZG1hX3VubWFwKCkgdW5tYXBzIHRoZSB3aG9sZQorCQkJICogVEhQLCBhbmQgY2xl
YXIgdGhlIHRhaWxzLgogCQkJICovCi0JCQlkc3RbaV0gfD0gU1ZNX1JBTkdFX0RNQV9USFA7Ci0J
CQlmb3IgKGwgPSAxOyBsIDwgazsgbCsrKQotCQkJCWRzdFtpICsgbF0gPSAwOworCQkJZHN0W2kg
LSBucl0gfD0gU1ZNX1JBTkdFX0RNQV9USFA7CisJCQlmb3IgKG4gPSAxOyBuIDwgbnI7IG4rKykK
KwkJCQlkc3RbaSAtIG5yICsgbl0gPSAwOwogCiAJCQlpZiAocikKIAkJCQlnb3RvIG91dF9vb207
Ci0KLQkJfSBlbHNlCi0JCQlqKys7CisJCX0KIAl9CiAKLQlpZiAoaiA+IDApCi0JCXIgPSBzdm1f
bWlncmF0ZV9jb3B5X21lbW9yeV9nYXJ0KGFkZXYsIGRzdCArIGkgLSBqLCBzcmMgKyBpIC0gaiwg
aiwKLQkJCQkJCSBGUk9NX1ZSQU1fVE9fUkFNLCBtZmVuY2UpOworCXIgPSBzdm1fbWlncmF0ZV9m
bHVzaF9iYXRjaChhZGV2LCBkc3QsIHNyYywgaSwgJmJhdGNoLCBGUk9NX1ZSQU1fVE9fUkFNLAor
CQkJCSAgICBtZmVuY2UpOwogb3V0X29vbToKIAlpZiAocikgewogCQlwcl9kZWJ1ZygiZmFpbGVk
ICVkIGNvcHkgdG8gcmFtXG4iLCByKTsKIAotCQkvKiBmaXJzdCByZWxlYXNlIGN1cnJlbnQgZHBh
Z2Ugd2hlbiBkbWFfbWFwX3BhZ2UgZmFpbCAqLworCQkvKiBUaGUgcGFnZSBvZiB0aGUgY3VycmVu
dCBpdGVyYXRpb24gaXMgbm90IGluIG1pZ3JhdGUtPmRzdFtdIHlldC4gKi8KIAkJaWYgKGRwYWdl
KSB7CiAJCQl1bmxvY2tfcGFnZShkcGFnZSk7CiAJCQlwdXRfcGFnZShkcGFnZSk7Ci0tIAoyLjUw
LjEKCg==

--------------Nx4ALlExu7T307bC5j22FBWO
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-amdkfd-Simplify-svm_migrate_copy_to_vram.patch"
Content-Disposition: attachment;
 filename="0001-drm-amdkfd-Simplify-svm_migrate_copy_to_vram.patch"
Content-Transfer-Encoding: base64

RnJvbSAyMGJhODYzMjdjN2M2Nzc0OWIwMjdjZWFjY2YzMmI3ZDU5ZmUzNDAxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgWWFuZyA8UGhpbGlwLllhbmdAYW1kLmNvbT4KRGF0
ZTogVGh1LCAxMiBOb3YgMjAyNiAxNzo1MzozNiAtMDUwMApTdWJqZWN0OiBbUEFUQ0ggMS8yXSBk
cm0vYW1ka2ZkOiBTaW1wbGlmeSBzdm1fbWlncmF0ZV9jb3B5X3RvX3ZyYW0oKQoKVGhlIFRIUCBh
bmQgdGhlIHNpbmdsZSBwYWdlIHBhdGhzIHdlcmUgd3JpdHRlbiBhcyB0d28gc2VwYXJhdGUgZmxv
d3MKdXNpbmcgZml2ZSBzaW5nbGUgbGV0dGVyIGxvb3AgdmFyaWFibGVzLCB3aXRoIHRoZSBzYW1l
ICJjb3B5IHdoYXRldmVyCmhhcyBiZWVuIGFjY3VtdWxhdGVkIHNvIGZhciIgYmxvY2sgb3BlbiBj
b2RlZCBmb3VyIHRpbWVzLgoKRm9sZCB0aGVtIGludG8gb25lIGZsb3c6CgogLSBhZGQgc3ZtX21p
Z3JhdGVfZmx1c2hfYmF0Y2goKSBmb3IgdGhlIGFjY3VtdWxhdGVkIGNvcHksIGl0IGlzIGEgbm8t
b3AKICAgd2hlbiBub3RoaW5nIGlzIHBlbmRpbmcgc28gdGhlIGNhbGxlcnMgbm8gbG9uZ2VyIG5l
ZWQgdG8gZ3VhcmQgaXQuCiAgIHN2bV9taWdyYXRlX2NvcHlfbWVtb3J5X2dhcnQoKSBpcyBub3cg
Y2FsbGVkIGZyb20gdGhlcmUgb25seS4KIC0gcmVuYW1lIHRoZSBsb29wIHZhcmlhYmxlcyB0byBp
LCBiYXRjaCBhbmQgb2ZmLCBhbmQgZGVyaXZlIHRoZSBzdGVwIG5yCiAgIGZyb20gb3JkZXIgc28g
dGhhdCBvcmRlciBjYW4gYmUgcGFzc2VkIHRvIHN2bV9taWdyYXRlX2dldF92cmFtX3BhZ2UoKQog
ICBkaXJlY3RseS4KIC0gY2xhaW0gdGhlIGRlc3RpbmF0aW9uIGluIGEgc2luZ2xlIGJyYW5jaCwg
dGhlIHRhaWwgbG9vcHMgYXJlIG5vLW9wcwogICBmb3IgYW4gb3JkZXIgMCBwYWdlLgogLSBtYXAg
dGhlIHNvdXJjZSB3aXRoIG9uZSBkbWFfbWFwX3BhZ2UoKSBvZiBuciBwYWdlcy4KCkEgVEhQIGlz
IHN0aWxsIGNvcGllZCBvbiBpdHMgb3duIGJlY2F1c2Ugb25seSBpdHMgaGVhZCBmaWxscyBkc3Rb
XSwgc28KaXQgY2Fubm90IHNoYXJlIGEgdHJhbnNmZXIgd2l0aCB0aGUgYWNjdW11bGF0ZWQgcGFn
ZXMuCgpUaGlzIGFsc28gZml4ZXMgYSBwYWdlIHRoYXQgaXMgbGVmdCBpbiBzeXN0ZW0gbWVtb3J5
IGJlY2F1c2UgaXRzIHJldXNlZApzdm1fYm8gZGVzdGluYXRpb24gcGFnZSBpcyBzdGlsbCByZWZl
cmVuY2VkIGJ5IGEgQ1BVIGZhdWx0LiBUaGUgb2xkIGNvZGUKc2lnbmFsbGVkIHRoZSBza2lwIGJ5
IGNsZWFyaW5nIHNwYWdlLCBidXQgdGhlIHNpbmdsZSBwYWdlIHBhdGgKcmVjb21wdXRlZCBzcGFn
ZSByaWdodCBhZnRlciBhbmQgdGhlIHBhZ2Ugd2FzIGRtYSBtYXBwZWQgYW5kIGNvcGllZCB3aXRo
CmRzdFtpXSA9PSAwLiBBIHNvdXJjZSBwYWdlIHdpdGhvdXQgTUlHUkFURV9QRk5fTUlHUkFURSB0
b29rIHRoZSBzYW1lCnBhdGguIHNwYWdlIGlzIG5vdyBjb21wdXRlZCBvbmNlIGFuZCBldmVyeSBy
ZWplY3Rpb24gY2xlYXJzIGl0IGZvciBnb29kLgoKTm8gZnVuY3Rpb25hbCBjaGFuZ2Ugb3RoZXJ3
aXNlLgoKU2lnbmVkLW9mZi1ieTogUGhpbGlwIFlhbmcgPFBoaWxpcC5ZYW5nQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYyB8IDI0MiArKysrKysr
KystLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDk4IGluc2VydGlvbnMoKyksIDE0NCBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
bWlncmF0ZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYwppbmRl
eCA2OTA1OTlkZWExNWQuLmIyZmU0MGJjNzUxMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfbWlncmF0ZS5jCkBAIC0zMTIsNiArMzEyLDIyIEBAIHN0YXRpYyB1bnNpZ25lZCBsb25n
IHN2bV9taWdyYXRlX3N1Y2Nlc3NmdWxfcGFnZXMoc3RydWN0IG1pZ3JhdGVfdm1hICptaWdyYXRl
KQogCXJldHVybiBtcGFnZXM7CiB9CiAKKy8qIENvcHkgdGhlIHBhZ2VzIGFjY3VtdWxhdGVkIGlu
IFtpIC0gKmJhdGNoLCBpKSBhbmQgcmVzZXQgdGhlIGFjY3VtdWxhdG9yLiAqLworc3RhdGljIGlu
dAorc3ZtX21pZ3JhdGVfZmx1c2hfYmF0Y2goc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGRt
YV9hZGRyX3QgKnNyYywgdTY0ICpkc3QsCisJCQl1NjQgaSwgdTY0ICpiYXRjaCwgc3RydWN0IGRt
YV9mZW5jZSAqKm1mZW5jZSkKK3sKKwlpbnQgcjsKKworCWlmICghKmJhdGNoKQorCQlyZXR1cm4g
MDsKKworCXIgPSBzdm1fbWlncmF0ZV9jb3B5X21lbW9yeV9nYXJ0KGFkZXYsIHNyYyArIGkgLSAq
YmF0Y2gsIGRzdCArIGkgLSAqYmF0Y2gsCisJCQkJCSAqYmF0Y2gsIEZST01fUkFNX1RPX1ZSQU0s
IG1mZW5jZSk7CisJKmJhdGNoID0gMDsKKwlyZXR1cm4gcjsKK30KKwogc3RhdGljIGludAogc3Zt
X21pZ3JhdGVfY29weV90b192cmFtKHN0cnVjdCBrZmRfbm9kZSAqbm9kZSwgc3RydWN0IHN2bV9y
YW5nZSAqcHJhbmdlLAogCQkJIHN0cnVjdCBtaWdyYXRlX3ZtYSAqbWlncmF0ZSwgc3RydWN0IGRt
YV9mZW5jZSAqKm1mZW5jZSwKQEAgLTMyNCw3ICszNDAsNyBAQCBzdm1fbWlncmF0ZV9jb3B5X3Rv
X3ZyYW0oc3RydWN0IGtmZF9ub2RlICpub2RlLCBzdHJ1Y3Qgc3ZtX3JhbmdlICpwcmFuZ2UsCiAJ
dTY0IG1wYWdlcyA9IDA7CiAJZG1hX2FkZHJfdCAqc3JjOwogCXU2NCAqZHN0OwotCXU2NCBpLCBq
LCBrLCBsLCBtOworCXU2NCBpLCBiYXRjaCwgb2ZmOwogCWludCByID0gMDsKIAogCXByX2RlYnVn
KCJzdm1zIDB4JXAgWzB4JWx4IDB4JWx4IDB4JWxseF1cbiIsIHByYW5nZS0+c3ZtcywgcHJhbmdl
LT5zdGFydCwKQEAgLTMzNSwxNjggKzM1MSwxMDYgQEAgc3ZtX21pZ3JhdGVfY29weV90b192cmFt
KHN0cnVjdCBrZmRfbm9kZSAqbm9kZSwgc3RydWN0IHN2bV9yYW5nZSAqcHJhbmdlLAogCiAJYW1k
Z3B1X3Jlc19maXJzdChwcmFuZ2UtPnR0bV9yZXMsIHR0bV9yZXNfb2Zmc2V0LAogCQkJIG5wYWdl
cyA8PCBQQUdFX1NISUZULCAmY3Vyc29yKTsKLQlmb3IgKGkgPSBqID0gbSA9IDA7IChpIDwgbnBh
Z2VzKSAmJiAobXBhZ2VzIDwgbWlncmF0ZS0+Y3BhZ2VzKTspIHsKLQkJc3RydWN0IHBhZ2UgKnNw
YWdlID0gbWlncmF0ZV9wZm5fdG9fcGFnZShtaWdyYXRlLT5zcmNbaV0pOwotCQl1bnNpZ25lZCBs
b25nIGN1cl9kc3RfcGZuOwotCi0JCWN1cl9kc3RfcGZuID0gc3ZtX21pZ3JhdGVfYWRkcl90b19w
Zm4oYWRldiwKLQkJCQkJCSAgICAgIGN1cnNvci5zdGFydCArIChtIDw8IFBBR0VfU0hJRlQpKTsK
LQotCQkvKiB3aGVuIG1pZ3JhdGUtPnNyY1tpXSBoYXMgTUlHUkFURV9QRk5fQ09NUE9VTkQgc2V0
IHRoZSBzcmMgcGFnZQotCQkgKiBpcyBjb21wb3VuZCBUSFA7IGl0cyB2bSBhZGRyZXNzIGlzIEhQ
QUdFX1BNRF9TSVpFIGFsaWduZWQgYW5kCi0JCSAqIGl0cyBNSUdSQVRFX1BGTl9NSUdSQVRFIGlz
IHNldAotCQkqLwotCQlpZiAoKG0gKyBIUEFHRV9QTURfTlIpIDw9IChjdXJzb3Iuc2l6ZSA+PiBQ
QUdFX1NISUZUKSAmJgotCQkgICAgKGkgKyBIUEFHRV9QTURfTlIpIDw9IG5wYWdlcyAmJgotCQkg
ICAgKG1pZ3JhdGUtPnNyY1tpXSAmIE1JR1JBVEVfUEZOX0NPTVBPVU5EKSAmJgotCQkgICAgSVNf
QUxJR05FRChjdXJfZHN0X3BmbiwgSFBBR0VfUE1EX05SKSkKLQkJCWsgPSBIUEFHRV9QTURfTlI7
Ci0JCWVsc2UKLQkJCWsgPSAxOwotCi0JCS8qIGZvciBUSFAgc3JjWzBdIGFsd2FzIE1JR1JBVEVf
UEZOX01JR1JBVEUKLQkJICoganVzdCB0aGUgZmlyc3QgbWlncmF0ZS0+ZHN0IG5lZWQgYmUgc2V0
dXAsIG90aGVycyBhcmUgemVybwotCQkgKi8KLQkJaWYgKGsgPiAxKSB7Ci0JCQlkc3RbaV0gPSBj
dXJzb3Iuc3RhcnQgKyAobSA8PCBQQUdFX1NISUZUKTsKLQkJCXN2bV9taWdyYXRlX2dldF92cmFt
X3BhZ2UocHJhbmdlLCBjdXJfZHN0X3BmbiwKLQkJCQkJCSAgSFBBR0VfUE1EX09SREVSKTsKIAot
CQkJbWlncmF0ZS0+ZHN0W2ldID0gbWlncmF0ZV9wZm4oY3VyX2RzdF9wZm4pOwotCQkJbWlncmF0
ZS0+ZHN0W2ldIHw9IE1JR1JBVEVfUEZOX0NPTVBPVU5EOworCWZvciAoaSA9IGJhdGNoID0gb2Zm
ID0gMDsgaSA8IG5wYWdlcyAmJiBtcGFnZXMgPCBtaWdyYXRlLT5jcGFnZXM7KSB7CisJCXN0cnVj
dCBwYWdlICpzcGFnZSA9IG1pZ3JhdGVfcGZuX3RvX3BhZ2UobWlncmF0ZS0+c3JjW2ldKTsKKwkJ
dTY0IHZyYW1fYWRkciA9IGN1cnNvci5zdGFydCArIChvZmYgPDwgUEFHRV9TSElGVCk7CisJCXVu
c2lnbmVkIGxvbmcgZHN0X3BmbjsKKwkJdW5zaWduZWQgaW50IG9yZGVyID0gMDsKKwkJdTY0IG5y
LCBuOwogCi0JCQlmb3IgKGwgPSAxOyBsIDwgazsgbCsrKQotCQkJCW1pZ3JhdGUtPmRzdFtpK2xd
ID0gMDsKKwkJZHN0X3BmbiA9IHN2bV9taWdyYXRlX2FkZHJfdG9fcGZuKGFkZXYsIHZyYW1fYWRk
cik7CiAKKwkJLyogTUlHUkFURV9QRk5fQ09NUE9VTkQgbWVhbnMgdGhlIHNvdXJjZSBpcyBhIFRI
UCwgaXRzIFZBIGlzCisJCSAqIEhQQUdFX1BNRF9TSVpFIGFsaWduZWQgYW5kIE1JR1JBVEVfUEZO
X01JR1JBVEUgaXMgc2V0LgorCQkgKi8KKwkJaWYgKChtaWdyYXRlLT5zcmNbaV0gJiBNSUdSQVRF
X1BGTl9DT01QT1VORCkgJiYKKwkJICAgIG9mZiArIEhQQUdFX1BNRF9OUiA8PSAoY3Vyc29yLnNp
emUgPj4gUEFHRV9TSElGVCkgJiYKKwkJICAgIGkgKyBIUEFHRV9QTURfTlIgPD0gbnBhZ2VzICYm
CisJCSAgICBJU19BTElHTkVEKGRzdF9wZm4sIEhQQUdFX1BNRF9OUikpCisJCQlvcmRlciA9IEhQ
QUdFX1BNRF9PUkRFUjsKKwkJbnIgPSAxVUxMIDw8IG9yZGVyOworCisJCWlmIChzcGFnZSAmJiBp
c196b25lX2RldmljZV9wYWdlKHNwYWdlKSkKKwkJCXNwYWdlID0gTlVMTDsKKworCQkvKiBDbGFp
bSB0aGUgZGVzdGluYXRpb24sIHVubGVzcyB0aGUgc291cmNlIGNhbm5vdCBtaWdyYXRlIG9yIGEK
KwkJICogcmV1c2VkIHN2bV9ibyBwYWdlIGlzIHN0aWxsIGhlbGQgYnkgYSBDUFUgZmF1bHQ6IHJl
aW5pdGlhbGl6aW5nCisJCSAqIGl0IHdvdWxkIGZyZWUgaXQgdW5kZXIgdGhpcyBtaWdyYXRpb24u
CisJCSAqLworCQlpZiAoIShtaWdyYXRlLT5zcmNbaV0gJiBNSUdSQVRFX1BGTl9NSUdSQVRFKSB8
fAorCQkgICAgKCFvcmRlciAmJiBwYWdlX3JlZl9jb3VudChwZm5fdG9fcGFnZShkc3RfcGZuKSkp
KSB7CisJCQlkc3RbaV0gPSAwOworCQkJbWlncmF0ZS0+ZHN0W2ldID0gMDsKKwkJCXNwYWdlID0g
TlVMTDsKKwkJfSBlbHNlIHsKKwkJCS8qIEEgVEhQIG9ubHkgZmlsbHMgdGhlIGhlYWQgZW50cnks
IHRoZSB0YWlscyBzdGF5IHplcm8uICovCisJCQlkc3RbaV0gPSB2cmFtX2FkZHI7CisJCQlzdm1f
bWlncmF0ZV9nZXRfdnJhbV9wYWdlKHByYW5nZSwgZHN0X3Bmbiwgb3JkZXIpOworCQkJbWlncmF0
ZS0+ZHN0W2ldID0gbWlncmF0ZV9wZm4oZHN0X3BmbikgfAorCQkJCQkgIChvcmRlciA/IE1JR1JB
VEVfUEZOX0NPTVBPVU5EIDogMCk7CisJCQlmb3IgKG4gPSAxOyBuIDwgbnI7IG4rKykKKwkJCQlt
aWdyYXRlLT5kc3RbaSArIG5dID0gMDsKIAkJCW1wYWdlcysrOwotCQl9IGVsc2UgaWYgKG1pZ3Jh
dGUtPnNyY1tpXSAmIE1JR1JBVEVfUEZOX01JR1JBVEUpIHsKLQkJCWRzdFtpXSA9IGN1cnNvci5z
dGFydCArIChtIDw8IFBBR0VfU0hJRlQpOwotCQkJLyoKLQkJCSAqIEEgcmV1c2VkIHN2bV9ibyBw
YWdlIG1heSBzdGlsbCBiZSBoZWxkIGJ5IGEgQ1BVIGZhdWx0LgotCQkJICogUmVpbml0aWFsaXpp
bmcgaXQgd291bGQgZnJlZSBpdCB1bmRlciB0aGlzIG1pZ3JhdGlvbiwKLQkJCSAqIHNvIGxlYXZl
IHRoaXMgcGFnZSBpbiBzeXN0ZW0gbWVtb3J5LgotCQkJICovCi0JCQlpZiAocGFnZV9yZWZfY291
bnQocGZuX3RvX3BhZ2UoY3VyX2RzdF9wZm4pKSkgewotCQkJCWRzdFtpXSA9IDA7Ci0JCQkJbWln
cmF0ZS0+ZHN0W2ldID0gMDsKLQkJCQlzcGFnZSA9IE5VTEw7Ci0JCQl9IGVsc2UgewotCQkJCXN2
bV9taWdyYXRlX2dldF92cmFtX3BhZ2UocHJhbmdlLCBjdXJfZHN0X3BmbiwgMCk7Ci0JCQkJbWln
cmF0ZS0+ZHN0W2ldID0gbWlncmF0ZV9wZm4oY3VyX2RzdF9wZm4pOwotCQkJCW1wYWdlcysrOwot
CQkJfQogCQl9CiAKLQkJaWYgKGsgPiAxKSB7Ci0JCQlpZiAoaikgewotCQkJCS8qIG1pZ3JhdGUg
cHJldmlvdXMgYWNjdW11bGF0ZWQgcGFnZXMgKi8KLQkJCQlyID0gc3ZtX21pZ3JhdGVfY29weV9t
ZW1vcnlfZ2FydCgKLQkJCQkJCWFkZXYsIHNyYyArIGkgLSBqLAotCQkJCQkJZHN0ICsgaSAtIGos
IGosCi0JCQkJCQlGUk9NX1JBTV9UT19WUkFNLAotCQkJCQkJbWZlbmNlKTsKLQotCQkJCWlmIChy
KQotCQkJCQlnb3RvIG91dF9mcmVlX3ZyYW1fcGFnZXM7CisJCS8qIEEgVEhQIGlzIGNvcGllZCBv
biBpdHMgb3duLCBzbyBkcmFpbiB3aGF0ZXZlciBwcmVjZWRlZCBpdC4gKi8KKwkJaWYgKG9yZGVy
IHx8ICFzcGFnZSkgeworCQkJciA9IHN2bV9taWdyYXRlX2ZsdXNoX2JhdGNoKGFkZXYsIHNyYywg
ZHN0LCBpLCAmYmF0Y2gsIG1mZW5jZSk7CisJCQlpZiAocikKKwkJCQlnb3RvIG91dF9mcmVlX3Zy
YW1fcGFnZXM7CisJCX0KIAotCQkJCWogPSAwOworCQlpZiAoc3BhZ2UpIHsKKwkJCXNyY1tpXSA9
IGRtYV9tYXBfcGFnZShkZXYsIHNwYWdlLCAwLCBuciA8PCBQQUdFX1NISUZULAorCQkJCQkgICAg
ICBETUFfQklESVJFQ1RJT05BTCk7CisJCQlyID0gZG1hX21hcHBpbmdfZXJyb3IoZGV2LCBzcmNb
aV0pOworCQkJaWYgKHIpIHsKKwkJCQlkZXZfZXJyKGRldiwgIiVzOiBmYWlsICVkIGRtYV9tYXBf
cGFnZVxuIiwgX19mdW5jX18sIHIpOworCQkJCWdvdG8gb3V0X2ZyZWVfdnJhbV9wYWdlczsKIAkJ
CX0KIAotCQkJLyogZm9yIFRIUCBjaGVjayBpZiB0aGUgZmlyc3Qgc3JjIHBhZ2UgaXMgdmFsaWQK
LQkJCSAqIGlmIG5vdCB2YWxpZCBza2lwIGZvbGxvd2luZyBIUEFHRV9QTURfTlIgLSAxIHBhZ2Vz
CisJCQkvKiBUaGUgc291cmNlIHBhZ2VzIGFyZSBjb250aWd1b3VzLCBzbyBhcmUgdGhlaXIgZG1h
CisJCQkgKiBhZGRyZXNzZXMuCiAJCQkgKi8KLQkJCXNwYWdlID0gbWlncmF0ZV9wZm5fdG9fcGFn
ZShtaWdyYXRlLT5zcmNbaV0pOwotCQkJaWYgKHNwYWdlICYmICFpc196b25lX2RldmljZV9wYWdl
KHNwYWdlKSkgewotCQkJCS8qIGRtYV9tYXAgY29udGludW91cyBIUEFHRV9QTURfTlIgc3lzIHJh
bSBwYWdlcyAqLwotCQkJCXNyY1tpXSA9IGRtYV9tYXBfcGFnZShkZXYsIHNwYWdlLCAwLCBQQUdF
X1NJWkUqSFBBR0VfUE1EX05SLAotCQkJCQkJICAgICAgRE1BX0JJRElSRUNUSU9OQUwpOwotCi0J
CQkJciA9IGRtYV9tYXBwaW5nX2Vycm9yKGRldiwgc3JjW2ldKTsKLQkJCQlpZiAocikgewotCQkJ
CQlkZXZfZXJyKGRldiwgIiVzOiBmYWlsICVkIGRtYV9tYXBfcGFnZVxuIiwKLQkJCQkJCQlfX2Z1
bmNfXywgcik7Ci0JCQkJCWdvdG8gb3V0X2ZyZWVfdnJhbV9wYWdlczsKLQkJCQl9Ci0KLQkJCQkv
KiBnZXQgZG1hIGFkZHJlc3MgZm9yIGZvbGxvd2luZyBIUEFHRV9QTURfTlItMSBwYWdlcwotCQkJ
CSAqIHNpbmNlIHNyYyBwYWdlcyBhcmUgY29udGludW91cyB0aGVpciBkbWEgYWRkcmVzc2VzCi0J
CQkJICogYXJlIGNvbnRpbnVvdXMgdG9vLgotCQkJCSAqLwotCQkJCWZvciAobCA9IDE7IGwgPCBr
OyBsKyspCi0JCQkJCXNyY1tpICsgbF0gPSBzcmNbaV0gKyBsKlBBR0VfU0laRTsKLQotCQkJCS8q
IG1pZ3JhdGUgdGhlIEhQQUdFX1BNRF9OUiBwYWdlcyBhYm92ZSAqLwotCQkJCXIgPSBzdm1fbWln
cmF0ZV9jb3B5X21lbW9yeV9nYXJ0KAotCQkJCQkJYWRldiwgc3JjICsgaSwKLQkJCQkJCWRzdCAr
IGksIEhQQUdFX1BNRF9OUiwKLQkJCQkJCUZST01fUkFNX1RPX1ZSQU0sCi0JCQkJCQltZmVuY2Up
OwotCi0JCQkJLyogbWFyayBoZWFkIHBhZ2UgZG1hIG1hcHBpbmcgYXMgVEhQLCB0YWlsIHBhZ2Vz
IGRtYSBhZGRyCi0JCQkJICogYXJlIHNldCB0byAwIGZvciBmb2xsb3dpbmcgZG1hX3VubWFwCi0J
CQkJICovCi0JCQkJc3JjW2ldIHw9IFNWTV9SQU5HRV9ETUFfVEhQOwotCQkJCWZvciAobCA9IDE7
IGwgPCBrOyBsKyspCi0JCQkJCXNyY1tpICsgbF0gPSAwOwotCi0JCQkJaWYgKHIpCi0JCQkJCWdv
dG8gb3V0X2ZyZWVfdnJhbV9wYWdlczsKLQotCQkJCWogPSAwOwotCQkJfQotCQl9IGVsc2Ugewot
Ci0JCQkvKiBzaW5nbGUgbm9ybWFsIHBhZ2UgY2FzZSAqLwotCQkJc3BhZ2UgPSBtaWdyYXRlX3Bm
bl90b19wYWdlKG1pZ3JhdGUtPnNyY1tpXSk7Ci0JCQlpZiAoc3BhZ2UgJiYgIWlzX3pvbmVfZGV2
aWNlX3BhZ2Uoc3BhZ2UpKSB7Ci0JCQkJc3JjW2ldID0gZG1hX21hcF9wYWdlKGRldiwgc3BhZ2Us
IDAsIFBBR0VfU0laRSwKLQkJCQkJICAgICAgRE1BX0JJRElSRUNUSU9OQUwpOworCQkJZm9yIChu
ID0gMTsgbiA8IG5yOyBuKyspCisJCQkJc3JjW2kgKyBuXSA9IHNyY1tpXSArIChuIDw8IFBBR0Vf
U0hJRlQpOworCQkJYmF0Y2ggKz0gbnI7CisJCX0KIAotCQkJCXIgPSBkbWFfbWFwcGluZ19lcnJv
cihkZXYsIHNyY1tpXSk7CisJCWlmIChvcmRlciAmJiBzcGFnZSkgeworCQkJciA9IHN2bV9taWdy
YXRlX2ZsdXNoX2JhdGNoKGFkZXYsIHNyYywgZHN0LCBpICsgbnIsICZiYXRjaCwKKwkJCQkJCSAg
ICBtZmVuY2UpOwogCi0JCQkJaWYgKHIpIHsKLQkJCQkJZGV2X2VycihkZXYsICIlczogZmFpbCAl
ZCBkbWFfbWFwX3BhZ2VcbiIsCi0JCQkJCQkJX19mdW5jX18sIHIpOwotCQkJCQlnb3RvIG91dF9m
cmVlX3ZyYW1fcGFnZXM7Ci0JCQkJfQotCQkJCWogKz0gMTsKKwkJCS8qIE1hcmsgdGhlIGhlYWQg
c28gc3ZtX3JhbmdlX2RtYV91bm1hcCgpIHVubWFwcyB0aGUgd2hvbGUKKwkJCSAqIFRIUCwgYW5k
IGNsZWFyIHRoZSB0YWlscy4KKwkJCSAqLworCQkJc3JjW2ldIHw9IFNWTV9SQU5HRV9ETUFfVEhQ
OworCQkJZm9yIChuID0gMTsgbiA8IG5yOyBuKyspCisJCQkJc3JjW2kgKyBuXSA9IDA7CiAKLQkJ
CX0gZWxzZSBpZiAoaikgewotCQkJCXIgPSBzdm1fbWlncmF0ZV9jb3B5X21lbW9yeV9nYXJ0KAot
CQkJCQkJYWRldiwgc3JjICsgaSAtIGosCi0JCQkJCQlkc3QgKyBpIC0gaiwgaiwKLQkJCQkJCUZS
T01fUkFNX1RPX1ZSQU0sCi0JCQkJCQltZmVuY2UpOwotCQkJCWlmIChyKQotCQkJCQlnb3RvIG91
dF9mcmVlX3ZyYW1fcGFnZXM7Ci0JCQkJaiA9IDA7Ci0JCQl9CisJCQlpZiAocikKKwkJCQlnb3Rv
IG91dF9mcmVlX3ZyYW1fcGFnZXM7CiAJCX0KIAotCQlwcl9kZWJ1Z19yYXRlbGltaXRlZCgiZG1h
IG1hcHBpbmcgJWxsZCBwYWdlcywgc3JjIHRvIDB4JWxseCwgcGZuIDB4JWx4XG4iLAotCQkJCSAg
ICAgaywgc3JjW2ldID4+IFBBR0VfU0hJRlQsIG1pZ3JhdGUtPnNyY1tpXSA+PiBNSUdSQVRFX1BG
Tl9TSElGVCk7CisJCXByX2RlYnVnX3JhdGVsaW1pdGVkKCJkbWEgbWFwcGluZyAlbGx1IHBhZ2Vz
LCBzcmMgdG8gMHglbGx4LCBwZm4gMHglbHhcbiIsCisJCQkJICAgICBuciwgc3JjW2ldID4+IFBB
R0VfU0hJRlQsCisJCQkJICAgICBtaWdyYXRlLT5zcmNbaV0gPj4gTUlHUkFURV9QRk5fU0hJRlQp
OwogCi0JCWkgKz0gazsKLQkJbSArPSBrOworCQlpICs9IG5yOworCQlvZmYgKz0gbnI7CiAKLQkJ
aWYgKG0gPj0gKGN1cnNvci5zaXplID4+IFBBR0VfU0hJRlQpKSB7Ci0JCQlpZiAoaiA+IDApIHsK
LQkJCQlyID0gc3ZtX21pZ3JhdGVfY29weV9tZW1vcnlfZ2FydChhZGV2LCBzcmMgKyBpIC0gaiwK
LQkJCQkJCQkJIGRzdCArIGkgLSBqLCBqLAotCQkJCQkJCQkgRlJPTV9SQU1fVE9fVlJBTSwKLQkJ
CQkJCQkJIG1mZW5jZSk7Ci0JCQkJaWYgKHIpCi0JCQkJCWdvdG8gb3V0X2ZyZWVfdnJhbV9wYWdl
czsKLQkJCX0KKwkJaWYgKG9mZiA+PSAoY3Vyc29yLnNpemUgPj4gUEFHRV9TSElGVCkpIHsKKwkJ
CXIgPSBzdm1fbWlncmF0ZV9mbHVzaF9iYXRjaChhZGV2LCBzcmMsIGRzdCwgaSwgJmJhdGNoLCBt
ZmVuY2UpOworCQkJaWYgKHIpCisJCQkJZ290byBvdXRfZnJlZV92cmFtX3BhZ2VzOwogCi0JCQlh
bWRncHVfcmVzX25leHQoJmN1cnNvciwgbSpQQUdFX1NJWkUpOwotCQkJbSA9IDA7CisJCQlhbWRn
cHVfcmVzX25leHQoJmN1cnNvciwgb2ZmIDw8IFBBR0VfU0hJRlQpOworCQkJb2ZmID0gMDsKIAkJ
fQogCX0KIAotCWlmIChqID4gMCkKLQkJciA9IHN2bV9taWdyYXRlX2NvcHlfbWVtb3J5X2dhcnQo
YWRldiwgc3JjICsgaSAtIGosIGRzdCArIGkgLSBqLCBqLAotCQkJCQkgRlJPTV9SQU1fVE9fVlJB
TSwgbWZlbmNlKTsKKwlyID0gc3ZtX21pZ3JhdGVfZmx1c2hfYmF0Y2goYWRldiwgc3JjLCBkc3Qs
IGksICZiYXRjaCwgbWZlbmNlKTsKIAogb3V0X2ZyZWVfdnJhbV9wYWdlczoKIAlpZiAocikgewpA
QCAtNTExLDggKzQ2NSw4IEBAIHN2bV9taWdyYXRlX2NvcHlfdG9fdnJhbShzdHJ1Y3Qga2ZkX25v
ZGUgKm5vZGUsIHN0cnVjdCBzdm1fcmFuZ2UgKnByYW5nZSwKIAl9CiAKICNpZmRlZiBERUJVR19G
T1JDRV9NSVhFRF9ET01BSU5TCi0JZm9yIChpID0gMCwgaiA9IDA7IGkgPCBucGFnZXM7IGkgKz0g
NCwgaisrKSB7Ci0JCWlmIChqICYgMSkKKwlmb3IgKGkgPSAwLCBvZmYgPSAwOyBpIDwgbnBhZ2Vz
OyBpICs9IDQsIG9mZisrKSB7CisJCWlmIChvZmYgJiAxKQogCQkJY29udGludWU7CiAJCXN2bV9t
aWdyYXRlX3B1dF92cmFtX3BhZ2UoYWRldiwgZHN0W2ldKTsKIAkJbWlncmF0ZS0+ZHN0W2ldID0g
MDsKLS0gCjIuNTAuMQoK

--------------Nx4ALlExu7T307bC5j22FBWO--
