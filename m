Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CFBC432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 12:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F05061265
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 12:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F05061265
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10B43897BB;
	Tue, 24 Aug 2021 12:16:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A881897BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 12:16:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzZ9cZUmXOqZXfglCLv0zIzgvaR8XYIpa7VmcUzSsFwHpLIJ4s6U8D6ipvUqXOCxsUbF6TgQXn9SD0m/1X5dfcWRjjaRBu20t0z2ALgQlr3+Bpze8oamQ6YC/UiPO0shwcENfohebJJv6bnb2FBfZ09ikoYXD/3SelPiwJkBXZiAZsmGfFYgnzv0yOO1r+J1kCM3X7wsJkJf/XEEbMMUd0xMVbU+VqTLgb/nbkQXhT8nqeBgxygZ08zL2OsJgoaxlPou23u+l5LPkST1bM/qMqziAMQyOtqInC/dsSfV0Igp0mkAr9+gohepls5UzkD5JgT7uVTXLqX/HmcIZubXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLsQ3B0jKoPYPN/00m7x9xxWr/jdktE0JrGynJ7BjO0=;
 b=VtS1fkzbwBc9WxvrbFQn6ma53gWpMQbsxRfdeKKkcNgHlv/7gN0q2RRLw20gCadzbVByb986p19jazulrrj/t1gO9oki01ZAH11HgC3aeW+BSMYrZutS3YKVKpkYbH9RhJDu6/M2Hw2boMZo63XO8ox0Ees37Wy3oxWBN+CKZMwTC10PWiMhIJMVlpOEI/hI3paxFfMy4fCM5GPBH+gTWiDDey9pZymsq02MqD3tVT7wJFOq7vI3Ui425Oy8wKunv1hfpLiLy1A+iu+pNMDmu/f/l04YptD/tIhqZdG6ezAmuP91fl+kEjE2dXb7K+LqS4vSb+73pU81RGQks25lGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLsQ3B0jKoPYPN/00m7x9xxWr/jdktE0JrGynJ7BjO0=;
 b=XG0bHsVAH0Y7hSTqTBzU+uD1aXpSLyxtnAKlBIPI4wUAiwGPHpc3eSF2Yeu4fcnTQ2DWSZD6Qcsb0kPRvCn/LKTGVQfaRZqLi24PjaEXc7mLhTwu7nxKkcwhkH/NBBAtazaaNjb5Il/KfYoKXiye9LxGdrRnyYt0NdYJrZCjODM=
