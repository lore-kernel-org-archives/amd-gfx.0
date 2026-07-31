Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CDAC55178
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC0D10F40C;
	Fri, 31 Jul 2026 21:16:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EuUdXS7E";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013031.outbound.protection.outlook.com
 [40.93.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE8510F409
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:16:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlhPK10d4OdrK+XLwSwe4u/GPhAcZ6jF6if2jIhRfGbJBe5KH7WXIGOziccQLn85Qj7YFIqJmx2kA3EduUd7aS8WKHq2VhjH344UUFk0QUlwLSN6vSFiWjJS6GihizaChyC1jOqbImL8pt8uw+z34PPk/op/kA/OSyg8MMPfYTICyKnSyZlTUYG1OpVaZ3WR8nJ1iYy9FYGQb6+kdT+YKqLrHjOhcrTdrwpwHIK561BJD76VYsU6f99nZ1NLzo1j1347jEiTlGshgvBwhlprp3gmeNs4Y0n3bt+5ppNP3bxMJKdcx/Dw8VUnWQYKdejCvwnWqm4l20rYdyYuVIPt7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHjr7qY/U0EitxC5ylbbITfpPVk1kvTfYl8i6fap5Ok=;
 b=jTn3eNv3mst3Emj32iAtQxjzomKtKJWJm0Pdx8GHsz5DXspu23dzfZdXuTS3H0WyOkTf43Jq5hYA/T/B97NF+JS5lRhbStrTnhVvM/EqSLz4CK7JdTOYo3PUjTftWX1btwTSUy9soF8EojTmtRFHQNAo9J0kgzNyRX7Lbvw1bMDETwEruInBEufk65CejVDXPeEyU07Z21pMXs2mG843jjnEaMC7jx+zJ7k9aWPHNpu/2BXlfuCch2IwOXQwF3QUHi3QYAaSgMNPQHKJr0hStirH7NSk6gTyaGrpEBGhnL9hBSGZZ7WQAtedu7oH1ZCxGKzYDeXmlaxt5d8aQw4yDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHjr7qY/U0EitxC5ylbbITfpPVk1kvTfYl8i6fap5Ok=;
 b=EuUdXS7EzqY3X8ovm9KWMMqHCXGLnCKlbt+1lChrNs6XzC5eIKyWclUKsUK9ENmkdLwvwuQK4R3v8QGjFolkULuiBu2BYP4+LqAWZLmfd86v5sxAgRNxmBknHjqWFjrQZrqsfK56mQ7VB/tPKJ0+tkkY9vBwwLuf/C+OOPoYWro=
Received: from CH0PR03CA0214.namprd03.prod.outlook.com (2603:10b6:610:e7::9)
 by CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:15:57 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::4) by CH0PR03CA0214.outlook.office365.com
 (2603:10b6:610:e7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:15:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:57 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:56 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 29/41] drm/amd/display: Cover crtc destroy_state stream release
