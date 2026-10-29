Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22088606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sNOKEp45
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B47AE10E0B8;
	Thu, 29 Oct 2026 21:08:17 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78F5910E0B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 21:08:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5j8hKha88r/MusE2n+BlagthECw4n9chQC91m5X+7B4irhEvNJK+ay4k6X4tCPlDORYIWhke+MPBDZI3twkRNwpPeFf6QEekg/0wj2hH3+/DOX6J8QnSoQ4spI5d+BT0VUkF/oRdNWKCbYliNGuddVJH4CGSlpCYsqernV2Xwnp7sKF19XvCx3vstASdu7Y6aOFoCKIZ8zMQixuUxJaIWvT6yrDggVidX0gtS8SLzSd0Dtg0hCMF9/sbVgGjveHJjiuSq+iKooAfb5HF/1Rh58jKKWITKpM9p/qKPIVFNocUuL+kDkW6SZ9zY0WjpS5WnKO26n8NSLDZ1HULSDmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDps6W/ZBPAA+hus0nstfMtd9sqDXCO8dmgwKYq5Xak=;
 b=ve1jX4TW7/Vw61anEt7sK59Z+9YZ+w5ZkEswpTcgeUCHyQKRbTAvYYx363kqa64gp+02+80afvXLrWJ9J+yXhWf9Q7IMuNEWwcrTeOO3MBQ+nAvLprIaXOwLc65GgLdjFBaYwhNZupHpRUaPDGRuCj26U0drDLPt2aqPMt8FTJseHxovvETB8gyVJG7RHgIZB4ZrERJun00BWrMpQrSXh7bQCc8rAGG7ywHKqNEGPFSNc/wo20i3kSujAFQeOebj6KJC3WalI114X7mKSORXEOuWQS9iACnQIo3qUuHDXXwDjREjz04JdJhu8wpYbPmVaBWo+WgYNkF4XxLdpxZKyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDps6W/ZBPAA+hus0nstfMtd9sqDXCO8dmgwKYq5Xak=;
 b=sNOKEp45MJTvrAlk+3jDSFJQdvqN90OVYXV7iT8Guqczc6RXCG0NhrNs0n0lOdktXwl1db+EuRzoLsbTANYhm4pmHV+VxUxJgVP0Ka+Vsua1D9tKCmGV4ixL9ctAuZF7l2v9464olQokUPmeAuDi5FN047lR2PFa7y2DRAWlkj0=
