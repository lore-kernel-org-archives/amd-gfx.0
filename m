Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACF7C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Oct 2022 18:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7284910E2C5;
	Mon,  3 Oct 2022 18:38:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E8910E467
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Oct 2022 18:38:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihAXyHYsx+DsypcMw3dgnbopYuVZniRK5OAtR52NBXTX7QNg85TdG3aYJoPsSCsKeyJsUrEYu2nP4nda4sv457cuCsg3MAs5fF3THZahBGGdy35R8/YJ/AY6h7LRlGTVYDEtegp5WaCL0Xsh73ZQQ1vSVhZvZuE7rMmyuOEiklBnQi0LQqLTrZT0SXKrVw6LbIsadrK9beqtWLOPkAhLD3G4NXtFiGjGEA2UaihPknsGEZMMSnh/xVmXcyoLxua0GJ4SA+KTZ/RuLnstwDX9cVrXG9f7ETP0uW/Rc8Z2vTdT57/DUazovr9G7eansd/1BnRpU2IbuGoqFjWZbRTqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuwqXkuX8/nc6/FAodcBb8vkrPPnCCkfjATe8jSYevA=;
 b=Do14SIAc61J5Qjz5Kqq+js2NpJZF5tQd6ca5AGji9K14gVzy4uy7T92kWTyHgs2ZQi7bfrnxtXgagsi1wOpswBRXdd34qj1xry9C+aTC91nKnhgvT905Pf7Ln0jpiptdox4UK4DPkP5TKhkVOmzQNv6Ga2MWZu654xOXoBPmRs8AGJvnQmrIn2BHdnUI5S5v06zi6RraOa1+SRAGeBi3KCVTfBvm7uEnX9yORB4GELcMifN/Ei5MKpIz3DwYKkgPO/W4lL330tJt2UVR6ilyC45cVVGU1WRVHsMrwmysRB5SIRj12ZBRJh3J9sGPZ9u+IoHRoqyhk89FB3Kfzq5Tbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuwqXkuX8/nc6/FAodcBb8vkrPPnCCkfjATe8jSYevA=;
 b=usZInHabiRQmJYpovfyVRgXio8raKv9XFMsrjc8kQhLnB9Jf+hAe5JrG+8PfrVwXcJHjMDnjLEqq8e0WN3RTP19IkYlakSC6iO/xYmMI2lbUGWRxifw8SSuK7LblV5tUF24uO8L9DqLd8czzUaPPIrvcpdpDMDUqUXbf3fLPn4s=
