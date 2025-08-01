Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D11C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 06:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2DFC10E3BD;
	Fri,  1 Aug 2025 06:27:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M1GIM5cV";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B3110E3BB
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 06:27:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzGvJUjg4rQaXYttDDSxC6N6zyZlS/7RoT8sI293EDD82eCRUmAzkEyM2oxQcVM5nPsift9kkeZ52nqT5n4Ogs3UwO1Tr8J5QuGCZt8HagLAdUfyfMCOwQG1pSxNudWo8O9wjEWLWP29Jc3Dr6idvRoh/o3L9RyZsyIDrqudyAwQ29MwopweLifVOdBv71SLfaB6wAQjpjvyyrahpK8TAwkkcZ8g45+Z5TS7249UFznrvYv1P+dwY+RBoxPWbjUGTmkta8g801M2rzM3nEvDC4Wl1ffcUfJLZb6qfYNISK/mqBgcSxrwsZAkYNGyKZTFXY1JN68XCLXhQGBT/UJDxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOmTZtbPZXJtgcJbBGvQfh7sO8kto1E8s66Jz8ErVVw=;
 b=fhthMq0zBLd089b2oeYXMaYe0h2D1tYQXgNvqwK85Eh8rAKfNeVLmQ0Y+reYMforuXg35OjCdhIjYuR0+8yPrc2YjPHIRgh8VYyn+4zdhqR2qZltMDOLWWaieWbla7wRHQM28Et1wZ5CmnEgfmiG8xRezEQTF5bQR/J3faRMT0iVmo4Ubn7YhZDrD5JvdDMC3NHV/HAlJ6WuRD8fP6nht3jptxnWfljtrw/q5L4Mgs6vfhEr87+4vtTpag0RkG7k6C8m6Eybt0MG1ZEekZKUoW6EvVPENsEpZtypPs+WCTVI4f1TewP3JMYae3iRlGWjiQ3Mfms9OrYSAzoW8sPuow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOmTZtbPZXJtgcJbBGvQfh7sO8kto1E8s66Jz8ErVVw=;
 b=M1GIM5cVnaLtHgFREhAYCQWCuZNxi9sMWpEmLN/JJCAJojf0kqGLP3C6kbl8OwJGqAaou9h/utHh4SrVtANlNeWCJ1SngFM/jhPtp8xf+3hfRom0uQU+Azo5YumoUd5/K5dQ2N2vEbrheNDDzMyCed/QF9IzitOg2qGwz2eOldE=
Received: from BN9P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::18)
 by LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 06:26:59 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::17) by BN9P223CA0013.outlook.office365.com
 (2603:10b6:408:10b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Fri,
 1 Aug 2025 06:26:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 06:26:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:26:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:26:58 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 1 Aug 2025 01:26:52 -0500
From: <Alexander.Deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v6 12/12] drm/amdgpu: Implement queue preemption using
 suspend/resume API
