Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F4DD2A52E
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 15:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 474FB10E73E;
	Wed, 16 Oct 2024 15:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XBN3qrAw";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0265210E050
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 15:58:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZcptj9oZNz0dAjwPSSiOlin+WySP2S/pAupLqyWkP7HMUXVMJ2Oc94VKPHHF7IENsvoNOWNOKHg7acQ/9mBk2CPn0tCD5aEjpdZtmEUpBtdV/K4BounSKGhb/owNW10m+WUL8WiVa0RSN0piJEbgeCSkg6JTW4fZfMYSrQXQfmCoUimS6Fs67oI4RbJg9beT96h1LXk8/7Bufor7ppHoRcI85kH9+QIwHfpiVlIWsHZZ+W9pMJLOgQbB8GYP5PiGb6rZ5g9d0lgvdbU0xWFgpwswf6+GvW0F5fN40oVWhLV/zcdcntiHz+kBXw0hgrOCa1uzj3HfDnhNC5h9yDLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jh9JcrGF3wwCzMKrtM62jL9RcGNyahnAtqMcK0Ck2Hc=;
 b=Q9hqosvGyIwYmAclHgSnBgH8VVEST0ZvTape42QMFeBpLbMb160eGLnZH/wTOuc+gCaOP85kUyYBxpe2RCr1kHmEsPAtm+adYYsMq1YelytnOI5C/dwD6l/MAkR2BNVv17IxzOJ+IFIM1YbeJ2GwhW+7Vs+QRiaHdxm/nSldvWikitObpbJ2tzw167lAZjSA/bwT5NipfroUXFJRVNbluinBNIRcruxbyFf5bNzApIT6nxdj5JMqzuGH1cC5oNLxx/IEnkialLOO7yoVLc/QEwnMQ9RNEd33XXdBaejJ8tQMQ8/LlXF+MCFvuqzML7sCgZhsHpuipoHEwIUDoj6iKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jh9JcrGF3wwCzMKrtM62jL9RcGNyahnAtqMcK0Ck2Hc=;
 b=XBN3qrAwP4btmAmaKyQQbHZWJebvIcKRPJWZ9AW85HkbjWKW9hYjKpM0qmA1jzJhs9rwEJkGIooYLfjRy4xiUms9kaK6B5CO8ZcO3yEfrWd7nV6AIrFjOgByrkieiZldayRcsDh+FC34UD3/+NMbmrWly88li20YFohjnc1d2jI=
