Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49850CD6E4A
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 954FF11284E;
	Thu,  4 Jun 2026 14:55:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UtZJjn+R";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D11E8112840
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThDPf1ec3PVwhEwgKZNfTAEnFyXsNudeJofuM9NWdQT6S+zZS9ySGVVI19DtjxB5IRviq0pOMYVvSyRIkit77nlbQ915OpasD4y+skTgmISq4sdAzN/zq3Li52Nx/hsna+mEwUsQ7p23GL+iwLTROohyQ6r0jzY07SpJrdZE/p6HP3PttVknTh/8nK9xxGDD/E28pcNSoetmSWF8v82uetEIj5pnDS94Q6DrbceewTxA7XjG0Gk1THtnccDFyUDjRB/2ZxGN+jjGvcLgMCpOeo5bJt1xe81u07WLvSRhHgytqKOzuYrvaI6n0INhwSVxXBYiFVKiBWaIgO60RvcgRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuF3XfUr31PclL1AxMoSKvdP9aqKXysz4E4Boh/J1w8=;
 b=huuBaSAwK9Se3Sj2TPQ1Q9bQsrK3L5wLhpciGkVId3FYFg9A4KAtEy88y3i7MaMhLUzj4Ny3I0edoT8HtmsRdSCozDKB8KSIAqvC2kEbcERg+G51zPwaEukXOR5NleFP3+S22drCz+1htAcK0wWwLOHmYfJ8/vaCJMusp3QE2dfJsUdpveO3QMXTpOoiqbCx+zTcoYq/idyfG7D+HLCb5ibpvhlkaPCX5ihDt63hN2X+v5x+6PVFoqFGKuYIWMlclVSXLFrtoUyHI9GYjuqW62Au7qi/gNOviGcvSjLWleMcwAQOleh+xV2L/y0cYfYEdpMc/P1TXvr/rhLrkVPdQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuF3XfUr31PclL1AxMoSKvdP9aqKXysz4E4Boh/J1w8=;
 b=UtZJjn+RD0HQIagvuWS790/Yj3qiDFVBeNidGk0gQhjQ+dwWSQYODwU6+K+9lwCgGjDhtQan9P22GYB/m/i6U1lXqqWBiwBhriGR1UsLOWsIImh//8nRobAC6dAf+lxxD5iwyxg1d06lY19X1gZNTjR+PWfL1ca/Pdiy731b/MU=
