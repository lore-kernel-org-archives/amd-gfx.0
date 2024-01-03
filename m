Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DE5C47079
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 08:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80A7410E23E;
	Wed,  3 Jan 2024 08:03:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A12C010E23E
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 08:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp+vyrI7GFijqEeXcttM+Sgon8W8qV0EzEoLvvTJanDfuHdd9NjUj0vG/bHIYd+N54hwyYgsY8c3wRVzrwV46eLpioF5s/wbaOucUg4cZTM4fKT5Bid22iMWAw3Grc9vKVtQExwVwGVyh/Eig+BQfo4qsfAOhtOxeYkcNRuZ2jwheYHH5aJOfMo8Iy+hs5S99DKmPKcNmdlAzrNBKwnquxWaXlvVkt31GAH9OODjGv8m2AW6KSRl3cXvc4YEMQ/8OjdJhiBPAEht7mJ7ta3vnu74S8IIWa4zMyt4NqheY+Su2AohVUhAEVIV+nNpZ87wGZP3oVWYNXwgzryPC26l3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awb4P1kb4Fm/INpci/gvTN/JVJdbHABnEP9kwFeWn/s=;
 b=VM9SNQMXy0pC6ic+qXvjqS23KP6Q/8ru+7O89CvvnJ+5l1jEQIEsiOevRPb2QH/oLBdPlCEgsa7MU5jj9P5vEQx9+JO/txrwJEIj4UA2a3E7nBm6M3zVhUHONLbwBf7kCl2JbRWc6pd+6shUI1dxK2FhGCaSVtGU98e41QVDAbjWAlc3nORCkmh4RgPeW9uFmCmgygvDvSIsWy6QEyaGAM+F+kRGqpJ62dRjefJBFkcXOoTdUKtK8tfM/mIdUgMQ6il7Ov84UDhkLG/wXMKmVXB9oPFkzQc5Jkac9MaXSWj9VieGXDl908HB3nMIjFbgL7/PlnDnokrT6HPo9htgug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awb4P1kb4Fm/INpci/gvTN/JVJdbHABnEP9kwFeWn/s=;
 b=3D8IgGrxRa/546jkxkeZ3LdoLy6z3xQVMTL7wBXQM/xaHrcCyowVnGKNsdCzQX/HDOYPSVqO3GH+4mkYQBiF7Q+ev1LJfesuOeKtbI1UVVF3xNl0nTLLD/QnkPZONGcK33vyGLO7JJgpY+CAeQ1kcxguN1+wVkarFi42bppWK9M=
Received: from BY3PR10CA0015.namprd10.prod.outlook.com (2603:10b6:a03:255::20)
 by CH2PR12MB4955.namprd12.prod.outlook.com (2603:10b6:610:68::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 08:03:11 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::ca) by BY3PR10CA0015.outlook.office365.com
 (2603:10b6:a03:255::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22 via Frontend
 Transport; Wed, 3 Jan 2024 08:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 08:03:10 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 02:03:08 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/14] drm/amdgpu: add ACA bank dump debugfs support
Date: Wed, 3 Jan 2024 16:02:09 +0800
Message-ID: <20240103080220.2815115-4-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103080220.2815115-1-kevinyang.wang@amd.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|CH2PR12MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf25395-38e7-41f5-39cd-08dc0c326dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HdBONLPUJlO4f7jdMcEwoOH1Ea7qKgb/uk2ry0OcismKqmc0SBgtUBOplHcprogqvqAIi5UkqTCZoRpw1tJ2wrINxPg7ArkJ7jlQSMWH/VfTza26p2KObaz43q7lXVVSwgcxH5QTSovI0Dv/JJk+kbMMHt84P1/JoCDHm4XxMD1XCa6kFKNC2831vYCOjEQoemLn5t9ww0hGD0xuuCDlI/oqRCE0BhyWmlUm/CylvlQ19dX+w9/4y6Dksd/NQzei6GunXbGKTAo3Nk38n8ZG/j5RcEGOU0JW+OS+J0gkdEO0Bfpedl7zxbQhK3vKggIkXk3oKYeOTQYCvDwuFjf7fOg9KNPsQguQgei6UdDJTMv7hNGcetvEVR7kE5uF7GV7ZDBU7l5rMSRY9tldoSrkXDiDeMzC1ENMGl+uysiXUZsRIWmRhXMainK5Ct2TqI3drkEu6CEMUQrH8C/VBVex9wSUf67EOD16agJJZuwI/9ggSwJVS3GhACMA7Oew4XDuJGZNR7ShhlDgmNnUet1WHq4RkehjMfMA62cjFE9H1rAqmJKRiX23/1hzLdxsODVvrJIEz1ea5GO7mELhmVbNMfrZrLrOiPYo8aFuQuaIGTga3V/VNeYbSNTSGtneWhjfHMs0DdoHFfBlQyGwCYJyW2/rcFO0DcvZhnchnsMPEF6oBKTOc63u1DborPohOmbDkF0VUWVzLKoENwBYKSZ8LaMwgqDwCCFqfW/FEgBRXrKhGWErf7I1ag5uPRAKKu7rQEInGKTREY7JCpV1NSMYCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(36756003)(40480700001)(40460700003)(70206006)(7696005)(6916009)(70586007)(86362001)(426003)(81166007)(83380400001)(356005)(2616005)(1076003)(47076005)(82740400003)(26005)(2906002)(4326008)(5660300002)(336012)(478600001)(36860700001)(16526019)(54906003)(41300700001)(8676002)(15650500001)(316002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 08:03:10.8975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf25395-38e7-41f5-39cd-08dc0c326dd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4955
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
index cadeda64eded..68b61aaac6d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -706,3 +706,122 @@ int aca_bank_check_error_codes(struct amdgpu_device *adev, struct aca_bank *bank
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
+	return aca_bank_update(adev, type, handler_aca_bank_dump, (void *)&context);
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
index 688907270ff7..961fad87281f 100644
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
index 39399d0f2ce5..038bd1b17cef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3428,6 +3428,20 @@ int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable)
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

