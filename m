Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E749CD11DD
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3C5A10FE3D;
	Thu, 28 Mar 2024 19:51:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H5SAJrVf";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32D7710F775
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZYudKgh12vH9qzJyaprDVuu/L37HPL6wikKWoiWdgspNu9+xq20SEWkKu7VZip8PEEQVFTtoIJDyXS2anT6YUhHkzS7g0v6YjuhDmWD8dGw+qggWUsPgtS4k5a8tbeUByr48amJ1Z5U3JXmhF8V6MXPu7lJXerzk4QOLdequqDZIW7PEyZtf4WQ9Jh9F4pnkZ7V4TQ48M1lbAkYtn/qJQOjke+zWcRL720258NT0I9Udr7rufslWqedLx6WcW4lACSVx3Oq4HnK9/Ps06P4hEgUrZx7e71AEJ8kVhfIjsbklgKmgZUu0tuw/wCUvN3UswP2jFIzts1Jtb/+0iHIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rU5224YWR1DGV7RGlfIEmCwBH6sWHVP3PnT6bvAqeU=;
 b=BJOJF26ZwdiAHcv+lQ2xpflrI/VCydFivYLnoPXnuRJmrC972leRI16lXPhz76dNsTmQtFyGh4Y8jAitfWSAmajxmSBvBySSV9h/XJtfzMUC5lThO0mNZQtpiilLafJGiwVSMvOG/dU8mmHzJb+kO8jhGY9+jzQQzYQ6N945X6AmTQ+Lr81NaU+85OsuuYWaZJaXsaUsfP0xD384FXosARXaaQ9DyLbhnQidCnx/umetjGWReIPNW1+fk6QbNb3aEtB7KpoeHId7sjNNdX39/tPd7JcYmPElLPp0RfudQdr8T5ZTMCXuV5lTG0au9z/+8Wmht5FwmeWgoUcl84Nznw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rU5224YWR1DGV7RGlfIEmCwBH6sWHVP3PnT6bvAqeU=;
 b=H5SAJrVfU/pzmBCbf384EpGired7MF7d4xoikyJa3gisfzTmZOL3BexpmJCsohozatQCTBdUlkb7DokCVlbwdN+gQvt0y2zUdf1RpRC0ZaTVCGS1DMgfZ5mbUU36tx2um38cBJGZrulo3Yg64FTSbGD4SEkg2JtqaldgOFS4LSg=
Received: from SJ0PR03CA0359.namprd03.prod.outlook.com (2603:10b6:a03:39c::34)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 19:51:42 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::e2) by SJ0PR03CA0359.outlook.office365.com
 (2603:10b6:a03:39c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:39 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:39 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Duncan Ma
 <duncan.ma@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 15/43] drm/amd/display: Allow HPO PG for DCN35
Date: Thu, 28 Mar 2024 15:50:19 -0400
Message-ID: <20240328195047.2843715-16-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d846227-1a51-4728-dc20-08dc4f607d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ETCcT2xhz5/e5JUGec/aLNwogzP9SkeXNWd6Zn/Et0iZ9AcZZX+MEhlnAcsG8qx9CQ8b/dinojmxRn17bmHQOlCcHov7S8xQ6Yt7DA9Mbi0R0Q6C0oDNsAPYflbXKzd43ovd94e6RSttTW+HN+3uPUWK1oxDHCVoQzokXxb16n3h8tC93yJDUmlUHdoxENHyx+FLcjcAR5zW5u6rwXs1NjMWBuunt2pwI0EHF5PEOQcsqJprbDmR63iiUa7N20lzolxBRcvAMMjolZ+BUlFCwmdpdPhYyK0ch3wRCESfS6RY6DmAxt9Tl92QVAhWoSgfFPa86uieeLsiqrKfQjCdtM3VNdP7WAQrrIAXDzFTDSgY7DL7yxWUPlmfRzm9vaw2Owtr2dBfTU2pNPKIj8dAO+LtkdkSI11AkTwfjLbJFLJ7dpr5kC98PGoy7ipLUY7riE+N7rVOhlTep9As8rg4WjQx9HzGBkAtGe25vZD7x1Sbu+tnKmGNLnz3qP2XtMiUhqMB6FKPA7xoUX4TG2ZVPdxaWzguwga2JHDNUiu15IQbn2QbrgBYM8Y5NMfilmBcXWqNzWsOTR5gECYSsAh3Z7qPFH9o6CNU8YhPxj3s0yL8WpqXRKpPIz6ZaJJvuWsyRpMU13I1dKXscb9F6gI8qIbChapakqNaRMUq4KKrsDwqmt7jWhyueXeXGYXY5LCSiMsBoKa251ytc9mHBYRbrIEAJtmRF0CAL063y8waPYpS/it3ckOjG9Uam1KHj4H
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:41.4836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d846227-1a51-4728-dc20-08dc4f607d52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972
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

From: Duncan Ma <duncan.ma@amd.com>

[Why]
HPO can be power gated unconditionally for
DCN35.

[How]
Set disable flag to false.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 91c6eff79282..f1efce1bfbec 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -721,7 +721,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dpp_power_gate = true,
 	.disable_hubp_power_gate = true,
 	.disable_optc_power_gate = true, /*should the same as above two*/
-	.disable_hpo_power_gate = true, /*dmubfw force domain25 on*/
+	.disable_hpo_power_gate = false, /*dmubfw force domain25 on*/
 	.disable_clock_gate = false,
 	.disable_dsc_power_gate = true,
 	.vsr_support = true,
-- 
2.34.1

