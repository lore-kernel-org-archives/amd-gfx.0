Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D1ECF8840
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 18:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68AEF10EA85;
	Fri,  4 Oct 2024 18:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pbmoPmVC";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E37810EA85
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 18:45:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdrUnltwFfx8i4gXdyJev3aIV+P5fZ4G7K6qOskx02jSQSwspXnknn0CvafZ8qdnH/7UfGud8VlnFXR/Y9q3Rpdtbttn1ImuM3cFX8vFXiW9UF9sJqWn3graZgjPBMR+5ft9dO9HXJ4QJsjcquHkNoWqjsCMK7nwEO3cxlVi9lUi/GJ2Q550QGMLp8fqNvqNIY2Yta1ZQaZIAD3wL9w7qFVx4/GKKaAyuLMrrXsQoDCC2JAcwzvIS+mc3m3NstsCT+VyispbonMMm4W4NdMAt6CCHAwznZ77u2LV/s15CSMrzXIwoODtPXdeN33ezfdZ6vT/WpvXttoW4WE7WfnvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3Vp9Ti+dHvj/Spxj+Id10nCJwzZHRX2DAjsyQcKNSk=;
 b=h+pCfBl/fLhXFBS1Per3K5w12pfq6eWAr1bMSVsJz7ADc1DQafEPB8wXD/QseEHeuzchGfseN3XZYvMB1M9zxTfViJhWbDMexzmmMwlZE4DkrG4QNBMvcNHRd0bvgw2akO0BVa6JUQG+0udcCPlGvje4UP6h7O+5PV2U3k8tSmV9l4LzNZHzFPAClLHmAgKOHZ/8NY4ibSOripXQ5xBbQ56xMLoz1W+Jj59b3fAfYKVy5p8AT9iYKNJJdwDX8l/OEwR6Zentty//3A2mkkIXu8dllboFDkhAPW69QNZEcvPJ4gtI8SA7PKXhZjnXySgJXZYqf57q8/6KmM7kMxpSIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3Vp9Ti+dHvj/Spxj+Id10nCJwzZHRX2DAjsyQcKNSk=;
 b=pbmoPmVC8XpY9R7qI7jCCVGWHFUBTSiPHp9SoGge7YbMSc6p6bUmDFx5SXWpMfFWHVwLSbxcQEF28XoBdvs1k8snwKTOxvAymydTZ8ssq36eFv7YUwohcVlQT3YK8VIgpNd5QZ+oG8iSr91ObX57uE4m4yp6+FATHaSbU/ecUfM=
Received: from MN0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::22)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 18:45:01 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::1e) by MN0P220CA0005.outlook.office365.com
 (2603:10b6:208:52e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 18:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 18:45:00 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 13:44:59 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 00/18] Separating vcn power management by instance
