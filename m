Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0607FC56203
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 986F310ED13;
	Wed,  5 Aug 2026 06:41:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D9aRT9n6";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F24010ED14
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:41:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruMWiOkjJb848ckRVf06XBAAbjl/iKir0MoZJHUClhKVcsD+xYmFjTWQTPWT5U1Rjxv+uVtp+o6E2gPIXUxQsHVXULRfOTVK/mmKRtR/Z9Ed8wGGk5HHYKpsuUCKzytZJs8jAmvtMSMVm0fuByeb5vWKLx7PlWaeMJrQ4jeeADnfI0IBUwhUZTm4iZzgYOMtve/fMPAdFrfM0zr7jyiZFUqI9SwYwB68gE6TG1oZqFCvk94oM+P5dGxjdjopOrge3yDtPlfuYzgl6UF25gN835XlrEypXlWhGqERmI7ZN2liHey6igVFojVDIssxBgLWtIqNAELbSzHbMRVtDexETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfXaaGiNXrxFzCejZIz79VGKgNvEpPiFWb+Wbu/SY4A=;
 b=CtV8YwM4vqGbuRu1EAYB/VfeiCoHFuHg4lGc1MvSeNz88nprxXhj7Rnv4HZKDPo7r2PMJwrHyfEc5y7XkxW/KQ7uC55SB2V/MOpmFN2vL3aimXAp1HOhyk7W2sOqJXGLzkVLnlLXm/xA+2eq0IcwJ9iJDVcn9MewOJD6XzZWBAdsnrqQjYnaREQmwV972cIYw4EHVLEqxIrY2CSjZySoQD7vcqCT9JPljJr8/MxYi3LtZ9QffO0p7DRa3NzafQjYfX0Q/vgz3yqyDJJ8XOkQE9Gz2WFbi1+UzDh8ICbxB3YqyV5+Svz3vgl5POkDL4yweAWZtUdqpILwq1jWqLoh9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfXaaGiNXrxFzCejZIz79VGKgNvEpPiFWb+Wbu/SY4A=;
 b=D9aRT9n6JBYXS2BjctPcu8R6lrqn6xF2/dST51aVp1c7uGm0JUO5NYEWyIWWmDxidFxPiiY1tlewlLPDCYJgCohle1n6isERSbAhvt+P2WycpYz6RHtj/rhkK6Uo5TqKTa+z96c/bv1vW5423qHHQYUhNc2H1AqchgAKss601aI=
Received: from SJ0PR13CA0095.namprd13.prod.outlook.com (2603:10b6:a03:2c5::10)
 by DS7PR12MB6047.namprd12.prod.outlook.com (2603:10b6:8:84::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 06:41:45 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::1c) by SJ0PR13CA0095.outlook.office365.com
 (2603:10b6:a03:2c5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6 via Frontend Transport; Wed, 5
 Aug 2026 06:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:41:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:35 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:41:32 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 26/34] drm/amd/display: Force FreeSync range minimum on quirky
 panels