Received: from BN9PR03CA0118.namprd03.prod.outlook.com (2603:10b6:408:fd::33)
 by MN0PR12MB6344.namprd12.prod.outlook.com (2603:10b6:208:3d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.30; Mon, 3 Oct
 2022 18:38:51 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::88) by BN9PR03CA0118.outlook.office365.com
 (2603:10b6:408:fd::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Mon, 3 Oct 2022 18:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Mon, 3 Oct 2022 18:38:51 +0000
Received: from tstdenis.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 3 Oct
 2022 13:38:48 -0500
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Update debugfs SRBM/GRBM logic
Date: Mon, 3 Oct 2022 14:38:24 -0400
Message-ID: <20221003183824.585893-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|MN0PR12MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e8ddbed-67d1-40d1-ea86-08daa56e847e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1lhpeKzZrmPhdEaEAVpEeuX1EVJiFOa3YyFvBCIZMaIhSVRr+Cmy7JP6jLNCnUSiKW9NmBYTv1oi1567zCL4uVz3CW43B4Wh7sP5ihlmFSNRNOo8oR+LUkzerXCg7D0hepUm/1+GPIFsye6mfrcy/kILDFFXrg7XSD1dTu3eaEle5xYai45THPqzZiWnTfo65V5zI9lRolME4SQ9Fxtm/JStSCLJ3qon++gXGNuu5Ua1s3WHMdvdYgr0+nWzaic0vSk66O5JlKMBdAX9m7YOMko89R8aeaPujHFOfjcET2wdhJ7ldU3rbNzOUZXHxSXa8/pizqxbNw1OiEsCGofIudIfZTLjOCfeizjIwbexZvZVylV5In5Dgw1w7a1BAezUNLlyuD6engDWCfrI3FGTEBgueqjl/ueEV2ICwQ5gdEqb7/7/NZULwAN9Infn2jhuRnwgnXAIs2qA9J4HpontE9W6yVPExEVRrw5l454bWL9L2sUjykw10PT7Y6KcxSUMCY+ToWbLgH7Tuto4txHbX/6loXtYBZvSiTOHQjlnPXjU679KyN1s1G8zDkTJRv7jad6hTWNMAJJVjyIhmJYNzzPC+RvObtCOZuTMkorZGkzswtG8O3LiHKsFuekb9oQOEoyKro7FOZ9+e0CwOE1n8Ya2RZg7tkK6XIm7+34p5FdT7fUqOM9blkXj90+UOoM55MOGCXvRp8h/1oL2gEPz920a7/t5h+wkuzi6L8iSi1TIEN6dSNryHaU+5hnJhOUBoVkZLv0ea9Atn4eAaglA443BWdKwlwGBcvoPwaYTCUc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(26005)(8936002)(36756003)(7696005)(86362001)(16526019)(336012)(6666004)(41300700001)(81166007)(30864003)(40480700001)(40460700003)(2906002)(5660300002)(15650500001)(426003)(478600001)(82310400005)(2616005)(83380400001)(47076005)(1076003)(186003)(70206006)(4326008)(70586007)(8676002)(356005)(36860700001)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 18:38:51.2367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8ddbed-67d1-40d1-ea86-08daa56e847e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6344
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently our debugfs bank selection logic only
supports a single GC instance.  This updates the functions
amdgpu_gfx_select_se_sh() and amdgpu_gfx_select_me_pipe_q()
to support a GC instance parameter and ultimately a GC
instance selection via the IOCTL to debugfs.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 44 +++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h     |  7 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h     | 15 ++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      | 17 ++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      | 17 ++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 18 +++++++--
 9 files changed, 98 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 6066aebf491c..3a09028277f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -139,7 +139,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 					sh_bank, instance_bank);
 	} else if (use_ring) {
 		mutex_lock(&adev->srbm_mutex);
-		amdgpu_gfx_select_me_pipe_q(adev, me, pipe, queue, vmid);
+		amdgpu_gfx_select_me_pipe_q(adev, me, pipe, queue, vmid, 0);
 	}
 
 	if (pm_pg_lock)
@@ -172,7 +172,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
 		mutex_unlock(&adev->grbm_idx_mutex);
 	} else if (use_ring) {
-		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 	}
 
@@ -261,15 +261,15 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
 			return -EINVAL;
 		}
 		mutex_lock(&adev->grbm_idx_mutex);
-		amdgpu_gfx_select_se_sh(adev, rd->id.grbm.se,
+		amdgpu_gfx_select_se_sh_instanced(adev, rd->id.grbm.se,
 								rd->id.grbm.sh,
-								rd->id.grbm.instance);
+								rd->id.grbm.instance, rd->id.gc_instance);
 	}
 
 	if (rd->id.use_srbm) {
 		mutex_lock(&adev->srbm_mutex);
 		amdgpu_gfx_select_me_pipe_q(adev, rd->id.srbm.me, rd->id.srbm.pipe,
-									rd->id.srbm.queue, rd->id.srbm.vmid);
+									rd->id.srbm.queue, rd->id.srbm.vmid, rd->id.gc_instance);
 	}
 
 	if (rd->id.pg_lock)
