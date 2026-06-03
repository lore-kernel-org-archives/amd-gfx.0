Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017BECD6E57
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 953501120E9;
	Wed,  3 Jun 2026 16:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="khMy8d8Z";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010050.outbound.protection.outlook.com
 [40.93.198.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B47B21120E9
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EuKXILiPlpbe2sqnrlw+5CFIeBdXbfG/+PqzfbHqcTWKpiYkh6o/Eblgst7OgSK4aJBjVfOrJ9B4d3VOH2ZgVyz7noFVjA4mdT7iXSU3DYn3u8A8vY86l1c1CcEqnrCanb2lElQRaIcV7qXCu7uL6XD4KwDWggnr5H09hapRTNGOfWey2D3iCzlIRWDhGHtHuM3XaDmmA6BRwZGSeD182scgf1gFcsoTYmcLObPxI+6cCC1BHAgV+15ego+tcYz9XMav5MGBDUeE99dd6bB8iatSpE0YFHy5LTBREGi5NSj5hw2KjDn7P8811ORwGp64qM5iVcuqJE5D8O7OcVYuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgEF/Vf0gpYex0sCtsNbUf+IWMevb/VZ78I53yxq9Ig=;
 b=xFGHwQkPo07w7Gq8tLrw1NJWqoHzDS22uHpOCVmUumdjYKrAb5U4gH+AEUomEpoV8oRZ1xxHdZF0Lw50mLEielFLBhS+xftSfQqhbWH1I2vt03KxCVDKF1QxO7ntpYoREKjmk+dwJo9Ph3Du3Kv0kXIiXJIwd6AIY9ZogqX6RnzJ99FIAMunp0pjKg5Lmlil0HiUSlJAirEYCWcgUBMPhLS6DcRqn/0z6iqKtxRoWl7KZ0hgUYw/7YHFoM2RyuDGQ42A9fXMXauppdTQm2Ss6oyqyNyfF+yGHrx+erWPmqqGF/oa1GomLhzTyjjjKWOa5s0lHE8l9C6+SkOVdDiOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgEF/Vf0gpYex0sCtsNbUf+IWMevb/VZ78I53yxq9Ig=;
 b=khMy8d8Zrt5u5TKK4b/drc4oIdze0fD4zPeOzD8SwEJ13AePOC9pmlZGrH/nXW5vrId5jNr13vDh0fH7AeYNgcvbmFxxYT6VJtyhFJylxLtvdZs0+U/VN3cCUgdD3Yqe42PFfsvEnA4d60I0Qq9EqWPARTGEMmbqO4A+5kgMTis=
Received: from MN2PR05CA0037.namprd05.prod.outlook.com (2603:10b6:208:236::6)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 16:36:16 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::51) by MN2PR05CA0037.outlook.office365.com
 (2603:10b6:208:236::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:36:16 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:36:14 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/wait-event: Export push-data helper
Date: Wed, 3 Jun 2026 22:05:59 +0530
Message-ID: <20260603163602.2678435-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163602.2678435-1-srinivasan.shanmugam@amd.com>
References: <20260603163602.2678435-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 90646678-575f-4ba0-ea7f-08dec18e3bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: E7lDF1RKyNKEbpO8MzNrQYvPkIUt41p1ER4cQ94kEMOFlGbbSLNWBLgoACmj+DU+Upg2cyeLolBWy53hxxKhDKfdjHF2UHhKZg3k4YTORg7eIJ/RS8caaawqxBu8At/hMBZCXwkVnDGuuikUlQQnqjtZqUKpNfvnCEXgFUo3DumzvnhTiyp4lBRMtLrUD/xFsvtajdFMtLB8ljqinoKyC3nOupEnDFPCuWe0qmskajZC0TlzDAipV/rEXaWaP3qe7y2O8FQhBw4WCqPBKH4Dfcu/b+7Wu1TbrvJXUwgShEO8MDTFcEVtxF++//HgtUXTtirK5oN6vjHChJQht5m1c9sKD9QT75eygaOinOyQDHv6AIM1B4MVdSNWi4Mtm7Opb82fSCI+GQKT0QmMZUdfvkNSrweuxQQkGEfLAHi6nk9aIKMn7co10f6vEO5bKRDGtPoxTaRiybgZ4oRi5iOhe0Zt6b3KpzBCPY2LN14t2OJOGcKSCKMtAArdu6cR7EyKK5QKrncGx7rZdVcvB4LJDcQV5rEW8pWJ+hJ5bLBm11XW2Iv3AYNw2M0nToU3j9uN8fFgLzsFjKc8SO3JuI0uazYWF0ZwqxIdlr4DGBUm6WR/Lk8ulGk7LzeKFbuz1wIQ4ThKqhSTv4Pw6h3SZzYfyh7nyxswu64vY23LA/+PWxV3eLOkH7fdQDrr/Ods+ce/fIgZbZW8g/5m+5CksG7euY6UMTOGBSy1y4BZCC8YKEk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vbeTFIk00/sfbFZrS4hT3YQvZNvLBHZI1InTWwrpeWmuTXUGw+CBf4bRsp0bTJfSEl/Q2KvwO7mow0pM+REnefZus8e9Csdm0hGBMVzP0jCQOXyzEbFcjAOxYS4oGK8hw25y11g8w/poi935WP5pY+eEFuvzin1dqB/XeRfjR0bJ2v9Sisl+AR2JxTvyL3JtgSiC5JiVflSSHZlkd5z1p8a2mX6JBM8j1oJqbuYCPRIq/ItyRVJZFey6uHsA837wotextUDNHuXzCulNW8jl245/ukSmJkKEKmdmSFk1e5BBtl4r1NYDXbAQL34r+XQG6OaiO1pD93vWQSTtOtQXuIXAVWi+4vbzo4x2SGTrWm26LoBbg+uOGB3XjstkiHBCp21FRvnqkjJjYj+7IEIo95fug64eITpWSGDiS5o/4HtkN5DowIDQZRLuHhq6ITGD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:36:16.5613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90646678-575f-4ba0-ea7f-08dec18e3bcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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

Expose a small helper which injects a prepared WAIT_EVENT record into a
per-file wait-event manager.

The debugger routing layer uses this helper when the debugger forwards an
intercepted event back to the application. Keeping this helper separate makes
the later debug-event core build cleanly.

Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
index 8ecc4e40a95c..4ae72acb9778 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
@@ -29,6 +29,9 @@
 #include "amdgpu.h"
 #include "amdgpu_wait_event.h"
 
+#include "amdgpu.h"
+#include "amdgpu_wait_event.h"
+
 int amdgpu_userq_wait_event_check_queue_reset(struct drm_file *file_priv,
 					      u32 queue_id);
 
@@ -179,6 +182,18 @@ static int amdgpu_wait_event_push_common(struct amdgpu_wait_event_mgr *mgr,
 	return 0;
 }
 
+int amdgpu_wait_event_push_data(struct amdgpu_wait_event_mgr *mgr,
+				const struct drm_amdgpu_wait_event_data *data)
+{
+	struct drm_amdgpu_wait_event_data tmp;
+
+	if (!mgr || !data)
+		return -EINVAL;
+
+	tmp = *data;
+	return amdgpu_wait_event_push_common(mgr, &tmp);
+}
+
 void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr)
 {
 	spin_lock_init(&mgr->lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
index 3cccc652360f..0bde6861522c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
@@ -58,6 +58,9 @@ struct amdgpu_wait_event_mgr {
 void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr);
 void amdgpu_wait_event_mgr_fini(struct amdgpu_wait_event_mgr *mgr);
 
+int amdgpu_wait_event_push_data(struct amdgpu_wait_event_mgr *mgr,
+				const struct drm_amdgpu_wait_event_data *data);
+
 int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file_priv);
 
-- 
2.34.1