Received: from BN0PR07CA0026.namprd07.prod.outlook.com (2603:10b6:408:141::26)
 by BN7PPFCE25C719B.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 14:54:56 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:141:cafe::5b) by BN0PR07CA0026.outlook.office365.com
 (2603:10b6:408:141::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 14:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:54:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:54:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:54:40 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:54:40 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, ChunTao Tso <ChunTao.Tso@amd.com>, Robin Chen
 <robin.chen@amd.com>
Subject: [PATCH 02/24] drm/amd/display: TEST_HARNESS FSN could be 0
Date: Thu, 4 Jun 2026 10:51:56 -0400
Message-ID: <20260604145428.809959-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|BN7PPFCE25C719B:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a5cdf5-fdbe-4371-da28-08dec2493ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: ojmSToR7JaainUCyzk4tSh2O3p3K8xGCvNpI5YEsKeWoTriqAnHXv+lQPFwOS81qzHFTLQ0NBppcvueMvHGrdC/sDpuhwJEryamQ+/baAKK+iXwJZZXRcSmvwxkc+J3YtegPoRYD90IsqaKQDhP/QQjf+2sZOEq5XTLPFHWwBBAc51j9OtJeo1xCjETWANGD4CPlygzysTO2ZfZlxyGd6nAII+lru8SjxMsVgp8TujtRvaeWWQuu5fjpuNOh5EHywY7yK2WW+ApteufrOWE+wZDLepTJFgvPv7dWBmSst5JcCgoSYKVQowhh1SpGDyaXqPnXTnJNhkOcucgYnRZGnqlxaYnGytMI6KSDyy2arMxgcQ4LCCQ79afWOubN7SFrS03XECz/0tIYovnT7i+Bs65ImoDwjyoAcYzAxY0pie9BcT3Eb3x4+gB9o02Em70EER4uX353NSlrW54eIIv6aRaPAAWmEAEivaVgdm/UkW0pVeYR+VqgzFn1kEaSJbmtuOOj5swE1DDigR6TN6CjXPeUkr83Pepx9NX1vProyqhQ1Q5YjJod3UnXO3RFYtrLVlZyHJL2xNhAPgYp9kKKIkY9BYC1FamxMmP0xoaSQqCeqj1/OgMhSRoKozzoso1IO0z19TwMPv2DirldSkJXafEgKyMqL/26bGGGWqm/lqD+hkZhfaQbl28ZL+mbemv0rjt4LUKADW0kHR3a7k4BMwNceIzwwm39w77C+wPhwEc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QiUnGMY3oKeuXGgOllAu/1wUd8z3GvutIcQ1z7UB5abxadKsRDEK76opo3rxXdQF/pbwK4jC5t74vGOAwwF0s+J5cP3yhMbwDK4nWL3ouHoVBAXHYwTCKM2FxMlQjixK8x8U4Rkkpp54mbksSBSQi3PLn065M2/uFtUwbixhInOQv65KYfuJYVGGJU3nneLwRAM5xpfCiag/kjp5cmFoS0dEI3pM6KzZAwtViAbzXP5VeZRJ2HzJeFyFoCUAnmcxg42ztLEsL1FmxzOyCkuf1jw3KTa9uV3GRxInPcvDKeZftupDYsIxLrSEf6VxSElnZ/UOINZ4SK3FEbz6Yrpmb8gWOGcS+5UXfkCEv0Ex6C69WqDJAjqzhumMbQpCWlL/4eR+40snPrYYj8LkvlN0YFUjaQ5OjblNVBrXf7Fx9tHUe7GVNXdX0Ed78ZswVzJW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:54:55.9061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a5cdf5-fdbe-4371-da28-08dec2493ddc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCE25C719B
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

From: ChunTao Tso <ChunTao.Tso@amd.com>

The frame skipping number could be 0 if needed.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: ChunTao Tso <ChunTao.Tso@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/modules/power/power_replay.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_replay.c b/drivers/gpu/drm/amd/display/modules/power/power_replay.c
index 983be9759e74..e782501442c4 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_replay.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_replay.c
@@ -175,11 +175,10 @@ static bool mod_power_update_replay_active_status(unsigned int active_replay_eve
 		if (link->replay_settings.coasting_vtotal_table[PR_COASTING_TYPE_TEST_HARNESS])
 			*coasting_vtotal =
 				link->replay_settings.coasting_vtotal_table[PR_COASTING_TYPE_TEST_HARNESS];
-		if (link->replay_settings.frame_skip_number_table[PR_COASTING_TYPE_TEST_HARNESS]) {
-			ASSERT(link->replay_settings.frame_skip_number_table[PR_COASTING_TYPE_TEST_HARNESS] <= 0xFFFF);
-			*frame_skip_number =
-				(uint16_t)link->replay_settings.frame_skip_number_table[PR_COASTING_TYPE_TEST_HARNESS];
-		}
+
+		ASSERT(link->replay_settings.frame_skip_number_table[PR_COASTING_TYPE_TEST_HARNESS] <= 0xFFFF);
+		*frame_skip_number =
+			(uint16_t)link->replay_settings.frame_skip_number_table[PR_COASTING_TYPE_TEST_HARNESS];
 
 		/* During the ultra sleep mode testing, disable the timing sync in short vblank mode */
 		if (active_replay_events & (replay_event_test_harness_enable_replay)) {
-- 
2.54.0

