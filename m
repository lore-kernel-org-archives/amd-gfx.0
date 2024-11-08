Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C62D5C0E4
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 15:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C615010E9E3;
	Fri,  8 Nov 2024 15:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gOo7SKO4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF28010E9E3
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 15:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RN4Yyd/TQFguxwLoK0TDS5ARtD8CcA8MxDKCviaG6eNYwg389Y/mWm3gyLdWFEKdl74b/E6ZYFPqowZUWbPl/MdFT/GmEAy0nJF5bS42gRJfZRcc7Z3UkogtP7/pAy0Sf+Wt61FKYKQA7CE1GeI/AKOFGkihl8Kk3h0Fu8PHRLQbpV93Smh71uSXZeRe8WB6/MCyiLz3kZzjORWyfIYBiPCLOjRKJ0FlDCEV/r7V6zymExCJXSOhPjX7KUdygja1zp6KGC+4kFY8wLMXz/xUbphBDxma2IzGiVGsPSDK9BASMVlwveFevpD5NxNic7/Kh/6c0mEE1wsb5Q8AhGOEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8wxDmNH8gnPxrl+fswG3lDuB9ljn6Y5IXg2S3pChSs=;
 b=I0+mxrO7v+/G+4Ml+zFmA/iIW9x0eAYBLn9lM1ny59XMHEgsSYd5R7K+2Kj1JDbjJDOyLHihZuX57nwVqMydU86wsiAhx6EBJv2eFy/BtxeLsB6i08Qt58XLBmOAqsBH72tr9cZ3oNbm7IFPcgP8fCnRLCigwF9bY3dA8kXcHeeHgr/0bmj31UiX8dF88NcL7DbYM/3No66h/UnJ5KmwEbUrvVGS8o/1XvmIhFfWNYl0VAB2p+5rdkSbMAidZmV+VyDwnpAfrR0Yga9b1oR402qvJU8df6TmeN62T03sQl9sB7rv/b/AZsNVXfIzoDyZmUE5njNtlRjhK88BJodz/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8wxDmNH8gnPxrl+fswG3lDuB9ljn6Y5IXg2S3pChSs=;
 b=gOo7SKO4XPZSpM5MYo7zXStIikj0d8Z//kVDLwRC2HILRvftU0xrwiBCqethFG9DSTdN1ykNJgY4Y7ESdMhrIEqBJFIZ0uvBSjVqU3NTTz8uoX5Si/jOXnfGzYMkku8LWAXIfUSQfjP+XXlIDRS+xWAM08VyKhDNgefd90hyxRM=
