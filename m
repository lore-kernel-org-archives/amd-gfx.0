Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEDCC77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 03:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C542610E00B;
	Fri, 28 Apr 2023 03:48:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40DF010E00B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 03:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maJzvFkedSh+P/e+eXLc01iu02IdnQFR1gIfst7FHksoHa56q91TOsApkHxbw6PjVV0MqLWA/I4SgySkr7MNSy9ardbMR0B8bopqUK3xX65OFbA8ULDSHCNMYvJzkdxhQ2mQxfXv5TOTzPGC88WF0ICNRnmLH4t6tyAsSqyBsdf09JkuAYEmPJR1rUyu60A7QVAaDLB3LKUU12pGZyDZo3GocXatZBEctYDqKg4rEC/UlzzhsB5b5EbXVcTTNgeffeQykz74LDMdRN+u3pty0Er2JWXkOJ8dj23xBU9G5n1REh5TbzZrO9iapxjjSftT9DWM89EBtEkguQt7uoXd8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WsstgxPCkJdQj1UO6Jq9v9wGMdzEcsT4XnlHEEh8fU=;
 b=nu1agkd5cvxpGKlaGeU3nIFcPU0LDTCzHvbI9Wtf5j25YrW9JGOPHNi3YaxukKc3CKp/LgCX3mwlbLSSIizxZVtwT17l/bWcl87boc/f0qgN9glh7e1byT4eL2UKU19Sy/pM1TgwgUdYHEAQg8huZgl0pkpY8mQv8/AtqioKmg9N36cEKaA7CRDqIIuLyWh8LNcCbYWNL04QCmDqBSyAbz7WGCwt+eYy1AshI9KEC9T+Nj+8am68PpEcmazDD3dx28FWWabqXlU5/8nqYp6tvn9W5Xbn0dyEutwOYKd2TNACqAxr2XSEd4CK4ouf68ba3YsjygdmJ75F719WnoapTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WsstgxPCkJdQj1UO6Jq9v9wGMdzEcsT4XnlHEEh8fU=;
 b=0yKlwhGotGHiZXdQBXbwdIfIaGyJgt5K39JhZbIKwhs7b8PK7/3qdayFaAUmnNlc88m0X/gGuoyfATSzS3Eg8uAxlrwSdSQf3yhazOT61mBvHvIsiDY0kr9K0NIvW7biQ9NtlwGZA4MEwIpC1tcRA2tLH89MqRCDdDclsLxTP0Q=
