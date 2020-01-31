Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42518C2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BA22082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="b2/kRuWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BA22082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 948FF6FC34;
	Fri, 31 Jan 2020 22:17:11 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760054.outbound.protection.outlook.com [40.107.76.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68B556FC31
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqGbcBrMH0jCeiniSNEZHFsUSZs9quJwUOEE+RDWdmgWzL9uoIkXk5BkDI9DpsZrpDVmfQe2RyZ7tsC+GtMlveHs35Ceg0WTbSvHF0n0tpGobRFhzi1fEJxHwhDbs/E7O6iHH12DMiSzCsuYxallbT8FLhSecqI5G9nGuyiCD24E7Xg3Xb/7jsUby/r4ubstRb8e8oCMJqq8qaY96e3IuuSiL1XPTiBq4XpGCiPfr+3BErU5LdQDAiK6rS1V4WS3AKaTLgHDq0AZInutrkiMCPhvjkL4TrHt8SQsrGXvbjLllXU1zQgatm3bAsjMj5WePArS/O/mKdEcoF/AwRuutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmiSHWHT1kJOyrwEGmTA1x5srQja+f8rIrCjgB+/MMc=;
 b=JAfnESE1JoGOMQ2vtIqF0o1VoZcoc4WDeI1KZmAWn+/srMMfU7Ba6L+290v8iZY2K5X2OjVtr9t1Nq6P7YQ6JOcFmvqPYgOpOP8HY930WrsAYOGeGP9malONfXZ0D/16U2YxMUvcUbaNruacbT6DAczzQkmt94iH1V0Fjhn9xlQb90WiVNQrbMoxuk0moyB3OghOl4IUPhZnIrDb4LaKek6gP2w7YfLJ2bVu/R0IY2PGmbMAFEj5hLt684jysQBse3u6gi+reEk6ImhrJt7sM0v2S8LB9XG4L3JD6/DnQ+g4LRdSIIM2KzCjhWHzl/MvI2IcnuLgz4Seu02ZWBrIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmiSHWHT1kJOyrwEGmTA1x5srQja+f8rIrCjgB+/MMc=;
 b=b2/kRuWUG3ToSn7JxkzHDoBkmrBAd69BzG8D8eRDNN4qCSMooqmnng/cTU8Y2LhuI3lYO49pWtbf6hoFD4j6eQKxINB05gzW6ccSW9pnEjVD/XOEieoeljnOzu8z7mJsns3ruBnJ406AWn1WXuYk0FGFGW3vEOHOCEffvlAx/SY=
Received: from BN6PR1201CA0012.namprd12.prod.outlook.com
 (2603:10b6:405:4c::22) by DM6PR12MB4218.namprd12.prod.outlook.com
 (2603:10b6:5:21b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29; Fri, 31 Jan
 2020 22:17:05 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::207) by BN6PR1201CA0012.outlook.office365.com
 (2603:10b6:405:4c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:05 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:04 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:04 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:03 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/33] drm/amd/display: Add GPINT handler interface
Date: Fri, 31 Jan 2020 17:16:19 -0500
Message-ID: <20200131221643.10035-10-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(396003)(428003)(189003)(199004)(1076003)(26005)(5660300002)(70586007)(70206006)(2616005)(426003)(336012)(7696005)(36756003)(478600001)(186003)(86362001)(4326008)(2906002)(54906003)(6666004)(356004)(6916009)(8936002)(316002)(81166006)(81156014)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4218; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31d2f6b0-a35c-48d8-767a-08d7a69b4dfe
X-MS-TrafficTypeDiagnostic: DM6PR12MB4218:
X-Microsoft-Antispam-PRVS: <DM6PR12MB421872ECD92A25595FEE5B6FF9070@DM6PR12MB4218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vqsTvxc7YF/omg05gFwcNahL5/DPt/y1gZMYBSNtBQJ256znhJi9VdZL7CTfCm/aTXeS091UWkwyT3qpZYeHL96xUH8WD5onVUjIXQ2tkLomiKMZgNJ+PDH+lkvr4w7dhUd5nQHrnMfVvFHmBl+5LlOnnpYBCOtziOClkskG9wXjzI2g+LstMdaEDDWPc93iWcUemLTIYX4EKcecwL1UMPn16CdsGMgTk+rD4ah7MwL5A0k4ggV0A+Q8F4MrdE6WM7HK1DSe/D3NydGp01ctG8Qd+avvsRo29EqPHs+8EkiowlfNkVe0C8Q/5mnnO16jHZfd6s/wA9QnOSagCk5nlb2opFM/MAhC8WWZPtf3jYJ5D9GVUTe7my903+nRWJWJGN451Ggoooh/I7rPXcvgJPqlQjlQDISVmWPrjGo4wy6tzVBkgJrxUnDA3uqFqKTB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:05.4458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d2f6b0-a35c-48d8-767a-08d7a69b4dfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The General Purpose Interrupt is used on the DMCUB to pass lightweight
commands via a register to the DMCUB.

This is limited to 32-bit command and 32-bit response.

This will be used for shutting down the firmware in a clean manner.

[How]
Add the command IDs and the data register to correctly format
the commands.

Add the interface functions to dmub_srv for sending and receiving the
commands.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../drm/amd/display/dmub/inc/dmub_gpint_cmd.h | 68 +++++++++++++++++++
 .../gpu/drm/amd/display/dmub/inc/dmub_srv.h   | 48 +++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 22 ++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |  9 +++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 50 ++++++++++++++
 5 files changed, 197 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h
new file mode 100644
index 000000000000..5398ed6b35d1
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h
@@ -0,0 +1,68 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef _DMUB_GPINT_CMD_H_
+#define _DMUB_GPINT_CMD_H_
+
+#include "dmub_types.h"
+
+/**
+ * The register format for sending a command via the GPINT.
+ */
+union dmub_gpint_data_register {
+	struct {
+		uint32_t param : 16;
+		uint32_t command_code : 12;
+		uint32_t status : 4;
+	} bits;
+	uint32_t all;
+};
+
+/**
+ * The shifts and masks below may alternatively be used to format and read
+ * the command register bits.
+ */
+
+#define DMUB_GPINT_DATA_PARAM_MASK 0xFFFF
+#define DMUB_GPINT_DATA_PARAM_SHIFT 0
+
+#define DMUB_GPINT_DATA_COMMAND_CODE_MASK 0xFFF
+#define DMUB_GPINT_DATA_COMMAND_CODE_SHIFT 16
+
+#define DMUB_GPINT_DATA_STATUS_MASK 0xF
+#define DMUB_GPINT_DATA_STATUS_SHIFT 28
+
+/*
+ * Command IDs should be treated as stable ABI.
+ * Do not reuse or modify IDs.
+ */
+
+enum dmub_gpint_command {
+	DMUB_GPINT__INVALID_COMMAND = 0,
+	DMUB_GPINT__GET_FW_VERSION = 1,
+	DMUB_GPINT__STOP_FW = 2,
+};
+
+#endif /* _DMUB_GPINT_CMD_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
index f8917594036a..e619fa9cf53a 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
@@ -66,6 +66,7 @@
 
 #include "dmub_types.h"
 #include "dmub_cmd.h"
+#include "dmub_gpint_cmd.h"
 #include "dmub_rb.h"
 
 #if defined(__cplusplus)
@@ -262,6 +263,14 @@ struct dmub_srv_hw_funcs {
 	bool (*is_phy_init)(struct dmub_srv *dmub);
 
 	bool (*is_auto_load_done)(struct dmub_srv *dmub);
+
+	void (*set_gpint)(struct dmub_srv *dmub,
+			  union dmub_gpint_data_register reg);
+
+	bool (*is_gpint_acked)(struct dmub_srv *dmub,
+			       union dmub_gpint_data_register reg);
+
+	uint32_t (*get_gpint_response)(struct dmub_srv *dmub);
 };
 
 /**
@@ -516,6 +525,45 @@ enum dmub_status dmub_srv_wait_for_phy_init(struct dmub_srv *dmub,
 enum dmub_status dmub_srv_wait_for_idle(struct dmub_srv *dmub,
 					uint32_t timeout_us);
 
+/**
+ * dmub_srv_send_gpint_command() - Sends a GPINT based command.
+ * @dmub: the dmub service
+ * @command_code: the command code to send
+ * @param: the command parameter to send
+ * @timeout_us: the maximum number of microseconds to wait
+ *
+ * Sends a command via the general purpose interrupt (GPINT).
+ * Waits for the number of microseconds specified by timeout_us
+ * for the command ACK before returning.
+ *
+ * Can be called after software initialization.
+ *
+ * Return:
+ *   DMUB_STATUS_OK - success
+ *   DMUB_STATUS_TIMEOUT - wait for ACK timed out
+ *   DMUB_STATUS_INVALID - unspecified error
+ */
+enum dmub_status
+dmub_srv_send_gpint_command(struct dmub_srv *dmub,
+			    enum dmub_gpint_command command_code,
+			    uint16_t param, uint32_t timeout_us);
+
+/**
+ * dmub_srv_get_gpint_response() - Queries the GPINT response.
+ * @dmub: the dmub service
+ * @response: the response for the last GPINT
+ *
+ * Returns the response code for the last GPINT interrupt.
+ *
+ * Can be called after software initialization.
+ *
+ * Return:
+ *   DMUB_STATUS_OK - success
+ *   DMUB_STATUS_INVALID - unspecified error
+ */
+enum dmub_status dmub_srv_get_gpint_response(struct dmub_srv *dmub,
+					     uint32_t *response);
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index b2ca8e0dbac9..7c1604c2221c 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -217,3 +217,25 @@ bool dmub_dcn20_is_supported(struct dmub_srv *dmub)
 
 	return supported;
 }
