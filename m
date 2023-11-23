Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95330C5AD4C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 06:20:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05DAA10E6D0;
	Thu, 23 Nov 2023 06:20:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37CD210E6CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 06:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1pTY/5VLHRLXGZJbusSlMC0+YTZ0sFuy+YcWdi0f+SX7lb2DDx6cXhX5lNyArhvpq2AkOt+NLb2YUfUKJh+ZXZcQlebTPhdnBx4IYbSwDznKEkx5/WhqUp1rc+O7zcorSnkhUy/kqTAmOGZM3s1f+6w8OQIXIJI8cs01wkWcaXwBqz0hKtMoSnXL6tA0yGLcwAalO/SYG+FMGGnuPSqrYRIxwgBMoabdMhQOQuvjsKkH5Rd//QjhBThYeSgWtnvKwrzCpZDlmyk8wqJ3EdxqFMxqM5StSdLkfVrAYB/9vAyy6Y3leNW+k9jhSmvfY6Ft1J8IMeaYEuc0L/EXpU7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYGaQgbAPL1G0P8Le1rRDc+D7l5xCzNUfvDUb4x7tmY=;
 b=dPhqvJVvqZ0/liOtJw45YT0KsstG19tiscFdlcB8DbAUqW1qaJp024w3EToD1AIwqShS8ZIdvV7Q1suS0d4WmohUtr/wVCmeUvZJm7pHBatMIJyvKhpTsDbuMRgOTK1clAEYbYdK4g5dzBHOtK1M8umE8a8t8d1wcfYa1k5Gm83lIZb19dYuMMj1jwXH9MhqBcqStwxtgrly0KEVSpBAwRxzyFElIgS87yaFOwjRbXWnw/txgl9PJ+l89ocxRK36dF1BQw/g0GB619pDOK5DukY4dwXUlpO+jtTjtGczcbs6SJSWxujvcFyxhhPkVzCgxxs8YZzzloHsGrqUDhmBWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYGaQgbAPL1G0P8Le1rRDc+D7l5xCzNUfvDUb4x7tmY=;
 b=mPm6sa/JM1umehehiJwRkds4f7u5szvrti1CjAriaaQrJschwcO2kAJkEYGz1o2LhIPRq+5XE6CXFJDYFeE9JlVT+rXogwjqPST9wGt8nIAAci4NP6nG8gvUjl9C7Pn3UxQb5Fqv4CuEIUxUmbCR/zRC7G0PumFlc/hp+t1+lVs=
