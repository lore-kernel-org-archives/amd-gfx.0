Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11CCCEE342
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 19:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B73F10E7D6;
	Wed,  9 Oct 2024 19:25:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C1W/DKb5";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1304410E7D6
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 19:25:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oik6ecJa4odx+a/7bocMJxVu2W+88A+kMM6AoixpCaMTybeSXilspCAY4AS1aUu/pObOn+ceaL0p9S51xbccvpkFeQHlgzRHkNGetof00z7o3FF00ABP+OJZljStctyBXan/40aQv/vrX9S8aA+vI/k/n/VGO6eWWy98Ta/7wPHB9dbOxFGXo4aMFTz9YztYm11JGgwgDIZK0blTV7nDJ1h8MDvB3Vgo+f82Hh/1SomQgf2/2hu+lYFZZgYBBTkxus22Lvm+Dhh1cG4/Er6SEWBSkzOYfxMVKK8Dqjlxr+H35qoUQUVhzvZe0oHpC8s+v99bKIJn9jGLmLfBJqczCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NdTJpIeRdXTLV5733SqHZZg/agCRfIY7X7zDGqrQvw=;
 b=PNwRtOOZFBAPdljZqswxDdjICspKpD3pRMFeD2ef2z5NZ1/6U4uLvb3uVvGeWeDe9DH70wu7ehMjEVbgKOYULluusnjGqhtOdYFfSdKs/VfQh3PY1w/x8VQXpYhzqkZLQZaQBPIfsxKCeAnZjUHMGrAtbowlnFZLL1+kJbs7L67UEXS0GnbIeBP9CrhCR+FnJ2T6b+AjuS32vQiLsZhq9mND14+xllPDCRf9tFY2C+0cjvR6ltnUZX/cM8KExbabpnYtecWjux89wb1zGxnsPPU++cozT5ljp9z94mKCv4IHru/ruXwCL/yA+Liq3E15Ce1lVQJYvcvqjKFJ03SwOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NdTJpIeRdXTLV5733SqHZZg/agCRfIY7X7zDGqrQvw=;
 b=C1W/DKb5ofS7Cs2JklgsvpFRNuhWRnJ+NhTs9blHoKBZQU/UmcqmmyENW5tnVhwkTAKR1ZYXte+r3d3H9LOXy7/d0BrKi1P/QvDbWkbL9EB+CpAon7LPcanb/LRlKGC1FNirOAstdkDxGRfH0VYnKRMB53CZKT2fiUo6du3MXFo=
Received: from BN8PR15CA0021.namprd15.prod.outlook.com (2603:10b6:408:c0::34)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 19:25:50 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:c0:cafe::25) by BN8PR15CA0021.outlook.office365.com
 (2603:10b6:408:c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 19:25:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.0 via Frontend Transport; Wed, 9 Oct 2024 19:25:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:25:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:25:49 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 14:25:48 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 03/16] drm/amd/display: Remove useless assignments
Date: Wed, 9 Oct 2024 15:23:31 -0400
Message-ID: <20241009192344.650118-4-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009192344.650118-1-Roman.Li@amd.com>
References: <20241009192344.650118-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 44951276-dced-4e9d-817f-08dce8982ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2SnltcRjXaTjs0JvV8GEELD6cbwXgKoq36mz5OJwdf07hTkhBdQ9J88cPihY?=
 =?us-ascii?Q?e3RPzYqx3GS8YslQ+auSzg0mq6Q6djXzFBoQnIjXcdpH6T9W1MLTHyd6KO2k?=
 =?us-ascii?Q?xbHVg2GxNCWP+EB78ARWENwxPaFErdK4Q2LolwWggv9zAUq8g6xMBL97EBgq?=
 =?us-ascii?Q?RVgElLsjYyXMHiwq9i35UWV9Ea8zmbPXjEKr8hjjoRPFhM6LzW0C6lDJyW5P?=
 =?us-ascii?Q?KEk8pWe/NGbOY3LCwvw/ti6/04gO7EgtrzWEo6hMIQomH99OqCbwbcza7zAv?=
 =?us-ascii?Q?snv6/4H6O3/QM/heEFWKu8Rrw2gc3PwRf40JMhXdTZMYeWm97hs9EI3D33Th?=
 =?us-ascii?Q?v6xeRoWMP6ZMjck3l8kNsTVhVR3n6MO71TidqHR5as7+lOuQ4etL/d8Ke7LU?=
 =?us-ascii?Q?FUUwOToSZ3Qqwp8GdQSyu7LAJTgDB6Tb6EzLF4H6EfU6SMFJm10TpOl3Lh8d?=
 =?us-ascii?Q?LNELnD8WltAeVszTfN5krkJRS566qFbj+kGiNyzMvScRIgD2LpUh9v0Mk3pz?=
 =?us-ascii?Q?K7hTilCoWBScc6bMt+YtGYDMx9Db35IKbAHDvtPC6vhIsqwfNZeQJAeO/sTu?=
 =?us-ascii?Q?2r3M5Ju3UDK+Gw8/yUMIw3zeoOWrC8kW7xF2Kv/dA3ksws1G+lDBCRXjDW+Y?=
 =?us-ascii?Q?R83jTzcGa7yRfnUbj1mbmQyh08Y3OSTz7TlXKut/wbePyW9WEz2LEhxXqWnR?=
 =?us-ascii?Q?o8Zj/9ZQefcQArwGyEGXfB0miraCqifCXkVc33xS4Tl5kKRJnG+ka+tEGt0X?=
 =?us-ascii?Q?5H8RKmgQc8cWjbuNxZXBMlAB9ySqTGBbUai6o374J4jXV1HymoVkDpeKrPMR?=
 =?us-ascii?Q?DBpbIwgSRrFYbdvOIOtbS+x17sJImcFqQWTw12l9d+7Asxl8q6FJrSA+HPvC?=
 =?us-ascii?Q?UyiWa0iP5wHHwRNiOCXyZK3ogUBKCULEby6YkM9zp4Ol4KEqcKaCy/Bj4clD?=
 =?us-ascii?Q?L5Njo01HzfAl5fSxWNaIDnuRFX5hO6RZaM+yMptDwmpcmb7UDCo30JrgRysy?=
 =?us-ascii?Q?E/WKF+rWB3CqL2t7sQ+mNHsmduYkmOfQYtt0uMkJ+mUzLrrnPi/zG3HFOSvj?=
 =?us-ascii?Q?Y4nN0ZtxwI7Ag/jZaWF3zvqi0kf8SSV/vdY2efwL/QXyezvxjgcA4TLHsyVS?=
 =?us-ascii?Q?dgr9mEaib5xVU4y7lhK56RbLfNIJZzk949FUf5RS7KssVipBkf23p0JKw8JY?=
 =?us-ascii?Q?E+fggasEYen0bmryHuCdEKHDWrvvLDTcIcxjhshBgEfEY2hYS4WePnSVFuz0?=
 =?us-ascii?Q?6jyMeRUlfqzUqfrtKK/Jm8cc+K2eX1QRs/b5GuFnnFJa3aMk2IwUEiRTDGDg?=
 =?us-ascii?Q?2Hw2NcAk+G3lo28jn1VllLKKRL1s3veCIogwVHixLy19dQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:25:49.7494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44951276-dced-4e9d-817f-08dce8982ed4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
