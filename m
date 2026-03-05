Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA4DEFCE5A
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 03:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF93410EAE7;
	Thu,  5 Mar 2026 03:08:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T7BMY3jO";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012056.outbound.protection.outlook.com
 [40.93.195.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63C1D10EAE7
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 03:08:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEsrVmxX4uUw/uog+C7AqSm5E+U4w2SSVFVmQcT1PCLIwi/kJb6gmhz1qD15ns/oO6QdY7DZsV/D4C6vkWjPfyNubGoer1h1X/DMNfE6oRdMRxDiiXxqAOWzooDEbYTgpmnLSmG5apq0buF78PxXV7XNQKAalZXxLM13OrNSTCNQBMRHdrGQzrIb4daDBux37DX6NnkHjKkcoP2z3w+dAkmgO5JfoHQI2zU8wNYHDwTtUcdpAIZfnBfXEnQMT4eY6XoE0HFafz2+71OQj/enSN9aYASapyt2CMqL6vg5w9nDg7SLxJRBXd0NZgWU9PIaXpYVGSko6zFy77vhs6y20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzsy5Hy5yrUBZAnIdvQ8wiSS9zRLVPKlv0rS8NTE2Dk=;
 b=FaK50RcpBalvdIwF1yvPInMyGaZQP1XxQA2Mapd9k/yU807QzwFY6A/yRB+dWwCGw8O1IFslxFQV1Cj9eBiZLB3bch61LNIvUspCMuxOSXjhc0IoA4IV3f2ZrYMjomQ7uVR+PjwPVIl6Msk1NS1PtvJ+oulaANPK1y8JV+55qlVQCSJ5VylSzlR99Br105vyh7Um9dgSSCkDOC/u0lkbv1G0rZ7eLc7C0hz0uHOk2fiCzr2HqAfVkeF7EvYU3jBmgSxY3L/7fif9oDeY5Vk98zeTv2TmQLQ4gi/M3OzedtR+H4/W1iK8l1z/DfVx1Drl380s+MwUuLTUhQ4E1bhyuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzsy5Hy5yrUBZAnIdvQ8wiSS9zRLVPKlv0rS8NTE2Dk=;
 b=T7BMY3jOzUqcDLBJvsmz/ZVdwGuUDom3VpthJU8Foz1om+QCBdmn8M+FyukR277BLx1Mu0tK1LcyZVOEWcrkG5/e3qpF6j3iU2JXI46TBl01stYFTd6qsUiX8pjbYjwkWOzm3oURtNk0iPw6v7IXjgT0EVso/7UcpkZo0+296g8=
Received: from SN7PR04CA0068.namprd04.prod.outlook.com (2603:10b6:806:121::13)
 by IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 03:08:27 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:121:cafe::4c) by SN7PR04CA0068.outlook.office365.com
 (2603:10b6:806:121::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 03:08:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 03:08:27 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 4 Mar 2026 21:07:51 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 2/4] drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
Date: Thu, 5 Mar 2026 08:37:24 +0530
Message-ID: <20260305030726.1779794-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305030726.1779794-1-srinivasan.shanmugam@amd.com>
References: <20260305030726.1779794-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|IA1PR12MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: deef2dc1-733e-4fa4-ae71-08de7a64789a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: wepgWhIC6UsjX3nq9rV73pal79xKu/zvmi5UBpvCYWC/tYSw8mS2GmcxfFXiFPiJnJ+X5sFfWfAehoXp5OPo2V6ij4fSd5+E2F31NeK2i16915MGorywH549QQqEq94zc8Le7e4asAG8BPyILYYviDShYag7AELfz23Zvz6nasGaVsaVoOPgZiL60+fkHOhYo/Tb2DpYcEvU5Y05Q9N8bnl3t3gTBIait47HkLht2DubNWh07m3FSEP1k9+MsCYwTt5E5OhnAtcxums1qxrDZv+6n8PrG9tv+fCSO5RjuVtqMGDAKtuhtWOHUmD7GlHMgbyxQ6eHOXOwZH8nzC77aQzZlJjW9SieeJ5O9LqvEHXPJ/KYrKoCCoeU9zm595PH39Wfy0uVKwvWdRvkNpYIoLcNY+XWGRtwwEhUpvxGv7vvn6l8C+AU9xd3nxyOyzr79K1JzqnzrBm1sPIjLyw0nFss/nI8XBsxr28ms+XwXTHjqHrQ0AFAIipQmcUZ1hgLBhG5wS4p0t3IM8ceh/S+Ag0FWLPQQ7zL2dwQ16aRahHuZy0UIiR+Xlqdf8/4pG1of74pR7JIk/lfy75CJ1QFQiqnoeXtHyChYDbi9JiSw791Sac6OnA0HEjtEHcUoTkoCdpUX2X1GlSGJufcVAVeq6tPiF/z6wzB1cg0Txh7KyP2DHmGCYOFBCzvryfFAMGiI6/ri2TSvwZcmKYVhS4gcKHPZgky1y5a4eXW9FpcqKoEAa6Qg5Fxp/2+CFCpbNMUu5w/12gY7aBZBwK3De3tZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tAF/ZJ3gwUtQJ7+kQ8/To/IQ52CK0lQkPVvvKsS0uRbNJJfUXptc+55m7G2i6pQwkBGjSVUfmoBbLOIOrxnsgDA4gpv7RfuAHzbhAAZsXnG7eJHtkcZDDgoLIrb3m3FXG+1D86mG1m5k3Hi0sN/wZ9eVkeijpQSArPkcHTKzyI14FZn1irxaEfihh1vZG2SSTp74GcA1qsjfCXR4HeJ8bh1M278ca5UujpM0Orr+CLiFVOQLOZzpskeDDhP4jOqskVanE79P7a9k2DyIItWClIbfqIrQFdCGFuuEUKgXy3FFxnCHQ6L6kSL3mKdla884cEmg0eXiuugCaHCumCtpHlZXZ5P7jXPbPqOl+mluliMKT1wXo0djAOiy+lQNFQ7WplI7q+CeYUHcfZdrLk+CRk5/bw4xjHPmd1RfguZCVvS4tVBLKfS5T9PWxaWJAnds
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 03:08:27.1566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deef2dc1-733e-4fa4-ae71-08de7a64789a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221
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

Tie the eventfd manager lifetime strictly to the drm_file (amdgpu_fpriv)
by embedding the manager instead of storing a pointer.

This removes the need for reference counting and avoids destroying the
manager from IRQ context

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 59731014a55a..6d652e8ac978 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -104,6 +104,7 @@
 #include "amdgpu_fdinfo.h"
 #include "amdgpu_mca.h"
 #include "amdgpu_aca.h"
+#include "amdgpu_eventfd.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_cper.h"
 #include "amdgpu_xcp.h"
@@ -453,6 +454,8 @@ struct amdgpu_fpriv {
 
 	/** GPU partition selection */
 	uint32_t		xcp_id;
+
+	struct amdgpu_eventfd_mgr	eventfd_mgr;
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f69332eed051..ad27274a9e92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1469,6 +1469,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		goto out_suspend;
 	}
 
+	amdgpu_eventfd_mgr_init(&fpriv->eventfd_mgr);
+
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0) {
 		dev_warn(adev->dev, "No more PASIDs available!");
@@ -1568,6 +1570,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (!fpriv)
 		return;
 
+	/* Drop all subscriptions before fpriv goes away. */
+	amdgpu_eventfd_mgr_fini(&fpriv->eventfd_mgr);
+
 	pm_runtime_get_sync(dev->dev);
 
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
-- 
2.34.1

