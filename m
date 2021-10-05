Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1777C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5D16126A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE5D16126A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5878E6EB41;
	Tue,  5 Oct 2021 07:54:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5F396EB41
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 07:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gxqu19PYRcLvCJhHN8Oxe87Vfbew5DLSATZeH+bPuZNUKT7s0PY/2a30Fp0/+z2ETuYhXLP8PPW/o+yEvF2NozEowFVsauqRz3aV9/QhB9TVHEv6lvQqTamfW+/3ZETogoUYWqoZ9BnsgdQmZB7ASa3Uvh8bq1aaLVtqkU+uuncfYW/9637/TJAMhKOjSei9uZBWcq8rb9I1maI0/fImp1E483RFQct4F8nay5kCzHQuh/AbP84d75j39e20ZBsjNDkQvfMgK41N1LJ2s0j94vZ5UZB8WM8tR9jCw8VJr9dBTR0qmcbIkHffiDEFJlub2in9BUR+OF/IJqCkszW9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+gVFPCaUavmsMZ3KRoJGf7GjpSCdPs8FfZeyUIzXS8=;
 b=d1FGUqYkFNyG/GlKIk57sWt/oyvytZbggO+H/wDZ9RTNJY6zRfWl/U9PXEDbSpHKHYzAlap73y9XguY2BamuAPdbv5+jQTkQgkH+YCwhaNPwKDLqmAqme22w6Nm0e6mLF3Y75ELAGf9HR3ugWizqeWod185ODitMw6DN+3OQSPumefGUoG0S8vad1o4xdTcIRZzohD5v5CRFhy5WJs0YHASE69j0Hbzp06ixrjTQekQWwSdTHWO1Xel0sJUzOGg/qqka3AaHolJXGnFQ3BRe3pJfZ8BGbePt8ml7s6XNTlzegetkXujXfei7rXNxQRgBmGzW/JairTLa1KSPpqlU6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+gVFPCaUavmsMZ3KRoJGf7GjpSCdPs8FfZeyUIzXS8=;
 b=gXgyiDxk57ZkhUBW1Nbp29B1j5PK1Z2iZPHoJuj9abXUwxnvkcqn4fX349qUltQaUq2e6AHYZ8m/jb/gHfHQDqzBp0/jIQ4CnFtZjjfA624WqefFLzTon9xjdurIAfWAsvocdIJ9qmSG/akGaxnVO0di2K2xRsJFEPP4m6sXCPc=
Received: from DM6PR13CA0008.namprd13.prod.outlook.com (2603:10b6:5:bc::21) by
 BN8PR12MB3507.namprd12.prod.outlook.com (2603:10b6:408:6e::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14; Tue, 5 Oct 2021 07:54:08 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::af) by DM6PR13CA0008.outlook.office365.com
 (2603:10b6:5:bc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7 via Frontend
 Transport; Tue, 5 Oct 2021 07:54:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 07:54:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 02:54:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 02:54:06 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 02:53:53 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH v2 06/23] drm/amd/display: Support DP tunneling when DPRX
 detection
