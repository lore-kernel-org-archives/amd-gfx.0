Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39757C3DA63
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 20:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FA1810E04B;
	Wed, 24 Jul 2024 20:34:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PKvOD0GI";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D12110E04B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 20:34:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixkJrJs1DcakHLRZ3HCXJP0iFSdnQWmTZ7yRfYsAN6wiqtPgzHRmfNN+9awM9+cY6FmlK0TjERKN80ImF3JUndW5XRiGYGcXpNOuSv3LCxEEk/ooG+DUSqTjVTIutCKstNPxbAAs9iSfbUvS4PphM1XACl9wfwiyAtrgC3JWojwQ28+OIbLjXBDd/i9VXLIR+TZoT3OKBgJMGqIq4yQK7lC/gdtSkkFXaLJIIYQq8ErwU0Er5ZAxGh4umW65Oa+PaRzzPPI0evXjnWWSkxRxE8TKPBWLFp5asJ+3xLU/biKcNxJxjacntT4KNeDkRagZgRcxwi2a0Rj+K6xTq3XAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2rrCCiLtlLExEBTyxHuj1OvqkA01w0vUB/eQVATQW4=;
 b=mh8UOpGlYkUqG4g7KC0zwj713AKZv+IuD+ApnKPTiMCATRVH/FuHZk4zYOOxfDdWKctM5wR5BKxtn3oi4m+Uuq+t6qwjMTHHFxNTluScfVsAxyhYou9i7wT+/inWzcdShgfIeWjzcEgVKRKRGQG5U0jfVGuj597fga61/8j6h9ELAxPES9nQulGbByJRZe0/8+y1YmstajHQ0mc1wdFQjMOl0IcyOzDEolXePjkCXmLJnsSY3luNvSNd20SJ7Bi32ONDWvkmdRYD53F5acIahcl4r3tMp4IixQDymAdg7Q5kUtXSHqyBtBTCigv/SPT2/RxD8DTFSyygWDmyEdnpDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2rrCCiLtlLExEBTyxHuj1OvqkA01w0vUB/eQVATQW4=;
 b=PKvOD0GIfMEjKCN1GncbAjQSH+okMXh97IvKXTFuy7YhQPMAUJrr7e9LwztdI73Wf10LsezKBSGNni+6paHQGdX7NXsLrBzXb1LANzY1vNOJCkbQom1PoZm9hYCBRf/djVwnaejVvCGN47OKVgQHWHJeJtqqm59zCOd1gEZF/eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Wed, 24 Jul
 2024 20:34:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 20:34:41 +0000
