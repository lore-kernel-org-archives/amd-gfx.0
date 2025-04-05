Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1571EC36010
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Apr 2025 07:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9233210E2AB;
	Sat,  5 Apr 2025 07:32:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pt9TLlbR";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B1310E0C9
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Apr 2025 07:32:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCvZC1mpte+5lPlCmTxJv3t5316Raq2DGjGX/IJt/ZNFd8yc53T8dkXfkmvWfjJVp31+XUl2jxEqJiKM2xZIUA+rmmylJqTXv4Y7K8DuOc3GuYgRi2TmvvVyciq25jL428ahbtFkaVjLDkTSYrwuvWTi7vAVSTrLYPAUqQVAIiC0q7/Ac2/V1E/m4xRBI4MW5XH4zFbM2d3fR8s9oQb31guU86Ks+kE9sIcKku4lpNNAvFMfE0uVG0TkcqYUEwEzGrQ/US5/aoXKuCSvUtKuejM/qoxethhk9Y+971WFfBrKz3oQ8xv8DUIn9c/Ouu2aoil1NA8hlz9R/Bb7SqpXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhIiy1GWfE0mEIhIjM9pJEmeAbrot9BxmiRZkC7yT+I=;
 b=Lf8wy/SHX9zb88I9mh+A2+XMr4Xim59f2EgV1sI9kLFFeryf+Da0g3Km0eNPq5AybsoadDPBUUz8YZGdXovI9qc1iKwnkOfrrPMMPhru/Z7NS0T64fsqwVypQU0Qe5mZZUh6KTLCSyPG8FHOlHHOgimyxGfsp/OiQNLgH+BWKst/96/YniAusmeW2maDhqq7Y+E6UqNft+7oC7a1v+GSDbiiFkwRN7sBMU/nhRMPiLAm4rX6hgedQk6f/rn74y6EC2uOhKAzQJalQ/pkf7Y/dOT2tbqgXOc/eLR1MWKZzO05a/hPDOZ9C1oCAEtWagvqY0KQa0P3OKO52F8X182mbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhIiy1GWfE0mEIhIjM9pJEmeAbrot9BxmiRZkC7yT+I=;
 b=Pt9TLlbR29Yb25BIDKsJeLVFs/7D0ki01ntDEMdvvDcFjlkAWPZzT2+hWx/poa7h1MzmryTRnhSraMncDaEYRAMoAsZxLQwTw8brp6lpJEEsikJaBSpl1tdrDGpgdC59A1mPRvnH21WkqIXjKmgFZfLwHEQZ1zpO6wbGkOKqMKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by IA0PR12MB7628.namprd12.prod.outlook.com (2603:10b6:208:436::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Sat, 5 Apr
 2025 07:32:54 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8534.045; Sat, 5 Apr 2025
 07:32:54 +0000
Message-ID: <5e33847e-de9a-4635-98cb-dbec36653042@amd.com>
Date: Sat, 5 Apr 2025 13:02:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: cleanup amdgpu_vm_flush v3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250404141607.1451-1-christian.koenig@amd.com>
 <20250404141607.1451-2-christian.koenig@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20250404141607.1451-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::7) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|IA0PR12MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e33b9e-1910-4333-e8e2-08dd74141399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzdsMk41NDZKTjVkUFdvbXgyRVJYaGE5RWc3NEJuQmgrWVJCK1VnSVo1Syty?=
 =?utf-8?B?cG81OUIxNUc1UENHWlA4NVhaRVNnTEpJVGUxRk5Oa281RjBZQ2EydEtVc1hi?=
 =?utf-8?B?enluOGNud2dBNHdYNW1mdzlyNlFVUEEyTnV6M0VXVlFIN0g0TS8yZWVJR3px?=
 =?utf-8?B?OEZ1cTN4eWJZRkVwRzM2clpnbUJqaDA3dWhhMWN2NG0yRjZOWHpOemlkL1Iw?=
 =?utf-8?B?L2I0K2x2YnBEdEJjS2NFZ1RHY21EOXZ0YXROWWRySkVZKy9wd0krY3l6ekFz?=
 =?utf-8?B?MTA3T3hQc0JnbmE5VkFmZHVVT1A4cndOZ2hoWThqNEFGbkxnSXFpbUc5bG1o?=
 =?utf-8?B?aVd0NUFNOWk0cG9LME9CSGptbEVZcHpIV1hNR05Md0VFM0lsa25vZFZNVFFo?=
 =?utf-8?B?SkhKTnVsMk5OM0RTOEJDdjd3Yk1yVHpjWGFRKzNjS2taQkVKOGhNMUk5cjIr?=
 =?utf-8?B?N2xzaHcxRFM3SkZkNFF6OGlHQWFHRnVoZ2tEQUwxTy84OTRFeThYN212d3kw?=
 =?utf-8?B?UUhKQWhMNnlRNzhrcjBMUmJoVUN0REhROXFtQWZQdW4zV0srV25wQk1rVEVC?=
 =?utf-8?B?eHF4N0crcnFScmJxMHdNQkwxTjlTMVZzVXNFb3lYTE9sTXFFakZ6SjIxcEJB?=
 =?utf-8?B?WnoyZmZSRGNBRm95MGErMTdTYlhvNDFVM3RCeHpiZlNHZ0hVRmFLY1VpOXlQ?=
 =?utf-8?B?ZDgxb1RjRTBWS3BBd2JmYWhGaE55YkdLNGwxNFR1SjhOZVJuTWRvZ3FrRXdO?=
 =?utf-8?B?ZlVrWVAwejNlY1VDYVBiZGRmS2djVnYvSmkyYSs1K1M1cWJKMkkxYnBNeGN6?=
 =?utf-8?B?eUdtRXlGTzBhaGdYamJXUFBjU1JJdzhhOXJTVllIZFh0YUtZYzhJMXlCem8w?=
 =?utf-8?B?N21pakNpM1p6Sm1sWlZDdzVrSHRybkcwYlZkdkRFWlc5NEljT2FhUnpwZHF1?=
 =?utf-8?B?TXBjR3ZWOUlVUFZxcDlMbFRNSDhZZTVKb2dIdVQwVVB3UTRmd2g0ZTdQQXF1?=
 =?utf-8?B?UGNHOFYrbDlHQk05dWVKdEh0OEFKTkhueXM3bXRKSW5vRzlHbmRjd00welpO?=
 =?utf-8?B?dDZzWGIwRjdoYnczdEt4ZkZGQTlIMXlDU2tDa09PUVlEcmRYRkdMT1VjMDhw?=
 =?utf-8?B?WGdZZVE2QjUrZnM4R2pWUWJZYm4vM3ZNV2J4QU80UGZPSFc3WDJXbm1QbU1n?=
 =?utf-8?B?RTEwVE0zZzJFeXVMcjRaZW1wL09KamEzV0NRZGw0Zm9UWHVtbmxNdFBHa3Ez?=
 =?utf-8?B?dUk1OTZlbnJWSlR6K1FLcFVyQWFlTlRuRTJvK0IvbEd3TWZDRUdyQVdvKzFm?=
 =?utf-8?B?MVNnb3FQTTBjei9CbnpTT09obWxhZHVYL3RTTkxlOWx5SWpqcHYxOTUyK29h?=
 =?utf-8?B?T2VQQjhzUWNrQndic2NyT1NYMm1KUWd6MHZZc1VyVHJmRFVjVmhCVkY3VCsy?=
 =?utf-8?B?aVRsZWdsN1o2TjRsMmZUTEZRK1JOdG5JK0JHSmt2OWg3L2RCTW9UWmJhTWNs?=
 =?utf-8?B?cVFpbFZDTWRMM2F3ZXUxNmJ0Yk4xWTJOV25vTUhlYzJIckhCY1JnSVVSNU53?=
 =?utf-8?B?T3JxWWtHVncwWjI4ZjV5TmM3czNTcVN3Y0xNcngxckQ4ZXIzejJFWXlUN2Nh?=
 =?utf-8?B?a3ZHbmZ6bGlhWG5NN3ZkMnVVU29qU08wZERuWDJQbU1USmdFeHdSdjRpVENp?=
 =?utf-8?B?b2JnaUFyV1dRcGtlYmVtZzBNZktzRmFwT2VVYlIwaGNycWdnNXZyN3RNZHJ4?=
 =?utf-8?B?ZFRlWFdSS2lEZmRWT04yQkNYSHJIOWQ0YUtEQkxFc2ROWHJlTzZ2TnFyVEZE?=
 =?utf-8?B?bmxqd29LdlNaeDlwNEdveTJtZE4zdHNPaTJDM0pjUXhWdVg0MmJYOW9kVkpJ?=
 =?utf-8?B?OGdCRUZmWjNDb2FzdS9MZ2dRRHE4RllHZC91UVpJS3Q0a2p2dk16R2lYNS9B?=
 =?utf-8?Q?rNqqa2ckKW0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVMxTjBEVUg1Kzk4S1VGTDRjNitIc2R2dVI3REhJWE5Zbit4Y0FjWjJYUm15?=
 =?utf-8?B?cWhBd0pMVDBJNEh5RlJ2bVRYYU5MUnR5VFdMZVVDRVF4Zkc2WUJFUEd2K1d3?=
 =?utf-8?B?bTZmQnhFZ0tHS0N0VWdSSEVRRHdjRU9GaCtOSnE3eFhwcS9hNzdEUGhOUi9s?=
 =?utf-8?B?eUdXZ0I0SzQ3RjNDczBaQ0lWcDdGNXdaaktta25jN201ZEZMRG84anJDOFpJ?=
 =?utf-8?B?dVd2OTVaRHlGTzltc3lxU0g3Qm51cHNzMnFqUTRNQTlKb1NUUUFRWUx6emlw?=
 =?utf-8?B?WDdRdFpwWHJPSkVOaGRqNkJ3eUFxTWVxR1hFN2dPcmhya01MSldscVZOYkVm?=
 =?utf-8?B?N1JQQWFDUFlhdlFsZHFlc25VeWcwQk1OemhmUlF4WWp3ZTBERzVqaFlyZ3hi?=
 =?utf-8?B?ZDhEOUxocnZ3c1ZaeHFZeHFEVnJORFFwNXdKWitRMkdXQXNQN0hMYXhoZWxk?=
 =?utf-8?B?VFFFeFdrTTlvNDNSYjRZK0RGVjBKQzgyRDR5Njd5QVRFYjl4S2I5TVhJM25I?=
 =?utf-8?B?UWtPODlhamIramVnLy85RkpDYWxYU1Y3NDdrYUFaQ3NvakRDZkxjZVpaV0xv?=
 =?utf-8?B?ZnBhK2I1eFAwSitBaG1iS2Urdkh1MUdzajcwRFQ2Mk1aWTZWYTNPeGc5eTIz?=
 =?utf-8?B?KytlUDA3ekZ6MFdtaXRuR2crdnNSTUxPMjJTeUFibWRjYzNRVW9rUDNsSEd5?=
 =?utf-8?B?U2l3NE90QjM5SG42aXgvTXMza3kzWXk0N2Y1YnB0QkZsRXhvSTdlczJsTDA0?=
 =?utf-8?B?QU9wdUYzTWxQcmlYSVMzMkxGbG5IWk1Ca1B5STF4cFlYZHgwYUI4RzNlT3R2?=
 =?utf-8?B?bzlYTWo0ME1aQjI1ZTBXS3Rnb08vaGw3QWloV0hwRzh2RHVPQ3JsbkcrRk53?=
 =?utf-8?B?NDVvNmtrRWFWcEt5Q3FYNDE2Q0tTaFFUUXVadTk1ekF6K2s0Z09MR09mcnhF?=
 =?utf-8?B?OHNmQUdKM2FNaWx5c1FEMjcxY1h4b21YaTRaakxNYjZMdlJrN0FZUngyNVRS?=
 =?utf-8?B?THZ2eFhGd3ZyMDgvaDMraFoxTkJQUk9CNGZiZmdiR0xvVDF0bjJ3VlhKTlZM?=
 =?utf-8?B?K0RqMm5PRWR6aGxXYk1QR0RzNWgzekowajlubTRYYkM5b3lYUjZaMHhqT0ZG?=
 =?utf-8?B?QU45TTFHS294S0wzaW9LY0lIaVp1Ym1yWW5kTlRrVlpLN2tDZnNGN1hyaDUz?=
 =?utf-8?B?N2RqUHIrQ1liSjNnV3NuNVlPMEtMR1Vuc3U1ZjFOMUtZSDl0TTRxSkxqM3dp?=
 =?utf-8?B?eHliZlhnYmpDNGFCREU0TEhTaDdFY09WTTlhMlJKdVYzUXR4UW1oR2RyY1FM?=
 =?utf-8?B?L2VoMW40MllKUWplR3A4RVFxTDg2Wm1IRzhzSitxWjR6akhtRTgwUERGcVBM?=
 =?utf-8?B?dFA4dUdaMnMvVGxpU045R01ZN1lVYUFsTC9hc3I1UzdPQTAwaTdRUTVkWS9H?=
 =?utf-8?B?bE9KWVdVdjBsK3RUNERpSWhkbnNwNVpiQzNvd3lLcnF1TnlycFFNeHdDUXl6?=
 =?utf-8?B?aHRzZXVHWmNRUStLSjRlbkpWbUxjQnBiczhJc3EyMndsWkhiT2prcy8zTVZs?=
 =?utf-8?B?UXk3QUJaTXFnZDVYRkdrK3lBSE1Pd2NXUlkyalJWQjFXTFVKLzRFN2phVmN5?=
 =?utf-8?B?MXJ2UlQ0WVA3TllTdTR4UUZaTDZrV2w2dmU3WE5nME5aZXdrNWo1d29TL0Jw?=
 =?utf-8?B?aVZ1SHhIZ05oR2VWaWpGa3VuUzdKK0NtekFzRkNBRTc3TDVaWHRHZVZSbTJi?=
 =?utf-8?B?U2dheW0xeThLZmo2TXJ1dWZkTS85YURuS2ZLdVdDR0dpSURNemRDM29ScnUx?=
 =?utf-8?B?UzJFT2hyQW14ZXdIeENreU5FS1lzdFlOeUFXK1N1K1ZiMHVuZEdIdWwwRThk?=
 =?utf-8?B?dUJ0bjZicHZmUm8zdDZGbXFHdWRaNEt2eXBOT2VQRzNzcjBsSURpeGNjN1Qz?=
 =?utf-8?B?MlNrbk90cmpRVVJia2hTZjZRYkQ5REY3S2xVUEFJNUVGV01LVlA1TU9tRW5I?=
 =?utf-8?B?MExhWUh4S1RiZDh6M0JaRVUzb2VmOGF3MTUyQzV4cEZkZlkyK1orTVI3dmJz?=
 =?utf-8?B?S2dWSTcrb0o3bUM5cXIzNjg4OU9CU3NRY1lUbmk1WlZ1UmZ5QStrMDUySVcw?=
 =?utf-8?Q?uEl6gJIIuw3S+hZVjqNZrvWl4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e33b9e-1910-4333-e8e2-08dd74141399
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2025 07:32:54.0045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DU/T4EhRbVMxnv1WghTqwhrR/Pao0KpsmLh9MTJkHQqIn7HwBv8X7uhh9ltkuW2kaJ8zCwNopXcI7A27ClCXGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7628
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


