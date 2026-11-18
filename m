Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590DC606A325
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PrrpSS79
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B8110FF61;
	Wed, 18 Nov 2026 18:52:56 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8714F10FF69
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 18:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxqQpWFl7xwfF+tWz7UOj0QR4YxE1lQtZ85DfYzDHcuF9dkVBKU5v7MIP9LByOBTAsIxl0SfVzJLf2HwbaK5NCVkkHGe2lsEF37Wyc1cl+XRZCNVVg/z45qoRVAVogd9jIL7ksgpBxLbOwyEMfZmxrwi0nYvdNye65e0xgZ6sl13FW0xtcimRC+fXWs0X96rebN5VhUlaGejisv7FGmxdIePYA0H5BTRf9XZbIduPVXxqKHTA7xTeLYWs1/TNB0mLtblCxNZcCBAtf+dSsT4AHVcENWOGkrzUIK3ogKW8v+SgI4e3mopQtmNhfis+MWKaRr0JHTBKJAgnvB8kzgFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=st3ahb48ErsPP+DO6xkdX4HGK4YanwcPNp7by+8f8Y8=;
 b=IC5IVwcPBSnaoTLDznVzUos56pvg+3jIS/sYR6Et7RIbzRg6cjpYp1lLfOt1GNHGLGh6b5BmIKZqBWlEV6JjGR3lwwaVzNVMLp5yzivhUktYZHCGxKxi6PHBA/nH/2wjCpoRib+vdw0zUs8IZUiEEoX76z7wHIr2pXhRIJeUmqzKqoCmK7pSY0BbJ2ogJYGKY9Un+eAAnCZVzN3V7AdMcujTn5uiHVBRCBO7orL9amtaW7gMFdzm0s5d4EelofnCCPqKHC5vDw58u8/l1u3BKyCJAkWk6t/4xduJJMsGjaRxYIGuu+P0tXaLlqpOpaPttlh3JkmcETeRuYJZhcPbeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st3ahb48ErsPP+DO6xkdX4HGK4YanwcPNp7by+8f8Y8=;
 b=PrrpSS790Mb+/oKBTY40hcU+eBo9PMb5LZtnzUQlNj6Gyq7fb4aIVfUjFi17D/J8npoG1nvrq8poGjOlWC6UAIzu3Np31O1O/xUSmZ60PJDRSJRBimO3LE0oE/BlGiveVu+sXb+lKltu3KRN2E5egswEvvJWVfh/0hBgk1c8K+U=
