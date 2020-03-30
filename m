Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEF2C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 08:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9304F20732
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 08:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c+QhKNiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9304F20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 440096E111;
	Mon, 30 Mar 2020 08:49:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78EFC6E111
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 08:49:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feCd8pW+80A56dfWvBUwmEwjQwbpHMSWzB6Ni/iUPl90euFe9f/6a0K/ykNspjHsEd9qAleMn2CALeIsUy7DU370Pra3axk78z+G3XvHoT0fz9vYgi9wrU1TXUb0EQeyAwNIUFL7SDYSB1SaJqtfEwYV/9PfMMOwvDIc82krWt+3g0A5cWLEGiG5KvZ0hUqZVuhxDoIaZjO0MAb2HFXUhw+7SwfU/TWRR+SK5VPiUUD3deH/yFJIoV8janPedelYRcHpksrlG898GSnLElXc5hXJyyAM4vq7x0Ud+ibzkDgKtQC950Axm49yOBwtsxPMdHsU+MluoOxspk5MAF5Tlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2O5n0s3TUBIxzikhKcsGX787uCHX6FA8fpxyfiwF8w=;
 b=B5L/vdzVdBG27QL4TAsjqmKahefgfSpokHN8rk6dRFrxjXoueeaKgQn/F1fk8i78i7WO9Y6yaJJFW3+KXD2dVadeXKPogHfxUMtmo2cN/iScgXgMNYbiCntbaaUU5BBe0hV05z35Er2Wtz9Qt4c0HW+XieydL/uscVSxOhOxq01u50LhKqHQS5H70c1EcqBMLX7BSuaTau/FNsHy/bMPVted5kCmAfARvaAPKrFLLVlAJgvgaACEPW3ZtMB5pO+N7dU4wsyKHf6qFx4sQgCj1aHI16olyVohFGIViklXNTdjTQJ8gTrTk3kqmBCQFiPUfz7d4mSA/w/mIiIOtqTPJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2O5n0s3TUBIxzikhKcsGX787uCHX6FA8fpxyfiwF8w=;
 b=c+QhKNiDd+PT4Y0RgHfN6SII31zm24Az5XFp8i7iuvQxv/UdhQgZR+GJ8SsD7T+DTuX452xqrXGWDuTqcaICZx3oIWGWXZkvKDx4/2+MfqQj9oI4dgdS6pQi25URH4/lyafIyN3BvlFrBVt9w+SXaELE2NzH35xyDAeyqtMyyWU=
