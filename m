Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7883C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 10:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A75410E425;
	Tue, 15 Feb 2022 10:13:08 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2088.outbound.protection.outlook.com [40.107.212.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C787C10E425
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 10:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKR/29MFJ/cm72bbTjfwPfDdiFYlfZmpxpZI/pPeh7+76oPpv3HV0IT7xLiIsg2j5LLkt0ZpH44riRJ7pCnnqZWxA3ZTfYo4RrY4BrN4qM+OhL5kwBwzf0YRMgIngH+hiEvO/PIQKa2Gun2m35W9cytYCG9KVn0Ymnz7sKtCB8yW6M9rm/lR5Gwv0L53BFw2DUV/HM2t6FRom5W0J6nx0pkCErTH6ec+r0LiVwqB7gNNE+X+hCY34NS901HiTZWIKQPQlx1ms+6pzWh4SrVClircktX80VCmx8odx0cZ2OQC/SS3H/ZiihawWZ7rS8s1/k85+90OddvV1ALCc8A6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mDpiJav8oPpAc4TZkoG+wyBdBXihspXeV8j6vCjZlU=;
 b=PbO4HKKj2cB4Oz9SbfOFZGXdjYJn/+tw6ZW+rRiaP0o7/Co387aZdh6GoY4KeieWgxLZKf3/HO3TPpvs/AfK0yAacORDWFIKduWIbKoj09YFZkbPzBRMF93+u/rtdQj8jsLKHc1XC2zCcm8PYVhWCs8XJCjIlda6i7r5FfsNIZ7yFvSK9L32LGrTKBy3EYRtur5ygPdbNIKmKbdiKPjKsiRlIjGmeB5cZlEkSQnpNVFd9OjiBn5e2f9GSdjMNIYm3a6qrODI3a0eQ04B5laI7FGrRrCqpiYyLwigvBZrwFU+1LUB7XU9+xwoaRQslz8lJ65dDndhBut78Ijkcv8mGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mDpiJav8oPpAc4TZkoG+wyBdBXihspXeV8j6vCjZlU=;
 b=wWvteY2YaKB3UpkLQyeOGYqOOlnEZ/sYvt0/jaIYNnsZ8k70fz6rASfRctkXukD8IMITid9mUYIChmtzpjQRdLy9IpjeeDhvXzHjpoMpnjmkbuUU5uFRR0cRKG4SfnWopMsxY77rxmN82Lpww/Ydkny8XQqos2vrwd5glACm2DQ=
Received: from DM6PR21CA0006.namprd21.prod.outlook.com (2603:10b6:5:174::16)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 10:13:03 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::3a) by DM6PR21CA0006.outlook.office365.com
 (2603:10b6:5:174::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.6 via Frontend
 Transport; Tue, 15 Feb 2022 10:13:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 10:13:02 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 15 Feb 2022 04:12:59 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 1/2] drm/amdgpu: add debugfs for reset registers list
Date: Tue, 15 Feb 2022 15:42:27 +0530
Message-ID: <20220215101228.9433-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ef0ed46-703e-4a10-e0ab-08d9f06bc03d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5368:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5368C573EBD001DD75B297B9F8349@BN9PR12MB5368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1K2Of3w3KQkUvmfGStkBwVvyTBKhWDIq9aCuYs6VTvLdjuO4qO9GgyUnfAqCKctjFlzKNp8KRIt6SPIuPpMt+0djzCkkL50Boj3yvu9n5XHzesNP59Cw1A/MpjXncfRd+M1TwoU0XTDtUdVHKnkj63xc0MEbCJhWX0mylZZY6pXG1tPpJJwaeNuB7i0slAiXC4rRK/VbdW22CFlMogfGyui8fkERQNERdt4r09ecgfS8sLImFRWKFA4VSsYU/PBBOr+SmKl76V+PO2QD37wmG4h6JBLqNxYw6Iq+cn0ayda0/EOsAv+Hgdqgg/ZS1yTLViY/RAY177vwSw0F89snShHoLiiZIvOhQe9RKnlOYYuh8VdxKCbG3e06K7t/O/OGseraT21kvkICg2u9i9VDheb5a9dmqZG3ZNggC5Rj7HgdkHodS5Cj11rhLXDz8oFIEof9MI14Y6/MQSeA1DZF2XSHce8VAZXubcZ9wO7Q8LnWiQsvLSOsupGOOqbVBbzqJ/axy2tiIxh1paF14yUB3Df7YM3POxFcPEND9A7jhW/x63TGcgwIgGaQLSO0Z6LZCjvRzFL4d/uUoRAC8dEuIimEUxDAvJtDg9xCwwQFR86yKNMX0ZIFiTZTKpPQNN2mbnikRZAAvVt5DNT2vgMl0W61B7KPDGj/I02JB+6GGrxZUk9X2N83QaasqnGBve98ezHurPgsoS+3jQtz8OEcJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(26005)(40460700003)(54906003)(86362001)(6916009)(186003)(356005)(336012)(16526019)(1076003)(36860700001)(81166007)(426003)(47076005)(36756003)(5660300002)(6666004)(7696005)(8936002)(508600001)(70206006)(2906002)(82310400004)(316002)(70586007)(4326008)(2616005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 10:13:02.6458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef0ed46-703e-4a10-e0ab-08d9f06bc03d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 89 +++++++++++++++++++++
 2 files changed, 93 insertions(+)

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
index 164d6a9e9fbb..edcb032bc1f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1609,6 +1609,93 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
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
+		memset(reg_offset,  0, 11);
+		sprintf(reg_offset + strlen(reg_offset),
+				"0x%x ", adev->reset_dump_reg_list[i]);
+		r = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
+		len += strlen(reg_offset);
+	}
+
+	r = copy_to_user(buf + len, "\n", 1);
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
+	ret = copy_from_user(reg_offset, buf, 11);
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
+		ret = copy_from_user(reg_offset, buf + len, 11);
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
@@ -1672,6 +1759,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_test_ib_fops);
 	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
 			    &amdgpu_debugfs_vm_info_fops);
+	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
+			    &amdgpu_reset_dump_register_list);
 
 	adev->debugfs_vbios_blob.data = adev->bios;
 	adev->debugfs_vbios_blob.size = adev->bios_size;
-- 
2.25.1

