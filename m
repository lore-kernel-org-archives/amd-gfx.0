Return-Path: <SRS0=Inwe=AH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32811C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0552D206BE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jkkvGt1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0552D206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C25296ECD8;
	Fri, 26 Jun 2020 16:19:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C28126ECD4
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 16:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0UrtMYOpRYf0wLQ58mUMl7tXZ/k97IuYwzFvVArQm+udiuOYtDQ3Jx3Syxc1sw3skoX92rHeJvgNYoyogPSu77G0lPQwGZLacILynwglitj4lpk6WBLO+Dj+nQSwAeIvAXR4Yy7God1zQhdIMTHkHF+b/R6LsBoBMQAzGD4dlQgqIFs6N8zqsIyq61MaLd25LbwO85ADgTT0q9RJXUv/YZ5lz8zz8kNoE7LBOh7QZvOgf9RwsZttehUL05wyRhF9SIw+MDeV2N8a4ZXVkh5itAzoTblQCmjHp/4PYlSfs389MiVMwna6Il2dto2zyAbRTtzoaGiPfFk5h1/ELU3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmTB9MqmJt+PFb/9S2aCBClwyASYnNTVM9fU4ewcRnc=;
 b=MYEqJVsu3GaMQCvkhLO5qH/jrAYkR0vYklILYA4sVP/7KzctisvFmWc/WDtIc4Bs7JnS5yFmIQoVqQXjiqR2o50NcfNyedHipTZ6WNL1lhiecE8FeqaeFpybqXrFqUtx9Wg7LftMhYNF8UBuzSLYFusoigg89CNaKD9NwqXp3ycBr6HqBFR0teChkzLB4PATjxA7vgZJPXStfjt1mbU+O0OrQdysP5MWcLYhdhgchXipSCF1uGm5W4dW7RmSuXHHdDJeSsQZH6MUdf+Gq2EjvWKPMgsKkeK4FIweDaB1ZouO2bcYnv1Gc1Ikik8kx2yqBmYYGyy+DnpBf7NHTDnVWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmTB9MqmJt+PFb/9S2aCBClwyASYnNTVM9fU4ewcRnc=;
 b=jkkvGt1/tU8LBjJyXqOh0jZP/d6RBdU3ZSORnfzaQG2/TLZaHelXEmpLNuNtGbGIIbceIsMuxVhfgYzxmd+3erTPzN/NN8h2gN4dYBh+AlSj3Xbv0TQrqEtSchIp8UJTC30wczTfavy8jPRodULcyU90KSpgjabKpHawcU6YCIc=
Received: from DM3PR12CA0072.namprd12.prod.outlook.com (2603:10b6:0:57::16) by
 BY5PR12MB3858.namprd12.prod.outlook.com (2603:10b6:a03:1a7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Fri, 26 Jun
 2020 16:19:50 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::45) by DM3PR12CA0072.outlook.office365.com
 (2603:10b6:0:57::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Fri, 26 Jun 2020 16:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 16:19:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jun
 2020 11:19:49 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jun
 2020 11:19:49 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 26 Jun 2020 11:19:49 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/11] drm/amd/display: Handle SMU msg response
