Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD608C55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 09:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3766710EDAE;
	Wed,  5 Aug 2026 09:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zWzlIG1N";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59D6D10EDAE
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 09:25:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1JZ8mfQFrOmNYMWRJzCIpcZOskJT7VRyys+Hgg04fHuI386aq+qjM4XLewamBfdTGLXeTkLK5fK9gpDJTK1sAfyUn7ES2QWVh7m/K0JcsqT+G3slskqT8epyZOBAk/EJTMAoNEpSlqYeYwEWvs7GRom3I5FDsPkqito9DR8hwZACE3PCebdIcEKo+JhvgJOPCA+rYoxLUlpWBAk0vAGvq4owS0sgc6HDcCouNBiTKYPSNbJ87EUelUtHh7rMhU49sQx+ymEF0eox/+ldDXT2qOX5u9B8U1M3V0kYUvMyFY/FzQqoocxHXHzVQxQ/939R2qY+otUUDoGVMeXG7kwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVXQRTP6Q26LJd3yKi98kPmilTSWCkTa/euec1udMyk=;
 b=k7xmoSCut0esSjZLmVjBmhD7t1riCox9rHxINJjqiPcZjJ0KNvN/q2lp4sYfPbIkxCvcOT4+gjbwoNOBDqKThS351vrjkVvgmk8Dcyy4mzM04SqA2dHvsk1mLJl27YDLPEfUwuI9th2VZoa9eQDM2TV1f5xQUIa24rz6z1N06lTPCue+coNa/624aa40OMaVodhVHzzAu6kHXB9Re4fL990MfOzRaEsLV4dznd96ucnhdTdWctGNAbn26jsLZTcLMJA9P8E7Q7XUe7Z1xCg/1dLvvnOvLnkfvH4VCNx+FfOlqrX5hOE1++wPvRwRrsWYmA3TZf395xTLwaOavvqK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVXQRTP6Q26LJd3yKi98kPmilTSWCkTa/euec1udMyk=;
 b=zWzlIG1N7hO/ji0sIqFFb1JIhdeWiqXr39miUmvYfCj0jdTv9EYSWCropYoelTCG/snEedh7zaad2LsRCmG39cim6RCHPcu3TCAg0QITQTwGsAfoU+FEIqPqy5fWNXe5kvIwn4BwHPCunfIGY+B0plSwqgPngigln/UOZol+HCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 09:25:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 09:25:16 +0000
