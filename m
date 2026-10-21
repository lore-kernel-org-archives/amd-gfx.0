Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC249606A31B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4caJLybt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3693410F953;
	Wed, 21 Oct 2026 06:26:52 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2744210F952
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:26:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdCSvhR29wl1AUY9+HC1yuLW2Swqpg5GETr3D67vSUPWBs2fSybWHz5DcFCtZpzAtxMsSd0dH7ac/hr1AXpKtjmuBYmE9QDjtcBiHj5y/vXILFPI10KVZaR6KYO8e3MmoRoSQqnxxroMkh6d9SYhgBG6ZYezG21R2TMLuPSNJkzEaYJuEjqb2+y9cvtD1J0ov8Z8EXrUXzxnr1CzkWJGFAklrnQg5evutXgc04mzKl7oGNKlrJESe/etjb2IsCL8s1E2f9XooD0FgziHLiSeGGc+hiF1lFoGMRg8ic8BohocWDgJ3vO94s48l1jA54YCK/cButQ1wGSAgUM3m92ymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6txvp2QjY43GlvfIm8RUVjVam9wYuhIYeopSxs9C2+A=;
 b=BibVKe4s/lE7GFAe+1iwErw4S7q9QOKqWSfVEnyRa0qXP0e+RnAAztoLv6FnJbPZbBkqFXHoBhn8ip5QKFl9U/24i+jlsPwuJyX99ReNVAEGxgZX/ZnZsmDeyrrvZXV+yeZiG6EViIyBCXzm9OFym4s13LsAuG3XQM+euEh5qXiY07g6M/Msa7eYOiF5TeXp1whGJjICRUwioUM4CQqUtZH0M08mc5E8ibUG0hnpDdj0TSg+ofqtmQKlg5fNM6h+nTmlvdx+VfDBzWmaG5ciMwsOU2O2t2bhfEZuDNxmkzpExvcTeEO5sZ0n4TQatLeRXIW3bzbU0GG+wA1P1cJLbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6txvp2QjY43GlvfIm8RUVjVam9wYuhIYeopSxs9C2+A=;
 b=4caJLybtQudKDkL3JVxswSLsVwApPCuBO9xesyLFBByGujSMIZqr06ZA2itNzYEZ/aDbTm5hq1+qy71qmyAt5fxUJX5wXrSiq/fncDGO0XpzqNWGpmtHxTs9PpSwZqPrMoGzGC/r5ZeSZGQ036NKcuWlepa1H+64EKYFo1Hq9O8=
