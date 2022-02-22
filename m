Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05880C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 09:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F76610E500;
	Tue, 22 Feb 2022 09:36:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D10510E4D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 09:36:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1bMpQz+MlctsP4eqdAvPM//HbX1tP+vDVTExes4ylMdnLuM/a0KIro5veWOLROt2DCXO4zLnLLasp/LLGVHP39N6px9nriFoMzBGT5TfbxXAysDnM2cKr4qQ2UCgpNWmItugOWKpTWLlTlWmsEV/BeeEL/TGP+f5wBqmVsv/s5PCcUqLA/vFIP3z14EyivjAf7xW4EO0RDTMzDaWlCEuiuQjt6T10VHwVmrfo9sPmavN7ihRNjqSI3Z6MzdJgr/K1RZMaf1mw66OYC6rxpEdyUwlejpi0FANPTN8SZI1qxgNiASVVyXoKayswt+hKM20/45dqIByO0bLMd/ramikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEwTHnQcUgLCad4sac+Yg15YNo/ORu691dJfpKNP0I8=;
 b=T83VpjE6Sx9gzTsumb15zFhPjaT0lBFrJ1KW0dpZpAYfcVMaTy5VFuWYTcZiTA+FSnJZfdLT3RwM/IPdydwAsGDn6thX5WOlVBHYAxa1+N4PH8Udo0MOyz0kOD1M7+Rv+hu8F1i7CtGlH8OSHBc1n3gY6PLhZBP1Nv/4h7F4jei+Hp8KBDAzfZOOgg5FwYNN8HT23/tixZi2bgL6ZD+jiQWmm+72KX9Tx9LK/yhmuLxPC0OWpWpsb6fdFwxzNTX8LXj/3OXvJ9JR9nF5h6Pm4R5wsSkULPDdegizeNRB4LHcVC1wJfUS5WmVTSSiktNt9EJUyDhzG60wKFvP9Zluag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEwTHnQcUgLCad4sac+Yg15YNo/ORu691dJfpKNP0I8=;
 b=3S/T7k1mNe+dIMkqgeE6EdDkEpDPeVhhPaSS8V6IwfRoaT5gAygsZ8L8ZFBv6mshkakoob0H+dUvjg2gfQTZGGnn8ehsjVoww5669XwCEcdQqLHmlLUoLTuWyHbmmvavYFEsiyDfEIZPyhME7T/IykKvIaCg0s698JDBwEjZeSw=
Received: from BN9PR03CA0854.namprd03.prod.outlook.com (2603:10b6:408:13d::19)
 by BYAPR12MB5701.namprd12.prod.outlook.com (2603:10b6:a03:a6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 09:36:27 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::9a) by BN9PR03CA0854.outlook.office365.com
 (2603:10b6:408:13d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Tue, 22 Feb 2022 09:36:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 09:36:27 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 22 Feb 2022 03:36:24 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v10 1/2] drm/amdgpu: add debugfs for reset registers list
