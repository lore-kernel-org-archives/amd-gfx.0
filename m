Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04787EB2700
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 21:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D72710E606;
	Tue, 10 Feb 2026 21:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="taUGXPE8";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AACD10E0AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 21:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8jrc15+LH8LA1HGuRUCsJZ/pMLPbYnA7u6UgnTQf58htD3nO2/xJJTjdqeufnjZVI6fte0wG4Cga0GWpLgsob4sT84h+Py22h4whD9NokfGE0HJ5m5O4sq07w+4LYE/JKtiIeKZhLpK2WyHIqlJZzZJHSYq2QSmoVyVn17qVddSJmKrCOB2E1RRy5ovNf35djA1jpvM7I3kFU7vnP+CAWbjn7W53A/dCJu2APhvFU72hqZN3twfGUhVoaR7fMhyls0BGkpmLLA2f3reP/dbgWn7lgyGNEIssSnNNrTntggZSEczTW2EX7Wi+8VPNV5r1DCM38IVuvyUZz/Mq98qtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ESNRQwNrtfpNWyVfKBFRdFTqy01ilpXNdp7WA2OkuM=;
 b=vtHYtARe1kETWna9wPbGTARoLY3AGc0VDlL0SsZbgNaotzyLdbgIBzO+nwYJ3i5YRjDP8TY2wcTfWA0Cyxj+t78BzL36QEFIP67V6pT93v4V65Omtu+wGoEb7/jDHva2TqJV9BI3SprQ0l+WA+5s52rPNYdADUcwbhrj2RurEcB6vbq7ulKajjyRKvUs2vXia6bay9bogoN7OAPh1G3tuYkCuOtQ9Eyvdtv9otvPa2E03r3W4aq1P6ueUfhrU20VjQ/EoK1gDnMPgWv2P74vGfTnV7YdNM5bmk81LaqlR2kFyfrNGPnnBvK/NgkG3XU4TvvWCn0L0HFtkFOxByv6aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ESNRQwNrtfpNWyVfKBFRdFTqy01ilpXNdp7WA2OkuM=;
 b=taUGXPE8gq9BV9lW/rYK1Z7yS5kzOty64pBwYx2GXuIM+s9HlFft41R5z2Yt6jApdUmS5XkUNfOIKDxx6WES6X0TIGy6wDAZ18BYmxBBPay8746TtJzRCQ9jyAgDXiLI+nzLLhuV4luZRlnd3AXMqczS0CZxnW8iIhRW1cHmeAM=
