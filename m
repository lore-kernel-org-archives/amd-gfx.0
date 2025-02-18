Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B45C02198
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 15:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2816610E05A;
	Tue, 18 Feb 2025 15:08:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1oJuWTr5";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1142510E05A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 15:08:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5kYBZsrsyJ3PpaaFrxi2CC8miQZZ3a+MTCjqbdN6nPjxpNsvlh4BibwdA/iobNDqhA1p1cN3QX+lLnwQcRsCA7qU1Tg2mXrrVCaPfG6M0Ag58rK2Jd4A2ZcPYc85p9jcCQgtiRfkEq3lqfunson7WOT02CxZK3htuiGIpthBIi5M/2SwSu+btKFHG1hCep8FWSDO7yzXCC72YNRrjMWsWHTRAEVE7jbzTYXUVGyGsc5apC7o1+vCLCgOdq2OPkhweJW3RAA3MJ7VM5vEuvq/AtZTzZgoX2wUadVKe0LTL2jTgCul0yWrniYVW6+eTdtkFc0WoIwdDzq7llYYqlTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5l6y8l4+u+l0cMnyhzUxM+Tup1akfAvgqT3Sg4Z2YA=;
 b=JwcpO9e+mn2Di8kvtYCNN/+Jaq+nhCh5SYsFc6I0aa4xywFRxFmke2hu0XvrIhaJ/+aFKaGkrNxWrhnWcZoW6w8ApGqZjljo3KnelLussCFqUwTwkjh+E+Yc35T+Nmt1jsxspVHdppYmljXRFUx6oaZNIuC/8kYrPaoXq61k5/MpvD4Vz1YLCNfVGuhiif4cOw2wGYxlx1COCCnMWxp7ajPIW6lcUwdI8zy+CaI4F8lGQhnkRw/mF/tN8R5p/kAzvoCCkZ6U+XJZW3147+pwcgvuxxRMR07P7Q0W8fyqtowk5wQzvd/gJGlz2zPnW1qjfdYWz8H60GRUJkszTI0StA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5l6y8l4+u+l0cMnyhzUxM+Tup1akfAvgqT3Sg4Z2YA=;
 b=1oJuWTr5EhJRxhrYe+G/WYCXyJu0y4qXdkqtDk3M+Dz7bEzMmOI+JrZtxz0ip3p5pbrrywjKJwvHTfQiuBHdVgPJ5ZqHC6ht0bgTZhBmi7yV1jX1iNOTmSHJGbuoHzE60IZZryPTeP+sM3mJYO+qyi40V41lNh2rhRmJJlAYp5k=
