Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD53C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5887F61184
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5887F61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 179446E209;
	Fri, 14 May 2021 04:50:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E85A16E209
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:50:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9sNJz9I/SoC2qluea8xLKqi9jBTkaHu4Bq+n+y9RYKAq1pG6qD03oDWSCdiM12ZTjSuP2LW3SqUpiPMoySmQT6eV1zrMBkaiBfotrLEYOn5o9YOXCUQalqywnuvZTOmYWatY+eQ6BJOMIBRfx8vLciUq7ZtL9YGEDEAw9tHsR6wnKcbtKt003P2Z9c50Nvzbsu66+c+C6wG6Psvg0PpE5GArci3q1d1bgW4zCGUVrDFRx+cZFMvgZ+mbkqRshfagK/RynEo2TDVmg0wc7djqj6Obygr/Vyh8umsZmkCp3tVxKCCDaw//T4BpPk5dRYtPYb1rFeyvya62Q5wNllt2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIXSgZPboqQKK7Zq+WtDwzdO5d4wwRD7E0MYXNRX18k=;
 b=PyZ8iiwo3jA4f9HI8wTb93BCo+ZTDWeymSOHLwK1miyQP5Z/HY6qrN7IUlGoIPw4sGZnUN26XmuPHAUb8AiTc17DVGsLKz4x57M+rSWO/UTbCvxPTvKqIJrsR+pRWOa9LI0QfzAqu3uGwJGjb5crzX7XLph5oQezVr71OurIUHju7QlhHmbLPZS1II2gxN+PnELp7RKsDkZFW/1KieqVUXWgfFDe2boRZq6P6VVkTc4fQHfmePbxlS/WBkGvSptMoGOEVL/i7k+3PBip8flUPEwWx0EVn6lu47vwXmeTZpQ5KHALJpDVv467T9ksC0IeH6Syj7nHiHn0gl9afhezLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIXSgZPboqQKK7Zq+WtDwzdO5d4wwRD7E0MYXNRX18k=;
 b=s+nX1hcOagNJlwQkkVMMQ3VRi2z4F08cTLJxDRgthpSSdeYn+44lFL9C/vPUjU6lZLR56qsy2Dehhx5v6UTp1teSBnhBqvy5DyFIvVCc0iahh0MgGIG52qWfqXCalNYTwIWP8MA2TxlZd+dXz9MgHkIsf77JMQK1qK6e5Pk1tGY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 04:50:52 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:50:52 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/20] drm/amd/display: Minor refactor of DP PHY test
 automation
