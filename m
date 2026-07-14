Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47917C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 07:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D92F010E690;
	Tue, 14 Jul 2026 07:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z1OHAlo7";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012027.outbound.protection.outlook.com [40.107.209.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A7AD10EB6C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 07:00:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bL7UqTTwiQ53QDLGpzaD4NUMQkxEKnLZdQHo6QKSd+9qWxMyU88JGjSZ4OPGJjlfacG5IjrE1KOqbziDqwkeGg5vRKKIEm+l59YQGCiBRZ3etCAVwWb3hM0dRujBTxZleE27LeFWeK2ANWcXg4TN3V/9SyRFmYMd+4iL0hDQ4iyF18BBhZXQ7FbZV5YW2vZ19NUFXVTq+EWsa8qsPXUXqm328f8wzxeynPgvsOYKMxf71EXCE3Te0yWoWjVAMCAxKYW4pRS2yfxOw51uqyM0eVQVH2dzMVbHjpmK8K4CazHtO/4thtUuQlYiX9qssx1sg7CMiLSin/wY7o9CQJnu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1DzgNpRHoFzf4dvKpbaMmbYvA5S4lsH5tjMJd14ouk=;
 b=WikQRaaBDFeqRkE/0oPmevcWU8KaAY28vGXh0RPrMHqxZjCD69BB2He+wGenmdH2/BL3nSyAaLEEO01HmKLC1aqYii9eUPjWL8q+t5ZXKal56Oi5sIKM7zLuG9sDGvpbpe/T/JzgqjshzfCpdQ2dhwR7ExaVpAjk8L2AGv4EyUhx8kFV4Hz2+VN5ALIVZsYU5l5xnf8Fckfe58SKZYvUb9U+kht/aDVH1aWnnpiix2ElTOWrSP3c6NmdTrdXUHOLFz9Qnmf5LeW2YMTa/wtU6gsYeHPF5VD439CLE1m9LzMg/d3KsHccKB1o1O2LLSJeSFWAGpmDspC47meC9znskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1DzgNpRHoFzf4dvKpbaMmbYvA5S4lsH5tjMJd14ouk=;
 b=Z1OHAlo7KVub+AuJCf54nmCTqoI5J+b4qHYdftjg6VwuB0j9WTd+u6TkZmUulSYbO//579iimIHbTAPEHy7T7NGnmuAX+3TCEYRxYe4SWQ+zgUTIfk7R4RK6WxlM7ulIvd/+/OLq+1wGwp+10B7QJACni4u0qLNTQXKQCNFsehE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8917.namprd12.prod.outlook.com (2603:10b6:806:386::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:00:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 07:00:18 +0000
