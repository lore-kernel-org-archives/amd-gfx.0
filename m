Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE154606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UUsrEPlx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BB1810FD7A;
	Wed, 21 Oct 2026 11:10:02 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010056.outbound.protection.outlook.com
 [40.93.198.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0648910FD6C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 11:09:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uj81HQBGmRfm2nZjaoKCmTB//baRvcBszyRkaqwLdp4Wh190veR/TfHZcoUD+3t5YBB8vORXQt6yl7p2mhdcYltP8CboUNkVgWCf3tqEGwyfDfzBkeUtVp+Kbnt5wUQ4Dyi416LHo/dla9Jzd0c1cA0XyI5wWsMXq+zOMS24YEXgGB45wrkrsatoXVnzHdLeZelOMudx70U47vdKRNuEhGdNIun3YgDwhGOtzPszss2qFMc+yKKKRJlQ0dYq6qy6bsKSypZyPyLxZtcxH8lqlBYLroqUz2qQKpKS7bgjLwLCxHI9ktLoIViBGEKz929OIyli2KAdbj+Wafr9RZrARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ziqBHRV5VptNWRSHRxVrx1D/pRL9KxADPd2/wQxKeY=;
 b=QtjyyWuzMbRSjyGp1ae/MrY/CbUq93jIW9RHMNcAuSAIQghMtleFpt/ZZgB0r7bXVp2A1Nw6MHG4Fz48uE6A7hJ0j8la6uj9CKFpFgJ1umPq67z+hD6Nw6vXjLf3e5nvOJvt3wZWPZH2i0wvKH1unAoAogEUYDdTwRcTr4ONxdwFuPv1HJ2M4PzNXltIod+dRCBRmLAb5HhX0/Vejc4humu4YbeCN9hVweku0EosqieEF9RxbFvRPxvza1eqTbrnU5nMvVQHOTQ58w4BOUPbumNSF6ZU+7+cI+WYFMJY0d9vCll8R8h2kwg/as52e4/0/Rx/JfLKiuFgxkT+hi9O4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ziqBHRV5VptNWRSHRxVrx1D/pRL9KxADPd2/wQxKeY=;
 b=UUsrEPlxwi4KV4CwPzBosLGSb0tM7qx6zW4X2vobmQZ1UK7iya/IZ9Hy6N/9gi1ML9F4MQrHW6DPRgyv7x118iuO1V9uQt76ikURS0WNM/pgAHq+rrQ4uGqlNlaR0gyxC6TL4gRUjDJRy8SaYIpNcbUbYD3ieymns21IjxzyD28=
Received: from BN9PR03CA0618.namprd03.prod.outlook.com (2603:10b6:408:106::23)
 by IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 11:09:47 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::e) by BN9PR03CA0618.outlook.office365.com
 (2603:10b6:408:106::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 11:09:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 11:09:47 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 06:09:45 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Benjamin.Welton@amd.com>, <Ray.Huang@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH 12/12] drm/amdgpu: set userq perf state before publish it
