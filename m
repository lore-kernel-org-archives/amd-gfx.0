Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1FAC3F2D8
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5FE720716
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4RlNAbZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5FE720716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01A8D6E989;
	Tue,  3 Mar 2020 23:27:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A0226E98B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 23:27:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCZMo3MdOZtQYbz+MvdMdD+A9KVnvfLozMAhWlWHpifT3tvbFssjKQCpknhhJ1xetU9N4Yi1YW8/dw+ROL4tJgfQOpxgKENipR9moNEovJk3GHqHzngRtgKYuNE1t0KVY1epLcLfdFlEdI3ESdFez2AC9SeOVj2DZMPJfjyIgwCfyfZbabZ9WfBAuv+lyZAqVX3s9DZyE0GhcZAY+g2xkKMWuMbZKnIILP+5lrLyAafKZLTYI5w1bbgdRSY4RB5Ioe0cpc2ITsE5MgLmU8JANYCiBAoApkBs80ugwR4STMfwHvgdoYcLhChWRp6WkyBhw0leMoPC6beC0sOykruYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sehLaXg6K5KfwseF0u/hH2VabQxDywanl4md+Inxf3g=;
 b=P9uFuzOYjKMoYgN8+/r9jUgKS5aFKicWH+BH/NMBEkhhITxEPEGfSrh8HZHoYms2sDWX3o4Rk7lwYcAmapX0wLc45fB4o7D5Gi7lFXH3++3W1mCloVSAKZhrJc13sKTADL2F3thVaWGbVbsYe4eBJK3fw4X5uU7Jz5Wd4FJ2K47f/xeZT3XVFTaXn5TkP6EgNuPIbPoXQB+EjyuM+7tcJJ6yAKl5Rc01krg05ZpohyhaxkIyxLbhyAOXluFICOmYpYUInBE4XBZdTE1DGmb5lpASAlszR4ovQ30rYZAPP8p5H0jTxz1EKPLgL9lbCJ/I0PhiiOM1TJNx3vBJPszqOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sehLaXg6K5KfwseF0u/hH2VabQxDywanl4md+Inxf3g=;
 b=4RlNAbZMA6rz8z3qK4ZSPet/ZVeWaA/O89RhweKx29p/dwzfZNFBNcqkEf1IGyVz/tefJuv2BtrcUOusJPaNVB9nzyGYYmVgmzMpC8geCtL8jLor586A3g9wcGOOWUOyumuiBaT0p+L672BnZu9umsMSEOYMu0XAT5fttCAxrAE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2441.namprd12.prod.outlook.com (2603:10b6:907:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 23:27:40 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 23:27:40 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/12] drm/amd/display: determine rx id list bytes to read
 based on device count
Date: Tue,  3 Mar 2020 18:27:13 -0500
Message-Id: <20200303232718.351364-8-Rodrigo.Siqueira@amd.com>
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
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 23:27:39 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 99fce797-af34-4a53-d3a3-08d7bfca7723
X-MS-TrafficTypeDiagnostic: MW2PR12MB2441:|MW2PR12MB2441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24418D0399596EDF2FBC577F98E40@MW2PR12MB2441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
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
X-Microsoft-Antispam-Message-Info: 5yLS+XEt9LTQctIoGQlwyOMfbZoImv4kdlOG7otIKk3JEsJdQgWVNqY+PCiM9iW4EDUsKlDLRPHUxdZ6AyTtxYLZ7xwV6r9z2Fg3W2F6Ko4/q4LJfMyArKPwLd+RXddCjnXR+6d14Z6n3e0dps7j7HQOPYlwfr/R9Jals33zP0BUy0QnaFpvc/5iknr8Ada+7kUH8XOWyy3qW8F03Ut3NPi8o2LxYkDRFljzrFRPDm8D8sVaqK7DqXsf0dhZc+fWBPrb0ZLtjR/yz9YfKAkG2WRW0N0/5gKrsizlOLDCla1TmqPB2GXod2yBe501E3FPfrmzBNr4ZffXMnGVWE4iOUFU78wBzIyzpdARu5qXILV6JJorbSo6Or/ZqImjuqrBRSxYalO0Z4J4rZxI28Zi54DOL9B4zZ/7/RywHGY8ZH+5MAs2HlNqC7P4lQqLxGL7
X-MS-Exchange-AntiSpam-MessageData: 6XPGd+ySE++KJFjvQuiBIfm815GWPueahLDwQw7yAfFN15Qk5849JylGYE15FPI07Wh5md21vPTMxtcco7WUee48c612ytDMT++SfYPxLIh/QuE/s2q1VYrGUKd1Yxjb4h1KJeVOhnYbOWqkEGNM0Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fce797-af34-4a53-d3a3-08d7bfca7723
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 23:27:40.1808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCgyTvu37hkvYRnuejYfvi1ASQ8sD4tJX7a+RSEVnFxsll/q041hL1//uAL1sp718nZkP/B7VmYUH3yvwvbSlQ==
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
Some RX doesn't like us to read rx id list upto max rx id list size.  As
discussed, we decided to read rx id list based on device count.