Message-ID: <e1d3a744-43b9-4fae-a49d-11504fe13a37@amd.com>
Date: Wed, 24 Jul 2024 16:34:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: support per-queue reset on gfx9
To: Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240718175645.1002418-1-Jonathan.Kim@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240718175645.1002418-1-Jonathan.Kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0204.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c0c3155-b655-4a71-ad89-08dcac200b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SW1XeVo1ekdwRjE3NU9wV1paWXM1MWpiSGpZaG1sakwvOEh6aU5DaWJNQWJJ?=
 =?utf-8?B?Mi9GdHhqL2ttd1hpa2ltK3hMM0xFOHpKSnVtRHNTTktzNnZwOVRhdUhFVm9X?=
 =?utf-8?B?VE5LVEg4MnZlS3Z1T04wT2VaYmpsVzFmcTgwV1ZvdEw3RWtmS0FYbFJla2tz?=
 =?utf-8?B?OGdmN0xEcnBrRGNmNkYzbDMveitIQk5WY2FGeVJ3dkQ2K2ZvMGc2Wmh4NUxm?=
 =?utf-8?B?Y2NZVVFGUjkzZmpEUk1HOVVROEJpOWw2cHlQd1RuOFRkZnF6cGRJYjZvdGI1?=
 =?utf-8?B?NUx0MGlFTDVsZHJxa3lHem1yRGxXbi9OblJTSFRGYVVabC9SN1ZXaWo3TnVn?=
 =?utf-8?B?R3Z6UXZkcWxJMHVPQi9yNHpoa2tHUW5Dbm1jUW1vNE5HR0JtREhyRFU4aVZa?=
 =?utf-8?B?UHcwOFprL1djRTBNRjhraE1TelFrOHp0WXBRd2RaV1ZRcm1tTkFBOUIrYUdr?=
 =?utf-8?B?NDZlZk11S0lka2Vxcm9MQXlYdzJPaCtOblIreVVjdWpIb1I3L2hsR2VhOVVP?=
 =?utf-8?B?TGpVSk5XQXMzdjBJTld3QnR0eUxPUmh5WklDNHp6NFJ0OXM5YXFkY3FLeWMy?=
 =?utf-8?B?bGxvR0I3TVpvaTRWaEVKcU9OQjNLWFhCTFVTRm0xbGNCZ1RFREVUcHVHL3p0?=
 =?utf-8?B?TjNxdnQ5UzBtR0JOZmF2Rmg3cDU3WUNvTXR5ejNmSUF5RGhINjdld25EWU1J?=
 =?utf-8?B?VEF4VDI1cEJmMEE1Smt1ZkdTUUU0MVFLV05RYkZ5aURJSi9yaTVyckJaYlls?=
 =?utf-8?B?cWNuc3hDTVRxTXdqWFFYYnVZakVKU2E2dGNEdC8rQi90VVdZSlZWdlR4a2dI?=
 =?utf-8?B?Q01wMUNjNTZzdC81WVZiUVdheVBMU2FvTFMxNmhJY1NIYWZ1S2hvVGxzVi9L?=
 =?utf-8?B?QXAyUm1zWlgxQnFHL2lNTWJUZzFZdTJBK090ZnZ2SVVJK0dLeGhSWVhKakZm?=
 =?utf-8?B?N3pzNXNIamlQd0dVRzFIRFFGUEo2c0loNFkzbno3d3pTbit1V3BqZExNeDkv?=
 =?utf-8?B?Yi9kc2x5NUR6ditZSEhUdlh1NllkV1RzZjVJRi9JbkZKY3hXamhCZGRpSWFD?=
 =?utf-8?B?MVBWN1IyNXUweEJNM0xuMk8xSnlvVHBDaHY0QzZVTEFZbWo2TFdMcXEwcG9J?=
 =?utf-8?B?TUE4SkM0MWFOL21zTngwdjlIWEg4dk9MZlJ1ZHIvTi9sVFJBNVZVNVFZdkw3?=
 =?utf-8?B?c1BFSVJHNVBsUXdBNUdQSTBsUStPRU1tMHVySWxZNit6bEl5S0lPbzZJSlpS?=
 =?utf-8?B?Y29pb0ZvbEpIMWVBZm1DbDNpUFJIeHQ1K21abVpYUGEwc0pCSXNZU01YYlNy?=
 =?utf-8?B?R1J0SjlqclFLSnV1QUlHVnZxc1lRRVpWL09QU2R4VFVnRjh6NjhleU4xcEYy?=
 =?utf-8?B?RlFkNm5peDM2UFljZEErY1Z2dlFmdVBYeEpWTDhUR3d4NHlXWmpiT3FiOUxz?=
 =?utf-8?B?V1RINkVCbHQ4eCtwSjBLOGwwTzlOVzRrdVRqa0Y5Vjk0bENzNzhuU1c0S0t2?=
 =?utf-8?B?Q0UwM0p2YzNhVHRkYkk4OGdIeHNiQkJJZFF0OW9ZUjZLKzBPZWZrM0M1OFhy?=
 =?utf-8?B?MXhoSzdLNDI2cDNmYlpwWUxsMVh4c2taMERhTXY4Z2FaRnJhbnlwZXZTRnpw?=
 =?utf-8?B?eThNY09QNDlGaVJZLzB4QXpGbEh6SE1oVFVDUkN0L1kyVWZRMFI5USs1RXFV?=
 =?utf-8?B?YVQ2bHN0bm9hd2x2OFdOT05GZjVua3d5VVN3emVid2piR0kzZFRvTFMvdW4x?=
 =?utf-8?B?bkFvVEJlZEp5bi9JaklJRlhHdW5GUFhWQ2JSRk9udEdpRU5TMkhNZldVM3lD?=
 =?utf-8?B?cEdnNnd4U2JOVzVvdEd6UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzZDR1hVakZsRGF5eWoyM3pMRFVjTHFjaENWWUQ1VVgwdVZPaEpoMWtDMlF1?=
 =?utf-8?B?aFZpNjY3amtEQlBDejNLamwzdzNwSEFEM001c1h5WTlDdXAyVjlWMWV0Nldn?=
 =?utf-8?B?VmtjaUw1UmN1aVhZRnBQUVlzOXR0QkpCRjBmSDhLWmZDYnNjWHpUOGVSc0tm?=
 =?utf-8?B?VXV6RUtoMklhZ2FRbDJQRGFiNTNsd3dsbEJPN0Vod25NVVM1Y2lSOTZqV0Jh?=
 =?utf-8?B?blg3S3Nsdk1yMTJaYmpKakFENkVKVE9rbTcvUjllUEdoT2Naa2tOWmpzcmtF?=
 =?utf-8?B?ZVVoRi9FTnN5MW1DZmEvK2dNeFdYUjVQdWNxSTNwMGYzRFE4MjF2a3YyT0pF?=
 =?utf-8?B?WjVoVEdvNzhXN0kwWks2SW1KcmxWWEVkWCtBRUlXQnQ2RUJmV3VMZnJHeS9S?=
 =?utf-8?B?QTN1K2dnNEZ2N3JEZzVOTmc4NHhwcU5WaXdwMkhVOWhpUlNDQ3B4YjV6REhD?=
 =?utf-8?B?ak5KdlczNTRla1JPSjVJejZFUUxBSEpJNnZwdE9PY1RQWklJb2pTcDFyeVpo?=
 =?utf-8?B?cGNtaG5aMGFtbE8wYUJKUmJ4bHc4MEkxeDZYOGhqTWFHbmV0WkNNT3NEMnhm?=
 =?utf-8?B?ekFDSmFYVDZXenNTRzBhTUxwT0E0ZUluRnI1NnFvNVBxZTMrQUlNYm0vVEl3?=
 =?utf-8?B?Z083ZE16RGZQamg0dWp1L2RKRnYwc0pRODZIZ3ZtSmVoV1d1ZVZKY0VFM2pB?=
 =?utf-8?B?UEc1eHFmYzlhL3FLZDd1UXBCczFoTW05eVpRcU0vdzVZR3NKSGIreFZlOTZi?=
 =?utf-8?B?cFR6ckVKeVdFRWp3V3ZkUTE2UHNXMEpRWnczY3AxOTBGTUU4U2V2ZHptK2Vs?=
 =?utf-8?B?NXR1enlQUGFhMHQxeVFBMTYrWWVUaHcwZDgvSGNqUDVUL2J2V2JxdVN5c1Z2?=
 =?utf-8?B?bE92ajJSc21aNzl4dnNvVWJJU0YrMU4vS2JLWkd1d01jYlQ1Wnl5QTkxUGYy?=
 =?utf-8?B?L3Evc3NuRTcrbWxXdVhrRnhVT0NDT0ltYmhhMG9QYU9IeWJmRnFjcmRhb0o4?=
 =?utf-8?B?Y2p4L0F0NWkxcnVyY1ZGc09ncnV4NDdGQ3Ezb0R5aWF2VTVyRVY1Lzc2Yy9P?=
 =?utf-8?B?cUU5VnFhVW95WUdGcTVZYW1wY21LcWN5MzRaTmVidWZ4OWRYbHZ1ejE4ODht?=
 =?utf-8?B?d25BbDFrTTE0b3R1YU9uNEZTODlmMFpqMUdkaVhpYUlzOC9Oam0xYU5adFdh?=
 =?utf-8?B?YmQvdi9lbHVaa24wVmViSlpVMkFNTkU1TUpBcHl3Y3RnTHJsYkxwWW56T2RD?=
 =?utf-8?B?Z2o0ZlZXNGdkOXpFTk5YeisvbkRxNG1WSm1STSsrekVHMmJseWVPZGdSVG5o?=
 =?utf-8?B?OGI5dkpldFV5K3FHUXV6dUhoV05rbG5mbzFCelQzKzlYU0laLzl4SHl4QmlL?=
 =?utf-8?B?U2YzY3VTcHZEV0NQKzE4SysydWcvSzRyNE4xQmxYbWIwUENQWEdYWHVjZVYv?=
 =?utf-8?B?Z3hkcHVROThCS2wycXRtRHBiL1JsQkhPL1V1M3VhSkl3N0VkZTVzaFlwRjBh?=
 =?utf-8?B?WVpTRG1kRWxQbWRTTnlHejh5TE9KS1lHdU40dElkYWZaSmlZL29aOW5iYVQ1?=
 =?utf-8?B?MEpLdWk5WExXNU43eUtzNThkT0pLVlBrT2h6MFBSZTlzVG52OUlwWG03NnFG?=
 =?utf-8?B?ZlNvMzJtUDBEcnhOWFR1U1lyNkVoMjQzYk9pMzgxV0tBWGhZTkNXcHU3c2RI?=
 =?utf-8?B?bi9jUE4zR01ydFlFZXNDWGdKZGxxZzEvaWhGcU5zZFNrakxTaWlXOUpiRnVj?=
 =?utf-8?B?a0FsVVZMZkpPOHF5NjczQ3hkd0RpOFVjVTE2Q3hpNzdwU3lNSU4rN3Fxdmxz?=
 =?utf-8?B?TU13TDhRYTdYTkEvNENKM1lwMFZLdFhZUWg4UE56MDhtLzRSY1pHNVVtKzVO?=
 =?utf-8?B?cUdLSTBzL2dkdmNsT1NhekNLdGNsL25oZGtkTXlsbUJTTm1pUVpGVys2QnFi?=
 =?utf-8?B?SDVxS2UxNGwvb0ZOKzJ1ZFQ5cUt1M0lLRGhKUnJ5U00za01uN3l2RkhnOGF5?=
 =?utf-8?B?bGxET04zNU1Ub2k4VHhTOU1PMm1UczVQNFREUVF3d0xmbGh5eDBUTUdCUVRG?=
 =?utf-8?B?TmVGY0ZUZEREdmhEZnZxdkc5cElQeWFhL3FIY3pmb0lXYnVYVXRQZ0E3TWZ6?=
 =?utf-8?Q?YoDloxEhjILhdYXMu8sMposPd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0c3155-b655-4a71-ad89-08dcac200b9c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 20:34:41.5070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIA2yF/qg+0Suk+aSvhJ9LFLwRb8jn1vAtrbiboFwkChQ3oGqGRt8H9GY3C7xMCv844AKdOV4WUMtqcY7eFrgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306
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


