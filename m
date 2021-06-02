Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72553C47080
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 02:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1861460720
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 02:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1861460720
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA3CD6EB45;
	Wed,  2 Jun 2021 02:05:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA386EB45
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 02:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoGj6exhmXRgqcVsSAFNRhoMSG5faUwxeGzCMll53fGQg8Wq5uVKJ4pxEzBT3daH5p2T5EVDwM4ERnaRhKLlsMve0mpCEP2GLpJVagM3eWOjAAfnnZQSvaqNIVU+IU23eIF0CJSFrYDHq7MoMKWnmCdXVniyNhZdDmmlRIZcArzQeUVUoXrp9Rxg549ekTCNLriEa7Uv6aIsDWupJsQWC5Mw+1HBrCflcIFapEQ7mpVPwwcUuvj/OwxFFrLWC6enB1Gqgq99Wyo9Qe2fgt9EdtSHsbXhH1z8oexWA6UjAYJS3mxoF55xwRlsn121rA+irt0NRH+1YrpqnRpdkp2JsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHCrk1sQfE+2ygQd5n0t6F8o8wCJODcA3xYoT6dPO7M=;
 b=C8S8bCsusvGXXEjUxoEBHqTff0XM+u58Uqy4yyRpTdzkKV3ZoBy2xxlN1R0Oh/Nbh3tGUkvkNHY7UFBCfdyLYO2CGZGFOOlitAtx1c+sKjnQ0sPOPuQl2mcCIoDfErwoOQ3loCv1bu+1194npIkFRIsELnhCgtw7Irl25JuNRoEzfUIuBwJKlUGW7sJP+ZMZTkcpSIQmxto5GueugsDtG0oE3OKl/5xAUiFxQ/rD3vhZFTnUHcs9pQIUwmjq5LQHqbmbXxMqQLn8NXVvGYpAaLHeAIqBGi2in0c+whnkAC+Px3JzBDQwJFex9tXEY8GbVyKjWUuH3d4Nc3oYkLtnYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHCrk1sQfE+2ygQd5n0t6F8o8wCJODcA3xYoT6dPO7M=;
 b=bGhlhQHzX5+nFP8fk9IxGIMQG9HoO2uWJcKY1rJVbW6xPObcO+SVAKtGxomwQpJPBNsDKc9j1zJKNdZiMFqRazvRWnRHOWNYQQmBu/8+0X7UHW+RbJoqJBa1PUksJHiblmxKbJbKqT6bRoDwmbQ4ZSXeU/6mpgQmdslUPmdFVBg=
