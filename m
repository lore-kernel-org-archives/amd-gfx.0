Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477A3CA6019
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 15:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF7210E19D;
	Fri,  9 Oct 2026 15:20:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TygDqcda";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010046.outbound.protection.outlook.com
 [40.93.198.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAC8610E19D
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 15:20:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBySm4iMj3/Noj54m7g07N6ElxXzrxSYhctRDSZ0JDHPGut5TXds+JAC/2irYCnmFRlMiZv+yFS9xmHycY4LdRDYoTaqiMrMANKB5zZMOvfLrf35Nm5GIu6jbwoa/XB8uN1DLJeITcHc+6seTs/uL/gmN/SLhK43jnlZ7qr/CpwqJXaoHHpioSiJiLHEbz97IthZzzrawgg7fsb08+/jgqvcijtqEuGQzcs6R+nfz6K3j0tI42cxd+7jGtLio9oMw2mN5jj10j5I+zBlUwb4XgjMmL9zB+e72jXPmNCB6jF7LVea47dlmd/jJWn0aFF1Sv6rl5Ccny4ya+IrxrUB8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tl/3uqZNt6YEnLX4d9v7lT7OuqumyPnU6Wd75k16ueg=;
 b=HIrxJze4YuSDdCPYv1ZHxO6uJLXeD6OmJT3gUblW7jCCOlymg9Ug9lxWHwb06aFGLx9m0cSd7GZSnq7OAPYv6sV1Jh1/7MjLVrULXl8zX4ZsfKctUrD+zxe99Ot349tQ7O5xC0VGowfTBg7UMit4Wy0ukaS6nHBcMXjahmAlpZnO94OuTkqXsa+dL1sHdu/SEkKQwj5ZqzmkakPHjhiop/apDXyomw23vHDlYkOcX2NndNKgVxpxU4nAfS5oo1EW9ZMVthlziIHfSonuWU/cgB3P8EE34Df6IkedtoPnyHZOjDJy//N5aOaFxuYbTIDdD/wR1KkGj5dXinEtTSnGKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tl/3uqZNt6YEnLX4d9v7lT7OuqumyPnU6Wd75k16ueg=;
 b=TygDqcdaPyFRW2C6jEoI7TnfRO1SsklLNWAPvOCY7q5K7BiCcNfi1zV+S38wnW9nwJS22NSNEySqGel0SqHpAmcdOKMWb3Negqce+tIjgxk6+eIEdqw0g1kOuRk4CAiKCRSxjt3LmXIO4fF6vUv8ZZw0C7MS9dg4mdbSgX0aDQk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CH1PPFC908D89D1.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::623) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:20:17 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 15:20:16 +0000
Message-ID: <4f892f03-e59b-46b2-b9af-c9933506b767@amd.com>
Date: Fri, 9 Oct 2026 11:20:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: fix lost wakeup in interrupt drain on
 debugged process exit
To: Heng Zhou <Heng.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Lijo.Lazar@amd.com, Christian.Koenig@amd.com, Emily.Deng@amd.com,
 Victor.Zhao@amd.com, phasta@kernel.org, HaiJun.Chang@amd.com,
 Jonathan.Kim@amd.com
