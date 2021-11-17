Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9538CC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 20:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C98A61406
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 20:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C98A61406
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C20B76E05C;
	Wed, 17 Nov 2021 20:37:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C5576E05C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 20:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNElWb9gr8tyt3ffU34kFIQm42iNTwDLZ+cq+XcrlAksqR9gUMKeDM4k1uNN5FrDySCugzv+yfIVT9ZbTydSJ4r/kelrmiETEAiYbE47GZ369se2fuv6wyjzyP6fJEzN5g//8gSXfcI/HxtLNsVPE5xpKc3C4WHCCirAl9IbPI9MhzkTbqmJ0C9CdX5lku3mbXEluYbHD9znQhOLNL1jvKaFYzbp+CPd9v+ms0U1BePTo/djXNderEHNFtEKn1NV4OMbDzqn+HtslgENYO6VvSyihh0+32jlmsehoNYhqm8oRfDFnDpMdnJ5w8UKIKhEsJv04i/jir08F8wd1nr2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0XQTHb7EZlotm1oSYHfMlFwnJT/v99NsLkfyR/Xh6o=;
 b=livoReV6yNCkryW99gcKu94BReZj/kEsTPeA8nneNelqToRlwbAKTyNX4BLdczX9RAJPlZlNLEavg7c6a8YG0naXtvGUnOJLb6l0sjt/NCmNd7r57jzv/jSGXbfVHIgrk09+XX/cm+L64pFUaaY+Mrtt7iiA/WSeYg8Z+zCmtHdfwYPAyucDGK857Z47icLN/GhKB+QuagI7zXu8qvOYNDD1OlO+41LyypVCz4UyBOIebFwriQiAzuZilUIQw2b3l/wCVXEF0vJCAPEJeYrHzYwiH1z4GRv6FmcJ9oBcTWx7QZBcv1Lrq7eWW/WFh5xu6AUC87qaAU1Vr2g5a/0fJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0XQTHb7EZlotm1oSYHfMlFwnJT/v99NsLkfyR/Xh6o=;
 b=KX3IjsG4VDAOMO/HB7JJnFoxzVWHtdq2Hj1StiIYqh3V2PS752OzUiLvzfjQJo2e4GgHe+Fn0sxwb5R7j0q32qjmTa5hsKNt38diMn1fqJ3WFxB1OrmLYXNDtX38FytVhdA0Cs4wwssdHtbYV5lxJ7hVxLJGqNfqFDLRiD+aSfc=