Received: from CH2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:610:50::28)
 by DS3PR12MB793063.namprd12.prod.outlook.com (2603:10b6:8:43f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:52:46 +0000
Received: from DS2PEPF00006E24.namprd05.prod.outlook.com
 (2603:10b6:610:50:cafe::28) by CH2PR16CA0018.outlook.office365.com
 (2603:10b6:610:50::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Wed,
 18 Nov 2026 18:52:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00006E24.mail.protection.outlook.com (10.167.23.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 18:52:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 12:52:44 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 12:52:43 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH 8/8] drm/amdgpu/object: get rid of amdgpu_bo_fence
Date: Wed, 18 Nov 2026 13:52:25 -0500
Message-ID: <20261118185225.1857845-9-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118185225.1857845-1-benjamin.cheng@amd.com>
References: <20261118185225.1857845-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E24:EE_|DS3PR12MB793063:EE_
X-MS-Office365-Filtering-Correlation-Id: f88fc927-418b-4a46-0494-08df45a52272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|22082099003|18002099003|261009223027099003|11063799006|56012099006|261021123027099003|261028144727099003|261026140227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: KgQznTFiydZDqfyCWW6Zv9gGKk/Kx9+2JvjvOvrdDdiu8P4cZzFGmlIBd8sMvoPV5kirNr6mDEZUxertqb+t00EXdRh5ruzweCex5Y98DnVYNItau4uEcJpjJCMAWREHlN4RMvTlHaehf2q9Y1KYISnH0GAmP4WfqcViAjKSzEM3WvKMVAawFj59E6GG9+I9qsdPWic0fEDnS9oSTvDlHyzSZW9/dJ+a6HKqq602iALvon/p0lxgje1xR57RJIqMsrNEX5ClyXiPgQDH6BoJ+OTZXl14A18TM0tMaFuoSRe4dyRwBNXRHFWnwI9BXeWeGWaxT6sIhSaub9hNry5N5Hys7Y23d73we96we1eNY3vm8Nod2or/AM2HoE/n2rxRurSr0VFt0/c+afXUvoycbH2c+72MbUk3qxSnOzVtL8fpTCJ54xJW/ho1nurrJw88yTAGRDBvh7uZD5nehFw5Qt4iLHMs/oCNdBO44+2X2GBhMj7HdiU/ABDKc7zPd04uqw0JppQbmudeECiYGoU/6wp2Ed+DScHBTgcgjQvQYLFS2euuWMTonE9ydma0+vtNDHRknLkTj8GoMc0H80zAmxf+1JBwBTqd8dMn0u0JScXHUWOMXzv47FXZmYL9wbjLiIcOj8+8UEenHTasQKUcPUzcvuEt+GMUV3du3ielqj4DinxWQKcWV/aX7b6w/y2PNiuWAK2N++nWETKEkcQu7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261021123027099003)(261028144727099003)(261026140227099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CE6QwMi0GTcoY4ZVwScZ6lKbPRcvG53LjFUbGgcGQboZcXtOsUY7JtsRxMpUHq27uR7r0T6mJLNbVZclVpJxs625DpWZosf67sqlOaa1G5UknBwpGDETqk2epKi3fnx8CNqHxeHLGVeaW6PM7tKAXrs0J+dvgBAYzwh2l2nvIAYgzyBvLPXxuiBEl4Ch2XWE/ncM0e6eTt/anBHX6F6ucbhSkLry/w3vZ9lttHi18oAQDZmC0g0ptu8Scp66S3fENVBT39IMKQOXlAHVFqI1L8FAjjGWqfF0L3jJbcgQkdQ+5iJck1Qy4pNIKdp3BbSU1e7bu2lQ+zu3F3otivASaaLb398ixckaMryewQuiP6IDurOD+5rYO1ggLP9jzpMoNK3+ZebcR4JjcNY1Qo3M0Ow+bW55tRSJpSkM9rvnJrz5NkyUTrGg8EElf4UCxaBA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:52:45.8873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f88fc927-418b-4a46-0494-08df45a52272
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00006E24.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB793063
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

All uses of this function have been removed, so we can now get rid of
this function.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 25 ----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 --
 2 files changed, 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d4651f2d437c..ba9b5ed71cf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1463,31 +1463,6 @@ vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo)
 	return 0;
 }
 
-/**
- * amdgpu_bo_fence - add fence to buffer object
- *
- * @bo: buffer object in question
- * @fence: fence to add
- * @shared: true if fence should be added shared
- *
- */
-void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
-		     bool shared)
-{
-	struct dma_resv *resv = bo->tbo.base.resv;
-	int r;
-
-	r = dma_resv_reserve_fences(resv, 1);
-	if (r) {
-		/* As last resort on OOM we block for the fence */
-		dma_fence_wait(fence, false);
-		return;
-	}
-
-	dma_resv_add_fence(resv, fence, shared ? DMA_RESV_USAGE_READ :
-			   DMA_RESV_USAGE_WRITE);
-}
-
 /**
  * amdgpu_bo_sync_wait_resv - Wait for BO reservation fences
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 8e67a8e60572..33a1bfce79e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -305,8 +305,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 			   struct ttm_resource *new_mem);
 void amdgpu_bo_release_notify(struct ttm_buffer_object *bo);
 vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo);
-void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
-		     bool shared);
 int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
 			     enum amdgpu_sync_mode sync_mode, void *owner,
 			     bool intr);
-- 
2.56.1

