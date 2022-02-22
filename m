Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07EDC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 15:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C0710E7D1;
	Tue, 22 Feb 2022 15:35:54 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2066.outbound.protection.outlook.com [40.107.100.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D6E810E628
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 15:35:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbOUaDRRnoZq7V6KKKKVxXp3cFR3nwE9ERK6tz9KZywOWsyvEcBDc3b6SZ7QEndGgaQZKIWWwTvR8qU4fvM0P46ZuOSe9rpRHsHswDcgLkjN5iKdrHZw5knnVBQrBAXvjnVMNtMcrRmolUeH0NBor6qJMhd3Uic7y24VmrFgxs703fYVhfX7+qMz4mz2IeOrFEFKsQ4gqYlaW+6S3b2MrX78WHehS+XoD++byufViB/CY+YJj6GaSDcqw2JOJUG9CZEPVpZQsw4XHTEFvIBtrUslCFHNrjIIl2h7ETr309LTR/hn34YgH5KpkB/M23cQNjn6qoLtXiiWEma8UL7K0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QISitYqQF3AHVBBEmmtB4dHicl9D6nJ3u+9+diq9iG8=;
 b=ZZq6GCzTSoSp3eMErGQo9LAPUXa42AM2DLW4Fd+x2zrUGUIWbFewWAUVwhiP12eB3yeMyLQy88GoW05BqPWTYFI85e4BsvOfWHA7gJjdHkGCvXSJaRYZMDNDeAyjBEokQdakpyLdEe+M/kAsxoSwb5R5X8/JAjnxbRjd1XZq3D/JXlnMW+RluWQhdW65B/3KqgGkbmG4jqSBmYl/7/yrN/q4sp6cjt53p2KlnTH4BPhvpUHWjcM9zhsq+5nOXPGcotqJvYclkXFkjWdoC9IkZFhP6tD/3MdTbeQ49nMDu+L9cOL9DiD714yPS4iZC1lRC22cMujwEOWkD3fYznQD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QISitYqQF3AHVBBEmmtB4dHicl9D6nJ3u+9+diq9iG8=;
 b=WiRBumoBcE084LamNspVVmee7f5JT20mRs8ubv/CSxwTZyhAdo1hTv114hto5cEefaBLfp+E9JvTyACA21JHsWyAKqzHygTq9FFfRAcYQDikq5yhJ3fzzN9pmMIzq1fCwBphGyu+zs4yWneTheK1Yix92FrBxwjxaip3QTz3FN8=
Received: from DM6PR02CA0070.namprd02.prod.outlook.com (2603:10b6:5:177::47)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Tue, 22 Feb
 2022 15:35:51 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::7a) by DM6PR02CA0070.outlook.office365.com
 (2603:10b6:5:177::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.19 via Frontend
 Transport; Tue, 22 Feb 2022 15:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 15:35:51 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 22 Feb 2022 09:35:48 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v12 1/2] drm/amdgpu: add debugfs for reset registers list
Date: Tue, 22 Feb 2022 21:04:32 +0530
Message-ID: <20220222153433.11464-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 084fe3d4-32ce-474a-cf2d-08d9f61901b5
X-MS-TrafficTypeDiagnostic: CH2PR12MB4053:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB40532E9C4B3C1F4FA93B3E65F83B9@CH2PR12MB4053.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/dfR9lzzly6c/xN6tr+zAzhpSGij6So4hdVINoAL6eKyNfDIvE301ypw3U9lGKHz1rwWyCu+Xruliow9iu5jVi95jLtOFaMCSOboCCuatoCcQPrpJ03aBv9ujuX9sLwwjkF8Am4ryhG8Ft+Rf30Qz8yfV+HzELKsz8BDAjaLaw5cZQ513J3xrcJplO/oOCaGHDfscpnH/OGgh9cZjiKFHSY/MgWdShCZnR9gggtf+JBl4FQQq5SE8wi9lj2xvJbVbHkua/2jenWunRp13Rsu6ce6ougazVU4ryHSjUotTfC2rjDJD5uwNc5bTymW5TWswkdhaaeqro+wcBaL7WHo2mhrKsw1VCANAtX1GnROMZh6lB6ysZ7Kc+2kgOmsFe8+H4zFRHYF/EJrNmvSADtkLOaMDB8ViPzCPAGpR6OTIs06tDm30PZapUF6T5sXU80zrRqKhF8Lly56E36QVJYoHU74zk7ppMzWAuy/mQJiOaokVOdSIbz6GvoyriMBFrLho+j+r4bDRkmAL6Vk3WLs7j2JEMoaH6UUBWSw146QvZ0MPOmy0e9bAXIeHc0mfPapay1+Mdq0G6/MnN5D6XxgkL0nh8/hS05X2KIq2tTjkUjfiXx1GN12DwzyIobCcJiD49gmWvvsOfPFiX/m/yBh+mtE1azdVF/zBkwRLT6p6baag6Ocv/v+ifV1p5qBhR3TIlc0dkdHbKt3mLoSz99iQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(47076005)(336012)(426003)(36756003)(40460700003)(5660300002)(8936002)(2906002)(82310400004)(2616005)(7696005)(36860700001)(16526019)(186003)(26005)(70206006)(70586007)(1076003)(356005)(81166007)(6916009)(54906003)(6666004)(86362001)(508600001)(316002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 15:35:51.2005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 084fe3d4-32ce-474a-cf2d-08d9f61901b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 83 +++++++++++++++++++++
 2 files changed, 87 insertions(+)

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
index 164d6a9e9fbb..0cc80aa1b5ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1609,6 +1609,87 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
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
+		sprintf(reg_offset, "0x%x\n", adev->reset_dump_reg_list[i]);
+		up_read(&adev->reset_sem);
+		ret = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
+		if (ret)
+			return -EFAULT;
+
+		len += strlen(reg_offset);
+		ret = down_read_killable(&adev->reset_sem);
+		if (ret)
+			return ret;
+	}
+
+	up_read(&adev->reset_sem);
+	if (ret)
+		return ret;
+
+	*pos += len;
+
+	return len;
+}
+
+static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
+			const char __user *buf, size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	char reg_offset[12];
+	uint32_t *tmp;
+	int ret, i = 0, len = 0;
+
+	do {
+		memset(reg_offset, 0, 12);
+		if (copy_from_user(reg_offset, buf + len,
+					min(11, ((int)size-len)))) {
+			ret = -EFAULT;
+			goto error_free;
+		}
+
+		tmp = krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_KERNEL);
+		if (sscanf(reg_offset, "%X %n", &tmp[i], &ret) != 1)
+			goto error_free;
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
@@ -1672,6 +1753,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_test_ib_fops);
 	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
 			    &amdgpu_debugfs_vm_info_fops);
+	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
+			    &amdgpu_reset_dump_register_list);
 
 	adev->debugfs_vbios_blob.data = adev->bios;
 	adev->debugfs_vbios_blob.size = adev->bios_size;
-- 
2.25.1

