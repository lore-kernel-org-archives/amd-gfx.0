Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610CFCCF9EA
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 05:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E17EB10E244;
	Thu, 30 Oct 2025 05:11:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4A0ZHrRR";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A62DE10E244
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 05:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiCzQhmzEAFRtQ3uHJt6wyAOJqpqqyEc5/qxxJxHNFn0m0bDVGSmg867WxF/ioYqwMGvky/umWUw2gQajaFeEa/bmUAqlb5y5orhhUwYrMMPedbGOQsbjwyxOkMgBSz2ahvv565R2dHeeDQ2isiQtEAuzLAD/TpWyNTz4O9/X58uXLuS0BgGA3B3bZ0AxRyi8geXkHqyNs5rIhHBKM8u86/6YHRNEOUjUIYhN9qsurCdpFMAEdK0vgeEvo+DJNWijADmxbkkC3JE2Jac77xJuvXXDPtmrPiLr8//pP0fgbc6By3VInGfeYsCk1U9qfx8h6a6qQ359CVmc0lXdQEAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVINKgabZVkHmrqqLWvd9Jaxksxn/FZ+y/mKeaYl/Uw=;
 b=xA0meuFxvSmBbnWlBLR1+dtzEunnwUpOLvhfe95BfjdhPz1SpJAcgLbQnoZlmwaMxMIpQ/b54dQgdvpnKhAgSt0++bHejNDJG/rxc+0We2Lzw4NLXSaZC5TEneNbkazLXP0a5Pc782G50NpWxZLvS8xAyInrcb35V6smcmHuD6SfIdnp3ISa02QX7sqAOdwdyrXtvY1Rqct/mkFGE7dHfhheObTb6hwRFD3J6oW/ch7hYewNbs6xnPeksDufz8whrSWmk31Yakn1FMG8TV1F5qi5ZxKqi9l4aLnB6dWVdyw5VsuaFCv76RWhBl1ZtonAvhYiTDNvrI47wvXvr3jjfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVINKgabZVkHmrqqLWvd9Jaxksxn/FZ+y/mKeaYl/Uw=;
 b=4A0ZHrRRjzKfbJH0+DP5CXe78w8+VcmiWNrf4e2GL/8bvi+wS7quX9Gyd21AX3rcGFRgJ+dNlE9xGu9spEgI4/qAOWS16rzWwv1VrGrvGWgNvBcc2qIc/DvhWPyya0db/bFCQitVfCPi/zN5xddZagP4j7IlNEjpfeIwRKCMZ6U=
