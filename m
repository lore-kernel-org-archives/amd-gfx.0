Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66B9C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 05:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6694B61B29
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 05:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6694B61B29
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D28C36E8F2;
	Thu, 18 Nov 2021 05:40:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E8B86E8F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 05:40:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyUUeE8vM9P5DGIohn87vpo0Uze9E2NeVB1tuRG2fmzjL+ZsS9KpMWq+ML4jdu9YjXnb0krJCDhBzFKButyOLaThaaKn5UH1Y7MoGePlNp8hfJ93blkIN/Wuuh/ZQ5o79PaAUYDpg5Qezx2KWvk6zF7vQ0dJCsr9B1ohmowF1EXisnFKV10jvqU9h/iiCzsRwqKQ0Vohp2R+k4zyaGicsSHUiqgOrYf1IwNKxWMzk6ARtdoRM4UOMAP/cqwolku5xfjMRxtlGybVFwg7zme0M/FylOXUc5JEmigt+nbKGnRCJyQh4u956cSH3EsVXUqIHWrIFp6FZQWB1BmMbkV35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PEAYc7g/dtA5lWJv2Wu6AG8f1GT9TVD5d1GoHRWvBI=;
 b=a52vKqyqguyHD/v68t49/oz8a5EDYLPSlrCTI+qNwBGac2K3/D5EHjDgVzA211XS9/mD1P+Vxt0kUDNGct96seTelfSrBZO++fbSlMR34lz7jHYpVGK7mwkuOCChtLknhDHx3s4GuqKl/in5+3ZtIjMQC16h64iOW1pwjFZLHSaUl8thGE4e50FRkc+jmUPeqIaVPzA2i3pTrzMKwQOEzZk9FP/0sL1DEbfDVtOmuz2ptlEDsaMYYQpStv6HscQuZEtpFCED06zxX1p5Dt2WclH0uHYAIsbW7aI8tUQ9wxMLPW+HBZzzbAJt398bBtNuF2OAnW+jhyUDS/KE8cf+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PEAYc7g/dtA5lWJv2Wu6AG8f1GT9TVD5d1GoHRWvBI=;
 b=oXq9IJCkXnZcNOoMKSAZ61MKKwfLuzy+Mv8AGVF381rK2ZG3BUQhc32TbkSliTS9yfNxiFtge7N/GFZaYUC18GwwqH/+cmAflxwqHq+xMsB0Np9DL2Ugr58IKVNZR+9d453Fb9KuCxrlQCFwmZNRIAOwRLKy2kEpIP3Ka9qyCCk=
Received: from MW4PR03CA0127.namprd03.prod.outlook.com (2603:10b6:303:8c::12)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 05:40:19 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::94) by MW4PR03CA0127.outlook.office365.com
 (2603:10b6:303:8c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Thu, 18 Nov 2021 05:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 05:40:19 +0000
Received: from alin.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 17 Nov
 2021 23:40:16 -0600
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: Retrieve SDMA numbers from amdgpu
Date: Thu, 18 Nov 2021 00:39:59 -0500
Message-ID: <20211118053959.15006-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 844c95fc-8383-473d-f3b1-08d9aa55e811
X-MS-TrafficTypeDiagnostic: MN2PR12MB4376:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4376105E9C7FF5B8B9AF92D9E19B9@MN2PR12MB4376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0ZelBRsS3sewRKPbni2V7GPIkzRIwY4ynmC0mS4pcxbBvXyKdKIMybEokfp37UBX5Sw4LG6Hll7jUaid8Z8WP8liTK9WZ8wq092LzhAM2TNJmNJZhHQ1JXbq662G4prDnjt4E7UVf6bULTx8/sxBolCukDOrQ3x6Sjv7Vbv5ADgbJOo+5O1MrpQbKMDYpS9Sgdg9xKi7PFFlu/TrTBol6vng0q3ND8ok9z9UDqRmzM0ywes6TpvtYJwPW9tqcw7wbO3eYfj3pZ5PyiJBMG0r1rRBQOXlab+tGQiypkARskSgr7awfjEmnOBQqS8kZQ7tVp2ApdwWfeBmQ0/7J0vQi736jUiW3aT6/QDBeUAwtXrdBebA53rrc0TFIGfV/CypVbTflsT4tM08JVWYN5zV5fS2/8xzs9tcK/WpNeUIPTBMqI04ae1xUDscpfTI9KuS5bgxxjM2+0j9BJ2Oo+E2b7hbwJoZZyqS8do1yhqUaI8hW9eDEJ/l69eEB1gtBGc0LlRK/rO6RWmdj6Uy5zBAdPp6gaR9eHSpBPDc7dSHMeYX/WhOk+jc1dECkMzkGq7uzq2EoBG+278+eIWkltAl49aGjExvFBlubk5XucVZhOZAY7fYD1ikXRKVMQR005/ktZzNNlt4Ff6jlFLK71Av3893vH6MlNQzvDhHX+xe/1c489zMgrNo4AGGSY2vfX+ppNAzuYj+gVrrF7g3UJ3z4F8uZfMr/lyWloTS34yqEk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(16526019)(70586007)(186003)(82310400003)(70206006)(6666004)(336012)(47076005)(8936002)(5660300002)(2616005)(426003)(8676002)(508600001)(4326008)(356005)(6916009)(86362001)(1076003)(2906002)(26005)(81166007)(7696005)(83380400001)(36756003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 05:40:19.0489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 844c95fc-8383-473d-f3b1-08d9aa55e811
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
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

v2: add kfd_ prefix to non static function names

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 20 ++++++++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 32 +++++++------------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  4 +--
 4 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index ce9f4e562bac..3fea47e37c17 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1516,6 +1516,26 @@ void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask)
 		kfd_smi_event_update_thermal_throttling(kfd, throttle_bitmask);
 }
 