Received: from BN9P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::18)
 by BL0PR12MB2545.namprd12.prod.outlook.com (2603:10b6:207:4e::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 02:05:15 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::8e) by BN9P220CA0013.outlook.office365.com
 (2603:10b6:408:13e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Wed, 2 Jun 2021 02:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 02:05:15 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 21:05:14 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: Don't flush/invalidate HDP for APUs and A+A
Date: Tue, 1 Jun 2021 22:04:58 -0400
Message-ID: <20210602020458.781206-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0a3ee7c-0451-4437-a302-08d9256add16
X-MS-TrafficTypeDiagnostic: BL0PR12MB2545:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2545DFBD875E4BAFCA3C2013823D9@BL0PR12MB2545.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHUe4vK5Jm5Pcq39eggUQBDCEOfYe90UXf7BiH6vIGxaPxJ5wph5z68ygdTmmn7iLrKV5wRwE8Lp4fkdnEkwUN6khG+B0uCPE3JvwizH44YjHYUxvRRoBhRHp6+76tPEa4svAgbAgfz/v3UbyHrAlZ3a2yw7gs80ZcfKj1YX+La2rMTCHfamcBdg/BckHJtz6TFy/X3BoepSDySw9PqxM6Yqbw8VVzv78Y1CzqfM8Y/s/aD4LnXOnEslM+CeLdWKD0jpfiZdAZRmY35CDMFEdTbEMNy0dIKwqUnXepdRzwt+5NNB7ywH0vb77L55h1g1SxNaEjjtyCxVqH1ogNeau5ZSzQCB0GbFzi0xz33kwLxglHWI/m1Py6HhNiDTAHQUroBPutupbEMB2rwnNi81+JpKAPHNkEPg2JraxAALjBBHJfy1/JdFQKdQE3byRAZroskOKT6LL1sk1I1GOkExgPGkBW9zKB8Ky8gT8eIBFxe5cJ6intWHGLLOd+HYEeRfmVjcEyyj4JYk7vVtUHG5tFtkbKw/W1Vxv9ZLOiPy5Zb+MHkeFzWIMLbCTTZeRiLwDw3TQuaSTcx9uHjXkLUm9DLWiMbRff6HhBUWnLyOzxQIGTC8PtIi6a313qHJ2A64SPfdKsPbZVRm6ijuwG00jzq+k503/1X8hyXaageyxLorIbm0N6c/aPCn21CK2g3p
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(46966006)(36840700001)(82740400003)(81166007)(83380400001)(356005)(16526019)(186003)(36860700001)(26005)(4326008)(336012)(36756003)(86362001)(6916009)(478600001)(2906002)(8936002)(8676002)(47076005)(316002)(5660300002)(6666004)(70586007)(1076003)(82310400003)(426003)(70206006)(7696005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 02:05:15.5215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a3ee7c-0451-4437-a302-08d9256add16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2545
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Integrate two macros into two generic functions and add
no_flush flag to determine if HDP flush is needed for
all Asics.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  9 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 15 ++---------
 4 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1e3cd4ce9e91..224552d38240 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1297,10 +1297,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_read_bios_from_rom(adev, b, l) (adev)->asic_funcs->read_bios_from_rom((adev), (b), (l))
 #define amdgpu_asic_read_register(adev, se, sh, offset, v)((adev)->asic_funcs->read_register((adev), (se), (sh), (offset), (v)))
 #define amdgpu_asic_get_config_memsize(adev) (adev)->asic_funcs->get_config_memsize((adev))
-#define amdgpu_asic_flush_hdp(adev, r) \
-	((adev)->asic_funcs->flush_hdp ? (adev)->asic_funcs->flush_hdp((adev), (r)) : (adev)->hdp.funcs->flush_hdp((adev), (r)))
-#define amdgpu_asic_invalidate_hdp(adev, r) \
-	((adev)->asic_funcs->invalidate_hdp ? (adev)->asic_funcs->invalidate_hdp((adev), (r)) : (adev)->hdp.funcs->invalidate_hdp((adev), (r)))
 #define amdgpu_asic_need_full_reset(adev) (adev)->asic_funcs->need_full_reset((adev))
 #define amdgpu_asic_init_doorbell_index(adev) (adev)->asic_funcs->init_doorbell_index((adev))
 #define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs->get_pcie_usage((adev), (cnt0), (cnt1)))
@@ -1314,6 +1310,11 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 
 #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
 
+void amdgpu_asic_flush_hdp(struct amdgpu_device *adev,
+		struct amdgpu_ring *ring);
+void amdgpu_asic_invalidate_hdp(struct amdgpu_device *adev,
+		struct amdgpu_ring *ring);
+
 /* Common functions */
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
 bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9c4d33f649f7..951feefb5e76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3505,6 +3505,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		goto failed_unmap;
 
+	if ((adev->flags & AMD_IS_APU) || adev->gmc.xgmi.connected_to_cpu)
+		adev->hdp.no_flush = true;
+
 	/* doorbell bar mapping and doorbell index init*/
 	amdgpu_device_doorbell_init(adev);
 
@@ -5548,3 +5551,29 @@ bool amdgpu_device_is_headless(struct amdgpu_device *adev)
     /* Check if it is NV's VGA class while VCN is harvest, it is headless*/
     return nv_is_headless_sku(adev->pdev);
 }
+
+void amdgpu_asic_flush_hdp(struct amdgpu_device *adev,
+		struct amdgpu_ring *ring)
+{
+	if (adev->hdp.no_flush)
+		return;
+
+	if (ring->funcs->emit_hdp_flush)
+		amdgpu_ring_emit_hdp_flush(ring);
+	else if (adev->asic_funcs->flush_hdp)
+		adev->asic_funcs->flush_hdp(adev, ring);
+	else
+		adev->hdp.funcs->flush_hdp(adev, ring);
+}
+
+void amdgpu_asic_invalidate_hdp(struct amdgpu_device *adev,
+		struct amdgpu_ring *ring)
+{
+	if (adev->hdp.no_flush)
+		return;
+
+	if (adev->asic_funcs->invalidate_hdp)
+		adev->asic_funcs->invalidate_hdp(adev, ring);
+	else
+		adev->hdp.funcs->invalidate_hdp(adev, ring);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index 7ec99d591584..1ca23f2f51d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -44,6 +44,7 @@ struct amdgpu_hdp {
 	struct ras_common_if			*ras_if;
 	const struct amdgpu_hdp_funcs		*funcs;
 	const struct amdgpu_hdp_ras_funcs	*ras_funcs;
+	bool	no_flush;
 };
 
 int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index aaa2574ce9bc..6db676c4c7e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -222,15 +222,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	if (job && ring->funcs->init_cond_exec)
 		patch_offset = amdgpu_ring_init_cond_exec(ring);
 
-#ifdef CONFIG_X86_64
-	if (!(adev->flags & AMD_IS_APU))
-#endif
-	{
-		if (ring->funcs->emit_hdp_flush)
-			amdgpu_ring_emit_hdp_flush(ring);
-		else
-			amdgpu_asic_flush_hdp(adev, ring);
-	}
+	amdgpu_asic_flush_hdp(adev, ring);
 
 	if (need_ctx_switch)
 		status |= AMDGPU_HAVE_CTX_SWITCH;
@@ -267,10 +259,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	if (job && ring->funcs->emit_frame_cntl)
 		amdgpu_ring_emit_frame_cntl(ring, false, secure);
 
-#ifdef CONFIG_X86_64
-	if (!(adev->flags & AMD_IS_APU))
-#endif
-		amdgpu_asic_invalidate_hdp(adev, ring);
+	amdgpu_asic_invalidate_hdp(adev, ring);
 
 	if (ib->flags & AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE)
 		fence_flags |= AMDGPU_FENCE_FLAG_TC_WB_ONLY;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
