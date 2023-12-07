Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF0FC10F04
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F30CD10E9AA;
	Thu,  7 Dec 2023 22:54:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0028310E227
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYPjCpEBvEYB8e+QLLFKSe00c1RNsfs5/QqPutAQ7c9BSYmnqDs6Uk5igZk6KFMoSSvA0M54QTteMCpRS/x8o6O/wHkbtMr5w4fIfj0L86c0ioAtWO6ZN7Ld18goPVRDLRKyDb4t4XFShclZMEZMWgCNEJ8qmJ2RKOv0kqIQJvLVmNCglhhlGx6NUPZoZast9PaqxZrQRoro7JCn7KyeU7okxp3O4EZT0d+pkYnPIiFy1cq+1N3ZqwWeVZpMFmXuIEiQKi2xgxfs5PNneZuf0OzRjHPP3D1faKSdkJqoUoqmt2ohmfAlDM8iEEd+tgjWAlgemD6VQmqEPfPsIEYliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpbV+3FF2NgHKTFlqFSytrBK+JtyhSq6jGN5nlhQiVQ=;
 b=AqOZaQYD4fuwhTdbwaFwNsMk0lj2wmAN3BPNJSX0nNurESf359Px0Z35WDOdSdj4uAm8IxGPY7A4T1zMIadITOovZqNOM9UxLdaFdHYvrzwZPfsA0B6XMUZ5T7xmatRtC2Uv/GyG3Vu96h27Mq2HEpTyCr4hpb9zjV5yh1eQbJUmXdgptfzvgW+NQrvBd819biceVe6BP1K3Oglt/qZHSFUTrKkZ8TiwlKkxXhYyAADqqqytKnWEjZlczd1hNepU2Hf7prLDa+v2WhZa6afszvgtTHqgzpGqL0eIjDY2iZcB8do6dnb2DEN1Xk4GQMmqGyF8gO05KD/PNq/JhNzTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpbV+3FF2NgHKTFlqFSytrBK+JtyhSq6jGN5nlhQiVQ=;
 b=IktQDZinMMyGvEkE9Z3cKFIq+FsF8zAM5ukOZ3GIq8iff1UMl1wYtMvtCeE9brH4aGTZxyYbHRIqlwUqFjwYdQaSKSZvupM3NLCFVAHsNdjcUA758IqzYwKlLNOVCvxBdqKfuN31/hXXfXiRjWn1NJVOvqh6ScePJoBs/X0h8tk=
Received: from CH2PR20CA0025.namprd20.prod.outlook.com (2603:10b6:610:58::35)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 22:54:47 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::ce) by CH2PR20CA0025.outlook.office365.com
 (2603:10b6:610:58::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.26 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:47 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:45 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 19/23] drm/amdkfd: add queue remapping
Date: Thu, 7 Dec 2023 17:54:18 -0500
Message-ID: <20231207225422.4057292-20-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207225422.4057292-1-James.Zhu@amd.com>
References: <20231207225422.4057292-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: f61bf696-c1a4-40eb-68a0-08dbf77782e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7OsCYGflC88BAge81JHQkjz5l1wh8HR7oJMD4ZJd/zqFZva4RzOqAG1amIXsNgiDwTYMDwuopToarvBHXg7hhoSNo5T9NhGDdD49NfURLrQba84MKT/+isSuYmat31lQe7nclvKqdjkoaVg0G5AxIrwKFWGoC1BUE4aJu+pCZP8sk9UstP5YKzQzkVjZ5d2Md/UZH+3odxFc0W4nc90IgjSY9rloHlbDDjz/VfNQ1/eLWCMvgoq5xsmRfWjEShJ+Is1aYkgQWTKUeh/wDX5vWUMy6y08WD54FENmRDEbximGPUH5AeQYJ54TohchzxwbMisGPrzWR7xFWoiglEcJeQf/ObCVTpGHPDy9jt3XEtUL0JQUjDQcOCIlByEnWDJCog828akHM9qa1akJxrNpFmezftLPBMYewBFqMQxkRQB6T6eiDFdgU70BnAEgU3WQMl2/k2ZmbSWqP58nnIB8ROwzqUWa7q1pXlz9+ntsl1mOn7EBEoZhsxQbBhjhFmzLlaL0P1R0xpWL8+q5V3ryJz28x8NG6g/vPwo4NRj73gqSCAdgMbS8UOz5wtRxNNsaLeLmmtrEoatfZ56JsE/Y6t7iJX9HNcamE6qgSOtMRy7IcXbIKYBn5usV36GAgnRPNAVSBCmLoebRqot9dCaWAuzUiThJPht5x3NhrgwI0Sh0RlxAHVJJAtKab//FQZgajO/xTxFjR1TA5uzLyGxfGpkkEaQ9d3WMNmEdNu+GOQiBkLtimckGU0YCmcXSkm9F1CI0pUJOGaapMC3Z7WDFVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(81166007)(82740400003)(356005)(2906002)(16526019)(26005)(336012)(83380400001)(426003)(40480700001)(40460700003)(47076005)(86362001)(36860700001)(1076003)(5660300002)(478600001)(54906003)(7696005)(316002)(36756003)(6666004)(8936002)(8676002)(4326008)(41300700001)(6916009)(70586007)(70206006)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:47.1714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f61bf696-c1a4-40eb-68a0-08dbf77782e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488
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
index 29a6f9f40f83..7d0722498bf5 100644
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

