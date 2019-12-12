Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80ADC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 17:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8D421655
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 17:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1ufg9uca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8D421655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 530816E15F;
	Thu, 12 Dec 2019 17:06:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B0546E0FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 17:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gl0mgCZpl9+NoCpy5oSIPjtklKx9tebZQ5j4FVVcWjOLuWd6w+OeaflRpFAYiwTk21JlD4Ml5+JNl5TDmCIAJnAdVPulF8iBYBe3p8NdBD+HkISgVvGPSKz50ODwjpfDE7TiZd7E+GF0tr4KzqtqTdaacBBPSVAwVEWAGK9CIidWNVvQOwVtpwxQ2dYabE1gwp1vbfeG30VHV+X2+ukCOO0m4/h0VMpa2iVmu0oC7ZqzxJnskJJPzPVwKTbKProeWeaYw3KlY7YCIkD2WT4XjhEtGpiYSeVt4DNnZkUAW4jB4WNNZtTjdif1XK4mpkUQv867wiXWVtAEPJC7q6gpgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZviAcqcUPauebbRRuq2E9M9602y1VV4mwosGhRLJYU=;
 b=FTbb0kiVVCrvEMtgzEeOeU46w+EqX1hqlXab/jIR4AkVsabsOemFWBwD33MJTs9jRFv+w4pwbCd7Dviwvg/w9d1q+E28qaImSiqQkFZIvd5a5YRgYYoy3yP0H7HMaaGNaqAWUHcaVtbbgaRXzq0SVeP8lsE1C4KokvA+u0Tltiys9HDSxIfNbFkkkqL3HcfGE8dcGA6ODzgEkiet8QpKrpn7cBIsP3oZdEy6n59E5U3soYFp6rL7BwnY+O/ZtuQOEWbrDNhcSxRQuhh11qcHJXSPkCIg508u2VB0A40B/C+2c2e82Qxzq1XRrqmBsr5itiDRzkK4V4feXy/obSe+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZviAcqcUPauebbRRuq2E9M9602y1VV4mwosGhRLJYU=;
 b=1ufg9ucaKfHh4Fk8S9LM2BCGWjCp9z6XwfYNqU855yQeQfYz5bnXrRsH8innI2yaJdjh08wSnGpUo9d7cDIC0xdLt4WMcf+Km4BKUeXjlmVU3mjBKmvjjroq3KEqmEf/a6XTBsStqRBUDS+5X5rcS96xEo2iPZD6kLD9nNlAQqQ=
Received: from BN4PR12CA0013.namprd12.prod.outlook.com (2603:10b6:403:2::23)
 by BN6PR12MB1875.namprd12.prod.outlook.com (2603:10b6:404:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16; Thu, 12 Dec
 2019 17:06:27 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::208) by BN4PR12CA0013.outlook.office365.com
 (2603:10b6:403:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.17 via Frontend
 Transport; Thu, 12 Dec 2019 17:06:27 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Thu, 12 Dec 2019 17:06:27 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 12 Dec
 2019 11:06:23 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 12 Dec 2019 11:06:23 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] drm/amd/display: Add delay after h' watchdog timeout event
Date: Thu, 12 Dec 2019 12:06:13 -0500
Message-ID: <20191212170614.24837-6-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212170614.24837-1-Bhawanpreet.Lakha@amd.com>
References: <20191212170614.24837-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39850400004)(346002)(376002)(136003)(428003)(189003)(199004)(2616005)(8936002)(186003)(36756003)(336012)(478600001)(5660300002)(1076003)(4326008)(81166006)(81156014)(86362001)(8676002)(26005)(70586007)(70206006)(6916009)(316002)(426003)(2906002)(6666004)(356004)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1875; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8edcc36-5e0c-4567-f951-08d77f25a009
X-MS-TrafficTypeDiagnostic: BN6PR12MB1875:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1875579504913AA341A967A1F9550@BN6PR12MB1875.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0249EFCB0B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AwfQ7Wb14Jd17yzNUKGo+vneXMJsS+knF3DA4fHRbfybqbFRLs07ftj1lIYDbwGP70xZa9N/YB6nzl75UGd8qO60LNQRV5ZWHXWKiD+EFry41//V/VO9yB9CjvOdoCe2KPcmh9ybW/RTa9sVKL36aZ7vSKdkIHqQ0/Hq+xjw8x3q6TdM60JLCOReGM6yB3fhQcAMrU/lcfxGUMwK2uB3X4XZb5J5QAzckem3SpMPf5Yq1sZeRKoUXoXCeZhZbpAAu2CNhSzsNwbb5IXCFtwTnUhFz/Ef8LwsYOXZBSZHt6b+6LEHTT1fsPkDanrHg7GxP6GpPYzNouRt1PyddxFWIrNpO9KsPze0+ZY2x310Z+VcbYhdUGLA8TITDvI9TUcApygU93WkB+kTcVEt3jDi6Qbr8PoJPjtVZv5/AcNTMm8q9bn9WE4y+shf7RcNcXn4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 17:06:27.0149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8edcc36-5e0c-4567-f951-08d77f25a009
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1875
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
Cc: Michael Strauss <michael.strauss@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Some monitors trigger HDCP2.x timeout after reinitializing (e.g. toggling HDR)
by taking longer than expected to return h' (h prime)
Previously the 200ms watchdog timer retry count would hit
MAX_NUM_OF_ATTEMPTS (4), causing fallback to HDCP1.x

[HOW]
Adding a 1s delay after an h' watchdog timeout provides enough time
for affected monitors to return h' in time without hitting MAX_NUM_OF_ATTEMPTS

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
---
 .../gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c   | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
index e8043c903a84..da190739a969 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
@@ -114,7 +114,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_transition(struct mod_hdcp *hdcp,
 			if (event_ctx->event ==
 					MOD_HDCP_EVENT_WATCHDOG_TIMEOUT) {
 				/* 1A-11-3: consider h' timeout a failure */
-				fail_and_restart_in_ms(0, &status, output);
+				fail_and_restart_in_ms(1000, &status, output);
 			} else {
 				/* continue h' polling */
 				callback_in_ms(100, output);
@@ -166,7 +166,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_transition(struct mod_hdcp *hdcp,
 			if (event_ctx->event ==
 					MOD_HDCP_EVENT_WATCHDOG_TIMEOUT) {
 				/* 1A-11-2: consider h' timeout a failure */
-				fail_and_restart_in_ms(0, &status, output);
+				fail_and_restart_in_ms(1000, &status, output);
 			} else {
 				/* continue h' polling */
 				callback_in_ms(20, output);
@@ -439,7 +439,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_dp_transition(struct mod_hdcp *hdcp,
 			if (event_ctx->event ==
 					MOD_HDCP_EVENT_WATCHDOG_TIMEOUT)
 				/* 1A-10-3: consider h' timeout a failure */
-				fail_and_restart_in_ms(0, &status, output);
+				fail_and_restart_in_ms(1000, &status, output);
 			else
 				increment_stay_counter(hdcp);
 			break;
@@ -484,7 +484,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_dp_transition(struct mod_hdcp *hdcp,
 			if (event_ctx->event ==
 					MOD_HDCP_EVENT_WATCHDOG_TIMEOUT)
 				/* 1A-10-2: consider h' timeout a failure */
-				fail_and_restart_in_ms(0, &status, output);
+				fail_and_restart_in_ms(1000, &status, output);
 			else
 				increment_stay_counter(hdcp);
 			break;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
