Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04667C83F0A
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:05:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2DC810E52D;
	Mon,  7 Jul 2025 19:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R9FIVV8T";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3277310E51F
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:05:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfdXfXzW5bIn5Ln3AgXfiobKBx+NNCY0odAPYREsNc9PpbMH88SipXXx6d10sFQMA0daXf49B2AdXy9AKrtA0uVorZSkb+wAAowlqDdL8Gx0RKE0UUZkO5Kp8zC4ntlcpmyguoJdVCKPhmoMJnark2Gl2D9OCk76IkLm3jiGRZrilMwIPkArf2slMt9pnAGfRN/WzPsp62S98hJZHF5RVAcfeunXsNHy8y7cPAhz/KH5iXqi5KS3RqlsYR5YqD9YeAs0xkZF0Uee42+9NaU7cGIiJ6PMip4daUF5xNqCz2qQMt81jpUSAZjkzYsbq0X9UbHrvuj2vpxbXG9NNC8qSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb1IVhUnlZ+MDUUHDzBFI0OkwJrv1xtknLI6bQlR6NQ=;
 b=hnF8WKD1nbNIYnv0MXYjzOf9wbGUXsPyVT4U4Z6oHLNVn5cGgS3gJlCFxUFo9t1AMhZfsvmTZvx5b0+U6hFBlmez+NCYc5bRwDxxVqD9Ecpp67Re+aUrqd9Heto58vlR8CnO/ACQjDKg8NGUfPca812GrAfetxaTw3hjiuh6Ak64qTrRVEvrDXVG9kaym6RwQciV2sTv0flddNYe93QVim2vTDCNPXlueHtEHwY/SpGIgAQk4TZBgtVtAxuUe2WA1MyFbpdgCeSsd2rG/Ea3vRVtgQcUjwDbyCRYaRn1dT3aDA5XQEqULWpb/cL/nU7xwBHeVif+QTbY2YJ1P1Cm7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb1IVhUnlZ+MDUUHDzBFI0OkwJrv1xtknLI6bQlR6NQ=;
 b=R9FIVV8TbvCdJ57siDNnMWu+YBv/FyljQDtesnQxwQdLZyls67OvrHfe6Oij3SzUE+BjblM7tKWPimwaWRulpmsrfZovKvPj2W/J170gWjAHqFdNDiIETR2eOE/DpAA5qYDr/xcknpOyfShNV5Bg8VAuKYlcsgP+xfab0bYMQV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 19:05:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 19:05:08 +0000