Date: Wed, 5 Aug 2026 14:36:38 +0800
Message-ID: <20260805063937.2145774-27-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|DS7PR12MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 308897b9-5ea2-43fa-a079-08def2bc9df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|5023799004|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UliMntzWTID+cGwhLzlEu65GrrO72u5yf2Iq/vYMJT6HXlFQeGZPO6TokQ1UgNFhXaVOxycHoLymLgsIn6e7ynB4PK2/0Lt+5Ruu3GjDnfSm6O7wJzcb3yPwuhQaW/UHX9u9UfoR0OQQlmcYHhPkwvoX6fJ6wm9Fi4pVAv/4BRunFwKJtstjpmDHknMOEgw8S6atIjwx3i16OZi/KbQtUn5ths1Um2hXMHqPHuwJhIwU85QkbeMBrHPrPGKaTFAOds31VfLHnYth5NIbLCNaO3KT9ek7e9rqBHnFrL2YIwpX/Ijs/PRG0uoNkKvUgPO3fKo2Npg8AKAQN7eltLWL4DEG2aGJ4N20N+tu8hMYSDDo6mlYJwQsNd0rYAsW0h0HrWmAipLBu7PeMz7mIYBP9Q7iuuPsESvW6tZIgifj2Xd4m+AY0OJlMmH2XEnd5HyNDRfBRxko9bniyx1EbEq3tCOtdrJg4qFX8Ph4Ql7w6rDY02stTpQxD5YjhibweJFuMAmNnc1LFZNM6YTxA3WXzplwjIuOxWCOVLK0RFvw3t3k7ulfKqZ0rvz3BGOPctL0sK5pW/m/A1OY6Mvt4ba77mpMpnNgzWeXVFTwj1RrogUJ7A3PWV6d3TiarReBkq8MTetuajk7oRltG4IodvFPzwOQ5GN9M4NW0yXZMUXHp5Dr42UTXAqhc3JVPzvObpJkLpHUrklfAaU5AY+8OiBxQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(5023799004)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vqQGMWLybHUrd8UBNN5MjIGcVCLpf7ZzKfIshzbRPxlBneyahClwfU9AaBYYYVp3+o6tjReGpTxhB5Pf/0Ea99fXaxsmXWpf6yQQe822UQsY8CiKkdkmow66jZvGxeQXDRK6q+KVAiYPj9t0+IOrzZbN7waQztFATKoTJlXgWlTfIKPV8YWfbEDodsmIzZMFrsZYm4pQ5dyDGG/rvH8u0XOmN8p7lebTeo8mhswDkEtB1OZD0b1zIDMINFX3pRhPaH8o2cL9J4LotsMgmGSN3t7jVqFi7zydYtbmvQ1mCwxYeB9GC4TpF9n+qL7ABTLdJhdjv4f8t/GRq1BggngClnwOMl9BOAo5tRQkGvkH1p9RZDLrVKSTo+tHZEn+58DsuvoKTMqs8jtaxwugNQB6r7MO+hmeyKnUf/EHN2rTqF/aLa2FjDsuCBNKFo17DdrO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:41:45.0046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 308897b9-5ea2-43fa-a079-08def2bc9df2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6047
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

From: Fangzhi Zuo <jerry.zuo@amd.com>

[why]
Some panels advertise a FreeSync range minimum that does not operate
reliably at the low end:
- X34GS (EDID panel id ACR 0x08AF) reports a minimum that
  can flicker or drop out when the refresh rate approaches the reported
  minimum.
- 34w-30 (EDID panel id LEN 0x66F1) reports a 48 Hz minimum over
  DisplayPort, but the panel fails to light up at that minimum, resulting
  in a black screen. Forcing the minimum to 60 Hz avoids the black screen
  and lets the display light up normally.

[how]
- Add a force_freesync_min_hz field to struct dc_panel_patch.
- Add apply_edid_quirks() cases keyed on the affected panel ids that set
  force_freesync_min_hz (55 Hz for the X34GS, 60 Hz for the G34w-30).
- In amdgpu_dm_update_freesync_caps(), when the quirk is set and the sink
  is otherwise FreeSync capable, clamp the reported VRR range minimum
  (min_vfreq and monitor_range.min_vfreq) to the quirked value.
- Add a KUnit test covering the new quirk.

Reviewed-by: George Zhang <george.zhang@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c    | 12 ++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 18 ++++++++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c   | 17 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_types.h      |  1 +
 4 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 4304520d2484..2cc3734c992b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3880,6 +3880,18 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		}
 	}
 
