Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CC3C5DF7D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 752CF10E85B;
	Tue, 18 Aug 2026 20:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RhTfwQSO";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00C8A10ECD4
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vamz1CqjLDrnGSLTtB5BOOXp2KGb1xU3RgWjsMvktr4k6h9gR6RK/C/KBLOQy6PaDpIeISQLNfz2e6jiliPgygwZMlOnEbO8KNgmKEaZiByX6I+/q/yEmvmEpRpIRBbEL1/3a4gGtA5e5Ktlw3Dbgb3cDNBaxBgMdwe5FOalqYxdxZ51ERIz7FjGfwZwiYyCTJlbQgYNRqNZIt2ngn7ymx6SWfwPk+o0gb8hNksFgR5Pie6cLd5PZJYUlkx6RgjKXQEwYE/vGquCj4s1iHU4AULRo2cTTBypBFXV2edn2sZAHFpQaEx7u4bySw6ORQlU0Co37ylSB/kxWpaQwOto1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVpDww/wGPzpJOPeFG6q+6ASg1+Zql6V0zodv/jgi6Q=;
 b=usOUenCR1VdizyxSIe7uozDBfh2unmM/GZabpLqj09G9U5Wyzhyd0k43ZBgOTVisgd7kH88JVoViIwtSig0u0GGrZQmGmk78oaVQh3/acPTLqkQWNOC8F+J2uCdc5OhEHlmV/Py8vZcgyA7tL/u68Ky485yJ92Nl05luk0V7xlhyGb0SDFnntLmOamllFInPaKNfqN3tApNZktOun4EwmxgUJcp5GXU5lFlHrhvmj383pdcep3wOZkfWZmSs2G9yXCjxrvK6ibbI1GloEvclggBzYYWYo4nPDXKMr/z3dnmMz/N5qyPT2nPY1jw5h9/3LCtq4EPcOdoAhYcL9odZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVpDww/wGPzpJOPeFG6q+6ASg1+Zql6V0zodv/jgi6Q=;
 b=RhTfwQSOfV2Xyu/2K1pQ0GI0PYz782oLVmAZAJbpb6bpQ6c7azSrJFHajyxLSv7ZsfszA5sZVczL7tb+nxSY3TRLgEbUukYxgd+l1Yr4MWjEuMb/uiZl8BNRZOA7wTV3+hCceZfrpI+dLjpVxj8rYnDezcaxCIUxd2H2Ti+krIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by SJ2PR12MB9007.namprd12.prod.outlook.com
 (2603:10b6:a03:541::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:50:22 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852%8]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 20:50:22 +0000
