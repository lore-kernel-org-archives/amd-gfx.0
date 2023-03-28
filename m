Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAF4C761AF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F2CC10E90F;
	Tue, 28 Mar 2023 15:14:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7662110E908
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlGUNhLYXqxPQmWKmhtdHQ1l47NgD0iRwTBeU8Sp3LAYTQAYX1Rj8q3Dm2bRx7FrHPkWd4zbfQt9hvdidnWvrI7/PI41eYEOp09il+ELrhSlZDZ6DODxT7v7w5Kw3z2YuMzrSN5XFJQTPtlMtoSkt33bfTcttthQ40Gix9/pwhabgy11lW9IdH3yNOXvPQRVTvf+bwXOtxZN1C5+2bKNYDG6tghcSpEI8+c1zKCrm3tPq8/wA3VQiZwajg+X17z41WOddvZeYs1NXXMp754PSXBA51g7uZRGhx4T9QagZaAXEjBIqf/xKJOfgbmNG7j/Ojb8ZSC6Zj51C9QqmplPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEku5lwfWrMe8fj0TH6TO5pL7u6mlb+aTSKRSqgsUF0=;
 b=ml+2NjuuUCyaP4kki/RWOMVW1JmRhDCrjcTY7n+XPTM12FPg8pZmAZ2snwmxcya5259UaUb6ajngnoej06cIf3xRt40atSflff+Q5b2gCjspX9I4xztJ6g/BeSSYRJR4egNbPNjHhQtoAznMOAVMV9aCNR4Qk4wy3G6wXihBlv6Hh54MlNrWxp2bgmKhiX92Rad30IG0dP8DB3JmaE75duC8/J4FnF/L39c0ZmJbZ19jsHXvb3EX/N89RQyrdm5yJnEcHqzGDEl6FADYrIP3gh/wqOXHGS5iMZ+S1njSdcWjX0VijINETg8FN8xoYFDnW3t/Iep35BGpdgGkWI5Tuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEku5lwfWrMe8fj0TH6TO5pL7u6mlb+aTSKRSqgsUF0=;
 b=PY9HiBjXkQfCFlrH0kYSsYWUn74Uxx0pO1W6DKB6WWIEtvAxJIl1ZpN4sK/iWLeFoiSlB70NHuy4htIqPcgRdXn8zMnZs/21rVtMqh1anm5iRp71LaqH76q423Jxsg1qJuce++pgNJwWe+3TbVsol1k82Ex52d9Nx8SyYWOO+rI=
Received: from MN2PR22CA0014.namprd22.prod.outlook.com (2603:10b6:208:238::19)
 by PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 15:14:36 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::df) by MN2PR22CA0014.outlook.office365.com
 (2603:10b6:208:238::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/32] drm/amdkfd: Add PM4 target XCC
Date: Tue, 28 Mar 2023 11:13:21 -0400
Message-ID: <20230328151344.1934291-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf0d355-c838-4670-844d-08db2f9f24a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lcPAn9MtkV/zqZFfdfRAZwk1yo1YKQqWscShH4iqr17X5WnBwnrk9OUMfW9rbVpIwvOcjf1nyg6YyIVtZ5ScD8UgxpZOIWrlHwIK8j53tumOC/o3TxEhpoRiezG8+zW+tOIOAFbwyPpYYc8U63LPdOa/yDihy4NK0E0jndhF8lS8tV7VJb+dmDkcZ0R92qaiJfcNJIhiNyCmqvtza7wla0QKKhdIzhmZue66BlawjGtEEZCo8VlChsrsJSr6eVR7l7EdWCDMFO/9Nx5orz2SF+UKmazXPqYs9+vDvq/N+/wm/cQGGx3WpLfSetIJkI01JajqE6pclQyiOY6259b7dVNWHyn8n8hce6zSf/HQ7dsqeQGT249fk3B93SkZlO+DyapMGCPf+9/LAooLwovD+gXyOki4k2/W826VJ/Hh6vnQjyD3y19qt/8l+po7/5ewySBpYPOT9uxcpj6iIlc71+7JW8BHQPhtFedtXZKjZxOnqq8bzvyWs29JKJERtfMn47kAadgVDInEHjyBLsDqE1WBZSzluxohAnRgOsYdt+n3oypzQciiLwBsYadS/FdCwJn8rcbqjfSYkyl8YIFjWKc7RJIBN/arS7m36kvVb5aOtiktCFnTitOuEJ954O5dc70jC/964Vj/YwWu1U4+qEmsSVF0YXjhn/X44XcwhTRWasLIyPSSmvuWixbtpbZ3d/VUpYpBQj8p4ltoJ/1Uq9wTuj/gzlly9HzT/V51Y/Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(6666004)(26005)(40460700003)(36756003)(5660300002)(7696005)(81166007)(478600001)(8936002)(54906003)(41300700001)(6916009)(86362001)(70586007)(4326008)(8676002)(70206006)(356005)(82740400003)(316002)(36860700001)(40480700001)(82310400005)(1076003)(47076005)(336012)(83380400001)(426003)(2906002)(2616005)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:36.3983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf0d355-c838-4670-844d-08db2f9f24a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026
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
Cc: Amber Lin <Amber.Lin@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Felix
 Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