Received: from MWHPR14CA0008.namprd14.prod.outlook.com (2603:10b6:300:ae::18)
 by CH2PR12MB3720.namprd12.prod.outlook.com (2603:10b6:610:29::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 08:49:48 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::60) by MWHPR14CA0008.outlook.office365.com
 (2603:10b6:300:ae::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend
 Transport; Mon, 30 Mar 2020 08:49:48 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2856.19 via Frontend Transport; Mon, 30 Mar 2020 08:49:47 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 30 Mar
 2020 03:49:47 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 30 Mar 2020 03:49:45 -0500
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: skip access sdma_v5_0 registers under SRIOV
Date: Mon, 30 Mar 2020 16:49:43 +0800
Message-ID: <20200330084943.28382-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(428003)(46966005)(316002)(336012)(426003)(110136005)(186003)(54906003)(2616005)(81156014)(36756003)(81166006)(478600001)(26005)(82740400003)(47076004)(7696005)(6636002)(5660300002)(2906002)(4326008)(1076003)(8676002)(356004)(8936002)(70586007)(70206006);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af339c12-224e-4f5f-63a5-08d7d4874d74
X-MS-TrafficTypeDiagnostic: CH2PR12MB3720:
X-Microsoft-Antispam-PRVS: <CH2PR12MB37202C1DD00A3C1AD1BCEDFDE5CB0@CH2PR12MB3720.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0358535363
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5NgRLJPLoJ+DO3FToTgCmP+kkeRxzYoH1OHXBsZmo7L9N5Oh5SAYo0FAd0s3vHTplw+IkI3yzthW/ymPWub0ZAbbktMgy3cWiLti4knaL4eq4GM+itB12wvArMHYty3zVrrjcEccr8AZR9BbnWW4QJgBxAsAmhNIp42aFgJ5vNvd5ARsjIa0ksYllDVXtjrmsFz0gC+2g+jWZhebunQG502ee6OHrbPzI4Gx0wd8hajDvFWAUXsjHJJ+5YuaPri4c+lqeLWE4KyH17wzWRT6So95IaRGy7IpUMGQMYdIPQQmagM82a/FHajc+sk1LPXnPbbjHNjo4ZTHChf67iDEMciMiMWtwoFO22EoS3LbrW5het49VXQUahKIC0IHVhw/SLlQrO0qeJgsDlIhNexsOqjByNXCOC6m6jctBQw46tJjL1DzUc6Mf1pfbc7U7p8tbZ4LHrAhHjBMMQvfID0YlP/FyAKf0ArvW0esW58Y4c9+EWMeXVUho1NbniKMk6oXzklWmJt41aCdKjI1C1FVA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 08:49:47.9742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af339c12-224e-4f5f-63a5-08d7d4874d74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3720
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
Cc: amd-gfx@lists.freedesktop.org, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Due to the new L1.0b0c011b policy, many SDMA registers are blocked which raise
the violation warning. There are total 6 pair register needed to be skipped
when driver init and de-init.
mmSDMA0/1_CNTL
mmSDMA0/1_F32_CNTL
mmSDMA0/1_UTCL1_PAGE
mmSDMA0/1_UTCL1_CNTL
mmSDMA0/1_CHICKEN_BITS,
mmSDMA0/1_SEM_WAIT_FAIL_TIMER_CNTL

Signed-off-by: Yintian Tao <yttao@amd.com>
Change-Id: I9d5087582ceb5f629d37bf856533d00c179e6de3
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 110 +++++++++++++++++--------
 1 file changed, 75 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index b3c30616d6b4..d7c0269059b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -88,6 +88,29 @@ static const struct soc15_reg_golden golden_settings_sdma_5[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_UTCL1_PAGE, 0x00ffffff, 0x000c5c00)
 };
 
+static const struct soc15_reg_golden golden_settings_sdma_5_sriov[] = {
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_GFX_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_PAGE_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_RLC0_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_RLC1_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_RLC2_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_RLC3_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_RLC4_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_RLC5_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_RLC6_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_RLC7_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_GFX_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_PAGE_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_RLC0_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_RLC1_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_RLC2_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_RLC3_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_RLC4_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_RLC5_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_RLC6_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_RLC7_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+};
+
 static const struct soc15_reg_golden golden_settings_sdma_nv10[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_RLC3_RB_WPTR_POLL_CNTL, 0x0000fff0, 0x00403000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_RLC3_RB_WPTR_POLL_CNTL, 0x0000fff0, 0x00403000),
@@ -141,9 +164,14 @@ static void sdma_v5_0_init_golden_registers(struct amdgpu_device *adev)
 						(const u32)ARRAY_SIZE(golden_settings_sdma_nv14));
 		break;
 	case CHIP_NAVI12:
-		soc15_program_register_sequence(adev,
-						golden_settings_sdma_5,
-						(const u32)ARRAY_SIZE(golden_settings_sdma_5));
+		if (amdgpu_sriov_vf(adev))
+			soc15_program_register_sequence(adev,
+							golden_settings_sdma_5_sriov,
+							(const u32)ARRAY_SIZE(golden_settings_sdma_5_sriov));
+		else
+			soc15_program_register_sequence(adev,
+							golden_settings_sdma_5,
+							(const u32)ARRAY_SIZE(golden_settings_sdma_5));
 		soc15_program_register_sequence(adev,
 						golden_settings_sdma_nv12,
 						(const u32)ARRAY_SIZE(golden_settings_sdma_nv12));
