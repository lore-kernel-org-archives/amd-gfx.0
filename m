Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A415DC02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 15:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D5CC10E8FC;
	Wed, 12 Feb 2025 15:57:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K8Apq9Rv";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DE8B10E8FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 15:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OL+31B2CAbhCiH5vDjDHGLdyxz0rNojL47hcL3PYbNosyBIJa9dvOSRaPF9+bTZoU+6yawKPZYAXmGKKztPwmFLvnXW/EUMyU7UV4fOqZ2yBYHFmBR0wLLq/p3kuRWkwn0wmPKWs8YeYhkch5YfMeN9QIGrP3Er9qQg/Di+yBhXMeYA+uhhKrMF78PGTts/pwOzbIO99onnD332gE+KtT5jQjJ+N7R9j2Bhgaq80rxbmIOLWsA/dGWqrBERIReaNi9uBJqxg/4xMZSJ1B4idEXlFkaKUZztARY9Hng3j/6in8rjTc9D8MHbTmzt5XjPyV+FseXRW4qfHuCN05goLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxmRwDJiqMKP5RvnZZapK78ahmOM0Lspn3t2/bHZnXI=;
 b=BNPX511xfkcInMUHmQFckRpEbHXb0+NISpkfIajSa6SrWUK3GsQp2S0CJ+48JUdqryOHbiIAznFFyqhCnCLJHoAgF0U7frnvO/zqONaZ7eZktI1q6f0C3TF399d6KrrqI5/EHJKCIDdIEImZzZbmiTzA0hKv43VHx4qlGss3YErExapDn7HhB2CMWFJpAtnZP+Z1RpOFVyDNne+U4KCJpfjLStxqCvgCqTaJNNgyPP2wTAzGLoZGb7Gt8tYpM+9uAx54omE4mh7uGK9Gfd/drpC/spO7VDvzJ9hEb9VtjUAfOsk22MfiyV2O/2lxUhAwv6OCrU3o5oH+9+Ap/EEaeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxmRwDJiqMKP5RvnZZapK78ahmOM0Lspn3t2/bHZnXI=;
 b=K8Apq9RvbXx/CWxfk+0ZepPMNw9siiiNfA/VnLSDLNxSCzfqVXO2ksWhPsoySPSPwUy1IIeDDa+Zv6hhBufDaIbDzbKQpp0M2ptJddk8LkudRkd8DR5KLPePT0Uub9wklU9FxlIf84hTrwVbP4LTGc62//4zC2ohTQjOHrt4UMc=