Received: from DS7PR03CA0315.namprd03.prod.outlook.com (2603:10b6:8:2b::10) by
 MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 15:58:47 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::fa) by DS7PR03CA0315.outlook.office365.com
 (2603:10b6:8:2b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 15:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 15:58:46 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 10:58:45 -0500
From: jokim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, <Felix.Kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jonathan Kim <jonathan.kim@amd.com>, James Yao
 <yiqing@yao.amd.com>
Subject: [PATCH] drm/amdkfd: sever xgmi io link if host driver has disable
 sharing
Date: Wed, 16 Oct 2024 11:58:33 -0400
Message-ID: <20241016155833.956478-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: 0286a49b-aeec-45bc-6b70-08dcedfb6b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BG9F4VnqL53Ah0j6w86vjkeQZrJHUwafNtZC03SruE43dZya8jCsyewHEzuH?=
 =?us-ascii?Q?W89InpKNK2iTxC2Ap/6VLGyzh0FS9zubEapJW9CxY5QQOH7jiHBGbyVY7vGk?=
 =?us-ascii?Q?Zq3kQmHI5C8+PaqhBarl+c7f/PfI4e9+Tqss1iXXX700JnMORy+uroVCZdBs?=
 =?us-ascii?Q?+rUrMNLqJq7I5Jc1BtP2TbObm6wTE+rssYArG/MZ8DIivZB9k0Tp37wJeGOz?=
 =?us-ascii?Q?Jbqzxt4/JW/ToPuH2BJryQzNjRhtNQeQgnwSJrXr/7N1C3REr7sGOv8J++uv?=
 =?us-ascii?Q?pXQcJtM2nh+KmkTAVS0KE/kby3ZZRmv8n5PkpUjlxv2VUwxcnCNnIQog+FPk?=
 =?us-ascii?Q?EFXsgn92HBYqzKiF15vGNjLQizUoL5lHk6a1NvCzDR+yziU+kK13JK+ujRWd?=
 =?us-ascii?Q?x0Z0MT30CTjHBTlmc225VLgrsp5cD1OT41fAjAEtgLtsrgtCF2YpuvvBSSss?=
 =?us-ascii?Q?JDyX9qc5mIHsBWw7a2lBEw1FkpSq6IJMhp0rhDV+bcAHAB0XJqxkLwWXOhc7?=
 =?us-ascii?Q?2BahSg1EmZZT/4Q+/eZ7y1BgzOdAzHirBA/8a4pxGLM51VCdAEQS19MMdxHQ?=
 =?us-ascii?Q?R3nV6c6MIbt0TsUGuCWnsc3UJuzHuqNbMQjcBtoQw+GMd97iavEM/e/Hq2PL?=
 =?us-ascii?Q?mojElDb5xONNAlwxo/wFDorqSheTS088jSNVHaOx1c78egyjee3Nj0OeBnN+?=
 =?us-ascii?Q?zWv2e/DaQqHjL7dQUd0eHVDh0myujOqkyAKcuRCUnMS9eMfsrlXKZhLEityd?=
 =?us-ascii?Q?Ro7UzKUlQkg7QZ/eTQ6WkRcD73Ilhr53O/PEaaS/KmsXjNfU41MxtEsWTLJG?=
 =?us-ascii?Q?FExmoPzRvOaS9E7XBJcMeg03BwdGr5F6G4zTvkuZansJgxF89S4qyplQ9kjE?=
 =?us-ascii?Q?apQgXzbEwIvBqDmdR8zdSQefxGNhYe+tt+ysF/8rDxcN23gyhhEBtFPrhGh9?=
 =?us-ascii?Q?UV5coiztz+hCJ5NQYSjzsicL5ToEtHrwpqU+E4j3YMMXOrWr7ncFbUhiGrkC?=
 =?us-ascii?Q?/ryTp8U1jZWGKCqW18yg5TjmplLEzjzeSgUg7Ts3K8KTiN4BUz8fgYyCuD6m?=
 =?us-ascii?Q?94aJKs36t7uLvWtglfje248V9t02fNVdJZYPRRLtMqI3WsIw0dM3zYp3UO2c?=
 =?us-ascii?Q?3VtP/4jj8JXccj+ggWAdR2nxrNpG+u4rtcbfkxJgi/GyjwBLqjc7VIjaQHWU?=
 =?us-ascii?Q?v7/ONOHyGeUemF4S+EMw/YK+OP7UeNkRZdidoKfOh0Dy2RYMYgrgyvsEf2gB?=
 =?us-ascii?Q?Z4MIryXmepufw2MtD+3bfJ1rS9MyR7qW9ZRcXRhP+82h7x46yXSNmm4h/Guz?=
 =?us-ascii?Q?FGsMAtGDmhd9EFFlIeDh+wSJCZjDKlC3hGYfT1gta6ovXxZBtj1HCZ5vRkgi?=
 =?us-ascii?Q?5w2McWQJ7MCJnU+edDaE+A/ofDtcLJ2LqWnp9lC2vntToq55IA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 15:58:46.6659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0286a49b-aeec-45bc-6b70-08dcedfb6b01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706
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

From: Jonathan Kim <Jonathan.Kim@amd.com>

Host drivers can create partial hives per guest by disabling xgmi sharing
between certain peers in the main hive.
Typically, these partial hives are fully connected per guest session.
In the event that the host makes a mistake by adding a non-shared node
to a guest session, have the KFD reflect sharing disabled by severing
the IO link.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Tested-by: James Yao <yiqing@yao.amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c    |  3 +++
 3 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index fcdbcff57632..1d50f327eb08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -801,6 +801,23 @@ int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
 	return	-EINVAL;
 }
 
+bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
+					struct amdgpu_device *peer_adev)
+{
+	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
+	int i;
+
+	/* Sharing should always be enabled for non-SRIOV. */
+	if (!amdgpu_sriov_vf(adev))
+		return true;
+
+	for (i = 0 ; i < top->num_nodes; ++i)
+		if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
+			return !!top->nodes[i].is_sharing_enabled;
+
+	return false;
+}
+
 /*
  * Devices that support extended data require the entire hive to initialize with
  * the shared memory buffer flag set.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 41d5f97fc77a..8cc7ab38db7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -66,6 +66,8 @@ int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
 		struct amdgpu_device *peer_adev);
 int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
 		struct amdgpu_device *peer_adev);
+bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
+					struct amdgpu_device *peer_adev);
 uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
 					   uint64_t addr);
 static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 48caecf7e72e..723f1220e1cc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -28,6 +28,7 @@
 #include "kfd_topology.h"
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_xgmi.h"
 
 /* GPU Processor ID base for dGPUs for which VCRAT needs to be created.
  * GPU processor ID are expressed with Bit[31]=1.
@@ -2329,6 +2330,8 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 				continue;
 			if (peer_dev->gpu->kfd->hive_id != kdev->kfd->hive_id)
 				continue;
+			if (!amdgpu_xgmi_get_is_sharing_enabled(kdev->adev, peer_dev->gpu->adev))
+				continue;
 			sub_type_hdr = (typeof(sub_type_hdr))(
 				(char *)sub_type_hdr +
 				sizeof(struct crat_subtype_iolink));
-- 
2.34.1

