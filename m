Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51A7C761A6
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CF7310E72A;
	Mon, 27 Mar 2023 19:36:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9007910E720
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izaZ/k6/Uqs+/RK5AHmdMANGcjBPE/epAWmgwmvB8UjBrJE5+d62d4gVK2MbdaIVA+DcJdTgWJ49GsGgPMA6oESk02md06OjyXrFBtfmlRZwSkuB8Xu0TJm2gwQCKjXp7qU9Yyv/MMhSh7AFUfJ/hMUfkU5/mKkspft0WRKQEakUPsFsFKI2BRoiJWOiUvyfSBfhmFHcvt4wHaRJo25YP8vABn8QKJGeB6Dgy1SIb58hPhEedCZExo0ZyQ2sBCkVv4QO3wj/UNAMJV2evQpChCC0C/jim17kGwaiDDTbFGg5Tdivg5ratqIWdSWbDDqKnIEoE2Yeyf4SZajcxi1eZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8mETfMroVfQAbaHMDOsX+xgPKAGZ1V81jmyqf9SJAk=;
 b=KjTKWXFLvp5piYi7EKJOM0UCiu43aUi7eVPzUUroynH6R9F4Kfza+4lnzFjCKKWkHyUfClz4o65YHNsg3A+MRJAtkNTL4OGZbDbNdXY44XOETBdms2GmrXznS+5PUNCkMuXrchqXp7ctot/A0lP9ctz8op9GouAH3Zp5mBQFS8N3iIolpRPufV1Al6oJ1UUT/bYAbafiHrfZf4ENxKquPiQwcMNZU2Tc9f7HoHzCrg3uglobChg0+UFdfCgAOzmmfJcQc2y1jV8mO6R5zmRbg5Y/3Q8YZqS3AGJguoSVSwPpZDzp18o6Q8B991l2CyjFbkqHuXdgk/zpkHktMFl2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8mETfMroVfQAbaHMDOsX+xgPKAGZ1V81jmyqf9SJAk=;
 b=wF09NHvgH9PTAKFd2i77ZKZpwQv5Z+p5HanOACUnyQO5l3/n/zJiC+v5PzcCO232aEZg58OKxxsadkVTumuUNV1wpKk9M0giO6CmmTQ/128TqtP/socugPl2Olppv5Sn9LYTf0VTpkcjDPB9RombELNBxRLnQ/dkSrqyU+SZciE=
Received: from BN8PR15CA0052.namprd15.prod.outlook.com (2603:10b6:408:80::29)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:36:28 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::16) by BN8PR15CA0052.outlook.office365.com
 (2603:10b6:408:80::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/28] drm/amdgpu: add xcc index argument to select_sh_se
 function v2
Date: Mon, 27 Mar 2023 15:35:45 -0400
Message-ID: <20230327193602.7901-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: a17bebdc-f8fb-434e-28c1-08db2efa8f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XIBPjR29kUJHT3bCNZzUwNSgi+mZVfovwckQYtZtdxWN8wUhP2BypS+CBwXDgmmlYw10K95SJJd45Q75DUEEg0mwbXWUUvnCdzDrmrJw6Ml3L0nqFrw3948LgS5xBGld3Af97jfylEESuM+v/OuWyMVS2zLHs0ZlNHNzLpiMnaOSSAC2BOYGzKWwESYHn12MlveDmKWizG50hAA1bW4urm8n6md+wRGuj/iETClfwL+i2J++p4Qvwwy96+IYubeqZJQy3Bkft2g25Mjz7y8gj3NsNyRsYvX1IvQILPFwF73PCJLfnASAP9qJIgO/wsXD7d2syuy6RToUTwaWoLOGj37JoeDaHhCK8gnz4p291kndOnUkcsLWrkfu5x66KYiu85qjBi5/8JgN3N83hjdONxd1N21EakkMGNOwi7fK1PzWY4YLEjqwTF484WaddSBv+lBItGq8fale9FYsETpGz/UPYqP0Tlo6LWLxjcngFekYocSbSAaZzo7AELrdjt6Ml8P0nPjXfL4xSskUO66kd8y0sb6nIf9VNl8PqxUcg7M6/xDJR7wi5F2Afw12r4pwYnop+bCnRZ1lPGGJVBkotSEToutpAGhNI9uaa0jCp3MN0r5nNz8KLb6E7KQ+lHLNhiBHtzfZIJE0cF+1u68A5mopc7RVPVkJa9cmK8TKjuL7n/4LSRAsKKH7H5VSFps2jRdWCkCEGj+u02pAKV9KEkPghMlyivZRZAjfqkcS8nr8xlbpPI+rMOMBTBUam2WsATj+7hEjIqkc+eICcdl7TQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(6666004)(2616005)(356005)(7696005)(86362001)(426003)(40460700003)(40480700001)(47076005)(70586007)(8676002)(82740400003)(82310400005)(41300700001)(54906003)(186003)(70206006)(16526019)(36756003)(478600001)(36860700001)(336012)(316002)(26005)(6916009)(4326008)(83380400001)(2906002)(5660300002)(1076003)(30864003)(8936002)(81166007)(21314003)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:27.8966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a17bebdc-f8fb-434e-28c1-08db2efa8f08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

