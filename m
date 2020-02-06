Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3611C35247
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 21:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676B321775
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 21:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LDe14vWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676B321775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B4666FB5C;
	Thu,  6 Feb 2020 21:14:40 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690059.outbound.protection.outlook.com [40.107.69.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88DE76FB5C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 21:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gobd3yvY2pMyo1qGqSW17YMi9Acd3q6BXTwLxXxr5RqxhyXsnlpK2Z/WB3ScdNBbwBKfmmTtmbqyxrc3UrNqpYdR8aeaOgQtXwPZLoS8O1wn/S5RdlEwgNT+2OPjrNRgsjhN+dvEe1WIQAwi9b9N6a9tkZp3lPRY8vN/M8aWh89HWrFqETfLSE/QZTpoXbkzGOk1CUBufoEv0Kj3w9lTCaC7SVuLXjixZgpCrirmDGqb4tI5RjHXLDyetkQ+8r6Hzv/xOqcRSfBr2La397kQN7SvI/cUXu73OoVQkFVpfIgRYPZgIwe/Tk3sY5dCzlyaX5bYsC1aCv3zdAIEpEtlVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tc0ckRmos/TUtSibgHgoJ7E6QRi9Ri/P5UbSmdxvAqc=;
 b=jLJTU4f4cDAkfkYwQazJY8N/tJf01w1PCrKiE77NSJZDEFZ5G6CeKkSaDFA8Atz6aSQfAb8Djv0uL5hVH+imAGT2W6MAuhNh5JlDhYzmbOFhVVPw9N+cTtvH6ZOl3havrRqrGHeDjNASTY6Sadw5ChPT3CAkaAyFLhVMAp0pBTguMfnjVsDKvclWILdjFo3J5C/zDa6o+ADboY8+Vs/9UkILB3AYSqGhPXmNACjli43cImzK1OX3GX0rX5vuUIBEH9wefO1Wd2Rri/mbo5DFAci3vvxIAIYySesPAmRnklqXhuOpYInCUQBDwBHIxi9IkJVyF0aBJM9DQuLqMv+flg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tc0ckRmos/TUtSibgHgoJ7E6QRi9Ri/P5UbSmdxvAqc=;
 b=LDe14vWAxuXrDdEoHHGoumbwW7b6rtJL9vuBCOy8OH0IDvPL9YlxE3DeTCRIoYl43cHg+d6zeN+ttLcm9i7hXEjmRIll1PipZvyAFSPh3goV6Pl6bQ6v9AFAP/c2YHUff8ZeAarIf4yVna+tBURt4c9sg8DJxQn0RZnD8ON4VzY=
Received: from MN2PR12CA0006.namprd12.prod.outlook.com (2603:10b6:208:a8::19)
 by MWHPR12MB1840.namprd12.prod.outlook.com (2603:10b6:300:114::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21; Thu, 6 Feb
 2020 21:14:38 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::200) by MN2PR12CA0006.outlook.office365.com
 (2603:10b6:208:a8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.24 via Frontend
 Transport; Thu, 6 Feb 2020 21:14:38 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 21:14:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Feb 2020
 15:14:37 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Feb 2020
 15:14:37 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 6 Feb 2020 15:14:37 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amd/display: Handle revoked receivers
Date: Thu, 6 Feb 2020 16:14:21 -0500
Message-ID: <20200206211425.20394-2-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206211425.20394-1-Bhawanpreet.Lakha@amd.com>
References: <20200206211425.20394-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(428003)(189003)(199004)(478600001)(5660300002)(426003)(7696005)(336012)(86362001)(6666004)(6916009)(186003)(36756003)(26005)(356004)(2616005)(70586007)(70206006)(54906003)(4326008)(2906002)(81156014)(81166006)(316002)(8936002)(8676002)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1840; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80db9315-0175-4842-02f3-08d7ab4992d4
X-MS-TrafficTypeDiagnostic: MWHPR12MB1840:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1840414A5BA7684A054E19CAF91D0@MWHPR12MB1840.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 81gO/rDpdea3+of/70Vy9PGfYfh39LCT6kUFtJX8F22l900UqVc6mRxe1xQl+yYV7xshz4rLQE4+jyFbS6pgB4IXfdxv/9n3D476Z2GolVYAcVXUL56Ye6j9mSsm31pGAxFlDJ7/6bkJ6LYZMsc87E2xonYiKAwQq2iM/c9nXorMkaqe4kYCf2ZyApnWKrw/XpUfkdWM2Z5YZ4QJ1mzy2IjwIiejyZIQPUIlvel2dyIhgscYfrXVk56t4mkOOR11PhYreZL02176inPqZnm3HLbvXiwulVqXEbej2IL2CvJcLU8jpcElBFe26/5wm+ght/zegAdjM5zYK1vkPPQzIYHfUboVAxHY/Knrjkys4pOgvdRodNoPcm2hc5G3IRSP3yPaM7m/w0R7f/uXNMiWcDeXYeRKddsVbeU3HZKMKRmhKNd4h8+YZC5r5mP2xwU3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 21:14:38.0124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80db9315-0175-4842-02f3-08d7ab4992d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1840
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
PSP added a new return code for revoked receivers (SRM). We need to
handle that so we don't retry hdcp

This is already being handled on windows

[How]
Add the enums to psp interface header and handle them.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   | 28 ++++++++++++++++---
 .../drm/amd/display/modules/hdcp/hdcp_psp.h   |  6 ++--
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 7911dc157d5a..844454e0a5ba 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -210,6 +210,10 @@ enum mod_hdcp_status mod_hdcp_hdcp1_validate_rx(struct mod_hdcp *hdcp)
 	} else if (hdcp_cmd->out_msg.hdcp1_first_part_authentication.authentication_status ==
 		   TA_HDCP_AUTHENTICATION_STATUS__HDCP1_AUTHENTICATED) {
 		hdcp->connection.is_repeater = 0;
+	} else if (hdcp_cmd->out_msg.hdcp1_first_part_authentication.authentication_status ==
+		   TA_HDCP_AUTHENTICATION_STATUS__HDCP1_KSV_REVOKED) {
+		hdcp->connection.is_hdcp1_revoked = 1;
+		return MOD_HDCP_STATUS_HDCP1_BKSV_REVOKED;
 	} else
 		return MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILURE;
 
@@ -245,6 +249,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_validate_ksvlist_vp(struct mod_hdcp *hdcp)
 {
 	struct psp_context *psp = hdcp->config.psp.handle;
 	struct ta_hdcp_shared_memory *hdcp_cmd;
+	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
@@ -264,10 +269,19 @@ enum mod_hdcp_status mod_hdcp_hdcp1_validate_ksvlist_vp(struct mod_hdcp *hdcp)
 
 	psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
 
-	if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
-		return MOD_HDCP_STATUS_HDCP1_VALIDATE_KSV_LIST_FAILURE;
+	if (hdcp_cmd->hdcp_status == TA_HDCP_STATUS__SUCCESS &&
+	    hdcp_cmd->out_msg.hdcp1_second_part_authentication.authentication_status ==
+		    TA_HDCP_AUTHENTICATION_STATUS__HDCP1_AUTHENTICATED) {
+		status = MOD_HDCP_STATUS_SUCCESS;
+	} else if (hdcp_cmd->out_msg.hdcp1_second_part_authentication.authentication_status ==
+		   TA_HDCP_AUTHENTICATION_STATUS__HDCP1_KSV_REVOKED) {
+		hdcp->connection.is_hdcp1_revoked = 1;
+		status = MOD_HDCP_STATUS_HDCP1_KSV_LIST_REVOKED;
+	} else {
+		status = MOD_HDCP_STATUS_HDCP1_VALIDATE_KSV_LIST_FAILURE;
+	}
 
-	return MOD_HDCP_STATUS_SUCCESS;
+	return status;
 }
 
 enum mod_hdcp_status mod_hdcp_hdcp1_enable_dp_stream_encryption(struct mod_hdcp *hdcp)
@@ -473,9 +487,12 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_ake_cert(struct mod_hdcp *hdcp)
 		hdcp->connection.is_km_stored = msg_out->process.is_km_stored ? 1 : 0;
 		hdcp->connection.is_repeater = msg_out->process.is_repeater ? 1 : 0;
 		return MOD_HDCP_STATUS_SUCCESS;
+	} else if (msg_out->process.msg1_status == TA_HDCP2_MSG_AUTHENTICATION_STATUS__RECEIVERID_REVOKED) {
+		hdcp->connection.is_hdcp2_revoked = 1;
+		return MOD_HDCP_STATUS_HDCP2_AKE_CERT_REVOKED;
 	}
 