Received: from DS7PR05CA0083.namprd05.prod.outlook.com (2603:10b6:8:57::29) by
 PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.20; Thu, 23 Nov 2023 06:20:22 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::2f) by DS7PR05CA0083.outlook.office365.com
 (2603:10b6:8:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.13 via Frontend
 Transport; Thu, 23 Nov 2023 06:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Thu, 23 Nov 2023 06:20:21 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 23 Nov
 2023 00:20:10 -0600
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdkfd: Free gang_ctx_bo and wptr_bo in pqm_uninit
Date: Thu, 23 Nov 2023 14:20:01 +0800
Message-ID: <20231123062001.231761-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 434aff64-4c9c-45a6-8802-08dbebec459b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SS3uxRNmqmyG34/8vVZ+VT+OwjngnRXnZ1BPQNOmb6A3Bm11aTjQFn7YNb20YSC3GmnzVIHPuQGWoEz5VtJC8fYjgFOT5rbYQoOq6uTcbF05i7vgEQRFbt51XifmRMFt3cBaZ9otUGE31Ce6FqMniGQB1ma/HfGiLYpZHv8kheiMXvRm8Dz1G3JAyN3x6AtJ0G022CU9H4sa8NvfdoTTseyYdoS0yzPA/vUgehV/z+6JLyiG4eEzqiOWrNOPmicDvrL0Hso5cHuUMVLS0lV7x4gcfKNY3Zp0IxQt3WjfDSh1IzbKzlfgJX/T0CROcZ6U1hvE0fvJIkpA/FoQHoQmIBfZZcIwXEJIJWtxopqND99lBlZc9Jn/ccjcmrz5CakhhkzV+dMvyO34IABTr1yrPuZMcMv16w/qjCKlkaer4DWCE309CiGL6FPSLSOy2Ye2gqAVuJ1cu4aluGy04ENV/idE7B+Bi6Olpkt0rLDKLl3l/V120kzUDfK+5xpw9dwjhe5GVcXmJvzcHW0A40m1Xc2tkqMFzrJaplLMroiLcpfn/PHCh5N1I1s9/1jwF9X804vq+ipG1NhRrfcx4ShXrhhj3OGwbXgX3J5cVvxBVSerIGpkKEAok6KIemQI9kDDd0+Bh/O8BSk3xBCxhddH81XDb7xOgV8e5SNIAxCxgoZTvQJ2FOfYKFBXC3xTOFfy65sGJQ+yL3Pc5E/cSQ/2nK6z6YACxjCSJcXRSJS149ZEVBkX3E6VWdF9q3HHiWg6PMeW7HknxAvZ5HOJ3gbtqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(40470700004)(46966006)(36840700001)(2906002)(41300700001)(8676002)(8936002)(4326008)(40480700001)(5660300002)(6916009)(316002)(54906003)(70206006)(70586007)(40460700003)(47076005)(86362001)(1076003)(2616005)(478600001)(7696005)(36756003)(26005)(6666004)(426003)(336012)(16526019)(356005)(81166007)(83380400001)(36860700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 06:20:21.4905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 434aff64-4c9c-45a6-8802-08dbebec459b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128
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
Cc: ZhenGuo Yin <zhenguo.yin@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Memory leaks of gang_ctx_bo and wptr_bo.

[How]
Free gang_ctx_bo and wptr_bo in pqm_uninit.

v2: add a common function pqm_clean_queue_resource to
free queue's resources.
v3: reset pdd->pqd.num_gws when destorying GWS queue.

Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 .../amd/amdkfd/kfd_process_queue_manager.c    | 54 +++++++++++--------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index ebaec476f49a..fb5840a5df06 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -169,16 +169,43 @@ int pqm_init(struct process_queue_manager *pqm, struct kfd_process *p)
 	return 0;
 }
 
+static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
+				     struct process_queue_node *pqn)
+{
+	struct kfd_node *dev;
+	struct kfd_process_device *pdd;
+
+	dev = pqn->q->device;
+
+	pdd = kfd_get_process_device_data(dev, pqm->process);
+	if (!pdd) {
+		pr_err("Process device data doesn't exist\n");
+		return;
+	}
+
+	if (pqn->q->gws) {
+		if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
+		    !dev->kfd->shared_resources.enable_mes)
+			amdgpu_amdkfd_remove_gws_from_process(
+				pqm->process->kgd_process_info, pqn->q->gws);
+				pdd->qpd.num_gws = 0;
+	}
+
+	if (dev->kfd->shared_resources.enable_mes) {
+		amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->gang_ctx_bo);
+		if (pqn->q->wptr_bo)
+			amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
+	}
+}
+
 void pqm_uninit(struct process_queue_manager *pqm)
 {
 	struct process_queue_node *pqn, *next;
 
 	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
-		if (pqn->q && pqn->q->gws &&
-		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
-		    !pqn->q->device->kfd->shared_resources.enable_mes)
-			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
-				pqn->q->gws);
+		if (pqn->q)
+			pqm_clean_queue_resource(pqm, pqn);
+
 		kfd_procfs_del_queue(pqn->q);
 		uninit_queue(pqn->q);
 		list_del(&pqn->process_queue_list);
@@ -465,22 +492,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 				goto err_destroy_queue;
 		}
 
-		if (pqn->q->gws) {
-			if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
-			    !dev->kfd->shared_resources.enable_mes)
-				amdgpu_amdkfd_remove_gws_from_process(
-						pqm->process->kgd_process_info,
-						pqn->q->gws);
-			pdd->qpd.num_gws = 0;
-		}
-
-		if (dev->kfd->shared_resources.enable_mes) {
-			amdgpu_amdkfd_free_gtt_mem(dev->adev,
-						   pqn->q->gang_ctx_bo);
-			if (pqn->q->wptr_bo)
-				amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
-
-		}
+		pqm_clean_queue_resource(pqm, pqn);
 		uninit_queue(pqn->q);
 	}
 
-- 
2.35.1

