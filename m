Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C14C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 05:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C24BE61130
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 05:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24BE61130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8643D89CCE;
	Thu,  8 Apr 2021 05:33:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DA9A6EA03
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 05:33:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKOfNia5p38xkoovoUCq9ZNmTkqUnz3quW8RWYwJoDcq6lZjjs9etAhZmjmM8L3bFDtouQxunTjOnJDaZYzyVn6IvmxteppSfm/TKsrH8QdVHyan3y6w/8uVS+KQQkNEJrHehE6UZWyCjpigXVCHyRcwsYhx7DzPB/P/ZnidSwOWnVwlbGVXGaH1CdIT21sru0wpqHWaN6BUtRE+BcQbELbAuLCu3dXBgnXw6SYVWjYHRmEihJMpG3hD3tFpCLoMw8mA4n9G2Dtw7WJCLG5a08voWauHZoOmataHE95KeFCF34+43lhzIcljGOwVk5yQaGhwqon/CTl1ymnQR6QWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCbkgNlGZLDDc8v17tpLg//VVRt2uKSXTMaoVR8wqLc=;
 b=AaYdKxwE4LpE53U8b7qlNk8EnXzuN1oH+uJ+IIigUF5qNemcgKNxZlG0CFQOHO9cu5Nhd0/ykBVboqcMLmh2LCu6RupoaJyD1Qots8aLUfEDnkk2VaOvsaw3ISixUnVcLnp5Xyb33RQygvveTzE54s4ACRegqo0h2srDYnZ3pNrk8FIV+5V4JTWhmDe/27T9NDhtpsqrdrF1yLqQpSJEiCyKdDMXs8Md3/lvPyLhz/cb/uSlytOc9eRvdEb+ZyJj+QIbEv/MU0j2qwuyPZyGpT5gGuaEk1hIk0JuTP/uA6OycLCICciB8Os+uPbOsepaKMnxwQpoI9I+RW7wvpxf6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCbkgNlGZLDDc8v17tpLg//VVRt2uKSXTMaoVR8wqLc=;
 b=qyLnlt7xafH4wPj+cBtiM9aUiX4BC76he66gXEVH5p0yxbeYS5vMyWqd3784C+leKQ4pUYqZ6lvjT3AH+O/34eKelm/jtZ6Ay4orDFW2r9NYbEOH26nh1d7WdYFlBn2mKz6G8oKeNaKa/VnMOSatrNDX1nlI1eZrJJpztMOeBdY=
Received: from BN9PR03CA0034.namprd03.prod.outlook.com (2603:10b6:408:fb::9)
 by BYAPR12MB4983.namprd12.prod.outlook.com (2603:10b6:a03:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Thu, 8 Apr
 2021 05:33:22 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::10) by BN9PR03CA0034.outlook.office365.com
 (2603:10b6:408:fb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Thu, 8 Apr 2021 05:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 05:33:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 00:33:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 00:33:22 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Thu, 8 Apr 2021 00:33:20 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amdgpu: Change GC register access from MMIO to RLCG
Date: Thu, 8 Apr 2021 13:32:35 +0800
Message-ID: <20210408053236.30762-7-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210408053236.30762-1-PengJu.Zhou@amd.com>
References: <20210408053236.30762-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0bdad8e-d4ee-4143-0585-08d8fa4fd350
X-MS-TrafficTypeDiagnostic: BYAPR12MB4983:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4983EE46A798AFA25828D6A8F8749@BYAPR12MB4983.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g6Ir/DVAI3JDq3DYKY1+CgPJJ6nAo1ulIDNdXPIN0NC9gMcVSP0SI/AQeJNRBjO58jRFdl5cjJHNWwhxb7/az9HUQekLvriG44nFSFJ1T5HVLKW46H1zHSTROo4BAXu2Jn6aaocBdFQdgAq4J5Ylft8aH6ipDgEbtroOTqY8FYEdmO6Qf7YoAEFgzOCnqAsQEx8t4V/3iJXP1WpI8sj7l9+adRNkv2nQNJaSr8VJIeHmzK0XIs68dmk2hjgSxBMK5jd79KRxw8MnmxfQr8Xs89XqDlUFykf7YQcmjc3hKa9eYcYiyD7tlBeTUkyjzzv8X81saAOs2W2C7gNxWg9UN+b6USKqhxWYlGXAMcke9hLEm7WWawsCPS3I+I0n+Ev/wadQD2FcX0G+dNu8kbSp7MklOzjaRE8LxZs3zk/q2jufHC1Rvn46c2umHQGyBh2qJsgtiK2oTC8qSGkxS68osW2Q4eu7LDmPpuhvoxUW+LsJBO0NgXFCwzB1wP9de3yvV3rZCnaNrtYn+WPyUKst57KsXrlLWyIc6/Zx7LPT2vz6C4SEN7ijkystFZP+M43Kq6uAB2Bg1P7mk/vW3oKG6F8Yh3yFVt4nAh11aryHLR1N7S8TgxX9qAse16dEZpN7UYbKURPoT/Zb5rJjYMtc1gUAR86PEHYMHyK/VpRfIKaGpiOzEMXCUJVm1DdhC7oi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966006)(36840700001)(8676002)(478600001)(54906003)(7696005)(83380400001)(82740400003)(4326008)(316002)(70586007)(47076005)(81166007)(26005)(6666004)(86362001)(1076003)(8936002)(356005)(70206006)(36860700001)(336012)(426003)(186003)(2906002)(82310400003)(6916009)(36756003)(5660300002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 05:33:22.7072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bdad8e-d4ee-4143-0585-08d8fa4fd350
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4983
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
Cc: jane.jian@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Change GC register access from MMIO to RLCG.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 34 +++++++++++++-------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index b1d5b08e4f06..0265a082d791 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5016,17 +5016,17 @@ static void gfx_v10_0_tcp_harvest(struct amdgpu_device *adev)
 					}
 				}
 