Message-ID: <e8926046-2e03-4224-98ba-8601de0421db@amd.com>
Date: Tue, 14 Jul 2026 09:00:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] drm/amdgpu: add an buffer funcs callback for TLB
 invalidation
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260713182732.630947-1-alexander.deucher@amd.com>
 <20260713182732.630947-5-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260713182732.630947-5-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 962a73e8-2f1d-4844-c150-08dee1759086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|6133799003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: GQXl90co+WCO8ArAdW28qkdpZY5ru0FP0ym87XeANFl9fkfnQQXfBVOEi4NtS++vt9KAZ2jza1IBmUKjqFjZU8fRoz6WI/ryp7x8jeeRKN5/YYxtoDfBs2rniq6AAzAjay0uhce2nzXxJZdwIGyQDmPw3lHrX37uK9+kw/Km6zG2GNBYAIQj7TwmHeIPvU5shayFTctN11esowOeA7LfX4JOjHZseVOo109ePdpCc9KT/06VWVTX2NJrqLuTrtk49kr0IGlSvgw1VmlcftKlzZn8WoRTRVq5+3ntze4HTiAYlV+mY7d7ZvmwrILjrSRYKm95jiXy0YKezoRUSA9hFNayYP8euJOatQYjGHF1fWihuL8TSvFeSCPolq6iWxJrIEE+VnXxfiwfnkjFgBZTcd4IYx0wU481i8zFCa8ZsjP3B0+9ByZjO0zRzeGWXAXA7qdFI/6B+CZYDU6iwpWpdZN6knO/pRByfBxDcrSWzs8Q/GrfCqWvWPY1z7556gacqkVcVdvgt/cq9ewrtIZMEz6UiOvFzzDAvnuhEfYpTl91CrTGCVBVIQ3aciMhuI9Ah8mn3h1gihTdkB8jsC0wd1ythGcbQQZvx5sE52pa2zDsSDpOdhUxFEZjgoYWeZSjnjOcFzNdqy+yFgiamQIguP+elcNfyxalc4Q3HTThJOc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTJsQUgwMjNab0dCUTM4VlFoVHVTNlZ0TTg2eis4M25wdmxWTGcwaUljMkRq?=
 =?utf-8?B?eC9jTGlZc1ptMkpEQlhSOG96QWdOSjBUdkJlbjhidXNzQ0lycE1IOFE4MW8v?=
 =?utf-8?B?NlJhZlVYanFQakZrdDVVMVRjQ1pRbmNlWUxIRzkrTko5UjNvWnQrS0dqbmZK?=
 =?utf-8?B?MkZpLzhmckErQjVXWFBBVmhlaTVCYnNrVlpQZkd4eldaSmZlRnZPOVZvV2lF?=
 =?utf-8?B?SG15ZXZMem51OUFOTzZwajc4MVlFdUpKUndkd1NLbSttazBSWVNBM3dGNGlU?=
 =?utf-8?B?YVhienJoM0V3VFZPaFNKb1dlZDQ0Qnc3dmo2M0I1TEU3UXlSNnFWYWg3SkNx?=
 =?utf-8?B?eWt3d2g1Zm84RlFUSC9xTGpMaTUwcVdLTGcwdXV2b3JqVkF2VHhJcXh0VFZp?=
 =?utf-8?B?cGFVL0IzcENzaTl4MUdxUFBCekVNOG9ha1Rkc1RGTUUzVEJjUWVxdHVGYVF0?=
 =?utf-8?B?VENkQ2lMQUo3aGkzM0lLNWdNOVEwbHpWVmY2OFExS1dBOWN4MkF1MkxTSGlI?=
 =?utf-8?B?VXVsa2NOdTlMcFdzYmxIOTRvL0p6c0o1UE9qSjhIeFFwVGRPdndFNG1zSFVP?=
 =?utf-8?B?WXlFQUtTa3doNmpldUJMTlFGbkZNeXNlaXY1T0xGclZwYkIxcWQ0Nk9YSk1I?=
 =?utf-8?B?WVNaWFR4aVdUSG1GeHJKVGtvelZOQzd5TEdNSysxMEY2R3dKdWJGaUtJRzlM?=
 =?utf-8?B?TG9QZEVCTGpxdy9MZDBSNzZRbmx2Y1NDcEk3SVpKSjJxSUwzSlFJL3puNk1m?=
 =?utf-8?B?T1NydHRHanZ5SnA0VVg5TU9WUTJGbDVVTEhSOFhBcEx5SW9GY0FHSzl5cVdT?=
 =?utf-8?B?bDZ5b1p5Z09taWU1KzRSQ1pQOE90c1BSR1J1ZEtSSHV1emI0Zm1jR1pQclk3?=
 =?utf-8?B?clJkc2VNOU9ZRW9nRGV1MUZTcldqVW8vTTkyMzN6NlVhK01ER1NGUXUrUXBk?=
 =?utf-8?B?b0lzQ0dMa1hldEZ0UVBVUzhJdVZHdEZKVTA0dHJSUnBCNzlwNGcrZnRVT1FU?=
 =?utf-8?B?VHdubkFxcUxvclNYVUZYRkEwVHBUNUh5eFdOV2FTN3ZDU21vMi9GRERiUnhK?=
 =?utf-8?B?Z2JDTHdKOTBrcitxdFNGZndybVJra2pScjN4Q0NoWldyeVFNUVRBWGt3Z0Vu?=
 =?utf-8?B?WHBIV3FRNUxsam51MUU1WTlkOExCM29OZ0MzV3k3Mzd5L25Hb201OU44aFVE?=
 =?utf-8?B?NThpMnROb0drcWN1bjlEeGR3eXZiajcyVmlOQllhb3c1a1BhdkNNeEYrVDdZ?=
 =?utf-8?B?bGlya2h0R0JmOTJvZVduMks3cC9ucGkxd3kyanI0czdvNGlLcngrRXh6SEho?=
 =?utf-8?B?aEZ6cUNGUm1rVncwV1JlSHcwZXFFTXp0NHlzQURYdkpkRjdWMjFhNFBUK3V2?=
 =?utf-8?B?QlhTZnVXR2lqekxrSDN4VmJVNllpYTcweXZsRHZDZ1lHd3VibVA3Vmk3am54?=
 =?utf-8?B?Q1Q5OURrT2lnbEk0cmlHVGJ6UzlXdG1Hc3VuSTRjaWZsbnFuZ2paMzNWZDgx?=
 =?utf-8?B?OEtPYm56RnJjb200YmpsQ0hTVTZNdmNxcGRjeWMrTGxxRGVtOTZtWHZobnM2?=
 =?utf-8?B?eVc0QWJIYnN0cXlrQmJneDJlZk9qSm1CcDZvMUpjUUEvRmlhNnBTeFBWVkp5?=
 =?utf-8?B?dWtISXVxelB1N1gyNm1hV0djWUJjNHM3SHdEMVBiS2tQblozSWJqRmsvL2do?=
 =?utf-8?B?ZHc5S2FCOEFlb3BDdmN6dm1TTDBJWE5ZdHJzT081V0xCMW1iWC8zM3A5dEdv?=
 =?utf-8?B?eTV0a2xtSmNzNHdiSFdXbWlkbnJoRmcydCsvN3VESHNvdHVZdnBGcm9VWHNV?=
 =?utf-8?B?aEQ0eXRuVGxDK0p6UUc0OXhKNUhxaEF6UHV5UFBQRlpLMlFKS09YVEF5TmRU?=
 =?utf-8?B?MlM0Wnl4VjM5YjRVUlhDTHg4Rnk2ank3czBUS2ZmSGpGbDR1U1NZdlZiSkF0?=
 =?utf-8?B?Tm5BTnVaOCtoK3VoMzZCSXRKM3hTS29HRXk5WVcwTXRHNmxJa3hxVlIrN3Np?=
 =?utf-8?B?VWxZTWpCdFZvQWRNZ1pxYk5qcHFlYjRsZ2Ric3lrbTArUXkyMDhCTGwrVnA3?=
 =?utf-8?B?MTFCazZUQ0RvaTh3OS9MRG5Wditja01XMFdDUVM3UFF5TFl1dmg1WE5qUElU?=
 =?utf-8?B?SXFFRlBpSnQrVkhHOEUxVTlIc21uTG9velluTnQrWUh5N2t3Znh6ZVA3eTdz?=
 =?utf-8?B?aEYwaWQrUzRWT1FmSlpBODFjdUVWT3pBWlMvNzJWcE1ONHBqMjcvaWRjOWFo?=
 =?utf-8?B?QUdLeFJlMGVHWHFkU0tkdzI5a1psd1pTem1wd1Y4dm1pUXljK1ZiM1lJNXlO?=
 =?utf-8?Q?HZb5stmBDp0l/g+0I9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962a73e8-2f1d-4844-c150-08dee1759086
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:00:18.7164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnnOx469KET8TmmNjwjXGVKejLw5Rn5dcbOVHStB7mBpnWbdk+Y8+LVsrYBQeX4/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8917
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

