Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9505EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 15:53:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5498A10E49C;
	Fri, 30 Jun 2023 15:53:49 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3BC10E4A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 15:53:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lO8Z1fE7weirrZhw9VBF1BTQ5wqze4zLE9fj7hFDp5aFO1DQ8Ix1XcA4JVz57m2PtNprbGUaCOBFwO342MfgiJxuD1tDKxEL2tIKTkUzvZKctqi6Mna1K1Gkh4u7JvlFCJymfcz/JbC162WS6rSWjENLjBiIOIk4IaUViOwF3txQDANN4zHDBtvCIn43y+I3MppI15Hzv4zuusP/6bRflp4COypJHIkB+Oauj+hdAFy/9+EssSQy5GnzInEJYniD1L9EBJfh++GWJyN3zmOZLtYdYFLtMTQK2NInGOEBnsFjTC4H7eqeV6viYHmTOgfK9wy4S3x0XlvxvrYIG5PcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF7GoXv+Eg7cKULtK5TmqvwZC6SvnlaA/11dKNWix3Q=;
 b=XydoV9o/j6sXr0tT4QE7VbgOOFxcvO3o4DAEnHPA2+slzEFTXwWnW0LCRZrAqlSXKdV6YTSWfRPgsl7bUvYr6vlPv7w+E/A4g0I/nPIkL30VisJCvrvYR7HgL8zSV+S+v+GrjDsnXmrJWikBjqNUsuVJKX5ljz8ut61BtAchSA93XyRNMx+F2vFYZwWqn8TpbuU1yruAgvK7MYyXwsmm83ohQGMG1tQke/mzzDW0kprPVa4FnLciB8aMGwPazrgOYf/hUtWEE6mp0+TbeXqnz44SEhxllAQUuiOHSN+rf7wGtKZo3OSxqzA977RZvYws6QoJlVDrFo4krS/r/tRhmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF7GoXv+Eg7cKULtK5TmqvwZC6SvnlaA/11dKNWix3Q=;
 b=B5Gt6DblVhJXh5s+UDD+n2MmsZAtYfqQQ9cegvrhninz4RLXgqGOfG5UMEGeHaCeUWF0ZRLW/jjBrKzq+KVSc/2+IueZ2EYM4yYLk/NhSS6KdeZ0hclrdbxPQekcBl6CO2lpGummx9l8JoXa86BZbLx5qXmHHmFNQNA5Xs8Il4g=
