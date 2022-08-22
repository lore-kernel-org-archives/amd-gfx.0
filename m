Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5625C28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 06:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D21EC14BE2A;
	Mon, 22 Aug 2022 06:37:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9FAB950BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 06:37:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzFS89BGW5jtbzFzXT6mhe0oIT/NXjhcLydom2CNH3zlV3Y6NATJqqFGlpLOXHXvqJu9hldhTfPmMnSJ1NTO11MoSfVubof4G8mc4JOkELl4YYSkUgNfWv0SoLYfVSSJnmiyAxni2fzuxKyBHyR0sKC9orjl5YTmZvQM6aHxAKhfp/n5FlTlFhMnYEpaER/iR2MjRHmWP0OIApp0PNUWNr7l4hypSC6UoTGcicEhJ2ehNc24DyrSnpVxhsHdn6gCzK0Q20Ctj/UwJUKKZneC8SYK4+awdT38FyXwPHoD6+UfDLBgqj+kQYszEWUoG2BmU5O3r6jjrv31cjAM1YVrjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rujW9uwZpXKv6Gf1aGEwXKWck7JvZ7mgHykcPMvTgnM=;
 b=ZrcHSgMO3S29dptlte1efhYWASJJ9S4F0TD+iIiZDKfumZ0Becn8yFQ4CcUCIHDorclHzTFap0MQlHbB4vj1dpPzNvHbsj1hpwwspSPz2jx61GXtaN1XSO1A2tWLrPiy1QiG7q8j8smc17AxyoF+FbY1NG1hHD1u7+QI0axxOVLM9ocqkquAvAe4USfhddZnZRhWBvfAUboKaXlwZ78XEzDPiq2rSC6LHFaCQ+efNQvY9Vu2rTtL34IdahOSgYj8/GqeO2nfS0DvZnGLgcrpF/KQyrHILr2BFfs16G4Pxx9dTyi0VK68Z6zRc2xQMleSBp2tgbNosyHBEGOFXWK86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rujW9uwZpXKv6Gf1aGEwXKWck7JvZ7mgHykcPMvTgnM=;
 b=Svuf4xM9kNiDmTpPucbg2seTdgQWBV+2GgF6k0NVp1lTkgbR+U8vZWLbtDG/uuyHmdhhMb4ugNURARtYc0WZ8TO+6O5igPkOoZ10+sJ+auxznZuNtLE5hnqI+OLg/Up1UaXPipNP/b6lxBhp6oA1AEzACnopFoF/iQy++EO9SCY=
