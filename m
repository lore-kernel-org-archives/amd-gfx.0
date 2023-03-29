Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79DFC761A6
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83ADB10EC62;
	Wed, 29 Mar 2023 20:26:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48E2910EC5F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:26:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKZ9pF173RhXh+Uo3zjB8Loekn/hmYlVTJ9FNGP14VceKbsIiwKhzMrXH8d9cP1N41/Leloa0ajCrcBCW4SAJRvUAcY7EFlIkUc3mXyTyedzGf0/QuXT7XBVRUsqSlJWEfWOeO6JBCqs+RpbePHwOyF3I76ilAt3CyLtott5/JVT0ZQKRGZ8HPPZ/lb39sXy3Q7DvhMJbMdRIgeVW+gcZUnDk6U7Sqi2CJS3Vie5umHyiupDnlS+esK0jcOSNr8G0SpEeR4+zc5wdwFg0G4Nga4wJZ6lCM5jEsPKBeg9uloRJoefWq4RZS/PGKivr3BcefhMzjnM/VzU9vKCKBOGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+buntVns247cvuI/7/Kp8rzSm64Gb1LxPW+fNXFjpU=;
 b=Ursc2hSXiC8zYlkgPzpQNyLRfI5rw0J2DjDzncJe8CdQH9aaDzEpDElKC30uf4qaZMqGpdvdy7LIbQTKBSiK5sBzDowbiu46b13vX5MiiGzf24n4b9FhzHuef5GG9NV0Jl2F7zspqbhwgtGRr4Vh8vdT+iyNl5o3lJBqwEHUdpQfUVPMw9/9ntFEH7jIKREKk350TmFl2ONLzVeiOH/wJxjaysZbiFwqYxDWsuWjzGPgmISRnt2l7rIpjqbPMQmR6SxfyB4Z4F+QG2gdEdvcwkmnHR+6sEv9k3BL8cXQ33v7mb/ofUj3h0JVfsMypuVAvnDGwP1QGEl1XtfjnIRwBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+buntVns247cvuI/7/Kp8rzSm64Gb1LxPW+fNXFjpU=;
 b=TdFbo+FXyQScw5Gdl6zQzufVF+6yPwqyQ5SQEFfQP0Swv5asIRFvuqpw5solxG0f/yeQmhfIW3vPvBU+rpT9H6povheEB0DZ3rFxhU0Oc3kDT/ylDjkSGZHM51Wtor7YNIKFx4QcS+jwPrSFnB3rKEm/k8YQt58i5WWE6nzLScM=
Received: from DS7PR03CA0089.namprd03.prod.outlook.com (2603:10b6:5:3bb::34)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:26:09 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::13) by DS7PR03CA0089.outlook.office365.com
 (2603:10b6:5:3bb::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:26:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:26:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/14] drm/amd/amdgpu: Update debugfs for XCC support (v3)
Date: Wed, 29 Mar 2023 16:25:47 -0400
Message-ID: <20230329202548.1983334-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329202548.1983334-1-alexander.deucher@amd.com>
References: <20230329202548.1983334-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3b97cf-ac34-4a5d-3bfe-08db3093d4f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zdReVPHXsv88tVtMyDNGAAJvYGOR5+cj3bji1MeF1wVKO0yz8bewj90FD2w0huhACJupN75Xq+KiVwgUoxSFFm26ev2DhcGRO7a3zAeGdjXIWA35iuRHUYVSj9pTyHjvRvLaOl084Z6f6SuXKx//kooG6yR6XRK5HUsKT5c83cEw5/GC6yMuy+4gnDupYP0U0O6b7OL9NNKAAY2GBfrs+Jd9S4pCACavqX1mEQFy9R2uhlnVFOY1155DNh8OktCP6S/2l7XuImiehRX6EN3tTKe3ju949jgaijoZWDdx+eQt7Slhs7CKvCDVywsrIlVbfBVsj8N14LncetmWbvHp5AO3xfmeQHWUU/jiGDvmA51aCCmKf0EtAHK4dCQuzXG2GoA/2xQma6h/OaXeD7a7uTOkpOCTNqCxynjCn9YjgkmvzSU39XwSlIcQmsOTLWpohMai5vJeCSNFl3ZYHf9thw6KAhNMoYyhwZJ4gPWdDv/NXzjm5r9iVJd/EB06hLohcAMsbTM4mFXgza0OAaY4s3IAg2re9d6YLUwHn+OPFYlY5Js3WOCVQtINX6wi3tTYxE2r5/ZvZOokLQ7CQRRLhpYN6AhnQuLpGdt/C5+lBI7UR/NBv+vVJf5Y0R8Rs3mQKZ2ea5k0hJMYhIvDnb++z7HhPu1vuL4AUB8ylL2ccifAgk7zkZ5gGJCV6+9e09/kaljXYlR9zyhaAR11W8U76BzHqQij5vMRHHtiFfR1H0w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(7696005)(70586007)(478600001)(54906003)(4326008)(316002)(70206006)(6916009)(8676002)(86362001)(36756003)(47076005)(336012)(2616005)(426003)(1076003)(83380400001)(186003)(6666004)(8936002)(16526019)(26005)(15650500001)(82740400003)(2906002)(41300700001)(30864003)(81166007)(36860700001)(40480700001)(82310400005)(5660300002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:26:09.3377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3b97cf-ac34-4a5d-3bfe-08db3093d4f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107
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
Cc: Tom St Denis <tom.stdenis@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom St Denis <tom.stdenis@amd.com>

