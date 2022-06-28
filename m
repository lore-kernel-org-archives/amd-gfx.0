Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9F2C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 14:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4649910FAA9;
	Tue, 28 Jun 2022 14:51:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4F010F9FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 14:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Raj38PhodtROZXz+JsVtbi7ofS9P2M1ICEVZEgwUdEYkAEL2MyH8rDZeJBO3c3wBkuAZpON2ITP9E2uYX8OLx5W9QrrSlSp9wAPp9EAPUvTgaWvObrn7c4dldLn/C3kBJKMaIiaVWTqtQtUvRhH7kKs2oGH5iBLsimYIMlAlLQ9aBWi4gRhm+Y0IGxKz7snholhDqIgtAKUywfqO0/Ay1p3yqD1K98YohJtLejGuXq34erXFQlMjFBGauXslMH6gT5X3bU0PP/qF6vcAb/cC726+N9DEqRdWvzwBMUHKxph6h9Q4vQhwdajj0sOCkJ0caKCwqLxlv5OGQtUOwG6Luw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf0/h7XaRhG+6dwFHaeA5HvkDIAKG0uhhqcxy1Z0zaY=;
 b=gIPQHh2qBY0MqXVR4AH3iQwJewyS8dl4oo9kVyhgVMoPrwhKvG7GTLC0CPfBdY8k9UtORBhRLjwhOsafOtKSubWCtynxwoY7GK6HWYYDh4/m7YkPOLJvBmjxcmqO5c40ZgyDII3jB+G5R3YXjczUNHAknfBNzkaEi+B/w8f+7Zhn4snWJryg7D8KLI77cQ+ocFXV9un9jXGtj/3Sw7TkY1544rnbQ8op1MYigSzZlcTcv9vVrriudddwUZItyXo52UbOT3zmb8129XuEy1rV38UafAQjllX6iHzTNgJ4Ls5TkFUN9lqtnejDz1WGR6XQR+GPxiJkBc4aOTPwzHvQtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf0/h7XaRhG+6dwFHaeA5HvkDIAKG0uhhqcxy1Z0zaY=;
 b=Ez6iCZTS993tlGGS75hDSaM+y5ka7igHJud/3FvLXaYqJOakE3bvJLV7zAFMoT8SkrG4eudRgprUPfpO52NHY1JQYn1G0Kp5qsyHjnbtIiBRBm1JD80NZP/notzA0Jb54jdUk7gt/VMrflSxDr3guFp4B8NYgO+UOVVB6TR/haw=
Received: from MWHPR17CA0077.namprd17.prod.outlook.com (2603:10b6:300:c2::15)
 by MWHPR1201MB0063.namprd12.prod.outlook.com (2603:10b6:301:4d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 14:51:29 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::80) by MWHPR17CA0077.outlook.office365.com
 (2603:10b6:300:c2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Tue, 28 Jun 2022 14:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 14:51:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 09:51:24 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 9/11] libhsakmt: hsaKmtGetNodeProperties add gpu_id
