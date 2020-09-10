Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB01C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058D521D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZjUW3kJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058D521D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E4296E946;
	Thu, 10 Sep 2020 13:47:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E82FB6E941
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoPNobnthQUAEo04u3w42VFKje1di88CR4RKHzVoxfBPFNWH6Zv7DwAQbnSumgQE0qCZ3/BY0vCLu73D8lckIr60gYjW5QXKoTtkZAe1WV1WSuXJef2BahxGwmVhl8NtGn4jXT3YuU8OonE0+EOlsrHW8yULZ75c8OcAwUl3BqCz5THKAB0xI42rGPubAIF53bvGhc5Sx59em3C7xd7qoMUx4mXNQe+DGi4ikj8Hi/+gDIx6Swhv/j8zp6WpmUk60UR8KrdTHzLcXT+pGguc4C6g5SmFiw9l+w5Y0gJNHAoOAd1WiL7J/4SWxvY13Ekk+k6uVacnQQPVCqCfHIY1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPXFXFrOZMrG1lD0hHn73ot7WVMjZWi94uGLiJU/2bE=;
 b=DinbQRfEzty+p1R3dKN6qw/aZzdiigjG2tKYFEGV7A9wroWKi0uTPfFirWXceZ/i0QGaNQlQvaN5kOIEOAGe6HjjfK+UFdQoT7jc5LT8IOVTzOKBjLau/dN8SYL6wYrsIzE7TbVmPY4vpWOW3Kqfhpab5Em6aYSKFGY9PIJn7Ba6fShbSJyzLhNj1JYAvNZGOqV3alhpuKF+kXHv9El39hL6wkfZg+IVlngX2dnrxtseOf8zn/FJ3NgRZolZ2H2zwN2Uis+5JZTOGorBk4bRYDLEAg3wJlCl0sJiZZLM5bksnl/+qJI8v5+aYXMXZzYZJ/MMgsJslaF2zO8e2PZAvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPXFXFrOZMrG1lD0hHn73ot7WVMjZWi94uGLiJU/2bE=;
 b=ZjUW3kJuWXRvaOqsM8T1spEVDbDnGHHlG0hh00pPKYAkG/X+ZA49uB1ENVS/4GpxHvFI6W/hWGfLuMFKQP9rOdHSqk2eq6mPlc4FYbxH0i00LNNgLwPbQwNhH/2v6KDuGj8gZkkOFQkv1AW7QY0jbDJz7Rt4vIwr09/+SMvjuB4=
Received: from BN8PR07CA0008.namprd07.prod.outlook.com (2603:10b6:408:ac::21)
 by BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Thu, 10 Sep
 2020 13:47:34 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::a8) by BN8PR07CA0008.outlook.office365.com
 (2603:10b6:408:ac::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:33 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:33 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:33 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/42] drm/amd/display: Fix CP_IRQ clear bit and logic
Date: Thu, 10 Sep 2020 09:46:55 -0400
Message-ID: <20200910134723.27410-15-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 045410e5-0782-4c69-e00d-08d855901230
X-MS-TrafficTypeDiagnostic: BYAPR12MB3560:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3560DD5F8A4EE899F83479668B270@BYAPR12MB3560.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2In6dTEzBIHNreAqAIHZAU4K/u4Czj2ZmmE6T8tIpnU5xcOR4949RVvosDZxR3mTYhsrXXmx0RXIm0NXxrbIAt0f2Tfgn1ifUlvmU39L8gn6QjbHFL0RE0AffkhCZ5aPjKsUiWsAcoR8WD8oX3xkyNeQlOG2WZva59sCzA2fUGwTVaMBmSYMp+ezcxrHJ1IJvK8INlWnthZ6/1FA27/r5zjVz58KIeQE6Rqw6rq/v6gfnNFrhIqIu4W+0CneqKqLiaT7aJunj122VGbWCqcmfd+iXdT4Zlkkpj734yQodmiuV7dhc4w9fADQEfvBPGsvSsKDRQLWBRLyKgO1nMdmosn4l2Q/DXQ3eimFaoTks/vHOsW55Vm8teuDYZvTyGD7h03dIHD5uecj7OBQMeOqUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966005)(356005)(44832011)(81166007)(26005)(83380400001)(8936002)(7696005)(70206006)(8676002)(86362001)(336012)(2906002)(70586007)(47076004)(82740400003)(186003)(6916009)(36756003)(316002)(82310400003)(5660300002)(478600001)(6666004)(4326008)(2616005)(1076003)(54906003)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:34.1339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 045410e5-0782-4c69-e00d-08d855901230
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3560
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Harmanprit Tatla <harmanprit.tatla@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harmanprit Tatla <harmanprit.tatla@amd.com>

