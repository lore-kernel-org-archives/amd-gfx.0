Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E622ECA6015
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 21:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D1310E959;
	Thu,  8 Oct 2026 21:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0nNsphDl";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013046.outbound.protection.outlook.com
 [40.93.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B74810E959
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 21:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIOMCayxPHNQKQaakj+CasqVFhSnNM7zrTR6nhfjxLhAt11E94vihM17So3tEp3Q6M1PN1hKj4fXaxqbJ50qQQi0Cg1oluy20QTNmcohkTggiZA2p3ElQj3CU88wJsyBtnT07OtjNY6Z0aXhiPtIMaEqiaWbqgtG2HnnGPnlNyNuku22OPCZoe5zgDWavHAkf4xyZS8cbdWbB3SgmAfizu3dmGHnxii+ZMEvhMuQQI9rJOUpQiMSuqJ+IS12x3JXzHYRMVEt29vaMEltc4a5BaRaA40w0pgBmQKfyVc0Oo+wx5arHeNs6swhwRuNhQIT7hJcBP1NFY2Q/rXjR8JH0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzwRO3C5JC2AiNiJGVevbBmcfjexFn3tTzExSMBPpWM=;
 b=RoP5sDugU26T5EafxRL/F6q8WCWl/GMCleBhYuKYYvelkJ8XVq661CpJUkKt+330kqi4d4WiiyoFhWOA9OLNqRoOtre/1729h9lTxGJhGRukx8jJz4zK9cjZsPy6Y1LtvAWdxE9p0RCHVTsV5AzkKpjjExcw3dpXtMpismkDfw8OtNz/xwdGF50iIquGoTCJ9vVdE+2HxJEGHBatAq11UBqoxFzloBSQSURW6V3NMTJpkDwWKpy4d3w2YjetTmhsBAnvGEsrYvl9ebJgfRH0vYFqZxdNbVgRKvLVf+XEp9/tpmGihezG9bbOY41LdUeEpQIFScyok+94D9/0GPB/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzwRO3C5JC2AiNiJGVevbBmcfjexFn3tTzExSMBPpWM=;
 b=0nNsphDl3izfn/M2ocVVB0gxQ00IGQgYtBAoI1K+1bRzWblug6JomEh6jKvlAwpeBrQnHy1ZCg8bJowUwAHzK0zNZOFBUuV2WpMQ2ukAMBr8fhAvg4Jnro5n+cfFc3g9UKI2fAnT2z19rQEhqaD8McTBDzwK79N0kzkAXdGdYhU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CY1PR12MB9603.namprd12.prod.outlook.com
 (2603:10b6:930:108::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 21:59:21 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 21:59:18 +0000
Message-ID: <cda6720c-0957-4345-9cbf-e78deaa2cc8a@amd.com>
Date: Thu, 8 Oct 2026 17:59:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: fix lost wakeup in interrupt drain on
 debugged process exit
To: Heng Zhou <Heng.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Lijo.Lazar@amd.com, Christian.Koenig@amd.com, Emily.Deng@amd.com,
 Victor.Zhao@amd.com, phasta@kernel.org, Qing.Ma@amd.com,
 HaiJun.Chang@amd.com, Jonathan.Kim@amd.com
References: <e546c00d-6686-4f33-9e17-fee0cf25eaed@amd.com>
 <20261008140605.944513-1-Heng.Zhou@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261008140605.944513-1-Heng.Zhou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0488.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::18) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CY1PR12MB9603:EE_
X-MS-Office365-Filtering-Correlation-Id: 1358a61c-3a75-44ee-e6de-08df258766a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: E6IZD/FwORTpfs6CwXnDQkvnr/XHMLt8AULQAO/yik8ceWmDnl7J0FnjeCnEfIr40I9iqpCW3Lkij9OIDZglI9vT5Og83QX2OF2gUCQS/H1p7kkqlsF+8WOIz6F/x6DchjUnKvcCeLwBGUrP9Fbd8Tl5FAxaqQA7QrI7SJra5+V9QX14l2/BvhYpyhkk3cU3RhPpn/IoXIGYK15HlNpACCe6Lwy/FRRy9HNlWC0JNCw4tT5GspTQPTC8etCcvr8XWiu5s3yTX9X/OFxd9531dhdWVJhKzzZoktW6bLAksqjk5oZ/fYBtADgPI/OqOIWg768K4mqCRXNStOqFveB6zLG5cb9/GziZUKhxics1CDT9eF8XgEWuTZNoJhjLM+CzLePDOglaBk7rsJS7vVp7I/k+putEzA4XscV955TbNo0RvgGK34rPJOA19WETbk0f/JUH1SwTBiAKtI/rQ8vW9N+FGUhHM3JUqQ8vvP4BXNWA94jyoAcPNM5ZSsUSYvyH3ynclafNaugEhMukovHH+yXNjWYxeCWNFoZnWU1Xzjr9wopFNj/9OCqV5RwfjZPiHBa1Iqvybe7gzPUE/xtuYyz3tPc/4xKVq2i0q2bTpEFk37MHrO9h2ubqjqqqU7iUmoQa9wE1jEXubiVyoEGm69b8KJ8BeuxY1sqB5tO6/LA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWV2ZkZrWGMvZzhpL0g2RkFHMUo5cUkzRkZZZUY4c0lsemE4U0RXejhNU21I?=
 =?utf-8?B?eDg3Uzd4cmZ2eDZScWJsaFdXbmI4cytxSlJ4ZmdTdC9LbjVmSjhTNWgyOE1N?=
 =?utf-8?B?cU1JUUY5SHc1Y0lNRXAwZTdtSUMwd25Yb054a1gzWGxLV1FienU4bGZDbE1z?=
 =?utf-8?B?SFQ0YmkxK01Fa211MElXc2hvTExBVnRlbytSNjBFMzFXY21Jd3I5ajU5d0hJ?=
 =?utf-8?B?eEdRSmJZVk9ONWxROEVPeEVkMERabXJaMmpnU1EvT3hGNGFrVWVkajZ6M1p6?=
 =?utf-8?B?WDFJT21hS056RzNTUyswaUVxcjYwRFIreTFscithUkpnZFZibjIzNGlQUzZB?=
 =?utf-8?B?VFErKzRodWhpcVFqUEVYa3cxWTlyUzk1OFRiclpnV1lCWmZUSmtCMEQ4RnJa?=
 =?utf-8?B?OFRrc0V5Wi9JMWdTdkZ4V1FMNklJRHZvTE1saWZ4TkRoN3gyV0RDTUZyRllO?=
 =?utf-8?B?d0o4OGJMLy9rekJCaEZuVHV5azlaOFZ5RTE4TklWNlc5RzIxZ2lKRXNKYkJl?=
 =?utf-8?B?eGhSTWVUVmRBdU1UUmwwT1BQRXhlN2VkOWFtN0NNd1hDald5WVJUY1VCNkxu?=
 =?utf-8?B?ZnV2Q3RMVjlTTGRlbmsyZG9KVStHZURlY3NqUzVqTkR6aFRHS2YxdTNaTVkv?=
 =?utf-8?B?azlqaUNwNXUwZDZBczBzcUlva20zMFYxS3BPMmVoZXpVdTRNMVZjcGlZSUM3?=
 =?utf-8?B?dEZnNmYyL0lITm5EbUhQTGR0UWtNYmdHRlduRldERUpGd3FoVm1xeDd1dkdt?=
 =?utf-8?B?clh2d1E3eU40SzZmOHFnWnkxcXh0dTc2Ylg2bnBOTmpJSUtDNlV6ZUJiaHh6?=
 =?utf-8?B?R1lOcndIRnZzaXRieTlPZkdWdE1WeUJXaS9XQmdEUDlRazQ1Y0xOdGdqaWZ2?=
 =?utf-8?B?Y1BMNWhLSlk5WHNLRWJxMm5sdHBxSmZ0S3AvNjFHcjZrSktyRmo5OTRRVnU5?=
 =?utf-8?B?WlI5OEtPV0J6Y0RxQTJFMWdHUGFJcHdyZ2g5UmFmQTVHb1JEVlRjZWU5WGNE?=
 =?utf-8?B?bStCaW5LdkdGcndXc3FwTUFUVVN4eHFsNkRNQ0E0TEtzbElLOVVocVo4NjYv?=
 =?utf-8?B?eUpZRldsMGQ2SHd3QnJvOWZ0NkJiLzhuQTNmcUdHRyttTHV5M1U2VGgrcklV?=
 =?utf-8?B?YUdGRXZTbm80RTF6Sk0waGpOV2cxL3RwUkNXZTJQRFJNTVlITWVoZGRvbXM2?=
 =?utf-8?B?TGRQNDFjazhEZ3RTanNFU1lNMzZEVFhBQUhwbFN6OFJ2bm5SZ2l0UnVNak1Z?=
 =?utf-8?B?aEJJbHc1WXQyR3RGNFo3Y0xMYjdwVjlNSXRqTE1ORWp0ZU45WFpUbUhpOGkz?=
 =?utf-8?B?Rzd5emhuZG10YUxBc1RoV1poekFpOVdGVjc0NGVvOXZaajJzKytxNjN4S0VQ?=
 =?utf-8?B?dGx5a01rdElUV2hpcWVGZHhZT1BmKzFuOEhtdk05VUVrOGhwRXJlQ21NQk1i?=
 =?utf-8?B?NVVVanpuV1BUcS9nZnVOQTFjaytmbFdjUDl5enhBLzhONm1YUmp2S2toY0Mz?=
 =?utf-8?B?cTJndjV5UXl1QmRjd0VtS3lLcTFEUlJhYVN5b1VCaXpMT01TWjZkQ0tHZXlU?=
 =?utf-8?B?MGFoOEF4KzNnV2J5RVpHdnIwdDlZUUdIQzhKOTV6WGVxQnNPOVVycHlybzRP?=
 =?utf-8?B?V2JpUkZvOFM3U0dCNWMvNXVmTE4wNjc2SWxQQzYwY2l6YUplancxYTNlWHd3?=
 =?utf-8?B?UnhNUDFtdzJEOUFBenhDanRqSmhoSUFmZUluUEtIQ0NncDRoNS9kNGp3b3ZB?=
 =?utf-8?B?aW9vMm42aHFjdGtUZFRMTlVkMi9CWGhLTVpXNllOZjBvcG9DNzY0bWpFR2Jn?=
 =?utf-8?B?aWRyM2ZSdElXaE1PMzFxRXRPZ2JtYXVybGJtalBSeGtTTEFMaFkydDJWd1NF?=
 =?utf-8?B?OHE0VlBTQ2I3cEw0eUlKWnROdUEyeGhqNEJzZ0hnWkhNOTFBM0FQOEdrVVRL?=
 =?utf-8?B?cEZXeGJISzZPR1JUSGwyYlhXL29MNmkwU2VyY0FLbmVQNmlwN0VmUzF6YTBR?=
 =?utf-8?B?bENCUzk4dHE4VytmWjltRHhsK1NsNXNlYTZmalRxaWJKa2tqNkVHbTNRS0Ns?=
 =?utf-8?B?VllxVWp1aE5TeHp3dDlzczU0UmNEc0x0YWo2NGR2Q1cxREZLQXJENGVqa2pK?=
 =?utf-8?B?UVc5eWovK2tLR1JJdDRBVzRoT3k3eGZ3RzhQVGx4bXRsaHJIT3U5cmtveTFV?=
 =?utf-8?B?d1cxSHpFWk5tUitCT2k2S25lWEh5QXZBaHY4eG9uOFBhTGl1WlJyT0VITGhr?=
 =?utf-8?B?NkdBZjlLQkN5czI5TFVOa1pObis4VnFpekNzd2dSTEp6b05lSGdRVm1Fc0pn?=
 =?utf-8?Q?5fMcdB6FdySZX+AO0v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1358a61c-3a75-44ee-e6de-08df258766a7
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 21:59:18.4415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GD4IP/W6QWp0AE/vzrhrm0Gz/b3hEoAkZNrYlEctz2W+PgrJ2oAJpSVhjdoDmp1/3NbTHEcitqaa3ZVHRDjdfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9603
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

On 2026-10-08 10:06, Heng Zhou wrote:
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
> Fixes: 12fb1ad70d65 ("drm/amdkfd: update process interrupt handling for debug events")
> Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c  | 62 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h  |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  |  2 +
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 10 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  6 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 46 ++++++------------
>   9 files changed, 93 insertions(+), 43 deletions(-)
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
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 2847a5ec5ede..ef9c698bd5cb 100644
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
> @@ -1245,7 +1241,7 @@ bool enqueue_ih_ring_entry(struct kfd_node *kfd, const void *ih_ring_entry);
>   bool interrupt_is_wanted(struct kfd_node *dev,
>   				const uint32_t *ih_ring_entry,
>   				uint32_t *patched_ihre, bool *flag);
> -int kfd_process_drain_interrupts(struct kfd_process_device *pdd);
> +void kfd_process_drain_interrupts(struct kfd_process_device *pdd);
>   void kfd_process_close_interrupt_drain(unsigned int pasid);
>   
>   /* amdkfd Apertures */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 226f52626e84..c1a01260463e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -55,6 +55,8 @@ DEFINE_MUTEX(kfd_processes_mutex);
>   
>   DEFINE_SRCU(kfd_processes_srcu);
>   
> +#define KFD_IRQ_DRAIN_TIMEOUT	msecs_to_jiffies(1000)

Could we use AMDGPU_FENCE_JIFFIES_TIMEOUT here instead of inventing a 
new arbitrary timeout? If interrupts take longer than the fence-timeout 
to drain, surely fences will timeout, too.


> +
>   /* For process termination handling */
>   static struct workqueue_struct *kfd_process_wq;
>   
> @@ -1019,8 +1021,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   		if (ret)
>   			pr_warn("Failed to create debugfs entry for the kfd_process, ret = %d\n",
>   				ret);
> -
> -		init_waitqueue_head(&process->wait_irq_drain);
>   	}
>   out:
>   	mutex_unlock(&kfd_processes_mutex);
> @@ -1420,7 +1420,7 @@ void kfd_process_notifier_release_internal(struct kfd_process *p)
>   	 * back on the MES list and, once proc_ctx_bo is freed, MES would fault
>   	 * on the freed process context. Retiring the context last avoids this.
>   	 */
> -	kfd_dbg_trap_disable(p);
> +	kfd_dbg_trap_disable(p, false);
>   
>   	if (atomic_read(&p->debugged_process_count) > 0) {
>   		struct kfd_process *target;
> @@ -1430,7 +1430,7 @@ void kfd_process_notifier_release_internal(struct kfd_process *p)
>   		hash_for_each_rcu(kfd_processes_table, temp, target, kfd_processes) {
>   			if (target->debugger_process && target->debugger_process == p) {
>   				mutex_lock_nested(&target->mutex, 1);
> -				kfd_dbg_trap_disable(target);
> +				kfd_dbg_trap_disable(target, true);
>   				mutex_unlock(&target->mutex);
>   				if (atomic_read(&p->debugged_process_count) == 0)
>   					break;
> @@ -2313,17 +2313,14 @@ int kfd_resume_all_processes(void)
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
> -
> -	if (!KFD_IS_SOC15(pdd->dev))
> -		return 0;
> +	int r;
>   
> -	pdd->process->irq_drain_is_open = true;
> +	if (!KFD_IS_SOC15(pdd->dev) || !pdd->drm_priv)
> +		return;
>   
>   	memset(irq_drain_fence, 0, sizeof(irq_drain_fence));
>   	irq_drain_fence[0] = (KFD_IRQ_FENCE_SOURCEID << 8) |
> @@ -2342,32 +2339,17 @@ int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
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
> +				   KFD_IRQ_DRAIN_TIMEOUT);
>   	if (r)
> -		pdd->process->irq_drain_is_open = false;
> -
> -	return r;
> +		dev_warn_ratelimited(pdd->dev->adev->dev,
> +				     "irq drain on pasid 0x%x did not complete (%d)\n",
> +				     pdd->pasid, r);
>   }
>   
>   void kfd_process_close_interrupt_drain(unsigned int pasid)

Please get rid of this wrapper and call amdgpu_pasid_drain_irq_done 
directly from the interrupt handlers.

Thanks,
   Felix


>   {
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
> +	amdgpu_pasid_drain_irq_done(pasid);
>   }
>   
>   struct send_exception_work_handler_workarea {
