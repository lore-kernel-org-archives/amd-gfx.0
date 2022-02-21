Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B2BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 22:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1271110E4A4;
	Mon, 21 Feb 2022 22:31:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76F5F10E4A4
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 22:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHr3VAzTGWxQt7ib8lrYqRoWucpkHrhSg9P+MK0fJw1aaFkz5kTbYfNKYPyEE+DYth9RU5O8c8zIhm26SADIIxQrw1X5NuT6QTmkeBGsp6uvNHtvrwe569JuHPg4RLbxkwMaXgoLUembH2XkJtdarOCzjuoIY6Zs6KTsBIzEN+he1D+Az3aa/pnchJHF/5rxeP3xbaV6m3zjvGtCPYsYrXZx+NZ3mBgayWsDIvxTnLcbbP8aX43rfxEinMsvPBBSCBsl3k6TBWn2DzxUnOyuIKXhLf37YtFq4GDgXwFqxr18KAhUS+UAMjW+4F8IQdNswmwhEEJndrAtORWqwmx6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPvM3fkyfDMUW217C+wr6D6KnegerEM1i94IX+e05Wo=;
 b=Ue/LSCRnyxT9rh/Lo8YnbQ3OZQrAGyu0a6ddyoLg9UBCrzyGmSYTZS5VSv5Oqliy9/9IKGOEAr1QOyfKQJSQs7WsTWzqMZi6B0Zxpd2FttC+4Szh0Acj8O1H71hwIdZVFOnn9Jl6Uvh+dsbuSfAYnsJ7fa7Y7ENw+jv5ohATeZW11Nyn8qsrcp0GBSazoBNYK/Hhlga7y0f6074gRp2HHXQzSgjNhmic5yysP4IQMCPZ8xdCEEODnpPEmgV0KFRbq9g0hAWeAlO64aHSWBOj6RPNEmVzJpYNXyF3YAxyClyq9LDEqpcgtKk5L3wUtAHK7UC3U5DX/+cbTvTEA6l7MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPvM3fkyfDMUW217C+wr6D6KnegerEM1i94IX+e05Wo=;
 b=ny32xO3JKfKGCjViqnZtZj0XV+gu3KZG99PiEsQsCqntwIgXdXlmDTO8xgX+LnTLO5zOo0s0uAcWmgxq/YBtYcn8UUBdn7eoOCyuGxNSgr4Id1sXkvBoGjyeUsT9TcD3TDXIDz3WJ5PhvT7Avyy/Gsg7gX3G6daTWxBms21H53k=