Date: Tue, 22 Feb 2022 15:05:58 +0530
Message-ID: <20220222093559.2829-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62cf12c0-2103-4adb-be68-08d9f5e6cc70
X-MS-TrafficTypeDiagnostic: BYAPR12MB5701:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB5701ECB9CB1A80027CF236E4F83B9@BYAPR12MB5701.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ctmsnqv4lg+QKNHs/3LDbW0Xt2dfPsHK4TqHfwJyNXEkpyVtizfLZfuSawUxNmF9U+e9xb1sX9yLqpH7n1+zo53MaHY78mRb6DxMLybt2G/k9+7DDgmLm9TxvTtk3CKJ51y14+L/EicVIXClOxv9Ae5lef07IkePsplh9/iUi95+mU3vS3ZE5Rb3HD0tqkH91Do/DgLaWMZHNCqgJnD0dz97ogltr6dGHQNalrb9arerXUUHv4LZEgh3uWJ3K057uhfRZzcAB+IStwkRrn3H76+kTOjle0ZF1M007dHO2eno16qaLv8oukaZzYrukM7CmkTwg/RaL855TRErJkMhBpuzVPmpsomWEtL96hKgjMdrLTNtMhCW/UBHupdctDRSVQwoHeYyqIN51pNfNnldYMihBUt9+sEOvSXVopezbN+G40y1/D6xer4HD/zL4t9TUsl0oweJYcJd7lP0s5k6UUALugcUIKlfmLQd0u6scYtontLdlEw9M0Jqey/SoJs9Eei+Q/lqxWL5me0/QjeQW9EJFlbEiB705bPhl0BN9OOWrYwtifYErbw7eJQ/92xYAY//eOM+SoJ82RjqdPRXbiNR/Lya1Z0DZlrOOFW2YQm7K2ZP5l85DYDLyA8aF7Mm3eg47Aaf8KLpGZgFMMNrLi/7mq9K1TwYSZH3KUtUz71eQUcRaqjmbJsvPFDbgkmvpVM+/m+4wkAAwMW/6x0uYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8676002)(36756003)(426003)(336012)(2906002)(1076003)(86362001)(26005)(16526019)(82310400004)(70586007)(6666004)(2616005)(5660300002)(186003)(4326008)(508600001)(7696005)(81166007)(70206006)(356005)(8936002)(47076005)(6916009)(316002)(36860700001)(54906003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 09:36:27.0078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62cf12c0-2103-4adb-be68-08d9f5e6cc70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB5701
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
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 92 +++++++++++++++++++++
 2 files changed, 96 insertions(+)

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
index 164d6a9e9fbb..733ee54efa34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1609,6 +1609,96 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
 DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
+static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
+				char __user *buf, size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	char reg_offset[11];
+	int i, ret, len = 0;
+
+	if (*pos)
+		return 0;
+
+	ret = down_read_killable(&adev->reset_sem);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < adev->num_regs; i++) {
+		sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
+		up_read(&adev->reset_sem);
+		ret = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
+		if (ret)
+			goto error;
+
+		len += strlen(reg_offset);
+		ret = down_read_killable(&adev->reset_sem);
+		if (ret)
+			return ret;
+	}
+
+	up_read(&adev->reset_sem);
+	ret = copy_to_user(buf + len, "\n", 1);
+	if (ret)
+		return -EFAULT;
+
+	len++;
+	*pos += len;
+
+	return len;
+error:
+	up_read(&adev->reset_sem);
+	return -EFAULT;
+}
+
+static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
+			const char __user *buf, size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	char *reg_offset, *reg, reg_temp[11];
+	uint32_t *tmp;
+	int ret, i = 0, len = 0;
+
+	do {
+		reg_offset = reg_temp;
+		memset(reg_offset, 0, 11);
+		ret = copy_from_user(reg_offset, buf + len, min(11, ((int)size-len)));
+		if (ret)
+			goto error_free;
+
+		reg = strsep(&reg_offset, " ");
+		tmp = krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_KERNEL);
+		ret = kstrtouint(reg, 16, &tmp[i]);
+		if (ret)
+			goto error_free;
+
+		len += strlen(reg) + 1;
+		i++;
+
+	} while (len < size);
+
+	ret = down_write_killable(&adev->reset_sem);
+	if (ret)
+		goto error_free;
+
+	swap(adev->reset_dump_reg_list, tmp);
+	adev->num_regs = i;
+	up_write(&adev->reset_sem);
+	ret = size;
+
+error_free:
+	kfree(tmp);
+	return ret;
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
@@ -1672,6 +1762,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_test_ib_fops);
 	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
 			    &amdgpu_debugfs_vm_info_fops);
+	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
+			    &amdgpu_reset_dump_register_list);
 
 	adev->debugfs_vbios_blob.data = adev->bios;
 	adev->debugfs_vbios_blob.size = adev->bios_size;
-- 
2.25.1

