Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717D7C44501
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 032FF10F70E;
	Thu,  9 Jul 2026 21:02:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mRJTr88f";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A0F310F70C
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDNRdcOejT0G+wzZ9478GZFgfNPQqn9N5XV7VnpGRfZDfk7+B9q0AkXh9euxckYBwnjX++jS+t8XJ2IV1dXo5sG7hezoxzsodGYq9K4erywPoZB9FRExx+eoPXvTvn44LyTDLo9DIu2bXflHRfPx6La4i6zniHdLRBDQ+xEoo35QM3YHOgqN6/vatok3G6mLjDIQ45De6lcFXtumiSBUZc5FJ06pPbYb80mNKGy5vylSWpMNxnBhKw+WJkd3Amyb+9R2Wcq7q6hdmH/Dcb+vw3+5eJFu4h+vUUzrp4SKC0qo2uvI5M1b85Yu+/7S/JQGiMbxE5I/21j/h5mRJ8HCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9m8cF/BoIABSBLDVq+ORcsJ2AgWSXxKn+1bHg9mkXk=;
 b=qN83bYmqPEgtFmCdOe4pX2SoywifLFN5ksheNmPE91q9SPDyBJ7IP4NZywqmoNTDHanxlw35HlwCFAdt9AVIKkP0e+EqcmWig5IX3uo4kWI9QFyOg+IJUQhfphbt/XagK/52UUI0PGFZ+IHC6IH/WOJL2ngKDiCMUQdDjO6wxvtxkznr8vM/qWqlb7XhB8Z68S4G+iru/n9GEff13sFhJT+j5/pQjMsFIrwADCSufm701gq8FuJRUekMzNaKxRi56A4+ZDFMBWHvaOJN8Cc+jhel07Pzhio71DVa5AtozApJCE1iP/VC78t/7lLLWevrzwt7ViIj6dMAIuY2Jajb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9m8cF/BoIABSBLDVq+ORcsJ2AgWSXxKn+1bHg9mkXk=;
 b=mRJTr88fr9+7raFVGHv66BpVHcrdTIvgpExbdNlQdm7MNeYAqfDNn16LYSwg+8W8zAnTGipfnYTfuljrM8/ejN9y+ZOqa4UKVFYmrMGIbH77JyKzYUODKv1q7XbaKAmxg4ccg56EG2e/PBJyGNz972A+1MSxZFd5CBE9EGm+RHM=
Received: from MN0PR04CA0004.namprd04.prod.outlook.com (2603:10b6:208:52d::6)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 21:02:42 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::3f) by MN0PR04CA0004.outlook.office365.com
 (2603:10b6:208:52d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:40 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:35 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Aric Cyr
 <aric.cyr@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 78/80] drm/amd/display: add DST_Y_DELTA_DRQ_LIMIT hw
 programming
Date: Thu, 9 Jul 2026 16:48:46 -0400
Message-ID: <20260709205936.5719-79-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b363ba-3383-4b4b-eeba-08deddfd6994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|3023799007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: TTCiMAlXRiBThXXo5VY8OD+Er8To92hAKZFbg3fDrzIqnN89hkJrtKXfs9nbthL7SGQRWNZetU2wA6BqastAK3Wfzt5bPITPBIoL8ShbWylbwomg1EMvhl7zrCnKn0z1Rd5uBkfSKxXZ64xBlbbhsVcnheNyWIJCVe/3NXg4I0LVDXSztAFSgwAPJp2pJgxLSFTxbG+eScD36oPN5Al++zY+BbF6Cyo/5vSPp8wN+vgNswCsVnDu+LX1LxVRCpy6plX+0/RbGMisWlAbCnTmmiI1KqQlMesPcx4cEojKrIN5ToLbNV5JLurWxL3XqqD07sP1uH+zqxlz/9fCyaJ1geXjC0FdEvGpLOt3uxvqMJhbvGpoywlgSyeAPP9VtEVJgPRuz6Av3M2PDfZhnbpV+bhUuos8ys6RbjDsay/A/13Lkrq8S7GmJ6Ys+HDQHPNrbdJ5pR7VTW3xI11Kh97AwW4Us8hXP9KP6ujEPRJUA6ypIYSLsWr6mTkoXBc2676CBb/3lB5zPhg9ffuj86O1zzwWD0SFFIvSVYJEqdTQ57EwTXMr9cqRxlZF2aI8iwYvjslhjh9yaDENkU2iYh2tp+XPs+Z6rKK7FoUAINOOvNqpjrFZJ80AoytXdmnip5PfgnlTHJV1oc3DTCjCFdKKsaYOq3KyStIv/Xw1ptPCBZHp1kZb1+q3UlWUGq4KfBkVZvH+0EQVCKSdt5AjRchggg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F9htOAnBVeol0ntddRiXQEptw/Fkw2eYIPLiooDub/yXt2A1+K+uGu7nrLHnDHqc/JK8zHLLIVc3sD3TxsCOt6nYPzexQ5octGt6Nyb0+tgDWRpF5IhU0WDBB+QG/tUqx7plptM+uHT3RxDiBA1bO4Gy/KWL91Fw+T2o6EOcCLe5XmdvCplHO+bR7RNmTgkPx9jKWqYCOllndgKFpdrj2zHbnznXJjP4Jv1eAFMkDCoxp8EFWKGaTYl4+aLySjjN2KES7dmA7e7cjGiKbSu9ZNligcJOD/yOFXI70KfoBRCoNNNNDuD208EfqKBcC9Ee+6CUmDPspTtkb+Ny7N/qTAFptrYshH+Owc4o5t7UTaQX8BiyU/dB52JxmxlcXeVONBY00/qRMjhwhM7UmdcaZupWCLINJuFS+Ve+kfpJRe8+k3IP1JIoUEvXID8TP81v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:40.0657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b363ba-3383-4b4b-eeba-08deddfd6994
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845
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
dchubp needs to program DST_Y_DELTA_DRQ_LIMIT  based on dml2.x

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    | 51 ++++++++++++++++++-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.h    |  3 ++
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
index 57de98444f6c..94730f3cff42 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
@@ -580,7 +580,56 @@ static bool hubp42_program_surface_flip_and_addr(
 
 	return true;
 }
