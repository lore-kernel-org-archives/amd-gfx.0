Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7E4CD3424
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE9110ECC8;
	Wed,  6 May 2026 07:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FideXixp";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4E7E10ECC8
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFUIyvRd81SiSRYVlnBt+Ob1a4NWLJvYa9v37mQpTboNZGBF3HNT6zDpXduLz4gujhMgHUHDnIoH+PzcEg8IWzpO4pY34OsikpkhY3nhiY3Snz/EsXE4ezMXagEooZDCirM9ccXoFNGP4+bg7CMoQ2q63D/isyhzVKxR8Qn0vqJi1MJw8NHIgIGnRQecM2so+o42CAnsim7I/a5SiQu66RnSk4nrwR/V6t/4QkQBb0OYN1uNdRxXDnnymVj6PKeac9u1eFQuUi3o5jAB2I3AOPXz7oebmm6sG+GbtqwTLIXicbd7DoJG27GGlDzcnE/kpyxA+N8IglmnyHIiMyC2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcRLbWpt4+nkXuTjHP7HOqFmVAJ0x6KBGl0N0QpgRmc=;
 b=pOg9t4uGElsa08TzderCBQc/9ikeZiDbNZJrgOSBITTvtM/1yrTZH4ff4bAZaR4gdok/Ug7U+ZrvF8Zkpm0KxqbSmBJAXUdptrkWNcQiquY2NWRWiPZpk2YGWtoIpHJpvm9vyzDksu4XLsmqYuJYotu6wdqQJa/odW5hPe5rhe5Oeec3TaRTi8cAkd3EOQSXDl+ogaMSez40dU7c3HaN6qr0jsB1ulwZg8H+Ny9TX62Pj6chqEwp3mvrSgyNKgSoBvdMd9JbRT97Vwa19Vuat92i86Oyq4fAXuO5rBzCuhp3D4msxOGQdBcwiWUe6+Q7QZ3P/pHL7PVMZgBGR4Rp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcRLbWpt4+nkXuTjHP7HOqFmVAJ0x6KBGl0N0QpgRmc=;
 b=FideXixpu7sdoKj1MyjfAjD18APMxizPAnYeP4q6IOZmt+OiJK/SaaS5pY5LEoKHsK0V0P7J7mEaYR9JgkOjgLK3hHq++tTT6hwpGtaujP66kb3XGXnWYMynrgt6yG3gBEr91fBx3chvPKwwGI3Ztf7JDMa7A9p+Hgno691n2q4=
Received: from DS7PR03CA0179.namprd03.prod.outlook.com (2603:10b6:5:3b2::34)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 07:03:06 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::c2) by DS7PR03CA0179.outlook.office365.com
 (2603:10b6:5:3b2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 07:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:03:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 6 May
 2026 02:02:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 May
 2026 02:02:57 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:02:48 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, ChunTao Tso <ChunTao.Tso@amd.com>, Robin Chen
 <robin.chen@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 01/20] drm/amd/display: Fix refresh rate round up case
