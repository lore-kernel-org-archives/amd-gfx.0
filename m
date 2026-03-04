Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BFFEDEBFF
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 02:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EFE210E92C;
	Wed,  4 Mar 2026 02:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fNWi4ftQ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011004.outbound.protection.outlook.com [52.101.57.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72F2010E92C
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 02:48:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0R0ywDZsYv6NSctpSxD3ji59xUd/VPU660bF9dMi+b7ff7eT2SnpLBII8pbe5d/6xz6JIhe/rxKBacSTcdSOTIaLTeEiSUQ9D/7mWytY4bZyjTEkFXPCg35V/bWy8cnWT2goep7qPXI5hXo2XGVMQOeNAS79r7RbI8NcEQDFzrdrvk3R4+cJ8QfHMe+Mxaz0G3yyr4s5xYywjcygMyiiwU81YDLDv6H8diUagG/NMYSRTEHLVqY3gXqLguNETSvk0Pz2px52B7ha2jPkTk1Fp4zk8owK5m7ahQTTuIC+Y44LlePMRqE0Qbl1cXC3kfKoZE9twpa/rJZlqoNVomy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8hjwJ+AbFzNkVNIvG4qzucbF6wxr+PxMhu3MuTOIk4=;
 b=lwKI6/GhX2ieFGTGp+Ej+vvK08NLBXKPXy7up4kz7ec29R+BALMn8cN5azcBtp6h/VdeB1jszXDm/Wj+A/uLYUGTAvL2EDvYQ+horQ2cjDkRMW/lNG4A0Qsxy13w+hnHa+XZuwGqL2YwSWc/hkq0LgXNPlOsRhgTo+N/W6LBUhV2DpUS3P8EomZIysbcuA3XmS9sJZGGwJlN0hvITAMEqWWeT3pUAgcLBYcAEuiIGpOd/jyH76+ZRaUNZipESx99CmunkzrjAJqAYchTWm0tUFb7QNhHmVHWsU7hF4gi8CcVdegYKY09ZDqIBYxQWM1J4UHIZGaqBct9o5/X3krpXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8hjwJ+AbFzNkVNIvG4qzucbF6wxr+PxMhu3MuTOIk4=;
 b=fNWi4ftQgGRDOk49GZWosj27KbmDgBA1pdSBfZQAVffAYsPb8emR2acVzVimwRInTnUkoYx0mupQcca4i9auWQORQKfzhbdIKlOXfA/2DFyTGMTUaDPuG8Zan3E+rG6qtJqVepbsj+Z3P9nVc0bn+dYMt+D3E5RT5mPau2FbL5Q=
Received: from BN9PR03CA0501.namprd03.prod.outlook.com (2603:10b6:408:130::26)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 02:48:26 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::bd) by BN9PR03CA0501.outlook.office365.com
 (2603:10b6:408:130::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Wed,
 4 Mar 2026 02:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Wed, 4 Mar 2026 02:48:25 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Mar
 2026 20:48:21 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: add missing od setting
 PP_OD_FEATURE_ZERO_FAN_BIT for smu v13
Date: Tue, 3 Mar 2026 21:48:10 -0500
Message-ID: <20260304024811.897237-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|MN0PR12MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d0dffde-9455-44d3-8afa-08de799881dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: 6Lxvwf8ho7kVWZNWHG6l+w2PY9190voJk7oXHU6oPSzwysPc2RJKtLKJnTlh6Kk3NeXSDu5YeJNmOCWTjTamMoBIvIHD4tH9C15MAuWXAxC4prqJZ2y0FmDv6yXL3B7DrrP6Hudpz93xa3/J4/rciV7FwzZlxZjzfzjGziJBnT7VI8gjY25prcqYrNdF+qsC4Bo1DYrJWPp/i79iqWhDnz+WiYkDlhSkt9c412IGgLxDH0qZHUR1PC3fddH24/nEkWTD/w4IP/IQsSyy6BLrGC6D91CPSmTSkcjZHoFj6yAlLe/ga/UaQ44kRYelswgTYdxlPmbxzvYbbbdpj0izcndvTNpbJG/dGtEpmOlc4PAIZrS4WN8gWi3R9meS3w8epduAsS2HGl0VtSG+J52wbz98GFlfXu5sOnKQtlT4ulY4vMJhbRRUkii6V5X3gQzaOfaFKmqTx9MK9yjWXHsZRz2JLaT4fFr4CqyLkXCepXWkuC/COIj97I14nPE5d2i4cmErD/PxwarsYDZycgvxqDxzI4RZftwT3OOQE5EJg4VEMO9C674XzEv33nOHPSIFjqDwwZuUrjXcI6/IixZ9hCghx8xZg2jucWK214wc0uURxOx/2E1VaueDDjWqpqsr2JdUM9uf74P5jFQaecxFLSqM4gnhmjLzxhnoC6Ym59SFDfMe7vUCwjdZQ1QAqlJlVLMMSP+ewu04Y/yotK32RQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JHua9BJrTFqkhwOpQ1cJpVpiYARQRVx5MsquzCAk0zWG6EyRQ0bjT0j+/TEBslqv+KXLisqKkbEvw67ywILEBYMoWIz0O9rC8kdk+hsMk6KQVfuAs0O5K86j0fu0680dzqMQWojOnnuu7VDfUpBSR0m2U0E8PSRd/Au3lgFa9Jlfzz3Bw87+H42qcmfHe4Lqij7crSMiDN8SsAyYGdWxkajnEPOJSuIKp1ZZTE86IODCMR6gXx/BY3XwSvcd+hOpXSxcIMgd2dsFy+irxg0Y5tOuCjgC8iCbcXbh9kXj3IImTa9m1SEb95fd0/HYYpwntuSjWp9LGEwLiOnPbnLkQ4eIfaXCwX5Un1P5EBPKEEGz1V0AhPTNXnBtdAGm57kWYcz7vWdYtHlM0MsrnIQvn91sSmvWh9uePPapBy/V4xAyK0g+DxSmpid2PKqum8sw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 02:48:25.3525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0dffde-9455-44d3-8afa-08de799881dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126
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

add missing od setting PP_OD_FEATURE_ZERO_FAN_BIT for smu v13.0.0/13.0.7

Fixes: cfffd980bf21 ("drm/amd/pm: add zero RPM OD setting support for SMU13")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5018

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 35d36f2fe7dd..0a7307f5eb4c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2223,7 +2223,8 @@ static int smu_v13_0_0_restore_user_od_settings(struct smu_context *smu)
 	user_od_table->OverDriveTable.FeatureCtrlMask = BIT(PP_OD_FEATURE_GFXCLK_BIT) |
 							BIT(PP_OD_FEATURE_UCLK_BIT) |
 							BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT) |
-							BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+							BIT(PP_OD_FEATURE_FAN_CURVE_BIT) |
+							BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 	res = smu_v13_0_0_upload_overdrive_table(smu, user_od_table);
 	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
 	if (res == 0)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 4f729f54a64c..fa23f3d4a3fd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2225,7 +2225,8 @@ static int smu_v13_0_7_restore_user_od_settings(struct smu_context *smu)
 	user_od_table->OverDriveTable.FeatureCtrlMask = BIT(PP_OD_FEATURE_GFXCLK_BIT) |
 							BIT(PP_OD_FEATURE_UCLK_BIT) |
 							BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT) |
-							BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+							BIT(PP_OD_FEATURE_FAN_CURVE_BIT) |
+							BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 	res = smu_v13_0_7_upload_overdrive_table(smu, user_od_table);
 	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
 	if (res == 0)
-- 
2.47.3

