Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4B4C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jun 2022 04:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EBB9113A1B;
	Thu, 23 Jun 2022 04:26:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59089113A1B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jun 2022 04:26:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfXLle7wSizjxQ38heDfMhRXDIDURzCJ6LEF8ZktswPJ5eq2Xr3GBWXpMv1vDgbRP+ekyImRckN8rmr3Nv+93emRQma2do9+C53cRyTs2OJ7D8iyDpPhCCGJ1PZZaKf0B+Y6tMwiJp6ulkdvwtp+ajqdPZhRCEXulRXVlw1YBOfHReCkM6WYpUfJgBG8imTWmTc5LGELKRUUmOMrZLOitPwCFoIvYR3nChLOJp6cqEC2o7IBhVtGBia+2ABPu1PHxxChAVCWVVdaxXtBEIINNy1GwbfeSYotL6Mpu9GbcPid7fQuTpv0wdSWTUk+vOTQJX2hRxiov4lpo27Z8rUp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E2i+zSLR6Ug+uJ6n1GtBo+5SLKIehsa3d2p7/xK0uE=;
 b=Eq2/nIu1sNLlndESk5EXBGDe0Z9p3UnwFDQq8eFK/sydRSUijnMYhaL86pU/wI80/+0UVxAZMEBfkUP9DO6dnYkfKSru2o0NYZd+UJkAtOENLc73uZlNz2ljKO9NX8z/qFO/japTTQApBKJdTaAdNzQmkTFGlFhu3qawhxYJ5FRoW7tohsrZ+P+CFrBz7jCpw1ku0Uafu6+AqRErF0hD+qq0miJA2cGRaN/MZXyM+eorrdkkgE/iTH/VJpbUHL7Y/66LgjbE6XDIi/xmd9VKMS7qCPM7gRKPhRYJwdG35bdm7WArNBMTxBQ/UhURRXlatTaGcZtYyRvyRJj/Z0UESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E2i+zSLR6Ug+uJ6n1GtBo+5SLKIehsa3d2p7/xK0uE=;
 b=EmAzdee8ZbNIWfCUj9hCTv2Hv0A6h4Qv/WKKR5fUBox9j+Y6SD/lLId0YaOTwq8RdvBgVFCxvzUUPziwztFgCvCHbvCGaN1ImR54EZqWEGJDLT4J4/1sI6raxr2SAXlZ8516PXgnjKoZH2tGj98idtqwi0xuUwN9fUUxhCaJ1Ew=
