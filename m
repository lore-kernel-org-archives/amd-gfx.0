Return-Path: <SRS0=5+Vp=CS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A758C2D0A7
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 14:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D2F32224E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 14:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aBZQiXuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2F32224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D61E6EB93;
	Wed,  9 Sep 2020 14:29:01 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750089.outbound.protection.outlook.com [40.107.75.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 596116EB8F
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2020 14:29:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=finr9BYcPTYQ/E+LsT+Vi5vlmd8Jq/CShHCVryVitm9lxQsLKRBHvlDOAMv/tTZxnQOTezoNMsmjzuGkNBNJqSHYkOC85RWZ0OXFz23iVOX704eoSnd098WFsfZbp0uvtEA16GdOEBvd9c0Mo7lFw5i2uKh4E/Z72Mn84brgZm3WpDgxeg5OJjffLlzyYRZ7iKZk564vno/1M/YCkHnRNa3iTbRn+9CUYY0+DD2vJBSIVAuIupjStma4ARxeqLS35OAL2STuUIiIt39nf/tWzZz36v3kWULiHsiCRO/6KHxWomGmOuc8HnpJpkdjW2/SUCNasV0JGvo2xJ7DDpGM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlS4OlsfWP6t7hrcIRnZulgoGODI3noXtVxpBRnyzBc=;
 b=gkpJszDqF4jrwnscDerR0EiX+fHuZ7uyQDNBLCEC+FANRLcMAZ1qtFslZ/9fduRPvHFGgmpFzF5RVFGmCjdhm/vxH+LXK3w8VZ2re+MLT73rtSWf9FNpds7v545kc0FnTlpBZUhMjIS1ls7qi7C1LG8TX0+O3Obli96IBY8jX+6p+Tx8IRsH4fJqkctA1+/ZCh3wzUstErr55b0ayn+JTe7T6lXRnOjqKCBgJuZ83ypA0G6+pZe7AER6qIU0GVIXLjcWicf5Vw9GIj4QIrvi50dAKu00JKhrOfk7FH+Ocmuo5CUNWHJ+bon+fczZw3q0CCHecm/W3+cTTGCHoY7iEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlS4OlsfWP6t7hrcIRnZulgoGODI3noXtVxpBRnyzBc=;
 b=aBZQiXuw2H2qwwT2Lgjw3rfAh7p0JEOUb9srVmQ/eEwJebktM3kCYo1zATTM8IHn2LH/UqP+gnWq8gseW67oEubSz2Ixp0kacn+bcdYYdohQKAEkWmA84kBAtx5LJ+I9IlCkteRzOG29wSwoihaMdtbi5qjq4mPgu2VO5xPz9W8=
Received: from MW2PR2101CA0033.namprd21.prod.outlook.com (2603:10b6:302:1::46)
 by BYAPR12MB2712.namprd12.prod.outlook.com (2603:10b6:a03:65::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 14:28:57 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::7d) by MW2PR2101CA0033.outlook.office365.com
 (2603:10b6:302:1::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.3 via Frontend
 Transport; Wed, 9 Sep 2020 14:28:57 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 14:28:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Sep 2020
 09:28:56 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Sep 2020
 09:28:55 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 9 Sep 2020 09:28:55 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Move existing pflip fields into separate
 struct
Date: Wed, 9 Sep 2020 10:28:52 -0400
Message-ID: <20200909142854.105032-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909142854.105032-1-aurabindo.pillai@amd.com>
References: <20200909142854.105032-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5439bd38-31b5-40e6-06f9-08d854ccafa3
X-MS-TrafficTypeDiagnostic: BYAPR12MB2712:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2712F0C5FFDCAE618E47AAC08B260@BYAPR12MB2712.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRyCI104RnGbO4YmSnesmu7Th/3TfM9zzhN3g/4ENok5eV7KGRtR0LiE6HhTlhcMvDvnPnY/cH24krjrZPVPF7bw4SoHJMjnd4Iukg+uLdFeGEOzO0olLo4P8dtC9XI6sSizg0Dh4QvTKAMgRk6MMe0SoMkQmnyFbUqFXIuVOP/5npuWohDgMbSCMXT1zZoyBniltl+saHN2mK033SColXeII5J4zGczvBE5B8riRkESl8JS9bs3J6MCwh3VjB+sa84R/nwGRnKsQbC+D0OaaUAV1+UMn6fksrbjd47u686m4c/zTBXs+VPF0T2Aklab7q7sNMxwpH1gThAtmRy+LbD+w3qVo3Er4ZrZkYFpe+eyrtF8N+KYLs1T3R+0TnNk191crA5714jOLmS5/GevfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966005)(47076004)(70206006)(70586007)(5660300002)(2906002)(8676002)(6666004)(6916009)(4326008)(7696005)(186003)(8936002)(82310400003)(44832011)(83380400001)(26005)(478600001)(2616005)(81166007)(36756003)(316002)(86362001)(426003)(356005)(336012)(1076003)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 14:28:56.8104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5439bd38-31b5-40e6-06f9-08d854ccafa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2712
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
