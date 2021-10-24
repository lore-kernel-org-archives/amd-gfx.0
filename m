Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4033EC433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C1D6052B
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 14C1D6052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4292F6E0FE;
	Sun, 24 Oct 2021 13:32:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E6E989CAC
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+UwsUpYLzeJrWvuaO78An8h4aABAHZpo996mVEbV8BqQOEsFNVPXDhHaZ07KG/T+dJaID8UHDux2bP6CjdP6KdZPuA8nMCBB0o5Q8TGzFXKeYKXOa3Ph+9d1nGW3SKy0PpnhULHx91vPINLU6GXM6AlHGRxFe+STlYLhPPfpu1sF7M84HsEqZn+AT/t+W2W29cUC0hPTDiN9qWZS6tNCnsU3VksoXc6TXnegauPHyqQT/wKnveN+paFs1+x/xM1QXAh7MKU73y51gB5b7lpmYmt2m2DgvxoctrVozh4dCbJogQYsh9ET5aLDwz0zgbxZKskn5FwQOwohQc6kpe0ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sM6a/vm0uUxDjY/7tA8/+cCYmLWVQzJbsZwPynGjtyM=;
 b=Vh6pOf9JTtbAKRbY++BPWKRipnfWN1R+yJY0DFkP3YVksfY4r4oE+lrF+lVGx0ErdHqIIuRU7yiaVry/vIID4bzs4hfCmMvKIEhbsLNkQiOksKAl2sI5bckSKzbBmMByuJuSfwAkV+5+lX8Mlz9UqjupSvzK93Rk1uMXwX/oTLgzYE4hoNAO3ki0luTc6/btYIuZQp+Dtn3jyR+T2fqsADaJeWDsQzzykHHjDp9ogOqsjnYbAG7ZPCgwfADosrkmrfisPj9472KWsIHXOMM+skVUdp+CgQhBi23H3EEAq3+mDhmEK6loau3lxRb45BiGEnuYO76QosNJb5R4VU+IYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sM6a/vm0uUxDjY/7tA8/+cCYmLWVQzJbsZwPynGjtyM=;
 b=dOueGfNnk2OQk72rXkUyVmvstBtpH+4qmSl4PUMYuGYGdgCVTQIoEGLSSZQ/cVRDvVUhrIsWcmrgj/XkDMYBkFOW61YG2KHV3zEJgsK31EJEGqcC20I6HC9G3uW690WlG1+Aw0r8Wnv5ahlr+NKHz4Aj7s0b6EymoafddpDsFOA=
Received: from MWHPR1401CA0003.namprd14.prod.outlook.com
 (2603:10b6:301:4b::13) by BYAPR12MB3350.namprd12.prod.outlook.com
 (2603:10b6:a03:ab::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 13:32:18 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::30) by MWHPR1401CA0003.outlook.office365.com
 (2603:10b6:301:4b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:17 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:14 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Hersen Wu <hersenxs.wu@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 06/33] drm/amd/display: move FPU associated DSC code to DML
 folder
Date: Sun, 24 Oct 2021 09:31:14 -0400
Message-ID: <20211024133141.239861-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ea59285-c4a8-470f-ec78-08d996f2b2f0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3350:
X-Microsoft-Antispam-PRVS: <BYAPR12MB33506F8A9D9904930D3583A698829@BYAPR12MB3350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EniWz3FFIbMJFDmQ68dDcDQdCZC+7SNdXfZEOBB0gMdds3jrq8037ar3VqVM17+s9QVJIVHBS5ERh61X5HjrSO3Tcsv1R3dMTM8279X2eqCzit8AL28OZXDM7qYs3m+aEqb4hdRTKLe9/i6H1NUKvbLqSo4E5X0FwPDFPPZ+h39LvK32utr9vPO4b3rwslTqDVshtOWH6GHryoQllB8uqH69wBlpR4EzQoVVO2zm68pssogyQgBVC2xE150ummYaULoHOiC0Xltcjn0KIvsTpmHZy5CXW/KeOLL/RRzUcNjmnN09pcZCKnv8nMrm1a3DqqS1/QAawj99YbUVU1uPBhEKr3Jjxipkqhq9aKQZyVtRhGphoFgyizNymMbsOLYuk10i9IY82w3SszVhko98dzj2EI5jjDGBFyE52JVpSSK/uipoXgH42WcTV+0sZ4BfVRWY+xugzV+/mykk4CtpdQryP1LGAL/pt+WTQKZlr3E1k/6GSqbPULKNtkgR5bC37zHbu6SUrYQGa78g2QfLaI+a3TtqLANv5ik3QFpT1ImG8E5RXr8Q456YZc2sYdCW7Rys86sKMr8WJkF+T3uL7q+TF9kIBRXmKoFkfSc9x12A85XJdF+csVKk0cNLzUIJzJH68icq9lbvYhpn4SNNflLdX6zyeaX3n9bJgaPTDRzmU61HK9aRex858yVkWjiIrvJkTAVHgaaCYXo4wypfBdWbz+CoaBscafo+jNN3wuIepWIDmabeDwLO5c07II7BvgY5OeyhaTQl8gSqY1i4BQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(30864003)(2906002)(81166007)(83380400001)(966005)(5660300002)(47076005)(2616005)(336012)(86362001)(356005)(1076003)(6916009)(54906003)(70206006)(508600001)(4326008)(36860700001)(316002)(66574015)(16526019)(186003)(426003)(26005)(70586007)(36756003)(82310400003)(8676002)(8936002)(461764006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:17.6482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea59285-c4a8-470f-ec78-08d996f2b2f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3350
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

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why & How]
As part of the FPU isolation work documented in
https://patchwork.freedesktop.org/series/93042/, isolate code that uses
FPU in DSC to DML, where all FPU code should locate.

