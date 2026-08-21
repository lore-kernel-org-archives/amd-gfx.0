Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E78C5DF97
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DADF910F354;
	Fri, 21 Aug 2026 16:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L6UZa9Vk";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA4B810F352
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x59CfEiA3KHsDkDjq7Y0sO5xlDf1BEzbboOzxJ6aQ8wJ/FN01WA5FWJK4vQTFgjc0nIt5rEe45b98nNCsVrBm0Q9OU0/DqZxwPb0ELGhG4iEl7iQSJZhHf1EjMid7pez/9vjp8IBqyBPRe9JEfsMNmBuH/F1ymxf3H5QIvh4p0hL5yBlbiOtQlMlKbjnKkJ2gW8v4cAwQ1QQwUs1SUfVJmIWDUa+AANhnJWp4SfrJK1RTWaEuXPkJ4BigwrQ+XnzmW5J0YePK8B0cP2ES9248Wocm1X/9WiZwnJEH4suIakCDvv4gqJW2Bt6lSdg/BetTXqCRJHqUNusuJ5MzQo/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+eUcOKm81POKiVSERFdW47+c4Q6lWCx9RNDwYgBDmo=;
 b=qY/2aiEA6Z1GdS4p8qaryiVSPlvlzsvzWt6+JoqP5ewbrcoewOBaQDKm4jJ58J1bQjCbeQvXOjeWGBUW2tI6tQ5aiS9e8bSqLh1TWFsqbI8OzRZxXd9/kFDsQUJC2HJloDRpDmrbKLfUNQ+ctdBe3u3oXu4y2F+450rGlAk1VpF6f8Wv+2MXTEEkjpNtRghcMX2ngZFdE6Y73joj+bGeRg4BDXn0/KkrbkiNzyunAicOygTltj8SRPk9HUMfO4oCFkqUgzdbdfANYMfaT48l7GdY6mkKXppr7tNYSrr0md6w05R63SQS/7Ry4/Lht2k+0c3zn9ycNadybaHPmJqIQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+eUcOKm81POKiVSERFdW47+c4Q6lWCx9RNDwYgBDmo=;
 b=L6UZa9VkXh0OTfhOnCq24odQdvdKCkvWXU6NshQy+mp21NhmWdDMf4jgXR1NDMUfYLOLj3NmVyRqAo2FRFOqIEu4A8d33RwcFvcr8HrhEr/QMZunzN6dGdgByDrH+UmWcbuN5JzrB5Ivv6fy4XAarUfKokZsxW1d8pr3OyDsyo0=
Received: from BY3PR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:217::23)
 by SA1PR12MB999230.namprd12.prod.outlook.com (2603:10b6:806:4de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 16:07:35 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::7) by BY3PR04CA0018.outlook.office365.com
 (2603:10b6:a03:217::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:07:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:30 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:07:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/15] drm/amdgpu: declare MEC_1 and RLC firmware in gfx_v12_1
Date: Fri, 21 Aug 2026 12:07:08 -0400
Message-ID: <20260821160710.752459-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160710.752459-1-alexander.deucher@amd.com>
References: <20260821160710.752459-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|SA1PR12MB999230:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f2a604-a881-495d-932b-08deff9e5056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|10067099003|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: yEXQg5RqbubHIfPsFSOJ/I0Z8+oiqg57yy2vWhEOUfFatzLrMX500EHertYZtqgdDbw9NV/9KIyEwnh555RgZN20xDJbtBn3oWItp8C0CxCMVYCF4oSvZEUagzWhNZ4TkuAJdTN4HBbLRPwAyyzeH1q+hk5wcEu5BZKlfEFP0w5PDh+nefX7cWvzdPKx2USSg/brhTp0EOKMvcwCXCGU7PX7o4ktmZqIP+euq2xouHaX2aKCXiYppxh672aJDOFYZ8aCQAJT/H9YjVW3/RFHjNu3az3mfIh4+/TfOex9RbzVW8g2pp5p8EZkTVnGPQCKhY762IjavfVMB7s+nKG5hmIyCbS5xTcImIRWUwgwGtbcPGnzUERkKSP6Zdo5lRvrSqYXQEJ4jW2Xd4+XV9gF+GiBW97r6LqyyRgVpKAp3TEFnRjuxFyXTIuIEErG7CXiGAPRkJHOxlmyoEZQ32KMMoCRF4DHoW1cMkoP6Zose7BR+C16lmaRUE6L4JBiosC785ncP9CLg3oHuDH2Pzr62ZkOog483WPjH6gkLaNhvbpWbEm/I3vtzhYdabmBSa7NaP8NqFHdW8etqC7xKWWg+zQgDSXq5lAWA9A5fWr1j+wWUHj9zTMfQHcFEmSuAUdpeEOJ5EvsreQwEAAfEg1jqn99gf7wATMQJyATOWU0AwIL8SeNAuTew6FJZTIRQ67hheDA+QSQfDIAsEmWdHKDNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(10067099003)(56012099006)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9HSZZDCr4g6Xypuk84UNzdIlZaMwMhC/5yupwXSM7/YsHsVSG1dx/54d//Qt2ceE7QOtfv3nvtTKBUZBVEbBN4lw+YwyDmxwOhBKOucMarmE+15KoaMPIFu2DIdQh3NhtWj8SMoH6c7v8it3pD/LK+Au7zBq6St4kSDT6dAoY+6m2xzRuzEoY0iSRn2e5KFhxCE7CQGtQvn1sS8GrC7RdTKDL+zlUwFTfC+ssL7HCWCqzJ5g4T99LGhOwwYXsxzgYXlWReRLhfcTknT8WZkn9GI8ebHFEuyRId/TB6/Pnya3lmUPNPJ4xWZtqlIIA4gHgB/0HJ7Wff9TNfXdp+mJo3XQ7T9UTTBhIIYHMjfO765YH8XZet7W13hBsJx48+MHdaw7dQIbnVPGlCfL08DUKpu1pcgwvJSiq6wXtnUyyf/EjsJGFgoi2p4JXwWCtKjH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:07:34.9872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f2a604-a881-495d-932b-08deff9e5056
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999230
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

From: Candice Li <candice.li@amd.com>

Declare MEC_1 and RLC firmware in gfx_v12_1 with MODULE_FIRMWARE()
so modinfo and distro firmware packaging pick them up.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index beb7d55e14771..55e21359a8129 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -61,6 +61,8 @@
 #define regCP_HQD_IB_CONTROL_DEFAULT                                              0x00100000
 
 MODULE_FIRMWARE("amdgpu/gc_12_1_0_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_12_1_0_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_12_1_0_mec_1.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_1_0_rlc_1.bin");
 
 #define SH_MEM_ALIGNMENT_MODE_UNALIGNED_GFX12_1_0	0x00000001
-- 
2.55.0

