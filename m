Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379EAC3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 17:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B70A910E619;
	Wed, 28 May 2025 17:19:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sC5FCGsO";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A279010E6A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 17:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQtztmbboE8GLNYpllTgAs8gfyJvJiKG/cwpVVcXWswjRxFW/i5Em3qa6/8SKVND+iKbRqHbcnSVsdG5+7Mrds9VvuMlb1ai9pFpdYaC4SBY/o0jyLVepULbnMktJrJsYlyIwpScC3PQCmeqYE+ZouesgW+Y10TM9UQ85tR4mk2oeFFlpgSzhx4QnwNqJXIJZmeGzIINTAGv6lPmnK8CPu2kU/tRWVO7leoqsVJawVLxODBbX9pKGyIbPvgf5tbROuWo4ZbQxfOlPI6WSmbJB0xp1VOiKqIDcGVUD5B/ziLX2vYtuEBudSozrBv+gqBwHNZTJ7IJYrzHzxw0FgTLtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLd/g7DJ2bAXi2M6t9sDFqNoGbPnmkPB/JM3IB5OdqI=;
 b=EH/jTjrHkDd82JS3/PK6MSBCnEoymyd6o1XYnmw+eUwQao4ffPw+jr58MoghJs0qqjxN64h17C0iKwv979HkLjOF0KhQSdPTkMIrjI+PHVpQCZ5YtQHCTP20nytK6n1i8F9gYp1bNTKyF/WPNIh4pzn0eKavGjcocNNDEOoQPTq6RBSFr6AvPiPxNb9KiWo6tnxHdDtzTe/cSBQCTbQq1fHGr+92T7qgER3Yd4tvz696ouNz43GrxwVU1D6wdYEG9D0X+x1nxVC4z0CVSoC7VqjpyHliweDYUifr8GxEGbIeD3aIfr5i9uWf+ykAtlP758WYOgXRv219Fto3maPEsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLd/g7DJ2bAXi2M6t9sDFqNoGbPnmkPB/JM3IB5OdqI=;
 b=sC5FCGsO4SlasB41hnuJHdbU/W54eG5m7nhPaI/FN5Kit5U6EJ1a2X+IXWkt+5vkg44EqVsj/JLia2bpZyqFNgvZrk9dkAtto8+wSC1h0siyLxEi/OsT1/XJcONs40aS7vdpoyWcWPDRFiZDEBfLiE+8WnyeJZDOn/WDYecUwjc=