This change does not refactor any functions but move code around.

Cc: Christian König <christian.koenig@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Anson Jacob <Anson.Jacob@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Tested-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   3 +
 .../amd/display/dc/{ => dml}/dsc/qp_tables.h  |   0
 .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.c  | 291 ++++++++++++++++++
 .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.h  |  94 ++++++
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   |  29 --
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c  | 259 ----------------
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h  |  50 +--
 .../gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c  |   1 -
 8 files changed, 389 insertions(+), 338 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{ => dml}/dsc/qp_tables.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 169a4e68f86e..e7bb69ec99b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -70,6 +70,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) $(fram
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_rcflags)
@@ -84,6 +85,7 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_rcfla
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o  := $(dml_rcflags)
 endif
 CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
@@ -99,6 +101,7 @@ DML += dcn20/display_rq_dlg_calc_20v2.o dcn20/display_mode_vba_20v2.o
 DML += dcn21/display_rq_dlg_calc_21.o dcn21/display_mode_vba_21.o
 DML += dcn30/display_mode_vba_30.o dcn30/display_rq_dlg_calc_30.o
 DML += dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
+DML += dsc/rc_calc_fpu.o
 endif
 
 AMD_DAL_DML = $(addprefix $(AMDDALPATH)/dc/dml/,$(DML))
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/qp_tables.h b/drivers/gpu/drm/amd/display/dc/dml/dsc/qp_tables.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dsc/qp_tables.h
rename to drivers/gpu/drm/amd/display/dc/dml/dsc/qp_tables.h
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
new file mode 100644
index 000000000000..3ee858f311d1
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
@@ -0,0 +1,291 @@
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
+#include "rc_calc_fpu.h"
+
+#include "qp_tables.h"
+#include "amdgpu_dm/dc_fpu.h"
+
+#define table_hash(mode, bpc, max_min) ((mode << 16) | (bpc << 8) | max_min)
+
+#define MODE_SELECT(val444, val422, val420) \
+	(cm == CM_444 || cm == CM_RGB) ? (val444) : (cm == CM_422 ? (val422) : (val420))
+
+
+#define TABLE_CASE(mode, bpc, max)   case (table_hash(mode, BPC_##bpc, max)): \
+	table = qp_table_##mode##_##bpc##bpc_##max; \
+	table_size = sizeof(qp_table_##mode##_##bpc##bpc_##max)/sizeof(*qp_table_##mode##_##bpc##bpc_##max); \
+	break
+
+static int median3(int a, int b, int c)
+{
+	if (a > b)
+		swap(a, b);
+	if (b > c)
+		swap(b, c);
+	if (a > b)
+		swap(b, c);
+
+	return b;
+}
+
+static double dsc_roundf(double num)
+{
+	if (num < 0.0)
+		num = num - 0.5;
+	else
+		num = num + 0.5;
+
+	return (int)(num);
+}
+
+static double dsc_ceil(double num)
+{
+	double retval = (int)num;
+
+	if (retval != num && num > 0)
+		retval = num + 1;
+
+	return (int)retval;
+}
+
+static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_comp bpc,
+		       enum max_min max_min, float bpp)
+{
+	int mode = MODE_SELECT(444, 422, 420);
+	int sel = table_hash(mode, bpc, max_min);
+	int table_size = 0;
+	int index;
+	const struct qp_entry *table = 0L;
+
+	// alias enum
+	enum { min = DAL_MM_MIN, max = DAL_MM_MAX };
+	switch (sel) {
+		TABLE_CASE(444,  8, max);
+		TABLE_CASE(444,  8, min);
+		TABLE_CASE(444, 10, max);
+		TABLE_CASE(444, 10, min);
+		TABLE_CASE(444, 12, max);
+		TABLE_CASE(444, 12, min);
+		TABLE_CASE(422,  8, max);
+		TABLE_CASE(422,  8, min);
+		TABLE_CASE(422, 10, max);
+		TABLE_CASE(422, 10, min);
+		TABLE_CASE(422, 12, max);
+		TABLE_CASE(422, 12, min);
+		TABLE_CASE(420,  8, max);
+		TABLE_CASE(420,  8, min);
+		TABLE_CASE(420, 10, max);
+		TABLE_CASE(420, 10, min);
+		TABLE_CASE(420, 12, max);
+		TABLE_CASE(420, 12, min);
+	}
+
+	if (table == 0)
+		return;
+
+	index = (bpp - table[0].bpp) * 2;
+
+	/* requested size is bigger than the table */
+	if (index >= table_size) {
+		dm_error("ERROR: Requested rc_calc to find a bpp entry that exceeds the table size\n");
+		return;
+	}
+
+	memcpy(qps, table[index].qps, sizeof(qp_set));
+}
+
+static void get_ofs_set(qp_set ofs, enum colour_mode mode, float bpp)
+{
+	int   *p = ofs;
+
+	if (mode == CM_444 || mode == CM_RGB) {
+		*p++ = (bpp <=  6) ? (0) : ((((bpp >=  8) && (bpp <= 12))) ? (2) : ((bpp >= 15) ? (10) : ((((bpp > 6) && (bpp < 8))) ? (0 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (2 + dsc_roundf((bpp - 12) * (8 / 3.0))))));
+		*p++ = (bpp <=  6) ? (-2) : ((((bpp >=  8) && (bpp <= 12))) ? (0) : ((bpp >= 15) ? (8) : ((((bpp > 6) && (bpp < 8))) ? (-2 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (8 / 3.0))))));
+		*p++ = (bpp <=  6) ? (-2) : ((((bpp >=  8) && (bpp <= 12))) ? (0) : ((bpp >= 15) ? (6) : ((((bpp > 6) && (bpp < 8))) ? (-2 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
+		*p++ = (bpp <=  6) ? (-4) : ((((bpp >=  8) && (bpp <= 12))) ? (-2) : ((bpp >= 15) ? (4) : ((((bpp > 6) && (bpp < 8))) ? (-4 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-2 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
+		*p++ = (bpp <=  6) ? (-6) : ((((bpp >=  8) && (bpp <= 12))) ? (-4) : ((bpp >= 15) ? (2) : ((((bpp > 6) && (bpp < 8))) ? (-6 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-4 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
+		*p++ = (bpp <= 12) ? (-6) : ((bpp >= 15) ? (0) : (-6 + dsc_roundf((bpp - 12) * (6 / 3.0))));
+		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-2) : (-8 + dsc_roundf((bpp - 12) * (6 / 3.0))));
+		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-4) : (-8 + dsc_roundf((bpp - 12) * (4 / 3.0))));
+		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-6) : (-8 + dsc_roundf((bpp - 12) * (2 / 3.0))));
+		*p++ = (bpp <= 12) ? (-10) : ((bpp >= 15) ? (-8) : (-10 + dsc_roundf((bpp - 12) * (2 / 3.0))));
+		*p++ = -10;
+		*p++ = (bpp <=  6) ? (-12) : ((bpp >=  8) ? (-10) : (-12 + dsc_roundf((bpp -  6) * (2 / 2.0))));
+		*p++ = -12;
+		*p++ = -12;
+		*p++ = -12;
+	} else if (mode == CM_422) {
+		*p++ = (bpp <=  8) ? (2) : ((bpp >= 10) ? (10) : (2 + dsc_roundf((bpp -  8) * (8 / 2.0))));
+		*p++ = (bpp <=  8) ? (0) : ((bpp >= 10) ? (8) : (0 + dsc_roundf((bpp -  8) * (8 / 2.0))));
+		*p++ = (bpp <=  8) ? (0) : ((bpp >= 10) ? (6) : (0 + dsc_roundf((bpp -  8) * (6 / 2.0))));
+		*p++ = (bpp <=  8) ? (-2) : ((bpp >= 10) ? (4) : (-2 + dsc_roundf((bpp -  8) * (6 / 2.0))));
+		*p++ = (bpp <=  8) ? (-4) : ((bpp >= 10) ? (2) : (-4 + dsc_roundf((bpp -  8) * (6 / 2.0))));
+		*p++ = (bpp <=  8) ? (-6) : ((bpp >= 10) ? (0) : (-6 + dsc_roundf((bpp -  8) * (6 / 2.0))));
+		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-2) : (-8 + dsc_roundf((bpp -  8) * (6 / 2.0))));
+		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-4) : (-8 + dsc_roundf((bpp -  8) * (4 / 2.0))));
+		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-6) : (-8 + dsc_roundf((bpp -  8) * (2 / 2.0))));
+		*p++ = (bpp <=  8) ? (-10) : ((bpp >= 10) ? (-8) : (-10 + dsc_roundf((bpp -  8) * (2 / 2.0))));
+		*p++ = -10;
+		*p++ = (bpp <=  6) ? (-12) : ((bpp >= 7) ? (-10) : (-12 + dsc_roundf((bpp -  6) * (2.0 / 1))));
+		*p++ = -12;
+		*p++ = -12;
+		*p++ = -12;
+	} else {
+		*p++ = (bpp <=  6) ? (2) : ((bpp >=  8) ? (10) : (2 + dsc_roundf((bpp -  6) * (8 / 2.0))));
+		*p++ = (bpp <=  6) ? (0) : ((bpp >=  8) ? (8) : (0 + dsc_roundf((bpp -  6) * (8 / 2.0))));
+		*p++ = (bpp <=  6) ? (0) : ((bpp >=  8) ? (6) : (0 + dsc_roundf((bpp -  6) * (6 / 2.0))));
+		*p++ = (bpp <=  6) ? (-2) : ((bpp >=  8) ? (4) : (-2 + dsc_roundf((bpp -  6) * (6 / 2.0))));
+		*p++ = (bpp <=  6) ? (-4) : ((bpp >=  8) ? (2) : (-4 + dsc_roundf((bpp -  6) * (6 / 2.0))));
+		*p++ = (bpp <=  6) ? (-6) : ((bpp >=  8) ? (0) : (-6 + dsc_roundf((bpp -  6) * (6 / 2.0))));
+		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-2) : (-8 + dsc_roundf((bpp -  6) * (6 / 2.0))));
+		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-4) : (-8 + dsc_roundf((bpp -  6) * (4 / 2.0))));
+		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-6) : (-8 + dsc_roundf((bpp -  6) * (2 / 2.0))));
+		*p++ = (bpp <=  6) ? (-10) : ((bpp >=  8) ? (-8) : (-10 + dsc_roundf((bpp -  6) * (2 / 2.0))));
+		*p++ = -10;
+		*p++ = (bpp <=  4) ? (-12) : ((bpp >=  5) ? (-10) : (-12 + dsc_roundf((bpp -  4) * (2 / 1.0))));
+		*p++ = -12;
+		*p++ = -12;
+		*p++ = -12;
+	}
+}
+
+void _do_calc_rc_params(struct rc_params *rc,
+		enum colour_mode cm,
+		enum bits_per_comp bpc,
+		u16 drm_bpp,
+		bool is_navite_422_or_420,
+		int slice_width,
+		int slice_height,
+		int minor_version)
+{
+	float bpp;
+	float bpp_group;
+	float initial_xmit_delay_factor;
+	int padding_pixels;
+	int i;
+
+	dc_assert_fp_enabled();
+
+	bpp = ((float)drm_bpp / 16.0);
+	/* in native_422 or native_420 modes, the bits_per_pixel is double the
+	 * target bpp (the latter is what calc_rc_params expects)
+	 */
+	if (is_navite_422_or_420)
+		bpp /= 2.0;
+
+	rc->rc_quant_incr_limit0 = ((bpc == BPC_8) ? 11 : (bpc == BPC_10 ? 15 : 19)) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
+	rc->rc_quant_incr_limit1 = ((bpc == BPC_8) ? 11 : (bpc == BPC_10 ? 15 : 19)) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
+
+	bpp_group = MODE_SELECT(bpp, bpp * 2.0, bpp * 2.0);
+
+	switch (cm) {
+	case CM_420:
+		rc->initial_fullness_offset = (bpp >=  6) ? (2048) : ((bpp <=  4) ? (6144) : ((((bpp >  4) && (bpp <=  5))) ? (6144 - dsc_roundf((bpp - 4) * (512))) : (5632 - dsc_roundf((bpp -  5) * (3584)))));
+		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)((3 * bpc * 3) - (3 * bpp_group)));
+		rc->second_line_bpg_offset  = median3(0, 12, (int)((3 * bpc * 3) - (3 * bpp_group)));
+		break;
+	case CM_422:
+		rc->initial_fullness_offset = (bpp >=  8) ? (2048) : ((bpp <=  7) ? (5632) : (5632 - dsc_roundf((bpp - 7) * (3584))));
+		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)((3 * bpc * 4) - (3 * bpp_group)));
+		rc->second_line_bpg_offset  = 0;
+		break;
+	case CM_444:
+	case CM_RGB:
+		rc->initial_fullness_offset = (bpp >= 12) ? (2048) : ((bpp <=  8) ? (6144) : ((((bpp >  8) && (bpp <= 10))) ? (6144 - dsc_roundf((bpp - 8) * (512 / 2))) : (5632 - dsc_roundf((bpp - 10) * (3584 / 2)))));
+		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)(((3 * bpc + (cm == CM_444 ? 0 : 2)) * 3) - (3 * bpp_group)));
+		rc->second_line_bpg_offset  = 0;
+		break;
+	}
+
+	initial_xmit_delay_factor = (cm == CM_444 || cm == CM_RGB) ? 1.0 : 2.0;
+	rc->initial_xmit_delay = dsc_roundf(8192.0/2.0/bpp/initial_xmit_delay_factor);
+
+	if (cm == CM_422 || cm == CM_420)
+		slice_width /= 2;
+
+	padding_pixels = ((slice_width % 3) != 0) ? (3 - (slice_width % 3)) * (rc->initial_xmit_delay / slice_width) : 0;
+	if (3 * bpp_group >= (((rc->initial_xmit_delay + 2) / 3) * (3 + (cm == CM_422)))) {
+		if ((rc->initial_xmit_delay + padding_pixels) % 3 == 1)
+			rc->initial_xmit_delay++;
+	}
+
+	rc->flatness_min_qp     = ((bpc == BPC_8) ?  (3) : ((bpc == BPC_10) ? (7)  : (11))) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
+	rc->flatness_max_qp     = ((bpc == BPC_8) ? (12) : ((bpc == BPC_10) ? (16) : (20))) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
+	rc->flatness_det_thresh = 2 << (bpc - 8);
+
+	get_qp_set(rc->qp_min, cm, bpc, DAL_MM_MIN, bpp);
+	get_qp_set(rc->qp_max, cm, bpc, DAL_MM_MAX, bpp);
+	if (cm == CM_444 && minor_version == 1) {
+		for (i = 0; i < QP_SET_SIZE; ++i) {
+			rc->qp_min[i] = rc->qp_min[i] > 0 ? rc->qp_min[i] - 1 : 0;
+			rc->qp_max[i] = rc->qp_max[i] > 0 ? rc->qp_max[i] - 1 : 0;
+		}
+	}
+	get_ofs_set(rc->ofs, cm, bpp);
+
+	/* fixed parameters */
+	rc->rc_model_size    = 8192;
+	rc->rc_edge_factor   = 6;
+	rc->rc_tgt_offset_hi = 3;
+	rc->rc_tgt_offset_lo = 3;
+
+	rc->rc_buf_thresh[0] = 896;
+	rc->rc_buf_thresh[1] = 1792;
+	rc->rc_buf_thresh[2] = 2688;
+	rc->rc_buf_thresh[3] = 3584;
+	rc->rc_buf_thresh[4] = 4480;
+	rc->rc_buf_thresh[5] = 5376;
+	rc->rc_buf_thresh[6] = 6272;
+	rc->rc_buf_thresh[7] = 6720;
+	rc->rc_buf_thresh[8] = 7168;
+	rc->rc_buf_thresh[9] = 7616;
+	rc->rc_buf_thresh[10] = 7744;
+	rc->rc_buf_thresh[11] = 7872;
+	rc->rc_buf_thresh[12] = 8000;
+	rc->rc_buf_thresh[13] = 8064;
+}
+
+u32 _do_bytes_per_pixel_calc(int slice_width,
+		u16 drm_bpp,
+		bool is_navite_422_or_420)
+{
+	float bpp;
+	u32 bytes_per_pixel;
+	double d_bytes_per_pixel;
+
+	dc_assert_fp_enabled();
+
+	bpp = ((float)drm_bpp / 16.0);
+	d_bytes_per_pixel = dsc_ceil(bpp * slice_width / 8.0) / slice_width;
+	// TODO: Make sure the formula for calculating this is precise (ceiling
+	// vs. floor, and at what point they should be applied)
+	if (is_navite_422_or_420)
+		d_bytes_per_pixel /= 2;
+
+	bytes_per_pixel = (u32)dsc_ceil(d_bytes_per_pixel * 0x10000000);
+
+	return bytes_per_pixel;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h
new file mode 100644
index 000000000000..b93b95409fbe
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h
@@ -0,0 +1,94 @@
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
+#ifndef __RC_CALC_FPU_H__
+#define __RC_CALC_FPU_H__
+
+#include "os_types.h"
+#include <drm/drm_dsc.h>
+
+#define QP_SET_SIZE 15
+
+typedef int qp_set[QP_SET_SIZE];
+
+struct rc_params {
+	int      rc_quant_incr_limit0;
+	int      rc_quant_incr_limit1;
+	int      initial_fullness_offset;
+	int      initial_xmit_delay;
+	int      first_line_bpg_offset;
+	int      second_line_bpg_offset;
+	int      flatness_min_qp;
+	int      flatness_max_qp;
+	int      flatness_det_thresh;
+	qp_set   qp_min;
+	qp_set   qp_max;
+	qp_set   ofs;
+	int      rc_model_size;
+	int      rc_edge_factor;
+	int      rc_tgt_offset_hi;
+	int      rc_tgt_offset_lo;
+	int      rc_buf_thresh[QP_SET_SIZE - 1];
+};
+
+enum colour_mode {
+	CM_RGB,   /* 444 RGB */
+	CM_444,   /* 444 YUV or simple 422 */
+	CM_422,   /* native 422 */
+	CM_420    /* native 420 */
+};
+
+enum bits_per_comp {
+	BPC_8  =  8,
+	BPC_10 = 10,
+	BPC_12 = 12
+};
+
+enum max_min {
+	DAL_MM_MIN = 0,
+	DAL_MM_MAX = 1
+};
+
+struct qp_entry {
+	float         bpp;
+	const qp_set  qps;
+};
+
+typedef struct qp_entry qp_table[];
+
+u32 _do_bytes_per_pixel_calc(int slice_width,
+		u16 drm_bpp,
+		bool is_navite_422_or_420);
+
+void _do_calc_rc_params(struct rc_params *rc,
+		enum colour_mode cm,
+		enum bits_per_comp bpc,
+		u16 drm_bpp,
+		bool is_navite_422_or_420,
+		int slice_width,
+		int slice_height,
+		int minor_version);
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
index 8d31eb75c6a6..a2537229ee88 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
@@ -1,35 +1,6 @@
 # SPDX-License-Identifier: MIT
 #
 # Makefile for the 'dsc' sub-component of DAL.
-
-ifdef CONFIG_X86
-dsc_ccflags := -mhard-float -msse
-endif
-
-ifdef CONFIG_PPC64
-dsc_ccflags := -mhard-float -maltivec
-endif
-
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-endif
-
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-dsc_ccflags += -mpreferred-stack-boundary=4
-else
-dsc_ccflags += -msse2
-endif
-endif
-
-CFLAGS_$(AMDDALPATH)/dc/dsc/rc_calc.o := $(dsc_ccflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dsc/rc_calc.o := $(dsc_rcflags)
-
 DSC = dc_dsc.o rc_calc.o rc_calc_dpi.o
 
 AMD_DAL_DSC = $(addprefix $(AMDDALPATH)/dc/dsc/,$(DSC))
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
index 7b294f637881..b19d3aeb5962 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
@@ -23,266 +23,7 @@
  * Authors: AMD
  *
  */
-#include <drm/drm_dsc.h>
-
-#include "os_types.h"
 #include "rc_calc.h"
-#include "qp_tables.h"
-
-#define table_hash(mode, bpc, max_min) ((mode << 16) | (bpc << 8) | max_min)
-
-#define MODE_SELECT(val444, val422, val420) \
-	(cm == CM_444 || cm == CM_RGB) ? (val444) : (cm == CM_422 ? (val422) : (val420))
-
-
-#define TABLE_CASE(mode, bpc, max)   case (table_hash(mode, BPC_##bpc, max)): \
-	table = qp_table_##mode##_##bpc##bpc_##max; \
-	table_size = sizeof(qp_table_##mode##_##bpc##bpc_##max)/sizeof(*qp_table_##mode##_##bpc##bpc_##max); \
-	break
-
-
-static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_comp bpc,
-		       enum max_min max_min, float bpp)
-{
-	int mode = MODE_SELECT(444, 422, 420);
-	int sel = table_hash(mode, bpc, max_min);
-	int table_size = 0;
-	int index;
-	const struct qp_entry *table = 0L;
-
-	// alias enum
-	enum { min = DAL_MM_MIN, max = DAL_MM_MAX };
-	switch (sel) {
-		TABLE_CASE(444,  8, max);
-		TABLE_CASE(444,  8, min);
-		TABLE_CASE(444, 10, max);
-		TABLE_CASE(444, 10, min);
-		TABLE_CASE(444, 12, max);
-		TABLE_CASE(444, 12, min);
-		TABLE_CASE(422,  8, max);
-		TABLE_CASE(422,  8, min);
-		TABLE_CASE(422, 10, max);
-		TABLE_CASE(422, 10, min);
-		TABLE_CASE(422, 12, max);
-		TABLE_CASE(422, 12, min);
-		TABLE_CASE(420,  8, max);
-		TABLE_CASE(420,  8, min);
-		TABLE_CASE(420, 10, max);
-		TABLE_CASE(420, 10, min);
-		TABLE_CASE(420, 12, max);
-		TABLE_CASE(420, 12, min);
-	}
-
-	if (table == 0)
-		return;
-
-	index = (bpp - table[0].bpp) * 2;
-
-	/* requested size is bigger than the table */
-	if (index >= table_size) {
-		dm_error("ERROR: Requested rc_calc to find a bpp entry that exceeds the table size\n");
-		return;
-	}
-
-	memcpy(qps, table[index].qps, sizeof(qp_set));
-}
-
-static double dsc_roundf(double num)
-{
-	if (num < 0.0)
-		num = num - 0.5;
-	else
-		num = num + 0.5;
-
-	return (int)(num);
-}
-
-static double dsc_ceil(double num)
-{
-	double retval = (int)num;
-
-	if (retval != num && num > 0)
-		retval = num + 1;
-
-	return (int)retval;
-}
-
-static void get_ofs_set(qp_set ofs, enum colour_mode mode, float bpp)
-{
-	int   *p = ofs;
-
-	if (mode == CM_444 || mode == CM_RGB) {
-		*p++ = (bpp <=  6) ? (0) : ((((bpp >=  8) && (bpp <= 12))) ? (2) : ((bpp >= 15) ? (10) : ((((bpp > 6) && (bpp < 8))) ? (0 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (2 + dsc_roundf((bpp - 12) * (8 / 3.0))))));
-		*p++ = (bpp <=  6) ? (-2) : ((((bpp >=  8) && (bpp <= 12))) ? (0) : ((bpp >= 15) ? (8) : ((((bpp > 6) && (bpp < 8))) ? (-2 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (8 / 3.0))))));
-		*p++ = (bpp <=  6) ? (-2) : ((((bpp >=  8) && (bpp <= 12))) ? (0) : ((bpp >= 15) ? (6) : ((((bpp > 6) && (bpp < 8))) ? (-2 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
-		*p++ = (bpp <=  6) ? (-4) : ((((bpp >=  8) && (bpp <= 12))) ? (-2) : ((bpp >= 15) ? (4) : ((((bpp > 6) && (bpp < 8))) ? (-4 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-2 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
-		*p++ = (bpp <=  6) ? (-6) : ((((bpp >=  8) && (bpp <= 12))) ? (-4) : ((bpp >= 15) ? (2) : ((((bpp > 6) && (bpp < 8))) ? (-6 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-4 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
-		*p++ = (bpp <= 12) ? (-6) : ((bpp >= 15) ? (0) : (-6 + dsc_roundf((bpp - 12) * (6 / 3.0))));
-		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-2) : (-8 + dsc_roundf((bpp - 12) * (6 / 3.0))));
-		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-4) : (-8 + dsc_roundf((bpp - 12) * (4 / 3.0))));
-		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-6) : (-8 + dsc_roundf((bpp - 12) * (2 / 3.0))));
-		*p++ = (bpp <= 12) ? (-10) : ((bpp >= 15) ? (-8) : (-10 + dsc_roundf((bpp - 12) * (2 / 3.0))));
-		*p++ = -10;
-		*p++ = (bpp <=  6) ? (-12) : ((bpp >=  8) ? (-10) : (-12 + dsc_roundf((bpp -  6) * (2 / 2.0))));
-		*p++ = -12;
-		*p++ = -12;
-		*p++ = -12;
-	} else if (mode == CM_422) {
-		*p++ = (bpp <=  8) ? (2) : ((bpp >= 10) ? (10) : (2 + dsc_roundf((bpp -  8) * (8 / 2.0))));
-		*p++ = (bpp <=  8) ? (0) : ((bpp >= 10) ? (8) : (0 + dsc_roundf((bpp -  8) * (8 / 2.0))));
-		*p++ = (bpp <=  8) ? (0) : ((bpp >= 10) ? (6) : (0 + dsc_roundf((bpp -  8) * (6 / 2.0))));
-		*p++ = (bpp <=  8) ? (-2) : ((bpp >= 10) ? (4) : (-2 + dsc_roundf((bpp -  8) * (6 / 2.0))));
-		*p++ = (bpp <=  8) ? (-4) : ((bpp >= 10) ? (2) : (-4 + dsc_roundf((bpp -  8) * (6 / 2.0))));
-		*p++ = (bpp <=  8) ? (-6) : ((bpp >= 10) ? (0) : (-6 + dsc_roundf((bpp -  8) * (6 / 2.0))));
-		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-2) : (-8 + dsc_roundf((bpp -  8) * (6 / 2.0))));
-		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-4) : (-8 + dsc_roundf((bpp -  8) * (4 / 2.0))));
-		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-6) : (-8 + dsc_roundf((bpp -  8) * (2 / 2.0))));
-		*p++ = (bpp <=  8) ? (-10) : ((bpp >= 10) ? (-8) : (-10 + dsc_roundf((bpp -  8) * (2 / 2.0))));
-		*p++ = -10;
-		*p++ = (bpp <=  6) ? (-12) : ((bpp >= 7) ? (-10) : (-12 + dsc_roundf((bpp -  6) * (2.0 / 1))));
-		*p++ = -12;
-		*p++ = -12;
-		*p++ = -12;
-	} else {
-		*p++ = (bpp <=  6) ? (2) : ((bpp >=  8) ? (10) : (2 + dsc_roundf((bpp -  6) * (8 / 2.0))));
-		*p++ = (bpp <=  6) ? (0) : ((bpp >=  8) ? (8) : (0 + dsc_roundf((bpp -  6) * (8 / 2.0))));
-		*p++ = (bpp <=  6) ? (0) : ((bpp >=  8) ? (6) : (0 + dsc_roundf((bpp -  6) * (6 / 2.0))));
-		*p++ = (bpp <=  6) ? (-2) : ((bpp >=  8) ? (4) : (-2 + dsc_roundf((bpp -  6) * (6 / 2.0))));
-		*p++ = (bpp <=  6) ? (-4) : ((bpp >=  8) ? (2) : (-4 + dsc_roundf((bpp -  6) * (6 / 2.0))));
-		*p++ = (bpp <=  6) ? (-6) : ((bpp >=  8) ? (0) : (-6 + dsc_roundf((bpp -  6) * (6 / 2.0))));
-		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-2) : (-8 + dsc_roundf((bpp -  6) * (6 / 2.0))));
-		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-4) : (-8 + dsc_roundf((bpp -  6) * (4 / 2.0))));
-		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-6) : (-8 + dsc_roundf((bpp -  6) * (2 / 2.0))));
-		*p++ = (bpp <=  6) ? (-10) : ((bpp >=  8) ? (-8) : (-10 + dsc_roundf((bpp -  6) * (2 / 2.0))));
-		*p++ = -10;
-		*p++ = (bpp <=  4) ? (-12) : ((bpp >=  5) ? (-10) : (-12 + dsc_roundf((bpp -  4) * (2 / 1.0))));
-		*p++ = -12;
-		*p++ = -12;
-		*p++ = -12;
-	}
-}
-
-static int median3(int a, int b, int c)
-{
-	if (a > b)
-		swap(a, b);
-	if (b > c)
-		swap(b, c);
-	if (a > b)
-		swap(b, c);
-
-	return b;
-}
-
-static void _do_calc_rc_params(struct rc_params *rc, enum colour_mode cm,
-			       enum bits_per_comp bpc, u16 drm_bpp,
-			       bool is_navite_422_or_420,
-			       int slice_width, int slice_height,
-			       int minor_version)
-{
-	float bpp;
-	float bpp_group;
-	float initial_xmit_delay_factor;
-	int padding_pixels;
-	int i;
-
-	bpp = ((float)drm_bpp / 16.0);
-	/* in native_422 or native_420 modes, the bits_per_pixel is double the
-	 * target bpp (the latter is what calc_rc_params expects)
-	 */
-	if (is_navite_422_or_420)
-		bpp /= 2.0;
-
-	rc->rc_quant_incr_limit0 = ((bpc == BPC_8) ? 11 : (bpc == BPC_10 ? 15 : 19)) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
-	rc->rc_quant_incr_limit1 = ((bpc == BPC_8) ? 11 : (bpc == BPC_10 ? 15 : 19)) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
-
-	bpp_group = MODE_SELECT(bpp, bpp * 2.0, bpp * 2.0);
-
-	switch (cm) {
-	case CM_420:
-		rc->initial_fullness_offset = (bpp >=  6) ? (2048) : ((bpp <=  4) ? (6144) : ((((bpp >  4) && (bpp <=  5))) ? (6144 - dsc_roundf((bpp - 4) * (512))) : (5632 - dsc_roundf((bpp -  5) * (3584)))));
-		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)((3 * bpc * 3) - (3 * bpp_group)));
-		rc->second_line_bpg_offset  = median3(0, 12, (int)((3 * bpc * 3) - (3 * bpp_group)));
-		break;
-	case CM_422:
-		rc->initial_fullness_offset = (bpp >=  8) ? (2048) : ((bpp <=  7) ? (5632) : (5632 - dsc_roundf((bpp - 7) * (3584))));
-		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)((3 * bpc * 4) - (3 * bpp_group)));
-		rc->second_line_bpg_offset  = 0;
-		break;
-	case CM_444:
-	case CM_RGB:
-		rc->initial_fullness_offset = (bpp >= 12) ? (2048) : ((bpp <=  8) ? (6144) : ((((bpp >  8) && (bpp <= 10))) ? (6144 - dsc_roundf((bpp - 8) * (512 / 2))) : (5632 - dsc_roundf((bpp - 10) * (3584 / 2)))));
-		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)(((3 * bpc + (cm == CM_444 ? 0 : 2)) * 3) - (3 * bpp_group)));
-		rc->second_line_bpg_offset  = 0;
-		break;
-	}
-
-	initial_xmit_delay_factor = (cm == CM_444 || cm == CM_RGB) ? 1.0 : 2.0;
-	rc->initial_xmit_delay = dsc_roundf(8192.0/2.0/bpp/initial_xmit_delay_factor);
-
-	if (cm == CM_422 || cm == CM_420)
-		slice_width /= 2;
-
-	padding_pixels = ((slice_width % 3) != 0) ? (3 - (slice_width % 3)) * (rc->initial_xmit_delay / slice_width) : 0;
-	if (3 * bpp_group >= (((rc->initial_xmit_delay + 2) / 3) * (3 + (cm == CM_422)))) {
-		if ((rc->initial_xmit_delay + padding_pixels) % 3 == 1)
-			rc->initial_xmit_delay++;
-	}
-
-	rc->flatness_min_qp     = ((bpc == BPC_8) ?  (3) : ((bpc == BPC_10) ? (7)  : (11))) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
-	rc->flatness_max_qp     = ((bpc == BPC_8) ? (12) : ((bpc == BPC_10) ? (16) : (20))) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
-	rc->flatness_det_thresh = 2 << (bpc - 8);
-
-	get_qp_set(rc->qp_min, cm, bpc, DAL_MM_MIN, bpp);
-	get_qp_set(rc->qp_max, cm, bpc, DAL_MM_MAX, bpp);
-	if (cm == CM_444 && minor_version == 1) {
-		for (i = 0; i < QP_SET_SIZE; ++i) {
-			rc->qp_min[i] = rc->qp_min[i] > 0 ? rc->qp_min[i] - 1 : 0;
-			rc->qp_max[i] = rc->qp_max[i] > 0 ? rc->qp_max[i] - 1 : 0;
-		}
-	}
-	get_ofs_set(rc->ofs, cm, bpp);
-
-	/* fixed parameters */
-	rc->rc_model_size    = 8192;
-	rc->rc_edge_factor   = 6;
-	rc->rc_tgt_offset_hi = 3;
-	rc->rc_tgt_offset_lo = 3;
-
-	rc->rc_buf_thresh[0] = 896;
-	rc->rc_buf_thresh[1] = 1792;
-	rc->rc_buf_thresh[2] = 2688;
-	rc->rc_buf_thresh[3] = 3584;
-	rc->rc_buf_thresh[4] = 4480;
-	rc->rc_buf_thresh[5] = 5376;
-	rc->rc_buf_thresh[6] = 6272;
-	rc->rc_buf_thresh[7] = 6720;
-	rc->rc_buf_thresh[8] = 7168;
-	rc->rc_buf_thresh[9] = 7616;
-	rc->rc_buf_thresh[10] = 7744;
-	rc->rc_buf_thresh[11] = 7872;
-	rc->rc_buf_thresh[12] = 8000;
-	rc->rc_buf_thresh[13] = 8064;
-}
-
-static u32 _do_bytes_per_pixel_calc(int slice_width, u16 drm_bpp,
-				    bool is_navite_422_or_420)
-{
-	float bpp;
-	u32 bytes_per_pixel;
-	double d_bytes_per_pixel;
-
-	bpp = ((float)drm_bpp / 16.0);
-	d_bytes_per_pixel = dsc_ceil(bpp * slice_width / 8.0) / slice_width;
-	// TODO: Make sure the formula for calculating this is precise (ceiling
-	// vs. floor, and at what point they should be applied)
-	if (is_navite_422_or_420)
-		d_bytes_per_pixel /= 2;
-
-	bytes_per_pixel = (u32)dsc_ceil(d_bytes_per_pixel * 0x10000000);
-
-	return bytes_per_pixel;
-}
 
 /**
  * calc_rc_params - reads the user's cmdline mode
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
index 262f06afcbf9..c2340e001b57 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
@@ -27,55 +27,7 @@
 #ifndef __RC_CALC_H__
 #define __RC_CALC_H__
 
-
-#define QP_SET_SIZE 15
-
-typedef int qp_set[QP_SET_SIZE];
-
-struct rc_params {
-	int      rc_quant_incr_limit0;
-	int      rc_quant_incr_limit1;
-	int      initial_fullness_offset;
-	int      initial_xmit_delay;
-	int      first_line_bpg_offset;
-	int      second_line_bpg_offset;
-	int      flatness_min_qp;
-	int      flatness_max_qp;
-	int      flatness_det_thresh;
-	qp_set   qp_min;
-	qp_set   qp_max;
-	qp_set   ofs;
-	int      rc_model_size;
-	int      rc_edge_factor;
-	int      rc_tgt_offset_hi;
-	int      rc_tgt_offset_lo;
-	int      rc_buf_thresh[QP_SET_SIZE - 1];
-};
-
-enum colour_mode {
-	CM_RGB,   /* 444 RGB */
-	CM_444,   /* 444 YUV or simple 422 */
-	CM_422,   /* native 422 */
-	CM_420    /* native 420 */
-};
-
-enum bits_per_comp {
-	BPC_8  =  8,
-	BPC_10 = 10,
-	BPC_12 = 12
-};
-
-enum max_min {
-	DAL_MM_MIN = 0,
-	DAL_MM_MAX = 1
-};
-
-struct qp_entry {
-	float         bpp;
-	const qp_set  qps;
-};
-
-typedef struct qp_entry qp_table[];
+#include "dml/dsc/rc_calc_fpu.h"
 
 void calc_rc_params(struct rc_params *rc, const struct drm_dsc_config *pps);
 u32 calc_dsc_bytes_per_pixel(const struct drm_dsc_config *pps);
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
index ef830aded5b1..1e19dd674e5a 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
@@ -22,7 +22,6 @@
  * Authors: AMD
  *
  */
-#include "os_types.h"
 #include <drm/drm_dsc.h>
 #include "dscc_types.h"
 #include "rc_calc.h"
-- 
2.25.1

