Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C6EC79FAD
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 131B710EB1D;
	Tue,  8 Sep 2026 11:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lF/DnS8Z";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C910510EB1D
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGWuYXji2B+HSioKTivgUwViIGU5c312sUTtSdfFkwW5qh6EO5rOiyb9HnB1DrCPVQvfz4RGFaP5SLjApJgaU9KHQ3QOu4gFcCKipXfc6pDlbW2fSdc4usixhA9dYsWgYd2t5CMaWqPUYe668DOq1OrrAQbumv3+/RJgmFZfetqgLe7DjRsPgBmqX0ndv0UR6pdnth128tYAIeLPtGgJ8TZ3S86q74rHLTaiikWJof0g9xGPhRRhcg73EyIwjEnCbxwS+kpplNGkwjHpAyUkQgQ2uXcX05F4lVgX3Nwsj8/Tas2U7+8Mm9omXB8hyXfBxATX4EYI/S2/bxVkguV22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDk44RfEaQlzWkrKsI+pWwIz26u8BG+XVB/MpTrtrz0=;
 b=cTxPhaKGXRZGfsieTL1NH2luMRgFhfuKAfYreQ6iBGYRu0NVKX7pKrtPC36Acv/TuFNO3yGFFDmZdFARDVdnF7yP1Sf10tBsOerB+yqhf3s4DRkkjfBuB/zl6RQY7dTFJ16VozRED/76QB7dIQVXRh7Es6mQvK48JGZ8jDWXpDnmkXPHdpBU3VOz21kE2o8wK5HnnhOSxlMe5m1FfOQ7yplRHQXdnaRIsT+5c37rec5FyRDdywL8EHRI/f96QE0PVXfglGyMd4n1TA3Xs83zJdYncLEZNaRm+9yT3LJ1CNAH/UleXI0jtiWFRePa81eJw99UB/slRrzJX6PxBOzSxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDk44RfEaQlzWkrKsI+pWwIz26u8BG+XVB/MpTrtrz0=;
 b=lF/DnS8Z+OB8KQMcSH+dFu4OBUcQj0kgDh9hQR8bf6PAiC2Mp8iC85PBsoJeR9hUiOP9kLOXGCjw7BEVs2gEHAGh/Td3Kw7GFlqz20kHV+ZNYLe/gfgza5EFAi3fNwLhCAMYnbbJlDyYd2iZAXNWQaUB3m6O6OHaRJjmsUZvVUY=
