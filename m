Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41C2C43460
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53EFD6143F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EFD6143F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D30D46ED9C;
	Thu, 29 Apr 2021 08:14:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5CA26ED9C
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 08:14:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0HDX07ZZHb/2xRfmUzBh47ItjFK0IWvRaG2a/TF6r2LzYrXz73agh/ogTb6g2IEF9CiMEYui95CuG6vUVt2kxKIxR+H48I1Kv5ZK6dzC8MwHmrnZBxU1qqOrLtFVzZtbPy9R31VhO1X6vanfpz6xJU5KtlkC4jsHVnU7UTmtdhNioM9obzIcXtTS+J1buFVBl+rHJqNm2zjwHHjJ6B9byNEcsocHRJWbJhM1ur+Pu1DSEo0jfOeQXZihfpDp7DK/z2JnvFUM7FTQ3fOWUCC5JmpCTdnHmfEBhQZT+wAUvzaWbLsoOouufmf8RSNgtXUL+uysmiX5bP+QJyqSVCNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujJMcH+TUIgXHh1NfyJ7JobDJh01Rw8WYBHhn74hAhw=;
 b=D//r1wK2YHspJahxHPjzp6NFGtkVyucTEshuXYtztPhnkdjuxKKziJSNGhoPAm5NbfEnn0Zfs04WztoYCmfjmZl+VaJ9/1xxRQsaA2y1bJLrHQHT5wWr3eo7LsHrRxbPUWNCEgb/VJemlSRBJ9mnxbxl+mv8jpwmBhzwgxMrOTXPu5OSuRTfh44gdZDF7qhMtxC42EyIMH2w7aanQwxx+ra9Yx+tj8oQP/C4VVm/yWJRc+DKSeP5W850Xwj153ix1dec+9IPlmDdUvD6Qh9FIY4n4AV8jFjBkBI9KJK/y63HsQwynhNufuMBNbcnqXNvoKJ53AFWHgyx3JX5CfdV3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujJMcH+TUIgXHh1NfyJ7JobDJh01Rw8WYBHhn74hAhw=;
 b=sm8Aqk9cnAmRvXeV2WHudcRFvTm8WnbXkrLqPSfUDUw2LZVYplYWrtK0jvtb7kmKhm9a0nLYxV5ZAf9zJcWnjPdIzuSwbpECM6+6OtSFxvCx0Np/jw+1qhcLef4B9dMyME5/vWetAMUqMQgtpUzCDfSMD0Agdr3OKzg8wdpCr4U=
Received: from DM6PR06CA0101.namprd06.prod.outlook.com (2603:10b6:5:336::34)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 08:14:00 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::ab) by DM6PR06CA0101.outlook.office365.com
 (2603:10b6:5:336::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Thu, 29 Apr 2021 08:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 08:13:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 03:13:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 03:13:58 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 03:13:58 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/12] drm/amdgpu: Modify GC register access from MMIO to RLCG
 in file gfx_v10*
Date: Thu, 29 Apr 2021 16:13:35 +0800
Message-ID: <20210429081345.24217-2-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429081345.24217-1-PengJu.Zhou@amd.com>
References: <20210429081345.24217-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 040f9f4a-7b36-4436-e1f6-08d90ae6be2c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4429:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4429ED168680E500BED3A1D1F85F9@SA0PR12MB4429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5wRMQk7uBKQYugd8oWe9DIrika3wEbTxWrAgPdL1EvDRD4BFxb5FrD1RcWfXG/Bdg3cCHL7KBTHvbCgYq1rHvtzrHXjeB2h1jh1zfQTTe/Xt7QK1Utz0dihGSlNBD0b9t2gYT6sUs5IbW2kGlk2mFrTOfr5TigU0MJTgoN9IFvbn70qVxZ8kfgsmnR0p0X2p4TSRt880XHf2bwCL+ds8lvrfHOxN0SkuJngItRJshdcBbaTB9lXGynp4FojvEsldWYkcvymHQVq0QHbraPENaJotOCYAlXYYkh1XKRrF8IVtlCkjIXgGt0xhgxbuaPt19G6xLH9L67OkLnbk/koOgDGupKPbkEDumNLJiYMqIltEBRoh9obeWhcuk8hJOphQzWge62IEbdlN4vxo6+ivrVen47ILZXTPyvqnNXnMnyUu49tvv2+SGUGpItv5b5G8lsjDAzK5+yuzYHFHKDj/9RWGkJ7ZHDG6bfSc5zh7xUj3SlWOthYJJcUMD5TIMpVDLiYW5ou1dZEy5Ck9SwfgyZ1XLxkNjR9seSeW8+ef9Xef7MBYX/8YWWlPV/I4hlcer5F4ZnPj1LtyNWzOoa+5l/jowgpne/gv8Gv833Qm1D4FJhNHJ5dTH809nS4WTu950GNsYHciAcqc/4n1t69583rdv5/oy6HOGuVT2IEM3wnjYMi3QWePiIAK/hisSl5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966006)(36840700001)(70206006)(70586007)(7696005)(2906002)(83380400001)(4326008)(1076003)(82310400003)(8676002)(336012)(2616005)(426003)(86362001)(5660300002)(316002)(47076005)(8936002)(82740400003)(81166007)(6916009)(36756003)(478600001)(186003)(356005)(26005)(6666004)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 08:13:59.8044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 040f9f4a-7b36-4436-e1f6-08d90ae6be2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 34 +++++++++++++-------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index c7e04ed168bf..2ec9701544c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4897,7 +4897,7 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		nv_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
-		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
+		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
 		WREG32_SOC15(GC, 0, mmSH_MEM_BASES, sh_mem_bases);
 	}
 	nv_grbm_select(adev, 0, 0, 0, 0);
