Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE45BC41535
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Dec 2023 04:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 103B710E00A;
	Fri, 22 Dec 2023 04:15:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9700C10E00A
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Dec 2023 04:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPtX6c4HIW6QLgy2kj0AS1VWL1to9s5qz9Tx+JfIESHz4ADZRtIZsdXvJoS+sUQCBy5p6tzTMiazTqzfKILqayszBnZA+Bwo7zHT1KMEWQSS22GZSplA1fOb6r+dI4mHzPaY6IFwQYswa0q4gC3hO+mK/pl3VWOo3LduvadK1cvbOq/SfilEriOVen2FcWPL0VqXLAuTZUsOcPOKgGdtgKe/8cPxNeRwg2vi2+mGEO/d2JzmPix5y87MwWvvwYSOxQhmFpARg4uBx0gZVr+C1mAeRB3gHsycGK5sM681aWQQ5Zo3b4PUda1/n7fRASKkUZLZ5jmttMsVXE4UmtjaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDwusEvH1cvyxCwjGhpvns/5kUjvgW0LtIZV+3Sk/TU=;
 b=TfwHpAHx0DDMlr/pPhbOZuqsRjyAJZ0G3ysBLU1JWGCJnsAOMilhj6Mdk2hBa1U/q3odeHRVOHt4MonphhbAzoLa4zITIbfV92hlrofyq0CPD0WlG6s6BU4dAlAVuDy4ea0FeprqAyr0Cj6F4JarTiNChcgH0b2LYdqt+nlUg5b0VJBvsn61LdLNyPHdm3wom2fXT8kIDgEqiEr4MRODRSfQlnXynzNvvfPofRJ+sIelQcCVelUs8+E3/U+/Cx20lSQZtxynfEz0lmyvKSqtSYJ9z44cGb7J4ShLwoAPssdQR6WNBR1ZPQUTHdzaFeExO4s5F2aekLDlO2qArqEgUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDwusEvH1cvyxCwjGhpvns/5kUjvgW0LtIZV+3Sk/TU=;
 b=ZgFPVOccR/n1s791tU6yAJgK5iYhJJ51CzQgz3+OFA7cPH2A7ksQSWwCDqR8BuIDTrCQGkxe9gtlirmfjKnV4tODJ703f5BdgVdpm6fHuxvXpVaa5UKfJEXr2caM0ASFpphdiQVFjygqjgegTSaJ3pJVfUBNaCMRXxAmuZ4+fM8=
Received: from DS7PR03CA0290.namprd03.prod.outlook.com (2603:10b6:5:3ad::25)
 by PH7PR12MB9256.namprd12.prod.outlook.com (2603:10b6:510:2fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Fri, 22 Dec
 2023 04:15:15 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::fa) by DS7PR03CA0290.outlook.office365.com
 (2603:10b6:5:3ad::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Fri, 22 Dec 2023 04:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 22 Dec 2023 04:15:15 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 21 Dec 2023 22:15:12 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Confirm list is non-empty before utilizing
 list_first_entry in kfd_topology.c
Date: Fri, 22 Dec 2023 09:44:53 +0530
Message-ID: <20231222041453.1568945-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|PH7PR12MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 053bac32-80e1-483c-ffa5-08dc02a499ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: apMPFucSIamXYTWisYPgwDqqkOAn9NiFhCBxqSZxiyGlpSea1GSMBNioKkaT5EDzmvyoiMvyTEGkwMFk4DOhZhPHtWINdOzo5gSjWBf+At8juXnKhL1Wf0vN+cr+gFyq9fB7FLsDjuzE4x45HNAnkVbJdkD5yBD+0xJE2cqA2DjQ9eoeU3JuLpOvBCoORdDO96Jf0Hq1AZlED/k6zbaHULDIDRebgdEJJqKp3rTSqG6qZ5P91gY2P2uj/5WZg+M/GNbatuGwGslFlpSh0HHeOUgf5dZTp5LZB6cd09wI140BFPGQl9LbFhOMQF6KmiUDlHh9A2N1fFoTDh8PteaIzJVS53ToHd6ZH0/vCpDBjYcMsZ0f80rszYja8bfzCpRVrjrQuAj+y5517kuoT0KKxkESi2UfbOvXQoM5TtDnE/bNEgFGtPt3Z918YRDSZLxoWjO1pYnO581uRjO99T5JDKBLo16VcvPoOMI7TrcMRlwE5EacbKcQyoOFz3omhj5C8WvxzuJBWHgfxvH5qx+0vGVGNIjG96kFHfTJYqU4lMODXNOnyy0YD5g6NELuZVZiBhe/rDOAYaIssSjZfaXcJEKikfpffAT89EpxVpNGKmnxhV4kVriC24nma2F4k2whp9PDMYd/mbOfGuHe/DFggJeGykDuDckVRGV1Q8OjHpEXbWBqzgXvh8nLtCmztHM3hzXO930mgfuo8qjJVqqRfQ2PHOl/o4un8zRgDA58CRSDWVfJm7vrScEEcL3inH4yO4nAcPRGzPF57NVDhIGNsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(6636002)(54906003)(316002)(70206006)(70586007)(426003)(336012)(110136005)(83380400001)(44832011)(40480700001)(5660300002)(8936002)(47076005)(8676002)(4326008)(36860700001)(6666004)(7696005)(26005)(16526019)(2616005)(478600001)(1076003)(40460700003)(41300700001)(2906002)(36756003)(86362001)(356005)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 04:15:15.5064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 053bac32-80e1-483c-ffa5-08dc02a499ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9256
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

Before using list_first_entry, make sure to check that list is not
empty.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1347 kfd_create_indirect_link_prop() warn: can 'gpu_link' even be NULL?
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1428 kfd_add_peer_prop() warn: can 'iolink1' even be NULL?
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1433 kfd_add_peer_prop() warn: can 'iolink2' even be NULL?

'Fixes: 0f28cca87e9a ("drm/amdkfd: Extend KFD device topology to surface
peer-to-peer links")'
Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index dc7c8312e8c7..a4cc88f08df2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1342,10 +1342,9 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
 		num_cpu++;
 	}
 
-	gpu_link = list_first_entry(&kdev->io_link_props,
-					struct kfd_iolink_properties, list);
-	if (!gpu_link)
-		return -ENOMEM;
+	if (!list_empty(&kdev->io_link_props))
+		gpu_link = list_first_entry(&kdev->io_link_props,
+					    struct kfd_iolink_properties, list);
 
 	for (i = 0; i < num_cpu; i++) {
 		/* CPU <--> GPU */
@@ -1423,15 +1422,13 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
 				peer->gpu->adev))
 		return ret;
 
-	iolink1 = list_first_entry(&kdev->io_link_props,
-							struct kfd_iolink_properties, list);
-	if (!iolink1)
-		return -ENOMEM;
+	if (!list_empty(&kdev->io_link_props))
+		iolink1 = list_first_entry(&kdev->io_link_props,
+					   struct kfd_iolink_properties, list);
 
-	iolink2 = list_first_entry(&peer->io_link_props,
-							struct kfd_iolink_properties, list);
-	if (!iolink2)
-		return -ENOMEM;
+	if (!list_empty(&peer->io_link_props))
+		iolink2 = list_first_entry(&peer->io_link_props,
+					   struct kfd_iolink_properties, list);
 
 	props = kfd_alloc_struct(props);
 	if (!props)
-- 
2.34.1

