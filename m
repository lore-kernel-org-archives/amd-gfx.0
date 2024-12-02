Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA1FE69E98
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 21:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58E4010E876;
	Mon,  2 Dec 2024 21:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gmyCr+AJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB32410E872
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 21:50:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZ2Zy8xDQBdN4ZB9g8+UqlWR5PSkXeADaEGnQ+9xqgxeu25CYKu5Z2FLjNDFevnX3exT2RzN+RDJXvMKIWl7L5RufKrGlW4H3cb23C3zUlMxwoSJkalb5wDrrmyE02i/doIOwzgS2uip89nFZj7nCEfpDOnYJw50XV6o0RUDKze2E+CAhFFqoqSKucUK4DtMmSo+cNSNAXrbTgpOj4T6+wD26t7sQYkVgtGM1drfxZH6e5+olj8hleuKL5WgR/LCNBzEE9be8OeL08OmQMA8v8dsA5hFIEDtLbb5iTmzAXiQvWUMDW5UMbjgB9F8n93Eo4rJgzWi1SQ2XzrqpL/U6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmvoPSQWjMn3i9E/Df7zXncnznjF3iDI07/owb44RmY=;
 b=IhHSX4AesCJ6d3aRDv0ed3niK9el+7GRjGoC9okI0NbczYqqefQ/u4s1QpyZA+zobFsjSNU8n8k8QCdzFsUsWYLFXLn2qQYK5wbt0lhsyOFKMLjiNARqc+TMxMRrhDKgXadBPcmVlD0xhB5S0gCcaSLcq2chWVenhyZt9WefzOm+epwvmR2RQoRSq+Ocpe1lG4HWVccXEi5cewzKkRavWJktctRSk1jcBBsFZcw//Zxl7kKD+ka7ucv2oskeSfexyDYCdq5sQfrZ341JK379p601XVlPQR00rLJWuWtcidvng0yR8YsUiXuzooMHLMRoi12lFkvJtB1+BXqSvSflZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmvoPSQWjMn3i9E/Df7zXncnznjF3iDI07/owb44RmY=;
 b=gmyCr+AJ/H7/KTAWcBlvoKO2Pkc4iEqhJDF8M0xg61G9qu4LMhD8rmLT2DIKbZEn6kdyfEQY7vVn0/DIlKLA0CmONc9FJ3WMhleQ1Rjh+0XIgtbTLZwLjx1/7pjwlgIHv3iT3b4LXP0eHnigWU9BMbaDx2l0XlztqD3PBDQrbWo=
Received: from DS7PR03CA0166.namprd03.prod.outlook.com (2603:10b6:5:3b2::21)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 21:50:21 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::8d) by DS7PR03CA0166.outlook.office365.com
 (2603:10b6:5:3b2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 21:50:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 21:50:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 15:50:16 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lancelot SIX <lancelot.six@amd.com>, Jay Cornwall <jay.cornwall@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/11] drm/amdkfd: Adjust CWSR trap handler for gfx950
