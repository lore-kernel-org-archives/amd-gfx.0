Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0202C5DF95
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAACF10ECBE;
	Tue, 18 Aug 2026 20:22:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ok+p3CbI";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010011.outbound.protection.outlook.com
 [52.101.193.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 236AD10EC9C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ia5ewJwq/evimki5gpL78gh01roSzeNJOP/RJOWQz99r0mhHZdhz0wKFBHds1ikyrTlphYefaNxKwxlFvBtTObs9Dd+aoXMCv61ei63ruL1YtEugLGFk4il7GqG25RbVDVg5UoRToeMT/cGuuxje8OHTEOkwG82ockaANmkV+2mZ07cNHEi3tfGt6wOSz0XVOa2lP+CWOsoTibne/wCRjhPmscZfKDM+PAI00J6jdnjIX7YtPJi5YGFNUGklqT3wgFm2shWmj7Dw5IjRadIl25bZVoZN/teAxJdc6Y0GpY56hf7X39XAzhj7OPXjh2k1OozXeDogr6uEskb/dD3WDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCyzSz7CSX9fOcA19/nx+A6KEvA07gykivxBDoPy4Jg=;
 b=cZOcyT4nRzMYIWDfp5DKix2C8YfehqHnnUd0/8eQ1Fc/VuZiur+fBJEWQk1nddffN+feIGqz5MehUAilb/RFMMbBOTv54gEZ0hi142tEvSV8qf/cpaHfxA9PK2VMhgU3sntcvV+fmWky8Zc7oAJgmwTKbX6QxtqOhqheXDswX33N6kgagX5hgPqfokCIeq2Uraw90x+OZnIy3EhN7BIgtr4f+jixJBBuUcv1dMc+H6jhQ8ox0qD8Sfrgi1POZ1Kis7/9A5iWMvvJkzbSwR56d6JH35UazCX/YpgKrKHqCLpEWbI+h31+bmcca3PlBpk/5YIcyxGOlVf9iXOQJDIF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCyzSz7CSX9fOcA19/nx+A6KEvA07gykivxBDoPy4Jg=;
 b=ok+p3CbI/TpZTZOC6WeSrusWUZuqU6yFJ3XMDKa9M1nIiyi11XHIB6EUgUzrZ+PJ4ZxPqgmC7x6xD08JO07wEEBEDEaDXnawnl6oMROicgB0sbxiBPE2W1T75FCK13ZZGDuPJbju2NnmfwdrSEkpWscTJdMCXwBBZI7hp+lZu0Q=
Received: from CH5P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::20)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:31 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:610:1ee:cafe::82) by CH5P222CA0019.outlook.office365.com
 (2603:10b6:610:1ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:23 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:22 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 41/82] drm/amd/display: Test dm_dp_mst_detect DPCD probe and
 unplug