v1: To support multiple XCD case (Le)
v2: introduce xcc index to gfx_v11_0_select_sh_se (Hawking)

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   | 16 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  4 +--
 drivers/gpu/drm/amd/amdgpu/cik.c              |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 16 ++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  8 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         | 24 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         | 33 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 33 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 30 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 20 ++++++-----
 drivers/gpu/drm/amd/amdgpu/nv.c               |  4 +--
 drivers/gpu/drm/amd/amdgpu/si.c               |  4 +--
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  4 +--
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  4 +--
 drivers/gpu/drm/amd/amdgpu/vi.c               |  4 +--
 18 files changed, 110 insertions(+), 106 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index ebb35633058c..ae06d1f2af93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -787,7 +787,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 	for (se_idx = 0; se_idx < se_cnt; se_idx++) {
 		for (sh_idx = 0; sh_idx < sh_cnt; sh_idx++) {
 
-			amdgpu_gfx_select_se_sh(adev, se_idx, sh_idx, 0xffffffff);
+			amdgpu_gfx_select_se_sh(adev, se_idx, sh_idx, 0xffffffff, 0);
 			queue_map = RREG32_SOC15(GC, 0, mmSPI_CSQ_WF_ACTIVE_STATUS);
 
 			/*
@@ -820,7 +820,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 		}
 	}
 
-	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 	unlock_spi_csq_mutexes(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 0f16d3c09309..547abe155820 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -136,7 +136,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 		}
 		mutex_lock(&adev->grbm_idx_mutex);
 		amdgpu_gfx_select_se_sh(adev, se_bank,
-					sh_bank, instance_bank);
+					sh_bank, instance_bank, 0);
 	} else if (use_ring) {
 		mutex_lock(&adev->srbm_mutex);
 		amdgpu_gfx_select_me_pipe_q(adev, me, pipe, queue, vmid);
@@ -169,7 +169,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 
 end:
 	if (use_bank) {
-		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 		mutex_unlock(&adev->grbm_idx_mutex);
 	} else if (use_ring) {
 		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
@@ -263,7 +263,7 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
 		mutex_lock(&adev->grbm_idx_mutex);
 		amdgpu_gfx_select_se_sh(adev, rd->id.grbm.se,
 								rd->id.grbm.sh,
-								rd->id.grbm.instance);
+								rd->id.grbm.instance, 0);
 	}
 
 	if (rd->id.use_srbm) {
@@ -295,7 +295,7 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
 	}
 end:
 	if (rd->id.use_grbm) {
-		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 		mutex_unlock(&adev->grbm_idx_mutex);
 	}
 
@@ -907,13 +907,13 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
 
 	/* switch to the specific se/sh/cu */
 	mutex_lock(&adev->grbm_idx_mutex);
-	amdgpu_gfx_select_se_sh(adev, se, sh, cu);
+	amdgpu_gfx_select_se_sh(adev, se, sh, cu, 0);
 
 	x = 0;
 	if (adev->gfx.funcs->read_wave_data)
 		adev->gfx.funcs->read_wave_data(adev, simd, wave, data, &x);
 
-	amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
+	amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
@@ -1001,7 +1001,7 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 
 	/* switch to the specific se/sh/cu */
 	mutex_lock(&adev->grbm_idx_mutex);
-	amdgpu_gfx_select_se_sh(adev, se, sh, cu);
+	amdgpu_gfx_select_se_sh(adev, se, sh, cu, 0);
 
 	if (bank == 0) {
 		if (adev->gfx.funcs->read_wave_vgprs)
@@ -1011,7 +1011,7 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 			adev->gfx.funcs->read_wave_sgprs(adev, simd, wave, offset, size>>2, data);
 	}
 
-	amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
+	amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index a9e41d7970ea..1f7010041431 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -237,7 +237,7 @@ struct amdgpu_gfx_funcs {
 	/* get the gpu clock counter */
 	uint64_t (*get_gpu_clock_counter)(struct amdgpu_device *adev);
 	void (*select_se_sh)(struct amdgpu_device *adev, u32 se_num,
-			     u32 sh_num, u32 instance);
+			     u32 sh_num, u32 instance, int xcc_id);
 	void (*read_wave_data)(struct amdgpu_device *adev, uint32_t simd,
 			       uint32_t wave, uint32_t *dst, int *no_fields);
 	void (*read_wave_vgprs)(struct amdgpu_device *adev, uint32_t simd,
@@ -386,7 +386,7 @@ struct amdgpu_gfx {
 };
 
 #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
-#define amdgpu_gfx_select_se_sh(adev, se, sh, instance) (adev)->gfx.funcs->select_se_sh((adev), (se), (sh), (instance))
+#define amdgpu_gfx_select_se_sh(adev, se, sh, instance, xcc_id) (adev)->gfx.funcs->select_se_sh((adev), (se), (sh), (instance), (xcc_id))
 #define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q, vmid) (adev)->gfx.funcs->select_me_pipe_q((adev), (me), (pipe), (q), (vmid))
 #define amdgpu_gfx_init_spm_golden(adev) (adev)->gfx.funcs->init_spm_golden((adev))
 
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index de6d10390ab2..5641cf05d856 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1141,12 +1141,12 @@ static uint32_t cik_get_register_value(struct amdgpu_device *adev,
 
 		mutex_lock(&adev->grbm_idx_mutex);
 		if (se_num != 0xffffffff || sh_num != 0xffffffff)
-			amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff);
+			amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
 
 		val = RREG32(reg_offset);
 
 		if (se_num != 0xffffffff || sh_num != 0xffffffff)
-			amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+			amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 		mutex_unlock(&adev->grbm_idx_mutex);
 		return val;
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index accc0a7251b9..323f5b8927ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3490,7 +3490,7 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
 				 struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev);
 static void gfx_v10_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
-				   u32 sh_num, u32 instance);
+				   u32 sh_num, u32 instance, int xcc_id);
 static u32 gfx_v10_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev);
 
 static int gfx_v10_0_rlc_backdoor_autoload_buffer_init(struct amdgpu_device *adev);
