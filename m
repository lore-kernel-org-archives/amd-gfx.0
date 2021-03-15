Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B87C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4547564DDF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4547564DDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA7B89DD8;
	Mon, 15 Mar 2021 11:22:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 379DD89DD8
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:22:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HA79O6l2AOtG9hfJ4FY4A9kxiGXvZIo01AtDJfdVIijUlso27YocoC0frlXZlzUUiVc8UTkuNjV+csUI+QZJ/CU/uMYngm+5jETQHAccaZV5FNSjE1vyLEn3DH/AqzqbViKWrCYP20Svt0l7DcLKk9rgQ2S9wfoSf/1X7JPcNe1gnu2Re0NkqDJv8DYUKwNgDUfPHt1R0YlGgnMoMnUtyxMw84QVicwGjFZpoYyYiY03+fJXdVKfIf5gROcxW7OgkVEMYex+qnJkpAZEFobZ1+ymKtgaQCuMWMXrFExFZyK2ipLnV0pko7xpricf5GJ/GF+zXu2quLkcTvZMvwlm0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/fD33BGoIeTW4L99x8o/pzqhLJzZKz/cHzaZ8B3DcY=;
 b=NVOwYiq+hYnV/nFEgnGg903H3Nwz2uTDFJZ8kKDsV3cp/DDV9lm8wX/a/dI0u1TAymnJfMerEM0OGfENQCSXF7RrGQu66gWYAxuSA1t+85gtYRgNX07p1+m/OMi5mUzt4JbErLMt9ebTuq4i8MXprTlwucnkYRH7hOTBhxoTHPxwmqyE/jrjdn0fG0IV0JXvs2sIkt5EwR0bxRHpbgUu4ztOwS36VXi4C3rGMRjHt0qCgyMyglC0wKOJWSVmpzU1AIoizNYIZxPPttvC+zJMCJpvlpHLCZCUQXRgE9nOqJTHiKLPMMpREoATCso/J+yfYLkSE0EcTKyaTce/4U0k/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/fD33BGoIeTW4L99x8o/pzqhLJzZKz/cHzaZ8B3DcY=;
 b=y8iOWnk1j1LSti3Hbzi7XcR02+QeanfZDGJ+FPGboIt+tlA2UAfgNfqQFUakVmb4NS/+/xjaDDYOccZG2hkqLURraotmsiMBt4xhfMegHr1m5XwFRg7+oody0pxRGb/Wh8y/Ytnqvcb55OlZEv7G2oGsLnzIDshnIzhrK8b+0ss=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:22:50 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:22:50 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/23] drm/amd/display: Increase precision for bpp in DSC
 calculations
