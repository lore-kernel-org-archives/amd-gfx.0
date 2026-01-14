Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F62D39015
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 20:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8851F10E681;
	Wed, 14 Jan 2026 20:24:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cOH5p3oT";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9631310E681
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 20:24:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCVVfC+OCar4B/1XBvkOhpQG+voRuCTXYSu7RVNsGtEuUTHl8EoTZj0fpM74KF0Hnj1hsjx7xWILyzKWkftr1qThLNjQrbIsvNnn26Hm5rTbp08Jp4zP9WgVn6ERmYy1CFNaVWseKZFU9amuR4C4Y1lIvNWQIz25CwNslWjWp79fHqsxLxVyQlDf/f3fhx/tTOcem5dM/deJGNLc38EGGFsStR3rxq9uMPSEbjfwnRnf/ai9Eji/3ReHXLNu7xJbXr7NNqQRbF66FJQfA9IhrNAqCJM8HYNOyyPBqiFVQohVRe9TzHCT4+SfN1DlhN3oJwLEOGIxwGbL0udXg2hgYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HmDS+nugZBXt1i0kXriWs+sib9wtTYH01xxsZmIn1I=;
 b=u5JdN2iZLQpvO7ZtqYxVALPpnkA7e591tgVa9bicxkwqfSfkV7ywVqONmifhF3sLNjyJcXM99AOW9q7wih9BhvGv9A276JROgxrbAbr+VNZfxu1DzRsbQRzYkaWsfqOsHvrE89G7gj5mN8qnEHsoIA6BWfC0fQfsbwnvHZcDLkJKLT7XE+/ivQn7SrMOKf/Tt73LvIM2/elDP0kvDG29O5UA6/KlxZLDzcgzLKqb7Qcjb8d2GkKhahjaTRTlQSUxwf+4c7WPxsIxfDsZx6yW8O+t1WBQEMqTwbz8uEx8jGU4CCL9YS643luvMabcBZir1RfCxtkFZpUR3kh5fADXDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HmDS+nugZBXt1i0kXriWs+sib9wtTYH01xxsZmIn1I=;
 b=cOH5p3oTKOmppSrBC9frpyhXOfmNWWElarNFt15PLFW8SHzEcIf2FoeV7gH3p9aea16oZSM+HdBE71rS/BSzDwtU5AnpcQSuqUACXHQ+hCxTT4aqW8cKKQlzW56jFlUeNMtTknpwj/+K3WjpgBp44/1Uq1LsFHTPir6x5+YJ+lE=