Message-ID: <81e1603b-01a9-4f2d-a4e2-21b15e1d90b9@amd.com>
Date: Tue, 18 Aug 2026 16:50:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdkfd: Fix the case that vm range is hole at
 svm_migrate_copy_to_vram
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260817135918.228397-1-xiaogang.chen@amd.com>
 <20260817135918.228397-2-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260817135918.228397-2-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::28) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|SJ2PR12MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: 00acad13-c222-4e50-09b8-08defd6a5289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: zwWK4Njm3tIe5+WPOxpWxipljty5mUrJsW2yuaR1oAPaGaP6ccVp6E8Tsu5Hbg9ILxt3bz7mSIbvewDdG0ZEehMuz8JulI77FYN/e/b+9z3seO5Deo+Vawa81TehXeUAZAco0PS9rHRTSSfK82ORqeST8W0zm5cYorO8VNgC/tWV3xwgkR4lpr/zH2xrqmK9qt/SQ4h4LVfzJzq48JooOucnEfFbMNQMFimDboVQMOLIKqpPUTAWkbjwMZSpn46FH8mgF4gEelyI4zcTdLw9Yh8YLeGSZ7JeFcqGgpjGmhutvJCfy4IBfU5kUWpbZ1r/gs+IRiHwlbmRh0C7Id33QqoqE2tJTPERmmbscZXDXYfysWm9fAwFFvjeJjGR7e6eW3yLAh4oszL2wrZnD2r1tFdk7Fu1BWRqPgUttNUMIp2MwkSF6GtSjdE+8Ws7coSmgtn8zn4bQob8zVT+XfvgsSq6xWT2DRXCKgwyP0tj8/U/okKNFmKj1JG/qnMV39oNU8BTSDwH6jGSpyGoyDSrJlqzNA9L3wDUQP47Gs4sE8VP+uQfQjbk08CIeX7OjiQsGQoA/cYHyClIy7XbXgXEHWcCV27P0oFoDQFnNtCzGoYMLOM8uYOn9Oup2rWCJDUj+Osc16s/wyyN7S84l6Sbdq9J3uIGqxeSL/oEkdNSZ78=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STZwMldHT2F2bWRGaE13Y3EwYWFWMUxpMFpvbVpJcnBTWno1a25YSlpTd0JT?=
 =?utf-8?B?V2RoalV5Y21paFcyM1V3WjhYak1iNUNHUFYwQjFMTElvTmV4OGc2aEt5bkRZ?=
 =?utf-8?B?cm53K3VXRCt2ZzV0aGJpVnNzRjI2NSsxTUFrS0c1SFJYdmcrQVZ0M0hsaXVs?=
 =?utf-8?B?VDBlZzNWMy9HM3lNNk9tdkxkcWF2dVVTcVRnTXd6M1prbVNsWUF4NWQ0YWh2?=
 =?utf-8?B?Z0RGOFpCWDBGU0tXVi9yWFBkaDRBQ2dGOElRUnQrMndyUS94ek9QdERETVFB?=
 =?utf-8?B?bFN1dTdmQ2NOTmFCRTdWNGdjeiszSFlBdnl1bERTVTRBWWxVeXlPcHZpQXlY?=
 =?utf-8?B?N0RVbk9aQjhCUEt4TTRGTnJDcmsvaU9PMDNOa1ZhRUFYQWk1V0kvNDBUdU83?=
 =?utf-8?B?WEQ3U1ZnS0RSVHpST3NKNzBLSm1yYWozZkFNZUVnaWFyZmFldkZ5Mmx5MFJY?=
 =?utf-8?B?VWVUSU1BbTdmN3RUUDg0RENDY2VRR0RUN3h4QWtSM1h0enhqazh5UXhRTGRT?=
 =?utf-8?B?U0dYdy9DKy83M3hYWVVYMWg4b1QvUkZRcTV6Ukx4aGU2ai9CUWZDT1Q2NXp3?=
 =?utf-8?B?dFp5cVFLRE1oMG1zU3R2UFFKcTB0cGhDOWRTZlVsWE5wcGFGV3VRWFE4NDhs?=
 =?utf-8?B?T3NaT2J1d2h4anM3aWU4WmZpR1IwRlBicitEV210d01NUy9JRFlPcnpXS1hE?=
 =?utf-8?B?NFNEdTNlUFhxd2Z0d2pTbElLT1FEaDVTWFRybGFsQjVkRUxueEF1RGNZb2Y0?=
 =?utf-8?B?TVdQa0U4RGJRM1pyeHd6VHRLNzcrYWtmY1ZPbXZHdDRmSXBJZUVxRGNqc2Fa?=
 =?utf-8?B?MmdCeUlXbmdlMHpXYnF4aG8xNHpQcXFZcjJlS1gxTGE5UHorRFU2V2oxSEFJ?=
 =?utf-8?B?TDkrTDhxdERadVZoL3ZrRkJHcUVvRWE4bVJTU1d4aVFMRmo4ZmxiSDZWd290?=
 =?utf-8?B?MXNDNjR0L2IvUVdDTTBSem5Vc1Y1VThMSGdxYkRoS3pxWWFpdU5pd3hmdFRP?=
 =?utf-8?B?b0pyMmtteVYxaDJ1aUlTM3Q4L3paNy9zZUw4S1d6UWd1SnVqcTRZMi95VjhI?=
 =?utf-8?B?eHFiMWJxL3kxZGhSVGRESUY5Zk1ubVFWMVBRSDQ0aGhBMVY4c3RkaG44ZStJ?=
 =?utf-8?B?YitLT1RFeFFEWUpwbGlnSklENDIrVkptWStmaGpEN282YWtUMm8xZWhhZzVN?=
 =?utf-8?B?aUQ0RmJ0cXRNQUp4YkZmUGJnb2JJWEs3aWRXT3FoZzRYWmlNa0NMSTM5d1Ro?=
 =?utf-8?B?NmxOLzVsWFVkb0ZmWWFycThpNWx1U1VwdlhJdENlalJWUG5tcm5xcExvUnMv?=
 =?utf-8?B?ZEc1azh3NnYwYTlPQVZQTGE2ZzNreG1TM0Q2dTBJa1h4djZBL2p1NVZnOTZa?=
 =?utf-8?B?S1B6NGt2clFySzdWTXBDdlJFVngwU005RE9OazhFZEE2WFlnQ2pwdVdMMmVB?=
 =?utf-8?B?NmVxdElkVmJqQlZiZXIvcHM3eEI3OTdCMWV6b0UrOXE2VFZlRm1PSWF6WEtV?=
 =?utf-8?B?TkFXSFRVMVlycmIrOTJTc3h5SllVcnpRbWJ3WXYwK3hoSkpPazlNYlBncXcv?=
 =?utf-8?B?WTRzdnFWLzRaWlVFTTF3ZVFlRWRyalBaYXdLcGV1dHBRQXZhakU2bysrWVJD?=
 =?utf-8?B?M0NtM3Q0cEsxSlhhYk5kcXoyWk1vem9hUFVZTXQ1OXhnOXQ2cC9ONWR6WjNN?=
 =?utf-8?B?MHc2eVk4RnlEeDZKMTM4dFRiaEpvalVwRTU1M0JXQmRyODJobUx0Vyt3NVFU?=
 =?utf-8?B?UzZtNnJBSmMvWDFSUjlqUDJCL2x0WU5aZWVhdjJSUnVtZ0N2eE1Neng3MmFC?=
 =?utf-8?B?ckt3Ym1zOTIxSEQxOVlyemdMUXVGNUNiTDhUelJ5cXkyK2NPMm51bERQellU?=
 =?utf-8?B?RTJMOVprdDliVUlvYlFSaTJISXV2L3dKQ1E3R1FxQUl0c1h1TUptbEZHSG1P?=
 =?utf-8?B?YWw4ZGthbXEyc010TllnQTl5RGJ6amRhQUxJc2RleVFIZ1V0N2NxMWtyZ2VG?=
 =?utf-8?B?MjN4S2dXa3ZwSHl5UkJGSG4wSVJIZkJyV3cvc2E0TDZvdG9pajhrRXZsM04y?=
 =?utf-8?B?WmdGd2V2U0dNWGhGeDlOQmVXajRGS2dXejNScnlZRlhmQWdwYmhCSnNST0Rm?=
 =?utf-8?B?bVJobnl0elR0bThmWlFDSy9zR0o1NWJUOFEzY1J1Mm9UNExVNUx0OE5RbHJq?=
 =?utf-8?B?Rlk3SS82dnlGRW5DdkFIbVZ5TjE4VWJ1SFlab0V0Q01PMUNSV082eFRQMmRh?=
 =?utf-8?B?MnRNNTF4YVpNV0oxOURtZ1FiUG9DblllTzRLSWdsTDZwaExhNG9hQ1ZnRGd6?=
 =?utf-8?B?OUVtOTcwWS9SSldIUmFWbDBXTzZsd2k1SDhJRENmbWtUcmV0Yko3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00acad13-c222-4e50-09b8-08defd6a5289
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:50:22.8246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eK1bzjMzhONY8cvbw8m1fBg6aaliS/aa6RZbj2iwh7bbK1NpicxAZMZCvopveovsupzVVN8P14637mj/lmhakg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9007
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


