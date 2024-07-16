Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B4CC3DA4B
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 02:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AF3A10E506;
	Tue, 16 Jul 2024 02:31:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ym2Xy1lf";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E94F810E506
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 02:31:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrHB2N6xwHbKtu/m2MsPnerk/nNrubAYt/uXWVtrjWEGx9/qZmM2nq6g64g9m5EzXsiAhj+Kp18CYS2mTi5Zl2srS0AIbGlqo0dKZOcjRWM5drob2SlLZPLiEQtN1Pt5cRWqjonLS2M0LGwrP2xZ+ampduBVCHZAuJ2Loo78hfIz8zk31wKisygwrc7kUgn7dMhUQH1cD7seHftZoauSuwqXUiRmMSED4beYUCM6UcgO/Ll5YS0AXEsw0gzt+Z215DwYNtoKqFVJY7YHJ7RRP1VOzPrqhwPVjOthyBa7xn1gqvTMAi0We2YnNXRQmMKnXifCDdy9yStwaSduUHp+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsAtbUDOZH1WWXGypsb/OHbvak8UuVGHHoWlY/HRWlg=;
 b=SnlvoRJZ98KaGt5c3lgTf+T9nYQFlLy8oRDejCuXar3juTuXDWPA/qlShIc+xIePuS479q8tG7/NhchfuZg7iHrpJTpljs/KYF4Ko5iYg4ZsVKR0w3QhthZzmar1RRcXNUtkWGpXGx5OK8QkPoJzT7po9hu+dZvqdMSi0C93sWReL8vGf8eIOybQ8cwVQk9rR7Bbr60+tTQ9YTNg/Noqz9h+9YsBdTALFPicPtYpwzEVvd2Jpk2m6GMOu9TJajXyhIS3H2TIq6Tn1rmIZYHCKn65ciEJo9yM9iL4e91t9vuJVadc/nVqVkOov+Wz6bRtVXg/EkMiNJ1nrnHApmJzug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsAtbUDOZH1WWXGypsb/OHbvak8UuVGHHoWlY/HRWlg=;
 b=ym2Xy1lf+NdlisE5pRSryL0v+hMn0E+2WA/HM4YMBiwjLxM4cKXpmZbhMS1fX/lGJpGxDpS6gCwcw0HIyTWcURi/EmAsdeAUKnY2R8vz4T7X8Pa4whjS9g1POjkzHvaiGsYjqT3UyxRYXBQkCd0fnBgcBF9Ar8qY/THHofWel1U=
Received: from BN9P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::33)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 02:31:50 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:10b:cafe::63) by BN9P223CA0028.outlook.office365.com
 (2603:10b6:408:10b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Tue, 16 Jul 2024 02:31:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Tue, 16 Jul 2024 02:31:50 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 21:31:48 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <Roman.Li@amd.com>, 
 <Alex.Hung@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/6] drm/amd/display: Move DIO documentation to the right place
Date: Mon, 15 Jul 2024 20:27:23 -0600
Message-ID: <20240716023022.100811-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716023022.100811-3-Rodrigo.Siqueira@amd.com>
References: <20240716023022.100811-3-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 7717abce-2249-437a-c6f1-08dca53f728a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?91wGXpYKHQzROPVxTnhGJvD2Zh3TTggWI9zUP49l+4K/PPllz3OTQXIivSaL?=
 =?us-ascii?Q?rY2BbDZ2Y1WEIFjjP6sI685dWSXiI/WEJ5P32h91BTjb/qDQzwetevoI0lqR?=
 =?us-ascii?Q?dyWNjhO3s939RS/TrNGG15yVgT7fSUVwOL4WczKLmhQ3TSVZCaxiRuV0KQSN?=
 =?us-ascii?Q?UwDJM/NO8Z1Z5eBrM6bl5dZAjYcD3XbmD9436KKnrfbQpqcPr59lpNbVa014?=
 =?us-ascii?Q?ShZM57RpWfMfN8OceL/TZ8KwUVCr5nyAn5zTP0I4686ICqAzudGSGSOsZLbQ?=
 =?us-ascii?Q?GhzOCoVbeipq9jK0efYkdSFpGGFG+IP73HLeVX2KD16+l/fbNXm1l5GNmhFy?=
 =?us-ascii?Q?R/lTKWDYliblsWLl+Zc+EBJryfTocQNQD/Hq35YFkIM+5/UyfF1mqXXk64mO?=
 =?us-ascii?Q?kxMFu/3lR/Sok4EBgowP+rRLMLkK+ayiruRhpL6IEWZ7/oDk2t69jtyNJXFq?=
 =?us-ascii?Q?f84jve2FKBS9aqPN7oI8tYvWYD/XqUpJb49bJXU40Rg4xCPMFaMCorfTZzbl?=
 =?us-ascii?Q?hsByPIw3kQgSI+Z2ONHaDN9ZN3JVkOguhjEv2XRz2uyVNRKxdNK144w3znLJ?=
 =?us-ascii?Q?/eUo0Hhex/TgvNWHHrPS4TStgEirZT44MblnmzW/7VfYjVBA7CsAnjjC/bUf?=
 =?us-ascii?Q?iU4MoNopXwqoMRDuOPIe7rfHLfQXHO1LM/fLUKLt+/JRYU0N6OaRbhQGF5a/?=
 =?us-ascii?Q?Q1lQKD0F9yzRvEnNl2/eD6MW1aVLoWt6WMkwq7PMI88F0lHaZPDyMUow00TS?=
 =?us-ascii?Q?Sq/lnBQTemZosfhg1vFK8FzEWZH4ykwyl55bHPjkz/EQDbgZ04ZGDUVRyYjd?=
 =?us-ascii?Q?3THgrSFU29/4SKm8NeXJB1pGIjbDySTI6jVbNprXKAxW7uUd44nwVQLcab6g?=
 =?us-ascii?Q?bXEMQSuovUoBHgAWTTN/V5y1hoDOCf7NQ4FzoSzNoicaKzqlNSiXJ1vBzk8b?=
 =?us-ascii?Q?DROdUQjvWD7cajHZyG1D+aNS09Uvh/OJLeqwxqPNP+aHnnzpsaVMPP5Y4JTk?=
 =?us-ascii?Q?yP5ne4ub2I51KizPSseSK0OWbYFHlpiKBE5mvHtB/ik5PHpjSeBZKIzE9x6x?=
 =?us-ascii?Q?1d4uVaLXpRuq1AspDW3M/jD8gN0kKwXpWyYKB1FHHdebbt/szv7a7L88D4Cb?=
 =?us-ascii?Q?AbdCHRXWQMd5CEGByabPATE+5aJLru5ww3Hvxy1PUt5R7APmIBPMy6JED2v/?=
 =?us-ascii?Q?HH+aPtDZULhrE+wBUNELmnLxL+rJWshmg3JRH1gyKjp8ujT17KemhSSSCynK?=
 =?us-ascii?Q?gnK8cKDc4aHUe2a3EWFO8zeduJwyytpdr/bQlVy/X3x45Zv3Jz9G1Y99EX27?=
 =?us-ascii?Q?QeYxoVFZ7tGUbJF5ThuNZMdBtvfhwXVZZ7f4y3e0slaJhrm0KCslO+5ZDO15?=
 =?us-ascii?Q?zIe5awPopNRWCmOvXSke1nrQ9hovM68EM66CdZY2JTOnNhRDfQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 02:31:50.2362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7717abce-2249-437a-c6f1-08dca53f728a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705
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