@@ -4712,7 +4712,7 @@ static int gfx_v10_0_sw_fini(void *handle)
 }
 
 static void gfx_v10_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
-				   u32 sh_num, u32 instance)
+				   u32 sh_num, u32 instance, int xcc_id)
 {
 	u32 data;
 
@@ -4772,13 +4772,13 @@ static void gfx_v10_0_setup_rb(struct amdgpu_device *adev)
 				(adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 6))) &&
 			    ((gfx_v10_3_get_disabled_sa(adev) >> bitmap) & 1))
 				continue;
-			gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff);
+			gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff, 0);
 			data = gfx_v10_0_get_rb_active_bitmap(adev);
 			active_rbs |= data << ((i * adev->gfx.config.max_sh_per_se + j) *
 					       rb_bitmap_width_per_sh);
 		}
 	}
-	gfx_v10_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v10_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	adev->gfx.config.backend_enable_mask = active_rbs;
@@ -4907,7 +4907,7 @@ static void gfx_v10_0_tcp_harvest(struct amdgpu_device *adev)
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff);
+			gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff, 0);
 			wgp_active_bitmap = gfx_v10_0_get_wgp_active_bitmap_per_sh(adev);
 			/*
 			 * Set corresponding TCP bits for the inactive WGPs in
@@ -4940,7 +4940,7 @@ static void gfx_v10_0_tcp_harvest(struct amdgpu_device *adev)
 		}
 	}
 
-	gfx_v10_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v10_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
@@ -9540,7 +9540,7 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
 			mask = 1;
 			ao_bitmap = 0;
 			counter = 0;
-			gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff);
+			gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff, 0);
 			if (i < 4 && j < 2)
 				gfx_v10_0_set_user_wgp_inactive_bitmap_per_sh(
 					adev, disable_masks[i * 2 + j]);
@@ -9561,7 +9561,7 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
 			cu_info->ao_cu_bitmap[i][j] = ao_bitmap;
 		}
 	}
-	gfx_v10_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v10_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	cu_info->number = active_cu_number;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 05caffdf4445..7bbb74aceb45 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -112,7 +112,7 @@ static int gfx_v11_0_get_cu_info(struct amdgpu_device *adev,
                                  struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v11_0_get_gpu_clock_counter(struct amdgpu_device *adev);
 static void gfx_v11_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
-				   u32 sh_num, u32 instance);
+				   u32 sh_num, u32 instance, int xcc_id);
 static u32 gfx_v11_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev);
 
 static void gfx_v11_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume);
@@ -1484,7 +1484,7 @@ static int gfx_v11_0_sw_fini(void *handle)
 }
 
 static void gfx_v11_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
-				   u32 sh_num, u32 instance)
+				   u32 sh_num, u32 instance, int xcc_id)
 {
 	u32 data;
 
@@ -6460,7 +6460,7 @@ static int gfx_v11_0_get_cu_info(struct amdgpu_device *adev,
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
 			mask = 1;
 			counter = 0;
-			gfx_v11_0_select_se_sh(adev, i, j, 0xffffffff);
+			gfx_v11_0_select_se_sh(adev, i, j, 0xffffffff, 0);
 			if (i < 8 && j < 2)
 				gfx_v11_0_set_user_wgp_inactive_bitmap_per_sh(
 					adev, disable_masks[i * 2 + j]);
@@ -6492,7 +6492,7 @@ static int gfx_v11_0_get_cu_info(struct amdgpu_device *adev,
 			active_cu_number += counter;
 		}
 	}
-	gfx_v11_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v11_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	cu_info->number = active_cu_number;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index c41219e23151..acacab1f67ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1285,7 +1285,7 @@ static void gfx_v6_0_tiling_mode_table_init(struct amdgpu_device *adev)
 }
 
 static void gfx_v6_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
-				  u32 sh_num, u32 instance)
+				  u32 sh_num, u32 instance, int xcc_id)
 {
 	u32 data;
 
@@ -1438,12 +1438,12 @@ static void gfx_v6_0_write_harvested_raster_configs(struct amdgpu_device *adev,
 		}
 
 		/* GRBM_GFX_INDEX has a different offset on SI */
-		gfx_v6_0_select_se_sh(adev, se, 0xffffffff, 0xffffffff);
+		gfx_v6_0_select_se_sh(adev, se, 0xffffffff, 0xffffffff, 0);
 		WREG32(mmPA_SC_RASTER_CONFIG, raster_config_se);
 	}
 
 	/* GRBM_GFX_INDEX has a different offset on SI */
-	gfx_v6_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v6_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 }
 
 static void gfx_v6_0_setup_rb(struct amdgpu_device *adev)
@@ -1459,14 +1459,14 @@ static void gfx_v6_0_setup_rb(struct amdgpu_device *adev)
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v6_0_select_se_sh(adev, i, j, 0xffffffff);
+			gfx_v6_0_select_se_sh(adev, i, j, 0xffffffff, 0);
 			data = gfx_v6_0_get_rb_active_bitmap(adev);
 			active_rbs |= data <<
 				((i * adev->gfx.config.max_sh_per_se + j) *
 				 rb_bitmap_width_per_sh);
 		}
 	}
