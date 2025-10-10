Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B410CCD185
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 16:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CD5310EC55;
	Fri, 10 Oct 2025 16:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gK0vwQy7";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013028.outbound.protection.outlook.com
 [40.107.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0C9E10EC55
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 16:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DteEYTEA/AsrOw1TQIZFXRAN45SKqfr3/+3/UjiQfV46Jc/7fFbi1QSNM8v5Vv1YHAZZFJKSPmOjmZYB6cshCd5q16XjZpFTMKSLQ1rJ5MOhvuZhTJEYF/ahcJpXb0eH90XHMnRXDT/WXYbF7E6QEhcbN8kgxCYxk6JX/1okt9Wqy+yYzjXrCfw3cnVuG5E7v8mJq7a3ZCURTMr6yBTdjz658i0MEoJ0HhHVdKfEH59r/bY2Bju2L99zLnx+D069gMp04tyz22JWS7anJHGAb8QarHDy5BsAt3Aa3vq5Nw90sl4wlc4UTSqDWTTkGIL3r64CbTVwWb9uQxZR10BwJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kg2KtnjVdVJZDFJitfbom8N1tDZk0sRAsU6rne8Lyfs=;
 b=poS1KTizXv1tXtvxnNAuhh5g0DQ9ClKXEJ0SFfjxiR1wsrFw7iJ78sCO3w6YzDCUSocIPSAyjap2IZ/cfp8lqhq7daHd1rAbEGhsN/S0j+19Xbwmas6QWUbXwPu66K2T9I/IMalGKlurjrmxcgUOne+VC7icjant0RYyaXqha2jP5dWB802AcNJVpw9D68kvrmHzGIETgBZGGc4TyyewHi86p0JpaFIsRJtgCq3tswAatza8ALGP5BBAKvHI4xrn9pT5ojcJkfS1frhdRxD944xjZMNPDGrzpnGGR/Hr6wdxwodRhwd3ZQKhL3m7bI0Kj4BW+1AgJpI9XK6T/D60gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg2KtnjVdVJZDFJitfbom8N1tDZk0sRAsU6rne8Lyfs=;
 b=gK0vwQy7APRa0yBO8qLf/6urafVXxpzVMYm1lV7zzfhwyq10EIDB+XND8Up2I5kXY3kaSQURr/JFiHVHI/B7faClcCnDfxg4E9r911SIjqxMAHubnGHDCp8cdaVC6Cuf2UW9utxOIQYbNl7dvPwJ5usTuA4PM5Pnw6s9s9KQPwE=
Received: from BN9PR03CA0505.namprd03.prod.outlook.com (2603:10b6:408:130::30)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 16:33:37 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:408:130:cafe::b8) by BN9PR03CA0505.outlook.office365.com
 (2603:10b6:408:130::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Fri,
 10 Oct 2025 16:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Fri, 10 Oct 2025 16:33:36 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 09:33:35 -0700
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <alexdeucher@gmail.com>, Jonathan Kim
 <jonathan.kim@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: fix hung reset queue array memory allocation
Date: Fri, 10 Oct 2025 12:33:13 -0400
Message-ID: <20251010163314.1105768-2-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010163314.1105768-1-jonathan.kim@amd.com>
References: <20251010163314.1105768-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 721ff61f-9b9e-4c7d-d850-08de081ac329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?80A09qSUJfJzN77115fnAhknOycpg8VXJVFZACASRUIUT6keogJN6b6geVkS?=
 =?us-ascii?Q?RdsTNJiRAL5FEU6GYOL7XL6ElHS8LEFsyt2OSCdG9IaPfOswNUk8/kJzSsaM?=
 =?us-ascii?Q?WABXBsSFg82I1+hie6GXLrTQ8KDhoKfz2opOX0h2s1Dqsl7WNC85HVm4fN38?=
 =?us-ascii?Q?XY6tAZcSmm0CL2UEwXzUxWlZ5iVIVTNB55DmuwHJVEJHvdQHFO8P14FlxEtU?=
 =?us-ascii?Q?J2DpBc/BcW2Hb2VyfQiXpDsRML0r79N+BC3gciW9CQacfMW/8aZ2W5HoaNQd?=
 =?us-ascii?Q?yugN2t8NlUda8YFRom4DUiEz354tKvNpuZyzIPFPZPdnPYsCw2jOgUxHUgZd?=
 =?us-ascii?Q?2R+4ORL4+JUmHdf14wCfXKdZg4a3xO5eq4/jJz6eB1oO/IwSod7VFQsUlw1a?=
 =?us-ascii?Q?Jb85obVHaE1O3K8OocfJDVESCre0GzZqsirmgdKw+8/yW0e38YYRSXQ2FdNI?=
 =?us-ascii?Q?ASaLWrIyu2Kx6kJXy0Mx4S4tv40WKt1Q8EK8lKu7bGA0eJ/Jl17JcFqwo+bJ?=
 =?us-ascii?Q?6x6prMpJO0Tco1JkC82M+1bziWE9Eh69PbCX0Cnx3WkbaGSXdSj1P3vtSlSB?=
 =?us-ascii?Q?uLRGg32Lb4bspb/RPH44Mjl/RoTfBlaK8F/uv101olfms9SdzQNb6EEhkSuM?=
 =?us-ascii?Q?NHMoA55d0yRN79GraHzEUPXuQOFL1vKF5nBqpqDiIEJRUWG0SONnDjz8Qla8?=
 =?us-ascii?Q?Hp+dsy8f1XTA3mMXC42weyjzfTxGkB86LgTE6GhT+osFY1/bcmjNhWhw2pBe?=
 =?us-ascii?Q?x7NpfXgtBzdVUubHOeBbdBYAYDLYMjP4TqeAilY02F/DBgwM9NWwlgMspnSB?=
 =?us-ascii?Q?kuogy+dNr1BMnfhyqSoAcXvcQjHNaxFmL3fbssACCETAiT9e74dOiawjckB9?=
 =?us-ascii?Q?AJAPOapxSKPx0eN7rTu72Eqm8Y8MkMBUYn6AALjXk1ay2Kju3gm3eBSa50KJ?=
 =?us-ascii?Q?dzVGw2yYVJHd6rwDZ07Gt0T4eD17qr0NQ/ubBlSbX99+Qi6m/2Zx9mcSax3O?=
 =?us-ascii?Q?oIT4bHSkW45uV3OIzYbhUebm9YZC0F3oEufy4XvxRXznBwgIOY7EkxDJXDh7?=
 =?us-ascii?Q?wTueY+fHz6iqlG9erkwbM7tYD7Et5yj2u0/cmJt/ioYHXlqOsA3AXixxkNVo?=
 =?us-ascii?Q?19coodWSiAV/GbubcaU/i00hpCH2+umJT7Lypmpu/km+9LJdNBYHbMgAO62u?=
 =?us-ascii?Q?JvDntuByrWzdaC7wVfhS0IE485g5225uR7yuG0+lkpzuVBDCbJRy6ldsc3cX?=
 =?us-ascii?Q?PFaYl56+fphJ2YKd9QwIhQIZ/MTXN6BvrZZYyZYa8R3YCNF/nHP6MFzwiPXy?=
 =?us-ascii?Q?xBPEF+kq9VTithdgqsDD27vAKk32lY0Yk4li+Z3Sib9ulaTzH6fBazrmttLO?=
 =?us-ascii?Q?ZK30GlPwMG7ZaBIJzC6DD19GhY2iK8W74QuqRG7MvF1wFOMwWU+JaghVLEWk?=
 =?us-ascii?Q?QLvMHH5+WNfSIVlxj/l8LCbUzc34updNoO5iOSLDs0ry1npghKu29RE/AZZi?=
 =?us-ascii?Q?rFQL6S/bGFVrMA/Z6P/Mxy62uwbzphR2PNslbXdctqzRCxCr97hZFA3BnjxN?=
 =?us-ascii?Q?wAKcxPjC1EBdNtH4SX4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 16:33:36.9204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 721ff61f-9b9e-4c7d-d850-08de081ac329
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570
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

By design the MES will return an array result that is twice the number
of hung doorbells it can report.

i.e. if up k reported doorbells are supported, then the
second half of the array, also of length k, holds the HQD information
(type/queue/pipe) where queue 1 corresponds to index 0 and k,
queue 2 corresponds to index 1 and k + 1 etc ...

The driver will use the HDQ info to target queue/pipe reset for
hardware scheduled user compute queues.

v2: only extend memory to accommodate HQD info for now as it will
be used later.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c     | 8 +++++---
 5 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 01ac942c1bb1..45bf8309cb37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -420,12 +420,17 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 		dev_err(adev->dev, "failed to detect and reset\n");
 	} else {
 		*hung_db_num = 0;
-		for (i = 0; i < adev->mes.hung_queue_db_array_size; i++) {
+		for (i = 0; i < adev->mes.hung_queue_hqd_info_offset; i++) {
 			if (db_array[i] != AMDGPU_MES_INVALID_DB_OFFSET) {
 				hung_db_array[i] = db_array[i];
 				*hung_db_num += 1;
 			}
 		}
+
+		/*
+		 * TODO: return HQD info for MES scheduled user compute queue reset cases
+		 * stored in hung_db_array hqd info offset to full array size
+		 */
 	}
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 6b506fc72f58..97c137c90f97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -149,6 +149,7 @@ struct amdgpu_mes {
 	void                *resource_1_addr[AMDGPU_MAX_MES_PIPES];
 
 	int				hung_queue_db_array_size;
+	int				hung_queue_hqd_info_offset;
 	struct amdgpu_bo		*hung_queue_db_array_gpu_obj;
 	uint64_t			hung_queue_db_array_gpu_addr;
 	void				*hung_queue_db_array_cpu_addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 829129ad7bd1..5c63480dda9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -208,10 +208,10 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 	struct amdgpu_userq_mgr *uqm, *tmp;
 	unsigned int hung_db_num = 0;
 	int queue_id, r, i;
-	u32 db_array[4];
+	u32 db_array[8];
 
-	if (db_array_size > 4) {
-		dev_err(adev->dev, "DB array size (%d vs 4) too small\n",
+	if (db_array_size > 8) {
+		dev_err(adev->dev, "DB array size (%d vs 8) too small\n",
 			db_array_size);
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e82188431f79..da575bb1377f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -66,7 +66,8 @@ static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev);
 #define GFX_MES_DRAM_SIZE	0x80000
 #define MES11_HW_RESOURCE_1_SIZE (128 * AMDGPU_GPU_PAGE_SIZE)
 
-#define MES11_HUNG_DB_OFFSET_ARRAY_SIZE 4
+#define MES11_HUNG_DB_OFFSET_ARRAY_SIZE 8 /* [0:3] = db offset, [4:7] = hqd info */
+#define MES11_HUNG_HQD_INFO_OFFSET	4
 
 static void mes_v11_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
@@ -1720,8 +1721,9 @@ static int mes_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
-	adev->mes.hung_queue_db_array_size =
-		MES11_HUNG_DB_OFFSET_ARRAY_SIZE;
+	adev->mes.hung_queue_db_array_size = MES11_HUNG_DB_OFFSET_ARRAY_SIZE;
+	adev->mes.hung_queue_hqd_info_offset = MES11_HUNG_HQD_INFO_OFFSET;
+
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
 			continue;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index e3149196143e..7f3512d9de07 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -47,7 +47,8 @@ static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev);
 
 #define MES_EOP_SIZE   2048
 
-#define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 4
+#define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 8 /* [0:3] = db offset [4:7] hqd info */
+#define MES12_HUNG_HQD_INFO_OFFSET	4
 
 static void mes_v12_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
@@ -1904,8 +1905,9 @@ static int mes_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
-	adev->mes.hung_queue_db_array_size =
-		MES12_HUNG_DB_OFFSET_ARRAY_SIZE;
+	adev->mes.hung_queue_db_array_size = MES12_HUNG_DB_OFFSET_ARRAY_SIZE;
+	adev->mes.hung_queue_hqd_info_offset = MES12_HUNG_HQD_INFO_OFFSET;
+
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		r = amdgpu_mes_init_microcode(adev, pipe);
 		if (r)
-- 
2.34.1

