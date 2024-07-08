Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB9BC3DA42
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 21:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD30B10E41E;
	Mon,  8 Jul 2024 21:51:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k+rW1bu9";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF93510E41E
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 21:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bULWNOqlaGzXmap5zmqeavbOUg6L/AbpdWCa7aFx7UmxEShn8TmrOkgcLCKsJvyaJ/J6IoUDkEX5vWQJG2QJ7yY8Wpa3XjWuKEH0tqFmLZSyCXok38g7G+/KCz1aVk8b9XfFVK12B7YtemPkPH2GPi4LilRCrknmGBsSAQi3mPpr6UYvrsCF745lAWA3Wkli/GBU5vj+alZ2ZSSiuszhXxmWR3vvaBGY/HLNQ9yNcKoAtKIzpNDVxm01Ve/NIMEfe+pYeXMIywcJeTa4deomZAyErzh+jX/F55OmJMXNugM0mW3NYro4qXe+wog03+UWl/M9MCKbtD44OBDSCrjLYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8GTXbAvHUwZ7p9ncVJI86hToYJs58prlDEPeWAZyNo=;
 b=b5bZpP2Dvw8DOwUMssprZG2XXm0h88mQUXLz3mgx0nin0BdVwMOqTmmR74/QsKtfScnrQkAlllx2dy+EacZyDEwB/2gmcUHCfNA/bYkd3FCA6mdXjODTNCo6LFP4RP/4BdO/jZD6n4g9QPtyLFm3Q4xFHwNSNgT3XoAo+PjZZ4Xjc62jxT02zPPojM91Ru1vpXbivCWNYSIUAt9M8MBogEAAvbGlDPCyYqVxcsnr1sHgqzC76iZrRdgU7Ya4HTAGXYkimTuI+QGLo5wEjkYLaRm3U0OuihXpiPtakEonEFxas3ghe1eOKxDrlLFFQXCqrjlqfqPXIcCdWVftwTk6cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8GTXbAvHUwZ7p9ncVJI86hToYJs58prlDEPeWAZyNo=;
 b=k+rW1bu9sWuAtR9aeTLP+7aMktSTnw7pK36PyEyN15/lFL+zGGxYKJvqd2EiiX1l2ok+23NH7KrbaUj2RdnAkewsY3VWNaEAKUmTxgLe1Hs7SvgBrzi/4eb9kLlbS+FBBQvbRaIJhqhJUw5tv0Keqc0sTqHYpsmPN1Bjkr9I1JY=