Date: Fri, 31 Jul 2026 17:12:50 -0400
Message-ID: <20260731211302.3040343-30-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|CH8PR12MB9766:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4662ba-0403-42f4-9f77-08deef48e9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wVptUOtEXE/uU7qjzPIY65r1MwqY48VCZKsqVicdj16pqaaRcQMOoPWcWhjLbO3g3jugJSkPSPPmfmcjfeJRJrPVEQpvk0ALymgXYiBhbwLH7IMeEFQ4phGmMSz8M0C9hMQPNdl9Lpre5VPMMKXh/VyLHZc+5zMl7CloQQoMRsplWF8pChvQBAwx3k9vTNEBjCDj76nUO3hGqDV5aGudk5efUyN0QKeCKip2v0RNaQa4yJjMf/lpg3+uxyjIMKcTJ1YyfcVJgOY03gh/+mbk3E+6/Ve66313hTgIoPxVMqmUPgZ/0qpRnfpEyXA6DYLZcPaxylaxD0Im71vCsvDz1x0FUR57Z0JGF3r0ZRn26Df+8aj/cIa96IhJLV0slnbGJYfIA2ctnsD6jsD/KyT27TZ8b8UbTf+SjOMWQUgTRx+l3ZTtIO7uMVL9e+QfsTggBb6+m/DATt7ba6/+gL7W5JGow2H7ZesaZVke9f8Z+5DW1Txe3SInt3OdibSnGNsDZk/+9/odmv21hpnNt6I7kt6h/plzTRFhmKheP8ou/2obf07QXYnKRv9v8BtQytVsRimGARJOl1aOmVk9z7jzTsH2NeOKx22Bo8aTVEWLM0M6/N1FI8ZhckSDQWsKYNH0LMXX9DwRH5zi7CpMEbT5RBybbShN80KS2wEbUWHEoNCuCnWtz0B62qxbxytv2Gre+r3Jpd/JCXa3UnqpXEaLKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U+LjCGvDv9tQ0Nc7It+LwPkwuu4OOgZxeMvZeJQKqMtp1IheU0LrgfquYMuJBdIDYWj+dTaMlpzvFzfoLXqhF5tbElDOLWCWH9ppgUswPY+khONFB+tR0qWRLvbUstnMGStyx6LeimoixiVxIDCR1ZJLI4DEP/4yvNWewRLvzJwcNX0CaYpvYDKQiF5KKaUM3paJe+poosBi9zoGbSQggpBnogQrviJ3Me26r7mdIrFF538CG5MNAx2FETf6fSZgolcVeFHDeZh6rkxoEPk4+euLhFxHMPVMgFXH+nCR9xLCURXFd4pamEFsfQpIuYn7FKE8T1gHE5ocb9QGUM5qk1GIDfnL5Bs7givOiexOwQOQsHTzymLLG5e11Jcz1NKxaKqn9b7YUc11bSp5xVlIKdoRrEYOT0wnHmzqi7llLCXUChEhfkkLIGY4wQUtsciv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:57.4381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4662ba-0403-42f4-9f77-08deef48e9f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9766
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

Add dm_test_crtc_destroy_state_releases_stream to cover the cur->stream
branch of amdgpu_dm_crtc_destroy_state(), complementing the existing
no-stream test.

The test attaches a DC stream to the CRTC state and takes an extra stream
reference so the destroy path drops back to the KUnit-managed reference
instead of freeing the stream, then verifies exactly one reference was
released.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 805c171564c8..4dacddd23878 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -1451,6 +1451,40 @@ static void dm_test_crtc_destroy_state_no_stream(struct kunit *test)
 	amdgpu_dm_crtc_destroy_state(NULL, &dm_state->base);
 }
 
+/**
+ * dm_test_crtc_destroy_state_releases_stream - Test destroy releases the stream
+ * @test: The KUnit test context
+ *
+ * When the CRTC state carries a DC stream, destroying the state must release a
+ * stream reference. An extra reference is taken up front so the release leaves
+ * the KUnit-managed reference intact rather than freeing the stream here.
+ */
+static void dm_test_crtc_destroy_state_releases_stream(struct kunit *test)
+{
+	struct dc_stream_state *stream;
+	struct dm_crtc_state *dm_state;
+	struct dc_link *link;
+
+	link = dm_kunit_alloc_link(test);
+	stream = dm_kunit_alloc_stream(test, link);
+
+	/*
+	 * Take an extra reference so amdgpu_dm_crtc_destroy_state() drops back to
+	 * the KUnit-managed reference instead of freeing the stream.
+	 */
+	kref_get(&stream->refcount);
+
+	/* destroy_state kfree()s the state, so use a plain (unmanaged) alloc. */
+	dm_state = kzalloc_obj(*dm_state, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+	dm_state->stream = stream;
+
+	amdgpu_dm_crtc_destroy_state(NULL, &dm_state->base);
+
+	/* One reference was dropped, leaving the KUnit-managed one. */
+	KUNIT_EXPECT_EQ(test, kref_read(&stream->refcount), 1);
+}
+
 /**
  * dm_test_crtc_handle_vblank_no_event - Test vblank handling with no pending event
  * @test: The KUnit test context
@@ -1877,6 +1911,7 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	KUNIT_CASE(dm_test_crtc_reset_state_allocates_state),
 	/* amdgpu_dm_crtc_destroy_state */
 	KUNIT_CASE(dm_test_crtc_destroy_state_no_stream),
+	KUNIT_CASE(dm_test_crtc_destroy_state_releases_stream),
 	/* amdgpu_dm_crtc_handle_vblank */
 	KUNIT_CASE(dm_test_crtc_handle_vblank_no_event),
 	KUNIT_CASE(dm_test_crtc_handle_vblank_skips_when_flip_submitted),
-- 
2.34.1

