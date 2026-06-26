Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AE1C43211
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 14:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19C210F61E;
	Fri, 26 Jun 2026 14:44:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KIRKpC6p";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC9C10F61E
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 14:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCOTw3jp/REYadNV+JrZJggpCTpWlaYcXntdcuf9OVg53mr5llA4iIWpr+djCeiaQXGSdc+QdN5bg2jFZtMmMr/+9gf1DQTcUsuE+CcV7Zm5Dp8utTmCLKVAaEviQyncSxbSMxGB8+cXf4+AQsoHjb2wtfvhyeMmuqQF7F5gG+GCbS6RktQN5GMJ8IwQYau+GCBqbXc+dx1RHKm9a9GZdCSCNkq+jtPgZE/h62TP//P3jquJi/ucZcMnzxalg6UuLDbZHKw+/1pdnz3GyEfoBl5WA2x+kNrjXzf88r3WHGUbYCFv1PRaPuvMRvxF0XEcNYBqPPAZtu6RRhd+9GgcOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdEVS1BfZ3bFiLhA8/NbmIHaVHdV5CkU6WvWbUcDpNc=;
 b=ykD/jndYGOI7T4bENGNyHFTMKX/ysMhG52Rt6brU5UFf71ZKKcIiKGh48RGVoSzcrqUZsZES6kedO8r2GqpnrWst7XBABZCHuEW8miTttzhnIKzgwpB93mgxbD/DnXCfmpUAof2Sr+8tlGdO7o6o3Ei8vYWtgcq/4bJ2duqrXYr6f5dtgYFyLM2zmBkJP4AUJ3LbqjFpoRc9piN+6okBw8Q4ikwcVwRF6DcHEB8IKYnUiyRwdegomzT1wINS4WQaCvjsjBogebe3HKR3C8zP1su+P0nBNhabyIbLy/IKTthS+rX5kZLJqoBmuIUjj9ze58U4gr5URhaRdxuJuALNPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdEVS1BfZ3bFiLhA8/NbmIHaVHdV5CkU6WvWbUcDpNc=;
 b=KIRKpC6pQtxC52rQ5QgzvtUhIYZSgIwJeGNBsc8tDbIxXF6NzW6dcWsQ282F+68Epkd8nGte7QX2I/QIiFjcxRaUm/bAkO6IqGCy1HPrnv7Lxytbms2JC5S32vxRuFiYW5f4Y8cVYJa/wALiCWs6o7WNF52IbzNNgZfZczAAbi4=
Received: from SJ0PR03CA0174.namprd03.prod.outlook.com (2603:10b6:a03:338::29)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:43:55 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::49) by SJ0PR03CA0174.outlook.office365.com
 (2603:10b6:a03:338::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Fri,
 26 Jun 2026 14:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 14:43:55 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 26 Jun 2026 09:43:54 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <alexander.deucher@amd.com>, <david.wu3@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>, David Wu <David.Wu3@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/jpeg: fix jpeg_v5_0_1_is_idle detection
Date: Fri, 26 Jun 2026 10:43:18 -0400
Message-ID: <20260626144319.313979-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6b2598-17f1-4108-34b5-08ded391590c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: rssN6yapCkpEg7kzhEKrqvWYkc7SFddzpiSa5dUDA1u4x+SZldrU5pA69YwkO8GxKUW/9ziTLSVCgK1eFwPuJJLPSee+3109Vnp7UjmcFyQAYfsJWf1Xfk/tVy752vRG2yKJZ3nhC/yqOEqqLZXmIX5M2rVDZBf4qTQlPwqLW+sRkk0hJ/fqI+Wea2U2WpmqYdrUGpCPtGazTk6ppQffw28Vv7DoQyB42NNPnh2eObd6b2nNXIYYyOnG/tdufv5wwXX+nbb/ToJiYrk32HFuuZKNAh/SEItYznYGMX/HxrUrhP3XplCirVEYzROhIm/L83uygY/XtFo/GgZsVxSRRnfdOqKzpL5AkOxBHShObXLR+2PVX+gtsO9n1V0cvJoPtO5U55bMBV7mguKyFFUQi+lPNLpfJyGmSebJ1eAUcCxi8YhBEXw3AizPJ6wMqfprW4+/8UKnxxcexsTzmCqmGEooQ+txwae9Fggt6OQav9WD1W2i3Wm1lw9+XO1NdGrHozYn0QBiSnt67d4XyBv9bDmcSaYhs69STNyGI8uWnkRiJ+s4rFLEUtpQxE1gOlrfsvV+dIHUDv30PDAjpAsiyIsG9sOwM762U6V2+gkOiBmexKdCUh+z/tj5d7cvw7I4E+lfX37fgOhwh/oiLGCQ66cHuS/YIAXDe4J3t3W96vHdms73COzeUCr78MlGXyLnPSyld+HEJvv66nD7it1G3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 685tbse9RhKRzrePtRhAuTOdGTDYnuvZtY/tytWRcDrsm6JTlAPEkI3XUwc0yO9/kJtD0GzGr75bb9BLaR9vSCV3CjjUd33hV29pJHCKQBeeUu+Kv/tuE+bItr2IFk1qrJFNU046vmz7toQ1hNl7lfR700NErZ9BGYvP6X8HZz0sFWWS528r36W3nZRlXVs5gGxmWhBppeo0PVmj+gypUjnh1W6o/iN11onnZCqIJacRcjZjy7QM0csPsBcIDu/TGr4NEoGFDt0LY4LvoZtnxtqUBYFwKD/u1+yeNjOj0LJUueVIXIPDH84uURIGzS/5UbAJ+yhVBc1kmq3oLUgNgYwRYIQZGbs53l/SjC/ysTASLbOvQGRAOIZ5CDII4anjRftJlQAIHMcFP2EoOKqU0O0zMM9ELtiNUBz/UH+NaC16GJdWG/mxiZmPJC/xu/Pf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:43:55.0035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6b2598-17f1-4108-34b5-08ded391590c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

jpeg_v5_0_1_is_idle() initializes ret to false and then accumulates ring
idle status using &=. Since false & condition always remains false, the
function can never report the JPEG block as idle.

Initialize ret to true so the function returns true only when all JPEG
rings report RB_JOB_DONE.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index a562369d2d81..01cafa6a4fed 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -674,7 +674,7 @@ static void jpeg_v5_0_1_dec_ring_set_wptr(struct amdgpu_ring *ring)
 static bool jpeg_v5_0_1_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	bool ret = false;
+	bool ret = true;
 	int i, j;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
-- 
2.43.0

