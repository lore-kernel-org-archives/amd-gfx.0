Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB119C7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E0710EFE2;
	Thu, 30 Mar 2023 19:32:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABE4310E54A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:32:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csnsTmiUvzy8olpfSNqeH8I6NYFd6TByNyu33b39IbaUu/T8v+e0vXhzsI0nCqwNRMmh4lgSc64m/EyRiRmhymMayu5o1lg7Q2uT+tyCmuyh1U4/wDc2qjpOxeR2p/O/XoUWiUVeGRVWJcg06iB1+MqvsIuESsJAelLs8KRAGPVzD8Imd8mg4E5QehE4L1YmzJe+XVAWLqWEcimoj9awQSWyYFQvW9Yypb9ZryOs6xteEePNuA2Sv/FKb1Ls9lUlMCBFYStc5mHEn3FDbiTtQiQE4v7UIDVSMhgZ5Ar15fyNIZlC7+A8KDuEQt78LLAB8gai0LvxgtjyzNduUSWvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6R3IhHcxrTMz0wEwyf94ZSQFtp+yYxgG53ZJ7dBIr8=;
 b=izOV07iPNyupXghKvcSO0bkNp/4uWztEoSb7LF/k6nhhObnUOAbABXBQU1xxrPDQtbrPWBWNdB9BMds1UiDAUAc7kQYHx7TPqeUj7Ic7+lAj/DNfH8fLhJYWpi+DjoUKE12YdfR8QXTFDBgD+mjBxe/8iHCz+09ywojIZKpgI+S6fmmuW9qbDBVtoN38yWBwkbcSi0MdbUSEAkyXLNNNCPbU0ktR+lwAprxK2HmgKaCGJNQ/nCJXKhmYDG2RdGKZEYR/zJntS3IusPnswuZFcauoSdG/9pWU6cz7hbJ4mion2qpDTH+oTi6kPf3qtXvXnBpv2KORKCWgUC5N0tITZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6R3IhHcxrTMz0wEwyf94ZSQFtp+yYxgG53ZJ7dBIr8=;
 b=kEyGZwA1MuorP9deJVTmCjC0RQ+hNSnaKPOZD1YU9HoJjuX9ob864dgCUiZBxsOojYXpbRfsfVs8WeJiyMM9ukyQJFwdwl3QoP9FXI+33qEGkCjkHCqZOSUvtwOYdoMGAob+9QXTaWrVEVejqu6kXf48PNxCQHyMXZbPehhwK98=
Received: from BN9PR03CA0086.namprd03.prod.outlook.com (2603:10b6:408:fc::31)
 by IA1PR12MB6579.namprd12.prod.outlook.com (2603:10b6:208:3a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.37; Thu, 30 Mar
 2023 19:32:22 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::45) by BN9PR03CA0086.outlook.office365.com
 (2603:10b6:408:fc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:32:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:32:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/10] drm/amdgpu: Add initial version of XCP routines
