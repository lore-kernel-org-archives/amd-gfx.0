Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB8CC0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 04:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4FF020578
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 04:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xKd+uBQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FF020578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF9FE89123;
	Mon, 16 Mar 2020 04:05:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B24D489123
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 04:05:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfR5OBqQ4b3h/lkxeFuHj5vAjIzztdz+7EZ4yvkkAsdAQbXbDu+2asrqEpbTWriUgblSF19Iinn8S9ORvrzze0ZGXwXm4RHYj7jk9BdsV0kQRA5NaYYy9IId+qOAViXjcXUrt6PuYpBBheE4ZiivHWgAjfqcOgPzdMRUL2ynCrCHOq55ksLf2Az++HmKFgDr5fxyfWA9vfM5FATdXXJIevcNXVEhbHGrQkR39xgTXUrRUhp4GbaXUZpxsKVi4ho0Z6fnLXSyDuTAn/ItAatPrfieB4pEQZLdNlAVSiW9v00jb0NonZxWHzpGEt1k485YH5d2VwXMOovsUb3F/CxK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QirAzUNP4Ida2XzwetrCx0A2t/8FoIn1rkf7UT3Mpgw=;
 b=Fwi4XcRg6kOYrfmKy0Ivx2krIrmvjrqatox0F8UDiMRQRhrlzNE/Id9rNs3N20Pbc/e0v23OT4o5K3ecxFhR2f9jE7rVANst7Y1NaoRMOQUvImUOUwwtyEyrNAf4LANY2QqspM7sKYCksDkEFGu4r1S51IHRU2Cpbzc50JqWQ4ouS6IzRfOva7tCiSX5KqTefxgUGtYiUMZctcnS1wbdroXzCktSmoGStJ+ZFAXdXs7NwZisUE+mbX8m3jTou+wc1EYlMFkWfDLscETqDeOvREgCXJjVPMvOk7cdgQZEOHxAklxNlpIzSrif8tPVK4ipedDyOFfPGoXmeEBK6qn/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QirAzUNP4Ida2XzwetrCx0A2t/8FoIn1rkf7UT3Mpgw=;
 b=xKd+uBQWW9CrntJmd6kd03gBUprjXmp3Va0i09qOMF4iIOlZrvBcADO6IjKfjMXET+/70z9CZmx9InMKkHuCHcf+HQ3QmPFY5ADklvz3+QfMBMhaA7DG5igFlR7vzRmkuE/Cpf9xCjcgYwt4/ntfJvu7K513FoVvOwoWj3fm7K8=
