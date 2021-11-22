Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D09C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 16:26:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F33E189DA4;
	Mon, 22 Nov 2021 16:26:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE21589DA4
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 16:26:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEN+F/jJYmnyH4ZnfU7AXsIEfi98ZFRYzixz4/R4QAQdqHrIXa6VgK6nWd+d6j33CRLzm2+ONCdK/5StpT+do8M237S2QgyveCtkhCnkw1ngii3qXr0oSPYWjb2j133uUGoIXtsd+rNW8Opzjskj8zhHjqYipnq29ahmPvi1nAb8eBn+Ng4H25xxPkUgU0ElMT7cyt4nF/zcoTwES1CZRjiInsNcr+U9HF6QSGU22Tziq8h6QsaIDjS2ZD5cv95RJzlUsSD+3gZQ7Koz5TLF8BumcRnOjrMuDMeDmCSmK8Dx5Pxur/U9yThjpK4fK1CpRLmn85LwRY+iPDbuM1BrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtBnj+m5zoztEPsco6N967F6dbe8czQdqRU9Oj1nreo=;
 b=BUw4Se7xAJxewRvYdX4NqlIXmBRqrMxm3Fwyba1FLWo2L59vg0X5AtMgB+Zojjauo2wr/1Gil7jbC0twlUQZU1U+qWotYgGqiNedFJTobldCyfi8+DRzmwKln8il6oFxu9EMGDsTEgbYuwyuio3SbjEr5sDM3jbHvqan79bNLDgNhVtnXQg/aLKmbMBGhGzu2u91ly3Stv/1PLvmrEcX39s0wNRrevu3Sc0YB6gNaFFM4Y/qp5IDrYjQ2yb/mqX0Xno80LUXsy08JjEiHbcX1wq1t84zzTaWLGAxGf1w9MrMZamNufaSv4+qb8VGAhW3VWBSK2PWdTLczTCcBqaDnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtBnj+m5zoztEPsco6N967F6dbe8czQdqRU9Oj1nreo=;
 b=GiZ27VjhnKmHWr86zOwvD2ppC+pC0CsHvifPY910xYTR3sw/NzczrAj8Af6zhiRROLiXXPYMr6Nirk7IVr2SwwD7Xi7RSblmhpG53CjMtYbfWE2MqGKMrF4Q2YAsb4PFloIqmzBruQCtGpHlPQ+H7C4czt+Ei+4qKVbCT7ls1LI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 16:26:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 16:26:00 +0000
