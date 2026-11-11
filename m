Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441C2606A326
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jkJDitwk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC7C910F8D7;
	Wed, 11 Nov 2026 01:43:00 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013014.outbound.protection.outlook.com
 [40.93.196.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E89710F8D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:42:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/Q7QeUl+F87y1sWbNSRpHhziUMYqKKo1Mc1+FaxH9O4xhSY7GnrXUQX3K8JSP3IAKuwprzt57Z7ccTa+bZmJzdW453Tgri6Df3NxaNwCk+5U7PMzCtfK5bIL/ODzWilhK+gbj7Prg5g5eOWmRdrOGD/HCriJxhsXIpQHsn4XO7/60/TulD+JLoCHwto4SYjKrOepCsGS8SLQm+cxTFVRMx7vGbZ6latbjKG3TiGWRuBnysIJpn5uZtg9EL+y3SIJv7YEdAcgGsCNWjAwYn6N5hDWr60ZScbYz1tWH6OiZC0v13WYjtmA1JObXE+Laqj/fzHJ2M2NqmsncQE8c5FnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYtTsZEMcYSF5YwAISc7cl4dQoQddy8Wn0UmKjA22s8=;
 b=YDD2Q9VkuZN8kH+9bEzazQup+rfPzybOr+LEh2CPAFPDKK5vcC/uCuVQQNUKz4TX0nPhbRDH1WTOoNR0PgSHI6TlQwjlnWGwYf/IYzlP4v8fFQVbmsh9gHq0H9HvMZRymTRElWB+GUxHOvqvvoygRnNXXZi8GRfJPi563tcV2HWQkSfHHOeSl0XWCz2qpSyPQ1qn34uXY+PdXz8X9yJklAFacjg68djmEwAbd1+f/joXQcVrZ7IL+fcQ742J6XJdkOAjKPGtG8x1gM3iQTvEA5VkAs22vSkMk78zoOPErUPo02sYHty+E3kN2c8vIFQ8J/m3BgilpbkScFPZDulDtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYtTsZEMcYSF5YwAISc7cl4dQoQddy8Wn0UmKjA22s8=;
 b=jkJDitwk10AWTs1ZRadYA08//jD0w0Uy+1omdsQP1Q1M++dg9xn7hgjHsV5gMadmg3zgxg2phWdxnSmOsGSWi2vI+vvV6g3u9MxKmUPWkYNhNDIzLv5n52IDwxJHDc41a95pgfI2Sdu6zuok0cS85B7y7VBHyzP6xHVqboK9oE8=
Received: from CH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::10)
 by LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:42:50 +0000
