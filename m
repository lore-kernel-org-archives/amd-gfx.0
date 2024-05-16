Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FD5C25B79
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50F5310EDBB;
	Thu, 16 May 2024 19:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FFQ0EmAt";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A0DE10EDBF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/QKXnlITcs6drSpBhk4S/hrF28BDL/7pv89jkEnG7+kodVKnUO61xbx039Fkgw7hJeAX3/oCc5W+yQbx23BEZgP+v8WILuW5GWmMVP+dPZLoYw4SZ7sBDjcS+w9C3m73kRpZuSSj1IITDGPGzQ85K4AmXmvVr0Ysc2rLmdnFLm+ax+VjRnq/tEUi/OqgScgwUoqC/kxrrG00/tI2lwXewPmo2hxWP9PRfJIdHi52fi5NgF+cU2QOpFe3BmbMrojxm+OMwxd1PXPx/78pg2dYhC+43o2sAJAHd9WjfQWiR6XkOkKi5mOAbYAkpf8STHWKkb9f4JgFGA5DT6YfFSoWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psZmBwAoPN5rWZFt7Kn3E/I9rcLCdd+qCDL2W/UMRjk=;
 b=NnnxV9iAT5viCe5g1oRDpwRJQCIPXH1yjssUmCdeotXg8V8GH/v17zC8JdW/U7xGSD01mgjbVWzECUjywt551QovHk7ToAkFM10FUc4GdzQ1F31/Eefm8I9IcOfOsk/XpEWWll73IYWY16nl0pF2OcPVWjopUEb9ptnLWw7H3uVq0T4SWpFGTZY2Fnae15sexXrIj3lH63pOgNRrcOkh/TiTwcIdXx7nyaMvFwx6dBGFYo0+B9TEAhevQJSvERRsMfbSnb/E0Ot95ocZHO5jk92Xi9O7GDElvuABiA6X+OPg/36B6KAE9tHs+OtZ6fw3E/YUlBgWLqFUOyC39ZIkIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psZmBwAoPN5rWZFt7Kn3E/I9rcLCdd+qCDL2W/UMRjk=;
 b=FFQ0EmAtyOZGa7uapCzaa/cJEqcC6bVqugEN8ZEXsr87R+BRJ0mb+yJaXJxHpf7nuHlY9PPOWB5pvYIByUrFMsXYg2Hi9sCTJW5nP+Vjkd4V/Spuiw2S+s3woLsF++CyTjqTLTEp/Y4Xs8CiZqswBzsuenetkcnR3b9M/S/cnDY=
