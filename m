Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7D7C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 13:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DE4E10E05C;
	Tue, 14 Jul 2026 13:03:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FLyCSQ+T";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010026.outbound.protection.outlook.com
 [40.93.198.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F005910E05C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 13:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7AUbPDlRGJMTOriPFB1YiABHisa/u/jgTHJSFIiolXsPFQs37SjEOumq+1VIbZmw5EyIj1qUQcTuQKbZ0KHovhURxs4xWwMsPj0MXWxaw3Xt7Eyr8FiKEwvReOV6bbvc5j6Dv7XwHEMF5yeVjIvaZMAs2P78dfKR5auNfuH1ZHcBnyjUChcjiNlzX2ju2P1C8G8DnRxxHw3e5xk3vTdDw+txzjvn2zRSOtbuzl+d8jXiiWM8ZWw+rePEs9PtxhLyhO1RSl9qMclVJt9vUEeVx9wwCSJptQ/8GnBCFr/uUQBvpNM8kTTimeaNSJTEH6gFX4lgnhDcXfHWjTpF/W08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRu5t2aKWsvEZFT6//kbU/oKgQRBoq7tAvDcj3w8kcs=;
 b=CekcefGRmb+oZhQ962+Q9uThRphUUZ8w9FKKZEkPH+6qbyedyzMCpt+uKer0PVZszVZCOl1K0paegbNxPJk2Bs8OB7Os/PQ3TcxcctaWghR1faMov2FcyesKe3pRqfabdFDMfDs1Qwsgae8ESu9dO386brpattsls+v45qeVqusD+GGxOFu+8RZaYuthF/Ia/Y4fZ5rfowzBDJvHDgVxKGCTIMw3UXsrWIvJdbF137VLjSZd8OJULSdxdqjpNR/FHFvIDGu/SxhNielXlJiZDEZtLvMp0AApPS37N6E0slvXepp/r3uwbDGyiyB0RhnqMKxn+UcRgvfO09hdpfChpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRu5t2aKWsvEZFT6//kbU/oKgQRBoq7tAvDcj3w8kcs=;
 b=FLyCSQ+TcuzSV0FhKss0xNY1xymkZ7ZX09w7ze/T55JetQAG+XHlfap77H0B92+LkeYeFEiDIgxJqsn6RuPmWHRzQjIkBJ0ayzGoXQfozPfF8wg28gv3Scaw1auilShkVGeKllalm1Jvbzp1M5z2QJt/V8ACf3H0fm9D7BAapBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 13:03:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 13:03:21 +0000
Message-ID: <56ed16c5-4b30-48b8-9140-375bf8015a99@amd.com>
Date: Tue, 14 Jul 2026 15:03:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/5] drm/amdgpu: Record USERQ_EOP WAIT_EVENT
 notifications
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
 <20260714081023.3395485-5-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260714081023.3395485-5-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6af669-d13a-4a38-ee87-08dee1a8482d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: S5tJdUb9jjn8aVGGe7mZUcaoIjxObS26sKDCfv84SIufx6PCdSrR6xf5HO8WKr2rMIaBLgJXDRA5Mov+QnIKqST+PYLoi2otz/BFzW0YCZ4FPm4ZfIGfgM/tJidLPWgI6OSA3Fx98xlEQY0qcO2sqxq5pqskQ+rFRTOv4ZFZVIYqblY0IihGIuR/MKCRMNhCAlrr5+9xC+KUe98gJW7mQybePU/Tay4LrFXxjmB6pLc8s2iAwMP0Dxjra9jlPOCQKMRKTxp+IEPJO+ALXU8x16Go1kluSGxxTapQbLNdjbwUxSWyVFqDkD6s7mc1+JJh6q3ErdOtOtDI9iQrGy6aa4sTswaQfIC4gXYSqlB1sPY/4PNpji9NDvCwWJi/2gS+n4nLX5QYp5+1usGm8N70FdlucPVMZsr+T/X+Jf8xIaEIJ9moXEhH0/qAlfokpJuBX5Ttu5UyFjCE6Nz9PvS9mK2RL5/7CuYp8gUP05yAfw7VHwJ839Ef92G/02ID5vXw7irJcnUS5Dd7lfSDBvAenAOdeiEDiSJI41yzAQLcfFFgtHrbBTN0ODWWIaeQiTACwjM5TLyBQ2QOsogAJltdiLiAYbtsr1sqbQq7kPxlD2HyCyKl7pt8nkVTUGH0GIuMeAPhrP9Ss7L8C5YaVObZZLx8j5kK41n5KCDuNSGbejo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnB0ZVVKYWdQQlorOHBiTHB4cDlEV0YyQjYrTVY4VmZ6elc1WDRxRnRTdW1u?=
 =?utf-8?B?ZEFRVHpScXhnTGRrT3NkclVqNTBOS3prWCs3VjFpMk42T2ZGcjlHY0Jadld3?=
 =?utf-8?B?TURkVmFYQmcvTFBYRmtRTHl6WlpiczZBSGJIK1lyQ25aMFoxQ3p1VHlieWpR?=
 =?utf-8?B?aEVTZG03dUVkeWhvTkNhS2FFc1ROM1l0S1p1aHVZMHhPZUJ5b2VkN3dpczBP?=
 =?utf-8?B?d2huc2hHQ3ArSmJsSkRpTUw1MVpqazRCNzByN0J0dGdJTis3ZDhEaG9iT3ZM?=
 =?utf-8?B?Y3JoeXFTOHA0aGk4V0t1a3hXVURRc3B2R0NrSW1zMUh4Q2JqdEtvYTVhdmpE?=
 =?utf-8?B?bVBneFBRTTlldDRTaGRrNUUyYitWRC96UHZ6a2o2VHFsZ3FLdjdxby9CbTgy?=
 =?utf-8?B?MVNUUUJtU25zTWk2cHIvdUwyeHAyQTdSSVRKdEx2elErZ2pSZVhwdDJtY1Jr?=
 =?utf-8?B?WC9jOWY1RVBKS3R0Qk1NSUdHT2s2MjJiVzV3aE1Cd2VyQm8xS3J4ckplY0Vn?=
 =?utf-8?B?Qi9sQk50NGpvci9lazdoRUJaSTdNY1pSWHg2c0tmaFJQNVFiMjJXRU1YZ2Fk?=
 =?utf-8?B?ZU9QKzczZHRKZSt5WTY0YzN6WjR6bDRwV0dVZUVndTdwT2JvTkpLT1ovU1Z2?=
 =?utf-8?B?b20rVFlqbGtwSllqcjl0MjRxR1VXZUVQeVUraWxoZUxiYk5rWTF6MlFLdDZP?=
 =?utf-8?B?R0t1S01JbENQWlNFNVJVQ2FBMWdlcjc3RzhGcjdsU0JJMWxiV3lPU1NWdW92?=
 =?utf-8?B?ME9yUzRUSUordS96Mi9ycXJySjhmNWM5ZEVPaXN6UDNOVUt5K0VOWW5OSTB2?=
 =?utf-8?B?Rmd0dkswTU05Vk5QckxUT2FCaVZKczlTSXlmVnJzdmVJRGhycWd3M053bWk1?=
 =?utf-8?B?ZDVqVkZjYXdCNGNGc1lhT094cU1GT0FvZzk2YUFaOEg5RFRFc3BLRWJIa1ox?=
 =?utf-8?B?T0l6Mm1ZNVVJVTBKSHRGNjhTNHhtMC90QUtodVJpRFY0czJYdzcxRFA5Tlc3?=
 =?utf-8?B?dnJDS0xodnJ3cEFVZTdpSVEvNXRtYXRTWDQyVWU0bitiNEFGZzFmMTIwM2tP?=
 =?utf-8?B?VnBhZUs4UDhNUmJvWFRVRUJ6Q01PcDJSYStRdHpDYlpBeVl2Q214UkVkR1dO?=
 =?utf-8?B?R2ZYdTlkSUtrc0dqWWwzc3JVQ1lUQUVVTVhab2NYWFp5bmJWWlJjSGpqaFRu?=
 =?utf-8?B?OU1MVGt2NlkvM2VPVE1IOXBqMEVvNjZyZ0FkeXBUb2FERDM2a2h5RGZDWWVW?=
 =?utf-8?B?SDRTcnRVL3I3RG5weDRKM2lkbUpyeldoQ2hFS2FIdmRHUUREMitueWN2cFZo?=
 =?utf-8?B?dTlsWElySFBORFB5dE1FNzArOGNMdEEvb1M0TjNweS8vclh1a2c3TXI2amFN?=
 =?utf-8?B?dDd3YzkzTDg2Y016RU1id1dHY3JJaElXbmo1bzIrTEwwWWZ3dEM0VG40U1Ns?=
 =?utf-8?B?bG9hRkZxWnlwM0VuVGJaaHlja0lSVklzZ3MrU2llQzRrb3VxZG5WdWRiTTNm?=
 =?utf-8?B?cU5wWlgvWmg4U2NXQWpRZ0kvVU94aU9mamhqV0M4ZE5URDhzMnhCL3hWSjJv?=
 =?utf-8?B?QThYellzOE0rUmhxOWhwMTdpV3ZTa3JqbE90TEpweC9JVkdIMDlERkREdkZq?=
 =?utf-8?B?SjhPa20rVjhBUnVqNEJ3SEIyM0FhQTV1SWN2a2o5Z21tbCtBTHBQQVU1VmFh?=
 =?utf-8?B?bTFiVWlnc0NXQ0tVL2VqZ1ZaV3JjRnBYMlNpVllENkNUbzJGVi9GUkx6WGlq?=
 =?utf-8?B?RHBWVXpHd21pSDhtRXNZcnZtSlBrb3NLZytWVXUwWjNSU2hUckxDOFJxNkM1?=
 =?utf-8?B?VEV6V3M0M1ZTMmFzRDBlUUowTWo0dld6cEZVUkRxb2Irc3lPc2dVak1LRmI4?=
 =?utf-8?B?bDhFam5DVnMydGFUMTN2amNxWFRPb09ENG9aN0pOS2NKb3FSU2l5eEt6aHRj?=
 =?utf-8?B?Y1UwYU9jTjIyU2FKRk5qbEF2akhuaHJqMVBQSXh4QnpBYlhnQzBOSWswblpx?=
 =?utf-8?B?Ti9PNW03RFZ2WjlDSjdBWVc5MUNuTTZMYjBYUVFIU0U0cU1zeWVwZEJLTUF0?=
 =?utf-8?B?UDR4dStyb1crTWgvd0YxeDhMMkIvOWpTcGdCZFhkblIvQzFKOHJwL2kyOHFm?=
 =?utf-8?B?YnlFRFc3N25mUnRBZDJpMlhTcEZObVdxbnpLamZBZWE3MGkwSkZ0YUUrTVFa?=
 =?utf-8?B?Y25tTkdHcE5JeDZ6bzBNeWVnWEtKVmloeFFZTDVGQzVNU29OTVk1S3g2ejBa?=
 =?utf-8?B?VFo4bWVmYllMSmNVYWI3SWxzdXpEa0tUVWFvaEdYMjhNSFFlVlZiYVlBK1l2?=
 =?utf-8?Q?L1AaiyyImImlP66WmD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6af669-d13a-4a38-ee87-08dee1a8482d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 13:03:21.6300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVraijtXq+wDelezPFGMtw5MnrctGAlltodzsRCaF12MuWM4yjM5B2LxXuTh5vbp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551
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

