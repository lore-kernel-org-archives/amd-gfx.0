Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470C0CCA472
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 13:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE2D810E82D;
	Wed,  8 Oct 2025 13:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mTzfF3Hn";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 703C610E816
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 13:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gM8pq2GrTCNW19PHksioGFukdZVjQ9NJm2q7OLxaS1ayf5h50bAfVqQihHUyF2khTN3RPCJIb9rnhR/XnLUZikmNjGP+lheUEHkbjMxzT/fRErVLGV2nZ/wGFpWV5QLoY4ghaGLuZdxi3xdrvVw2BpIA9RTbKSSM5blYvwabRCObmZ3hPBlOLJ0mkiVrLUR7gv1LqrrEFKYEb5HP4miijOz4GP2JmFjywx+4bDnzLbEWBB2yGhEhQzn6bZS6zXdiX8IYcJRt78JG8tOJ9fjREZkatj0OlYbckYIdFK7DSuz7YK0W5YnYk4Rw35MtkTubGRgvfcaW2/4BnDIn11QPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7VfYC3jZjQ1kUKapVMmhPdoPu6pjY07EOo0Br4I+X0=;
 b=V8hCYBszAoQHlZqTtWL+CDhtzRnqYGRQV+ZY5thXHZSTT2irkvWEa3tFiYMeQ2nA6IK/PlwWWJvniOy5IaPLDi0DbuWZqrnzrHOwO2KK6N+w7SgHhnbOzGbqqJulkqBec5ssyj47axfbNDRvpr6VjLhgI6mlmnTjkB3EtulMQ2+PxHjRlF29IP6x1wJS4TFIdhHMOgAzmaLNMesghjkxuW5wgzIq/g+NeTv3tD3A0PybnfxxiKKw/JY1r+0c/DEHVS9+pF9kq59m9L4MEzoRs8xQBX4R95OWvlwucNs6MnT7z9SyGD7/8WjMfeew+usrAo4cvwqlLBPVXq8IC/IJTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7VfYC3jZjQ1kUKapVMmhPdoPu6pjY07EOo0Br4I+X0=;
 b=mTzfF3HnlsMn0RGAqwOS48grnEbDs8GgqOxOICCON34Nah/wB4XzsG3uV+yJclb3JfiblOYZ4/dhZtm43Ush6cgvLDAfPgMiyV5ZVvkFp4Eyn5Q6tyCASxgOAYbrFDcde/gUBJDHIFPnaE3DbXTfYuii11HccqyL00/S1TdEPCo=