Received: from CH0PR04CA0119.namprd04.prod.outlook.com (2603:10b6:610:75::34)
 by CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 05:11:22 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::55) by CH0PR04CA0119.outlook.office365.com
 (2603:10b6:610:75::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Thu,
 30 Oct 2025 05:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 05:11:22 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 22:11:20 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/pm: fix missing device_attr cleanup in
 amdgpu_pm_sysfs_init()
Date: Thu, 30 Oct 2025 13:11:10 +0800
Message-ID: <20251030051110.1441129-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|CY3PR12MB9555:EE_
X-MS-Office365-Filtering-Correlation-Id: 294769f7-5651-456a-4692-08de1772c480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XOGlrzq2KA/IIFlFIJ3GE5yewiWYHG1FuV602rB6RhCHB21rURW2FL9P2ZTL?=
 =?us-ascii?Q?RcR9VQKgKmBxVJywco3MuXhbbxzXLcse/ZPPtPP/8WUzv79SnEMl/LO6sHmE?=
 =?us-ascii?Q?Td8AUOqOpWwg2DtKL4ryf7VWSgiPgu+J5AbmrArfAJSbp+Id6VML+y16z1fs?=
 =?us-ascii?Q?btmJE6EiCn8dWpzZe2pxg5V0O2Xh1uTZrniRbF+BuSic1DUYyDV6WIRn+8NF?=
 =?us-ascii?Q?zGCzcFZ+TEZrf/9kP7qeWg9SXKdrhmtA4R94MK2g2PcmcP67ukK1fIRY6t0N?=
 =?us-ascii?Q?/d+bEa6DYgnxC+V+pJofITqZx+vjToC3h3+nYhUmMqX1jH70DFL5iz5HhpSy?=
 =?us-ascii?Q?4fVKK9DGKfBbe9u36+pw7vPJ5Pz57dDcs0Wdxz3mfXvqBr0BskAujbUGk4JL?=
 =?us-ascii?Q?HsjGstCJKbqA66fUB1HkvPvtjlPfPWnwdGfc8oE+Wemwi3ytcdZQ2+JT7Nbk?=
 =?us-ascii?Q?sn7U6imnziWVbsckkePLuqZKIqvRKXg2KT4TMAlduzPNc7O02HkEk6ZtmZRQ?=
 =?us-ascii?Q?ChkNa0CydOTYEEHZA/5YOuo2gL9djSZyRWjbo8FreYgTjpOO1ei4wxId9wj9?=
 =?us-ascii?Q?22be7AbBPf9cV/ZB3Il+DZKaFnJD04WaP9D2gx4Ye80uXJzuSiU8fTDSaUB+?=
 =?us-ascii?Q?FZU3BlFM8npcRsr7yemOuTJd1kmT6158pO/z0CZ9Z2am573uZc1vskM8d48n?=
 =?us-ascii?Q?BJxAL28597zjKCHsbpnfdRA3l6YUwR/jmS2UUsmN3iEjp8KpByqpU75UTtfs?=
 =?us-ascii?Q?9/72SX/X/0YsVsGaOl8ZL+j9s1WuLjJSh98DwkuVh1g4vAI1oscMAShPeV6b?=
 =?us-ascii?Q?yqe/HHtG7FrblSF4n+2dA6RDQebga2OuDppbZXKz1spOoHG3UEsKNCqRMrAl?=
 =?us-ascii?Q?4Qz4rQ3YbaoWzBd0o18zfH/8Ez3H71TA++qlv3cxchVz/3QipspygVbx1wPj?=
 =?us-ascii?Q?NFRM+6WAif3InGGFllW2SXq4cGTC5Mew6rT9bE4rqmwgtIpEo+02tqFBBbzq?=
 =?us-ascii?Q?nr0MWRkeeDn6f0eJbMfP8toVJAww+HsCc3nM4evr1WV0OwrJuJvgqyYrKW3Y?=
 =?us-ascii?Q?IDIjSChbZqoSMXSVFUSJx2Rb8W4pgaU6oTBOO75EfjLeoL+cNnmEjn+CFRel?=
 =?us-ascii?Q?UyP89E7n+zQPC47AMbfKAihVhKW2pvPA185AnwbNiNWCLR/6cWbOp3DWvCFw?=
 =?us-ascii?Q?T6EAwUh8A8l03mPj0EVcaK8mBkPty5br8Xn10iplouSHQ9KCE64zrbuPOiuY?=
 =?us-ascii?Q?8OfkZ189YfvvP+F3V/FD2Q6W5KXzDgFFiwwSb4ffKbDD714INBJGTBkGrsYq?=
 =?us-ascii?Q?6Xh7iDT+q5rekW25eghKvcx/ZvkW2gywebfKfre9awEX0W34k5g+WBOvnUds?=
 =?us-ascii?Q?q96r2WBiMfOSbdE8vXsOWLhPzIdvbyU4PyzrA3NGPn20zVH+jQQU0x7BGUd/?=
 =?us-ascii?Q?9W9ny0/jV+LATLB1jqqagIIOZuCBCbOLHplyHy63fYQK5MmVWhy7wMbi+yI6?=
 =?us-ascii?Q?P3jRWetwPWvKD5ij7prlNUvyHZVcKmaIuK/Fmyqz0dnOg7TK9dUISYVjUV04?=
 =?us-ascii?Q?/J8xCm3QL/GntHuoxz4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 05:11:22.3112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 294769f7-5651-456a-4692-08de1772c480
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9555
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

Use the correct label to complete all cleanup work.

Fixes: 4d154b1ca580f ("drm/amd/pm: Add support for DPM policies")
Fixes: d2e690ff5d3cf ("drm/amd/pm: Add temperature metrics sysfs entry")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 3ce9b862e6ed..f9edb80133dc 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -4739,14 +4739,14 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 		ret = devm_device_add_group(adev->dev,
 					    &amdgpu_pm_policy_attr_group);
 		if (ret)
-			goto err_out0;
+			goto err_out1;
 	}
 
 	if (amdgpu_dpm_is_temp_metrics_supported(adev, SMU_TEMP_METRIC_GPUBOARD)) {
 		ret = devm_device_add_group(adev->dev,
 					    &amdgpu_board_attr_group);
 		if (ret)
-			goto err_out0;
+			goto err_out1;
 		if (amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT,
 						 (void *)&tmp) != -EOPNOTSUPP) {
 			sysfs_add_file_to_group(&adev->dev->kobj,
-- 
2.34.1

