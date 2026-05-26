Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B322ACD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A79110E501;
	Tue, 26 May 2026 07:18:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WhV80wXR";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA42F10E501
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:18:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKcC+iLkax+byBuuAdfh2t0VnjabOB30ajRmqTSggZgCLm2nGosQNoCF1vgtSXr5++eJ50tO+6ZzaPN89+6wvEltZdWiujAegkt676zk/wPryCV5yD1g2VCF4wj9XX/Ku7EbV0Uf9n/nGVPNPRGtc4qJAILWRWqKT5K4U2lTtdk/rC8YrudroFdU4uy1MxLqh3pKbJQtHHKssu0fNt304AjZD+Gg2cDTF5OgpqcEs23mWqtdJrtMZ2B/0rNaQQlsb3B07AdV0Si+p6hsAyBqXzTlw0V+CjtR57aCd6ALuSYgubcPIhyr0w0dZjfvqDEPSLPxh4oM9wKVVrWqQ0CuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6sKr36Wh6lTESXk40Do2z77LVNHwWgwkpm8DTvA0vA=;
 b=CQ0NBBRb5wW9k1J/UTxV6kJtutoDLFBNdLEaUdyGWEJAjI0OAqgIdI0T9S/0bYO1ZfzUWKbTUEd0BKZFGnI+ipLqd1yUSr3VT8mdt3MH/akD3Im3sFO/HGGoypZOJKhQwNCfRUG04m9rAWnwyRGNSe5Wto19IZOGaDKcnuUJDxv9/biQV061k/2ZL41/hUWWj7arfJOdJVLMsdrbOQaaNLlgbVAi0OT/Bd9kCqQv66QXvTOVdO4RRUi8Oj/9i82pA45Wu15aXjxds2g/RTmaXmOIIp1EINSITF5jn7MGWIOS38FzvAGKFmUmJygFd2S3yTJNjRjl1qOMDwAsfAXHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6sKr36Wh6lTESXk40Do2z77LVNHwWgwkpm8DTvA0vA=;
 b=WhV80wXRPGZTBhcOtMHJ54mLISgkQOPdpXPb+n7thiPvLP0Yj0ysQTSTfbVIfIIXX27Qv3E+ONiEY6ObcA+Nm+Js4e24IOZ/5WVeg9EFyyOVwsoky9f9y94MwNd9Pms0C4R2jLjnEfSCeeQT3b5XD3tusB/3iJR5h1eUCvvLVww=
Received: from CY5PR20CA0021.namprd20.prod.outlook.com (2603:10b6:930:3::8) by
 DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.11; Tue, 26 May 2026 07:18:34 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:3:cafe::15) by CY5PR20CA0021.outlook.office365.com
 (2603:10b6:930:3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 26
 May 2026 07:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:18:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:18:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 00:18:33 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:18:25 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 29/41] drm/amd/display: Add KUnit tests for
 amdgpu_dm_psr_set_event
