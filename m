Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E61C606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=y+/o7pNN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD2F010E2EF;
	Mon, 26 Oct 2026 21:38:53 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C47510E2EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 21:38:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4626rQ7HyoKoZLT0AZ8qRhxp65f27pkzmLga/y3l+htpZZhmJTpYUNCzTvZ4Dzh49alWpHuauVtobv8FSGhTeZNs4No/g6G4euW8gzFroMdJQlMqf+4YPsLVW6FegJpF/XEIwbcEEEcSWBk5MkAlgF5KEs1OKfjovfBlFl1BzdhZTG13sQMZ8Gn1MbenVFXlkMWm2zLC12Wlv+lG6LDuTpoYR05DkhhIWwtomY9LpGV+ZyVNIe+Z/Hs0hA36W9xMgvfDaf4Cjbv5dl0EAnC5pDe4x0cQhVZUKFpcK+Ojkq/tE3zy0zlVLl+KlfO/ht08BHE8askzwVfiH6bHtjdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZhB+Iz49TSkYJmuAW1E0N+eO8haFhYTc1SClNcCHGw=;
 b=Ppw9wgGXZytmdfSxAkL90u16rsiNvckDc1sBQ03pPfmnuMyLBta71wKzlgx1ayHtDGnvMXR1/Qq9pPt2U2e8SZR3YPJTOYxobBhQSkOJqGmQB7Av04scAqS4RCHNSljK+bHohYOOYaHSqzUYhZqZaPKQDeGOAJSXynYBU6lddt2AwSG/Cb4xevP4L5EaiQXPkuVAzMTWWESnSgHjqxGmfDeT+Oe85OBBuJStzyMcsHg6cdHdb9l6wpW+pxKHp62rRCZaP8v6hrpS7D5WL20yX/RWGv4UtZy5UYnHUErdMmm5BrgGU/IB5QJGW4P7st6mXuOViI6LVpBZpreuPhDvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZhB+Iz49TSkYJmuAW1E0N+eO8haFhYTc1SClNcCHGw=;
 b=y+/o7pNNesr/ihj06Gu1yH2YooTu6i5R0FepK2kN5sF9Tl9lyzjZ4R0ldy1sg6NKUGmh7mrufL1oE5MxKmHd6l/r7pAkfEMZM+t1UeU7bdCfzMUOIRxQZchncOjKwOGlUIAHw2lXfJ2lM1uMMmSGleB+SzJMpTJmPiBnAuTWg6E=
Received: from CY5PR22CA0039.namprd22.prod.outlook.com (2603:10b6:930:1d::13)
 by DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Mon, 26 Oct 2026 21:38:43 +0000
