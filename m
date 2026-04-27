Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F24FF8868
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 17:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E1D910E870;
	Mon, 27 Apr 2026 17:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n0+n1mZr";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290D110E861
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 17:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrDNr8Wk2M4u3K6trgJK0aPXrvMt73DSlWvozs53Sa29iyiOsxycMHm7as3I3z05cEKxZY3ECkWo5KjJjQGLrCEFFMFablMwMtsZA5+DVR1TTMdeE7UQG+dWCLE8APr38QsWxr3iZj+lkFi3J65/9LFOA/a7Q2pOf5lM9yZj6GnQz6qh+9DXIoN7MFRJ+F981pP7+4KU4JWdCbWfI1EqU41WTAEesa6dmZEGF1ylA0BZ+6Q+nWOEV2x/kMv48YxsKRnzC+PHfAEZceE8wiAMBbqFQQr9pjqHkjPGK7C+NsNLffyT5YfzzKyC7AT31e0PrkoBCE4iVYQp/PgrVTDj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSybM06nE4uJjlGIUmO6n960r49JjJs8iDExvrKIqUY=;
 b=G3tbslSJuepUwVyoxT1D2xoS1yzhiQ9LBlMs1rhD6E4b9gXWJNb4j0cPg/iFVSAd50tlSNIoH6F2az5IxCpAA9W48jWAf0bycvlAiZJVEPu8yMFttk86MhqG/zI8IwOpnAhvwJxcdWRdli/yk43IO+R+ARwajB3dSucSXdgBxa3R7LffimRoGWKbb8wk7hXbNN1DPdkUaybfXxEf9WO7g2Q6N8JIRRUTnnITHDeY25vBEnajBEOXKTLqsO0tdqcdbNXb0faYNS+eJbjubqQ4Ro6b2WKqLsCMjU/5WXqQ1d2phekSA2ImquDLVJ501lyeXXmzswpT8EKVsWvSjg3bjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSybM06nE4uJjlGIUmO6n960r49JjJs8iDExvrKIqUY=;
 b=n0+n1mZrM+PzDoJpyHisOMjRowdwzL7YTp2UezGNteZc86AUq2gd0ek6nvQ/QrowwzSTo3qIwSUFxxaxYBa29MI+R7cDHdqqNB8hzmGle/tAwrOuy/UfYYnnIK+C2Dn9f2EERalWCQHaJOPyrRuH6te8jyPGLv+BlxKwQouIeWQ=