Received: from CH0PR03CA0401.namprd03.prod.outlook.com (2603:10b6:610:11b::35)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 13:33:13 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::6b) by CH0PR03CA0401.outlook.office365.com
 (2603:10b6:610:11b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 13:33:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 13:33:13 +0000
Received: from smc-sc-di15-34.dh144.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Oct 2025 06:33:12 -0700
From: <will.aitken@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.skvortsov@amd.com>, <lijo.lazar@amd.com>, Will Aitken
 <wiaitken@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Refactor sriov xgmi topology filling to
 common code
Date: Wed, 8 Oct 2025 13:32:23 +0000
Message-ID: <20251008133225.1238028-1-will.aitken@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c33704-b874-4b35-2235-08de066f3af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hr5FAC4f1BZcq8CjJ2l90Y0j1Hvhnb9hqkujV3t702ZyiJlPlmTRpePxM9lX?=
 =?us-ascii?Q?IDDUMnk+DQ2qDMH80rVr2mGRWXB9omxwRPUbCxYnkiBZLCHm6lfeDVNAw6X7?=
 =?us-ascii?Q?uuwjoDhc8XyV2/L9cHSaIRFfG7yDv318U9jPqWV9jN+w+ZyeK0d9gW70dIqo?=
 =?us-ascii?Q?9G5kq1jwIG3Q2Z/BDM9BqrFrkl56rDK7w5gTtlndN/+kwQPS0FV+0CWo+TC1?=
 =?us-ascii?Q?wg8uuYeBJYefeIHIS/UoIKNHOyHBTSj2OpeYBm1mh8gbTgFxisNUkmb5C8M3?=
 =?us-ascii?Q?mjmSKXYQ0xolJeBmNe7AN5r5z30OOa+Pn9yXgAaaVKsKv/g9u2mcuflIsKXh?=
 =?us-ascii?Q?CZ2IxWcqvP0aKBJ+UN1wJrEEGQWH3Vv955zi7S6RYndAwgz1WWkw7K6rU/Ph?=
 =?us-ascii?Q?OaR8xGlCNtOTGIbZACn9gJFkd7jDSCvLJ6M1XG17JieSWKawm6r7GunEtn8D?=
 =?us-ascii?Q?KZMzDEpg7SskqZDRn2hTJrEcVt0BXVETrq6rHOOAokTwKPPD37GNmFpl8yUu?=
 =?us-ascii?Q?YMXxjU6fkY0CpvdCPSUxICd7kG2r97ReDck0dlWqofGR27RHISU3/GEwWJVP?=
 =?us-ascii?Q?8J8tFkxJKCh92AVr7SHQh00QL0ErrRhrBuv3xN5LXPfzFccIawqFkvnhWHkZ?=
 =?us-ascii?Q?nbP7EZRhyUL/ZM6ltSrDxmcNhNFUFKuxYagBp8Hxq5QXrvssQXoGDMIDrEzA?=
 =?us-ascii?Q?gwEAv5MeziTjv/AGIh/JpKchA0ceJqcyHI5aMTHbGbPXqBqLQkjGqpvMhxdi?=
 =?us-ascii?Q?+uraHe4JOiY/sXSSIFv714bdnwwV+jy/xNdmXO9GXBkstv6xvzWaeRqBihqi?=
 =?us-ascii?Q?kpqyKmxEE1tmRGVnyxuBYkStkCJRL/WEHG8VvVmQ9RrxBiTcy0auZUaoV6Ny?=
 =?us-ascii?Q?Dq2E3ISEGl4nZaHU3/bKnb5UuWxc2shD5DL9HtT7UTcbzRJVPvzbCiXlxntK?=
 =?us-ascii?Q?Kr+wAOBQaEEDzWg3dTgPfiiGofCTHGLvmfCKGa3rVu0oW4kmR7ne2GlliUHe?=
 =?us-ascii?Q?kv8b0pKwLBWPVwwqU/EJzvdh76mGmI0MdJydiOqLmPc2EBBqoT3/v6hOhlnY?=
 =?us-ascii?Q?K12GFUxNz2fyuUvLg5ijDY993cS3SL+yu1qn0HUN1Iy4vj9KSHD+Dk5/pGcG?=
 =?us-ascii?Q?wGvosZV8nLL4IuPwoaeEbbepSI7U19qnMFDifiBNZidboLN4i80gdntfInPC?=
 =?us-ascii?Q?MY/yLmNQrm7TsD5B6L0wDF5PfU25VTpaiBNI1q6/WXobtNn+A8pmudG00xyI?=
 =?us-ascii?Q?Vslsp0yAucsAf4eL9yb72ttT2EAHFVT7zGM1RNm4OT/ITnyNV+toE4MWFfbb?=
 =?us-ascii?Q?9/YN7hVr0lewAXvM6vuqR4k+353U/aA9airYq18P+GSpKlXBZMKFUK801+qD?=
 =?us-ascii?Q?0+LTCJUDKIof7SEe73XgXW0EhsAqX2dYIkDF76jfu5pL3MsiQnRb54B6pyfg?=
 =?us-ascii?Q?MOJ+LF2tusuwatPlL2yV+7eIx9Kj1ThVFg62zfBCMeTrDxzh0fLaHIGSt7Ss?=
 =?us-ascii?Q?lpsn41eYpqX2/TMIqMahaNH+CPyUNAAQJ7yHZR/pOvrMeplP+Ac1OVdJxjsL?=
 =?us-ascii?Q?nL4KeBYeyFN4DOAvngk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 13:33:13.2808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c33704-b874-4b35-2235-08de066f3af3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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

From: Will Aitken <wiaitken@amd.com>

amdgpu_xgmi_fill_topology_info and psp_xgmi_reflect_topology_info
perform the same logic of copying topology info of one node to every
other node in the hive. Instead of having two functions that purport to
do the same thing, this refactoring moves the logic of the fill function
to the reflect function and adds reflecting port number info as well for
complete functionality.

Signed-off-by: Will Aitken <wiaitken@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 19 ++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 27 ------------------------
 2 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6208a49c9f23..82500ade240d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1539,6 +1539,7 @@ static void psp_xgmi_reflect_topology_info(struct psp_context *psp,
 	uint64_t src_node_id = psp->adev->gmc.xgmi.node_id;
 	uint64_t dst_node_id = node_info.node_id;
 	uint8_t dst_num_hops = node_info.num_hops;
+	uint8_t dst_is_sharing_enabled = node_info.is_sharing_enabled;
 	uint8_t dst_num_links = node_info.num_links;
 
 	hive = amdgpu_get_xgmi_hive(psp->adev);
@@ -1558,13 +1559,20 @@ static void psp_xgmi_reflect_topology_info(struct psp_context *psp,
 				continue;
 
 			mirror_top_info->nodes[j].num_hops = dst_num_hops;
-			/*
-			 * prevent 0 num_links value re-reflection since reflection
+			mirror_top_info->nodes[j].is_sharing_enabled = dst_is_sharing_enabled;
+			/* prevent 0 num_links value re-reflection since reflection
 			 * criteria is based on num_hops (direct or indirect).
-			 *
 			 */
-			if (dst_num_links)
+			if (dst_num_links) {
 				mirror_top_info->nodes[j].num_links = dst_num_links;
+				/* swap src and dst due to frame of reference */
+				for (int k = 0; k < dst_num_links; k++) {
+					mirror_top_info->nodes[j].port_num[k].src_xgmi_port_num =
+						node_info.port_num[k].dst_xgmi_port_num;
+					mirror_top_info->nodes[j].port_num[k].dst_xgmi_port_num =
+						node_info.port_num[k].src_xgmi_port_num;
+				}
+			}
 
 			break;
 		}
@@ -1639,7 +1647,8 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 			amdgpu_ip_version(psp->adev, MP0_HWIP, 0) ==
 				IP_VERSION(13, 0, 6) ||
 			amdgpu_ip_version(psp->adev, MP0_HWIP, 0) ==
-				IP_VERSION(13, 0, 14);
+				IP_VERSION(13, 0, 14) ||
+			amdgpu_sriov_vf(psp->adev);
 		bool ta_port_num_support = amdgpu_sriov_vf(psp->adev) ? 0 :
 				psp->xgmi_context.xgmi_ta_caps & EXTEND_PEER_LINK_INFO_CMD_FLAG;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 1ede308a7c67..2e70b84a8c3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -958,28 +958,6 @@ static int amdgpu_xgmi_initialize_hive_get_data_partition(struct amdgpu_hive_inf
 	return 0;
 }
 
-static void amdgpu_xgmi_fill_topology_info(struct amdgpu_device *adev,
-	struct amdgpu_device *peer_adev)
-{
-	struct psp_xgmi_topology_info *top_info = &adev->psp.xgmi_context.top_info;
-	struct psp_xgmi_topology_info *peer_info = &peer_adev->psp.xgmi_context.top_info;
-
-	for (int i = 0; i < peer_info->num_nodes; i++) {
-		if (peer_info->nodes[i].node_id == adev->gmc.xgmi.node_id) {
-			for (int j = 0; j < top_info->num_nodes; j++) {
-				if (top_info->nodes[j].node_id == peer_adev->gmc.xgmi.node_id) {
-					peer_info->nodes[i].num_hops = top_info->nodes[j].num_hops;
-					peer_info->nodes[i].is_sharing_enabled =
-							top_info->nodes[j].is_sharing_enabled;
-					peer_info->nodes[i].num_links =
-							top_info->nodes[j].num_links;
-					return;
-				}
-			}
-		}
-	}
-}
-
 int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 {
 	struct psp_xgmi_topology_info *top_info;
@@ -1065,11 +1043,6 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 				/* To do: continue with some node failed or disable the whole hive*/
 				goto exit_unlock;
 			}
-
-			/* fill the topology info for peers instead of getting from PSP */
-			list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
-				amdgpu_xgmi_fill_topology_info(adev, tmp_adev);
-			}
 		} else {
 			/* get latest topology info for each device from psp */
 			list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
-- 
2.43.0

