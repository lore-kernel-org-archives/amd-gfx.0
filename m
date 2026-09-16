Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB62AC982D1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B047710ECC9;
	Wed, 16 Sep 2026 17:53:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="16CLW64S";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010015.outbound.protection.outlook.com
 [40.93.198.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB2E610ECA4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClOx0pUkRuK8ZWjMXucXSMPviOydgXHS7HZBl15OxQb8ylzkkLx9LfWXUKCMAgn5YKlA0KJdmxxmOz+hirHHclr6KaI2GzunW9d7kBszvVRD1lnUFaOZlUZuud6wldjC1rDDOKB3fW6gYCmQSR53qlKt81Srx+Gkg0Zjbjh41S1laApkDSDrgzk/GvD09ZJRXv2ROqDlqyImCQxIIK2sFOItTwqhenTpPU3k8KtUSmBQzNagscWDe6vBz8Nv0xcD4HiGDy30W7m/i2K39SzkS3MU3Wzb8FUu/25sJVwmBGQfumu/gv72+xEeWx/1uFnOINGsLdzsYLXVZkBak1ORWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAXg3b4XperM0Jmpc6OqGXbXRmFTRMQZkSd0vOI+nSA=;
 b=YO5IwmUczN8xF3tj0O92yW5onBifTJCvogAPXG/Zm+xGfD+59vq+CXyHUElnjTom9wUuoT6arCRpp7UFimjWZ/X4obroqVxt2Sna2ATlManU7ZD4eQD8y7mVGeOmz1FsxLH5hYXIVSFnwm7d6GP9uUbUV9ViMX0AU/PW9Etzn0z3EPDkQTy/Jfz4H34QGTMCBy1iIdgPrrA+D/BkJFsJe12b76OqPkTPn39JX9/vCHGzyHISq9chLIIMChlagF+TaHqRa0+Oi49had9jRAEua9D4Mf7VPogiNMh4PU1R5p1vhicr9mecMlO1klJKkR9AKntVew+NXMBl+oBErLcG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAXg3b4XperM0Jmpc6OqGXbXRmFTRMQZkSd0vOI+nSA=;
 b=16CLW64SUOCzhBuhPwwdj8/fQpbz8x6fqXUP/EdkkncvWWIllFHJGyTYodNpu5H52bm+ymbLOAnxP8dHfQU8egX5MvZRR4LJpEW98HVsX0mQ00sGjD4Ptynrt3CfLIAWeJ5wJkdb3umBxWexGz603i2xAufbRpjzdS9eXDpIwfA=
Received: from CH0PR03CA0188.namprd03.prod.outlook.com (2603:10b6:610:e4::13)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:52:52 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::21) by CH0PR03CA0188.outlook.office365.com
 (2603:10b6:610:e4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:51 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:37 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 31/64] drm/amd/display: Test unassigned OTG CRTC lookup