Date: Mon, 2 Dec 2024 16:49:50 -0500
Message-ID: <20241202214952.1125211-9-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 866b010e-9ce6-4e4a-b1b1-08dd131b5202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M5yq1Yw+zOIAXZWmOUHrzIEJEz4OUPlMzIFb10lhib9ucbMHyDFd04KoZZDc?=
 =?us-ascii?Q?czrp8DI1AaL8i+9w5wwBs3fnMz6YZGzVeASfncb7UoB4kCA0ufZKfBea9LhU?=
 =?us-ascii?Q?gdQcMcAyfRV9/G1mrJiua/S63cfpWh+yl9mPgVGfLV6EvpdUXGAPmI1ICh71?=
 =?us-ascii?Q?sU6bwBqADO2K6I2s0AJT7uRGtYrhszrNHRq8tt7V9pxi2lSqpSeoHQu3SXAZ?=
 =?us-ascii?Q?sdySsbC+fQnv9GgKMkH9c06IXzhH697vXOy2Tsx59JOTnOFLnT3+PifX3LMx?=
 =?us-ascii?Q?MzK3qzFjmvfCPuoR6zbhLRzkK06fDuZs1skp2k5bRHw2RudWlYqz25nwoV1Q?=
 =?us-ascii?Q?oAnyQJi1X25q+IrDZfCkkPLMqYrXifc0w9ebI93sVUtIee5yKAFSb1oezTwN?=
 =?us-ascii?Q?seHQnkhINtMn2n2ytslJERExWNZklBNVlllcj/OCXjR+MToUhpNxB2ffYg9S?=
 =?us-ascii?Q?zzfP4Qze0oZ0FFKfF5/DuVErJdpNJjheI3Rim+CHQsAEAMgHG5Wm4NgXgeNX?=
 =?us-ascii?Q?zZbHv6WIOjVpIkwctx+cZ3FLB6tSnGgF/1dHjdgAHNscTU5w/jT0qEtGRISP?=
 =?us-ascii?Q?TiyWUMlfzQ5MGiW6Mgk6n9pi7AxAJt/m16VM84D97TW5lt/i/AVAGU6bDEEE?=
 =?us-ascii?Q?+1y8PINM5qzskYhmqLdHG/b+z8H1F7vvnseWPSGfZ/g3URrllsL5RFSTAG8s?=
 =?us-ascii?Q?B5YnrO4p6jHMRQuD+0DLC+WFgf94eRcz/Sw8sRo8rBZi8IqUNAQvuJ1M93c/?=
 =?us-ascii?Q?AQDmwHER8H8Y3urMXgjXx5aYa+CC9twBKK+9cCfSAN9+82OgOLVlQsUu25vo?=
 =?us-ascii?Q?Cpz8i6+7WihLldsQUfq6TS+RDvqcCcndB9mgm4AypRwJYqAb4YJ4YFe+xOui?=
 =?us-ascii?Q?6cpUFtrG/NslEd+nV7fIDIv4H2CEtkYq+Z+3GKlEuCP9YzOFEfhM94DysCT2?=
 =?us-ascii?Q?gx7tlTHYajPCC4J4gKIziMCBFSXGHhvw9UEL+4WjoEKbdketcVhkYWqFemK+?=
 =?us-ascii?Q?h6CotAu+nh8Fe+rj3T0OvYs2WBO9sL2E8cxqkR512ZKs8LypIvpJogErMbEx?=
 =?us-ascii?Q?7mtYRsxFVl6AIC/v/aF2+rhmfrskvlBvjNMY9kXkGvyRSuFB2JgW80Ra3Uo8?=
 =?us-ascii?Q?I9wyxMa/sF3o7RBzoEu2aeT6bedCI+Esc2rNCaX6W38l48/NsHPXe1R72RUf?=
 =?us-ascii?Q?kWWYWFKBfgvwSr5JwSFceDYzARBfL3Jk+rtZF/TAdr6KxY2VIvajQPVnLuPv?=
 =?us-ascii?Q?1j8fhaPot7CIcpL3Ai4V8VFII/voSDwvqm89zMOmTdkwJ2NID6xQjv4CDdQc?=
 =?us-ascii?Q?dgq7uJgx38/Z8HPc9oMPicn8LExTpKVLKtWRclFr25Axd+U11EguTeCi9qwP?=
 =?us-ascii?Q?VEgRawL5lWwVnRZtIOirUphHrt77w+hoUp0/BNS3SXshQZuuq3Kcqr82LnvO?=
 =?us-ascii?Q?vGnkaujZr8z+N/IpZ1qsE/gGTsU3boAj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 21:50:21.6493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 866b010e-9ce6-4e4a-b1b1-08dd131b5202
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
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

From: Lancelot SIX <lancelot.six@amd.com>

In gfx950, the SQ_WAVE_LDS_ALLOC.LDS_SIZE field is extended to bits 12
to 22.  The LDS_SIZE granularity remains unchanged (units of 64 dwords,
or 256 bytes).  This patch adjusts the CWSR trap handler to read the
full extent of LDS_SIZE.

Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 497 ++++++++++++++++++
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm |   9 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   6 +-
 3 files changed, 509 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 02f7ba8c93cd4..5931a17b4da3e 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -4122,3 +4122,500 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0x00000000,
 };
