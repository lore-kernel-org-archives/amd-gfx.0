Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B015C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E7AB10E45C;
	Wed,  2 Sep 2026 05:06:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tdLKIGiN";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010056.outbound.protection.outlook.com
 [40.93.198.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FC8C10E45C
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkdm9rXI5qSULakKlja9ksyhtGTg3mbx4QViAl8ucL9UwyWzDSh3QG9Kkt5i8N0fgvVuaved6+uAeWLdsgesTyGwF6VncBsvcFJL0J2/x0MtsHhuoi+rgfckTsm4H3DbN+f5BMd89NdbQvsWguO3IOLBkyFUXrkISaOQ8XS3z1DOEuiwE/ZasMmQPN1kGhF3Pove9TzmGnBCKgfr4Zl2EAeZcD7/7FOGDH6Tro0OVsTKzST+39CqKXvacrxd9pieE55bnm9jN+zNcr8P5hZUz8qzXawdMUsagSB8TVfuKvCux87+FvGUc/YCSmLEWwJD2aiTgVslGnZMFSRJVvvf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lc+6nl6lq+z8q1vch0cozxJA1CL/POwxsUotMF0bWo=;
 b=l0W3hB34tvC4yN+NUj76Aw6utc6Q14p6Gx+Lr/cq1Z6mB6YSKEOrgWg8G9sBknh1Y+qRRpBIrBhDz7PJfXfLrb174im3l48ObCKKbznH/nSlTAcjCgHlL+QNpUSMcKQ91vA06lUD6RzqjVDw3Fr3Qa2mfymxAHF0CTUnsQJI9RyF1WEQjg7TDVOl5MES5NxhzIuv/mE4PrZVAu/EQ3MF5wyIE0QJK/zFVEZSQz0gagA1tMFNPEDrlvoGakESPROTIYO1vMUspMXGaZ7VLpaD9U0qNfFcliXEuJ2UoYOk4H+ExHPISjp0BqcA1U0XnBZc9Jgv0PlUoLT4Y7O25Dqp/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lc+6nl6lq+z8q1vch0cozxJA1CL/POwxsUotMF0bWo=;
 b=tdLKIGiNfdC3uHLpcNa1xk/8jTltQ5a4b1iFTp9nTJbyI60jD1enkLS863s3qQruzMCDtkv4nV8Yz9CZYy2vcAlx4VBDU5tR7+UBTBZ/aIM5zSO3qEELAcN8h/cA4BpH7W/lVhzNt8nQcdJ0SI+piwWKC8drsJGp3aPigHN5LRE=
Received: from BN9PR03CA0471.namprd03.prod.outlook.com (2603:10b6:408:139::26)
 by CY3PR12MB9606.namprd12.prod.outlook.com (2603:10b6:930:102::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:06:23 +0000
Received: from BN1PEPF00018547.namprd05.prod.outlook.com
 (2603:10b6:408:139:cafe::a4) by BN9PR03CA0471.outlook.office365.com
 (2603:10b6:408:139::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 05:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00018547.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:06:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:06:19 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:06:10 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 13/40] drm/amd/display: Cover EDID CEA parsing helpers
Date: Wed, 2 Sep 2026 12:58:35 +0800
Message-ID: <20260902050411.3473916-14-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018547:EE_|CY3PR12MB9606:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e70e38-cfcc-4e2d-9731-08df08afee5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lZPEBZ3LuYjFHMRvOYlxKH2L1qPfqUMBBY0VPz9s0MHqhwLX3dhLqmcg6LpueImU8XNA6QXOaHNNwaamceobjbe52nqxrI8+iB8AxCLtmZqgCg6t7TEi6qOjFNmL9ICAt4tXC/dt9qdg2c396vyJeUnNPLMyDi8GOgIUM+UeZSd1mjmxzBr6sqQQ6eVHCZ8OooRRfqMS98MpF/eHl5oUGD7/+aE3kfz/8xNyk2Ta0VR7jNjjQ1tiYdQqKHTWyP/yeH3P2Zy+3cFAeFDi8WoAepOmKSwdgU00zs4OTioATynon4XCfSNM9N2KmI41bunXCW10A/e2D4fpO16JmflrToxCaNomuUbq/fptgH4PFl+xJxGLVusDHqUwVz9Dm22ecMRIBgPLKqvNx+8lnAIL/jEi5dNrXJ2QkHy2bg298cQWcfCvxtAicLrwiwA8lGX5HEtsyr3RThiN3QIFLDp0a5KqPfieKjKrpZWbx8C5nH/7agcG0o/TK/Oqfxn+xelCe3/+iKhQ6MX14JgAbd8mHVbIwD+GH9EW3d0LMwU4iaNd41a96CC3p5bUVfrfbNJXLFCrs0lr0h8DTXvahAxMt8jr07wTeId3nRSlizs5GcjpaiG8zoNpK38NgYmC/5vCxUAlhei+tEvQKvM4v/GlsviE5SX5+w3i0NkV5cNwyWX0ZcxsBZBMvVGmpzyfBRDnsS7tK3bBnnqP5h8KUOfZKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tH573yYmcXyPTuyyTPh1EEpnHjk7Mb2YO7+RIxZNevj40dZ7oMAuBP6o30Hb4LJ/qZt8Bup7sGNV/vO+YrkpJntw+sO80iaMPqLDwl5dGkQU5gVNyYYqwt5v6cjvqyh2kpJA0vA0P76LwDokSGS+7+EinGKeE3kb2SH6HnjLEno2JH7YfZuI0vBtEUMk0ZoJLhMnA/ifq5gvFoka0K+xkOcCP9N0okvO5bTrhWxMpsRU+EJ9D1Iu+Ht6RnsXCaIb9C96V9+g+JcN6BvsUFnvp2vR5Qkm0JY7tlBR6dy9NC0YKxc77SbPsXaNgXT+7+J2WiMDuZ05M/L+UcB9j9dckqN5lDcHE4TRCRSyiN8K/01U013XSUDMtIxGWIZ6/0OC7XMFrQFWnKREZwwq+ncZyX/ZSDyQYvWC3cJlGyMF/Gk8+WiUDG+O7vajPR1YSaxy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:06:22.1009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e70e38-cfcc-4e2d-9731-08df08afee5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018547.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9606
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

[Why & How]
Add KUnit coverage for the EDID CEA extension parsing helpers
dm_edid_parser_send_cea(), parse_edid_cea_dmcu(), parse_edid_cea_dmub()
and parse_edid_cea(). Tests exercise the oversized-chunk rejection and
DMUB-unavailable paths of the send helper, the DMCU ack/VSDB branches
via a mock dmcu_funcs table, the DMUB empty/send-fail branches, and both
routing branches of parse_edid_cea().

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  12 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |  10 +
 .../tests/amdgpu_dm_connector_test.c          | 337 ++++++++++++++++++
 3 files changed, 355 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 1b184699e955..6a41ccd1b5b9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3544,7 +3544,7 @@ void dm_restore_drm_connector_state(struct drm_device *dev,
 }
 EXPORT_IF_KUNIT(dm_restore_drm_connector_state);
 
-static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
+STATIC_IFN_KUNIT bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 		unsigned int offset,
 		unsigned int total_length,
 		u8 *data,
@@ -3601,8 +3601,9 @@ static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 
 	return true;
 }
+EXPORT_IF_KUNIT(dm_edid_parser_send_cea);
 
-static bool parse_edid_cea_dmcu(struct amdgpu_display_manager *dm,
+STATIC_IFN_KUNIT bool parse_edid_cea_dmcu(struct amdgpu_display_manager *dm,
 		u8 *edid_ext, int len,
 		struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
@@ -3644,8 +3645,9 @@ static bool parse_edid_cea_dmcu(struct amdgpu_display_manager *dm,
 
 	return false;
 }
+EXPORT_IF_KUNIT(parse_edid_cea_dmcu);
 
-static bool parse_edid_cea_dmub(struct amdgpu_display_manager *dm,
+STATIC_IFN_KUNIT bool parse_edid_cea_dmub(struct amdgpu_display_manager *dm,
 		u8 *edid_ext, int len,
 		struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
@@ -3660,8 +3662,9 @@ static bool parse_edid_cea_dmub(struct amdgpu_display_manager *dm,
 
 	return vsdb_info->freesync_supported;
 }
+EXPORT_IF_KUNIT(parse_edid_cea_dmub);
 
-static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
+STATIC_IFN_KUNIT bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
 		u8 *edid_ext, int len,
 		struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
@@ -3676,6 +3679,7 @@ static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
 	mutex_unlock(&adev->dm.dc_lock);
 	return ret;
 }
+EXPORT_IF_KUNIT(parse_edid_cea);
 
 STATIC_IFN_KUNIT void parse_edid_displayid_vrr(struct drm_connector *connector,
 				     const struct edid *edid)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index 6732e5e644cd..e42a0d53b549 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -158,6 +158,16 @@ int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 			const struct edid *edid,
 			struct amdgpu_hdmi_vsdb_info *vsdb_info);
+bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
+			     unsigned int offset, unsigned int total_length,
+			     u8 *data, unsigned int length,
+			     struct amdgpu_hdmi_vsdb_info *vsdb);
+bool parse_edid_cea_dmcu(struct amdgpu_display_manager *dm, u8 *edid_ext,
+			 int len, struct amdgpu_hdmi_vsdb_info *vsdb_info);
+bool parse_edid_cea_dmub(struct amdgpu_display_manager *dm, u8 *edid_ext,
+			 int len, struct amdgpu_hdmi_vsdb_info *vsdb_info);
+bool parse_edid_cea(struct amdgpu_dm_connector *aconnector, u8 *edid_ext,
+		    int len, struct amdgpu_hdmi_vsdb_info *vsdb_info);
 void amdgpu_dm_connector_funcs_force(struct drm_connector *connector);
 enum dc_status dm_validate_stream_and_context(struct dc *dc,
 					      struct dc_stream_state *stream);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 9b3802dc6836..dc5bf2d9daca 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -6099,6 +6099,331 @@ static void dm_test_restore_state_same_sink(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, stream->sink, aconnector->dc_sink);
 }
 
+/* Mock DMCU plumbing for parse_edid_cea_dmcu() tests. */
+static bool dm_test_dmcu_is_init(struct dmcu *dmcu)
+{
+	return true;
+}
+
+static bool dm_test_dmcu_send_cea(struct dmcu *dmcu, int offset,
+				  int total_length, u8 *data, int length)
+{
+	return true;
+}
+
+static bool dm_test_dmcu_recv_ack_ok(struct dmcu *dmcu, int *offset)
+{
+	*offset = 0;
+	return true;
+}
+
+static bool dm_test_dmcu_recv_ack_fail(struct dmcu *dmcu, int *offset)
+{
+	return false;
+}
+
+static bool dm_test_dmcu_recv_vsdb_found(struct dmcu *dmcu, int *version,
+					 int *min_frame_rate, int *max_frame_rate)
+{
+	*version = 2;
+	*min_frame_rate = 24;
+	*max_frame_rate = 60;
+	return true;
+}
+
+static bool dm_test_dmcu_recv_vsdb_none(struct dmcu *dmcu, int *version,
+					int *min_frame_rate, int *max_frame_rate)
+{
+	return false;
+}
+
+static const struct dmcu_funcs dm_test_dmcu_funcs_vsdb = {
+	.is_dmcu_initialized = dm_test_dmcu_is_init,
+	.send_edid_cea = dm_test_dmcu_send_cea,
+	.recv_edid_cea_ack = dm_test_dmcu_recv_ack_ok,
+	.recv_amd_vsdb = dm_test_dmcu_recv_vsdb_found,
+};
+
+static const struct dmcu_funcs dm_test_dmcu_funcs_novsdb = {
+	.is_dmcu_initialized = dm_test_dmcu_is_init,
+	.send_edid_cea = dm_test_dmcu_send_cea,
+	.recv_edid_cea_ack = dm_test_dmcu_recv_ack_ok,
+	.recv_amd_vsdb = dm_test_dmcu_recv_vsdb_none,
+};
+
+static const struct dmcu_funcs dm_test_dmcu_funcs_ackfail = {
+	.is_dmcu_initialized = dm_test_dmcu_is_init,
+	.send_edid_cea = dm_test_dmcu_send_cea,
+	.recv_edid_cea_ack = dm_test_dmcu_recv_ack_fail,
+	.recv_amd_vsdb = dm_test_dmcu_recv_vsdb_none,
+};
+
+/*
+ * Build a bare display manager carrying a dc with a resource pool whose DMCU
+ * uses the supplied funcs table (or no DMCU at all when @funcs is NULL). The
+ * DMCU CEA parser path only touches dm->dc->res_pool->dmcu, so no adev/ctx is
+ * required.
+ */
+static struct amdgpu_display_manager *
+dm_test_alloc_dm_dmcu(struct kunit *test, const struct dmcu_funcs *funcs)
+{
+	struct amdgpu_display_manager *dm;
+	struct resource_pool *pool;
+	struct dmcu *dmcu = NULL;
+	struct dc *dc;
+
+	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	pool = kunit_kzalloc(test, sizeof(*pool), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pool);
+
+	if (funcs) {
+		dmcu = kunit_kzalloc(test, sizeof(*dmcu), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, dmcu);
+		dmcu->funcs = funcs;
+	}
+
+	pool->dmcu = dmcu;
+	dc->res_pool = pool;
+	dm->dc = dc;
+	return dm;
+}
+
+/*
+ * Build a display manager backed by an amdgpu_device and a dc with a ctx (but
+ * no DMUB), so the DMUB CEA send path can build a command, fail the execute,
+ * and log via drm_err() safely.
+ */
+static struct amdgpu_display_manager *dm_test_alloc_dm_adev(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	adev->dm.adev = adev;
+	adev->dm.dc = dc;
+	return &adev->dm;
+}
+
+/**
+ * dm_test_send_cea_length_too_long - Test an oversized chunk is rejected
+ * @test: KUnit test context
+ */
+static void dm_test_send_cea_length_too_long(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_test_alloc_dm_adev(test);
+	struct amdgpu_hdmi_vsdb_info vsdb = {0};
+	u8 data[16] = {0};
+	bool ret;
+
+	ret = dm_edid_parser_send_cea(dm, 0, 128, data,
+				      DMUB_EDID_CEA_DATA_CHUNK_BYTES + 1, &vsdb);
+	KUNIT_EXPECT_FALSE(test, ret);
+}
+
+/**
+ * dm_test_send_cea_dmub_unavailable - Test a failed DMUB command reports false
+ * @test: KUnit test context
+ */
+static void dm_test_send_cea_dmub_unavailable(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_test_alloc_dm_adev(test);
+	struct amdgpu_hdmi_vsdb_info vsdb = {0};
+	u8 data[DMUB_EDID_CEA_DATA_CHUNK_BYTES] = {0};
+	bool ret;
+
+	/* ctx->dmub_srv is NULL, so the DMUB command execute fails. */
+	ret = dm_edid_parser_send_cea(dm, 0, 8, data,
+				      DMUB_EDID_CEA_DATA_CHUNK_BYTES, &vsdb);
+	KUNIT_EXPECT_FALSE(test, ret);
+}
+
+/**
+ * dm_test_parse_cea_dmcu_empty - Test an empty extension parses to no VSDB
+ * @test: KUnit test context
+ */
+static void dm_test_parse_cea_dmcu_empty(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_test_alloc_dm_dmcu(test, NULL);
+	struct amdgpu_hdmi_vsdb_info vsdb = {0};
+	u8 ext[1] = {0};
+
+	KUNIT_EXPECT_FALSE(test, parse_edid_cea_dmcu(dm, ext, 0, &vsdb));
+}
+
+/**
+ * dm_test_parse_cea_dmcu_no_dmcu - Test a missing DMCU fails the first send
+ * @test: KUnit test context
+ */
+static void dm_test_parse_cea_dmcu_no_dmcu(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_test_alloc_dm_dmcu(test, NULL);
+	struct amdgpu_hdmi_vsdb_info vsdb = {0};
+	u8 ext[DMUB_EDID_CEA_DATA_CHUNK_BYTES] = {0};
+	bool ret;
+
+	/* res_pool->dmcu is NULL, so the CEA send returns false. */
+	ret = parse_edid_cea_dmcu(dm, ext, DMUB_EDID_CEA_DATA_CHUNK_BYTES,
+				  &vsdb);
+	KUNIT_EXPECT_FALSE(test, ret);
+}
+
+/**
+ * dm_test_parse_cea_dmcu_vsdb_found - Test the DMCU reports an AMD VSDB
+ * @test: KUnit test context
+ */
+static void dm_test_parse_cea_dmcu_vsdb_found(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm =
+		dm_test_alloc_dm_dmcu(test, &dm_test_dmcu_funcs_vsdb);
+	struct amdgpu_hdmi_vsdb_info vsdb = {0};
+	u8 ext[DMUB_EDID_CEA_DATA_CHUNK_BYTES] = {0};
+	bool ret;
+
+	ret = parse_edid_cea_dmcu(dm, ext, DMUB_EDID_CEA_DATA_CHUNK_BYTES,
+				  &vsdb);
+	KUNIT_EXPECT_TRUE(test, ret);
+	KUNIT_EXPECT_TRUE(test, vsdb.freesync_supported);
+	KUNIT_EXPECT_EQ(test, vsdb.amd_vsdb_version, 2);
+	KUNIT_EXPECT_EQ(test, vsdb.min_refresh_rate_hz, 24);
+	KUNIT_EXPECT_EQ(test, vsdb.max_refresh_rate_hz, 60);
+	KUNIT_EXPECT_EQ(test, vsdb.freesync_mccs_vcp_code, 0);
+}
+
+/**
+ * dm_test_parse_cea_dmcu_vsdb_none - Test the DMCU finds no AMD VSDB
+ * @test: KUnit test context
+ */
+static void dm_test_parse_cea_dmcu_vsdb_none(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm =
+		dm_test_alloc_dm_dmcu(test, &dm_test_dmcu_funcs_novsdb);
+	struct amdgpu_hdmi_vsdb_info vsdb = {0};
+	u8 ext[DMUB_EDID_CEA_DATA_CHUNK_BYTES] = {0};
+	bool ret;
+
+	ret = parse_edid_cea_dmcu(dm, ext, DMUB_EDID_CEA_DATA_CHUNK_BYTES,
+				  &vsdb);
+	KUNIT_EXPECT_FALSE(test, ret);
+}
+
+/**
+ * dm_test_parse_cea_dmcu_multi_chunk - Test intermediate chunks are acked
+ * @test: KUnit test context
+ */
+static void dm_test_parse_cea_dmcu_multi_chunk(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm =
+		dm_test_alloc_dm_dmcu(test, &dm_test_dmcu_funcs_vsdb);
+	struct amdgpu_hdmi_vsdb_info vsdb = {0};
+	u8 ext[2 * DMUB_EDID_CEA_DATA_CHUNK_BYTES] = {0};
+	bool ret;
+
+	ret = parse_edid_cea_dmcu(dm, ext, 2 * DMUB_EDID_CEA_DATA_CHUNK_BYTES,
+				  &vsdb);
+	KUNIT_EXPECT_TRUE(test, ret);
+}
+
+/**
+ * dm_test_parse_cea_dmcu_ack_fail - Test a failed chunk ack aborts the parse
+ * @test: KUnit test context
+ */
+static void dm_test_parse_cea_dmcu_ack_fail(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm =
+		dm_test_alloc_dm_dmcu(test, &dm_test_dmcu_funcs_ackfail);
+	struct amdgpu_hdmi_vsdb_info vsdb = {0};
+	u8 ext[2 * DMUB_EDID_CEA_DATA_CHUNK_BYTES] = {0};
+	bool ret;
+
+	ret = parse_edid_cea_dmcu(dm, ext, 2 * DMUB_EDID_CEA_DATA_CHUNK_BYTES,
+				  &vsdb);
+	KUNIT_EXPECT_FALSE(test, ret);
+}
+
+/**
+ * dm_test_parse_cea_dmub_empty - Test an empty extension returns the flag
+ * @test: KUnit test context
+ */
+static void dm_test_parse_cea_dmub_empty(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_test_alloc_dm_adev(test);
+	struct amdgpu_hdmi_vsdb_info vsdb = {0};
+	u8 ext[1] = {0};
+
+	/* No chunks are sent, so the freesync flag is returned as-is. */
+	vsdb.freesync_supported = true;
+	KUNIT_EXPECT_TRUE(test, parse_edid_cea_dmub(dm, ext, 0, &vsdb));
+}
+
+/**
+ * dm_test_parse_cea_dmub_send_fail - Test a chunk send failure aborts the parse
+ * @test: KUnit test context
+ */
+static void dm_test_parse_cea_dmub_send_fail(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_test_alloc_dm_adev(test);
+	struct amdgpu_hdmi_vsdb_info vsdb = {0};
+	u8 ext[DMUB_EDID_CEA_DATA_CHUNK_BYTES] = {0};
+	bool ret;
+
+	/* The first chunk send fails (no DMUB), so the parse bails out. */
+	ret = parse_edid_cea_dmub(dm, ext, DMUB_EDID_CEA_DATA_CHUNK_BYTES,
+				  &vsdb);
+	KUNIT_EXPECT_FALSE(test, ret);
+}
+
+/**
+ * dm_test_parse_cea_routes_dmub - Test a present dmub_srv routes to DMUB
+ * @test: KUnit test context
+ */
+static void dm_test_parse_cea_routes_dmub(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_hdmi_vsdb_info vsdb = {0};
+	u8 ext[1] = {0};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	mutex_init(&adev->dm.dc_lock);
+	adev->dm.dmub_srv = kunit_kzalloc(test, 1, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev->dm.dmub_srv);
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	aconnector->base.dev = &adev->ddev;
+
+	/* len 0 routes to the DMUB parser, which returns the freesync flag. */
+	vsdb.freesync_supported = true;
+	KUNIT_EXPECT_TRUE(test, parse_edid_cea(aconnector, ext, 0, &vsdb));
+}
+
+/**
+ * dm_test_parse_cea_routes_dmcu - Test a missing dmub_srv routes to DMCU
+ * @test: KUnit test context
+ */
+static void dm_test_parse_cea_routes_dmcu(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_hdmi_vsdb_info vsdb = {0};
+	u8 ext[1] = {0};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	mutex_init(&adev->dm.dc_lock);
+	adev->dm.dmub_srv = NULL;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	aconnector->base.dev = &adev->ddev;
+
+	/* len 0 routes to the DMCU parser, which returns false. */
+	KUNIT_EXPECT_FALSE(test, parse_edid_cea(aconnector, ext, 0, &vsdb));
+}
+
 /**
  * dm_test_get_amd_vsdb_unsupported - Test a zero VSDB version reports no support
  * @test: The KUnit test context
@@ -8862,6 +9187,18 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_restore_state_no_encoder),
 	KUNIT_CASE(dm_test_restore_state_no_stream),
 	KUNIT_CASE(dm_test_restore_state_same_sink),
+	KUNIT_CASE(dm_test_send_cea_length_too_long),
+	KUNIT_CASE(dm_test_send_cea_dmub_unavailable),
+	KUNIT_CASE(dm_test_parse_cea_dmcu_empty),
+	KUNIT_CASE(dm_test_parse_cea_dmcu_no_dmcu),
+	KUNIT_CASE(dm_test_parse_cea_dmcu_vsdb_found),
+	KUNIT_CASE(dm_test_parse_cea_dmcu_vsdb_none),
+	KUNIT_CASE(dm_test_parse_cea_dmcu_multi_chunk),
+	KUNIT_CASE(dm_test_parse_cea_dmcu_ack_fail),
+	KUNIT_CASE(dm_test_parse_cea_dmub_empty),
+	KUNIT_CASE(dm_test_parse_cea_dmub_send_fail),
+	KUNIT_CASE(dm_test_parse_cea_routes_dmub),
+	KUNIT_CASE(dm_test_parse_cea_routes_dmcu),
 	/* get_amd_vsdb */
 	KUNIT_CASE(dm_test_get_amd_vsdb_unsupported),
 	KUNIT_CASE(dm_test_get_amd_vsdb_supported),
-- 
2.43.0