Received: from DM5PR19CA0050.namprd19.prod.outlook.com (2603:10b6:3:116::12)
 by BY5PR12MB4949.namprd12.prod.outlook.com (2603:10b6:a03:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Wed, 17 Nov
 2021 20:37:06 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::ce) by DM5PR19CA0050.outlook.office365.com
 (2603:10b6:3:116::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Wed, 17 Nov 2021 20:37:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Wed, 17 Nov 2021 20:37:05 +0000
Received: from alin.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 17 Nov
 2021 14:37:04 -0600
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Retrieve SDMA numbers from amdgpu
Date: Wed, 17 Nov 2021 15:36:48 -0500
Message-ID: <20211117203648.26521-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13c07d8b-e093-4d7d-4fe9-08d9aa0a04f8
X-MS-TrafficTypeDiagnostic: BY5PR12MB4949:
X-Microsoft-Antispam-PRVS: <BY5PR12MB49499E3506B7927F054DA7EEE19A9@BY5PR12MB4949.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hGefMNVWi1L5l1f4Zk+s1+0ZHh6jEossp8M53Ri3W5ClMQshg7IVEa1NxK3G3Wex7xppiv0gNbsOMF24ozmnv67C35NOz2eZuchTIRJuDefcHyKo2D0JipkVuAt9DkD9vw2iFfzWmMYsfI1bl2kq1f+W1T/MQkvDOmggLCU0Ouks7P/hxGwvhjFFjuATqS7TZVNSnPnlX/NSWDhXGM/YyWTdFgb7NNBUzo4I8MMVM911yj0rlYUl8NSimFEz99IByloHGuFveYoirmEzMQ/7yUQa6Cp+vxUdho/ggZp2Yt+FkrqLv6GHVDs03Vtxvw25XOf53CtJeianUhsm9VPUSOC02c17nZU5rGez1XFNUQisl4KRV1+ky2U7JQKKfIeVgJY6/l4R8isyOVpW17iEfUBRSsbVvZj2e6T3nHZiNX4JOiytMNyE1cqPVUTS8WK3xj1Wt6i/f77w9TcNiGUeD962pPExy86od+GxcB5sNZkqnkFndO/DIGLnGnhGwKdsi5yWJJ4RXTv3kgPRLcJMgNYWElP5XXk0UOkIII4JNdPgowvnwLNVv1yU+Zn8aFDRYG1ziKx7lIdDmXZB3b8fTCF8Ncpi11skOcGBUxsSvFrP5Iwqx6q9tOaQxWDbO/ugdGPp8ooo9tVc7zLskCY+YRYDi0IL9MCbRtwBnQHrGrQai6Lzcmq9xy0Q3EEnCmqpUTYeLJv3SUxrtKLtu2+LLstfAAx6uIA+TjDT5e3ySL4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(83380400001)(81166007)(356005)(47076005)(6666004)(426003)(70586007)(5660300002)(70206006)(1076003)(336012)(2616005)(36756003)(508600001)(4326008)(16526019)(186003)(8936002)(7696005)(8676002)(26005)(6916009)(82310400003)(36860700001)(86362001)(316002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 20:37:05.8133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c07d8b-e093-4d7d-4fe9-08d9aa0a04f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4949
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
Cc: Amber Lin <Amber.Lin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of hard coding the number of sdma engines and the number of
sdma_xgmi engines in the device_info table, get the number of toal SDMA
instances from amdgpu. The first two engines are sdma engines and the
rest are sdma-xgmi engines unless the ASIC doesn't support XGMI.

v2: Move get_num_*_sdma_engines to global and shared by queues manager
    and topology.
v3: Use gmc.xgmi.supported to justify the SDMA PCIe/XGMI assignment

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 20 ++++++++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 31 +++++++------------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  5 ++-
 4 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index ce9f4e562bac..ec1f6bacb61e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1516,6 +1516,26 @@ void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask)
 		kfd_smi_event_update_thermal_throttling(kfd, throttle_bitmask);
 }
 