Date: Tue, 28 Jun 2022 10:50:18 -0400
Message-ID: <20220628145020.26925-10-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628145020.26925-1-Philip.Yang@amd.com>
References: <20220628145020.26925-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f51ba01-c8f3-4a47-69dc-08da5915aee0
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0063:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Dpy9LBh5cqTRKLzpqO4V1iwm2lqdfBdsSpM6McLgWyB7j9rAMpo9DiRdhWPzBLlrceWgDZJ3Nsj7B/fhwhSuH3iYdgz896B3Gww6VqAtWgpydrQJAvIk07r0gAE28oZhRM+DkTDw7Eo7WIeu9EtKAQjMmWT6zfEc+ws5Anw8+4FjoF88X9JufquZsLUIZzYRO9Q7FLy1UbzGfrp8d0xx2ODS0RRJaLxyK2igihGx434BnDm9U7SnjvtmqWwhptRRx+r1Wl4kOe1roVoFio9y7AJ1Td4H8x5R/LdMWiGNZVljmhhNf2hFPqzgORqrhMlXTPdmqoKvEuZ9itiwtK2iZ2lEEv1C/ycY4YZNK7Hv8ZAErHKD+HBkCKxu0yQrCp7MSvR6C0KRcA/E1F0wC3u3/Wk3uUs9W9HhCfsklmCgXTmTzJxXnLpkltlaAoRWfaLe/4d1vggTDUcuK3Ly0ilVR60LjsyyZuZaWI4z1hfrR/mzGapyn9Tk2Yx1hBL7XdAQERVwZMKWkqp7K0HhNqRwFOQioP+tfs2/rN0L5krsomzWsnwqiYlH8pB+LQ9tfVVY/ZN8aobBvZmNusdw+PJFePF7NrMCsreXVTHVZvuNCvhjpKRgvLxxy7sBtCElhlJ2kSyfjiC+fNFq9Scs1Kfd6eeu1wLVbgS8cbxFdb16XMKzlRVCFHbKm0toyj/6Rkdx4l4g2aDfmrdg9WsjQdl/whGTrAC8B+27zSREUnQ0CXsOyXhu1lbCqk1douc53FH9phIEXE4G0O5SeC07aUq3YcnqyUysGzJcGmKmclsF6t5FtpAA3NsEmJKQJWlcTAjjWHcGfp2SxvKuqXhnyRj2eBXejIhBCKCvhObTF5H9vk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(376002)(46966006)(36840700001)(40470700004)(7696005)(356005)(5660300002)(8676002)(40480700001)(8936002)(82310400005)(54906003)(26005)(316002)(81166007)(82740400003)(2906002)(6666004)(6916009)(36860700001)(478600001)(70206006)(47076005)(16526019)(41300700001)(186003)(40460700003)(4326008)(36756003)(2616005)(86362001)(426003)(83380400001)(70586007)(1076003)(336012)(145543001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 14:51:28.7599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f51ba01-c8f3-4a47-69dc-08da5915aee0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0063
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add KFDGpuID to HsaNodeProperties to return gpu_id to upper layer,
gpu_id is hash ID generated by KFD to distinguish GPUs on the system.
ROCr and ROCProfiler will use gpu_id to analyze SMI event message.

Change-Id: I6eabe6849230e04120674f5bc55e6ea254a532d6
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 include/hsakmttypes.h |  4 +++-
 src/fmm.c             |  7 +++----
 src/libhsakmt.h       |  1 -
 src/topology.c        | 26 ++++++++++++--------------
 4 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/include/hsakmttypes.h b/include/hsakmttypes.h
index 9063f85..ab2591b 100644
--- a/include/hsakmttypes.h
+++ b/include/hsakmttypes.h
@@ -328,7 +328,9 @@ typedef struct _HsaNodeProperties
 
     HSAuint32       VGPRSizePerCU;     // VGPR size in bytes per CU
     HSAuint32       SGPRSizePerCU;     // SGPR size in bytes per CU
-    HSAuint8        Reserved[12];
+
+    HSAuint32       KFDGpuID;          // GPU Hash ID generated by KFD
+    HSAuint8        Reserved[8];
 } HsaNodeProperties;
 
 
