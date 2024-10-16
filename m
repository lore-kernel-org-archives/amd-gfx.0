Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FEDD1AD53
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 13:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1067110E6F4;
	Wed, 16 Oct 2024 13:15:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FOWtMQwK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F1DB10E097
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 13:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QaTXGm9wferA5w65YmgfQgDKvoEip0VBPWemjiMxcXiHWndqKTsSxFaRdCWZIkdXRBzl9mAj+yDW+NhYmZjZnB9CfkyFHXPZRQEVGwCeTAKWsaWgJAy566R++O+f/TP/5Q1OZhW/q5O+GBZ80W+7h5Mx7nEMedstiy2PJMLP29eEU9EDDnZ6tBV8ZNSmFVYbKK1iv0pABwbl6znyoLNqTzCbpCFex8MUjvmqdCMjbeXEKBYKxiHEpbnfhP9zJXCRk+JvcLOTyEjASIlGUlwb5B5FkBY436kUgtGI0SCngpS+5T0ETXccQYjGZzzgXMkzES950aITL0Z9bf0tBniHPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tet64FRY2D4eYoZb1SYWTYFsUh6yhUw9m6RTfMK3nqw=;
 b=FE0icgAvHO3vECoraOgRCptyOgbzuG8MWPP07WbtOncFHF17yqTCl9nyvia3gNooTbLmXZEsK6LGiLLAoyd3Wyy8uJdH4eE6l/2hNT2UPyXs+HCU9qFPxEhMzukWt42ZNRh3uVCXjIQLU0ikRfkSFe+sD4aeTX1CL9ObU68AbiTaw+wf0lNyCUkTo9ahtewXFoBtK9CAXlnTQmd132INDrEI59JZC/1BpByr7Hemf5TwubS9fKOn1CCuCP+KfF0+1NW8KWv167uG4UZ+ok43N9nnN0wAgY9Vh5+N7Pj1HMiZ5fJx0H+CZ61Lsa8zK/ur0Uuj7f566hRzvlnsO9YUrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tet64FRY2D4eYoZb1SYWTYFsUh6yhUw9m6RTfMK3nqw=;
 b=FOWtMQwKIvJ8JZpg6NErmQOaxX4KcfZWDlmtIO93NH4WOTfC47HBKenqff2+Y51sEHmLdP57jEwZ19Es56f4vtlJMe0hu13FXeHMn1eUdYdXklsYoisnIhhVDVUVLSnjRXx1IAmYDDNup4onasY8loSo+RhevRSYMSoee3TL9G8=
Received: from BL6PEPF00013E0E.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:f) by CY5PR12MB6227.namprd12.prod.outlook.com
 (2603:10b6:930:21::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 13:15:10 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2a01:111:f403:f900::2) by BL6PEPF00013E0E.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24 via Frontend
 Transport; Wed, 16 Oct 2024 13:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 13:15:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 08:15:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: fix vram info table parsing ordering
