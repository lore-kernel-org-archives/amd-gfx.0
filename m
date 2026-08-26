Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DF3C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 301DC10EE49;
	Wed, 26 Aug 2026 23:24:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AnNssmoL";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010001.outbound.protection.outlook.com
 [40.93.198.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 213AF10EE49
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:24:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nr4CTctTiFQlJ3CAEsw45OPLibtRJnXIWxM9x+fbv7ObSE4Me1jrB18TMTbEmkEZ4hoisCcwcwsqx22+NtpRs100o3i0LMctXFT855D7QsFQ3fGwM+lwAb6pz2O9JRjhRDaJSujq9Cg3LbDFR2BvKUucgNy3QFXTVJHypY2oK5EWgl43thWmVumdPdiSuDqAKX8KPUDKiCJkvkpcWHQdYHK/P0Q7ZE9XTAstqdjG4z75TtyA2WAuVIrLbHfLgWTJaE1N0LyFAdQjjeDwfkvu5tQnuv2OxL3rjsozADKuNZ0ScIz6OhWcRviQaddxRj+mmU+GPPR+9WEyxOU4BjtkhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlyakZntkRxOnrfo5KwyQIH3CQGlPqzGtP7G6j8zWjE=;
 b=a/urs3KBL8dWFZXvSXG68MGHjTfia5/wwe4PbCmJX6Ko+38g21I48vgGC6U0J2wKAT5ePWNf6Uo/DHRvhwZvQ91naH6b8DTzzSZfuvyBeQrGjLrAqZ3zxA64nk3Dj3NagVRHid5izPiSrv/Lfx5HZtd5AotMQSlUHGY8uANHEObmSAguSRBtH9S8ZO8eNqdHmnCD7AZUY/Ge9epyauDGXXejZ+ULjbWPI1aaR58c71gUzyycFB2vFdwc0kcrpU9vWMo1lFBlhJnSyNaUo30gtASPYXwC+h9xwoStQukHLLIvEfp1hE0kilfr+mgJ0ypMxWNq4P6UJqQUF+/2iWxjow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlyakZntkRxOnrfo5KwyQIH3CQGlPqzGtP7G6j8zWjE=;
 b=AnNssmoLXrT8Nr1GRlIyuIJg8jUcokCLfKVKy2yfQOEHYwAhobtrfTzYFmG7xPuxGz1PI2iSLCkXTzRf9rSTPmbMmGRriyFGLG9fWHwkfCEpZkSuQf0BtT1xGnjp+Ze1nwto57vIQC+wKFEzu4kPGgSupA/2Sk55dFkEX+yytVQ=
Received: from SA9P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::17)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 23:24:11 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::56) by SA9P221CA0012.outlook.office365.com
 (2603:10b6:806:25::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Wed, 26
 Aug 2026 23:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:24:11 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:24:06 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 25/59] drm/amd/display: Change RBBMIF timeout control
 conditions
Date: Wed, 26 Aug 2026 17:04:56 -0600
Message-ID: <20260826231519.881949-26-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: e03f8f60-8971-4c36-4f63-08df03c922a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dMQC9lpBQqIaj0OIJnnzgEyeMjb3TOPpjZANq2tU5GAhCci+8CDjMMy3ESgNyh+N3n992BRxMaMOp+DBK2yjfyd7AmlL6kPGgqgq1RUuBjVtBmGONj6tjQKOquxrPtmYlKRYnZDXPEMo++Tjx/+SVWcqTIVPTSaEG2ywfZpMMCBNQZGjDG+tswUaAOPTqp1F/cI+ck/FIjAfUtXCbNWCcAmyF9IgOOV2+trUNHkM7ittzxK8FpFdyB5EB4bfbrNFEY4sXOV7IjED2W6S6CkkMwCMScJFXkklChgosh2IkL9De6jwo7G0Obawjtk1OEIm99yArtWGyPfQoPean3jDn7xZL4uaG8q/7HHoGzHp5nUEMzxO872fmFKQr4QJMvjoP9QTj1QqnRnOdznTemXRalSye1VNfV9zmXhGVc3oKy0YhtT5hW1sZ2BU1EBVYmodBp0OWs2d0b9agol1U2IvJURoPBVYBQhez4VFyIbMKj3b/djrMZalaD7nwu5AcehtAd07DrdHbC4h4o0IdQg4j/a/42y1loVZ657KH5Vn7nMMAL1HSKcxIWasFvb1N+zLcFdafUzsumux5PZDe6ytZNAatWRCE0Tck4SsIVxDU99AlcUN5DBqS3VFSR17nvbHk1Ltb1Su6coDygnFCa9w5T8YgUprr5ilCu3omMRtfusRMn/R5/cUlxhZ2diUS9Kq8sAhsYj5Awbilxr44SDOiw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ggAMOhvrCQt4N3jsLJCvY9ImDVsPvGJAiaQRhDfqj7Nm8Ly2BMm5Zil56hbOZ+Agp6inB7K/IycGV+CK5s/owbL20yngPQOGvRy5Uz7gRzZtwsW6td1XQVvPplIqu9hg5xgRiZOSXSeJIyu9DMFxJbU1Pipz9jM0kmiy4kL8MC6uLU2DWmMO0FFKOSUplvFkfBW89ZhnGldtaU7ZXkrkorcP50fdeugj2Xg/c4Bn3Y1uzJQsP2HpwVpTVpXWoaY6MZjphx5wOP0sj5FDbLasNMQWw9cbZF5/oG+juLYhmccdQwVu/VWyvUwn/9S/Bdz+i1GyQ1Zmb0ob4F0aNhQM8mqPpEU8e9B+fSinalnHsuKl1Z7FzNNSGGb99ruzLDETKsKuxeHDGHO4y4yt7Oz6r5+Wt3Py3YEFhon614Eev+kMvubDkWkxQ36yryj8Fbis
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:24:11.3178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e03f8f60-8971-4c36-4f63-08df03c922a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
RBBMIF timeout should not be disabled to prevent register access
hang.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 38d587af9dd8..1e60b852e61f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -3208,10 +3208,6 @@ void dcn20_fpga_init_hw(struct dc *dc)
 	if (hws->funcs.enable_power_gating_plane)
 		hws->funcs.enable_power_gating_plane(hws, true);
 
-	// Specific to FPGA dccg and registers
-	REG_WRITE(RBBMIF_TIMEOUT_DIS, 0xFFFFFFFF);
-	REG_WRITE(RBBMIF_TIMEOUT_DIS_2, 0xFFFFFFFF);
-
 	dcn10_hubbub_global_timer_enable(dc->res_pool->hubbub, true, 2);
 
 	if (hws->funcs.dccg_init)
-- 
2.43.0

