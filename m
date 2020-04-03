Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9050EC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 07:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427B1206F6
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 07:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iOg2un57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427B1206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1ECF6EB11;
	Fri,  3 Apr 2020 07:14:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6BB86EB11
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 07:14:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niXjz0XLeJdyHfjFLH9YKCs6B0WH1voZRMps5DeynQ6Muo50kVwtK8uozulLS3/j4tTYKZMuTy2BQvVMAtamuFfCX6uLpoDSCtAUSmLu4bXVILoVaT3q/R7wTCL8Vp6zjZt2fiqsgje45QqKsivnzJGiCzEX/vzw9Cq3bUhJB1HPVP15gTJl9fWUyBt2AED9+O2ZaZxwfVHSEhw03vH+7pA5cbWd1TSh3AEys9MGVl2YLMnWqZsNbMIEbRkggJG5LeRFj6xPYS1NExcRP2mQPMcSlP7CXrWhKPtaK6aciuR0HSyQMndqW7MuO6+GcnORxhrSEzTUpbjvAq51sArm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8A1IhWPeHy9Pezk2zuMdX2OGO0EW+vWLFHnqmtAlUs=;
 b=L1saJm9FfMi1y3H9n+iU7B4B9JE2T+kgPhwAb/0gpYTtTK+lF7Z00SNfQGcR78IG+hxzuD6fbQVYBfOJUP1XJrBtl1YePduf6WEnF3vBO7dC853GoQuPYirQNIbasWUevgWWftYsv+YQgq46c/99o7w9D+J6oXt5V0mCvSrajApOEvEuamA08ul2r4apV0bO01qQLBPivOME8eWhDAsAun/kQsCT1jPNnhioMyIst0cfzo9qsHtkbyywFGm9fh7VwwOnGsl1/uefarVNIl/DFkmO6yx0yLswaB0RyIaBNLClCtdKMxJMrXgbjY6WhHH6Cqc1Lt269fqf5onPPr6oqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8A1IhWPeHy9Pezk2zuMdX2OGO0EW+vWLFHnqmtAlUs=;
 b=iOg2un57kQDa8/rpWAs2rGwzeusxfMdSO7iuKDcNaeJF8lvD++6x5zp8zopcPPtcjVkOpyd64Nw3VLJytKQKSzkML77Zw/OIMEaDIlmcenXpcb0V3oXqNb409nYm9whnNptl7NTolH2yks7eED8vjn6WeC05e4E6CmuSnqJ7OjM=