Received: from DM6PR02CA0054.namprd02.prod.outlook.com (2603:10b6:5:177::31)
 by CH0PR12MB5282.namprd12.prod.outlook.com (2603:10b6:610:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Tue, 24 Aug
 2021 12:16:37 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::f8) by DM6PR02CA0054.outlook.office365.com
 (2603:10b6:5:177::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 24 Aug 2021 12:16:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 12:16:37 +0000
Received: from ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 07:16:35 -0500
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
Date: Tue, 24 Aug 2021 08:16:18 -0400
Message-ID: <20210824121618.99839-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daf3434c-c2fe-471d-446e-08d966f9054f
X-MS-TrafficTypeDiagnostic: CH0PR12MB5282:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5282F5BE2CEFD422F4BF2905F7C59@CH0PR12MB5282.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eP6vpiu787ffSUlCrTDVMHGw//jv/weL91ydOhCPLURoiOEge1vmOrb2LYQI0lrJZ7KSZfvsxooNlY20R4CsbxfW5kCCweh98/XI9NmhmzcsBBpSMkad9A7LfIM7JrCTjh0cRhJjgfkzFVRgVVr/owBJPAfUu0XMYxENZx5Ehh4uSazx/QA+uycO9AI7Jui1t+gT1ZBczUO0dqFzhGaIrPBKJijSiti/2xLFBLbv7WRcl47ossZAkILdQN6eppUN3eU42Lm8CU381X6zk79DE73cth6rDQVgssaXp6YEohx6RkPzlMpnXlO64zCjzeUwOtNKX1+g6e0sFZvRVZOnmkz+tgubFSdCdOgrqn931U4Ci3FOamQ/6HiBpzgdQAnGyG/awpmP6A5CywdQObvxSWv6goHe0/ZpUfROV7WARRHoI9GXusaVj4wETviutr37TPCShoBg4hFZRv/Mo6rFK4M8Yb/bWci+J+KeJHsn3WydYR+7rsR9jyfZZCMVCgtE7IKoD6uMbb9IuQBk5VFSyZ4G+oHVu/TEHrWg/A6PtxU7ha9ik2S+dr1+d0Ebc+L/h/KA5AdG54MkrpHJPcSpWVbwSE0/e9Xh6uuAX0ZbP0OrpfiR1PIrjU4GJNCeUxrQPwY6v5RCxAM7bbGank1IYYRrRduwe7nTPar9F4mYhpojTdAGfHfP6vlvhcHv0sbGQyOhcQ78MGgAVNEb/jeX2TnfxKecvAAOS+dIYUnc0zxPE439EHJ2G/l3EIP0YiiUHRKMd3gWsu4CqSUaX4hS3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(46966006)(36840700001)(36860700001)(8676002)(8936002)(26005)(6666004)(356005)(86362001)(7696005)(426003)(70586007)(82740400003)(316002)(70206006)(2906002)(186003)(81166007)(16526019)(5660300002)(83380400001)(34020700004)(82310400003)(36756003)(4326008)(478600001)(1076003)(6916009)(47076005)(2616005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 12:16:37.0547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daf3434c-c2fe-471d-446e-08d966f9054f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5282
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

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 177 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  32 ++++
 2 files changed, 209 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 277128846dd1..ab2d92f84da5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -279,6 +279,173 @@ static ssize_t amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
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
+static int amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, int write_en)
+{
+	struct amdgpu_debugfs_regs2_data *rd = f->private_data;
+	struct amdgpu_device *adev = rd->adev;
+	int result = 0, r;
+	uint32_t value;
+
+	if (rd->state.offset & 0x3)
+		return -EINVAL;
+
+	if (rd->state.use_grbm) {
+		if (rd->state.grbm.se == 0x3FF)
+			rd->state.grbm.se = 0xFFFFFFFF;
+		if (rd->state.grbm.sh == 0x3FF)
+			rd->state.grbm.sh = 0xFFFFFFFF;
+		if (rd->state.grbm.instance == 0x3FF)
+			rd->state.grbm.instance = 0xFFFFFFFF;
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
+	if (rd->state.use_grbm) {
+		if ((rd->state.grbm.sh != 0xFFFFFFFF && rd->state.grbm.sh >= adev->gfx.config.max_sh_per_se) ||
+		    (rd->state.grbm.se != 0xFFFFFFFF && rd->state.grbm.se >= adev->gfx.config.max_shader_engines)) {
+			pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+			pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+			amdgpu_virt_disable_access_debugfs(adev);
+			return -EINVAL;
+		}
+		mutex_lock(&adev->grbm_idx_mutex);
+		amdgpu_gfx_select_se_sh(adev, rd->state.grbm.se,
+								rd->state.grbm.sh,
+								rd->state.grbm.instance);
+	} else if (rd->state.use_grbm) {
+		mutex_lock(&adev->srbm_mutex);
+		amdgpu_gfx_select_me_pipe_q(adev, rd->state.srbm.me, rd->state.srbm.pipe,
+									rd->state.srbm.queue, rd->state.srbm.vmid);
+	}
+
+	if (rd->state.pg_lock)
+		mutex_lock(&adev->pm.mutex);
+
+	if (!write_en) {
+		value = RREG32(rd->state.offset >> 2);
+		r = put_user(value, (uint32_t *)buf);
+	} else {
+		r = get_user(value, (uint32_t *)buf);
+		if (!r)
+			amdgpu_mm_wreg_mmio_rlc(adev, rd->state.offset >> 2, value);
+	}
+	if (r) {
+		result = r;
+		goto end;
+	}
+	result = 0;
+end:
+	if (rd->state.use_grbm) {
+		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+		mutex_unlock(&adev->grbm_idx_mutex);
+	} else if (rd->state.use_srbm) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	}
+
+	if (rd->state.pg_lock)
+		mutex_unlock(&adev->pm.mutex);
+
+	// in umr (the likely user of this) flags are set per file operation
+	// which means they're never "unset" explicitly.  To avoid breaking
+	// this convention we unset the flags after each operation
+	// flags are for a single call (need to be set for every read/write)
+	rd->state.use_grbm = 0;
+	rd->state.use_srbm = 0;
+	rd->state.pg_lock  = 0;
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
+	unsigned char st[32], v;
+	int r, x;
+
+	// always read first 4 bytes of data
+	for (x = 0; x < 4; x++) {
+		if ((r = get_user(v, (unsigned char *)data))) {
+			return r;
+		}
+		++data;
+		st[x] = v;
+	}
+
+	// first 4 bytes are offset
+	rd->state.offset = ((u32)st[0]) | ((u32)st[1] << 8) |
+					   ((u32)st[2] << 16) | ((u32)st[3] << 24);
+
+	switch (cmd) {
+		case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
+			for (x = 4; x < 32; x++) {
+				if ((r = get_user(v, (unsigned char *)data))) {
+					return r;
+				}
+				++data;
+				st[x] = v;
+			}
+
+			// next byte contains the flag
+			// we only consume the remainder of the state if bit 1 is set
+			// this allows the subsequent read/write
+			rd->state.use_grbm = (st[4] & 1) ? 1 : 0;
+			rd->state.use_srbm = (st[4] & 2) ? 1 : 0;
+			rd->state.pg_lock  = (st[4] & 4) ? 1 : 0;
+
+			// next 6 bytes are grbm data
+			rd->state.grbm.se       =  ((u32)st[5]) | ((u32)st[6] << 8);
+			rd->state.grbm.sh       =  ((u32)st[7]) | ((u32)st[8] << 8);
+			rd->state.grbm.instance =  ((u32)st[9]) | ((u32)st[10] << 8);
+
+			// next 8 are srbm data
+			rd->state.srbm.me       =  ((u32)st[11]) | ((u32)st[12] << 8);
+			rd->state.srbm.pipe     =  ((u32)st[13]) | ((u32)st[14] << 8);
+			rd->state.srbm.queue    =  ((u32)st[15]) | ((u32)st[16] << 8);
+			rd->state.srbm.vmid     =  ((u32)st[17]) | ((u32)st[18] << 8);
+			break;
+		case AMDGPU_DEBUGFS_REGS2_IOC_READ:
+			return amdgpu_debugfs_regs2_op(f, (char __user *)data, 0);
+		case AMDGPU_DEBUGFS_REGS2_IOC_WRITE:
+			return amdgpu_debugfs_regs2_op(f, (char __user *)data, 1);
+		default:
+			return -EINVAL;
+	}
+	return 0;
+}
 
 /**
  * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
@@ -1091,6 +1258,14 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
 	return result;
 }
 
+static const struct file_operations amdgpu_debugfs_regs2_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = amdgpu_debugfs_regs2_ioctl,
+	.open = amdgpu_debugfs_regs2_open,
+	.release = amdgpu_debugfs_regs2_release,
+	.llseek = default_llseek
+};
+
 static const struct file_operations amdgpu_debugfs_regs_fops = {
 	.owner = THIS_MODULE,
 	.read = amdgpu_debugfs_regs_read,
@@ -1148,6 +1323,7 @@ static const struct file_operations amdgpu_debugfs_gfxoff_fops = {
 
 static const struct file_operations *debugfs_regs[] = {
 	&amdgpu_debugfs_regs_fops,
+	&amdgpu_debugfs_regs2_fops,
 	&amdgpu_debugfs_regs_didt_fops,
 	&amdgpu_debugfs_regs_pcie_fops,
 	&amdgpu_debugfs_regs_smc_fops,
@@ -1160,6 +1336,7 @@ static const struct file_operations *debugfs_regs[] = {
 
 static const char *debugfs_regs_names[] = {
 	"amdgpu_regs",
+	"amdgpu_regs2",
 	"amdgpu_regs_didt",
 	"amdgpu_regs_pcie",
 	"amdgpu_regs_smc",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
index 141a8474e24f..04c81cd4bcc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
@@ -22,6 +22,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
+#include <linux/ioctl.h>
 
 /*
  * Debugfs
@@ -38,3 +39,34 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
+
+struct amdgpu_debugfs_regs2_data {
+	struct amdgpu_device *adev;
+	struct {
+		// regs state
+		int use_srbm,
+		    use_grbm,
+		    pg_lock;
+		struct {
+			u32 se, sh, instance;
+		} grbm;
+		struct {
+			u32 me, pipe, queue, vmid;
+		} srbm;
+		u32 offset;
+	} state;
+};
+
+enum AMDGPU_DEBUGFS_REGS2_CMDS {
+	AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=0,
+	AMDGPU_DEBUGFS_REGS2_CMD_READ,
+	AMDGPU_DEBUGFS_REGS2_CMD_WRITE,
+};
+
+struct amdgpu_debugfs_regs2_iocdata {
+	unsigned char t[32];
+};
+
+#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)
+#define AMDGPU_DEBUGFS_REGS2_IOC_READ _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_WRITE, struct amdgpu_debugfs_regs2_iocdata)
+#define AMDGPU_DEBUGFS_REGS2_IOC_WRITE _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_READ, struct amdgpu_debugfs_regs2_iocdata)
-- 
2.31.1

