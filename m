Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE89C27C55
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A5010EAD2;
	Thu,  6 Jun 2024 21:57:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rf9U13Hb";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C5AC10EAD2
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuowMS7uaBf2pC/SC3wIbk/SJrT/zyNUCXmg5DEJxY8b+Rj6VpSxZSKWAzx7o7sk6MwQjH0h2T29dL/lLmQRdZdEE50c6emb9xdEc0OkXJCpx71KAN19hUYYPozWUijF+WAnnnFP0XV3DX70SEB3Osrm4mVR6Dd90WraJTWmHYtVyZ+5GG/tfM56p9Fn5dDnCAZ0VaKJIf0ZJlE+FGkBqtsUTbnH+YQ9bqipX9ofmskBTeOlpegNKBPXhgZKCHghHjjaculuf+fPw2qTCGpZkY/upo3u4E5HB/YOIvizh8isIPOrPFBiRXRPWAaB22os6chBq2IOnkdc4VbEJLIvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNaJztD0b2kyYr5LNBJJ9BxpIOy20tVOCwUN2aXK5w0=;
 b=OOpj8WwE3qdReekqhgBJmxIkoH3UZl8PaClxNV4IcNK0lX1Zy1UzaDziMmfYfc3ovUL9ieLBQzi/E/UcTVZYYXS0bA8+pxOBKHYbpKA4eGXPf82Dht6h0P6ELsFfyE4LaXU5I/bGZRXYiaGW6+y9l+tvoPcgpAmU6spX9hgiKrow72VAVU6Ye3u5mZV0Zv8g9QxfkpZaoptoF7EXq1RRw8z7f2UWGRuba0ufvHEGHEvhj7ftPPmu+FB6J4/H8w0DM8Ewvyqy1v7Fqyk7c+W8MQEbAobPACqoNA4QCb/vu2EjJiC/EmpFHxl+3YBgMWApNlatgYlXJULzNkwU1FlB9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNaJztD0b2kyYr5LNBJJ9BxpIOy20tVOCwUN2aXK5w0=;
 b=Rf9U13HbQ+55bRg9mD2XcpzSwRyx8+epSi50MJQ8Gn+PG1Y0iUuEWm+/O4r42Sp5snA7/x0Eqccefd7ZZ2aEB+TmMs0t/JVU8V4j5P5qTnqz+371GvHarU/ueEDflXXtcH1+AnKnZqCztbfyJ8urk53GVaA4ELhBzkulRg9MBbg=