+
+static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
+	0xbf820001, 0xbf8202ea,
+	0xb8f8f802, 0x8978ff78,
+	0x00020006, 0xb8fbf803,
+	0x866eff78, 0x00002000,
+	0xbf840008, 0xbf0d986d,
+	0xbf85001f, 0x866eff7b,
+	0x00000400, 0xbf850061,
+	0xbf8e0010, 0xb8fbf803,
+	0xbf82fffa, 0x866eff7b,
+	0x03800900, 0xbf850015,
+	0x866eff7b, 0x000071ff,
+	0xbf840008, 0x866fff7b,
+	0x00007080, 0xbf840001,
+	0xbeee1a87, 0xb8eff801,
+	0x8e6e8c6e, 0x866e6f6e,
+	0xbf85000a, 0xbf0d986d,
+	0xbf850003, 0x866eff6d,
+	0x00ff0000, 0xbf850005,
+	0xbf0d986d, 0xbf850004,
+	0x866eff7b, 0x00000400,
+	0xbf850046, 0xbeed1a9d,
+	0xb8faf807, 0x867aff7a,
+	0x001f8000, 0x8e7a8b7a,
+	0x8979ff79, 0xfc000000,
+	0x87797a79, 0xba7ff807,
+	0x00000000, 0xb8faf812,
+	0xb8fbf813, 0x8efa887a,
+	0xbf0d8f7b, 0xbf840002,
+	0x877bff7b, 0xffff0000,
+	0xc0031cfd, 0x00000010,
+	0xc0071bbd, 0x00000000,
+	0xc0071ebd, 0x00000008,
+	0xbf8cc07f, 0x8e739773,
+	0x8979ff79, 0x01800000,
+	0x87797379, 0xbf0d986d,
+	0xbf840009, 0xbf0d9879,
+	0xbf850007, 0x896dff6d,
+	0x01ff0000, 0xba7f0583,
+	0x00000000, 0xbf0d9d6d,
+	0xbeed189d, 0xbf840012,
+	0xbef91898, 0xbeed189d,
+	0x86ee6e6e, 0xbf840001,
+	0xbe801d6e, 0x866eff6d,
+	0x01ff0000, 0xbf850005,
+	0x8778ff78, 0x00002000,
+	0x80ec886c, 0x82ed806d,
+	0xbf820005, 0x866eff6d,
+	0x01000000, 0xbf850002,
+	0x806c846c, 0x826d806d,
+	0x866dff6d, 0x0000ffff,
+	0x8f7a8b79, 0x867aff7a,
+	0x001f8000, 0xb97af807,
+	0x86fe7e7e, 0x86ea6a6a,
+	0x8f6e8378, 0xb96ee0c2,
+	0xbf800002, 0xb9780002,
+	0xbe801f6c, 0x866dff6d,
+	0x0000ffff, 0xbefa0080,
+	0xb97a0283, 0xb8faf807,
+	0x867aff7a, 0x001f8000,
+	0x8e7a8b7a, 0x8979ff79,
+	0xfc000000, 0x87797a79,
+	0xba7ff807, 0x00000000,
+	0xbeee007e, 0xbeef007f,
+	0xbefe0180, 0xbf900004,
+	0x877a8478, 0xb97af802,
+	0xbf8e0002, 0xbf88fffe,
+	0xb8fa2985, 0x807a817a,
+	0x8e7a8a7a, 0x8e7a817a,
+	0xb8fb1605, 0x807b817b,
+	0x8e7b867b, 0x807a7b7a,
+	0x807a7e7a, 0x827b807f,
+	0x867bff7b, 0x0000ffff,
+	0xc04b1c3d, 0x00000050,
+	0xbf8cc07f, 0xc04b1d3d,
+	0x00000060, 0xbf8cc07f,
+	0xc0431e7d, 0x00000074,
+	0xbf8cc07f, 0xbef4007e,
+	0x8675ff7f, 0x0000ffff,
+	0x8775ff75, 0x00040000,
+	0xbef60080, 0xbef700ff,
+	0x00807fac, 0xbef1007c,
+	0xbef00080, 0xb8f02985,
+	0x80708170, 0x8e708a70,
+	0x8e708170, 0xb8fa1605,
+	0x807a817a, 0x8e7a867a,
+	0x80707a70, 0xbef60084,
+	0xbef600ff, 0x01000000,
+	0xbefe007c, 0xbefc0070,
+	0xc0611c7a, 0x0000007c,
+	0xbf8cc07f, 0x80708470,
+	0xbefc007e, 0xbefe007c,
+	0xbefc0070, 0xc0611b3a,
+	0x0000007c, 0xbf8cc07f,
+	0x80708470, 0xbefc007e,
+	0xbefe007c, 0xbefc0070,
+	0xc0611b7a, 0x0000007c,
+	0xbf8cc07f, 0x80708470,
+	0xbefc007e, 0xbefe007c,
+	0xbefc0070, 0xc0611bba,
+	0x0000007c, 0xbf8cc07f,
+	0x80708470, 0xbefc007e,
+	0xbefe007c, 0xbefc0070,
+	0xc0611bfa, 0x0000007c,
+	0xbf8cc07f, 0x80708470,
+	0xbefc007e, 0xbefe007c,
+	0xbefc0070, 0xc0611e3a,
+	0x0000007c, 0xbf8cc07f,
+	0x80708470, 0xbefc007e,
+	0xb8fbf803, 0xbefe007c,
+	0xbefc0070, 0xc0611efa,
+	0x0000007c, 0xbf8cc07f,
+	0x80708470, 0xbefc007e,
+	0xbefe007c, 0xbefc0070,
+	0xc0611a3a, 0x0000007c,
+	0xbf8cc07f, 0x80708470,
+	0xbefc007e, 0xbefe007c,
+	0xbefc0070, 0xc0611a7a,
+	0x0000007c, 0xbf8cc07f,
+	0x80708470, 0xbefc007e,
+	0xb8f1f801, 0xbefe007c,
+	0xbefc0070, 0xc0611c7a,
+	0x0000007c, 0xbf8cc07f,
+	0x80708470, 0xbefc007e,
+	0x867aff7f, 0x04000000,
+	0xbeef0080, 0x876f6f7a,
+	0xb8f02985, 0x80708170,
+	0x8e708a70, 0x8e708170,
+	0xb8fb1605, 0x807b817b,
+	0x8e7b847b, 0x8e76827b,
+	0xbef600ff, 0x01000000,
+	0xbef20174, 0x80747074,
+	0x82758075, 0xbefc0080,
+	0xbf800000, 0xbe802b00,
+	0xbe822b02, 0xbe842b04,
+	0xbe862b06, 0xbe882b08,
+	0xbe8a2b0a, 0xbe8c2b0c,
+	0xbe8e2b0e, 0xc06b003a,
+	0x00000000, 0xbf8cc07f,
+	0xc06b013a, 0x00000010,
+	0xbf8cc07f, 0xc06b023a,
+	0x00000020, 0xbf8cc07f,
+	0xc06b033a, 0x00000030,
+	0xbf8cc07f, 0x8074c074,
+	0x82758075, 0x807c907c,
+	0xbf0a7b7c, 0xbf85ffe7,
+	0xbef40172, 0xbef00080,
+	0xbefe00c1, 0xbeff00c1,
+	0xbee80080, 0xbee90080,
+	0xbef600ff, 0x01000000,
+	0x867aff78, 0x00400000,
+	0xbf850003, 0xb8faf803,
+	0x897a7aff, 0x10000000,
+	0xbf85004d, 0xbe840080,
+	0xd2890000, 0x00000900,
+	0x80048104, 0xd2890001,
+	0x00000900, 0x80048104,
+	0xd2890002, 0x00000900,
+	0x80048104, 0xd2890003,
+	0x00000900, 0x80048104,
+	0xc069003a, 0x00000070,
+	0xbf8cc07f, 0x80709070,
+	0xbf06c004, 0xbf84ffee,
+	0xbe840080, 0xd2890000,
+	0x00000901, 0x80048104,
+	0xd2890001, 0x00000901,
+	0x80048104, 0xd2890002,
+	0x00000901, 0x80048104,
+	0xd2890003, 0x00000901,
+	0x80048104, 0xc069003a,
+	0x00000070, 0xbf8cc07f,
+	0x80709070, 0xbf06c004,
+	0xbf84ffee, 0xbe840080,
+	0xd2890000, 0x00000902,
+	0x80048104, 0xd2890001,
+	0x00000902, 0x80048104,
+	0xd2890002, 0x00000902,
+	0x80048104, 0xd2890003,
+	0x00000902, 0x80048104,
+	0xc069003a, 0x00000070,
+	0xbf8cc07f, 0x80709070,
+	0xbf06c004, 0xbf84ffee,
+	0xbe840080, 0xd2890000,
+	0x00000903, 0x80048104,
+	0xd2890001, 0x00000903,
+	0x80048104, 0xd2890002,
+	0x00000903, 0x80048104,
+	0xd2890003, 0x00000903,
+	0x80048104, 0xc069003a,
+	0x00000070, 0xbf8cc07f,
+	0x80709070, 0xbf06c004,
+	0xbf84ffee, 0xbf820008,
+	0xe0724000, 0x701d0000,
+	0xe0724100, 0x701d0100,
+	0xe0724200, 0x701d0200,
+	0xe0724300, 0x701d0300,
+	0xbefe00c1, 0xbeff00c1,
+	0xb8fb5306, 0x867bc17b,
+	0xbf840064, 0xbf8a0000,
+	0x867aff6f, 0x04000000,
+	0xbf840060, 0x8e7b867b,
+	0x8e7b827b, 0xbef6007b,
+	0xb8f02985, 0x80708170,
+	0x8e708a70, 0x8e708170,
+	0xb8fa1605, 0x807a817a,
+	0x8e7a867a, 0x80707a70,
+	0x8070ff70, 0x00000080,
+	0xbef600ff, 0x01000000,
+	0xbefc0080, 0xd28c0002,
+	0x000100c1, 0xd28d0003,
+	0x000204c1, 0x867aff78,
+	0x00400000, 0xbf850003,
+	0xb8faf803, 0x897a7aff,
+	0x10000000, 0xbf850030,
+	0x24040682, 0xd86e4000,
+	0x00000002, 0xbf8cc07f,
+	0xbe840080, 0xd2890000,
+	0x00000900, 0x80048104,
+	0xd2890001, 0x00000900,
+	0x80048104, 0xd2890002,
+	0x00000900, 0x80048104,
+	0xd2890003, 0x00000900,
+	0x80048104, 0xc069003a,
+	0x00000070, 0xbf8cc07f,
+	0x80709070, 0xbf06c004,
+	0xbf84ffee, 0xbe840080,
+	0xd2890000, 0x00000901,
+	0x80048104, 0xd2890001,
+	0x00000901, 0x80048104,
+	0xd2890002, 0x00000901,
+	0x80048104, 0xd2890003,
+	0x00000901, 0x80048104,
+	0xc069003a, 0x00000070,
+	0xbf8cc07f, 0x80709070,
+	0xbf06c004, 0xbf84ffee,
+	0x680404ff, 0x00000200,
+	0xd0c9006a, 0x0000f702,
+	0xbf87ffd2, 0xbf820015,
+	0xd1060002, 0x00011103,
+	0x7e0602ff, 0x00000200,
+	0xbefc00ff, 0x00010000,
+	0xbe800077, 0x8677ff77,
+	0xff7fffff, 0x8777ff77,
+	0x00058000, 0xd8ec0000,
+	0x00000002, 0xbf8cc07f,
+	0xe0765000, 0x701d0002,
+	0x68040702, 0xd0c9006a,
+	0x0000f702, 0xbf87fff7,
+	0xbef70000, 0xbef000ff,
+	0x00000400, 0xbefe00c1,
+	0xbeff00c1, 0xb8fb2b05,
+	0x807b817b, 0x8e7b827b,
+	0xbef600ff, 0x01000000,
+	0xbefc0084, 0xbf0a7b7c,
+	0xbf84006d, 0xbf11017c,
+	0x807bff7b, 0x00001000,
+	0x867aff78, 0x00400000,
+	0xbf850003, 0xb8faf803,
+	0x897a7aff, 0x10000000,
+	0xbf850051, 0xbe840080,
+	0xd2890000, 0x00000900,
+	0x80048104, 0xd2890001,
+	0x00000900, 0x80048104,
+	0xd2890002, 0x00000900,
+	0x80048104, 0xd2890003,
+	0x00000900, 0x80048104,
+	0xc069003a, 0x00000070,
+	0xbf8cc07f, 0x80709070,
+	0xbf06c004, 0xbf84ffee,
+	0xbe840080, 0xd2890000,
+	0x00000901, 0x80048104,
+	0xd2890001, 0x00000901,
+	0x80048104, 0xd2890002,
+	0x00000901, 0x80048104,
+	0xd2890003, 0x00000901,
+	0x80048104, 0xc069003a,
+	0x00000070, 0xbf8cc07f,
+	0x80709070, 0xbf06c004,
+	0xbf84ffee, 0xbe840080,
+	0xd2890000, 0x00000902,
+	0x80048104, 0xd2890001,
+	0x00000902, 0x80048104,
+	0xd2890002, 0x00000902,
+	0x80048104, 0xd2890003,
+	0x00000902, 0x80048104,
+	0xc069003a, 0x00000070,
+	0xbf8cc07f, 0x80709070,
+	0xbf06c004, 0xbf84ffee,
+	0xbe840080, 0xd2890000,
+	0x00000903, 0x80048104,
+	0xd2890001, 0x00000903,
+	0x80048104, 0xd2890002,
+	0x00000903, 0x80048104,
+	0xd2890003, 0x00000903,
+	0x80048104, 0xc069003a,
+	0x00000070, 0xbf8cc07f,
+	0x80709070, 0xbf06c004,
+	0xbf84ffee, 0x807c847c,
+	0xbf0a7b7c, 0xbf85ffb1,
+	0xbf9c0000, 0xbf820012,
+	0x7e000300, 0x7e020301,
+	0x7e040302, 0x7e060303,
+	0xe0724000, 0x701d0000,
+	0xe0724100, 0x701d0100,
+	0xe0724200, 0x701d0200,
+	0xe0724300, 0x701d0300,
+	0x807c847c, 0x8070ff70,
+	0x00000400, 0xbf0a7b7c,
+	0xbf85ffef, 0xbf9c0000,
+	0xb8fb2985, 0x807b817b,
+	0x8e7b837b, 0xb8fa2b05,
+	0x807a817a, 0x8e7a827a,
+	0x80fb7a7b, 0x867b7b7b,
+	0xbf84007a, 0x807bff7b,
+	0x00001000, 0xbefc0080,
+	0xbf11017c, 0x867aff78,
+	0x00400000, 0xbf850003,
+	0xb8faf803, 0x897a7aff,
+	0x10000000, 0xbf850059,
+	0xd3d84000, 0x18000100,
+	0xd3d84001, 0x18000101,
+	0xd3d84002, 0x18000102,
+	0xd3d84003, 0x18000103,
+	0xbe840080, 0xd2890000,
+	0x00000900, 0x80048104,
+	0xd2890001, 0x00000900,
+	0x80048104, 0xd2890002,
+	0x00000900, 0x80048104,
+	0xd2890003, 0x00000900,
+	0x80048104, 0xc069003a,
+	0x00000070, 0xbf8cc07f,
+	0x80709070, 0xbf06c004,
+	0xbf84ffee, 0xbe840080,
+	0xd2890000, 0x00000901,
+	0x80048104, 0xd2890001,
+	0x00000901, 0x80048104,
+	0xd2890002, 0x00000901,
+	0x80048104, 0xd2890003,
+	0x00000901, 0x80048104,
+	0xc069003a, 0x00000070,
+	0xbf8cc07f, 0x80709070,
+	0xbf06c004, 0xbf84ffee,
+	0xbe840080, 0xd2890000,
+	0x00000902, 0x80048104,
+	0xd2890001, 0x00000902,
+	0x80048104, 0xd2890002,
+	0x00000902, 0x80048104,
+	0xd2890003, 0x00000902,
+	0x80048104, 0xc069003a,
+	0x00000070, 0xbf8cc07f,
+	0x80709070, 0xbf06c004,
+	0xbf84ffee, 0xbe840080,
+	0xd2890000, 0x00000903,
+	0x80048104, 0xd2890001,
+	0x00000903, 0x80048104,
+	0xd2890002, 0x00000903,
+	0x80048104, 0xd2890003,
+	0x00000903, 0x80048104,
+	0xc069003a, 0x00000070,
+	0xbf8cc07f, 0x80709070,
+	0xbf06c004, 0xbf84ffee,
+	0x807c847c, 0xbf0a7b7c,
+	0xbf85ffa9, 0xbf9c0000,
+	0xbf820016, 0xd3d84000,
+	0x18000100, 0xd3d84001,
+	0x18000101, 0xd3d84002,
+	0x18000102, 0xd3d84003,
+	0x18000103, 0xe0724000,
+	0x701d0000, 0xe0724100,
+	0x701d0100, 0xe0724200,
+	0x701d0200, 0xe0724300,
+	0x701d0300, 0x807c847c,
+	0x8070ff70, 0x00000400,
+	0xbf0a7b7c, 0xbf85ffeb,
+	0xbf9c0000, 0xbf8200ee,
+	0xbef4007e, 0x8675ff7f,
+	0x0000ffff, 0x8775ff75,
+	0x00040000, 0xbef60080,
+	0xbef700ff, 0x00807fac,
+	0x866eff7f, 0x04000000,
+	0xbf84001f, 0xbefe00c1,
+	0xbeff00c1, 0xb8ef5306,
+	0x866fc16f, 0xbf84001a,
+	0x8e6f866f, 0x8e6f826f,
+	0xbef6006f, 0xb8f82985,
+	0x80788178, 0x8e788a78,
+	0x8e788178, 0xb8ee1605,
+	0x806e816e, 0x8e6e866e,
+	0x80786e78, 0x8078ff78,
+	0x00000080, 0xbef600ff,
+	0x01000000, 0xbefc0080,
+	0xe0510000, 0x781d0000,
+	0xe0510100, 0x781d0000,
+	0x807cff7c, 0x00000200,
+	0x8078ff78, 0x00000200,
+	0xbf0a6f7c, 0xbf85fff6,
+	0xbefe00c1, 0xbeff00c1,
+	0xbef600ff, 0x01000000,
+	0xb8ef2b05, 0x806f816f,
+	0x8e6f826f, 0x806fff6f,
+	0x00008000, 0xbef80080,
+	0xbeee0078, 0x8078ff78,
+	0x00000400, 0xbefc0084,
+	0xbf11087c, 0xe0524000,
+	0x781d0000, 0xe0524100,
+	0x781d0100, 0xe0524200,
+	0x781d0200, 0xe0524300,
+	0x781d0300, 0xbf8c0f70,
+	0x7e000300, 0x7e020301,
+	0x7e040302, 0x7e060303,
+	0x807c847c, 0x8078ff78,
+	0x00000400, 0xbf0a6f7c,
+	0xbf85ffee, 0xb8ef2985,
+	0x806f816f, 0x8e6f836f,
+	0xb8f92b05, 0x80798179,
+	0x8e798279, 0x80ef796f,
+	0x866f6f6f, 0xbf84001a,
+	0x806fff6f, 0x00008000,
+	0xbefc0080, 0xbf11087c,
+	0xe0524000, 0x781d0000,
+	0xe0524100, 0x781d0100,
+	0xe0524200, 0x781d0200,
+	0xe0524300, 0x781d0300,
+	0xbf8c0f70, 0xd3d94000,
+	0x18000100, 0xd3d94001,
+	0x18000101, 0xd3d94002,
+	0x18000102, 0xd3d94003,
+	0x18000103, 0x807c847c,
+	0x8078ff78, 0x00000400,
+	0xbf0a6f7c, 0xbf85ffea,
+	0xbf9c0000, 0xe0524000,
+	0x6e1d0000, 0xe0524100,
+	0x6e1d0100, 0xe0524200,
+	0x6e1d0200, 0xe0524300,
+	0x6e1d0300, 0xbf8c0f70,
+	0xb8f82985, 0x80788178,
+	0x8e788a78, 0x8e788178,
+	0xb8ee1605, 0x806e816e,
+	0x8e6e866e, 0x80786e78,
+	0x80f8c078, 0xb8ef1605,
+	0x806f816f, 0x8e6f846f,
+	0x8e76826f, 0xbef600ff,
+	0x01000000, 0xbefc006f,
+	0xc031003a, 0x00000078,
+	0x80f8c078, 0xbf8cc07f,
+	0x80fc907c, 0xbf800000,
+	0xbe802d00, 0xbe822d02,
+	0xbe842d04, 0xbe862d06,
+	0xbe882d08, 0xbe8a2d0a,
+	0xbe8c2d0c, 0xbe8e2d0e,
+	0xbf06807c, 0xbf84fff0,
+	0xb8f82985, 0x80788178,
+	0x8e788a78, 0x8e788178,
+	0xb8ee1605, 0x806e816e,
+	0x8e6e866e, 0x80786e78,
+	0xbef60084, 0xbef600ff,
+	0x01000000, 0xc0211bfa,
+	0x00000078, 0x80788478,
+	0xc0211b3a, 0x00000078,
+	0x80788478, 0xc0211b7a,
+	0x00000078, 0x80788478,
+	0xc0211c3a, 0x00000078,
+	0x80788478, 0xc0211c7a,
+	0x00000078, 0x80788478,
+	0xc0211eba, 0x00000078,
+	0x80788478, 0xc0211efa,
+	0x00000078, 0x80788478,
+	0xc0211a3a, 0x00000078,
+	0x80788478, 0xc0211a7a,
+	0x00000078, 0x80788478,
+	0xc0211cfa, 0x00000078,
+	0x80788478, 0xbf8cc07f,
+	0xbefc006f, 0xbefe0070,
+	0xbeff0071, 0x866f7bff,
+	0x000003ff, 0xb96f4803,
+	0x866f7bff, 0xfffff800,
+	0x8f6f8b6f, 0xb96fa2c3,
+	0xb973f801, 0xb8ee2985,
+	0x806e816e, 0x8e6e8a6e,
+	0x8e6e816e, 0xb8ef1605,
+	0x806f816f, 0x8e6f866f,
+	0x806e6f6e, 0x806e746e,
+	0x826f8075, 0x866fff6f,
+	0x0000ffff, 0xc00b1c37,
+	0x00000050, 0xc00b1d37,
+	0x00000060, 0xc0031e77,
+	0x00000074, 0xbf8cc07f,
+	0x8f6e8b79, 0x866eff6e,
+	0x001f8000, 0xb96ef807,
+	0x866dff6d, 0x0000ffff,
+	0x86fe7e7e, 0x86ea6a6a,
+	0x8f6e837a, 0xb96ee0c2,
+	0xbf800002, 0xb97a0002,
+	0xbf8a0000, 0xbe801f6c,
+	0xbf9b0000, 0x00000000,
+};
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
index a2d597d7fb574..0f4877a601409 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
@@ -37,12 +37,17 @@
  * gc_9_4_3:
  *   cpp -DASIC_FAMILY=GC_9_4_3 cwsr_trap_handler_gfx9.asm -P -o gc_9_4_3.sp3
  *   sp3 gc_9_4_3.sp3 -hex gc_9_4_3.hex
