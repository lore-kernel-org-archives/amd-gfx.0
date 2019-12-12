Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AE2C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 17:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E3121655
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 17:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jRZX+R7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E3121655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2023F6E121;
	Thu, 12 Dec 2019 17:06:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C67226E121
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 17:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yc2v42bFlBbQpbCeBBH9T/89eli9rJURW2DohnP8CdSNSXWlN1XnxnkcUyYXiq0Bt9kppfRMMXe1kJYzNhXUwTUqueC+WbJJFsyISQ1u75/p7/faB/BOQPpPgH/xiqqFGQkcuSCWz/O8CeSl9wkmLs5QAjLNghr1ccZw47b85/cSEvZc8+Fbdzd02A8hRz/zecB8/HbAI2tLV0aN6xdB4Cq5FR5zTVuF6LKVdRTwbAHi8jDLO4dWmkrzoweqbzfjVws8zqbr87ISfoOHtUUV1+45PN7zTiEKNH4HCgUJQ2y4U/rBuAHm8wkx57+5xs173FJi6UEo/8VnTZPcvdLYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9atCqgRMT9ZwFGTAtHRadXE1vwWQ9tVP++62HNEdp8=;
 b=jkB2gUUt9c3ooWPeuPeaT7OJIaVPKI1Px+yVIHCV34ms1Uy7hd148Ac5/Npd+9XkSh3WPS6AR0KaXJnCmZRw6bcIVMhaVbYiEkHvvfLmbf8mgBi1SgOt87Kif2a4BADqNcbS5Q/LaFvpNoi8Ux6tdJkluj/NqEicGAYl1v5gIv/yFrdYF61B1kuQyIheenGU4Cl1ON0yKQi99uEJCZDzZ5oXmrj84ptUm+QqN5T9KeKvZ4drRjtuHjhEnSbROIPNtKHj/2fxpt17khUCX6UH/Q60NDyj5dnHfZIFdQDdTm6TQbsuYwGvWj9QQNQB2AmWBI6geh5JRE0YhCZd8pRxzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9atCqgRMT9ZwFGTAtHRadXE1vwWQ9tVP++62HNEdp8=;
 b=jRZX+R7YyA5LhtA1gUAB6CBGL3bb/sfPqtNOxVMO80YtarMhmrK6+raVruOaozpKS4Os+T1BzXfMv6Qvg9gINBb6WykRPKz2JWh2UyBq+yeLulhnuwvfH0k9tGMD4MIL6emS0oICHV4uVcEbO8ZV7foBvkUvImp2Q+SVH1rzGnw=
Received: from DM3PR12CA0131.namprd12.prod.outlook.com (2603:10b6:0:51::27) by
 CY4PR1201MB2519.namprd12.prod.outlook.com (2603:10b6:903:d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14; Thu, 12 Dec
 2019 17:06:27 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::205) by DM3PR12CA0131.outlook.office365.com
 (2603:10b6:0:51::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16 via Frontend
 Transport; Thu, 12 Dec 2019 17:06:27 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Thu, 12 Dec 2019 17:06:27 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 12 Dec
 2019 11:06:24 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 12 Dec 2019 11:06:23 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] drm/amd/display: add event type check before restart the
 authentication
Date: Thu, 12 Dec 2019 12:06:14 -0500
Message-ID: <20191212170614.24837-7-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212170614.24837-1-Bhawanpreet.Lakha@amd.com>
References: <20191212170614.24837-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39850400004)(376002)(396003)(428003)(43544003)(199004)(189003)(7696005)(5660300002)(36756003)(70206006)(316002)(70586007)(336012)(186003)(26005)(81166006)(86362001)(478600001)(6916009)(4326008)(1076003)(2906002)(356004)(6666004)(8676002)(8936002)(426003)(2616005)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB2519; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb7cf1c1-334d-4598-f818-08d77f25a016
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2519:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2519E50CFFB403289754B714F9550@CY4PR1201MB2519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0249EFCB0B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +uBZiO/EsNFBWE/y1S/CMDAxN+iSoJtWg1ZCFkYSMGXo/RnEVIzkHbVxNjoFEpANNP8ZUqJ6ptdNEZefOJ1oBz6HP+o5xlsEFOvGWVhCkVxSzAO0E4vBglLpfe0Wje7YZom238wou28/FjEypQ29QUQTFuMOkPWWSROWRWBSv+Y2l7YuQw5M0Cm7IrllkP40Dc9ILJcOQlBqSAmSSk5a+7y7UyEsZBkEcKMF3O56w5ON3hfDlaTDH86ltfyoTo+3X0INTSanTmCBRcdaabfwDSoh052N0/ZEd0fAni/d6PSTt/t2K8mY1Q++bIa7Jv8mCvGcdYbfMjZW+ZRMLb99W22UHjN51aRE1yV7umm++0tpcMXqJ4DSJCbjseyGJoWr0UnX4rhUDJ7hX2FfctXYZd+Pw5lWzVcw0q4GdK5DW+EnqPmGjS4i7Lk34khvxm8tLWs9zIqHZJqMHGvraD873wuGV6v+yyJ9mCw9gt8YWhbBePqOfE/DTzIwOHm8Tgwu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 17:06:27.1020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7cf1c1-334d-4598-f818-08d77f25a016
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2519
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
Cc: Xiaodong Yan <Xiaodong.Yan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaodong Yan <Xiaodong.Yan@amd.com>

[Why]
Some combined docks will always trigger CP_IRQ but there's nothing the driver
needs to take care of, but the CP_IRQ breaks the original hdcp state and
triggers the driver to restart the authentication.

[How]
Add the event type check before restart the authentication or resend the stream
management

Signed-off-by: Xiaodong Yan <Xiaodong.Yan@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
---
 .../gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c  | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
index da190739a969..8cae3e3aacd5 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
@@ -630,7 +630,10 @@ enum mod_hdcp_status mod_hdcp_hdcp2_dp_transition(struct mod_hdcp *hdcp,
 			break;
 		} else if (input->prepare_stream_manage != PASS ||
 				input->stream_manage_write != PASS) {
-			fail_and_restart_in_ms(0, &status, output);
+			if (event_ctx->event == MOD_HDCP_EVENT_CALLBACK)
+				fail_and_restart_in_ms(0, &status, output);
+			else
+				increment_stay_counter(hdcp);
 			break;
 		}
 		callback_in_ms(100, output);
@@ -655,10 +658,12 @@ enum mod_hdcp_status mod_hdcp_hdcp2_dp_transition(struct mod_hdcp *hdcp,
 			 */
 			if (hdcp->auth.count.stream_management_retry_count > 10) {
 				fail_and_restart_in_ms(0, &status, output);
-			} else {
+			} else if (event_ctx->event == MOD_HDCP_EVENT_CALLBACK) {
 				hdcp->auth.count.stream_management_retry_count++;
 				callback_in_ms(0, output);
 				set_state_id(hdcp, output, D2_A9_SEND_STREAM_MANAGEMENT);
+			} else {
+				increment_stay_counter(hdcp);
 			}
 			break;
 		}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