-	gfx_v6_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v6_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 
 	adev->gfx.config.backend_enable_mask = active_rbs;
 	adev->gfx.config.num_rbs = hweight32(active_rbs);
@@ -1487,7 +1487,7 @@ static void gfx_v6_0_setup_rb(struct amdgpu_device *adev)
 	/* cache the values for userspace */
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v6_0_select_se_sh(adev, i, j, 0xffffffff);
+			gfx_v6_0_select_se_sh(adev, i, j, 0xffffffff, 0);
 			adev->gfx.config.rb_config[i][j].rb_backend_disable =
 				RREG32(mmCC_RB_BACKEND_DISABLE);
 			adev->gfx.config.rb_config[i][j].user_rb_backend_disable =
@@ -1496,7 +1496,7 @@ static void gfx_v6_0_setup_rb(struct amdgpu_device *adev)
 				RREG32(mmPA_SC_RASTER_CONFIG);
 		}
 	}
-	gfx_v6_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v6_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
@@ -1535,7 +1535,7 @@ static void gfx_v6_0_setup_spi(struct amdgpu_device *adev)
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v6_0_select_se_sh(adev, i, j, 0xffffffff);
+			gfx_v6_0_select_se_sh(adev, i, j, 0xffffffff, 0);
 			data = RREG32(mmSPI_STATIC_THREAD_MGMT_3);
 			active_cu = gfx_v6_0_get_cu_enabled(adev);
 
@@ -1550,7 +1550,7 @@ static void gfx_v6_0_setup_spi(struct amdgpu_device *adev)
 			}
 		}
 	}
-	gfx_v6_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v6_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
@@ -2391,7 +2391,7 @@ static void gfx_v6_0_enable_lbpw(struct amdgpu_device *adev, bool enable)
 	WREG32_FIELD(RLC_LB_CNTL, LOAD_BALANCE_ENABLE, enable ? 1 : 0);
 
 	if (!enable) {
-		gfx_v6_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+		gfx_v6_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 		WREG32(mmSPI_LB_CU_MASK, 0x00ff);
 	}
 }
@@ -3571,7 +3571,7 @@ static void gfx_v6_0_get_cu_info(struct amdgpu_device *adev)
 			mask = 1;
 			ao_bitmap = 0;
 			counter = 0;
-			gfx_v6_0_select_se_sh(adev, i, j, 0xffffffff);
+			gfx_v6_0_select_se_sh(adev, i, j, 0xffffffff, 0);
 			if (i < 4 && j < 2)
 				gfx_v6_0_set_user_cu_inactive_bitmap(
 					adev, disable_masks[i * 2 + j]);
@@ -3593,7 +3593,7 @@ static void gfx_v6_0_get_cu_info(struct amdgpu_device *adev)
 		}
 	}
 
-	gfx_v6_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v6_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	cu_info->number = active_cu_number;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 46740ad9a80f..d055e44eee1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -1552,7 +1552,8 @@ static void gfx_v7_0_tiling_mode_table_init(struct amdgpu_device *adev)
  * Select which SE, SH combinations to address.
  */
 static void gfx_v7_0_select_se_sh(struct amdgpu_device *adev,
-				  u32 se_num, u32 sh_num, u32 instance)
+				  u32 se_num, u32 sh_num, u32 instance,
+				  int xcc_id)
 {
 	u32 data;
 
@@ -1732,13 +1733,13 @@ gfx_v7_0_write_harvested_raster_configs(struct amdgpu_device *adev,
 		}
 
 		/* GRBM_GFX_INDEX has a different offset on CI+ */
-		gfx_v7_0_select_se_sh(adev, se, 0xffffffff, 0xffffffff);
+		gfx_v7_0_select_se_sh(adev, se, 0xffffffff, 0xffffffff, 0);
 		WREG32(mmPA_SC_RASTER_CONFIG, raster_config_se);
 		WREG32(mmPA_SC_RASTER_CONFIG_1, raster_config_1);
 	}
 
 	/* GRBM_GFX_INDEX has a different offset on CI+ */
-	gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 }
 
 /**
@@ -1761,13 +1762,13 @@ static void gfx_v7_0_setup_rb(struct amdgpu_device *adev)
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v7_0_select_se_sh(adev, i, j, 0xffffffff);
+			gfx_v7_0_select_se_sh(adev, i, j, 0xffffffff, 0);
 			data = gfx_v7_0_get_rb_active_bitmap(adev);
 			active_rbs |= data << ((i * adev->gfx.config.max_sh_per_se + j) *
 					       rb_bitmap_width_per_sh);
 		}
 	}
-	gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 
 	adev->gfx.config.backend_enable_mask = active_rbs;
 	adev->gfx.config.num_rbs = hweight32(active_rbs);
@@ -1790,7 +1791,7 @@ static void gfx_v7_0_setup_rb(struct amdgpu_device *adev)
 	/* cache the values for userspace */
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v7_0_select_se_sh(adev, i, j, 0xffffffff);
+			gfx_v7_0_select_se_sh(adev, i, j, 0xffffffff, 0);
 			adev->gfx.config.rb_config[i][j].rb_backend_disable =
 				RREG32(mmCC_RB_BACKEND_DISABLE);
 			adev->gfx.config.rb_config[i][j].user_rb_backend_disable =
@@ -1801,7 +1802,7 @@ static void gfx_v7_0_setup_rb(struct amdgpu_device *adev)
 				RREG32(mmPA_SC_RASTER_CONFIG_1);
 		}
 	}