Received: from SA0PR11CA0124.namprd11.prod.outlook.com (2603:10b6:806:131::9)
 by CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Fri, 8 Nov
 2024 15:02:10 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:131:cafe::96) by SA0PR11CA0124.outlook.office365.com
 (2603:10b6:806:131::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Fri, 8 Nov 2024 15:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 15:02:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 09:02:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <aurabindo.pillai@amd.com>,
 <hamishclaxton@gmail.com>
Subject: [PATCH 2/2] Revert "drm/amd/display: parse umc_info or vram_info
 based on ASIC"
Date: Fri, 8 Nov 2024 10:01:52 -0500
Message-ID: <20241108150152.983465-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108150152.983465-1-alexander.deucher@amd.com>
References: <20241108150152.983465-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|CY5PR12MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d7a27f-f3e6-450e-4fec-08dd00065208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3fp9SNo7p0MkddtQWmQeeXP5LQPMIQtEuygJBCcEJYSfZtGwlAVZr5aJ6W9Z?=
 =?us-ascii?Q?HdEb4fdz7SqEDeb9x3o/z7zIaOvUdE8DOa4BidjFRpwP/on4XqhP+KBCchD0?=
 =?us-ascii?Q?3numoGP7OS72Nc1fr1oScNKMT6vrT8ZYOHEJw+qg3UR2iozs2qS8KelLrRRO?=
 =?us-ascii?Q?TzRwSX2AwNxaiK0cSpIuyzVkuC9Pd+Qp7ksG/9qdRFG1VhucJEXsrLaS8Ahp?=
 =?us-ascii?Q?PxuHR1DH1ZFRgv7XNdigfesIuqOsVXpCAlNnmav4leufxyrjcMbVg/XcBtX+?=
 =?us-ascii?Q?67pLPy1IZmizpVyo87751dcZ1lsKhRt0TlnvpXNuwt80fqwjDtyGpAl8bi0e?=
 =?us-ascii?Q?Tu+IufJL95dqGqOQ5KmpPE9/hd+TSIqg5dRojstxv5zGOWL//grgEDZO1f1z?=
 =?us-ascii?Q?YtoP1l+f498yxOzKdotNfcLkPDua2Vn/PiO/btLQGAcQldOdEkfFL6f2ZsTn?=
 =?us-ascii?Q?DaqmyTvUKezWVO/E0IPVxgm/4mdJNwKgJu6AE/ie07aWm5LrbCUHodf9CtVK?=
 =?us-ascii?Q?VgOw6jzAOZYTFbKJ42ub9g7CkyVEUMHcwsSZIKRpBcsD3ekjdVyQ/RtD5xDl?=
 =?us-ascii?Q?xBoF7WyrDKUW0FtF81yORvKLTU4RcVaQjv0aBs+REB8kiII7GfeCl1xer/WC?=
 =?us-ascii?Q?TlOIBUNCMw8w47mj0X/PvBjZZMyAnZFQYQWP92D2uIqBGY53MbUXcLtJdrO2?=
 =?us-ascii?Q?JtKCbo03E2YnNAOAVBd8gbBt4rmiEL21b1JeBdlHe+0/94UKzZzCHtZ9hfDn?=
 =?us-ascii?Q?juGaE1uK1eUfq5c+8w//8eWmRdUTurUbN0EPaNLALWKViWVzfMHkRyBu1g3t?=
 =?us-ascii?Q?BNDcDJsYWT7nTyWqIQGkR7CoxFySO4sbwsrZ4EWLh7dzF4pAOmKBwFFFKmt5?=
 =?us-ascii?Q?RNnp8bQpfEruLXGABvgLTidb5AGS39x/LYNzTRXFhQ20E6HMWh90gZc3Mzwq?=
 =?us-ascii?Q?folAPt1c9SsJNxBvo68c4IO6fQMKT/N3SSdaK/8bK0GkoZ8oy9a4N2WPpDZm?=
 =?us-ascii?Q?JUSCnMsP9lON8P5hDOBwZU6qXsJmpbfJ3F5I71PHZUXtC6V5wbbtMppVSKEv?=
 =?us-ascii?Q?l0StSq8eNtH2aw8RdsdPGCqEg5U0IqP5B7eihy7Z3Z2JUVGgP+P9bXP+ijp2?=
 =?us-ascii?Q?e9/JZWIMiK5LCcU7YcYT9AS+zw3KXl5nLIgoQz/Ytm5rigIqMhUG7Mbs361S?=
 =?us-ascii?Q?QmqWKZjYfI9Qn+kUR9QegMIWu7q1NnvgmsWQdg1cksoUlGsZOpiR4h9kXs+2?=
 =?us-ascii?Q?YscLENHeJfDjuV8J+7OwXJQM+g7Jrp4shiI0n0ZEUx3F/e1FDmXBDdhtg45E?=
 =?us-ascii?Q?zq1MULfZNuApsjoDsesSCF2gQHb/cisDh62CoH+ov6JJSFn3lFHmUFGo+zTJ?=
 =?us-ascii?Q?zBvJmrU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 15:02:10.1621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d7a27f-f3e6-450e-4fec-08dd00065208
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6549
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

This reverts commit 2551b4a321a68134360b860113dd460133e856e5.

This was not the root cause.  Revert.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3678
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: aurabindo.pillai@amd.com
Cc: hamishclaxton@gmail.com
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 902491669cbc..c9a6de110b74 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -3127,9 +3127,7 @@ static enum bp_result bios_parser_get_vram_info(
 	struct atom_data_revision revision;
 
 	// vram info moved to umc_info for DCN4x
-	if (dcb->ctx->dce_version >= DCN_VERSION_4_01 &&
-		dcb->ctx->dce_version < DCN_VERSION_MAX &&
-		info && DATA_TABLES(umc_info)) {
+	if (info && DATA_TABLES(umc_info)) {
 		header = GET_IMAGE(struct atom_common_table_header,
 					DATA_TABLES(umc_info));
 
-- 
2.47.0

