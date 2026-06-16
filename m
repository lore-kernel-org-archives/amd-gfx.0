Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E8FCD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 11:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 483ED10EA37;
	Tue, 16 Jun 2026 11:13:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zM++YEI7";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013021.outbound.protection.outlook.com
 [40.93.196.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D957C10EA34
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 11:13:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5uYe442YVhv+oJqhyVUD2aIKDmfHBbLeNqmPE+1BEd3Ki9y4mwrTE0kd7SIuXgG+N/mQ3HOew3MDJaoNmYDA2TrMDWZjmzQ7CoUi6fHSlMztp5O7QbOQU8lltsiaLP/SvlMa/kN/G2QvfvsrUU4zZKYEQXRxGji0uDiH7lWdT+6DM3bvRLWrcCVlJaovNsmkdMNKeR2U//rT8jEfL1TgQzhcpKRjYLVqDPYUYEBbzOphmf++Ft2x4df8bKnv0AdjzAQf3V48zRAfU/rS4fUlgvORMs7zoSWWj1lDvP+jh+z2Qd4FiPKtCj/8vGRRQm9JuAGwYnw8Fno+mCD/Owlrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=325BzYfO1tnkFOojNtzLDrxDQPmGmmEbqO8ZsPqaaC8=;
 b=UW46NQbRSutvfg5vRCCJWiXiYp9l623TGZbvAOSv8QSNXu6YRvCev4m5UolFp4Ym3izNL8jAU3qBb6IG0081vEx7uzeVGDldqmwAlCT64y/zpQ4PHm2IeIM7a82JtAndKTp/F/S4SkSn1AZCPAoewiGMiYrNsTu2d1WVIJ920gKkGYpVSKAvmV8rA1/xgy+XJSCcOG03GsFu38F7AQ39ydfdhKtXgW4MHgJjklgNgs3a5Y5lCH+sV2QL79gp/2LMajmVssLfFRAnxzsX47CmL+BGRVoLU+5nSGMrK1uc3/gyo6IWjJxAXPf0lSL6IGNNtADm0m65+gMHJEcMvVOlAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=325BzYfO1tnkFOojNtzLDrxDQPmGmmEbqO8ZsPqaaC8=;
 b=zM++YEI7A1rB6jBxlAzK3r8fU+olPH8KfowfQgEwma6gXowTVc3DSayvZiA/elJtbGfOEUcwSJ+ptyKtpCE60UB8YQldH6Uaj5RWi8+m9P9w5P5/Hn172wVgBTAPOEo0Dgq0UC9vl82d5GST6aSXAMevWcKzfYicChmSUYVo5ws=
Received: from SA0PR11CA0205.namprd11.prod.outlook.com (2603:10b6:806:1bc::30)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 11:13:40 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::2d) by SA0PR11CA0205.outlook.office365.com
 (2603:10b6:806:1bc::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 11:13:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 11:13:39 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 16 Jun 2026 06:13:37 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 4/4] drm/amdgpu: Remove queue-scoped WAIT_EVENT records on
 queue teardown
