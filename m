Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3527C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 05:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D9E46EA4A;
	Tue, 30 Nov 2021 05:17:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7267A6EA48
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 05:17:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGIbDacv9FHjJFs6zoLVZiXa/q9wuB6bQWDe0pF6gw43yHmRB1CUyfBktCUibe4RN9AkI0gtnOdMK4e/4DTgJxPdO3y20pV4zTfomT1GbxRlxQAC5d6cV3UhzbHeRBDjijiuC8ASds5Lb3mZLt0OL2aFPuw5tQDU787ujZGNY6Vo97FxJOHUb5JymNFH82VzeaLbNeT9uqmLst1yzCOH6FiAjFXNKGxGtxVApgu95ldBA+ss1LlmxvY5zAiRXTSlsVVnEHmtnfn4db01QbzW4/LWndEwTjI4is7QwdKor486QZYIaTgVRfitFSOP+QSESigsEb2IJg8CNutpBmDBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFZxm+2ihB+v4MuO7llW8hiHzSjGOVtfu7SrqIsMk84=;
 b=Zxp2I8nrpgqxAjdwdcxfGpwMLrRD/M/7Jo0DYu9th3kQZzeK9XznoZv9iikTeOpHN9MXP3S+A+s1NX1ZatT52tIYCFEpjq734v4gSwhO2XOpy8/nfiBlYdFbYNqYklY7GQLL+ZT36hupet0kBzAF6YQsWiButbFr5fDS8HRssXBxNOWonYm6yyx/dRYyYO0mg5P/6IEnORHeby+myPolmDuOu7YqPmA8JC6pLaD1Z3AFvWhikBVtKnYWOTBS5+TR9eM/kEcSoVjsO1LPK5vUJGPxqHm23EiNXkvgDTzmMLEjPlahSuG2p8qc4R8NuoNJiGujl7zFBnklOwBtzXQadw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFZxm+2ihB+v4MuO7llW8hiHzSjGOVtfu7SrqIsMk84=;
 b=cvk8v2S22P67WEPnmlnu/EN4KW+0m988fg6UAmJ7wi0/a5cSxNJq0QNWwe40A7j/Otg44EHpn02WHQh5a84YirplBuiygv1UshiN6UekVCcIXBn+Q3FGG5Qo1infN3RevLh/S2lsNF2zHu4sgcmipnQrWb8A18m1IpS3jDz6sQQ=
