Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D834CD35664
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 02:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 759E510E1E9;
	Wed, 28 Jan 2026 02:21:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iRLB6H2R";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010029.outbound.protection.outlook.com
 [40.93.198.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 706C410E1E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 02:21:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlSjyX+T5mxqc/E89AxWv1glkcoTCrO3zlVqxxQCfpXMVyEpwoUvNsBn5icRzz9OS/bq4/H29mpuiCMAdTHSXZsLewpeeIXUVJiETZVnbiXxIog6hVwgEvxKiMtOnS9cr0FYDjByKBmDZxDE89eVrpxxDeaf3rclEAX7R3VGp5BlTVKQJUcGISp7Payckc4k8hiewyUyGsWuE/0AujMYgBQ8ghHWsQeRJMUy3xIN3Vwhm+dx6jbRjrZp+KcbsMvkDzUvVwysxX2Xs3AYR3/xp/GDvJvQRmc+fVWVS2avTq1dHpQRCddcPzVid72JHDsUEDnUbWAxISfL74pbpWW/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zraCt1jeN+ZlSasI9JVxkbBi+/qicz6luoKyxVm2eaY=;
 b=mK31tdJPN8an5Dvr5V1smKIXtd2Ou3TPosH1Qz/ybp9SrtXSfvCIRhbTSAC0R8/xM8cQfZDNQvgZIe/OZQm05Z3JDJdGeCSmw+2jaBd645wLxWkiAe3XwHaRI3ILrUCaw4aRU9qY8OqYPQafMQ857Q9cPHIwMBxAT11k0kyb73Zv3HdkPMQ92GhOzQhh9GI65KDm+Y0OVPdC1jI08MxDjEzn/9DfvIEOjkl7GrzwKu2CFSJRMgKQIfexk0pBCnJnXoXvYUd9whuViAwhCFtxJGnzKgOR9sH6JODWucYrxzINW3kN+KZsWRyDwObTYcZl+6OuA0FUk4SSfe8LrgHsNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zraCt1jeN+ZlSasI9JVxkbBi+/qicz6luoKyxVm2eaY=;
 b=iRLB6H2R93GFHRbQO3mSqjuXYSiAUabJ7RIjq08jHJl/dHzCzDHxXoQ1M8oz2LozbSPcy1RNo1Z6uKEXpkANlFuyRpmRLh+9ZoHqNL/b7ELGNgqo+/XUu11TzRSnIWJ9L1bdKTJo1EtZT9aeVjBJLtb87ziy9BBTqx9c2pd0ZCE=
Received: from PH1PEPF00013316.namprd07.prod.outlook.com (2603:10b6:518:1::5)
 by CY8PR12MB7612.namprd12.prod.outlook.com (2603:10b6:930:9c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 02:21:27 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2a01:111:f403:f90e::4) by PH1PEPF00013316.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 02:21:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 02:21:27 +0000
Received: from lang-cezanne.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 20:21:25 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, "David
 Belanger" <david.belanger@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH 4/4] drm/amdkfd: Use AMDGPU_MQD_SIZE_ALIGN in gfx11+ kfd mqd
 manager
Date: Wed, 28 Jan 2026 10:21:11 +0800
Message-ID: <20260128022111.281082-4-lang.yu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128022111.281082-1-lang.yu@amd.com>
References: <20260128022111.281082-1-lang.yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|CY8PR12MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b8aabaa-93fe-4f7f-05e2-08de5e13f111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c5J1t7Ajzklqju/vBFLHu2hPggv4udHRFGpY//zF+6R4qKl3K7fdbSCYnEj6?=
 =?us-ascii?Q?jfq13eoz3GQX4wGg6LA+cwe9Xg7aR8yAkUy/P/CNZzTM6ZdG6Sy1Em54oXou?=
 =?us-ascii?Q?iW1FLwrZmB1ONjFS3OwVopKcvWQdW78b3Ss2FSTjk0oqQvqxifMWsWpKZUP+?=
 =?us-ascii?Q?ATXRtPbYUdmA3xXxpNAy9veLQXlJqK9k3zp/EfkzWCMIVVI5Sv8f04d50LFq?=
 =?us-ascii?Q?MMsFZUz/Fe9X007zbbaLIBcX7k5QnA2GOJeKaNQK62pqI99edzApOmBOCtYa?=
 =?us-ascii?Q?J06gVuS0iFIiKALAYLV4IwtxQZr1zDU/HBEs+9eh99eI57UGO/a1kEr+73Q3?=
 =?us-ascii?Q?3tsivR9NCKg/K5URWjKnmPqSX2fUG25ElyE/WcV1PI7QBi9zB+Ll//KMYkiI?=
 =?us-ascii?Q?IiGDGQf5wkezaFpC2Ed0YOOkqFym5rDe5Qii8R6mMPBYMP/HhdUtmpsK1D3p?=
 =?us-ascii?Q?kvbOwi4CkqeDS4bKvtPai8/qKHyT42d98dLBC52W9d3xgFqLXqvl6wsCDgnU?=
 =?us-ascii?Q?sWI1cDb+mjHLmCn3acsKqyX72vDUSTarx8ycAz00WtT+tlSRiuVg+dPbhULW?=
 =?us-ascii?Q?g01Y1XZaWMacjz8bGzIt8MDTuQfok6oBXBVL59P1WMUSl4ebqhZK7XySV95V?=
 =?us-ascii?Q?mNiHyQEVQn+qxlcXCFBP+X28ed1NxSbogbA8gPh/r8l2ok3MBCu4f0Min2J3?=
 =?us-ascii?Q?syxL/ip/K/4TVZ7cauXW7NCPVKo2szA/C8BWlNIidKv4VtcB+izB2unYVrgR?=
 =?us-ascii?Q?MS2mWq0FedlyEb7WbjFSp2fUkKRtX+gBJi8DLe72jczhIZkgrnIRn7b0EtBl?=
 =?us-ascii?Q?HhP97WLD5HZsJkNJdbCWEo0iV7TwEu7bIInDFpUd+2Q5JuFhdE0tUwqL4fhs?=
 =?us-ascii?Q?jkm3WCvUlqrlGaVCOQX3LHPixhjzejK8UdZm1fcAoEmG4tRNoJDUTrHcC2Gl?=
 =?us-ascii?Q?CqGhTqqVY4Z99tcTbIbzAXeUcyn0XAQgUTmIo/iFygStayFfF3SZLQ6wEf/w?=
 =?us-ascii?Q?mUMK/XNcR1x78lTyvASHn8hx4S8wiFVzgP1RgZA0ajlSWlMf10oygnaTV0wx?=
 =?us-ascii?Q?nT4F9vrfw08Q+Iv5YVRtfpkfv652lNeuoOPsIeJEE2IEBP02tNZa5/SL//bn?=
 =?us-ascii?Q?kNg3u71WmG1fdnwSyMev0s4eq4tlZd/xARGw6kIlJBt7u8JEzbkcNOi6ocMe?=
 =?us-ascii?Q?Sd7888+Qel1d8K2UrM8HTfQGI5KxnGEAuoeuERwNyOBAMr3TH1oQwcBQ4bIA?=
 =?us-ascii?Q?c4DnhCQQ10yAnO4rODZhY8a1ffBKRNKrZyLiaHVWaAJDowFlCiJw/D34eNmV?=
 =?us-ascii?Q?3xrPEjRG0eE61lEc+6FZGYsgrxDir4eW2D+X0EcUC0el19Krbm/tOfPVhjQ4?=
 =?us-ascii?Q?EFESrxWspdBIcVNEaTMhp7PvtV1P12vSGWwb9/Huu4Z+xV6ayoSENGYyOUzu?=
 =?us-ascii?Q?/sEFzDKsOfcqvBFxJg7Fj0BfU1IL4CK/SL9LrMyl5DLwgEXhuhir9YUWxdUq?=
 =?us-ascii?Q?WvaNhsIMFvbRcnmH7ousk6Wu/ZZOEbjEatu7VHSxh2Cjb14UR8/keWyQqedh?=
 =?us-ascii?Q?F3a5KLPDFn/s2HJBOhEiL35fIgOWh1CWT//e6tcLBtIIa1sJqcE5TRWTsS2m?=
 =?us-ascii?Q?+B/Cm2juOtJ2TfPUORfSKtiWXm+ykJEsLB9D43qw43vKJSawFHXGAX5d/4D7?=
 =?us-ascii?Q?vhLpew=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 02:21:27.4637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8aabaa-93fe-4f7f-05e2-08de5e13f111
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7612
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

MES is enabled by default from gfx11+, use AMDGPU_MQD_SIZE_ALIGN
unconditionally for gfx11+.

Signed-off-by: Lang Yu <lang.yu@amd.com>
Reviewed-by: David Belanger <david.belanger@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  3 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 22 +++-----------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  | 10 +++----
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    | 29 ++++---------------
 4 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index ceb6566ff3e1..d88d0de58edd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -292,6 +292,9 @@ void kfd_get_hiq_xcc_mqd(struct kfd_node *dev, struct kfd_mem_obj *mqd_mem_obj,
 uint64_t kfd_mqd_stride(struct mqd_manager *mm,
 			struct queue_properties *q)
 {
+	if (KFD_GC_VERSION(mm->dev) >= IP_VERSION(11, 0, 0))
+		return AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
+
 	return mm->mqd_size;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 5c44d0987737..7e5a7ab6d0c0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -102,20 +102,11 @@ static void set_priority(struct v11_compute_mqd *m, struct queue_properties *q)
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
 		struct queue_properties *q)
 {
+	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
 	struct kfd_node *node = mm->dev;
 	struct kfd_mem_obj *mqd_mem_obj;
-	int size;
-
-	/*
-	 * MES write to areas beyond MQD size. So allocate
-	 * 1 PAGE_SIZE memory for MQD is MES is enabled.
-	 */
-	if (node->kfd->shared_resources.enable_mes)
-		size = PAGE_SIZE;
-	else
-		size = sizeof(struct v11_compute_mqd);
 
-	if (kfd_gtt_sa_allocate(node, size, &mqd_mem_obj))
+	if (kfd_gtt_sa_allocate(node, mqd_size, &mqd_mem_obj))
 		return NULL;
 
 	return mqd_mem_obj;
@@ -127,18 +118,13 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 {
 	uint64_t addr;
 	struct v11_compute_mqd *m;
-	int size;
+	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
 	uint32_t wa_mask = q->is_dbg_wa ? 0xffff : 0xffffffff;
 
 	m = (struct v11_compute_mqd *) mqd_mem_obj->cpu_ptr;
 	addr = mqd_mem_obj->gpu_addr;
 
-	if (mm->dev->kfd->shared_resources.enable_mes)
-		size = PAGE_SIZE;
-	else
-		size = sizeof(struct v11_compute_mqd);
-
-	memset(m, 0, size);
+	memset(m, 0, mqd_size);
 
 	m->header = 0xC0310800;
 	m->compute_pipelinestat_enable = 1;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index b7ac2dea8775..a51f217329db 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -83,14 +83,11 @@ static void set_priority(struct v12_compute_mqd *m, struct queue_properties *q)
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
 		struct queue_properties *q)
 {
+	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
 	struct kfd_node *node = mm->dev;
 	struct kfd_mem_obj *mqd_mem_obj;
 
-	/*
-	 * Allocate one PAGE_SIZE memory for MQD as MES writes to areas beyond
-	 * struct MQD size.
-	 */
-	if (kfd_gtt_sa_allocate(node, PAGE_SIZE, &mqd_mem_obj))
+	if (kfd_gtt_sa_allocate(node, mqd_size, &mqd_mem_obj))
 		return NULL;
 
 	return mqd_mem_obj;
@@ -102,11 +99,12 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 {
 	uint64_t addr;
 	struct v12_compute_mqd *m;
+	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
 
 	m = (struct v12_compute_mqd *) mqd_mem_obj->cpu_ptr;
 	addr = mqd_mem_obj->gpu_addr;
 
-	memset(m, 0, PAGE_SIZE);
+	memset(m, 0, mqd_size);
 
 	m->header = 0xC0310800;
 	m->compute_pipelinestat_enable = 1;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 0b0d802a0917..d0776ba2cc99 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -32,17 +32,6 @@
 #include "amdgpu_amdkfd.h"
 #include "kfd_device_queue_manager.h"
 
-#define MQD_SIZE	(2 * PAGE_SIZE)
-
-static uint64_t mqd_stride_v12_1(struct mqd_manager *mm,
-				struct queue_properties *q)
-{
-	if (q->type == KFD_QUEUE_TYPE_COMPUTE)
-		return MQD_SIZE;
-	else
-		return PAGE_SIZE;
-}
-
 static inline struct v12_1_compute_mqd *get_mqd(void *mqd)
 {
 	return (struct v12_1_compute_mqd *)mqd;
@@ -148,21 +137,14 @@ static void set_priority(struct v12_1_compute_mqd *m, struct queue_properties *q
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
 		struct queue_properties *q)
 {
+	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
 	struct kfd_node *node = mm->dev;
 	struct kfd_mem_obj *mqd_mem_obj;
-	unsigned int size;
 
-	/*
-	 * Allocate two PAGE_SIZE memory for Compute MQD as MES writes to areas beyond
-	 * struct MQD size. Size of the Compute MQD is 1 PAGE_SIZE.
-	 * For SDMA MQD, we allocate 1 Page_size.
-	 */
 	if (q->type == KFD_QUEUE_TYPE_COMPUTE)
-		size = MQD_SIZE * NUM_XCC(node->xcc_mask);
-	else
-		size = PAGE_SIZE;
+		mqd_size *= NUM_XCC(node->xcc_mask);
 
-	if (kfd_gtt_sa_allocate(node, size, &mqd_mem_obj))
+	if (kfd_gtt_sa_allocate(node, mqd_size, &mqd_mem_obj))
 		return NULL;
 
 	return mqd_mem_obj;
@@ -174,11 +156,12 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 {
 	uint64_t addr;
 	struct v12_1_compute_mqd *m;
+	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
 
 	m = (struct v12_1_compute_mqd *) mqd_mem_obj->cpu_ptr;
 	addr = mqd_mem_obj->gpu_addr;
 
-	memset(m, 0, MQD_SIZE);
+	memset(m, 0, mqd_size);
 
 	m->header = 0xC0310800;
 	m->compute_pipelinestat_enable = 1;
@@ -681,7 +664,7 @@ struct mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD_TYPE type,
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct v12_1_compute_mqd);
 		mqd->get_wave_state = get_wave_state_v12_1;
-		mqd->mqd_stride = mqd_stride_v12_1;
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
-- 
2.34.1

