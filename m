Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2428DC35247
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 21:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E892621775
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 21:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eutAgtfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E892621775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06D7B6FB63;
	Thu,  6 Feb 2020 21:14:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36F9D6FB5D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 21:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbcmELIHMqMlPuHKvIV4a/0maudKb/l6HtAeS+tkYPx0STUrImuSCe+nZcDNXcF0auI7/jxSFO2IDmkn1nkj5piNeaE2AR44SSN/0yT/svuBA/AbLMJkM0v2exzpucJ7ikdEB6vO9Om7iMfiCCD75avPT9Bon65u+sO92wAJjY4N5jWsbGrCr7vayv+IlCUokTFan6aDjcAJKMORsnZL42R3jZ8PUCyrYemMBMtVbSQaZUedS/LFFsNOkdMmCl36C/LUvxKHWB9YbHQ3SWSrg4c3UlCpxNqf36eb+THv1RHuyZg2/agJ0qz9AuQtnpuq1eflqJZBqxqfK/OPth3mvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPjSDurkLqXPBk7OX/GlnQNydKaJn/7x/RZ9DP2OrY8=;
 b=DI6oHIiUsDRatT7i9wE1U+9G57t7kv0OmFNCrGve2KZwxVT6hviTDSfLgQ+XPrfyPptfpWjSr4tauYgZxKYq1omgMXQH7TpI/iNa1ChYmu/WHvVb+qsxDnNtrOsp4q62RDPtmV/Qh2IE/O/AbSww+hqLJ0+f1ff61VtQps6qbysE5ZDxkxtNH7gDlA3UVgjMmfKBX1Qd6OzG6EHOzwyJ4i5V6Wxk2wwNqnohNp5HY7QWIWPUeFk1/BxmbzbJEgogUg8xiIwsYxglbKOKxm8kAr1RylL+IydTehOfiERsBMmCkjKczr0+JooJyva9T/SUKnOm34SNO1vGcAcl5jY/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPjSDurkLqXPBk7OX/GlnQNydKaJn/7x/RZ9DP2OrY8=;
 b=eutAgtfSo8Dox8BgCLtFFBlvc9Ey7f2/hc8Ni/e/Ek6887GHWL3o6jMffx2uV471wWG86rvivkbgnV0xp7GXkmwwYENgyFyx4FUE8DxysoEEXxPP00+7tA4vp1jM9Ae7NWzGBWdMxs/f6t2e0TyvhP5tjccmNRvB995EUN+Sfgc=
Received: from MN2PR12CA0006.namprd12.prod.outlook.com (2603:10b6:208:a8::19)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.24; Thu, 6 Feb
 2020 21:14:40 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::200) by MN2PR12CA0006.outlook.office365.com
 (2603:10b6:208:a8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.24 via Frontend
 Transport; Thu, 6 Feb 2020 21:14:40 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 21:14:39 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Feb 2020
 15:14:38 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 6 Feb 2020 15:14:38 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amd/display: fix backwards byte order in rx_caps.
Date: Thu, 6 Feb 2020 16:14:24 -0500
Message-ID: <20200206211425.20394-5-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206211425.20394-1-Bhawanpreet.Lakha@amd.com>
References: <20200206211425.20394-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(428003)(199004)(189003)(356004)(478600001)(186003)(7696005)(6916009)(6666004)(36756003)(2906002)(426003)(1076003)(70586007)(336012)(70206006)(26005)(86362001)(54906003)(2616005)(5660300002)(8936002)(316002)(4326008)(81156014)(8676002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4244; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35c86ca4-5887-4c54-e796-08d7ab4993f1
X-MS-TrafficTypeDiagnostic: BY5PR12MB4244:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4244813E5351CA414D3DEFB6F91D0@BY5PR12MB4244.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T3F1yZYy/uxe5XQ90f26u+7k2+88iy00MGboWFWpSsnFJ0rQ2K4ePWHNNYzFeciFBQJAimlwnRy1O7CXT/E/joj2PmeZ/l8SYDPB8i1XQnY0TMg5hClawFg/Fm1HKhw8Gtab+p2ZbYm/l3k+NS5ahRCRSTr7cQuKdK9LRwYUHfNZ8fTzd/Np6D6vTNizuV4/qh1D84w32fvx6AqIs/mkHkEVZ6kDh4JbUIF2ngVGIOwMZ0GRPXja9TXXGXecUeWPv/TJBWnUrX9/XzCwMi7DhOYgr5WBtPi6qE1M+8q1X9gLf1/6iq2r32+0dzs4UEaYaiocvVuETgabvJH1CfCnuFLgaAyFIadSZ25J+U9v1V1Ty2Dt+MqDUrxLXQiDgQ7+SJTWXDrMZukqcfC6fpmXyMA4/tGH8ExOd/NPLuVcWP/BImXqPlvPnQ+YpQ34wjpC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 21:14:39.8850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c86ca4-5887-4c54-e796-08d7ab4993f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 "JinZe . Xu" <JinZe.Xu@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We were using incorrect byte order after we started using the drm_defines
So fix it.

Fixes: 02837a91ae75 ("drm/amd/display: add and use defines from drm_hdcp.h")
Signed-off-by: JinZe.Xu <JinZe.Xu@amd.com>
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index 432b2a016e56..340df6d406f9 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -46,8 +46,8 @@ static inline enum mod_hdcp_status check_hdcp2_capable(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status;
 
 	if (is_dp_hdcp(hdcp))
-		status = (hdcp->auth.msg.hdcp2.rxcaps_dp[2] & HDCP_2_2_RX_CAPS_VERSION_VAL) &&
-				HDCP_2_2_DP_HDCP_CAPABLE(hdcp->auth.msg.hdcp2.rxcaps_dp[0]) ?
+		status = (hdcp->auth.msg.hdcp2.rxcaps_dp[0] == HDCP_2_2_RX_CAPS_VERSION_VAL) &&
+				HDCP_2_2_DP_HDCP_CAPABLE(hdcp->auth.msg.hdcp2.rxcaps_dp[2]) ?
 				MOD_HDCP_STATUS_SUCCESS :
 				MOD_HDCP_STATUS_HDCP2_NOT_CAPABLE;
 	else
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