-	gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
@@ -1911,7 +1912,7 @@ static void gfx_v7_0_constants_init(struct amdgpu_device *adev)
 	 * making sure that the following register writes will be broadcasted
 	 * to all the shaders
 	 */
-	gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
@@ -3301,7 +3302,7 @@ static void gfx_v7_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v7_0_select_se_sh(adev, i, j, 0xffffffff);
+			gfx_v7_0_select_se_sh(adev, i, j, 0xffffffff, 0);
 			for (k = 0; k < adev->usec_timeout; k++) {
 				if (RREG32(mmRLC_SERDES_CU_MASTER_BUSY) == 0)
 					break;
@@ -3309,7 +3310,7 @@ static void gfx_v7_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
 			}
 		}
 	}
-	gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	mask = RLC_SERDES_NONCU_MASTER_BUSY__SE_MASTER_BUSY_MASK |
@@ -3474,7 +3475,7 @@ static int gfx_v7_0_rlc_resume(struct amdgpu_device *adev)
 	WREG32(mmRLC_LB_CNTR_MAX, 0x00008000);
 
 	mutex_lock(&adev->grbm_idx_mutex);
-	gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	WREG32(mmRLC_LB_INIT_CU_MASK, 0xffffffff);
 	WREG32(mmRLC_LB_PARAMS, 0x00600408);
 	WREG32(mmRLC_LB_CNTL, 0x80000004);
@@ -3530,7 +3531,7 @@ static void gfx_v7_0_enable_cgcg(struct amdgpu_device *adev, bool enable)
 		tmp = gfx_v7_0_halt_rlc(adev);
 
 		mutex_lock(&adev->grbm_idx_mutex);
-		gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+		gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 		WREG32(mmRLC_SERDES_WR_CU_MASTER_MASK, 0xffffffff);
 		WREG32(mmRLC_SERDES_WR_NONCU_MASTER_MASK, 0xffffffff);
 		tmp2 = RLC_SERDES_WR_CTRL__BPM_ADDR_MASK |
@@ -3584,7 +3585,7 @@ static void gfx_v7_0_enable_mgcg(struct amdgpu_device *adev, bool enable)
 		tmp = gfx_v7_0_halt_rlc(adev);
 
 		mutex_lock(&adev->grbm_idx_mutex);
-		gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+		gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 		WREG32(mmRLC_SERDES_WR_CU_MASTER_MASK, 0xffffffff);
 		WREG32(mmRLC_SERDES_WR_NONCU_MASTER_MASK, 0xffffffff);
 		data = RLC_SERDES_WR_CTRL__BPM_ADDR_MASK |
@@ -3635,7 +3636,7 @@ static void gfx_v7_0_enable_mgcg(struct amdgpu_device *adev, bool enable)
 		tmp = gfx_v7_0_halt_rlc(adev);
 
 		mutex_lock(&adev->grbm_idx_mutex);
-		gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+		gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 		WREG32(mmRLC_SERDES_WR_CU_MASTER_MASK, 0xffffffff);
 		WREG32(mmRLC_SERDES_WR_NONCU_MASTER_MASK, 0xffffffff);
 		data = RLC_SERDES_WR_CTRL__BPM_ADDR_MASK | RLC_SERDES_WR_CTRL__MGCG_OVERRIDE_1_MASK;
@@ -5115,7 +5116,7 @@ static void gfx_v7_0_get_cu_info(struct amdgpu_device *adev)
 			mask = 1;
 			ao_bitmap = 0;
 			counter = 0;
-			gfx_v7_0_select_se_sh(adev, i, j, 0xffffffff);
+			gfx_v7_0_select_se_sh(adev, i, j, 0xffffffff, 0);
 			if (i < 4 && j < 2)
 				gfx_v7_0_set_user_cu_inactive_bitmap(
 					adev, disable_masks[i * 2 + j]);
@@ -5136,7 +5137,7 @@ static void gfx_v7_0_get_cu_info(struct amdgpu_device *adev)
 			cu_info->ao_cu_bitmap[i][j] = ao_bitmap;
 		}
 	}
-	gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v7_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	cu_info->number = active_cu_number;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 8a43e87de49f..b60480876149 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3395,7 +3395,8 @@ static void gfx_v8_0_tiling_mode_table_init(struct amdgpu_device *adev)
 }
 
 static void gfx_v8_0_select_se_sh(struct amdgpu_device *adev,
-				  u32 se_num, u32 sh_num, u32 instance)
+				  u32 se_num, u32 sh_num, u32 instance,
+				  int xcc_id)
 {
 	u32 data;
 
@@ -3579,13 +3580,13 @@ gfx_v8_0_write_harvested_raster_configs(struct amdgpu_device *adev,
 		}
 
 		/* GRBM_GFX_INDEX has a different offset on VI */
-		gfx_v8_0_select_se_sh(adev, se, 0xffffffff, 0xffffffff);
+		gfx_v8_0_select_se_sh(adev, se, 0xffffffff, 0xffffffff, 0);
 		WREG32(mmPA_SC_RASTER_CONFIG, raster_config_se);
 		WREG32(mmPA_SC_RASTER_CONFIG_1, raster_config_1);
 	}
 
 	/* GRBM_GFX_INDEX has a different offset on VI */
-	gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 }
 
 static void gfx_v8_0_setup_rb(struct amdgpu_device *adev)
