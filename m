Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9678EC3F2D1
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BDF220716
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TlhnbuHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDF220716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 244EC6E97E;
	Tue,  3 Mar 2020 23:27:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 326336E0A6
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 23:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2s+ebFicuYUAKU0JdX0N+X3CyYg7H37KWFV9AnPYM896nWfxxaysE7DFghybvKD0+xX58q5DgyVY5uFPKfM24iAnMkaCAoB9Kk223AIkBivV1tYECLkFVWKzAWsBPs3v+ElKCqVjQCTPDYqP0t6CLZy1YgmfPMMtQD5Hq8z9i6KL3fol117tXYTDDvOJzvfmVCIjuZp/1tgF/SDiDG8wEbDuYj/KVxdeZHvbQtW0cofxLsmpUtSSxISGxxpbni9L5lMEqddQF8mG/ZHEPCYHYTVDpwP9U4Bz4CyGKHh/GkAI2RSZK/++RZAr6McLDX/6uT4TonoVu8qIkLCZvxaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcmDKDCHqtDTSnhJgVx4ZLtAqJyY3eo0giPsdYG08GI=;
 b=SCpTWCOvP834JS3CeyfLAMAIZNkC1Xjbp7qmO0DgsG8ef04SsMc3IKoHt97BiZPJFvBKH/QVrMlbWM90h2D+QmBWEn/Nai1Y7DEeLGoguq2sy5K5rwm+uaXDW35rVR6T8/F9tSeGbpzD/weIG1HVSi5eF4OCRLAqRvAPeAs/BgRvqfYvNY4mBb3M+1gAn5UzXGI71eLlP+Wp3tgx01/W0ZNiQ0n9DiGsJ9/SJvnc5DIhQTGEHnmBBDYb5XTzY4qZyGZ0Ye5ipAJziSD9VFW282vRW9ls6veIi8aWioSmhgfOW7Wb+RC/x2btMCrdbn4AtmcQQXH5umzYyd05AWspRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcmDKDCHqtDTSnhJgVx4ZLtAqJyY3eo0giPsdYG08GI=;
 b=TlhnbuHrxF7ReU9aO9QbQ2NQzCeIcARX8lW8Obax8WlrMkhrk0XJBupBe+SRHolj4sc3EF0MMpD4Z2r9S1rAIqp39b9WMqG0csvv62auDltvyFcm0eMjfBPTVw5S/2HHk9480JXSqydfqSji0pnFy0GgHwcMyjaQOXzP0nuGY/0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2441.namprd12.prod.outlook.com (2603:10b6:907:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 23:27:36 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 23:27:36 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/12] drm/amd/display: determine is mst hdcp based on stream
 instead of sink signal
Date: Tue,  3 Mar 2020 18:27:09 -0500
Message-Id: <20200303232718.351364-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
References: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 23:27:35 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c0200c55-c5da-4358-ef95-08d7bfca74e0
X-MS-TrafficTypeDiagnostic: MW2PR12MB2441:|MW2PR12MB2441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2441871BCCD7CA095090867298E40@MW2PR12MB2441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:239;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(36756003)(6486002)(8936002)(54906003)(52116002)(7696005)(81166006)(81156014)(316002)(4326008)(6916009)(5660300002)(186003)(66476007)(956004)(66946007)(1076003)(478600001)(86362001)(2616005)(8676002)(6666004)(66556008)(26005)(16526019)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2441;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k7xpoZPqnA75B9PeCOHsuaHWQaWkBloF4J1MsUg8IIKg+yuzlTwC8cpFw+Txxvl1+13VG9ffjqM47Qi1rxvUS+uWb/Ykz7CKomqYpQDM8zY1rB465iMU+gri8camhYZHrCOzVCuA6jqNKtVBQfI0ANWjHkFGjZjXCkZ83+LADE2OPflHIqhXwAxZsEr+FVv+nlg4ROHILmfVrmHMd/Ho9VxcX2Tjaqhu7XXzv+CQRz6UhTSFGwUkFvC6ZpaA45lho2gOjXqFLelXbhAeOAzgS/mrvqIntkTkTKCsdtWTj62h4pza91LM47QrIsAwhqK2SlszD/5zfHn7B+nK9h8Sq5RDqUjx63g9cLZ7wECk+m79qOjntHkXCkbhlk1c+B4hx+rACLJwa9qrBDHj0ULeTxlO58SviJHJj2/Te2VSVrEMqzDDh+Q5LPumyh7ev4qI
X-MS-Exchange-AntiSpam-MessageData: niWW7QTTbTNc8lhsB4rRH9yFvqSbcd2HIimfJ0HGqfpaTyaxALIZiUwLm43LKS4rigmVkkFs9hEUsgt4yIWegg7WLN684l7e/Oad4ZOPggh/xh5O5nknrtpa4PFEM6xpGAuIxozbN8nhVM4P5kS0Yw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0200c55-c5da-4358-ef95-08d7bfca74e0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 23:27:36.3710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cz1c8YGZCTMUqN3HQAyRshlGrJnLsWOodKmgWU1b1ZJpAABACR0mU18Olzp07TLQL6fMGZJWJnXx6Jp12kW7cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2441
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
Cc: Ashley Thomas <Ashley.Thomas2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <Wenjing.Liu@amd.com>

