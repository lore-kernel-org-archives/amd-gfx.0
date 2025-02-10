Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCF8C021A1
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 07:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D31BD10E4A8;
	Mon, 10 Feb 2025 07:00:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bIT185K8";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9734210E4A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 07:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYrNjO8LEqZCQkz9TDBjoQLI9Gfbjd/8t5SSdw3y0ikBylmL7DK9XmlSBiEwt6lXQXA1IebrppQUYX/FhKhIryfCtrIsoltySp5dF6c9knSLah/qCD+9+wcS6ayN4zuNlEh3NskwCAMqk+pvC5+rdS4wh8fXCkKDy5Lbo32QIujKwk/d25xucNojj+i7bSRxl/DxZSJcT5nKaSoWllgSOW69QaVIBEwco38stHHQkVdASTBkWkNgjNqaw0Zzknn0P6aixbaaNnN5TmVNkTObO30MdRWLzC9KVex5GKtTcJFaZJmb/4y5zt9cSo7CoxsHXbhCwXHvdepz9giNGIjBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F36jJ0UhQSNCvlq2DB+1CZDNdUaVXL5Yua5Nouq/ESs=;
 b=MZlW8TmnU+RWbUY0lrIP13amihnimSGvMav6NymzglLuSUALK5x0IxDfEzcrdCJffn2fv0eQpkJK/hi3UhK/61PwANwliHZnNWwZX32yFAIR8ri29gwQokaZmtYEVq7h/uKFovVYHCcx50ppbFSFe2rgteGh4Av/wlIZkM/Jf0leUsL8sXbFl+FrdbE0ifHB1g/TlO7rXcX4DgArTUVEpYTO+iQluSgX11ePPqlJODn3Wd14TSuiRCl/NH2ivhMqk8grSThXhW7u81Ri4wB0YoTVuzgePlJtgXjGJOGTJDl4aKBZ+TbfxX1TVFc4yhTNNo2LyXmnoKedxUo2gfMICQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F36jJ0UhQSNCvlq2DB+1CZDNdUaVXL5Yua5Nouq/ESs=;
 b=bIT185K8sBnnGxTf/zMaUGm4ZPSGsu4YqfZGYL//CahxllRFpiEN4wbJ6o0/GJqi/3WnchsYlRLMksknJ4YMyQE/asCbKlaTJIgE//oYLte+fNj2/16LQ0mYCHyylwBsmVG/Y8z5rj96T+MuPVX0XRGVqEeRwCmCJOor8m+Ji+s=