Received: from BN1PR14CA0027.namprd14.prod.outlook.com (2603:10b6:408:e3::32)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 03:48:30 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::b0) by BN1PR14CA0027.outlook.office365.com
 (2603:10b6:408:e3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23 via Frontend
 Transport; Fri, 28 Apr 2023 03:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.23 via Frontend Transport; Fri, 28 Apr 2023 03:48:30 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 22:48:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 20:48:29 -0700
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Thu, 27 Apr 2023 22:48:21 -0500
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <hawking.zhang@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4] drm/amdgpu: drop gfx_v11_0_cp_ecc_error_irq_funcs
Date: Thu, 27 Apr 2023 23:48:16 -0400
Message-ID: <20230428034816.3569-1-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 24315272-fb4e-417c-67e6-08db479b6e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LGKVnfPqIQLNI1HmnAgSS6llZDE/4R7sTAJVvxUqbzr+zhmuW3N5vAy333lF4LgvYnA0vBBajO2uNO0/KHquRgD8gblbfpfL+MGk4UxRI5p/BCiG2FUdJkCaoK3JyiT1iuYHPEC+IHl58RXma/1/0oj/Qcub5UZwN79vk4ZUbRJu79j2+N0v4WEBGI/9xD1TBf8JNiDI49OBiccwa4oFmU45bQ5Fp7lY0Ml0QAeQIjPHseRUt5D37VTM/kI/tLePVgMYM1YWe7gPphFcU93pggx1QnwFzVzuf1EzRot5I+PlmMIfhnOQSjXGAk6Bqi1Ay/InW0Uq9siSrwcwb29v00BOcNPPb49rug+N9izHxr8lwgpjR/NpC45up8S4Nvxz1QGORpna3q2T3lsKTS18j/nKDx0gMzUOEtxzQeJmBfmRPmisBL8VMR6SPrliAsODOH0VVvr6tq30MSG0zzuJNEz3w4QPoWbVM6HUi+n14vF23/d8M3lOSHgH6yp9+2KNSuFO6aeq5FC7OC9JTZZ9Vefhjj2nDQOJwmyZq3ja2MuTSqARqs0nHpgZgYvRI0DNd1d6lIbgmJjXCFLf8gggzYBeqDVSUPNltQOVTtlhcil21YBF/xjMhV+eejMKccpfLcoan/UovUb15TMxECHZgEnXjxOSjabgJwLqDbjbkKQ1mbkhGa3KEi/GP2jYVrQs+h8Mro0HnPWOK5s2aEZhslucOSfmeyiubbSx3uhXwYM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(36860700001)(2616005)(426003)(336012)(66574015)(83380400001)(47076005)(82310400005)(40480700001)(82740400003)(356005)(36756003)(86362001)(81166007)(40460700003)(110136005)(54906003)(70206006)(7696005)(478600001)(6666004)(8936002)(5660300002)(8676002)(70586007)(2906002)(4326008)(316002)(41300700001)(1076003)(186003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 03:48:30.2973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24315272-fb4e-417c-67e6-08db479b6e96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
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
Cc: Horatio Zhang <Hongkun.Zhang@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 longlong.yao@amd.com, Feifei Xu <Feifei.Xu@amd.com>, yipeng.chai@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The gfx.cp_ecc_error_irq is retired in gfx11. In gfx_v11_0_hw_fini still
use amdgpu_irq_put to disable this interrupt, which caused the call trace
in this function.

[  102.873958] Call Trace:
[  102.873959]  <TASK>
[  102.873961]  gfx_v11_0_hw_fini+0x23/0x1e0 [amdgpu]
[  102.874019]  gfx_v11_0_suspend+0xe/0x20 [amdgpu]
[  102.874072]  amdgpu_device_ip_suspend_phase2+0x240/0x460 [amdgpu]
[  102.874122]  amdgpu_device_ip_suspend+0x3d/0x80 [amdgpu]
[  102.874172]  amdgpu_device_pre_asic_reset+0xd9/0x490 [amdgpu]
[  102.874223]  amdgpu_device_gpu_recover.cold+0x548/0xce6 [amdgpu]
[  102.874321]  amdgpu_debugfs_reset_work+0x4c/0x70 [amdgpu]
[  102.874375]  process_one_work+0x21f/0x3f0
[  102.874377]  worker_thread+0x200/0x3e0
[  102.874378]  ? process_one_work+0x3f0/0x3f0
[  102.874379]  kthread+0xfd/0x130
[  102.874380]  ? kthread_complete_and_exit+0x20/0x20
[  102.874381]  ret_from_fork+0x22/0x30

v2:
- Handle umc and gfx ras cases in separated patch
- Retired the gfx_v11_0_cp_ecc_error_irq_funcs in gfx11

v3:
- Improve the subject and code comments
- Add judgment on gfx11 in the function of amdgpu_gfx_ras_late_init

v4:
- Drop the define of CP_ME1_PIPE_INST_ADDR_INTERVAL and 
SET_ECC_ME_PIPE_STATE which using in gfx_v11_0_set_cp_ecc_error_state
- Check cp_ecc_error_irq.funcs rather than ip version for a more 
sustainable life

Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  8 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 46 -------------------------
 2 files changed, 5 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 66b9740ec376..042f69e1ef91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -720,9 +720,11 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 		if (r)
 			return r;
 
-		r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
-		if (r)
-			goto late_fini;
+		if (!(adev->gfx.cp_ecc_error_irq.funcs == NULL)) {
+			r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
+			if (r)
+				goto late_fini;
+		}
 	} else {
 		amdgpu_ras_feature_enable_on_boot(adev, ras_block, 0);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8a4c4769e607..4ba21f798c72 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1355,13 +1355,6 @@ static int gfx_v11_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	/* ECC error */
-	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
-				  GFX_11_0_0__SRCID__CP_ECC_ERROR,
-				  &adev->gfx.cp_ecc_error_irq);
-	if (r)
-		return r;
-
 	/* FED error */
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GFX,
 				  GFX_11_0_0__SRCID__RLC_GC_FED_INTERRUPT,
