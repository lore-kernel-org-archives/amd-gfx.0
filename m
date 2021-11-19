Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E60C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 22:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13FEB6E29D;
	Fri, 19 Nov 2021 22:59:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F3716E544
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 22:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YA3OujG9X9d3J2MteNp3ngjLtkN/Rj8cHqvn9dAlasmkpRuP7GCOO2B1vl8/BlSCFBUwXwD8nS0/JMkAk1oWz683zLD/z+mb6OBq0+XPkJ0n+I87RuqMbrkWSArG4OyI6lg29gbRJzKH4NohRanEiEbhUQlbZPAe6XmjfG5eSjaMB1zWXa1aBxJcfFE+B+HAAUB/paqSMwzZcXHuvafXC//jnv9VtskF5JkzyGy+iX45TUCe3MlDBq9eBzHaoCxplhq5F7RmqaHT4t7VG++jYFhgA+v+eZx+e57LsBqMmPJr/8QQZvSoZPo2eM/uWTI/O3X/MxDReJuHOzlRs7uxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HSRQC8RpguS27ugyk0OhrwDiPwrM/3gkCN0ejZhYfM=;
 b=FL1TU3b59vWxzYWbbZF2u+aKjjy8FMIa2JfYcc/W3IoSZcxUvZpg0SP832Vv8OvSvCn68JzIYmQ6oweVyTemjb2sZEqkm2AmtnF1FFTV+/KRkx0cYKSOwfQMbILyMgG9Zq3MIpuVUg7OTdh8z/HHZIyhTQsvQ7Za2wq9WCcm2CDy41Q4253TE0nZ32kdxDul097R9oWPlKQHZv45RsiCoiJ+l7FnZjqrLgTeVqeqaXZPKys3UbqyQyhxRhKyQnWajviAWufegMFc6Fi49+jGQae82pu8M7O8vozRLnZ5g8S10aY6aY5Q+NqLudxs0WeUt3IZIP9m2Yn8VMaede+oHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HSRQC8RpguS27ugyk0OhrwDiPwrM/3gkCN0ejZhYfM=;
 b=gTJv2VUttLGvZZpP4jAEzK2wQpQkID3Kr+q04Naj1vtg1yyeSMaKoq3HwW9YxDCnx6r5KEWYp1dMhsiOUD6qcaD8bexGapOyYicv/L1AI1DIZ6VwFylP4yfGsfSb0p7FYGPVvN3KZC0EW2j+noFHKQlRrRCdg4LorA6HEu6iuwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5275.namprd12.prod.outlook.com (2603:10b6:408:100::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 22:59:34 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 22:59:34 +0000
Subject: Re: [PATCH v2] drm/amdkfd: handle IH ring1 overflow
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211119202233.13486-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <2a610519-689f-c3d0-3675-59f7c64eaf4f@amd.com>
Date: Fri, 19 Nov 2021 17:59:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211119202233.13486-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BL0PR0102CA0060.prod.exchangelabs.com
 (2603:10b6:208:25::37) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 BL0PR0102CA0060.prod.exchangelabs.com (2603:10b6:208:25::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.22 via Frontend Transport; Fri, 19 Nov 2021 22:59:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2765c43-1f06-4e75-6e8c-08d9abb04132
X-MS-TrafficTypeDiagnostic: BN9PR12MB5275:
X-Microsoft-Antispam-PRVS: <BN9PR12MB52755CC6BFB17F32A788D306929C9@BN9PR12MB5275.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjWxDRvFsAAqwGGlaJk3BrTVU7uFu+CL3tGxL5/uatqCeqoc4XwZuFQQralehajoYy8Sw4jfE/VFWhGRpfcRw3yyuncyF0VBNll6/8IQKhC6f/SewsLPUfji+fjki6ujMrUur3DOo0E2j21t6rXqtL/udNRQ3mgD8F/mx6k5ARHb7Eg2xS08zRemVhQZ/mvFrUfKqmk1mOt2BR4tRPAkpg9jUhwK/zd3Nn0S7106QFqlWSrv9MNTknvypJgs6kBHJU03gOshjrwF7ls6v6dF5wZB0hoMOkzdybz5T8UXTzXq1ak5BzXcxTUCbVLprpac8LwmhEDQZ4W4ORQojTEhASz5vljnsveC6hJKg3AAnDjeLUi6AnPqGQ+0jD2nTdPHqnOjWOIY5KBQJ6vWFEx7Fb8XO2N7ydxrsxRgr6w4m8afpkngcOUeJ8UKXbtXfCZF/xn9E9KjbjzbkrcNqsnDGBaXPEwkCxkQ7oiHvaAXpytw9XHYZ862cGpgW5fUTH3XrqO4XU/oHeqdE8qZ+rzQ0t7epp4BbQrVuB5WAb6Et/Vye8LwnLaYYhQ4eCr1jwheO3pw/8ZexVvSVQceANNMs1NTE0ImBeSpcnt0dCshlG1BrUJ8VolBt7x+Axuax7F31KjFwMGXglhsY6+EDfmd6+0LWXKWAwVLqP1ValWyhyVrSlXLy22Vs5l3yi3bv2BPD1MDYO8/nP/SkSgqmuJEOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(83380400001)(66476007)(86362001)(186003)(66946007)(2906002)(31696002)(4001150100001)(4326008)(44832011)(66556008)(36916002)(16576012)(8936002)(38100700002)(53546011)(316002)(31686004)(36756003)(5660300002)(508600001)(26005)(8676002)(956004)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUJVYUlycEM5L0hjOE9BMWcvOFRQdzcwWFNvU3g5ODJDc0YxdXZPSno3dEJq?=
 =?utf-8?B?K0R3Q1BKYWZtQnErcXE5aHhkWGsxclNDdDFDZkJ3UzhmUmJMZmxzVGhyWHpB?=
 =?utf-8?B?NWNodVJIY0ZVSUM0Rys3N3JMUFpoM0J0Vlk5UTU0NnVZdGQ0V25yRGdRYmtU?=
 =?utf-8?B?eVV0ZzZESnZmQi8wYmpFakUrTDNGT2cwTUsxSmwxYzFMdmRXL0VOVnZuR015?=
 =?utf-8?B?RDduUlk2MUFjYzBqVjVsSDlGUXkxUmdTM3hFM0QyME83TmN5N2NSc0RTY09W?=
 =?utf-8?B?S1FycSt1VEt4Y2VmMGlNZTYvdUxIY0l4aTJvR3krSEZ5TDl6NExWSk9FOExw?=
 =?utf-8?B?SE1Jd2lpUEx0NFpBS3dCY1BVVFpHVHVacy96MmRGYWtHYVJCN1ZFa3Nrdmtl?=
 =?utf-8?B?eitEeGNTUWE4U04yb0V4VDJiSXRxZVg3b0h1d0ptR3JPcVp5aVJwd3JmblRu?=
 =?utf-8?B?UnA0V3A3TEpxaVBFYzY2ek9CYzFZb2ZSVWFxdFdZNE9ESE1ZSm1JYllHazRW?=
 =?utf-8?B?N0Q1TVllb1ZBY1VVZ0Q4ejZmOWVTVzM0SElCcGdTQm5rMXJHTzIxTUpnOXh2?=
 =?utf-8?B?UnJnUEtPaW9QL1loa20xVEoxS2V3VHRwTWdNNGRzOUdWNGZkWmVpUmhkYkN0?=
 =?utf-8?B?L3RmckEzRXdpS09zeHo2SzFUWGNYYUtXV2N5VmJ2RHhJOVF2eVNCbkdyTGRh?=
 =?utf-8?B?ZjZ4RlFlcm00TlNGTzlJbjIvT1cxWjhicmcrcCtUamNzcWMvUCt1b0wyRENK?=
 =?utf-8?B?M3B4WFBEWE9ZNEc3MGlHbzQ2SThLSjd1SzcycUZ3R1dQTWMyUkhNUVFaejJw?=
 =?utf-8?B?c3Jra2VMWjlicVUzaExmeVpkbGpwT0w2RWRDTnRpdkFjMFRwOGhac3lMZit0?=
 =?utf-8?B?UVgrbm9mWWdoZyt0alNNRnBiWEhQbHlXbE8zM0pVUHJSazY5dENibGxoUGlI?=
 =?utf-8?B?OVB5U3BKb0ptRUU0b1liaUgrSEFCZkd0MGI1SmVTdGtRMjA0OFZncnlXaTZq?=
 =?utf-8?B?RFptRGpLSzA2UnJ6bktMNzk4QVdyM3BSSUhHREtBbFg4UlpPcStaKzJhVXk3?=
 =?utf-8?B?b21oSWRaUFg0RnFuMEY5RU14V0JQMjhnZGp6U2pvZDhwQ040RHYwMi91Rzc0?=
 =?utf-8?B?bDNFQy8yVDNScW12dnZKZ0NvdjZYY2p3YUlBeXluWTF6bkxaZWtXRzkrTDZq?=
 =?utf-8?B?bis2cnk1Vm9lNHIvSDhxM0ljWERGdHpvTFNWdk1uempYTVg0bTdmeVFYUUVy?=
 =?utf-8?B?S1hTajlESFJhRzMyWVJYOVJvQ2JlZ0J5ZnZqRGJSKzMyRndURm9vcUFnbDNv?=
 =?utf-8?B?anlpTmtTb0hnVGYvcGZkWHpoVWNNZElLUDNCcDRuQmduTmVBeTlzcnJoTmpt?=
 =?utf-8?B?aFdaWW9rY2djNWNsTWpvN2cveUN4YjRaMy9lbzJlWkNrZ2J4LzZDNmtjY2lV?=
 =?utf-8?B?b1dTYjJ6TllyVUVpTkdqZzZUeFZWMlQzUnRGTEdGZlozMWhPSlhQVG0wRkR0?=
 =?utf-8?B?ckQvbVNia1dPYzcwR0NUR2I3bk01N2xmT0xRQmxHNTB1dC9SSjZEY01GMWpp?=
 =?utf-8?B?Z0ErM1c2WlVqYWNUdHkwR3lOdEllU1dPWTNmODJTclFBQlN2bTFFU3NMZ0w1?=
 =?utf-8?B?eEQ3eGRpbWtDT2dMZk52Z3NPOTU1aThIM3k2ZHhXbzczUUhlYXk0NkNoemdm?=
 =?utf-8?B?S3NYWk85amJsK25rZVBhdXJ5ZHVzYThlS0wvdXdueHJielUrTUVPUUJUMXFT?=
 =?utf-8?B?ajI2cTNpLzlzZHN4REQ2OE1FcTVGVGkxWE5EU09RUy9OcTRieGxDUGZVUzBH?=
 =?utf-8?B?ZUltdi9Fd3R6K05BQUVqQVFkbjlGa2pXTzZyTzdEZE5HUlA4U3lRMGFKc1gw?=
 =?utf-8?B?TmovaHFvdVFnTFFEKzFNQVo1MmZuTTdERUYyQ3c4RC92WHZEblRqc3htRHht?=
 =?utf-8?B?Y20wNHRseXZlODVUNmxDRkh1cCttVUdBTFJhT25wZEtGcmF5d3ZlTXRuMkk4?=
 =?utf-8?B?MjhqMGhQUGRWcnFmZEQyYjcySmViNGQ5ODBiTm5UOHJvNGZ5WUNXRXlnSjVL?=
 =?utf-8?B?bC9rSHdpQzBDK0twbE41a2VvYXBacFVLMitJRUw1VUdYUERzTDI0bmcrYkg4?=
 =?utf-8?B?cU13TzdCZGpCYUIwaHJ4amY0R280VHhKVHZBcm5WT2ZZTTJ4eHE1Y0QwWnhO?=
 =?utf-8?Q?55iymSqzXOQ3RLPGMngLOdI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2765c43-1f06-4e75-6e8c-08d9abb04132
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 22:59:34.6959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMQ8XLBAGe0zwjd6GyCl4iGj8t6f/xUZ7up85dOt805X0peC5oRYlyywNqEZ2lEh/3V6rtsMLVZT62Zrbt4hdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5275
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

On 2021-11-19 3:22 p.m., Philip Yang wrote:
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
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 98 +++++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  |  6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |  2 +-
>   4 files changed, 80 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index f3d62e196901..ad12f9d5d86a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -165,51 +165,41 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>   }
>   
>   /* Waiter helper that checks current rptr matches or passes checkpoint wptr */
> -static bool amdgpu_ih_has_checkpoint_processed(struct amdgpu_device *adev,
> +static bool amdgpu_ih_has_checkpoint_processed_ts(struct amdgpu_device *adev,
>   					struct amdgpu_ih_ring *ih,
> -					uint32_t checkpoint_wptr,
> -					uint32_t *prev_rptr)
> +					uint64_t checkpoint_ts)
>   {
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
> +	/* After wakeup, ih->rptr is the entry which is being processed, check
> +	 * the timestamp of previous entry which is processed.
> +	 */
> +	return checkpoint_ts <= amdgpu_ih_decode_iv_ts(ih, ih->rptr - 32);

This assumes a IV size of 32 bytes, which is not true for all ASICs. On 
GFXv8 and older GPUs it's on 16. OTOH, those chips don't have a ring1 
and may not have a timestamp in the IV at all.

And I think you need to be better at handling when the time stamps wrap. 
Keep in mind that the number of valid bits may vary between ASICs.


>   }
>   
>   /**
> - * amdgpu_ih_wait_on_checkpoint_process - wait to process IVs up to checkpoint
> + * amdgpu_ih_wait_on_checkpoint_process_ts - wait to process IVs up to checkpoint
>    *
>    * @adev: amdgpu_device pointer
>    * @ih: ih ring to process
>    *
>    * Used to ensure ring has processed IVs up to the checkpoint write pointer.
>    */
> -int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
> +int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
>   					struct amdgpu_ih_ring *ih)

