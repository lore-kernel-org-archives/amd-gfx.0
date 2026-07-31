Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B257AC55173
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 345A010F40B;
	Fri, 31 Jul 2026 21:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vRs1P+gU";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9BCD10F40F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crlUGcoYy9Sm5JBADjgNv6f7uXZnsBtcrDad6UIzgggKlja0Z2qjlASg8hX+JrZUctg3LzTckO1OBQN5DppRFvGNxyaAkzndqaHcIsomviZE5SEe98EMtjy4GWip6DGr8U8WN/J1bNJkfEkCBGj/+jNSRElHaW+ZEWzD8tna/ICMsIGxTt+id9qqy3ZDg5A/r8Hk87R3rO+2CB1sFwtZOAZlfS7TzHbL77elAtWYW/jdH9gYoA+Y6IAnF3UQ49eoi9CehUXnZlBSckLhda6fz6JQq7oQtGDTbEhEIma1/dE21dz+sfynWXH2jpddyGtlSA0bdhtjehNMb9bpUDoKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2Mmby34rDxvYQuJFhwwyxz2X9St3TJpzaEu1DnmWRI=;
 b=bLYEDKjnGGsbvul/xv/P0xVuLGiZHQ6dl/vdAnXa/5+4z638Nz8OumdOiSaA5Ttyc50vUR0sAKtJqAyFZ3OoOz5Hjw8MH0F8TbGRhN8iNbHAadSDl600bJY0RcSlvSxM6NPOQ+f9E3JsRwrE+Kvnn2cDgg7FquX8FvuPX/Aj/flZINr5YfeQpTDemHqnUYe8HjdsFV4PcafR7BrDzVlbbTua8OHqoVvYRepajXY7Wqu7hFpQ2bmJYFbEA7YBXe+sqf+lta09pXM3GrS+dr6Zg9MMsqqH8lJTqpRyV7lAhxstjRMqjhMcumFO/Nveyydw1AcPyZ47lB61HEFO2QD8QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2Mmby34rDxvYQuJFhwwyxz2X9St3TJpzaEu1DnmWRI=;
 b=vRs1P+gUdYBVzUMoHq13maUM7MzKb8En3NAd9Ka0b5GFNtgsiZBqgw+ZFpDWHIp9EpOnWaDf8pZC61lafBA9urpIm1OodCK/oJEWgn2VD5HUc0/5DdCKuAWMmmdvtzNatZ8ZM2JDSPzHLBCwZr1q7W8345putckUq6BWOZZbNpA=
Received: from CH0PR07CA0013.namprd07.prod.outlook.com (2603:10b6:610:32::18)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.16; Fri, 31 Jul 2026 21:15:47 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::60) by CH0PR07CA0013.outlook.office365.com
 (2603:10b6:610:32::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:46 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:46 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:45 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 18/41] drm/amd/display: Add KUnit test for crtc vblank event
 completion
