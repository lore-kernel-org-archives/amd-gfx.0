Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2085C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 19:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E27510E607;
	Wed, 25 May 2022 19:05:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EFDB10E3C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 19:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiR3dmd2dNOtG0H7akXMQ6FdW72SPRmQ0o4fX5kPNqTehTiF4rB3JesqCQHzCJ32f1ePMKQH/9svxPkakkPjcQ5tY1LA4jqxVZY3AayKa7PNxnvz6oaznWFKVUgE+FwJZVyD8oTez9V78VFr2TBcYi9wdxENFO6iAXCY67HIRnVIUE7Hf0OHWY719Prsqcb2QR0WNNtApwvE2fEFPeaz5H30EvI8wnUIg1wXV3BDR1uAuO46gn8NBbcN708G3hetX1EAEIMeDmKoC4/JzJjMiieUAebFoKQZXeP0vCXmaHQ2EBuGH67oN51ngQqD0ObsgzDtiTkgf2orgUB0IF3lNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oy9He+Li39cVsdWEvmILtEeUeUzRJKUyfDMfEioFIdw=;
 b=Stbz3eqwiwBNdj8ZGzANPGGjbB3EH4ICIfdpFPhpBEI7/Hun7acbxLtlhlQuiTRDjDE+txRshV+s4fz1sVZnRntxDdAXT5Z/VBgTjXDo9KuFNwaeQbQpLpqHF8J0HjrEMueI40SWrgJLd2+rd/Etvut2hfUEcIre616XQpjfwXxhXZlCLR3k7rFh8QepO5nqjhDHIFb4oyoHvDe6y5CcJ0ttpPvXVviy2kRYcPwlOABCGOyEHeoIYD9yWksFUMcgMMeuArGMTtSZY0Y5Lybl88AzLDopDqxBeqbCqpLMRiYRMIVTpRhdQxuT8iZZj1fe65rqgqRmQzrHNttXBE5AnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy9He+Li39cVsdWEvmILtEeUeUzRJKUyfDMfEioFIdw=;
 b=Xx7tTS0wR4hg2tXS8J/qu4TrRq4roXTy6Kz/cIfkb7GaAify2tAtFx+WShH8P//dr9dqwYE4w5uK4JNnLuJE0eGs3LQugyuUnioeQb8OesfxjStbBXjDna/yAsiPpxKLLodkcKas7M9EYAahshMssCDDXyobRzhwWd+I/GiNT2s=
Received: from BN6PR19CA0075.namprd19.prod.outlook.com (2603:10b6:404:133::13)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.15; Wed, 25 May 2022 19:05:18 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::3b) by BN6PR19CA0075.outlook.office365.com
 (2603:10b6:404:133::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 19:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 19:05:18 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 14:05:17 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 6/7] drm/amdgpu: Rename amdgpu_device_gpu_recover_imp back
 to amdgpu_device_gpu_recover
Date: Wed, 25 May 2022 15:04:46 -0400
Message-ID: <20220525190447.239867-7-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
References: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcb273f6-6889-4a57-80c6-08da3e81824c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB13550D5DE7058B0EE2E78395EAD69@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UIm/9WH2naxruY+P+QTdDmZmO78Hvsr1WFoKUP5l2jKODxIMt97khN7Gyls3Smf+OghKDTHMZdLG+s4UcFt3HwlTBdkkaTEY4HXm6B8fDZCtzChk40jPu+4fmPDsSR4ouXDEV06EZFhdUhn1Iv8LlJaPPp9Fr6o9mk9IqfGfJbxYHpH1K/+rIVmT4ov9jRivzQgVSgjsn+TXatITBtbrKSe8z7p7cItSO7VrPsJNwCkpgI0OAeggYHwuQ9QuCwhsHuYYXcoQ2u8DshzOCmJE6FJCr9MyfST4hkvB58piq0wxOvs6+QKPcrTdL1HiMr/bZO83nH2AQmOY6mt4ssmPwDXTlTkLsblTquvFNBn+VTEbOkn6kOO7XsWqYgAVF1lpqhb0aehcbOYwnu0kK5BlekY7ya+4Z15/SadrXuMmbxhEsFNR1ZeUmMV7EjVT1MkZpMhni6dazzfkBb8Ja+RnQpLOMpGPzYe4H79vJHfXOteVw2SCcO3GLWBTIuZxKweAcJ5dlU31GMZUav/FGWDACG4CPiA/LJES1nW4/9VRwnr1fcNLFXwKCslW6ql25ruOQncLfJT7HF2CLyUUsboF96ENFQKLNny8SWPH9JItFf4i37ii+W6f12nQJ8HqIlq9lCre+Fxu4mR6sb1XfOr/8ffEF37y0mySZnTTAvDGWF6kiptpzEfCtyOBEwG9ibtYgt1ets/w0usTGddDoJ7C8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(336012)(6916009)(70206006)(70586007)(508600001)(316002)(82310400005)(4326008)(44832011)(5660300002)(2906002)(86362001)(26005)(2616005)(8676002)(36756003)(81166007)(356005)(36860700001)(16526019)(83380400001)(186003)(426003)(8936002)(7696005)(6666004)(1076003)(47076005)(40460700003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 19:05:18.3476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb273f6-6889-4a57-80c6-08da3e81824c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
Cc: Zoy.Bai@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 lijo.lazar@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We removed the wrapper that was queueing the recover function
into reset domain queue who was using this name.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8165ee5b0457..664ed0a6deab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1244,7 +1244,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
 bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
 int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			      struct amdgpu_job* job);
