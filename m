Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C42606A334
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NtMeUpd0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 787F210E699;
	Mon,  9 Nov 2026 18:41:40 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013043.outbound.protection.outlook.com
 [40.93.196.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCAAE10E3AF
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 18:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dt5VsdPceWTJv5RUe3nIWfOYJlTbzW7a9aHA4a7SYiT/Vl/iy730DkTG+S6p7hefQLavz+N9JIi69YuS201kIqR1o1QlHx3CMws7uA4LARgS4JE2isytlNvG1kSnxb9yCj4ENJN4EWufHblg9KYe2PIFA7Wmk5VBq9iTlVc9jgr9HMPf6Youe6SRHfXZxkBkAO7vbI/qPa43Vb+NGApKFPcZwe3LwwcaGtEg4U1lSUjR8nkrRNAvs9yFfNVB/XEfjp97ERlcSMnQxGq1iKMkj9QaMnabUjAPDJn7aQGsM/CZM+DwhzujIqz2qBkqO/SRIlzcc0FYlVZzrsZLku6a9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgipHTi4tqFJrTqWfY1JQkp9Y+N+7gg6h60JCyZivs4=;
 b=TtH1NBkvRQXyqUv6d86utFL2YgEkzoBZsOL8ecVSZcIxvqlylVF7DWf9OYJpEciKcBJp1xqlk4uq5keAVlzD+UJ912g/PL5IA/IIjojhYFYTGVE1RVFdzHbQDlFcgJZxXV/1j7cTQd9MdJf+DrtYzHElZccpDjpe44cronUW2Jr6F7UEf60uCVeJCzGY/qpnDL38pxfEP6DXMBkUqxrDF7B2ArLERKXpS+rLVl9zz5u7SpSutkx33cIos3JqpA6KGCzyzFrWewY0Q6cVd3uAcXTn2qECNJv0ou4A9QWwIi6nsGxLy04+WKxYlgjxLrYYbzVPF2+GH8Z2MsVirOc2EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgipHTi4tqFJrTqWfY1JQkp9Y+N+7gg6h60JCyZivs4=;
 b=NtMeUpd0shCWKf6tbhHR5KTh9JgXhp1mkxWRAVVyhaGpBVtrIbO9ngu+1tEs/Xir7tVR9CR7rD6PlP25FVxd1lIMGH2Tup9lDSlUwMhEB6Wt3jK4XwJ7Dyf9SnZ9Gary17PYyC/mNIzmFhOuZXb2PbxFivPf8mgUtvPR75zLElY=
Received: from MW4PR03CA0052.namprd03.prod.outlook.com (2603:10b6:303:8e::27)
 by LV2PR12MB707735.namprd12.prod.outlook.com (2603:10b6:408:424::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 18:41:30 +0000
Received: from EA8PEPF0000000A.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::82) by MW4PR03CA0052.outlook.office365.com
 (2603:10b6:303:8e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 18:41:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF0000000A.mail.protection.outlook.com (10.167.249.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 18:41:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 12:41:28 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 12:41:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Add max_cu_per_engine property
Date: Mon, 9 Nov 2026 13:41:12 -0500
Message-ID: <20261109184113.3656539-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109184113.3656539-1-alexander.deucher@amd.com>
References: <20261109184113.3656539-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000A:EE_|LV2PR12MB707735:EE_
X-MS-Office365-Filtering-Correlation-Id: 087fa4ff-b5c5-4b80-85ff-08df3e91117a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|11063799006|56012099006|261021121427099003|261022075727099003|261009223027099003|261102123227099003|261026121527099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: j1gcRI+O4yBCwI53SrUcjQ7kFpGgdrJpThSO2oA/JiNcN7yUl+0U4RE7HviAmrQtII0aV4qqwLdT+JGNCCigb6NUayR4VcYbclTXt+vD5nR6L9vTxOudtDuS1Sg8hClEzWg6GyeanyuGtInamcGuqbUKLMiQ0ILRn3aYIa9AiIJjhYXOoBCWMssvATA1M41M4vsqTlsyfs6GzDsoMyPBJK5p8zQFo5RKBIKJsiHtA01sAEn/C20cG4Uf0ae0SFq2j/uuFS3M6qHd7VReWcMjemtWuZYfZglq/8wEoRZfzPBqBszDFjP4cj34owifaOrvKVoEU+kbzhWg/4bO3dh+6OJYZcG30mZWyHb+syCJjF4yZsnsVo0vJ1vqhMhO1lwWG2HusHCs38B4tVX5dg95/E+Ha3VK7yLH49FMF4LpHmQmy+KXkmjXbr+Mr/p9Ym9ijp05skzRsdCAG6CoNtHWLbIdl7U0anX65ph4F7UjsdepusV0t2Mf72Xm1PnG6ITWW95P8v5RS2mZw8+2bgFr35UfJrJcXia2rMMIZG8tl2GS/hclC6cdO5jtMg/4PZZ1tETWRh2mGn+s/8/5gv+BpT39M6AEypwLIk8Dbgflax4qbMZgc8ovBqCZUDEXdFV0TcDSA+JPMP8DlGx9WpjRzFOKdTW3PNEQG43I8AB8MqKYvEIBomXyojxXjK2EjvXW/8+HND4skzU2e80vwJEnPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vEC350DHb5rCfNGouFLPkCaNRLT/B/y9il4EHdpeKnolYOXLZDxEFYjJ6lWmRcZb5yAvCWZ3xHRFkQyaBLfzxXRKaYXqcJRQhcU+ldpP2YKqvPzjr+dvsJv5pa+xovRaHMDR2xIFbPS3N341yEjFvcXlzfMJ4ue1EAsR2iFCRa9skcELxhsKI+H4jPP3MIldshVI1ahE7PiRS7HBQC8Ag9Wlw46LO8W6yZRQ0iLaxSlyivuiz36qZW8BVbcw2h+GoJqLas4Y1PBrPnme6bN2bYixtqQivL9BIyZyAs/P4l+Jh9gVTjbNGf84pUCwpDUvIfHjHWWNjiGPlGHl6Vv+n0nq9rx2d+c5RKlv1E7P3L36WxK77zNaom5J5ilR3SeIeAmiBquy5dAgjhYbYwrcIk9fEdmm6LnTHqvflFegL0laQkUuIJxtOt8s1rFKIEMb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:41:29.2975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 087fa4ff-b5c5-4b80-85ff-08df3e91117a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF0000000A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB707735
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

From: David Belanger <david.belanger@amd.com>

This property is the max possible number of CU for an engine and consider
asymmetric configuration.

Signed-off-by: David Belanger <david.belanger@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h     | 1 +
 4 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f10560b65f116..9d500e4d01951 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2168,6 +2168,8 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 		adev->gfx.config.max_cu_per_sh = 2 * (le32_to_cpu(gc_info->v1.gc_num_wgp0_per_sa) +
 					      le32_to_cpu(gc_info->v1.gc_num_wgp1_per_sa));
 		adev->gfx.config.max_sh_per_se = le32_to_cpu(gc_info->v1.gc_num_sa_per_se);
+		adev->gfx.config.max_cu_per_se =
+			adev->gfx.config.max_sh_per_se * adev->gfx.config.max_cu_per_sh;
 		adev->gfx.config.max_backends_per_se = le32_to_cpu(gc_info->v1.gc_num_rb_per_se);
 		adev->gfx.config.max_texture_channel_caches = le32_to_cpu(gc_info->v1.gc_num_gl2c);
 		adev->gfx.config.max_gprs = le32_to_cpu(gc_info->v1.gc_num_gprs);
@@ -2208,6 +2210,7 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 					   le32_to_cpu(gc_info->v1_4.gc_num_twgp1_per_sa1);
 			adev->gfx.config.max_cu_per_sh = 2 * (num_wgps_per_sa >= num_wgps_per_sa1 ?
 							      num_wgps_per_sa : num_wgps_per_sa1);
+			adev->gfx.config.max_cu_per_se = 2 * (num_wgps_per_sa + num_wgps_per_sa1);
 		} else if (le16_to_cpu(gc_info->v1.header.version_minor) >= 3) {
 			adev->gfx.config.gc_tcp_size_per_cu = le32_to_cpu(gc_info->v1_3.gc_tcp_size_per_cu);
 			adev->gfx.config.gc_tcp_cache_line_size = le32_to_cpu(gc_info->v1_3.gc_tcp_cache_line_size);
@@ -2229,12 +2232,15 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 					   le32_to_cpu(gc_info->v1_5.gc_num_wgp1_per_sa1);
 			adev->gfx.config.max_cu_per_sh = num_wgps_per_sa >= num_wgps_per_sa1 ?
 							 num_wgps_per_sa : num_wgps_per_sa1;
+			adev->gfx.config.max_cu_per_se = 2 * (num_wgps_per_sa + num_wgps_per_sa1);
 		}
 		break;
 	case 2:
 		adev->gfx.config.max_shader_engines = le32_to_cpu(gc_info->v2.gc_num_se);
 		adev->gfx.config.max_cu_per_sh = le32_to_cpu(gc_info->v2.gc_num_cu_per_sh);
 		adev->gfx.config.max_sh_per_se = le32_to_cpu(gc_info->v2.gc_num_sh_per_se);
+		adev->gfx.config.max_cu_per_se =
+			adev->gfx.config.max_sh_per_se * adev->gfx.config.max_cu_per_sh;
 		adev->gfx.config.max_backends_per_se = le32_to_cpu(gc_info->v2.gc_num_rb_per_se);
 		adev->gfx.config.max_texture_channel_caches = le32_to_cpu(gc_info->v2.gc_num_tccs);
 		adev->gfx.config.max_gprs = le32_to_cpu(gc_info->v2.gc_num_gprs);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 5939e1fb3b241..e4458b5e35380 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -238,6 +238,7 @@ struct amdgpu_gfx_config {
 	unsigned max_tile_pipes;
 	unsigned max_cu_per_sh;
 	unsigned max_sh_per_se;
+	unsigned max_cu_per_se;
 	unsigned max_backends_per_se;
 	unsigned max_texture_channel_caches;
 	unsigned max_gprs;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 1ef4d26a0ac69..af0c161c520dd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -466,6 +466,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			      dev->node_props.cu_per_simd_array);
 	sysfs_show_32bit_prop(buffer, offs, "simd_per_cu",
 			      dev->node_props.simd_per_cu);
+	sysfs_show_32bit_prop(buffer, offs, "max_cu_per_engine",
+			      dev->node_props.max_cu_per_engine);
 	sysfs_show_32bit_prop(buffer, offs, "max_slots_scratch_cu",
 			      dev->node_props.max_slots_scratch_cu);
 	sysfs_show_32bit_prop(buffer, offs, "gfx_target_version",
@@ -2100,6 +2102,8 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	dev->node_props.simd_arrays_per_engine =
 		gfx_info->max_sh_per_se;
 
+	dev->node_props.max_cu_per_engine = gpu->adev->gfx.config.max_cu_per_se;
+
 	dev->node_props.gfx_target_version =
 				gpu->kfd->device_info.gfx_target_version;
 	dev->node_props.vendor_id = gpu->adev->pdev->vendor;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index ad63ba67b5774..0f29da44c45ae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -62,6 +62,7 @@ struct kfd_node_properties {
 	uint32_t simd_arrays_per_engine;
 	uint32_t cu_per_simd_array;
 	uint32_t simd_per_cu;
+	uint32_t max_cu_per_engine;
 	uint32_t max_slots_scratch_cu;
 	uint32_t engine_id;
 	uint32_t gfx_target_version;
-- 
2.56.0

