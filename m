Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D8AFF8860
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 15:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3DCE10E7B6;
	Mon, 27 Apr 2026 15:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AjFBEfHY";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57F0410E7B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 15:29:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZRIAjzMoWkiKLccuGwrmlNppVZ+iF3o4O3p9shVkvgxh6ZT5+VraSCjDznBl+dwgq583/ZouZfE07tB8+h2LHL+Knowm14btuk7uvV1dvGgWJ1kGFQqGj3YJyA4V2VXE6UUf+Bo9BFhFHrDvUFAqHP61nKElL828P2Q1ebH+2xcgZbTa6LOgsyzldDbv18fXyUdC1hIwYUcIimILOB8JKpuVQRThpZrI5nSc6VIRzhc5eCL+izmb87TfxoyeVt4rZoSn+9UJkxxwiYi082oYUicLijT9uEoO6txwGqmRgcpTQYONle5u1efrpaU+aI4d6C58q+9ufUvtclTVLYTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gnALiOftUD4EQ3OcGvkcQbwXz0DJ1OJX3NnHXuhDxk=;
 b=XO5EGnt4YIFgO5OGaNzOtg3fSKQDKlBVKYiuPtJLR0nxWxvTIYnElg/QUwgcnfwW3gmFCLWId7FfLDRWaoR7gZp+jUzg0tFYb7Ur3deSDjtNMDFHrTQ//8lWxjpt3/VpI7cNIMGVsEZTwgrDb9sAafI3N8n2omm5o9cCKEp/z5mF7jOOxAT8jgO4vCJLSTgN1M3XmTEU6WPiwV7zFfPKZ7AUJEsdD6DIr07N91wBsK30dgftEyh6eFN/0tELRNNSrP+rvzi6rlZpoa6V777pcd5dyDb57soOwYt9dPahdIf05mw6g9JrQWxrwWjYw6lXCOti65eQElfU5V57D1M2fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gnALiOftUD4EQ3OcGvkcQbwXz0DJ1OJX3NnHXuhDxk=;
 b=AjFBEfHY8n/H/LWDqhDbkp/Eg4Z184bDbAvG9PSiBE7qGADUvExsXOKJimb2qdKJwYf2tnvvcguss4zz6TDNcTmXsOavnURkjtbiaBv8ZfUnR8q0dbK+0U4M/NQ4/7nvyap5tXdyrsdLV6desvP1ucXv094ETvjEFEjzkYtUlPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Mon, 27 Apr
 2026 15:29:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 15:29:00 +0000
Message-ID: <f05eb0c5-5591-4226-b461-9bbddb960983@amd.com>
Date: Mon, 27 Apr 2026 17:28:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/vcn: set no_user_fence for VCN v2-v5
 enc/dec rings
