Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE1FC48BC3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED8A810E0AD;
	Wed, 14 Feb 2024 18:40:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iGJNevv0";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6401410E182
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:40:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAdWgTUzrgR+hb3llC1ywC9JgB9ePc8xunphZpb3E8pM0cUIylBfJq4PeIx096QuTedrwpg5gJvPMrRUwTB/+AwArkrdzB0Ww2bmgUuEMcCl+8wtjHHPWJ9qp/0biZorDXk/5Z1fTN06yHRVm1znzs2S4p7GmAFwWSUK/ovBvaU7OJvapQtJPKkAC/CECBHhiEzSTKGtCq+5+WCmKnfZQKYTCyHIYq190Tk3XO44cYIB0WHVsaz3L1k/HgwKTA/BZ7XVviZI/jucyeYvsHaOA3ZT/xt9yAZfQ16dhikhZHNk56yFrE6OYYdPOUOXDSmhY1vqLuZ2LEYKSO6XA5ZiQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abwC4IaYQqG1q06lhOwLc2jCpuv+0bSpcmj8KvltuVM=;
 b=I2pcBn9QtYrDyYyvSaKsTH+dWZ4Nk00+Po9Kw2ID51iL4O0WHs0UHVFSkUfYMu7yEJwdaBsFe1r5yK1OvImbCzQrlJ3cBXmrNCuBB5CrlqTwbq8lnpwosfSRJKWI+5LSI5oFnm+vZo1hfJcQo88X/SdAkjLWmqfXjAqo6PqcmY7sywHkNfbYPry2liBOhSZjm9MHkxnk2PxWLwo2jUbe4o1/bgMrlzSYSkr66qL85NUL9asvUurUKiTWX0SbtYfCohhW+dNONCFPOxnJCjk4LS4VKvJK2LAruDVzBWJm70FrHHsdA0EopsMM/Yxv4q2DAiNCMw+FLEnUA3eHRg9SEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abwC4IaYQqG1q06lhOwLc2jCpuv+0bSpcmj8KvltuVM=;
 b=iGJNevv0mqFc5JGvkL/xUeXlrSwqiePEoUSexVZS0Y1k10wfa1Bv0LRojoxrDZzqHQJshur7tMTB+Zpr/gRVCc2/WIS2DYPyZ2E68YNxB0fjYXJj5/Xu5TRwadoos5vnS2wmDMVnE8iMzF3cKDxYXnKOqMohSNk2nl6DJO+r7DQ=
Received: from CH0PR03CA0297.namprd03.prod.outlook.com (2603:10b6:610:e6::32)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 18:40:36 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::51) by CH0PR03CA0297.outlook.office365.com
 (2603:10b6:610:e6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 18:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 18:40:36 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:40:34 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 04/17] drm/amd/display: Add SMU timeout check and retry
Date: Wed, 14 Feb 2024 11:38:35 -0700
Message-ID: <20240214184006.1356137-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: e43a9efd-7bc4-4742-37f3-08dc2d8c6f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 947AouSYyvAScNt4jGH6jFKQe2jCSAY3KVUFD8AvbFD5MM4XL8Id/OFm6TK9s1j/iawqERhcwSDHCilP/0OB/KXh9bOZ0yf09JrQKO3sdhNOIArC0rdT8h/wQGfGLXLPyVipmrzvgGSsLNINxOQUgpgCnBkxQVbICJCusqIV2SvSK1dxfEPxd+FdkGEDhP4sB+BXKk3vK6+yywYLN2VPF1GkLSSYHUGNAENdp6T8KNuhfym7Y9NTBn82hLQwlSiVrdR4PHuTjNnq9cnJAEh/dpxTUZqbQa1CmR4w6UKdOzl0V+dfF/7d00nj58lU2CKV6gLfMUXnkWBv1rrd5UtFvHyar7GE8JtRmPI/rZ0KzXWtgOuLpp+dFJBkD1rz+EgYMeBOCAIOB0OqWRqSPKOneF9HDXV8goGY07mZoADp5LL90EG6wvjVRhq1SUR4x/95VdQa/a93aQdo++lSkv7Ed7G+n4viyq0IPDlaK53BDw13CVj0cePV9qB1DKF+8cXRmu2+8qFnhdXaaTxvud83Ir+vZiMYdjiS7XYmhzBwCOAZIZb2wEiSq5k8RINfJBY90AjmUSh82DaAm8BFaMKLHDML1c5xsyY1orR0tav4/DI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(40470700004)(46966006)(36840700001)(41300700001)(5660300002)(336012)(82740400003)(2906002)(316002)(36756003)(4326008)(26005)(70206006)(426003)(16526019)(478600001)(70586007)(8676002)(2616005)(8936002)(1076003)(356005)(86362001)(81166007)(83380400001)(54906003)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:40:36.1057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e43a9efd-7bc4-4742-37f3-08dc2d8c6f11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419
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

Instead of only asserting in the case of the SMU wait time is not what
we expect, add the SMU timeout check and try again.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   | 11 ++++++++---
 .../drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c    |  6 +++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
index d72acbb049b1..23b390245b5d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
@@ -26,6 +26,10 @@
 #include "core_types.h"
 #include "clk_mgr_internal.h"
 #include "reg_helper.h"
+#include "dm_helpers.h"
+
+#include "rn_clk_mgr_vbios_smu.h"
+
 #include <linux/delay.h>
 
 #include "renoir_ip_offset.h"
@@ -33,8 +37,6 @@
 #include "mp/mp_12_0_0_offset.h"
 #include "mp/mp_12_0_0_sh_mask.h"
 
-#include "rn_clk_mgr_vbios_smu.h"
-
 #define REG(reg_name) \
 	(MP0_BASE.instance[0].segment[mm ## reg_name ## _BASE_IDX] + mm ## reg_name)
 
@@ -120,7 +122,10 @@ static int rn_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
 
 	result = rn_smu_wait_for_response(clk_mgr, 10, 200000);
 
-	ASSERT(result == VBIOSSMC_Result_OK || result == VBIOSSMC_Result_UnknownCmd);
+	if (IS_SMU_TIMEOUT(result)) {
+		ASSERT(0);
+		dm_helpers_smu_timeout(CTX, msg_id, param, 10 * 200000);
+	}
 
 	/* Actual dispclk set is returned in the parameter register */
 	return REG_READ(MP1_SMN_C2PMSG_83);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
index 19e5b3be9275..b4fb17b7a096 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 
 #include "dcn301_smu.h"
+#include "dm_helpers.h"
 
 #include "vangogh_ip_offset.h"
 
@@ -120,7 +121,10 @@ static int dcn301_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
 
 	result = dcn301_smu_wait_for_response(clk_mgr, 10, 200000);
 
-	ASSERT(result == VBIOSSMC_Result_OK);
+	if (IS_SMU_TIMEOUT(result)) {
+		ASSERT(0);
+		dm_helpers_smu_timeout(CTX, msg_id, param, 10 * 200000);
+	}
 
 	/* Actual dispclk set is returned in the parameter register */
 	return REG_READ(MP1_SMN_C2PMSG_83);
-- 
2.43.0