Date: Fri, 1 Aug 2025 14:21:10 +0800
Message-ID: <20250801062547.4085580-12-Alexander.Deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
References: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: Alexander.Deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: 361a08a5-5782-4a92-f931-08ddd0c46b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2hMU01IZ0hjOXVWaUdBUnE1ZXI3ZmllSEhzSXdzTU5XTEhYUWt1Wk1IR2Nk?=
 =?utf-8?B?KzkyNXVIT2R3VVF4bk9nWEhhSk5rSWhDbGVNWnNBeTMyNWo5MEhvWjdld3dx?=
 =?utf-8?B?YzlGT0lpMHdDbkFDMjgyblhnMjV6RFVXekRoVEdYU3ZpaEtTK1NxTk41SjRT?=
 =?utf-8?B?RVhrSXNoKytuWkFJZVgxNlBXbFpuS0hINUtxcGxwdDg4YmtqN2cyY0R6Z1Z5?=
 =?utf-8?B?T1c3b3AwYzd5VHJYYmF2VGlmTzZ1MmFJSzdKTTVzMnRvemNSL0F5ejh0RldQ?=
 =?utf-8?B?ZlNya1BKMFJEVkxvdzhmQ1VhbC9Wam45dm8wcEFuNUREbEhRVlVjMVlGd0pL?=
 =?utf-8?B?Zi8zdFVrRUhuSUdjQ0huUXJsSVlISi9IZXovbmtkWHg4WkQxSjY4ZVdXTDdM?=
 =?utf-8?B?UlhqZG4vMWZIZ2dvL1g5Y2dhTWpicTk0VUpINi96cFFCcCswczUvWGlVSm9t?=
 =?utf-8?B?YnlZYk1SVXNadkYzZGlMQkdMZ21CS1NlTWhtMHFncUkyTXlyM2hlNWEvOVBR?=
 =?utf-8?B?cDJNUHlxZDBlN3doR3BKd28xYXVmUHB3OEF2eFpLYnBRUmVMdkpkQmJkYUZM?=
 =?utf-8?B?ZUJidGdSeGdkQVlUZE5NTzdTWG13Nlp2eGZDQ3JZeTlOSUsxbVFNOGZTTHlm?=
 =?utf-8?B?NDlkYTF1TFdwbldNVWNQb2ZMUWhHdGdhQmZya2JoM2p5b1FaRUVSQkpIVFNC?=
 =?utf-8?B?ZEVIcUUvdENKaEdtQ1Jwc1Z1b1REUm9OcDMvL3BWdFdzcExTRWJZaFo4QWUy?=
 =?utf-8?B?SEFxc1l6K3NxcVUzRWdMcTkwNm44MEtSZlNQTVVyRVFFV2pjOFpBU3NFaUJS?=
 =?utf-8?B?a3JGN1pJNDFvbkE1Nzc3WmVOeGZRSStGMU9TTzhEVElWQnFUL3ltM0xFUnVN?=
 =?utf-8?B?enZtaXpVcGJZdEM4OWpuOFAyb0tCSkFzbElTbGV4WUlPV0gwTFJFdENOV0ZY?=
 =?utf-8?B?MEh4ODVJZEY5ZHo1dDViSVRZNE9sY3NCNkVFZWw3OHIvVlhZWVZPeW5leVZw?=
 =?utf-8?B?Q1puUHJwc3ZyTnVLbHZUVUN6Sm9EbXo4SHR4S0tmV1FubkVCNVNTMGZTUkEr?=
 =?utf-8?B?eWVXTXVlU2QwTnhZeHB4cTlnTWZuWnJpaHhkM0Z5eWhSaXp4ZHRRUDdOaHJS?=
 =?utf-8?B?a0ZUMTRyRGNndU5WMVByZ0ZUVGp1VHBIRjdnUVlFRS9Gd1FCQ29TZEFrY3lh?=
 =?utf-8?B?QjF4UVJ3UEdENEtDOUdRZzM3ckFHNEJFd2dXK09hMGxsN0lCSmY1Z1hHZU1l?=
 =?utf-8?B?bldJWk1KOXNEYVZTMDN2Nlo2RTV4ZjVPQmVxdjdGM0FuOU1sa2Z0VmFwYXQy?=
 =?utf-8?B?QW9vbktmUHFTMXhJbWFBWFE0YWFjYkE0ZnRiTEovWlh4di81TzZScmRUMThs?=
 =?utf-8?B?dzZ2ZkJnVVY5dG4rdFZmcXJUQ1haUXdQZ1A1M1ZOQlZlTXBSS2l2VmJpdVlF?=
 =?utf-8?B?Wi9GZ0pUalQvbWhCb0M2WnNqQVhHNDlucXNWQ2hXRWJ6Ni9LdjBZNEJFcnZB?=
 =?utf-8?B?MHVhVXVMYmhqZDY4NDF1cTZOQ0RObkFVUHZQWk9GTkJRMDlPVUpwVHBZLzdV?=
 =?utf-8?B?R3M4VTR6TERtTjk2VFd5M3M5UVBKQ1JYM3E4THhRaDdMRjd6eUNjNHlWOVdo?=
 =?utf-8?B?ZWt6dDN1WjFMcXNSd21yc2JsMW9MejFOZXVKcGUwWlRXNlh4VjhDMEVoRTNa?=
 =?utf-8?B?YmRTMHdXSlFLcVVwNWZaL0tqWmpteUozVlpxb3BhY0ZkY2ZaNTlkankxSVYx?=
 =?utf-8?B?UWpncjFuNnRCL2UxTGtUNjk3SmtFYVUvb0EycE9ESkZZVllDRmVtUlQ1MC9Q?=
 =?utf-8?B?ZnE4bW9tYnRyQTlUQ2E2MWhjSU5obmMwRmdGSlNhRHNHNVJaUmsyUGpsZ3Qx?=
 =?utf-8?B?T21tYStvRnBFcUx0aUNqUzVIZ2M3MjdBL3c3Ky9EbW1HU0dSWGwvazdiK25u?=
 =?utf-8?B?RHRJMHlDUlhxQjVCWWYxOFVQQ3pvaXdEZFpBeklQbmVNNWM1MVRnc2c4RFdS?=
 =?utf-8?B?SHRxK2p2M1dwaVRqK2k2dUZJanJTQWVYbHN2M1RjaFc2Q3ZSVUl5bjhOSkJs?=
 =?utf-8?Q?0icZUO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 06:26:59.2355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 361a08a5-5782-4a92-f931-08ddd0c46b88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141
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

From: Alex Deucher <alexander.deucher@amd.com>

Replace the queue remove/add approach with suspend/resume semantics
for user queue preemption. This change:

1. Maintains queue scheduling registration while only preempting execution
   - Previously used remove_queue/add_queue would fully deregister queues
   - New suspend/resume approach keeps scheduler state while preempting

2. Introduces proper preemption helpers:
   - amdgpu_userqueue_preempt_helper(): Suspends queue execution
     - Transitions MAPPED→UNMAPPED state on success
     - Marks as HUNG and triggers reset on failure
   - amdgpu_userqueue_restore_helper(): Resumes queue execution
     - Transitions UNMAPPED→MAPPED state on success
     - Triggers GPU reset on failure

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 53 +++++++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0c91302162fa..af0ac4b73ddf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -185,6 +185,54 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
+static int
+amdgpu_userqueue_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
+			  struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	int r = 0;
+
+	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+		r = userq_funcs->preempt(uq_mgr, queue);
+		if (r) {
+			amdgpu_userq_detect_and_reset_queues(uq_mgr);
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		} else {
+			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
+		}
+	}
+
+	return r;
+}
+
+static int
+amdgpu_userqueue_restore_helper(struct amdgpu_userq_mgr *uq_mgr,
+			struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	bool gpu_reset = false;
+	int r = 0;
+
+	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
+		r = userq_funcs->restore(uq_mgr, queue);
+		if (r) {
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			gpu_reset = true;
+		} else {
+			queue->state = AMDGPU_USERQ_STATE_MAPPED;
+		}
+	}
+
+	if (gpu_reset)
+		amdgpu_userq_gpu_reset(adev);
+
+	return r;
+}
+
 static void
 amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_usermode_queue *queue)
@@ -639,7 +687,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_map_helper(uq_mgr, queue);
+		r = amdgpu_userqueue_restore_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
@@ -794,10 +842,9 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	int queue_id;
 	int ret = 0, r;
 
-	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	/* Try to unmap all the queues in this process ctx */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+		r = amdgpu_userqueue_preempt_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
-- 
2.49.0