Date: Wed, 16 Oct 2024 09:14:54 -0400
Message-ID: <20241016131454.2942748-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd6773e-602e-4d2e-2028-08dcede48fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6x6b4uCTpKtWfuXK8g1Iq1XkThToCzvZIiU8GS7hcX5edhlTbwes3Dn4gXpP?=
 =?us-ascii?Q?NyIQbx8F7vbXuf5u9o5Yp1FsDbtXnz4wf3pf+UX2l2Wdz9QcgnSVBr75VfMp?=
 =?us-ascii?Q?5HF592FZ3NDFgL0z6rAelcMbfxWDzrSYbejW+22G40mOXBgVp3XgCEIODmCT?=
 =?us-ascii?Q?fL2pFvMgEv4mjz5/Na4jPFYzhr66jIV3s7C8z7iqx/kqjl35Q8Mhbpxthwfo?=
 =?us-ascii?Q?ndop+jEvUWQHYtpKl/R4v0u+6bBsGzjVBBhG2wJ+WMlDP8r2Gev2d8ZLErje?=
 =?us-ascii?Q?ae6ZymuZJMD38xkL1A8cVq8PyKZC3g6AXzsQctlu5lbFsuz0cghsH1pCcjXo?=
 =?us-ascii?Q?KibMTBf4UkAhGMFHb1V8ysyfphA7UUD8AdHSXe0V43hD2x4NY12TB3juau+L?=
 =?us-ascii?Q?3WS9/ArzgWGNeNDZbHAVboXGiyJTxoNcIa1UJrNXWc4GU843O3TUuDP2r2F4?=
 =?us-ascii?Q?rXc1724ZAaROrHoTq7Wl6M+mXnzlQtYAcIGj+2HsPeRzDO5fpKN9GcRsJnuP?=
 =?us-ascii?Q?IK5Ps4j19EgRoSsK5wlydmUHW7oACrmDLc0p1itAt8IOEU1wBy5Jp7yd9jR6?=
 =?us-ascii?Q?tiJtTfctsdS/MN5xnnEJXZdQQDq5RszJ8JndnVBrzPEFw+vWGwooXXqZjyrw?=
 =?us-ascii?Q?+0wDvE6qRex7bmHHRO3dX4Vn/pFAdoyIFjXfxoF96N9bO0SfP+1+By24ZK2U?=
 =?us-ascii?Q?HTRXkQh+f2u4s4uajwHPBcG7jHWN+xTLMNu/u+zMkIlHDGosN7/U2slNX7Oe?=
 =?us-ascii?Q?WKuB6eDtV9fmyKhjdJ7WpMZJSYRAoeolfFp3cKSZ0ix6ToqYLbfG0tZksJnv?=
 =?us-ascii?Q?MXYbOZgIEkzFdrR2/qs2vu/uQJNm7RaAgSZ7+cI/+iqQkOU+qh3dnkTt0g6B?=
 =?us-ascii?Q?G2IWL0vz4TE35swMl8CCX3wjUWJQSNCUwwnWMdOsufqdpT5V2wVYNEMRxrh9?=
 =?us-ascii?Q?0ZVxv5C8PY1CCDfwiMzXxqhfS3lolwFPCiAgB69L0aFoSW/EA7Yw3aHjW/Hh?=
 =?us-ascii?Q?mnfkIc5wrmfitSeMIgdTEmb+o7VBGmD62Awq/GAzCxcuCiB9ky5hx7JaVxvE?=
 =?us-ascii?Q?R1IjhoYgftcYY5YUivRrC2C8aLKteSBqCbLYhk0OEoNKMvaeYn2pgrZA9kte?=
 =?us-ascii?Q?f70KWcTtJEF7wfEtsE6aGIGCvzB5Y9Vz8Axo0UAYulnIOYh70mbawpkXy0Ln?=
 =?us-ascii?Q?HwhMxDJP8G5NhNvWAARdCIsIRQpIENrl0MECgDLeEld3pkvZb/+iBZWYsGa1?=
 =?us-ascii?Q?uhpqJrmKcCU3fJWVAu8rNnkkRX7DDydrTD4XJcK0BfFuY08m5Y/IfIVI/exz?=
 =?us-ascii?Q?jbHJ/3zlEMqohoS5q77jmnM/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 13:15:10.1363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd6773e-602e-4d2e-2028-08dcede48fe1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227
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

For DCN 4.x, the vram_info moved into the umc_info table.
However, it appears some DCN 2.x based boards also happen
to have a umc table with a version matching DCN 4.x which
causes them to match the wrong table.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3678
Fixes: 00c391102abc ("drm/amd/display: Add misc DC changes for DCN401")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 49 ++++++++++---------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 0d8498ab9b23..a8181631a40b 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -3126,29 +3126,7 @@ static enum bp_result bios_parser_get_vram_info(
 	struct atom_common_table_header *header;
 	struct atom_data_revision revision;
 
-	// vram info moved to umc_info for DCN4x
-	if (info && DATA_TABLES(umc_info)) {
-		header = GET_IMAGE(struct atom_common_table_header,
-					DATA_TABLES(umc_info));
-
-		get_atom_data_table_revision(header, &revision);
-
-		switch (revision.major) {
-		case 4:
-			switch (revision.minor) {
-			case 0:
-				result = get_vram_info_from_umc_info_v40(bp, info);
-				break;
-			default:
-				break;
-			}
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (result != BP_RESULT_OK && info && DATA_TABLES(vram_info)) {
+	if (info && DATA_TABLES(vram_info)) {
 		header = GET_IMAGE(struct atom_common_table_header,
 					DATA_TABLES(vram_info));
 
@@ -3182,10 +3160,33 @@ static enum bp_result bios_parser_get_vram_info(
 			break;
 
 		default:
-			return result;
+			break;
 		}
 
 	}
+
+	// vram info moved to umc_info for DCN4x
+	if (result != BP_RESULT_OK && info && DATA_TABLES(umc_info)) {
+		header = GET_IMAGE(struct atom_common_table_header,
+					DATA_TABLES(umc_info));
+
+		get_atom_data_table_revision(header, &revision);
+
+		switch (revision.major) {
+		case 4:
+			switch (revision.minor) {
+			case 0:
+				result = get_vram_info_from_umc_info_v40(bp, info);
+				break;
+			default:
+				break;
+			}
+			break;
+		default:
+			break;
+		}
+	}
+
 	return result;
 }
 
-- 
2.46.2