This patch updates the 'regs2' interface for MMIO
registers to add a new IOCTL command for a 'v2' state
data that includes the XCC ID.

This patch then updates amdgpu_gfx_select_se_sh()
and amdgpu_gfx_select_me_pipe_q() (and the implementations
in the gfx drivers) to support an additional parameter.

This patch then creates a new debugfs interface "gprwave"
which is a merge of shader GPR and wave status access.  This
new inteface uses an IOCTL to select banks as well as XCC identity.

(v2) Fix missing xcc_id in wave_ind function

(v3) Fix pm runtime calls and mutex locking

(v4) Fix bad label

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 199 ++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h     |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h     |  36 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  60 +++---
 10 files changed, 273 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 547abe155820..b36106252176 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -139,7 +139,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 					sh_bank, instance_bank, 0);
 	} else if (use_ring) {
 		mutex_lock(&adev->srbm_mutex);
-		amdgpu_gfx_select_me_pipe_q(adev, me, pipe, queue, vmid);
+		amdgpu_gfx_select_me_pipe_q(adev, me, pipe, queue, vmid, 0);
 	}
 
 	if (pm_pg_lock)
@@ -172,7 +172,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 		mutex_unlock(&adev->grbm_idx_mutex);
 	} else if (use_ring) {
-		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 	}
 
@@ -262,14 +262,14 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
 		}
 		mutex_lock(&adev->grbm_idx_mutex);
 		amdgpu_gfx_select_se_sh(adev, rd->id.grbm.se,
-								rd->id.grbm.sh,
-								rd->id.grbm.instance, 0);
+						  rd->id.grbm.sh,
+						  rd->id.grbm.instance, rd->id.xcc_id);
 	}
 
 	if (rd->id.use_srbm) {
 		mutex_lock(&adev->srbm_mutex);
 		amdgpu_gfx_select_me_pipe_q(adev, rd->id.srbm.me, rd->id.srbm.pipe,
-									rd->id.srbm.queue, rd->id.srbm.vmid);
+					    rd->id.srbm.queue, rd->id.srbm.vmid, rd->id.xcc_id);
 	}
 
 	if (rd->id.pg_lock)
@@ -295,12 +295,12 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
 	}
 end:
 	if (rd->id.use_grbm) {
-		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
+		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, rd->id.xcc_id);
 		mutex_unlock(&adev->grbm_idx_mutex);
 	}
 
 	if (rd->id.use_srbm) {
-		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, rd->id.xcc_id);
 		mutex_unlock(&adev->srbm_mutex);
 	}
 
