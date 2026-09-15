Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457E3C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 07:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEADB10ECAE;
	Tue, 15 Sep 2026 07:20:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zIUtL9x6";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9229410ECAE
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 07:20:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3zHUcyDSeYG7zFwFko1LGGRH2U3XNd75gJ9SeLdKSxhP6LwShj8Lqvn2CUvwudBVUYdsXfbwBQqGMo+1PmRDbcOfEggcJicFE/dqur4UBkehLb6ea/phFDg6KLEFawaIOqlBh+FLuUnBObnD/VUs3btbC2cGrtiE0juq2J6I+1uhTKo9YCD4RC/BsOY4OrPT2s9cr7k7+ENTdgNWBN31MGUCfvYscTfWjyOUmzCZlRGuflxsR9omkCJ8GUkaYq/kHCcwDhXZFeWjElnxSTrDQCL6XBshNIPEMfIQ3NWakOWMhih4eqwNXlpo6ATe8bsTc5odpYDnwY7gvdrdfjM5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS7otyWlGRslky1aPNlsGlgmz+N38EglW+oWaibo/t4=;
 b=ABTBS0BSX/wuTiPVw+2efLT82lUuT4gIZrDSvCCi4OxS//Hrs638aACF8VuRLdA0aIx44qQBSsXix2zJ7z94VjbFW7nYJ/b3ssZ13v2clIahck7Lu1Sb5cc3QSGVlL9mEjE1mJ3qKqQBER6BhNYcMfE6zfi0Wq7TXUlW+26fIYWy+VgXx/YaEg181keqXUS9yNJHVEcHdU8PpPu3cVfAyyDtdK9/hx2HDoGE+AF0LbK5TCuIhFqhDEajsjApjPV5flT5mBw7eeihQlEHYHbjIO5l8j5zxjPfoi2jwL0OO5pQNIdwNZX10QXPM+tTCdbX6uwd4jRDnPxK0pnU7tJN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS7otyWlGRslky1aPNlsGlgmz+N38EglW+oWaibo/t4=;
 b=zIUtL9x6Zr/QahdnDz1btj0NelmB4QqSLSOAg4kwUESc5n5QBc8ETp6SUn2KbH4HqKOCx4GKwT5ASNyv0FyyjAuiPPVdG8CH58wbPi5BMamIRs+5b/L+X3Z4+szcQLN35UuSQCpQi4pHEvW+/MxbLMd9Ay/yNWBjPJk3WWHev9c=
Received: from CH5PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:1f1::18)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 07:20:07 +0000
Received: from BN2PEPF0000A805.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::56) by CH5PR03CA0018.outlook.office365.com
 (2603:10b6:610:1f1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 07:20:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A805.mail.protection.outlook.com (10.167.245.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 07:20:06 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 02:20:00 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 3/5] drm/amdgpu: extend UAPI for reporting userq invalid VA
Date: Tue, 15 Sep 2026 15:19:44 +0800
Message-ID: <20260915071946.710846-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915071946.710846-1-Prike.Liang@amd.com>
References: <20260915071946.710846-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A805:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 734fd60f-012d-4b8f-6552-08df12f9c4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|22082099003|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: R/kLIs/J/aUmL20HOUeNFOHHL6yjGgdIUStIuz0LdxOJnk36hYCRydzxLLNpoytEnnzRCx+4hLV7HUMMxTW3zE5Vxx+ukExfK+2L5I6ao3IPYArAPS0nVYkt3YAcCWmrXZlijybYA6Xn05rZvq57P9iB08g0/MMlLcbG2cmdIr/GTw2TvR9bOj7HDmr1mykxj4bNaL18PVfDf/cbwoYZyJXnV1qtRttrsN1hgkAYCNqfbiiPpIwuODNp9eM4G4DMYLOy+FpwXl+SSrbKSFPqIqvvZCCDCPSdv5UlgGobj6y5v+Fcb1EbS9ZWt3loQ43+EiEK37tDcdPmwTfkSY4gEyNE3fbO5cgk1g9f592mYrJt+OseyGj1fFWILma/uKm2qtOnMHnuh5teUy/SZyfyubFCmCSR944J3pNpxKwyShQn/ZTfY7eQdUVJGdvVtu6aJ5wLj0WFgYQvuTZThPd6U90ozYzi7cnO4TAzO3aNuAuLgL6mzbESqnM6yqLjhSEoHNsh81vYpG2mNdiVt3Le4abTfzefaBpS0z/SsVtfzUh9v4X4DtL59aUFOi+2Fb8O+FzTNq2Z9uNiZW/UXCoGru0rlFEgb7nwDU8g5BOW2LpMa3knZjT3uXNiEVLtRNkZ7uwbPYks9CZD7KHL2Gu8kk7EtoD8R8m0HOMbwaut8y0D3jLsuhCj5tFbOYT1fUTBHDQZbhiNoACmUHA4h9STjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pvzc3XwetRsMCCGrzbMBNpu5NyDOJ8lty6xqm38eU451nCzUIV5766L9QnKIkhZFwKEVT/sfavjWPDDELJbf3vG2GqyIbaKeZnkGzFYCq479UTujBjijRidTZ89PFkCatNLz64bX6xMaXFGAFt4OocyrQ80aW+9UD/n1yGkWyZ5ARPDVKlUl5/JziKhkzPAeNyppRtEz+vGgv+CnSxMDD3CKOSfTc8s2WQeuJcKR9th1KZeRJIqTZnItAOLHiqc3Q/+pbUgCHx2jMmxrCITlU2hNFyBqPgI+lTI1ije2u2zWmcSeCMgPD4Du2CrY3WZrlHnbw6NsgAadR4nFnGJQF+iQSru7UFTAAW4U8Qb7ao9mor8GGW2JWghLusmP5Is9r3BJMaGWHZCOq5LrqO9fWYLxUi70OukqTQ1Cw9GFEZBRiYU9B+fsBtsvtIRfRyBS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:20:06.7359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 734fd60f-012d-4b8f-6552-08df12f9c4cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A805.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656
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

Add UAPI new definition for reporting userq invalid
virtual address status to user space.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 183ac26f2bd3..2f81ec3265cd 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -358,7 +358,8 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
 /* indicate vram lost since queue was created */
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
-
+/* the invalid userq VA unmapped */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA (1 << 2)
 /*
  * This structure is a container to pass input configuration
  * info for all supported userqueue related operations.
-- 
2.34.1

