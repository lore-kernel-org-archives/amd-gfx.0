Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357A9C369D3
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 07:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD65310E89F;
	Fri, 25 Apr 2025 07:21:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R8XrAawC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8280410E89F
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 07:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATN2ROAI5+5zyce0KyvBE+r+jhaD3RpQOL8gCP0rxAj4p6uNC3syoiYFcZ6nYtm2mV0oI6qc3vtTRuqTRyYF6Xc2x2M/JDIV1rPuLegImgG3Zgu8ACAsVexhuTiaBN+RQuuQexquOtxme6UPhHRZuPRcOWJZ8oMhiDx4tDIwilzAWBzTuOu6TVJvg//HxU8tXy2soGLYS/7UVqRr5v5JPqtriBUI2bYSQ6/VqiZ27JBNmQDzpRjNHR5SIBbC5JJLSNiS2+ODoCZbgulyO4zbhtIJtR3Oinlr/HuZjdTcOJ/R/xU3MF1ukC7NVGu4yyM2agOXgylK30Q0bA8RLKKpZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8rmupeM0Oy48xxiJ/szQyFkcdJURSfxOsCNkTNmc10=;
 b=rdEEN+T2cA+1eWZ7Mq0FUakdZT43TLQCqdqZbdo4PbmdFRQu1x4MI+yfjg9i8YzdK8QI034uK2oNzlZNl3eWVopakvaUzh7cmwkz0qtR9U/Vp8qhi9zo45UBSfcyF/I5WsbKmDXHlWAx+bS7lMdihVGsICtYUG0qxAtwoS1penf1/eiEr2xx6A5WH5JtPIBy9i8lLrWWNzdBFLUUP/IoJM+56TLmcED/6RefldEM5G2crzqkvj8tXpNt8D5VYgOykG+3T6cUV6ASk67ZwIyR80J8TP7Bluli0X2MpL4Hvp7Z+hMn6ubLicK3yOW6By/LFiLFXBu+4thgcNOfV7CQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8rmupeM0Oy48xxiJ/szQyFkcdJURSfxOsCNkTNmc10=;
 b=R8XrAawC08I1QqUiEcao+iYEl/UJ7n96+KIiULIvFsMz3WLhUMc2JbbUNgWeaUUrtLILiQCD5mLa0e1VSXdtZt6Asf2XKbBYkh/icwMTcgmmdxmkzmWpQdi9D6kSm/3wtDcltGO2HRmQ6aybl67MpawbSnjQ8GrSTofRlZPoaSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 07:21:11 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8632.025; Fri, 25 Apr 2025
 07:21:10 +0000
