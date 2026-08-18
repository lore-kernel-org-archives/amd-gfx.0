Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F79C5DF81
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E568E10ECA8;
	Tue, 18 Aug 2026 20:22:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gQWAceUW";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65B6210ECA6
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOFMarfCMbh/Yo4UJUJ8ZR0uUkqsejwKtOVlZizpqaIgWGlsR4QJW+PflZKpBk4L2ErKc7dmPT+5HfVpW0ayqlHlj0B6afdByFI7Aen2WmLXntT+8nCZOHNWWewwSz72yacW1lqKH3fXhbswXORbi4ihCd88M6Hkhu5Jb2xvherSWoMnjXScbuZEROFG/rqYupg7/yye3J1/hRe9uzc014SL2/CpclwNiehCwzSKF409BsqlOAIYb1hNuc18XDgSFi4Fgj6R/x/H5jV6ugrMHm1kE1i9uKZdv13QoxsRGlrYAPElO2Wl7+23dmw3/r600HBy8/E8DuHQpxTbULFy9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjPr6+H4MXw94Qs7e6n20GGrqYpIzXy3Yp/Q8yNZihM=;
 b=MR4R+aUyIqGEDQZl7bkghe+UXu7/nUKvIvH+hZD1x+V2YIttUT48fAVid+cTHb38KmFQVHIuy4ixU+6Iho3fsZyXnq0XHm/oUcqJ1OM85g3dvhX4I9chiKS9QVzQiGYc+jQoWotRFao67Ctl/Au/9RJ6VyhhkNtexy1S1E4PqAxE4qOzj6EF7lA/OxxadtlqNzNsoiTPHS+pfdqUu/OuRK/OcFuyqsblD7baihL9+x8dyNZcbhJUG4MwISoPHxqBNyaVzk7CvcT3dydj8wHl/i5cGomiW3bag0gi+95vCFoERUD6VJQwx5PWiUSR+VNwWDO317OqAdAp+GEV/NJ1SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjPr6+H4MXw94Qs7e6n20GGrqYpIzXy3Yp/Q8yNZihM=;
 b=gQWAceUWPWtD/iZwigYDAd5wtRZj7QA5Gn0Px1I+NDcN/uiD4dxNxBz+btQpN0y0betkpCnlWocgIBbEHcRwCG239H4EHsQf0Mugx9m8WlThZRRmZbhay4fdTKjgkLq87GKxY/YwT0VNhljkSeYj1em6XPeqYn6xGWhPEi6nm44=
Received: from BN9PR03CA0568.namprd03.prod.outlook.com (2603:10b6:408:138::33)
 by CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:34 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::a8) by BN9PR03CA0568.outlook.office365.com
 (2603:10b6:408:138::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:08 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:07 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 20/82] drm/amd/display: Test dm_helpers_submit_i2c_over_aux
