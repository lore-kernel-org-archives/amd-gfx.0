Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0494EC1128
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 20:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4458610E30B;
	Mon, 23 Feb 2026 20:20:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NjTKbDdo";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0698610E30B
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 20:20:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adjclpv1SGDVtTNOXaDPNJDRmuVpKI8qYsueI3RNmYgabAJTs4Pn9MeBEV1Ay7ZRv5xiNKDSTulud+yX/NdbOLS2KWx1cYS8r0vdWKY0NUSh76bzS4pZZAQ/tTL3O3ymtrT2IaPdcTCJUsdAgOOW1KTZCR0wj5oStzOWye9GWn7vT0D3oEVGF7eZMCQiTtruJFIVY7kyYlVhfcmijCrnW7BBuWfEvcqzU/oqk5aOMM8BJKSTDYgxcvFSmYT71rv4M2YTYCkbdKFKibCylVOu+YtwRazAZGgIOdMoTfpGiiz5Zvk+RB2PTXwrvyZAA/doOOlx5Eq2j+1IvV4XkekQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FU3spVoA6edFEBIlK20GalNGVCunmxq2X8Zmsh8+kk=;
 b=e+Vwyu7hJ/RJ8hVEbPzpHIudLFHneMvPp0AxXrCCDaZBel+edI4bie453t8H4y/ZGzZge5NR2zgr8xfNgh3NgEXMpvgld6EtFfCMKiV4V+j4d7nl3LyGYISx+mWLbqWL9R+/eBrodsMdmFLSaHBE94H70rRs8rJzK4Q9LHX2g75FVxGUkLifvft6ZwGKrrUKvm5rZ1deNI2AXux/StSTeVizL7azQIE6Syb/8wVAq7vruB6PWnKKFZiNHiDsFAtRoBkc52nouw23ErGSYXpd1hjtbDQAMT8VSFOsIVPhKzf464K90J3qL6tAeTAwkRqOR0+hrZljSmzjgyueKHaSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FU3spVoA6edFEBIlK20GalNGVCunmxq2X8Zmsh8+kk=;
 b=NjTKbDdoPXWIexjGueK5O7mCbIGPTmJ0slJzUPAjMI3OVYXc3vxYwtBe2NIv0U36G4+oqk2tBGQIUxEpqQY3Cn0Nf+TIUat0oIeRcjTttUae7dZVp9L4yK3qiVAy1qGLQhQZFP8qiSwlA0Vgrg0RwCDgvgj30ts6yS2kqMOR0Fg=
