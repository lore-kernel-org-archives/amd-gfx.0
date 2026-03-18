Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235A6FEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B39D210E660;
	Wed, 18 Mar 2026 01:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BRr8Fm0j";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4C5010E660
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2h9vtY/UZwF9CmCgTpM3J9MC1wtogRZaECo1yRzodjQwjMz33mHFvlZo3PsCBZhnk9GpAEEPQYJBeb3cvwrOMIe07wqH6czGWIguwlQXRcqn+e8GjCD6lwHVnfb0g/Ha3z/GS0ZtpCvrPetIyZaJGfqqyxVJGNJZWaF8mYW1FmZNUYcVDzxf5bn/JeLY6Vv2fibiensxDuM/AysnMxjvKqRSFHDLqsHuKbczMtaGJso8uYxkPKVVok23s4Z2tb3vRTN4G885hm/FhcLQiA8+DGew9m38ecxx3UKqONLZW9FxWq7ccrv/blv6fjl1X2fKsIQL6BzdYXgsoVwYWFz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmyjTNwUsv7tSHQ5UEY/bJSjvLSPEj4VDcZv1Bm6c/o=;
 b=NvJHJxXc1w4MR84RknPeMAYB4MacN8yXxY6/7vk+XW+ZFOlxgligGlzBU4fNzU5wieGq8DYdZpuisGMVTs85JVz31456qERUXGyy6bhn2U7glqJqjj4ENN/LCmqLjc6x/rrFcg0ULWpNIP2pdopCJ5ovNSL79zvvrUrpmevweOVDhOAWLrDIWr5GAY7xU/1e1OJrSQqQyMcYmlVFl8JKDSCnLTHUyibyaKeYBtfrJ4ZLuBYxCGZbJlp7l7aymT4YFT7NRc4MRl2MaDMicJUOlazWGXUSAa4K8JwqXdncSQRC5ocd03n9ChP59KXo+dCC9A5arM0GIhfQ3wDumP0bCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmyjTNwUsv7tSHQ5UEY/bJSjvLSPEj4VDcZv1Bm6c/o=;
 b=BRr8Fm0jUAe0khD+H6EAvGM/3m345iyOE5o4bsXfRNx1rrMJ+D4NS7yz9SIMpM1CNdU4gOAxFq9tY1MeAPouDJ5rFqKeqpYESFm9Jri30CictxWk5/c0dzQ3v9b00UwbFpqlrR7fBW56EiQIAC1uzdSLXIjOYZ8k7IZ9ccHdlis=
Received: from SN7PR04CA0209.namprd04.prod.outlook.com (2603:10b6:806:126::34)
 by SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:02:47 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::36) by SN7PR04CA0209.outlook.office365.com
 (2603:10b6:806:126::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Wed,
 18 Mar 2026 01:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:02:46 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:02:42 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Swapnil Patel
 <swapnil.patel@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 28/31] drm/amd/display: add dccg FGCG mask init
Date: Wed, 18 Mar 2026 08:59:37 +0800
Message-ID: <20260318010224.513094-29-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SA1PR12MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d1eaf4-039e-4fff-c856-08de848a11a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TcGGZXd9n8+6Dqf6ihlChVcDV1LrO9FAf7M7Fg7CafWP8kWbm0gnG+xL2PWqSyEIDWqKbr07KPEH+8V5ugIfoQfP3SnfaZGvdrj2hPgR2xNbWz0yimK2DUVn9EJOHcp7D5CUO7s7CUoBjcc7pk1ITuQj/SwKk74zBklYNBIlLeRhyklF9WVfZeENbSqk5UiyQpviMvoZvgKqzYLqi+PpSYgfnw3kwh/JgLId/um+kRVTpgVJfBiFuhGXYQmrPwKA6yegqlOljznVD0N19alt0v8M5bsDabWYhHs9vHVs2SHWWdIm9dEFmeO+RKoHsfRDDWLhJt/3qWsZTCdRJ8HK08L3O74MpWFUwbYoS38W/8tcqxZBhoHfSO0V7HI6YL04XYEZ4c3MZRd+006lbPS3LJMY7BEKTS+0S/yYHcLskjNLXHj9vP8K3f46cEi/2ZN2JsXyKtC+2SqkzsVTZ0/kPb68bfWcsIyBgOnFzJhywLmKXdR41/COtreY4pLi/tY4w+gYChhMEGyV4Hr+TyvDA+HI21rSJrjJFKiI7G37eEvbmcf0L76GwUSaLpKghCuoVzkSGjHtVve7qt/RZX4mPNV1EroNLurHTeMfa9E675qLTEYTPNBLAfGNmTcRmv0DB0ZbnJmHYXfxboVROvqWj5l2w1GWu4wrjh/2dLVrx2DRqXsC8GYRzUUaqd+Q6L3bLXxwm+kvXQmM9kGCRd8hh2K+1dmjuwUc7e7qmVzcOSPhIRb54H3JFHCsdM2ISXt8twv5X2dSevpvPq2ERBETSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uBLgPZ6wnPKP/BePDfLsd3Mv5KvuKBXQOQ36M/kgzcjlm9wzq/+e36gR/EPGhiKlt7kO892MKsduCQks0c1rc8mIjPZ2nmfDQI0fFX92U4xMQOJVatzzplfRH0N6a7FSLYcxO+cvxqlwl11mjZTlm03uzToHWhHvCySRgkqn4TuJvmb9IC8BpULOWLB1B2Ds5n8m7aTc7yvTcg4C2Jk4HNoc+AiMk0zliaLT0AHVaUmShiyBIwfPsDTabjDgSFXBQnGRTqJbhf4twK3Z1Mk+M2X9rttiHR/3W7OPauywABXsxr5PKyT36Ol4wGkIKdKSN4WXE9ns/7bN/dHmcTFOShu7/eb/R5Rcsi7oWKp+bple5Z5DKRWU2AetPHpuZWbSJa9MJfs21XlP+4KlFOMEq9apmNSIPjMbx7NSMk/jfgQxwzewpG8rMPv2cOsqLbD8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:02:46.9181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d1eaf4-039e-4fff-c856-08de848a11a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
missing DCCG_GLOBAL_FGCG_REP_DIS mask macro init

Reviewed-by: Swapnil Patel <swapnil.patel@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
index d9831b0f8235..2076565b1caa 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
@@ -122,6 +122,7 @@
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYBSYMCLK_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYCSYMCLK_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYDSYMCLK_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GLOBAL_FGCG_REP_CNTL, DCCG_GLOBAL_FGCG_REP_DIS, mask_sh),\
 	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DP_DTO, ENABLE, 0, mask_sh),\
 	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DP_DTO, ENABLE, 1, mask_sh),\
 	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DP_DTO, ENABLE, 2, mask_sh),\
-- 
2.43.0

