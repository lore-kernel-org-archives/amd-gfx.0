Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D68C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D2E61207
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 35D2E61207
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 954D173795;
	Thu,  4 Nov 2021 20:52:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E30F573784
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:52:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSOanm43OcSCwoFtEnvuDCkWJ8C1DyYAiRk7Z70trzEQGFJUfkQX291UbeLAnoLevB2XixwZbn9XMAlk2yj4zFMY9ostnovgX6SkTPrDCGc7QlHjIzzUaiDBSZXNWL/qqi0Z8ZnDDGeBXf0KAWuZBJoUTUrBXT5YBjQ/qd2zDyrNjWdzlZWsu9Tc5/Fo+J1AaRelq7juAgrthSYUl4808ZDZxsK/ynOxr60Qq1A3YkyCFc8KNbMyik1wxANBYrLJxhWbT2uEG7+TmClr6pXz3P1B+RGDIauyeEjL8pE0S8TwMFqjR422oA305NBr74tCO2vUXKUa9H09tJsXGgI81Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3o9vJM99icVsEN2MofC449Gkgkmgk/EPsKEDhmZmEc=;
 b=KC4liTWj3+j5+BnAFlTShcez7zjjZFcMkI60wdj6aulaiiwp33IdhJ/qwKuJgaM1s+IwRfttrAJdvMeXEetp3NXzJXqu0km/mxIzjzXQdsuc8J5hxji7amB8aA18QND4cXLfoz6ZnGSDcPpCwuWun3x9VEmIwSnZQ5jtDnl8svFj100xFi6iR9fO6DvrN8ZevopWCMJQO4mqcBb84FOnaK/z2yqsKLuvFiTkrcG6MTjf4qJjCHFi4L37sf1ndbs6myJc4ZWG3J24/r7zTFidGn72YlvZv0ci/FkwP5b1vmLVzKTGonyhxz6/iBRj1Ctz/3DY049/OGb2FUIIV19whQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3o9vJM99icVsEN2MofC449Gkgkmgk/EPsKEDhmZmEc=;
 b=CM/SRw51+RXOZkpFXhx69lwjSGRJmLXnsEq2b/dmAu+HxskliAC+nfaVk8C2GDth1FWQhIm8+2B3UWpN5+gl071XwcOZtkjzWGRfGXD3UCfwBR2NbOHQDpVOS5dSgU+BAGSlcYKdZ2CsX7H7U9j4GhBTizpIaI4HaPoM3vg7DQ0=
Received: from DS7PR03CA0272.namprd03.prod.outlook.com (2603:10b6:5:3ad::7) by
 MN2PR12MB3630.namprd12.prod.outlook.com (2603:10b6:208:cc::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Thu, 4 Nov 2021 20:52:32 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::14) by DS7PR03CA0272.outlook.office365.com
 (2603:10b6:5:3ad::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:30 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:29 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/22] drm/amd/display: clean up some formats and log.
