Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A377C5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA7010E323;
	Fri, 21 Aug 2026 16:39:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L8WIVxLs";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CADEC10E323
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:39:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ao1MY9W/oGp4yd5XILMAtEqsuZFeY6q5/yq0WMTvhnlOAnSLq3Yasrw3ydNw+I7/0yPmxvnRIv2L5A5+arp7OxvJuEwDeiC2mepvYZhWvNnMNBVy8/2F123jdpgmvsd7q+H74Ht91wmpdJ22cAwMBeHZmH/97Xpizln3YOV71NfYK5aC9CQmMWer6ZAjIDpw+lpOjPUNw0IR6EC8LFR38m04feyH/AlebqqVT3zrIOtkNESiZKens+0q0Ap7utO7TRIDn+L12Q31PDI5h0F6GwmOdMPthVyJAL5BeDWS8XMf0vejLbpwpH4R35EykrRvuVW/is+TNhmljRAI+Voj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9tmkM0WGi7YzUYAe/RkzjmiGlNdxx/I2uD/4+hKwU8=;
 b=N996KVRf4dBLCtowXWK8PlE0xF9mvWH3eZHKHQFzTDJ/EO2Mg6uOTrfwPa+xgsSrrFDZyP2tS1fAwNN3nvCTmcqxO5+mHsP6haBwLdZM7udRrigA3ijeCixIZ9J6A7TnLWotRNICgR5mRGxsC9z3iARf2mbBmuSbz4r+xnFJ+j1R3sJCYLxFW0IZPIMj168S2FkS4guEC9Ylvl53Csb2uP+0/E4AEBYsCmxoAPjBJTlbNUC5oGKWaShg556HbxM5s3HwpOEu44fUr9fi9vvp5o6NzRnGzMKXJ2slqBVoUlNTKs8oWpKza411GUl4pWopKeMJxbjD6ccWUwjHl2aSJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9tmkM0WGi7YzUYAe/RkzjmiGlNdxx/I2uD/4+hKwU8=;
 b=L8WIVxLsr7Nbh5DMqI8QjMnQMCgVa4JaJnF4dO2hGhWYl7fKmU0/Fj7EWBObQwQLVAP3PT9SvH/qWFJBfCUtbFJiq+VK14GdwzQiGGtmPeb+UDJ5/TpQ5aOHtp52TWndwP13el5rjQggtZ33Llf2rREkk54GzFP94oZn2hOUD0o=
Received: from BY3PR05CA0051.namprd05.prod.outlook.com (2603:10b6:a03:39b::26)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:39:12 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::3e) by BY3PR05CA0051.outlook.office365.com
 (2603:10b6:a03:39b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3 via Frontend Transport; Fri, 21
 Aug 2026 16:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:39:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:39:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:39:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:39:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Init mcm_addr look up table
Date: Fri, 21 Aug 2026 12:38:59 -0400
Message-ID: <20260821163901.781602-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821163901.781602-1-alexander.deucher@amd.com>
References: <20260821163901.781602-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a79ab35-cbe2-4095-4c5f-08deffa2ba6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 6iwPdV7vExjeCY4pwuJ6PeLK2lSPmkXrzrKcOUeK91TWD/i36hYRzUHMsd8RWmJ+qGlPnNMBE/Lsm5HZ20XLxlRMmERgMFLVhRKycE6/i9vUJ7MH8Q2Y/yCJ8/1mdF5g+fX0+f3+l5YRj/V+xqu+n3xvpjhr55a4N2L5zPkhSehKBP24ciSozRzTwUh0PO3mVDFjOVz7KGtqmrJZab7X3Hou78vEIHdK49G/FOiKtatu/NJYoJ0q2F2Jc3GwEs692DoyGvsJVTx6qrdBQQzlWKyn6jz2NcxelS0Edtgk9BKcBKE0oJMMBZP8wG+uapnEA2dwXbMhymA58AihsSZc8blKRbU388knssSuM2t8GeoUiZM/1hsOtGmLjbuc1H+I2Jv+S5eeWE8IaCWuvPb4UgrzLCVdNarn/R4dWBdNObEsPfSY5cHQyd8KGLY0xR2cbUYj5D2sEUZe6trqGjAvN0+6KuojCefUr6FBH7b7ux7RBg9Bh29G2ETapgcyM/AIN3P0d/ft3nCs0MzhNKrcSEeLDaJQOa3DclAF48ni8yWCcUy1vjv6DqO3+s5bAhh9N/MhYDIedtQG8brU1ic5LujpbEo4LR0hu56L2o0aXsU2NMcp+mLACS2Aus7x0WNwljc9E8oekuYI9b+lKJEV38DojWlq94rYD1UmVpC99N9uyEnHYwif8qKIy68yZKM9iwrKUE9fBmZtW8iofnQ25A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2pdbOTKshyHTowrJhOrogkCtjVgItkJo0GejmeIl2jn7C+O6o2RGo4oM49lKsFCNmj4y5XvoZQQwf7xLzd0jLvE+YEWMzdciUMcMsT/sp5C8LtgflGAfu0Qt3kZq3xDDdYkSdzxr00iTZr/0Fd0GpdANDRiMqGicrW59+Nk+vX+7+/cutA/sma3sdvqkS6A5GY/ONi0ovm0ytsz4xZMUrgy1+thdwk8Spl0f1wnKy0Q2tRMIdcGHRZSGOxHUbT6Glb8IMnrKP5dyOj+LuJBhIV/6XproatOo1EjOXESJwAU+z33cLu4CDrn3aQntddgG/KXYC4eaJJDuR6wzx69/wm6ZhfqogiCQXJy9wgMmTK+0iFCIXybuU4qApJZXQzhYJmjBTozUlqJqzfAQfJZhGdHAZhkDua0hm4dHkBJIev/CB5po7vqA53cAYQIyUUjL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:39:10.4828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a79ab35-cbe2-4095-4c5f-08deffa2ba6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Encode mcm address look up table in SPX mode
as a temp solution.

v2: fill in when interface is ready (Alex)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h | 1 +
 drivers/gpu/drm/amd/amdgpu/imu_v12_1.c  | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
index eb8537558f5fb..9c56be725ff3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
@@ -39,6 +39,7 @@ struct amdgpu_imu_funcs {
     int (*switch_compute_partition)(struct amdgpu_device *adev,
 				    int num_xccs_per_xcp,
 				    int compute_partition_mode);
+    void (*init_mcm_addr_lut)(struct amdgpu_device *adev);
 };
 
 struct imu_rlc_ram_golden {
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
index 71e35e16b683f..7077f74446960 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
@@ -201,8 +201,14 @@ static int imu_v12_1_switch_compute_partition(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void imu_v12_1_init_mcm_addr_lut(struct amdgpu_device *adev)
+{
+	/* todo: fill in when interface is ready */
+}
+
 const struct amdgpu_imu_funcs gfx_v12_1_imu_funcs = {
 	.init_microcode = imu_v12_1_init_microcode,
 	.load_microcode = imu_v12_1_load_microcode,
 	.switch_compute_partition = imu_v12_1_switch_compute_partition,
+	.init_mcm_addr_lut = imu_v12_1_init_mcm_addr_lut,
 };
-- 
2.55.0

