Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54057C9830D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 08:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC91D10EA11;
	Fri, 25 Sep 2026 08:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RpfUMX4J";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84DC110EA11
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 08:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQ2fbbVVqVPwIwbC/UjbeFguiKIohyuGW/z3DCPL/fDKPpb2LBY8osGaD6FlVi3m64ZxHsUbSw4NGUOc7nyQ/px34rZ9IL6Fo7FDZG2W6cHy4KCJK0cWwB9YLm9Mu1m2M5TBwuxeBqLsAVPKcEgJcWf4SpUWcfkulNal4VeeEDRYs1vMlZuhMyQdemqiij4kgCWeuN2C2iLIpg5kXUhSuit7pLCvGJkSSbEIWyeyGwL9ByK3cFAc0oSU7hl5gFmg+S7jmOVRIhm3eytDqCMTyqPTcir24aXZYscXQN8M/hxQy2Wf3Pc/Q84z3rUmXQRDsPWKhIuRSIMan3VI/Uftuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Va1+kjgbaeaSDCHKL5FXsy0e6BHEAD7WH3qn8Fe/kBE=;
 b=PST5aWC6+Yc1TfHRfFjOlswB9TLzaqHthPVsVwGXTD9NxJuV/NvzKE/f2w66WBZkIQxEx9v0za8wAToOM03VA267K3kDmLa7bgQ/23ueuS0m7eWr52+1PEz/u6dB30Z+AlQHVAKPg0RSg4/7iltgiVpmddpOlZ3MUcYDXYjaZgQ3LGZfGssAiJP1uCh0DIMHfedZE2UZvqoX70lvM1JOCVgJx6U2GPumwEZ+UMiB9poB+sfRTJmO/WhMGAUoJxFAfQ7pKwTgu101oAAHbhj8FL1veFNnjJOQTK/aA24hqKRvX4qAG/ezxTaVtZEwgmtVME6ZO3TcH3hVv6r5cRiiKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Va1+kjgbaeaSDCHKL5FXsy0e6BHEAD7WH3qn8Fe/kBE=;
 b=RpfUMX4Jh6uexcgXkFT0VS6vLmlHwwJSx4/OmhdTA4Y8HIbni5Ps5DCaxqnBKPpJGuG7uObrsU8ti2rleJx8zLPbcTWqkPe3erDBN2g+QIcWZZ/X7oN1aSRuUsg3LSEFAkZA0qc+qAhOddzv4ECXr7mrIvLdsAI3XBo9w9pSVyw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 08:51:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 08:51:32 +0000