References: <cda6720c-0957-4345-9cbf-e78deaa2cc8a@amd.com>
 <20261009064547.1091603-1-Heng.Zhou@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261009064547.1091603-1-Heng.Zhou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::25) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1621b5-7911-4c43-6548-08df2618d2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|4143699003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: +KMNZHnoE+ENnr/YFR9NOdmOfLlBuSPvWasDpsSjjCdylBGILLDlKpa9Jgs9LkrgcUIa1tXsi9KpCpt3jQwZeLqK5KXC3YIZWHcl0xA9zM4A485qM33yBF/SZoDUb/g4eoo/uh62+3grPaeBOSc03Z+ceg5OUtiILQdYbEPgqtHkPShJo6zLrsBt44ClTFZW8zdxMUSAEEoXOiQMDfJFpIRNohmu3/rgc749TCJ1D/3CJJpVUnXMs84bt/9z4iFKAdPg4tL4EXjlNITZlBg4G/KcftCrFzyMs/DaC7+ZdI2NUMCYlmN7QTH1YPX/cyW4/PMhHN8n5njMSLrZOAi7BdcNLnVWnSQx/v2Cc/wfEQeqdNfJrsglU/PsCN8gzQhqsycPpG4LNteYRjX7nQ6C0zM+DXVhFipm7m5ye2mv12T4Gd5oaTktb4TvcF0voLseQo3CznExnM3J76rakxV7tVAVi6bR6oYEBYS5P4QZ0PAN1u1u+/3S6PzK0/grRa9dBXJRxuejVg4pCHhYpLS9Td6pXdW1o5AqVXBzDFahljnc0YVIP6pw9AslooEWYTcnYVRT6+LfvvtNkYdMyf+qGy2/JQMlWXw2TJwAg7nyjncPCCHk/JGEtiYCwcSG5xnxnCeWc2LMSlq4nX3ohSnUvIocXVC13imfiF82WbgKjZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0cwSmpXanA2dzJybFpBY3g1SzR4dzh1SkgvRGVSdU5ON1YyS1VtbW9lRzhy?=
 =?utf-8?B?R1oxYTRsTjUwbGxxeksxcWxhYjRhM3lUWWsxK1ljZG51bkZ3djArLzlONFZi?=
 =?utf-8?B?eWkrNHNOL2JtWVZFZCtFUEdmZmVwY2h2bFp0d0JQMXFzS2dpbU00OXJsdExv?=
 =?utf-8?B?dDNHeUR6amZ2TndFM21KTWFPMUJySnV5ZHI5YW81WEtLZ0hva2ZwTGtndVF3?=
 =?utf-8?B?VkN1UC84VVM1SnB5Yno1L2NibEtORllTMUV1RXNKMTlMQTdTQXRUM2pPZUlE?=
 =?utf-8?B?NHhIREpudXcyLytrSlFrT2RaR0ViZVNJRDVsdHVOY2FRT0hndlZUSm5wQmYx?=
 =?utf-8?B?a1g2TzA5M20yYjFVVm9uSTk1NENNWTFreVpOTGNybmIzYkp2OXRMUDh1QlV6?=
 =?utf-8?B?RXhDcXJnZVR4cVI1Nm5DZ2t3VnNsd0FkLy96Zy9kMGRWTzk0TEQwUzBlTHB4?=
 =?utf-8?B?Z1BPQkIxdzRQeWJLUWo5N0dTdXgzYldHLzhSeWJtaFhQcmhQT25KVWxOQXhw?=
 =?utf-8?B?S2VZazlCN0hHYkVMYkNxN1NTWlVIdVlpMThDV1JIUU1ZaWRvQXNvQTRsazd2?=
 =?utf-8?B?cFo5aHRyNWV5c2dMR1A1Z3d3WHcrOFRXeHRTL1JyNFFXMEoxY2J6L3laT29Z?=
 =?utf-8?B?OWF5RlFUUS9VSldSNjg1em9YWWVXQmFPOHBhS2NpdG00emtPZGllWUdhdDBF?=
 =?utf-8?B?MDlTMzltYVZhRGpwVy9IMFFNSnlqN1Q4dkhOWFJwN25MM3J2Z2ZYZzk3RGZh?=
 =?utf-8?B?aUYxTjVWODduUHUxYktYT08xWXIrdU5Mc3E0WlNVd0U5ZW14R3BUVkRrdmE0?=
 =?utf-8?B?NExCNEhRZUEvRDlMSkpCQnAvSjNMaEsyK2ltV3hMaEpEdk9jdEY1WjBKTWV4?=
 =?utf-8?B?OHpDcktRUTdNY1hyMWJlT0tKMExybzRVa1JoWGc0RkNWY1VsM2Y1azFJd2p0?=
 =?utf-8?B?M0MwYm9sOGY5MWdBVEQ2eWJsODNvNHBIQ1BTTy9vNG9PQ2k1RHNZK1daeHlD?=
 =?utf-8?B?Y2t3Q3Q4NWxoYjhYU3g4Rld5WlBSSlVrcFJSU1k5Z1d5RlpUZCs2Y1c0VmpI?=
 =?utf-8?B?OEZpTFpBQWRXWUNMSGFUUGwrOGhaeHBoOGorN0UwNjFQWkhuclEwb2VSRCtt?=
 =?utf-8?B?dVJvaEpwKzZYdGVjYUJwc3FyMkc1WTlUOUtqZG1HQlFTNzVva0ZUOGRZV1Jm?=
 =?utf-8?B?TVF4c2NzcmZUcWhPakhlT2ZReDFFdDZiL0ZCYUhtTi9TZU1lTU55dVQ3MFdK?=
 =?utf-8?B?S1UxTDRoM3k5WXFCbytVQTBKK1dSRmNPU0RoWXI0Y0tGc1d6RGQ1YjAyc3gr?=
 =?utf-8?B?REg1Y3E3T3ZieEdvNGtJSWNkNDVaRnhFUnZlNXBkRVVHbnVaUHRsSjVkZk9O?=
 =?utf-8?B?WjB2MFlPOUVhdEV2bVMwVVo1ZTF4Q2MyWEYrK2FCajFSRUtTUDBJV21JQ0Rj?=
 =?utf-8?B?N1ljZDAxVHNxMmVWcWgya3RYcTNkK1hWTUQyczB0Rk9zditPSjNUWEM3WmVu?=
 =?utf-8?B?N0IvN0xvUWxKOGhMN09WK1Erd0FvZS9qWHpHSlBEZE5IaEdwaGZTSjVyRklo?=
 =?utf-8?B?SzdieVhKMXB3ZExMVk5vdG1pcWMyd1lSWjhIRVRsUGVmYXNOTWhMblAxWllQ?=
 =?utf-8?B?endYem1uOWw0WlU2T3d3cGlvbmIrVWpQVGNJajNNN1hKbkRMd1VLcWpkNi9I?=
 =?utf-8?B?QlNDN0V5bE8yMHdBc2dXMy9MdkxwU3RISXVZOGpETVV3bkNPejhuK0VwVHYv?=
 =?utf-8?B?bi9TYVJZaVlISE9DcytLRkhmOHIrc3VpcHRHL0x0ZHVyV0UrSXpRcll3NjNX?=
 =?utf-8?B?V3RIOEdseC91Z2Y4T2JJcitVeXpPYVFvTjFkd0ppTHNqY3lvN3RhcmgrOUZX?=
 =?utf-8?B?UUtyRG9McjVFOVJzcFRIcGRNY1dDVUR6YjZoOHZTR0VzNCtFNDdoWmdkYUhi?=
 =?utf-8?B?QXprcHVUdlJTeGRSSXFLNHp0Uy9Pa2J5cFpIaVF1QWM3TVZvckF2ckprME11?=
 =?utf-8?B?WEs5d3VJYzhxcG5EeGUzTzlaZkdhOGJjVFZwZFlpdGZVOXd6Unh0UkxDbTZt?=
 =?utf-8?B?UGFkZ3Z4eVpsVnZVcjFmVWRsT1Y4NDhFZmZZWEE5Ykl1eVJ2S2VwK0FkQjNK?=
 =?utf-8?B?ZEtxZnVocjdvMmNkYmR0ekhueERTOVJnYVNHczdnU2FURTI4cGNMT1dxYWlu?=
 =?utf-8?B?eTFrZjVkYWF3S2dVQWwzN3dpU1pBK1NPZThxRzFIVnNlS1ZqRmZyM3B3Vzhi?=
 =?utf-8?B?Q2tMQitCaFMrbXFqaUZqMTJZdFNweVlRUVFzZEFLc0drR0xXK0cvVWRqYUlC?=
 =?utf-8?Q?aD4bBvvsQub/TAaP2r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1621b5-7911-4c43-6548-08df2618d2be
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:20:16.8487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Msh7RRPsjaQ/jZwlCbtEdUuaouGmfJm95FUHW+HlHCddYQaqBssmzR1LUAiu3epfKy1fmoP0FgHEov+8zDCI0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1
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