Received: from SN6PR04CA0104.namprd04.prod.outlook.com (2603:10b6:805:f2::45)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 17:19:20 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::f6) by SN6PR04CA0104.outlook.office365.com
 (2603:10b6:805:f2::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Wed,
 28 May 2025 17:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 17:19:19 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 12:19:19 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <philip.yang@amd.com>
CC: <Felix.kuehling@amd.com>, <christian.koenig@amd.com>, <jamesz@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: remove unused code
Date: Wed, 28 May 2025 13:19:07 -0400
Message-ID: <20250528171908.82639-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9d6f58-64b7-403f-90fb-08dd9e0bc859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FzX9FLpdOs8MGJ+V86iE+M//h4N2iQ8RlWbbjcXZxBsnDsG3tr7TFAylYcPW?=
 =?us-ascii?Q?KI1woqr2Qas6UWgJ4TMuOvivcvfk02Ve6tACHm7lcmPbp12/Nt58VGcIaHTl?=
 =?us-ascii?Q?5KOM2l/VnKs0XXm3nUnVna5eGSP+sFa6dIcVbyyOY0exgHjQWRvWxASlUSvH?=
 =?us-ascii?Q?otZht4C6xs3BHhY5zzh7bVCDk1tc9zrYxMsJ3gd34HWpoL3asbgML/rLKv1S?=
 =?us-ascii?Q?9n5m7T2tTYJVZE+8tGQsAqX7pxQoGSt300SGH27wA+AjBN+IpomcCuEnac99?=
 =?us-ascii?Q?GnFvOcInBLk5sJ7ryLG2aC7xN6G9Gfj5G5cDMZOrb7YrlagqswcZgKQW4S6u?=
 =?us-ascii?Q?2n1KLn28E2XzXhhNBD5gw2WonbtRAgvUf9PxsmLctEI7pUX62HQQYtCBE056?=
 =?us-ascii?Q?62dLbs3SBRKL1yPRSvbeiWpvr5Ch6FDnY6A+fi4DlW9R7j/I0yxsoBAuR3kf?=
 =?us-ascii?Q?0nuICg9xaCaDIICN/Se8/NHAm8JAuPqf4ZWN5tU2DFi21ejkFW07zTT1gGcq?=
 =?us-ascii?Q?WQBXg9ECaIxPgaXjicb9bRsyoiXEKx21nX1CT6kQmvmIAakYVVLgDL+NCNBq?=
 =?us-ascii?Q?1ps9MHv5K2NqpkPOLbOQdeEw8Ws5NnJCcHbf6Rf35ralFFfRravCD6zXzMmr?=
 =?us-ascii?Q?gFiPTpVSKwc7bc/A5y2kdlLzWO4mU07Ywe08vyV7z/jBLuZt0UO64FNvmYfR?=
 =?us-ascii?Q?TwfmcPxJ/kvwmpY4DLD8IZJ8cp/mZ4f1i52zUjZk5pqgcTiQHngATnflGewM?=
 =?us-ascii?Q?p2KZQRWsUea28Ad+KYR0QEn9j2ViDEPCnit0VXegg63W41vIqSJTvmJetosj?=
 =?us-ascii?Q?y/UxzdOXTcdospnJUZeutCfJS/janJvNR5kV6aDjW7H/7sQB1Z31aBVjISXi?=
 =?us-ascii?Q?8/M2SEbiBLVpFX6+AVnXN+emYPu3yUGewW8OgDBjWy8xt2iUxKuXwB1pySWt?=
 =?us-ascii?Q?FskiLo8UjNYdcAehDVnunuUmIb1NoUVUMf+jl7FzZ2OiAWyrpTbTBCgbV3sW?=
 =?us-ascii?Q?JuF78Sovr185JY30YwxlT9Bm72AZB6KLRXgDJaYt/GsuVxe/Y8iD2kfaILph?=
 =?us-ascii?Q?5CmfOK6CzYLeGh+XcFYgx8Y4mZflG/L0DFSlq2zoDUFVpLjsf0mycUgP5kqf?=
 =?us-ascii?Q?K+IccQjaTQkQUwwwefwMAQla/Kyx+4jnrn8LKdrTmTTpPWiozo7Z6P0RpFiQ?=
 =?us-ascii?Q?OPmtOEL5TcXsbJ5koL/9cbC0ldAQtMw3xMi0JieMr8oCltNGt/EWQHHDA4XO?=
 =?us-ascii?Q?PBb/MYChjEyiUOWSV5LOXWLP0WHoh8zhW46RObsMAqIgdXSPOU/gR+9Epiqw?=
 =?us-ascii?Q?yDZyqH7L0MLNRPcagR+uhr2vVeI14yeFNfDi1MFikoDot8dpwga7XwIkXxKY?=
 =?us-ascii?Q?78Jdzu9m5lHObZiTT/w4twKZdIzuusTcf4iS+hAy8/KswRecf1vDOsQZa0DH?=
 =?us-ascii?Q?TUq7irrtKs7aGkvpSRMWGh+/6uwIVhI05DXwatY5wGpZAMWkFKTqnnL1su9d?=
 =?us-ascii?Q?LSqTE6tjA5xehIgbqrj454WNSfCr7vKWl0m+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:19:19.8972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9d6f58-64b7-403f-90fb-08dd9e0bc859
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275
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

upages is assigned under cpages = 0, so it isn't really used in this function.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 79251f22b702..f0b690d4bb46 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -736,7 +736,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	if (!cpages) {
 		pr_debug("failed collect migrate device pages [0x%lx 0x%lx]\n",
 			 prange->start, prange->last);
-		upages = svm_migrate_unsuccessful_pages(&migrate);
 		goto out_free;
 	}
 	if (cpages != npages)
-- 
2.34.1