Subject: Re: [PATCH v3] drm/amdkfd: handle IH ring1 overflow
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211121025840.4839-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <d80d3203-1ebc-1334-3779-8a25175a969e@amd.com>
Date: Mon, 22 Nov 2021 11:25:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211121025840.4839-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT1PR01CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.20 via Frontend Transport; Mon, 22 Nov 2021 16:25:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95b7e93b-fd4a-45ad-0537-08d9add4c4f4
X-MS-TrafficTypeDiagnostic: BN9PR12MB5083:
X-Microsoft-Antispam-PRVS: <BN9PR12MB50834C334F44C1399EB6D5DB929F9@BN9PR12MB5083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JD+7cgJVTRpwt8PDr2GBpAqRT1hjJ3OYXPdsBp6/H1IjsXYpMKKJfVYM+85M+g9tlHUQJKfUEqIwd7XApdz94byJ2m0xJfyZK7Pkk8TpdJ0a5MZX9/G4XEi8FBj1q2uaqHnT6+Fxv4kVjvvEGc+a6zwQ8maiwkBgb7HKubDSfvR1os1Jmic3wP2QmQGMyyU1NL9Lv3lRv7mZdFlChYmCpB2FeHcJan49BMQzJr2yyXMCkNjIKJ2SH6Xtq6IYVLkwjKub9Hq0QAHMrV1WLZuxpmIiz6t98zszv3HfCbUooo9r3ZhRxWCeKYVjzU17zgwA3e/5ZOglF0Y3xFKP+Zva50BNF6j/boLXLRbghicisQRBeQssOAX8DAFkX3gXPEEgPtQ5NP6UqlaPT8Tge6MnKyhxB6wbs/zsUzQOPi3POscqgLHSxQ8UndFRr0+JU5wZasoGvW87+2TcqmNd9Ruu2QL/hUIM6OS0tLCBAC6uxGVCNkc++QoKS8J8te+ccmLzOzQ/Bzo+1he2e9N3pCMwF0fhTM8JA3ZCkJ3Q5QpSnZelgqj/Dz6q3cRkZX0WvxdKz30qFu+JSHBIgxx52paOp6gFCkT1x1jNFEt4As3x23OtbSz8v4UnmPZ3rNMOiwMsTAMj9KAXO0ZGQ5ytmfJQAr1SWJ7urpuRk9Uq/Uh5+dOgZXjAL2XoAKdH7Uiz9Q1QA3N//bjZyfW1beUbzDNffB8EJt/pY5VFdKExvj5DLS/+J9LNDCU5Ltlkr8saIau1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(36756003)(508600001)(6486002)(31696002)(2906002)(8936002)(66556008)(956004)(66946007)(30864003)(2616005)(83380400001)(38100700002)(66476007)(16576012)(316002)(4001150100001)(31686004)(26005)(4326008)(186003)(44832011)(5660300002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEFpOEhlWVRERkRsYzlFYkd1MlEvZkoySkhTVXoxT2hERGl4QjhjaGJ4K1lL?=
 =?utf-8?B?K3AyT1lsT2xmSnFUeXNnWDJmRW1HTFBpUlZzUWloMWRUVVMrMDBNQWh2MmhC?=
 =?utf-8?B?Qk1kdm1DenVOTWlxNUU5ZXJ3U2JSd0RxcWVYV3VSRWxkdzJiL0dNVVBGN09P?=
 =?utf-8?B?WXNOQXAzSHNZK01JenZ3ckJiYk55Y1RhVlZJMlg2SUVpTHRhZytTSEJQdk9C?=
 =?utf-8?B?eW8xc3E2U0pwL0JpOUxjNi8zQzhweFZ1WUdjbjE1T3lrRVBtSldIZGJ0K0Vv?=
 =?utf-8?B?djZYSTBIbzJLVURXbzN0aFJWdzhrZnVDNkROMXExWDBBcVNmbHhEV1NKcUFW?=
 =?utf-8?B?eGxIMGNPVVV6bVVTcFYxVEZMTXBtbmRIMURET2l5VW9aTWxiN2JGZWdOQXhq?=
 =?utf-8?B?L0VDVnlJS29xdVBBbHVGSytjT0czSFA1ZTZtYXMyOTh4Y1hQc1o5OUErZm5k?=
 =?utf-8?B?U0NHaVEzM2pueUYyRWNab2VYVStIVnk1eGk2SzZrSWUxQWJKNlhUQ3ZvUTE2?=
 =?utf-8?B?aXEwaUV1RExBWHEreDFkSWpMazkxTFk4MCtrcTZnRGlsZkE2ekN1WFMyK25P?=
 =?utf-8?B?OTE3NHUwckUwb2xuNFNkSzBMWDhHN1RJeEZZU0hwWkc2czBMOXAzaXl4MXVI?=
 =?utf-8?B?WUJhS2VmWGhxdWxzbHYwY0g0WHN4K2JXOGxocS8rTGZCVFB4QkNMd0F2akE0?=
 =?utf-8?B?ZEV4bFhxaGVCSGV6Tlo0RndxNWpwQkVVUUl5OUhidlJFN2lNeGorYnh5ZlJO?=
 =?utf-8?B?bGl5YkYxMDdERDJFZGxjVm1ndGUycHM4eCtBazl5NWt2SHZpcWRuUEJGQXNr?=
 =?utf-8?B?bVYyS1RiTWUwck9zYjFaUWlCRWRWNHc4U0VzSU1zK1VvNWI5aCthVVd4dkVW?=
 =?utf-8?B?K3pudzJPMFc1Yk9acWZqQmptOU9COGtTVnQ5Z1dBdW1oS3d4a215R1hiOW56?=
 =?utf-8?B?bk5SOCtSV0lnaUNMczg3SUhNNlMxSUR2Q0dSd1ArSXExU1piblg4WjdtVlNy?=
 =?utf-8?B?VU1QRUtMQmw5ckhVb2NsR0VhT2g4ZGxiSkEzOUpCcEcyeTNEblVuanlrZjhD?=
 =?utf-8?B?NTlZRlhvL3BtcVRkRE5LaDhhM1Y5UE1ETFkxcE13TTdWbWxqZUxINWdySk5X?=
 =?utf-8?B?UHlQZHVnSkJ1clQ3UE16SDkvS0dBUVkzeWVVRS95ZDZrS3pZYlB6V21WYnVO?=
 =?utf-8?B?MC9BNWVNSE5hUUFsRUZKdndrRTBDbkZyZDlsc0dkVklndU0vUHFDazcxbllX?=
 =?utf-8?B?Z1F0ejJ0ZGFha05CNW5NR2pIYzRkUDFBSHVLYXY0aWZXWWE5U0hvc0ZodFlm?=
 =?utf-8?B?djBvelNWNGl4RUt1WlpmZXV5SmVYdUZNKy9vK2h1Y3NhWEJIc29GS1VVRTJU?=
 =?utf-8?B?ZWJXWDVtSUJHTnR1RG5zbWVCNFJZV3p1dk0vOHlYbVJnR3BjUUZzNTNuN0tn?=
 =?utf-8?B?a3NkcEZzVTNxWnN5Tjd6dHRIYkpWTHovOTBCSitTOXRhaEpJLzI1MDVCcnMy?=
 =?utf-8?B?MDI3Y2Rxcm1Dckh0aC9BUTFheGFva1p0bE5qZjhIZFZtRU5OcXlSWHVJbFB0?=
 =?utf-8?B?bjlVNU94cnBEVHBwWS9oYTVIcUpYNFZYckNVYWd4RHFwT2hzcWlNdy9UVGpM?=
 =?utf-8?B?bDhUTzZLOVJYWURSWjN0QkJJUDBxZnpCSXIxbGVTU0lSN0JJVDJyVER6Tk1M?=
 =?utf-8?B?MEwrZTNSYVMxenJiczB5azl3ZDJHNUk5NlhuaFhWeXpzZTA5SGpuUGlyTlp2?=
 =?utf-8?B?WmtNcE5VZ1pmR2FvMzFhTHhWZXJ0MUo2di9aVC9QajBlemkxY0wvczdyMWxm?=
 =?utf-8?B?V2hyMnI2RSt4d0pKMG5WNFRrV1o4bmdFWExJRlc0cmlDY3h2OXJtaTJKYmQ5?=
 =?utf-8?B?Sys5SlVKQk1LRnNicHYrbXloV3NHSTFYV2U0ajkxYWIyOGxSYlBGTHg2Umxy?=
 =?utf-8?B?d2dma1BJeWVvd3ZHU21OYWl1S3hPeEpMSnJrY0dNT3pQQ2QvNkRNRDdYYkdC?=
 =?utf-8?B?Nmt2TnJjNHpuMnZNNi8yaFkzTzRaeGdQQ1QyWUNZcFM5bGlaT1kzYklnbzNH?=
 =?utf-8?B?TytTUm9QN3FvVU5pcE5RbXMreTREb2Fyaitkb1g5akdBLzAwSVh5QlJvKzFi?=
 =?utf-8?B?c2FSUzdQVkcyUDc4UU1MVmdOTXA2RUI3dnVIMHFVWTgySUJEQnhDeWkxaytv?=
 =?utf-8?Q?vuMSPamU3jQICIKFqHE0c/g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b7e93b-fd4a-45ad-0537-08d9add4c4f4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 16:26:00.1242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAXJr6yILJkYKXPQGQoRz3g/dY+rNQUVTv96mnavDMMlND91gMXPQkACJ+pjbKgokTNANCI+e+zCjX6BmB+giA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-11-20 um 9:58 p.m. schrieb Philip Yang:
