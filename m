Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3BCC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3080613F7
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3080613F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D5D06ED88;
	Thu, 29 Apr 2021 07:54:46 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C6726ED7D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 07:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrtTmpZCU6BWUNkbuGnjfoefBbTD1BAJyO5FzFUjzScjtOaHUAih3KQ/eR1KwDibfKUowrmDIVs12l7c4qPuIJMjepFObC1pULQ5eodg/9vd0lItT70xkS/QUFnqvn5uFZEYMp1oQ5FjYSi77SJBufvaGhkxwtQS/XagAHHzia0qnK7QKOHdJuU2Lmhy+OK3wLIlqV//J+fjE1NUFDjjDCVMWI0Lgkes0cl9h3ybSvgvloNKa8TiCt9c8ttqvu3CGHl6R4BGt30eri+qwMiIy1Xk4K3d3JpherFid5EBhjJlWjipWXqfbJKPWXzYrhGbN3fK49SIsir6ebQvqP0VKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i3bA7xATikCbEbDPASynVVEJk1G+jYHSOGxpuS62S0=;
 b=lHpgrcu3r/M8tzEv9+BlV6oXGMUnmar7TlfUgLA/RFy3DdEIAZui40OwteegGnURUKE22FxZEp1mc1WcXCJD10e584kKgKsrt6XuVqgLOTZGdQX6aaONzLAE+0jLS52h5LQ4mdMUItmdYmZfpKicBqz61MhvqyMgXAZFzJm5WT5ppRnogWHxiK8HI8VWtMvXtgSI6kG0xVy6ysuyi+yFkCcAF22JU0r1X9iLLFAKFieHktXp+AEnxVNISZ+OZBfOes6348E+/eyYiG0G/mHeiqmeV2+fmUg8/vF/HOvSWvu+4sowmkzZOjskPcbaR7Oi1u8zfKYFdNKiMh4oUIU28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i3bA7xATikCbEbDPASynVVEJk1G+jYHSOGxpuS62S0=;
 b=lh3/4gvM0+JdcGy22iiM8mJzQhTapvUfiGIfUdllb3tGywEx83J0ZGjTLgiy5v4V+oI8u8NoDnqHapd9bhnWqW25rnpddgaDA5SKZ5EmSxWXghVDzaLbbw/LPt5+LaCuiVh8gITIDO8y/UpIiXMRnS9zplF6DDvRAk5+1WORygQ=
Received: from BN9PR03CA0218.namprd03.prod.outlook.com (2603:10b6:408:f8::13)
 by MN2PR12MB3853.namprd12.prod.outlook.com (2603:10b6:208:162::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 07:54:43 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::98) by BN9PR03CA0218.outlook.office365.com
 (2603:10b6:408:f8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 07:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 07:54:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:42 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 02:54:39 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] drm/amd/display: Filter out YCbCr420 timing if VSC SDP
 not supported
Date: Thu, 29 Apr 2021 15:52:02 +0800
Message-ID: <20210429075206.15974-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429075206.15974-1-Wayne.Lin@amd.com>
References: <20210429075206.15974-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94da7606-be7c-4180-c2d5-08d90ae40cb7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3853:
X-Microsoft-Antispam-PRVS: <MN2PR12MB38535C7EFAFCEB1A046E85B2FC5F9@MN2PR12MB3853.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wns/fQy6FRnkD6PEyJJTD93dJhxlYTMbtHZm99n+dmQ6Bq1mjYBK5/KTnjB9E1yxrRYdKXnRomKdWsCTLphhNs1OxigLCadaorpx4NVJCOkoeL0dlwEJuZ10+/STgc04rjY6svS+bacSWlHIoyL3d7F0/m6quAg6AHvuJ/pNUezfPGp/Aij2mNdB+7+zv7ibXw4FYS/vDj3M8LtnmFitGxeQBF9tVF3bcw6lsH7nFn8rKMAISQCLpVfxfBWomL+TG2VEDjkkbSVh7tF5N2P/OS36UKK1ASq2cT6V0Fp3/sU4a0pGvwypLBZ6zH1+S7xOleYQbj2pyrgZvXNlAvpEYtFuWO24iBvfMjmnOk2nUpVZmKHPSlrhHJr2JsBbLD0akMln7JNWiDMF3XBoqxZ11z43Poe/rUNS8D+TYpYtvZTtA68a1oiwCLFgWPY7qJK7+N3PZPxQlAwv8Um+3PaIUa/K+sotTgVr0FX8exKw8lt90I4z7Ey5jAOC/hlGgHS2XjuTnVgLvRh6IcF7ok/Q0IHkHMtNaDzhwuNmDegwSlSGRvxCQfeantxos4LaJIrrtzsEMQsb2MOIDlgR3x+WnvdNQD/UWRdixd4KY7p8FgaKwPpRE/8hMG4sQVb9eVocolswK3gaCjXScTMm8XcoSq8iriSMorWSQHrnmmxciX0+wktZGiv68p8dhCLLHxqA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(6029001)(4636009)(346002)(376002)(396003)(39860400002)(136003)(36840700001)(46966006)(36860700001)(70206006)(82310400003)(82740400003)(6916009)(478600001)(26005)(81166007)(316002)(8676002)(356005)(86362001)(1076003)(336012)(5660300002)(186003)(8936002)(83380400001)(2616005)(7696005)(2906002)(70586007)(36756003)(426003)(6666004)(4326008)(47076005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:54:43.1396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94da7606-be7c-4180-c2d5-08d90ae40cb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3853
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, George Shen <george.shen@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Per DP specification, YCbCr420 shall use VSC SDP.

[How]
For YCbCr420 timings, fail DP mode timing validation
if DPCD caps do not indicate VSC SDP colorimetry
support.

Signed-off-by: George Shen <george.shen@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index ffb4f9027d5e..ced552ed7b8a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2411,6 +2411,12 @@ bool dp_validate_mode_timing(
 
 	const struct dc_link_settings *link_setting;
 
+	/* According to spec, VSC SDP should be used if pixel format is YCbCr420 */
+	if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420 &&
+			!link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED &&
+			dal_graphics_object_id_get_connector_id(link->link_id) != CONNECTOR_ID_VIRTUAL)
+		return false;
+
 	/*always DP fail safe mode*/
 	if ((timing->pix_clk_100hz / 10) == (uint32_t) 25175 &&
 		timing->h_addressable == (uint32_t) 640 &&
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