Date: Fri, 14 May 2021 12:49:50 +0800
Message-Id: <20210514045003.3069681-8-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514045003.3069681-1-stylon.wang@amd.com>
References: <20210514045003.3069681-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:50:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2e930df-38f4-49ed-4c1c-08d91693d9e9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3129DEC3B5C4D46DBDFDD55AFF509@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bQWevuiZwrI+48YQ5axqIpm847FgyFf53Iaa3To9M8GSfhb3R3qkLA5nIvajM8yUmsNhSNz3M9mDii/ruo7UsXauyoFcXhTJBi5B7nqT50lTW6HojSOx1Hur5sHJ4pSe/bANg1VDm0sjtce1FTZ60/1qZb1kdfPqQQfIGP9AfihXMDDahW9/oIK0JGS23NBHFzPSyqIhLjvvmXU9owAM1KytMJQ9uem/FmuYVighU2THyF0t8S1dOw9E1FL7WVdasONgMvkcvmlNxM1dxTtd8S8jrB0fPZkxV6EkBt/Rsb+5MFXi3o+HwE9TOqS7O7VNshXsOAfmuErukHnY4C2xJa6Ge50aB1tQUHtQU5Oc88uM4cCypdsg/IU7n1WsfbT9Pb8vJNu/kDbMBwpC+e5AAHnxn3WqsAS23sowtUyGuY2XqX7VmMEZ22TjyRmc5ryscICmwSpMZt2gYSOZCtO9z6r4WX19WijatSBKOnFMr0DytUH4cBM1WskDFybr/JHPdomvKIRTouHua2sQNRPWTcyGDXcsHNUmoyAEuqv9sxRqQe/wchUIenN1bJIqkdLxj9w5c8jOxdFXFFyXGzeZblQqHnmbea6BCfubRpetxTyLpZ2o0U4T1xSIGk/Pq27NCd2IAoHD/lAyUpmu+LK/U2sMY8W8CPbF2ofE8UA8s58=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(8676002)(316002)(478600001)(83380400001)(26005)(956004)(86362001)(54906003)(7696005)(4326008)(38350700002)(2616005)(6916009)(1076003)(44832011)(38100700002)(186003)(66556008)(66476007)(66946007)(16526019)(6486002)(6666004)(8936002)(52116002)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?E6hWzMDfZkVmwWQPh3OeQrYLCooI33Bu0p/Cjmbcqdu5szM5mVAvzTlmXXyW?=
 =?us-ascii?Q?mLStBn576AX2zYQVdN7HJCLcRska6dgSnmc6LEVFuqT0WkxKV2qIX7ZnZzrN?=
 =?us-ascii?Q?achZOh7DoBFT4wDlUTpuqBzhkxeMXWf65sGclNKAI184vcS3T+AZELGDkKby?=
 =?us-ascii?Q?G6Camk6WQW+GJYFg2dBHg8eRHpGFBnXTur37M318ILECYyY4srGvjikL/jte?=
 =?us-ascii?Q?dGG+QAQduAaMqpdEo0ZCG8+rv8HttP3bV6gMNCAKXBhs+H8RPB1v+Fk9s/YZ?=
 =?us-ascii?Q?qkYw1L1SokIRV62O72aDV3FWbPEmIBrfkqlgzo2doBgk+B8PhF1ogKtPOxWP?=
 =?us-ascii?Q?OofsgKn85FRoKLSgnWdXsUiw5iHHjwCJla0d55vgpUIdweW68ivXH5QdcZSF?=
 =?us-ascii?Q?BZZcttFbrlymhXgNXxSEVu5DG+Yq4xQRa2nO5qI6tLF3c1nmXdK16uGdyT8X?=
 =?us-ascii?Q?mD+COZzCTdaUTTTGaaTMw00kbLic0x2eYFu9An65wZeLsr/3zhzFpMgdVYyS?=
 =?us-ascii?Q?oSTzZ/a5ej4CGCBhIGIkKoYBQOFPoBBlpk5ZoDB2IW7SUUDGFJHhsoKwVUFS?=
 =?us-ascii?Q?syuF5qIaCwWyI0O9lM0uAo2vK1qG6SHZT5Yp3G4hmEKC7pfm1T4xIqD3Aqzo?=
 =?us-ascii?Q?wcwqJBB6wvnb92o3Z2+LZBDnh5U8pD7Ij5UMe0lIFibOOLeRldLawY/w/fQH?=
 =?us-ascii?Q?qO2+2BNXfLz01eQ1keBMDI0A1lvdYk2TwajRoP69j26pSSVhAjYrKXo7Xyiu?=
 =?us-ascii?Q?CaGSGlVZn00eAFQSmCeFtCAqR+Tvyv1Mtej+9NK128aXQ3km+fKY3rP4Faf5?=
 =?us-ascii?Q?xclQjDNwimUVCTB4B9gqH6mrqDHC2U5zbVBcruwvuW8kk8/axNTH3dSfCwka?=
 =?us-ascii?Q?8LLx3j4QQXwA7WHmYLtPkjV+Mmb4yKzXFh2wgnTrdWOuO3rnYhP4F8J4h0Gn?=
 =?us-ascii?Q?LE7dFZ91b8WJdSbFysmVUhhx/ITTxz6wzcJMomVLQtgEbn64Wf7BiX1jtlEI?=
 =?us-ascii?Q?6KVDWrX/K/bkQ/YV14gDKdwdYzojlTeA6SfN4ZKlQN/1VJX2Z/GUUJus3MN/?=
 =?us-ascii?Q?zf/vHjuqUN40wudYqjd+myI2ZaanKrn2YZzwbo2PK6Umkwk/ZOan43zJ4BF/?=
 =?us-ascii?Q?wEhcd1N7vGmCfxi1aN0uI2jhISb52lp5HIoyEb6AdlMP8auVIjBkPcUwSEdZ?=
 =?us-ascii?Q?73Nt+VjV9DV/9YaBfJYI+SecKwKlKIIzN9Wk2MNZM4tOeLC6aXOhXN4HYrbm?=
 =?us-ascii?Q?NWg61oBwXnt9JSAz3atraaTAK35xqiTQBHVEzQGOGdbYxUbwkuZmLdvsdY3X?=
 =?us-ascii?Q?Yr5iZSD7rPvmPJWun7pbO0hPDq+wRaivfdz4YDj48U1zmw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e930df-38f4-49ed-4c1c-08d91693d9e9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:50:52.4023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/TmiWnI71Uiep7A7lwI0HgMg2L6b2uvZ+A4WL+Nsgix3DcBdBno30JkDLK144tawyJu+wnK0HR/ZaCJyuBArw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, George Shen <george.shen@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Improve readability and maintainability of code.

[How]
Refactor test pattern size calculation out of function
call parameter and store value in variable.

Signed-off-by: George Shen <george.shen@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c    | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index ba4883fca616..69d511717828 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2773,9 +2773,10 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 	union phy_test_pattern dpcd_test_pattern;
 	union lane_adjust dpcd_lane_adjustment[2];
 	unsigned char dpcd_post_cursor_2_adjustment = 0;
-	unsigned char test_80_bit_pattern[
+	unsigned char test_pattern_buffer[
 			(DP_TEST_80BIT_CUSTOM_PATTERN_79_72 -
 			DP_TEST_80BIT_CUSTOM_PATTERN_7_0)+1] = {0};
+	unsigned int test_pattern_size = 0;
 	enum dp_test_pattern test_pattern;
 	struct dc_link_training_settings link_settings;
 	union lane_adjust dpcd_lane_adjust;
@@ -2845,12 +2846,15 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 	break;
 	}
 
-	if (test_pattern == DP_TEST_PATTERN_80BIT_CUSTOM)
+	if (test_pattern == DP_TEST_PATTERN_80BIT_CUSTOM) {
+		test_pattern_size = (DP_TEST_80BIT_CUSTOM_PATTERN_79_72 -
+				DP_TEST_80BIT_CUSTOM_PATTERN_7_0) + 1;
 		core_link_read_dpcd(
 				link,
 				DP_TEST_80BIT_CUSTOM_PATTERN_7_0,
-				test_80_bit_pattern,
-				sizeof(test_80_bit_pattern));
+				test_pattern_buffer,
+				test_pattern_size);
+	}
 
 	/* prepare link training settings */
 	link_settings.link = link->cur_link_settings;
@@ -2888,9 +2892,8 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 		test_pattern,
 		DP_TEST_PATTERN_COLOR_SPACE_UNDEFINED,
 		&link_training_settings,
-		test_80_bit_pattern,
-		(DP_TEST_80BIT_CUSTOM_PATTERN_79_72 -
-		DP_TEST_80BIT_CUSTOM_PATTERN_7_0)+1);
+		test_pattern_buffer,
+		test_pattern_size);
 }
 
 static void dp_test_send_link_test_pattern(struct dc_link *link)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
