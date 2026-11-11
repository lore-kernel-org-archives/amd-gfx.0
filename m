Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6088606A33B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ag1RwMwp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4127D10E9DD;
	Wed, 11 Nov 2026 09:06:31 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013000.outbound.protection.outlook.com
 [40.93.196.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 993B410E9DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 09:06:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlvNksVeDehgMj7/sNclqKNoq1DpWU2S2U+eof5L4LrDJl2eFAR33p3uoLc5rPn4mqORDF5TlfkbSq2iBh0YIO8BEoHR7oPqFDxT+jSfgJOBGeTInBjjlvojYHXpE2f4d4+hUBAlF6kkgYSiAzAGg/f620qTwhF/ERDv7x0Mjn4Bl4NC9gRg0Viso9CFPKTHNsx6olu/nhjFbkqIcrjO20kFoEig/hvt/AXBiQkuAkWPG3YWvrJI4GsXqxTy5P0w3YRcuv954us9TkH1Rk+Q5WKYFUk60pG5xOMM49q+9FBMiXPkCDCHSj02gI8uj/5d5FjNeS1O0MQIUNL6qw91tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18s2nGRfv43WZZtSlqmlZLgFFpWZDYcpmzSj//Dj+t0=;
 b=IitzUewRsttqnXc51m1mIiJKg8vihlfLebIztsUABB7y7Yxr422yd6fviDprrnbXMxOBw33637MTa5H8tI+V4MbAvIGYTY6Boxoyz44ftm0o7tgj8ilfUCX9uLY2nSG9HbaJ3P5BSQ1BJ+AI94aEIuOIwTuWAFVtKK+IgHtjo7y7IKIZLIf4hjs7ZJQBz+PItUCJy4dUG/hmkiXTKt2H6mRcu8vrJuWfTkvG7NdVh9mhgOmAx6IkzHoVXs18cVplt1uw1w1xrVeDAyEhOoBA1n6fsHrU0VA7PlX3jLbNli3sJA3rZYOSiZX0fmrH7wJA5yyC6Yn4A5jtcNo5O4m0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18s2nGRfv43WZZtSlqmlZLgFFpWZDYcpmzSj//Dj+t0=;
 b=ag1RwMwpPXQYg1dgkuabVngE9A8WjjTNYs8dJkO+QU110615K4hCPoEGua8kByDIUQkDINJzmum67xosOBJTNFPp6jJQPgqeojD5zbJoqGWvvszoLqpqRdr7AAFMgU/DSaqGxt+FwLkXNmT8wSbNIxQmEqeEVpCcvDUNGHgllho=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB8789.namprd12.prod.outlook.com (2603:10b6:806:34b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:06:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 09:06:20 +0000
Message-ID: <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
Date: Wed, 11 Nov 2026 10:06:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/amdgpu: make CPU page-table update waits
 uninterruptible
To: "Mu, Zihao" <Zihao.Mu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
 <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB8789:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb2124b-8c90-43b1-b776-08df3fd30d49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|261009223027099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022075727099003|261102123227099003|261022105027099003|261026121527099003|56012099006|11063799006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: G8YBBUpKByRgkGYBBGPtq5YqQrPGwcdp6/yKJVQfVN6Sotf+2igGH1SvkPyjsDp0THbyBodKrZDHRjKhqtjMUPNreDJU9fzaU+sBQg1nX3BQecJKmE87K3E/xWVN8T8UEoVp35KevyGSzTjS1oINewEqIeNW7Zbu1IHuw59kKHEjDF7eWKemirh77dnUJzCfOIEk6wKMkostqDcLQUGgpDyJH3aMNmrzQCDE1BP3Fx/P9rIywqgLr+xQlgt5mDvUefHBT1pTjCBPExtTDOR2N8Rx+DIAMPmOkV66VrMBpYPLrtA5esil7sxz1kvp0RoK5UWoqB2kyv0EUupn2GmkyJaoyUbEp/XPnQ3kpGW/c5aVb5HY3WNyjHkGxU3tg+5cuU/hxBGeUf8n4it8lUtDGwZGnIdd3ZoM6nSepU1Ku25ZK5etusakm1OPD2PWsP5KBtpzfHMIuXaHELAMaW23tLbi4ml0XuxuHGfk89+TutuUn9RxvgBVMiD/EkwwF+2cqJQVBtDiRZlcgzpqwCz10SPC4WaViKmBz/iN5yztm5wFAO4bzmKgtOM/IcKhD/w5udGentxgE/+plhFUJbYlOQM/5pEzN8LT5TNithtkgMfLoaqJSCID6XVIEjfAw/Zj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(261009223027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022075727099003)(261102123227099003)(261022105027099003)(261026121527099003)(56012099006)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGxwWk13emp4RVJ2R0M2QldseVJjUmF1WGFxcnFYOVZTN0VxVkpWaHNiV0E1?=
 =?utf-8?B?dnJjZUtXWmppVFJXdFVSUTRxcjlxcmMrYjkzL21scnpUY3QzYW8zZzdiZmtp?=
 =?utf-8?B?TWpMSDk3Nnl2Q2s4NzFkZzBkcGRodXp5Vkd1NEpmem5XbDl5R2lDeUNVc3A1?=
 =?utf-8?B?NWxtQW1XYWtGT2ZxREJNMUNpSkJaWCsvN0htZ2lRTmF0UmJtb2FMdjZPR3cz?=
 =?utf-8?B?dEttcjhTTEdjb2VxK2RXSEJXdDFFaG85ZVh2NFdYYVJ1dExoTzZ3T282eVhR?=
 =?utf-8?B?YUp1Y3VLaThEeVZaMlVJOFYwY0owcktxbEJPSG9CcFJBY2dRR0doSW1lVEhO?=
 =?utf-8?B?OWs5dkZPUmY3KzYzc2k4bDdKNHROcHhHYVV2VnZIbG1MQ3lLOW11TGlhOThj?=
 =?utf-8?B?dmFNdDdWTVowd1BhQkNWdlF1NDlOU3lzQmZjcFRjMlpaaHNObEkydGtsLyth?=
 =?utf-8?B?RHlzeitmTlloVXNnS2RBak9tTVNLSEkxUHg1dzhBeFVjc082T0lMbmVoNEhK?=
 =?utf-8?B?dVp5RU9Cb3k3SUVDM1V6SHUvUDd3cnpoQnRqdCtMRWN5Q2p5SU5HZGpvZmww?=
 =?utf-8?B?aVdkR0x0UXU1aXRyOFY1UER0VkRpTmxoWDFZaDR3QVBncE83TkFpZTR1L1Qy?=
 =?utf-8?B?SkxvaTNIcktadUNpMnhlSHVXc0xickhZL1ZlYXJESXcxZWtPTnNpQ2VnWFlC?=
 =?utf-8?B?Q1BCUjZLalIyL2FRSTkwR3c0N0tOWi9WWFJLV0ltakllSCtMeUtlL3UzSnhZ?=
 =?utf-8?B?WWoyWCt4dDhCVlZrWXF6SEVrWXh0NmFGMHpiQkkxWDdhalp1RGlEbStjY2FP?=
 =?utf-8?B?MUNDQmlDODFFZi8vNWZ1bnlTWTJGZzlLNVRvQndWUVlZKzhyZWNpVUpITHNo?=
 =?utf-8?B?WjFFS1RsY1pxTlA1RHZNbzNwT2s3dVFNN21ZTm5MODlhYUoycW5Rd2hvb2p2?=
 =?utf-8?B?bkNGOHlhUXdmaDBRUmpKQWxwVnhBVzBuOTQ2UzhicTlSYXY5aGtlN1JYaXJ3?=
 =?utf-8?B?eVdRL0NTY3ZKcnBxRXdsdGl0NkRLeTdsd3AwYUdGWGVMK3ZWbUl4Q2tkMU5G?=
 =?utf-8?B?cU1DMXIxVUhMQ0FEbGxHbXZwa1ppaXNPZzVkcVNlZHU5VTB3aXlNRTBjL3Fh?=
 =?utf-8?B?Qk9CRWEvWHh3aVBPMEtscTMzeUpTSFJ2Z3kvdFNVa2FDLzVRZUJ2OWt6MjJY?=
 =?utf-8?B?RE5aNUhOaGcwNDk2L3B2YVdKZWsyRDRUUGhyNG8zRElpUU1BK1drMXdvQUFS?=
 =?utf-8?B?OHVoK0dYd215MkliYUtFOVg2di92YzkvU0lucjViSnQ3TG5QalhHT2NYamlH?=
 =?utf-8?B?ajFGQnp4Ri9adW9pek5CeG1PK3JvNFVsV0NJYUkxV3JsVkxZYi9oTGMxeTZz?=
 =?utf-8?B?OU9vMVZ2VUcwSUFHVkd4S3NNdXNQdGtTQ1JIeUkyQjRCVDJxZDl4M1lzL1Q4?=
 =?utf-8?B?ZUtKbmtLWFNIZC9ITWFPaGpYMzdLUkFMbW1DQS9vOEUrL2w2dUxQdjB3VzVO?=
 =?utf-8?B?TGR2MXRIRklYaGF5NGlTbTNGc0ZpM3lUUHN1bUpISVN1aUdHbXFaY1BEemJa?=
 =?utf-8?B?VTEwZVp4QnNhcGI4VTdsNEdJTjZzRXB3dTF1cE9tcHZ1dnlXNm8zYWI2R1VN?=
 =?utf-8?B?SG5iUTNReXhDVkcvcm5oMkJESHlHM0FmNXBqbEdiZ2dacjZtUHYxL2wxRE9q?=
 =?utf-8?B?MXE2djZCNk1sUWRnNnZPejNjcUg4cWEyYVBXSzVDRTkvb0FjZmpHTzVOTk5i?=
 =?utf-8?B?OHdWN25zNUloelhaVEM3R1JUd29TQWphdWoxTm5adFlMbjk2ZEc0VWRWbSt1?=
 =?utf-8?B?TjFuMFdyN0VCb3AyeFpKMEhvSFd3YmFmT1p5WFlHZWFCb1VxRmRwaE9QbFEv?=
 =?utf-8?B?QUp5RkNRdDlLM0Z6dHVianA1dzRSb0hvMEtXUjFnam9CTmM2d1hSVGxLYXh0?=
 =?utf-8?B?bElKZmlldU1OdG4welJQcG5BWVZvYUVzM1VVVFBQMWl6NU9YT0xYTExJMXhJ?=
 =?utf-8?B?TnIvamZneTNjc0FpQWlLRjNITDFRWEYvMVBhTnY5Z3Y3dVdnSnhjamRDdURV?=
 =?utf-8?B?YWF6aFYwVXBWWkRlc2xDTFNiTXpDb0FZcDhBeWRPL0VPRXpLWGNWMksvc2xL?=
 =?utf-8?B?M096b25OSURMYTJ5TW5Tc0RUUTFtSnNUK2dHbkJqRWJtRmd1MmQ0NUkxTUky?=
 =?utf-8?B?WlpJL2I5VHZ6dHhLL2I3b3J6SDh5MFprWml1bkx5NEY5bEtzR1VkOWQ4Unlx?=
 =?utf-8?B?UGV5SXorTFNMS0hIMFdXa08wRUowYzdYdHFzVmgzVmx4WXUzdHIyenRDQlpR?=
 =?utf-8?Q?btOoZexZAQJ0D+QGwm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb2124b-8c90-43b1-b776-08df3fd30d49
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:06:20.6043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNeDowtJ/1HtOHzski41HHUNDXEL86xDQGZyQuBuOKBNH34k99617rx11ryXlUsL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8789
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

On 11/11/26 06:39, Mu, Zihao wrote:
> From: zihaomu <zmu@amd.com>
> 
> The CPU update callback waits for KERNEL fences before writing a batch
> of page-table entries. A pending signal can interrupt that wait and
> return -ERESTARTSYS without writing the entries. The PTE walker ignores
> the callback's result and advances past that batch.
> 
> Page-table updates must complete instead of abandoning writes because
> of a signal. Make the dependency wait uninterruptible and remove the
> interruption error path from the CPU update callback. The dependencies
> are still waited on before any entry is written.
> 
> Keep the shared update callback type, the preparation phase, and the
> SDMA backend unchanged. The CPU callback still returns zero through the
> existing interface.
> 
> Link: https://lore.kernel.org/r/4edd67f7-381a-4446-9509-552739c8f016@amd.com
> Signed-off-by: zihaomu <zmu@amd.com>

The Signed-off-by line should be your full legal name, e.g. similar to a signature. At least of hand zihaomu doesn't looks correct.

> ---
> Hi Christian,
> 
>> Yeah we need to remove those error codes. PTE updates generally can't fail.
> 
> Thanks for clarifying. I have replaced the propagation proposal with
> this focused first step for the CPU update callback. It waits for the
> KERNEL dependencies without allowing a signal to abandon the PTE writes.
> 
> This is based on drm-amdgpu-next at a6836fcbb5b2. The previous walker
> error-propagation diff and its cleanup prerequisites are not included.
> 
> This is not a complete conversion of all VM operations to a no-fail
> interface. The CPU preparation wait remains interruptible before the
> update phase. The shared callback type and SDMA backend are unchanged;
> SDMA dependency registration and replacement-job allocations can still
> fail. I have not hidden those failures behind a void callback or added
> an unbounded allocation retry loop.
> 
> For the remaining SDMA work, is there a reserved-resource or map/unmap
> split series I should build on? Job, scheduler-fence and IB allocations
> need a forward-progress design before the remaining errors can be
> removed safely.
> 
> Validation of this patch:
> - 28 modeled dependency scenarios and 384 parameter combinations, using
>   the native CPU update and reservation traversal function bodies with
>   simulated fence/storage primitives. Both the original omitted-write
>   behavior and a deliberately broken swallow-the-error control were
>   detected. ASan/UBSan reported no errors.
> - amdgpu_vm_cpu.o compiled with GCC 13.3.0 and CONFIG_DRM_AMDGPU=m in a
>   fresh private build directory. Strict checkpatch: 0 errors/warnings/checks.
> 
> The PTE write/flags/commit code is unchanged. This has not been linked
> into a full module or loaded on hardware, and it does not establish a
> fix for the original multi-second queue stalls. The independent CPU
> fence-scan performance proposal is not included here.
> 
> Regards,
> Zihao
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> index d03b9bbe20c..dc1cebbc0d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -78,12 +78,10 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
>  {
>  	unsigned int i;
>  	uint64_t value;
> -	long r;
>  
> -	r = dma_resv_wait_timeout(vmbo->bo.tbo.base.resv, DMA_RESV_USAGE_KERNEL,
> -				  true, MAX_SCHEDULE_TIMEOUT);
> -	if (r < 0)
> -		return r;
> +	/* Page-table updates must not skip writes because of a signal. */
> +	dma_resv_wait_timeout(vmbo->bo.tbo.base.resv, DMA_RESV_USAGE_KERNEL,
> +			      false, MAX_SCHEDULE_TIMEOUT);

The problem is rather that we shouldn't call dma_resv_wait_timeout() here in the first place.

That should be done in amdgpu_vm_cpu_prepare() instead but currently can't be done there because we don't call commit/prepare around page table allocation.

So we need to fix that first and then fix this bug here.

Regards,
Christian.

>  
>  	pe += (unsigned long)amdgpu_bo_kptr(&vmbo->bo);
>  
> 
> base-commit: a6836fcbb5b22968019256025321d655b78bc49c

