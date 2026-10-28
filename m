Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A5606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 04:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2loWhSj1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385D110E4B5;
	Wed, 28 Oct 2026 04:40:45 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87C6B10E4B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 04:40:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/lExGz+R+S2T/TiAyHBYaTYPzIpsjzkx1ajIFOzpIgVEd2WrQuGy0Lgf1cD4Nk5PZYA2HTrJ7HBaET0+AcLraH6YnNBMCQtAkBFzzPv8omcf/cwt+EJ/zw1QMmvNTb/1BTInSpp2FzE82+1Out+mkE93ZQmKuM67TCBsq27xAJhH72igIuR6miJvdwUqHUN1YJ1cfmJubU1JZvS59cFk1+IapzjHJJj/gvkYbrkbtRyATzc4TiB/MBzeBugjerfU5JPXWkZUYYQDm7oSJZLwKS89H/bBfnLyQLAyz9yz7985LBFq9YPE4jZHBnn3JDmPzNibtnBQQ2u7Ut4A0KM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNwpifFpJ+uWz+Vx3Hkez6HepGA5ZRWkMoLC3y1G1Lc=;
 b=iiEpvEKwKpmY94EoVpvoVZ5z/E0ToGxg2Dc0ziatPKs4CSJTiN0rHyZGhF7Ect37GjvcUA1NsM6nA+yOVbnnHS3SVsZCgSauYpfhwX3TKLQOkn6CsJmNCpfyqNuwfJhpoZj7Gcn7uvwxt6WCtPbJFfgI0lYL9hJoDLX6Lao2DIYMYABz0z28GG33z5wUbCdMlmh37jcr/vGbyQyyiliVpN9h3MbcNH/0xC9XMY6yESUzpiXFP6ddUuXpvvpL/4sGitPBIC8mv1u7NNi+lMjWQPRopZAtyHM+8RHMRHQsu+bF4T/xszJwqvJIM/zD1KZUAdK62ss/r+UCGMEOQIN+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNwpifFpJ+uWz+Vx3Hkez6HepGA5ZRWkMoLC3y1G1Lc=;
 b=2loWhSj1px4WtyJjR1k3KN+Eza6/Tw9PWkrD04OeBi/3lgFBoIX8m47b/hqpOd8G9ptYLVBFYeBNTFqJC8qhM7M+iA5S4L4qNr186cry380PeqxSRyYXJzMJzxtG+e07KWwK3Te8lu3XjU8o+Iu5RPevdz3qEDNETR6AFdlNlc4=
