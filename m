Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6F3C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jun 2022 04:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E89A5113BF4;
	Thu, 23 Jun 2022 04:39:58 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF9C2113BF1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jun 2022 04:39:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moP6DiYFLDBDb9aBltaG/h63Sx4PoWrowicBZ2l61E2mWUg2IVwjkBxIkpyqCVl98df/4dL795n08nEGM+syOjqQbwKP00Xw0koQ6juqWGP5Z7gSfV8TsAJpTI/K29dFXGjyaRl0a2BctM25zqGzDKePMU5z5UCtjZmPVJbh7E9eOKEbGc6Arc9lzj7zkHielSxYqbxsSQTepNY1w7XW/EL/OBRnWugEJtQscljlGFhnySrywcEKWkR/wISTbN3kxFI0mIYhHyjkc3r/kKpL1c5Hi2g4fyclf/DtBn9SEgxd8aCiTNiTAiFxWQxuW0SNyj8jMo88DAlvhzwLhUalGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoSTqmdPJcWwIM6RgR+QvCb/YDhzKXoITcgflclrrCI=;
 b=Dt/KJsc7+asw7pVvVGconGuh2qtWPKLroS1cZi+R2kJYhlT7TLJTB3cQUlao9/ga1/dt4dc+0TTIoeaARkK/HBrxiJGg/I5OCiMBGrcVSL29JQqdVrOrJ4WLOakVydqBfIFWefBqNlbyImRv+lQbrs4A0YfNnHWoEUDKoPOJf1Ub6FaRX6KLbFlw+vkJNXB980NRn+H740DQ01ZYly7BlOokUvwkyhVClDLyNDennRqDYWIPHjhRR9UANwbqGre5Lu1zhC4sgMoClyb+jWClVZtxIUDfaXHF3UaR+Y8AknJP8VXOQUbcpNVYCQnlEUbxQvaH1tU7D0Myt9xK0FE7cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoSTqmdPJcWwIM6RgR+QvCb/YDhzKXoITcgflclrrCI=;
 b=XTwDjrFRzr1o+vKFT73QFLLxppLGumT1jn0XJbkILEUtUJC/Z5YruJoVMkqWsk6V5I6q+RcO+djDn5xDge4YdqwiflFtuKRrIIcmhnJ1bE79tKwZVc0GP6vtOqTqGD6Tueak0+4s7aRBw8Eg4p6HEmAc4NiV64lzHhDNXL0JtRg=
Received: from DM6PR05CA0049.namprd05.prod.outlook.com (2603:10b6:5:335::18)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Thu, 23 Jun
 2022 04:39:56 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::ae) by DM6PR05CA0049.outlook.office365.com
 (2603:10b6:5:335::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.6 via Frontend
 Transport; Thu, 23 Jun 2022 04:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Thu, 23 Jun 2022 04:39:55 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 23:39:54 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Protect the validate list with a mutex
Date: Thu, 23 Jun 2022 00:39:44 -0400
Message-ID: <20220623043944.29880-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.36.1.74.g277cf0bc36
In-Reply-To: <20220623042512.13815-1-luben.tuikov@amd.com>
References: <20220623042512.13815-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fb96db1-aa94-4a0a-455c-08da54d26c05
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB62147B8394FA8A427AE6BF8C99B59@DS7PR12MB6214.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7zdTIDaCXzHmlnwQ8jBhyy60/xi11+PxmN19+rlrA613B94Nck5r0KAs8pV1WvMAWBlk4HtDoVK3eWx/jeyjNG3db1wWKYZW815qqRuoEVDCW6XWnZRt8h7Ph39PbZQAVsmatqXRoKPXlPQpILGnWOILj/CxSBij7fmC42WAElG8d/U/q55CZybMxZk9WR/ky5EXXfm/L28eFY4jBb8ZxIylCP8sKjdb5ANycqaLIM9fM+hRUVUbNLsShk7IP23pph+X7mar0atQOmCsyzzbk9Yfn6UPJv+yCHRP1LdyujfGzzvsrJ2tcPi3ra4Ug1Zk8DtOVCGX3TvHRIv2MeU1gnwQFcr/VgpWFdygDfKXGvyODoBfeV//1Uj5BlFiC9C7EgqGOZL23PzEMblG++rLV7dUqVS5wZ67MhJJJ7M8YraWPNIDha69zTX2xVk2GVfNLndTvNgzhpuvE6NWOVFBT+4fLoTpnK6Vc8T/xBLIkn/dNBJE6sQzdwaqTvPpBW5qmC6FkvLq0a8zI0kytzbpQ0STlWHvfGrOJsN4VuPxLWgv1zpye8agXvZhnlTZoWcJb6lysmU1XNk7U6J/SSo4SidegR0VwXxCrhtzyqNl8PEiuz4lOa0gvz1O/Vv1Oep2/3Dzh09+r+YkpPtDp/7K7gm3lT69RGRKzHWgcSbay7DBCjyrODYAqwo+ryopcYJv0i4/ksqp0XiH24JUKxGP9PZzBRwlKE0U8AOYLe7xMS6wnYFXOcH/jshvixrJqZrA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(346002)(46966006)(40470700004)(36840700001)(7696005)(966005)(6666004)(70206006)(41300700001)(54906003)(316002)(82310400005)(8676002)(70586007)(478600001)(2906002)(26005)(86362001)(36860700001)(6916009)(40460700003)(356005)(5660300002)(186003)(36756003)(83380400001)(82740400003)(47076005)(1076003)(81166007)(15650500001)(4326008)(44832011)(336012)(40480700001)(66574015)(8936002)(2616005)(16526019)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 04:39:55.7559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb96db1-aa94-4a0a-455c-08da54d26c05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 30 ++++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h |  4 ++++
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 36ac1f1d11e6b4..0be0bf17c05420 100644
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
@@ -670,8 +682,9 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 {
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
 	struct amdgpu_bo_list_entry *e;
-	int r;
+	int r = 0;
 
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
+	return r;
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

