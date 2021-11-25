Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4271AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 01:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A34E66E220;
	Thu, 25 Nov 2021 01:56:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E33E6E311
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 01:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/IEUDOdnSGOJt0q6oGZUDhkWosTQ8rRUVFY1iZEDaMyAzup/qt5gjHIFYTkcxqT7tYIKToOif5UijQK0kb6SiYvYRQ56UibBbwFTr/cTioFfZt+RXU+8Nx0wSMo7Oj6NfShtjdtYhCHuUoceBzyzLsIONjvlP+HxHLgws6vvvatGTokmsGb5zLfPYikefQJ94apwm5IJEAweqh1/eurVc6ePckdaWnEP6nBP6V7iOznjKOp7WaFT81CrTxrCkL1EQBSmVKfiPgQfCjWxMCZZTCxeKnOExF3nn05JTtOQ4b+phQI1Vc/j6SHFz9ZaV2IQVjkRlzJIDfvOJWLSWhS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjjQKNSilbuR3FQjruuITE2TZ/fyrb2VUpJk+LcfNQI=;
 b=ZL04krqYDCrKat2AQKyi9bLh4cGgRschRuZBxaFvy6jOZ0C2X9HVV9Pm1tzesD46RfZDRU8c2TuD5nj6yTWDopQrkjjwp2Zpe+NKM8vatZwezgoIM9+fqYbO4j9CBgek1boEndBqFC14NouwZTBHb6suY/esvjh4IWKIVhnMcUavgok5QZMARUA7dWkunl07cEslO7O8Ib0G9ylCk3byu7AOXL4bXja00+5TlQSo3yRYK9yuOJ01Maz/Bk6z8PBnqhXC8mpxiA0bSZs7LRgDc47LEuSpknCDx+yJ+xeUMeF9cfGykrdLejfqGXlU0TaSOcXxZO+Ca/haJ8zLt5ajhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjjQKNSilbuR3FQjruuITE2TZ/fyrb2VUpJk+LcfNQI=;
 b=AdJeMPrCxL+LZS2FAJ1Pld+1VFlPLaFYLLhqeYms8qAkRm1X96ColKPJpV3f/OFztZ3VFm5QMqEV0d5IhYCHSOp9Crq38aigodHMmh12SMeuLSdF0RyUl3toOM5MbiKSqCGzpXXcnOG+JOZREFhkKa7JQM/DJv8bnqCruwWQMy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 25 Nov
 2021 01:56:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.025; Thu, 25 Nov 2021
 01:56:05 +0000
