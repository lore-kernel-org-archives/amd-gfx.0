Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DE1CAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 08:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A9C510E66D;
	Thu, 18 Sep 2025 08:18:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FbDXJ/cX";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F7DB10E66C
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 08:18:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHZqcwOwfukaWZYc1nEaFgizWuNDaf7K3wOCRSkKA2mkMjDuTYNfgtpec992CEJ4rkAynb1/InZjDv8XGKvJi+fkPLFcH4IY4A2ojX/fQdMRKwF/ttHMKSvnEExtmoJzMWKJxtEGig/p6YFGe+IAYOBnsY9s5ev3Wh7QHojDDhBbIaeBNpuzbV2sJWSpgA5e+u90doB/3gdjY0EvHXKrN0vDEWw9G0wxlGVCLdjIzwnQZ0kc08G+x7h+TLl2JHchBe5qrnFdpOd+KAo01zjGflBjBsZcU72xgipkB3ro+zl2xJvi5/YjcCvov6yPNuSOrDZ5u8UwJ9SJcPMcvb9HXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLq7IknDWDclY2wIp4bHnTFP/hk0okqUyRcawD/JSEg=;
 b=mSNlNK3A3qTYB2YynF1/3aXfi1ilNrJ5ABrouYV5tz5+N0s5M9N6tXUTVIyS4yJfHLTzACm6lg4LHj2py5WaGyNPlZ4dc/aVv4xw3IbrpLhy3uWVfn603IbkH/PUj5kq2edN31/pzWOokqMuReh/rceUo6BX0AueVKlF8xxAjraPZJVNO7WYIUjJao5fBJCAmMnRMCyQACGaXZrrTyW4K3xJA6FTQQ0OQqbzMH+ebVq0szuLkSIGk+jZxdO7oRwMjDRo0YHjcSTX86nJhCz2j3Q6D9KjxRMiq6W/tx98MwwEYlxqQ2op5CH7peeIS3FG+vZraPEUDbnwBlk0aB/ClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLq7IknDWDclY2wIp4bHnTFP/hk0okqUyRcawD/JSEg=;
 b=FbDXJ/cXu7R+PlJTFynvPMGZ48PQr/b/wbTaMxEutuusfH8ts1upVaauVpMVOucYhHwBUtl4J/a5Q+z4uAZOsSg5xJSOGIUqbr1Vlgzue5OOP+J/Lfwjw0LylobqJN2o1WdhFDqBXU/md5+qh1F0kFAfKN7SSDRKUb0/35tW8vU=
Received: from MW4PR03CA0245.namprd03.prod.outlook.com (2603:10b6:303:b4::10)
 by DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 08:18:53 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::11) by MW4PR03CA0245.outlook.office365.com
 (2603:10b6:303:b4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 08:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 08:18:52 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 01:18:37 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 08/10] drm/amdgpu: keeping waiting userq fence infinitely
