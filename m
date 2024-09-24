Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B2DCF9C71
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 05:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E58CF10E4CA;
	Tue, 24 Sep 2024 05:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mQHGP7Qw";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09A9110E4CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 05:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+b2G3KgiXbNEii4NibR/lJIWWqcbWydJaeMSUfkr0MsmzDH//WBjmc5dEoxRZzqLrDfnBqp998zy7/R10okZbgKZInrwWA7icy6DyXCWpnWi2YHIpNs5KFO8BOkD0CRFzAQbZ+E0M0BYFdO3Qx+zfqfy50t4QcNUwGkjLnomDBp2eBOGskYOzfEce63ISyY0Jb1cY5rJPOYU+vLdtgcFjgczL+clCm6VDZA/fdtVjuDdf7y8KKoSZAjkcG7TEoP900HOUnsjBoJXQvJLOg7HPL4BNLFsMQIO+ugTfilWM6nCzB/N64NcaHiIfPK+vrwSTv1ir7QNYe7jcp7Vkbvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7GwlKDmMGrd8S8dTNEoWJphdDBHLxqNXCBcrI/pObM=;
 b=YrNCfiSbSP47QoToysur/MZjlu9eeiFvNcJCcU3haOA78jT+5LQ4E52hx9fSTYJugfgErCjJ8nbUr0Feel1bITegt3XgTuF7oJ2v3Y1mBUNhHlJEB4iQL+zr6Amq+ELwTwvMGtBp1eltANsXFkP8aQaB4kQ23zcr7+h6kw5px3sCo2mPjPIrwlGqBOYADHUcn6IgQoxekhuQ0D6aiaP7NQnk2XOwvWhJmG1rCacSYIRSOhywfm9Z83NaNEuJ+/GPjSA5XpNIblfCh6vDMAlD+jTvUuy+vaRf4eNNCULqCBBDfPZ6Te4iAUGTcIjFqRkkZhdgTj+xP5TgPWp7kvd2Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7GwlKDmMGrd8S8dTNEoWJphdDBHLxqNXCBcrI/pObM=;
 b=mQHGP7QwNfcu09wcGQUX8/inOhVyRCZ+Ec3/XO3tCiHEC2eb8dqwPnn7lrSMvrSO6xgHI3UdsyuwbDdbipaYKX1DN1dajb4T/8W9tsg6vnKmsltbkSOEucmbFd3YdYhoZG3FSmnoWMrbJpZx/Xgrh+uH0Bd5/cWkszkkNX/1WuQ=