+
+void dmub_dcn20_set_gpint(struct dmub_srv *dmub,
+			  union dmub_gpint_data_register reg)
+{
+	REG_WRITE(DMCUB_GPINT_DATAIN1, reg.all);
+}
+
+bool dmub_dcn20_is_gpint_acked(struct dmub_srv *dmub,
+			       union dmub_gpint_data_register reg)
+{
+	union dmub_gpint_data_register test;
+
+	reg.bits.status = 0;
+	test.all = REG_READ(DMCUB_GPINT_DATAIN1);
+
+	return test.all == reg.all;
+}
+
+uint32_t dmub_dcn20_get_gpint_response(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_SCRATCH7);
+}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
index 04b0fa13153d..7f046c73927e 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
@@ -91,6 +91,7 @@ struct dmub_srv;
 	DMUB_SR(DMCUB_SCRATCH13) \
 	DMUB_SR(DMCUB_SCRATCH14) \
 	DMUB_SR(DMCUB_SCRATCH15) \
+	DMUB_SR(DMCUB_GPINT_DATAIN1) \
 	DMUB_SR(CC_DC_PIPE_DIS) \
 	DMUB_SR(MMHUBBUB_SOFT_RESET) \
 	DMUB_SR(DCN_VM_FB_LOCATION_BASE) \
