Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE86C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549B720936
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="27KL8fWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549B720936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F0F6EB18;
	Wed, 16 Sep 2020 19:42:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 945C96EB0B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 19:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Owq9v3mkitXi7wztRU/XRtf6xMoAF/d1w83NujfX3u6TbVcp8fUW1SbyvBpfaIDiMNYMnXDJT9IDHIUjT11UFVXnlPDYRoTXcz+HG+BliGtC3Ch0CQy+7dvWvCwGX2ZfoUVPJEKTKloGLL5YYEE5sj5maPb4gPwAW+ovjR3PmP1ButDv7Z6+oyRIibPPOOhCc+bS8/+sEhUJVqKFBDLs2pKu/tiJFpQHEEUuARS0nFhX9Bzcl03O4Dmyp+Ga2mHdz7bH0urZT2gOcp0RYnw5CmnWtU1TPjiEuesOVEzbDDTRdidEIQeF9GYdeWuUNRX6L3J8eLxKaEc+/Ux5mJEthA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9O1vDJXdI/pqdPkygdShrzr+ay/j3I/Qbd4BlwpSkcY=;
 b=QNqCgNtl+Hrev8bmbpfuOQ5c6jO6+4ov9spB/oqO/qP7tEnBjpbz/qXJOOtvRgpKVdZIXZsPZ0BE2aT2xxOndsfaDu5UaQOCv2eR+ntuK5XQpF9lgjegyYXuorhqGLKhA0MweLKW5tQWT1HQpA3P3rxy/djcPVO0K8b763M0z/enP3Lzmz+FjjqTpCrMr1FMIBTwrQNnmq63xNEzTcl3leT8m1BnfXJS+4LEhpKIa5gl27+Fqnu5F0VbXOxSTk0MJfqeFuhknUkhqEW/L5jACG9f3gqdLB5OwxZN6Z554BMdA100OdYKGHOo2vHVckJWFIxHfg2X5F+nzzZvCV9eGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9O1vDJXdI/pqdPkygdShrzr+ay/j3I/Qbd4BlwpSkcY=;
 b=27KL8fWKD//wVHafcNSCV5O/awvGO6ektkYB4IOPJzqGDHJpFJ7d8suPn68bTABTxmFVAU3Rr7Bv2UA/xeS64/Icm3G5f6q+5gwlvV109SiB0rhUEMbmRaKkSA4ACnT4/1q0llikx6ogLJX7NyV54BDjwZqucA25j0db21Md5PA=
Received: from BN6PR04CA0101.namprd04.prod.outlook.com (2603:10b6:404:c9::27)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 19:36:43 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:c9:cafe::31) by BN6PR04CA0101.outlook.office365.com
 (2603:10b6:404:c9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 19:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 19:36:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:42 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:41 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Sep 2020 14:36:41 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/15] drm/amd/display: Enable DP YCbCr420 mode support for
 DCN10
Date: Wed, 16 Sep 2020 15:36:29 -0400
Message-ID: <20200916193635.5169-10-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916193635.5169-1-qingqing.zhuo@amd.com>
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e92ab825-3ed5-48b4-5560-08d85a77d6ed
X-MS-TrafficTypeDiagnostic: MW3PR12MB4378:
X-Microsoft-Antispam-PRVS: <MW3PR12MB43788252CE9E610927DD9B8AFB210@MW3PR12MB4378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3RYK9l+L0/nTNdvOMA3txRnXwC2JaMOjWtiaVKAQbHTSFdYgnAeU3/DPW4UKakDG7z5aEyRmsK+vZ2Z9nGSda4D5XN+rV3tlWI3kSIKpBuUoGUymHVVt5CzhwXFNL6pWchY6rtSseV1ilIuNVsRMSAGWMGs2koNwdpsyqj1JZYo8o0EdjAKCMj0xZk1LFgvnIBXPjqsKi//O/AHj5ivj9Hix/696YkBmyhnW6dRmjT/B+YKk3n/vOkZGXehXRjKFPqcAyRJglqxG3zZP7TS7N7KfoxYHFH8ArvqR1k/hVYlEJFKbdK79omO9YetrKcPEm2HCNeLoRPKxe9BtPevLupMY/Lu7MZsCioi8xhOuqydBjcTUpLqDti3tqPq2r3IWlviOflJhqMjIDCOfT/T+8RH2ie6rYAfqfl3HGRRU51c6zmFuJUGWgUEmjPpnjX6L
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(6029001)(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966005)(47076004)(82310400003)(316002)(82740400003)(6666004)(8676002)(186003)(336012)(6916009)(2906002)(36756003)(426003)(2616005)(83380400001)(26005)(70206006)(86362001)(70586007)(8936002)(54906003)(5660300002)(478600001)(356005)(44832011)(81166007)(1076003)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 19:36:42.5981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e92ab825-3ed5-48b4-5560-08d85a77d6ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378
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
Cc: Gary Li <gary.li@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gary Li <gary.li@amd.com>

[WHY]
In DCN10 when a panel with YCbCr420 capability is connected via
USB-C to HDMI active dongle, no YCbCr420 option is listed in
Radeon settings.

[HOW]
Enable DP YCbCr420 mode support for DCN10

Signed-off-by: Gary Li <gary.li@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 1abd81e17f09..a78712caf124 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -798,7 +798,7 @@ static const struct encoder_feature_support link_enc_feature = {
 		.max_hdmi_deep_color = COLOR_DEPTH_121212,
 		.max_hdmi_pixel_clock = 600000,
 		.hdmi_ycbcr420_supported = true,
-		.dp_ycbcr420_supported = false,
+		.dp_ycbcr420_supported = true,
 		.flags.bits.IS_HBR2_CAPABLE = true,
 		.flags.bits.IS_HBR3_CAPABLE = true,
 		.flags.bits.IS_TPS3_CAPABLE = true,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
