Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF75CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 08:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 040BE10F60F;
	Tue, 13 Oct 2026 08:25:37 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011064.outbound.protection.outlook.com
 [40.93.194.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB6E310F5E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 08:25:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvPDB8zyn+EUiq6n9KD1/I0hF168atrJUYe68hUHEgePHGzuMXQMiuJ4SARz8a2B/62cfzEWdGOBYODsHW76LdWqX3N3tNBI2b+yABQTzaukfFK+FE+ZWp7e/p5WXyWWw9vIVJkmr7Q27D02+tghUyHX0uDBDo2b+FVYAJOoOyQIqZ80a0XTr1GdLg5s3ZWbraFU1VljZNuYCnsG4qaO7yciqHSKQ4ZgQxxYkafyElBRm3qGld4G2tOhGhQOIS54F28ybICD2cnmv3nReDBkEHVXpXJw/oLDnCZqJLZIq7gJlq+iuJFT6YGe+ITyP+SzO7laJID3cl25RNLoDrD7LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXISM67/CRyOtdWCLTfvlDlTox/5NU4GK4DmYXmiKwU=;
 b=l4EU9wooqspfDKzLnGgKBYaFWeoj7IT7Ma/epSjBp+krm2H9Y+7kHoMkWjobYcyM5pceKnXrAYEcwXoRxHB6hNylvT5aB16HtASJ/3bMTigD7uXmLRR+jStwTn/gV7z1HbAaqFJfy0YXWX8jfLh+2hlQ03Fgf2mfOu+7yMFCzRix3hG+RkJZoD2BT9tF1VQkTvj6apaPCTZ/fA0o+QgmRXvJtDgoFagwkXLGg4KYUfE9pP5QjtbpG+soKR24mmZDJqG2+paOsg+pzdD6kS9uoMMeTmlq9uluc5au//qobhdfcZSmsoiNmN/Z35etyDdrgA+QSgo3kcYI8T9WRgTewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXISM67/CRyOtdWCLTfvlDlTox/5NU4GK4DmYXmiKwU=;
 b=K2RL9S2g7b90ayejJX98m1qtNnSCoplNzwAvdxSjU0d5OmC7fWVvsLZJadGDK7qJGVaoHaayn22To9RvtJzX2EOQXQIoKkwkEqt62ddwnZZnYhYfKfdOEap5PUjaVmw1UIMOorgaTE0/+wWuvdTVxnHTAm6KN9jjYZFQmP6TgRI=
Received: from DS7PR05CA0025.namprd05.prod.outlook.com (2603:10b6:5:3b9::30)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 08:25:25 +0000
Received: from DS1PEPF00053451.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::76) by DS7PR05CA0025.outlook.office365.com
 (2603:10b6:5:3b9::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 08:25:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00053451.mail.protection.outlook.com (10.167.23.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 08:25:25 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 03:25:16 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 8/9] drm/amdgpu/userq: take reset_domain->sem before
 userq_mutex in create
Date: Tue, 13 Oct 2026 16:24:56 +0800
Message-ID: <20261013082457.2492273-8-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013082457.2492273-1-Prike.Liang@amd.com>
References: <20261013082457.2492273-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00053451:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: f844f756-d30c-4d02-aefe-08df290387fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +YR27I2W74BwfQ2X3LsiF6zhjQYiJmMJwEfpJmiDKnETPGHHEyhI0M+M0Gd027EWQP2uC6F9SFjM6yuXgoUBd7s59yLGTzHNNhxceMeO2UT0f5t4iWxmfXDZgAL22zvQxBg0tIkHYaxKHtPZ++9YZTt4WVAUgg4mQWc94ZnUGYQAivDzgyNMxu8exdKfkUxTo/YCvJ9ymJSMJnkXPweGwGxnTvQAnb53nLRSLSzVog9zjXY1WLUhGLiCTqbcKGiqY2Q7K9HD47YXijHDVgfBbcRex/C3QH2IrWllLKu3DsQQcuUEkG+TuMEELIBklHBvzr10gQ2BTYF5BZ+yIvWIcg5T6BvSVYRI0Gd4CwtuTR+qwOVSTbUDzR7tuCHFdxVA5y9d01gRrYdLYOl9AOgF2/QX5qcHdJsh6T5YlVZKtCWH9A4Cjx+GPHsLL+MvhKIqWgfgsUVworwd1vnJ/tWGKgepCHhLocXYq2RkNwHoeXUbPf6+rDlQ0J1Sa51I2Yo9hHvGg6UuCS3ovv9yqMa0h7AkTK51FvQPYURvmOmHS7eMaFE4UUSAMU25V0ZaVQkwmM43qzQlAKGgKw1X8bB/0WqUs9APbdf3JcmKPSd7iulQQFbljLRQyb8LyfoUlR/6RZnToF15pcZSnRtSllK1L/7ZpAtnF74gtyClIivG1dd0z6jyIL5eX/dQWZl0Jko8Y95HI5+BxseBohpjwrrq7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3X5f+H5bOiQf/kFHmMydHTq/18HLMH03Z7kAqRJNai1+Z/XUCCOTVt9lGRs8IKLhkIc3pXGXwGvXbUYmP2RGMIPtmWEjQ6wGDKQKKv6OXUTH8NMctzzDfCyONvLVrO5kU2EYgqPUesv48vhsBumfbzEz8PjxDsovLkYFXEb++DSRVAwOZbf4PUnQtfHWwCd69t8vuBasykygBTw+RLgYUavbES9u2lTp+4yYNKk16aPgPTAEM4K8cnjYLczIOn1Y3pDqVyhWIpHRal7DNy39Sgyp5mI24n40TSIqAiQaONfAl0aHblOzP61FIPfNw7UcIKc/F87B/ky+djZKWJLKe2k3ZD6nZh/geCJzw1l8c+FIp7UVoG8v5otnOHPsM57eDtwYA2Pp+zrC+UUPb/pQhyOeQZshWooEIHGCbHcjSYFFEbrM2LwpORrntWbf2zds
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:25:25.2162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f844f756-d30c-4d02-aefe-08df290387fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00053451.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799
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

amdgpu_userq_create() maps the queue under reset_domain->sem, but
amdgpu_userq_ensure_ev_fence() returns with userq_mutex held, so the
semaphore nests inside userq_mutex. That is the inverse of the order
used by GPU recovery and lockdep reports a circular dependency:

  Chain exists of:
    &dev->clientlist_mutex --> &userq_mgr->userq_mutex --> &reset_domain->sem

userq_mutex has to stay held from amdgpu_userq_ensure_ev_fence() until
the queue is mapped to keep the eviction fence valid, so only trylock
reset_domain->sem under it. If a reset is in progress, drop userq_mutex,
wait for the reset to finish and retry. Hold the semaphore until the
queue is mapped or its doorbell is erased again on failure.

Fixes: 44fd81554cc0 ("drm/amdgpu/userq: serialize queue map against GPU reset")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a34ea8ecd700..817bd395d2f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -748,18 +748,21 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (r)
 		goto clean_mqd;
 
-	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
+	for (;;) {
+		amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
+		/* reset_domain->sem nests outside userq_mutex, so only trylock here */
+		if (down_read_trylock(&adev->reset_domain->sem))
+			break;
+		mutex_unlock(&uq_mgr->userq_mutex);
+		down_read(&adev->reset_domain->sem);
+		up_read(&adev->reset_domain->sem);
+	}
 
 	/* don't map the queue if scheduling is halted */
 	if (!adev->userq_halt_for_enforce_isolation ||
 	    ((queue->queue_type != AMDGPU_HW_IP_GFX) &&
 	     (queue->queue_type != AMDGPU_HW_IP_COMPUTE))) {
-		/* Serialize the map against an in-progress GPU reset (MES is
-		 * unresponsive during recovery), matching amdgpu_userq_detach_doorbell().
-		 */
-		down_read(&adev->reset_domain->sem);
 		r = amdgpu_userq_map_helper(queue);
-		up_read(&adev->reset_domain->sem);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
 			trace_amdgpu_userq_create_end(queue, r);
@@ -770,6 +773,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
 	mutex_unlock(&uq_mgr->userq_mutex);
+	up_read(&adev->reset_domain->sem);
 
 	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
 		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT),
@@ -791,6 +795,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 erase_doorbell:
 	xa_erase_irq(&adev->userq_doorbell_xa, index);
+	up_read(&adev->reset_domain->sem);
 clean_mqd:
 	uq_funcs->mqd_destroy(queue);
 clean_doorbell_bo:
-- 
2.34.1