Received: from MN2PR03CA0009.namprd03.prod.outlook.com (2603:10b6:208:23a::14)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Thu, 6 Jun
 2024 21:57:00 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::44) by MN2PR03CA0009.outlook.office365.com
 (2603:10b6:208:23a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:00 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:56:59 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Ivan Lipski <ivlipski@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>
Subject: [PATCH 08/67] drm/amd/display: Remove redundant if conditions
Date: Thu, 6 Jun 2024 17:55:33 -0400
Message-ID: <20240606215632.4061204-9-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|IA0PR12MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8646db-7e5f-420d-e04a-08dc867397c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H9LuyWl3Fekv7YnJARdRaOQmZswmEU9R4VIe16IgLuDlt2olAjcArbmWjZmL?=
 =?us-ascii?Q?K5edtORc9HO6r/Df+vjaIMAJ8ZSVJzvKr5KBPatVvMzjOGV2XGDtUHp1XnwD?=
 =?us-ascii?Q?aLZYqvq9Ga2q9GrMzxtqFuSp0LtaIFqd+aNtsOs7/SHtukkUFycuUuiEOCFU?=
 =?us-ascii?Q?ArK2rwN/2izjWb/103F4tmWF75I9+I0k0V5RaoYnmIebCy4gJELnW5DLyGoH?=
 =?us-ascii?Q?HlZdlac+3t0vcJLRhBx7JAas/I0VTI9YeR2l+FztfGf8qlh3qxnIxOtJH8Lh?=
 =?us-ascii?Q?jrCosj5bwPqsmI8XWilbpBjgH3nFSyMvc3bgVy8dkOBM16CWr3mhYoYmF0ZP?=
 =?us-ascii?Q?66rEDaA+k5S5d/4iKMJeEh5Uq22JEIxm3pq2H9FRu2SPAEnBoVNSbYNeDeJW?=
 =?us-ascii?Q?XfI0FRZOlaMv36h7stZZdsXrDSsjSAsDfutTxeRPvckCYcnOwnIxJO8Asw60?=
 =?us-ascii?Q?6lLVsTDOm36I4XCKb4fuXuW7hIyM26N8+lKZrOQrKtVXGw56X5NLtPo3KSDf?=
 =?us-ascii?Q?VtBiTA7A+0QjH1kDqtpItRI52QUKs7yvhNLVhPz9NS/p2SOa03teh+scMINy?=
 =?us-ascii?Q?EO1B/MhGVjSXfF7I3sfrxiJDAXWZW4EN1gXCb3Rtk2VkLqZnfunE7ecfyuoZ?=
 =?us-ascii?Q?34CmnszOPsmld44l3z4nbzhQLLrbYz6tU2RQg3ipFUSjzaNDYfald0sk46Sn?=
 =?us-ascii?Q?jmC5z3ANpZfKpU2FH5+QvSskNLWf7E9/ThV4AWr5t+/a3JNanHk30dfiOf87?=
 =?us-ascii?Q?d2wmKMWEogqtA9Q2AI+HOgtU0baV6zoqpEQDbSfPRTPjuODVdDL9szNDzAMJ?=
 =?us-ascii?Q?nE7vpJZOUdiRTR4juya8gd82O8o4JUbxahU//IE1S+GgqHmxCyIu2K80wuGN?=
 =?us-ascii?Q?oF2hOZ0OLBmt9uoonYyp7tArq73MHuhQu1jfKigpIYRtBzn2an4pxpAlmqly?=
 =?us-ascii?Q?lPlxYe2OmkSFqpOadHgeYt+YiG2iuSGPvMbm8C2Z0Z0jNWjaEH3BXIh1lZPD?=
 =?us-ascii?Q?x4RWDtELdmgCPqxaP0YcwSRZE6JFCRsVjYSakmqIXjGJojpLywfaJTBdtcfv?=
 =?us-ascii?Q?vKF7tKPGW/Gr40x1oooif2qSyyN9S5RE9OMEI+/FTKA+5RbyyU/XPDdH8hbQ?=
 =?us-ascii?Q?E/PrsfnFiRzBq05mNuecu2NnlBGoTsBkJ3RixENsQa5nqbDZTTrlPqnCDFId?=
 =?us-ascii?Q?3+Upd3rsrYAeAb3b3AaRgAQ0CMjx5ucqpz8ji7OWF1n9AX9NcsMvV89h1hqr?=
 =?us-ascii?Q?fTpFlmy0rIbzKIY5jRz3apVEdtGFXzKN3rHgnR81tZLCLYjwH7ul3aam+1A8?=
 =?us-ascii?Q?Ufwv3CKBigV1abeLR+IVUF3XfNR6RPMd2L6LAdIKyTIS5zFSBNV28SaxLNmC?=
 =?us-ascii?Q?mNjZtZLBzXR3+xqLqxYyfZPYulROxaKdsPWuh+/azuimM9mXqA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:00.4503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8646db-7e5f-420d-e04a-08dc867397c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974
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

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
Coverity analysis flagged the two if conditions in
dcn30_dpp.c and dcn401_dpp.c as DEADCODE since they
are never true, since the variable
'program_prealpha_dealpha' is initialized at 0 and
never chagnes.

[HOW]
Removed the variable 'program_prealpha_dealpha' and
the if conditions.

Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c   | 5 -----
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index abdf6a132e66..40acebd13e46 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -219,7 +219,6 @@ void dpp3_cnv_setup (
 	uint32_t alpha_plane_enable = 0;
 	uint32_t dealpha_en = 0, dealpha_ablnd_en = 0;
 	uint32_t realpha_en = 0, realpha_ablnd_en = 0;
-	uint32_t program_prealpha_dealpha = 0;
 	struct out_csc_color_matrix tbl_entry;
 	int i;
 
@@ -347,10 +346,6 @@ void dpp3_cnv_setup (
 			CNVC_ALPHA_PLANE_ENABLE, alpha_plane_enable);
 	REG_UPDATE(FORMAT_CONTROL, FORMAT_CONTROL__ALPHA_EN, alpha_en);
 
-	if (program_prealpha_dealpha) {
-		dealpha_en = 1;
-		realpha_en = 1;
-	}
 	REG_SET_2(PRE_DEALPHA, 0,
 			PRE_DEALPHA_EN, dealpha_en,
 			PRE_DEALPHA_ABLND_EN, dealpha_ablnd_en);
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
index eee64d8e1013..7cae18fd7be9 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
@@ -68,7 +68,6 @@ void dpp401_dpp_setup(
 	uint32_t alpha_plane_enable = 0;
 	uint32_t dealpha_en = 0, dealpha_ablnd_en = 0;
 	uint32_t realpha_en = 0, realpha_ablnd_en = 0;
-	uint32_t program_prealpha_dealpha = 0;
 	struct out_csc_color_matrix tbl_entry;
 	int i;
 
@@ -192,10 +191,6 @@ void dpp401_dpp_setup(
 		CNVC_ALPHA_PLANE_ENABLE, alpha_plane_enable);
 	REG_UPDATE(FORMAT_CONTROL, FORMAT_CONTROL__ALPHA_EN, alpha_en);
 
-	if (program_prealpha_dealpha) {
-		dealpha_en = 1;
-		realpha_en = 1;
-	}
 	REG_SET_2(PRE_DEALPHA, 0,
 		PRE_DEALPHA_EN, dealpha_en,
 		PRE_DEALPHA_ABLND_EN, dealpha_ablnd_en);
-- 
2.34.1