> IH ring1 is used to process GPU retry fault, overflow is enabled to
> drain retry fault because we want receive other interrupts while
> handling retry fault to recover range. There is no overflow flag set
> when wptr pass rptr. Use timestamp of rptr and wptr to handle overflow
> and drain retry fault.
>
> Add helper function amdgpu_ih_decode_iv_ts to get 48bit timestamp from
> IV entry. drain retry fault check timestamp of rptr is larger than
> timestamp of (checkpoint_wptr - 32).
>
> Add function amdgpu_ih_process1 to process IH ring1 until timestamp of
> rptr is larger then timestamp of (rptr + 32).
>
> Enable navi asics 48bit time stamp in IV.
>
> Helper amdgpu_ih_ts_after to compare time stamps with 48bit wrap around.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 109 +++++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  |   9 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |   2 +-
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c  |   2 +
>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c  |   1 +
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c  |   1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |   2 +-
>  7 files changed, 99 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index f3d62e196901..17f7f8173bfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -164,52 +164,52 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>  	}
>  }
>  
> +/* return true if time stamp t2 is after t1 with 48bit wrap around */
> +static inline bool amdgpu_ih_ts_after(uint64_t t1, uint64_t t2)
> +{
> +	return ((t1 < t2 && (t2 - t1) < (1ULL << 47)) ||
> +		(t1 > t2 && (t1 - t2) > (1ULL << 47)));

There is a more straight-forward way to do this:

return ((int64_t)(t2 << 16) - (t1 << 16)) > 0;



> +}
> +
>  /* Waiter helper that checks current rptr matches or passes checkpoint wptr */
> -static bool amdgpu_ih_has_checkpoint_processed(struct amdgpu_device *adev,
> +static bool amdgpu_ih_has_checkpoint_processed_ts(struct amdgpu_device *adev,
>  					struct amdgpu_ih_ring *ih,
> -					uint32_t checkpoint_wptr,
> -					uint32_t *prev_rptr)
> +					uint64_t checkpoint_ts)
>  {
> -	uint32_t cur_rptr = ih->rptr | (*prev_rptr & ~ih->ptr_mask);
> +	uint64_t ts;
>  
> -	/* rptr has wrapped. */
> -	if (cur_rptr < *prev_rptr)
> -		cur_rptr += ih->ptr_mask + 1;
> -	*prev_rptr = cur_rptr;
> -
> -	/* check ring is empty to workaround missing wptr overflow flag */
> -	return cur_rptr >= checkpoint_wptr ||
> -	       (cur_rptr & ih->ptr_mask) == amdgpu_ih_get_wptr(adev, ih);
> +	/* After wakeup, ih->rptr is the entry which is being processed, check
> +	 * the timestamp of previous entry which is processed.
> +	 */
> +	ts = amdgpu_ih_decode_iv_ts(adev, ih, ih->rptr - 32);

I still disagree with hard-coding -32 here and in a few other places
that are not IP version specific code, or a helper called from
IP-version specific code. You could abstract this away by adding an
offset parameter to amdgpu_ih_decode_iv_ts. Then the IP-version specific
code can multiply that with the actual IV size. In this case you'd use
offset -1 and amdgpu_ih_decode_iv_ts_helper would multiply that with 32
and add it to rptr.


> +	return checkpoint_ts == ts || amdgpu_ih_ts_after(checkpoint_ts, ts);

This could be done with a single condition like this:

    return !amdgpu_ih_ts_before(checkpoint_ts, ts);


>  }
>  
>  /**
> - * amdgpu_ih_wait_on_checkpoint_process - wait to process IVs up to checkpoint
> + * amdgpu_ih_wait_on_checkpoint_process_ts - wait to process IVs up to checkpoint
>   *
>   * @adev: amdgpu_device pointer
>   * @ih: ih ring to process
>   *
>   * Used to ensure ring has processed IVs up to the checkpoint write pointer.
>   */
> -int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
> +int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
>  					struct amdgpu_ih_ring *ih)
>  {
> -	uint32_t checkpoint_wptr, rptr;
> +	uint32_t checkpoint_wptr;
> +	uint64_t checkpoint_ts;
>  
>  	if (!ih->enabled || adev->shutdown)
>  		return -ENODEV;
>  
>  	checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> -	/* Order wptr with rptr. */
> +	/* Order wptr with ring data. */
>  	rmb();
> -	rptr = READ_ONCE(ih->rptr);
> -
> -	/* wptr has wrapped. */
> -	if (rptr > checkpoint_wptr)
> -		checkpoint_wptr += ih->ptr_mask + 1;
> +	checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr - 32);

