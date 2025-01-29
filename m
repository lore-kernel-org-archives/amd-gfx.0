Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BACC0218A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 02:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2138D10E342;
	Wed, 29 Jan 2025 02:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="krWhCqtb";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79BD510E722
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 02:46:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDugli4BGY9Fb1gmkvPu7e1lx14yRD4+HkrjgpTBNZEeW4L4kGEefGCT3gKTxUJq6+pvKap8CoTk8LxAz3ZNiKYnCxrdaA1JXVYUy/c33z9CHU/lLBMt0MD0VEhtuKrbuZjmGVFhHkX3xqiNxFbY7l7OcWkXUomw7Cq1AA19xiwpIPNCSnbzSi5GNQJ5HPYZewy2am5LPduCpzj2sYgTVodocM1H75B2jI8oeAS8UwO95WggWhZMUOgW26QhRvWxLejEiJoq0DEnUs5MNG6vwIpaisBoDm6l8H007D4QgXZUUq3IT5HmV/BMA41zZBu7/R6OvNwXKKTw482aP0n0zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOhUA5mJZQR/q1sCWgi72g6PrbxwTEdbmXhBhabe49Y=;
 b=YqZQMocsCpB4piv4pvBuF4xs+8mb1BEQ/nhWPkIesdLeSJvVJkbhdnOmK8LopzEx2fAw14LMCE37qcdCJXEqZFptL2bQ+3r5I+NqSp6Kr6E05lqshGsOTsRhk8t7iYfPwNNoAiNvbwKtLEUI9ltAa7+h/2cLHKO6rGr+TaVaY/wy69uHrn2njgAx5sJVVcf+GzeLCnpojDgrBnSkZkRNWJuca4owcnY/cxiUlP4Jrw2mShTOe3Rns6Zc1qg5Uy0M4qIgM1sihIC5kueYdJAIYblifDWsIBQ1GpdnqdDHMKQokFXjy955gEThLG/G7peCPJ4AuMc+79m3L11Zeg4IhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOhUA5mJZQR/q1sCWgi72g6PrbxwTEdbmXhBhabe49Y=;
 b=krWhCqtbgHjX/d+p+dT2pik2BdL3HqLIRjtIDh2M/t3pUuXZjcs6zNueCT+Ty8nqUfDgdql+UoG927GtQ1qKRu8JYt7pYQ5flwm6LCHBvVr0dQJLovFYPGD0eSW26MYhtTv1vonN88b6aMtcSkLbIcOTz2iFtiTW1sJwFCjKTWc=
Received: from MN2PR07CA0002.namprd07.prod.outlook.com (2603:10b6:208:1a0::12)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 02:46:19 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::1a) by MN2PR07CA0002.outlook.office365.com
 (2603:10b6:208:1a0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 02:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 02:46:19 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 20:46:17 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Brandon Syu
 <Brandon.Syu@amd.com>, Charlene Liu <charlene.liu@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 03/10] Revert "drm/amd/display: Exit idle optimizations before
 attempt to access PHY"