@@ -3601,13 +3602,13 @@ static void gfx_v8_0_setup_rb(struct amdgpu_device *adev)
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v8_0_select_se_sh(adev, i, j, 0xffffffff);
+			gfx_v8_0_select_se_sh(adev, i, j, 0xffffffff, 0);
 			data = gfx_v8_0_get_rb_active_bitmap(adev);
 			active_rbs |= data << ((i * adev->gfx.config.max_sh_per_se + j) *
 					       rb_bitmap_width_per_sh);
 		}
 	}
-	gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 
 	adev->gfx.config.backend_enable_mask = active_rbs;
 	adev->gfx.config.num_rbs = hweight32(active_rbs);
@@ -3630,7 +3631,7 @@ static void gfx_v8_0_setup_rb(struct amdgpu_device *adev)
 	/* cache the values for userspace */
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v8_0_select_se_sh(adev, i, j, 0xffffffff);
+			gfx_v8_0_select_se_sh(adev, i, j, 0xffffffff, 0);
 			adev->gfx.config.rb_config[i][j].rb_backend_disable =
 				RREG32(mmCC_RB_BACKEND_DISABLE);
 			adev->gfx.config.rb_config[i][j].user_rb_backend_disable =
@@ -3641,7 +3642,7 @@ static void gfx_v8_0_setup_rb(struct amdgpu_device *adev)
 				RREG32(mmPA_SC_RASTER_CONFIG_1);
 		}
 	}
-	gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
@@ -3788,7 +3789,7 @@ static void gfx_v8_0_constants_init(struct amdgpu_device *adev)
 	 * making sure that the following register writes will be broadcasted
 	 * to all the shaders
 	 */
-	gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 
 	WREG32(mmPA_SC_FIFO_SIZE,
 		   (adev->gfx.config.sc_prim_fifo_size_frontend <<
@@ -3819,7 +3820,7 @@ static void gfx_v8_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v8_0_select_se_sh(adev, i, j, 0xffffffff);
+			gfx_v8_0_select_se_sh(adev, i, j, 0xffffffff, 0);
 			for (k = 0; k < adev->usec_timeout; k++) {
 				if (RREG32(mmRLC_SERDES_CU_MASTER_BUSY) == 0)
 					break;
@@ -3827,7 +3828,7 @@ static void gfx_v8_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
 			}
 			if (k == adev->usec_timeout) {
 				gfx_v8_0_select_se_sh(adev, 0xffffffff,
-						      0xffffffff, 0xffffffff);
+						      0xffffffff, 0xffffffff, 0);
 				mutex_unlock(&adev->grbm_idx_mutex);
 				DRM_INFO("Timeout wait for RLC serdes %u,%u\n",
 					 i, j);
@@ -3835,7 +3836,7 @@ static void gfx_v8_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
 			}
 		}
 	}
-	gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	mask = RLC_SERDES_NONCU_MASTER_BUSY__SE_MASTER_BUSY_MASK |
@@ -5481,7 +5482,7 @@ static void gfx_v8_0_send_serdes_cmd(struct amdgpu_device *adev,
 {
 	uint32_t data;
 
-	gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 
 	WREG32(mmRLC_SERDES_WR_CU_MASTER_MASK, 0xffffffff);
 	WREG32(mmRLC_SERDES_WR_NONCU_MASTER_MASK, 0xffffffff);
@@ -6723,11 +6724,11 @@ static void gfx_v8_0_parse_sq_irq(struct amdgpu_device *adev, unsigned ih_data,
 			 */
 			if (from_wq) {
 				mutex_lock(&adev->grbm_idx_mutex);
-				gfx_v8_0_select_se_sh(adev, se_id, sh_id, cu_id);
+				gfx_v8_0_select_se_sh(adev, se_id, sh_id, cu_id, 0);
 
 				sq_edc_source = REG_GET_FIELD(RREG32(mmSQ_EDC_INFO), SQ_EDC_INFO, SOURCE);
 
-				gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+				gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 				mutex_unlock(&adev->grbm_idx_mutex);
 			}
 
@@ -7116,7 +7117,7 @@ static void gfx_v8_0_get_cu_info(struct amdgpu_device *adev)
 			mask = 1;
 			ao_bitmap = 0;
 			counter = 0;
-			gfx_v8_0_select_se_sh(adev, i, j, 0xffffffff);
+			gfx_v8_0_select_se_sh(adev, i, j, 0xffffffff, 0);
 			if (i < 4 && j < 2)
 				gfx_v8_0_set_user_cu_inactive_bitmap(
 					adev, disable_masks[i * 2 + j]);
@@ -7137,7 +7138,7 @@ static void gfx_v8_0_get_cu_info(struct amdgpu_device *adev)
 			cu_info->ao_cu_bitmap[i][j] = ao_bitmap;
 		}
 	}
-	gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	cu_info->number = active_cu_number;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 36d4a59cdf64..305974d682eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1494,7 +1494,7 @@ static void gfx_v9_0_init_always_on_cu_mask(struct amdgpu_device *adev)
 			mask = 1;
 			cu_bitmap = 0;
 			counter = 0;
-			amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff);
+			amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff, 0);
 
 			for (k = 0; k < adev->gfx.config.max_cu_per_sh; k ++) {
 				if (cu_info->bitmap[i][j] & mask) {
@@ -1513,7 +1513,7 @@ static void gfx_v9_0_init_always_on_cu_mask(struct amdgpu_device *adev)
 			cu_info->ao_cu_bitmap[i][j] = cu_bitmap;
 		}
 	}