Date: Wed, 21 Oct 2026 19:10:03 +0800
Message-ID: <20261021111003.3371005-13-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021111003.3371005-1-lingshan.zhu@amd.com>
References: <20261021111003.3371005-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|IA1PR12MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f99fcf1-47fa-4a79-0b16-08df2f63d1a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VS0NcwfjEZCUZMZGji6hIe8+v76bEqPR0YRtpf0KPj4b9glhDQ3YlXPg5TL9U5isLgV6HaD6eFb4jebrgl3etEdzKtYnWPQLPuoLvB8MsQdlJ/6fe3XCFJmEsnHiMM3mMV5ybwxIJtQ/8aQq3VlQ3MI3VpInerlg/CqbWyjqrMeunLR0MJYW51/9w2mQMEdJvWSTQuRnPOLhJXkJPXU+t38kVgFjiTGUBb4tmYytT4hIExnHIVPNTowLgtG3oYP6cxgw6FIlN+LR80sZa3TbtHIKD/3WAbylTuw6HMPlzePwLHvodWqmlXSk/oEpSwZBTV4QvZt+TGhz4+ep9uzxodAh+y51W24QgTZEX9T8jydelNp0RpU2vawmQQ1bx/LkEzvnZqA+sbbCCKBuxROxRtwl7ClRo3mg5ZwLT8eCMopKdBDNThmKTZ7lHcWiTDFusqXlYyAmV+eWoYxepRvIFJYtGZNBnZWLOBHhue0b+Z76gwffW+zFSPJv/m3w53B59h7KVnWvjYBQTO7Wu2z9WlvVsL+8erZhcXZJl0KP0D6cv6ruyp70M7W59VbhWI8cCjDVFV1HRikrcNrolYt0jsNkJ6EZwXaQfqIqI6kF1NFBXX1GhqXhRyDaQsgh6lfM60dDiA84hrM/8X4pQ7GU3U8edYk7kzFFGtOiakQF55SvUu6kD/RrXEmLv0bC4K+MO4Mh2H62HT60jW+FYTy9/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6W3wVg/HxYwG0y9EjW5ZzJmZaX9QB/b8ChfDf3F5cI+YNGE7iczuuL7dAQ/OwLkq0sHJRCtkOOlURj2A9bj9kiGWXe2l+2InApvAkPA978DnZR/DGKTkofQn160cEl5PZtQZy+TtyLTMYynsTpQruyIoA0UQ2GK0Bn8S7Mji7UraSpxPWQlIzb99twz9XIlAnCZ1am3/8HnbdZNMdIN2foooIbDOeMc0avOsA8UrC1Fa00s7A1oNtzgFHX8pVvZYwBWM0xl58ArqiPHBiG4soVUI2eDh2NOegW64t24jNNlegAGQcD0RegOLbUBhnK2gpofpRn9FtS7zWtg67j9pL8aCNUu/o8MVB1X8ZC/GzhXGlqh8NKIgyLQAsmrvCWyx0rnZrjZczHqZSzpWnZNg/XjH7QsWaYs3KYSzxz1jicny8GTRxIqpFSCPUe+94sfB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:09:47.4803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f99fcf1-47fa-4a79-0b16-08df2f63d1a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit sets the perf state of a user queue
before publish it.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 27 +++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 758f3b8c5c5c..6be290da3951 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -716,6 +716,30 @@ static int amdgpu_userq_priority_permit(struct drm_file *filp,
 	return -EACCES;
 }
 
+static int amdgpu_userq_attach(struct amdgpu_device *adev,
+			       struct amdgpu_usermode_queue *queue,
+			       u64 index)
+{
+	struct amdgpu_mqd *mqd_funcs = &adev->mqds[queue->queue_type];
+	int r;
+
+	mutex_lock(&adev->pmc_profiler.lock);
+
+	/* set the queue PMC state based on the device PMC state */
+	if (mqd_funcs->set_mqd_perfcount) {
+		queue->userq_prop->perfcount_enable = adev->pmc_profiler.enable;
+		mqd_funcs->set_mqd_perfcount(queue->mqd.cpu_ptr,
+					     queue->userq_prop);
+	}
+
+	/* attach the queue to the xarray */
+	r = xa_insert_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL);
+
+	mutex_unlock(&adev->pmc_profiler.lock);
+
+	return r;
+}
+
 static int
 amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 {
@@ -815,8 +839,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	/* Update VM owner at userq submit-time for page-fault attribution. */
 	amdgpu_vm_set_task_info(&fpriv->vm);
 
-	r = xa_insert_irq(&adev->userq_doorbell_xa, index, queue,
-			  GFP_KERNEL);
+	r = amdgpu_userq_attach(adev, queue, index);
 	if (r)
 		goto clean_mqd;
 
-- 
2.53.0

