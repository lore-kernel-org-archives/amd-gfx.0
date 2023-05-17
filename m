Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F633C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 11:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C619C10E401;
	Wed, 17 May 2023 11:40:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B11AB10E400
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 11:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOGPhdjRcoN/RenVpFjrpasiBpH6iuj0ohUgxx0WlUH7IuFJCMeEikuv6ehhhkvLxiU00tX6ISjIpmPoEKIjF3wzj3BDtgnsSbYw3VCDw5LvZF+s7xeagBDngDT8FJItPO0oYHx5h0y8siUhjDW6wNC78/IiWsPS7Z67bmve9vWJTPZBJCZcOwlCR29G5exz/8W2NmyuWwjeVUSdG5mkRJfqOsAEhyCJkE5g/bGoZpUmmZZuJL2oxFhaCt+48XtKSJ+yeziMViekgguKPBECVQ8yvNBr/owMUE7QVoVnIfiRAZbuOOx+qTvDQPpaLTtXoIyXeoghxgb+KY459UQ4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0hP98BJOgnfUZxS9iBcU/IGH5Z5+nsCKyIuSO3AkBM=;
 b=fPhcozwUOkZtEMFNyop029rMop33ebYGH9qh6nrclLjVGEhs8te0fVqF/sQ4c9pdyc0bkWf/ciHrU9vsDDz4DNjcqFMHjZpkZwaMGeSZuoxPL1gjYsymN00TGds28iCh8gLou3+LHOawLcFqwIZVOkDpKk1n3VxpP+x9k91P3iQ+hvTlPBm/c9TOKxfQxsmFOFmbOM0whSKwUrEO5zYIGbw+NuSiFBFQ8GMNaSJ9TXEDl6hisMuvOb3lH6vbDi/ko0W+LB0ogKxCh5NY4PcDNS3+phrvwsUmkr5VM3FBMVeGJUdTVrbl4C3E12vMnTvNOs2VVrxjfusudA1mzaZwow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0hP98BJOgnfUZxS9iBcU/IGH5Z5+nsCKyIuSO3AkBM=;
 b=3FSrNqq3ALeUV3asLAUo8n757DcjGYUrmmXa1xS5Q8R5bGanSro5nHANDhtZqKrhdcRDFTlZxqTtShO1BNdSnxpz8SoPc1bCK2A6nquhOXAvAviLQzQK6XCblDYLY4TBmQFNPX0zN/XMLPsvqI75neWAWZdhzWad1LeXUiuB7GM=
Received: from DS7P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::16) by
 MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.17; Wed, 17 May 2023 11:40:25 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::4f) by DS7P222CA0020.outlook.office365.com
 (2603:10b6:8:2e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Wed, 17 May 2023 11:40:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 11:40:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:40:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:40:14 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 06:40:09 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/18] drm/amd/display: Update correct DCN314 register header
Date: Wed, 17 May 2023 19:37:19 +0800
Message-ID: <20230517113723.1757259-15-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
References: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 01430e31-022c-42e0-34e0-08db56cb8145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nEpSfV9RdsGUZYjF3YNb3k4ebfw2RTA8SSGYEjJsgLgOxtB3VkqXHK4+ONp4U4INzX2jkCpYlTPqrXzNoyA+izxcEnXpVmvOhAG3+6m8krdKt9Vk2H2tTbbNhCzaXKNb5kzExpy/5foNZZyqWs6Ni8o7HMejohPQ8zbnj8eBr1pB67MbwGzuN716E4zamCGIWpazNsXVQGshjMpPvEaxZZriF04ef/AdVdO/Nc7o7AmLQ6tAHx4RX41Casb5Oqww2GWcmhanCQl7UMpaTt9T3zJLy6QSr54Fo2xV9ZIgHTw8+obCZm8UN63txt0Lu9F5LO1PAFXgISJyRyUL3mJBHXx67h/PT1bLsGffQb5bo3daDchB7HCyLkjNnFXBPOtIoVgieL2rpjN4CR/tU2GtPR4OMvFXzVvmgqrgAwqB5uPoVEIQOgH5Yb8s8bS8M/4zuM5sLcX9h00t4B606Oi/cr3WinmO/bQQA283/ixn6NNFOFy/UszbI/o3bOqIQKGvUuWgN9fpnWCDLoLFUyH+ss16pjUNuDB9kO7k6YJIWp2ENAtCkJPMQfEmSYLp6OUtV4aVSJ7WV/MgxitSlRVuyH98YBallIOp0wYQzLU/9IcIXF+lBMHUfDo3hiTfs9Q9zSvyNM23k3+Sdrzv4f5oiq6Cd3Q1sRlTbAC8II7zpdT92k3sXsN6QVUSPvucl9dtLBJmwhjinG5cvBgV7m/3+7YBUVBNUtBKuzJrXVZSrzg8rId7eGu6smDOniCr5J+e6j4QwZuAG+asz94FOEsMnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(36756003)(86362001)(7696005)(54906003)(70586007)(70206006)(6916009)(4326008)(316002)(478600001)(6666004)(40480700001)(82310400005)(8936002)(8676002)(5660300002)(41300700001)(15650500001)(2906002)(81166007)(356005)(82740400003)(2616005)(336012)(426003)(26005)(186003)(36860700001)(1076003)(83380400001)(47076005)(66899021)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:40:24.9422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01430e31-022c-42e0-34e0-08db56cb8145
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Cruise Hung <cruise.hung@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Cruise Hung <cruise.hung@amd.com>

