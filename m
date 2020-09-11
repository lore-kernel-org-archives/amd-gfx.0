Return-Path: <SRS0=U106=CU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF6AC433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 16:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA937221EB
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 16:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BrT/FiYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA937221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA276EAA8;
	Fri, 11 Sep 2020 16:27:14 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07E546EAA8
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2020 16:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmPL3dht98Gom6wYEW754OUPtDXqAioCBk2c2djSkppNPUhRkwmoIQeFZ3HACEreykb3Ozo2NXb9QvZJqHgNLxNyQsoFSNpp+hrDSSitnJJo1ah7gICPJFcOJblYzxh5HLbrcsZ2wat10EXbsWm1WwLJjWIGjA7c9cA8Yb7OS0T/NJ2NPfDPv/ZMv0oGGznREmJ8duhIH1Pslz5OaVW745LaQmmIdpGJNZs+yJYIwFxZO8bBNMWCCchGcen65EPcjoRh8PmOEmTzW0b4blZjQA/igPPllDoUbWuUgz+FdYFRVZsvCtpxQ8CaVvkBtANvALMvcTMe7Uq8ThnD7qVpBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlS4OlsfWP6t7hrcIRnZulgoGODI3noXtVxpBRnyzBc=;
 b=e2VQUX+Ha39bFx/uxti6Speh6DI2BwKnlpT2XIi+yZjHfny2AdOb8p8j9L64Dg3ts+m3FVXo76+zhJSYUHV/h7OsfOUrsSOQ3P7izuda/6/wAZOq5q4lPU+UXzix198qUvDITKtVX+QwNlgNqfrKwppkcbHHCTPMFgmcQkbvAWQ/l+jrLi1zFUR8RHXqYqNpJccNGpM4y2/VS28VJXuu7ifIxlLTPEMfz1De/3qoQ99L8LKewBSj9mhNi/a3j8FfUgyEPP88vej60OtpBzuyPuLlQzaa2Zl/dj3AJftvj6UQ+RE5RJ6LQM9o67QOE5w/lyCpqdPnpUM+P2DCuwnADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlS4OlsfWP6t7hrcIRnZulgoGODI3noXtVxpBRnyzBc=;
 b=BrT/FiYE89f+3Io/1E9ilpKR2h+ey92SAyzfF6qkLuo+vrFkrc1mOJnrY55HjxYEhdTzW+9iRrOEcKChtk5Piw1KAlREhn0TxOKM06srQ/ZWkykK7LEOxWtoFqnGu+6hDTwr74IfORG/HzsZNIF0XQPawKV5Bu3SUPh0vXVdhuQ=
Received: from BN8PR04CA0038.namprd04.prod.outlook.com (2603:10b6:408:d4::12)
 by DM5PR12MB2373.namprd12.prod.outlook.com (2603:10b6:4:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 16:27:11 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::d2) by BN8PR04CA0038.outlook.office365.com
 (2603:10b6:408:d4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Fri, 11 Sep 2020 16:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 16:27:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 11 Sep
 2020 11:27:10 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 11 Sep
 2020 11:27:10 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 11 Sep 2020 11:27:10 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amdgpu: Move existing pflip fields into separate
 struct
Date: Fri, 11 Sep 2020 12:27:07 -0400
Message-ID: <20200911162709.87720-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200911162709.87720-1-aurabindo.pillai@amd.com>
References: <20200911162709.87720-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1b1eba7-8d9e-4078-6066-08d8566f88cd
X-MS-TrafficTypeDiagnostic: DM5PR12MB2373:
X-Microsoft-Antispam-PRVS: <DM5PR12MB23732DF5F31D374CF6940CC38B240@DM5PR12MB2373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6FqYrDZLe+oaEXD8OvGQNX4oZInmbct6wh/hw+u2lJnl5bHzn6Q2uDgIm28YJOJ6eyA0p36E2GzTU4iOdQkblP8FGGsUFn++0GQGbx1gz+eydfImNc8LLOEyIarC9dLGAP1+Sh3LIvEeSin+ij6kibZlbGOCYL39Z+1CHu1CADtqPUcCjWgzeHkHnu6zSc8gU9dmKReOPlbShv7oV6QyCNWC7bSN9NagQYrQ3GEGvqWJaqMj2T5IxDboWEtHF53CAK7XH2zx5QoAKtDDIWexxetbIOAp2j5Fgb6L7LrFnlDgVE1ulMBh5X7XxX4PpFlorqEn1fGHSZjXZvay+ao1H8N5hlbNZ9HQ6dYLhEmWbGJAURL1utBVlHbAT30r1lgGj0LP0a+oELuCmgzIvDHCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966005)(2906002)(336012)(1076003)(26005)(426003)(44832011)(6916009)(7696005)(86362001)(70586007)(70206006)(5660300002)(82310400003)(4326008)(2616005)(186003)(478600001)(6666004)(36756003)(47076004)(8936002)(316002)(81166007)(83380400001)(82740400003)(356005)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 16:27:10.9014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b1eba7-8d9e-4078-6066-08d8566f88cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2373
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
Cc: nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
To refactor DM IRQ management, all fields used by IRQ is best moved
to a separate struct so that main amdgpu_crtc struct need not be changed
Location of the new struct shall be in DM

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  4 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +--
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  | 33 +++++++++++++++++++
 3 files changed, 38 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index aa3e22be4f2d..345cb0464370 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -46,6 +46,7 @@
 
 #include <drm/drm_dp_mst_helper.h>
 #include "modules/inc/mod_freesync.h"
+#include "amdgpu_dm_irq_params.h"
 
 struct amdgpu_bo;
 struct amdgpu_device;
@@ -410,7 +411,8 @@ struct amdgpu_crtc {
 	struct amdgpu_flip_work *pflip_works;
 	enum amdgpu_flip_status pflip_status;
 	int deferred_flip_completion;
-	u32 last_flip_vblank;
+	/* parameters access from DM IRQ handler */
+	struct dm_irq_params dm_irq_params;
 	/* pll sharing */
 	struct amdgpu_atom_ss ss;
 	bool ss_enabled;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cb624ee70545..40814cdd8c92 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -389,7 +389,7 @@ static void dm_pflip_high_irq(void *interrupt_params)
 	 * of pageflip completion, so last_flip_vblank is the forbidden count
 	 * for queueing new pageflips if vsync + VRR is enabled.
 	 */
-	amdgpu_crtc->last_flip_vblank =
+	amdgpu_crtc->dm_irq_params.last_flip_vblank =
 		amdgpu_get_vblank_counter_kms(&amdgpu_crtc->base);
 
 	amdgpu_crtc->pflip_status = AMDGPU_FLIP_NONE;
@@ -7248,7 +7248,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			 * on late submission of flips.
 			 */
 			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
-			last_flip_vblank = acrtc_attach->last_flip_vblank;
+			last_flip_vblank = acrtc_attach->dm_irq_params.last_flip_vblank;
 			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 		}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
new file mode 100644
index 000000000000..55ef237eed8b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+#ifndef __AMDGPU_DM_IRQ_PARAMS_H__
+#define __AMDGPU_DM_IRQ_PARAMS_H__
+
+struct dm_irq_params {
+	u32 last_flip_vblank;
+};
+
+#endif /* __AMDGPU_DM_IRQ_PARAMS_H__ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