Received: from DS7PR07CA0023.namprd07.prod.outlook.com (2603:10b6:5:3af::28)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 15:57:42 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::b7) by DS7PR07CA0023.outlook.office365.com
 (2603:10b6:5:3af::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 15:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 15:57:42 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 09:57:41 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdgpu: simplify xgmi peer info calls
Date: Wed, 12 Feb 2025 10:57:34 -0500
Message-ID: <20250212155734.2213096-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ae4f8b-4a6b-4718-7143-08dd4b7dfbbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gF5ITDFwAydt7vOVnrkwTT/C6GdkcFRpCY92UZVfGqpF0EbdANmyyMPb6Qv4?=
 =?us-ascii?Q?TqFxbr+JL8CR/w/49SnIp2h6WOWZFkyinwyAf4N0Uv0kLRf0ySBnI926l4Lc?=
 =?us-ascii?Q?obo5DNlJgvGCNrec8Fp7SW08eMptYa4RwkCCOXlLUz9LR/x81BbUwsd/b0n6?=
 =?us-ascii?Q?JqUS0y3F4gZUP1xcwx/m7rAikXAG48SiAccLsw1qX5hE0NV1J+8xeIgRXAc9?=
 =?us-ascii?Q?7Jz0jpMwrxn3VmtHsRp9AMhDunoUgxVsyRVpiIZ7qXnLBBUITKHh9mAlaVUQ?=
 =?us-ascii?Q?y30WO8CCYq7AxGJS5keS1kYGUO4P3TXUkxYOoxjPuQgySQxXNSLhhVRyk4tg?=
 =?us-ascii?Q?VUHn6EzT833GnB4VhbcT+w8zw1h2h+1Lqou0hnyvmnLhW+nBWWIVAkIQC/Pu?=
 =?us-ascii?Q?7a5F6ivPLk+E1bbvQoSl03VTHyIx34CjsKQCXZDRGkbFI7RpgC0k1e4u4ZuZ?=
 =?us-ascii?Q?u7baXExJTK6682Gny5XkrzniaDe89uqEcnLs+bUawwnrcZ/bpuv19TBEuOVz?=
 =?us-ascii?Q?gV9DyIPEe8fUFnsnx8PdoLtBTgsZhOjkdZsiF3bGiBGqVMbuiIZk6wn9L93e?=
 =?us-ascii?Q?kPiUp2+o271xnmPj22kF0Qwc60wOdrc/NnTI1ET38vWdpQhnokNgxmD59Gda?=
 =?us-ascii?Q?q/0yX0Ss7DjD7cp06M/UTnVDXOsphvKpoYYqJPES3PMIFiGjj+ZNRvnEPeq4?=
 =?us-ascii?Q?U/lxSW79Fj5qB2KhVkYqhSXuCIQAkXhgBer69XJAXAHFiwnYW7n3iE8R9Lcz?=
 =?us-ascii?Q?bWFxpZTYtlx6MFAvBX/9d6Y8B8cQ5c4L+DxCtRxjVXBdBUn8/eqVlStgpS/c?=
 =?us-ascii?Q?k1vPiycknznTqXUDo8MDcCEw30urrSwcmShp3gSxlbcR8+vQvILXMCUdBCH/?=
 =?us-ascii?Q?Wz670Hw2k87iXmnFahvbYWCRvdZJwjFRbERGoEe/y7qj//iDEgDTYJg5AZ4r?=
 =?us-ascii?Q?17yj+Oqi5ghN+PxaemcIoItl+v4EH/h1CnmNGiF8R1W15/IqhyF8Zs4KxndP?=
 =?us-ascii?Q?fwRjJlmvQHUX1Tiv0YvDdFIJI+jYKvYM3ss9vPJRpc+FEplWAYqArkwrayLe?=
 =?us-ascii?Q?7KEMvFA7NnBElT9xvQ8GAjw7rWJYj0ogvMUrpEm0SHe4v3bGeKPyPnyFq6LA?=
 =?us-ascii?Q?XXms3IKgegJjzY0le+PL8pUxvpgjLC3r0qIwqs49thbSvOkPMZkmqprD9oMf?=
 =?us-ascii?Q?7jw0Pr5ryWmMXoh7C1leZtTUj7YimVrm3G4T9hqzo5JoNw2nqLT71iEB/xLP?=
 =?us-ascii?Q?qQ0Hl/Jo4H9XKFCn5JBPXnPtnprnX4EMzZzOFAo2pF96sdSNZHirccY0+vwn?=
 =?us-ascii?Q?Fs1ELVPgsmHwlDAxjeLHOHmJUf8abmMXpCoHvDUmjFhzcg5LxdZCUYvJ0sRA?=
 =?us-ascii?Q?e0L50qnzn3L4MgqUm+3szfz503iTgUBYhjqt1S3DW4x4ke+tcrUopTm7Hhbc?=
 =?us-ascii?Q?bGpg7B3mU4f5tE9cK7c58nPj4hZUldfbfJPv7Rwd1aITzyumzvEmbnEakJjx?=
 =?us-ascii?Q?YQEhWSc8qIEwl+k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 15:57:42.1382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ae4f8b-4a6b-4718-7143-08dd4b7dfbbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352
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

Deprecate KFD XGMI peer info calls in favour of calling directly from
simplified XGMI peer info functions.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 42 ------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  5 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 51 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  6 +--
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c      | 11 +++--
 5 files changed, 48 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 0312231b703e..4cec3a873995 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -555,48 +555,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 	return r;
 }
 
-uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
-					  struct amdgpu_device *src)
-{
-	struct amdgpu_device *peer_adev = src;
-	struct amdgpu_device *adev = dst;
-	int ret = amdgpu_xgmi_get_hops_count(adev, peer_adev);
-
-	if (ret < 0) {
-		DRM_ERROR("amdgpu: failed to get  xgmi hops count between node %d and %d. ret = %d\n",
-			adev->gmc.xgmi.physical_node_id,
-			peer_adev->gmc.xgmi.physical_node_id, ret);
-		ret = 0;
-	}
-	return  (uint8_t)ret;
-}
-
-int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
-					    struct amdgpu_device *src,
-					    bool is_min)
-{
-	struct amdgpu_device *adev = dst, *peer_adev;
-	int num_links;
-
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2))
-		return 0;
-
-	if (src)
-		peer_adev = src;
-
-	/* num links returns 0 for indirect peers since indirect route is unknown. */
-	num_links = is_min ? 1 : amdgpu_xgmi_get_num_links(adev, peer_adev);
-	if (num_links < 0) {
-		DRM_ERROR("amdgpu: failed to get xgmi num links between node %d and %d. ret = %d\n",
-			adev->gmc.xgmi.physical_node_id,
-			peer_adev->gmc.xgmi.physical_node_id, num_links);
-		num_links = 0;
-	}
-
-	/* Aldebaran xGMI DPM is defeatured so assume x16 x 25Gbps for bandwidth. */
-	return (num_links * 16 * 25000)/BITS_PER_BYTE;
-}
-
 int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min)
 {
 	int num_lanes_shift = (is_min ? ffs(adev->pm.pcie_mlw_mask) :
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 092dbd8bec97..28eb1cd0eb5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -255,11 +255,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 				  uint64_t *bo_size, void *metadata_buffer,
 				  size_t buffer_size, uint32_t *metadata_size,
 				  uint32_t *flags, int8_t *xcp_id);
-uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
-					  struct amdgpu_device *src);
-int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
-					    struct amdgpu_device *src,
-					    bool is_min);
 int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min);
 int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
 					uint32_t *payload);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 74b4349e345a..d18d2a26cc91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -818,28 +818,59 @@ int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_dev
  * num_hops[2:0] = number of hops
  */
 int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
