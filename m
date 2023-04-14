Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C269C77B72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2C6C10EDEE;
	Fri, 14 Apr 2023 15:55:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DF4510EDED
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maSLLFri/ZFG7AxWGfunqLY1UB5xi75MHwgvVy1lFnfPWHLle6dD88A47Ymov/jlbzeg6SMeAYD9gI5dts8jxaYeMPHUl6bQQeFgctCGlyq3ENgaj2k651cXpIUPZQX5Yd9mj4jHG1IVKpytcag5LjY1g1ufmAUVygECD+xTQdDP5sd1qXLFAg4Hzv8VkcoKyv20296n7SqlwZJdEkDKFRb7cbOAogi9zX2H+5u7N3nKwUWH/pi4EFwrxDvjbr86jfyWufCdkPY22kTI/ySXrErAxV4Ofv+qxY4khYP+uOauKzTRoKzYBilpSVIhMhh3OrQiT0oTrHZj0t5L5leIaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiM44hrTYK2WHe7w6AgIlXgN1m5D5U9uSGYR0uGRQeM=;
 b=mbJsf7qiWaPfd4/nDQ+imomosnK/z3AKkzXeZ2CurRq+asDbM0e9UeBdsTlmE0+69ugxYisVmXigUvzVt6nKmsRamFU4bpxhU93L0WbIy0cBMy/qn/RorHaJbctgotDkUtBgjbiF+3vWVpjUcLvD6+T9Gfkx5DsJlRjRfhNeigNfW4fpcvgqgSEzGnjXnhjPpYZWpAfryejfBTKlmTGIyn+SNqDaO4whGCA4UHk7R4maNr43ZXN7IdcKss4//nWRYL4Ty+HX1WtDa76F8Akj6nWBK7P5UxOLsqNeNQlZ8FuxdxTqEV5Wi9RhnJC8lIGdXjlmc6y+BjUC2okKPe2igg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiM44hrTYK2WHe7w6AgIlXgN1m5D5U9uSGYR0uGRQeM=;
 b=DjnHWbI0JJ++1hTZY6vHe2JR/yE8X+lKhP8ZkSqSm58GP5xd7Wat7L/iG0KzE6uNqrM3PArp3t+iKs5LWJpMscBE/oooZDT8TgJd8jAtgKnXeTxJt4g/ppnYjhiXIdJYF8PTR6wGocffs/Ic3/YzJxGhlh5wMWuH5phLO3X3baM=
Received: from DS7PR06CA0020.namprd06.prod.outlook.com (2603:10b6:8:2a::21) by
 CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.28; Fri, 14 Apr 2023 15:55:12 +0000
