Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2E9C27C51
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3612589149;
	Fri, 31 May 2024 16:52:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FDOKzNjq";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21ACE10E288
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuC/kE/seKvOF8PcEUUFP9upN/u07ooSFl/dCRIgekDtxLBN3SSWUeNOhF4rd9g1sIqc8CAJBMOLm62sIeMjSYykoeAZmRIrR6O7W7YxD5Lptnhc+JhuWG+vH3/2jBFFcfVkEaGXterf992rshmhwrJbX6ujfEZ4QO8+4OR9EdVX5UhMXauPcZ1i6qGSbZE1Hr6XQnL/O9nDraIGtk9v0TI2kHLAb9kI2zZ/Jrwj6X+mB63Ulx4mAOU3HfGDURzBMYqcCkYAgaI9GmEqgxOOwSpbttp3lZDB/45bAdzEsWREeF4zhfpbS3X5uw12rrKr0A/pFM2Dbj1Y7U+AUdOOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzzwQskzR1ZhYX+adn0qXHY00VICmMGlaarUzIwe4QA=;
 b=HrBuBgHk1t4ddoJS2gAhzxw3KfjC9hA67sGnE+Lpjj+U4ztGf6CL4uDaYRJXsWJtYubFS81TWRE/lKYHVvpg41HmhlJV5AsJRiGkGv8f3q/Da6VT2yQSGXWcQj0rAH+2tUN8GcbHUy1c17N2p6P6+0+OlJ4AD3AlhABQXmhTGqI1ipWu+so2BCELwHCOsfqFWGrhVCL0HAwLjeR1UoOcohQD2vfTrpPfM52rSZ4Vy3JrgS6UY1U6QwlzHP8/F+nGG7K3NMf7yD94zdGlI5StbKz9w7INzzYjWGh4iE3Xzsz1dySKuSTvSlmBONweH20LNpBpMIiVuxow8mfSMWuOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzzwQskzR1ZhYX+adn0qXHY00VICmMGlaarUzIwe4QA=;
 b=FDOKzNjq2bWU/lLHn/VaZtH82VYVEhYs1gmZp4K7HaSuIP/Yiv0wc8QWK+Lj2B2Lu99DquXnh7azD9grGLwpqQhqTfgX30OWthd595odKzN/IGClv0ec1Oq9Y4NmYAmEhPk1dMt+AHVkpIkFi86UuXRleM4nCZoyPLUesoT+OOQ=
Received: from PH7PR10CA0010.namprd10.prod.outlook.com (2603:10b6:510:23d::19)
 by DS0PR12MB7826.namprd12.prod.outlook.com (2603:10b6:8:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.31; Fri, 31 May
 2024 16:52:28 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::f9) by PH7PR10CA0010.outlook.office365.com
 (2603:10b6:510:23d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Fri, 31 May 2024 16:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:28 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:23 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 03/32] drm/amd/display: Wait for hardmins to complete on dcn401
