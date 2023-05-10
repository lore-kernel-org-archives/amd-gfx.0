Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FCCC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 357BE10E541;
	Wed, 10 May 2023 21:24:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9009F10E53F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtIXY0Qrcxk5N9BtlUnOAp+4XXqvm6xy2Wp8Im0m8WEBLmPsboQKJlo9N4P/n22E3CELonOUxFhdhkPRRUDNZ1Gy28EgWJ9hWA3aL5kLrPXT0U1/THygHmx3fw6tl/o+Vz5L/14LBrZUx5qjaWcQFtMrUNBryW5P2uVJmR0ojfxDdNdUZcMHpoemxcXZKniOC9yzJBFAn+Bo+kg0qtjACiIWSZ0Yg9mk7q7AeS9Yly6LPO+H4zoj0dBDpBX18lRX6tV8lcVReVzCAz0Mv0ru8XU3TL0xksIDh/FW1gL8JCmmnIm9Y7F5wV1aZwMvICP/rFQMQjf9/6FWrxwED2pa1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AD5cJZiX2nf6DX0oNxpBTpGCV45Bl04KNQsBRlxW9pg=;
 b=Fb4q0tF3OpVmCGRZXv6tsTCQudjHFH5nlw6iHRT760vt/QRzT/PiZV8juKu6oqi6ei6gyWE7a62iuW/oDr8pt3sizXJ2cMkFTbMHJkLCkGCSkv7ZHE5zgTD/AfUBPDv8st9IKKmRHAss3IesgpzMia7jqjbthgEWV1h22pflucZ6A5gwf0U3e7Wvqv7a8AY5itg0UVKxvpNoo0Dcw9uu0mvqKx81Mt3NKZV68h2Ode+4cTEfh43w/GgtsA/YTKza9StTw9rQALe3Rw0sdzK2TM+FF9h+sTX45D7VU1uRBEXTmm2zuH73KvXgBOsV+hY82xO0pW1kUA+TdEnmMEmc6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AD5cJZiX2nf6DX0oNxpBTpGCV45Bl04KNQsBRlxW9pg=;
 b=N38Sg9ot6hxz7HnwaJj0sZaomI1UZfkdgVED4EVgY9ZBbSy3ZW/sSDPX3EBRYRKy3W3Q/HL2Eruq26OLgGUkkfiMvWwJmGdYpLw3Sdx5UIdRW1ahaQ1pDuivgY+Ny4y2DMgOLrLEL8iwZ8bv0m6qkUHeNWKjpBUhw+72DGUSXAw=
Received: from MW4PR04CA0356.namprd04.prod.outlook.com (2603:10b6:303:8a::31)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 21:24:04 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::ad) by MW4PR04CA0356.outlook.office365.com
 (2603:10b6:303:8a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Wed, 10 May 2023 21:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:24:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:24:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/29] drm/amdkfd: APU mode set max svm range pages
Date: Wed, 10 May 2023 17:23:30 -0400
Message-ID: <20230510212333.2071373-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c33164-e35c-421a-3564-08db519ce13f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdX5Ax60JgqkBKTihbMPxVOePJr/Xj+SccVYaVEEfKHSL5py8CfyJE+5hbjCsPGzAUn3XMlFl0F/yrm9WDKPUKbvtD8SsmetNMViVfSzhURKIsCmQ++J6sAIU7vPzG69LdaEgtCBEReCHtpWPDR82DrSEcWdMQh9mcRTaLjbDEVNlLOOuMdE3xLNQvD6qf9Ac59isRe3Owwqh1VJwJHA7g2puelDnFckx6UA2bml7D3KaG6jWvfM0o9BsgPyO/8rXjHyCdv6hGGUxI+4TGS9REv5+0diGGNcz46vowNnMDaGOabwjue5aIHmaziVOJc1HS871cvWwuDsZLX/PU3scI2aDa1h8OvHJv53XqvvmJSd7ofgKMdnxH6y2jMch1JOQb+Hiqa3EtVt46/NCxuGMlvtxt8gb4/jInOiOmrGLlzEufG9UOQhZFVFzEZiZe/B4+7YtEvZkF4mhg2aFzlj3VwIc4l1r23FjN+PqSKn1QIbs/tlIZlBCo52yfNoh+onAhrnjrYFRkmVp3KLFvqIZmHhPVGI9bGwVHrAP7oRBljq+rwFe8YyWsIB4okwkAVQyKk3hDS867uGo6hzToP1KB0A8Z7KOf+2TN+0VAscxR1dm23DrqMfvlCfsx6YWr336B7ulIneVBV61wKXWqM/mhAJI9X0xqg8Xe3mdPYWZfn4AP3DRvFgg0w+RRECu1tIpbX/gJV+1FobDmutrjs3eM/qZ31hsGUyFYOxvhqNhaK2sf0TtrhWW/K26M1ioNsahK9XDTUav+V5ICWDwSB5Tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(82740400003)(356005)(81166007)(82310400005)(36756003)(86362001)(40460700003)(7696005)(8676002)(8936002)(5660300002)(26005)(1076003)(40480700001)(478600001)(186003)(16526019)(83380400001)(2616005)(336012)(316002)(2906002)(47076005)(426003)(41300700001)(70206006)(6916009)(54906003)(70586007)(36860700001)(6666004)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:24:03.7102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c33164-e35c-421a-3564-08db519ce13f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

