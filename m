Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E48606A681
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=q+zFeWn9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB9AB112980;
	Fri, 27 Nov 2026 10:09:55 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93E50112980
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 10:09:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvTddEo/wIpMUJ8wsBIoBxEnRwqvKY3b58Ry54FjLwFkvI2XWp4YvkIgPL3pTYfnb3shBURieaEIPfTM3K811vlW3V9eMFGwAC5FXtpjsrUDvbmA3G5JFGRmLjs561r2mcoRlvsfV3M5xIjktiyvKSzwZVGWYq82Ng+v0IOsGyXBs+xAS125s4YKsQ0b39oNkgrd3lwBKtPNpUBd4cVq6D9ZPNBdWEKMN4vm4wRtAKMgEjg1JTReHmZN2qz0S1MsGFGRz7h3v9+FEmppeL1C5Y9Fk9BFzC+HEAk/Q7aj8+TOCFBAr8S2tVEsS3/e7+422gmEWp+wWxG3nDhkOl9F7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vp8q6nBEGxIhyU96h0MvJFvOnYjuVZW8GrgdXvzvunY=;
 b=jy+bpA9FvqBKS6NLw87YCGsmhq76/MjB+Ruhmnjvg+JpafXEWeIe7wYNjcmDmQvvP6aFSyWGSGdZ4mWN2SHPaREcM5Uh8Ws3vY69VB24uP2+4Gzqoi7jUKFavNNLnYuXIadS9nngDvp67nNTYOYtKiRvAYbuw26vMtu8Bh5dKf+JnjzRoGPj5tKYTphUFlWrT4HEl8CaG3v26MLogM7u/AB6MwrynHpGvVx+o7hcteCizxX8PZ5sD04c5RHZ43l1KXo/thYjVyu/Wn0V4lOvK59UV481nlUlGn5lCbZ6o4nvRc/SsbwwFgWeQMsmpL7BeybJR+NlOvEhvS2XFBjG6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vp8q6nBEGxIhyU96h0MvJFvOnYjuVZW8GrgdXvzvunY=;
 b=q+zFeWn96kfpmCNzhtfIqsct8X2btmhiHRSre8zjEuhxNZOePXaHbipoBhkgxf0P1bBNcnOfYy/GtUX+5B35RzaxVpZleJTPvQcL/w4xop9OOiUS/0hjquZjyLxqqYO9IEx2KwS75GmcNWSD3Gv3NEQs4QaJt27izdVmEqIKUes=