Date: Mon, 15 Mar 2021 09:39:55 +0800
Message-Id: <20210315014010.16238-9-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210315014010.16238-1-solomon.chiu@amd.com>
References: <20210315014010.16238-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To DM6PR12MB2604.namprd12.prod.outlook.com
 (2603:10b6:5:4d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:22:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d1f94708-80eb-46f5-78cc-08d8e7a4aac4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB46177DB45CE5D43F66403D6B976C9@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCS5NhvHT15eUhJoCw44VCH2M9MA23gKL5q/2wK/uMsy4/rOnThXdvJ/GRJNkPRJkH7u76WGOnjR2FZLKe6o4RJ2GH8ykMa/O3Bs9fPXexBXlVMutIWGxSgqFCBItAQYbLAXmeKCN+Sf1wrEieXky076dZYfiuxVUAszETrEFceT21AlHZ9JMxWu44jDq2FyduFQ8+u6eyUjCJigmD0ekzSRdKlqzLjqAM/t61cQurNovIfJ1wweZU2PX3vnJikFdbk1c4KC/pr3+IL1L15eHD2JsfaJzvWZBXPAbXjn5VBs8S+0HKw6v9ye+Cf7ixXZUxCoPNS0eyFKL/+mkcESLV977kHYjF2secfz6ctzPzAtTJTpxb/sDs9RwvsCotrZ+476Geq6xbnzfEvTZjwDW/5bgoi9nwlOYbJTUQLiW4lAZl/eWmJg2Msg3dKWHyB2VX+Zbhu/MHs5uBtkOtBnqGoAVAnnKh0EUaFD1nnHyewCkXI/mBSZc/8VB62Lyz3m8k/3kPZBU22ZQuF59t+Hur+xvXWvt3zIi1IMzaP0ZJcO5BfGJPg3NRT/GypZ34Rv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(8676002)(6666004)(54906003)(8936002)(52116002)(4744005)(4326008)(86362001)(5660300002)(316002)(186003)(16526019)(26005)(2616005)(2906002)(6486002)(6512007)(66946007)(66556008)(36756003)(6916009)(956004)(44832011)(66476007)(6506007)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Faww4N6CjH2fndo7Y9aQdrtnHL/FLRz7BgcDNXyfLLCzrI4sL7x9DNzl8fah?=
 =?us-ascii?Q?C5jBPVgtytbReXb3mxON+BAeZFIkLpkwVW3XLOMvNJK9OtA0aAGmf8JxTmdW?=
 =?us-ascii?Q?c91Cr1tM9i6gALc9UEnibGJ7lj45xmx53z284V1+so7MwaIj4LXO3LhmXcpZ?=
 =?us-ascii?Q?9gKZcdZnqqI6W0e5VKYXg0OJruZBFl0ARnXGArowri0Ae3H3g7lX4Z+4neud?=
 =?us-ascii?Q?AMt9Tp3KgacsAXZK6tK81o8cg+G+Iec3hyprUX/Ux9X+rtx4VVuAq1nj1pEi?=
 =?us-ascii?Q?mE0p7tERCqAqnNb4cU+6tSbuP6FydPkQV4iW7WDWInCZkRxqo9QcCJr26hc+?=
 =?us-ascii?Q?ftOyY4CryYATcuBR9Dpra5pQv5Yx/B3y+FCN81rLYiKGMPdsBoqkpz/sBdsZ?=
 =?us-ascii?Q?gxN7TPBRmcj6Z8HYbXSvB84L9pd6UzHXN8I2cMi2iI7g4qVRYPw7nKurskFo?=
 =?us-ascii?Q?kos/d6eDkRW3TH3RrSPM4HsEX2vKkg88cmCOWOnbFiSx5pRogSxUzzEivdCQ?=
 =?us-ascii?Q?9wKBSQwulgdW1PX0XXMlp22fkA+D9J7YbUpuNjzzSy1nDAq9Q1mhT7OFOuub?=
 =?us-ascii?Q?DkS+W/jXK37VudjoAf5PvkUZ0aGjCSAl90YOvyuYOXbuwgLjbtULjC9b8Sh7?=
 =?us-ascii?Q?rWymJfAabVkfd+2tIbT81veZxUrEdxzQ3POHWRLpBYywWmJh/fm+iFFlz5OV?=
 =?us-ascii?Q?oFtguxWXv/mcuAz/lhZ+e2lqv3rcUXouHJM/cr98OFqtLcsRY0uAA159mWo2?=
 =?us-ascii?Q?BjSJHUvBjZbiOqLCM3R6nc8SVs7QrSXH4r7qskbEOtAPNoDtMiI86kRb5Rpa?=
 =?us-ascii?Q?/9zXvVRAXMN0DZhgeixpW7VgfQun4VikjzVGbbaOyd3y5FU4YS2NY2v4oKUh?=
 =?us-ascii?Q?S1VzrJOnNcMjoI1XJ7WeTMm22m+HQUQCgW5Wc0FGmXMWOL56TQW9bqvfjlpD?=
 =?us-ascii?Q?4F/2D7WIg8DUGqD3FpA6FGYChy1zDGux7K48IwCcqQwiufIWurech0acbX7f?=
 =?us-ascii?Q?P036Qc8cU7izAvbiJFvuaspYqpLQ8s1/1eSxNXXrLHodRdorRuBTWrFi1lCe?=
 =?us-ascii?Q?dSMlJf/tcSAWzJw63Owjnuy+NMU2blevksYpaunyMMIVkNHst3zuHSCw432s?=
 =?us-ascii?Q?sTWMAc+oHNVx1EoQDS1xm6WaRbu5WmLd2vXbhmdCirLW+FNG4atHqqGxcaOu?=
 =?us-ascii?Q?ysAW5U84J+V05/h8xt3qpGfy0GGKWc8K57inKm3RPjp8hwRACscNlLVw2hgb?=
 =?us-ascii?Q?McP7wZ8LUWsn4Zk4NKLEW25Fh0lKGyCNuxjF7Pt7/JzPG2+NYOGwE8Sx1a+C?=
 =?us-ascii?Q?Iilos3bkIw04a0L3JqWkyiqWybgqRlPQxudNeiPEAm+J0A=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f94708-80eb-46f5-78cc-08d8e7a4aac4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:22:50.2688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VI/2Qt7YukJoc8D19PgedgP4nxg54Y/NsAzYn10ZLiXXYcnufin71A38SkBr8NE6BdJi1zsIpjKW635YiQYRDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4617
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
Cc: Dillon Varone <dillon.varone@amd.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jun Lei <jun.lei@amd.com>

[Why?]
Many DSC variables and related functions use whole bits for bpp.

[How?]
Change variables and related functions to use 16ths of a bit for bpp.

Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 48d3ed97ead9..bcec019efa6f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -770,6 +770,7 @@ struct dc_crtc_timing {
 #endif
 
 	struct dc_crtc_timing_flags flags;
+	uint32_t dsc_fixed_bits_per_pixel_x16; /* DSC target bitrate in 1/16 of bpp (e.g. 128 -> 8bpp) */
 	struct dc_dsc_config dsc_cfg;
 };
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