svm_migrate_init set the max svm range pages based on the KFD nodes
partition size. APU mode don't init pgmap because there is no migration.

kgd2kfd_device_init calls svm_migrate_init after KFD nodes allocation
and initialization.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c  |  5 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  7 +++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 15 ++++++++++-----
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index d41da964d2f5..882ff86bba08 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -724,9 +724,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	kfd_cwsr_init(kfd);
 
-	svm_migrate_init(kfd->adev);
-
-
 	dev_info(kfd_device, "Total number of KFD nodes to be created: %d\n",
 				kfd->num_nodes);
 
@@ -794,6 +791,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		kfd->nodes[i] = node;
 	}
 
+	svm_migrate_init(kfd->adev);
+
 	if (kfd_resume_iommu(kfd))
 		goto kfd_resume_iommu_error;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 199d32c7c289..2512bf681112 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1000,6 +1000,11 @@ int svm_migrate_init(struct amdgpu_device *adev)
 	if (!KFD_IS_SOC15(kfddev->dev))
 		return -EINVAL;
 
+	svm_range_set_max_pages(adev);
+
+	if (adev->gmc.is_app_apu)
+		return 0;
+
 	pgmap = &kfddev->pgmap;
 	memset(pgmap, 0, sizeof(*pgmap));
 
@@ -1042,8 +1047,6 @@ int svm_migrate_init(struct amdgpu_device *adev)
 
 	amdgpu_amdkfd_reserve_system_mem(SVM_HMM_PAGE_STRUCT_SIZE(size));
 
-	svm_range_set_max_pages(adev);
-
 	pr_info("HMM registered %ldMB device memory\n", size >> 20);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2dbbdad3f392..41dacc015983 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1937,14 +1937,19 @@ void svm_range_set_max_pages(struct amdgpu_device *adev)
 {
 	uint64_t max_pages;
 	uint64_t pages, _pages;
+	uint64_t min_pages = 0;
+	int i;
+
+	for (i = 0; i < adev->kfd.dev->num_nodes; i++) {
+		pages = KFD_XCP_MEMORY_SIZE(adev, adev->kfd.dev->nodes[i]->xcp->id) >> 17;
+		pages = clamp(pages, 1ULL << 9, 1ULL << 18);
+		pages = rounddown_pow_of_two(pages);
+		min_pages = min_not_zero(min_pages, pages);
+	}
 
-	/* 1/32 VRAM size in pages */
-	pages = adev->gmc.real_vram_size >> 17;
-	pages = clamp(pages, 1ULL << 9, 1ULL << 18);
-	pages = rounddown_pow_of_two(pages);
 	do {
 		max_pages = READ_ONCE(max_svm_range_pages);
-		_pages = min_not_zero(max_pages, pages);
+		_pages = min_not_zero(max_pages, min_pages);
 	} while (cmpxchg(&max_svm_range_pages, max_pages, _pages) != max_pages);
 }
 
-- 
2.40.1

