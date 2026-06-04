Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E769CD6E6D
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDB1011283C;
	Thu,  4 Jun 2026 14:55:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O7oUWdaF";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81AB011283C
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3akqz9Q1BcwpitjAovjEeRMx5yaQPHIavKwEpS15rHpfKC56Hx1atu4CJefeGf92th1SfXi1peEnN1fCQfH71xn+0SN8fw30kTJz41KboSE/X8N0dybaVjhVm2PLUqQE388VsVhHyX9SdFpEEwhF+waV5ihOwhDlLWSBY5Wt7iJJ9EkHdeoVBg3GLMcdqfxxziZIMCqMWrwVOabrVonIDOCwAmuNnKOC6BA3h9xLxijx2AUjyfdALzeQvWWH5SJyBcoqwf8y85XvPWoWr6hzy9na0A5mlaX3l8gD6nvTitlBJxv8BihN5AyIUoLADubzw31pmnwbTPmwfyLh8xm8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k13gqqzvFhWDdcxlwXT2CcJfwxoFXvCkWfV8ZPihFMo=;
 b=dWj8iEb7kAim15Qox5wBZEa2UgWL4U2/Xz2Q+y1wOX9XE1ON4VwaUv0MLVMX+CArVJH5FhINzyPEod6EjG4y9czRqOHnmXqUuTc/f3bPYAj8umNWyq1A2lMqsgcVowQzSpWS8JEsCLyzEhSI9HRq3cs2zK6FlAD+Du7LkY0N+3SM5Kdj+6bxFHR6lVSXHa1kVbK5YVaOK7rxCOOHgLSrf/KDP8f4BtbYAYWb1MUqZUuWJq5NakDn/U+VySP1F2L0FUZ0WnpSUR6mIzqCsd2k5CKNGo34yfQi9cbL/Pkx/8izo5tM7nZ/4AmamsprgYqRtVCl65bU4Kmo4khOfVINHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k13gqqzvFhWDdcxlwXT2CcJfwxoFXvCkWfV8ZPihFMo=;
 b=O7oUWdaF1uF8ViQtxqMZm5+BEV1VhDFUHbrRlmX4elGzSetKCu+8QBjUOP8mW6uejy4xLTgjIM0FPhqZlv6+KD4s1NeVX31JD4mGyO9JdHP1FeYb/pZVTwjN0FJjJLuH2RHw5COubEOwfHalOWsEu4+nxlEJ8IAnruXZkKlUdzE=
Received: from BL1PR13CA0430.namprd13.prod.outlook.com (2603:10b6:208:2c3::15)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Thu, 4 Jun 2026
 14:55:16 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::55) by BL1PR13CA0430.outlook.office365.com
 (2603:10b6:208:2c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 14:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:55:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:03 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:55:02 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 12/24] drm/amd/display: Fix incorrect logic in CRC source
 handling
