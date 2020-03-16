Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF48C18E5B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150A32051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="opUg89zr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150A32051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A5F96E471;
	Mon, 16 Mar 2020 13:50:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04AF96E462
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:50:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtFy5mYE+TwhK75SzAaSJCIyaAQzr8+st/ZaARXGD7Cm0Rnp+4ykly13tj+xfWHIvs7DX8q7XpTlaejn0X4G7mZMedqWS8n7Pp5P9mJuFDjId2cNUa49UoXLlIBLprH7oLHLsTCxxykTTW5HVX3mXRavm/fT8oC79dgSUJOSDvEgzMGd8Qc8ZsQ6UJ1zHoKDtv4po5C8b3Kw7kuQegitOlQoGAxPMMe+QwGAkxCWPQZgkFljuLZ54L+1rtIs+URmaFz7vKmbmsemNOrb0H5ddQcaCSC2C4FFIjX779w0C2w275ibGSTXxqYdJ9lvTzOF+BZbbaRfkF2hiesV8ty03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM7uY8Ay7+7VvJVFjMnvn5dW4uLO3N8EPqXjIy9PDLM=;
 b=HlHhaWHFs7BVPHSiPvB0SwjwG4BY5SoOleI3/6H8g3lnDKCbuxd74k3AqObioDi5+o4sfUEUP8l2rcFS0GRKk383qhHiVqDIesR2dshIETnarIIKbF6xyuOHdXNrMYKhZnBOnbHkXQJ6KhXlz2TBfEMG+hZTtMEJ1MZO+RLIq+RJkWIuuyChuDIyiheganaKCdM2dpkx8jCiI6kSA73jfeQKPLzluxnTNaVBxvyhceynDGFo5are58BXTbHXxeMl9+RFVWpEkl9QgtDQsX81rhc+nhh1FNTXcF7fu7PPgXfMJd5XsEQwQv1brGP6U2TiXilVeYL4MLpUeM6cT83nHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM7uY8Ay7+7VvJVFjMnvn5dW4uLO3N8EPqXjIy9PDLM=;
 b=opUg89zrN734yJ5xMspahkwOObpo7Ij5qgWH3JfZR3v6Pw9rKh1KKhTICWwO0VdnMRfzCQlhKt/OnEmNU0zHe6eiAAZqpbmLI2GliNAcTf+fdXUkh7f6MrbVnyVHIPzSyshn+RVNH2nxDzZP1q/V3QD0hry+pX43+Y/9TguqHNU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:50:04 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:50:04 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/19] drm/amd/display: remove magic numbers in hdcp_ddc
Date: Mon, 16 Mar 2020 09:49:12 -0400
Message-Id: <20200316134920.2526155-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
References: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:50:03 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e634affe-11dd-45df-c484-08d7c9b0ede0
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:|MW2PR12MB2396:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB239655F69777EF5C6911166A98F90@MW2PR12MB2396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(7696005)(6916009)(5660300002)(54906003)(26005)(36756003)(52116002)(1076003)(86362001)(66556008)(66946007)(66476007)(8936002)(6666004)(81166006)(81156014)(316002)(478600001)(2616005)(16526019)(2906002)(956004)(4326008)(8676002)(186003)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2396;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PaDhHQKz13v/KiSIalT7ZJ0Rf1bdU/M56+pUYrcN+w54BoB7w58S4claiPVnL3GXnUn3Xr9jahXF4Qiia5QpQIX/nCNCB12NY6SESPIX8X3ox63Zk3RapiM6Bc/KyE0w+GwLDABTU1V/qEgFNBV33KgOgcB2C2Cz8Q6JQAEQiKClCEOiAXQHzVjcgKHbdnj7/4bpcmX6LHtsaG1Pc/uzX9sjzpC/xZDYo0dg4KHbOK+7GgIEZHTPhpQmK97WrSXAxN8owLSFWFJexLvOr0kBkoE9dZokJqzMm6S1S1yY3Yy378PlVj4loeSTHe11Qn1MepHdtfJQv7JdUYTrIVAxyJuwzSl0zyRMDy+CdBINvdOHAS2+N8gostHd0393/fd7xHGF3S1i6FzuWIm/2Oe/hdFx+xKgUfMZCB2dvyPYG5ud2LVfivSntwu87aZdPztv
X-MS-Exchange-AntiSpam-MessageData: Gs9Pf/oaocb8odVGV1FJ8BsJ5G1V/YpB2X0mrsOKZ1Q7QRDdRa9N22TDYExehO9xyaErDa3rBEt+V06WD5aA7VTQPbAMDg53ewyBoZLKg9FLBNlJBS5rotKgRtOSiAv5CkzF035tmtothiNXd2ze9w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e634affe-11dd-45df-c484-08d7c9b0ede0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:50:04.1210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfFQWb0sp70MmifVVTKAXO0qqU6drWFR7LEVr7v5hR8Sh0yr+VHI2fMsw+Lobrj2aOV9cBpfEbBrj5vXymGhzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2396
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
DP doesn't have message id as the first byte of an hdcp message,
current hdcp psp unifies HDMI and DP message so that it is required
when reading DP HDCP messages in hdcp_ddc, a message id needs to be
added as the first byte of the HDCP message.
The id is currently assigned as a magic number which is not a good
coding practice.