Received: from BN9P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::23)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 15:53:44 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::ae) by BN9P221CA0024.outlook.office365.com
 (2603:10b6:408:10a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 15:53:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.51 via Frontend Transport; Fri, 30 Jun 2023 15:53:43 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 10:53:43 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add RLCG interface driver implementation for gfx
 v9.4.3
Date: Fri, 30 Jun 2023 11:51:05 -0400
Message-ID: <20230630155105.457217-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: d72ad783-c416-4a23-7c94-08db79822ea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N78hb3tciSY2WQsswHsKxH84O9+8hHow9Yh25fAQCoqp2E2t9KjKcabiucErD/j1gV7F/rPi0wdJH/19hV0jrsEmqs7ah9OljWsgnC1OZqdVDaneaxgIx9egRkvgW/IDlABKcyaXKXMg5NMkGQxA34TRTxWf/x6JuE8iDZTWveebubqVHf5F1bWGzArMmq0mriviqldEBUzlm4HV/evhftjoZ2G5mvd4xBsUhXV/59a4ag6dhO0PS5LmrBCVzTih6/JzFvZmjAaj4cVt992wr1cr4CepJoIhFV7UZPEA73gp/wnRuZKip8Nyh5qCb/Qh81tYcjU81pEusZmn7OqDLyEVRLGQe3c5azpXSiwq/IeunxlQrOXuSy+dvhhaO/ffkPoNcuibOaoRKkUSFVR2HIDImuE9l8pxRJJ64E/J5G5GLoFx0WBRaWQe6DJMQVyQVNiN9A+fA184D9QVKuo3cRNXPHGRsF02KiSAnzMEvgyG7Y3FLjnI4XmFlKys2ILX8DmQ/EqrOyt3fHX8G4b0EKCdGUJUmyGIizd2IsqlTJwPLDOQX/+fMYFi4/fH/0szzH5vUs8Q5yX/kjk1n5XCKFXK7qhnUcuxxz9L0GAjK0y7773OfQ2XTBxamWuXmhBpLhbJdFUwKimNzxjKvAdyBTqW/EBCJSbQbywffpwY6OJZPtPIYJKh0XkFMnsqxPQKBX3tWbZZ7XoC/Eoo5jDWz2ideoirLAo5Af8j5lV1mRB24KEqzRXHTn3tk8uyj5CEslJX79p73KO8kR/qaAi2bw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(8676002)(8936002)(5660300002)(36756003)(478600001)(6916009)(4326008)(7696005)(6666004)(70206006)(70586007)(40460700003)(316002)(41300700001)(40480700001)(81166007)(356005)(47076005)(186003)(16526019)(30864003)(2616005)(1076003)(26005)(426003)(83380400001)(82310400005)(86362001)(336012)(36860700001)(82740400003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 15:53:43.7895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d72ad783-c416-4a23-7c94-08db79822ea5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190
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
Cc: victorchengchi.lu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add RLCG interface support for gfx v9.4.3 and multiple XCCs.
Do not enable it yet.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 17 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 21 +++++++
 drivers/gpu/drm/amd/amdgpu/soc15_common.h  | 66 +++++++++++-----------
 9 files changed, 73 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 45b335c766fd..ce9a0b5ed24f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -591,11 +591,12 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
 
+	/* TODO: Add support for different XCCs */
 	if (amdgpu_sriov_fullaccess(adev) &&
 	    adev->gfx.rlc.funcs &&
 	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
 		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
-			return amdgpu_sriov_wreg(adev, reg, v, 0, 0);
+			return amdgpu_sriov_wreg(adev, reg, v, 0, 0, 0);
 	} else if ((reg * 4) >= adev->rmmio_size) {
 		adev->pcie_wreg(adev, reg * 4, v);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 80b263646966..efabcf6add1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -257,7 +257,7 @@ struct amdgpu_rlc {
 
 	bool rlcg_reg_access_supported;
 	/* registers for rlcg indirect reg access */
-	struct amdgpu_rlcg_reg_access_ctrl reg_access_ctrl;
+	struct amdgpu_rlcg_reg_access_ctrl reg_access_ctrl[8];
 };
 
 void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev, int xcc_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 5731829964c2..b5c6c7435551 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -960,7 +960,7 @@ static bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
 	return ret;
 }
 
-static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
+static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag, u32 xcc_id)
 {
 	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
 	uint32_t timeout = 50000;
@@ -978,7 +978,12 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
 		return 0;
 	}
 
-	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl;
+	if (adev->gfx.xcc_mask && (((1 << xcc_id) & adev->gfx.xcc_mask) == 0)) {
+		dev_err(adev->dev, "invalid xcc\n");
+		return 0;
+	}
+
+	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[xcc_id];
 	scratch_reg0 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg0;
 	scratch_reg1 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg1;
 	scratch_reg2 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg2;
@@ -1043,13 +1048,13 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
 
 void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 		       u32 offset, u32 value,
-		       u32 acc_flags, u32 hwip)
+		       u32 acc_flags, u32 hwip, u32 xcc_id)
 {
 	u32 rlcg_flag;
 
 	if (!amdgpu_sriov_runtime(adev) &&
 		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true, &rlcg_flag)) {
-		amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag);
+		amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag, xcc_id);
 		return;
 	}
 
@@ -1060,13 +1065,13 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 }
 
 u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
-		      u32 offset, u32 acc_flags, u32 hwip)
+		      u32 offset, u32 acc_flags, u32 hwip, u32 xcc_id)
 {
 	u32 rlcg_flag;
 
 	if (!amdgpu_sriov_runtime(adev) &&
 		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &rlcg_flag))
