Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93BCC87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 08:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80FC510E4F4;
	Mon,  4 Aug 2025 08:41:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XcELI7Ex";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0692310E4F4
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 08:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imtHJue59BN6IynuwQ7drHBMArrBok5ZGY9y3ybSJBTqDAxXNvchSLmmj2ZghB7ghFVRe263/ShqK91VeTKlfPwOdCMCZeJXMnKPEyB49YQDk+5/39ZLBnAcv0fvdK7pvSQwoShJ3KEA/XZH+plf33Yjhx/XXE7PlewXpGI6ZFfIYr9uHRP6dcN+sr9MqZNa3f/eZ8VfMY/L7sTdpQoYd3505nSGHysgFNYRvsY8WKfTbOdy6r3Zz76KKlQ+ixuUreYOI6VolpWMAx1P+FV1oPTBGjLePkNeJgu6Cm+ZnOsGm4i6eIaVnyy78SOoy6J43guWs0nNMUKitHVEwiQqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlzkX5gGDK9S/59pZtGzAeqGpl9jzqiODCbUKm+DLDk=;
 b=pxcp2/Pw4QDje4cSIFjwsAMBRSB2g2V/0thXyTGYbU+7nkdyNefDYkJFDES1NL3jIEu9uQWGDqOCP0OjHRuOVtS/jlDfZ834nmApi03czZEvFGXo6zG4o29PSVnn+TQg/aojOIp7C4CruW1X/PxoFOxcaJ7ER6YBeIE5aT9UsVqOvxk5mfoL5h2XJ6yPGrayZzl16f5/fvvVS6lLai6z8RTIZOl2KbQkdKeujGV6V7orff1PXuCB14r7aRDhXquHLhmJH+7Wsai8ZC/qqCc4I2LJjstF093XbqQ+uJf32CCe55SGOhdDPh2i8eUMgJ6oiFLzAVEq5up0peBFQ+wtnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlzkX5gGDK9S/59pZtGzAeqGpl9jzqiODCbUKm+DLDk=;
 b=XcELI7Ex/dmhbH7iV41EmsgU+ZnEaJ2hfa6NP6QnbDqsP07CX5EDsBLbItH9XZJNluLJjYb9YU8HaFiJUm6OKl1tPCOTKr5A3arjSQ5jKZVpnKU3ha4FLd07alWohokfYeFBd0CHOPRLTucrgtvYTEdopma1yvc/IxSn8U3T85E=
Received: from DM6PR06CA0077.namprd06.prod.outlook.com (2603:10b6:5:336::10)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 08:41:43 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::37) by DM6PR06CA0077.outlook.office365.com
 (2603:10b6:5:336::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 08:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 08:41:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:41:42 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 4 Aug 2025 03:41:36 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v6 13/13] drm/amdgpu: Implement queue preemption using
 suspend/resume API
