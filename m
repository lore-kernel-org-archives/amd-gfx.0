Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F0DC433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A04A710E2AC;
	Sun, 23 Jan 2022 18:21:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF03310E213
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUvcHbVhv/x7BibpbESdx/+a+/hMkULMq9OuMriCcAeZ9vl8pYCmLmmqGR2RO/tbXZvGjHH83xl3dQvBoJV0fQfdzwnBjuznzT/2ty2XgadXOjQptaQJ8GaeIxSb81LMCPYQT+VV8jd+2VLhyC1pf0f/vRRCv8PdZQSrey/sbNkv2uj9drdVi7yVOAT3s6qYlwr6M6fvaT64WAN2m9qnoosGJXGLh1fcISKDAeLWpthB9gvqADfGGuPLe/vGBHDZeMc7vmLCGLM15t9beHf7t/WVLa20spV4r7XJRMZdxl131FbZ5jWBoLCXiu+YCtHGi9jW92qvVK+Uc1eASylqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnQz8EDZPWVdEn+Olgn+FKnXP7Xl+bUvnG5KfNJu+tQ=;
 b=h3kMRuIm+VWsLzFXmS8H/Z2X3nH5ksGSWqCldPY60nH5HNn65sULcEAVyH38f45wrs2PZf0XyLBXHULGGR7quKtLZSl9yg/7IgOzdS3Kc5onXakeaSSghsWCnNxJy8IbSCTNhIqdFqHa9QiwHk2J0YTAFTuBCptRdqCTJxgjQ0aNBaaxMlpJw7PKjaj1jOQoa8u9+2HP+J2TR71dmO+IUhhnnZjuai9T3j5mk8mH9C83qag50pniAlzWmQlo0lFX4ThOS5++PJkSZWccXJ2pEo8WZ3F/0Z+OJq338oGkQTNemaQGhA6hZ5WMNi5qejfnFNTeMIPUIwiun27PLZBmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnQz8EDZPWVdEn+Olgn+FKnXP7Xl+bUvnG5KfNJu+tQ=;
 b=n89k+Wav27vOY+A5wb0ttMJZO+uASP2oluC07rSVGfwAPKlkzR8Zlrwq/AegQLS5pB6IUB7Tz5UK3DSuUhrfoab56CSC9MVKQy2tlYVuygwFe/x9T9iceE6dfHt8bkBUUtPtZg0Ox9oMLR8C7ar8ZefTWK4IY3TLJYo/jrGBA3s=
Received: from BN9PR03CA0739.namprd03.prod.outlook.com (2603:10b6:408:110::24)
 by DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Sun, 23 Jan
 2022 18:21:01 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::26) by BN9PR03CA0739.outlook.office365.com
 (2603:10b6:408:110::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Sun, 23 Jan 2022 18:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:21:01 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:20:59 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/24] drm/amd/display: Use PSR version selected during
 set_psr_caps
Date: Sun, 23 Jan 2022 13:20:04 -0500
Message-ID: <20220123182021.4154032-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e339b562-fd10-4bdc-21ed-08d9de9d1c03
X-MS-TrafficTypeDiagnostic: DM4PR12MB5391:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB53912CF5AED397E7ACD79161985D9@DM4PR12MB5391.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFmWwynzdSa80zE2Ob4sAVxfES60IdhWgUMOhb8xBfMJ0tffKmHnspxOhky6VNuh0Ftbl6sijD2Lq3+RfGLvrTCdg13SCPItkia87ZrfvSzHOA0FnzhoCIlKGDp9HWOmjesZMUnLZTa95cCWQtO6SJ/Pntl9KlMx3nhgW6ZYdOiPnmAVk2ie1Gj6pEazsZbfaLooCkDePHsOInBOCcp/wc1I2vk+EZC4yBU1CFFUuKIRGxzdochKIDEdgiYAZN+zYS7Ptb8HRG/soW9iv/ohEYuGz+uPqySPeUTlbACu3kYlyAMEH9PzBrBSzLRiX17zpzb9Z/KKzibXL1aQNUz6AHmDI+VtO7oRdYeKQ5aI4yNRYL35GH7mJGJUbM4O1y2gGBndZl8i0EXRF9nFJxuo4hN267r//pAsKhrGj0eUGY6K7Sb2RPYIXhE0QUnCH/B6Aj481u73qUb7JD5K2tB5t4ee17OjFhhxuhzUbn1ib2qPEE1t1NfMVikCRHkrVexriOvWd75o4720aVpiMzx2g6Gx7UgWhLCIxbVCF4/oE9w3hukclhTnnoQDQn8P6bxt623FNHweneS+NT1znz1DbP3IOtI+O0VWy+POGTPiv4kbv8ObBZC3AIE4u6joqVERAAsalSVXOHG8Usbi/Acp0uD6vYSKsKW+ePRoatK/dZXSPnKtgLrZ4mhTrJvA8R1F9QglSTsHkAR9+3u/jeNw2bQ3R2CNQAFtC6oa/D+xS92p5sxMNUGFIDWIQ2qSm7nJ5NeAkPBEO00HoJH6ih47QmTdGLj6xuhOYQvg6+i/K4Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(36840700001)(46966006)(86362001)(36756003)(40460700003)(47076005)(36860700001)(426003)(70206006)(8676002)(356005)(81166007)(6666004)(8936002)(70586007)(83380400001)(82310400004)(54906003)(16526019)(26005)(336012)(1076003)(6916009)(508600001)(4326008)(186003)(316002)(2616005)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:21:01.0366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e339b562-fd10-4bdc-21ed-08d9de9d1c03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5391
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
If the DPCD caps specifies a PSR version newer than PSR_VERSION_1 then
we fallback to using PSR_VERSION_1 in amdgpu_dm_set_psr_caps.

This gets overriden with the raw DPCD value in amdgpu_dm_link_setup_psr,
which can result in DMCUB hanging if we pass in an unsupported PSR
version number.

[How]
Fix the hang by using link->psr_settings.psr_version directly during
amdgpu_dm_link_setup_psr.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index c510638b4f99..a009fc654ac9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -149,10 +149,8 @@ bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream)
 
 	link = stream->link;
 
-	psr_config.psr_version = link->dpcd_caps.psr_caps.psr_version;
-
-	if (psr_config.psr_version > 0) {
-		psr_config.psr_exit_link_training_required = 0x1;
+	if (link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED) {
+		psr_config.psr_version = link->psr_settings.psr_version;
 		psr_config.psr_frame_capture_indication_req = 0;
 		psr_config.psr_rfb_setup_time = 0x37;
 		psr_config.psr_sdp_transmit_line_num_deadline = 0x20;
-- 
2.25.1

