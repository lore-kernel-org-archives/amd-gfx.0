Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE5BD65C6C
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 15:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5690810E581;
	Wed, 17 Dec 2025 15:47:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lahVPIzp";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011045.outbound.protection.outlook.com
 [40.93.194.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5447F10E581
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 15:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5cZJYRgoef2GHlsLSb53dUm/Nx3PZxXknRy4Sfpq0Lf52ysixXhwgzwNA4X0PF7rguFXnD22/2TPA7/hzl2kJsYpuGdkzg89T0Zuy5H7OoDE9CotYYb9uJhOxaIHEqrbscX1dA+h891/VbCYyBYiXGcRGGWlAdWN+Aqitkbznh6xp8zj1NcEHqYA+MurVH17YVdtUzovarNGBqS2auzPyj/TuGSmbvPLmqfvoEDeLXdMZcKimL/p2EfXCu/LkPHBPtK3sSm7vNIAhmwH82bwAtMJvR47EZ5x3vKZ2bzfZbQDjIHh1gUmBqySwCXG7nsWvl1rEilYK0CfN/BlSTEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p69Y40heiXkFCx639YoK9qgGt9+lOdGwzMfL5aUS6xE=;
 b=ZxmSWKXPQW8kRv0QFWHodgZamdwnyrqSYkE2CO0nLJa60+QULMxXrl3TQuIzXwT0SPfB+D5fdT0dDlatpdBd6A8kMxgLx/aa/6abbyDB/TSLFPuWDYJz282iUklDv1ZkKyUOCQQrebbF9RYSfxNzqb8tav0LEG//tFFXeuhQAcXSWU428Fi1CV/kSfkK/oE+Gw47KuqYw35qzmSsbo983KoVe7J7bJlPfnjFNNCMPq45vZTtdgsMYRIzm5zvRPI1NCyioSn3erH5jFIFxdjZGrXldheihrlB0smmMEZl8gW9rQ+4N1vEJpURR0EE2jGNROMyfzcIbxD90/AAcnbXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p69Y40heiXkFCx639YoK9qgGt9+lOdGwzMfL5aUS6xE=;
 b=lahVPIzp2MUqponzrGyljQ3nJtSVqazx4RK+u7xFjN1QD5l/1MLy31iJillAOwqURgozWvMB8+8m2RUAbcl05HdxXds3p2iyDljumy9nr8EXxZ+KG3bmhyjoMSNNi4Qfpqz8FeIH+eV0NKHjKAaoX5fYUZKuqMcvPPmYCZx7Qso=
Received: from CH2PR07CA0064.namprd07.prod.outlook.com (2603:10b6:610:5b::38)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:47:11 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::c1) by CH2PR07CA0064.outlook.office365.com
 (2603:10b6:610:5b::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 15:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 15:47:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 09:47:10 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:47:10 -0800
Received: from [10.4.12.116] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 17 Dec 2025 07:47:10 -0800
Message-ID: <a2a6c99b-f69c-4290-993f-31411d1658e6@amd.com>
Date: Wed, 17 Dec 2025 10:47:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Message handling improvements for amdgpu
To: <amd-gfx@lists.freedesktop.org>
References: <20251215011227.161597-1-superm1@kernel.org>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20251215011227.161597-1-superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eff602a-d8d0-4bc3-3c2f-08de3d838ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3hzdkE3ODA2SGE5ZzhpWW1DT2hScVBRd3hRNSs1aHRMdVBQTzd2VlJMRVVX?=
 =?utf-8?B?SDU3TFBzUlpDVUVZYzM1dHN6eENzNVpJWXJiT3VBTUtjUEdzUnZ2RmF5d1FI?=
 =?utf-8?B?UVlRUnY3cVJlWHZ1Vk5iamhSRHRiK2pGVG41VWR0TnVoc0hnVUVxU2pSenp2?=
 =?utf-8?B?ZHE2MmVjVUZxMmdFaFNXTEg0RmlSbFBDMmp6Ui84SVR1Wm9yZjFXdk1yeHpN?=
 =?utf-8?B?VDlBWXlreWhXY3dzb1Q1dXo5dXJ3SVlSRXBBMThkS1owNlROUUtUM2NMVGxa?=
 =?utf-8?B?S3U0L1JKWDhIbW9GYU5oTWZXOElEU0RxZXVrTUZkallwM09oTkNraG9Gd1hL?=
 =?utf-8?B?Q3M2VUFZbTJGTkNHOTZUSFExOUlOeGN3Yk5NQXI2U256ZHZ4SmptTmV1WmZs?=
 =?utf-8?B?QzBSVlRtSGZiSE1Ld0ZnUC8yemVscEltOWxwZnpjRE95RzBEQ3l1VzJIWUov?=
 =?utf-8?B?WHRoMlBTYWNBOWp5ditWeHliOHBDTVptMUNVeUlSRnpTQlJnSWZudTJ0RUxC?=
 =?utf-8?B?bEExWTk3ejFiNVNucmxaaEJJUjhvRUxHUkRWeElJZGtwQnFJSnlrYXJ6VGpr?=
 =?utf-8?B?WStjOXVMLzBRYlNxSTBVVk0xclpaMGpneEdaR1BzQnZ3Q0ZpaDdWd3h3bExG?=
 =?utf-8?B?OG43MmtsRVMrNW41ZVE2WW92a1VkVEUyaWFvRElDU3VKR0Jic2svYVpIQk9p?=
 =?utf-8?B?ZTlyZTVMNUhucmJPMjMyN1MvaHZvZmIwTCs4MXMxVDRyL3FYWFZCeld0cUVF?=
 =?utf-8?B?eWIvWTVNN1BlYnZQcFZnUU4vcjZVYlZrYXlKcGxJNjVKRVc2VDFvRWZOYmhw?=
 =?utf-8?B?ZW9pRWt2T1FQc0RldnRUSDRzdlVEaXYwcjRZd0NNcEZaNUtZYmlQRVNFR010?=
 =?utf-8?B?Ynl1ZU5JclZaNGF2WExCMVV2eGp1WUxsYWsrWm5ZRDBlR1RiS1ZvaXJYaXNu?=
 =?utf-8?B?MkMvd0JSdE1MMmRseVZySElNbi9FU2VVaHVDQk1EL1VvUVNZMkVQcmhZUWta?=
 =?utf-8?B?T0tWcVR5bHRBb0VxTlgzWjNrUEcwdVVhN0pWa2RkcmJZOXpMQzlHVm5QaEpU?=
 =?utf-8?B?a2UwT0NLWU9mUWcxbVpPNzZrRFdLWDIzWC8xdkM2TTh2QktBd3JUbVNtTWdQ?=
 =?utf-8?B?WnQ1R21ZNG1BVXpoN245ZjkvbmVlaVR0WW9NK2FKSFFNa21CMGxaQXMxeHAy?=
 =?utf-8?B?RnhJdlJZSmVGVWd0Zjk4dStGdkgrcFNCaDBpRlh1d05hZEl3NTF2K3NXRmhM?=
 =?utf-8?B?a0NOUVpjMzB1WkNjTjJKeE5WMERueTBPT0F6d0FjOEtNdVBmTWl6YUFnUlBM?=
 =?utf-8?B?bWFWYzN4TTNCNDluMmcxR3I0aXZWclRIRE1mS011NC9GdEw4eHVyYlFoRUhY?=
 =?utf-8?B?Yy96d2k5UUhENDVuSjZTZkZYVkJFOHgvNzhqeDUzSTQ0MnNPTnZnTFRWS0tD?=
 =?utf-8?B?NUJQcVh6d2J5YlpKVEMyZDlDMVR1djFiSFQxRHpjNEY0a3VPSjBpY0NlOHBK?=
 =?utf-8?B?Zyt2dGR6QjAxTWpGL0F5WTE5TEMvbnZBV2Z3VEc0SEJJaEw0NFFyN2psempV?=
 =?utf-8?B?K2hzQVlPVTRKZFhqRmVIdjlFNkxSQXFqd2h1djdoQnBEcHBPbUE4Y3FNVENK?=
 =?utf-8?B?eTFIQ0FMTmNWREJnN0dmejdDUnFIZmc2djFkVERFcWdxK3JwSGoyREFQcm5s?=
 =?utf-8?B?RG44UE9RUWJqSFhROTN2Y3ZjQVpFOExBUUk3S2JBM0lKN3JUcnJCd3kxYXJE?=
 =?utf-8?B?Uy8vZWlZQWRsVzNFWklES2NsWnBSbkY4ZEQwS2JLaTRuVTYybjh6WmV6OFQv?=
 =?utf-8?B?NW5SV0puM3IxZVV1dGhBV3l2RTlac3ErOTRveTkxQi9MamNqSThFYUdnQ3Zx?=
 =?utf-8?B?WVNkaGdqdGlGTnVrWG93cWZXYSs4Tlo3L2xWQkRORmQxMFlWcjB6RSs0L05F?=
 =?utf-8?B?cVhYSjNmOW00Vmo0c3RFRmd4cVc0eUZkaTN1WXVwbnNpRlE0Lzl0cDF6RG9i?=
 =?utf-8?B?NmRRRlg4bUNGcVM0VDNZQ1dKWDlsb0lyK1pvL1VVVXJkU2RLVFBZbDFabE9X?=
 =?utf-8?B?WG0rTER2UHI4RU5yV1hDcWJUSjBqU1IxcmE2d1RmczB0emM0b3VTMXdjWWNn?=
 =?utf-8?Q?Ge8o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:47:11.3003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eff602a-d8d0-4bc3-3c2f-08de3d838ae6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934
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



On 12/14/25 8:12 PM, Mario Limonciello (AMD) wrote:
> I noticed a lot of inconsistency in message handling.
>   * sometimes two amdgpu prints in a message
>   * sometimes no prints in a message
>   * some messages are device specific, others aren't
> 
> This series improves a lot of the cases that I've found to:
> 1. print no more than one time
> 2. include the device whenever possible.
> 
> Mario Limonciello (AMD) (9):
>    drm/amd: Drop "amdgpu kernel modesetting enabled" message
>    drm/amdkfd: Correct the topology message for APUs
>    drm/amd: Add correct prefix for VBIOS message
>    drm/amd: Pass `adev` to amdgpu_gfx_parse_disable_cu()
>    drm/amd: Drop dev_fmt prefix
>    drm/amd/display: Fix DPMS log printing
>    drm/amd: Convert amdgpu_display from DRM_* to drm_ macros
>    drm/amd: Drop amdgpu prefix from message prints
>    drm/amd: Convert DRM_*() to drm_*()
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |   9 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c       |   7 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    |  34 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c       |  12 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       |  14 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  12 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |   5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  40 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   5 +-
>   .../drm/amd/amdgpu/amdgpu_fw_attestation.c    |  11 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  14 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  10 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |   4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   9 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |   7 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |   4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   2 +-
>   drivers/gpu/drm/amd/amdgpu/atom.c             |   2 +-
>   .../gpu/drm/amd/amdgpu/atombios_encoders.c    |   6 +-
>   drivers/gpu/drm/amd/amdgpu/cik.c              |   8 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  16 +--
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  14 +--
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  12 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   8 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |   4 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  18 +--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  25 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   6 +-
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c      |   2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   4 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   4 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   4 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   4 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  14 +--
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |   4 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |   4 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |   4 +-
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   2 +-
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |   2 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |   4 +-
>   drivers/gpu/drm/amd/amdgpu/psp_v10_0.c        |   2 +-
>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        |   2 +-
>   drivers/gpu/drm/amd/amdgpu/psp_v12_0.c        |   6 +-
>   drivers/gpu/drm/amd/amdgpu/psp_v3_1.c         |   6 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |   8 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  10 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   8 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |  10 +-
>   drivers/gpu/drm/amd/amdgpu/si.c               |   8 +-
>   drivers/gpu/drm/amd/amdgpu/si_dma.c           |   2 +-
>   drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c    |   8 +-
>   drivers/gpu/drm/amd/amdgpu/umc_v6_1.c         |   9 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |   8 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   4 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   6 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |  16 +--
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |  10 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   6 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   8 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |   6 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  15 +--
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 +-
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   4 +-
>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   2 +-
>   .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   8 +-
>   .../gpu/drm/amd/display/dc/link/link_dpms.c   | 114 +++++-------------
>   .../link/protocols/link_edp_panel_control.c   |   9 +-
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  20 +--
>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |   5 +-
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |   7 +-
>   81 files changed, 352 insertions(+), 383 deletions(-)
> 

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
