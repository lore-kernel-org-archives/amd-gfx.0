Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E55C25B75
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 08:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 748ED10E14D;
	Thu,  9 May 2024 08:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gRHP8Lal";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3547010E14D
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 08:59:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XItql5CPieN+QO1mv0Cobj5H5DscJB4yFD/SL/M/x4qeK5FMd4RPUbQJ/YvwpE4SJqbZsbrP23TZI4/Ej/6Xwzt7KPsD+8M4oTAGbormiNKPJIl43OzTvO6r+qIV44OwKfvPRbrTF8HhFkC7NX5CnBTmfva/Ccq0IsISlPFfxBVp9QLC0c0H1yWFoaOzeduEaDC79fnB7Ef8d8cqc+WByXVMxmr148zHmFrnJUlcgJj2ZqPclBZdZ25Dm7L/aRbnPDB+fF/AizaY6n9NFI5kdHSrQ4y/h76+Dy0Q/LNC7SK5bgmxtxMKTxy5imnEsYp44jWroeDaK3PoOmfyBRDEYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SF183SB1sjvsSfnxfPdDF2BPKNDCKTf0hvn76bVr3Fg=;
 b=VFWqh0MUrq0iACjYc6/QVHZQv5sOreIGi0ny++2Fx3cU871pLY8aRslFAoUVnE29xAAm3iActTo1Z/3PicSf+U0KiYAaJDPBNFvZ8zwt1Sdes5jvMnR7EjmNBRuW37X2DW1BSCLRYt+iwv3g4DEqqOPwoQSoiUhyyDe5us0IDKkudqz0FIX2VqjRYocv280M6EJqniHUhnz96EcPlWwMIN2lfa2OqIdlsMn0fTXpYfB2Xfg34lghnB2FpUwjPPh7KtLQAwmWkNz8QMyl6RVaY1eFcZUvPCabjzRoFdPELvG517FGdniofp2DJQvV7LkNyqHUvSGOYG6npML1TypP1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SF183SB1sjvsSfnxfPdDF2BPKNDCKTf0hvn76bVr3Fg=;
 b=gRHP8LalGQkluOMWTeiOJYuHTxFEWBNgynW5sMPVXSB94oWZF40AV6iutjnporCdNN9mWgS1UcGge0mG9iu3B0/DkDOqdXx2EBrDWo8UTxUMsYp0+vjtxgHwWr9gZFGqZOGHkCABLRQtUrBKozx0Mqn3WeG9SLIf37mMxs6VuLI=
