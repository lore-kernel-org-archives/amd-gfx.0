Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC9AC47073
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 11:49:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD7A10E443;
	Thu,  4 Jan 2024 11:49:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77E5D10E443
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 11:49:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUF12PVA2YxRXmR2YncUkllp0k+3RmOa7Zay2fi5i7vyoOvOMlyCD5giuNhJD+htbGFVBZf4SP987M/N0nvA0fwkWJJTHtwHL5973kqCzUEpHNWxA2zg6O4C+1uqeSNmVpmYngQDbN7hb4JEL5QQo6Zp6NEzrmaaj7uKcuVStgdVCUBGohojoUgIbCXcU0yjZWn147t80Xc1UCKmSaLUguWd/7M3RXRd7D/qtw0n1cwQmFW9aL3p7BEqi7QmRrlxg/Ah/pvEVQVxh7mv4+v7nfGYbphLHpF/g59pN6jWJNOXjJVhWQ/DpVvLWdyn50nEiVguJPyYXkkzQ6KmS55TeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSq2FxEwjUa9HkN8Qc30/7NCqNdg/xjuByZ9swq03RY=;
 b=h6pfC4PPnntYLcmuvAcLMy0PTbpjdETaVRr4eSdo4OzxdEfnJLYndDgVNtbSuHiY6kDgW3l0um+TPZOiblRQKfVoG2Anl9YZAWTd6eSZCFCPuMUwHcapplOEL1X4kjxmQUe6CLP09UMuVoDVAGXTETbD/iFzalxk0gVMwzzcGVe5+xYreZRA76ZVlly8vGlG40no4EI+oG840itmRVBs7Ehw6PkPRG/RipP6uX1pPkTYKJMUlCr0aM3k0xxdRBXrH/xey5FHFXIlXJd4SEs1gPx8O7WhhhOuxsQNXR7ctv9pqEmD/xxVprxan3WWXVdihlp+PfC7q4Ks1c+gTvvCDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSq2FxEwjUa9HkN8Qc30/7NCqNdg/xjuByZ9swq03RY=;
 b=UrOjybWVD+TAGmb/lNsAx88NtjiKVE7XAJ0QeitJ7XPfPA4OvB5vfWP09e2oqhKwZBOLpfb4tJ/8P2VofebHjSR7tKZyGRS2F+c52r2tTWEYeSUGtFix7LschU0hyQEzUnMQb+mVOf6ITBB5EHy5n7ERlkqq7jEyYZO7MvsdntQ=
Received: from SJ0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:a03:2c0::34)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Thu, 4 Jan
 2024 11:49:27 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::fa) by SJ0PR13CA0029.outlook.office365.com
 (2603:10b6:a03:2c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.12 via Frontend
 Transport; Thu, 4 Jan 2024 11:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 11:49:27 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 05:49:24 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 03/12] drm/amdgpu: add ACA bank dump debugfs support
Date: Thu, 4 Jan 2024 19:48:49 +0800
Message-ID: <20240104114858.3475783-4-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104114858.3475783-1-kevinyang.wang@amd.com>
References: <20240104114858.3475783-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 6102a56e-c3e7-4699-9ea4-08dc0d1b344d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQyTAct3Rkb/8kD+q7lnAwkOA5AvcyQQFdd1Qk3evFB9nRMaE8gjHGinXMYUZRc9rrwXHGrjmBwpTKkb9b58b/5V5PHTX64wgZ+Ld/Wo3lxo6uSn9LPIFAT329URDLMF0IlYii269jogtcwzXuRYEA+QEHrB18RW96I7oXFJuEqnHtgSrMxFbt8eF6D+ortj4Px2zPVDR1tpoyKovPymaxw5yiBSL0UR6//IhsRCJ7shObKSLkvctk+nUGYVH1CNxxGmhAkcEb6SZ1oNjuoCyHqncAMuQf+o+XrLEtYAQuz/lQ8o13CF7MGclPZSz5/kZUkARFol6Lc8QZtgFQPUi11voSCklEBVMm3ZmIGz7f/ZRpAqqHyDWQEg2P2n+Lby3BtnJuFWAlMYhIv22idZwdOVIR0WzKXJHBlUJiIJ2Xrel5ZtIYv32PIwe5lPBZqK6s5nCaA++AU/oedGy6+M2fuO78EtOojgU2fMCG2DoLcE/BPGirLPX6UfZQmoDLAwWyR4N9Oldf1CVUPrC0rdUwBLD4aFPuIvt3iXP9EtlcHuMvCKBHe/VamyYihl22xZXobbRRbXw+6CvYxbQ3r4GO8U3dYVLrGhK5raGq93DW8dhSIqoQ5Q7hGP5Z99sINudlQNTJYxLCpscbObDsm3AeMswLdptLw3P8VMS8b4DoOrzdISSUPzEAMZi8R12eFmH7/H6x7F9PmOWsEUe+h9pEbUKUiNHPy4aGi4ay2EPkvUOpuH3Cejiv9BaDyA7B89cr1kL4njZjB091XuWr2PHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(82310400011)(1800799012)(451199024)(186009)(64100799003)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(426003)(336012)(26005)(7696005)(478600001)(6666004)(82740400003)(36860700001)(86362001)(36756003)(81166007)(356005)(15650500001)(5660300002)(2906002)(41300700001)(2616005)(1076003)(83380400001)(47076005)(16526019)(6916009)(54906003)(70206006)(316002)(70586007)(8936002)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 11:49:27.0673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6102a56e-c3e7-4699-9ea4-08dc0d1b344d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916
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
Cc: yipeng.chai@amd.com, tao.zhou1@amd.com, Yang
 Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add ACA bank dump debugfs support

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 119 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  14 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |   1 +
 4 files changed, 136 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index f03c7898991c..c447064fcaec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -692,3 +692,122 @@ int aca_bank_check_error_codes(struct amdgpu_device *adev, struct aca_bank *bank
 	return -EINVAL;
 }
 