On 2026-08-17 09:59, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> When migration vm range is hole at cpu side(MIGRATE_PFN_MIGRATE set +
> MIGRATE_PFN_VALID unset) driver still allocates device pages. There is no
> dma map of src pages and migration. j is 0 and svm_migrate_copy_memory_gart()
> will return an uninitialized r. That can trigger out_free_vram_pages to drop
> all VRAM just set up.

Good catch. The first fix I would expect here, is that 
svm_migrate_copy_memory_gart should never return an uninitialized r. I'd 
defensively initialize r in svm_migrate_copy_memory_gart as well, even 
if you never plan to call it with npages = 0. With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>
> Initialize r and only call the last svm_migrate_copy_memory_gart if j > 0.
>
> Current code postponed the last page to the final copy. This patch flushes on
> the last page when reach to the end of current drm_buddy_block; avoids another
> svm_migrate_copy_memory_gart.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index aea82da5f575..263dae49bb3e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -284,7 +284,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	dma_addr_t *src;
>   	u64 *dst;
>   	u64 i, j;
> -	int r;
> +	int r = 0;
>   
>   	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%llx]\n", prange->svms, prange->start,
>   		 prange->last, ttm_res_offset);
> @@ -310,6 +310,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   					      DMA_BIDIRECTIONAL);
>   			r = dma_mapping_error(dev, src[i]);
>   			if (r) {
> +				src[i] = 0;
>   				dev_err(dev, "%s: fail %d dma_map_page\n",
>   					__func__, r);
>   				goto out_free_vram_pages;
> @@ -334,7 +335,8 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   		pr_debug_ratelimited("dma mapping src to 0x%llx, pfn 0x%lx\n",
>   				     src[i] >> PAGE_SHIFT, page_to_pfn(spage));
>   
> -		if (j >= (cursor.size >> PAGE_SHIFT) - 1 && i < npages - 1) {
> +		/* accumulated j + 1 pages reach end of current drm_buddy_block */
> +		if (j + 1 >= (cursor.size >> PAGE_SHIFT)) {
>   			r = svm_migrate_copy_memory_gart(adev, src + i - j,
>   							 dst + i - j, j + 1,
>   							 FROM_RAM_TO_VRAM,
> @@ -348,7 +350,8 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   		}
>   	}
>   
> -	r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
> +	if (j > 0)
> +		r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
>   					 FROM_RAM_TO_VRAM, mfence);
>   
>   out_free_vram_pages:
