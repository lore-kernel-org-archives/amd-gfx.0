Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD21D0E6F9
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 15:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0167610E42E;
	Tue, 25 Nov 2025 15:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Eo10WAle";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E65E710E42A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 15:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uwbk7WeerhF/H8uUwHyZ69HmwjRgKu8wUknkROIOnFC51lYc2OwiM1mj66AdzhetFPz4S10w7vN+EKCbaiY6aI35B+MJIXr9cv47TiYmzR8+cNZbS5Oy9KIWZLfjgn14T5DsZjZePx6yGscXJq0U2CqvnkyG3Qh1JDrGGb0waGN0mVqzVWWbkzFaOrX/QCA6wLAj2aWYc8QMnwxg6jZmeBwmRTmdOQFk7NYF1l31zWcUNEm3RiiQPoWtM4DZW3PM3IoCr0Vjnfb4bqBhXiDcwwC/d4iGtiMm5v2OiVzyAt1UYwD6imDXP18AuKFYxFVu4q0cuuu9A6P94l4+GHD8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ7hDkN+kFMCIPy4ru0jNDTiCCrhYJhcq5ZFQycu9gw=;
 b=yPKw73zyzyDpo7MeSvL92C8FmAutSslCI+8NrqJFIt+OJGT5OPRV3K1t/8CuKAxLpmq2w4qZbmMfry/hzm2UOTjdipZ/fjMzPrFDt/GONMlCqj5VjG3s/6SJJtIJGLFnPFUbQph0xTqONVLeNZODRE6hdlH9ZmM33kNhliAUDT6MEeqK05K1XEo31wldlsJVNpyLcRB6KCZV9h3lfQo09LYFfRMdaSyCDCBVbsYIHUtcJV8lH0uc2uLgCZjsjxdwn3nuNOAqO81PDDINDmGSuwls9+3niBNTLzORdq6gsSUWiBLTU+AVePc3jnpHvKQm/BaJ0Zu3RECVwBb2phCN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ7hDkN+kFMCIPy4ru0jNDTiCCrhYJhcq5ZFQycu9gw=;
 b=Eo10WAlervFRiK/e9mI/L2liihNmf7JsD8RKU+HOEXWslVDTXgm2r5A6EPM6QjcUNN69B/Au6byAcynS5vNLoeqAHPHkw8vBJLmvO4f9zkk+/GGugzkYs9rn7hWRgGd4xGT1bFeCxLtQ2YtwLrioRTT6WZeW82bok0dXB/RMRaY=
Received: from BN1PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:e0::15)
 by PH0PR12MB7905.namprd12.prod.outlook.com (2603:10b6:510:28b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 15:08:31 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::5b) by BN1PR10CA0010.outlook.office365.com
 (2603:10b6:408:e0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Tue,
 25 Nov 2025 15:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 15:08:31 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 09:08:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix golden register init for GFX 12.1.0
Date: Tue, 25 Nov 2025 10:08:07 -0500
Message-ID: <20251125150812.2046438-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125150812.2046438-1-alexander.deucher@amd.com>
References: <20251125150812.2046438-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|PH0PR12MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: ca27f47d-306f-41a6-64d9-08de2c347f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nDw2Q+g01eGIERZKG3gB9r0wnoPLSgAEjgKAkZ8iDrvSlk44qqJ2p+Zbun8+?=
 =?us-ascii?Q?hzbz39wnzbLMT4LQbSKbe6Y0FRKNQ9YCI1oBzZTX7uY5qurHvj/1Kb57IA8Z?=
 =?us-ascii?Q?5lHjkFd+BwXs63V9GHGk6t6pPRsWLSE8mYyuSVqWCsBJJEmOZgXT+Y2124kV?=
 =?us-ascii?Q?3+qh/IJ47xlSPditAaZ3bKisOSB71UmGploXJvPB3M95jeLFJfR2VWCRgng6?=
 =?us-ascii?Q?MjY4dA8blV1mLMsxxCe1mI0fRbYMqaZQoA9cFJwEeoonC8QVlvQFGTx9L2Ja?=
 =?us-ascii?Q?wI68BzDxggnuCNe+aRnNwrLQYFBwxx6xRiksswjRIz8lbSoU3IvZCPFi0l5d?=
 =?us-ascii?Q?wYcd9erTfUbPpXdN8aDV4BLzxYqAmzYHOC7YydW90qKBRnAtu7ZuWsaZa083?=
 =?us-ascii?Q?0XKymKh975T1aolmGZATx6SH8fjOBPwrg+OecAxCL7lNKD+suIF2mg7aIs8K?=
 =?us-ascii?Q?+LZzw4TcG4lUddMTyKIc3GRP/qmifFP1EAl5elnjCC88Le+04qzYHncXMSWi?=
 =?us-ascii?Q?zuoT+LaWp67oPRcee7D/KcX0Ba2UNHBlkhqyG8GbgucbxXIvLs3nu8pJpMHa?=
 =?us-ascii?Q?F5nQt0QjxcGgc3Gv9rjBdPU/Ow4VXY8fxjynKTG654xxNifx1A8jtgwD+Pvc?=
 =?us-ascii?Q?zPvDcbTy9kadTC9Jyhnx0Aq3Xm94TdCuJYPydp/Xr41l5k8HmyANXB5hbewk?=
 =?us-ascii?Q?l+0JBSiVGkhu0M27lbKBYwDY2V45W0qSGwO8q3SDs5jtb8onGgDAEaOXSDk5?=
 =?us-ascii?Q?noxynktfk3WWKLgYyb9kr+JGh8kLTsTvY7ezTV9ulR+z2Gav9n39+MSrv22I?=
 =?us-ascii?Q?DqfkRGE//nGOP8gX+pugMcuTpebroIdL4XCuXf34di6vjEQumaSnL+H+JbIm?=
 =?us-ascii?Q?9PI6GHP4Gk7rfTpdM5X06/KfM3If7gmt0eLVvqGwleIvghFQwErlRm81QIAE?=
 =?us-ascii?Q?J3c0xYRz19oIykNvxdchA0SAjDNnsfDVG23olXzF/ZyCbSMTZRVmdaj3mHpU?=
 =?us-ascii?Q?R8q3vUQuhFceN2MYkl7ODCtnd+fygFMpq1icIlb7Qd4PL4p/xGDEWYweSlPX?=
 =?us-ascii?Q?pv0aZsMiLlMmNJ7MMURAC0Do2wONtj3IYOHJNTIacgZ4TPki7DlcqGb/LIR7?=
 =?us-ascii?Q?pNo+lMdQM4BV/ThTz9B9A/j5Ov4jmpbnJUO49W5MPP7I4lRgkbsGbvjw+DyV?=
 =?us-ascii?Q?Eu/Gzip6Eu1dIqIvujyoK5jIP6knng3WN7/7KKdckSTiDsok3mfvcSai8BX7?=
 =?us-ascii?Q?0LmPHi69WVNZwtpFlHBS9yw0Ckm3CznlZBi1K70KO8bBhCvay1QjiTWjzKRJ?=
 =?us-ascii?Q?t9OpFG5OpjhOOhobwqDX/eS36xF6+BHBSzCOJcaIlXam4+muMyQoOSOBy6Nk?=
 =?us-ascii?Q?Fua6AGZWO54fYPSAz9cIR3lJ6DoNvSlpzr9dTXAMolcUndHd2B/+g2P11PHg?=
 =?us-ascii?Q?z0Cx/4GgbCT8snwVC+hAWPcWyuKp/SLYQElwxQwaYnGduqRBahYKSfvA8RXK?=
 =?us-ascii?Q?nixM3SmgotoN+2L5GqdMqGn6dUnzwKVWu3YtNt0+lzrXacWyTqMsZSDIRC7n?=
 =?us-ascii?Q?YRBq7l0MPDTAnaor2yo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:08:31.4455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca27f47d-306f-41a6-64d9-08de2c347f10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7905
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

From: Mukul Joshi <mukul.joshi@amd.com>

TCP_UTCL0 registers are not per XCD so don't init them on a per
XCD basis.

Fixes: c2e19203140e3 ("drm/amdgpu: Add initial support for gfx v12_1")
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index d7944d6814769..607ec3bf80aa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2509,22 +2509,18 @@ static void gfx_v12_1_xcc_disable_gpa_mode(struct amdgpu_device *adev,
 
 static void gfx_v12_1_init_golden_registers(struct amdgpu_device *adev)
 {
-	int i, num_xcc;
 	uint32_t val;
 
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	for (i = 0; i < num_xcc; i++) {
-		/* Setup the TCP Thrashing control register */
-		val = RREG32_SOC15(GC, GET_INST(GC, i), regTCP_UTCL0_THRASHING_CTRL);
+	/* Setup the TCP Thrashing control register */
+	val = RREG32_SOC15(GC, 0, regTCP_UTCL0_THRASHING_CTRL);
 
-		val = REG_SET_FIELD(val, TCP_UTCL0_THRASHING_CTRL, THRASHING_EN, 0x2);
-		val = REG_SET_FIELD(val, TCP_UTCL0_THRASHING_CTRL,
-					RETRY_FRAGMENT_THRESHOLD_DOWN_EN, 0x0);
-		val = REG_SET_FIELD(val, TCP_UTCL0_THRASHING_CTRL,
-					RETRY_FRAGMENT_THRESHOLD_UP_EN, 0x0);
+	val = REG_SET_FIELD(val, TCP_UTCL0_THRASHING_CTRL, THRASHING_EN, 0x2);
+	val = REG_SET_FIELD(val, TCP_UTCL0_THRASHING_CTRL,
+				RETRY_FRAGMENT_THRESHOLD_DOWN_EN, 0x0);
+	val = REG_SET_FIELD(val, TCP_UTCL0_THRASHING_CTRL,
+				RETRY_FRAGMENT_THRESHOLD_UP_EN, 0x0);
 
-		WREG32_SOC15(GC, GET_INST(GC, i), regTCP_UTCL0_THRASHING_CTRL, val);
-	}
+	WREG32_SOC15(GC, 0, regTCP_UTCL0_THRASHING_CTRL, val);
 }
 
 static int gfx_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
-- 
2.51.1

