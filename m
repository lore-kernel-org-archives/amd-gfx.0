Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DDFC3ABBB
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 13:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABB9010E3F8;
	Mon,  5 May 2025 13:05:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bQSapsMO";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 134F010E3FD
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 13:05:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=is+h/xvsWmTQ8sQE16XVTANRvOvbzenBSRJQlOWEcz9PKHR2cCqAUsRSqFV73CBivs+i/+sJCRkYo+k0zWu2tAmMNi1TRmN2oY2askOOd5mTCiw5OpZ9E31TmsdITbxSlu81oS0aSgT6ZnGKfKfVYxSBxIa30Ys4hDVx1ZhYJOwX1z27sCO88VMYcRfBRQTX67BC05BvFU0T75LuJCKPJcQxyw/GHF1VBk3Xz9iT4XiKYgHX5lWGsOx6s4BCdlwdoZBHEXrap/u/ewndH6dp5Vy15kE44HXDyietFfpBcKPUU+FBzMQKgybGyNrbImQPW2pnQgLL2H41jsZdTLW6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQ7ZS8TQ51aGou4EAZMmPQkWA4iuq/xgK4/uU5dzFsM=;
 b=v+ROtVALDXvvqDpuQ+yao1tSfODXQwZFehYJpmhj06w8MqcaJ4Y1EqtK5Ju1HMXHkr3Q4Hnvwh4a25lS1GBFFfH1IvdNQ4boBvNiRYIrM7A6iIRmX8FFbMyQZIsIelw1/LcTlEqCkhNDOqU6ano7XkAgbWEyGY6FBaq1OG9coHEWEHV7B0IVslfjUTSiBZ5M1iCHia0zxHlT5o7RPNX+EkfGrtuzTtVdEuIt2ps1CWv96r35RV6QmiicbW7s/Hj/rXx5uUsWBF1PrlXjYytGS3Z2c9EEaeo59KD2Kb3l2ncQL1mFpUqWzKI0NkwZ3yxdt2y+riVkYm8deQBMHj+Btw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ7ZS8TQ51aGou4EAZMmPQkWA4iuq/xgK4/uU5dzFsM=;
 b=bQSapsMO2/9LXtc8zYOPW11utzX2wha+yk5kEcGnX8BS6zNzsCzmsQZhA0+X9LjFr9ZMiO2SV7X0CR0sWwaI/P/F62Prx9Fp8KSKXiVYMLnSZjNvV8Yf5uT93F4PHepqcbELmofp4IFzeeRBSFFWy504HWFzkVIM330tflB6PV4=
Received: from CH2PR18CA0020.namprd18.prod.outlook.com (2603:10b6:610:4f::30)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 13:05:20 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::1d) by CH2PR18CA0020.outlook.office365.com
 (2603:10b6:610:4f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 13:05:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 13:05:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 08:05:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/7] Reapply: drm/amdgpu: Use generic hdp flush function
