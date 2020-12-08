Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9171FC1B0E3
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A18323B86
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A18323B86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9FA06E9C3;
	Tue,  8 Dec 2020 19:29:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DDE36E9C1
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 19:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyFJ+jNT8OHarw1JUsC5iYu24GWgyALSKz752qgQsFHNzk8luOdMy/mbX1qWUZ7VDt3TSQmvj7VHD8D4OCuRJD3C5IB5yVrnWS2pBqq3TZNhhByYwx9EAR5SaG6+z0MJdIfC6MuGeximqfASBXBTlKd8KlvhqxtrtTfUHm2rLfzuEiqWkTSq+XVxC6aQjw3zjjBMWUgsp6e+vI4f4ffTqMzRBMvk+KV6mIqA0YX1cCdF3NBucv+B0gWgt4JgGz4QW2ST2Uhg0yQw7gAsSJOQgewXYUcSfZAC6vJ3KyMe6uirFE6yCQQbIGQNSKoZsQZEP26kbSNUNBYN4GJgn/fsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23ufN3c3WVpBvdhV/krDEidBYD52bnWWNhUaKliAHK0=;
 b=iNlyiSkCZ//b38joqXkHARYE4qEZwlAd/OBUw6xfFmL3/O4bnIUh9WNYO9IlvCcUjj2ANMq/I2OC/fvzKhzxHXJz07YJUYyNYPznpaznDSB/ax6i+hUJpZ9v8gmNBkz1ZxQokJ2DVfkpOtqKmfYvt50Fr+bHRRMsUkwK6YeVhD0tONRirUxL51EZvBKUQ/9tTq0ZjiO1FEZKIeX0eqQDdHNQ5Ygz1oCQrWt/DPDFnDQxRe86cfeMw09gh9OTf2K1xUTFkEPeqroEQW5Ck7xinplTEKHWri5zn5lc0CNThk2F+ZU8jN5lPqwgSdtLZ0mwFGklhZuQSpmCi4kFj+P3wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23ufN3c3WVpBvdhV/krDEidBYD52bnWWNhUaKliAHK0=;
 b=QVtV1ArcNFCfZ2p63HjbcHZy21YEgFztklJxwRq+oUOTdhSfy1BSBVuRDwsEd98DB2nL8mPs/8Kh3BY1lowbAIyuGfpO+TUsrRf4OWUrdIQVyOdQ174VBy6GlKdxSAl9Ful5y6XOIlb5FfmrZ0t1W2w6Gsnb1gs4BQ6Gb4oIiz8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Tue, 8 Dec
 2020 19:29:03 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853%6]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 19:29:03 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/13] drm/amd/display: Fix OGAM LUT calculation precision
Date: Tue,  8 Dec 2020 14:28:41 -0500
Message-Id: <20201208192844.23580-11-qingqing.zhuo@amd.com>
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
 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 19:29:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b0695e7-a224-4079-96b9-08d89baf85ab
X-MS-TrafficTypeDiagnostic: DM6PR12MB4338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4338D9AD675F99E3B345CE55FBCD0@DM6PR12MB4338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pfRRjoMfHNvS/UIocwirsJ92TZOoRzeBJxpPBhB/iX3CIYsYGsxPte8OElwMO48KyKeW28gzBVsdt4BkGJaait2BV7fM6lpwrxjUcngSWIXQjxrI6atl1prt3J6plQL87vSZRkcF8LSorNRNNr4RWSOsWYTsByC+iefM4Ma631JS4vLyPEmR/Lo4WwXq0OHVkk07i/rY/g9wPnCF24TOr05pXSTpgbxwLVyhoxuc9i2je+tYHq6xcs4hIGmhTw7uqv/w8Nu3fNFiD5KjU2HuryLI3V0hHJwrVT6tc2X3L19jznhhQPYwm7WrmK070Cm/LDqVjSPDVmZWhRRdj0xAAseC8R59b4Ig5Xfzcn0nehEvd0iKMQQx5o4h5LE9PDuQjOIddDYqSZLVGtGOt8evX69+hfsMINSAa+fh7Nz4cIY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(956004)(8936002)(44832011)(1076003)(36756003)(6512007)(69590400008)(16526019)(4326008)(34490700003)(83380400001)(66946007)(2906002)(6506007)(26005)(6666004)(5660300002)(186003)(8676002)(66556008)(52116002)(6916009)(2616005)(6486002)(66476007)(508600001)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PM7oDZ0Uvl19Zw7Up/jTIaCKIjRRMcdog528skgmZuKaVLP7ZiY/rtHhMWo2?=
 =?us-ascii?Q?eaNC30zVW3AJ6B+pWtJbU5yn3rP3pUfSq2mumw6ueWLFMQ2dHnDf29AtnFEh?=
 =?us-ascii?Q?/TqanXcwNEy+by7lgTq4OtCPOzDP3kCdOt/gcRMQGXmx+4GnvfxVgUa1Uekn?=
 =?us-ascii?Q?wqcHGML9XFrnBf1SD+8hvf4fEmToX5PgasODBAKMRyyletIbTOGZIax89Oi+?=
 =?us-ascii?Q?C162VoThMtf+oDSkSkypLyrk4aMN8ryfgUCUX5EDzK1TNuYraKj5GtiFxjTr?=
 =?us-ascii?Q?LJck09qCJZ3XbbH9cn//F76mrmx+wy1ZO4kJ+dOQD94Fix4dUbDRq3WujJFL?=
 =?us-ascii?Q?ugEsen97JzK0bt4UAv2xVEr1PVfkIhVDfuau++eC9GCkz5f602RlONux3JKW?=
 =?us-ascii?Q?Dw8KEr13ZHIw2fTGHCBLZL8q6o7biKfFJrofMZz/62NtjkFJmLVLiuhq28ka?=
 =?us-ascii?Q?l8pQ2NPzlSkNHjijxFrqYYX7jLA37RzrYOnIXJMRH21M+dfFeyOVUvJyuv1z?=
 =?us-ascii?Q?pSBN+mslmNZVndubegWLohUk2TmdN38Jo1kuyFU5ydq+hqvHZFeIF2KX3f5I?=
 =?us-ascii?Q?ulVyQ+aoWwnHnptKlGRVXc57KfQ/xk4DRJjx+qrwWgT7Vn3ktHeUr4RR0tzA?=
 =?us-ascii?Q?SEbewIPhSsjAXRuA/zsYgEqXPEbpbj2TGBJ+KyArkNxTpQVqa6pAihJlAw2W?=
 =?us-ascii?Q?sNGmX4ep1FzpWAVAVl5j2b30WuSnF9Wdr6cKwVzrQkMzhCxYAWDqOzYr5uTz?=
 =?us-ascii?Q?FJRuoRA9g/SmWZTBIs7xjVa+NjSOAV23+BEyYsaoivAQIQ8smB8PHjFiC6mv?=
 =?us-ascii?Q?W6z0yDAmh+vOZXMYZh+/hreu2a90EqdraOX+rG6gcqYqdQ9Lau6hj4KuSJkq?=
 =?us-ascii?Q?qRqQEUT0QgpmhF/jkBpbIkt+CQiltN3kXx48jFNt5sMx+eQSsLEUV1hOcT4r?=
 =?us-ascii?Q?CwuhphOUuEmLSlS235QXryQKSWj8wpf1teByO9po+BO/cQU4v4ZqASOPHGqa?=
 =?us-ascii?Q?3Gs4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 19:29:03.2484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0695e7-a224-4079-96b9-08d89baf85ab
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gh7Sn/MIdlEtESZ5j5XiL8DlqdtgeS3o8FH8agIcYisvHbFvEsUan+R3gJR02daP
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
Cc: Felipe <Felipe.Clark@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Felipe <Felipe.Clark@amd.com>

