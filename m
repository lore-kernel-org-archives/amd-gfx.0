Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EEEC02182
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 19:40:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67ADA10E629;
	Tue, 21 Jan 2025 19:40:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LSBjaEJY";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0883010E629
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 19:40:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODr7uedePbLlHohBEH04ePrUmcj5zMZjGmifBHxOuJ5PU1xfVeZQIC8gonu7CGztK3gDTTh+8agBr0lr6pinZCLN2WgaNXz3bCwGBEjAebaKTvVnjGvNNKhThdSyj78bdlTwDHDT6Vf1pFJJ44E7p/BGdOtm4bMSiJgLebqzjttU3pGfXEEocdvjpRCWVtDSAvHnCm62pAcVFppN+u4xHq9POGqn8eqOzHgBROfToLEFgZhBEK0+kYNxH6Dp4UaI9u6PiFEtNGMmPF9u4r4fAngF2Gn0NGz49TGhoC6C587SGLwthBTBbby1SHjdwY6M73xRA6TvOCkbeM14FKUevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3c8vH3r62wETJX7Xad/8uG6EDxH0IpN8VM7vNn+qId4=;
 b=VHsNnP4tHvKmM9nsL95kzEkPXZ1oNEmkifcfNM/7n1dgeEFGGNehY+HRwqJGT0U7gA2ffqYZzG3gC5FX2HuMc0dd3XGknGatTImMmKSOMsdxHAlkTzgd715b1dkl9GrJLGF2Yb9x7dBs5A76GX/V9IhmdPZq7m46hmncVWcaUmtLUvFlJWwtNkv3LNMx06dE+yjSNxHPn6FI1xZp9UH2TQ9MIKGHb+u823vNVKt7eU689MHJ83Cev9Uh2jimCLHVj7t9M6zm3KYfVb72lN0KjFg+QXk86l5GM10jzTEFTGOG/yHI9nzapz5UwmMOLzdhvT6FyV4cG2/gK2fK6qDsaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3c8vH3r62wETJX7Xad/8uG6EDxH0IpN8VM7vNn+qId4=;
 b=LSBjaEJYWPKy9dXhfP6/sTtW6reiC4l3KFnxXgZ5OZG4UcFwip1uBvhhQNgAVxXnsHbsJ0OR/5cX893wzGpE9e7ijN6je0G/khbzjn2dEmdFjU3Kt1Z+T5BKK4hZnkkgtdJ47QD/cIWXvEzNmm5qiw+LRA2K0yh3MfdR/y6iuW4=
Received: from MN2PR22CA0027.namprd22.prod.outlook.com (2603:10b6:208:238::32)
 by SN7PR12MB7107.namprd12.prod.outlook.com (2603:10b6:806:2a2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Tue, 21 Jan
 2025 19:40:03 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::ee) by MN2PR22CA0027.outlook.office365.com
 (2603:10b6:208:238::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Tue,
 21 Jan 2025 19:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 19:40:03 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 13:40:00 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Austin Zheng
 <Austin.Zheng@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 05/14] drm/amd/display: Account For OTO Prefetch Bandwidth
 When Calculating Urgent Bandwidth