+/* get_num_sdma_engines returns the number of PCIe optimized SDMA and
+ * get_num_xgmi_sdma_engines returns the number of XGMI SDMA.
+ * When the device has more than two engines, we reserve two for PCIe to enable
+ * full-duplex and the rest are used as XGMI.
+ */
+unsigned int get_num_sdma_engines(struct kfd_dev *kdev)
+{
+	/* If XGMI is not supported, all SDMA engines are PCIe */
+	if (!kdev->adev->gmc.xgmi.supported)
+		return kdev->adev->sdma.num_instances;
+
+	return min(kdev->adev->sdma.num_instances, 2);
+}
+
+unsigned int get_num_xgmi_sdma_engines(struct kfd_dev *kdev)
+{
+	/* After reserved for PCIe, the rest of engines are XGMI */
+	return kdev->adev->sdma.num_instances - get_num_sdma_engines(kdev);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 /* This function will send a package to HIQ to hang the HWS
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 62fe28244a80..5f2886cf4d7e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -99,31 +99,22 @@ unsigned int get_pipes_per_mec(struct device_queue_manager *dqm)
 	return dqm->dev->shared_resources.num_pipe_per_mec;
 }
 
-static unsigned int get_num_sdma_engines(struct device_queue_manager *dqm)
-{
-	return dqm->dev->device_info->num_sdma_engines;
-}
-
-static unsigned int get_num_xgmi_sdma_engines(struct device_queue_manager *dqm)
-{
-	return dqm->dev->device_info->num_xgmi_sdma_engines;
-}
-
 static unsigned int get_num_all_sdma_engines(struct device_queue_manager *dqm)
 {
-	return get_num_sdma_engines(dqm) + get_num_xgmi_sdma_engines(dqm);
+	return get_num_sdma_engines(dqm->dev) +
+		get_num_xgmi_sdma_engines(dqm->dev);
 }
 
 unsigned int get_num_sdma_queues(struct device_queue_manager *dqm)
 {
-	return dqm->dev->device_info->num_sdma_engines
-			* dqm->dev->device_info->num_sdma_queues_per_engine;
+	return get_num_sdma_engines(dqm->dev) *
+		dqm->dev->device_info->num_sdma_queues_per_engine;
 }
 
 unsigned int get_num_xgmi_sdma_queues(struct device_queue_manager *dqm)
 {
-	return dqm->dev->device_info->num_xgmi_sdma_engines
-			* dqm->dev->device_info->num_sdma_queues_per_engine;
+	return get_num_xgmi_sdma_engines(dqm->dev) *
+		dqm->dev->device_info->num_sdma_queues_per_engine;
 }
 
 void program_sh_mem_settings(struct device_queue_manager *dqm,
@@ -1054,9 +1045,9 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 		dqm->sdma_bitmap &= ~(1ULL << bit);
 		q->sdma_id = bit;
 		q->properties.sdma_engine_id = q->sdma_id %
-				get_num_sdma_engines(dqm);
+				get_num_sdma_engines(dqm->dev);
 		q->properties.sdma_queue_id = q->sdma_id /
-				get_num_sdma_engines(dqm);
+				get_num_sdma_engines(dqm->dev);
 	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
 		if (dqm->xgmi_sdma_bitmap == 0) {
 			pr_err("No more XGMI SDMA queue to allocate\n");
@@ -1071,10 +1062,10 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 		 * assumes the first N engines are always
 		 * PCIe-optimized ones
 		 */
-		q->properties.sdma_engine_id = get_num_sdma_engines(dqm) +
-				q->sdma_id % get_num_xgmi_sdma_engines(dqm);
+		q->properties.sdma_engine_id = get_num_sdma_engines(dqm->dev) +
+			q->sdma_id % get_num_xgmi_sdma_engines(dqm->dev);
 		q->properties.sdma_queue_id = q->sdma_id /
-				get_num_xgmi_sdma_engines(dqm);
+			get_num_xgmi_sdma_engines(dqm->dev);
 	}
 
 	pr_debug("SDMA engine id: %d\n", q->properties.sdma_engine_id);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 1d3f012bcd2a..85efa100a80d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -213,6 +213,9 @@ struct kfd_device_info {
 	unsigned int num_sdma_queues_per_engine;
 };
 
+unsigned int get_num_sdma_engines(struct kfd_dev *kdev);
+unsigned int get_num_xgmi_sdma_engines(struct kfd_dev *kdev);
+
 struct kfd_mem_obj {
 	uint32_t range_start;
 	uint32_t range_end;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index a3f590e17973..fff4cc99fb5d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1392,9 +1392,8 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		gpu->shared_resources.drm_render_minor;
 
 	dev->node_props.hive_id = gpu->hive_id;
-	dev->node_props.num_sdma_engines = gpu->device_info->num_sdma_engines;
-	dev->node_props.num_sdma_xgmi_engines =
-				gpu->device_info->num_xgmi_sdma_engines;
+	dev->node_props.num_sdma_engines = get_num_sdma_engines(gpu);
+	dev->node_props.num_sdma_xgmi_engines = get_num_xgmi_sdma_engines(gpu);
 	dev->node_props.num_sdma_queues_per_engine =
 				gpu->device_info->num_sdma_queues_per_engine;
 	dev->node_props.num_gws = (dev->gpu->gws &&
-- 
2.17.1

