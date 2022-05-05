Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6984C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 330B310E485;
	Thu,  5 May 2022 20:06:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 719D210E485
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:06:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRmY9w/AZggazPf6QbSTWSUGeCr1KQSs5jQw59foQGrBdRjDa2zBQfGJmD9HgppPQCNArnE4iJgPZEOlLFwPWJAlEG/Id+FIyFQJzPfKTZHxnyid57FHCTqYD1KjN/zSkVF/vADi+YB5kvsBYRD7CwTvxZsQumcuf8ev6dYmurR/swpumQ1OneIY8N01mSS/Myxb/XDm20Ln2xOuGO5v2G/0QTvPtVwgPduWJLculCposvjC9nQvcAMKQs3CAeEOS/3+ouAdLfDjk8p7GMNNMrO4+3EcDfRdqJ7RUCWwaBG0mvSV9HYum+3OqnOE/SdGkZgNUWhbDUqzKHumU4qyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4moIqZ4pTwNR3nJNP3dCG4Jgp8E3HFrEHqJ94JIhcmo=;
 b=e/EkuJX7rXC300OgElF+SUpqwTHTq4cGIqh/tyHUuqzPkdpEtf+NEqAjRrfpS8i6zIoLqr9WYqdE8FrndkzH06eR24D9IHSgWOphjzQ8vlNnj/CCImhJpJDEb3Jf7mow5f7ncSrkEYu9C//0EdHCmcXIo8b40x8AfSniTRRqSYH4RHlcbmbbFq5isFkQ/kq4SaFzkH4i2JMrvtqq+c6r56n2Y+r78Xx8WzROIkxQMqnqB+aEBuxr0lLs8apBy/gTAahiyQLgeiHaHG7qiXLux3yQ99CSDNlu5z/UYEY0wNFFsPm9mdzErLnKj1YuZrLlBsfzxB1d2vhXdP5xoG8aig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4moIqZ4pTwNR3nJNP3dCG4Jgp8E3HFrEHqJ94JIhcmo=;
 b=ZbHR/lbQtjNb6mGQQELxHsC8yR4aSJDbfqijDIjGE2vCoweC8fKBsEPTNv/2do2rFuQK3GSJSJmHVi2YJafA9448AHZGF3ScbrWuxhS5iqiEccj4CnSJkrP7MeKry+UOnCcZgHft3D4YsEedLVxN4HAF3undOLZMjV/8MN13qG4=