On 4/4/2025 7:46 PM, Christian König wrote:
> This reverts commit c2cc3648ba517a6c270500b5447d5a1efdad5936. Turned out
> that this has some negative consequences for some workloads. Instead check
> if the cleaner shader should run directly.
>
> While at it remove amdgpu_vm_need_pipeline_sync(), we also check again
> if the VMID has seen a GPU reset since last use and the gds switch
> setiing can be handled more simply as well.
>
> Also remove some duplicate checks and re-order and document the code.
>
> v2: restructure the while function
> v3: fix logic error pointed out by Srini
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 92 +++++++++-----------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 +-
>   3 files changed, 36 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 802743efa3b3..ff2ca984279a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -191,8 +191,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   	need_ctx_switch = ring->current_ctx != fence_ctx;
>   	if (ring->funcs->emit_pipeline_sync && job &&
>   	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
> -	     need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
> -
> +	     (amdgpu_sriov_vf(adev) && need_ctx_switch))) {
>   		need_pipe_sync = true;
>   
>   		if (tmp)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b5ddfcbbc9fc..e6d7db8d40cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -596,37 +596,6 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev)
>   	}
>   }
>   
> -/**
> - * amdgpu_vm_need_pipeline_sync - Check if pipe sync is needed for job.
> - *
> - * @ring: ring on which the job will be submitted
> - * @job: job to submit
> - *
> - * Returns:
> - * True if sync is needed.
> - */
> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
> -				  struct amdgpu_job *job)
> -{
> -	struct amdgpu_device *adev = ring->adev;
> -	unsigned vmhub = ring->vm_hub;
> -	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
> -
> -	if (job->vmid == 0)
> -		return false;
> -
> -	if (job->vm_needs_flush || ring->has_compute_vm_bug)
> -		return true;
> -
> -	if (ring->funcs->emit_gds_switch && job->gds_switch_needed)
> -		return true;
> -
> -	if (amdgpu_vmid_had_gpu_reset(adev, &id_mgr->ids[job->vmid]))
> -		return true;
> -
> -	return false;
> -}
> -
>   /**
>    * amdgpu_vm_flush - hardware flush the vm
>    *
> @@ -647,29 +616,31 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	unsigned vmhub = ring->vm_hub;
>   	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>   	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
> -	bool spm_update_needed = job->spm_update_needed;
> -	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
> -		job->gds_switch_needed;
> -	bool vm_flush_needed = job->vm_needs_flush;
> -	bool cleaner_shader_needed = false;
> -	bool pasid_mapping_needed = false;
> -	struct dma_fence *fence = NULL;
> +	bool gds_switch_needed, vm_flush_needed, spm_update_needed,
> +	     cleaner_shader_needed, pasid_mapping_needed;
> +	struct dma_fence *fence;
>   	unsigned int patch;
>   	int r;
>   
> +	/* First of all figure out what needs to be done */
>   	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
> +		need_pipe_sync = true;
>   		gds_switch_needed = true;
>   		vm_flush_needed = true;
>   		pasid_mapping_needed = true;
>   		spm_update_needed = true;
> +	} else {
> +		need_pipe_sync |= ring->has_compute_vm_bug;
> +		gds_switch_needed = job->gds_switch_needed;


*[1]:* Should we need to check along with "ring->funcs->emit_gds_switch"
ie., "ring->funcs->emit_gds_switch && job->gds_switch_needed;" here?


> +		vm_flush_needed = job->vm_needs_flush;
> +		mutex_lock(&id_mgr->lock);
> +		if (id->pasid != job->pasid || !id->pasid_mapping ||
> +		    !dma_fence_is_signaled(id->pasid_mapping))
> +			pasid_mapping_needed = true;
> +		mutex_unlock(&id_mgr->lock);
> +		spm_update_needed = job->spm_update_needed;
>   	}
>   
> -	mutex_lock(&id_mgr->lock);
> -	if (id->pasid != job->pasid || !id->pasid_mapping ||
> -	    !dma_fence_is_signaled(id->pasid_mapping))
> -		pasid_mapping_needed = true;
> -	mutex_unlock(&id_mgr->lock);
> -
>   	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
>   	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
>   			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
> @@ -681,15 +652,17 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		&job->base.s_fence->scheduled == isolation->spearhead;
>   
>   	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
> -	    !cleaner_shader_needed)
> +	    !cleaner_shader_needed && !spm_update_needed)
>   		return 0;
>   
> +	/* Then aktually prepare the submission frame */