-int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
+int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			      struct amdgpu_job *job);
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index a23abc0e86e7..513c57f839d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -129,7 +129,7 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
 	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
 						  kfd.reset_work);
 
-	amdgpu_device_gpu_recover_imp(adev, NULL);
+	amdgpu_device_gpu_recover(adev, NULL);
 }
 
 void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e3e2a5d17cc2..424571e46cf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5065,7 +5065,7 @@ static void amdgpu_device_recheck_guilty_jobs(
  * Returns 0 for success or an error on failure.
  */
 
-int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
+int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			      struct amdgpu_job *job)
 {
 	struct list_head device_list, *device_list_handle =  NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index b0498ffcf7c3..957437a5558c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -819,7 +819,7 @@ static void amdgpu_debugfs_reset_work(struct work_struct *work)
 	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
 						  reset_work);
 
-	amdgpu_device_gpu_recover_imp(adev, NULL);
+	amdgpu_device_gpu_recover(adev, NULL);
 }
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index dfe7f2b8f0aa..10aa073600d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -64,7 +64,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
 
 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
-		r = amdgpu_device_gpu_recover_imp(ring->adev, job);
+		r = amdgpu_device_gpu_recover(ring->adev, job);
 		if (r)
 			DRM_ERROR("GPU Recovery Failed: %d\n", r);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a439c04223b5..bc0049308207 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1922,7 +1922,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	}
 
 	if (amdgpu_device_should_recover_gpu(ras->adev))
-		amdgpu_device_gpu_recover_imp(ras->adev, NULL);
+		amdgpu_device_gpu_recover(ras->adev, NULL);
 	atomic_set(&ras->in_recovery, 0);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index b81acf59870c..7ec5b5cf4bb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -284,7 +284,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	if (amdgpu_device_should_recover_gpu(adev)
 		&& (!amdgpu_device_has_job_running(adev) ||
 		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT))
-		amdgpu_device_gpu_recover_imp(adev, NULL);
+		amdgpu_device_gpu_recover(adev, NULL);
 }
 
 static int xgpu_ai_set_mailbox_rcv_irq(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 22c10b97ea81..e18b75c8fde6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -311,7 +311,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->video_timeout == MAX_SCHEDULE_TIMEOUT))
-		amdgpu_device_gpu_recover_imp(adev, NULL);
+		amdgpu_device_gpu_recover(adev, NULL);
 }
 
 static int xgpu_nv_set_mailbox_rcv_irq(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index 7b63d30b9b79..c5016a926331 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -523,7 +523,7 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
 
 	/* Trigger recovery due to world switch failure */
 	if (amdgpu_device_should_recover_gpu(adev))
-		amdgpu_device_gpu_recover_imp(adev, NULL);
+		amdgpu_device_gpu_recover(adev, NULL);
 }
 
 static int xgpu_vi_set_mailbox_rcv_irq(struct amdgpu_device *adev,
-- 
2.25.1

