Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CCAC25B67
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D649710E821;
	Thu, 26 Oct 2023 14:21:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DCC210E826
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:21:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBE4mi0vNEIbbfBIcamzAbAyy6k7RL6tMRpR9Jvl1gjSsDkpRteUgbsHMGsHk4b/th65FqRc71aJUajF6xr9LDY2AVapGUtpFgpWzsYqotuD38b7DK3X4UY4WAVfZ9B110V5/G43oNxB5O8q9/zgI0FnvnSTII3ib4/jAJPW84PCujLhg54wkq85ht8NCPvemqPtMAXsmfVtryKo7tgVodNvQrEgZcM4WY6DGOh3oUuC03WMKDixfJwjuw5yrZcg8YXjCdXqsHGzLNb9BQUhgktBwkNosgSx+SNi7bMw/0i2EEj2cqUWdv96YIQOb7e9/bBxlwGGhtbLpCwq7sjYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=me5P4F28GbmbxEUEeqFKbO+sXhlXnTfUnQYIqrFFiVs=;
 b=TD3g20+Zr/wK/ITvbHIAICNphtTFJNJyC584v7bGmyeUiawNYefUjz/aGqtktfYM+ZwjCxFcbpEzjX2v2ACX93gpl4aXjpA4S6IWF41r8eGP+/Odmzv7CROIgy1OcYM+WQZTll2tEEy+CAfbAlB9yPnfbqTOTzsbp2nRLTRDwU9jYRXe/7Y0073FouZn30kAecUAN+9dTnzp4l3z9RCGL5e4iQb+pJO3FxrPby4r4OZXjN1MJ20rU7ebrZY6u+dfOhiaQqrE+GngU3vkMvAbExLm4NuykdEwL7/G69EmMpYyfJT/w56arfMN3CZqxxW2Obs64u+8wLn9Ixbw5T0Bvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me5P4F28GbmbxEUEeqFKbO+sXhlXnTfUnQYIqrFFiVs=;
 b=TzNZEBc7Pk58GGcqZHgTWtfNegjs7kOqDNPPEbem8ys0vpeGyMtTId6oiqeod/xUc/CvoZ8KQ2OKELTVSVaoKVd+BSRTfUUgglsMqs9d1MfYcBrlUoW7AskHB+Ttg+pwBAPscB6DbHuYU9FjliBVd72dl03Sr0qTGQpwtczwH+s=
Received: from BYAPR11CA0081.namprd11.prod.outlook.com (2603:10b6:a03:f4::22)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 14:21:09 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::75) by BYAPR11CA0081.outlook.office365.com
 (2603:10b6:a03:f4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Thu, 26 Oct 2023 14:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:21:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:21:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:21:08 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:21:07 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/25] drm/amd/display: Revise Replay Desync Error IRQ handle
Date: Thu, 26 Oct 2023 10:20:20 -0400
Message-ID: <20231026142020.67861-26-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 658231a9-5203-4441-0cee-08dbd62ecc91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z1oyTPWHOffSLGsvT4GpYHccR3w2GdwmgfTRm7lsRIAq3OnQMcoOk0XfKKjZsWAf9LdBMPtsQUpE/eH+3S6WcW9Pp90jO9epQn1Pa85SptBYYN28ExBBrOp82jGw7+9SUdNYa+7R7C6RpBdNZjn0vzTsisLtgS6LxnlZDNLYmAJmyo/x1/RWVwc0hnY37FYNacDh1vQ4A4+r8H17ztHkDd/yE+JqBVXsJa21DeKG4EKRsm2ntpGucq/G0K8C+t7iYAVpQKk9L6pvocc3pvQc8IsKdEWJShfWIY+DctkBKspHKPQ/dno3LY15q6XtCLrMv2iJnwnHXOQBxlEoDPie6u5zgPW4RM993uaZMJOry4sCoK4af13qL3k2aomVQg8nTi5X7idNL9dHZY1M5piKx8gkROezKhkqS7xs0XcEViWi+RPWPG2p3wE+ncoyH8+xawvEwjH+5OqFHq6SeKaW7UeRuLDHesJ6XgvqzZ325Zptsp2NUuhYby0PqlLA/iYmcNSaC0SVsGTnRPqtXByuZ5cYNfTm7BjZNZcPX6qM9Y+22WayMr8wZZ5x6aeSU7oWDwhdZkoyRAjpCB4BZ/+CZCDfZyW9505nYcoi3ypKKykU9KaCajhC0FOXN/iFzxLr+Cz56ZOPvKo9bhHdUft6nO3AYAUnR1wprQf627cUcBQEMTlJAZBGLG+TMkvN7hHYs92xDLuivNhIT5Lx35FN8G0YY4x2+75LGWqtPde27Ohro+WEH4PA2XhkA/y2EA/8FWpKtpM8y9GJajzHAOOPBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(36840700001)(40470700004)(46966006)(478600001)(70206006)(316002)(6916009)(70586007)(4326008)(8676002)(8936002)(54906003)(5660300002)(356005)(40480700001)(36860700001)(81166007)(82740400003)(47076005)(86362001)(2906002)(26005)(336012)(426003)(40460700003)(6666004)(41300700001)(2616005)(1076003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:21:09.1329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 658231a9-5203-4441-0cee-08dbd62ecc91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Dennis Chan <dennis.chan@amd.com>, wayne.lin@amd.com,
 Robin Chen <robin.chen@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dennis Chan <dennis.chan@amd.com>

[Why]
Current Desync IRQ handler will have some potential do not hit the
desync error case. We change to check both desync error HPD and DPCD.

Signed-off-by: Dennis Chan <dennis.chan@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Robin Chen <robin.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h                      | 1 +
 .../drm/amd/display/dc/link/protocols/link_dp_irq_handler.c    | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index bb159b6b1b76..cea666ea66c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1039,6 +1039,7 @@ struct replay_config {
 	uint32_t debug_flags;                           // Replay debug flags
 	bool replay_timing_sync_supported; // Replay desync is supported
 	bool force_disable_desync_error_check;             // Replay desync is supported
+	bool received_desync_error_hpd; //Replay Received Desync Error HPD.
 	union replay_error_status replay_error_status; // Replay error status
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 06e829ef48af..0c00e94e90b1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -210,6 +210,9 @@ static void handle_hpd_irq_replay_sink(struct dc_link *link)
 		&replay_error_status.raw,
 		sizeof(replay_error_status.raw));
 
+	if (replay_configuration.bits.DESYNC_ERROR_STATUS)
+		link->replay_settings.config.received_desync_error_hpd = 1;
+
 	link->replay_settings.config.replay_error_status.bits.LINK_CRC_ERROR =
 		replay_error_status.bits.LINK_CRC_ERROR;
 	link->replay_settings.config.replay_error_status.bits.DESYNC_ERROR =
-- 
2.25.1