Message-ID: <57a204ea-2868-4b98-9d24-931a98b43d88@amd.com>
Date: Wed, 5 Aug 2026 11:25:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: skip BOs being torn down during GTT
 recovery
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, David.Francis@amd.com, Perry.Yuan@amd.com
References: <20260805085826.2700421-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260805085826.2700421-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: f272013b-5f4e-48e1-f1d3-08def2d37582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: HgHAPWMPB38Zi7hZGnHU8dQkvKr+ulNYNlh7J7FGuixo2zuxFifNyFvcg8cXgfeMUz3sz1PfsrUuFyDeg+MbyRxLPeg6XGdtmDeFyEJN69C4kZuDh0OwAyrYBfZRFvSy6AxW3locUKmFoQLCwTa3mPz/RKZ6/hyIGSH0+uJu/24Nd04fa9e290fgnfQSU+hya3bzKhpcCuGHLYm4jD8AI74a0Z3Kjyr3Tct7BtMJ84Tir9DVm/jlys0VP82IbzeiiN/LMHRqZA6W7DP1WZPtd40LnVm0yd9HKwLhoNVHzocURt7aM3zqOVRoHRcwfBAt9LxwTg/u3ydtCovNJN7NjMSsjeR48pCy1FJbgOFjcCjSZVqr9w5bwc3HPgHj/XaGPfCNh57OWyBwPOvyiV4a6Yd+jhSgC0RzUM3c3CvvypAXpQTiJ+N+rWoUxHtdQwDIBpmYrXM/NiYZAVbvEvCnawhSp11dxsNUzg/hBzxxH9LSVAAKTXLYPXAt6D86tf1Ha8/qJHX1DjsLSXy+KU4jO6cGEDP8t5DyhiDNcTC2bmJYqgtyxF0dXPPZTcKSJP4aUv94u1AHaNPolXmPSgyxdV64ojK3H/Ka3dby0krnFLhs90wcWqH/rdmaXwpD2ad4llTYZT+gqnQoAy0wfyC3IuaVgcRhjwYr+DnXOdpXPgw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVRBeGRIM2o2OExSSmlpOGRLVStwWHhzdml1M0JRMWpjaTNCY0FQYjlqZGpi?=
 =?utf-8?B?K09KSlUvUStuWTV4cUREZ2p5THJLWlAra0lkT0lhb0JuRFNhb3dRazNlVUVI?=
 =?utf-8?B?TExvLy93K1YvdmcybHcveHJsL0dNNFpwNnJ6TzFUTkZya2s0U2hnYVRKMHlO?=
 =?utf-8?B?UkZEcFExblh5Q050UThQeVpZVU1pemNtYzdON3MxejAzNGhpenloOThZOG5m?=
 =?utf-8?B?K2dWSkh3b3VGRm1rdFY1L25KL1NWZ2c2dWtaR1RkbmlkMWxrcWxzY1R6M20y?=
 =?utf-8?B?Mkt5b1ZUVVB1QjJ4d28vV2d3ZURaRGtUblVSSzNlS2VjdWduTW13UWo3bHpM?=
 =?utf-8?B?QnJYeEM0ZGQwWU9yOFdpNGhRdTBoV25jcE5MY1pBQm5jRkViNEFyVUhMZGox?=
 =?utf-8?B?bzNWV1JQS1RPYTJJallwRTVSK1JNWEhSRTQwNEw3YXZSeXpxVy9DZ1lJOFFK?=
 =?utf-8?B?d3FFRk9jRHVRZDFhOFRLS1J2NHFLQmU4eHc0ZGMyNmJEQXRNamczZzJmK3Bu?=
 =?utf-8?B?ajFxN1BDbHNtWVJkeUorYlhQR1J6YWtYcEtLRko5M3laQUJaL1BGcWlEcUpy?=
 =?utf-8?B?cjNiLzNjQUJOelE4YUp5Tm9VRFhhV1ZISnY0UWZpblpaR2JzbG03K25kenlF?=
 =?utf-8?B?aGx0b0pvQ3JXMUJJL1dTK3lXQWpqeVkrTVh1c05iN1Awd043OXgxYXhQTTcz?=
 =?utf-8?B?Z0RhU3JsV2RwbWlzdGt5cjFiTlhvVVNxOGd6L0lYYzBiR1R1TXZRdHhzL1Zn?=
 =?utf-8?B?L0NUays2dXI1QTJiTDJ5YzNmZGlWZW13R2dHVko0U2ZscGgyelZjbmkyVTVB?=
 =?utf-8?B?R3R5QnVWdThPemtwOW5yb3lEWGVyd1dUR2pwTUx5cUM5QjhPSUlscmNhbG92?=
 =?utf-8?B?Q3VoN09CckxsWlhRMklZbG5BbkRueWx6ektnSmpzNWw4RzFpZkZRWmFoeU1U?=
 =?utf-8?B?bk8xQ1k5M28wQVEremtSeTRXV09Kbm0yUDViT3diS0JISGZRaW1EelZBNXpX?=
 =?utf-8?B?ZXFLdXROcW45R3ltWkhIdldQVXlRZlpab0c2U3FuUDNBNmpjcGQvY2ozTDMx?=
 =?utf-8?B?Q0hLSkM4S0h3TFJZdmtwN1c5c2oxU0lvQjNmWmVsaTEyYk02MTBNcmRhclhK?=
 =?utf-8?B?Z05Xa2hGNkp5WUFMNjE5cVRRR254VVFuRHUzcnpBWmxBYjNpdTJLNVp5bUhS?=
 =?utf-8?B?bzd3K1h4ZHBIVnhBNzBVMGk4bTBEeTM4TFp5eDQrWW9QS0cvQnNidWViZHpn?=
 =?utf-8?B?MHM4RDBIK21ReFhrb3o4bmp6NE0yTFl3SUhYQ2w5eVZXa3U5a3lrcTBZQmZD?=
 =?utf-8?B?YW1hK3RnelV1V0JYNmYwRkxOaHR3MXJvZy9reVR6U2RtbkRtcEJoS2wzTlZx?=
 =?utf-8?B?UHJLVTdNdlBCeDJDWDBwK1lHQkJ5ZjRMZmQxd2F5RU53YUtHbDUyVGJGWFZs?=
 =?utf-8?B?RSs3aGhNaHpGWXhTZVpLWHJOb0QxYmdzbWhjWTNxWFVLbFBtVWtPK1duVFgx?=
 =?utf-8?B?Szc3TWFzRlJlNGVIbjFtYWcyNUcvZFlsSkpuMHdPVkNTSk1BV0t5Z2dRVTQ1?=
 =?utf-8?B?RDZxdHZrenpYNkRFckF5RElDODlJU0xWNVVoNWdQMjkzN3J4dlhPeHBGNmc5?=
 =?utf-8?B?NWdHVk9hb0pjSFEranlVZmI4N1VDMWpHQStXOUNNSEE3QlV5ck9Nak5tZ1py?=
 =?utf-8?B?SFdudnIzY1M0dUc1ODlGblQxR0ZENFFoZUI3U3BaUUNJOXNLNi9KMnlRZ3l0?=
 =?utf-8?B?eUpEUTRTR1h4TFZSNEhwZ0d5TzNGZGVlZmJkWjFXRGUyTU8yYTJPMW9qRlk0?=
 =?utf-8?B?R20ySDZtbjdYc3lDOWxQWXlJUkQxV2NPQ3NoSjVhaXgrRlkvR2NINmpBSGt0?=
 =?utf-8?B?SnZjT0haSUM0VXpEZ3oxc2MxT2UyVHY4UG5uVUNlaTdYcDJBKzd6TGI1aGRO?=
 =?utf-8?B?SXBSLzdrWUFIcFdoZFd5dXVjMTJRTEx1RStES3c0ZW0rT3RXNEMraFRJbi9R?=
 =?utf-8?B?Uy9BREZzaFVpRWF5cjBjQWMxSXU5TUcxUXJSYjJVaWRBakJrMGpjaDhhVStY?=
 =?utf-8?B?WVpmbHhRcWljWSt5NXVhY2xMWGVWdFNZYk40eC9LaUE1Z1Q1Mi9ReEEvK2Ir?=
 =?utf-8?B?TXNxNmgzbG1aZ2lpMklHbFhvMGFCUHVGZXVBSi9ra2xudG1LZnpFRkd5SWI5?=
 =?utf-8?B?OTZkZDMvZm5NQUFlOEpHdk94cVJYbzIvV2M5TEsycDF6Mm1zT3NUcTY5SS9n?=
 =?utf-8?B?ODdyejRHKzJHcU1mVkZXUG5jK2ZaZzlSNnF0T3BiWWJZVjJVblVocUFZdEow?=
 =?utf-8?Q?764MBHAfBPl44HLefa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f272013b-5f4e-48e1-f1d3-08def2d37582
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 09:25:15.9093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcYytxFNlH6vuMnqqUuHU44ZhbgYETvpOpkW7ylM2A3Ryk8NhCj5WeWdzFczRicq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
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



