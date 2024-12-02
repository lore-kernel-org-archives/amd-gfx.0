Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43D1E69E98
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 21:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC5510E860;
	Mon,  2 Dec 2024 21:50:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nFt3n/PF";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 492FC10E860
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 21:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxYxFpmsSbUugCOZMxxknssx8M6kjCJVV7Vas/GenXW+2Q81Etg1pWT/Kvn88LjXne5oedP8jKYTBOpNne+gYCNjXj0mUmdTHier7k6+Ru1m37uUtJUH4sWJO1abrOwGCol/v9J3m/vMbD1M8T+1drTTHsBe4ADUyk3hkD4NhaqRJeMlbVH0okGKIiSe5nd3rcwUYb1m58efkoG9C/6kpyycLCQxza+ZmB9rrkcg+rAjaM7yf5m8uFDFTir2qwvG4Sc3mlfPcUMqq2n7tdZfSW6eug4lazxDNGY1/r56Bh00L1i77dT5R+6ujTUMdBEaiU+2cMJvRolpBgxDpjLkWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SNu831OrTcNKJlremWCUS5tzD98H2fEfT9ap2l+6fo=;
 b=CfzCOIAPAqGMEAgMQ9fUSjjTPhgrfqu4Oa+F461p5jd43qYGOl9iCgjkmwcMEsK/aYKByRue2YzI17sVBzj8g2fWaRLGasRQNcRoRys6Mt4oSyPbXx5apI1W+9aUVWhwTIwtzsnivHaG0s4fqhVKZwAmWd/Z7+rWPmIueNRVqpPslJwu+UZBJ4TVu4OrrZucNNZxrpRyanzgUXM2l+qooz2oBx7EF1zLJ+0UQh0c9d7R4J10p9Lk5FgpztOoBLFvfLHv8R0A12IdMw97MpbjzMxLYmq36cV/YRyuJKfzkJ1JZsbaeIL0Z6IaKoLiGpVqkmEEuaRPt0K9A9jfad4WAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SNu831OrTcNKJlremWCUS5tzD98H2fEfT9ap2l+6fo=;
 b=nFt3n/PFg8H/Abf9LzNoVA3O8ge6UytrULSlgzkU04tzd+Zch2M3yavAOtDeuR81TwG12rk6kUm3iiNdDpD9RsBF5A62SxzDm7/GTLv8mOl+kPfdu1TSgII+Y4Q+620CyoNUYNtozlibNowqRJ1K2O5rFERAiOMwGWoKeZyH6xE=
Received: from MN2PR15CA0049.namprd15.prod.outlook.com (2603:10b6:208:237::18)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 21:50:13 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::d4) by MN2PR15CA0049.outlook.office365.com
 (2603:10b6:208:237::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 21:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 21:50:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 15:50:11 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 02/11] drm/amdgpu/gfx: add gfx950 microcode
