Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA733F44868
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 14:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7483A10E966;
	Fri, 10 Apr 2026 14:17:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X59wr0n1";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69E1910E966
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 14:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZs6jghdhlcxchZopMNf9BPiB4BVisiMpAlZza9F9AadB9Ntma6dzP+0AwU9d6uYU8JhXNaX0uGGdMdX2xSDCIiie/zDgSLxL7tZ2R9Nv1jcB8wHmNvvTrjyK3imCy2ht48YtajpnTArCp7M23A59Kf355l9L3kFiR0yemce89iq1RwDcdaqyU6sDp4FWHMrEZDSAtqj9FstPtBIqPGC1NZ1Qk7DJFpu7YDEDuJjckxgpRa7f3qC8qod6pI5yW5+DE6/RUaP1z2Km4Skj37X0A8IOuMZ4L2GM4yvFwQz3eKbHoyqX/oy8TmUDXv3nmxCk28e4p5iL9CJMSmrp8DZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RWg5o/fzr517l1Z1D6DmXswWGyY9OotNggSmQXGFVo=;
 b=ZvaY+/+WsdoPM4mfrgczNGVsb/HHWJsA+8actD5lTXA2cy5Zaq0r3nmLVfnYRONUNc4sMxKlFqhZyTwsFwCRhO9sGXIArorTFDKHmAwtRUOI4X8mBEuL0bMuLMytAEIM3xcUjtRX/W6KCnhtPX6L/F3V1Mls/9dP+Ine8vuLxToJEEKfvspGWpo8n2renacQX0LJ0d9Sl74b0wn/buALLGAejqk/5VEQ1RWhTDGCV8/XTd9+W7QfU6pEstN/USiZiSqqj1w8RyCAl+J/dBpJnYaJgn31JpSMzn7C+3CMJxUQrJhJ3+KNex8QXkmln6DHw5dqWu8QswmV3QLjZpVNpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RWg5o/fzr517l1Z1D6DmXswWGyY9OotNggSmQXGFVo=;
 b=X59wr0n1+yEIvWNJ6LufxqkHxKWg2CSNzQv4i2arN4+Z78xU6WJdwPo0gvwaVWQARsr+vJv3daWz1W4dWuNvgfN+TFerdbW1bgx8zdD/SSZpqHL1BK3YJUUp/jsFzYe0gum7YESnB392Kw/C4g+AAp9IOpPrIz3ZXiruD8tD+qw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 10 Apr
 2026 14:17:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 14:17:32 +0000
