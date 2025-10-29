Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD53CCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 11:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 477A610E11D;
	Wed, 29 Oct 2025 11:52:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yb/M/fts";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013010.outbound.protection.outlook.com
 [40.93.196.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1592910E11D
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 11:52:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=as/p/AS1UMKFMktVUE876khaA3Zx3Yraj+tl7zFFA4hPf4oc/YbACAJQ7TccOQ6WkiHN5PGnjQZRHxnWQaGqcLieUzwSmJnaKWdu3oz4/bN3RUu2fNl7JkKbz8Pr3UkpiWPkxmv23HF96sd5gBI5ZrHnGTz4+4PGxv3eHusvX0lU1B4qBHWsmhjwiDYQSuJY4liU/WfKRv/9UbQb9YoZZpYPVKu5dhkfDrm/kuG88NU12cTxNNBB6aEbZerRilw4ieYAytJY3qy0TcXHsIdX+JHOI1XqMHiEHi2b1tLbLX8Wq7pyDnMOLvuUVlzE/lGjLmfXf1/2PNFe9P73ICCdGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHML8pP0UM/70cawMS7VFWNWlqaFBfRjRFJgoJ2GDo8=;
 b=bgvAaQlfuBBvd6ogZJeq0L0duyYrYGSA627WlvA8kKKkTwOR4BthrJYyDh6J4vbTHn+khp+0ZbfQroG73ZOCBmTRoqjangfZriAY07h+IVxDv/9eSlU+BOlYleksMp6zZ43Dpngd2Lx3g71lHwSnZu2FKlCtigc/CdHoo+KTETHRUcNox8wLRTJ3IIs06Yj92RsEaiFrTOKOCstM6bK+D3XRvZu6D0FlZ46b7frovw33RiPHGdHLbEoC1dd45b9sxLSQ/KfmW/FgZaLbo7vGedQjhnE8bd7cbNd6SRfywyWT8v1B0aJ/S96Hef/V4yQktTqqeUZVDMcnrSgT1ZvODQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHML8pP0UM/70cawMS7VFWNWlqaFBfRjRFJgoJ2GDo8=;
 b=yb/M/ftsQ+T4KCrfkLp9+521Tvr6meuuIOwkwjibqjWUWGmi5ygSDeVNojhlYwq44uXv24Y37qkXPx9OI/AzlajFNAkYVPpzGvihOKCgfKrSKq+AuvcQRFWLl3tVAcRCX2/Da0gCKv96ifX4Qmshev2e3wP9gZUvbdNB+ZdBho0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 11:51:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 11:51:59 +0000
Message-ID: <ec4d47d8-c4b8-467d-8e38-bb2f65675192@amd.com>
Date: Wed, 29 Oct 2025 12:51:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] drm/amdgpu/vce1: Enable VCE1 on Tahiti, Pitcairn,
 Cape Verde GPUs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-14-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251028220628.8371-14-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: 386775df-85cb-41e8-3be0-08de16e1911e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXFlRjFMZmFIbzJnTGpmVnovd3VzWk1FTERZVTYyQm5GQ01Ddm1QUzZBa0Z5?=
 =?utf-8?B?WXdEZUpYcWRRMkVTSkJBcUxaTDh6QVRsNEhsRTl1ZXd3V040aHVWQVEwMndH?=
 =?utf-8?B?ajBJTldrY2ZqMEJBVUtSSE40OUFZb0hVUGVhbGx5OVpra3FHUkhMc0FWRTkr?=
 =?utf-8?B?cGM2bng5akZFaWJEK2VYVlpJb0Q0OHBNTTBJVEQ1UkRra0phMDZBWE1IRUNw?=
 =?utf-8?B?Q24xMTQwSU1SOFE4S3g0M091QUluZ2V4cjZ0S3FLalFwNGg0dmcydkJQWnVx?=
 =?utf-8?B?QUpoVEVTTkh4YUs5cFZxam5zT3RyWkpiYkJzVVl2ZmVvWHd0SmpuTkRYT0FI?=
 =?utf-8?B?TU1uQlNsM281aWwxNUpBWUtISkxXMGI0VVpjbE1XY1RJK25UWnlycCtRL3hP?=
 =?utf-8?B?TlM5WFRoUmtUb2JSR2tpbVZaL01zaVJ3bGFOanVFQzMreEo3ME5PZGpSNmlG?=
 =?utf-8?B?RWNHMW94S1A5U0phQ2pRRm5PMnYyMTdEOUJLbXdUZE5ab0ttbGd2ZFNRbjda?=
 =?utf-8?B?R0RxZ2UrKy9yeFpaenZ3dTBaSkZjNkJEalFSeUhXNjN2NndDcjh5SnpMc2xM?=
 =?utf-8?B?Sko2RjdVWUFBbmRYck1QVlR6V1gwa3BYcnVwVUhxQnRZYStDdXhpRzFoQXdL?=
 =?utf-8?B?TnBsZ0VralAvY0l4b3hUdGJUYlAzbnNwZytaRVloa0VaandHYXptMmpxTHZ1?=
 =?utf-8?B?Sko0aDMxaWZjbTZtSXFQdHhRQmI4UXhsajE1TElhTUpwMk82Vy81WXgrdHFq?=
 =?utf-8?B?UE1kZWtXZXBaMjJvS0N5Wk1CbWJkSTkrajFkc3B5ck5Bb2xiNXhoYW5KLzcw?=
 =?utf-8?B?dGNEM3crY1Fla1V3SVFRaVFWZGpEanRBMDR3cVZRME1uRkdmVENzRGFzZDF4?=
 =?utf-8?B?WWVKa3phcW45SHZaK2lqbW1aSm1VTWZtZnh6Ynprbk9qS2pKeVJTZy9nMzhQ?=
 =?utf-8?B?RFlJU0xaSG5MNXlOazlIN0VMTzc5L1JNYTF5aWtHRzFDbjQ4YkxRaEsvWXk0?=
 =?utf-8?B?SWFHaVpZMENjZCtCY1FMSUhzc0NSRHlaeHB5bm5tT0huL2hRZkU2K0lvRnpx?=
 =?utf-8?B?c3dhcEZOanFFTkVkL2lpQWZLS285V3pPM1gxSVNnU3BuOU9DU0lJMDJnMVRo?=
 =?utf-8?B?S0lrVm1lYm9uU2dvbk5WTElGN2FEa3YySFpLK2ptOEYwemdFcG1YUE5MSFVF?=
 =?utf-8?B?WWU5NU1vNHloY2NKbVdKd3hJemE2SmMweFRiUlhhMjRRUXNNTnFmcUxUYm1h?=
 =?utf-8?B?L3J4RDU5b2FBNFg3VVZYZ1lTVUd3emJVY0pHcGxhclhQRUhDOU9JMVF2SDVy?=
 =?utf-8?B?V29XaHhOWDVlVE8zQ1RXYUNjTHFvZXVLbVVnTVJ0aW9GaE5seXRsbElwTWxT?=
 =?utf-8?B?OXAvYzQ5MnFxSTRQeFBCbHFkSENBY2lITTJQUU9NQ0R1elV6TjI1N2l1aXF3?=
 =?utf-8?B?aDZuN1FWaEZxb1hXSnBCZEgrbm5XQm5xb25Ld3ZQVUpjNE5vTHNNSm9GWE1l?=
 =?utf-8?B?cTN3ZXd1ODc1aWs4dFBqSE13OHFJdU1EWExLMTBqN0hZaDlUTGhUbDc0T1o0?=
 =?utf-8?B?NnduVnVoSE5qaHhGLzBaWGM3TUZUaVprYy94dldTSjZDQ1l3S3JjQkptZk51?=
 =?utf-8?B?b2UycXpQOU5JSUEyanJqT0lyOUk5cC9sbVdoaFlMWnhWdGlNTkNEaTdGMUwx?=
 =?utf-8?B?QmpRV2J6bnRtQjEzTkJlcTZiNDhRSDJ3ZEFxQXhNV2NWUHlwRzUyQ3g4aEZQ?=
 =?utf-8?B?NlNmNVcvb2wyWmZUWGN1b0hzdnJMNzFlZHF5MnpEZXBIZGREcVRpZTMrSjRU?=
 =?utf-8?B?cVhLSXhuY0swZUh4djZZbUVtV0dQUVZ2azJ6emVQS2dZQ0JHejl6VU5iblJP?=
 =?utf-8?B?enpJVEQrai93S0NJZTJ6UFlxeWwwOExldzVtWlVhMFlQT1Nab0N0Uld2TkF6?=
 =?utf-8?Q?SOYZSvj6d5aGyuryu01GKbyn3kjJnpR0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2F1Rnk3VkZLem9GUEtOa1NaR01VVDlLRm9yR0lBTC9GQmF2K2w4Yk9pQlFK?=
 =?utf-8?B?bGkwMjZoYll0bHBMNER0NE1LbndiWWE4N3RadGtCajdSaGVxajk3akxPSXZ2?=
 =?utf-8?B?SEcrcHhBWDV6cnFaR2o2dHhjK0oxbkhlS0hTbDY4bXlaajFlaXRqR1RnMldQ?=
 =?utf-8?B?MWJMWUFiU2FWaU5tcjVtRnpvWXR0ZkZrdlRLVFVZTTJyTyt2K1lFNHBsbW83?=
 =?utf-8?B?akQxR0NSWmI4WTJpNHVHK3FZaVBpYlE4YTB4ZGw1ektRNEx0L2VmamVsSFJs?=
 =?utf-8?B?UjllSDhqd0VrWGF1QVZqMDJicHpFOE51aXVKVXNyOERtcW1QYXJwR2E1c2lX?=
 =?utf-8?B?SGVBM2J6KzZtclZXVGZETTBXMytGWUhDY3lMOFRLRkhaU25NQjZnZFhuT3hS?=
 =?utf-8?B?bWxaOVc5dnFzQjFSUEYxZjlRZVJMMTA1aGtCaE5nRnJZSDBXVkRiOGV1eEVX?=
 =?utf-8?B?NitRRDlueWFaZGJTb0o2Q2U5UXZQekQvQUUrMVorRjc5blcvTkJ5Y2RFL2hB?=
 =?utf-8?B?RjUvM3c1WHczTTB6Nms3QTdaSU1TSW5mTEN6STBDemVkMHA5MElWN3ZsSENN?=
 =?utf-8?B?Q0NRRFEybS83Q1Nhb3QvWWh1V1ROWG8zN05KemdZWVdxVkhtemRIQnBCZE80?=
 =?utf-8?B?bXR6WWhjM3YvOTc3UW10YnZRbmh1elMrbnBlZjNYTFZlWVJLWWhBS3BVZUor?=
 =?utf-8?B?Ri9JQVZETWgyNjhRRktTeC9MWkJnOUcxQmpXc3Q2TVd4aEFmc1JXWGRqamJG?=
 =?utf-8?B?RFlEZUR1bDFmbmxvVHYyTjhXUTdpTVlnOGFUN3ptMW1rN291d0s0MWl0bzM1?=
 =?utf-8?B?RjJLditRbStyUTZyMUxQZ3BnS3NPOThsUytvdWJYYXR2anVKV1FFakxZNjN6?=
 =?utf-8?B?SEp1a3lJSXNNaTBDNlBibVZ0V3dtUmFIdHFZemovQzg2aklWY0Fic2Q0V3c1?=
 =?utf-8?B?NGoxOGw2YXB3cGQ5UkxMV0pXUjIzQ25QSTBHWEkyV0p5U1Z5M0Fld2cyVDBQ?=
 =?utf-8?B?cU5EcFVLU081KzVYMFRHUzdsMzlXMlAvWmdDTWp3V1NwT0ZtRzdYamJBWVd2?=
 =?utf-8?B?d2FUS1E1cHZlMUZ6ZTcvckJIcWMrdnFTdXh1UUdjUXJNa20zM2dZWW5qL2ky?=
 =?utf-8?B?VDl4ajdyUFFLdE4zd2ZWWmFFRmRPZ3FZa3QzSHBHVjEwbkl3RlNrcC9KWUNL?=
 =?utf-8?B?RHdRc0QwdGlpcHdRWGR5TkpjeDZRaE1Qa3BJcU9yUUZsaWV5VEF4RFZmajJp?=
 =?utf-8?B?OEh6SHRRcllreWM5cU1ONkhiaWdnb3IxQmZIZFhuV2I4cFdrTjRCUVgzUTdI?=
 =?utf-8?B?QmpVald5dFQwOUppVXh2Y0xZRmVtTGhrZlAyM0p2bXJONG16ZlR5eFlUczdh?=
 =?utf-8?B?ZDczRUpqV1ZkcVk2SnY1WXVpZVd5U0o2bEtrRU1CSGpZa01HSkRkNUNrNlpO?=
 =?utf-8?B?QlRlSlhKWGxIdnAxTTErZWNaUlBGWDI5OElkVm9DQTludWUxQmZOb2sxSHZj?=
 =?utf-8?B?dWJBRk9KSEpTWHVPemFVb2xqNDdPcXdKQ0RENCtpeTcyblBTSVlFT2tOQ0lk?=
 =?utf-8?B?K3B2Mnh6TEhlcFdsTWVZQmZPMHJCd29BOUppN2VyVGNzU1dWdk50OHRVNDlD?=
 =?utf-8?B?c1M0V0hra1dMVjVhOWJuVCtxL3pSQU1Lb0tLcFl3NVFCai9LYTVYOUZQMUV1?=
 =?utf-8?B?bVdMNHRJSmFINnBGRG56UG5JNE4ydEFCUGdGTFVoNmhGaGdFK2VZUTVHQkVP?=
 =?utf-8?B?Smd0NHhIZjlya2pvc2x0b2FuS2xOcld0MHNJM3pFd3Z3MTVHdmtJNXdJOG1h?=
 =?utf-8?B?MGkrek1kV2wvMlkxYUVDbU5VYmY0RFBMZ3ZLNmovdlpkcENsZDZ1MFYyUnRi?=
 =?utf-8?B?ZkRGcEdVOGpRQW05NGdWWjZkd0R6WndVOXNZSHN2bFRFZytJL29jdFVsbklM?=
 =?utf-8?B?NnpTaW1UbWZxUUkvdzlQVk05K2FYcTA1SU9UREJzb2dnRlNaYmk3ZXNwOU9D?=
 =?utf-8?B?cUtVWmtxbVRMalgzNFBxZnNEZ2dMekc3bFFjZm9iNXZUSnd4SnQrM0c2d1Vz?=
 =?utf-8?B?S0NUOFhEMWZRVkRQWjhnR2UrcG1hVEwyU3BTS0t2SUVLcGZLcnlGNncwZXhP?=
 =?utf-8?Q?pxzKKcYvy4NvCTvH46lbyjNQ9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386775df-85cb-41e8-3be0-08de16e1911e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 11:51:59.5395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2kUD8NzP6ZsOOOfLtLR2U+JjLTcde578h8WGFKUJ6MPwcvWQ6xtPb64qOzvlE63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088
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

