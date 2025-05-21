Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE68C54E65
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 20:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB01110E727;
	Wed, 21 May 2025 20:02:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Oxkiv12r";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B32B10E727
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 20:02:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3/zE6f2m2MYlhHf9zFinrn6FAMcjNt6A/0mtRNbHUTfeuu3TWUgIdr/xkvIsVaA7vzk8a5dpXJilJrECzRT1cbzmIwLJxai/dmhZBv4bDG9ipTfVOfgVRkNUW8YvwvKIek7XYBdqcK0CFaDXeWY5QG0lepoltKvf8lIK2XMlmSwxeMPx+V3CTxvzVoYWfUbddF4ruIZ8HnCp99Kdm0cF9d7qyO0srG7dJ6JuveG0x9EIIYXEjDXNUqcZ8pAs2DHo7dOnIIcm2nGqMuaArpeu+fjwgYysy4h0zyIkHhay7PE3juCfCs77gf6V8vjyl6ZO5IvkATq/3B8V0w0wgr/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vl39VibLyrrrBPdx8RpCzRrOkJcZ8KzwxETk3MQEVcU=;
 b=g3rxZTPAsjLZAQxt3ygm/Qo2SG7X7+bP/a4yISOYY3OT5vYRK/ZLVb/MNwYxVr05MCvQpOQRju4pljHy20rBEVQRd2eAqsabKUH7RO8dfQuy5jqUWN0MyWDgEt2Ai3bKfuxJ8HHfXlEULtB36yF+hDuhpKcI5CpbRaCCuIh/EWIk2CakAd0qUEzy8CKRs4ZiSqAAgmH6lYHw53RdhzqofAMp6eKsjmqR5tzia9Ipe2+Aq1ELHMezThmDduPMLcwzcpZf2tQaiKAzZW81qF0U0kjyzqer2kWZfSryAra8Pkni1qMBIml6XqLDH0kzj5TFG0uPpHf/n6K9CjZjTqDcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl39VibLyrrrBPdx8RpCzRrOkJcZ8KzwxETk3MQEVcU=;
 b=Oxkiv12r/U1v9f43oNrq0jErz5UeRGATgGKVmXjP2+8N2DeAnVa2wg3KqHVxWFETIcudmWsbCPba8n5rn+LEgsbVFoe6BiMWqjEBgUyOe1KkbngDH3Gtr/xt6YIi8OS/uOJRHdpNRUCqg71fynlfhoscebWslLqacXFE8i338OI=
