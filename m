Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CA7C55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:40:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73F9E10ECFA;
	Wed,  5 Aug 2026 06:40:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z8erz4xh";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010051.outbound.protection.outlook.com
 [40.93.198.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2298210ECF7
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOiWFbG0SeGnx7OaT9F8lwWb+suKWJN5xZoj0GRnLxrUBi7voGARg4FyxmL4vVM5Wdmt2zyqQSBy5c8lGaAqrM/koYqiPUWOReRckG9aIUxagu9NeG3EKgaZdv4/ci/3/vQr07qzXSLOui/tMQ+kbZpbEJB1s3oyfAyz/c76Ar0RO0GnVIXAbm8NX/PYuOeJJ/7YY0IkHn3FB+tt79/1t4ctOwTr2npmsH18QSDYce4cbPRXyAx483i7F5icym1srg7WDGlz2rP23Qniy9+XfV/fKoDgV8aFnAobKFpo4K8fZjVPQYbpOV9iTggT2NtGmd787M8zI8KH3284+tamsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSE6z5zgFTPl9ZXbbXQJ2eOZXUzIuXxYSqLMgcmXdM0=;
 b=M+gjigtx3WynCqe+lj3I6pHp41Ox2s5ecdndC7L6xAhpqKwTYEF9uSXUdbUk2NBNeA0jiJpt7xRP+M0VeFVOpgP44oqlmqNnJ/28dA340HwEF3+cmIMzogfwNtdAEo/1W8sT9U+2bP+kAHb3LrTsOXOqrzWBhRpWgIIuZdYG/Huqdyk51FCfGPmMFfygZvDxRak5GrdHElJ3u4R1JTS3yG82A1SerqoaT54eu0K7O5OsnrNY7ztEbkIdtAQO2O9IUq5oG0E/aDwua/R3BL7TQSO47fqCLxJUfiRBKlgvN4wD/Pw/kyAAV+Rgo9MSrY0EjV1gYxI9cN0zZGs1aGeJEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSE6z5zgFTPl9ZXbbXQJ2eOZXUzIuXxYSqLMgcmXdM0=;
 b=Z8erz4xh9oXw4Cczt3iricxtagdTOLfWqzCYmjiZhFFtrPokrj3Iy64yqYLWuFjT8YnRrQr+Tg5XI5pD9WQU2TPhaawYBzQYMic6tnCYVGUe4RQEdNFPVnT3YAB85XUEiaS3QVldeOWjH6AsdJa25Iyfd9AUuNnz2xKrAhIAhEs=
Received: from MW4PR03CA0256.namprd03.prod.outlook.com (2603:10b6:303:b4::21)
 by SA1PR12MB8946.namprd12.prod.outlook.com (2603:10b6:806:375::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 06:40:15 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::79) by MW4PR03CA0256.outlook.office365.com
 (2603:10b6:303:b4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Wed, 5
 Aug 2026 06:40:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:40:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:07 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:40:04 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Subject: [PATCH 04/34] drm/amd/display: Cover crtc duplicate_state stream and
 null guard
Date: Wed, 5 Aug 2026 14:36:16 +0800
Message-ID: <20260805063937.2145774-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|SA1PR12MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d10f277-2078-42fb-5ec3-08def2bc680a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: fVb4HO8duvAXV+99ODlneHVAue0yN1xgfs7+IWzEm/ytwOlq2E15m+oxL4T0IgSLhLGnpiLG8xr+QcCuU2jaWd+KJdKVe87ordv8NLx+wlxK4iQ65AMS0NRXKtWTGS8+Re9yjd2DG/iN0h4DWxpCDJqnO9SmQhf6hp79s0E6D3xYZvQxVvqNLsXEOrtpD07W4IPXD3AjryGop0vQ3oy0RDdSUcZD0BCIpBwQr6ybCnfJ132K77WBaYiUb3VnCjnoTedUXayxOinWS/+R5RhcZ5+IhmYWzenDNDUHzITSRo/VfrkqymCVd3nsZV3wRUAkhsvQSfF0CR11syBVPkb71S0rFmqN60WVskbj3/oZFQ0kBxR/2tswMsziTkSHEd93JvxJGKfaRzr8SR6Cmx5J45lhYkb1Z/LfDtalHzJKCakDZiSLqa7UPBCFLTCdastl0oasfAibeCmG1EljuLnai+aSyNyVaGctsO+ZYN36kTtzlCQbGe8J8nPmLrA3TxY4gnsv9Gyl0kA41fUKrYssZwaJhPnvD7LlvWGx22rfbdzWI48Y2V35fSVqH0T4A3KpjuaiYCxlcF6RhYVMTBeRbetPE4GmI37GPrVmrX9RAixdS+xgyVGqlI5iXk26bRx4pjXMhtLqQCHEYnegl0djI4fcNETE0XucuQ6k/rcyPLNaCrHiqaNZDwDTpZPY+KBvbDmhLoNzIPaVQD+e8HICHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hvLxedbgKBpEM811J4cOWhfS5D46b95n6q3fmBy6WWNJcROm3D+Q6D0ZfXd491xxvDauFOmPu375ZOdiyaztOTSDvN04uYy7E7mREovCeNWNRYqq+THvqbrZo80NAHeqrJGkrqTUTr8VaVgkL66ZK0Mo1AafWlps2U9Jta62r7LBRZ9XU3AtOSJghFU6gE6QnmbN7Afh0ZPOQIAQ/SyNAsH4fs4rBcOTiJh4J+HnMS5cF85fDHMmQeBdvvDhALSGlzInqdZdcni0kG20G+7eyuTvwlad09+t8zTqpdtF0H95HRvZHKO3lVciS+1tjoP4CTS7nlgpr12jBD4ji3muGgRUzN7u655pZgG7xrq2M/4RHgBg/+CpXDtBKFbO4nMOh+LjHtWa42ZQzVgfK+YbTm0hP6ngpMBJhjPhLXtQRdDaBznpRs/ycvtFbl8sNpYY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:40:14.5676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d10f277-2078-42fb-5ec3-08def2bc680a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8946
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

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

[why]
The duplicate_state stream-reference and NULL-state guard paths in
amdgpu_dm_crtc_duplicate_state were not exercised by the KUnit suite.

[how]
Added dm_test_crtc_duplicate_state_retains_stream to verify the duplicated
state keeps the stream pointer and takes an extra reference that is dropped
on destroy, and dm_test_crtc_duplicate_state_null_state_returns_null to
verify the WARN_ON guard returns NULL. Registered both cases in
amdgpu_dm_crtc_tests.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 4dacddd23878..a23281a33422 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -1404,6 +1404,65 @@ static void dm_test_crtc_duplicate_state_copies_fields(struct kunit *test)
 	amdgpu_dm_crtc_destroy_state(crtc, dup);
 }
 
+/**
+ * dm_test_crtc_duplicate_state_retains_stream - Test duplicate retains the stream
+ * @test: The KUnit test context
+ *
+ * When the current CRTC state carries a DC stream, duplicating the state must
+ * copy the stream pointer and take an additional reference on it. Destroying
+ * the duplicate then drops that reference back to the KUnit-managed one.
+ */
+static void dm_test_crtc_duplicate_state_retains_stream(struct kunit *test)
+{
+	struct dc_stream_state *stream;
+	struct drm_crtc *crtc;
+	struct dm_crtc_state *cur;
+	struct drm_crtc_state *dup;
+	struct dm_crtc_state *dm_dup;
+	struct dc_link *link;
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	cur = kunit_kzalloc(test, sizeof(*cur), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cur);
+
+	link = dm_kunit_alloc_link(test);
+	stream = dm_kunit_alloc_stream(test, link);
+
+	cur->stream = stream;
+	crtc->state = &cur->base;
+
+	dup = amdgpu_dm_crtc_duplicate_state(crtc);
+	KUNIT_ASSERT_NOT_NULL(test, dup);
+
+	dm_dup = to_dm_crtc_state(dup);
+	KUNIT_EXPECT_PTR_EQ(test, dm_dup->stream, stream);
+	/* The duplicate took a second reference on top of the managed one. */
+	KUNIT_EXPECT_EQ(test, kref_read(&stream->refcount), 2);
+
+	/* Destroying the duplicate drops back to the KUnit-managed reference. */
+	amdgpu_dm_crtc_destroy_state(crtc, dup);
+	KUNIT_EXPECT_EQ(test, kref_read(&stream->refcount), 1);
+}
+
+/**
+ * dm_test_crtc_duplicate_state_null_state_returns_null - Test guard on missing state
+ * @test: The KUnit test context
+ *
+ * Duplicating a CRTC whose current state is NULL must trip the WARN_ON guard
+ * and return NULL without allocating a new state.
+ */
+static void dm_test_crtc_duplicate_state_null_state_returns_null(struct kunit *test)
+{
+	struct drm_crtc *crtc;
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	crtc->state = NULL;
+
+	KUNIT_EXPECT_NULL(test, amdgpu_dm_crtc_duplicate_state(crtc));
+}
+
 /* Tests for amdgpu_dm_crtc_reset_state() */
 
 /**
@@ -1907,6 +1966,8 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	KUNIT_CASE(dm_test_count_crtc_active_planes_mixed),
 	/* amdgpu_dm_crtc_duplicate_state */
 	KUNIT_CASE(dm_test_crtc_duplicate_state_copies_fields),
+	KUNIT_CASE(dm_test_crtc_duplicate_state_retains_stream),
+	KUNIT_CASE(dm_test_crtc_duplicate_state_null_state_returns_null),
 	/* amdgpu_dm_crtc_reset_state */
 	KUNIT_CASE(dm_test_crtc_reset_state_allocates_state),
 	/* amdgpu_dm_crtc_destroy_state */
-- 
2.43.0

