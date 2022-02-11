Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB69C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 11:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F7410E5D5;
	Fri, 11 Feb 2022 11:48:05 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1DA910EA74
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 11:48:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biDKzW9inhnDeLTcF4uX3kMlzBraH+vVHZa0Wr/5aF1yirK/qpTlzmbBCmV4NABbOmairB4LmqhmZFuFgZ5Bzd5KSe37t6U2kaDAJx5lRCW/OiyN3/teKoVi/o+nz1fuD5fUW2F5KwzlH5Odd4e9Yef5F4aLdgMNEM93yTd732iSscEytVyOR3M45/dlI7SuhmSdw5LMumi2/bUOKOhIyQuk5pd1DJcPw/eyodNZoX2WYFO9AVB61CI30nYEENlEh7SGttLx6T6L9SUt1Geb8B9O1VSK/BMYmrDB669khZRgikA7rCcofJfBwfSL2rqgaXkbI+NruwPbvSEFLHOacw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JD3CFy1W1+uUy2HiFhL0mBN0wgzhkvW+gPL1D52n90E=;
 b=QbQTeYzgFNeoBrw6vgNSLWw8YDuPq0JHlELiGm7j0ecuubggMQN03Iss2neIlPoUVpqwM1fEwLwmDT0HvrShwLNKJd08CaeJF8QmlrAl4vokFfOcjz5gWbfccHAj9k70zY7PzbPqzO5Yr3gvfcr/VC/zyr7EynFUAIvE+N3nh4RM/i/fWl9OjQNnrbenGxEgMM2HPFSJBFXv0ypuBzP1Vo6jaMq1SXCMmD6AuGRjLWUDjggDUYyrguMRW2tA3YIXdUjAgphC8DMsITKbNvprCSCMub95r3LQoxNKIKUSYlmDcaKBdsq2k7j/DSKeJ7xryxYuXTnoBD2HMuG48kmJFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD3CFy1W1+uUy2HiFhL0mBN0wgzhkvW+gPL1D52n90E=;
 b=UnJReEQQK4ldQJDYR+OZSHWDEcd4iCHhwtWBqnughrsg3AulBudJhsRM1Z7xQJNRjsSuOkKnPx1mEQNWiHKpzdULUBf6ZFqOA8/v5fKwLHJQ+HSONlsne52xyCP9p950s2HVdSDKuMhsEmeFPiw4z/9lbXI+ZbJhnfARU6fB2Kk=
