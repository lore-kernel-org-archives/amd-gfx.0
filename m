Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E24DD5E392
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 08:10:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D04E10E42E;
	Mon, 11 Nov 2024 08:10:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CvuvJlJe";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 709AE10E42E
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 08:10:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klHx2YxwvNKl3QXjbHYZ7VooN5NuHX5bKT8eSIb15rZ0U1dIFtNL+nj/1nkODtdDayvAUTPrkZL324TfhMELuWNr/QDPVCheFAc7QmFa1AtUFeFiFjpvmoQ7Dp0bDucnGioIUW7Wh4ua/DH1Nee5RKxBw/9oZEj3mDL4lbIuI/RBpAlforKMAMQsb5xldAHKkX8v0ny6FhvyBJcVtQadfJacPGwbhbliIsUmyFjRpCdvqKgErIc1z0W8v5Rcvx/SnwTRjBlMRAW07xYcayLsuHqvCr+EWZPsZwBAUmTWXLEEv31RDXwbQIVd7IpbIEbMjBA113nSxUqGjq/ZaMylbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBR09qSKov2s0pt007GrDWJR4nZmmgyn4cnHXpszAWE=;
 b=ov9tAedpIres0FIc8muJPGoBh/NiK7pk2xmiyoqih++LYkdVqR36NfVgSBGwVCOQThWPTURyk/My8yi3xfq62Evg5jJpckYOTI4qg68iW5wU/3VtzyirR7x54E6v+JIRMnWT1n4iPbzcOzXkX3wKZ+viid5rfeKHjfJ0EVe9c1PVTduLrre1BrfcIjnCbB4Q+Ag6PXY2x50uTZ+8+4jU1Mu6guXIuoauPi1Xw5Fsc2Ssg3UknsM1T8N5kkj1GkXIFK6wMHViBtdkoNwWXMfilI/1b1y1rr7pqzIQVyowL6gGSitO+DEQJD14Zz56d00tBE4IhCDEshmIiZ5vIcuCMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBR09qSKov2s0pt007GrDWJR4nZmmgyn4cnHXpszAWE=;
 b=CvuvJlJeQzLl4efduo/QbY9pqSEOBNq2sunXdCoYTHypvhZg96lFqfuxWMsOq6N28Qh1Dr8gWhDwJxdXxvTB3E1TDuDUIRS+g2QNw9oBq0LA3BOAiC4zOvm57DzJRHBL4h9D2Cv9AwcSaW7em48bm/+5fUdt/xXsWsPEWYus/mU=