Received: from BL0PR1501CA0023.namprd15.prod.outlook.com
 (2603:10b6:207:17::36) by PH7PR12MB7306.namprd12.prod.outlook.com
 (2603:10b6:510:20a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 15:08:45 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::a6) by BL0PR1501CA0023.outlook.office365.com
 (2603:10b6:207:17::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Tue,
 18 Feb 2025 15:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 15:08:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 09:08:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: disable BAR resize on Dell G5 SE
Date: Tue, 18 Feb 2025 10:08:29 -0500
Message-ID: <20250218150829.2710795-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f2ed29-2484-4ee4-f921-08dd502e22da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JMSLTbTCd5oD0qHas+VcROmz1Iohnw2WT2wZEwLaB3DjeycHcFY0u0xE/ZdN?=
 =?us-ascii?Q?0fTh7/nEDKAzb5ekzRxZvlTaUtZyH1y+FDz+jnFYVemd54lOkXi6bnqko+ml?=
 =?us-ascii?Q?xOXI2mCv6X5AfbdtfKxfY3gydU6/FMWjI/5EmhhWAZS+Pb3Yufb074YD5gyC?=
 =?us-ascii?Q?xTWSm9v2fevIQnu1eAzHdyAQK55KEPYXnw7IVkAAGKMLOP26j4rFnk71r37j?=
 =?us-ascii?Q?VxJe1xGLcvYblD/GtVQWzmn9qg8Y275VhyJQuG525hurSO4ST8Y3OP8UirzA?=
 =?us-ascii?Q?e9del/th/R+ghHVd2JD43P0yvSbx4yVkWYOwnqzta4WX3E39Gx4M220+7ic+?=
 =?us-ascii?Q?YzCD7CYzN/2dcfbEoLcbE9ZLEZSYJwyoZ5F+sT0RHb2nGbsCu62zQKA+JAvd?=
 =?us-ascii?Q?TTkIvOJBKd0+jj4Uut/QGGFj+7YXsEWCLOESG4taIC+6aJ1ok5/8axk3F0Mo?=
 =?us-ascii?Q?9MILVhmwJ4iuNh92dZMS7wCbReGa+rF8PhZgdDQn8kXNY+fJdRL9KRg9KOdV?=
 =?us-ascii?Q?AfSiMbcL3rFmOWHK5rPGzizrA04pv+Qx2VxSGWmQoQ0krR+Wx8DIuz1BzHh4?=
 =?us-ascii?Q?3FELLOQWOtWnqkL5WcVgzdTDLtOGi96T39ROY1VGkty4oJ8VyyEEQdZLZ1JB?=
 =?us-ascii?Q?05NiRlMxn7uBoe3ac5/CtJVF9Er61Y8U/1Xa5j4JSkweZJQpvQEtWV60Sw2u?=
 =?us-ascii?Q?aivX3aGl2CwnepR19vErmDTm1WFigH07fmrMMAZh7ZzCjq+W9HT7mIfl8SUQ?=
 =?us-ascii?Q?FXFFdafJvcjjRvfhKATPFt1mAYHHb3rlq97GgGT+fWN54YpRhwtRpeRX/JEx?=
 =?us-ascii?Q?NAGUDzpMWh/uFmSgMNszC/W8+TXEyE8JtOlPUCU1esm7jBS5j0kPv6qPtYy4?=
 =?us-ascii?Q?x1AHWyT8O3xJ3HRotr0+OD8leGu8DRmdloH0QlRTX5jqqSP3kpDYkyhItuqm?=
 =?us-ascii?Q?20X53Mb5dW+EqfsMaE0KzQ5fydEi8WoDj2IRpWgHu5LGovXr4YUvV0bI0Nn4?=
 =?us-ascii?Q?mE/L+Z3oCa66zSfJ5MPmDEfcXoT5AcNrZmkqSSYhFVGVQ0vYJpStpvAuF8HA?=
 =?us-ascii?Q?fwU5BSsSKT+1LxXrQLNjgsXKxW76UU7XM4PyAw/yv2yPc/jfrK2yLfY91dYM?=
 =?us-ascii?Q?QQAVgvNmRWI71L3Kt9m9t0VVX0PMWL2a0vRkh2BTGYmzRsX9+zRgAMgOq4+h?=
 =?us-ascii?Q?lTRdLXgYELjda8xRDwzERgiA1UQWIA3Gc+z9o8kch4niSL6YBibCaSmIfyFW?=
 =?us-ascii?Q?GdJmEjOAdeyxsnXh2u6dFdM62NDpmCjCKV+/92yCQdiBXUpgNFIGLCkAd4SC?=
 =?us-ascii?Q?GbVtrJfUgdxVwPyX4ZgrL25hSdNveyYJm04fHQtet9sKBJONeXcnOAo6A17N?=
 =?us-ascii?Q?65eRW2qyvXvc9xd5e1J6+Gr08XC3zOTIX8VZMLRms6RU6nlG2FxYMhKaa0yN?=
 =?us-ascii?Q?c4CKuxNt5dA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 15:08:43.9503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f2ed29-2484-4ee4-f921-08dd502e22da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306
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

There was a quirk added to add a workaround for a Sapphire
RX 5600 XT Pulse that didn't allow BAR resizing.  However,
the quirk casused a regression on Dell laptops using those
chips, rather than narrowing the scope of the resizing
quirk, add a quirk to prevent amdgpu from resizing the BAR
on those Dell platforms.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 512e642477a7e..56fd874a22de8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1662,6 +1662,12 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	/* skip resizing on Dell G5 SE platforms */
+	if (adev->pdev->vendor == PCI_VENDOR_ID_ATI &&
+	    adev->pdev->device == 0x731f &&
+	    adev->pdev->subsystem_vendor == PCI_VENDOR_ID_DELL)
+		return 0;
+
 	/* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
 	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
 		DRM_WARN("System can't access extended configuration space, please check!!\n");
-- 
2.48.1

