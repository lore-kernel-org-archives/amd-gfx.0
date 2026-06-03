Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FF5CD6E57
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35BF41120CB;
	Wed,  3 Jun 2026 16:34:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JnXuBCxt";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DDD01120CB
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iw19zSmAga0yidc3pHaBhKJubnEmU7vwFLIvpt/DjX6w0jUO9fPUXMDAIUcKxlP3tAQkrAqEdRvt8ooIZ+jU7RHxf8tn83JAmd23zfErmDhkHKaMt7mHnyimrenoALRqyXJOLF74DsQZ4M7lnLbty2g1fErzKXmi8OB0PpkcZtJyeABuCGrEG2UrD9dIySc+rM1iSLVF8X/kqpjzukpWaRMKadmjRs2rB2KLGBPqO8s1sTo8Uxk8MHqcynJrAXrbWJb/f4vinx1EOUD7K/ij4DXVkt2K24sN4tqQHG3n83OPsxGnEgv09KgZI7KKee1D0Bg4qL63vi49zFVlTr1AdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RWzj6wmmf0rGY5o2E3z3YsoXdRG9rzWJHL8pCXtSDs=;
 b=dAFDSHQYXUlayGIMzcO8X4/LeqXnUHBpIcgTHS409VEdzvT+pRnMV88wSmU0Fn9WteF0yss4ZERrbZk7yWdM06nz176tZo/+noBenpE7oPro2HKg+D4epqQaaG72QuteBK84bQAFhx2ByGSmFN8Xlx4G4+e1wRWmmH9QCQl09chj36MH22GXRH/mdrUa4Amsa9Pq5vqDMmINQ6eT0iaK3lRb+QKje3KEFAOP5UlM9T6g2dCNVB1J41f2ChDZjRn8DZOnV2q7NJsO0Jg0syM6O8ncjutXEoc6ncLIU02F2yomvv5cB/pLyLbMr8H6RTTY+jNknot10VMSK8JnHqxJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RWzj6wmmf0rGY5o2E3z3YsoXdRG9rzWJHL8pCXtSDs=;
 b=JnXuBCxt/PWsi6DS9YFRnJbiVFwxsVIMrtjJlXrwrIgG6ZoKAYPwD0fVwuH62NuUgJ3tKnmvEZYGwFBmvrXjMUt1a8V6O4cwIVSQPGqui3wONdaNNxwteiAZiZ+H/EjpYJK5N0XmCrCI4ELUIo8sxu0Lg6eQgBEp7OoL7/z1jcA=
Received: from BL1PR13CA0349.namprd13.prod.outlook.com (2603:10b6:208:2c6::24)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 16:34:24 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::66) by BL1PR13CA0349.outlook.office365.com
 (2603:10b6:208:2c6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:34:23 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:34:22 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v9 09/11] drm/amdgpu: Signal QUEUE_RESET eventfds
Date: Wed, 3 Jun 2026 22:03:48 +0530
Message-ID: <20260603163350.2678309-10-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
References: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 58933566-a2a5-47c1-03a9-08dec18df8a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: njl8bBHjkB3hxSOl6iUmMqiTFzOxIedtOUzjCVvNolurMgjsOQBJWL53tfDGZH3tK8q+AXLrZDII6yWrbm1w2ePBLEZSWCp5oRRMaemzvMF+u0v9huUDzhjEKsCl7eMcZixJNHRcLpAWUygjQhMly2oGUn5TyCd7oF8Ozm+8UymJzsXpct/ubKqmhqMg87FXXuLjjbvm4oD9a+I14OaSVA6hwJ9eHj/JCKDGk+L9uJOS6v7L3tFd3ZAOkZOMv3sL3iOgeuKTe5yhPnKSRBnToAGvHo2BeunocPDiqt3Sk1edD8JYsXAuhrLYPTeKUuueSTOfgEeOMEgF1FSWZoVlvLEoPpTi6XIbPD2qJS304yAG4JE/uOlziBnq9RXGioQAMsd7alun0tfzn0684KZ0eci/bRt1aYRutFulH0G7i/JdabwbfYBXEFSML19X2Cz8Qa0ngI9Mf/IExgQhCb9Hl6ZYaTwkkoV5gxHEWIHwPDosb0RoHHELO/pCDHbYsnlMBytTwdIklQ3IkCahBoGE8pGrYTKs2BRP5nxPKBwp+BY2HLCZz64e47PRkTV4tJUhFPQIq4nTzfxahRqUaFasoGbM2lQrgU1bl253O64Qge2Bq0fDzV3Z+vC8cz/tVlEwziIN6YsmfDuV5OkJZof1jz1tAtkJdJJ+N4WokaW/WCXCxBRpzbOhwhj/wS7HGLq3vqcqi3KrhnA73VtVRoX2xbPhwrzBac3NLX15qwL9Xqc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aeyV6fPvYvd8PzIxJHz/Wcto1qH8V4nU2guLHxMaR3T7U0dsW/wCroXrIeAFZ5HR/tn6nmN3EF+UAYEHKv5XKSvSFpZQ25sr7QJf8B8Z7ZPsqxprQ8GyhMbhEyqx/xwH3p3oZIGHur8y7Nzzv+RDhGuUx6a2ooRQ8Q13s3CG02o8Ue9nIJAP6o4HUvmNgJFprKZx6D9qeZqS38kIMP1USL/9nA7JlWIk4PobIYAlTPpxjUkvQY2xygVfZ+47Rs/c02fdwnY+MzAoJMYqMw61eYhh6qdfHtREIMs/Db1QZNWd9YFYLddrawTf05fhu12U6yn8Zinb3sxBABdpQ3kcfEhnT7q00Jhm76U0v/M4bC8pMtUbgzGYl3e7ZL9uK27ZfRCZ46f1bT4kQbtQTaenmOJoe9mbMDIqW5wVsZlB4BLlMYIEzMHliClvlbObZbi3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:34:23.8731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58933566-a2a5-47c1-03a9-08dec18df8a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890
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

Signal queue reset EVENTFD subscriptions when hung user queues are
detected.

The user queue reset path already identifies affected queues and marks
them as AMDGPU_USERQ_STATE_HUNG. Reuse this point to signal queue-scoped
QUEUE_RESET eventfd subscriptions keyed by doorbell index.

EVENTFD remains notification-only.

Changes in v8:
- Use queue->qid instead of doorbell_index for queue-scoped event
  handling (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I30e31c6bd4504f308b001f8e92bdcdcd4c854274
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index e9189f07c6dc..90945b078248 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -239,6 +239,13 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 				for (i = 0; i < hung_db_num; i++) {
 					if (queue->doorbell_index == db_array[i]) {
 						queue->state = AMDGPU_USERQ_STATE_HUNG;
+
+						if (queue->userq_mgr &&
+						    queue->userq_mgr->eventfd_mgr)
+							amdgpu_eventfd_signal(queue->userq_mgr->eventfd_mgr,
+									      DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
+									      queue->qid);
+
 						found_hung_queue = true;
 						atomic_inc(&adev->gpu_reset_counter);
 						amdgpu_userq_fence_driver_force_completion(queue);
-- 
2.34.1

