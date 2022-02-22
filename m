Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1245C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 14:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0915410E7EC;
	Tue, 22 Feb 2022 14:38:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA21310E84E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 14:38:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jahEYLWxTa8bgXWJ6wE/3iQA1JR9haJMPD+ajZcWA/bzUGI/gzsmTjQQxnlpwWIc2cP6hMGJ4R32ZRzMwmoRmpPVYGkipKR9nXSuoipd+3UQTkRGABSGXzwWz65o9AkauUUT6hhqoAC4kuHuZsPBD8YuL7kMtTkWkSknuCnHBhqpOqXyWdsjcduQWKCglto7UkIC1aA/CKqJ+ESbqP++w+8vXy//V9Lt4+kOJlPuBk6E0XTFS1P+kgeI6FG6yp+YCgl3Sez2A87ub96MFWyJr8eCiUnX75GXOQkWuyfoivwAXf/Ld8lwsTdFXQMlTw+V7rvBGrypEiEMlLNy2yO4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9E2pLG/sxMk/qqdMFLooyhQwww86wShvORZcHPvlFk=;
 b=KQnV1FVIfGPjuZUWnRAx+ZW8MPicAaIlKFzoetWxlpHji46k0ALbVqSUX28VgxGR6dDVqBOiP+23c2yMUQFVjp+Xi1xZ7BZO2g0qJ4A1FnTttBGXW+shRMV7zPUULQL8O3Q/qWcW0rq4pFE2SmRZskrnAWBNZB9h6/mr8SSAQTMSR1MDPVRrrYa3iwKmbCcBKefgKptsWPUX68Wg/DP/5vbIVd5lC1a5cps/phfFdRkdoQ254nByVef4xgCZCuI5wnWJaeLdapkejTQvZQFbBULWXLO+y6plGnyhwZXYwy5wjuCb9TzvpFZ3mfrNJxIZnNA0ibsYd7sZ+FMgWfMhmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9E2pLG/sxMk/qqdMFLooyhQwww86wShvORZcHPvlFk=;
 b=X9UA74HmDBF6aWzYVjnIX8Y7aPyuVo0CiaTepqGXgR0iPn7G7DagVqeiXlJroIjnz0W84z+WAW/ojlKf/OcTrVDsvVVbjSi6ZCy7lEqscWanaB90J1+E8RJiKfq1a9d+a9ObbrnktrRUXeiTccmGzugl6esWILVYO7o4vHAj6RI=
Received: from MWHPR17CA0052.namprd17.prod.outlook.com (2603:10b6:300:93::14)
 by BY5PR12MB3953.namprd12.prod.outlook.com (2603:10b6:a03:194::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 14:38:06 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93::4) by MWHPR17CA0052.outlook.office365.com
 (2603:10b6:300:93::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Tue, 22 Feb 2022 14:38:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 14:38:06 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 22 Feb 2022 08:38:02 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v11 1/2] drm/amdgpu: add debugfs for reset registers list
Date: Tue, 22 Feb 2022 20:07:41 +0530
Message-ID: <20220222143742.2575-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 009c52e5-0052-47df-9600-08d9f610f06c
X-MS-TrafficTypeDiagnostic: BY5PR12MB3953:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB395389186745EB083766EE1AF83B9@BY5PR12MB3953.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XFfFg5qz1VarPJnBqMealmMuRkcg7XSxC/UVN6GqJvL/IMgnTj9KJQEfUh+rBAwuWS73j7sYIL8sEnHRzZ9ZN7t8Bn8NbU7roD2a/wiolGEkf51SIhEazghHok4b5EAY3DeZEgTpKkj/a64fBL6Cdd7QhNlUl+76sgi2d9TpEMoUoFGvK3Ax8U+pg15a6rmxDkEdhGRuFnXeWHy0UGJb6MxUo+NMJEIJbT7UrLgTIRpCz4Siw65Cq071q7lkNtYT1UYxzuieESZAPa3cRnk/u+OCmZBJsZRNBhvnfn4fNMCUXO/AV+CbHf0gEWyLnY7/1iooez5COSIf/OqJp2f5iMgJlFP02PwxAK2qmQ8ryKLNNYQXRnHFKq76uTgUdyaugw0PJU8DW0wfk9MdNwTIuG96+E2qCoMlZJ5olhFnFJ5rgZF/Crg+NmFb/uH8GBkkUKEM+0eGD0VaFbZzSgFx8fqFg4fxrKpmXV/47JagICPgOy5s26coEViuU9ElPLIgDd336EsqDSbFrJnpeFPB6pS34YA2n5ya81jSbHXM1HvM5CLCPVkGegty5EjQcA5Rj3SI30Z5mqqsuocndi9Ye/pn+gs/+lieVTAUgF2Wp4tbPmPHZBasKpXKMwfAmEPnBB1Lk6U/jCxf54sRsmNi+Q9ya4R+TlE85nx7SRZw0sE3hGMCyQY9pwyAsSDeENNn3F3hDw1RjdDBBgUgMvc3TA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(6666004)(2616005)(40460700003)(7696005)(508600001)(47076005)(36860700001)(2906002)(1076003)(186003)(16526019)(5660300002)(4326008)(54906003)(6916009)(8936002)(26005)(8676002)(316002)(356005)(82310400004)(86362001)(336012)(426003)(81166007)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 14:38:06.1162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 009c52e5-0052-47df-9600-08d9f610f06c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3953
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 81 +++++++++++++++++++++
 2 files changed, 85 insertions(+)

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
index 164d6a9e9fbb..df6d9fb69657 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1609,6 +1609,85 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
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
+			return ret;
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
+		ret = copy_from_user(reg_offset, buf + len, min(11, ((int)size-len)));
+		if (ret)
+			goto error_free;
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
@@ -1672,6 +1751,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_test_ib_fops);
 	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
 			    &amdgpu_debugfs_vm_info_fops);
+	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
+			    &amdgpu_reset_dump_register_list);
 
 	adev->debugfs_vbios_blob.data = adev->bios;
 	adev->debugfs_vbios_blob.size = adev->bios_size;
-- 
2.25.1

