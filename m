Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E880CA600A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFF4C10F703;
	Wed,  7 Oct 2026 17:04:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JUjV8hiW";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012064.outbound.protection.outlook.com
 [40.107.200.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B9B610F6FC
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aplng5QLfsQoPuGs/nLRYGYjsOelzyZGo6Llc4nClCzIMsA3bx62dcoTHrBhVj54pZj5Xs45xi4K9YRhiExNXCQrBVd+wog8vA28wyjjgnfFBfDes76gf2eC7xMQQQUf9dHxcqr7zCo1du6uW3tdDhuW+MNhB2rjyXf0WhbF3IEOYrhax9j5PtZAYaG6suegEebIceQj1iyArjmxrfCSQyn92W6OYg1pTl6UK/CLSs/MZkB828OxdZQxKr+Dx3vngyVzdkuK1IA9xC32FB6U0yT19MumUqCfBXQohMqgPB/M/3+RulapzqWojZceIXx6uK3i76Gly8F4zt4rZQv1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G92qnU3Z/sCireUVCTjaTEZYlOksR5STVPSkokxWCbI=;
 b=HRg+Dm6MXfCu3IR+h/8br1zqIKa8msemLBo0cEYygnS84n5ZKAu4WZxqO6iH9tTRW/MDWa3xkuP3FJuvU3DUAwJiHadqKnWRp75hh43RheXXTdPZLhRcwmfBrQbje5tUnFVhPUFagjMfyVnXfT0I+a/0Nzl+Mtzcv+V4cYlktEs+K3Oc4/aDlwNMkOurFf0yjbBtNgun7TBatUnhUv5vplmheRSjYim19Z2efkDiQOOmAW6r9LggkrmYudn7GHAV2JlAUzOZzgNG9bYpv/8gw/o7gpL/uxjy+72Kyl+KdyzA4KuvbAeX1GO7WqVeGIxg5Wxom2+M7vb3sUH/gUlkeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G92qnU3Z/sCireUVCTjaTEZYlOksR5STVPSkokxWCbI=;
 b=JUjV8hiWa1ZjGCUl381vwJ78nNlDjvMtWZihEGCUgstINUlioo45tdCefuGUEe7DeuGEKObmHOR94tCNTgy12eESAzxfZvyUl2/zpXHId6EI+0J9HNF5EtkpSAobGm2HeJNO0EkYPeHSE8ZMu+DNlzxT9qI33iP7X97UuJzEhLA=
Received: from YT4PR01CA0046.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:fe::14)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 17:04:40 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:b01:fe:cafe::8d) by YT4PR01CA0046.outlook.office365.com
 (2603:10b6:b01:fe::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 17:04:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:34 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:34 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Leo Chen <leo.chen@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>
Subject: [PATCH 17/19] drm/amd/display: Disable HUBP/DPP power gating on DCN42
Date: Wed, 7 Oct 2026 12:59:50 -0400
Message-ID: <20261007170412.1898315-18-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: fab97597-9c27-476f-6568-08df2495134c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|18002099003|10067099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: K/QkRTgRaDxbxEkYsYQy5OnEwHdTJgDCBpPWXPMyrlJeKouoWc3N3CZ9XEtZViyK/6n7ItkHd5LJrzDaP71NqRV0xMf0Xm7h10Wp/9pRI081DKhyutKEC5vbjXTWBQ40zzAACHUb05NnMh6PSB5t/B88YAgpf3P0Z5A7fnXyrIQll5W0W7gyZtyt+1dCPaeK17VR9AdbE9J8Mqh9sHVh9LAjkaP8Yyvc/hBk+C9uK6Kndjr6RpeLDNu4Y0KwcuGXOBISBmVhwg39DQeSfEWCdrYlr4LFoP+tS38Jdh7dei8Zwv73ecyd29dIrIVt/r6TFGjX9l9mBt3X/M8EWBkb2Hqlgf8B1Zyo5G7ICDUPpgNowP8b8CAOL/fiM+65fObiVWrGkjipqzSNfw7zby8JdoH0nP1Iy55CQBFSA3RTtwwA55BmXPh5S8AuZO1FMrmzcOB/8l43RtO7BZGRTAOwRYZ/me3OWGS3D9HN93D4NDtwdnNRwrtyXLKCQAcwKaoayuzNtD+RMSEX1BmU1LXEGJ9A2ojayuyKN3C0I/cf/MyQpIzbk/aOTfNvUmEB4+LTFRChHqUxfNKw3ejLGX3O07hRhJVXFmT+V81m2XRPuM5DAiE/wBMBEHkGNz9t9baFZg4rn2xETCf+1XOa/VgryHV567FeTxdKzxKBbfBFLSxdnum8KxL0Lmbhau5GQgM8mL2sXMmrOgxyREDVKQbL/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(18002099003)(10067099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9WrInQqUgmUOLKDzSRf037wli5SwONb+MPnjyQO3m3nsk6Sh1B/vQ0bFfFFHUSArONY/qq+1GAf3cfF2G9oQRXN92fBeoZAqPJet3PaFqPf1HtSxM+kO17rBkBbVsF+YTZoC0/FojB5G4MRakI5uuzWuQ7oI5U8C2s3ijPcTeaa4F1lIdWYxKR1EQDp6skWLg+xRru6M/RIyE0HCu7c6v8+0KkYzmhWSwx/abG6Z7QFwutjxMUfGBwy+fW0lATgDIGIGlX1Wxzi7XKqOEFGBHO19LWy7Wf1Q2GsyO9YszUE/QEpleaxT31HJHP0uiTcALL5qXKcHGiBa2bti10SaWXn4JzF/4+EHQT/DrfMtJoJZ1htM4z19fsGWDz6VviCMdtwrVz/a7uGrqKGHGubDL5/5fE2ux536HAebeDNgmBvhbIvDQ20urxo1fYOA3lPJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:40.1978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fab97597-9c27-476f-6568-08df2495134c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175
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

From: Leo Chen <leo.chen@amd.com>

[Why]
Driver-controlled HUBP and DPP power gating can cause display underflow
on DCN42.

[How]
Set disable_hubp_power_gate and disable_dpp_power_gate in the DCN42
driver debug defaults as a temporary workaround.

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 7c271dd264c9..a7fdffca8cb9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -745,8 +745,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.clock_trace = true,
 	.disable_pplib_clock_request = false,
 	.ignore_pg = false,
-	.disable_dpp_power_gate = false,
-	.disable_hubp_power_gate = false,
+	.disable_dpp_power_gate = true,
+	.disable_hubp_power_gate = true,
 	.disable_optc_power_gate = true,
 	.disable_dsc_power_gate = false,
 	.disable_dio_power_gate = true,
-- 
2.43.0

