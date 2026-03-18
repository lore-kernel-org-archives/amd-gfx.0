Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0896103E18D
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E2A410E82D;
	Wed, 18 Mar 2026 14:09:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XcLGeZ8t";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4022010E826
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApT6zkPMrhJLkqg2uslxL9By7Wo6IZ4ziW/ffh4zHzaFJ/LPz3h8MaSJAv1in2PUDISoljtMECb+I5VVE+flZDd1DzHdMwybsAwE+PZDG/tbimvimDOW33b3zpk5ck2M1+GiKxLvyNgiwVJJpkmUQlcnNPd/7Wt5ivtKzaBSsR24vcta/X3KO1/aDn3uPU1cbga3ZnrDh2Ar+FFPFXjcQcj0gNqB8VTmifChgDunVMOFisqUluxOwN91jTlORDIIrLheB2ZxCBi1ZxUoZd1Uuxv1bFNlBqytrs2bz/Ij3/n4DFWGN61zMII565/nx2e5N6pHiy9wCu9jWN8cJcJWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sz2wuNZh9pTfUqhXT2htmNNkMFAD1A+Gg0lXdTt+23g=;
 b=bB5Cwsxyv85IF3Ik8zt0d0n2DNnS/ft+szTS2mfaS1b8p3/qxM/lxn9diB1bLrPpsvYw9LxBGbXl2hqOTP3T+tksbx6nnU1IC4xNVLbwfBbDjRSuVkZH69K9cjQS8Mp/ANQd/7JSq8FmytsVtn5lAeVH8U73I6UU9SODxo9sI2i4mWKvv7alrFBGWIYcjeDhUaxETE+1opmGxTtRPbJRDk022SFBpmxGDKOwqBTcogvF4zV3oqP2QvPnkrHhb3EuB1kLSb1RUxi4Q5kQmWzF6gGfN2KWuFaIMMctR87ee25WHBoXnYuf2un2ektgmxirVjSp1pN9zaH0UImfnNZbVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sz2wuNZh9pTfUqhXT2htmNNkMFAD1A+Gg0lXdTt+23g=;
 b=XcLGeZ8tbZRh4O/mmOPtBW4W0VFmz4Bvw4N8UU5nmnYxUk4oTqsLujPpQX221b7MBMN0lRxwkOnYX8pNP3YNslW8cDuOjhlENUbCaiKjU5qaGRkuxo8Ttvp+E0P282efV7KnnJkNkOEXf3Qy8RZ94TeCRHNEJlREA55r071sTcs=
Received: from BN0PR04CA0149.namprd04.prod.outlook.com (2603:10b6:408:ed::34)
 by CH8PR12MB9837.namprd12.prod.outlook.com (2603:10b6:610:2b4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:09:04 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::62) by BN0PR04CA0149.outlook.office365.com
 (2603:10b6:408:ed::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:08:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 14:09:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:09:01 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:09:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/16] drm/amdgpu/gfx9.4.3: rework kernel queue priority
 handling
Date: Wed, 18 Mar 2026 10:08:32 -0400
Message-ID: <20260318140837.582776-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140837.582776-1-alexander.deucher@amd.com>
References: <20260318140837.582776-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CH8PR12MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2ca50b-914b-42ec-1a11-08de84f7e975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: zT9epE1E5bd6cWsKbr9LBW9Vf7M+FO+7VNXX4w4gN2XT3fVxV2aM2sZx5g9i6ztRMeMKOwlHI3OVtH0eQbxYKIHUX7hxdr3DS/nV4os5wtmHY1PG2JLkXAi5EE1FNBOe0lnZJ6Hloq2o5iXbyxG81mGfSG5sydCYUgBGJrAAPLHzd68o/6rNANRwljcaMdyYH9LE1lrq7Clg16RU4GPUjTMDbTJGAd2Bt05nqZmT7OBjizhb+Eq0N8clWqeQ+5nUNkXr83dwdfJZGF5EiXFbPShEQ0RJTqkxf8pzwKzqmVtS7BaLHNpHB7ft71p9Yn6wnaCieCFpmsax+Pzy6sYOnmgJrWxo8tAkDoaI0UOv3muy/vlBbXZBAwUIz+90UK/JV4cD2E8rKnVL+DzVzIK3LOiKM9WMd6FWXk3KV5+Go6gyN50GK4GgO7Pkwr0H5XJvh6hlW7PSUjvz5K880Zzh9s+LMuvJVIKWOC1e+yfAZ8EwGPKdJsSdavcqnDSnWsUUTYHkCevStF46z7vIJYz1VPexwRFfmYy5v31zjqKY6ymEbOPcngseKV6K6VDm81ntk0lwLIG6K9RWLnAsJErP11nY+yKzvGvq0HFOXQDsH9tsb2pUmjnTECT2gnVxm08Jx9rUQ9/jV3OWm0tRl14EeMlloez06cSjN8OXb4s6If0pTBQIDXUGvcaUYpH50QGIJNx9yGGTkixAN4HV/rSb/L1bpavHzf1ZHhVEwvI2f7DSt49+FZkY4hH1ZsB4CLVUs1PSckKulICx4bAs6Eajqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7m4SKDBjRgcDWqnS2Xm+nxwicm3FUtu/1HQvT3YWuS4m6LAFUMDYH9iduoWGCFgJG4QOmgXKsaKOuPHFYxwAXOwhCh00BMxKBrzTwnS7MBUHQTsDBKgmL15nGaATJem3akyQ7qp4gZyfQp8a2fpyAPEZt23x/bDqQeENYUHB4shsR2X1YBc5PQERiR3TCbo3y4E7HWNBH43cyR+EnGWXGa4hJEeS2XWxY1IsUsf3Zim/BJGCuKQK8ddJjFK5aKpdT635ilvdxBdW9aIqW3HA+GBuXc8RBoxpxBnDxUndQZ1XL7P68WyGJbM6uYjNZ0dcZ3k8fK/OJOtSErkQX1ceoxiWgX0OckKE9yrk8VoBaBaAhq6ENeThXDrGIkTOOlXs2ejJ+ahicCOOuDatsiattcLKmy31mSpJ3wVO5e+/tWivqQ4lz3fdMfFQKA3tv/Ya
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:09:04.1304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2ca50b-914b-42ec-1a11-08de84f7e975
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9837
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

Rather than setting a higher queue priority which could
starve a lower priority queue, enable longer quantums
for high priority kernel queues. This will avoid
starvation, but provide longer runtime for high priority
queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index d0b8fb9317201..e843793112638 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1946,7 +1946,10 @@ static int gfx_v9_4_3_xcc_mqd_init(struct amdgpu_ring *ring, int xcc_id)
 	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_QUANTUM);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_EN, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
+	if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring))
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 2);
+	else
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
 	mqd->cp_hqd_quantum = tmp;
 
 	/* map_queues packet doesn't need activate the queue,
-- 
2.53.0

