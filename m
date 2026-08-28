Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED907C61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 07:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D9C10F295;
	Fri, 28 Aug 2026 07:33:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vGFglRwp";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010039.outbound.protection.outlook.com
 [52.101.193.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 905E410F295
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 07:33:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2WTC03lbFuEsfmuV/sYbdtap5nTsSyUKbCiYGpVilmTxofEp65JdRTjsmQIrCefTLlLuXJsUZEQkZ0qVaS0aUyWXPVx41HcGEjRoPEWMKEsqhxyFbu2CZRgrOnDSdq3BjVBqwzk6bQpyPwn3bSd8Z8Mx0rMnqwiE7rLcAiKcz/SDgtFQMk2aPumE2joVtYVH9EIjTSKGs6SYZmRWXzotrQcL6NqYrgA0uDKmscEQ0IFGo1792GlbuaK30f6OdjVZeXYeDY58bKmtrMfOPh8NmVNFCnrML9XBf67l7Imq5WsAOB5Md6aND8UZrAGdoRc0v3ThlfZzKhwEbP8h+LZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFCrgpmnwxvE7pBJcrzOyKNGfTZRsOzJYzO24iOtgO4=;
 b=BDSMLR+M4NbJA+viM13rQ0vujibkxN4QZyNRt4qu9ekedwVXXeQ1XJYGkQ/y4o1dC/5ZCnzUKiRRFqQSgERSiltePSZttcPr3wGKEcdjDnxythnCfy7TJmgarNEWURiFuMzpRUmliArqihlwc8u/MrJiXFbNOj8Du8X8+LkqtsyZ+FaljnyMiHk7PIgtPj6bgMyDCX3aySmTKOcwVMcsoG6NpxUf/CxHxgioqY4kWwMY16wPk0vTvOGXPdqXCmu/noiyPOLRq0UjZPgPrMO12llmA1Co1uvk5X6wPr9BBVtzY+VNVgCbiQdqgTjqgJTfwFVB3z4VjV4LrIXvDGrG9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFCrgpmnwxvE7pBJcrzOyKNGfTZRsOzJYzO24iOtgO4=;
 b=vGFglRwpPOuG2eSgowfuz1VfqvnsPfs+CDYgYavzPm9M1jrQzvTWt1edWOrzBbUrEqxwMADibEqoNgHgtaQx35DTZoBEEnJ6qGi2Ib+NbEDrV/DXq54smZdo4ox0ZK58LKKUTQzlyYFk1C2McthRnT61FcCP4kGScrFF5z0S0E4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8215.namprd12.prod.outlook.com (2603:10b6:930:77::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 07:33:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Fri, 28 Aug 2026
 07:33:56 +0000
Message-ID: <210d385c-dfe3-4530-81ce-4af1c21d13c7@amd.com>
Date: Fri, 28 Aug 2026 09:33:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] drm/amdgpu: use AMDGPU_GPU_PAGE_SHIFT instead of
 PAGE_SHIFT
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260827154849.1021013-1-sunil.khatri@amd.com>
 <20260827154849.1021013-3-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260827154849.1021013-3-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: f9af54ff-e519-4db9-d858-08df04d6b7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: ZgZnaD6Jc0FElRoI5b1yb3iJtSbncv8phPQpyFzldl4VclGp7Wx7gZcr1Vgi0al4VMv3gfTreUD+z+3PE3z2TormJM0k3Dx06r//G77ZysBbgE6xcTR/SnTkaIEtq2TyJ4nn9uMBNPANSOQqwqDDqKON2S0pDAwpasrthg254N3Gpm9q9h88Dc5caD9NvHONRB+UvR6KIkWXW8RaZhKynmCIePfJKWVyBbrqhk7ANZUCOdSbuWAJ66cnWUWLkwpihd5NnwFKLwm2O5vFsrxPsfJ5n2k1mig5/iAz6tStJpRAx9IZQmfdtuMcr22Rhfwtk2bfZo++6dyCX+wsL+RJGPbNGv62D5ts3XEAuOVuYquUVgq7jNj7H8PQcNgLKHVYIDSpy3DnEXU5GNjqeg+EkGVneaE+SxkPVe2/8r6TbJnus5n2FAq3bRya256jZBrtXG2DoOiW9KvG4UQARR6zpijYmVBYguQYB2Y7rLwfCdcmwZ09NRTGgxKxW2HtL4tspgTLmWT0nMfbIWImOAPTkccVR7YST/WlUbLZRFOtaVYeY+e6DsOmUn2A1+GZtqcvFoUg21WHGSxjOzLTHJWaJt81NN82WGdKDYjeS0OJSA1rtaAUXsU71N0u0dKvE9LKMeU7RmbGiQYMl2UVasIVC22r4aEmGr05v2a1tl977Wg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Si9USU9TTHVxem1OR3BFY0Z1OGpNUU9MbS82WDd5QUpSY1Qyd1hJeGRPY1VK?=
 =?utf-8?B?Y0hlSmRtSUZ2OXJ3Z0ZqY2c1WHpHTVlLWlZaSktVMzJ1MUZwUmVIeDhnTHp4?=
 =?utf-8?B?OS9sK0lNODZta00wQVJYVCs2TE5mbVRLY2pRZVYyZ21OSFd4UzBCODlNTEM0?=
 =?utf-8?B?RWI0M3VxMThWbE5Dam80bGlTdVdHSHd2WG9kUW0reTZJQ3A3eTZYa0VRVjlJ?=
 =?utf-8?B?aEZaZ0twWURWTExneC9GQkFFM1Irb20ySExOUkFuUkx0VGtKSS81cjFSRHFS?=
 =?utf-8?B?aXB4L09NODRHYXBFVXRXeXZRNzdBRTVSUUgrZlBSUlJZeHdCSHlmTkFhTnhi?=
 =?utf-8?B?WU5BV3dkSWkyMWE0NHZiTjJpaVVtTkppazdxVEx1SkY3SW45OXp6UFRMTFFr?=
 =?utf-8?B?TU1LNk9pbEhEenlhOHZWVXc5TGNucHZwSWRneXAvaEM3Z3FCTTE0MU4yUWlp?=
 =?utf-8?B?RkhVUTNJT0hwNENyQTdaQTVKUVlaaDlpR3dsdmhUMmUyL1ZxOWZMNUp1bTdv?=
 =?utf-8?B?T1prQ29UVnNKMUFDSmdWbkx3cER5cmtVNVlUa29uQzVnYUlTLzZvUUNMMlpT?=
 =?utf-8?B?R3l6dHlaYkFOcEI3VU9RRTFXTTYxcDMxcmkybk13NFFGbVh1UVlHeHZjUjVK?=
 =?utf-8?B?WW1FY3phOVNtYkhRMUZ3SGtPOVVVazFKSU1aK2JtNmRGWW1qZ2J2OVV2TGpM?=
 =?utf-8?B?TllCUWgxMGNwd0dvOXU4eEdyQk9MeEs2Sm9HcTFpd3lva1B5RFVNaVBhSFVw?=
 =?utf-8?B?YVYvZ2ZiOWRWcFhNYTgrUDMrOXpaeGYxVHJyV2Z6NElpVkI1M0U0R0dlWWNV?=
 =?utf-8?B?djA2T0ZFTmY5WEdZWWFoeXJPZXJ2M1lFZ2RJTWFqSzFoeVFnOEEvL25nR3dn?=
 =?utf-8?B?OUFsL3JhdXFjL2JjaXVtQWhYeGxJSVdXSEdQL01jc1dDNmR1eDc4TWVhcXd3?=
 =?utf-8?B?ZzArTjZqVkRlQTcwNnJIR0F6UjhBSVBDdWxieEV2TlJENlpHQkx3V2srTTdi?=
 =?utf-8?B?VzJSaURCTkxxTHQyWk5MdzZvWkxoWlMxdUM3djU0TlBhenN0L0tudWJzMVlm?=
 =?utf-8?B?azEzY0FCNmpHR3NPN0E3cTFrUEMrR2tBN092bk5CcEdWb3FZV2cwRGV0YXFX?=
 =?utf-8?B?Y21lK21ySHdnTlhSc3ZiWDZ4VnZNd1lTZmltYTYrL0YzcTkyZzdvQXJ3U3dL?=
 =?utf-8?B?OXBzaENPU2hjQldWS1NMcmF3dmJueW5naCtxd3NldzdkOTdjMVRzckNPVlVx?=
 =?utf-8?B?R2FlQUpNeTdDYjhTL2laL1RLZkRLemRHVFQ2SjFqWk4rVTNsRDJEMFRjbE93?=
 =?utf-8?B?czNkUUVpcWtrM1VWZ3p0SVN0eWxvQnJkQ012ZjNySGN2ZExUZW5ObUZrc2hV?=
 =?utf-8?B?OUxGUXhWQnlaQU9hZmcvU1dKWEMvdGVmVFpFZUl4S0d2U1o3V2Vwa21lTGlP?=
 =?utf-8?B?a0dLdFg1MGY0VlZzV0VTQ1RPYSs5UTdOOS9ubWw4c1pNOTFuTkp4R2RGcGNY?=
 =?utf-8?B?cTJwMzNVUWM1bTRxQ3ZPQk5MWGNZUDBrWlZVTXFzS1FzelV2ZVpFRFowdjlq?=
 =?utf-8?B?U2NuUXpKS2dpbGVzWTFSWGI5bXZLbXdwbjVYZ2l4MVJROHhSRUI2cDh6dG9I?=
 =?utf-8?B?SHd0QzJ1cUVXYWpDTTJVYklQcnJqM2p5bHdyc21hSDljQUs2amFuT29kZ2NH?=
 =?utf-8?B?M0oxUDNtRiszSzlrbWNSdTdGMGUzbktkcVlPMDFqMmRSRHFLOVZySUZPV1lI?=
 =?utf-8?B?Rng0NVJkWHlCK2Z2aFhheGc2T1dxNEFBNnBjQUdWOUlGZ05nT0xpUkFER2VS?=
 =?utf-8?B?ckZabW1aa3VnVmhzKytiam0wYUlPdFZTY2hiZWdkUkFSNkxUYmlwWnQ2VlRM?=
 =?utf-8?B?blFFUjVNTy9mdDB4cFpjcEpNK002Q3NTU0NLMmUyTU1iSU9iNDMrMm9NRGli?=
 =?utf-8?B?UUJ5dFVZdWVPUXl3VGdoNnBsZTY0L0ZUOG9GSHNKd1FkQ3lrb2lmRFp6Yk9Q?=
 =?utf-8?B?WnBTaTNMdEpVa2JYMllZdnNSZFNmeHpWYWVyM2ZhQ0hxVUlPUjdZN2RWaVZp?=
 =?utf-8?B?aTJIYVBEcnRWSnpFdi9tZTJ4dlhUUTdBelVuQ3dVaVpoUzd1bFhnblgrU04r?=
 =?utf-8?B?QzJBVjFocWZKK2pJUFBtUmFFWFBGTHNuczZCOHM4akJSUlY4T0ZhQXkyVnF6?=
 =?utf-8?B?NWFoMzVpRG5MUkR2cWlLYlVINW9BZVhLaGZrSFVCMExlTDN1QmR4Z0dqc24r?=
 =?utf-8?B?RUdiNWhFS1dSaFFKR29ZQkRESVd4RUFkRDlxYjVkYzRZcFZmeVg4ZHMvRHRM?=
 =?utf-8?Q?Tiklqnms9FuytOCB4n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9af54ff-e519-4db9-d858-08df04d6b7e1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 07:33:56.5543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxOlS/ICIKFVP57gtsgXgaNnOQM4h40KLIsvfcf0ojFPFmI8rOOGXtmaVaNunK3M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8215
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

On 8/27/26 17:48, Sunil Khatri wrote:
> For different address types the variable PAGE_SHIFT might
> not work well and it's better to use the GPU specific one
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Oh good catch, Reviewed-by: Christian König <christian.koenig@amd.com>

This patch might need a CC stable as well.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index c8d1f2624b1b..dbdcd57e5b6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2090,7 +2090,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>  			after->start = eaddr + 1;
>  			after->last = tmp->last;
>  			after->offset = tmp->offset;
> -			after->offset += (after->start - tmp->start) << PAGE_SHIFT;
> +			after->offset += (after->start - tmp->start) << AMDGPU_GPU_PAGE_SHIFT;
>  			after->flags = tmp->flags;
>  			after->bo_va = tmp->bo_va;
>  			list_add(&after->list, &tmp->bo_va->invalids);

