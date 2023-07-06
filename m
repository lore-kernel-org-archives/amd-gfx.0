Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D9FEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 16:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E73A110E0EB;
	Thu,  6 Jul 2023 16:25:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ECE210E0EB
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 16:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXEzbUUp7uSYKOwTJKV9u7MvYZ+2WX10vsymo7M14+uZnFwn+YewPS+ndu2rcAy68Y5OuWZdVAJvQXQlJ8Dh/S7XNhVscNB76UqsKsK6+oGSLqL5CA8v5wpbPIV+wUFmrZFBhJyfURm/lXGiPhalZf632yfN5rm7SFErgyXJeHSREzuB+M5+/u/GmT7S+LWD1/SYrTxVGHG0t2TVxpovnMRHbsZH08ln7JNMbjA0RZph5KWEMQx6aTMDkvweleUSeJYRoc+hj9W32j8VBtUGcBW3WsYPfqK+aRkJNnulwexY861ULEvSOdwipsdjWwZrTFtiYwJ0hZrM0RkeZnoBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjF5AzYZGMKOp4a5ukMAp2mLE5tqQ/pDgrZFedgS5NQ=;
 b=DllpJKlcNXii87w/d5h0ucewEYl+JoimQpyPOW5Db8K+PRFkqmdCAk+rgSurCgP1mzwJIlVb8PIvtz9ctzMoGIJY8Ja59ouMzQjqNndTQ90SJiRd/A1RaIMl5p78RTxYcs8NyRGKkkszEPp1HDi5tkNl5NqtV2w8pPF+WXyJ5jjVSP9/WyXLOd5P6uqGwXTt7FL0lig1BdIqUSz7S6OootNfiyOb3uni641D2IfpFCMZ9jHVkMAr/P3wdRoDk1enNdWpNuQvkCfYgY9XmR6ZXY2Oihmn0Ddy927A6iOyjMOZyWrw6hRHSDzufJJCOC86BVoaqTvVbNUNnoIOHOFy8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjF5AzYZGMKOp4a5ukMAp2mLE5tqQ/pDgrZFedgS5NQ=;
 b=R69VJFN74HuX0sod5fT7jQs/t95cHr/TzqpQmXMOkPvhIrTtURuwDiR/rVF0j5YsK1CfMRxJh9VjZEtTmQr70HuJCOkA3vnUd8of+ptfP1Ec1TzH/eL/Clrp3XA1naTfGOBRk9O9O8uTPJBC7uIKJQSngsK4txUCeGrsgR2UaUQ=