Message-ID: <c901f3d3-6451-466f-8e41-42baa61137b8@amd.com>
Date: Fri, 25 Sep 2026 10:51:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] drm/amdgpu: place VRAM-capable dma-buf imports in the
 PREEMPT domain
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20260924133644.1541887-1-mukul.joshi@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260924133644.1541887-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8861ee-49d9-4c3f-59ee-08df1ae232c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|22082099003|18002099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: hb6CLrfABMUidENm7gfovAnGl2UQNjw1PeNUx16f0IHMMEiuV1WrUmB4Q1IX1GT8bbgZwK6sS8QDgk/l+GDJGjPwgkQ+bB5urgeEurWtLd0xSTOGG+pAUEgxVySfNPtt3tF/PIUJd9Yqq3YLCi25b0DVw9oMid2cp5uRgB2YyrwMsDl6arT6bPvM6uucbcioN5FWSHCGMXSpXomf3BAU4QRSra+OKh5xuIPFXPsyRZfuMJB+zJ8rxLiMaFp0GlCuN2iHs7sgPyWQH9dBrKmLodRNRQUmCZ8lbz3wLVIcvtvH5s8tjz09rCBYHugzUMNylCzHTWZsNfGssPc3Zqk3QsGMSRVEKHTbSUI/WtTNOQNwUi5CHJitLaJzRVBU4qmdpCYMAWiR0ga/gDf3x3hDML+r0RZNOUvh43UVEa5LeS+gFxO/UJwmVuPRE9cVzaOOBKv5eDYdAH1X5DG0a4YF2qsja5aYvNaQPojh+SRE1xaRv0Y94zYSwXjoPL6VKhfrihOl9VHB6o6gF7u618bh7CNRj3/sL9Zx9rhsUS8T0mHt2dxDRtbGcZzvsfioEF3UuIb5yzESu4yuIk2eHjTKJugKJ/2mKqDkR7utL3y8VQL5AnqutIHmiT4CwjcoX4aM1EnjdtY08zp9AMBrbWxgOZzvMVoeDhKGj7rM9E6M8+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0ZMRkwwSFUzRmlOK0xhbjMyWk9YQWRwejJuWnJwTCtFTEROREhlT3d0OXpG?=
 =?utf-8?B?WkxOYlMvd3pockYvWWZzS0lDR2JHTWJHbW9KOHNCSzRLQTFCSEdQQUk0RExt?=
 =?utf-8?B?Sld4akNDZm9ZWFMva1QwaGhmQzVCZ29tQ2RRd1QyOU1rczdXSEorSjdvbGdn?=
 =?utf-8?B?ZzBFSUJPWjhkdlhsUjM1Qnlsd0VHejhNK0ZGZVpTbEMwK2grSktKMGRQdGpP?=
 =?utf-8?B?MHVVMkJxRFluZGlKUWFLLy9wbmx6ZXR6dTFXZVpFOFk1YXJFSmN4Tzc5cmt2?=
 =?utf-8?B?RHZYRHBqNStQam1ObTNYM3BuaTNJVWNNQjN2Sk5uVjd3Zlptc0ZlcVRHdG9B?=
 =?utf-8?B?NWNuYy9oRURuakhaZkhVSnluSHo4ZEpZTWwvSXhOR0tKN0hDeXF0NngxNER3?=
 =?utf-8?B?MCs2OWpwZlYrUWNZckd6bjRINTNlQnNsUk0wTXVVRzQxbUd0amc5eGo3ZmlL?=
 =?utf-8?B?L21KWEUwUGk1TDQ2TSt6anBjZXpJcWJQMy9sUDVDUlVzUGJXMUpCaHY3RTRG?=
 =?utf-8?B?bjFHSWtMMGVVSTdZL2g0cGhoK2dsdHRjU2Z1TXRPRGpSbWdMSHQ1MlY4dndl?=
 =?utf-8?B?VFd5ZktnUEE0YWdsa3FHZlFCK2puN2RzNlFwcS91eW4vSXBiNlhBalFoSFVT?=
 =?utf-8?B?WVAvTjVzRCswQjdrRjhuMHNtenVseG5lL1JRTG9YZFRUT1BqeDUxcm02YWFz?=
 =?utf-8?B?L1BUSlM4bnVHYlMrWEhON2E4VGd6M1grYWk3K1BlU0dPKzAycGFOKzRaeHJl?=
 =?utf-8?B?NWM1SEFiOWZhdzlpS2RnUVJidkloZUJZM2psbUpZb0hzdDBnV2drL1ZUaHh4?=
 =?utf-8?B?VGtmbEZIanB6M0lXa2UxVDZLUlFWNnhRZUU4MDZBaHRZaENwWGdyV2xVdHVH?=
 =?utf-8?B?RnQycVV4RUVQSjR3Sm1IMkRER3owUGN3djJrR0hhaFJEVldlR0JLS2hScnhq?=
 =?utf-8?B?Tm1ZeHcyKys0MFIxNWt2SWJ5ZUxnMWxaK1FjL1hUMjluKytuM1N3Z1hmdVV3?=
 =?utf-8?B?NGprTnh3c3JnQkd2WjV4MUl0RnJLV1dnYzB5MlZybWVEYkdkTVNoblIvMmJu?=
 =?utf-8?B?empGemgwemo4eEYzdFZNZmxqZHZsS0ltcDd3VUNoYXpPUlM1SWNZRmd5aEM3?=
 =?utf-8?B?eCtoc1lrSkZ3eVY0d0toTVFKdGY1M3ZrNWdjZkwrR3lFMDZ4blBld3luY3g1?=
 =?utf-8?B?ME5JcFNCR1VvUmpZL2ZTdU1ZMHl3R25DUDc2OXdyeCsrUWk3VTd2VENSenNU?=
 =?utf-8?B?YVVIOGZDaVRKbzhGcnZGWW9KeDB1UVhaNHp3M25BQ3N1bDNpVE1kNDdGYTRs?=
 =?utf-8?B?MGhKUXZhdkRXRHV0TFhWTzJya3BPVjI1bGc3SFRRKzNXTlBDOW9KVHd6MnVD?=
 =?utf-8?B?ejJQVGh1YnpGRG1QbHVDWXNRVUg5Mk44Skc1NGxZNnhQalZuU0x1OGZxY1p6?=
 =?utf-8?B?ZWZkY0FxWk4wTlBOS3ZnSXFwNlFYWmpmRDhYbC83eDdSMHBUaDlsV0RDR3Y2?=
 =?utf-8?B?dUpuZm11b01RRkdPK3JYMStva0lqV0VORmsvNFMzYXZPSmJNQjlEMHkrTzB6?=
 =?utf-8?B?aFExajM4Y3pvZytPZlE1ZkI3Skd3cktTNWpzKzRRQ0Z6RGVCekl2bmNrUjM2?=
 =?utf-8?B?OFlUUmVHWTdCb0NzSG0xajZ6Y3d5WUFPeUo2WWQ3ejBXZ3ZIbkN0T2ovNDBZ?=
 =?utf-8?B?UDlTNFc2TnNSd2lJWHcwc1dWQmZBbCsyR0pzaUE3cm4xV3l2UTFueTBwTC9E?=
 =?utf-8?B?aDRMcnUvTkxXZDVrWUtWaVBnS1JHRlUraGM4NDd3STYxd1Zmd3JzYitMNVo5?=
 =?utf-8?B?WlhrUk0rbzIrcGs3Tzh2S2xqZGhHR09ERHJxVGd0UTQ3QTZsQ3RETFhnWXVt?=
 =?utf-8?B?NE15cXZJZDlkR2xici9vSi83ajBhcjRyaDgzdm9lRlJwQWdQMmZhcnl6b3kv?=
 =?utf-8?B?WE11UFJCa0REZ2puUGJDRzJITjFXc1IzdzhFQ0Z3MHM0RzRzQTZxcFM0ajZh?=
 =?utf-8?B?UHUrVEVhZ3owdzNRQzE1YmtFTkhxVFV0Tml5WnNOVWpoWHBBTzRmNnRuYnB3?=
 =?utf-8?B?VFpTRnpyVktKYmFMRUlqRGFJYzhBWmJlRFYwTXlmMU1PQWNRRkVpME9EYUhJ?=
 =?utf-8?B?L0EzSDhiY1hkcklyZWRDb29LL2FMSEtUV2NGdm1Qb29QTlJnUGtOTDhkcWRV?=
 =?utf-8?B?OHZ0K2IrZmtOcjRCcVowUGlQTGJkMVNKQ3YvMFgyc1h2SVFoZ3VLZXFLYlRm?=
 =?utf-8?B?cXE1KzlIMGorcDcrOWFlMkczL1RvM2k2L0Fvbm5OblZDYVk3NmxJWEE3OWtD?=
 =?utf-8?Q?ymC9pOTfLmBu2zwEB4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8861ee-49d9-4c3f-59ee-08df1ae232c3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 08:51:32.8254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNXN+wGSC3m27AeraMFpCbafHQ7bOjJgFcGatu8bhWII97ShkwgsgU93LH14pLl/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459
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

