Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE84C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 07:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BF6710EA34;
	Wed, 23 Feb 2022 07:13:55 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 933B310EA34
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 07:13:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SP2pgWZ7LMXDBvozqnjSfLHCYrnoG1P7pJErB4U/vq4jg6k9CCYtGglzUPABxlMGCPpBlPIoqNFpgC5oSwyMa/8ox4c45SD3+7XrelZNA9RWvrkJiO9qytbawV22+OsY359NduDISdwj7qre9rDmOa9s1s4L5/ZqxakqdKpttsuBGTI+CK8KrQxBPmIC2h4X1s3f/18YRjpVV5/VdXBgRij53QzlYUf4Y6//X37JWtnm+P2lgIJF4fcyuNNDl2KXUQZ8rVk7NI9leIkwWOQWrfYLTLUmc3ho8TbD8H+0V9Z4JiQtcBGUrhFo4Og4vr1+2M7NKy5MQCdoXCqtZE6tfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5mHOC8lcwjt9P1eI0Yp3Un68pIojsbnGwGFbelZgEU=;
 b=P3I/WZqZD16gPyShFFZk3yraW1azlKUrU6tIBcXzNhSGJVUcTatHIfwCWtwVwSKNKLBt9QgepsYFiTQSKjJO9ioiR4avMItROC2ZcenLVmE0WFEtOs27z7pC47NEbZLB2+gRo8YEax8gRY/0yY9kd5IVgjJKHJJLFWfiJNNMnQrmmmkiqzgnfJHxMPh6FiISlQ5zqaCw0bJ+htFWEsn4Bj5r2aI58vFyB90hcrw49iQlbJ464nQnMgRUwXfU470V2m+TDW7vVfm+uaGLn4xKFxITjy+jBhwtSjzFaHXPl4cK6mEpAEBLLOCxXuN51XQk0kycr/OnSzpF082CA/fi0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5mHOC8lcwjt9P1eI0Yp3Un68pIojsbnGwGFbelZgEU=;
 b=kdCFyZ/yJCtkyrMx3QwIrtVjrzSaa1TzSMp+pSiil4Imd3FLX6kQ2foSfhJgvgZQplbz+X05EjbNZodHYn2DjPae5tYJGvo4yAlQVZOUQKCcvudgAhouSSyul0Xh36xeJL4+EGO17gOh312CIoLZ2RYGSwpyRITnFADQ8cN8xu0=
Received: from BN8PR04CA0031.namprd04.prod.outlook.com (2603:10b6:408:70::44)
 by BN6PR12MB1572.namprd12.prod.outlook.com (2603:10b6:405:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Wed, 23 Feb
 2022 07:13:51 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::7a) by BN8PR04CA0031.outlook.office365.com
 (2603:10b6:408:70::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Wed, 23 Feb 2022 07:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 07:13:51 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 23 Feb 2022 01:13:49 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v13 1/2] drm/amdgpu: add debugfs for reset registers list
Date: Wed, 23 Feb 2022 12:43:12 +0530
Message-ID: <20220223071313.3757-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c383424-6937-4cfd-2ec7-08d9f69c0b5e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1572:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1572346CCC75CCF21B091657F83C9@BN6PR12MB1572.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: havcs6peUquhAhHFBDTJPn3T7UYfXsTkuJn382TMDk1P4k0plaWg1Vmz2+AvVOyhVVJxaJCnY8ssUHhf2Ibtfh86LaQVHUHgN/n2CBXApoyI8zggwOen2RARdpfXWdoSCpB79GG0TUgDm+XzDxgOT7d8PihsJ7gw9bxqh6YlGRqEOQgDHpf3zmkBAW69rrLTr2/okiI9tdSPXFQUXzYoFbjotWhbatYZYGY+eMpmmwYUpBHtpNHSg8qKBgBX/Ve6F5vr47L5f6GR6QQsNi337taO/fTkDCsR8e3McNwWl1ZLQ4a81JSiE5KtavJxbJhTyjSinOENlzRptaxoHy2Z/mzSNxtbQ14Qto2ARepo4SvxEmGUWcR/hq3Fp4gCdWf9N5H56VGL+kPCBgfpVG/bRM6o7VpJw5Wj/kLdsKzifx+j7QSbWG5xqUglCfD+1GjQ7HV+cGpJsOQLEcgWhW8do4nmf7hR2ZyUL+fxf6NhLHhrvl4fkGowNSsKhUaA5M3xqxqzvd49HuwR9Ryda43CJnHcUkfjOyBOSSA5dTZm3LHkA931m4U4FkW3Zsia7DAwkJ81z6PBs13YTilMKvi2VqG+Qdm0fywYFXJgua9r8bIeuJS1UXrQBwlgFxb3RMYkQ/UrErBZAcu37a4rCz83p9cWrSkiPZPJtPW1LF1IUWBm9JzqYX1U3YoqZXczPlUSSOaEurI27Yes1T3Kw2ixxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(16526019)(7696005)(36860700001)(426003)(8676002)(6916009)(70206006)(36756003)(70586007)(336012)(186003)(4326008)(6666004)(26005)(47076005)(2906002)(508600001)(1076003)(8936002)(356005)(82310400004)(5660300002)(316002)(2616005)(86362001)(81166007)(54906003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 07:13:51.4907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c383424-6937-4cfd-2ec7-08d9f69c0b5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1572
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 82 +++++++++++++++++++++
 2 files changed, 86 insertions(+)

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
index 164d6a9e9fbb..b91f21cec269 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1609,6 +1609,86 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
 DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
+static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
+				char __user *buf, size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	char reg_offset[12];
+	int i, ret, len = 0;
+
+	if (*pos)
+		return 0;
+
+	memset(reg_offset, 0, 12);
+	ret = down_read_killable(&adev->reset_sem);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < adev->num_regs; i++) {
+		sprintf(reg_offset, "0x%x\n", adev->reset_dump_reg_list[i]);
+		up_read(&adev->reset_sem);
+		if (copy_to_user(buf + len, reg_offset, strlen(reg_offset)))
+			return -EFAULT;
+
+		len += strlen(reg_offset);
+		ret = down_read_killable(&adev->reset_sem);
+		if (ret)
+			return ret;
+	}
+
+	up_read(&adev->reset_sem);
+	*pos += len;
+
+	return len;
+}
+
+static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
+			const char __user *buf, size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	char reg_offset[11];
+	uint32_t *tmp;
+	int ret, i = 0, len = 0;
+
+	do {
+		memset(reg_offset, 0, 11);
+		if (copy_from_user(reg_offset, buf + len,
+					min(10, ((int)size-len)))) {
+			ret = -EFAULT;
+			goto error_free;
+		}
+
+		tmp = krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_KERNEL);
+		if (sscanf(reg_offset, "%X %n", &tmp[i], &ret) != 1) {
+			return -EINVAL;
+			goto error_free;
+		}
+
+		len += ret;
+		i++;
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
@@ -1672,6 +1752,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_test_ib_fops);
 	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
 			    &amdgpu_debugfs_vm_info_fops);
+	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
+			    &amdgpu_reset_dump_register_list);
 
 	adev->debugfs_vbios_blob.data = adev->bios;
 	adev->debugfs_vbios_blob.size = adev->bios_size;
-- 
2.25.1

