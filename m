Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FA7F99368
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 10:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4793810F055;
	Thu, 23 Apr 2026 10:12:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NhJ7j7Pp";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C51ED10F055
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 10:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jL5gqlhpUW2IPwfVrzng7KVWVtqATYinBwEHyufOmfPk6D/9QwQQlD94ADKfzbdA8CL8xQju9SunhhfykJInHwTDH6WWjcsCWcU2uOSq34xRfODig9rTl1DMhDhBXjxMBMp8aDBFpQpPkfBofjjVPv+jCkByT6/Q/dbrvZvfRb05LlfM/QVGu5gDRyrm8RCWYSgGCQWVYfYRSK75ayBe7yRHTkiKOWQjwahmbKFacrfXNINLPfLUT4/LG24Utn5r8w8Lf+eboqlUs58wgwIbaoCDKvosv/AoN9himEaOnMjJ70/fa3ZUxNPDDJNFnpCVPBhWZSqH61KD1Eatof0sPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yR9ohwMVGEbK/l2hSt9rNJCrH7gjF7h/F+NImHsJuMQ=;
 b=t1gCg8Ly2a31vyqkdrIHRTKUcGQunWlZ85TsSnGw8UZLDSvCL2lbtaq5mEox8LTMzNB+Ppx2nhIEPew3l9EKv+6/i5u9V7WbP2mQTgC+kQkViH5b84ssybTl4uZ2sHo2sJ14X7C7lgoZodPtkMsfcyyJGQMPzpB8ezNub9y33QaO/P8HI9s4fONs5y8P1XX0U++RapRv+Y0TjT+nrE5L/i/4tlxAE2QL1/TquoB4qKytgsSJx47R7GLQyCo4D3ih3egoEldr0Lx7QklXf+9PfwKP/Za34MVC1UnHe4vqxYnkm9z44fSe5HaR5NjnIJ1TPdruTXPMOuwxJGN/CJKVHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yR9ohwMVGEbK/l2hSt9rNJCrH7gjF7h/F+NImHsJuMQ=;
 b=NhJ7j7PpcDKBl2xb5qXLQP3PdTsM9nAEbvmFczRCTgQjvZw3RF/pYRoewswlGm/GNZy5Z263X2T8wTjihBXwlIp2EcjLBNKFO+O/fuogsQ7gTpwZ3uYAQsY5aNHP6M0U9ATE3BuPVBzuOolIoAnTRGjk6fwU+V4Nbp4jBkFy96w=
