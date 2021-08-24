Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C78CC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 13:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093986113B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 13:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 093986113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A236B89ACD;
	Tue, 24 Aug 2021 13:36:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2088.outbound.protection.outlook.com [40.107.101.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C203789ACD
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 13:36:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/khRFn/nx1xDjOol4rzlLXGbK7fnNMDv1rF06kimNzjLF2qG8CEhRp8hJvrnQfUXKSkkujwUYPozqdcyw0dVVzxcv8Kw9MdrwSSy1I0u3fs7YqQrQTIrJW6g0wYdeZaq0PCgvjda7OE1+q+L6McdPx2hg42mE13LvE+JkV0X4Kv7Gwt4XduW6mvFyJHYLl0polMKu1QnNnkoIo69nfRMrjYijweFKecS50qKN0nwfgIqDpvP/Q24hrR2rfyEUC0uMRxEJBimuK4uh10krZDy0CcuySr34RZJGI+BUwtpayKF/4YwkSlszAzZ2eGmgDGg9HoPUIneGfuRZHWjjpyvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99TE0a+OcDBkp/w6KZS5DIe6gxp1QBBGCfRgPwAqi04=;
 b=QcbjaufBEfadq2jupxH1w+JGvHqfMoFiSZBaUVeYFe4SE4gno+AJomezHj+/mE/vWI0HdWGE5ypczO9K0ht2uhtS83xeaUHmrVu5iqT7QcW7kfiIJNI4btZ91Um/FAdsP8Rbb/IAZF6jFnih5J0saGRvw2wuVQQUClf24L9w2vm5eJuvVVaeSqV72mlkFpmg/SrkmEsrp+CXXrA0Nqfu+f2SDxK4m9YNwnt6rtiGj63FVaGL5HUmaG8qUCAJyrncZdutzSiqivTeAbFwXshHy98TsaFqRlNID+f0eWEQ/L2iGkAK+iS0QbxQnvE3Oj09bpyF5aOYmR5XczR7sohT8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99TE0a+OcDBkp/w6KZS5DIe6gxp1QBBGCfRgPwAqi04=;
 b=Mt3AGj+rL6KpTlw77+/48ifVGaZGtey2vAhklLwsbyTe7OcseuSZjaPy9mbUdriduAeizt82Mpz75rUYaQlNP74BF6ygaDZqMRcFVIm/VmqExjqASnDFelpFtXmE4MLkAH11Qymu0+d21DN5xcqyS2qGWTnpZdrkj8YW+MbnCpo=
Received: from MW4PR04CA0040.namprd04.prod.outlook.com (2603:10b6:303:6a::15)
 by CH2PR12MB3910.namprd12.prod.outlook.com (2603:10b6:610:28::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 13:36:52 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::6d) by MW4PR04CA0040.outlook.office365.com
 (2603:10b6:303:6a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 24 Aug 2021 13:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 13:36:51 +0000
Received: from ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 08:36:49 -0500
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers (v2)
Date: Tue, 24 Aug 2021 09:36:42 -0400
Message-ID: <20210824133642.109072-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d52eeaf-0103-4089-6af6-08d967043ad9
X-MS-TrafficTypeDiagnostic: CH2PR12MB3910:
X-Microsoft-Antispam-PRVS: <CH2PR12MB391087DD82FE9696063AC4E6F7C59@CH2PR12MB3910.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R42KX+uvyguJ4M8xQqAE0tvvzOI1W+yri63kJA2RWiYak90vFeZXEOTPyxF8nljBusXgjC0EiHVidUrWcaZ+UhV65T/UegzGGwvdth0jsJY2LW34mT+ZCFm2m+lMZj3jUJBTM9aqG+Fobb4j/iV8BRPyoK7IJz7hW7dw4szqQzDObVhSSuUOa1zTtNd/1+OMSu7Ni33mrN7gp02Sq4RI2Ta/Yvssf06ffD4MGPI53dtWuPV0MXWXCwP+sN3NlcFX7z7lTkshN+BNSLyh0UhEovZpA+gQmyjKHGNkyQj8K3Xeh4RSsmJlxDziSgUIF80hoERdrjGqfmQ59FXo4mancXXM1I7FH8hRGmG4nfT4u+DI6iaP3578QlER4oH7RXcmbMZOjCeKJ3SajBktk1f2nlL5jXJzdahpLPY2c9Pg5VIW9UTM6oGVSqqUhWYu07AuDBs23gvNN5MiVfgGTWvUy4a81upFSKTEHmoqrESzpJmxCVggWSTeLmxQZSZrR4wwLYdXB8ytmQ+/0U0nwDdDub+FHCDKCXiFehd2KISB5TY6ynSDwWzeFei1cd0ym/60msvXyYUMr+zHSCQAwhw+RJH26k3SRfsQXNu/AHsILl07/FutCki1vBpAkN9D9cQ4LihuJZ92hOVJY7KIpSn0W3S+mQ2hi02VY8frzadMMd+KNEUP5J2GHeNejQZwHFuJlkB9OIn3RFAUQbtS4oVAmkk9TYE4wp5DK64ZUCC1qXRffEnch8Ex6KfHl/fnRBUIKy7ML2RCC/rSv7CG15AP+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966006)(36840700001)(2616005)(8676002)(36860700001)(36756003)(8936002)(5660300002)(83380400001)(70206006)(2906002)(70586007)(426003)(336012)(47076005)(16526019)(186003)(316002)(82740400003)(6916009)(26005)(34020700004)(82310400003)(4326008)(478600001)(7696005)(6666004)(356005)(81166007)(1076003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 13:36:51.2904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d52eeaf-0103-4089-6af6-08d967043ad9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3910
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This new debugfs interface uses an IOCTL interface in order to pass
along state information like SRBM and GRBM bank switching.  This
new interface also allows a full 32-bit MMIO address range which
the previous didn't.  With this new design we have room to grow
the flexibility of the file as need be.

(v2): Move read/write to .read/.write, fix style, add comment
      for IOCTL data structure

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 162 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  32 ++++
 2 files changed, 194 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 277128846dd1..8e8f5743c8f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -279,6 +279,156 @@ static ssize_t amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
 	return amdgpu_debugfs_process_reg_op(false, f, (char __user *)buf, size, pos);
 }
 
+static int amdgpu_debugfs_regs2_open(struct inode *inode, struct file *file)
+{
+	struct amdgpu_debugfs_regs2_data *rd;
+
+	rd = kzalloc(sizeof *rd, GFP_KERNEL);
+	if (!rd)
+		return -ENOMEM;
+	rd->adev = file_inode(file)->i_private;
+	file->private_data = rd;
+
+	return 0;
+}
+
+static int amdgpu_debugfs_regs2_release(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+	return 0;
+}
+
+static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, size_t size, int write_en)
+{
+	struct amdgpu_debugfs_regs2_data *rd = f->private_data;
+	struct amdgpu_device *adev = rd->adev;
+	ssize_t result = 0;
+	int r;
+	uint32_t value;
+
+	if (size & 0x3 || rd->state.offset & 0x3)
+		return -EINVAL;
+
+	if (rd->state.id.use_grbm) {
+		if (rd->state.id.grbm.se == 0x3FF)
+			rd->state.id.grbm.se = 0xFFFFFFFF;
+		if (rd->state.id.grbm.sh == 0x3FF)
+			rd->state.id.grbm.sh = 0xFFFFFFFF;
+		if (rd->state.id.grbm.instance == 0x3FF)
+			rd->state.id.grbm.instance = 0xFFFFFFFF;
+	}
+
+	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		return r;
+	}
+
+	r = amdgpu_virt_enable_access_debugfs(adev);
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		return r;
+	}
+
+	if (rd->state.id.use_grbm) {
+		if ((rd->state.id.grbm.sh != 0xFFFFFFFF && rd->state.id.grbm.sh >= adev->gfx.config.max_sh_per_se) ||
+		    (rd->state.id.grbm.se != 0xFFFFFFFF && rd->state.id.grbm.se >= adev->gfx.config.max_shader_engines)) {
+			pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+			pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+			amdgpu_virt_disable_access_debugfs(adev);
+			return -EINVAL;
+		}
+		mutex_lock(&adev->grbm_idx_mutex);
+		amdgpu_gfx_select_se_sh(adev, rd->state.id.grbm.se,
+								rd->state.id.grbm.sh,
+								rd->state.id.grbm.instance);
+	}
+
+	if (rd->state.id.use_srbm) {
+		mutex_lock(&adev->srbm_mutex);
+		amdgpu_gfx_select_me_pipe_q(adev, rd->state.id.srbm.me, rd->state.id.srbm.pipe,
+									rd->state.id.srbm.queue, rd->state.id.srbm.vmid);
+	}
+
+	if (rd->state.id.pg_lock)
+		mutex_lock(&adev->pm.mutex);
+
+	while (size) {
+		if (!write_en) {
+			value = RREG32(rd->state.offset >> 2);
+			r = put_user(value, (uint32_t *)buf);
+		} else {
+			r = get_user(value, (uint32_t *)buf);
+			if (!r)
+				amdgpu_mm_wreg_mmio_rlc(adev, rd->state.offset >> 2, value);
+		}
+		if (r) {
+			result = r;
+			goto end;
+		}
+		rd->state.offset += 4;
+		size -= 4;
+		result += 4;
+		buf += 4;
+	}
+end:
+	if (rd->state.id.use_grbm) {
+		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+		mutex_unlock(&adev->grbm_idx_mutex);
+	}
+
+	if (rd->state.id.use_srbm) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	}
+
+	if (rd->state.id.pg_lock)
+		mutex_unlock(&adev->pm.mutex);
+
+	// in umr (the likely user of this) flags are set per file operation
+	// which means they're never "unset" explicitly.  To avoid breaking
+	// this convention we unset the flags after each operation
+	// flags are for a single call (need to be set for every read/write)
+	rd->state.id.use_grbm = 0;
+	rd->state.id.use_srbm = 0;
+	rd->state.id.pg_lock  = 0;
+
+	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+
+	amdgpu_virt_disable_access_debugfs(adev);
+	return result;
+}
+
+static long amdgpu_debugfs_regs2_ioctl(struct file *f, unsigned int cmd, unsigned long data)
+{
+	struct amdgpu_debugfs_regs2_data *rd = f->private_data;
+
+	switch (cmd) {
+	case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
+		if (copy_from_user(&rd->state.id, (struct amdgpu_debugfs_regs2_iocdata *)data, sizeof rd->state.id))
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static ssize_t amdgpu_debugfs_regs2_read(struct file *f, char __user *buf, size_t size, loff_t *pos)
+{
+	struct amdgpu_debugfs_regs2_data *rd = f->private_data;
+	rd->state.offset = *pos;
+	return amdgpu_debugfs_regs2_op(f, buf, size, 0);
+}
+
+static ssize_t amdgpu_debugfs_regs2_write(struct file *f, const char __user *buf, size_t size, loff_t *pos)
+{
+	struct amdgpu_debugfs_regs2_data *rd = f->private_data;
+	rd->state.offset = *pos;
+	return amdgpu_debugfs_regs2_op(f, (char __user *)buf, size, 1);
+}
+
 
 /**
  * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
@@ -1091,6 +1241,16 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
 	return result;
 }
 
+static const struct file_operations amdgpu_debugfs_regs2_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = amdgpu_debugfs_regs2_ioctl,
+	.read = amdgpu_debugfs_regs2_read,
+	.write = amdgpu_debugfs_regs2_write,
+	.open = amdgpu_debugfs_regs2_open,
+	.release = amdgpu_debugfs_regs2_release,
+	.llseek = default_llseek
+};
+
 static const struct file_operations amdgpu_debugfs_regs_fops = {
 	.owner = THIS_MODULE,
 	.read = amdgpu_debugfs_regs_read,
@@ -1148,6 +1308,7 @@ static const struct file_operations amdgpu_debugfs_gfxoff_fops = {
 
 static const struct file_operations *debugfs_regs[] = {
 	&amdgpu_debugfs_regs_fops,
+	&amdgpu_debugfs_regs2_fops,
 	&amdgpu_debugfs_regs_didt_fops,
 	&amdgpu_debugfs_regs_pcie_fops,
 	&amdgpu_debugfs_regs_smc_fops,
@@ -1160,6 +1321,7 @@ static const struct file_operations *debugfs_regs[] = {
 
 static const char *debugfs_regs_names[] = {
 	"amdgpu_regs",
+	"amdgpu_regs2",
 	"amdgpu_regs_didt",
 	"amdgpu_regs_pcie",
 	"amdgpu_regs_smc",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
index 141a8474e24f..ec044df5d428 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
@@ -22,6 +22,8 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
+#include <linux/ioctl.h>
+#include <uapi/drm/amdgpu_drm.h>
 
 /*
  * Debugfs
@@ -38,3 +40,33 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
+
+/*
+ * MMIO debugfs IOCTL structure
+ */
+struct amdgpu_debugfs_regs2_iocdata {
+	__u8 use_srbm, use_grbm, pg_lock;
+	struct {
+		__u32 se, sh, instance;
+	} grbm;
+	struct {
+		__u32 me, pipe, queue, vmid;
+	} srbm;
+};
+
+/*
+ * MMIO debugfs state data (per file* handle)
+ */
+struct amdgpu_debugfs_regs2_data {
+	struct amdgpu_device *adev;
+	struct {
+		struct amdgpu_debugfs_regs2_iocdata id;
+		__u32 offset;
+	} state;
+};
+
+enum AMDGPU_DEBUGFS_REGS2_CMDS {
+	AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=0,
+};
+
+#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)
-- 
2.31.1