[why]
It is possible even if sink signal is MST but driver enables SST stream.
We should not determine if we should do MST authentication based on
sink's capability.
Instead we should determine whether to do MST authentication based on
what we have enabled in stream.

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Ashley Thomas <Ashley.Thomas2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 1 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c          | 2 ++
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h             | 1 +
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c        | 4 +---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h        | 6 +++---
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h     | 4 ++--
 6 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index c4fd148bf6e0..5b70ed3cdb88 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -412,6 +412,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	link->dig_be = config->link_enc_inst;
 	link->ddc_line = aconnector->dc_link->ddc_hw_inst + 1;
 	link->dp.rev = aconnector->dc_link->dpcd_caps.dpcd_rev.raw;
+	link->dp.mst_supported = config->mst_supported;
 	display->adjust.disable = 1;
 	link->adjust.auth_delay = 2;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index a4680968c8f4..ddd4dca61cc3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2959,6 +2959,8 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 		config.link_enc_inst = pipe_ctx->stream->link->link_enc_hw_inst;
 		config.dpms_off = dpms_off;
 		config.dm_stream_ctx = pipe_ctx->stream->dm_stream_context;
+		config.mst_supported = (pipe_ctx->stream->signal ==
+				SIGNAL_TYPE_DISPLAY_PORT_MST);
 		cp_psp->funcs.update_stream_config(cp_psp->handle, &config);
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h b/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
index 626d22d437f4..968c46dfb506 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
@@ -32,6 +32,7 @@ struct cp_psp_stream_config {
 	uint8_t otg_inst;
 	uint8_t link_enc_inst;
 	uint8_t stream_enc_inst;
+	uint8_t mst_supported;
 	void *dm_stream_ctx;
 	bool dpms_off;
 };
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index bcba93d3b195..7a571b3f62d6 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -481,10 +481,8 @@ enum mod_hdcp_operation_mode mod_hdcp_signal_type_to_operation_mode(
 		break;
 	case SIGNAL_TYPE_EDP:
 	case SIGNAL_TYPE_DISPLAY_PORT:
-		mode = MOD_HDCP_MODE_DP;
-		break;
 	case SIGNAL_TYPE_DISPLAY_PORT_MST:
-		mode = MOD_HDCP_MODE_DP_MST;
+		mode = MOD_HDCP_MODE_DP;
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index 77fdcec4263e..5cb4546be0ef 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -392,13 +392,13 @@ enum mod_hdcp_status mod_hdcp_write_content_type(struct mod_hdcp *hdcp);
 /* hdcp version helpers */
 static inline uint8_t is_dp_hdcp(struct mod_hdcp *hdcp)
 {
-	return (hdcp->connection.link.mode == MOD_HDCP_MODE_DP ||
-			hdcp->connection.link.mode == MOD_HDCP_MODE_DP_MST);
+	return (hdcp->connection.link.mode == MOD_HDCP_MODE_DP);
 }
 
 static inline uint8_t is_dp_mst_hdcp(struct mod_hdcp *hdcp)
 {
-	return (hdcp->connection.link.mode == MOD_HDCP_MODE_DP_MST);
+	return (hdcp->connection.link.mode == MOD_HDCP_MODE_DP &&
+			hdcp->connection.link.dp.mst_supported);
 }
 
 static inline uint8_t is_hdmi_dvi_sl_hdcp(struct mod_hdcp *hdcp)
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index bb855ea5d5a3..c088602bc1a0 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -102,6 +102,7 @@ enum mod_hdcp_status {
 struct mod_hdcp_displayport {
 	uint8_t rev;
 	uint8_t assr_supported;
+	uint8_t mst_supported;
 };
 
 struct mod_hdcp_hdmi {
@@ -110,8 +111,7 @@ struct mod_hdcp_hdmi {
 enum mod_hdcp_operation_mode {
 	MOD_HDCP_MODE_OFF,
 	MOD_HDCP_MODE_DEFAULT,
-	MOD_HDCP_MODE_DP,
-	MOD_HDCP_MODE_DP_MST
+	MOD_HDCP_MODE_DP
 };
 
 enum mod_hdcp_display_state {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
