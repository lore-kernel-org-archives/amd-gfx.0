Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E24FC433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Feb 2022 18:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB19B10E1AC;
	Thu,  3 Feb 2022 18:59:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67D9010E1AC
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Feb 2022 18:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmSrdPzNEm6hrkFJ5HpkaegwQyQzd8juYv3rmG/Kwsg1wFnurfR3QDGQWomWEm33qbsXyAGc+AX+O+6QMlhWfzGozYwFovigtPOwg4EUGoe1LP4bxNUILjlG3fvwt2PoEBqPwHnxHe6CJBW64SSL+ohVh3Na4uXscssHHWSQcb8DQpQbbsThoLNSfpM6/t910Ro1JK0WnjNWYGuidpd4s1RTvF1ogavdeiC/bm4+Yb70jjWLVSIwsLwUMqoS0fROzVhGI+rsXFINcSzdBgoFSZXPuvDKVJkaBjeEY6FSmVX9g0pjh+Xw/siXFnB4afVjSkH89D3D5e3BVjuqx/fg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOvAEuuvDISSHX2LWcF+V/cnb3wUahd5nFJ4NUYkTBI=;
 b=ls532/uxOYTrq5NLfZxv8RgplhkJyxNMvWPthUJBoG+u5PSISOqP8caBy5dDVU2klOhcptCBCtnPDAc6H3XtGkrQvT7wnbNH0F4c3+RCTt+7jyxtailpxjBIW8UKj9jvRYkUj09IRoAtVgYx9RJbv72ciVP34vtMr2W2bwxRxsiwTIiiS3I4grxMXo82bYiP1xLYg7xAP0HOxL+jTpULdSN0yfiRZYpUdgXiRxIQvVWoUSuyZfHKJrDuzjChHFGDqYxW7DsUyE1CBmDNJ87oDRQGMbXT5VoIcuTFbd24hfI69Loe9l7zwrkLCoKy0obhV4mAhw56V6w4Ar6jHaVgXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOvAEuuvDISSHX2LWcF+V/cnb3wUahd5nFJ4NUYkTBI=;
 b=vZix0a3SCBWxZ7SvfUcDobsdULJ2U5ONwoE0TTsubNtoNZdvpsOusWB8+a4tONNyqOo4Fi6HdnfwMbiM3q+oqJhFDk477dpgjLFg7gNcw1etbf5I0huTY5HaM3qwZ60dEcbCIHaY+YMC1UinNNtSG1gLneOd5HXbCLlwCTg0cvo=