Date: Fri, 31 May 2024 12:51:16 -0400
Message-ID: <20240531165145.1874966-4-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS0PR12MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab2d621-0318-4383-c344-08dc81920e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1nnfkBqsJC/5K/7EtK7tIjZGjcSj7uQpvF267iuOZKUFu/jW2JTiM5FbShUQ?=
 =?us-ascii?Q?RgIQyfcwzzWGWG1e4LjCbQY5Wb3G7kNuSAGtmJrTgRAEyrzzuzQ9TOKctGZ3?=
 =?us-ascii?Q?FM4N4aw9MWod03R3EKlVCJhTPLFupSlXNbdEa8iPttK2g2VHD7ZOMeK4hjqd?=
 =?us-ascii?Q?GMsuCa0MdHLfPSTVKtQoYQMKkiYHQeYAvper4Kd67ecT4d1FxEmV0YtUEUo8?=
 =?us-ascii?Q?lDsQv6eWq34yLwqls4yNmZkPLJaI+bN7KZbbf7v1/K4hvWflLjEDuRSpHn90?=
 =?us-ascii?Q?9k4wx+W/TjLjIJ7OcmRjXaBAMy1r1Lqcn+mcAz1Bnn96BHNZtNaC0wY/j/JZ?=
 =?us-ascii?Q?ZCpIORmAsGG1/L9N/4ip9Utb9p+MbBPUFrdRajTxzplzl3PWjgSt2yNje/mt?=
 =?us-ascii?Q?6cbln+75Fl+skHMw0P2CFM9boRtapmFJ+vihFCACUNfMPlWlmvRitE6VEhHM?=
 =?us-ascii?Q?tEByZzngdlb+iKKypaxlaUfFTxrugs7A4pJi1WnYxkhaGVSUNe/rAkku1VMC?=
 =?us-ascii?Q?h5XAAX/3L7E/xA387KkKuBZT1IBm4m75q8kznBARvd9CkYsxndpgHC3m1qTq?=
 =?us-ascii?Q?JygaagECsEMeZoFgz2Z+fuR9BO+gKwKeS8SwYx47CcAAiHqJ8vKnIVO+EV7f?=
 =?us-ascii?Q?CxrU6/b6clxBanG7I5ZGHVgs/VzPTbrDknrTiQANo46PsJ3n69Y7ywgH784S?=
 =?us-ascii?Q?QDtjyCcG9zcwTm7BFH6jilPTAFUnhlxcm0mPBV4WAoWmBTrhdFkYqCtjrVuk?=
 =?us-ascii?Q?MhtAKki66xIJoen+zItiofpRYSb/OrvUygM4oBLVRcr/b/WbZVHNe7IYE3xm?=
 =?us-ascii?Q?SB27BhDn6iO1HSb6eh4u1byWf4+yR5yPqnEHVr9ouZxCUkEQDnu+5ujDJdUD?=
 =?us-ascii?Q?BCX/VwmBYDiET8DyBuo3sFsSF0Suz8o1q//N5QUBpzUGhQgTAFnIIVnc5kq5?=
 =?us-ascii?Q?/NYgAc0yxwk0QGyQtjB2sleq9O0j65C9I0CK1WuB9cxYu06AjsmDzjYCQGv8?=
 =?us-ascii?Q?WGApSvZ/1bwJvWekv1xCqRyosi+UqlHJVms7oDj8S1DlmQ5Y2gO+otyIBEre?=
 =?us-ascii?Q?uxn4wQ1yuxaRNibq7B4PGImLVi8dssKbirh63AH/3XPi6LZLmLUekLi2QFRf?=
 =?us-ascii?Q?UtoVjeIeA24PY6YRRHt79U2WoERCjdDccaxm2lcSYIBxV/RiLyfZDzciztVP?=
 =?us-ascii?Q?LpWonODMayFhbXV3dcJVHA1aT9OgD8pOEDN4ahGEcsyt4d0/TuCBG5Z1tef+?=
 =?us-ascii?Q?DHNBR5gSuCDXbq0S+goAnTUbfjyFG+mp9OE9wYDaTBs+Xso3FhRL2W0qiMq0?=
 =?us-ascii?Q?b8JcBiNpUl0manqFKG5ULavE4G/l4SHM8vbdeDJ+3pSnmodMp6G3s1y1CBPE?=
 =?us-ascii?Q?usAAeY2OhxUA8YxOZHQfcqmh5Z0s?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:28.1524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab2d621-0318-4383-c344-08dc81920e27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7826
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
When updating clocks via SMU, DAL needs to wait for requests to be fulfilled
before proceeding.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn401/dalsmc.h    |   3 +-
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c   | 113 +++++++++++++++++-
 2 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dalsmc.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dalsmc.h
index 5653c7991c62..dbfdd3487da5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dalsmc.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dalsmc.h
@@ -42,7 +42,8 @@
 #define DALSMC_MSG_IndicateDrrStatus              0x17  // PMFW 15811
 #define DALSMC_MSG_ActiveUclkFclk                 0x18
 #define DALSMC_MSG_IdleUclkFclk                   0x19
-#define DALSMC_Message_Count                      0x1A
+#define DALSMC_MSG_SetUclkPstateAllow             0x1A
+#define DALSMC_Message_Count                      0x1B
 
 typedef enum {
   FCLK_SWITCH_DISALLOW,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
index a3d0a48ed7ce..84e9203aba3b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
@@ -69,6 +69,68 @@ static bool dcn401_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, uin
 	return false;
 }
 
+/*
+ * Use these functions to return back delay information so we can aggregate the total
+ *  delay when requesting hardmin clk
+ *
+ * dcn401_smu_wait_for_response_delay
+ * dcn401_smu_send_msg_with_param_delay
+ *
+ */
+static uint32_t dcn401_smu_wait_for_response_delay(struct clk_mgr_internal *clk_mgr, unsigned int delay_us, unsigned int max_retries, unsigned int *total_delay_us)
+{
+	uint32_t reg = 0;
+	*total_delay_us = 0;
+
+	do {
+		reg = REG_READ(DAL_RESP_REG);
+		if (reg)
+			break;
+
+		if (delay_us >= 1000)
+			msleep(delay_us/1000);
+		else if (delay_us > 0)
+			udelay(delay_us);
+		*total_delay_us += delay_us;
+	} while (max_retries--);
+
+	TRACE_SMU_DELAY(*total_delay_us, clk_mgr->base.ctx);
+
+	return reg;
+}
+
+static bool dcn401_smu_send_msg_with_param_delay(struct clk_mgr_internal *clk_mgr, uint32_t msg_id, uint32_t param_in, uint32_t *param_out, unsigned int *total_delay_us)
+{
+	unsigned int delay1_us, delay2_us;
+	*total_delay_us = 0;
+
+	/* Wait for response register to be ready */
+	dcn401_smu_wait_for_response_delay(clk_mgr, 10, 200000, &delay1_us);
+
+	/* Clear response register */
+	REG_WRITE(DAL_RESP_REG, 0);
+
+	/* Set the parameter register for the SMU message */
+	REG_WRITE(DAL_ARG_REG, param_in);
+
+	/* Trigger the message transaction by writing the message ID */
+	REG_WRITE(DAL_MSG_REG, msg_id);
+
+	TRACE_SMU_MSG(msg_id, param_in, clk_mgr->base.ctx);
+
+	/* Wait for response */
+	if (dcn401_smu_wait_for_response_delay(clk_mgr, 10, 200000, &delay2_us) == DALSMC_Result_OK) {
+		if (param_out)
+			*param_out = REG_READ(DAL_ARG_REG);
+
+		*total_delay_us = delay1_us + delay2_us;
+		return true;
+	}
+
+	*total_delay_us = delay1_us + 2000000;
+	return false;
+}
+
 void dcn401_smu_send_fclk_pstate_message(struct clk_mgr_internal *clk_mgr, bool enable)
 {
 	smu_print("FCLK P-state support value is : %d\n", enable);
@@ -101,6 +163,51 @@ void dcn401_smu_set_pme_workaround(struct clk_mgr_internal *clk_mgr)
 		DALSMC_MSG_BacoAudioD3PME, 0, NULL);
 }
 
