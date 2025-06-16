Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A56C71135
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 09:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB92010E311;
	Mon, 16 Jun 2025 09:39:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Mg2H6vA";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BF7A10E30D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 09:39:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Km1WrOHdtRmBKUm6oNtxvF+6rKxdkc1lmCmcE8KhWKpxPf1I2LH6613N5DUZHn8Lj+XKbKVqmaWBrebaLx6DbQfkh+FiQBZ3S2in4FLPBD61Iv0XXKGyBzcRuTfJcdoxsCVQwnPFwLq34U2c+VX3jHuoY64BOsAClb0hLUM5+eyeY4owG4oNOaUhigYgBD/Woxdx3y26cnP4h5hfv3PmjnzVtwPLT8Wg14xiYpuvLyW/usphckK6ajOQX5WBuhXlv+z5WtyEAKBwWPiGvYnVJ5kWes20HMatajrvPCct7ZvXf5P/x97QF6b9JqVS8lagwhjDF+lU7Bj+JCK1mhhoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFruO3lxujiMxQF+Dk8RINOdpmEZdWd3M5eOYtwATFA=;
 b=jQlaPMw3dpSUiYNU2u/EueSlZDtS8HX7ZJJ8FGdHs86QFgGMsIK727RERo2QSvPbd4QudvscVS7qkfBUIxhG7V9nI5WU/6oWCysQsVBTLhlzSpEqmjCIPsX7sFAl2SKrGzkCBXVAeUsjSpSNBMUHRMPxZTUrSRlIbFN0gUUWUf13MXNdmVs2G0n5fG27nKRHbQPKVKzxIsr/78XqptVsxHSQ2S808J9VnOSFo1/qTBugTbacSQ7QGf7+xAokvWLqvdmpcuZPihIPhrhV220H//MFHmOqG5DcE1puTxXbeLNAMGmyRvgQWh3rmR3ZnIZrng33TwRt5xYA9gL+oaR2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFruO3lxujiMxQF+Dk8RINOdpmEZdWd3M5eOYtwATFA=;
 b=2Mg2H6vAfYh7P2Fq7XG0bOD3PtB688GuxSPqR8rpap8uBbd+SOizkLBzGaPnQ10fTffy+RO20Ag1JezJ++6MxVexmHwjZ+gfPR6EJJBzo4lg0WCmsmYEcffmamFkoj23oiO0vLBC0AeGn/RgaKFe/TKSXHs+vIKnK665dPX30lM=
Received: from CH5P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::17)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 09:39:06 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::b8) by CH5P221CA0017.outlook.office365.com
 (2603:10b6:610:1f2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 09:39:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 09:39:06 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Jun 2025 04:39:04 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, Le Ma
 <Le.Ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 05/10] drm/amdgpu: Convert update_supported_modes into a
 common helper
