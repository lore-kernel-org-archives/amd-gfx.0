Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C271C02190
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 15:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5328810E81A;
	Wed, 29 Jan 2025 15:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pJbHkuGB";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D157210E81A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 15:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R63YLmvhC7ZDMJI9EbSHJZRTUFPRNKCVBgmiiuvkM/UrcdLtfSxfr7pXpWovGphq2aOZS6koeHOJnhWUSabFt9RfNsF/9agTCrVFmJDF0USRSgAHrcmsaf4QB66CIrQQI1TOHQp/hv5gUQiBWJWkfLTxD400R7HEacxIRsLCUWtOGNb2foNS3obvykoSVVQUIUF1yFsmDjQztLpCM5oJaIiLuBK/gILWWOR9PbhTxjoHzsNyDlUWA1WVNKQ8VrrrJosoOUwRiVpa7mpMPRn3jmiy6rapNNyABbjoHZiM4QCTlO7qSXrjHonI7NS8GaYi8DG1TkUYBpx2F+qCKvEetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gKqq0iV7QxwwGj+ADWofA9NdrM7JyJHAkg+v4ds0yw=;
 b=toaIBLhW4rvsUY5ZEgFfGY5BS0nQQdTxHrNEPTXyB2gKV7lL8/YkukPdRIGO8ax9ZsDd174SC9R+H+mtPbeAXkiLM0ekwD98ZFoZWgPW4PlsuqCUybVMmrUyGLNSLFtviZodKPytkRS/ljs2LIRCmB9oh7l7myMMItxYlI53qrMoDybW8Fk6VscvfWneURhQmuJy8+aTgpDyy0FkWCh5/Yz23FGur9o0MjX7GOxpJy2B3RmZAdvq8A5O8hBcONd0yorqLC73OMUTIGHpxn2BqkKFpVW8lMYOZ2lMtVUBoQmn4sRZnfL5WH9ugZIAs91jrRqps9ym+vKW0HdH9DbSBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gKqq0iV7QxwwGj+ADWofA9NdrM7JyJHAkg+v4ds0yw=;
 b=pJbHkuGBHovEVMf5R2JFbnPpP92KE0m3ZOOxjp1GGqozpi+DN8zEzhiRJpUQfO/oJml+su6Vq2ovnxzB0LcgembqTWRnJBU3DdvSZcBBaOLAt/o9eNb1fZDDSmEz+uu3DUXLUHYLz8RIry82tbsj+vaXO0J/e2B/5yx2PC9n+qI=
