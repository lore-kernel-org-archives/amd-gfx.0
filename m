Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F0DC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jun 2022 14:05:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1F9A1123BE;
	Tue, 14 Jun 2022 14:05:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 229A31123BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 14:05:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDYsFW8AWQ3VF45AWmB7/TSbltXd9OTpGUMhRMa/+CGueIOc0PqORIeUhf5pQz+zMdo4Wpc1s8HZF/tvTil98gsPGdDQiLu8w4bM9Vwqe4RUpdbklyizlMncbV9CI+iv9Ntm+vJ0cdKJvcy3xWw+0Mkr/bCYALaXOe1c1lqrG0pwpr9TBWPcgu8GSAn1m+pDmdYCg8vnsy4xT1PfzrX3eW9hNGNv/mw6ILiVONSvFHUuamC17fF4bzBOSQ2Rfp4A+/Qr8ZDwlA53kIwzzr6SzesyQWg5bAsVr5nzji9U/CQE5jUwnZziuTeDWBIpEOEGJ/LTg3zIS9kd0a5FRBBbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHbYagYexPqr8+1thynRZW5xy9lfzsYQuKMtJhn3NOw=;
 b=fwQrQz5c4mzdOjucsoflL8JGECKCCqqtYby3Ry2o7lgljs4aOFv0K6v6VwNR4MGFqabtdr/nTydzPpESSb7EKmzyqI9NuMXpFJ5SIVFI1JsUxKRfeF6qKtXpWIZAYOhGo+F2OCus3v8aJTu12kMXoe/nYx0TYAbna5bdRgx53QNnuytcqszTDCscU13KzkNdMQDU1WNDP4Qw51grqHRsgdXBGAbTF/NWotXWCfp0PWw8n482Rl3LunlhDZUyNkpqyaZMAQdTwhbvljZZZicSolI/Z6tT+nPK1CwvSnGoKBYjxh0moh3wBlyUMaV9hkQmgXK0R1VD9mkf2pILr4QjpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHbYagYexPqr8+1thynRZW5xy9lfzsYQuKMtJhn3NOw=;
 b=xhg22Ofj1rGE/aCG7hbe9JYKV/SS+hpwGEO915mI0S8RgfBtaFKKyQrNZLF6ig7zIUINusgteA2QMtoS2EIeujM34hAD7BQ26V9HXGsOzm6JnQ28MD/P+C/8nJfrAwf4vaq5NjXGJiyzjkWaOawfoUNyKMzGlnd0Sq1J2+Bq0CI=
Received: from DM6PR21CA0002.namprd21.prod.outlook.com (2603:10b6:5:174::12)
 by SN6PR12MB2637.namprd12.prod.outlook.com (2603:10b6:805:6b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Tue, 14 Jun
 2022 14:05:39 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::f7) by DM6PR21CA0002.outlook.office365.com
 (2603:10b6:5:174::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.6 via Frontend
 Transport; Tue, 14 Jun 2022 14:05:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Tue, 14 Jun 2022 14:05:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 14 Jun
 2022 09:05:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/display: make FP handling in Makefiles
 consistent
Date: Tue, 14 Jun 2022 10:05:24 -0400
Message-ID: <20220614140524.2677317-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220614140524.2677317-1-alexander.deucher@amd.com>
References: <20220614140524.2677317-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 313aed7e-5c74-4bd4-e77a-08da4e0ef630
X-MS-TrafficTypeDiagnostic: SN6PR12MB2637:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB263722F9BD37C2D76C6133E8F7AA9@SN6PR12MB2637.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WcPU6XfDpd8iB22dtKjY5AWFFY3t8IrymKrUWcHgDi9AbpVHMPJN18vSr6KpImV/AvAl1gBgiSGJtHe/8g6YB+QVUKHiii8kUgzKHWIdpks3CY4wL8kmd9OAkqvTDX0InPBQ5marCJCQV5wjVcSXuPzmffF8P37c0lmaX8ue9du3tGsmHe3dWfFz/+gYEZTUVOTm+W+QSuYmigo0gEL7j3jnIUakeiLg+nAa28qXUgyQ+cGTrxeSwhY4WHdAGSMcDHkIb9XlC7zaHsb6Q6W4gSinniSt4rQ7FipfZJPTa7jo4FvFoc1ZTvEeZk3SC+/gdnDdL07fSSoi3wPHdEgi7AzBB8GYu240jsgQSaIki10FaTXIRnZpt/zrHTY8fbfDeg35cAboFzO0tRvIrd8t+LMZ9SpVfv+cbcjQZMqvx4AO6N6PvE2m3auKRkzSpsyXWyvOGzcS+dIP7zBTxRbPjg7gu7XpGxQrO0pQvAGIX/StAZW00MRyQLnVh4RBkBFmwwZzvzVI0jQspVq58k0PTAXM2RLoEdeSBcSys+D7jOFDe9eRlu4dnEQMoePzgGXS6iQLzM/nQTKg/qQruVP+7uIXuDx2+/Cv3vC3XUZVhkX0zl9FtGSC3rYIhH07lY3JfNI2UANmeALps/pWTEDsQUy/0TCUdDtPxrndrPMleV4mjwzoUfnETHPWAqMtm/MoweHMBdNnQsSZPe5vXhOQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(6666004)(26005)(47076005)(186003)(426003)(336012)(16526019)(2616005)(1076003)(7696005)(356005)(40460700003)(86362001)(81166007)(83380400001)(6916009)(8936002)(82310400005)(36860700001)(508600001)(316002)(5660300002)(70586007)(70206006)(36756003)(4326008)(2906002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 14:05:39.2161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 313aed7e-5c74-4bd4-e77a-08da4e0ef630
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2637
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

