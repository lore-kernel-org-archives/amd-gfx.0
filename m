Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB450C35274
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE5F610EA7E;
	Fri, 15 Dec 2023 16:00:53 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C89310EA67
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLFdF8L/q3woMPu+8Bm8tQnZ0qovnSj55URXAKgg252hFCfvAAQyHA9WLB7Cu/73ose3a1x2ms1GcaYKiZsU5wRIoaw4EFE506ILThGVfdv9JQeFDbK8i0fJSjH7iXS/8gIPqW8Vr/DEd9FEX/ksDUAou/8r1rZ9/rzI0tKDF2FOimfmGvJAd0wUIzg29gndebKGGYgTQhT8qL7XpsVrx8EiP5ViIRF4BCK/kuN30vjg0JWnqSHV7xzesQV4svkCUH7QcdiDwIqwBpuK+ptk9EYY8cXCOzf1SAv9Rb9Fx6IOjmFfMJ59ebQKKGtHbUPbDAjjcierh/M+MLwGQCcFPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EchToIdeaSBRjBxKxsRpwBdeR2aRtDs6I52ugtCtaE=;
 b=cOcEIEijTn+GZah3T0aOH65lk3a3ZUVRjehYxOfCPjE23anh8/7g1qqM3vhEHAt6JHpfkMIQQKoF8BtNJQNgIZOchBKwCU1CbetSon2TXWY8IyFau3JbpOuIaF9EVjFuMaKJLHbzi1jqS8rkiQBhQNhaiTGmGoi2tsp5OafKAx7g2Js1xYG650OjL3UiNHJEYeeSa5FpR/bh/Vx/Q9xsyPNXciVh084AyOa36xGpc0u0zm99jJSOHs1QNZqGCQcK1b1hsVTj2dVCIpXVv4bRCk++adaS4VA+ejsSma7+JgM6KOCbBPnkCC/nzvIYlkMcmPZFbt0fspUQO24GV18cEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EchToIdeaSBRjBxKxsRpwBdeR2aRtDs6I52ugtCtaE=;
 b=BSDYEjOH9Qf2MH7JVFW8iJrJr19pz0RL2ISCRY6vNXosvuzDbsXS5lF+8wDzLF0WLevovGhXBysyK0Z2HBkFaLMOujGA/UlddgU+UyB16A18FKSz97IFPIRz9tmCLfh+qM3UvE9ZXQCG2Q873/8cAcGQfLtTcqS2uIrWJUPkeSQ=
Received: from SN1PR12CA0097.namprd12.prod.outlook.com (2603:10b6:802:21::32)
 by CH3PR12MB7715.namprd12.prod.outlook.com (2603:10b6:610:151::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 16:00:46 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:802:21:cafe::ea) by SN1PR12CA0097.outlook.office365.com
 (2603:10b6:802:21::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:46 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:45 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 19/24] drm/amdkfd: add queue remapping
Date: Fri, 15 Dec 2023 10:59:46 -0500
Message-ID: <20231215155951.811884-20-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215155951.811884-1-James.Zhu@amd.com>
References: <20231215155951.811884-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CH3PR12MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c89ed4f-7b91-4f55-394f-08dbfd870024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QEWGyrM0mKriQKoXeii5LiRPLmK0B10Vs0/yhs6cB4qQMy98hsdNzk5xuu2wyuLbFdP8BbG7WiG8fu+20CDNbj77bi5pJmLO0PqWAlcPmuN3oEWy49nnH/NmD+hPiWHLFn2mxHeuNzaeu/wDBFSZDdsrS11qZ77ThM4b6cfYbrrO98bkHvzwqwnClUbF4DzqT0ORZE4YfIWMffxkbLWVPLDj7TA6UhUOnjozRAFPKg2anC745Xge9vgWN8gQ9S8rcE29SW/aOpn2fEoePpBSKnnt25DNLMwJ4p4SR/2300CQSdoxux777CpnWrMgToBroqFgDEomGBGsJlKnZkdH6YJufMa5hT4qTC5ozBWwMPyZpWRdeLmtUjPaPt3Ds53/qr4huuQv7nW3LBV9uuQWFME3kHCMYCriq9WdyYbw6mrPEIepvWi0TvjP/GI2eHQkHA42EDrD9WMFlSX/HYsZKzJVQR/Kbskva7zIF337DPY+cxAtT4FUU7/m5quZao9Kh2Zkpg9YwIcp+4s3rQyrRhDh9CRBn1tqOoByatPDKQ73jfvQ5gEiZfclvKCfYdecOfRIjgGv+gZcPPM+JHoY193HDZWGJq5LYmrNiFKY4WHLlSFBbSfDMT7W75eClVUEXgw1JQiTby2sbU1vBgqlQUFy77QSgXa4QKpGpAY++ANIZq/RIYhI4ayk2a+Rgc3gxYYKlE7Zk/9iI0KJIighX8s0bTHmyXOHJ6JUkr0wRLaExMK/bNMBsr+45XEG+y4zVt6AHiKDVdqNXiJmu6//aw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(41300700001)(16526019)(1076003)(478600001)(2616005)(36860700001)(7696005)(336012)(26005)(86362001)(70206006)(70586007)(40480700001)(426003)(6916009)(54906003)(356005)(81166007)(40460700003)(82740400003)(8676002)(83380400001)(316002)(36756003)(4326008)(8936002)(2906002)(47076005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:46.7218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c89ed4f-7b91-4f55-394f-08dbfd870024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7715
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
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
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c          |  3 +++
 3 files changed, 19 insertions(+)

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
index 02fa481d7457..c9fd5b2a3330 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -24,6 +24,7 @@
 #include "kfd_priv.h"
 #include "amdgpu_amdkfd.h"
 #include "kfd_pc_sampling.h"
+#include "kfd_device_queue_manager.h"
 
 struct supported_pc_sample_info {
 	uint32_t ip_version;
@@ -105,6 +106,8 @@ static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
 	if (pc_sampling_stop) {
 		kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
 			pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, false);
+		remap_queue(pdd->dev->dqm,
+			KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
 
 		mutex_lock(&pdd->dev->pcs_data.mutex);
 		pdd->dev->pcs_data.hosttrap_entry.base.target_simd = 0;
-- 
2.25.1

