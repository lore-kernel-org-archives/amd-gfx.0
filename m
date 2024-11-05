Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB28ED1CA15
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 02:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D61010E4F9;
	Tue,  5 Nov 2024 02:53:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dnsLkN30";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F5C410E4F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 02:53:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSc74b2m/eFJ/bE3PV9Sp63N65OobJyY2RN+Q3KgjriNIfnDDBruJmK4URhXf1izuF4Xq55uDukiJX5GbZ6cgJNS9ncAeTxg1HxoSkJrdxZJM3BHARWX1mcXAWF1vaezmNMUpsdGPaiIiAI0Exv7/E0EKOoyqzzaN6MDAMLQIWfCDIJaCKP6oFaniHJgMovOhL9VXUOp5gv7gjyrmkwDwQJ12svsxBRapm+g2zDwETCCL1xib+8usspWC/mpW/GT13dlsf7tld+ePefOKRNlyYroXkjrzjk3QCbOnz0p87E/BqpMhoGIins2ukg21dDpaHDvHoBkgwUpXQ63tUWDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXeRXz1Ox2m/SQpIGgPqsvzvE+1g3izlEMMwYgQqNLc=;
 b=K+l8Ko8diACOLmVPrVihfaJkjsJD+Utz2djcnfPc0X1wxyTUz+Mqgdz/9rgtNPWgBaahDE61IWrBoK7YkuUurtT+rGwZBfHiyxtWD4CkvAqfQ8BX6Exbsjnmi0eKj57r6ShDhCN2YNzlz2fSgg5XHEwDSjhQUPeua9Kv8arlcaMrndQlhPkFck97SW/rTgdkcKldO522HnhyL6TG3PBh0Th/yRxO5UX0Ogr0WQXRtiTZpvRq+XEEFNpTeyMfXHZqFPkhLSY9fxvoIPfbrf3PQnlukeBin5/Blh8HNY9TQOvi/k/eTa4FFS/cEo/IiGJxvLp49WMxaxUAWJA40fHGfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXeRXz1Ox2m/SQpIGgPqsvzvE+1g3izlEMMwYgQqNLc=;
 b=dnsLkN30vaP5S2Jsimwbsnq4oeQ2cQoy8qYJ+N23Hq35ynGGZrtftAYehZKw2AGTpMp86Z1eQtenYeZ8eGJA95UKv3bKjndR1QGXOGB8kQCVdgbec8tW5pCcf7pZq/Jqw7/SUNJ5c9wAAD5dcwGskO7p8XkH7eB59LUIHMwoCus=