Received: from BYAPR05CA0014.namprd05.prod.outlook.com (2603:10b6:a03:74::33)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 10:09:44 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:74:cafe::1f) by BYAPR05CA0014.outlook.office365.com
 (2603:10b6:a03:74::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.6 via Frontend Transport; Fri, 27
 Nov 2026 10:09:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 10:09:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 04:09:43 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 04:09:43 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Fri, 27 Nov 2026 04:09:41 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Sunil Khatri <sunil.khatri@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: validate the WPTR BO before handing its address
 to the MES
Date: Fri, 27 Nov 2026 18:09:30 +0800
Message-ID: <20261127100941.738014-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4b61cc-a100-4edd-aa83-08df4c6e8ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|6133799003|18002099003|261009223027099003|10067099003|261026140227099003|261026121527099003|261102123227099003|261028144727099003|261021121427099003|261022075727099003|261022105027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: FNSq8+nyLduNg4mT3OXvTlBe993C06C3wIyNrWiR3YJ8anUJYxGTbIwHnXFTyNC9Ep6D0Rn+V7sICse19Jtu4WuKqZzqDoRxWMdZ8R6lWRsXDB1Ci0GQ0pdY//nWvDEBBb5a2IchD7n6rXY+ZI8Fyj8c61CI1Od5fGVPVlDH8TZ2fALAYp4T1MZTWHUMcYTD8UvIYFvrDGHdRhTsB/5KJtjl3hpQc4eauFap7l2O3btpIMovjfH+OBa1t1rFbhjUo1ptV99GkBA4msQ+xL9vsWR+0cZudDI0NizGkfB3TuzMK1nYSWfeVzOVhQpfyKslFGu0Zc1YYM2Fx0qms5unJ6ngThXaCt3BTyd7osrvLAlvOAgRU2gRdEFIUjal5vgbFqM6PEQTl7rNWimi0/K+e44TPi+J8FGZddDO0zK4zaBzE1733KftiDRWuBwvJ2jPRXRbqGtDnY8PKfUFbOKESpsS2tbND01OogXVvArAjA+gA5UQH5ocwCqaUGJ0dBOtukZ5EEReipNf2pwg0yVAeSN/KdF3lcn6Y/glELJQzx3mz0ATXQiNAscT21gQNZ4imBTFMBJPPqUjBPTGQ7jwmfkdId6j7eIC4UugRlhIgi4SxHBtAReA0jeNhB3ZgRyxWqy6wMXpsrppo1P64jrWXJm6Ua7TWJcGz50ZsHncGG0xqjcdm9C6m4TqM1fKOqhWsjBOegw3V4AsHYvGD+k3dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(6133799003)(18002099003)(261009223027099003)(10067099003)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(261021121427099003)(261022075727099003)(261022105027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8aaUxgYiu2kuFDoLO3h5zkJoa12oyAp6qkjmCHl7a5UI352yM6CLiCMJO4LKq0naIBSVrtYsY1LpCncINeBIL5JWOGhp4ZMzAlsmojrM5l203z5WiDH2xRVvyzmCh2/il1c5aBl4Z9p56j9jYfr0s5NGMPMhYyg65ZWXMv80GMW+W3ks05PvIkw6r45QVrkiKD9YzQ2gKv0ucq7E8ER0WBzH4A8QTXHIU5/rovJhUn91Rs5o4bqUaIScSuxEwHWUJSQlcm0jQnwAyhq22BDFVS04aLkjCRgTzJ2N6MzS9qp8CAhHGpijQY9Q5adYUjjC6fBDlHN2ukScFFrsuaOHWWyc4mumlge70Yhm83orxlaS9+XquCxiQopZpbRP1CDEbsYi7grEZ0vacKvWi2k8d+H1cnytucwTrUe9vJCOaH7xMpuFE78FOr61vWcCSSzT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 10:09:43.7549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4b61cc-a100-4edd-aa83-08df4c6e8ef2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The unpinned WPTR BO can be evicted to SYSTEM before queue creation.
amdgpu_evf_mgr_attach_fence() skips validation when the eviction fence
is already signaled, leaving the BO in SYSTEM. Since resource->start
is zero, amdgpu_ttm_alloc_gart() also returns success without allocating
or binding GART space. mes_userq_create_wptr_mapping() then passes an
invalid GPU address to MES.

On Navi31, creating SDMA user queues during GTT eviction triggers:

  WARNING: amdgpu_object.c:1550 at amdgpu_bo_gpu_offset
   mes_userq_create_wptr_mapping
   mes_userq_mqd_create
   amdgpu_userq_ioctl

followed by page faults at address 0 and GPU resets.

Validate the BO into its allowed domains before allocating GART space,
as the restore path does. This removes the warning and address-zero
faults in the same test.

Fixes: 7264bc10c7c6 ("drm/amdgpu: dont pin wptr bo instead use eviction fence")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 7abb9d95ef59..105c9866b2a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -37,6 +37,7 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
 			      struct amdgpu_usermode_queue *queue,
 			      uint64_t wptr)
 {
+	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_bo_va_mapping *wptr_mapping;
 	struct amdgpu_userq_obj *wptr_obj = &queue->wptr_obj;
 	struct amdgpu_bo *obj;
@@ -84,6 +85,12 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
 		goto fail_map;
 	}
 
+	/* The BO may have been evicted, it needs a GPU address for the MES */
+	amdgpu_bo_placement_from_domain(wptr_obj->obj, wptr_obj->obj->allowed_domains);
+	ret = ttm_bo_validate(&wptr_obj->obj->tbo, &wptr_obj->obj->placement, &ctx);
+	if (ret)
+		goto fail_map;
+
 	ret = amdgpu_ttm_alloc_gart(&wptr_obj->obj->tbo);
 	if (ret) {
 		DRM_ERROR("Failed to bind wptr bo to GART. ret %d\n", ret);
-- 
2.50.1

