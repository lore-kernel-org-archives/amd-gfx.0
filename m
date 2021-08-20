Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3ACC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 23:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576DE61178
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 23:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 576DE61178
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB1BC6EB2F;
	Fri, 20 Aug 2021 23:30:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B14E36EB2F
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 23:30:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsi+zNAWnHNLWMOi9GudEsM49bZLaO8kqHMJbFoqEw6wcPjDV6bkaCiemqtm/4tMO0u/EhJbs1bCAc8PTele1cyTa9Aw6gS2SFNoo667KGKQE3tVEOfSFeGRnYA90B0Mk6k4bN3Mtg5ap49xr55BceXwMjLe03OgACgwWupiVZpE9b3ptBKd2+1N+3Mho1f7xvVekV2zhFwMZ8SpMDk2trpqFjItbwuyio4GmB8tmYWeVKcV/CcXkv0YwyDTwDg/EX8dfnKEEOW+M51VBuRYfsR1OLl6hcbqwcDvphWm847pXKMAfq2BY9QuQO5fi6ZHdMdSn+uNCzEyb06gVuYfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1FW1/2Q1kA24ZW9CZITDZS6F7BRO2AB60lZYPZriLo=;
 b=PNdOB3OJhX48dBoXlFFyNN+A4Scmsg796G3oQRQ1VU9vh+XpoviVdV6s1OSyZJ6r88Ted+heB+boPLSjjrjwBBIUkG2XL/my+IlNQg1OllWPkzb045eWiA9DraYPI/Bnuw523QeOlm/++HuexAlYElqy9xKVbZA4cytKRcii901WD8O3TmgdLQZmIU3gC2yfkCcC+aW9p6zit5zYukbcf56lj0505OSGayG8XBGDt6eyXC9dqCZjRgq5QrM1zzAGpCuewfnjt6Wki6p0FxHGoMjoOb/im0l4sbbHHoxzrHoMHxVzrzgsE7CrEkRxr/9LhnODFWo0imqdw/lzhz5/aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1FW1/2Q1kA24ZW9CZITDZS6F7BRO2AB60lZYPZriLo=;
 b=kK4pLxA1HIGO9dx6w5XTQMG7zKfKlkV7ofC2GayyzNZXUEEUcc3ND//0wXDDHkE2Z8deZAeSLh9WIcHZvjtCQhwNEsMGfgNGsHcNVp6v2CkzRJ9cXmKyiLm7RHXPYdxMuy1df3Dt8i0W3c7NSHqn93pQUmrsErlXrIH+CsPOPt8=
Received: from BN6PR13CA0046.namprd13.prod.outlook.com (2603:10b6:404:13e::32)
 by BN9PR12MB5308.namprd12.prod.outlook.com (2603:10b6:408:105::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Fri, 20 Aug
 2021 23:15:42 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::e6) by BN6PR13CA0046.outlook.office365.com
 (2603:10b6:404:13e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend
 Transport; Fri, 20 Aug 2021 23:15:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 23:15:42 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 20 Aug
 2021 18:15:41 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, Wyatt Wood <wyatt.wood@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>
Subject: [PATCH 07/10] drm/amd/display: Initialize GSP1 SDP header
Date: Fri, 20 Aug 2021 19:15:17 -0400
Message-ID: <20210820231520.1243509-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820231520.1243509-1-qingqing.zhuo@amd.com>
References: <20210820231520.1243509-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 939b8022-5169-4168-d886-08d964306eae
X-MS-TrafficTypeDiagnostic: BN9PR12MB5308:
X-Microsoft-Antispam-PRVS: <BN9PR12MB53088C662FD8F93747B602F7FBC19@BN9PR12MB5308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f0PvJDhjdCdJjRWoi5eifiX0jzZnzbm2LR8z0mxqJQAnVi8D5PurCsZdsEBML44wyfdVGjFehqBYtSlAgd7rhkOPPMCYGy1mcapB8ncyIaeaDOjCtUfy4zlJ2WLjtLjEoq2xLvfdsFdB7iaOITD5+SoOqgS5Ro+Xdt0eSvObueD2WGLsN7A9jHREMJnrTHkxla/trQ9VcnXLWaeLcFXiZkBjPbNTXipA3QvMlxQf/iEJZYfwMDBGdOY1LrsHo+jZQVnkfqVsgv6qyICZI/k5I0oBH3ZCLgeiPpt7XOqgZlanMApTcRPfo78OjvI4G+Zz4gMU9vq9SvijdYWZAsXyTheEnCwHBeLR3JB4jtVcBsoAmX+N2GBKu1Y8wyorR1ezCK/IZvitJokTXWMGv5mao83UbKM+KD/4in4UUa7rTnfG8YMskrG3idCjBdRlL450h2F7ND23iHF14Lefxpzrow+990OivaMlymIPrr52jGCdm5pVyOHUFc9qn8FboJwFJrTkqwkRKcOEoZDEdLK+rQMKa3zTGp+QAtcujYxvxaxFkbI8sUly5753FNvI6oKaWdvQ3tlPjolLbtid82kUkxsAQGCIwZuzOo7HOC6PRcUVa3BxdVT2g0I0ZIYhfzKRVccb5ekXtc0bFe9ZS2DDYMsO5a5Kq3Dqhy4qEaa5lFo7Geo01gq5Wyq3sfO4N5GS/RV7UWcOh1e15b5FXRuCR3CtU8qUNYT11sMWc09lrYCEvl0bjAX3bBmCKTgHF6FhM9/a6RWTvwl6Nh9ArOPKGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(46966006)(36840700001)(81166007)(36860700001)(336012)(86362001)(426003)(8936002)(8676002)(82740400003)(83380400001)(356005)(47076005)(34020700004)(316002)(54906003)(6916009)(1076003)(478600001)(4326008)(82310400003)(2906002)(16526019)(70206006)(186003)(26005)(5660300002)(36756003)(6666004)(70586007)(2616005)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 23:15:42.7356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 939b8022-5169-4168-d886-08d964306eae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why + How]
Initialize GSP1 SDP header for use in DMCUB FW.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_stream_encoder.c    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index f1a08a7736ac..58ff201a54e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -715,6 +715,16 @@ void enc1_stream_encoder_update_dp_info_packets(
 					0,  /* packetIndex */
 					&info_frame->vsc);
 
+	/* VSC SDP at packetIndex 1 is used by PSR in DMCUB FW.
+	 * Note that the enablement of GSP1 is not done below,
+	 * it's done in FW.
+	 */
+	if (info_frame->vsc.valid)
+		enc1_update_generic_info_packet(
+					enc1,
+					1,  /* packetIndex */
+					&info_frame->vsc);
+
 	if (info_frame->spd.valid)
 		enc1_update_generic_info_packet(
 				enc1,
-- 
2.25.1

