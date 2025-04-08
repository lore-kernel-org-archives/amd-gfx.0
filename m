Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2778AC3600C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 08:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9589410E21D;
	Tue,  8 Apr 2025 08:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CZnK8rtc";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1445210E21D
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 08:24:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAecXPkipyzW/9bNlRC8OSIA+bQzHRHG9Md99AWL2EnaijRUVcCv90uEO8iaNDDzZRLThnBD/9aKNnK+nZGUCNNWjOwJHGx3MyE4uP+3wGwkRCdLTOPrF8XpV8crjI/l1LvMLYPsQHoDuE+DOBxoqVbOHLTZwpQUPVJPtnKSBb2u7lbxdt8P2hS2wJa992U4+yXq5ib/j9OqELWtba8f844pEk/DYhMStP15opt6uC56/z9JCktqfjGk8reJXHAe6NLMFEYsIytVu0qrF1RnSYfH0y6oTUyNF7kIkfwHNznYPL2IKiO50p8EkGB4JTQ/9AoLG3GVODPbYgSG/DRoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4Cw8Z+5GHs/WfdCuZFJhvhnA5EN/+Ow8hk8F/WsCvg=;
 b=rewzUVzF/mklktfxc7g3Qq2R3OfgQgc0CI/EoIfoGo418ZzhkNgVz1CMQLUcQmWyTskQs58pkll1Po17joibEz2ldrsPMKJyd8diVh8TZoNH3ITelFnD53baYmWnbM6xTbAg2TthPIEheDQOIrED6JSoqQMCCREnXEFYOssIPskipBlHPoa/ZryJsnKzNyS+DBtYU7wz/6EJR1b0fgqf77Iq5+hERu9sgeNDne20rlpauAWzhurTfBiNWhRuzerM1sUVY+vjWFJJ3ux3IuYzUFTDqjia5HaIa6gtW4miOmoEUHw38sMfSqgxd0LGM5Tv3ayBIRxrCyUj7l/a0vQyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4Cw8Z+5GHs/WfdCuZFJhvhnA5EN/+Ow8hk8F/WsCvg=;
 b=CZnK8rtchvTxqUJkEMz00T89QY3viRB/oA7TVINI8oBwgzn8D3nbPgxdo4W3GQ1PUoPlmGHHX/zclCgngA2ZSiPnPAgaK3znO8VtrDGk8VuPXRnjnWGiJtR6T6DLiwuKEdqJG4SDshtY+iouhSik0gPsWwH5ZFnoPhJsAvvlGEU=
