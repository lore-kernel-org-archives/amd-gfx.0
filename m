Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41AFC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D5410E177;
	Thu, 20 Oct 2022 15:48:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 991B910E48F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdxE4XuDhDXfQuwegcTxxo7sYH+ktzXyj+aExaq1qdC1Wz3IV0zCZM70RjD9bsj1XEvZXOeTnZ5l+W0RT2EzJt8CdGB5V+g4gHG9OphHU2KN8F3n3H2Y3ricwAupl3z1WlkfJM02NxVnGWorJCWLfTIbl2mmgPNiwZNdixjfbEB3bB72jcPivEPAGCdngC1N1MqNZPxQvOxnf0iKtKqnTcqmuOAffaezAGb245zwkdC8m1xskaSrRaDd4bWxR/XKIBMxJrmuaB5wTRfXiuN50IxYaS9VGlBR44LnaGpxPxGuoIwA8czzCpYND4pfTloYR5U5x2omAHzUAdUdwPvY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=309yOT8IekZsJrr6NWc+C82V/2NHBXMiNuRjEhWFgTU=;
 b=k7/GW8dcrWhRs5cIoOA67/mpI19lS2rLPSWVd4q07e4YXillRYhDHuI9htGZtWaDDCQ1sGPtWCd3f2TvcRFZFnjnVDyOH10QzlIXue0SvVMRq52yAwc5ElFNnOu+tzKFDNmZcKeTNy3AKs9GCGW3/t6Z1W31aUXRpIyTgZOj226yBFO4nQGcUS3Hnp+hzKgjgBP2hos8xtUbSvio5hjXTtCIzo97Jfa6TYLZITNiNkkkPVyKQ7iECe3Bj7/+JR4qshq9gtiCfilH1D51WBljjrhinmDlMzQPshtVeUy+GBNJ5y3lcUGfs/iK9vm+K+aTguheBiki4bC4bJkdt1kasw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=309yOT8IekZsJrr6NWc+C82V/2NHBXMiNuRjEhWFgTU=;
 b=Y/5MykG2GpccIQPxPrIN/FeXyxHYbgzxXuy/IahRzoPSrePMya7h8uJHpUObtTvYonXplsmExpu42s3ij37X1CigcTEsBHQi2u4AeOlkAYPaD39TB8c/JNGIwfUYpr/fqH5zQn/mHFYl8v20iQMzSmwZjy7hr1slRd/qTkpLFUo=
Received: from DS7PR03CA0316.namprd03.prod.outlook.com (2603:10b6:8:2b::17) by
 BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 15:47:45 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::c5) by DS7PR03CA0316.outlook.office365.com
 (2603:10b6:8:2b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Thu, 20 Oct 2022 15:47:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:47:45 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:47:43 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/33] drm/amd/display: Add events log to trace OPTC lock and
 unlock
