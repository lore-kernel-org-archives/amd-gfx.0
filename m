Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F85C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BEEB10F2D8;
	Wed, 25 May 2022 16:20:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7229910E814
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTzUOTdQVOYE4yApJJj5qd+kK8noE32kwsZ9rqH4caurvsISrzBdfvU3icqDtFx0GmFOYt+uWR4OdPtB8UlklBVPBw6Z4fobqTtnNTWAfva+mdzcD+lx91yoG9+Eio4vIRi2dggvREc0IcG7Uw/jbR1AmRNWC49M1c+0y7X3IV8Y3vBagF8rRccUlg1Cwya0UPPycWTohU52/vxP+Ma6zdI0RuggAEEPCFlCow1R+uwLbetF4T3RSvS2krmMFygP3RAt/ika3wKsM4t+jEvTYdMpOshk1ISaiIQ4rTo+5i5OaDZP5SQDD0ZInJ+rk/fV5R/QKKREFk8gx5FNIccBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LYtLTyE2rHynen3yq5ayWh3HJVN0ljNdiDq2ToHfZE=;
 b=bGgQlKmTkRdBuAkQc4p/y1+hquLKYjkRNtEnOAySUZ+x2tviVYYbCBnZ+dzFdWUnP/gaE/RyySiGMlWyGiPE0c330cDu2JgLDrk283Yu4Mw93wwA3cDucHfhv+ERJ+glhOkNJpHhdYYzG0dAR+Ciofe7KGnREnHv2XDsrhVbq9/MS2AHEveB/WMBxImUoOYn5ov8hMpu0TGr/OXGuIEDs42Xv2vCoZi6KQRCJdtBVUWaCMmlPrSqmgsNhSoxPI9KLeZ6zE6Uxr4Wmm4HDsJqNhLq1gf+sOLD5OE3GHD/yjBZWHAJOMSSLT+XsCiiSOG49vJpDQxeAWV8E+uKAVdj3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LYtLTyE2rHynen3yq5ayWh3HJVN0ljNdiDq2ToHfZE=;
 b=vp0qgpJH84BQiy7XsqvmoOBv3IFlztqZIrlCMDs2am3fp3BZzbRpWo95x0qFXtnrPV8E1j+WVspkJYZffdyzbOuLAtXHthvh9Uuvma6BQx4isZZjurI4u29hK3/pRrQxlqOb8ysfjQvqxBcRbS9xyjeH3ksfuMi+8MR7Fs9Z9G0=
Received: from DS7PR05CA0097.namprd05.prod.outlook.com (2603:10b6:8:56::26) by
 DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.15; Wed, 25 May 2022 16:20:18 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::82) by DS7PR05CA0097.outlook.office365.com
 (2603:10b6:8:56::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/43] drm/amd/display: Disable DTB Ref Clock Switching in
 dcn32
Date: Wed, 25 May 2022 12:19:27 -0400
Message-ID: <20220525161941.2544055-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce877631-9928-4744-3522-08da3e6a752b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0201:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB020167AC1CF9FBAD19E7B278F7D69@DM5PR1201MB0201.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9ZWzFqcgHq/VXLHU4ULKHS9MUvmh6idR7OA/INHeZhCVIVVgZ3vEPMCCJ0C9vr65irOe/8CZmTpUEcrB8VAbgBMK4e2An46cauS3OrG33oCk1HVAQLTX1UML9T3wykLyjNd3iNBaIrO0U2rKSRkbeF1e0xyDsMTJvxUUOeZRQE2Lz2ZM4P/ny1l0Jd6MVLMBmz11Q5nmWvCQPrNAHn8NaRRCiGwMO/x97X3UakaXqsHcX1Zi9LdDH1qM2NFWeUAn9Ncgi8dJDt2N6PViXGpQ9bUluZlOqYR2ijghEbKveRCJCGQfwnJT6wj2uQZeleUhk/BtQO4PdYR+/zp5uEpi04mhRinovmmsApLUWEd/VpiWNzLn4XnaYzr9hc+++7RBS4TxrcRE5QtJyjxg20lrfpnT4Iu+IkNS0JGrQwbGc+Fe/fGXBTqc932/vJlyKQ2QuV0KsZWDZE/fWg+AGtzSvkIiNLPLLuqVj+uaRJaKGDo2mQi0M/4x52AkN7ZUmeuOEdXxxSNfqnq6uNB4DmI+eM6M4irA6zXgLBiAcDk5vkcc4ctciYrDjidreBttanQ5CV+ooDM8YhN/cNLqToISXJpOjktDrL9WhuYuWo43a/Qfs/JPtB8ECftuXNsM+qoMdaLSnRQL1rB0cua6EkVfa3SaYzsRtoth0XT61jJTMCFl2Ffd9gmFaMBxBbN/b6q48BNTdvUWYgnJtfxtfNtVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(54906003)(6666004)(36860700001)(2906002)(40460700003)(8936002)(47076005)(2616005)(5660300002)(508600001)(86362001)(426003)(336012)(26005)(7696005)(81166007)(4326008)(1076003)(36756003)(316002)(356005)(8676002)(186003)(70206006)(70586007)(82310400005)(6916009)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:17.8630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce877631-9928-4744-3522-08da3e6a752b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0201
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Dillon Varone <dillon.varone@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

[How & Why]
To be enabled once PMFW supports it.

Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/dc.h                          | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 774de29fa532..f147c65137c6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -607,6 +607,10 @@ void dcn32_clk_mgr_construct(
 	if (clk_mgr->base.dentist_vco_freq_khz == 0)
 		clk_mgr->base.dentist_vco_freq_khz = 4300000; /* Updated as per HW docs */
 
+	if (clk_mgr->dccg->ref_dtbclk_khz != clk_mgr->base.boot_snapshot.dtbclk) {
+		clk_mgr->dccg->ref_dtbclk_khz = clk_mgr->base.boot_snapshot.dtbclk;
+	}
+
 	if (clk_mgr->base.boot_snapshot.dprefclk != 0) {
 		//ASSERT(clk_mgr->base.dprefclk_khz == clk_mgr->base.boot_snapshot.dprefclk);
 		//clk_mgr->base.dprefclk_khz = clk_mgr->base.boot_snapshot.dprefclk;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b6decdf820fa..e25e91bfe763 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -430,7 +430,6 @@ struct dc_clocks {
 	bool p_state_change_support;
 	enum dcn_zstate_support_state zstate_support;
 	bool dtbclk_en;
-	int dtbclk_khz;
 	bool fclk_p_state_change_support;
 	enum dcn_pwr_state pwr_state;
 	/*
-- 
2.35.3