Received: from SJ0PR13CA0227.namprd13.prod.outlook.com (2603:10b6:a03:2c1::22)
 by CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 08:09:54 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::1e) by SJ0PR13CA0227.outlook.office365.com
 (2603:10b6:a03:2c1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.14 via Frontend
 Transport; Mon, 11 Nov 2024 08:09:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 08:09:54 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 11 Nov 2024 02:05:52 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/amdgpu: Fix UVD contiguous CS mapping problem
Date: Mon, 11 Nov 2024 13:35:24 +0530
Message-ID: <20241111080524.353192-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|CY8PR12MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: dd83ccb4-b208-404d-467c-08dd0228396e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PQV/J3sXAw27KW1sOZswhTz8GlMeIRx2Y1kylEiDx/aCkXIYrJ3FgoxHwXNp?=
 =?us-ascii?Q?VQ/vMy2kgYZQ6Ez+qzKbJnANUgZiq3zjhh9PnoXLEtD7uS/dv24mJB1bRPKS?=
 =?us-ascii?Q?du0mIUmnrPap3VcUypvVx80hSWtDn1GGisFXqJQHNbYMhV1DeTWLHgNBDG9L?=
 =?us-ascii?Q?LJj6y4+j7jPMs0huEzcFWTYEI5OLi9E90l/3Rxmm04MtBuhTr6ZJfIowE/mR?=
 =?us-ascii?Q?utDK2UBupiu39gdWovM1VhJzu48dFEPdkfHuQuAwCB9VadYAYlvI1LXQuhoX?=
 =?us-ascii?Q?MKo8R6oxf3fvs+WQDB3OGybAPJdfKpy3zbmUJtjVGLZX2w2rSLCHMveXkYoZ?=
 =?us-ascii?Q?N7wIvyWqTQhtGcYFP17ygFfd4qJLaxP4FAsI7+tTqo4GRP3U8mfplTMWWyMS?=
 =?us-ascii?Q?moIYIBNJMQ4Sc82eQ/IsOGh7jdNinBDNGuL/SHgM/dmSeKHoKlNQzQbY7piv?=
 =?us-ascii?Q?R1yNsZZI+dLTvTtTrMfe8ZJ4L6QZWNhe3VtGIqKsaJr0QBzPc2tdACZT5ika?=
 =?us-ascii?Q?xTb8UbVBBU8IJJUzTX7YOpoFMgj6uFbPEcJbR0ecBgLkyfLY4JQ9T7UlLhw6?=
 =?us-ascii?Q?XVm/fX7W98UfAxW89bbH8KpbVWT7KMjt0P+NIHPPas8u61I1iTG71zKUqPWC?=
 =?us-ascii?Q?Yoby9GOEdUuvvOHG8PEJcFgv1asVFjuqUypJ3xQVGd6G5oknL+4BuF0HB5Di?=
 =?us-ascii?Q?zUUNqJ6sTfusWONCURYVSKgac9GFd5IINfiqm7zT8PP4cYdgUolobhbCiSqA?=
 =?us-ascii?Q?bH3reTelrau8L8oHsoWna6PLwqGcSGZG/yjQpfG580zqfzyCuXTWzST3sqiI?=
 =?us-ascii?Q?1n0/JJMo0N+hHFaKj0y2PLWbpWqhp9WYVjifrGOVK0THFjBQFKU/4//IGgCE?=
 =?us-ascii?Q?pGjAjUYAdVlnh+mgd1YkhgAjT+vj8lFpc+8ED9+N5Ld389ggC3scXYJwu1Ql?=
 =?us-ascii?Q?v4WOC7yaqRpnw4HYlI5lIiLsaDBMkah8cZdhL2ef0edOMvJdSdpqTqBNknf8?=
 =?us-ascii?Q?v9HHJJA6W9nX7fn4GtYwSxwe3y1Zt58EK2QkB/lZc4kpW3axTUV/mARpboc9?=
 =?us-ascii?Q?k3xZ4lTWkg6HQMw47XNKBnlqbcFinQxlTo5XkM7ugVZ9ITNJ3Ewv0zX34wUw?=
 =?us-ascii?Q?Rws3LTB9Ew8kexoJWw8aTnd8J6Fecfwtw84LBbSEkzlZ48pPSRBRkCj2TlYh?=
 =?us-ascii?Q?+NhYHR17w6dtcQiMohK1aPZPCc6wjxX1C/4GOIkYM2YI+4pk3WhmNHby+gIp?=
 =?us-ascii?Q?vf0kTrT67zEeSFm/eDsC64awLj/WfY8Kan7wChEeN1BZlQ3d67sxShNyiLXl?=
 =?us-ascii?Q?vfAF6+x8rZhfU3MOOdDC+YVwWABjNT+Cw0J9i8t2lafKPX2EHtb/XiKBEcZI?=
 =?us-ascii?Q?XlVdYy8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 08:09:54.0235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd83ccb4-b208-404d-467c-08dd0228396e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289
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

When starting the mpv player, Radeon R9 users are observing
the below error in dmesg.

[drm:amdgpu_uvd_cs_pass2 [amdgpu]]
*ERROR* msg/fb buffer ff00f7c000-ff00f7e000 out of 256MB segment!

The patch tries to set the TTM_PL_FLAG_CONTIGUOUS for both user
flag(AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) set and not set cases.

Closes:https://gitlab.freedesktop.org/drm/amd/-/issues/3599
Closes:https://gitlab.freedesktop.org/drm/amd/-/issues/3501
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index d891ab779ca7..9f73f821054b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1801,13 +1801,17 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
 	if (dma_resv_locking_ctx((*bo)->tbo.base.resv) != &parser->exec.ticket)
 		return -EINVAL;
 
-	(*bo)->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
-	amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
-	for (i = 0; i < (*bo)->placement.num_placement; i++)
-		(*bo)->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
-	r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
-	if (r)
-		return r;
+	if ((*bo)->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
+		(*bo)->placements[0].flags |= TTM_PL_FLAG_CONTIGUOUS;
+	} else {
+		(*bo)->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
+		amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
+		for (i = 0; i < (*bo)->placement.num_placement; i++)
+			(*bo)->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
+		r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
+		if (r)
+			return r;
+	}
 
 	return amdgpu_ttm_alloc_gart(&(*bo)->tbo);
 }
-- 
2.25.1