Received: from BL1PR13CA0374.namprd13.prod.outlook.com (2603:10b6:208:2c0::19)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Mon, 23 Feb
 2026 20:19:59 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::77) by BL1PR13CA0374.outlook.office365.com
 (2603:10b6:208:2c0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 20:19:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 20:19:58 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Feb 2026 14:19:58 -0600
From: Andrew Martin <andrew.martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Andrew Martin <andrew.martin@amd.com>
Subject: [PATCH] drm/amdkfd: Removed commented line for MQD queue priority
Date: Mon, 23 Feb 2026 15:19:45 -0500
Message-ID: <20260223201945.58052-1-andrew.martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: a361dc86-8817-4890-1772-08de7318eae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8tYW6e55YbXrvgRnJLlstdNkddIMSIW/Nur580q9gAEh6Ie0M9OnOI3sVGPR?=
 =?us-ascii?Q?zWS5bEy7zSe2CnCZXWwbXYOKW/LW00mXEbzorPyaOaMbTc/c0QKvvfwxoqPq?=
 =?us-ascii?Q?8j8eoUqlhh/SKVaK9WIbLsRvehUMZyovqwYVHZZhVIgk/bJvAw0+UfrypVH8?=
 =?us-ascii?Q?N4xOb0qtkyexTtlCiJjbUBxIsBQgHfiK0q7K7U31ErKkayNx5rU4fWIDZMil?=
 =?us-ascii?Q?huQv65AM3KrAFPiOrFimlOz98jRzyht3GD/P15OtY76in60ApTJZT/E1Nh/a?=
 =?us-ascii?Q?pioqWCT4GN5zMsJ+A5X5Q5+kkZZX96ySyAJxzVtp8F0ccZIOZenhwzpgkn9B?=
 =?us-ascii?Q?siuzkFEHiZ8S6GSCcznOjHGUESk/eDUV/dYHjt9QzcFH9vNjX8It/euPjPmS?=
 =?us-ascii?Q?3X9bJaEGUJlFWl6uraLmGP1pRJjUXOxVBuo9oJ6smJgLaWB+eS6QLzz9K28Q?=
 =?us-ascii?Q?2WYDowBFz9ADSjuK0z462FE1BYoFFWTXy4PbN+Krs2kKO9PoLvNaW+BrJO8G?=
 =?us-ascii?Q?u1fQ0cLerlkvnGj8Z2AC9mTkNh+7nDUUwVW02c3f5EwrFMqI3P0DfmPPQVAc?=
 =?us-ascii?Q?VZJJBsVcYX+BXfJonZXD30HVFeihB6dETy4U1gxjGa986Bjqh/E1gB/6QW9O?=
 =?us-ascii?Q?jrqtBmrRqzJ945rJChg8jfKlQRNIcIlutFSNKveFaFGejeGoYC7/hVz/Xy6Y?=
 =?us-ascii?Q?27RZ1Gb1RBPuggmbfs0KOpvxaFVf81Xvq1cWyB3l07Djhr9Hwz0cFGgnJfcz?=
 =?us-ascii?Q?MYKZHJs0zN7oZLZoit0cv2m8h4IXVgWMRecUoLH6Zo4SPuHm3z9OwuOwwWbn?=
 =?us-ascii?Q?7NZzgc+aANfaWvyNgNnZh+7xQHA3PeTVQ7BByqir8slOWGWsdazgEoT69YeQ?=
 =?us-ascii?Q?yy3+mNre8EFitnZYjdjQDEJ4d6LgXarTQ8XKaGhBtav2SvvVULiFsgictFM0?=
 =?us-ascii?Q?FKVogc6KojFrdvFTk5UUBWROrQtE7rbSqXr5a8yG+Mf1nbpgWh1omMcsl28G?=
 =?us-ascii?Q?wEbkP80ACanfKKjLePDVBNge6HBvhuAIVvrPBXOLUDhB6tKJIs5D7Xtrd8NK?=
 =?us-ascii?Q?QuugXtKAkpECEoWBqn381KsuOxcy847Iqp5fWna1U1qFZWb/AfBqqCUR+Svf?=
 =?us-ascii?Q?49WN/xgG+1QjD5Pjw8dOonWrV3wSlcpfiqQBk8qA7kuOqtQpC3VHWO+76x3F?=
 =?us-ascii?Q?NvnlKU/09icvtLsj3icuMiLi44Bbmogf3Na0DcM4KhatVFLLSAuLMGjOJ+kM?=
 =?us-ascii?Q?uWM/2uixTeDRIIsu2o3InP+pieVF4atxsPt+Vu8y1yOCSkPaFy5da6f4HY7c?=
 =?us-ascii?Q?D8/zprajOzQS1CYKA0Qqze8Q42ckchKyNTZcaZk44l7SNsZWZwQdR0/ddVU+?=
 =?us-ascii?Q?uRXHNfMHmP1UfOJJ2TnYnoovwJMJXDKEd2cyiqWKHdSy4ZCdU+Z9jmkODvjZ?=
 =?us-ascii?Q?cGk6wqTHpEvduwj7FPmzcCJ1Vnwwq6YvHajfsBP2JbCgKY1J1krj4bNzMqjH?=
 =?us-ascii?Q?BoDXVraRLwAtYmNWQh4X2mHGr4u6dc1g+/RP590bZWJWAm65G3GJMbGZpo5O?=
 =?us-ascii?Q?pvK8tCgoGmBaMPkxec2JHXOfQrJ24z4WCoqZ8NISCKvL9RhGWB2u4k/7oVDO?=
 =?us-ascii?Q?C2bmdrXSxW8uVWpVXW5f1habAeZOKT2YSZZ3Rzumqm+9CzewVlNFBCi5Z6ps?=
 =?us-ascii?Q?SfqVHA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ExXgbQIVqpl7OKR2VNM4rlqqIubgA3SrhOFDK82xdISgLtDE3XnrawSrprqj1mtVbeOIGDR6e60njVJ4NG55YejnAsf6fAU3rhRoppmEPStbng034TDf89BICL9DYxE99RUENWcSV5AIpiyD8Q2XCucZIzLWEkyNFdRbXX+zVWdnf2urRybWUxyIoYtVEiisyTwV8zNu92odwAPQcy/McgdBBeoEWZyNH74k+aeZakyPwZxuVMgsO7WTS8VELIGIkul14Zw6nTWQk/4C+UhW/sXyxrYPa8ZRQdEkMhU/IeJzchXHwHDvJsTsDKzDT3Q9ujcISGx1G11wS0D9j1/PHOrOkkO8mTrcexN13tB4tPqWZs880Mw0lRyaKPmHZOrIAN3wqLnkZ1VyK0Z/eahfsDaUXuQ6jOYFzHwwvGgSk72tSTwG6Ynk3VFIMhzVg5b1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 20:19:58.9840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a361dc86-8817-4890-1772-08de7318eae2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009
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

Missed deleting the commented line in the original patch.

Fixes:3e95063383f5 ("drm/amdkfd: Disable MQD queue priority")
Signed-off-by: Andrew Martin <andrew.martin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   | 1 -
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   | 1 -
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   | 1 -
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   | 1 -
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 1 -
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    | 1 -
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    | 1 -
 7 files changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 90ac3a30e81d..14123c5d4925 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -70,7 +70,6 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 static void set_priority(struct cik_mqd *m, struct queue_properties *q)
 {
 	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
-	m->cp_hqd_queue_priority = q->priority;
 }
 
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 97055f808d4a..0f7688a1f8b1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -70,7 +70,6 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 static void set_priority(struct v10_compute_mqd *m, struct queue_properties *q)
 {
 	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
-	m->cp_hqd_queue_priority = q->priority;
 }
 
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 7e5a7ab6d0c0..d8f565cb2180 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -96,7 +96,6 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 static void set_priority(struct v11_compute_mqd *m, struct queue_properties *q)
 {
 	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
-	m->cp_hqd_queue_priority = q->priority;
 }
 
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index a51f217329db..db615b42b25c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -77,7 +77,6 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 static void set_priority(struct v12_compute_mqd *m, struct queue_properties *q)
 {
 	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
-	m->cp_hqd_queue_priority = q->priority;
 }
 
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index d0776ba2cc99..6e591103c3b6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -131,7 +131,6 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 static void set_priority(struct v12_1_compute_mqd *m, struct queue_properties *q)
 {
 	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
-	m->cp_hqd_queue_priority = q->priority;
 }
 
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index dcf4bbfa641b..ad0dcaed3d35 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -106,7 +106,6 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 static void set_priority(struct v9_mqd *m, struct queue_properties *q)
 {
 	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
-	m->cp_hqd_queue_priority = q->priority;
 }
 
 static bool mqd_on_vram(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 09483f0862d4..c192c66a5c7b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -73,7 +73,6 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 static void set_priority(struct vi_mqd *m, struct queue_properties *q)
 {
 	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
-	m->cp_hqd_queue_priority = q->priority;
 }
 
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
-- 
2.43.0

