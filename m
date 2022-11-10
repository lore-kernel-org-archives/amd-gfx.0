Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B495C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 19:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0BB710E7F8;
	Thu, 10 Nov 2022 19:27:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FB9110E7F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 19:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKsOnptQKL3MEPm5gOBjf8PQNeGichYTZlWlhJ4NGE7LmddV7G/5QL67uBQ93juZDKN/KcQJoM0Ptnw9xsvfNTuo9YLdxuGZ2nleqmTyirAVPBMIi0jyDXOtCW8XaFfkzzPyo1Ox9WPFIc7GEacQ9HygVzwpDqLdfOsg2dBBwbY5hc+PBua8ewocLm+taGgIketfwfwLiAJ9PmBtvNePyNp4NwuvXUysBu6RhR0MxM8SCOE05o8KW4PdCwLK0AlzD99pY/FgaSa18CsbbZA0cDY/igfxSTIRCBv1f05n1w+bHtitvv2EuXqQctMLwegWzsFg6W/DOPWOU736019qow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nj6NAlGdf5IuFqygL83IAEA66WTDXbDl72rq6Gzdqgw=;
 b=VyIBTLtlEjVgayi/Bf2bdnDoG9zH99yMWpqrOgRId/w/6QgP3J2Q7cBzhKK7vqqrQgPr0tTZGmBwtrjNK1fxURKpt+ypEzNUTOimtWFQ+AqbbBjxvUznI02ZfsDOBvQCbEIqdIET9vO1stdquw1QjxWG4ZRAWiRlnfhv+6+oe1HlTVOl3ViXbvgOBKbE/vcJNRx8ffoQ37UowgE/dbuqAtG/hu87Wnoj6H9yTdNfB7h8qXxkw8+xcKxQWJZjtM8Rsmqici3nS2+FY24vTOqpmMzUhkU5baZ7s1HNOnRDFko9LiWNCX3E4i/oVs8lQrXOcxQNPVkAXyYuY6rL3gF/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nj6NAlGdf5IuFqygL83IAEA66WTDXbDl72rq6Gzdqgw=;
 b=WNBbSa9rD0McaSncBNc++ZEC3ulnfm5xSc9vfq5S8Mbsvj+R123mhZK4e1IjBG+x4EH3em4wNJw50iYQ38Qwa7oSR2QXNL0crdQPIuhANaXMHpX/Nsk+z0DZ1CspKKE6oeskn9uX51l2S5KXhJZcCXt1QYpJQGLTqbevh/FF+Es=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.13; Thu, 10 Nov 2022 19:27:48 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5791.026; Thu, 10 Nov 2022
 19:27:48 +0000
Message-ID: <166a4109-0a35-6e77-64dd-69bd798096e7@amd.com>
Date: Thu, 10 Nov 2022 14:27:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-CA
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
 <20221018090815.2662321-4-jiadong.zhu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)
