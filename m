Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEA9EE801A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 16:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EC9E10E914;
	Fri,  8 Sep 2023 16:06:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12D2010E913
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 16:06:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oh0qP5j/pVwGS0aK2JEHPRBjsl+kn3AvWvYl8IQkblBwLUWhwlPtEFk77AH8BykoSqlcac4Lp18MMWLsRpKjX0lAVVpJwndim8SAT6NI787MWNhyJ21zEOIcanpKGhtixvd1kEiNqg9gKKC7E5k+vLBInIMRkQB+B9qGUSs2ahBqxCuA+DULNaWGPFN0awn40de7RLJKsikUREmhLe8U1o2AUTziGbYqOCY49QwX4ZbapE5TPCtm0vLB6WzOQGj8rqQ7FD5z1lVKln5ObkmnMbO49ae1Nephwy5tZ8TxlwP1jiqQ+544q2vUUMfi8A7XVxoVdeFnQlq+PgRivay0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9HLo7gzIil/tmEMNIHl7fJzgtkiyNR+MNwSKG9ioK0=;
 b=PVix2EScQmg3jHnfl4ISZDTpuQyLg0LrTzfhoOjaNT0ciRlOUZkU0C89luxfOcdwbTH3744ChjsD/w1VhtgV/I+TvtEb0D/xqDKHD3DX2Ml70L1F68MIUmo+bEXyXtBwhAmx2V2PKe6RAs1zdJyEgLQ+HvpiakZ5r9L3P/8HW19nKaCkmW6crB5BXFSVflGDFPv4PwSpoXaLGDeChnqefzi/fHXp+M1AKhvHj9q9RVJ7+6DgEgBrvz0+4fCD/Pt+a73crbSapo97J7Z+zZJRZ7jVlJR1VriNr9tyTjCmZaL5n11WeO6h+3m+DWD5f8oRbOE0GSdqwVP0HJz4LRpOXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9HLo7gzIil/tmEMNIHl7fJzgtkiyNR+MNwSKG9ioK0=;
 b=PPCu8MJBvsbCKFT2Af2oi1flo9YwqmlE1lP99Gu9l4eCCRkJZwCKM13vX4F6km3GmgVSyWUamUxji/xdOyxrwtZWBR4ofZFiXhQzHgqX1On7s1ZbwDpWSw+tIdMoDhat1Fg0z1DdHm3yH6VIp2AOW51uqAXmstW5xuzAFFYArgM=
Received: from CH0PR03CA0221.namprd03.prod.outlook.com (2603:10b6:610:e7::16)
 by CYYPR12MB8702.namprd12.prod.outlook.com (2603:10b6:930:c8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 16:06:20 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::73) by CH0PR03CA0221.outlook.office365.com
 (2603:10b6:610:e7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Fri, 8 Sep 2023 16:06:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Fri, 8 Sep 2023 16:06:19 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 11:06:18 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 9/9] drm/amdgpu: cleanup leftover queues
Date: Fri, 8 Sep 2023 18:04:46 +0200
Message-ID: <20230908160446.2188-10-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230908160446.2188-1-shashank.sharma@amd.com>
References: <20230908160446.2188-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|CYYPR12MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: a99d0e02-dd28-4588-243f-08dbb0858a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5z6FyEgdoXwDrxYFdPATHCAMN34UBOEaca9U7axVq2RcqMl9eZdEVFp+VEZscIjYtwgzGPmoLs7Enw7FiSzFMLkTu6VAsjXMVSLOLMQEWnfznQoYiLAYGiWpuumyibSC/OVOnSjh6rYoxOdGRNp2DQALZnMAB443HW6lOe0u8Ija8gPyyk+lOEzUGGoAisKxnDlKY1pm3cUnMtSxnR7duOvTbY0O2nxdp7m2jrVzNlpNYRd8CFT9W3R7VzNfSntmeX3+iCPJ6GIOTmlXkB3FBNbmrbsnJLYaq9JEfY0kxAAjQQlHGgHJ/UElPNXJjaSz46wvQxE3o0eOtvWx4JQX6Dovr6ObnimYJUBBB9Ebzwr+wTyRQwF2yotrosYnoQmNdHxOTXfZ88rKB+fuP/XcpksaO191/d8/i8j45p1hcqx32808gSMQsBq/Hgs0q55bsNOm2Vu6qHQmyLpb4XK8bmf+wOxCjdWMcIh3DYvTCVDJl0r75WI+64Iw0O5ma5Lg43VN4LV8VU7W5eVhgqe5aqotk2nJSOlc3Zrn8hq+RJxyttCsI+MDU+61WC8+1cbeoyn8vV96heElGR6bFHh7kJKEKof0kgLjtHwJmg6+gT3zlAmeHvZc4+8yliWg9WobaO1vLqVlS0aw8xzbcBL99uvfspXI7q/o5EslN+vZTpIQpg3xerHsQcfxSTiZ6YgEdgELHVOu++KT9Mo/sgRzbFZl41LFf0n7B/sodzoxrM9FT3Uc27CIhG260n/pYbBtly8UZESm/fhKytto1nwUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(83380400001)(426003)(336012)(36860700001)(47076005)(81166007)(86362001)(356005)(7696005)(6666004)(2616005)(478600001)(1076003)(26005)(16526019)(82740400003)(54906003)(316002)(8936002)(8676002)(70586007)(6916009)(70206006)(40460700003)(41300700001)(44832011)(2906002)(36756003)(40480700001)(4326008)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 16:06:19.6898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a99d0e02-dd28-4588-243f-08dbb0858a29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8702
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds code to cleanup any leftover userqueues which
a user might have missed to destroy due to a crash or any other
programming error.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Suggested-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index a311d4949bb8..0c78579b0791 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -61,12 +61,23 @@ amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 	return index;
 }
 
+static void
+amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
+			 struct amdgpu_usermode_queue *queue,
+			 int queue_id)
+{
+	const struct amdgpu_userq_funcs *uq_funcs = uq_mgr->userq_funcs[queue->queue_type];
+
+	uq_funcs->mqd_destroy(uq_mgr, queue);
+	idr_remove(&uq_mgr->userq_idr, queue_id);
+	kfree(queue);
+}
+
 static int
 amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
-	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
 
 	mutex_lock(&uq_mgr->userq_mutex);
@@ -77,12 +88,10 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 		mutex_unlock(&uq_mgr->userq_mutex);
 		return -EINVAL;
 	}
-	uq_funcs = uq_mgr->userq_funcs[queue->queue_type];
-	uq_funcs->mqd_destroy(uq_mgr, queue);
+
 	amdgpu_bo_unpin(queue->db_bo);
 	amdgpu_bo_unref(&queue->db_bo);
-	idr_remove(&uq_mgr->userq_idr, queue_id);
-	kfree(queue);
+	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
 
 	mutex_unlock(&uq_mgr->userq_mutex);
 	return 0;
@@ -207,6 +216,12 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 {
+	uint32_t queue_id;
+	struct amdgpu_usermode_queue *queue;
+
+	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id)
+		amdgpu_userqueue_cleanup(userq_mgr, queue, queue_id);
+
 	idr_destroy(&userq_mgr->userq_idr);
 	mutex_destroy(&userq_mgr->userq_mutex);
 }
-- 
2.42.0