Date: Thu, 20 Oct 2022 11:46:38 -0400
Message-ID: <20221020154702.503934-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|BN9PR12MB5356:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2cb8d6-9871-4d58-8910-08dab2b26e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WSmEVpXK2ErK9QR6cga4dFfBaPZc37gY0QEFLAib96aFLmQ89ogIokGkePkVjFRmsvgS513i7C8NEl/qzH+3k8lazosZHZpvDl1a+AjvoQuPkFsM04lfNVG8ClWmMCm0nwBI5INVlw+eJRAiqS3qiNO44j5rNwQ3S1bllBbCkEnM42704pn6D+WIS5QIw6P+OxuP25blLZ1az6tbMSnUarZ2GhIHEoVzqWe0japxqJoPYEM0sjeSCQYtRBe/8aq39W5fs6tDQMj3IWT9ZZoJfaHabdRS0cOJ7BwekswTigdDDQvgs1sOvIqVUGiOAzSmlWyKah1iLKm5P1xelhn4xg9948T6YwojZ4MVOY9TFO4aVgCNMqICmpQ7ETfz68u8wyUaCN3u9Y3/R2CNn1wJNE8xFaOQ1CuzWsfstUmozKptnpvgP8Po8ZUeNGb9V8EuFzkiKIL4lQKqrLvHjs8PAJpOfO4WrMRPkW12lcGo6c+0FjU8AEEdS6mcPnEkzGHvDCk7+QaggU6uHLBgvqKQY4Bj6LfDPyHXa+2ln5hts2UEg5Pp9one5JSkF76DJ0ULvmuc1TvAkZPjy56y+EfjZr1tp7DJx8YSjf4KuyqQ3tGdUEdSTprZDO75wCXPP6pUgKKpepGQua2FiiA0cyfVe3cTVNTan5XvFKm4+5la7n4BGiFb0/xvPypVFs46KB/DyOmiPqnQXOr5+3l+qqqnPygQ+kArWYryyVo8aYvl0CRzRH8Pwb4BfNv5NRifWBZobWQSi6ZkvJ9MH4KsrDCNkuVlh3gtNAY+eILs3e0pOUQndsVWsLZM9qKfcnQX7OAm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(2906002)(356005)(186003)(82740400003)(81166007)(66899015)(1076003)(16526019)(40460700003)(478600001)(82310400005)(426003)(8676002)(47076005)(4326008)(2616005)(54906003)(26005)(6916009)(36860700001)(8936002)(336012)(40480700001)(6666004)(86362001)(70206006)(36756003)(41300700001)(83380400001)(7696005)(316002)(70586007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:47:45.2750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2cb8d6-9871-4d58-8910-08dab2b26e76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5356
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As an attempt to offer more DCN debug tools for cases where the OPTC can
hang, this commit introduces a trace event responsible for showing OPTC
status when it requests lock and unlock.

Reviewed-by: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   | 64 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_trace.h     |  2 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  5 ++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  9 +++
 4 files changed, 80 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index fdcaea22b456..a2450c970083 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -36,6 +36,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_atomic.h>
+#include "dcn10/dcn10_optc.h"
 
 #include "dc/inc/core_types.h"
 
@@ -661,6 +662,69 @@ TRACE_EVENT(dcn_fpu,
 	    )
 );
 
+TRACE_EVENT(dcn_optc_lock_unlock_state,
+	    TP_PROTO(const struct optc *optc_state, int instance, bool lock, const char *function, const int line),
+	    TP_ARGS(optc_state, instance, lock, function, line),
+
+	    TP_STRUCT__entry(
+			     __field(const char *, function)
+			     __field(int, instance)
+			     __field(bool, lock)
+			     __field(int, line)
+			     __field(int, opp_count)
+			     __field(int, max_h_total)
+			     __field(int, max_v_total)
+			     __field(int, min_h_blank)
+			     __field(int, min_h_sync_width)
+			     __field(int, min_v_sync_width)
+			     __field(int, min_v_blank)
+			     __field(int, min_v_blank_interlace)
+			     __field(int, vstartup_start)
+			     __field(int, vupdate_offset)
+			     __field(int, vupdate_width)
+			     __field(int, vready_offset)
+	    ),
+	    TP_fast_assign(
+			   __entry->function = function;
+			   __entry->instance = instance;
+			   __entry->lock = lock;
+			   __entry->line = line;
+			   __entry->opp_count = optc_state->opp_count;
+			   __entry->max_h_total = optc_state->max_h_total;
+			   __entry->max_v_total = optc_state->max_v_total;
+			   __entry->min_h_blank = optc_state->min_h_blank;
+			   __entry->min_h_sync_width = optc_state->min_h_sync_width;
+			   __entry->min_v_sync_width = optc_state->min_v_sync_width;
+			   __entry->min_v_blank = optc_state->min_v_blank;
+			   __entry->min_v_blank_interlace = optc_state->min_v_blank_interlace;
+			   __entry->vstartup_start = optc_state->vstartup_start;
+			   __entry->vupdate_offset = optc_state->vupdate_offset;
+			   __entry->vupdate_width = optc_state->vupdate_width;
+			   __entry->vready_offset = optc_state->vupdate_offset;
+	    ),
+	    TP_printk("%s: %s()+%d: optc_instance=%d opp_count=%d max_h_total=%d max_v_total=%d "
+		      "min_h_blank=%d min_h_sync_width=%d min_v_sync_width=%d min_v_blank=%d "
+		      "min_v_blank_interlace=%d vstartup_start=%d vupdate_offset=%d vupdate_width=%d "
+		      "vready_offset=%d",
+		      __entry->lock ? "Lock" : "Unlock",
+		      __entry->function,
+		      __entry->line,
+		      __entry->instance,
+		      __entry->opp_count,
+		      __entry->max_h_total,
+		      __entry->max_v_total,
+		      __entry->min_h_blank,
+		      __entry->min_h_sync_width,
+		      __entry->min_v_sync_width,
+		      __entry->min_v_blank,
+		      __entry->min_v_blank_interlace,
+		      __entry->vstartup_start,
+		      __entry->vupdate_offset,
+		      __entry->vupdate_width,
+		      __entry->vready_offset
+	    )
+);
+
 #endif /* _AMDGPU_DM_TRACE_H_ */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/drivers/gpu/drm/amd/display/dc/dc_trace.h b/drivers/gpu/drm/amd/display/dc/dc_trace.h