On 10/28/25 23:06, Timur Kristóf wrote:
> Add the VCE1 IP block to the SI GPUs that have it.
> Advertise the encoder capabilities corresponding to VCE1,
> so the userspace applications can detect and use it.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> Co-developed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Christian König <christian.koenig@amd.com>

Again I didn't contributed anything to this patch.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/si.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index 9468c03bdb1b..f7b35b860ba3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -45,6 +45,7 @@
>  #include "dce_v6_0.h"
>  #include "si.h"
>  #include "uvd_v3_1.h"
> +#include "vce_v1_0.h"
>  
>  #include "uvd/uvd_4_0_d.h"
>  
> @@ -921,8 +922,6 @@ static const u32 hainan_mgcg_cgcg_init[] =
>  	0x3630, 0xfffffff0, 0x00000100,
>  };
>  
> -/* XXX: update when we support VCE */
> -#if 0
>  /* tahiti, pitcairn, verde */
>  static const struct amdgpu_video_codec_info tahiti_video_codecs_encode_array[] =
>  {
> @@ -940,13 +939,7 @@ static const struct amdgpu_video_codecs tahiti_video_codecs_encode =
>  	.codec_count = ARRAY_SIZE(tahiti_video_codecs_encode_array),
>  	.codec_array = tahiti_video_codecs_encode_array,
>  };
> -#else
> -static const struct amdgpu_video_codecs tahiti_video_codecs_encode =
> -{
> -	.codec_count = 0,
> -	.codec_array = NULL,
> -};
> -#endif
> +
>  /* oland and hainan don't support encode */
>  static const struct amdgpu_video_codecs hainan_video_codecs_encode =
>  {
> @@ -2723,7 +2716,7 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
>  		else
>  			amdgpu_device_ip_block_add(adev, &dce_v6_0_ip_block);
>  		amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
> -		/* amdgpu_device_ip_block_add(adev, &vce_v1_0_ip_block); */
> +		amdgpu_device_ip_block_add(adev, &vce_v1_0_ip_block);
>  		break;
>  	case CHIP_OLAND:
>  		amdgpu_device_ip_block_add(adev, &si_common_ip_block);
> @@ -2741,7 +2734,6 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
>  		else
>  			amdgpu_device_ip_block_add(adev, &dce_v6_4_ip_block);
>  		amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
> -		/* amdgpu_device_ip_block_add(adev, &vce_v1_0_ip_block); */
>  		break;
>  	case CHIP_HAINAN:
>  		amdgpu_device_ip_block_add(adev, &si_common_ip_block);

