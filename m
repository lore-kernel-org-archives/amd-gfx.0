Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57751C77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 04:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B5410E5BD;
	Fri, 19 May 2023 04:42:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B02210E5BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 04:42:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtY8S0wZvGc6Y6t5mwOpqEvKHZJgGyKI34oo7j0+rYwnODQwO8SHzZh0ehOW3eQdKDb76CT3o9X4lImiW5zkfDHknIOhiDAwUi/53oB95R1qupqfG0mzS0v+F0682Xo7vh1+m2pHR2vBgAnkt8SF+psIMidiXPzr8tA9qyTwXuBa0M5kSDC3Pt12gKU7UCS/9AI2340/46XLxFXoNOKXSVDtCldvQEqd6Bi6A8iCbnWeSEMgdwa853Mg4zHHgfxfwvsazXGgyZ4hQpxl753KZvv695vkO7UbyM+fxcVNaVxCopkaIboo5P7/5TBTtOxVUNjRcslDQfB/qetjN6Sy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJc7uac+0VvFBhgZtGUiRT1pV30GuVJBbqYquzhOen0=;
 b=RvtWXGRZMw7fSR7ygOA1fltsfef4Weta3WezsUsxBWsuQD6L+Pd2DJcZ/CnBgyYJTO8iGf/AzoxS4xX8sKJnOjlSI3u6xtYjCEFSWzqVdNfTNKgF/e6pkbFvJhy1pl3h7aWAe8T3OY6JKWQ7ysnTL8IrR/5/lwOYT4bpS217mzhCPVo/YV2qwY1CXfK36DXK7b37O1731YsLsTvEz5nrHUq2pYnocA8PpPqk0dqpRo+yA1v+s+INTBuicXlMzFJA/LYsK/OShS3kncuMMrbCBg6ACABZLGLv/0y7slj6kHpQ4d1Tg0vXnsa5iy0qf27exc8waGKZtgoLkZVPIs00/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJc7uac+0VvFBhgZtGUiRT1pV30GuVJBbqYquzhOen0=;
 b=svsFdcLJomV5f9PBsN3CxNQ1Dwu1VOJVM5bN7WcR8TCX5hvtSXOaZgIhiFmaxR3HTAgqAnHahlZdynvMbDK21zd4N1gfJaGeuHnPbdsZqdRU9pBTgE2oF5HMLGzy+RffEDUmlFPuEAfnjFHs0VoOnw0trSxUVhptvvE0/nlzqkc=
Received: from MN2PR11CA0007.namprd11.prod.outlook.com (2603:10b6:208:23b::12)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 04:42:11 +0000
Received: from BL02EPF000145BB.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::fd) by MN2PR11CA0007.outlook.office365.com
 (2603:10b6:208:23b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Fri, 19 May 2023 04:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145BB.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.7 via Frontend Transport; Fri, 19 May 2023 04:42:11 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 23:42:10 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Disable interrupt tracker on NBIOv7.9
Date: Fri, 19 May 2023 12:41:53 +0800
Message-ID: <20230519044153.16726-2-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230519044153.16726-1-shiwu.zhang@amd.com>
References: <20230519044153.16726-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: be318720-1917-4dad-8210-08db58236944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKiXGRU0JAbRpSDmVPw0jNqum7jWcR2dVfXhIVYkYDtKz+drWp6Et9H1tnQzZBIni3FosPGYnFTZ2CqONy7pz0wvyi+Tf2WPuou6KV6HSMNN02LQl0oaHxwENLGF9eVO2HfWxQA3SZf2pr0S3ta2Tm+RvWQP9++XkUAYZvKVvicTHqB4pOaIUkgH/TE6dv/juzmqHOg6nGOejHeVZ/sqg0wc81OaSKBLRSR1LjEq3DEStyjcjH59CatJBNHpzwaifUaOk9egS1GjN0jfvaJvuKsmrpMumQuF61W2ZD0nNrSgYy+2TFgl2dcgSRT4ZBQ8bYYl5pllW7lKkN8U5KKi4WvW/LnQBLVifKSfKpoGWYXXSCryWctTkC7Ku7D7sRRetS8cUUchyV4BZMowIfRbj5CmWYka18TRyE7/3sAaJ4ai/v+QKawTMzG8+dglENI/cQL0WhlBfbRbn69ObISC9T/Lm8r9Slw8ZN9mmDalZzYtVrnFUMc0naFeEOZcQbdJpmver6bo6CyAdP+stbNGfyqe6cXRqWLh8SY1/TOEmGNN1ztEF8Dpy0d5cy3x+66QfOMYjjejzlJvaHuK4r8KiR+Cu09PHQY2WhyL1mD7QrLPY4OJ4KSjwAMOhcxcEA0HzpMpGwXTgKtF9ofs1WxsvofYWmIHC50iNsddHk+siQY1nWy58BpaWjlheq7KRq0HAiqhUofU+pG8TSgTYpxx+PziBWEqMbgVGij5pimHGASegTP+lRtA9alJjjaFVfp7EdPExPNsOm/pNQFkScVt9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(1076003)(2906002)(186003)(16526019)(40460700003)(86362001)(26005)(40480700001)(336012)(426003)(2616005)(36860700001)(36756003)(81166007)(47076005)(356005)(82740400003)(316002)(41300700001)(6666004)(7696005)(6916009)(70586007)(70206006)(478600001)(5660300002)(44832011)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 04:42:11.5785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be318720-1917-4dad-8210-08db58236944
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Enabling nBIF interrupt history tracker prevents LCLK deep sleep,
hence disable it

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c                        | 2 ++
 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_offset.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index ad70086de9b5..e082f6343d20 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -432,6 +432,8 @@ static void nbio_v7_9_init_registers(struct amdgpu_device *adev)
 	WREG32_SOC15(NBIO, 0, regXCC_DOORBELL_FENCE,
 		0xff & ~(adev->gfx.xcc_mask));
 
+	WREG32_SOC15(NBIO, 0, regBIFC_GFX_INT_MONITOR_MASK, 0x7ff);
+
 	inst_mask = adev->aid_mask & ~1U;
 	for_each_inst(i, inst_mask) {
 		WREG32_SOC15_EXT(NBIO, i, regXCC_DOORBELL_FENCE, i,
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_offset.h
index 033f2796c1e3..c8a15c8f4822 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_offset.h
@@ -6201,6 +6201,8 @@
 #define regNBIF_SHUB_TODET_SYNCFLOOD_CTRL2_BASE_IDX 8
 #define regBIFC_BME_ERR_LOG_HB                                                                          0xe8ab
 #define regBIFC_BME_ERR_LOG_HB_BASE_IDX 8
+#define regBIFC_GFX_INT_MONITOR_MASK                                                                    0xe8ad
+#define regBIFC_GFX_INT_MONITOR_MASK_BASE_IDX 8
 #define regBIFC_HRP_SDP_WRRSP_POOLCRED_ALLOC                                                            0xe8c0
 #define regBIFC_HRP_SDP_WRRSP_POOLCRED_ALLOC_BASE_IDX 8
 #define regBIFC_HRP_SDP_RDRSP_POOLCRED_ALLOC                                                            0xe8c1
-- 
2.17.1

