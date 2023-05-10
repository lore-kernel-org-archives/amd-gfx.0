Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D39C7EE22
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0561510E538;
	Wed, 10 May 2023 21:24:03 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A16810E533
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:23:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXH/DyMmqcsWrndkrtZKrrr8KEkQ0hOwGba+6CJ6GwJ10gHWphFbJlFVzDOz/3fYyjNX3+9WcN6UHw38ZsIjZRiAsVtswygn+vDV6RqPsX1/Wys3w3DrAwQ6hW5FDhOatsH38plXqGdRvfTgqkKdw/P/QGFhNglZVo9j5y3JsRf4xHCu9wdkf42x+QpIyXMhHhSz0H6zmWdv3TgJP1PiN1je/V3Gj1cChICihOeld8ipn2vQZLryOca+oTj2dMF1+HFqSv78tPworu/cvH1S4gnLd8ihjzL4T+y0dL190yvX6yvLtD+/90KYdyjPokrAiqOooHo4h41JXj6IxBAxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s14bPsm9uWyf9vg4fWWepS+FNSV4ALrGnEWmhT2iWy0=;
 b=kuvGB22D1sRR/9U0tHtrcPnkUE/7xXfSTpUSuDZekx3wlnbqdV0zNIErKcxisn/amc8hDU/6rgydDuxacciX8IaW8XQu2sWG2ou0Ha0KDaaYRlKAARlFzJYdl6JYttFJlvCXhMVFZaMee1Qm2/byYibfZ0ZgkdaNx1yTlMGx63leTfOqVp9zIdyruhQgigr5EGzlGR7Ux+KQaQM9Lnm/Q4hUwW9+UIsT2CgNwCR+8HMGZTeZtWmSlmSGpG8OsyPxJxEGc0SvmjtL+d7/nqqEOUgej0bwXVABc4rguZvc+/Eb2skIoX4PRUbCJjHle9epafjabZxJX1qh0hdMZicrVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s14bPsm9uWyf9vg4fWWepS+FNSV4ALrGnEWmhT2iWy0=;
 b=VYE357BwwyLwqXaZbtM6EI8tzhfXVkhEk3WJhVZhXXCr6ibezw1mXgPQUpfkkKFwkzqte1K3rfchvhQNRt7O0aq2/OkW3ouqqHFBTbAjKgwZAm0ghy2QxSnFUmL0aWnZW9zHTO8HJSOvB8H9Rb9zexGDsy5Sb8+LtoO6XCkan/w=
Received: from MW4PR03CA0065.namprd03.prod.outlook.com (2603:10b6:303:b6::10)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 21:23:54 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::5c) by MW4PR03CA0065.outlook.office365.com
 (2603:10b6:303:b6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Wed, 10 May 2023 21:23:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:23:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/29] drm/amdgpu: update ref_cnt before ctx free
