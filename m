Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27664C5DF86
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC7210ECCB;
	Tue, 18 Aug 2026 20:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GPCSdjGt";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010045.outbound.protection.outlook.com
 [40.93.198.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F03A610ECBF
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1yOCQmzIAUuDfcUWEMAg3TOmESTWma/WYepSlGg8PB/TAgcGyC9SmmAyLqWtPygQa1/Wajp/DYlWac+DCbpmk6/z/YZKJdAfVAh9v0uh1CE9BLn/nobMehS49DGqIvSbgXFHFrZm1h8dh3AilzLRR7ZxT8GHP5ipeSBp63XXxc2mJnSX8ja8gCxayZ66LBXuHsR9twQrOinA9q8TTx4UC/JrNQ97QS1lOKr26jpuCl9cClpAtFfu/S0mFYJ329LBuB0Y1WKxQ1/O/aZRGlfhSLpIUXyITeCGwXbzwTAUptmOuY7wdMNmA8CHeNWNnBAMUkHyxsvo8JZgYFGJzGweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsDQqwetcIJa//M6ltMgRQdNzi5MjpMOpec/0TEPFP4=;
 b=wzF2qE6bLK9ihhooKtVLLSINWUAY47FBF5kdNzqNPrK9z9X1FJFSRr0mXwDZfDxtTgewDlLyM6nwWsFtwdoJT26p5dIT8u9JDZKKMVu7OYipiJo3r9gqbIH4YM16CQc6n9zDHgVHHWy6h9EY8ykCQnyCUfVYf/oCZU4UJ/PwX4jTgJiyodQR/WT6N3a7PYLyl33xmLhoXxAdhBmbv2K+cGxM6AYRT94re0r9bMQX/RIuB9++Ux+HpJZOjdvZBAwF1vfP1vUlkm3AnC9mQBgGp3SFFdLA/5d0zV6a/+rD+GiMy1E8dTuRfFYWIj3ioTE8Qb2Q9+UELV0azxoeLWsp0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsDQqwetcIJa//M6ltMgRQdNzi5MjpMOpec/0TEPFP4=;
 b=GPCSdjGtKpvDUB0CDqUxvv2h1PNlVskl+e3Kz/05fTbjQdFiuVK73m96NaOMVzalU2vzWK7ynZoRT92kzJCcQ3bUT/qyIctytSmm3TdHLVVTQCXemZlbjaml8kcyr/ahIVA6/lktS7g8gRXrSbpYi0pfIqTcVZoUUNlPV5uoSaE=
Received: from BN9PR03CA0570.namprd03.prod.outlook.com (2603:10b6:408:138::35)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:42 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::1b) by BN9PR03CA0570.outlook.office365.com
 (2603:10b6:408:138::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:31 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:30 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:30 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Rafal Ostrowski <rafal.ostrowski@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Sridevi Arvindekar
 <sridevi.arvindekar@amd.com>
Subject: [PATCH 52/82] drm/amd/display: Remove RMCM tetrahedral cube from
 dc_plane_state
Date: Tue, 18 Aug 2026 16:15:44 -0400
Message-ID: <20260818202139.4172592-53-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fecccac-f14a-4a36-4dc9-08defd667527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: Wnzgsa9amNFeMHGioJlz6aFjdWyV8A55vWNF/FzJ2S9XD50f4uOH0Co2OBoU56QmE9XvvIpTKZDRf8xvj/ESNeFzOQ8lmea0otqMaSKH2m9Gg0V0DFXfXn/pQjpY3UL2gbZxn6zHv4pr7BhY/t7kM6VXkWf6rRu7ekMYckkAcoJd+CfBIrTMMMfNKtd6TLcBou7I50J6Ijv4tZPYpgjSrTCCDmgeN08/8Xj+HN/rNNY+oSvtUIaqDbGRrkpn1i5OwOOqfGVIvQmeBSki0d8vCSVeMSAwEZNtBWWtu/rzcESGLo1xjAtSGsO9LmaxmSko6miMNuoT8xwIbFHqVcrFv5kvoPvkVrHCMoixyh0YVxjfOPQCY7deB0oAVgr9Tzt43GR0/fwwXOv3OBo31b1l8VyEddx7W1AniJXHjzg/yLvMpc0j5vilNK8IZBXL/f/VRX5WdLLSVVkiydSjmLDq7ADfAeOwtH3dX5GmI1JnqfaQFoTdUYCz/I2/XYoJyrUnyPzhSEzCWCNQJzEiDZcTFPUcRVVN/oQrb4425+HQfJHHEv7vJeZ3WS+Y6+U6/VgNH573WbrZCjSndkfsqMWX5bodUi/NdmAi0JIffHCKyM92gxeR7m0R1h0J0BYyECpv8tYcYyCMwR16nq5xD38PuWhLwN49g3S87eNQn74XgBFNYiPpTO/hEmyY2ehPgSH575rnO5vypn5+kAWeCXQRoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JrZkJ0XkOH0haM1EaZLnkuPi5WpDr6gz/x2Dv5mQ2ZkJpy/JLTPepFVvC0jW/9qgQscKD4kDFxac3G0d5e0+pVTFeEiLzFrMriIZIJm8TnuB73ZFPtoYbr5mXmjvS2MWnLQCs4Nnv6NhzclQx6S/oqkld1Ln/bewBfxAAlKgge27KXafgVNBmqcccT3kmfGqIUaOUqNA2+8JmdqnR9gqeHThPfgfBYvvSKNxkwK+ZnyloeEhTsKs/T3CFoWOsS1xbJ58/iKrBd2sKDxFQtkXIEbtFezjqvsqfIz1qk6yfK57tK4BnhAN3gGfdn8bb4Cw75mGcQj2/ZeW9a2dag1N90Gaef4UFPxQbwMqsLnj9zI32MGHTCojqDPXojM8yW3MzXYMg9tp7U7AktssKUMo4CiTRSPRZ5mODArfPp8C+JqyJa+LPi2IajWJui+csFAh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:42.6754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fecccac-f14a-4a36-4dc9-08defd667527
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
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

From: Rafal Ostrowski <rafal.ostrowski@amd.com>

[Why&How]
MCM and RMCM both took their cube from struct tetrahedral_params, which is
embedded by value in dc_3dlut and therefore in dc_plane_state and
dc.scratch. RMCM needs a 33x33x33 cube, but that cube is ~421KB, so
enabling it in the shared union - where tetrahedral_33 was left commented
out - would push sizeof(struct dc) past the kmalloc MAX_PAGE_ORDER limit
and break kunit and other allocations.
Drop the unused struct tetrahedral_33x33x33 definition and lut_dim.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index 176d048a64e70..6109d22e10938 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -153,13 +153,6 @@ struct dc_rgb {
 	uint32_t blue;
 };
 
-struct tetrahedral_33x33x33 {
-	struct dc_rgb lut0[8985];
-	struct dc_rgb lut1[8984];
-	struct dc_rgb lut2[8984];
-	struct dc_rgb lut3[8984];
-};
-
 struct tetrahedral_17x17x17 {
 	struct dc_rgb lut0[1229];
 	struct dc_rgb lut1[1228];
@@ -182,14 +175,11 @@ enum lut_dimension {
 
 struct tetrahedral_params {
 	union {
-//TODO: Uncomment when in use.
-//		struct tetrahedral_33x33x33 tetrahedral_33;
 		struct tetrahedral_17x17x17 tetrahedral_17;
 		struct tetrahedral_9x9x9 tetrahedral_9;
 	};
 	bool use_tetrahedral_9;
 	bool use_12bits;
-	enum lut_dimension lut_dim;
 };
 
 /* arr_curve_points - regamma regions/segments specification
-- 
2.43.0