Date: Tue, 26 May 2026 15:01:52 +0800
Message-ID: <20260526071413.2181251-30-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f111ae-6501-4231-7eec-08debaf6ffaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Ioxzc91crAtoAJnoqaEFAohz+DUPS+xNH7GvOwDJESd9HGyUA1AqQfglQJOJUc0YTyas/UEVeThVTIrwomkyAKVxLMEQ22IY3eWcQW5RAqoC2E0XwkgqKe5ZGyAoregmNk/k+JeRuu4xN9+OhmSO3g0FQLgthX7+FRCiN9WMYqXwOcAJcshPz0HvXmr2E2U/dDtZKNZay5Ig0SASEmTjF7srAAuo/A8jlqsyRKh4iTJdMK0SDhS1+rxNAToQdgT/5FcYniddYsQCwvNexvw0R+VvNr16ys91Zy/UUSjCAGmWdqHS/GbFKWgdcWH6OOLbg3QBkKMOJvSBagdQTCVzcO7J3vhjzbUUsF2xsEHfdEqlwNsrpv5OqLuHVKGa5HGRStTsOhqyQmq8+MotQzaXhqr1CSQ3eEoEPFxgpo1Tr+xzMqjJ3Anos7D7U4P6H+s7XaRWRTZAalD0JeDZdWwzrxKlpRVGdLv0ZO+qNvhRwkSHK4K4uYwmi5sj7YpTQSPx0i0QkRrzxn8vbSOA/BmAf8APrnv6AIicxwlRNUFqT6Au1XF9WuR8hHg0HypJefvYwc1wTvFc4Be73+6lFkbW4m6hASp7ou68uvPzvbUc4wB78ouTTuw/XsLSb6X8bdUpSI6SjfSiCh4NNQyOPmOEoNqDAy1zj+fwR71jZlI77oyDgCS+C9Rpcx5rZCP+fprpysHGED9qe7aC2Cy+Q1phIjeRxnbjpUNtJDfC/RbU7aQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(11063799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wmVpux1WiCQjn42EL0mkO7FKTGVpzGeADxmgTpdiVuca9FIuNExXH059cmGS94mhNrldffnSmNGY17wIXIUDlrogRmmlKtaUwQffCibQ04nE8YUI2ep3xDt2Sd1MKnc02M3kOpL4kxUFoyuD9+a7My4fgFNOvIqVMkwEMfiKwT4QyOM1ERuhjW+DJWR03IDBGPOyf12NbW8CN2ArZg1glOF/6PFNokWK31oxjKulgkMnx08fy7bA14U0eKwqUSEtf/Ojuf7FIPJBQlLdGfYFpSfkYcMPJnlpunWl9Ng9rt/UO9zsLkuiPymVdM3ikAGt93btoEz0EVo4h5ZK+UVYr0GUwBZnyByhsrlKgaEXW5VLaJ2Nxx/CpXZUnPouHMfVbklPFqCDT8th6FG8xa+NoVW9j4tL4qwfsYAuHlyjX06kkRO/LZdzb15fUgkQdC00
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:18:34.6865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f111ae-6501-4231-7eec-08debaf6ffaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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

[Why & How]
Add three KUnit tests covering the early-exit validation guard in
amdgpu_dm_psr_set_event():

  - NULL stream argument returns false immediately
  - Valid stream with NULL link returns false
  - Valid stream/link with psr_feature_enabled == false returns false

Assisted-by: Copilot:Claude-Sonnet-4.6

Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |  4 +-
 .../amdgpu_dm/tests/amdgpu_dm_psr_test.c      | 46 +++++++++++++++++--
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 4b823bba4392..dd26de9a57e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -25,6 +25,7 @@
  */
 
 #include "amdgpu_dm_psr.h"
+#include "amdgpu.h"
 #include "dc_dmub_srv.h"
 #include "dc.h"
 #include "amdgpu_dm.h"
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
index 9f3e22520ca0..40a09b5dc606 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
@@ -27,10 +27,12 @@
 #ifndef AMDGPU_DM_AMDGPU_DM_PSR_H_
 #define AMDGPU_DM_AMDGPU_DM_PSR_H_
 
-#include "amdgpu.h"
 #include "dc.h"
 #include "modules/inc/mod_power.h"
 
+struct amdgpu_display_manager;
+struct amdgpu_dm_connector;
+
 /* the number of pageflips before enabling psr */
 #define AMDGPU_DM_PSR_ENTRY_DELAY 5
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
index 61a4167898cb..09084f70a405 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
@@ -7,11 +7,7 @@
 
 #include <kunit/test.h>
 
-#include "dc.h"
-
-/* Extern declaration for the function under test */
-extern void amdgpu_dm_psr_fill_caps(struct dc_link *link,
-				     struct psr_caps *caps);
+#include "amdgpu_dm_psr.h"
 
 /*
  * Helper: allocate and zero-initialise a dc_link sufficient for
@@ -227,6 +223,43 @@ static void dm_test_psr_fill_caps_power_opts_z10_always_set(struct kunit *test)
 }
 /* End of tests for amdgpu_dm_psr_fill_caps() */
 
+/* Tests for amdgpu_dm_psr_set_event() — early-exit validation guards */
+
+static void dm_test_psr_set_event_null_stream(struct kunit *test)
+{
+	/* NULL stream → immediate false, dm is not accessed */
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_psr_set_event(NULL, NULL, true, psr_event_vsync, false));
+}
+
+static void dm_test_psr_set_event_null_link(struct kunit *test)
+{
+	struct dc_stream_state *stream;
+
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	/* stream->link remains NULL from kzalloc */
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_psr_set_event(NULL, stream, true, psr_event_vsync, false));
+}
+
+static void dm_test_psr_set_event_psr_not_enabled(struct kunit *test)
+{
+	struct dc_stream_state *stream;
+	struct dc_link *link;
+
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	stream->link = link;
+	/* link->psr_settings.psr_feature_enabled remains false from kzalloc */
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_psr_set_event(NULL, stream, true, psr_event_vsync, false));
+}
+/* End of tests for amdgpu_dm_psr_set_event() */
+
 static struct kunit_case dm_psr_test_cases[] = {
 	KUNIT_CASE(dm_test_psr_fill_caps_version_1),
 	KUNIT_CASE(dm_test_psr_fill_caps_version_su1),
@@ -240,6 +273,9 @@ static struct kunit_case dm_psr_test_cases[] = {
 	KUNIT_CASE(dm_test_psr_fill_caps_dpcd_fields_unset),
 	KUNIT_CASE(dm_test_psr_fill_caps_rate_control_always_zero),
 	KUNIT_CASE(dm_test_psr_fill_caps_power_opts_z10_always_set),
+	KUNIT_CASE(dm_test_psr_set_event_null_stream),
+	KUNIT_CASE(dm_test_psr_set_event_null_link),
+	KUNIT_CASE(dm_test_psr_set_event_psr_not_enabled),
 	{}
 };
 
-- 
2.43.0