Date: Mon, 5 May 2025 09:04:59 -0400
Message-ID: <20250505130459.1985637-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505130459.1985637-1-alexander.deucher@amd.com>
References: <20250505130459.1985637-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e204e7f-dcae-48f0-3927-08dd8bd57d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L8gghdfmovaGTSNV11Q7Pvg2wRGzep9u3fEfNEHsn0qpfzKKIxLjJNl8VnnB?=
 =?us-ascii?Q?fJ4eXL2XayUPIuYICMYUNu/flU8a3C7cZWZ5pF1eZVmCNks4XpqMXAr3Tb1X?=
 =?us-ascii?Q?W9BXO9mnqfwzdGqr1aSwwdd6CHZeBoPQoyIdxUhdzfQo6Yz87pXoIFq0BGp1?=
 =?us-ascii?Q?bRNeYkHflBpX9cGugEEDYSAwxxjeiUWH5es6q8+OY1bBUoRlEXU/5EtXGjb+?=
 =?us-ascii?Q?EDbqCMv4PmYHc/dZRsY3BiOTUdy1rovpBQQJmLt9gtZrs3iG1ogHkulApb9q?=
 =?us-ascii?Q?99tuNedkcZp7hnnpk2EXTApg2FwJDKFoJ7n2U3/hJ8DCVrjsOsuSSGyK2B3y?=
 =?us-ascii?Q?WwhrJYKIX7HCxUGdVxdHysguy77K5A8c1yGuoHWpKQNLuDbzzIiMeC2ccvo1?=
 =?us-ascii?Q?VeTMWWRNKggy8C4ArAZ+GA8J4LGwr2z+sCCJiwKS4lYuogVCaxvluPPSYHfN?=
 =?us-ascii?Q?72AIwCriU4LUDmWLuczy0XpU3Yy+VJmURQ9eAJXVkPmHl/dL48/QFNUIOyRD?=
 =?us-ascii?Q?llsaCG2LoOH9X9kko+7JwVQciKij+Pd1Nq5fRuEutrtav6am0chleflJGLiy?=
 =?us-ascii?Q?4oPaxUcml6BiH1/gkIWkA5tSGOvdLROVkef+O6vPnNwY9TBszzxZf3wsqcxE?=
 =?us-ascii?Q?TmZmylpXhzyryn2h3wgt6zn7orxmR4C8VIGvBJuHlRCjRPGJPgH8jeaJDQPA?=
 =?us-ascii?Q?Jpezh21PUKCoWoS+WdjA75CKCC4RyY5L+pXscqMRXZZaEsLoU8vWnnFh9Umc?=
 =?us-ascii?Q?TF99qWeQ/LNJYYNsnbMKTr8Ry7AbC8JiZSEsUQkYLadLKe72f5iavA2FbFyA?=
 =?us-ascii?Q?Z8VLSVUbdfvS6HL3lbUH1whrZZR2CgjftT7hRM2UaBbixLtq0tZN7W6GLmcl?=
 =?us-ascii?Q?sHdRLwJ660/9QIabwCTZAr1Caw5Xe1D9lKwm5Q7iu8eD5pNQCOLrllfKjBYH?=
 =?us-ascii?Q?+27xhwFZuxyHSUn+jSr7gIQfMcIui1RFSa1Zu97ILcro+WtWVJ0xgfEmfD3h?=
 =?us-ascii?Q?U7qHL81tswfBcRtl/HZsbe5SHfRMScz8nNp+iXnj48BpthDsYrAzSQHBF53E?=
 =?us-ascii?Q?TqoXAGVWxOUNJt3SJRKGlFIvDqIZgujop4/kp7QMMHEJqM6Ogv13kkH6po6j?=
 =?us-ascii?Q?lPEkHGtUqj4Rkl+r+MiosvPQgJQH8EP9pZjOiYWhM6PI5FZeoBDv+SORzeL7?=
 =?us-ascii?Q?IM1Bpu8o4q/frC+OrwvsVFTRTO982VuPWy0iWuP7lnQ4Q5HoltFb1FyiuBML?=
 =?us-ascii?Q?qqT9vrgxzjeQQm5nOlxpktSIVBMwUigbVlUPKSV6CKJDAjqhky5qjAgNlYhW?=
 =?us-ascii?Q?EPpkytGW5r3chCT3EzkuwmFOq1fYcvRWcnBB7ToZO75eHg/egjf2gQE7xgtR?=
 =?us-ascii?Q?FTsnb8rjGNBe4pN49muT3bFLD9HM/4icG9AM5XF7R2+xqTNlbGnno86pkyY2?=
 =?us-ascii?Q?mt/6SVzLk1dkB2ziCOmo4UCs0WOuPIeod9F3MJhWwyowlasLVzs1msxs/QY6?=
 =?us-ascii?Q?JCxAPsH7H0pmnKfUAHTPOpVW0gfnw56DSF16?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 13:05:19.7504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e204e7f-dcae-48f0-3927-08dd8bd57d06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
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

From: Lijo Lazar <lijo.lazar@amd.com>

Except HDP v5.2 all use a common logic for HDP flush. Use a generic
function. HDP v5.2 forces NO_KIQ logic, revisit it later.

Reapply after fixing up an HDP regression.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 18 +-----------------
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c   | 18 +-----------------
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c   | 18 +-----------------
 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c   | 18 +-----------------
 6 files changed, 27 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index b6cf801939aa5..7fd8f09c28e66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -22,6 +22,7 @@
  */
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
+#include <uapi/linux/kfd_ioctl.h>
 
 int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
 {
@@ -46,3 +47,23 @@ int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
 	/* hdp ras follows amdgpu_ras_block_late_init_default for late init */
 	return 0;
 }