When building the kernel-doc, it complains with the below warning:

./drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h:1: warning: no structured comments found

This warning was caused by the wrong use of the ':export:' and the lack
of function documentation in the file pointed under the ':internal:'.
This commit addresses those issues by relocating the overview
documentation to the correct C file, removing the ':export:' options,
and adding two simple kernel-doc to ensure that ':internal:' does not
have any warning.

Cc: Alex Deucher <alexander.deucher@amd.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/dri-devel/20240715085918.68f5ecc9@canb.auug.org.au/
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/amdgpu/display/dcn-blocks.rst         |  7 ++---
 .../amd/display/dc/link/hwss/link_hwss_dio.c  | 29 +++++++++++++++++++
 .../amd/display/dc/link/hwss/link_hwss_dio.h  |  9 ------
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/Documentation/gpu/amdgpu/display/dcn-blocks.rst b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
index a3fbd3ea028b..118aeb9fd2b4 100644
--- a/Documentation/gpu/amdgpu/display/dcn-blocks.rst
+++ b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
@@ -68,11 +68,8 @@ OPP
 DIO
 ---
 
-.. kernel-doc:: drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
    :doc: overview
 
-.. kernel-doc:: drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
-   :export:
-
-.. kernel-doc:: drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
    :internal:
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
index 81e335280e0f..3e47a6735912 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
@@ -26,6 +26,16 @@
 #include "core_types.h"
 #include "link_enc_cfg.h"
 
+/**
+ * DOC: overview
+ *
+ * Display Input Output (DIO), is the display input and output unit in DCN. It
+ * includes output encoders to support different display output, like
+ * DisplayPort, HDMI, DVI interface, and others. It also includes the control
+ * and status channels for these interfaces.
+ */
+
+
 void set_dio_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
 		struct fixed31_32 throttled_vcp_size)
 {
@@ -257,12 +267,31 @@ static const struct link_hwss dio_link_hwss = {
 	},
 };
 
+/**
+ * can_use_dio_link_hwss - Check if the link_hwss is accessible
+ *
+ * @link: Reference a link struct containing one or more sinks and the
+ *	  connective status.
+ * @link_res: Mappable hardware resource used to enable a link.
+ *
+ * Returns:
+ * Return true if the link encoder is accessible from link.
+ */
 bool can_use_dio_link_hwss(const struct dc_link *link,
 		const struct link_resource *link_res)
 {
 	return link->link_enc != NULL;
 }
 
+/**
+ * get_dio_link_hwss - Return link_hwss reference
+ *
+ * This function behaves like a get function to return the link_hwss populated
+ * in the link_hwss_dio.c file.
+ *
+ * Returns:
+ * Return the reference to the filled struct of link_hwss.
+ */
 const struct link_hwss *get_dio_link_hwss(void)
 {
 	return &dio_link_hwss;
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
index a1f72fe378ee..45f0e091fcb0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
@@ -23,15 +23,6 @@
  *
  */
 
-/**
- * DOC: overview
- *
- * Display Input Output (DIO), is the display input and output unit in DCN. It
- * includes output encoders to support different display output, like
- * DisplayPort, HDMI, DVI interface, and others. It also includes the control
- * and status channels for these interfaces.
- */
-
 #ifndef __LINK_HWSS_DIO_H__
 #define __LINK_HWSS_DIO_H__
 
-- 
2.43.0