@@ -319,18 +319,43 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
 static long amdgpu_debugfs_regs2_ioctl(struct file *f, unsigned int cmd, unsigned long data)
 {
 	struct amdgpu_debugfs_regs2_data *rd = f->private_data;
+	struct amdgpu_debugfs_regs2_iocdata v1_data;
 	int r;
 
+	mutex_lock(&rd->lock);
+
 	switch (cmd) {
+	case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE_V2:
+		r = copy_from_user(&rd->id, (struct amdgpu_debugfs_regs2_iocdata_v2 *)data, sizeof rd->id);
+		if (r)
+			r = -EINVAL;
+		goto done;
 	case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
-		mutex_lock(&rd->lock);
-		r = copy_from_user(&rd->id, (struct amdgpu_debugfs_regs2_iocdata *)data, sizeof rd->id);
-		mutex_unlock(&rd->lock);
-		return r ? -EINVAL : 0;
+		r = copy_from_user(&v1_data, (struct amdgpu_debugfs_regs2_iocdata *)data, sizeof v1_data);
+		if (r) {
+			r = -EINVAL;
+			goto done;
+		}
+		goto v1_copy;
 	default:
-		return -EINVAL;
-	}
-	return 0;
+		r = -EINVAL;
+		goto done;
+	}
+
+v1_copy:
+	rd->id.use_srbm = v1_data.use_srbm;
+	rd->id.use_grbm = v1_data.use_grbm;
+	rd->id.pg_lock = v1_data.pg_lock;
+	rd->id.grbm.se = v1_data.grbm.se;
+	rd->id.grbm.sh = v1_data.grbm.sh;
+	rd->id.grbm.instance = v1_data.grbm.instance;
+	rd->id.srbm.me = v1_data.srbm.me;
+	rd->id.srbm.pipe = v1_data.srbm.pipe;
+	rd->id.srbm.queue = v1_data.srbm.queue;
+	rd->id.xcc_id = 0;
+done:
+	mutex_unlock(&rd->lock);
+	return r;
 }
 
 static ssize_t amdgpu_debugfs_regs2_read(struct file *f, char __user *buf, size_t size, loff_t *pos)
@@ -343,6 +368,135 @@ static ssize_t amdgpu_debugfs_regs2_write(struct file *f, const char __user *buf
 	return amdgpu_debugfs_regs2_op(f, (char __user *)buf, *pos, size, 1);
 }
 