Date: Fri, 26 Jun 2020 12:18:40 -0400
Message-ID: <20200626161847.16000-5-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626161847.16000-1-eryk.brol@amd.com>
References: <20200626161847.16000-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966005)(1076003)(19627235002)(5660300002)(70586007)(86362001)(2616005)(6666004)(4326008)(70206006)(44832011)(82310400002)(356005)(426003)(6916009)(8936002)(336012)(83380400001)(54906003)(82740400003)(47076004)(81166007)(478600001)(26005)(36756003)(2906002)(8676002)(316002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb505fa2-ff6c-4b3d-4a2a-08d819ecc047
X-MS-TrafficTypeDiagnostic: BY5PR12MB3858:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3858F0DFC5815DCD708DDE1AE5930@BY5PR12MB3858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4eVlRpKN0MHFJ2uM+84TD/SW6fnsQfqkysSk57ehyLq1cFcd85MxZKY0gPZqEJ9NnGRhJZIjE/SvufKuD1piXmYYuqx88UTsC95JxWcZQsaBO13szFo+Q3MtcteHDzBcGPpPRC/AKCV39NbQkf+ES9AMxvHy4GXLqhBPachRyTbB/sMkxrqskEdrzLIdyT6+qvpoOlsRvZQEt1dfghwO4v1KRItuR7ND0nLSJebZm0yDsxA9LzVGMhw/jlvbTWguANQV047/SvkaiBJxOzTo9WBnH0sqfPwkKusWmjwqNFUeG7vrT5dWJMgmq3Jum/v56Iwu2H2woBGXiQC27d9RFIONQ6NT7KrS2QtIVK8/aimM1ABYSDrv5vGfVslyrh8J4/mkdIYFolTREUDXxQvpLw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 16:19:50.0969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb505fa2-ff6c-4b3d-4a2a-08d819ecc047
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3858
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
Cc: eryk.brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
SMU may return error code to driver, but driver only check if response
is OK.

[How]
Check SMU response instead of reg_wait, assert in case of reponse isn't
OK.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c  | 39 +++++++++++++++++-
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   | 40 ++++++++++++++++++-
 2 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
index c320b7af7d34..dbc7cde00433 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
@@ -26,6 +26,7 @@
 #include "core_types.h"
 #include "clk_mgr_internal.h"
 #include "reg_helper.h"
+#include <linux/delay.h>
 
 #define MAX_INSTANCE	5
 #define MAX_SEGMENT		5
@@ -68,10 +69,42 @@ static const struct IP_BASE MP1_BASE  = { { { { 0x00016000, 0, 0, 0, 0 } },
 #define VBIOSSMC_MSG_SetDispclkFreq           0x4
 #define VBIOSSMC_MSG_SetDprefclkFreq          0x5
 
+#define VBIOSSMC_Status_BUSY                      0x0
+#define VBIOSSMC_Result_OK                        0x1
+#define VBIOSSMC_Result_Failed                    0xFF
+#define VBIOSSMC_Result_UnknownCmd                0xFE
+#define VBIOSSMC_Result_CmdRejectedPrereq         0xFD
+#define VBIOSSMC_Result_CmdRejectedBusy           0xFC
+
+/*
+ * Function to be used instead of REG_WAIT macro because the wait ends when
+ * the register is NOT EQUAL to zero, and because the translation in msg_if.h
+ * won't work with REG_WAIT.
+ */
+static uint32_t rv1_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, unsigned int delay_us, unsigned int max_retries)
+{
+	uint32_t res_val = VBIOSSMC_Status_BUSY;
+
+	do {
+		res_val = REG_READ(MP1_SMN_C2PMSG_91);
+		if (res_val != VBIOSSMC_Status_BUSY)
+			break;
+
+		if (delay_us >= 1000)
+			msleep(delay_us/1000);
+		else if (delay_us > 0)
+			udelay(delay_us);
+	} while (max_retries--);
+
+	return res_val;
+}
+
 int rv1_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, unsigned int msg_id, unsigned int param)
 {
+	uint32_t result;
+
 	/* First clear response register */
-	REG_WRITE(MP1_SMN_C2PMSG_91, 0);
+	REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Status_BUSY);
 
 	/* Set the parameter register for the SMU message, unit is Mhz */
 	REG_WRITE(MP1_SMN_C2PMSG_83, param);
@@ -79,7 +112,9 @@ int rv1_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, unsigned
 	/* Trigger the message transaction by writing the message ID */
 	REG_WRITE(MP1_SMN_C2PMSG_67, msg_id);
 
-	REG_WAIT(MP1_SMN_C2PMSG_91, CONTENT, 1, 10, 200000);
+	result = rv1_smu_wait_for_response(clk_mgr, 10, 1000);
+
+	ASSERT(result == VBIOSSMC_Result_OK);
 
 	/* Actual dispclk set is returned in the parameter register */
 	return REG_READ(MP1_SMN_C2PMSG_83);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
index 6878aedf1d3e..d2facbb114d3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
@@ -26,6 +26,7 @@
 #include "core_types.h"
 #include "clk_mgr_internal.h"
 #include "reg_helper.h"
+#include <linux/delay.h>
 
 #include "renoir_ip_offset.h"
 
@@ -53,10 +54,43 @@
 #define VBIOSSMC_MSG_EnableTmdp48MHzRefclkPwrDown 0xD
 #define VBIOSSMC_MSG_UpdatePmeRestore			  0xE
 
+#define VBIOSSMC_Status_BUSY                      0x0
+#define VBIOSSMC_Result_OK                        0x1
+#define VBIOSSMC_Result_Failed                    0xFF
+#define VBIOSSMC_Result_UnknownCmd                0xFE
+#define VBIOSSMC_Result_CmdRejectedPrereq         0xFD
+#define VBIOSSMC_Result_CmdRejectedBusy           0xFC
+
+/*
+ * Function to be used instead of REG_WAIT macro because the wait ends when
+ * the register is NOT EQUAL to zero, and because the translation in msg_if.h
+ * won't work with REG_WAIT.
+ */
+static uint32_t rn_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, unsigned int delay_us, unsigned int max_retries)
+{
+	uint32_t res_val = VBIOSSMC_Status_BUSY;
+
+	do {
+		res_val = REG_READ(MP1_SMN_C2PMSG_91);
+		if (res_val != VBIOSSMC_Status_BUSY)
+			break;
+
+		if (delay_us >= 1000)
+			msleep(delay_us/1000);
+		else if (delay_us > 0)
+			udelay(delay_us);
+	} while (max_retries--);
+
+	return res_val;
+}
+
+
 int rn_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, unsigned int msg_id, unsigned int param)
 {
+	uint32_t result;
+
 	/* First clear response register */
-	REG_WRITE(MP1_SMN_C2PMSG_91, 0);
+	REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Status_BUSY);
 
 	/* Set the parameter register for the SMU message, unit is Mhz */
 	REG_WRITE(MP1_SMN_C2PMSG_83, param);
@@ -64,7 +98,9 @@ int rn_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, unsigned
 	/* Trigger the message transaction by writing the message ID */
 	REG_WRITE(MP1_SMN_C2PMSG_67, msg_id);
 
-	REG_WAIT(MP1_SMN_C2PMSG_91, CONTENT, 1, 10, 200000);
+	result = rn_smu_wait_for_response(clk_mgr, 10, 1000);
+
+	ASSERT(result == VBIOSSMC_Result_OK);
 
 	/* Actual dispclk set is returned in the parameter register */
 	return REG_READ(MP1_SMN_C2PMSG_83);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
