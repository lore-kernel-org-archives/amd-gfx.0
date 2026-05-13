Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6CCCD4851
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4EDB10EEBD;
	Wed, 13 May 2026 14:33:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rMfmfJRm";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96AB710EEE2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEONyPKACTEmHLCZDvT4zMWkz1ZPQv8qGhvgLaYRNgsENNhcjqihMI/2I879zYxibDWWDYHBqaamAcprlVtomd2pF175brWA8U5ksa4R8GJFKXaqmQvtByml9pabI04TdGjCC1bF4GyJKniBdK5rH7Qhk5A4LWGLCCjuomjtEcrLkzczmSNGdW152N0t/rkwMdDS/1PPyi0sgEqUOF4WKwbesD2kWN/fvRMrDOblUVAh1VcOqvNoyhRrnezwbrbXF6NldlToADYC3RhQvRrUvOJ3Zwb+eK4vZi3y4dDv6W3thWC0lGMaxD0yfpYOnwXFVr3wbmZ5WOVsnWMZNr05EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0ZFwQD14VBNTJ8qwyr0eskWC+FKx3hig54W1pVSxoY=;
 b=OgdyzPeXztY37j6SS5hkpHhmvqD7Sv6LRgVHVoJXawLhrRaM0fmg7pC+2GR/53yumujn4aZ9zlJRun2aL9ovzI6Zq40rjaKmvsDqBQv+z+fGxMK/Q7ULKSr0l6LmC/jldr7iBOGuqFweOilEh2aLVg/cOkb0pVgCrUmUPFA+pfpT9SvrImyu/hp0n0xuPOmhG2spKS70GPJ4UzBLDivJljtMgyzEocT0moYA6TRG0+Pc+U2OiZZ2YaTqXEVeYpSHuTZGrfVvZg2rWDz38BFz6Gjyq7iQGUCbBEIPVerEnwvrXgJs6vkQ6TnsVbLQOhP8Od2UtSeDHkQqQFfOv01Daw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0ZFwQD14VBNTJ8qwyr0eskWC+FKx3hig54W1pVSxoY=;
 b=rMfmfJRmGrJJq7UKDVa7UV6gsjokC3QJSmTN3IIhIAIcR9DhOoAmnBdsVSb4Iq5YJGJgNqECtdpSTIgEUujQI0gwu8tXXgrQ/t22O2dDJ7FG0IGT97tJrAqZEW32Iruta+JnU7tFOpsbwBTNQSslGebDOugg5rojj+/MpCEC9CQ=
Received: from MW4P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::16)
 by SA6PR12MB999200.namprd12.prod.outlook.com (2603:10b6:806:450::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 13 May
 2026 14:33:50 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::e1) by MW4P220CA0011.outlook.office365.com
 (2603:10b6:303:115::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Wed,
 13 May 2026 14:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 13 May
 2026 09:33:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 May
 2026 09:33:41 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:40 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wei-Guang Li <wei-guang.li@amd.com>, Robin Chen
 <robin.chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 25/28] drm/amd/display: Add debug option for replay ESD
 recovery
