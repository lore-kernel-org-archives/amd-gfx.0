Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56657C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 179E461184
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179E461184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE5A6E203;
	Fri, 14 May 2021 04:50:51 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56EBE6E203
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:50:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6KDmeKDs9eZpimtKod60dH00sFMdOVGTTjFWMsFh661IS4mPVuJlJgkeXmcDaIrGoYqLX7an2CdX4QzGy/zPFPNdGBNDRWrO8vx6C04Ri9kNrckb+22lhXlm6BVFQrO2wnkfRclqwxfwEvXipDLOjgZGWD1AL6n57mfpr1gX6rk5S9RXqOyMFX65aJ0UabKP+i3y0cEucvH5prQo0s5ZE3fBGSbJCzyzaU85eeWz6GUEHH1xXqBB0A978RmJiOyiNcnWwj5OVZK31U2MNmlc3DXWkKD0Y9yZe+n7KfyD9Kek8NX6C4pmYuKvGiKjqurt5J56Igv6jqyEpab2dQg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNNBwiqpHTzsnRzXK32Ns+FmBVKKn10HlWzbW3UzrqY=;
 b=fDT7aWC8LCFfdWw9WqsG2BhO9QZLkhvlHRd17enkMUvvjqDoAXcAw9btptu1u1RFAPda2e5RBWIbsVFzBm70/lmN5fn3+6fx0Z+EEXGiwQGT7NMToenOf3ChZs/tgXcvv4NY69UUKEVX9Z5tyhzab9kcVOFxs21lKFrZ429K1Cl+yTuwVAOJidGd6FXhj7VUESDkyA3hUT2NKJPd+XZEETYHnZcF7IHL+Q0n+EWwhmkeuDZCfh+VNhxFlJRnTaNEbO5v5IVPIV/x+P7u+3KmD79Syu8/byCToB9IERjjya9D/SRI4QRKozSZa27iHfHsXkzd3WRxLPi63HWI8AYn4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNNBwiqpHTzsnRzXK32Ns+FmBVKKn10HlWzbW3UzrqY=;
 b=jTgM41vX+/n1CZKXKNyMUbKDmcLLLj8B6cRMLfAcD1sQ7Y5aOvqAGlmxethODT4RIh3RBGEM5xu1h9o4AZrbSYnyQW0m5aKmVAKf60f8SE2eitgd6jaJ7s6lEH/BwCEVAeLegoxtaOckS2HDXArQA+GI7u8TIPH03o53ICAfpXw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 04:50:49 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:50:49 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/20] drm/amd/display: Document set RECOUT operation