-	return MOD_HDCP_STATUS_FAILURE;
+	return MOD_HDCP_STATUS_HDCP2_VALIDATE_AKE_CERT_FAILURE;
 }
 
 enum mod_hdcp_status mod_hdcp_hdcp2_validate_h_prime(struct mod_hdcp *hdcp)
@@ -695,6 +712,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_rx_id_list(struct mod_hdcp *hdcp)
 		hdcp->connection.is_km_stored = msg_out->process.is_km_stored ? 1 : 0;
 		hdcp->connection.is_repeater = msg_out->process.is_repeater ? 1 : 0;
 		return MOD_HDCP_STATUS_SUCCESS;
+	} else if (msg_out->process.msg1_status == TA_HDCP2_MSG_AUTHENTICATION_STATUS__RECEIVERID_REVOKED) {
+		hdcp->connection.is_hdcp2_revoked = 1;
+		return MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_REVOKED;
 	}
 
 
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
index d5cb3f46606f..1a663dbbf810 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
@@ -240,7 +240,8 @@ enum ta_hdcp_authentication_status {
 	TA_HDCP_AUTHENTICATION_STATUS__HDCP22_AUTHENTICATION_PENDING = 0x06,
 	TA_HDCP_AUTHENTICATION_STATUS__HDCP22_AUTHENTICATION_FAILED = 0x07,
 	TA_HDCP_AUTHENTICATION_STATUS__HDCP22_AUTHENTICATED = 0x08,
-	TA_HDCP_AUTHENTICATION_STATUS__HDCP1_KSV_VALIDATION_FAILED = 0x09
+	TA_HDCP_AUTHENTICATION_STATUS__HDCP1_KSV_VALIDATION_FAILED = 0x09,
+	TA_HDCP_AUTHENTICATION_STATUS__HDCP1_KSV_REVOKED = 0x0A
 };
 
 enum ta_hdcp2_msg_authentication_status {
@@ -258,7 +259,8 @@ enum ta_hdcp2_msg_authentication_status {
 	TA_HDCP2_MSG_AUTHENTICATION_STATUS__INVALID_SEQ_NUM,
 	TA_HDCP2_MSG_AUTHENTICATION_STATUS__INVALID_SIZE,
 	TA_HDCP2_MSG_AUTHENTICATION_STATUS__INVALID_LENGTH,
-	TA_HDCP2_MSG_AUTHENTICATION_STATUS__REAUTH_REQUEST
+	TA_HDCP2_MSG_AUTHENTICATION_STATUS__REAUTH_REQUEST,
+	TA_HDCP2_MSG_AUTHENTICATION_STATUS__RECEIVERID_REVOKED
 };
 
 enum ta_hdcp_content_type {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