Date: Tue, 28 Jan 2025 19:41:39 -0700
Message-ID: <20250129024432.2107937-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129024432.2107937-1-alex.hung@amd.com>
References: <20250129024432.2107937-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8b4d9a-8a02-4820-15b6-08dd400f1bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bUkQPxvuwchRtCv733zlvQXBwxbHf+qu4U8DUOsIxBPEAudmgqVbGskor7gb?=
 =?us-ascii?Q?LNwqL+FOH825LM6VOydx9vIKH+fzqNTHuj3wFtf0UGIdDyEvQhwwaAZoQq4M?=
 =?us-ascii?Q?wdRxn8gkEBSu61bm2WpTGzq4mBDjFzxYFyOCP6nNahiE8AL8AAX3mK5KEKsV?=
 =?us-ascii?Q?oftK2kUjTHSKjvLAudwVO+VoTOe/dIiF1qESnPqiqewyS/FDiyYJ3B6BGhTE?=
 =?us-ascii?Q?IW7hU8JDogfVPQVBGk/ibDSMqiP8ghLR4MyicaX1d1Yhg3IvX0jJGbIootuF?=
 =?us-ascii?Q?HSW8vg9dJCyAJ0RJbVMUBYlh8MYPvkOM7HV9NkFSsUdzOtucXq3f1TKnbAbD?=
 =?us-ascii?Q?o45n13oGCCvVZ+xY9KrXQ5J4Voa6DFn0OfsXQvTV0ywJFUs7pldUYzM6F1v5?=
 =?us-ascii?Q?fCqFzCXFtYff/3kVgT6IkmR/NbALxZEMPiTjAdsfNAje9hcniieS3aFYQLyi?=
 =?us-ascii?Q?XgYig8/JU3GCocLa5DExZrsgMPTHE11/ESCUAo24F8mQdBAAsJthEeD+NK8H?=
 =?us-ascii?Q?3mZnMRIF7elaAR9Qve7FQsc+/BuUoz9t7JCRKGogEUurBhvSS0cgLdfYoFdv?=
 =?us-ascii?Q?S+kP8ZsA7TSEXvVWy7rMwzbO6NbU4irzJULJ3p+2zpJ5pE+HbSlAb1pFyyO5?=
 =?us-ascii?Q?zmgh27OMT9MjGSemj0ErDyg+AYw39krHBjgDzvYtzdwmXA+Oho72bPgDr24O?=
 =?us-ascii?Q?bC/+KkzJgRDydYpz6ctyqv9BltQy46yN2CZ0Ssi0e5gqgj8KPDX8gdxcmLyS?=
 =?us-ascii?Q?L4WSNOtzjruCwfzriIk/4dcjwtoKFlrCf0Q8/8e5zPCRD1idViHvQDe5rQmz?=
 =?us-ascii?Q?+zPhbH4mM13EbCEz/b17I48h3BQEYSzbGpWxWXKm8kM47K7Gpf3x6dizlp7P?=
 =?us-ascii?Q?BhvQ4FAUW2F6qSDjE62oeWTOrp2L3wMcyohPU1x5J21rpqN1encCCJzgQ5hs?=
 =?us-ascii?Q?hhsTXUEbymcL/v6QCNB+ZU2iVJSXKT0liq/7DMkDffmVia+EtgdBFNxQ6KzI?=
 =?us-ascii?Q?5SBlDIbA1aAjRvHJfAKn2nJE5xIENOS6J916VnUKvlJSCNQ8WTSIyu0TWN/y?=
 =?us-ascii?Q?qf487DB7jwrZZeG6/L2RPXZ2xJ2ssT0ahxQu9URXRS8xOvKW6ljA4FJBvwbm?=
 =?us-ascii?Q?l0Q4Ck/U+IPZdpQyNcR4612RBhOQD+gx31rxwUM9Tssx54SW6YA6S+mn2itF?=
 =?us-ascii?Q?FEQvS4llyGbPP4JFVpxxOR3/Xa8gkAbk6jOpG71dvDfOar6du8gWcisduMU6?=
 =?us-ascii?Q?ymB8ckjo4802wSsNjySLYs26OkqiQqmNbr29FfNbPMHuGHr6sEjUcMc6rFog?=
 =?us-ascii?Q?RSdqkhLFtOiI1HFB6PmgVB1AmJRe6rW6/hTB8e3mZKGPC1pSPpVV+h2WtKYf?=
 =?us-ascii?Q?V2OF2kVZb48PevhoRVfEzMofCkX+S2T8v0guLW8AseHNOjSZW6uBJd7IxnsD?=
 =?us-ascii?Q?io2F6ChBkKnz4Gjs4NuTcDaE5wb1xXWh+9UvcW6cQBpqy4ySs/1jHMlUfatJ?=
 =?us-ascii?Q?ST3dMPIO1OEnkGk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 02:46:19.1792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8b4d9a-8a02-4820-15b6-08dd400f1bdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574
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

From: Brandon Syu <Brandon.Syu@amd.com>

This reverts commit de612738e9771bd66aeb20044486c457c512f684.

Reason to revert: screen flashes or gray screen appeared half of the
screen after resume from S4/S5.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Brandon Syu <Brandon.Syu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 81f4c386c287..e033e6476fe5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1890,7 +1890,6 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	bool can_apply_edp_fast_boot = false;
 	bool can_apply_seamless_boot = false;
 	bool keep_edp_vdd_on = false;
-	struct dc_bios *dcb = dc->ctx->dc_bios;
 	DC_LOGGER_INIT();
 
 
@@ -1967,8 +1966,6 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 			hws->funcs.edp_backlight_control(edp_link_with_sink, false);
 		}
 		/*resume from S3, no vbios posting, no need to power down again*/
-		if (dcb && dcb->funcs && !dcb->funcs->is_accelerated_mode(dcb))
-			clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
 
 		power_down_all_hw_blocks(dc);
 
@@ -1981,8 +1978,6 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 		disable_vga_and_power_gate_all_controllers(dc);
 		if (edp_link_with_sink && !keep_edp_vdd_on)
 			dc->hwss.edp_power_control(edp_link_with_sink, false);
-		if (dcb && dcb->funcs && !dcb->funcs->is_accelerated_mode(dcb))
-			clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
 	}
 	bios_set_scratch_acc_mode_change(dc->ctx->dc_bios, 1);
 }
-- 
2.43.0