diff --git a/src/fmm.c b/src/fmm.c
index 35da3b8..92b76e1 100644
--- a/src/fmm.c
+++ b/src/fmm.c
@@ -2170,7 +2170,6 @@ HSAKMT_STATUS fmm_init_process_apertures(unsigned int NumNodes)
 {
 	uint32_t i;
 	int32_t gpu_mem_id = 0;
-	uint32_t gpu_id;
 	HsaNodeProperties props;
 	struct kfd_process_device_apertures *process_apertures;
 	uint32_t num_of_sysfs_nodes;
@@ -2235,14 +2234,14 @@ HSAKMT_STATUS fmm_init_process_apertures(unsigned int NumNodes)
 
 	for (i = 0; i < NumNodes; i++) {
 		memset(&props, 0, sizeof(props));
-		ret = topology_sysfs_get_node_props(i, &props, &gpu_id, NULL, NULL);
+		ret = topology_sysfs_get_node_props(i, &props, NULL, NULL);
 		if (ret != HSAKMT_STATUS_SUCCESS)
 			goto sysfs_parse_failed;
 
 		topology_setup_is_dgpu_param(&props);
 
 		/* Skip non-GPU nodes */
-		if (gpu_id != 0) {
+		if (props.KFDGpuID) {
 			int fd = open_drm_render_device(props.DrmRenderMinor);
 			if (fd <= 0) {
 				ret = HSAKMT_STATUS_ERROR;
@@ -2254,7 +2253,7 @@ HSAKMT_STATUS fmm_init_process_apertures(unsigned int NumNodes)
 			gpu_mem[gpu_mem_count].EngineId.ui32.Stepping = props.EngineId.ui32.Stepping;
 
 			gpu_mem[gpu_mem_count].drm_render_fd = fd;
-			gpu_mem[gpu_mem_count].gpu_id = gpu_id;
+			gpu_mem[gpu_mem_count].gpu_id = props.KFDGpuID;
 			gpu_mem[gpu_mem_count].local_mem_size = props.LocalMemSize;
 			gpu_mem[gpu_mem_count].device_id = props.DeviceId;
 			gpu_mem[gpu_mem_count].node_id = i;
diff --git a/src/libhsakmt.h b/src/libhsakmt.h
index e4246e0..822744b 100644
--- a/src/libhsakmt.h
+++ b/src/libhsakmt.h
@@ -173,7 +173,6 @@ HSAKMT_STATUS validate_nodeid_array(uint32_t **gpu_id_array,
 		uint32_t NumberOfNodes, uint32_t *NodeArray);
 
 HSAKMT_STATUS topology_sysfs_get_node_props(uint32_t node_id, HsaNodeProperties *props,
-					uint32_t *gpu_id,
 					bool *p2p_links, uint32_t *num_p2pLinks);
 HSAKMT_STATUS topology_sysfs_get_system_props(HsaSystemProperties *props);
 void topology_setup_is_dgpu_param(HsaNodeProperties *props);
diff --git a/src/topology.c b/src/topology.c
index 81ff62f..99a6a03 100644
--- a/src/topology.c
+++ b/src/topology.c
@@ -56,7 +56,6 @@
 #define KFD_SYSFS_PATH_NODES "/sys/devices/virtual/kfd/kfd/topology/nodes"
 
 typedef struct {
-	uint32_t gpu_id;
 	HsaNodeProperties node;
 	HsaMemoryProperties *mem;     /* node->NumBanks elements */
 	HsaCacheProperties *cache;
@@ -1037,7 +1036,6 @@ static int topology_get_marketing_name(int minor, uint16_t *marketing_name)
 
 HSAKMT_STATUS topology_sysfs_get_node_props(uint32_t node_id,
 					    HsaNodeProperties *props,
-					    uint32_t *gpu_id,
 					    bool *p2p_links,
 					    uint32_t *num_p2pLinks)
 {
@@ -1056,13 +1054,14 @@ HSAKMT_STATUS topology_sysfs_get_node_props(uint32_t node_id,
 	HSAKMT_STATUS ret = HSAKMT_STATUS_SUCCESS;
 
 	assert(props);
-	assert(gpu_id);
 	ret = topology_sysfs_map_node_id(node_id, &sys_node_id);
 	if (ret != HSAKMT_STATUS_SUCCESS)
 		return ret;
 
 	/* Retrieve the GPU ID */
-	ret = topology_sysfs_get_gpu_id(sys_node_id, gpu_id);
+	ret = topology_sysfs_get_gpu_id(sys_node_id, &props->KFDGpuID);
+	if (ret != HSAKMT_STATUS_SUCCESS)
+		return ret;
 
 	read_buf = malloc(PAGE_SIZE);
 	if (!read_buf)
@@ -1723,7 +1722,7 @@ static int32_t gpu_get_direct_link_cpu(uint32_t gpu_node, node_props_t *node_pro
 	HsaIoLinkProperties *props = node_props[gpu_node].link;
 	uint32_t i;
 
-	if (!node_props[gpu_node].gpu_id || !props ||
+	if (!node_props[gpu_node].node.KFDGpuID || !props ||
 			node_props[gpu_node].node.NumIOLinks == 0)
 		return -1;
 
@@ -1776,7 +1775,7 @@ static HSAKMT_STATUS get_indirect_iolink_info(uint32_t node1, uint32_t node2,
 		return HSAKMT_STATUS_INVALID_PARAMETER;
 
 	/* CPU->CPU is not an indirect link */
-	if (!node_props[node1].gpu_id && !node_props[node2].gpu_id)
+	if (!node_props[node1].node.KFDGpuID && !node_props[node2].node.KFDGpuID)
 		return HSAKMT_STATUS_INVALID_NODE_UNIT;
 
 	if (node_props[node1].node.HiveID &&
@@ -1784,16 +1783,16 @@ static HSAKMT_STATUS get_indirect_iolink_info(uint32_t node1, uint32_t node2,
 	    node_props[node1].node.HiveID == node_props[node2].node.HiveID)
 		return HSAKMT_STATUS_INVALID_PARAMETER;
 
-	if (node_props[node1].gpu_id)
+	if (node_props[node1].node.KFDGpuID)
 		dir_cpu1 = gpu_get_direct_link_cpu(node1, node_props);
-	if (node_props[node2].gpu_id)
+	if (node_props[node2].node.KFDGpuID)
 		dir_cpu2 = gpu_get_direct_link_cpu(node2, node_props);
 
 	if (dir_cpu1 < 0 && dir_cpu2 < 0)
 		return HSAKMT_STATUS_ERROR;
 
 	/* if the node2(dst) is GPU , it need to be large bar for host access*/
-	if (node_props[node2].gpu_id) {
+	if (node_props[node2].node.KFDGpuID) {
 		for (i = 0; i < node_props[node2].node.NumMemoryBanks; ++i)
 			if (node_props[node2].mem[i].HeapType ==
 				HSA_HEAPTYPE_FRAME_BUFFER_PUBLIC)
@@ -1922,7 +1921,6 @@ retry:
 		for (i = 0; i < sys_props.NumNodes; i++) {
 			ret = topology_sysfs_get_node_props(i,
 					&temp_props[i].node,
-					&temp_props[i].gpu_id,
 					&p2p_links, &num_p2pLinks);
 			if (ret != HSAKMT_STATUS_SUCCESS) {
 				free_properties(temp_props, i);
@@ -1963,7 +1961,7 @@ retry:
 						goto err;
 					}
 				}
-			} else if (!temp_props[i].gpu_id) { /* a CPU node */
+			} else if (!temp_props[i].node.KFDGpuID) { /* a CPU node */
 				ret = topology_get_cpu_cache_props(
 						i, cpuinfo, &temp_props[i]);
 				if (ret != HSAKMT_STATUS_SUCCESS) {
@@ -2104,7 +2102,7 @@ HSAKMT_STATUS validate_nodeid(uint32_t nodeid, uint32_t *gpu_id)
 	if (!g_props || !g_system || g_system->NumNodes <= nodeid)
 		return HSAKMT_STATUS_INVALID_NODE_UNIT;
 	if (gpu_id)
-		*gpu_id = g_props[nodeid].gpu_id;
+		*gpu_id = g_props[nodeid].node.KFDGpuID;
 
 	return HSAKMT_STATUS_SUCCESS;
 }
@@ -2114,7 +2112,7 @@ HSAKMT_STATUS gpuid_to_nodeid(uint32_t gpu_id, uint32_t *node_id)
 	uint64_t node_idx;
 
 	for (node_idx = 0; node_idx < g_system->NumNodes; node_idx++) {
-		if (g_props[node_idx].gpu_id == gpu_id) {
+		if (g_props[node_idx].node.KFDGpuID == gpu_id) {
 			*node_id = node_idx;
 			return HSAKMT_STATUS_SUCCESS;
 		}
@@ -2383,7 +2381,7 @@ uint16_t get_device_id_by_gpu_id(HSAuint32 gpu_id)
 		return 0;
 
 	for (i = 0; i < g_system->NumNodes; i++) {
-		if (g_props[i].gpu_id == gpu_id)
+		if (g_props[i].node.KFDGpuID == gpu_id)
 			return g_props[i].node.DeviceId;
 	}
 
-- 
2.35.1

