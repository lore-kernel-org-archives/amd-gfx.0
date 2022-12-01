Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7F5C4321E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Dec 2022 08:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABD5210E02A;
	Thu,  1 Dec 2022 08:34:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B3410E02A
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Dec 2022 08:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIqY0y5c7Q5VLY1DqqxE2am1taOgnEc/KNNta0FufUBRWeR0XeEf3Ke2TZHe4RdsjBtvnQnVI/oBn6s4FXEuS6/wUODvON3U4hIz7PVVkyexEtHI3QDuItJRI11NM/LRrdc4YhCthi7gQh9wnsRKySKFUtVO6TPngjSOba26Q10cyCOiwWFIumWkgPNioqFtWd5vEYu3YoW2jQ7iyThfCkvBV+B3Uo/8bHRBHz9G4yr80BfafP3EnEzZUvJd9pAqWEqY0P0VkPIKmaE60DGNmuz4nvAew+oucUAULRpoJvbxVSg+gd2ELjn9GrytEth69/+723dNgyUyMM+dmVoVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIEOO3ir7P4NsmbVNNCoFSMFpgud5DnMop/+oeDVZXU=;
 b=mne/ZmnUy8FUW70M2m+y50XnakaF9lVK5BWxbr8nUrLQKnqQv+M1pTNUCGNAtJ3OCu0b2dQPDDIGyMm3KE+Wvz0VOkLv4JNZLgrFk4T05ytRAhae7Ha6zrhIxrqPJB2o2qJctsD3gdkABdg6Cx55dDTlDYKYt71stRL8DLhNKd6emSF8ItrUWoP4VPy3GjWTjG67Bzt8J8A8wyS6EAHj0Mtbl4DPUaV3TgK92nFcnyFEz8SCAa6M2599Qd9j18rIeqpLCDFEKqfMlWLy4KytRtibWVjz7snMVDfE4nFtOhyrVfOC9IaTsvaP6B3Y+ryMgAz8cJrfFCIcriM4SEGCZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIEOO3ir7P4NsmbVNNCoFSMFpgud5DnMop/+oeDVZXU=;
 b=iZH5ojthB8CYo4ojqxoaO8Hpl9/dn3NAX5KgJtq8HmHVkKky23KlB3c1L6/kWTQnlNQcu0lpBnB5+SLani2EUi/oFifXE4FbwT6Z2ViGE1rbarmYslc0QtqIfsE0hxwdfoH2DehbnkJx/+itZQ3j0PF34P0eQKGfttD3KNFxZJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 08:34:48 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 08:34:48 +0000
