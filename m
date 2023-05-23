Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E598EC7EE26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 18:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 661B110E49A;
	Tue, 23 May 2023 18:31:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 531DE10E49A
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 18:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRrrzshSpgILeC42PpqFmOwJGwPnsWeTpJFytLJMd8JHP7kR0g50NmT9n47szVtgUwLE40zOVC2RFwkTtwNkuWmxZ+qvpqHMDDoVjU1mOpvYYn2ki8WAyI1sWTR731Y1DGqjcKp97Nj6k7H9UQaCxxCm2ooF7UXxcEIrnetCiQJ0bQl/hPmngqEzf78RzOdwC8sGypve3uhnjFN712FrX8WqzMwcHU79Vc58Q5k6j9krBLAzq9bEmHs5BU3LxPbHHnNiFj63oD4psscd3uRFAnRafzpj5gz2k87e9alqxSEgPTMDRzYmKGASLJo5fmz9k2PT40uDTdJb4iS8JPGUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrMGUdQeUAFH7NwWG8Yogx06ZRKoYWGy9ewJe/zSqQg=;
 b=a2iSgK9dObM4TZAsbQj+4muWyvE0+631lSBZJQDzJSZmrNUBk2AK/VjOkMAFp7FXUppTHUu9jsIz4HZ95GhvaTc3aA6YLtXT0g/fh0Isn8NpNQ28YuCIeIl5bA5//f4+e+waGzv7D0HiR1RFGcconEbv6D7IR2LITq6NzBu9RQgBm8w7Y07rKyGkG5RC/8E71cX2ttmQxy3EErsuC/rDnJ7iS0xi4LbCjucz6xPC+h2N1akaXk1XtEDFNuylWPr7fxy0Fyy4rtNiGtre2w21S6+RvDsivLrNvYh7t0elUsAiUb+hw4u4xrk/3C1N2o/3HN4qkTlIEJuOi9qyIFFs7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrMGUdQeUAFH7NwWG8Yogx06ZRKoYWGy9ewJe/zSqQg=;
 b=st9R6CNKO/Tt0y0ydavW5PnKxyPVbQL77MxTjqeyeVKFGidy1zUFVEZqo1+u3Y7ocssK6IuRkkVNEvGB7v0HvCkDXkXVAEPRYL48YgSzX+ei33RcTTYMvEnzAZmaCiHoJy3LtxyMoys8WmO1uRxnnSFnwL5VMCDt7LMyswU9qkE=
Received: from BN9P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::16)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 18:31:34 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::48) by BN9P220CA0011.outlook.office365.com
 (2603:10b6:408:13e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 18:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 18:31:33 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 13:31:31 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Remove unused variable in amdgpu_gfx.c
Date: Wed, 24 May 2023 00:01:18 +0530
Message-ID: <20230523183118.3080904-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: f287c17f-0913-4766-dc75-08db5bbbef95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VDg9HTkcLgmRMSRKBhy0SADWmZet0NV5sgjQBAeqmZLapdsz4aqzRGETXHswGj3KzfP+KpmdivORAiNsa0e3zbj3nDbGlVp1RWVIFhaLtJmne/wwz07cX8B6nD4giTRa0itaOtUE1Ewq+uAl0oS0mKuIcIaqirdcNP5i1HoapmqRLJpr61up/PlrqbJRLBkJToZygPXHpxy5TMfBq5I/geco/KuvTdTl2V1pyij5348kI+jmrQkAo1Vsbh7HgxV/2R88MfnkgnAb4HTN7LbuBBOfmKIQLXy+ZNkkz+kuDGN4wa6dIMHrHRhZuehzY6BOG6T1HWavNXFJD7gg1XhUdMkiurz1zawJpLixNWTZ5dXOhDejEexsaa178cuEWdaoVYIIhOx47VVzA9P7pm7y5I5TNxpMNGtSeQ+zVQjhc5jsPXO0B0qfFJspZvbdLZCHtQMraA/CDUmypWPCiKiLLcOc8gqiBUa4wgqOGP8wVWVsER/dbMFzrzGF1Br/DJ3ncf4noMeO1QYM82njxOEMJLVMqZ6GJY71yAiJzXIKablHRyVhX95VwKmtp+mym4hPij6CPDCdt5PjaxWr2GrNjpc5a83M7BbMb+HenqSAg3hElzMGV+Qs/Tjr5zWZaHHFY8mRVEL3yS2S5ZwmcV9zR/8+bSSlmXzBQa0MqSQyXCfP2VyxeTjnJfT5apTbJ3ogSlSYMmTWBSCKyS68D7nI4tr+B+UsI/keQgkcBoDIyzF6MMHHDHcZAAx/wnxgc8dlHStbM5mJXJM+qY67qjHO/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(40460700003)(86362001)(7696005)(82310400005)(426003)(336012)(316002)(2616005)(6666004)(8676002)(8936002)(186003)(36756003)(44832011)(26005)(1076003)(16526019)(5660300002)(2906002)(40480700001)(70586007)(478600001)(36860700001)(82740400003)(81166007)(356005)(110136005)(54906003)(70206006)(47076005)(66574015)(83380400001)(6636002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 18:31:33.9176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f287c17f-0913-4766-dc75-08db5bbbef95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function ‘amdgpu_gfx_disable_kcq’:
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:497:6: warning: variable ‘j’ set but not used [-Wunused-but-set-variable]
  497 |  int j;
      |      ^
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function ‘amdgpu_gfx_disable_kgq’:
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:528:6: warning: variable ‘j’ set but not used [-Wunused-but-set-variable]
  528 |  int j;
      |      ^
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function ‘amdgpu_gfx_enable_kgq’:
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:630:12: warning: variable ‘j’ set but not used [-Wunused-but-set-variable]
  630 |  int r, i, j;
      |

This variable is not used so remove them.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2b4bf6c11ae4..c7c16d6c476a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -494,7 +494,6 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	int i, r = 0;
-	int j;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
@@ -506,12 +505,10 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		j = i + xcc_id * adev->gfx.num_compute_rings;
+	for (i = 0; i < adev->gfx.num_compute_rings; i++)
 		kiq->pmf->kiq_unmap_queues(kiq_ring,
 					   &adev->gfx.compute_ring[i],
 					   RESET_QUEUES, 0, 0);
-	}
 
 	if (kiq_ring->sched.ready && !adev->job_hang)
 		r = amdgpu_ring_test_helper(kiq_ring);
@@ -525,7 +522,6 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev, int xcc_id)
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	int i, r = 0;
-	int j;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
@@ -538,12 +534,10 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev, int xcc_id)
 			return -ENOMEM;
 		}
 
-		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-			j = i + xcc_id * adev->gfx.num_gfx_rings;
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 			kiq->pmf->kiq_unmap_queues(kiq_ring,
 						   &adev->gfx.gfx_ring[i],
 						   PREEMPT_QUEUES, 0, 0);
-		}
 	}
 
 	if (adev->gfx.kiq[0].ring.sched.ready && !adev->job_hang)
@@ -627,7 +621,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	int r, i, j;
+	int r, i;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
 		return -EINVAL;
@@ -645,11 +639,9 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 			return r;
 		}
 
-		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-			j = i + xcc_id * adev->gfx.num_gfx_rings;
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 			kiq->pmf->kiq_map_queues(kiq_ring,
 						 &adev->gfx.gfx_ring[i]);
-		}
 	}
 
 	r = amdgpu_ring_test_helper(kiq_ring);
-- 
2.25.1