+ *
+ * gc_9_5_0:
+ *   cpp -DASIC_FAMILY=GC_9_5_0 cwsr_trap_handler_gfx9.asm -P -o gc_9_5_0.sp3
+ *   sp3 gc_9_5_0.sp3 -hex gc_9_5_0.hex
  */
 
 #define CHIP_VEGAM 18
 #define CHIP_ARCTURUS 23
 #define CHIP_ALDEBARAN 25
 #define CHIP_GC_9_4_3 26
+#define CHIP_GC_9_5_0 27
 
 var ACK_SQC_STORE		    =	1		    //workaround for suspected SQC store bug causing incorrect stores under concurrency
 var SAVE_AFTER_XNACK_ERROR	    =	1		    //workaround for TCP store failure after XNACK error when ALLOW_REPLAY=0, for debugger
@@ -68,7 +73,11 @@ var SQ_WAVE_STATUS_ALLOW_REPLAY_MASK    = 0x400000
 var SQ_WAVE_STATUS_ECC_ERR_MASK         = 0x20000
 
 var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT	= 12
+#if ASIC_FAMILY >= CHIP_GC_9_5_0
+var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE	= 11
+#else
 var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE	= 9
+#endif
 var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE	= 6
 var SQ_WAVE_GPR_ALLOC_SGPR_SIZE_SIZE	= 3			//FIXME	 sq.blk still has 4 bits at this time while SQ programming guide has 3 bits
 var SQ_WAVE_GPR_ALLOC_SGPR_SIZE_SHIFT	= 24
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b58f798bf2d56..ac0fdaa1ea23e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -522,9 +522,9 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
 			kfd->cwsr_isa = cwsr_trap_gfx9_4_3_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx9_4_3_hex);
 		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 5, 0)) {
-			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex) > PAGE_SIZE);
-			kfd->cwsr_isa = cwsr_trap_gfx9_4_3_hex;
-			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx9_4_3_hex);
+			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_5_0_hex) > PAGE_SIZE);
+			kfd->cwsr_isa = cwsr_trap_gfx9_5_0_hex;
+			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx9_5_0_hex);
 		} else if (KFD_GC_VERSION(kfd) < IP_VERSION(10, 1, 1)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex)
 					     > KFD_CWSR_TMA_OFFSET);
-- 
2.47.0

