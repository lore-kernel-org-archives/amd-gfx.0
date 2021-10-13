Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62E1C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 03:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 655D160F94
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 03:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 655D160F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B94C06E07B;
	Wed, 13 Oct 2021 03:11:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28AC66E061
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 03:11:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0iWN6dzb0ahMfFeEaE5ttovrco6rjnM7EvkefjWrloC4DRd5Dr/2a2/1or19zdOCwm28q0vGGBMaQdYZHYJpSnMBOY2V3SZBD61HWy9riQAUAzr+kaOhJBI3LbEBDUyRHczRCv88kX92Psx26UXn7lzG88Lnva4TPgp0oYJptw8VxFROjrHs6mPhkAOCRodEi+ciMo4v5NnU94Ms7wHQlqhKuIH24TpsUQiNGq7Yjr4J36VYINncR34XHlATMpKyZgGxmIIVLZFEV1Tkix1Q6hw7bpyjl8Xqb9acppL/pw/beOMfbBvjhU0V6c9fDAQVDRPi/wzjmCyZ/Ae1NPtxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lc/iyO4maBUcAsXD9LNkA1Pt4FYT3hmwQMODhHqMZL4=;
 b=XBXOPLXbF9wkL+eJPyKdvq4mG6Vwvq3VgttbNxDfKpAolpPVbc8Ya2Y4lejTbPe68itWwqCvus2SR0c8pzlVTHCfAES1sgmzpu0hbGq0him7VMswvvz01n1rniFDu6MUqGeC0O07/MlCeR6wEtqlgBl4uWda4OSDvNhIcl3O1N5ZpECluKI+pdKNDvfNm1R6rBV9C0SHih78RKGbbmD0AjsXlvfj/WIsNSaNq2Q52iTaP4RDY1rTV9pYq0XKNcpBJ5arRwXlH6xoiBCcmyae7zuAT1PIwOptS5qW95QdERyq4QGiAAD2Z9XtYqLvlYOGvBbmP/Why+nrwnD8C7QN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lc/iyO4maBUcAsXD9LNkA1Pt4FYT3hmwQMODhHqMZL4=;
 b=exV0JIXiIoOzELD8isqkOQLzwfHfK8AyoWNxm2fGS6cmvKTAdNIbsQkA4XNUKOy9WEXYZMx80DiOuUmXuiLXRKDdaPdYBXrt1SmlKhFwKXYCc9cP3LVmsnYCoUBli5HrFCCPcJEI6J7W5VArN8oQJ630ALOYiS7XEwrPQ7K5/Is=