Date: Tue, 16 Jun 2026 16:42:42 +0530
Message-ID: <20260616111242.2922144-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616111242.2922144-1-srinivasan.shanmugam@amd.com>
References: <20260616111242.2922144-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 7277ef0d-abf4-4247-1ab6-08decb98516e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HEGFx8YvvpJRvtwaVm8dr9ehqQ7eZ+R+ixNaKct1Hu8uHmZNzCq97cMU4dLuM/A9Vwl9ri77jrxAlGAx2GbDmLI4X5xCsqCx/oAazx/eAl46Mn8SKtOvggOs8iMcofcZEgCLntm9xE6gQTw3tVKJflgwb/bqvJtOo054mIov+0vpFce0Vp71AZEwnnQbMjz9DzLpyYiSiNdr/s47i27z5SnnTphIeXIVOAH6iu8xSfQYgWZNQSeJwWV+0dIYVimBRspEUd6a7IgI71nsSanbJNBGKvlkB9crNGCQgqBfGvLf+2QHWHH7uslEIKuR9g/0SpPZuKF8szzr2QIsJy9KG/P/fdcybdQSIg0y5i/Atkvfr6sOhcxKjqJuJ+STEhqeawlipoyoeIWjVxqLoGwwSyjbo+MagiFQ5D04uC4FEUrkUOZul9WpC89VdgHPeV7moBNiVQ9kXk+1QWTbbR8v5ZZdUku9cwyMAU48LpFB3cjPCwO90azkXjpZMWUxDBqhMwp17U6PrZOi3WuSSA9yjT45mdrVPJLYvLk76Pct4AsRmXwRqkJEsD1wMm2y7BMuxWMobKRI4yZCZs79N3XemB4BbbvsH6BRk8VBEmZHcYSdQhrnFS/Do5nW6yA/ajB+htW8EMtbwYwA2tH5LojE7eMatv6/xE7RIEPqEj/Qmr4LpQ6H50mFwghD38MMMz9UXIPLD/Aet0KytCYzj5/ndsP6P7BCCo9xxo6DoDXIWKY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jeFzNIj3j9GKsknsI+pG4v5MalRyJjtS6N7K1Xojvpp9AQC8ddFMJ9ZX+zMiiJjjmdJuvfnh019nroFkjXMBXXluKBc+wOjNAFldMuC5qNHNhcTu93OiNlmgec0X56+9jbYntAjuL+LpSJ07HiF5vSDgiFsIzv7xTLOefyU92l3igVXsiSAYybVfgBPitqo8gdcWiO2dWiZwXH6RejPlLhkwJK1NnmFPw51ETdMd4p+1PtRKsSHP8aFuQMCRVr64rEIGo1plzqfNSQ6jVJPnwSWYXrS7QrX/v7ajRd8T5CWJT7euvKspxrsUY7OMKSdGH3JszU+y3RiOpbPivsBLF/149g29eUjV+4ngv3qFCBn901E4Iz1GZv8N8gK5mlut64U0EBFes0MBdfe8Hri3+hYzF5OU2UfhYIoMUqsoOppibFLiXErdcsrO6s0rAo3E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 11:13:39.4164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7277ef0d-abf4-4247-1ab6-08decb98516e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
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

Pending WAIT_EVENT records for queue-scoped events store queue pointers
and own queue references while queued.

Remove all WAIT_EVENT records associated with a user queue before USERQ
drops its queue reference during queue teardown. This mirrors the
EVENTFD queue cleanup path and prevents pending records from keeping
stale queue state after the queue is removed from USERQ ownership.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7f605501c84c..43fd60b1dc6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -54,6 +54,24 @@ amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr)
 	return &fpriv->eventfd_mgr;
 }
 
+/*
+ * Get the per-file wait-event manager associated with this userq manager.
+ */
+struct amdgpu_wait_event_mgr *
+amdgpu_userq_wait_event_mgr(struct amdgpu_userq_mgr *userq_mgr)
+{
+	struct amdgpu_fpriv *fpriv;
+
+	if (WARN_ON(!userq_mgr || !userq_mgr->file))
+		return NULL;
+
+	fpriv = userq_mgr->file->driver_priv;
+	if (WARN_ON(!fpriv))
+		return NULL;
+
+	return &fpriv->wait_event_mgr;
+}
+
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
 	int i;
@@ -874,6 +892,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 			return -ENOENT;
 
 		amdgpu_eventfd_remove_queue(&fpriv->eventfd_mgr, queue);
+		amdgpu_wait_event_remove_queue(&fpriv->wait_event_mgr, queue);
 
 		amdgpu_userq_put(queue);
 		break;
@@ -1244,6 +1263,8 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 
 		amdgpu_eventfd_remove_queue(amdgpu_userq_eventfd_mgr(userq_mgr),
 					    queue);
+		amdgpu_wait_event_remove_queue(amdgpu_userq_wait_event_mgr(userq_mgr),
+					       queue);
 
 		amdgpu_userq_put(queue);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index e1a7d0dbc436..ff76241a3446 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -182,4 +182,6 @@ void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 					struct amdgpu_bo_va_mapping *mapping);
 struct amdgpu_eventfd_mgr *
 amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr);
+struct amdgpu_wait_event_mgr *
+amdgpu_userq_wait_event_mgr(struct amdgpu_userq_mgr *userq_mgr);
 #endif
-- 
2.34.1

