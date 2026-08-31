Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89352C624D1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F40010EA95;
	Mon, 31 Aug 2026 18:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g7i2tOWS";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0FB310EA7B
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aroqtv6yk0GRSoSOH1yIYxZhc/YIElbkw0md7M7Unw7NFpgqZiJGNfRgfjPzs8ys//RkIY4q0F+LW/WZiBBEEF0a7nUq9Fchjci09x+r9hDv4HwWOYMGNn78AyHXSxAmPX4QofLDMj20oCL+x2AIs8o/UVR4o0BwbGMa18WBmYGDEFgev/ctIBLuxp/wkvyxIqX0AzKN7sSPxlZCNlJuvBF6ahzTEd93WcfX3uGnS4XEaanHjroIjfSi6TQH/enni+AqsIlE23xvirF6LChL5zaZbdTAsgu3IhVzC3rxgWCjhxc8L0oXV651ak+UYJ2BYgBBGDAZRo9nSW2F1aiAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8Q6+LEUVKMWQoTRCD7KDqPnYFaNiD2Y9miMpay38XY=;
 b=hzxT0qJkw/RMQ45QdR2+Ny1FltPsBMClXz6ewJjelD0JW9khKkG8Iy+fVmPkfEIK8+QRZuuLBZ0lSShUXeCdtYy+J64zcQV6R0JFSyJQx9cnxb8+jFDQhro/gaCF7szbVnRjjc5PKtc7+pbGNLw+j5I06wEDSqSXAa6U3iC5cR7XftdG+VnHGltAFdCsMQmyugYRKWlRkptRz4EpRNyPCNCVUMWFBPYXuYhBGDfO13zGzGd9r64dkUZMjvHAgSovW9xZ100GAOzN+vRnYWgzQC+ot4L8V76v7/+nOFEqYjqUygmsH+MHBofn5rS/jIm1gKsukoJ9sTadtpXGDwioZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8Q6+LEUVKMWQoTRCD7KDqPnYFaNiD2Y9miMpay38XY=;
 b=g7i2tOWSMereWvASs/FEz4b4RYYE/UL+XVt3MNL0E38D3FsmIueBgRyHCuBzg5ZLPgbDxJlX+z/7REvGRXyJLwXetbeJcYCGpVCnVrtTelsCmv+TYdSiCc6NwCwSJE0JQ0LJA1kmh6/Pn1kxYQaouX/tcAxIUzCkPZKqOoLQ2mU=
Received: from CH5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:610:1f1::9)
 by DS0PR12MB8576.namprd12.prod.outlook.com (2603:10b6:8:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:16 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::20) by CH5PR03CA0012.outlook.office365.com
 (2603:10b6:610:1f1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:58 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 81/95] drm/amdgpu: Add handlers for ualink notifications
Date: Mon, 31 Aug 2026 14:27:40 -0400
Message-ID: <20260831182754.1089811-82-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|DS0PR12MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: c85ee32c-d765-4b2c-d1e0-08df078dc3c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|10067099003|11063799006|56012099006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rNbZxAdvJC0mLLLrArzoJ0ORP+8lRIVPEBS2p24lhagZnznTlRzIj/pZUxIaNGA0y0CfAINtp+SxZDKtgP8RyrP+MexGc+qpFWxuRPSZ07vdF6mpZv9N5R1s2uBqUYHX38mJdeF7HLM0KE1z6p3MKSIqdcNET00lc4v7i5p9a+mbSKK32fwSFxd6V3tE0GpzOxmaigxPCAW11mavXcAB11cqYikmmBSzc+SvXVhrDY41vqFv9lZX5JjTKLSNptZ1q7YQWyDyTHimMfyOcFBIUtAGfEMEVpSoEMZeqZA7JZ1i7lwSdDJlr3fMP2X1LlApf9XjpcpjPPmBbmi3BJnCvLqHjIEv9yk7M7sMYMnZgsDI5q82F1oob6AEFInlpE8nHM+VhLbeTXO3K4QjgYhp/dA78SQVN5WWnCoH5EkNqaoMFwXV4U4o94hWvHTz/aAjiTLf5MrQttmoDHQCN/M8p93JwD9JDZGsHH5H81sjAhZiAfMHe1LBoh7VEOg9VjHQzxQa8qhYsn9ms73DfVbioV5oeiibwp+vB8+CRlU9o0EqYRfhQKGwJM3HdEb4nmDUV+qsk1BS9f8oQ48JgpTSfeOreC0YsqgUlRK630sj3dWvVzvWl2qdQl5m/Z4YV1oQi2uxi6b9zEs4gHq3qA11wBKZ71yeOXUSI25ggoUb3gvVF+WXuJS6FeLUMz+CMgwAVatn6n6Sof+qjH4EyYHIAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gJH2eT02ZQErOii7tDQf4O6ImJgjipqvD8MUS/O8ok8CC9+0zevGRCHJtfiYmy/iLeMjtplyChTlz1hKXOhoT5/9xwRMASR0n4DRQFE67twJAwiy7udcpXCDPY/oy/d+l/cxRztNxSSPtXVlGkxiXB1f3gbehS1y9ftXjnS/KRcXERR70KRVgKXjGq4g1SAKOvntinGW15GVe1tLkEv3yTMdvw5qO8XhuK4NNT2LfVHqSycGvTnTD26o1eDHAPAB4wvfCr5CqM464exEQSV/HN+wEk2LMGMNzwokwlblE34FzGYx3m5CmaPSmnhNfmKzk1jEWvGZhuMuh9FSwTQ2LU1zGuv8hOYY385OCx7uC6jPbDwMoweY50gUkSVd+l4/qT5PTvWxIpyaf47gr3vC6evpeHHjevp6kAGhvBQvhBdvLerFPIIHkI4qJlz+q51C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:16.5684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c85ee32c-d765-4b2c-d1e0-08df078dc3c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8576
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add handlers for ualink notifications from ASP. Pause/Resume
notifications are not handled currently.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 64 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  3 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h    | 34 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c   | 48 +++++++++++++++-
 4 files changed, 143 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 5efee75faddb2..de79b2ea1f99a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -204,6 +204,70 @@ static int amdgpu_ualink_query_info(struct amdgpu_device *adev)
 	return 0;
 }
 
