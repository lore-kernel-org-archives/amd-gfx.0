Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1359C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 11:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4265310F612;
	Thu, 16 Dec 2021 11:35:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88C7110F5F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 11:35:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOozD7F0qSXuOouxkblRoCHOLPC/JnGWooDCwUCCpHA4PvjBBQRrFBE4LPptRM0vWCSZe3sfr/Fg1kaIfYMq2EqHmHdjaT5NkzfNAli532uijwxvObr4TYLrGZsPAisy5o0MGIjrTUnprGOKUuDBOXVg84xdayde93g6DsYVpXTuYnZ5uXy2ijZHQWuiO4bYLBRtzWAPdP9P++D3XJYf7vZTsjbUUWOzG0x9MvyscE/MiJZGIk599FU7e+7EV7DtHaq/y3B2APuXbWmz6vmSEPZFSHcqylBaznuGV0F6mNbmDoPPAaG5RnWxZ7KGRIo5+B6IFPnxay4FLn9IXz3axQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Asl5J/t7/vXR70ElbQ978Eh/4niuI30yen34uC50g4=;
 b=Bde3+ZrCSOLLe7ftAwTlyy9+Rmgcjc6SkgyJ+Lc2hHkfpZ0yOYTclnjB1+jdF7+OV/ZSarh2rdP9S0zH33fmxYQ0bNisZMNHI1wfAgJw9MFGffKWQf1ckr21KwohwhlAz0BqThiNDM/cnRMCeGhTYLBUXrvnmrocRgYdbMV+oaM2U4Tlw5AxMOfRqcOP4eTGI8vv0y+CtwkqLacubPGKSI9wK9OgA9rwsYco3grZ4Dd600lPPGbfa8ew9w0kB8buyxKnDoi2WlbPMXJ8/TnHHiklwNsxWOEqcj0pkEQek02s3Qp8+qv0ppU2tGDMEUg2kWQ5tI9277C76LyjSGcuVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Asl5J/t7/vXR70ElbQ978Eh/4niuI30yen34uC50g4=;
 b=3LvcOECCrvYIZTC7RpNW94O/Au0crSxE7rxEZvLjJHmqJbfCY+WksAP4iiQwn9tAGvCyZwAn4FSdlS0RO8HS6iDa0OeZo9eJry25/TDNVggLEJGXalZrUTpkkq2/bkFMn2l4YJRE7MPv5LduTaiJZ6RTWHrVVxSXj2hkmsidKB4=
Received: from DM5PR1101CA0006.namprd11.prod.outlook.com (2603:10b6:4:4c::16)
 by BN8PR12MB3428.namprd12.prod.outlook.com (2603:10b6:408:47::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 11:35:51 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::22) by DM5PR1101CA0006.outlook.office365.com
 (2603:10b6:4:4c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15 via Frontend
 Transport; Thu, 16 Dec 2021 11:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 11:35:50 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 05:35:48 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <Felix.Kuehling@amd.com>
Subject: [PATCH 4/4] drm/amdkfd: reset queue which consumes RAS poison (v2)
Date: Thu, 16 Dec 2021 19:35:32 +0800
Message-ID: <20211216113532.12369-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216113532.12369-1-tao.zhou1@amd.com>
References: <20211216113532.12369-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42b5fde5-4a48-4963-d505-08d9c0883666
X-MS-TrafficTypeDiagnostic: BN8PR12MB3428:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3428597B7F5E02CF5DE5A18BB0779@BN8PR12MB3428.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Od5OzvRmqCMdK6jgQSmP1xvnNxjdKeIYvJ+zR2N+NSiUzbMYWUp5mFet75PH3vJRKRMLZYfODzMox+FWmXnMLhCMiOUpSwLVpg5XCp4MIntsZJ6hs3WtE07Le/TuDEtWASHfWB6NF8wcpXI5HP9VFRsyO6N5ughITq49Csu4suP5QXnifq/ZTGrwM81ks3JUWL99Bmtdv4DiU5W9tGqRIKfNRbrrCHQc2KoBG+r+cfojf+g+5J6TyKr1cfGhaekm8dVKf8DcMwPeiGcLTnsvHNq11FayiiCfvBeic3TLgAlolp766yQ/TyUhcncRsseKqWn8isRekrAmBS2bPYQ8JhVax+PRCCSX+SfPfYcnptvqk8LUxyMlm8XFoO+atUzG+i0njvA4pyUayvOEMypb4CMSSz4HKwLyS93JmYJh9iOrqzVzOtanhbauJzTP+3r97tSP3iDf9zo0ieqrc57nExD/6MYOs3H4jQyzHa8RTSxnlxKsZ8kfCEBO+zPvdVWN2qIIfV2MKfeny0NKFVdoSlTp6jn+lHw4LY+nCcKMRTkskMTjEuyD/8ejYd23FnhXjJfRbj+9/MEp6uTzz14Q+gAu574RFrg9bpQV9TrKwUxMBSS9dJotXwYpOF237gzylVqgejW524FC2hmEEw2lSTd08xH0xYVIP9SmNw0VYR+Pg5cGiGEGvwUPI07igVzZUBauLSzlan6pUDNsY7B40nKv0FsoWI8ZEG0a003FnI2DFDiYYkotp/N6cPCyCaNiJ56I0vJwqc9Ff4zJstM2zclhCNXjDs8d/89eI5S82iE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(86362001)(40460700001)(83380400001)(356005)(426003)(36860700001)(16526019)(186003)(508600001)(336012)(316002)(82310400004)(70586007)(70206006)(81166007)(8676002)(2616005)(26005)(6636002)(5660300002)(1076003)(4326008)(2906002)(7696005)(36756003)(8936002)(6666004)(110136005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 11:35:50.9566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b5fde5-4a48-4963-d505-08d9c0883666
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3428
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CP supports unmap queue with reset mode which only destroys specific queue without affecting others.
Replacing whole gpu reset with reset queue mode for RAS poison consumption
saves much time, and we can also fallback to gpu reset solution if reset
queue fails.

v2: Return directly if process is NULL;
    Reset queue solution is not applicable to SDMA, fallback to legacy
way.
    call kfd_unref_process after lookup process.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  3 +-
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 44 +++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 46cf48b3904a..0bf09a94d944 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -721,13 +721,13 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev)
 	return adev->have_atomics_support;
 }
 