[how]
According to HDCP specs the actual size of rx id list is calculated as
rx id list size = 2+3+16+5*device_count.  We will read 16 bytes at a
time until it reached or exceeded rx id list size.

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Ashley Thomas <Ashley.Thomas2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   | 24 +++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
index ff9d54812e62..816759d10cbc 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
@@ -65,6 +65,7 @@ enum mod_hdcp_ddc_message_id {
 	MOD_HDCP_MESSAGE_ID_READ_LC_SEND_L_PRIME,
 	MOD_HDCP_MESSAGE_ID_WRITE_SKE_SEND_EKS,
 	MOD_HDCP_MESSAGE_ID_READ_REPEATER_AUTH_SEND_RECEIVERID_LIST,
+	MOD_HDCP_MESSAGE_ID_READ_REPEATER_AUTH_SEND_RECEIVERID_LIST_PART2,
 	MOD_HDCP_MESSAGE_ID_WRITE_REPEATER_AUTH_SEND_ACK,
 	MOD_HDCP_MESSAGE_ID_WRITE_REPEATER_AUTH_STREAM_MANAGE,
 	MOD_HDCP_MESSAGE_ID_READ_REPEATER_AUTH_STREAM_READY,
@@ -101,6 +102,7 @@ static const uint8_t hdcp_i2c_offsets[] = {
 	[MOD_HDCP_MESSAGE_ID_READ_LC_SEND_L_PRIME] = 0x80,
 	[MOD_HDCP_MESSAGE_ID_WRITE_SKE_SEND_EKS] = 0x60,
 	[MOD_HDCP_MESSAGE_ID_READ_REPEATER_AUTH_SEND_RECEIVERID_LIST] = 0x80,
+	[MOD_HDCP_MESSAGE_ID_READ_REPEATER_AUTH_SEND_RECEIVERID_LIST_PART2] = 0x80,
 	[MOD_HDCP_MESSAGE_ID_WRITE_REPEATER_AUTH_SEND_ACK] = 0x60,
 	[MOD_HDCP_MESSAGE_ID_WRITE_REPEATER_AUTH_STREAM_MANAGE] = 0x60,
 	[MOD_HDCP_MESSAGE_ID_READ_REPEATER_AUTH_STREAM_READY] = 0x80,
@@ -135,6 +137,7 @@ static const uint32_t hdcp_dpcd_addrs[] = {
 	[MOD_HDCP_MESSAGE_ID_READ_LC_SEND_L_PRIME] = 0x692f8,
 	[MOD_HDCP_MESSAGE_ID_WRITE_SKE_SEND_EKS] = 0x69318,
 	[MOD_HDCP_MESSAGE_ID_READ_REPEATER_AUTH_SEND_RECEIVERID_LIST] = 0x69330,
+	[MOD_HDCP_MESSAGE_ID_READ_REPEATER_AUTH_SEND_RECEIVERID_LIST_PART2] = 0x69340,
 	[MOD_HDCP_MESSAGE_ID_WRITE_REPEATER_AUTH_SEND_ACK] = 0x693e0,
 	[MOD_HDCP_MESSAGE_ID_WRITE_REPEATER_AUTH_STREAM_MANAGE] = 0x693f0,
 	[MOD_HDCP_MESSAGE_ID_READ_REPEATER_AUTH_STREAM_READY] = 0x69473,
@@ -474,14 +477,27 @@ enum mod_hdcp_status mod_hdcp_read_l_prime(struct mod_hdcp *hdcp)
 
 enum mod_hdcp_status mod_hdcp_read_rx_id_list(struct mod_hdcp *hdcp)
 {
-	enum mod_hdcp_status status;
+	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	if (is_dp_hdcp(hdcp)) {
+		uint32_t device_count = 0;
+		uint32_t rx_id_list_size = 0;
+		uint32_t bytes_read = 0;
+
 		hdcp->auth.msg.hdcp2.rx_id_list[0] = 12;
 		status = read(hdcp, MOD_HDCP_MESSAGE_ID_READ_REPEATER_AUTH_SEND_RECEIVERID_LIST,
-				hdcp->auth.msg.hdcp2.rx_id_list+1,
-				sizeof(hdcp->auth.msg.hdcp2.rx_id_list)-1);
-
+						hdcp->auth.msg.hdcp2.rx_id_list+1,
+						HDCP_MAX_AUX_TRANSACTION_SIZE);
+		if (status == MOD_HDCP_STATUS_SUCCESS) {
+			bytes_read = HDCP_MAX_AUX_TRANSACTION_SIZE;
+			device_count = HDCP_2_2_DEV_COUNT_LO(hdcp->auth.msg.hdcp2.rx_id_list[2]) +
+					(HDCP_2_2_DEV_COUNT_HI(hdcp->auth.msg.hdcp2.rx_id_list[1]) << 4);
+			rx_id_list_size = MIN((21 + 5 * device_count),
+					(sizeof(hdcp->auth.msg.hdcp2.rx_id_list) - 1));
+			status = read(hdcp, MOD_HDCP_MESSAGE_ID_READ_REPEATER_AUTH_SEND_RECEIVERID_LIST_PART2,
+					hdcp->auth.msg.hdcp2.rx_id_list + 1 + bytes_read,
+					(rx_id_list_size - 1) / HDCP_MAX_AUX_TRANSACTION_SIZE * HDCP_MAX_AUX_TRANSACTION_SIZE);
+		}
 	} else {
 		status = read(hdcp, MOD_HDCP_MESSAGE_ID_READ_REPEATER_AUTH_SEND_RECEIVERID_LIST,
 				hdcp->auth.msg.hdcp2.rx_id_list,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