Received: from DS7PR05CA0091.namprd05.prod.outlook.com (2603:10b6:8:56::12) by
 SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 05:57:18 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::9f) by DS7PR05CA0091.outlook.office365.com
 (2603:10b6:8:56::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.16 via Frontend
 Transport; Tue, 24 Sep 2024 05:57:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 05:57:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 00:57:15 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <rajneesh.bhardwaj@amd.com>,
 <Ramesh.Errabolu@amd.com>
Subject: [PATCH 2/7] drm/amdgpu: Add PSP interface for NPS switch
Date: Tue, 24 Sep 2024 11:26:47 +0530
Message-ID: <20240924055652.2678433-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240924055652.2678433-1-lijo.lazar@amd.com>
References: <20240924055652.2678433-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9f35cc-e0c9-401b-2194-08dcdc5dbf84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lJGzU+fNpAnApdnG/GZ+0bjFtFIkEHAOIbcoQcEWB2HOBMfmVpFpQjCdE8+C?=
 =?us-ascii?Q?ZawJhN951ebr0gK0XCbJymRXsedEkr4UCwbkTHF2RbGSxQjqC20w+qpVsHT/?=
 =?us-ascii?Q?4Umwl1s35ce075W5btKqvC5dvYpO4ogHSSUvGiWMeDsFHAkEAeXfLnXzk8Kz?=
 =?us-ascii?Q?LXipBesVdSSJtdxcZraYEDCy/J2O0VZeSXe15XdZMEqc5N/kL/O5BnpK81lR?=
 =?us-ascii?Q?eQCxH+tGd+BXrBqgAPL7Kvli9crdGkSUBQ6qD2XjwsW43MpRCyXPcSoLvJjK?=
 =?us-ascii?Q?3JqQFbutjFBKE7IG8gZD9Ghic7fHAYEzZfGjkg24/9TaSrrz2/sI2Uawn4M7?=
 =?us-ascii?Q?6YPv4Z1HWyWfBa+IYN8mI1rTNIg+v0jEkoeicf4+T4DVx0RzSmTZvpuawFoM?=
 =?us-ascii?Q?yqBfHnRckSNCLSkb8VbJ7LQO/KyF3Lyl96A5c1psd8S+zI9LAGg5Cr5+M3Lr?=
 =?us-ascii?Q?PnvNIK7I9UFSZf8k4P+sNYGAHh83OEMkolMerqaM/TDYHq/E7+ia/5vU6qd2?=
 =?us-ascii?Q?PMHzj6bPe2eYJLnx9vR0pZlGP5qnmxnvlZFrdBqgI4Nl0UnBmvkwItHi+ZPg?=
 =?us-ascii?Q?ERnyT6UtARbgbkg9aPtPB2k+jwb696Acrj0D/Hov+4LfMfI8+jcXVsiKdJ0g?=
 =?us-ascii?Q?9p/Zw6ukvV6HvLBHoACTfdqr1nsHoNMJoY8HPmTnNjvJ9sA9TQuvz9Dfl2W6?=
 =?us-ascii?Q?G+CihRmZKRp3+pjIHX8BKVs3+qQo5jYJTUyKogjc2s2aG+TxP6Fh9vdW16D+?=
 =?us-ascii?Q?8ubCtqeTnC5GL7GLAD3uv7NkPGA/PrHlgfw3+VqxXY5KcnaYAXzs0kRhrpDj?=
 =?us-ascii?Q?MfmUhInJ4pvqcg2P2nwVuCgpRHUWJ5/SmpF/XtQNkwZNegEglKxglKfj0Ufq?=
 =?us-ascii?Q?Vbg8C4Ay5mzAcp5wL93PzSBCeicn340AoOxKouZ9C6Nkn81cSQoSFF2bFjQg?=
 =?us-ascii?Q?0lE2ZdEnksX+RhDdN3hHif3xlpoWMlNghwJUWdpdbSuwcE+D1SoAaCGkPg9e?=
 =?us-ascii?Q?9t34eGNAPmvRW6zrv3ziwcUyxEmv0n3XIP24/23047lNbylf5oGCCy7u8fWx?=
 =?us-ascii?Q?g/m8Ia19I/dXJ4okSo5BxTk3fGVPe0UvJJWZyYimCXWKuV9WWDyLF8s22+wx?=
 =?us-ascii?Q?qLibN3ua+eBpo+XFz5Jyim1LMcacKNtVRTfUHhNHnnMgXDqHYJnjxojMspn/?=
 =?us-ascii?Q?OJph54SSdrnpZhoKhk6XqNhTeZDvZYRjSy9vRG/iLHgCvWlinp0lbuqtr3/Q?=
 =?us-ascii?Q?knIya+rzQP0X6SfcPIPJe9lNUooPAqxeA+XDuV1LS/YCf8RzhxVNR4Cc71y7?=
 =?us-ascii?Q?ywUmfTgBeamUqhbGAuOMeWzS9j49A0SyYOEdnPBD69vnGW8U3tEsKrZK1rC4?=
 =?us-ascii?Q?iabICksq9j69S8OIJebrlt/E4d82iu6rUzEY3IPRLc00qD2WXvUczTd15HJ9?=
 =?us-ascii?Q?/7XsgiZM3qyqYMM8oQ96MaFutcOoY52L?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 05:57:18.1850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9f35cc-e0c9-401b-2194-08dcdc5dbf84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772
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