Received: from BN1PR12CA0007.namprd12.prod.outlook.com (2603:10b6:408:e1::12)
 by DM4PR12MB6613.namprd12.prod.outlook.com (2603:10b6:8:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Tue, 5 Nov
 2024 02:53:00 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::79) by BN1PR12CA0007.outlook.office365.com
 (2603:10b6:408:e1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 02:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 02:52:59 +0000
Received: from lc-X10DRi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 20:52:27 -0600
From: Chong Li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <emily.deng@amd.com>, <lincao12@amd.com>,
 <dejan.andjelkovic@amd.com>, <zhengyin@amd.com>, Chong Li <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: fix return random value when multiple threads
 read registers via mes.
Date: Tue, 5 Nov 2024 10:52:09 +0800
Message-ID: <20241105025210.30636-1-chongli2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DM4PR12MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0959ac-ebc7-4bc0-0ab7-08dcfd44f582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fOJC5BiYbtNG2wsmrbfeF6aTtw7r3ToACjQA+/h7JNh5atcLhofXq7NGVXlK?=
 =?us-ascii?Q?Pd42KhrUXUoRg93f8gMVQ0iVmaY4keGM0bgicq1GHRM7n989KXn3zOf9gjxK?=
 =?us-ascii?Q?Sn8EBq3RUbckhik97aOesbALKTMYKFY8n32kMpTeLsVeh86wh5zgXWB96/+p?=
 =?us-ascii?Q?E9Ch6H2N0sbi6n/i6sjtftYxCQ8Wt+z3ytWX/z9Q2EGQgJsQ2K7jC1cWKe7Y?=
 =?us-ascii?Q?evhUx69IOd048+/gNMPuK7CwRe3Tc5G2bcyH6JqzBxXogRNT37Dz8PDUJKIA?=
 =?us-ascii?Q?ZK//yw7A1+9uIQ7h0QMj01v4WDvi08b82O1KjJwfAACOOyaeIrJbuWRGUUkg?=
 =?us-ascii?Q?wdKStRE9v0dgn3fRrceehl/gkZlnVsjWY9YCa92P8eO3xeO5luqXIZ/PExE5?=
 =?us-ascii?Q?5LOna5aSxdz0geh5rAE1ghPvAtuaPMskybw+pW3bpYDrCvF9To+VeVtpt4Eh?=
 =?us-ascii?Q?k+IbS/Kv8FRnw2yJzt4wZqGzw6TKP8aEvoEuD+hB5YrnZkqQTIu5tmGuDYOe?=
 =?us-ascii?Q?Uso8zmgOfLYkOR1/cY5QbwPdxzV93o20DeIayiDz5ywlqvYr8wo0lLuyEZjF?=
 =?us-ascii?Q?Q/jHjYimonpGufVUmQ+bV136N8X0mSamYsUHUlAmbQHsAJEqMcixOjR1c1Go?=
 =?us-ascii?Q?3h/BDJ7RX+MK2MyN577kfRo9FXLK9yPTdzS9LkqLSDFLMU8E9H2oP1JbySmU?=
 =?us-ascii?Q?aD6+vVRs3Z+dj0vjLQGaORpEUWt+UN2aotFRaS7nRlolCvQevnxpUWVENoS0?=
 =?us-ascii?Q?JAxkbVQc8pKndRDbZcoMPX9yhp1Ag/1jgv3jlKaT/6PpRHJojzzNrWnGbIH0?=
 =?us-ascii?Q?E6Ox6FojzHLPACXPQLFQUiwmmtxOnW/1ZycqEKisM8fEg51EiNqGII4DSu6+?=
 =?us-ascii?Q?Nx187b7HKOo/exOzSkV55OU7BJQ8N/2ZxbXfM2o9Er+NGpDHuZn3y5n2XIiw?=
 =?us-ascii?Q?4Nam1TXJWksXECAGvTmRTGZR8lX+19xAw0yRdp2mIVlHGZNd3SKZXIMgpCTY?=
 =?us-ascii?Q?FLfqkiOiLtUOiTj/YXOmnvcUO+4hAB+ySCOOHMfAHtj41H6PRCnbV2AoE3YO?=
 =?us-ascii?Q?0K2ZL36On490N8X9jpB0SumD3PdGYzWYnaLPjbGCKqWBQTtxw1oB1GCiMM00?=
 =?us-ascii?Q?/VSyCw7MtF95FNXjN3EXCv8N3fXLPuJGhoC+2E2sfD2qtyTPg3W1fUANBaQs?=
 =?us-ascii?Q?siP1wVvieQKwr/+8W2k8QZItPa6MD0TusEfH8WenLIdH0+tHYFRQYnJcOaX9?=
 =?us-ascii?Q?MlaKvWuz0CXBDpB2EMXCmEZ0rxnySjSsKTfvgesBCwgTUPYZ5NzLtZehcVGl?=
 =?us-ascii?Q?ggPFQhraLHzTcUUpt9G6ouPZcZrfRn35j8RZvsT+LE/xjjqzoRxv8+D9tPBP?=
 =?us-ascii?Q?CEbOYis6hlwejnGZBv11S2TG8eZFsi6OOT1rBmFVhZW53/tXJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 02:52:59.7686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0959ac-ebc7-4bc0-0ab7-08dcfd44f582
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6613
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

The currect code use the address "adev->mes.read_val_ptr" to
store the value read from register via mes.
So when multiple threads read register,
multiple threads have to share the one address,
and overwrite the value each other.

Assign an address by "amdgpu_device_wb_get" to store register value.
each thread will has an address to store register value.

Signed-off-by: Chong Li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 30 +++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 ---
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 83d0f731fb65..d74e3507e155 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -189,17 +189,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 			(uint64_t *)&adev->wb.wb[adev->mes.query_status_fence_offs[i]];
 	}
 
