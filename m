Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB73CEBF69
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 04:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94DD510EC09;
	Fri, 27 Sep 2024 04:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zh/e8zAu";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D01DD10EC0C
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 04:58:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7WZphTMcv7680FPtsnvQ2AGukqc954J1rW89ZJ9Lxy3sq1iVGKuy1o+QNV3yfY/gDrE+afX0aR425He4k7bkViZQysaqDNhiGm8XwgHQbI7HT0+8HwtHdsvwPPPIsXzdsqKxmcz1NqICDsVhYSLzPmV2FNPEsBanIEALTDFsRn0h4B3yR9eo8E0wOWK8gNbXbTkqy68xWkKD1EyL4oLJv42RWnXJezNJSpOiAgVRQRsO37PYGhHpledqxQ6hGAZJIaBmsfPLo1JLZ4kUA2FHFwGKvmSXzn7kqJlTIhs5DOmsTuwtQjV/qANuc5/Mj6t1OwaPdlSeZnRGO4Up+H25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOvVjCz3Yg0s73Ft+V+VcEC4dFGNeMlCQjZOCdFJOEQ=;
 b=eF1ssayK5e72L1ApUOZKEBjVjpr5jQGltiRxJ7BTnsm1S9Se8WM4nUGff4uV+iG9ML7b4TZZ2W4EM29dVaQV5r+YmtMRN74KphnyhsRB6TmOSw+wDenCYUvJNnVHikH9Ak9Emh/+JeCJenWVLRmBnAOPdIy/JpH+Q9x/AVcNdm3y6pXQqt1CabBUaESrrB+UBvD+ZDKgWwG1yBDl32NS8hLqqp+33KgdGXkI9fALR0Vu9PMloMafGELM2V9I6D+mxSlXYcfEIzAQv0Zs8APz8RZLeRic4Twqhyh1U68gM10STGCg97xIPXE/RvOpcWEu9BEpXGNCbW58kUJXEJ+9yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOvVjCz3Yg0s73Ft+V+VcEC4dFGNeMlCQjZOCdFJOEQ=;
 b=zh/e8zAuhbTGVRNdEaEoWogECs0OHEeNb5OkRTtITno+rXxBTmThZU41NI6zFfQB1fR5oeO4hgcVJEOc/4xz99xMfGyYJ8Mdytu902SoEusafNGOd8LcFpHYYLSo52ziHg13EyzrqyqcwGZ5a07nQKR/CD6TGi9hOE7un4uYVK8=
Received: from BYAPR08CA0068.namprd08.prod.outlook.com (2603:10b6:a03:117::45)
 by IA1PR12MB8466.namprd12.prod.outlook.com (2603:10b6:208:44b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 04:58:09 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::27) by BYAPR08CA0068.outlook.office365.com
 (2603:10b6:a03:117::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30 via Frontend
 Transport; Fri, 27 Sep 2024 04:58:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 04:58:08 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Sep
 2024 23:58:05 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <rajneesh.bhardwaj@amd.com>, <Ramesh.Errabolu@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH v2 2/7] drm/amdgpu: Add PSP interface for NPS switch
Date: Fri, 27 Sep 2024 10:27:38 +0530
Message-ID: <20240927045743.2718949-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240927045743.2718949-1-lijo.lazar@amd.com>
References: <20240927045743.2718949-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|IA1PR12MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: e2db3a8d-c101-4f18-adbd-08dcdeb0fae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OMq38sDSDSitSeyeKZiER34FNVDLanaQlUigmAFikE7mZYmVZ1c1sRX4OxgO?=
 =?us-ascii?Q?MMKLDFI3TVNAKpuaCZrAruUpOJyrckU78IvZi+dqAJ4yNeoCXjVQFU5UFH5f?=
 =?us-ascii?Q?XukNRmJO7qqJxBu+keeJUIRSe9IO8mzsxVCvUgUTkQ8+6Fx2LeMadfhmZl8Q?=
 =?us-ascii?Q?xOH574Sx6eALCEQvVQjaDeEa/2ajMrx95c1mollrT/ChXGFfv51mo2fdfU+E?=
 =?us-ascii?Q?WMBsh3wPi/gOjBZw7O03jz2uyPvP5vBkqfA99GtXDyy9ONIqWFDv6KGtCvQ+?=
 =?us-ascii?Q?xm4tIS0Tgq6uJfNg8P2+r0IqUaJ2FWk48F8/D2HGcZfgrsXbE9l92iX3bLHM?=
 =?us-ascii?Q?EWza5C46KeRgwm5NQbyht+DwqTd8GsUSYjnVRwHkM7JBmEc+zqpGD9JXYuky?=
 =?us-ascii?Q?8WAszZravBxAE3ka814B6J2teAfmtT86MVWEw+2I+sUYD+aMWtk4itoNMZMs?=
 =?us-ascii?Q?VJB9vQGl6+75WKx/X4XKpDJnVvoTIzxJ2B0esxCajFt7xT6Pl8U97zR74tbE?=
 =?us-ascii?Q?dGufnpFl5gustfW1DUmPRBsC25TsYwNioiDl2MLV5/X1Rgfp6Dkjwsna2jB9?=
 =?us-ascii?Q?p/T5S7/2Am+jrHEu4lLOrVyFlrsF5G8i+Vq9yXB+x2Dw2cTWxPV/h80A6e79?=
 =?us-ascii?Q?S8TB7BHqeFl2eP48tDr/J2wHM1VZUp9OaSe82dbCYyY3RMU3OOCKQXXlDIlx?=
 =?us-ascii?Q?uDiZON6jsvnv0y3fPqeeYDcuhEh+TwNSbuNnPDHqGndO8MqKBbvdNqP51afT?=
 =?us-ascii?Q?7j6u56xVqWzfU3LFlFQgUwVKpAAbzjwg+gs+6Y8+5fiU9MTVkLyXL8FLFMeG?=
 =?us-ascii?Q?N7fR0Q7q7LQOfaDf21M3EZnQSMqTFAZXdzu4HoLN7V5XGajg2wBkptiUgt9I?=
 =?us-ascii?Q?3M4QheSZ3SACPRNQ1u7GF8kmzLTqaRAABeRERFylb3+g4OW71kwLVL6X8ia6?=
 =?us-ascii?Q?89H/SCrB/pXRrzzxiloXUFwadWucDgdGeQjFu9MY/DtthPSobpVbFnjVzRKn?=
 =?us-ascii?Q?JUoxUFxA+4CNqpVzi+zQW6X2/8L4q/ukpldxKzc8j2aR3xQKzYsjau4ivCuk?=
 =?us-ascii?Q?lRvSbN3HOUVpg/A8GdxEeucVfodHTin+fenu2EPfSIbA5xUtNTrfyhwcEa/v?=
 =?us-ascii?Q?jVrziroPs1QRrx7sHljJGbgBsDNcSoZiiyogalkWm/xhsztmuQythxMyGFGw?=
 =?us-ascii?Q?mBLr43N6OMsx76kMB0+JGoWESAbR6Tb7+fpoRNC5CFdDZlqbmsjIxIKb793s?=
 =?us-ascii?Q?mEF8ELvyHxsyeKZqqcefYLeooH+bXCWdFnnxakHaDXYboWvYQOzx/Ramp//v?=
 =?us-ascii?Q?DAxC+5+k0jDIHETv7vsGHWwq8xrGmVoCvwMaQd6OQRsndNLae3hxLsqHUGRq?=
 =?us-ascii?Q?Q2QwhsI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 04:58:08.3328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2db3a8d-c101-4f18-adbd-08dcdeb0fae5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8466
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