Received: from SJ0PR13CA0008.namprd13.prod.outlook.com (2603:10b6:a03:2c0::13)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 04:40:34 +0000
Received: from CO1PEPF00018866.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::18) by SJ0PR13CA0008.outlook.office365.com
 (2603:10b6:a03:2c0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.3 via Frontend Transport; Wed, 28
 Oct 2026 04:40:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00018866.mail.protection.outlook.com (10.167.249.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 04:40:33 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 23:40:31 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: unwind init failures for SWSMU
Date: Wed, 28 Oct 2026 12:40:21 +0800
Message-ID: <20261028044021.896657-1-kevin.wang@amd.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018866:EE_|PH7PR12MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a20e33-cac1-4652-5a1d-08df34ad9aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|261026140227099003|11063799006|56012099006|261021123027099003|261026121527099003|261021121427099003|261022075727099003|261009223027099003|10067099003|261022105027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 7mdbPNdYRSWe0B3FAq7v/J6qX8ELombP//4AGP2Avo1D/acGInAMZzb4CCJQlGqu7qzJOwQLATTIpMQ6uOALyUYrB6OdU9c2OzAUntCkwOWbLVSZHCkVhQcNVpF4zFe7RwDCkt1jpQ6twdTrVv9z2xQEP/Th40omKPcDQSKf0wcAGFHQcxbJo1+XgcY1sU4mMS0qMOCJmSRxfLhnfjGPaETPDmGigbHvxJ0+GLec/eRgaeuHXx+CeS1xtVcgSk8FV/A4JvKqp0Uz/HTftyVnrvj5AuK/IuaPhvUIaxAN1Vn97ZnPXWX7L1yKZdAqQ7hKRP34A0o8QrUVZqKYB4PnEGAmeyuK/PZ71Ztd8hr0EyhtMofgDrr/MeWcQtzkQ115LKD1D8M5LJlqaY/IMH6ykvTJ9qJdi96i15xtgN3j/blvvs0SeF+9xMRn8e9/U0PK9930gBjxARPJyjk/O9RYkOFfB8OcxrTCkWDOFXADf56k8g6UFgRy98J6beN448+AMX7Tl/MQPVq1AVK8cCOAE8EkQfC8dsSQliZEnan0h6FrGlPQurRetp8sqp0e7Zs2VsAEtkjRarv5Yt/Mr0MSaIdoP8mUyaR1ejkSEM0dBC1QX79mNBTsZG3y9mOo6do3fMiKkzx0Ws4xkr4fCGW1rctQT0yupSb8DleeFzNm8q0b/dAwlZugt5zXjZ+mf0tAwFVSvwn+eaBpSEPJlhTrgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(261026140227099003)(11063799006)(56012099006)(261021123027099003)(261026121527099003)(261021121427099003)(261022075727099003)(261009223027099003)(10067099003)(261022105027099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mZGLhGzLssoDwJJcuBrX054O4bq+mU3tEjJqCpeohZaTuE53qtahFbJGQxgt/VplmV/pImNA+SffOKCrXsSaybDBFsFdy3qihmWaYVCfjBzDlykIrb7WbfEww/hp8jg0TR485JbDar0FV39NpNcqRp1Gpm10JdFPUMtrqXc2gTPJk/uwiTReM7ktfJ5FdmqyTEdpkymoqHFS3xNHEaIT7SXSyi6YuvSjd4C0Ko6dAmwjWaAFJd5lVDqOUxaLAy8Gq2d5GsOsvFbqEpKXUi9nuwG7JGIAO8/H1ucyBgW6hJDxhEnJXwTQIVmc9wAWWffXvXTCTutKdHEmeHVHFScGYZPGfOL3KlryuegqFAQKxzFoMJTJQujh6JS+OqkK4QXlQrE8bFD1R46/8T7C7iikXzKImTbLHFyhSEJB0MYWW6BYVgZrBWAkIH5U6c897sMW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 04:40:33.7578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a20e33-cac1-4652-5a1d-08df34ad9aad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00018866.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654
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

smu initialization returns directly after partially creating software
resources. the ip block is not marked initialized on these paths,
so the normal fini callbacks do not release them.

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 41 +++++++++++++++++++----
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1915413ccac3..0f5b7a2e3fff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -883,11 +883,24 @@ static int smu_early_init(struct amdgpu_ip_block *ip_block)
 
 	r = smu_set_funcs(adev);
 	if (r)
-		return r;
+		goto free_smu;
 
 	smu_feature_init(smu, SMU_FEATURE_NUM_DEFAULT);
 
-	return smu_init_microcode(smu);
+	r = smu_init_microcode(smu);
+	if (r) {
+		smu_fini_microcode(smu);
+		goto free_smu;
+	}
+
+	return 0;
+
+free_smu:
+	adev->powerplay.pp_handle = NULL;
+	adev->powerplay.pp_funcs = NULL;
+	kfree(smu);
+
+	return r;
 }
 
 static int smu_set_default_dpm_table(struct smu_context *smu)
@@ -1243,7 +1256,7 @@ static int smu_smc_table_sw_init(struct smu_context *smu)
 	ret = smu_init_power(smu);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to init smu_init_power!\n");
-		return ret;
+		goto fini_tables;
 	}
 
 	/*
@@ -1251,21 +1264,35 @@ static int smu_smc_table_sw_init(struct smu_context *smu)
 	 */
 	ret = smu_init_fb_allocations(smu);
 	if (ret)
-		return ret;
+		goto fini_power;
 
 	ret = smu_alloc_memory_pool(smu);
 	if (ret)
-		return ret;
+		goto free_memory_pool;
 
 	ret = smu_alloc_dummy_read_table(smu);
 	if (ret)
-		return ret;
+		goto free_dummy_read_table;
 
 	ret = smu_i2c_init(smu);
 	if (ret)
-		return ret;
+		goto fini_i2c;
 
 	return 0;
+
+fini_i2c:
+	smu_i2c_fini(smu);
+free_dummy_read_table:
+	smu_free_dummy_read_table(smu);
+free_memory_pool:
+	smu_free_memory_pool(smu);
+	smu_fini_fb_allocations(smu);
+fini_power:
+	smu_fini_power(smu);
+fini_tables:
+	smu_fini_smc_tables(smu);
+
+	return ret;
 }
 
 static int smu_smc_table_sw_fini(struct smu_context *smu)
-- 
2.55.0

