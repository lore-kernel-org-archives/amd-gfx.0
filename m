Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E025A606A329
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3bTl+HoK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BDC410E9E4;
	Mon, 16 Nov 2026 14:17:51 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012032.outbound.protection.outlook.com
 [40.93.195.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E322B10E9E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 14:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3bpqLaZ5GXIqyhaOqGRPzsVNf1l1sZu3D3px0UV20EMAIi6KFLBDAo4niC9/kwewo3SKQTq55lwt0TT/4dLOx3z5j3rscVCQVWe4Y9N3Cu+9+E/M/Fm3Piv8nXqfsuIhZ822OZ45o3X3Of2mfWCNJPZMQ1wx7Dm5dd4u7vyHt62E0C4OkC3kPSiE+Zt2gO+shN+Ziz3cpb/JEf9or/xDZ0FPMS74pPDOpuWnuH8xdpop5HQnXYZI/si6sE4T096iqUrQVGrTL7a24N7YzZkbeQNOnQkNrEjB7pXKR6R8rjeXw/agdx7sXMNjSoWI3A0TpeEO21BvHDKdDN8TgOcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfXbd5Wg1cxTBKuFDodzY7vYkDuhFtRYCmUwK4MefrU=;
 b=JfSRxpDy8iegRJnL4vu5Sp3JozTazWrbhgPDlUYRrVdSkFUkARmUKceaWr9OhTcn1zHPWtlH/iZ2quWPbSU6eTe1vELzRG+D7MP/TBTgA4ZX7wJ98bR6eclLVzZQu9eUjIgNZJrw6yB65yL4c32ctFDB7koaWUvDTPwZvlYtsNui/BEtfM2LoloIUee42LijHgiXrZZgvhmed9BoQQNPSwj+UmqameJ39OTV92y2Wwz2mQCit6g0EwpnGFWC9gb2cjO+AbBOCI+5QjHdsHSXxxiT0qnPDhyiAE44GZRHk/AWb5d8ycKDd2IoYXnktRKF4o57KA5JQ/Fi0HRPsWEwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfXbd5Wg1cxTBKuFDodzY7vYkDuhFtRYCmUwK4MefrU=;
 b=3bTl+HoKzfC8ZgxMoY7Tl2wREGgCBvgKaiYemmeIH5f0boI2lEsSynzX+oV58z/zhscVJM8BREk2VXO5hQZYX+bDE2IHLnUo4Vz7uQPQscXXquysxseLiX6QXc+tVeLrRcc48r5XfMYV6/fiQw2sesxYKCMR7rxI/jbZglLp9U0=
Received: from CH0PR03CA0113.namprd03.prod.outlook.com (2603:10b6:610:cd::28)
 by CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 14:17:38 +0000
Received: from CH2PEPF00016D4B.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::48) by CH0PR03CA0113.outlook.office365.com
 (2603:10b6:610:cd::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 14:17:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00016D4B.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 14:17:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 08:17:37 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 08:17:37 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 08:17:37 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Vladimir Indic <vladimir.indic@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Philip Yang <philip.yang@amd.com>
Subject: [PATCH] drm/amdkfd: move TBA/TMA back to system memory
Date: Mon, 16 Nov 2026 09:17:31 -0500
Message-ID: <20261116141731.1903647-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00016D4B:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: 83b01e13-c8cc-458b-83ca-08df43ec5e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: RthFJnQD7lGqLBMMBV6xgc8k3ZnRggvw1oUnYTJnas34rdTGQxlQuz2NEVFWzZPeEXNXrYPaOrVCoPgSewL4REtMSAMWqp2nVg07Ag55KEWboqPRJaRtcnvObwzQLpQXcjGPIjaJkInwi4DM8UjOmsMfWpIfzOE1Z5qvbJFVG0XgO+czwQ1eku8tbmnTsJ1xxkQevLNC8yhfMrdtDje8sRq/EVpKpYZVPQvh6DxDyTvBsIr/cQmMvZ/vFK0IuS1YfcVwuttV/lOrRi285UF/mnr1aGXvF3lnlmAEkhdSHWl+TZcw9v7UnmhxOfGGFzKfqo3Zf9QmukO/2aYWKuU2WoTIVyrpki4tp6E8RKR/CdAt4XaLKzgSo77xfnuZ/ZG/gZH5YlxxSfWDO0PZMHv5Toyyb7icb6oFONW0IRY/AMHlRUAdJfcuNiIn9p6vu4qquTdNqvbIG4RvTlFu8iqDWDT7+L+N7LNi9Mz49eifGZSF7Id4RFdKXxnWSVMwlSxxrAVx7N9thRIxpQZUOD5Njx8MDptSyWAOFcTOZzS8V/597UT/QuQiNZrDyYuGuzh73Ap8O9qRSXo5r2DoqiFZlgK/2IUZ31bFz3CSd8xAP4LeawVpLYavZjRO3rj/CZHz/vq4qh4rnzr/+oCDAnIYyKKRirDU8e6ykg1WJCXra1U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oOTyOMGvWvvKKNVRXfgS0YxZsWjOWDft2DBZVMJS4iLpxsiOuefyQ+LfsoaLZ72fKODvs7jCtGLG3n63JfJb6NFo606S1AugIyfs9xgC/YIuu3hhs3cYks+Cblx8rkZPruLCXBruH5eBzY6BUJpsiPauO9b6SH6a/CFgPQgKpWJHkLOJ4iNYVJ3WclRiEIWHvP+9SmjWpI9Tj6HTO+dPSNAx7ZPrr+mgprni6rt+lrVcW3q6JBLMlItlGZuKc9Dn6g0hi9qcG3DGSAwktT6ywcLMcMLBY2eMUN4d5WbIrqpqlxevA3I5BYNFtno9VmYGWhCf7ndUlwOOe4g3crQfxNQza44vZ/qTmerQuBaW4hLNmQzTswURUjxtBaE6/F0KPPkKE/4UOe3XSWmo/5Hw/16TTck0yr/Wz5xStVku3Zbi8k/D1QDTAWqEwJEB8A1y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:17:38.3336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b01e13-c8cc-458b-83ca-08df43ec5e55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00016D4B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For non-MI parts, move TBA/TMA back to system memory.
Results in GPU resets in some apps after suspend.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6116
Fixes: fe5966d4fdcb ("drm/amdkfd: move TBA/TMA from system to device memory")
Cc: James Zhu <James.Zhu@amd.com>
Cc: Vladimir Indic <vladimir.indic@amd.com>
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Philip Yang <philip.yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 546721b4d59ac..7a424184a4a3c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1554,7 +1554,10 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 	if (!dev->kfd->cwsr_enabled || !iosys_map_is_null(&qpd->cwsr_map) || !qpd->cwsr_base)
 		return 0;
 
-	if (KFD_GC_VERSION(dev) >= IP_VERSION(9, 4, 2) && !dev->adev->apu_prefer_gtt)
+	if ((KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
+	     KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
+	     KFD_GC_VERSION(dev) == IP_VERSION(12, 1, 0)) &&
+	    !dev->adev->apu_prefer_gtt)
 		flags |= KFD_IOC_ALLOC_MEM_FLAGS_VRAM;
 	else
 		flags |= KFD_IOC_ALLOC_MEM_FLAGS_GTT;
-- 
2.56.0