@@ -4483,7 +4476,6 @@ static int gfx_v11_0_hw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
-	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
@@ -5962,36 +5954,6 @@ static void gfx_v11_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev
 	}
 }
 
-#define CP_ME1_PIPE_INST_ADDR_INTERVAL  0x1
-#define SET_ECC_ME_PIPE_STATE(reg_addr, state) \
-	do { \
-		uint32_t tmp = RREG32_SOC15_IP(GC, reg_addr); \
-		tmp = REG_SET_FIELD(tmp, CP_ME1_PIPE0_INT_CNTL, CP_ECC_ERROR_INT_ENABLE, state); \
-		WREG32_SOC15_IP(GC, reg_addr, tmp); \
-	} while (0)
-
-static int gfx_v11_0_set_cp_ecc_error_state(struct amdgpu_device *adev,
-							struct amdgpu_irq_src *source,
-							unsigned type,
-							enum amdgpu_interrupt_state state)
-{
-	uint32_t ecc_irq_state = 0;
-	uint32_t pipe0_int_cntl_addr = 0;
-	int i = 0;
-
-	ecc_irq_state = (state == AMDGPU_IRQ_STATE_ENABLE) ? 1 : 0;
-
-	pipe0_int_cntl_addr = SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE0_INT_CNTL);
-
-	WREG32_FIELD15_PREREG(GC, 0, CP_INT_CNTL_RING0, CP_ECC_ERROR_INT_ENABLE, ecc_irq_state);
-
-	for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++)
-		SET_ECC_ME_PIPE_STATE(pipe0_int_cntl_addr + i * CP_ME1_PIPE_INST_ADDR_INTERVAL,
-					ecc_irq_state);
-
-	return 0;
-}
-
 static int gfx_v11_0_set_eop_interrupt_state(struct amdgpu_device *adev,
 					    struct amdgpu_irq_src *src,
 					    unsigned type,
@@ -6408,11 +6370,6 @@ static const struct amdgpu_irq_src_funcs gfx_v11_0_priv_inst_irq_funcs = {
 	.process = gfx_v11_0_priv_inst_irq,
 };
 
-static const struct amdgpu_irq_src_funcs gfx_v11_0_cp_ecc_error_irq_funcs = {
-	.set = gfx_v11_0_set_cp_ecc_error_state,
-	.process = amdgpu_gfx_cp_ecc_error_irq,
-};
-
 static const struct amdgpu_irq_src_funcs gfx_v11_0_rlc_gc_fed_irq_funcs = {
 	.process = gfx_v11_0_rlc_gc_fed_irq,
 };
@@ -6428,9 +6385,6 @@ static void gfx_v11_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gfx.priv_inst_irq.num_types = 1;
 	adev->gfx.priv_inst_irq.funcs = &gfx_v11_0_priv_inst_irq_funcs;
 
-	adev->gfx.cp_ecc_error_irq.num_types = 1; /* CP ECC error */
-	adev->gfx.cp_ecc_error_irq.funcs = &gfx_v11_0_cp_ecc_error_irq_funcs;
-
 	adev->gfx.rlc_gc_fed_irq.num_types = 1; /* 0x80 FED error */
 	adev->gfx.rlc_gc_fed_irq.funcs = &gfx_v11_0_rlc_gc_fed_irq_funcs;
 
-- 
2.34.1

