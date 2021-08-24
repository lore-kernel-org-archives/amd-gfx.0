Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C097C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 16:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F038161183
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 16:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F038161183
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66E23899BE;
	Tue, 24 Aug 2021 16:48:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49592899BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 16:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmvMw9+UjtdvbdT4pnmnlgry5QbUMag7lnS8jV9U78asejEcW6AlCEWObWh2ZH77Q2yuVvfmXCfKZ11TuMgD29Umi+h9brTFSfkrxvwEdiTFx5jsRlRptLJ0mBVD7jYwcaVJp+iApSYjM8UtClua0/0KIYVckpX/kX52xlBDS5IdkQH4KlnkKZMHGie4+Ni7vlFbO9rLpOk1G2FcfWVhbjvaE7qF912mDsBA/uIOnwPkR32T1dhPhUGI0yJttEtCmEnP6iZSAuAyV/cv7umY12AJfosZR+8tJ5cyeAvkEzX0EYU+Ddl9Ql1AkR91PWhBMxiY0bcgckHl7Z02Fk0ygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Jrj9RQ4uXYT4AFI1F2QIFEgUGSc4FY3RFaI1wKh7H8=;
 b=Q+osz64FWBq0vNi/HC7U3XxCpIjRXJlU1ayBlW3Q4c64slmKjIBHEVum0hgJRerzcJIhqU4n1ZAwZeVq/lcUwlshdA/n91lFrGw3VAQDpi0uZQZqkfH7HloltHoo0VhDHkwXbjSekb0m6lWXMlGM3cf2iVyJDAJunMFl5uhRB0UMNr67+ntq5blVEeGLHJXSqsw+MYPKd9/wTKk1eLA9T6eQUuJflNGINz86KeKSHr2Qu2DjcYkJ9z90emMFmAOnG3i9vZJzWVjkRmVExo5XtxIAXb2xY7CRxHR/v3NXO6VNzD6noAMJp/CSHG3e5XtEFf6NCF4do8ujof9F4zqfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Jrj9RQ4uXYT4AFI1F2QIFEgUGSc4FY3RFaI1wKh7H8=;
 b=qmx2WA8Q6hUPjq+65Gjkw3vd1N5hGl68gACT9wa5Wa49kAA3dNl182qsJUaPnwkgyUfk1WzpgMEi9DkCCbeXE6X88kqch8eEfR4fLF0BysnKU8FIoD37onKYrrpxfd+n7VdCMyOk6kjB3UPA4XB4p1SNOwz8oetSSkmK4f+favI=
Received: from CO2PR05CA0085.namprd05.prod.outlook.com (2603:10b6:104:1::11)
 by BN6PR1201MB2496.namprd12.prod.outlook.com (2603:10b6:404:a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Tue, 24 Aug
 2021 16:48:13 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::31) by CO2PR05CA0085.outlook.office365.com
 (2603:10b6:104:1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend
 Transport; Tue, 24 Aug 2021 16:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 16:48:11 +0000
Received: from ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 11:48:10 -0500
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers (v3)
Date: Tue, 24 Aug 2021 12:48:03 -0400
Message-ID: <20210824164803.126531-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 036b32e1-39b6-472b-d4a1-08d9671ef5c3
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2496:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB249632EE70AEAAF66DD5E760F7C59@BN6PR1201MB2496.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nehmMPkihEJRlOY9JE6akoWm8DC9K++e3sPMLQMLc3nGPNoW4UD1XsZ5ZAfDYkXZa+gmxVipmSe5FTuymoVOGWZyAzjAzPh/qAUkHwWOQ/oTKtpBnPJ5kKeGii1MAW5oMoWtCS9EA9rpIflCer4v91maGwUPan1HIoh2uvGmcNDBg+shmY1b/iR3Tby/e9+gKMknkKRPx17JN+7NhAjbveBGuEDMtP+k6Xt3zopvV+km6DozScPI4kHOBpSKNd1G+MXsEZDAU870ReeSRi4DgnsEjiYEWz3N/k32E2WExAaqP5Y5OdNvSBWUUdZnx01w5qDhHcfHJCh2UQ9k7EnotB9/PMuKuzrlpqHPMNJBBbzSB3vgrvYplapz93mjR6MYSNNbY/Cl3xKyK8ztK/3R/OL7xaPSno4JU/NNiRDkNCp5yjLjaoaDzK7GHyAqwvkotccsh+WSYv404Dwpm+5SNQvmD9S01A0xDU3Fm49VpUkICODTa3bqYN/kq4sU99E+rzTDRFgV3wFW/TUaq61ixkBPd4QotbbcqxzUUqofXLSJrPJf1J/tUghyX8iHcRj0Tt/Uls/HNbKxb/SwUhT8f9JMRDNb7aA8dAmLgOCFt7c+JmqpeoKBNLPOfjAhwcRPCSIu0P+Nxw91ubHwUENgQ1fQEaOKobs2+vkOLp0JHZILcRM6Ssv7AOhFXil7Oyywp663bOLViAglpwVab21pgScroLmCbxJ5pAP4uQYYJbfLhwXF4f0iAYjRsCWoW627GNNoxx+ZhGajC4DTv8JZsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966006)(36840700001)(336012)(478600001)(186003)(86362001)(26005)(7696005)(8676002)(36756003)(8936002)(426003)(16526019)(1076003)(83380400001)(6666004)(4326008)(356005)(2616005)(47076005)(2906002)(316002)(5660300002)(81166007)(34020700004)(6916009)(82310400003)(82740400003)(36860700001)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 16:48:11.7938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 036b32e1-39b6-472b-d4a1-08d9671ef5c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2496
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

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 162 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  32 ++++
 2 files changed, 194 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 277128846dd1..b464a7d50bd7 100644
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
+	/* in umr (the likely user of this) flags are set per file operation
+	 * which means they're never "unset" explicitly.  To avoid breaking
+	 * this convention we unset the flags after each operation
+	 * flags are for a single call (need to be set for every read/write) */
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

