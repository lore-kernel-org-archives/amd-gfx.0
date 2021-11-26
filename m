Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD543C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 19:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3F7D6E8E5;
	Fri, 26 Nov 2021 19:49:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B8B06E871
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 19:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGCRCtOA9+m1UH7HqWHQ9a8rxUoNZ3+Bh2zNO87BVOSYnqE+N7EZA238CcDg5QfUpwmbnE6GO5U1KEfwZqPRzairSKEeKZmqmCBhpHvz9NcMAAyjgUQrINXifp5Tz09Klj9aJ3GkcNGwec6etXlRdo/upusrKalLvsAPsbBme/3UqR5DOkmqp6lMXjZ2UxLji8EV+Gd/5LdVC0mPDvzqo3E2cvze1RkhdE26aBKA1sIjCwOSaeruUOUjvrIrh9x+okTOjkYqjLp3mJtkcj0xKB38plLY4eK+8hIpJZUgmzk+F4MvvDatGs22i4/OM5bGnoTIASylJwMqVjPTBR1neg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufU2IFrrOM71Q74FDpTP/hlLJ1/QI7RIt986UgUC8ek=;
 b=Mjw31FnRxGbC5USp9l7Ovf5sXE6ABqVoKpOmHUTJhvLcQqwoE68rQm+w/PhzBy41Sya+1XzAzSx578Oj49kVVYwp4fNixmg/H5p/SylE4qzkDaJ2rv27cd7O819rhVD58D1Pa7+pUHBN7zN5qU0eK36brXZD6FarhUfYSM2zlkKCaxpBFgl+e/V/VrisKdp8YUTAhA2bCG1dgU5pRe/ji6cQUnDhywutAdYDR5586Yft4a/7cOLGksmwZfK+iKiAsRmQTBqu8+EYgg6xYCygDKzS3QRjLDDUxadEo8J36P+rEqm/3wIppN9SSJZKFr1U499vfGL7zrFgpwvgUEnDWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufU2IFrrOM71Q74FDpTP/hlLJ1/QI7RIt986UgUC8ek=;
 b=SZTK4yPIX50tTbZ2KYDB5wgL2USL+fp8GTNxRgOGmPdLzM/ZUL1whE7wbd76g9MpnY2/71fo7z/3WEWeA6sj0n0+uLdYTwZG51RKt/tKM9HjlBi2n1kXecEKhR3Uy/Ls5luYv3/1MIWwwsBg5FBaH5Swk8RUtsSVylb8a5c6Wqw=
Received: from MWHPR17CA0074.namprd17.prod.outlook.com (2603:10b6:300:c2::12)
 by BN6PR12MB1633.namprd12.prod.outlook.com (2603:10b6:405:5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 26 Nov
 2021 19:49:33 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::3a) by MWHPR17CA0074.outlook.office365.com
 (2603:10b6:300:c2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Fri, 26 Nov 2021 19:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 19:49:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 13:49:28 -0600
Received: from blakha.ht.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 13:49:27 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/16] drm/amd/display: add hdmi disable debug check
Date: Fri, 26 Nov 2021 14:49:09 -0500
Message-ID: <20211126194922.816835-4-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
References: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 392fde05-5cb6-493e-75ea-08d9b115de09
X-MS-TrafficTypeDiagnostic: BN6PR12MB1633:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1633F0472A7CF2553A1518C2F9639@BN6PR12MB1633.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2cyLVaPJOXohbfmK7+2Ag/8XUzpKOtPwfq4aF6NQ7kCyxsafWqBxRvJ+lsgMs6FDJS9Ume9I4EqhqzTKNKqYHcHlst4NSbGy4qHDolt/9LgSG94Ag1OQX5Eyha584iAy4H3jFad/J/sVJHWAK0tcz24jK3BN5EwHhddYy6hekO6g2/qyPUWQo4mgG9V6ruREWdO6rZEQ9C6m3WLLYezF6JCJS4eNDTsIL0b3Nbc8rx+wR9t/MzCYAkUNVNYYpph18fINfCDpMfV2piRY4zsHw3hJYW9B5VmRf3etl/G3HvL117ehDWdAmDKbUiZNLPrf72yKKFPb4AQPMGWrmdVSQNBkFtmp+18ggqq+ujtCPMLWJccyznCVQQ1fuvmIfmmI32AFpfy+U22wsV6mRu5Ze/DTvct3K8pL/3WxYY0CJnfifRsSGs5htCCVYU63YvxTqN3SDRjow2K57WpmnXyqCooBEFq3pYDjJgUbkdQRyhmvV8/0cpi5gFnK89Fib/uroYvTd9NHCoF21HOyLrvtwvWfxcZC/jiYVCSOH5DOdtJlouEzCf/LZJdmqLUZCzyYmxngaVs5PKEDBGVdJuM6NaoNCJUV3Es/GdWxLkpVXPYg0n5BoQtJXvdv3NTJm5zi4cMNOy2ZWvf+05dsU5irYFYu8CyhfZ4iR/QMVcRCzK5EyyS77dwG4QwiwO0W6PUO1zMK7Gpgs94q8TjoLppPPVIbGDNOJknPmsbbFvkO+s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(70206006)(336012)(70586007)(1076003)(26005)(426003)(8676002)(6666004)(86362001)(54906003)(8936002)(36860700001)(83380400001)(36756003)(6916009)(316002)(81166007)(356005)(5660300002)(508600001)(47076005)(82310400004)(186003)(2906002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 19:49:32.5638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 392fde05-5cb6-493e-75ea-08d9b115de09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1633
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Chris Park <Chris.Park@amd.com>, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 Dale Zhao <dale.zhao@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dale Zhao <dale.zhao@amd.com>

[Why]
Using the hdmi_disable option doesnt disable 6GB bandwidth

[How]
Add debug.hdmi20_disable flage when checking 6GB enable or not.

Reviewed-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Dale Zhao <dale.zhao@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c     | 5 +++--
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 1e77ffee71b3..f1c61d5aee6c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -788,8 +788,9 @@ static bool dce110_link_encoder_validate_hdmi_output(
 			crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR420)
 		return false;
 
-	if (!enc110->base.features.flags.bits.HDMI_6GB_EN &&
-		adjusted_pix_clk_khz >= 300000)
+	if ((!enc110->base.features.flags.bits.HDMI_6GB_EN ||
+			enc110->base.ctx->dc->debug.hdmi20_disable) &&
+			adjusted_pix_clk_khz >= 300000)
 		return false;
 	if (enc110->base.ctx->dc->debug.hdmi20_disable &&
 		crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR420)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
index 2dc4b4e4ba02..f4b34c110eae 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
@@ -646,8 +646,9 @@ static bool dcn10_link_encoder_validate_hdmi_output(
 			crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR420)
 		return false;
 
-	if (!enc10->base.features.flags.bits.HDMI_6GB_EN &&
-		adjusted_pix_clk_100hz >= 3000000)
+	if ((!enc10->base.features.flags.bits.HDMI_6GB_EN ||
+			enc10->base.ctx->dc->debug.hdmi20_disable) &&
+			adjusted_pix_clk_100hz >= 3000000)
 		return false;
 	if (enc10->base.ctx->dc->debug.hdmi20_disable &&
 		crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR420)
-- 
2.25.1

