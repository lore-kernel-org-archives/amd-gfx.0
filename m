Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E86C25B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 22:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D08910E8C6;
	Thu, 26 Oct 2023 22:19:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1561510E8C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 22:19:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbCOIuqqUnOqE1ADhm80wqP0IwhNpThBkW8opHLkr2auLHFPV5QD3b2JeOuoaCDiVePu3nh5ev7Hqf1ubCjzQcOjUa1ZwcsnlJZSQ3IGpym7mOZfiR6BZ/9J7XVAsGBcr9G+FWIRER30gIT62b+813JZmDDe0nL5tEsWaZv1AXjDxSKZFIqplB/bZHQHcXhRWhEWfN040LQ68awjAn6nerp6stLcJ4xVAdc0XgUbwMzyW2QVnaQKuj7TFnndF/WRIyWDmolTE/GVd63VKReAtlVO03CZORAbk+QUbJeNxucvQKG6SRGELOLAGjWgBwE0TTj/QHQCM+Sp9xIdt3QFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0u2D+kpJBBCnQfAZDz+2cT0GuxufBi6NchD6xnJyXE=;
 b=Kgkdcl+s8Udqo6Cbu25rPHT7fdjF1CF5E06a0mEQrjEecugviBks/4XdngITKBwIEpeWb2tbPAL2UZTal4vvuHAIodhk044mH8W48y/tulQM+paZPnBdOLXe2G8L2GGk4Ul0KmrnesusSEq0gGiVtBcVNjWCBLS0qlHxZfeGyRR9Z1C08Fk6S57viTA20yetijWV7TGvMzCRvbpR3w+CcdqeGOtbZ+WBU7xm/Q2lJR2gzHxM5jbLUkCY+ZoElSVRebB2rTAYfwehXZn8lzaiouYaTSSzrZUzSp54SqJI1mkq59RGD6eQ/hDeMNdIw/aamZZ96IILPqVDRPpmXnfzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0u2D+kpJBBCnQfAZDz+2cT0GuxufBi6NchD6xnJyXE=;
 b=p8SnPbQo2ByTwtG4D1xfSidoszMj2AEdWDP28jqsF/OTMSG82hSQVvU8xs7XQjYDr1hY5rFfeSRGOsZjmwsH8kqifzM9znamQjER5Y0F61JQm+TUAxs7MQ8c0Mjxj7v9heuwli4bqVFjEBQrm4SJqpv9zsO1tEcKYH4vzCEVrp0=
