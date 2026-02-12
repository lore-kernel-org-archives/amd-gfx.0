Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A752DEEA84C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 19:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4724C10E1B4;
	Thu, 12 Feb 2026 19:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TD/Yqhkz";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013029.outbound.protection.outlook.com
 [40.93.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0590210E1B4
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 19:43:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9jDPutJg+nzth/wHFkZlhMER2r6aOif+3b5hjSOKk+z5z6GmHGfb8R49IwpI1Bw+brqbMEBqSRyzTy+P3i1AYcvPpyW6hT8RLCwxHryMgpM4Pa7oETJLxrQzBfPSWvMR6VyrdWpb7d0cnoUKgs4yuXyDopdbk+yI/SV/CMBVGMCNTWSsgQjwy59TmDtNqBouexpuGlhsLqwaAAg1C1oZ0gygFs7Ur0tqE+MQdQHlZu+wErX8vCZhlQjT8sDgB7Ot36zX6Ts8yYQgZa0+bnDE+Y/bmOkm9LZB/YQe0icN3AYq2/nctFWGtbxrLvKOL5pKJccM1/XGjqyy887OJmWuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lzO1mRobqiLntYnDRGRav2h0WeVhAahHMPPzYJA7XA=;
 b=PwgyiWYxliaT6yamRHvAEh7ikood+KuJVKlfXw6+vUjvYXF/OsVrH8hoCUWEufcYnQQP+pI85TC6rgDFKDGNHQ00/9h9X700WllJ/qkDak2s9EkZ8lDyb6PgRGiEwyjerKxz0M6S14mOATkoKy2btzjmJMlstFJLlSmoBqo5ni4dT3adAA8QqpzHjftRRithbjdknQ/wJ0X+lb6rgASflsuYLUzJi3d8b7E1VlZkNDuCJo5/pBGWNBUflx4/GoHM0fnH5BwDwMUaZa3zfTMl8y+WZ3Z3uzUC+ar8l/RDSlWgeZpT5mIM8CtlnVwIOaAXY50AInLOdspxzUYNsp6Zpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lzO1mRobqiLntYnDRGRav2h0WeVhAahHMPPzYJA7XA=;
 b=TD/Yqhkz9xBFNqPEcbAzxETYU+EwasSdFedgnPJxVH9iMzGwmsp86OGVWLC0eP7c/+6QORFT5ItO0651goCwsE4Kw8XOy+LuiN6ZMIvtCPs3KkF4C3KSrO7rWGV6sY3+XIk0g5mbVWP78Es2GYs0JTkBgZuv2sVVj51O/A7Rw04=
Received: from CH0PR03CA0109.namprd03.prod.outlook.com (2603:10b6:610:cd::24)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 19:43:11 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::19) by CH0PR03CA0109.outlook.office365.com
 (2603:10b6:610:cd::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend
 Transport; Thu, 12 Feb 2026 19:43:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 19:43:10 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 12 Feb 2026 13:43:10 -0600
From: Andrew Martin <andrew.martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jay.cornwall@amd.com>, <joseph.greathouse@amd.com>,
 <felix.kuehling@amd.com>, Andrew Martin <andrew.martin@amd.com>
Subject: [PATCH v2] drm/amdkfd: Disable MQD queue priority
Date: Thu, 12 Feb 2026 14:42:56 -0500
Message-ID: <20260212194256.33118-1-andrew.martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|MN2PR12MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1a2ba1-03da-4344-0d71-08de6a6ef443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7RPgVG1vVh4V5dYHQrBMfpVeYvGNLn1K5kcjQMZFkyfpc6QJfm53BC605ebB?=
 =?us-ascii?Q?jnuGKbOkFSh+Dzzhi0QhxtI276k8b4yUhiIie4WUHUaHB+k7lhp6R/hvlqxo?=
 =?us-ascii?Q?y+TIsasWyZf1LrfT+ceJ7P13t6TeLd6Xz5z1sSWp96Jve3i9w932nyEAchL6?=
 =?us-ascii?Q?5DLTJhN0PYSeq/4hcM+pXvPf6gH1q0L6wGEMrFfRn/sd0vqdtob/QeskyAsH?=
 =?us-ascii?Q?Z4rofbjKecCfp2t6zup5XqhhdzsRWb1BrK3N1tMkwmz6Pd3aETwRUptT8ows?=
 =?us-ascii?Q?g34UEyS3EAbyLfvYETlLzp8451NrhXCb+tfaexeYiTTfBUbyN3FBAHY+UJxC?=
 =?us-ascii?Q?WN0PGjosxhBVNnPMFGsHxovU74jwsZnCgdWuTjAGBSGrvvZi1llDfPHI+jNS?=
 =?us-ascii?Q?j4DdkduuY0gl8J0dWIr5vJryQUVHUhut811ZhX84MvwAlKXjWom87Tf48WXt?=
 =?us-ascii?Q?U7hUA+X+cF/cPYE3stEgqMLApSE7MYY38GPl0+L5rc0lyDta8Pek53v+HU81?=
 =?us-ascii?Q?UNOoDqMgVobRYOH3XUdMP16dunytc8uwpXGKZZStz7x4X1BoPp5Ot8IFnzzR?=
 =?us-ascii?Q?yq4sLUQLfpo0anzkIohxAfCdyoRDijF8KO7toXmcfVVxG8JMvLnz2K6f6ttu?=
 =?us-ascii?Q?lUHUMopr4Wq934x3VTHQZrY9ryb4ayr+Q4bABLqgcGcUv/1LoHUTZQ+SgeWN?=
 =?us-ascii?Q?BSBvienG8jMyvMbkiyuLIV3KrkxsDIfJCSLarpHW/PHwOJnlRcbFs/6Fvmp6?=
 =?us-ascii?Q?r53ql7/LP2VWVmoQiO2uM19i76NUYCphyYVD7D0lsGHk9tfmd+vfheJwNAe2?=
 =?us-ascii?Q?+Yc844GZTDK6OitE1o8nlcNEXkjsXdnfK7c7frTbOFJpY82oRq5ijl7rDpw0?=
 =?us-ascii?Q?Ynb9/v1nRhlPp8qBBujXvZYdHrPIzU8/uxi+Laj6RgFKAtikHJpcX4EyCQuj?=
 =?us-ascii?Q?CCFJLUWNncOzXjmGjVo6SE3vgMmiJ50HeDUsgqg9p/Vm7QHiX+RAhm+RjY0+?=
 =?us-ascii?Q?H/v03M+kGxaMYJTmgQcnczYAR6YG7hOOQPLbMBlwdnzZQu3HvEwduzV7lIw8?=
 =?us-ascii?Q?nCsL2fUeQaPuc6poiN6BNd3F1qGATtBqUkixDrG4a7KFAr3OqVGv86nybTsn?=
 =?us-ascii?Q?WbEY7b2lC6NBco1XPEVkQUhEYnVp5HNvEFLAB6zOiCMwKRP2c7DciAnNt9B5?=
 =?us-ascii?Q?D6ScF6nK9F6GOwhJyypQibhOxbocHG+ADjr/4qdXwkl+XBoEjvqgM9sMz/AL?=
 =?us-ascii?Q?eyK6oWxjm4dDHQ+uUAnr7+dYTCw7LUizuzuHh3BRNnjFgo525Zuo0L/QCPYv?=
 =?us-ascii?Q?0ZdVRntsEA1oCxiEWq7bMeMDy2xyV8V5/hWRPKk8k7jYH4BisdHj4rNpfVAa?=
 =?us-ascii?Q?dNZkjUF7L4bfQgNFr9LCSrnuyrSaL/1NyVLJ/sCa4Cqp2GMLqMVvgDdFsB5J?=
 =?us-ascii?Q?9SG3Un/NKTZ0lsOxWsgLlYFfARE+SMHfHEsd6CEa8LZJuw3hdQKBLHdcphkM?=
 =?us-ascii?Q?UY0dokGpUIMkue9HtrGdUbAv8dWrA8UAMZCXCI1DnqKT0TTqVblggBMniQyr?=
 =?us-ascii?Q?KUo5R/i3bMRE6ebTrL9exB/tycwHyX9z4FDJeYYiRGDAraYwOkuU+ygXFlkr?=
 =?us-ascii?Q?+hmPfRvmUjzKnTD95uvRu0w/4iePJLDIJCqS7e7SqE7d+5sKQ6Z+6tNJovrM?=
 =?us-ascii?Q?QU2Z0A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BPJueSSquMCRXq7OCzAOmtQ68tS6xbHEH1Tnsw4PENQca/ElZi59VlloMc5dbbhHkkgN/0CZQM5BIeastHNpAjnsDKrbcWCGH2b6m7GHDfhWC3dTz9ym4id3kH4bMhXjntwZ4mJtrLRrp7nXAvZ9+tsO58dKgFyNG1cFE6cL5Vh6zES/wAGE3pfzoMpE5Whrsw2YlmQuzGgRcrpE32ueBwF7q9UApXL9rm+OqxHlfY4huanAfBq0KuslgOoe+sfAS3pyuswvlHBl/87jZljWv1Ctf6S9hetzU2N1CxbjDFej02vhoBh7g8wStMWHpO5BGYv3tbEZQugXo9JIGiK2/6EOuBccRuMGguo/Zi7OLmOHCvBsN9r5V+0Qq+EzCIStSzcdWT5tQP2fVPmfMaHhJ1muvzq/XTUBrL162opDKTHecOgX+aYFlJANL52QXOEe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 19:43:10.9635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1a2ba1-03da-4344-0d71-08de6a6ef443
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
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

This solves a priority inversion issue, caused by the language
runtime making high-priority queues wait for activity on
lower-priority queues.

Signed-off-by: Andrew Martin <andrew.martin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 90ac3a30e81d..76483d91af98 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -70,7 +70,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 static void set_priority(struct cik_mqd *m, struct queue_properties *q)
 {
 	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
-	m->cp_hqd_queue_priority = q->priority;
+	/* m->cp_hqd_queue_priority = q->priority; */
 }
 
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 97055f808d4a..0186b3de67c0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -70,7 +70,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 static void set_priority(struct v10_compute_mqd *m, struct queue_properties *q)
 {
 	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
-	m->cp_hqd_queue_priority = q->priority;
+	/* m->cp_hqd_queue_priority = q->priority; */
 }
 
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 7e5a7ab6d0c0..c9e397366782 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -96,7 +96,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 static void set_priority(struct v11_compute_mqd *m, struct queue_properties *q)
 {
 	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
-	m->cp_hqd_queue_priority = q->priority;
+	/* m->cp_hqd_queue_priority = q->priority; */
 }
 
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index a51f217329db..3bbc2648f51d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -77,7 +77,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 static void set_priority(struct v12_compute_mqd *m, struct queue_properties *q)
 {
 	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
-	m->cp_hqd_queue_priority = q->priority;
+	/* m->cp_hqd_queue_priority = q->priority; */
 }
 
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index d0776ba2cc99..0d6b601962eb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -131,7 +131,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 static void set_priority(struct v12_1_compute_mqd *m, struct queue_properties *q)
 {
 	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
-	m->cp_hqd_queue_priority = q->priority;
+	/* m->cp_hqd_queue_priority = q->priority; */
 }
 
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index dcf4bbfa641b..bc4ceba35908 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -106,7 +106,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 static void set_priority(struct v9_mqd *m, struct queue_properties *q)
 {
 	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
-	m->cp_hqd_queue_priority = q->priority;
+	/* m->cp_hqd_queue_priority = q->priority; */
 }
 
 static bool mqd_on_vram(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 09483f0862d4..e63ef6442b35 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -73,7 +73,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 static void set_priority(struct vi_mqd *m, struct queue_properties *q)
 {
 	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
-	m->cp_hqd_queue_priority = q->priority;
+	/* m->cp_hqd_queue_priority = q->priority; */
 }
 
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
-- 
2.43.0