[Why]
The OGAM LUT precision was accumulating too much error
in the higher end.

[How]
Instead of calculating all points of the LUT in relation
to the previous ones, perform a full calculation in one
of the intermediate segments to stop error propagation.

Signed-off-by: Felipe Clark <Felipe.Clark@amd.com>
Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../amd/display/modules/color/color_gamma.c   | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index eced40a2fce4..5c67e12b2e55 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -30,6 +30,14 @@
 #include "opp.h"
 #include "color_gamma.h"
 
+/* When calculating LUT values the first region and at least one subsequent
+ * region are calculated with full precision. These defines are a demarcation
+ * of where the second region starts and ends.
+ * These are hardcoded values to avoid recalculating them in loops.
+ */
+#define PRECISE_LUT_REGION_START 224
+#define PRECISE_LUT_REGION_END 239
+
 static struct hw_x_point coordinates_x[MAX_HW_POINTS + 2];
 
 // these are helpers for calculations to reduce stack usage
@@ -346,7 +354,13 @@ static struct fixed31_32 translate_from_linear_space(
 					dc_fixpt_recip(args->gamma));
 		}
 		scratch_1 = dc_fixpt_add(one, args->a3);
-		if (cal_buffer->buffer_index < 16)
+		/* In the first region (first 16 points) and in the
+		 * region delimited by START/END we calculate with
+		 * full precision to avoid error accumulation. 
+		 */
+		if ((cal_buffer->buffer_index >= PRECISE_LUT_REGION_START &&
+			cal_buffer->buffer_index <= PRECISE_LUT_REGION_END) ||
+			(cal_buffer->buffer_index < 16))
 			scratch_2 = dc_fixpt_pow(args->arg,
 					dc_fixpt_recip(args->gamma));
 		else
@@ -397,9 +411,7 @@ static struct fixed31_32 translate_from_linear_space_long(
 					dc_fixpt_recip(args->gamma))),
 					args->a2);
 	else
-		return dc_fixpt_mul(
-			args->arg,
-			args->a1);
+		return dc_fixpt_mul(args->arg, args->a1);
 }
 
 static struct fixed31_32 calculate_gamma22(struct fixed31_32 arg, bool use_eetf, struct calculate_buffer *cal_buffer)
@@ -717,7 +729,6 @@ static struct fixed31_32 calculate_mapped_value(
 		BREAK_TO_DEBUGGER();
 		result = dc_fixpt_zero;
 	} else {
-		BREAK_TO_DEBUGGER();
 		result = dc_fixpt_one;
 	}
 
@@ -976,6 +987,7 @@ static bool build_freesync_hdr(struct pwl_float_data_ex *rgb_regamma,
 		cal_buffer->buffer_index = 0; // see var definition for more info
 	rgb += 32; // first 32 points have problems with fixed point, too small
 	coord_x += 32;
+
 	for (i = 32; i <= hw_points_num; i++) {
 		if (!is_clipped) {
 			if (use_eetf) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
