Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0DCCCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 18:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F1710EAEE;
	Thu,  9 Oct 2025 18:50:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m3hVmHSM";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013015.outbound.protection.outlook.com
 [40.107.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE5810EAEE
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 18:50:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TeMFHrwz++3MOOEg+hMKYUnDqE1FV81pyEkSXi13iMDlNFYcNE22l7xDp7xHN9hS5ef+cMoIk7GUcbmvCtlpEINL6JGC6IO3fisRzAoPixI4DLBDTaTOlKkjpuC/4CREBNDFHCScQCxM3o4Pc6wd8BjvB86ogLgl5Ln7EfgAJoacdluEGLRFeLvdHKHiBkUV2TGGvEV6COCpRBqaTulKUTX0rmRbp0vlzy+suOxV2Y0DkbEOj4qJC10x2e5AANMglIfkUzokWZEc5k6BjRUT3gLPsRATBZORRGoOZTnHQLubuhQAE/u8qIE8B1/AHHDR6qHbyEv5ozAUi9kCULH8Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2rVQ/MxLBfXT49wIHerfVIIiOceRtL0v7ek7ZQI5VQ=;
 b=i7Qh88n/qkdMexdel1Cpqzb5QYooT00uyOsbwlrahbe4NctNxNRgsumzAtDaxP7xKaVcpo7seNLHC8xGYB7ff9ET+NrpXTUcd30KyYFmk3ViRJaz3ungZsE6Uk09L7LoNWowx5FVfIYkxlO8eL3fRRA4kzNrwOmDQHgHRj7x+gL1bTYVcOmKZSoeUROwae7VExDPb9UQXAtVFx3oq/VZeoJkVgCmiJcpvpdulzzWUBYkIhwH++wtiU6meDMqe1jcMldWYPNiveHp7047f7jQ4c5e+eAp7dY73gESc6ri8REQE/opkGVvgOmmv+AOFAyeqXtvj+eGFW5ZP+coM9zGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2rVQ/MxLBfXT49wIHerfVIIiOceRtL0v7ek7ZQI5VQ=;
 b=m3hVmHSM2ZUZfAzaK6QxIlTV7dzHG41jvmM2vNkMFijzA6bLqUKJurkLwJGy7l5+TxF0JZA2qzzP4OowAwhLDXvgkKVGzDVKnGg0TS9Y9TzA4OTFRaLZ9+7BylxIOlx2six0UtyB1Ls5OblfudXT6RaMbANohwsQytr8zEQOBXc=
Received: from MN2PR01CA0017.prod.exchangelabs.com (2603:10b6:208:10c::30) by
 IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Thu, 9 Oct 2025 18:49:56 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::a5) by MN2PR01CA0017.outlook.office365.com
 (2603:10b6:208:10c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Thu,
 9 Oct 2025 18:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 18:49:56 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 11:49:53 -0700
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexdeucher@gmail.com>, <Alexander.Deucher@amd.com>,
 <Shaoyun.Liu@amd.com>, <Harish.Kasiviswanathan@amd.com>, <Amber.Lin@amd.com>, 
 Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: fix hung reset queue array return for hws
 user compute
Date: Thu, 9 Oct 2025 14:49:26 -0400
Message-ID: <20251009184929.1038298-4-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009184929.1038298-1-jonathan.kim@amd.com>
References: <20251009184929.1038298-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 3412e11e-30fb-4db7-d68a-08de0764a462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0ipZqG+OxvKnFftE2AWUGR+EEYpFHIWEu5j/WvyIwPbt3XQwJR8c2qmpob0t?=
 =?us-ascii?Q?hgInkF1aaaEr9mRkk4+BrMqXZrJBE7yPuG3VhDK2f5PPLEyu+0q8vGlZHqap?=
 =?us-ascii?Q?UAzqsVoCciw9BpFSpRPCVC7rplZyTf3cdQrqTt/+WWbMWmHpHTNd6LcoZasy?=
 =?us-ascii?Q?b+kMJXGNtvVUd0qrS0DSrCebVnNBuxLxW6XsUI1d52m7QQvYP+Y3Z2lsundT?=
 =?us-ascii?Q?c9zMWQVySNhcP2x7zRmwJd2OSyxhUehMLvyiHrTj3l33dPTklonkKWzJSuTi?=
 =?us-ascii?Q?vTYNPkNJJevN/48251dPdihFc51QwliUQhttyT1aK+QGWOLFgGFQa9MMn+eP?=
 =?us-ascii?Q?ytCIgPR4JqDMt2dqaWXLddsDi+wGUhDyZ5tE+qWp3L+Y9cnCTcJny8VJkUYN?=
 =?us-ascii?Q?p99cTKlzQoABNgJO1UZiau7FzbWcdepgxChRxsReffPPLSPhl6IuJupkkJoE?=
 =?us-ascii?Q?h/CVI8Bu+VZ5LQPGk3IIZfK1lCoxgO89k7gsv5rRbximLQhyjU9L6gJ+aLD0?=
 =?us-ascii?Q?Au8+TN9U+LB/UaSNdirR4l3BvSkeUOVr0iPrd4c/NnJWlqHswIjykQYWgEAB?=
 =?us-ascii?Q?Sz9+qrNhtMZLirkmk8321E9Y4rvY2HSLBGdclgZlqh2UcvV7xa8jUkTrRV16?=
 =?us-ascii?Q?MXHAdMY03jYvQ7J3Oy0151Rmacd2CecGGu3j5VF+ewDJbalLVwNvPaldNqJJ?=
 =?us-ascii?Q?jNHg6xppmJzVOzUV0qJlgtyswNOYBuHl1CQ5wFr1Gnu849m1I3GKCbnhumBA?=
 =?us-ascii?Q?ImVI0/kLT/+CONmFXXLq+3GPbg9164udfPLtjetz0ruuivkCreMoEiAJKRdv?=
 =?us-ascii?Q?p781HoYcQ66BhCPGdYhJSGsObRbsD+bubv+M8pkaPX5XS8aTqLJ4ZEKkSTjo?=
 =?us-ascii?Q?pm18p1lSPUVhrUyR/lS5hn31kskJMp1m/2lBy9Zphhba+b+EMIanJU2OVrMS?=
 =?us-ascii?Q?CwaEGthg3r64DjXmjaMWxLmHsWD7wnhMozs/vHEWzyBMYHqesthoMdPUpZfW?=
 =?us-ascii?Q?1s9ikbYg0wE1H7WlamOvQ49r52+gsZ7Ax3Cww4LAK+1qonAqGgRDQ8M03//2?=
 =?us-ascii?Q?rVxW70R8a47byJIR8oi/sFIUucd6Wnoc1XT62STF6C3OW6RpLNGw9ixeiVUh?=
 =?us-ascii?Q?7KfKDbYAq52EShFBv+nyqNwPsg70S4hNMDfIR7LzRHxoqWYpw+AqTdncmM6C?=
 =?us-ascii?Q?4Y5nsOkTJ/X4vtZmn0TZPCFl9X+4yCu112vjhKuIGbjq86YxvjcdJKsndPTj?=
 =?us-ascii?Q?nhAHPtiKyAvqjPhTT7RnCjaNWgwuOb7uoDYgd7ROPncG/LdrhfNRotes40QS?=
 =?us-ascii?Q?gJJsUfBFg/f6WqL3cHm10u3fCeQOodVIQ16D/k+mC1R0z/NW9QUc6qX/hvgP?=
 =?us-ascii?Q?GQiRX/LIm+KQkOASKKhCoJvAkJu/mU+pQliAqKP/U0gtXQm6KxRkIw8Eg+Z+?=
 =?us-ascii?Q?rEIzwRzFb8K78Iw7LvkNCB4oxMbspByDAIUl5xRlTDxHkEOS3lDdg1I5iHWD?=
 =?us-ascii?Q?KXuqyhz5rCrCOIhjNZbFWFrXE9/99oTqpWxbQ7IsxwU2a3jp88gosiajXtw+?=
 =?us-ascii?Q?uA98FsKC+HerkHzbY8U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 18:49:56.8813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3412e11e-30fb-4db7-d68a-08de0764a462
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604
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

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 20 ++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  6 +++---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     |  8 +++++---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c     |  8 +++++---
 5 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index c698e183beda..1af3ddb6f65c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -419,12 +419,24 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 	if (r) {
 		dev_err(adev->dev, "failed to detect and reset\n");
 	} else {
+		int array_hqd_info_offset = adev->mes.hung_queue_hqd_info_offset;
+		int array_size = adev->mes.hung_queue_db_array_size;
 		*hung_db_num = 0;
-		for (i = 0; i < adev->mes.hung_queue_db_array_size; i++) {
-			if (db_array[i] != AMDGPU_MES_INVALID_DB_OFFSET) {
+
+		for (i = 0; i < array_hqd_info_offset; i++) {
+			if (db_array[i] == AMDGPU_MES_INVALID_DB_OFFSET)
+				continue;
+
+			hung_db_array[i] = db_array[i];
+			*hung_db_num += 1;
+		}
+
+		for (i = array_hqd_info_offset; i < array_size; i++) {
+			if (!hung_db_num || queue_type != AMDGPU_RING_TYPE_COMPUTE)
+				break;
+
+			if (db_array[i] != AMDGPU_MES_INVALID_DB_OFFSET)
 				hung_db_array[i] = db_array[i];
-				*hung_db_num += 1;
-			}
 		}
 	}
 
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
index be8a352f9771..79dd2261ad04 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -47,7 +47,8 @@ static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev);
 
 #define MES_EOP_SIZE   2048
 
-#define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 4
+#define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 8 /* [0:3] = db offset [4:7] hqd info */
+#define MES12_HUNG_HQD_INFO_OFFSET	4
 
 static void mes_v12_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
@@ -1899,8 +1900,9 @@ static int mes_v12_0_early_init(struct amdgpu_ip_block *ip_block)
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

