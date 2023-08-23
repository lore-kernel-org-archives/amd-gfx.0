Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34648EE49B0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDD7D10E43F;
	Wed, 23 Aug 2023 15:51:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8925610E43D
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFjBdqW3ef0hWTLMbADGHKuKFPacLF675RjotIAvkXWQP2QdLCgXdSLvRwIyfXCEK4S/9ayaSJkOt0oanGXw8I/35ZyrXEf86t9RedmhzWYzSDidqthe3Bc473YRt8asHoKbRfe9/Ivxtv9X/L3b1Q7Bd3pC+KHMvHu2ame8qcKYteqSYAFTDFWsbDJiSaS6StP4YfYVS7Brx9ylZt/+AtLcduqwyEPUe4YkElYa+DIaM2fatygr6cCKziAPFtHw6xrvt6EzFclQrUk4I0Nys3v7thOr6HkfHQwk2aEThwxXLVXD5ll/VTbnAaP5blwDUQehI31299W65gqDgpnBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZNgdgFDkMGCOMDHJUTpPyGnIpBitQ+51dGb/Z4t29M=;
 b=OzSwsooDMNXw0VesDEbCkkKJqNafjslngkfZ1bDPDdkxqBehm+88XLez0snSEyg3prri5emE4hW3rqBdqYVx7QveFONYgtmrMd/6lMsrBVDWIvHGB0Nn+J5CEi6YCI3RukrcZtj9GccO2KaGpRDBvD6mGT32hnhrlguUV6patnM3xhQ//kaosEmiTeXqX4DVaXW7iRpEKgSOZNCBhR2P73bX53RvnVDGHCEWaHCt6f3KFlIdshSUgLm9z5Tm37IoCdRb0wvOpxxweU/n65TAb1m/zTl4xVjWFhhp8oZHyXxuJMpBmioZNvrXhPfpsHGPogOfVBwSJkJdE61gvVMhKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZNgdgFDkMGCOMDHJUTpPyGnIpBitQ+51dGb/Z4t29M=;
 b=URLIrx/QM9uAUffQGAu4wlJ74z65SK97rv0AKuGYVSA4hki3cOYzrKTblmgRjJz8QeEFqEOBc6sbyjhOWINmfIX+4Vr/MOGkS6eciSt9MPIN8ucO/AdjGPMBOK8KxqZie2/dA0Z67tIAMYWb9auFFpHbJVHoTW9mDFTQvl8X2bE=
Received: from DM6PR21CA0007.namprd21.prod.outlook.com (2603:10b6:5:174::17)
 by SA3PR12MB7976.namprd12.prod.outlook.com (2603:10b6:806:312::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 15:51:13 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::1d) by DM6PR21CA0007.outlook.office365.com
 (2603:10b6:5:174::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.12 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/35] drm/amd/display: Update DCN32 for DCN35 support