In-Reply-To: <20221018090815.2662321-4-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::30) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MW3PR12MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: 7325d791-5c9a-4099-f8e8-08dac351a672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FWjApZic23cm4g6ZKcSJzqCPXyxrwSdLEcJo4EMMxIZOcumSPRvonQMSdO8SqMKOdHmSXRpfe03Cp1CtSINNH7oGd0lovn3R4nfFpcoZbBllV31BwbGec8hslYgf1HM9TdfECCbnyW6V+jtgK4pFsaFRRxMJF7JHqZDmtngqmw4FVSVuudKO6yvYXQCou78uyB0XZbzopPLx+nL3UXvY3n20fpt6yDbLg6+mVH3vHspNOkZV17qZOFgeodKlAjcSQzE5PmMMBfnag1E8HDHo3t6mdMDdXe+pfh1KG3VIlEoXlbL8hvfmyakHDm6kP+YJ+qrkn2TScBMjHMoIPCr+NZ7gf/04keas0RbpdCvtOsHleBA0QT135Jk3kXjpxb6qKpnryhuq37I1cOZEMoRQ3nQMptqBjEtlG7xR/MEfKwyEct/SVqmNdmjNxeab7wLgzWDVIA9Hz8OZPIVXzrsThIVHR3WBZ40n2qBjGLOtvGmcmoLxMeT5I7eXWYvjDNpfCHGi5oXG+C4fVJ5jj+Fc3jsSByg7Tna+egbMvqqvQrlctWNGIBj1COhJY4iZPEcp0jMJy0kIaOYxD6Qh4g8q3B0BlE48w+lKyqoe7DgqaluK5NtLtIHPc/q7D8Ype9zBTgb3bH5VZ1WGjoXWBNE8KBH1p6ImosUOgfVzk2NRYUPNCqMuhGsI7+bzV5+gIP1/xKoGr47ElZPI4WuBLytaNbbFYeld+k6cr0p0TzwLhDTn91EdQxPOEzFKW1LDPXAAB7oL6Ptryo+uU9GbwRj8HZgdTUls1u+NCORQ8FJwUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199015)(6486002)(8676002)(31686004)(6666004)(478600001)(66556008)(4326008)(26005)(41300700001)(36756003)(6512007)(6506007)(53546011)(316002)(30864003)(54906003)(5660300002)(186003)(2616005)(8936002)(44832011)(2906002)(4001150100001)(83380400001)(66476007)(86362001)(31696002)(38100700002)(66574015)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFRtTFp0V2NQWmNvaUszSnJXcmhNVUdoSzcwN05tS0dlSWFvRy9JbkV0aWFY?=
 =?utf-8?B?NGRrVk1oSE9ybkdmTTRwTHU3YitnYWE1Y1F2VHN6a3ZLSlMwYmdjV2MyTFY1?=
 =?utf-8?B?T2RWemJ0RE54YSthaUZKd3RhWU9jMzdwSDRDT1h1K1o3ck9aQjVSd2lxbU0r?=
 =?utf-8?B?UStvTDFKVXJSYnJpa1RJNjl6MExubG9UZU15dkkvZVl3enBDbEJVRTMxWGlI?=
 =?utf-8?B?YTIvUmMzbFIzSFR6elR5WmJ1S2VzeEJLbmQ3QXdNWVFwQ0NlSHdObFJPeWlB?=
 =?utf-8?B?ZW9DbXpoU3U2aVArUG5wVzV3dENYcStUWUt2SmZGS0wwbU1Qc0dSRTFSTmhQ?=
 =?utf-8?B?VEJSUHlHcXN6ZDJEbUMxN3ZHdE5kVVRSdXpWSzE3WWRxcDF5OC9qQWNva2lS?=
 =?utf-8?B?U3A5NlZHT0NzcWRWRzFsNHljYkoxcnVhNFIxR05EZE9oZ0ZqYUtVbmdDQm5n?=
 =?utf-8?B?RUtVeEh6bEJkT0J2Nzc4TGVQQ1MraFNHOTczL1cyMkJ1K2NNWHMrNWhPcW9Y?=
 =?utf-8?B?MkpsYnFFUWh4N1p0QzJCL0U0SWVXWGtWOTR5Q3lwaldKZ2wvdDJQV2gyQU1o?=
 =?utf-8?B?OGU0U3ZWR0k5c2dMTG03U2xkZWxudzF3M3ZEaGZDYlFNeWlDcDZnMHJid0Zo?=
 =?utf-8?B?dFJQTG9pWU5EQVFhemE0ZzVBYzFjSWVwL0RndHdzVnp5MDBXSkVSMVJFNTBM?=
 =?utf-8?B?aVoyUWZwVFNZTUhkMEh2TjRMMkY0NTZnY01RNGh0VngvYnE0a1Rna0MzM2d5?=
 =?utf-8?B?M0c4b2ZzSUQyY3hZdTBDUW5qZGhBQ1VNUUlBeFNjNTExTHJuZzdWSVYrbm1G?=
 =?utf-8?B?NjdlSTMrUXdWZDFmODJaY2J4bU12OFdZRUVGV2ZoaElPVWthOEorWnNHSjNP?=
 =?utf-8?B?Z01vbktrUlB1VHpNaHNUeFBxMVppOWpOcWxiQ3RBMUlweU4xNWJPOU9PVW8v?=
 =?utf-8?B?d25SbUZnL01XQmlMRktHWEgyOUcyRDAreS9CcUpuMWllclFxYkxDV2NDQy9r?=
 =?utf-8?B?TnBjZTRyb0pBS3crcTE1N3RBL2NidVZDWEFpR0RPdDVTMjc2b1VDUnUwZXdu?=
 =?utf-8?B?TnNKKzBOY2VCbm5FN3JvQkhHZUY1QU15RXNWNkU4aFdNWVhxZTdzRzlyekVM?=
 =?utf-8?B?Vy9jakxhK1p4ZDA2WkRVMUZaa0kxVlI1dko4Q3QzRklXenBPYmRtc3cwOHgv?=
 =?utf-8?B?UytjSTBUelFlL2UvcXAyOEMxVW16TVZtOWVYSkZMWmtZd0RVeFRwOThCcURl?=
 =?utf-8?B?MW1ZU0xaZFNOMHlqT28yNTBtSzNHYzFDL1RWOWQ0cWdlNlFZbHB3QnRTbGhn?=
 =?utf-8?B?WDVOZG9ueVh4STBOWkJQNGI3eGk5b09LVVdERDIwZ1FhNFhOcDhaT0NYME9W?=
 =?utf-8?B?YUR2WnNZQnpVWmJGb05ST2pTNmZnRWROejh4UHcxeFFHRy9aTFlYdXQ1ZFdm?=
 =?utf-8?B?MndZY01HQ1BTaWI1Tlo5emNiQkFlcDBWOHFmWTFnaDlud3RLRzkzSXJQZUYx?=
 =?utf-8?B?eGs4cUtGWU9wVTVmUXhUQkEzTW9YVkhwWWlDQldlR0YzYmJOYXZCQ2dxRkZ6?=
 =?utf-8?B?enRrYkYxQkttYTRtK2lkbEt1ViszWlB0UUNvd2FrQy91RGltUVBBQVhEK2wv?=
 =?utf-8?B?NmVXOERyME9sRVE2WHI0WlJrZ1RPeE5WZTJvNkpTYkVVWTFHalRWUTc3a002?=
 =?utf-8?B?UVlSMi82bTdDajhWd1RGQlFDcWdBcVZBdnp2SS9TMXA0bzZaVXpOWlFiUmZm?=
 =?utf-8?B?Y05CRE5mTlhQSHh3OGZuWE5qd1pOYzZjdWt0OEpLbzJRRTFtZXQyV0pKQ3U1?=
 =?utf-8?B?ZXVPTkhRY2c5Mnh1b01TdUhSYWZUNnZwZ0EyMGN4ckhvWEplOE9uR1Q4VkU4?=
 =?utf-8?B?cWRVUFR5UnJmSTdvK3NhMWFnalVQc0NJZVlQcnk3bEc1a1hSQS92U0JyaEdV?=
 =?utf-8?B?UGwva0YvbGI3SFhDWDV0cXVXRUNzMWFIaEV0Vys0Y2JGUWhiUklyRHZGTDQ3?=
 =?utf-8?B?N0RqLzBwaG90WG9SMm1ZcDR2N0pWTCtUdDlmYm5yTnl1ZXFnOGZvSnpQWDB6?=
 =?utf-8?B?eEh1VGpNT29INzFaQ3BvTU1GSS8vTU1JS09uZjYydWhGS2tCYk9VZFEzeVNw?=
 =?utf-8?Q?2/wMm1DY8/UQXDs+2lkKpGmoE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7325d791-5c9a-4099-f8e8-08dac351a672
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 19:27:48.3197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Xu9Zc0gTtlZfQgMbDOUopNudddidC/P69riYAKVcgjh0Klz5NsyUfUG5YhOyp9d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4475
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
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Huang Rui <ray.huang@amd.com>, Christian Koenig <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-10-18 05:08, jiadong.zhu@amd.com wrote:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
> 
> Trigger Mid-Command Buffer Preemption according to the priority of the software
> rings and the hw fence signalling condition.
> 
> The muxer saves the locations of the indirect buffer frames from the software
> ring together with the fence sequence number in its fifo queue, and pops out
> those records when the fences are signalled. The locations are used to resubmit
> packages in preemption scenarios by coping the chunks from the software ring.
> 
> v2: Update comment style.
> v3: Fix conflict caused by previous modifications.
> v4: Remove unnecessary prints.
> v5: Fix corner cases for resubmission cases.
> v6: Refactor functions for resubmission, calling fence_process in irq handler.
> v7: Solve conflict for removing amdgpu_sw_ring.c.
> v8: Add time threshold to judge if preemption request is needed.
> 
> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Michel Dänzer <michel@daenzer.net>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> Acked-by: Luben Tuikov <luben.tuikov@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c    |  53 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c       |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c     |  12 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 353 +++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  29 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c       |   2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        |   7 +-
>  8 files changed, 420 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 790f7bfdc654..470448bc1ebb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -54,6 +54,7 @@ struct amdgpu_fence {
>  
>  	/* RB, DMA, etc. */
>  	struct amdgpu_ring		*ring;
> +	ktime_t				start_timestamp;
>  };
>  
>  static struct kmem_cache *amdgpu_fence_slab;
> @@ -199,6 +200,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>  	rcu_assign_pointer(*ptr, dma_fence_get(fence));
>  
>  	*f = fence;
> +	to_amdgpu_fence(fence)->start_timestamp = ktime_get();
>  
>  	return 0;
>  }
> @@ -400,6 +402,57 @@ unsigned amdgpu_fence_count_emitted(struct amdgpu_ring *ring)
>  	return lower_32_bits(emitted);
>  }
>  
> +/**
> + * amdgpu_fence_last_unsignaled_time_us - the time fence emited till now

Spelling: emitted until

> + * @ring: ring the fence is associated with
> + *
> + * Find the earlist fence unsignaled till now, calculate the time delta

Spelling: earliest fence unsignalled until

> + * between the time fence emitted and now.
> + */
> +u64 amdgpu_fence_last_unsignaled_time_us(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_fence_driver *drv = &ring->fence_drv;
> +	struct dma_fence *fence;
> +	uint32_t last_seq, sync_seq;
> +
> +	last_seq = atomic_read(&ring->fence_drv.last_seq);
> +	sync_seq = READ_ONCE(ring->fence_drv.sync_seq);
> +	if (last_seq == sync_seq)
> +		return 0;
> +
> +	++last_seq;
> +	last_seq &= drv->num_fences_mask;
> +	fence = drv->fences[last_seq];
> +	if (!fence)
> +		return 0;
> +
> +	return ktime_us_delta(ktime_get(),
> +		to_amdgpu_fence(fence)->start_timestamp);
> +}
> +
> +/**
> + * amdgpu_fence_update_start_timestamp - update the timestamp of the fence
> + * @ring: ring the fence is associated with
> + * @seq: the fence seq number to update.
> + * @timestamp: the start timestamp to update.
> + *
> + * The function called at the time the fence and related ib is about to
> + * resubmit to gpu in MCBP scenario. Thus we do not consider race condition
> + * with amdgpu_fence_process to modify the same fence.
> + */
> +void amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring, uint32_t seq, ktime_t timestamp)
> +{
> +	struct amdgpu_fence_driver *drv = &ring->fence_drv;
> +	struct dma_fence *fence;
> +
> +	seq &= drv->num_fences_mask;
> +	fence = drv->fences[seq];
> +	if (!fence)
> +		return;
> +
> +	to_amdgpu_fence(fence)->start_timestamp = timestamp;
> +}
> +
>  /**
>   * amdgpu_fence_driver_start_ring - make the fence driver
>   * ready for use on the requested ring.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 258cffe3c06a..af86d87e2f3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -211,6 +211,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>  		}
>  	}
>  
> +	amdgpu_ring_ib_begin(ring);
>  	if (job && ring->funcs->init_cond_exec)
>  		patch_offset = amdgpu_ring_init_cond_exec(ring);
>  
> @@ -285,6 +286,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>  	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
>  		ring->funcs->emit_wave_limit(ring, false);
>  
> +	amdgpu_ring_ib_end(ring);
>  	amdgpu_ring_commit(ring);
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 13db99d653bd..1f15f9242e99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -569,3 +569,15 @@ int amdgpu_ring_init_mqd(struct amdgpu_ring *ring)
>  
>  	return mqd_mgr->init_mqd(adev, ring->mqd_ptr, &prop);
>  }
> +
> +void amdgpu_ring_ib_begin(struct amdgpu_ring *ring)
> +{
> +	if (ring->is_sw_ring)
> +		amdgpu_sw_ring_ib_begin(ring);
> +}
> +
> +void amdgpu_ring_ib_end(struct amdgpu_ring *ring)
> +{
> +	if (ring->is_sw_ring)
> +		amdgpu_sw_ring_ib_end(ring);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index e90d327a589e..8f82fd0d47c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -145,6 +145,9 @@ signed long amdgpu_fence_wait_polling(struct amdgpu_ring *ring,
>  				      uint32_t wait_seq,
>  				      signed long timeout);
>  unsigned amdgpu_fence_count_emitted(struct amdgpu_ring *ring);
> +u64 amdgpu_fence_last_unsignaled_time_us(struct amdgpu_ring *ring);
> +void amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring, uint32_t seq,
> +					 ktime_t timestamp);

FYI: A conflict exists here with latest amd-staging-drm-next. Easy to fix.

Regards,
Luben

>  
>  /*
>   * Rings.
> @@ -312,6 +315,9 @@ struct amdgpu_ring {
>  #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
>  
>  int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
> +void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);
> +void amdgpu_ring_ib_end(struct amdgpu_ring *ring);
> +
>  void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
>  void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
>  void amdgpu_ring_commit(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> index 2e64ffccc030..41b057b9358e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -28,6 +28,7 @@
>  #include "amdgpu.h"
>  
>  #define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ / 2)
> +#define AMDGPU_MAX_LAST_UNSIGNALED_THRESHOLD_US 10000
>  
>  static const struct ring_info {
>  	unsigned int hw_pio;
> @@ -37,23 +38,145 @@ static const struct ring_info {
>  	{ AMDGPU_RING_PRIO_2, "gfx_high"},
>  };
>  
> +static struct kmem_cache *amdgpu_mux_chunk_slab;
> +
> +static inline struct amdgpu_mux_entry *amdgpu_ring_mux_sw_entry(struct amdgpu_ring_mux *mux,
> +								struct amdgpu_ring *ring)
> +{
> +	return ring->entry_index < mux->ring_entry_size ?
> +			&mux->ring_entry[ring->entry_index] : NULL;
> +}
> +
> +/* copy packages on sw ring range[begin, end) */
> +static void amdgpu_ring_mux_copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
> +						  struct amdgpu_ring *ring,
> +						  u64 s_start, u64 s_end)
> +{
> +	u64 start, end;
> +	struct amdgpu_ring *real_ring = mux->real_ring;
> +
> +	start = s_start & ring->buf_mask;
> +	end = s_end & ring->buf_mask;
> +
> +	if (start == end) {
> +		DRM_ERROR("no more data copied from sw ring\n");
> +		return;
> +	}
> +	if (start > end) {
> +		amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - start);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start],
> +					   (ring->ring_size >> 2) - start);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
> +	} else {
> +		amdgpu_ring_alloc(real_ring, end - start);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start], end - start);
> +	}
> +}
> +
> +static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux)
> +{
> +	struct amdgpu_mux_entry *e = NULL;
> +	struct amdgpu_mux_chunk *chunk;
> +	uint32_t seq, last_seq;
> +	int i;
> +
> +	/*find low priority entries:*/
> +	if (!mux->s_resubmit)
> +		return;
> +
> +	for (i = 0; i < mux->num_ring_entries; i++) {
> +		if (mux->ring_entry[i].ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT) {
> +			e = &mux->ring_entry[i];
> +			break;
> +		}
> +	}
> +
> +	if (!e) {
> +		DRM_ERROR("%s no low priority ring found\n", __func__);
> +		return;
> +	}
> +
> +	last_seq = atomic_read(&e->ring->fence_drv.last_seq);
> +	seq = mux->seqno_to_resubmit;
> +	if (last_seq < seq) {
> +		/*resubmit all the fences between (last_seq, seq]*/
> +		list_for_each_entry(chunk, &e->list, entry) {
> +			if (chunk->sync_seq > last_seq && chunk->sync_seq <= seq) {
> +				amdgpu_fence_update_start_timestamp(e->ring,
> +								    chunk->sync_seq,
> +								    ktime_get());
> +				amdgpu_ring_mux_copy_pkt_from_sw_ring(mux, e->ring,
> +								      chunk->start,
> +								      chunk->end);
> +				mux->wptr_resubmit = chunk->end;
> +				amdgpu_ring_commit(mux->real_ring);
> +			}
> +		}
> +	}
> +
> +	del_timer(&mux->resubmit_timer);
> +	mux->s_resubmit = false;
> +}
> +
> +static void amdgpu_ring_mux_schedule_resubmit(struct amdgpu_ring_mux *mux)
> +{
> +	mod_timer(&mux->resubmit_timer, jiffies + AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT);
> +}
> +
> +static void amdgpu_mux_resubmit_fallback(struct timer_list *t)
> +{
> +	struct amdgpu_ring_mux *mux = from_timer(mux, t, resubmit_timer);
> +
> +	if (!spin_trylock(&mux->lock)) {
> +		amdgpu_ring_mux_schedule_resubmit(mux);
> +		DRM_ERROR("reschedule resubmit\n");
> +		return;
> +	}
> +	amdgpu_mux_resubmit_chunks(mux);
> +	spin_unlock(&mux->lock);
> +}
> +
>  int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>  			 unsigned int entry_size)
>  {
>  	mux->real_ring = ring;
>  	mux->num_ring_entries = 0;
> +
>  	mux->ring_entry = kcalloc(entry_size, sizeof(struct amdgpu_mux_entry), GFP_KERNEL);
>  	if (!mux->ring_entry)
>  		return -ENOMEM;
>  
>  	mux->ring_entry_size = entry_size;
> +	mux->s_resubmit = false;
> +
> +	amdgpu_mux_chunk_slab = kmem_cache_create("amdgpu_mux_chunk",
> +						  sizeof(struct amdgpu_mux_chunk), 0,
> +						  SLAB_HWCACHE_ALIGN, NULL);
> +	if (!amdgpu_mux_chunk_slab) {
> +		DRM_ERROR("create amdgpu_mux_chunk cache failed\n");
> +		return -ENOMEM;
> +	}
> +
>  	spin_lock_init(&mux->lock);
> +	timer_setup(&mux->resubmit_timer, amdgpu_mux_resubmit_fallback, 0);
>  
>  	return 0;
>  }
>  
>  void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
>  {
> +	struct amdgpu_mux_entry *e;
> +	struct amdgpu_mux_chunk *chunk, *chunk2;
> +	int i;
> +
> +	for (i = 0; i < mux->num_ring_entries; i++) {
> +		e = &mux->ring_entry[i];
> +		list_for_each_entry_safe(chunk, chunk2, &e->list, entry) {
> +			list_del(&chunk->entry);
> +			kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
> +		}
> +	}
> +	kmem_cache_destroy(amdgpu_mux_chunk_slab);
>  	kfree(mux->ring_entry);
>  	mux->ring_entry = NULL;
>  	mux->num_ring_entries = 0;
> @@ -73,62 +196,48 @@ int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>  	ring->entry_index = mux->num_ring_entries;
>  	e->ring = ring;
>  
> +	INIT_LIST_HEAD(&e->list);
>  	mux->num_ring_entries += 1;
>  	return 0;
>  }
>  
> -static inline struct amdgpu_mux_entry *amdgpu_ring_mux_sw_entry(struct amdgpu_ring_mux *mux,
> -								struct amdgpu_ring *ring)
> -{
> -	return ring->entry_index < mux->ring_entry_size ?
> -			&mux->ring_entry[ring->entry_index] : NULL;
> -}
> -
> -/* copy packages on sw ring range[begin, end) */
> -static void amdgpu_ring_mux_copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
> -						  struct amdgpu_ring *ring,
> -						  u64 s_start, u64 s_end)
> -{
> -	u64 start, end;
> -	struct amdgpu_ring *real_ring = mux->real_ring;
> -
> -	start = s_start & ring->buf_mask;
> -	end = s_end & ring->buf_mask;
> -
> -	if (start == end) {
> -		DRM_ERROR("no more data copied from sw ring\n");
> -		return;
> -	}
> -	if (start > end) {
> -		amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - start);
> -		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start],
> -					   (ring->ring_size >> 2) - start);
> -		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
> -	} else {
> -		amdgpu_ring_alloc(real_ring, end - start);
> -		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start], end - start);
> -	}
> -}
> -
>  void amdgpu_ring_mux_set_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr)
>  {
>  	struct amdgpu_mux_entry *e;
>  
> +	spin_lock(&mux->lock);
> +
> +	if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT)
> +		amdgpu_mux_resubmit_chunks(mux);
> +
>  	e = amdgpu_ring_mux_sw_entry(mux, ring);
>  	if (!e) {
>  		DRM_ERROR("cannot find entry for sw ring\n");
> +		spin_unlock(&mux->lock);
> +		return;
> +	}
> +
> +	/* We could skip this set wptr as preemption in process. */
> +	if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT && mux->pending_trailing_fence_signaled) {
> +		spin_unlock(&mux->lock);
>  		return;
>  	}
>  
> -	spin_lock(&mux->lock);
>  	e->sw_cptr = e->sw_wptr;
> +	/* Update cptr if the package already copied in resubmit functions */
> +	if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT && e->sw_cptr < mux->wptr_resubmit)
> +		e->sw_cptr = mux->wptr_resubmit;
>  	e->sw_wptr = wptr;
>  	e->start_ptr_in_hw_ring = mux->real_ring->wptr;
>  
> -	amdgpu_ring_mux_copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr);
> -	e->end_ptr_in_hw_ring = mux->real_ring->wptr;
> -	amdgpu_ring_commit(mux->real_ring);
> -
> +	/* Skip copying for the packages already resubmitted.*/
> +	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT || mux->wptr_resubmit < wptr) {
> +		amdgpu_ring_mux_copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr);
> +		e->end_ptr_in_hw_ring = mux->real_ring->wptr;
> +		amdgpu_ring_commit(mux->real_ring);
> +	} else {
> +		e->end_ptr_in_hw_ring = mux->real_ring->wptr;
> +	}
>  	spin_unlock(&mux->lock);
>  }
>  
> @@ -145,7 +254,7 @@ u64 amdgpu_ring_mux_get_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ri
>  	return e->sw_wptr;
>  }
>  
> -/*
> +/**
>   * The return value of the readptr is not precise while the other rings could
>   * write data onto the real ring buffer.After overwriting on the real ring, we
>   * can not decide if our packages have been excuted or not read yet. However,
> @@ -235,3 +344,169 @@ unsigned int amdgpu_sw_ring_priority(int idx)
>  	return idx < ARRAY_SIZE(sw_ring_info) ?
>  		sw_ring_info[idx].hw_pio : AMDGPU_RING_PRIO_DEFAULT;
>  }
> +
> +/*Scan on low prio rings to have unsignaled fence and high ring has no fence.*/
> +int amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux)
> +{
> +	struct amdgpu_ring *ring;
> +	int i, need_preempt;
> +
> +	need_preempt = 0;
> +	for (i = 0; i < mux->num_ring_entries; i++) {
> +		ring = mux->ring_entry[i].ring;
> +		if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT &&
> +		    amdgpu_fence_count_emitted(ring) > 0)
> +			return 0;
> +		if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT &&
> +		    amdgpu_fence_last_unsignaled_time_us(ring) >
> +		    AMDGPU_MAX_LAST_UNSIGNALED_THRESHOLD_US)
> +			need_preempt = 1;
> +	}
> +	return need_preempt && !mux->s_resubmit;
> +}
> +
> +/* Trigger Mid-Command Buffer Preemption (MCBP) and find if we need to resubmit. */
> +int amdgpu_mcbp_trigger_preempt(struct amdgpu_ring_mux *mux)
> +{
> +	int r;
> +
> +	spin_lock(&mux->lock);
> +	mux->pending_trailing_fence_signaled = true;
> +	r = amdgpu_ring_preempt_ib(mux->real_ring);
> +	spin_unlock(&mux->lock);
> +	return r;
> +}
> +
> +void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	WARN_ON(!ring->is_sw_ring);
> +	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT) {
> +		if (amdgpu_mcbp_scan(mux) > 0)
> +			amdgpu_mcbp_trigger_preempt(mux);
> +		return;
> +	}
> +
> +	amdgpu_ring_mux_start_ib(mux, ring);
> +}
> +
> +void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	WARN_ON(!ring->is_sw_ring);
> +	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT)
> +		return;
> +	amdgpu_ring_mux_end_ib(mux, ring);
> +}
> +
> +void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +	struct amdgpu_mux_chunk *chunk;
> +
> +	spin_lock(&mux->lock);
> +	amdgpu_mux_resubmit_chunks(mux);
> +	spin_unlock(&mux->lock);
> +
> +	e = amdgpu_ring_mux_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("cannot find entry!\n");
> +		return;
> +	}
> +
> +	chunk = kmem_cache_alloc(amdgpu_mux_chunk_slab, GFP_KERNEL);
> +	if (!chunk) {
> +		DRM_ERROR("alloc amdgpu_mux_chunk_slab failed\n");
> +		return;
> +	}
> +
> +	chunk->start = ring->wptr;
> +	list_add_tail(&chunk->entry, &e->list);
> +}
> +
> +static void scan_and_remove_signaled_chunk(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	uint32_t last_seq, size = 0;
> +	struct amdgpu_mux_entry *e;
> +	struct amdgpu_mux_chunk *chunk, *tmp;
> +
> +	e = amdgpu_ring_mux_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("cannot find entry!\n");
> +		return;
> +	}
> +
> +	last_seq = atomic_read(&ring->fence_drv.last_seq);
> +
> +	list_for_each_entry_safe(chunk, tmp, &e->list, entry) {
> +		if (chunk->sync_seq <= last_seq) {
> +			list_del(&chunk->entry);
> +			kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
> +		} else {
> +			size++;
> +		}
> +	}
> +}
> +
> +void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +	struct amdgpu_mux_chunk *chunk;
> +
> +	e = amdgpu_ring_mux_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("cannot find entry!\n");
> +		return;
> +	}
> +
> +	chunk = list_last_entry(&e->list, struct amdgpu_mux_chunk, entry);
> +	if (!chunk) {
> +		DRM_ERROR("cannot find chunk!\n");
> +		return;
> +	}
> +
> +	chunk->end = ring->wptr;
> +	chunk->sync_seq = READ_ONCE(ring->fence_drv.sync_seq);
> +
> +	scan_and_remove_signaled_chunk(mux, ring);
> +}
> +
> +bool amdgpu_mcbp_handle_trailing_fence_irq(struct amdgpu_ring_mux *mux)
> +{
> +	struct amdgpu_mux_entry *e;
> +	struct amdgpu_ring *ring = NULL;
> +	int i;
> +
> +	if (!mux->pending_trailing_fence_signaled)
> +		return false;
> +
> +	if (mux->real_ring->trail_seq != le32_to_cpu(*mux->real_ring->trail_fence_cpu_addr))
> +		return false;
> +
> +	for (i = 0; i < mux->num_ring_entries; i++) {
> +		e = &mux->ring_entry[i];
> +		if (e->ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT) {
> +			ring = e->ring;
> +			break;
> +		}
> +	}
> +
> +	if (!ring) {
> +		DRM_ERROR("cannot find low priority ring\n");
> +		return false;
> +	}
> +
> +	amdgpu_fence_process(ring);
> +	if (amdgpu_fence_count_emitted(ring) > 0) {
> +		mux->s_resubmit = true;
> +		mux->seqno_to_resubmit = ring->fence_drv.sync_seq;
> +		amdgpu_ring_mux_schedule_resubmit(mux);
> +	}
> +
> +	mux->pending_trailing_fence_signaled = false;
> +	return true;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> index 28399f4b0e5c..aa758ebc86ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> @@ -29,6 +29,7 @@
>  #include "amdgpu_ring.h"
>  
>  struct amdgpu_ring;
> +
>  /**
>   * struct amdgpu_mux_entry - the entry recording software rings copying information.
>   * @ring: the pointer to the software ring.
> @@ -37,6 +38,7 @@ struct amdgpu_ring;
>   * @sw_cptr: the position of the copy pointer in the sw ring.
>   * @sw_rptr: the read pointer in software ring.
>   * @sw_wptr: the write pointer in software ring.
> + * @list: list head for amdgpu_mux_chunk
>   */
>  struct amdgpu_mux_entry {
>  	struct                  amdgpu_ring *ring;
> @@ -45,6 +47,7 @@ struct amdgpu_mux_entry {
>  	u64                     sw_cptr;
>  	u64                     sw_rptr;
>  	u64                     sw_wptr;
> +	struct list_head        list;
>  };
>  
>  struct amdgpu_ring_mux {
> @@ -55,6 +58,26 @@ struct amdgpu_ring_mux {
>  	unsigned int            ring_entry_size;
>  	/*the lock for copy data from different software rings*/
>  	spinlock_t              lock;
> +	bool                    s_resubmit;
> +	uint32_t                seqno_to_resubmit;
> +	u64                     wptr_resubmit;
> +	struct timer_list       resubmit_timer;
> +
> +	bool                    pending_trailing_fence_signaled;
> +};
> +
> +/**
> + * struct amdgpu_mux_chunk - save the location of indirect buffer's package on softare rings.
> + * @entry: the list entry.
> + * @sync_seq: the fence seqno related with the saved IB.
> + * @start:- start location on the software ring.
> + * @end:- end location on the software ring.
> + */
> +struct amdgpu_mux_chunk {
> +	struct list_head        entry;
> +	uint32_t                sync_seq;
> +	u64                     start;
> +	u64                     end;
>  };
>  
>  int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> @@ -64,15 +87,17 @@ int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>  void amdgpu_ring_mux_set_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr);
>  u64 amdgpu_ring_mux_get_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
>  u64 amdgpu_ring_mux_get_rptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +bool amdgpu_mcbp_handle_trailing_fence_irq(struct amdgpu_ring_mux *mux);
>  
>  u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring);
>  u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring);
>  void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring);
> -
>  void amdgpu_sw_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
>  void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring);
>  void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
> -
>  const char *amdgpu_sw_ring_name(int idx);
>  unsigned int amdgpu_sw_ring_priority(int idx);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 9596c22fded6..b7e94553f4fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -601,6 +601,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync)
>  		return 0;
>  
> +	amdgpu_ring_ib_begin(ring);
>  	if (ring->funcs->init_cond_exec)
>  		patch_offset = amdgpu_ring_init_cond_exec(ring);
>  
> @@ -661,6 +662,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  		amdgpu_ring_emit_switch_buffer(ring);
>  		amdgpu_ring_emit_switch_buffer(ring);
>  	}
> +	amdgpu_ring_ib_end(ring);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 01ec0551d26a..42bda7766e11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5620,7 +5620,7 @@ static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ring *ring)
>  	ring->trail_seq += 1;
>  	amdgpu_ring_alloc(ring, 13);
>  	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
> -				 ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC);
> +				 ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC | AMDGPU_FENCE_FLAG_INT);
>  	/*reset the CP_VMID_PREEMPT after trailing fence*/
>  	amdgpu_ring_emit_wreg(ring,
>  			      SOC15_REG_OFFSET(GC, 0, mmCP_VMID_PREEMPT),
> @@ -6046,8 +6046,9 @@ static int gfx_v9_0_eop_irq(struct amdgpu_device *adev,
>  
>  	switch (me_id) {
>  	case 0:
> -		/* Fence signals are handled on the software rings*/
> -		if (adev->gfx.num_gfx_rings) {
> +		if (adev->gfx.num_gfx_rings &&
> +		    !amdgpu_mcbp_handle_trailing_fence_irq(&adev->gfx.muxer)) {
> +			/* Fence signals are handled on the software rings*/
>  			for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
>  				amdgpu_fence_process(&adev->gfx.sw_gfx_ring[i]);
>  		}