Date: Mon, 16 Jun 2025 17:37:51 +0800
Message-ID: <20250616093756.16200-6-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250616093756.16200-1-Hawking.Zhang@amd.com>
References: <20250616093756.16200-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ae28d8-95b5-4e39-b7cb-08ddacb9a34f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nViHkYdQDRfpMDxSnMoNgd/+yJRQeurE8wQcpgzDsm0xvBAX/ir1tbrSwdUX?=
 =?us-ascii?Q?DscEfZvfv1PiXY3bbTdDmpPi8PwTsxxtfJkGtJfYB0cOCh9kfZusu1wbEb/h?=
 =?us-ascii?Q?yWEZBNxEHWzRKA5Jzl3MIdTj2VzAmMWr9jfbIbPxCW58XDdINRQ/dsIOPex7?=
 =?us-ascii?Q?lyXlvjEoffUTjDkd5vZSv8tIpLbHkbwdhENG7qlJyrkJnGKL3qWuRgEOWihN?=
 =?us-ascii?Q?iB+6Q5hkStaQaVu/unVkF8K/KC7XuqyFMsnbtEuhWhOSiaglDubHKJZG8Klf?=
 =?us-ascii?Q?eQJjYC4OAGho6AAIrmpyNo9NF0WLQ/4YFrbw4Y0gInrI/R/roVyyFZRdwhMJ?=
 =?us-ascii?Q?/VixYVNqQsGB8f4y5ThXXlZ81IkCFlYoN5R+hSdgqXS8Nj7/oBFWIyOQT2Tn?=
 =?us-ascii?Q?IZMwWGD0Wf65Ou7kmO0sSc0+W2Ik2cSW6yQlqdXHYSlMsvyLr3RVq5hesEdB?=
 =?us-ascii?Q?Li3nbU/JSLQ7fP7vWzwvHHNIEJH65er48sGkTIu5ofLqaY7NwJ6sy06w4UMj?=
 =?us-ascii?Q?4EQYU7syR3TBNT11CUyW5/fwGj/4ZqLIHv8Bv9E8oGKlF6gRrghSQYjaInBo?=
 =?us-ascii?Q?R2kEvi1sMBVwTpC+yPFFv9mPm+DsO0HrpKRnuD+tC7v0iBuj8LkZ91UJdCSY?=
 =?us-ascii?Q?VNa5C5MitPQ/qQ7mQpOYRBJ3CCkY8wc8IRB/RZPXbZ5+4DRpoKUPY7RY+5Lp?=
 =?us-ascii?Q?pxqQMKGaz2rCz9bcrkH9nVFGNYirFOuFGfGLz48ErNMnxDJlUxJksNE6Druv?=
 =?us-ascii?Q?SnAvTQbTeMzfPrg3VTMPgvjt8sAqIMIPmGE2Om5TBZSG7nk+ZgSkWLce3xJS?=
 =?us-ascii?Q?2/3SeS7rGB8rarneTa6UypxAx3p1oCKkpSmRjvb1l+zfAhJrC1s8CMKS7zki?=
 =?us-ascii?Q?uejvwd8VCvWNW2io7fNj/r/THl97HvncG3IkCZUwMGlaQWYvVYG/cWg3KLKm?=
 =?us-ascii?Q?UFwzIUGmTwVVugcX9GUGUcKl1X0tIehMw35blR/d+fZ9GjTz3n+z4hQWsbKw?=
 =?us-ascii?Q?r4TgQyDWZVXhmcOl3wtxqqX+zPoEFjn3XpKYwm58gzxJHkqRgG6f2S2GiDS9?=
 =?us-ascii?Q?F0U0lMZwcTrvylWymPIboSrqaT2s7CWpc5pyW5HBwKM6cAqZNKyaFiRycyFj?=
 =?us-ascii?Q?1KAYU0G0cJH2ZMz3GgDLVP1fP0TxSZGKcUBrmnrTkrk7gXdN2huMohegDy7O?=
 =?us-ascii?Q?efddFsRnVZqW7XkaLEsW2LQZ4bLVCWWDCs6RGbA3LZARatIsz6ih0d0ggdws?=
 =?us-ascii?Q?GUNUV4KDs2uUoQK5hqdABAe/3rvAWSduJzSLYlqlo3s4D/fR4poQqhIxApau?=
 =?us-ascii?Q?MKLQCf0ckRQlJ/whrfMEws4AH+hEtNayVHbkqUF6FSRv7nyC19vMZFzsMUfY?=
 =?us-ascii?Q?2+jyBFlIdRK66FTB0BarOi73/i68MN9QIyuak4LkQoL3YcVA9UF1YNwD0Aa8?=
 =?us-ascii?Q?I7hkAA4tS59o0EuMN1U7Unlp5HncYG0Vpg/RgkhbSNIiZ2bUBHN9hpF9JCUL?=
 =?us-ascii?Q?PB/yaHp06WHtEOK1O6KcG18ctxa5rK3kkTBA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 09:39:06.4501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ae28d8-95b5-4e39-b7cb-08ddacb9a34f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
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

So it can be used for future products

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 37 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 41 +---------------------
 3 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index f056c6cf7faf..d2423abac68b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -594,6 +594,43 @@ int amdgpu_xcp_update_partition_sched_list(struct amdgpu_device *adev)
 	return amdgpu_xcp_sched_list_update(adev);
 }
 