Subject: Re: [PATCH v6] drm/amdgpu: handle IH ring1 overflow
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211124225827.26232-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <dfaad884-e185-6dcc-df00-1cb2da4a6e50@amd.com>
Date: Wed, 24 Nov 2021 20:56:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211124225827.26232-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::45) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YTXPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 01:56:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48d02633-0f8b-445b-2829-08d9afb6bdd3
X-MS-TrafficTypeDiagnostic: BN9PR12MB5196:
X-Microsoft-Antispam-PRVS: <BN9PR12MB51960F640D3B5C0369713A2792629@BN9PR12MB5196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Agr/Ju0cf6GMUeRhWBQPCQwt0Yf+u54AxaR7ffvmty/eeUvdPIyCrrQOaxDIdl6ydGiWHb1Il0oXhrALxFcI25PyvFvBk+6Na5/exwo+GK9aA6d0XMTCmTqciCpXe+lu3tfR9axV1j9TYVWzcZASqLp0jcFKNFmDzeEux/+dOITl9uoZ0jpJ1fptAQx4b53KbkLds0imn6JcexCQq9QPPbAPQUz4ui5sfGxDxOblPphfUKHX+iWYh779136n5XZpSXOSKjUsK5B5hCV/CVYAzM2klB6dK0DQZhGcjIPFyvaVshd0myuQNB08Qh7fXOwTPSgz2CROjdOY1WtUPqRto5AA7B2RKB/lDf05fvuUIndzmPiiBCaD7gPmuZF43OVHX17Z/E7M5ki2dH6k4EI0ihxTeyV2rS7ipL3oUhtPaUhyMhssWLq6dg7rN2RkmsQqjF8UqaRMY9AxSq9Wsm4B/OTHA/NjEuepoY97l18+xuOKcL9iAQIZNclHPJ1IEPwDB1q8ABg4TN12fK2kgKUFJz31JTSaZzaWIwORLJVTOM2xPVDvOelz6BFVn66AN24FMMmKi9CKXIQJ+O1b/qsL4yAo3EPTMkWmgfXDe3eFvt6z5CfGgXk7GI1FfR+RHPdE8a5+JuETzbVuK6KStgyywCq2MppM5GW9yKuU1cD+cEc63zEwwHmgL7X+1kJ2adAlerplI+Aze234em8W3SRVdQOjB/+V6WxX2BCEmYUR+azcseUFb2QPCNW3lDG6URSC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(6486002)(66556008)(31686004)(31696002)(186003)(38100700002)(4001150100001)(5660300002)(8936002)(66946007)(316002)(86362001)(83380400001)(4326008)(44832011)(26005)(36756003)(16576012)(2616005)(508600001)(8676002)(2906002)(956004)(30864003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmxZV01tbHJQMnQ2UTcyTmY2Qm03bHVpSXpDY25yVGVQS0ExNTRGTmVMN0pF?=
 =?utf-8?B?aVFnVXdQaU4yall5ME5jK1B1Q3lRRTZiL1FqQXlUc1QvdjIwc3pma04vdXp1?=
 =?utf-8?B?ajBwUzFBY1lFNnJhMEYyKzU4VXpiRUFsTjJMZi8zR29vOTNyQVZhYm94SE5D?=
 =?utf-8?B?a2RKNTJaWVVtdHczNHhDMUJCRGVkRXc1OVV5enBDWTR5Yk1ZZmplc0tZWHYy?=
 =?utf-8?B?UUZkZGx5d2ZrVGQvTlNmTFFDYVQ3bmRkQWlzNk1jZCs4MDZaKy9tczhUWnJa?=
 =?utf-8?B?cTRoc2hjS21UdldOZk9Nc0VUZUxmQlhuQzFvK1U1cEVnbGRtc3YwN09adnFX?=
 =?utf-8?B?eUxxNkkxeEdYcXUxK254U2ozOTJKV0wzQWd3S2Zmejg1VEpaejM5RHhndUZ5?=
 =?utf-8?B?RDJQYmk0azFPbmd2dmZkdDNGMytNWEovcktwbHFXUUZ1enJ5T1krMjVPZ3Fm?=
 =?utf-8?B?Y2thSDUxRXhoM2hEK21MejduN0owNDZEOHJQMDhYS0svOUtickgyZUd3bitk?=
 =?utf-8?B?TVlqZ3hDSzQ1N1hLS3pQeEEzbzBCMmFwYjd5bEF1alhabVI4UkNwT1BpTDJ0?=
 =?utf-8?B?eHpVUjFNNlNmZjZkNzNjcXFmNGdSNk01Vk55TnNsUjZ5WWI2eE4xTmNYRmRZ?=
 =?utf-8?B?TmFOK0JiWjRXY1pGWm5ZVTAzeDgzdDRKN0E5eFRoOVpEaU15OE9Dcnp4THdv?=
 =?utf-8?B?MkVQekF2ZGtZYlY5V1FzQVR0eEJWRk13bGEzbzh0RGR2bEJ6TGFLYng0V2pr?=
 =?utf-8?B?TnlGczFieDRkZnhkZjVXL25weFE1THRoc1N1TWtnNUhJY0xodEdsSzBIMll6?=
 =?utf-8?B?cXg3a0lISTNaUU1CY2V3OVlRTnFNRFNBTTA1cmtYTnpzVTVwWGNBR0JuSFVv?=
 =?utf-8?B?cWRQTWJ5aTBiK2lLODA1MWt4RVgyV3FlTHZjUmIwd0JKVTJXdXhIanBra0Ju?=
 =?utf-8?B?cEFrdHN3dDdzRWJUWnhJWE5vYnF5ZTBJeGJ5QzJpOVlvSXF1K1hLYVUrNVR0?=
 =?utf-8?B?VVJWaDV0UmE0KzFLcW8yaEkzSGw2VVgxamc5VERMWUFUUkpXY1dCZHJXeDA3?=
 =?utf-8?B?SysvaUtBTGI4d3cwNUt5YzJzNERDTWhUSWNJK1lULzNBcE1KYXRVendGS0ZS?=
 =?utf-8?B?YkVpK0pWcmpINVhOQjJLQWc1cDN0a21JdTBqa25Fdit4YmxaSU96bWhZVHVI?=
 =?utf-8?B?UCsxcU1ReTdpaks2Yys5M2hXTUlSUkNHL3VGUEp3dHdoT3hoR045bHJ6alNo?=
 =?utf-8?B?c3BtbHQ0bXh6UkxHbjUzYkxqdUJ2L08yZG5FM2M1TGpmR25GQ3dyN3hlU0VE?=
 =?utf-8?B?UVlQTzFHQStmVXVMQ3kyQlptRTBOcUJFM2l1THNTRTRGQzVIdit1VFltaUNI?=
 =?utf-8?B?NGVOK3ZaS0JQWXVFTGRDRGxYQzNtajlpY1RQcEo4aDAzdzhHelRyM2I2cSsr?=
 =?utf-8?B?OEdLcHhvZ3lmVHk1Z3ROVEFROTVPcElraEZUMGUrWVFJRW83Y3hNNzJORHJs?=
 =?utf-8?B?czM0c1R0RE1BYjAzeVgxdEljb3BGL0w4d1BIcTkxRUQ2djhrNTdsT0dYOVNw?=
 =?utf-8?B?MUo0Z3NlbDQ1U3Ntay9LTHFTMFNURDhjNzNZanozczVKV3I5bjNSZTdwd1NH?=
 =?utf-8?B?UTNLbjNPUTA5Snhnek4yZERQSERxWWZrQUJ2SEtZcjlvUFlqVkdLR3M2dStI?=
 =?utf-8?B?bEI3ZWoxR1hzZHNrbDg0TlZLUnNVb3Y4Qm5KUk1sWUFOMk5va3YrbWcyYnAr?=
 =?utf-8?B?d28zdDQzYkZBcGxkN2ZwZ1pSNTdBMHlFTjhiRzFWWmhWWFN4MVR1alZvQ2dK?=
 =?utf-8?B?OEt6L3BiLzVqMHpmZTcwRW44eWZUL2NpWWdVUzV0T2ZDWVlPMnJxU2JVSmpn?=
 =?utf-8?B?RkEwa2g2MFFlR1NWTlc1YlpnTjU5djRVLzE5VDdoUkUzQTNmSU9PeW10RXNO?=
 =?utf-8?B?NWZlV2VIQzZUM1pPdjJYUEpoNTBUd3F0UjN4a1JjQis1eTFVNmZDblRTS2hu?=
 =?utf-8?B?RTRsS056bWFhYlBWenRjREVubE00V2Yxc2M4UTUybS9UN0lVYjA1ODlZUGli?=
 =?utf-8?B?RTVYWi9nMDduTlp2VXM2c0pQS3VGaUtJWTRoSkJ2b2RLeENldmJCYXg4T2Ft?=
 =?utf-8?B?N1Vpc3FoNUkrT0JzaUdVZzB3NUI1UXkrY0xJd0VOU05ZVndDZWFtUWRTQ3Q3?=
 =?utf-8?Q?N7s/pT3MeNfEXz7EtDUwAok=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d02633-0f8b-445b-2829-08d9afb6bdd3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 01:56:05.5855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlMlVA4N8C20+fhpx/Gjap2bzjeTtP+9PznMr1Uuw+xVzOOa8cyvg0FMi0ApH9HkBxKi16f24b4s3ZriV8A9Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5196
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

Am 2021-11-24 um 5:58 p.m. schrieb Philip Yang:
> IH ring1 is used to process GPU retry fault, overflow is enabled to
> drain retry fault because we want receive other interrupts while
> handling retry fault to recover range. There is no overflow flag set
> when wptr pass rptr. Use timestamp of rptr and wptr to handle overflow
> and drain retry fault.
>
> Add amdgpu_ih_function interface decode_iv_ts for different chips to get
> timestamp from IV entry with different iv size and timestamp offset.
> amdgpu_ih_decode_iv_ts_helper is used for vega10, vega20, navi10.
>
> Drain retry fault is done if processed_timestamp is equal to or larger
> than checkpoint timestamp. Page fault handler skips retry fault entry if
> entry timestamp goes backward.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 58 +++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h | 16 ++++++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  5 +++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  5 +++
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c   |  2 +-
>  8 files changed, 56 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index 0c7963dfacad..3e043acaab82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -164,52 +164,32 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>  	}
>  }
>  
> -/* Waiter helper that checks current rptr matches or passes checkpoint wptr */
> -static bool amdgpu_ih_has_checkpoint_processed(struct amdgpu_device *adev,
> -					struct amdgpu_ih_ring *ih,
> -					uint32_t checkpoint_wptr,
> -					uint32_t *prev_rptr)
> -{
> -	uint32_t cur_rptr = ih->rptr | (*prev_rptr & ~ih->ptr_mask);
> -
> -	/* rptr has wrapped. */
> -	if (cur_rptr < *prev_rptr)
> -		cur_rptr += ih->ptr_mask + 1;
> -	*prev_rptr = cur_rptr;
> -
> -	/* check ring is empty to workaround missing wptr overflow flag */
> -	return cur_rptr >= checkpoint_wptr ||
> -	       (cur_rptr & ih->ptr_mask) == amdgpu_ih_get_wptr(adev, ih);
> -}
> -
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
> +	long timeout = HZ;
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
> +	checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
>  
> -	return wait_event_interruptible(ih->wait_process,
> -				amdgpu_ih_has_checkpoint_processed(adev, ih,
> -						checkpoint_wptr, &rptr));
> +	return wait_event_interruptible_timeout(ih->wait_process,
> +		    !amdgpu_ih_ts_after(ih->processed_timestamp, checkpoint_ts),
> +		    timeout);
>  }
>  
>  /**
> @@ -298,4 +278,22 @@ void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
>  
>  	/* wptr/rptr are in bytes! */
>  	ih->rptr += 32;
> +	if (ih == &adev->irq.ih1 &&
> +	    amdgpu_ih_ts_after(ih->processed_timestamp, entry->timestamp))
> +		ih->processed_timestamp = entry->timestamp;

