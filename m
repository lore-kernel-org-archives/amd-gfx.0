Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C23E69E98
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 21:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F3410E86F;
	Mon,  2 Dec 2024 21:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h4+nzWBy";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C55810E86F
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 21:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPyBwjuVkWY77HkAlak4XlDeJC7g9z2h49Ho3GQzTI4sd2PifgICfY+3KxcQyaGP0HyWmOKzQSWZIv4n01413ZScamNOwGVxvIgBOrI4qgf3FVhs6JK4I+drCn1U5oTPMvLM0hOHhg79ewlA0nknr9+036tX0QjZo0GPsMC7zQKTUOUhFX8iPiUvKToiUzo7Dn6a6gRFNgjj47UUAkGIcUfJnv1agIUrS+Ckyw2Ws0Gs2y1uVGfzgwOYN7VBeRtE3hgDkhsomsK3fMudZ8FvsKVjsMS8wamGz+6pLqhkZ0s1+bFOotPHz5qBayv7fw+1vZUulJLOUK5tX9xNh7Sc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ln7tbV6WVodvGTyN11YfWUfrBVDpJqOQyCmAh4+Pk8=;
 b=CIZe9ydIHTvqrt3E6jpkGUgjljR5637ZrPUOaa1Xnof0L4R4EAa1Z+0Z8kgtqUGe4C6ZS3FJar8Vg3MXh6b9j6uf7/KajMjHkIbM/vHCAwIAxv7TDJUQBrT0mkm9kg2Rw2+yR25MfJJcAid8I6g7FW4r4sYZfmNMgNL6BnNXH1hrxkHZa1q07VSAflMoVtm87kSD5hJSs9qqOBzWJ7jgTmH5pKyIpb8bLBAlIu5lgqNmk8Wc71Gm2lkJ8ViX+cePSME23mgnsbClEhEz9SkcGgDHoQ/1vyRaU6cJ3sS0CtJhEKLQ/C8lq5WYRneCVxUTMJ5iRwhVioGGi1tj4Q6/Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ln7tbV6WVodvGTyN11YfWUfrBVDpJqOQyCmAh4+Pk8=;
 b=h4+nzWBy7fvJk7HTqEDlFavTl4bHSyBx9tWnudM+PdI/om4EK7t5989wg0Hb3yfDBfkHTm5CXPCzlH/sA2XurpRgjhKjeOWaNxTwNjEZhzooofFpDps9bKhZz6f8oafw/huf7ClSb6sCvpfMcbM/MSl24pFLi/rO7ud8q2XTrzg=
Received: from DS7PR03CA0179.namprd03.prod.outlook.com (2603:10b6:5:3b2::34)
 by CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 21:50:20 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::59) by DS7PR03CA0179.outlook.office365.com
 (2603:10b6:5:3b2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 21:50:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 21:50:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 15:50:14 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Asad Kamal <asad.kamal@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/11] drm/amdgpu: Apply gc v9_5_0 golden settings