Date: Thu, 4 Nov 2021 16:52:02 -0400
Message-ID: <20211104205215.1125899-10-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad8c93e0-2b67-4dfc-4123-08d99fd50556
X-MS-TrafficTypeDiagnostic: MN2PR12MB3630:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3630A4B65B62108C02AEBFD1EB8D9@MN2PR12MB3630.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lwjV7UHeidWFRDHyhM4+NU6gDXWGsSe0nrmM/UJzOe91XnVGedjJKpV2hMKpYuVmM+Y+W/pg1OwZgnTqsap4AGdtwvnkPspJm0uij8xXfD2lnBKf1M9/3DNF+jqOsApkwMpprsNxMJgke+ndGVtCkSBxlStRHCvllogAp1hnf83FVxMy1EFtvGPMK6KzKMm9DQNEsAfP1vDhzn2mUFq2adyn/YstqFEOCYxm7jWkbzEDrzd5swl5p8Jsq5CxM/ujJEqNuwZce/V+yR2qvE1exZUWG0DWUXXwOJIjKi4fzvkYHzKYhVQ1eS2EjJLANCLX+bM8qOBCbYkjjrpFhqsa5YFnJNErJxbY0HJwL7106nsvvpzjn5zx/Y7ml80J/zUmCnWYJH51mWaL+w0cwgQLTnNKuQAbT3xy2n+6vXBVRLh1F5SZ/VNIqIE37QtrF8TL29HHCyRPOPB3sH+xLWWljwndUFITeOUxf80FOv3a6j9BYuMHydzXvln3yzlMIZ/JUYx4cLSJF5MOeELdniF18wlrDB+P8BCgjB/TEt6sWHRXBtUS20qsfPxdHnFwBqDxuAdQpKQp6N5jeFvPaooY41pjj7y74AI4xboTumTiX5BmzRYbchk6SC+WBtE48alpdxFncSMFFtH+kog1D/H9iQHhVqutKWm9M0YTnjD2Zl1ONRQc6OV/af8m3Zg35eT7fzd90rtk1K0Uxf7q4wj48Dc2IMVrEjayF0LBo4+Af1A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(2906002)(8676002)(4326008)(508600001)(81166007)(47076005)(36860700001)(36756003)(356005)(5660300002)(1076003)(7696005)(86362001)(26005)(336012)(186003)(82310400003)(54906003)(6916009)(6666004)(2616005)(316002)(426003)(70206006)(83380400001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:31.5175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8c93e0-2b67-4dfc-4123-08d99fd50556
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3630
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 solomon.chiu@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Sung joon
 Kim <Sungjoon.Kim@amd.com>, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
reduce az indirect register dump. need add az
clock_gating control field used in some project.

[how]
conditional output indrect register in the log.
add clock_gating feild

Reviewed-by: Sung joon Kim <Sungjoon.Kim@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h       | 2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c | 6 ------
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.h | 2 ++
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 669c162c0c02..b732398dac89 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -302,7 +302,7 @@ enum dc_detect_reason {
 	DETECT_REASON_HPD,
 	DETECT_REASON_HPDRX,
 	DETECT_REASON_FALLBACK,
-	DETECT_REASON_RETRAIN
+	DETECT_REASON_RETRAIN,
 };
 
 bool dc_link_detect(struct dc_link *dc_link, enum dc_detect_reason reason);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index 27218ede150a..70eaac017624 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -67,9 +67,6 @@ static void write_indirect_azalia_reg(struct audio *audio,
 	/* AZALIA_F0_CODEC_ENDPOINT_DATA  endpoint data  */
 	REG_SET(AZALIA_F0_CODEC_ENDPOINT_DATA, 0,
 			AZALIA_ENDPOINT_REG_DATA, reg_data);
-
-	DC_LOG_HW_AUDIO("AUDIO:write_indirect_azalia_reg: index: %u  data: %u\n",
-		reg_index, reg_data);
 }
 
 static uint32_t read_indirect_azalia_reg(struct audio *audio, uint32_t reg_index)
@@ -85,9 +82,6 @@ static uint32_t read_indirect_azalia_reg(struct audio *audio, uint32_t reg_index
 	/* AZALIA_F0_CODEC_ENDPOINT_DATA  endpoint data  */
 	value = REG_READ(AZALIA_F0_CODEC_ENDPOINT_DATA);
 
-	DC_LOG_HW_AUDIO("AUDIO:read_indirect_azalia_reg: index: %u  data: %u\n",
-		reg_index, value);
-
 	return value;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
index 5622d5e32d81..dbd2cfed0603 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
@@ -113,6 +113,7 @@ struct dce_audio_shift {
 	uint8_t DCCG_AUDIO_DTO2_USE_512FBR_DTO;
 	uint32_t DCCG_AUDIO_DTO0_USE_512FBR_DTO;
 	uint32_t DCCG_AUDIO_DTO1_USE_512FBR_DTO;
+	uint32_t CLOCK_GATING_DISABLE;
 };
 
 struct dce_audio_mask {
@@ -132,6 +133,7 @@ struct dce_audio_mask {
 	uint32_t DCCG_AUDIO_DTO2_USE_512FBR_DTO;
 	uint32_t DCCG_AUDIO_DTO0_USE_512FBR_DTO;
 	uint32_t DCCG_AUDIO_DTO1_USE_512FBR_DTO;
+	uint32_t CLOCK_GATING_DISABLE;
 
 };
 
-- 
2.25.1