Received: from BN6PR13CA0012.namprd13.prod.outlook.com (2603:10b6:404:10a::22)
 by DM5PR12MB1673.namprd12.prod.outlook.com (2603:10b6:4:e::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16; Mon, 16 Mar 2020 04:05:40 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::a6) by BN6PR13CA0012.outlook.office365.com
 (2603:10b6:404:10a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.7 via Frontend
 Transport; Mon, 16 Mar 2020 04:05:40 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Mon, 16 Mar 2020 04:05:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 15 Mar
 2020 23:05:39 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 15 Mar
 2020 23:05:39 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 15 Mar 2020 23:05:38 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: revise RLCG access path
Date: Mon, 16 Mar 2020 12:05:34 +0800
Message-ID: <1584331534-28939-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(136003)(346002)(428003)(199004)(46966005)(81156014)(81166006)(8676002)(2616005)(336012)(186003)(26005)(8936002)(426003)(86362001)(7696005)(70206006)(47076004)(70586007)(54906003)(316002)(30864003)(478600001)(2906002)(6916009)(5660300002)(356004)(4326008)(36756003)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1673; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6a5eec9-5af7-4519-912a-08d7c95f4a22
X-MS-TrafficTypeDiagnostic: DM5PR12MB1673:
X-Microsoft-Antispam-PRVS: <DM5PR12MB167314A8FCDED0721AE62C2384F90@DM5PR12MB1673.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 03449D5DD1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FejgsJG5EtVa6DDuYrvlYLZq8X6H4ahroPsY6dRSgY39Ec/oU3Z+O6iu2pKhCP1rUX+qO7eFRIumyheiB+DthwouxlnsTu8OVL9510hmp7mGctwo3AReCoQG1RHZiY+08bfz6Dz+s3MtTfeek6zZcLVLKiGPIWmwNcbDBtG6hAmWhczlBGLYTJFWQfZTJCGgIjGsrroRZ0dtH9Wcm8Z3N2YBu9QVAThC6FWcsxQ8iC9Kb34mzHE5DdYnZ7gBl6iUKZJE0t720JfwEF9iB3fyqm6OXOI6zcQOY8jwJb1e7MkwCdkY0CrQfAK1rVmkbPFlVdVW9jQgGAWBQz42QzOYj7jPgLhXuDGl/tEDPAoW4mrCprblpttaeImQGepXDfTVIegeU/neaYhghFUU5n/LtZ/OcGqLk4j7CXD8I6WPnxQPMVrr+i117pCnrfBCiH5IOo7P1PzEX3Vcm0hZEMKE2Vpn7LQr1LGKg49YJYbYPPknjCI63QzH5+D3ziaDbb6UsI/zmZm4h4pDYmtM2I0K/w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 04:05:39.8640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a5eec9-5af7-4519-912a-08d7c95f4a22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1673
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

what changed:
1)provide new implementation interface for the rlcg access path
2)put SQ_CMD/SQ_IND_INDEX to GFX9 RLCG path to let debugfs's reg_op
function can access reg that need RLCG path help

now even debugfs's reg_op can used to dump wave.

tested-by: Monk Liu <monk.liu@amd.com>
tested-by: Zhou pengju <pengju.zhou@amd.com>
Signed-off-by: Zhou pengju <pengju.zhou@amd.com>
Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 50 +++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h     |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  3 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      | 74 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 95 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/soc15.h          |  7 +++
 drivers/gpu/drm/amd/amdgpu/soc15_common.h   |  5 +-
 9 files changed, 221 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c00831f..87c25230 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -999,6 +999,8 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 			uint32_t acc_flags);
 void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags);
+void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
+		    uint32_t acc_flags);
 void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value);
 uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 02bb1be1..c0f9a65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -179,7 +179,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 		} else {
 			r = get_user(value, (uint32_t *)buf);
 			if (!r)
-				WREG32(*pos >> 2, value);
+				amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, value, 0);
 		}
 		if (r) {
 			result = r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a35c899..729565f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -306,6 +306,26 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
 		BUG();
 }
 
