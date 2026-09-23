Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84D1C9830E
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19DBB10E4EB;
	Wed, 23 Sep 2026 15:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="htGBfYzi";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011058.outbound.protection.outlook.com
 [40.93.194.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE11E10E415
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufnxLnGRrZYB2cRvDlNE/1w9oBeUt3/1R/jWdw2lDThfBE5FgpysKfEHaUgbvGKyt4OKLSzHh7tpkbDmqNGwyQdFY85emD8uyzuD9tHc4Fznt7wUkUBZBXtYc8nNJLt4t4OULKUc0shbqv9I4M/A3voKQwtOgfOYOBmkcGHbuTyGFXakCyWMrz7YIbKfnzqTQ2QgjmWIckwawJy7WWupds37DfV+Gw54l/AGmIphypYlboeOQs5cOUbjLEWg2noVjUXRW5FquQG0k+IRirIRgO7zQSdxCQE3NJ/YqiJ36F1RxiDSiMGUxaC1HJ3fikyvJK/EoRTzexEp0SQGAuzE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3nI0jFq5BCf3Nc0v23lN/RVykyInauEL8RA8fL7hrA=;
 b=rVn1xXBeRDJ9iOKtMGnVO3cT7nBINMyTbzM6bGUXJ46+d3nKz8gpVku536pHZFQl16GJsN50EV5tAXFce6XCChHRKDYAvYF/NQ1IXaCPW2UZA1j9woMrd7bnfS8/u3r3x5oKZcrTKKGer2Q+e1UhKv+FPuEuCji/uopcquoMN4PAF5RxzgGoOmV2RWjqmtsSDhr74xxuQvtIgfyttInE+pvpGJ11Rp2+ms7hnNJ9m9vBcTDbLdVCOW4+Jd0RvpjZW3dWf13YzOk/FYzsk96KiPrzzGU/3Dn7nSPLsDZ2Ir89i1aTpxBAj5haFOe3426lkzvrIR0zUluIiZ044StgJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3nI0jFq5BCf3Nc0v23lN/RVykyInauEL8RA8fL7hrA=;
 b=htGBfYziLhgRTGpdotGwPYj3Lb60cqPtYBTP7IXQSFuxERIBvkNfApJ7+2OQhrUM5uibxux7SNtYhjnYyMazDDSQN35YSOpnKr7LXURC89J3feIaZshMify6TvKjRskojQJ4WqhVhUsBlN/VUpkvgu5cv08D6QTYTf0v/kjawjU=
Received: from MW4PR03CA0191.namprd03.prod.outlook.com (2603:10b6:303:b8::16)
 by CY1PR12MB9673.namprd12.prod.outlook.com (2603:10b6:930:104::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 15:12:39 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::14) by MW4PR03CA0191.outlook.office365.com
 (2603:10b6:303:b8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 15:12:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:12:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:36 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:12:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yang Wang <kevinyang.wang@amd.com>, Frank Min <Frank.Min@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 04/12] drm/amdgpu: fix ASP 15.0.3 runtime DB offset
Date: Wed, 23 Sep 2026 11:12:18 -0400
Message-ID: <20260923151226.2778589-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923151226.2778589-1-alexander.deucher@amd.com>
References: <20260923151226.2778589-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|CY1PR12MB9673:EE_
X-MS-Office365-Filtering-Correlation-Id: d7115c32-f4ef-40d7-e0fd-08df19851b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sr3eERMw9LPMz0ktE4Xgdlkc8Hb2hsuoJz0OFVlMDHEh2nJLfyePpO/JsQtLRw1Dvy5v6idTbz3fg3l6WrBwsSJu+RwGDPI3NoT5ygL8hYdOvfnPsy10gktsJ/Sv4YbRH0I98wK0pdeRb9bDZa5uT4wJG9m0GsqlYb7/wFWlyzL6XXIo3he6mK3jPQcN/Arn9xceCvIH+yEtoQ8jaS4/RvB8vdCQfszUHa+/dOiZuZytY4B6FcrqNqQylYBKDfPcTSioNMWfLZgra3C4mCnsps8k7LrOovPA0pu8n3TQYp5UZ4KXL873U/KqEA+a8//a0p+oJXc1H+2GSSk5QinKwwiSpDtBXwzEZtA5f2NcsLxSKLqxVUtuNw99+33rk7RmYEN4QxGJ6ttFiHXY2HptBDNPcgn7QVBvEpy8AcUKyMUaYjqL5+db8t7v/wSGEDz6p5K37HPLurDz4Ac7EnqzFsjF85xGKHhcxt1N9tvoe7th8uGP4JmDGMA8f2249++iH7A4yzUh5upr+STUPMlqVADPxytXeTjFklnhELHPRgmMLy6KAmvCPuLdmecwK1gK6s8hRjmV4sEn+/DopPFye/qIJZuIGRNsvRkRnO0BfvNJJyGMTM/FLzUTTNeXcc7aoDwpKgPxYExqCcqI9JOrfd0JMuqaAi4iAwhWKPfjama6wtWYub4H/yVkcJOX5BM//wQ9LIC0TIZk7BcyLAnIJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sw6XKwIHip/thGfjPWeuDXl6jrQZ3b2nZLP36IbS4ZSAoOIdiedwVfmcDnp7EnjO60AtfgRhB4GGzhcdZ7sEVyLFJjOGuk/GmYFnEwj/FbUYDHkhYajXTBSGOyp+ab6deAfNz0XI7QrY+3o+w7A56+XBr58POcPnH7zYBBu4ltfQt4gE1fDa1GcDhH0csByGPJM7tIYvt/atmI7JZ2at15w9ByiW6xBy+T9/nNmdyiMrkXG3qC3tgGfZ/Z2VPEj8xPKgeEeN8HRhue36AiB2sRZhyBwsplk8e+grSIT5B9UMvu9HKkMHQ2XahE9+r5xAGt0uui5EwoM0TZr6UF/aizC/5z/8Br4YJHOM4cuwWLyD7C6sKa4hz/JUT7FD6ii5WwoLmwDe/j/Bn0goGNBAIGNgVCarVKBQVGC2VuLniPHJxRyn8ZAdais33W0/mfoU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:12:38.7848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7115c32-f4ef-40d7-e0fd-08df19851b4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9673
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

From: Yang Wang <kevinyang.wang@amd.com>

ASP 15.0.3 stores the PSP runtime database at a fixed 64KB offset from the IP
discovery table, not at the legacy offset from the end of VRAM.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-By: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 18 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 +
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index fcf7ce0e971b4..0b5e8373855aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -383,6 +383,22 @@ static int psp_memory_training_init(struct psp_context *psp)
 	return ret;
 }
 
