Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF0ECD6E6E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 19:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD98211A2A0;
	Thu,  4 Jun 2026 19:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C3CQMlOL";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3445311A2A0
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 19:43:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTEH8HaVyAz2nBtszZnBnRQ98s7QqgdxxQr8CafEOyKPvWVFvyKq4sk4YLOnK9e1czoult/mTabO1RiwE/E+6kbBMjJoYABlrG+pYbvq1cEWDDL4zdfyl9+UrPcRz3iyCAkMRMdbWj2otHIIEu/Sv/zYYTOqHIgaBIZiyfMx6KJmxym278goCuzhUyOtpW7ytMrv3QQqa2JfBGZW8B7OcCINkPGCSgWik0YysSm8hRniwfWPTAKrgHZtMp0LB7mgi+IZ0JcmVYAtf+PtjW1c/V6mP/hvNSBfudWOFW0s699hO1wmJK991kPEhUCw2l3TKUAuiV40xT3PCrF2o/pyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VE9vq2w8ovNBbd1YT9THeLCdrcM5J9MjH6IWo764FEs=;
 b=FyNaOK+IoG+ly4+CDarFUYHo22oDgAR3q1b8emg6mDSFNr6LmNpeGboJbMkuzr8Kd86tDQWqDPggaN4d6fPZZpoBkNPAPPj1uPSLbwu4UU2E6iz0xEjIRsMTkYZr2hWj4dDBXqylj29kAHjKPyMVbz/bV1NnU6doaNPbEmY3pRg7zDKN1GqaVAgW+GMIhRPQ5VvzpyfVarzEMM7Fn1ja4cJ6G6Wql9o1D44LOIbL3V9ZAnOpbyI+RL1L7tk6HD1aQDYGdBJs46jyInbXjRzwrau5A/I3DDOF2YX5HWeolXSJi0y3fvylzJu8JXJKEJHzguq0MfJtD1P+DeBgK8VQUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VE9vq2w8ovNBbd1YT9THeLCdrcM5J9MjH6IWo764FEs=;
 b=C3CQMlOLoltJkdltCOog6YnT4xNzQi9b1p1Rj7R6+WjYp3F/TUJ25GqQNOVD7o+SDccQ8yNlioYqskS2G4VJ36Jtfu8gokimj1O9hsHlyn2Y8GCKPV7G9JqJWODZiK7TvWYVY8OFvCfMTKvH86tKul5y5gsNchjFaauvTtfIQvw=
Received: from BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::17)
 by MW5PR12MB5622.namprd12.prod.outlook.com (2603:10b6:303:198::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 19:43:28 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:59d:cafe::2a) by BY1P220CA0013.outlook.office365.com
 (2603:10b6:a03:59d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 19:43:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 19:43:28 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 14:43:27 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Philip.Yang@amd.com>, <David.YatSin@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH] drm/amdkfd: Properly acquire queue buffers in CRIU restore
