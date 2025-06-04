Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BE9C5B549
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 19:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB8510E7FD;
	Wed,  4 Jun 2025 19:41:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aZu/SwyC";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A1E010E7FD
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 19:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5+wUh9nVT4lVvRYrXWrKD8OZpgyLbPo4uKQjh53ijn1/8s1kx9y/rCEjxf8phO452hy6Gk5bjsk0xE2Us9DkZVEVEFLPl8EVx5eNtItvSYp8yQCPPZ1lSYd5PwCnNhqYQwuEcJefPBEgnMAkOMrij3MdYrlQYV7NgsbAImGE4v2Fqjy1ySkVNIlS3yTyHF5keqclE0kW1neKmwG59R9C60L07O4lEL9SUBskYMYOuqfDkcnPsh9Tv1xY2k7NGTEAE8ZZ9z0w0B3q07NJZV8VucxyXRPf3Ad5a5/X8cIFoPxz0erFrZcQLVscU3bGhskzp038yJCQ+jLtMHatgq7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFziXC9F+D2aNa8r7rRzEmoGMwYGoY+kFgWtdwFM/7U=;
 b=jWRkbFr1HQKitw+mIeO5c0RbDA1EJGdoO7/2xygoxINZwCDCs/T+UCoOqTTkjTuxWgkiMVuSE/FZmtoUXZtaHoqExZPyZAP0W7LV8kiQRgUcv/df98HspkXSP4AfwHrDbaGnvgpWYKEjdEQMj3ThBMvi18L4JKHpOQlWMCntP4UntRXzM2PQiXgrHBokStfXu2FUji4pFO74kjN78qNrJlyrolBLpFNQP7YWYLxHvCWtNCWEkewJsatXc+KUyUHKeuKNWS+xmRbjKyzFD7JPwPUhSMQnZ85SjF+erSIqq7i6Kj2JMjnS0mLP0orLyZLkP/mZDb0zBRSQLRPSbAhAyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFziXC9F+D2aNa8r7rRzEmoGMwYGoY+kFgWtdwFM/7U=;
 b=aZu/SwyC5aeCBUTyGnTmtE26S43m/1yMmhvYgbw4hp7cLMaCwaeBjW0P2fqyYmDH45nghvOD++osHt/MhsMQx+z1PqGTkgA9STlweQw2/2lIZreAi5hT0+2fjCp/vo0rsI2a0BGsoSExUVy6RWd8sY59BrF8DxqNwnlWawJQkgE=
Received: from CH2PR19CA0004.namprd19.prod.outlook.com (2603:10b6:610:4d::14)
 by PH7PR12MB6693.namprd12.prod.outlook.com (2603:10b6:510:1b0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 19:41:22 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::3a) by CH2PR19CA0004.outlook.office365.com
 (2603:10b6:610:4d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 4 Jun 2025 19:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:41:20 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:41:18 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Yihan Zhu
 <Yihan.Zhu@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 18/23] drm/amd/display: Add RMCM debug logging