Received: from MN2PR22CA0010.namprd22.prod.outlook.com (2603:10b6:208:238::15)
 by DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.15; Mon, 27 Apr 2026 17:31:31 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::d9) by MN2PR22CA0010.outlook.office365.com
 (2603:10b6:208:238::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 17:31:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 17:31:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 27 Apr
 2026 12:31:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 27 Apr
 2026 12:31:29 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Apr 2026 12:31:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/radeon: add missing revision check for CI
Date: Mon, 27 Apr 2026 13:31:03 -0400
Message-ID: <20260427173103.1020723-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427173103.1020723-1-alexander.deucher@amd.com>
References: <20260427173103.1020723-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|DS0PR12MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: ab3d5118-5553-4f4a-1dd3-08dea482d25e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FDhcmH5BZfeBwicsJtMUDn0Az5+IQlsNybt2wHx2hJQx1H3eIU5NI1ZZvqojKKBoRSDRu0R1ROX8FdGP4pPhtwP3pf/eo6jqpoxD3qHSWn8bCquNJhSyCpjbt97iFHdnHMGfkKmoZ97QEyqAmZ9f1rCf3ATmj7XboXfZKyjU3K8D8TycDe8BJRIFlsOElqIo2+1DT9JVdalpZOMbx9/3ve9pYYnvSod7lvQIiJDnRASb1bMZ4WQ32Xw9Q0I9U/PJe2U79BdtiqI74tdwQaO8oWJS/TsFJ/b59GVXVJa0jGIbM8JKgur6t+dWqwMi9teZN+uypUg6ZvTzc+w6d6NNWoVqiNfSTb39bj7mQQfpSfCWUs4c2BEnj+TVFCdYIzx4CpvKtjHh55YwBNTTUbqzmyOHikbNb8kSIKFTMtPBBqS84AuW3/4yk8WSnP7x9A8AHiy9A5eCC8lL/ziwPaJP8VMZaDUpQndt2JpER3HD7ziTplLRrpHV/kWJDmeYC8w+DcSh8/jGf/kZ9dvvq1aJqgcGgD1GfE/oshEC+OplGwnsNBfEblSbdQs4+pDiiMuDFUwLwN+d/3uingdjzZamgnWPeON7ObokCMwwrQ0FFmo1NPKYd3wDN5q5E4jCuDv5UbkoABoR8RfiqNrfSHA0KPKGaO3e1JvCan1MRDQzMqcxDWShQrwxudM5HxY4/Sy7zTUrj1urG8xd/94e773gY2ILAV4iw+r6VSWJ6fNUqC26vkOTWnliR/mGtgquAlHRj4TwEfE8lG4GULh4F8UnYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qd80uQ9JIfsJcgkVV8YkGfzoPdCavMP7mCTa7a1VhBnLW/j8amqVqnij0drUy9Cfhdm2/3mqrSb+o32/0KRvOvFXyKfOn8gcQq7t8LP//NqmtybcDXNdhijLq/e+xF6OypCfPA/bw6FsAAoWIcyraj3SUnqQgKyJLoH+ys+fF/sf0IdOXxXAYTNc1xdobcPCxk8ziVQTFZItSFfOH/JPVyDZ7KlrDislIGwYvWz1UdGCzJsCp/yB18stBKuCvFTeWooZvUiXm4B3QiKjK6aC21QKq3UmPzYzjVheEAW3jO7Uykwg3B9otUyV/dYJ4DVkJ3dcPyCMHALbvQKFUm4qWfubfzrFozyMx+F+9ixn/V3Q6bIrbLUYozdfhH9eXLz7p/ENSab9cdNePdJ8v6mwByggdoelmJKnZC9fBlkL4OcH9HaEuSCFEq/TB3Egpsjb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 17:31:31.4826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3d5118-5553-4f4a-1dd3-08dea482d25e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069
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

The memory level workarounds only apply to revision 0 SKUs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/radeon/ci_dpm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index ba8db1d07c070..b47b91272b244 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -2461,7 +2461,8 @@ static void ci_register_patching_mc_arb(struct radeon_device *rdev,
 
 	if (patch &&
 	    ((rdev->pdev->device == 0x67B0) ||
-	     (rdev->pdev->device == 0x67B1))) {
+	     (rdev->pdev->device == 0x67B1)) &&
+	    (rdev->pdev->revision == 0)) {
 		if ((memory_clock > 100000) && (memory_clock <= 125000)) {
 			tmp2 = (((0x31 * engine_clock) / 125000) - 1) & 0xff;
 			*dram_timimg2 &= ~0x00ff0000;
@@ -3304,7 +3305,8 @@ static int ci_populate_all_memory_levels(struct radeon_device *rdev)
 	pi->smc_state_table.MemoryLevel[0].EnabledForActivity = 1;
 
 	if ((dpm_table->mclk_table.count >= 2) &&
-	    ((rdev->pdev->device == 0x67B0) || (rdev->pdev->device == 0x67B1))) {
+	    ((rdev->pdev->device == 0x67B0) || (rdev->pdev->device == 0x67B1)) &&
+	    (rdev->pdev->revision == 0)) {
 		pi->smc_state_table.MemoryLevel[1].MinVddc =
 			pi->smc_state_table.MemoryLevel[0].MinVddc;
 		pi->smc_state_table.MemoryLevel[1].MinVddcPhases =
@@ -4493,7 +4495,8 @@ static int ci_register_patching_mc_seq(struct radeon_device *rdev,
 
 	if (patch &&
 	    ((rdev->pdev->device == 0x67B0) ||
-	     (rdev->pdev->device == 0x67B1))) {
+	     (rdev->pdev->device == 0x67B1)) &&
+	    (rdev->pdev->revision == 0)) {
 		for (i = 0; i < table->last; i++) {
 			if (table->last >= SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
 				return -EINVAL;
-- 
2.53.0

