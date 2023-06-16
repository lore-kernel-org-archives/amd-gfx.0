Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB96EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 18:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94BC610E678;
	Fri, 16 Jun 2023 18:44:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46B3210E678
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 18:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRyZq1ZG3kuhKc1gLwXIGP6sB3TWDU1q48wDv8h1ioUygj6KLQROMOQgumeY3ztnQ3muqDL5peV3/O0+xi1UP3S6vYZjvj0s9A89gDHX3q5ORKRf66pasgManFklYXLwww0pL9AAQ82ahUFA6HZV7XSLyZBQZGGaSqwJ9MTw/lQCdB6qUF7BEndDbmR32HD68tyZnxoBzfm18y63unQklMZstDcBuuXaUYWF9iAUOwjN4XrPkx4fDbDcqnTV73qKfVs3WbrNRfwTaA4DjGzSP8g64av6PMmaDnyL7aZqblsZFQ9N7oD7oWXSV+GsNyerTH5307JNB4VPc3AGF54ufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGM6fBFN+Mnop+fMZcFbPNtQ88kVFWipNQhwjAEnOL0=;
 b=StNY0p4bIUWX22LGyvJj4pky59E/R9BOebZcP2ro6TuhPEV+fcTJbMU3UOeS5Q/PJcpOQ0VzaK3/DJJ/VmU8lThVm3wBmGMbcQWjSNo88dOGvCmNrnoFqgVeOXwdJ2Q/o7f6yKcq3sZOroaDT1WepfHeXBmudKQ/YFNPKa71Ior7WILggFU0oJyWykESLMAXYklJ8m0WntI5SSl/cYyjfYD12WVMaBFyauv+wmDQ7Qab/f9AjxvanYwg1Cq55tj5p7xi4foOePvWhZy2YvQjB6tQWg7qoryZ20mvbrqG9z541EwgRBNVaRc9aMfop31kspbyavDtSFNEi+OZLiQrPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGM6fBFN+Mnop+fMZcFbPNtQ88kVFWipNQhwjAEnOL0=;
 b=D1+PZ3fCwkyVfxFfw1zW5yX3UdT8ZGIsNJxrTkhT/12ibps9R6iZDqodRuE4bXd9qpTo3khln/92S6O32MP/RbTXvS8+vMOElujXjC7a54QmfAAzw8j5RavIjYlPQgnQ/d3YSx57Peb5Yfk3GGXU877Fs6jGimZTqEhHrdoB1WM=
Received: from DS7PR07CA0014.namprd07.prod.outlook.com (2603:10b6:5:3af::17)
 by SJ2PR12MB8944.namprd12.prod.outlook.com (2603:10b6:a03:53e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 18:44:21 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::f4) by DS7PR07CA0014.outlook.office365.com
 (2603:10b6:5:3af::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29 via Frontend
 Transport; Fri, 16 Jun 2023 18:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Fri, 16 Jun 2023 18:44:19 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 13:44:18 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCHv2] drm/amdkfd: Enable GWS on GFX9.4.3