Date: Fri, 4 Oct 2024 14:44:26 -0400
Message-ID: <20241004184444.435356-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 21efaca3-6f43-4b7a-5e19-08dce4a4a6ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2ZmbWgrdnFNa2Z4cVhaY29EdE5JcVdQV3FSaGUrZVd5cDJzQkVyb3BCRHZF?=
 =?utf-8?B?NHNCSjgyeTV2cGRnVU1BSFRIZ05LV0d1QTVMa2pleVBPdTRwYUdHd0xyR2JV?=
 =?utf-8?B?U2dqOHZSZGpyNGxtYytkdzNMay9lWDdWRDdxVitUYjJGeFlvZ2hKK3JpOWN3?=
 =?utf-8?B?U0hPbDZnZ1NwMGdKSHQ2ZGxGNFlHU2pRSWxwbDRMdzNQV21CWVNXSGxuN21S?=
 =?utf-8?B?TzNMeXMwZ1ZKWUNLanMzSm5mOEs0QS9tNUhwRVRZNVNWUGZrNVJVaFNxaFlF?=
 =?utf-8?B?WmhPSU5TRUM4cStKRmVHRHNOZUhvMDBFZS83bzUzYjJYNlJnclMrSTQzcGJN?=
 =?utf-8?B?eXM1Zy9oSnlyV2FldEN0L3hOZ3JJbGEvb00vc2h2M2FOOE05SStvZ3BuNlg5?=
 =?utf-8?B?QTN2MW9SWitwR1hNSTk2Q2I4ZGZUd2Raa3VhMWVGeXVMZkJLUm9HWG9tUzNx?=
 =?utf-8?B?Ym8vK1pOa1RWZmlNNkdDUzBaN0xhMThWa3cyMDRLWWNiclp3aFFqRUtLb0VG?=
 =?utf-8?B?UFVNME5yWnIxM1hKNzBZZmVWZmZ5YmlmcVRjUTVtbUtQeXZvS3RXRitqYzF1?=
 =?utf-8?B?Zmh6eDBKZFZnV1RJOFE4azBRU2QzQWovSWRMNFdzVCtNRmc0aG1HQzNjQ0lE?=
 =?utf-8?B?NDIvNkNyVzFzTVlrN0V0bmJiQ3VjVTNhZE9PazRGUGdRTFNadmY2cHFzWDJp?=
 =?utf-8?B?aFRyd2xrTndpV0hVM0JDSWJiOCtUNDVCZFhaNmZpNXBuWDk2dUY0L1R1MDNj?=
 =?utf-8?B?U1h0cG9hR0pJc0ZKQkQ4VlpaaGJKd3dvdU9vdHh4dGYxWTlVZjFycWZjOFpR?=
 =?utf-8?B?eUZVbmFjcEFKT0pJeHdlQlVDbmRtS3hJMngycDhHd2p1SU5tb3B1cUZaV1Rq?=
 =?utf-8?B?WnA0RGlrSjdtUC9wSXhUOEVnSWx0dHRlQ05VaHovWWxPNjhudkxNbzQvT2dm?=
 =?utf-8?B?Ym9vbjZqOUpFWjRhVzdiNUJGL3ZaUzQyUEEwL2NOemRtSE13RU8yQ2s1Zjlu?=
 =?utf-8?B?dUprbHFKNmtKMzlLdzJRNFYvNE9CdGxINU1oY1hBRmtmdlZvWnE1cDdpZ2pO?=
 =?utf-8?B?a2sxTldJaTZ2dmhSZ3ZrWTM1aWRSVXYyb0VJM0hwcTFKalhxUnNRNzhCNGRO?=
 =?utf-8?B?alE0aHFDMjBIbHdFRHkxd2gzQmNrc2N5WU5idDJxZUlFditReHlLWS9zSldO?=
 =?utf-8?B?b21VaDNSVTBlQTdiYStVeTE0ZWZVRG5hUnNYRTBwRyszeTBsMThqYjk3RjJV?=
 =?utf-8?B?bDA1QXV4R0x2Z0Rjc1NTNTNKamNmOU1seW5hZ29xZWwwZFduRnlKMTcrblhv?=
 =?utf-8?B?cjFMUjk2WTFFQlAwSGlJNWJucXpncHJVMm9HMGwycmZ1ZVZFY25lenF0OURt?=
 =?utf-8?B?c09zN3FsZVRqOEFZK01pRTg2bTFxenFXQ3FlQmg2eGNLZHRhRE5jMVNjWnFP?=
 =?utf-8?B?SURydmprVDNvc0FDWnFPV2hCWi9pUWdNcjVwRkNzRnpBT3R3Z1BZYzNzazlj?=
 =?utf-8?B?ZFVIK1JoOFdFQkxyN1hDLy9VYXNjbEdKL2ZjQk5LSFFvVmhBdGttUVJVY1lE?=
 =?utf-8?B?cXFZcXc2bzMvdjg2dzVVQ1piQTEraWU0d09tM1F5Znh0Snk0R0VRUDFyM2JO?=
 =?utf-8?B?bDNyWWdjNER4RFRUTXlaRU5rOGtIZFh3WGlPL2Z2ZTg4MWQ1aXoxTzZxNVkv?=
 =?utf-8?B?WXM0N0IvaW9HTXY3aWlLeC8rWHAvUCtDWm1KeDFXbkVCc2plK2FxcThpNU1i?=
 =?utf-8?B?Qm5WeXBMOGNueHl6aVppRHpOMTA2Y0lFMXVHTmd5eHlwcVB0T0dzWG9sNWxm?=
 =?utf-8?Q?OgtycU+m1QXqRhNFhQWTvAq3LG20FTwMWEzko=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:45:00.4639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21efaca3-6f43-4b7a-5e19-08dce4a4a6ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Previously, all vcn instance will be powered on/off at the same time