Received: from SJ0PR13CA0231.namprd13.prod.outlook.com (2603:10b6:a03:2c1::26)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Thu, 26 Oct
 2023 22:19:23 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::3) by SJ0PR13CA0231.outlook.office365.com
 (2603:10b6:a03:2c1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8 via Frontend
 Transport; Thu, 26 Oct 2023 22:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 22:19:23 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 17:19:22 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Update cache reporting for GFX 9.4.3
Date: Thu, 26 Oct 2023 18:18:40 -0400
Message-ID: <20231026221840.441807-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: 1379ddf1-bd59-4fe5-3b42-08dbd6719bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TY21UV0KcOvNK96ke39GJRRSLbg+rdZxW86xehwqv3i1S5iiB7U3SuT423VXo1so3DGtcqTq2++rUOK3X4L/tbH898yW1V8ZU2yiWIkVi7cQpGaBoRFlIykBLPUrubYHqpQdEYL+yDhvGwkNAo9f8OKM+qRZB3asqdtrOOL3Q7/bNQGwJQP9P+Z7/0gwP6Kj/isD3m3XHaLcqbXsWW+eiIs7OcTDWS/lbjTlLwIyCXpFo0APrVfLxZh0JSJIiAnSJWK/vaY0Mp09PbctsKecSt3ptgwnZjC2W/esnxRjQBnZeWQ7UPzcGYLVxKhaa4dOdfjR+TBtLUz8w55iWgrGkfmPJ9knrrQHW+1ZjoqgcRlHAVhA6qSPJpdk/J9dNU+dadlogOGmTd/DSqvjPV13LW+d6c0LV/fcJ948zsX9JofRuO9Ed1QicZ0IBZoV2ItGJdxkTcuRNnXJjGoRsjiEJcEMHCovJZeztgI56Jps6+rN5+n7sHBzOlN7vf9SGVf4/SquO153Q1Xny+nEG8jseENpQtkFUCeKoPWnMC8MRmSshjkCcvTx1k0obGO8mk7aI3h8gPDcWNcHJEtV4LmUxFTT3R+GTE8kXAAcgeGF+1k1f6+8pNboLzJRC37lT/j0F+v1teboIFcjfl0nIOxVYMlm1h8B+lsLVRwrWmF+Bb/dWwyljCXI2CE3St1UruMxtJiUuGCS9LtH+XtAbjPTY9Pn2IEI3ImYIivNjcZ8XT6dXT37rw7C6i+lH5Si5GcWOISmIIZbipIRxJFL2jkFBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(82310400011)(186009)(36840700001)(40470700004)(46966006)(41300700001)(16526019)(2906002)(81166007)(40460700003)(54906003)(316002)(82740400003)(6666004)(6916009)(1076003)(70206006)(70586007)(336012)(47076005)(40480700001)(426003)(83380400001)(7696005)(36860700001)(44832011)(86362001)(5660300002)(15650500001)(478600001)(2616005)(4326008)(36756003)(8936002)(8676002)(26005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 22:19:23.3159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1379ddf1-bd59-4fe5-3b42-08dbd6719bb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188
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
Cc: alexander.deucher@amd.com, Mukul Joshi <mukul.joshi@amd.com>,
 Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFX 9.4.3 uses a new version of the GC info table in IP
discovery. This patch adds a new function to parse and
fill the cache information based on the new table. Also,
update cache reporting based on compute and memory
partitioning modes.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 66 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 23 +++++++-
 2 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 0e792a8496d6..cd8e459201f1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1404,6 +1404,66 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
 	return i;
 }
 
+static int kfd_fill_gpu_cache_info_from_gfx_config_v2(struct kfd_dev *kdev,
+						   struct kfd_gpu_cache_info *pcache_info)
+{
+	struct amdgpu_device *adev = kdev->adev;
+	int i = 0;
+
+	/* TCP L1 Cache per CU */
+	if (adev->gfx.config.gc_tcp_size_per_cu) {
+		pcache_info[i].cache_size = adev->gfx.config.gc_tcp_size_per_cu;
+		pcache_info[i].cache_level = 1;
+		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
+					CRAT_CACHE_FLAGS_DATA_CACHE |
+					CRAT_CACHE_FLAGS_SIMD_CACHE);
+		pcache_info[i].num_cu_shared = 1;
+		i++;
+	}
+	/* Scalar L1 Instruction Cache per SQC */
+	if (adev->gfx.config.gc_l1_instruction_cache_size_per_sqc) {
+		pcache_info[i].cache_size =
+			adev->gfx.config.gc_l1_instruction_cache_size_per_sqc;
+		pcache_info[i].cache_level = 1;
+		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
+					CRAT_CACHE_FLAGS_INST_CACHE |
+					CRAT_CACHE_FLAGS_SIMD_CACHE);
+		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_cu_per_sqc;
+		i++;
+	}
+	/* Scalar L1 Data Cache per SQC */
+	if (adev->gfx.config.gc_l1_data_cache_size_per_sqc) {
+		pcache_info[i].cache_size = adev->gfx.config.gc_l1_data_cache_size_per_sqc;
+		pcache_info[i].cache_level = 1;
+		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
+					CRAT_CACHE_FLAGS_DATA_CACHE |
+					CRAT_CACHE_FLAGS_SIMD_CACHE);
+		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_cu_per_sqc;
+		i++;
+	}
+	/* L2 Data Cache per GPU (Total Tex Cache) */
+	if (adev->gfx.config.gc_tcc_size) {
+		pcache_info[i].cache_size = adev->gfx.config.gc_tcc_size;
+		pcache_info[i].cache_level = 2;
+		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
+					CRAT_CACHE_FLAGS_DATA_CACHE |
+					CRAT_CACHE_FLAGS_SIMD_CACHE);
+		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
+		i++;
+	}
+	/* L3 Data Cache per GPU */
+	if (adev->gmc.mall_size) {
+		pcache_info[i].cache_size = adev->gmc.mall_size / 1024;
+		pcache_info[i].cache_level = 3;
+		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
+					CRAT_CACHE_FLAGS_DATA_CACHE |
+					CRAT_CACHE_FLAGS_SIMD_CACHE);
+		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
+		i++;
+	}
+	return i;
+}
+
 int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pcache_info)
 {
 	int num_of_cache_types = 0;
@@ -1461,10 +1521,14 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
 			num_of_cache_types = ARRAY_SIZE(vega20_cache_info);
 			break;
 		case IP_VERSION(9, 4, 2):
-		case IP_VERSION(9, 4, 3):
 			*pcache_info = aldebaran_cache_info;
 			num_of_cache_types = ARRAY_SIZE(aldebaran_cache_info);
 			break;
+		case IP_VERSION(9, 4, 3):
+			num_of_cache_types =
+				kfd_fill_gpu_cache_info_from_gfx_config_v2(kdev->kfd,
+									*pcache_info);
+			break;
 		case IP_VERSION(9, 1, 0):
 		case IP_VERSION(9, 2, 2):
 			*pcache_info = raven_cache_info;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 4e530791507e..1a79a6c25466 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1602,10 +1602,13 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 	unsigned int cu_sibling_map_mask;
 	int first_active_cu;
 	int i, j, k, xcc, start, end;
+	int num_xcc = NUM_XCC(knode->xcc_mask);
 	struct kfd_cache_properties *pcache = NULL;
+	enum amdgpu_memory_partition mode;
+	struct amdgpu_device *adev = knode->adev;
 
 	start = ffs(knode->xcc_mask) - 1;
-	end = start + NUM_XCC(knode->xcc_mask);
+	end = start + num_xcc;
 	cu_sibling_map_mask = cu_info->bitmap[start][0][0];
 	cu_sibling_map_mask &=
 		((1 << pcache_info[cache_type].num_cu_shared) - 1);
@@ -1624,7 +1627,23 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 		pcache->processor_id_low = cu_processor_id
 					+ (first_active_cu - 1);
 		pcache->cache_level = pcache_info[cache_type].cache_level;
-		pcache->cache_size = pcache_info[cache_type].cache_size;
+		if (pcache->cache_level == 2) {
+			pcache->cache_size = pcache_info[cache_type].cache_size * num_xcc;
+		} else {
+			if (KFD_GC_VERSION(knode) == IP_VERSION(9, 4, 3)) {
+				mode = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
+				if (mode) {
+					pcache->cache_size =
+						pcache_info[cache_type].cache_size / mode;
+				} else {
+					dev_warn(adev->dev, "Unexpected memory partition %u", mode);
+					pcache->cache_size =
+						pcache_info[cache_type].cache_size;
+				}
+			} else {
+				pcache->cache_size = pcache_info[cache_type].cache_size;
+			}
+		}
 
 		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_DATA_CACHE)
 			pcache->cache_type |= HSA_CACHE_TYPE_DATA;
-- 
2.35.1

