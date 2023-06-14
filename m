Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA946EB64DC
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 17:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A9C10E141;
	Wed, 14 Jun 2023 17:58:20 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C474910E141
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 17:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPrZ+jlgh0L/3IzV2lD0B1a8ri2AovJrx2FZQdcaMWA45xzOaIxJLWXRhqUfhBglEB02Fi2+FfhbXOd1RwHLtQWqH3Dpt1i3bjsSUx0e2KGpjm6uRiOoZEbqTeEqb/ABzw/ZtRvkaPrv5dyPUuXTeLHnTGmTil6/ByxC6nP3HwonvYbLtDB31JHkpR6/mqsPOg5JJy0f0jkAjKd/3LSGjaZ/mC8BywWxBMgTDN7GvYCo5LqobWFJkA5HXUqFIKbAmD7JaxT+WYeSihfFe5tKsyoOR0X8IiOuWaZyuK4BJEgN8y8MuUuzkCTp5//ZCWtAGHKSgCI6ym12ZqJlcdIRXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVjwxky+/1eHXeQWtI40lK/CkNa3TgWug1acGH0OC14=;
 b=Z0oVL9mxetOP57b+x4yVq57KGAb5kr0tWtyPOawtenWWxqJTkY99I8yaShDBXKiG4YbmU4IceVKgaZZgIdkVKQemmf4rSsPV7+NkUoX8gf44i2NIgZn3uRO4JyMnoOQsIGQ/BjR+0BvW3h2xiiu8xPrAYhXFOxUneCGZDpxUK26f64QRRbZV/BIP7PBkj6VWu1fJzTaVW/nfvSaciU0/AoTOhEx3xKafP8RpRBUFLQwq6mSl+Fpi1zT/0m5LYVCS/DfeFYlQDdA07GEm8suAUH934fTgf5nu/wGiWpC7WDhZUDN6w3A3m/lvdI4xUiHOWgFfJJS96Gxa/Supf2yCsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVjwxky+/1eHXeQWtI40lK/CkNa3TgWug1acGH0OC14=;
 b=Z6M4rfqK2hccWiNQIYIFO1vVOldjmwm9E/gwaK3m2P3HEb+ld1RUR5su5+0PL7ro72tR3X7YXhZDL4Ln1GbUmr0YidodcEV6WTQrB+71N1M9cwQ5rASV3KouEplQtzUX7W7P8qOEAFQXx7T/QYVk5jw5tDej2vzHXRAZz48H9OE=
Received: from MW4PR04CA0047.namprd04.prod.outlook.com (2603:10b6:303:6a::22)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 17:58:13 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::a3) by MW4PR04CA0047.outlook.office365.com
 (2603:10b6:303:6a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 17:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 17:58:13 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 12:58:11 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/17] drm/amd/display: Move DPP/HUBP power gating setting
 below debug initialization
Date: Wed, 14 Jun 2023 13:57:36 -0400
Message-ID: <20230614175750.43359-4-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614175750.43359-1-hamza.mahfooz@amd.com>
References: <20230614175750.43359-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT049:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5f2562-68fb-4050-d3f5-08db6d00ec2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZRL+pzYUrvVPNoYH+OlNUdjYKpon8R5bNHMJPm7cbpni7aDOMaw+Z15HQbK8EGfE+490ZA3dPAFOaYiny8+vsLNyvwUjzYmqzhZpB7iEGyaVgQmlLCdRIGi9Q3R/olecblbAaNVhAeOTy+0KRc/nhBZtD6ickMEGi83MAr2LFG3KBwxCRjT1fH4dUOvGQPdqV0UCpg8/S4M18DPVvDfuGTe+7ABJGkct/P/PPmM2KIUnkDqR+AZ0xHfGHw73/aWQR4/OKNbHjKCmgjFFWvajVCDNVP3ZWKckX0v2KOL6qz6Eo1gWPxwLfWcBagzUWCcC5AoqyeyLniLUarl+RsH5aSO5lJBxlbMNBBdCeGLwrt2244yELvQ7ktxCAVjtpspBa8UHWZF/wggeLVw+Wphacp7j1tYjxshmWreZ04faOfaWRL2+GxLkpdHgRjNAI+C+CZE6BG5dZ6CLj77bFe0sop9Nwale8hEm7notGHtkE+3kyL4g03vfw2fT0iBwjFHeYw5DUsVAEv8G5v02fieyLgVHyavSxe42Lqku/sC464FPLJzdBczFFwbs4aV8so6SarWVZiU/I+qawlPovLxHhH9vjf8VTk22b6WZEeKHd8HBkEftHWpC30FeGvptMNZg/HbHVuOZdR0+BT2FrWpFyHeyaCIoiNlUG4DHs1SweAlwzcRaC135kPQA6wdTCTI15Jks2PlVbP2k6cVhegcFQcAg31sOrLwdxPEdYi9U0ardY1zcQue9a9SlZyZh6i5hFQxrP87z97FiGgqzumXpwD8k5hto5iM+3I41DFvHICH0OeXeII2bjHZ3mQVnpZDh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(8936002)(26005)(40460700003)(8676002)(41300700001)(36860700001)(81166007)(478600001)(82740400003)(36756003)(82310400005)(356005)(70586007)(70206006)(6916009)(4326008)(86362001)(1076003)(316002)(54906003)(6666004)(40480700001)(44832011)(5660300002)(83380400001)(426003)(336012)(186003)(2616005)(16526019)(47076005)(2906002)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 17:58:13.1348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5f2562-68fb-4050-d3f5-08db6d00ec2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

[Why]
Setting DPP/HUBP power gating debug settings occurs before debug
struct initalization leading to the values being clobbered

[How]
Move the setting down below debug struct initalization

Fixes: 6d642c58a814 ("drm/amd/display: Re-enable DPP/HUBP Power Gating")
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 .../drm/amd/display/dc/dcn314/dcn314_resource.c   | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index a840b008d660..03c5690ff54b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1883,13 +1883,6 @@ static bool dcn314_resource_construct(
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
 
-	/* Disable pipe power gating when unsupported */
-	if (ctx->asic_id.hw_internal_rev == 0x01 ||
-			ctx->asic_id.hw_internal_rev == 0x80) {
-		dc->debug.disable_dpp_power_gate = true;
-		dc->debug.disable_hubp_power_gate = true;
-	}
-
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
@@ -1910,6 +1903,14 @@ static bool dcn314_resource_construct(
 		dc->debug = debug_defaults_drv;
 	else
 		dc->debug = debug_defaults_diags;
+
+	/* Disable pipe power gating when unsupported */
+	if (ctx->asic_id.hw_internal_rev == 0x01 ||
+			ctx->asic_id.hw_internal_rev == 0x80) {
+		dc->debug.disable_dpp_power_gate = true;
+		dc->debug.disable_hubp_power_gate = true;
+	}
+
 	// Init the vm_helper
 	if (dc->vm_helper)
 		vm_helper_init(dc->vm_helper, 16);
-- 
2.40.1