[Why]
The register header for DCN314 is not correct.

[How]
Update correct DCN314 register header.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Cruise Hung <cruise.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/Makefile |  2 +-
 .../drm/amd/display/dmub/src/dmub_dcn314.c    | 62 +++++++++++++++++++
 .../drm/amd/display/dmub/src/dmub_dcn314.h    | 33 ++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  5 +-
 4 files changed, 100 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h

diff --git a/drivers/gpu/drm/amd/display/dmub/src/Makefile b/drivers/gpu/drm/amd/display/dmub/src/Makefile
index 0589ad4778ee..caf095aca8f3 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/Makefile
+++ b/drivers/gpu/drm/amd/display/dmub/src/Makefile
@@ -22,7 +22,7 @@
 
 DMUB = dmub_srv.o dmub_srv_stat.o dmub_reg.o dmub_dcn20.o dmub_dcn21.o
 DMUB += dmub_dcn30.o dmub_dcn301.o dmub_dcn302.o dmub_dcn303.o
-DMUB += dmub_dcn31.o dmub_dcn315.o dmub_dcn316.o
+DMUB += dmub_dcn31.o dmub_dcn314.o dmub_dcn315.o dmub_dcn316.o
 DMUB += dmub_dcn32.o
 
 AMD_DAL_DMUB = $(addprefix $(AMDDALPATH)/dmub/src/,$(DMUB))
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
new file mode 100644
index 000000000000..48a06dbd9be7
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
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
+#include "dmub_dcn314.h"
+
+#include "dcn/dcn_3_1_4_offset.h"
+#include "dcn/dcn_3_1_4_sh_mask.h"
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
+const struct dmub_srv_dcn31_regs dmub_srv_dcn314_regs = {
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
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
new file mode 100644
index 000000000000..674267a2940e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
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
+#ifndef _DMUB_DCN314_H_
+#define _DMUB_DCN314_H_
+
+#include "dmub_dcn31.h"
+
+extern const struct dmub_srv_dcn31_regs dmub_srv_dcn314_regs;
+
+#endif /* _DMUB_DCN314_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index ea3bed70a229..9e9a6a44a7ac 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -32,6 +32,7 @@
 #include "dmub_dcn302.h"
 #include "dmub_dcn303.h"
 #include "dmub_dcn31.h"
+#include "dmub_dcn314.h"
 #include "dmub_dcn315.h"
 #include "dmub_dcn316.h"
 #include "dmub_dcn32.h"
@@ -225,7 +226,9 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 	case DMUB_ASIC_DCN314:
 	case DMUB_ASIC_DCN315:
 	case DMUB_ASIC_DCN316:
-		if (asic == DMUB_ASIC_DCN315)
+		if (asic == DMUB_ASIC_DCN314)
+			dmub->regs_dcn31 = &dmub_srv_dcn314_regs;
+		else if (asic == DMUB_ASIC_DCN315)
 			dmub->regs_dcn31 = &dmub_srv_dcn315_regs;
 		else if (asic == DMUB_ASIC_DCN316)
 			dmub->regs_dcn31 = &dmub_srv_dcn316_regs;
-- 
2.25.1