+
+void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
+			      struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg) {
+		WREG32((adev->rmmio_remap.reg_offset +
+			KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
+			       2,
+		       0);
+		RREG32((adev->rmmio_remap.reg_offset +
+			KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
+		       2);
+	} else {
+		amdgpu_ring_emit_wreg(ring,
+				      (adev->rmmio_remap.reg_offset +
+				       KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
+					      2,
+				      0);
+	}
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index 7b8a6152dc8d9..4cfd932b7e91e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -44,4 +44,6 @@ struct amdgpu_hdp {
 };
 
 int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev);
+void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
+			      struct amdgpu_ring *ring);
 #endif /* __AMDGPU_HDP_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index cbbeadeb53f72..e6c0d86d34865 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -36,22 +36,6 @@
 #define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK     0x00020000L
 #define mmHDP_MEM_POWER_CTRL_BASE_IDX   0
 
-static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		/* We just need to read back a register to post the write.
-		 * Reading back the remapped register causes problems on
-		 * some platforms so just read back the memory size register.
-		 */
-		if (adev->nbio.funcs->get_memsize)
-			adev->nbio.funcs->get_memsize(adev);
-	} else {
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	}
-}
-
 static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
 				    struct amdgpu_ring *ring)
 {
@@ -185,7 +169,7 @@ struct amdgpu_hdp_ras hdp_v4_0_ras = {
 };
 
 const struct amdgpu_hdp_funcs hdp_v4_0_funcs = {
-	.flush_hdp = hdp_v4_0_flush_hdp,
+	.flush_hdp = amdgpu_hdp_generic_flush,
 	.invalidate_hdp = hdp_v4_0_invalidate_hdp,
 	.update_clock_gating = hdp_v4_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v4_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
index 086a647308df0..8bc001dc9f631 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
@@ -27,22 +27,6 @@
 #include "hdp/hdp_5_0_0_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
 
-static void hdp_v5_0_flush_hdp(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		/* We just need to read back a register to post the write.
-		 * Reading back the remapped register causes problems on
-		 * some platforms so just read back the memory size register.
-		 */
-		if (adev->nbio.funcs->get_memsize)
-			adev->nbio.funcs->get_memsize(adev);
-	} else {
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	}
-}
-
 static void hdp_v5_0_invalidate_hdp(struct amdgpu_device *adev,
 				    struct amdgpu_ring *ring)
 {
@@ -222,7 +206,7 @@ static void hdp_v5_0_init_registers(struct amdgpu_device *adev)
 }
 
 const struct amdgpu_hdp_funcs hdp_v5_0_funcs = {
-	.flush_hdp = hdp_v5_0_flush_hdp,
+	.flush_hdp = amdgpu_hdp_generic_flush,
 	.invalidate_hdp = hdp_v5_0_invalidate_hdp,
 	.update_clock_gating = hdp_v5_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v5_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
index 6ccd31c8bc692..ec20daf4272c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
@@ -30,22 +30,6 @@
 #define regHDP_CLK_CNTL_V6_1	0xd5
 #define regHDP_CLK_CNTL_V6_1_BASE_IDX 0
 
-static void hdp_v6_0_flush_hdp(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		/* We just need to read back a register to post the write.
-		 * Reading back the remapped register causes problems on
-		 * some platforms so just read back the memory size register.
-		 */
-		if (adev->nbio.funcs->get_memsize)
-			adev->nbio.funcs->get_memsize(adev);
-	} else {
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	}
-}
-
 static void hdp_v6_0_update_clock_gating(struct amdgpu_device *adev,
 					 bool enable)
 {
@@ -154,7 +138,7 @@ static void hdp_v6_0_get_clockgating_state(struct amdgpu_device *adev,
 }
 
 const struct amdgpu_hdp_funcs hdp_v6_0_funcs = {
-	.flush_hdp = hdp_v6_0_flush_hdp,
+	.flush_hdp = amdgpu_hdp_generic_flush,
 	.update_clock_gating = hdp_v6_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v6_0_get_clockgating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
index 2c9239a22f398..ed1debc035073 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
@@ -27,22 +27,6 @@
 #include "hdp/hdp_7_0_0_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
 
-static void hdp_v7_0_flush_hdp(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		/* We just need to read back a register to post the write.
-		 * Reading back the remapped register causes problems on
-		 * some platforms so just read back the memory size register.
-		 */
-		if (adev->nbio.funcs->get_memsize)
-			adev->nbio.funcs->get_memsize(adev);
-	} else {
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	}
-}
-
 static void hdp_v7_0_update_clock_gating(struct amdgpu_device *adev,
 					 bool enable)
 {
@@ -142,7 +126,7 @@ static void hdp_v7_0_get_clockgating_state(struct amdgpu_device *adev,
 }
 
 const struct amdgpu_hdp_funcs hdp_v7_0_funcs = {
-	.flush_hdp = hdp_v7_0_flush_hdp,
+	.flush_hdp = amdgpu_hdp_generic_flush,
 	.update_clock_gating = hdp_v7_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v7_0_get_clockgating_state,
 };
-- 
2.49.0

