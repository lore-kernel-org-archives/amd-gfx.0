Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A66CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40FB6112DDB;
	Mon,  1 Jun 2026 05:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jocnAI1c";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BB72112DDF
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:54:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iy/l0Tk/8QomWIVzh8Pg9qk29gHCsKBObCPJ8GCt2IHKfngmLZ1DAunJJ7ccDfLT3O85Qlk5ASHo3Oy7q3M1aHSeeajc3vGW7W6gMNL7VgLBBhGZT1cOYpjD//2Hwgvnd+O37eonmJsQJifcNRDWu8gv8QcxdGpS8yzj0XYHN3qDDkeq6Dcb9Z/jRF+cdoCk5YiXEwymc1bqC8IPGJ0aEk/64KXiWqyu3Tev7A5bOLGEHyb/5pSxXhGrOt2jybeL9VvMCjHG1u+Fsj4YWeyKf0DXLzPYgZ0R2QcwBk5C81LuqnL2g9yQ2myecRrAnpygHTrq0bF0TPnYJkGajfht0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8xwhV/rFHh73YKFSnnyLmFji+Zk2KxzwywyADffWZg=;
 b=mGuiES4IqVKcMfbX2EznPJNGNkZNd6n+bRlKVD0pI/DkRNGN7VyxuPsapD7cr3+0SgPjs6Wb6fKDPtaiDsNWA6kBQPqdqKi3vvEnL+aYwoVqMyxU4zzoq6WNTM4Mq7GbKSu4YBb6EWmijKtFXsrX3g+wPfB03H4eMROn9oFNSxBvx2S4azyZAdxED0UtGzCvqKKDFhXKywdEMUZ4kv2XWJfnD4nXVtSpH/2lnKmzerVX2x/NQW3Fh5LGPIKPlHG7tVDUjbrrfX6xYKtD4Jf7N8/UGMKUThuyEFLi8GOJvU8kxnxXnelKeS2+dG9JBHiLjyEhDlYc0ae7xa+GIJZ+6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8xwhV/rFHh73YKFSnnyLmFji+Zk2KxzwywyADffWZg=;
 b=jocnAI1cfqnmQSbp5GFuyFRUuD31lF2v7QnVgl0oun381WrFGCyGWBNa5Ez7Q68sVLZ6uepSv7jgrUjBriPbmoIlN5OAe+wyIOEkmdiV52+zIq4lRTb/6zNqKb3CS2ZeUZchyr57EYIDz0/w8qJOfM/wVc39U1onltX9JAP/TAI=
Received: from DS7PR03CA0055.namprd03.prod.outlook.com (2603:10b6:5:3b5::30)
 by BL4PR12MB9722.namprd12.prod.outlook.com (2603:10b6:208:4ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 05:54:54 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::aa) by DS7PR03CA0055.outlook.office365.com
 (2603:10b6:5:3b5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Mon, 1
 Jun 2026 05:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:54:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:54:53 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:54:47 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH v2 35/42] drm/amdkfd: plumb a helper to reset a KFD user queue
Date: Mon, 1 Jun 2026 13:49:21 +0800
Message-ID: <20260601055034.3700921-35-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|BL4PR12MB9722:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a28632-dc79-40b0-6efa-08debfa24ded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|22082099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: DveXde5sH3vGOI0l8e1uTpDpJNxbqa8uQlsAJskrBIlzBoel4WvfB//tnJY2pOAlrviMWp+9PLdebHPtsNz9AlGEC9AyWo3KJdpRCyYQeHuclZCsvIIMBTgW/z0YlmU6W0VlfX/4sQDIzmutLwWeE/GDF20Km7+g+SzP8ZE0mFA6omn3zgHe0b350Y9bDtztdoaXqWJbs1hH7VHx/oO1w8lq975w+QGiGuYnp1V4MkoXO08v6nQmvpmZtmbPqurA2YPLkuYUSX9yH+cMfPepq3Kvi+Moiw5xwJ3RR+0nFN67bVa15X8w6kzwBZChjA8D3etyIvRbDP4JCPHzgw17DRkwVAt+Yu36mEDNQSR2dYaTvUO8N/H7otCIyRIYmubY1ueDFwO1WaYoSpfCxCfasihS16d4e2Ax08WqJYt/tyxyLe+jRnVbHwmVLInVQOG4a9mmH7wbZnegYuZgUVFpVaUZ3+S0aTMENuq1G6TjAiKRfzFFIMjvIcwX8XqKgIyBlzpRD+ciG4eN+AO3cFxL+MnzEoV8hsl43C4SkAd31C9uHTPA3VBkw+BfigcYTfNwXfGRbRoCHJ+W9Ru8i+Zm93OXALRGmXz4RDLwb/lQNJZAtkl5YVd6cPqj3yBGU4LH57dnm32ilexmDjdnQZIzkkaq59N7Iq/ca42lYN8b2JpcXbVDn27mAHU6cTnKGDtIOTBVRicrkSyk/oq8OerRubDJFSQ2WxtPF1boy+1Ql8E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aftHefJRvbLWdj5hsCLBgM7Gp+0OPlxaYqMEesdGhg3P/xBLqePK94NVXl2dUc5TjZ1Ad06PjbFmsCnhxhDW22/2u+5PGk8jVjkeNjL/mJi7VrNUyw7dFFYk+MpW1kKPaYTlAoI/HKmPb1Yz0+ItH4UlxOA28vz+u14d6gIZpNhNursoWuKhMpieoFNBh69ZprzXVuqNnWNH1l6fg38nkx/+B0mp5sW9Me9t14ECV97wTYwB0fE7RJ7kCeOr+YuNcYv0RCZamg3Fo1TOfyTtFY3NrSBs1+JAWK/1SEplco4nbyNUSdcXtaVgTucrGpN8v3YtU74rVQJxyQoloFkW+bncYqYQOyTAF7arnIpMk6+s/gYJDJgDIT+pKd0ZsGN5iBmctXpfoFXx+3logccKlyX8bH+QZo1aDdN2K7V6FE+0XvXqPBI0avzXy7hGsdj7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:54:54.5503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a28632-dc79-40b0-6efa-08debfa24ded
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9722
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