On 9/24/26 15:34, Mukul Joshi wrote:
> An imported dma-buf BO backed by a VRAM-capable exporter holds no host
> pages of its own, yet when validated into TTM_PL_TT it is charged against
> the GTT page budget; importing many such buffers can exhaust that budget
> and fail with -ENOMEM even though no host memory is used. Set
> AMDGPU_GEM_CREATE_PREEMPTIBLE on these imports so they land in the PREEMPT
> domain instead, which is GTT-like and still bound (keeping the exporter
> resident) but carries no host-page limit.
> 
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> v1->v2:
> - Check if p2p access is allowed. If not, clear the PREEMPT flag since
>   the BO will be put in GTT domain.
> - v1 reviewed by Felix.
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 4031ebe075d8..bbe518757907 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -472,6 +472,15 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
>  					 AMDGPU_GEM_CREATE_COHERENT |
>  					 AMDGPU_GEM_CREATE_EXT_COHERENT |
>  					 AMDGPU_GEM_CREATE_UNCACHED);
> +
> +		/*
> +		 * A VRAM-capable import is backed by the exporter's device
> +		 * memory, not host pages of its own. Place it in the PREEMPT
> +		 * domain (GTT-like, but with no host-page budget) so many such
> +		 * imports cannot exhaust the GTT limit.
> +		 */
> +		if (other->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)
> +			flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
>  	}
>  
>  	ret = amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,
> @@ -618,6 +627,17 @@ struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
>  		return ERR_CAST(attach);
>  	}
>  
> +	/*
> +	 * The PREEMPT domain is only correct when the attachment actually
> +	 * resolves to P2P access, in which case the import lives in the
> +	 * exporter's VRAM and consumes no host GTT pages.  Without P2P the
> +	 * import is staged in system memory and must count against the GTT
> +	 * budget normally, so drop AMDGPU_GEM_CREATE_PREEMPTIBLE again.  The
> +	 * BO is not published yet, so clearing the flag here is race-free.
> +	 */
> +	if (!attach->peer2peer)
> +		gem_to_amdgpu_bo(obj)->flags &= ~AMDGPU_GEM_CREATE_PREEMPTIBLE;
> +
>  	get_dma_buf(dma_buf);
>  	obj->import_attach = attach;
>  	return obj;

