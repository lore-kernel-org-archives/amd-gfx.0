Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7894FC98304
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 03:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E2310F2B8;
	Thu, 24 Sep 2026 03:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XktdPOn1";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D3710F2BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 03:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMfgMvXGZ9PQJFbbRzebpzcRcruCbEtptL7E0Oy2kzE0YfHj+wzkKh8rsaVV/gtF1LvZXJ8/PPWR9I8iZhQ1xOmSUDgD38S+Ym2rGybjIEz83PEshyagFaoU6gWyVaZQKvvIX5bZugvARIcABELSckZzIVUztAmEQZpekcUmLTK5sxfs1EKF7JURj4AVen26TJsDTFzRJvJtRy4LcR1HBu6KjDslQKxhGP522yL1kbFzj7JGH+8OQD102rQmrCwq+haSYBuiKKfvjTLU97rHIlPBZw171/NGza1/wiRb875hfaPIbi0y/jms/8RV8F71A05FZnuxR+RWi0ngOdA23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ShyZsnwxwuV3fhhFiygiTUslEYyoGV2F16HLvs7Cro=;
 b=q+g027qTJn/eBm78BCjRXDGnfkKONG05l90Pj7oVm1VYitUzSPCcKG2kCOVcjDGLYNXRjLSzBRwZUZzkZtu3JlYeMZjeQCHUbDzlAB4B42KsQtXo1oz/qpD6SyCQUSY6Ipmg7eJF+j/71ujaw49Sky+Q4Vki77GQ71zgmPpuj5sSg4QS6t74EDNh/cN2ibF6zZDeSj9LpFQJeGJ7KETSckj/Ax/7Ur/XpaEL6jYY3UOI/QDAj9Vb60QX3stQsrkCKf/zWMLeV3s42W4CGcRLp+zG4QwXiXq5BhAchdXrgXgeoOE1PdnZl1ORxODCiJEmnQVieh3cDNrmRtju/i48Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ShyZsnwxwuV3fhhFiygiTUslEYyoGV2F16HLvs7Cro=;
 b=XktdPOn1+qkFHIe8Sz5epDOo6PR1mQy+44PyPaBK2p8bV7taOzEmE/xcJ6xkRyI8S/zb/ym3wtLY9EiNKy63MwyfmIoS31W5E5tHPPKFANhbn/Bb00Le2u7bks8WSCOtWV4QUNJdI3T12TkJdbg3LPRNFZwShjNnwOhZxe27co8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 03:40:31 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 03:40:31 +0000
Message-ID: <2d2ca529-5651-4257-903c-59cd3507f8b8@amd.com>
Date: Thu, 24 Sep 2026 09:10:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] drm/amdkfd: correct vram_available calculation
To: "Han, Zhen" <Zhen.Han@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Hou, Junhua (Richard)" <Junhua.Hou@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "Zhou, Tony" <Tony.Zhou@amd.com>, "Li, Chuan (Richard)" <Chuan.Li2@amd.com>,
 "Russell, Kent" <Kent.Russell@amd.com>,
 "Tudor, Alexandru" <Alexandru.Tudor@amd.com>, "Wu, Cindy"
 <Xiucheng.Wu@amd.com>