-		return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag);
+		return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag, xcc_id);
 
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
 		return RREG32_NO_KIQ(offset);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 4f7bab52282a..d1f7509a44cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -355,9 +355,9 @@ void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
 			struct amdgpu_video_codec_info *decode, uint32_t decode_array_size);
 void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 		       u32 offset, u32 value,
-		       u32 acc_flags, u32 hwip);
+		       u32 acc_flags, u32 hwip, u32 xcc_id);
 u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
-		      u32 offset, u32 acc_flags, u32 hwip);
+		      u32 offset, u32 acc_flags, u32 hwip, u32 xcc_id);
 bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev,
 			uint32_t ucode_id);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index c8291711dba3..7a1e7e3db2cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4151,7 +4151,7 @@ static void gfx_v10_0_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 {
 	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
 
-	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl;
+	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[0];
 	reg_access_ctrl->scratch_reg0 = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0);
 	reg_access_ctrl->scratch_reg1 = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG1);
 	reg_access_ctrl->scratch_reg2 = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG2);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a9f008d0d5ab..f5b52d239eb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -645,7 +645,7 @@ static void gfx_v11_0_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 {
 	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
 
-	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl;
+	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[0];
 	reg_access_ctrl->scratch_reg0 = SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG0);
 	reg_access_ctrl->scratch_reg1 = SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG1);
 	reg_access_ctrl->scratch_reg2 = SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG2);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index de9a5c67e241..ebdc0f9200f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1636,7 +1636,7 @@ static void gfx_v9_0_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 {
 	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
 
-	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl;
+	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[0];
 	reg_access_ctrl->scratch_reg0 = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0);
 	reg_access_ctrl->scratch_reg1 = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG1);
 	reg_access_ctrl->scratch_reg2 = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG2);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index b41d6ae35c8a..14338f963172 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1126,6 +1126,24 @@ static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SAFE_MODE, data);
 }
 
+static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
+{
+	int i, num_xcc;
+	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
+		reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[i];
+		reg_access_ctrl->scratch_reg0 = SOC15_REG_OFFSET(GC, i, regSCRATCH_REG0);
+		reg_access_ctrl->scratch_reg1 = SOC15_REG_OFFSET(GC, i, regSCRATCH_REG1);
+		reg_access_ctrl->scratch_reg2 = SOC15_REG_OFFSET(GC, i, regSCRATCH_REG2);
+		reg_access_ctrl->scratch_reg3 = SOC15_REG_OFFSET(GC, i, regSCRATCH_REG3);
+		reg_access_ctrl->grbm_cntl = SOC15_REG_OFFSET(GC, i, regGRBM_GFX_CNTL);
+		reg_access_ctrl->grbm_idx = SOC15_REG_OFFSET(GC, i, regGRBM_GFX_INDEX);
+		reg_access_ctrl->spare_int = SOC15_REG_OFFSET(GC, i, regRLC_SPARE_INT);
+	}
+}
+
 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
 {
 	/* init spm vmid with 0xf */
@@ -2319,6 +2337,9 @@ static int gfx_v9_4_3_early_init(void *handle)
 			gfx_v9_4_3_xcc_rlc_smu_handshake_cntl(adev, false, i);
 	}
 
+	/* init rlcg reg access ctrl */
+	gfx_v9_4_3_init_rlcg_reg_access_ctrl(adev);
+
 	return gfx_v9_4_3_init_microcode(adev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 96948a59f8dd..da683afa0222 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -37,65 +37,65 @@
 #define SOC15_REG_OFFSET1(ip, inst, reg, offset) \
 	(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + (reg)+(offset))
 
-#define __WREG32_SOC15_RLC__(reg, value, flag, hwip) \
+#define __WREG32_SOC15_RLC__(reg, value, flag, hwip, inst) \
 	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.rlcg_reg_access_supported) ? \
-	 amdgpu_sriov_wreg(adev, reg, value, flag, hwip) : \
+	 amdgpu_sriov_wreg(adev, reg, value, flag, hwip, inst) : \
 	 WREG32(reg, value))
 
-#define __RREG32_SOC15_RLC__(reg, flag, hwip) \
+#define __RREG32_SOC15_RLC__(reg, flag, hwip, inst) \
 	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.rlcg_reg_access_supported) ? \