Received: from BN9PR03CA0378.namprd03.prod.outlook.com (2603:10b6:408:f7::23)
 by BN6PR12MB1217.namprd12.prod.outlook.com (2603:10b6:404:20::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 05:17:37 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::9f) by BN9PR03CA0378.outlook.office365.com
 (2603:10b6:408:f7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 05:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 05:17:37 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 29 Nov
 2021 23:17:35 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add SMU debug option support
Date: Tue, 30 Nov 2021 13:17:21 +0800
Message-ID: <20211130051721.3192979-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbb426ec-176c-441b-4913-08d9b3c0b95c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1217:
X-Microsoft-Antispam-PRVS: <BN6PR12MB121785D81047AF70552D3713FB679@BN6PR12MB1217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2h8EYw/cphL9tuMRI4L0jLKFu5gb2IyFcX2kAYWZEl1xZiglNgDxT8qztfz6QNxI2KJCExsRYJS5WgMGalX/hYwI+XQvfRWR1HvWmo89OBq6akics2VC9vZGtzqG4hqrLYhXh4HGRLGvPUeBSNUlkqO12jI6rgSa/t8UcJUfIRw2leLf1jGE/bGMybqK/qp3fFG/7lzPTJvcw7oxpiGCSd9KSW4ZmwEpac9yLGRxMmbD6zeQC2DmOvcJGA2VYU9fFFLHHsPU3e61YAddqNwz/EbE6YvIyxnUFwvoNE7x6hmpSadww1U7BsbJ7whgA0/fj4iKuUklGg9WNsD+g2f9lWZr5fb6QIQSya700HXn2kQXGRHNBFwDzwES8vvjg1F79lhieG/da3Pz2D4Y5quDKrbdmHrbCgYmNI1ye285a/GKvvbF0otaIgLr2phRz3EkxmGmL9Uk/O4ZUhOpLXRnwZWuSiepNML25DXnYWf/AhG334a1VSHkJ5KQ/9iqlOeyRmTq39LJWYCUHVEpqdh8gqN6Rm4WVp9a2jq7y9nxWVnWdMcE1prjcRQIUJpmdfJfWWnKsrnXeEJYeZaS2mZaECKCFie4BPp9w4bLPk/o7dYi67eTzXmREVlMWQYNEnC/9E1oxe6FxX5LbpavQYv6VBuYs3L5lB59TBzSk4GTIBxE2lWtim0J91oMi+Nv06CJSEWnta21Km4OvP59NzWAhxT7IAYOQ44D3BuAIMLGGg55wXuNEPnR3g+wJ0OkvIBp6cl5XIj/av9Fc227YllGkWpXMj8/WIPd+cXfSUt1YOk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(47076005)(86362001)(2616005)(83380400001)(36756003)(426003)(8936002)(7696005)(8676002)(44832011)(40460700001)(6916009)(5660300002)(4326008)(26005)(81166007)(2906002)(356005)(508600001)(82310400004)(1076003)(70206006)(186003)(316002)(6666004)(54906003)(16526019)(36860700001)(336012)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 05:17:37.4121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb426ec-176c-441b-4913-08d9b3c0b95c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1217
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
 Huang Rui <ray.huang@amd.com>, Lang Yu <lang.yu@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To maintain system error state when SMU errors occurred,
which will aid in debugging SMU firmware issues,
add SMU debug option support.

It can be enabled or disabled via amdgpu_smu_debug
debugfs file. When enabled, it makes SMU errors fatal.
It is disabled by default.

== Command Guide ==

1, enable SMU debug option

 # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug

2, disable SMU debug option

 # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug

v2:
 - Resend command when timeout.(Lijo)
 - Use debugfs file instead of module parameter.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 32 +++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 39 +++++++++++++++++++--
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 164d6a9e9fbb..f9412de86599 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -39,6 +39,8 @@
 
 #if defined(CONFIG_DEBUG_FS)
 
+extern int amdgpu_smu_debug;
+
 /**
  * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
  *
@@ -1152,6 +1154,8 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
 	return result;
 }
 
+
+
 static const struct file_operations amdgpu_debugfs_regs2_fops = {
 	.owner = THIS_MODULE,
 	.unlocked_ioctl = amdgpu_debugfs_regs2_ioctl,
@@ -1609,6 +1613,26 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
 DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
+static int amdgpu_debugfs_smu_debug_get(void *data, u64 *val)
+{
+	*val = amdgpu_smu_debug;
+	return 0;
+}
+
+static int amdgpu_debugfs_smu_debug_set(void *data, u64 val)
+{
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	amdgpu_smu_debug = val;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_smu_debug,
+			 amdgpu_debugfs_smu_debug_get,
+			 amdgpu_debugfs_smu_debug_set,
+			 "%llu\n");
+
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
 	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
@@ -1632,6 +1656,14 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		return PTR_ERR(ent);
 	}
 
+	ent = debugfs_create_file("amdgpu_smu_debug", 0600, root, adev,
+				  &fops_smu_debug);
+	if (IS_ERR(ent)) {
+		DRM_ERROR("unable to create amdgpu_smu_debug debugsfs file\n");
+		return PTR_ERR(ent);
+	}
+
+
 	/* Register debugfs entries for amdgpu_ttm */
 	amdgpu_ttm_debugfs_init(adev);
 	amdgpu_debugfs_pm_init(adev);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 048ca1673863..b3969d7933d3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -55,6 +55,14 @@
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	#type
+
+/*
+ * Used to enable SMU debug option. When enabled, it makes SMU errors fatal.
+ * This will aid in debugging SMU firmware issues.
+ * (0 = disabled (default), 1 = enabled)
+ */
+int amdgpu_smu_debug;
+
 static const char * const __smu_message_names[] = {
 	SMU_MESSAGE_TYPES
 };
@@ -272,6 +280,11 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 	__smu_cmn_send_msg(smu, msg_index, param);
 	res = 0;
 Out:
+	if (unlikely(amdgpu_smu_debug == 1) && res) {
+		mutex_unlock(&smu->message_lock);
+		BUG();
+	}
+
 	return res;
 }
 
@@ -288,9 +301,17 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 int smu_cmn_wait_for_response(struct smu_context *smu)
 {
 	u32 reg;
+	int res;
 
 	reg = __smu_cmn_poll_stat(smu);
-	return __smu_cmn_reg2errno(smu, reg);
+	res = __smu_cmn_reg2errno(smu, reg);
+
+	if (unlikely(amdgpu_smu_debug == 1) && res) {
+		mutex_unlock(&smu->message_lock);
+		BUG();
+	}
+
+	return res;
 }
 
 /**
@@ -328,6 +349,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    uint32_t param,
 				    uint32_t *read_arg)
 {
+	int retry_count = 0;
 	int res, index;
 	u32 reg;
 
@@ -349,15 +371,28 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
 		goto Out;
 	}
+retry:
 	__smu_cmn_send_msg(smu, (uint16_t) index, param);
 	reg = __smu_cmn_poll_stat(smu);
 	res = __smu_cmn_reg2errno(smu, reg);
-	if (res != 0)
+	if (res != 0) {
 		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
+		if ((res == -ETIME) && (retry_count++ < 1)) {
+			usleep_range(500, 1000);
+			dev_err(smu->adev->dev,
+				"SMU: resend command: index:%d param:0x%08X message:%s",
+				index, param, smu_get_message_name(smu, msg));
+			goto retry;
+		}
+		goto Out;
+	}
 	if (read_arg)
 		smu_cmn_read_arg(smu, read_arg);
 Out:
 	mutex_unlock(&smu->message_lock);
+
+	BUG_ON(unlikely(amdgpu_smu_debug == 1) && res);
+
 	return res;
 }
 
-- 
2.25.1

