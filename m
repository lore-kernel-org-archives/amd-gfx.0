Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D375FC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 21:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F6D010E55C;
	Tue, 15 Feb 2022 21:45:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D29689F24
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 21:45:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMoCcUGGomdC1lILflPuCDINusrcKYzV7Wc+FJSp1AYvjoFKYlR+PBPsDwO0ZwjMyvjEGf+SXoDuqmOpT5Kk4ZpdF19RucyWvUk182GwxsfGj+/Xt1BM0MXM+x19TP9uCXaYeOqIBJq7NHLSoCJJ2Zrmk7ftlgAPGDBXIq7HXdgb5GRmH2bS/0H8tIgtnD9WwsmBLFboOo0rPaAT40i4mjKT/Ypw4mMjr7FuJqH0P9geyMh26jf0/yhDnDvemlpQO4Lq1BkAJeo9aybUYlMpBX7Fv0QbsLy6jol1lQGGWAxXLizlxhTZKpxmw7kfUfLiwdaJO3vHqF4bzRaQm9PCyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElUfDD4SjY+8u2VfIO3eb2GHajqBxI3NuKFLdZY3YhM=;
 b=HzaOfI3DhPQ993GqMpHaYJZiPukYNsuL0XKkQsIs/UA1YUU+OjOimPt/g+6qVzRaQURLPSf6NeN/UMRhia0N4EQ195cBYz6SM1g7mm6ulOS/EAfScoWJE6ORi0JmUQcqPlWcG3clBc1ka8pMIwO8/XhVrtOUs2psqcEBrfF5GhvCT4qs1Au9md8mWnRjNbADRwe8K3RFaYtwQNS8MYMFLYdEYWXVx112+F0NWUtV3Tm+Az/joDzGuK8FAG5pg9IyOEQPqyrCH86GjSiDAxnahV+y1QKv17zLaL6GXE5tIPlYa/oPYCwlOLQfsQjY/PDya3bN2vSlZAJFrUHB86Jh4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElUfDD4SjY+8u2VfIO3eb2GHajqBxI3NuKFLdZY3YhM=;
 b=KgJX9EKTvEqwB1qaXsEh9RHX222yYy+DvzeF6hWTgkP71xTFlzBPoDsn7Cv0XpiBjzwDxX1AfDQPLDAwlFfO+Rgo1/Nj+ptRAnyYi5BOxQip7BD1eesTrRJccGhRg9Fu68L2am/JWgvIJ9am7fkO7svjjJ05j3f/u6wl5WOOvVg=
Received: from BN9PR03CA0242.namprd03.prod.outlook.com (2603:10b6:408:ff::7)
 by BY5PR12MB3940.namprd12.prod.outlook.com (2603:10b6:a03:1a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Tue, 15 Feb
 2022 21:45:09 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::a4) by BN9PR03CA0242.outlook.office365.com
 (2603:10b6:408:ff::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Tue, 15 Feb 2022 21:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 21:45:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 15:45:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] drm/amd/display: Add DMUB support for DCN316