Date: Tue, 18 Aug 2026 16:15:33 -0400
Message-ID: <20260818202139.4172592-42-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f186433-0336-4756-a00b-08defd666e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|6133799003|3023799007|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: dayGgFk2Hep4O5Zq4JH9C1FFQmD+WQnRxGqo9VhyPXz8IrLJWfl72HIoxL4y70fUARgBNdXEN5nK0LA7YKSePA6CWcpxIdJdmGHWpxlsGRVcYMcoJH3vRm0Nc17JFAqwt7UyIsD9cLr11F6nvxHblVtaBvGbVGQVE8AjmRcuhpoFazyGoYBGzYgdHfvbvjTXKxHTdeFDmZgJztlp+SRjNo4ASJoZh5/pgrRb2RpCzdPqyPmx147KUC1So3M9OuPBcO0390CZ5R+56vz3V8fmuAPz4NwkgRQ4iZyHa7/JuhcTr0rJWL2Kt7zb2EM6leelg29iDy6D9RB2kzp/osunt9bt/GHes1UUvgBhyKfNg3sZbw/Yaq7FssLMrGsciBkpUJ7lSB/1QQA7OLM2eWbNw+mnqnLoxJeWkkNcqeRQ9cxb1DclROJOT+h1Q7jJYMtqa/sJFT7E6KxY5CRYsKeWwn8oOhFgHDmiG3B5gW+QzxpML8i3fRl0IyDEzC/bk6ixQAzlkWLZ7WPsAOZx+hdB86QWiALVIVfj7CZoPzmvMdygBhnFc4dDW8MxrNMqpU9OwaKNoATor/SGZbwgekKf/ZCurxJCD4dcBhi5IbCByQf5D2TS3cxI1s2YhBpjeyinDl6AYc7+heGaK7ObxlZyH3s6qmzwgHjwi/IjDrh8xQ6pT4ju8naAhFP+a2KdMk7mY0FFsNv9i7BaEb1STfIxqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bzxGE4MEJSskKTPNOAVNParrQvTAftmOfstlDVT6Uo9FwBYv1SFwj+7A6SLlmG0o10bOUQa4bNb+LbBgoh/JXywFaDAlQYkWIWMPbsldQQM3RVhs1RclwkN7r9Ga087P008f1uvNWHmogVdYh/G7LRGOhujGRxAEYzf3jVF76lBXaW0raU+NZJJv9Y1M85y+PIeselnx5UApMvyz2bxcW/hNDvwwAhKa/iE65+waAMqimy53UX9w1JypgH8ORhGmU0RJKQnGctueT0ACTVZBDXFb4P+2RnrD/r0d4bD5+m7hWnyGThok8nT7eOElXrPQS2nXvXpfRlGQXGBlXWp+3ZoK5+B5T/w/4FBW7qWg0Xys/LMyTEFC3E0e4rC3SOqfvhEezRr3oDvbU+ekoADws2dWtCAnNBLKqSIJ865L0Mn6KdBGiyB/Osu5WJ5h7qgh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:31.0811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f186433-0336-4756-a00b-08defd666e3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567
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
Add KUnit tests for dm_dp_mst_detect() covering the DPCD revision probe
of a peer device, the fallback when both revision registers read back as
zero, the NAKed remote read that must leave the cached revision alone,
and the unplugged port whose disconnected status releases the remote sink
and resets the MST connector state.

[HOW]
The tests reuse the MST downstream connector fixture. Its empty topology
manager makes drm_dp_mst_detect_port() report a disconnected port, which
is what the unplug path needs, and the port AUX is served by the fake
DPCD store.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_mst_types_test.c          | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index b74f0611dfe06..6c0d5d233dcf1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -1711,6 +1711,113 @@ static void dm_mst_test_get_modes_reads_remote_edid(struct kunit *test)
 	dm_mst_test_fini_child(&child);
 }
 