+int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev)
+{
+	int r;
+	u32 status = 0;
+
+	/* TBD: Stop ASP interrupts if driver faced an issue */
+	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_COMPLETE) {
+		dev_dbg(adev->dev,
+			"UALink not initialized, skipping config update\n");
+		status = !!(adev->ualink.mgr_state == AMDGPU_UALINK_INIT_ERROR);
+		goto out;
+	}
+
+	/*TBD: find the right value of status to be sent to ASP*/
+	r = amdgpu_ualink_query_info(adev);
+	if (r) {
+		dev_info(adev->dev, "UALink config update failed %d\n", r);
+		status = 1;
+	}
+
+out:
+	return psp_ual_send_completion(&adev->psp, adev->ualink.psp_if_ver,
+				       PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID,
+				       status);
+}
+
+int amdgpu_ualink_pause_handler(struct amdgpu_device *adev)
+{
+	u32 status = 0;
+
+	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_COMPLETE) {
+		dev_dbg(adev->dev,
+			"UALink not initialized, skipping pause update\n");
+		status = !!(adev->ualink.mgr_state == AMDGPU_UALINK_INIT_ERROR);
+		goto out;
+	}
+
+	dev_dbg(adev->dev, "UALink pause command is not handled\n");
+
+out:
+	return psp_ual_send_completion(&adev->psp, adev->ualink.psp_if_ver,
+				       PSP_GFX_INT_CTXT_UAL_CMD_PAUSE_ID,
+				       status);
+}
+
+int amdgpu_ualink_resume_handler(struct amdgpu_device *adev)
+{
+	u32 status = 0;
+
+	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_COMPLETE) {
+		dev_dbg(adev->dev,
+			"UALink not initialized, skipping pause update\n");
+		status = !!(adev->ualink.mgr_state == AMDGPU_UALINK_INIT_ERROR);
+		goto out;
+	}
+
+	dev_dbg(adev->dev, "UALink resume command is not handled\n");
+
+out:
+	return psp_ual_send_completion(&adev->psp, adev->ualink.psp_if_ver,
+				       PSP_GFX_INT_CTXT_UAL_CMD_RESUME_ID,
+				       status);
+}
+
 int ualink_ip_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 6f522bcafa442..ce8b643811dfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -391,6 +391,9 @@ void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
 
 int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id);
 
