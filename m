Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE9BC4167B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8795C23B86
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8795C23B86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D2956E9C1;
	Tue,  8 Dec 2020 19:29:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD0186E9C1
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 19:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pb464AEuXVAEIIYtOuc1VhN/C3fEXQG1GrRsFrKuiqeXOm/bYDslmrRvoAUeYRPLuDE8cP6u/GYDIcc5pFFS6+rVSduLC2NaNY+tbymkC6E0AhKwtEFZgigRjnNhkriAwoYbFzETevcYyzeQs6DiuIDtVveLIznYcv7Lbix7RpuGVI0VRUcGPzQqn9MVbyCJiAHBKfli/TQH+8f1Hx8FjXXEQg61zJX1neGC8BSohwbWKSrvZ4ZobZMODmdK7d5P/QmpTr35VBAoo8GrcH7mpL/QqcgRLgw6M4eImyxfA8SOrsD2jL7YuOyNdiFXG1VA+uFfOpPEBp4VLSbX0feq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw9wP31ko9MhmlDb3zhuiHUHCVdHoZz5dAenRD73HKs=;
 b=bV8yrOuz+Pg/SdLn8CrOQwy62ZCRL6PbNaXqA0V33NwaMlom44JMsDtWtKR8dD6iHNnBK6+8CPaFqwqpoyNHztlqSvROaIV/pv8+qOEnrhGEm5sxlMyRrfabaCNQwi/6MOP+YNOkijU+y2P+izD2b7FqrJHv1LgLYnPlCyblSN9W7Be58rZsuggiuo1dQlouoTvxxTanB4yUMdFZuZiAOWCQvpiAXVdloqiUd3+NFBVbsQ9Qj5JxnhNPykHgbt+A3a7hoi2AT/4sB6pEptTh59d5joahQqyj2ziUkoqOTraqj8XvE2xk/EoTWK4eanAnb1W70zwBNeLpjbQzWJkDwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw9wP31ko9MhmlDb3zhuiHUHCVdHoZz5dAenRD73HKs=;
 b=oRCuH3/WkqqRKRqh9u8g9j1UqR3/SPzvba+yTvfgBUD/dbJhlLIZfMcFU8yLQfQpDwJWHRiF6DpLK1UxpQ4Szm4nvW5KSozW5e1/RUijJQu1Sdf68OXzVe5BDj4lE6GpN/MrHrlih4ZtEkxHbAty3d1MKE5SZ2mBTfYdkQjlafQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Tue, 8 Dec
 2020 19:29:04 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853%6]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 19:29:04 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/13] drm/amd/display: [FW Promotion] Release 0.0.46