Date: Tue, 21 Jan 2025 14:39:10 -0500
Message-ID: <20250121193919.3342348-6-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
References: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SN7PR12MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe73b3c-2cc0-4290-4337-08dd3a53668d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FlrvleLkNjuUiJudxQzj0Lyqdzk0UXlgHcp36BBroc2Jby4UBfyJK+jMDxUb?=
 =?us-ascii?Q?I856OOZSwChBnQ/uISYxVXKxcKbsjpCH515qPKmBxa+eXTdQH9d2r1FYWEU8?=
 =?us-ascii?Q?+6cCbOJaGOu4Ql0Ae9kLJfuAM6eFS7YqQ/A55Ic8388q4l0GVwh1GtcWTKJI?=
 =?us-ascii?Q?xdXmZm8JwfhuCekD4F7vfeAk20qwVBzqOUb7xoCO1z1VODXadU+h3ag8pDzF?=
 =?us-ascii?Q?pUx25nkzO89kt3W5erC6iiQS9WHArTRYkEMSDasM/t1AqNnhQoTZUsaQwrJ9?=
 =?us-ascii?Q?mIPUQJTkp0w/HAt8qnypTFyg6NrGI2xk30OmnM/VFFoSVFRM5eDShiPcU42B?=
 =?us-ascii?Q?0vxz1Xpx4gceo+2GPZH/e/p6HoYCy9Kd9Zg5U4d6ZmKvymes4b02iI1DchFu?=
 =?us-ascii?Q?iWSzaMpxXvx3//kYcbzbxMG193wGHvGR56JcYyybpUPKRaHmyNpfWm22qh9h?=
 =?us-ascii?Q?1dWOHLeGatdqdFhG/UEG++rZ7kPZuag+0oGr6/Na2qi8JhoIyKXONkXO+YFn?=
 =?us-ascii?Q?Yl+TfCyDmB+YugVc9DKRAyKkb49s/lwtCZQhspQO/DBOuIkZtPzHrZC/Sk2q?=
 =?us-ascii?Q?L3PGQ6blGUMM8svg+4lp4kyxu7hSyWQ/z1v1rLaG1cx+wzaFwgvQtuPvIvde?=
 =?us-ascii?Q?elxG6xpwZEuLJZlN+6Sxv99DyaXTBUzrdqZRnhUi1Dv0AtJnf+9ukhMDRucQ?=
 =?us-ascii?Q?TmTof6pPu441XVkV+QkRFIxb+rDTEC1r/Btl8sb7wfXkg/gvHleovM4mK8T7?=
 =?us-ascii?Q?Hrz4QavqHlq+t9w1lv+FBB26KtqX3Cl/MRlM26YZsyZ05lQNIVL8fM3hZ8Vq?=
 =?us-ascii?Q?vYzhdCTu+Tsf8lQd9UpQKz2jyiKD5fawZTaWvl1aTVvphFWyUDhNta1puOb/?=
 =?us-ascii?Q?yeYcU7ZTv+npks3F5qCOk0XJSTPfLck/7p/YwjuCbD4mtUeLHEaUv0LmN7kR?=
 =?us-ascii?Q?wwdyDA9AhsVCaPwuKtaYxamugVvpk5/9mRXkMrpJBC0wjRvNwgJPSyLF7zl5?=
 =?us-ascii?Q?o5d3hd4kXExRtZT8IL795yTlvK+H+HndEKuWLV5vNhweCxwsOn/v6Bq5/kqa?=
 =?us-ascii?Q?DTJFICTupc50KzL9Bkk2GXt4VwGcUmDPQW3BVHoeeXUc4wmBCo8fh82A46rf?=
 =?us-ascii?Q?LzO2rAu4k5AvYfzeOkn3UTKRiscYrbco4OqjemxBMutu0F30EckL9mBCbHYW?=
 =?us-ascii?Q?MMSy/i2iawHDZg3tw4puHHnExJOFw+dul2L94XOVOt+p4G26llZ4D0/W7k4i?=
 =?us-ascii?Q?kjWXs7lTo6qNfu/MycK5fmrPpzinn1xsCzeGNg3W0Stjz5xPkEHIKrZjWCKl?=
 =?us-ascii?Q?H2p/EtE28bdeB4k4ukDcoRv7ga9jta41GdiFJhcDHlMQG8QeVw9hjonSmDur?=
 =?us-ascii?Q?HoG48hPCYWUzFfNnrbDjzEmW6tWkC45xrIzqD2x8pLViE8pZFFt1Tb1ALIGo?=
 =?us-ascii?Q?Mp4u66LrHWPvCxuBaHiqNzbqrXNDC0QNNlNaAh0rYL+1PYXbK9WWjnScc1+Y?=
 =?us-ascii?Q?sGZNmsiwkjgKV40=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:40:03.2927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe73b3c-2cc0-4290-4337-08dd3a53668d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7107
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why]
1) The current calculations for OTO prefetch bandwidth do not consider the number of DPP pipes in use.
As a result, OTO prefetch bandwidth may be larger than the vactive bandwidth if multiple DPP pipes are used.
OTO prefetch bandwidth should never exceed the vactive bandwidth.