Date: Tue, 15 Feb 2022 16:44:45 -0500
Message-ID: <20220215214447.2234978-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215214447.2234978-1-alexander.deucher@amd.com>
References: <20220215214447.2234978-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 709bdd0f-7635-419e-2ace-08d9f0cc7047
X-MS-TrafficTypeDiagnostic: BY5PR12MB3940:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3940D0C898E8ADEF2B1D22CBF7349@BY5PR12MB3940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EO808jXbEgj9mCDOILaV2qnPL90j6xtltfxYs9+y/HyvSx+8Peoym5fiKjP+IVw4Q6IKhZWEM8YpXlKU/YbT9Fbxb4ir8ErKvNNpCFQMvKhpUCs7KECXISqKEH7qcB0f4CDd9XLTjuwRYuJZe/fUyP/DYTXRVCFPVX007DBYrLOt5df/fXiYJ3fcircgFLUy8asCBrmjZ8IzCw7sWWMOS3PhhsENmtN8EhP3FukUcf/vBdF8M9zb9Lif/245zky4+rCHWEm/HAnndaqamsKfCViKFDb5R7v7f78L4TH4q3n5/cyvi8XestijNJLhFICEX0ZwbIH/iDEt6NbWOX6up05wHVez2mYI2l8PExbeEhAnuyekVdeD2/RUZW3RK4x+5vI7EPIsruWgxRtwbTM6qUHTMXi5+cjtIGKsQ+iz5BoRa/ZE1H2YTZsG/rz32ILfGDM9yW+n7tb4K2luqLMpGMvieE0Y0AVzdcMnP44AHmOVkNX4x1PyvDzpDpZ43Mf0D/83A2VYNkkRPWYozzZrZ6Wk36z7qyIy5flp45kPrloGIxNO47EvNWZZoun4YQ0VZNFFcNb9ap7VbPVlEXtq/8g7yLY19LMZw57b/zwFxBVN95FkmzD4iFMm6SDekLEMW5dwrN9x9cdCLKM65wIhzY+uDQ9U+K4sBfXUJqvoJcffq/2igYCW5bWvWsxPvDNxYUqSf50CeuEMHF7HZb0jSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(54906003)(86362001)(8676002)(4326008)(70586007)(8936002)(5660300002)(47076005)(82310400004)(70206006)(81166007)(40460700003)(83380400001)(356005)(316002)(186003)(1076003)(6666004)(16526019)(26005)(7696005)(426003)(336012)(2616005)(36756003)(508600001)(2906002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 21:45:09.6717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 709bdd0f-7635-419e-2ace-08d9f0cc7047
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3940
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
Cc: Leo Li <sunpeng.li@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

Initialize DMUB for DCN316. Use same funcs as DCN31 for
DCN316.

Acked-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 drivers/gpu/drm/amd/display/dmub/src/Makefile |  2 +
 .../drm/amd/display/dmub/src/dmub_dcn316.c    | 62 +++++++++++++++++++
 .../drm/amd/display/dmub/src/dmub_dcn316.h    | 33 ++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  4 ++
 6 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn316.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn316.h

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a4254357bf5f..4b2cb9bdc3d2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1920,7 +1920,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		fw_name_dmub = FIRMWARE_YELLOW_CARP_DMUB;
 		break;
 	case IP_VERSION(3, 1, 6):
-		dmub_asic = DMUB_ASIC_DCN31B;
+		dmub_asic = DMUB_ASIC_DCN316;
 		fw_name_dmub = FIRMWARE_DCN316_DMUB;
 		break;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 83855b8a32e9..821d3fb1f824 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -98,6 +98,7 @@ enum dmub_asic {
 	DMUB_ASIC_DCN303,
 	DMUB_ASIC_DCN31,
 	DMUB_ASIC_DCN31B,
+	DMUB_ASIC_DCN316,
 	DMUB_ASIC_MAX,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/Makefile b/drivers/gpu/drm/amd/display/dmub/src/Makefile
index 0495bcdd3463..21e818862072 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/Makefile
+++ b/drivers/gpu/drm/amd/display/dmub/src/Makefile
@@ -22,7 +22,9 @@
 
 DMUB = dmub_srv.o dmub_srv_stat.o dmub_reg.o dmub_dcn20.o dmub_dcn21.o
 DMUB += dmub_dcn30.o dmub_dcn301.o dmub_dcn302.o dmub_dcn303.o
+
 DMUB += dmub_dcn31.o
+DMUB += dmub_dcn316.o
 
 AMD_DAL_DMUB = $(addprefix $(AMDDALPATH)/dmub/src/,$(DMUB))
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn316.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn316.c
new file mode 100644
index 000000000000..c43d1e3819e0
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn316.c
@@ -0,0 +1,62 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "../dmub_srv.h"
+#include "dmub_reg.h"
+#include "dmub_dcn316.h"
+
+#include "dcn/dcn_3_1_6_offset.h"
+#include "dcn/dcn_3_1_6_sh_mask.h"
+
+#define DCN_BASE__INST0_SEG0                       0x00000012
+#define DCN_BASE__INST0_SEG1                       0x000000C0
+#define DCN_BASE__INST0_SEG2                       0x000034C0
+#define DCN_BASE__INST0_SEG3                       0x00009000
+#define DCN_BASE__INST0_SEG4                       0x02403C00
+#define DCN_BASE__INST0_SEG5                       0
+
+#define BASE_INNER(seg) DCN_BASE__INST0_SEG##seg
+#define CTX dmub
+#define REGS dmub->regs_dcn31
+#define REG_OFFSET_EXP(reg_name) (BASE(reg##reg_name##_BASE_IDX) + reg##reg_name)
+
+/* Registers. */
+
+const struct dmub_srv_dcn31_regs dmub_srv_dcn316_regs = {
+#define DMUB_SR(reg) REG_OFFSET_EXP(reg),
+	{
+		DMUB_DCN31_REGS()
+		DMCUB_INTERNAL_REGS()
+	},
+#undef DMUB_SR
+
+#define DMUB_SF(reg, field) FD_MASK(reg, field),
+	{ DMUB_DCN31_FIELDS() },
+#undef DMUB_SF
+
+#define DMUB_SF(reg, field) FD_SHIFT(reg, field),
+	{ DMUB_DCN31_FIELDS() },
+#undef DMUB_SF
+};
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn316.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn316.h
new file mode 100644
index 000000000000..9e7d109129ea
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn316.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef _DMUB_DCN316_H_
+#define _DMUB_DCN316_H_
+
+#include "dmub_dcn31.h"
+
+extern const struct dmub_srv_dcn31_regs dmub_srv_dcn316_regs;
+
+#endif /* _DMUB_DCN316_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 9280f2abd973..db2802a14f95 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -32,6 +32,7 @@
 #include "dmub_dcn302.h"
 #include "dmub_dcn303.h"
 #include "dmub_dcn31.h"
+#include "dmub_dcn316.h"
 #include "os_types.h"
 /*
  * Note: the DMUB service is standalone. No additional headers should be
@@ -220,7 +221,10 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 
 	case DMUB_ASIC_DCN31:
 	case DMUB_ASIC_DCN31B:
+	case DMUB_ASIC_DCN316:
 		dmub->regs_dcn31 = &dmub_srv_dcn31_regs;
+		if (asic == DMUB_ASIC_DCN316)
+			dmub->regs_dcn31 = &dmub_srv_dcn316_regs;
 		funcs->reset = dmub_dcn31_reset;
 		funcs->reset_release = dmub_dcn31_reset_release;
 		funcs->backdoor_load = dmub_dcn31_backdoor_load;
-- 
2.34.1

