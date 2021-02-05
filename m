Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620A4C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231F664EEC
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231F664EEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66D46F502;
	Fri,  5 Feb 2021 22:03:28 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750085.outbound.protection.outlook.com [40.107.75.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FBF06F507
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 22:03:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BszgXJ6D1jy+8RabGJftJdY5HMFkvGsPZmfhCFV+M1CwmMQGQHR7a8OH1ztDRJZ4H3Zou0XXGxiVXqnH8tyNbmXuoXZz5lKHIQezGeqcR058uYvgxl/eW4gVSqa8Wc7Ice6MArra9S3alew5i2gLR//ZUw3PObKy3LD6BfU9By+KyOYH8pN5KxjhZzVyH+RyT0p34C+2cSwCSJxUxNuy/GCx4RD1PEExAMl6+H58lkyDvIIcgv/2SRhnEVEOn2v8R5LWdF3c/9TP11W8g3GU/8rEWKhVPMooSH7Pn1d2ySr2YmkpKTFQFcg1V6gEu+WYa0Z8TL8km1n3B+JucYy8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRvfB2+kURRYWr+5LqFryKN+yhbNFfVsXknZP/KdMf4=;
 b=UypMHbZycAubEjAOTdNu+jNwQ5vjtkl6js7+4cyq0Bt3ukCDUGvpd4HOEoD2LjpgmlwrDGSOONzY16JmJFp53CMLCjef0rrbzLNL1j3ubov5d5BPph/GG1+02xhj/gRu6YCXuCtc0Q9LkEfJHxWMBx68MzFBz9I+mrx7BC88Xf+NQAEl6iRfSXftbxUS89CYSHxRnw7FHTlZ8LTppzarT6zes3x43KgP8CJjrmwdYhuWX/qtOr6Tv8hGrVK7RFO/fx+gIZrAzu28vkhQaVJ4dgfir/QfeI1na+/8HN5H4RZze2rPEv9a7mPnXb9mUcc8CZI/NmNhoE6xk19hJYZ9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRvfB2+kURRYWr+5LqFryKN+yhbNFfVsXknZP/KdMf4=;
 b=0FCLNDm5fBrQC/f8JVVIdyHd7fUPqmDeaeHSIYtqinXWoPKqBmmKzcQInRCx1ki7RKyD74d7rYmz4D6gx9OCkhtVYdI/Tumbkc+/wlTn1pPkA+73ZIplMsKB/gmPJ1X2Y75582+LtOPHfAUEcqrhMzG7uNrtixXKfS7pXfdt4zA=
Received: from CO2PR05CA0062.namprd05.prod.outlook.com (2603:10b6:102:2::30)
 by DM5PR12MB1179.namprd12.prod.outlook.com (2603:10b6:3:6f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16; Fri, 5 Feb 2021 22:03:25 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::1b) by CO2PR05CA0062.outlook.office365.com
 (2603:10b6:102:2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend
 Transport; Fri, 5 Feb 2021 22:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 5 Feb 2021 22:03:23 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 16:03:14 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 5 Feb 2021 16:03:13 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/11] drm/amd/display: [FW Promotion] Release 0.0.51
Date: Fri, 5 Feb 2021 17:02:49 -0500
Message-ID: <20210205220250.1871069-11-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210205220250.1871069-1-Anson.Jacob@amd.com>
References: <20210205220250.1871069-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91a71d6d-061c-49f7-a757-08d8ca21db9b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1179:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1179DF431F0F42D09C4935C5EBB29@DM5PR12MB1179.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 93RCYTiTPLURjpOHx7B5lCy1KttONlx69P+8LfDDGMCkWBK0gaFwo3WaJ9S3UMvZOUuEnRTPCQWJMT4MD41lLShnFQ0qwvJEvxsD7p7/HCS616407ML/jSxfm/MqOlO/01n0c4eeowHLK42kDdhyM9I9T6FZ6XzXr5WbghsJvNbzKXtz9FSrfV5/1lw1SyO2E0JR3EPdis3JQBJdRMppkLttDRre4Bp2T+8aKkyHDlp3fpFYzUFSV9VricIZrQv7XNm8GOfu67oL33odecmPDGFVSoiFFHRKBgoDY0Z9x1aUEZnpOZk1O6wIwOp7QZVlKEEb9pzefgka2mzCSvAUEzl/5eGkjB+RjUNlj5WLFFkxGKD5k/qzRSY6ZCZBf7MeShZK2ln2aBXbDzFHBymEqnseYs/3xEXFoxUQE5GkpsE+MPLhGzIgBmdzI1+HSJzWKAKQD71eiTvv0V6OPoHE8aIHGQMayHF/864Tge3AsymN+8oIc9Ej9/b+I8z7JsN5U4aJD8psLb1U3aA2dES/130fLKvjoq6XyrCz89pT7nn8DxHMRfL5GTtYPjV6SJVIzzbOyou98cpYaSv7M3Ke7nbRTHr3qhXpxE0wtLiuPPmEkSeZA6+6xb7nrs07Kj/GMMN/hak7KI4IBCdd0ePjp/3+iHniyG7L2iMsS3dhKTd/Xml/176teT1EZyRRivLA9gv+gNOTmLkR2Cmon97RRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(86362001)(8936002)(316002)(186003)(36860700001)(6916009)(82310400003)(70206006)(54906003)(426003)(82740400003)(83380400001)(7696005)(2906002)(5660300002)(6666004)(4326008)(478600001)(26005)(336012)(47076005)(81166007)(2616005)(8676002)(70586007)(36756003)(1076003)(356005)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 22:03:23.8408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a71d6d-061c-49f7-a757-08d8ca21db9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1179
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Add new definition and union for dmub_rb_cmd_dig1_transmitter_control

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 29 ++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 5aaa35c8c172..072b4e7e624b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xca1cd48c9
+#define DMUB_FW_VERSION_GIT_HASH 0x6444c02e7
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 50
+#define DMUB_FW_VERSION_REVISION 51
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -491,13 +491,34 @@ struct dmub_rb_cmd_enable_disp_power_gating {
 	struct dmub_cmd_enable_disp_power_gating_data power_gating;
 };
 
-struct dmub_cmd_dig1_transmitter_control_data {
+struct dmub_dig_transmitter_control_data_v1_7 {
+	uint8_t phyid; /**< 0=UNIPHYA, 1=UNIPHYB, 2=UNIPHYC, 3=UNIPHYD, 4=UNIPHYE, 5=UNIPHYF */
+	uint8_t action; /**< Defined as ATOM_TRANSMITER_ACTION_xxx */
+	union {
+		uint8_t digmode; /**< enum atom_encode_mode_def */
+		uint8_t dplaneset; /**< DP voltage swing and pre-emphasis value, "DP_LANE_SET__xDB_y_zV" */
+	} mode_laneset;
+	uint8_t lanenum; /**< Number of lanes */
+	union {
+		uint32_t symclk_10khz; /**< Symbol Clock in 10Khz */
+	} symclk_units;
+	uint8_t hpdsel; /**< =1: HPD1, =2: HPD2, ..., =6: HPD6, =0: HPD is not assigned */
+	uint8_t digfe_sel; /**< DIG front-end selection, bit0 means DIG0 FE is enabled */
+	uint8_t connobj_id; /**< Connector Object Id defined in ObjectId.h */
+	uint8_t reserved0; /**< For future use */
+	uint8_t reserved1; /**< For future use */
+	uint8_t reserved2[3]; /**< For future use */
+	uint32_t reserved3[11]; /**< For future use */
+};
+
+union dmub_cmd_dig1_transmitter_control_data {
 	struct dig_transmitter_control_parameters_v1_6 dig;
+	struct dmub_dig_transmitter_control_data_v1_7 dig_v1_7;
 };
 
 struct dmub_rb_cmd_dig1_transmitter_control {
 	struct dmub_cmd_header header;
-	struct dmub_cmd_dig1_transmitter_control_data transmitter_control;
+	union dmub_cmd_dig1_transmitter_control_data transmitter_control;
 };
 
 struct dmub_rb_cmd_dpphy_init {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