Date: Fri, 14 May 2021 12:49:49 +0800
Message-Id: <20210514045003.3069681-7-stylon.wang@amd.com>
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
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:50:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31aac8ef-d4bf-4727-5aab-08d91693d7cf
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31293709C3E6CBB8A2B61FFFFF509@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1/mlgg72p/kByPa9Ajzh+N1JCAHVDKwaG1NaaSeBKBv8RRz2rrL5JBIulY1UyYETj+JjVKs6FgzLiHJ8pXjoHM2khLKdB8W0fG9aHqfj5JDmz/YYJ1GaTdnCeDyHCb3NZPIdBQCpAp9UDbGupTr5cjTFv4gXy26QswfbbvDSWnQOxZd3+GOPnQTQHhs6+tMcUl0KCcXv5RuKC+RpzDE8jFRT0EQ4z/t2gNIp8CD26XByFxF0yybTuwk4dnRC8+iW0VMUU/VGaVtrBfBwXnw8cpvBZVcveQLj3FLhxqwpkcidP2FjJwZBe5p7lr29uPkbTbLQ1ip/AjFFivx+WdnGsZdo13n58xkCGWo3KT0aEdwBfz/n+4zOfM/Nufl4B/6ajhVEiqPgj4is9cOjw70PC+OgBfZZRDhGGzyY2xqnNsgg6kbgYJAMlQ0/N8J0zW80rHLN0DxZ6GC7V+vhRYfEvdU00iezSp307cgjNZ0xYq05LMIK2NittYRDigGl4oQayA8CyFI9HZBxISoykqI+o9ZLyfD42q/cY6JZqqJCSsm0Pg3vQK/E1ZeGyJRKCxvhVqcbYfS92xhULQP+78l00EcuqDrFL1wD3H9WoqtdUAoYQe60zfBayH2r5roKgkt3B4kwQziaQ2qbTUQdmBVV7kNuekrET3+y0+YoHpkaoo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(8676002)(316002)(478600001)(83380400001)(26005)(956004)(86362001)(7696005)(4326008)(38350700002)(2616005)(6916009)(1076003)(44832011)(38100700002)(186003)(66556008)(66476007)(66946007)(16526019)(6486002)(8936002)(52116002)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?U/8AsmZEkSdNwOfFLaQQoqIm541SWHEmBInwFh4xDOvpU4YrVNlai/gOFTzW?=
 =?us-ascii?Q?kSQnT7n0PfHQZURGv8arns+HeTNUB3vvqmj42TzYUAYXouZ26PxFjBj9PnJ5?=
 =?us-ascii?Q?4sDdcuGydZodOI376mIHmy5pafdk1jzFxANH0ARWsAlGe0S6YXIwfmxB+09Z?=
 =?us-ascii?Q?vO5G0og+ihYsFTOn3sQcMXUzAhrLMuXJmTaPofLW1VwkepTVsFG9eckR97jz?=
 =?us-ascii?Q?W39s9VWeEVHUqBeShaLEGEfFBq3i0RQf6ttpzYcpt2bd6egctiiYvC8wccmS?=
 =?us-ascii?Q?yscPgGRzAa3XG0zHAknujwHSQrZN6d+YlbEohN8SR+l3rQ33VA2NxkllrXKX?=
 =?us-ascii?Q?UPESpbugO3hEDnTvU/CmFVxHrBq+PwXbMbJKOnU0x7XWFvU4oaxoFEa+9y81?=
 =?us-ascii?Q?qjPLFJCIMrsg2Nz7CO3r3cL6OcGmQLE0DnQAUKRTo1cUn3RrW7CxG0SRLB1v?=
 =?us-ascii?Q?o+cQfZCRHoch/L5v1P7a7qUHrurxwvhULDLSKlfjz5KDPOvR8xAyz3DKafhH?=
 =?us-ascii?Q?EH/6Ydz6YuR4YgZzaEQJkOA+qmi/57yyTkCck5dzBWIVPIVFifVvAhEhAmBC?=
 =?us-ascii?Q?5k5AXCoavbNpawGnPWuHJ3KCIGjjEYal3NvMc6R2rHWPuRwSjiVdVVIJNYyK?=
 =?us-ascii?Q?CDXUW/cQ5ovgcuw7LoWXQw3PX7+e6pjyVzutwj94qG4UdiCCDvFTVepUSWe9?=
 =?us-ascii?Q?XumLSVhyOSSLbs2EdAhqL0SrXYZVerJBhuRr/R5xGysSB9fgvfSGzn3TTc33?=
 =?us-ascii?Q?P9MkushpbD2p85fhYwOGghXxQ6AimR9Io971NuUUhjny8xEf0St7ovoIIzXD?=
 =?us-ascii?Q?/JeUc77uIetPZ6V18xaqWR1lyoUOAAEmzkFOYUUuDPTJbK+mrYN6tuj2cpLP?=
 =?us-ascii?Q?rj+0QKM4o14pC/Vpbd6v2nsef+8JlfUncRN3kASL1mSmS+p+11ebQMscROBM?=
 =?us-ascii?Q?HovPwzXGeaiu0zl28yiK5oKROm8gClTBxeXwAFXWCp4JW/9s3p4rpdhf8yyV?=
 =?us-ascii?Q?8Y5vOJWpo9iA6uQeBASMW0wsZ/aczCsJucz6eaam+D+N3HaAFLC63rGXgRlD?=
 =?us-ascii?Q?rL7l08nsXiK8g3FvRZ7iRjsI+HyDTeZN1QOMDIOBcTMsQYHd4CENyVwUUK2e?=
 =?us-ascii?Q?rm3Wbq2xz7ZAH2iY9Znm0Sr1So6rz/8p0EVSEI3i5h1+RBRuDnVIVxWkhaDL?=
 =?us-ascii?Q?AFrji5EEDUe+OjuiL1ImzldDaQw1ukCVTpist5p2YaUvyU4JpxhDV3O8Gq2R?=
 =?us-ascii?Q?HqOAXf41r+H0QGNavleOAHpkZbTAQLhEbeLJkG5kjvOaOWigrN59CCHZv/I3?=
 =?us-ascii?Q?pWYFqnGjYzTfCsJ6NZ4woAKu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31aac8ef-d4bf-4727-5aab-08d91693d7cf
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:50:48.8489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQYh1Bua87IiNsJahjmOZWUQgujHQVc8TaxkjV0Rl1KvdcssdtkYGy28GND3Gb3dSTL7NpfIIjFDMKFgRHgmew==
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
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