[Why]
Currently clearing the wrong bit for CP_IRQ, and logic on when to
clear needs to be fixed.

[How]
Corrected bit to clear and improved logic for decision to clear.

Signed-off-by: Harmanprit Tatla <harmanprit.tatla@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c  |  3 +--
 .../gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c  | 16 +++++++---------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index a82975970e87..20e554e771d1 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -472,8 +472,7 @@ enum mod_hdcp_status mod_hdcp_process_event(struct mod_hdcp *hdcp,
 	}
 
 	/* Clear CP_IRQ status if needed */
-	if (event_ctx.event == MOD_HDCP_EVENT_CPIRQ &&
-			event_ctx.unexpected_event == 0) {
+	if (event_ctx.event == MOD_HDCP_EVENT_CPIRQ) {
 		status = mod_hdcp_clear_cp_irq_status(hdcp);
 		if (status != MOD_HDCP_STATUS_SUCCESS)
 			push_error_status(hdcp, status);
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
index 9dd8c854fd81..f7b5583ee609 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
@@ -30,6 +30,8 @@
 #define KSV_READ_SIZE 0xf	/* 0x6803b - 0x6802c */
 #define HDCP_MAX_AUX_TRANSACTION_SIZE 16
 
+#define DP_CP_IRQ (1 << 2)
+
 enum mod_hdcp_ddc_message_id {
 	MOD_HDCP_MESSAGE_ID_INVALID = -1,
 
@@ -648,18 +650,14 @@ enum mod_hdcp_status mod_hdcp_write_content_type(struct mod_hdcp *hdcp)
 
 enum mod_hdcp_status mod_hdcp_clear_cp_irq_status(struct mod_hdcp *hdcp)
 {
-	uint8_t clear_cp_irq_bit = 2;
+	uint8_t clear_cp_irq_bit = DP_CP_IRQ;
 	uint32_t size = 1;
 
 	if (is_dp_hdcp(hdcp)) {
-		if (hdcp->connection.link.dp.rev >= 0x14)
-			return hdcp->config.ddc.funcs.write_dpcd(hdcp->config.ddc.handle,
-					DP_DEVICE_SERVICE_IRQ_VECTOR_ESI0, &clear_cp_irq_bit, size)
-					? MOD_HDCP_STATUS_SUCCESS : MOD_HDCP_STATUS_DDC_FAILURE;
-		else
-			return hdcp->config.ddc.funcs.write_dpcd(hdcp->config.ddc.handle,
-					DP_DEVICE_SERVICE_IRQ_VECTOR, &clear_cp_irq_bit, size)
-					? MOD_HDCP_STATUS_SUCCESS : MOD_HDCP_STATUS_DDC_FAILURE;
+		uint32_t cp_irq_addrs = (hdcp->connection.link.dp.rev >= 0x14)
+				? DP_DEVICE_SERVICE_IRQ_VECTOR_ESI0:DP_DEVICE_SERVICE_IRQ_VECTOR;
+		return hdcp->config.ddc.funcs.write_dpcd(hdcp->config.ddc.handle, cp_irq_addrs,
+				&clear_cp_irq_bit, size) ? MOD_HDCP_STATUS_SUCCESS : MOD_HDCP_STATUS_DDC_FAILURE;
 	}
 
 	return MOD_HDCP_STATUS_INVALID_OPERATION;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
