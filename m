Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA62CD6E57
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6BC51120D5;
	Wed,  3 Jun 2026 16:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gcbqlyDW";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 402A91120D3
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:35:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvowRdj4/u1nXxtYwrXQrbFaIj6IM2Db8YvsM+o/AhCwQm55nSmkvPU9fwO3J8nYOAy+g+OA8nui/R0DMrx3tE/2TTc4G+5DI+S+of/NW/acXmVxKr0PNWDcBdHgVvIEVc3DN8WyZz0ONCW6jaVJgb96As4G9YqZw+GFn85FhH7xbn8BGg84cZrhPcBrJltmOHaMn7X51i0ZVXUj5FACKE9dPaYq9J1qi9e/Sgbs0v8Qi9MvOKFpX06CSASSX++q0jEJELMaE9Pu0tkfQwzKBa48tL5pCbKZK4Ae644k/eKFvrDdsjnSdsv/L6ktR+/L6NWJtTqVkranTAUA/7SS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5GNx0BDv7mbiSFakpOXfmGSpJF3r4qP/55OK4Cvm4k=;
 b=xc7gghMjsmz3jaQLv00n2hS0PunlylqZe9uSeCo8VVcSgFYTGdKFCSUfOyhkmiQzmmL8IAdLLCH7bTv8Hz060BmaVnrb40BVScl4zmfGUt6HxaTHEjV55tMWerMMkahXpktkMhnHawcIJ+Xjb+yJJ8MbLb+mqckfW3MxmS3ffYBL+/GcQFaJHKoktC4MFa+cIRz6caf9frlIj9CoEufgy2DddLuaK7NrqYwd0DrN823gf93f3BGTxOtv1YXGsOtUt+Mlpf1JmFkdwU3ticUjOLlSpLZLVUIGIC/J51sAMRKf6lVXNvgMeXlx9+nMUDqqeb8uZxzhPcLdPppVe0/wkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5GNx0BDv7mbiSFakpOXfmGSpJF3r4qP/55OK4Cvm4k=;
 b=gcbqlyDWv0h4pw5T42cDfCBOh1TQYZPU3fTb22AIFNFtoIJ+N2kxiatIgfo0S/fkg/YYbgZaZyUvtZlMvlerS2le+RQxhYrW8o8TVrkLVxzW61GH9bmF2YKJJp13OnaUTPnvIOkcx+BXDD84e9fdw0urytKALahxWIRzY9g+ogI=
Received: from BLAPR03CA0147.namprd03.prod.outlook.com (2603:10b6:208:32e::32)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 16:35:18 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::8) by BLAPR03CA0147.outlook.office365.com
 (2603:10b6:208:32e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:35:17 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:35:11 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 04/11] drm/amdgpu/gfx11: Queue USERQ_EOP records for
 WAIT_EVENT
Date: Wed, 3 Jun 2026 22:04:43 +0530
Message-ID: <20260603163450.2678374-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
References: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: e819e8bd-558f-4ed0-58d5-08dec18e18d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: YfYjclZpbOCqI5imfh5jqxhFDOA6pfWZ8HLPyMT69SXibde7glnmrddAjph2nbi2xxfrzZrIA9xk7MUyDey3Lj9aDebPI37x2rkkpumGrIGYdi4HYVrrBRQ3ps7216msrrmE3c8VaRmHqtEA7wrG56+lI2Hwo1blJ+D3gzDTcEJ5hGNKN5uVklJegI/qz6KK5OdIDp22FLzq4cmI7Lg56zHIdmRM3lOvRzquKXFyR7mq4Ob6QnrPXpvK/hOVsE8oAyxV5SdMi7TtALteQWO+ejpw4fpMInEfa0O95GPut6twApXHzuWFFzvp1y+O51c9dZJtSivnlfr6c2s0i8FYv+Q4Im0hvRgeYUz55t3k3EYQXa1xs9Ixtelq1Mt40mlW5mAdV0ERDUidvsyEPYGMB48YxYVoUI+NVbT5A9gsfZTCZYT6GImht9ORMcXPQyQ9jfsbkOxwv6UGKdOaqdpcxbVKOvPi2WdpU67sjysPuAq+wdbDATb7zEBxvSaJE1Z38UCPjGj8WOQm7Y9rI1oBPx0GZe1I2diQoTKZyk4DW5ESh0Yx9ArYvJZdacPiqyjLONSpfSr3JpWJOZ2srSfDfWA05ZfUq7qalIwQQvJTvbIttnbTlsRRLSA6/jUj2hBr42+fBNJSlCOHWyYMZLKp1Wf8coscxWQdz3u1VI4VnKuL7G355hTCmGloMWVd07W/QDOW0Q+ZLMenCwI2+SA2x0gWbhkl92eRAIsEzBZN3Vs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AQPjBx82cRCMUv01ivZHsKf6bmO0N+SkGVC8gqZaE/giNYjbrTJ+rZE+5w5x7qJK+vyDK7rH1/MK3gMS+DYWCnxjxlx8KKdOQSmxyGw+h6nZHgRn/+WINWfjRq5r1oJGqc6GWZAI9Fos7R4NWsaqXX7jBlY6VEwH5IHEN3Lf9yxlGanKOtH18Au+PygBcyYRYsY5Cw7XPW/6NusOcIh9+5rpTGUG+pvIQkTZ1TX41VmBQIabdkrgBH8dbEHe/YiFmJDSNwIbp9VXvOck7hAo0PWbREu2lpc8UvJ82JbvzhlKfYXYfRvvyJCURZBAqrjI9vzeyKx9nSf4hiGEgRvGcc12s8J+V6XfAigiqhAY0JipoMx0UAgf+PxtUFVPhu+Q+9+CMDk881yQVSOOzhcSZDd9oShFVsPR5/Dpwfy8MujaGU48+HqJdLBAt3BWAW91
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:35:17.8571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e819e8bd-558f-4ed0-58d5-08dec18e18d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
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

Queue USERQ_EOP event records into the per-file wait-event manager from
the gfx11 EOP interrupt path.

This wires the first producer into the WAIT_EVENT path.

Use the doorbell offset as the current queue selector for queue-scoped
waiting. This keeps the initial wait path independent of a separate
logical queue id definition.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 4ee53178cdea..7d737d55c817 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1185,6 +1185,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
 	userq_mgr->eventfd_mgr = fpriv ? &fpriv->eventfd_mgr : NULL;
+	userq_mgr->wait_event_mgr = fpriv ? &fpriv->wait_event_mgr : NULL;
 
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
 	INIT_WORK(&userq_mgr->reset_work, amdgpu_userq_mgr_reset_work);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 3941028af4a6..66ef69311205 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -129,6 +129,7 @@ struct amdgpu_userq_mgr {
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
 	struct amdgpu_eventfd_mgr       *eventfd_mgr;
+	struct amdgpu_wait_event_mgr    *wait_event_mgr;
 
 	/**
 	 * @reset_work:
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a47e8caf519a..1bd1eee77262 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6500,6 +6500,10 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
                                       DRM_AMDGPU_EVENT_TYPE_USERQ_EOP,
                                       queue_key);
 
+	if (mgr && mgr->wait_event_mgr)
+		amdgpu_wait_event_push_userq_eop(mgr->wait_event_mgr,
+						 queue_key, 0, 0, 0);
+
         xa_unlock_irqrestore(xa, flags);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
-- 
2.34.1