Received: from MW4PR03CA0351.namprd03.prod.outlook.com (2603:10b6:303:dc::26)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 11:48:02 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::2f) by MW4PR03CA0351.outlook.office365.com
 (2603:10b6:303:dc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Fri, 11 Feb 2022 11:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 11:48:01 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 11 Feb 2022 05:47:58 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amdgpu: add debugfs for reset registers list
Date: Fri, 11 Feb 2022 17:17:39 +0530
Message-ID: <20220211114740.10904-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4304db28-451e-4998-753c-08d9ed545b91
X-MS-TrafficTypeDiagnostic: BL1PR12MB5287:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52874A95F8E6D28841AA906EF8309@BL1PR12MB5287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23lUhgh/2ed2SjijD2B5sOkhpLXcneAbGcJgcuQPDNlkgJH/I3aEHAPsLxsdI9qxrmln1d6QcaCwpwVliTUxhLnU/FLwNl+P79DMsGubGU835QsGiLaLowCIKknpvOaNF+s9oOVCNWIx+02QZYNeKe5xi2DSOdl8bFodugYVFQ1RhM0KnxOrGm/lzLKVsnStgBRvwesWNqlTtiPdnBPEBeBNH4zzwPZ6zu3KjqVXLfkQ4YBZZDqFD/RhsICvQoOQD258UsIOBCQCUQfBdbjV6eUTl6gQrNYlYxXXx0gDb7XYoLv9UHn5PR5ecxaKkYpFaL84aXRnKSVhgM+psf/9c6vKxTOHBkLBr79Lt6jeeHt0G1HOUBQ6T240G/BbU8nDt4Oux4qxakHhH0P9hmmMpBuFqg7vLvk69+1P0yWEinAfccypczNBlNANIim+7w2leCjoqZ0fhoxpd9cXz+7hA09UvkHPMTMQZ4KsmME1bAdus635C9yH3bPUfmVB5Yq/O+EV0acG3+WEZ6Noyb+eSRI7ya6tHunl9d1qViepGA0SEEl8Uqy2wa6uLv111hfy7qmGbqwxx5zGF5PzVNrImb975jX79lh9PY9Plm8Ct0hHfUFKZEPI5X72gRUvpsvqAdcxYWhpaupOqiUNr+u3w49vyQgTRDsjQdKyChDDFRzT4mDAkK5lFLgtT5SHi57P2q4sxp4dbSTwVDstKY/RIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(426003)(186003)(2906002)(82310400004)(2616005)(36756003)(26005)(47076005)(36860700001)(336012)(16526019)(1076003)(356005)(81166007)(8676002)(7696005)(5660300002)(70206006)(54906003)(70586007)(6666004)(508600001)(86362001)(4326008)(8936002)(40460700003)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 11:48:01.7056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4304db28-451e-4998-753c-08d9ed545b91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
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

List of register to be populated for dump collection during the GPU reset.

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 61 +++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b85b67a88a3d..b90349b86918 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -813,6 +813,7 @@ struct amd_powerplay {
 
 #define AMDGPU_RESET_MAGIC_NUM 64
 #define AMDGPU_MAX_DF_PERFMONS 4
+#define AMDGPU_RESET_DUMP_REGS_MAX     128
 struct amdgpu_device {
 	struct device			*dev;
 	struct pci_dev			*pdev;
@@ -1097,6 +1098,10 @@ struct amdgpu_device {
 
 	struct amdgpu_reset_control     *reset_cntl;
 	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
+
+	/* reset dump register */
+	uint32_t			reset_dump_reg_list[AMDGPU_RESET_DUMP_REGS_MAX];
+	int				n_regs;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 164d6a9e9fbb..fb99f3d657a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1609,6 +1609,65 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
 DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
+static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
+				char __user *buf, size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	char *reg_offset;
+	int i, r, len;
+
+	reg_offset = kmalloc(2048, GFP_KERNEL);
+	memset(reg_offset,  0, 2048);
+	for (i = 0; i < adev->n_regs; i++)
+		sprintf(reg_offset + strlen(reg_offset), "0x%x ", adev->reset_dump_reg_list[i]);
+
+	sprintf(reg_offset + strlen(reg_offset), "\n");
+	len = strlen(reg_offset);
+
+	if (*pos >=  len)
+		return 0;
+
+	r = copy_to_user(buf, reg_offset, len);
+	*pos += len - r;
+	kfree(reg_offset);
+
+	return len - r;
+}
+
+static ssize_t amdgpu_reset_dump_register_list_write(struct file *f, const char __user *buf,
+		size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	char *reg_offset, *reg;
+	int ret, i = 0;
+
+	reg_offset = kmalloc(size, GFP_KERNEL);
+	memset(reg_offset,  0, size);
+	ret = copy_from_user(reg_offset, buf, size);
+
+	if (ret)
+		return -EFAULT;
+
+	while ((reg = strsep(&reg_offset, " ")) != NULL) {
+		ret  = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
+		if (ret)
+			return -EINVAL;
+		i++;
+	}
+
+	adev->n_regs = i;
+	kfree(reg_offset);
+
+	return size;
+}
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
@@ -1672,6 +1731,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_test_ib_fops);
 	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
 			    &amdgpu_debugfs_vm_info_fops);
+	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
+			    &amdgpu_reset_dump_register_list);
 
 	adev->debugfs_vbios_blob.data = adev->bios;
 	adev->debugfs_vbios_blob.size = adev->bios_size;
-- 
2.25.1

