Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B46C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF26810EFE2;
	Wed,  2 Sep 2026 05:10:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dKarqT0q";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABCFB10EFE2
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:10:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sftBjMSHMM1sXSPgEPKOShCF4aWEDvvy8HbR8rCoBqEvRwI0BWgk6H/T+GKo62XZ6tOkbrpKAuEFW0ED7eQUPjnsEDci791BgXarGFK+N8RhGvRtJriEAVHuiLWQP0D7i//V3hsVlD3NYfH0hnBeFaBx4KvGt08fP8Z/68OOBpEIYfl+bM9D38DiAiMjQLkc4JlKXZpMNMh3snQtIHTNxDrEqkcwlt54y0xEbYMa25ybYyH6MY2tULAvU/ZMA680fPFhQj7wrhhPTkM+EOe4XV2yuGCOdFc/BhW2HmINLMirUInKTsE9ZveymKYxCkNJKazKUzZKYx2rCQ1mEO9TBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqqG+iTpP4z115pzOhNKK1phT1+StdU/tMuKIvvxIfo=;
 b=bCwcuegV5Mtfvi7o/HyZk0TXrfsyDqrzFTiF3qvWyO24EmPWkCKFKamGaCJQv5SZNhXKQPq3+tlZ56vkQEFb9Qhj326QknHf3lo8rQw81NKtMivBB8/Uw/aG2G44eieFa5iWbLcI2LSsktIaBl5fkmJBcK6JLatxH3SB+dRUglsMCDHn42hZJ4kLattrWpavR66Yb6OAAm6tVF8hrNbCcTlaNgOc7ExzkNn9ZLUtXEaPRQu/Al4x6DtnjQa6TzFt7o4ZkRZ1MSsyvpJ0PRR7Mne2kDSOWxmIGT/r72M34WnPWW3LIo28LDljxfqdg3p5hs4YrgL1kEqQ6tqHjpPtuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqqG+iTpP4z115pzOhNKK1phT1+StdU/tMuKIvvxIfo=;
 b=dKarqT0qD3nBZ3nqVCRIg9pawHvoVWrxrXW4gkIRCSFDK9/NVyLA28DkkbFGql3QLIqzmNfbhrN0T2DZ2HjBsBRHSPCkI+O9HRTzC3u97sIfoAwsPblvb9TGyo4nWaMO/giSgKl0OGXLdGf5cz+tMmG+U+RVAVHE1i9fAw3WyPE=
Received: from LV3P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::9)
 by SJ5PPF0170DF9F2.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::985) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:10:03 +0000
Received: from LV8PEPF00000066.namprd03.prod.outlook.com
 (2603:10b6:408:234:cafe::5d) by LV3P220CA0006.outlook.office365.com
 (2603:10b6:408:234::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 05:10:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF00000066.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:10:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:10:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:10:00 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:09:47 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 37/40] drm/amd/display: Fix NULL deref of new_stream->sink in
 VTEM guard
Date: Wed, 2 Sep 2026 12:58:59 +0800
Message-ID: <20260902050411.3473916-38-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000066:EE_|SJ5PPF0170DF9F2:EE_
X-MS-Office365-Filtering-Correlation-Id: 7664e044-ce5d-44d3-a0dc-08df08b0712a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OHn9/pLTE2qVg7Ug7Q4Sn2mJcOAl7A2Pu6z4i6jW8VIAklHhX2ZJ58aMn8nQf4boAnfiKf0UZnHjy4Th8McLs9+hGgQvlPgWaYfcgexm06xwUffSo5mpH2eVvraBOckge7KPeQMGOwgwHcOKLguLBaF5TK44qx92HEK1tNIG/I/ykXlWYgGSsVFypu8A4ydM5PATPQkRI/J/U8O3IxWidxGI37L+X/kY/dzAmpndAD+lK/d3ObLsQeQfuGKpgMRCLpsqP/pMcLYpHdvC7+h40n+5n5291OqDjtaZIuuaccNTA2Vdfzs8PVvYzL+ar3T/hsHdqcqFaFcUI0j/sp/BBA6q54D3Fsgb18iDI5WSlWyACzPXJ8ErXSVciaWduBssopxPtveibtED5vW+HcfU97jR7wuHJZx44PVEaDOxtc2qmMYcLHlrXk+VIkX9l9PNXL9v7biHuKD5Ckw2IzsGBv+XU/K97r4B1ne7hKr7ySFYlZJd/qlmmv/6Jq4t+28obdWlK3lJsWqQMq+tgNstZspZnYh3MJG53aXgN0VG/UqTR4N+C5aWZa5HwOTkDoRnM5sfxd5Meq4uBMiybgwLzcLyvY4/iJ4StGgEl5fLk3APcgvoOJm4DGG5u4PF3ylwrQqq+FA4r30tIU3GfAelT+YJuz/igwExDJPuSwEBpOBSP/2M6XnGm3RV94WLsKdHHvi+PVM1sAV3cutb1+6Jkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: roBoxRWK8evJR0wgeEBgIvFoZ66xbDeNKDKagGzeH4bSp5VmiTfMvXrcFCKwKc/bIYPoTV4jdJ6S/AAierMvgLi2zWc7XRdM4N0SUbJ0qHlE2KxmzUNdJlQJNvzguqQNovAAUiIk+e/wLwK/UYecGu80qHGTBHtj5jhl0USuRgLuX76oVioPV/qvhsNqYwgEeHCQamO0MCnX+mEah32lSCbepa1zY/cGMKWIJtvgxdysGwgIpjOvTTJoVDE+AXirO6EiTZeook1m5RRNbymfHhHLO2/H6b4w1pSRVKXZBybVHLuoXDifNe5wriLyGcB/7rshwgbZqEwXOZrkyAmoCEEoy9Ysn6TiVq2Gg6bDSg+xjgyWpGUiFlkWx8tR6I9twwe0FceGFWhmo5y2XliRYzcrulQrQ8zw3QV+NZDLvXnycv0Ho5fdnBbPKDCNlYHx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:10:01.5347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7664e044-ce5d-44d3-a0dc-08df08b0712a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000066.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0170DF9F2
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[Why & How]
amdgpu_dm_update_freesync_state_on_stream() keyed the VTEM guard off
new_stream->sink->sink_signal, but new_stream->sink can be NULL, leading
to a NULL pointer dereference.

Use new_stream->signal instead, which is a direct field of the already
validated new_stream and carries the same HDMI signal type. This matches
the ALLM block in the same function, which already uses new_stream->signal.

Fixes: fabf2169cb45 ("drm/amd/display: Emit VTEM for HF-VSDB VRR on TMDS links")
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 281c6cec9f4b..e8ae238bbb69 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -239,8 +239,8 @@ void amdgpu_dm_update_freesync_state_on_stream(
 		pack_sdp_v1_3);
 
 	/* Per HDMI 2.1, VTEM is valid on TMDS as well as FRL */
-	if (new_stream->sink->sink_signal == SIGNAL_TYPE_HDMI_FRL ||
-	    (new_stream->sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A &&
+	if (new_stream->signal == SIGNAL_TYPE_HDMI_FRL ||
+	    (new_stream->signal == SIGNAL_TYPE_HDMI_TYPE_A &&
 	     aconn && aconn->base.display_info.hdmi.vrr_cap.supported))
 		mod_build_infopacket_vtem(new_stream, &vrr_params, 0, &vrr_infopacket);
 
-- 
2.43.0

