Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29C4CD5BD5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 04:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5389A10EBE3;
	Thu, 28 May 2026 04:35:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VPPE1PDf";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF9910EBE3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 04:35:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h955Hrc+DRDhqbTcATjboopeHIbHrZ3LQV9R14yzeOLRJNVodjucTdpNdcfUcXxCCdSIhS5/7Oi95MtYjsE6d8L+Eb/txqPPCkQuv43Zs8rSzkx+RvUQ6ZNcogdXbLoqx+JHlKVz2ERpc2GlPPlOcBFrOlLKEyHuxIh2JUsnlzysg8c2mY3C26Qsl/cDEm8sdv1L6C3JKQX1IFZCjGrkGn2zn4dN+ZGyhMcyYNnhqdggmaRur9qxM7wLbDLDrwbAiIVxkmUsxAuBMdMmrL+mpFODIwMjDuL6kYr6Tog+ziW5XCCMKJlg8RkNbCSsOzXZ0MhUEL3se6dsNoVKyiGhvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZD9A7cTuCtGNx1vgvmftvc6FNO5iRwxoY42ClOsLgCI=;
 b=euVrmbHpKqJDa/goI6vO1q3sjmtnYPtIpIVrW4AdlF3S/4yjd2AV/5Gmn+TY4fDcIpU7yh4ZvdZQU9cHg8ehvZAbpoltlcIWjL6+cHUMI63HyBrjDQIc4JNYAHOtXPno/iUYZsVap64bSkGqQEI23u2l3GSdtOOzzmTtd/cTX0kcgrRVmbRU+E9c4SecAaX0W+rCPEiw/8tSZz2j9Q+X7tDZ96ebgbbprH5HHLIUiR93LrK33IUqPP6u0vNjp6jEfJtuVqrS2zaZx5M1nKK2boPVLXW1Bct5SHAcKwqByV0NmV42B6hkntgKWRAiNl9KmnqqYpvQFp0ebvg1+49rmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZD9A7cTuCtGNx1vgvmftvc6FNO5iRwxoY42ClOsLgCI=;
 b=VPPE1PDfHYAhb9wNyjvbZBx+2jNrxkzTSd+PDEW2spvnwo1lRN6MmFulzLbYwDHlI4lMsrSBf7dGhVafXsDCIBTzT0FcS3aG+cd9cV55zs1PkYIvpvralLEYgaDFEda0BXqT7nPFudLwZ1ip8lce4EOQAd7rbx760aC7/1/NOyY=
Received: from SJ0PR03CA0357.namprd03.prod.outlook.com (2603:10b6:a03:39c::32)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 04:34:56 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::71) by SJ0PR03CA0357.outlook.office365.com
 (2603:10b6:a03:39c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Thu, 28
 May 2026 04:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 04:34:56 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 23:34:54 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Stanley Yang <stanley.yang@amd.com>, Thomas Chai <yipeng.chai@amd.com>,
 Candice Li <candice.li@amd.com>
Subject: [PATCH 8/8] drm/amd/amdxcp: assert XCP platform device names
Date: Thu, 28 May 2026 12:34:08 +0800
Message-ID: <20260528043408.237209-8-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260528043408.237209-1-candice.li@amd.com>
References: <20260528043408.237209-1-candice.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba3f416-80a7-470f-46fd-08debc72784a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|11063799006|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: k5pTqp3rWGSyMqSwqfxrUkGMm4H3f+23amKKmio6rYk3OKiGmS3KFtLecE+/SiNz3rsFpLp/CcRl8WlfWe/xO0UaxgOBl7wZVd37+aM0qd1rJlsGN3Y7HTSGd9Y4vfHUXzq2ps37U1DpE8gGqjwh5D+ijjQGicz1VAyTYjzfITLV6rHoiJWP9cNfoU0nVXXC3ZpYnttw1B4CrmrgWV5hJJZAxXF1b6sLq6egoAWBKWLNFCD5Cxn+VtcutBrmKhXoIDto6hjQuzVQN4peIAkM0zpD6x9TRq+fcYtULx06MEXjYSfPMm2FksxP7V+040pLIiKXUW2q7G5IBtCW/NC8SPNL9I80geCheBwS6pL/prnYoaDAtD/wWT8f1469sRiHVAIs2WLByftGeeSn5NWfKtUgnalRjuYHBbtjPBCPz1uaKPjKXhy+yyJCEgW/Kzt8n/wPbD4jPQn2v/HRLRYpNSycThdlizmcD+KM7jK/MESRsxOA4myakKtJuDil1GUf56tpKbF8OKJilQ8cbX/xT1CMHupsHvJGI/ygM0YZqwGtuwcjEtPW1IMQp8TdvTRCPcIaEMruOr7w8UL1+KLW7i7FlKvNxp2o2/mnsMrCpu/4rdGLpFZsEBtEgjHbdbQfnqIJ53i7c1eT7B5/voiiPJj5ZLgoiqWv+0Ip6o69ctKtDekGo85LZNiPGyZk9iNYvqKd/SDKga6mwZLyYrEoAqr0PxGuwG2WSL3QMa28Tqw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kRE1/G3voz3CD09mj/G1slkFWt6zxcA8bQC4WVvFH0kNdW0kWZo8pWLjt2h5pi0KiuozeUc5sRkgMg8S/8qVBdhA9cklPOf7KIE+YA9I63M+qPx4cMxRnQbAIZHE7muZD4SEl8GtAXkb7/O0a0BxjXdJi1/lVk2BhkeEaeP6zB4hndHK7hXDeKxempcTizx2WYsZA/71wl0G2cFRyHfuLysvqdyCr3Azv7TVnBrsNC0b21C18Htp9mtt+G+3Av/frdi6PLkHcktb3V5SYE71SAgWJbyLtmmmpmP+2yfzVKGMFknZEEB5JQZMkr5KGEYyhy9NjQeetqHfi9VGjLJTxY2p3uRhwrJ0txSTq2JnXOeFjw6xi92TtvkILBYN/zwxKUC6cJ4e1gXggpj+VWYIEfDN6pZJqK5XArfOZQ3WuzcFFDdb6OOuT8eTU53/b5K6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 04:34:56.2797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba3f416-80a7-470f-46fd-08debc72784a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421
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

Replace the fixed stack buffer and static_assert with kasprintf() so
platform device names are always fully formatted.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
index 44009aa8216ed0..995cae6be144a0 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #include <drm/drm_drv.h>
 
@@ -52,7 +53,7 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 {
 	struct platform_device *pdev;
 	struct xcp_device *pxcp_dev;
-	char dev_name[20];
+	char *dev_name;
 	int ret, i;
 
 	guard(mutex)(&xcp_mutex);
@@ -68,8 +69,12 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 	if (i >= MAX_XCP_PLATFORM_DEVICE)
 		return -ENODEV;
 
-	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", i);
+	dev_name = kasprintf(GFP_KERNEL, "amdgpu_xcp_%d", i);
+	if (!dev_name)
+		return -ENOMEM;
+
 	pdev = platform_device_register_simple(dev_name, -1, NULL, 0);
+	kfree(dev_name);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
-- 
2.25.1

