Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE39D1125811
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 17:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6755910E32C;
	Wed, 11 Mar 2026 17:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h0MIdN3k";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFEDA10E32C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 17:43:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhF509g4k1eSHpe9ac/9bhDPtdfz9AtPS/DayP2I5DCYOaIrT4lfmtqMhKYefegklyG8/v7bCe0u3Ych/784VLX2x3Bgtk9qI2jX6gt9mA4BMQCzuPuCnLspWSFj8RW+XtXiUMrnFXEH7Tg0PAXZXMycZUYqBIPF65rjF74MJgokw+TEugDvaCCv8pDE+Xf0uCxUFhpTmn+DUupJePQ+K3aJ6PR0AYMhXfO3w9WoYMc7ZMYfz/zPQuj7z3H4qNNYTFtXW7KLQfsZjkStFGkry/uOVR7WBZy1gkAIqzkk/gv70BJoo/9wbm/NO79N4ZWjtmZKe1At8NM1d2ThGbk//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6z9+P7vZrdSAsAvYxlDiw+Twlzb/mqwR8L4hAC6zB4U=;
 b=cpewN3Vbl4qnityCelk1GX89zW0kWiAkCnY9KtgcYX6TTX5OjcDNTxLPcuc8F80AxP9g0o+h3BNwrhwFerd1kDbMP1azS5I7FFfofnoP+W6TIeJP7He6CdHdzmUUhMRSADBh7GN+sN/kqOcZgUENaBwKvoroUn55MP3h9FyjBaANbbWhewRcwPEsjqUZiqYkbU9exYWEfOK+MitlEfC76EtdG6Ewx0BAelDZTM5Vm89YG6vm+SdRzLD8m4qpbih7UExTYsrLofNGSXdL98dem2F+vLZiRa3Mn8hWZebZRXIk0sEfYt1iqfqF1BFEpy8W272ZFdf9xXQoRa7Y+1vUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z9+P7vZrdSAsAvYxlDiw+Twlzb/mqwR8L4hAC6zB4U=;
 b=h0MIdN3kP5j2MK4Z2F5l97Eg3FMVSre8uNMJiXAG26mRioMWjCus5pCIWV2wo94w7EbjqK3y77MbL+2zdo2vb0avW1qRmpBSycH8PhdhNF+eIwRMgJa7d+Z/yY7Ro6ooHLcwemaFLp8PU0gpnsHkXMzgnTVVxwhSL+K77+tvqck=