References: <20260924032211.3705774-1-Zhen.Han@amd.com>
 <DS7PR12MB8348EA535EEDD5E6EEAA62CA8D812@DS7PR12MB8348.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DS7PR12MB8348EA535EEDD5E6EEAA62CA8D812@DS7PR12MB8348.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0356.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::12) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH3PR12MB9172:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb4c4e9-3b81-45d3-4caf-08df19ed9465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aYVU1QvklVii4AMV/MKsxIAA4SFEJbrrJzsLOfc8dqdph+rU09+RsTYFE7Hz+Xw6H8NiuOP/dwYa2BFvagIucIP0V/8RuQVwpsoWWP/Xq2rjBZ/b7qi7iwIrHnZy+0Z1kS6RFCf9+5HxaE3XNsMdc1vveEbksvu4zMvwsXn4VzaK1DcOOGD/0N1Fhg++gMPwP/Z6IYZ5dX3j7r3Y+fQNJb+qXp8P3XYO6e6peRcJ2VyU/mu4TX6mJgQNtIkx8lPGYMOoBQmol5RFqvyOLt+oMvu8QsGIXIkdWy5X7+0eqbtjZmBGca/xHHlVZi1X9rLPdNsX9kQUFjblgheS72STkAFLzvrrp+2JvKxe9pSOWXQbvUq2oBAmlo1CPApnL7OtMfzieJf7pw/Ftu+ilTBr4WcziEhkxuEkZO5vXGyWKUoSxTiCCks7rodg884b3SFC8taz4jYpZNK7g293I2yw/jCEhLnighgMuDnmyHUvXVGCvXfituVJSqZDXLPe9aPMMlZ5EyDLISEkMFmLkODYej3elZ7I99Ey7AmM542u28zXOp6Wl1hgUBRb+e6y9jMGOjiS/rPe9eUxsvfW/S7nN+HjGKe8kg8LrXvDLK86lOrFyfWQuJU7rXRkLzz/ki1fdrxFHvTvlAZVP/lnFzlTzWnfktk1dTlQ5HpPoPFmicw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODAwcTFEU1g4NlB3eHRHcVNWcXR4K0Z4cy93aDJVVDlrbFE1OFFTaDdYcS94?=
 =?utf-8?B?N3l2SXBOamxlS25vLzlTUThiK25DT21kVUVSdTB0WHVrYmlxWGNJRUd3N3BS?=
 =?utf-8?B?SDZDdUxiaVVFdjV6cTk3WlM5SmpPMjFXYUR6TEtEN1FiOUE0MmtrSytsemZE?=
 =?utf-8?B?Yk9uTFJ5VitqcFdhZFZVRjlIdWlqSWNUNXpVa09FSXd4bjk3c2ZTK3Mvd3Q2?=
 =?utf-8?B?aTl2akZGYUMvNnFXYW5jQjhNSUVLWWNrSWlBN1Q5VVRlcnNUU05qSXF4UGQ0?=
 =?utf-8?B?dml3VUJ5WThRMjFGZkZVT0RHV3VKNmxBNThFVnZqd2hxY2RLZDliU2IwckM0?=
 =?utf-8?B?dHg5bWxhZHpkN3VEb3VXenNVcmZkRnZVdUJxMmsxYVVrVTJFWXcvMnZUNktT?=
 =?utf-8?B?aWhUSm5kdTd1VG54QmlxVWUwam5yNVVXOUtzNHRLT0VER0t6azB0SXYzbjk5?=
 =?utf-8?B?eUFjS0laTHY1VzFPR0ZvbGhUd3Ftd0dxdFhvYkpDc3VMcjdjeHR3aTk1RE50?=
 =?utf-8?B?d2JBVllyVU54TUpnbzdPVmpDSGs4MTZVYVRQUXZ5L0h0b29VRExVQXFvWHRI?=
 =?utf-8?B?ODNwc3hITTBYcm41Qm5JSFNrYndQNk9QZzlDRkdMWW8vODJUT1V0bk5lOTVT?=
 =?utf-8?B?SSt6MUFzMXhnSXFWN28rREE5cXJ3cGcxdWQ5cUlaUDRsaDRJOFMzL01QYmFx?=
 =?utf-8?B?WGNRZXhXclR5Ky9vTjkwNzdlWUdOR2ZjOFhPa3h2WnJVeUVwRTFmU1lKNTM3?=
 =?utf-8?B?bFVlcVVQcFFmTDZUMExZR3p2TVMyaytuWm5nQk50dTdRYi9tL3c1MTdmUFB4?=
 =?utf-8?B?NkMvQUFKaGFTcFkvWkhqSHlrL1pFWmp5ellkS0EvL0ZqbDNGdkk0cDJXV2V3?=
 =?utf-8?B?Y3RqQ21IYm1IYkNUNkxJeG9oNVBVeUlXdkhuTStYUi9veXZrK2ROVnB5ZUVB?=
 =?utf-8?B?M21YZVBDTU0vWVlLdjlpRlJhSmY0dEVUQVFsQjJLcXVudjR2Y29uZFJLOHhv?=
 =?utf-8?B?akIzUmlDaUpBZ1RtRVp6Tkt3ZDhSM0NyNFFYemVteHRoZElJK3ZYY1NyTkZz?=
 =?utf-8?B?MFhCUTBhR1RoNzFnYlFPT0hpMjBBbGs5TXBGZ1hMcFRhOFh2NjlHaUNLL0hQ?=
 =?utf-8?B?M3VYU0FGTXh2bzY5ZlNqTHZyV1A0MVNFNy94QjFKTmo3TjVoMlUvSGZWVW14?=
 =?utf-8?B?Rk9FTi90dVkrb2NMVVEvVUtOOVdGRXVtb3plc2Q5Z0Z6dmI0Y2ZPSWdUNjRl?=
 =?utf-8?B?RXA5ZGQvNG1DOTZEZHdXUEZrQWVUeGdvdnkyWGVoeStJdTNISEI5azZzOHA0?=
 =?utf-8?B?WHV0NVByVWNkMjEwY3cwZlZzcmI3dTRhQ0E3ZzRGWHp3RDFCUXRtaXlMSmU3?=
 =?utf-8?B?dFoweldGeEFGN0hueVBiNTBtajdLRzBXM2dhUmxObHlXeGh6aThCQnBlQ3p1?=
 =?utf-8?B?NnlJVFkrcDZDWUtYMGxjMWlhNGRSSklaTjRPSWZTbFdMQzdLUzNmOFFuWjVl?=
 =?utf-8?B?YmE1c3owY1dSZ2JPUWRTelZTTm91K0Z5dzRnQ0ZmM3M5REhSK3RDWTFHdzU1?=
 =?utf-8?B?anE3ZFV0aFJ0enlSWWdaVXFkbWFxa0FubXhJMG5ZeEdoMENkMWhXYVJZVjJG?=
 =?utf-8?B?Q0JPZXFZbnNyMmlrTnhjT09wZy9GamYyd0o3TDR1M21INHZKaU1KNFpOTEV4?=
 =?utf-8?B?Z3dRQ21LK2R0YWtqTmlsT3RiU2ZQQlpzM25aWGx4UDUxS0VrSkFLY0RDdUxm?=
 =?utf-8?B?Yy9WMkcwdnlTUUU1OElsR2tjU2dTbEFqTzBBaG9GT011Q1BDNUhUY01Fb1ZF?=
 =?utf-8?B?dnhBMUtyMVpibm5aSXcra05lWVJ6RlN6YXhxYmVqVlA0OUR6TE9uSE1LNEJY?=
 =?utf-8?B?a3k1RGhkanp1amdZcHgrRHE2Qm4wamtwUzRwNzBMMHh2TzA3bHlHMjVmN0x1?=
 =?utf-8?B?Ymk4cmE5NElnWFdzanpud3F5N1ZXaEpjdGF6L21xRWt0MVFBSU84RE8ydDRK?=
 =?utf-8?B?ZzhRclVob2l6WmtFMnRiWC9XTmp1SERhVlltSkl5Nk5YMEpPSEpXaDNqYjVl?=
 =?utf-8?B?ampJc3VQOGdQTS81ZE1ldVVhd1d1dkdDNTdyblluQ1FEMmtsbDlzYVNZSzJN?=
 =?utf-8?B?SHFoVW9uQUk5alFsTUZtZnd6NUxrU3F6bUlmRGJoZHZYSU9BMEN1TjE3d0cr?=
 =?utf-8?B?bW5SM2tsUVpCZ2diUkk3OUJ6SWE4RlBCS2Z0eU5NSStvY3VnOEMrOGpDZlA4?=
 =?utf-8?B?ZmRwMlA5UlVnNjJWSlhmc2tmRk1DWnVRTXJZeFRLN1VCTnRTMEZhOWZMTHN3?=
 =?utf-8?Q?qSAgMvRADBU8vSxoa4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb4c4e9-3b81-45d3-4caf-08df19ed9465
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 03:40:30.8219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unzozDkTzZpHENUBb+j9AdR20GeXCpiXtQQd9c/djEfYDc0GNEKqX2uSZ31A2/CD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172
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