Date: Wed, 23 Aug 2023 11:50:23 -0400
Message-ID: <20230823155048.2526343-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SA3PR12MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: 881b2551-0026-4216-5f3d-08dba3f0c726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zm3ggxOGhalNO6NVP5B6uJNjiTQFAzm86nJ/uz+n6ZifZ5gbtFA+m+5+reSkwqzNkFcLTleTpPoBOXhgltWVSZR5HKVA3k2/osvs+UtQljjlL4oj8vZfKxdQOckIG2IcmVhZY7GVSHKUT9/iVgLvUSh48/QBMAorb8b6UR7R3X3b2S+S/13Ye7ElBb+PCM7ymP52Q9iHqo+TlEsOWkEFrRKqhs2usDZGS9pggWZklmcbSVUxECwZ6V4mOaiof2S4WGR5iAz06GDIZyMw8aUFhoWGpIq6yd6MVRC3Gwb0V3W8vnjGP7iZVN3C/Oyx1iQieMxgOG7BzZ0Q6IVLjrvFRVv4fd0vD/fznfXIzI4mwtRe2gR9l8ycbrXyx/rgN9Zt+diMU7otEX7ZKtgqbbcBpKhGcSb2cuLVmp/VbcSNnYasMJdyyjrdFyp2ZOE2ywSSCnssDbGSqKTfi5DnafNJ7fwjFeSEStm2WjsAY+3VNuD2ncpp35OcX6PWv0iA6he6cTQrmDkfo7x/VKO8EZEfxAIjT5BiOWpRJI5Zo8CF+go1DShRQX9ZT0n0gspoiRETlGqnPvmfLQaHHvf+HAhq+ILIkWsPJ/0+Iz+8SW46amxjeFos5N8bCvhxfz+ywupRr8cByOg+O4ZREs1CpTp2Vz9nGe5AYYjnlR9tc+cWnY3gX3F/rmjgPMGgZeibisYqgIF/DHTnaSlG6eGtZwi0tTCAq0fneUGinIjrSJ2UxEd6aGtKO66vi1tcU0ZEIozSctSrAZM6lwAu1wtj3QPvXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199024)(186009)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(36756003)(86362001)(478600001)(40460700003)(40480700001)(2616005)(47076005)(8936002)(8676002)(36860700001)(16526019)(426003)(2906002)(4326008)(1076003)(336012)(26005)(15650500001)(83380400001)(5660300002)(70586007)(6666004)(316002)(356005)(82740400003)(54906003)(70206006)(6916009)(81166007)(41300700001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:13.0778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 881b2551-0026-4216-5f3d-08dba3f0c726
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7976
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Update DCN32 files for DCN35 usage.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h      | 1 -
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.h | 4 ----
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h      | 2 --
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h | 2 --
 4 files changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
index c8a3a6a96ff7..5198f2167c7c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
@@ -779,7 +779,6 @@
 	type MPCC_MCM_1DLUT_LUT_DATA;\
 	type MPCC_MCM_1DLUT_LUT_WRITE_COLOR_MASK;\
 	type MPCC_MCM_1DLUT_LUT_READ_COLOR_SEL;\
-	type MPCC_MCM_1DLUT_LUT_READ_DBG;\
 	type MPCC_MCM_1DLUT_LUT_HOST_SEL;\
 	type MPCC_MCM_1DLUT_LUT_CONFIG_MODE;\
 	type MPCC_MCM_1DLUT_RAMA_EXP_REGION_START_B;\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.h
index e460cf8d9041..ef15b4f1f6b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.h
@@ -43,8 +43,6 @@
 	SRI2(MCIF_WB_BUF_4_STATUS2, MCIF_WB, inst),\
 	SRI2(MCIF_WB_ARBITRATION_CONTROL, MCIF_WB, inst),\
 	SRI2(MCIF_WB_SCLK_CHANGE, MCIF_WB, inst),\
-	SRI2(MCIF_WB_TEST_DEBUG_INDEX, MCIF_WB, inst),\
-	SRI2(MCIF_WB_TEST_DEBUG_DATA, MCIF_WB, inst),\
 	SRI2(MCIF_WB_BUF_1_ADDR_Y, MCIF_WB, inst),\
 	SRI2(MCIF_WB_BUF_1_ADDR_C, MCIF_WB, inst),\
 	SRI2(MCIF_WB_BUF_2_ADDR_Y, MCIF_WB, inst),\
@@ -157,8 +155,6 @@
 	SF(MCIF_WB_ARBITRATION_CONTROL, MCIF_WB_CLIENT_ARBITRATION_SLICE, mask_sh),\
 	SF(MCIF_WB_ARBITRATION_CONTROL, MCIF_WB_TIME_PER_PIXEL, mask_sh),\
 	SF(MCIF_WB_SCLK_CHANGE, WM_CHANGE_ACK_FORCE_ON, mask_sh),\
-	SF(MCIF_WB_TEST_DEBUG_INDEX, MCIF_WB_TEST_DEBUG_INDEX, mask_sh),\
-	SF(MCIF_WB_TEST_DEBUG_DATA, MCIF_WB_TEST_DEBUG_DATA, mask_sh),\
 	SF(MCIF_WB_BUF_1_ADDR_Y, MCIF_WB_BUF_1_ADDR_Y, mask_sh),\
 	SF(MCIF_WB_BUF_1_ADDR_C, MCIF_WB_BUF_1_ADDR_C, mask_sh),\
 	SF(MCIF_WB_BUF_2_ADDR_Y, MCIF_WB_BUF_2_ADDR_Y, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h
index 9ac584fa89ce..9622518826c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h
@@ -232,7 +232,6 @@
 	SF(MPCC_OGAM0_MPCC_OGAM_CONTROL, MPCC_OGAM_SELECT_CURRENT, mask_sh),\
 	SF(MPCC_OGAM0_MPCC_OGAM_LUT_CONTROL, MPCC_OGAM_LUT_WRITE_COLOR_MASK, mask_sh),\
 	SF(MPCC_OGAM0_MPCC_OGAM_LUT_CONTROL, MPCC_OGAM_LUT_READ_COLOR_SEL, mask_sh),\
-	SF(MPCC_OGAM0_MPCC_OGAM_LUT_CONTROL, MPCC_OGAM_LUT_READ_DBG, mask_sh),\
 	SF(MPCC_OGAM0_MPCC_OGAM_LUT_CONTROL, MPCC_OGAM_LUT_HOST_SEL, mask_sh),\
 	SF(MPCC_OGAM0_MPCC_OGAM_LUT_CONTROL, MPCC_OGAM_LUT_CONFIG_MODE, mask_sh),\
 	SF(MPCC_OGAM0_MPCC_OGAM_LUT_DATA, MPCC_OGAM_LUT_DATA, mask_sh),\
@@ -276,7 +275,6 @@
 	SF(MPCC_MCM0_MPCC_MCM_1DLUT_LUT_DATA, MPCC_MCM_1DLUT_LUT_DATA, mask_sh),\
 	SF(MPCC_MCM0_MPCC_MCM_1DLUT_LUT_CONTROL, MPCC_MCM_1DLUT_LUT_WRITE_COLOR_MASK, mask_sh),\
 	SF(MPCC_MCM0_MPCC_MCM_1DLUT_LUT_CONTROL, MPCC_MCM_1DLUT_LUT_READ_COLOR_SEL, mask_sh),\
-	SF(MPCC_MCM0_MPCC_MCM_1DLUT_LUT_CONTROL, MPCC_MCM_1DLUT_LUT_READ_DBG, mask_sh),\
 	SF(MPCC_MCM0_MPCC_MCM_1DLUT_LUT_CONTROL, MPCC_MCM_1DLUT_LUT_HOST_SEL, mask_sh),\
 	SF(MPCC_MCM0_MPCC_MCM_1DLUT_LUT_CONTROL, MPCC_MCM_1DLUT_LUT_CONFIG_MODE, mask_sh),\
 	SF(MPCC_MCM0_MPCC_MCM_1DLUT_RAMA_START_CNTL_B, MPCC_MCM_1DLUT_RAMA_EXP_REGION_START_B, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 103a2b54d025..48f34f77ff6c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -703,8 +703,6 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       SRI2_ARR(MCIF_WB_BUF_4_STATUS2, MCIF_WB, inst),                          \
       SRI2_ARR(MCIF_WB_ARBITRATION_CONTROL, MCIF_WB, inst),                    \
       SRI2_ARR(MCIF_WB_SCLK_CHANGE, MCIF_WB, inst),                            \
-      SRI2_ARR(MCIF_WB_TEST_DEBUG_INDEX, MCIF_WB, inst),                       \
-      SRI2_ARR(MCIF_WB_TEST_DEBUG_DATA, MCIF_WB, inst),                        \
       SRI2_ARR(MCIF_WB_BUF_1_ADDR_Y, MCIF_WB, inst),                           \
       SRI2_ARR(MCIF_WB_BUF_1_ADDR_C, MCIF_WB, inst),                           \
       SRI2_ARR(MCIF_WB_BUF_2_ADDR_Y, MCIF_WB, inst),                           \
-- 
2.41.0

