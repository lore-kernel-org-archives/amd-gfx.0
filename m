Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24476C982D3
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B7F10ED1C;
	Wed, 16 Sep 2026 17:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="meDBfTTn";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C6610ECDE
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lafw7UpQGUFwtqvE/f1hgkFD5eqATIBMS/bvfu0xTB2bSRL978CbaHguz5hHaHRERzxI/b707I33DOm0tlTFrZ2dc3EpGiJxWHeyPQnee9SgheMzjEzA8TjHDMQ4/YZ47utwmTjO+jnhDvQeWF+UJ5kiUMdd31mSnb+J8Ueq/HSNOSbFZdAWceyABMcbi7eMW3Sg+dNV/TKW7jat91P+0lnk7MeaIc4npVCZF/7Jk1KvCaLS/h4xLNkF7/jYkujPQazh5HsfEy5Qfge5sisArDInEEueypFzCa5GGICJE2pQKDYzaquvCpzsGyVcwOz7t2m7ehm40araGOjhFoyZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i84T1lzo94EWkDDdJGVZ/6hbJ0He2R9bnFQWDO2DJUI=;
 b=HV/HnWeVFt8A9Yz/IcLf3cG/mWfg07fG1H4T3u7KPgWAsHR1pG5+0MT7nS5GwI0MFsO341lBGCc0plgqmqKscvPWF/IX0c64uZbMBrcpgjTMmHznit68+Mv+M02L3gnqzAuzL1oMgvE4GiQssfPFu6wIRI88DaFMXiKfKhxfNq7H5taN7HsOniEtHWj8hULXiArL99ck+eJBlCpH2QOFowFnY1Bo2DP0JR2LMDQEJsezcgu8IYloz695sl0z8ZR4j9vAThUo4L3ILua62m/Uyea1e+li0fxmfbT/b1hXH55H0JLq9P2leHxLvfI4hsQGXLpB62gmtc/Z9TVv3frhgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i84T1lzo94EWkDDdJGVZ/6hbJ0He2R9bnFQWDO2DJUI=;
 b=meDBfTTnYJJVsGkPqHH4s2C2L/dKmVG66P2hc6BCTnK1zEdfYijxZ1AEDLbRnGkXtL0C9lIlbHkMFfxj0qp34pAYQPQxZhbODATcddxeT2umDubWCDab1EQPB9/0EOMEjUrq/9YKi2LjpqWwLc0dVH5OzUqzacoe9/WsnpJImKk=
Received: from CH5P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::25)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 17:53:06 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::95) by CH5P220CA0018.outlook.office365.com
 (2603:10b6:610:1ef::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:05 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:54 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 52/64] drm/amd/display: Restore FreeSync VCP code check for
 HDMI/PCON sinks
Date: Wed, 16 Sep 2026 13:52:07 -0400
Message-ID: <20260916175301.368306-53-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a621bb-c197-4ce0-e7ac-08df141b5c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|3023799007|6133799003|22082099003|56012099006|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: cbFOrutG59+fDpYnUZEDQdofrRz6SCXzr4oikLoJ7c6yLaXvONr5DX8gmO1z1HzT0XfJQyTnIV8j/6C4qpOIQdp47aEjC7rZJZQdmdZ3AYr4Io739xs/cstQwIBrJ2EmYo+tYelMbGfiiXSDpNnEjc3sDdZA/mum9kl1f6GcUcP1W9U8EPLmH/+Wj66sW1Yxx3sQfLQkhcK+64EnCr2mYbpuJArhoqVCzFOU7ptMrmEuzLA/89UI7i9zdDpOo0WqkakdqJuRCQBDOBraEOM3M2CX1LSmJ8wrXcGNwWqFgmpekgEiA1S8txUW6QXHKthS64SxylhijTcILXPmq16liHPNISi/O262xsJvd0OrO9dwh1wBkcStYn8UnxzQzUkqc2+qqX+PjqSg0R31kKNm4IZ1tK0wJb+BXjRnFVDNs7/0GD1JzIp+c2T5vlD+OdQkqy68D2KvUizV9oa64CXefvwk+Vxo2F/9ef6Gj6KILycQtK2udSmaCKuH7T1Ho0LenGisxSvZ96zGpB3fktYihXrpsvnCpIybaSqWe/ZXKvKSMNOfue6Gzm6rXkxKDQJrI9A98k74eJp+9RmAIwOZuMbHtNmSdkWoU52g9X7E7h1KCuT8yFWF5oXMYL0kuLU9l7gyqreUe0elye/ZM7MELEidRz5i8rOgHkM8ANmxNMtNBXN/bNiFz9i/h3/RhqZfGT6tHmoxTlJEMvUuyGw10g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(3023799007)(6133799003)(22082099003)(56012099006)(5023799004)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EJbEjqKg6bwiBH1AmAH48ZLOQVyRVpNwqL3+PiLPu8Swme2hS0W1kQcNkJpyClRDIK21ndyUiyCWrKZpg2CxC9PulfgFM/xNoiVF5VuRmk2b/w2uorEvQrYuKpFdyWM6MXK5omHk1st+jicOB0XTUJARKguD3SpMATL8QtdlDwS+Ewg56GrRBkkwb5HMgVmX89TWvKXck66j7aR2TwpACVtYH53IuaYvSoVHNxyw0oLz5BMWz/pzuDap8FZYVSj1pDNGMZUm8FOoobE/0rFuT2M/DXk825JWpm9p2QSKpIiByzJ4M+fUsmPzN0pJSI0cwFSjNbPYv5WX75AGck7SoPe3SmdCV5y9Dj2hDMIT8iPBVakeKlUicGsE2D0DqGQfBEhnvvIijFyn5nHl29+pNlj5/9vHSmF5+OtgexkLIj69u3bvVvv1ycx1/mx5s28A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:05.9941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a621bb-c197-4ce0-e7ac-08df141b5c9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
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

