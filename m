Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B207C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jun 2022 17:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E859A113CD0;
	Mon, 27 Jun 2022 17:33:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE0F4113CD9
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 17:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCv8HxV9xFsDlekhNfJmhqXlDHqSzqcpv6Dljm4xyXWLSXhaoFu1shhyAjFoGhFU/PTuBturfqDcERP6au2v/vEZ/LfV03nHTdekXohSDINgfgcQr/3iettBkxnAkyoffs4v5O5esxg2ec9bYefPikkh6q1zL5fpGuca9qRONmgkx3MeDcsbvMIlFP7YuQIVVrIuJtDsI91UFmgSaaFhGWcFDT9h6KLE1lgUVrm/M09C1/sLiCNkPM3dGLJOEAG7hC3O0Up55oeugQWQ9Q6WuASU6QteMIT5etGffzfe0T/MMODJjBKFi9qlafCVqcaW8FFJd+0+aESYaypL2uh64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8ZudcUWaIC2GVW0+hF/YgnL943PhJDaUrlkfAV/9WA=;
 b=G9VVQZEweAvkqTR2m9Drr58ATqet+90Qd02VMVapYo1443B4p7BykGMDUiimazyzn1Mdles7pFsk5Q+U88ZMMKSFhHFJOq4srSPxmR15BCDnk6FozYBdNa/0rr7Vm1JWb1gKIYBW68AYYDX0s4byck2p+JWkaLTE8oEUG32MiQ6VujZKW4NZt8FOTU6PtRm1r1VuQs8eJjQAuSzeA9zq4nQkfyHo/HXyR3bylQhZpfPHrPcYkTSIvJsW57xLS6YlOhhiqHO0+uFVPIDSHpy0Y4/uutEcWWyhHIoFJ0mJB88q0gR35O6/rngoTgenz0QyxaklMuDfmqwxu3JzZjKang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8ZudcUWaIC2GVW0+hF/YgnL943PhJDaUrlkfAV/9WA=;
 b=Js7rTZ0OSQad1DJYpLZkHBVOAo3GUYZC/O9SezWla2uB2YgIQExGcsHQ3xl1fhL6tklyxrIsIGfvsn3qeq7Z1qNfitWpfQtTJqP1WzHtTDkagso7BYGYs+fF7C+5Dz8NeS4FXXk/wCa5EFcpHXynj5alZnB+cuZT5xoltVKgCu4=
Received: from BN9PR03CA0321.namprd03.prod.outlook.com (2603:10b6:408:112::26)
 by DM5PR12MB1929.namprd12.prod.outlook.com (2603:10b6:3:106::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Mon, 27 Jun
 2022 17:33:12 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::9c) by BN9PR03CA0321.outlook.office365.com
 (2603:10b6:408:112::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Mon, 27 Jun 2022 17:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Mon, 27 Jun 2022 17:33:11 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 27 Jun
 2022 12:33:10 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] Revert "drm/amdkfd: Free queue after unmap queue success"