From: Alex Deucher <alexander.deucher@amd.com>

Can be called from KGD.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 14 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 16 ++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 24 +++++++++++++++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 11 +++++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 ++
 5 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 0017d502d169..ffd059089c56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -942,3 +942,17 @@ int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
 
 	return r;
 }
+
+/* Reset an MES queue */
+int amdgpu_amdkfd_reset_mes_queue(struct amdgpu_device *adev,
+				  uint32_t node_id,
+				  int queue_type,
+				  int pipe, int queue,
+				  unsigned int db)
+{
+	if (!adev->kfd.init_complete)
+		return 0;
+
+	return kgd2kfd_reset_mes_queue(adev->kfd.dev, node_id, queue_type,
+				       pipe, queue, db);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 5333e052d56d..d403af5fb552 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -275,7 +275,11 @@ int amdgpu_amdkfd_stop_sched(struct amdgpu_device *adev, uint32_t node_id);
 int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
 	bool core_override_enable, bool reg_override_enable, bool perfmon_override_enable);
 bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, uint32_t node_id);
-
+int amdgpu_amdkfd_reset_mes_queue(struct amdgpu_device *adev,
+				  uint32_t node_id,
+				  int queue_type,
+				  int pipe, int queue,
+				  unsigned int db);
 
 /* Read user wptr from a specified user address space with page fault
  * disabled. The memory must be pinned and mapped to the hardware when
@@ -446,6 +450,9 @@ bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entr
 			       bool retry_fault);
 void kgd2kfd_lock_kfd(void);
 void kgd2kfd_teardown_processes(struct amdgpu_device *adev);
+int kgd2kfd_reset_mes_queue(struct kfd_dev *kfd, uint32_t node_id,
+			    int queue_type, int pipe, int queue,
+			    unsigned int db);
 
 #else
 static inline int kgd2kfd_init(void)
@@ -576,5 +583,12 @@ static inline void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
 {
 }
 
+static inline int kgd2kfd_reset_mes_queue(struct kfd_dev *kfd, uint32_t node_id,
+					  int queue_type, int pipe, int queue,
+					  unsigned int db)
+{
+	return 0;
+}
+
 #endif
 #endif /* AMDGPU_AMDKFD_H_INCLUDED */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9e77c4a842ef..e87e1b78ca42 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1793,6 +1793,30 @@ void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
 		cond_resched();
 }
 
+int kgd2kfd_reset_mes_queue(struct kfd_dev *kfd, uint32_t node_id,
+			    int queue_type, int pipe, int queue,
+			    unsigned int db)
+{
+	struct kfd_node *node;
+	int ret;
+
+	if (!kfd->init_complete)
+		return 0;
+
+	if (node_id >= kfd->num_nodes) {
+		dev_warn(kfd->adev->dev, "Invalid node ID: %u exceeds %u\n",
+			 node_id, kfd->num_nodes - 1);
+		return -EINVAL;
+	}
+	node = kfd->nodes[node_id];
+
+	ret = kfd_reset_queue_mes(node->dqm, queue_type, pipe, queue, db);
+	if (ret)
+		dev_err(kfd_device, "Error resetting queue\n");
+
+	return ret;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 /* This function will send a package to HIQ to hang the HWS
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 0a59a79ee28b..babf53b7b1bb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -433,6 +433,17 @@ static int reset_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	return 0;
 }
 
+int kfd_reset_queue_mes(struct device_queue_manager *dqm, int queue_type,
+			int pipe, int queue, unsigned int db)
+{
+	struct queue *q;
+
+	q = find_queue_by_doorbell_offset(dqm, db);
+	if (!q)
+		return 0;
+	return reset_queue_mes(dqm, q, queue_type, pipe, queue, db);
+}
+
 static int reset_queues_mes(struct device_queue_manager *dqm)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index e0b6a47e7722..2229f8b2f446 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -333,6 +333,8 @@ int debug_refresh_runlist(struct device_queue_manager *dqm);
 bool kfd_dqm_is_queue_in_process(struct device_queue_manager *dqm,
 				 struct qcm_process_device *qpd,
 				 int doorbell_off, u32 *queue_format);
+int kfd_reset_queue_mes(struct device_queue_manager *dqm, int queue_type,
+			int pipe, int queue, unsigned int db);
 
 static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device *pdd)
 {
-- 
2.49.0

