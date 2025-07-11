Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51645C83F1B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8C1710EAD5;
	Fri, 11 Jul 2025 22:40:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5XL4rub3";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C4010EAD5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDdIOOYlAXb09vVxzQBRzUTwhP7JauFUyLTM4QcTG5JQiESDRLbdUWwtfLiw2e/5TrXfEYknnqvJ0TdfAAtuDk+J6RIE5MliIeN47snT1mvtWZytNsE0E0oHsGsMGJyv+Fg7VTl2hx5pj4sAnzUu7Mu9/ckVcPO0cXTQksvo9jHRFQgZjK5Ycczae86fmBP/pT0ZY9XfmEzx1xGVYphP/wu059Z+dZZH4J7mJQJ1BMa412Jxntr/JOomeyae5H1HC9UjZ9zWkdOrF/xvjjMHIYOA8ovtNjMhlMKYeYnLtHl0zZBRl1jDkECVacqAm4EhqRvcdXkkV5ZVQUxu5+lZTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ij1udK/K6ROCspEkzCIILI+oppZ++51Ayp93nb2SkNM=;
 b=YxGu7MiiXMpNDD2NWHfm0cKkdtMZ+LAJaKgSyKW9UhikNeXOUIwwUvAn1ISdSxUYvvGtF13/xxeZ4b/uUlVq5UfnS/NWLRwI/PyvgOstGVDxV47vQqQWl5Uhowj4w0Y11NxEXOILd4eZ6R6OKmpy4oinnE8pymsd+gf74URquHqAIbAazD/p12g+ezZlkPtFgrDrZhueTy2bzXrrvogC7CnhdoYj9S7WhVFCZ641a2B/ZgmCoIPyPAtRhcuvjKoGneBzMzZfuIsmjQBMTcVAvV+9SpsmOaVGq75giYdAK78hpDT8Pu20trpl7ab6/d85wlzTiVxO4gVdo9BsPfm2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ij1udK/K6ROCspEkzCIILI+oppZ++51Ayp93nb2SkNM=;
 b=5XL4rub3LS8qvTyip62mbDoXwLBJfJjrsXJUsRmuVd0NJhSoEcGMstVAw8J0scWbJQIuwG08bkYxxEyUoQHeU7+fnlGPLOk9YelNXh9b1jOmyr5ak2g3ZEsqriIdsPipYFBOPI4K91l0vn/46fnhjvRQ4/MhnPrwiFZHZMA75VM=
Received: from BYAPR01CA0055.prod.exchangelabs.com (2603:10b6:a03:94::32) by
 MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 22:40:41 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::de) by BYAPR01CA0055.outlook.office365.com
 (2603:10b6:a03:94::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.26 via Frontend Transport; Fri,
 11 Jul 2025 22:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/33] drm/amdgpu: clean up sdma reset functions
Date: Fri, 11 Jul 2025 18:39:52 -0400
Message-ID: <20250711224024.410506-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: ca134edf-9deb-4662-527e-08ddc0cbf6a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lvXG5vhYHOl1H1C28mn6GpBa4xPOLUKiiG1fW8vKXIMr+0W2KAVmjQ7gPvRp?=
 =?us-ascii?Q?XlzumgmirlwsDw3JY4iUo4Rj36+blTCc1v/jac/gfGstLjDQFB8t36/nljf8?=
 =?us-ascii?Q?10ZGxaiIMBFCr+hneOI5FEYpd8JE1QAZgqOMRPZORNzvnKvG85wkLUJeJ6Nh?=
 =?us-ascii?Q?fhKUHXSmM6h3CJHzwXgOXdQtbKPpuu3CosOVk5a0hXSuf1tDsnb4QZALMGgq?=
 =?us-ascii?Q?cu0ML5zXWkFjsedE4jDTG+BCHyKF9V5Sty+a5qCslV/JCJcjKYXK5SLsq9Zz?=
 =?us-ascii?Q?nSNgi3F/UFYWVobNQ16l4y62ZP15WdxWXtt/aqqgwcTAiTATABU0bl4tPF1X?=
 =?us-ascii?Q?ApbWg/m3HMJrYRnH0BABvRIaPafdzvoLZVHIV61OFGXA5s9clONKJ4e+bbnL?=
 =?us-ascii?Q?wnkQoc+iZgzFBtQZcQcc2SMV3HmebNFpp77L+1W90K5U2lyVs3BAxmpGVinQ?=
 =?us-ascii?Q?+sEch5VzdWFEZ4g0BkCUhyyVyw7vQVE7TQpK9Qz3k6BUI0C9dFSDjaKLHysV?=
 =?us-ascii?Q?r2yTSe+TCWKwyBivd0U+0m90kOUl7NJ6KsBsOXvKXNIef0NNlRLSATH+GvsF?=
 =?us-ascii?Q?JfrOy3vnAr7u3qyDjnWlann1F0C4P+PX15SFNpbM/zmB7TGv9c8RsvF4ZCfs?=
 =?us-ascii?Q?DGGrNohbeU0k5biXlPDdeexwOiNSplgYy77OuEPlDCw2kcDrhsNFPS063Z6O?=
 =?us-ascii?Q?0uTEbl6FzHEMjavK1Aanpw6sQo3AH8J5D5XT8IqMLMvD45BWl5pljSp28nkG?=
 =?us-ascii?Q?5SUUZ6tQWtneUeSp9ATyVv0b9P1JadU0A743epUJ8VTYp0bhiHa6QxO7fLon?=
 =?us-ascii?Q?aOlgmy0QXubCMdTNR4Y39cyqPusdN7JNMaslTlcPi4UuSFC7c4GMzGVZGHZ0?=
 =?us-ascii?Q?ZX/URvSBqtLRhglvHmCYeEPCwXJ6cEaXhM4BeIDKdiuEREp7FaoRPjNzdAZH?=
 =?us-ascii?Q?/DwNXCmFGDWMJmX0df58mY0OUuORfCMN7wj51G/1OACK3zQWtJVy9qE4qqa/?=
 =?us-ascii?Q?eGyhn+HfLP+97XcbydsWxZPe5Uhc5tkM9ceEbj+u+CC9qWjcHPQiZxer7eo4?=
 =?us-ascii?Q?sn/ggJrfkBrDCv2fAQZeJvxkM5qea3t1IPWal4PYEvJpz0Qy0erOMbbGGvQp?=
 =?us-ascii?Q?14fIcS7aACt0737o4/vzMkqqpe7xP1lwqbbd3cR3QlAv7T3bo3BZG2JGk/pl?=
 =?us-ascii?Q?02rmw0FtWsd3oxBwAQV+au93t5X+IRtOPhcx6rpwnLsVKbHpKFCNRytN58MY?=
 =?us-ascii?Q?ccWrKNsJ/2egzlCHLHaIDvqItd8kXuzo2dGmt8okvHMIGRRJhJpgCUwVOgV2?=
 =?us-ascii?Q?6GNwdYKqUIId71X7t3Aj785PXIIvBBob3KRFR80wLv8nigJpG4UcLvT+Ags6?=
 =?us-ascii?Q?59t9xqH0SPfLqSiVHn/YLvxG6uShSQQOWgYs2czXx8BZL2lejSEYq+Ff+8wL?=
 =?us-ascii?Q?1wAchhaBZV7iuPHTNLgnjnnHG9knwqZdC2vQkcllUfddK9z2sfHRA7H8bW1Z?=
 =?us-ascii?Q?ireSXiGD+KXwEprCYdwj5SjNEApDWepxpYda?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:40.4686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca134edf-9deb-4662-527e-08ddc0cbf6a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365
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