Date: Thu, 18 Sep 2025 16:18:13 +0800
Message-ID: <20250918081815.2755437-8-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918081815.2755437-1-Prike.Liang@amd.com>
References: <20250918081815.2755437-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DM6PR12MB4387:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cab897b-2702-41cf-7d29-08ddf68c010a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5FTwHgAzIwPbG6PUNTm15zySrK8Ad1eR7BaMTI3PrTukTsYKsOlhJRDEsqBm?=
 =?us-ascii?Q?2W5ZmBD9+XPbl9dgtwLNh0V+jO5AbbuweV4k0EhE0gmj/TwKiZBGhu+YbttO?=
 =?us-ascii?Q?ad7HALgTiQZtDEotTYsyH3sS2BCO4CqRfpM/u6+WxR1bXyCF9RQR3j+3ldll?=
 =?us-ascii?Q?Z0pEv/Zj8ldkijFHD7Jrqp3oykL7zwqKDhS5HhePdXTNXEl+D5oLS+z6GE49?=
 =?us-ascii?Q?aY8MAnT9qUwHZQJhtarpuXAclFjltySSXA17dQWBR2axx6bygVj31pF0XE+h?=
 =?us-ascii?Q?ApbvB/U2y6sVQca6uQCd8H369Ew0ivYhIYwmhaXChCVi1HYCGQkh4lGEICYm?=
 =?us-ascii?Q?aaPM1+Xm25FYcUJ+v3g8LDdZY+Ae6it+6Q0x8dYapnajvh33uqbIlkds+Hdx?=
 =?us-ascii?Q?2EN6UPs5RIdOyi70i5NIW6+eoopZGtdgbqLeCI3+K3hoXE4aASQpTgVjY3nv?=
 =?us-ascii?Q?aG8mjhR8lSNqbMZtb9Mg6fzOAFj/Dh+1BD8Jbn19sqH7U8OVBIfcPsw3Uh91?=
 =?us-ascii?Q?GKfYzP1NN2pXoOhRTlO8G6W+9uhWUKq65iNhpUniwNAm2UNfbd6QRJdgWBoM?=
 =?us-ascii?Q?tp0Xlvsx9Q6ZrdfdrVJwac47GPfOHwWbaxrbYVMby3CtGCNZU6rcTKXEWCCB?=
 =?us-ascii?Q?yR2Dg6Z/LhZ2lm0vtWK/egXuGOOvQ0fMWAl70RxLv9Qp8UL9Ikh4Qx1+KMuG?=
 =?us-ascii?Q?vmrd9cC9UNfIgJOnFIWw5RaA+dZoBKieE+gXOYCSAI4RbJxgvBibqTZ5IyzB?=
 =?us-ascii?Q?psoTRRSqGjjWCI2KxrgRBMQY5tOUQZN3yS9AM5ecS3geOx0y/EvvqECjuJa2?=
 =?us-ascii?Q?FAl9lJX92uiAgKs/d7O0QJyGu+dCAo/wlRN4rljD0P0Uefje3ofItljhyh3P?=
 =?us-ascii?Q?DarXhBLlx3cIjC5S/rsalVU80U4dvQFNtkgg9aPDbmVh7mNQs8S8gIgZM6Gj?=
 =?us-ascii?Q?aw2JmBaxJ0WPVVebjGFSbbeF/MRAUOqUv2koq00NVldUCEARFJeQLuORG9FW?=
 =?us-ascii?Q?Isq3SaSNtXO7r03+k5BwyCv2S0OP9Ndo8bYkAX9k+eUFx1u4+XCHitUktLVT?=
 =?us-ascii?Q?klfVqWb7G3ImBXb6FqTVF1ruq+GCT8sisumIOP1DB82ceM+eOWHz/4FNrr4E?=
 =?us-ascii?Q?o6Z0vam5lpHypij3HgmTxw0WG18fc5Ft9y2hATKetWTCC5VG+IS3IpUeo+nR?=
 =?us-ascii?Q?FMck9iHBnDsUpOqN8ZDAdJkd2aQTP7zK3ZZq3OtgxIJm0nSxwdLP7T2GnQ2N?=
 =?us-ascii?Q?E0DcaI3hU5zJZr1OXx53rQ3WepPS8vspjKX5yXqF9pYuBwqeqQ1ElgM5LsRk?=
 =?us-ascii?Q?YJQYjGA6/yzsXTbfeGIIp8bB/8dryST/LbRsFWcO33jZQafDmDT4WJ6FzPHT?=
 =?us-ascii?Q?2HWR9J8/DQUtlMGtxjdkRiiRH7Utjqs3Mz5eWg4ZBF7SbMmrPhbLen0aEh0I?=
 =?us-ascii?Q?y6hyCXwGUbeZtvGlXfrFNhCfj1L7mDcHT4tGGjRNHnXCaeEKCc8qKKQqYS3W?=
 =?us-ascii?Q?TvpGL9nl4f8dg/YKlDy9yADj7NtWhFU3GEjT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:18:52.8469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cab897b-2702-41cf-7d29-08ddf68c010a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387
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

Keeping waiting the userq fence infinitely untill
hang detection, and then suspend the hang queue and
set the fence error.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3c8f05a9e82d..5c918faca776 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -193,7 +193,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static void
+static int
 amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_usermode_queue *queue)
 {
@@ -201,11 +201,16 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 	int ret;
 
 	if (f && !dma_fence_is_signaled(f)) {
-		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
-		if (ret <= 0)
+		ret = dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIMEOUT);
+		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			return -ETIME;
+		}
 	}
+
+	return ret;
 }
 
 static void
-- 
2.34.1