Same as above.


>  
>  	return wait_event_interruptible(ih->wait_process,
> -				amdgpu_ih_has_checkpoint_processed(adev, ih,
> -						checkpoint_wptr, &rptr));
> +				amdgpu_ih_has_checkpoint_processed_ts(adev, ih,
> +						checkpoint_ts));
>  }
>  
>  /**
> @@ -253,6 +253,59 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>  	return IRQ_HANDLED;
>  }
>  
> +/**
> + * amdgpu_ih_process1 - interrupt handler work for IH ring1
> + *
> + * @adev: amdgpu_device pointer
> + * @ih: ih ring to process
> + *
> + * Interrupt handler of IH ring1, walk the IH ring1.
> + * Returns irq process return code.
> + */
> +int amdgpu_ih_process1(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
> +{
> +	uint64_t ts, ts_next;
> +	unsigned int count;
> +	u32 wptr;
> +
> +	if (dev_WARN_ONCE(adev->dev, ih != &adev->irq.ih1, "not ring1"))
> +		return 0;
> +
> +	if (!ih->enabled || adev->shutdown)
> +		return IRQ_NONE;
> +
> +	wptr = amdgpu_ih_get_wptr(adev, ih);
> +	if (ih->rptr == wptr)
> +		return 0;
> +
> +restart_ih:
> +	count = AMDGPU_IH_MAX_NUM_IVS;
> +
> +	ts = amdgpu_ih_decode_iv_ts(adev, ih, ih->rptr);
> +	ts_next = amdgpu_ih_decode_iv_ts(adev, ih, ih->rptr + 32);

Same as above.


> +	while (amdgpu_ih_ts_after(ts, ts_next) && --count) {
> +		amdgpu_irq_dispatch(adev, ih);
> +		ih->rptr &= ih->ptr_mask;
> +		ts = ts_next;
> +		ts_next = amdgpu_ih_decode_iv_ts(adev, ih, ih->rptr + 32);

Same as above.


> +	}
> +	/*
> +	 * Process the last timestamp updated entry or one more entry
> +	 * if count = 0, ts is timestamp of the entry.
> +	 */
> +	amdgpu_irq_dispatch(adev, ih);
> +	amdgpu_ih_set_rptr(adev, ih);
> +	wake_up_all(&ih->wait_process);
> +
> +	wptr = amdgpu_ih_get_wptr(adev, ih);
> +	/* Order reading of wptr vs. reading of IH ring data */
> +	rmb();
> +	if (amdgpu_ih_ts_after(ts, amdgpu_ih_decode_iv_ts(adev, ih, wptr - 32)))

Same as above.


> +		goto restart_ih;
> +
> +	return IRQ_HANDLED;
> +}
> +
>  /**
>   * amdgpu_ih_decode_iv_helper - decode an interrupt vector
>   *
> @@ -298,3 +351,13 @@ void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
>  	/* wptr/rptr are in bytes! */
>  	ih->rptr += 32;
>  }
> +
> +uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr)
> +{
> +	uint32_t index = (rptr & ih->ptr_mask) >> 2;
> +	uint32_t dw1, dw2;
> +
> +	dw1 = ih->ring[index + 1];
> +	dw2 = ih->ring[index + 2];
> +	return dw1 | ((u64)(dw2 & 0xffff) << 32);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index 0649b59830a5..edfa0a18a123 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -76,12 +76,15 @@ struct amdgpu_ih_funcs {
>  	u32 (*get_wptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>  	void (*decode_iv)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>  			  struct amdgpu_iv_entry *entry);
> +	uint64_t (*decode_iv_ts)(struct amdgpu_ih_ring *ih, u32 rptr);
>  	void (*set_rptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>  };
>  
>  #define amdgpu_ih_get_wptr(adev, ih) (adev)->irq.ih_funcs->get_wptr((adev), (ih))
>  #define amdgpu_ih_decode_iv(adev, iv) \
>  	(adev)->irq.ih_funcs->decode_iv((adev), (ih), (iv))
> +#define amdgpu_ih_decode_iv_ts(adev, ih, rptr) \
> +	((adev)->irq.ih_funcs->decode_iv_ts((ih), (rptr)))

Since you're not populating this for older ASICs, it would be good to
have a NULL pointer check here and return 0 as a fallback and maybe
print a WARN_ON_ONCE because checking a timestamp on an ASIC that
doesn't provide it would result in unexpected behaviour:

#define amdgpu_ih_decode_iv_ts(adev, ih, rptr) \
	(WARN_ON_ONCE(!(adev)->irq.ih_funcs->decode_iv_ts) ? 0 : \
		(adev)->irq.ih_funcs->decode_iv_ts((ih), (rptr)))


>  #define amdgpu_ih_set_rptr(adev, ih) (adev)->irq.ih_funcs->set_rptr((adev), (ih))
>  
>  int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
> @@ -89,10 +92,12 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>  void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>  void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>  			  unsigned int num_dw);
> -int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
> -					struct amdgpu_ih_ring *ih);
> +int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
> +					    struct amdgpu_ih_ring *ih);
>  int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
> +int amdgpu_ih_process1(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>  void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
>  				struct amdgpu_ih_ring *ih,
>  				struct amdgpu_iv_entry *entry);
> +uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index e9023687dc9a..891486cca94b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -224,7 +224,7 @@ static void amdgpu_irq_handle_ih1(struct work_struct *work)
>  	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
>  						  irq.ih1_work);
>  
> -	amdgpu_ih_process(adev, &adev->irq.ih1);
> +	amdgpu_ih_process1(adev, &adev->irq.ih1);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index 1d8414c3fadb..1af1358f9650 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -160,6 +160,7 @@ static int navi10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
>  
>  	tmp = RREG32(ih_regs->ih_rb_cntl);
>  	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_ENABLE, (enable ? 1 : 0));
> +	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_GPU_TS_ENABLE, 1);

