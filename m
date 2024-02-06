Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A839C48BC0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 637F1112CAB;
	Tue,  6 Feb 2024 15:59:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n3umbmMf";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A620112B47
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFvIjdo9tFwLlPMtPidBqogFaJO6q9W4Uux1x3Ku/Xo6YM2VibQPLwVwZL634XNfvZkOrNtIyyYXinDBt50Qg19/N2z9xriSEUzEP6j9bRBAoVCuhad9R3NXfCnqY8iCxzkIMsm9Aj6Oc0z4I32dAS9pFqEPgYsu5vdHIHMqfTU4vxuaOmdIiN4ulD3WXDWiRqIMEuoOD2f4tOObS1tjU0JhAxeaQVAlyP7+i16zjDXy540n1P+/cgY8Gt1SicMQrX3Q3duVpDdN0tLskpzs2X6gz2JCenDBrCtcASAxsgkuIrWfMwf/IMeCGTBY39Sa02oP3P9v7Av5eMszucKkFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJGr/KBin95GbE82J5mUeRfEPBOufii6qLcVqb3bxkU=;
 b=F5nSVJh5RKhlqWLLspgSbnyGVBHIfPVRvSQM8AkasSjGkEPTnsP80uwPlip94Rymocz4JD5tU5iYG+KirxQgjwQaRzvpwyqnxsMo9xZpiXxS4fYCR5wIGJP/k++XuSN7KsbynmhHDyp38/uRqT/5PJ5Nr/xqbVgS7/BAUd2rIyPZHSLZNgfKX14ZjfbfFL6y84iQ//SDBMWNDYUUUDh9rSxq2KCPIcWGhEQuqOPO404KvH33dqC/MwFbOGz6/7FcXNMCyT0ZyBk7VZJgCzUXX+ci1F8yHY1rj5v3NnoC51kDHk9edE8LFRhQgydhZQnJZjLkIND6RmVtH0+9q9PdUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJGr/KBin95GbE82J5mUeRfEPBOufii6qLcVqb3bxkU=;
 b=n3umbmMfho4+2hgIgIG+A6ZDvs8w2UpqYD05OnNPSyAspPylorU0EyE6CuhWQnZIvH5qkIWxZAtVCcsU8LHVo2ifqiW8FCJ786rIQSCBxUhjMZxzgTbfXaLuYDWvui1pnlbpcJk0kC9K1X7AhHdy+9h9A5EoDpRZZFN+VZkFsIk=
Received: from SJ0PR03CA0218.namprd03.prod.outlook.com (2603:10b6:a03:39f::13)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Tue, 6 Feb
 2024 15:59:45 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::24) by SJ0PR03CA0218.outlook.office365.com
 (2603:10b6:a03:39f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:44 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:40 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 19/24] drm/amdkfd: add queue remapping