On 2026-10-09 02:45, Heng Zhou wrote:
> When a debugged process exits, kfd_process_notifier_release_internal()
> first removes it from kfd_processes_table and then calls
> kfd_dbg_trap_disable(), which drains the process interrupts. The drain
> sends a fence through the IH and waits, without a timeout, for
> kfd_process_close_interrupt_drain() to wake it up. That wakeup looks
> the process up by PASID in kfd_processes_table, which no longer holds
> it, so the wakeup is lost and the exiting task sleeps forever. The
> fatal signal has already been consumed in do_exit(), so the
> interruptible wait cannot be broken either.
>
> The wait happens inside the mmu_notifier release callback, i.e. within
> the global mmu_notifier SRCU read-side critical section, so every
> synchronize_srcu() on it stalls as well. Any other process releasing
> its mm then hangs in D state and the system needs a reboot. This is
> seen with rocgdb on MI300X.
>
> Fix this by:
>
> - Waiting on a completion in struct amdgpu_fpriv, looked up by PASID
>    through amdgpu_pasid_xa, instead of looking the process up in
>    kfd_processes_table. The DRM file owning the PASID is still
>    referenced by KFD while it drains, so the drain fence always finds
>    its waiter. The drain logic moves to amdgpu_ids.c and KFD only
>    passes the PASID.
> - Bounding the wait with a timeout, since the fence can be lost when
>    the IH ring or the KFD interrupt FIFO overflows, and warning when the
>    drain does not complete.
> - Passing drain_irqs to kfd_dbg_trap_disable() and skipping the drain
>    when the process itself exits. Its interrupts are no longer delivered
>    once it is out of kfd_processes_table, and its PASID owner is cleared
>    before the PASID is freed and later reallocated cyclically.
>
> v2: track drains with a completion in amdgpu_fpriv via amdgpu_pasid_xa
>      and move the drain logic to amdgpu_ids.c; pass drain_irqs to
>      kfd_dbg_trap_disable() and skip the drain on process exit instead
>      of deferring it (Felix)
>
> v3: use AMDGPU_FENCE_JIFFIES_TIMEOUT for the drain timeout; drop
>      kfd_process_close_interrupt_drain() and call
>      amdgpu_pasid_drain_irq_done() directly from the interrupt handlers
>      (Felix)
>
> Fixes: 12fb1ad70d65 ("drm/amdkfd: update process interrupt handling for debug events")
> Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c       | 62 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h       |  3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  2 +
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 10 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |  2 +-
>   .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  |  2 +-
>   .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |  2 +-
>   .../drm/amd/amdkfd/kfd_int_process_v12_1.c    |  2 +-
>   .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  8 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 47 ++++----------
>   13 files changed, 94 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ce671731b700..c32d3b0b4153 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -426,6 +426,9 @@ struct amdgpu_fpriv {
>   
>   	/** GPU partition selection */
>   	uint32_t		xcp_id;
> +
> +	/** Signaled when a KFD interrupt drain fence for this PASID is seen */
> +	struct completion	irq_drain_done;
>   };
>   
>   int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 5e424e3b6e71..87cc297109a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -171,6 +171,68 @@ struct amdgpu_fpriv *amdgpu_pasid_get_fpriv_locked(u32 pasid)
>   	return xa_load(&amdgpu_pasid_xa, pasid);
>   }
>   
> +/**
> + * amdgpu_pasid_drain_irq - wait for pending KFD interrupts of a PASID
> + * @adev: amdgpu device the drain fence is sent to
> + * @pasid: PASID whose interrupts should be drained
> + * @ih_fence: IH entry injected as the drain fence
> + * @timeout: maximum time to wait, in jiffies
> + *
> + * Injects @ih_fence behind the interrupts already queued for KFD and waits
> + * until amdgpu_pasid_drain_irq_done() is called for @pasid.
> + *
> + * The caller must hold a reference to the DRM file that owns @pasid, so
> + * that its amdgpu_fpriv stays valid after the PASID lock is dropped.
> + *
> + * Returns:
> + * 0 on success or when no fence could be sent, -ENOENT if @pasid has no
> + * owner, -ETIMEDOUT on timeout or -ERESTARTSYS if interrupted.
> + */
> +int amdgpu_pasid_drain_irq(struct amdgpu_device *adev, u32 pasid,
> +			   u32 *ih_fence, unsigned long timeout)
> +{
> +	struct amdgpu_fpriv *fpriv;
> +	unsigned long flags;
> +	long r;
> +
> +	amdgpu_pasid_lock(&flags);
> +	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
> +	if (fpriv)
> +		reinit_completion(&fpriv->irq_drain_done);
> +	amdgpu_pasid_unlock(flags);
> +	if (!fpriv)
> +		return -ENOENT;
> +
> +	if (amdgpu_amdkfd_send_close_event_drain_irq(adev, ih_fence))
> +		return 0;
> +
> +	r = wait_for_completion_interruptible_timeout(&fpriv->irq_drain_done,
> +						      timeout);
> +	if (!r)
> +		return -ETIMEDOUT;
> +
> +	return r < 0 ? r : 0;
> +}
> +
> +/**
> + * amdgpu_pasid_drain_irq_done - signal that a KFD interrupt drain completed
> + * @pasid: PASID carried by the drain fence
> + *
> + * Called by KFD when it processes the drain fence injected by
> + * amdgpu_pasid_drain_irq().
> + */
> +void amdgpu_pasid_drain_irq_done(u32 pasid)
> +{
> +	struct amdgpu_fpriv *fpriv;
> +	unsigned long flags;
> +
> +	amdgpu_pasid_lock(&flags);
> +	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
> +	if (fpriv)
> +		complete(&fpriv->irq_drain_done);
> +	amdgpu_pasid_unlock(flags);
> +}
> +
>   /**
>    * amdgpu_pasid_free_delayed - free pasid when fences signal
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index 46b2c2160126..2af733d96d60 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -98,6 +98,9 @@ int amdgpu_pasid_alloc(unsigned int bits, struct amdgpu_fpriv *fpriv);
>   void amdgpu_pasid_lock(unsigned long *flags);
>   void amdgpu_pasid_unlock(unsigned long flags);
>   struct amdgpu_fpriv *amdgpu_pasid_get_fpriv_locked(u32 pasid);
> +int amdgpu_pasid_drain_irq(struct amdgpu_device *adev, u32 pasid,
> +			   u32 *ih_fence, unsigned long timeout);
> +void amdgpu_pasid_drain_irq_done(u32 pasid);
>   void amdgpu_pasid_free(u32 pasid);
>   void amdgpu_pasid_free_delayed(struct dma_resv *resv,
>   			       u32 pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index bac072d73e16..8b080e2e1496 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1507,6 +1507,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   	if (r)
>   		goto error_pasid;
>   
> +	init_completion(&fpriv->irq_drain_done);
> +
>   	pasid = amdgpu_pasid_alloc(16, fpriv);
>   	if (pasid < 0) {
>   		dev_warn(adev->dev, "No more PASIDs available!");
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 1d86ddfd6bde..b3ebbee76088 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3223,7 +3223,7 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   
>   		break;
>   	case KFD_IOC_DBG_TRAP_DISABLE:
> -		r = kfd_dbg_trap_disable(target);
> +		r = kfd_dbg_trap_disable(target, true);
>   		break;
>   	case KFD_IOC_DBG_TRAP_SEND_RUNTIME_EVENT:
>   		r = kfd_dbg_send_exception_to_runtime(target,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 0dd1fd448059..8bed0d0f9bd2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -655,7 +655,8 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
>   	kfd_dbg_set_workaround(target, false);
>   }
>   
> -static void kfd_dbg_clean_exception_status(struct kfd_process *target)
> +static void kfd_dbg_clean_exception_status(struct kfd_process *target,
> +					   bool drain_irqs)
>   {
>   	struct process_queue_manager *pqm;
>   	struct process_queue_node *pqn;
> @@ -664,7 +665,8 @@ static void kfd_dbg_clean_exception_status(struct kfd_process *target)
>   	for (i = 0; i < target->n_pdds; i++) {
>   		struct kfd_process_device *pdd = target->pdds[i];
>   
> -		kfd_process_drain_interrupts(pdd);
> +		if (drain_irqs)
> +			kfd_process_drain_interrupts(pdd);
>   
>   		pdd->exception_status = 0;
>   	}
> @@ -680,7 +682,7 @@ static void kfd_dbg_clean_exception_status(struct kfd_process *target)
>   	target->exception_status = 0;
>   }
>   
> -int kfd_dbg_trap_disable(struct kfd_process *target)
> +int kfd_dbg_trap_disable(struct kfd_process *target, bool drain_irqs)
>   {
>   	if (!target->debug_trap_enabled)
>   		return 0;
> @@ -704,7 +706,7 @@ int kfd_dbg_trap_disable(struct kfd_process *target)
>   	}
>   
>   	target->debug_trap_enabled = false;
> -	kfd_dbg_clean_exception_status(target);
> +	kfd_dbg_clean_exception_status(target, drain_irqs);
>   	kfd_unref_process(target);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index fbb751821c69..5babf9b992cd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -43,7 +43,7 @@ bool kfd_dbg_ev_raise(uint64_t event_mask,
>   			unsigned int source_id, bool use_worker,
>   			void *exception_data,
>   			size_t exception_data_size);
> -int kfd_dbg_trap_disable(struct kfd_process *target);
> +int kfd_dbg_trap_disable(struct kfd_process *target, bool drain_irqs);
>   int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
>   			void __user *runtime_info,
>   			uint32_t *runtime_info_size);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> index 19406ab92c5b..45ac77bb2102 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> @@ -376,7 +376,7 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
>   						&exception_data,
>   						sizeof(exception_data));
>   	} else if (KFD_IRQ_IS_FENCE(client_id, source_id)) {
> -		kfd_process_close_interrupt_drain(pasid);
> +		amdgpu_pasid_drain_irq_done(pasid);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> index 12d81abed748..24d13a74a181 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> @@ -408,7 +408,7 @@ static void event_interrupt_wq_v11(struct kfd_node *dev,
>   		}
>   
>   	} else if (KFD_IRQ_IS_FENCE(client_id, source_id)) {
> -		kfd_process_close_interrupt_drain(pasid);
> +		amdgpu_pasid_drain_irq_done(pasid);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
> index 0da7e1db55c9..4c7ad5aaaebc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
> @@ -395,7 +395,7 @@ static void event_interrupt_wq_v12_1(struct kfd_node *node,
>   		}
>   
>   	} else if (KFD_IRQ_IS_FENCE(client_id, source_id)) {
> -		kfd_process_close_interrupt_drain(pasid);
> +		amdgpu_pasid_drain_irq_done(pasid);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 2ae1129fea55..e241ad7d55df 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -596,7 +596,7 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
>   						sizeof(exception_data));
>   		kfd_smi_event_update_vmfault(dev, pasid);
>   	} else if (KFD_IRQ_IS_FENCE(client_id, source_id)) {
> -		kfd_process_close_interrupt_drain(pasid);
> +		amdgpu_pasid_drain_irq_done(pasid);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 2847a5ec5ede..4777d6b7911c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1030,10 +1030,6 @@ struct kfd_process {
>   	uint64_t exception_enable_mask;
>   	uint64_t exception_status;
>   
> -	/* Used to drain stale interrupts */
> -	wait_queue_head_t wait_irq_drain;
> -	bool irq_drain_is_open;
> -
>   	/* shared virtual memory registered by this process */
>   	struct svm_range_list svms;
>   
> @@ -1245,9 +1241,7 @@ bool enqueue_ih_ring_entry(struct kfd_node *kfd, const void *ih_ring_entry);
>   bool interrupt_is_wanted(struct kfd_node *dev,
>   				const uint32_t *ih_ring_entry,
>   				uint32_t *patched_ihre, bool *flag);
> -int kfd_process_drain_interrupts(struct kfd_process_device *pdd);
> -void kfd_process_close_interrupt_drain(unsigned int pasid);
> -
> +void kfd_process_drain_interrupts(struct kfd_process_device *pdd);
>   /* amdkfd Apertures */
>   int kfd_init_apertures(struct kfd_process *process);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 226f52626e84..e742ef206abd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1019,8 +1019,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   		if (ret)
>   			pr_warn("Failed to create debugfs entry for the kfd_process, ret = %d\n",
>   				ret);
> -
> -		init_waitqueue_head(&process->wait_irq_drain);
>   	}
>   out:
>   	mutex_unlock(&kfd_processes_mutex);
> @@ -1420,7 +1418,7 @@ void kfd_process_notifier_release_internal(struct kfd_process *p)
>   	 * back on the MES list and, once proc_ctx_bo is freed, MES would fault
>   	 * on the freed process context. Retiring the context last avoids this.
>   	 */
> -	kfd_dbg_trap_disable(p);
> +	kfd_dbg_trap_disable(p, false);
>   
>   	if (atomic_read(&p->debugged_process_count) > 0) {
>   		struct kfd_process *target;
> @@ -1430,7 +1428,7 @@ void kfd_process_notifier_release_internal(struct kfd_process *p)
>   		hash_for_each_rcu(kfd_processes_table, temp, target, kfd_processes) {
>   			if (target->debugger_process && target->debugger_process == p) {
>   				mutex_lock_nested(&target->mutex, 1);
> -				kfd_dbg_trap_disable(target);
> +				kfd_dbg_trap_disable(target, true);
>   				mutex_unlock(&target->mutex);
>   				if (atomic_read(&p->debugged_process_count) == 0)
>   					break;
> @@ -2313,17 +2311,14 @@ int kfd_resume_all_processes(void)
>   	return ret;
>   }
>   
> -/* assumes caller holds process lock. */
> -int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
> +void kfd_process_drain_interrupts(struct kfd_process_device *pdd)
>   {
>   	uint32_t irq_drain_fence[8];
>   	uint8_t node_id = 0;
> -	int r = 0;
> +	int r;
>   
> -	if (!KFD_IS_SOC15(pdd->dev))
> -		return 0;
> -
> -	pdd->process->irq_drain_is_open = true;
> +	if (!KFD_IS_SOC15(pdd->dev) || !pdd->drm_priv)
> +		return;
>   
>   	memset(irq_drain_fence, 0, sizeof(irq_drain_fence));
>   	irq_drain_fence[0] = (KFD_IRQ_FENCE_SOURCEID << 8) |
> @@ -2342,32 +2337,12 @@ int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
>   	}
>   
>   	/* ensure stale irqs scheduled KFD interrupts and send drain fence. */
> -	if (amdgpu_amdkfd_send_close_event_drain_irq(pdd->dev->adev,
> -						     irq_drain_fence)) {
> -		pdd->process->irq_drain_is_open = false;
> -		return 0;
> -	}
> -
> -	r = wait_event_interruptible(pdd->process->wait_irq_drain,
> -				     !READ_ONCE(pdd->process->irq_drain_is_open));
> +	r = amdgpu_pasid_drain_irq(pdd->dev->adev, pdd->pasid, irq_drain_fence,
> +				   AMDGPU_FENCE_JIFFIES_TIMEOUT);
>   	if (r)
> -		pdd->process->irq_drain_is_open = false;
> -
> -	return r;
> -}
> -
> -void kfd_process_close_interrupt_drain(unsigned int pasid)
> -{
> -	struct kfd_process *p;
> -
> -	p = kfd_lookup_process_by_pasid(pasid, NULL);
> -
> -	if (!p)
> -		return;
> -
> -	WRITE_ONCE(p->irq_drain_is_open, false);
> -	wake_up_all(&p->wait_irq_drain);
> -	kfd_unref_process(p);
> +		dev_warn_ratelimited(pdd->dev->adev->dev,
> +				     "irq drain on pasid 0x%x did not complete (%d)\n",
> +				     pdd->pasid, r);
>   }
>   
>   struct send_exception_work_handler_workarea {