Subject: Re: [PATCH 1/3] drm/amdgpu: implicitly sync the dependent read fences
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com
References: <20250425070730.4033803-1-Prike.Liang@amd.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <b7011f0d-cdda-9318-ddd7-6c36f6581ad9@amd.com>
Date: Fri, 25 Apr 2025 12:51:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20250425070730.4033803-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PN4P287CA0043.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::6) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e5fef3-b08d-4ee3-8366-08dd83c9c0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yi9CUVR1NnZZM3JYV3RtOVA4SS94NVozc0YzNFJZUlY1MEtMUG9DYnoxRWZs?=
 =?utf-8?B?eWhWeUN0VStXa0JLblF3ZWUzdGc2VFA1L2xrUjhRVGlzNTk0WEdFT052ckpa?=
 =?utf-8?B?cUE3d0xENFp6dlI3YzdCN21iSFVQWkhWRnFaQUhCS1A3YWZEUHNjaEZ0Y3o1?=
 =?utf-8?B?c0JmZDl3MlFZOHRZUVpjTUhvSFovZXlWbkgwRUcxdnVWWnRZRGF4alRiWitP?=
 =?utf-8?B?ZjJEaURqc1R1OW8vbHc0WWFVMnVUcGhiY09rR1VVZDdHa0ZpTVczYjRNa2x0?=
 =?utf-8?B?U1BDMEs3M1hlVERIUUo4OFh3YWZMbG15ay9uUHZtN2JVbUI5d0ZaM1o4VmJl?=
 =?utf-8?B?RFNzeitTS2lKOWg3eUNCcnU0cHJsZWl6TGZnbGtnbzJZYUx2MS9LVFlZRHMw?=
 =?utf-8?B?QTR6VFlBYnc4VkxZUUF1ZFBCTENsS3UzTUNBa2hyV1lGUTAzRDFjNSsvT0di?=
 =?utf-8?B?alNjZWtUdHg4N1VKbFc4OWkrWTJRdFlWYXEvRWxENFJxam5oaks0UjUxQS9P?=
 =?utf-8?B?U0FmNnhVdWxzMFZKN1U5c3hrUlZzVmFaMzJ5RmVlQkh5Qmd1bWpzYTM5NVZM?=
 =?utf-8?B?ZHhHemt1ZGozNFdoVzlKLzJaMEI4T0RrZ2ZuR0xoK3RyV1FvZXpnN0xzbGtH?=
 =?utf-8?B?cTAvRjJ4d1ZoUzB6SW11YVRiOUxFMDRTSDNHM2NMdzJxU3RKajYvcS9Ma28y?=
 =?utf-8?B?ZlphRGsxcFUwYXprMk5ZbGlyVnl6bTdES0Jia3htT1RvdTRHSS9LRnpCalVi?=
 =?utf-8?B?MzkzT0p5SXBvc1VPOFlzTlZkZ1BXejh6YlZVSGE0TERycWNXNVJGOWFDQWRo?=
 =?utf-8?B?RDlCMXFWV2RRY2d2RFliR2duMjhIbEZUaWJOZ2ZoWXg4NEdaUzM5LzM0R3Bx?=
 =?utf-8?B?MjlHMm1IUzkySkxDcnJmQUpiRnlKbXE2bnVKS0dxNkQybjdlcldhRUMvcFh0?=
 =?utf-8?B?Tkh2NmNZM1loYlBEeS9VREtybHBEQjlqTmZNVnA2Q004NWhDYXFtaEJzSjZO?=
 =?utf-8?B?ZFBBK1lFN1F0N3hYcHRQUEE1QXFudlphNndvd0JOQTRGRXFxSGU3MXVSOE5s?=
 =?utf-8?B?TFdWQjk1Mmx2V1Q4Sk84ZGlBRFJncjR5K0VXL1l6amdQeStaTjRQTFBZTkx6?=
 =?utf-8?B?ajl3aTFUVEJSR1NHNEtnTEh4WkxVN0U1Tmg1UlpOVGppWXBjRkREV3M1K0dI?=
 =?utf-8?B?WnNzWnM2TncrT1hVNWZBWmRXdmhSSmpIZ3BTQzZlakgwNGNLWDFmQUd2RTM1?=
 =?utf-8?B?OGo3Z25nYWxuZDc0SHB1Yis3MU9JT2szSTIxY2R5M2FEK2d1RnpIaVplbzMz?=
 =?utf-8?B?OTMzSURGK1IyS0hPd0hMOVR4UU5iZUxkb0RFYWJxRmlpWVA1bWkzbSs3cUkx?=
 =?utf-8?B?bDdjajh5NFpyYy9ST0JKRDBKNTJIbm5FcmdqUWVWV0l4d1pVOWN1K1JEZ0xN?=
 =?utf-8?B?STgzcHNrZkQ0L08yWjY0U1RtTUFpTGdHVXhmZXZ0NFdQU0dOU05LcEtPTlly?=
 =?utf-8?B?WVdFOHh0RExzLytyRHlKRGE5ZGx2bWhOK2ZycHNQQWdHL1lVcHk1NG5GNkps?=
 =?utf-8?B?STVLTWxQazJWdjhSZk5hbXRSck9xR2RZOGttczhWUUJTOUM3dXpSOERIbFVK?=
 =?utf-8?B?anpsR2hPYUltRnhva2J4RzMxdnBtZHpGUkEraWVIYW9DdlJIRTN1eWdwVVFn?=
 =?utf-8?B?NUQ4bE01aXZQTGpnTnR5QlBNQi9pVFVUTXZnd2tITkJ5OWtFcE0vV2JnZ2pm?=
 =?utf-8?B?RUFYY2lIUjdNU21zRE1lamR6d2VUZ25ZbmNqdlQ1M3N1RXRrQkNVVHRtNjVv?=
 =?utf-8?B?aFpjQkwwNXRDcWhVb3NWOTNxYWwrblpGZmdDOUFVSEhMcGMxZmtLdCtTcVNZ?=
 =?utf-8?B?NnJlNTYzRmJCRDZwMU9ESHZnU2t5Mkh5ZWU0Y2ZjR0VPVWhVNmZFeC9qMFpE?=
 =?utf-8?Q?Zs8w+7yP5OE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHRSdzRRa3NzT0t1NVM1YVRXdlJYNUwzVnhaa0RRV1dBZmxDODF3bS9hSk9Q?=
 =?utf-8?B?akZ6blZJU3ZjM0lCVU1EL0FPNW5lNm5sbmZhZnVwcFNSdDluTjhsYXlRbHBk?=
 =?utf-8?B?WUwzYWhhVFJLZTlhQ1J0TjF4T1dCUTlieHQ5cWxKMWw0eXArVmVEdlIwWWVK?=
 =?utf-8?B?V0dXSkw3SWpKM2N2dURiYXg0ajIxd3AxT0l5cGppMGdUcTdoREV0cUNvQzIx?=
 =?utf-8?B?WXFZWnpaNlFvSTgxNVZXSTc4Ui9DZDBwYm9vdnFHd3lUdXVuTHV6VTBtTHdU?=
 =?utf-8?B?cHlRK3htcSs3ZlptMkE3bWYraWRvKzJ2c25zQnk0WTNoRlFyTUgxRlhFbGdt?=
 =?utf-8?B?aW5reHJmNWIxQkxuMUNXU3ZMRVo0c1hUUU5naHJmTlY1ckJwcmRmbXJKajhH?=
 =?utf-8?B?c1FWS0MyR2Y5T0ZNMVhCT3FTQlJ3U2pkanY3VVZlTHlBQlBPLzRZQjZKT2Uz?=
 =?utf-8?B?WGdwRnVJOWRHcThPaUFYQkluM3NpTGZwcFIvakk0cnlDZE4xWkUxZkFnNURE?=
 =?utf-8?B?QVVrRlhEeXlFRFB4bGdMYzA0OWVxdDBlMHhCOEl2U2k2MnFVYWN4TCsrV3Vy?=
 =?utf-8?B?MDN4TUZ2MWsrdVBuaXBXRkhSZFJ5TWJIdEFNeEg5MldsNHM0ZmVsOU1NMFBM?=
 =?utf-8?B?cFltVDVTNE03dDVrb2gwUm9aZDNKUVFDRFpMVURyajZUOHJMWGJJVmdVQTZN?=
 =?utf-8?B?Z3dmSkxRVWJ3V1dTU3g2WlVNNW9UenR3UG4xeUx3WkVXb0hsSFo3aHZOcE83?=
 =?utf-8?B?L2FzVjV5QWpEUmNPZ3JlbmozU011T2FPS0Z3ZlcrR2ppeDVrM0VnaXFUU0Qz?=
 =?utf-8?B?aVVuaFRJOXZNYlJ5eDZDMkl5MGZyeXZMajFDWHpHRnU3UGtieFgxSDVhMEtQ?=
 =?utf-8?B?SjJNbzQ2YkZBa3JsdjIwZ1NlZVRTcVByMW51dGtEOFF0QkYrdUlNdG56N3B3?=
 =?utf-8?B?bHFGbUhBYnBINTNsZ3ZCek82aDZzeHZHcVV4VGlYdHcwZ24yY0lMd1JXQzQ4?=
 =?utf-8?B?RFVqT2I3MGFySmFLc3FhMUt5aWFnUGYzVVlXM2xkSTkwZVZyVFRhcnFCVTVm?=
 =?utf-8?B?L2dzaEI5TXBCYmVyMFdXODFhTTg0TEpIQzJ0eHBabmQwSzBGMTk3OE9Yajh5?=
 =?utf-8?B?aS93blFRUEdBMEpZKzRkTWxsZUcvWSt1Z1NoeXF4M1dFL3NFMTJUMzFEN3Iw?=
 =?utf-8?B?M2VDZnZxcHlBSUVXdlhFTGVmOWVsUm93OHdYQnpTMXVPajdhaTFRR0R3SDRq?=
 =?utf-8?B?SDArN3F2dldyQVMvZHpWeG0ydW1kYjg1Z2hZRVFDaURWYnlNOWg0UjBqUHJj?=
 =?utf-8?B?Z01XazJDdzN6MDV6UGI2QkkzQ1pMbitkeDJYMTcvK3BjbzRZMmpKRDZIenVZ?=
 =?utf-8?B?WVgvYkhEQTFnQkVJM3RpcXYwSGN2c0pmcDlwaGFJcjZQdEJtMEEvMVVhZWMr?=
 =?utf-8?B?dUNGQmpFYVRKbU53N0JrdHVQRk1pS0hWbGM4dG5UdTBqZ3RzN2F5RnY5Y2ZW?=
 =?utf-8?B?RXYwVjN4M0FXZU5kUTVJb0hkcUZBL0JpdWp1NGNxdVY1Z1BhMTQyVW5sSml1?=
 =?utf-8?B?NFVYcGJtd0ZEdnhvMVR4NlZyOUFaYTBHRU1Ua3hLc0NmOG81VkNsM2ZBK0Mv?=
 =?utf-8?B?Uk9aazVveFlYYTJ4RUsxRGpmNUhCcWRtN3UvTkpLK0xzelVCTW5JZ2VpUERG?=
 =?utf-8?B?Y3dSQ1F2NU8vRmlwbWVYcFhyZ25IZ2IrbmVCZzBKeHJzbWtGZkhibzdpQ2Vn?=
 =?utf-8?B?b2RrM2J5eG5CQXJ5V2U0QVZFYU5EOXhRYThTZWo1MmZLNmdlVDg0UmMramZu?=
 =?utf-8?B?UVR2YU9ZNEU1Ylo4TWZrWlpXTnJLNXBqbHVLQjVYTmxHTk95c2w0cVZmeC9Z?=
 =?utf-8?B?NEdvNUhDelZrK1g2Q3FZQUlZSmdNRloybVpCTTkreU8xV09yNXkyODFqdGVM?=
 =?utf-8?B?QnZwSnduMDJPSy9EbVJVTUpSL0REbkVhcXhTSTBITk5nTFhoenk2OWFqZlZU?=
 =?utf-8?B?R2lSNnlrNFNlR2hnQWpTTEpGNFh2OHdkeVg0NmUzb2ZYZnRNT2JmK2hDSmZi?=
 =?utf-8?B?SzNVRGFsb0puclBVNG02T0dyS2V0Sk92QStyZHgzRE9QOFh4aEdvUE4vdU1z?=
 =?utf-8?Q?UYMgTPSVrk5Uxkt0fhJQZseCY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e5fef3-b08d-4ee3-8366-08dd83c9c0ea
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 07:21:10.7535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4gshzY88UV875S6cQTh2hilc//ofvn4j+y0YFocoQZHZRZTZqU8IthGBOmqSEXozPvrDzVr/f+4//Fk4nCGJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260
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

This is problem for TLB flush. We should not do this changes. Here we 
are utilizing DMA_RESV_USAGE_BOOKKEEP due to the TLB flush fence 
associated with the page table (PT). We are ensuring that no page 
directory (PD) or page table (PT) should be free before flush and ttm bo 
release and delete both are also waiting for BOOKKEEP fence. Please drop 
this changes for eviction fence.

Regards,
~arvind

On 4/25/2025 12:37 PM, Prike Liang wrote:
> The driver doesn't want to sync on the DMA_RESV_USAGE_BOOKKEEP
> usage fences, so here only return and sync the dependent read
> fences.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> index 5576ed0b508f..4e1d30ecb6cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -249,9 +249,8 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
>   
>   	if (resv == NULL)
>   		return -EINVAL;
> -
> -	/* TODO: Use DMA_RESV_USAGE_READ here */
> -	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP, f) {
> +	/*Only return and sync the fences of usage <= DMA_RESV_USAGE_READ.*/
> +	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_READ, f) {
>   		dma_fence_chain_for_each(f, f) {
>   			struct dma_fence *tmp = dma_fence_chain_contained(f);
>   