*[2]:* Could you pls correct the typo?


>   	amdgpu_ring_ib_begin(ring);
>   	if (ring->funcs->init_cond_exec)
>   		patch = amdgpu_ring_init_cond_exec(ring,
>   						   ring->cond_exe_gpu_addr);
>   
> -	if (need_pipe_sync)
> +	if (need_pipe_sync || vm_flush_needed || cleaner_shader_needed ||
> +	    gds_switch_needed)


*[3]:* Can we check even for *spm_update_needed* alongside the other 
conditions, that might need Pipeline Sync here?, Cz in an environment 
where multiple jobs might be accessing or modifying shared data 
(especially in gang submissions), ensuring that all operations 
(including SPM updates) are completed before executing further commands, 
to prevent using stale or invalid data.


>   		amdgpu_ring_emit_pipeline_sync(ring);
>   
>   	if (cleaner_shader_needed)
> @@ -706,20 +679,31 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
>   		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring, job->vmid);
>   
> -	if (ring->funcs->emit_gds_switch &&
> -	    gds_switch_needed) {
> +	if (gds_switch_needed)
>   		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>   					    job->gds_size, job->gws_base,
>   					    job->gws_size, job->oa_base,
>   					    job->oa_size);
> -	}
>   
>   	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
>   		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>   		if (r)
>   			return r;
> +	} else {
> +		fence = NULL;
> +	}
> +
> +	amdgpu_ring_patch_cond_exec(ring, patch);
> +
> +	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
> +	if (ring->funcs->emit_switch_buffer) {
> +		amdgpu_ring_emit_switch_buffer(ring);
> +		amdgpu_ring_emit_switch_buffer(ring);
>   	}
>   
> +	amdgpu_ring_ib_end(ring);
> +
> +	/* And finally remember what the ring has executed */
>   	if (vm_flush_needed) {
>   		mutex_lock(&id_mgr->lock);
>   		dma_fence_put(id->last_flush);
> @@ -749,16 +733,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		mutex_unlock(&adev->enforce_isolation_mutex);
>   	}
>   	dma_fence_put(fence);
> -
> -	amdgpu_ring_patch_cond_exec(ring, patch);
> -
> -	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
> -	if (ring->funcs->emit_switch_buffer) {
> -		amdgpu_ring_emit_switch_buffer(ring);
> -		amdgpu_ring_emit_switch_buffer(ring);
> -	}
> -
> -	amdgpu_ring_ib_end(ring);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index daa2f9b33620..e9ecdb96bafa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -493,7 +493,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		       struct ww_acquire_ctx *ticket,
>   		       int (*callback)(void *p, struct amdgpu_bo *bo),
>   		       void *param);
> -int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
> +int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> +		    bool need_pipe_sync);
>   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   			  struct amdgpu_vm *vm, bool immediate);
>   int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
> @@ -550,8 +551,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>   			   uint32_t fragment_size_default, unsigned max_level,
>   			   unsigned max_bits);
>   int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
> -				  struct amdgpu_job *job);
>   void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>   
>   struct amdgpu_task_info *
