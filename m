Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B94C606A31D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 02:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=n/Pt8aW5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0065810E36F;
	Thu, 22 Oct 2026 02:55:46 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0274910E195
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 02:55:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mF3RhyAy7M2B6fdRfPn3/jL7rJpcUxl7j7UVcI5+g42+gnYGxs+3mgEhHYgTM5KsNWVXolEo5vCcr5VYvU41CVW9oKDTM5v9j5x4vK9Y4f0TXNDwl8CClIDwxNol44sD1lK2Nahw6rJUa+rWReUW8F7y1cVru2y4AfZYg4WlG0yxiuK9XyAWEJfCBMo/eCIolpjIE/Vi+VrNILmOXcaAGSNsQUFR3tjVhTTw1F5qfoLTphXEtzAmH4DgPaxbesEWraYwkKsSrfOgyJrrin622Q9M0lbIGcBqWgrUp9qvDLPzKUhiSRICkBfhyMsatXOmOmkXSyv/aKzrOsoZkjCaEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgotOayIHw/5RNrvfRZCcXeP63f5ljPPaQzKcAagT2I=;
 b=GVh5vSU6TWXuEm3KOd6Sqn1Ra2JitIkjbdUSYIAy3WDDelvO+bUfBqqmlEoQ16IlkZqRPKrNEKyd9Nc860nmzuQI6tS/uq0mFhllV5jmbeGSpUqEAbS2zZcFCHzluWcBE15zTJvTYNiJbeC8gO2MH0VYGoyk9+HLo/r5XA8Cdsh75zdP/IxPchvPOFAUdvmT93V5fbYD4ECE2g8lb/esFcG17CGGDlajAW4xqANvn2YzdT7htMz1yHfK4JVE4sI0t6MqOAdBmHcFmTUTh5y23J787hsd4nuf+789p2TuEt0oSm7LqUZLNXJyjr/273F8uAX1SG/6bmpHRX8yqGtFxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgotOayIHw/5RNrvfRZCcXeP63f5ljPPaQzKcAagT2I=;
 b=n/Pt8aW5stMDMTdiak4W7sZlpUXAFqaWcXOC3MTLd5im5XwoS49UAw2pAXjcZUQAYrFObnIoiNp3sxpIALTe79oUFq3rYJGYO/BwrED5Pr5v7Ji+lqshZLeuhQqaDIeGAGkEjrvf4WcURf27UnAQ4hwCdmbbbx7V+GRlFeNLLgI=
Received: from BN9PR03CA0159.namprd03.prod.outlook.com (2603:10b6:408:f4::14)
 by DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 02:55:35 +0000