On 2024-07-18 13:56, Jonathan Kim wrote:
> Support per-queue reset for GFX9.  The recommendation is for the driver
> to target reset the HW queue via a SPI MMIO register write.
>
> Since this requires pipe and HW queue info and MEC FW is limited to
> doorbell reports of hung queues after an unmap failure, scan the HW
> queue slots defined by SET_RESOURCES first to identify the user queue
> candidates to reset.
>
> Only signal reset events to processes that have had a queue reset.
>
> If queue reset fails, fall back to GPU reset.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   1 +
>   .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |   3 +-
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |   3 +-
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |   9 +
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |   6 +
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |   3 +-
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |  11 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  56 +++++
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |   6 +
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 195 ++++++++++++++++--
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  12 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  15 ++
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   6 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   4 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   2 +
>   .../gpu/drm/amd/include/kgd_kfd_interface.h   |   4 +
>   16 files changed, 310 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index aff08321e976..1dc601e4518a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -191,4 +191,5 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>   	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>   	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
>   	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
> +	.hqd_detect_and_reset = kgd_gfx_v9_hqd_detect_and_reset
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 3a3f3ce09f00..534975c722df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -418,5 +418,6 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
>   	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>   	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
>   	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
> -	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
> +	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
> +	.hqd_detect_and_reset = kgd_gfx_v9_hqd_detect_and_reset
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index a5c7259cf2a3..b53c1cfa34de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -541,5 +541,6 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
>   			kgd_gfx_v9_4_3_set_wave_launch_trap_override,
>   	.set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
>   	.set_address_watch = kgd_gfx_v9_4_3_set_address_watch,
> -	.clear_address_watch = kgd_gfx_v9_4_3_clear_address_watch
> +	.clear_address_watch = kgd_gfx_v9_4_3_clear_address_watch,
> +	.hqd_detect_and_reset = kgd_gfx_v9_hqd_detect_and_reset
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 3ab6c3aa0ad1..dd449a0caba8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -1070,6 +1070,14 @@ static void program_trap_handler_settings(struct amdgpu_device *adev,
>   	unlock_srbm(adev);
>   }
>   
> +uint64_t kgd_gfx_v10_hqd_detect_and_reset(struct amdgpu_device *adev,
> +					  uint32_t pipe_id, uint32_t queue_id,
> +					  uint32_t inst, unsigned int utimeout,
> +					  bool detect_only)
> +{
> +	return 0;
> +}
> +
>   const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
>   	.program_sh_mem_settings = kgd_program_sh_mem_settings,
>   	.set_pasid_vmid_mapping = kgd_set_pasid_vmid_mapping,
> @@ -1097,4 +1105,5 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
>   	.get_iq_wait_times = kgd_gfx_v10_get_iq_wait_times,
>   	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
>   	.program_trap_handler_settings = program_trap_handler_settings,
> +	.hqd_detect_and_reset = kgd_gfx_v10_hqd_detect_and_reset
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> index 67bcaa3d4226..9eeda8808a3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> @@ -56,3 +56,9 @@ void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
>   					       uint32_t grace_period,
>   					       uint32_t *reg_offset,
>   					       uint32_t *reg_data);
> +uint64_t kgd_gfx_v10_hqd_detect_and_reset(struct amdgpu_device *adev,
> +					  uint32_t pipe_id,
> +					  uint32_t queue_id,
> +					  uint32_t inst,
> +					  unsigned int utimeout,
> +					  bool detect_only);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> index 8c8437a4383f..9872bca4156b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> @@ -680,5 +680,6 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
>   	.set_wave_launch_trap_override = kgd_gfx_v10_set_wave_launch_trap_override,
>   	.set_wave_launch_mode = kgd_gfx_v10_set_wave_launch_mode,
>   	.set_address_watch = kgd_gfx_v10_set_address_watch,
> -	.clear_address_watch = kgd_gfx_v10_clear_address_watch
> +	.clear_address_watch = kgd_gfx_v10_clear_address_watch,
> +	.hqd_detect_and_reset = kgd_gfx_v10_hqd_detect_and_reset
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> index b61a32d6af4b..483937c571ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> @@ -786,6 +786,14 @@ static uint32_t kgd_gfx_v11_clear_address_watch(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +static uint64_t kgd_gfx_v11_hqd_detect_and_reset(struct amdgpu_device *adev,
> +						 uint32_t pipe_id, uint32_t queue_id,
> +						 uint32_t inst, unsigned int utimeout,
> +						 bool detect_only)
> +{
> +	return 0;
> +}
> +
>   const struct kfd2kgd_calls gfx_v11_kfd2kgd = {
>   	.program_sh_mem_settings = program_sh_mem_settings_v11,
>   	.set_pasid_vmid_mapping = set_pasid_vmid_mapping_v11,
> @@ -808,5 +816,6 @@ const struct kfd2kgd_calls gfx_v11_kfd2kgd = {
>   	.set_wave_launch_trap_override = kgd_gfx_v11_set_wave_launch_trap_override,
>   	.set_wave_launch_mode = kgd_gfx_v11_set_wave_launch_mode,
>   	.set_address_watch = kgd_gfx_v11_set_address_watch,
> -	.clear_address_watch = kgd_gfx_v11_clear_address_watch
> +	.clear_address_watch = kgd_gfx_v11_clear_address_watch,
> +	.hqd_detect_and_reset = kgd_gfx_v11_hqd_detect_and_reset
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 5a35a8ca8922..9428e98ac12b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1144,6 +1144,61 @@ void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
>   	kgd_gfx_v9_unlock_srbm(adev, inst);
>   }
>   
> +uint64_t kgd_gfx_v9_hqd_detect_and_reset(struct amdgpu_device *adev,
> +					 uint32_t pipe_id, uint32_t queue_id,
> +					 uint32_t inst, unsigned int utimeout,
> +					 bool detect_only)

This is a bit misleading. This function doesn't detect anything. It just 
returns a queue address and optionally resets the queue. And the way 
it's called is like "detect and reset, but don't reset", except that 
last part is not obvious if you don't know what the last parameter 
means. It would make the code easier to read if you split this into two 
functions: hqd_get_pq_addr and hqd_reset.


> +{
> +	uint32_t low, high, temp;
> +	unsigned long end_jiffies;
> +	uint64_t queue_addr = 0;
> +
> +	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
> +	if (!RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE))
> +		goto unlock_out;
> +
> +	low = RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_BASE);
> +	high = RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_BASE_HI);