Date: Wed, 4 Jun 2025 12:43:29 -0600
Message-ID: <20250604193659.2462225-19-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH7PR12MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf96132-e61e-4bd7-cb5d-08dda39fc824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1GvCLZkpu/o/n8EiW56iSJem+Po9qv+uTm7ZZpwJ80VYUQHUVJw1WvFLQng6?=
 =?us-ascii?Q?5Heb7QcCpUhg5FGqXzBiUAeGr2SxwZz5OWy68Rpf08iB0zBukhRuhLILQvVd?=
 =?us-ascii?Q?GcQXeuka+0LQr0NpXSFRyBiEL2XP4o6BkNq8+/HJ4dbkx/RRbTudXFkUfAKX?=
 =?us-ascii?Q?AmMtMFMUDnGx/bUKJqOiB4pxQWrLH9Q9NE/Z1bXCr3Z0L/P6zsFYwnn9l0HO?=
 =?us-ascii?Q?8xrNcdkqziOluakBYc+AvwQJ1V0DwF1o1YoIGy54KUn57d5VNaLD9vMjV+0q?=
 =?us-ascii?Q?I0FfxuqsIOj7x1ZtjUVBlQYN4E5kcAA58IH46ui+8mwWTN7JOO/dt2dsXDQX?=
 =?us-ascii?Q?+wdPmtc+++fvpU8E8XPWDHmOeTWkwX9D1mXxiDWJGpb1EXiCa2q+Iow6A/3D?=
 =?us-ascii?Q?J9fe5yYDysRClh+oljk7oRi9jpMA+dYQoWfjT0yj+T6FuYQtRrz8L5+KzZBi?=
 =?us-ascii?Q?z1JSamnVVGj3AM+CK+XZ9gBRPF50KMCfR+UWNQ0D7KbJ7UtEPClO77pdc6Gx?=
 =?us-ascii?Q?iRRFnfFCDGq2plh4NXv63fr/LdPrWNXi8zBP26KSG5vSGdayCnZ92mnMe0Iu?=
 =?us-ascii?Q?BoNL7HBTp7xkK9Meqs3a+6ndptwIuVVJ3+83k260/I3EyBBbb/0SGnCyQFVW?=
 =?us-ascii?Q?bDw1+u+jQdxCF/ei6fUNqGNAtbD0SZOowbN3hs2OxhXzaAv4HAxN84qeKfgM?=
 =?us-ascii?Q?wqYYbRYIo9yjLgWakmmC9aNl0Te9WU/52jFPLSnqIz2Ee7B1kmB20/8CqJE3?=
 =?us-ascii?Q?pVR5Kg317nPoQVbET4nlOt+zAulKDE2YilSX21/xbQQw+qfxkDheDnYI/2Vt?=
 =?us-ascii?Q?7hKgXF4Zz3fP8WcKhm4c8I7MQ0vm9uy0wPfMOEh9J2PCN8pJdeYF5SNKWraT?=
 =?us-ascii?Q?IeNdhMyFkNoKizK4b4h/KhikNtNp04qjA7MbR4LzTQyRqIblVBZyskDuDm+G?=
 =?us-ascii?Q?o+/wTibBXp5e3QeJzmxHwe2Rp5bduxOiwJiEzGTnfVSNsVu2gqDug1+EE5BA?=
 =?us-ascii?Q?1pDIT9AAb9njGtg/Jt8s19ChZ3sopxZVOp8ped+a3glLmIiTekc7plyy5hTe?=
 =?us-ascii?Q?l5Qs+Ku5r3eTUJyYp5HcCn0TROkLoa4N33YkkKx2qyoehxnKyUq459k3qF5G?=
 =?us-ascii?Q?pfzYW2qmKgMuXW313HADYEvTiCuBxcZwcfjWJa/zeYTJcRrfFzHdhaF+D0WU?=
 =?us-ascii?Q?KObs4F1W8Y7SRnZ6XQ1lcQ7HpHqZJvc4lxnEri818FC7yPug13yeY5VE2yih?=
 =?us-ascii?Q?4/urTVCCXxemF+uqkE8vYaWq+ZjFYmg0Vgg3GUciFKTHleT7y0JJwWDi5tkt?=
 =?us-ascii?Q?uK6wyymD7f9xBitcneqagXy5ogpX6aWZn8iNy7DxayqcgtCnevKukyIsyw02?=
 =?us-ascii?Q?lhemqzfGCJW9tXLsiU+KfZ7lZDY7n+Ib6ysPmIfiEUpROqL5Q5Qwk4jyIl3G?=
 =?us-ascii?Q?a6smJ4n6WUFmfqJS1qSPwT19FUzdyx8UuZBCOSmMGWNQYkRkjPX5QDI7wqlE?=
 =?us-ascii?Q?vG+j1Jkc9j9VI0xQfwPLdJgHhLxq/3QNVtNy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:41:20.8667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf96132-e61e-4bd7-cb5d-08dda39fc824
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6693
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

From: Yihan Zhu <Yihan.Zhu@amd.com>

[WHY & HOW]
Add new FL feature debug logging into the existing DTN logging.

Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Yihan Zhu <Yihan.Zhu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    | 19 ++++++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 59 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   | 37 ++++++++++++
 3 files changed, 115 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
index c7765e6f09e6..f8f991785d4f 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
@@ -666,10 +666,29 @@ struct dcn_mi_mask {
 	DCN_HUBP_REG_FIELD_LIST(uint32_t);
 };
 
+struct dcn_fl_regs_st {
+	uint32_t lut_enable;
+	uint32_t lut_done;
+	uint32_t lut_addr_mode;
+	uint32_t lut_width;
+	uint32_t lut_tmz;
+	uint32_t lut_crossbar_sel_r;
+	uint32_t lut_crossbar_sel_g;
+	uint32_t lut_crossbar_sel_b;
+	uint32_t lut_addr_hi;
+	uint32_t lut_addr_lo;
+	uint32_t refcyc_3dlut_group;
+	uint32_t lut_fl_bias;
+	uint32_t lut_fl_scale;
+	uint32_t lut_fl_mode;
+	uint32_t lut_fl_format;
+};
+
 struct dcn_hubp_state {
 	struct _vcs_dpi_display_dlg_regs_st dlg_attr;
 	struct _vcs_dpi_display_ttu_regs_st ttu_attr;
 	struct _vcs_dpi_display_rq_regs_st rq_regs;
+	struct dcn_fl_regs_st fl_regs;
 	uint32_t pixel_format;
 	uint32_t inuse_addr_hi;
 	uint32_t inuse_addr_lo;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index f9ee55998b6b..9ad29be925e2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -327,6 +327,35 @@ static void dcn10_log_hubp_states(struct dc *dc, void *log_ctx)
 		}
 	}
 
