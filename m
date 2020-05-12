Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA33C2D0F6
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 16:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058FE206B9
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 16:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X0Wm0ras"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058FE206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F23D96E942;
	Tue, 12 May 2020 16:44:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 029EE6E93B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 16:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQIiSvRZTaTAtHsGu01BOFjMxQYi1Go9X8N83c8HhgdSQ+Xc1vIEugRXgFbHLGoq7drzIbRV2u13eVcZRAVPyZI2TK93IsiP99HBnsAN3gWAzLg65KnRI2MhPsY78IPbvC7oS66J2c5PzRKOj6EL4MrT0O5AKwGue9Gyd8UZKwt2S/aIfbQ+sfzn1CAt2cd05rP0Al47Nyi0WIuSK7luXLoRjfoQQ0+onRZ0W0HcYMIfZM1wzz/wC9oNxyxChq9jTks6SF7NDzH3Usg7kTa5hptQzPdQwepHeHVYxn1mWmXUAwR9Hv9roOQb9zzk+FpICTr1D7lRyOnECBio/BP0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLI3JdMxfMKzAz6jpFJdaz4xKoVqcemo656QNoUz9x4=;
 b=QO4U51NrMUsO34GLwxf/T0OdEVVlbtMznk4AFvuDIObSzhZTLFKkpInao0JtAbQs3r91r3YMSx1YoLKCrZk6OlwMnI9ye0dzqU3BNjs2MFWn8sBNsynGvN9/TiHfdkDO7RZxztgh3Pvt+lQzp8WGEyAd6MhYu9IMbAWMr3pRnKrZKfr6wkozbpj5Kt1kyb9uZFkNbwSOTdjZen841aFx1/6w/w02yBA+XG1M8RkLVmOXWydoibyT/InS0hHWE7l3tYbJGeEQBXfMzAMPzrsWmLvFZKKX5FPDQJOXTpkMqBUCzCUsA9BwhlJ92OogN5E5ThxgL9wqWyJhW6ByBrLMXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLI3JdMxfMKzAz6jpFJdaz4xKoVqcemo656QNoUz9x4=;
 b=X0Wm0rasgyGQzkNw672jq2L5Syo0mI2bGD/h41OI3rQQ8aEGAeIIWtOV/kx/HjhZyOizZmPcoVVFz9vbZKtpxcfAPVo6jpsSiaUpcS1+88zU3vSmNR4PziIkrZWGTB0Yuz0OvELA9n3U2FCrJNezuHqjmCBWqApyWDRgRXTgBL0=
Received: from CO2PR06CA0067.namprd06.prod.outlook.com (2603:10b6:104:3::25)
 by DM5PR12MB1738.namprd12.prod.outlook.com (2603:10b6:3:112::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 16:44:39 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::5c) by CO2PR06CA0067.outlook.office365.com
 (2603:10b6:104:3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend
 Transport; Tue, 12 May 2020 16:44:39 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2979.27 via Frontend Transport; Tue, 12 May 2020 16:44:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 12 May
 2020 11:44:37 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 12 May
 2020 11:44:37 -0500
Received: from hwentlanstrix.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 12 May 2020 11:44:37 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/display: Fix disable_stutter debug option
Date: Tue, 12 May 2020 12:45:05 -0400
Message-ID: <20200512164506.26861-3-harry.wentland@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512164506.26861-1-harry.wentland@amd.com>
References: <20200512164506.26861-1-harry.wentland@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966005)(33430700001)(82310400002)(426003)(8676002)(2616005)(8936002)(82740400003)(86362001)(316002)(70586007)(47076004)(26005)(36756003)(1076003)(5660300002)(336012)(356005)(70206006)(7696005)(2906002)(33440700001)(6916009)(81166007)(44832011)(478600001)(6666004)(4326008)(186003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1147ceb8-b328-4be7-36e8-08d7f693c2fe
X-MS-TrafficTypeDiagnostic: DM5PR12MB1738:
X-Microsoft-Antispam-PRVS: <DM5PR12MB173885CDC4797773B8EA53B68CBE0@DM5PR12MB1738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFQAuzsbl0sPhUNv227G+mFwx0+/8GvAANwH0fG1gPP3SIKtOX/LDOAytCPfpwZaLil/lDLH6vKbbx0/KzLJw0Ze2+hObfUn+nDSBLJaBbF8Z71ce665uvioVUE/lKjjACbJ2B0F9VHgi/hxa1ITwaQ0fWin2vjXJaddhnjpDX1zOLfaa6gq4EjkCgbIC63Yr4SvPw9etBU7aYRGFPJgVcKBKyZk+jz9Ea5FffGmF2vvpQXkuxCKa/sq5LOlLDX0Ln+PsXw5+F8wu/ekXO1kJYP7YbpHIaWkBOo8w57D6Kh7lh64h8swMmx9yws3GJ9UJGdp6XmnqMQBtUOmpOGY1ZGv/BV9rSxEoSHXNAnaPozk98mHsic5aES4rQKFpGmnwIsvtAl+r2z1PFt+7f79CQWJY5m/iBQgzHHx5PhkxN7My283BhnkAzMIGlg2npb7841SVgTk1FvfZUxLVwKLtA3qomFaTjCbVxoEV1ArVv8iXSrUdKVSTrMFeB1L1X4+ilDcVReuGalqxI1ZlI7TUMM756EjLk3TzTEjoeJ4R+ylDEE6jzd+83EObJX45c0xdibNxFgyjIswxUlp2DHlcQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 16:44:38.6680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1147ceb8-b328-4be7-36e8-08d7f693c2fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1738
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
Cc: Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
One call was forcing stutter on instead of looking at the debug option.
Ensure we always check the debug option unless we want to force stutter
off.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c       | 1 -
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
index deccab0228d2..75637c291e75 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
@@ -93,7 +93,6 @@ void hubbub1_wm_read_state(struct hubbub *hubbub,
 void hubbub1_allow_self_refresh_control(struct hubbub *hubbub, bool allow)
 {
 	struct dcn10_hubbub *hubbub1 = TO_DCN10_HUBBUB(hubbub);
-
 	/*
 	 * DCHUBBUB_ARB_ALLOW_SELF_REFRESH_FORCE_ENABLE = 1 means do not allow stutter
 	 * DCHUBBUB_ARB_ALLOW_SELF_REFRESH_FORCE_ENABLE = 0 means allow stutter
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index f36d1f57b846..daf6977b5fb5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -737,7 +737,8 @@ void dcn10_bios_golden_init(struct dc *dc)
 	if (dc->res_pool->hubbub->funcs->allow_self_refresh_control)
 		if (allow_self_fresh_force_enable == false &&
 				dc->res_pool->hubbub->funcs->is_allow_self_refresh_enabled(dc->res_pool->hubbub))
-			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub, true);
+			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
+										!dc->res_pool->hubbub->ctx->dc->debug.disable_stutter);
 
 }
 
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