+static int amdgpu_debugfs_gprwave_open(struct inode *inode, struct file *file)
+{
+	struct amdgpu_debugfs_gprwave_data *rd;
+
+	rd = kzalloc(sizeof *rd, GFP_KERNEL);
+	if (!rd)
+		return -ENOMEM;
+	rd->adev = file_inode(file)->i_private;
+	file->private_data = rd;
+	mutex_init(&rd->lock);
+
+	return 0;
+}
+
+static int amdgpu_debugfs_gprwave_release(struct inode *inode, struct file *file)
+{
+	struct amdgpu_debugfs_gprwave_data *rd = file->private_data;
+	mutex_destroy(&rd->lock);
+	kfree(file->private_data);
+	return 0;
+}
+
+static ssize_t amdgpu_debugfs_gprwave_read(struct file *f, char __user *buf, size_t size, loff_t *pos)
+{
+	struct amdgpu_debugfs_gprwave_data *rd = f->private_data;
+	struct amdgpu_device *adev = rd->adev;
+	ssize_t result = 0;
+	int r;
+	uint32_t *data, x;
+
+	if (size & 0x3 || *pos & 0x3)
+		return -EINVAL;
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
+	data = kcalloc(1024, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		amdgpu_virt_disable_access_debugfs(adev);
+		return -ENOMEM;
+	}
+
+	/* switch to the specific se/sh/cu */
+	mutex_lock(&adev->grbm_idx_mutex);
+	amdgpu_gfx_select_se_sh(adev, rd->id.se, rd->id.sh, rd->id.cu, rd->id.xcc_id);
+
+	if (!rd->id.gpr_or_wave) {
+		x = 0;
+		if (adev->gfx.funcs->read_wave_data)
+			adev->gfx.funcs->read_wave_data(adev, rd->id.xcc_id, rd->id.simd, rd->id.wave, data, &x);
+	} else {
+		x = size >> 2;
+		if (rd->id.gpr.vpgr_or_sgpr) {
+			if (adev->gfx.funcs->read_wave_vgprs)
+				adev->gfx.funcs->read_wave_vgprs(adev, rd->id.xcc_id, rd->id.simd, rd->id.wave, rd->id.gpr.thread, *pos, size>>2, data);
+		} else {
+			if (adev->gfx.funcs->read_wave_sgprs)
+				adev->gfx.funcs->read_wave_sgprs(adev, rd->id.xcc_id, rd->id.simd, rd->id.wave, *pos, size>>2, data);
+		}
+	}
+
+	amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, rd->id.xcc_id);
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+
+	if (!x) {
+		result = -EINVAL;
+		goto done;
+	}
+
+	while (size && (*pos < x * 4)) {
+		uint32_t value;
+
+		value = data[*pos >> 2];
+		r = put_user(value, (uint32_t *)buf);
+		if (r) {
+			result = r;
+			goto done;
+		}
+
+		result += 4;
+		buf += 4;
+		*pos += 4;
+		size -= 4;
+	}
+
+done:
+	amdgpu_virt_disable_access_debugfs(adev);
+	kfree(data);
+	return result;
+}
+
+static long amdgpu_debugfs_gprwave_ioctl(struct file *f, unsigned int cmd, unsigned long data)
+{
+	struct amdgpu_debugfs_gprwave_data *rd = f->private_data;
+	int r;
+
+	mutex_lock(&rd->lock);
+
+	switch (cmd) {
+	case AMDGPU_DEBUGFS_GPRWAVE_IOC_SET_STATE:
+		r = copy_from_user(&rd->id, (struct amdgpu_debugfs_gprwave_iocdata *)data, sizeof rd->id);
+		if (r)
+			return r ? -EINVAL : 0;
+		goto done;
+	default:
+		r = -EINVAL;
+		goto done;
+	}
+
+done:
+	mutex_unlock(&rd->lock);
+	return r;
+}
+
+
+
 
 /**
  * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
@@ -911,7 +1065,7 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
 
 	x = 0;
 	if (adev->gfx.funcs->read_wave_data)
-		adev->gfx.funcs->read_wave_data(adev, simd, wave, data, &x);
+		adev->gfx.funcs->read_wave_data(adev, 0, simd, wave, data, &x);
 
 	amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
@@ -1005,10 +1159,10 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 
 	if (bank == 0) {
 		if (adev->gfx.funcs->read_wave_vgprs)
-			adev->gfx.funcs->read_wave_vgprs(adev, simd, wave, thread, offset, size>>2, data);
+			adev->gfx.funcs->read_wave_vgprs(adev, 0, simd, wave, thread, offset, size>>2, data);
 	} else {
 		if (adev->gfx.funcs->read_wave_sgprs)
-			adev->gfx.funcs->read_wave_sgprs(adev, simd, wave, offset, size>>2, data);
+			adev->gfx.funcs->read_wave_sgprs(adev, 0, simd, wave, offset, size>>2, data);
 	}
 
 	amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0);
@@ -1339,6 +1493,15 @@ static const struct file_operations amdgpu_debugfs_regs2_fops = {
 	.llseek = default_llseek
 };
 
+static const struct file_operations amdgpu_debugfs_gprwave_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = amdgpu_debugfs_gprwave_ioctl,
+	.read = amdgpu_debugfs_gprwave_read,
+	.open = amdgpu_debugfs_gprwave_open,
+	.release = amdgpu_debugfs_gprwave_release,
+	.llseek = default_llseek
+};
+
 static const struct file_operations amdgpu_debugfs_regs_fops = {
 	.owner = THIS_MODULE,
 	.read = amdgpu_debugfs_regs_read,
@@ -1416,6 +1579,7 @@ static const struct file_operations amdgpu_debugfs_gfxoff_residency_fops = {
 static const struct file_operations *debugfs_regs[] = {
 	&amdgpu_debugfs_regs_fops,
 	&amdgpu_debugfs_regs2_fops,
+	&amdgpu_debugfs_gprwave_fops,
 	&amdgpu_debugfs_regs_didt_fops,
 	&amdgpu_debugfs_regs_pcie_fops,
 	&amdgpu_debugfs_regs_smc_fops,
@@ -1432,6 +1596,7 @@ static const struct file_operations *debugfs_regs[] = {
 static const char *debugfs_regs_names[] = {
 	"amdgpu_regs",
 	"amdgpu_regs2",
+	"amdgpu_gprwave",
 	"amdgpu_regs_didt",
 	"amdgpu_regs_pcie",
 	"amdgpu_regs_smc",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 8741f8c30ce0..9c21792fbfc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -240,16 +240,16 @@ struct amdgpu_gfx_funcs {
 	uint64_t (*get_gpu_clock_counter)(struct amdgpu_device *adev);
 	void (*select_se_sh)(struct amdgpu_device *adev, u32 se_num,
 			     u32 sh_num, u32 instance, int xcc_id);
-	void (*read_wave_data)(struct amdgpu_device *adev, uint32_t simd,
+	void (*read_wave_data)(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
 			       uint32_t wave, uint32_t *dst, int *no_fields);
-	void (*read_wave_vgprs)(struct amdgpu_device *adev, uint32_t simd,
+	void (*read_wave_vgprs)(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
 				uint32_t wave, uint32_t thread, uint32_t start,
 				uint32_t size, uint32_t *dst);
-	void (*read_wave_sgprs)(struct amdgpu_device *adev, uint32_t simd,
+	void (*read_wave_sgprs)(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
 				uint32_t wave, uint32_t start, uint32_t size,
 				uint32_t *dst);
 	void (*select_me_pipe_q)(struct amdgpu_device *adev, u32 me, u32 pipe,
-				 u32 queue, u32 vmid);
+				 u32 queue, u32 vmid, u32 xcc_id);
 	void (*init_spm_golden)(struct amdgpu_device *adev);
 	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
 	enum amdgpu_gfx_partition
@@ -394,7 +394,7 @@ struct amdgpu_gfx {
 
 #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
 #define amdgpu_gfx_select_se_sh(adev, se, sh, instance, xcc_id) (adev)->gfx.funcs->select_se_sh((adev), (se), (sh), (instance), (xcc_id))
-#define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q, vmid) (adev)->gfx.funcs->select_me_pipe_q((adev), (me), (pipe), (q), (vmid))
+#define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q, vmid, xcc_id) (adev)->gfx.funcs->select_me_pipe_q((adev), (me), (pipe), (q), (vmid), (xcc_id))
 #define amdgpu_gfx_init_spm_golden(adev) (adev)->gfx.funcs->init_spm_golden((adev))
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
index 919d9d401750..107f9bb0e24f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
@@ -35,17 +35,51 @@ struct amdgpu_debugfs_regs2_iocdata {
 	} srbm;
 };
 
+struct amdgpu_debugfs_regs2_iocdata_v2 {
+	__u32 use_srbm, use_grbm, pg_lock;
+	struct {
+		__u32 se, sh, instance;
+	} grbm;
+	struct {
+		__u32 me, pipe, queue, vmid;
+	} srbm;
+	u32 xcc_id;
+};
+
+struct amdgpu_debugfs_gprwave_iocdata {
+	u32 gpr_or_wave, se, sh, cu, wave, simd, xcc_id;
+	struct {
+		u32 thread, vpgr_or_sgpr;
+	} gpr;
+};
+
 /*
  * MMIO debugfs state data (per file* handle)
  */
 struct amdgpu_debugfs_regs2_data {
 	struct amdgpu_device *adev;
 	struct mutex lock;
-	struct amdgpu_debugfs_regs2_iocdata id;
+	struct amdgpu_debugfs_regs2_iocdata_v2 id;
+};
+
+struct amdgpu_debugfs_gprwave_data {
+	struct amdgpu_device *adev;
+	struct mutex lock;
+	struct amdgpu_debugfs_gprwave_iocdata id;
 };
 
 enum AMDGPU_DEBUGFS_REGS2_CMDS {
 	AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=0,
+	AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE_V2,
+};
+
+enum AMDGPU_DEBUGFS_GPRWAVE_CMDS {
+	AMDGPU_DEBUGFS_GPRWAVE_CMD_SET_STATE=0,
 };
 