-void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev)
+void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev, bool reset)
 {
 	struct ras_err_data err_data = {0, 0, 0, NULL};
 
 	/* CPU MCA will handle page retirement if connected_to_cpu is 1 */
 	if (!adev->gmc.xgmi.connected_to_cpu)
-		amdgpu_umc_process_ras_data_cb(adev, &err_data, NULL);
-	else
+		amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset);
+	else if (reset)
 		amdgpu_amdkfd_gpu_reset(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index fcbc8a9c9e06..61f899e54fd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -296,7 +296,8 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
 				      uint64_t *mmap_offset);
 int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
 				struct tile_config *config);
-void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev);
+void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,
+				bool reset);
 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index deb64168c9e8..bd29b50532ea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -89,6 +89,44 @@ enum SQ_INTERRUPT_ERROR_TYPE {
 #define KFD_SQ_INT_DATA__ERR_TYPE_MASK 0xF00000
 #define KFD_SQ_INT_DATA__ERR_TYPE__SHIFT 20
 
+static void event_interrupt_poison_consumption(struct kfd_dev *dev,
+				uint16_t pasid, uint16_t source_id)
+{
+	int ret = -EINVAL;
+	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
+
+	if (!p)
+		return;
+
+	/* all queues of a process will be unmapped in one time */
+	if (atomic_read(&p->poison)) {
+		kfd_unref_process(p);
+		return;
+	}
+
+	atomic_set(&p->poison, 1);
+	kfd_unref_process(p);
+
+	switch (source_id) {
+	case SOC15_INTSRC_SQ_INTERRUPT_MSG:
+		if (dev->dqm->ops.unmap_queues_cpsch_poison)
+			ret = dev->dqm->ops.unmap_queues_cpsch_poison(dev->dqm, pasid);
+		break;
+	case SOC15_INTSRC_SDMA_ECC:
+	default:
+		break;
+	}
+
+	kfd_signal_poison_consumed_event(dev, pasid);
+
+	/* resetting queue passes, do page retirement without gpu reset
+	   resetting queue fails, fallback to gpu reset solution */
+	if (!ret)
+		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, false);
+	else
+		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, true);
+}
+
 static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 					const uint32_t *ih_ring_entry,
 					uint32_t *patched_ihre,
@@ -230,8 +268,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 					sq_intr_err);
 				if (sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
 					sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
-					kfd_signal_poison_consumed_event(dev, pasid);
-					amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev);
+					event_interrupt_poison_consumption(dev, pasid, source_id);
 					return;
 				}
 				break;
@@ -252,8 +289,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 		if (source_id == SOC15_INTSRC_SDMA_TRAP) {
 			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
 		} else if (source_id == SOC15_INTSRC_SDMA_ECC) {
-			kfd_signal_poison_consumed_event(dev, pasid);
-			amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev);
+			event_interrupt_poison_consumption(dev, pasid, source_id);
 			return;
 		}
 	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 0c3f911e3bf4..ea68f3b3a4e9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -856,6 +856,8 @@ struct kfd_process {
 	struct svm_range_list svms;
 
 	bool xnack_enabled;
+
+	atomic_t poison;
 };
 
 #define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
-- 
2.17.1