+void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t acc_flags)
+{
+	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
+
+	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
+		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
+	else {
+		unsigned long flags;
+
+		spin_lock_irqsave(&adev->mmio_idx_lock, flags);
+		writel((reg * 4), ((void __iomem *)adev->rmmio) + (mmMM_INDEX * 4));
+		writel(v, ((void __iomem *)adev->rmmio) + (mmMM_DATA * 4));
+		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
+	}
+
+	if (adev->asic_type >= CHIP_VEGA10 && reg == 1 && adev->last_mm_index == 0x5702C) {
+		udelay(500);
+	}
+}
+
 /**
  * amdgpu_mm_wreg - write to a memory mapped IO register
  *
@@ -319,8 +339,6 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
 void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags)
 {
-	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
-
 	if (adev->asic_type >= CHIP_VEGA10 && reg == 0) {
 		adev->last_mm_index = v;
 	}
@@ -328,20 +346,26 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 	if ((acc_flags & AMDGPU_REGS_KIQ) || (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev)))
 		return amdgpu_kiq_wreg(adev, reg, v);
 
-	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
-		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
-	else {
-		unsigned long flags;
+	amdgpu_mm_wreg_mmio(adev, reg, v, acc_flags);
+}
 
-		spin_lock_irqsave(&adev->mmio_idx_lock, flags);
-		writel((reg * 4), ((void __iomem *)adev->rmmio) + (mmMM_INDEX * 4));
-		writel(v, ((void __iomem *)adev->rmmio) + (mmMM_DATA * 4));
-		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
-	}
+/*
+ * amdgpu_mm_wreg_mmio_rlc -  write register either with mmio or with RLC path if in range
+ *
+ * this function is invoked only the debugfs register access
+ * */
+void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
+		    uint32_t acc_flags)
+{
+	if (amdgpu_sriov_fullaccess(adev) &&
+		adev->gfx.rlc.funcs &&
+		adev->gfx.rlc.funcs->is_rlcg_access_range) {
 
-	if (adev->asic_type >= CHIP_VEGA10 && reg == 1 && adev->last_mm_index == 0x5702C) {
-		udelay(500);
+		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
+			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v);
 	}
+
+	amdgpu_mm_wreg_mmio(adev, reg, v, acc_flags);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 52509c2..60bb3e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -127,6 +127,8 @@ struct amdgpu_rlc_funcs {
 	void (*reset)(struct amdgpu_device *adev);
 	void (*start)(struct amdgpu_device *adev);
 	void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
+	void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v);
+	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);
 };
 
 struct amdgpu_rlc {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index daaf909..f0128f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -270,6 +270,9 @@ struct amdgpu_virt {
 #define amdgpu_sriov_runtime(adev) \
 ((adev)->virt.caps & AMDGPU_SRIOV_CAPS_RUNTIME)
 
+#define amdgpu_sriov_fullaccess(adev) \
+(amdgpu_sriov_vf((adev)) && !amdgpu_sriov_runtime((adev)))
+
 #define amdgpu_passthrough(adev) \
 ((adev)->virt.caps & AMDGPU_PASSTHROUGH_MODE)
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 82ef08d..d1cdcb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -224,6 +224,49 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00800000)
 };
 
+static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
+{
+	static void *scratch_reg0;
+	static void *scratch_reg1;
+	static void *scratch_reg2;
+	static void *scratch_reg3;
+	static void *spare_int;
+	static uint32_t grbm_cntl;
+	static uint32_t grbm_idx;
+	uint32_t i = 0;
+	uint32_t retries = 50000;
+
+	scratch_reg0 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
+	scratch_reg1 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
+	scratch_reg2 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG2)*4;
+	scratch_reg3 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG3)*4;
+	spare_int = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] + mmRLC_SPARE_INT)*4;
+
+	grbm_cntl = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_IDX] + mmGRBM_GFX_CNTL;
+	grbm_idx = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_IDX] + mmGRBM_GFX_INDEX;
+
+	if (amdgpu_sriov_runtime(adev)) {
+		pr_err("shoudn't call rlcg write register during runtime\n");
+		return;
+	}
+
+	writel(v, scratch_reg0);
+	writel(offset | 0x80000000, scratch_reg1);
+	writel(1, spare_int);
+	for (i = 0; i < retries; i++) {
+		u32 tmp;
+
+		tmp = readl(scratch_reg1);
+		if (!(tmp & 0x80000000))
+			break;
+
+		udelay(10);
+	}
+
+	if (i >= retries)
+		pr_err("timeout: rlcg program reg:0x%05x failed !\n", offset);
+}
+
 static const struct soc15_reg_golden golden_settings_gc_10_1_nv14[] =
 {
 	/* Pending on emulation bring up */
@@ -4247,6 +4290,33 @@ static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 	WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
 }
 