+static uint64_t psp_get_runtime_db_header_pos(struct amdgpu_device *adev)
+{
+	uint64_t pos;
+
+	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
+	case IP_VERSION(15, 0, 3):
+		pos = adev->discovery.offset + PSP_RUNTIME_DB_OFFSET_FROM_IP_DISCOVERY_TABLE;
+		break;
+	default:
+		pos = adev->gmc.mc_vram_size - PSP_RUNTIME_DB_OFFSET;
+		break;
+	}
+
+	return pos;
+}
+
 /*
  * Helper funciton to query psp runtime database entry
  *
@@ -415,7 +431,7 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
 		amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 15))
 		return false;
 
-	db_header_pos = adev->gmc.mc_vram_size - PSP_RUNTIME_DB_OFFSET;
+	db_header_pos = psp_get_runtime_db_header_pos(adev);
 	db_dir_pos = db_header_pos + sizeof(struct psp_runtime_data_header);
 
 	/* read runtime db header from vram */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index e9822e03e6190..a4ec60f6c3170 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -296,6 +296,7 @@ struct psp_memory_training_context {
 #define PSP_RUNTIME_DB_COOKIE_ID		0x0ed5
 #define PSP_RUNTIME_DB_VER_1			0x0100
 #define PSP_RUNTIME_DB_DIAG_ENTRY_MAX_COUNT	0x40
+#define PSP_RUNTIME_DB_OFFSET_FROM_IP_DISCOVERY_TABLE 0x10000
 
 enum psp_runtime_entry_type {
 	PSP_RUNTIME_ENTRY_TYPE_INVALID		= 0x0,
-- 
2.55.0