@@ -295,12 +295,12 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
 	}
 end:
 	if (rd->id.use_grbm) {
-		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+		amdgpu_gfx_select_se_sh_instanced(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 		mutex_unlock(&adev->grbm_idx_mutex);
 	}
 
 	if (rd->id.use_srbm) {
-		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 	}
 
@@ -319,17 +319,39 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
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
+			return r ? -EINVAL : 0;
+		goto done;
 	case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
-		mutex_lock(&rd->lock);
-		r = copy_from_user(&rd->id, (struct amdgpu_debugfs_regs2_iocdata *)data, sizeof rd->id);
-		mutex_unlock(&rd->lock);
-		return r ? -EINVAL : 0;
+		r = copy_from_user(&v1_data, (struct amdgpu_debugfs_regs2_iocdata *)data, sizeof v1_data);
+		if (r)
+			return r ? -EINVAL : 0;
+		goto v1_copy;
 	default:
 		return -EINVAL;
 	}
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
+	rd->id.gc_instance = 0;
+done:
+	mutex_unlock(&rd->lock);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 832b3807f1d6..e6e722a30f08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -216,6 +216,8 @@ struct amdgpu_gfx_funcs {
 	uint64_t (*get_gpu_clock_counter)(struct amdgpu_device *adev);
 	void (*select_se_sh)(struct amdgpu_device *adev, u32 se_num,
 			     u32 sh_num, u32 instance);
+	void (*select_se_sh_instanced)(struct amdgpu_device *adev, u32 se_num,
+			     u32 sh_num, u32 instance, u32 gc_inst);
 	void (*read_wave_data)(struct amdgpu_device *adev, uint32_t simd,
 			       uint32_t wave, uint32_t *dst, int *no_fields);
 	void (*read_wave_vgprs)(struct amdgpu_device *adev, uint32_t simd,
@@ -225,7 +227,7 @@ struct amdgpu_gfx_funcs {
 				uint32_t wave, uint32_t start, uint32_t size,
 				uint32_t *dst);
 	void (*select_me_pipe_q)(struct amdgpu_device *adev, u32 me, u32 pipe,
-				 u32 queue, u32 vmid);
+				 u32 queue, u32 vmid, u32 instance);
 	void (*init_spm_golden)(struct amdgpu_device *adev);
 	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
 };
@@ -356,7 +358,8 @@ struct amdgpu_gfx {
 
 #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
 #define amdgpu_gfx_select_se_sh(adev, se, sh, instance) (adev)->gfx.funcs->select_se_sh((adev), (se), (sh), (instance))
-#define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q, vmid) (adev)->gfx.funcs->select_me_pipe_q((adev), (me), (pipe), (q), (vmid))
+#define amdgpu_gfx_select_se_sh_instanced(adev, se, sh, instance, gc_inst) (adev)->gfx.funcs->select_se_sh_instanced ? (adev)->gfx.funcs->select_se_sh_instanced((adev), (se), (sh), (instance), (gc_inst)) : (adev)->gfx.funcs->select_se_sh((adev), (se), (sh), (instance))
+#define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q, vmid, instance) (adev)->gfx.funcs->select_me_pipe_q((adev), (me), (pipe), (q), (vmid), (instance))
 #define amdgpu_gfx_init_spm_golden(adev) (adev)->gfx.funcs->init_spm_golden((adev))
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
index 919d9d401750..a49519e6a3c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
@@ -35,17 +35,30 @@ struct amdgpu_debugfs_regs2_iocdata {
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
+	u32 gc_instance;
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
 };
 
 enum AMDGPU_DEBUGFS_REGS2_CMDS {
 	AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=0,
+	AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE_V2,
 };
 
 #define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)
+#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE_V2 _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE_V2, struct amdgpu_debugfs_regs2_iocdata_v2)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index af94ac580d3e..e47b51374f95 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3506,6 +3506,8 @@ static void gfx_v10_3_set_power_brake_sequence(struct amdgpu_device *adev);
 static void gfx_v10_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 					   uint16_t pasid, uint32_t flush_type,
 					   bool all_hub, uint8_t dst_sel);
+static void gfx_v10_0_select_se_sh_instanced(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
+			   u32 instance, u32 gc_inst);
 
 static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
 {
@@ -4417,7 +4419,7 @@ static void gfx_v10_0_read_wave_vgprs(struct amdgpu_device *adev, uint32_t simd,
 }
 
 static void gfx_v10_0_select_me_pipe_q(struct amdgpu_device *adev,
-				       u32 me, u32 pipe, u32 q, u32 vm)
+				       u32 me, u32 pipe, u32 q, u32 vm, u32 instance)
 {
 	nv_grbm_select(adev, me, pipe, q, vm);
 }
@@ -4441,6 +4443,7 @@ static void gfx_v10_0_update_perfmon_mgcg(struct amdgpu_device *adev,
 static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v10_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v10_0_select_se_sh,
+	.select_se_sh_instanced = &gfx_v10_0_select_se_sh_instanced,
 	.read_wave_data = &gfx_v10_0_read_wave_data,
 	.read_wave_sgprs = &gfx_v10_0_read_wave_sgprs,
 	.read_wave_vgprs = &gfx_v10_0_read_wave_vgprs,
@@ -4790,8 +4793,8 @@ static int gfx_v10_0_sw_fini(void *handle)
 	return 0;
 }
 