+static bool gfx_v10_0_check_rlcg_range(struct amdgpu_device *adev,
+					uint32_t offset,
+					struct soc15_reg_rlcg *entries, int arr_size)
+{
+	int i;
+	uint32_t reg;
+
+	if (!entries)
+		return false;
+
+	for (i = 0; i < arr_size; i++) {
+		const struct soc15_reg_rlcg *entry;
+
+		entry = &entries[i];
+		reg = adev->reg_offset[entry->hwip][entry->instance][entry->segment] + entry->reg;
+		if (offset == reg)
+			return true;
+	}
+
+	return false;
+}
+
+static bool gfx_v10_0_is_rlcg_access_range(struct amdgpu_device *adev, u32 offset)
+{
+	return gfx_v10_0_check_rlcg_range(adev, offset, NULL, 0);
+}
+
 static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
 	.is_rlc_enabled = gfx_v10_0_is_rlc_enabled,
 	.set_safe_mode = gfx_v10_0_set_safe_mode,
@@ -4258,7 +4328,9 @@ static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
 	.stop = gfx_v10_0_rlc_stop,
 	.reset = gfx_v10_0_rlc_reset,
 	.start = gfx_v10_0_rlc_start,
-	.update_spm_vmid = gfx_v10_0_update_spm_vmid
+	.update_spm_vmid = gfx_v10_0_update_spm_vmid,
+	.rlcg_wreg = gfx_v10_rlcg_wreg,
+	.is_rlcg_access_range = gfx_v10_0_is_rlcg_access_range,
 };
 
 static int gfx_v10_0_set_powergating_state(void *handle,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index fb9c45f..18e2b57 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -697,6 +697,11 @@ static const struct soc15_reg_golden golden_settings_gc_9_4_1_arct[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_FIFO_SIZES, 0xffffffff, 0x00000f00),
 };
 
+static const struct soc15_reg_rlcg rlcg_access_gc_9_0[] = {
+	{SOC15_REG_ENTRY(GC, 0, mmGRBM_GFX_INDEX)},
+	{SOC15_REG_ENTRY(GC, 0, mmSQ_IND_INDEX)},
+};
+
 static const u32 GFX_RLC_SRM_INDEX_CNTL_ADDR_OFFSETS[] =
 {
 	mmRLC_SRM_INDEX_CNTL_ADDR_0 - mmRLC_SRM_INDEX_CNTL_ADDR_0,
@@ -721,6 +726,63 @@ static const u32 GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
 	mmRLC_SRM_INDEX_CNTL_DATA_7 - mmRLC_SRM_INDEX_CNTL_DATA_0,
 };
 
+void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
+{
+	static void *scratch_reg0;
+	static void *scratch_reg1;
+	static void *scratch_reg2;
+	static void *scratch_reg3;
+	static void *spare_int;
+	static uint32_t grbm_cntl;
+	static uint32_t grbm_idx;
+	bool shadow;
+
+	scratch_reg0 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
+	scratch_reg1 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
+	scratch_reg2 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG2)*4;
+	scratch_reg3 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG3)*4;
+	spare_int = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] + mmRLC_SPARE_INT)*4;
+
+	grbm_cntl = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_IDX] + mmGRBM_GFX_CNTL;
+	grbm_idx = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_IDX] + mmGRBM_GFX_INDEX;
+
+	if (amdgpu_sriov_runtime(adev)) {
+		pr_err("shoudn't call rlcg write register during runtime\n");
+		return;
+	}
+
+	if (offset == grbm_cntl || offset == grbm_idx)
+		shadow = true;
+
+	if (shadow) {
+		if (offset  == grbm_cntl)
+			writel(v, scratch_reg2);
+		else if (offset == grbm_idx)
+			writel(v, scratch_reg3);
+
+		writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
+	} else {
+		uint32_t i = 0;
+		uint32_t retries = 50000;
+
+		writel(v, scratch_reg0);
+		writel(offset | 0x80000000, scratch_reg1);
+		writel(1, spare_int);
+		for (i = 0; i < retries; i++) {
+			u32 tmp;
+
+			tmp = readl(scratch_reg1);
+			if (!(tmp & 0x80000000))
+				break;
+
+			udelay(10);
+		}
+		if (i >= retries)
+			pr_err("timeout: rlcg program reg:0x%05x failed !\n", offset);
+	}
+
+}
+
 #define VEGA10_GB_ADDR_CONFIG_GOLDEN 0x2a114042
 #define VEGA12_GB_ADDR_CONFIG_GOLDEN 0x24104041
 #define RAVEN_GB_ADDR_CONFIG_GOLDEN 0x24000042