Date: Mon, 2 Dec 2024 16:49:43 -0500
Message-ID: <20241202214952.1125211-2-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: bca33537-fed8-4e6d-8633-08dd131b4cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IMet0c5ZZ/g+2fgbKtBlRZ2OrxgEJGeIbWm5N7AF3sJWOxuyvfMLDV0FglQD?=
 =?us-ascii?Q?gRLf9SatGSofQJ+yDO3Lvzek+Uo6JkeKa269HRZkpSPkrjAsIVCVYquFHXKk?=
 =?us-ascii?Q?NmRXOgEh3hvVD0AN/SsuTv1BpcK+qsmuw0rmcx2YzZPPpl91hyd3Pj4FxJ3g?=
 =?us-ascii?Q?qg06CDGGyBk/YARLpLIEOPdQgU+Q2XcObaL5ezaIOlVJMPtp/O7OMFNjCeyO?=
 =?us-ascii?Q?EhjKHzWou7oXVC7fmhic05t3BI0BBfQNhTai6vexxkv9HT6m+prqhmu/Ypxb?=
 =?us-ascii?Q?6G8091k+18sFgQs/AuHVBmxvkITMNPwO/xEtt4kLqHm9MB24aeJCAshzKJwZ?=
 =?us-ascii?Q?o6mbDamwEqkmzHH2r2Tv/UjupCV8U/9LJ6Lc63CEjaZWY3pTaTyHDGEX16bB?=
 =?us-ascii?Q?AMjwxTtnLB4H6MFjRz4rFQcd/3HFN+DNM2XJMpCOg62tCidqr6PcYqX+sAoO?=
 =?us-ascii?Q?WtRi23dTtHkZDx+IUeuynHx/XiuvPaAkAAln+uTZHepaxic1VHwOiUR2KBVQ?=
 =?us-ascii?Q?4ak/DfssuLh3icek/2S0aj4/6Z9V7Wikl1DtxE1jYiWUIlYAYP6g89QJ/xtL?=
 =?us-ascii?Q?iyG3F+IeFDcgPFZRsblM+BQJFwLUwa7OT80XhcDiM+jJdAifaT6h/vzVOaDC?=
 =?us-ascii?Q?MmjWZbEDwRd9VQqbIooJgEWuPLHHmKbIqvvaQo1RMSpzNMVo5fWhEB9nRFI/?=
 =?us-ascii?Q?5r6gm06yn/hdRlcLAEy0C2Fc/F6cbiUtYzAMM8TuZcJ11a9m91Nmfi1k9XpM?=
 =?us-ascii?Q?pJ0Mu3Bo12r3BK/3R5p4OaU8w8DWXWsht16VtE9zS3GcmiMn/PUvyDFbFZ8i?=
 =?us-ascii?Q?wzIyp/VimXwCPGHAsxtOpg/poY0Ea3KwHhD1cEm/S8Cva7QjTxJQDX0AngJ1?=
 =?us-ascii?Q?xnNxvq55GuRr3K5wE++mc4wVJoto/pLQyl+IXKhrgRdmkca/scweLstolxdg?=
 =?us-ascii?Q?qlP+0BDZHeADtMyKiNMTwLSbpUyUgdeGRuXIwRTGj1VovsFcrQGDW4S6u30u?=
 =?us-ascii?Q?RdlJNdZGEX5IDvobH/i8BdvdFphKXSSMgkw9vtrIbpmANoYI7VQLaNZnjpVE?=
 =?us-ascii?Q?swRiNeH8ZqieMBnipICPb/yY8MtAVcLJ3g0RqHuNmt0Gvf3QH/tdb2WiAKCt?=
 =?us-ascii?Q?3womvOGUoDlgr8PIR8lNYgFmZanhoX1j3jg/PY3z7hZu7rW+eDIv287neBUl?=
 =?us-ascii?Q?Y04wSyaz3FFzdx+ceBfBak9MhuCkjgpHwEYsHq+b7C7fNfwfUxzyGxO9KA21?=
 =?us-ascii?Q?3GCvmptAGjx5eZkPD1QwTNNm/gMAJRzgqCnNy3+M+zm5MTAAm6PB39X2ZPDV?=
 =?us-ascii?Q?sAQQeVSqqRLq/vSKryiE/YJgI9GBW8TAP7aQDGPpEAuMKBMkJPA3QEVBQ9ur?=
 =?us-ascii?Q?ifHetU1zRyY0UCRIBkWRv65/RplP4GJUntu9g+GoxDvrehbLivo1Z4awX1S5?=
 =?us-ascii?Q?jpPk7+KgTF+rCNfpZ7umTXX2cPltIHGV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 21:50:12.9042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bca33537-fed8-4e6d-8633-08dd131b4cc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
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

From: Le Ma <le.ma@amd.com>

Add firmware declarations.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index f23df55d72fd8..15689ca219757 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -43,8 +43,10 @@
 
 MODULE_FIRMWARE("amdgpu/gc_9_4_3_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_4_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_9_5_0_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_4_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_9_5_0_rlc.bin");
 
 #define GFX9_MEC_HPD_SIZE 4096
 #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
-- 
2.47.0