Received: from PA7P264CA0274.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:373::19)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Thu, 9 May
 2024 08:59:46 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10a6:102:373:cafe::81) by PA7P264CA0274.outlook.office365.com
 (2603:10a6:102:373::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Thu, 9 May 2024 08:59:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 08:59:45 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 03:59:43 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Fix aldebaran pcie speed reporting
Date: Thu, 9 May 2024 14:29:25 +0530
Message-ID: <20240509085925.61641-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a873e3-f89e-49db-ffb8-08dc70065f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TUVm/e54wVw4GCESLYj+HSB4DtyTPPU4ApDCamWRRiW6GlZV9OByDv7SfjMx?=
 =?us-ascii?Q?rbVPrgbvFcQJq3RoMjCyQ+cwCc3EBDdWlnfPjwn4nRGUIT/PwOFZcDK1tZAH?=
 =?us-ascii?Q?hoyt4LEfLSTQz8pOoSqwSYFBJBQSdgAf3Ku2DmjgfqM1E8bpsdwas2T13Il4?=
 =?us-ascii?Q?FE1iuKnJ1hWu/xiTEkoEgxPeZn5xpyco9TLZRi8BfUbR0NVogBhTSxXj2wQ7?=
 =?us-ascii?Q?PeU6thHseuLEMkHJLmzfJteC3q/18h+4Q1R8Pj9m5uP5dz47QJePUoLmk/eJ?=
 =?us-ascii?Q?uxUwX80mQTWIChlIYi7d6HXXKYB0esMPlKWV2xvOy0ls/le6bc/30+8KwPd7?=
 =?us-ascii?Q?BEKmlu7eNtQYIT3P2LvVhap597mDcsUuW3OVBhXx9AtWqHM6uVD89bVZMUl+?=
 =?us-ascii?Q?D3xZWXiUdAonMLCkbfJjnKH9Jey57iq80doX3nBdo9GOhzfjTcrHeaWoCmkn?=
 =?us-ascii?Q?sUYP1RQgyzKJYlWP1yJchYjxtMjDS5Gh2ESAmmKRVM3kztJNMSzlOFm0CTp2?=
 =?us-ascii?Q?3LFcRfZHPNtcZZgcKXOc4GVUftpcVPHTXVYcBMTCTaSMSbHpc6T8M5HGcc7F?=
 =?us-ascii?Q?fKGjMRM/rmofij7vcMbgbQiHI0gaiaiUs08Q23/OcV2AvpMGeb894ERZ8nvO?=
 =?us-ascii?Q?oU2gcLBxIzgAFDmLgX8Wg7aR1CQownpubMPAtlOp0TXGy563sviYMXAIpvMr?=
 =?us-ascii?Q?mA38EQQk5GtQjI1KGY4piMT/H/9JEWnz8/F6GlRVWW2LSQfa44pUbtkg5jD7?=
 =?us-ascii?Q?GkBaLI5YHuW+RpzGBuObJOESOMmNPv91GFBitzLQqW03AHwWIk0fN8MHBwGo?=
 =?us-ascii?Q?CVdi0xWLnzVr6E0SIPnfHqj0kxvowq+lYGndAAQJMZqwMYgr/6c36z8pYKRL?=
 =?us-ascii?Q?wkfjSvNcD/UZjWJjRNCSdPqsCtYZ6NDcjxqgKUzJFjBvsUykgazlmHwLJtjf?=
 =?us-ascii?Q?meo4dxPBVlGH+cDHN4256Jh3z9DWpVHcPRP2DlUosUe8ze4pYbSQT8mLgb6v?=
 =?us-ascii?Q?/Rz9cKBrZhJnsviRPOMpLAFkzxrmOtGm7a+N41NnPz9qmK7ZbFjGVwtp2c1l?=
 =?us-ascii?Q?XA+haWFd7uMeNsqSEU17cpLpzNYwewOIq1783BrtiCGKADG3X1VZyU7tAliI?=
 =?us-ascii?Q?Deic6As2YLl6b1eohFEiZ+M4VqfRYhVDa7Z1v07Oc3WQkHNlKxoIVOQy/1T3?=
 =?us-ascii?Q?vBEi+N0ehUrWMe7+JhddoRpwQggj8/v7wUkCZLCwZzqy39lmjRwTpYDQrhAc?=
 =?us-ascii?Q?SewVLPAeBGs6LaDjfzcC2FyYazEUSWbD0Fgi8h9vW29h+6XkPJbYNfq5qD52?=
 =?us-ascii?Q?Ba2LXZPku31VdG627MY8LaXRwA8MkLdYdbNJ5k2LpQVCKsl/7kvxnstVLQ1Y?=
 =?us-ascii?Q?i7UrQOc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 08:59:45.5119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a873e3-f89e-49db-ffb8-08dc70065f98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154
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

Fix the field definitions for LC_CURRENT_DATA_RATE.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Fixes: c05d1c401572 ("drm/amd/swsmu: add aldebaran smu13 ip support")
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0fd25b72a40c..9c0445fa9f9b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -79,8 +79,8 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_10.bin");
 #define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK 0x00000070L
 #define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT 0x4
 #define smnPCIE_LC_SPEED_CNTL			0x11140290
-#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xC000
-#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0xE
+#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xE0
+#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0x5
 
 #define ENABLE_IMU_ARG_GFXOFF_ENABLE		1
 
-- 
2.25.1