Received: from BYAPR03CA0017.namprd03.prod.outlook.com (2603:10b6:a02:a8::30)
 by DM4PR12MB5985.namprd12.prod.outlook.com (2603:10b6:8:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 16:25:47 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a02:a8:cafe::e4) by BYAPR03CA0017.outlook.office365.com
 (2603:10b6:a02:a8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 6 Jul 2023 16:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 16:25:46 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 11:25:45 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: remove SRIOV VF FB location programming
Date: Thu, 6 Jul 2023 12:25:27 -0400
Message-ID: <20230706162528.17739-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|DM4PR12MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 0567b00f-0862-4e10-4477-08db7e3da74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YgrF4mM4eClOUUv5afyfJwzOiwxv4AV521pJijWB+ZMhrDtwxSf6w7/yfDjSGo5SuJgWJUCMREyrDzLd5LF2q76LIKurzcqM0b9dUrVDNayv6oLe7R5d+DLXURql23ltW+oc2TV3fMezOfM4V0ScCUmkpXXbN60Fx5n98+GB502M1f4OE6DrkbcUIX5MeXRwa3ZSb5Lw3Ym6zMGE3VBsbmwbFz5Ts88gTdkhRZgqGHHGWzjWpvcstH5S7WtZdhadNs9PQ7z9pHYJ9Pl6w8WXrZv4yGtui2Z03jGhzLZ1RjcgyQ5QuFOaaEFOLGbxnVsb3XgdmiCCQ7L/JHanyBaImOzmeZeviUuhfuIuVKt//x/au9+Ap0+Pspju+2i2baYXhdByH350+ltb6VfP80mzYjJtqqM1e0QKrgPY6BIooSlmeHXjP6gEIoGZYY7aNIbK1RwJ8O2geYA6iubj9yUDbjsl8ASixR4y0Zo86wL2hUnSTlQnHUMg1oFTBbbT9Jrd1esxUwaVsqx8aPNt7GUTrdtmsqZX7gRbNFShBDiNVoNlGdMXBV7Qn716EdAMmMblQran3X6XmNmVUrn2+z8VVEAY99yXnxICR70a8bQTVFqEGdljZA38AJpn32QrtrNFWkGCmEmJkdIaqtDvP0RsMqO79+KNcp409RKOvPcIMAANT1dLKAtLXi1OPdTKCfK6s78iEUTSy3i6xOt5cAqErdjW+3nLY3W01Hdn4CBkoWDud5V7lzao0EUk+cXNBSD6Pu8peH0H0t1dS6L79Pihj7mtJpOFpb8ZfTK5bR54XAIOjbVCXwicJ1mK0JsVkecq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(2906002)(82310400005)(8936002)(2616005)(86362001)(40480700001)(36860700001)(70586007)(316002)(5660300002)(83380400001)(6666004)(16526019)(7696005)(54906003)(478600001)(26005)(336012)(186003)(8676002)(82740400003)(47076005)(356005)(426003)(40460700003)(81166007)(4326008)(6916009)(36756003)(70206006)(1076003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:25:46.7370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0567b00f-0862-4e10-4477-08db7e3da74f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5985
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
Cc: alexander.deucher@amd.com, Zhigang Luo <Zhigang.Luo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For SRIOV VF, FB location is programmed by host driver, no need to
program it in guest driver.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
Change-Id: I2a4838f6703e94bb0bcf3a8e923c69466e37803f
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 15 +--------------
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  | 12 ------------
 2 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 47f95ec218a3..03ae661e3b54 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -406,20 +406,6 @@ static int gfxhub_v1_2_xcc_gart_enable(struct amdgpu_device *adev,
 	int i;
 
 	tmp_mask = xcc_mask;
-	/*
-	 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, because they are
-	 * VF copy registers so vbios post doesn't program them, for
-	 * SRIOV driver need to program them
-	 */
-	if (amdgpu_sriov_vf(adev)) {
-		for_each_inst(i, tmp_mask) {
-			i = ffs(tmp_mask) - 1;
-			WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE,
-				     adev->gmc.vram_start >> 24);
-			WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP,
-				     adev->gmc.vram_end >> 24);
-		}
-	}
 
 	/* GART Enable. */
 	gfxhub_v1_2_xcc_init_gart_aperture_regs(adev, xcc_mask);
@@ -606,6 +592,7 @@ static int gfxhub_v1_2_get_xgmi_info(struct amdgpu_device *adev)
 	max_region =
 		REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB_CNTL, PF_MAX_REGION);
 
+	DRM_INFO("XXXXXX xgmi_lfb_cntl=0x%x seg_size=0x%llx", xgmi_lfb_cntl, seg_size);
 
 
 	max_num_physical_nodes   = 8;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 5e8b493f8699..784c4e077470 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -413,18 +413,6 @@ static void mmhub_v1_8_program_invalidation(struct amdgpu_device *adev)
 
 static int mmhub_v1_8_gart_enable(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev)) {
-		/*
-		 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
-		 * VF copy registers so vbios post doesn't program them, for
-		 * SRIOV driver need to program them
-		 */
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE,
-			     adev->gmc.vram_start >> 24);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP,
-			     adev->gmc.vram_end >> 24);
-	}
-
 	/* GART Enable. */
 	mmhub_v1_8_init_gart_aperture_regs(adev);
 	mmhub_v1_8_init_system_aperture_regs(adev);
-- 
2.25.1