Received: from MN2PR15CA0040.namprd15.prod.outlook.com (2603:10b6:208:237::9)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:34:50 +0000
Received: from BN2PEPF0000A895.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::1) by MN2PR15CA0040.outlook.office365.com
 (2603:10b6:208:237::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A895.mail.protection.outlook.com (10.167.248.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:34:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:34:48 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:34:40 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Chenyu Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 07/66] drm/amd/display: Test HDMI connector init
Date: Tue, 8 Sep 2026 19:31:00 +0800
Message-ID: <20260908113338.2433445-8-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A895:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b22ecc2-e6b1-49ea-567d-08df0d9d318b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3bWKh5wU5vquGvt4J7JG0UQMnUXb6pdsA+gM8acDWohEDih1RuAwjAmgOGuTB6F+7nj+eCCy3hXnRAMJjZvZbmKVkddfirBp0FOcyaPAs0XdRxh74DH7NtJ+ijeAJBTwfpoKjC424A3l7OWyPIVn3YUT5ceQYLDDIxAQ7qWjFk0f+ciPNS8o6iaKyjkLZEnTPzg5yOWTVlbRrnxWZQW9Zy8EDX/SvvYGES7b+0RddbHgn6Bw7BExyC+Sg/3Kw7jzX2H1hR6Ynb5XvGBZo8RhyAWg7b5wKKrcfFIWsRkAtb/gPXXBffmLDn13X+B9ybh7wTgaPJIQ83O3g5w1/1T0/Q4hLv6SG4OYU09PQ38F9JPKIAMhJ1fs8d+Gxbpwi//UTUmTqAMDc1bl/4XMos9Gd84jE+YdOsdWRV+P3o3Nulqjktohw2HsA0HpkpKOgy1pHSAHQX6izfH4nEAoGxpJsygLJs/FEeatzJyrHjS+lVJ+1BfDI77qSSVTarWOH67qb+4RF1kCsRc2tjRob81ETx5R8k67GUYYUhNs/ZegYt4wlNaBeniJLDry1KT7a48pas2GIYspTIbXbW8a3+TlxtmjXFa4vL1sUwxjHuwZlCcoRSZKikv9FGU8WOjsAoWOX3y/qO0pdXzbzm/YiBD/N08lymhsNFR2OKZw0jdeL15kBgJMmKVU+ToqG8UPTLd8IxMcTACreX/HbSgKxqHBDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YmJ+ug8nXdMTCAJCxnxrz9NxZqIv2Xv6aZZ/JuGPNJEjf23LB5PuCTiiPwTKssjr2f/jKZ8jnlKaTYNrt481P4pqisVNExhcd3O7EuTz4ldl3E1uVx5dJPZVajouulhyp/oCX1ZOANzfCnbnUyR0aB1LVpTWOL3zssFt5cIVHY6jxCrH0ZFRzQRMoytkb5MELaUpNJAQa5wBPkauMgi+kJIGYhXdS5SoWM15Fl06bAVei7QRCLTILNPmj2HQzohh79Ve9g/pk+dU9nKoHgH0Gox6wF4xXGuJ7A5u3cL5iG0o8AEd4pktrtwWZowimEb7dkdhECP9aLJ6uL8q0+o0TADaHsJ13yIML5EfRK+rgGXVGaihCArlaM/NKPX64ncxUS/nKGTq1sUqeUMbFdDbIV/r8R1GCwkYF4uaINvhnRhp6aXMagybelVCBp1HIHlV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:34:50.1755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b22ecc2-e6b1-49ea-567d-08df0d9d318b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A895.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656
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
Add a KUnit test for amdgpu_dm_initialize_hdmi_connector() verifying
that a CEC notifier is created for the connector.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  1 +
 .../tests/amdgpu_dm_connector_test.c          | 20 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index a80d5426bd9f..f95b680ee8f3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3368,6 +3368,7 @@ int amdgpu_dm_initialize_hdmi_connector(struct amdgpu_dm_connector *aconnector)
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_initialize_hdmi_connector);
 
 /*
  * Note: this function assumes that dc_link_detect() was called for the
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 2fe55f07e464..7a51b27f020a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -9422,6 +9422,24 @@ static void dm_test_init_helper_hpd_debounce_disabled(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ctx->aconnector->hdmi_hpd_debounce_delay_ms, 0);
 }
 
+/* Tests for amdgpu_dm_initialize_hdmi_connector() */
+
+/**
+ * dm_test_initialize_hdmi_cec_registers - Test the CEC notifier is registered
+ * @test: The KUnit test context
+ *
+ * Without DC_DISABLE_HDMI_CEC in the debug mask a CEC notifier is created for
+ * the connector.
+ */
+static void dm_test_initialize_hdmi_cec_registers(struct kunit *test)
+{
+	struct dm_test_init_helper_ctx *ctx =
+		dm_test_init_helper_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_initialize_hdmi_connector(ctx->aconnector), 0);
+	KUNIT_EXPECT_NOT_NULL(test, ctx->aconnector->notifier);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -9830,6 +9848,8 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_init_helper_edp),
 	KUNIT_CASE(dm_test_init_helper_hdcp_property),
 	KUNIT_CASE(dm_test_init_helper_hpd_debounce_disabled),
+	/* amdgpu_dm_initialize_hdmi_connector */
+	KUNIT_CASE(dm_test_initialize_hdmi_cec_registers),
 	{}
 };
 
-- 
2.43.0