Message-ID: <e35490cd-7ce5-479f-a6b3-7319fe408b54@amd.com>
Date: Fri, 10 Apr 2026 16:17:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: fix heap buffer overflow in
 amdgpu_coredump ring dump
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
References: <20260410013639.129917-1-vitaly.prosyak@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260410013639.129917-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0338.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6e7450-b81a-445d-ec5e-08de970be7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: fYab8YSZwhdDISw3HIVwgi55WEsS/oY/8DGEuroWA7f7JxoOEVIlaHjVAtkWp6+PDlCDmBjP4D+E6jkWE+nnHm3yeQ/ZvqYewqRDOkb3ZB08pbrQL07IWvfIwF1MxeCOjs/ZWZOlqmIZbiJIOcj0Z0ulOp7+FBonII7eC5dZcyR/SOCTSrbD2h0G2r1t+vtE7XmyQjWX5LgVF4R3omZPtMTpfJFiAAKTINYBT8YKYYFcnTFppHYM/QwzEJX7U6VVTr6BEHUrFDOG3mTxYmgxoB4CLUcEcZ+Z1dW4HLhuDJl6hPm9IGHLN0l6cvsFSwpfq+L2etRLMg4RVC2qTOm6cHtaD7jqYiG9I4scHa5X1EQg0TuiK9l4j1qzTco8Y5KZBiKtaVoisx2KoLQkpiREEwvQ8mPsF8MRVYlVs3NDQNOyP6cr7pURVfOrLGNVjJ9XTDdP6DgLBhXO7dWOqMk5DR2yi1LOh7ZeHVxCtfRxrj1Ui9XgNQBOG8kbwKltuoEtbss0dr2hgCK3ENr+TGgylPFc49DoRMK7mrRAOHyqwG+Y+VLGEUDgiigf+YdjheismWM32yzquiYpyrd5weEZz9wgM6TDAJj9Zokn0gJCFYXaPWdWE/upWXxdUX6p1Z3UR3tYaXLIphFApUHfP2eqpwhhhjv/efbh+XfqgrmpTTvfE/XwtmNnhbYGPzbXqAe/HehhdtoAiShnTneah3rPdnWcXE5GzNpffyvl2bYZvkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2wvenUvbW1rZXYrSGVmWmhwbUFJTzFSa0Z3dEJRRHU1cXNhNVNRY2xKTlY2?=
 =?utf-8?B?MTNZczlWRFNxL3FqaDNGRVJTOFdhKzRqYzVKMVR3MjRtbFlkVWQ0akJGNHo0?=
 =?utf-8?B?M0NsL1U2SEcwVGRZd0RHbU04SHEzS2tqRktMTVNMMElIcnFNM25tcDB1MEFR?=
 =?utf-8?B?TG5VK2ViOG9udk8yMzZVcUNUNVFDK3hmSXgwaWlaWmpPbUhrV29razByNjJQ?=
 =?utf-8?B?b0tHaUhaTXhZRWFOWURUY3lULzhkVlllNlNudGI1b1V2dWNmeG5xK1FlOE92?=
 =?utf-8?B?MEt2cGx4UVVmY3N5RE12T1lPaVFQMkh3ZnZjVHVwVE1HOW5sSWZnaHVpR1lz?=
 =?utf-8?B?YWdSdnhuNGdwWkFudnFkQTEzbmFDditmZ1RVdWhYM1ZXNXpET1JwVHN6MC91?=
 =?utf-8?B?VEpDemtqVlp1NXoyWnY2d0dPMGRDV3dJVnFkOUM0SCtJYk9LbmU2V2IwTHNy?=
 =?utf-8?B?Y2p3c1FCVUR2azgzWW5CcWpmYzBPV0JHRlNkYm14ZzFQS3FUc294cWpGWXlX?=
 =?utf-8?B?M2xiOXNJTFNndUlBeFZTNG1BLzFiSmNnTTdRa1dTRXlreWoxZjg5VDFTTTNw?=
 =?utf-8?B?a1RSSXBXZkNSc1EwZlBKVGdwMkZoU3hRUTFrRFc4SWhDZDZDc1J0ZEk4R1lX?=
 =?utf-8?B?blFzL0E4MHk2cFZlTjlPUjFsY3NGWVFndTdtR2dVNDk5UVVHN3NWK00wVnBw?=
 =?utf-8?B?VUswNWRmeWR4TjQzeFJ5ZHc1cmFPSUo0VUw5YkRydERVQ0xJRmhmTStwSWVS?=
 =?utf-8?B?bTVKMWVDZ1VrMHJtRmJFWDlhcXEvNyt6UEt5Nmo2Q3VUT3pYZ2xhdFNVWkp6?=
 =?utf-8?B?Z3VNNWNaUHlkRlkwV2Vtb1AxV3Ewak00Y3krUmVxZWtBY2xBVVFYK1JaZ09k?=
 =?utf-8?B?anBmOHpKaHBlaHl1OThtSnZlcFNsaU9OQmRFeVJlcUlyOHBuYk9jeHV1aU56?=
 =?utf-8?B?K3RRQzlQMjFtUGI2cjVGSWlsNHRCbk41Q3NnZUxpK2dLdGtjWnhlYTlOU3Rq?=
 =?utf-8?B?L0doZXVQOUNmRC8yS1Y5WU1KeW8yd2xNY2FRNzQ4QjJib1B6UVdpVjYrSjZV?=
 =?utf-8?B?enUxeGRGMXJ6Ny8xQ1YwQkhLZnVGNk5oNkt6b05TR1NyRkkrNWZ3QzExTkk1?=
 =?utf-8?B?Vlo4aGVsdHA1WDhnNExmSHR5NjZYb2w5OE9WSTZRSEQxcWdkZ005M0h3UGVn?=
 =?utf-8?B?QTBDbjJCMUllQ3dDUmFSZy9vbzNoelNwbFZlcy9adGRiKzl2VytnZnM2Wi9u?=
 =?utf-8?B?WDRNMTd1VnNGZWdyMEZ2MDdCUlZpSnpxMjZvTkNvT1RyNGV6N2pMQldVcmZq?=
 =?utf-8?B?RW04eERESmdUSXlyQTYvSzRrVlZpS1oxZ0tkZndNb1drcFY0R295TC9HdGY3?=
 =?utf-8?B?UlZoc2FWTW14TWFlTldXWXIvNk1hbmNYMWVOcFM5WGt0V3gyY1RGY3hBV0hU?=
 =?utf-8?B?eTVSQVQrQ1V6WFFxUFhCRHVVd0gycjJibWZVUlV4WXlsVWVmNCtFVEhZYVpu?=
 =?utf-8?B?c3N1ZXQ3UTBBM3FXWVp5STVhMm4xNWMrZ2g4ek5wejN3a25UVDdmTzFSeHVW?=
 =?utf-8?B?L1dtZ0V1TjhUYWI2TUt0MnM2elF0Zjl1ZFA5YW5nbGkvS3hoSUZTbHA5T2FP?=
 =?utf-8?B?TERITnRCc08rWml0N1dGYWpQTEM1bDVFT3JHbnEyc05mUVJPMkQ1aEFYSUQx?=
 =?utf-8?B?WTludUZuOHhvdnVaWWM3VHB0b3FQQVR0eUdESzhJSUVjL0oyN2RZZ0x4M1Nw?=
 =?utf-8?B?dWsyNzJ2bG5SejhCdEpvdFk5ODhIMzk2TlRsWXVYQWc1OHlmTUR0M3Zyb1B5?=
 =?utf-8?B?aUJIV1FuQUttNSszVDlXN241Nm9RZ2VuRVZ2a3dkMnRyQ0I4bkFsUTBIOVlG?=
 =?utf-8?B?ZmRVaDBsOXVhM0xHUUEwUE5OSzZzODNPREN4Qm1pWFo1UHBEM0xXdUtaWE5o?=
 =?utf-8?B?S29BVDNlWVJSb0Z6bmQxdWtXQTZSYWIzUk9TL2pUSW9ZcENuR0hZZHFpK2w1?=
 =?utf-8?B?VThTMXl3c1B3VDI0NnZJK1prbFFZanF5RTE4bG5pclI2TCsveno0NFZMM1gr?=
 =?utf-8?B?MmF2Snc3UllPQUpuaDhzajQ1R2xhZnZXRzVTT0ZESjJTazF6ZzJvMnBKeTJk?=
 =?utf-8?B?bTFWbitLWGthMDgxa2JUbUVadGk0d1ZEaCtNUytRQmo5NU5NaTh0aEtYWEgy?=
 =?utf-8?B?TmpOL0poajdlMzVDSnlsNUhCZFRHbDNWNHpXSnFaazU2Mms4Y0RXRTRKV044?=
 =?utf-8?B?d293MWRhUGRhd2F0R0hZdmNTeVhqN1BtTW53M1dNay9TeVY4dTdhNHdYZm9P?=
 =?utf-8?Q?04+hag2dgGwDfG2ltB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6e7450-b81a-445d-ec5e-08de970be7ee
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 14:17:32.7291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IeDHFcvxwK+3KPgKcn7ysIkRqULTOhdv7t29RD1ZpaE2HoeAikHVNC2ApQ/vq8S2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884
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

