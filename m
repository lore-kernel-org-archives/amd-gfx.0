Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933AEC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 14:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FBB460FC0
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 14:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4FBB460FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1E1B893CD;
	Wed, 11 Aug 2021 14:36:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C48D688DE5
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 14:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzChYjtt91Z8jDyEbsn2uibze6ZFeWux8/gUf6XPtceyVcw5IOPaLOLKi4XWIxiTLKfQEsHMRaD7s2P9kEJEZgfrB+XeYLbcOwglMRmq0FSmV8RYmerkYRW707pYeL0cripdlgl6jKKejdpJbvCQqEh8dIyTFr/INzM313GAbBcuz2UXzfy4jw2k6z6fY4VzuDYVxH3X94WDkZ2sErSX4epaxc8wNy3xqhvUjsFdMKY464gP7PeD37dmzzhO2tbWB0G9HrylBLGg+fKHMF/MpCvkEd6nd4FqCZ05Vty966SQVSvY1706v06z3dbLScFHj+1cVQ3FQ6pB+F91dPeGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znQjU0/zPKpUQuY12tNu61x9MRoVLhdpXrm9WN0O0eM=;
 b=dF7lQfRO/QXYeINUBRoTJN9JXWXJ7e4vAriJD4mA9dmkuD1OQ3liEzTPtlVIa05FI9G1lTazXUyl/CvXJh9U7MWIVGuCRK7WKuyEHk4xEPcKpDMIJBHAiJNpjQ2B/caIBh0f8zTEp7BC0tFgtgT3ibNog8luwu7VNfrorkbpN4d/XtuNC3oM9kt968GX85kfAPVbNR9ZMZ+BtG5Zb2g4xgMhUkxXMC2FLkEH2zF6q13PRTiqAYLhJwWiyLLKRcR+XGWa9Orq8rS5NeoS+yn+FYcFpzp0Ff/VJfwW9yYBeRGwdRX6GGxk/+0UIzetUnSBfaLO/lPThaXtTgX8L09Pvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znQjU0/zPKpUQuY12tNu61x9MRoVLhdpXrm9WN0O0eM=;
 b=GJx4hGMU7ozHQusC569dOTUsMJQ6dSGpgRmprFE1wwHiSa18ucJ+2upHBQJ1w/pmHFux/dOXhIXjvP6+aexzolSs5poJ+RqdOOGhWQQrBLC4y+Kj+b6tOoS8lydgZ/9y4TtnM1NQ5weCrDPbZ33gSFnkyA1UdJGnyNifyTjsGdY=
Received: from BN0PR04CA0065.namprd04.prod.outlook.com (2603:10b6:408:ea::10)
 by DM5PR12MB1227.namprd12.prod.outlook.com (2603:10b6:3:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Wed, 11 Aug
 2021 14:36:17 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::9c) by BN0PR04CA0065.outlook.office365.com
 (2603:10b6:408:ea::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Wed, 11 Aug 2021 14:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Wed, 11 Aug 2021 14:36:17 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 09:36:15 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3] drm/amdkfd: AIP mGPUs best prefetch location for xnack on