Date: Tue, 18 Aug 2026 16:15:12 -0400
Message-ID: <20260818202139.4172592-21-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: 42cecfb4-f499-4c35-78fd-08defd666fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6BVtD67RaaEoBMR7D/e3jIm+lK+Ig/77M8XGuF7kqc5yjuN9JV+nLjQCFQZZjk0/bzVvNk0JuC/KyQ7FBIEXb494A7NIYN9NpwQHzo3SuYv6XkGBwXNc9lR+qL6O8234BN5+pKUa6L41FyNQ+KmNdhb10vk5gK5fL0jF/vGHG1JGFlHkLT+G+xlF7Rx/Cunx2T0soVEkljNtf4LbD/1sQM4MmBfCAxZ+0BTPXB1tXoTGxkYIDNI5WSeEzNzDCVk0Tlr+b7DKaZC31dJzgoUuegt8Z1R59dyn3BgSG9nkCalJkiOSRGFacTW2Efl1+DnsaBcrd8nSVtfE2beg2wwckgxuXdqbbX2f80YC3piQI4stWuTqky5D9hAjTuasn5XjvvHvDH9Y/yf9bRWKTsl1yPxhy4XJeD1t+0qJiovmq8d7inuhkJID+Efp/SwRxmmxZsmSNg/o9Jaxn7gh+5nXNMAUZ5OzMdwPo5lvRm9zP0Kkj8DF2zvjVuiD3WAPYcjjBa4om4MM83I9l6vGJpq2Zm+fGR8JZKPWExhf34vIg3M53C2sxsmy2dDSEXz0AzUGZODFqLa+G2nctdCrCdSTX22SSwnTlSiCLC+MRhV0kgDsixpw8UPRZAPtjNrSX/GK6tRtDsWM20H2AwevHtspqIbL/xvrTsbDzEWfbeQY7VRW7JmLHMvYK0D7mr7M6uZFof7HnVgkZF9g7GTCJUCNxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6cdfilJcboAk221TpfpY7+YVvbe94nkqcpqPHBS7eHb14upsVrPny+Ro4jisOh091tgN5uAMZ1AaqyU+Ao3p0dSdx4ddqktt+U12aVnFGdFAY+yCkCaBOOu0HTbiOgAoMPySAgcDsW49WPerhanfPPhOneMGcN5jyNfOdTtpDINIOqrVuqJ532E+vFu/0flaoeNp+gSTzcXOTbnQd4yBa8GqS5LvZy5JTncUB9GnJEBrAT8RzANI0B2g9h3QETCYfo7TlCR92jGDLQvMekDGiL2NR5OBdRB/aS8hpCXCI629meDaOixOKZuShPaFqiIBk6hAtYXNPl5DbkP/2Kqu04fsdrp5hkzFK3mrjM93Qq4yqkxuUM8im7YYaxApS3U4hiqPpNLHXv8Z4J1ZKvIcXpcdjYAYamVIgiYW8WDtjUXJ057Bt9/ZUQwDJKzxA0xN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:33.8720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cecfb4-f499-4c35-78fd-08defd666fe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727
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
Add a KUnit test for dm_helpers_submit_i2c_over_aux(), which is still an
unimplemented stub, to pin down that it reports failure.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c    |  1 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c     | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index b05455498cbf6..29f254cafae4e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1927,3 +1927,4 @@ bool dm_helpers_submit_i2c_over_aux(struct ddc_service *ddc, uint32_t address, u
 	//TODO: Implement this
 	return false;
 }
+EXPORT_IF_KUNIT(dm_helpers_submit_i2c_over_aux);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index 6b4f6993ace94..0314ebb5c8aea 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -3892,6 +3892,20 @@ static void dm_test_dp_handle_test_pattern_no_pipe(struct kunit *test)
 							       test_params));
 }
 
+/* Tests for dm_helpers_submit_i2c_over_aux() */
+
+/**
+ * dm_test_submit_i2c_over_aux_unimplemented - Test the unimplemented stub returns false
+ * @test: The KUnit test context
+ */
+static void dm_test_submit_i2c_over_aux_unimplemented(struct kunit *test)
+{
+	u8 buffer[1] = { 0 };
+
+	KUNIT_EXPECT_FALSE(test, dm_helpers_submit_i2c_over_aux(NULL, 0x50, 0, buffer,
+								sizeof(buffer), true));
+}
+
 static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	/* edid_extract_panel_id */
 	KUNIT_CASE(dm_test_edid_extract_panel_id_basic),
@@ -4080,6 +4094,8 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_dp_write_dsc_enable_pcon_disable),
 	/* dm_helpers_dp_handle_test_pattern_request */
 	KUNIT_CASE(dm_test_dp_handle_test_pattern_no_pipe),
+	/* dm_helpers_submit_i2c_over_aux */
+	KUNIT_CASE(dm_test_submit_i2c_over_aux_unimplemented),
 	{}
 };
 
-- 
2.43.0