On 7/14/26 10:10, Srinivasan Shanmugam wrote:
> WAIT_EVENT currently provides the per-file queue, matching, and lifetime
> infrastructure, but no producer creates records when a user queue fence
> completes.
> 
> Add an IRQ-safe helper which appends a WAIT_EVENT record using the queue
> pointer as the internal routing key. The record takes a queue reference
> before it is published and releases it through the existing record
> cleanup paths.
> 
> The producer does not translate the queue pointer back to a queue ID.
> Instead, the WAIT_EVENT ioctl adds the queue ID supplied by the waiter
> to the matched record immediately before returning it to userspace. This
> keeps queue IDs at the UAPI boundary while retaining queue-pointer-based
> matching internally.
> 
> Call the helper from amdgpu_userq_process_fence_irq(), next to the
> existing EVENTFD notification. This reuses the established
> doorbell-to-queue lookup and does not add another queue lookup or change
> the GFX interrupt handling.
> 
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

What you do with the queue_id still looks a bit fishy to me, but I don't really have time to check that in detail.

Acked-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  6 +++
>  .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 53 +++++++++++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    |  4 ++
>  3 files changed, 63 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index aa17e55d52e8..28f9d3fe0e80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -264,6 +264,7 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
>  	struct xarray *xa = &adev->userq_doorbell_xa;
>  	struct amdgpu_usermode_queue *queue;
>  	struct amdgpu_eventfd_mgr *eventfd_mgr;
> +	struct amdgpu_wait_event_mgr *wait_event_mgr;
>  	unsigned long flags;
>  	int r;
>  
> @@ -286,6 +287,11 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
>  		amdgpu_eventfd_signal(eventfd_mgr,
>  				      DRM_AMDGPU_EVENT_TYPE_USERQ_EOP,
>  				      queue);
> +
> +		wait_event_mgr = amdgpu_userq_wait_event_mgr(queue->userq_mgr);
> +		amdgpu_wait_event_add(wait_event_mgr,
> +				      DRM_AMDGPU_EVENT_TYPE_USERQ_EOP,
> +				      queue);
>  	}
>  	xa_unlock_irqrestore(xa, flags);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
> index f98de1d94b56..ddbd03059916 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
> @@ -63,6 +63,27 @@ static bool amdgpu_wait_event_valid_type(u32 event_type)
>  	}
>  }
>  
> +static void
> +amdgpu_wait_event_set_queue_id(struct amdgpu_wait_event_record *rec,
> +			       u32 queue_id)
> +{
> +	rec->data.queue_id = queue_id;
> +
> +	switch (rec->data.event_type) {
> +	case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
> +		rec->data.u.queue.queue_id = queue_id;
> +		break;
> +	case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
> +		rec->data.u.reset.queue_id = queue_id;
> +		break;
> +	case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
> +		rec->data.u.scratch.queue_id = queue_id;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static void
>  amdgpu_wait_event_record_free(struct amdgpu_wait_event_record *rec)
>  {
> @@ -167,6 +188,35 @@ void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr)
>  	mgr->dead = false;
>  }
>  
> +void amdgpu_wait_event_add(struct amdgpu_wait_event_mgr *mgr,
> +			   u32 event_type,
> +			   struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_wait_event_record *rec;
> +	unsigned long flags;
> +
> +	rec = kzalloc(sizeof(*rec), GFP_ATOMIC);
> +	if (!rec)
> +		return;
> +
> +	kref_get(&queue->refcount);
> +	rec->queue = queue;
> +	rec->data.event_type = event_type;
> +	rec->data.seqno = atomic64_inc_return(&mgr->seqno);
> +
> +	spin_lock_irqsave(&mgr->lock, flags);
> +	if (mgr->dead) {
> +		spin_unlock_irqrestore(&mgr->lock, flags);
> +		amdgpu_wait_event_record_free(rec);
> +		return;
> +	}
> +
> +	list_add_tail(&rec->node, &mgr->pending);
> +	spin_unlock_irqrestore(&mgr->lock, flags);
> +
> +	wake_up_interruptible(&mgr->wq);
> +}
> +
>  void amdgpu_wait_event_mgr_fini(struct amdgpu_wait_event_mgr *mgr)
>  {
>  	struct amdgpu_wait_event_record *rec, *tmp;
> @@ -270,6 +320,9 @@ int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
>  		}
>  	}
>  
> +	if (queue)
> +		amdgpu_wait_event_set_queue_id(rec, args->queue_id);
> +
>  	if (copy_to_user(u64_to_user_ptr(args->out_ptr), &rec->data,
>  			 sizeof(rec->data)))
>  		ret = -EFAULT;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
> index e887fffdc4ac..07e043dcc2e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
> @@ -56,6 +56,10 @@ void amdgpu_wait_event_mgr_fini(struct amdgpu_wait_event_mgr *mgr);
>  void amdgpu_wait_event_remove_queue(struct amdgpu_wait_event_mgr *mgr,
>  				    struct amdgpu_usermode_queue *queue);
>  
> +void amdgpu_wait_event_add(struct amdgpu_wait_event_mgr *mgr,
> +			   u32 event_type,
> +			   struct amdgpu_usermode_queue *queue);
> +
>  int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
>  				struct drm_file *file_priv);
>  