2) Mode programming may be mismatched with mode support
In cases where mode support has chosen to use the equalized (equ) prefetch schedule,
mode programming may end up using oto prefetch schedule instead.
The bandwidth required to do the oto schedule may end up being higher than the equ schedule.
This can cause the required urgent bandwidth to exceed the available urgent bandwidth.

[How]
Output the oto prefetch bandwidth and incorperate it into the urgent bandwidth calculations
even if the prefetch schedule being used is not the oto schedule.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 25 ++++++++++++++++++-
 .../src/dml2_core/dml2_core_shared_types.h    |  5 ++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 51b457b6d66f..e96a13dc43d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -4909,6 +4909,7 @@ static double get_urgent_bandwidth_required(
 	double ReadBandwidthChroma[],
 	double PrefetchBandwidthLuma[],
 	double PrefetchBandwidthChroma[],
+	double PrefetchBandwidthOto[],
 	double excess_vactive_fill_bw_l[],
 	double excess_vactive_fill_bw_c[],
 	double cursor_bw[],
@@ -4972,8 +4973,9 @@ static double get_urgent_bandwidth_required(
 			l->vm_row_bw = NumberOfDPP[k] * prefetch_vmrow_bw[k];
 			l->flip_and_active_bw = l->per_plane_flip_bw[k] + ReadBandwidthLuma[k] * l->adj_factor_p0 + ReadBandwidthChroma[k] * l->adj_factor_p1 + cursor_bw[k] * l->adj_factor_cur;
 			l->flip_and_prefetch_bw = l->per_plane_flip_bw[k] + NumberOfDPP[k] * (PrefetchBandwidthLuma[k] * l->adj_factor_p0_pre + PrefetchBandwidthChroma[k] * l->adj_factor_p1_pre) + prefetch_cursor_bw[k] * l->adj_factor_cur_pre;
+			l->flip_and_prefetch_bw_oto = l->per_plane_flip_bw[k] + NumberOfDPP[k] * (PrefetchBandwidthOto[k] * l->adj_factor_p0_pre + PrefetchBandwidthChroma[k] * l->adj_factor_p1_pre) + prefetch_cursor_bw[k] * l->adj_factor_cur_pre;
 			l->active_and_excess_bw = (ReadBandwidthLuma[k] + excess_vactive_fill_bw_l[k]) * l->tmp_nom_adj_factor_p0 + (ReadBandwidthChroma[k] + excess_vactive_fill_bw_c[k]) * l->tmp_nom_adj_factor_p1 + dpte_row_bw[k] + meta_row_bw[k];
-			surface_required_bw[k] = math_max4(l->vm_row_bw, l->flip_and_active_bw, l->flip_and_prefetch_bw, l->active_and_excess_bw);
+			surface_required_bw[k] = math_max5(l->vm_row_bw, l->flip_and_active_bw, l->flip_and_prefetch_bw, l->active_and_excess_bw, l->flip_and_prefetch_bw_oto);
 
 			/* export peak required bandwidth for the surface */
 			surface_peak_required_bw[k] = math_max2(surface_required_bw[k], surface_peak_required_bw[k]);
@@ -5171,6 +5173,7 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 	s->Tsw_est3 = 0.0;
 	s->cursor_prefetch_bytes = 0;
 	*p->prefetch_cursor_bw = 0;
+	*p->RequiredPrefetchBWOTO = 0.0;
 
 	dcc_mrq_enable = (p->dcc_enable && p->mrq_present);
 
@@ -5384,6 +5387,9 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 		s->prefetch_bw_oto += (p->swath_width_chroma_ub * p->myPipe->BytePerPixelC) / s->LineTime;
 	}
 
+	/* oto prefetch bw should be always be less than total vactive bw */
+	DML2_ASSERT(s->prefetch_bw_oto < s->per_pipe_vactive_sw_bw * p->myPipe->DPPPerSurface);
+
 	s->prefetch_bw_oto = math_max2(s->per_pipe_vactive_sw_bw, s->prefetch_bw_oto) * p->mall_prefetch_sdp_overhead_factor;
 
 	s->prefetch_bw_oto = math_min2(s->prefetch_bw_oto, *p->prefetch_sw_bytes/(s->min_Lsw_oto*s->LineTime));
@@ -5394,6 +5400,12 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 					p->vm_bytes * p->HostVMInefficiencyFactor / (31 * s->LineTime) - *p->Tno_bw,
 					(p->PixelPTEBytesPerRow * p->HostVMInefficiencyFactor + p->meta_row_bytes + tdlut_row_bytes) / (15 * s->LineTime));
 