@@ -5154,10 +5154,10 @@ static void gfx_v10_0_rlc_enable_srm(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	/* enable Save Restore Machine */
-	tmp = RREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_SRM_CNTL));
+	tmp = RREG32_SOC15(GC, 0, mmRLC_SRM_CNTL);
 	tmp |= RLC_SRM_CNTL__AUTO_INCR_ADDR_MASK;
 	tmp |= RLC_SRM_CNTL__SRM_ENABLE_MASK;
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_SRM_CNTL), tmp);
+	WREG32_SOC15(GC, 0, mmRLC_SRM_CNTL, tmp);
 }
 
 static int gfx_v10_0_rlc_load_microcode(struct amdgpu_device *adev)
@@ -7849,12 +7849,12 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 {
 	u32 reg, data;
-
+	/* not for *_SOC15 */
 	reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		data = RREG32_NO_KIQ(reg);
 	else
-		data = RREG32(reg);
+		data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
 
 	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
 	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
@@ -8594,16 +8594,16 @@ gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
-		cp_int_cntl = RREG32(cp_int_cntl_reg);
+		cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
 		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
 					    TIME_STAMP_INT_ENABLE, 0);
-		WREG32(cp_int_cntl_reg, cp_int_cntl);
+		WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
-		cp_int_cntl = RREG32(cp_int_cntl_reg);
+		cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
 		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
 					    TIME_STAMP_INT_ENABLE, 1);
-		WREG32(cp_int_cntl_reg, cp_int_cntl);
+		WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
 		break;
 	default:
 		break;
@@ -8647,16 +8647,16 @@ static void gfx_v10_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev
 
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_SOC15_IP(GC, mec_int_cntl_reg);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 0);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_SOC15_IP(GC, mec_int_cntl_reg);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 1);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);
 		break;
 	default:
 		break;
@@ -8852,20 +8852,20 @@ static int gfx_v10_0_kiq_set_interrupt_state(struct amdgpu_device *adev,
 					    GENERIC2_INT_ENABLE, 0);
 			WREG32_SOC15(GC, 0, mmCPC_INT_CNTL, tmp);
 
-			tmp = RREG32(target);
+			tmp = RREG32_SOC15_IP(GC, target);
 			tmp = REG_SET_FIELD(tmp, CP_ME2_PIPE0_INT_CNTL,
 					    GENERIC2_INT_ENABLE, 0);
-			WREG32(target, tmp);
+			WREG32_SOC15_IP(GC, target, tmp);
 		} else {
 			tmp = RREG32_SOC15(GC, 0, mmCPC_INT_CNTL);
 			tmp = REG_SET_FIELD(tmp, CPC_INT_CNTL,
 					    GENERIC2_INT_ENABLE, 1);
 			WREG32_SOC15(GC, 0, mmCPC_INT_CNTL, tmp);
 
-			tmp = RREG32(target);
+			tmp = RREG32_SOC15_IP(GC, target);
 			tmp = REG_SET_FIELD(tmp, CP_ME2_PIPE0_INT_CNTL,
 					    GENERIC2_INT_ENABLE, 1);
-			WREG32(target, tmp);
+			WREG32_SOC15_IP(GC, target, tmp);
 		}
 		break;
 	default:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
