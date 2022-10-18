Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C127C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 12:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5C6E10EF2F;
	Tue, 18 Oct 2022 12:28:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 346C910EF26
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 12:28:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4NuPwKt33I7ZJhPW3zJkZX+C9CgQhZ6eSehNzeyZQSHakNEd1ZP4B+W+dXGvqNFQRp3VVPZQCDdkO1HwJos8CiAI02TnD8sKExASD1gpjqLn7IHnCH7iIbJNX42oofHZETVPaE+BVpi7Sl2WAw/njp7BDDEmuLBX+mW+Dd9ZIPT2ENaIOOzP1e+/h0yIo5WZzbB9ombAFAfJ2dGSk6CGMSgyEpwWA1IicPaKBtu200VocGjy8xwib5swT6L5Egww5l9fwM/NRKzaztIqGB33iDya5o54b4bVAu68/lTTZnHScI4XsDyiRNL6ZT6Iu3lKkIaKSBmv5tTS0zfyU+hVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiMjdMEzTFnLL8sR2FFsws5ctfixCkGKIEaykSywbh8=;
 b=Xw/KlUFwSAtdxhhX8WmGBVyBninYTsG8/U5+8eOzAscVqskwzVAOAumzxEijjETon6YDT8BzWgl0Q8qepYErBVlmrDkQi7r8a4x9Y9GSC33uPUV6TtlU8JDv8P3pcbjnlrl/AOYvUiFbOMWBhWRwhiKCF0rtLPKnPNfbZIdj1kIhOEj0SU+9qqcgbaiRxYZwdIX/YDic4kSTBzr5Vyb0HuYbV2WLbotKGGe/p9vBgZqi50J6RpxX2U9IfQFQNZ834Sq/SHM1uDBMkYDCKoccs4SOgtwQtd4WBeN613K9KtBA8Bp/4xGMjKgblqoq84ffkuXaEc2xTDko87NUEnpKHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiMjdMEzTFnLL8sR2FFsws5ctfixCkGKIEaykSywbh8=;
 b=QZfLTNfwABUly4yiK3fpYj26+ISniSkRNagLVRnbxZOBHvMQd4b7M3fVOCv9bFd9G2IxWVs7XxXNxXTP/WfuKMhxMRma/IVosMOIYrtom/rrSnuQhKT5AWA4ZVQ2L4jo/1wXBEXIQzgOUNQdS4LrMrvkLIc2g/VBgIlnBNWf44U=
Received: from MW4PR04CA0034.namprd04.prod.outlook.com (2603:10b6:303:6a::9)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 12:28:32 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::97) by MW4PR04CA0034.outlook.office365.com
 (2603:10b6:303:6a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Tue, 18 Oct 2022 12:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 12:28:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 07:28:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 05:28:31 -0700
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via
 Frontend Transport; Tue, 18 Oct 2022 07:28:26 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 08/12] drm/amd/display: Handle seamless boot stream
Date: Tue, 18 Oct 2022 08:28:22 -0400
Message-ID: <20221018122826.1790114-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
References: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT011:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: fc780c23-ded1-4bdf-9938-08dab1044547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JSixhKxs5oFUnjmXD7en242GIewNpHNcxVDfXJ1LO8ZyyXvlKXZnT9Q5hXPDu4rSF9fzZSd/sPJb4J22gvxcJ/fYs7ytALba9uSEn6R7hQ5Q0LBnlsYdnNVCk102q7zD44wBvitrhFnP1kY8bDsNqDD+iGzAB3rmkfSLYW6P951UHLzogFvZqFQAKCZVDazuHAzmS67JMcoiluylLPWszaN2e/wrZJxnq8Mv/kpCU5RUxPjFydWkatHuiXTyaCAXBJEqhZsmwb4UihmVPj4NUfPZtOT/Hjb+YLkqfi9j/QKzVoC2B7xnaLBLi+feMTd3+q6mdKP4ie52N4V/b/pwtUHjsDx7+spRgYJvOshXCl9JTzikS9s7yVzhFZ1V1XNvxlRp2ahA/F+/8AvETesxkXeffojvLb0nP39iAzYJyn5p1sx3EEPqmimCuopquChtVnJbLDhCzVUtP7ve7h4OIbg03rj5P7t/wkPTumFa4PvHEF5ooVkgDYhBOaB89KbNBUMbI/M58kBwmt8HYAC9Zho4R69xk/p08Hfnwhp8xZQgUBzbMk5djPRvlNuWM3SG4pcYEipVwGDXbkCeCFrY9mnjXz+xobThjGkzXk8Tv0BWqE3+6fOcr1+6zC8PSfxwptJ9h0YEu7P3uiOu+F1lMpjFtTzQ4mcbXl6JcrKz+nxjvq4JVE375DZ6GdSejBhQZpaoCCeDyYUCd8vmE57JeFFHaXQ1hMHcFSNxi3TERDWBO1St8Kf/HYADCrJflAjw80bUCvo8THIp2TIE2amUAU+96qaTstlfD2q72wCitZI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(6916009)(54906003)(4326008)(8676002)(5660300002)(316002)(40460700003)(70206006)(70586007)(36860700001)(6666004)(478600001)(2906002)(86362001)(82310400005)(41300700001)(36756003)(8936002)(83380400001)(186003)(1076003)(336012)(426003)(47076005)(82740400003)(40480700001)(356005)(26005)(2616005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 12:28:32.4931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc780c23-ded1-4bdf-9938-08dab1044547
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A seamless boot stream has hardware resources assigned to it, and adding
a new stream means rebuilding the current assignment. It is desirable to
avoid this situation since it may cause light-up issues on the VGA
monitor on USB-C. This commit swaps the seamless boot stream to pipe 0
(if necessary) to ensure that the pipe context matches.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index e001b138b2ac..ba2d4347f722 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2765,6 +2765,21 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 			goto fail;
 	}
 
+	/* Swap seamless boot stream to pipe 0 (if needed) to ensure pipe_ctx
+	 * matches. This may change in the future if seamless_boot_stream can be
+	 * multiple.
+	 */
+	for (i = 0; i < add_streams_count; i++) {
+		mark_seamless_boot_stream(dc, add_streams[i]);
+		if (add_streams[i]->apply_seamless_boot_optimization && i != 0) {
+			struct dc_stream_state *temp = add_streams[0];
+
+			add_streams[0] = add_streams[i];
+			add_streams[i] = temp;
+			break;
+		}
+	}
+
 	/* Add new streams and then add all planes for the new stream */
 	for (i = 0; i < add_streams_count; i++) {
 		calculate_phy_pix_clks(add_streams[i]);
-- 
2.38.0