Date: Tue,  8 Dec 2020 14:28:43 -0500
Message-Id: <20201208192844.23580-13-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208192844.23580-1-qingqing.zhuo@amd.com>
References: <20201208192844.23580-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 19:29:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 187e74e2-c57d-40fb-eab2-08d89baf8645
X-MS-TrafficTypeDiagnostic: DM6PR12MB4338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4338524A4CAFC2B7D5A919FCFBCD0@DM6PR12MB4338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVbM4mpV0UdEeNM5+gO7RxXDxoI74VojfEaijlztmVtx8Jp/63WBATHOOegZyskymjPwlbVIaTjmFs6Q5nmgMChvr1AUjhsjgzgEWWysy/6L04GYM1ehqJRBaXyCjQTvspWQC6i0Z/zDiT5vKjwAZb6VF1bhSRFD7CfJrsod3yqlkK1TlrvLu8ws/mC9g4dA96DSzmrWVmhzuXXnZMGHXDXK2r+Zydwv6RTkD/WA/+RJd+qn5N2Qa6XY8Q6kEJbr2QYdl6cZaYX1f1AL6KQmnJLM7LOXZ+IKH8jGYSrn/8YkV0VPkybYTUGDQ35CsdA0pdoJk1B8n1iF2xeNQAz5l6cOShmhPVaRtPgCk3LLVKfq/Ct3wYQUek2QcvJCA5d17bscWuS8EDompAjhgr/KzJpPRaS70x5ylcrR1xH270E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(956004)(8936002)(44832011)(1076003)(36756003)(6512007)(69590400008)(16526019)(4326008)(34490700003)(83380400001)(66946007)(2906002)(6506007)(26005)(6666004)(5660300002)(186003)(8676002)(66556008)(52116002)(6916009)(2616005)(6486002)(66476007)(508600001)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?clKJWri+hvqTeN2TJ6nx2hxudzfuaoUd/omPS2D/KDc73UTAMV+ec8Hx6bU2?=
 =?us-ascii?Q?IQR/sZQESr36JkM6RooW/i5VLgIxQXwBoPCyoUhqrJfKj4GoXedtqj9zD9yN?=
 =?us-ascii?Q?IN5T38Zh4p9JOq3NWzoGo536SCsxllJkwO7iwpkn2VMR956sIj+0C1q+ilgr?=
 =?us-ascii?Q?ZUdmvmt5trl33M7B+sPaippO882XaJSWqswWf5aJkZGfsS51vlp0AilCkLLs?=
 =?us-ascii?Q?Qn6ZMwFdog11XkwZtKumkig2fkdYtnBOZYzdkQQMQ9wMSJkb+xKUTUDWqvBA?=
 =?us-ascii?Q?3HqoRWKQP09Gk3o+iBJzxqQWLEEpinDK6pW56jKgFL8Dy/oRMbG0iujENP5+?=
 =?us-ascii?Q?YD+2lShv/dKUu5hrszxB7Vw5WFet7Yg/JGaNpnfHkpCGMgAm5gkfXVsyCWju?=
 =?us-ascii?Q?cN2VOUGkF3kvdQqV3gpTMvkPpfCFg2kLOGz260bPXuKmpgaTMR/rsPYsGYn9?=
 =?us-ascii?Q?HezzDDucI/2f6n0to4Pf4F+6U8tJawy7lrn/9n0zLmFJuy7Z2XfhDierA185?=
 =?us-ascii?Q?kCN5fl6foxStKygNaVDolsjZA8W7yWCH7lq8v+xGfOjgWZSkFZ9dfzOVyDox?=
 =?us-ascii?Q?D3ZxhCRfM+58mkFEtxPrqxS/035Q+HApAGz9zH9J34wBXtbYqH3lkvTU0w7h?=
 =?us-ascii?Q?cq7XD70BvIfq5+MgwLdlY4VpDXxmYDFJXsni99qQMQsjaeLkETt8PFPR6113?=
 =?us-ascii?Q?KMSZ1Rp3h8JSZtPwrIxHkQwWiN8KlOZdqMx8llwVm1dChWP4leTcOcH5in+m?=
 =?us-ascii?Q?p6Fw4Mp0U845ngETnkY4qwmjQIADz0KUDPhS7MdzaVlwoFoB24Fv93xC0zD0?=
 =?us-ascii?Q?vvigpjmelV3h7qyyByZZGXs4cjgK+YjUr8etOrvLYllZdWCa4u+6m7Gm9Lxu?=
 =?us-ascii?Q?ypRRgHoCwguHipfuID1chdXH+23Ym2KhiP5tElBf2NO6lbZ2v4REeXHkck+1?=
 =?us-ascii?Q?3a3UuW/EfOzLF1yJc0gFg1ashDkKTG439J+VsxkdjEB/H2dDCeR4qFBQUgZ8?=
 =?us-ascii?Q?tKh6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 19:29:04.5947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 187e74e2-c57d-40fb-eab2-08d89baf8645
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLwRkUlan9T9AXbEn+N5EgBpUyHhscawlVv/bxoNbU+kGTCUlqp+6uAS/4n64SjY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
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
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