Received: from BN9PR03CA0088.namprd03.prod.outlook.com (2603:10b6:408:fc::33)
 by SJ0PR12MB7084.namprd12.prod.outlook.com (2603:10b6:a03:4ae::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 19:27:07 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::7f) by BN9PR03CA0088.outlook.office365.com
 (2603:10b6:408:fc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Thu, 16 May 2024 19:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:27:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:04 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:27:04 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>
Subject: [PATCH 15/24] drm/amd/display: Add ips status info to debugfs
Date: Thu, 16 May 2024 15:26:38 -0400
Message-ID: <20240516192647.1522729-16-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SJ0PR12MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: 57bd7d5b-9a0d-4d5a-3329-08dc75de2cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gSFW2iyrag3krpo2RAgwifAcKuMPcAg6ldM5hxaAXqG/Fa/krr8g+j7//AOv?=
 =?us-ascii?Q?Dj/mmD7BkrvZEtjZN/DxqWPB51B9lk2VYBN7LiL7cYFwtd3RYcvwZVUi0N5O?=
 =?us-ascii?Q?zaqyDDPGY23x72IuWR4Lfr4+O0R0fNLkeU73/Ouhv4UHH6xG1D48YsqV90Z0?=
 =?us-ascii?Q?rk2gCurhjkdSVevUG8pFcQhlk/7Fw3ZrfuRiXGAgIrWGOYwq53SK9kVjK4w2?=
 =?us-ascii?Q?37jwsobvmKGUkoWaKe3lCvJ4zpsr4EtmpJWMGzTmVO+Ba8Yt1XgEedMqxE6Q?=
 =?us-ascii?Q?lUBeFoUifj2f2O6ckYirwUsRONFU8jaKmw1Xt9pfPK11oANCfaRIeMuKQHr1?=
 =?us-ascii?Q?4bFjd4F6C9FJ4I75xSiqUH22lIiioxltO4nFW80vCcp+INjm+ek3IQcs/Yez?=
 =?us-ascii?Q?aTJWpDSH3b84h0YC7DmmDeTmphvDzYtMl7bqDvpHGb3qdntNnB/EG+KmZbSv?=
 =?us-ascii?Q?s2mzq2kgCg7ocYr8yYM9Uknfux+QZ0GrJiCTwhgYYhm2LvVUmSDHI1qMzgB9?=
 =?us-ascii?Q?obQfeuJP77vmZJ6iSx30L8As50Hn2wtuMm6AeGe/DEfP/kxgfU56V1JrOnVJ?=
 =?us-ascii?Q?kd7YgxdPSIjbOMltUCmAGzbu356yTCgTfrbqaLaSEjEYEGUx/6zGwzwW/ytG?=
 =?us-ascii?Q?NmxlESZWzjWnKaxYItjk2jaa2yoBccLW6AF0uLzW/LYshc0qX1NjqLiqMuzq?=
 =?us-ascii?Q?g12E0vajupSvyph1KrPRLDttWKWrpvABvpUwWGsUo2kB9EDwfrzPQdA+XYdX?=
 =?us-ascii?Q?8nA8dEyqPKxyaHHCW0edvIbZVAcT/UjsseitE6SV6oabIF+LnRDcXsO0iR/m?=
 =?us-ascii?Q?MKfao3W4joMiG8WVE++rExzKVK8zHLQ8Jb3RN1WLM0r8wsWRqa/iLoQjqwpu?=
 =?us-ascii?Q?1Bdf6C4oLbB37PquAU7V0Ove4ToNf5TIVKSSYcrvBQIkV9bG77L/1JvDKEW/?=
 =?us-ascii?Q?WkjgeJpBuma0ixEUQMXKA2IVFHcNdlXCYVh0POZKOn7lZTwJ476DIRjurnau?=
 =?us-ascii?Q?5lwBYrBl0ELsytwaSXkMvJxWBJOIppQkfixGLhE1n/BmZ83uaQfUttifx4YT?=
 =?us-ascii?Q?oEemz2DGfeD4tUUya633q84zB0k6g3NbKpAgIaqggH+FdLPCM/a4m44+EBRQ?=
 =?us-ascii?Q?wnTBFWJMeo2SqYec3EiovzxQU7e+ztjlraILsG2Nm6qFcw1xbRRsjwinwQlu?=
 =?us-ascii?Q?7IHJyBa2dgiph2E1UwynDVA3RE0nexpiacYNAcGg1RpVrO0cd2llpv2gI2HE?=
 =?us-ascii?Q?OtaiOw8mqvz5KhJ0eUa1Q54LR4HVLDNXTIAQQCWisRCbipB1y1h48pGD8md4?=
 =?us-ascii?Q?fCVp5R8L3WQjmok+8B3LTlwTArag3AxRlkx5ccO5mRlyHXERnY217QC4j94a?=
 =?us-ascii?Q?52uwcn+Nowa8yaQHCJh5yWTndB3N?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:27:07.4920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bd7d5b-9a0d-4d5a-3329-08dc75de2cd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7084
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

From: Roman Li <roman.li@amd.com>

[Why]
For debugging and testing purposes.

[How]
If IPS is supported create ips_status debugfs entry.
Usage: cat /sys/kernel/debug/dri/0/amdgpu_dm_ips_status

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 7d97fdd9da92..27d5c6077630 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2670,6 +2670,49 @@ static ssize_t dp_max_bpc_write(struct file *f, const char __user *buf,
 	return size;
 }
 
+/*
+ * IPS status.  Read only.
+ *
+ * Example usage: cat /sys/kernel/debug/dri/0/amdgpu_dm_ips_status
+ */
+static int ips_status_show(struct seq_file *m, void *unused)
+{
+	struct amdgpu_device *adev = m->private;
+	struct dc *dc = adev->dm.dc;
+	struct dc_dmub_srv *dc_dmub_srv;
+
+	seq_printf(m, "IPS config: %d\n", dc->config.disable_ips);
+	seq_printf(m, "Idle optimization: %d\n", dc->idle_optimizations_allowed);
+
+	if (adev->dm.idle_workqueue) {
+		seq_printf(m, "Idle workqueue - enabled: %d\n", adev->dm.idle_workqueue->enable);
+		seq_printf(m, "Idle workqueue - running: %d\n", adev->dm.idle_workqueue->running);
+	}
+
+	dc_dmub_srv = dc->ctx->dmub_srv;
+	if (dc_dmub_srv && dc_dmub_srv->dmub) {
+		uint32_t rcg_count, ips1_count, ips2_count;
+		volatile const struct dmub_shared_state_ips_fw *ips_fw =
+			&dc_dmub_srv->dmub->shared_state[DMUB_SHARED_SHARE_FEATURE__IPS_FW].data.ips_fw;
+		rcg_count = ips_fw->rcg_entry_count;
+		ips1_count = ips_fw->ips1_entry_count;
+		ips2_count = ips_fw->ips2_entry_count;
+		seq_printf(m, "entry counts: rcg=%u ips1=%u ips2=%u\n",
+			   rcg_count,
+			   ips1_count,
+			   ips2_count);
+		rcg_count = ips_fw->rcg_exit_count;
+		ips1_count = ips_fw->ips1_exit_count;
+		ips2_count = ips_fw->ips2_exit_count;
+		seq_printf(m, "exit counts: rcg=%u ips1=%u ips2=%u",
+			   rcg_count,
+			   ips1_count,
+			   ips2_count);
+		seq_puts(m, "\n");
+	}
+	return 0;
+}
+
 /*
  * Backlight at this moment.  Read only.
  * As written to display, taking ABM and backlight lut into account.
@@ -3240,6 +3283,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(disallow_edp_enter_psr_fops,
 
 DEFINE_SHOW_ATTRIBUTE(current_backlight);
 DEFINE_SHOW_ATTRIBUTE(target_backlight);
+DEFINE_SHOW_ATTRIBUTE(ips_status);
 
 static const struct {
 	char *name;
@@ -4129,4 +4173,7 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_file_unsafe("amdgpu_dm_disable_hpd", 0644, root, adev,
 				   &disable_hpd_ops);
 
+	if (adev->dm.dc->caps.ips_support)
+		debugfs_create_file_unsafe("amdgpu_dm_ips_status", 0644, root, adev,
+					   &ips_status_fops);
 }
-- 
2.34.1