index c711797e5c9e..bbec308a3a5e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_trace.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_trace.h
@@ -40,3 +40,5 @@
 
 #define TRACE_DCN_FPU(begin, function, line, ref_count) \
 	trace_dcn_fpu(begin, function, line, ref_count)
+#define TRACE_OPTC_LOCK_UNLOCK_STATE(optc, inst, lock) \
+	trace_dcn_optc_lock_unlock_state(optc, inst, lock, __func__, __LINE__)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 33d780218790..c9e53dc49c92 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -27,6 +27,7 @@
 #include "reg_helper.h"
 #include "dcn10_optc.h"
 #include "dc.h"
+#include "dc_trace.h"
 
 #define REG(reg)\
 	optc1->tg_regs->reg
@@ -657,6 +658,8 @@ void optc1_lock(struct timing_generator *optc)
 		REG_WAIT(OTG_MASTER_UPDATE_LOCK,
 				UPDATE_LOCK_STATUS, 1,
 				1, 10);
+
+	TRACE_OPTC_LOCK_UNLOCK_STATE(optc1, optc->inst, true);
 }
 
 void optc1_unlock(struct timing_generator *optc)
@@ -665,6 +668,8 @@ void optc1_unlock(struct timing_generator *optc)
 
 	REG_SET(OTG_MASTER_UPDATE_LOCK, 0,
 			OTG_MASTER_UPDATE_LOCK, 0);
+
+	TRACE_OPTC_LOCK_UNLOCK_STATE(optc1, optc->inst, false);
 }
 
 void optc1_get_position(struct timing_generator *optc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index 892d3c4d01a1..867d60151aeb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -30,6 +30,7 @@
 #include "dc_dmub_srv.h"
 
 #include "dml/dcn30/dcn30_fpu.h"
+#include "dc_trace.h"
 
 #define REG(reg)\
 	optc1->tg_regs->reg
@@ -58,6 +59,8 @@ void optc3_triplebuffer_lock(struct timing_generator *optc)
 		REG_WAIT(OTG_MASTER_UPDATE_LOCK,
 				UPDATE_LOCK_STATUS, 1,
 				1, 10);
+
+	TRACE_OPTC_LOCK_UNLOCK_STATE(optc1, optc->inst, true);
 }
 
 void optc3_lock_doublebuffer_enable(struct timing_generator *optc)
@@ -93,6 +96,8 @@ void optc3_lock_doublebuffer_enable(struct timing_generator *optc)
 		MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET, 0,
 		MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, 100,
 		OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, 1);
+
+	TRACE_OPTC_LOCK_UNLOCK_STATE(optc1, optc->inst, true);
 }
 
 void optc3_lock_doublebuffer_disable(struct timing_generator *optc)
@@ -108,6 +113,8 @@ void optc3_lock_doublebuffer_disable(struct timing_generator *optc)
 
 	REG_UPDATE(OTG_GLOBAL_CONTROL2, GLOBAL_UPDATE_LOCK_EN, 0);
 	REG_UPDATE(OTG_GLOBAL_CONTROL0, MASTER_UPDATE_LOCK_DB_EN, 0);
+
+	TRACE_OPTC_LOCK_UNLOCK_STATE(optc1, optc->inst, true);
 }
 
 void optc3_lock(struct timing_generator *optc)
@@ -122,6 +129,8 @@ void optc3_lock(struct timing_generator *optc)
 	REG_WAIT(OTG_MASTER_UPDATE_LOCK,
 			UPDATE_LOCK_STATUS, 1,
 			1, 10);
+
+	TRACE_OPTC_LOCK_UNLOCK_STATE(optc1, optc->inst, true);
 }
 
 void optc3_set_out_mux(struct timing_generator *optc, enum otg_out_mux_dest dest)
-- 
2.35.1

