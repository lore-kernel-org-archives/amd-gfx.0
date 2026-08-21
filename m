Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97067C5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 22:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F00AF10E283;
	Fri, 21 Aug 2026 22:33:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xclw6BYb";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013040.outbound.protection.outlook.com
 [40.93.196.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BAC010E283
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 22:33:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKea11E0uHx7XNOfpL1niwje/hDL6st0IZgpS/3dGR16i2qI6+gpGISZt6tWg8V4JDVHkTE4YX+qMP/ZBWI0dTuCrQzYicTcz5a4zQP03cRhdJrgIEuAFMBaoPPhDN9uoaeXX7ilw1zFyFUSKgtaTOhAmzxIrsXgoBDLX7K0C8cfVojZWOh9zMu3Z7o1NT44AgvOZFlmWyKtyjL7/uK/nMQJWqeI/Uat1zqZdBh/JxTDN9frF/0Oo1ME1mZ8hZ3krxTAURFOChlutShVSw+8XkC6FS/e+HY7MTu9h8Ga1Tg2CQtYiiRizjgNFlkGxdcMkwsfmtiiJjAcws2vjVCNow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFegPYK2tF4oFrRgayvMdJUmzEhuCniNCzcM8m2BbI8=;
 b=kX+gIs44BnEMSkDR6nQVHgIExt1nPB+fAP51TMwaRyiMqpqlxiPEACVowRc9+OCkBPWvw0YoMS12gbHEysR4m+lQieBfgl1Fd0X099jdipevNRtNO3hp5o530RmKhsSXWxc0b10nDlAU/jYGT9mN1zWgkDmzySkUmzrYq9EK7KDCyZhRTL0MD4V7FVyK4aYbYt9vpnbs3xZ1z5bHfKjt89HlrmaOz3DDd3jVZh8WO3jf0OcBGky0JhHVPIsrgbkAjJeBt7Ktv/JNd4CQSNOTHZXxNo2Yncpa8eQS8qV7xJODGpy16wabxbaOFtzwOJTdxafj/ZX5sC5+R1LnWqoj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFegPYK2tF4oFrRgayvMdJUmzEhuCniNCzcM8m2BbI8=;
 b=Xclw6BYbVzxlvcaW02dcf0oXR5oAcxVnIdvY2Zf72t6Qlm3gGhSzQ23MdBECW5/2gpl7ji/AiyVdgdaW7LipH3jiO+Qzz9JO8yOtBkyyCzn1hLszQjgzQ0PePn1dm0FPiVUWRce28JNbP5M8Dz9gHvr3cpcX1vV3llJPrgnIejk=
Received: from DS7PR03CA0295.namprd03.prod.outlook.com (2603:10b6:5:3ad::30)
 by DM4PR12MB6447.namprd12.prod.outlook.com (2603:10b6:8:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 22:32:59 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:5:3ad:cafe::e) by DS7PR03CA0295.outlook.office365.com
 (2603:10b6:5:3ad::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 22:32:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 21 Aug 2026 22:32:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 17:32:55 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 17:32:54 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Mario Limonciello <superm1@kernel.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 "Alex Hung" <alex.hung@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH] drm/amd/display: Bump frame warning limit for clang builds of
 dml
Date: Fri, 21 Aug 2026 18:32:51 -0400
Message-ID: <20260821223251.692196-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|DM4PR12MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0ee54d-dd99-409b-969c-08deffd4258c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|13003099007|18002099003|3023799007|56012099006|10067099003|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: lekT9+fmfvmJGcsd8/mrMdc7Sj8GQwxg0+mKQlLlo6flKze3Dxz2LzAfqJ0giOiprDAl+Yni26cnbF9C/mecVIn6UuqeQsm3Ml5ylM98lWgra/2or/5Q3EG5a73lSbHV7uYBygl33gudQ8e0LlTGt0znH/6CjcT9lusapeAXWrOm3cIferwOZmYzl40DP2gjtua1iC25SUBoxfkqI13tOynot6RWbinycSeBHCY/gNjFQdsGptzS09hzEzhCW9yLFBYM1FzMnEhrlDXMNbykO45NM48xdlZxzudYYKvnYLwKF6uZl2MbpbNwImMd8FPrUmwmILb7vct745+sTWtHcMOzkrR2jlWhC7noFRSnysA/TLqL5zN3UVFzu8frq//DPiRXwuBVGzeXNbQz7n2bWJ341P9PcotQ8RGUCkIaiGiwj3LhFNREbArG00+V1/zDr1mjYJR00nncXqNnd948QIERCTMJ8L0xVN7O2rLhaMzF8v2XetcxXjoDrXZUVZHX0x+qVF5U1iKXz4c0VvhoRrr+OYua7vUS9L371IgdahVA0rN6KaTQoV2fo1wG9eKCeH+VkfIHDK1cn9nvyQXnZGUrxdwbeQnp03fPz5g6zdPO8uBF2L5LZnAaUbneZAoIPu1oRj/cTowGPBXMoMEu6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(13003099007)(18002099003)(3023799007)(56012099006)(10067099003)(5023799004)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ShHT6q5s0CyblnSrzNdPm3Ph8e2Bpi3zWIWRkFF9uoOuZFhz8B9uAN1d+m8Yqm8piPxiorb1d4Pg2iuqPLQA8JXPRcroe9IgAW40Oo/9Iz2kKk2EYP3sUkpka1az7Yguduaf/MhPwhSKpyzJThWrgZvVHyzRfChH7GT3KEr2WH8qh7xdEAGwHM0rCwg+8dhva+tFjAbZvjmgROfkC+/8ZK1QY2CL6RERsXO/2jiU2uVtXb+dYfnu5nul+OOBTtsTms62mH8mx8r6tqLD4oxlXPdbe6hcPeMcHhpsHwohZZ5JqnobIxKkFAarge8VVWpvedJ14etb+rt29YDxIPoRh/iN1rYWO5MLjgFXwJobQrWs4yNE56N/y1lq7j0F2l5dmCdS9AnlPPkOip9qSXzEi9qPuCTp9DVBMxcaZClR8o9X4t0zUsD4oeWIf9hV6Oel
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 22:32:55.6409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0ee54d-dd99-409b-969c-08deffd4258c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
When building the DML files with clang without any sanitizer or LTO,
the following -Wframe-larger-than errors break the build under
CONFIG_WERROR:

  display_mode_vba_30.c: error: stack frame size (2512) exceeds limit
    (2048) in 'dml30_ModeSupportAndSystemConfigurationFull'
  display_mode_vba_31.c: error: stack frame size (2416) exceeds limit
    (2048) in 'dml31_ModeSupportAndSystemConfigurationFull'
  display_mode_vba_314.c: error: stack frame size (2392) exceeds limit
    (2048) in 'dml314_ModeSupportAndSystemConfigurationFull'

Clang consistently spills more than gcc, pushing the frame past the 2048
byte limit.

Apply an existing approach of increasing the warn stack size to the
non-sanitizer path so plain clang builds use a 3072 byte limit.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5642

Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 10d4ace04d4f1..99da9dbd62b75 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -36,7 +36,11 @@ ifneq ($(CONFIG_FRAME_WARN),0)
             frame_warn_limit := 3072
         endif
     else
-        frame_warn_limit := 2048
+        ifeq ($(CONFIG_CC_IS_CLANG),y)
+            frame_warn_limit := 3072
+        else
+            frame_warn_limit := 2048
+        endif
     endif
 
     ifeq ($(call test-lt, $(CONFIG_FRAME_WARN), $(frame_warn_limit)),y)
-- 
2.43.0