On 7/13/26 20:27, Alex Deucher wrote:
> Use this interface to issue TLB invalidations using
> SDMA.

Hui? What should that be good for?

Regards,
Christian.

> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 4f4e56022c970..4ab92d287675a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -155,6 +155,23 @@ struct amdgpu_buffer_funcs {
>  				 uint64_t dst_offset,
>  				 /* number of byte to fill */
>  				 uint32_t byte_count);
> +
> +	/* number of dw to reserve per operation */
> +	unsigned	tlb_inv_num_dw;
> +
> +	/* used for buffer clearing */
> +	void (*emit_tlb_inv)(struct amdgpu_device *adev,
> +			     struct amdgpu_ib *ib,
> +			     /* vmid to target */
> +			     unsigned int vmid,
> +			     /* vmhub to target */
> +			     u32 vmhub,
> +			     /* inv eng to target */
> +			     u32 eng,
> +			     /* flush type */
> +			     u32 flush_type,
> +			     /* XCC to target */
> +			     u32 xcc_inst);
>  };
>  
>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
> @@ -162,6 +179,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
>  
>  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
>  #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
> +#define amdgpu_emit_tlb_inv(adev, ib, v, h, e, f, x) (adev)->mman.buffer_funcs->emit_tlb_inv((adev), (ib), (v), (h), (e), (f), (x))
>  
>  struct amdgpu_sdma_instance *
>  amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring);