Message-ID: <554d7cce-dbb1-d403-80ca-65441704778a@amd.com>
Date: Thu, 1 Dec 2022 03:34:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 4/4] drm/amdgpu: MCBP based on DRM scheduler (v9)
Content-Language: en-CA
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20221129071037.531124-1-jiadong.zhu@amd.com>
 <20221129071037.531124-4-jiadong.zhu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20221129071037.531124-4-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::14) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fdb404-a343-4da8-ae0a-08dad376e806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KU0F7z5aehZ/MSBZfdNEjzoG6NP8hlM4FQkoXKw58Tm0M1GLXcoAEoz+xjwSMZ8wrMhPai5HJfRSa9Nj6YMjO3i2uDVhgj9aJ7zL86gw5ghJ8FO5Yw1/GXmQHlSe6Ap3bnlPwQDzTJSOxS2euzEwNQoOTvuytdfI/mZv8BPbLMJAMlJk9DNSRIfu+C7oPj1sLtvR5LPsVO1YT4tZLTBnJn8IHi4wtsuEKBmB7z7SjrNdOrbqFUn9+9GciRYdm5ZIK0HPiZo/MWFaFQ1qOlqJvrdAy9BQVP2DQlrXOGqd3ljSN++svQUsBE9pVYTt9WOcDLE7EvPyfhPXMZgt89IY+Q2g9JAKExIR/FQd/JxUUXv9/WPASCuiZijyvDlEYMwpxjwqqUQfkd53vl+RBnTlx7PP1fWGtMb3N0+IMF0ohPVMJCFIa+ril4vYfqZD1N9HL9qmyGqdFkfQuiRpu6XE9L/kkQaIUQjyQC8Qfjzx3CV429ceV4zVb97coAwtsMIGqIy7moV2YZFbhlwzFbStFUGqF5UndyReZA/a6xQPVUHy0hkdJbsxW4NXRbzD/46sbsCghBth7e1kfDGCubG0IT7Lu1VglKnzeEGf24NmNYcuWyY+H1T8pt5PnnJ9ZTN9AYsY1RcQv9GkcVHjs3P6SufY2j1pcKk2knhfz8bxKdq5YEzyHiT/cLBhHhuetgVb44kIettenPrbCxWQXRnfiGF1c/hIO2FJpVxHSP2Q/TE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199015)(31696002)(83380400001)(86362001)(2906002)(44832011)(66574015)(66476007)(4001150100001)(41300700001)(30864003)(54906003)(26005)(6512007)(8936002)(5660300002)(53546011)(6506007)(4326008)(6666004)(186003)(2616005)(316002)(6486002)(66946007)(8676002)(66556008)(478600001)(38100700002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDFUR1BnSk9FRWFhbXNTSW51ako0amhJR3VqKzRwUlZ5UHVveUxrQ2M5dkhj?=
 =?utf-8?B?emFRdUNha3JlT0JkTkE3VEhHQ3ovRHl1MnFZQ3hweUwzcWMxaEZHWVhaSURO?=
 =?utf-8?B?MFpsNDhhZE12RTk2d0M0WVFUTVJPZ2JCTFBEWHU2ektwa0tsNzExYU1EMk1H?=
 =?utf-8?B?NGZTNUhLK25uZXJOWWNoOWk1bVhlc3VDcWRrTEh6WTE0UVZ6WE16UjM2Zmh0?=
 =?utf-8?B?SDBCREtSdVF5NEduS1QwbS9ubjc0V0FvMU9hWlBTalZkT21QOUwyVW5TaVZO?=
 =?utf-8?B?VWIvck5aVzBabXgrWWt2TGdDRUxpLzVjRmJzQWNmeVVnZWZwTkx3WlZkSEpx?=
 =?utf-8?B?QU1ndDB4R0toRjlOMG03MVU0VkFhYU9yUDdEeUluRjQyTzB4Wms0NzEyU3Vq?=
 =?utf-8?B?TFc1bDQxMENJamhEelNLbktlVjFDWHY1WFFMUDRtV2dNL3R1amxuNjZpd2FW?=
 =?utf-8?B?b2JkQVRsTnNUOUgySkY0ZjhuUHlMREJCVXVJZE5YYk9sODlsQlB0Tm00a0V2?=
 =?utf-8?B?d3VFRmQ3V1pKQlk1Y1N3T1RjOHFUNWJsbUJGZFRhNHBmOWU3K2ZsSTArK3d3?=
 =?utf-8?B?U0lxQkVlNVM2Vi9WUmQwbTlXRHFXUmlSZkVZdnMvSXhkRXl0Q0k4RktxVDhP?=
 =?utf-8?B?bFl2SndyVkM2TkJXOEVzRExYb3JMSU1zbVNpMDdCeHFicnQxNUJ1c0piYlkx?=
 =?utf-8?B?eWVYUUx1OGxFRzY5UDR2dXhYaGhRK1ZmUDAvempJbytJaFU1RVZST1liVXJo?=
 =?utf-8?B?MnV2ckxDZTIzRUZ0YTBMZnlFNjZBeU5rZWYvVkFLdlhEVGJiekg1VlBSbldw?=
 =?utf-8?B?YllGQVgyaGtjMXBFVG10WWZOcTY4M3gwT2RWbDZMUlhXL2J3TzBtdW1ienpZ?=
 =?utf-8?B?SlMyS0lsR1J4VFZiY1FCaFloWVYxNmQ5LzFiMm1pbmFHaXdqSTh2TllLUkFU?=
 =?utf-8?B?dDUrMzBtQlVzaDNLRFJ3aDJpNElCSGNCOWJYUjBqOXJSQm1BT0lTaFBkbWNo?=
 =?utf-8?B?SXhZMVovSWpYMGcxOGhkUkkrZXAwcUNEV3RsZGZUTkpYdDFhbU9LNlo0bkx1?=
 =?utf-8?B?T3FWcnp4R2xwd0s5U0FIY1ovcXA2RDhDNm9QRWVDYjhmL1RtNU5wbGZvZERC?=
 =?utf-8?B?cER4MjFMc1NJNGVndWlEZ3hnMWh5YW5SMzZaUnZVQmlVUTIyK0QxRHdXTDF6?=
 =?utf-8?B?d1FGNExoTm0zRkFibFdHcmJWVTFQclo2cEFsaTFxU1luN1VEQXBUckUreWND?=
 =?utf-8?B?MFJBenBSekNCRktmRVROMEdmOHZjbTNRYU5ROWFFRzNTVzdFMVpwNG1ua1Jv?=
 =?utf-8?B?ZUlienVWL2QyQjVOTXdTUisySm1BdUV5UXdEMlIwakY1Rjkxc2Z5OWJCUFBP?=
 =?utf-8?B?ZGM3Vm9KWWIxb1pKa3E4dUNwa01EVlg3YUsrM2dJdXpUY0xyUkVaRjhXUXpr?=
 =?utf-8?B?SjNXaFcyOElFbm9PZHlHaExZRmVCcWpnclJ1VS9xdjB1bnk1RS9nL0M4RjN1?=
 =?utf-8?B?ODhFOElTQ096Z2hTUGFzOS8xR05UNysvR1BMbVV1bExGd3BNRVdvQ0xmUXlh?=
 =?utf-8?B?VHd1Ny9nMTNXVFg4MHF4dmFkUFM4QmpDd3VmTzFKSzV6bnNhRTNyQStUWEd4?=
 =?utf-8?B?SEJGcFhOKzhTdGIrNTlXdEZucjlSSHFpcDB0V2I5TzBTZG5qUnU1Q0xOQjE5?=
 =?utf-8?B?ZHdOeHlZWE10OEtOWnJ5R1FrRkFZS1dtOWxyUmxLRVE3UE14QnNYYWRyV1l4?=
 =?utf-8?B?UmVPSEZNSkY0a3JxeDgzRDZXUFNuT2VNRkwxeUMwZENZZC9sVDR4SVpkZkRs?=
 =?utf-8?B?a2twdDNtcWxYSXBhcld4c3VkSEN0cmtNWnZ3OE9Vd0EzVkUwL24xcVR2bXFJ?=
 =?utf-8?B?S2g4UFNwLzVNbFlXTGxaUnlmTGY3ajZuWURWNGtsQkhFbTNvVEQ0bVRPNDdW?=
 =?utf-8?B?dDM5V29ycUN0UU5WN0pEV3NLT3NQcEF6aU5nM0dPV2VmNXF2VEFrKzBoYmJ1?=
 =?utf-8?B?Q1VObERLT2YwemI5Y2JGcUt5S0dEOWhCME0wazJSMDkyM1Nnd3FEWU9TYmNQ?=
 =?utf-8?B?Z0hJbjMwRm5CRXJQWjhIM2VUZXFMRDNaZGpPa3FoTzcvYzFUL3MzY0NoaGdp?=
 =?utf-8?Q?hCJvP7zu0zx8QWe0bk0Ythsdg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fdb404-a343-4da8-ae0a-08dad376e806
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 08:34:48.1199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYEZa72xLtovLklK/xJFWeYsuk+iCgR8DpzGaqVymOBhJNywB8drg0X3z42GoP6E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Huang Rui <ray.huang@amd.com>, Christian Koenig <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-11-29 02:10, jiadong.zhu@amd.com wrote:
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
> v9: Correct comment spelling. Set fence emit timestamp before rsu assignment.
> 
> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Michel Dänzer <michel@daenzer.net>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> Acked-by: Luben Tuikov <luben.tuikov@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c    |  54 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c       |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c     |  12 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   8 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 351 +++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  29 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c       |   2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        |   7 +-
>  8 files changed, 422 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 2f8784396e89..ca6a47792dcb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -55,6 +55,7 @@ struct amdgpu_fence {
>  
>  	/* RB, DMA, etc. */
>  	struct amdgpu_ring		*ring;
> +	ktime_t				start_timestamp;
>  };
>  
>  static struct kmem_cache *amdgpu_fence_slab;
> @@ -199,6 +200,8 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>  		}
>  	}
>  
> +	to_amdgpu_fence(fence)->start_timestamp = ktime_get();
> +
>  	/* This function can't be called concurrently anyway, otherwise
>  	 * emitting the fence would mess up the hardware ring buffer.
>  	 */
> @@ -415,6 +418,57 @@ unsigned amdgpu_fence_count_emitted(struct amdgpu_ring *ring)
>  	return lower_32_bits(emitted);
>  }
>  
> +/**
> + * amdgpu_fence_last_unsignaled_time_us - the time fence emited until now

Spelling: emitted

(See two lines above--a function whose name has "emitted"...)

> + * @ring: ring the fence is associated with
> + *
> + * Find the earlist fence unsignaled until now, calculate the time delta

Spelling: earliest

Regards,
Luben

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
> index 9dc1487c6fb2..bc70d1e3efd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -219,6 +219,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>  		}
>  	}
>  
> +	amdgpu_ring_ib_begin(ring);
>  	if (job && ring->funcs->init_cond_exec)
>  		patch_offset = amdgpu_ring_init_cond_exec(ring);
>  
> @@ -293,6 +294,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>  	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
>  		ring->funcs->emit_wave_limit(ring, false);
>  
> +	amdgpu_ring_ib_end(ring);
>  	amdgpu_ring_commit(ring);
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 3e316b013fd9..5163cad5b35f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -572,3 +572,15 @@ int amdgpu_ring_init_mqd(struct amdgpu_ring *ring)
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
> index 073e767c057f..f752c7ae7f60 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -145,8 +145,13 @@ signed long amdgpu_fence_wait_polling(struct amdgpu_ring *ring,
>  				      uint32_t wait_seq,
>  				      signed long timeout);
>  unsigned amdgpu_fence_count_emitted(struct amdgpu_ring *ring);
> +
>  void amdgpu_fence_driver_isr_toggle(struct amdgpu_device *adev, bool stop);
>  
> +u64 amdgpu_fence_last_unsignaled_time_us(struct amdgpu_ring *ring);
> +void amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring, uint32_t seq,
> +					 ktime_t timestamp);
> +
>  /*
>   * Rings.
>   */
> @@ -313,6 +318,9 @@ struct amdgpu_ring {
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
> index a52c4e7e8c39..3348337379da 100644
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
> @@ -239,3 +348,169 @@ unsigned int amdgpu_sw_ring_priority(int idx)
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
> index f67970dc3dbd..4be45fc14954 100644
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
>  	struct amdgpu_ring      *ring;
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
> index 7ad3e51bad40..5cafba788e6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -582,6 +582,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync)
>  		return 0;
>  
> +	amdgpu_ring_ib_begin(ring);
>  	if (ring->funcs->init_cond_exec)
>  		patch_offset = amdgpu_ring_init_cond_exec(ring);
>  
> @@ -642,6 +643,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  		amdgpu_ring_emit_switch_buffer(ring);
>  		amdgpu_ring_emit_switch_buffer(ring);
>  	}
> +	amdgpu_ring_ib_end(ring);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index ec528b1d82e5..4cb939ead783 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5578,7 +5578,7 @@ static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ring *ring)
>  	ring->trail_seq += 1;
>  	amdgpu_ring_alloc(ring, 13);
>  	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
> -				 ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC);
> +				 ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC | AMDGPU_FENCE_FLAG_INT);
>  	/*reset the CP_VMID_PREEMPT after trailing fence*/
>  	amdgpu_ring_emit_wreg(ring,
>  			      SOC15_REG_OFFSET(GC, 0, mmCP_VMID_PREEMPT),
> @@ -6004,8 +6004,9 @@ static int gfx_v9_0_eop_irq(struct amdgpu_device *adev,
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