@@ -183,4 +184,12 @@ bool dmub_dcn20_is_hw_init(struct dmub_srv *dmub);
 
 bool dmub_dcn20_is_supported(struct dmub_srv *dmub);
 
+void dmub_dcn20_set_gpint(struct dmub_srv *dmub,
+			  union dmub_gpint_data_register reg);
+
+bool dmub_dcn20_is_gpint_acked(struct dmub_srv *dmub,
+			       union dmub_gpint_data_register reg);
+
+uint32_t dmub_dcn20_get_gpint_response(struct dmub_srv *dmub);
+
 #endif /* _DMUB_DCN20_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 85a518bf8a76..45be185ef312 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -126,6 +126,9 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		funcs->set_inbox1_wptr = dmub_dcn20_set_inbox1_wptr;
 		funcs->is_supported = dmub_dcn20_is_supported;
 		funcs->is_hw_init = dmub_dcn20_is_hw_init;
+		funcs->set_gpint = dmub_dcn20_set_gpint;
+		funcs->is_gpint_acked = dmub_dcn20_is_gpint_acked;
+		funcs->get_gpint_response = dmub_dcn20_get_gpint_response;
 
 		if (asic == DMUB_ASIC_DCN21) {
 			dmub->regs = &dmub_srv_dcn21_regs;
@@ -522,3 +525,50 @@ enum dmub_status dmub_srv_wait_for_idle(struct dmub_srv *dmub,
 
 	return DMUB_STATUS_TIMEOUT;
 }
+
+enum dmub_status
+dmub_srv_send_gpint_command(struct dmub_srv *dmub,
+			    enum dmub_gpint_command command_code,
+			    uint16_t param, uint32_t timeout_us)
+{
+	union dmub_gpint_data_register reg;
+	uint32_t i;
+
+	if (!dmub->sw_init)
+		return DMUB_STATUS_INVALID;
+
+	if (!dmub->hw_funcs.set_gpint)
+		return DMUB_STATUS_INVALID;
+
+	if (!dmub->hw_funcs.is_gpint_acked)
+		return DMUB_STATUS_INVALID;
+
+	reg.bits.status = 1;
+	reg.bits.command_code = command_code;
+	reg.bits.param = param;
+
+	dmub->hw_funcs.set_gpint(dmub, reg);
+
+	for (i = 0; i < timeout_us; ++i) {
+		if (dmub->hw_funcs.is_gpint_acked(dmub, reg))
+			return DMUB_STATUS_OK;
+	}
+
+	return DMUB_STATUS_TIMEOUT;
+}
+
+enum dmub_status dmub_srv_get_gpint_response(struct dmub_srv *dmub,
+					     uint32_t *response)
+{
+	*response = 0;
+
+	if (!dmub->sw_init)
+		return DMUB_STATUS_INVALID;
+
+	if (!dmub->hw_funcs.get_gpint_response)
+		return DMUB_STATUS_INVALID;
+
+	*response = dmub->hw_funcs.get_gpint_response(dmub);
+
+	return DMUB_STATUS_OK;
+}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