- Add new aux_channel_type
- Changed port_index to instance in dmub_cmd_dp_aux_control_data
- Change aux_return_code_type to sync up with driver
- param for ramping abm based on backlight level

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 62 +++++++++++--------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index b20a39f488ae..f512bda96917 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x931573111
+#define DMUB_FW_VERSION_GIT_HASH 0xa18e25995
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 45
+#define DMUB_FW_VERSION_REVISION 46
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -514,12 +514,20 @@ enum dp_aux_request_action {
 
 enum aux_return_code_type {
 	AUX_RET_SUCCESS = 0,
+	AUX_RET_ERROR_UNKNOWN,
+	AUX_RET_ERROR_INVALID_REPLY,
 	AUX_RET_ERROR_TIMEOUT,
-	AUX_RET_ERROR_NO_DATA,
+	AUX_RET_ERROR_HPD_DISCON,
+	AUX_RET_ERROR_ENGINE_ACQUIRE,
 	AUX_RET_ERROR_INVALID_OPERATION,
 	AUX_RET_ERROR_PROTOCOL_ERROR,
 };
 
+enum aux_channel_type {
+	AUX_CHANNEL_LEGACY_DDC,
+	AUX_CHANNEL_DPIA
+};
+
 /* DP AUX command */
 struct aux_transaction_parameters {
 	uint8_t is_i2c_over_aux;
@@ -532,9 +540,10 @@ struct aux_transaction_parameters {
 
 struct dmub_cmd_dp_aux_control_data {
 	uint32_t handle;
-	uint8_t port_index;
+	uint8_t instance;
 	uint8_t sw_crc_enabled;
 	uint16_t timeout;
+	enum aux_channel_type type;
 	struct aux_transaction_parameters dpaux;
 };
 
@@ -558,7 +567,7 @@ struct aux_reply_data {
 
 struct aux_reply_control_data {
 	uint32_t handle;
-	uint8_t phy_port_index;
+	uint8_t instance;
 	uint8_t result;
 	uint16_t pad;
 };
@@ -581,7 +590,7 @@ enum dp_hpd_status {
 };
 
 struct dp_hpd_data {
-	uint8_t phy_port_index;
+	uint8_t instance;
 	uint8_t hpd_type;
 	uint8_t hpd_status;
 	uint8_t pad;
@@ -732,27 +741,30 @@ enum dmub_cmd_abm_type {
 struct abm_config_table {
 	/* Parameters for crgb conversion */
 	uint16_t crgb_thresh[NUM_POWER_FN_SEGS];                 // 0B
-	uint16_t crgb_offset[NUM_POWER_FN_SEGS];                 // 15B
-	uint16_t crgb_slope[NUM_POWER_FN_SEGS];                  // 31B
+	uint16_t crgb_offset[NUM_POWER_FN_SEGS];                 // 16B
+	uint16_t crgb_slope[NUM_POWER_FN_SEGS];                  // 32B
 
 	/* Parameters for custom curve */
-	uint16_t backlight_thresholds[NUM_BL_CURVE_SEGS];        // 47B
-	uint16_t backlight_offsets[NUM_BL_CURVE_SEGS];           // 79B
-
-	uint16_t ambient_thresholds_lux[NUM_AMBI_LEVEL];         // 111B
-	uint16_t min_abm_backlight;                              // 121B
-
-	uint8_t min_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 123B
-	uint8_t max_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 143B
-	uint8_t bright_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL]; // 163B
-	uint8_t dark_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 183B
-	uint8_t hybrid_factor[NUM_AGGR_LEVEL];                   // 203B
-	uint8_t contrast_factor[NUM_AGGR_LEVEL];                 // 207B
-	uint8_t deviation_gain[NUM_AGGR_LEVEL];                  // 211B
-	uint8_t min_knee[NUM_AGGR_LEVEL];                        // 215B
-	uint8_t max_knee[NUM_AGGR_LEVEL];                        // 219B
-	uint8_t iir_curve[NUM_AMBI_LEVEL];                       // 223B
-	uint8_t pad3[3];                                         // 228B
+	uint16_t backlight_thresholds[NUM_BL_CURVE_SEGS];        // 48B
+	uint16_t backlight_offsets[NUM_BL_CURVE_SEGS];           // 78B
+
+	uint16_t ambient_thresholds_lux[NUM_AMBI_LEVEL];         // 112B
+	uint16_t min_abm_backlight;                              // 122B
+
+	uint8_t min_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 124B
+	uint8_t max_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 144B
+	uint8_t bright_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL]; // 164B
+	uint8_t dark_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 184B
+	uint8_t hybrid_factor[NUM_AGGR_LEVEL];                   // 204B
+	uint8_t contrast_factor[NUM_AGGR_LEVEL];                 // 208B
+	uint8_t deviation_gain[NUM_AGGR_LEVEL];                  // 212B
+	uint8_t min_knee[NUM_AGGR_LEVEL];                        // 216B
+	uint8_t max_knee[NUM_AGGR_LEVEL];                        // 220B
+	uint8_t iir_curve[NUM_AMBI_LEVEL];                       // 224B
+	uint8_t pad3[3];                                         // 229B
+
+	uint16_t blRampReduction[NUM_AGGR_LEVEL];                // 232B
+	uint16_t blRampStart[NUM_AGGR_LEVEL];                    // 240B
 };
 
 struct dmub_cmd_abm_set_pipe_data {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
