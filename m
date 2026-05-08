Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B23ACD3436
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 07:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E27110F399;
	Fri,  8 May 2026 07:53:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Whliz8Km";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B697610F399
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 07:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXHzUjjuEZWB0LMNaEhxgZRKvzKwAze4PWkDhM2ObFYk96m0994/hdYmkSBOdqjr7KgjVO90HkYnrWAWsjHwLKM4ABtueCJZU05R3sMdbWjeE66YY1G2a9Yjens1BrKS0ltEYC1lCE7hlgKl1k7h4M9CySCh2hvHmemdXsc2g6f/Slftg30mna9TWHraluh/FsglZ07NrWjvfICgTPiOHqKuYbGyfvmXRNYR1i/7dSfaFec+xVI9wG5dzZ9zHDwx8MpIFcjzE/Cg/N9x2AuRuFgKS9aJFOPjBbGXlaiJkuzY6+tf80L+zlldIeGhjd/zFWMH3hSgcudEisRE4wvIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnKiC8gLgrWq15DoX9VolVHM/R/bgPxeWf8gnz7iYLk=;
 b=O4+jjR8bd0CSVoSro/1C1Hf9bfOlA2ERczmHJ31D0LqZ2eEV94Skyhp54lHSTpKC8VemM++BUl74AXDiyIUPRadWr8hhtEuPSGQTSGaR82mSpgM1laVwXJ2uIuOynOBEIb4YHsE4tEQ4Os70Enzxm6qWAcukOSCCV7Wj9ZVsQLEyqYeoQOebrwcMYUyNNREZFi/NV8QCFDGsrGiKY23V+7+O0DDvrYGbP6Ym2wbMU78dEBql6cIYWRzez9KmL/2P/5CXL5PexUkaACT4xu3xHWDwvoLZH2455bQl1RjLPP0vDpFCNOzfrDXuIDAH8ruBB5YF0apGBIU1vefCZF87TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnKiC8gLgrWq15DoX9VolVHM/R/bgPxeWf8gnz7iYLk=;
 b=Whliz8KmkTQOYR37pw/ZjoGtoerRTAIDQRYZL1khsUHtcXwjACcZPpmB1K4qejQlnMYrFL/aLuhK/R/li2615SYkDrTE9pXg8fj2Ew7zeSNhUZVZ6Pp56ftg1d7jNyw0EjfMIBGTxc0ms75gnoyovqjvanEsW2XIMKQxZPB5i0w=
