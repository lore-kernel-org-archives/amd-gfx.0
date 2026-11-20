Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24715606A320
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cJYqILPZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6FF9112B11;
	Fri, 20 Nov 2026 15:11:11 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010061.outbound.protection.outlook.com
 [40.93.198.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E6DE112B11
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 15:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V367UKoYv2sZ0TKougagGbBNlNvxWCmOtD1CCbdV1KkJBFSi2EeakryPE8Lv7j9OkW7vUrTCLiB/SThhR8cjPS+T7HZzifeACAcW+pIcwKDCgAwUCUWDZqISolKDFxZUg+v9cvOP6CqwmW6uwyWXvsid61HxzeEVYmqaCH5xEbfSYpGlRJP7wAJoaljKOdd00NRyno16U2HlBPBSrwpSu0QFF63z4Wrh5xi4E3Q12klg4gmN3xSIj4k0O78GN7gif6DoEYdu8ErKHJOYP12zl2FQ7z3M8Ds/q2d8eb0NCXYI6zeNsUXbzexLjmMgeQyVruhM7mfiObl+Wcr/fQzuYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfBUYlDQTMROxjkaa6igIRBgdsOmIUEuL6MVrQInNq8=;
 b=ToaBWyjpTbDptfVQZNa4dvGOZtsku895YU1ZP4JkZpW4i7BCNwNnvfUG3vDNhkFgbtM2B47cLXssTJ0jLN16LOuaq4+O6laNh1Tu305ljsEvDWYwxnVjnKM4FJ1ngvUY/7mgLjN/E84uWiJxmd58NT3VDo84LLDZ9wmnTsIQ7H8NtTJUdpZPDljSMOPsa+cX3h41RVHhghYpS4AVN1F/QjKAyGpyJZAuOXH7PVUPxFi9UPji6q30tbdaIDni+LdGNKvboXrI8ppYPiRKIFUtQR1/TjaMX8qXI8jeCbKjTeDOco/+DjYKkwS5aMgNc6IKOwIStTEeclmF2k+JfSSczg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfBUYlDQTMROxjkaa6igIRBgdsOmIUEuL6MVrQInNq8=;
 b=cJYqILPZkbVP2NvbkwwTVd5ZFnMldJAuOL/D4+fHmBapEZL9RTEKgHYA2/NQzxx0mD4hryHxuzVssJ7Suptbdtdk29S85YXMsimq6Pc0ma8WGSoXhkH6Zmqv7ZYCk738gAeTIo/3lCWxpANUEFsFeoCHB5ROMl4Dae0P9HxWG74=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 15:11:01 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%6]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 15:11:01 +0000
Message-ID: <2c99ca3a-cc64-4206-87dd-07a24f88249f@amd.com>
Date: Fri, 20 Nov 2026 10:10:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: keep the commit padding when re-emitting
 submissions
To: Ruijing Dong <ruijing.dong@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, alexander.deucher@amd.com, leo.liu@amd.com,
 Boyuan.Zhang@amd.com
