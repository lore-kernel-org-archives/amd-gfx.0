Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2ABC76196
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F6210E0E0;
	Tue, 28 Mar 2023 15:18:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 957B010E0E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:18:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yw9+b9sWCQ3gn1hefqfx2JMuIhnIqyiGN+RxdCeIgwg4jwRWJC66jbIyIlK5vFrdZWXLmompu/QLohfMuy6/MVhTbW+nC6e59Mwt3iomIvtvmEoQfVLi269h608dcGqclNzOOuPnXVZ4XAvIPNEpEQmyjj5JMW7eaMbTK4fPQ5FODhX/dv3K/H+gBmY0mtgECYRafohhv1en/vZJHCaXzyOFoNvfb1M+45PsY3vog+XL+Ql6OW1Uvqr0/nd68Rw5+/GQ/wXVW75O+oq29fK0L9aRqwUHzyNwjeHsdqixmFMPSxZAgt+4+emGz/vZ62CTq3m79p4huCZUfrKWZb050A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asyPwQLLqBXOn1BYeCG/t15RjBg9183p7xhfjbyf9+I=;
 b=lhMkmI2dAhfkrYRajCufQdyTSDy6VynFbei+51hBFtcv2ghjnM17UBepnfHBjahsI76t3fAyt2q+7PAGcJmhu6CTv6SAkgDzG+4XKjENRkNkCYZmGNccT0OshvG6G2g8DTJpEfThdZDvxayudAxnF8AnQcETU5XU8RT/huihadL+liz7nwWCXMZUYsmUqCa3KCfI7RtQ/3ew+4tNt6aYinvWidg0b6uql1tGsYFBtdaDNuVajqqek+UDd3FqzRW2CUI2BhDoVXXQ3bq745QLfJFZGebyE9DoZo6AekzAZHLttul45SVINzKhfeUKLYc+h2TWXYi1vqNeRtXBaBvIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asyPwQLLqBXOn1BYeCG/t15RjBg9183p7xhfjbyf9+I=;
 b=wXoxb0INkxAUeMF46QjvPya33b1yMcblasQ+a2DqXc8c0qQwbgB4cpbm57nrOjWdujNb0+o+aQ9+T5LjpexUZKTYVMwsJAhXy0pyc1dB5ehny6alI8AQp03yVGxwsFi66Eymvv4UvRhlvfuUYk5oNtr6jeqhnfpEnLZFWP+IJss=
Received: from BN0PR08CA0025.namprd08.prod.outlook.com (2603:10b6:408:142::10)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.26; Tue, 28 Mar
 2023 15:18:39 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::99) by BN0PR08CA0025.outlook.office365.com
 (2603:10b6:408:142::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:18:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:18:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:18:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] drm/amdkfd: Fix SDMA in CPX mode