@@ -557,9 +585,12 @@ static void sdma_v5_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-		f32_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL));
-		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
-				AUTO_CTXSW_ENABLE, enable ? 1 : 0);
+		if (!amdgpu_sriov_vf(adev)) {
+			f32_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL));
+			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+						 AUTO_CTXSW_ENABLE, enable ? 1 : 0);
+		}
+
 		if (enable && amdgpu_sdma_phase_quantum) {
 			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
 			       phase_quantum);
@@ -568,7 +599,8 @@ static void sdma_v5_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
 			       phase_quantum);
 		}
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
+		if (!amdgpu_sriov_vf(adev))
+			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
 	}
 
 }
@@ -591,6 +623,9 @@ static void sdma_v5_0_enable(struct amdgpu_device *adev, bool enable)
 		sdma_v5_0_rlc_stop(adev);
 	}
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		f32_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
 		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
@@ -623,7 +658,8 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 		ring = &adev->sdma.instance[i].ring;
 		wb_offset = (ring->rptr_offs * 4);
 
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
+		if (!amdgpu_sriov_vf(adev))
+			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
 
 		/* Set ring buffer size in dwords */
 		rb_bufsz = order_base_2(ring->ring_size / 4);
@@ -699,26 +735,28 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 		/* set minor_ptr_update to 0 after wptr programed */
 		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
 
-		/* set utc l1 enable flag always to 1 */
-		temp = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL));
-		temp = REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);
-
-		/* enable MCBP */
-		temp = REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_PREEMPT_ENABLE, 1);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL), temp);
-
-		/* Set up RESP_MODE to non-copy addresses */
-		temp = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL));
-		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
-		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL), temp);
-
-		/* program default cache read and write policy */
-		temp = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE));
-		/* clean read policy and write policy bits */
-		temp &= 0xFF0FFF;
-		temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) | (CACHE_WRITE_POLICY_L2__DEFAULT << 14));
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE), temp);
+		if (!amdgpu_sriov_vf(adev)) {
+			/* set utc l1 enable flag always to 1 */
+			temp = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL));
+			temp = REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);
+
+			/* enable MCBP */
+			temp = REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_PREEMPT_ENABLE, 1);
+			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL), temp);
+
+			/* Set up RESP_MODE to non-copy addresses */
+			temp = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL));
+			temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
+			temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
+			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL), temp);
+
+			/* program default cache read and write policy */
+			temp = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE));
+			/* clean read policy and write policy bits */
+			temp &= 0xFF0FFF;
+			temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) | (CACHE_WRITE_POLICY_L2__DEFAULT << 14));
+			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE), temp);
+		}
 
 		if (!amdgpu_sriov_vf(adev)) {
 			/* unhalt engine */
@@ -1388,14 +1426,16 @@ static int sdma_v5_0_set_trap_irq_state(struct amdgpu_device *adev,
 {
 	u32 sdma_cntl;
 
-	u32 reg_offset = (type == AMDGPU_SDMA_IRQ_INSTANCE0) ?
-		sdma_v5_0_get_reg_offset(adev, 0, mmSDMA0_CNTL) :
-		sdma_v5_0_get_reg_offset(adev, 1, mmSDMA0_CNTL);
+	if (!amdgpu_sriov_vf(adev)) {
+		u32 reg_offset = (type == AMDGPU_SDMA_IRQ_INSTANCE0) ?
+			sdma_v5_0_get_reg_offset(adev, 0, mmSDMA0_CNTL) :
+			sdma_v5_0_get_reg_offset(adev, 1, mmSDMA0_CNTL);
 
-	sdma_cntl = RREG32(reg_offset);
-	sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA0_CNTL, TRAP_ENABLE,
-		       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
-	WREG32(reg_offset, sdma_cntl);
+		sdma_cntl = RREG32(reg_offset);
+		sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA0_CNTL, TRAP_ENABLE,
+					  state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+		WREG32(reg_offset, sdma_cntl);
+	}
 
 	return 0;
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
