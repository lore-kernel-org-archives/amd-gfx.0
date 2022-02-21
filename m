Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCC5C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 07:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60ED210F71C;
	Mon, 21 Feb 2022 07:16:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3355610F71C
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 07:16:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMZ7P1bW3yhV1O+JseBuPfpsI8qPKOeM/Y5cwexzbe5QIM1QdiajIbH5PikxbewC4tstnwtdxoGBwqI6gSBxipIGHDxKY6i/Lk+hMCXAm1/5p8rNEitSaqj/7Kj+ZngCqmjFjX8Vlik5bGclSqkLCVlRMOv706zHw/q9wEaIFQwYI46rYTWoItXJJDFcodFESjQR9iR4M4fAYiEtwGz/Hg2tqIfo+lBwDOv27jfpoOuccwAtdUNt8n3EUEEcGgO5kVxhPaySqshOcaFKyh748gSPhB9SGY8QL3N72TLIeEdo5EXAVUhrSrpqFJOLDUPq5T/vG6a7Tl4+5xIQdAMHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOXUTiTXd1RN0WeZwPGoNiNfNY7kAZkKHM3jRmlAGN4=;
 b=ZLZ+zi32mCxgh+yrrODzEbF6+TYIBkGJuY/5WbS8AU2B9LvbvLq/Y1GrEt02vCkBh4wI+z1F2Z3awiF0msRXHcbb9w9HZ1y6OkartjgDrplPxTpNKnHj6XD6m5NoJc/eVl511Usfcn8NGyfjR2/glpjHOGD3rIA56QwK8X1/cwjtrnI/Kmbh/MQzUvw9MwZDc3TWqehDkHom8HfLz2rPq45xTSQtF90rwJQjd5GeS42CZ1/2vKK6sgTInQ87tHcFSV3Ja5BFe9fuSGFlUDSy6MPwW7UN3/lVFCp6Ok9xnlYtF5hVeIKQ7tur7uQzQzZmV0ILV8v9DGllFmn0twY1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOXUTiTXd1RN0WeZwPGoNiNfNY7kAZkKHM3jRmlAGN4=;
 b=2GFXDImxrMH1CksRt3oyVqDcfpr3GedJLQxK2TD04OP2hESz3Kz5ha3oN/ZmGGk4J4Qcl/hCexwhhezv0hn0HpbcwGoRS5B29DDmOjYJRSXxC9NrITolpc+o8SXtlvzqmPVR6VfrqD8KTkny8GdFFayVbIYxWkmJMrsw9Jn76TA=
Received: from BN0PR04CA0141.namprd04.prod.outlook.com (2603:10b6:408:ed::26)
 by BY5PR12MB4853.namprd12.prod.outlook.com (2603:10b6:a03:1da::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Mon, 21 Feb
 2022 07:16:09 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::d3) by BN0PR04CA0141.outlook.office365.com
 (2603:10b6:408:ed::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Mon, 21 Feb 2022 07:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 07:16:09 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Feb 2022 01:16:05 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v8 1/2] drm/amdgpu: add debugfs for reset registers list
Date: Mon, 21 Feb 2022 12:45:39 +0530
Message-ID: <20220221071540.2485-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e5fef80-95b8-44fd-093a-08d9f50a08d0
X-MS-TrafficTypeDiagnostic: BY5PR12MB4853:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB48537AE9F37C86A869ACA5E6F83A9@BY5PR12MB4853.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xs9Pt8QYVE6i46T7cI5JlXdwCkWeRnpbwI2fvJ1nS5/P4nDbyV4JEXlaeO4+1Tq15SuciYJ0DD4V79IDmqj8ye2Zw8cyXK6vWB1pHq3+J92zWStCYAPjPGt/JQM4Un/ekghznyxBtF2z19zTXqJgiEaQ+TtEfI0ze+IJNEb8hsfhba8jj43fmpbo4/Bnjk2BaPY45N8vanXc9XTaPFIsJpHZpNBWogPBh5Mjff3z+R7KMMIByMGSdTE/FDQa++4JO5mGT5LEG4V0FhHO9FCo0o9A/GJod4HGDEgOl+XVQ65lFPR3j+XxxbmfxlbfyGRcZ7CnKD/TlgmJj6HY2zcm/IggKBhfDfRIypeYP40evZmQD8fLG+E5vC+0T7n8FynjMauldvWuXlhnSZEI9sbRpJ/T5nrYuYsh2Ot6yKlHCfaJLKdSYC/Zc/BG1IF7ar8wwx4/BHrsaVOvp7MZOyi3ju0gpT6iM6Eg1AI35qwY8JIevodo70Ss9A2P5CwmOLjsn6PNeo52S5L1Uj9h9tBl3AtadGvmi9Cvlv0M02vHR6bhFcbdnajIwLmhJkQOMZN8Eh5BjDaVyneWWx/CrJWnah7qopf+efbxNBNyAm/p9JYLTi+2C2GpgZXi164uYFciBn+ncoEfJUq0ogd9VNjPey4fJCuhQ5aDlGT1xfBBoneNDMdKVM88vcWmMfxCdzqS/8PNTUi0PbOCOXv3lrwe2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6916009)(6666004)(70586007)(508600001)(7696005)(5660300002)(4326008)(1076003)(186003)(336012)(426003)(26005)(316002)(2616005)(16526019)(70206006)(36756003)(47076005)(8676002)(8936002)(356005)(36860700001)(2906002)(40460700003)(81166007)(54906003)(82310400004)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 07:16:09.4715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5fef80-95b8-44fd-093a-08d9f50a08d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4853
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
Cc: alexander.deucher@amd.com,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 christian.koenig@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