Received: from CH2PR18CA0036.namprd18.prod.outlook.com (2603:10b6:610:55::16)
 by DS0PR12MB6437.namprd12.prod.outlook.com (2603:10b6:8:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 21:07:11 +0000
Received: from CH01EPF000BE944.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::16) by CH2PR18CA0036.outlook.office365.com
 (2603:10b6:610:55::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 29 Oct 2026 21:07:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE944.mail.protection.outlook.com (10.167.244.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 21:07:10 +0000
Received: from alex-sierra-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 16:07:07 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Lijo.Lazar@amd.com>, <Mukul.Joshi@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, Alysa Liu <Alysa.Liu@amd.com>
Subject: [PATCH] drm/amdkfd: Add UALOE and UALINK IO link types
Date: Thu, 29 Oct 2026 16:02:19 -0500
Message-ID: <20261029210219.3233503-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026213820.2979770-1-alex.sierra@amd.com>
References: <20261026213820.2979770-1-alex.sierra@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE944:EE_|DS0PR12MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ccbdd9-7d5b-4c93-3c5c-08df36009948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|261028144727099003|261022105027099003|11063799006|56012099006|261026121527099003|261026140227099003|10067099003|261009223027099003|261021123027099003|261021121427099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: y7Dk3ambicRcyJiuUeEJQNzHPFLzKBNOX8I8f/xRU/yXwk1qtgNyF8Qb+HFUYTUyP+9q2mRIT2RMsMmmAo2FHJvn0jaGovjP8SvVReUvy+8UNQW5uQqsQaKgislO0YtQNNfncJUHW9m0U7gk3xK36E2D1cWlEzGf9DFEu2EwJGjqoG1VMpKHShXaoC/R6O7wDRTOV6oowrMNP0KdsFVOippN3yREMdylVcRmHPwQM9T3k5R7/CR0ZtSKqJwp9GXEGjtc8MGvGrVE2YXAXgkCq4L6g4ecHEYga9nJklcApdqH+n18VwEHgwHpqL5up9FuXvdWE9k4jmsniZLqVIPC9XGvAori0x8AzJCmqZp0yyCrQI7YU55x5OPeBSq9USL+wzNpApa+BEn5/AJRUB+kWx0iAcvWNpji5dzOXaCXhrw+aUAj9uQ4uIDKqwTyx+BOgR2X1VbV18sIuV6VwefG6KNvcgu6cY7Ti2zRgPSbqnbyoYs0sKkb+jWow8QuhjL0F0jPPqIKDjl6MAvi7ct4WFp6kebmUuptZ58gabkcf2iEe7xhJvnGFidByygNXpnm2f3q5ZwqtZe7gtEuVDHxrCenm8YT/xT6VI78VPVJqaVmrL14v52YXDPGWpkBkRYvlDcdyO39C2cXhnEJazxrq8+AO17v0x4/h7b6VvxvDLka9etqHkvX7rV+nGe1xZzB8akb+pUwHm5sy9pvcn0Fsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(261028144727099003)(261022105027099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(10067099003)(261009223027099003)(261021123027099003)(261021121427099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +KOKoaXbXks/hztmP2YWK72px0ZJKr+F9jXxR15wGh0I+mTt9BweC6U3FXLaFyZvcJZT+cd+oC7mlNdk/rFWSWyjbFjMMF4ppGis7OKh0HLgZdkudTTedmSYucavw7GR7gdExFh4OB0xdNEDodg28pyWCRyXmh4gFTRcXiJwtX9LE3TrM4RKuoPSk0Y3Ml6JvsAqJTyCXAnvS2uLQ1/PjGLXOwO/GDNaTFGtx8AbyPWP81HexbclB5tv0ehtQ64XKNoeNOY0Q3UJAfCf0Dh1/qS4K0MraNERU6JKR0RIB7K2GQ8L1dFXu5Y4cNzlc1BMgpBWm34USTgURjs5OFXVA81VdP+AyfPecsTL/k6E3olNq0itcK/4YKHKDXuOylYOAmgzjV2T2Y76tuTlXHdGQG9WPdgUCVi/KNpBKR1VTWKWF/wgoq6ZDDGj+mHpUDei
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 21:07:10.8696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ccbdd9-7d5b-4c93-3c5c-08df36009948
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE944.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6437
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alysa Liu <Alysa.Liu@amd.com>

When ualink info is available, report the specific link type
(UALOE or UALINK) instead of XGMI in topology sysfs.

UALink and UALoE use different link weights so userspace can prefer
native UALink over UALink-over-Ethernet. UALink links advertise every
SDMA engine, since those SOCs do not reserve a dedicated xGMI SDMA set.

Signed-off-by: Alysa Liu <Alysa.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 60 +++++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h     | 13 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 17 +++++--
 include/uapi/linux/kfd_sysfs.h            |  2 +
 4 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 2c49c3f0789f..35f9d693d2b0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1252,9 +1252,14 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
 			props->ver_min = iolink->version_minor;
 			props->iolink_type = iolink->io_interface_type;
 
+			/*
+			 * weight_xgmi stores the link cost for xGMI, UALink,
+			 * and UALoE. It is selected per link type when the
+			 * IO link record is built.
+			 */
 			if (props->iolink_type == CRAT_IOLINK_TYPE_PCIEXPRESS)
 				props->weight = 20;
-			else if (props->iolink_type == CRAT_IOLINK_TYPE_XGMI)
+			else if (crat_iolink_is_xgmi_class(props->iolink_type))
 				props->weight = iolink->weight_xgmi;
 			else
 				props->weight = node_distance(id_from, id_to);
@@ -2132,6 +2137,26 @@ static void kfd_find_numa_node_in_srat(struct kfd_node *kdev)
 
 #define KFD_CRAT_INTRA_SOCKET_WEIGHT	13
 #define KFD_CRAT_XGMI_WEIGHT		15
+/*
+ * Relative link cost, lower is preferred. PCIe is 20.
+ * Native UALink is a scale-up load/store fabric in the same class as xGMI.
+ * UALoE (UALink over Ethernet) is a higher-latency path, so it costs more
+ * than UALink but stays preferred over PCIe.
+ */
+#define KFD_CRAT_UALINK_WEIGHT		15
+#define KFD_CRAT_UALOE_WEIGHT		18
+
+static uint8_t kfd_crat_iolink_base_weight(uint8_t io_type)
+{
+	switch (io_type) {
+	case CRAT_IOLINK_TYPE_UALOE:
+		return KFD_CRAT_UALOE_WEIGHT;
+	case CRAT_IOLINK_TYPE_UALINK:
+		return KFD_CRAT_UALINK_WEIGHT;
+	default:
+		return KFD_CRAT_XGMI_WEIGHT;
+	}
+}
 
 /* kfd_fill_gpu_direct_io_link - Fill in direct io link from GPU
  * to its NUMA node
@@ -2234,13 +2259,38 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int *avail_size,
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
 
 	if (use_ta_info) {
-		sub_type_hdr->weight_xgmi = KFD_CRAT_XGMI_WEIGHT *
+		unsigned int hops =
 			amdgpu_xgmi_get_hops_count(kdev->adev, peer_kdev->adev);
+		uint8_t base = kfd_crat_iolink_base_weight(sub_type_hdr->io_interface_type);
+
+		/*
+		 * Hop count comes from the xGMI topology and is zero when the
+		 * peer is not listed there. A UALink/UALoE direct link still
+		 * needs its own base weight in that case.
+		 */
+		if (!hops && crat_iolink_is_ual(sub_type_hdr->io_interface_type))
+			hops = 1;
+
+		sub_type_hdr->weight_xgmi = base * hops;
 		amdgpu_xgmi_get_bandwidth(kdev->adev, peer_kdev->adev,
 					  AMDGPU_XGMI_BW_MODE_PER_PEER,
 					  AMDGPU_XGMI_BW_UNIT_MBYTES,
@@ -2248,8 +2298,10 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int *avail_size,
 					  &sub_type_hdr->maximum_bandwidth_mbs);
 	} else {
 		bool is_single_hop = kdev->kfd == peer_kdev->kfd;
+		uint8_t link_weight =
+			kfd_crat_iolink_base_weight(sub_type_hdr->io_interface_type);
 		int weight = is_single_hop ? KFD_CRAT_INTRA_SOCKET_WEIGHT :
-			(2 * KFD_CRAT_INTRA_SOCKET_WEIGHT) + KFD_CRAT_XGMI_WEIGHT;
+			(2 * KFD_CRAT_INTRA_SOCKET_WEIGHT) + link_weight;
 		int mem_bw = 819200;
 
 		sub_type_hdr->weight_xgmi = weight;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index ff6ecae34a5e..f640c0398546 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -257,8 +257,21 @@ struct crat_subtype_ccompute {
 #define CRAT_IOLINK_TYPE_ETHERNET_RDMA	14
 #define CRAT_IOLINK_TYPE_RDMA_OTHER	15
 #define CRAT_IOLINK_TYPE_OTHER		16
+#define CRAT_IOLINK_TYPE_UALOE		17
+#define CRAT_IOLINK_TYPE_UALINK		18
 #define CRAT_IOLINK_TYPE_MAX		255
 
+static inline bool crat_iolink_is_ual(uint32_t type)
+{
+	return type == CRAT_IOLINK_TYPE_UALOE ||
+	       type == CRAT_IOLINK_TYPE_UALINK;
+}
+
+static inline bool crat_iolink_is_xgmi_class(uint32_t type)
+{
+	return type == CRAT_IOLINK_TYPE_XGMI || crat_iolink_is_ual(type);
+}
+
 #define CRAT_IOLINK_RESERVED_LENGTH	24
 
 struct crat_subtype_iolink {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 5c3a134a9e5c..9fa26a01ebfb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1215,7 +1215,7 @@ static void kfd_set_iolink_no_atomics(struct kfd_topology_device *dev,
 					struct kfd_iolink_properties *link)
 {
 	/* xgmi always supports atomics between links. */
-	if (link->iolink_type == CRAT_IOLINK_TYPE_XGMI)
+	if (crat_iolink_is_xgmi_class(link->iolink_type))
 		return;
 
 	/* check pcie support to set cpu(dev) flags for target_gpu_dev link. */
@@ -1283,8 +1283,13 @@ static void kfd_set_recommended_sdma_engines(struct kfd_topology_device *to_dev,
 	uint32_t sdma_eng_id_mask = (1 << num_sdma_engines) - 1;
 	uint32_t xgmi_sdma_eng_id_mask =
 			((1 << num_xgmi_sdma_engines) - 1) << num_sdma_engines;
+	bool ual_link = crat_iolink_is_ual(outbound_link->iolink_type);
 
-	bool support_rec_eng = !amdgpu_sriov_vf(adev) && to_dev->gpu &&
+	/*
+	 * The per-socket recommended-engine map is an xGMI property.
+	 * UALink SOCs do not reserve dedicated SDMA engines.
+	 */
+	bool support_rec_eng = !ual_link && !amdgpu_sriov_vf(adev) && to_dev->gpu &&
 		adev->aid_mask && num_xgmi_nodes && gpu->kfd->num_nodes == 1 &&
 		num_xgmi_sdma_engines >= 6 && (!(adev->flags & AMD_IS_APU) &&
 		num_xgmi_nodes == 8);
@@ -1305,6 +1310,12 @@ static void kfd_set_recommended_sdma_engines(struct kfd_topology_device *to_dev,
 		if (inbound_link->rec_sdma_eng_id_mask & sdma_eng_id_mask)
 			inbound_link->rec_sdma_eng_id_mask = xgmi_sdma_eng_id_mask;
 
+	} else if (ual_link) {
+		/* No dedicated fabric SDMA engines; every engine is usable. */
+		uint32_t engine_mask = sdma_eng_id_mask | xgmi_sdma_eng_id_mask;
+
+		outbound_link->rec_sdma_eng_id_mask = engine_mask;
+		inbound_link->rec_sdma_eng_id_mask = engine_mask;
 	} else {
 		uint32_t engine_mask = (outbound_link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
 				num_xgmi_sdma_engines && to_dev->gpu) ? xgmi_sdma_eng_id_mask :
@@ -1335,7 +1346,7 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 
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