Message-ID: <df22a007-09c1-4823-8323-a94564889a78@amd.com>
Date: Mon, 7 Jul 2025 15:05:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/36] drm/amdgpu/vcn4.0.5: add additional ring reset
 error checking
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, sasundar@amd.com
References: <20250707190355.837891-1-alexander.deucher@amd.com>
 <20250707190355.837891-10-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250707190355.837891-10-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: dd698d64-0c2d-4a22-41b9-08ddbd8930df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y014ckJTTjAwa0h6WVN1RWUrMkd6Q1RTdTQzeEMxMStYcU0vR1Urb3p6OGVi?=
 =?utf-8?B?UWhkWjhUTFZCeHVXNWlqOG4xNnhxNjN2N2lOZkRWUWdoUzNmN1owR0Y3Nk1u?=
 =?utf-8?B?ZFlRZEJ2RFZOaGdtZTA4aGZuYlp4RmJQNGZwdjI1ZHFQSEZ4eGUrTVlOcjhI?=
 =?utf-8?B?Q2RxSGlKYThINGd1TlNoc2JLS3IramlEN0NQeW0xNEE5WFBwTkhsZ1ErRnpu?=
 =?utf-8?B?T0lkdHpLbXhkY1NmN3FLY05ncDIzd1NPc2JLTVdma1BOV0pIZWROdng3SGFL?=
 =?utf-8?B?UHhTTklLL0ZMVS9IbHpyanM1ZVBqc3AxSFU4VXEvcFBXN2htQ3FHVFpTTkFE?=
 =?utf-8?B?Zyt4aUJzZU9kVTI3ay81SVRuN3lpMU9yM1VLcjdqZkdiWG5hcDhrbUFJRnRI?=
 =?utf-8?B?OEl1anR2QzhEdWlvZFdYRW56Q3lVNkVKTTJlSUhFMktwZ085aHdWZHphdHl1?=
 =?utf-8?B?bnBlUHFzdVlCcFBoTHoremRuVm1KMUNNVjdEQ2NvL2NMMXJzZzVSYk5zNmRQ?=
 =?utf-8?B?NWU3dUJRdkd3Qmk4V1JVdTQxRzFJVk9QNmh0SlhaMWpwMHpVZC9UYTdCOFpw?=
 =?utf-8?B?eHNPRjlCWjNQTFJvNjhMZ3NjSWxhTm1VcTlGREhyRUFiWUZvR244dzZiQU5G?=
 =?utf-8?B?ZGhvdG91Q3VGN1liZnZYcUVPODNWbUl5NEVJVjVOajdsSVZMaUtOcDJaZC9q?=
 =?utf-8?B?VitMVEVDbGxMQXM0d3MxUnN1cU94TTkrazNFVGdzK1RZTHJiQThVblBLNXhG?=
 =?utf-8?B?cTlTTVZySys2RjF2RkNXMnBaTkUrWk5ISkdxbkVKVTVmSUhjaklmRHFsTzk5?=
 =?utf-8?B?RHRRU2tyU1VUbm5mektrTlhKd1NRVjcyYjJwQm9yazMwdVBtVlNpZkNKQ1N0?=
 =?utf-8?B?bElyNzlLbDJxV3J4Z3V6aXJHYnFhT2xzT1RYTTZHcEVCOW1uaTIwbFVyb1Fp?=
 =?utf-8?B?TUx6blQ1Y3VRK21jREZVeVc0YkNRcXlWMU04SmF6M3F0VjhYRHpldVM2dzhI?=
 =?utf-8?B?bTVDYkQxWFg0SXRCZDl0cjQ0aFp2cEZEd0pyVngrUEFuV0x2Y2drMWNEY0dj?=
 =?utf-8?B?NzFGd1pFSGlMWmlDQm1aTWljT0tJNEs5U3c2WExEODZkbkpjaTdqVXMyYWVu?=
 =?utf-8?B?cVFQSzNwVXJJU0IrcEpFSi9ZbnNuSzFzVVZxaWNoNW94WlovWFdZRkVxaFNq?=
 =?utf-8?B?a0FuaVRrM1FVdFpNQkluTlpDQzdBOHRDR3R3VjhqWERYQ1RibnpubVRxQWZ2?=
 =?utf-8?B?aUNuU0dPMHU3eEtLMzRoUWJvS2cvUW1zcmVCTWR4QmpVd0ZJRjVJeGJrNWJI?=
 =?utf-8?B?VDlPdlFMSTV3MEZYc2JGMXN0L1JxNTNsbm1rSm5OcENoelBBZStIdHZNWVp3?=
 =?utf-8?B?TTJ0bXo2S0pQazVBSkxOaHJJQjQrY2pONHNOWmFETGMyYWkzWjJpZDVCb2FK?=
 =?utf-8?B?QkxsbHlwQ01DRVhQb3NmMVhtUjBGMnQxMkd5UnQ2ZlpTSHd5bzhqc1RkRVpZ?=
 =?utf-8?B?M29Jb0huTFhERFVIRGtEODRpZjNaR0ZLVVZFTVBoUlZ1VTJvN1dtU2UvZnM4?=
 =?utf-8?B?MmFZdlRtNGRCL3pSdExhd3pLd0MxcnlvajNMZUs1aVpKN0czeWJJVXRLMlZI?=
 =?utf-8?B?a21KZCtOYktDRlR0N2V1WE12Y05OSi9tU2szKzFyUjhLeDhZa1lMRnJTbm03?=
 =?utf-8?B?Wkp4UGRYcFVvejNEUWkyemdjTjg0UzhCc21yWVlab3pMRzVZQkFXY1d0eUxr?=
 =?utf-8?B?MGRwT04yOWFLVFNIb0RmMVNJUTdyaG5rSkN1em1iNC95OFB4ZUFLRllhaW0z?=
 =?utf-8?B?aTB5SUNnVXVrM2pGbUlLSlNVSGlYMXJWTW9Eb2JaeEIxcG9PL0VqR21KbnNm?=
 =?utf-8?B?c25RRVBWUXh3VTVYM2pxaUJjQ0hBZHZ2V2F2b2tsZ2NTVklKNEpNL1pQdjZJ?=
 =?utf-8?Q?7q597Y6aark=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0g2L3JWNGRBVS9aK0FFZlB5aFpKVEtGN3oxVTBQSC9WaFRCZVNwcmpDbVk4?=
 =?utf-8?B?MmI5RDc4RVBhZDArWC8zblM5MklyMGFVR1lvRlExRTN4Y2x1Z2J4QTdCZk44?=
 =?utf-8?B?MXVxZC95VVA4djFsS0hrVS9SVFQ3Q2JkRW1DWXZDaHVEdGErNVFiQ2J1Y0li?=
 =?utf-8?B?Q2ZZOFVnRVpBcTRzUEo2WmtidmZvekZjMitWbWhtM0ZIRnY3MFFxS1NBZVpK?=
 =?utf-8?B?cGx6UlBKQ3dpTnpnYld3K1pLekw4NUJ2TjJYQ1NmdmpDZkZYOFJNa1M5UkJS?=
 =?utf-8?B?V2N0L1MyTDlYSjBiV1E3eTRSU3RNdGNKWFVFTnZHd25kNkhXNExrS1duK0xj?=
 =?utf-8?B?UGxHTzJFdlVhaXZUVnQwNEFOc0w5cnUwazNKbi9SUUMzSVlzaElhREdmckNC?=
 =?utf-8?B?Y21ZN0M2eGVQRlBQVU9hM0dzLzNSTzM5UTRpWWYwMUg0SlFPZis5L0NzMGwr?=
 =?utf-8?B?SGJ6SnUxczRsNHdKNVQ3RTIyOUdYVHI1R05PQ1pxaGJGN2F4RU1jNEZOOXR4?=
 =?utf-8?B?ejBvUUI5cUxSTEhzZEsrRVNTZ2VWUXBEdnJJQ0c5Y0NpRCt6amxXNzFjcHJj?=
 =?utf-8?B?YUNNYUtLZFNhcjVISFprRDl3NmdKOHpzK0QwWURFYTlEUThYaEZacTU3R3Er?=
 =?utf-8?B?STNlNVIvVjdEOGdzc1E5MGt2bE9ESkRsSm9GY3RtWUpUNXZXU3pQWE1QYXY4?=
 =?utf-8?B?LzFOd2ZQa0VwV1M2dGNpTW11TEwrWFNHd1FZQjFpUWk3d1NJQ3N4THNseGhL?=
 =?utf-8?B?QzZvRzJJZUx5SlVyOFpmV25WbTZHRjBOeFlJckhuWnlBWU1hc29GQno1SWhU?=
 =?utf-8?B?UGpnZ0E2VmZ2bXhpOHRhb0p6TUZ4MWkvN0dVb3ZGbkNlM3hWaGd1WE51aWll?=
 =?utf-8?B?emZLR09CODFiRzJ6a0NNOXFsRUJOQi9mZHI5a2xGN3V3ME1CSzNDMWRnYWRN?=
 =?utf-8?B?WXZxTlJYU3lacGNRaFJkVGtVS1gwaERnc2QwUk1GUFdtSXJWRDRNUjJVbXJa?=
 =?utf-8?B?Q0FUNkt1a3h5UnQ0dmgwNnkrVjBKR0ZoekQ3Y0YwOFRNTXpFNHUvZDJ6SDc0?=
 =?utf-8?B?SzIyNnQ2QzdCa1Y0UDBzQ3d5WGJ5SzUxSHovLzhVTTlnOUUwMER5d1lkR1BF?=
 =?utf-8?B?TUVjaTFnT0VrbkZFT1dNRmwzcXl0QnJBSHlVTS80c1gwcHJZTk12c05HYXBJ?=
 =?utf-8?B?b2ZaNlArd3crS3lpNitsaGl3eW5aRTNFMlJRVFdEZUJJWUM0djNCTlVTT0dB?=
 =?utf-8?B?Z0E3U1FNSlRvT05abVcwb1UxeEhUd29SSUFoUnQ5c0FrMC9LVEl5WllQQmxa?=
 =?utf-8?B?czZxSnE4OEZGbHBrUnlhVHkzWEZyMGpuZ0h1MVVtNnZSUy8ySkFEOEtDdjZa?=
 =?utf-8?B?ckFnM2xpY0VDYzcwWEtKRGh6QlRUL3JobytuY01pc0d1TktYSEpvRlMxNG9x?=
 =?utf-8?B?VS80Z2p0MVVUTkxPSEtDbnhQVlhrbmk5RXBMNWx1azNYbGM4S0Y4c082R05Q?=
 =?utf-8?B?UmpoNzhrM2N4emIxYWNTUy95aWlQOGFkYUZnQWlncDI0bERDcVBNS0oyaTdT?=
 =?utf-8?B?T0lLVlVKY3lMZWRrTjNITnBqODUvOHVwNXVZSGlwM1lVWUtkWWh0d3hlNGtE?=
 =?utf-8?B?T0tzOFluWlF1d09qMzJKV1crVDFUTldJVGtvd2hqbElHMHJxV3JXaEhPQVJ4?=
 =?utf-8?B?cFZFSVFnMDhJNHpwWVE5OXBaRWtoMlUxTVFFbzRSdVlMOGdTZFk0L0hvcWlY?=
 =?utf-8?B?S290a3J1ZEZuSzkzYWpobGpJYmlLVUpVY2x5L2xVSGIyT1E3NEFLNUJGSzE1?=
 =?utf-8?B?QzJXamdCNkttUmlUaWxRd0VCMTlDVGR6NWx6d1lUckxLNnZMRkFXS1Ryd29M?=
 =?utf-8?B?b1ZaVFhkdzdmdFBMd0pYZ3ZmcVo5Z0dPSnhWWnlRSHcxN28ybWgxNzJwVlhs?=
 =?utf-8?B?b0tmM0t0cDcxQm56S2dLUUJOWnhEdWpEdmNRTFRESndKSzlyUHhrT2M0MlJV?=
 =?utf-8?B?TTJieGc5OGFXWlhwZG1OR2UzeDdrV0k3Vmg3cmtGbW84MVcwT2JoeTgyN2w0?=
 =?utf-8?B?K0tDTnVTY2VaM2M2eHVJcy95QXg1RlRWWkZpYTVDSVoxcnFBU0pMRlVxbUVB?=
 =?utf-8?Q?JdsLIRQha/wD5arX8f9Y1+KWn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd698d64-0c2d-4a22-41b9-08ddbd8930df
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:05:08.6555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8ht/lWmSN14m0PGsPHiVO1a7ffRVNao3+e0yMUnbbHQccbXB3yOY4dEjg1JUQarB36kxCA0/cKCIMbtUaRW4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575
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

On 7/7/2025 3:03 PM, Alex Deucher wrote:
> Start and stop can fail, so add checks.
> 
> Fixes: d1a46cdd0053 ("drm/amd: Add per-ring reset for vcn v4.0.5 use")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Mario Limonciello <mari.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 7e37ddea63550..6000c528ad6ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1477,8 +1477,12 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
>   		return -EOPNOTSUPP;
>   
>   	drm_sched_wqueue_stop(&ring->sched);
> -	vcn_v4_0_5_stop(vinst);
> -	vcn_v4_0_5_start(vinst);
> +	r = vcn_v4_0_5_stop(vinst);
> +	if (r)
> +		return r;
> +	r = vcn_v4_0_5_start(vinst);
> +	if (r)
> +		return r;
>   
>   	r = amdgpu_ring_test_helper(ring);
>   	if (r)