-static void gfx_v10_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
-				   u32 sh_num, u32 instance)
+static void gfx_v10_0_select_se_sh_instanced(struct amdgpu_device *adev, u32 se_num,
+				   u32 sh_num, u32 instance, u32 gc_inst)
 {
 	u32 data;
 
@@ -4814,7 +4817,13 @@ static void gfx_v10_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 	else
 		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SA_INDEX, sh_num);
 
-	WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
+	WREG32_SOC15(GC, gc_inst, mmGRBM_GFX_INDEX, data);
+}
+
+static void gfx_v10_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
+				   u32 sh_num, u32 instance)
+{
+	gfx_v10_0_select_se_sh_instanced(adev, se_num, sh_num, instance, 0);
 }
 
 static u32 gfx_v10_0_get_rb_active_bitmap(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 251109723ab6..d970390be94a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -122,6 +122,8 @@ static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev);
 static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev);
 static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
+static void gfx_v11_0_select_se_sh_instanced(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
+			   u32 instance, u32 gc_inst);
 
 static void gfx11_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
 {
@@ -826,7 +828,7 @@ static void gfx_v11_0_read_wave_vgprs(struct amdgpu_device *adev, uint32_t simd,
 }
 
 static void gfx_v11_0_select_me_pipe_q(struct amdgpu_device *adev,
-									  u32 me, u32 pipe, u32 q, u32 vm)
+									  u32 me, u32 pipe, u32 q, u32 vm, u32 instance)
 {
 	soc21_grbm_select(adev, me, pipe, q, vm);
 }
@@ -834,6 +836,7 @@ static void gfx_v11_0_select_me_pipe_q(struct amdgpu_device *adev,
 static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v11_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v11_0_select_se_sh,
+	.select_se_sh_instanced = &gfx_v11_0_select_se_sh_instanced,
 	.read_wave_data = &gfx_v11_0_read_wave_data,
 	.read_wave_sgprs = &gfx_v11_0_read_wave_sgprs,
 	.read_wave_vgprs = &gfx_v11_0_read_wave_vgprs,
@@ -1477,8 +1480,8 @@ static int gfx_v11_0_sw_fini(void *handle)
 	return 0;
 }
 
-static void gfx_v11_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
-				   u32 sh_num, u32 instance)
+static void gfx_v11_0_select_se_sh_instanced(struct amdgpu_device *adev, u32 se_num,
+				   u32 sh_num, u32 instance, u32 gc_inst)
 {
 	u32 data;
 
@@ -1501,7 +1504,13 @@ static void gfx_v11_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 	else
 		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SA_INDEX, sh_num);
 
-	WREG32_SOC15(GC, 0, regGRBM_GFX_INDEX, data);
+	WREG32_SOC15(GC, gc_inst, regGRBM_GFX_INDEX, data);
+}
+
+static void gfx_v11_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
+				   u32 sh_num, u32 instance)
+{
+	gfx_v11_0_select_se_sh_instanced(adev, se_num, sh_num, instance, 0);
 }
 
 static u32 gfx_v11_0_get_rb_active_bitmap(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 204b246f0e3f..3fc7edd160d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3016,7 +3016,7 @@ static void gfx_v6_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
 }
 
 static void gfx_v6_0_select_me_pipe_q(struct amdgpu_device *adev,
-				  u32 me, u32 pipe, u32 q, u32 vm)
+				  u32 me, u32 pipe, u32 q, u32 vm, u32 instance)
 {
 	DRM_INFO("Not implemented\n");
 }
@@ -3024,6 +3024,7 @@ static void gfx_v6_0_select_me_pipe_q(struct amdgpu_device *adev,
 static const struct amdgpu_gfx_funcs gfx_v6_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v6_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v6_0_select_se_sh,
+	.select_se_sh_instanced = NULL,
 	.read_wave_data = &gfx_v6_0_read_wave_data,
 	.read_wave_sgprs = &gfx_v6_0_read_wave_sgprs,
 	.select_me_pipe_q = &gfx_v6_0_select_me_pipe_q
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 0f2976507e48..162a64b45472 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4179,7 +4179,7 @@ static void gfx_v7_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
 }
 
 static void gfx_v7_0_select_me_pipe_q(struct amdgpu_device *adev,
-				  u32 me, u32 pipe, u32 q, u32 vm)
+				  u32 me, u32 pipe, u32 q, u32 vm, u32 instance)
 {
 	cik_srbm_select(adev, me, pipe, q, vm);
 }