To: Yinjie Yao <yinjie.yao@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Leo.Liu@amd.com, Alexander.Deucher@amd.com, Ruijing.Dong@amd.com
References: <20260427152248.1349143-1-yinjie.yao@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260427152248.1349143-1-yinjie.yao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0342.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d737158-8459-4b29-65cc-08dea471b464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: IA2+xPXMDiQULyFtBiMn1VPxfj7cGLM0ikP//FalS32c99RvwKrZvLXn4bbu3aDpe9yN/pGIuM/yUVFk2Q9UeZbZgVqvkINoslISroXesirGmoj7LfOOTcU33KjD34qMj/QnE6FVxo1lGNdhE6U1wF32QUPyYmpc8X9yyd/i26Pvgsk+sFpyllVuyTuD4k7+hwxnASGFcvoRObaEdpi/8AF8Kgpc2Stv32MIk43kmuW3nTnFnzEPzypAndmgbI+cJ6eQAZ+l/b0BA1C8eo9nYOLZ24zDV41LqSiKvrfHqKJQ1oo3nIT2OSsgngsy9ALG34irXzOFu6saT0umyAjjAlmXVY0+BXLU6PWiK+sjX9uQf9TkCVZQERAcDlVDISE4WNdQ0mq9IhXxCa/ZgTraSHUo1JIvFJoxjvGcilOGmzdU2ATs79mMYt2QYq6ioWPWH3xsLgqt1dgtfW6DP9clHLlYNVseQuw6jbi2MX+3k5c46uXByUm8Hbh8j/nhq3GZT/30rbx320/QdOPP68DSnGyE8qzzoo+y+6FWHaolJEYf6lm5GAXfDvtkxy8OKgambQjPhqGIV6zCouiB+Ro7pEPFN1ljs0LiHRg9aQ86rr/c0PiYebmZFwYtc6B5n8GutsmzPjUYqEj3ZaX7U4mzdpi/0he+7tBE199VYrIj84KeLFVDGO19tyMW9hF0DaGmWudxknhUFaY6A1eFmLM9Rlem4sDCuVeM934VDr3JCXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjA5anNETGl3ekQyTkpEOFlZaUlWbHRRRGNBNmZ6K3RsWEd2d1ptQTdiTmZk?=
 =?utf-8?B?bUEzZkR5akRlUWZyNmZTenNvWUkxdTV0L1VzdnV5eUgvWWxaMGxaUDdmZExH?=
 =?utf-8?B?akJ0QWgzVngwUGJtaU10b3JFUWVEaXNZUWtuQkFUVEVrRXp3WVVNUzRVNVhj?=
 =?utf-8?B?YytEUDBOYjdrRklyNExhZ05naVJETVBXQ01DbkwwS1pkWWhPaVc5d2tNb3lx?=
 =?utf-8?B?eWFvNVhkZXpBQ1Q3bkhxNDR0Sld1MlhVSnBOZ3JIU05OYnAxYWowTmR4a0xT?=
 =?utf-8?B?RnByTDFrWjhIRWFHQXFZUjVCeUg1VEp6bjh6SXB4cFZVQWpnZ0JTaVdXREgv?=
 =?utf-8?B?KzcyVlBLemRpQTQxUTBQMjkxSXFsdEQvNWE1UG5WZ20vTHFhdGwzbndTcWFu?=
 =?utf-8?B?T2VvbmZMODNsRXBVZ2hsakI3SzU5MEkvLzhKQjdFeTlKZ1VLV3RIQmYzNTUr?=
 =?utf-8?B?dFU4cjBoalMvYUNKTkhjWnAxUVYrNUgzemhGTWJqOVljRDRFZ2F2L0R4Qzhs?=
 =?utf-8?B?cEdyY2Q4Vld6MVpqZGFJVkNmL2k3aHF1dGNYUkM1UTZMcjd2NmFqUEQremJt?=
 =?utf-8?B?akU0UVNmUzIrRkQ5Tlg1MXAreTZiMW13U1Jwa2IwdE1hd3p5a05BQmEvMTB1?=
 =?utf-8?B?YUtzY2xnRDZqMzRPSE9IUy9aWm1RYXFyRW90SFRSd252S2ZXd3QvN1RkazJa?=
 =?utf-8?B?c0ZWK0J3N3BONGlkaTl5TEExMUoxUFg1eGVMRDBlbm1PMUtiVGIzcnlkaHB0?=
 =?utf-8?B?aVk4Sm5WMDdhODlJWnlrSUVaZUVTbXo3T0RUVXhIOTBpazFuUjNBbTFQbEY1?=
 =?utf-8?B?Q2tocUgraVpYaVJaVWh6VU16by92N2YvdGx2cWZKS0gwU3BNRllUUmdLUEpR?=
 =?utf-8?B?UmVNeGFUd3QySDdCSlgxVUZ4V3U2WUgvSmhXWGZxL2FEQzZOVXFWWEhQWi93?=
 =?utf-8?B?M2d0NFRlaWZIcU0zd2d5aW5kbFVvMC9rQ29LQ2dRWTk5NCsxUSs4a3I1VGRB?=
 =?utf-8?B?d3RwMDdJRjhlWTRVdjFVeWt1Z2ZDb0txdVYvR2RrRWtDVU5xZ3hRNmpPK3R2?=
 =?utf-8?B?aWhySjZyNk1ybTA5dXdJSUhveDFlNXFkaWcxMmdENEJoMVdiVXJ2YmdRTmFX?=
 =?utf-8?B?SHMxZmVobHdaMEd6R1pQU25ZRjJVM2RFVmMrLzFLaG8wc09ldVVmNXB5VVl2?=
 =?utf-8?B?eTMzbzdna1lja3I2L2FWZlFSeCtXS2pBdTFhZFo3YTFwN09ycjd2SUJnR2Nk?=
 =?utf-8?B?VzVpUTdlSEZrMTk0VjdNazFHQzRRSk5PSFhrQ1hqTUsrenJWUFN4QTMvWXJV?=
 =?utf-8?B?cmxBcGZuM0tmbGpUM3pGeVBNVWU5aXFHdWFjNXFSTFZ1aE5YOFZCaHIzaEZn?=
 =?utf-8?B?RVNid2VqeFoza2txdGoxSE96dWpZWE1xcWJTQjBldE1ZdXZHNDJiVFVzSFBt?=
 =?utf-8?B?c0FQVERrVy9zODdhK0pYcmFPY0g3VitlZXQzNGRwSjc5YkwrNUJJZW1Oa2FZ?=
 =?utf-8?B?SktSeWZHL291TXo1Ynl2aFl6RVc3SFpUOU42bXdsdG9GcG8rOHh2SkxGZkFZ?=
 =?utf-8?B?M09xRHRTT05DZ1ducVZicXRaU0xRenFCM1Q4clhXSTFuTFFiRGQxM3Y4ekJN?=
 =?utf-8?B?aSs4azZ0czNJV0FEbTRMQ3FsMjB4Zm1oZHdTR25MQzFlMCs3SUxqTk5HMDVO?=
 =?utf-8?B?RGtFWE1aVEZmLzNXOC8wRDdkQkI3bW5JY1UzaVgvMTRWNTgyRjl3M2Q1ZjRV?=
 =?utf-8?B?dnpzczJndVN6bkF4MXVDNEFIdjJyNXdYeEtHeUxrV1FRVVUwRFZ6U1BkbDJr?=
 =?utf-8?B?UG5ERVhNVGt3enh5V0VWWWs4QXVmMjlOZHlIRUhuTmI5bGlJbVNLZjIyM0FK?=
 =?utf-8?B?NkpkOCtTZkNOUWdrWW1Rc3Z1TjAzaTZGRlc4OGNkUUdQQXg0WTkvclZIcnpU?=
 =?utf-8?B?RlpnUVFmZFZXT25pNVlVZy9kR1BmQnpTRjB2L2cxK0gzamdXdWdPNmRyd1pL?=
 =?utf-8?B?a2JHR3ZGZmRRTmlrOW9UU1dFd05LV09oa1NVOHRISjliMHF4a28wVzlVcUs3?=
 =?utf-8?B?ODY4WXBCQjRBdmk3RDRQMVdFUnJ3bXo4VUFiZzNlWmJoVmF3NVExSkJ2bnJM?=
 =?utf-8?B?SGhRRFBwamd2V0NUUEd6OUJnaCtBczZ1dEsyOTNKeFBvSi82MmI4SGc5UmNr?=
 =?utf-8?B?aWZSMDZWOGV3d2UzdnFoTURkSjRPV2lqSktFbFNLN3QzS0NEZlF5VFMwenJz?=
 =?utf-8?B?QXZjQWY4d0pCeTlFV291dFkwTXdPdVQwbWVRbi9vZURueXhEbFpuSWYwWkUr?=
 =?utf-8?Q?sHaS0F6lx/D3ldLJiS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d737158-8459-4b29-65cc-08dea471b464
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:29:00.7562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVp45HIWxdyEC64nU+/8wZ+kOfszH3MWdt2mDsQqUQS4vGX8qq8s+MhSt0AzLc1M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042
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