Date: Mon, 2 Dec 2024 16:49:47 -0500
Message-ID: <20241202214952.1125211-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202214952.1125211-1-alexander.deucher@amd.com>
References: <20241202214952.1125211-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|CY8PR12MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: d429d064-9fb4-4f57-95ee-08dd131b5103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wi9Zcu5btyd+Z0grsSZjDWsLI/AWSHssKiWsID6sRxyEcTpnOo6TE8ceoCdx?=
 =?us-ascii?Q?rwLNtdjigKLOk2Zcc4GJjJ3r1q5wfErJU80/GGXhM+fGV4maqtxnWcs6pC5P?=
 =?us-ascii?Q?Q5XtmzyW0v1jPSaaPyD+wuNaN/H0za+EvWKufEJ08cB3tTtLKMY7je/PrhC4?=
 =?us-ascii?Q?PnHPfCVm71GfRjb5bWhbUvMZ1U/3tA/+isqD47VNoOMSyL2Yjo81Ycgckm3O?=
 =?us-ascii?Q?tjpXB0VeAfIsDtNaxfG4R39nrBuTcxo2clkNhz5GEDkmvPID4ogcCLGLrR5p?=
 =?us-ascii?Q?8bIXHWCg4agLwELDkKq5phZgblTrp8nrKA8yXKvwWY9ws9Wy3q0HjXTm1kCL?=
 =?us-ascii?Q?FIO/mlbHNswCvyq0zuaGUc50IxRBLx26V3YhroEDzVRVYn+lHnaWy2fuelrW?=
 =?us-ascii?Q?Bk/gYc5Q8J7Jiks+mq6ZzPpDDxDLWE28szPqYiPYAt5DM/k5EdRxg+lM+9Fe?=
 =?us-ascii?Q?sh/ajh5ZDLK6FoAul9VX0ohgOSeNZYul26Ht2xwc9atLQohWNMbrcJMlIv2v?=
 =?us-ascii?Q?vvwiX1i7anfh3wsqE9L145H0rXMScoo997bNrTEH/XDy4oDIvCxy4bsYC+4u?=
 =?us-ascii?Q?ylycbfVzN4KSqGDsUXo2HlQyMHyTrji5qnQhL0TECLkK2m6PavY4M+3D8uVG?=
 =?us-ascii?Q?/jxMgVct12X0Cq13uIBhke8XtE88Yq5NGTJkWU+OdaDhwNxa0QQw9JYAvweS?=
 =?us-ascii?Q?3H8rX3dc5qV14uCi0SnoWX7ctFIjW+9eACs+sF0wh5WhFdvMkhbo4lgJ/b1z?=
 =?us-ascii?Q?GM5iD3z4f4ZmDg+gmJjnrfes0NjeZKY/Vvdxkltx1/wH6LkJWXlO0Kl2xm8L?=
 =?us-ascii?Q?yob08qCpoBSUFJAbe8HOipQMokyvAqYXoDDAR2XJEfgVFOZAC1seQAg3G7x6?=
 =?us-ascii?Q?ftoXJnBOy/viBe0oX9VXqzdPpAVqPyRZ36Bl2rMFN9a/iQ7LU3JSuST0F71S?=
 =?us-ascii?Q?8bHvV1Mt4bGqJF0h3pPrIPTD6Z9tLZ7T6hsOfmhlEhaZrykAgBO4PHsg/z+C?=
 =?us-ascii?Q?ZoFbcECaS6ON03RFJ8jfM10XjBdpezJRxnFWnKENyewgQkqSEuViSr9furj7?=
 =?us-ascii?Q?zBTa7vSh/8L6dbBkpIcnzJYMShpPdGwPg2y2UinqzmLW4gjrNKWWrNukSpSb?=
 =?us-ascii?Q?44AxDary+MD0V5F4hxqCvOg05zc3DstEgG9I1nDIwjFpjdnuzXdzxgjlDeDZ?=
 =?us-ascii?Q?L2s8zP8xiverD3sB05k/cwVi0BlyGu04LCMWEyhlyVGXnsIQDmaWMTz+0Dfr?=
 =?us-ascii?Q?BJtAU5RiyQbEU9Bf5VYPEiFLhyDmCrw+t2Ew5lx/sY/6YSvr9M1fvMNJFtkR?=
 =?us-ascii?Q?VNbphwLscji33Db/wVV92z+dQFWsHQ1JHfy3eU05bbbcf4xM7PvxEm6hf+sf?=
 =?us-ascii?Q?mbVHmW8NiNrMephQ5X/cbuxJQZ8oMIt8KXdGovIIzjr+qNQAMD3R6TnHGL5N?=
 =?us-ascii?Q?Yhrig8NZV4BtHPqAiFoNfbzfOfSzvMT5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 21:50:19.9618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d429d064-9fb4-4f57-95ee-08dd131b5103
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Apply gc v9_5_0 golden settings.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index b755de502da5c..d703bb7e5f460 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -351,13 +351,17 @@ static void gfx_v9_4_3_init_golden_registers(struct amdgpu_device *adev)
 
 		WREG32_SOC15(GC, dev_inst, regGB_ADDR_CONFIG,
 			     GOLDEN_GB_ADDR_CONFIG);
-		/* Golden settings applied by driver for ASIC with rev_id 0 */
-		if (adev->rev_id == 0) {
-			WREG32_FIELD15_PREREG(GC, dev_inst, TCP_UTCL1_CNTL1,
-					      REDUCE_FIFO_DEPTH_BY_2, 2);
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)) {
+			WREG32_FIELD15_PREREG(GC, dev_inst, TCP_UTCL1_CNTL2, SPARE, 0x1);
 		} else {
-			WREG32_FIELD15_PREREG(GC, dev_inst, TCP_UTCL1_CNTL2,
-						SPARE, 0x1);
+			/* Golden settings applied by driver for ASIC with rev_id 0 */
+			if (adev->rev_id == 0) {
+				WREG32_FIELD15_PREREG(GC, dev_inst, TCP_UTCL1_CNTL1,
+						      REDUCE_FIFO_DEPTH_BY_2, 2);
+			} else {
+				WREG32_FIELD15_PREREG(GC, dev_inst, TCP_UTCL1_CNTL2,
+						      SPARE, 0x1);
+			}
 		}
 	}
 }
-- 
2.47.0

