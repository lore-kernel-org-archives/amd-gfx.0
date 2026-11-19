Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCAB606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xbP8khrI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B35BC1124C9;
	Thu, 19 Nov 2026 14:41:16 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010030.outbound.protection.outlook.com
 [40.93.198.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA68E1124C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 14:41:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXpPB1GoT9KuTETgKZVSUIPW0gU41EKTFrq9x7uUCzu3qESfHvuw6lLrVxzGxxPGOuCg0PoCyzSpJY0llGn+zeCtAQnwNq/ypECMnmcgPKRgZzKiizImQg75XJf5e/xcKcaoG0EWpQfyKFQ3NqTUIvnP/EGWJDvPpX69bGrf1IAdpR8lIh6KAF3tzYdeEu9cZZCiHVOIM5PyGaYtHTStqcs8H6yhYIXJsAG3XUH6aDdYoe/bDRdlu0mvDKTPr+l6O3E4kayhFUgThGZ3z8EnkGQeLJbkOGvkZzluBuJBjfirvcnuGOIZ7A+EsvzigdTO36d+wGY3IJZ2QBjWznbPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeq4/30S5Ck4ygp8fgYLTa3SKOfdD0Bk7lA1Rt1gA0E=;
 b=y1IxUP/UnhcsOi+EKf6YzLjxDHKz3bpNm5p8whAatoVaefGkxXcj1UPPWpofsIiLKlGBfXe8CfStBpQLam7CgJv65IS8OftXBzmdMuSHQ0aGDO0eUvS82F4teup7pSZ80gwVyOOo8Lf5/hfo3LrF7uviiXxrqFm29tM8iZOobFAiuTlx5OrsWJJlRoc70zrBg25UobnHpU4LU/qcWYLgrznZRc3HHKrz6olAy7e94X7hOkqdR4dWiGQbCeS9ov3lzsz0gigw3HcZbPpCvKNWkdI7NRE1aecVlJnpKKrKYj9X9iwQ20ubaG9j+OZmAB1v7I1Aq8N0QEx+7/yreAAaNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeq4/30S5Ck4ygp8fgYLTa3SKOfdD0Bk7lA1Rt1gA0E=;
 b=xbP8khrINbewmGyR5KqYaXAfZZaFsWNEcVT3cTb3oNraQtTDbW1d2/wJnixWM2L1GVQKdgnJyK4w2QT2u/o5zX9q4ZGNLwKjYD3hnIJNP/fpTKXyLcjDiG20nWo2Z/78Igwz+QtzAAoOUjypETRvkBD2nL+fChf36QqEAVhC4sk=
Received: from CY5PR19CA0132.namprd19.prod.outlook.com (2603:10b6:930:64::29)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 14:41:06 +0000
Received: from PH3PEPF00059618.namprd05.prod.outlook.com
 (2603:10b6:930:64:cafe::89) by CY5PR19CA0132.outlook.office365.com
 (2603:10b6:930:64::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 14:41:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF00059618.mail.protection.outlook.com (10.167.243.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 14:41:05 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 08:41:04 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 08:41:03 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v3 6/7] drm/amdgpu/uvd: stop using amdgpu_bo_fence
Date: Thu, 19 Nov 2026 09:40:48 -0500
Message-ID: <20261119144049.2057674-6-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119144049.2057674-1-benjamin.cheng@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059618:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd0970c-19bf-45e7-16d5-08df464b242f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|22082099003|18002099003|11063799006|56012099006|4143699003|261026140227099003|261102123227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: OSUPhL8jGRWM2+8QL6ySgFNhr26+nXZN5tLiBhvyy2qORMdcDf4kbgokmv+b1WkjopAqIYF7vpHnsR/eAdu1WceBTRX/1S7z0czCdja/v8JpV2vu1yRKxgq4zh7nwhQItbi99t94IMAcagZyjuHJCm2FcEzQ1+KIR0X9WgU/hE45lhhM1uFnSjez/TYaNCJM9f1ruVL6K/0DaJ1Ol23vonr80g/CsFw974CNvWLP3LH2H+6GlYtxq6TdYdc7Fb43E7z2m6KpJXw/TefX2Evy7KJu5QQ9L3IG/JMNu3nWhI/SC464GKBIqkBoxfh0QvughFjcreyXR+xq4Uj/8shnwXac91FFh6uyu1+S69C7vzQkCGc0t73cla19FoSCpaiXtiaGTT0HKD0rMj2BxvybYqMVgX400rC3+IPO64KxFZZcjyQHDJAvTms4qmCfQxODndQx2bFU0gi+azZhQr3GaF9r3dPCoReXKKBmEcoGB9mqtBhVcPNGvgk3J0bn2q7UYDmdKWpX1DkdQt7JpsNprC4We9Z+U98/AVyG2tEnwjpP4RLmUTpC7qvadNU5N2radtezIBJi5BAHex3+cCOlBBdZIiKU7LahbaTjL2Ub/I1q0Pop427XgR6HoUQEzSJoqR/0AlQScVlhQPc9B2BnXrEj25f/Ig9cR3iy8Qlx+U6lDbPmuyg5bWK5iE7f1tpIzxZGWfcjSG4+dOK8BCdDwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(261026140227099003)(261102123227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HIre0ngTcykEp5ZA28U+saXWvF5foat5Yw/vqHeq7ptQCf6YNcTo8hWpOwqYQ5TnwUjnbiU3e39EZ4V9Z0jSPOt2AZ8OG6doESDQF+FMOCD5juCKBSC+SAe4G6EXjEQ6jLMgwC1gQOzTzUPG6fDVkqDEAAOiTUNIs8sN28a7L45jQVk40/w6/fTJ6VwVVV0yVsc2PGZ24v7A/DKzrJF/kWwVGk+l0YLwdbkUS+9Qn46ZVYI/7xGL+l0axfpQWqGO9Noqgqinfk5jq6sgXHKDsYQAOlF70yc+5119fp0ezEEUkXW0dmVnEXNxhENAanO38Ze4aIgGllzTIpmS1CnWN6g4P4NGnB20Lyk0IcQPvtRbyEPalHsYB+1OIatImRhRK4rPPzGiNT/gy+Aoc9CMpOQhgEav7x0lKliL5iVnJ+Eat/t16SdsJEtSKdtjC2z0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:41:05.2231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd0970c-19bf-45e7-16d5-08df464b242f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059618.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616
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

This helper is deprecated since it is incorrect in most circumstances.
This was a circumstance where it was mostly correct but it is the only
remaining usage, so get rid of it here.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
v3:
- Moved the reserve_fences call above submit (Christian)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index d88dde859615..1d9a18203d39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1154,16 +1154,27 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 		if (r)
 			goto err_free;
 	} else {
+		r = amdgpu_bo_reserve(bo, true);
+		if (r)
+			goto err_free;
+
 		r = drm_sched_job_add_resv_dependencies(&job->base,
 							bo->tbo.base.resv,
 							DMA_RESV_USAGE_KERNEL);
 		if (r)
-			goto err_free;
+			goto err_unreserve;
+
+		r = dma_resv_reserve_fences(bo->tbo.base.resv, 1);
 
 		f = amdgpu_job_submit(job);
 
-		amdgpu_bo_reserve(bo, true);
-		amdgpu_bo_fence(bo, f, false);
+		if (r) {
+			dma_fence_wait(f, false);
+			r = 0;
+		} else {
+			dma_resv_add_fence(bo->tbo.base.resv, f,
+					   DMA_RESV_USAGE_BOOKKEEP);
+		}
 		amdgpu_bo_unreserve(bo);
 	}
 
@@ -1173,6 +1184,9 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 
 	return 0;
 
+err_unreserve:
+	amdgpu_bo_unreserve(bo);
+
 err_free:
 	amdgpu_job_free(job);
 	return r;
-- 
2.56.1