Received: from SJ0PR03CA0337.namprd03.prod.outlook.com (2603:10b6:a03:39c::12)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 06:26:40 +0000
Received: from SJ1PEPF000037A9.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::51) by SJ0PR03CA0337.outlook.office365.com
 (2603:10b6:a03:39c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 06:26:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037A9.mail.protection.outlook.com (10.167.244.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:26:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:39 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:26:35 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Karthikeyan B <karthikeyan.b@amd.com>
Subject: [PATCH 21/49] drm/amd/display: Poll passive DVI sinks for EDID
 readiness
Date: Wed, 21 Oct 2026 14:22:27 +0800
Message-ID: <20261021062519.674697-22-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A9:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c91e2d-b051-4ce3-9521-08df2f3c4471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|11063799006|56012099006|10067099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xNHIGWbkCdpauGJIrZx211wz93vlQUrIkufR9T3H+9bq+GXTY58r5FBr3K51UmLWxhEhEy2zhZn5KzQEyISGv4tqSIDAP1Bg8R/2jhsUONrqgBlagV2elMGiH/DeEhdnsMWJf16/O/mMWwqt0QaRS6QCDun0DZqMg0tarSQlSVDbz1P8uYhlAsd3JJZRJX4y4+wSICSCG58bpAcf+WBWIomRtRnjm5GY2/UfLYHYWCH0hRhwGQmAPb7PzAYI+D64PLevaxeeDE1fz3EAyuo3qp9alBiRXMA2c+0/weeHGfpX2xaP469aIz/LPE3WGxDZgjHGDFSiJlD7m1frGOoFQlMVDpyyoxsbQng1jcPKej2jRODwTmYKyQj4hZZnam7gEog7uwmjQE1ZegFQRS6ELFiJ8HnnOjEkKotyJzo4jGNdJJ73VrHhN4NC4POmIVyXpjjKugBNUshLUVCOom91E+V92CnTnTjvjTisgjWFB2HWPanf0mTyPV8mfTv9N9ZSYj9/R+pIwPelP5MsD/vrpza42gdkcPkPbXCaNpFUdcz/GcGREjroRdhdklxf86mLuPU9I1y87LQEj2pxQyfYGdx3JEs2webeVx3j50ToFkt607mApnMGeMf+6ZTE9+YuSKURkSLTav/nkSNa8CTACbQyDRg77kcK2n1Y09GwTr0CakP3d7pWDQ1ifmsNrFRHCEeaKa0F4ZAVhxTMdm/gQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(11063799006)(56012099006)(10067099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WR/9qlwwxf3q4bJbgGP5OAnkLf2TwB9Bc753W74yPu2TCiOxZ3yKkrkLXV9N1E2vbLCU7h4PZdcku5McmIxk3mCWVkAu0P0nMKcHzJDunbuJ//cXSJytVcruOC3MoflatT1iljsECs6YUxzGAyIZXVy1Y3qj0D/K8KCSNnlTQkN3RjKddkoGfBd5tE8Y+ALDq3gwwNGwxlrhMuBMXBSqeI5RxKhqgmZRY0QE2p0WSX3EpXk7aS8hHZTxkaEnA2R3xURK3xYDTyQD6rWAhZ/sBNiElBF+PaUabXCk1ltxFoRJbyrNbg+5w9gXURqxWVxIb5wLrJu1PBxhClgDdfXOapkEkk0WrlVBGUN856jwU7EojcgllNism2/7bKqixbH2ip7BzHuwl0yCUL8QuJFMUK778KQI3VRPsOtWY2LsaNEBH5qp5fhFAwoUW9xz2XeV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:26:40.1435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c91e2d-b051-4ce3-9521-08df2f3c4471
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fangzhi Zuo <jerry.zuo@amd.com>

A passive DP-DVI adapter is identified when the adapter DDC probe does not
respond, but the downstream monitor's EDID EEPROM may still need time to
become available after resume. Poll the downstream DDC address for passive
DP-DVI links before reading and parsing the EDID.

Keep the eDP detection optimization without adding a generic EDID retry
delay or a deferred connector reprobe.

Revert commit dfd80cb27a49 ("drm/amd/display: Exit IPS before connector
detection on resume") and rely on targeted passive DP-DVI EDID readiness
polling instead of the generic pre-detection IPS exit.

Fixes: d1d51519bc3b ("drm/amd/display: Skip eDP detection when no sink")
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Karthikeyan B <karthikeyan.b@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 ----
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 22 +++++++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 08837477d9c1..b016f737f3e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2023,10 +2023,6 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	/* On resume we need to rewrite the MSTM control bits to enable MST*/
 	s3_handle_mst(ddev, false);
 
-	/* Exit IPS before the detection loop's first AUX/DDC access. */
-	scoped_guard(mutex, &dm->dc_lock)
-		dc_exit_ips_for_hw_access(dm->dc);
-
 	/* Do detection*/
 	drm_connector_list_iter_begin(ddev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index a4cd5902d428..f0fc6d080c20 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1244,6 +1244,26 @@ void populate_hdmi_info_from_connector(bool enable_frl, struct drm_hdmi_info *hd
 }
 EXPORT_IF_KUNIT(populate_hdmi_info_from_connector);
 
+static void dm_helpers_wait_for_edid_ready(struct dc_link *link,
+					   struct i2c_adapter *ddc)
+{
+	const unsigned int retry_count = 50;
+	const unsigned int retry_interval_ms = 20;
+	unsigned int retry;
+
+	if (!ddc || link->dpcd_caps.dongle_type !=
+			DISPLAY_DONGLE_DP_DVI_DONGLE)
+		return;
+
+	for (retry = 0; retry < retry_count; retry++) {
+		if (drm_probe_ddc(ddc))
+			return;
+
+		if (retry + 1 < retry_count)
+			msleep(retry_interval_ms);
+	}
+}
+
 enum dc_edid_status dm_helpers_read_local_edid(
 		struct dc_context *ctx,
 		struct dc_link *link,
@@ -1268,6 +1288,8 @@ enum dc_edid_status dm_helpers_read_local_edid(
 	if (link->dc->hwss.prepare_ddc)
 		link->dc->hwss.prepare_ddc(link);
 
+	dm_helpers_wait_for_edid_ready(link, ddc);
+
 	/* some dongles read edid incorrectly the first time,
 	 * do check sum and retry to make sure read correct edid.
 	 */
-- 
2.43.0

