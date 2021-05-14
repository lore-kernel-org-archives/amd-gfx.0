Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF48C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D1661184
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D1661184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0862F6EE02;
	Fri, 14 May 2021 04:51:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 885866EE02
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:51:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfjvBmdTo6BbIIUZYYmvw8gNGjpkpgkbZWH3D/xqaxZbg75/YsXh4Ndc8BcGoXoayLdZ5fsrfJoxZergHF1tJzpjOiMqvdg+QGY67IqUS0dgmA3swK9A0WDTQw0r7uKtKPbg4YwFXT5LOOwz+WQoA9MUN8KsFh/+y03pcnS16L7zWNW2kOOPCG+iZnhr5YaZUEStT/VU0/IgS//2MkYpIfBHLXB9mFvFejxF2TCj97HcgS/OoBPNCfvpl7QtX/+8QUiihDc2cuqQYyqV1eriyGEbck2BLQKiAvFqD7Wx4pGJlbCspGypqKDKVDI3ajGt1fyHbfIIH56Pd1WGwCJ4eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC1sSdSz/q6rPHpd0ira7BVTLTgRUeNBZQKuTM+ptpg=;
 b=oL24QLl4fCRYB8haFfQHNHcEzim7ywsQ5cQmYfRDvGPwaYRztEC06c+tCxeexqurZhnIxe0SCJJI5PmWnNWEQTYOyIHTL//x0rCbfX0mw3ykbDvKuzc3elFfXqlsp3FOgvRnTphrpm12nViIkp9mU6mqS6sSNfrXzDE7ImSRO0tWrbA3vazLa9bIH9QEmHzaixKlysrFD8LG5tPijApi3Vn5ICB+yn8Lh/qq6yQG+QRHs9yLf2Uxwjr7B+nxM8xMY5c5KmfshL9aeBrQYKFRVh+XqqqJGNnCF0wfq5mCafNH6dpVwGX+3diBvmAuSoWtuj5H2w/CoGWiOWx/DT1p1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC1sSdSz/q6rPHpd0ira7BVTLTgRUeNBZQKuTM+ptpg=;
 b=Bl6MbGAMW1MvekHuI1IV856q/XjejjTYaMhjYdXr2E9WpDMDvq14AumB8t0zMv8cnhQVmhJ8E+Tjawv6ZHkTO83SeCL3DBr8obC4+Ldgq2TL7gBn3SKaz08w8QiQ5a2wPkkDPjIb0sbwVkqyhp0sVCRtVtAlaoVkUWS2f9UmVcI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 04:51:27 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:51:27 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/20] drm/amd/display: Use the correct max downscaling value
 for DCN3.x family
