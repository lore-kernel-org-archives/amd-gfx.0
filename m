Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEC4C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 14:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C7B60E97
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 14:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 83C7B60E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07EDD6E25A;
	Wed, 25 Aug 2021 14:44:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E33D86E25A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 14:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFpixejPMFLkrqzT9uTea3E+DVX0XfBJQF+CLyet0k+KoDE/YcAtojdeWI1yd1AMARw2TbwNi5XBVTfoVNSSn7lYlMuynmJY7hJrlyhduPVAE5tUmo+Bfpb+WmnICKsmDEa2f25J1Oc8HJDY0OmiKLxXqsje1kYhYMkWGOQa9+JA+EHTy7bFK2ExnGDVPmJGRS1iPlVBwrYEq9Mk/tHecy+tjRM03pSTZ8s5GNrC6SIgbfktsahIKeXs7GO3k0RTvV4tsVYn6OV/kZE64BYooNemcC+/Jv2i8idWHryZHOH1iyh+zOcJjuKkCFTnCEnfa8MAmGdRPTXkuZM6ZJ6TMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX9tSvWDAZ74l5KLcoHRV2Bv65Np/2lVyY6NPqZ0MlI=;
 b=Qv8zP5SNRAsM3dSH0Ykg1wt20vz6ERxJZS0Gvsp/9IrfmhZ5ynJ2bcc/JqPeZrtXAA+82+xbwg1LcG0+N/DPO5+qSuK8WBvGWYYNMscIIPpr9EPKJqGRHlYFasVl8MNQv9iZIegvDmOc+mlyELy8At1XyIkn7/y8Qc/zVHlVWLD8u9pF4Q12slRzdCSU8huCdGZzbgKbwZk7mh57B//ELWzISgwddAlNOl6vc3I40Zl18cCt0QbOg8DtcZzETochcaRjN799cW2fqWdUH9os8cTuqV50qUAQiWlm9McE7HOgefjSFodNiISOFaJUyC/j2kMcAvl6cfPa6UapyV94nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX9tSvWDAZ74l5KLcoHRV2Bv65Np/2lVyY6NPqZ0MlI=;
 b=o8vKU68OOZiliFafr5D3OnhLbY55RHEqKoKuei7zrPzK4B8Wixn3VaxV+6l+Ayo/th5PNsfox3Bt5E2GFjPukQwaOZuQVCxmGnwrkNii8emSITykb3F15gDcE+Zxaz153r/255+LsAoFq5XAhwKUTJ4bpFkUgSeIe/vNSDWgJ4Q=