+//reg2 interface
 #define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)
+#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE_V2 _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE_V2, struct amdgpu_debugfs_regs2_iocdata_v2)
+
+//gprwave interface
+#define AMDGPU_DEBUGFS_GPRWAVE_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_GPRWAVE_CMD_SET_STATE, struct amdgpu_debugfs_gprwave_iocdata)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ce421e77f7c5..9ef6b01ddb17 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4291,7 +4291,7 @@ static void wave_read_regs(struct amdgpu_device *adev, uint32_t wave,
 		*(out++) = RREG32_SOC15(GC, 0, mmSQ_IND_DATA);
 }
 
-static void gfx_v10_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
+static void gfx_v10_0_read_wave_data(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
 {
 	/* in gfx10 the SIMD_ID is specified as part of the INSTANCE
 	 * field when performing a select_se_sh so it should be
@@ -4318,7 +4318,7 @@ static void gfx_v10_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd,
 	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_MODE);
 }
 
-static void gfx_v10_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
+static void gfx_v10_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
 				     uint32_t wave, uint32_t start,
 				     uint32_t size, uint32_t *dst)
 {
@@ -4329,7 +4329,7 @@ static void gfx_v10_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
 		dst);
 }
 
-static void gfx_v10_0_read_wave_vgprs(struct amdgpu_device *adev, uint32_t simd,
+static void gfx_v10_0_read_wave_vgprs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
 				      uint32_t wave, uint32_t thread,
 				      uint32_t start, uint32_t size,
 				      uint32_t *dst)
@@ -4340,7 +4340,7 @@ static void gfx_v10_0_read_wave_vgprs(struct amdgpu_device *adev, uint32_t simd,
 }
 
 static void gfx_v10_0_select_me_pipe_q(struct amdgpu_device *adev,
-				       u32 me, u32 pipe, u32 q, u32 vm)
+				       u32 me, u32 pipe, u32 q, u32 vm, u32 xcc_id)
 {
 	nv_grbm_select(adev, me, pipe, q, vm);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8639b38fda6b..635df08f0ed5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -747,7 +747,7 @@ static void wave_read_regs(struct amdgpu_device *adev, uint32_t wave,
 		*(out++) = RREG32_SOC15(GC, 0, regSQ_IND_DATA);
 }
 
-static void gfx_v11_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
+static void gfx_v11_0_read_wave_data(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
 {
 	/* in gfx11 the SIMD_ID is specified as part of the INSTANCE
 	 * field when performing a select_se_sh so it should be
@@ -773,7 +773,7 @@ static void gfx_v11_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd,
 	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_MODE);
 }
 
-static void gfx_v11_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
+static void gfx_v11_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
 				     uint32_t wave, uint32_t start,
 				     uint32_t size, uint32_t *dst)
 {
@@ -784,7 +784,7 @@ static void gfx_v11_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
 		dst);
 }
 
-static void gfx_v11_0_read_wave_vgprs(struct amdgpu_device *adev, uint32_t simd,
+static void gfx_v11_0_read_wave_vgprs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
 				      uint32_t wave, uint32_t thread,
 				      uint32_t start, uint32_t size,
 				      uint32_t *dst)
@@ -795,7 +795,7 @@ static void gfx_v11_0_read_wave_vgprs(struct amdgpu_device *adev, uint32_t simd,
 }
 
 static void gfx_v11_0_select_me_pipe_q(struct amdgpu_device *adev,
-									  u32 me, u32 pipe, u32 q, u32 vm)
+					u32 me, u32 pipe, u32 q, u32 vm, u32 xcc_id)
 {
 	soc21_grbm_select(adev, me, pipe, q, vm);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index acacab1f67ef..3c6115d018c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2968,7 +2968,7 @@ static void wave_read_regs(struct amdgpu_device *adev, uint32_t simd,
 		*(out++) = RREG32(mmSQ_IND_DATA);
 }
 
-static void gfx_v6_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
+static void gfx_v6_0_read_wave_data(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
 {
 	/* type 0 wave data */
 	dst[(*no_fields)++] = 0;
@@ -2993,7 +2993,7 @@ static void gfx_v6_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd, u
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_MODE);
 }
 