References: <20261120033850.387702-1-ruijing.dong@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <20261120033850.387702-1-ruijing.dong@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0033.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::10) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b2bd97c-4c0f-4e3e-8d83-08df47187cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|261009223027099003|3023799007|11063799006|56012099006|261026121527099003|10067099003|261028144727099003|261022105027099003|261102123227099003|261026140227099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: XaGs5I2MLZQ1MXCRr54HnX869WZAX3opHZNGAAkyQJ9HEQH3Q74zIE/RmpCpmwNVEHGJdGtDF2EI86SCGOsbLk/Q/k1FcH0YYFpkfhMNHpNjkQiKSHhHrGTLPaZg+HCZC38ajpDFycj9R4IgXnYjUuVGo3lwlSvqRKgcLdSz5+obz6njoC4HN4nxlWX9bygBPEvn9fBjm7ZqPlFgBQWEgcql/Xw3VUZZEHgwrKFsTJkzCF7+l/2ecXo8s5SRnqfvGmHtL+8ZSs7PJof8GNdJJRPAKaGNYWEJBy5f5p2194hZQai+KpH7e9zffT72D3KHjUFItr52h2zBbRxFdp5uOA3+cmZfCgv3zzdZm1sYlGablBq/WAyQDsIJapGEhFg2nrSrdNGXdhaeIDMGohOgc9kwQDWmxwtiZD98lSkAJ1yJIt73cBZB3T2m6sJZ8lMrCuVshyJJaA4Qpy3AyVw+1Or3LXJ0rUdF2XrfkD41w6O5zWE7Bgs6zyJoUDqAUpMC0J26T10zMBdKWsOHK6wfoOBEyfo+VO8QUJeptf4Ho96SJ0ZPbs5gk9IVhW3wGbtCCSnvFlMti++2LF9ou3gysFlPSqoRieaRYr9lmU9XWn9l6JYVW8Ae04QFHX1wqLC+CbT2vWzGRpGL/rUIe+QjF3rXY9NNP8uq9X/Ypg9edRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(261026121527099003)(10067099003)(261028144727099003)(261022105027099003)(261102123227099003)(261026140227099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWFHaU5JSnpGeTU0bklHNUNGWUd4UTl6emoyS0syTVMxa2g0M1Zwdi9WNktB?=
 =?utf-8?B?SFpzTDgrcHMzbWVnU3ErQ2NZSlVhSVVuU2N3WmhoVUxXNnRGRjFlei9vcWxp?=
 =?utf-8?B?TFZPRWx4V2Z0cFZiSWt0cUgwZy9qUVBYYjFUbEs2cTVtZ011dVgvakNSdStB?=
 =?utf-8?B?WHVHcko4RXVYVWNvR1NTT2pMeFB3RG11M2NMWEhHV1RZbEthZmlYemluNUZB?=
 =?utf-8?B?NDdXbkNJR2w5NWVZOXZ2R0tsS0dvY3ZTWEY2eS9YaDZTUDA3dC9VMSs5S3lQ?=
 =?utf-8?B?aXh2RkFQTjkxTkhiVU1MZFFIaGxzZi9aMkFuS1J4UGduL2pObm1uNHIyblBH?=
 =?utf-8?B?K29CQnJqeHU1cm01RHdETjdGRDBCbnFoaUQrQnJIT2c5LzVZQmlDSGw2bUFK?=
 =?utf-8?B?bTRuWVB4TzIzYkZKWHRtcTNOZmpjMi9ySmtFQkk5dkJSY2liVFNoQ2lZckNy?=
 =?utf-8?B?U0dUQ05weU5nNWxqU3dUZEhuL0RLcnVmS0l6eUN0aXpqUitJOVBWbGE4Uzgw?=
 =?utf-8?B?eDJqR0VLZTgzajB3U3R0RHRManBhdkl1N040YUVuWUh5ZVlMR0QxNE5wRUVE?=
 =?utf-8?B?a3ZkS015T1E1OVhWYjA3S2ozTEFwWUY0RFVMaUZlU1l1MUdiR1B0cHo0TmtF?=
 =?utf-8?B?cWllakIzbnJ0eUw3cGV2UzlnU25EbFl3bnppclpSR0VibEhXNFBtZ2p5dVp3?=
 =?utf-8?B?aWd0LzJUajhwVE9CUmtWUXpOWVE0ZlphY2c0WmN3eEFZU0ZhcXpFbzVCcjB1?=
 =?utf-8?B?bW5RYkhMSzR4cUdnTk5TTTVRbVFlNFkwZHZjWGlNSC94RlB1L1JTVTBZME05?=
 =?utf-8?B?citYd0RBS1VFS28yd3gzd3RWdW5jQ1NHQmtvS1NkY0NmeVVxd0t2Um9sQjFW?=
 =?utf-8?B?VmFLSW1FQWw0eG5vclBCYmNVbDVEZ29zVjlUYlNKbDNvUnVpdVgrV1BsVUZw?=
 =?utf-8?B?dHZvUUU1U0pPTWllSW5rSnVKQzkxVlJjeUZPc0J0WGNKVE5GaGExVDFkU3I1?=
 =?utf-8?B?Uk41ZFJuRHIyT0RWd0R6VVloTVMwek9VOThZWFVMenZESU1sQkRHT00yUW9k?=
 =?utf-8?B?a0l1ZlVUK2lGcG5WTWVMZWQwY0s3cGhFb3piQUtpYktMUCtlV2JWNG4wcW9q?=
 =?utf-8?B?T0RURzBTOGlTN2xuUWc1Zkg2bnNwZm0yeXlVdS9GWnRDUGtmeGZUa2JBY0h2?=
 =?utf-8?B?ZE9RV0VHSjQvTk1CSkdKbFZOOVJDcmZ4Sy9RZFFyN2xNZFZkYysvVDhDeGF1?=
 =?utf-8?B?NW1nTGoySUZubzcrWnMrYUJGWERNWG5raXY3OC92bC9nZENSaGpzenNUbC95?=
 =?utf-8?B?em9QRmpzVmRqeExPWUN5SXdSbzRRa1BZMk1seEdzam4rUy9LQWNYNzdMdWtk?=
 =?utf-8?B?NXVMWE11WkVHWnNmRFNLMDZvN0ExWmgzRWtLU2hKY1VkMVEyMmxDMnMzVjV0?=
 =?utf-8?B?SXRKbjB0OStzTHVjMmNQczlIYnVsZzh4amREVUpLS2lycFVGT3cxYy8xeDRU?=
 =?utf-8?B?QVNzZk84WU9iMEhvekhLVmUweTRucGRldEdpdlp6a05tdDdPZW5kcXRLV0Nm?=
 =?utf-8?B?bVQwaDJEcGRDaEM4ZDVaTmV1ZHdsWTlxZCt6QTJoSDVDZ0krWWlDOVRZRXAw?=
 =?utf-8?B?dm1SVHk3WkRHOVlmRFZGTEljc3NOVTg3bi9JVXJJZ0VWS3VXMGVheC9xWWUx?=
 =?utf-8?B?dlVhdGFuQ2RZMS9FMXV4RExoL1BUNXNnZFdQc3BWcmdVWWJlNTh6Q2ZaMUZ1?=
 =?utf-8?B?MTdIL2ZJd3lqYStJOTdjRmU1UE5OMHBrSEFpaEU5MHVBUjF5NVh3a1gxRXpD?=
 =?utf-8?B?UHVjNzg0Wm1EUW9jOXVwWDcyak4zZlM0MnM1N09IZDFzMGJ0OXoyUWRaWGtG?=
 =?utf-8?B?VzNuajR5RERiZk1uOGxYb2ZETWR1aXZwUEd4Nk5GbDRQNFBldDZSdWwzeGF3?=
 =?utf-8?B?RXhkdXFoQ0lSYWVCdjFPc1ZBaWZaSWFnSURETENmVWdXQ0oyLzBhSTNOeDgw?=
 =?utf-8?B?N25HRDRibjNpNlUzY2lCSnY2SjV6cXp1NFA2ZVlzTGVaWXRnYWxLNUYyeUtO?=
 =?utf-8?B?bXpIME82MWVqTU93dnBUdk9aTGJlYVNXYWxrQWY1cngxWi8rWTE0SUkvdVh3?=
 =?utf-8?B?QnB2S05PR1FOUEZxRkZURUxpN2JneGhsaWlrVEYxcHV4OE5IUjd1ZmUrbnBW?=
 =?utf-8?B?VUdNUzBPdTQ5aC8yTU1LUWh4Z05sQUN2amJ0RFcyUzRwODFDWS80dkRiLzVt?=
 =?utf-8?B?UXJGSHpJR08wTWFwNm9zSmtmL1JzUkE2MXU0T21FRThEVWM2dUFQcWx1Rmhs?=
 =?utf-8?B?U1pSZTVub0NyRTVaTjNlejFZZjRGdlNhdXY3MmVKSC9vYUZCQlByQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2bd97c-4c0f-4e3e-8d83-08df47187cda
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:11:01.3241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4zF4qD7OX0iLuL14p/rAVEA5Kbgc+RL5hyOptVwmg36DWtVmhhk2R/6srxcefTx0ynUeaZrD5FegYuuXGMLpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076
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


On 2026-11-19 22:38, Ruijing Dong wrote:
> Re-emitted submissions are written back to back without the padding
> amdgpu_ring_commit() added. Pad each one again, as commit did, since
> some IPs like VCN require every submission to keep that alignment.
>
> Fixes: a17ef941212b ("drm/amdgpu: rework ring reset backup and reemit v9")
> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
Reviewed-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  7 ++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 25 +++++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  1 +
>  3 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index c3f56253d3b8..faeaa65355ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -745,7 +745,8 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
>  		return;
>  	}
>  	ring->reemit = true;
> -	amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
> +	amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy +
> +			  (seq - last_seq) * ring->funcs->align_mask);
>  	spin_lock_irqsave(&ring->fence_drv.lock, flags);
>  	do {
>  		last_seq++;
> @@ -778,6 +779,10 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
>  					amdgpu_ring_write(ring,
>  							  ring->ring_backup[fence->backup_idx + i]);
>  			}
> +
> +			/* A job fence ends a submission, pad it like commit did */
> +			if (fence->skip_ib_dw_end_offset)
> +				amdgpu_ring_pad_to_align(ring);
>  		}
>  		rcu_read_unlock();
>  	} while (last_seq != seq);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 7b67e8cecca2..411c74802d20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -142,6 +142,22 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
>  	}
>  }
>  
> +/**
> + * amdgpu_ring_pad_to_align - pad the ring to the fetch alignment
> + * @ring: amdgpu_ring structure holding ring information
> + */
> +void amdgpu_ring_pad_to_align(struct amdgpu_ring *ring)
> +{
> +	u32 count;
> +
> +	count = ring->funcs->align_mask + 1 -
> +		(ring->wptr & ring->funcs->align_mask);
> +	count &= ring->funcs->align_mask;
> +
> +	if (count != 0)
> +		ring->funcs->insert_nop(ring, count);
> +}
> +
>  /**
>   * amdgpu_ring_commit - tell the GPU to execute the new
>   * commands on the ring buffer
> @@ -153,18 +169,11 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
>   */
>  void amdgpu_ring_commit(struct amdgpu_ring *ring)
>  {
> -	uint32_t count;
> -
>  	if (ring->count_dw < 0)
>  		drm_err(adev_to_drm(ring->adev), "writing more dwords to the ring than expected!\n");
>  
>  	/* We pad to match fetch size */
> -	count = ring->funcs->align_mask + 1 -
> -		(ring->wptr & ring->funcs->align_mask);
> -	count &= ring->funcs->align_mask;
> -
> -	if (count != 0)
> -		ring->funcs->insert_nop(ring, count);
> +	amdgpu_ring_pad_to_align(ring);
>  
>  	mb();
>  	amdgpu_ring_set_wptr(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index b2040f80b7f2..6224a9f94826 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -464,6 +464,7 @@ void amdgpu_ring_ib_on_emit_de(struct amdgpu_ring *ring);
>  
>  void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
>  void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
> +void amdgpu_ring_pad_to_align(struct amdgpu_ring *ring);
>  void amdgpu_ring_commit(struct amdgpu_ring *ring);
>  void amdgpu_ring_undo(struct amdgpu_ring *ring);
>  int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