-				tmp = RREG32_SOC15(GC, 0, mmUTCL1_UTCL0_INVREQ_DISABLE);
+				tmp = RREG32_SOC15_RLC(GC, 0, mmUTCL1_UTCL0_INVREQ_DISABLE);
 				/* only override TCP & SQC bits */
 				tmp &= 0xffffffff << (4 * max_wgp_per_sh);
 				tmp |= (utcl_invreq_disable & utcl_invreq_disable_mask);
-				WREG32_SOC15(GC, 0, mmUTCL1_UTCL0_INVREQ_DISABLE, tmp);
+				WREG32_SOC15_RLC(GC, 0, mmUTCL1_UTCL0_INVREQ_DISABLE, tmp);
 
-				tmp = RREG32_SOC15(GC, 0, mmGCRD_SA_TARGETS_DISABLE);
+				tmp = RREG32_SOC15_RLC(GC, 0, mmGCRD_SA_TARGETS_DISABLE);
 				/* only override TCP bits */
 				tmp &= 0xffffffff << (2 * max_wgp_per_sh);
 				tmp |= (gcrd_targets_disable_tcp & gcrd_targets_disable_mask);
-				WREG32_SOC15(GC, 0, mmGCRD_SA_TARGETS_DISABLE, tmp);
+				WREG32_SOC15_RLC(GC, 0, mmGCRD_SA_TARGETS_DISABLE, tmp);
 			}
 		}
 
@@ -5044,8 +5044,8 @@ static void gfx_v10_0_get_tcc_info(struct amdgpu_device *adev)
 		tcc_disable = RREG32_SOC15_RLC(GC, 0, mmCGTS_TCC_DISABLE_gc_10_3) |
 			      RREG32_SOC15_RLC(GC, 0, mmCGTS_USER_TCC_DISABLE_gc_10_3);
 	} else {
-		tcc_disable = RREG32_SOC15(GC, 0, mmCGTS_TCC_DISABLE) |
-			      RREG32_SOC15(GC, 0, mmCGTS_USER_TCC_DISABLE);
+		tcc_disable = RREG32_SOC15_RLC(GC, 0, mmCGTS_TCC_DISABLE) |
+			      RREG32_SOC15_RLC(GC, 0, mmCGTS_USER_TCC_DISABLE);
 	}
 
 	adev->gfx.config.tcc_disabled_mask =
@@ -5058,7 +5058,7 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
 	u32 tmp;
 	int i;
 
-	WREG32_FIELD15(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
+	WREG32_FIELD15_RLC(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
 
 	gfx_v10_0_setup_rb(adev);
 	gfx_v10_0_get_cu_info(adev, &adev->gfx.cu_info);
@@ -6794,10 +6794,10 @@ static int gfx_v10_0_kiq_init_register(struct amdgpu_ring *ring)
 
 	/* inactivate the queue */
 	if (amdgpu_sriov_vf(adev))
-		WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
+		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE, 0);
 
 	/* disable wptr polling */
-	WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
+	WREG32_FIELD15_RLC(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
 
 	/* write the EOP addr */
 	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_EOP_BASE_ADDR,
@@ -7103,15 +7103,15 @@ static bool gfx_v10_0_check_grbm_cam_remapping(struct amdgpu_device *adev)
 	case CHIP_VANGOGH:
 		return true;
 	default:
-		data = RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE);
-		WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE, 0);
-		WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, pattern);
+		data = RREG32_SOC15_RLC(GC, 0, mmVGT_ESGS_RING_SIZE);
+		WREG32_SOC15_RLC(GC, 0, mmVGT_ESGS_RING_SIZE, 0);
+		WREG32_SOC15_RLC(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, pattern);
 
-		if (RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE) == pattern) {
-			WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, data);
+		if (RREG32_SOC15_RLC(GC, 0, mmVGT_ESGS_RING_SIZE) == pattern) {
+			WREG32_SOC15_RLC(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, data);
 			return true;
 		} else {
-			WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE, data);
+			WREG32_SOC15_RLC(GC, 0, mmVGT_ESGS_RING_SIZE, data);
 			return false;
 		}
 		break;
@@ -7358,9 +7358,9 @@ static int gfx_v10_0_hw_fini(void *handle)
 	if (amdgpu_sriov_vf(adev)) {
 		gfx_v10_0_cp_gfx_enable(adev, false);
 		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
-		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
+		tmp = RREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS);
 		tmp &= 0xffffff00;
-		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+		WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
 
 		return 0;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
