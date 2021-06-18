Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC24C48BE8
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 17:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC98613BA
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 17:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC98613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D2C6EA4D;
	Fri, 18 Jun 2021 17:35:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C4066EA4D
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 17:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obPq8XGQZcYTbWlJcOAfz5Mu+LSnEFrQBzWoLRTwBSEEo3XqYhEcOWYnVq7L0WKdkEWguy5qjYyqs/fVmhKRBYwSqWJv6yD1WiY/SUBighJ6knIKbz7GbHqnjZLoZX7d5R0n/QeYEvyeiIqKwhJFd863Pzpg3BWVTBY5RZXNBnv6ZC+nAHEh0Fu5ot9o4PnRm7g1UknJ0j/0CLPK3EtuWgKPeEoGqKErfAmytiQeSJ8ZYwwfimOQtCgT2kuQEHwnLQPU+KR83om8SizNBlF8Cmu67mdjcLaiqM2AiKsLBIQfOCXL4oAR99lmUwZU1IggIjMAPmSnypDSnTeDu2hFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFX6Sr8LOt3A67/lmVI5F3l69aq/JyEmk5QKKyKS8kw=;
 b=FXPKRq+d0lVP3biif4rF2sirk6QA1g7Z/dMEGHdSCC8dquY1dLL3TEWG/sBJA4tRssW2b49lci1hnEXywnvrqnHYndQhB9Wxo7c7jYlBz8IG5osHBGhr+4DmdvlheS9x5sduToBi4twmNgAz46+G2cxlJO++HaRVPsjMGWghmmmpICVenqi//YfSVw8jGx6fDn64KuZpdDJXONxT9UxHtPb8xTejpdpZL5gImVZ8+X2r6C2lPd63Syee3tGL5yT4OyBgf4NXY2J7YHcgcX+OgfMXDYrBCtdmdjRTGjoiDMzTXUWFcvMAu+NUyCeq5HbNvXfYwQXDKOW5pf1+mQYlLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFX6Sr8LOt3A67/lmVI5F3l69aq/JyEmk5QKKyKS8kw=;
 b=nhqXqyixsj+0g60jpVPOQlAYXXISPFLygX8VHz+DuVc8Sygb23grNbrlqem5orxO2fqGTNbdE23vEWzIpzt0k1FlccbDf6L/XBntyUbhL7IOtYOhWI2r5711/nOR+NNr1FK2lwu+3H0/lJkeZ38GlKZQd3oMK5GlAyI0bYB5dyU=
Received: from MWHPR11CA0047.namprd11.prod.outlook.com (2603:10b6:300:115::33)
 by CH2PR12MB3734.namprd12.prod.outlook.com (2603:10b6:610:2a::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 18 Jun
 2021 17:35:43 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::ce) by MWHPR11CA0047.outlook.office365.com
 (2603:10b6:300:115::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Fri, 18 Jun 2021 17:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 17:35:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 12:35:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 12:35:40 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 18 Jun 2021 12:35:39 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/12] drm/amd/display: get refclk from
 MICROSECOND_TIME_BASE_DIV HW register