You may need to disable GFXOFF before accessing these registers. Maybe 
you're assuming that the GPU is not idle when you're getting here, and 
maybe that's a good assumption, so I'm not sure.


> +
> +	/* only concerned with user queues. */
> +	if (!high)
> +		goto unlock_out;
> +
> +	queue_addr = (((queue_addr | high) << 32) | low) << 8;
> +
> +	if (detect_only)
> +		goto unlock_out;
> +
> +	pr_debug("Attempting queue reset on XCC %i pipe id %i queue id %i\n",
> +		 inst, pipe_id, queue_id);
> +
> +	/* assume previous dequeue request issued will take affect after reset */
> +	WREG32_SOC15(GC, GET_INST(GC, inst), mmSPI_COMPUTE_QUEUE_RESET, 0x1);
> +
> +	end_jiffies = (utimeout * HZ / 1000) + jiffies;
> +	while (true) {
> +		temp = RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE);
> +
> +		if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
> +			break;
> +
> +		if (time_after(jiffies, end_jiffies)) {
> +			queue_addr = 0;
> +			break;
> +		}
> +
> +		usleep_range(500, 1000);
> +	}
> +
> +unlock_out:
> +	if (!detect_only)
> +		pr_debug("queue reset on XCC %i pipe id %i queue id %i %s\n",
> +			 inst, pipe_id, queue_id, !!queue_addr ? "succeeded!" : "failed!");
> +	kgd_gfx_v9_release_queue(adev, inst);
> +
> +	return queue_addr;
> +}
> +
>   const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
>   	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
>   	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
> @@ -1172,4 +1227,5 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
>   	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
>   	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
>   	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
> +	.hqd_detect_and_reset = kgd_gfx_v9_hqd_detect_and_reset
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index ce424615f59b..cf70d8fc3d10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -101,3 +101,9 @@ void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
>   					       uint32_t grace_period,
>   					       uint32_t *reg_offset,
>   					       uint32_t *reg_data);
> +uint64_t kgd_gfx_v9_hqd_detect_and_reset(struct amdgpu_device *adev,
> +					 uint32_t pipe_id,
> +					 uint32_t queue_id,
> +					 uint32_t inst,
> +					 unsigned int utimeout,
> +					 bool detect_only);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 4f48507418d2..037b75a64e66 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -153,6 +153,19 @@ void program_sh_mem_settings(struct device_queue_manager *dqm,
>   
>   static void kfd_hws_hang(struct device_queue_manager *dqm)
>   {
> +	struct device_process_node *cur;
> +	struct qcm_process_device *qpd;
> +	struct queue *q;
> +
> +	/* Mark all device queues as reset. */
> +	list_for_each_entry(cur, &dqm->queues, list) {
> +		qpd = cur->qpd;
> +		list_for_each_entry(q, &qpd->queues_list, list) {
> +			q->properties.is_reset = true;
> +			q->process->has_reset_queue = true;

Both seem to track the same information, but one does it per queue, the 
other does it per process. Why do you need to track this per queue at 
all? The only place where I see q->properties->is_reset used is in 
update_queue. I think you can use the per-process tracking there.

That said, I think it would be better to track has_reset_queue in the 
pdd or qpd because GPU resets are per GPU, and these fields are accessed 
under the per-GPU DQM lock and reset events sent to user mode are per 
GPU as well.


> +		}
> +	}
> +
>   	/*
>   	 * Issue a GPU reset if HWS is unresponsive
>   	 */
> @@ -880,6 +893,12 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
>   		else if (prev_active)
>   			retval = remove_queue_mes(dqm, q, &pdd->qpd);
>   
> +		/* queue is reset so inaccessable  */
> +		if (q->properties.is_reset) {

You could use pdd->process->has_reset_queue (or pdd->has_reset_queue) 
here and get rid of is_reset.


> +			retval = -EACCES;
> +			goto out_unlock;
> +		}
> +
>   		if (retval) {
>   			dev_err(dev, "unmap queue failed\n");
>   			goto out_unlock;
> @@ -1629,7 +1648,7 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
>   static int start_cpsch(struct device_queue_manager *dqm)
>   {
>   	struct device *dev = dqm->dev->adev->dev;
> -	int retval;
> +	int retval, num_hw_queue_slots;
>   
>   	retval = 0;
>   
> @@ -1682,6 +1701,14 @@ static int start_cpsch(struct device_queue_manager *dqm)
>   					&dqm->wait_times);
>   	}
>   
> +	/* setup per-queue reset detection buffer  */
> +	num_hw_queue_slots =  dqm->dev->kfd->shared_resources.num_queue_per_pipe *
> +			      dqm->dev->kfd->shared_resources.num_pipe_per_mec *
> +			      NUM_XCC(dqm->dev->xcc_mask);
> +
> +	dqm->detect_hang_info_size = num_hw_queue_slots * sizeof(struct dqm_detect_hang_info);
> +	dqm->detect_hang_info = kzalloc(dqm->detect_hang_info_size, GFP_KERNEL);
> +
>   	dqm_unlock(dqm);
>   
>   	return 0;
> @@ -1715,6 +1742,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
>   	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
>   	if (!dqm->dev->kfd->shared_resources.enable_mes)
>   		pm_uninit(&dqm->packet_mgr);
> +	kfree(dqm->detect_hang_info);
>   	dqm_unlock(dqm);
>   
>   	return 0;
> @@ -1931,6 +1959,143 @@ static int map_queues_cpsch(struct device_queue_manager *dqm)
>   	return retval;
>   }
>   
> +static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
> +			       struct qcm_process_device *qpd)
> +{
> +	pr_err("queue id 0x%0x at pasid 0x%0x is reset\n",
> +	       q->properties.queue_id, q->process->pasid);
> +
> +	q->properties.is_reset = true;
> +	q->process->has_reset_queue = true;
> +	if (q->properties.is_active) {
> +		q->properties.is_active = false;
> +		decrement_queue_count(dqm, qpd, q);
> +	}
> +}
> +
> +static int detect_queue_hang(struct device_queue_manager *dqm)
> +{
> +	int i;
> +
> +	memset(dqm->detect_hang_info, 0, dqm->detect_hang_info_size);
> +
> +	for (i = 0; i < AMDGPU_MAX_QUEUES; ++i) {
> +		uint32_t mec, pipe, queue;
> +		int xcc_id;
> +
> +		mec = (i / dqm->dev->kfd->shared_resources.num_queue_per_pipe)
> +			/ dqm->dev->kfd->shared_resources.num_pipe_per_mec;
> +
> +		if (mec || !test_bit(i, dqm->dev->kfd->shared_resources.cp_queue_bitmap))
> +			continue;
> +
> +		amdgpu_queue_mask_bit_to_mec_queue(dqm->dev->adev, i, &mec, &pipe, &queue);
> +
> +		for_each_inst(xcc_id, dqm->dev->xcc_mask) {
> +			uint64_t queue_addr = dqm->dev->kfd2kgd->hqd_detect_and_reset(
> +						dqm->dev->adev, pipe, queue, xcc_id,
> +						0, true);
> +			struct dqm_detect_hang_info hang_info;
> +
> +			if (!queue_addr)
> +				continue;
> +
> +			hang_info.pipe_id = pipe;
> +			hang_info.queue_id = queue;
> +			hang_info.xcc_id = xcc_id;
> +			hang_info.queue_address = queue_addr;
> +
> +			dqm->detect_hang_info[dqm->detect_hang_count] = hang_info;
> +			dqm->detect_hang_count++;
> +		}
> +	}
> +
> +	return dqm->detect_hang_count;
> +}
> +
> +static struct queue *find_queue_by_address(struct device_queue_manager *dqm, uint64_t queue_address)
> +{
> +	struct device_process_node *cur;
> +	struct qcm_process_device *qpd;
> +	struct queue *q;
> +
> +	list_for_each_entry(cur, &dqm->queues, list) {
> +		qpd = cur->qpd;
> +		list_for_each_entry(q, &qpd->queues_list, list) {
> +			if (queue_address == q->properties.queue_address)
> +				return q;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +/* only for compute queue */
> +static int reset_queues_cpsch(struct device_queue_manager *dqm, uint16_t pasid)
> +{
> +	int retval = 0, reset_count = 0, i;
> +
> +	if (pasid) {
> +		dqm_lock(dqm);
> +
> +		retval = unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_BY_PASID,
> +					    pasid, USE_DEFAULT_GRACE_PERIOD, true);
> +
> +		dqm_unlock(dqm);
> +		return retval;
> +	}
> +
> +	if (!dqm->detect_hang_info || dqm->is_hws_hang)
> +		return -EIO;
> +
> +	/* assume dqm locked. */

This is weird, the same function does different things and has different 
assumptions about its locking context depending where it's called from. 
Maybe keep the original function and and make this a new function with a 
distinct name.


> +	if (!detect_queue_hang(dqm))
> +		return -ENOTRECOVERABLE;
> +
> +	for (i = 0; i < dqm->detect_hang_count; i++) {
> +		struct dqm_detect_hang_info hang_info = dqm->detect_hang_info[i];
> +		struct queue *q = find_queue_by_address(dqm, hang_info.queue_address);
> +		struct kfd_process_device *pdd;
> +		uint64_t queue_addr = 0;
> +		int pipe = hang_info.pipe_id;
> +		int queue = hang_info.queue_id;
> +		int xcc_id = hang_info.xcc_id;

Why do you need these local variables. hang_info is already a local 
variable. Now you have two copies of this on your stack.

Regards,
   Felix


> +
> +		if (!q) {
> +			retval = -ENOTRECOVERABLE;
> +			goto reset_fail;
> +		}
> +
> +		pdd = kfd_get_process_device_data(dqm->dev, q->process);
> +		if (!pdd) {
> +			retval = -ENOTRECOVERABLE;
> +			goto reset_fail;
> +		}
> +
> +		queue_addr = dqm->dev->kfd2kgd->hqd_detect_and_reset(
> +				dqm->dev->adev, pipe, queue, xcc_id,
> +				KFD_UNMAP_LATENCY_MS, false);
> +
> +		if (queue_addr != q->properties.queue_address) {
> +			retval = -ENOTRECOVERABLE;
> +			goto reset_fail;
> +		}
> +
> +		set_queue_as_reset(dqm, q, &pdd->qpd);
> +		reset_count++;
> +	}
> +
> +	if (reset_count == dqm->detect_hang_count)
> +		kfd_signal_reset_event(dqm->dev);
> +	else
> +		retval = -ENOTRECOVERABLE;
> +
> +reset_fail:
> +	dqm->detect_hang_count = 0;
> +
> +	return retval;
> +}
> +
>   /* dqm->lock mutex has to be locked before calling this function */
>   static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   				enum kfd_unmap_queues_filter filter,
> @@ -1981,11 +2146,14 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   	 */
>   	mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
>   	if (mqd_mgr->check_preemption_failed(mqd_mgr, dqm->packet_mgr.priv_queue->queue->mqd)) {
> -		while (halt_if_hws_hang)
> -			schedule();
> -		kfd_hws_hang(dqm);
> -		retval = -ETIME;
> -		goto out;
> +		if (reset_queues_cpsch(dqm, 0)) {
> +			while (halt_if_hws_hang)
> +				schedule();
> +			dqm->is_hws_hang = true;
> +			kfd_hws_hang(dqm);
> +			retval = -ETIME;
> +			goto out;
> +		}
>   	}
>   
>   	/* We need to reset the grace period value for this device */
> @@ -2003,21 +2171,6 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   	return retval;
>   }
>   
> -/* only for compute queue */
> -static int reset_queues_cpsch(struct device_queue_manager *dqm,
> -			uint16_t pasid)
> -{
> -	int retval;
> -
> -	dqm_lock(dqm);
> -
> -	retval = unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_BY_PASID,
> -			pasid, USE_DEFAULT_GRACE_PERIOD, true);
> -
> -	dqm_unlock(dqm);
> -	return retval;
> -}
> -
>   /* dqm->lock mutex has to be locked before calling this function */
>   static int execute_queues_cpsch(struct device_queue_manager *dqm,
>   				enum kfd_unmap_queues_filter filter,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 3b9b8eabaacc..dfb36a246637 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -210,6 +210,13 @@ struct device_queue_manager_asic_ops {
>   				 struct kfd_node *dev);
>   };
>   
> +struct dqm_detect_hang_info {
> +	int pipe_id;
> +	int queue_id;
> +	int xcc_id;
> +	uint64_t queue_address;
> +};
> +
>   /**
>    * struct device_queue_manager
>    *
> @@ -264,6 +271,11 @@ struct device_queue_manager {
>   	uint32_t		wait_times;
>   
>   	wait_queue_head_t	destroy_wait;
> +
> +	/* for per-queue reset support */
> +	struct dqm_detect_hang_info *detect_hang_info;
> +	size_t detect_hang_info_size;
> +	int detect_hang_count;
>   };
>   
>   void device_queue_manager_init_cik(
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 9b33d9d2c9ad..30a55d3733e8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -31,6 +31,7 @@
>   #include <linux/memory.h>
>   #include "kfd_priv.h"
>   #include "kfd_events.h"
> +#include "kfd_device_queue_manager.h"
>   #include <linux/device.h>
>   
>   /*
> @@ -1250,6 +1251,20 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>   			continue;
>   		}
>   
> +		if (dev->dqm->detect_hang_count && !p->has_reset_queue)
> +			continue;
> +
> +		if (dev->dqm->detect_hang_count) {
> +			struct amdgpu_task_info *ti;
> +
> +			ti = amdgpu_vm_get_task_info_pasid(dev->adev, p->pasid);
> +			if (ti) {
> +				DRM_ERROR("Process info: process %s tid %d thread %s pid %d\n",
> +				ti->process_name, ti->tgid, ti->task_name, ti->pid);
> +				amdgpu_vm_put_task_info(ti);
> +			}
> +		}
> +
>   		rcu_read_lock();
>   
>   		id = KFD_FIRST_NONSIGNAL_EVENT_ID;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 66c73825c0a0..84e8ea3a8a0c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -321,8 +321,11 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>   static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
>   {
>   	struct v9_mqd *m = (struct v9_mqd *)mqd;
> +	uint32_t doorbell_id = m->queue_doorbell_id0;
>   
> -	return kfd_check_hiq_mqd_doorbell_id(mm->dev, m->queue_doorbell_id0, 0);
> +	m->queue_doorbell_id0 = 0;
> +
> +	return kfd_check_hiq_mqd_doorbell_id(mm->dev, doorbell_id, 0);
>   }
>   
>   static int get_wave_state(struct mqd_manager *mm, void *mqd,
> @@ -624,6 +627,7 @@ static bool check_preemption_failed_v9_4_3(struct mqd_manager *mm, void *mqd)
>   		m = get_mqd(mqd + hiq_mqd_size * inst);
>   		ret |= kfd_check_hiq_mqd_doorbell_id(mm->dev,
>   					m->queue_doorbell_id0, inst);
> +		m->queue_doorbell_id0 = 0;
>   		++inst;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 2b3ec92981e8..e244242fd1b4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -504,6 +504,7 @@ struct queue_properties {
>   	bool is_being_destroyed;
>   	bool is_active;
>   	bool is_gws;
> +	bool is_reset;
>   	uint32_t pm4_target_xcc;
>   	bool is_dbg_wa;
>   	bool is_user_cu_masked;
> @@ -982,6 +983,9 @@ struct kfd_process {
>   	struct semaphore runtime_enable_sema;
>   	bool is_runtime_retry;
>   	struct kfd_runtime_info runtime_info;
> +
> +	/* Tracks queue reset status */
> +	bool has_reset_queue;
>   };
>   
>   #define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 17e42161b015..9a1d69f83a08 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1851,6 +1851,8 @@ int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
>   			goto fail;
>   		}
>   		n_evicted++;
> +
> +		pdd->dev->dqm->is_hws_hang = false;
>   	}
>   
>   	return r;
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index 6d094cf3587d..20bb4a0c893e 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -318,6 +318,10 @@ struct kfd2kgd_calls {
>   	void (*program_trap_handler_settings)(struct amdgpu_device *adev,
>   			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
>   			uint32_t inst);
> +	uint64_t (*hqd_detect_and_reset)(struct amdgpu_device *adev,
> +					 uint32_t pipe_id, uint32_t queue_id,
> +					 uint32_t inst, unsigned int utimeout,
> +					 bool detect_only);
>   };
>   
>   #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