Date: Wed, 6 May 2026 12:30:59 +0800
Message-ID: <20260506043342.2164710-2-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: PingLei.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 17dab6aa-8056-42e9-9f02-08deab3d85b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: rtcN8kusg6GaSYBxJD8GU6hj3ScQbrnDQd6fO9hb3KYzetpptsOv3d20dgogHVMmJMhNcgSQE9g+Rn2wm4d86np7EdBnwR0TbJIEFeIuCsBKDbK629eAOfjeoyaAofZVAw4INwoj4FAIMz3amkCpcdL5NywuA4Kb056i/VVXGh89QFhTg3DJPwml3Rgu/CZOgOqRS4cYUS8sh5eCp+f8PvfqLhBQp18LEa1mPoP4GpK26tghYApE3UR2tVjzcCAkH7bPchR+9k64EIiZq/hCvUTbc7eHqik3VRYfvH0iPTulxgmxXlB4S1QXVW3fJ8vBtbOONRnjE6YiOsp87srRVdpqTRwG12eIz7cDWdp+InEUcO9CKe9aY/dDbGEUtSzELgbw5NlLnwhqubMO+ABadRI9MD5zKZsJ1DYPDO2lpAlgtn4BvZEwybhwgJh43biULhD3an19M+746qbDuLhTnY+V+Ga5oUq+szGCy3ASnJrqrJnqe3HZmPrYsDSFNrXaGzoHNR47HaRSO9NodqJw9BrBQSP5ggvoVQRzabDeNUbTcMMQwPMeMoENGJV9rPQrSv5O1Q3zP9jdeAbD/gsXG1BloOngd4UC+jfGa/VllLBydP/2L4xLhd4GicS9BL+79PmfOfiDz0ytecoGTxRKe2lg8cjb1KHiP0Xh29yCtpPEAV0AtjHAiefFgMn55qV+ynkOr5rkCm6dHJ4GZZswyXVbSyk9lZFs3qhsS1sxl6A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yBbUEJw2WwHVmKkOzalqB8D6xUECUIfPOX7qAcq+eOm0ydYC+B7bVCOF9nwP8rRxL0GRYEOba5ZUJ7zvrucRbYnSXo1/v96gdmPh6FnNuM7+0Eret3FczC76x8umVoiNHtGcpwwuy+XPLT5y2gnDd8xgah5IEV4AAGHk1N7C7lDQS3QO1w5UUsrEZyABzAAbl9ZC8NdnxYXTj9/ToqhYeBG271v+QILn9cBDpR4lJ2MCTY8maSwxXLtQnUM9hOY1Av3rtPtVu+qyT5C3MFxhWv9D4kd1jJFl7GKP/F/YbRrzN2eKMDmXn8sbyL00PDo8QYQMM0HbWGEm/25Jaw2ZavtqCqgdqubFq7RizfbK4EjFFl3qR52N6D7eGa+6m/M0Tzyda+1CKMsbPuUXMnvDmJsoKeo4WsKfqoJ+aDP6Aj5xUoFyCGljXuFlvba5IrVP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:03:05.7199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17dab6aa-8056-42e9-9f02-08deab3d85b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249
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

From: ChunTao Tso <ChunTao.Tso@amd.com>

[Why & How]
fix refresh rate round up case

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: ChunTao Tso <ChunTao.Tso@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index f8b763db9b8c..f55c15199fb4 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -993,8 +993,8 @@ bool psr_su_set_dsc_slice_height(struct dc *dc, struct dc_link *link,
 
 void set_replay_frame_skip_number(struct dc_link *link,
 	enum replay_coasting_vtotal_type type,
-	uint32_t coasting_vtotal_refresh_rate_mhz,
-	uint32_t flicker_free_refresh_rate_mhz,
+	uint32_t coasting_vtotal_refresh_rate_uhz,
+	uint32_t flicker_free_refresh_rate_uhz,
 	bool is_defer)
 {
 	uint32_t *frame_skip_number_array = NULL;
@@ -1006,7 +1006,7 @@ void set_replay_frame_skip_number(struct dc_link *link,
 	if (false == link->replay_settings.config.frame_skip_supported)
 		return;
 
-	if (flicker_free_refresh_rate_mhz == 0 || coasting_vtotal_refresh_rate_mhz == 0)
+	if (flicker_free_refresh_rate_uhz == 0 || coasting_vtotal_refresh_rate_uhz == 0)
 		return;
 
 	if (is_defer)
@@ -1017,7 +1017,7 @@ void set_replay_frame_skip_number(struct dc_link *link,
 	if (frame_skip_number_array == NULL)
 		return;
 
-	frame_skip_number = coasting_vtotal_refresh_rate_mhz / flicker_free_refresh_rate_mhz;
+	frame_skip_number = (coasting_vtotal_refresh_rate_uhz + 500000) / flicker_free_refresh_rate_uhz;
 
 	if (frame_skip_number >= 1)
 		frame_skip_number_array[type] = frame_skip_number - 1;
-- 
2.43.0