Date: Thu, 30 Mar 2023 15:31:51 -0400
Message-ID: <20230330193158.1134802-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330193158.1134802-1-alexander.deucher@amd.com>
References: <20230330193158.1134802-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|IA1PR12MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f2fd32-eee1-4fd4-ac78-08db31557bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xe93YTTipoOD4vm4Q7Z/sA8J8RRPm1N4ZOWGrLs2Y7FajXDxoO2tPz1MoMMs6AJL1HdNmDGviB4wImSC9hjkEGh3hgxF5PGE3o3p9lxUGJd0BqVP8bWTs9KKtY3Op4zk7vfdeAKCuLnBLKsUHGBprlbGoDo74mfva3u7kGYDl0PVyzdgjtzznm/36Yq7dy/LNR788h3kGO/itUOGaH8S/pplWYH5+ML9D3nC6PDsUgIS+yj6P00BAW5eOn0R/ChKvc4U6ttIJCRUbUsIu1jtReVY+4wg33TQVuNwWfRUl4t9Opi3laDIRwHkN69FQ6xQC6vytUvJgvMPjUrqtnAddWZsdvN+Kaou6RQ1vICtl+oGFzRqYgArKVq9yqeYdKRn8UNkCiGn5sZVr/t2zpA/58qTQad+R1jQvrDqZvP7z2No7tVGthlh+3tw+mpG5IDrCVyW/NP3L0YKNqk9KHsZH2G2MLkuc/hxWuvFsLP4nGMa2nzHxQ6rSXz+dymj5QojyciSa5Sy6bXRs3vOXy1gbaooLmlaFRxfEJdyCCWyU8wJAGuxzCkDAib3eQv3HpEGc2NnxDvtvjtdFRsANnwPmGhYGjCChTvfqgfbnxK2AFQXBmDzvSap8izhmNxGCa7dLWfvM9qCPhU+mFpqBDG/IhTtG8f9tWAFvZKlnyHQWYVZ1/mQT14P7QoyNYUk15lq0ayX4huTKTThMx5kZ+GDJxsxZkCQvvObobMVP6tI0Uc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(66899021)(47076005)(81166007)(356005)(8936002)(6916009)(5660300002)(82310400005)(30864003)(40460700003)(4326008)(86362001)(82740400003)(70206006)(70586007)(8676002)(36756003)(40480700001)(41300700001)(83380400001)(186003)(1076003)(2616005)(336012)(426003)(36860700001)(54906003)(2906002)(6666004)(478600001)(7696005)(26005)(316002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:32:22.1187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f2fd32-eee1-4fd4-ac78-08db31557bc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6579
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Within a device, an accelerator core partition can be constituted with
different IP instances. These partitions are spatial in nature. Number
of partitions which can exist at the same time depends on the 'partition
mode'. Add a manager entity which is responsible for switching between
different partition modes and maintaining partitions. It is also
responsible for suspend/resume of different partitions.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c  | 244 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h  | 107 ++++++++++
 6 files changed, 356 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 8418a90df493..74a9aa6fe18c 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -60,7 +60,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
-	amdgpu_ring_mux.o
+	amdgpu_ring_mux.o amdgpu_xcp.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4a9817d2acaa..96269bc41107 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -286,6 +286,7 @@ extern uint amdgpu_user_partt_mode;
 #define AMDGPU_SMARTSHIFT_MAX_BIAS (100)
 #define AMDGPU_SMARTSHIFT_MIN_BIAS (-100)
 
+struct amdgpu_xcp_mgr;
 struct amdgpu_device;
 struct amdgpu_irq_src;
 struct amdgpu_fpriv;
@@ -786,6 +787,7 @@ struct amdgpu_device {
 	struct amdgpu_acp		acp;
 #endif
 	struct amdgpu_hive_info *hive;
+	struct amdgpu_xcp_mgr *xcp_mgr;
 	/* ASIC */
 	enum amd_asic_type		asic_type;
 	uint32_t			family;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index e48be6031c44..77e3c86b7623 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -61,7 +61,7 @@ enum amdgpu_gfx_partition {
 	AMDGPU_TPX_PARTITION_MODE = 2,
 	AMDGPU_QPX_PARTITION_MODE = 3,
 	AMDGPU_CPX_PARTITION_MODE = 4,
-	AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE,
+	AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE = -1,
 };
 
 #define NUM_XCC(x) hweight16(x)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 639b86c4d664..eb25ac98903f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -96,7 +96,7 @@ struct amdgpu_nbio_funcs {
 	void (*apply_l1_link_width_reconfig_wa)(struct amdgpu_device *adev);
 	void (*clear_doorbell_interrupt)(struct amdgpu_device *adev);
 	u32 (*get_rom_offset)(struct amdgpu_device *adev);
-	u32 (*get_compute_partition_mode)(struct amdgpu_device *adev);
+	int (*get_compute_partition_mode)(struct amdgpu_device *adev);
 	u32 (*get_memory_partition_mode)(struct amdgpu_device *adev);
 	void (*set_compute_partition_mode)(struct amdgpu_device *adev,
 					   enum amdgpu_gfx_partition mode);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
new file mode 100644
index 000000000000..f59bc450cabe
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -0,0 +1,244 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+ */
+#include "amdgpu.h"
+#include "amdgpu_xcp.h"
+
+static int __amdgpu_xcp_run(struct amdgpu_xcp_mgr *xcp_mgr,
+			    struct amdgpu_xcp_ip *xcp_ip, int xcp_state)
+{
+	int (*run_func)(void *handle, uint32_t inst_mask);
+	int ret = 0;
+
+	if (!xcp_ip || !xcp_ip->valid || !xcp_ip->ip_funcs)
+		return 0;
+
+	run_func = NULL;
+
+	switch (xcp_state) {
+	case AMDGPU_XCP_PREPARE_SUSPEND:
+		run_func = xcp_ip->ip_funcs->prepare_suspend;
+		break;
+	case AMDGPU_XCP_SUSPEND:
+		run_func = xcp_ip->ip_funcs->suspend;
+		break;
+	case AMDGPU_XCP_PREPARE_RESUME:
+		run_func = xcp_ip->ip_funcs->prepare_resume;
+		break;
+	case AMDGPU_XCP_RESUME:
+		run_func = xcp_ip->ip_funcs->resume;
+		break;
+	}
+
+	if (run_func)
+		ret = run_func(xcp_mgr->adev, xcp_ip->inst_mask);
+
+	return ret;
+}
+
+static int amdgpu_xcp_run_transition(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
+				     int state)
+{
+	struct amdgpu_xcp_ip *xcp_ip;
+	struct amdgpu_xcp *xcp;
+	int i, ret;
+
+	if (xcp_id > MAX_XCP || !xcp_mgr->xcp[xcp_id].valid)
+		return -EINVAL;
+
+	xcp = &xcp_mgr->xcp[xcp_id];
+	for (i = 0; i < AMDGPU_XCP_MAX_BLOCKS; ++i) {
+		xcp_ip = &xcp->ip[i];
+		ret = __amdgpu_xcp_run(xcp_mgr, xcp_ip, state);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+int amdgpu_xcp_prepare_suspend(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id)
+{
+	return amdgpu_xcp_run_transition(xcp_mgr, xcp_id,
+					 AMDGPU_XCP_PREPARE_SUSPEND);
+}
+
+int amdgpu_xcp_suspend(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id)
+{
+	return amdgpu_xcp_run_transition(xcp_mgr, xcp_id, AMDGPU_XCP_SUSPEND);
+}
+
+int amdgpu_xcp_prepare_resume(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id)
+{
+	return amdgpu_xcp_run_transition(xcp_mgr, xcp_id,
+					 AMDGPU_XCP_PREPARE_RESUME);
+}
+
+int amdgpu_xcp_resume(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id)
+{
+	return amdgpu_xcp_run_transition(xcp_mgr, xcp_id, AMDGPU_XCP_RESUME);
+}
+
+static void __amdgpu_xcp_add_block(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
+				   struct amdgpu_xcp_ip *ip)
+{
+	struct amdgpu_xcp *xcp;
+
+	if (!ip)
+		return;
+
+	xcp = &xcp_mgr->xcp[xcp_id];
+	xcp->ip[ip->ip_id] = *ip;
+	xcp->ip[ip->ip_id].valid = true;
+
+	xcp->valid = true;
+}
+
+static int __amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps)
+{
+	struct amdgpu_xcp_ip ip;
+	int i, j, ret;
+
+	for (i = 0; i < MAX_XCP; ++i)
+		xcp_mgr->xcp[i].valid = false;
+
+	for (i = 0; i < num_xcps; ++i) {
+		for (j = AMDGPU_XCP_GFXHUB; j < AMDGPU_XCP_MAX_BLOCKS; ++j) {
+			ret = xcp_mgr->funcs->get_ip_details(xcp_mgr, i, j,
+							     &ip);
+			if (ret)
+				continue;
+
+			__amdgpu_xcp_add_block(xcp_mgr, i, &ip);
+		}
+	}
+
+	xcp_mgr->num_xcps = num_xcps;
+
+	return 0;
+}
+
+int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int mode)
+{
+	int ret, num_xcps = 0;
+
+	if (!xcp_mgr || mode == AMDGPU_XCP_MODE_NONE)
+		return -EINVAL;
+
+	if (xcp_mgr->mode == mode)
+		return 0;
+
+	if (!xcp_mgr->funcs || !xcp_mgr->funcs->switch_partition_mode)
+		return 0;
+
+	mutex_lock(&xcp_mgr->xcp_lock);
+
+	ret = xcp_mgr->funcs->switch_partition_mode(xcp_mgr, mode, &num_xcps);
+
+	if (ret)
+		goto out;
+
+	if (!num_xcps || num_xcps > MAX_XCP) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	xcp_mgr->mode = mode;
+	__amdgpu_xcp_init(xcp_mgr, num_xcps);
+out:
+	mutex_unlock(&xcp_mgr->xcp_lock);
+
+	return ret;
+}
+
+int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
+{
+	int mode;
+
+	if (xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
+		return xcp_mgr->mode;
+
+	if (!xcp_mgr->funcs || !xcp_mgr->funcs->query_partition_mode)
+		return xcp_mgr->mode;
+
+	mutex_lock(&xcp_mgr->xcp_lock);
+	mode = xcp_mgr->funcs->query_partition_mode(xcp_mgr);
+	if (mode != xcp_mgr->mode)
+		dev_WARN(
+			xcp_mgr->adev->dev,
+			"Cached partition mode %d not matching with device mode %d",
+			xcp_mgr->mode, mode);
+
+	mutex_unlock(&xcp_mgr->xcp_lock);
+
+	return mode;
+}
+
+int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
+			int init_num_xcps,
+			struct amdgpu_xcp_mgr_funcs *xcp_funcs)
+{
+	struct amdgpu_xcp_mgr *xcp_mgr;
+
+	if (!xcp_funcs || !xcp_funcs->switch_partition_mode ||
+	    !xcp_funcs->get_ip_details)
+		return -EINVAL;
+
+	xcp_mgr = kzalloc(sizeof(*xcp_mgr), GFP_KERNEL);
+
+	if (!xcp_mgr)
+		return -ENOMEM;
+
+	xcp_mgr->adev = adev;
+	xcp_mgr->funcs = xcp_funcs;
+	xcp_mgr->mode = init_mode;
+	mutex_init(&xcp_mgr->xcp_lock);
+
+	if (init_mode != AMDGPU_XCP_MODE_NONE)
+		__amdgpu_xcp_init(xcp_mgr, init_num_xcps);
+
+	adev->xcp_mgr = xcp_mgr;
+
+	return 0;
+}
+
+int amdgpu_xcp_get_partition(struct amdgpu_xcp_mgr *xcp_mgr,
+			     enum AMDGPU_XCP_IP_BLOCK ip, int instance)
+{
+	struct amdgpu_xcp *xcp;
+	int i, id_mask = 0;
+
+	if (ip >= AMDGPU_XCP_MAX_BLOCKS)
+		return -EINVAL;
+
+	for (i = 0; i < xcp_mgr->num_xcps; ++i) {
+		xcp = &xcp_mgr->xcp[i];
+		if ((xcp->valid) && (xcp->ip[ip].valid) &&
+		    (xcp->ip[ip].inst_mask & BIT(instance)))
+			id_mask |= BIT(i);
+	}
+
+	if (!id_mask)
+		id_mask = -ENXIO;
+
+	return id_mask;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
new file mode 100644
index 000000000000..f0b973c6092f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -0,0 +1,107 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+ */
+
+#ifndef AMDGPU_XCP_H
+#define AMDGPU_XCP_H
+
+#include <linux/xarray.h>
+
+#define MAX_XCP 8
+
+#define AMDGPU_XCP_MODE_NONE -1
+
+enum AMDGPU_XCP_IP_BLOCK {
+	AMDGPU_XCP_GFXHUB,
+	AMDGPU_XCP_GFX,
+	AMDGPU_XCP_SDMA,
+	AMDGPU_XCP_VCN,
+	AMDGPU_XCP_MAX_BLOCKS
+};
+
+enum AMDGPU_XCP_STATE {
+	AMDGPU_XCP_PREPARE_SUSPEND,
+	AMDGPU_XCP_SUSPEND,
+	AMDGPU_XCP_PREPARE_RESUME,
+	AMDGPU_XCP_RESUME,
+};
+
+struct amdgpu_xcp_ip_funcs {
+	int (*prepare_suspend)(void *handle, uint32_t inst_mask);
+	int (*suspend)(void *handle, uint32_t inst_mask);
+	int (*prepare_resume)(void *handle, uint32_t inst_mask);
+	int (*resume)(void *handle, uint32_t inst_mask);
+};
+
+struct amdgpu_xcp_ip {
+	struct amdgpu_xcp_ip_funcs *ip_funcs;
+	uint32_t inst_mask;
+
+	enum AMDGPU_XCP_IP_BLOCK ip_id;
+	bool valid;
+};
+
+struct amdgpu_xcp {
+	struct amdgpu_xcp_ip ip[AMDGPU_XCP_MAX_BLOCKS];
+
+	uint8_t id;
+	uint8_t mem_node;
+	bool valid;
+};
+
+struct amdgpu_xcp_mgr {
+	struct amdgpu_device *adev;
+	struct mutex xcp_lock;
+	struct amdgpu_xcp_mgr_funcs *funcs;
+
+	struct amdgpu_xcp xcp[MAX_XCP];
+	uint8_t num_xcps;
+	int8_t mode;
+};
+
+struct amdgpu_xcp_mgr_funcs {
+	int (*switch_partition_mode)(struct amdgpu_xcp_mgr *xcp_mgr, int mode,
+				     int *num_xcps);
+	int (*query_partition_mode)(struct amdgpu_xcp_mgr *xcp_mgr);
+	int (*get_ip_details)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
+			      enum AMDGPU_XCP_IP_BLOCK ip_id,
+			      struct amdgpu_xcp_ip *ip);
+
+	int (*prepare_suspend)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
+	int (*suspend)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
+	int (*prepare_resume)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
+	int (*resume)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
+};
+
+int amdgpu_xcp_prepare_suspend(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
+int amdgpu_xcp_suspend(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
+int amdgpu_xcp_prepare_resume(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
+int amdgpu_xcp_resume(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
+
+int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
+			int init_xcps, struct amdgpu_xcp_mgr_funcs *xcp_funcs);
+int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr);
+int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int mode);
+int amdgpu_xcp_get_partition(struct amdgpu_xcp_mgr *xcp_mgr,
+			     enum AMDGPU_XCP_IP_BLOCK ip, int instance);
+
+#endif
-- 
2.39.2