Date: Mon, 4 Aug 2025 16:38:31 +0800
Message-ID: <20250804084029.863138-13-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804084029.863138-1-Jesse.Zhang@amd.com>
References: <20250804084029.863138-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b8b0407-48be-4e15-cf36-08ddd332bd3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWdaaEZ6UlJaQXcyY21jTWVyT09FYVprellQMEVQZUVuRklmbkRDZVJoM2o1?=
 =?utf-8?B?K0lGT0JRMHpTVUlQK0hUbzV3RFZFcWpmalhVQlQ3L0JWR3JIa05TWHpiQUpz?=
 =?utf-8?B?YkNLRWNqY1RjUm4zSEVuaUZZVjYyRWcxK0JNbUVHM0lPNncwRUdtbFUzNmY3?=
 =?utf-8?B?UzlUbHRaUjJ2cDdKRWo2VUdkR1UwQVVWNm9jUzYvdGZ6SzI2UTZyb2FmcDVK?=
 =?utf-8?B?MlFhUFpmU2ZNeDI3dmFwTkZ2K2QwWXlzL1hsOXAxZnBCcGtnNTBHbFU0UmpS?=
 =?utf-8?B?azJjZWJyZDBtbHcrYTZDVmlwS0hyQi9HWEoxK1p4Wjg4WFZ1NEIvSzJGNHZX?=
 =?utf-8?B?VTd1OW8xNGlQTXVGN1JHTHZSWXZaWWlUNDgvbUVqNkt4aExmVEExODNYSHlP?=
 =?utf-8?B?M0VseDJXZnphYTJuOHp4VTZGVHpiSWdhUlJBUHNaTDFBU21xdkhWNEVPbGJC?=
 =?utf-8?B?cFdvMkl1VXZ4UVh3UkNBQXZ2Vzd1TzFvUzd1bUVyd2FnRDJKbU5iRFQyNWE5?=
 =?utf-8?B?aldENDFnZHlNTUpveVhrZitmdmpjendrUzA0K2Z1cE8wYVlnbG90VXl5b2ZE?=
 =?utf-8?B?OVhzWVVObFBxUkoyL2hLcXJiMC82c3RkOWVhbVdoUjN1QllabUwwZmEwdThZ?=
 =?utf-8?B?T2RNRU1yV2JjTXNtQ2VhR2o4b2Z5RjFqa0RQTVJmcCtma2t4NkdEV0FhcDRv?=
 =?utf-8?B?UGhBUmNYOGFtYWh2NzBwVFNDYlh1VFpINTZqZ1RnZUlaZFNyRS9DbGxRZGNX?=
 =?utf-8?B?TzIxK3VQWjNkK01VWm5VdXlaMWZGeUZkNTNQMUM5aWdKRlZpejcyQXlPeURv?=
 =?utf-8?B?V2hMMlhLRjRDMSs1S2VFbTBxSUl4bHYwbnpwK1NDYzZOWldDR2oxYis0cEcr?=
 =?utf-8?B?UEpoYWdyRWZOeUJGYWdpUHNhTnRxUk95ZVNERUVidUwzcW5VWkQ4VnVqajAx?=
 =?utf-8?B?QkFuSXNFVk5oU2xSM0l0bUplYWkyUDBVUzJ4dkdtNkpRNENxSklJUldDYUE4?=
 =?utf-8?B?NjlxL1c1V1dtcktwODBJbG14RjdlT2NKbzAzdW4vRFBkTXJmVUk2ZHJnRkhp?=
 =?utf-8?B?QjM2T0Yyajl2U3l0TTlMVmlyRFZJdU01dHA4dm1kRlhhZDV1MnNKd3EyME5S?=
 =?utf-8?B?K05WWklJbm1VM09lYy9xUUwyNDJPc2NiOWtPUjRiQXJsUzFNZ1NxUlg5SGtQ?=
 =?utf-8?B?WlRDaTg1bEg4cllHSjU4ZWhvWldveXVTcDBpaXg4OEN3UmJUSnJuY1dtL3Rn?=
 =?utf-8?B?ZmZsbSs1WUgvbzAzZ0k5dWx4TGQ4RFZOMjJIYUNldDFBeUEwS0c4S2IxSDZR?=
 =?utf-8?B?blJwemtEZGQ2Nnh0S3Fkd21XUmRJT0FDM2Z3NHgvOWphb1A2RU1lbDNFSzBn?=
 =?utf-8?B?NHVUVmlocllaWjRjclgrdUdCeG1FTDRLbUZBamh3cTFRRm1Ld1I2NzlPSks0?=
 =?utf-8?B?RTBOQ0s3NHhqZGlGVXNvRXA1TVlwRmxCSkYyY25WRDlyQ3ZhSmkrV2huMEhh?=
 =?utf-8?B?WmgxK3daSXNET1ltSTloaGhaZlB5c2pXOEc3OGUwemlONWExVDFyclErSnlF?=
 =?utf-8?B?V3lJelFlT2ZmTENKRmw1dGUwcnZWRkVZMnBJcER3WlY2VnI3R3RRWjl5NlI2?=
 =?utf-8?B?SkVibXVVREJ2R2hvNCtib0FRWkppRWhtMktzZHhacTZUY3h1bHpqN3NYSFU0?=
 =?utf-8?B?M1ZOOVVxTWVaRTVSNU9XZSszOXlMTHd5QzJWM2ljR1lpS09GSkUvblhuQVFp?=
 =?utf-8?B?M3U1am00YWxyeFdnSi9IQUdmQ3dqanRULzVLQ3Rab1ExRjNpclk5WWlzaGZ4?=
 =?utf-8?B?OVlDSDdOQlMreTF6TTVmdkIxZU9OSGtyZm9GUWRkSnRKSk9GYWtwK2paL0tH?=
 =?utf-8?B?UUp4dHpKSzZ1bDB3TnJOU2wxSElkMmZTakFwMFpCYzZ3OUJxK0lTY015T2VK?=
 =?utf-8?B?b2VocXZNVk9LSUloMEpyRGJYemhLSGE0RDJQNm02d3pJdUMva1JrSVNxelJM?=
 =?utf-8?B?aklrZno3N2NLZnlnZXVMZzZ5Q2wwNCtrWC9iM3NCdzZpS3RjYWNHUWo0UG1w?=
 =?utf-8?Q?67y0zb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 08:41:43.2293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8b0407-48be-4e15-cf36-08ddd332bd3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 64 +++++++++++++++++++----
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0c91302162fa..3a8da1f47159 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -72,7 +72,7 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
 	bool has_gfx = false, has_compute = false, has_sdma = false;
 	struct amdgpu_usermode_queue *userq;
 	bool gpu_reset = false;
-	int gpu_suspend, id, r = 0;
+	int id, r = 0;
 
 	if (idr_is_empty(&uq_mgr->userq_idr))
 		return false;
@@ -98,7 +98,6 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
 		dev_err(adev->dev, "userq reset disabled by debug mask\n");
 	} else if (amdgpu_gpu_recovery) {
 		if (has_compute && userq_compute_funcs->detect_and_reset) {
-			gpu_suspend = amdgpu_mes_suspend(adev);
 			r = userq_compute_funcs->detect_and_reset(adev, AMDGPU_RING_TYPE_COMPUTE);
 			if (r) {
 				gpu_reset = true;
@@ -127,9 +126,6 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
 	if (gpu_reset)
 		amdgpu_userq_gpu_reset(adev);
 
-	if ((!gpu_suspend) && has_compute)
-		amdgpu_mes_resume(adev);
-
 	return r;
 }
 
@@ -143,7 +139,8 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 	bool gpu_reset = false;
 	int r = 0;
 
-	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED)  ||
+			(queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
 		r = userq_funcs->unmap(uq_mgr, queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
@@ -185,6 +182,54 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
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
+			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
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
+	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
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
@@ -639,7 +684,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_map_helper(uq_mgr, queue);
+		r = amdgpu_userqueue_restore_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
@@ -794,10 +839,9 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
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
@@ -900,7 +944,6 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 	uint32_t queue_id;
 
 	cancel_delayed_work_sync(&userq_mgr->resume_work);
-
 	mutex_lock(&adev->userq_mutex);
 	mutex_lock(&userq_mgr->userq_mutex);
 	amdgpu_userq_detect_and_reset_queues(userq_mgr);
@@ -909,7 +952,6 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 		amdgpu_userq_unmap_helper(userq_mgr, queue);
 		amdgpu_userq_cleanup(userq_mgr, queue, queue_id);
 	}
-
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		if (uqm == userq_mgr) {
 			list_del(&uqm->list);
-- 
2.49.0

