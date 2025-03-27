Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A920C3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 15:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D740010E90B;
	Thu, 27 Mar 2025 15:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DmmqVe6r";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EE3A10E90B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 15:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9H5MgjFHNFzdNUyJYslHiJV0kgk+2MyjoAFr5rHO86qHLmQA/iZRWEohrdpRRU0RZx0FnTGMFqYjOpb0P5qqU3lcDAfZJsLgK1l8cLcNKthKJD8vmLU2FvRzrFj97I5FxlzqG/Yrvl0hkZej1ciZa4ufOBqA6f/OCRYVjkGVRAZOztgekVx7iuGEQyx998wAtpuET8nHxWr/adaTrDSt+di6xQ23PKtMys5ppVXRQVVDSVBPu04CWL6ka9qSFkGphAdIZISP3+Yf7/bZ1GUXyYJAgPxpF5J5ZG+D9BrkJDAvd+Y1IE4uSAXkEXRaS9oqy8URr0rc5b4W32p3Q8f3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUtywZB8WgI4rMKwcl1SmLk5hktFbZGdrGoQOUo14VI=;
 b=szvJLE65BZ7uCRvEKeCd8DNvbHpQppcJToORvNUEAq+igJ+sBlmd1yvRW9O8VRf39YmTlHw71l9V/QTTHitsdm6BMylOULdGJ/EgiM95faq5DM3eXEB/QJ8NQxDEHUHJ+4j15UXw7vDsSdTIBNc8O/E5dEIK/YBxvdlx8CId2Ly6D5wPdBgBMOO3BRR3EycYq2UvLSDGH5PySmNGEEq4fRjRNGN3fmehNNVNSWTQvZd0LMOftsVxCeEzkOX/hs+Sd3gmEZiffcNSYm7EGUfaStoQJDgvdUIuBHRlZx7ZH99DKqGslVGWksXqEEaV0j/+zyhBeNuORpklokwxLL+BOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUtywZB8WgI4rMKwcl1SmLk5hktFbZGdrGoQOUo14VI=;
 b=DmmqVe6r+GvJU4I6Vu1qY7kwboaMjkHYShRgSkY/LYLcacvVQXw61jHWyR1SBsMQYgUYTqRjx1IS8OAu8ZPWw3QsD3Rgb24ZWfIiNDMnWjPSKH8TG0tYXi8zkWHRBHS4eZGJYy1a9hpLXfvvug2Ynu5ozxysViOr0KLQ82wm6SQ=