Date: Wed, 11 Aug 2021 10:35:57 -0400
Message-ID: <20210811143557.26042-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210802162806.12631-1-Philip.Yang@amd.com>
References: <20210802162806.12631-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61f970d0-a939-4f11-f954-08d95cd56124
X-MS-TrafficTypeDiagnostic: DM5PR12MB1227:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1227CE52E3F27F1A5212AC3BE6F89@DM5PR12MB1227.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LjQeYivP9s80mVYKacpZKqTPmNpoynzwwC2C7O4R3te0ZgFqnIDv19ZKU/Lf2lUd6mRmLUgpxriue3hRbmKxblUr7Xm/5YYGkjkKLmFitf8fjVmJCepuS103PP4aIsc4aOiUBSIhWr4H4miBrjs/EyqAFFkPkpHOkYCBYNk81Qz/B53LMne3HzphXovsXHKn1cufCaP+JK7Ne5eXCM1AcgXDlfO6OfTM6JH5jWjfNNuEouWIYbf2+cw/HIyVQRuM6Ljk4q7BgsD5HdG9pHMGKpiO+dJV9uCpHOPGPd7k8HfqYLSe6XeCo2avQ54na5tqKb41SLNTMQdtOxIxihqSg9hHbbJskkuidyLcjTLGtUQD8aDR791j1DKZaijpsOYLzGNAOhPmE7/XEblfIVvfamqsdvrUpbhOBJhDQbflQkRhGiMmqysgck0ynwBoCyZas0XRvPMsIf054Dvr3Bga+7jKo31Njco69/r2dNqOyj8PPF+QZki7CsQRMbpKd+NPzg5I/hWYaz77bbyy19mtsRw3uajFv9M+qeTT4UT7pdFB6thkOU0f5b3rJTFnkvDfnv8tv1ENjS76xCO2MzRkz1xxEW5E41ZZUsGsojdIcexZboo03E+PdQP8XypP1Qg+9CDBxsdfkU4auTlSmOCG+lvRy0TmlpTEZs+zOdooWwHl0blL7DdQ2BdCB2uLwb4+lUHErOTqpiBzAbqWMRVVW77gil6xhVKUScnnPFyusi0oS8n5T9PZOfptpAAOR/cVOIqpDQQzf7jHTxIsM8dUWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(36840700001)(46966006)(186003)(83380400001)(478600001)(356005)(336012)(16526019)(6916009)(6666004)(81166007)(82310400003)(316002)(4326008)(36756003)(34020700004)(70206006)(8676002)(70586007)(47076005)(1076003)(8936002)(36860700001)(82740400003)(2906002)(86362001)(2616005)(5660300002)(26005)(7696005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 14:36:17.6798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f970d0-a939-4f11-f954-08d95cd56124
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1227
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

For xnack on, if range ACCESS or ACCESS_IN_PLACE (AIP) by single GPU, or
range is ACCESS_IN_PLACE by mGPUs and all mGPUs connection on XGMI same
hive, the best prefetch location is prefetch_loc GPU. Otherwise, the best
prefetch location is always CPU because GPU does not have coherent
mapping VRAM of other GPUs even with large-BAR PCIe connection.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 35 +++++++++++++++-------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f811a3a24cd2..4cdca8604d69 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2719,22 +2719,26 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	return 0;
 }
 
-/* svm_range_best_prefetch_location - decide the best prefetch location
+/**
+ * svm_range_best_prefetch_location - decide the best prefetch location
  * @prange: svm range structure
  *
  * For xnack off:
- * If range map to single GPU, the best acutal location is prefetch loc, which
+ * If range map to single GPU, the best prefetch location is prefetch_loc, which
  * can be CPU or GPU.
  *
- * If range map to multiple GPUs, only if mGPU connection on xgmi same hive,
- * the best actual location could be prefetch_loc GPU. If mGPU connection on
- * PCIe, the best actual location is always CPU, because GPU cannot access vram
- * of other GPUs, assuming PCIe small bar (large bar support is not upstream).
+ * If range is ACCESS or ACCESS_IN_PLACE by mGPUs, only if mGPU connection on
+ * XGMI same hive, the best prefetch location is prefetch_loc GPU, othervise
+ * the best prefetch location is always CPU, because GPU can not have coherent
+ * mapping VRAM of other GPUs even with large-BAR PCIe connection.
  *
  * For xnack on:
- * The best actual location is prefetch location. If mGPU connection on xgmi
- * same hive, range map to multiple GPUs. Otherwise, the range only map to
- * actual location GPU. Other GPU access vm fault will trigger migration.
+ * If range is not ACCESS_IN_PLACE by mGPUs, the best prefetch location is
+ * prefetch_loc, other GPU access will generate vm fault and trigger migration.
+ *
+ * If range is ACCESS_IN_PLACE by mGPUs, only if mGPU connection on XGMI same
+ * hive, the best prefetch location is prefetch_loc GPU, otherwise the best
+ * prefetch location is always CPU.
  *
  * Context: Process context
  *
@@ -2754,11 +2758,6 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 
 	p = container_of(prange->svms, struct kfd_process, svms);
 
-	/* xnack on */
-	if (p->xnack_enabled)
-		goto out;
-
-	/* xnack off */
 	if (!best_loc || best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED)
 		goto out;
 
@@ -2768,8 +2767,12 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 		best_loc = 0;
 		goto out;
 	}
-	bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
-		  MAX_GPU_INSTANCE);
+
+	if (p->xnack_enabled)
+		bitmap_copy(bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
+	else
+		bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
+			  MAX_GPU_INSTANCE);
 
 	for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
 		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
-- 
2.17.1

