Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2040FC35247
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 21:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E865D21775
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 21:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NNN9Q3XM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E865D21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 199956FB5B;
	Thu,  6 Feb 2020 21:14:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 903256FB5D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 21:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBkNtKy91wPK0FTJdwptgH7GnXOGn7JbTrSM9DVu9eaQ7l/L7DWgfVyqfK3gt6tj1YCsiDZqQBPdNwhG7R7MG/t38DFjBwVNBw7/Drvktg8Y9QXZLQe47v+3mNn/aQECj19/OadkXk/OGTCaPP3ehIf17H843RR5L8dbe6VR7Kq8k7Ped5AmR5ruBixCY6LOW+ZaD1YVh/83xQ1YxFwxUfohg5K/BY9vscx2nULmx70dXsR5RtTGpp1GaR8q8mpVqsibT0CSsJqaHAh7sVDoaKVU1LUYUwu0XFRDYv2ATN3GdUBlWJKii3YDqr34vA2wMLGGUicFYh3WR7CT4KNC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwFPE5Nn1tZycEkIJ20jrh0cMl9hYfrJPyNBgfDXd4w=;
 b=jc7IZsDXZdsBrH+4Pf4ZLvcfABtgGRjz/gGMcVJmuRcAe67gNRHxiNcgkpoz+H++d5km9rDTRI5q1nqeZhe86KykLK9SrPsHuFg8IO8DP5RH2vCdBapuOckp/rkmgDuChbKC0IMOcdj/2FYCTJVkmAkbbPiRQtdTHR0CALyhGqGqzgsCwts0ynA61zW/MJ5DWML8RyoXpBupJhTuIK3uIt1luqM4V1+p0SWrhthADUDaGwh/XwFZNVPjOTLKxPEgJoMhVDGdkqYVuAGnhZEIFVcKejY+fRCidmxXXld3rcmvZANn4hNmiL+f51k3GaEORVUjUS5cLOXx4bGHTahOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwFPE5Nn1tZycEkIJ20jrh0cMl9hYfrJPyNBgfDXd4w=;
 b=NNN9Q3XMpZgDpA/taOiQRUD84Prevejp8rJmIoW45cytFXxCMKs5y5ffC2OlZlJ1MIsZaZeHe7e6/8xM1VBLaI6Y2yyr6TjsJmAYU6zcFDuhwCpZZygIVfCVNyF3pqx3B+q9NedZeME83gYtRwhByXKrnUbyfPW2iDKr7Iije8A=
