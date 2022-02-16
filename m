Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C418C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 09:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15E4010E636;
	Wed, 16 Feb 2022 09:50:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A72010E62A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 09:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBLRJ0Y3UyEmzevXnsbUteFo2QcfJZ399+4YywBkyXwd4B/yMJOku4K7fjXoXmG14Eu3LLLVE0hpmnrvhEUihTqsP3NJQ922ogZ3HS8WJq/GACXSql18T2RoaYBupqvEhPURHVKinz7Orl7Qdkj2+MpznCR1EaUF8bp3qezcjrOKK6TH1fixZpo+sVtxX/5w3m4osSPA7lU7E1TrDqhTuRStMErnfkHIy6NTKcsm0erbnR14qOiHY7hAQKOwBTC+zaW0AiZL6llzINPfdRlkw6IZ8DowSgJl+lqwEbcvLiqTHwdJC505Mi0UcGol28SOwimTJz/rS3sEq8oaSX+vrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu13Xi13i4pkQASfuTVnpfHQW/TK/WJSDc8Orjpx/EQ=;
 b=FtYWW5ch8XIBv7SNz8MrXE6TmLZPvQ1NREh7uMoNH2MmLJwCUFa7/BBad6wDKHHFlevpU3swlaD5NHIKazRmy2lwWxFdNq30E7g5KtQmyOFDMR2vAkVSddjXZs/TZfL2nkVxsbmgd4suAdkJP40GJCrVX52UkUFpRANoQi4XZKlNIrtaNySqZ3Ph35Px2GiWAEQRF/ecCIA9AluwLqCip8v5xU2kuh5DlPJLASLaPEjJuczE6CpjRN0zuJz8uZlD+IxEEYCtxt3Um/iTPVsYStSDAOzNX8Xn+4vDGZfMZiGqcULLt1gX4ety0YBxdDIUgIBqRi2+jCeKpDCzZK6gfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bu13Xi13i4pkQASfuTVnpfHQW/TK/WJSDc8Orjpx/EQ=;
 b=Z/Jza1IWcOeIcSpVHT5j6gOiffzFKS+GDTU8lc9FXr5iXU4ZEQ4Gv+edQc+N6ZTFRQMdtgAIobTM8kl76lAg6TxemVqfG+zvX4bxSoji4G6roqHEgmWVsl9ejhDO0oBd8RKpzeeHepRwPN1v3HDwEGjBMdjeV1I/m3eupOGwKcc=
Received: from BN6PR11CA0051.namprd11.prod.outlook.com (2603:10b6:404:f7::13)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 09:50:14 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::f3) by BN6PR11CA0051.outlook.office365.com
 (2603:10b6:404:f7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Wed, 16 Feb 2022 09:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 09:50:14 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 16 Feb 2022 03:50:09 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Date: Wed, 16 Feb 2022 15:19:48 +0530
Message-ID: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 466f884b-8c6f-4235-7123-08d9f131bb19
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB576242D7BDE1CC3BEA87D6A5F8359@MN0PR12MB5762.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v8s3jR0ZnDlQF8lB9anL3Krual3mfA4tvFPMZ6rPwt6EbxomExhJoa+riDLCrZ+o9zaghgYDtaj056SZH0PnIUJOdPNUib/30RgqXyzxhqlu9a4RhTniUNSNf2Fp64cuQxZ7Q3SuEoXHPmAM72Mq4pQmIvYyQBt8W/OnPGcMsDhQiISaVySv8ylSobABW2UYvAuvH6SGj2s9cQtcvi00kMSmhlrbccLdt9q6l8ks3usZnDdkLjQNT7p0VmgoVFbpMT/d8g7O8DscMXXHzSuyO31VOff6inKrNSBRtohx3HUdvx1LHlasv/+n4BufrTQsnae8hUzOzNS4pGoz9EpUF4UEqeRunTMKL5gwd5wtCej9FNtrrVKxzuENn31eUHpPb/klpGlB33mL45Zj3Xz/V6c8A00RaaEE42BjuKFTN3WA3lBTUAoENGwC3vKd9Vtvbn7lCaJqbr75tN5NG7R5rXt56vRsNFxRouAVZFK7Hpm2MPk4pQvYW1TpgIvylJA5+wmEY8PW+9H0KmPi6edu5WWFv/lNSLC1Akt5WYmWMap9VBdPjGsK7AOJKEMZmUCGGMwJQGXhk/1WP/K7QPeeLQ7+b8LAUYVpb9M8nLkXuFoyeuh9U+ZCdrE+jaFfRWkHvUQRJWrKgoghT3qvsLXUTo70ytddtbEp7sNQII2z37zGawQ9FkPqY8gKjLB/8Ldi3Zq8FLV4Pl22zD9ZD+o8LQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(83380400001)(7696005)(426003)(336012)(8936002)(6666004)(40460700003)(186003)(26005)(70586007)(47076005)(70206006)(2616005)(36756003)(1076003)(2906002)(5660300002)(8676002)(4326008)(6916009)(508600001)(316002)(36860700001)(54906003)(81166007)(16526019)(356005)(86362001)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 09:50:14.3709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 466f884b-8c6f-4235-7123-08d9f131bb19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762
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
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 +++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b85b67a88a3d..57965316873b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1097,6 +1097,11 @@ struct amdgpu_device {
 
 	struct amdgpu_reset_control     *reset_cntl;
 	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
+
+	/* reset dump register */
+	uint32_t			*reset_dump_reg_list;
+	int                             n_regs;
+	struct mutex			reset_dump_mutex;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 164d6a9e9fbb..faf985c7cb93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1609,6 +1609,98 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
 DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
+static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
+				char __user *buf, size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	char reg_offset[11];
+	int i, r, len = 0;
+
+	if (*pos)
+		return 0;
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
+	static int alloc_count;
+	int ret, i = 0, len = 0;
+
+	do {
+		reg_offset = reg_temp;
+		memset(reg_offset,  0, 11);
+		ret = copy_from_user(reg_offset, buf + len, min(11, ((int)size-len)));
+
+		if (ret)
+			goto failed;
+
+		reg = strsep(&reg_offset, " ");
+
+		if (alloc_count <= i) {
+			adev->reset_dump_reg_list =  krealloc_array(
+							adev->reset_dump_reg_list, 1,
+							sizeof(uint32_t), GFP_KERNEL);
+			alloc_count++;
+		}
+
+		ret = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
+
+		if (ret)
+			goto failed;
+
+		len += strlen(reg) + 1;
+		i++;
+
+	} while (len < size);
+
+	adev->n_regs = i;
+
+	return size;
+
+failed:
+	mutex_lock(&adev->reset_dump_mutex);
+	kfree(adev->reset_dump_reg_list);
+	adev->reset_dump_reg_list = NULL;
+	alloc_count = 0;
+	adev->n_regs = 0;
+	mutex_unlock(&adev->reset_dump_mutex);
+	return -EFAULT;
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
@@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	if (!debugfs_initialized())
 		return 0;
 
+	mutex_init(&adev->reset_dump_mutex);
 	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
 	if (IS_ERR(ent)) {
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

