Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251ACC61DA4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 16:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FFD510E928;
	Tue, 14 Feb 2023 16:15:58 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAE7210E926
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 16:15:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLG31xeFN5enaXcJuySMR4fF2UjC5MMMPDa8sducJPA7+yTJcRDA7ojWPJvKNHvmDoNthxj0pXzk3pLtQ2NdaKDuxO7HjSw376c1K+eFTHBi+ASGj1cJTuuTLS2ZIEH/g4OItIkDZXiS5g9Fxe32UtlqjRVN2DdD8pC3m3mcup4HosD//Q/VJgv8kkAYouE0adbjgR7Bqp4OZ3pkWS1+rZroAPmER3kKmXNgy7yR3asxDRPIVESoZMI9qBGLyCXMo8Y0JFtq6R0HrzmYbJkSyDgvmOaNxgCOBpenPPdtlCSri+L6eDv4UlzBlnrOQ5aKOmWbfKH+WMeFiDMJyolH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOOJxLVZgd4vdWfAKhzx9KqF+ajPvAYRqJNKyGD4WNU=;
 b=AAzWmRDjTdtEh4eMGzkeyg7vqEPjJcYitOapu4KievHV/52qSIk7c03q9wnKgzuUbtPArfLylblqaVf9K75PtHEwXap8lzT2n5NTewLKz1rbYBn/eBEe0+nhann9bOUEljWB6SmK2Gr3d5GFtHzE6U6yUWnZMQmXnJwp73yhiSOH73e5KuvZk7TF0Y1nSS0RgUMtyXEyEej/euxz8PL+Z3l9Y8pLw7hxNS+8YXDVqBcKRM1x61/+aYwNPAS/5LM2UHIr/qp+OXw2GvEuLv3zWPcARevWGgVcgTJ0rozamIRJuUlytmCMPLZnH6SULTGHuMQaKK3+PFH2yBUxkuJMeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOOJxLVZgd4vdWfAKhzx9KqF+ajPvAYRqJNKyGD4WNU=;
 b=BAYDipfubDWp63IiHDXp0oJpYPFNo/84I+7rDCpPZi+2sO66bN8wqHWSiBBa1MVVpDoOvqNgd2u46eeRu6bAWo8Q3ieSU4wdksFE12U7VYZyuWyV6cM5meMIhIjDxmkFC10QfX9cbUVkleRYfqoS/BY09g1ngq6s4SXVIA4zuSA=
Received: from MW2PR16CA0043.namprd16.prod.outlook.com (2603:10b6:907:1::20)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Tue, 14 Feb
 2023 16:15:53 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::9a) by MW2PR16CA0043.outlook.office365.com
 (2603:10b6:907:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Tue, 14 Feb 2023 16:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.24 via Frontend Transport; Tue, 14 Feb 2023 16:15:53 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Feb
 2023 10:15:50 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 5/8] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
