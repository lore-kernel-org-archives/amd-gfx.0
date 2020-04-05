Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E489CC2BA2B
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B89BB20659
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1KuIQ1G0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89BB20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D5766E2BE;
	Sun,  5 Apr 2020 20:42:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E26526E2B4
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:42:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur3F+lbac7WLHTQF6t1LT1Z4WTxeHwBC+x5oFzZn+trAV1idh7ezeiOJ+Q/1MFulTCK/Zinlu7vH1oKnF/vpTVSEDT95cukHSb9RisrgizQrRXMOebyfdO55A88y7LpLlLf9keJwdhjpZIUFNEskbgdlPi3UQcxm6QJehwjumszsU5KT1UjIwsM8+AklbCDJjUH65LzfkrKe3QBGphIIfWMF5VuIEKXzGHApHB3FozgNFMa3hFa+GWhN+YEVVyjpMR+YcOyr5X1qw284uzHnxFDjAekFxu/ZjSgbW4Gz0E9xmcgChy0bwoQDEaxp/nAllBvU0LLwfrtqspMwq1Pslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A9ljRsMKLR2gZlk61TaXKhSqZ2razAUndJFTkBRtZ0=;
 b=fwDMBr1Tvx8wWOq29j/BCZB+TPEvOeexmN1CsiLlHPCOnTuue/z6Q2M4AKn/B8U7/bjDl7qTZLiR3vnJJ9QhdOUaQW2M1lmJmrP7gp55bI/Jb681m3O/HrtfLno3Pl0aIKF58eBbMQqlsaM7PmKiiGJPo0iVl1MER25SPlBojrhzf/KfApO+bKt8H9EPqqWXPlRS1p2+mEaT2XcyLVZSXjOsyLMyErpLm5qfzpmvJ1Gu2tjv3bFyxM8BdPpvkTWv7S1DtOzuhCbGfxrDoVygha0knnzxMJxXTGG8xu8dUhBAuWzWkURfkMIhn/yXsNc7XQ5zzVzV8kow86z2g2ygEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A9ljRsMKLR2gZlk61TaXKhSqZ2razAUndJFTkBRtZ0=;
 b=1KuIQ1G0bJPRDUNQykx0TieDaOqActKCEK1ldUp+57eoon3L89PRtnhOD9IE7kt1yQxRmLgA3kWsKo8n2JW6lIdq5izSda76qckgPmzSkLIQffA6d5tDC+vNv0Tw4OTclyOpPwiT8UULvEQfAtaV7tfBNAm36gEIPALv8nTVWaM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:42:04 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:42:04 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 26/36] drm/amd/display: Revert to old formula in set_vtg_params
Date: Sun,  5 Apr 2020 16:41:05 -0400
Message-Id: <20200405204115.683559-27-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:42:03 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 78318ce5-2274-42cd-663b-08d7d9a1cc93
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25557C424D4ADDAB96B292D398C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5uTHHBjHntoQV7/82ozYIeS82WH9ry6+wF3jIyMa5MWJa+hArJPhcdRP7d14KSfRSClcyRJGilNrBncYg4z/NWBsnoHyvcW56cXe3bHpStSZoQq4d8S+kntVBR6pWIcM+Wf93bfePcxDXUApIc2A9VQ7Of9tPOcUIdXZ4G1EU3tWAA7GAsvK32MQwsm7JokOmzphLyZKNIyA+TevlGJ9TbXg85Blm2pcqKXNoHq01KaAqrgSMPClR+UnifEouRp4AaZhgQX2v+qex0juwx2lpGHixlewLAjTH+ox4HRmg9+QJKoZkll7aaN507Lo9+0GwVGjk9+RUvqrrmdlJp2546PROjSjHOoEVLZR1gRpnb+xOrKDq1clxpXzBrImJzkFn3MEIhOP5RWUmzquBWyFe2OcOuJ3giVwoGJm+nDnuZeKQUR7gm+UzMcXqJcjerPq
X-MS-Exchange-AntiSpam-MessageData: ct9TBkAwyXOB8cLXTIFI5xCs+2r3WsLU2iCzVPmUy+DCWFs1RwWTvgPUt7mdQh/23UcAHL6cXfzNFlCg2oaaLTR2ICAcJP6eByYcF/AOuzHOiVKSaXDEVuYRnx4eCRFxb5kaTPLkuA+rOA15/5woASQllx9ysX/u94w76LmW2Vc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78318ce5-2274-42cd-663b-08d7d9a1cc93
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:42:04.3647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oX3LJxPCSb+B6TzbnSVH9u2b6IEbDc1dhmPNewSkANUT5kO+YGxPSME4AtssLAKqxtQcvGfPvpiLIZ8tK/DsNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, Harry.Wentland@amd.com,
 Alvin Lee <alvin.lee2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
New formula + cursor change causing underflow
on certain configs

[How]
Rever to old formula

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 17d96ec6acd8..ec0ab42becba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -299,6 +299,7 @@ void optc1_set_vtg_params(struct timing_generator *optc,
 	uint32_t asic_blank_end;
 	uint32_t v_init;
 	uint32_t v_fp2 = 0;
+	int32_t vertical_line_start;
 
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
@@ -315,8 +316,9 @@ void optc1_set_vtg_params(struct timing_generator *optc,
 			patched_crtc_timing.v_border_top;
 
 	/* if VSTARTUP is before VSYNC, FP2 is the offset, otherwise 0 */
-	if (optc1->vstartup_start > asic_blank_end)
-		v_fp2 = optc1->vstartup_start - asic_blank_end;
+	vertical_line_start = asic_blank_end - optc1->vstartup_start + 1;
+	if (vertical_line_start < 0)
+		v_fp2 = -vertical_line_start;
 
 	/* Interlace */
 	if (REG(OTG_INTERLACE_CONTROL)) {
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
