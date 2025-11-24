Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C85CFD31C
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 08:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 166C710E1E9;
	Mon, 24 Nov 2025 08:58:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OM34a8mo";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6891E10E1E9
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Nov 2025 08:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R29trsrZRtlUlW2uQPrLP3d8RbKbDbPjcDGawdK2YD62RoEGDeacDGRpqCJMZUXaAO2BGr6B39LJteovt2CeeE/1FS3H/heZBjE0hhhsIgvFMw03Vce4HqgbJfnCmylrhzSLNIEoILSHeSJkYOwHP3Pj3yvF+NlhLuwc8nnT0Hqx0Ht5c8YE/KR82/EeOXT0ZMLIcD4lVpCd73ebVKmrhrgDQr7r9ay+7CcgZYmgMc8eRO5Zstu45ovwBat36MjvM7LR8KW44ZpRYLLOKh04eZgUeFW8chm54bP5k5CmQBpGcD8Lw6+VYnKxsVuMLUtY2iCyPh/r+wgvWHXD5mc1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsFRYKltI8Mu04QowkP3+pyajMe+QcCHW1lJxUhEXHk=;
 b=XXJ97/QurlkByEbb+niH+gbOTjx7LH9+V73JHZNj3RY2N16ZAxWsUj7YoQz5MbTfwWikFcnQWrijPC9G78EK1qscGTbR/8GmJCXmy6q6QXXg4sQChDoZoOF/faStwynz/V3adW4cLUN4yvnBa/aHxyTj62RdwSQUu5/FLTgQ6cUdpNYv7RXBoPQancTLu1cvgVgxdQ8Bucw9YjLSknkGYco0ii73LlWBziCMogLZn3igcCkY9x/wyjIFwdkVLEIZ1xvvJyYFvsaWTSB33gui8EzfBxU/m4iOZL4lHQd3UutN6bLTQ85KAOh89MbExtDJVBMPw24wnWF0gELhwMPKig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsFRYKltI8Mu04QowkP3+pyajMe+QcCHW1lJxUhEXHk=;
 b=OM34a8mogMgFZEJQV/wtVuZ3xwMJIqX6l/Ej5qWMl5PCciy1XvCoEaTpaO18gfHdPITBtnBBGz660vylWodH4+QQhvlgpJmdPQ9HmvjroDBQLw5YebtLm1otVKiV7j7byLTN6T2dua0YM4gNbAJiIFLm2rfk0I+g3E6qbKn9FBQ=