On 8/5/26 10:58, Yifan Zhang wrote:
> A GPU reset can race with BO teardown after the BO's GTT resource has
> been marked for deletion but before its drm_mm node is removed. In this
> window, amdgpu_gtt_mgr_recover() can treat the node as a live BO and try
> to restore its GART mapping while its TT backing is being destroyed.
> 
> Recolor the GTT node from amdgpu_bo_delete_mem_notify() so that recovery
> skips it, reusing the existing color for ranges without a BO. The range
> stays allocated until the resource is freed.
> 
> This prevents reset recovery from accessing a BO whose backing storage
> is no longer valid.
> 
> v2: refine commit message. (David Francis)
> v3: Remove new BO color. (Christian)
> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 23 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 +
>  3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 0ea32561c4bc..6219233ff712 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -102,6 +102,29 @@ bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *res)
>  	return drm_mm_node_allocated(&node->mm_nodes[0]);
>  }
>  
> +/**
> + * amdgpu_gtt_mgr_mark_bo_teardown - exclude a BO from GART recovery
> + *
> + * @tbo: TTM BO whose TT backing is about to be destroyed
> + *
> + * Keep the GART range allocated until the resource is freed, but make recovery
> + * treat it like a range without a BO so it isn't touched after TT teardown has
> + * started.
> + */
> +void amdgpu_gtt_mgr_mark_bo_teardown(struct ttm_buffer_object *tbo)

Avoiding the ttm_buffer object and giving ttm_resource_manager and ttm_resource separately would be better, but not a must have.

> +{
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
> +	struct ttm_range_mgr_node *node = to_ttm_range_mgr_node(tbo->resource);
> +	struct amdgpu_gtt_mgr *mgr = &adev->mman.gtt_mgr;
> +
> +	dma_resv_assert_held(tbo->base.resv);
> +
> +	spin_lock(&mgr->lock);
> +	if (drm_mm_node_allocated(&node->mm_nodes[0]))
> +		node->mm_nodes[0].color = GART_ENTRY_WITHOUT_BO_COLOR;

We could rename GART_ENTRY_WITHOUT_BO_COLOR to something else, but also not a must have that should work for now.

Feel free to add Acked-by: Christian König <christian.koenig@amd.com> to the patch.

Regards,
Christian.


> +	spin_unlock(&mgr->lock);
> +}
> +
>  /**
>   * amdgpu_gtt_mgr_new - allocate a new node
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index c4094edbdff1..a9067305b26d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1694,6 +1694,9 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
>  static void
>  amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
>  {
> +	if (bo->resource && bo->resource->mem_type == TTM_PL_TT)
> +		amdgpu_gtt_mgr_mark_bo_teardown(bo);
> +
>  	amdgpu_bo_move_notify(bo, false, NULL);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index ff9e2e346609..af1e7fcc7175 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -145,6 +145,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev);
>  void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>  
>  bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
> +void amdgpu_gtt_mgr_mark_bo_teardown(struct ttm_buffer_object *tbo);
>  void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>  
>  int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,