Date: Thu, 4 Jun 2026 10:52:06 -0400
Message-ID: <20260604145428.809959-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: 1922179b-9cce-4290-940d-08dec2494951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: OlNlBEcG47vmnKg27tbjhOy9Nm4JkkTH0GQqxahfoY61H0JOW938I3nXiy40UASOH9R6RUASSPsoQBqHdnUto3CtPSsGC3KT/xpQWkOKQE7phc6vUuvVmo0IARFFY8HEU81/zrTeq7T6mGaJ40RPi0I9KAzA4KvWvfv1nLOoKLshbV5RSSl9oM2krzZ/YuPvWdMVSJ71PUN4C0VJ3FFW9mHEMnI2CDFHgEs3JjEJSR7/C35o2SbNnecTOrNSDb+yCI0WamHP01Rhoml6R8LlPNs8opPekIYQgbUXXfrlLOp/Tp133QBb2G9KpINdpYDrwwmtoZ/RshehmxkTwBP7azi0gkB393RBemcuJjmVsozbgeMmX/z0Pf53qignPQY/Df3ty0g4m7HSn2jH45lr63piEOt6krhuZCJ9PZy56WwI+8EY2LMzAtH5sJNfycgPHwxIzS+mNZHcei4IwZIhzktUsYtKyIlsUqIkXYdbiBHPZibiLb1sfX9RLRuU/Ge0/veP4SX/QHo9cA8Kk1Fvwi1vkRbnBbYMTRPtYqV0+UMfdob6jVa1yyV2hJ7tAf6PfqAV5R7fhmQTBSp4l6xZqsxbZYnDRVfVtpdCLyTrZcNXYvJ48nZtIIi7DQUGqW/ZIgQ1fWSVaGrI/btlIxablTjjlVsYKBrs0bz7yc05ZtiTAVJ5rqM+7syQdWrmljS13+LvcQNkEjvNfv9exgvMlNPDxGhTpSOhI1awhyNq/Po=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3E9m6sylONGjMz55Rgw9FFO9IzwF/Nqi0bFEgoK4E0DedpAS/fL6kBmk4tAySLi/bdnjGhHOAl6ujIwaPCR4rc5/tPHlCiTcYR4Gu/eu3ojCHy688L+n9qDxFos+5aOhS48iJlsF6MJDs/5xd5US+2a5j3BOnVJjhNFV/RDNLvj4ErCnApeYDxJXYA20nanLnoS85WsPyMcpYwHDDWDqZJJRU8Uq6YW2HUOyrrt7RdCKX/6jJe/8Raz2h1fq+e+AoVgWe84Lc6gVzCkPCDk7Kbnf0k30r9vKog9SgOSLK9D2NHW5WvZCY6D8whr4iNj5/v+6rPw8FXHqG+wUlTefQQVBzOtdb+qZCDD7RVT4AK8D/ca86JXs9sRa/mg6srPO1lrNPWiGb9gUUX9NifyzhyFJBuPA4B5sUUbBVI+E7j4y14DZZ1vhaCBrqzMX6ybi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:55:15.1318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1922179b-9cce-4290-940d-08dec2494951
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Fix three issues amdgpu_dm_crc.c:
- Use cur_crc_src instead of source when deciding whether to call
  drm_dp_stop_crc() in the disable path of set_crc_source(). When
  disabling CRC, source is always NONE so dm_is_crc_source_dprx(source)
  was always false, meaning drm_dp_stop_crc() was never called when
  stopping a DPRX CRC source. Use cur_crc_src to check what was
  previously active instead.
- Replace fragile 'source < 0' comparisons in verify_crc_source() and
  set_crc_source() with AMDGPU_DM_PIPE_CRC_SOURCE_INVALID.
  and avoiding signed/unsigned enum comparison concerns.
- Remove redundant NULL initializations for drm_dev and acrtc in
  handle_crc_irq(). Both variables are unconditionally assigned right
  after.

Assisted-by: Copilot:Claude-Sonnet-4.6
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 3613e67d1085..d6d38c97fbad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -496,7 +496,7 @@ amdgpu_dm_crtc_verify_crc_source(struct drm_crtc *crtc, const char *src_name,
 {
 	enum amdgpu_dm_pipe_crc_source source = dm_parse_crc_source(src_name);
 
-	if (source < 0) {
+	if (source == AMDGPU_DM_PIPE_CRC_SOURCE_INVALID) {
 		DRM_DEBUG_DRIVER("Unknown CRC source %s for CRTC%d\n",
 				 src_name, crtc->index);
 		return -EINVAL;
@@ -595,7 +595,7 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 	bool enabled = false;
 	int ret = 0;
 
-	if (source < 0) {
+	if (source == AMDGPU_DM_PIPE_CRC_SOURCE_INVALID) {
 		DRM_DEBUG_DRIVER("Unknown CRC source %s for CRTC%d\n",
 				 src_name, crtc->index);
 		return -EINVAL;
@@ -724,7 +724,7 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 		}
 	} else if (enabled && !enable) {
 		drm_crtc_vblank_put(crtc);
-		if (dm_is_crc_source_dprx(source)) {
+		if (dm_is_crc_source_dprx(cur_crc_src)) {
 			if (drm_dp_stop_crc(aux)) {
 				DRM_DEBUG_DRIVER("dp stop crc failed\n");
 				ret = -EINVAL;
@@ -767,9 +767,9 @@ void amdgpu_dm_crtc_handle_crc_irq(struct drm_crtc *crtc)
 {
 	struct dm_crtc_state *crtc_state;
 	struct dc_stream_state *stream_state;
-	struct drm_device *drm_dev = NULL;
+	struct drm_device *drm_dev;
 	enum amdgpu_dm_pipe_crc_source cur_crc_src;
-	struct amdgpu_crtc *acrtc = NULL;
+	struct amdgpu_crtc *acrtc;
 	uint32_t crcs[3];
 	unsigned long flags;
 
-- 
2.54.0