Received: from BN9P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::30)
 by PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Thu, 23 Apr
 2026 10:12:05 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::1f) by BN9P223CA0025.outlook.office365.com
 (2603:10b6:408:10b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Thu,
 23 Apr 2026 10:12:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 10:12:05 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Apr
 2026 05:12:03 -0500
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <haijun.chang@amd.com>, chong li <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: Add guest driver CUID support
Date: Thu, 23 Apr 2026 18:11:47 +0800
Message-ID: <20260423101147.367219-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|PH8PR12MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: aec2e4ba-4364-467c-49a5-08dea120c515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: eVGiVPWawPmBqkssUGIjSWTAQWw18t1kEQNEkcTxcksMf1V1lSavExa9QgRDHxDr1hdDjz1WeyMkuvO39R1+NSKlCOZAplHI5aHZ/4XmmNFYY70PPgi57nbBxDRylwH4Tn/cozb7gk3kQLn/26zDGNSLrJfDf3JaX1uFPfCIhzs0mZvlqATVOZE9zI2Eb16x3IRuaaqPCxTpPaThpI1wnjzo6GQt3hfTFduQAvmYBUm1sTti6N2w0mmrlMlhg8PfPtZ2sALax6Bjg6rJxAwnm4XDEUqRgfkjGE7UIyjM5WYdrwo24IWAlLF4ZzqjR0COR25XJmx5dY6CtBcCOmMuRGPGpL6J7PBjL6SR3dZSiP371sB6W6oZeNZwRTGH1cryJ9Q9C7WDOPAMoLCn8RLwivS1noxOq03sQTIsojEIgs+YgZnglj3RVhCd5RCKtAn0cm0Qo/SUVNRmoMkF4SjfKzACC50+x2jDNJU5PkAPeT3D25ylG631piT73eDdWI/hp47eBe46XLehxywduK/0Pw5hszmilm5BvyJ7nl2TSQRvQ/YGiacOy1S/wytQS0xQ0GR6t+KHd0Bq65DtTgYqg6Flx4C16jlDhPBKextEtWUPf3aZHsNjolVGqQuxdjMQNBvcQ1Pbr6JXLCgRkJifTZZP2i5OgmVuG/cOshUqLwEwfV93VBZJP+UNywgqBGP5XDroEJQaPMh7TjgHxTCWom33eHjjfjbzardvnG8lOERfUwCslwSlT2piQefiJHr3hugPcp5/S9hIvMH1Y5bevg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xf7+24z07RwH+rHlNyr1z4eZWd//NjGzuh+i/hTvJCYlghP+I3huGBc9s1afUlLeDm00w/54gA1hWlxYN4LB1Yfqx/utP/OBhg3sokHwXVtSRRPPpfE+CEVT1iueRlAmJSehT9KCPCexQyF/fBVzpWzJAy54tIgRIMaxTp1HL9beV6dkeSVoVchgZca4krESQLd5/yqHH0BY3SOwUEg/PaVWcGSSxfnPaPho+akCoVRQq2d0bnnJEzi0j0wIV36X+va0YTstP8359nthRXs2HIUGgB8Jc4OIFqzs6tdNH4Ev/pst73VqDm1SM7USUeHYCo3P0v3ktzoGyJApVEn6plg91qdvqmnSQppyCUecNkLEs4l1yW/Ggs4rwYTSrMjHWi3LuABLFyBvPaXUHpyd1fB7OCigycNOiCKaxxngDMNkolZgUmiT5lqGznIJ6GKj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 10:12:05.0293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aec2e4ba-4364-467c-49a5-08dea120c515
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868
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
2. Sync the feature flag between guest driver and host driver.

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 55 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  8 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 12 ++++-
 5 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 39894e38fee4..27522f7b12da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1112,6 +1112,7 @@ struct amdgpu_device {
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 9da0c6e9b869..5f889382fe4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -163,6 +163,8 @@ enum AMDGIM_FEATURE_FLAG {
 	AMDGIM_FEATURE_RAS_CPER = (1 << 11),
 	AMDGIM_FEATURE_XGMI_TA_EXT_PEER_LINK = (1 << 12),
 	AMDGIM_FEATURE_XGMI_CONNECTED_TO_CPU = (1 << 13),
+	AMDGIM_FEATURE_PTL_SUPPORT = (1 << 14),
+	AMDGIM_FEATURE_UNITID = (1 << 15),
 };
 
 enum AMDGIM_REG_ACCESS_FLAG {
@@ -441,6 +443,8 @@ static inline bool is_virtual_machine(void)
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_VCN_RB_DECOUPLE)
 #define amdgpu_sriov_is_mes_info_enable(adev) \
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_MES_INFO_ENABLE)
+#define amdgpu_sriov_is_unitid_support(adev) \
+	((adev)->virt.gim_feature & AMDGIM_FEATURE_UNITID)
 
 #define amdgpu_virt_xgmi_migrate_enabled(adev) \
 	((adev)->virt.is_xgmi_node_migrate_enabled && (adev)->gmc.xgmi.node_segment_size != 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 847cfd1fd004..7d79fb785e12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -162,7 +162,9 @@ union amd_sriov_msg_feature_flags {
 		uint32_t ras_cper		: 1;
 		uint32_t xgmi_ta_ext_peer_link	: 1;
 		uint32_t xgmi_connected_to_cpu  : 1;
-		uint32_t reserved		: 18;
+		uint32_t ptl_support		: 1;
+		uint32_t unitid_support		: 1;
+		uint32_t reserved		: 16;
 	} flags;
 	uint32_t all;
 };
@@ -256,7 +258,7 @@ struct amd_sriov_msg_pf2vf_info_header {
 	uint32_t reserved[2];
 };
 
-#define AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE (55)
+#define AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE (59)
 struct amd_sriov_msg_pf2vf_info {
 	/* header contains size and version */
 	struct amd_sriov_msg_pf2vf_info_header header;
@@ -314,6 +316,12 @@ struct amd_sriov_msg_pf2vf_info {
 	uint32_t more_bp;	//Reserved for future use.
 	union amd_sriov_ras_caps ras_en_caps;
 	union amd_sriov_ras_caps ras_telemetry_en_caps;
+	uint8_t unitid;
+	uint8_t padding[3];  //use the 3 bytes to align
+	/* PTL status response for guest */
+	uint32_t ptl_enabled;        // PTL enable status: 0=disabled, 1=enabled
+	uint32_t ptl_pref_format1;   // Current preferred format 1
+	uint32_t ptl_pref_format2;   // Current preferred format 2
 
 	/* reserved */
 	uint32_t reserved[256 - AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE];
-- 
2.48.1