Received: from BN8PR15CA0023.namprd15.prod.outlook.com (2603:10b6:408:c0::36)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 21:50:57 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:c0:cafe::19) by BN8PR15CA0023.outlook.office365.com
 (2603:10b6:408:c0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 21:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 21:50:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 16:50:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/mes11: update opcode strings
Date: Mon, 8 Jul 2024 17:50:40 -0400
Message-ID: <20240708215041.529979-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 02970d3e-8626-4d75-e968-08dc9f980c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jOqh4Rvq4UQpZ6yg0cNUZK1b7Ky75pNYNeV1gruOF6tJRxlrDRAagE0x9PHY?=
 =?us-ascii?Q?xduJxi4wnrXwnyu56iORsEX8HQ8jgGID8K/AVYPg0dVLVTYd39GcqvGDIbx0?=
 =?us-ascii?Q?M8OrsYaTk1t7bke3lBa05EaF30r7rbuAGHesDR2BVASWMQ1I5ohx0HWCGyLQ?=
 =?us-ascii?Q?Df1pO9/Hbk9nMiL/UJO3pk8RiW6liK0svjM316bNF4J6ihTM8r7IamCLSIHu?=
 =?us-ascii?Q?JzG51Hd8WbhWAJQLvo1X7amS0Uhf0uAWZxtHcZ9TTyQrcuQoUwRNxq6boFH0?=
 =?us-ascii?Q?gjQ1ruSLWEl+J84DQ8tRcoffZ0CEMCV79ledHJ97nHkHChHzSlkP9qExdD10?=
 =?us-ascii?Q?dauXOonxtFEIBj/ZRdvCtj/EVirnE2I5PCoVawzN5glyoKRHEvs0Hg0cyT8z?=
 =?us-ascii?Q?crB7UnPg6LlJjoa10+bcL1998lnBTW/Q4iTgmHmCeJjJKZmzoj2pM80IrkFf?=
 =?us-ascii?Q?4y6uydSyQNmA/fe1+tDBPvRsbILV4h1e0vttoWxILt/xZrGDq++9dCfSmbtD?=
 =?us-ascii?Q?nQ9/X5cTDx8EMWTkuz3tu05kRk/4lQkFhyku5BDti5xLBfYRc7B5uJytdfjk?=
 =?us-ascii?Q?z2mvq5c6DXpBP3yLyrTJc6Do6gzTccklZWyRX67s3k3epELqsioy500rp+rC?=
 =?us-ascii?Q?8oiaF0eXvu1071m5aj9j7Dyqj1DKmVu77wchiLa+tmk4bFFfLFHu4klKxXSr?=
 =?us-ascii?Q?Z+D5eOlMsDEkQtxzrsQEVSKIKBvS+U95kXQiXHqv5jOeqGxmOZqRXxdeNbHA?=
 =?us-ascii?Q?++8zkjmi0jSXQJZJQ0z5JoLHFIwrnilD0YGSDq51ITQvXNkNKJiFvTS+7p0c?=
 =?us-ascii?Q?x11Tk6E59Ew7GBP4RWoxqxt5vECsLMuR2hEBveA3HaBy+4N1hjZaQNy2lB1C?=
 =?us-ascii?Q?4DETP8p31nJ8d9cF0Ga4K2ik5eonc7KIY8EF/bUVVX/cE65RFNc1LKgPluvT?=
 =?us-ascii?Q?QbGsw/70Te6lfAxC0/c4OYTtZ09teGouWAWOCkMXNdvd4DdvrqU6snKkgFss?=
 =?us-ascii?Q?HJmWW3j2ph5tIYO0Gj6+fs0DiPzeZAyV0rmIizE+S6ax6byLO1RHgxGdy2N1?=
 =?us-ascii?Q?C5pxrD5/X1lJPS5Xleaig5DIU3fdhVZoU1yzG0772GukWAd6cOfMusoSixCO?=
 =?us-ascii?Q?SWNLnUvNgKG/lHCqB69ATUnM4vwBz6K/MK7xeFnyoqIssPj0od7lIr/ztCh5?=
 =?us-ascii?Q?WE49GVljaYQUEQkwGCW/onfVjJ40CGDkcGsNNkcAKGj9DTdQ1sAqXdZIDH22?=
 =?us-ascii?Q?Ebdcbza/J/TU7ECaYZ2Pd01qX/07vZp3FdqAODkvL7UQMcFKXIGee4U86G7z?=
 =?us-ascii?Q?qj+ikRpWcFYPPtW8JPS46sWt6C7vp+uNSrlnut9NH6va3UUO6v1giaAqU5Uv?=
 =?us-ascii?Q?cZBu9Fv+Qxta/MlUR+/ApDksYoht3tjCaSZYOZ9oTQKoKPCzogM8Ylm5YB3N?=
 =?us-ascii?Q?7hAJX05OqmW8q/YRrjF3Z1fiX6mHccF5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 21:50:56.8437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02970d3e-8626-4d75-e968-08dc9f980c3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074
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

Add new packet.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 1376b6ff1b77..8ce51b9236c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -120,6 +120,9 @@ static const char *mes_v11_0_opcodes[] = {
 	"MISC",
 	"UPDATE_ROOT_PAGE_TABLE",
 	"AMD_LOG",
+	"unused",
+	"unused",
+	"SET_HW_RSRC_1",
 };
 
 static const char *mes_v11_0_misc_opcodes[] = {
-- 
2.45.2