+void hubp42_setup_interdependent(
+		struct hubp *hubp,
+		struct dml2_dchub_per_pipe_register_set *pipe_regs)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	REG_SET_2(PREFETCH_SETTINGS, 0,
+			DST_Y_PREFETCH, pipe_regs->dlg_regs.dst_y_prefetch,
+			VRATIO_PREFETCH, pipe_regs->dlg_regs.vratio_prefetch);
+
+	REG_SET(PREFETCH_SETTINGS_C, 0,
+			VRATIO_PREFETCH_C, pipe_regs->dlg_regs.vratio_prefetch_c);
+
+	REG_SET_2(VBLANK_PARAMETERS_0, 0,
+		DST_Y_PER_VM_VBLANK, pipe_regs->dlg_regs.dst_y_per_vm_vblank,
+		DST_Y_PER_ROW_VBLANK, pipe_regs->dlg_regs.dst_y_per_row_vblank);
+
+	REG_SET_2(FLIP_PARAMETERS_0, 0,
+		DST_Y_PER_VM_FLIP, pipe_regs->dlg_regs.dst_y_per_vm_flip,
+		DST_Y_PER_ROW_FLIP, pipe_regs->dlg_regs.dst_y_per_row_flip);
 
+	REG_SET(VBLANK_PARAMETERS_3, 0,
+		REFCYC_PER_META_CHUNK_VBLANK_L, pipe_regs->dlg_regs.refcyc_per_meta_chunk_vblank_l);
+
+	REG_SET(VBLANK_PARAMETERS_4, 0,
+		REFCYC_PER_META_CHUNK_VBLANK_C, pipe_regs->dlg_regs.refcyc_per_meta_chunk_vblank_c);
+
+	REG_SET(FLIP_PARAMETERS_2, 0,
+		REFCYC_PER_META_CHUNK_FLIP_L, pipe_regs->dlg_regs.refcyc_per_meta_chunk_flip_l);
+
+	REG_SET_2(PER_LINE_DELIVERY_PRE, 0,
+		REFCYC_PER_LINE_DELIVERY_PRE_L, pipe_regs->dlg_regs.refcyc_per_line_delivery_pre_l,
+		REFCYC_PER_LINE_DELIVERY_PRE_C, pipe_regs->dlg_regs.refcyc_per_line_delivery_pre_c);
+
+	REG_SET(DCN_SURF0_TTU_CNTL1, 0,
+		REFCYC_PER_REQ_DELIVERY_PRE,
+		pipe_regs->ttu_regs.refcyc_per_req_delivery_pre_l);
+	REG_SET(DCN_SURF1_TTU_CNTL1, 0,
+		REFCYC_PER_REQ_DELIVERY_PRE,
+		pipe_regs->ttu_regs.refcyc_per_req_delivery_pre_c);
+	REG_SET(DCN_CUR0_TTU_CNTL1, 0,
+		REFCYC_PER_REQ_DELIVERY_PRE, pipe_regs->ttu_regs.refcyc_per_req_delivery_pre_cur0);
+
+	REG_SET_2(DCN_GLOBAL_TTU_CNTL, 0,
+		MIN_TTU_VBLANK, pipe_regs->ttu_regs.min_ttu_vblank,
+		QoS_LEVEL_FLIP, pipe_regs->ttu_regs.qos_level_flip);
+
+	REG_SET(DST_Y_DELTA_DRQ_LIMIT, 0,
+		DST_Y_DELTA_DRQ_LIMIT, pipe_regs->dlg_regs.dst_y_delta_drq_limit);
+}
 struct hubp_funcs dcn42_hubp_funcs = {
 	.hubp_enable_tripleBuffer = hubp2_enable_triplebuffer,
 	.hubp_is_triplebuffer_enabled = hubp2_is_triplebuffer_enabled,
@@ -588,7 +637,7 @@ struct hubp_funcs dcn42_hubp_funcs = {
 	.hubp_program_surface_config = hubp42_program_surface_config,
 	.hubp_is_flip_pending = hubp2_is_flip_pending,
 	.hubp_setup2 = hubp42_setup,
-	.hubp_setup_interdependent2 = hubp401_setup_interdependent,
+	.hubp_setup_interdependent2 = hubp42_setup_interdependent,
 	.hubp_set_vm_system_aperture_settings = hubp3_set_vm_system_aperture_settings,
 	.set_blank = hubp2_set_blank,
 	.set_blank_regs = hubp2_set_blank_regs,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h
index 27528f82058c..ba4a58c353dd 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h
@@ -97,4 +97,7 @@ void hubp42_setup(
 		union dml2_global_sync_programming *pipe_global_sync,
 		struct dc_crtc_timing *timing);
 
+void hubp42_setup_interdependent(
+		struct hubp *hubp,
+		struct dml2_dchub_per_pipe_register_set *pipe_regs);
 #endif /* __DC_HUBP_DCN42_H__ */
-- 
2.55.0