-static void gfx_v6_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
+static void gfx_v6_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
 				     uint32_t wave, uint32_t start,
 				     uint32_t size, uint32_t *dst)
 {
@@ -3003,7 +3003,7 @@ static void gfx_v6_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
 }
 
 static void gfx_v6_0_select_me_pipe_q(struct amdgpu_device *adev,
-				  u32 me, u32 pipe, u32 q, u32 vm)
+				  u32 me, u32 pipe, u32 q, u32 vm, u32 xcc_id)
 {
 	DRM_INFO("Not implemented\n");
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index d56dda5fc588..0f0c12bbe228 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4112,7 +4112,7 @@ static void wave_read_regs(struct amdgpu_device *adev, uint32_t simd,
 		*(out++) = RREG32(mmSQ_IND_DATA);
 }
 
-static void gfx_v7_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
+static void gfx_v7_0_read_wave_data(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
 {
 	/* type 0 wave data */
 	dst[(*no_fields)++] = 0;
@@ -4137,7 +4137,7 @@ static void gfx_v7_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd, u
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_MODE);
 }
 
-static void gfx_v7_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
+static void gfx_v7_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
 				     uint32_t wave, uint32_t start,
 				     uint32_t size, uint32_t *dst)
 {
@@ -4147,7 +4147,7 @@ static void gfx_v7_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
 }
 
 static void gfx_v7_0_select_me_pipe_q(struct amdgpu_device *adev,
-				  u32 me, u32 pipe, u32 q, u32 vm)
+				  u32 me, u32 pipe, u32 q, u32 vm, u32 xcc_id)
 {
 	cik_srbm_select(adev, me, pipe, q, vm);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 278416acf060..9c9f92fcb79f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3419,7 +3419,7 @@ static void gfx_v8_0_select_se_sh(struct amdgpu_device *adev,
 }
 
 static void gfx_v8_0_select_me_pipe_q(struct amdgpu_device *adev,
-				  u32 me, u32 pipe, u32 q, u32 vm)
+				  u32 me, u32 pipe, u32 q, u32 vm, u32 xcc_id)
 {
 	vi_srbm_select(adev, me, pipe, q, vm);
 }