+/* kfd_get_num_sdma_engines returns the number of PCIe optimized SDMA and
+ * kfd_get_num_xgmi_sdma_engines returns the number of XGMI SDMA.
+ * When the device has more than two engines, we reserve two for PCIe to enable
+ * full-duplex and the rest are used as XGMI.
+ */
+unsigned int kfd_get_num_sdma_engines(struct kfd_dev *kdev)
+{
+	/* If XGMI is not supported, all SDMA engines are PCIe */
+	if (!kdev->adev->gmc.xgmi.supported)
+		return kdev->adev->sdma.num_instances;
+
+	return min(kdev->adev->sdma.num_instances, 2);
+}
+
+unsigned int kfd_get_num_xgmi_sdma_engines(struct kfd_dev *kdev)
+{
+	/* After reserved for PCIe, the rest of engines are XGMI */
+	return kdev->adev->sdma.num_instances - kfd_get_num_sdma_engines(kdev);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 /* This function will send a package to HIQ to hang the HWS
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 62fe28244a80..2af2b3268171 100644
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
+	return kfd_get_num_sdma_engines(dqm->dev) +
+		kfd_get_num_xgmi_sdma_engines(dqm->dev);
 }
 
 unsigned int get_num_sdma_queues(struct device_queue_manager *dqm)
 {
-	return dqm->dev->device_info->num_sdma_engines
-			* dqm->dev->device_info->num_sdma_queues_per_engine;
+	return kfd_get_num_sdma_engines(dqm->dev) *
+		dqm->dev->device_info->num_sdma_queues_per_engine;
 }
 
 unsigned int get_num_xgmi_sdma_queues(struct device_queue_manager *dqm)
 {
-	return dqm->dev->device_info->num_xgmi_sdma_engines
-			* dqm->dev->device_info->num_sdma_queues_per_engine;
+	return kfd_get_num_xgmi_sdma_engines(dqm->dev) *
+		dqm->dev->device_info->num_sdma_queues_per_engine;
 }
 
 void program_sh_mem_settings(struct device_queue_manager *dqm,
@@ -1054,9 +1045,9 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 		dqm->sdma_bitmap &= ~(1ULL << bit);
 		q->sdma_id = bit;
 		q->properties.sdma_engine_id = q->sdma_id %
-				get_num_sdma_engines(dqm);
+				kfd_get_num_sdma_engines(dqm->dev);
 		q->properties.sdma_queue_id = q->sdma_id /
-				get_num_sdma_engines(dqm);
+				kfd_get_num_sdma_engines(dqm->dev);
 	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
 		if (dqm->xgmi_sdma_bitmap == 0) {
 			pr_err("No more XGMI SDMA queue to allocate\n");
@@ -1071,10 +1062,11 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 		 * assumes the first N engines are always
 		 * PCIe-optimized ones
 		 */
-		q->properties.sdma_engine_id = get_num_sdma_engines(dqm) +
-				q->sdma_id % get_num_xgmi_sdma_engines(dqm);
+		q->properties.sdma_engine_id =
+			kfd_get_num_sdma_engines(dqm->dev) +
+			q->sdma_id % kfd_get_num_xgmi_sdma_engines(dqm->dev);
 		q->properties.sdma_queue_id = q->sdma_id /
-				get_num_xgmi_sdma_engines(dqm);
+			kfd_get_num_xgmi_sdma_engines(dqm->dev);
 	}
 
 	pr_debug("SDMA engine id: %d\n", q->properties.sdma_engine_id);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 1d3f012bcd2a..1054fedd7b3c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -213,6 +213,9 @@ struct kfd_device_info {
 	unsigned int num_sdma_queues_per_engine;
 };
 
+unsigned int kfd_get_num_sdma_engines(struct kfd_dev *kdev);
+unsigned int kfd_get_num_xgmi_sdma_engines(struct kfd_dev *kdev);
+
 struct kfd_mem_obj {
 	uint32_t range_start;
 	uint32_t range_end;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index a3f590e17973..2d44b26b6657 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1392,9 +1392,9 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		gpu->shared_resources.drm_render_minor;
 
 	dev->node_props.hive_id = gpu->hive_id;
-	dev->node_props.num_sdma_engines = gpu->device_info->num_sdma_engines;
+	dev->node_props.num_sdma_engines = kfd_get_num_sdma_engines(gpu);
 	dev->node_props.num_sdma_xgmi_engines =
-				gpu->device_info->num_xgmi_sdma_engines;
+					kfd_get_num_xgmi_sdma_engines(gpu);
 	dev->node_props.num_sdma_queues_per_engine =
 				gpu->device_info->num_sdma_queues_per_engine;
 	dev->node_props.num_gws = (dev->gpu->gws &&
-- 
2.17.1

