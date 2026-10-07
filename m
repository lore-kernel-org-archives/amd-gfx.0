Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37035CA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8DBE10F711;
	Wed,  7 Oct 2026 17:04:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VPRTtCQ7";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010046.outbound.protection.outlook.com
 [52.101.193.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C961C10F6D6
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiZRdgB9aCxq8tEY/Q1mwsiCrfASlzbWTG02iI3wayhNAFhojkoYV6AYEBsWFPmdG9Vyp+dvVuJ6Qp092WPQN3ZGpgtu2XiRMU4Ju8xSx+yv+JW+aHV7Jb+EBPwEDaH42P9uqocG7vlhqOUAOJ9HSnxNo1iKV9nTwULc6ZHXNbDUJKtKXvPKTEuGpOwUhYyjwzxltiTw01/whV9ja5wDGj2W328htD0OvcnKBkra5zzf/OsAmj0gBGm4nb+kMNiLG47XQ9cfBYW3l1TJVj6VPSmUQrPD/yWKxgXZRwLzp/vD9jt82uPfKVeuugjEBlvPc/cYU0VWJWlm8B8FSa426Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2h8CRneKAFj43nuGORF4re4SvFwCTBPy3YYj+k48ec=;
 b=Gta80t95kOYtVEC1VaAKlm1ffv9Qb/XzpXYFC75ctsNBc2FlcaxGXV272wDK1MsJfRCTsPIUW7Af/KlqZ4jeuQ/hHgiyWp+SoxXW035GEqLWtFvuAa5aDfUhFwO2T+bhfpUwETr/XiWb3Bm4cyDie6j5i/0KyTjlwJE14L1VemybXLV5WpmPiArpfqADkiaS21R7Aatk/XH3OZekZS4t859H07+kMjUhdADBf3vUndql/VwX9D6zGA9cIw8Ztl9Y+OTcFORK7bA1m9PB7doLI4P98vMnMwFc99EfD2Kh+zQNmU80YrY92Y/y7LN7OfrLoug8ghvDcm7lCJYzNGpJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2h8CRneKAFj43nuGORF4re4SvFwCTBPy3YYj+k48ec=;
 b=VPRTtCQ7tV1BlioYPPDgY+tMe1Mn4n8AbsON1UT6g0pCiNS2lpbU9f48rt7PHXqPFJKxS1utDKkr1JhwTpWDT/ViUH4/6l2T7dOYPLlK6e4Pz2fRw2B0tVGUtwi2ABh+R72LwU2skQXgH16nv8X0Vji/awiNL1/+zNGWqmeVcqc=
Received: from SJ0PR03CA0285.namprd03.prod.outlook.com (2603:10b6:a03:39e::20)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 17:04:44 +0000
Received: from MW1PEPF0001888E.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::15) by SJ0PR03CA0285.outlook.office365.com
 (2603:10b6:a03:39e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 17:04:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001888E.mail.protection.outlook.com (10.167.249.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:37 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:36 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:35 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 19/19] drm/amd/display: Fix FreeSync caps tests after common
 EDID VSDB switch
Date: Wed, 7 Oct 2026 12:59:52 -0400
Message-ID: <20261007170412.1898315-20-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001888E:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eafe2cd-3b80-4966-3594-08df249515ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|6133799003|18002099003|10067099003|22082099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: ljqTJ2MmHavHSzXtCb/cY0HcFN0iF7AgRa6gkhs0N1q3dnLr4x7rnp4w6sG2y87nXzmj5xrbctUjyqyFVw4Cwjp5aa7J/Wtqe64KTiNiXe/3yQuEgAe3QHw2tn4Vl8HOgMOp32/zROGOzYjoP/S/J+mrXz0K0YxPUUREU4DR04jSAguLdSzi7ykk/LFOjjPfzL9gN5LMLjy7PySR6qDb4LuS9+0XMmvCQtnOrrFV1G/yoVeh8oauG+dh8MLKTaib5mY4dCc/dnFPXlUdsiFWtyScDIyYfjb1l2x0ITloX+xvjyAe0uRqsMYxaJe9KLURMocUIDNNEqDQgObDq6x5M1qvxmqwg7cd8dgPhbd9Z4L5DxOyVqvg308Lefueq+ctfAON6uFRADi+P9gLyM1OuOiy7kegZ3DxZ93ocVRF0j2brZS1jP06p+BrA01s97owfCygw9O7PZWYSzUthOxJRdESHIfOp+fIBWCD6ZmbHDTPB+0SLB84m8nTZMqC/qnbx7l2i0qyM27LvsL/5QxoVxnSJ9d+AZkZ6XW2P2O+7FfQVjVTfrJz6m9/jIExKVJbQatReuBUaeSp7NZ7rmsEpfGNBdghdIwmcrWhuJ69bsa2ObIVIZmn/PsOb/WkuxyMmGs+i0jgfUfC0agxRqFcgs7nt4xYYv2l+wb1UqWLuTpzATyARMIEclKf3Rnmuw5OQYFJ7m8HS7e9E3mYRFFhyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(6133799003)(18002099003)(10067099003)(22082099003)(11063799006)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xQ/fq1ElfEMWqYsej16HuRoGYwu5yz5bY9y7SJb+g7V8PtXKRRv0vvnlr+h3T+qFoMCbRwqix8GJ4u91OwW3lS4UDTkvcapYIGe+o3laOuk136F/UjVs40MhsLJ5X0aOoVdinUg+nHNmuC0BtmUhBJLktaA68Ai4DteCpfnLt9BL9Bn267yeFGwHAUTFpIyS3xp/RDVrwi1RdWFENdHIi5RrgPwcZxVyrQ8qgTHPh53ZXaa5Md38RIIQWIXgz/UxCQiOkwNUqHJTSktCa/KAHT9WGg+yMvwPHVJxFh5JrRpXEqYAgEvEwf80rYbSNm301qIZ7ewmcNCSpBUgs9pVnOS5vfvKOp/F+hbwS7SrTbqiV40c9sHisN/7pdacCudtQh/UeLi34V50LcnXfteLG0U0WNZCHDZVjgAroBOvoVPUEAngsGCW3BTqjI6TdPtM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:44.0923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eafe2cd-3b80-4966-3594-08df249515ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001888E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
The HDMI and PCON whitelist paths now take their FreeSync range from
get_amd_vsdb(), which reads the VSDB parsed by the common DRM EDID
code. dm_test_fs_edid_amd_vsdb() builds a VSDB with no refresh range
and only the replay feature bit, so both tests saw no FreeSync data
and failed.

Add a refresh rate range to the helper, emitting the v1 min_vfreq and
v3 max_vfreq_ext bytes, and set the FreeSync feature bit in the two
tests that need it.

Fixes: e46eeba0c74c ("drm/amd/display: Use HDMI FreeSync range from common EDID parser")
Assisted-by: Copilot:claude-opus-5

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 30 ++++++++++---------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 56fd133bc405..de3a0b9c961a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -9359,14 +9359,14 @@ dm_test_fs_edid_displayid(struct kunit *test, u8 min_vfreq, u8 max_vfreq)
 	return dm_test_fs_edid_alloc(test, ext);
 }
 