If this function is only meant to work on ring1 now, we should probably 
ensure that by checking that ih is really ring1.

Do we need to keep the old solution for Vega20, which doesn't reroute 
interrupts to ring1?


>   {
> -	uint32_t checkpoint_wptr, rptr;
> +	uint32_t checkpoint_wptr;
> +	uint64_t checkpoint_ts;
>   
>   	if (!ih->enabled || adev->shutdown)
>   		return -ENODEV;
>   
>   	checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> -	/* Order wptr with rptr. */
> +	/* Order wptr with ring data. */
>   	rmb();
> -	rptr = READ_ONCE(ih->rptr);
> -
> -	/* wptr has wrapped. */
> -	if (rptr > checkpoint_wptr)
> -		checkpoint_wptr += ih->ptr_mask + 1;
> +	checkpoint_ts = amdgpu_ih_decode_iv_ts(ih, checkpoint_wptr - 32);

Same as above.


>   
>   	return wait_event_interruptible(ih->wait_process,
> -				amdgpu_ih_has_checkpoint_processed(adev, ih,
> -						checkpoint_wptr, &rptr));
> +				amdgpu_ih_has_checkpoint_processed_ts(adev, ih,
> +						checkpoint_ts));
>   }
>   
>   /**
> @@ -253,6 +243,56 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>   	return IRQ_HANDLED;
>   }
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
> +	ts = amdgpu_ih_decode_iv_ts(ih, ih->rptr);
> +	ts_next = amdgpu_ih_decode_iv_ts(ih, ih->rptr + 32);

Same as above.


> +	while (ts < ts_next && --count) {
> +		amdgpu_irq_dispatch(adev, ih);
> +		ih->rptr &= ih->ptr_mask;
> +		ts = ts_next;
> +		ts_next = amdgpu_ih_decode_iv_ts(ih, ih->rptr + 32);
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
> +	if (ts < amdgpu_ih_decode_iv_ts(ih, wptr - 32))
> +		goto restart_ih;
> +
> +	return IRQ_HANDLED;
> +}
> +
>   /**
>    * amdgpu_ih_decode_iv_helper - decode an interrupt vector
>    *
> @@ -298,3 +338,13 @@ void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
>   	/* wptr/rptr are in bytes! */
>   	ih->rptr += 32;
>   }
> +
> +uint64_t amdgpu_ih_decode_iv_ts(struct amdgpu_ih_ring *ih, u32 rptr)

