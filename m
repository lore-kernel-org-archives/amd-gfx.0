Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEC1C77B60
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 08:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AA1610E1A4;
	Wed, 26 Apr 2023 08:40:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17CF510E1A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 08:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhmRJA0F0bLgPaM5kQkxllCJeiTuFG3UH7dh/RG7THGGOct2J/cr/HCdOKapH9dsxFWJX+nbeGen95EZGZ/ih/ie2FJPsQOuPhMkxoI61xeEEW8ycTfF1jQ9SpsbInveiAgguDWhbAVC+oFH5Qlvva5HUhmMxxMD92aPRZ08fDFBMkQ3JFGR9uUyufGZ+WJxuf/HaAVrxw/y1l30JAR+QieGgLsFsDdt7YuHGK1VYZmmzq4qiMh195sJ5aWd/u904/JdAjxM1qdDmWgcCu6maYAehXya5uDdj6/6ukGhrLmRRU8PmRLJ4h1cYC/mG+9yeGxxfaA6Ye6rPEIVJfdPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lk5xE5uW5C7UMgqcDkbYLmuUO9lF5nK2phMT/s4UizA=;
 b=OORI7CDgTlhGthACxd5Q0jswN5YgC0shRVLey3+PmFWCuuQQOlRrAYx/Z5z2DHncvCf5xSWBwE1kmaSJEU7TrtFnIHbP6Du48+CKRS4CV7SPXQvt0tHZvkE6Eprx2WhWyZdlHEglM3nOZ7Rj7IFgrdW5ShidH9N7CaMQCZ4P3jhjOLoxKZKXwv12MlPgPkYaam9aWhgTnC0RjfJSDh5RlKwydKE0lN6YjkRECrIt70JYU15jluEvLsBK171bnBSfs0pzQB/PdYeQc2e8qB/A3inFiNjmHYfmehW5DCi1RvDFz4u8YpcqjfupUs3YqJ+nyc/4auTO8oCADiGDEEs/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lk5xE5uW5C7UMgqcDkbYLmuUO9lF5nK2phMT/s4UizA=;
 b=RB4AEtKDhSG9g8mIvVMrctT4ZbEVcAMOutcG6eSEt2p4nKx7+xXaj3pCb7GFIzCICk9pJ+eKO7IlMFBmfvKuO4a6aTanO08laP9NsFpqSqjGLGI8o5v2VnSae4biGhka11Nvcfv5wcO8tN9dhjgMov0oPYF/cSs/UrLNGt/Ks/M=
Received: from BN1PR13CA0026.namprd13.prod.outlook.com (2603:10b6:408:e2::31)
 by MW4PR12MB7336.namprd12.prod.outlook.com (2603:10b6:303:21a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Wed, 26 Apr
 2023 08:40:46 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::f6) by BN1PR13CA0026.outlook.office365.com
 (2603:10b6:408:e2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 08:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.21 via Frontend Transport; Wed, 26 Apr 2023 08:40:45 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 03:40:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 01:40:45 -0700
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Wed, 26 Apr 2023 03:40:32 -0500
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <hawking.zhang@amd.com>, <christian.koenig@amd.com>,
 <Guchun.Chen@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: drop gfx_v11_0_cp_ecc_error_irq_funcs
Date: Wed, 26 Apr 2023 04:40:31 -0400
Message-ID: <20230426084031.5867-1-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT028:EE_|MW4PR12MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 739fc34a-eae2-45f8-908e-08db4631eda5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9sSMPk2terN11SYYVa8PrctQFW51ia740RDMYJMLKtEoUkzucVx+at+t4WjuZB2+15M9yeif/xqx1rhH7Q6uwCHODVBG0nZy9MAOUCX6zUwpE9hj0xl6zyWZ+uO53JQs4LDqwr3uaAXokfibBxKRi1urtj/kOwJlZPnY0zR7LbDss8JREVsA3+na+UrZjE6rV4bdD1xJvYoVT/mzHDhyABXtggzrhDGFwSkZ1Wc7olsIkzD5psoBqaL7Z16JfjgMJuPc2y/2a9mZ6r5Fxu/MpmzHYPEnekrUPN0ltnbIFd53d19NU0/zvaUbkMkMKxFrbyixK+vtfr5sL0II6HJtQK/9pzRQ3cUT2Bvgg5IT3a6kTQiAYC1a4W83/AcWsg2GHGl0T13fcOAqdGX3k6cCVTXx3e3VE++jtyKORhFjYyzNmoDetZ3PUkvBvwjoiqK+YfCeaa4pY7qs6kLZqO/Y2xO6wsqIi3Nkppof3MR1Pm21hZ8eJuZXxLryB7jtGSdev4XWei23U5kqs0dnMYiuWvmavtzzC79Aj+88TMk8HipJl4BlXpaNNFpd/afnr9L3mIaG7D4qhw46C+yjCrM0KpSQ6b23W2glEMw+SeST0bzvLBkZs+spLFKGzHQ7F0IA0vQuaAHsxyaBQbc4As0n+zy9zM91pmSgp7iChaw4j2+o5TtN9ozCufuRr7tJcP+G0b/Ibbr4WVmdu4V9sIcmMhTFtt5IWGvvC+JXIcIJrNQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(8936002)(8676002)(5660300002)(36756003)(82310400005)(86362001)(40480700001)(7696005)(26005)(54906003)(110136005)(478600001)(1076003)(36860700001)(2616005)(47076005)(83380400001)(66574015)(426003)(336012)(186003)(70206006)(316002)(82740400003)(356005)(70586007)(41300700001)(4326008)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 08:40:45.6980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 739fc34a-eae2-45f8-908e-08db4631eda5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7336
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
Cc: longlong.yao@amd.com, feifei.xu@amd.com,
 Horatio Zhang <Hongkun.Zhang@amd.com>, Guchun Chen <guchun.chen@amd.com>,
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

Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  8 ++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 38 -------------------------
 2 files changed, 5 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 60bb4bba1994..5e69eec4b754 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -719,9 +719,11 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 		if (r)
 			return r;
 
-		r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
-		if (r)
-			goto late_fini;
+		if (!(adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 0, 3))){
+			r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
+			if (r)
+				goto late_fini;
+		}
 	} else {
 		amdgpu_ras_feature_enable_on_boot(adev, ras_block, 0);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8a4c4769e607..e9491aec3cae 100644
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
 
@@ -5970,28 +5962,6 @@ static void gfx_v11_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev
 		WREG32_SOC15_IP(GC, reg_addr, tmp); \
 	} while (0)
 
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
@@ -6408,11 +6378,6 @@ static const struct amdgpu_irq_src_funcs gfx_v11_0_priv_inst_irq_funcs = {
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
@@ -6428,9 +6393,6 @@ static void gfx_v11_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gfx.priv_inst_irq.num_types = 1;
 	adev->gfx.priv_inst_irq.funcs = &gfx_v11_0_priv_inst_irq_funcs;
 
-	adev->gfx.cp_ecc_error_irq.num_types = 1; /* CP ECC error */
-	adev->gfx.cp_ecc_error_irq.funcs = &gfx_v11_0_cp_ecc_error_irq_funcs;
-
 	adev->gfx.rlc_gc_fed_irq.num_types = 1; /* 0x80 FED error */
 	adev->gfx.rlc_gc_fed_irq.funcs = &gfx_v11_0_rlc_gc_fed_irq_funcs;
 
-- 
2.34.1