Make them consistent and drop unneeded extra variables.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 14 +++++++++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 17 +++++++++++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 20 ++++++++------------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 20 ++++++++------------
 4 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 5a1098bdd8256..999705e7b2641 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1428,7 +1428,8 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(5, 0, 0):
 	case IP_VERSION(5, 0, 2):
 	case IP_VERSION(5, 0, 5):
-		if (adev->sdma.instance[0].fw_version >= 35)
+		if ((adev->sdma.instance[0].fw_version >= 35) &&
+		    !amdgpu_sriov_vf(adev))
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	default:
@@ -1544,11 +1545,18 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 inst_id = ring->me;
 	int r;
 
+	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
+
+	if (ring->me >= adev->sdma.num_instances) {
+		dev_err(adev->dev, "sdma instance not found\n");
+		return -EINVAL;
+	}
+
 	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, inst_id, false);
+	r = amdgpu_sdma_reset_engine(adev, ring->me, false);
 	amdgpu_amdkfd_resume(adev, true);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 6843c2c3d71f5..e542195972dd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1347,11 +1347,13 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(5, 2, 2):
 	case IP_VERSION(5, 2, 3):
 	case IP_VERSION(5, 2, 4):
-		if (adev->sdma.instance[0].fw_version >= 76)
+		if ((adev->sdma.instance[0].fw_version >= 76) &&
+		    !amdgpu_sriov_vf(adev))
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	case IP_VERSION(5, 2, 5):
-		if (adev->sdma.instance[0].fw_version >= 34)
+		if ((adev->sdma.instance[0].fw_version >= 34) &&
+		    !amdgpu_sriov_vf(adev))
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	default:
@@ -1457,11 +1459,18 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 inst_id = ring->me;
 	int r;
 
+	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
+
+	if (ring->me >= adev->sdma.num_instances) {
+		dev_err(adev->dev, "sdma instance not found\n");
+		return -EINVAL;
+	}
+
 	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, inst_id, false);
+	r = amdgpu_sdma_reset_engine(adev, ring->me, false);
 	amdgpu_amdkfd_resume(adev, true);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index d2effa5318176..c08e9a6cf6827 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1355,7 +1355,8 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(6, 0, 0):
 	case IP_VERSION(6, 0, 2):
 	case IP_VERSION(6, 0, 3):
-		if (adev->sdma.instance[0].fw_version >= 21)
+		if ((adev->sdma.instance[0].fw_version >= 21) &&
+		    !amdgpu_sriov_vf(adev))
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	default:
@@ -1575,18 +1576,13 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i, r;
-
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
+	int r;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (ring == &adev->sdma.instance[i].ring)
-			break;
-	}
+	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
 
-	if (i == adev->sdma.num_instances) {
-		DRM_ERROR("sdma instance not found\n");
+	if (ring->me >= adev->sdma.num_instances) {
+		dev_err(adev->dev, "sdma instance not found\n");
 		return -EINVAL;
 	}
 
@@ -1596,7 +1592,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	r = sdma_v6_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v6_0_gfx_resume_instance(adev, ring->me, true);
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 99a080bad2a3d..ba1f3e3b6eb61 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -807,18 +807,13 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i, r;
-
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
+	int r;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (ring == &adev->sdma.instance[i].ring)
-			break;
-	}
+	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
 
-	if (i == adev->sdma.num_instances) {
-		DRM_ERROR("sdma instance not found\n");
+	if (ring->me >= adev->sdma.num_instances) {
+		dev_err(adev->dev, "sdma instance not found\n");
 		return -EINVAL;
 	}
 
@@ -828,7 +823,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	r = sdma_v7_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v7_0_gfx_resume_instance(adev, ring->me, true);
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
@@ -1346,7 +1341,8 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	adev->sdma.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
-	adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+	if (!amdgpu_sriov_vf(adev))
+		adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
 	if (r)
-- 
2.50.0

