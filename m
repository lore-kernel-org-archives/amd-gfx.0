Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDCFC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02A31613CD
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A31613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A07A6EE1F;
	Fri, 14 May 2021 07:27:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C64986EE1C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gis11dDnXh9kOBoUbMYE/3GNQyfWvidlGX8L5DJXIragUd08usfZjtJsVPo5r1WzrPgUhSmsPH8jh8iwjTMtyFgbhMYOEMRbHdyFSMefn9jOSZemEXYaqUXKtca/PWZ5G/a9mLYyZDhm2iZ61GjJnlnSZN76T0c15mAVCIZgBgQj8VueD0h1owMnm7nvdzpA2lxdlltU8f5ePi/d2DEban2XextIXU+OWej4Chr8BC3Yn6Dh4DwcGEl1bH1/s2Loiu/ppin2zaBWlhmdicY1uuZdePpi22waddAdEXS1+HcEqMtxKhuGl9TOjw34C/uY578S8gpa3O3qS9Rm22FScw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDJQRnffdEcQJ4YRHyu6QvlzPBMxtQXA8YDuZ4UvMOc=;
 b=eRWSTL58e3Ce2XzS1qmBAF+RgykCRS7yU6/uSQlnQ/gNfKmqh0MrEOo8fCctldBnF2UnaVTtBzItwE94Ws080zFSKJWLPGrOJXXJTuRgfrIjXp5Ca/lrZE/YXsSQxQOe8eCcmJv9pBiELLXZYjx+vkgK5rp1jyQH0Ipx9E4/h5XLorQtm/nWcfpcASof6yb6vZt4lbzlK6ZNZ/JMyCKbJQsS5QBAIZ3ZEwgdTl9fpwTugLvp6N+t03UtGZdxGzngE+c2RQA8RPMpcw+CH4x75BnW4njWWu3nyiSLjOXseVMKKrfKHZTV+zKMkEDb2sO7a8wAq8/gL70bfhWqVSIs6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDJQRnffdEcQJ4YRHyu6QvlzPBMxtQXA8YDuZ4UvMOc=;
 b=ryXeVs9lgNdgiEn/QVuYGolYzMqJD2Yz9VOUK9G1Oezn1z3laMaz1TEnM4sSoz3Xjqyq40MGWXRiEOaEycf+f9Tq4WnbCR8yGtiYZivxKb+qcQxeBF7EaC6oSNRpLo5YEie0NRE4GwqTjBSc2Q4uyNOm7vjsYPhyi21LaOpqF1o=
Received: from DM5PR1101CA0004.namprd11.prod.outlook.com (2603:10b6:4:4c::14)
 by BL0PR12MB4707.namprd12.prod.outlook.com (2603:10b6:208:8a::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 07:27:23 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::bd) by DM5PR1101CA0004.outlook.office365.com
 (2603:10b6:4:4c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Fri, 14 May 2021 07:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 07:27:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:18 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Fri, 14 May 2021 02:27:18 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 05/16] drm/amdgpu: Modify GC register access from MMIO to
 RLCG in file gfx_v10*
Date: Fri, 14 May 2021 15:26:55 +0800
Message-ID: <20210514072706.4264-5-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210514072706.4264-1-PengJu.Zhou@amd.com>
References: <20210514072706.4264-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6815e56c-c0de-48a6-884e-08d916a9b742
X-MS-TrafficTypeDiagnostic: BL0PR12MB4707:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4707ADD30C9EF5505C3B3E86F8509@BL0PR12MB4707.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9NsywrbyoY9kEKyHcFBRXLZq0ZtMpqVs0IU+pY+uet0WNj+qasT0A8Q+vtqdqgKYR57OJ1OxD09fUWCMD9fJ66SCjMBPFmDNOuzExZDFzeYPDmPI3nHDsaJ0clR+69G3jvwSAYDJejku69oGvLRC1vwHgKhCrtIHnuDzE1WfJUrUNKy0noC+TfmsNcCPX91R7bpOLllOeU77RVKPnCKkFxHxL2IYa5hqfx5fx9OVWFo6nQsDMysIIrbrQJXLG71uT5840DRKvOGk++sVxlP49g1c6w/l8ZXEErXPNfgsLt9L14LIxZJSqHy4oGZIV25NoVjxEoGSCY7OB9+94V2YQGOTFfryb/WLxWlCWyVWxYN1MROeO03Vp/8M0LwTJsqGu4bhmxb2o5jXrrZoE6bu61u7NpHh6Qtjem6X7AgPsplS69q0zWVj0NhgstxSzVRwErcYc4Cf7y/t/gTe54lITH1CN/XZl5DDRwnlru6/PFEYIArdIo0hgoUm+skxYboYh5K83Kgkk29e+W+oUzvgW+LtX+oNYOUBDVfKzsd9RfsEqcLgybv4Wd0NPgiaGzLDO1mNZmOquRKivAhFNURufFgsfFyRd9BT7aeHTHD4O6Xoa0zOoljphfso+q3paeHw4U3/VikHMD8tgf9izdR5LJ92y25hIe2viQRi8ABBoZ8+eqqcAMDbkgQNdws4PAw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966006)(36840700001)(8936002)(8676002)(82740400003)(356005)(2906002)(7696005)(82310400003)(83380400001)(6916009)(186003)(426003)(336012)(4326008)(86362001)(2616005)(478600001)(5660300002)(70586007)(36756003)(70206006)(316002)(36860700001)(81166007)(1076003)(6666004)(47076005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:27:22.8461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6815e56c-c0de-48a6-884e-08d916a9b742
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4707
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
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 32 +++++++++++++-------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2df977fcb238..67db0197c882 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5178,10 +5178,10 @@ static void gfx_v10_0_rlc_enable_srm(struct amdgpu_device *adev)
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
@@ -7873,12 +7873,12 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
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
@@ -8618,16 +8618,16 @@ gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 
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
@@ -8671,16 +8671,16 @@ static void gfx_v10_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev
 
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
@@ -8876,20 +8876,20 @@ static int gfx_v10_0_kiq_set_interrupt_state(struct amdgpu_device *adev,
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