Received: from SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::9)
 by BL3PR12MB6545.namprd12.prod.outlook.com (2603:10b6:208:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 07:53:51 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::7d) by SJ0P220CA0004.outlook.office365.com
 (2603:10b6:a03:41b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Fri,
 8 May 2026 07:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 07:53:50 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 02:53:49 -0500
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <HaiJun.Chang@amd.com>, chong li
 <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: Add guest driver CUID support
Date: Fri, 8 May 2026 15:53:35 +0800
Message-ID: <20260508075335.574374-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|BL3PR12MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e07b27-51c1-4087-e8ce-08deacd6f182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ELPm77uPMeN59Ap9/ixof378Q+4WMuesqwRixERFytS3HjokezxhFoAxjIU6t0r6tFLQQezzxJad1jAH78TOazq+Z5XjOra+Vczn8qI+vqKCMFvSuucHRxl+NwZhoz7PDyo90/urkoQHSCUve4cO1JupEHwoIwmHEh1drDBfP4FgV+m1JqVw7XZjTOdhefOMYNbo2jizuVnFf6HPkHKvMctywrfdYkw/l1fSP/S7T6z429ahqW/M/5Ex1Cm27jvRlyQTjZq1m7KLe3pwxkLUCjyETMbqcrMMMX89iQHitJ+G9/eHRZ/xt/gAUAmgpyoorug8LFQRlai6k3Cl1mNbDnd0cyR08AzA6GBtKPv+QyieLINMFq1VfvRIbbf1w1bi2sF6qi4kcKU/Du2L6o+xkLYrBY4gQdAmJG5Qm/V7fWjbLesUjUmupBONjz0waVMiOxRvkjB3QItkun0iB7v+qnNnIM1Wyyw1AHiYLzGQbDGIT30v3PDHqCpUQbamfJWnXciQVAmVUlPeF28frhrouyKfrISd3pGGqtSqGdE43XZQlfZ45ci8wNSwyyWFFxrHq6VTmNFq3JYiEYJqdDgcDnm/vu0dXMLM9dWVs+2Bq1M/qczNs1V+WYguBgyRls5nnsNFUBSDDKbTkMUkB0AoKopKFraW71oVnHsV0gaL6cZtawHzwHoEZGjsvq0VHGuNHXyukV0P/3WKtaV+dauG6aJL01ZTbkhvrpdGhvO/Pl0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C0tM2Cl70V+Yn+VDoRjVpEixaUeGeT8wdoOg7K1KTHXL1RDtwlp5BCW1BiDaGey3jbBBi2cYkGJHCTuvXecg3lIuXXirHc/H4ywYwuC8eJgTqs2xKmE5isLz1rl+sxQhWJalyVnBySFQRSAPZui3V+7WIJOf9k0WJHyQ+9eYN9jjq6VZoYA+dfEkoDDBmo+59dV4MSdCp/ypsldtB3+cRZjG88Fb1I2xBCHQ7fVlLIbI1NK0uiPrmmwn8a1UJKsxYbjXZuwDS8kqc2UB/caeFb19i5ppBFxixtJ0sKS3pB/xzZXSlL+XreBltn6IL0UkQMd7QzWeCfhbsse/D7x0lxCau9fV75uTvCTKVXUUX1ROVOLhXK/6D0wxcYW4/hIZZwqzHgjCnihExYgG/Kjw2GBfP56Z91EZHz+Jnj26CiyUNPmvD/AIW3wbc6+F8K9T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:53:50.7300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e07b27-51c1-4087-e8ce-08deacd6f182
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545
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

1. Add guest driver CUID support
2. Do not expose vf index(variable "fcn_idx") to customers,
   replace the fcn_idx with pad.
   Only expose the unitid to customers.

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 55 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  8 ++-
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  2 +-
 4 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 80b18bbd7f3a..98549a148695 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1074,6 +1074,7 @@ struct amdgpu_device {
 	long				psp_timeout;
 
 	uint64_t			unique_id;
+	uint8_t				unitid;
 	uint64_t	df_perfmon_config_assign_mask[AMDGPU_MAX_DF_PERFMONS];
 
 	/* enable runtime pm on the device */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 979032ecaf79..366e37db69d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2114,6 +2114,45 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
 DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
+
+static ssize_t amdgpu_debugfs_unique_id_read(struct file *f, char __user *buf,
+					 size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = file_inode(f)->i_private;
+	char tmp[34];
+	int len;
+
+	len = scnprintf(tmp, sizeof(tmp), "0x%016llx\n",
+			adev->unique_id);
+
+	return simple_read_from_buffer(buf, size, pos, tmp, len);
+}
+
+static ssize_t amdgpu_debugfs_unitid_read(struct file *f, char __user *buf,
+					 size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = file_inode(f)->i_private;
+	char tmp[34];
+	int len;
+
+	len = scnprintf(tmp, sizeof(tmp), "0x%02x\n",
+			adev->unitid);
+
+	return simple_read_from_buffer(buf, size, pos, tmp, len);
+}
+
+static const struct file_operations amdgpu_debugfs_unique_id_fops = {
+	.owner = THIS_MODULE,
+	.read = amdgpu_debugfs_unique_id_read,
+	.llseek = default_llseek,
+};
+
+static const struct file_operations amdgpu_debugfs_unitid_fops = {
+	.owner = THIS_MODULE,
+	.read = amdgpu_debugfs_unitid_read,
+	.llseek = default_llseek,
+};
+
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
 	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
@@ -2126,6 +2165,22 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_x32("amdgpu_smu_debug", 0600, root,
 			   &adev->pm.smu_debug_mask);
 
+	ent = debugfs_create_file("unique_id", 0444, root, adev,
+			    &amdgpu_debugfs_unique_id_fops);
+	if (IS_ERR(ent)) {
+		drm_err(adev_to_drm(adev),
+			"unable to create unique_id debugfs file\n");
+		return PTR_ERR(ent);
+	}
+
+	ent = debugfs_create_file("unitid", 0444, root, adev,
+			    &amdgpu_debugfs_unitid_fops);
+	if (IS_ERR(ent)) {
+		drm_err(adev_to_drm(adev),
+			"unable to create unitid debugfs file\n");
+		return PTR_ERR(ent);
+	}
+
 	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
 	if (IS_ERR(ent)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 6974b1c5b56c..45e89e104b5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -534,8 +534,12 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 		if ((adev->virt.decode_max_dimension_pixels > 0) || (adev->virt.encode_max_dimension_pixels > 0))
 			adev->virt.is_mm_bw_enabled = true;
 
-		adev->unique_id =
-			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
+		adev->unique_id = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
+
+		adev->unitid = 0;
+		if (amdgpu_sriov_is_unitid_support(adev))
+			adev->unitid = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->unitid;
+
 		adev->virt.ras_en_caps.all = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->ras_en_caps.all;
 		adev->virt.ras_telemetry_en_caps.all =
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->ras_telemetry_en_caps.all;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 9dcf0b07d513..d80f01c0e754 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -295,7 +295,7 @@ struct amd_sriov_msg_pf2vf_info {
 	uint32_t vf2pf_update_interval_ms;
 	/* identification in ROCm SMI */
 	uint64_t uuid;
-	uint32_t fcn_idx;
+	uint32_t pad;
 	/* flags to indicate which register access method VF should use */
 	union amd_sriov_reg_access_flags reg_access_flags;
 	/* MM BW management */
-- 
2.48.1