[how]
Replace magic numbers with macro defined in hdcp headers.

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Ashley Thomas <Ashley.Thomas2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
index 816759d10cbc..bb5130f4228d 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
@@ -408,7 +408,7 @@ enum mod_hdcp_status mod_hdcp_read_ake_cert(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status;
 
 	if (is_dp_hdcp(hdcp)) {
-		hdcp->auth.msg.hdcp2.ake_cert[0] = 3;
+		hdcp->auth.msg.hdcp2.ake_cert[0] = HDCP_2_2_AKE_SEND_CERT;
 		status = read(hdcp, MOD_HDCP_MESSAGE_ID_READ_AKE_SEND_CERT,
 				hdcp->auth.msg.hdcp2.ake_cert+1,
 				sizeof(hdcp->auth.msg.hdcp2.ake_cert)-1);
@@ -426,7 +426,7 @@ enum mod_hdcp_status mod_hdcp_read_h_prime(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status;
 
 	if (is_dp_hdcp(hdcp)) {
-		hdcp->auth.msg.hdcp2.ake_h_prime[0] = 7;
+		hdcp->auth.msg.hdcp2.ake_h_prime[0] = HDCP_2_2_AKE_SEND_HPRIME;
 		status = read(hdcp, MOD_HDCP_MESSAGE_ID_READ_AKE_SEND_H_PRIME,
 				hdcp->auth.msg.hdcp2.ake_h_prime+1,
 				sizeof(hdcp->auth.msg.hdcp2.ake_h_prime)-1);
@@ -444,7 +444,7 @@ enum mod_hdcp_status mod_hdcp_read_pairing_info(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status;
 
 	if (is_dp_hdcp(hdcp)) {
-		hdcp->auth.msg.hdcp2.ake_pairing_info[0] = 8;
+		hdcp->auth.msg.hdcp2.ake_pairing_info[0] = HDCP_2_2_AKE_SEND_PAIRING_INFO;
 		status = read(hdcp, MOD_HDCP_MESSAGE_ID_READ_AKE_SEND_PAIRING_INFO,
 				hdcp->auth.msg.hdcp2.ake_pairing_info+1,
 				sizeof(hdcp->auth.msg.hdcp2.ake_pairing_info)-1);
@@ -462,7 +462,7 @@ enum mod_hdcp_status mod_hdcp_read_l_prime(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status;
 
 	if (is_dp_hdcp(hdcp)) {
-		hdcp->auth.msg.hdcp2.lc_l_prime[0] = 10;
+		hdcp->auth.msg.hdcp2.lc_l_prime[0] = HDCP_2_2_LC_SEND_LPRIME;
 		status = read(hdcp, MOD_HDCP_MESSAGE_ID_READ_LC_SEND_L_PRIME,
 				hdcp->auth.msg.hdcp2.lc_l_prime+1,
 				sizeof(hdcp->auth.msg.hdcp2.lc_l_prime)-1);
@@ -484,7 +484,7 @@ enum mod_hdcp_status mod_hdcp_read_rx_id_list(struct mod_hdcp *hdcp)
 		uint32_t rx_id_list_size = 0;
 		uint32_t bytes_read = 0;
 
-		hdcp->auth.msg.hdcp2.rx_id_list[0] = 12;
+		hdcp->auth.msg.hdcp2.rx_id_list[0] = HDCP_2_2_REP_SEND_RECVID_LIST;
 		status = read(hdcp, MOD_HDCP_MESSAGE_ID_READ_REPEATER_AUTH_SEND_RECEIVERID_LIST,
 						hdcp->auth.msg.hdcp2.rx_id_list+1,
 						HDCP_MAX_AUX_TRANSACTION_SIZE);
@@ -511,7 +511,7 @@ enum mod_hdcp_status mod_hdcp_read_stream_ready(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status;
 
 	if (is_dp_hdcp(hdcp)) {
-		hdcp->auth.msg.hdcp2.repeater_auth_stream_ready[0] = 17;
+		hdcp->auth.msg.hdcp2.repeater_auth_stream_ready[0] = HDCP_2_2_REP_STREAM_READY;
 		status = read(hdcp, MOD_HDCP_MESSAGE_ID_READ_REPEATER_AUTH_STREAM_READY,
 				hdcp->auth.msg.hdcp2.repeater_auth_stream_ready+1,
 				sizeof(hdcp->auth.msg.hdcp2.repeater_auth_stream_ready)-1);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