Received: from IA4P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::9)
 by PH0PR12MB8049.namprd12.prod.outlook.com (2603:10b6:510:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.32; Wed, 21 May
 2025 20:01:58 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:558:cafe::55) by IA4P220CA0005.outlook.office365.com
 (2603:10b6:208:558::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.20 via Frontend Transport; Wed,
 21 May 2025 20:01:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 20:01:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 15:01:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 15:01:50 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 21 May 2025 15:01:50 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunpeng.li@amd.com>, <harry.wentland@amd.com>, <alex.hung@amd.com>,
 <alexander.deucher@amd.com>, <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Add some missing register headers for DCN401
Date: Wed, 21 May 2025 16:01:44 -0400
Message-ID: <20250521200144.74369-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|PH0PR12MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: 316d1eca-88a3-41dd-fa46-08dd98a25771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YlU+MAJqAel6U8UcfoeBjO2J08HjHOghSZKP/a3gGSFDRam9Bucs84H2CaHo?=
 =?us-ascii?Q?+bHF1dcFElmWc9xdDPlioa16cTnb67wOmOAjj8C3YE7IJvhqeZQ22Kl6+9mI?=
 =?us-ascii?Q?pR9xvvIKnTKVazdQyOAWBACx9qyjQZoygXhuVKifTJ2r06X78Yk2W/6OR8Ez?=
 =?us-ascii?Q?IBMj2ZoxG+aK3Sr5lpjLV+gb9V163q/g9SLkIllBfUr2ca38TcaO2jIqKN+l?=
 =?us-ascii?Q?L2UfIgon2KIBxC430caVVj1n5fgmh+44N9PFmFJmAb5SkTU3fZhVJMIp6op9?=
 =?us-ascii?Q?nD7aO2pX3rx3yp5r/PMyVQbrH64dwkd6/f5Sg42CGxLN96N3lWtRafduXIkM?=
 =?us-ascii?Q?O7fKB10OjCQffUv9vFM3bUCcAJC5JgggnwHhyEAgtSOdAdrUSNIu7rWzwrY8?=
 =?us-ascii?Q?e5gVhTSxCUjaWC2dyQ0PURmen+evW8sb+BWIDZBvHamszIFgHhe2GqSsSVC7?=
 =?us-ascii?Q?oSAo/ZQH92nWYM8LAbj7Lfo/Ww8dDAncK6bSmpKcZmwK66wSp5OTtTvG/kjG?=
 =?us-ascii?Q?w7xTP4dIot1vexeJyP/zjNGgJ8JF+jAWNwRMzWP2pSA8aiNsq5ioWr/zFwoU?=
 =?us-ascii?Q?UwZV/B+T7TwmdJ+XCndC2NOpTTo1jkSiSk4aSTRCyVvbL10Yu454dvCL1q7q?=
 =?us-ascii?Q?h6QlE2GSXy9FkTIC7+ZT5BwHKss3LtghKYaaUF6HUFB0l/4yDiqzzSbuyK15?=
 =?us-ascii?Q?omnLTL7pP+N/JnGgXF/mZqZrzfkd0qacRqT9krp8Fmj3V0Y0u7geXQzn1BV5?=
 =?us-ascii?Q?pgDhbaSpMZkNnJDCZhoO63KCM+6ktSLariLto9xjMSNH7RTRIpKeRBK7H75p?=
 =?us-ascii?Q?ksxSHwlcHDcHSmVc2ORLB0KKU1OJ+fZsbfMyN3Qi0oks7NuJ/eO4HQ3bP5Pf?=
 =?us-ascii?Q?2tuRLh29I2oZAC+Yr4W2ZmYbF3rBIyxXcZ0pCbAQCfSAxVyN1AQ+/CDAu6FH?=
 =?us-ascii?Q?5fOxh+kzlVbnvH4rmiJglB1qK8WQmars+psYoNlyTOzjo0kz6Or23oJqoaHz?=
 =?us-ascii?Q?BR6MQTUE9f+Wt5/BWNUaX7CavhlIQeLC4V376qDJMXdYHdRL5iGEkUBUxrxL?=
 =?us-ascii?Q?lbfP3QEt+iWBBimvC+JrvHgOPXVYCG7PYM5pJgabHU9A497b8BdbqeMcRBtN?=
 =?us-ascii?Q?SspoyIH06fbvShMXjQlDMm88AkgbmWOrjqHFWk7SnblGdsJKEYzHFuifRI1P?=
 =?us-ascii?Q?0RfKfThMoW2Zgz30Adb8F15MPp6KQb4iycL6GcnePSedoIDPwKrjx8O35TUP?=
 =?us-ascii?Q?mJ42n4ocKT1Niwh3XENNFqlM5ddGz3b4p8VrZqhpOIT4+kJWXQRxbm/drNmh?=
 =?us-ascii?Q?DXW61CallJdu5IObG2fTugPudGV1cLZ4H/RadZF579BWDEHtyzJqHOavZ61v?=
 =?us-ascii?Q?taeWVdZLnt/4NpwgdY+Bg3SM5pA7bhLwSmd9Tx+eBC/pul9zcdKDafoYh59d?=
 =?us-ascii?Q?pRe5LFpwS7BmZViMg41wDFaYrKpKDnN5IFTRMPmn5DBC1fBTbx5s0B3PsFt8?=
 =?us-ascii?Q?BkQaXpzNltEpHld+NYQs5ZGgjdagKtrS4ViX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 20:01:57.5257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 316d1eca-88a3-41dd-fa46-08dd98a25771
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8049
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

Add some HDCP related register headers for future use.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../include/asic_reg/dcn/dcn_4_1_0_offset.h   | 26 +++++++++++++++++++
 .../include/asic_reg/dcn/dcn_4_1_0_sh_mask.h  | 16 ++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h
index 15e5a65cf492..70ee6be94a9b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h
@@ -9776,6 +9776,14 @@
 #define regDIG0_DIG_BE_CNTL_BASE_IDX                                                                    2
 #define regDIG0_DIG_BE_EN_CNTL                                                                          0x20bd
 #define regDIG0_DIG_BE_EN_CNTL_BASE_IDX                                                                 2
+#define regDIG0_HDCP_INT_CONTROL                                                                        0x20c0
+#define regDIG0_HDCP_INT_CONTROL_BASE_IDX                                                               2
+#define regDIG0_HDCP_LINK0_STATUS                                                                       0x20c1
+#define regDIG0_HDCP_LINK0_STATUS_BASE_IDX                                                              2
+#define regDIG0_HDCP_I2C_CONTROL_0                                                                      0x20c2
+#define regDIG0_HDCP_I2C_CONTROL_0_BASE_IDX                                                             2
+#define regDIG0_HDCP_I2C_CONTROL_1                                                                      0x20c3
+#define regDIG0_HDCP_I2C_CONTROL_1_BASE_IDX                                                             2
 #define regDIG0_TMDS_CNTL                                                                               0x20e4
 #define regDIG0_TMDS_CNTL_BASE_IDX                                                                      2
 #define regDIG0_TMDS_CONTROL_CHAR                                                                       0x20e5
@@ -10081,6 +10089,12 @@
 #define regDIG1_DIG_BE_CNTL_BASE_IDX                                                                    2
 #define regDIG1_DIG_BE_EN_CNTL                                                                          0x21e1
 #define regDIG1_DIG_BE_EN_CNTL_BASE_IDX                                                                 2
+#define regDIG1_HDCP_INT_CONTROL                                                                        0x21e4
+#define regDIG1_HDCP_INT_CONTROL_BASE_IDX                                                               2
+#define regDIG1_HDCP_I2C_CONTROL_0                                                                      0x21e6
+#define regDIG1_HDCP_I2C_CONTROL_0_BASE_IDX                                                             2
+#define regDIG1_HDCP_I2C_CONTROL_1                                                                      0x21e7
+#define regDIG1_HDCP_I2C_CONTROL_1_BASE_IDX                                                             2
 #define regDIG1_TMDS_CNTL                                                                               0x2208
 #define regDIG1_TMDS_CNTL_BASE_IDX                                                                      2
 #define regDIG1_TMDS_CONTROL_CHAR                                                                       0x2209
@@ -10386,6 +10400,12 @@
 #define regDIG2_DIG_BE_CNTL_BASE_IDX                                                                    2
 #define regDIG2_DIG_BE_EN_CNTL                                                                          0x2305
 #define regDIG2_DIG_BE_EN_CNTL_BASE_IDX                                                                 2
+#define regDIG2_HDCP_INT_CONTROL                                                                        0x2308
+#define regDIG2_HDCP_INT_CONTROL_BASE_IDX                                                               2
+#define regDIG2_HDCP_I2C_CONTROL_0                                                                      0x230a
+#define regDIG2_HDCP_I2C_CONTROL_0_BASE_IDX                                                             2
+#define regDIG2_HDCP_I2C_CONTROL_1                                                                      0x230b
+#define regDIG2_HDCP_I2C_CONTROL_1_BASE_IDX                                                             2
 #define regDIG2_TMDS_CNTL                                                                               0x232c
 #define regDIG2_TMDS_CNTL_BASE_IDX                                                                      2
 #define regDIG2_TMDS_CONTROL_CHAR                                                                       0x232d
@@ -10691,6 +10711,12 @@
 #define regDIG3_DIG_BE_CNTL_BASE_IDX                                                                    2
 #define regDIG3_DIG_BE_EN_CNTL                                                                          0x2429
 #define regDIG3_DIG_BE_EN_CNTL_BASE_IDX                                                                 2
+#define regDIG3_HDCP_INT_CONTROL                                                                        0x242c
+#define regDIG3_HDCP_INT_CONTROL_BASE_IDX                                                               2
+#define regDIG3_HDCP_I2C_CONTROL_0                                                                      0x242e
+#define regDIG3_HDCP_I2C_CONTROL_0_BASE_IDX                                                             2
+#define regDIG3_HDCP_I2C_CONTROL_1                                                                      0x242f
+#define regDIG3_HDCP_I2C_CONTROL_1_BASE_IDX                                                             2
 #define regDIG3_TMDS_CNTL                                                                               0x2450
 #define regDIG3_TMDS_CNTL_BASE_IDX                                                                      2
 #define regDIG3_TMDS_CONTROL_CHAR                                                                       0x2451
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h
index 5d9d5fea6e06..e3d841b2e9af 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h
@@ -2847,6 +2847,14 @@
 #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP0_AUTH_FAIL_INTERRUPT_DEST__SHIFT                                   0x1
 #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP0_I2C_XFER_REQ_INTERRUPT_DEST__SHIFT                                0x2
 #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP0_I2C_XFER_DONE_INTERRUPT_DEST__SHIFT                               0x3
+#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP1_AUTH_SUCCESS_INTERRUPT_DEST__SHIFT                                0x4
+#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP1_AUTH_FAIL_INTERRUPT_DEST__SHIFT                                   0x5
+#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP1_I2C_XFER_REQ_INTERRUPT_DEST__SHIFT                                0x6
+#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP1_I2C_XFER_DONE_INTERRUPT_DEST__SHIFT                               0x7
+#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP2_AUTH_SUCCESS_INTERRUPT_DEST__SHIFT                                0x8
+#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP2_AUTH_FAIL_INTERRUPT_DEST__SHIFT                                   0x9
+#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP2_I2C_XFER_REQ_INTERRUPT_DEST__SHIFT                                0xa
+#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP2_I2C_XFER_DONE_INTERRUPT_DEST__SHIFT                               0xb
 #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP3_AUTH_SUCCESS_INTERRUPT_DEST__SHIFT                                0xc
 #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP3_AUTH_FAIL_INTERRUPT_DEST__SHIFT                                   0xd
 #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP3_I2C_XFER_REQ_INTERRUPT_DEST__SHIFT                                0xe
@@ -2871,6 +2879,14 @@
 #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP0_AUTH_FAIL_INTERRUPT_DEST_MASK                                     0x00000002L
 #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP0_I2C_XFER_REQ_INTERRUPT_DEST_MASK                                  0x00000004L
 #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP0_I2C_XFER_DONE_INTERRUPT_DEST_MASK                                 0x00000008L
+#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP1_AUTH_SUCCESS_INTERRUPT_DEST_MASK                                  0x00000010L
+#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP1_AUTH_FAIL_INTERRUPT_DEST_MASK                                     0x00000020L
+#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP1_I2C_XFER_REQ_INTERRUPT_DEST_MASK                                  0x00000040L
+#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP1_I2C_XFER_DONE_INTERRUPT_DEST_MASK                                 0x00000080L
+#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP2_AUTH_SUCCESS_INTERRUPT_DEST_MASK                                  0x00000100L
+#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP2_AUTH_FAIL_INTERRUPT_DEST_MASK                                     0x00000200L
+#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP2_I2C_XFER_REQ_INTERRUPT_DEST_MASK                                  0x00000400L
+#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP2_I2C_XFER_DONE_INTERRUPT_DEST_MASK                                 0x00000800L
 #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP3_AUTH_SUCCESS_INTERRUPT_DEST_MASK                                  0x00001000L
 #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP3_AUTH_FAIL_INTERRUPT_DEST_MASK                                     0x00002000L
 #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP3_I2C_XFER_REQ_INTERRUPT_DEST_MASK                                  0x00004000L
-- 
2.49.0

