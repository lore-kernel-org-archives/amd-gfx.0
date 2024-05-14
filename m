Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB30C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 11:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1531E10E599;
	Tue, 14 May 2024 11:06:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N2hVLxPa";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1F6210E599
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 11:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWncwuugfzwW2TR6Ca4SZQwrpNc8XaJ+f277qkjOVL5WMRrV2u0PrpWCGgPqJybnK6t3wyJcFNpFs5luwq1mkSFmtbgWCTr5yh/GCL78HCsa3yLhx4pwwb3qcbiGq0SP2GmFDMDscUBuX9gIoqTnnZfa9jRd/5Sal1Di3i1ijU+z/s4u+ky3iQLn87+nirgR5JSRsGxeX71sqmRzf0vBVMUek8AYB/99aubaEVdNDFbJLyeSVFkTB5crZ+9K9v52efGtPhsG02zM3AMUdx5pPDy1V5oQ9xIhZD2NVhm5FSFK3+iHoaZKBNhTUyrawughG2Zfy8ITVf/QTZZ7Up35vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gqwogkPGagFmjI/SfPloQDTgbYEz64RnEnJ+beRfp4=;
 b=X025w4h5yEifJxvqlXVprAazHSjKHH1iFGP3dqntW9Z+RrmkBa+gtdaR5O+HYCOussLcbkJb9uEpoX9Ybum6Ctz9YQowNUzoQmV3mSNk/utbkPM31iIfvkgj5x2qsayGoA6/ZkhEeUqgPDk4na93INvRCAXfkTZcDzmYDrelnFwTLweP6NnzuDpQNIdtHvw8476g5fYNAGxzKpIQdfRfPN/+C4VkO3cwa3MyDz5fWPQT9xKFLp72LoxJdiFOyICA+qoWWcBolGcUR2wysv+4Awug4oGGpNafNlS+ObGAyWV0OUxmoKy6dlhLGl0UtX4Whcocd1uOsvzYPW0mB16o8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gqwogkPGagFmjI/SfPloQDTgbYEz64RnEnJ+beRfp4=;
 b=N2hVLxPaTlpikCR2UonZ8cugcBoyP3E9ylJRomUke4jk0ygyH0g6g3i6mrPH8AdPYWkIa5CQFYMdr09AvwyrUPlYvUS1HARdMLYjXeWjTecxHxiZqNJf9iVtgzjI8PuKxycEwn/6nHdVhLUP62aFaruh9LcrGzRu9aEL7/fIzHc=
Received: from CH0PR04CA0042.namprd04.prod.outlook.com (2603:10b6:610:77::17)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25; Tue, 14 May
 2024 11:06:27 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::32) by CH0PR04CA0042.outlook.office365.com
 (2603:10b6:610:77::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 11:06:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 11:06:27 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 06:06:25 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v4 02/10] drm/amd/pm: Update PMFW messages for SMUv13.0.6