Date: Wed, 10 May 2023 17:23:13 -0400
Message-ID: <20230510212333.2071373-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd6e8c6-8b6d-4120-1e0e-08db519cdb74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FqqxJ+3OJMcSl1FlPr8kaJdrF5/qZ4PCGCe76CaDzEVhlbChwusv9hvduz7i1zFCkytLiDgCQ+OqZaLbv758FviPts4r9GrQboYtqUzXuko8ui8lAFdV6UellBiX4JWo4agNRkcYt8HqIvE5H7bU10uxeIe2gXmjJK7meeFFFROvkX9wrMz7Mvj/9ha+hMTAZD1M/GKVhbpdNq5P1bJdXyBukZEXqhQMKIZi9tMNI3vtGb4/14oTWKX97+dDMAETiLMAHlY3r07fCBj10VjoxXtQKUtnwLk9EhmoFyc2Exn+2mYlo0YeedOXt8Hzyr5Nu4+SkEsMDCYa1RjF6YgfJQm2m7HCHyircfycGfvF7x7wKIXFXvOQkMKGZL4IYB3Kh+88oqf1kxlNmvd77W0jV4+eMiSNNa04uV/KaXSPyog01kebyswwgYq2hQ1GNsYVetcqqKELbld9hlRh82mOEvX0NQjp1hwvSkMeXm3qnmN/IJsFhxneRgYMz2ROBj2SwcnKlYS37QzVpgn6P0dQsPD2V7sI72CFmQfFoWDQvs8SGsTipNmaSqwwBS3rCbs1KoYFLmHnPMqRddI18FBtVEFl88OwUqXiCUssqmPh9ALZ7LxGPWBQyUGROyS3lWHQwDH9Gpecm/9YuU4ZwlF2yKqXgnWPmiRWqWKxJUAmq1fvXeg2k2hM3LYDTLVpy0acoeyS45jLniGY+BJh/cwgwhJAGiZuYPQQTgDee4l3vSE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(54906003)(478600001)(26005)(7696005)(6666004)(41300700001)(15650500001)(8676002)(8936002)(316002)(1076003)(4326008)(70586007)(70206006)(6916009)(2616005)(2906002)(83380400001)(47076005)(16526019)(336012)(426003)(40480700001)(186003)(36860700001)(356005)(81166007)(40460700003)(82740400003)(86362001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:23:54.0062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd6e8c6-8b6d-4120-1e0e-08db519cdb74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Update ref_cnt before ctx free.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h |  2 ++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index e579bb054a58..3ccd709ae76a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -266,7 +266,8 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	return r;
 }
 
-static ktime_t amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
+static ktime_t amdgpu_ctx_fini_entity(struct amdgpu_device *adev,
+				  struct amdgpu_ctx_entity *entity)
 {
 	ktime_t res = ns_to_ktime(0);
 	int i;
@@ -279,6 +280,8 @@ static ktime_t amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
 		dma_fence_put(entity->fences[i]);
 	}
 
+	amdgpu_xcp_release_sched(adev, entity);
+
 	kfree(entity);
 	return res;
 }
@@ -412,7 +415,7 @@ static void amdgpu_ctx_fini(struct kref *ref)
 		for (j = 0; j < AMDGPU_MAX_ENTITY_NUM; ++j) {
 			ktime_t spend;
 
-			spend = amdgpu_ctx_fini_entity(ctx->entities[i][j]);
+			spend = amdgpu_ctx_fini_entity(adev, ctx->entities[i][j]);
 			atomic64_add(ktime_to_ns(spend), &mgr->time_spend[i]);
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 78fce5aab218..9b960ba0b7ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -366,3 +366,19 @@ int amdgpu_xcp_open_device(struct amdgpu_device *adev,
 	return 0;
 }
 
+void amdgpu_xcp_release_sched(struct amdgpu_device *adev,
+				  struct amdgpu_ctx_entity *entity)
+{
+	struct drm_gpu_scheduler *sched;
+	struct amdgpu_ring *ring;
+
+	if (!adev->xcp_mgr)
+		return;
+
+	sched = entity->entity.rq->sched;
+	if (sched->ready) {
+		ring = to_amdgpu_ring(entity->entity.rq->sched);
+		atomic_dec(&adev->xcp_mgr->xcp[ring->xcp_id].ref_cnt);
+	}
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index cca06d38b03d..39aca87ce204 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -128,6 +128,8 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev);
 int amdgpu_xcp_open_device(struct amdgpu_device *adev,
 			   struct amdgpu_fpriv *fpriv,
 			   struct drm_file *file_priv);
+void amdgpu_xcp_release_sched(struct amdgpu_device *adev,
+			      struct amdgpu_ctx_entity *entity);
 
 #define amdgpu_xcp_select_scheds(adev, e, c, d, x, y) \
 	((adev)->xcp_mgr && (adev)->xcp_mgr->funcs && \
-- 
2.40.1