Received: from CH0PR03CA0253.namprd03.prod.outlook.com (2603:10b6:610:e5::18)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 20:24:12 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::21) by CH0PR03CA0253.outlook.office365.com
 (2603:10b6:610:e5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 20:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 20:24:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 14:24:11 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 14:24:06 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>
Subject: [PATCH 09/14] drm/amd/display: Add IPS residency info to debugfs
Date: Wed, 14 Jan 2026 15:21:50 -0500
Message-ID: <20260114202421.3654137-10-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
References: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 64695db3-1682-4ec7-9fd4-08de53aae16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oI6xnKez9XXiGq5eTNIq0HxhRBx6BUHJsbOirFCnCIrUpDTvpMkD3iZRkJYk?=
 =?us-ascii?Q?AeX5ZTj6v33CP2E6ksyl3n4l7EuARMw/BxQOm8mPMOMYOKrGr97aN2Jbn+A9?=
 =?us-ascii?Q?ewmNQd9cisRatv2AfA1VGEMIbU5z0kpmmV0kN7HzMmuajw9L0YLD3VF286Wg?=
 =?us-ascii?Q?EvYQL3HzLYPIMDkuWtJ5INr+ly7osklFjjsO+5Xutq3Jm0FLZOXcnDRPLL4I?=
 =?us-ascii?Q?yLuNvzpFknHdNWDI0ChJj1AvWPPpDv3IFnnSSC8Nl3E+mTMbK7Rw/gh/Vo4I?=
 =?us-ascii?Q?hLgkHwTmCTtkpKV7CdXUpRiXLTumEE4grFiCkTWnSz0lJBN8985pFquwlxZj?=
 =?us-ascii?Q?8l1cNbNSOl3vUsX2S+ZbgUqrHHiDVhTd9ji61nnkD/KchCU7ozSuMuwioyU5?=
 =?us-ascii?Q?FTebdfBJ2ebBwm8jwPPb2HUmqr4lQXz8PDHOPbFlpVb0ZKl+Pljvq8o4Ziou?=
 =?us-ascii?Q?g2sURDmCtVXGrERrmkA7j4VoeTeCWTvaLpH/srwAhxjCLa0hQy+HJ5eUXuHH?=
 =?us-ascii?Q?TVGXHT9cGOGPK1MviUZvfUUFbPGfPT8woF6yJNdf6dY9T8V8IRMd+q44vxew?=
 =?us-ascii?Q?vZ3fBiaL3MM2Q1fqtTCFILuOHBLhDbKl6JcUX1QOFMBMADVIgFVcs43wKNRF?=
 =?us-ascii?Q?/Z+WVQsPSuGjHGpvBf0n9vP27COYIhI8AxmZ6/nMVX1x2CfwlT7OG4+/ofA4?=
 =?us-ascii?Q?YVhvPBwT+tb8uQHhPsNnpgzd+GnrPtUFe69KHkBE1zmWwpXnpKqhLOdjBQuh?=
 =?us-ascii?Q?Omf/P4LAds2yFi/16915pEEr7FDjeyf2QF5oXCCP3zk2Hetcs7bYX7Z58PY7?=
 =?us-ascii?Q?roXLkw3BlqbrCf+IiJPWocfUbqW6J8jXCkmFIqObOBzvSR7thqy2dLPpJa1p?=
 =?us-ascii?Q?Pool4PGdcb5feQNF6piyePeyKeSoDZZD6uvQD1tvhJRQKC08fIexhBE6ThW3?=
 =?us-ascii?Q?ho+grcFsgj8Mc2VnWMcjlkMQbnI/7j2A1uzLw0EJ1a6cJrTuTXEMTPEOZA+k?=
 =?us-ascii?Q?ojyxwjrbzjLPwf3hZsixFK/+AgS8vnd2BexxHAVMMFisIhczEHKEiBHXnJpy?=
 =?us-ascii?Q?aENtsrqL9LQ4fHAkoozMaQlbUgJCc3VS9LQeBSgfFno4IvhcU2eDvsphTPry?=
 =?us-ascii?Q?6j9GCOqXMHoNxFvhIFcj6mRpxCRVZ3+//aPhwC4MQqPMvByipJr0S+rLFtpJ?=
 =?us-ascii?Q?tckzaGJ7gAoQCIvSxV4nXFYSj630QvkDWScs8OAyeAWKGvtUsn3JqRfHDr1p?=
 =?us-ascii?Q?bCnCDta8gXlq2m9mikiuEuN0dO7PwiQcMm3RMMwtF40JzdMOxv37nZfTiD2W?=
 =?us-ascii?Q?6e5qYiuwSUTSbl2mykplCFCJO+5qR/hyccjqlu4Q9B2cnTmv/FcF8t31Ju7S?=
 =?us-ascii?Q?kjgVsTo702po4EnZHAgvL82deWvcDmkGiaVDVKkhp3IplJ6fN2YVMdahXb40?=
 =?us-ascii?Q?YVJQW2pcWuuM4ThmBeyhSzttd3kx7YdoS92Yu2GvFenl+QqqQ0MRRBh5as7B?=
 =?us-ascii?Q?ei5UpYnptSsav4gi0S+6pA0owHalzt8NdtcIpW1pspJnkgXlwhzkVXR4wNxX?=
 =?us-ascii?Q?Au7G4Fgn3rY7vMJGTtTt8ZT2JusFXtXcvFP+tXmsrIRrhkTtTtDTGlNVuPMx?=
 =?us-ascii?Q?Hc652/t+MsUu4ne0coKvVkiqB3l31oKrISNfGFadoJE8lw5/+hwxGhhRx34U?=
 =?us-ascii?Q?EQMq1Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 20:24:12.4113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64695db3-1682-4ec7-9fd4-08de53aae16b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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

From: Ray Wu <ray.wu@amd.com>

[Why]
For debugging and testing purpose

[How]
Usage:
- echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_ips_residency_cntl
- echo 0 > /sys/kernel/debug/dri/0/amdgpu_dm_ips_residency_cntl
- cat /sys/kernel/debug/dri/0/amdgpu_dm_ips_residency

Reviewed-by: ChiaHsuan (Tom) Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 71 ++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 36078ed5103d..b9ed29ec60dc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2709,6 +2709,65 @@ static int ips_status_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
+/*
+ * IPS residency information from DMUB service. Read only.
+ *
+ * For time-window (segment) measurement:
+ *	1) echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_ips_residency_cntl
+ *	2) sleep <seconds>
+ *	3) echo 0 > /sys/kernel/debug/dri/0/amdgpu_dm_ips_residency_cntl
+ *	4) cat /sys/kernel/debug/dri/0/amdgpu_dm_ips_residency
+ */
+static int ips_residency_show(struct seq_file *m, void *unused)
+{
+	struct amdgpu_device *adev = m->private;
+	struct dc *dc = adev->dm.dc;
+	uint8_t panel_inst = 0;
+	enum ips_residency_mode mode;
+	struct dmub_ips_residency_info info;
+
+	mutex_lock(&adev->dm.dc_lock);
+
+	mode = IPS_RESIDENCY__IPS1_RCG;
+	if (!dc_dmub_srv_ips_query_residency_info(dc->ctx, panel_inst, &info, mode)) {
+		seq_printf(m, "ISP query failed\n");
+	} else {
+		unsigned int pct, frac;
+		pct = info.residency_millipercent / 1000;
+		frac = info.residency_millipercent % 1000;
+
+		seq_printf(m, "IPS residency: %u.%03u%% \n", pct, frac);
+		seq_printf(m, "    entry_counter: %u\n", info.entry_counter);
+		seq_printf(m, "    total_time_us: %llu\n",
+			(unsigned long long)info.total_time_us);
+		seq_printf(m, "    total_inactive_time_us: %llu\n",
+			(unsigned long long)info.total_inactive_time_us);
+	}
+	mutex_unlock(&adev->dm.dc_lock);
+	return 0;
+}
+
+static int ips_residency_cntl_get(void *data, u64 *val)
+{
+	*val = 0;
+	return 0;
+}
+
+static int ips_residency_cntl_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+	struct dc *dc = adev->dm.dc;
+	uint8_t panel_inst = 0;
+	int ret = 0;
+
+	mutex_lock(&adev->dm.dc_lock);
+	if (!dc_dmub_srv_ips_residency_cntl(dc->ctx, panel_inst, !!val))
+		ret = -EIO;
+	mutex_unlock(&adev->dm.dc_lock);
+
+	return ret;
+}
+
 /*
  * Backlight at this moment.  Read only.
  * As written to display, taking ABM and backlight lut into account.
@@ -3370,9 +3429,12 @@ DEFINE_DEBUGFS_ATTRIBUTE(disallow_edp_enter_psr_fops,
 			disallow_edp_enter_psr_get,
 			disallow_edp_enter_psr_set, "%llu\n");
 
+DEFINE_DEBUGFS_ATTRIBUTE(ips_residency_cntl_fops, ips_residency_cntl_get,
+			   ips_residency_cntl_set, "%llu\n");
 DEFINE_SHOW_ATTRIBUTE(current_backlight);
 DEFINE_SHOW_ATTRIBUTE(target_backlight);
 DEFINE_SHOW_ATTRIBUTE(ips_status);
+DEFINE_SHOW_ATTRIBUTE(ips_residency);
 
 static const struct {
 	char *name;
@@ -4271,7 +4333,14 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_file_unsafe("amdgpu_dm_disable_hpd", 0644, root, adev,
 				   &disable_hpd_ops);
 
-	if (adev->dm.dc->caps.ips_support)
+	if (adev->dm.dc->caps.ips_support) {
 		debugfs_create_file_unsafe("amdgpu_dm_ips_status", 0644, root, adev,
 					   &ips_status_fops);
+
+		debugfs_create_file_unsafe("amdgpu_dm_ips_residency_cntl", 0644, root, adev,
+					   &ips_residency_cntl_fops);
+
+		debugfs_create_file_unsafe("amdgpu_dm_ips_residency", 0644, root, adev,
+					   &ips_residency_fops);
+	}
 }
-- 
2.52.0

