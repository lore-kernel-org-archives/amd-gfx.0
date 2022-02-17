Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7ADC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 14:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCC4310E9B1;
	Thu, 17 Feb 2022 14:29:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E9D710E9A7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 14:29:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqLnjK5aJmsNFPxJ87feyxv4i9yG59MmNEA+IpBF9k06Kvh3F1C3KPwJ0IP47x69LrrhUi5+72PeTHzizMIrAxMo4kBn9xM7OkeYPPmrPlDYojr9U8mnoLqYCMm8vV+qFUTwpOLXyFLIHghA2oT1mWHP6SLf/tQ17rQUprpwSDf9b6AJmjZaWoBcJ1JryaVbtS/rnCWfagYq2vII53Vd1HrLZcrILaWsy28CbAlyhqArs2qj7j1gbxyi0LAxNuEXTliyaVtbFA7X52NMmdJHWi1sL5U8Ya1dHVHh5wpg4e4dzbpzB1WLgqx2j0nMupAuGTrbCzrmehEQ8QMod/cFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeiCSZ4Dhb4kadfsXpM7Ecpq/puokEa25z5QAq7cnPA=;
 b=mjDVCBqUhj8fTuGOL448cCngFP6QXVMhoXjYmS1CoQIyl9x0GnOaIRF3mLWSrcbwq3chpS3TTxRR6sgbRV38vZyVzLLrpReSIaNEGS7XvYGbTuvRX8PS1lTF0vnkZiSqGTtoj4HIIhpm4nqnD0BaNwbvuGdTVfrsSl+8BfK8ecxyYZxczwKtvxyn+lCC8aXANQvcoN2o/X7r1BkZxqxlagZlRteSnHoiJ/q9m1KdgRU+qvVdKkWTC8bE3yaXt+6G5mx5NATziRiZpcLaf13ZA+3vf7NpaLBlJBr53pbpvNx6T/IdJj9HUsEzjxWFHSyJCh9nh9fiKPV8UeTe87YGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeiCSZ4Dhb4kadfsXpM7Ecpq/puokEa25z5QAq7cnPA=;
 b=l7wYxbRVz3Dbz2UrjxmhuWLEdFa7qRYxiMmoEpMwFEZF7x98adcABWGzwS0BTHqDkfaHbO2dJ7EKX6K0exJ3Hr/SWaOaErdi4OYaEy+eG93Cg58gqWMvaH0Z+nTBBelec+0RyBymtJD2TgVzsWnGjfUWJvt1mhjdEUj5N7KbWAQ=
Received: from BN9P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::28)
 by CH2PR12MB4908.namprd12.prod.outlook.com (2603:10b6:610:6b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Thu, 17 Feb
 2022 14:29:48 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::8b) by BN9P220CA0023.outlook.office365.com
 (2603:10b6:408:13e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Thu, 17 Feb 2022 14:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 14:29:47 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 17 Feb 2022 08:29:45 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v7 1/2] drm/amdgpu: add debugfs for reset registers list