Received: from DS7PR03CA0086.namprd03.prod.outlook.com (2603:10b6:5:3bb::31)
 by BN6PR12MB1555.namprd12.prod.outlook.com (2603:10b6:405:5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 20:06:05 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::fc) by DS7PR03CA0086.outlook.office365.com
 (2603:10b6:5:3bb::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 5 May 2022 20:06:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:06:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:06:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: add sysfs to shows psp vbflash status
Date: Thu, 5 May 2022 16:05:38 -0400
Message-ID: <20220505200538.1293584-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200538.1293584-1-alexander.deucher@amd.com>
References: <20220505200538.1293584-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e57acfe1-80d7-4da1-0d3f-08da2ed2afa1
X-MS-TrafficTypeDiagnostic: BN6PR12MB1555:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1555FBD5EBCBB0FDEAC6E15DF7C29@BN6PR12MB1555.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7uuCmIK+/hba6BHpHrlsx5uZs+8Zid/RZ6isxIm6ssMluLqbWWX57rtA05iUaXicuz4WHntPRMBeFxTPqsHky8bT9D7a05tUpk+WHV1yg5mh221GRt9hCC1HbZTqHQUpMUte3kIXR/mOIou/6uieBLaARFSvYb33PsHp9gBG3Xc+AMd7vUzJAKucPmyk2DNyAjTYPvBXxHnN9OSt3cckeDYoM7wq+ljOtQpdE1YprnIhzhKCBbOXYx3cVAlaN0oyruYrklCulReBdPrkXhjB8M2DDdK4Z+2kWY4PTFpXyLlZOl24jn8p3aSwKO1+YjHa9jq7AbvaKscIVZbGqMyRjloNMt6if4wlDfmbMzr/l/WFrmI7JuC5us5594oE8C+ap9hwW5w33GjKgaiP/INwr6YaScXNuwQmSvXfwiNCm32aCDaYlxpHsDzrKSQElj6r9SJ4EtW9tqMc5Ghkhzj/534P0Yx4tU7b3GktLK1wJ16nZlThJeoCs8VzqQ0+zaDljrRYE5kLflZsD162aJdSspTFH2nN0punK1yX2nAcPqnE3SAr8cu8X8sosFjAmatqfegw6UAJAvXtbqZRwATT10GJ+rSMp2BZsHvxsJz5TGbft9oBn1C0xTiFb3ux1klUu3qqhdVV33XMbgJo9eRS4jrVLxGWpiJJD2fDQ26jGKhJgbXoUphpM0CbZ+MvK2VSaKP239QIDBmQSfwdPdTAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(70586007)(426003)(336012)(47076005)(40460700003)(8676002)(70206006)(81166007)(4326008)(6916009)(54906003)(2616005)(36860700001)(16526019)(1076003)(186003)(316002)(82310400005)(2906002)(86362001)(26005)(36756003)(6666004)(356005)(7696005)(5660300002)(8936002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:06:04.9986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e57acfe1-80d7-4da1-0d3f-08da2ed2afa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1555
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add new sysfs interface to shows the status of psp vbflash status.

V2: rename the sysfs interface, and set more return value.
    (0: not start; 1: in progress; MBX115 value when vbflash finish)
V3: warning fixes

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 15 ++++++++++++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7d0a37a94ea6..1f3f93e9eeb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3453,6 +3453,8 @@ static ssize_t amdgpu_psp_vbflash_write(struct file *filp, struct kobject *kobj,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
+	adev->psp.vbflash_done = false;
+
 	/* Safeguard against memory drain */
 	if (adev->psp.vbflash_image_size > AMD_VBIOS_FILE_MAX_SIZE_B) {
 		dev_err(adev->dev, "File size cannot exceed %u", AMD_VBIOS_FILE_MAX_SIZE_B);
@@ -3524,6 +3526,23 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
 	return 0;
 }
 
+static ssize_t amdgpu_psp_vbflash_status(struct device *dev,
+				         struct device_attribute *attr,
+				         char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	uint32_t vbflash_status;
+
+	vbflash_status = psp_vbflash_status(&adev->psp);
+	if (!adev->psp.vbflash_done)
+		vbflash_status = 0;
+	else if (adev->psp.vbflash_done && !(vbflash_status & 0x80000000))
+		vbflash_status = 1;
+
+	return sysfs_emit(buf, "0x%x\n", vbflash_status);
+}
+
 static const struct bin_attribute psp_vbflash_bin_attr = {
 	.attr = {.name = "psp_vbflash", .mode = 0664},
 	.size = 0,
@@ -3531,6 +3550,8 @@ static const struct bin_attribute psp_vbflash_bin_attr = {
 	.read = amdgpu_psp_vbflash_read,
 };
 
+static DEVICE_ATTR(psp_vbflash_status, 0444, amdgpu_psp_vbflash_status, NULL);
+
 int amdgpu_psp_sysfs_init(struct amdgpu_device *adev)
 {
 	int ret = 0;
@@ -3549,6 +3570,9 @@ int amdgpu_psp_sysfs_init(struct amdgpu_device *adev)
 		ret = sysfs_create_bin_file(&adev->dev->kobj, &psp_vbflash_bin_attr);
 		if (ret)
 			dev_err(adev->dev, "Failed to create device file psp_vbflash");
+		ret = device_create_file(adev->dev, &dev_attr_psp_vbflash_status);
+		if (ret)
+			dev_err(adev->dev, "Failed to create device file psp_vbflash_status");
 		return ret;
 	default:
 		return 0;
@@ -3586,6 +3610,7 @@ static int psp_sysfs_init(struct amdgpu_device *adev)
 void amdgpu_psp_sysfs_fini(struct amdgpu_device *adev)
 {
 	sysfs_remove_bin_file(&adev->dev->kobj, &psp_vbflash_bin_attr);
+	device_remove_file(adev->dev, &dev_attr_psp_vbflash_status);
 }
 
 static void psp_sysfs_fini(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index db7b7dbb9c93..e431f4994931 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -130,6 +130,7 @@ struct psp_funcs
 	int (*load_usbc_pd_fw)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
 	int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver);
 	int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
+	int (*vbflash_stat)(struct psp_context *psp);
 };
 
 #define AMDGPU_XGMI_MAX_CONNECTED_NODES		64
@@ -375,6 +376,7 @@ struct psp_context
 
 	char *vbflash_tmp_buf;
 	size_t vbflash_image_size;
+	bool vbflash_done;
 };
 
 struct amdgpu_psp_funcs {
@@ -425,6 +427,10 @@ struct amdgpu_psp_funcs {
 	((psp)->funcs->update_spirom ? \
 	(psp)->funcs->update_spirom((psp), fw_pri_mc_addr) : -EINVAL)
 
+#define psp_vbflash_status(psp) \
+	((psp)->funcs->vbflash_stat ? \
+	(psp)->funcs->vbflash_stat((psp)) : -EINVAL)
+
 extern const struct amd_ip_funcs psp_ip_funcs;
 
 extern const struct amdgpu_ip_block_version psp_v3_1_ip_block;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 894ac0c64bf6..c14abd9dd41e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -487,6 +487,9 @@ static int psp_v13_0_exec_spi_cmd(struct psp_context *psp, int cmd)
 	/* Ring the doorbell */
 	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_73, 1);
 
+	if (cmd == C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
+		return 0;
+
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
 				MBOX_READY_FLAG, MBOX_READY_MASK, false);
 	if (ret) {
@@ -529,6 +532,8 @@ int psp_v13_0_update_spirom(struct psp_context *psp, uint64_t fw_pri_mc_addr)
 	if (ret)
 		return ret;
 
+	psp->vbflash_done = true;
+
 	ret = psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE);
 	if (ret)
 		return ret;
@@ -536,6 +541,13 @@ int psp_v13_0_update_spirom(struct psp_context *psp, uint64_t fw_pri_mc_addr)
 	return 0;
 }
 
+int psp_v13_0_vbflash_status(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	return RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_115);
+}
+
 static const struct psp_funcs psp_v13_0_funcs = {
 	.init_microcode = psp_v13_0_init_microcode,
 	.bootloader_load_kdb = psp_v13_0_bootloader_load_kdb,
@@ -553,7 +565,8 @@ static const struct psp_funcs psp_v13_0_funcs = {
 	.ring_set_wptr = psp_v13_0_ring_set_wptr,
 	.load_usbc_pd_fw = psp_v13_0_load_usbc_pd_fw,
 	.read_usbc_pd_fw = psp_v13_0_read_usbc_pd_fw,
-	.update_spirom = psp_v13_0_update_spirom
+	.update_spirom = psp_v13_0_update_spirom,
+	.vbflash_stat = psp_v13_0_vbflash_status
 };
 
 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
-- 
2.35.1

