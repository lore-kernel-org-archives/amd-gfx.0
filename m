Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9C4F94CC2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 03:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8453910E1D6;
	Wed, 22 Apr 2026 03:56:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DMnrLj2l";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010009.outbound.protection.outlook.com
 [52.101.193.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89CC210E1DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 03:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgQBLrGQ1OeiiGtS0iXor0cMuF9FUZFkDSfZRyK19MdZNvxPzLeQGTf5d+kV5Qsz7vfC1TiVlZEMZpBTsiFHxdUxgK33Dvz/DvkouacOoJVC+a6NbvBQjyPRz280c6wtaoGyOLYuanHRu4c9i8M+BO2DaMRZ9YSqjuR76oGFqRdr39ZuC4I7dRc2X8UY8yWj7epoW3BRO9zECKhDGogNvngNVORall9sLZbc7ztHWAR4JRBwbn3K1SbyeT5IADzE4+j91MrG0Y9Kyqud7pvG3AcvjxkGJXTkrz5xcKaiDzXXmZEF6yYdXbM4makfbg9elUQlQt4d14GaWXvgjg38uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rn3eelEAdwcaueR4MAG/WqOK7ZTSzp/XNXAtQhLS5qs=;
 b=ppu065xc71OuXN0hDiiKmdhYBJvfnXqioi/QrCe7r7lb91fTy1n07QCA1BaMPYY/0K3UAFXZ/hnbleWRr9pZyVPWRwHESjTmny5KpLsafT+2bteNiTbtLyvRFwLp+XA899c9MvVrrQr6KmMfALV5Gs7weKjqcD59fhPY4cLQkcfGqz6fnbGppkJ49whgDFl2ylbFAa+CTddWoH7gR3jaSqqfEbrzwBfBpJLCJI63UAO1kDmlmRB6SKgjPsN5hamVRHyW1OE3dZJQqGNmwaET4LYKpgWWWrVit2SiixaaJZdgH2YUBcPEkYh8ob+zF8DbqyChgVC6WLrAnajoKgC5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rn3eelEAdwcaueR4MAG/WqOK7ZTSzp/XNXAtQhLS5qs=;
 b=DMnrLj2lqqDFqB7s7HjMkZvqdKcJ6tXicCWKGxwpkIhY8o82f/mS9we7DnA1SKbKPALnhvtt0Gh4rF0sm9kG4eva3xJX5IuPIqvlK70MZObGbReBM74HplUTadM5greU1c+nA8ZbFYc6iYb5qyCuMImq/ZCBW9dTUgEIelQ5070=
Received: from MN0P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::24)
 by SJ5PPF1C7838BF6.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Wed, 22 Apr
 2026 03:56:28 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:52b:cafe::6b) by MN0P223CA0027.outlook.office365.com
 (2603:10b6:208:52b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 03:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 03:56:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:56:27 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:56:26 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Apr 2026 22:56:23 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Leo Chen
 <leo.chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>
Subject: [PATCH 01/14] drm/amd/display: Enable driver power gating
Date: Wed, 22 Apr 2026 11:52:39 +0800
Message-ID: <20260422035611.1870316-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
References: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SJ5PPF1C7838BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: b33aa10d-42da-4725-b939-08dea0232127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Yy6QrnbiZ/B+94ey5xVFGqTtTza9IvTZaI/fv1Ce+zjcPX0/LQebh+Crg+TpR2WE4GJwAoTsc53FxtHnKL4uN6vuutFcuKyEuzNZjtsgionP6kn7XyQC395kF5o12D5ZkxVtiXBtiTTHwQVcgZWzfoRHm9Wy1j9hpucIR5SFRq8PgPDRXSUjyWrh89KRuCiJapJ5F24/whSC8M0vBZOS+Skv8UZwJ7FsQqxPnl4snzfQz3jWweTsQ7iemnVkeC74Lay9AePPHRhyqoYzpeJ3mCynXTgFwBlUZBV93R3a8Kl2yGsaym8jUf/ZmchnM1i/1QVTIUqbg+ZKkvizT4KAl7VTgJVPiieysixEzfCCH3nzYY+LYJN1FsRR+7ffCT/dUJ1/sme7QFLsllUip/g5z6AckfvTEz0G3Aira9/y/cd8iHR/R3lz7wpsshC1D3esZhacdxaN8lUoEqDl3ekjjVa0AAQ+uNMYf6CmPzs51JpMcNkef6EoNsWieFdjVJmSglj/FPFclm6HDraWkxWRYk2MVEBmXEJof0tads4XS6bYGBeF6yUK8dpaFPYHnq/d/rSrE7twOaOB9pb6R1yqA1ImIH8L8fhe7yMqJeEvrGMcmoUoAcKIu6tw1KW57qpAram23uXLMDESVpFJHI6tlfFv3qxmQvnd5ZiAc+0UNK8hh+eVxyIxe+5NKo298msKxUocPbkEfDHdyiWvbasp1pavQ2aePHunIgW0Zm6yIRaV3j9WsZoif6p8tsVQDTtUOnrM8jg5f7rre5OkGxq9uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EYom9nmOJrSir0HZcTbkeqdofK6eG+AESZCl4UFdw6aaoQNsO2+E5/lMaISSRo/SyuBiTmSKz96OezK6GD6Mm5skt3KuepXqEyHK+mpfSo9sUpsdm/165am4S3m+f6ZnbryA43wx99en0PZx0lC2UcoUjdoBzDRwJmkx18+l0CMOWBonhe8tczZ0GZE1VGM9DwkXGwehROgzWs4oKzUVsD6O0ZaiK9N5Asmg5rxzSZSBHV5tUOCvDP1is5MQug55dZtw33pUbjYt6SSCRjAD1wKBiFfr7rhxYRHkmgddRLp+rTD3j/u3YLw15QGj/DjIKcU5X0+tZ223+3lQtA9xeAS6StQxC68/U/6Q6izntsBBB0HAfRr5qn1CPeOjRJ/w/hk2fZK8TDEC+UU3S+m8aKU/jI0s6FO0tyOem8vcArSmUOv5A4OclSmKCfs4GjU9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 03:56:27.3296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b33aa10d-42da-4725-b939-08dea0232127
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1C7838BF6
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

From: Leo Chen <leo.chen@amd.com>

[Why & How]
Enable driver power gating. Temporarily disable DIO power gating.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index d5efe1e8fcee..c2f8554cdcd3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -758,11 +758,12 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.min_disp_clk_khz = 50000,
 	.static_screen_wait_frames = 2,
 	.disable_z10 = false,
-	.ignore_pg = true,
+	.ignore_pg = false,
 	.disable_stutter_for_wm_program = true,
 	.min_deep_sleep_dcfclk_khz = 8000,
 	.replay_skip_crtc_disabled = true,
 	.psr_skip_crtc_disable = true,
+	.disable_dio_power_gate = true,
 };
 
 static const struct dc_check_config config_defaults = {
-- 
2.43.0