Received: from BN8PR04CA0023.namprd04.prod.outlook.com (2603:10b6:408:70::36)
 by LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.13; Mon, 10 Feb
 2025 07:00:53 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::7) by BN8PR04CA0023.outlook.office365.com
 (2603:10b6:408:70::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 07:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 07:00:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 01:00:49 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Jonathan.Kim@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: Move xgmi definitions to xgmi header
Date: Mon, 10 Feb 2025 12:30:31 +0530
Message-ID: <20250210070034.1998011-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: a122d5b6-577c-47ab-30bc-08dd49a0a872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jag6Dba/tWB0Xa9VboVD95V7W4n/AUdP49tQcIrHTA3xrjIK3i9C5GjWG4hj?=
 =?us-ascii?Q?TnGeUtjDWy9ffMmwmYvptL0Ku+KZm7z84LAimR+xm2SmIG3Kd7DTbTaSux9R?=
 =?us-ascii?Q?Eepax9w941Ks/xpBNRk/9OIMqo6UhqZU3jQrE+oLG2UTe/rBzwfpYAinBTIs?=
 =?us-ascii?Q?m39vVWj8yjypqvdwVBKh1UMhHf+k2Vjrdbxh45Z6o+Tphw7qbfJggwixB+vf?=
 =?us-ascii?Q?CFlsSzbUJlJlXUu8mqsHJgX02ddx2FEruJZn6dd+hwATB/QYhQPys215RfNL?=
 =?us-ascii?Q?cOjo69k+wggJZTsdSakF1vioLyvXIgHclz291Zahr6D26YRn9fYvLlYPD3CT?=
 =?us-ascii?Q?XW8oCHwyOxFCn7vTWoL9PA7j0XLrsgBHBJxZbW3V+4h1IPAJGKBV0AU5Jnvc?=
 =?us-ascii?Q?F+dTsrZqLURyUhGl7DoiPy3QcTuIEuzZiSOviMk1gp4QYfufsXP0S4RtFHOi?=
 =?us-ascii?Q?bcynGWbPqJhXfBpRVtOTvwO3ifG1jHfH6wybIG6waXoguoKgSvologvrPdKt?=
 =?us-ascii?Q?SXRXI4Zc2tdfylP0ZKmOtENi4ve09Wm8GqE4SbYtIDdfAWfKJcbefU6tXIe7?=
 =?us-ascii?Q?kaiJxZ6/yPbcRPxWuOKra+MgH9BtGrVBkgCzNC79Pcs6jdq6C10UKauKHTxQ?=
 =?us-ascii?Q?Q3ACOHd6H5UllWPYyBdc61qHH7wDoQHwDcocebg+rAFOzovsyRZzmpLj8OuB?=
 =?us-ascii?Q?O4e7W1/0kwZ9TrY3HpGvZO9L3ROEEEYXU0achxFOijhw+ORW2BPyH0u2tG9b?=
 =?us-ascii?Q?asAoKCK/fSSrNINrT5vbKNiyRYSiI8ptw7aRJ7wMNy984WCd0TZgv5pFU8ta?=
 =?us-ascii?Q?Cvc1mEFMv3uoa/exGnNyyHPDIDgQtADQHpbJ1qoM3pbx5uxwvHws7utCnvaT?=
 =?us-ascii?Q?4XSjgyLd7g9U56mqkP+YA9kh3Uh3nulZ7WP0F5/+6LCN2ghVFnmUBvoVQS3u?=
 =?us-ascii?Q?cxUQoniiiUvvKEHlZoQlgargs2S1+m1tN2Njdka7jtqW0p3mZI0+iS5dvxPq?=
 =?us-ascii?Q?J9yQPi21N8ETeDIbK8UG5gXBRHWT6UiYLL2qI46ef6iqVFu87KSg2i+PgkHW?=
 =?us-ascii?Q?SYEBr8X4angbJG/wmXOtssec+5uB87MaSHjUO5wnydU8o9VZqxgq13l2IomB?=
 =?us-ascii?Q?IESxEtqT/vg/FqYAls4sPPoYBLc6+blNijgbcbfO1oVSV6VsR4HrFnus5tbg?=
 =?us-ascii?Q?bZSfIqxbdrWHKZgSJ0aXjuQBMEa9bLao7kV3/iky6e9XHW4MJA7K8KkVVrbr?=
 =?us-ascii?Q?LEpuZWdd97xDvICKalQkcfjTaVTVzq3G/GCB5Xm00kO4nGnfyoYP85qYnHAP?=
 =?us-ascii?Q?xs0XG5oicju9oxk13DnnoJaNQCMvhDA+E0QUbAOrlVDBpVpgqAR8brANeeuZ?=
 =?us-ascii?Q?lma7qi5IUVAltDYEvSblKGl4aiPEpibVxc6AeoSeWN0G5Jk+IuNIP3AXSNk7?=
 =?us-ascii?Q?qzLKN7srhGUAvf/LsWAPU2+CR5RrMOsyTnQArA2hmpYR50iGS/5vpA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 07:00:52.5348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a122d5b6-577c-47ab-30bc-08dd49a0a872
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451
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

Move definitions related to xgmi to amdgpu_xgmi header

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  | 23 +---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c |  8 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h | 35 +++++++++++++++++-------
 3 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 459a30fe239f..bd7fc123b8f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -29,6 +29,7 @@
 #include <linux/types.h>
 
 #include "amdgpu_irq.h"
+#include "amdgpu_xgmi.h"
 #include "amdgpu_ras.h"
 
 /* VA hole for 48bit addresses on Vega10 */
@@ -174,28 +175,6 @@ struct amdgpu_gmc_funcs {
 	bool (*need_reset_on_init)(struct amdgpu_device *adev);
 };
 
-struct amdgpu_xgmi_ras {
-	struct amdgpu_ras_block_object ras_block;
-};
-
-struct amdgpu_xgmi {
-	/* from psp */
-	u64 node_id;
-	u64 hive_id;
-	/* fixed per family */
-	u64 node_segment_size;
-	/* physical node (0-3) */
-	unsigned physical_node_id;
-	/* number of nodes (0-4) */
-	unsigned num_physical_nodes;
-	/* gpu list in the same hive */
-	struct list_head head;
-	bool supported;
-	struct ras_common_if *ras_if;
-	bool connected_to_cpu;
-	struct amdgpu_xgmi_ras *ras;
-};
-
 struct amdgpu_mem_partition_info {
 	union {
 		struct {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 74b4349e345a..03d909c7b14b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1671,3 +1671,11 @@ int amdgpu_xgmi_request_nps_change(struct amdgpu_device *adev,
 
 	return r;
 }
+
+bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
+			   struct amdgpu_device *bo_adev)
+{
+	return (amdgpu_use_xgmi_p2p && adev != bo_adev &&
+		adev->gmc.xgmi.hive_id &&
+		adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index d1282b4c6348..044c4f6be44a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -23,7 +23,6 @@
 #define __AMDGPU_XGMI_H__
 
 #include <drm/task_barrier.h>
-#include "amdgpu_psp.h"
 #include "amdgpu_ras.h"
 
 struct amdgpu_hive_info {
@@ -55,7 +54,29 @@ struct amdgpu_pcs_ras_field {
 	uint32_t pcs_err_shift;
 };
 
-extern struct amdgpu_xgmi_ras  xgmi_ras;
+struct amdgpu_xgmi_ras {
+	struct amdgpu_ras_block_object ras_block;
+};
+extern struct amdgpu_xgmi_ras xgmi_ras;
+
+struct amdgpu_xgmi {
+	/* from psp */
+	u64 node_id;
+	u64 hive_id;
+	/* fixed per family */
+	u64 node_segment_size;
+	/* physical node (0-3) */
+	unsigned physical_node_id;
+	/* number of nodes (0-4) */
+	unsigned num_physical_nodes;
+	/* gpu list in the same hive */
+	struct list_head head;
+	bool supported;
+	struct ras_common_if *ras_if;
+	bool connected_to_cpu;
+	struct amdgpu_xgmi_ras *ras;
+};
+
 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev);
 void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive);
 int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_device *adev);
@@ -70,14 +91,8 @@ bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
 					struct amdgpu_device *peer_adev);
 uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
 					   uint64_t addr);
-static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
-		struct amdgpu_device *bo_adev)
-{
-	return (amdgpu_use_xgmi_p2p &&
-		adev != bo_adev &&
-		adev->gmc.xgmi.hive_id &&
-		adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
-}
+bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
+			   struct amdgpu_device *bo_adev);
 int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_xgmi_reset_on_init(struct amdgpu_device *adev);
 
-- 
2.25.1