Received: from MW4PR04CA0270.namprd04.prod.outlook.com (2603:10b6:303:88::35)
 by BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Thu, 3 Feb
 2022 18:59:07 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::b7) by MW4PR04CA0270.outlook.office365.com
 (2603:10b6:303:88::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11 via Frontend
 Transport; Thu, 3 Feb 2022 18:59:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 18:59:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 12:59:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: move dpcs_3_0_0 headers from dcn to dpcs
Date: Thu, 3 Feb 2022 13:58:46 -0500
Message-ID: <20220203185847.1473998-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203185847.1473998-1-alexander.deucher@amd.com>
References: <20220203185847.1473998-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4906bdad-c24f-4c22-85a5-08d9e74740c0
X-MS-TrafficTypeDiagnostic: BN9PR12MB5273:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB527340D0C110297B4EC1C06DF7289@BN9PR12MB5273.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:82;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16EbjOO7wbW88sgQIs41SGEQAzkN0iYqorPrOrMLg+/UnlmbeMd0KC7RwEc/enmRqn+6SZyagVXfPIiuZWKX+anIIy0QHq2LoMuVGZH4Jde8LkDw+/CCzDAsVnxN58NH2VBSPslQkJM9CZiNGo5lgt6QODSxBVly2n1/vKuXkF/aOc0MyPEJZh9/VMpbDn+GDbsg9udxf3kDmq0ggfqRe/k6nw2lrQTm8s2gtoiooLMV6AQBoutTn2uTV6EWVxRLSClxMICwZvIiKWjqn+8nWqD2l9ywCP2zkdxlMCOz5HYADn5fuzmzg6hMd3Z5A0CgY8iRjlawyD4xcU+wxiV3x5Rtwl1NG+MnVKikcIcpAe00q/2t/jvoRXzUtlex7qMmDvuxJZVdRlL72NyAHr4FO5cttveyzy/O6u/SIYJLk4ylykkNyKNO6Gg3HTJCNXFmv/pK78kKFQQy5+bYpPM+zQgVhFsA0f0nsq6SUPMDp7+cnkzYLD4rpcS9LEItV4pwF+YGUPBb+vQt6oIz9QIBLsB7p2CLZTXJuYjfCoA7NAVodVEOFqlv1BWZoV99hCgfyWjUolLRfvPtbTcs9jndPebAi1TTeH3sMi2dY+gHSpIa83mJwRcFyn3edYkAcatpMtqQ+UN14yubqCRjB8lvZ/EGpp0KLp/4371vylsXQj0EsE0HJPR0+BZAkCVPOUDBJzA+nwOFJ7md8E6QgzL4Dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(426003)(316002)(336012)(4326008)(7696005)(70206006)(26005)(1076003)(16526019)(8676002)(186003)(70586007)(2906002)(2616005)(36756003)(83380400001)(40460700003)(47076005)(6666004)(6916009)(8936002)(508600001)(5660300002)(36860700001)(81166007)(356005)(86362001)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 18:59:06.2814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4906bdad-c24f-4c22-85a5-08d9e74740c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5273
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To align with other headers.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c         | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c       | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c       | 4 ++--
 drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c  | 4 ++--
 .../gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c    | 4 ++--
 drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c  | 4 ++--
 .../amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_0_offset.h    | 0
 .../amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_0_sh_mask.h   | 0
 9 files changed, 14 insertions(+), 14 deletions(-)
 rename drivers/gpu/drm/amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_0_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_0_sh_mask.h (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 0602bde78e6c..589131d415fd 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -42,8 +42,8 @@
 
 #include "nbio/nbio_7_4_offset.h"
 
-#include "dcn/dpcs_3_0_0_offset.h"
-#include "dcn/dpcs_3_0_0_sh_mask.h"
+#include "dpcs/dpcs_3_0_0_offset.h"
+#include "dpcs/dpcs_3_0_0_sh_mask.h"
 
 #include "mmhub/mmhub_2_0_0_offset.h"
 #include "mmhub/mmhub_2_0_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 8ca26383b568..f10f7a0ca02a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -72,8 +72,8 @@
 
 #include "nbio/nbio_7_4_offset.h"
 
-#include "dcn/dpcs_3_0_0_offset.h"
-#include "dcn/dpcs_3_0_0_sh_mask.h"
+#include "dpcs/dpcs_3_0_0_offset.h"
+#include "dpcs/dpcs_3_0_0_sh_mask.h"
 
 #include "mmhub/mmhub_2_0_0_offset.h"
 #include "mmhub/mmhub_2_0_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 5d9637b07429..4daf8931aa7c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -73,8 +73,8 @@
 
 #include "nbio/nbio_7_2_0_offset.h"
 
-#include "dcn/dpcs_3_0_0_offset.h"
-#include "dcn/dpcs_3_0_0_sh_mask.h"
+#include "dpcs/dpcs_3_0_0_offset.h"
+#include "dpcs/dpcs_3_0_0_sh_mask.h"
 
 #include "reg_helper.h"
 #include "dce/dmub_abm.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index e512ae6d00d4..88318e8ffca8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -66,8 +66,8 @@
 #include "dimgrey_cavefish_ip_offset.h"
 #include "dcn/dcn_3_0_2_offset.h"
 #include "dcn/dcn_3_0_2_sh_mask.h"
-#include "dcn/dpcs_3_0_0_offset.h"
-#include "dcn/dpcs_3_0_0_sh_mask.h"
+#include "dpcs/dpcs_3_0_0_offset.h"
+#include "dpcs/dpcs_3_0_0_sh_mask.h"
 #include "nbio/nbio_7_4_offset.h"
 #include "amdgpu_socbb.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
index 5f6ae3edb755..3b7df1ac26be 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
@@ -42,8 +42,8 @@
 
 #include "nbio/nbio_7_4_offset.h"
 
-#include "dcn/dpcs_3_0_0_offset.h"
-#include "dcn/dpcs_3_0_0_sh_mask.h"
+#include "dpcs/dpcs_3_0_0_offset.h"
+#include "dpcs/dpcs_3_0_0_sh_mask.h"
 
 #include "mmhub/mmhub_2_0_0_offset.h"
 #include "mmhub/mmhub_2_0_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c
index 0046219a1cc7..6b6b7c7bd12f 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c
@@ -40,8 +40,8 @@
 
 #include "nbio/nbio_7_4_offset.h"
 
-#include "dcn/dpcs_3_0_0_offset.h"
-#include "dcn/dpcs_3_0_0_sh_mask.h"
+#include "dpcs/dpcs_3_0_0_offset.h"
+#include "dpcs/dpcs_3_0_0_sh_mask.h"
 
 #include "mmhub/mmhub_2_0_0_offset.h"
 #include "mmhub/mmhub_2_0_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
index 914ce2ce1c2f..0b68c08fac3f 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
@@ -37,8 +37,8 @@
 
 #include "nbio/nbio_7_4_offset.h"
 
-#include "dcn/dpcs_3_0_0_offset.h"
-#include "dcn/dpcs_3_0_0_sh_mask.h"
+#include "dpcs/dpcs_3_0_0_offset.h"
+#include "dpcs/dpcs_3_0_0_sh_mask.h"
 
 #include "mmhub/mmhub_2_0_0_offset.h"
 #include "mmhub/mmhub_2_0_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_offset.h
similarity index 100%
rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h
rename to drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_offset.h
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_sh_mask.h
similarity index 100%
rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h
rename to drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_sh_mask.h
-- 
2.34.1