+/* Tests for dm_dp_mst_detect */
+
+/**
+ * dm_mst_test_detect_reads_port_dpcd_rev - Test DPCD revision probing
+ * @test: KUnit test context
+ *
+ * For a peer device with an unknown DPCD revision, dm_dp_mst_detect() must probe
+ * DP_DP13_DPCD_REV over the port AUX and cache the returned revision.
+ */
+static void dm_mst_test_detect_reads_port_dpcd_rev(struct kunit *test)
+{
+	struct dm_mst_test_child child;
+
+	dm_mst_test_init_child(test, &child);
+	child.port->pdt = DP_PEER_DEVICE_SST_SINK;
+	/* Both DP_DP13_DPCD_REV and DP_DPCD_REV alias to offset 0 in the fake. */
+	dm_mst_test_dpcd[0] = 0x13;
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_detect(&child.aconnector->base, NULL, false),
+			(int)connector_status_disconnected);
+
+	KUNIT_EXPECT_EQ(test, (int)child.port->dpcd_rev, 0x13);
+
+	dm_mst_test_fini_child(&child);
+}
+
+/**
+ * dm_mst_test_detect_unknown_dpcd_rev - Test unreadable DPCD revision
+ * @test: KUnit test context
+ *
+ * When both DPCD revision registers read back as zero, dm_dp_mst_detect() must
+ * leave the cached revision cleared instead of reporting a bogus value.
+ */
+static void dm_mst_test_detect_unknown_dpcd_rev(struct kunit *test)
+{
+	struct dm_mst_test_child child;
+
+	dm_mst_test_init_child(test, &child);
+	child.port->pdt = DP_PEER_DEVICE_SST_SINK;
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_detect(&child.aconnector->base, NULL, false),
+			(int)connector_status_disconnected);
+
+	KUNIT_EXPECT_EQ(test, (int)child.port->dpcd_rev, 0);
+
+	dm_mst_test_fini_child(&child);
+}
+
+/**
+ * dm_mst_test_detect_dpcd_read_error - Test unreachable port DPCD
+ * @test: KUnit test context
+ *
+ * When the remote DPCD read is NAKed, dm_dp_mst_detect() must leave the cached
+ * revision untouched instead of storing a garbage value.
+ */
+static void dm_mst_test_detect_dpcd_read_error(struct kunit *test)
+{
+	struct dm_mst_test_child child;
+
+	dm_mst_test_init_child(test, &child);
+	child.port->pdt = DP_PEER_DEVICE_SST_SINK;
+	dm_mst_test_aux_transfer_override = -EIO;
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_detect(&child.aconnector->base, NULL, false),
+			(int)connector_status_disconnected);
+
+	KUNIT_EXPECT_EQ(test, (int)child.port->dpcd_rev, 0);
+
+	dm_mst_test_fini_child(&child);
+}
+
+/**
+ * dm_mst_test_detect_disconnect_releases_sink - Test unplug sink release
+ * @test: KUnit test context
+ *
+ * A port with no peer device must have its cached DPCD revision cleared, and the
+ * resulting disconnected status must release the remote sink and reset the MST
+ * connector state.
+ */
+static void dm_mst_test_detect_disconnect_releases_sink(struct kunit *test)
+{
+	struct dm_mst_test_child child;
+	struct dc_sink *sink;
+
+	dm_mst_test_init_child(test, &child);
+	child.port->pdt = DP_PEER_DEVICE_NONE;
+	child.port->dpcd_rev = 0x14;
+
+	sink = dm_mst_test_alloc_sink(test);
+	child.aconnector->dc_sink = sink;
+	child.aconnector->dsc_aux = &child.port->aux;
+	child.aconnector->mst_local_bw = 1234;
+	child.link->sink_count = 1;
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_detect(&child.aconnector->base, NULL, false),
+			(int)connector_status_disconnected);
+
+	KUNIT_EXPECT_EQ(test, (int)child.port->dpcd_rev, 0);
+	KUNIT_EXPECT_EQ(test, dm_mst_test_remove_remote_sink_calls, 1U);
+	KUNIT_EXPECT_PTR_EQ(test, dm_mst_test_removed_sink, sink);
+	KUNIT_EXPECT_NULL(test, child.aconnector->dc_sink);
+	KUNIT_EXPECT_NULL(test, child.aconnector->dsc_aux);
+	KUNIT_EXPECT_EQ(test, child.aconnector->mst_local_bw, 0U);
+
+	dm_mst_test_fini_child(&child);
+}
+
 /*
  * Sideband connector with a live topology manager and the DOWN_REP ready bit
  * armed, so dm_handle_mst_sideband_msg_ready_event() reaches its ack path.
@@ -1859,6 +1966,10 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_atomic_check_no_old_crtc),
 	/* dm_dp_mst_detect tests */
 	KUNIT_CASE(dm_mst_test_detect_unregistered),
+	KUNIT_CASE(dm_mst_test_detect_reads_port_dpcd_rev),
+	KUNIT_CASE(dm_mst_test_detect_unknown_dpcd_rev),
+	KUNIT_CASE(dm_mst_test_detect_dpcd_read_error),
+	KUNIT_CASE(dm_mst_test_detect_disconnect_releases_sink),
 	/* dm_dp_mst_get_modes tests */
 	KUNIT_CASE(dm_mst_test_get_modes_no_edid_adds_default_sink),
 	KUNIT_CASE(dm_mst_test_get_modes_no_edid_sink_alloc_fails),
-- 
2.43.0