Date: Thu, 4 Jun 2026 15:43:14 -0400
Message-ID: <20260604194314.2981688-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|MW5PR12MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 63596231-dfed-4a71-eac9-08dec2718cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: t/XTUyvdeBsRkWqW31a2w0XvG9dIHcUyjJF8kXocI82NhUS4wbUV12OloZNOHv6e0TomuUe40I+ljFph78yRlp1EnIRAY7n0qL++UQQMHQhK8VPTsQLnsjH0abtrCcPl7BMdJ265yCz8ClGZKxjerUS4/Jo2MdJa4YePw/MdTwNDndyniTUfYjczwR/KFfkzUttWWdYUll3p+ymaZvwEQ6fSeAArqACt76t66iSutcXDWtcfibQO2oPgq+JCWqCIhmkpHcWcTo2B7F1034JAjS7eo4ENGsrSSOuhNdEs0gJda9xaihoyB3b7EFAi0cejDQIF6c7C8dxbZFi1rL0TD3Oa2+o/NxPrTFhAxslDYTmkZrgYlWOTGdEwtAje1zzCjwe2HEmLPF6ntlGBkMWXVdMjaIrAtHczMxZ/6fpK1X+PvQ5i6n0QmFO4Q3eEq2YfZf4qAJVoejJIDHThKF/3dIemTyy+q1Y410wjsJiOEitj6sWGJze4VmCvGDtPeAMQTLN+yOTfkD5Ipynb8sQkMQG9Xz2sCKUmBafYM4THYn9+tv3WEufsWqV3YiK0pmImvmD9sm8n1p9JBRZOy6sQigHkQ/51pdOirq+fhiAllXp7uFHka4xCTo/a4RUKKejBxhdKTjITL8mEmgZsxldmssaxMmQribPbIL7UdD1kxq8GMI5rjngakddrZ/fxg/8ppjjgQ+uxQuWgXanYgRedhB2mYDc/sSqNsCHzdXHYuRk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HGNu+DecPITr7Tii8E0Fp1oC/4B5DksUUOD2HKL1RHFQOKnMpfJVflovADtFbTMHL2g4R8Mnk2rvDecaB0CIs7Dv70krylwught1c7FDgWrIlYdnGE85AYQfjfuhMFtqrHkaMEFRvrc/UlzQfc2wDc4TqEnKOB7MhnXIYUlTH1fJdWbDbVC7JQUaciesYPppmkgTNUnSkbza+Qw249M7DfoMp78Eu3Qkz6LlRFeVYcIFCDxlS4G7fmV0+hYzxFpGLaHE3xEoFWgj+yQBdtFb0skdg1ZurqKcGICWQE++8YV21NADA6B0mWllN4ZYPxzVhoyG8D762fm2r55c4IwBCikh53/xn0sdoq5Ul1Hmwm5dg+kGhkWnr19GCgPF7aPORf5MmXvhWnwrkMvWNQG9h/gcuPKp9ac+qXacifTIvP880dsU9en37ehlcJmGXCxb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 19:43:28.2444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63596231-dfed-4a71-eac9-08dec2718cd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5622
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

When kfd_queue_acquire_buffers() was split off from
set_queue_properties_from_user(), set_queue_properties_from_criu()
was missed. Thus, set_queue_properties_from_criu() is not
filling out the buffer fields of queue_properties, which
can come up when subsequent code expects them to be non-null.

Add the proper call to kfd_queue_acquire_buffers(), and also
use the right cast types in set_queue_properties_from_criu()
(which were missed at the same time)

Signed-off-by: David Francis <David.Francis@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c  | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 9295d0f9dce4..67b282dafbe7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -962,8 +962,8 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
 	qp->priority = q_data->priority;
 	qp->queue_address = q_data->q_address;
 	qp->queue_size = q_data->q_size;
-	qp->read_ptr = (uint32_t *) q_data->read_ptr_addr;
-	qp->write_ptr = (uint32_t *) q_data->write_ptr_addr;
+	qp->read_ptr = (void __user *)q_data->read_ptr_addr;
+	qp->write_ptr = (void __user *)q_data->write_ptr_addr;
 	qp->eop_ring_buffer_address = q_data->eop_ring_buffer_address;
 	qp->eop_ring_buffer_size = q_data->eop_ring_buffer_size;
 	qp->ctx_save_restore_area_address = q_data->ctx_save_restore_area_address;
@@ -1042,17 +1042,24 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 	memset(&qp, 0, sizeof(qp));
 	set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev->adev->gfx.xcc_mask));
 
+	ret = kfd_queue_acquire_buffers(pdd, &qp);
+	if (ret) {
+		pr_debug("failed to acquire user queue buffers for CRIU\n");
+		goto exit;
+	}
+
 	print_queue_properties(&qp);
 
 	ret = pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_data, mqd, ctl_stack, NULL);
 	if (ret) {
+		kfd_queue_unref_bo_vas(pdd, &qp);
+		kfd_queue_release_buffers(pdd, &qp);
 		pr_err("Failed to create new queue err:%d\n", ret);
 		goto exit;
 	}
 
 	if (q_data->gws)
 		ret = pqm_set_gws(&p->pqm, q_data->q_id, pdd->dev->gws);
-
 exit:
 	if (ret)
 		pr_err("Failed to restore queue (%d)\n", ret);
-- 
2.34.1