+	DTN_INFO("\n=======HUBP FL======\n");
+	DTN_INFO(
+		"HUBP FL:  Enabled  Done  adr_mode  width  tmz  xbar_sel_R  xbar_sel_G  xbar_sel_B  adr_hi  adr_low  REFCYC  Bias   Scale       Mode      Format\n");
+	for (i = 0; i < pool->pipe_count; i++) {
+		struct dcn_hubp_state *s = &(TO_DCN10_HUBP(pool->hubps[i])->state);
+		struct dcn_fl_regs_st *fl_regs = &s->fl_regs;
+
+		if (!s->blank_en) {
+			DTN_INFO("[%2d]:  %5xh  %6xh  %5d  %6d  %2xh  %2xh  %6xh  %6d  %8d  %8d  %7d  %8xh %5x %5x %5x",
+					pool->hubps[i]->inst,
+					fl_regs->lut_enable,
+					fl_regs->lut_done,
+					fl_regs->lut_addr_mode,
+					fl_regs->lut_width,
+					fl_regs->lut_tmz,
+					fl_regs->lut_crossbar_sel_r,
+					fl_regs->lut_crossbar_sel_g,
+					fl_regs->lut_crossbar_sel_b,
+					fl_regs->lut_addr_hi,
+					fl_regs->lut_addr_lo,
+					fl_regs->refcyc_3dlut_group,
+					fl_regs->lut_fl_bias,
+					fl_regs->lut_fl_scale,
+					fl_regs->lut_fl_mode,
+					fl_regs->lut_fl_format);
+			DTN_INFO("\n");
+		}
+	}
+
 	DTN_INFO("\n=========RQ========\n");
 	DTN_INFO("HUBP:  drq_exp_m  prq_exp_m  mrq_exp_m  crq_exp_m  plane1_ba  L:chunk_s  min_chu_s  meta_ch_s"
 		"  min_m_c_s  dpte_gr_s  mpte_gr_s  swath_hei  pte_row_h  C:chunk_s  min_chu_s  meta_ch_s"
@@ -511,6 +540,36 @@ static void dcn10_log_color_state(struct dc *dc,
 		 dc->caps.color.mpc.num_3dluts,
 		 dc->caps.color.mpc.ogam_ram,
 		 dc->caps.color.mpc.ocsc);
+	DTN_INFO("===== MPC RMCM 3DLUT =====\n");
+	DTN_INFO("MPCC:  SIZE  MODE  MODE_CUR  RD_SEL  30BIT_EN  WR_EN_MASK  RAM_SEL  OUT_NORM_FACTOR	FL_SEL	OUT_OFFSET	OUT_SCALE	FL_DONE	SOFT_UNDERFLOW	HARD_UNDERFLOW MEM_PWR_ST	FORCE	DIS	MODE\n");
+	for (i = 0; i < pool->mpcc_count; i++) {
+		struct mpcc_state s = {0};
+
+		pool->mpc->funcs->read_mpcc_state(pool->mpc, i, &s);
+		if (s.opp_id != 0xf)
+			DTN_INFO("[%2d]:  %4xh  %4xh  %6xh  %4x  %4x  %4x  %4x  %4x %4xh  %4xh  %6xh  %4x  %4x  %4x  %4x  %4x  %4x  %4x\n",
+				i, s.rmcm_regs.rmcm_3dlut_size, s.rmcm_regs.rmcm_3dlut_mode, s.rmcm_regs.rmcm_3dlut_mode_cur,
+				s.rmcm_regs.rmcm_3dlut_read_sel, s.rmcm_regs.rmcm_3dlut_30bit_en, s.rmcm_regs.rmcm_3dlut_wr_en_mask,
+				s.rmcm_regs.rmcm_3dlut_ram_sel, s.rmcm_regs.rmcm_3dlut_out_norm_factor, s.rmcm_regs.rmcm_3dlut_fl_sel,
+				s.rmcm_regs.rmcm_3dlut_out_offset_r, s.rmcm_regs.rmcm_3dlut_out_scale_r, s.rmcm_regs.rmcm_3dlut_fl_done,
+				s.rmcm_regs.rmcm_3dlut_fl_soft_underflow, s.rmcm_regs.rmcm_3dlut_fl_hard_underflow, s.rmcm_regs.rmcm_3dlut_mem_pwr_state,
+				s.rmcm_regs.rmcm_3dlut_mem_pwr_force, s.rmcm_regs.rmcm_3dlut_mem_pwr_dis, s.rmcm_regs.rmcm_3dlut_mem_pwr_mode);
+	}
+	DTN_INFO("\n");
+	DTN_INFO("===== MPC RMCM Shaper =====\n");
+	DTN_INFO("MPCC:  CNTL  LUT_MODE  MODE_CUR  WR_EN_MASK  WR_SEL  OFFSET  SCALE  START_B	START_SEG_B	END_B	END_BASE_B	MEM_PWR_ST	FORCE	DIS	MODE\n");
+	for (i = 0; i < pool->mpcc_count; i++) {
+		struct mpcc_state s = {0};
+
+		pool->mpc->funcs->read_mpcc_state(pool->mpc, i, &s);
+		if (s.opp_id != 0xf)
+			DTN_INFO("[%2d]:  %4xh  %4xh  %6xh  %4x  %4x  %4x  %4x  %4x %4xh  %4xh  %6xh  %4x  %4x  %4x  %4x\n",
+				i, s.rmcm_regs.rmcm_cntl, s.rmcm_regs.rmcm_shaper_lut_mode, s.rmcm_regs.rmcm_shaper_mode_cur,
+				s.rmcm_regs.rmcm_shaper_lut_write_en_mask, s.rmcm_regs.rmcm_shaper_lut_write_sel, s.rmcm_regs.rmcm_shaper_offset_b,
+				s.rmcm_regs.rmcm_shaper_scale_b, s.rmcm_regs.rmcm_shaper_rama_exp_region_start_b, s.rmcm_regs.rmcm_shaper_rama_exp_region_start_seg_b,
+				s.rmcm_regs.rmcm_shaper_rama_exp_region_end_b, s.rmcm_regs.rmcm_shaper_rama_exp_region_end_base_b, s.rmcm_regs.rmcm_shaper_mem_pwr_state,
+				s.rmcm_regs.rmcm_shaper_mem_pwr_force, s.rmcm_regs.rmcm_shaper_mem_pwr_dis, s.rmcm_regs.rmcm_shaper_mem_pwr_mode);
+	}
 }
 
 void dcn10_log_hw_state(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 6e303b81bfb0..a5510bedca4b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -190,6 +190,42 @@ struct mpc_grph_gamut_adjustment {
 	enum mpcc_gamut_remap_id mpcc_gamut_remap_block_id;
 };
 
+struct mpc_rmcm_regs {
+	uint32_t rmcm_3dlut_mem_pwr_state;
+	uint32_t rmcm_3dlut_mem_pwr_force;
+	uint32_t rmcm_3dlut_mem_pwr_dis;
+	uint32_t rmcm_3dlut_mem_pwr_mode;
+	uint32_t rmcm_3dlut_size;
+	uint32_t rmcm_3dlut_mode;
+	uint32_t rmcm_3dlut_mode_cur;
+	uint32_t rmcm_3dlut_read_sel;
+	uint32_t rmcm_3dlut_30bit_en;
+	uint32_t rmcm_3dlut_wr_en_mask;
+	uint32_t rmcm_3dlut_ram_sel;
+	uint32_t rmcm_3dlut_out_norm_factor;
+	uint32_t rmcm_3dlut_fl_sel;
+	uint32_t rmcm_3dlut_out_offset_r;
+	uint32_t rmcm_3dlut_out_scale_r;
+	uint32_t rmcm_3dlut_fl_done;
+	uint32_t rmcm_3dlut_fl_soft_underflow;
+	uint32_t rmcm_3dlut_fl_hard_underflow;
+	uint32_t rmcm_cntl;
+	uint32_t rmcm_shaper_mem_pwr_state;
+	uint32_t rmcm_shaper_mem_pwr_force;
+	uint32_t rmcm_shaper_mem_pwr_dis;
+	uint32_t rmcm_shaper_mem_pwr_mode;
+	uint32_t rmcm_shaper_lut_mode;
+	uint32_t rmcm_shaper_mode_cur;
+	uint32_t rmcm_shaper_lut_write_en_mask;
+	uint32_t rmcm_shaper_lut_write_sel;
+	uint32_t rmcm_shaper_offset_b;
+	uint32_t rmcm_shaper_scale_b;
+	uint32_t rmcm_shaper_rama_exp_region_start_b;
+	uint32_t rmcm_shaper_rama_exp_region_start_seg_b;
+	uint32_t rmcm_shaper_rama_exp_region_end_b;
+	uint32_t rmcm_shaper_rama_exp_region_end_base_b;
+};
+
 struct mpcc_sm_cfg {
 	bool enable;
 	/* 0-single plane,2-row subsampling,4-column subsampling,6-checkboard subsampling */
@@ -301,6 +337,7 @@ struct mpcc_state {
 	uint32_t rgam_mode;
 	uint32_t rgam_lut;
 	struct mpc_grph_gamut_adjustment gamut_remap;
+	struct mpc_rmcm_regs rmcm_regs;
 };
 
 /**
-- 
2.43.0