Received: from DS7PR05CA0027.namprd05.prod.outlook.com (2603:10b6:5:3b9::32)
 by SN6PR12MB2608.namprd12.prod.outlook.com (2603:10b6:805:68::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Wed, 13 Oct
 2021 03:11:00 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::87) by DS7PR05CA0027.outlook.office365.com
 (2603:10b6:5:3b9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Wed, 13 Oct 2021 03:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Wed, 13 Oct 2021 03:11:00 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 22:10:57 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <Alexander.Deucher@amd.com>, Luben Tuikov
 <luben.tuikov@amd.com>
Subject: [PATCH 1/5] drm/amd/pm: Slight function rename
Date: Tue, 12 Oct 2021 23:10:38 -0400
Message-ID: <20211013031042.53540-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.33.1.558.g2bd2f258f4
In-Reply-To: <20211013031042.53540-1-luben.tuikov@amd.com>
References: <20211013031042.53540-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a554fa48-7fbb-42ea-ed92-08d98df71529
X-MS-TrafficTypeDiagnostic: SN6PR12MB2608:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2608DC5B4A54506A9CED86CF99B79@SN6PR12MB2608.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPjTj4H74AWob5PURdAOarNlBy8HcErpy3px11mWo9KkrymmCisXNTLskcgHKYSBTRqrEpsMPAlArQnNpyjSli54X/y0eqJMjQGB9O60nGjU5PIM7nFoTDSSZdZ7T7uXY6b0Yd42Sp0mVZ7nMgUHWLvp5OP8sVENjWWdi2zKx73b0/BzuXezgyCnxZF2IGNlJP0QQIFvLZSrvzEy6HHRUd9HHGK+WaIWh+wVzTC+wNYiM0naspdLdjhfRhZhnbjTTzSaWh7yObWTuFb68llAmgpqz632bOnkl1QWoee3NumpFYxsBO3uEH84GegOPINfAdeuthzIFDp3eHFel//8dH1NEnSWapglMBUN803+kCyzHaWymTkBsv81s9JF4YY8ERyXqMtFGqZUziJs7yikyM9oRQ4HzxPVlx17SBVw2l5DaLi/lvlKG6S15tpLvNkpyln3Vkaw+r4xPouIzufkIZ0GsaqabT/reY96vdxw6MAfjOW8tc620YXq/6o96jU/2il9rpgxeYvfwpos9qK+PPNelre6aBHgvtBZC+ffh4PvH7lcEjT3Q9ncSuOf9N8RmXDtacdeVa7rbfS4quO4w7WQHb2EJU+8AtRGZrcBx4+5MHcwl9yvQ1IFF3JIiDDMAOYUiFpdI6qytF6wZOSvagMg5UZpubntyABS29AxU3aKaKpMfDf+SrmEwZeTZyznPK7obuZfdvT2fO/Yro4whH6DJCedfNpJ4To61DjVhvI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(86362001)(81166007)(356005)(82310400003)(5660300002)(186003)(7696005)(16526019)(2906002)(316002)(508600001)(36860700001)(6916009)(70586007)(44832011)(6666004)(4326008)(8936002)(70206006)(336012)(1076003)(54906003)(83380400001)(36756003)(8676002)(2616005)(47076005)(426003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 03:11:00.0344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a554fa48-7fbb-42ea-ed92-08d98df71529
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2608
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

Rename
sienna_cichlid_is_support_fine_grained_dpm() to
sienna_cichlid_support_fine_grained_dpm().

Rename
navi10_is_support_fine_grained_dpm() to
navi10_supports_fine_grained_dpm().

Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 71161f6b78fea9..0fe9790f67f5af 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1231,7 +1231,8 @@ static int navi10_get_current_clk_freq_by_table(struct smu_context *smu,
 					   value);
 }
 
-static bool navi10_is_support_fine_grained_dpm(struct smu_context *smu, enum smu_clk_type clk_type)
+static bool navi10_supports_fine_grained_dpm(struct smu_context *smu,
+					     enum smu_clk_type clk_type)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	DpmDescriptor_t *dpm_desc = NULL;
@@ -1299,7 +1300,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			return size;
 
-		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+		if (!navi10_supports_fine_grained_dpm(smu, clk_type)) {
 			for (i = 0; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
@@ -1465,7 +1466,7 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 	case SMU_UCLK:
 	case SMU_FCLK:
 		/* There is only 2 levels for fine grained DPM */
-		if (navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+		if (navi10_supports_fine_grained_dpm(smu, clk_type)) {
 			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
 			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
 		}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 15e66e1912de33..3f5721baa5ff50 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1006,7 +1006,8 @@ static int sienna_cichlid_get_current_clk_freq_by_table(struct smu_context *smu,
 
 }
 
-static bool sienna_cichlid_is_support_fine_grained_dpm(struct smu_context *smu, enum smu_clk_type clk_type)
+static bool sienna_cichlid_supports_fine_grained_dpm(struct smu_context *smu,
+						     enum smu_clk_type clk_type)
 {
 	DpmDescriptor_t *dpm_desc = NULL;
 	DpmDescriptor_t *table_member;
@@ -1084,7 +1085,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			goto print_clk_out;
 
-		if (!sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
+		if (!sienna_cichlid_supports_fine_grained_dpm(smu, clk_type)) {
 			for (i = 0; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
@@ -1235,7 +1236,7 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 	case SMU_UCLK:
 	case SMU_FCLK:
 		/* There is only 2 levels for fine grained DPM */
-		if (sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
+		if (sienna_cichlid_supports_fine_grained_dpm(smu, clk_type)) {
 			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
 			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
 		}
-- 
2.33.1.558.g2bd2f258f4

