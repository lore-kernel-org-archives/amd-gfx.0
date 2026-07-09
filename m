Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44764C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C589E10F6B9;
	Thu,  9 Jul 2026 21:01:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H28f123j";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011005.outbound.protection.outlook.com
 [40.93.194.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFCC810F6B2
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:01:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hw6pyLFBzeuieyqVGy978AfYvm1ME6GBycaXXRRGeoGKy3J/R7s2fSTO9xy7WYav2LBb1YcqO0sOC/yBv47u6M9yHW50zIJvEIYTbOeDe2PqwITfiZoP9Oa7DccXPPaUeonRuy83ffzZguTLKtP2m1PLrA2rO4TM/AoTQzVV0jG/NqwG7l1TxUS1kMW1colp8VgOmAX+EpkLn8DGAzJjJP7svJzoKz60lHDk/H6B/4JIbcb0IM2uHxuzrIE3ucLKHfmZjo4caKcS02J1YHB1myLqZf14pAkjFG0A7JwqXstUiXazXQsYhUBpsQftC2skFyegplfLe5YfIXiEP37dnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htiP/174qWaQhPs23Wqpxu3ri/AVxFecU7aElQOKXH4=;
 b=ZUC8Bt1FdITNsF0qG+fU2rJ/YJLaMp3BYa+Zghv+hKp1iRCNN6ZG5IPoTpShhdzY5qTGuiwuw7ZLQhA+bnlgP1JBq9K4s+oEUkxGLDQPLT2xEKaZNjJaE9qsS5do+4m0ks7xcs7DcRbjBKTJCJFUMC7QMSHXH0s+4ymPbNc0WX/pnf71Y3ZSY4plpUzDcAt/TGJcrny5TZK5mZU7wtQdRa0rF2629Si01Ilzxlk6Z61U6rU/pZddmeXZPnPVMBd4Bfo1UARFVYgf3TnkevEH383SPBhwClP5njYywuqbrwnxegDDgfYPBVaJ8XU5R10coCZh8rrR7xroPnDhZ9hqWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htiP/174qWaQhPs23Wqpxu3ri/AVxFecU7aElQOKXH4=;
 b=H28f123jQznvADoO39nfGZzieB01oIP7o7rToO9xj/i/XFsHjfJIWRkR7E1fHYxJ3nn8fkSwElOKEbwLNfcNGaSVdU/yJ16e7n3A9OXmFA2AYztpe3jjipY9h3I8iI34qK0ryxxZyal6BKjA4+cSfE2SqlsdNfTgeOmJf04wgwY=
Received: from PH7P220CA0082.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::17)
 by PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:01:43 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:510:32c:cafe::83) by PH7P220CA0082.outlook.office365.com
 (2603:10b6:510:32c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:01:42 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:35 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, George Zhang
 <george.zhang@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>
Subject: [PATCH 04/80] drm/amd/display: Enable PSR and Replay on DCN4 variant
 [Part 2]
Date: Thu, 9 Jul 2026 16:47:32 -0400
Message-ID: <20260709205936.5719-5-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|PH7PR12MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 10bcfde2-a24b-4222-8002-08deddfd477e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QA8kJTDzUrdcr4yzBhkytQX417/JNhZJx0Qkaj0csI/gq/txZ9pzPWfQ/cxs23cqKjFMKpSvF08t5Hmvv4npqROAxPZ4IR6IgMQ5qladX4wjYLprp/ZWDyaS0k+tu4RsUnhCe746zyexLB5qVhXPbq/cJ/N60xfDKpsFHftP51RDMwvUhabafgb99z5jU6UxhzUG05F25mnrsqDApa+KSPZYSg1bM3MaXUPRV/eWpwB2CnprWfQ5yAO8tSc2nZSoe1j4Cc9mkEcpD3u0qGXbF007nzRcnCejtKV9ZASsD4AarRheqXUrHYcsi+AaVriOC7vQp9Dli3HGfZNBmZdDCJoMZ7fsdFmMVkSUGj/LKjadkxoI7qWCBReV+9Pt7M0/ruojHmWHawEG/gCcWgpRpVZ9ifludO40mm6c4cd0N3S6GLcO8hn9Zm2EmOcp/HTfhYdAU9eZC4EJ9Dw90QXDGc5QDhzKbjoO7LTOwS+2OnFjtZyLN+ragssIKO0CiP2RcG/LC/K7QTTEDGM+a4mb40EKNSpaM6IZNpMYTNQbhXgJyXYB/VqX9UD2IQ2a8yXtBsEq8tvNB/7uY4Bg+MQwlL4se+9N2zc7rdZpqgdqm9rE85QTbmer9X8+opiabTxtrj08JdkEcENG2v/kMTFdEkdH22fdct2hFvP8a/SokPGBGjxd1ReB4U1EOVNcPznD4eOyUdRlWh4aH7k7ijEZ+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FXJkdPeRL8PmKSJauYhAga+CJQX/8kZojk86QNBgfUXFHEQN59Ge5SdWsi2uxRg/XDU9/K41of344umIhymmsN9Y5kuF56xkGhXJeem4ZzvLoKW0QIfYlWAQBxS8hBHGVzfbQ17pUteDC0tmLa+yh4DtzePXM/FVtBtFxWmnUpl/JI4upQ/WzX+N9CdDSx6nJr815L69mNbyZFB1w8z/ML87zcxcnagx0qE1OiHm2pOTQcPvs3v1KT/0DkUGUOOKswPx47a0BLDMWLCum01ST369nDDeF7K7cc9xI+Y86Bh9WYKVAK55wXCCJhenP4uHiAD2d9mthW2+IHcRayN/Dd8xZ2ORddQeVPiz6igrtxOL2kOnw6G3Ob87+43zOkSVIH2FjPIBl2Ze+ez+gSwdriuFscDmLqoXykqKA8KlpkvgOdmjWwJE09RmBJxsu4rr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:01:42.8439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10bcfde2-a24b-4222-8002-08deddfd477e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6611
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

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
Enable PSR and Panel Replay on a DCN4 variant for display power
savings.

[How]
Enable PSR and Replay in the DCN4 variant panel config defaults.

Fixes: fe8199d025d4 ("drm/amd/display: Enable PSR and Replay on DCN4 variant and fix AUX instance")
Reviewed-by: George Zhang <george.zhang@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index 60cbaf4f6fdf..330e82b0974b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -1016,9 +1016,9 @@ static struct hubp *dcn42b_hubp_create(
 }
 static const struct dc_panel_config dcn42b_panel_config_defaults = {
 	.psr = {
-		.disable_psr = true,
+		.disable_psr = false,
 		.disallow_psrsu = true,
-		.disallow_replay = true,
+		.disallow_replay = false,
 	},
 	.ilr = {
 		.optimize_edp_link_rate = true,
--
2.55.0