Received: from DM5PR13CA0041.namprd13.prod.outlook.com (2603:10b6:3:7b::27) by
 BL0PR12MB2500.namprd12.prod.outlook.com (2603:10b6:207:4e::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15; Thu, 23 Jun 2022 04:26:23 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::b0) by DM5PR13CA0041.outlook.office365.com
 (2603:10b6:3:7b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.9 via Frontend
 Transport; Thu, 23 Jun 2022 04:26:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Thu, 23 Jun 2022 04:26:22 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 23:26:19 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Protect the validate list with a mutex
Date: Thu, 23 Jun 2022 00:25:12 -0400
Message-ID: <20220623042512.13815-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.36.1.74.g277cf0bc36
In-Reply-To: <a0ae6ae0-35ec-7da9-0671-42bdf126460b@amd.com>
References: <a0ae6ae0-35ec-7da9-0671-42bdf126460b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e0942b2-257a-4448-1a82-08da54d08742
X-MS-TrafficTypeDiagnostic: BL0PR12MB2500:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2500C29410503F89FEA79DD499B59@BL0PR12MB2500.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7DOtYSGWq1m2H7YCqy+lCC8ALYvrQ6qg9QULdL6J+pu2PKwpy/n1+6igKt2YXQjz8P98YgnZGRaXSNBkK12W537rvhiDtESnSohYO425RFoGhSEe4Qw3MXVzMZVWj/uSfeWialq1EmTrro5IbqfSiaMrpCGR2T5LaOU21rzzfz9NVFR/fMcDChIpHciljNJ+/+Nmm2uWl1vuK4PUTEGFvvdCok/8bQQjwIhvnF0y49QdtJXBw+JJXQGb2TXqnoP//lt5NSE/+rna7NANBNo8usDeN36bBlwdjaVsWrstJoxlHh8pu9L6zPPbLUAIlvUECQxqHwR8V52Iytc0nrInITnF/FU2tQORqRZwc9PmttfKhpjlvHe8BpEzY/By+81VEPr+BVBduZsUV4BZ2LTMB4O9CFKm/EfKZfwPVIXF9E7zRhNpd6uPhLjo+n/dgGgggBhAdX+UWPd6s1YR3CwgIiFxZa6KzdV7xDwwr7u+lVed0S3K8/BQI2l7udLFQVBaZw4w8qljcpi6O7byukT3IVipM6a6E+nCY6JiyHxRbNGieTXgkQD+08JnnTo/3cIzYhRrxFbfw2lcTBjPiFvQTbCXNdRCCr84QzSH/mk198PPuMBSTf2xitdbF1Ma8pIFXOmihrShQ24wv3P2OPeX5dg3j7W0IquuEn/gW9CZU8nzJZO9WzjSOT1mbCyk0qg0TG3qMHWOHVkannHPI8qzEtb61iAnwLZ6BQiJeib7sp+z9j9mTo21mvNLhWEQ76ba
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(36840700001)(46966006)(40470700004)(47076005)(1076003)(82740400003)(186003)(336012)(16526019)(7696005)(6666004)(66574015)(426003)(478600001)(41300700001)(26005)(2616005)(86362001)(81166007)(356005)(36860700001)(15650500001)(8936002)(44832011)(5660300002)(82310400005)(2906002)(36756003)(40480700001)(70206006)(70586007)(40460700003)(6916009)(54906003)(8676002)(4326008)(83380400001)(316002)(966005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 04:26:22.4596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0942b2-257a-4448-1a82-08da54d08742
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2500
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Andrey
 Grodzovsky <Andrey.Grodzovsky@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Vitaly Prosyak <Vitaly.Prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Protect the parser's validate list with a mutex in order to avoid buffer
object corruption as recorded in the link below.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Vitaly Prosyak <Vitaly.Prosyak@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2048
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 28 +++++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h |  4 ++++
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 36ac1f1d11e6b4..e593e30a8545f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -498,6 +498,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	struct amdgpu_bo *oa;
 	int r;
 
+	mutex_init(&p->mutex_validated);
 	INIT_LIST_HEAD(&p->validated);
 
 	/* p->bo_list could already be assigned if AMDGPU_CHUNK_ID_BO_HANDLES is present */
@@ -521,13 +522,15 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	amdgpu_bo_list_for_each_entry(e, p->bo_list)
 		e->tv.num_shared = 2;
 
-	amdgpu_bo_list_get_list(p->bo_list, &p->validated);
-
 	INIT_LIST_HEAD(&duplicates);
+
+	mutex_lock(&p->mutex_validated);
+	amdgpu_bo_list_get_list(p->bo_list, &p->validated);
 	amdgpu_vm_get_pd_bo(&fpriv->vm, &p->validated, &p->vm_pd);
 
 	if (p->uf_entry.tv.bo && !ttm_to_amdgpu_bo(p->uf_entry.tv.bo)->parent)
 		list_add(&p->uf_entry.tv.head, &p->validated);
+	mutex_unlock(&p->mutex_validated);
 
 	/* Get userptr backing pages. If pages are updated after registered
 	 * in amdgpu_gem_userptr_ioctl(), amdgpu_cs_list_validate() will do
@@ -563,8 +566,11 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		e->user_invalidated = userpage_invalidated;
 	}
 
+	mutex_lock(&p->mutex_validated);
 	r = ttm_eu_reserve_buffers(&p->ticket, &p->validated, true,
 				   &duplicates);
+	mutex_unlock(&p->mutex_validated);
+
 	if (unlikely(r != 0)) {
 		if (r != -ERESTARTSYS)
 			DRM_ERROR("ttm_eu_reserve_buffers failed.\n");
@@ -607,11 +613,15 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		goto error_validate;
 	}
 
+	mutex_lock(&p->mutex_validated);
 	r = amdgpu_cs_list_validate(p, &duplicates);
-	if (r)
+	if (r) {
+		mutex_unlock(&p->mutex_validated);
 		goto error_validate;
+	}
 
 	r = amdgpu_cs_list_validate(p, &p->validated);
+	mutex_unlock(&p->mutex_validated);
 	if (r)
 		goto error_validate;
 
@@ -648,7 +658,9 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 			dma_fence_chain_free(e->chain);
 			e->chain = NULL;
 		}
+		mutex_lock(&p->mutex_validated);
 		ttm_eu_backoff_reservation(&p->ticket, &p->validated);
+		mutex_unlock(&p->mutex_validated);
 	}
 
 out_free_user_pages:
@@ -672,6 +684,7 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 	struct amdgpu_bo_list_entry *e;
 	int r;
 
+	mutex_lock(&p->mutex_validated);
 	list_for_each_entry(e, &p->validated, tv.head) {
 		struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
 		struct dma_resv *resv = bo->tbo.base.resv;
@@ -682,9 +695,10 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 		r = amdgpu_sync_resv(p->adev, &p->job->sync, resv, sync_mode,
 				     &fpriv->vm);
 		if (r)
-			return r;
+			break;
 	}
-	return 0;
+	mutex_unlock(&p->mutex_validated);
+	return r ?: 0;
 }
 
 /**
@@ -709,8 +723,10 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
 			e->chain = NULL;
 		}
 
+		mutex_lock(&parser->mutex_validated);
 		ttm_eu_backoff_reservation(&parser->ticket,
 					   &parser->validated);
+		mutex_unlock(&parser->mutex_validated);
 	}
 
 	for (i = 0; i < parser->num_post_deps; i++) {
@@ -1307,7 +1323,9 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 		e->chain = NULL;
 	}
 
+	mutex_lock(&p->mutex_validated);
 	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
+	mutex_unlock(&p->mutex_validated);
 	mutex_unlock(&p->adev->notifier_lock);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
index 30ecc4917f811d..284d1c03d65d0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
@@ -59,6 +59,10 @@ struct amdgpu_cs_parser {
 	struct amdgpu_bo_list		*bo_list;
 	struct amdgpu_mn		*mn;
 	struct amdgpu_bo_list_entry	vm_pd;
+
+	/* Protect access to list "valided" below.
+	 */
+	struct mutex                    mutex_validated;
 	struct list_head		validated;
 	struct dma_fence		*fence;
 	uint64_t			bytes_moved_threshold;

base-commit: ab7e60938be74e21c723223e7eb96cac7b441e5e
-- 
2.36.1.74.g277cf0bc36