On 4/10/26 03:35, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> The off variable in the ring content dump loop tracks a byte offset
> accumulated from ring->ring_size (which is in bytes), but it is used
> as an index into u32 *rings_dw.  C pointer arithmetic on a u32 pointer
> automatically multiplies the index by sizeof(u32) = 4, so the actual
> byte address accessed is:
> 
>     &rings_dw[off]  ==  (char *)rings_dw + off * 4
> 
> This means off is effectively quadrupled, causing a 4x overshoot.
> 
> Concrete example -- two rings, each ring_size = 8 192 bytes (8 KB):
> 
>     total_ring_size = 16 384 bytes
>     rings_dw = kzalloc(16 384)          /* 16 KB buffer */
> 
>   Ring 0: off = 0
>     memcpy(&rings_dw[0], ring0->ring, 8192)
>         -> writes bytes 0 .. 8 191                              OK
> 
>     off += ring->ring_size            -> off = 8 192   (BUG)
> 
>   Ring 1: off = 8 192
>     memcpy(&rings_dw[8192], ring1->ring, 8192)
>         -> actual byte offset = 8 192 * 4 = 32 768
>         -> writes bytes 32 768 .. 40 959
>         -> but buffer is only 16 384 bytes!             OVERFLOW
> 
> With the fix (off += ring->ring_size / 4):
> 
>   Ring 0: off = 0
>     memcpy(&rings_dw[0], ring0->ring, 8192)             OK
>     off += 8 192 / 4                  -> off = 2 048
> 
>   Ring 1: off = 2 048
>     memcpy(&rings_dw[2048], ring1->ring, 8192)
>         -> byte offset = 2 048 * 4 = 8 192
>         -> writes bytes 8 192 .. 16 383                 OK
> 
> KASAN catches the overflow as a slab-use-after-free when the write
> lands on a quarantined slab object:
> 
>   BUG: KASAN: slab-use-after-free in amdgpu_coredump+0x775/0x13c0 [amdgpu]
>   Write of size 8192 at addr ffff8890b2400000 by task kworker/u128:1/329
>   Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
>   Call Trace:
>    __asan_memcpy+0x3c/0x60
>    amdgpu_coredump+0x775/0x13c0 [amdgpu]
>    amdgpu_job_timedout+0xdb5/0x1420 [amdgpu]
> 
> The corrupted object was a 4 KB drm_exec buffer from a completed
> amdgpu_cs_ioctl -- the ring dump memcpy overshot into this freed
> slab region.
> 
> Fix by accumulating off in dword units (ring->ring_size / 4) so the
> u32* indexing produces the correct byte address.  The reader in
> amdgpu_devcoredump_format() already consumes the stored offset as a
> dword index (rings_dw[off + j / 4]), so no change is needed there.
> 
> Fixes: 678236b37eee (" drm/amdgpu: save ring content before resetting the device\)
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Jesse Zhang <jesse.zhang@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 3f1cc2265645..8edec416fe2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -563,7 +563,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
>  			coredump->rings[idx].offset = off;
>  
>  			memcpy(&coredump->rings_dw[off], ring->ring, ring->ring_size);
> -			off += ring->ring_size;
> +			off += ring->ring_size / 4;
>  			idx++;
>  		}
>  		coredump->num_rings = idx;

