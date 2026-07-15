Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A8BC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC7510F09E;
	Wed, 15 Jul 2026 13:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0IjcWLdQ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29B6010F09E
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZp52ILVuJjQdyjoAMECEbkuCFPqpfxj8ZHsWMc9+DKhRtdVSziKeWjoFKZzeCdC+hXqcyab/vaPWGOKF+3ambSmd5PoTTUsepkkMvhTClaYM/tpHNrOQdvziOVQ1WvnqfXQlg/yWODuEQBEq52Y1F5h6AInKnvurVPW+bso4zB06YsdwKs2cMGQ7TZYwIRqO15r+pdRu71Pb6mi+59nAlZnRgbJ2h5zZ1AsFR+kATQHJUl8NCkrHEkaaF5BFDNH5x349+4XzpFtEuhrrKETuOYWZ1qyQ/dSvK3ffEPn+w5YaEXlDo3+AlmL/4Udt8VmapUdKtr6wvsH0sPrsQ0Dzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Al3yASSL6doBzfaslgUveL560N/DQgo+Yg4jaTNyFsU=;
 b=UTjzc69Is70EMIIF7IONGOilUKOd9OJs/OF0jVqvHT5elzicC4uo38dXpGqKPiMDfnq/ga2kRX7SnO4fhP2KEzOrU9Ftg1A72y4BWFKRvUf6XaKrCzu9VXMRoP7WHH+O/sZSBH9XJqT5+u3QYSxi0FFOaw46P+/PypLnLtQONuBP9z1rRg2O2mM6FyxSRWcmEJD4SAA/MIpx0UGnkuMR66obZKHyWpC4oDVC+HW7VHlKFTY2c21n2hCvf7edG89rx0vQy+mmdcOr5lfhu2pxtMSR0x3njzQ9g8Yvuu+oCY7TjEaQ8Jq9tMkorObhPJS/S8U+TSg6N5YyzWp5IoYqug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Al3yASSL6doBzfaslgUveL560N/DQgo+Yg4jaTNyFsU=;
 b=0IjcWLdQJw8EC3hBRCcgIimdOz/im1oDn9Jq5SCq0rTHuqbfa8QNRQhP9UN1ZoVrC8Stkk+jCbh20opX/vraMBTiuK7GPORDratCAVOXQEaJKqo2h+hFfD8ctRNu3njqPj/WsHL9K8q0CS+LZdjEo6nVpxXrLLJ5uKbyb281FvI=
Received: from DS7P220CA0075.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::17) by
 SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.12; Wed, 15 Jul 2026 13:47:26 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:8:259:cafe::31) by DS7P220CA0075.outlook.office365.com
 (2603:10b6:8:259::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:47:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:24 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:23 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:47:20 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 40/70] drm/amd/display: add CRC source verify KUnit coverage
Date: Wed, 15 Jul 2026 21:37:50 +0800
Message-ID: <20260715134432.1975118-41-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 873d5a67-578a-4781-d8c0-08dee2779ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Hqn1RpBQyQRK5RQUStH696LN6/9ZXJxz7T7FwLDT0fIlAVdSx9S/LNKeSo1E1aRM7Bf8v5dgpaeyYugmayp5q/OhRcraNWVIG9qlnKrQndx+vCBGDRIZQw40jqaefuMWeShoKiwCOla4Zqvdaed34dkNbvrgKQ4/ZagJQ6b8/RbMxr6s5RD8a8Q0yA8KeJLAWnokeynkV5vbl9jHFqyMihzxwbmz4tgXbV+hg2tlgK7Gk+6wEj9pU1kXwN7JNZS/keE5v+6Oh7qOeqijSKgQj9cC8qXT075WIGMUbpDpVm5S4t551XGkHTTURdJ+iWXzQGSOUDLaDmx8IipFptKb1/fn1Eyoxh5bYbLS9poKgATPbIicUPIXHbsSWlu0y2tn9hoJAafv5/ZEPLt/yNeKgPmMeYqLvpzy1er0c/T4HUvhq0xOuqnyP6dLNAK/ILMcFrPU8nc2wJEeBLxrm6JU2xgZQOlnMusyIxMjU5hLmByE/9vxSX9FNFAwj5FjbuYyVHErc6xw1lEGI91A24a6EwOUCjbMzUqOp3RkQC/s+H/33BL2gSlJ/65WlL6wfHk1x6neyOsrviTJMBGzZwTsxogrD3NERsACdffGp6Z7rlEjMWkhnJhrXZJ1RkFIkRhJb/8lfIObCzlhV2d3hPFiWwoIc7+M/JqwgCYlqBei+gQ63ObHXAz5JYzgmg0ULs8S+3xCKS1PpEyUyCQB4EEKMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lC9xXwgd2sncvljB0lIAfqHZd4q1q0TVl6YmvryL75itKPZHZefuTNFnQTlayZHL982IXK0tiHfzLfQ4wcUixMk7d8zpzkuJbyENTRSX/K5qL1CKLinOddIlecQ1jPxb36YVf9Rsvx7juGZSASRUyC4b+d60icFHYqnfu8t1JTnhWhNi9a1o27TcTOArWAvIJHPVlPOmlNcSQrWEX5NBitMWydCo52NzcoPhMv6Q7XZ2Xi1ah26mdt4HdLsg/QKRerEoA0CvTcM9PFqAyYgl3ZiuO/gvEcU2CYiQZUZCzUaSeAa5wDSQ2IQ79jov2G8jJE4SyXtIh7bXCPyAk/Kqmi+bS201MG5QOytadD71og4EBdfpzexJqEdfPV+2CojgMJ5SPrJ3QtLuoE2JgR98Ck2Il9wouSg6y49iK/lNhrGusnakpG8hzENAtFD3i37J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:47:25.6416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 873d5a67-578a-4781-d8c0-08dee2779ab0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904
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
Expose amdgpu_dm_crtc_verify_crc_source() for KUnit and add tests for the
valid and invalid source-name paths. Introduce the shared CRTC test
scaffolding (dm_test_alloc_crc_crtc() plus the DM device test includes)
used by the remaining CRTC CRC tests.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  1 +
 .../amdgpu_dm/tests/amdgpu_dm_crc_test.c      | 66 +++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 630dea3487b3..6600cc6ecf8e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -565,6 +565,7 @@ amdgpu_dm_crtc_verify_crc_source(struct drm_crtc *crtc, const char *src_name,
 	*values_cnt = 3;
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_verify_crc_source);
 
 int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 					struct dm_crtc_state *dm_crtc_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
