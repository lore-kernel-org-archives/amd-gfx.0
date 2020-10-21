Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE734C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 735C822283
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SUX9DtNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735C822283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C67466EDD6;
	Wed, 21 Oct 2020 14:23:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C94A56EDD3
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4ONxLB335CjAh17csinwtla9iiv6HWlyZ7M9QKLwRSxeyBCokH2n3xMdl/zqdOfHsM3u1wlAnZV+pSwrzcNlVuPGbEEfxlVWaKthVp88wXhg8wFAGdr7FBj2yu4/C4ZyTGN8FM5wdYMY/ZgeSSr7XYI8q7deKl+mtgeCPz+oPq72bxJxThjW2fWxrEATjQY4Tsvh5LBbnhT5omUUTqNbzV89HTnm2dxiUoZz4M7sE7dSi/C3cHmcZXeFVQumq2Llc0XM7tnJLWHKCq7x6mvJqCrtDJpwC4+eznhyfjK663Pm9mg9+Il9VQLbHHkKMx6dU+H1PGUzUUzZwEx5pLFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQ7HKuCAl+lScQAK4A1nUyJ37DCgQ4bpF8EV/Vq1dNI=;
 b=Td4NHSiNwvYu+6mwv8yLmfDjfdDSPv5BQhPE4x9hqBGxPH05mFFxhLhmrwrZsSBViBFxvOZqVVTFakN+mRBCI0cxBd3K2/LynauHSxnRCH9z8dc/2F0KWJ1zUBiXvUNBPCrTrLlBEikmRtRBMEpXRbeFp/Y+3LVT5k+WSmWW7BuvhTiV6Oxi161e0uNhbVnOW/hQBwHFCT3YRXMWfPmm4frcelm05zugF4cxeIl0seBUVwhEBFDiu4nhrrD6YpkcZIcv9iBF00YASn5P3YUIFeshZrIFiNnbQbhKRrbj+3mx9RtaTuelBmvAxzX2kNYongZoT1r2UzfmgajQisJkKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQ7HKuCAl+lScQAK4A1nUyJ37DCgQ4bpF8EV/Vq1dNI=;
 b=SUX9DtNiILPTkF+SLWH4q0gIPvgKmU+PyDGwm/Bqz/Ln77PiXAreSX+MCRUN/r+tAh74rKE0IDTpddW8P9BcUGN/M9K+N3r/H2PXOBufs7CAzqSQomJAK9TBP+7xox5D1YcX0P3zP7pBJDRyk7XHLNdjaXUekGEs+7Eb7YPWIM0=
Received: from DM5PR16CA0042.namprd16.prod.outlook.com (2603:10b6:4:15::28) by
 SN1PR12MB2496.namprd12.prod.outlook.com (2603:10b6:802:2f::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.22; Wed, 21 Oct 2020 14:23:26 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::eb) by DM5PR16CA0042.outlook.office365.com
 (2603:10b6:4:15::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:24 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:24 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:24 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/33] drm/amd/display: Decouple amdgpu_dm_trace from service
Date: Wed, 21 Oct 2020 10:22:49 -0400
Message-ID: <20201021142257.190969-26-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c78fac38-3bcc-452e-dfd2-08d875ccdfc4
X-MS-TrafficTypeDiagnostic: SN1PR12MB2496:
X-Microsoft-Antispam-PRVS: <SN1PR12MB24961E92568CB7D523376E628B1C0@SN1PR12MB2496.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ikyZuNZQpiDyqx1upD/yb7noVQIDDjgxmLwmMdakMMSJxTFndKygKCdJs6PDA+TUb97QSjXq9xL4S11tWx6+Fb9JAEi7Iaf1QuMuPkm87gw8XxKMLaTzRxAjW94+WEC+MCfv84eugcTmCV/sdYHpBThCDztbEmSGLbqH/Tbf/m26sEzOrJn9qSshH7IgRDsJ9zJy9tXYT5mz4Xn1ugJju5YwDnbSvT/m/8QsxspTZHGc/0+2RLWe3baxWfV5T9Gqps3lQ3CHVvV1e/qnxccfFBX+vAI1LjocVs/6ZDCp0PM9CWfm/cA//VHXSNVJO3EtAu6yNyr9uyOpUcpDq0i38Ri1WiU6JLyVOPo4ekK0+qZE9WF7nzRknL1I4WtiOrrMIJ9RH7KCdJO4Dcv/+Ld7hA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966005)(81166007)(6916009)(36756003)(26005)(7696005)(478600001)(47076004)(2616005)(82740400003)(44832011)(1076003)(426003)(4326008)(70206006)(8936002)(54906003)(70586007)(5660300002)(186003)(336012)(2906002)(82310400003)(83380400001)(8676002)(6666004)(356005)(86362001)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:25.9445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c78fac38-3bcc-452e-dfd2-08d875ccdfc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2496
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Our DC currently uses some of the tracepoint function inside a DC
header, which means that many other files implicitly include part of the
trace function. This situation limits how we can expand this feature for
other parts of the driver by generating multiple compilation errors when
we try to reuse some of the existing structures. This commit decouples
part of the amdgpu_dm_trace from DC core to simplify the trace
enlargement in future changes.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 39 +++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_services.c    | 17 +++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    | 26 ------------
 drivers/gpu/drm/amd/display/dc/dm_services.h  | 42 +++++--------------
 5 files changed, 61 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a7f4874f698f..1a9aa4d3d7ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -34,6 +34,7 @@
 #include "dc/inc/hw/dmcu.h"
 #include "dc/inc/hw/abm.h"
 #include "dc/dc_dmub_srv.h"
