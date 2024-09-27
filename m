Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B649CEBF69
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 04:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 117DA10EC0B;
	Fri, 27 Sep 2024 04:53:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DKSoBuuh";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61FB010EC0B
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 04:53:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KA0mqfMrcjt47lJnNzSnbcaXgdWxemqx0nj/KZra689XjnXF+nYXnxIqiL23h021KgXeMUmUM7xvVY17OFI1YUARakSjkUzho0NGmNSoOcRebcWUnXUzt32W/YQ3xbRix5qGv66o/lEEN/ZUnyD//OIO/G4CqURGWbqSTwt7QN/ltrmRKojBy1kzusxSpxveZj5PKMLsUBOrEjSyP6n5Oqb8hBRz7CbduLVAo8a5XHvzvHTs6x/M4wvL3tRUFdGJIw0vwA7KX1L9x44Qj4sxAUyUnUR9O6vi5O5W4HdJv/SNvM1oxaOQGdiVKZs0MyP8TQG9cpC9fD6DG45ZbfUW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOvVjCz3Yg0s73Ft+V+VcEC4dFGNeMlCQjZOCdFJOEQ=;
 b=ohLvwayB+B1jWUT4ssCZ8cch1sHCjgCcAYwGEN3XbfIYgUw+1lpcMzCgEic+QVb1nb7V8BPIMEWKJw5F97YWpcf18WYirEYuRR4f+6yor+RTgAgtroXtBI3PPTxeExTKoCtgbht+EZ39zwFqnqM5K81CU3bDRZ/baOBTNd9zTYNUjMgdQiQ8wiZbYb+HnH+eY2ZdK7f6WjJIqEf6HeqhevvX+rEomGKqueaIc+4WixA+c2ksz3DALPZ1xScrXQpYwvSH3KHIOMNzh/CjpaKs2778TYHHuMzRfCP5HfPqQZUC1fSEGX5lP2yn3atH1/4sQ6KKhPQSZn0e+sTEx3VlTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOvVjCz3Yg0s73Ft+V+VcEC4dFGNeMlCQjZOCdFJOEQ=;
 b=DKSoBuuhOwd2J5v56k/9x4gI01vZtnBuDm/26mXTglDX1IA6OV2RuQ/rq8lhAe7tDVwr2sT7pcDZchDV6C6vUDyMpcNllxRY1uWFUVVW2PF2ub9cdHEPvWtmyCfbhVAkfK1EQ1wffRCEjDOUY81Mr6TuKkgYyPV06LCGcbP18r8=
Received: from YTBP288CA0016.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01:14::29)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 04:53:29 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:b01:14:cafe::33) by YTBP288CA0016.outlook.office365.com
 (2603:10b6:b01:14::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 04:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 04:53:29 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Sep
 2024 23:53:26 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Vignesh.Chander@amd.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>
Subject: [PATCH v2 2/7] drm/amdgpu: Add PSP interface for NPS switch
Date: Fri, 27 Sep 2024 10:23:00 +0530
Message-ID: <20240927045305.2718867-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240927045305.2718867-1-lijo.lazar@amd.com>
References: <20240927045305.2718867-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa5e531-b29b-44ce-d6c5-08dcdeb0549f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2FzpYaSC2S+OXemaoX1wytsAFGht91iAduVpGiX2+RxRupWcVixMDcEimg1O?=
 =?us-ascii?Q?4OUeyaplDWZV623An3tHZeiIJx11am62CHhgXjvcv57LjSp9EiOvRAjhjymp?=
 =?us-ascii?Q?/7azvE8e4RbwZt8e6uofr+0kZJ8yF+WQ9FGoz3s5FZewbQPIFVJq56kHPsnV?=
 =?us-ascii?Q?RjM8RIg6j2bSeqQNbkSpxe1Rl5V3yzQ9FVfOLCrVUv747YqY+sBuvsX7RfIM?=
 =?us-ascii?Q?R/82wqDzh7JhVahZZM7eiY07omAV5btuk7gjoMj95Nbt5DCFwF4FfQhwOdQt?=
 =?us-ascii?Q?ySKN19mLpWBy2cc20JwVPwzjtzHy61umK4M/bBnYjcR3rb9WSKtJTjDdAZUd?=
 =?us-ascii?Q?Jzu6V1Mt1t0wv9ZJrLJx+z59gV3akZ2b5VpcZF8X6i5a+hdw2CRQgm/O3fOG?=
 =?us-ascii?Q?dIW+6AvyqymlFIZQ9OYUbJROEp8isf45Md+kTrihcW7DVDPYn6SSHgu6YOML?=
 =?us-ascii?Q?TYC6EKn8FSdqmrESN4KibDdCajE0sGaXOUy8acRuYYO2/HESSocgFWKZs3FE?=
 =?us-ascii?Q?P6J7I8OJns8j/aCKD2lpxotvKFrABk1uNCWKMAeDxEFqFaQAnwp8JeV92xIQ?=
 =?us-ascii?Q?EMJeXNB1u1cOMyy9ikTWYbirY8+it+j60RfX1xg/kTx2t8VDg7DkOJrcDo3r?=
 =?us-ascii?Q?C2ULjtvY3foPSWqZDvqLrP5LOILQ+qeH7aNUc+ghEEcLukDqX5kqm0O+jJDv?=
 =?us-ascii?Q?kuqcrfWIZx2ibqdj+8/kBnMWHN7MwAoWHw1loy145AqpNrF3veYkKibGYUf8?=
 =?us-ascii?Q?iVX038khktZuuyAJFbV0LUpxVVOjNTMVyPDs9CzgoKaHcEz6toBkIJKiR1xb?=
 =?us-ascii?Q?GmhVc98l8EbRxnfl6D2Isf4HAU2p4OCtBhv7dVGiVmAug0l9MI9hqtco4ZJZ?=
 =?us-ascii?Q?yQdtRZIzQCdJ8CPl0pM/5gnVLk+coJw1y4NfgiliXY8lKLcbeK2ejP/WPYN0?=
 =?us-ascii?Q?at5f0b68D0G1FFIQBIIxdPwVdDlfPhY0so7Q/U58MJxfcIQN1scyVR53VsMB?=
 =?us-ascii?Q?qkCCa6h24AHqGh2o8OCSPtcfpAurJU6c5ath09v7zZIZvcsSMv5RbQpuW2W3?=
 =?us-ascii?Q?t7+wRtFXIkYBhgfx/K+B/YLhJZqlN+Lvv0Q4Roc7e8o311GtIf9hx8+M/QMO?=
 =?us-ascii?Q?1Bidnvco0EwDaCErRTKxLxUnoqdHq0eTgn5hFj8Gbrp/fFy2zOUrk7tvfO2J?=
 =?us-ascii?Q?5IJMS7i86FcsCdGhNAhJJoRkMrume2dDMZl6hKh1Cw6KSm95jpL0cIy5BMOz?=
 =?us-ascii?Q?TmIa5O4enysYmvfQYARj6+7Ga1ongYx8w5Rv3n8zZUbgL5p4qRNPc59dGNvV?=
 =?us-ascii?Q?WKseo/q/mm3blCexvHeyaqIDtR5g2/pYO6Yv1LPn5bhiWMRUxIDNXpJa8Xep?=
 =?us-ascii?Q?99osv/JFst8xdpykLGKPR29vxTZumhaeyg8DFe1W8mV6Uh2C1tfj+mp3sEK0?=
 =?us-ascii?Q?3bo4+wKx25lbQe1l3jQFCXfLsSByJLIc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 04:53:29.4045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa5e531-b29b-44ce-d6c5-08dcdeb0549f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810
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