Received: from CY7PEPF000000F1.namprd05.prod.outlook.com
 (2603:10b6:930:1d:cafe::52) by CY5PR22CA0039.outlook.office365.com
 (2603:10b6:930:1d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 21:38:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F1.mail.protection.outlook.com (10.167.247.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 21:38:43 +0000
Received: from alex-sierra-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 16:38:42 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Mukul.Joshi@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Lijo.Lazar@amd.com>, Alysa Liu <Alysa.Liu@amd.com>
Subject: [PATCH] drm/amdkfd: Add UALOE and UALINK IO link types
Date: Mon, 26 Oct 2026 16:38:20 -0500
Message-ID: <20261026213820.2979770-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F1:EE_|DS7PR12MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: b95bac73-35bd-4c21-939e-08df33a981e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|261026140227099003|11063799006|56012099006|261009223027099003|261021123027099003|261021121427099003|261022105027099003|10067099003|261026121527099003|18002099003;
X-Microsoft-Antispam-Message-Info: x2Oc4vsDE7mqiZTLy0sMXgDBm4DzJbeiWeSKHcSAs0PPU0aPW9NZDZN6j+jCe1ilVRpr3+6L1uQJt4wbhC5gs7uwl/vTK6YAxuvMnM5YW+IHRwACU6bXcP7Eq6H8aF8NUL2AcQAlCGpPYeRWFkazqPEyD13058zSj0vEzIiIQn7nVNYMc6hhxZE3h3WVIgJMm+ZFz6ZbZakvebM8FzLQgAzAlYrSk0nctfCCLdg5zpTyGRAwscxBq/1HBUaZj/43ADbs+QEUFDaIWCPscbmaJjJSWP4dKOd5dbpwGMXjkd8ppthmD4lnAnJVir0w9T2E6J6d2/79WmK41QP1LeE6/mRPd2xIEy2vKPKnxdo/Y9jvlmXQ+WV8nRG2Csnjf62s/hHq/U1lzuL1DhPXN6k9pkcjifhXgn83PDuYVvH798pyS67X/RGXXj1sL1HD72/hJtPv7eea42kmNZaaRdWONVcZWDgCu8WOyu4uAMOamNREqbZ0ByR05kwd9R4jjYgW3sSYbZIYBZZz2G4tbDwbM5Z+fnPNyCVFETfKupnwnJU2t7s4XTSfsLWSOjZ0c2D0rec99y4zS92HNvvlmAXxq4HNChgcYJEnHirJKqVpMVEUUrsn7POiW/DgS/b6RogG2HI0Dk+QGhAsT6OvRUdUExKyEUmpA8ltg9TgZWe4a08rALivBYhmp4POABclD59EmdMisKqwduPCMZ6XHiVDVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(261026140227099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003)(261026121527099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Tz5E4ragUgNqYL04L3MBrQn7Eq6qLNAZB9iprCFoXWM5u+4jeLiojFmoADjg58aKLpJIoVYFBsAvkYtABovdQ2Plkz+2c1BkJXwVprEEmKmS/fzFB0SXH+8i4mJTKhjGCQ2E37bZ0MiaficxKAaQiNLMmP6YaaGhvJ/+UouavyDHMoP74CmDgoQxcTxW1qz1MNzz5Gxp3DTkH/RksXZjR51mNv48v5c9cMkfuc+5iit1sseYFGApp+DmnA7ShOEmVsrLADROrxoy+itLU7pcdkCrMDIpk1LqBpDZVEI4xI5W9jZNRjlbqOj5dLoiTL5aFq+F+r5RUBJVRB7ZQkyqs0KjrH4QlByaqWkvJxv/u4UdGreNNvkISoTVSzZSL1kARWfhbKvnoMJ4NOPRTixvxeIwGvppd+8MYR4d2UymTnMat/DIoeMkBogjkxUOZptZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 21:38:43.0745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b95bac73-35bd-4c21-939e-08df33a981e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312
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

From: Alysa Liu <Alysa.Liu@amd.com>

When ualink info is available, report the specific link type
(UALOE or UALINK) instead of XGMI in topology sysfs.

Signed-off-by: Alysa Liu <Alysa.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 18 ++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  9 +++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  6 +++---
 include/uapi/linux/kfd_sysfs.h            |  2 ++
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 7725956e4b08..0583624e5897 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1254,7 +1254,7 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
 
 			if (props->iolink_type == CRAT_IOLINK_TYPE_PCIEXPRESS)
 				props->weight = 20;
-			else if (props->iolink_type == CRAT_IOLINK_TYPE_XGMI)
+			else if (crat_iolink_is_xgmi_class(props->iolink_type))
 				props->weight = iolink->weight_xgmi;
 			else
 				props->weight = node_distance(id_from, id_to);
@@ -2229,7 +2229,21 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int *avail_size,
 	sub_type_hdr->flags |= CRAT_SUBTYPE_FLAGS_ENABLED |
 			       CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
 
-	sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
+	if (kdev->adev->ualink.info) {
+		switch (kdev->adev->ualink.info->link_type) {
+		case AMDGPU_UALINK_TYPE_UALOE:
+			sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_UALOE;
+			break;
+		case AMDGPU_UALINK_TYPE_UALINK:
+			sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_UALINK;
+			break;
+		default:
+			sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
+			break;
+		}
+	} else {
+		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
+	}
 	sub_type_hdr->proximity_domain_from = proximity_domain_from;
 	sub_type_hdr->proximity_domain_to = proximity_domain_to;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index a8ca7ecb6d27..ce78484f94a5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -257,8 +257,17 @@ struct crat_subtype_ccompute {
 #define CRAT_IOLINK_TYPE_ETHERNET_RDMA	14
 #define CRAT_IOLINK_TYPE_RDMA_OTHER	15
 #define CRAT_IOLINK_TYPE_OTHER		16
+#define CRAT_IOLINK_TYPE_UALOE		17
+#define CRAT_IOLINK_TYPE_UALINK		18
 #define CRAT_IOLINK_TYPE_MAX		255
 
+static inline bool crat_iolink_is_xgmi_class(uint32_t type)
+{
+	return type == CRAT_IOLINK_TYPE_XGMI ||
+	       type == CRAT_IOLINK_TYPE_UALOE ||
+	       type == CRAT_IOLINK_TYPE_UALINK;
+}
+
 #define CRAT_IOLINK_RESERVED_LENGTH	24
 
 struct crat_subtype_iolink {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 8689f4110afc..1863a944d44d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1473,7 +1473,7 @@ static void kfd_set_iolink_no_atomics(struct kfd_topology_device *dev,
 					struct kfd_iolink_properties *link)
 {
 	/* xgmi always supports atomics between links. */
-	if (link->iolink_type == CRAT_IOLINK_TYPE_XGMI)
+	if (crat_iolink_is_xgmi_class(link->iolink_type))
 		return;
 
 	/* checkout source dev has atomics support on root. */
@@ -1572,7 +1572,7 @@ static void kfd_set_recommended_sdma_engines(struct kfd_topology_device *to_dev,
 			inbound_link->rec_sdma_eng_id_mask = xgmi_sdma_eng_id_mask;
 
 	} else {
-		uint32_t engine_mask = (outbound_link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
+		uint32_t engine_mask = (crat_iolink_is_xgmi_class(outbound_link->iolink_type) &&
 				num_xgmi_sdma_engines && to_dev->gpu) ? xgmi_sdma_eng_id_mask :
 				sdma_eng_id_mask;
 
@@ -1601,7 +1601,7 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 
 		/* Include the CPU peer in GPU hive if connected over xGMI. */
 		if (!peer_dev->gpu &&
-		    link->iolink_type == CRAT_IOLINK_TYPE_XGMI) {
+		    crat_iolink_is_xgmi_class(link->iolink_type)) {
 			/*
 			 * If the GPU is not part of a GPU hive, use its pci
 			 * device location as the hive ID to bind with the CPU.
diff --git a/include/uapi/linux/kfd_sysfs.h b/include/uapi/linux/kfd_sysfs.h
index 0b6ce2f3c887..b11f9bcae7f8 100644
--- a/include/uapi/linux/kfd_sysfs.h
+++ b/include/uapi/linux/kfd_sysfs.h
@@ -114,6 +114,8 @@
 #define HSA_IOLINK_TYPE_ETHERNET_RDMA	14
 #define HSA_IOLINK_TYPE_RDMA_OTHER	15
 #define HSA_IOLINK_TYPE_OTHER		16
+#define HSA_IOLINK_TYPE_UALOE		17
+#define HSA_IOLINK_TYPE_UALINK		18
 
 /* Flag bits in IO link properties (matches CRAT flags, excluding the
  * bi-directional flag, which is not offially part of the CRAT spec, and
-- 
2.34.1