Date: Fri, 31 Jul 2026 17:12:39 -0400
Message-ID: <20260731211302.3040343-19-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DM4PR12MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: 65710769-cade-4402-de36-08deef48e3ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UPe85BUs5Z8Wo/Jyoj4SzkvKpLO1XcYOO1xr62lNFAJQ9XnaGL5uoHDa04KvRhQ0ozQUfxVUTW6HtWUMQxzZ6TEgEO3Xyj0b5ghzWAIgE/VeA6cF6U4Ary+H7UOKGs3eOIALQKpqM91o29/6pdpC2DtHbIIIeZotD3s41nmEdxrfdNt47385QJFDQT6kyzbOlWT8c8w7c5BIp/RVjyXcXiqXDq/q081yLbg7UUkbPQo0+N9j/lcOp4zo8FxTasAcqUVrTs1C3Y5NkcGbeOJ/3xHPamf/Rj4sPKlADNVh2KRwbzIANHFPpp35ggyvqZr+Li6waZnJrV0NV0hBRUzTIItOEPvbTsQ1SJnuMHGnyVy07xYRnxlZGwiIRBRUtca8n4MzNz9NMZt9MrHeNoZC/zMUVwAXp+hUoMJyydHFk3KgICnEBKG6gJ4a91I6wsBvTqscuQIavVs0TKafGAcLQpvIk+MbKoJNzWT4X7aH1U3mJzBtfNryPUKRjRBjwp6nIXGkyEJFjOJiyz79MNYMpFn/Ja37QO7M3OOA+M4c7gpT6oPGlkNKjvU9rmRN+eCynmaSV2AKC9LKgmcPa0x3GtKCKhBK8Kf0TFXzWZY2Y2ehOnNuzWUom3+zNLm1Dsx226wkrg1wZtfwZVMF0fVUfOQeAuT0siE3NaURjkqnr8XVKZ87bVuMpKk7M6L8lwiaGNfzHWgYQQWCEVBm11AbRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gfxHQZSNr+4Bk2aE/8Jq/hAzjBqFHtxu27kUTR8MauU8cwt7v0lc5iiZdScfv5sNk0ScXFs7XUnZU+g/qyAIa7lTOJM3iXaEd+YkmzEgZf6D+QD4OZltMuk7LPnkUZB3fh//B3qxcDCqh/NoIAzCXYdDiQZLVJHRf5yZSPTCMjKkQuW00rD2mKRoC3gkRKc51REqe2rRB42XH6NnHWGf6IktPphrMR1BcnHrZZqn5+cj91U97E3s7+1BzC0LKmVWm8ctjOFtjOmtJNc0x3vvCX4jOguA4PzsS8cpcMZDkAMoH68++q8c4SHpLMZ5+/tH2C1V099w/q3sWAytA+Bj+rzcINCkqctgYeZyjs+YKFYS5I8hVLfwf+M6wSetKwfSW5hgOsruRK2jbnzpyIW2Q7VU+vNMunyM+meieWFZbMRos56PY1gSVkLPFwHu9/vp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:46.9220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65710769-cade-4402-de36-08deef48e3ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012
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

Add dm_test_crtc_handle_vblank_completes_cursor_only to cover the
previously untested branch in amdgpu_dm_crtc_handle_vblank() where a
pending event with pflip_status != AMDGPU_FLIP_SUBMITTED (a cursor-only
commit) is signalled: the vblank event is sent, the vblank reference is
dropped, and acrtc->event is cleared.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 9948d1780454..6bc4f932c839 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -971,6 +971,50 @@ static void dm_test_crtc_handle_vblank_skips_when_flip_submitted(struct kunit *t
 	KUNIT_EXPECT_PTR_EQ(test, acrtc->event, event);
 }
 
+/**
+ * dm_test_crtc_handle_vblank_completes_cursor_only - Test event sent on vblank
+ * @test: The KUnit test context
+ *
+ * A pending event whose flip is not AMDGPU_FLIP_SUBMITTED (a cursor-only commit)
+ * must be signalled on vblank: the vblank event is sent, the vblank reference is
+ * dropped and acrtc->event is cleared.
+ */
+static void dm_test_crtc_handle_vblank_completes_cursor_only(struct kunit *test)
+{
+	struct drm_pending_vblank_event *event;
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&adev->ddev, 1), 0);
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	/* drm_crtc_send_vblank_event() consumes (kfree()s) the event. */
+	event = kzalloc_obj(*event, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	acrtc->base.dev = &adev->ddev;
+	acrtc->event = event;
+	acrtc->pflip_status = AMDGPU_FLIP_NONE;
+
+	/*
+	 * Take a vblank reference so the handler's drm_crtc_vblank_put() does not
+	 * underflow. Mark vblank enabled so the get succeeds without a hardware
+	 * enable hook.
+	 */
+	adev->ddev.vblank[0].enabled = true;
+	KUNIT_ASSERT_EQ(test, drm_crtc_vblank_get(&acrtc->base), 0);
+
+	amdgpu_dm_crtc_handle_vblank(acrtc);
+
+	/* Cursor-only commit: event was signalled and cleared. */
+	KUNIT_EXPECT_NULL(test, acrtc->event);
+}
+
 /**
  * dm_test_vblank_control_worker_setup - Build a vblank_control_work for the worker
  * @test: The KUnit test context
@@ -1168,6 +1212,7 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	/* amdgpu_dm_crtc_handle_vblank */
 	KUNIT_CASE(dm_test_crtc_handle_vblank_no_event),
 	KUNIT_CASE(dm_test_crtc_handle_vblank_skips_when_flip_submitted),
+	KUNIT_CASE(dm_test_crtc_handle_vblank_completes_cursor_only),
 	/* amdgpu_dm_crtc_vblank_control_worker */
 	KUNIT_CASE(dm_test_vblank_control_worker_enable_increments),
 	KUNIT_CASE(dm_test_vblank_control_worker_disable_decrements),
-- 
2.34.1