@@ -5217,7 +5217,7 @@ static void wave_read_regs(struct amdgpu_device *adev, uint32_t simd,
 		*(out++) = RREG32(mmSQ_IND_DATA);
 }
 
-static void gfx_v8_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
+static void gfx_v8_0_read_wave_data(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
 {
 	/* type 0 wave data */
 	dst[(*no_fields)++] = 0;
@@ -5242,7 +5242,7 @@ static void gfx_v8_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd, u
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_MODE);
 }
 
-static void gfx_v8_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
+static void gfx_v8_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
 				     uint32_t wave, uint32_t start,
 				     uint32_t size, uint32_t *dst)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 032f9fbd1a23..d4270c30aab5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1778,7 +1778,7 @@ static void wave_read_regs(struct amdgpu_device *adev, uint32_t simd,
 		*(out++) = RREG32_SOC15(GC, 0, mmSQ_IND_DATA);
 }
 
-static void gfx_v9_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
+static void gfx_v9_0_read_wave_data(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
 {
 	/* type 1 wave data */
 	dst[(*no_fields)++] = 1;
@@ -1799,7 +1799,7 @@ static void gfx_v9_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd, u
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_MODE);
 }
 
-static void gfx_v9_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
+static void gfx_v9_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
 				     uint32_t wave, uint32_t start,
 				     uint32_t size, uint32_t *dst)
 {
@@ -1808,7 +1808,7 @@ static void gfx_v9_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
 		start + SQIND_WAVE_SGPRS_OFFSET, size, dst);
 }
 
-static void gfx_v9_0_read_wave_vgprs(struct amdgpu_device *adev, uint32_t simd,
+static void gfx_v9_0_read_wave_vgprs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
 				     uint32_t wave, uint32_t thread,
 				     uint32_t start, uint32_t size,
 				     uint32_t *dst)
