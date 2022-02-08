Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F157C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 08:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01CB410E22C;
	Tue,  8 Feb 2022 08:17:20 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01A3C10E22C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 08:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mS4dF529W+F31liPHz9gZXVWe0GgbI/xhNpE35ge36Prv/xx5sYDE4Pgvz0ykNWaYHx9VWMiu2vfwcZ09XXMNhQI6YuYzy9PTYUhkli/8sKfAR2/yrToPxG6EWo+U6ZBSrFVCsAf1t7PDFnTE6B+mRLkcoxt2CK471ZIrjSCogMwfdLSAb1Uca5WoztOTa70nGD5Nf7szwradlCPht7IEh1pcqziIX+2i1Fy5yv3h/Id2GNEbUBwHufm3uFh6jO+jsugalhAe/ISV/BOq1FJW8uUFYS5cztFcEFzjIJuvIq69EPPfVfwR6WXcqu3ZlP78DVPKpJpNPuKraCqfc7PVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEdFAtvvlkLnxPP5W21DV1dREDLBnZWYxvMgPIWIphk=;
 b=SwHya1e2KiIKXX7GCUNc7719aT5JtH95cE6hvHHZOa9RMlR29rSfFd0gNBcoe+fVsExloYcPO3MeJJXtgBh8Ne/mU44ifr+5/dAvim4yP07rQPFMGqaMzQMxLzF6AinDwTfgDxoKuA3flXCfmEhpkxfqMJaKpLJDIB9orqFh3L/BAXt3Hy1N1b9Rib5FpsfEZHcZEbnkafRSgQ4pGtiZmnVNYqC7JplQkliLi0EW3rxtF4rR8ftCcAuOCYD1Q4Wt6DE5fceXLXNqIf21RFYjv2nx0USsl8wpaYRZ87bloFvphmovWvcxG9Y0qGp8KSHO6CRJbqT5pZaMacP0tNwBlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEdFAtvvlkLnxPP5W21DV1dREDLBnZWYxvMgPIWIphk=;
 b=5tBO+45abiWMd1a6K7p8srWu/wR+zHFqnSSS4Gy97v4NIQtzqFcRUw8JzaY+0DHN7VEKwEgk0v6OyU3eq8QyR+5phm1QFDMN90yejWMyQPQonp7ROF6oKSx4BYZzjCGDANtkRCKOHw5tSrv5IYNyc+A1bqz3l96l2Duaj8tW8EM=
Received: from MWHPR20CA0002.namprd20.prod.outlook.com (2603:10b6:300:13d::12)
 by MWHPR1201MB0047.namprd12.prod.outlook.com (2603:10b6:301:54::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 08:17:13 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::ef) by MWHPR20CA0002.outlook.office365.com
 (2603:10b6:300:13d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Tue, 8 Feb 2022 08:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 08:17:12 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Feb 2022 02:17:05 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add debugfs for reset registers list
Date: Tue, 8 Feb 2022 13:46:46 +0530
Message-ID: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30a5c8b8-75e3-4eda-dff6-08d9eadb6924
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0047:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0047FB526F02F6F6F998FD98F82D9@MWHPR1201MB0047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1EXeijrOzpNonQ8GEjAf5FUUPWHI2sXD6tV4RqUCPmlpitln7fIjBM8AHxGHQwWdXtkBTKCx4Z6STlbPswWWq25GQ+88ueDAqsJuviQxsKCjI0125E1z12OXGUsGmnyXpBJyPcm9MKhBKragTLMtH4HuykVD0Rwot3WI95QqCTAthREOG8WRM0Q6v1LC/wfUmNpHQMMVHduZem0Y21FQTcVQ995R5lAFagSoNmGYSjBdNXZA/57zTyugGgCDqBKlWZme0K2xTqNHm676vn22a7zltQwc8e8Lr7xR7bFFEG7HS8+qFRMu1NpEUvyUJTSfEYBViJFIurc+sRgtbxp81SmWLZ7WUmA/WbHaFxGaNzI91pJp3Scx9jOO46zTWPVKPRUI/n2bdKdFOKchoem/+tjUoEVKsk4xEBnRCSthA15+62FYJYY8di19WPupG5DWueEHrKDPT5IpRjbLn/OinpSXsRC6dCn1MM70Te+NGVEya40/fDdD5+QQ7+fBv76GC8+q17Xhf5TS/kzTCRrnoRng9WFplPIHVO24XETe10bPoTdBKx4BpRygBMteE0Axdlo8Opt1kGn40/uE9NONAMZCj/5pnVm5U0EwokhVr8NmpsdmqIEouNlOjtxSZULS1Fdx6r93YJ6Aa+KM94wd3C3EEftAwyeE6vI4IGB0ih3kXL8tee0ebVmrz3eDQJNYF0KBw5vBI/ef2YJUwbYyOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(54906003)(6666004)(7696005)(82310400004)(70206006)(508600001)(6916009)(36756003)(4326008)(81166007)(8676002)(8936002)(70586007)(86362001)(40460700003)(2906002)(356005)(16526019)(47076005)(26005)(186003)(1076003)(336012)(426003)(5660300002)(36860700001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 08:17:12.7554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a5c8b8-75e3-4eda-dff6-08d9eadb6924
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0047
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
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 60 +++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b85b67a88a3d..78fa46f959c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1097,6 +1097,9 @@ struct amdgpu_device {
 
 	struct amdgpu_reset_control     *reset_cntl;
 	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
+
+	/* reset dump register */
+	long			reset_dump_reg_list[128];
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 164d6a9e9fbb..dad268e8a81a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1609,6 +1609,64 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
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
+	for (i = 0; adev->reset_dump_reg_list[i] != 0; i++)
+		sprintf(reg_offset + strlen(reg_offset), "0x%lx ", adev->reset_dump_reg_list[i]);
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
+		ret  = kstrtol(reg, 16, &adev->reset_dump_reg_list[i]);
+		if (ret)
+			return -EINVAL;
+		i++;
+	}
+
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
@@ -1672,6 +1730,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_test_ib_fops);
 	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
 			    &amdgpu_debugfs_vm_info_fops);
+	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
+			    &amdgpu_reset_dump_register_list);
 
 	adev->debugfs_vbios_blob.data = adev->bios;
 	adev->debugfs_vbios_blob.size = adev->bios_size;
-- 
2.25.1

