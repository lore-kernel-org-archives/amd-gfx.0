Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216A2C25B72
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00FE310E827;
	Thu, 26 Oct 2023 14:21:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A76F410E817
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:21:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYk2s8RVZ9acKA++3fj78rmlVTmzdzbL0vhwJ/NHr/3b+kWNU3p/1Vlyr06MctLQihuUK0Zz1aHgrUsZcAZafPkVipVuSq2oE3kqgQ+iE6Q0GmXWrWPvfQiTBp7QHFexsmQbW5auLW4gaPpemo7A62XmFLDsKK5DPA7y8IJduYr4RnMgBL3uDde64PqyL/5VGMdTh2pgKe9kGXdRCcbNHlmIHJxhGZZ/iFTNjolA0X/hZzS7FUY9c8zHV1qFMlgsCVrNdbWsOrLh6LhdXHsVeHBmxVWBS+FjnS0KBKeeClTt8g38FfNJBbH6YWPIVYztzLCMg6HShYL1FYLe3P91Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bq8eTY96n/69WZOGJ4i/ii9bhjH7Vo34lnITiQJOS44=;
 b=Wm/lyKaRDVLcHQwUirA1Vfazrw2U5SjjGSMHbdCR2NkkdS3YWvUU0Kf3BKm08vnE9wKdnVIfJ9IJenvkOcA6uiRmSLWLjgHaHgE9nxfCajbT4/AaBx6Ku4NKzMP/doWD/biEqYvoH/ywtNMMMepntKW4qtrf1DC7sNJGc/mQ1D78nNPEd3gh7DpU4YKnfbKcVtgbvZuZrOZ0+vA61aoz4h8QjiN9CEAmMxPw9Jigsf8OjXdLM0NsfEbYZKtxDxEdb/WAHeKZomi6KE2WZRnTaOlrv8xK8vc5eGspyvm8N87DEdSZWOtwPjZ1P60FjtJEGluHn/GKBmlpp5gD+Bi5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq8eTY96n/69WZOGJ4i/ii9bhjH7Vo34lnITiQJOS44=;
 b=vNxzboZ6nR+Q5uNozrBYTT1V37ba+rMFQWOEhjAafJ+TYO8+OPKi6OveCKKrP5su+zQNgujiJcLEe/Sb3yJpceRInjh7vt2bYFi4/74aUZkLjGyOmo5kdi1UOjILsC1ND9UuY6W705XdIZ9Ghn5vFHoZTaHKCPsWQpYcjBtYq7c=
Received: from PH7PR17CA0063.namprd17.prod.outlook.com (2603:10b6:510:325::27)
 by DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 14:21:06 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::aa) by PH7PR17CA0063.outlook.office365.com
 (2603:10b6:510:325::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Thu, 26 Oct 2023 14:21:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:21:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:21:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:21:05 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:59 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/25] drm/amd/display: amend HPD handler for Replay
Date: Thu, 26 Oct 2023 10:20:18 -0400
Message-ID: <20231026142020.67861-24-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 46660b0e-1b39-4ea2-2e74-08dbd62ecb00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1ZzDSeYvivBjo/kqWe+VLclN1yKemBlK7Yk/ueim7/wEugv/zYfV5I83dWAc9zdgCRtRis5c2Zr6lFDXkZIwFjysJAAjkzZOu/WU6e2dNJcqzqO4rzZXvPEEznppb+58CjVsP4aCfdZFPvk0kjBRfc8KhxzKhI35DvQwdNGUUK6lexxFaQcD3boncDqfFIjZxu79i/SdmaatBvSUNGpOQmJMGr+teV6Px8ZnnaDCvv8BlgvogxdV5nvpWhc3ATvftMrK9BUHIgBQzjHfJjl7KUp56iSLc+juwn6lUCW6SoMfyneTkKQfcxVo3MTFUKY0+WB+XiGUVffJr1djiy8VKtxKGMMIHPWKz9323pmXhg8XeYgSzQJd6mDpM5QrvxUngSfiQjXe7Hyb2kjlvh3bQl4ppSvevVhkpvgR7Rdvr82AtE8cljIS0gAvdPITYojBFPUiXhK8iWne043WCHikfDIaZz5qeAtPykqgAd4Suiogb9wKn96pZno+zHvxr/sIr9gif2YuQdRNkIn6NA3/dN8waNt+NhOzRh7sQxkruuO8zbNRjAon7zIXjT1Yt3/CCN87HIUqurr63EE+CXX/46RXaXQkUih+HpuVd0KSVe7B9zfsFL3Pksltka6oJ1eyYlfA06cgpGbHVdMe7hz/423Tug4ATTy7KD6y9el2iOuVv8qCBkqqS9tAeppij/Cx+Tue5F63VObCPNIAGAeXlgIsODGXF+NuEnRttJE+WoZQG/dURvANaHfJOAMrPB79yiOGgHGZGWS+yFyZNXuKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799009)(46966006)(40470700004)(36840700001)(40480700001)(8676002)(8936002)(41300700001)(4326008)(40460700003)(2906002)(5660300002)(47076005)(82740400003)(2616005)(356005)(26005)(36756003)(426003)(336012)(1076003)(6666004)(81166007)(36860700001)(83380400001)(478600001)(86362001)(54906003)(70586007)(70206006)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:21:06.5058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46660b0e-1b39-4ea2-2e74-08dbd62ecb00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, ChunTao Tso <ChunTao.Tso@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: ChunTao Tso <chuntao.tso@amd.com>

[Why]
For Replay, if we receive HPD, it doesn’t need to reboot the display.
We don’t need to return anything exactly.

[How]
Return nothing just because we don’t need to reboot the display.

Signed-off-by: ChunTao Tso <ChunTao.Tso@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
---
 .../display/dc/link/protocols/link_dp_irq_handler.c   | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index fc14c3644144..06e829ef48af 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -184,17 +184,17 @@ static bool handle_hpd_irq_psr_sink(struct dc_link *link)
 	return false;
 }
 
-static bool handle_hpd_irq_replay_sink(struct dc_link *link)
+static void handle_hpd_irq_replay_sink(struct dc_link *link)
 {
 	union dpcd_replay_configuration replay_configuration;
 	/*AMD Replay version reuse DP_PSR_ERROR_STATUS for REPLAY_ERROR status.*/
 	union psr_error_status replay_error_status;
 
 	if (link->replay_settings.config.force_disable_desync_error_check)
-		return true;
+		return;
 
 	if (!link->replay_settings.replay_feature_enabled)
-		return false;
+		return;
 
 	dm_helpers_dp_read_dpcd(
 		link->ctx,
@@ -246,7 +246,6 @@ static bool handle_hpd_irq_replay_sink(struct dc_link *link)
 			edp_set_replay_allow_active(link, &allow_active, true, false, NULL);
 		}
 	}
-	return true;
 }
 
 void dp_handle_link_loss(struct dc_link *link)
@@ -427,9 +426,7 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 		/* PSR-related error was detected and handled */
 		return true;
 
-	if (handle_hpd_irq_replay_sink(link))
-		/* Replay-related error was detected and handled */
-		return true;
+	handle_hpd_irq_replay_sink(link);
 
 	/* If PSR-related error handled, Main link may be off,
 	 * so do not handle as a normal sink status change interrupt.
-- 
2.25.1

