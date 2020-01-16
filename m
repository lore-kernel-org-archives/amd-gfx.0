Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B961CC33CB6
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC84206D9
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fE0Va0QO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC84206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D376E287;
	Thu, 16 Jan 2020 20:14:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF8746E47E
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqihK2kJ7zcAbJ69FmNveUMR/IJciRZahD1r/40+3zqfWa6yJxBepQWwlQdLQ0Rj3YU0jBa/CfQzz2ybV0d35nHNev0rZyXzuPniDoUs5lqoBveJPBA0QjA7yMKGqm2dj6RE+sVPoBXel/Tr9a8HlQiWKNIIsoqUWKhGigrVyi9ALH23nFEeWEq1JByp7P3Bf8Ps5TN/VC68pwW+85dBPUMOBujndN0nw2ekK28fP8BKDyO/MySovADWymYIAcjqCVQHS91oMfkZiEXd3bgo2zcK5dJ90BA4sgshgwOHo/CF9AO2kkeZQQWEhmFBf2WuPP1SxoUhbpmN1gOR76tzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Uq+Kvim+nmVUTMMPSlHXqqSrpw63hoG+o1CVCijPWU=;
 b=Pvz3IF9QUcjRS2+MGMu2+kbJ5OMPNTcPGVARmzrYe2lPkq0h/HU0BtO4K78KrAtY5VpCAuBkK+tdFBU1TfQiZHpZD8xlThYY7qL3Mw+i3FyJ6GFfw5yoOKfknWPimSw3JcGDJsfbd0To1d4ma61zYQqURxlxWYhJD/peoOKsgmzZJS/ShRLWklXYG6kbRfMF5Ym5f8PHJGhk+sHFjl96VP5kLOjI/kV6eES6vsNzs90BheKLBO5RLmoBhGtU3/McKjiSoGIh1qX+TDK00RwJ39U7Ql/vWzdPxuZk+R1IifTbYK0aFQ40/u+75i38JTZr+jtuLXIK/a++wyVCW1iI2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Uq+Kvim+nmVUTMMPSlHXqqSrpw63hoG+o1CVCijPWU=;
 b=fE0Va0QObGD9EmBElh8d8SSHFefgXPxYZ3Z/jYrkkl5l3Ah4d4+SzkNFxUxorqEoPIyOIkP/H9Ha5hIy5J4mz6Pc6M1MbcJ1tF8TAE+yk9ggmQWC9oVk3frCmV8VTmJrxb8fC17kHgOSlvss2j5I6dcd8eToIuMGAQB2eziTnhA=
Received: from MWHPR1201CA0016.namprd12.prod.outlook.com
 (2603:10b6:301:4a::26) by BY5PR12MB3684.namprd12.prod.outlook.com
 (2603:10b6:a03:1a2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13; Thu, 16 Jan
 2020 20:14:34 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::208) by MWHPR1201CA0016.outlook.office365.com
 (2603:10b6:301:4a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:34 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:33 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:32 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:32 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/22] drm/amd/display: init hw i2c speed
Date: Thu, 16 Jan 2020 15:14:17 -0500
Message-ID: <20200116201418.2254-22-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(136003)(428003)(199004)(189003)(336012)(8676002)(81166006)(186003)(478600001)(70586007)(81156014)(70206006)(2906002)(7696005)(4326008)(6916009)(8936002)(316002)(26005)(6666004)(1076003)(2616005)(86362001)(54906003)(36756003)(356004)(5660300002)(426003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3684; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5d11189-2f2d-4171-5d1d-08d79ac0b40a
X-MS-TrafficTypeDiagnostic: BY5PR12MB3684:
X-Microsoft-Antispam-PRVS: <BY5PR12MB368439BB8C2A4F08638F1BD9F9360@BY5PR12MB3684.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1jH+/+uWaYQ0zjCHU36O6jh60Ti/Jb9UE9x2dwwjtbfwMmnq5DWEYNAY86zI9s68t9Rdi0NGx3IZupg3OmpIeHc0Gv+ogZcRY3Em1SHK9ZVYhuJWwGJuwgRRt7yVi48XpIcWYJ6ULOb3LiVVyuiGdvKzZU0XGqurmkREEwAMCqyyqGOvIwf884Py0Cb4SNYMXqxoizo3WUyopoLVAnVL+xVxPry1N5ILgyG3WdMwhReywCGyFMj75vKa5SEy9jzLchzG/L82GAa5xy+PqdOsE6RhU5lKMruiDy108/6Fj/z2+wk80XIndk9qfVHO4GAKxtiFJzWY3sT0XGsx4H9kD6JjDFUTmMFPu4g+lBg1uWalIYlhbutKwLuYSTFZJUo1kk2I/ceA/srQrYm7r1SbPhbmLv3ekthad7PnXYiqvTCefYNQg0MfF2ek/cvybST1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:33.9569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d11189-2f2d-4171-5d1d-08d79ac0b40a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3684
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
Driver didn't init hw i2c speed cause hdcp hw cannot
send command, because the default value of speed register
is 0x2.

[How]
Restore the default speed when release i2c engine

Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c | 9 +--------
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h | 1 -
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
index 49d490214060..066188ba7949 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
@@ -339,7 +339,7 @@ static void release_engine(
 	bool safe_to_reset;
 
 	/* Restore original HW engine speed */
-	REG_WRITE(SPEED, dce_i2c_hw->original_speed);
+	set_speed(dce_i2c_hw, dce_i2c_hw->default_speed);
 
 	/* Reset HW engine */
 	{
@@ -371,7 +371,6 @@ struct dce_i2c_hw *acquire_i2c_hw_engine(
 {
 	uint32_t counter = 0;
 	enum gpio_result result;
-	uint32_t current_speed;
 	struct dce_i2c_hw *dce_i2c_hw = NULL;
 
 	if (!ddc)
@@ -409,11 +408,6 @@ struct dce_i2c_hw *acquire_i2c_hw_engine(
 
 	dce_i2c_hw->ddc = ddc;
 
-	current_speed = REG_READ(SPEED);
-
-	if (current_speed)
-		dce_i2c_hw->original_speed = current_speed;
-
 	if (!setup_engine(dce_i2c_hw)) {
 		release_engine(dce_i2c_hw);
 		return NULL;
@@ -613,7 +607,6 @@ void dce_i2c_hw_construct(
 	dce_i2c_hw->buffer_used_bytes = 0;
 	dce_i2c_hw->transaction_count = 0;
 	dce_i2c_hw->engine_keep_power_up_count = 1;
-	dce_i2c_hw->original_speed = DEFAULT_I2C_HW_SPEED;
 	dce_i2c_hw->default_speed = DEFAULT_I2C_HW_SPEED;
 	dce_i2c_hw->send_reset_length = 0;
 	dce_i2c_hw->setup_limit = I2C_SETUP_TIME_LIMIT_DCE;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h
index d4b2037f7d74..fb055e6883c0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h
@@ -256,7 +256,6 @@ struct i2c_request_transaction_data {
 
 struct dce_i2c_hw {
 	struct ddc *ddc;
-	uint32_t original_speed;
 	uint32_t engine_keep_power_up_count;
 	uint32_t transaction_count;
 	uint32_t buffer_used_bytes;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