Received: from BYAPR02CA0017.namprd02.prod.outlook.com (2603:10b6:a02:ee::30)
 by SJ5PPF0AEDE5C3D.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::989) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Tue, 10 Feb
 2026 21:48:15 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::d4) by BYAPR02CA0017.outlook.office365.com
 (2603:10b6:a02:ee::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 21:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 21:48:08 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Feb 2026 15:48:00 -0600
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: <leo.liu@amd.com>, <Boyuan.Zhang@amd.com>, <David.Wu3@amd.com>,
 "Saleemkhan Jamadar" <saleemkhan.jamadar@amd.com>
Subject: [PATCH 10/14] drm/amdgpu/umsch: user queue support for vcn
Date: Tue, 10 Feb 2026 16:47:25 -0500
Message-ID: <20260210214729.80964-11-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210214729.80964-1-David.Wu3@amd.com>
References: <20260210214729.80964-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|SJ5PPF0AEDE5C3D:EE_
X-MS-Office365-Filtering-Correlation-Id: 583bb784-1a38-40a3-b8f8-08de68ee1413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H8D0RzNpxOn0KN1I6uXuvHjOcpRVWpJ0bYDwkKJ0+3fiYvmgsuqfYTazNoGA?=
 =?us-ascii?Q?1P8ZLc/MScjhXz6CsrYRhXQTXzAWrFXgvILaortGoVwz+ORQpUzXozKOfA5Y?=
 =?us-ascii?Q?vDvAVZx68h3Gilw4lnBp8MUzmD+Ztr/Rv36rZ20oKIzpDhYEEeRNnvlzdTxi?=
 =?us-ascii?Q?JJYythennULo3hglwlQpbNF8l2Fxdptv+jtKLNP5n60/LCTDN7phUtFbPI1D?=
 =?us-ascii?Q?7z8OBPsedEfsJ837SUzWphG+rY7ee4I8TVTlE7oi1JRCip7LSfdRswiIHE8b?=
 =?us-ascii?Q?aJvSUdvDRzLLvw8aLSbQXf6TY2fkcCv5mvCfBRrt9fnziH2rjZgkwWCt8hi+?=
 =?us-ascii?Q?Ds3UM2wjSoio7lTaRiUwjuT7JcYySsyz4r8m/iHfPp/6fy6cPoE6+DnKgU3Q?=
 =?us-ascii?Q?2yvV/KTjMv1Rg+dx9x0Zz/hHO+YsWaqmKMkA5BNLTJCeexn7nQOlA2x4TH2u?=
 =?us-ascii?Q?cf3E0csZoWRcZTU4sn0MkWs7R8E8zgOMx0THZyQSGDzQsgPR2N2a/6FnTdm8?=
 =?us-ascii?Q?R8Hn3LYxY9wuBwqdVWER1bz6cE254ywnPehDP066p4OVz3FgGurs897iX5WC?=
 =?us-ascii?Q?VqULtiOxK7q1l01Al2B0JfzFo+l7An+qzap4DOJZ0kkqNlricnBIk8r7S+yW?=
 =?us-ascii?Q?RG10N6SwtpsWwchl7xjIDAe2CQa0ziNmsAaYyeVw5bqrAQw3xoyY94pAeXwy?=
 =?us-ascii?Q?GnSIYyESrZW3tf5mtTkIBr8SZChjLi7dpse4k1JUmdM3LzAnUm5bEQJVXPQF?=
 =?us-ascii?Q?uOpdtJjpXuHf99qfpko6rKOIRw77H8EPQj5bDGz0UEFfybq+9/ugcpB59ysp?=
 =?us-ascii?Q?1OzVsuJ6mJrTcJR/UTcZNAm97wLlTp0Fxvyp80QLHbToIz6rNSGsUoRj+mjr?=
 =?us-ascii?Q?L0pSanEgJkTTn07Ej5USF+kcmq7K5C0KdhDvwXYznMpSRefmjZfo5nOktlyv?=
 =?us-ascii?Q?7yQBBoVlkiBEkxBaPL792dksAAa2xlZVJWh1xJbRyyXLPZAZc8VJbo4KU0x2?=
 =?us-ascii?Q?7xozrteNrvIR1xc1sNHzOCfN1wpLCEvVNDzIWw6xTZx+4jc+pA5XUDpoOSzo?=
 =?us-ascii?Q?hyajVWG2Pnrw+bo7RXn3Io6w/Nqkjpvfi93i7XzK3lQZSMX4Y92fd0UyVMqW?=
 =?us-ascii?Q?bPbkNq0m9+Dadl6lXxKFCW3ahGv82v7zMKgYkWPCAbdoHc+xJzoIlCGKXBFN?=
 =?us-ascii?Q?msWcZiE+cU/0itvITbP6qMCN8vjY6E/yE3n5roLlicPjVzSjZeXfJ0bEXPQz?=
 =?us-ascii?Q?IyhqK3AIU7TpWxYwAAkKHIb+/gx8u/Cp0ZB4bJXgOBH0HGZejMROAelnQjzS?=
 =?us-ascii?Q?ZgIB7zJOpXbua8sg8kZF9W5HICxCa2vwasPo/epBIAOdigzlekFpnLpABPJF?=
 =?us-ascii?Q?aEix0DqK09/pN/CIaLfLiTqnL8SV9utwXUuPf2dyepfjVFIsvi38NtRfG6Mt?=
 =?us-ascii?Q?+7Je0+vBK4oiFn8xZ/4desxMEeWgBskUwTUYH6E5u17sxJKV+TJLFn+/ZxmY?=
 =?us-ascii?Q?dhuuPpgDZDyRUkNjdtob8pEO2kGZVqsDMXwz5Om2d9pgb8pIbBJx3l5/AE2B?=
 =?us-ascii?Q?Hpa+BvJR1kHrQgW6m/1PItnaOCHQR5MvbGDLGBiDZxm1U2F5FgWBTu/jGfYX?=
 =?us-ascii?Q?55Pix9E+GwSsLOyqT8Fn9S/H8ZwXFrpEgYjEzd9ggx1jG5W7ErzVpDAQGsyj?=
 =?us-ascii?Q?xRgDVw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cSRGBrHQWPGufHMTKI23NQv0prs9FJMF5InDskSRUrIqFB+CrbYdgpNT5YEEEu/yp5ZavfDsIP5rG2f9+DRpTrl0UzFsVdqojHG6vqNbWSdgbvDwXRKmkHqCjKwLkBYJJGnHktsgHFINLJ91Mfs/Y4OsW5PEZlnsSieNPys1xMObfDgS/UkICMWBjGmxqCuTi3s8Dnh6ec54eUldetkSmOuVPDQehAlTTcTfZOQNVgVrrVTb2AsAK0nQqUGF1EGcbHOeBej0QNZuupoLi9PM42tM5coQiCBp+b6rnsIKFsDtuzzLyJj4TtWmHoVMCMi+MdfNarSjZFnCZKun68KCpXIacTTQumAvbeY0zFBZmWpEq39YNZUpJ0JQ5n6i7XhM+UOADYrlRtbAtt+YwkzzpF9x6V+bAp2qz0M8dh2mahmO3Dy8uiTFEBVZw/w0ecVd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:48:08.0194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 583bb784-1a38-40a3-b8f8-08de68ee1413
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0AEDE5C3D
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

v5 - add convert_to_umsch_priority() to allow user priority setting
v4 - add vcn.agdb_offset which will be used in AMDGPU_INFO_DOORBELL
v3 - 1 use common function amdgpu_userq_create_wptr_mapping()
     2 use dev_err() instead of DRM_ERROR()
     3 don't need mqd setting from user space
     4 powergating on the last queue removal
v2 - use amdgpu_bo_gpu_offset() and reserve BO (Christian)

Implement User mode queues infrastructure api support for UMSCH.
And enable VCN user queues for vcn v4_0_5.
Drop v4_0_6 as it is not tested.

Use new amdgpu_userq_funcs structure for above functions and
convert rb_size as dword (David)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 237 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c   |   5 +
 6 files changed, 242 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index 760285ad028f..5a9589b56534 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -31,6 +31,7 @@
 #include "amdgpu.h"
 #include "amdgpu_umsch_mm.h"
 #include "umsch_mm_v4_0.h"
+#include "amdgpu_userq_fence.h"
 
 MODULE_FIRMWARE("amdgpu/umsch_mm_4_0_0.bin");
 
@@ -125,7 +126,6 @@ int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_mm *umsch)
 
 	switch (amdgpu_ip_version(adev, VCN_HWIP, 0)) {
 	case IP_VERSION(4, 0, 5):
-	case IP_VERSION(4, 0, 6):
 		fw_name = "4_0_0";
 		break;
 	default:
@@ -253,15 +253,21 @@ int amdgpu_umsch_mm_psp_execute_cmd_buf(struct amdgpu_umsch_mm *umsch)
 
 static void umsch_mm_agdb_index_init(struct amdgpu_device *adev)
 {
+	struct amdgpu_bo *obj = adev->agdb_bo;
 	uint32_t umsch_mm_agdb_start;
-	int i;
+	int i, r;
 
-	umsch_mm_agdb_start = adev->doorbell_index.max_assignment + 1;
-	umsch_mm_agdb_start = roundup(umsch_mm_agdb_start, 1024);
-	umsch_mm_agdb_start += (AMDGPU_NAVI10_DOORBELL64_VCN0_1 << 1);
+	r = amdgpu_bo_reserve(obj, true);
+	if (r)
+		return;
+	adev->vcn.agdb_offset = AMDGPU_NAVI10_DOORBELL64_VCN0_1 << 1;
+	umsch_mm_agdb_start = amdgpu_doorbell_index_on_bar(adev, obj,
+				   adev->vcn.agdb_offset, sizeof(u32));
+	amdgpu_bo_unreserve(obj);
 
 	for (i = 0; i < CONTEXT_PRIORITY_NUM_LEVELS; i++)
-		adev->umsch_mm.agdb_index[i] = umsch_mm_agdb_start + i;
+		adev->umsch_mm.agdb_index[i] = umsch_mm_agdb_start +
+					       (i * DIV_ROUND_UP(sizeof(u32), 4));
 }
 
 static int umsch_mm_init(struct amdgpu_device *adev)
@@ -328,8 +334,8 @@ static int umsch_mm_early_init(struct amdgpu_ip_block *ip_block)
 
 	switch (amdgpu_ip_version(adev, VCN_HWIP, 0)) {
 	case IP_VERSION(4, 0, 5):
-	case IP_VERSION(4, 0, 6):
 		umsch_mm_v4_0_set_funcs(&adev->umsch_mm);
+		adev->userq_funcs[AMDGPU_HW_IP_VCN_ENC] = &userq_umsch_4_0_funcs;
 		break;
 	default:
 		return -EINVAL;
@@ -440,6 +446,216 @@ static int umsch_mm_resume(struct amdgpu_ip_block *ip_block)
 	return umsch_mm_hw_init(ip_block);
 }
 
+static int convert_to_umsch_priority(int priority)
+{
+	switch (priority) {
+	case AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_NORMAL_LOW:
+	case AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_LOW:
+	default:
+		return CONTEXT_PRIORITY_LEVEL_NORMAL;
+	case AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_NORMAL_HIGH:
+		return CONTEXT_PRIORITY_LEVEL_FOCUS;
+	case AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH:
+		return CONTEXT_PRIORITY_LEVEL_REALTIME;
+	}
+}
+
+static int amdgpu_umsch_userq_map(struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_umsch_mm *umsch = &adev->umsch_mm;
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	struct umsch_mm_add_queue_input in_queue;
+	int r;
+
+	memset(&in_queue, 0, sizeof(struct umsch_mm_add_queue_input));
+	in_queue.process_id = queue->vm->pasid;
+	in_queue.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
+	in_queue.process_va_start = 0;
+	in_queue.process_va_end = (adev->vm_manager.max_pfn - 1);
+	in_queue.process_quantum = 100000; /* 10ms */;
+	in_queue.process_csa_addr = ctx->gpu_addr;
+
+	in_queue.context_quantum = 10000; /* 1ms */;
+	in_queue.context_csa_addr = ctx->gpu_addr + AMDGPU_GPU_PAGE_SIZE;
+	in_queue.inprocess_context_priority = CONTEXT_PRIORITY_LEVEL_NORMAL;
+	in_queue.context_global_priority_level = convert_to_umsch_priority(queue->priority);
+	if (queue->queue_type == AMDGPU_HW_IP_VCN_ENC) {
+		if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(4, 0, 5)) {
+			in_queue.doorbell_offset_0 = queue->doorbell_index;
+			in_queue.doorbell_offset_1 = 0;
+			in_queue.affinity = 1;
+			if (adev->vcn.num_vcn_inst == 2) {
+				in_queue.doorbell_offset_1 = (queue->doorbell_index + 2 + 8 * 1);
+				in_queue.affinity = 0x5;
+			}
+		}
+
+		in_queue.engine_type = UMSCH_SWIP_ENGINE_TYPE_VCN;
+	}
+
+	in_queue.mqd_addr = queue->mqd.gpu_addr;
+	in_queue.mqd_type = 2; /* MQD Type Linux */
+	in_queue.fence_signal_addr = queue->fence_drv->gpu_addr;
+	in_queue.vm_context_cntl = hub->vm_cntx_cntl;
+	amdgpu_umsch_mm_lock(&adev->umsch_mm);
+	r = umsch->funcs->add_queue(umsch, &in_queue);
+	amdgpu_umsch_mm_unlock(&adev->umsch_mm);
+	if (r)
+		dev_err(adev->dev, "Failed to create queue. for IP %d r %d\n", queue->queue_type, r);
+
+	return r;
+}
+
+static int amdgpu_umsch_userq_unmap(struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	struct amdgpu_umsch_mm *umsch = &adev->umsch_mm;
+	struct umsch_mm_remove_queue_input q_input;
+	int r;
+
+	memset(&q_input, 0, sizeof(struct umsch_mm_remove_queue_input));
+	q_input.doorbell_offset_0 = queue->doorbell_index;
+	q_input.doorbell_offset_1 = 0;
+	if (adev->vcn.num_vcn_inst == 2)
+		q_input.doorbell_offset_1 = (queue->doorbell_index + 2 + 8 * 1);
+
+	q_input.context_csa_addr = ctx->gpu_addr + AMDGPU_GPU_PAGE_SIZE;
+
+	amdgpu_umsch_mm_lock(&adev->umsch_mm);
+	r = umsch->funcs->remove_queue(umsch, &q_input);
+	amdgpu_umsch_mm_unlock(&adev->umsch_mm);
+	if (r)
+		dev_err(adev->dev, "Failed to unmap queue in HW, err (%d)\n", r);
+
+	return r;
+}
+
+static int amdgpu_umsch_mqd_create(struct amdgpu_usermode_queue *queue,
+				   struct drm_amdgpu_userq_in *args)
+{
+	struct amdgpu_userq_obj *sfence = &queue->suspend_fence_obj;
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_umsch_mm *umsch = &adev->umsch_mm;
+	struct amdgpu_mqd_prop *userq_props;
+	struct MQD_INFO *mqd;
+	int r, size, i;
+
+	/* Structure to initialize MQD for userqueue using generic MQD init function */
+	userq_props = kzalloc(sizeof(struct amdgpu_mqd_prop), GFP_KERNEL);
+	if (!userq_props) {
+		dev_err(adev->dev, "Failed to allocate memory for userq_props\n");
+		return -ENOMEM;
+	}
+
+	/* FW expects WPTR BOs to be mapped into GART */
+	r = amdgpu_userq_create_wptr_mapping(uq_mgr, queue, args->wptr_va);
+	if (r) {
+		dev_err(adev->dev, "Failed to create WPTR mapping\n");
+		goto exit;
+	}
+
+	r = amdgpu_userq_create_object(uq_mgr, &queue->mqd, sizeof(struct MQD_INFO));
+	if (r) {
+		dev_err(adev->dev, "Failed to create MQD object for userqueue\n");
+		goto exit;
+	}
+
+	userq_props->wptr_gpu_addr = args->wptr_va;
+	userq_props->mqd_gpu_addr = queue->mqd.gpu_addr;
+	userq_props->use_doorbell = true;
+	userq_props->doorbell_index = queue->doorbell_index; /* VCN0 doorbell*/
+	queue->userq_prop = userq_props;
+
+	/* Initialize the MQD BO with user given values */
+	mqd = (struct MQD_INFO *)queue->mqd.cpu_ptr;
+	memset(mqd, 0, sizeof(struct MQD_INFO));
+	mqd->rb_base_lo = lower_32_bits(args->queue_va);
+	mqd->rb_base_hi = upper_32_bits(args->queue_va);
+	mqd->wptr_addr_monotonic_hi = upper_32_bits(queue->wptr_obj.gpu_addr);
+	mqd->wptr_addr_monotonic_lo = lower_32_bits(queue->wptr_obj.gpu_addr);
+	mqd->rptr_addr_monotonic_hi = upper_32_bits(args->rptr_va);
+	mqd->rptr_addr_monotonic_lo = lower_32_bits(args->rptr_va);
+	mqd->rb_size = args->queue_size / 4;
+	mqd->unmapped = 1;
+
+	size = 2 * PAGE_SIZE;
+	r = amdgpu_userq_create_object(uq_mgr, ctx, size);
+	if (r) {
+		dev_err(adev->dev, "Failed to allocate ctx space bo for userqueue, err:%d\n", r);
+		goto free_mqd;
+	}
+
+	mutex_lock(&umsch->mutex_hidden);
+	atomic_inc(&umsch->userq_count);
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_VCN) {
+			const struct amdgpu_ip_block_version *ip_block =
+						adev->ip_blocks[i].version;
+
+			r = ip_block->funcs->set_powergating_state(&adev->ip_blocks[i],
+						AMD_PG_STATE_UNGATE);
+			if (r) {
+				dev_err(adev->dev, "Failed to power ON VCN :err %d\n", r);
+				goto free_ctx;
+			}
+		}
+	}
+	mutex_unlock(&umsch->mutex_hidden);
+
+	r = amdgpu_userq_create_object(uq_mgr, sfence, AMDGPU_GPU_PAGE_SIZE);
+	if (r) {
+		DRM_ERROR("Failed to allocate suspend fence bo for userq, err:%d\n", r);
+		goto free_ctx;
+	}
+
+	return 0;
+
+free_ctx:
+	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
+
+free_mqd:
+	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
+
+exit:
+	kfree(userq_props);
+	return r;
+}
+
+static void amdgpu_umsch_destroy_queue(struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_umsch_mm *umsch = &adev->umsch_mm;
+	int r, i;
+
+	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
+	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
+	kfree(queue->userq_prop);
+
+	mutex_lock(&umsch->mutex_hidden);
+	if (!atomic_dec_return(&umsch->userq_count)) {
+		for (i = 0; i < adev->num_ip_blocks; i++) {
+			if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_VCN) {
+				const struct amdgpu_ip_block_version *ip_block =
+					adev->ip_blocks[i].version;
+
+				r = ip_block->funcs->set_powergating_state(&adev->ip_blocks[i],
+									   AMD_PG_STATE_GATE);
+				if (r)
+					dev_err(adev->dev, "Failed to power OFF VCN :err %d\n", r);
+			}
+		}
+	}
+	mutex_unlock(&umsch->mutex_hidden);
+}
+
 void amdgpu_umsch_fwlog_init(struct amdgpu_umsch_mm *umsch_mm)
 {
 #if defined(CONFIG_DEBUG_FS)
@@ -559,3 +775,10 @@ const struct amdgpu_ip_block_version umsch_mm_v4_0_ip_block = {
 	.rev = 0,
 	.funcs = &umsch_mm_v4_0_ip_funcs,
 };
+
+const struct amdgpu_userq_funcs userq_umsch_4_0_funcs = {
+	.mqd_create = amdgpu_umsch_mqd_create,
+	.mqd_destroy = amdgpu_umsch_destroy_queue,
+	.map = amdgpu_umsch_userq_map,
+	.unmap = amdgpu_umsch_userq_unmap,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
index af34faa5e1ef..6b827c92e817 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
@@ -25,6 +25,8 @@
 #ifndef __AMDGPU_UMSCH_MM_H__
 #define __AMDGPU_UMSCH_MM_H__
 
+extern const struct amdgpu_userq_funcs userq_umsch_4_0_funcs;
+
 enum UMSCH_SWIP_ENGINE_TYPE {
 	UMSCH_SWIP_ENGINE_TYPE_VCN = 0,
 	UMSCH_SWIP_ENGINE_TYPE_VPE = 1,
@@ -181,6 +183,7 @@ struct amdgpu_umsch_mm {
 	uint64_t			log_gpu_addr;
 	uint32_t			mem_size;
 	uint32_t			log_offset;
+	atomic_t                        userq_count;
 };
 
 int amdgpu_umsch_mm_submit_pkt(struct amdgpu_umsch_mm *umsch, void *pkt, int ndws);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 59e593b3bae7..50c75acc8e94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -916,7 +916,8 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 		/* Usermode queues are only supported for GFX IP as of now */
 		if (args->in.ip_type != AMDGPU_HW_IP_GFX &&
 		    args->in.ip_type != AMDGPU_HW_IP_DMA &&
-		    args->in.ip_type != AMDGPU_HW_IP_COMPUTE) {
+		    args->in.ip_type != AMDGPU_HW_IP_COMPUTE &&
+		    args->in.ip_type != AMDGPU_HW_IP_VCN_ENC) {
 			drm_file_err(filp, "Usermode queue doesn't support IP type %u\n",
 				     args->in.ip_type);
 			return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 758464203d98..7a5b5c204601 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -66,6 +66,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_userq_obj	db_obj;
 	struct amdgpu_userq_obj fw_obj;
 	struct amdgpu_userq_obj wptr_obj;
+	struct amdgpu_userq_obj suspend_fence_obj;
 	struct xarray		fence_drv_xa;
 	struct amdgpu_userq_fence_driver *fence_drv;
 	struct dma_fence	*last_fence;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index bea95307fd42..ec8540fcc916 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -371,6 +371,7 @@ struct amdgpu_vcn {
 
 	bool			disable_uq;
 	bool			disable_kq;
+	uint32_t		agdb_offset;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
index 79e1ec9933c5..60d1fdfb2af5 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -289,6 +289,11 @@ static int umsch_mm_v4_0_set_hw_resources(struct amdgpu_umsch_mm *umsch)
 	set_hw_resources.g_sch_ctx_gpu_mc_ptr = umsch->sch_ctx_gpu_addr;
 
 	set_hw_resources.enable_level_process_quantum_check = 1;
+	if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(4, 0, 5)) {
+		set_hw_resources.is_vcn0_enabled = 1;
+		if (adev->vcn.num_vcn_inst == 2)
+			set_hw_resources.is_vcn1_enabled = 1;
+	}
 
 	memcpy(set_hw_resources.mmhub_base, adev->reg_offset[MMHUB_HWIP][0],
 	       sizeof(uint32_t) * 5);
-- 
2.43.0