-	 amdgpu_sriov_rreg(adev, reg, flag, hwip) : \
+	 amdgpu_sriov_rreg(adev, reg, flag, hwip, inst) : \
 	 RREG32(reg))
 
 #define WREG32_FIELD15(ip, idx, reg, field, val)	\
 	 __WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg,	\
 				(__RREG32_SOC15_RLC__( \
 					adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg, \
-					0, ip##_HWIP) & \
+					0, ip##_HWIP, idx) & \
 				~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field), \
-			      0, ip##_HWIP)
+			      0, ip##_HWIP, idx)
 
 #define WREG32_FIELD15_PREREG(ip, idx, reg_name, field, val)        \
 	__WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][reg##reg_name##_BASE_IDX] + reg##reg_name,   \
 			(__RREG32_SOC15_RLC__( \
 					adev->reg_offset[ip##_HWIP][idx][reg##reg_name##_BASE_IDX] + reg##reg_name, \
-					0, ip##_HWIP) & \
+					0, ip##_HWIP, idx) & \
 					~REG_FIELD_MASK(reg_name, field)) | (val) << REG_FIELD_SHIFT(reg_name, field), \
-			0, ip##_HWIP)
+			0, ip##_HWIP, idx)
 
 #define RREG32_SOC15(ip, inst, reg) \
 	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
-			 0, ip##_HWIP)
+			 0, ip##_HWIP, inst)
 
-#define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0, ip##_HWIP)
+#define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0, ip##_HWIP, 0)
 
-#define RREG32_SOC15_IP_NO_KIQ(ip, reg) __RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
+#define RREG32_SOC15_IP_NO_KIQ(ip, reg) __RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ, ip##_HWIP, 0)
 
 #define RREG32_SOC15_NO_KIQ(ip, inst, reg) \
 	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
-			 AMDGPU_REGS_NO_KIQ, ip##_HWIP)
+			 AMDGPU_REGS_NO_KIQ, ip##_HWIP, inst)
 
 #define RREG32_SOC15_OFFSET(ip, inst, reg, offset) \
 	 __RREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + (reg)) + \
-			 (offset), 0, ip##_HWIP)
+			 (offset), 0, ip##_HWIP, inst)
 
 #define WREG32_SOC15(ip, inst, reg, value) \
 	 __WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), \
-			  value, 0, ip##_HWIP)
+			  value, 0, ip##_HWIP, inst)
 
 #define WREG32_SOC15_IP(ip, reg, value) \
-	 __WREG32_SOC15_RLC__(reg, value, 0, ip##_HWIP)
+	 __WREG32_SOC15_RLC__(reg, value, 0, ip##_HWIP, 0)
 
 #define WREG32_SOC15_IP_NO_KIQ(ip, reg, value) \
-	 __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
+	 __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ, ip##_HWIP, 0)
 
 #define WREG32_SOC15_NO_KIQ(ip, inst, reg, value) \
 	__WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
-			     value, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
+			     value, AMDGPU_REGS_NO_KIQ, ip##_HWIP, inst)
 
 #define WREG32_SOC15_OFFSET(ip, inst, reg, offset, value) \
 	 __WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, \
-			  value, 0, ip##_HWIP)
+			  value, 0, ip##_HWIP, inst)
 
 #define SOC15_WAIT_ON_RREG(ip, inst, reg, expected_value, mask)      \
 	amdgpu_device_wait_on_rreg(adev, inst,                       \
@@ -108,16 +108,16 @@
 	#reg, expected_value, mask)
 
 #define WREG32_RLC(reg, value) \
-	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_RLC, GC_HWIP)
+	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_RLC, GC_HWIP, 0)
 
-#define WREG32_RLC_EX(prefix, reg, value) \
+#define WREG32_RLC_EX(prefix, reg, value, inst) \
 	do {							\
 		if (amdgpu_sriov_fullaccess(adev)) {    \
 			uint32_t i = 0;	\
 			uint32_t retries = 50000;	\
-			uint32_t r0 = adev->reg_offset[GC_HWIP][0][prefix##SCRATCH_REG0_BASE_IDX] + prefix##SCRATCH_REG0;	\
-			uint32_t r1 = adev->reg_offset[GC_HWIP][0][prefix##SCRATCH_REG1_BASE_IDX] + prefix##SCRATCH_REG1;	\
-			uint32_t spare_int = adev->reg_offset[GC_HWIP][0][prefix##RLC_SPARE_INT_BASE_IDX] + prefix##RLC_SPARE_INT;	\
+			uint32_t r0 = adev->reg_offset[GC_HWIP][inst][prefix##SCRATCH_REG0_BASE_IDX] + prefix##SCRATCH_REG0;	\
+			uint32_t r1 = adev->reg_offset[GC_HWIP][inst][prefix##SCRATCH_REG1_BASE_IDX] + prefix##SCRATCH_REG1;	\
+			uint32_t spare_int = adev->reg_offset[GC_HWIP][inst][prefix##RLC_SPARE_INT_BASE_IDX] + prefix##RLC_SPARE_INT;	\
 			WREG32(r0, value);	\
 			WREG32(r1, (reg | 0x80000000));	\
 			WREG32(spare_int, 0x1);	\
@@ -136,17 +136,17 @@
 
 /* shadow the registers in the callback function */
 #define WREG32_SOC15_RLC_SHADOW(ip, inst, reg, value) \
-	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value, AMDGPU_REGS_RLC, GC_HWIP)
+	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value, AMDGPU_REGS_RLC, GC_HWIP, inst)
 
 /* for GC only */
 #define RREG32_RLC(reg) \
 	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP)
 
 #define WREG32_RLC_NO_KIQ(reg, value, hwip) \
-	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_RLC, hwip)
+	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_RLC, hwip, 0)
 
 #define RREG32_RLC_NO_KIQ(reg, hwip) \
-	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_RLC, hwip)
+	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_RLC, hwip, 0)
 
 #define WREG32_SOC15_RLC_SHADOW_EX(prefix, ip, inst, reg, value) \
 	do {							\
@@ -167,32 +167,32 @@
 	} while (0)
 
 #define RREG32_SOC15_RLC(ip, inst, reg) \
-	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, AMDGPU_REGS_RLC, ip##_HWIP)
+	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, AMDGPU_REGS_RLC, ip##_HWIP, inst)
 
 #define WREG32_SOC15_RLC(ip, inst, reg, value) \
 	do {							\
 		uint32_t target_reg = adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg;\
-		__WREG32_SOC15_RLC__(target_reg, value, AMDGPU_REGS_RLC, ip##_HWIP); \
+		__WREG32_SOC15_RLC__(target_reg, value, AMDGPU_REGS_RLC, ip##_HWIP, inst); \
 	} while (0)
 
 #define WREG32_SOC15_RLC_EX(prefix, ip, inst, reg, value) \
 	do {							\
 			uint32_t target_reg = adev->reg_offset[GC_HWIP][inst][reg##_BASE_IDX] + reg;\
-			WREG32_RLC_EX(prefix, target_reg, value); \
+			WREG32_RLC_EX(prefix, target_reg, value, inst); \
 	} while (0)
 
 #define WREG32_FIELD15_RLC(ip, idx, reg, field, val)   \
 	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
 			     (__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg, \
-						   AMDGPU_REGS_RLC, ip##_HWIP) & \
+						   AMDGPU_REGS_RLC, ip##_HWIP, idx) & \
 			      ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field), \
-			     AMDGPU_REGS_RLC, ip##_HWIP)
+			     AMDGPU_REGS_RLC, ip##_HWIP, idx)
 
 #define WREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset, value) \
-	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, value, AMDGPU_REGS_RLC, ip##_HWIP)
+	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, value, AMDGPU_REGS_RLC, ip##_HWIP, inst)
 
 #define RREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset) \
-	__RREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, AMDGPU_REGS_RLC, ip##_HWIP)
+	__RREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, AMDGPU_REGS_RLC, ip##_HWIP, inst)
 
 /* inst equals to ext for some IPs */
 #define RREG32_SOC15_EXT(ip, inst, reg, ext) \
-- 
2.34.1