In a device that supports multiple XCCs, unlike AQL queues, the PM4 queue
will be only processed in one XCC in the partitioning. This patch
re-purposes the queue percentage variable in create queue and update
queue ioctl for the user space to specify the target XCC.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Tested-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 22 +++++++++++++++----
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 .../amd/amdkfd/kfd_process_queue_manager.c    |  1 +
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 8949dcd24f79..cf1a97583901 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -186,7 +186,12 @@ static int kfd_ioctl_get_version(struct file *filep, struct kfd_process *p,
 static int set_queue_properties_from_user(struct queue_properties *q_properties,
 				struct kfd_ioctl_create_queue_args *args)
 {
-	if (args->queue_percentage > KFD_MAX_QUEUE_PERCENTAGE) {
+	/*
+	 * Repurpose queue percentage to accommodate new features:
+	 * bit 0-7: queue percentage
+	 * bit 8-15: pm4_target_xcc
+	 */
+	if ((args->queue_percentage & 0xFF) > KFD_MAX_QUEUE_PERCENTAGE) {
 		pr_err("Queue percentage must be between 0 to KFD_MAX_QUEUE_PERCENTAGE\n");
 		return -EINVAL;
 	}
@@ -236,7 +241,9 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
 
 	q_properties->is_interop = false;
 	q_properties->is_gws = false;
-	q_properties->queue_percent = args->queue_percentage;
+	q_properties->queue_percent = args->queue_percentage & 0xFF;
+	/* bit 8-15 are repurposed to be PM4 target XCC */
+	q_properties->pm4_target_xcc = (args->queue_percentage >> 8) & 0xFF;
 	q_properties->priority = args->queue_priority;
 	q_properties->queue_address = args->ring_base_address;
 	q_properties->queue_size = args->ring_size;
@@ -442,7 +449,12 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
 	struct kfd_ioctl_update_queue_args *args = data;
 	struct queue_properties properties;
 
-	if (args->queue_percentage > KFD_MAX_QUEUE_PERCENTAGE) {
+	/*
+	 * Repurpose queue percentage to accommodate new features:
+	 * bit 0-7: queue percentage
+	 * bit 8-15: pm4_target_xcc
+	 */
+	if ((args->queue_percentage & 0xFF) > KFD_MAX_QUEUE_PERCENTAGE) {
 		pr_err("Queue percentage must be between 0 to KFD_MAX_QUEUE_PERCENTAGE\n");
 		return -EINVAL;
 	}
@@ -466,7 +478,9 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
 
 	properties.queue_address = args->ring_base_address;
 	properties.queue_size = args->ring_size;
-	properties.queue_percent = args->queue_percentage;
+	properties.queue_percent = args->queue_percentage & 0xFF;
+	/* bit 8-15 are repurposed to be PM4 target XCC */
+	properties.pm4_target_xcc = (args->queue_percentage >> 8) & 0xFF;
 	properties.priority = args->queue_priority;
 
 	pr_debug("Updating queue id %d for pasid 0x%x\n",
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index fa89606099b8..6bfa9b9d75bd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -586,6 +586,7 @@ static void init_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
 			/* PM4 Queue */
 			m->compute_current_logic_xcc_id = 0;
 			m->compute_tg_chunk_size = 0;
+			m->pm4_target_xcc_in_xcp = q->pm4_target_xcc;
 		}
 
 		if (xcc == 0) {
@@ -626,6 +627,7 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 			/* PM4 Queue */
 			m->compute_current_logic_xcc_id = 0;
 			m->compute_tg_chunk_size = 0;
+			m->pm4_target_xcc_in_xcp = q->pm4_target_xcc;
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 873b49238dc1..1337fcdf8958 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -509,6 +509,7 @@ struct queue_properties {
 	bool is_evicted;
 	bool is_active;
 	bool is_gws;
+	uint32_t pm4_target_xcc;
 	/* Not relevant for user mode queues in cp scheduling */
 	unsigned int vmid;
 	/* Relevant only for sdma queues*/
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index b1fb017b2ef8..2b2ae0c9902b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -477,6 +477,7 @@ int pqm_update_queue_properties(struct process_queue_manager *pqm,
 	pqn->q->properties.queue_size = p->queue_size;
 	pqn->q->properties.queue_percent = p->queue_percent;
 	pqn->q->properties.priority = p->priority;
+	pqn->q->properties.pm4_target_xcc = p->pm4_target_xcc;
 
 	retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
 							pqn->q, NULL);
-- 
2.39.2

