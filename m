Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72A2F513EE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E8B110E311;
	Fri,  6 Mar 2026 03:43:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sldJ0jL1";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011034.outbound.protection.outlook.com
 [40.93.194.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B23E10E313
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1Fa1lQs/jHI/yTsKbPBd4WwUOtEUkcEv6tp0sVBGSFqkzqHWIp9KLVungn4eCo9LK/5/FU47R9cEwBMJ8ytMn7BzaWSlRUGKKNZ6GVf+YUvryKI3Ze/+77Or80m7ZMbbOv4LPOeOoLA6D9PQpN+VrfhtrFqtePWLnHKGL0zqLgziQPgggD3psnl3NbtL6C9hcocg1aE1gs11QEeWiNBg+kKWQ56BiA9BYNEHEUNTfCl7KfyGORrZ1NMDghCF0c6QjD23Kq4Vw7YBF2L/a4BaGnPf7Ss0bRgx8GHh+hcRmS621MPtGVBwz478IshI9xmaNQDUPWm1C86PnNib8q22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzsy5Hy5yrUBZAnIdvQ8wiSS9zRLVPKlv0rS8NTE2Dk=;
 b=skKusET5rXVbTtDAXM0Eo+qpZfNvXEcEbUN1dWCDfbQbYwy7xTsd+ZZTjxdjPYWyzs6lHQoA5W8ZvsU+gsJ3CUDNOmD54IK0OzIaGpi8y+UbwwnwK315MdHwNmCIpniVuTb3J9J5IvE169+XnjvUNvohDflXZnBArFHpnyHcJickECr9iKJdvRdNXr/BcHmkrpKqhXOqaVEmKdR2TDa98M051XyHfx4BohF22gvQtmUYAWzy04lx2oBh5Mwk3kwES0FncHWY3LvAxnr575YJx05heY70tOKhHcBqpBz1UfObs+TmVGK5bLLETUsdlCTAVHsKDRhTLd7zA3TO4hOz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzsy5Hy5yrUBZAnIdvQ8wiSS9zRLVPKlv0rS8NTE2Dk=;
 b=sldJ0jL1hkeDw/BwMdBPRi9BdhdJMPqyFNcTCvp7feJwzp4fy18YN5ol/ptSIAofxyFbZ+Flpp78QNaP7N77TZDsFdTsynwliCSesVW17DkG1WTpddgCFi1l/wWlCigYFSUqAtHImVtGA3f0s5XGHxPjV6qkoYO5tbKDNL1ptj0=
Received: from SJ0PR03CA0185.namprd03.prod.outlook.com (2603:10b6:a03:2ef::10)
 by IA1PR12MB6042.namprd12.prod.outlook.com (2603:10b6:208:3d6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 03:43:06 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::bf) by SJ0PR03CA0185.outlook.office365.com
 (2603:10b6:a03:2ef::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Fri,
 6 Mar 2026 03:43:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:43:06 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Mar 2026 21:43:04 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 2/5] drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
Date: Fri, 6 Mar 2026 09:12:44 +0530
Message-ID: <20260306034247.1783347-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306034247.1783347-1-srinivasan.shanmugam@amd.com>
References: <20260306034247.1783347-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|IA1PR12MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b7e61d-4031-418b-1db7-08de7b327a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016; 
X-Microsoft-Antispam-Message-Info: /Hs82MXqbNAOnDmV/Gz/2Rf30pvIbfFyLMA6HOekzSCb9T5x5xfJAN+8ji6+3Q1CUxZeS3MyWFamhRmIQ2ZYd3x1iuUY1fxrumbzzG3N1uAqizeUkZaUuLlT/wWUgPy1xZQ5uTKgABqV/LyC1ExQszSjnXdVQ39Ip0lxaJYIgyqC5fWPLb7WW42XNV1Q66sTayaLQ8WBao2XEy6J1bm3iqxn+aovM4nWlkIM9niBVmmichmTCqw61FF7bYTJ/VnT5CWlPvZvIiQDUFIb3pqxkaaKY4m7LzFtQhmyAWvZqOYIfBb2ReH7BUmHtK4rKpP0IPwbrDhT0miWutOQRWIGJlPDAUiqmH9un8lBqJ4zJ+KFDx9l0CZiD1N1kh1TL/G1yyXytBv5np+ogMMeugKI5uSLHj+dowPgnHD7lD/1F7GK3FDyj8XLgn/a2wEN5MyFZGN5Noqare5JQlL9MiqQBb4dS+3dPBla2/ESj5Od+EmVG8D3x918NJoaRWbIfnGWiyeAkwlR6agRZM1esQh5Y8D5hd6hd1qeJwKI3p92h+C7mdshZO52o3YUHcuifFjLesQm141FYflGPj/qYJGeiorwhmblSf0qDQr6et+ljm/54c53ognO8Jc0qxG0jvfI4gTu8ZiT5aVPQouqpYrLptERfO+howhhmru6O/b8cJoxil1xXbb0CyJWicfgKSe0dx6LGYOBKj6yyMkPi944fvyCsXNfaFo9zYsyUbrPwcLDW4sxx3hMgGSjbejcItBmbQtS7LKfJReoLYtbqV6W8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ehfV8k3ufXJV4NThytX3cv0KfRJDpPeFnt7UpZrD7CazFpDe5UG2KwtoxnmSS1N+nwt/+M5/hT4/+5J1+3e7ga05PTE4GoONY+FUTrtxu8/PBLDoYu94TbJeLy2lIANvuBiZlrGjwpenoUmF1Ixv0TJTjO5i/qZePLSI6ELBoD832VpMej5RRGIVfPNLjNVOTH0JqSWx9oZu9FTO3asdQIQJhyX32aqts0tLz3kJda4US+eZZIOfBaOL4WSXDuhAAcWYMe8QGkkTuDpJkZBlW4IFKe3+zUsq1jeQI0GuJco+Q8ADO3+V4ShG8R8PXzdLdmEaQUct41t8gr4CD+q+wKdCZzcjRV9IkPTgzt081eWatQO5hl4Yd2TF0jnbmTHyxpBkeBMKO2TkiMU1GXL0Ybm50BJ3S2nUAUDb80102p7IRTIY+EfnSrB+NP0VJqV6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:43:06.1914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b7e61d-4031-418b-1db7-08de7b327a44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6042
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