@@ -1819,7 +1819,7 @@ static void gfx_v9_0_read_wave_vgprs(struct amdgpu_device *adev, uint32_t simd,
 }
 
 static void gfx_v9_0_select_me_pipe_q(struct amdgpu_device *adev,
-				  u32 me, u32 pipe, u32 q, u32 vm)
+				  u32 me, u32 pipe, u32 q, u32 vm, u32 xcc_id)
 {
 	soc15_grbm_select(adev, me, pipe, q, vm, 0);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index ca55e522a168..40d4123de54e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -541,21 +541,21 @@ static void gfx_v9_4_3_select_se_sh(struct amdgpu_device *adev,
 	WREG32_SOC15_RLC_SHADOW_EX(reg, GC, GET_INST(GC, xcc_id), regGRBM_GFX_INDEX, data);
 }
 
-static uint32_t wave_read_ind(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t address)
+static uint32_t wave_read_ind(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd, uint32_t wave, uint32_t address)
 {
-	WREG32_SOC15_RLC(GC, GET_INST(GC, 0), regSQ_IND_INDEX,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSQ_IND_INDEX,
 		(wave << SQ_IND_INDEX__WAVE_ID__SHIFT) |
 		(simd << SQ_IND_INDEX__SIMD_ID__SHIFT) |
 		(address << SQ_IND_INDEX__INDEX__SHIFT) |
 		(SQ_IND_INDEX__FORCE_READ_MASK));
-	return RREG32_SOC15(GC, GET_INST(GC, 0), regSQ_IND_DATA);
+	return RREG32_SOC15(GC, GET_INST(GC, xcc_id), regSQ_IND_DATA);
 }
 
-static void wave_read_regs(struct amdgpu_device *adev, uint32_t simd,
+static void wave_read_regs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
 			   uint32_t wave, uint32_t thread,
 			   uint32_t regno, uint32_t num, uint32_t *out)
 {
-	WREG32_SOC15_RLC(GC, GET_INST(GC, 0), regSQ_IND_INDEX,
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSQ_IND_INDEX,
 		(wave << SQ_IND_INDEX__WAVE_ID__SHIFT) |
 		(simd << SQ_IND_INDEX__SIMD_ID__SHIFT) |
 		(regno << SQ_IND_INDEX__INDEX__SHIFT) |
@@ -563,53 +563,53 @@ static void wave_read_regs(struct amdgpu_device *adev, uint32_t simd,
 		(SQ_IND_INDEX__FORCE_READ_MASK) |
 		(SQ_IND_INDEX__AUTO_INCR_MASK));
 	while (num--)
-		*(out++) = RREG32_SOC15(GC, GET_INST(GC, 0), regSQ_IND_DATA);
+		*(out++) = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regSQ_IND_DATA);
 }
 
 static void gfx_v9_4_3_read_wave_data(struct amdgpu_device *adev,
-				      uint32_t simd, uint32_t wave,
+				      uint32_t xcc_id, uint32_t simd, uint32_t wave,
 				      uint32_t *dst, int *no_fields)
 {
 	/* type 1 wave data */
 	dst[(*no_fields)++] = 1;
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_STATUS);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_HW_ID);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW0);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW1);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_GPR_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_LDS_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TRAPSTS);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_STS);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_DBG0);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_M0);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_MODE);
-}
-
-static void gfx_v9_4_3_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
+	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_STATUS);
+	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_PC_LO);
+	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_PC_HI);
+	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_EXEC_LO);
+	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_EXEC_HI);
+	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_HW_ID);
+	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_INST_DW0);
+	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_INST_DW1);
+	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_GPR_ALLOC);
+	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_LDS_ALLOC);
+	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_TRAPSTS);
+	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_IB_STS);
+	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_IB_DBG0);
+	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_M0);
+	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_MODE);
+}
+
+static void gfx_v9_4_3_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
 				       uint32_t wave, uint32_t start,
 				       uint32_t size, uint32_t *dst)
 {
-	wave_read_regs(adev, simd, wave, 0,
+	wave_read_regs(adev, xcc_id, simd, wave, 0,
 		       start + SQIND_WAVE_SGPRS_OFFSET, size, dst);
 }
 
-static void gfx_v9_4_3_read_wave_vgprs(struct amdgpu_device *adev, uint32_t simd,
+static void gfx_v9_4_3_read_wave_vgprs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
 				       uint32_t wave, uint32_t thread,
 				       uint32_t start, uint32_t size,
 				       uint32_t *dst)
 {
-	wave_read_regs(adev, simd, wave, thread,
+	wave_read_regs(adev, xcc_id, simd, wave, thread,
 		       start + SQIND_WAVE_VGPRS_OFFSET, size, dst);
 }
 
 static void gfx_v9_4_3_select_me_pipe_q(struct amdgpu_device *adev,
-					u32 me, u32 pipe, u32 q, u32 vm)
+					u32 me, u32 pipe, u32 q, u32 vm, u32 xcc_id)
 {
-	soc15_grbm_select(adev, me, pipe, q, vm, GET_INST(GC, 0));
+	soc15_grbm_select(adev, me, pipe, q, vm, GET_INST(GC, xcc_id));
 }
 
 static enum amdgpu_gfx_partition
-- 
2.39.2