Received: from BN2PEPF0000A7FE.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::93) by CH5P220CA0002.outlook.office365.com
 (2603:10b6:610:1ef::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:42:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A7FE.mail.protection.outlook.com (10.167.245.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:42:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:49 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:42:40 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>, Hugo Sales <hugo@hsal.es>
Subject: [PATCH 37/74] drm/amd/display: Allow DC_PSR_MASK to enable PSR
 without DMUB PSR cap
Date: Wed, 11 Nov 2026 09:28:43 +0800
Message-ID: <20261111014100.3596072-38-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FE:EE_|LV3PR12MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f8018d-20ab-41cc-b19c-08df3f951835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|11063799006|56012099006|22082099003|18002099003|10067099003|261009223027099003|261026121527099003|261102123227099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: W6oAdQ4PEuJW+X8PM6PHA8h1xN5+9LO9HMDhePEkbuH9zqqxDZfvbbW4LNebR+A4vMYIZWCyMibdMlwTu4iDhOj9gJAvuNLJVqW7rd9BsXqJpJLKGHGIE+NzSi0ig6xJe+w7jOY2K08UcZpMU5v81gdP6aM3BNjC4wlS1KEN/Oxhxtb3i9N4NTcb5xiH5+QL4F51zJ74vq0PZ9zAJrRGIMQWIokikCG39qnsvTBud7aVi7z25R9B/NQMMWwMBdJmPlSPcScU+C8YQGl/m1h5DJp18zBwMty+jCC2hQR0sm947dB5n5wqQs/r6ghv/OvOE77jaJN6139ofw9esB11VCTt+oDgT2/rQqxaNoX1mk4cTUMRSHlUB6HFg0aCi5ysWoKyWo1x7b6DiZ1eHnZxbOGM/dHbgqqTF9AOuz+r1FWu6udr+rD74w4ygrKH9avY9Cft4fYiKzFkY0oaymPM/b1+LHGAZmi9XdFsla0z5tAaPEQkEn8/5MxzcQnp8ErCaMwhppmrfL9b9Kvaa3jvSua72N5JYgHRUrYEttFvAl4CNA3Bun0UL6q6Ag8ZS/QIwcbvgrDFaOHSf5mnQQKlMsXh4TzXnVtQMvs1rZOml+/XlLErr8wUzZaLydF9hM6bKWgxJ/L3H63cXN8K12u4GHIsQ9X0iFBhPGVQekOVM0DCAiNzZQWX2wi+pv3VVbjmFNuI5BbVXthd2Npi7qtJWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003)(261009223027099003)(261026121527099003)(261102123227099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9XqiB108PaVOMeA36Wy2E1xWrb53bv7wTdnkc61uVT21c+Pdu7nuOpy68j2ICuwafra4cB4lGfsdFkCP0Hcj1PMbTnwy1slh5H5Ol334tPpY8CwEHlQJQTAI+chP5oCripAZgWOfETD+CjjhycHJiRukeAL2sSIr3e2A+0lerpnT1H60qNOzAk94TXltLxt2UILBZmrN3HS6JeC7DahHMLppLZIBvzaDQTV1IIyxdE/brWmyCtzjlwzuj+lBGvW99XjWCHrid4+nc2a2TGrH+cIheXP1zIVKaZKz5z7Zdvg1EOYn2EaoV/cExnrpdzLNbhYovkwNzNrPltD9cvCBS/ghl9XQ38Jj3gfKXB3iiii9rgMYvGuFEYiii0CPAjvTLtBIOHQ0DnoPslKm/Z3P6ZVy7tjoUoxZhYfk6MWKpLlZSkPylT8/fddIQWazB3fZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:42:49.8233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f8018d-20ab-41cc-b19c-08df3f951835
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9404
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ray Wu <ray.wu@amd.com>

[Why]
amdgpu_dm_set_psr_caps() requires dc->caps.dmub_caps.psr, which is only
populated on DCN IPs that query DMUB feature caps in init_hw. DCN 1.x,
2.x and 3.0.1 never do, so PSR can no longer be enabled there even with
amdgpu.dcfeaturemask=0x8.

[How]
Skip the DMUB PSR cap check when DC_PSR_MASK is set, and add a KUnit
case for this path.

Tested-by: Hugo Sales <hugo@hsal.es>
Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  3 +-
 .../amdgpu_dm/tests/amdgpu_dm_psr_test.c      | 35 ++++++++++++++++++-
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index dbad0a6d3a2b..295b1c307fa3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -111,7 +111,8 @@ bool amdgpu_dm_set_psr_caps(struct dc_link *link, struct amdgpu_dm_connector *ac
 	/* Reset psr version first */
 	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 
-	if (!dc->caps.dmub_caps.psr)
+	/* DCN IPs that never query DMUB feature caps rely on DC_PSR_MASK to opt in */
+	if (!dc->caps.dmub_caps.psr && !(amdgpu_dc_feature_mask & DC_PSR_MASK))
 		return false;
 
 	if (!(link->connector_signal & SIGNAL_TYPE_EDP))
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
index 0a484ea7c0e8..c084e4f85f95 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
@@ -230,15 +230,47 @@ static void dm_test_set_psr_caps_no_dmub_psr(struct kunit *test)
 {
 	struct dc_link *link = alloc_test_psr_caps_link(test);
 	struct amdgpu_dm_connector *aconnector = alloc_test_aconnector(test);
+	unsigned int old_feature_mask;
+	bool ret;
 
 	link->psr_settings.psr_version = DC_PSR_VERSION_1;
 	link->ctx->dc->caps.dmub_caps.psr = false;
 
-	KUNIT_EXPECT_FALSE(test, amdgpu_dm_set_psr_caps(link, aconnector));
+	old_feature_mask = amdgpu_dm_psr_get_dc_feature_mask();
+	amdgpu_dm_psr_set_dc_feature_mask(old_feature_mask & ~DC_PSR_MASK);
+
+	ret = amdgpu_dm_set_psr_caps(link, aconnector);
+	amdgpu_dm_psr_set_dc_feature_mask(old_feature_mask);
+
+	KUNIT_EXPECT_FALSE(test, ret);
 	KUNIT_EXPECT_EQ(test, link->psr_settings.psr_version,
 			DC_PSR_VERSION_UNSUPPORTED);
 }
 
+/**
+ * dm_test_set_psr_caps_feature_mask_no_dmub_psr() - DC_PSR_MASK opts in without DMUB PSR cap.
+ * @test: KUnit test context.
+ */
+static void dm_test_set_psr_caps_feature_mask_no_dmub_psr(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_psr_caps_link(test);
+	struct amdgpu_dm_connector *aconnector = alloc_test_aconnector(test);
+	unsigned int old_feature_mask;
+	bool ret;
+
+	link->ctx->dc->caps.dmub_caps.psr = false;
+
+	old_feature_mask = amdgpu_dm_psr_get_dc_feature_mask();
+	amdgpu_dm_psr_set_dc_feature_mask(old_feature_mask | DC_PSR_MASK);
+
+	ret = amdgpu_dm_set_psr_caps(link, aconnector);
+	amdgpu_dm_psr_set_dc_feature_mask(old_feature_mask);
+
+	KUNIT_EXPECT_TRUE(test, ret);
+	KUNIT_EXPECT_NE(test, link->psr_settings.psr_version,
+			DC_PSR_VERSION_UNSUPPORTED);
+}
+
 /**
  * dm_test_set_psr_caps_non_edp() - Only eDP links can enable PSR.
  * @test: KUnit test context.
@@ -712,6 +744,7 @@ static struct kunit_case dm_psr_test_cases[] = {
 	KUNIT_CASE(dm_test_set_psr_caps_null_link),
 	KUNIT_CASE(dm_test_set_psr_caps_null_connector),
 	KUNIT_CASE(dm_test_set_psr_caps_no_dmub_psr),
+	KUNIT_CASE(dm_test_set_psr_caps_feature_mask_no_dmub_psr),
 	KUNIT_CASE(dm_test_set_psr_caps_non_edp),
 	KUNIT_CASE(dm_test_set_psr_caps_disconnected),
 	KUNIT_CASE(dm_test_set_psr_caps_no_dpcd_psr),
-- 
2.43.0