Received: from MN2PR14CA0012.namprd14.prod.outlook.com (2603:10b6:208:23e::17)
 by IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 15:53:47 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::43) by MN2PR14CA0012.outlook.office365.com
 (2603:10b6:208:23e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Thu,
 27 Mar 2025 15:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 15:53:47 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 10:53:46 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <David.Belanger@amd.com>, <Harish.Kasiviswanathan@amd.com>, Jonathan Kim
 <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: limit sdma queue reset caps flagging for gfx9
Date: Thu, 27 Mar 2025 11:53:39 -0400
Message-ID: <20250327155339.1756101-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|IA1PR12MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f83edb-daf9-455b-d319-08dd6d478f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?++8ukh8LuKkLO0yVWdPsX5T8S31aSGVihH2RFCpQJpY2Wo2VMhyQ7fulMB7m?=
 =?us-ascii?Q?odN4ssweaXZ850JyFJ36qYk5suzQwKuixo6BPyTgpLku6BoK5hYMPQEXfBjy?=
 =?us-ascii?Q?CrXwuFkU3RgZUftnDA28/gpVLXIzFVkqDtrRhBNNN3sAk+TLoiP8DMoacmBA?=
 =?us-ascii?Q?v/MHlBlSQY+8cySURM6sVfS98PINgx7U/w6PZcgNSJmrg8eswerm6fGLdfbd?=
 =?us-ascii?Q?3VtZX1CxEfB1J0DW7ug1Ya5CmdtPvNn8CMYg5meGJJz5/x5RFQqlTarzBd+Q?=
 =?us-ascii?Q?h+Ob5nWPxzCebUfpkheM+uOHd6RLWS0DCcB3r4Mz5KdCLTEJgpBeNGQtHB0L?=
 =?us-ascii?Q?Vj3Kgtifu8h4MgSqNJOekpIfqgHayhOL3c641R7hDMw93DyvfLdGRn4Ymmr0?=
 =?us-ascii?Q?kfDlbUWpfOyeT3hZRfYK6JTXvJhi8bbu0bbZSpw8QFomkLyrWpOBbHzAjaVA?=
 =?us-ascii?Q?7AiespO/O1RbcSPVFwHixSw/KF7IiK5BFxdzODgegCUj0s4pL3hIEMQGG4sp?=
 =?us-ascii?Q?4XKbB6ZfH3UCO8btBMBIcWaXsjzNxwsjYzUEZp8J4DTwq7aY0s0l6pNC2tQD?=
 =?us-ascii?Q?NtA7WhOHREP0pjGg1bZM55QTQdYSNPXPMcruUpBa8cKxp42iueCJ6Mv5gcrm?=
 =?us-ascii?Q?H5B38aKhDOOS53W8jfFzf7YYiApbpY2941GGQRAgeOTyAY+XpIQKDtrl9tx2?=
 =?us-ascii?Q?e9Rkjj6XeKSMxC0XlB/yR8UjHrifiBdMEUotpb5793fDilcHmz+TazrYMfXB?=
 =?us-ascii?Q?HLv954iGu3b9lFisgiIMNWab56lq4m6a3wm7/vcd7Ula70UM2JdXrFUZFnyf?=
 =?us-ascii?Q?AS+c13iYv/QxrznwlLqeDJ+Xg4nHu+XQwvoNf0fIqtWWABUc3LE9Wef2YXNc?=
 =?us-ascii?Q?K/noS/wRSAABHczqcjFAjq8K9oG9NQ/LbRM2j+/LdNS20BEzeDL9rcIbX8ea?=
 =?us-ascii?Q?6UXDc5REEhTyXPDzzLwJ1jzNrYRtKZW5TrDiEaKN7qmYXZlcU/5HYFkjwP+x?=
 =?us-ascii?Q?230i8HP9LNo0VaKeh2bAJ+LxhK9jRd63xvjxWKpPIroFLJ53Kpu8h2IF1jjO?=
 =?us-ascii?Q?T/1TueWgTb9KoedCkN1fem4sPVNNhgE143FrnSkOvRo8V7DB1C+iCH8qgcV7?=
 =?us-ascii?Q?523yKqd4QEU50mYuOwLLUexSKlFEdf2UrAs9RnlMSjdATtj+FwtaUa9XPuVi?=
 =?us-ascii?Q?fiXjK+Di19Hc+0wuIYsrK1+dccW0bcLkSDgWq06AlxhtbUSsDzslyLmFtxXa?=
 =?us-ascii?Q?1iyzfQ0HKCvEUckQ8dguAyYnFzJdgAMZ9lRhqylANVdNQiTef7ffyOjf0K82?=
 =?us-ascii?Q?/hO+Atk1uKed1/4sLU7Vls8QuguE0LZSFCXS8MOyGZ8fogyCbMxRxoyJWOH8?=
 =?us-ascii?Q?zHkcxPxW0E9om5W/ZQ1EYhY9TrCKbXqoWhO9zfntBhl91+GmgJwnmBs/tKXB?=
 =?us-ascii?Q?p0EY/o3ROWF/+GcfrnCOfCxrJX6w6K+Xmzo1zCQEfdo/c/iQDJf8aWY22AW6?=
 =?us-ascii?Q?QqVl4KCbz0g/hns=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 15:53:47.1930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f83edb-daf9-455b-d319-08dd6d478f65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077
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

ASICs post GFX 9 are being flagged as SDMA per queue reset supported
in the KGD but KFD and scheduler FW currently have no support.
Limit SDMA queue reset capabilities to GFX 9.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index e477d7509646..993eef5a4983 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1983,9 +1983,6 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 	if (kfd_dbg_has_ttmps_always_setup(dev->gpu))
 		dev->node_props.debug_prop |= HSA_DBG_DISPATCH_INFO_ALWAYS_VALID;
 
-	if (dev->gpu->adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE)
-		dev->node_props.capability2 |= HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED;
-
 	if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0)) {
 		if (KFD_GC_VERSION(dev->gpu) == IP_VERSION(9, 4, 3) ||
 		    KFD_GC_VERSION(dev->gpu) == IP_VERSION(9, 4, 4))
@@ -2002,6 +1999,9 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
 
 		dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
+
+		if (dev->gpu->adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE)
+			dev->node_props.capability2 |= HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED;
 	} else {
 		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
 					HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
-- 
2.34.1