Date: Fri, 18 Jun 2021 13:35:09 -0400
Message-ID: <20210618173514.430647-8-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618173514.430647-1-bindu.r@amd.com>
References: <20210618173514.430647-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 246e4403-1c33-42e9-e861-08d9327f7f6f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3734:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3734966FB568A5F9D080307EF50D9@CH2PR12MB3734.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:246;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /yiVZPYuW94AwrAYwqRliA5PwbR7Dhp0SKfwQPOEHHTd2LORO1Dm2dojMf5TevE9D7ElmZeK3y+HoDeQNlavhAwORB5ZXYMqZbUtKwtVqSC/wBzo9XWJnnj7IElrACQSRFS2gYFyat/bFvx2N7XQ/g7K8pZxNMBSvPZLhdFNRo6T5DwxICAjk2g6O92nMO0eZTdqp8kZmQHP3GL84TycOliUFv8rvX8FiVB+BbAnraXbEaqNPt/jFuVRB3kEJ6DUvxijW0w3ZKQGQYlqttF5DAgA8GBOcnAijC2NFDS1Lamv6AoE9elY1p/A/TEURwEbwkTse9HMOyx9FUg+stN/LmGai0ohYV5KginK6n6Fe9zVO8gfgKvHo/IgTRq4lh920uA/r7v6Yejx7OfhSlVDbcG2tU500OdtvrEk2PcTL/99F5mewEHHzYa82Dnp3yycvMwJMTMOsf5voGW8WODq2L0E7BJUrKEBE8UuKA2BvcOX0kFVprXHEOSyphkHeEZpoNox1F1Fze+ikQ3FruXw/b+jIjZiHUy196wF6AQnEw2kkshFZWDb0a+hY7HsGtVeiWAByYqD+v2arxk9udRTTe8w7QR9Ld2O0ufgpOMjH9MKDjUIOnW/lrWpD8c/Vfg8WyUmrajaGhgUM4F+g/+HQvHcml/aD1uMuRpFqZgS1TunrvoIWJKETe92S3Huortd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(36840700001)(46966006)(2906002)(2616005)(336012)(426003)(86362001)(36756003)(356005)(81166007)(4326008)(36860700001)(47076005)(83380400001)(82740400003)(82310400003)(6916009)(5660300002)(54906003)(186003)(70586007)(7696005)(478600001)(316002)(1076003)(70206006)(8936002)(8676002)(26005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 17:35:42.8362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 246e4403-1c33-42e9-e861-08d9327f7f6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3734
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Chris Park <Chris.Park@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
recent VBIOS dce_infotable reference clock change caused a I2c regression.
instead of relying on vbios, let's get it from HW directly.

Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c | 13 ++++++++++---
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h |  3 +++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
index a524f471e0d7..6d1b01c267b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
@@ -264,18 +264,25 @@ static void set_speed(
 	struct dce_i2c_hw *dce_i2c_hw,
 	uint32_t speed)
 {
-	uint32_t xtal_ref_div = 0;
+	uint32_t xtal_ref_div = 0, ref_base_div = 0;
 	uint32_t prescale = 0;
+	uint32_t i2c_ref_clock = 0;
 
 	if (speed == 0)
 		return;
 
-	REG_GET(MICROSECOND_TIME_BASE_DIV, XTAL_REF_DIV, &xtal_ref_div);
+	REG_GET_2(MICROSECOND_TIME_BASE_DIV, MICROSECOND_TIME_BASE_DIV, &ref_base_div,
+		XTAL_REF_DIV, &xtal_ref_div);
 
 	if (xtal_ref_div == 0)
 		xtal_ref_div = 2;
 
-	prescale = ((dce_i2c_hw->reference_frequency * 2) / xtal_ref_div) / speed;
+	if (ref_base_div == 0)
+		i2c_ref_clock = (dce_i2c_hw->reference_frequency * 2);
+	else
+		i2c_ref_clock = ref_base_div * 1000;
+
+	prescale = (i2c_ref_clock / xtal_ref_div) / speed;
 
 	if (dce_i2c_hw->masks->DC_I2C_DDC1_START_STOP_TIMING_CNTL)
 		REG_UPDATE_N(SPEED, 3,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h
index 2309f2bb162c..3f45ecd189a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h
@@ -139,6 +139,7 @@ enum {
 	I2C_SF(DC_I2C_DATA, DC_I2C_INDEX, mask_sh),\
 	I2C_SF(DC_I2C_DATA, DC_I2C_INDEX_WRITE, mask_sh),\
 	I2C_SF(MICROSECOND_TIME_BASE_DIV, XTAL_REF_DIV, mask_sh),\
+	I2C_SF(MICROSECOND_TIME_BASE_DIV, MICROSECOND_TIME_BASE_DIV, mask_sh),\
 	I2C_SF(DC_I2C_ARBITRATION, DC_I2C_REG_RW_CNTL_STATUS, mask_sh)
 
 #define I2C_COMMON_MASK_SH_LIST_DCE110(mask_sh)\
@@ -182,6 +183,7 @@ struct dce_i2c_shift {
 	uint8_t DC_I2C_INDEX;
 	uint8_t DC_I2C_INDEX_WRITE;
 	uint8_t XTAL_REF_DIV;
+	uint8_t MICROSECOND_TIME_BASE_DIV;
 	uint8_t DC_I2C_DDC1_SEND_RESET_LENGTH;
 	uint8_t DC_I2C_REG_RW_CNTL_STATUS;
 	uint8_t I2C_LIGHT_SLEEP_FORCE;
@@ -225,6 +227,7 @@ struct dce_i2c_mask {
 	uint32_t DC_I2C_INDEX;
 	uint32_t DC_I2C_INDEX_WRITE;
 	uint32_t XTAL_REF_DIV;
+	uint32_t MICROSECOND_TIME_BASE_DIV;
 	uint32_t DC_I2C_DDC1_SEND_RESET_LENGTH;
 	uint32_t DC_I2C_REG_RW_CNTL_STATUS;
 	uint32_t I2C_LIGHT_SLEEP_FORCE;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