Received: from SJ0PR03CA0145.namprd03.prod.outlook.com (2603:10b6:a03:33c::30)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 08:23:58 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::e7) by SJ0PR03CA0145.outlook.office365.com
 (2603:10b6:a03:33c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.33 via Frontend Transport; Tue,
 8 Apr 2025 08:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Tue, 8 Apr 2025 08:23:58 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 03:23:55 -0500
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <shashank.sharma@amd.com>,
 <yuliang.shi@amd.com>, <andrey.grodzovsky@amd.com>, ZhenGuo Yin
 <zhenguo.yin@amd.com>
Subject: [PATCH] drm/amdgpu: fix warning of drm_mm_clean
Date: Tue, 8 Apr 2025 16:23:43 +0800
Message-ID: <20250408082343.207648-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ba3c1e-890b-44fd-5017-08dd7676b5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?scR82J/R9yZlZqB9cXZgqv9sd5qwsCWTOOI811a5cilJYY3WbZXSRo2+HiVL?=
 =?us-ascii?Q?kopxUBxihL/fmqZ7Dewdd1M6aVObZB9WlWDCP2r5ds1qBng+VaLW3Ys9+qsX?=
 =?us-ascii?Q?+CLMrdkDnIYGHGuVs80I+jHbug5l+p7nz2lrDuw2Iu6Vlyt0nl/vMNrJmRjZ?=
 =?us-ascii?Q?TweMaeZOheBkTR+LlZqz0fmOqiAO22oasnsqtAHDxtsFkncsZbBWqJsxB2R1?=
 =?us-ascii?Q?FugXEaoVgElaKXRN35O9svWLfhjnIZAuN8CrFVS1hIMSBcjSbP+nZtjbtDG/?=
 =?us-ascii?Q?GdDEfgNhd29ZxyJIJVy9nY4IFzC72DM3w/VTWWOWVT7+amTZQHyIM02fgsI4?=
 =?us-ascii?Q?uacu9+PNUyaEuND8oXPEVHunQtRZsTX9G83lCctm5c4/U5XLN7FSrO4nQh+o?=
 =?us-ascii?Q?ILJpeu2h2aldpn0EBjtlE6kMyWK4nrOw4ty8ZcDbBCY1JYuyXSfRUxVp4Ad+?=
 =?us-ascii?Q?x3pqCu2txOgiuo3Uq6YSVoXUQNwtzlALrs+nwqnCMF+pDfPOWngY7Ul5KSjF?=
 =?us-ascii?Q?+aFzQgI9GH5eoL7DQeJh8C3jFpmHL9B7IrFg2/TtcE6D9PzX7+vRSFJuR+kx?=
 =?us-ascii?Q?meIBNuMvtxMPf7O8li0Uhyb2umz8ULmxg1DmPKKlV5StWQls7uG9b+bUnRzx?=
 =?us-ascii?Q?fU22AzTBgU2ZrOHxHSPrfjX3M+o3SKIdmF4HYC+rJjlAW6YjEefcQcXANVPG?=
 =?us-ascii?Q?sULci13Z5Ec4s4Qt9CghsWizPWdtDm8xpS5xIIBSmHutr3vk+0ibkjdkpSJk?=
 =?us-ascii?Q?Bk107oxjST3TmsWQufvCKNpaKGlYuGtKAHeWCg5h/hJV3zQDHH5WV3QJoFIR?=
 =?us-ascii?Q?IYaKmJoY865tJW3oxxdAiqqbuy4dg8Y5MoEDcFs2eJEQ2gBb1J37eDNbqUWz?=
 =?us-ascii?Q?xcb8pgilCuV3mCTd8fT0oyJIr2sTNf9mdHNSK9RkERz5cWKrP1HVr1Zhn2Cq?=
 =?us-ascii?Q?Wz82LT63KmjaHsJIlDNBQeqOp5xrqczPwJkldkFSQbfXy3APO9HY0O/3TCJT?=
 =?us-ascii?Q?y9rZZy9sHB0zR6gOU58eGkEZ4/wqb7dsFhSsr4qMwgXjBxtKBQdXzpWYB71e?=
 =?us-ascii?Q?mvlY4Xt7sImFkcJR6oDe1j8xL21joUbpQHR6a8HosZidqLjbzR7DB3+wJYjA?=
 =?us-ascii?Q?Iqg83CFqq5QArriZ0EbOcmUjccq3txq27j2VZWOzW2TTByscYtUQmcr4Rmc7?=
 =?us-ascii?Q?xL51Ra46PhE9g7XFtYRwDIFgblw1E2Mh0JMgi1Xf1+SZwmWzd6LHj0SBfTnS?=
 =?us-ascii?Q?9h62qFW8n/bvaXYw5BeGm9xu2C9NjhaTdvudNnOnQPhMJZjBJS35JQ4XlzEt?=
 =?us-ascii?Q?n/kh8e++Wq4H0gRJmMlHqDBUhzN5gHf5/54m5FJ9X0c3T9YdNgpTe6LQmiNp?=
 =?us-ascii?Q?MJQqllPK7+M9XCtYe1+zXnbp0C6lj2YT2aIfk/FRAmmhN3R8j9rTzq6QSxXt?=
 =?us-ascii?Q?dRFyHmbr0vwXeJBfo3DW7+ZORmOQkCvoLrA82I48zBhpf/irvbXgucCmDO8t?=
 =?us-ascii?Q?wXSlNM4cv4N5hdA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 08:23:58.1193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ba3c1e-890b-44fd-5017-08dd7676b5ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127
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

Kernel doorbell BOs needs to be freed before ttm_fini.

Fixes: 54c30d2a8def ("drm/amdgpu: create kernel doorbell pages")
Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d4b01ef00025..ff48096c1d80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3508,6 +3508,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 			amdgpu_device_mem_scratch_fini(adev);
 			amdgpu_ib_pool_fini(adev);
 			amdgpu_seq64_fini(adev);
+			amdgpu_doorbell_fini(adev);
 		}
 		if (adev->ip_blocks[i].version->funcs->sw_fini) {
 			r = adev->ip_blocks[i].version->funcs->sw_fini(&adev->ip_blocks[i]);
@@ -4851,7 +4852,6 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 
 		iounmap(adev->rmmio);
 		adev->rmmio = NULL;
-		amdgpu_doorbell_fini(adev);
 		drm_dev_exit(idx);
 	}
 
-- 
2.35.1

