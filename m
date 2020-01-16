Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85230C33CB3
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565B2206D9
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CZfLgb9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565B2206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BEB56E2B2;
	Thu, 16 Jan 2020 20:14:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCC946E2B2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaU78mFTmvOq6OXWVLSXha94FiyF3uxgJoFDprNdTSj+gNXV9SW1awl+jw+Ba9FSt8KcYuKKDahZHBWPrLt3MUX8v/PRBBZS707vv/W+qb08Pjd9FP5saXBw6F6XuOInKQKbh/3cjURveCaTxSWm9abzAlmheIHLAPcWLloUB1rDp6+k6gGQyGthrhSOy4wEk/VxJf476MEu1W9lNozjJCEp8fNkCFmOLsSL8S2SWO/U3v1phFKAMnoQoAJ1lTBdkTHvVMszS92YZOljesVAl14JXuggdcssl5O+bL3u4cMnAyuETZl7yjFadSlxxoGpt6b5i7YdwmFx1+CMR2wnRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0iPfJ4xdMFyM0XD/DDqpPgDV3H/4xPBRfkXWpU7GhE=;
 b=oGubkOIEmXuljtF2zmioj8VFkXPkvOP1BClsgvwIfqJfVVRNHAepQz1JaHiiojd3bt84a9JBSJraVoqUB9GIMZV42okoQx/jp5J73uF1IEceWOtrCKwre8GCZIP0h6moGAu1+L4+2g8ROXtzDtyaTord0DgoMa8M3Z1bxWuO1yns3cS6XnQDleB8OWwWYhMhh/54bdYYVAwDgiEGFO8hVu5qqwX7C729RoT7hNH1zBzNGctziYR4vD7zLFOb7dqq2p77w8UEcM7HHjCornWaNUAd2OUiFp04LAR+UF4i577hwvQ8SXvxeYoJJDTV5gO8NsTTysiEJ6r1zJOryu47IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0iPfJ4xdMFyM0XD/DDqpPgDV3H/4xPBRfkXWpU7GhE=;
 b=CZfLgb9Umwkqzuh/IkJsJykWX3NSNePDNkC7bS8eMagzl50C+3cQEubbjVDTg6s/8rOowwMaNznl6/5b4zb6d2LF13UURDd3LdyQo5gtqWLKAdzC16HLyaMHqwLuX47bBbkRhjXTUpmQc+XxN6VM6ucqe+njj99CNW5Plj1ny7M=
Received: from DM5PR12CA0010.namprd12.prod.outlook.com (2603:10b6:4:1::20) by
 CY4PR12MB1350.namprd12.prod.outlook.com (2603:10b6:903:41::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 16 Jan 2020 20:14:30 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by DM5PR12CA0010.outlook.office365.com
 (2603:10b6:4:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:30 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:30 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:27 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:27 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/22] drm/amd/display: Refine i2c frequency calculating
 sequence
Date: Thu, 16 Jan 2020 15:14:07 -0500
Message-ID: <20200116201418.2254-12-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(136003)(428003)(199004)(189003)(2906002)(8936002)(336012)(426003)(316002)(6916009)(36756003)(81156014)(70206006)(54906003)(81166006)(70586007)(8676002)(186003)(4326008)(26005)(2616005)(7696005)(478600001)(356004)(6666004)(1076003)(5660300002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1350; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eff75174-2308-4269-9626-08d79ac0b1cc
X-MS-TrafficTypeDiagnostic: CY4PR12MB1350:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1350DD05B97EF7FD8FC1EE5CF9360@CY4PR12MB1350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VztyHHoSyIMjQ/V5jFeURtrRVzB0QEeNqAxXy4fc0JF07IgZTtRFcsRDdqjT66w8ZnPLFqb2FQG4om3n9KHjQIy0Fq8s5TM8tioWdRSwMCT3K0BSs+qqIYxZ+uYItyvEUpXUW8D+zF/2ACJCkfEIMB1vojwUz0eUXbvReH70sS46hcDAjPpw+arXL/ddMxqQnx233TlVIl6PBOkHe4Vc6eKoQVXQphwMa6/SJB4NM03dfiqGYScRhjSRG+8UGpGuh3vngav1s1YcXfmcNFytx5e7bxUpwe9RRG4VRQPWg7LRv/Wo4k8bGJZ8tzU7g6y4o5EP2KhRsYIr2MWhr/hH8tXKCT0yE0gPsKqIdedoflIr2eMk+uZ0QsLFY4/Ar9ySyixwdE6u8XnYzcuVs+2V/W4t3tnok7Zxguaff/vsOVVokE0lms01yzQO5PL+Ss9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:30.2547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eff75174-2308-4269-9626-08d79ac0b1cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1350
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
 Lewis Huang <Lewis.Huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <Lewis.Huang@amd.com>

[Why]
In HG mode, vbios didn't call DispController_Init to program NV1x
XTAL_REF_DIV value when ASIC_INIT, but driver read XTAL_REF_DIV
to calculate i2c reference frequency. it cause i2c frequency change
from 100kHz to 200kHz.

[How]
remove get_speed function and calculate reference frequency at
set_speed functiton.

Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   | 68 ++++++-------------
 1 file changed, 19 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
index 1cd4d8fc361f..49d490214060 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
@@ -100,20 +100,6 @@ static uint32_t get_hw_buffer_available_size(
 			dce_i2c_hw->buffer_used_bytes;
 }
 
-static uint32_t get_speed(
-	const struct dce_i2c_hw *dce_i2c_hw)
-{
-	uint32_t pre_scale = 0;
-
-	REG_GET(SPEED, DC_I2C_DDC1_PRESCALE, &pre_scale);
-
-	/* [anaumov] it seems following is unnecessary */
-	/*ASSERT(value.bits.DC_I2C_DDC1_PRESCALE);*/
-	return pre_scale ?
-		dce_i2c_hw->reference_frequency / pre_scale :
-		dce_i2c_hw->default_speed;
-}
-
 static void process_channel_reply(
 	struct dce_i2c_hw *dce_i2c_hw,
 	struct i2c_payload *reply)
@@ -278,16 +264,25 @@ static void set_speed(
 	struct dce_i2c_hw *dce_i2c_hw,
 	uint32_t speed)
 {
+	uint32_t xtal_ref_div = 0;
+	uint32_t prescale = 0;
+
+	REG_GET(MICROSECOND_TIME_BASE_DIV, XTAL_REF_DIV, &xtal_ref_div);
+
+	if (xtal_ref_div == 0)
+		xtal_ref_div = 2;
+
+	prescale = ((dce_i2c_hw->reference_frequency * 2) / xtal_ref_div) / speed;
 
 	if (speed) {
 		if (dce_i2c_hw->masks->DC_I2C_DDC1_START_STOP_TIMING_CNTL)
 			REG_UPDATE_N(SPEED, 3,
-				     FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_PRESCALE), dce_i2c_hw->reference_frequency / speed,
+				     FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_PRESCALE), prescale,
 				     FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_THRESHOLD), 2,
 				     FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_START_STOP_TIMING_CNTL), speed > 50 ? 2:1);
 		else
 			REG_UPDATE_N(SPEED, 2,
-				     FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_PRESCALE), dce_i2c_hw->reference_frequency / speed,
+				     FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_PRESCALE), prescale,
 				     FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_THRESHOLD), 2);
 	}
 }
