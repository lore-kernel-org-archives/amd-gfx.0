Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365B3EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 04:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93DA710E106;
	Wed, 19 Jul 2023 04:52:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F18F10E106
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 04:52:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyJTZhr21pOx53KiO5Ekynjw5LyueOmpNrm6e+Woz0k6tXOBx3ZMErJkDMde+TdacVFv0E7+C9Vl5/n6JvItimEdj9TzAqUjrP7jooxTg3H9tjHQyo75xwqB8+E43V/bVmnO1xujYs+5ZNcs33psuGXPdpftX+OWegOSRBi29HHdFFeTOzEV4KaGetr7y+VpgttPRWhz/MTzDxvqseTdG+xOA9RuzurJVWklEjWvi7qJ/u25USmHqttgMcCt0RPt23bKFTfAnoLa2k3yLP17zZ9sM5C25S2qS37pAFVzQt+KSpafpuTFeArKvwOnp5PS7pNLTLRzSDmUSFuNMV6ouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHhIMdF3IKQiqN37JCooEPIWRVlLHD/kXCetKYSGC6M=;
 b=VNFozGaFFIHZlKiwHVpjWpElLQdOreighhx3jdh2gao3C4RSsHEC0R91CtDtyRrQk6kkckSnxs/GG7SUwb18847Qdvz0mwMBIb6Pyf3Kx4m1V4611+K5LogR67gbpMbSKuXQW9U7vZz3BfXA38aXRu4LcpaV450d+/pnMP9fjHCEHO8hCTceUWm3w3Qawsx5i6b5zP3A97/263KSpO9tH6qXjuQaGFecBSwLtWFeB0sctKVNx1Iz3cyjSqG6QouKpyJE7FDb7yQZHy76XhOqf1Nm+mCcTiP9i2OcUn/o+h+5Z6qWj8vvdDyy+br154IvtPzJBcJz1AeXsVe/VbvPIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHhIMdF3IKQiqN37JCooEPIWRVlLHD/kXCetKYSGC6M=;
 b=s7aXOZtfOJCSRd17OONZQfCsCrqujsJrdgEFNzeDVL3XJ9WTIse6uD33f0nE9m1IxGJ9IgaEodaYmjtGDYIhl2twdCQlr2XL+ov5zr/IFGAFzBTHCMm1nWvfCgLH1HqFjvyQ0wzqZnJgKjcIRhqnpN+WMzVoo9jdT4dfATGO+Nc=
Received: from MW4PR03CA0207.namprd03.prod.outlook.com (2603:10b6:303:b8::32)
 by BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 04:52:28 +0000
Received: from CO1NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::81) by MW4PR03CA0207.outlook.office365.com
 (2603:10b6:303:b8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Wed, 19 Jul 2023 04:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT105.mail.protection.outlook.com (10.13.175.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 04:52:27 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Jul 2023 23:52:21 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: update sched.ready within kernel drm scheduler
Date: Wed, 19 Jul 2023 12:52:04 +0800
Message-ID: <20230719045204.789223-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT105:EE_|BL0PR12MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: 790ba423-e889-4cf2-4fc7-08db8813f3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nX6ndnHf90pW96BmwDxIdcO6qo0CSWd0KFfyCzVjIRHQmsBp+BOjb084JT3ywp+2QBewnlUDnABh/0InT8rT7FssmfPuObj48pogRP0sYRSXHJezUdugm3AqI40fL01sYKUZIfTXeyxzV7ywo7/iNCneTGiYZVG6kqABMs/gTmFf+Oj0jXdndgSCOsw+4aV/GxRfHXnbBBvVKcDVSg4uVAT/SHtPpl4RWVs1Zh2eyiwuZUoIIOaDPHXAFC+1VgQDufG8qP4y9wtK3vZST8aXDi0Qdns+9loB/X555Agi5YDnM+jcEBpbqx+SMKs7vzMGxWXb40tuZjQv8BczfsQgPv0dWMPptYaH3P32sbs3LSD6eyDPpvZ+lvFvj7EW9ePUQunw1U7i4FNYXsAZp/+RGpSXNHgWlGABexFN2ZyN8Nq1R5RqxfG6+K08BpEDQJTd+0aFJLDGq2CgKnd9FWmiexPIS+Yy0De1oWf4rPitoYnkhYvdvfUQZiuUVWIf7YWZUd14PG/2NIzmrUlgbXKJ8YfO5Yhx67UsXcI7JQJOisAXyta7K7taaKzbtLJ4hvqBa8k9RIDQvBTjPlVrq71eJKSPy3oOSmzhmXhVRi7r8GydHtx6k1KgIerXIO1TsOZX/IXYb7/kN7T8BWLoehU078amp0g1MKE/LxqDXEOCVYiXuZlxLnnN+nA2T9/WcxeUr1Q1PsVOYKcbg1xgzr6t/4XEKCVgCGRcI1MEy+H9GPCCfPzBrH2tnkSI3FlYJv9izvpdERk/ss5WVYVUIyFNlOCVXrePXdqmjJ7jqtL3Gjk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(2906002)(41300700001)(316002)(40460700003)(5660300002)(86362001)(8676002)(8936002)(40480700001)(36756003)(44832011)(1076003)(26005)(478600001)(82740400003)(6666004)(7696005)(47076005)(83380400001)(36860700001)(186003)(16526019)(426003)(336012)(2616005)(356005)(81166007)(4326008)(6636002)(110136005)(70206006)(70586007)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 04:52:27.8512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 790ba423-e889-4cf2-4fc7-08db8813f3d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5011
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_test_ring_helper will set sched.ready unconditionally
based on ring test result, this will lead value mismatch between
ring->sched.ready and no_scheduler for those rings without a kernel
scheluer, after they perform ring test. This will be confused as
kernel ring no_scheduler is true, but ring->sched.ready is true as well.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 80d6e132e409..afa76d069d94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -630,7 +630,9 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring)
 		DRM_DEV_DEBUG(adev->dev, "ring test on %s succeeded\n",
 			      ring->name);
 
-	ring->sched.ready = !r;
+	/* Only set sched.ready on top of kernel scheduler. */
+	if (!ring->no_scheduler)
+		ring->sched.ready = !r;
 	return r;
 }
 
-- 
2.25.1

