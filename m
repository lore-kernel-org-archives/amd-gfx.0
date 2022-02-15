Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA41C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 15:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2883610E627;
	Tue, 15 Feb 2022 15:36:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A6F210E627
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 15:36:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cF9ry6S6pLJgGZg4tM2XAJ5d//pzXUBR/7QNFlF0GWTY7UDoR9QWQU7EZpoP/coqvrO2GFVArEbiP/fO042FYHcLBrR1ZoDd43pfuSoOxl4jIfsVDQEgmcbUdTJjWq+x6sfWNrKkX2CDpjx5Wq3fiGGO3ttI/rfQPSJjO4bQ3Ww0Hm83V62NSscNmN2F41pN44dzt60YVfFvTIEkufByRGhj2G4AP0KITxQugXg9/Myn9FYbbrykOUFajOrvDMIQNZOenquuL83cWHToglS2vRZqVGYV4L2vU52uP+uJ6nsTu5XVC0QMfDgl3lNYY+eNTg77q383P3PlrNQlvSNqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cImUKv6m3aLm4V1e/flLX7MYqxuRL6SIXkFFihDqAMI=;
 b=dvXThgSWkWKZAWf8wVaqGTFSGeD8G18D/ZCojkgprCl8sn/sr5Qw55zk4+y5nMquedjGDHKEmHGhyJmRL6n9k3Y2jlnGqb+n6yPWqMin9LfpZPlrUxf2yr1swM7QzfbsL222MG0vfShzcTutvMyk3oAY/tnppQ65A56uSACLibpJXkOIfQWCOlD9lTE4jvSVQAiLENuWRkfdenBOnfk8s+vUvYnl5mszRt96FBU0tDNeFlGuSZ7QiOpP2b8vA4AEUL4VjG5IlNxSrryjkAVWqbiDucZCIzzrVRx9gTB+NM/n/s9qkIQeQKRc6KHsiE5lsQTkMZFLFHXSn20jOHnIeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cImUKv6m3aLm4V1e/flLX7MYqxuRL6SIXkFFihDqAMI=;
 b=PS/QvWVPv8hgP1eNC/rNpjLWtq/I9WNmOiBnm0jIqVr7yMYT9Z/WV9mTp/LNqV41QCbfbOluTTx2atoXYv8ZfInARAAZ54SRwDAzKcL/JgBXXUpUl1WrLNhc/ci6eXzD1Os7pt18f0PCbDRtFV0c1rtni+IGqxKw2wqG7q5mLS4=
Received: from BN0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:408:e4::22)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 15:36:41 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::e) by BN0PR02CA0017.outlook.office365.com
 (2603:10b6:408:e4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Tue, 15 Feb 2022 15:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 15:36:40 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 15 Feb 2022 09:36:38 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 1/2] drm/amdgpu: add debugfs for reset registers list
