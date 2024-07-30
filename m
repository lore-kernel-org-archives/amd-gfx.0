Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71925C3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 167BF10E4AB;
	Tue, 30 Jul 2024 07:19:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aPFkefyC";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DD4210E4AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:19:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nM6PVlEcTjEwLuGFti58c4/ublP+r5rrMCCNK7roYpOFXeCLlKlf3GLWrQsNnP7ORgzxjFylcwZQMwDbLi2YKiuXojZLJYPPmwFseUTGbXejuOv3Ypz+zEE4g3h5f/piPmhOK3d4mgoO5GIHTNc7vPUeBRoa9eg6mLEmjCsTgO1vcrhYB7iDQqHoqQuhs4iF+PLClNqDn+TKDP9RKx+yf2dSUGbm+mDIKFq1Kgwwn+Ego+P9tnU1o0yKpTdMHpkLodmpIC6Uv84DwGyuUDWWvlh2xE+ekCAoUdd+QcyMSmkJoJ+WwOUeaFUg8fe7UDUusyNs/1D+88rBWSQc7P9epw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uZRqgKjYwhWcR7Gx1PDZ4Sa3CCJNrTw7q9qyhT5hoo=;
 b=wL59lRcWO2ccWmVjy5I+RJT6CFcSZ5vAKHsCUGLtWAch/dHNpkxtehFFZ6A1wLeFL8/Und69uriK0g/KS6ozj+7ayKaVB6yNi8o292PFVdZ3Ti8isb6jGtLOL26NIBCDnx2Yvu9jl1nsXBfxRA3vzgB59hbTYpz/vlG8dXrJvvM+wG8uXJwUzVSyd+PetYSQikW2iA5FklI4yfqHFlYEEkho9wZy9tagwjK6BREyVX/DUZXsqv0VPRCIphWCEsGqEC9qaaWDlV1hiY5e6ID6aRu2dNXh1622qDt0zqV03rQ8iaYlUZHLjHhubJPmqZO9pmi/qwjrDcw9Jz6xiSLbcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uZRqgKjYwhWcR7Gx1PDZ4Sa3CCJNrTw7q9qyhT5hoo=;
 b=aPFkefyCG9NawhUNtSYYwRzirzyDrhshkNyVjNLiPv+sRrOhoFSwlLZRQ5piAlOIhSe0SICnGUpwiSH9/GTW5jJCXcVJUnXinqbl3ri6rFnDNVC8GMnE/2UufaAvtsxU+a9KyOrKsH6W6yWQnSqNtQc9LkWGLyG8SjbR7EZkrPo=