Received: from DM6PR08CA0024.namprd08.prod.outlook.com (2603:10b6:5:80::37) by
 DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.12; Wed, 11 Mar 2026 17:43:27 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::dd) by DM6PR08CA0024.outlook.office365.com
 (2603:10b6:5:80::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 17:43:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 17:43:26 +0000
Received: from STXH3-MAPLE-10.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 12:43:25 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <mlimonci@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>
CC: <rafael.j.wysocki@intel.com>, <benjamin.chan@amd.com>, <bin.du@amd.com>,
 <king.li@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>, Bin Du
 <Bin.Du@amd.com>
Subject: [PATCH v3] drm/amdgpu: Fix ISP segfault issue in kernel v7.0
Date: Wed, 11 Mar 2026 13:41:04 -0400
Message-ID: <20260311174251.3121654-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: a95dc57f-679f-415e-3de4-08de7f95b339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: yoaMsx7GvUa+2Xe2FJ1lOrWnbomfv071aNZgU+UJB4FIjgfZJFz46VJxqHBd8Ej80i+qirfDMV9imkKLMFv9iyCGcwR8VE5I30kVQyqM0B2Py332g+NyKNZBacp5VgGwoXGQcB0gOeLIboQB/ScLdJ74vNo9Zy25mP3P26c1MGo+lRHurm1zZuXL/Kd98sAN0RDlOey4SQ/pyDvEcH/JBCqUoah3EaJKXADRrXx8uBk6XYd6BL8PqfgTISOX364jpqFvyscu0aMA33lyy6DR5+LBks1VM/wcwoZ8ZAUs4CmFnucxW10AOi3Zw1GK+a7MAzfgrpnJTuJA9vQdMRIxSHoRJIMXxLNYDyl9wfReOF6yEEtqDNjz7m7c+ybsuHK4UW6z7ruTBrX0iUCn+Bavjpuom9fxiY3yzT4YzIq5nttsOfm1Gme7p80tsZeQ+KDI23ZtkL6K9L2xqXke9pQlt0jZDATteDJxrU/BrvZNgVQGhUqC5ofrS7PnRfbBJEMSzVKSLyY1GsZk9vJdMDJgpowDwIcMSY3JWdLYnkQZSKM/3rIIOTP9lggCTm1nVcclOtA9q0NN+/VZO27xioCBaUGgT9e8tfTsH51/JqvRwDKwo8IkDL09D5GruHEFUARWUhBs92kwrCeseyVAQc3m2wgMgSyKJy9SXh03lmgeacDEnmWCQi6noozBH2yHXdyd6dEwBWNmX2kOhAMQdJrazdgcDaKz0t7fZ+QiInuD2JvJRERhgWZKutoadnCNZefeMjxKpw/oe+52992J5JWFsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d9hxD1EdI0TC52UIP5/TRGBC4qBNsHZu7Dh8TD1c602YxDDx1QUFUlolks8CDuPHmt5BNfloZg30vbVaGbItucWVftOekNOh68j4+eTRi6fBeqO8U9nGjxr/mm4+TZnJjK1nWmasLmpNAhIHtTuPiAIC1OniKinYPevomuPBi2cqfe+kol/kk13BYoI6jSFTe8/Go5p3vm+te8rKFbMUp+ubc82BfJuqSHs/KOut1qEkjKynkEhBrUJYAzQwbBQSc93OEaSpZA40P56wO5usuK/T/YnQGbH50MBfZpmiAf9w6+RX8PBe8xpKark7i5Oslaxwh1yWAfPNgyiLU61wMmYTiYNuCzhTzeDqqOofsdKvmp+n3cboKcbOoVFGDjJ1+JK2D7a5cIRELodbjJC7bKLZrX5IwXH9mG7o6n5neCNxeT1+UO64dJ0lqS425f82
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:43:26.5034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a95dc57f-679f-415e-3de4-08de7f95b339
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095
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

Add NULL pointer checks for dev->type before accessing
dev->type->name in ISP genpd add/remove functions to
prevent kernel crashes.

This regression was introduced in v7.0 as the wakeup sources
are registered using physical device instead of ACPI device.
This led to adding wakeup source device as the first child of
AMDGPU device without initializing dev-type variable, and
resulted in segfault when accessed it in the amdgpu isp driver.

Fixes: 057edc58aa59 ("ACPI: PM: Register wakeup sources under physical devices")
Suggested-by: Bin Du <Bin.Du@amd.com>
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
Changes v2 -> v3:

- S-o-b tag is not applicable when Suggested-by is used, so it is removed.

 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index b3590b33cab9e..485ecdec96184 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -129,7 +129,7 @@ static int isp_genpd_add_device(struct device *dev, void *data)
 	if (!pdev)
 		return -EINVAL;
 
-	if (!dev->type->name) {
+	if (!dev->type || !dev->type->name) {
 		drm_dbg(&adev->ddev, "Invalid device type to add\n");
 		goto exit;
 	}
@@ -165,7 +165,7 @@ static int isp_genpd_remove_device(struct device *dev, void *data)
 	if (!pdev)
 		return -EINVAL;
 
-	if (!dev->type->name) {
+	if (!dev->type || !dev->type->name) {
 		drm_dbg(&adev->ddev, "Invalid device type to remove\n");
 		goto exit;
 	}
-- 
2.43.0

