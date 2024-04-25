Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11127C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 19:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EFCC11A869;
	Thu, 25 Apr 2024 19:59:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dEPg8EAX";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8272C11A867
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 19:59:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyMncBEWVC14HOgB871qmi9L+YjlW+k1QpNVFHsDW7tzUXQBgpqKIcNmgJalleKVa7ZLi28JuHwL3mvhzdzo76PZRWFgTIWgTbPlNxv6401QFppmd1tYrPd05yEbb6ABNMNtJ0hjReEvq+cL5XRsM7qf5du1VP924kRrP/hvMHmbOAuOPzjAAeJXN7LFGONQ3R2YyceDO00icoRhOLCa90e/CVmzVeuD5KXOb5LGiTM8aHkfQct3jA47o/JwymfycxQyFvURr3nE+p9YIDNKeFdR9jZmd6VJczzzAaRRO1vHdsxohUkxOd74FxFrJgAiwuHb/8Qx+4MaycaPx9naFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6jb6ZGWf8TVENSfFz6mP3bf7KNs+6tAA4o94Godvr0=;
 b=e0rwqiCEKqgzfoEJ4TtYKky/fajc0w2dp+9PHD/LLyOr749cJKcFMlOj1aWjuZOICGlAsbSC3OxBDnuL8xZq6XUSsJ+P87kGXm3sJq2xnsJgvjBEp6WTerpHSeq5CNeLCUGXYK4kwOaWl8OLuXFBELiO8grqSDggUQm4YnDYf69x4vrxh0wxXZTWZH7ZmnbLl3yONLl/Yi9cFWVv3XfIl3JB5EZDmSyfcVq65AkWxw+ONEd2OtIzoA5isLhMa8xY1JyqpD3XtQkmEv3Iwa0lsxH1u/mEvnGgkn5qYYZ4+2F79uLfLSQxb10L9PirNqYF/Lgzbs61JhHqsl0iAIRaDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6jb6ZGWf8TVENSfFz6mP3bf7KNs+6tAA4o94Godvr0=;
 b=dEPg8EAXvx+uaqtbsrD6uVvWvr/N1wSwdlM8cjfNqGUYkbBgfz+Z4gLeHzotTcu7ggcDPac2DQz7TPk3VG54RAKc7YnpRCDLWLfp08a+LqdKHOYnSeViY9RWvLUcXsVbkkQktPcM/zqiIZb5Zdd6A2TodD2+iPO6M+v6EF54WY4=