+#include "amdgpu_dm_trace.h"
 
 #include "vid.h"
 #include "amdgpu.h"
@@ -9290,3 +9291,41 @@ void amdgpu_dm_trigger_timing_sync(struct drm_device *dev)
 	}
 	mutex_unlock(&adev->dm.dc_lock);
 }
+
+void dm_write_reg_func(const struct dc_context *ctx, uint32_t address,
+		       uint32_t value, const char *func_name)
+{
+#ifdef DM_CHECK_ADDR_0
+	if (address == 0) {
+		DC_ERR("invalid register write. address = 0");
+		return;
+	}
+#endif
+	cgs_write_register(ctx->cgs_device, address, value);
+	trace_amdgpu_dc_wreg(&ctx->perf_trace->write_count, address, value);
+}
+
+uint32_t dm_read_reg_func(const struct dc_context *ctx, uint32_t address,
+			  const char *func_name)
+{
+	uint32_t value;
+#ifdef DM_CHECK_ADDR_0
+	if (address == 0) {
+		DC_ERR("invalid register read; address = 0\n");
+		return 0;
+	}
+#endif
+
+	if (ctx->dmub_srv &&
+	    ctx->dmub_srv->reg_helper_offload.gather_in_progress &&
+	    !ctx->dmub_srv->reg_helper_offload.should_burst_write) {
+		ASSERT(false);
+		return 0;
+	}
+
+	value = cgs_read_register(ctx->cgs_device, address);
+
+	trace_amdgpu_dc_rreg(&ctx->perf_trace->read_count, address, value);
+
+	return value;
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
index 51f57420fadd..d9e33c6bccd9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
@@ -33,18 +33,23 @@
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_irq.h"
 #include "amdgpu_pm.h"
+#include "amdgpu_dm_trace.h"
 
-
-
-unsigned long long dm_get_elapse_time_in_ns(struct dc_context *ctx,
-		unsigned long long current_time_stamp,
-		unsigned long long last_time_stamp)
+	unsigned long long
+	dm_get_elapse_time_in_ns(struct dc_context *ctx,
+				 unsigned long long current_time_stamp,
+				 unsigned long long last_time_stamp)
 {
 	return current_time_stamp - last_time_stamp;
 }
 
-void dm_perf_trace_timestamp(const char *func_name, unsigned int line)
+void dm_perf_trace_timestamp(const char *func_name, unsigned int line, struct dc_context *ctx)
 {
+	trace_amdgpu_dc_performance(ctx->perf_trace->read_count,
+				    ctx->perf_trace->write_count,
+				    &ctx->perf_trace->last_entry_read,
+				    &ctx->perf_trace->last_entry_write,
+				    func_name, line);
 }
 
 /**** power component interfaces ****/
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index d898981684d5..1151e03365a3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -26,7 +26,7 @@
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM amdgpu_dm
 
-#if !defined(_AMDGPU_DM_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#if !defined(_AMDGPU_DM_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
 #define _AMDGPU_DM_TRACE_H_
 
 #include <linux/tracepoint.h>
diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index 85a0170be544..57edb25fc381 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -296,32 +296,6 @@ uint32_t generic_reg_set_ex(const struct dc_context *ctx,
 	return reg_val;
 }
 
-uint32_t dm_read_reg_func(
-	const struct dc_context *ctx,
-	uint32_t address,
-	const char *func_name)
-{
-	uint32_t value;
-#ifdef DM_CHECK_ADDR_0
-	if (address == 0) {
-		DC_ERR("invalid register read; address = 0\n");
-		return 0;
-	}
-#endif
-
-	if (ctx->dmub_srv &&
-	    ctx->dmub_srv->reg_helper_offload.gather_in_progress &&
-	    !ctx->dmub_srv->reg_helper_offload.should_burst_write) {
-		ASSERT(false);
-		return 0;
-	}
-
-	value = cgs_read_register(ctx->cgs_device, address);
-	trace_amdgpu_dc_rreg(&ctx->perf_trace->read_count, address, value);
-
-	return value;
-}
-
 uint32_t generic_reg_get(const struct dc_context *ctx, uint32_t addr,
 		uint8_t shift, uint32_t mask, uint32_t *field_value)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services.h b/drivers/gpu/drm/amd/display/dc/dm_services.h
index fdd1943c828d..9a3f2a44f882 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services.h
@@ -31,8 +31,6 @@
 
 #define __DM_SERVICES_H__
 
-#include "amdgpu_dm_trace.h"
-
 /* TODO: remove when DC is complete. */
 #include "dm_services_types.h"
 #include "logger_interface.h"
@@ -49,43 +47,26 @@ irq_handler_idx dm_register_interrupt(
 	interrupt_handler ih,
 	void *handler_args);
 
-
 /*
  *
  * GPU registers access
  *
  */
-uint32_t dm_read_reg_func(
-	const struct dc_context *ctx,
-	uint32_t address,
-	const char *func_name);
+uint32_t dm_read_reg_func(const struct dc_context *ctx, uint32_t address,
+			  const char *func_name);
+
 /* enable for debugging new code, this adds 50k to the driver size. */
 /* #define DM_CHECK_ADDR_0 */
 
-#define dm_read_reg(ctx, address)	\
-		dm_read_reg_func(ctx, address, __func__)
-
+void dm_write_reg_func(const struct dc_context *ctx, uint32_t address,
+		       uint32_t value, const char *func_name);
 
+#define dm_read_reg(ctx, address)	\
+	dm_read_reg_func(ctx, address, __func__)
 
 #define dm_write_reg(ctx, address, value)	\
 	dm_write_reg_func(ctx, address, value, __func__)
 
-static inline void dm_write_reg_func(
-	const struct dc_context *ctx,
-	uint32_t address,
-	uint32_t value,
-	const char *func_name)
-{
-#ifdef DM_CHECK_ADDR_0
-	if (address == 0) {
-		DC_ERR("invalid register write. address = 0");
-		return;
-	}
-#endif
-	cgs_write_register(ctx->cgs_device, address, value);
-	trace_amdgpu_dc_wreg(&ctx->perf_trace->write_count, address, value);
-}
-
 static inline uint32_t dm_read_index_reg(
 	const struct dc_context *ctx,
 	enum cgs_ind_reg addr_space,
@@ -287,13 +268,10 @@ unsigned long long dm_get_elapse_time_in_ns(struct dc_context *ctx,
 /*
  * performance tracing
  */
-#define PERF_TRACE()	trace_amdgpu_dc_performance(CTX->perf_trace->read_count,\
-		CTX->perf_trace->write_count, &CTX->perf_trace->last_entry_read,\
-		&CTX->perf_trace->last_entry_write, __func__, __LINE__)
-#define PERF_TRACE_CTX(__CTX)	trace_amdgpu_dc_performance(__CTX->perf_trace->read_count,\
-		__CTX->perf_trace->write_count, &__CTX->perf_trace->last_entry_read,\
-		&__CTX->perf_trace->last_entry_write, __func__, __LINE__)
+void dm_perf_trace_timestamp(const char *func_name, unsigned int line, struct dc_context *ctx);
 
+#define PERF_TRACE()	dm_perf_trace_timestamp(__func__, __LINE__, CTX)
+#define PERF_TRACE_CTX(__CTX)	dm_perf_trace_timestamp(__func__, __LINE__, __CTX)
 
 /*
  * Debug and verification hooks
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
