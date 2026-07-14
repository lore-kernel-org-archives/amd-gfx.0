Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4B4C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 08:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 307FE10EC4E;
	Tue, 14 Jul 2026 08:10:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hau31eBr";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B48B510EC4E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 08:10:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KK0YQjY+TEbmemEePsZYGfZw3jucI3fNMCIP7cOUK/oRReJMR3MDslw2EHCDfqA/sDjjBrpz6t/NAKoaiaIOQCdz4uaMl3ofxBSvjzxx6oXOXIeMKNhOdCckQdqzbhfY0qSic4pOxXf1pTUjQzk+nbwoQuypx3/VjE85FF/RltLECX4pAgx4dvpPxlc8Qgtslp679IKTwBPDTZEGMS6nRvliOe+TF8JVL5ecDWCAuqpsLi61tpCdyfABx1AXGqQzHcJ1qBbACI6PReOfkHRHqFB9ZQenAq873VGA8SYIE9yLgRCHMDhCzXFMvD9VmqoVdbrnxZZp3HMD7oF3jBzEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5mxMGIU06LHMXgEtZYQ7It9MSzLfJLLfNP/ATzCuZM=;
 b=p2+elUbxkLCnup8+nylDjlQqEB64jD7EksmlG4iWFtpPqbpaXvCuyDZsJGDq3sONYT4s5bR909q7rv0lg0VjSV1TXdAbbkWgtNCZG6DhDPtFXE2gz81QZGT69m9mTPKzIQOLKMxdUWoWpcPChx+wFg6aHaCKOzgbmigdCSTRtLR0k+O1yoahG/D0gRqkMeXFoGoQjjDWSE6a4BCOu5n79vXgGE6KJr1KClalzHPVdhd9O9wYNMKGWN89KSsKz8tw+X0//Jxtb926BAHU832FhqUzxn4losgZPkgBCkEuvTj1NlWStSA9wCqwoKxH6+59nn3Fn0fLYrC9PjCDRBkfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5mxMGIU06LHMXgEtZYQ7It9MSzLfJLLfNP/ATzCuZM=;
 b=hau31eBrBAyJ96PgAbuNiEQ0ztAyC7g0m6W8/8YHKrWzVS0h4CLhZw9qzoTy8e3HBq2EzJmIcgTFPkGxkB55H6BVnb9BP5v3hzzfIJevovC1YxDCmjGFmxyd3PiK8sc+JDIELDWom7a+ikIcBl1tOeXLwJlR0tb8SLTcg43EuFs=
Received: from SJ0PR13CA0101.namprd13.prod.outlook.com (2603:10b6:a03:2c5::16)
 by SJ5PPF8AECCE022.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 08:10:40 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::9e) by SJ0PR13CA0101.outlook.office365.com
 (2603:10b6:a03:2c5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 08:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 08:10:39 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 14 Jul 2026 03:10:38 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v9 3/5] drm/amdgpu: Remove queue-scoped WAIT_EVENT records on
 queue teardown
Date: Tue, 14 Jul 2026 13:40:21 +0530
Message-ID: <20260714081023.3395485-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
References: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|SJ5PPF8AECCE022:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c39349-54a3-476c-178d-08dee17f64c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LUjGnWCI5KfxvX/F+BfwSSk5anr2V8IxHDvNIvK2qdcFbQVtj4Zi4GNr0oImn2b95t0dKcpGN5XbvVU+8LGDkOmdjEqSUqEK3/9gYvFcOp+tQeZZT3hKtN8z9/OIdnhbx1Yeh5s5jak6I0pzN4Si0Pai5eCqYN2WVnV3qY77tuUxlDzcCweZE0ZD+PCGecs/g7QaES3VtA8hR4ThVRYy+aDYCIM0h8GTaZw0uRlnyVeq/f1d3SNYaKuBqXlIxF22ZdL7l1PDvbK+fvalzwywTUfQKLVvSH2wJ1NvfaYyrD9y9UrcF4AXXIVe7nEB2NqzkCCMIhae6vTheOKEhpStAQz5BTs/zSpM+9xTdP3yB24DWc8i40ys/cSmc6+33OU8x/FdTl6JnpKs7krK6v7b/XE5WLrevWKCcL1v4Y9cgG1rBK1K75xwa4WnHFnPoHpsrtW5JUIf4nizA0D92859L+ZpZAlFMspQHTsxrUTDj3bWr+2EpyQ2JWXUKwyO/Tok2q0URN4ganOsMHaQOM2PayTX3UAZAI/hZNc/trXQLFJT1nF6Pj8XLonGc+O6ZXGQwNHeDhfUuOIHZ0RXoqDs+zMi2gPc53023CeVyAIDePICD4Na1SuoJLOJ+zcDvkZLSccQQV6OxWkzR7c0dDabFe2e7ULzJIUkcnmsKVea5hV6UkBGpK7gVyrpvMYYUVbBiBSn3bdKcA5Pb6Kas4hmIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: udB1FFV5fg1VLiBil0XjrVBs6mHH+TW3wzIT4zt9rkZia70svAhL16/6b7C9MrLxpSdwNg+SScVRAaZnEog+kvrXdr9aMLTy9dTp2yrcMqUmjGCevPZKp5/wbKxY21Q/TtiQiioBaLvApvkJixPVGZcuqjGUUyjVdCkZmklEE9D52hNRz+FRxv6f1l5DCJnNORJdRB8li7HMXHjDCOB9dwmlUTttGnu8klzJqAyhBkRggNpL7bUUpkEtG2rrFWZHY94JHCVpT8jprlMLxdRlhdAXyHS3OKxr0dEIr/4E4UfsAaoh4Wdd4PGPAeiQ5uoJ5DwKgr3icho0NZGitspbfUWFHs8+ABz0cjoV03TU3oZCPLG1I0ZrKiZwWwr4EpdKjr/oTTKjRiNTH73y6o7eGosYlMrRMg0fzKXnvlG4xgQEXAJTjK3KVv/Unf6150J8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 08:10:39.9328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c39349-54a3-476c-178d-08dee17f64c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8AECCE022
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
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 65b20d7a4b18..aa17e55d52e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -56,6 +56,24 @@ amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr)
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
@@ -1035,6 +1053,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 			return -ENOENT;
 
 		amdgpu_eventfd_remove_queue(&fpriv->eventfd_mgr, queue);
+		amdgpu_wait_event_remove_queue(&fpriv->wait_event_mgr, queue);
 
 		amdgpu_userq_put(queue);
 		break;
@@ -1421,6 +1440,8 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 
 		amdgpu_eventfd_remove_queue(amdgpu_userq_eventfd_mgr(userq_mgr),
 					    queue);
+		amdgpu_wait_event_remove_queue(amdgpu_userq_wait_event_mgr(userq_mgr),
+					       queue);
 
 		amdgpu_userq_put(queue);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 526e007e300e..5d6d68d26c90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -204,4 +204,6 @@ int amdgpu_userq_input_cwsr_params_validate(
 	struct amdgpu_cwsr_params *cwsr_params);
 struct amdgpu_eventfd_mgr *
 amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr);
+struct amdgpu_wait_event_mgr *
+amdgpu_userq_wait_event_mgr(struct amdgpu_userq_mgr *userq_mgr);
 #endif
-- 
2.34.1

