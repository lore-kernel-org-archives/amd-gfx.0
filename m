Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF8DC5DF94
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 573F910ECDD;
	Tue, 18 Aug 2026 20:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I3diNy7Y";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAE3C10ECD1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfJItFlAPkkJfRYbi+DxKMPwM3lj0uaORwd21VfHnEzBlgiG+iuLt4Bx7aS5iHQe8N7w7+gvJ0043tUDmWVmUldhBjuOjBl/A1U1PYGotfWNeHnHgF4rifvov9tO/SlMZexymrHjkmdeSa+FhLxpVcpIvovq9mIAfBe6cn+qxAm85c9XeDk+3Flc2kNmtnjpRJj2kL0gyfTXwss98OPM6qzl+KS0O7uld7jNz7jICw6Dw9WqJZ85n6aQEMhOS4ydC+pEIzraHsMsZ7pkfFqXcTaliy+egvRW/iUPL8XMDCFElMP9SPjhuk8NjyfH3pvTSSk5te0E3cPD3Rgm64d3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4agLxi9axf5muacCRbP+w/okGPzGJlf4PH5vWZ7DQM=;
 b=LpjnsPD5ASJ6rvKNuJNTKQwMLz7VM9BTH1zexd/7TAFM1cejOIQRcCwl3b6i/nkE7Ck3VRQ7fdDmiJ22st+1NAK0xUQomcFg0ftbFqYHZs/mqo0XzpGmwtp59oyOSU6DyRT5DGhxEoDuXUYB7x0RDnaTwyqqVF1I4f2p9+bG1w3RL18P8k/BIHbbiTLZFexmwx+zhAssd8v6eDr70ITPDwEGQbH39hYt7g7yb7ETCCsNSA6kD4vhEhMoXopfI2KKhAXv6twPcLD31syCgyBoii4hjNosAdda2e0Y9K2AajvXEoQGAAxkKUAZN96WIS5kc7clr+DO+bGAR0Fiw0OIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4agLxi9axf5muacCRbP+w/okGPzGJlf4PH5vWZ7DQM=;
 b=I3diNy7YuKqACrRJsHiAbKx2YKuCtxBLT/t1JZBfHUIrBxSX9DIVXtBI7QvRd8evRNiQbsDmKwFG0IzlGIB9N8nEd1CM2C0Abyl53Gc7QyBYXlHFZ7DjE4unh/qbc4SlHJx8+4sAkthAm2tZlUE7a5JDbI77CA3J8lFKm4T2TNA=
Received: from BL1P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::16)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:50 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::52) by BL1P221CA0022.outlook.office365.com
 (2603:10b6:208:2c5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:48 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:48 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 73/82] drm/amd/display: Cover add_fs_modes illegal timing skip
Date: Tue, 18 Aug 2026 16:16:05 -0400
Message-ID: <20260818202139.4172592-74-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DS7PR12MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: c14b5830-f326-4c3e-2150-08defd66798f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /NBO01nfphoglGBXoUR0DlK5R+iCWcABrz0S5p+aOiM5K7zKA02lIULUvUZMl+QlFzXc0WLjXidMHFn0f4nPAnrHoldrK4/MN8K3qp6HQGunIsdb2IvZCCn1jz1Uco4Jc1XzCsO3gUyWoHHiXqCpkucC+Kb/+o1Bp4lVWQzJ8tnXl+OpBT1o0l6k2wJtTDv5AOlyboLjPspTbmNOD3wsNbA4vPObbFfL8PFXHswE4xNbXjYiv1JYckCd3djFc5z4C3qJb8EBG3JoOKb/5BhvjdSJC/bImNOPAJNYy5NRPgEE6n8qXOGExdizfGxbltEmazECp6KwCZltwgT0CvcnSvfjx9Q5MaSrbOxEbyhdUKoqLFeJtE/pqLw1/2oArqR7z68GufoaRhnDJWocfpnVQDoqDfLoUZBKhDxsiqemzD7Igyn63QCSa39vZ7D069dbWfDSMnmyWT+nqQrl5DL9zDbl9t8dbOpxWqq5Jsn+emwNpmabmp4a4SAs8i7JPy0wPfhCy0z1RMZ+L6meQbNzCoOmyb3UsPj0Nvtz+0IU9RlFk2sLzvs3vAWbzKTtvX+s7V1cBIOzLBGSNTsZiIP/7Re+el4CQFUhCYwgE1yCfRKcT7QYKVyjLCYqfcvMVnuWCegOkCPQqSeWqZbC34Aox06XG8mhRmyoxlRiplGGAC4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AQPoKiYgl6JWA7Dfm1+pQ6QqSZC/vGkByqtRfQxkqfTaP5Ud8pYHgwbxRfeMgMI8P6vzCYw4VGmB+W67OzyF8KSBmTVtZYxuqYqRK5vwzi1CcQLIDhue+U3pDK/E5fYbE5L5b/W/aeuNUU273nl3JkvA+QsyriPlFTJT6pr0EGxaM1jxrr+mwF34egwQwI9KgDGYvrRzvAIxo+BctGJrCAlwjWyRz1516bvoya93x6fh64nUfV0f8L2r73Rjj9tDKQJdrxKzIhM/fEQXMClmA3EKmygOivYgZ7cxz7kTeEHMU/vGjdMLs4EnjiLJNXEeWLhNqN0W0Pu2aOlHvpCLHzZDNtm4laSEnRI1ro8vEVsTIB0UtITykGI4GcfgEfIYWGI6ZALX1FSjVf9Sw7QZjkHKVT3Rtb/JYO425Wv11rXZLlPIcpWDp+czZMLTcvoW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:50.0673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c14b5830-f326-4c3e-2150-08defd66798f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840
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

Add a KUnit test for add_fs_modes() confirming that a generated mode
with illegal timing is skipped rather than added.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 988f0885679aa..5e5c372e9e01e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -5664,6 +5664,26 @@ static void dm_test_add_fs_modes_out_of_range(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)add_fs_modes(aconnector), 0);
 }
 
+/**
+ * dm_test_add_fs_modes_skips_illegal - Test illegal derived timings are dropped
+ * @test: The KUnit test context
+ *
+ * A reference vtotal of 1133 gives a true refresh of ~59.58 that rounds up to
+ * 60, so the 60000 rate clears the refresh check yet yields a negative vtotal
+ * delta. The resulting timing is illegal, so add_fs_modes() skips it and
+ * returns 0.
+ */
+static void dm_test_add_fs_modes_skips_illegal(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector = dm_test_fs_setup(test);
+
+	aconnector->freesync_vid_base.vtotal = 1133;
+	aconnector->min_vfreq = 59;
+	aconnector->max_vfreq = 60;
+
+	KUNIT_EXPECT_EQ(test, (int)add_fs_modes(aconnector), 0);
+}
+
 /**
  * dm_test_add_freesync_modes_null_edid_noop - Test NULL EDID adds no modes
  * @test: The KUnit test context
@@ -8270,6 +8290,7 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_add_fs_modes_no_preferred_mode),
 	KUNIT_CASE(dm_test_add_fs_modes_generates),
 	KUNIT_CASE(dm_test_add_fs_modes_out_of_range),
+	KUNIT_CASE(dm_test_add_fs_modes_skips_illegal),
 	/* amdgpu_dm_connector_add_freesync_modes */
 	KUNIT_CASE(dm_test_add_freesync_modes_null_edid_noop),
 	/* amdgpu_dm_i2c_func */
-- 
2.43.0