Date: Tue, 14 May 2024 16:35:58 +0530
Message-ID: <20240514110606.396234-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240514110606.396234-1-lijo.lazar@amd.com>
References: <20240514110606.396234-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aec33be-356c-464a-2fbe-08dc7405e6bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5T/XbAfn+YH/9LW9/lQsTms+US+CgzaptPQZBpEKrwpcM9Lr+Y/aaOAX+127?=
 =?us-ascii?Q?HoB7GrmBVRW2NVat75ob0ud42B4YYBJQwmiu/7pp7bCkSvRtyx5iggX5DiBL?=
 =?us-ascii?Q?0uWVCcQh3n60N6Qaa4bBA/oEBjoGGHLgRuPV9Wk4Tt2oqmbHJpBR98mfVStU?=
 =?us-ascii?Q?I2LOC0ivKNTqGBncRd/ghfqiAIiI0I8r8pO9X0FWu8dVehYRny8rhX8BIky/?=
 =?us-ascii?Q?aDUZYE2HGbWlF+R0uT6b3WKiZU6e+jjmwU9IfApBteIgJTmmKJc0P2Ggns74?=
 =?us-ascii?Q?RwQsHBO8dMaXRlOXW+Sm6IOg3QxDcSVkDyjE1jaaeDGkqsak/LsHjs9lymN/?=
 =?us-ascii?Q?dA45uRF7w5Uod202R5dAA9L3fh4zrj7colHe5lxGOKf27Dk9C8udyVHrxGlr?=
 =?us-ascii?Q?qxszSDcYetrzaaCeQF+b42AVzfgfRyDZtHDQGSiluibVMD070bbDBPLEdD0I?=
 =?us-ascii?Q?ErOjBBPHuXxBChWvFF5Ioxg0IZn/VtjrQowhOFfgBHwhLmHRasnHQAZkw3rh?=
 =?us-ascii?Q?JY78eloRCebbuU0Cq315KkXEqaoix60cKufIz2GVJIkIEjVzxeGMwUJCl7aF?=
 =?us-ascii?Q?07l/x5P/sXijA59dxX+cokrl60DtNciqBiTQgJzrnV2wUxRDeCRsxN8tYJvI?=
 =?us-ascii?Q?6AGBOh9sWp2H7DVArLdebefhKDsHoMZVJ+6GizpEBSu5MN4zOIijtIhPZFUr?=
 =?us-ascii?Q?MYeTl/UW5Sk03XsBzB4TIKRSlyxhUNUcxUCyb9Hf+sYK4fzvHrF178h4YJjV?=
 =?us-ascii?Q?C7UxJLAdkFjpSYyAEZtIH3uYnsJEWFUUZKDOZOdrnd2bIuJ7WZxN8drnPNRw?=
 =?us-ascii?Q?6EaOfGeCO2Xs35gqckrbZousG2ZblDphR3OVt7Wg3X8FCPQUr2hwf8vWVC4M?=
 =?us-ascii?Q?D6Wpr4yLmETKQ7eF1f5a7BPcRVGtQzgOuh998M86kFMa27yk20ZN8obWW5Ld?=
 =?us-ascii?Q?4WQ7TyP8Fw08ecCCIHC6O0DntTjSZLshW13lkB8/iTft1VAafa8N1Tk0d+mA?=
 =?us-ascii?Q?iA+V8uFIgX5lt1CKCSezfnFF7Ce+3PNnT1TDPpdwCV9f0X9vFsDpfVaqFKAN?=
 =?us-ascii?Q?ApCFDITMxB1mHEzjzRNeY9O8PNL9uVi9hyXSr5KyZSgJMqUsTx9F2Xj5NJ6m?=
 =?us-ascii?Q?2ms1mSF06r71A/jNHnf0GE7CvfvYk9keArU1vbFDfTGC6VsMgVskPFVclc2m?=
 =?us-ascii?Q?k0/tNYQB/3Bg8MTaKwrH2k+oo8gIkrYc4fgBVcn1nBAV3r3QTYas8j2RUFWc?=
 =?us-ascii?Q?0D/wSFktvD+RtGDEMCugmnz96hG2uidA7+jVypACmY5TQ6/3qdzd0sjPzyh1?=
 =?us-ascii?Q?WVfdDYGKqRDQx5LKTeKF632xLol/qtkLBXUeAsyhUVMPymZ68E9kCCUnOMO7?=
 =?us-ascii?Q?F9RuJTo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 11:06:27.3672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aec33be-356c-464a-2fbe-08dc7405e6bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890
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

Add PMF message to select a Pstate policy in SOCs with SMU v13.0.6.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h                 | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 86758051cb93..41cb681927e2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -92,7 +92,8 @@
 #define PPSMC_MSG_McaBankCeDumpDW                   0x3B
 #define PPSMC_MSG_SelectPLPDMode                    0x40
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
-#define PPSMC_Message_Count                         0x44
+#define PPSMC_MSG_SelectPstatePolicy                0x44
+#define PPSMC_Message_Count                         0x45
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index c48214e3dc8e..dff36bd7a17c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -272,7 +272,8 @@
 	__SMU_DUMMY_MAP(SetSoftMinVpe), \
 	__SMU_DUMMY_MAP(GetMetricsVersion), \
 	__SMU_DUMMY_MAP(EnableUCLKShadow), \
-	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold),
+	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold),\
+	__SMU_DUMMY_MAP(SelectPstatePolicy),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
-- 
2.25.1