[WHAT]
Folding the MCCS FreeSync checks into the do_mccs block dropped the
other half of the original condition: the check that clears
freesync_capable for HDMI or PCON-in-whitelist sinks that expose no
EDID FreeSync VCP code. That check does not depend on the MCCS caps
and must run regardless of do_mccs.

As a result, when do_mccs is false such a sink without a FreeSync VCP
code is still reported as FreeSync-capable.

[HOW]
Restore the VCP code check outside the do_mccs block so it is
evaluated whether or not MCCS caps were read.

Fixes: ("drm/amd/display: Consult MCCS FreeSync cap only if requested & supported")
Reviewed-by: Roman Li <roman.li@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c  | 6 ++++++
 .../display/amdgpu_dm/tests/amdgpu_dm_connector_test.c   | 9 ++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index bcf0ed4fa589..7ebf7216b499 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3987,6 +3987,12 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 			amdgpu_dm_connector->min_vfreq;
 	}
 
+	/* HDMI/PCON without an EDID FreeSync VCP code is not FreeSync-capable. */
+	if ((sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+	     as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) &&
+	    !sink->edid_caps.freesync_vcp_code)
+		freesync_capable = false;
+
 	/* Handle MCCS */
 	if (do_mccs) {
 		dm_helpers_read_mccs_caps(adev->dm.dc->ctx, amdgpu_dm_connector->dc_link, sink);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index ff22e79e7c92..0f7cf32373d3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -9783,6 +9783,8 @@ static void dm_test_fs_caps_edp_replay_mode(struct kunit *test)
  *
  * On HDMI the CEA extension is handed to the DMCU parser, whose reported
  * 24-60Hz range is copied to the connector and published as the monitor range.
+ * The DMCU does not report an EDID FreeSync VCP code, so the connector is not
+ * marked FreeSync-capable.
  */
 static void dm_test_fs_caps_hdmi_vsdb(struct kunit *test)
 {
@@ -9800,7 +9802,7 @@ static void dm_test_fs_caps_hdmi_vsdb(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ctx->aconnector->max_vfreq, 60);
 	KUNIT_EXPECT_EQ(test, connector->display_info.monitor_range.min_vfreq, 24);
 	KUNIT_EXPECT_EQ(test, connector->display_info.monitor_range.max_vfreq, 60);
-	KUNIT_EXPECT_TRUE(test, dm_test_fs_caps_capable(ctx));
+	KUNIT_EXPECT_FALSE(test, dm_test_fs_caps_capable(ctx));
 }
 
 /**
@@ -9827,7 +9829,8 @@ static void dm_test_fs_caps_hdmi_no_vsdb(struct kunit *test)
  * @test: The KUnit test context
  *
  * A whitelisted protocol converter re-parses the AMD VSDB, enables SDP v1.3
- * packing and adopts the converter adaptive sync type.
+ * packing and adopts the converter adaptive sync type. Without an EDID
+ * FreeSync VCP code, the connector is not marked FreeSync-capable.
  */
 static void dm_test_fs_caps_pcon_whitelist(struct kunit *test)
 {
@@ -9850,7 +9853,7 @@ static void dm_test_fs_caps_pcon_whitelist(struct kunit *test)
 			(int)FREESYNC_TYPE_PCON_IN_WHITELIST);
 	KUNIT_EXPECT_EQ(test, ctx->aconnector->min_vfreq, 24);
 	KUNIT_EXPECT_EQ(test, ctx->aconnector->max_vfreq, 60);
-	KUNIT_EXPECT_TRUE(test, dm_test_fs_caps_capable(ctx));
+	KUNIT_EXPECT_FALSE(test, dm_test_fs_caps_capable(ctx));
 }
 
 /**
-- 
2.55.0

