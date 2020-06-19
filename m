Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCFAC433E5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 902B3208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jV2Yzhf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902B3208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54B566EB23;
	Fri, 19 Jun 2020 20:13:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D938E89D40
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cht6yTnjtBBrk8MTSDtKYcUyK7PJb8we647ZqYL0RrZGhHj2Ww1+NZFb3o3+plfbPpYN7E5YECN+OdOwgL7McMKUAB9aVnTZCKJVh6IuC7GXpws/EcJU8tuC1SaLvpdlGs7FBQesG7XRLd/U0xaRvUfx/RtmqL9aadaLkJsIz+BDm4uHe8PNUQML//tIw82OfsRR1j3wYt2J3KZ2fb8v7xZ0XOoHxXSDA+IVoS/dO15rSsJASdtRzH25SJrfuibc4psWVcQVVtIKPGb6QCGByGxDkb4dcrb4wZeHK7qfuMZCx46tzDk0bnW0X3nHLZrI/lWQJpGs8ZEjvwDooXTiCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dvx/2RmrrIf4u/+KLKyIoVnYNxgiUmqisLnpyDcM3YI=;
 b=Ot2iXFNDalQqUr+lKz5bNlWLslsgqixsD6faNHulR/AmQUNOfLrnjaLu5wroElESJo+nj2WWm18tgwkjDtBxhIBcNr5oNDfcYspTUgP43Pu/s3areXyhy9mpFtdwWHeF6/eUeMsi2k+J7dLvGuki9DG72Q1bf7frW3Gn3HzJuFH6Gv3wetthZjh+9WbiC2PWkgLTwyNhm+acLZw7XqAEtwZQ3pTnPozdD2f+/LKHMWmouXR3z1bDwK7kcmjssrRxFo+MYW1TbjYU9Wasp0ZpR2AmkUizJEizz8qODpv0GXBFcGvtvXySvUKrm+v1z5jub6XRr4Dnr5NWmrZfjYFVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dvx/2RmrrIf4u/+KLKyIoVnYNxgiUmqisLnpyDcM3YI=;
 b=jV2Yzhf/MyX4dCfYuk3LHoF35fpZc8x+7FvGNbKR9aq6SSTbiTk8GEvDnlS+engQ2ciAB4SHAo4Db/EVDK2N7A395g2CkbpXqWFbBET12ZbUKjsgibrUkhLYc9KopjrGCkjBuY52wznS8l7fYyiY2ekhjHibslPZfpP/hpOsUDA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:13:03 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:13:03 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 22/30] drm/amd/display: Allow 4 split on 10K 420 modes
Date: Fri, 19 Jun 2020 16:12:14 -0400
Message-Id: <20200619201222.2916504-23-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:13:02 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 63e54758-9594-4037-21d0-08d8148d2baf
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB40870236245F40BD3303C1E198980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfEKxEDNXZ1mFMk9OVBEhI8Qvjhqt6oNEDF4J3zJqw9hcWA7GaRQfuYcd99yayzUBsFww20f0jsGdTALTlJ4sPtWO7JdlHi4PZuD0mOn+NAJmnY8bF4Wv/uUDnWNoRnaEYckJAd6U5drp+pA4bLP4R9gvRMAVsnWyyWHxuAdhDlAwbUG4OKxRm0Ql+kLE9iBkSdBtaWOSOH/Ri724GSwIgDuFfB6Or5/DVnbrRO0Su9i9Jd0V+cqtw8V4OY4rr6+0BqBSFWfkbtrMNDCw3jeoS6cKda6PbmZBaoF6E5RAPy6vTsmnIIf8+d1+xyii5qsuKwWCnK1HjB/x8/C9GOr+7FhB6kMvP9m2urfCnjZUx5MSHtTQxijUYxL4TVgPYqz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(66556008)(16526019)(66476007)(44824005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0XhuQ4AavVM1kyA7+LPOBGS7v/GuaHQOkpTMKZVi0lU9jQcy4e+4nwwx6+s0X+tqChRANOJYoz9k6ncWpU/dtfvKrupXW+FlrQzpXKxEy8RTpFY9nlHTkJF6qPEGPwb2VAXauemJae/VYumvZzb85gcj7i8DvckuzlCPFPeqkq4JX0dBqtwyw7GaFUAz3WGnRFHi/S1tU0ssljuDkn8C8M+FSIxFHV50qt2wFF+eZoyyfH3FqoovZr4sZfiVBUbIiov+6rlqfbzNKrl3HIYSWLbNiTTwLd8Y1VLOQ1/xLyi1phhBqTMezToe3AcYytXR9EmSk46XgYvA18tnbH53FLEjYuECeYBIAh/jcnlK7uIfaW3S3OhRsPAsfwNKomBKtr7HBtDFI3zt17JYUWBlqKlcWj8lgRkoMP5pywOWfm7wdSCZFm1ks9U61ZRjkWiFr3kSgkmtLaxn+OkQxJvv7266bYnQggxLhsHs2GpW3dxt4JhUKMGqdiMJd9EDOkYjBD7Og5Yii1J7aDUIsMU+Qw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e54758-9594-4037-21d0-08d8148d2baf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:13:03.0828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46oM84nibcgdZzZ+yHnNAGUSCDIM9Vat3IiJdV66OQngVf/ZZqPBFzhr6kHzOZYw7wf+KSrmqk/36Fa3zlLwvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Chris Park <Chris.Park@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
10K YCbCr420 does not need ODM 4:1, but it requires MPC 4 split
indicated on the flags.

[How]
Make pixel encoding and resolution size specific workaround to enable
ODM combine on YCbCr420 high resolution modes.

Signed-off-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c        | 5 +++++
 .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c   | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index e8357d7af4ee..1371f4fb168f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2745,6 +2745,11 @@ int dcn20_validate_apply_pipe_split_flags(
 			split[i] = 4;
 			v->ODMCombineEnablePerState[vlevel][pipe_plane] = dm_odm_combine_mode_4to1;
 		}
+		/*420 format workaround*/
+		if (pipe->stream->timing.h_addressable > 7680 &&
+				pipe->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420) {
+			split[i] = 4;
+		}
 #endif
 		v->ODMCombineEnabled[pipe_plane] =
 			v->ODMCombineEnablePerState[vlevel][pipe_plane];
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 5909af0a25fb..75dc4fe41731 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -3986,11 +3986,6 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				} else if (v->PlaneRequiredDISPCLKWithoutODMCombine > v->MaxDispclkRoundedDownToDFSGranularity) {
 					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
 					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
-					/*420 format workaround*/
-					if (v->HActive[k] > 7680 && v->OutputFormat[k] == dm_420) {
-						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
-						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
-					}
 				} else {
 					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
 					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithoutODMCombine;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