Received: from DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::cd) by DS7PR06CA0020.outlook.office365.com
 (2603:10b6:8:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT087.mail.protection.outlook.com (10.13.172.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.38 via Frontend Transport; Fri, 14 Apr 2023 15:55:11 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:55:08 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 55/66] drm/amd/display: correct DML calc error
Date: Fri, 14 Apr 2023 11:53:19 -0400
Message-ID: <20230414155330.5215-56-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT087:EE_|CY5PR12MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da4717c-2ce7-460d-6691-08db3d00a145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBWl7QeATqWBmaY8nT9GT44gdXhuYFyElQio7qZJXOr+v6IaORotg4PrLENHO5a3+ay2L4pi1ku2SZMF8zFkxLhvTur+kFYo6jJkO8ZmRjoTaX7d6bzCSKHtM3/BnIQWMbcEdzxTdmKpy+vEhkfSZFUFCRJDMXjNOuQSPgB9pTV0hxsDftTPrLVhihLNckBmHB7VLa6Rsf8UrZEOzEtUhEOOAqPBVIWCBEPpd39BV0zVFgAedYHHQCHc9/Sb0SjqIkbpvulS2SYNTCyTZRLhjqge4q0ibcBMRfOCrYidpNOmOUYveUvBahmjK4LOP8VvwgOKTqAygW999SkGQbemEkJk92GHp0GP7TAVW7vVIm9Ax4H5zaTh4C/CXxLz3sQvS8Zo4jYqHrRGDDoBLEWnaP/fu1ssoE7f34qXM0tmo7zi8rjXZK2wNtCYtT6UC1A8EMHn7AHq63B5ICFxbxSMaKGBmbJosTkhtflINz6aUqVSx5QqrGTpsdGh85s/Bq9EgKsWFPg5RYrU3fhgcGyVLm+S56uR6/pZWivzRC/sMk2wKeXprZW1/FZQF3P18cTO8t+V4ZWB8hsnYellgkVFA4cSw4B4zhd8vi6pdQ8h63+ckjmxsdJh6A/V3imGv9SoTEgh9+1WTCYMBQlsZQXQKLAJa1TXmM2oozoaAi4DmCqPrZtHK2k55G24RZBg0fEoqSv6ZOXBKBrc9HpopFqfeXQgeNZqaqYt0teb62ieD3Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(82740400003)(478600001)(82310400005)(47076005)(83380400001)(356005)(316002)(81166007)(36756003)(1076003)(26005)(16526019)(40480700001)(186003)(36860700001)(336012)(2616005)(6666004)(426003)(41300700001)(8676002)(8936002)(70586007)(6916009)(70206006)(2906002)(4326008)(54906003)(86362001)(5660300002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:55:11.7250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da4717c-2ce7-460d-6691-08db3d00a145
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Sherry Wang <Yao.Wang1@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sherry Wang <Yao.Wang1@amd.com>

[Why]
DML calculation is different from HW formula.

[How]
Correct the bug to keep it same as HW formula.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Sherry Wang <Yao.Wang1@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c    | 4 ++--
 .../gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c    | 4 ++--
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 7d0626e42ea6..dea2b84e5ebe 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -4939,8 +4939,8 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					}
 					v->TotImmediateFlipBytes = 0.0;
 					for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
-						v->TotImmediateFlipBytes = v->TotImmediateFlipBytes + v->NoOfDPP[i][j][k] * v->PDEAndMetaPTEBytesPerFrame[i][j][k]
-								+ v->MetaRowBytes[i][j][k] + v->DPTEBytesPerRow[i][j][k];
+						v->TotImmediateFlipBytes = v->TotImmediateFlipBytes + v->NoOfDPP[i][j][k] * (v->PDEAndMetaPTEBytesPerFrame[i][j][k]
+								+ v->MetaRowBytes[i][j][k] + v->DPTEBytesPerRow[i][j][k]);
 					}
 
 					for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index bd674dc30df3..330b089d6a86 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -5274,8 +5274,8 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					v->TotImmediateFlipBytes = 0.0;
 					for (k = 0; k < v->NumberOfActivePlanes; k++) {
 						v->TotImmediateFlipBytes = v->TotImmediateFlipBytes
-								+ v->NoOfDPP[i][j][k] * v->PDEAndMetaPTEBytesPerFrame[i][j][k] + v->MetaRowBytes[i][j][k]
-								+ v->DPTEBytesPerRow[i][j][k];
+								+ v->NoOfDPP[i][j][k] * (v->PDEAndMetaPTEBytesPerFrame[i][j][k] + v->MetaRowBytes[i][j][k]
+								+ v->DPTEBytesPerRow[i][j][k]);
 					}
 
 					for (k = 0; k < v->NumberOfActivePlanes; k++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 7eb2173b7691..27b83162ae45 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -5371,8 +5371,8 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 					v->TotImmediateFlipBytes = 0.0;
 					for (k = 0; k < v->NumberOfActivePlanes; k++) {
 						v->TotImmediateFlipBytes = v->TotImmediateFlipBytes
-								+ v->NoOfDPP[i][j][k] * v->PDEAndMetaPTEBytesPerFrame[i][j][k] + v->MetaRowBytes[i][j][k]
-								+ v->DPTEBytesPerRow[i][j][k];
+								+ v->NoOfDPP[i][j][k] * (v->PDEAndMetaPTEBytesPerFrame[i][j][k] + v->MetaRowBytes[i][j][k]
+								+ v->DPTEBytesPerRow[i][j][k]);
 					}
 
 					for (k = 0; k < v->NumberOfActivePlanes; k++) {
-- 
2.34.1