Date: Fri, 14 May 2021 12:50:00 +0800
Message-Id: <20210514045003.3069681-18-stylon.wang@amd.com>
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
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:51:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53f4ea4a-c24d-49d8-ae54-08d91693eee0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3129039FDCD1A9A43390B24BFF509@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrxO5VjKbscYkIycD6uIeMsCCxxLfEBaJLmiWZqrNqeS6eE9oOnjJB2nqAEnfkMHGPmH4Hb8Es80ROE3IyewV9gE9P40eXYf1v5iV2xRqIvekJK1yv+xgjpCoJvdGgoVbRgU3g/NI7ROIe5KZkfNGRRLPDQEn954lY8MZu1JvN70CpCTBSxQyp0A6klR67JtYsilV7Is0DvhTA8VKZfuzW9o8M8rTu0AwesrBdHN4gH2YlwDi3lYXG5Cfdj/r78xtbZdSDM9zVaL9GYRmiOL7W7gvNFvtvj9QgJ+Ihry1swOEWD5l5c9pQKxD1R5X8TmFg067yK6yNa09PL4Kg6zvuTmvW/80FHcnRROdy1r5cPUOFlDgeEDpFTRCJZa1ZPhUSsy/COVRh1t9YGjyWFYP3SmzMZD1L/xNZdafrPmpn6Pa7yByZXY2DlNPk1+sp20J5MgNuQyHocQaassZH0+IGSmUTxLyVLAcWK8mqd1cMMiFN8P+kVSRPLnZoL/mP93n9ljxVpSsQhEku5iBihEU21FtslYz4kvEQiB56L4EKmdyav7Cq8FkMQEEgdOSlQYzSC0Bpj4ATIBraqdwj6ODMNC2N8k1vTZoQnTWTjaEfbIm7dGtLI2rfZl4l+xy3zU3XYI14qMWr+OiIAo9L3r2npTONft5T4ulCz5iBCZtr4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(8676002)(316002)(478600001)(83380400001)(26005)(956004)(86362001)(54906003)(7696005)(4326008)(38350700002)(2616005)(6916009)(1076003)(44832011)(38100700002)(186003)(66556008)(66476007)(66946007)(16526019)(6486002)(6666004)(8936002)(52116002)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1X+S8Tb+k55Lfxragj0frltSY22DW3DJETp0y6fcxWzFYuj35GOYhCq5SlOM?=
 =?us-ascii?Q?F20qO4JUWaS37sCCXpciMr4ln3SvaswJTdss0kgzIg4x1GJVOTcqBxz2Y3Su?=
 =?us-ascii?Q?oCIR/GGhnpObFc3g7MBbNTU8Jhq2u03GO+sq3C0thhtMw5B7AUcaDxXl3+Iu?=
 =?us-ascii?Q?cHw9n1XesTmHGLK6Sjz/kaw9ZR3wNn1L+gpuv0pUSmY83HNqBwncVKd0WMVE?=
 =?us-ascii?Q?WqdQMzGoBcgMtHC7SmCGkvDsUWpdMdyqLONqyfqR22eq8iv9zhBKQ3gOJ94T?=
 =?us-ascii?Q?IOgLPCZfFzELaTZQ/Mzd9zjMyD7DZhpHwfFek4jxPcdeMCt/HEdbYegk6Jks?=
 =?us-ascii?Q?zrfcvniHQGUL3+Vo5qikXwIZ21llMreub21qOdsnmzrpN58hIXw2mhghuVG7?=
 =?us-ascii?Q?Hys1hDprbYQpftxCSHZyuqB205cpv0X6q5IPc7xW+cGt3qD2Z/8iTpOBliWp?=
 =?us-ascii?Q?kL9qnqrchKnmogKcL1FHZo6DKnroo83+q+GeXXoFdhVWpY4hnOk+R1d+wRRg?=
 =?us-ascii?Q?ZN00xSHPLRccPdd0ZWnKzHn8PjfJfC6OaPNvhmOtq1tKjCy9ONyl6xaG96fe?=
 =?us-ascii?Q?+xY+UrVsO80cTO1HnOpPP6v8YbcRY6j2zBfMyGvQUXWUe1qgwmQlY1MwLCjC?=
 =?us-ascii?Q?JnoBT+bfnTjPzsaFaav1+iXMjuwNTmbkBbbRl5kJvuFDj/NjJwv5XUCCQ/hl?=
 =?us-ascii?Q?icANUiaIeBPyIt/HLhzDDGskqTe/aXjWTn/a8A2EQpyP5AOIr3VywfpXhyGH?=
 =?us-ascii?Q?q6DXbt/nyfLMoHUBO3m4iR2w59u455pdaIu32+M63AOmg6neZLYrtGkuIkGS?=
 =?us-ascii?Q?k8F43cPfACEYn0jZlhmCbyY8DqeQgX/+1lXDau2eEwM2fFOwy8dl1J3Rm3Vq?=
 =?us-ascii?Q?iUyfv4btF7xrKF0rN4Cuea7WPRbDrBsE9SLDSGFlcuk1DSziYp0YA8ncKUTx?=
 =?us-ascii?Q?nbrIUyUYFohMe6WbuAYON/Jhqnb12SLY5R5GV/ADod72N19mGPoclSFmFDu5?=
 =?us-ascii?Q?a7CU+v+mBzwotlSZmxHVDrbj4sBoKm3u4NJ+8YcMUrpk9SgJUaLW767zcw0g?=
 =?us-ascii?Q?LUMJyJmUe+r2TP9txRa9neTqqhZi19krUVuh2/pnRSiGZtjh3TcRqeiqbfBj?=
 =?us-ascii?Q?vRwZvS0RvLneF+Iiysd4SOahcccNFVL5dlHixZculSZtSELFCwZaLwj5Idte?=
 =?us-ascii?Q?knfiwAxGtxvavN/9bX8XEeSKW69NQzqCdezAAAggCyRDk1TrH6YX9I0rkfVx?=
 =?us-ascii?Q?qSuDFJVFBUxblG93mUHTmSSZu4oOYaMoATP/7b7WDm5ga5Cvt54Y0Vbgwnz/?=
 =?us-ascii?Q?QxsC/+6VjfUCyNaU1xzG0ZpKZ9jnzJOQY0ix7AnNS3NdCw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f4ea4a-c24d-49d8-ae54-08d91693eee0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:51:27.4980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuS/6FxcqXq9wh3rxV+v631Kq17fRLN3EZfJiJ2Ij24rDyhxaLI7en08JzSTsj1iEbSm3t9VBdKyNp8O698MAA==
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
Cc: Stylon Wang <stylon.wang@amd.com>, Charlene Liu <Charlene.Liu@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Nikola Cornij <nikola.cornij@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nikola Cornij <nikola.cornij@amd.com>

[why]
As per spec, DCN3.x can do 6:1 downscaling and DCN2.x can do 4:1. The
max downscaling limit value for DCN2.x is 250, which means it's
calculated as 1000 / 4 = 250. For DCN3.x this then gives 1000 / 6 = 167.

[how]
Set maximum downscaling limit to 167 for DCN3.x

Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 7 ++++---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 7 ++++---
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 7 ++++---
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 45f96221a094..9109e2433965 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -826,10 +826,11 @@ static const struct dc_plane_cap plane_cap = {
 			.fp16 = 16000
 	},
 
+	/* 6:1 downscaling ratio: 1000/6 = 166.666 */
 	.max_downscale_factor = {
-			.argb8888 = 600,
-			.nv12 = 600,
-			.fp16 = 600
+			.argb8888 = 167,
+			.nv12 = 167,
+			.fp16 = 167
 	}
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 2127399cf464..63b09c1124c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -843,10 +843,11 @@ static const struct dc_plane_cap plane_cap = {
 			.fp16 = 16000
 	},
 
+	/* 6:1 downscaling ratio: 1000/6 = 166.666 */
 	.max_downscale_factor = {
-			.argb8888 = 600,
-			.nv12 = 600,
-			.fp16 = 600
+			.argb8888 = 167,
+			.nv12 = 167,
+			.fp16 = 167 
 	},
 	64,
 	64
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index fc2dea243d1b..a33f0365329b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -284,10 +284,11 @@ static const struct dc_plane_cap plane_cap = {
 				.nv12 = 16000,
 				.fp16 = 16000
 		},
+		/* 6:1 downscaling ratio: 1000/6 = 166.666 */
 		.max_downscale_factor = {
-				.argb8888 = 600,
-				.nv12 = 600,
-				.fp16 = 600
+				.argb8888 = 167,
+				.nv12 = 167,
+				.fp16 = 167
 		},
 		16,
 		16
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
