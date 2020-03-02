Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489AEC3F2D9
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2046821D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hDizcNk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2046821D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA3766E7D4;
	Mon,  2 Mar 2020 16:48:14 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750088.outbound.protection.outlook.com [40.107.75.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19AC46E7D5
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:48:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNRRhDmZsB2s/URFfXPGmL6qTV54Hp5l3C4i4PuO9pbKhuCOZ7CbND87xvr7VK8jHFuAy9G2LbAMBXlFUxUibMS+YrlM0BZyCfutJe8KCdqFpU00MY1lBvRtiosu73aUnd7XmUXbzspR7GFDRvAFIZCXJDEbaV23bU7YwUiSF+CGBgcBIQnsvfwU23FAyBpvH4109/b5BizFCEyhOkjavqOeGsv8syrXtMf5cA/Iu+uLuNo/1Yp2O3Ngy4AoTY5HePtNATWTO1T4bqJCLp3rQBcHCcHlC5vcowlBDcUzu7FcJvpxEpDvyRobaHt8DINOjc9/zBoeVVYh1WrGXvMDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V2UkVqTGUAp77elHXRDnuZmputCNVKmEehR0Cp3kso=;
 b=i4J0ujy+oSLXd/fg0Tt2yQVzk6Shnq2IXADcNlmItLiH1DHHRDwzw4Y1rBXJhGMjsdqXBvHBzz5NZ33RKo2XlxmvID73jNbMs3XnXPnoNPTZrcjHAYaoHGhsva31M0y3TQjwcj9L8m5UGtpE88131NxWRnF+purpS9gllsbDRpvVw0ZlfHG+7kMEJO9fie65ihNc8swjQx0nRdaepP66c9XwerchazVpQiUxG1ZmZkz2MVQ6IdDSC9/plXzgFAc8zL4eI5dMwVvH+E9sMjqAPuQiENljgO7WDn6xabsokMBIIIflnLgKLTpKN7jTvK0kbVKQh8iRcom0THMRrN3Heg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V2UkVqTGUAp77elHXRDnuZmputCNVKmEehR0Cp3kso=;
 b=hDizcNk3geqyLT7WRfok1su81f6emRGcUqAsZaJThdAvK2Gh1nSLTJq/W4DMgq9gKo9JU/GO7jrMHshSaeIj8N2bc4rjkoERWQoXhO9bZ/sGxPSb3z8Zj2BxIUU6BAkGxHO6KDHQloLy0QJAIXwLWZY7JQwTs8p8YG7I29TLEUo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2411.namprd12.prod.outlook.com (2603:10b6:907:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Mon, 2 Mar
 2020 16:48:12 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:48:12 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/22] drm/amd/display: Fix default logger mask definition
Date: Mon,  2 Mar 2020 11:47:35 -0500
Message-Id: <20200302164736.89429-22-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
References: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:48:09 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce15ee2e-42b0-4ca9-6c03-08d7bec97db9
X-MS-TrafficTypeDiagnostic: MW2PR12MB2411:|MW2PR12MB2411:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24110CD0CD9D2688F713451398E70@MW2PR12MB2411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(66946007)(6916009)(6666004)(54906003)(8676002)(316002)(4326008)(66556008)(478600001)(36756003)(66476007)(8936002)(2616005)(1076003)(956004)(81156014)(186003)(81166006)(16526019)(86362001)(2906002)(52116002)(7696005)(26005)(6486002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2411;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /X91/2zTeb9NvvAE52NAqyNKo99H/j0TZf6yse6kOyYtpsV9EOrWJdae7VeWVTm5114RmIZqyLmihANMo4u51JP92tKiff65McTaM3qDdLYX0HFdifWMfg7ys4CNJ7D7rFsMFLNghN2WeP6rgsUPHAhr8fwh9awX/Kaaleeb4agGGLpsLTj4RbVV4ZM1ECEqMjmj7YRC91hlXb/Qsp5mH6uVnIDLz0Kazc/1vsZ7v3p6NnmTkoSlpiyViF1l0YY/r7fIJ+Q+nVY/fQB04cbB2ND/DfXBWuzUIXALl3QuHoY2kF8hVDMn+ETzYzt1fm/f7uvJf+fVmeE5DB06X8km/WaJnMulOApC0a4RReGm59uTAC8+jbcBQEnA89rBDBtC5RHy5MDaeez/+/CHBvj214MgIiFIhjF11OK2K36isSt/4vD6OGFq6Nii8/7q5UTb
X-MS-Exchange-AntiSpam-MessageData: sWVqDTIY6lwt39WMxT0DejkbHUFXTStwzEr0YK2PkJ4LE8hV/IPOKokrIUYpdnQmaYz4EprDmjmR8HWrQ7lrwmh6mJ/KJpLIAPzwAmyI+x9Q09CCyuAeg7kJdT8jG0FBCEWz3vKCI9K6qiBV6xhU3Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce15ee2e-42b0-4ca9-6c03-08d7bec97db9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:48:10.6280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXZzg3PatkrCuoNsPnaWI3EL47OTlnbhHFWUXjsmAJIIbhF0NXp1X7LhwMoDuGuK3Q4M4rk3ssu4Ra33Ayujcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2411
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Eric Bernstein <eric.bernstein@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

[Why]
Logger mask was updated to uint64_t, however default mask definition was
not updated for unsigned long long

[How]
Update DC_DEFAULT_LOG_MASK to support uint64_t type

Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/include/logger_types.h    | 63 ++++++++++---------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
index 89a709267019..d66f9d8eefb4 100644
--- a/drivers/gpu/drm/amd/display/include/logger_types.h
+++ b/drivers/gpu/drm/amd/display/include/logger_types.h
@@ -124,36 +124,37 @@ enum dc_log_type {
 #define DC_MIN_LOG_MASK ((1 << LOG_ERROR) | \
 		(1 << LOG_DETECTION_EDID_PARSER))
 
-#define DC_DEFAULT_LOG_MASK ((1 << LOG_ERROR) | \
-		(1 << LOG_WARNING) | \
-		(1 << LOG_EVENT_MODE_SET) | \
-		(1 << LOG_EVENT_DETECTION) | \
-		(1 << LOG_EVENT_LINK_TRAINING) | \
-		(1 << LOG_EVENT_LINK_LOSS) | \
-		(1 << LOG_EVENT_UNDERFLOW) | \
-		(1 << LOG_RESOURCE) | \
-		(1 << LOG_FEATURE_OVERRIDE) | \
-		(1 << LOG_DETECTION_EDID_PARSER) | \
-		(1 << LOG_DC) | \
-		(1 << LOG_HW_HOTPLUG) | \
-		(1 << LOG_HW_SET_MODE) | \
-		(1 << LOG_HW_RESUME_S3) | \
-		(1 << LOG_HW_HPD_IRQ) | \
-		(1 << LOG_SYNC) | \
-		(1 << LOG_BANDWIDTH_VALIDATION) | \
-		(1 << LOG_MST) | \
-		(1 << LOG_DETECTION_DP_CAPS) | \
-		(1 << LOG_BACKLIGHT)) | \
-		(1 << LOG_I2C_AUX) | \
-		(1 << LOG_IF_TRACE) | \
-		(1 << LOG_DTN) /* | \
-		(1 << LOG_DEBUG) | \
-		(1 << LOG_BIOS) | \
-		(1 << LOG_SURFACE) | \
-		(1 << LOG_SCALER) | \
-		(1 << LOG_DML) | \
-		(1 << LOG_HW_LINK_TRAINING) | \
-		(1 << LOG_HW_AUDIO)| \
-		(1 << LOG_BANDWIDTH_CALCS)*/
+#define DC_DEFAULT_LOG_MASK ((1ULL << LOG_ERROR) | \
+		(1ULL << LOG_WARNING) | \
+		(1ULL << LOG_EVENT_MODE_SET) | \
+		(1ULL << LOG_EVENT_DETECTION) | \
+		(1ULL << LOG_EVENT_LINK_TRAINING) | \
+		(1ULL << LOG_EVENT_LINK_LOSS) | \
+		(1ULL << LOG_EVENT_UNDERFLOW) | \
+		(1ULL << LOG_RESOURCE) | \
+		(1ULL << LOG_FEATURE_OVERRIDE) | \
+		(1ULL << LOG_DETECTION_EDID_PARSER) | \
+		(1ULL << LOG_DC) | \
+		(1ULL << LOG_HW_HOTPLUG) | \
+		(1ULL << LOG_HW_SET_MODE) | \
+		(1ULL << LOG_HW_RESUME_S3) | \
+		(1ULL << LOG_HW_HPD_IRQ) | \
+		(1ULL << LOG_SYNC) | \
+		(1ULL << LOG_BANDWIDTH_VALIDATION) | \
+		(1ULL << LOG_MST) | \
+		(1ULL << LOG_DETECTION_DP_CAPS) | \
+		(1ULL << LOG_BACKLIGHT)) | \
+		(1ULL << LOG_I2C_AUX) | \
+		(1ULL << LOG_IF_TRACE) | \
+		(1ULL << LOG_HDMI_FRL) | \
+		(1ULL << LOG_DTN) /* | \
+		(1ULL << LOG_DEBUG) | \
+		(1ULL << LOG_BIOS) | \
+		(1ULL << LOG_SURFACE) | \
+		(1ULL << LOG_SCALER) | \
+		(1ULL << LOG_DML) | \
+		(1ULL << LOG_HW_LINK_TRAINING) | \
+		(1ULL << LOG_HW_AUDIO)| \
+		(1ULL << LOG_BANDWIDTH_CALCS)*/
 
 #endif /* __DAL_LOGGER_TYPES_H__ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
