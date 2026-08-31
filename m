Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8ECAC61DF0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 04:35:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5043C10E5CD;
	Mon, 31 Aug 2026 04:35:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nGwCA8B5";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A1F610E25E
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 04:35:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnyB81gmXIcGyaMzQeabGVHjnnlhtomo6tQQ7KD2213mdKDaj6VQ4vVe9XuIyTTJTT37DvlQKduOb6xFBnH/2hpdTC0EYOxcnGcdbwioD7YWRXYZMAtltoBqm8pEHdo4nwd1E+gSTgaZPvqLY/ZE9TE/17xJ//80QE/Q9W5eHtySBeWHIq+4EH2JBHELIh10Q/cyW73L7UwRtKXGLojre+MairH0cqHKx8Fj7p1F1hloXYF96FdiilanDf14U7MgwcHX7NJ9fVA0J1qD8rqf5kKAB6E56BVHfYrr0TIJu+797Zs1kqA3qx1fgZ84gdxaROve3FCIe/5SZrNafyg6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YbumnlsBJL3dVRZz1OvgK2am0XT1rhVnHmixDfh/Hw=;
 b=mNomnlnS2R8bt/KtfNzQ8qx3eGYfW0h1YZdwNKUpjGYqHJHa/Dt7HiPA72KnBh49D3E64Kl87wabGywSZW34pBA4T9CR5+cV6DUBFqlFYNRvmQbxbnZ07Pyy0OvaVZSWETLTA96E0s9qfq3dcNFm79YCJAraB5Eh3eD/V6unHcTs3FezgzPEuvNJ2n3f8X71U3XCZzCIl9Q6tsYU7su9uKIX2IJibFs+hvugGoqVsQyMGAmdfwqPvaWFgMe58I7vEBfQ466i8e6qzfvlbVCUZ5Ie8ILUIQNvY0txSfvWGPoIlmZMG8IRCySm/0WlywN2T0GWEfskxwrwRmvweqZEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YbumnlsBJL3dVRZz1OvgK2am0XT1rhVnHmixDfh/Hw=;
 b=nGwCA8B54k7vdEAavNfhC37JYSk2eunTCnOz8zvAYgnEYccPzVasVFqP+LtMaa3RiqoeMgQ0O/K0C2aubq9+MNEOmnASUZPo/6/cWGZZ+lyaXnfyC8wl/EGwGBFmB+SCcCKogsvRNf9VJzT13hKYDzbVSSsg6p9Izep7lhYQSNo=
Received: from CH0PR03CA0119.namprd03.prod.outlook.com (2603:10b6:610:cd::34)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 04:35:25 +0000
Received: from BN2PEPF0000A803.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::21) by CH0PR03CA0119.outlook.office365.com
 (2603:10b6:610:cd::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 04:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A803.mail.protection.outlook.com (10.167.245.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 04:35:24 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 23:35:23 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 2/7] drm/amd/pm: stage od reset for smu 13.0.2
Date: Mon, 31 Aug 2026 12:35:02 +0800
Message-ID: <20260831043507.523599-3-kevin.wang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831043507.523599-1-kevin.wang@amd.com>
References: <20260831043507.523599-1-kevin.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A803:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b81763-23d5-4931-9ba3-08df07194664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OirJFXN9Yk3xjnli+Pwvhkua0e15QfZCv0yVFS0LtMgwNbeZU+3c2XViDwb8nWW3rcppdbjZAGA77RtC7DGChO8IQlp9dupF0cRNGmRhZAZb5s4ccL2/sRolROq/A+W8xUsyC/C62tw8lTlNSpfOHiAyjYEUMTyDHhtffCbUOmFtq4JXTig/JB6oFpsWlro2u6RnMRd0QFOCq3oxCw+iHgKCWIvVLb89vKlsbY7haNGGJUHtWrvu+pd9ZnVmyagsqMDExPtSkO1a5G+1jtsMO/l7MmerFTq38uF/GWs5OoNy1yvdyN2MQngAVwnamLuDJ8OY0mGrQjiUqRiR3Z8e2F1G1Ib55OWtG7P9FYIQm06BBTdGyPGKJf5UN1Yq/96T/KMUcmlKclWfl0DTy7Uj8pUKcISU4NtR4whbStunFunZWD+pDYLhkShjqm7tS5BP0VhEWdB128D0IzxtpmlHiLC7Zw+wpTCgEi0yF6/eEwhUI4SOvIpfJ8zXB1gLyopGdUeMcA11K0L/mRlUBk8GMFMSxy9y3jjW/BvfGCnqi06UZRtGCqxlKahxnGBpixUnP9mVTixa5l0/sYRzkJuoM6htCSq2WjEWmpipZxAhOw10bmvRuFT265DKkhaTQA2S1aBJmnMHPUAJ5XWEKsZKs8zAT2+FT/WvTLfdXh/DEo4eXydZWd7L9wdLBjH8mQSgG+9AoKKAL03l01YJnH8pUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KuTXQEVNNCtaMNE4uviKe55/0KFIoHC9InvKU0r37PGvE+OKwyYZYGanjSF2Z8DDKm10VduADLzsF3MflhmCnhrW/qA3brxEsP+FuGanuyBo2bYHBBqD7DGywE2emYRzHypb+KRijSKxrEE2Mq+I3cD09CLc0HRqkzsDOwMPl1EvMhByXu7iwCEiEdMercGQPSB7hYK7ioS+7NSZ36EoxRd22E7ssOXt7vBbYQPW0YFYwyVP3bLL+SUGTyscQNnZNTOacmbYdjM/RaIbw2ijki6a8jVLRuOM5ikX96ezCEZlBG4LPus/EFbewy11PpjosQsH+XBfeovY/X4vHrzzZOm+HL74dlAf/Ad7aAjaI0vH3MOFhk160DIyo3FaFPPvfaQJ+oMDws1ghwUF1ItalBZ7v6h7LUjw2BKTa5Sktx+s2EhUDG3QU/aLoRL3gpr5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 04:35:24.6079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b81763-23d5-4931-9ba3-08df07194664
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A803.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469
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

SMU 13.0.2 restores the default GFXCLK range by sending a frequency
limit command and then clears the custom range. This bypasses the
staged pp_od_clk_voltage transaction.

Stage the default GFXCLK range in the custom state instead. The existing
PP_OD_COMMIT_DPM_TABLE path remains the sole PMFW update operation.

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 1aa589bdc301..d07ad50d2666 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1354,17 +1354,10 @@ static int aldebaran_usr_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_
 			dev_err(smu->adev->dev, "Input parameter number not correct\n");
 			return -EINVAL;
 		} else {
-			/* Use the default frequencies for manual and determinism mode */
-			min_clk = SMU_DPM_TABLE_MIN(
-				&dpm_context->dpm_tables.gfx_table);
-			max_clk = SMU_DPM_TABLE_MAX(
-				&dpm_context->dpm_tables.gfx_table);
-
-			ret = aldebaran_set_soft_freq_limited_range(
-				smu, SMU_GFXCLK, min_clk, max_clk, false);
-			if (ret)
-				return ret;
-			smu_v13_0_reset_custom_level(smu);
+			pstate_table->gfxclk_pstate.custom.min =
+				SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.gfx_table);
+			pstate_table->gfxclk_pstate.custom.max =
+				SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.gfx_table);
 		}
 		break;
 	case PP_OD_COMMIT_DPM_TABLE:
-- 
2.55.0