List of register populated for dump collection during the GPU reset.

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 114 ++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b85b67a88a3d..6e35f2c4c869 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1097,6 +1097,10 @@ struct amdgpu_device {
 
 	struct amdgpu_reset_control     *reset_cntl;
 	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
+
+	/* reset dump register */
+	uint32_t			*reset_dump_reg_list;
+	int                             num_regs;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 164d6a9e9fbb..14ad9610f805 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1609,6 +1609,118 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
 DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
+static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
+				char __user *buf, size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	char reg_offset[11];
+	uint32_t num_regs;
+	int i, ret, len = 0;
+
+	if (*pos)
+		return 0;
+
+	ret = down_read_killable(&adev->reset_sem);
+
+	if (ret)
+		return ret;
+
+	num_regs = adev->num_regs;
+
+	up_read(&adev->reset_sem);
+
+	if (num_regs == 0)
+		return 0;
+
+	for (i = 0; i < num_regs; i++) {
+
+		ret = down_read_killable(&adev->reset_sem);
+
+		if (ret)
+			return ret;
+
+		sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
+
+		up_read(&adev->reset_sem);
+
+		ret = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
+
+		if (ret)
+			return -EFAULT;
+
+		len += strlen(reg_offset);
+	}
+
+	ret = copy_to_user(buf + len, "\n", 1);
+
+	if (ret)
+		return -EFAULT;
+
+	len++;
+	*pos += len;
+
+	return len;
+}
+
+static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
+			const char __user *buf, size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	char *reg_offset, *reg, reg_temp[11];
+	uint32_t *tmp_list;
+	int ret, i = 0, len = 0;
+
+	do {
+		reg_offset = reg_temp;
+		memset(reg_offset, 0, 11);
+		ret = copy_from_user(reg_offset, buf + len, min(11, ((int)size-len)));
+
+		if (ret) {
+			kfree(tmp_list);
+			return -EFAULT;
+		}
+
+		reg = strsep(&reg_offset, " ");
+		tmp_list = krealloc_array(tmp_list,
+					1, sizeof(uint32_t), GFP_KERNEL);
+		ret = kstrtouint(reg, 16, &tmp_list[i]);
+
+		if (ret) {
+			kfree(tmp_list);
+			return -EFAULT;
+		}
+
+		len += strlen(reg) + 1;
+		i++;
+
+	} while (len < size);
+
+	ret = down_read_killable(&adev->reset_sem);
+
+	if (ret) {
+		kfree(tmp_list);
+		return ret;
+	}
+
+	kfree(adev->reset_dump_reg_list);
+
+	swap(adev->reset_dump_reg_list, tmp_list);
+	adev->num_regs = i;
+
+	up_read(&adev->reset_sem);
+
+	return size;
+}
+
+
+
+static const struct file_operations amdgpu_reset_dump_register_list = {
+	.owner = THIS_MODULE,
+	.read = amdgpu_reset_dump_register_list_read,
+	.write = amdgpu_reset_dump_register_list_write,
+	.llseek = default_llseek
+};
+
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
 	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
@@ -1672,6 +1784,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_test_ib_fops);
 	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
 			    &amdgpu_debugfs_vm_info_fops);
+	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
+			    &amdgpu_reset_dump_register_list);
 
 	adev->debugfs_vbios_blob.data = adev->bios;
 	adev->debugfs_vbios_blob.size = adev->bios_size;
-- 
2.25.1