-
 /*
  * A CTA-861 extension carrying a 15-byte AMD VSDB v3 payload, which
  * drm_parse_amd_vsdb() turns into connector->display_info.amd_vsdb and
  * get_amd_vsdb() then reads back.
  */
 static const struct drm_edid *
-dm_test_fs_edid_amd_vsdb(struct kunit *test, u8 feature_caps)
+dm_test_fs_edid_amd_vsdb(struct kunit *test, u8 feature_caps,
+			 u8 min_vfreq, u16 max_vfreq)
 {
 	u8 ext[EDID_LENGTH] = {0};
 
@@ -9377,6 +9377,9 @@ dm_test_fs_edid_amd_vsdb(struct kunit *test, u8 feature_caps)
 	ext[5] = 0x1a;			/* AMD IEEE OUI, LSB first */
 	ext[8] = 0x03;			/* AMD VSDB payload version */
 	ext[9] = feature_caps;
+	ext[10] = min_vfreq;
+	ext[18] = max_vfreq & 0xff;	/* v3 max refresh rate, low bits */
+	ext[19] = (max_vfreq >> 8) & 0x3; /* v3 max refresh rate, high bits */
 
 	return dm_test_fs_edid_alloc(test, ext);
 }
@@ -9394,8 +9397,7 @@ struct dm_test_fs_caps_ctx {
  * Build a connector that clears every guard at the top of
  * amdgpu_dm_update_freesync_caps(): a reset connector state, a dc_sink whose
  * dc_context reports a VRR capable DCE version, and a non-NULL freesync
- * module. The resource pool carries no DMCU, so tests that need the AMD VSDB
- * parser to succeed install one.
+ * module.
  */
 static struct dm_test_fs_caps_ctx *
 dm_test_fs_caps_ctx_alloc(struct kunit *test, enum signal_type sink_signal)
@@ -9539,7 +9541,7 @@ static void dm_test_fs_caps_edp_replay_mode(struct kunit *test)
 {
 	struct dm_test_fs_caps_ctx *ctx =
 		dm_test_fs_caps_ctx_alloc(test, SIGNAL_TYPE_EDP);
-	const struct drm_edid *drm_edid = dm_test_fs_edid_amd_vsdb(test, 0x40);
+	const struct drm_edid *drm_edid = dm_test_fs_edid_amd_vsdb(test, 0x40, 0, 0);
 
 	amdgpu_dm_update_freesync_caps(&ctx->aconnector->base, drm_edid, false);
 
@@ -9552,16 +9554,15 @@ static void dm_test_fs_caps_edp_replay_mode(struct kunit *test)
  * dm_test_fs_caps_hdmi_vsdb - Test the HDMI AMD VSDB refresh range
  * @test: The KUnit test context
  *
- * On HDMI the CEA extension is handed to the DMCU parser, whose reported
- * 24-60Hz range is copied to the connector and published as the monitor range.
- * The DMCU does not report an EDID FreeSync VCP code, so the connector is not
- * marked FreeSync-capable.
+ * On HDMI the 24-60Hz range of the AMD VSDB parsed by the common EDID code is
+ * copied to the connector and published as the monitor range. The VSDB carries
+ * no EDID FreeSync VCP code, so the connector is not marked FreeSync-capable.
  */
 static void dm_test_fs_caps_hdmi_vsdb(struct kunit *test)
 {
 	struct dm_test_fs_caps_ctx *ctx =
 		dm_test_fs_caps_ctx_alloc(test, SIGNAL_TYPE_HDMI_TYPE_A);
-	const struct drm_edid *drm_edid = dm_test_fs_edid_amd_vsdb(test, 0x40);
+	const struct drm_edid *drm_edid = dm_test_fs_edid_amd_vsdb(test, 0x1, 24, 60);
 	struct drm_connector *connector = &ctx->aconnector->base;
 
 	amdgpu_dm_update_freesync_caps(connector, drm_edid, false);
@@ -9575,16 +9576,16 @@ static void dm_test_fs_caps_hdmi_vsdb(struct kunit *test)
 }
 
 /**
- * dm_test_fs_caps_hdmi_no_vsdb - Test an HDMI sink with no AMD VSDB
+ * dm_test_fs_caps_hdmi_no_vsdb - Test an HDMI sink with no FreeSync VSDB
  * @test: The KUnit test context
  *
- * Without a DMCU the CEA parse fails, so no refresh range is recorded.
+ * An AMD VSDB without the FreeSync feature bit records no refresh range.
  */
 static void dm_test_fs_caps_hdmi_no_vsdb(struct kunit *test)
 {
 	struct dm_test_fs_caps_ctx *ctx =
 		dm_test_fs_caps_ctx_alloc(test, SIGNAL_TYPE_HDMI_TYPE_A);
-	const struct drm_edid *drm_edid = dm_test_fs_edid_amd_vsdb(test, 0x40);
+	const struct drm_edid *drm_edid = dm_test_fs_edid_amd_vsdb(test, 0x40, 0, 0);
 
 	amdgpu_dm_update_freesync_caps(&ctx->aconnector->base, drm_edid, false);
 
@@ -9605,8 +9606,9 @@ static void dm_test_fs_caps_pcon_whitelist(struct kunit *test)
 {
 	struct dm_test_fs_caps_ctx *ctx =
 		dm_test_fs_caps_ctx_alloc(test, SIGNAL_TYPE_DISPLAY_PORT);
-	const struct drm_edid *drm_edid = dm_test_fs_edid_amd_vsdb(test, 0x40);
+	const struct drm_edid *drm_edid = dm_test_fs_edid_amd_vsdb(test, 0x1, 24, 60);
 	struct dpcd_caps *dpcd;
+
 	dpcd = &ctx->link->dpcd_caps;
 	dpcd->dongle_type = DISPLAY_DONGLE_DP_HDMI_CONVERTER;
 	dpcd->adaptive_sync_caps.dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT = 1;
-- 
2.43.0