Date: Tue, 5 Oct 2021 15:51:48 +0800
Message-ID: <20211005075205.3467938-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92c88408-9ef2-445b-6330-08d987d54f92
X-MS-TrafficTypeDiagnostic: BN8PR12MB3507:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3507CA0BEE6888EB5D2961F3FCAF9@BN8PR12MB3507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: slNHNEj7byk490yVfLJj6uq5K7i2lFtkHCNlL07HjPZGcG3KT43Vn2gpu3y3ao85jF8JTrPMpDVsPFveBG8xgThHda4PB3BJriVLHn53OotgRqZz6tDEyyQG+RVmAa1THVoqRczu/5jWkb04cJhVdkPUVWwtoNIVrLg7+iodBz6MpwGGTngv8+6Mh1hT/BDj1ExZoHxskSEa/aEWOGl7hz6dy87z8OzTgKNrqVKlzaekzuocTkoC5e742VDbFAuXIx8p7otB5UzD57WHGZaaHHh8THdZfu0uJ2VqHQKLec0mh6yzn/xlaR8DlgyGvvw4pU4B+Pg7kbV2O7KvPv2NetySDT7df9aJ737NQ3ER6HXFIySdL5PwbxPuJTwq8794rbAEO8uKmysnwuSXRSwcWB+ro+d7zbwgMDd8PJk08J0FCHQ5LNiDGzaOevdYdflRpxBTGhZ9qLztCYYJuvi7bXWNT7t3l/jG/ImXfkOlBx/uiPNeDv3kFbtuZldplcg7EqyFp9nG+fgJrz1p3PjEjoAs0yDyx3KzhWSRATNxm7FZaFKEzQuenMY80ct+IaPZ/c8VTjeR9cJypvqjGCEYS0CoCehQP4FIV0emrHe3yQ4O6pobwwaWh7/8kw2flYdSF1IeKx7t7xs/lanIMTdUeTJOATPfEwrYT725I1LgzpjGyeNomMdU9JGycutY9qBv4DtxrR67BLMcwPHALGVuF9/8tX9lMaL2Iwp/BwS7QTw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(70206006)(8676002)(508600001)(54906003)(70586007)(47076005)(7696005)(26005)(81166007)(36756003)(186003)(36860700001)(356005)(6916009)(83380400001)(8936002)(336012)(316002)(4326008)(86362001)(1076003)(2616005)(6666004)(82310400003)(2906002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 07:54:08.1579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c88408-9ef2-445b-6330-08d987d54f92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3507
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[why & how]
Add codes for commit "99732e52e7f8 drm/amd/display: Update DPRX detection"
to support USB4 DP tunneling feature

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  2 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  4 ++
 .../drm/amd/display/dc/core/dc_link_dpia.c    | 34 +++++++++++++++++
 .../gpu/drm/amd/display/dc/inc/dc_link_dpia.h | 38 +++++++++++++++++++
 5 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 520f58538364..1a0e462bed42 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -61,7 +61,7 @@ include $(AMD_DC)
 
 DISPLAY_CORE = dc.o  dc_stat.o dc_link.o dc_resource.o dc_hw_sequencer.o dc_sink.o \
 dc_surface.o dc_link_hwss.o dc_link_dp.o dc_link_ddc.o dc_debug.o dc_stream.o \
-dc_link_enc_cfg.o dc_link_dpcd.o
+dc_link_enc_cfg.o dc_link_dpia.o dc_link_dpcd.o
 
 ifdef CONFIG_DRM_AMD_DC_DCN
 DISPLAY_CORE += dc_vm_helper.o
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 66182b8c217b..1c397d5551ba 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1726,6 +1726,7 @@ static bool dc_link_construct_dpia(struct dc_link *link,
 	/* Dummy Init for linkid */
 	link->link_id.type = OBJECT_TYPE_CONNECTOR;
 	link->link_id.id = CONNECTOR_ID_DISPLAY_PORT;
+	link->link_id.enum_id = ENUM_ID_1 + init_params->connector_index;
 	link->is_internal_display = false;
 	link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
 	LINK_INFO("Connector[%d] description:signal %d\n",
@@ -1733,6 +1734,7 @@ static bool dc_link_construct_dpia(struct dc_link *link,
 		  link->connector_signal);
 
 	link->ep_type = DISPLAY_ENDPOINT_USB4_DPIA;
+	link->is_dig_mapping_flexible = true;
 
 	/* TODO: Initialize link : funcs->link_init */
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 4df71d728319..9bc5f49ea2ec 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -36,6 +36,7 @@
 #include "dpcd_defs.h"
 #include "dc_dmub_srv.h"
 #include "dce/dmub_hw_lock_mgr.h"
+#include "inc/dc_link_dpia.h"
 #include "inc/link_enc_cfg.h"
 
 /*Travis*/
@@ -4582,6 +4583,7 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 
 		/* Attempt to train in LTTPR transparent mode if repeater count exceeds 8. */
 		is_lttpr_present = (dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) != 0 &&
+				link->dpcd_caps.lttpr_caps.phy_repeater_cnt < 0xff &&
 				link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
 				link->dpcd_caps.lttpr_caps.max_lane_count <= 4 &&
 				link->dpcd_caps.lttpr_caps.revision.raw >= 0x14);
@@ -4630,6 +4632,8 @@ static bool retrieve_link_cap(struct dc_link *link)
 			LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD);
 
 	is_lttpr_present = dp_retrieve_lttpr_cap(link);
+	/* Read DP tunneling information. */
+	status = dpcd_get_tunneling_device_data(link);
 
 	status = core_link_read_dpcd(link, DP_SET_POWER,
 			&dpcd_power_state, sizeof(dpcd_power_state));
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
new file mode 100644
index 000000000000..183601e300fe
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -0,0 +1,34 @@
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
+#include "dc_link_dpia.h"
+#include "inc/core_status.h"
+#include "dc_link.h"
+
+enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link)
+{
+	/** @todo Read corresponding DPCD region and update link caps. */
+	return DC_OK;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
new file mode 100644
index 000000000000..8ed0c9f6414b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
@@ -0,0 +1,38 @@
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
+#ifndef __DC_LINK_DPIA_H__
+#define __DC_LINK_DPIA_H__
+
+/* This module implements functionality for training DPIA links. */
+
+struct dc_link;
+
+/* Read tunneling device capability from DPCD and update link capability
+ * accordingly.
+ */
+enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link);
+
+#endif /* __DC_LINK_DPIA_H__ */
-- 
2.25.1

