Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E32CD98F2
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC56F10F5E5;
	Fri, 19 Jun 2026 13:32:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pmcLln4K";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A598810F5E1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/4V/H9XROq7/abUsoc/rdm9tdfWa7VRGpnRXD/uQo/7dP4qgBVwYm/WSIEPcpvKKF2R7HP1u6JHAoyBoWfnQ8UNYxNDl5hU/Xp+dn/shJTiPUvt0uRLWN1dH5RGMhT0ErERfh3O3CA+YuTbDeeHUeo78D5aycjEN1qu/x+7swpsHvk2Zzj75UZK9j5ell5dccTniSrgLkVGKLme4ESvBwA64K+eXwM9Wyqm68WFrB4Rtvui/7E3I9v/z1wG0F0X1GHbTOJ6Ok6XyYrOSE7cINXnXxsqyQDO/Bzd67h2RYCgmDpFA5UFFK6H7AxxSC2X6hFbmsY0Hja6LJ2C9tthUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BouZgW/gPdZglraRbPJguFJmvmxJQgNgSkL3MG3ZgZo=;
 b=YU59geRmmju0AT5Tp9BwJfoyzq5iCiYApYGAdkAm6CcdtYqagnrbPVAg1rmEsD711cQVcgH0oKeUb26UK7H9aRdRdV6EfWFUiFyRELwBYu1SVJxNMqz7qe8eWwEVS56dHTLK0/8TnGn/I/kUv799eV5SelnddWo7uZ9fS5y0m/QI4vwa9XezjdjUEeVti/xkEne0lUdEoI/qevz0d+K9KBYdClaBq73VKpCN6F40yl9a34kEFkZ0GPRrY7SqslEvs1oVhd0uRJYdUvZOTJvQxE0gYob+1PV+/UZ4C/b7q5G4m+hQxX7RofWAdUcsfTH/eELvZsofjXncJBXZ5Y8AjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BouZgW/gPdZglraRbPJguFJmvmxJQgNgSkL3MG3ZgZo=;
 b=pmcLln4KE1uh/Z7szyt8HVdfwkt6Ryf/oijcBk5Dal0mhjLE0OHq3Al0JrSgpHQA1UKRv+kVVThJV4hVqp+f6RamOSa1cBy7Ibt5UNVDtYFW5Dk97kWuxT9MP6FWCM+6MP8RqkoUCrG2sHPHvvlJeRMVx4Vi/VSQGszI9slu19k=
Received: from BN0PR04CA0181.namprd04.prod.outlook.com (2603:10b6:408:e9::6)
 by DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 13:32:28 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::67) by BN0PR04CA0181.outlook.office365.com
 (2603:10b6:408:e9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Fri,
 19 Jun 2026 13:32:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:28 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:27 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Karen Chen <Karen.Chen@amd.com>, "Ovidiu (Ovi) Bunea"
 <ovidiu.bunea@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 12/24] drm/amd/display: Disable DPPCLK RCG to fix cursor
 disappearing
Date: Fri, 19 Jun 2026 09:21:27 -0400
Message-ID: <20260619133154.116746-13-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 072d43e1-62fc-483b-62d1-08dece07352e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sAw7sHUxivF9rxYvRfRT8hyElfyu/V0UhcgD4QBe2RSNdCSdcAFhBZm1oPLe1SxqB3wkaQFYZVNrfj6e0bALSRgLO8BtiPwp+J6xSRw3a0kbvqxi/xJfpvrl+u9y+/ZVKrvOyUyV4cuJyQAX/pzdWAtHjETiGl5zMv/TIIbO90AlKiN5BVL1fA/AKJzpZnldITEFg1roXzeWKoxiLYcIMBML6UsOOP7Ushm5X34EkemgW6VyY8Ytzl8mE/xg4QjGqCbFfk9MFgjGK7spepq3AhEQDe4rvr/dIpZYa0XnHehPZ9Uct/khWveh/zSv0N220MgowSTuQnH6bnvQ3Ya2ZkhRIN0XypkkXkhrIbefxZ/9y5Q5eOSMZrHoXaMMyGmcVEQgjRO0/OtT7XQN2ADhwNZcqgGXi4RyWwt3XK2QGQg7sFll49tkDp+pbifSLa+mV+S5r4IzEO1X3rOCh+3bIvzz6+fFYvkgapIR1T7o5TjzkIeZOtFWE5JI2CaJLiIE+HSpAHq2eU2Qy+UkWQF3kkHdse8kGWFA02X8Xok8LUZNtEpolsNmolx+QdPDxskTh0atkSNnbI664uPO7S1Qc6ZIoKaAewfPjdJ+38lxNlBAjBFPmjIRB+T6bWMYk9r9B1vXrUaMppvgK5MYrLSL1PFoH1KeDNplU7fybNQL3MvQGkbzhGnidL78YtRpyzPoTd5LI5DAZC/CweVKtWFS+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lwgSgE4YLzSBCS95rLqN2qDElgAoFF2q6VtLEmxGS1rhRGI7R0MP8SwXUDN8E3ywtjZtQr8RvBQV8fhy39jRWnKrzguHdV4xDPGlUZrh8dE0Rfvzh5EI3eIlp1C0Bm/oy+jokdJRNLeIolyg4N99tb2uqp8a46QyJZtcfx2g4U5ZeDRBZLyUi3b3kWcKRtrWP/0vh88M1SvR7z67d0xIzbDH+3m3Rm+2nUls0/pQ09zLMf+/h6B4wtQUaZWsj1k9WAR7zXM5HG5mf+9Uu6V8RuBeFfeO+N9AnnhHprx7NXOLcZ83vnOAKRSwmsImNJwcLxFVo/dBQQM6v1nOcVP5A6pQ4vHwr4DDCrFO6ZlocWu5SCE39B5EInBzq2V/W3gCTLt83S+SVWyh6K7DLWaU2nyAL6nD+QV1qIUIQhDNYmv9TYDrIPTgPUozwjfw6QLH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:28.5083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 072d43e1-62fc-483b-62d1-08dece07352e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564
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

From: Karen Chen <Karen.Chen@amd.com>

[Why & How]
DPP clock is gated when programming the cursor. This change
disables DPPCLK RCG in dccg42_init before accessing DPP,
ensuring cursor programming latches correctly.

Assisted-by: Cursor

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Karen Chen <Karen.Chen@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
index 8989761c6078..6cbc1f4ef411 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
@@ -292,6 +292,12 @@ static void dccg42_init(struct dccg *dccg)
 	dccg42_disable_hdmistreamclk(dccg);
 	if (dccg->ctx->dc->debug.root_clock_optimization.bits.hdmichar)
 		dccg42_disable_hdmicharclk(dccg, 0);
+
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpp) {
+		for (i = 0; i < res_pool->pipe_count; i++) {
+			dccg35_dpp_root_clock_control(dccg, i, true);
+		}
+	}
 }


--
2.54.0