-	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
@@ -1535,7 +1535,7 @@ static void gfx_v9_0_init_lbpw(struct amdgpu_device *adev)
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	/* set mmRLC_LB_INIT_CU_MASK thru broadcast mode to enable all SE/SH*/
-	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	WREG32_SOC15(GC, 0, mmRLC_LB_INIT_CU_MASK, 0xffffffff);
 
 	/* set mmRLC_LB_PARAMS = 0x003F_1006 */
@@ -1584,7 +1584,7 @@ static void gfx_v9_4_init_lbpw(struct amdgpu_device *adev)
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	/* set mmRLC_LB_INIT_CU_MASK thru broadcast mode to enable all SE/SH*/
-	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	WREG32_SOC15(GC, 0, mmRLC_LB_INIT_CU_MASK, 0xffffffff);
 
 	/* set mmRLC_LB_PARAMS = 0x003F_1006 */
@@ -2231,7 +2231,7 @@ static void gfx_v9_0_tiling_mode_table_init(struct amdgpu_device *adev)
 }
 
 void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
-			   u32 instance)
+			   u32 instance, int xcc_id)
 {
 	u32 data;
 
@@ -2280,13 +2280,13 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff);
+			amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff, 0);
 			data = gfx_v9_0_get_rb_active_bitmap(adev);
 			active_rbs |= data << ((i * adev->gfx.config.max_sh_per_se + j) *
 					       rb_bitmap_width_per_sh);
 		}
 	}
-	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	adev->gfx.config.backend_enable_mask = active_rbs;
@@ -2423,7 +2423,7 @@ static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff);
+			amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff, 0);
 			for (k = 0; k < adev->usec_timeout; k++) {
 				if (RREG32_SOC15(GC, 0, mmRLC_SERDES_CU_MASTER_BUSY) == 0)
 					break;
@@ -2431,7 +2431,7 @@ static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
 			}
 			if (k == adev->usec_timeout) {
 				amdgpu_gfx_select_se_sh(adev, 0xffffffff,
-						      0xffffffff, 0xffffffff);
+						      0xffffffff, 0xffffffff, 0);
 				mutex_unlock(&adev->grbm_idx_mutex);
 				DRM_INFO("Timeout wait for RLC serdes %u,%u\n",
 					 i, j);
@@ -2439,7 +2439,7 @@ static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
 			}
 		}
 	}
-	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	mask = RLC_SERDES_NONCU_MASTER_BUSY__SE_MASTER_BUSY_MASK |
@@ -6568,7 +6568,7 @@ static void gfx_v9_0_reset_ras_error_count(struct amdgpu_device *adev)
 	for (i = 0; i < ARRAY_SIZE(gfx_v9_0_edc_counter_regs); i++) {
 		for (j = 0; j < gfx_v9_0_edc_counter_regs[i].se_num; j++) {
 			for (k = 0; k < gfx_v9_0_edc_counter_regs[i].instance; k++) {
-				amdgpu_gfx_select_se_sh(adev, j, 0x0, k);
+				amdgpu_gfx_select_se_sh(adev, j, 0x0, k, 0);
 				RREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_0_edc_counter_regs[i]));
 			}
 		}
@@ -6630,7 +6630,7 @@ static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 	for (i = 0; i < ARRAY_SIZE(gfx_v9_0_edc_counter_regs); i++) {
 		for (j = 0; j < gfx_v9_0_edc_counter_regs[i].se_num; j++) {
 			for (k = 0; k < gfx_v9_0_edc_counter_regs[i].instance; k++) {
-				amdgpu_gfx_select_se_sh(adev, j, 0, k);
+				amdgpu_gfx_select_se_sh(adev, j, 0, k, 0);
 				reg_value =
 					RREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_0_edc_counter_regs[i]));
 				if (reg_value)
@@ -6645,7 +6645,7 @@ static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 	err_data->ce_count += sec_count;
 	err_data->ue_count += ded_count;
 
-	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	gfx_v9_0_query_utc_edc_status(adev, err_data);
@@ -7105,7 +7105,7 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
 			mask = 1;
 			ao_bitmap = 0;
 			counter = 0;
-			amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff);
+			amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff, 0);
 			gfx_v9_0_set_user_cu_inactive_bitmap(
 				adev, disable_masks[i * adev->gfx.config.max_sh_per_se + j]);
 			bitmap = gfx_v9_0_get_cu_active_bitmap(adev);
@@ -7138,7 +7138,7 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
 			cu_info->ao_cu_bitmap[i % 4][j + i / 4] = ao_bitmap;
 		}
 	}
-	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	cu_info->number = active_cu_number;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
index dfe8d4841f58..f9f6edc5e558 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
@@ -27,6 +27,6 @@
 extern const struct amdgpu_ip_block_version gfx_v9_0_ip_block;
 
 void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