During the investigation on how to add visual confirmation on top of the
planes used by DCN, it becomes evident that the lack of information in
the code makes this work unnecessarily complicated. This commit
introduces a set of documentation related to the RECOUT operation in
order to make it easy for developers to navigate this set of functions.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c | 49 +++++++++++++------
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  6 +++
 2 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
index 98ab4b776924..0bd8de4c73a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
@@ -653,33 +653,50 @@ static void dpp1_dscl_set_manual_ratio_init(
 	}
 }
 
-
-
-static void dpp1_dscl_set_recout(
-			struct dcn10_dpp *dpp, const struct rect *recout)
+/**
+ * dpp1_dscl_set_recout - Set the first pixel of RECOUT in the OTG active area
+ *
+ * @dpp: DPP data struct
+ * @recount: Rectangle information
+ *
+ * This function sets the MPC RECOUT_START and RECOUT_SIZE registers based on
+ * the values specified in the recount parameter.
+ *
+ * Note: This function only have effect if AutoCal is disabled.
+ */
+static void dpp1_dscl_set_recout(struct dcn10_dpp *dpp,
+				 const struct rect *recout)
 {
 	int visual_confirm_on = 0;
 	if (dpp->base.ctx->dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE)
 		visual_confirm_on = 1;
 
 	REG_SET_2(RECOUT_START, 0,
-		/* First pixel of RECOUT */
-			 RECOUT_START_X, recout->x,
-		/* First line of RECOUT */
-			 RECOUT_START_Y, recout->y);
+		  /* First pixel of RECOUT in the active OTG area */
+		  RECOUT_START_X, recout->x,
+		  /* First line of RECOUT in the active OTG area */
+		  RECOUT_START_Y, recout->y);
 
 	REG_SET_2(RECOUT_SIZE, 0,
-		/* Number of RECOUT horizontal pixels */
-			 RECOUT_WIDTH, recout->width,
-		/* Number of RECOUT vertical lines */
-			 RECOUT_HEIGHT, recout->height
+		  /* Number of RECOUT horizontal pixels */
+		  RECOUT_WIDTH, recout->width,
+		  /* Number of RECOUT vertical lines */
+		  RECOUT_HEIGHT, recout->height
 			 - visual_confirm_on * 2 * (dpp->base.inst + 1));
 }
 
-/* Main function to program scaler and line buffer in manual scaling mode */
-void dpp1_dscl_set_scaler_manual_scale(
-	struct dpp *dpp_base,
-	const struct scaler_data *scl_data)
+/**
+ * dpp1_dscl_set_scaler_manual_scale - Manually program scaler and line buffer
+ *
+ * @dpp_base: High level DPP struct
+ * @scl_data: scalaer_data info
+ *
+ * This is the primary function to program scaler and line buffer in manual
+ * scaling mode. To execute the required operations for manual scale, we need
+ * to disable AutoCal first.
+ */
+void dpp1_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
+				       const struct scaler_data *scl_data)
 {
 	enum lb_memory_config lb_config;
 	struct dcn10_dpp *dpp = TO_DCN10_DPP(dpp_base);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index ddbe4bb52724..00fc81431b43 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -32,6 +32,12 @@
 struct dpp {
 	const struct dpp_funcs *funcs;
 	struct dc_context *ctx;
+	/**
+	 * @inst:
+	 *
+	 * inst stands for "instance," and it is an id number that references a
+	 * specific DPP.
+	 */
 	int inst;
 	struct dpp_caps *caps;
 	struct pwl_params regamma_params;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