Date: Fri, 16 Jun 2023 14:44:06 -0400
Message-ID: <20230616184406.1272146-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SJ2PR12MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6d371b-0153-4540-506c-08db6e99b194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ly8owvFOt0pSAdwPEk8Y7luEWDyQnX6lXu31w039eNQ+ow8Zh6/T7bFukT8LIHg9u2NU3003G6GNHtGMP6PUxmtSK1zpoQbNZqYZFmsvuOCJY4G/WToFSsP4/jH68DQ6wI09tnwH8o+yj8WsiHEi94M0BIx+iPFBgIHaN+JBAXRb4x4gjPhaDEP7rGKHkInr+jqtJEer7u8/IqGi/k3wqtck6CxbXlXq5+EWf9kRPWdyiW7LmX6RyK+nDAKzkVl4lzjhjxwlnZWbFaBO+rpZPz6Poj1X58FuRXc5a9E+5tXOnWZnqpuwrg0Y/3QQDCNcgLpzTG4sexL1ec8cJSvIu3lrCLbyULVqe5uZHGnTrZz67KivMg1l8abRcobp4wOzgoJW7eZ7p9pXm0xpCZJj9xxArwANS32/7reF8EZdbpy7B/nuS3FMdXKozidgyfsRJYBQKJfg1ILkHOJDfG04VLPr76CPvfeoDMTR29cFmBy0aSK5+ZmObg3XRHntw3cKAHd0six3c5Rht8liFD8mX7NcpW5KvD8V/RSS1TdpOfympYmt+w5bgeoiFew633HLYd1GNiGeCz3VGUrWtJ4kfpuiUvcQL1k157pZSYIFkAUTIRajzH84nUNQ8y1qse8FlKxFxP/A/QMfNWVU85Doqk2QiL237JasDrAjzzZDjbL0DLaLn9OmixfE0nFk2S3t6Zc6p412l4wW9MWKa5upUMJgKrVQeMAnchhkcrTVSia4uBkke+SLmoKUVcQL2vOIEGHfRPhK7vW35rgKLEhztQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(186003)(16526019)(2906002)(82740400003)(40460700003)(82310400005)(44832011)(86362001)(336012)(426003)(1076003)(26005)(83380400001)(40480700001)(2616005)(36860700001)(81166007)(356005)(47076005)(36756003)(4326008)(316002)(6666004)(70586007)(70206006)(6916009)(7696005)(478600001)(41300700001)(54906003)(5660300002)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 18:44:19.0458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6d371b-0153-4540-506c-08db6e99b194
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8944
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable GWS capable queue creation for forward
progress gaurantee on GFX 9.4.3.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Update the condition for setting pqn->q->gws
  for GFX 9.4.3.
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  1 +
 .../amd/amdkfd/kfd_process_queue_manager.c    | 35 ++++++++++++-------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9d4abfd8b55e..226d2dd7fa49 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -518,6 +518,7 @@ static int kfd_gws_init(struct kfd_node *node)
 			&& kfd->mec2_fw_version >= 0x30)   ||
 		(KFD_GC_VERSION(node) == IP_VERSION(9, 4, 2)
 			&& kfd->mec2_fw_version >= 0x28) ||
+		(KFD_GC_VERSION(node) == IP_VERSION(9, 4, 3)) ||
 		(KFD_GC_VERSION(node) >= IP_VERSION(10, 3, 0)
 			&& KFD_GC_VERSION(node) < IP_VERSION(11, 0, 0)
 			&& kfd->mec2_fw_version >= 0x6b))))
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 9ad1a2186a24..ba9d69054119 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -123,16 +123,24 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 	if (!gws && pdd->qpd.num_gws == 0)
 		return -EINVAL;
 
-	if (gws)
-		ret = amdgpu_amdkfd_add_gws_to_process(pdd->process->kgd_process_info,
-			gws, &mem);
-	else
-		ret = amdgpu_amdkfd_remove_gws_from_process(pdd->process->kgd_process_info,
-			pqn->q->gws);
-	if (unlikely(ret))
-		return ret;
+	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3)) {
+		if (gws)
+			ret = amdgpu_amdkfd_add_gws_to_process(pdd->process->kgd_process_info,
+				gws, &mem);
+		else
+			ret = amdgpu_amdkfd_remove_gws_from_process(pdd->process->kgd_process_info,
+				pqn->q->gws);
+		if (unlikely(ret))
+			return ret;
+		pqn->q->gws = mem;
+	} else {
+		/*
+		 * Intentionally set GWS to a non-NULL value
+		 * for GFX 9.4.3.
+		 */
+		pqn->q->gws = gws ? ERR_PTR(-ENOMEM) : NULL;
+	}
 
-	pqn->q->gws = mem;
 	pdd->qpd.num_gws = gws ? dev->adev->gds.gws_size : 0;
 
 	return pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
@@ -164,7 +172,8 @@ void pqm_uninit(struct process_queue_manager *pqm)
 	struct process_queue_node *pqn, *next;
 
 	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
-		if (pqn->q && pqn->q->gws)
+		if (pqn->q && pqn->q->gws &&
+		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3))
 			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
 				pqn->q->gws);
 		kfd_procfs_del_queue(pqn->q);
@@ -446,8 +455,10 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 		}
 
 		if (pqn->q->gws) {
-			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
-				pqn->q->gws);
+			if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3))
+				amdgpu_amdkfd_remove_gws_from_process(
+						pqm->process->kgd_process_info,
+						pqn->q->gws);
 			pdd->qpd.num_gws = 0;
 		}
 
-- 
2.35.1

