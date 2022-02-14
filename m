Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88FCC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 09:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42A6010E2A7;
	Mon, 14 Feb 2022 09:16:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9537610E2A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 09:16:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bf2kSN+vXhst3LJrvNbxHAHFtFa8iqUiRLFgj6gf2mBsGFAakqL45/cu+1zYTrkpd56tMT5Mnlfx4BfJ92pNVbMu6kt9Wro/VM6plwVabZj956cmj4ZPCtWmhpYvBZ9aMsPgMGmm0jPiSpIWtFEwKYQxdksXRZLLIOYStj5XxCcXwEDAFJKFV6o50CYlB9I8dY8jEHoF2NHIywIOKoKB85fSabuYyROiJPHyWb8+eP5bVJi3vTZXY2JXC6Hu7Gs/jfEs+4x423ZqQtxuCE5Aq8Qma5eWwRETjHZ6SmCg0hZOuPeKOUWznuoODQBTjabmYl3DcHyrVo4uvlDp7ydOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEIreA1diGnDsGH0P5jROqjuRiEUdnCEJVx/EcUS/so=;
 b=GSPNmAl7Y94N3szfrF6GJwSLh4MtaGelP3L82Dts3bSztske6pSgaZ1GG/ouvwn9xEeAUDtQkoEHzdjf/5WqBgZNSdiOrvwbpnoalB8theIc3a/dWT0xIKTj9VZaRBYq92RZipDrXXpACtgserngNhKJGBhfNB0A6yy2IGW7fAaE8MSKEaYMdeJQbGUYFTqN5XTbt7yWnwv7NvzKoZY1Er5BZ/v86WNXu7BWlk5flqF0rqX1Wdkdu4hHnW/UGAbpr5XOSu0z14qk+a91vCcFsqgU1Q9qC5RUvr9HpPNdc1ArKstanlWQUPERE3dvxWqv/2yjhryN6OMah4UwpABszw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEIreA1diGnDsGH0P5jROqjuRiEUdnCEJVx/EcUS/so=;
 b=GzWymrJaasA9Ddnrd88zCmm5jp/2gG2ThfiVwmKTU8C9famfM2BQlpRWZblEx+qnbof1abfBpD/DfqBHseMSpCLWwNzerVMPqXv/QW9jFyVy6VVbu+jO7SOWoZ1+5ts5lglWgrzK+Ln0+FcUrESQ+FU9DO5g2H0unsnVo81cPnA=
Received: from DM6PR05CA0064.namprd05.prod.outlook.com (2603:10b6:5:335::33)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 09:16:51 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::40) by DM6PR05CA0064.outlook.office365.com
 (2603:10b6:5:335::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Mon, 14 Feb 2022 09:16:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 09:16:51 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Feb 2022 03:16:48 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/2] drm/amdgpu: add debugfs for reset registers list
Date: Mon, 14 Feb 2022 14:46:18 +0530
Message-ID: <20220214091619.2820-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e75432c8-16a9-4597-0a27-08d9ef9abc32
X-MS-TrafficTypeDiagnostic: CH2PR12MB4200:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4200B578BCB5E06788B6D880F8339@CH2PR12MB4200.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1i0LafR2OBm/U8vx7vdQk/l6BBbd1SUENXgCB9ugoQjJFGHp5gLcdbGcOjI/TrdYa2LDK8fwYx/e7K916+3NxacSWIANNG7/ov3aKIfmJwq3aQQUruZkwddIsebTnG3M/YlVLdCOhhsE+YZMhR8nrFCEFljGFXff3CtfNC0OF75c5bKnuv/P2DdsZKqpkB0b9NRTd2uNP/Jv2mZqYJpGbAbGs2AVRxowtHh17aQctaiP1PbAo9frx7yLTCcWRYU8FqTxTUwdkIVHdExLuE4b40hRTVNk+3KgUfyQ0eivgqzcboQYuqSoRehA3aIZGFjniMOMxRs2yC9p7lyhVtqSx33IGENL4HOo5236IqPgUj8i/O1eXY72K+9EAP/hUOSxm1vcgPsHhtnh7txLElItE4uSLYgZEYfVkVK0+tp0BRMvMFZ2NcJz6L9tzcpUJLibz3fByVH3d8qkgM6uH2gQlnYgtr18AtOz0OpraeXJ9vOzzAF1XKaDB5L3sGH/dwWR3FUCuxydkczyFZH83nIOh2jZOdhoRXfWzAL1z+qLV/s2oLPLNtxzw4jxx0qw3OV+rwTDIbmWaGrUDwde69T9z04PoSJNFCGzPW4CgUkRLGl+72MJOcJwmGsqdaE3dYlJ8F45GKktgc58yZhG3p/3iJoQV2JqZPm0HY48nN2SBUu1Lrj+3JMN3AfObq5QQ28UsWOeGPzxrX1amdex9yvTKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(186003)(1076003)(2616005)(16526019)(26005)(336012)(426003)(82310400004)(47076005)(36860700001)(5660300002)(8936002)(2906002)(36756003)(40460700003)(508600001)(7696005)(6666004)(4326008)(8676002)(70206006)(70586007)(86362001)(54906003)(316002)(6916009)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 09:16:51.0096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e75432c8-16a9-4597-0a27-08d9ef9abc32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200
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
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 80 +++++++++++++++++++++
 2 files changed, 84 insertions(+)

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
index 164d6a9e9fbb..6d49bed5b761 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1609,6 +1609,84 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
 DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
+static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
+				char __user *buf, size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	char *reg_offset;
+	int i, r, len;
+
+	if (adev->n_regs == 0)
+		return 0;
+
+	reg_offset = kmalloc((adev->n_regs * 11) + 1, GFP_KERNEL);
+	memset(reg_offset,  0, (adev->n_regs * 11) + 1);
+
+	for (i = 0; i < adev->n_regs; i++)
+		sprintf(reg_offset + strlen(reg_offset), "0x%x ", adev->reset_dump_reg_list[i]);
+
+	sprintf(reg_offset + strlen(reg_offset), "\n");
+	len = strlen(reg_offset);
+
+	if (*pos >= len)
+		return 0;
+
+	r = copy_to_user(buf, reg_offset, len);
+	*pos += len - r;
+	kfree(reg_offset);
+
+	return len - r;
+}
+
+static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
+			const char __user *buf, size_t size, loff_t *pos)
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
+	if (adev->n_regs > 0) {
+		adev->n_regs = 0;
+		kfree(adev->reset_dump_reg_list);
+		adev->reset_dump_reg_list = NULL;
+	}
+
+	while ((reg = strsep(&reg_offset, " ")) != NULL) {
+		adev->reset_dump_reg_list =  krealloc_array(
+						adev->reset_dump_reg_list, 1,
+						sizeof(uint32_t), GFP_KERNEL);
+		ret  = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
+
+		if (ret) {
+			kfree(adev->reset_dump_reg_list);
+			kfree(reg_offset);
+			adev->reset_dump_reg_list = NULL;
+			return -EINVAL;
+		}
+
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
@@ -1672,6 +1750,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_test_ib_fops);
 	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
 			    &amdgpu_debugfs_vm_info_fops);
+	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
+			    &amdgpu_reset_dump_register_list);
 
 	adev->debugfs_vbios_blob.data = adev->bios;
 	adev->debugfs_vbios_blob.size = adev->bios_size;
-- 
2.25.1

