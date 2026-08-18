Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AC3C5DF93
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A713310ECC4;
	Tue, 18 Aug 2026 20:22:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XsYUZOWx";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDDCE10ECBF
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjjxFQgOgTz53qsTGCMZVwSJ675Hu3u/4b3HTeUJF7QzLnp7aCVhincqj2ZSV90J84ZQNke3ZlL29ReV4TrI1PmCFmQ8LJqfa2dY2iH8grsyMqoDp2yypnqEaHYXGwWqomNxe+jNKHO7izqBuBW+SquiCZeWqU5R5M8es6QXf0rl1Fpvl1ClcPX4VSbRQlCv1ByK/PRBeDQr5XwQzUuA0hC+PXcRXwtKgGbNxnGbgV8Za7ioRAIRqLDz4c5xqqiUi6CBjM2vO/2zW5W0TUNK8mO69ifhoyhRqWsFrXQRmnMc/G6dMHRgplR2p4zTzGDhhDGOpzyY8+yzA4pSkCkx1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olPv8mobIZlM1Z5kyoLk/GnmOPFwOpesMV+PxDQfX/c=;
 b=CTlXNjc2NcD/gwj3cWAAB8beVdIJ91uzpqCzapI5Qwg+kPHYaPypOy/tO92UjRDI/Th27AO+pvAjCxSgnBiMecS+AIyedCzSCcb5ITGteak18hyOtp0wK4fdRPDvciOQ0SoQGqOH2uFVQlgm3CHEHl0E1eCn/wqEAMZ/zFtg8UquxHJzJRfV35O/E9W7GinBLi9rZz8FXw63W7rIb1yuiFyBI+OzpbptFd3oGhNZA2dTy/c8QIAznK309j6PdGpuYjAtOYNeVwTACV+2yHAjvctZQARAvAjeM6f+aGo3+tjkSsrIBolWRwXsj2aLW096/qatiuKEAhMUzW4DK0kz1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olPv8mobIZlM1Z5kyoLk/GnmOPFwOpesMV+PxDQfX/c=;
 b=XsYUZOWxNeXQpKUVtoRuY7JPW3G2BibZhnmBcYzxOxObs81Tmr9DHe4Ny93AUYgJbOZnGgZygeQxq7ZrWkajZqHQDxoHmSGgPw+EB9Y2M5mQQawTWO8Sb5BJrZc97+6unVZ3HuN35zQhyDL4f+pdkspKShkxyWkiSDpQT3GiOcs=
Received: from CH5P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::25)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:42 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:610:1ee:cafe::18) by CH5P222CA0009.outlook.office365.com
 (2603:10b6:610:1ee::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:31 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:31 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:31 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 53/82] drm/amd/display: Cover mode_valid EDID mgmt path
Date: Tue, 18 Aug 2026 16:15:45 -0400
Message-ID: <20260818202139.4172592-54-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|CY5PR12MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: 449ec85b-96a2-4a55-4d67-08defd6674fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rMiraY3b5nawz0qanfuPRn+PAOzQRtvQilPA81PVa/oh0JEvAJjkBSgZ4uSDDmSf59v47L64YQFRKhf5yhO/TczH58MRldvaURNfwWRif/Wpsm261k+wTcIpcbjDwoe0Aa/UkZhr+w04ZL4foKeI+jvWLnxTfDiTzVNIMolkfmyIQWvXrbCkED4K4DwlbyxhMK+1XwnjLLqOiVt9cUbN+2fbWsIxoJ+sYepNsOXNcG2yvjsTFZauNvsc/yQDy4a/Qarj2bbd3y0gjIRrzLmArJxdOVFepB8PjF06xh2v99/8TENp94Y2txxEKbqEJIqp85klhKptjTfY5mIt0OGmxszM10pQKaR42UVYCqCwvACVuunqQmyzMypJp9vDUo+HWsj96oF6HqCEotrM3rEE+Jun5lX8QkfnIxQbX28vL2khFfGo8jdP7pM+C0HxHH5lgXvegKBekGaSgEZ5IdXtHstYqOKtvBVd0XropuTDQqT7OItLvQnGctfj9cPcXHD1f722N4q43Rw29KKbNQvKCJqEftWgt7NBJ58wZcdfwbQKfZ90I7/MkIrqnTKJEfOZ2QP8AHJbneXjksdfp21P82uIIo6GMHn1AFGkXCndTCsyjtPNrG4k6iBeArb0Dy2A831Fy7Re6Dv3/i8MdwZrccJkwadHSHevWmT3qRUQudWLRgObYv8u2N/Vm7odu5oPVruzeCN6zg1ZVJaKwRycaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ywWvws8ot6oKonO5aOxHBTAlL/1/d9hg9WHQ2Mz4piOfzZ9Nnkb0JmfRTb5Q2oKqSprJsC3RLBZnxtaeG9UaDdVzQ1PjnsB9IoAldp7yTqasz0pWszaklLA6BE0sYNpUVjaPxCljwJ7yyr38e5go/ir3+ib2MZYF20BWJKGblVOito4IRj4b1bFIkTYEEseeknU1RW/sgpj/Fb6n6Y6lmCnSl7hgj3fnqmP5MK/oC27KvFpLBNNO6DP+tMXqBtxGoICq6F6fdJPpMvoGapyLkWhdgNnYvGNLtdxEZOqT0vtrxkgFhYqqmb+5eD2bHRs7mxhJJgixjGNioL0YYie2/zRMCZzDpte031XZudUl8UNgbfxrCPp1M6Tl1lUhV6VbMYXrghatNrOdmAq6m4PzjSRTuOZMFXTlZRfdvx9H0maNeXAWxy6yIc7PnbJ8RnLP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:42.3933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 449ec85b-96a2-4a55-4d67-08defd6674fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105
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

Add a KUnit test driving amdgpu_dm_connector_mode_valid() through the
EDID-management branch for a forced-on connector.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 23b83bbde73fd..fc16d3a35b653 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -6321,6 +6321,30 @@ static void dm_test_mode_valid_force_on_no_stream(struct kunit *test)
 			MODE_ERROR);
 }
 
+/**
+ * dm_test_mode_valid_edid_mgmt_forced - Test the forced-connector EDID refresh
+ * @test: The KUnit test context
+ *
+ * A forced connector with no emulated sink runs the one-time EDID mgmt refresh
+ * before validating; with no readable EDID no dc_sink appears and a non-on
+ * force still bails to MODE_ERROR.
+ */
+static void dm_test_mode_valid_edid_mgmt_forced(struct kunit *test)
+{
+	struct dm_test_edid_ctx *ctx =
+		dm_test_edid_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct drm_display_mode *mode;
+
+	ctx->link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+
+	mode = kunit_kzalloc(test, sizeof(*mode), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_connector_mode_valid(&ctx->aconnector->base, mode),
+			MODE_ERROR);
+}
+
 /**
  * dm_test_update_after_detect_mst_noop - Test MST connectors are left to drm_mst
  * @test: The KUnit test context
@@ -7178,6 +7202,7 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_mode_valid_dblscan_rejected),
 	KUNIT_CASE(dm_test_mode_valid_no_dc_sink),
 	KUNIT_CASE(dm_test_mode_valid_force_on_no_stream),
+	KUNIT_CASE(dm_test_mode_valid_edid_mgmt_forced),
 	/* amdgpu_dm_hdmi_cec_set_edid */
 	KUNIT_CASE(dm_test_hdmi_cec_set_edid_no_notifier),
 	/* amdgpu_dm_s3_handle_hdmi_cec */
-- 
2.43.0

