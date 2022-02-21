Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8476CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 13:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E53C08920D;
	Mon, 21 Feb 2022 13:34:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B78010E317
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 13:34:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOVsbmL1JXGKm7H16bJ4Qv86siPDe2lzJicusdmL0QTk/+faDfOfzemsUk44fW2er36BWUAUzfzpIyopKgdMpb2kX3anfjtrHApLEWVRTwoxdomioZPqDNwZdnFIdJlI3lb590nOvXTttJfepLZVD5pzvcrc7b8VaTn8C9aGLUNGEC3UeSs8bugUrj6Z+rGScwX6IPCvc3iNOuQEYC/56NMVZjEpDZrzsLQ2xG18JgDaPtE9zVjPMX2635RwOHUsWLAtfWD8+Dr8cxTssWL9iT/aCv/9oEHa3iNZ52XideLmMWjeHgvqefwiK3CKr5ylKrChRDQhiUNPnAVVu85hOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmnpdFaUoYs/eIxIjV5ay35R9cw9EqjMnrqoc2uDCfA=;
 b=ZgzUnvS6DxZRLa1i1gxQuAO2zqdiF50g2as/UiJpUG4frJafBaW1lae0kJdMd5OQwVZZhKq1S+R646rlX0hjGtGS/DfX5dIUFtvbpKIorY6d31nhFeoiODp6we5Ad3xz9hVuseeCNCpuuaBrQyjO6/G/Zkf8w+nrQHoRJ9izCkgIZTLUt6j2MKdtZw+23gOvmpzzgRHzPUf7hd2UPkgKk0PvL8Pbfqgzx3MRNaXPJbenjq/ZzXbZAqrrkrmF5DLgQqoomaq+1jU3lTFkRqwgND2YVng/80xpV+IIkxx1kLNquBXVkgD7VGsN1bEr1bSJGsIt71pIrN8eQGT2UlJIlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmnpdFaUoYs/eIxIjV5ay35R9cw9EqjMnrqoc2uDCfA=;
 b=lf34vtvlef+CrWox7/cOoHrorvi1NlNUNZeU15YQb50m2N+7dn6JXQ6jFee5SaIGC0Du1RLoVIFIKuCDCIbtkTMLwlw2S4KT+TvRFpyAS1Ni1eMSvpTNEyF6ntzJ8J9QFYpw1bnLxCvi5y1FlTfdu4XJKkw7a+K3muYrfr4hc7w=
Received: from DM6PR06CA0041.namprd06.prod.outlook.com (2603:10b6:5:54::18) by
 CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.15; Mon, 21 Feb 2022 13:34:40 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::b9) by DM6PR06CA0041.outlook.office365.com
 (2603:10b6:5:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Mon, 21 Feb 2022 13:34:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 13:34:39 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Feb 2022 07:34:37 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v9 1/2] drm/amdgpu: add debugfs for reset registers list
Date: Mon, 21 Feb 2022 19:04:10 +0530
Message-ID: <20220221133411.12544-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33c97046-884e-4818-569f-08d9f53ee947
X-MS-TrafficTypeDiagnostic: CH2PR12MB4246:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB42462735C5497A128E2443B4F83A9@CH2PR12MB4246.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GQN5ln/UlZ7GjOfbaigiptZAYjy65FUFoQKIIRhU2c2Z4RzaCfUUkWJmbGE5m3j0238mTmR2kK+2qHFCChlxPmW07RQJMoxGOiD5Tz2ap2RxKmRU/Zly4JablhxfqfyOJm/rF4Y0HqjJry3sJnMYoyb5wPQDLoGd75ii+/lUHu+DoqNUXFRhsyHYtDh0XCtjJAVHkcWdk5Mj/oi7mflE2UfD7N5EDA79PX+L3A2iLzdYpXVVmwonk+z+gNa/yr+3F4IYGku5ajaF5+ZF+EYQ4CE/gzwCiELnBZxA8uFC1X+PVORbDirXMEf7G9897ojSEJiF9B+cmVa0cjmQhIEhYecNPXVbFVvFI2RI0Bd+fQ7DvhdqAQn/4rGtJ32zfbFnfBX68adklIl/v1STxWad65M6VX/jXJyGgvsQ6h9NMJGvuhSmMMR2w1gAG8TL770KpVSn29jis1r4ZztqTBPsUZwByg8/6zlIdLIAj/TlXl+V+7asA/7JDvRX/exLHNOyK0Mk9lI6wNA7w90rNrhGrzmOa1HH4dhwo+t5gu0HDhdMaDR+dGvSdkn808Lg8kIl/RFmfk2VXow33G5YPPwi+qPZBalAcq6pfhdHtee3nmEQKbizGZx8jsdBEOMBTAmxRZIRrQYAmJAK1sKGb11zp77mLJwlkIwzt+I6VwWqSyYpd8YFVsboMNeljoW843HkbIZXEgXAaxZ27p3AS30pig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(16526019)(2616005)(1076003)(186003)(26005)(336012)(426003)(36756003)(2906002)(8936002)(6666004)(7696005)(47076005)(508600001)(82310400004)(36860700001)(86362001)(6916009)(316002)(70206006)(5660300002)(4326008)(70586007)(54906003)(356005)(8676002)(40460700003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 13:34:39.8461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c97046-884e-4818-569f-08d9f53ee947
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 96 +++++++++++++++++++++
 2 files changed, 100 insertions(+)

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
index 164d6a9e9fbb..69c0a28deeac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1609,6 +1609,100 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
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
+	for (i = 0; i < adev->num_regs; i++) {
+		down_read(&adev->reset_sem);
+		sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
+		up_read(&adev->reset_sem);
+		ret = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
+
+		if (ret)
+			goto error;
+
+		len += strlen(reg_offset);
+	}
+
+	up_read(&adev->reset_sem);
+	ret = copy_to_user(buf + len, "\n", 1);
+
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
+
+		if (ret)
+			goto error_free;
+
+		reg = strsep(&reg_offset, " ");
+		tmp = krealloc_array(tmp, 1, sizeof(uint32_t), GFP_KERNEL);
+		ret = kstrtouint(reg, 16, &tmp[i]);
+
+		if (ret)
+			goto error_free;
+
+		len += strlen(reg) + 1;
+		i++;
+
+	} while (len < size);
+
+	ret = down_write_killable(&adev->reset_sem);
+
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
@@ -1672,6 +1766,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_test_ib_fops);
 	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
 			    &amdgpu_debugfs_vm_info_fops);
+	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
+			    &amdgpu_reset_dump_register_list);
 
 	adev->debugfs_vbios_blob.data = adev->bios;
 	adev->debugfs_vbios_blob.size = adev->bios_size;
-- 
2.25.1