Received: from DM5PR08CA0058.namprd08.prod.outlook.com (2603:10b6:4:60::47) by
 BYAPR12MB2613.namprd12.prod.outlook.com (2603:10b6:a03:69::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 06:37:41 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::3e) by DM5PR08CA0058.outlook.office365.com
 (2603:10b6:4:60::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21 via Frontend
 Transport; Mon, 22 Aug 2022 06:37:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 22 Aug 2022 06:37:41 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 01:37:38 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add sdma instance check for gfx11 CGCG
Date: Mon, 22 Aug 2022 14:36:41 +0800
Message-ID: <20220822063641.67974-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dadf0a28-4786-4b8f-aa05-08da8408d008
X-MS-TrafficTypeDiagnostic: BYAPR12MB2613:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fo4ZuQOMgNGHkFdueWcEAsa5MTF8avy3Uc4wboAP7qDQxCcAFHNdNSM3xXoyCHviT8ZDwk6hhKToE7CCfU9ZHwMjzK+U3MbLHmLKlKdhNHfBwHZA4s+pVbXiIP6QACWSnh6g/5xuNhIOIVqbBz+8CIqXEvzaB2ZF3Jo1RywwNzHLtuCYPyNiCmQVBE+HII//xsDhRkNNEgG8urOLLOqWK0rTGe82F6JFg+PddtQRslbjxGmWEkV09Tl4UxdJxE2bhLAxsdVAnpf+aTMGzJn0O3YrUZ0EA986jVTfIPG4I/3E0hoAd4k/jXegaMo20WDfzgpehFab8hz5z0meiG+Rqw3GjZr3A9Ny69mWQiJEjSrRXaTJcqzn/86WWxrOlYko5EQlDqHp9Seey2YCop4SHeBO3nS5bIyTz2jlpH8DFulIDcBziBz93WGHvmqZVJ6KOogFdWM1snW/cIkHYZMePownyRTrgv5vHzLid+Wfa9yRglTNLm+ibOhj7ooI0jK4sTdDT/unmW3ci96zIwXvnTOIfPYvtkqKG36tj6wgEo2sP5IVnMMdlHY6uVqTihiyhcfafhBUIt8lE7bmIghjlX2aoLk/vZFzrFt+OC2Vqq5xaewB/7AZleE8rGfJiHTcO+mhDwHy1hLkfugvflih7TuVXQ4RWP5uS7gIFsqruHQAYAI4lKzwaiImJzkQFFBiOJHsmRU3C2h3+1HjMTZrMEV7YqvYQg1nogbB+TM8kG9AHEQhllAcVwulu9POBQrDxYzQlOjWDEuPBxy0GkHHce24CVRb43+/MrjgZ5RQ4Je9S64cYcy+IEZiy/Mp3Mlp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(36840700001)(46966006)(40470700004)(478600001)(316002)(6916009)(6666004)(26005)(7696005)(5660300002)(8936002)(44832011)(1076003)(336012)(16526019)(2906002)(86362001)(426003)(186003)(2616005)(47076005)(41300700001)(54906003)(40460700003)(81166007)(82310400005)(40480700001)(356005)(83380400001)(4326008)(8676002)(70586007)(82740400003)(70206006)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 06:37:41.0242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dadf0a28-4786-4b8f-aa05-08da8408d008
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2613
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
Cc: Yifan1.zhang@amd.com, Xiaojian.Du@amd.com, Tim
 Huang <tim.huang@amd.com>, Wenhui.Sheng@amd.com, Alexander.Deucher@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For some ASICs, like GFX IP v11.0.1, only have one SDMA instance,
so not need to configure SDMA1_RLC_CGCG_CTRL for this case.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f45db80810fa..e8db772e068c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5182,9 +5182,12 @@ static void gfx_v11_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 		data = REG_SET_FIELD(data, SDMA0_RLC_CGCG_CTRL, CGCG_INT_ENABLE, 1);
 		WREG32_SOC15(GC, 0, regSDMA0_RLC_CGCG_CTRL, data);
 
-		data = RREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL);
-		data = REG_SET_FIELD(data, SDMA1_RLC_CGCG_CTRL, CGCG_INT_ENABLE, 1);
-		WREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL, data);
+		/* Some ASICs only have one SDMA instance, not need to configure SDMA1 */
+		if (adev->sdma.num_instances > 1) {
+			data = RREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL);
+			data = REG_SET_FIELD(data, SDMA1_RLC_CGCG_CTRL, CGCG_INT_ENABLE, 1);
+			WREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL, data);
+		}
 	} else {
 		/* Program RLC_CGCG_CGLS_CTRL */
 		def = data = RREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL);
@@ -5213,9 +5216,12 @@ static void gfx_v11_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 		data &= ~SDMA0_RLC_CGCG_CTRL__CGCG_INT_ENABLE_MASK;
 		WREG32_SOC15(GC, 0, regSDMA0_RLC_CGCG_CTRL, data);
 
-		data = RREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL);
-		data &= ~SDMA1_RLC_CGCG_CTRL__CGCG_INT_ENABLE_MASK;
-		WREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL, data);
+		/* Some ASICs only have one SDMA instance, not need to configure SDMA1 */
+		if (adev->sdma.num_instances > 1) {
+			data = RREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL);
+			data &= ~SDMA1_RLC_CGCG_CTRL__CGCG_INT_ENABLE_MASK;
+			WREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL, data);
+		}
 	}
 }
 
-- 
2.25.1