Received: from CH2PR14CA0051.namprd14.prod.outlook.com (2603:10b6:610:56::31)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 19:59:08 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::78) by CH2PR14CA0051.outlook.office365.com
 (2603:10b6:610:56::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Thu, 25 Apr 2024 19:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 19:59:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 14:59:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: Add gfx v12 pte/pde format change
Date: Thu, 25 Apr 2024 15:58:45 -0400
Message-ID: <20240425195849.2787543-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c9492e-8703-4a41-e53e-08dc65622ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UvVWggabh0uaJOLWrwWO6ov+/TXR9BxKEr5xLyiJVxSFS1BCM0h2GG7ILXAA?=
 =?us-ascii?Q?loHaOX/uTbMfB9LOYUK+XiHzceKYImDsoaH3Zq/ZRhObLjDl6FS7BTdhGJ0W?=
 =?us-ascii?Q?dz/7Y3v0Cxtncf4N4SaYHiz/hJnRIMKkGitfCxKOmlfkx1ezJoPpPlk4MIDO?=
 =?us-ascii?Q?zvFxnCHYG+YCuzzMwMk93VV/bias43cBectv0LxVuNF9pDVeMLHz1K99+Pwv?=
 =?us-ascii?Q?EdDBxb0CyfVRu3MzFVs/f3EHwN9SlzZ2jlp/noHzVc4tKWODzfw2m0JFSqAR?=
 =?us-ascii?Q?Jsz7OgCB3W0C0pHHDz5h5Q6O0G8SCUj9AsXhEo8CG4zoa5a7NSqoy1O8cnOk?=
 =?us-ascii?Q?bygKpxfWN5GOoPT6Kkn+J1DcpjdGqr8JKCmRsGWvEyrMBxtV7kMzkNmHwh+L?=
 =?us-ascii?Q?2cttnesO+0ICQfOpsal4brx7JiQAYmkgjOMcsKJ1ZYi97P/rh6zWuwtcfYC3?=
 =?us-ascii?Q?6etfSxfjpMF0XqveNTJzDHbkExuB9xXspj1kzPNKfRnZKOfsHLyRMobvMsf2?=
 =?us-ascii?Q?foT1RhsiM6K3lymkOZJBTcxZR3/6oXS0LRbABRhBYVOpLhlgOKYKDNatdUxu?=
 =?us-ascii?Q?M5igSYGpqrpXL5JXUudBerjHpleSOA+bADY3LyCUvjt6P4L2XdM7EjpUWCnz?=
 =?us-ascii?Q?cj8tWZO+VTBNj61k/FpjAuelsnCoFwx7ztsd8E4LguZY3/7v0bjNHOTwitPN?=
 =?us-ascii?Q?d1sXV7LTb+g3SuomMgGXs+CfMGvmuJWztz6rvPQ3rParQxsHrcYG5rDrmaIX?=
 =?us-ascii?Q?T1IW/fAUdXkelcuQLsNTtnHcmwSBIXZgAl7S8XK3eozZpaui/2CCv5BuzMk+?=
 =?us-ascii?Q?jsO3Cn0kWKCg7ueoQotoY6kHYvUjZ9imQ3VeowWTlETOPxMsiz/QXhvquTI3?=
 =?us-ascii?Q?QdOQFMYqXraA+SYB2E/elVsLUbRCmlEyn0j9v15w1Cuaxq/mlO+4bvciIqjy?=
 =?us-ascii?Q?5mYmecwQS2FTHk0n/acfkvqJ234mQ4AuWRfCmZo9OaMDpDrOS/zmZGPKLU5g?=
 =?us-ascii?Q?4692OkBRVVqHcpNi5INkuZFRBGGKRmDseJZ7RJzZMV+laEXL5qSvj6NoY4Gb?=
 =?us-ascii?Q?rCEoLV84Y1ft7BKuykMxSYBfM6A/zToGO1AVRf1mk9iv3GUaMgGZuCll4OYE?=
 =?us-ascii?Q?5Tz44jBEddt2/e/f+CVp63+AdRZyT3a5UZxf+hXlHTtej/7VLY28nPHckWd4?=
 =?us-ascii?Q?Zdrh3bNNBolxGm9FjDxNZE+9L4o1di6x7dMeLxgb4NvXoZNLhhoWph0uudXq?=
 =?us-ascii?Q?Z6I036WFKEwBY2Md5B7pFEARNIBIICGLxfDQiy2P1GOfS9VsKofxji639Akn?=
 =?us-ascii?Q?AObsEjpWHVQKCuWtTzuLKOQZhHsfenadDPWmu26jHkY4iCGacyyqzpaaphUT?=
 =?us-ascii?Q?Pp/c9Y4bHbDGkzXZphvHM4noCaGC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 19:59:07.7774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c9492e-8703-4a41-e53e-08dc65622ac7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add gfx v12 pte/pde format change.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 54d7da396de0..e0e7e944a323 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -111,6 +111,19 @@ struct amdgpu_mem_stats;
 #define AMDGPU_PTE_MTYPE_NV10(a)       ((uint64_t)(a) << 48)
 #define AMDGPU_PTE_MTYPE_NV10_MASK     AMDGPU_PTE_MTYPE_NV10(7ULL)
 
+/* gfx12 */
+#define AMDGPU_PTE_PRT_GFX12		(1ULL << 56)
+
+#define AMDGPU_PTE_MTYPE_GFX12(a)	((uint64_t)(a) << 54)
+#define AMDGPU_PTE_MTYPE_GFX12_MASK	AMDGPU_PTE_MTYPE_GFX12(3ULL)
+
+#define AMDGPU_PTE_IS_PTE		(1ULL << 63)
+
+/* PDE Block Fragment Size for gfx v12 */
+#define AMDGPU_PDE_BFS_GFX12(a)		((uint64_t)((a) & 0x1fULL) << 58)
+/* PDE is handled as PTE for gfx v12 */
+#define AMDGPU_PDE_PTE_GFX12		(1ULL << 63)
+
 /* How to program VM fault handling */
 #define AMDGPU_VM_FAULT_STOP_NEVER	0
 #define AMDGPU_VM_FAULT_STOP_FIRST	1
-- 
2.44.0