Date: Thu, 17 Feb 2022 19:59:17 +0530
Message-ID: <20220217142918.3624-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ebb8dad-77ef-4480-20a2-08d9f221f326
X-MS-TrafficTypeDiagnostic: CH2PR12MB4908:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4908F03D5BF0B082777AEDAEF8369@CH2PR12MB4908.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnz+bldr+WHLMlzqqs43bk2sqjuWPff8aqwSsCfAKClAaPHVdDHtbhP19wtwmIOFi/99k1KH5cgG9S+t6J6azykNqWmUv3ydeae4yfYDLIDxSxTTMZgP2PyMGnjHwmPh18e8BWGPIYiRxU4oxwrwoaFSivZgLod7P3dH0Q7z1pw6eQ/fHaeGnt7+YciXQ2ogTSm8trI9KV1LizbPdm5qJpqacK7v8FH4NlwRIC3i3TaHKCbmj5K5rjy+EvmrgBIHzyZ6rRIpYkUzOXH3YmT8LxK5+kv7ewOv6i3XW/9dwGfMo0j5zNPrXVrYCoe8lO5IrUjrmq1rkUnUaAPEhMwELVezlhjpXmY8yFlV+3hHhHo7ARzdliiwLi6MJByGYN4PWCDeS/i5UwEKplM7Ww8LhwbY284LvJASfY2qKpfruPIDQlQ5EoYg92Q29Psf1XsLx99BUztq3/m3flL2PjwJ/3TUYgd3q/YewT0zyfJeunHPrQX5k+bSkx/U0Dzr2YrzQox1lqCcC4+vFlKt5adfeD+6M/A4qWN4f+wkRoGzCKQ++BauOA3WJRAIxLvh5R9yRXhH+O36d/OTUWp9NKpasq6G29LQ7aAZzI+DwZRZ2MwdDFbiNy9x/iq1p43Qzq/FlfI1Gn9HF3ik28xR9qbiniCWtjzaokFx2DWsF8aZBrpi8MYwXeyoCPXqPhLDanO72i9cFA2kf2wTuP/nEuCMsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(81166007)(356005)(82310400004)(47076005)(8936002)(6666004)(7696005)(8676002)(4326008)(5660300002)(426003)(336012)(508600001)(54906003)(186003)(70586007)(16526019)(2616005)(26005)(40460700003)(36756003)(6916009)(1076003)(86362001)(70206006)(2906002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 14:29:47.6059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebb8dad-77ef-4480-20a2-08d9f221f326
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4908
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 112 ++++++++++++++++++++
 2 files changed, 116 insertions(+)

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
index 164d6a9e9fbb..ad807350d13e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1609,6 +1609,116 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
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
+
+	if (ret)
+		return ret;
+
+	if (adev->num_regs == 0)
+		return 0;
+
+	for (i = 0; i < adev->num_regs; i++) {
+		sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
+		ret = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
+
+		if (ret)
+			return -EFAULT;
+
+		len += strlen(reg_offset);
+	}
+
+	up_read(&adev->reset_sem);
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
+	uint32_t reg_list[128];
+	int ret, i = 0, len = 0;
+
+	do {
+		reg_offset = reg_temp;
+		memset(reg_offset,  0, 11);
+		ret = copy_from_user(reg_offset, buf + len, min(11, ((int)size-len)));
+
+		if (ret)
+			return -EFAULT;
+
+		if (strncmp(reg_offset, "clear", 5) == 0) {
+
+			ret = down_read_killable(&adev->reset_sem);
+
+			if (ret)
+				return ret;
+
+			kfree(adev->reset_dump_reg_list);
+			adev->reset_dump_reg_list = NULL;
+			adev->num_regs = 0;
+
+			up_read(&adev->reset_sem);
+
+			return size;
+		}
+
+		reg = strsep(&reg_offset, " ");
+		ret = kstrtouint(reg, 16, &reg_list[i]);
+
+		if (ret)
+			return -EFAULT;
+
+		len += strlen(reg) + 1;
+		i++;
+
+	} while (len < size);
+
+	adev->reset_dump_reg_list =  krealloc_array(adev->reset_dump_reg_list,
+						i, sizeof(uint32_t), GFP_KERNEL);
+
+	ret = down_read_killable(&adev->reset_sem);
+
+	if (ret)
+		return ret;
+
+	adev->num_regs = i;
+	memcpy(adev->reset_dump_reg_list, reg_list,
+			sizeof(uint32_t) * adev->num_regs);
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
@@ -1672,6 +1782,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_test_ib_fops);
 	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
 			    &amdgpu_debugfs_vm_info_fops);
+	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
+			    &amdgpu_reset_dump_register_list);
 
 	adev->debugfs_vbios_blob.data = adev->bios;
 	adev->debugfs_vbios_blob.size = adev->bios_size;
-- 
2.25.1