@@ -344,9 +339,7 @@ static void release_engine(
 	bool safe_to_reset;
 
 	/* Restore original HW engine speed */
-
-	set_speed(dce_i2c_hw, dce_i2c_hw->original_speed);
-
+	REG_WRITE(SPEED, dce_i2c_hw->original_speed);
 
 	/* Reset HW engine */
 	{
@@ -416,7 +409,7 @@ struct dce_i2c_hw *acquire_i2c_hw_engine(
 
 	dce_i2c_hw->ddc = ddc;
 
-	current_speed = get_speed(dce_i2c_hw);
+	current_speed = REG_READ(SPEED);
 
 	if (current_speed)
 		dce_i2c_hw->original_speed = current_speed;
@@ -478,13 +471,9 @@ static void submit_channel_request_hw(
 
 static uint32_t get_transaction_timeout_hw(
 	const struct dce_i2c_hw *dce_i2c_hw,
-	uint32_t length)
+	uint32_t length,
+	uint32_t speed)
 {
-
-	uint32_t speed = get_speed(dce_i2c_hw);
-
-
-
 	uint32_t period_timeout;
 	uint32_t num_of_clock_stretches;
 
@@ -504,7 +493,8 @@ static uint32_t get_transaction_timeout_hw(
 bool dce_i2c_hw_engine_submit_payload(
 	struct dce_i2c_hw *dce_i2c_hw,
 	struct i2c_payload *payload,
-	bool middle_of_transaction)
+	bool middle_of_transaction,
+	uint32_t speed)
 {
 
 	struct i2c_request_transaction_data request;
@@ -542,7 +532,7 @@ bool dce_i2c_hw_engine_submit_payload(
 	/* obtain timeout value before submitting request */
 
 	transaction_timeout = get_transaction_timeout_hw(
-		dce_i2c_hw, payload->length + 1);
+		dce_i2c_hw, payload->length + 1, speed);
 
 	submit_channel_request_hw(
 		dce_i2c_hw, &request);
@@ -588,13 +578,11 @@ bool dce_i2c_submit_command_hw(
 		struct i2c_payload *payload = cmd->payloads + index_of_payload;
 
 		if (!dce_i2c_hw_engine_submit_payload(
-				dce_i2c_hw, payload, mot)) {
+				dce_i2c_hw, payload, mot, cmd->speed)) {
 			result = false;
 			break;
 		}
 
-
-
 		++index_of_payload;
 	}
 
@@ -640,9 +628,6 @@ void dce100_i2c_hw_construct(
 	const struct dce_i2c_shift *shifts,
 	const struct dce_i2c_mask *masks)
 {
-
-	uint32_t xtal_ref_div = 0;
-
 	dce_i2c_hw_construct(dce_i2c_hw,
 			ctx,
 			engine_id,
@@ -650,21 +635,6 @@ void dce100_i2c_hw_construct(
 			shifts,
 			masks);
 	dce_i2c_hw->buffer_size = I2C_HW_BUFFER_SIZE_DCE100;
-
-	REG_GET(MICROSECOND_TIME_BASE_DIV, XTAL_REF_DIV, &xtal_ref_div);
-
-	if (xtal_ref_div == 0)
-		xtal_ref_div = 2;
-
-	/*Calculating Reference Clock by divding original frequency by
-	 * XTAL_REF_DIV.
-	 * At upper level, uint32_t reference_frequency =
-	 *  dal_dce_i2c_get_reference_clock(as) >> 1
-	 *  which already divided by 2. So we need x2 to get original
-	 *  reference clock from ppll_info
-	 */
-	dce_i2c_hw->reference_frequency =
-		(dce_i2c_hw->reference_frequency * 2) / xtal_ref_div;
 }
 
 void dce112_i2c_hw_construct(
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