+int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en)
+{
+	struct amdgpu_aca *aca = &adev->aca;
+	const struct aca_smu_funcs *smu_funcs = aca->smu_funcs;
+
+	if (!smu_funcs || !smu_funcs->set_debug_mode)
+		return -EOPNOTSUPP;
+
+	return smu_funcs->set_debug_mode(adev, en);
+}
+
+#if defined(CONFIG_DEBUG_FS)
+static int amdgpu_aca_smu_debug_mode_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	int ret;
+
+	ret = amdgpu_ras_set_aca_debug_mode(adev, val ? true : false);
+	if (ret)
+		return ret;
+
+	dev_info(adev->dev, "amdgpu set smu aca debug mode %s success\n", val ? "on" : "off");
+
+	return 0;
+}
+
+static void aca_dump_entry(struct seq_file *m, struct aca_bank *bank, enum aca_error_type type, int idx)
+{
+	struct aca_bank_info info;
+	int i, ret;
+
+	ret = aca_bank_info_decode(bank, &info);
+	if (ret)
+		return;
+
+	seq_printf(m, "aca entry[%d].type: %s\n", idx, type ==  ACA_ERROR_TYPE_UE ? "UE" : "CE");
+	seq_printf(m, "aca entry[%d].info: socketid:%d aid:%d hwid:0x%03x mcatype:0x%04x\n",
+		   idx, info.socket_id, info.die_id, info.hwid, info.mcatype);
+
+	for (i = 0; i < ARRAY_SIZE(aca_regs); i++)
+		seq_printf(m, "aca entry[%d].regs[%d]: 0x%016llx\n", idx, aca_regs[i].reg_idx, bank->regs[aca_regs[i].reg_idx]);
+}
+
+struct aca_dump_context {
+	struct seq_file *m;
+	int idx;
+};
+
+static int handler_aca_bank_dump(struct aca_handle *handle, struct aca_bank *bank,
+				 enum aca_error_type type, void *data)
+{
+	struct aca_dump_context *ctx = (struct aca_dump_context *)data;
+
+	aca_dump_entry(ctx->m, bank, type, ctx->idx++);
+
+	return handler_aca_log_bank_error(handle, bank, type, NULL);
+}
+
+static int aca_dump_show(struct seq_file *m, enum aca_error_type type)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct aca_dump_context context = {
+		.m = m,
+		.idx = 0,
+	};
+
+	return aca_banks_update(adev, type, handler_aca_bank_dump, (void *)&context);
+}
+
+static int aca_dump_ce_show(struct seq_file *m, void *unused)
+{
+	return aca_dump_show(m, ACA_ERROR_TYPE_CE);
+}
+
+static int aca_dump_ce_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, aca_dump_ce_show, inode->i_private);
+}
+
+static const struct file_operations aca_ce_dump_debug_fops = {
+	.owner = THIS_MODULE,
+	.open = aca_dump_ce_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int aca_dump_ue_show(struct seq_file *m, void *unused)
+{
+	return aca_dump_show(m, ACA_ERROR_TYPE_UE);
+}
+
+static int aca_dump_ue_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, aca_dump_ue_show, inode->i_private);
+}
+
+static const struct file_operations aca_ue_dump_debug_fops = {
+	.owner = THIS_MODULE,
+	.open = aca_dump_ue_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+DEFINE_DEBUGFS_ATTRIBUTE(aca_debug_mode_fops, NULL, amdgpu_aca_smu_debug_mode_set, "%llu\n");
+#endif
+
+void amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root)
+{
+#if defined(CONFIG_DEBUG_FS)
+	if (!root || adev->ip_versions[MP1_HWIP][0] != IP_VERSION(13, 0, 6))
+		return;
+
+	debugfs_create_file("aca_debug_mode", 0200, root, adev, &aca_debug_mode_fops);
+	debugfs_create_file("aca_ue_dump", 0400, root, adev, &aca_ue_dump_debug_fops);
+	debugfs_create_file("aca_ce_dump", 0400, root, adev, &aca_ce_dump_debug_fops);
+#endif
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index 8cf520403548..747150c02609 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -193,4 +193,6 @@ int amdgpu_aca_add_handle(struct amdgpu_device *adev, struct aca_handle *handle,
 void amdgpu_aca_remove_handle(struct aca_handle *handle);
 int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
 				     enum aca_error_type type, void *data);
+int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en);
+void amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index fc42fb6ee191..dc11cc98c673 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3427,6 +3427,20 @@ int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable)
 	return ret;
 }
 
+int amdgpu_ras_set_aca_debug_mode(struct amdgpu_device *adev, bool enable)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	int ret = 0;
+
+	if (con) {
+		ret = amdgpu_aca_smu_set_debug_mode(adev, enable);
+		if (!ret)
+			con->is_mca_debug_mode = enable;
+	}
+
+	return ret;
+}
+
 bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index c36faf353b46..408e21c3cc88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -781,6 +781,7 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev);
 
 int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *ras_con);
 
+int amdgpu_ras_set_aca_debug_mode(struct amdgpu_device *adev, bool enable);
 int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable);
 bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev);
 bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
-- 
2.34.1

