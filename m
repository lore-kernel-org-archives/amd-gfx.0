Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A161AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 15:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EC23112221;
	Fri, 10 Jun 2022 15:43:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D14A3112220
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 15:43:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwG9uDFaFwRuDYYPu/p6izEi8D3toPr2briCCthpZmmG5hUG4z5+A0iDGRXXx2lQTM2avb0JDcTaC37HGqsdVdZ7FMZ4vp4DIx3YVYXm4/S/bBlIt2fbCrmD2Gz6xrZaJWLWk3wqsLUsLp7yHmXGdw8yRJ1J4yjVklDz4mSYfSPWygTsohV6iY75fC5ky7SN08c/ODpQm1wFtKg6OxhT49Y1IbXYpSlKjiFhL9xuvc3rx/98VwSu92dAXgStjT/K0FkVc/+QT7P1NP6Unvt7kRqnzjmQWg1Jab1jmpLsmUXpviauLs8Nl0iQZBXZ0YU4aMGj+mbySEm5kFNNegpLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHbYagYexPqr8+1thynRZW5xy9lfzsYQuKMtJhn3NOw=;
 b=jebiNZU2R0nyeDkxgyJAvcKL8ZJVJwpAf3rrb93n4hI80rLPlkCSxjWphXBFsTnDbJNIFaltapQmUdcjSzdFLnlj8lv3vXHUR8C2NmuzoqUgiO5ZAonJOIlU2CtqFLj8cimBFIEqRZn0VsrvF+GRIN6l0W6dVPn9Ei3fRGuAxPM5n/KtaOXVkXPkg59cqQMMvorWDzgjZgsz2Z0HvzTHjsCyBS0LucPJ1ZEMsnNS5KppVUos5DLaTd+d5tC//HfvlfsrgZGfLJmVVRffhLq3thNlhP1FaHQBcZGOwaHQuadthwZFEYgpHDagWHCucZcAxgB87uL7ERea0bKYz+26sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHbYagYexPqr8+1thynRZW5xy9lfzsYQuKMtJhn3NOw=;
 b=ue1zCCj4qmtpoCJ5gDVLBl1nt0i+QF+h3/TDy3oA986gzf0L/QzpomLiMCTaplHF31wavsZphrPc7vXYLlO9LGImZbYAQsdoyKkpc+0DlVUNq8b9BoJMrCvRVi5vYdfzitgFkYMSST+qn7zd0690X9vRF2iMqTrzFUayZr02ENI=
Received: from DS7PR05CA0037.namprd05.prod.outlook.com (2603:10b6:8:2f::24) by
 MWHPR1201MB0191.namprd12.prod.outlook.com (2603:10b6:301:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 15:43:04 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::a8) by DS7PR05CA0037.outlook.office365.com
 (2603:10b6:8:2f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.6 via Frontend
 Transport; Fri, 10 Jun 2022 15:43:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 15:43:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 10:43:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/display: make FP handling in Makefiles consistent
Date: Fri, 10 Jun 2022 11:42:46 -0400
Message-ID: <20220610154247.338073-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 614be1d9-6bcd-4115-d1ef-08da4af7e83f
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0191:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB019168D95F03D14DB1D65AD8F7A69@MWHPR1201MB0191.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UmdmxUwNhsuGtwOIx5eHIT81J7VNnHeFRt4OEagmYI2gzOqlW0WKBhb5rlF5tptMgr2OJ0KU7zASbjTxyLbh7F2GYxQBhrxlze33uA9FDLOuLbebpq/Qobo7Fppbv3wSOWxDrJ9NYoVuEpQBaRlA1mM2pA7VEYKQ6+dlcoSoKF4noKI+E8ue/N0Gk3d7lduR1pYwLyYjXzIt/pszl+hrmIkYhXxVnaQEzfKmKi5jZr2yELhUBSUbMH0FGx6XlzWF1Zp4e7IUlMe9RakbMjDDMCEQCWTG5OodylCPa1yOc6GexU4gSk+QSM+panGwxWgCHbUv5x5i6173nxB09oSoxwQbCZqgWWZZ2GCuPabYCq9ybe8W1n7/eGYFK3oHmREBeFmchTWmMUy/w05Ka7FzLwyDXKW9pWPL7amUaL8i04vohRb1xJDUi9bdnK80pDj3RXOYw+LxowXv/0Q9huJBjadb9j0ve6+4K1YzX2YIURSWq6RfTv7t0XfRtIv4KUgKLte+c0fZT7sTV54UXBqK2KdrDmnVwThX83IiMdlnsLzpyhj64BuHVKB8PSdd0dWeCRi3jkj10hz2fpF0Vr3Wlic967ueC3lP4m//kXS75CnA+x3W34gekdjOuLfd8NWyv0avRamVAmoVeD92hQ4krtq6nO5HGzNzbE5rMFOIjo93Lfqj1bOWKo4J2A2sQff//0nc4e55z+SyzJlyGGIDtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(83380400001)(81166007)(70206006)(2906002)(8676002)(5660300002)(70586007)(4326008)(86362001)(36756003)(6666004)(26005)(356005)(7696005)(16526019)(336012)(47076005)(426003)(508600001)(2616005)(82310400005)(1076003)(6916009)(40460700003)(186003)(8936002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 15:43:03.9283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 614be1d9-6bcd-4115-d1ef-08da4af7e83f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0191
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

Use the same pattern as the DML Makefile and while we are here
add a missing x86 guard around the msse flags for DCN3.2.x.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile | 3 +--
 drivers/gpu/drm/amd/display/dc/dcn201/Makefile  | 1 -
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile   | 6 ++----
 drivers/gpu/drm/amd/display/dc/dcn302/Makefile  | 8 +++++++-
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile   | 5 +++--
 drivers/gpu/drm/amd/display/dc/dcn321/Makefile  | 5 +++--
 6 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index c935c10b5f4f..7b505e1e9308 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -180,7 +180,7 @@ CLK_MGR_DCN32 = dcn32_clk_mgr.o dcn32_clk_mgr_smu_msg.o
 AMD_DAL_CLK_MGR_DCN32 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn32/,$(CLK_MGR_DCN32))
 
 ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -msse
+CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -mhard-float -msse
 endif
 
 ifdef CONFIG_PPC64
@@ -191,7 +191,6 @@ ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
 endif
-CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -mhard-float
 endif
 
 ifdef CONFIG_X86
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
index f68038ceb1b1..96cbd4ccd344 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
@@ -18,7 +18,6 @@ ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
 endif
-CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o += -mhard-float
 endif
 
 ifdef CONFIG_X86
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index dfd77b3cc84d..c20331eb62e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -32,8 +32,8 @@ DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
 
 
 ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -msse
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -msse
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse
 endif
 
 ifdef CONFIG_PPC64
@@ -45,8 +45,6 @@ ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
 endif
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -mhard-float
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o += -mhard-float
 endif
 
 ifdef CONFIG_X86
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
index f9561d7f97a1..e4b69ad0dde5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
@@ -8,7 +8,7 @@
 DCN3_02 = dcn302_init.o dcn302_hwseq.o dcn302_resource.o
 
 ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -msse
+CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -msse
 endif
 
 ifdef CONFIG_PPC64
@@ -16,6 +16,12 @@ CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -maltivec
 endif
 
 ifdef CONFIG_X86
+ifdef CONFIG_CC_IS_GCC
+ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+IS_OLD_GCC = 1
+endif
+endif
+
 ifdef IS_OLD_GCC
 # Stack alignment mismatch, proceed with caution.
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
index 3d09db3070f4..34f2e37b6704 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
@@ -16,7 +16,7 @@ DCN32 = dcn32_resource.o dcn32_hubbub.o dcn32_hwseq.o dcn32_init.o \
 		dcn32_mpc.o
 
 ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -msse
+CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -mhard-float -msse
 endif
 
 ifdef CONFIG_PPC64
@@ -27,9 +27,9 @@ ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
 endif
-CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -mhard-float
 endif
 
+ifdef CONFIG_X86
 ifdef IS_OLD_GCC
 # Stack alignment mismatch, proceed with caution.
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
@@ -38,6 +38,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -mpreferred-stack-boundary=4
 else
 CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -msse2
 endif
+endif
 
 AMD_DAL_DCN32 = $(addprefix $(AMDDALPATH)/dc/dcn32/,$(DCN32))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
index 5896ca303e39..e554fd6c16f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
@@ -13,7 +13,7 @@
 DCN321 = dcn321_resource.o dcn321_dio_link_encoder.o
 
 ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -msse
+CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -mhard-float -msse
 endif
 
 ifdef CONFIG_PPC64
@@ -24,9 +24,9 @@ ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
 endif
-CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -mhard-float
 endif
 
+ifdef CONFIG_X86
 ifdef IS_OLD_GCC
 # Stack alignment mismatch, proceed with caution.
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
@@ -35,6 +35,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -mpreferred-stack-boundary=4
 else
 CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -msse2
 endif
+endif
 
 AMD_DAL_DCN321 = $(addprefix $(AMDDALPATH)/dc/dcn321/,$(DCN321))
 
-- 
2.35.3