Received: from MWHPR13CA0024.namprd13.prod.outlook.com (2603:10b6:300:16::34)
 by BN6PR12MB1844.namprd12.prod.outlook.com (2603:10b6:404:fc::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 3 Apr
 2020 07:14:50 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::c3) by MWHPR13CA0024.outlook.office365.com
 (2603:10b6:300:16::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.5 via Frontend
 Transport; Fri, 3 Apr 2020 07:14:50 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 07:14:49 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 3 Apr 2020
 02:14:48 -0500
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 3 Apr 2020 02:14:46 -0500
From: Chengming Gui <Jack.Gui@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Correct gfx10's CG sequence
Date: Fri, 3 Apr 2020 15:13:33 +0800
Message-ID: <1585898013-7972-1-git-send-email-Jack.Gui@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(428003)(46966005)(70586007)(4326008)(81166006)(356004)(86362001)(8936002)(336012)(6666004)(6916009)(47076004)(81156014)(82740400003)(70206006)(7696005)(2906002)(186003)(8676002)(316002)(36756003)(2616005)(478600001)(5660300002)(26005)(54906003)(426003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6375c755-3a5a-4342-5bc4-08d7d79eb2bc
X-MS-TrafficTypeDiagnostic: BN6PR12MB1844:
X-Microsoft-Antispam-PRVS: <BN6PR12MB184453CD72A0ADE897A98EB18BC70@BN6PR12MB1844.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0362BF9FDB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMKGrgL2QDKxDiPyOtAwx0i9/Xk+coUsaVbA3PVTCxwwf9xrK4xpO0446SsdSj9Y92mJ+TvlRKMRCs1PGC3UdiUpksyXzeKRBoubILAPR3660Q27tL1mytbMtDoD6Uq4fbBD3XOD35JysePrn5dv45UxyyJU0hey6s9JYhgKjt74/RnAz4rP8gaIzYj/BLUn2A01hNm07OUSmNGXC3DoiSJlOAlyuPqUGnP//F4MMu1ndAFiOi0aNzlRvhKcq8FZ87ehhxs56G4D3f/C+EqctnmT2zUzm1NASOdkBcYxOhh5sGAJ39CmQB5ejWG9uQtRrzROdTzo6B04Xmbns6oHZVsZFCdFgyf3e6eW70+GbTcTPZvyy86fNhihKyY6EZbmxlOk1oG1jmxPkaFYJaCBNYOhwcFXo+GA2SPFUWLhJFHiNhRMIoGYSB91KtkPNo9a0hFasfbA33bonU8SMu8OECJDney8PcIPERpIKteGYs2T2nOHFNnuniphyX0d3f4Y+qDW6SPf6sJjvXlblalsrg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 07:14:49.7988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6375c755-3a5a-4342-5bc4-08d7d79eb2bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1844
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
Cc: Chengming Gui <Jack.Gui@amd.com>, Feifei.Xu@amd.com, Tianci.Yin@amd.com,
 Evan.Quan@amd.com, Kenneth.Feng@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Incorrect CG sequence will cause gfx timedout,
if we keep switching power profile mode
(enter profile mod such as PEAK will disable CG,
exit profile mode EXIT will enable CG)
when run Vulkan test case(case used for test: vkexample).

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 51be7aa..1439dd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4097,6 +4097,12 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
 
 	/* It is disabled by HW by default */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
+		/* 0 - Disable some blocks' MGCG */
+		WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, 0xe0000000);
+		WREG32_SOC15(GC, 0, mmCGTT_WD_CLK_CTRL, 0xff000000);
+		WREG32_SOC15(GC, 0, mmCGTT_VGT_CLK_CTRL, 0xff000000);
+		WREG32_SOC15(GC, 0, mmCGTT_IA_CLK_CTRL, 0xff000000);
+
 		/* 1 - RLC_CGTT_MGCG_OVERRIDE */
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		data &= ~(RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
@@ -4136,19 +4142,20 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
 
-		/* 2 - disable MGLS in RLC */
+		/* 2 - disable MGLS in CP */
+		data = RREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL);
+		if (data & CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK) {
+			data &= ~CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK;
+			WREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL, data);
+		}
+
+		/* 3 - disable MGLS in RLC */
 		data = RREG32_SOC15(GC, 0, mmRLC_MEM_SLP_CNTL);
 		if (data & RLC_MEM_SLP_CNTL__RLC_MEM_LS_EN_MASK) {
 			data &= ~RLC_MEM_SLP_CNTL__RLC_MEM_LS_EN_MASK;
 			WREG32_SOC15(GC, 0, mmRLC_MEM_SLP_CNTL, data);
 		}
 
-		/* 3 - disable MGLS in CP */
-		data = RREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL);
-		if (data & CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK) {
-			data &= ~CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK;
-			WREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL, data);
-		}
 	}
 }
 
@@ -4259,7 +4266,7 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 		/* ===  CGCG /CGLS for GFX 3D Only === */
 		gfx_v10_0_update_3d_clock_gating(adev, enable);
 		/* ===  MGCG + MGLS === */
-		gfx_v10_0_update_medium_grain_clock_gating(adev, enable);
+		/* gfx_v10_0_update_medium_grain_clock_gating(adev, enable); */
 	}
 
 	if (adev->cg_flags &
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