Date: Tue, 6 Feb 2024 10:59:15 -0500
Message-ID: <20240206155920.3171418-20-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|BL1PR12MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a408c64-6dbd-49d9-a247-08dc272ca2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qit5g+OyTbHrE2JAmhahkyGTxhHSmGw2HmGshkEkT8h2F0cpnHLLfpfysk56X3uaB7jIjmJ+owc8oP6G85hlPRo+eZPWAq0NxeF5OMZjPmfutp/Vs81teu6Tco8OaDmgJ42MWuCKSYhImqoIAmF158eVguO9j4LXUNXjwph0lhBy8RVjEbgYXn1q/EKX9SJPHze2BtAeydsbw1HeHo3tohCFi+2VeZ7Lb6PWz3JEVEF1EXdc/iHlsnSWsmAX1jbxejeab4dJm0LBzPI+vfFFhoDFztCdvBuAnNSEcK/C8saU7H/lhe5MX56+ctMJziKgKvDkSIC7cEoX4C4xt/zOOL5LU15CHVKAkusFkYV8sXsUZtThY+lmGV7emkYq9fqm38oIdC11UNERU9jmdL9Q0SoaCueKp9O/aQLmbZAngs3r9ewMX7PtXyNtSapw0VTDmhjbOE7i19PslsvB2ChFMSKTOXtS/wvpU+RG3vyeL7Wk1f5LGNiPLVn1ZEXKGghqrrNRb+K6O9eGYu06gQEq685Jn9OyPhdgHw5H8NTOqrVYzHIC6dnpoC8QSRve+ernvr7RW4pMlbubUSydMWzDlMGQf69Fb7gWf27ifSuRzbUE8fFtTUXHCcBSwtxj1HxXN87/Gqa454bnsPuaNn+z0PRx9KpIru88cUrxj34IoH8BG6jNJxPFWCVPyaZXT3eUe9eO70Iwtsuv+YB3euP7yGxKeZucX5Ppetl9u3NhUYgjeVpbgvvCriKcRQ9xbZBk1wp4D72lCYO9/VUhUuq8Yw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(356005)(40480700001)(40460700003)(47076005)(36860700001)(81166007)(82740400003)(83380400001)(2616005)(26005)(16526019)(336012)(426003)(86362001)(6666004)(7696005)(1076003)(478600001)(36756003)(70206006)(70586007)(316002)(6916009)(8676002)(41300700001)(2906002)(54906003)(4326008)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:44.4896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a408c64-6dbd-49d9-a247-08dc272ca2fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
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

Add queue remapping to ensure that any waves executing the PC sampling
part of the trap handler are done before kfd_pc_sample_stop returns,
and that no new waves enter that part of the trap handler afterwards.
This avoids race conditions that could lead to use-after-free. Unmapping
and remapping the queues either waits for the waves to drain, or preempts
them with CWSR, which itself executes a trap and waits for previous traps
to finish.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h |  5 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c          |  4 +++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c0e71543389a..a3f57be63f4f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3155,6 +3155,17 @@ int debug_refresh_runlist(struct device_queue_manager *dqm)
 	return debug_map_and_unlock(dqm);
 }
 
+void remap_queue(struct device_queue_manager *dqm,
+				enum kfd_unmap_queues_filter filter,
+				uint32_t filter_param,
+				uint32_t grace_period)
+{
+	dqm_lock(dqm);
+	if (!dqm->dev->kfd->shared_resources.enable_mes)
+		execute_queues_cpsch(dqm, filter, filter_param, grace_period);
+	dqm_unlock(dqm);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static void seq_reg_dump(struct seq_file *m,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index cf7e182588f8..f8aae3747a36 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -303,6 +303,11 @@ int debug_lock_and_unmap(struct device_queue_manager *dqm);
 int debug_map_and_unlock(struct device_queue_manager *dqm);
 int debug_refresh_runlist(struct device_queue_manager *dqm);
 
+void remap_queue(struct device_queue_manager *dqm,
+				enum kfd_unmap_queues_filter filter,
+				uint32_t filter_param,
+				uint32_t grace_period);
+
 static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device *pdd)
 {
 	return (pdd->lds_base >> 16) & 0xFF;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 53e44e68408e..df2f4bfd0cda 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -24,6 +24,7 @@
 #include "kfd_priv.h"
 #include "amdgpu_amdkfd.h"
 #include "kfd_pc_sampling.h"
+#include "kfd_device_queue_manager.h"
 
 struct supported_pc_sample_info {
 	uint32_t ip_version;
@@ -115,9 +116,10 @@ static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
 
 	kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
 		pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, false);
+	remap_queue(pdd->dev->dqm,
+		KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
 
 	if (pc_sampling_stop) {
-
 		mutex_lock(&pdd->dev->pcs_data.mutex);
 		pdd->dev->pcs_data.hosttrap_entry.base.target_simd = 0;
 		pdd->dev->pcs_data.hosttrap_entry.base.target_wave_slot = 0;
-- 
2.25.1