even only one of the instance requests power status change. This patch set
enables vcn to ONLY power on/off the instance that requires power status
change. Other vcn instances will remain the original power status.

v2: complete re-work for all PM changes as suggested-by Christian König and
Alex Deucher. Adding instance to all existing functions, instead of create
new functions. Remove all duplicated PM functions in previous patch set.
Use a new logic to track instance for ip_block with same type as
suggested by Alex. Also, fix wrong ip block index and remove redundant logic
suggested by Christian. Finally rebase all patches based on Sunil's ip block
changes.

Patch 1-6 are SMU changes to only power ON/OFF given VCN instance.
v2: Remove all duplicated PM functions in v1.

Patch 7 is VCN change to separate gating status for each VCN instance.
v2: Remove redundant logic.

Patch 8 is VCN change to handle idle work separately for each VCN instance.

Patch 9 is to pass ip_block in set_powergating_state() callback function.
v2: fix wrong ip block index for AMD_IP_BLOCK_TYPE_GFX

Patch 10 is to track VCN instance in VCN ip_block.
v2: use a new logic to track vcn instance

Patch 11 is to set_powergating_state by instance in amdgpu_device.

Patch 12-17 are to handle ip callback functions separately for each
VCN instance, so that only the given instance will be powered on/off.

Patch 18 is to set powergating state by VCN instance in amdgpu_vcn.

Boyuan Zhang (18):
  drm/amd/pm: add inst to dpm_set_vcn_enable
  drm/amd/pm: power up or down vcn by instance
  drm/amd/pm: add inst to smu_dpm_set_vcn_enable
  drm/amd/pm: add inst to set_powergating_by_smu
  drm/amd/pm: add inst to amdgpu_dpm_set_powergating_by_smu
  add inst to amdgpu_dpm_enable_vcn
  drm/amdgpu: pass ip_block in set_powergating_state
  drm/amdgpu: track instances of the same IP block
  drm/amdgpu: add set_powergating_state_instance
  drm/amdgpu/vcn: separate gating state by instance
  drm/amdgpu: power vcn 2_5 by instance
  drm/amdgpu: power vcn 3_0 by instance
  drm/amdgpu: power vcn 4_0 by instance
  drm/amdgpu: power vcn 4_0_3 by instance
  drm/amdgpu: power vcn 4_0_5 by instance
  drm/amdgpu: power vcn 5_0_0 by instance
  drm/amdgpu/vcn: separate idle work by instance
  drm/amdgpu: set powergating state by vcn instance

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  68 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  82 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/cik.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c           |   2 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/cz_ih.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |   4 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |   4 +-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |   4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   8 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |  10 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |  10 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/si.c               |   2 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |   4 +-
 drivers/gpu/drm/amd/amdgpu/si_ih.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |  36 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |  23 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 593 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 610 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         | 541 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       | 476 +++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       | 549 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       | 459 +++++++------
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c               |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 drivers/gpu/drm/amd/include/amd_shared.h      |   2 +-
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   4 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  49 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   3 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |   6 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |   2 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |   6 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  59 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |   4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |   4 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  24 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |   4 +-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |   4 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  19 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |   4 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |   4 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  38 +-
 104 files changed, 2053 insertions(+), 1929 deletions(-)

-- 
2.34.1