On 4/27/26 17:22, Yinjie Yao wrote:
> VCN encoder and decoder rings do not support 64-bit user fence writes,
> reject CS submissions with user fences.
> 
> Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the entire series.

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 2 ++
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 2 ++
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 3 +++
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c | 1 +
>  9 files changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index e35fae9cdaf6..0442bfcfd384 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -2113,6 +2113,7 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
>  static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
>  	.type = AMDGPU_RING_TYPE_VCN_DEC,
>  	.align_mask = 0xf,
> +	.no_user_fence = true,
>  	.secure_submission_supported = true,
>  	.get_rptr = vcn_v2_0_dec_ring_get_rptr,
>  	.get_wptr = vcn_v2_0_dec_ring_get_wptr,
> @@ -2145,6 +2146,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
>  	.type = AMDGPU_RING_TYPE_VCN_ENC,
>  	.align_mask = 0x3f,
>  	.nop = VCN_ENC_CMD_NO_OP,
> +	.no_user_fence = true,
>  	.get_rptr = vcn_v2_0_enc_ring_get_rptr,
>  	.get_wptr = vcn_v2_0_enc_ring_get_wptr,
>  	.set_wptr = vcn_v2_0_enc_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 006a15451197..8b8184fe6764 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1778,6 +1778,7 @@ static void vcn_v2_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
>  static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
>  	.type = AMDGPU_RING_TYPE_VCN_DEC,
>  	.align_mask = 0xf,
> +	.no_user_fence = true,
>  	.secure_submission_supported = true,
>  	.get_rptr = vcn_v2_5_dec_ring_get_rptr,
>  	.get_wptr = vcn_v2_5_dec_ring_get_wptr,
> @@ -1879,6 +1880,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
>  	.type = AMDGPU_RING_TYPE_VCN_ENC,
>  	.align_mask = 0x3f,
>  	.nop = VCN_ENC_CMD_NO_OP,
> +	.no_user_fence = true,
>  	.get_rptr = vcn_v2_5_enc_ring_get_rptr,
>  	.get_wptr = vcn_v2_5_enc_ring_get_wptr,
>  	.set_wptr = vcn_v2_5_enc_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 6fb4fcdbba4f..4924da5af5e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1856,6 +1856,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
>  	.type = AMDGPU_RING_TYPE_VCN_DEC,
>  	.align_mask = 0x3f,
>  	.nop = VCN_DEC_SW_CMD_NO_OP,
> +	.no_user_fence = true,
>  	.secure_submission_supported = true,
>  	.get_rptr = vcn_v3_0_dec_ring_get_rptr,
>  	.get_wptr = vcn_v3_0_dec_ring_get_wptr,
> @@ -2036,6 +2037,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>  static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs = {
>  	.type = AMDGPU_RING_TYPE_VCN_DEC,
>  	.align_mask = 0xf,
> +	.no_user_fence = true,
>  	.secure_submission_supported = true,
>  	.get_rptr = vcn_v3_0_dec_ring_get_rptr,
>  	.get_wptr = vcn_v3_0_dec_ring_get_wptr,
> @@ -2138,6 +2140,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_enc_ring_vm_funcs = {
>  	.type = AMDGPU_RING_TYPE_VCN_ENC,
>  	.align_mask = 0x3f,
>  	.nop = VCN_ENC_CMD_NO_OP,
> +	.no_user_fence = true,
>  	.get_rptr = vcn_v3_0_enc_ring_get_rptr,
>  	.get_wptr = vcn_v3_0_enc_ring_get_wptr,
>  	.set_wptr = vcn_v3_0_enc_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 5dec92691f73..bbdd017cbafb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1994,6 +1994,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
>  	.type = AMDGPU_RING_TYPE_VCN_ENC,
>  	.align_mask = 0x3f,
>  	.nop = VCN_ENC_CMD_NO_OP,
> +	.no_user_fence = true,
>  	.extra_bytes = sizeof(struct amdgpu_vcn_rb_metadata),
>  	.get_rptr = vcn_v4_0_unified_ring_get_rptr,
>  	.get_wptr = vcn_v4_0_unified_ring_get_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index ff3013b97abd..10e8fc2821f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1775,6 +1775,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
>  	.type = AMDGPU_RING_TYPE_VCN_ENC,
>  	.align_mask = 0x3f,
>  	.nop = VCN_ENC_CMD_NO_OP,
> +	.no_user_fence = true,
>  	.get_rptr = vcn_v4_0_3_unified_ring_get_rptr,
>  	.get_wptr = vcn_v4_0_3_unified_ring_get_wptr,
>  	.set_wptr = vcn_v4_0_3_unified_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 1f6a22983c0d..1571cc5a148c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1483,6 +1483,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
>  	.type = AMDGPU_RING_TYPE_VCN_ENC,
>  	.align_mask = 0x3f,
>  	.nop = VCN_ENC_CMD_NO_OP,
> +	.no_user_fence = true,
>  	.get_rptr = vcn_v4_0_5_unified_ring_get_rptr,
>  	.get_wptr = vcn_v4_0_5_unified_ring_get_wptr,
>  	.set_wptr = vcn_v4_0_5_unified_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 6109124f852e..d5f49fa33bee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1207,6 +1207,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
>  	.type = AMDGPU_RING_TYPE_VCN_ENC,
>  	.align_mask = 0x3f,
>  	.nop = VCN_ENC_CMD_NO_OP,
> +	.no_user_fence = true,
>  	.get_rptr = vcn_v5_0_0_unified_ring_get_rptr,
>  	.get_wptr = vcn_v5_0_0_unified_ring_get_wptr,
>  	.set_wptr = vcn_v5_0_0_unified_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index c28c6aff17aa..54fbf8d73ca6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -1419,6 +1419,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
>  	.type = AMDGPU_RING_TYPE_VCN_ENC,
>  	.align_mask = 0x3f,
>  	.nop = VCN_ENC_CMD_NO_OP,
> +	.no_user_fence = true,
>  	.get_rptr = vcn_v5_0_1_unified_ring_get_rptr,
>  	.get_wptr = vcn_v5_0_1_unified_ring_get_wptr,
>  	.set_wptr = vcn_v5_0_1_unified_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> index c3d3cc023058..bbc172db91a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -994,6 +994,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_2_unified_ring_vm_funcs = {
>  	.type = AMDGPU_RING_TYPE_VCN_ENC,
>  	.align_mask = 0x3f,
>  	.nop = VCN_ENC_CMD_NO_OP,
> +	.no_user_fence = true,
>  	.get_rptr = vcn_v5_0_2_unified_ring_get_rptr,
>  	.get_wptr = vcn_v5_0_2_unified_ring_get_wptr,
>  	.set_wptr = vcn_v5_0_2_unified_ring_set_wptr,