Received: from CH2PR14CA0029.namprd14.prod.outlook.com (2603:10b6:610:60::39)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 07:19:29 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::9d) by CH2PR14CA0029.outlook.office365.com
 (2603:10b6:610:60::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 07:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:19:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:19:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:19:27 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:19:22 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>
Subject: [PATCH 02/22] drm/amd/display: Cleanup dml2 and dc/resource Makefile
Date: Tue, 30 Jul 2024 15:18:23 +0800
Message-ID: <20240730071843.880430-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: fdeee3ca-06ef-4891-237d-08dcb067f362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/jsGnzBV4D4ydTMgFQ2ErKwRnE2YZCMCNQJupRelO4n7G8s7LCe3xDOauBhg?=
 =?us-ascii?Q?pCo/imNVlNlw8eCCQLy9Gw0zYgCNDaaHXRyZBDvJbfP7TpasCdSzbu5sCc5v?=
 =?us-ascii?Q?CW0Qj8U3x8O6GS2ogjAt4L7JhyNCXJvv08gQaH9+Z9LMA+J8c9900qmCT1Yc?=
 =?us-ascii?Q?SJ67Xh5ThzlxNpG489hn9xHLQIw/klFcu2YG5Cb9TWz2riA+Ov22ny+Nlb53?=
 =?us-ascii?Q?zlH2v9Gz0a4mMb+6hgjm+zqOvMen6O++Irvk9pdf5mO9Gtrj8UBiWNyZnHN7?=
 =?us-ascii?Q?0tgzpA+IDUJ0E455jTknnNUuxNHDAnxbua8aV+/IILQYB9AK4mwGqSCEDnjq?=
 =?us-ascii?Q?1xdiMtYOc8FhKIcbFfGtB1TILxISQ/E0KAq1Z1OL6ToKBbjXjxDRWnMhsY8U?=
 =?us-ascii?Q?ZS01V7BmHM4vy9z9han8JzieyjJUtoeaCNokZzE0OqBtpA1JbDVHsvbTA1pC?=
 =?us-ascii?Q?pbAWNjLPUDKkJcVUfcDPyRXiF5XGUPbBc0tw55m10Pvb1e+z9MuqPUTa+sra?=
 =?us-ascii?Q?NV2ym3nxyEOw3RJD1LEPiRz6hhalM4hwQAtUXnA+wnHYC0fpN23zV1IVsh8o?=
 =?us-ascii?Q?mbjthii5G8UDIYMzynMvsGONiL4kn0aFySv1DEJGaLGADKxbud2+kU0A6S1b?=
 =?us-ascii?Q?jSlabMVyvxUikL7VbKrd8242HduWPj3MNohHGB/eHHSPdusKzldx3p4FasBS?=
 =?us-ascii?Q?PQ23ZlVOC+4+v7WY0nW+PslPVIlOjVfkX0StG6sZxSRxAOglX9bmHk1cColJ?=
 =?us-ascii?Q?hrjNp7i5VaxRg99KiVTRZH8I3fmXfh7cTmdqMp9pgRiKC5c2dYV9RyqrBeWt?=
 =?us-ascii?Q?xI5vPJSW/TIrL6ib3vGzjWpk5e7wyDeaTZ7eT/0Z+ruYTn8DoX1un0b/hfbl?=
 =?us-ascii?Q?Fgw3XOIKikHcOPhjRiSwxTDBUjZvMg1782OTEF5KNZd+hmHmiTdN/u66ye7Q?=
 =?us-ascii?Q?p2DCEo8m50l/5miLPoLCR6fyYLXhMV7UaAHYWlTPOyyDNdXUScV4/tM7PPso?=
 =?us-ascii?Q?lp4IEgoK8PqR9NDeczc/pyIF8DDIzObd/2YAVbLmrDWW2p5RE/RG+XflNdj/?=
 =?us-ascii?Q?/NlgLb1IY0iNN8Fpbc0jjqHV2h9QUWpor8hnWAq7wM87NcNdO9O0hpGQwgyz?=
 =?us-ascii?Q?q/WnO/nhKAd171vv0ox72qjYHryL19JmXBwEmCybWUABDoTi/ITUQty1/oNl?=
 =?us-ascii?Q?PUkbLrkV75WcxnjxbJAid+EO5zGbJilaa3N1E9ObXV8UASi+xZdxzYF+CtzS?=
 =?us-ascii?Q?nyJ2rN91KGf8tHWvjHe78OF+QgmA1eQ1E6fzfw8KmXBYHZ/6iX9vQc38aUoE?=
 =?us-ascii?Q?SCsm5+XcMZks0NfzKce/VAaLs0G6MuzEznTgMh3LfIghQvrR8EWp5evfwWKF?=
 =?us-ascii?Q?PZcLLvmehAPD3l7YRx08lmDJ+QmotCSRkhoou3oPLwUZsV11JvPXVidGzfy1?=
 =?us-ascii?Q?32V0gY+is7r/ekLpRl1YQNThcmGKCE0K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:19:29.0401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdeee3ca-06ef-4891-237d-08dcb067f362
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Remove some useless lines from DC Makefiles.

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/Makefile     | 2 --
 drivers/gpu/drm/amd/display/dc/resource/Makefile | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
index b61332330b21..e954182c70a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
@@ -67,8 +67,6 @@ frame_warn_flag := -Wframe-larger-than=2048
 endif
 endif
 
-# DRIVER_BUILD is mostly used in DML2.1 source
-subdir-ccflags-y += -DDRIVER_BUILD=1
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2/dml21/src/dml2_core
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2/dml21/src/dml2_mcg/
diff --git a/drivers/gpu/drm/amd/display/dc/resource/Makefile b/drivers/gpu/drm/amd/display/dc/resource/Makefile
index 4860bb2531a1..09320344d8e9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/resource/Makefile
@@ -198,8 +198,6 @@ AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN351)
 
 ###############################################################################
 
-###############################################################################
-
 RESOURCE_DCN401 = dcn401_resource.o
 
 AMD_DAL_RESOURCE_DCN401 = $(addprefix $(AMDDALPATH)/dc/resource/dcn401/,$(RESOURCE_DCN401))
-- 
2.37.3