On 24-Sep-26 9:00 AM, Han, Zhen wrote:
> AMD General
> 
> reserve_mem_limit() computes available VRAM as
>          vram_size - reserved - vram_pin_size - kfd.vram_used However, kfd.vram_used already includes BOs that are later pinned.
> Pinning does not consume extra VRAM. Subtracting vram_pin_size counts those bytes twice and causes fake-OOM while VRAM is still free. A KFD BO reaches the VRAM pin path through the P2P dma-buf export, through the dma-buf vmap and through map_bo_to_kernel().
> 
> Reuse get_available_memory() in reserve_mem_limit(). Move ALIGN_DOWN to the ioctl so the userspace ABI is unchanged. The VRAM counter is a parameter: the ioctl passes vram_used_aligned[], the gate passes vram_used[] so a 4K BO is not charged 2MB.
> 
> kfd.vram_pinned is only updated in gpuvm_pin_bo(). dma-buf pin calls amdgpu_bo_pin() only, so the counter stays zero. Update it from amdgpu_bo_pin() through a KFD helper, on first pin and last unpin, matching vram_pin_size.
> 
> Track per-XCP pins in vram_pin_size_xcp[] and kfd.vram_pinned[].
> Pins that are not owned by a single partition go to vram_pin_size_common, which every partition subtracts.
> 
> A KFD VRAM BO always carries a partition, so the KFD credit is only correct for xcp >= 0. Call the helper for both branches and let it warn once and skip if that ever stops holding: without the credit the BO would be subtracted through vram_pin_size_common and never added back, which is the double counting this patch removes, and kfd.vram_pinned[] would be indexed out of bounds.
> 
> Signed-off-by: Zhen Han <Zhen.Han@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
> v6:
> - rebase v5 on patch 1/2, which adds kfd.vram_pinned (Mukul Joshi)
> 
> v5:
> - add the kfd.vram_pinned[] counter. v4 read it in get_available_memory()
>    but it does not exist in the tree (Mukul Joshi)
> - track pins per XCP in vram_pin_size_xcp[]; pins with no partition go to
>    vram_pin_size_common (Philip Yang, Lijo Lazar)
> - pass the VRAM counter into the shared helper: the gate uses vram_used[],
>    the ioctl vram_used_aligned[]
> - WARN_ONCE if a KFD BO reaches the VRAM pin path with xcp < 0 (Tony Zhou)
> 
> v4:
> - use get_available_memory() in reserve_mem_limit()
> - move ALIGN_DOWN from get_available_memory() to the ioctl
> - drop v3 extra call in amdgpu_dma_buf.c
> - update kfd.vram_pinned from amdgpu_bo_pin() via a KFD helper
> 
> v3:
> - update kfd.vram_pinned from dma-buf pin/vmap and gpuvm_pin_bo
>    on first pin / last unpin in amdgpu_dma_buf.c
> 
> v2:
> - keep vram_pin_size; add kfd.vram_pinned in reserve_mem_limit (Mukul Joshi)
> - leave get_available_memory unchanged
> - drop former 2/2 pin/unpin changes in amdgpu_object.c
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 11 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 20 +++-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 94 +++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 33 +++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 12 ++-
>   5 files changed, 127 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 79b69d74eb2e..04151eab3b3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -839,8 +839,17 @@ struct amdgpu_device {
>          struct mutex    mn_lock;
>          DECLARE_HASHTABLE(mn_hash, 7);
> 
> -       /* tracking pinned memory */
> +       /* tracking pinned memory
> +        *
> +        *      vram_pin_size = sum(vram_pin_size_xcp[]) + vram_pin_size_common
> +        *
> +        * vram_pin_size         total pin size in device
> +        * vram_pin_size_xcp[i]  pins owned by partition i (bo->xcp_id = i, i >= 0)
> +        * vram_pin_size_common  pins not owned by any partition, bo->xcp_id = -1
> +        */
>          atomic64_t vram_pin_size;
> +       atomic64_t vram_pin_size_xcp[MAX_XCP];
> +       atomic64_t vram_pin_size_common;
>          atomic64_t visible_pin_size;
>          atomic64_t gart_pin_size;
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 056dd7375d24..f462b40220eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -42,6 +42,12 @@
> 
>   extern uint64_t amdgpu_amdkfd_total_mem_size;
> 
> +/*
> + * Align VRAM availability to 2MB to avoid fragmentation caused by 4K
> + * allocations in the tail 2MB BO chunk.
> + */
> +#define VRAM_AVAILABLITY_ALIGN (1 << 21)
> +
>   enum TLB_FLUSH_TYPE {
>          TLB_FLUSH_LEGACY = 0,
>          TLB_FLUSH_LIGHTWEIGHT,
> @@ -106,7 +112,7 @@ struct amdgpu_kfd_dev {
>          struct kfd_dev *dev;
>          int64_t vram_used[MAX_XCP];
>          uint64_t vram_used_aligned[MAX_XCP];
> -       atomic64_t vram_pinned;
> +       atomic64_t vram_pinned[MAX_XCP];
>          bool init_complete;
>          struct work_struct reset_work;
> 
> @@ -391,6 +397,8 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>    * Allows KFD to release its resources associated with the GEM object.
>    */
>   void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
> +void amdgpu_amdkfd_account_vram_pin(struct amdgpu_bo *bo, int xcp_id);
> +void amdgpu_amdkfd_account_vram_unpin(struct amdgpu_bo *bo, int
> +xcp_id);
>   void amdgpu_amdkfd_reserve_system_mem(uint64_t size);  #else  static inline @@ -408,6 +416,16 @@ static inline  void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)  {  }
> +
> +static inline
> +void amdgpu_amdkfd_account_vram_pin(struct amdgpu_bo *bo, int xcp_id) {
> +}
> +
> +static inline
> +void amdgpu_amdkfd_account_vram_unpin(struct amdgpu_bo *bo, int xcp_id)
> +{ }
>   #endif
> 
>   #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 5a4072792a57..34cd791d826e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -46,12 +46,6 @@
>   #define AMDGPU_USERPTR_RESTORE_DELAY_MS 1
>   #define AMDGPU_RESERVE_MEM_LIMIT                       (3UL << 29)
> 
> -/*
> - * Align VRAM availability to 2MB to avoid fragmentation caused by 4K allocations in the tail 2MB
> - * BO chunk
> - */
> -#define VRAM_AVAILABLITY_ALIGN (1 << 21)
> -
>   /* Impose limit on how much memory KFD can use */  static struct {
>          uint64_t max_system_mem_limit;
> @@ -73,6 +67,8 @@ static const char * const domain_bit_to_string[] = {  #define domain_string(domain) domain_bit_to_string[ffs(domain)-1]
> 
>   static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work);
> +static size_t __get_available_memory(struct amdgpu_device *adev,
> +                                    uint8_t xcp_id, int64_t vram_used);
> 
>   static bool kfd_mem_is_attached(struct amdgpu_vm *avm,
>                  struct kgd_mem *mem)
> @@ -169,13 +165,8 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)  int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>                  uint64_t size, u32 alloc_flag, int8_t xcp_id)  {
> -       uint64_t reserved_for_pt =
> -               ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> -       struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> -       uint64_t reserved_for_ras = (con ? con->reserved_pages_in_bytes : 0);
>          size_t system_mem_needed, ttm_mem_needed, vram_needed;
>          int ret = 0;
> -       uint64_t vram_size = 0;
> 
>          system_mem_needed = 0;
>          ttm_mem_needed = 0;
> @@ -196,7 +187,6 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>                  if (WARN_ONCE(xcp_id < 0, "invalid XCP ID %d", xcp_id))
>                          return -EINVAL;
> 
> -               vram_size = KFD_XCP_MEMORY_SIZE(adev, xcp_id);
>                  if (adev->apu_prefer_gtt) {
>                          system_mem_needed = size;
>                          ttm_mem_needed = size;
> @@ -232,14 +222,11 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>           * VRAM check since ttm_mem_limit check already cover this allocation
>           */
> 
> -       if (adev && xcp_id >= 0 && (!adev->apu_prefer_gtt || adev->gmc.is_app_apu)) {
> -               uint64_t vram_available =
> -                       vram_size - reserved_for_pt - reserved_for_ras -
> -                       atomic64_read(&adev->vram_pin_size);
> -               if (adev->kfd.vram_used[xcp_id] + vram_needed > vram_available) {
> -                       ret = -ENOMEM;
> -                       goto release;
> -               }
> +       if (adev && xcp_id >= 0 && (!adev->apu_prefer_gtt || adev->gmc.is_app_apu) &&
> +           vram_needed > __get_available_memory(adev, xcp_id,
> +                                                adev->kfd.vram_used[xcp_id])) {
> +               ret = -ENOMEM;
> +               goto release;
>          }
> 
>          /* Update memory accounting by decreasing available system @@ -318,6 +305,30 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>          kfree(bo->kfd_bo);
>   }
> 
> +void amdgpu_amdkfd_account_vram_pin(struct amdgpu_bo *bo, int xcp_id) {
> +       if (!bo->kfd_bo)
> +               return;
> +
> +       if (WARN_ONCE(xcp_id < 0, "KFD BO pinned in VRAM with no partition"))
> +               return;
> +
> +       atomic64_add(amdgpu_bo_size(bo),
> +                    &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned[xcp_id]);
> +}
> +
> +void amdgpu_amdkfd_account_vram_unpin(struct amdgpu_bo *bo, int xcp_id)
> +{
> +       if (!bo->kfd_bo)
> +               return;
> +
> +       if (WARN_ONCE(xcp_id < 0, "KFD BO unpinned in VRAM with no partition"))
> +               return;
> +
> +       atomic64_sub(amdgpu_bo_size(bo),
> +                    &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned[xcp_id]);
> +}
> +
>   /**
>    * create_dmamap_sg_bo() - Creates a amdgpu_bo object to reflect information
>    * about USERPTR or DOOREBELL or MMIO BO.
> @@ -1537,10 +1548,6 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
> 
>          amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
> 
> -       if (!ret && bo->tbo.resource->mem_type == TTM_PL_VRAM)
> -               atomic64_add(amdgpu_bo_size(bo),
> -                       &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
> -
>   out:
>          amdgpu_bo_unreserve(bo);
>          return ret;
> @@ -1564,10 +1571,6 @@ static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
> 
>          amdgpu_bo_unpin(bo);
> 
> -       if (bo->tbo.resource->mem_type == TTM_PL_VRAM)
> -               atomic64_sub(amdgpu_bo_size(bo),
> -                       &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
> -
>          amdgpu_bo_unreserve(bo);
>   }
> 
> @@ -1671,8 +1674,9 @@ int amdgpu_amdkfd_criu_resume(void *p)
>          return ret;
>   }
> 
> -size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
> -                                         uint8_t xcp_id)
> +/* Caller must hold kfd_mem_limit.mem_limit_lock. */ static size_t
> +__get_available_memory(struct amdgpu_device *adev,
> +                                    uint8_t xcp_id, int64_t vram_used)
>   {
>          uint64_t reserved_for_pt =
>                  ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> @@ -1681,15 +1685,17 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
>          ssize_t available;
>          uint64_t vram_available, system_mem_available, ttm_mem_available;
> 
> -       spin_lock(&kfd_mem_limit.mem_limit_lock);
> +       lockdep_assert_held(&kfd_mem_limit.mem_limit_lock);
> +
>          if (adev->apu_prefer_gtt && !adev->gmc.is_app_apu)
>                  vram_available = KFD_XCP_MEMORY_SIZE(adev, xcp_id)
> -                       - adev->kfd.vram_used_aligned[xcp_id];
> +                       - vram_used;
>          else
>                  vram_available = KFD_XCP_MEMORY_SIZE(adev, xcp_id)
> -                       - adev->kfd.vram_used_aligned[xcp_id]
> -                       - atomic64_read(&adev->vram_pin_size)
> -                       + atomic64_read(&adev->kfd.vram_pinned)
> +                       - vram_used
> +                       - atomic64_read(&adev->vram_pin_size_xcp[xcp_id])
> +                       - atomic64_read(&adev->vram_pin_size_common)
> +                       + atomic64_read(&adev->kfd.vram_pinned[xcp_id])
>                          - reserved_for_pt
>                          - reserved_for_ras;
> 
> @@ -1704,19 +1710,29 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
> 
>                  available = min3(system_mem_available, ttm_mem_available,
>                                   vram_available);
> -               available = ALIGN_DOWN(available, PAGE_SIZE);
>          } else {
> -               available = ALIGN_DOWN(vram_available, VRAM_AVAILABLITY_ALIGN);
> +               available = vram_available;
>          }
> 
> -       spin_unlock(&kfd_mem_limit.mem_limit_lock);
> -
>          if (available < 0)
>                  available = 0;
> 
>          return available;
>   }
> 
> +size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
> +                                         uint8_t xcp_id)
> +{
> +       size_t available;
> +
> +       spin_lock(&kfd_mem_limit.mem_limit_lock);
> +       available = __get_available_memory(adev, xcp_id,
> +                                          adev->kfd.vram_used_aligned[xcp_id]);
> +       spin_unlock(&kfd_mem_limit.mem_limit_lock);
> +
> +       return available;
> +}
> +
>   int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>                  struct amdgpu_device *adev, uint64_t va, uint64_t size,
>                  void *drm_priv, struct kgd_mem **mem, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index fc6d3fa62d79..dc0ab5bc467f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -923,6 +923,19 @@ void amdgpu_bo_unref(struct amdgpu_bo **bo)
>          *bo = NULL;
>   }
> 
> +/* Map a BO onto vram_pin_size_xcp[]. bo->xcp_id < 0 means "any partition":
> + * such pins are not owned by a single partition and go to
> + * vram_pin_size_common, which every partition subtracts.
> + */
> +static int amdgpu_bo_get_xcp(struct amdgpu_bo *bo) {
> +       s8 xcp = bo->xcp_id;
> +
> +       if (xcp >= 0 && xcp < MAX_XCP)
> +               return xcp;
> +       return -1;
> +}
> +
>   /**
>    * amdgpu_bo_pin - pin an &amdgpu_bo buffer object
>    * @bo: &amdgpu_bo buffer object to be pinned @@ -1003,7 +1016,17 @@ int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain)
>          ttm_bo_pin(&bo->tbo);
> 
>          if (bo->tbo.resource->mem_type == TTM_PL_VRAM) {
> +               int xcp = amdgpu_bo_get_xcp(bo);
> +
>                  atomic64_add(amdgpu_bo_size(bo), &adev->vram_pin_size);
> +               if (xcp >= 0) {
> +                       atomic64_add(amdgpu_bo_size(bo),
> +                                    &adev->vram_pin_size_xcp[xcp]);
> +               } else {
> +                       atomic64_add(amdgpu_bo_size(bo),
> +                                    &adev->vram_pin_size_common);
> +               }
> +               amdgpu_amdkfd_account_vram_pin(bo, xcp);
>                  atomic64_add(amdgpu_vram_mgr_bo_visible_size(bo),
>                               &adev->visible_pin_size);
>          } else if (bo->tbo.resource->mem_type == TTM_PL_TT) { @@ -1036,7 +1059,17 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>                  dma_buf_unpin(bo->tbo.base.import_attach);
> 
>          if (bo->tbo.resource->mem_type == TTM_PL_VRAM) {
> +               int xcp = amdgpu_bo_get_xcp(bo);
> +
>                  atomic64_sub(amdgpu_bo_size(bo), &adev->vram_pin_size);
> +               if (xcp >= 0) {
> +                       atomic64_sub(amdgpu_bo_size(bo),
> +                                    &adev->vram_pin_size_xcp[xcp]);
> +               } else {
> +                       atomic64_sub(amdgpu_bo_size(bo),
> +                                    &adev->vram_pin_size_common);
> +               }
> +               amdgpu_amdkfd_account_vram_unpin(bo, xcp);
>                  atomic64_sub(amdgpu_vram_mgr_bo_visible_size(bo),
>                               &adev->visible_pin_size);
>          } else if (bo->tbo.resource->mem_type == TTM_PL_TT) { diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 7fcfc150a7fc..2295f9bcc5e4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1069,11 +1069,19 @@ static int kfd_ioctl_get_available_memory(struct file *filep,  {
>          struct kfd_ioctl_get_available_memory_args *args = data;
>          struct kfd_process_device *pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
> +       struct amdgpu_device *adev;
> +       size_t available;
> 
>          if (!pdd)
>                  return -EINVAL;
> -       args->available = amdgpu_amdkfd_get_available_memory(pdd->dev->adev,
> -                                                       pdd->dev->node_id);
> +
> +       adev = pdd->dev->adev;
> +       available = amdgpu_amdkfd_get_available_memory(adev, pdd->dev->node_id);
> +       if (adev->apu_prefer_gtt)
> +               args->available = ALIGN_DOWN(available, PAGE_SIZE);
> +       else
> +               args->available = ALIGN_DOWN(available, VRAM_AVAILABLITY_ALIGN);
> +
>          kfd_unlock_pdd(pdd);
>          return 0;
>   }
> --
> 2.43.0