I'd call this "latest_decoded_timestamp". At this point it hasn't been
processed yet.

Also, I think it would be safe and cheap enough to do this on all IH
rings, in case someone finds it useful for something else, e.g. using
amdgpu_ih_wait_on_checkpoint_process_ts on IH ring 0.


> +}
> +
> +uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
> +				       signed int offset)
> +{
> +	uint32_t iv_size = 32;
> +	uint32_t dw1, dw2;
> +	uint32_t index;
> +
> +	rptr += iv_size * offset;
> +	index = (rptr & ih->ptr_mask) >> 2;
> +
> +	dw1 = le32_to_cpu(ih->ring[index + 1]);
> +	dw2 = le32_to_cpu(ih->ring[index + 2]);
> +	return dw1 | ((u64)(dw2 & 0xffff) << 32);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index 0649b59830a5..dd1c2eded6b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -68,20 +68,30 @@ struct amdgpu_ih_ring {
>  
>  	/* For waiting on IH processing at checkpoint. */
>  	wait_queue_head_t wait_process;
> +	uint64_t		processed_timestamp;
>  };
>  
> +/* return true if time stamp t2 is after t1 with 48bit wrap around */
> +#define amdgpu_ih_ts_after(t1, t2) \
> +		(((int64_t)((t2) << 16) - (int64_t)((t1) << 16)) > 0LL)
> +
>  /* provided by the ih block */
>  struct amdgpu_ih_funcs {
>  	/* ring read/write ptr handling, called from interrupt context */
>  	u32 (*get_wptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>  	void (*decode_iv)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>  			  struct amdgpu_iv_entry *entry);
> +	uint64_t (*decode_iv_ts)(struct amdgpu_ih_ring *ih, u32 rptr,
> +				 signed int offset);
>  	void (*set_rptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>  };
>  
>  #define amdgpu_ih_get_wptr(adev, ih) (adev)->irq.ih_funcs->get_wptr((adev), (ih))
>  #define amdgpu_ih_decode_iv(adev, iv) \
>  	(adev)->irq.ih_funcs->decode_iv((adev), (ih), (iv))
> +#define amdgpu_ih_decode_iv_ts(adev, ih, rptr, offset) \
> +	(WARN_ON_ONCE(!(adev)->irq.ih_funcs->decode_iv_ts) ? 0 : \
> +	(adev)->irq.ih_funcs->decode_iv_ts((ih), (rptr), (offset)))
>  #define amdgpu_ih_set_rptr(adev, ih) (adev)->irq.ih_funcs->set_rptr((adev), (ih))
>  
>  int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
> @@ -89,10 +99,12 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>  void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>  void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>  			  unsigned int num_dw);
> -int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
> -					struct amdgpu_ih_ring *ih);
> +int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
> +					    struct amdgpu_ih_ring *ih);
>  int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>  void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
>  				struct amdgpu_ih_ring *ih,
>  				struct amdgpu_iv_entry *entry);
> +uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
> +				       signed int offset);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 3ec5ff5a6dbe..b129898db433 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -119,6 +119,11 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>  			return 1;
>  		}
>  
> +		/* Stale retry fault if timestamp goes backward */
> +		if (entry->ih == &adev->irq.ih1 &&
> +		    amdgpu_ih_ts_after(entry->timestamp, entry->ih->processed_timestamp))
> +			return 1;
> +

This check should go before amdgpu_gmc_filter_faults. Otherwise
amdgpu_gmc_filter_faults may later drop a real fault because it added a
stale fault in its hash table.


>  		/* Try to handle the recoverable page faults by filling page
>  		 * tables
>  		 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index cb82404df534..c0d9b254bbb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -535,6 +535,11 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>  			return 1;
>  		}
>  
> +		/* Stale retry fault if timestamp goes backward */
> +		if (entry->ih == &adev->irq.ih1 &&
> +		    amdgpu_ih_ts_after(entry->timestamp, entry->ih->processed_timestamp))
> +			return 1;
> +

Same as above.

Regards,
  Felix


>  		/* Try to handle the recoverable page faults by filling page
>  		 * tables
>  		 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index 38241cf0e1f1..8ce5b8ca1fd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -716,6 +716,7 @@ static const struct amd_ip_funcs navi10_ih_ip_funcs = {
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