-			   u32 instance);
+			   u32 instance, int xcc_id);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 93438770ca1a..d648a29c33e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -777,7 +777,7 @@ void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev)
 {
 	u32 tmp;
 
-	gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 
 	tmp = 0;
 	tmp = REG_SET_FIELD(tmp, GC_THROTTLE_CTRL, PATTERN_MODE, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 773c139a1f10..51a033537be1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -569,7 +569,8 @@ static int gfx_v9_4_3_mec_init(struct amdgpu_device *adev)
 static void gfx_v9_4_3_select_se_sh(struct amdgpu_device *adev,
 				    u32 se_num,
 				    u32 sh_num,
-				    u32 instance)
+				    u32 instance,
+				    int xcc_id)
 {
 	u32 data;
 
@@ -592,7 +593,7 @@ static void gfx_v9_4_3_select_se_sh(struct amdgpu_device *adev,
 	else
 		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SH_INDEX, sh_num);
 
-	WREG32_SOC15_RLC_SHADOW_EX(reg, GC, 0, regGRBM_GFX_INDEX, data);
+	WREG32_SOC15_RLC_SHADOW_EX(reg, GC, xcc_id, regGRBM_GFX_INDEX, data);
 }
 
 static uint32_t wave_read_ind(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t address)
@@ -908,13 +909,13 @@ static void gfx_v9_4_3_setup_rb(struct amdgpu_device *adev, int xcc_id)
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v9_4_3_select_se_sh(adev, i, j, 0xffffffff);
+			gfx_v9_4_3_select_se_sh(adev, i, j, 0xffffffff, xcc_id);
 			data = gfx_v9_4_3_get_rb_active_bitmap(adev);
 			active_rbs |= data << ((i * adev->gfx.config.max_sh_per_se + j) *
 					       rb_bitmap_width_per_sh);
 		}
 	}
-	gfx_v9_4_3_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v9_4_3_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, xcc_id);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	adev->gfx.config.backend_enable_mask = active_rbs;
@@ -1147,7 +1148,7 @@ static void gfx_v9_4_3_wait_for_rlc_serdes(struct amdgpu_device *adev,
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v9_4_3_select_se_sh(adev, i, j, 0xffffffff);
+			gfx_v9_4_3_select_se_sh(adev, i, j, 0xffffffff, xcc_id);
 			for (k = 0; k < adev->usec_timeout; k++) {
 				if (RREG32_SOC15(GC, 0, regRLC_SERDES_CU_MASTER_BUSY) == 0)
 					break;
@@ -1155,7 +1156,8 @@ static void gfx_v9_4_3_wait_for_rlc_serdes(struct amdgpu_device *adev,
 			}
 			if (k == adev->usec_timeout) {
 				gfx_v9_4_3_select_se_sh(adev, 0xffffffff,
-						      0xffffffff, 0xffffffff);
+							0xffffffff, 0xffffffff,
+							xcc_id);
 				mutex_unlock(&adev->grbm_idx_mutex);
 				DRM_INFO("Timeout wait for RLC serdes %u,%u\n",
 					 i, j);
@@ -1163,7 +1165,7 @@ static void gfx_v9_4_3_wait_for_rlc_serdes(struct amdgpu_device *adev,
 			}
 		}
 	}
-	gfx_v9_4_3_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v9_4_3_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, xcc_id);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	mask = RLC_SERDES_NONCU_MASTER_BUSY__SE_MASTER_BUSY_MASK |
@@ -3066,7 +3068,7 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 			mask = 1;
 			ao_bitmap = 0;
 			counter = 0;
-			gfx_v9_4_3_select_se_sh(adev, i, j, 0xffffffff);
+			gfx_v9_4_3_select_se_sh(adev, i, j, 0xffffffff, 0);
 			gfx_v9_4_3_set_user_cu_inactive_bitmap(
 				adev, disable_masks[i * adev->gfx.config.max_sh_per_se + j]);
 			bitmap = gfx_v9_4_3_get_cu_active_bitmap(adev);
@@ -3099,7 +3101,7 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 			cu_info->ao_cu_bitmap[i % 4][j + i / 4] = ao_bitmap;
 		}
 	}
-	gfx_v9_4_3_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	gfx_v9_4_3_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	cu_info->number = active_cu_number;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 47420b403871..148049782f50 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -371,12 +371,12 @@ static uint32_t nv_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff);
+		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
 
 	val = RREG32(reg_offset);
 
 	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 	return val;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 7f99e130acd0..f64b87b11b1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1181,12 +1181,12 @@ static uint32_t si_get_register_value(struct amdgpu_device *adev,
 
 		mutex_lock(&adev->grbm_idx_mutex);
 		if (se_num != 0xffffffff || sh_num != 0xffffffff)
-			amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff);
+			amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
 
 		val = RREG32(reg_offset);
 
 		if (se_num != 0xffffffff || sh_num != 0xffffffff)
-			amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+			amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 		mutex_unlock(&adev->grbm_idx_mutex);
 		return val;
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 2683de4a5b92..dc43aa5b6f40 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -364,12 +364,12 @@ static uint32_t soc15_read_indexed_register(struct amdgpu_device *adev, u32 se_n
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff);
+		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
 
 	val = RREG32(reg_offset);
 
 	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 	return val;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 514bfc705d5a..6ef4be9322d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -288,12 +288,12 @@ static uint32_t soc21_read_indexed_register(struct amdgpu_device *adev, u32 se_n
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff);
+		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
 
 	val = RREG32(reg_offset);
 
 	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 	return val;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 531f173ade2d..8e70581960fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -762,12 +762,12 @@ static uint32_t vi_get_register_value(struct amdgpu_device *adev,
 
 		mutex_lock(&adev->grbm_idx_mutex);
 		if (se_num != 0xffffffff || sh_num != 0xffffffff)
-			amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff);
+			amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
 
 		val = RREG32(reg_offset);
 
 		if (se_num != 0xffffffff || sh_num != 0xffffffff)
-			amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+			amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 		mutex_unlock(&adev->grbm_idx_mutex);
 		return val;
 	} else {
-- 
2.39.2

