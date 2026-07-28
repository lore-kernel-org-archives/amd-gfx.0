Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DBAC53219
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 12:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C931410E902;
	Tue, 28 Jul 2026 12:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M7h71N/Z";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012064.outbound.protection.outlook.com
 [40.107.200.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3DC310E8E9
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 12:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIisbK3oVkZ8qCjUh9aJLppiTxQDQMwW9B0EGrjdNSXBTVK22VjyJ9QZd5tY9B2v3pBbxrR6zMzFWaZbBzQJIubHvhRHFLdMlfa2dp2m9/TKSVYiNTA6LcSQc65BW4XhAFQK9IeYmQ7iieEOFfGpxrXB8fYLxC/bDSZf93i9Phk3mjaiXNT4KZ0aEUFOVJXf76ezsxQTijK+NK6/9UMLZrpWYOpSOc8Y/j4jN6fvU8gi331hs0QY5CCnwMxd/tCzabvHfdebFiT9k5iFusCNHqZmMvJv5ZlML9E2GXse9CKOKWKOFgEktoGCcovt35+t06RN28bHkoshRZEa2JzWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laDMFpZQHkornFfbi8LA8tkYea99+EQiAPlNUJDtWN0=;
 b=URdKdjYvz0b6/VfwnH4FUrOAjWliPYo6L40gXO23Kzid/RgdAGVkAdpyNfCzUYFwVZ4o5KdbeLQBaSV4kaRCx1PT7c719TJ+eDoG1rAwFAptypWGbwWS3+McM1euB1Y3aqzkxad4MrKqFUJskJltN0p+G+zO+HLl22LAZ0edBoOkH0Te8OveGhzv/gYxPw+m7ALh60C0K+Jo9hVTL/dGd4RPeEMgzmz/k80tkU7U51GIqoEKU3aREaiKApiZkiXrx0w63pRQfXUETR6gD7BFqyRXtk8Q2Xee73/V7aaIccePTAYlNmxcRAX36Bv2xV4BdEPtkpiZ66NXhgR3OGmXMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laDMFpZQHkornFfbi8LA8tkYea99+EQiAPlNUJDtWN0=;
 b=M7h71N/ZCeHqW+3M7zcm9M0SCPihuLldOFS/MD7JnpZ2Ap8m6epQMB7Cd6BBLwlhhtfZj/rsstA8UHu9JsDeQ2yvbqqLeieRR4Y7l2vOdRECpeKt3GrMi7Npe4HP4doapIYmelIreg2ddHbxx3ZdMThbjIYQRCj827KWbZyjYwE=
Received: from DS1P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::6) by
 SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.13; Tue, 28 Jul 2026 12:53:50 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:8:242:cafe::ac) by DS1P221CA0023.outlook.office365.com
 (2603:10b6:8:242::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 12:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 12:53:49 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 07:53:47 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Michael.Chen@amd.com>, <Shaoyun.Liu@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: enable rs64mem for kfd queue
Date: Tue, 28 Jul 2026 20:53:36 +0800
Message-ID: <20260728125336.213531-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728125336.213531-1-Prike.Liang@amd.com>
References: <20260728125336.213531-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9b871b-9560-494d-e527-08deeca74552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UAUje7eUwilj3sgBf8QiJicFp4JJKRI+R13X+Zfj86lmQbVCtbsr5vYVthMSSC8ktUS4KE1dPFy4NFQDLUb97+o3RW0uA+yzQ8b5DIKo88qloVk9dnFQuORFEBFUo3YskWpEYliZQMxugZHiNC6+WP971YRHtTEg6VxaNJ7Ad69NVq5J2mhHp6X/M+lqLA7V40Ju+OR595vIltolm1IiiKKRA4lbHhINICTfu2wwN/WVOxJQHLPWgc0UEcwlX6vIDBoI3qJRUSXMiGekZzq4HHO2hlznvZ0w1fy9EDbpMTcZJy7nuSIzk+iIlrmAh1Utvwzke2xp47R63Ig4i47iu/NeWUPJRs6tlreDJ1+jy+tMcfLkUdKaB73vFcSb8ybMUt4m6LbSM1mY1h/loFtGwabP2qQAF2G0dQwoAKHsx5nMQgOkWh+1gUTiqLqmENFVW7fiEEo0BgopA6qYuZgFVVyFzrhur8tgtOvm4nQP/HEqYwTprV50cldRF1VSFyIMWM4JZfd621nTVTIkBynwVkAJ74Zzqgd8sUJdXYI6v8IVxHMspqGOoguz8MPZ1l+Z98urNcBY6969xRKZ79kZU5YdP0p57y4xrovxCIxsEbheNPD8UqOk7srgkQ7oWl0hVfE3fzA+k1ykLJBwMdt0AwK+uIEelqZN/ybuHOLZY2astc0eKKDHIBFlEFx7gLsWfDm/3Oeq23Xzd2EEI3dvrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bc8xBlZ0YsvFqgOwKyKswfkF63UUaFmkDMpFFteonlE2u7D8R4y0OlhndCfVtYn6b/e3EZ5mmVw0JlR+ntS7gurYwmiDoDDy9873fI7waEk736jZ6IZZUvA9WeXQM3tX5nvUPPKznLaTc//PT+c/i1/u4vdR8xTV/R7eKmQZXQ89JB3m9z/EE3180S1ZRhCL9A3klYA0+QHNDRYteT8XQH2bb6EA+5JwpqvIb9wYwDGqc9J84BPvkRN4Jhvcr9+Ebus8sCrUlARg8OSMvH52hLaE5j2+60pe8KzAoY5Ag9PczbjQuiGnla0rZvbXPN1YkNfsihMxb+bxo+nx+g5IPNowSxJ4DsWgCtC0DOLa0wN0K23icBQfldawe5moOXAE43Haics7fpFBJ1PXqkVspe4byRn36PjWOLAKsbw6c/2UgHkLGzNDYZqajFwtQJGI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 12:53:49.9277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9b871b-9560-494d-e527-08deeca74552
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
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

Enabled RS64mem for KFD queues by integrating
process and gang context index allocation.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 25 ++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 +++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 51ee9c39104b..ce0ca3445ccd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -210,8 +210,10 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
 	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
 	struct mes_add_queue_input queue_input;
+	struct amdgpu_mes *mes = &adev->mes;
 	int r, queue_type;
 	uint64_t wptr_addr_off;
+	uint32_t index;
 
 	if (!dqm->sched_running || dqm->sched_halt)
 		return 0;
@@ -265,9 +267,18 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	queue_input.vm_cntx_cntl = qpd->vm_cntx_cntl;
 	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
 
-	amdgpu_mes_lock(&adev->mes);
-	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
-	amdgpu_mes_unlock(&adev->mes);
+	if (mes->use_rs64mem) {
+		amdgpu_mes_alloc_proc_ctx_index(mes, &index);
+		pdd->proc_ctx_array_index = index;
+		queue_input.process_context_array_index = index;
+		amdgpu_mes_alloc_gang_ctx_index(mes, &index);
+		pdd->gang_ctx_array_index = index;
+		queue_input.gang_context_array_index = index;
+	}
+
+	amdgpu_mes_lock(mes);
+	r = adev->mes.funcs->add_hw_queue(mes, &queue_input);
+	amdgpu_mes_unlock(mes);
 	up_read(&adev->reset_domain->sem);
 	if (r) {
 		dev_err(adev->dev, "failed to add hardware queue to MES, doorbell=0x%x\n",
@@ -287,6 +298,8 @@ static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
 	int r;
 	struct mes_remove_queue_input queue_input;
+	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
+	struct amdgpu_mes *mes = &adev->mes;
 
 	/* queue was already removed during reset */
 	if (q->properties.is_reset)
@@ -303,10 +316,16 @@ static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
 	queue_input.queue_type = convert_to_amdgpu_ring_type(q->properties.type);
 	queue_input.remove_queue_after_reset = flush_mes_queue;
 	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
+	queue_input.gang_context_array_index = pdd->gang_ctx_array_index;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
+	if (mes->use_rs64mem) {
+		amdgpu_mes_free_proc_ctx_index(mes, pdd->proc_ctx_array_index);
+		amdgpu_mes_free_gang_ctx_index(mes, pdd->gang_ctx_array_index);
+	}
+
 	up_read(&adev->reset_domain->sem);
 
 	/* If is_for_reset set, it is a mes internal cleanup */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 88191a4c1657..c1bbae9e6e82 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -871,6 +871,9 @@ struct kfd_process_device {
 	uint64_t proc_ctx_gpu_addr;
 	void *proc_ctx_cpu_ptr;
 
+	uint32_t	proc_ctx_array_index;
+	uint32_t	gang_ctx_array_index;
+
 	/* Tracks queue reset status */
 	bool has_reset_queue;
 
-- 
2.34.1