@@ -4187,6 +4187,7 @@ static void gfx_v7_0_select_me_pipe_q(struct amdgpu_device *adev,
 static const struct amdgpu_gfx_funcs gfx_v7_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v7_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v7_0_select_se_sh,
+	.select_se_sh_instanced = NULL,
 	.read_wave_data = &gfx_v7_0_read_wave_data,
 	.read_wave_sgprs = &gfx_v7_0_read_wave_sgprs,
 	.select_me_pipe_q = &gfx_v7_0_select_me_pipe_q
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 7f0b18b0d4c4..221fec5234c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3444,7 +3444,7 @@ static void gfx_v8_0_select_se_sh(struct amdgpu_device *adev,
 }
 
 static void gfx_v8_0_select_me_pipe_q(struct amdgpu_device *adev,
-				  u32 me, u32 pipe, u32 q, u32 vm)
+				  u32 me, u32 pipe, u32 q, u32 vm, u32 instance)
 {
 	vi_srbm_select(adev, me, pipe, q, vm);
 }
@@ -5279,6 +5279,7 @@ static void gfx_v8_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
 static const struct amdgpu_gfx_funcs gfx_v8_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v8_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v8_0_select_se_sh,
+	.select_se_sh_instanced = NULL,
 	.read_wave_data = &gfx_v8_0_read_wave_data,
 	.read_wave_sgprs = &gfx_v8_0_read_wave_sgprs,
 	.select_me_pipe_q = &gfx_v8_0_select_me_pipe_q
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 0320be4a5fc6..264213977986 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -761,6 +761,9 @@ static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
 				     void *inject_if);
 static void gfx_v9_0_reset_ras_error_count(struct amdgpu_device *adev);
 
+static void gfx_v9_0_select_se_sh_instanced(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
+			   u32 instance, u32 gc_inst);
+
 static void gfx_v9_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 				uint64_t queue_mask)
 {
@@ -1888,7 +1891,7 @@ static void gfx_v9_0_read_wave_vgprs(struct amdgpu_device *adev, uint32_t simd,
 }
 
 static void gfx_v9_0_select_me_pipe_q(struct amdgpu_device *adev,
-				  u32 me, u32 pipe, u32 q, u32 vm)
+				  u32 me, u32 pipe, u32 q, u32 vm, u32 instance)
 {
 	soc15_grbm_select(adev, me, pipe, q, vm);
 }
@@ -1896,6 +1899,7 @@ static void gfx_v9_0_select_me_pipe_q(struct amdgpu_device *adev,
 static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
         .get_gpu_clock_counter = &gfx_v9_0_get_gpu_clock_counter,
         .select_se_sh = &gfx_v9_0_select_se_sh,
+	.select_se_sh_instanced = &gfx_v9_0_select_se_sh_instanced,
         .read_wave_data = &gfx_v9_0_read_wave_data,
         .read_wave_sgprs = &gfx_v9_0_read_wave_sgprs,
         .read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
@@ -2274,8 +2278,8 @@ static void gfx_v9_0_tiling_mode_table_init(struct amdgpu_device *adev)
 	/* TODO */
 }
 
-void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
-			   u32 instance)
+static void gfx_v9_0_select_se_sh_instanced(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
+			   u32 instance, u32 gc_inst)
 {
 	u32 data;
 
@@ -2294,7 +2298,13 @@ void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
 	else
 		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SH_INDEX, sh_num);
 
-	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_INDEX, data);
+	WREG32_SOC15_RLC_SHADOW(GC, gc_inst, mmGRBM_GFX_INDEX, data);
+}
+
+void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
+			   u32 instance)
+{
+	gfx_v9_0_select_se_sh_instanced(adev, se_num, sh_num, instance, 0);
 }
 
 static u32 gfx_v9_0_get_rb_active_bitmap(struct amdgpu_device *adev)
-- 
2.34.1