"split_pipe" are assigned to test_pipe and then immediately are updated
to other values. The same also applies to "status" as well.

Similarly, "id", "dwb" and "unused_dpps" are assigned but the functions
immediately return, and thus they have no effects.

As a results, the assignments removed.

This fixes 5 UNUSED_VALUE issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c              | 2 --
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c              | 1 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c         | 1 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c         | 1 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c       | 1 -
 .../dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c    | 1 -
 6 files changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 866b0abcff1b..9190c1328d5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -209,8 +209,6 @@ static bool optimize_configuration(struct dml2_context *dml2, struct dml2_wrappe
 				p->cur_display_config->output.OutputEncoder[0], p->cur_mode_support_info->DSCEnabled[0]) - 1;
 
 			if (odms_needed <= unused_dpps) {
-				unused_dpps -= odms_needed;
-
 				if (odms_needed == 1) {
 					p->new_policy->ODMUse[0] = dml_odm_use_policy_combine_2to1;
 					optimization_done = true;
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index f344478e9bd4..b099989d9364 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -443,7 +443,6 @@ struct gpio *dal_gpio_create_irq(
 	case GPIO_ID_GPIO_PAD:
 	break;
 	default:
-		id = GPIO_ID_HPD;
 		ASSERT_CRITICAL(false);
 		return NULL;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index a6a1db5ba8ba..681bb92c6069 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3453,7 +3453,6 @@ static bool dcn10_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
 		r2 = test_pipe->plane_res.scl_data.recout;
 		r2_r = r2.x + r2.width;
 		r2_b = r2.y + r2.height;
-		split_pipe = test_pipe;
 
 		/**
 		 * There is another half plane on same layer because of
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index bf9b5daea2af..9e1777f727c4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -486,7 +486,6 @@ bool dcn30_mmhubbub_warmup(
 	}
 	/*following is the original: warmup each DWB's mcif buffer*/
 	for (i = 0; i < num_dwb; i++) {
-		dwb = dc->res_pool->dwbc[wb_info[i].dwb_pipe_inst];
 		mcif_wb = dc->res_pool->mcif_wb[wb_info[i].dwb_pipe_inst];
 		/*warmup is for VM mode only*/
 		if (wb_info[i].mcif_buf_params.p_vmid == 0)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 49a37f5ee28e..65176b59dcb2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1068,7 +1068,6 @@ static bool dcn401_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
 		r2 = test_pipe->plane_res.scl_data.recout;
 		r2_r = r2.x + r2.width;
 		r2_b = r2.y + r2.height;
-		split_pipe = test_pipe;
 
 		/**
 		 * There is another half plane on same layer because of
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
index b5cf75975fff..ccf8096dde29 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
@@ -412,7 +412,6 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 
 			/* 5. check CR done*/
 			if (dp_is_cr_done(lane_count, dpcd_lane_status)) {
-				status = LINK_TRAINING_SUCCESS;
 				break;
 			}
 
-- 
2.34.1