-	r = amdgpu_device_wb_get(adev, &adev->mes.read_val_offs);
-	if (r) {
-		dev_err(adev->dev,
-			"(%d) read_val_offs alloc failed\n", r);
-		goto error;
-	}
-	adev->mes.read_val_gpu_addr =
-		adev->wb.gpu_addr + (adev->mes.read_val_offs * 4);
-	adev->mes.read_val_ptr =
-		(uint32_t *)&adev->wb.wb[adev->mes.read_val_offs];
-
 	r = amdgpu_mes_doorbell_init(adev);
 	if (r)
 		goto error;
@@ -220,8 +209,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 			amdgpu_device_wb_free(adev,
 				      adev->mes.query_status_fence_offs[i]);
 	}
-	if (adev->mes.read_val_ptr)
-		amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
 
 	idr_destroy(&adev->mes.pasid_idr);
 	idr_destroy(&adev->mes.gang_id_idr);
@@ -246,8 +233,6 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 			amdgpu_device_wb_free(adev,
 				      adev->mes.query_status_fence_offs[i]);
 	}
-	if (adev->mes.read_val_ptr)
-		amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
 
 	amdgpu_mes_doorbell_free(adev);
 
@@ -918,10 +903,19 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 {
 	struct mes_misc_op_input op_input;
 	int r, val = 0;
+	uint32_t addr_offset = 0;
+	uint64_t read_val_gpu_addr = 0;
+	uint32_t *read_val_ptr = NULL;
 
+	if (amdgpu_device_wb_get(adev, &addr_offset)) {
+		DRM_ERROR("critical bug! too many mes readers\n");
+		goto error;
+	}
+	read_val_gpu_addr = adev->wb.gpu_addr + (addr_offset * 4);
+	read_val_ptr = (uint32_t *)&adev->wb.wb[addr_offset];
 	op_input.op = MES_MISC_OP_READ_REG;
 	op_input.read_reg.reg_offset = reg;
-	op_input.read_reg.buffer_addr = adev->mes.read_val_gpu_addr;
+	op_input.read_reg.buffer_addr = read_val_gpu_addr;
 
 	if (!adev->mes.funcs->misc_op) {
 		DRM_ERROR("mes rreg is not supported!\n");
@@ -932,9 +926,11 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 	if (r)
 		DRM_ERROR("failed to read reg (0x%x)\n", reg);
 	else
-		val = *(adev->mes.read_val_ptr);
+		val = *(read_val_ptr);
 
 error:
+	if (addr_offset)
+		amdgpu_device_wb_free(adev, addr_offset);
 	return val;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 45e3508f0f8e..83f45bb48427 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -119,9 +119,6 @@ struct amdgpu_mes {
 	uint32_t			query_status_fence_offs[AMDGPU_MAX_MES_PIPES];
 	uint64_t			query_status_fence_gpu_addr[AMDGPU_MAX_MES_PIPES];
 	uint64_t			*query_status_fence_ptr[AMDGPU_MAX_MES_PIPES];
-	uint32_t                        read_val_offs;
-	uint64_t			read_val_gpu_addr;
-	uint32_t			*read_val_ptr;
 
 	uint32_t			saved_flags;
 
-- 
2.34.1