Date: Tue, 14 Feb 2023 17:15:07 +0100
Message-ID: <20230214161510.2153-6-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230214161510.2153-1-shashank.sharma@amd.com>
References: <20230214161510.2153-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT059:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4e7965-dcf9-482f-9e47-08db0ea6bf2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLHOfeeMQ0Pt8lfhjEJvpru6ZBQTpt/hColduXDxcmihO2tzLD87Ggv5dusX7YsFTiUJhmpxN1DJzQVrPtaPerJ79TltMaVrw/v1MQPGJMlfsPSsll+NR39y0j3ldeqBhrENd3I0p6nUM8n5Nio9YB0tVzg83OHm8TUXI2CVdCocCblj3cD344nrh2M9Ph79+67Wu8Rl+grnrvn7h6WsdTxp1VVQGBIdJEZ106wf/wYLnkEQz1NJ1UBEbDURt3Itkreje3RoEyJTGIzmCNOHDJXX6cQ7gmA11qptkWBnx1KMGagHcUcOpLQLhHLzuGwNbDknpjAZrVqoerRyApU6L2C02Ezq974xDPQYXpEbV8MQ/yw3fljyBekf5kp72zgfSXFJq1+GqrfeRw+eatrwGqww5StesskxBud65qpwmqUKsJPmxnVI7O+Uwqud5Q96zXkcH1Ogtwc6XV7sOCMl+8OfQ1Ladrk9W+IyUPUKGvlvVUhQzZfzIgAQ95ho64WIhmucelyPhqGd2AdOXA7USNkpk/X4onsE74cvl5drWJMGpBJIV90Yf/l6E2KWfC059zPYcndQMJuoHvwuGACWhspNBY+2plkgicEy74HjiBds60dJIWbe8yI8O46yUxTpMPyJ1TLzlvDeCOrFWRvsH3ZXb9tVlFZariEVZCctJdIxIwnxslELHi4N7wQ7VACiy3I7eZkpL7jzMK3+DV7f8UCAySfXvlX31ejVLSD2KNw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(82310400005)(40460700003)(40480700001)(86362001)(36756003)(356005)(6916009)(4326008)(2616005)(8676002)(316002)(70586007)(478600001)(70206006)(26005)(1076003)(186003)(6666004)(16526019)(54906003)(7696005)(2906002)(36860700001)(41300700001)(8936002)(44832011)(336012)(83380400001)(47076005)(426003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 16:15:53.6292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4e7965-dcf9-482f-9e47-08db0ea6bf2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arvind.Yadav@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

This patch adds changes:
- to accommodate the new GEM domain DOORBELL
- to accommodate the new TTM PL DOORBELL

to manage doorbell allocations as GEM Objects.

V2: Addressed reviwe comments from Christian
    - drop the doorbell changes for pinning/unpinning
    - drop the doorbell changes for dma-buf map
    - drop the doorbell changes for sgt
    - no need to handle TTM_PL_FLAG_CONTIGUOUS for doorbell

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 11 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index b48c9fd60c43..ff9979fecfd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -147,6 +147,14 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 		c++;
 	}
 
+	if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
+		places[c].fpfn = 0;
+		places[c].lpfn = 0;
+		places[c].mem_type = AMDGPU_PL_DOORBELL;
+		places[c].flags = 0;
+		c++;
+	}
+
 	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
 		places[c].fpfn = 0;
 		places[c].lpfn = 0;
@@ -466,7 +474,7 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
 		goto fail;
 	}
 
-	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
+	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU,  AMDGPU_GEM_DOMAIN_DOORBELL */
 	return true;
 
 fail:
@@ -1014,6 +1022,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
 	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
 		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
 	}
+
 }
 
 static const char *amdgpu_vram_names[] = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0e8f580769ab..e9dc24191fc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 	case AMDGPU_PL_GDS:
 	case AMDGPU_PL_GWS:
 	case AMDGPU_PL_OA:
+	case AMDGPU_PL_DOORBELL:
 		placement->num_placement = 0;
 		placement->num_busy_placement = 0;
 		return;
@@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	if (old_mem->mem_type == AMDGPU_PL_GDS ||
 	    old_mem->mem_type == AMDGPU_PL_GWS ||
 	    old_mem->mem_type == AMDGPU_PL_OA ||
+	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
 	    new_mem->mem_type == AMDGPU_PL_GDS ||
 	    new_mem->mem_type == AMDGPU_PL_GWS ||
-	    new_mem->mem_type == AMDGPU_PL_OA) {
+	    new_mem->mem_type == AMDGPU_PL_OA ||
+	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
 		/* Nothing to save here */
 		ttm_bo_move_null(bo, new_mem);
 		goto out;
@@ -586,6 +589,11 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
 		mem->bus.offset += adev->gmc.vram_aper_base;
 		mem->bus.is_iomem = true;
 		break;
+	case AMDGPU_PL_DOORBELL:
+		mem->bus.offset = mem->start << PAGE_SHIFT;
+		mem->bus.offset += adev->doorbell.doorbell_aper_base;
+		mem->bus.is_iomem = true;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1267,6 +1275,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
 		flags |= AMDGPU_PTE_VALID;
 
 	if (mem && (mem->mem_type == TTM_PL_TT ||
+		    mem->mem_type == AMDGPU_PL_DOORBELL ||
 		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
 		flags |= AMDGPU_PTE_SYSTEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 967b265dbfa1..9cf5d8419965 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -33,6 +33,7 @@
 #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
 #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
 #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
+#define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
 
 #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
 #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
-- 
2.34.1