Received: from SJ0PR05CA0167.namprd05.prod.outlook.com (2603:10b6:a03:339::22)
 by PH0PR12MB999090.namprd12.prod.outlook.com (2603:10b6:510:38c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 08:58:47 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::ce) by SJ0PR05CA0167.outlook.office365.com
 (2603:10b6:a03:339::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.9 via Frontend Transport; Mon,
 24 Nov 2025 08:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 08:58:46 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 24 Nov
 2025 02:58:43 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Change user queue interface signatures
Date: Mon, 24 Nov 2025 14:28:15 +0530
Message-ID: <20251124085821.2759840-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|PH0PR12MB999090:EE_
X-MS-Office365-Filtering-Correlation-Id: 214c4e8e-9abc-40a7-869c-08de2b37ad75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pIzRlXbgRneJqN3Oq8s2DG1vJD2E8nAkPLisCUcIDrYuIAClzbN1qhB93o8W?=
 =?us-ascii?Q?0N1hHy/CdcdzlLoDwF5RyeMHAYKxkc9pTqoZ3eqb+ou9cvq8/Bqld2pRnlmz?=
 =?us-ascii?Q?5jjG32cUGmthtX7BdHOvRSvV7PWTL4N+pOVEW3S7eO4/A95aTMysq1vhxZ+z?=
 =?us-ascii?Q?+izHsPfb/FaBQkNgzZnm+idAXtl3ylJ5ITe1DYcFbv7v9Wvtk+iWZdF9JxbR?=
 =?us-ascii?Q?BVk3OeSLk8lEJJc7nA52F5whuW53e3eMywH7haLEplOReLCSWpnOtjd2OQ0D?=
 =?us-ascii?Q?rEc1qsmbCN8ltnCWVTfeqEWWnB4lxof05sXS74KNcEQFFp7R83OMiFa//hXD?=
 =?us-ascii?Q?GuiRSmAUt4I6WSzSgUMt/EkpdGGw8t445pbZp5hO8l6V76nT5igc/KYm7Wcg?=
 =?us-ascii?Q?wAPMqBeExPTGpE0Umt7dgAkW3s//P6M9gNKdUOCy7Dhrck5NucHTAnrPBjUE?=
 =?us-ascii?Q?7WgPEM3Nb4gPRfikYODn2uFDkjuIXzDdu8TOSBlj4O0qOU4xRHBYPxf4lJ54?=
 =?us-ascii?Q?lL4LPJRU+jY+4Ca+epOpEgUEZADl0CpjPy5wKKZTM4VgrWX3nbXRdrx9v0Gs?=
 =?us-ascii?Q?OFpi7MSrrSrn7otN+wBomt5OAXXmY/f2vbr6RGoWJXqHRMh2jQ4fuK82hcPT?=
 =?us-ascii?Q?ZZvgD3v89Q63tfmGhIMh4HMXMr0AAL8aJqgvxae6skAG/0Uc1KjuD7ftFTUw?=
 =?us-ascii?Q?J9WjOde3rGhW9ViVIKK39y0m7le5hrnpvEA3gMa8dALdW/1xkxQae3uRLy7L?=
 =?us-ascii?Q?rDQjiPHJYRUOAEUmm2C1zQ3FLY5r3EWuERgPIkcVCU+ZDITwqO0FmCtV5PLA?=
 =?us-ascii?Q?sLgC7OmbYbj/7/jmhVLil/f56orUx7Ej/ok710On2ZHKMTH8yr7o1DlUIUjz?=
 =?us-ascii?Q?fIg8CGAfqgkP1bLHVWlf3Vz0N3sk6Nr5bMyLgeiR/KHDVGuR0eForCn7ZzN+?=
 =?us-ascii?Q?dqKdU6OJiVomBOEwLzPjVHCfYEQoV0VGVu7+CC04OLBHSHZuSf7NudxjdmMC?=
 =?us-ascii?Q?L8ngz92KyeyBkThY3vi7v/WoOlDNl5t0WQgo1bZrqupiIxPCkgbAp3HfAhUM?=
 =?us-ascii?Q?jVYvqEEhr4RFVx3FVdMFsAZdsDxXMAHWJ3hqaKzRewJNz+lyDov9K5DgbvWZ?=
 =?us-ascii?Q?bmEltjkN0xXGxpmvsXHg+tKR7aY9JSny99SaLcCrQbgHoPsdChUbpyPpKuRU?=
 =?us-ascii?Q?D8ZRyb1lFPGr6Ai8XoUlqZJsTwvI6KUs6EgcfyObkdGUTXKwNXgAPo8CoVuH?=
 =?us-ascii?Q?kvAM/JkPZMQFfCbCw7mUCHMz1WXKtxRgBicj8I2tY+fRIenkkB4fsjVtbien?=
 =?us-ascii?Q?0DAE3xTPxjD4WenVeVmAvTh0s+XH5NpRKY4+ZtK3Flt2RylzHW4B52ktKHwV?=
 =?us-ascii?Q?LeLFEraEl/nHkdt8jNK2EWd0FekGyaLlN9Ww6yRdczGEYc6p1Jqshm3MNvpC?=
 =?us-ascii?Q?S2jzXGwq66knAUu2bFyR6BNiCUMx+lcEzn3hiJ7bbd5GXovvfGy6KZTj/ePl?=
 =?us-ascii?Q?Cyti4GqJwiKhzPigh+m1hO7bK1Cumnkk1xOA8jDznQOz8fAv3IspqWw4/OJg?=
 =?us-ascii?Q?ZKYtwoHGCDoHCgrzj8c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 08:58:46.5206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 214c4e8e-9abc-40a7-869c-08de2b37ad75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999090
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

A userq is associated with its queue manager. Use that and make
the userqueue interfaces to operate on queue.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 24 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  | 20 ++++++----------
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 28 +++++++++++-----------
 4 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 973998a2dc95..224aadb9d1d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -63,6 +63,7 @@
 #define MBOX_TOS_RESP_MASK (GFX_CMD_RESPONSE_MASK | GFX_CMD_STATUS_MASK)
 
 extern const struct attribute_group amdgpu_flash_attr_group;
+struct amdgpu_firmware_info;
 
 enum psp_shared_mem_size {
 	PSP_ASD_SHARED_MEM_SIZE				= 0x0,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 37f5863f40c8..923e3dc32326 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -283,7 +283,7 @@ amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
-		r = userq_funcs->preempt(uq_mgr, queue);
+		r = userq_funcs->preempt(queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
 			found_hung_queue = true;
@@ -308,7 +308,7 @@ amdgpu_userq_restore_helper(struct amdgpu_userq_mgr *uq_mgr,
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
-		r = userq_funcs->restore(uq_mgr, queue);
+		r = userq_funcs->restore(queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
 		} else {
@@ -331,7 +331,7 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 
 	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
 		(queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
-		r = userq_funcs->unmap(uq_mgr, queue);
+		r = userq_funcs->unmap(queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
 			found_hung_queue = true;
@@ -356,7 +356,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
-		r = userq_funcs->map(uq_mgr, queue);
+		r = userq_funcs->map(queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
 			amdgpu_userq_detect_and_reset_queues(uq_mgr);
@@ -401,7 +401,7 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 
 	/* Drop the userq reference. */
 	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
-	uq_funcs->mqd_destroy(uq_mgr, queue);
+	uq_funcs->mqd_destroy(queue);
 	amdgpu_userq_fence_driver_free(queue);
 	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
 	xa_erase_irq(&uq_mgr->userq_mgr_xa, (unsigned long)queue_id);
@@ -731,6 +731,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	db_info.db_obj = &queue->db_obj;
 	db_info.doorbell_offset = args->in.doorbell_offset;
 
+	queue->userq_mgr = uq_mgr;
 	/* Validate the userq virtual address.*/
 	if (amdgpu_userq_input_va_validate(adev, queue, args->in.queue_va, args->in.queue_size) ||
 	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
@@ -757,7 +758,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-	r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
+	r = uq_funcs->mqd_create(queue, &args->in);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
 		amdgpu_userq_fence_driver_free(queue);
@@ -778,14 +779,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
 		amdgpu_userq_fence_driver_free(queue);
-		uq_funcs->mqd_destroy(uq_mgr, queue);
+		uq_funcs->mqd_destroy(queue);
 		kfree(queue);
 		r = -ENOMEM;
 		up_read(&adev->reset_domain->sem);
 		goto unlock;
 	}
 	up_read(&adev->reset_domain->sem);
-	queue->userq_mgr = uq_mgr;
 
 	/* don't map the queue if scheduling is halted */
 	if (adev->userq_halt_for_enforce_isolation &&
@@ -800,7 +800,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
 			xa_erase(&uq_mgr->userq_mgr_xa, qid);
 			amdgpu_userq_fence_driver_free(queue);
-			uq_funcs->mqd_destroy(uq_mgr, queue);
+			uq_funcs->mqd_destroy(queue);
 			kfree(queue);
 			goto unlock;
 		}
@@ -1441,7 +1441,7 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
 		if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
 			amdgpu_userq_wait_for_last_fence(uqm, queue);
 			userq_funcs = adev->userq_funcs[queue->queue_type];
-			userq_funcs->unmap(uqm, queue);
+			userq_funcs->unmap(queue);
 			/* just mark all queues as hung at this point.
 			 * if unmap succeeds, we could map again
 			 * in amdgpu_userq_post_reset() if vram is not lost
@@ -1458,18 +1458,16 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 	 * at this point, we should be able to map it again
 	 * and continue if vram is not lost.
 	 */
-	struct amdgpu_userq_mgr *uqm;
 	struct amdgpu_usermode_queue *queue;
 	const struct amdgpu_userq_funcs *userq_funcs;
 	unsigned long queue_id;
 	int r = 0;
 
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
-		uqm = queue->userq_mgr;
 		if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
 			userq_funcs = adev->userq_funcs[queue->queue_type];
 			/* Re-map queue */
-			r = userq_funcs->map(uqm, queue);
+			r = userq_funcs->map(queue);
 			if (r) {
 				dev_err(adev->dev, "Failed to remap queue %ld\n", queue_id);
 				continue;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 649573977cd3..7c6dfc0e27a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -77,19 +77,13 @@ struct amdgpu_usermode_queue {
 };
 
 struct amdgpu_userq_funcs {
-	int (*mqd_create)(struct amdgpu_userq_mgr *uq_mgr,
-			  struct drm_amdgpu_userq_in *args,
-			  struct amdgpu_usermode_queue *queue);
-	void (*mqd_destroy)(struct amdgpu_userq_mgr *uq_mgr,
-			    struct amdgpu_usermode_queue *uq);
-	int (*unmap)(struct amdgpu_userq_mgr *uq_mgr,
-		     struct amdgpu_usermode_queue *queue);
-	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
-		   struct amdgpu_usermode_queue *queue);
-	int (*preempt)(struct amdgpu_userq_mgr *uq_mgr,
-		   struct amdgpu_usermode_queue *queue);
-	int (*restore)(struct amdgpu_userq_mgr *uq_mgr,
-		   struct amdgpu_usermode_queue *queue);
+	int (*mqd_create)(struct amdgpu_usermode_queue *queue,
+			  struct drm_amdgpu_userq_in *args);
+	void (*mqd_destroy)(struct amdgpu_usermode_queue *uq);
+	int (*unmap)(struct amdgpu_usermode_queue *queue);
+	int (*map)(struct amdgpu_usermode_queue *queue);
+	int (*preempt)(struct amdgpu_usermode_queue *queue);
+	int (*restore)(struct amdgpu_usermode_queue *queue);
 	int (*detect_and_reset)(struct amdgpu_device *adev,
 		  int queue_type);
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 91f443374813..8b0aeb89025a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -113,9 +113,9 @@ static int convert_to_mes_priority(int priority)
 	}
 }
 
-static int mes_userq_map(struct amdgpu_userq_mgr *uq_mgr,
-			 struct amdgpu_usermode_queue *queue)
+static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 {
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
 	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
@@ -158,9 +158,9 @@ static int mes_userq_map(struct amdgpu_userq_mgr *uq_mgr,
 	return 0;
 }
 
-static int mes_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
-			   struct amdgpu_usermode_queue *queue)
+static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
 {
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct mes_remove_queue_input queue_input;
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
@@ -252,10 +252,10 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 	return r;
 }
 
-static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
-				struct drm_amdgpu_userq_in *args_in,
-				struct amdgpu_usermode_queue *queue)
+static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
+				struct drm_amdgpu_userq_in *args_in)
 {
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
 	struct drm_amdgpu_userq_in *mqd_user = args_in;
@@ -412,18 +412,18 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static void
-mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
-		      struct amdgpu_usermode_queue *queue)
+static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
 {
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+
 	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
 
-static int mes_userq_preempt(struct amdgpu_userq_mgr *uq_mgr,
-				struct amdgpu_usermode_queue *queue)
+static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)
 {
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct mes_suspend_gang_input queue_input;
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
@@ -467,9 +467,9 @@ static int mes_userq_preempt(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static int mes_userq_restore(struct amdgpu_userq_mgr *uq_mgr,
-				struct amdgpu_usermode_queue *queue)
+static int mes_userq_restore(struct amdgpu_usermode_queue *queue)
 {
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct mes_resume_gang_input queue_input;
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
-- 
2.49.0