+	/* oto bw needs to be outputted even if the oto schedule isn't being used to avoid ms/mp mismatch.
+	 * mp will fail if ms decides to use equ schedule and mp decides to use oto schedule
+	 * and the required bandwidth increases when going from ms to mp
+	 */
+	*p->RequiredPrefetchBWOTO = s->prefetch_bw_oto;
+
 #ifdef __DML_VBA_DEBUG__
 	dml2_printf("DML::%s: vactive_sw_bw_l = %f\n", __func__, p->vactive_sw_bw_l);
 	dml2_printf("DML::%s: vactive_sw_bw_c = %f\n", __func__, p->vactive_sw_bw_c);
@@ -6154,6 +6166,7 @@ static void calculate_peak_bandwidth_required(
 				p->surface_read_bandwidth_c,
 				l->zero_array, //PrefetchBandwidthLuma,
 				l->zero_array, //PrefetchBandwidthChroma,
+				l->zero_array, //PrefetchBWOTO
 				l->zero_array,
 				l->zero_array,
 				l->zero_array,
@@ -6190,6 +6203,7 @@ static void calculate_peak_bandwidth_required(
 				p->surface_read_bandwidth_c,
 				l->zero_array, //PrefetchBandwidthLuma,
 				l->zero_array, //PrefetchBandwidthChroma,
+				l->zero_array, //PrefetchBWOTO
 				p->excess_vactive_fill_bw_l,
 				p->excess_vactive_fill_bw_c,
 				p->cursor_bw,
@@ -6226,6 +6240,7 @@ static void calculate_peak_bandwidth_required(
 				p->surface_read_bandwidth_c,
 				p->prefetch_bandwidth_l,
 				p->prefetch_bandwidth_c,
+				p->prefetch_bandwidth_oto, // to prevent ms/mp mismatch when oto bw > total vactive bw
 				p->excess_vactive_fill_bw_l,
 				p->excess_vactive_fill_bw_c,
 				p->cursor_bw,
@@ -6262,6 +6277,7 @@ static void calculate_peak_bandwidth_required(
 				p->surface_read_bandwidth_c,
 				p->prefetch_bandwidth_l,
 				p->prefetch_bandwidth_c,
+				p->prefetch_bandwidth_oto, // to prevent ms/mp mismatch when oto bw > total vactive bw
 				p->excess_vactive_fill_bw_l,
 				p->excess_vactive_fill_bw_c,
 				p->cursor_bw,
@@ -6298,6 +6314,7 @@ static void calculate_peak_bandwidth_required(
 				p->surface_read_bandwidth_c,
 				p->prefetch_bandwidth_l,
 				p->prefetch_bandwidth_c,
+				p->prefetch_bandwidth_oto, // to prevent ms/mp mismatch when oto bw > total vactive bw
 				p->excess_vactive_fill_bw_l,
 				p->excess_vactive_fill_bw_c,
 				p->cursor_bw,
@@ -9060,6 +9077,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 				CalculatePrefetchSchedule_params->VRatioPrefetchC = &mode_lib->ms.VRatioPreC[k];
 				CalculatePrefetchSchedule_params->RequiredPrefetchPixelDataBWLuma = &mode_lib->ms.RequiredPrefetchPixelDataBWLuma[k]; // prefetch_sw_bw_l
 				CalculatePrefetchSchedule_params->RequiredPrefetchPixelDataBWChroma = &mode_lib->ms.RequiredPrefetchPixelDataBWChroma[k]; // prefetch_sw_bw_c
+				CalculatePrefetchSchedule_params->RequiredPrefetchBWOTO = &mode_lib->ms.RequiredPrefetchBWOTO[k];
 				CalculatePrefetchSchedule_params->NotEnoughTimeForDynamicMetadata = &mode_lib->ms.NoTimeForDynamicMetadata[k];
 				CalculatePrefetchSchedule_params->Tno_bw = &mode_lib->ms.Tno_bw[k];
 				CalculatePrefetchSchedule_params->Tno_bw_flip = &mode_lib->ms.Tno_bw_flip[k];
@@ -9204,6 +9222,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 				calculate_peak_bandwidth_params->surface_read_bandwidth_c = mode_lib->ms.vactive_sw_bw_c;
 				calculate_peak_bandwidth_params->prefetch_bandwidth_l = mode_lib->ms.RequiredPrefetchPixelDataBWLuma;
 				calculate_peak_bandwidth_params->prefetch_bandwidth_c = mode_lib->ms.RequiredPrefetchPixelDataBWChroma;
+				calculate_peak_bandwidth_params->prefetch_bandwidth_oto = mode_lib->ms.RequiredPrefetchBWOTO;
 				calculate_peak_bandwidth_params->excess_vactive_fill_bw_l = mode_lib->ms.excess_vactive_fill_bw_l;
 				calculate_peak_bandwidth_params->excess_vactive_fill_bw_c = mode_lib->ms.excess_vactive_fill_bw_c;
 				calculate_peak_bandwidth_params->cursor_bw = mode_lib->ms.cursor_bw;
@@ -9370,6 +9389,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 			calculate_peak_bandwidth_params->surface_read_bandwidth_c = mode_lib->ms.vactive_sw_bw_c;
 			calculate_peak_bandwidth_params->prefetch_bandwidth_l = mode_lib->ms.RequiredPrefetchPixelDataBWLuma;
 			calculate_peak_bandwidth_params->prefetch_bandwidth_c = mode_lib->ms.RequiredPrefetchPixelDataBWChroma;
+			calculate_peak_bandwidth_params->prefetch_bandwidth_oto = mode_lib->ms.RequiredPrefetchBWOTO;
 			calculate_peak_bandwidth_params->excess_vactive_fill_bw_l = mode_lib->ms.excess_vactive_fill_bw_l;
 			calculate_peak_bandwidth_params->excess_vactive_fill_bw_c = mode_lib->ms.excess_vactive_fill_bw_c;
 			calculate_peak_bandwidth_params->cursor_bw = mode_lib->ms.cursor_bw;
@@ -11286,6 +11306,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 			CalculatePrefetchSchedule_params->VRatioPrefetchC = &mode_lib->mp.VRatioPrefetchC[k];
 			CalculatePrefetchSchedule_params->RequiredPrefetchPixelDataBWLuma = &mode_lib->mp.RequiredPrefetchPixelDataBWLuma[k];
 			CalculatePrefetchSchedule_params->RequiredPrefetchPixelDataBWChroma = &mode_lib->mp.RequiredPrefetchPixelDataBWChroma[k];
+			CalculatePrefetchSchedule_params->RequiredPrefetchBWOTO = &s->dummy_single_array[0][k];
 			CalculatePrefetchSchedule_params->NotEnoughTimeForDynamicMetadata = &mode_lib->mp.NotEnoughTimeForDynamicMetadata[k];
 			CalculatePrefetchSchedule_params->Tno_bw = &mode_lib->mp.Tno_bw[k];
 			CalculatePrefetchSchedule_params->Tno_bw_flip = &mode_lib->mp.Tno_bw_flip[k];
@@ -11428,6 +11449,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 			calculate_peak_bandwidth_params->surface_read_bandwidth_c = mode_lib->mp.vactive_sw_bw_c;
 			calculate_peak_bandwidth_params->prefetch_bandwidth_l = mode_lib->mp.RequiredPrefetchPixelDataBWLuma;
 			calculate_peak_bandwidth_params->prefetch_bandwidth_c = mode_lib->mp.RequiredPrefetchPixelDataBWChroma;
+			calculate_peak_bandwidth_params->prefetch_bandwidth_oto = s->dummy_single_array[0];
 			calculate_peak_bandwidth_params->excess_vactive_fill_bw_l = mode_lib->mp.excess_vactive_fill_bw_l;
 			calculate_peak_bandwidth_params->excess_vactive_fill_bw_c = mode_lib->mp.excess_vactive_fill_bw_c;
 			calculate_peak_bandwidth_params->cursor_bw = mode_lib->mp.cursor_bw;
@@ -11560,6 +11582,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 			calculate_peak_bandwidth_params->surface_read_bandwidth_c = mode_lib->mp.vactive_sw_bw_c;
 			calculate_peak_bandwidth_params->prefetch_bandwidth_l = mode_lib->mp.RequiredPrefetchPixelDataBWLuma;
 			calculate_peak_bandwidth_params->prefetch_bandwidth_c = mode_lib->mp.RequiredPrefetchPixelDataBWChroma;
+			calculate_peak_bandwidth_params->prefetch_bandwidth_oto = s->dummy_single_array[k];
 			calculate_peak_bandwidth_params->excess_vactive_fill_bw_l = mode_lib->mp.excess_vactive_fill_bw_l;
 			calculate_peak_bandwidth_params->excess_vactive_fill_bw_c = mode_lib->mp.excess_vactive_fill_bw_c;
 			calculate_peak_bandwidth_params->cursor_bw = mode_lib->mp.cursor_bw;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
index 23c0fca5515f..b7cb017b59ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -484,6 +484,8 @@ struct dml2_core_internal_mode_support {
 	double WriteBandwidth[DML2_MAX_PLANES][DML2_MAX_WRITEBACK];
 	double RequiredPrefetchPixelDataBWLuma[DML2_MAX_PLANES];
 	double RequiredPrefetchPixelDataBWChroma[DML2_MAX_PLANES];
+	/* oto bw should also be considered when calculating urgent bw to avoid situations oto/equ mismatches between ms and mp */
+	double RequiredPrefetchBWOTO[DML2_MAX_PLANES];
 	double cursor_bw[DML2_MAX_PLANES];
 	double prefetch_cursor_bw[DML2_MAX_PLANES];
 	double prefetch_vmrow_bw[DML2_MAX_PLANES];
@@ -1381,6 +1383,7 @@ struct dml2_core_shared_get_urgent_bandwidth_required_locals {
 	double vm_row_bw;
 	double flip_and_active_bw;
 	double flip_and_prefetch_bw;
+	double flip_and_prefetch_bw_oto;
 	double active_and_excess_bw;
 };
 
@@ -1792,6 +1795,7 @@ struct dml2_core_calcs_CalculatePrefetchSchedule_params {
 	double *VRatioPrefetchC;
 	double *RequiredPrefetchPixelDataBWLuma;
 	double *RequiredPrefetchPixelDataBWChroma;
+	double *RequiredPrefetchBWOTO;
 	bool *NotEnoughTimeForDynamicMetadata;
 	double *Tno_bw;
 	double *Tno_bw_flip;
@@ -2025,6 +2029,7 @@ struct dml2_core_calcs_calculate_peak_bandwidth_required_params {
 	double *surface_read_bandwidth_c;
 	double *prefetch_bandwidth_l;
 	double *prefetch_bandwidth_c;
+	double *prefetch_bandwidth_oto;
 	double *excess_vactive_fill_bw_l;
 	double *excess_vactive_fill_bw_c;
 	double *cursor_bw;
-- 
2.34.1