Received: from MW4PR04CA0294.namprd04.prod.outlook.com (2603:10b6:303:89::29)
 by BN6PR1201MB0163.namprd12.prod.outlook.com (2603:10b6:405:56::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Mon, 21 Feb
 2022 22:30:57 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::b) by MW4PR04CA0294.outlook.office365.com
 (2603:10b6:303:89::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Mon, 21 Feb 2022 22:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 22:30:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 16:30:55 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: use kernel BO API for benchmark buffer
 management
Date: Mon, 21 Feb 2022 17:30:29 -0500
Message-ID: <20220221223030.5672-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9f41512-8b4d-44f7-df30-08d9f589d436
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0163:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0163C462DFA953C28368EB40F73A9@BN6PR1201MB0163.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eq9INPxJc4r2RWdQypMON+nDrNOMtvLsc8I9ngLQYmf6yTOE1UUVw1Q5TFu0kpAqlUdee2spAdH/uH6yneg2x0xWEgf/uj07S+PdJP3K5jhNDDKzGe935aU+hxKwyk5a12wWyfyoOD/h4JmCeuyn0hhObddeGHDaNikiGVA+WJe2twF+GvnOwxlTNMy5URk/kOroaoop1mnx9KjXLV9jNPVoqsbHe5BDIlBHRMYjNh0UvoMFtujf9O2ZHjug48d7jJxwhKUzcONUw/M/tczBxmPkl81ik5ht4q0PsdswZkDIYnz5MK6T8ZfyabLi/j4FsMMeTRjV0oaBcAYj7kfyc3mCSByi2Dp1q7BMJuJj9BTrtkFbXxBfrQmPJMdsyhnKP+2uftEPN6n+Xe7rjvN8admWVHoeBj81QsZrWOmPT1eZCRvI4krfkESBg2J8vGynMH+981vJouQxt3BLKCSpFsvitax1WiOSBRspbIqpomnR2WmZMnibQIaw47Bo2YSyCSIKmo5UwnonHJJWrQhfvybYf9yuGoX1G/t70I0HRAuix0PMGyGtNmKoBTs93oF34o8Msjj/lI7s+qPR1OVlpxa0IzV+rMTOmj2gWs9ekk4UGeBw/1xdWg3FS9uyd4Sz7Qu4Ppf9b/WRRVKnSbxJ4KRda9uTPRdeqoDADEh2dESbsoEqfkJUA2zKNwJtiu/bTpSLhXGgFhY/0dkepA7E6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7696005)(16526019)(5660300002)(70586007)(1076003)(4326008)(2616005)(508600001)(70206006)(36756003)(6666004)(316002)(83380400001)(6916009)(47076005)(426003)(336012)(186003)(8676002)(8936002)(26005)(36860700001)(40460700003)(2906002)(81166007)(356005)(82310400004)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 22:30:56.7451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f41512-8b4d-44f7-df30-08d9f589d436
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0163
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Simplifies the code quite a bit.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 78 ++++---------------
 1 file changed, 17 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index 4f3cdd8cfb6a..92a2ffefe62e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -75,57 +75,25 @@ static int amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
 {
 	struct amdgpu_bo *dobj = NULL;
 	struct amdgpu_bo *sobj = NULL;
-	struct amdgpu_bo_param bp;
 	uint64_t saddr, daddr;
 	int r, n;
 
-	memset(&bp, 0, sizeof(bp));
-	bp.size = size;
-	bp.byte_align = PAGE_SIZE;
-	bp.domain = sdomain;
-	bp.flags = 0;
-	bp.type = ttm_bo_type_kernel;
-	bp.resv = NULL;
-	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
-
 	n = AMDGPU_BENCHMARK_ITERATIONS;
-	r = amdgpu_bo_create(adev, &bp, &sobj);
-	if (r) {
-		goto out_cleanup;
-	}
-	r = amdgpu_bo_reserve(sobj, false);
-	if (unlikely(r != 0))
-		goto out_cleanup;
-	r = amdgpu_bo_pin(sobj, sdomain);
-	if (r) {
-		amdgpu_bo_unreserve(sobj);
-		goto out_cleanup;
-	}
-	r = amdgpu_ttm_alloc_gart(&sobj->tbo);
-	amdgpu_bo_unreserve(sobj);
-	if (r) {
-		goto out_cleanup;
-	}
-	saddr = amdgpu_bo_gpu_offset(sobj);
-	bp.domain = ddomain;
-	r = amdgpu_bo_create(adev, &bp, &dobj);
-	if (r) {
-		goto out_cleanup;
-	}
-	r = amdgpu_bo_reserve(dobj, false);
-	if (unlikely(r != 0))
+
+	r = amdgpu_bo_create_kernel(adev, size,
+				    PAGE_SIZE, sdomain,
+				    &sobj,
+				    &saddr,
+				    NULL);
+	if (r)
 		goto out_cleanup;
-	r = amdgpu_bo_pin(dobj, ddomain);
-	if (r) {
-		amdgpu_bo_unreserve(sobj);
+	r = amdgpu_bo_create_kernel(adev, size,
+				    PAGE_SIZE, ddomain,
+				    &dobj,
+				    &daddr,
+				    NULL);
+	if (r)
 		goto out_cleanup;
-	}
-	r = amdgpu_ttm_alloc_gart(&dobj->tbo);
-	amdgpu_bo_unreserve(dobj);
-	if (r) {
-		goto out_cleanup;
-	}
-	daddr = amdgpu_bo_gpu_offset(dobj);
 
 	if (adev->mman.buffer_funcs) {
 		r = amdgpu_benchmark_do_move(adev, size, saddr, daddr, n);
@@ -141,22 +109,10 @@ static int amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
 	if (r < 0)
 		dev_info(adev->dev, "Error while benchmarking BO move.\n");
 
-	if (sobj) {
-		r = amdgpu_bo_reserve(sobj, true);
-		if (likely(r == 0)) {
-			amdgpu_bo_unpin(sobj);
-			amdgpu_bo_unreserve(sobj);
-		}
-		amdgpu_bo_unref(&sobj);
-	}
-	if (dobj) {
-		r = amdgpu_bo_reserve(dobj, true);
-		if (likely(r == 0)) {
-			amdgpu_bo_unpin(dobj);
-			amdgpu_bo_unreserve(dobj);
-		}
-		amdgpu_bo_unref(&dobj);
-	}
+	if (sobj)
+		amdgpu_bo_free_kernel(&sobj, &saddr, NULL);
+	if (dobj)
+		amdgpu_bo_free_kernel(&dobj, &daddr, NULL);
 	return r;
 }
 
-- 
2.35.1