Date: Tue, 15 Feb 2022 21:06:10 +0530
Message-ID: <20220215153610.2471-2-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215153610.2471-1-Amaranath.Somalapuram@amd.com>
References: <20220215153610.2471-1-Amaranath.Somalapuram@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2594659-1c88-460a-75dd-08d9f098f6d4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4138:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4138B46115676578BAE145EDF8349@DM6PR12MB4138.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eS9Zd8UBqILM0UkvfBlyAudFHb0CRbORVyUCREb3OZHBtFNbWIt88DX8eRU9EPd2yXmJg2MhZx2X/WfKonI23i8RJJDn8VYQKpx29+6L3pYSLCRihF5mP29tgrOBNyaD/9BMScillro5ow6zH7xERjluRPJhhN8/h2B3N85OdP5AJgwewv17HX/anXXIBE1JZoTMVIYuPX2d8xzhQtuuNiszgMJwhNH8oB4ImdAM4e0VLTPY+O3yqh+kM7j397gQG0SkO63qiOnIgorfRe4vdm9p1vjZakvpw43b+teMJVNX7b3fN3NJC92PwR/xi1eRzset6hqVQXeGHiZfsL5930bVfgowAe5bks1tETIacYYRPn1Ex8l7a31O91ZSmwR1nCHl3ay4QmfJsN5IvlH7+hczw6vWnPAzB2AoboZRpHeFMV8+mCclWEZeHrbmzl0WWFPwegmf1C8lWJjD+hVvCXitw9kqSRNbShJrP3kigbevyjPqypQJvMnYH4wgL2rqoNKLOdsmW7vbD6VlZXI6HULaSyQC7m7mb4qZNOfYuykhj5r3XZQZBzgWoiBWQ3/XJRB5beoTA50IZ65wmK1jnJl2OMJImD4Nlh/WR/Q0+bfQ0DEZrnbISuVzd8WiAQfxwOK5EMMpOy5KT3FYD5mfrjIekequTeoO9XmzK8LCc1zwbhlm5T7qnOSuRYO/bWbqCSicBSoArqk4sPEx7AcMVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(54906003)(6916009)(316002)(508600001)(82310400004)(7696005)(336012)(426003)(86362001)(36860700001)(6666004)(47076005)(40460700003)(26005)(186003)(2906002)(36756003)(5660300002)(2616005)(1076003)(8676002)(4326008)(70206006)(81166007)(356005)(70586007)(16526019)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 15:36:40.9263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2594659-1c88-460a-75dd-08d9f098f6d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 +++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b85b67a88a3d..2e8c2318276d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1097,6 +1097,10 @@ struct amdgpu_device {
 
 	struct amdgpu_reset_control     *reset_cntl;
 	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
+
+	/* reset dump register */
+	uint32_t			*reset_dump_reg_list;
+	int                             n_regs;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 164d6a9e9fbb..be4336574fec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1609,6 +1609,99 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
 DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
+static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
+				char __user *buf, size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	char reg_offset[11];
+	int i, r, len = 0;
+
+	if (adev->n_regs == 0)
+		return 0;
+
+	for (i = 0; i < adev->n_regs; i++) {
+		sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
+		r = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
+		
+		if (r)
+			return -EFAULT;
+
+		len += strlen(reg_offset);
+	}
+
+	r = copy_to_user(buf + len, "\n", 1);
+
+	if (r)
+		return -EFAULT;
+
+	len++;
+
+	if (*pos >= len)
+		return 0;
+
+	*pos += len - r;
+
+	return len;
+}
+
+static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
+			const char __user *buf, size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	char *reg_offset, *reg, reg_temp[11];
+	int ret, i = 0, len = 0;
+
+	reg_offset = reg_temp;
+	memset(reg_offset,  0, 11);
+	ret = copy_from_user(reg_offset, buf + len, (11 < (size) ? 11 : (size)));
+
+	if (ret)
+		return -EFAULT;
+
+	if (adev->n_regs > 0) {
+		adev->n_regs = 0;
+		kfree(adev->reset_dump_reg_list);
+		adev->reset_dump_reg_list = NULL;
+	}
+
+	while (((reg = strsep(&reg_offset, " ")) != NULL) && len < size) {
+		adev->reset_dump_reg_list =  krealloc_array(
+						adev->reset_dump_reg_list, 1,
+						sizeof(uint32_t), GFP_KERNEL);
+		ret  = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
+
+		if (ret) {
+			kfree(adev->reset_dump_reg_list);
+			adev->reset_dump_reg_list = NULL;
+			return -EINVAL;
+		}
+
+		len += strlen(reg) + 1;
+		reg_offset = reg_temp;
+		memset(reg_offset,  0, 11);
+		ret = copy_from_user(reg_offset, buf + len, (11 < (size-len) ? 11 : (size-len)));
+
+		if (ret) {
+			kfree(adev->reset_dump_reg_list);
+			adev->reset_dump_reg_list = NULL;
+			return -EFAULT;
+		}
+
+		i++;
+	}
+
+	adev->n_regs = i;
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
@@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_test_ib_fops);
 	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
 			    &amdgpu_debugfs_vm_info_fops);
+	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
+			    &amdgpu_reset_dump_register_list);
 
 	adev->debugfs_vbios_blob.data = adev->bios;
 	adev->debugfs_vbios_blob.size = adev->bios_size;
-- 
2.25.1

