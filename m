Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FBDD637AE
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C39610E856;
	Tue, 16 Dec 2025 21:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EwgC31O5";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012062.outbound.protection.outlook.com
 [40.107.200.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71ACF10E883
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o24KdSojH/Tvowd2pN8gAhQwJFXCL0dLaJxiiO9NTMZ5G/1j12D6Kk5WbTD1XxUEw918SEmvbIAqIxGW/zWMDmDnQinlyV7NW/LLDAGPhlXfhSIIeAPXiXQbbfqVxRNzP+FWVOk5nwEQvgVgY6hTJMhRgdvE2oN8zYlwGPlSXS7L4d7ozwOvQKcwVCfoXbztguPtxAQkUAR2Wu0hT4uAeSNgINEYEvvonOiSRggCShio/NJdO96m1GMoeQIiHrO6Fkq8gX9+1MSDkXobcItWabwzQ/JA3tMm1kYznTm86gt0gZixi8toSF4VnYpYWH6kGVYvARj9AbqCk3cHrJ6dVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSX5IoE7eeJwE42z45/nPVGj4CpZYBdZ2wrnusd+Bek=;
 b=X3LAus2fOISqNzxN0YYse1b8n1rh4hsXoi01X+2vyLLz5r++IAKyG+OirZ0VnD56RuuHk/eK3swUmowogSav1mDpBkQJHlRpY6MJjaNjc4F8rp2I6rIma91FjB21uKv/gMKe/hXHnODw0+1kIsUTuC3wHb1tE+7RgGJyeIMy6iMh6CKuUzra2q7KExqD3cdAaSC7P6yW1T8UPu4SjbLQeWkhk6Gu8XNVgrp7h0qEEtYpDQUIeQn5XUglMwc5dn+QSYpsRUwt/bGytVHdq2WYqrJxiynCEouinXHun8Nw0LMrih8P1gkTFwZBlw6BX2qRsn3oxGshFgfQwRnv3+ZpYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSX5IoE7eeJwE42z45/nPVGj4CpZYBdZ2wrnusd+Bek=;
 b=EwgC31O56/uCVebs5nQ6u/HqxxpRbCieV1zHWZHCNEVEWKx8Wq+ph8u8nXs6sgyyK3IJcNowEhv3eE2XU/URAvQ7fz3s7FOcUx0pHCNr425BIOIPLs7ORUz04Sd2Xtx2iyc066RnLgDXqdAMbNHRkn86oH/lsYWRS32CKOHTRUU=
Received: from BL1P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::24)
 by SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 21:04:09 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::ea) by BL1P223CA0019.outlook.office365.com
 (2603:10b6:208:2c4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 21:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:09 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jonathan Kim <jonathan.kim@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: fix partitioned gfx12 address watch enablement
Date: Tue, 16 Dec 2025 16:03:34 -0500
Message-ID: <20251216210349.1963466-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SA1PR12MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: c414fcb5-0835-4cda-0935-08de3ce6a83f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ahwO/fJp1DQOpK2Gv0+nS/wj4FzBCmFHYrrVRGQaqfRbzD5rQ8sZTbTxE2pK?=
 =?us-ascii?Q?MMJFIzYyBCcA54RIqPdpRgQnvO/++7WYLumlsO3NYsERe8RUFbBkKlOB8flq?=
 =?us-ascii?Q?xUVzzOZYnGOq+AAbPE2X/RX0ocLDwjM1YSdSY2dP/54CuTkqx8dyrcvTQ5zK?=
 =?us-ascii?Q?jD4CtwEFo+9pOboAoVgxEexctZuNr3u+khlBShUxXZY5obu6iwWSOI9yEwHR?=
 =?us-ascii?Q?+N4r81QlP/1bT2pLR1kueeKRou3xMB/Ob3/FGh0EuKeqwrT1n7SJUfsApMTJ?=
 =?us-ascii?Q?z2+BpfjtnBMjRaOsHC5u9qDIOO9OnWP6ptgxI8vpNf+SZY+mnWUHiJleaC4k?=
 =?us-ascii?Q?C5C5oobkEeugsfIbUoU6yTmv2juPQR5LeJDv2bQpnZJ7UpLgfUAYtItiKOdI?=
 =?us-ascii?Q?f+wCqH3k2KW+IRnRn2W8CBgeWoZkEqLIeZWJH4NH/862UvcP5tkB7uFQ3GGa?=
 =?us-ascii?Q?T8fQs6BhONaxGbacBkHE3stnI5KaR7B0ieJsLewXkOe99hmMiM/WB1y1ZvZD?=
 =?us-ascii?Q?XMWScoZIovK5eyimr4ziD6goq/RKOCnh3c7d7QjB3YxZrQc5FKe6P/gUCJfe?=
 =?us-ascii?Q?82Si17IpZnOT7I6ZGUjQflY6J2CEo56UaEhlyy1hOSrunFl5mgOztdrJ/u3E?=
 =?us-ascii?Q?u907dS8L0dQaKEv0xlFBPhGqmzHav4rceIw8wr7G3hrdR37Y7ZbIcNh8E5y1?=
 =?us-ascii?Q?wHMft7OOn8HamqIpzNRalxqjsAD9X767Qk3vEap4k7rw6sSceVF5ym6vXW5F?=
 =?us-ascii?Q?ZkhKpEUF+1FpOG1fA1UxUXOi+1KwhZuWx+Ob+0UaGbAZDXnkk/vQLPBx77NA?=
 =?us-ascii?Q?1PzmXmLqJwm4FhV159pAG61ijmglhQP99LsOFzkY0Y4R8I8iMk/wLChzenyT?=
 =?us-ascii?Q?DjXalH4g31TM0rR9MO3Rc15hhj8VXud0D4vdtPGiyXo22eRRNIKPqzv9XOgw?=
 =?us-ascii?Q?2c6YMSWZ59KV4ZcH/08B/AdGjqgJKVEAkdR28UV5Gn+G6Oj0HwTXqZ0vL2kV?=
 =?us-ascii?Q?aWZHosVqfnUDKEnOdJshjGn1RSrSZP3ED5UiiRtku7wveZmnYrGQHEFol1g9?=
 =?us-ascii?Q?gH8vSd5ZpghH/tfgJlh3n2XxzQa++vwwmvfo/cyOxDa5P5faR9UbyrLuCg+E?=
 =?us-ascii?Q?EPxduBeipBArci/Gu26TEIhelWjDQpdt6W19P9Ahh+ygM/1WfFS0KV061wkv?=
 =?us-ascii?Q?aSbjpXiGtaj03/+Uc3eEiIRT4Maoza7ihONLJiiftewRLOUUqN61XMZ47rDg?=
 =?us-ascii?Q?iY9x2bC7cEo4689Lg5eYcveEiH5ZuXzZqSj/vVvho6xdwglftySpORCtpwkU?=
 =?us-ascii?Q?2jG3xSWz1VnfFUhMdCTmz+syQvFVKII+Adc0yOsbWUCW2XE7A40nuM39UTqC?=
 =?us-ascii?Q?6iVH+prDOIgwC8TH/YCT2jnH70pCKhOSgnW9E3WzZP7/9KF7HubQLuNTndvy?=
 =?us-ascii?Q?j56xKdd2DFKJMc+Xj49Wibf+mW2wZB7x4QJSuQY1JeUO5HGdf04lQ7ngs3GZ?=
 =?us-ascii?Q?4hpc5gfvbyFazxlYSgjzDaOZ+Y95JjV0W5wy1/OuYmdVltk7biBHVPvghCH/?=
 =?us-ascii?Q?fiygjAZ+wnB1FvWeq6k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:09.5601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c414fcb5-0835-4cda-0935-08de3ce6a83f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847
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

From: Jonathan Kim <jonathan.kim@amd.com>

GFX 12 devices that support spatial partitioning should use the WREG32
per XCC macro when updating address watch settings, similar to GFX 9
devices that support spatial partitioning.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
index 14e4c60b9d79e..965c7e688535a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
@@ -347,13 +347,13 @@ static uint32_t kgd_gfx_v12_1_set_address_watch(struct amdgpu_device *adev,
 			VALID,
 			1);
 
-	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regTCP_WATCH0_ADDR_H) +
+	WREG32_XCC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regTCP_WATCH0_ADDR_H) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_high);
+			watch_address_high, inst);
 
-	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regTCP_WATCH0_ADDR_L) +
+	WREG32_XCC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regTCP_WATCH0_ADDR_L) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_low);
+			watch_address_low, inst);
 
 	return watch_address_cntl;
 }
-- 
2.52.0