Date: Wed, 16 Sep 2026 13:51:46 -0400
Message-ID: <20260916175301.368306-32-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 35693110-5118-4cb8-7f2c-08df141b5443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|22082099003|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: FE/ugK9bc2cC0kUwjxWYO35Og1xVC0gfABLv5okiqaLrP4nIjHiJnaAbui+7glyFeyq7Uc0Y88RNC2kQTJFq3rN3zmIVZ22AzHtbq0vhy6h9q29PbP6rVahz8rYXYwPopMKqG3NzAV7uFgcSjo8QVMcOTzH6wu0xXWHIUULyM+W23P7SY+xZtVAhqBLxzcmCJVSNZYkSsqD2HaiA4azc0E3p7bZneL4iQt8PLWC/WIOO7EyOfhvE3txg9x6wHJCgPJPPhVfHm9ZnTibDywDCaFJPhW5+7ZKMU98OmWYflsIQlJYfDHNSj+ty9OBWg2ugIYEkYW/HnpKXkwty9f48+xm+5Od8Bsrksw7xJpQ+rCrKMyQtc3JZcyLIJklPUgOoT0Imw12npwoVUL07q2iPqSED4Birv2G6Gpjw/CTKGZ2OHpHlcnVKs35iGBZ1/6ysGdK8nNc2TBei78EWy77UsCLSyabfdfkNp7hTZeUf8malZPns+559+K1FTFHwNPBGVuYnaitmJY2iAObl0ekgYc3EffwiYcLm5pjU3PfcvyEMvxjqMElRZU5YoqNXlAwkzi2YiCmdcRIFtQtD0f8/hWMv8y7hGWoJ96/20873JFxxqLg1sw/VFrqitingI7mcRJ2sHDHB2QiF8rBjW6u7itcxcTBrcwCkwJ+ntLUxvzaoRyCVaM695iID7JigTuVM3xIYfqIFnlJzPtO/0dnRxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bViGWpFE8kjkZbmpHMNsNT2qwnnHVoWbN4FUaKhOXZg1qINwrSnme3KWin6mpPzOe9OJ+Tqf2h8BUyMWVfIBj6xsJjQRCdKRFDDs+DcnIJ24RPntwyc4wTN2/PT+QnbS6zbdBs2iZDs2uhkrJ8y3p8qbFw9iMC5NGJH6KFqD5dRYtOVg3agOLV599GZdX6TV09LuM//6xv+1+1TpBtMGjYBkZGH9/nQrgFCtR65UZge1ubWonijtA93ZbvVegAVTRFr99ZEmfSBRZP9FKzwbacdQSIduENY/O6+6z8i6qnQ0nCxzogZyPAqxCZukHwsA302kOK6lA3+QEH4eZla9VRmoeyjZf7WN0wstqTBX86kDKRwKbKP2V5Dn9DXRgYNheF5hMxtrip+jD/W3gOdKBOJG61IKFqMXzomUTC+3HEsNavNZoB1KIkgCn19xPNtr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:51.9728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35693110-5118-4cb8-7f2c-08df141b5443
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094
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
amdgpu_dm_get_crtc_by_otg_inst() had no test for an OTG instance
of -1, so its WARN_ON guard and the fallback to the first CRTC were
never executed.

[HOW]
Add dm_test_get_crtc_by_otg_inst_unassigned_otg(), which installs
a CRTC as mode_info.crtcs[0] and asserts the lookup returns it rather
than walking the CRTC list.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index c1b5c442ad0d..28b1eeefb8ec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -1301,6 +1301,28 @@ static void dm_test_get_crtc_by_otg_inst_empty_list(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, amdgpu_dm_get_crtc_by_otg_inst(adev, 0));
 }
 
+/**
+ * dm_test_get_crtc_by_otg_inst_unassigned_otg - Test CRTC lookup for a disabled OTG
+ * @test: The KUnit test context
+ *
+ * An IRQ that names an OTG instance of -1 cannot be matched, so the lookup
+ * trips its WARN_ON and falls back to the first CRTC rather than walking the
+ * list.
+ */
+static void dm_test_get_crtc_by_otg_inst_unassigned_otg(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	adev = dm_kunit_alloc_adev(test);
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	adev->mode_info.crtcs[0] = acrtc;
+
+	KUNIT_EXPECT_PTR_EQ(test, amdgpu_dm_get_crtc_by_otg_inst(adev, -1), acrtc);
+}
+
 /* Tests for amdgpu_dm_set_irq_funcs() */
 
 /**
@@ -4865,6 +4887,7 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_get_crtc_by_otg_inst_returns_match),
 	KUNIT_CASE(dm_test_get_crtc_by_otg_inst_returns_null),
 	KUNIT_CASE(dm_test_get_crtc_by_otg_inst_empty_list),
+	KUNIT_CASE(dm_test_get_crtc_by_otg_inst_unassigned_otg),
 	/* amdgpu_dm_set_irq_funcs */
 	KUNIT_CASE(dm_test_set_irq_funcs),
 	/* amdgpu_dm_irq_suspend/resume_early/resume_late */
-- 
2.55.0

