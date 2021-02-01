Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81451C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F0661481
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F0661481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B416F89FA6;
	Mon,  1 Feb 2021 15:52:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F3F789FA5
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 15:52:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3GiXGiyEuvDr5RpKTO4CE0iYojcwyIkZgwGGO/ngqn51CzDSXSpSOyFxovn57wDfv/JM7Wh6S7DTFw3DTaycMR7ipJmJCMWNn5WKTuGhaA+8g7FxujCsOw25rEyR4+qo2s/vm3uX58ILGXTbsEx6CE8DhUIzq5UHRwkXXRp7tlqlwjOxQJQhBnTwWPirXzpc2e+bv5vjSQYV0UGjd7OyJJsv2UrcUBkVtynVsifkN8RykJYf+UF3Dhu3hqN6IU6HJvHj5+GEYVyBpg+BMkUHd87N3Pcb7ZQK0KvBS6EcMC7fA6kubWS67ZVhtnO5B8cykM/u8j8E5o+Lgvfh+K9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4FIeGLhWdXhLJ2NYi+FdWxTK2eeea8qp8rEbYaaGs4=;
 b=Eq93cZjPJG+wb2r0oCr6JUll9P0vHTvntK+CLdf6fCVoA9ZTL3EqQAGiDh9TApU8lsIyOvDXdQAPXvP11QBCT4yP4TJQu5yuT54D2eH364IxmIA6zc+8qG1/jb53XojFBhE4X4+TU0H81lVs89yNochwBO9nvHI4dd6HPG/PBhDfNVPFjpI67a8j03rTSorECDvIdKsg/2OqpsN9Tt+Q/VgQZkBuU1AvLm4Um4Z6yOCUgQSuyn+/nvtbqNAh2+L+edXVbIz1UIn/0WrzPFrNGMjY5D1DL+d+wKVZNt7UfCWdzLaCCJ/4b6sLFMm6tLZ61Ljc6hyI7yjJPpO1awDscw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4FIeGLhWdXhLJ2NYi+FdWxTK2eeea8qp8rEbYaaGs4=;
 b=fpvI1goEiBD+cxr9rHVMXg7Mf6IpRo9FzdPxLQPUie4R8/jDbw+p7cZA5ho5Z31npRnHZM8ifvt3s8Ax+ADpfu8x0ri2HdTCx5/0AjHABzG+I8E1hnEC68eD9eUGdNZ97RKD90pot4yqAeVzVP4c9H4Pc2Kd3VfTmNLUzhkSq4I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3066.namprd12.prod.outlook.com (2603:10b6:5:11a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Mon, 1 Feb
 2021 15:52:07 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Mon, 1 Feb 2021
 15:52:07 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: cleanup struct amdgpu_ring
Date: Mon,  1 Feb 2021 16:51:52 +0100
Message-Id: <20210201155155.103360-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [93.229.32.223]
X-ClientProxiedBy: AM0PR04CA0129.eurprd04.prod.outlook.com
 (2603:10a6:208:55::34) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.32.223) by
 AM0PR04CA0129.eurprd04.prod.outlook.com (2603:10a6:208:55::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17 via Frontend Transport; Mon, 1 Feb 2021 15:52:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f80e425-aefa-43a5-5adf-08d8c6c953f9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3066:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3066C1AC775A370432E1C1C08BB69@DM6PR12MB3066.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rxeEswXUKaSsZWGKDJoVon+TsNcBqPvyOqf2+MkmPDdiHfTc4C6Z9XqLNq8KSCh13WZtoJ7ry+ZxJaq9pccyW/m1bGM02fEH8eHjjhTTwe0MEjneZ9iwpR483Q8a+stoDkroARx2aqYG6vW2aPsRwNPwmx7d+ZBYngqIXcsMV6u+ifY0onvDN3E3702jPbtyOo1sxHCYwBQ9YAIxCuC2tyGe8CqisTQiDZlivTr6AYwGy2shjSibgWqxdFmNncwWXCVC/yzbV5uFJgKkIH6WQ8fxxxD2o5Ckky3iLJwWWzj80yJaJB3Nh87688d5CVSiS9erGFkJN1wC4sWV0WeAqhbIgYRK8N9sY9GKdGiffAUUZjpGZr1xLKednCkRqlLeTQXa9Ql/SfgqChlsTnyAVX878GQ+ZOs6wLrWW19HVppkM3TSsGlctSuSx19KIddv/B+NF7bA1qIwEhS2/ZoZHoy9UlUhY60Hz1uKuNUW4icJiOqmROeo1nnTFWPJbArOVdcwrketE5M8krRr5OQ5xQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(52116002)(6666004)(5660300002)(1076003)(6486002)(316002)(66476007)(66946007)(66556008)(6512007)(6916009)(2616005)(26005)(956004)(16526019)(6506007)(36756003)(86362001)(478600001)(4326008)(44832011)(2906002)(83380400001)(186003)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eCJk81JGtrdVAX/hcmprFt8GhgPrr3f5qoUuRZo+KC+9GMuKnJP3DZZhfFKS?=
 =?us-ascii?Q?UE9RopRTyXXPy6lza0VH4bzFYygIMdA2Kdrp8AIOxUjV1iK8ZOi5SK8cbrQ7?=
 =?us-ascii?Q?JxHofRW2l2R/XQsksTxsAoV2ieJ/K1bfWtYe9QR+LMPOwVpkB8oO3GmWBatQ?=
 =?us-ascii?Q?vmLMkW00AaV+LWbHLz9NE9WX5VpcOEHfSopnVrqzskRmnOtgZ7tfitkG9D2P?=
 =?us-ascii?Q?fVudaNGVE8VXu3+Ak3r/Qx8H7yaq2g1kmdEeDlf6coXksn/e5qyGq2iwbY58?=
 =?us-ascii?Q?+5YAc30Ta+SpysGd9qYsTz4hh+6dSr8peIfZFVGjLhuDjAp2IcVuzLpbp46Q?=
 =?us-ascii?Q?asxkJIXjOb/jlr0HLoCD/+Tdx3dBAyvuv1JEiNfnZFBLBgF6bL2mQ6K13JvR?=
 =?us-ascii?Q?VPeMGMF5H2szkExM/k3pbfDqxxgcIfamMgfcMrQsncEEpberWn3AXGqDW9sf?=
 =?us-ascii?Q?iwWk1fm0A44ww4Q4JV5P3JViU7Ohpo021AI1MqY7jld96E9ztiASlik6u8PX?=
 =?us-ascii?Q?QyVnMNa0fcHNvTVEYPt99BUJyjGr3bcdpXkzNCF+/O1CNw4zwin0q8vPmu7u?=
 =?us-ascii?Q?G3Jcb4apmL172OgvMuYjCeTsIughY/lsdiQdwlP7zp8SkTNR4lXdzOGYytx2?=
 =?us-ascii?Q?jFO8anynz9pPhSMiBYjCXmk/TZ8a5JUvaeAP4zg/mu9wTGe8Kz3kgU+XdWX5?=
 =?us-ascii?Q?52xE/UmF7uUzM3rE4ZXqFWRP2SZQyPW9exn4cWaM3zEuVqlA9FrA2IHKowXr?=
 =?us-ascii?Q?gNgtaCe0YiH3zThKfNaCJ4m01TRCnUI/3B3EGXw/HMaHzX7ubYN7cji3n+Yc?=
 =?us-ascii?Q?FjPjXquiqMPRHYz3HQnNMX4dLrF/58mjf6bwebjeqgPF1D8br+eX00dQ+2oq?=
 =?us-ascii?Q?8Lo/bFm1LmJHyvO7aDv5fS5qFBv+pY1MybxWy8qro6BdH/BhaidWZzDrul0l?=
 =?us-ascii?Q?eOjrADLt3r0G5M00tS9OTsYyqCwF1vWcLJE4BPB9lmQ0e72+8A6VXt5DonCK?=
 =?us-ascii?Q?/e96CO5+6lD+BOMSQuzL2AewwDsUHT4IT1/ztyEWaNyrTCn/ZV8dWQv2oEnr?=
 =?us-ascii?Q?i6FDOsVv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f80e425-aefa-43a5-5adf-08d8c6c953f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 15:52:07.6249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dAbI6Hbbh3nWaflR9jqV0htLPLMG6zHE+SK3kEkwoMmB+rcRx0o9VltraB279cc108ObVtnX1FkO91abPyVew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3066
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
Cc: Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>, ray.huang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch consist of below related changes:

1 Rename ring->priority to ring->hw_prio.
2 Assign correct hardware ring priority.
3 Remove ring->priority_mutex as ring priority remains unchanged
  after initialization.
4 Remove unused ring->num_jobs.

v3: remove ring->num_jobs.
v2: remove ring->priority_mutex.

Fixes: 33abcb1f5a17 ("drm/amdgpu: set compute queue priority at mqd_init")
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 8 ++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 6 +-----
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 1a612f51ecd9..b644c78475fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -166,7 +166,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 		     unsigned int max_dw, struct amdgpu_irq_src *irq_src,
 		     unsigned int irq_type, unsigned int hw_prio)
 {
-	int r, i;
+	int r;
 	int sched_hw_submission = amdgpu_sched_hw_submission;
 	u32 *num_sched;
 	u32 hw_ip;
@@ -258,8 +258,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	}
 
 	ring->max_dw = max_dw;
-	ring->priority = DRM_SCHED_PRIORITY_NORMAL;
-	mutex_init(&ring->priority_mutex);
+	ring->hw_prio = hw_prio;
 
 	if (!ring->no_scheduler) {
 		hw_ip = ring->funcs->type;
@@ -268,9 +267,6 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 			&ring->sched;
 	}
 
-	for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_COUNT; ++i)
-		atomic_set(&ring->num_jobs[i], 0);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7112137689db..2ada80ce42f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -242,11 +242,7 @@ struct amdgpu_ring {
 	struct dma_fence	*vmid_wait;
 	bool			has_compute_vm_bug;
 	bool			no_scheduler;
-
-	atomic_t		num_jobs[DRM_SCHED_PRIORITY_COUNT];
-	struct mutex		priority_mutex;
-	/* protected by priority_mutex */
-	int			priority;
+	int			hw_prio;
 
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry *ent;
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