Received: from MW4PR03CA0155.namprd03.prod.outlook.com (2603:10b6:303:8d::10)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 15:20:48 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::5f) by MW4PR03CA0155.outlook.office365.com
 (2603:10b6:303:8d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 15:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 15:20:47 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 Jan 2025 09:20:45 -0600
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: fix missing L2 cache info in topology
Date: Wed, 29 Jan 2025 10:20:29 -0500
Message-ID: <20250129152029.32275-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|SA1PR12MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: aec148f5-73f8-4381-8ccf-08dd4078820d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S03a7OOrsxxyA/wVH1vmX5APi+0EwKIplzslChWzu+DSVxrrSra1FBC/Np4J?=
 =?us-ascii?Q?vysdQQqd/d3bdjJtHN/zlnGCINN51/4LO5n4Q4peCFPhUFtGs2m7hhRgMTlc?=
 =?us-ascii?Q?cZnHJd6RwW9ZLywbTJAvUWEGYYUau843dvDXc8qahpgfn2YSlEDLtVpDCMxw?=
 =?us-ascii?Q?lXsAclJXtDnSHkeqkgVgovuVlWdYaXDvSSXpMa2Es9+fK7Z3FL/tBRa9SFkU?=
 =?us-ascii?Q?El+Jaj9Pxh4PzIf0573h3NPWXRT1d4/o2Yp2cJpkq27VQxprONy6zlZEmK8c?=
 =?us-ascii?Q?ietHuuzPEbEh1T076jZ0mY+H8FlslNr+IlBfNdcEFXzs1WcDm37wKTO5yINx?=
 =?us-ascii?Q?33nkMAbVhHVgvV3jrdNZcwTaSz7dl7LhirM+STzxdMq52zz0PoWMiDLavita?=
 =?us-ascii?Q?hLr6LwJxTJKgqqUEXN7wvbBvTmBqAAEE4PiZ4m3NI2lrQHSRtupmFQIaiaGO?=
 =?us-ascii?Q?MEjIX8ZtmYyuA1fQlyGGMHWvwQHDea93VXgwUQt9cb63RYl6qT4Zdag3+hqc?=
 =?us-ascii?Q?nfzB+NmOWN+Wp6gzhwcYdIv15q6dmw9EDnsiGHeWSxg4BMMYLBh3NLuxlBRU?=
 =?us-ascii?Q?jFfSgSvOC0QvLj/O9hQXz3lxdDEoV2tNjTyyI1CK7CW/Fe/uYrdLtaWUlTqE?=
 =?us-ascii?Q?RCyoFZP2VbuZCmZIU0snrgTxYm44aLmYm8ctRnc9VySvagvLxDP+MjFiEO0Q?=
 =?us-ascii?Q?eUxgXasQ3tQMIW2eDUEhTTAqFNwWGVcv2i8nq9jSnSa3pFyPEkA7q0TBfqbl?=
 =?us-ascii?Q?0WEXubxnTVxm67p+Tw3qnohfpMn13M1XJoBh8PAiPdfuXVR9KDvP8pw6SHE2?=
 =?us-ascii?Q?ITETH7L9tTeHYAJtSfeO6Dzn/ly+FxF5SmgK3IEIHCa3htfZ+q395Aoq5TaY?=
 =?us-ascii?Q?gB+jPDg6tDX/W3fPOKqhBOzbZsfT78I3vVKwVppqXvbWfZx9xNbHuMxvrRAS?=
 =?us-ascii?Q?9UG398ZMliJj5QTu/0Hco6QpSH+ZLtNrGS+DSQAVxpzXVncuKBqLGXdL6eXz?=
 =?us-ascii?Q?A/eNOnooIsLLTp9UTk86cXIwKWWWlAGRGKP6q3PtAY+ri1qVGiFmxgQtJZO0?=
 =?us-ascii?Q?D4BP8uy84BH6XhVuTOexxw7ABN6Hn9GIB/LG65u0TSOwQTYE2uykIYc1Krqz?=
 =?us-ascii?Q?Z0KXBGlUwHrv6l3Ax3jAPScHFmfICJ/7tyRWrIbsQTm6dYO3SjcH5ii4tnEH?=
 =?us-ascii?Q?xHkUoyZvVRh7hh0QqxJGTEzNVJNTOV5zilAtgF/x3UVuUOCPHpx6mkw20AI1?=
 =?us-ascii?Q?/O5jiTFTe1uQmhtISLCf3ey1O6bUjAoOKQjVr1Oas8rTS8w0OIChZuFkuIv3?=
 =?us-ascii?Q?Qg9zydZ/hDJJiwuVL3TL86wo0a9ZgwFMziPHK+aX5TjSJAHJO0cA8+FVLDiC?=
 =?us-ascii?Q?lk9o0uyPibTA0BZLtMJy2qZrr+uirf5HUnH6uZm68yHNHL9l3PzsxvdqTrBO?=
 =?us-ascii?Q?yPZQ1FIFiD5sSZaGJZ7habar7VVIf3uzqEHRvVtDHiDeU+0SNNZ6E4hOYK7I?=
 =?us-ascii?Q?60OVYVuK+njsy7A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 15:20:47.6939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aec148f5-73f8-4381-8ccf-08dd4078820d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799
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

In some ASICs L2 cache info may miss in kfd topology,
because the first bitmap may be empty, that means
the first cu may be inactive, so to find the first
active cu will solve the issue.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 4936697e6fc2..73d95041a388 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1665,17 +1665,31 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 				int cache_type, unsigned int cu_processor_id,
 				struct kfd_node *knode)
 {
-	unsigned int cu_sibling_map_mask;
+	unsigned int cu_sibling_map_mask = 0;
 	int first_active_cu;
 	int i, j, k, xcc, start, end;
 	int num_xcc = NUM_XCC(knode->xcc_mask);
 	struct kfd_cache_properties *pcache = NULL;
 	enum amdgpu_memory_partition mode;
 	struct amdgpu_device *adev = knode->adev;
+	bool found = false;
 
 	start = ffs(knode->xcc_mask) - 1;
 	end = start + num_xcc;
-	cu_sibling_map_mask = cu_info->bitmap[start][0][0];
+
+	/* To find the bitmap in the first active cu */
+	for (xcc = start; xcc < end && !found; xcc++) {
+		for (i = 0; i < gfx_info->max_shader_engines && !found; i++) {
+			for (j = 0; j < gfx_info->max_sh_per_se && !found; j++) {
+				if (cu_info->bitmap[xcc][i % 4][j % 4]) {
+					cu_sibling_map_mask =
+						cu_info->bitmap[xcc][i % 4][j % 4];
+					found = true;
+				}
+			}
+		}
+	}
+
 	cu_sibling_map_mask &=
 		((1 << pcache_info[cache_type].num_cu_shared) - 1);
 	first_active_cu = ffs(cu_sibling_map_mask);
-- 
2.34.1