-		struct amdgpu_device *peer_adev)
+			       struct amdgpu_device *peer_adev)
 {
 	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
 	uint8_t num_hops_mask = 0x7;
 	int i;
 
+	if (!adev->gmc.xgmi.supported)
+		return 0;
+
 	for (i = 0 ; i < top->num_nodes; ++i)
 		if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
 			return top->nodes[i].num_hops & num_hops_mask;
-	return	-EINVAL;
+
+	DRM_ERROR("amdgpu: failed to get  xgmi hops count between node %d and %d.\n",
+		  adev->gmc.xgmi.physical_node_id,
+		  peer_adev->gmc.xgmi.physical_node_id);
+
+	return 0;
 }
 
-int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
-		struct amdgpu_device *peer_adev)
+int amdgpu_xgmi_get_bandwidth_mbytes(struct amdgpu_device *adev,
+				     struct amdgpu_device *peer_adev)
 {
-	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
-	int i;
+	int num_links = !peer_adev ? 1 : 0;
 
-	for (i = 0 ; i < top->num_nodes; ++i)
-		if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
-			return top->nodes[i].num_links;
-	return	-EINVAL;
+	if (!adev->gmc.xgmi.supported)
+		return 0;
+
+	if (peer_adev) {
+		struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
+		int i;
+
+		for (i = 0 ; i < top->num_nodes; ++i) {
+			if (top->nodes[i].node_id != peer_adev->gmc.xgmi.node_id)
+				continue;
+
+			num_links =  top->nodes[i].num_links;
+			break;
+		}
+	}
+
+	/* num links returns 0 for indirect peers since indirect route is unknown. */
+	if (!num_links) {
+		DRM_ERROR("amdgpu: failed to get xgmi num links between node %d and %d.\n",
+			  adev->gmc.xgmi.physical_node_id,
+			  peer_adev->gmc.xgmi.physical_node_id);
+	}
+
+	/*
+	 * TBD - will update IP based bandwidth later.
+	 * Bandwidth currently assumed to be x16 lanes x 25Gbps.
+	 */
+	return (num_links * 16 * 25000)/BITS_PER_BYTE;
 }
 
 bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index d1282b4c6348..325e7972469d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -62,10 +62,8 @@ int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_dev
 int amdgpu_xgmi_add_device(struct amdgpu_device *adev);
 int amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
 int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);
-int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
-		struct amdgpu_device *peer_adev);
-int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
-		struct amdgpu_device *peer_adev);
+int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev, struct amdgpu_device *peer_adev);
+int amdgpu_xgmi_get_bandwidth_mbytes(struct amdgpu_device *adev, struct amdgpu_device *peer_adev);
 bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
 					struct amdgpu_device *peer_adev);
 uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 70b3ae0b74fe..a787d192390c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2133,8 +2133,8 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 		bool ext_cpu = KFD_GC_VERSION(kdev) != IP_VERSION(9, 4, 3);
 		int mem_bw = 819200, weight = ext_cpu ? KFD_CRAT_XGMI_WEIGHT :
 							KFD_CRAT_INTRA_SOCKET_WEIGHT;
-		uint32_t bandwidth = ext_cpu ? amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
-							kdev->adev, NULL, true) : mem_bw;
+		uint32_t bandwidth = ext_cpu ? amdgpu_xgmi_get_bandwidth_mbytes(kdev->adev, NULL) :
+					       mem_bw;
 
 		/*
 		 * with host gpu xgmi link, host can access gpu memory whether
@@ -2198,12 +2198,11 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int *avail_size,
 
 	if (use_ta_info) {
 		sub_type_hdr->weight_xgmi = KFD_CRAT_XGMI_WEIGHT *
-			amdgpu_amdkfd_get_xgmi_hops_count(kdev->adev, peer_kdev->adev);
+			amdgpu_xgmi_get_hops_count(kdev->adev, peer_kdev->adev);
 		sub_type_hdr->maximum_bandwidth_mbs =
-			amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev,
-							peer_kdev->adev, false);
+			amdgpu_xgmi_get_bandwidth_mbytes(kdev->adev, peer_kdev->adev);
 		sub_type_hdr->minimum_bandwidth_mbs = sub_type_hdr->maximum_bandwidth_mbs ?
-			amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev, NULL, true) : 0;
+			amdgpu_xgmi_get_bandwidth_mbytes(kdev->adev, NULL) : 0;
 	} else {
 		bool is_single_hop = kdev->kfd == peer_kdev->kfd;
 		int weight = is_single_hop ? KFD_CRAT_INTRA_SOCKET_WEIGHT :
-- 
2.34.1