Maybe this should be in a separate patch.

Regards,
  Felix


>  	/* enable_intr field is only valid in ring0 */
>  	if (ih == &adev->irq.ih)
>  		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
> @@ -724,6 +725,7 @@ static const struct amd_ip_funcs navi10_ih_ip_funcs = {
>  static const struct amdgpu_ih_funcs navi10_ih_funcs = {
>  	.get_wptr = navi10_ih_get_wptr,
>  	.decode_iv = amdgpu_ih_decode_iv_helper,
> +	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
>  	.set_rptr = navi10_ih_set_rptr
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index a9ca6988009e..3070466f54e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -640,6 +640,7 @@ const struct amd_ip_funcs vega10_ih_ip_funcs = {
>  static const struct amdgpu_ih_funcs vega10_ih_funcs = {
>  	.get_wptr = vega10_ih_get_wptr,
>  	.decode_iv = amdgpu_ih_decode_iv_helper,
> +	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
>  	.set_rptr = vega10_ih_set_rptr
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index f51dfc38ac65..3b4eb8285943 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -688,6 +688,7 @@ const struct amd_ip_funcs vega20_ih_ip_funcs = {
>  static const struct amdgpu_ih_funcs vega20_ih_funcs = {
>  	.get_wptr = vega20_ih_get_wptr,
>  	.decode_iv = amdgpu_ih_decode_iv_helper,
> +	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
>  	.set_rptr = vega20_ih_set_rptr
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 10868d5b549f..663489ae56d7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1974,7 +1974,7 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
>  
>  		pr_debug("drain retry fault gpu %d svms %p\n", i, svms);
>  
> -		amdgpu_ih_wait_on_checkpoint_process(pdd->dev->adev,
> +		amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
>  						     &pdd->dev->adev->irq.ih1);
>  		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
>  	}
