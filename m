Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE4EC4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C90610E9AF;
	Sun, 23 Jan 2022 18:21:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FE3D10EA17
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIH/Nq9xRmw+PuRKhephpHAPJGBHkbp5lfk60NlpBHJdqg1g4CaNsJiv8+jWTIodnJOICmMI9D+qVP7rGcRYDEahAz8o6bluoYbr2EzGVVskUYoWLij6NzNJal11fyAI3tg/dDltQDd4zCU13vanYuPEj0uDwX0P7RT6N36DJ2I/uuWl49J0oGMqFQfJbYKYo2VswpPsydsLMhn+d0zn74l8SFl15McP9xEAlSZaFCQsqRTqHS4iYANhHIVRCZPVC2CWh636/ydImioi3tY6uZjoH4xA3dfFbLqSJ5nHxjGxoBzBz3Xy6boOOehLBe3GwR0jwkCAqTT+00HtQOXhfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGcRFJyEHaL7fL8iSS16cmDeIw+mLQoUJhphhBt7m6c=;
 b=LGyxgzKk1ra9I54rjldclQKGiY6gSnuXFLFzgNIBOVpe2jgtsOmdbj7TObcx7Fdwswutx1iTiaiKyVipvDTWLJXPExMLE5BCc24PgvAkx2oeBR+vEMI9BX6R6DFpXN8P5a90rSSbfQdfpXJU6k6LbeerMjQmpLA9aIe1dmBRMZsH89C1MHq83qDPJbbTZWK83PjYkfRcVpG+dMAVxtytDZtujR3gkQX9OsmwejXrBh9+OeSWasLEEX66BJWc2Kn1wAcs4tbZUI2KeO4TN1fHwHAlqH5cCEt4260kSJgAWNhQSFxHAH3h8DdMReY0YKuqvy4A4mvAjQNRtld+0Kgh7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGcRFJyEHaL7fL8iSS16cmDeIw+mLQoUJhphhBt7m6c=;
 b=rC8pNSfvTfPGQy3deot9RRqevDC24XDhzeu7kzXNvtWAA+xt59omxj2vRd1lvAFijw7qJ7b2E+eQoxmuEG+GL2ft8EQS1v4KvhfOlum4uVqyceDEezA9PV7S4chCwTexrqSwoqG9IvQ0TDYoRImZ0QmiJODVZkKKjrOA0u6Wgtk=
Received: from BN9PR03CA0967.namprd03.prod.outlook.com (2603:10b6:408:109::12)
 by BYAPR12MB2726.namprd12.prod.outlook.com (2603:10b6:a03:66::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Sun, 23 Jan
 2022 18:21:18 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::c1) by BN9PR03CA0967.outlook.office365.com
 (2603:10b6:408:109::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11 via Frontend
 Transport; Sun, 23 Jan 2022 18:21:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:21:18 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:21:16 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/24] drm/amd/display: fix zstate allow interface to PMFW
Date: Sun, 23 Jan 2022 13:20:20 -0500
Message-ID: <20220123182021.4154032-24-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d7e9d455-0939-4e50-603c-08d9de9d2654
X-MS-TrafficTypeDiagnostic: BYAPR12MB2726:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB27269B7C9C2D831C4EF077FD985D9@BYAPR12MB2726.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFLBfAGiMynrE5b6canMhPtskBaz686IZQ1RcegcCOdJ9ug6eLhXEhf059NW0AZPIEmEVUn2Inqaiban2WTfRRnxYBBS4rqkSWXr8h41JjCcCQbtRjah8lVbhgA8wCYS7kORt50f0IAFfN64IuIv10z49+8J3aSCexmjASp2rBBLj/GWRF1k/i8EBgWy3QapnB1Obg0U4Gq38E7INQL6PV1z5znMRuQIsB2ocAFat1EQbtcDPXgeV2M7IHtcZDfxrlpZ3QKtafSCrP87DBQLz7ILml60Z0U/0Aacg9uxw0SUIFw0SV6E7vY6oO96GHREidl+5C/u6ZlSOVCr70WRFtzMw19O4+NJw9l6xgewbK3hyk6h8R0WVSgGeIROI8pl2U+MTJqkllNO45uLYQdWP3F4TLicpe+Zl7JioRyr69OxGEEBql7z9tnv7UulWz82wXTDy9hIQCTskK1jnj1E+3UzyRNgjReRNqVIBgEOPfvOSq1xf1gEz1mGwC4oZIJngaUFx4748ppisM491BPbljj4GZOeGa1cHSPizOcuc7SV5vRl2wkRsOkW16gxlmnhmZqI/mkBFF0VkuRiNiLM1o3929C/fFaCt3tPCHywilQj/I6w/YQ267eXJf75NKiGsdV3QO17jjemdsNlEkcbaqy9IugCwFMC1IJc7MxwaemOGJlo77Ty8+BMfBgNMiEs/8yH/aDvYwcryNM9/620zwyzTr0svPWXJgRxhKvqPuH/BuR3Nvm6VxIAXI3YNEYZzWpzsty7xP8TqZhX1lSih+YfpOfGfVH+LL+a1Okx3Ak=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(36840700001)(46966006)(4326008)(6916009)(47076005)(2906002)(5660300002)(1076003)(54906003)(508600001)(81166007)(82310400004)(316002)(83380400001)(8936002)(336012)(2616005)(36756003)(6666004)(356005)(16526019)(26005)(40460700003)(186003)(426003)(70206006)(36860700001)(8676002)(70586007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:21:18.3462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e9d455-0939-4e50-603c-08d9de9d2654
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2726
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
Cc: stylon.wang@amd.com, Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

[Why]
psr_feature_enabled flag is dynamically updated, and sometimes when
zstate allow status is determined the flag has not been set to true yet
even on PSR enabled config, lid off/on is such a case, which will result
in zstate disabled even though PSR is supported.

[How]
Check the supported PSR version and the PSR disable status instead.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index d0a5c7afa265..fcf388b509db 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3099,7 +3099,7 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 
 		if (context->bw_ctx.dml.vba.StutterPeriod > 5000.0)
 			return DCN_ZSTATE_SUPPORT_ALLOW;
-		else if (link->psr_settings.psr_feature_enabled)
+		else if (link->psr_settings.psr_version == DC_PSR_VERSION_1 && !dc->debug.disable_psr)
 			return DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
 		else
 			return DCN_ZSTATE_SUPPORT_DISALLOW;
-- 
2.25.1