Date: Wed, 13 May 2026 10:29:47 -0400
Message-ID: <20260513143213.1852892-27-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|SA6PR12MB999200:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb2e46a-66c2-4d2b-c906-08deb0fca631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|11063799003|56012099003|3023799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Zy6vofQzsn3tSkOqUm/zemQFQla318iOtSdc2jiHT2T+15ZhMqUt4RiPCyRCjyDafDe3EKDY+SDoB4j5wQGg2U23tc1IDXN1C0vsaKIARy81Bbry1NdfpBX28iWUBm2k7iXnYVFteMYqma/TEssOtM74q2Kor5V2zUS7S5xVJLpnW0juVgC7GRXU7XH1YnkiHFhlZHuLjji2X9/0DsKB5h5B2WBfy2xeYMASwGYO4Q0UKWBYxo5ffhJqDgi3ddeynIQyNA/i7Dq+IpiDTHGy1xAmP/n5QSV2F3KCRaQdUp91Bwp38/qorR6nBfy4nsQwdINzLOeiyRTC7zj3N2sttuMxLgGXxzqWtYgTBMWqDhYhcj8Qp3s0WfZsOGxgz0TTYzAbDL2LXZNsKKFfT03q1X5+khRARNrfDOVkQCLM0/PzNXzK+gRPDY5rXvFnmFi13W5GDlCC7IKhTpIAvdb7Fxj3G6JTTu+9uQvTdvnei/qU1ijs79H6CMAacBqgUGzZQwpN/IBB5bzfgfGFSCiXguef1vMAH7ASpB1yFbW6o/pUizMO6SioGBaJ7b+nZZ85UL+nzDIX1xBLphtLmizKn64Om4pVFfb9sAP44m6IX2qQJ9OdpGo7NkBncB68k7/AOVqOYBnXrQfbNGiTeZdXB++ftgrfObza7KwOvHORIKiL9xE/g398ZOrhhliU39ONlsOUkbAj1XLVMDiXO8wflmCwfXw6Cw6D9xHJmI7HxNI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(11063799003)(56012099003)(3023799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KXg4Mjr9Hk6SkwL9kXnr3NmXB8eMEzLTTvPAYcJJAbUHnpX70EDdhjN/WxxSs99ns9YB8gMS1OeN/HzP+RkCln09AUZP6NPWcNodwCYKg9nt7CA5NSd67GUWG1AoLuGmsG1OnOMme/lyJ8Ex2I9iMPmJZNYSpa7c88yizoKsQz6BH3s1w+iLFJd9fxHSYs8ytmiRt8wdRwMp+0r/BHKAVT8X3urm7eYNn14QijwdYMBZCbG7daJ4vD1NMtPavLey1/uNthL+iKuo3QhRkLQ6FWI2o3vnUX2yKumDtGUUIV6DdxUdxadzLYUOrAJ/c18FznJi/dsLUXmX8D3MIkSQ6E4f/nNoO6j53HdqGonzf6nU0KXKqBNGRjIoEq8lNnOGceVSsM62XpxtHTWNqUCY4ShExOtgaOX8GMjEB7+qHfGz2JJhsxz56DEQ26ia8ygp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:49.8402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb2e46a-66c2-4d2b-c906-08deb0fca631
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999200
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

From: Wei-Guang Li <wei-guang.li@amd.com>

[Why&How]
Add a new debug option "enable_replay_esd_recovery" to control whether
to enable the replay ESD recovery feature.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Wei-Guang Li <wei-guang.li@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                |  1 +
 .../dc/link/protocols/link_dp_irq_handler.c        | 14 ++++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d0b6fad65bc0..a356cf4faa1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1220,6 +1220,7 @@ struct dc_debug_options {
 	bool enable_otg_frame_sync_pwa;
 	unsigned int min_deep_sleep_dcfclk_khz;
 	unsigned int force_odm2to1_for_edp_pixclk_mhz;
+	bool enable_replay_esd_recovery;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index f9e0ba24d401..54ce768ae6ad 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -312,12 +312,14 @@ static void handle_hpd_irq_replay_sink(struct dc_link *link, bool *need_re_enabl
 		}
 	}
 
-	if (!link->replay_settings.replay_allow_active &&
-	    replay_sink_status.bits.SINK_DEVICE_REPLAY_STATUS == 0x7) {
-	    /* If sink device replay status is 0x7 and replay is disabled,
-	     * it means sink is in a bad state and link retraining is needed to recover
-	     */
-	    *replay_esd_detection_needed = true;
+	if (link->ctx->dc->debug.enable_replay_esd_recovery) {
+		if (!link->replay_settings.replay_allow_active &&
+		    replay_sink_status.bits.SINK_DEVICE_REPLAY_STATUS == 0x7) {
+		    /* If sink device replay status is 0x7 and replay is disabled,
+		     * it means sink is in a bad state and link retraining is needed to recover
+		     */
+		    *replay_esd_detection_needed = true;
+		}
 	}
 }
 
-- 
2.43.0