Date: Mon, 27 Jun 2022 13:32:26 -0400
Message-ID: <20220627173226.8485-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23900459-22ad-4673-50df-08da58631bb8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1929:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46ojOhaSxle6F6rpDfSKz03jvfegWIIm/OT8gZEhWGby05ac2EQugentx9kHA3BQI7DCbT/GuUC2C0oRJ6svEiyGRN8mIfFx88MdtW7yb232qDaFeLjkjV/k69ibkdXyJnkgdi1YrFxCDS3AYoMIkir1eZGtTUKe00/oQOQxivBiIV+sFk2tRVSCBYZNXcBMaylNi/3XqUqUYKB/qgb70hA3b+j7dA2BJyvg9me+Uxtjhf/foBSYVzugjv1BPLQykmFfEIa3T0vAbjXRXSqMqk1jbfBjqPJsAXqFMKWIFjsR9DcMZx66l9xEQRf/JHDHBjouTh6dOp3RwFE7Od7rjdKn1XnFr7DSCkSDxbZcKkI4N20pYnwCAx835hCHDhiampi4PfOyGje5ubDHWCQ/dr8Zb7AlBFYA2H/hUptGyqiP+CfP/Kgey7SyvrLsc+r283bGaOPVo3d47+dD5A0QpbB0PdsxMaIrvljXrRE8O4J+jfIox6ZiThqPmI/wZrDtbiDfgJkSPx3zB6GOj6pZiJFU07lUoxMmfSZhuHpdHm6Nk9ghd3/WHPes7vg+yzpdmMptxeqivfN5K+JP+uWEu0f8pYROpI4/IJPJJO6VVtNAEuHMVrYpjlaBe0o6eDbfx8GJ6Qk7toaB9VHYWyeP5QVlmd7MCBnMbF0SpMZJHLq+3VRwetcDJd+0p6R4LnnsqQFHRADxgEW+luHuLHHR0Dz1VVWP4hA1SOlvMSwjtB4E45Ds3Vmeh4N+1W4Lc0a6YR26UM7vglMJsGRadQlHTVFPhmO/WI9d+UzzxZF6MDfctJL1aNFt8W0P1APV25LNfc889o+OtM5ULa0gEdGxFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(40470700004)(36840700001)(46966006)(1076003)(47076005)(16526019)(70586007)(336012)(41300700001)(4326008)(70206006)(2906002)(8676002)(82310400005)(26005)(186003)(426003)(40460700003)(7696005)(86362001)(8936002)(478600001)(5660300002)(2616005)(316002)(6666004)(81166007)(40480700001)(83380400001)(82740400003)(356005)(36860700001)(6916009)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 17:33:11.5636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23900459-22ad-4673-50df-08da58631bb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1929
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
Cc: Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 150c1266d78fbaa0fc5f89461daafae416db1c3e.

This causes KFDTest regression on gfx9, will submit new patch after
fixing.
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 28 ++++++++-----------
 .../amd/amdkfd/kfd_process_queue_manager.c    |  2 +-
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 21e451acfa59..93a0b6995430 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1881,22 +1881,6 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 
 	}
 
-	if (q->properties.is_active) {
-		if (!dqm->dev->shared_resources.enable_mes) {
-			retval = execute_queues_cpsch(dqm,
-						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
-			if (retval == -ETIME)
-				qpd->reset_wavefronts = true;
-		} else {
-			retval = remove_queue_mes(dqm, q, qpd);
-		}
-
-		if (retval)
-			goto failed_unmap_queue;
-
-		decrement_queue_count(dqm, qpd, q);
-	}
-
 	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 			q->properties.type)];
 
@@ -1910,6 +1894,17 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 
 	list_del(&q->list);
 	qpd->queue_count--;
+	if (q->properties.is_active) {
+		if (!dqm->dev->shared_resources.enable_mes) {
+			decrement_queue_count(dqm, qpd, q);
+			retval = execute_queues_cpsch(dqm,
+						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
+			if (retval == -ETIME)
+				qpd->reset_wavefronts = true;
+		} else {
+			retval = remove_queue_mes(dqm, q, qpd);
+		}
+	}
 
 	/*
 	 * Unconditionally decrement this counter, regardless of the queue's
@@ -1926,7 +1921,6 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 
 	return retval;
 
-failed_unmap_queue:
 failed_try_destroy_debugged_queue:
 
 	dqm_unlock(dqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index a46e2a37b4a6..c9c205df4a14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -422,6 +422,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 	}
 
 	if (pqn->q) {
+		kfd_procfs_del_queue(pqn->q);
 		dqm = pqn->q->device->dqm;
 		retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
 		if (retval) {
@@ -445,7 +446,6 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 				amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
 
 		}
-		kfd_procfs_del_queue(pqn->q);
 		uninit_queue(pqn->q);
 	}
 
-- 
2.35.1