Date: Tue, 28 Mar 2023 11:18:19 -0400
Message-ID: <20230328151824.1934600-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d0746c-2746-42a9-223e-08db2f9fb540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y0pZRnyr1JAQRPV0FBmYYU3UwCLnbjqUVl7q9Vz9wRiXI57w5b8GbVptWWcCN7lHZQ6ZcGSxvawtNa0vloHE/mpzNVDAZQtIAzhDAr2MpADblzN33139jSvKoTwMn2s/I3ebn1GdTbxKpU+k5M5Nbxwn3Y6YD3rWcorglhHmTCMoLak76JkhhnEM4fhNs2IrDB8wLX1vFPLwVUZUc1ZuolPM4rY1Ob6W6cZHNHa+3wLyFUwBeKYNCFhjhOZwymkCRB3PDYahkeUVuLeueyi8f+w8qDp9ipN8YX4xCUsJuRJRch7YwZMDHuF4lsqz8Hfv5eyv/uJNj6psJTsVErFsl54D0EXqCU5At+NyNdj8OkvxTBAp+XNxN2ZHGJlkf8EAwd+vGqMoWTr3TvGPmV9tVoXI3/pjlfqhw+MpojKrNrlNjwvbZ/7G+/ITF1AIB7HHRpsdcZOe2R6Bm0tXHM2nFzJj0mGBsAq4UsM/vgVUeu4SkNFZyWjtYmU/vz7vG5dPKlcn7mgIrS3i+zTA30Jk3dQT4DuR+G/hb+yAHIPgGHkt3O3jFgvopeu0kWDnGPErHGl5K+ydjWodqPxOOAKFxSJxSf17N/TkTeC8di9FiJDFo+sGEVmSn04HbRsEh9fSeLKepuZo5Jyl0XqJFQrO0i4tuTLcu+vX9i+cBx/S68gtJ990iJuKzeuHpBp7TJZ2ggil1ipxvsHBPLZXV1uLrRbLDfFYmNemrjgc/BuvGLY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(316002)(40460700003)(54906003)(36756003)(86362001)(5660300002)(40480700001)(82310400005)(6916009)(82740400003)(16526019)(1076003)(356005)(336012)(83380400001)(2616005)(81166007)(8936002)(36860700001)(2906002)(6666004)(426003)(70206006)(186003)(41300700001)(4326008)(70586007)(7696005)(478600001)(47076005)(8676002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:18:38.9929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d0746c-2746-42a9-223e-08db2f9fb540
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
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
Cc: Amber Lin <Amber.Lin@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

When creating a user-mode SDMA queue, CP FW expects
driver to use/set virtual SDMA engine id in MAP_QUEUES
packet instead of using the physical SDMA engine id.
Each partition node's virtual SDMA number should start
from 0. However, when allocating doorbell for the queue,
KFD needs to allocate the doorbell from doorbell space
corresponding to the physical SDMA engine id, otherwise
the hwardware will not see the doorbell press.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 62838d84b6f1..527a2e0eef81 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -363,7 +363,16 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
 		 */
 
 		uint32_t *idx_offset = dev->kfd->shared_resources.sdma_doorbell_idx;
-		uint32_t valid_id = idx_offset[q->properties.sdma_engine_id]
+
+		/*
+		 * q->properties.sdma_engine_id corresponds to the virtual
+		 * sdma engine number. However, for doorbell allocation,
+		 * we need the physical sdma engine id in order to get the
+		 * correct doorbell offset.
+		 */
+		uint32_t valid_id = idx_offset[qpd->dqm->dev->node_id *
+					       get_num_all_sdma_engines(qpd->dqm) +
+					       q->properties.sdma_engine_id]
 						+ (q->properties.sdma_queue_id & 1)
 						* KFD_QUEUE_DOORBELL_MIRROR_OFFSET
 						+ (q->properties.sdma_queue_id >> 1);
@@ -1388,7 +1397,6 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 		}
 
 		q->properties.sdma_engine_id =
-			dqm->dev->node_id * get_num_all_sdma_engines(dqm) +
 			q->sdma_id % kfd_get_num_sdma_engines(dqm->dev);
 		q->properties.sdma_queue_id = q->sdma_id /
 				kfd_get_num_sdma_engines(dqm->dev);
@@ -1418,7 +1426,6 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 		 * PCIe-optimized ones
 		 */
 		q->properties.sdma_engine_id =
-			dqm->dev->node_id * get_num_all_sdma_engines(dqm) +
 			kfd_get_num_sdma_engines(dqm->dev) +
 			q->sdma_id % kfd_get_num_xgmi_sdma_engines(dqm->dev);
 		q->properties.sdma_queue_id = q->sdma_id /
@@ -2486,6 +2493,7 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
 	int pipe, queue;
 	int r = 0, xcc;
 	uint32_t inst;
+	uint32_t sdma_engine_start;
 
 	if (!dqm->sched_running) {
 		seq_puts(m, " Device is stopped\n");
@@ -2530,7 +2538,10 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
 		}
 	}
 
-	for (pipe = 0; pipe < get_num_all_sdma_engines(dqm); pipe++) {
+	sdma_engine_start = dqm->dev->node_id * get_num_all_sdma_engines(dqm);
+	for (pipe = sdma_engine_start;
+	     pipe < (sdma_engine_start + get_num_all_sdma_engines(dqm));
+	     pipe++) {
 		for (queue = 0;
 		     queue < dqm->dev->kfd->device_info.num_sdma_queues_per_engine;
 		     queue++) {
-- 
2.39.2