@@ -4908,6 +4970,35 @@ static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 	WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
 }
 
+static bool gfx_v9_0_check_rlcg_range(struct amdgpu_device *adev,
+					uint32_t offset,
+					struct soc15_reg_rlcg *entries, int arr_size)
+{
+	int i;
+	uint32_t reg;
+
+	if (!entries)
+		return false;
+
+	for (i = 0; i < arr_size; i++) {
+		const struct soc15_reg_rlcg *entry;
+
+		entry = &entries[i];
+		reg = adev->reg_offset[entry->hwip][entry->instance][entry->segment] + entry->reg;
+		if (offset == reg)
+			return true;
+	}
+
+	return false;
+}
+
+static bool gfx_v9_0_is_rlcg_access_range(struct amdgpu_device *adev, u32 offset)
+{
+	return gfx_v9_0_check_rlcg_range(adev, offset,
+					(void *)rlcg_access_gc_9_0,
+					ARRAY_SIZE(rlcg_access_gc_9_0));
+}
+
 static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
 	.is_rlc_enabled = gfx_v9_0_is_rlc_enabled,
 	.set_safe_mode = gfx_v9_0_set_safe_mode,
@@ -4920,7 +5011,9 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
 	.stop = gfx_v9_0_rlc_stop,
 	.reset = gfx_v9_0_rlc_reset,
 	.start = gfx_v9_0_rlc_start,
-	.update_spm_vmid = gfx_v9_0_update_spm_vmid
+	.update_spm_vmid = gfx_v9_0_update_spm_vmid,
+	.rlcg_wreg = gfx_v9_0_rlcg_wreg,
+	.is_rlcg_access_range = gfx_v9_0_is_rlcg_access_range,
 };
 
 static int gfx_v9_0_set_powergating_state(void *handle,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index d0fb7a6..b03f950 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -42,6 +42,13 @@ struct soc15_reg_golden {
 	u32	or_mask;
 };
 
+struct soc15_reg_rlcg {
+	u32	hwip;
+	u32	instance;
+	u32	segment;
+	u32	reg;
+};
+
 struct soc15_reg_entry {
 	uint32_t hwip;
 	uint32_t inst;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 19e870c..c893c64 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -70,10 +70,9 @@
 		}						\
 	} while (0)
 
-#define AMDGPU_VIRT_SUPPORT_RLC_PRG_REG(a) (amdgpu_sriov_vf((a)) && !amdgpu_sriov_runtime((a)))
 #define WREG32_RLC(reg, value) \
 	do {							\
-		if (AMDGPU_VIRT_SUPPORT_RLC_PRG_REG(adev)) {    \
+		if (amdgpu_sriov_fullaccess(adev)) {    \
 			uint32_t i = 0;	\
 			uint32_t retries = 50000;	\
 			uint32_t r0 = adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0;	\
@@ -98,7 +97,7 @@
 #define WREG32_SOC15_RLC_SHADOW(ip, inst, reg, value) \
 	do {							\
 		uint32_t target_reg = adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg;\
-		if (AMDGPU_VIRT_SUPPORT_RLC_PRG_REG(adev)) {    \
+		if (amdgpu_sriov_fullaccess(adev)) {    \
 			uint32_t r2 = adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG2;	\
 			uint32_t r3 = adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG3;	\
 			uint32_t grbm_cntl = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_IDX] + mmGRBM_GFX_CNTL;   \
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
