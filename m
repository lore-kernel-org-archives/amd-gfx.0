Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F3AC7EE21
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 15:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1A1E10EB5E;
	Thu, 27 Apr 2023 15:27:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A893A10E353
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 15:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7beZJlIytUFwth9VOGwV4q//pDqhyRkSTiuBQLqD7PfnZbwqTg+aJEats0AfduOx7xiCy9yD/KaSoscbYoBPr8naediyhz/vBpwqPA4qMl4I4/FBRtyD7PNqreHE5g+4Xmzsu9p3+I/HEjGIRXJmahEXxHEMPCBLZO9l3m1NqUZUEsTdQ3oxtGtgY+1NPi6pQEPo5MuIAS/fMJ9q9DhpxyDrOciYSEaKJ/zPk90t4i0Hv+SbasncwkDXS6qubpCbt+XeigJDSOI7azF8TZetc5sd/zalAtedTR8B+QfSux+3OtPagbTCIDq7r1+RFBfC2DO6QlcLt0/r4I9iFDz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wh8wagtu8NsJwCxeRkqQcDsX2JK6BFr5qZN1TBVdOpY=;
 b=KhL0wYRis3yg5QZN+wNEnwZ2qhJEsnLC4/gFSw7zmeZkLYJYnxJLUP9GtuMjT8GGH2DcTvQGmnClowyS7epfNtLvyMiVaHQDVDS9p6QwA3Aj7YCSY0AXiGNqJIdGd9duGK6qlSNlRl6VALKpBMC3zlXsCJQpE4vfBhcJHCFqZfmjcallsp6mvVdKEBOjRKLbWWiajK/mBPSwi2S8l6AY/Rumd7/NhfuWO0ow9UVYUVLOQjZpAZB40zOsbOAtXPElJe1ztsTnVmqTWVn9TWp9vGb+alKM6qG9lb0PNsU9p9MyW3yStbiRN79MD+Bzz3kZ08AqUvAiiU/YGy39bw98UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh8wagtu8NsJwCxeRkqQcDsX2JK6BFr5qZN1TBVdOpY=;
 b=g4OrKB4wgjcVF1H2rj7GhJEo59L+AvZTIYWXWJ1Zr07gHmFX/tAXzGcqPY4b7H9JOqR1fx/7EhQ5iJG8A6HMVNnUTj/BMlFeHaciwPT3j2Y7+WfPn08d1ave3O7sz+uZlXn5wFue8ZsTVRxkt7qQVNMfDJ/Dme2CgwQxSKdWGQA=
Received: from BN9PR03CA0474.namprd03.prod.outlook.com (2603:10b6:408:139::29)
 by BY5PR12MB5510.namprd12.prod.outlook.com (2603:10b6:a03:1d2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 15:27:39 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:139:cafe::57) by BN9PR03CA0474.outlook.office365.com
 (2603:10b6:408:139::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 15:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.15 via Frontend Transport; Thu, 27 Apr 2023 15:27:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 10:27:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/12] drm/amdgpu/gfx11: use generic [en/dis]able_kgq() helpers
Date: Thu, 27 Apr 2023 11:27:02 -0400
Message-ID: <20230427152709.7612-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427152709.7612-1-alexander.deucher@amd.com>
References: <20230427152709.7612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|BY5PR12MB5510:EE_
X-MS-Office365-Filtering-Correlation-Id: 9692e998-703a-48af-0acd-08db4733ec4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdVnjn1l/jfT6t9IKRBflYHoClLStCOhmhZ54ltTrxpMyLJn4fydpEv8e467j+p1+eAZaufHlVZPjVi8BipVCp6IS/THEOLCbo0N5Eg8RhWFZF02KDOm/G39SO+M+NOxWUFLRZzqtskLl6LFJZ3+x3rj4iTwzii9UbK5dTOXz2U+/BEmR1LndkR+f6Hp4QjJNFwNops0UrrEYPD8yJiQ75fagKZgGU97qjrihzN5WjMbBmi6ePL5qzif1Af6H1WqpLMfINdHsFekDlJZ31Dls9HEcxpMtpyRaOgpjZ8IzstZ0+Kq8rhcSROYQpaDFHIqMBc+cS38SGXQg1YN3BjGw+AnIcFmA5CwSojSq1PNzwSIEXAJyEajux21RA7OKtfj4mKaICmK0cLsuEjP5dsKU94HMwJNqUj/6IsaoiuFDT14RmJvGoiSmekUWedjqkRn1/+bFLAqqdO/vP4SC5I4rkIYlSW2iB/VlrNvgGAcCoNpOQ+Bb74HhG0/ZihrGSOrbD9wArZJE6wBcDFKmyFeDJsh1cuYBw72yqcWGAHxqLYtG6QhjnuUD+3kSHnDFt+m071PIURFjKM/kDOsGh7Q7hYFmewCpMgzwP/opUsObaI7k8pAfhDavIphz4bSs7A06acmovJX3xV03IuEPd3s+ISttg4qMqprulfmmFmeuW6IPyVnoFuDikKZqhkElGq/nJVRSHWZJhpes5u4C3a7KQmF9QK0T67d2KNZKHkSm3Zi0LoDMOHYLnsdmEYFgqFr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(36756003)(86362001)(2906002)(40460700003)(40480700001)(6666004)(7696005)(36860700001)(16526019)(47076005)(2616005)(83380400001)(336012)(426003)(186003)(1076003)(26005)(4326008)(6916009)(70586007)(70206006)(478600001)(316002)(81166007)(5660300002)(41300700001)(82740400003)(8676002)(54906003)(356005)(8936002)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:27:33.5767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9692e998-703a-48af-0acd-08db4733ec4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5510
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