Received: from DM3PR12CA0057.namprd12.prod.outlook.com (2603:10b6:0:56::25) by
 BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 21:14:39 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by DM3PR12CA0057.outlook.office365.com
 (2603:10b6:0:56::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Thu, 6 Feb 2020 21:14:39 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 21:14:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Feb 2020
 15:14:38 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Feb 2020
 15:14:37 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 6 Feb 2020 15:14:37 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amd/display: no hdcp retry if bksv or ksv list is
 revoked
Date: Thu, 6 Feb 2020 16:14:22 -0500
Message-ID: <20200206211425.20394-3-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206211425.20394-1-Bhawanpreet.Lakha@amd.com>
References: <20200206211425.20394-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(428003)(189003)(199004)(478600001)(5660300002)(426003)(7696005)(336012)(86362001)(6666004)(6916009)(186003)(36756003)(26005)(356004)(2616005)(70586007)(70206006)(54906003)(4326008)(2906002)(81156014)(81166006)(316002)(8936002)(8676002)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB2900; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3576ba33-bcf0-4469-f1ac-08d7ab499367
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2900FA18E304AD6FA35E2369F91D0@BN8PR12MB2900.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tb1xctLyXHSF+O0pXomdf7o8JSXbw1TAltyWFyJPRpmKjlkbs0SV0aFC8dmbwu9ijU69OPrIxs4MYYucGmeipDkDmEFMqlr6O7lOBTGvOoC8T10NVY+gwoy4yJ9npKi7e5MA/EFlnySQy0lvCFvWQSKaYu1LHCVUJ58dJQhctGqdXYnKl8hnl/r6ZUI1GsS/fthgfRKjvG+/eyfqEsWGiQXeWYSNqiuJmDwpovEQm+NKF+uyKAXbz+/wZUURGcQePI81gmvnvF9MmOsykQ2aUy1i/cIACdWioUO9gUJ748VIv+D0JAFmSn4BX2SmJL+z0NgFwLKIbW9zSYl1jyC5/P7PCJBCivizJq+v/K6/fcxCvbxTZq8DANsXJkS9YOqLE/gHMoUS7HRYrsZ1+YtrHCvq70QsqdArT62PzE9HYmPD/jf7b47OmF2tiu2agyRQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 21:14:38.8621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3576ba33-bcf0-4469-f1ac-08d7ab499367
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2900
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
Cc: Wenjing Liu <Wenjing.Liu@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <Wenjing.Liu@amd.com>

[why]
According to the specs when bksv or ksv list fails SRM check,
HDCP TX should abort hdcp immediately.
However with the current code HDCP will be reattampt upto 4 times.

[how]
Add the logic that stop HDCP retry if bksv or ksv list
is revoked.

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c             | 3 ++-
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h             | 1 +
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c | 6 ++++--
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c         | 4 ++++
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h          | 2 ++
 5 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index 8aa528e874c4..a7d24734c7cd 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -61,7 +61,8 @@ static uint8_t is_cp_desired_hdcp1(struct mod_hdcp *hdcp)
 
 	return (hdcp->connection.hdcp1_retry_count < MAX_NUM_OF_ATTEMPTS) &&
 			is_auth_needed &&
-			!hdcp->connection.link.adjust.hdcp1.disable;
+			!hdcp->connection.link.adjust.hdcp1.disable &&
+			!hdcp->connection.is_hdcp1_revoked;
 }
 
 static uint8_t is_cp_desired_hdcp2(struct mod_hdcp *hdcp)
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index af78e4f1be68..4d717ec8f14b 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -170,6 +170,7 @@ struct mod_hdcp_connection {
 	struct mod_hdcp_display displays[MAX_NUM_OF_DISPLAYS];
 	uint8_t is_repeater;
 	uint8_t is_km_stored;
+	uint8_t is_hdcp1_revoked;
 	uint8_t is_hdcp2_revoked;
 	struct mod_hdcp_trace trace;
 	uint8_t hdcp1_retry_count;
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
index 76edcbe51f71..d66a9f954ade 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
@@ -210,7 +210,8 @@ enum mod_hdcp_status mod_hdcp_hdcp1_dp_transition(struct mod_hdcp *hdcp,
 			fail_and_restart_in_ms(0, &status, output);
 			break;
 		} else if (input->rx_validation != PASS) {
-			if (hdcp->state.stay_count < 2) {
+			if (hdcp->state.stay_count < 2 &&
+					!hdcp->connection.is_hdcp1_revoked) {
 				/* allow 2 additional retries */
 				callback_in_ms(0, output);
 				increment_stay_counter(hdcp);
@@ -290,7 +291,8 @@ enum mod_hdcp_status mod_hdcp_hdcp1_dp_transition(struct mod_hdcp *hdcp,
 			fail_and_restart_in_ms(0, &status, output);
 			break;
 		} else if (input->ksvlist_vp_validation != PASS) {
-			if (hdcp->state.stay_count < 2) {
+			if (hdcp->state.stay_count < 2 &&
+					!hdcp->connection.is_hdcp1_revoked) {
 				/* allow 2 additional retries */
 				callback_in_ms(0, output);
 				increment_stay_counter(hdcp);
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
index 724ebcee9a19..44956f9ba178 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
@@ -90,10 +90,14 @@ char *mod_hdcp_status_to_str(int32_t status)
 		return "MOD_HDCP_STATUS_HDCP1_R0_PRIME_PENDING";
 	case MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILURE:
 		return "MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILURE";
+	case MOD_HDCP_STATUS_HDCP1_BKSV_REVOKED:
+		return "MOD_HDCP_STATUS_HDCP1_BKSV_REVOKED";
 	case MOD_HDCP_STATUS_HDCP1_KSV_LIST_NOT_READY:
 		return "MOD_HDCP_STATUS_HDCP1_KSV_LIST_NOT_READY";
 	case MOD_HDCP_STATUS_HDCP1_VALIDATE_KSV_LIST_FAILURE:
 		return "MOD_HDCP_STATUS_HDCP1_VALIDATE_KSV_LIST_FAILURE";
+	case MOD_HDCP_STATUS_HDCP1_KSV_LIST_REVOKED:
+		return "MOD_HDCP_STATUS_HDCP1_KSV_LIST_REVOKED";
 	case MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION:
 		return "MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION";
 	case MOD_HDCP_STATUS_HDCP1_ENABLE_STREAM_ENCRYPTION_FAILURE:
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index f2a0e1a064da..891bca555e17 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -56,8 +56,10 @@ enum mod_hdcp_status {
 	MOD_HDCP_STATUS_HDCP1_NOT_CAPABLE,
 	MOD_HDCP_STATUS_HDCP1_R0_PRIME_PENDING,
 	MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILURE,
+	MOD_HDCP_STATUS_HDCP1_BKSV_REVOKED,
 	MOD_HDCP_STATUS_HDCP1_KSV_LIST_NOT_READY,
 	MOD_HDCP_STATUS_HDCP1_VALIDATE_KSV_LIST_FAILURE,
+	MOD_HDCP_STATUS_HDCP1_KSV_LIST_REVOKED,
 	MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION,
 	MOD_HDCP_STATUS_HDCP1_ENABLE_STREAM_ENCRYPTION_FAILURE,
 	MOD_HDCP_STATUS_HDCP1_MAX_CASCADE_EXCEEDED_FAILURE,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