+int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev);
+int amdgpu_ualink_pause_handler(struct amdgpu_device *adev);
+int amdgpu_ualink_resume_handler(struct amdgpu_device *adev);
 
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 77be21c3eada3..0803cfc445dc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -400,11 +400,35 @@ struct psp_gfx_cmd_req_perf_hw {
 #define PSP_GFX_UAL_MAX_STATIONS_V1     64       /* max UALink stations */
 #define PSP_GFX_UAL_MAX_ACC_BIT_MASK    32       /* max accelerator bit mask 32*32 */
 
-enum psp_gfx_ual_npa_address_mode
-{
-    PSP_GFX_UAL_NPA_ADDRESS_MODE_SOURCE_ALIASING = 0,
-    PSP_GFX_UAL_NPA_ADDRESS_MODE_SOURCE_IDENTIFICATION = 1,
-    PSP_GFX_UAL_NPA_ADDRESS_MODE_MAX
+/* Interrupt category identifiers (upper byte) - ASP interrupts to Driver */
+
+/* Commands from ASP */
+#define PSP_GFX_INT_CTXT_UAL_CAT_CMD 0x01000000
+/* Mask for Command bits */
+#define PSP_GFX_INT_CTXT_UAL_CAT_CMD_MASK 0x000000FF
+/* Notifications from ASP */
+#define PSP_GFX_INT_CTXT_UAL_CAT_NOTIFY 0x02000000
+/* Mask for category bits */
+#define PSP_GFX_INT_CTXT_UAL_CAT_MASK 0xFF000000
+
+#define PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID 0x00000001
+#define PSP_GFX_INT_CTXT_UAL_CMD_PAUSE_ID 0x00000002
+#define PSP_GFX_INT_CTXT_UAL_CMD_RESUME_ID 0x00000003
+
+/* Command interrupts from ASP (GIM must execute action) */
+#define PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE \
+	(PSP_GFX_INT_CTXT_UAL_CAT_CMD | PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID)
+
+#define PSP_GFX_INT_CTXT_UAL_CMD_PAUSE \
+	(PSP_GFX_INT_CTXT_UAL_CAT_CMD | PSP_GFX_INT_CTXT_UAL_CMD_PAUSE_ID)
+
+#define PSP_GFX_INT_CTXT_UAL_CMD_RESUME \
+	(PSP_GFX_INT_CTXT_UAL_CAT_CMD | PSP_GFX_INT_CTXT_UAL_CMD_RESUME_ID)
+
+enum psp_gfx_ual_npa_address_mode {
+	PSP_GFX_UAL_NPA_ADDRESS_MODE_SOURCE_ALIASING = 0,
+	PSP_GFX_UAL_NPA_ADDRESS_MODE_SOURCE_IDENTIFICATION = 1,
+	PSP_GFX_UAL_NPA_ADDRESS_MODE_MAX
 };
 
 enum psp_gfx_ual_ports_per_station
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
index 85857b747bd46..dcfc9be269b07 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
@@ -428,6 +428,48 @@ static const struct amdgpu_irq_src_funcs psp_v15_0_8_irq_funcs = {
 	.process = psp_v15_0_8_irq_process,
 };
 
+static void psp_v15_0_8_ual_cmd_cfg_update(struct amdgpu_psp_irq_mgr *mgr,
+					   u32 event_id,
+					   struct amdgpu_iv_entry *entry)
+{
+	struct amdgpu_device *adev = mgr->psp->adev;
+
+	amdgpu_ualink_config_update_handler(adev);
+}
+
+static void psp_v15_0_8_ual_cmd_pause(struct amdgpu_psp_irq_mgr *mgr,
+				      u32 event_id,
+				      struct amdgpu_iv_entry *entry)
+{
+	struct amdgpu_device *adev = mgr->psp->adev;
+
+	amdgpu_ualink_pause_handler(adev);
+}
+
+static void psp_v15_0_8_ual_cmd_resume(struct amdgpu_psp_irq_mgr *mgr,
+				       u32 event_id,
+				       struct amdgpu_iv_entry *entry)
+{
+	struct amdgpu_device *adev = mgr->psp->adev;
+
+	amdgpu_ualink_resume_handler(adev);
+}
+
+static const struct amdgpu_psp_irq_handler psp_v15_0_8_ual_irq_handlers[] = {
+	{
+		.event_id = PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE,
+		.callback = psp_v15_0_8_ual_cmd_cfg_update,
+	},
+	{
+		.event_id = PSP_GFX_INT_CTXT_UAL_CMD_PAUSE,
+		.callback = psp_v15_0_8_ual_cmd_pause,
+	},
+	{
+		.event_id = PSP_GFX_INT_CTXT_UAL_CMD_RESUME,
+		.callback = psp_v15_0_8_ual_cmd_resume,
+	},
+};
+
 static int psp_v15_0_8_register_irq_handler(struct amdgpu_psp_irq_mgr *mgr,
 					    struct amdgpu_irq_src *irq_src)
 {
@@ -443,7 +485,11 @@ static int psp_v15_0_8_register_irq_handler(struct amdgpu_psp_irq_mgr *mgr,
 	if (ret)
 		return ret;
 
-	return 0;
+	ret = amdgpu_psp_irq_mgr_register(
+		mgr, psp_v15_0_8_ual_irq_handlers,
+		ARRAY_SIZE(psp_v15_0_8_ual_irq_handlers), NULL);
+
+	return ret;
 }
 
 static const struct psp_funcs psp_v15_0_8_funcs = {
-- 
2.55.0