index 88f7a15853e8..4fa0bd9669c4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
@@ -7,7 +7,30 @@
 
 #include <kunit/test.h>
 
+#include <drm/drm_modeset_lock.h>
+
+#include "dc.h"
+#include "amdgpu.h"
+#include "amdgpu_mode.h"
+#include "amdgpu_dm.h"
 #include "amdgpu_dm_crc.h"
+#include "amdgpu_dm_kunit_test_helpers.h"
+
+static struct amdgpu_crtc *dm_test_alloc_crc_crtc(struct kunit *test,
+							 struct amdgpu_device *adev)
+{
+	struct amdgpu_crtc *acrtc;
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+
+	acrtc->base.dev = &adev->ddev;
+	drm_modeset_lock_init(&acrtc->base.mutex);
+	spin_lock_init(&acrtc->base.commit_lock);
+	INIT_LIST_HEAD(&acrtc->base.commit_list);
+
+	return acrtc;
+}
 
 static void dm_test_parse_crc_source_none(struct kunit *test)
 {
@@ -119,6 +142,46 @@ static void dm_test_crtc_get_crc_sources(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, sources[5], "auto");
 }
 
+/**
+ * dm_test_crtc_verify_crc_source_valid() - Test valid CRC source verification.
+ * @test: KUnit test context.
+ *
+ * Verifies that valid source strings return success and request three CRC
+ * values.
+ */
+static void dm_test_crtc_verify_crc_source_valid(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	size_t values_cnt = 0;
+	int ret;
+
+	ret = amdgpu_dm_crtc_verify_crc_source(&acrtc->base, "crtc", &values_cnt);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, values_cnt, 3);
+}
+
+/**
+ * dm_test_crtc_verify_crc_source_invalid() - Test invalid CRC source verification.
+ * @test: KUnit test context.
+ *
+ * Verifies that invalid source strings are rejected without changing the
+ * caller-provided values count.
+ */
+static void dm_test_crtc_verify_crc_source_invalid(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	size_t values_cnt = 7;
+	int ret;
+
+	ret = amdgpu_dm_crtc_verify_crc_source(&acrtc->base, "bad", &values_cnt);
+
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	KUNIT_EXPECT_EQ(test, values_cnt, 7);
+}
+
 /**
  * dm_test_need_dp_aux() - Test dm_need_dp_aux().
  * @test: KUnit test context.
@@ -248,6 +311,9 @@ static struct kunit_case dm_crc_test_cases[] = {
 	KUNIT_CASE(dm_test_is_valid_crc_source),
 	/* amdgpu_dm_crtc_get_crc_sources() */
 	KUNIT_CASE(dm_test_crtc_get_crc_sources),
+	/* amdgpu_dm_crtc_verify_crc_source() */
+	KUNIT_CASE(dm_test_crtc_verify_crc_source_valid),
+	KUNIT_CASE(dm_test_crtc_verify_crc_source_invalid),
 	/* dm_need_dp_aux() */
 	KUNIT_CASE(dm_test_need_dp_aux),
 	/* dm_crc_source_should_start_dprx() */
-- 
2.43.0