+static unsigned int dcn401_smu_get_hard_min_status(struct clk_mgr_internal *clk_mgr, bool *no_timeout, unsigned int *total_delay_us)
+{
+	uint32_t response = 0;
+
+	/* bits 23:16 for clock type, lower 16 bits for frequency in MHz */
+	uint32_t param = 0;
+
+	*no_timeout = dcn401_smu_send_msg_with_param_delay(clk_mgr,
+			DALSMC_MSG_ReturnHardMinStatus, param, &response, total_delay_us);
+
+	smu_print("SMU Get hard min status: no_timeout %d delay %d us clk bits %x\n",
+		*no_timeout, *total_delay_us, response);
+
+	return response;
+}
+
+static bool dcn401_smu_wait_hard_min_status(struct clk_mgr_internal *clk_mgr, uint32_t ppclk)
+{
+	const unsigned int max_delay_us = 1000000;
+
+	unsigned int hardmin_status_mask = (1 << ppclk);
+	unsigned int total_delay_us = 0;
+	bool hardmin_done = false;
+
+	while (!hardmin_done && total_delay_us < max_delay_us) {
+		unsigned int hardmin_status;
+		unsigned int read_total_delay_us;
+		bool no_timeout;
+
+		if (!hardmin_done && total_delay_us > 0) {
+			/* hardmin not yet fulfilled, wait 500us and retry*/
+			udelay(500);
+			total_delay_us += 500;
+
+			smu_print("SMU Wait hard min status for %d us\n", total_delay_us);
+		}
+
+		hardmin_status = dcn401_smu_get_hard_min_status(clk_mgr, &no_timeout, &read_total_delay_us);
+		total_delay_us += read_total_delay_us;
+		hardmin_done = hardmin_status & hardmin_status_mask;
+	}
+
+	return hardmin_done;
+}
+
 /* Returns the actual frequency that was set in MHz, 0 on failure */
 unsigned int dcn401_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint16_t freq_mhz)
 {
@@ -116,7 +223,7 @@ unsigned int dcn401_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, u
 			DALSMC_MSG_SetHardMinByFreq, param, &response);
 
 	/* wait until hardmin acknowledged */
-	//hard_min_done = dcn401_smu_wait_get_hard_min_status(clk_mgr, clk);
+	hard_min_done = dcn401_smu_wait_hard_min_status(clk_mgr, clk);
 	smu_print("SMU Frequency set = %d KHz hard_min_done %d\n", response, hard_min_done);
 
 	return response;
@@ -153,7 +260,7 @@ bool dcn401_smu_set_idle_uclk_fclk_hardmin(struct clk_mgr_internal *clk_mgr,
 			DALSMC_MSG_IdleUclkFclk, param, &response);
 
 	/* wait until hardmin acknowledged */
-	//success &= dcn401_smu_wait_get_hard_min_status(clk_mgr, PPCLK_UCLK);
+	success &= dcn401_smu_wait_hard_min_status(clk_mgr, PPCLK_UCLK);
 	smu_print("SMU hard_min_done %d\n", success);
 
 	return success;
@@ -175,7 +282,7 @@ bool dcn401_smu_set_active_uclk_fclk_hardmin(struct clk_mgr_internal *clk_mgr,
 			DALSMC_MSG_ActiveUclkFclk, param, &response);
 
 	/* wait until hardmin acknowledged */
-	//success &= dcn401_smu_wait_get_hard_min_status(clk_mgr, PPCLK_UCLK);
+	success &= dcn401_smu_wait_hard_min_status(clk_mgr, PPCLK_UCLK);
 	smu_print("SMU hard_min_done %d\n", success);
 
 	return success;
-- 
2.34.1

