Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACB0C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 02:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 285C3112111;
	Mon, 25 Jul 2022 02:00:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C722510FF29
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 01:59:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXg64W6MBLho+JYMk/TPmyvsPgDOl+GcyoDxePBQsFyG9PrPdRPjQsJpWkCXP887DQFChsBTR/nGIm0x6ug/oUVXm+P41/+n5j2NPTOcXom2UbLI/YIWuzU5NotVKp8N+TXbrmapDc71Rs6gilhNqot6VtR1jNyEMLqBwszvpFzsW9PRVxkW1m5FC2FXWiYjCZqFN7/Ij09iRTnqn5Zu3C07dWu/kiI4rJxD+PyO037158gN9yBghxVgzxQkSZPCJeKcLsZ3Rv6lkh9fPS/PPEgfU6A4eula2u4P5VhIudRK2MtRs9rwItmGmG+H285ZdYqQS4I4505ZCG9hwPEvTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XITgA3Tyqbal2JwmX0BLluLlz7KNTar+WMOQiVOxCI4=;
 b=LE1oozy0T5vuYe92UYVUUOFsx+VMfxvdwHlGdclMNIW+1poR6lBG4jXAtfduQ34ILeJJ0lyur5OvUTSKpEaBuo2pMmNhBu/QJYRzC+lXM0JDezh3A05hmM8K5UarrQKXfKpsiLh1Y4jEwcvC8n8gDWC1rB1y+RvRnAyFk8En6MdKprwOoiyAeF0lrfmwPLm6kEhPf03qjCwuKP3OBLZoJgQ3q0t3KeHKrx4j2hcVH0qwwq1vSPU8QGEjB3xyfGhbCGhJjYjoDEPoCeeOTTGeJshHs8MIzS4X9DAaYskelRRcUPM/5emGpE3d5rGMtVqgIztpu75PoP1Jq/ESfIhZ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XITgA3Tyqbal2JwmX0BLluLlz7KNTar+WMOQiVOxCI4=;
 b=tRHwLGSHtKs2qt6DmIRDWuQ6p2F+jBcTZCoTm5o+96fia9CWXBYpE00lcUJDJqck1zPQVRKycGr82xJaiEN6vWn6lI1U/ImudUXaC6jNaTOWc+YW7gUP+HqG9sEUep3sva6rIzoQto4/1sTV3kxRbak9OHQixA75nOuLS+ckwjU=
Received: from BN9PR03CA0345.namprd03.prod.outlook.com (2603:10b6:408:f6::20)
 by BL0PR12MB4706.namprd12.prod.outlook.com (2603:10b6:208:82::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 01:59:54 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::b0) by BN9PR03CA0345.outlook.office365.com
 (2603:10b6:408:f6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22 via Frontend
 Transport; Mon, 25 Jul 2022 01:59:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 01:59:54 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 24 Jul
 2022 20:59:52 -0500
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: enable swiotlb for gmc 10.0 (V2)
Date: Mon, 25 Jul 2022 09:59:07 +0800
Message-ID: <20220725015908.1434478-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 487335fb-f2ab-4771-2b94-08da6de15e52
X-MS-TrafficTypeDiagnostic: BL0PR12MB4706:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 66FGWwd/A0eLR2GRyoAR3Dl46itOaIhIABSyFJhYK5+2BWYlAAgj8T2PbfhxVFsqcYj3XBF6NXbxeCnq5iR9t3DaSUS0BdhjzfoKpLe3fwxc4/SQbIEwqzF2sZy46viIIMrVxUkdCEuDMq0wonvGb6hij7CoNEmMACz9znGLpzTIGMFR+AJmrehMD9bEqJL1iLVKr9QP0syGUZyOMbfCsflIIcke61UEMHRe/5uQ2a10+IOke8QjM/x6pG3eahVgQ8xzjGGh7yP74ZuCILmMF+iYAvspKPdeZqjmH0mvBpzS1Xi8hQ9yDxY5VNUbHztH+R0z8tUKPo2JuIWH4pVhy9xtnCgfo9QhT/uKxOJKmlTXa8c9urS6BFpLP/PL/SKIdaXZTo2c8xY4FMHAFL+qc6WIQT/6M5y9OspOQm+/0jU6QVNxKntyAU4WRB6gDZbTDCnY32n+rLcbx9QZ+En+92Uhld5aMJ9a2tPSMhy/8wUYq8zr7g5c/VR5xONKBUwk27vvQNZwhYDmn6r3h1rm8euOA/YmNnFxRufhA2ZKb38eqmA4ojPtVCAClsaVQdwDi0jJ0xdVf6JI+qSjuo+ZcxqWwtZ5LVECARFgLJcQfnfGbpf+eC8QtK0kdrpc10BsFPyekTsxZ7NHCA4qtbm6KzPpvi0UIslt4NSamVOVuaRBTTF2hNO/tfDq9mwNq9U+eN8ULjSwC05g0n8Ky0caEP0BGtbtnrNy7g2tnjuoVC5ZZ/689melit5cFSxiKTwsRtxj6s7CGtOyxJ2dzXb5jLsNPcXLUDVr8L4uKTTHKSAQRek/4oimPWJEMSUw32UUyWLbdTAamrF4oOzCPPLljQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(36840700001)(46966006)(40470700004)(81166007)(356005)(82740400003)(36860700001)(8936002)(86362001)(26005)(7696005)(36756003)(426003)(47076005)(336012)(16526019)(186003)(2616005)(1076003)(478600001)(316002)(54906003)(6916009)(41300700001)(40460700003)(70586007)(44832011)(70206006)(4326008)(5660300002)(4744005)(8676002)(2906002)(6666004)(82310400005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 01:59:54.3077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 487335fb-f2ab-4771-2b94-08da6de15e52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4706
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable swiotlb for gmc 10.0.
v2: include drm_cache.h to use the function ‘drm_need_swiotlb’

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 1772f006c61a..9ae8cdaa033e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -22,6 +22,9 @@
  */
 #include <linux/firmware.h>
 #include <linux/pci.h>
+
+#include <drm/drm_cache.h>
+
 #include "amdgpu.h"
 #include "amdgpu_atomfirmware.h"
 #include "gmc_v10_0.h"
@@ -980,6 +983,8 @@ static int gmc_v10_0_sw_init(void *handle)
 		return r;
 	}
 
+	adev->need_swiotlb = drm_need_swiotlb(44);
+
 	r = gmc_v10_0_mc_init(adev);
 	if (r)
 		return r;
-- 
2.37.0

