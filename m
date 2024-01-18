Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9701DC4725D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 03:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD68610E110;
	Thu, 18 Jan 2024 03:17:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB5D910E110
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 03:17:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bc9hxEhoMa9bA3UHoaOcodexgxYk62a20yLW2IRUhI7zlXWJRel/TnO+LGjgjce6h2++Wt9z6dJ0p4pjTftHdsQcETtsipj+MNpnyKPWpuxxYLzwHs4WNuGxobrhBt5g5mRhDpHp+DXt2jzxjQgSlhTtrjhE908yi1HZPrA2CvEPmNEvL8LWuZGJqrLCh+XlMUXSwJ1uG6qGgr0FmO1HAE374UnhGaUdHS7KRF3jWzygAQR4V3YLN/8XdfKFajdkDGOhs21PQXJNQLp6PaFHietgE/7ebYwp4H9Tke1ZR8oWiEOCXNHuUpIfLBFD0OfeJCeLjCheJgcsTNQ6T5aBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UO18fazjC96dqHSxQdRSAz8IVTg4jykVHyIV/RzpXlg=;
 b=hEbl9wYFAS2dcrca8FwhHMnD72frHaDv17W71nea15RcRwMc2uFRfuwegQK7dVmXzBik66yAsHY0dsxWXFdEAnVGpRovyIIMsdSLLPTWVJNS6c7WKSY2fxXgGDmU9dm34hKL4dV1+EEJSiIwuN++K0MKfWoSr7gWqkKqqkWS6CEzWl/o3lLYjWlq1gGdP8RLlL6JJCHv/qnA5NpF6Yr7dtITt2ScARpClCPE2DmkY0WEaHi87Gbfc9prBhfJPO+4VguWuiOC9ncZVT9ygiYosQDtOxePNsNYzBI8ZCvPPbk2aX9RRTS90AAAgphf/KseNYqIeh+5SEA7uycpHuVidw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO18fazjC96dqHSxQdRSAz8IVTg4jykVHyIV/RzpXlg=;
 b=AjH+BWu/oTnmXyDwUBGfPWq62yS4UsNx6nFO75h9kco4K5ee4b5M6VAVwLZQ/7o4y9J5JLaeSxyTVPmm3b0PuhTT87ajFBOLLDkHD4jEzutr68AvHu0pCxo6cco49W3yuhLoylORNVspDdVdW6Olmrbzk652xq/5bSvJxCEo6Vg=
Received: from BL1PR13CA0366.namprd13.prod.outlook.com (2603:10b6:208:2c0::11)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Thu, 18 Jan
 2024 03:17:34 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::f2) by BL1PR13CA0366.outlook.office365.com
 (2603:10b6:208:2c0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.17 via Frontend
 Transport; Thu, 18 Jan 2024 03:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 03:17:33 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 17 Jan 2024 21:17:07 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Cleanup inconsistent indenting in
 'amdgpu_gfx_enable_kcq()'
Date: Thu, 18 Jan 2024 08:46:50 +0530
Message-ID: <20240118031650.391160-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: b4be99a3-600c-411d-2bbe-08dc17d40353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7D41DuXevXWBjN+7p4IJdH/modSvbFlUXayaaLOUA0Dpwj3sKTGlXXJ9G8ma9zlVh/qGXj+N0iWDQT+oa5oGL9sc242h85c5XXwAQuVrodXQwu81gucEORuUluU3R5VkdlLXsVEUCF3zj+7Y/N5sSVHR4QWlSrW3wEpmyuZtWq3YzT1omhe2ujKBL7vVnGbi4xA9gkk3aW4dtTt31MBoLyRUHICqBPH75L10ODrxZxGNY7ewDssI8wLfnNAcQwGV2vtA7KMO7vd6bxc9dgiOF/Qp1temHaecp2+e7H2Nx0hi6SUVgtDv4BCA0kI76Ylp+27EHuq8FTpuJXBwLXKEi+APB7MAJ6fl6D4jBqV8HxT5bSXiW3KPbl5XaodY5PrWP1DiziS63EvI1XnyUOh8VHjXIdqRK5aeeI1WsBp0fbhzT4RyyZvrIx8y22IA5AMe7SwTx+dmS/jF4q9F9i7v4ije7ri3Ms4sWjK3bXFzfcORiJ3FJcKQcPLPzm9WW2rVWfIcgFQR2ebRxQyIIm4JCEJF8kgN6Xh/nZys2Y/+isblOU8HRjMLyHprgXXP1ug/jgT/vjg+3foluJ3UdzONO5TDNc0ddvAlqYUe+S67D+WQb1WGK8lrOZKtbt7hNQYwTNSetXWa7ytTOMhMy/kwWWxEkyBQ8n+GWFjP5eaoS6u3psO+VubgXbIcP6RZ1WafHylqmqqVaQCwtR8uAG/gIVQnqd1B6xi6w3n7uev5Gyo0sA0WbvoXSizcR9uimMUmdWa9k3VMQP32xlju5vfU/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(16526019)(7696005)(47076005)(81166007)(54906003)(6636002)(316002)(356005)(70206006)(40460700003)(36860700001)(70586007)(110136005)(40480700001)(83380400001)(478600001)(1076003)(26005)(336012)(426003)(86362001)(6666004)(2616005)(36756003)(8676002)(2906002)(8936002)(4326008)(41300700001)(44832011)(5660300002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 03:17:33.5587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4be99a3-600c-411d-2bbe-08dc17d40353
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845
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
Cc: Le Ma <Le.Ma@amd.com>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:645 amdgpu_gfx_enable_kcq() warn: inconsistent indenting

Cc: Le Ma <Le.Ma@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b9674c57c436..eb03f2d7b607 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -642,8 +642,8 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 	kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		j = i + xcc_id * adev->gfx.num_compute_rings;
-			kiq->pmf->kiq_map_queues(kiq_ring,
-						 &adev->gfx.compute_ring[j]);
+		kiq->pmf->kiq_map_queues(kiq_ring,
+					 &adev->gfx.compute_ring[j]);
 	}
 
 	r = amdgpu_ring_test_helper(kiq_ring);
-- 
2.34.1