This function needs to be in IP-version-specific code. Maybe add an 
offset parameter, that way you can handle different IV sizes in 
different ASIC generations.


> +{
> +	uint32_t index = (rptr & ih->ptr_mask) >> 2;
> +	uint32_t dw1, dw2;
> +
> +	dw1 = ih->ring[index + 1];
> +	dw2 = ih->ring[index + 2];
> +	return dw1 | ((u64)(dw2 & 0xffff) << 32);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index 0649b59830a5..15e8fe0e5e40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -89,10 +89,12 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>   void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>   void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>   			  unsigned int num_dw);
> -int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
> -					struct amdgpu_ih_ring *ih);
> +int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
> +					    struct amdgpu_ih_ring *ih);
>   int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
> +int amdgpu_ih_process1(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>   void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
>   				struct amdgpu_ih_ring *ih,
>   				struct amdgpu_iv_entry *entry);
> +uint64_t amdgpu_ih_decode_iv_ts(struct amdgpu_ih_ring *ih, u32 rptr);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index e9023687dc9a..891486cca94b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -224,7 +224,7 @@ static void amdgpu_irq_handle_ih1(struct work_struct *work)
>   	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
>   						  irq.ih1_work);
>   
> -	amdgpu_ih_process(adev, &adev->irq.ih1);
> +	amdgpu_ih_process1(adev, &adev->irq.ih1);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 88360f23eb61..9e566ec54cf5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1968,7 +1968,7 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
>   
>   		pr_debug("drain retry fault gpu %d svms %p\n", i, svms);
>   
> -		amdgpu_ih_wait_on_checkpoint_process(pdd->dev->adev,
> +		amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
>   						     &pdd->dev->adev->irq.ih1);
>   		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
>   	}