Received: from BN2PEPF0000A801.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::59) by BN9PR03CA0159.outlook.office365.com
 (2603:10b6:408:f4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 22
 Oct 2026 02:55:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A801.mail.protection.outlook.com (10.167.245.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 02:55:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 21:55:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 21:55:34 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 21:55:32 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <Alexander.Deucher@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH] drm/amdgpu: add DCN36 OPTC RSMU underflow registers
Date: Thu, 22 Oct 2026 10:56:16 +0800
Message-ID: <20261022025620.3664022-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A801:EE_|DS7PR12MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7ac910-8772-47f9-b43b-08df2fe7f1ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003|261021121427099003;
X-Microsoft-Antispam-Message-Info: QQt2ST4exFw79owJYeckXeRnlWcHA430CfVW/U8R6Wui0It3pf7sIMCyAQGPds37yqJYvYzw7zVXZ3YdycVW+/tRcZXxHXBiB17qJZqEjsapL2AxpKSI33u+FG9HrKnY/qOIIy5Jx7jgqJg8G/e4m/k3ci426LZ0ylFe6NHlBkV++CHk9xHAm1gwJUKy2Pxbejmwq4U6ft3JT/0bPQieGrM8JepJy11DCZM/KMdig3aVwNGk8LTNE/T+e/4eIA+fCWptX19sJb05y8CIfQ4fDlHajxHrwiY/aqMVLONS5KumpFOUL9dYJSkywd08rMr0pc9AVp7Yz4M1hcoem9jGIDn+GF1V7VA0cOIzDAFc17JgoQufnBExYEcfisEotJOgQA/npWya8S4DEc89YpRKNdXUadzOTqUZhfWMvxgZahJlV1ld9qX5PO48EekZHI/RhqkkFdBPXcYL5ij2l023k5uTxEob1IyHRT6eDea7CxcddqW4xLBCNgQjz9g6yQilrKKhFfTDWclQ+qVSFp0t5nUmZGamVBORtiGPkysVD9DA7zI682b1gQ0PQGlkk74p3xmv5PCuJ2dMQCiWX8/TRUKi9rvzbA/IKzATFs0BjVGXnXbMNXC8N5zbwWwDdrXUGvrQN/6MARFDmtEWEF3+fLi331Z9Blwa2OI9zv+6jDWfi+eRzEMgT69Ef7TmH07KBroFpYjgiD+t6F3qkwsU4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2OyE+TqeYYxqHL9mLcECsHJ8aiBeqtmAN/w7k2Ou8+/CZg5uKPwHaix8iII7+TykhEsN/JqIP4M5FJQ0fIbnhkjSHB9HqsrMnNB8kuY+Dk+x48DvBggUr28CDaAMQkdXYyOn7pLaGhf0HrnlOPrhXlKRDjUaxySwS8kjS2bGj59N0NXxvidC7f8huJHt83RmKoB9Pj1V8GyVtgvhkJ3Y6XuQ4SK3T1n6o5elEV6HW8W2wkBusNiHc+0+NiIl6wqXuuRp+6UoCUYPCIPCrdqte2nA1HMq6f3wTRWox0kgMEUyWrEdUJa9vi3dzwZOrbUuHaPpxYoRcfk8o6mPFFQ/3ptn/qZDIT8UISUpgxZkxcBzIevodsGqxkNMnc7WnaerOyOvA53wor3woiubdhbt3hYGb+0nKK0hE6hag7L29qjYsorpLq6xmz1b7CIGK8b0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 02:55:34.8177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7ac910-8772-47f9-b43b-08df2fe7f1ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A801.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expose OPTC RSMU underflow registers of dcn36 for later usage.

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Assisted-by: Cursor:Grok 4.7
---
 .../include/asic_reg/dcn/dcn_3_6_0_offset.h   |  8 +++++
 .../include/asic_reg/dcn/dcn_3_6_0_sh_mask.h  | 36 +++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_6_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_6_0_offset.h
index b070f9b91f17..90d624d22b3a 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_6_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_6_0_offset.h
@@ -8329,6 +8329,8 @@
 #define regODM0_OPTC_MEMORY_CONFIG_BASE_IDX                                                             2
 #define regODM0_OPTC_INPUT_SPARE_REGISTER                                                               0x1ad1
 #define regODM0_OPTC_INPUT_SPARE_REGISTER_BASE_IDX                                                      2
+#define regODM0_OPTC_RSMU_UNDERFLOW                                                                     0x1ad4
+#define regODM0_OPTC_RSMU_UNDERFLOW_BASE_IDX                                                            2
 #define regODM0_OPTC_UNDERFLOW_THRESHOLD                                                                0x1ad5
 #define regODM0_OPTC_UNDERFLOW_THRESHOLD_BASE_IDX                                                       2
 
@@ -8351,6 +8353,8 @@
 #define regODM1_OPTC_MEMORY_CONFIG_BASE_IDX                                                             2
 #define regODM1_OPTC_INPUT_SPARE_REGISTER                                                               0x1ae1
 #define regODM1_OPTC_INPUT_SPARE_REGISTER_BASE_IDX                                                      2
+#define regODM1_OPTC_RSMU_UNDERFLOW                                                                     0x1ae4
+#define regODM1_OPTC_RSMU_UNDERFLOW_BASE_IDX                                                            2
 #define regODM1_OPTC_UNDERFLOW_THRESHOLD                                                                0x1ae5
 #define regODM1_OPTC_UNDERFLOW_THRESHOLD_BASE_IDX                                                       2
 
@@ -8373,6 +8377,8 @@
 #define regODM2_OPTC_MEMORY_CONFIG_BASE_IDX                                                             2
 #define regODM2_OPTC_INPUT_SPARE_REGISTER                                                               0x1af1
 #define regODM2_OPTC_INPUT_SPARE_REGISTER_BASE_IDX                                                      2
+#define regODM2_OPTC_RSMU_UNDERFLOW                                                                     0x1af4
+#define regODM2_OPTC_RSMU_UNDERFLOW_BASE_IDX                                                            2
 #define regODM2_OPTC_UNDERFLOW_THRESHOLD                                                                0x1af5
 #define regODM2_OPTC_UNDERFLOW_THRESHOLD_BASE_IDX                                                       2
 
@@ -8395,6 +8401,8 @@
 #define regODM3_OPTC_MEMORY_CONFIG_BASE_IDX                                                             2
 #define regODM3_OPTC_INPUT_SPARE_REGISTER                                                               0x1b01
 #define regODM3_OPTC_INPUT_SPARE_REGISTER_BASE_IDX                                                      2
+#define regODM3_OPTC_RSMU_UNDERFLOW                                                                     0x1b04
+#define regODM3_OPTC_RSMU_UNDERFLOW_BASE_IDX                                                            2
 #define regODM3_OPTC_UNDERFLOW_THRESHOLD                                                                0x1b05
 #define regODM3_OPTC_UNDERFLOW_THRESHOLD_BASE_IDX                                                       2
 
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_6_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_6_0_sh_mask.h
index 3ffb6ec8b40a..390b164fba5e 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_6_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_6_0_sh_mask.h
@@ -27326,6 +27326,15 @@
 //ODM0_OPTC_INPUT_SPARE_REGISTER
 #define ODM0_OPTC_INPUT_SPARE_REGISTER__OPTC_INPUT_SPARE_REG__SHIFT                                           0x0
 #define ODM0_OPTC_INPUT_SPARE_REGISTER__OPTC_INPUT_SPARE_REG_MASK                                             0xFFFFFFFFL
+//ODM0_OPTC_RSMU_UNDERFLOW
+#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_EN__SHIFT                                           0x0
+#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS__SHIFT                                  0x1
+#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_STATUS__SHIFT                                       0x2
+#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_CLEAR__SHIFT                                            0x3
+#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_EN_MASK                                             0x00000001L
+#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS_MASK                                    0x00000002L
+#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_STATUS_MASK                                         0x00000004L
+#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_CLEAR_MASK                                              0x00000008L
 //ODM0_OPTC_UNDERFLOW_THRESHOLD
 #define ODM0_OPTC_UNDERFLOW_THRESHOLD__OPTC_UNDERFLOW_THRESHOLD__SHIFT                                        0x0
 #define ODM0_OPTC_UNDERFLOW_THRESHOLD__OPTC_UNDERFLOW_THRESHOLD_MASK                                          0x01FFFFFFL
@@ -27388,6 +27397,15 @@
 //ODM1_OPTC_INPUT_SPARE_REGISTER
 #define ODM1_OPTC_INPUT_SPARE_REGISTER__OPTC_INPUT_SPARE_REG__SHIFT                                           0x0
 #define ODM1_OPTC_INPUT_SPARE_REGISTER__OPTC_INPUT_SPARE_REG_MASK                                             0xFFFFFFFFL
+//ODM1_OPTC_RSMU_UNDERFLOW
+#define ODM1_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_EN__SHIFT                                           0x0
+#define ODM1_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS__SHIFT                                  0x1
+#define ODM1_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_STATUS__SHIFT                                       0x2
+#define ODM1_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_CLEAR__SHIFT                                            0x3
+#define ODM1_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_EN_MASK                                             0x00000001L
+#define ODM1_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS_MASK                                    0x00000002L
+#define ODM1_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_STATUS_MASK                                         0x00000004L
+#define ODM1_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_CLEAR_MASK                                              0x00000008L
 //ODM1_OPTC_UNDERFLOW_THRESHOLD
 #define ODM1_OPTC_UNDERFLOW_THRESHOLD__OPTC_UNDERFLOW_THRESHOLD__SHIFT                                        0x0
 #define ODM1_OPTC_UNDERFLOW_THRESHOLD__OPTC_UNDERFLOW_THRESHOLD_MASK                                          0x01FFFFFFL
@@ -27450,6 +27468,15 @@
 //ODM2_OPTC_INPUT_SPARE_REGISTER
 #define ODM2_OPTC_INPUT_SPARE_REGISTER__OPTC_INPUT_SPARE_REG__SHIFT                                           0x0
 #define ODM2_OPTC_INPUT_SPARE_REGISTER__OPTC_INPUT_SPARE_REG_MASK                                             0xFFFFFFFFL
+//ODM2_OPTC_RSMU_UNDERFLOW
+#define ODM2_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_EN__SHIFT                                           0x0
+#define ODM2_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS__SHIFT                                  0x1
+#define ODM2_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_STATUS__SHIFT                                       0x2
+#define ODM2_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_CLEAR__SHIFT                                            0x3
+#define ODM2_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_EN_MASK                                             0x00000001L
+#define ODM2_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS_MASK                                    0x00000002L
+#define ODM2_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_STATUS_MASK                                         0x00000004L
+#define ODM2_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_CLEAR_MASK                                              0x00000008L
 //ODM2_OPTC_UNDERFLOW_THRESHOLD
 #define ODM2_OPTC_UNDERFLOW_THRESHOLD__OPTC_UNDERFLOW_THRESHOLD__SHIFT                                        0x0
 #define ODM2_OPTC_UNDERFLOW_THRESHOLD__OPTC_UNDERFLOW_THRESHOLD_MASK                                          0x01FFFFFFL
@@ -27512,6 +27539,15 @@
 //ODM3_OPTC_INPUT_SPARE_REGISTER
 #define ODM3_OPTC_INPUT_SPARE_REGISTER__OPTC_INPUT_SPARE_REG__SHIFT                                           0x0
 #define ODM3_OPTC_INPUT_SPARE_REGISTER__OPTC_INPUT_SPARE_REG_MASK                                             0xFFFFFFFFL
+//ODM3_OPTC_RSMU_UNDERFLOW
+#define ODM3_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_EN__SHIFT                                           0x0
+#define ODM3_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS__SHIFT                                  0x1
+#define ODM3_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_STATUS__SHIFT                                       0x2
+#define ODM3_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_CLEAR__SHIFT                                            0x3
+#define ODM3_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_EN_MASK                                             0x00000001L
+#define ODM3_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS_MASK                                    0x00000002L
+#define ODM3_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_STATUS_MASK                                         0x00000004L
+#define ODM3_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_CLEAR_MASK                                              0x00000008L
 //ODM3_OPTC_UNDERFLOW_THRESHOLD
 #define ODM3_OPTC_UNDERFLOW_THRESHOLD__OPTC_UNDERFLOW_THRESHOLD__SHIFT                                        0x0
 #define ODM3_OPTC_UNDERFLOW_THRESHOLD__OPTC_UNDERFLOW_THRESHOLD_MASK                                          0x01FFFFFFL
-- 
2.43.0