Implement PSP ring command interface for memory partitioning on the fly
on the supported asics.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 14 +++++++++++---
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 944dad9ad29f..04be0fabb4f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1045,6 +1045,31 @@ static int psp_rl_load(struct amdgpu_device *adev)
 	return ret;
 }
 
+int psp_memory_partition(struct psp_context *psp, int mode)
+{
+	struct psp_gfx_cmd_resp *cmd;
+	int ret;
+
+	if (amdgpu_sriov_vf(psp->adev))
+		return 0;
+
+	cmd = acquire_psp_cmd_buf(psp);
+
+	cmd->cmd_id = GFX_CMD_ID_FB_NPS_MODE;
+	cmd->cmd.cmd_memory_part.mode = mode;
+
+	dev_info(psp->adev->dev,
+		 "Requesting %d memory partition change through PSP", mode);
+	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+	if (ret)
+		dev_err(psp->adev->dev,
+			"PSP request failed to change to NPS%d mode\n", mode);
+
+	release_psp_cmd_buf(psp);
+
+	return ret;
+}
+
 int psp_spatial_partition(struct psp_context *psp, int mode)
 {
 	struct psp_gfx_cmd_resp *cmd;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 76fa18ffc045..567cb1f924ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -553,6 +553,7 @@ int psp_load_fw_list(struct psp_context *psp,
 void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size);
 
 int psp_spatial_partition(struct psp_context *psp, int mode);
+int psp_memory_partition(struct psp_context *psp, int mode);
 
 int is_psp_fw_valid(struct psp_bin_desc bin);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 604301371e4f..f4a91b126c73 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -103,8 +103,10 @@ enum psp_gfx_cmd_id
     GFX_CMD_ID_AUTOLOAD_RLC       = 0x00000021,   /* Indicates all graphics fw loaded, start RLC autoload */
     GFX_CMD_ID_BOOT_CFG           = 0x00000022,   /* Boot Config */
     GFX_CMD_ID_SRIOV_SPATIAL_PART = 0x00000027,   /* Configure spatial partitioning mode */
-	/*IDs of performance monitoring/profiling*/
-	GFX_CMD_ID_CONFIG_SQ_PERFMON = 0x00000046,   /* Config CGTT_SQ_CLK_CTRL */
+    /*IDs of performance monitoring/profiling*/
+    GFX_CMD_ID_CONFIG_SQ_PERFMON  = 0x00000046,   /* Config CGTT_SQ_CLK_CTRL */
+    /* Dynamic memory partitioninig (NPS mode change)*/
+    GFX_CMD_ID_FB_NPS_MODE         = 0x00000048,  /* Configure memory partitioning mode */
 };
 
 /* PSP boot config sub-commands */
@@ -362,6 +364,11 @@ struct psp_gfx_cmd_config_sq_perfmon {
 	uint8_t         reserved[5];
 };
 
+struct psp_gfx_cmd_fb_memory_part {
+	uint32_t mode; /* requested NPS mode */
+	uint32_t resvd;
+};
+
 /* All GFX ring buffer commands. */
 union psp_gfx_commands
 {
@@ -376,7 +383,8 @@ union psp_gfx_commands
     struct psp_gfx_cmd_load_toc         cmd_load_toc;
     struct psp_gfx_cmd_boot_cfg         boot_cfg;
     struct psp_gfx_cmd_sriov_spatial_part cmd_spatial_part;
-	struct psp_gfx_cmd_config_sq_perfmon config_sq_perfmon;
+    struct psp_gfx_cmd_config_sq_perfmon config_sq_perfmon;
+    struct psp_gfx_cmd_fb_memory_part cmd_memory_part;
 };
 
 struct psp_gfx_uresp_reserved
-- 
2.25.1

