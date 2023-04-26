Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03829C77B60
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 21:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8F3410EA37;
	Wed, 26 Apr 2023 21:22:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19AED10E34B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 21:22:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9DNA1h82ltpHGeG2oCt1UXBIitixRQpK5Jin0EbeELegB/eoeYOANRUhkAV3J2wPpS0kHVceyrBgnA4h81Ah3F+28j6mz/IumENWjy0BbtgaLofsdMDPsDkfFo/+oZ6kE8Y7fsgvhagT0cUT83MlCjS9RKUwwIXOArovrTAs6vLhYsWSza2K4Rq31lyxvK2Nh3oHrVQbRfVBc6ZtJX7ecRqS9qzNxqtvySMdTI6+T8aQq9aS/lEGwrgbmpj9ItfXSzt7SBLLrO/UKMzbqUtZKhKc57cki+GF80n/jizOU7+kO7POnwFY4v55yCV/6yrEZilmTPVw4nOPhdw+BEu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wh8wagtu8NsJwCxeRkqQcDsX2JK6BFr5qZN1TBVdOpY=;
 b=b/Xpe76yHRPuWys7iYOrayjFSbimITtXY/I1Ums5NtxYXLoUS1JtATs/R0+G7jCvayKhjbECXHpmkW+wizYqQPKbrAoTiyxFfb+2izU3nqXdJqq1U4FVNf2U9IfUiyWNsYBIQU18SGpMjieNqizLsRqnc6Ak3ZDU6CQ8vxP7iMjUXFiFsYq5JaGYKnKx22/LkY0QBqS8YURWn705DGdx91qtw4UP/eWr+cZ2JUG8VQg/NmYolGnEjnCUFZ/0fS26qFuk00dKfqvy9m0FmUVB5/fHbtV4qPFe8E79KYS8nV8sa1UKx74jtlShIOp43ss6JHCn3kRLhere/lRZ5abXgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh8wagtu8NsJwCxeRkqQcDsX2JK6BFr5qZN1TBVdOpY=;
 b=ISqhFKcxqou7Itz7sTiAeo7bduEq3EvWaHvECL21OzWLEBXyfWwt/nfyD//j48+JDrewkm6P7WxeMLmGWKNAyFc+cQK/Od2Lk3O97WeqNfpJ4GlNWMTVhIL4NqWXvH/PwulUQAAa7I1StTfRAlSsh2KL2J1WauhthmuAR84tYH0=
Received: from DS7P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::25) by
 PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 21:22:03 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::18) by DS7P222CA0022.outlook.office365.com
 (2603:10b6:8:2e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20 via Frontend
 Transport; Wed, 26 Apr 2023 21:22:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Wed, 26 Apr 2023 21:22:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 16:22:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/12] drm/amdgpu/gfx11: use generic [en/dis]able_kgq() helpers
Date: Wed, 26 Apr 2023 17:21:36 -0400
Message-ID: <20230426212143.7696-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426212143.7696-1-alexander.deucher@amd.com>
References: <20230426212143.7696-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dac698f-48cf-4792-0acc-08db469c4725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQ7Psq8IhPSaj9LcGRX0C08/BuYULJmUNXFt0/HROAKv5BKaUL8i/eT/UgSCBB2W4QNX2wu9o48wpaeH/KXSw3yK89lDxcYBsDgzNa1ccW68i5v5jGlOgMiwSu5+bl8U6NSh3bG+JRVMzHwD+NMFqgM5Hlujy3Zl55CzA7trVVhVfSVc3Z8BQgCbh7qrA2PpsJYbuxxS5zEjBu2kmgZZ6KWbPRBDn6on8daURWasrLzYHXqQcX680cOrtlLqcYZl3UvI3Lp6YibSeFM5zXMoi5HtZPjzDe07miFFYBxLooDbwg0c2qj2sDKPP2UYA2gkVhGOMg00I4EASpiBIgK0h7dZE8Tu1Yqh8e6XQnDeAP8ER2wPzbhSK1jWMl27SU5XXWcZ44TUbNu3jOqJQEMVDSMl183Hak3u66DAVmV+5DbCfgg6gaooboQ+5REQDdlOnPuYGt5Fi3UtL57qaU+ByiPsRpRs/lNXBe8hka9Ck22F+JSWl4cOC7ymrF4eCI+PgTB/hkRzjzdTKAtuP4X46KnoZC3tQXWophrfm7vw3AzVv2zvA4w1YYyIhhyD2D1Yd5vaK2sTZygUNGBJb+FJ1vgFSweroo6UofMPnw6lWcdm6fIsf6txNoNrjta15KuqhYDFrGtsTQIomi2MYiQUraa2l2+qIwONuG8R1kSEb2ds9ZOBysA4Kz5TsEk1cQwQV2P62ib12w6OMM2sc2Kw6ad/QiepyhAtAxmXbYE7PHvRbTVqOU7RwTtMV5PSodeU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(186003)(426003)(336012)(70586007)(81166007)(356005)(41300700001)(83380400001)(6666004)(7696005)(47076005)(2616005)(16526019)(70206006)(1076003)(26005)(36860700001)(54906003)(478600001)(40480700001)(82310400005)(4326008)(6916009)(316002)(82740400003)(5660300002)(40460700003)(36756003)(2906002)(86362001)(8676002)(8936002)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 21:22:02.4728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dac698f-48cf-4792-0acc-08db469c4725
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

And remove the duplicate local variants.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 49 ++------------------------
 1 file changed, 2 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 646003b2faf8..d36d365cb582 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3710,28 +3710,6 @@ static int gfx_v11_0_gfx_init_queue(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v11_0_kiq_enable_kgq(struct amdgpu_device *adev)
-{
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
-	int r, i;
-
-	if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
-		return -EINVAL;
-
-	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
-					adev->gfx.num_gfx_rings);
-	if (r) {
-		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
-		return r;
-	}
-
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
-		kiq->pmf->kiq_map_queues(kiq_ring, &adev->gfx.gfx_ring[i]);
-
-	return amdgpu_ring_test_helper(kiq_ring);
-}
-
 static int gfx_v11_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 {
 	int r, i;
@@ -3755,7 +3733,7 @@ static int gfx_v11_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 			goto done;
 	}
 
-	r = gfx_v11_0_kiq_enable_kgq(adev);
+	r = amdgpu_gfx_enable_kgq(adev, 0);
 	if (r)
 		goto done;
 
@@ -4392,29 +4370,6 @@ static int gfx_v11_0_hw_init(void *handle)
 	return r;
 }
 
-static int gfx_v11_0_kiq_disable_kgq(struct amdgpu_device *adev)
-{
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	int i, r = 0;
-
-	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
-		return -EINVAL;
-
-	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
-					adev->gfx.num_gfx_rings))
-		return -ENOMEM;
-
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
-		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.gfx_ring[i],
-					   PREEMPT_QUEUES, 0, 0);
-
-	if (adev->gfx.kiq[0].ring.sched.ready)
-		r = amdgpu_ring_test_helper(kiq_ring);
-
-	return r;
-}
-
 static int gfx_v11_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -4426,7 +4381,7 @@ static int gfx_v11_0_hw_fini(void *handle)
 
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
-			r = gfx_v11_0_kiq_disable_kgq(adev);
+			r = amdgpu_gfx_disable_kgq(adev, 0);
 			if (r)
 				DRM_ERROR("KGQ disable failed\n");
 		}
-- 
2.40.0