Received: from BN9P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::20)
 by BN8PR12MB2980.namprd12.prod.outlook.com (2603:10b6:408:62::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Wed, 25 Aug
 2021 13:09:34 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::db) by BN9P222CA0015.outlook.office365.com
 (2603:10b6:408:10c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Wed, 25 Aug 2021 13:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 13:09:34 +0000
Received: from ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 25 Aug
 2021 08:09:32 -0500
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers (v4)
Date: Wed, 25 Aug 2021 09:09:26 -0400
Message-ID: <20210825130926.230698-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b8a33fb-dc05-4aec-c099-08d967c9954d
X-MS-TrafficTypeDiagnostic: BN8PR12MB2980:
X-Microsoft-Antispam-PRVS: <BN8PR12MB29807FC5FD2FD9C9A6490ABEF7C69@BN8PR12MB2980.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KfgqR80uDJ4GF2Dq69kQjRV10+UlWDe0AaBQ3HhmhStdqfg5JCq+xiaeBfJkXXWZwCJhmQIRDa80jOkRjreIYUfY4Z+HC13kZpQfvRIRuHasL+WesO6uPFEuFRVdhz4eWaH34LbbOdu3zJqn8cjvL0F0kkYQvVMXTfsKEmlAKXwZ3GP7cSZ3GqTAMXatEBfdJH01gOEQIOcWbuonvc23mmN1gnrPBJdcHUVHrLdYSB22Hn4G7IpOm8KZxVAqCjyZ9FbjFuatwTEkEeAmCc4uGN0oEBQdMk/JWZT9hDN37UsYYIM/TGJ2qvjEOZ5VHPk5V2AdJa8xxeyhJZoW9qLF7V0DZiCuayerNhzD0ZcHH/sa0yAs9Jr2K7MEb2nnSm6GA38L32hodh5xs/+lNTl6SJjKcPk5uAMTaxCHRaih3GmBZbHfQzpAQQSg0TFMtw/NT0hvC70Eb54MMvdl7Tr/GcXz0uWnSImexGbkp3fcl003HLKsWpcYKmo2dOjOcNwNotx0P/ZlVLPx7jQgBGFICIQcil2sbez2NW7dQ4u26qxKaLaIzmL9CuBoCEYCLFAhzjcks+u+vZV4DGi1p4iDHewTxHpRL5b7PLHpYdcCU6/035c3vWu2xwTti6NuVVTUvoi6Cy/Iyncivr4H0v3lHElLeRD0MezEKd8F/HW1S4XmW5uS74OGIOt483kFPv8h0gUSDmirBZBJEve3553m14Q9PaI9o8/rs+Tkjx8YtDg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(36840700001)(478600001)(316002)(7696005)(6666004)(8936002)(16526019)(1076003)(2616005)(2906002)(5660300002)(186003)(6916009)(426003)(336012)(26005)(8676002)(36756003)(86362001)(4326008)(82740400003)(70586007)(70206006)(36860700001)(356005)(83380400001)(81166007)(82310400003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 13:09:34.0204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8a33fb-dc05-4aec-c099-08d967c9954d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2980
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

(v3): C style comments

(v4): use u32 in struct and remove offset variable

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 158 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  29 ++++
 2 files changed, 187 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 277128846dd1..6450f210f6c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -279,6 +279,152 @@ static ssize_t amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
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
+static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 offset, size_t size, int write_en)
+{
+	struct amdgpu_debugfs_regs2_data *rd = f->private_data;
+	struct amdgpu_device *adev = rd->adev;
+	ssize_t result = 0;
+	int r;
+	uint32_t value;
+
+	if (size & 0x3 || offset & 0x3)
+		return -EINVAL;
+
+	if (rd->id.use_grbm) {
+		if (rd->id.grbm.se == 0x3FF)
+			rd->id.grbm.se = 0xFFFFFFFF;
+		if (rd->id.grbm.sh == 0x3FF)
+			rd->id.grbm.sh = 0xFFFFFFFF;
+		if (rd->id.grbm.instance == 0x3FF)
+			rd->id.grbm.instance = 0xFFFFFFFF;
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
+	if (rd->id.use_grbm) {
+		if ((rd->id.grbm.sh != 0xFFFFFFFF && rd->id.grbm.sh >= adev->gfx.config.max_sh_per_se) ||
+		    (rd->id.grbm.se != 0xFFFFFFFF && rd->id.grbm.se >= adev->gfx.config.max_shader_engines)) {
+			pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+			pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+			amdgpu_virt_disable_access_debugfs(adev);
+			return -EINVAL;
+		}
+		mutex_lock(&adev->grbm_idx_mutex);
+		amdgpu_gfx_select_se_sh(adev, rd->id.grbm.se,
+								rd->id.grbm.sh,
+								rd->id.grbm.instance);
+	}
+
+	if (rd->id.use_srbm) {
+		mutex_lock(&adev->srbm_mutex);
+		amdgpu_gfx_select_me_pipe_q(adev, rd->id.srbm.me, rd->id.srbm.pipe,
+									rd->id.srbm.queue, rd->id.srbm.vmid);
+	}
+
+	if (rd->id.pg_lock)
+		mutex_lock(&adev->pm.mutex);
+
+	while (size) {
+		if (!write_en) {
+			value = RREG32(offset >> 2);
+			r = put_user(value, (uint32_t *)buf);
+		} else {
+			r = get_user(value, (uint32_t *)buf);
+			if (!r)
+				amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, value);
+		}
+		if (r) {
+			result = r;
+			goto end;
+		}
+		offset += 4;
+		size -= 4;
+		result += 4;
+		buf += 4;
+	}
+end:
+	if (rd->id.use_grbm) {
+		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+		mutex_unlock(&adev->grbm_idx_mutex);
+	}
+
+	if (rd->id.use_srbm) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	}
+
+	if (rd->id.pg_lock)
+		mutex_unlock(&adev->pm.mutex);
+
+	/* in umr (the likely user of this) flags are set per file operation
+	 * which means they're never "unset" explicitly.  To avoid breaking
+	 * this convention we unset the flags after each operation
+	 * flags are for a single call (need to be set for every read/write) */
+	rd->id.use_grbm = 0;
+	rd->id.use_srbm = 0;
+	rd->id.pg_lock  = 0;
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
+		if (copy_from_user(&rd->id, (struct amdgpu_debugfs_regs2_iocdata *)data, sizeof rd->id))
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
+	return amdgpu_debugfs_regs2_op(f, buf, *pos, size, 0);
+}
+
+static ssize_t amdgpu_debugfs_regs2_write(struct file *f, const char __user *buf, size_t size, loff_t *pos)
+{
+	return amdgpu_debugfs_regs2_op(f, (char __user *)buf, *pos, size, 1);
+}
+
 
 /**
  * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
@@ -1091,6 +1237,16 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
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
@@ -1148,6 +1304,7 @@ static const struct file_operations amdgpu_debugfs_gfxoff_fops = {
 
 static const struct file_operations *debugfs_regs[] = {
 	&amdgpu_debugfs_regs_fops,
+	&amdgpu_debugfs_regs2_fops,
 	&amdgpu_debugfs_regs_didt_fops,
 	&amdgpu_debugfs_regs_pcie_fops,
 	&amdgpu_debugfs_regs_smc_fops,
@@ -1160,6 +1317,7 @@ static const struct file_operations *debugfs_regs[] = {
 
 static const char *debugfs_regs_names[] = {
 	"amdgpu_regs",
+	"amdgpu_regs2",
 	"amdgpu_regs_didt",
 	"amdgpu_regs_pcie",
 	"amdgpu_regs_smc",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
index 141a8474e24f..dcf20859c866 100644
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
@@ -38,3 +40,30 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
+
+/*
+ * MMIO debugfs IOCTL structure
+ */
+struct amdgpu_debugfs_regs2_iocdata {
+	__u32 use_srbm, use_grbm, pg_lock;
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
+	struct amdgpu_debugfs_regs2_iocdata id;
+};
+
+enum AMDGPU_DEBUGFS_REGS2_CMDS {
+	AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=0,
+};
+
+#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)
-- 
2.31.1

