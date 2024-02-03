Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F14C4828D
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Feb 2024 06:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0DC210F3F2;
	Sat,  3 Feb 2024 06:51:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HrG7ipJs";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC5A10F3F2
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Feb 2024 06:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaPLvdVS4SIiac33xbT24hyFcwt/XULygNDO3oSgb9LEw93MKYD+iEdsZk16fnrprk+EMFXjZwf8w/hwEsLJZg4wUcTxQyQlLbRyXhCeavQ8CXyoA4dZcPRP4bX8wvfZ1seJTKF9MqaIVQo7TE4MH/MBOS4a2rXmysaj1jCd6DJSgCRbuQ+sW/Ca6Zt+mxO7c95FKzsuajYzUydweuEOdRiicGp0Ngb0IcssTk1E+WJ7/3Du8dki/hjf5BBLmjigCa5iWpG5PYqJ8dHSz4go4OoPdhkYsh0QkS3tu+RJYQVVptjF7NzViV3sg7GU3yXnKC4ZuN/rUGtkHtMmmXub6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZauXI63gbNfRIuuqzTxb3CXpmJvIX4scQxBtpwz4hw=;
 b=RhvVl+IEoCHum4kSzVRQge/+4ITXJcIuLiMuG3oBlytd54j/BKqXeP24JB1wA6HUn77H4uSM/A/ty+Y1+hkHOPGRqDldjSrH7Texh4FPuJom8XhlPkRTSPx2jq3z5YvwtUzVv+kaAWUnpPWOof+fqcpYym/PIbgdeRBADTWYt9o0m8nMAE7oibApoYlmlHXL9N6zgWsIswedy47aqI5kQuNWPsdXOhozWAdIHT9cnUAypWWSf3+48+B/rwedZztko0PoROcAg1zZnHpvcpwRzkb6Q1hwbMnCe34fH/BkO23yKK/plr+EayVLPc0MWapvcCDTGFOIT1j52R+XVL78Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZauXI63gbNfRIuuqzTxb3CXpmJvIX4scQxBtpwz4hw=;
 b=HrG7ipJsxW5vX/Kl0dXFP3BOXQr0esz7rjQtfC+bcFYzKVfzuqsgrm4haDiglBuXbdhfnetnVl+gJQuXZA86MxHCnxfmfFBZf3w+dpu0COC6GG9ROMis66pnM4ilnVw63kWPewAeRCGIwdW0xyj7zTWDzCOh5KrnY+4xdZ8GBg8=
Received: from DM6PR05CA0061.namprd05.prod.outlook.com (2603:10b6:5:335::30)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8; Sat, 3 Feb
 2024 06:51:38 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::a5) by DM6PR05CA0061.outlook.office365.com
 (2603:10b6:5:335::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Sat, 3 Feb 2024 06:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Sat, 3 Feb 2024 06:51:37 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 3 Feb
 2024 00:51:36 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd/display: Clear phantom stream count and plane count
Date: Fri, 2 Feb 2024 18:30:59 -0600
Message-ID: <20240203003059.1333-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: 144c4e67-9757-4073-5cac-08dc248491b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ftw6eOrhGg/QOk3EjkcwfhbHnnJwC2ezHmYzdonJZasJRXs3NhesSBmAv5EHsk7N9FVx6Uu20XzxtSXNioekU/vX0YVOVgfrJZuhPbicEaPEghrQ5+5Y9PZ084g89BOtS1mekzvRIssx3bzLmHoAFUzznmcrU5/lyuXLA9FOEOA4vmCLVkzZmWr6bjRxbGV9uZvkNqvpQ6oD7EMsEdaoV9B3fsVnzz5XeUn7va5dJoBgshjzwqg7IxXlBUvHDDY1edtJXcorWWxnmxfTWuutvHPK1WK8pW+Tctzd8jmRB6U7059O6yOcwGjicc+3XsZv5N5H5woOkVwlihdYZxSLazSgfOtKcaza70rFOCkASGMqosSauP8ajptXfh/rLVlT1qMMfVNXz6PkShIicU8bsUmWD71L+ibR9i1Uc5S4CyhP/8vqlVOLDS6sAk/XTKtxxJFCygbzF/GQPEguJrs4DcaJdVZiNVJgxtzxMuOaFv7w4RZasl4Z7Z7Xrfo2qylmn3gV7pNMAfZxXj0lvryndMzBBNGxAdHAKWZWZSFiUzfaX/b2gtc06VGTwBFWCZ97NshQAri5k5pL8KBYzjeas8XZwaPqCxL2t7oxUiS/1mx0M5BrP5Yz9v00lwwwOEv4+3nAhHZGaBDHMOp37zW7sMBgP4KL+9CUe0/SG3mroiQvf9qQmQ5OeZgwzgffbVsTz2iKLKBKrnkZywqtq30DHWiqP1NOhybU0ElTHM9tQXnxMOW74HSz6/Rq2u5ki0LYd13RWlhIw8Erssk9rVRBYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(316002)(6916009)(70586007)(36860700001)(44832011)(8676002)(40460700003)(40480700001)(2906002)(356005)(7696005)(41300700001)(4326008)(36756003)(8936002)(5660300002)(47076005)(86362001)(70206006)(81166007)(82740400003)(336012)(16526019)(426003)(26005)(2616005)(1076003)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2024 06:51:37.7670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 144c4e67-9757-4073-5cac-08dc248491b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937
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

When dc_state_destruct() was refactored the new phantom_stream_count
and phantom_plane_count members weren't cleared.

Fixes: 012a04b1d6af ("drm/amd/display: Refactor phantom resource allocation")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 88c6436b28b6..180ac47868c2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -291,11 +291,14 @@ void dc_state_destruct(struct dc_state *state)
 		dc_stream_release(state->phantom_streams[i]);
 		state->phantom_streams[i] = NULL;
 	}
+	state->phantom_stream_count = 0;
 
 	for (i = 0; i < state->phantom_plane_count; i++) {
 		dc_plane_state_release(state->phantom_planes[i]);
 		state->phantom_planes[i] = NULL;
 	}
+	state->phantom_plane_count = 0;
+
 	state->stream_mask = 0;
 	memset(&state->res_ctx, 0, sizeof(state->res_ctx));
 	memset(&state->pp_display_cfg, 0, sizeof(state->pp_display_cfg));
-- 
2.34.1