+	/*
+	 * Apply per-monitor FreeSync range quirks. Some panels report a
+	 * VRR minimum that does not operate reliably; force it when the
+	 * monitor is quirked (see apply_edid_quirks()).
+	 */
+	if (sink->edid_caps.panel_patch.force_freesync_min_hz && freesync_capable) {
+		amdgpu_dm_connector->min_vfreq =
+			sink->edid_caps.panel_patch.force_freesync_min_hz;
+		connector->display_info.monitor_range.min_vfreq =
+			amdgpu_dm_connector->min_vfreq;
+	}
+
 	/* Handle MCCS */
 	if (do_mccs)
 		dm_helpers_read_mccs_caps(adev->dm.dc->ctx, amdgpu_dm_connector->dc_link, sink);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index d451082552e8..b05455498cbf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -147,6 +147,24 @@ STATIC_IFN_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
 		drm_dbg_driver(dev, "Hiding secondary tile on panel id %X\n", panel_id);
 		edid_caps->panel_patch.disable_second_tile = true;
 		break;
+	/*
+	 * Workaround for the Acer Predator X34GS which reports a FreeSync
+	 * minimum refresh rate that does not operate reliably. Force the
+	 * FreeSync range minimum to 55 Hz.
+	 */
+	case drm_edid_encode_panel_id('A', 'C', 'R', 0x08AF):
+		drm_dbg_driver(dev, "Force FreeSync min to 55 Hz on panel id %X\n", panel_id);
+		edid_caps->panel_patch.force_freesync_min_hz = 55;
+		break;
+	/*
+	 * Workaround for the Lenovo G34w-30 which reports a FreeSync
+	 * minimum refresh rate (48 Hz) that fails to light up over DP.
+	 * Force the FreeSync range minimum to 60 Hz.
+	 */
+	case drm_edid_encode_panel_id('L', 'E', 'N', 0x66F1):
+		drm_dbg_driver(dev, "Force FreeSync min to 60 Hz on panel id %X\n", panel_id);
+		edid_caps->panel_patch.force_freesync_min_hz = 60;
+		break;
 	default:
 		return;
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index 058e1ad15dfe..5de697ca0fcc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -186,6 +186,22 @@ static void dm_test_apply_edid_quirks_skip_phy_ssc(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, link->wa_flags.skip_phy_ssc_reduction);
 }
 
+/**
+ * dm_test_apply_edid_quirks_force_freesync_min - Test ACR 0x08AF FreeSync min quirk
+ * @test: The KUnit test context
+ */
+static void dm_test_apply_edid_quirks_force_freesync_min(struct kunit *test)
+{
+	struct dc_edid_caps edid_caps = {0};
+	struct dc_link *link = dm_test_quirk_link(test);
+	struct edid *edid = dm_test_edid_with_panel_id(test,
+			drm_edid_encode_panel_id('A', 'C', 'R', 0x08AF));
+
+	apply_edid_quirks(link, edid, &edid_caps);
+
+	KUNIT_EXPECT_EQ(test, edid_caps.panel_patch.force_freesync_min_hz, 55U);
+}
+
 /**
  * dm_test_apply_edid_quirks_unknown_noop - Test unknown panel id is a no-op
  * @test: The KUnit test context
@@ -3724,6 +3740,7 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_apply_edid_quirks_remove_sink_ext_caps),
 	KUNIT_CASE(dm_test_apply_edid_quirks_disable_colorimetry),
 	KUNIT_CASE(dm_test_apply_edid_quirks_skip_phy_ssc),
+	KUNIT_CASE(dm_test_apply_edid_quirks_force_freesync_min),
 	KUNIT_CASE(dm_test_apply_edid_quirks_unknown_noop),
 	/* dm_helpers_parse_edid_caps */
 	KUNIT_CASE(dm_test_parse_edid_caps_null_edid),
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 7da673111ed9..64b4adee36c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -194,6 +194,7 @@ struct dc_panel_patch {
 	bool oled_optimize_display_on;
 	unsigned int force_mst_blocked_discovery;
 	unsigned int wait_after_dpcd_poweroff_ms;
+	unsigned int force_freesync_min_hz;
 };
 
 /**
-- 
2.43.0