+void amdgpu_xcp_update_supported_modes(struct amdgpu_xcp_mgr *xcp_mgr)
+{
+	struct amdgpu_device *adev = xcp_mgr->adev;
+
+	xcp_mgr->supp_xcp_modes = 0;
+
+	switch (NUM_XCC(adev->gfx.xcc_mask)) {
+	case 8:
+		xcp_mgr->supp_xcp_modes = BIT(AMDGPU_SPX_PARTITION_MODE) |
+					  BIT(AMDGPU_DPX_PARTITION_MODE) |
+					  BIT(AMDGPU_QPX_PARTITION_MODE) |
+					  BIT(AMDGPU_CPX_PARTITION_MODE);
+		break;
+	case 6:
+		xcp_mgr->supp_xcp_modes = BIT(AMDGPU_SPX_PARTITION_MODE) |
+					  BIT(AMDGPU_TPX_PARTITION_MODE) |
+					  BIT(AMDGPU_CPX_PARTITION_MODE);
+		break;
+	case 4:
+		xcp_mgr->supp_xcp_modes = BIT(AMDGPU_SPX_PARTITION_MODE) |
+					  BIT(AMDGPU_DPX_PARTITION_MODE) |
+					  BIT(AMDGPU_CPX_PARTITION_MODE);
+		break;
+	case 2:
+		xcp_mgr->supp_xcp_modes = BIT(AMDGPU_SPX_PARTITION_MODE) |
+					  BIT(AMDGPU_CPX_PARTITION_MODE);
+		break;
+	case 1:
+		xcp_mgr->supp_xcp_modes = BIT(AMDGPU_SPX_PARTITION_MODE) |
+					  BIT(AMDGPU_CPX_PARTITION_MODE);
+		break;
+
+	default:
+		break;
+	}
+}
+
 /*====================== xcp sysfs - configuration ======================*/
 #define XCP_CFG_SYSFS_RES_ATTR_SHOW(_name)                         \
 	static ssize_t amdgpu_xcp_res_sysfs_##_name##_show(        \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 5845dce6b804..98fe270d8437 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -177,6 +177,7 @@ int amdgpu_xcp_select_scheds(struct amdgpu_device *adev,
                              struct amdgpu_fpriv *fpriv,
                              unsigned int *num_scheds,
                              struct drm_gpu_scheduler ***scheds);
+void amdgpu_xcp_update_supported_modes(struct amdgpu_xcp_mgr *xcp_mgr);
 int amdgpu_xcp_update_partition_sched_list(struct amdgpu_device *adev);
 void amdgpu_xcp_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_xcp_sysfs_fini(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 86f0eaae5274..2dfffacfc8de 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -393,45 +393,6 @@ static int __aqua_vanjaram_post_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr,
 	return ret;
 }
 
-static void
-__aqua_vanjaram_update_supported_modes(struct amdgpu_xcp_mgr *xcp_mgr)
-{
-	struct amdgpu_device *adev = xcp_mgr->adev;
-
-	xcp_mgr->supp_xcp_modes = 0;
-
-	switch (NUM_XCC(adev->gfx.xcc_mask)) {
-	case 8:
-		xcp_mgr->supp_xcp_modes = BIT(AMDGPU_SPX_PARTITION_MODE) |
-					  BIT(AMDGPU_DPX_PARTITION_MODE) |
-					  BIT(AMDGPU_QPX_PARTITION_MODE) |
-					  BIT(AMDGPU_CPX_PARTITION_MODE);
-		break;
-	case 6:
-		xcp_mgr->supp_xcp_modes = BIT(AMDGPU_SPX_PARTITION_MODE) |
-					  BIT(AMDGPU_TPX_PARTITION_MODE) |
-					  BIT(AMDGPU_CPX_PARTITION_MODE);
-		break;
-	case 4:
-		xcp_mgr->supp_xcp_modes = BIT(AMDGPU_SPX_PARTITION_MODE) |
-					  BIT(AMDGPU_DPX_PARTITION_MODE) |
-					  BIT(AMDGPU_CPX_PARTITION_MODE);
-		break;
-	/* this seems only existing in emulation phase */
-	case 2:
-		xcp_mgr->supp_xcp_modes = BIT(AMDGPU_SPX_PARTITION_MODE) |
-					  BIT(AMDGPU_CPX_PARTITION_MODE);
-		break;
-	case 1:
-		xcp_mgr->supp_xcp_modes = BIT(AMDGPU_SPX_PARTITION_MODE) |
-					  BIT(AMDGPU_CPX_PARTITION_MODE);
-		break;
-
-	default:
-		break;
-	}
-}
-
 static void __aqua_vanjaram_update_available_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
 {
 	int mode;
@@ -588,7 +549,7 @@ static int aqua_vanjaram_xcp_mgr_init(struct amdgpu_device *adev)
 	if (ret)
 		return ret;
 
-	__aqua_vanjaram_update_supported_modes(adev->xcp_mgr);
+	amdgpu_xcp_update_supported_modes(adev->xcp_mgr);
 	/* TODO: Default memory node affinity init */
 
 	return ret;
-- 
2.17.1

