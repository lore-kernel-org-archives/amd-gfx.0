Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C49ACA5FC1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 09:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9FDB10F2A9;
	Wed, 30 Sep 2026 09:39:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iivNsmkm";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012000.outbound.protection.outlook.com
 [40.93.195.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF48910EEBC
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 09:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpuTM/udq9pmlpJ62nX1Oti8wYzr3Tfkb6E51tUXTFhfG/WtkNp/4sgSxHUTwcLga3V+pmQpMkme+O9rrNC2fkERo2HMgDDJ37newD36urOhrTTTZFqylSP/djVBAwowJY0GY14fiXH7v0KmgyJY0AsYf95fwssDS/SQuA7J1jEatsk+J4ka0n7cg99F2Pyl06HQXV8QjzskxclbZk1v/A43GFzA4gFlEEfEBxp7fM5BBMelBVOp7e7IHiAxPqigfQ2bf4o0l8x8WCBOO9Cg8jhns9Wsr1BN6mH4no5bHVVeDCY3zNF4c1JXn20OJY1T3FYyXg0XJasSwYjzgbEPPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/YRUATj0ydIv38m2w2zVX/QCJRwu5gWZN4bqMv1P3I=;
 b=asEqUwC1pSgp1hvagn45MppAiRdhy7/qqUI7UveVbHJ2HVCP9xIpKGlFUVGmAU41YxGkHdQIo77m6YvZ643yfyrF6zpJKFKro6QqXDjlcIx04SXi7LV6vzkNJxePh8NGDEgisdzmIPgylbWaGyVV0EdGShwTvHNOYSMadWBOPzJ5WjhNKmGUyia5b2DnBREDWOIufQeOwVWLlaXdkbT6JoH23tFDsvaYKyo41i+dGL7sIvLqV/yh1ikqm5asjNG+6JljH4FCsvXOWg02a9ibCKIFWQFITJq+geXtBcEbA2VKf259Nlu0XPkotCrx95HrMNsHSOMH8O9W8oxOmmg4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/YRUATj0ydIv38m2w2zVX/QCJRwu5gWZN4bqMv1P3I=;
 b=iivNsmkmz76+M5DxNXvmNmTl7z/fkL3bM7K8cED+PMdhPabIq5P5U2SMWdnCwUpRrX+4Vw8gsqJFZCRUOWSPezG89aivsKu3bAgov+cC6U2nM2jHgB7lJZ/RDqKwHtXNnRLJGp7l8XGbqqFOYruHkI/EJAS/zbw1JYKzW1n/PBE=
Received: from BY3PR10CA0004.namprd10.prod.outlook.com (2603:10b6:a03:255::9)
 by SA5PPF3C36BFCB5.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 30 Sep
 2026 09:39:19 +0000
Received: from SJ1PEPF000037A8.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::1) by BY3PR10CA0004.outlook.office365.com
 (2603:10b6:a03:255::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Wed,
 30 Sep 2026 09:39:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A8.mail.protection.outlook.com (10.167.244.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:39:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:39:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:39:13 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 04:39:12 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, <sukhatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V2 1/2] drm/amdgpu/userq: only accept doorbell BOs as queue
 doorbell
Date: Wed, 30 Sep 2026 17:38:10 +0800
Message-ID: <20260930093912.177219-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A8:EE_|SA5PPF3C36BFCB5:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c3c71e-be28-4d63-f40e-08df1ed6b1c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: /2mLF8pb6P8OCRRJlvI4RoeHiswpD+CwE4PumXaPOlXytR4QrG1zfTfsR6bixepwsAyQttqzQh9CA0l+V5U368buPEMoA7DIglaFcnDXzNnsCgt4GBUKxF3nAwfgke4BAJqJPFjdR+PpApOaWGeZEIEk3Zh8If7z7Ikc0mLrvRQtH5CFontjkcNOtyqdTbgLGGhZvHOJqyVBW3RsD58NSJzG3JQA8rQucyGQOnC2Wq/7OO/q5/qXCOL50okZaC+SGr4rcERamHYa5xqtGzPMvI44AR+vRYw/N1gaYQIs1hmQGm0OaeDuKYWTtBPAFWH6nKJscfayE9dax9Mrv1YzhG2k9J9NAlY+831oNqKQ+mIC7dFaxQGpFpjPBwPlUGg47t1yw57j7eIIY2f+q2XrqaiTqjIXd2sSDuTI18MUZ6f5a6AcQAYgk1BxUvq5KmaI+tozbetju+nTKFF4Jt2n94Xh6+qnxWNOtBXF98Bf4Yt3npP1Io1f3dZhRGykb5LrG/dh1HaoEliKepgfC8cxyVcyDN/CddA6Omhruu4S/yfWs7HmQzpIpz9D9HiSnOOgPXENyErLRgjKAFr9sbZCodlx72krweo+IxCB+1rRcFG9kDA4Lre2WJ4jHCrDPB8iqV8DqeZJja1g8z0Y5zquUGAR3N+NwLfrtGGs94fQsFB7MTxllvKOTfYyiAbufs6hfUIg/35Ezp2GhlDFCzx4dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AjqmKFgIQ2zkd92dhN8Npcjc8dMUroHvDdNBOVLr8RiRHJOCv+7+rSVmOOO1/HWT4olD3KYDlwUg3yfz14lHeG31GSYyURean0ZYhavJj+gxHtlPJnpY+faG9HK1uuh0A5rj153vCpJ1iTt9CqejsurudY2CTMGKhubitnx01KGjNzIQz0U6hQgzQKAlBop5FSIjvxyqZGgKAp3Snu9wUKwIW6ZGWeb4Ye9xuMu7+jVE7HO1isADLP/RL4dhaOaQTJeTxm8OeMeDomHCPfOO3KtsaOTwjcNeC4mJvY3DFk0ACTENT6EY+u4DXJfXLW8HlbUXs3QOHdzW8zz6IoH/2nu24MUFL/7KxoZY2qVOUB9okqo+5NNzR3nc72JdP1mNG1JfZB7Gx3D5CKuOvR06ApI52H0EOoJOeJMwOPS8cVRed+XGd8XlIzUVoglJfmpY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:39:16.2737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c3c71e-be28-4d63-f40e-08df1ed6b1c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF3C36BFCB5
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

amdgpu_userq_get_doorbell_index() pins any BO passed as doorbell_handle
into the doorbell domain. For a regular BO, TTM moves it with
ttm_bo_move_null() and its contents are lost. Since an importer on the
same device gets the exporter's GEM object, a client can do this to a
buffer another client shared with it.

Reject BOs that were not created in the doorbell domain.

v2: drop the error message, use a local abo variable (Christian)

Fixes: f09c1e6077ab ("drm/amdgpu: generate doorbell index for userqueue")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 89e03d3a930c..5a922f283743 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -469,6 +469,7 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 	u64 doorbell_index;
 	struct drm_gem_object *gobj;
 	struct amdgpu_userq_obj *db_obj = db_info->db_obj;
+	struct amdgpu_bo *abo;
 	int r, db_size;
 
 	gobj = drm_gem_object_lookup(filp, db_info->doorbell_handle);
@@ -477,7 +478,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 		return -EINVAL;
 	}
 
-	db_obj->obj = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
+	/*
+	 * Pinning a regular BO into the doorbell domain would discard its
+	 * contents, possibly those of a buffer shared by another client.
+	 */
+	abo = gem_to_amdgpu_bo(gobj);
+	if (!(abo->preferred_domains & AMDGPU_GEM_DOMAIN_DOORBELL)) {
+		drm_gem_object_put(gobj);
+		return -EINVAL;
+	}
+
+	db_obj->obj = amdgpu_bo_ref(abo);
 	drm_gem_object_put(gobj);
 
 	r = amdgpu_bo_reserve(db_obj->obj, true);
-- 
2.50.1

