Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82014C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 03:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A6A710F3B2;
	Wed, 27 Apr 2022 03:01:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 119A310F3B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 03:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyH0aOEHF2ZeliStY9Tg4E+nOa/EeZSn1bXVt9wxrfP0y0pTMea5qJuMRI8RK/TznJGskaov/Y7EtcBHrpNLN6eWl3i81AfC5Hn4pRBKXSdwx3q7zs/9Fi0NGM5SNtMfyBhqpqw3vqnIYTP5Ed+UYgmxXaZSTWxgWROu0tgJQ2JjXn96h/bQnmcjAIdHx4JYW7DLbqofD41mSCy+45h5kphvI/UCt6OOrbQRaqhSt7XCFHUah9leHhnURXLCGVoHFbXEIwfiFmh5/wpOTh2/PTDCz8omEpHKtPonWPw6gGPsB/OadhrRKPF7WAgfJ/LI9lqUt/gVIaz3XttKFuFNRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cXG0vWEg82jQjoRWipyDuLXY0uuSr5pkIyzq0s6VSk=;
 b=JXsgDnEQtBxlaBwHGhTARJeX2QMp061lemJZTv/NnVVXIX4+94CYTru212XX8OXKi+oR2LdKrX1M/NtOWdnMyoQgxTKHj1g5qxySeTKv6UFd1rmv3Zve8n0ubvZOV2aSXXFQb+jESEcDQRHjfwHEw8pd6aQjxwXqpuzFfhplqbvWo456YGaofFbVyuplrr/muN5hJQtWaMRVRCKiRmYBgRNa94oTaKBd4ZPC3arYKURQUB5ErM/0q3OLe76BvbAK+s/jXgQ9VB3wPSJF0xneGIEdbyM5MKgXM2iFvvqfMw0dQuaRf5Rm6uyaDdKjynTQ8R/l08aZaOF9tlUsfA75+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cXG0vWEg82jQjoRWipyDuLXY0uuSr5pkIyzq0s6VSk=;
 b=NpTwcabarb46c1RLtzSmfLSKZS5jR3QZnU7puLN9+OPwGe9l7Wpf6aKi0P6BBoTPstyvM+qtIamnMeU+CbH7Q5WvJSWFt2KlYcKMRHbFxcmmTIajBuwfQA/c0B/aAKFH+gRKbkG6YcumFL2X1N91avUNQw4HEQ4gcBm6UyxqzW4=
Received: from MW3PR06CA0025.namprd06.prod.outlook.com (2603:10b6:303:2a::30)
 by BN6PR12MB1122.namprd12.prod.outlook.com (2603:10b6:404:20::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 27 Apr
 2022 03:01:22 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::e8) by MW3PR06CA0025.outlook.office365.com
 (2603:10b6:303:2a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Wed, 27 Apr 2022 03:01:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 03:01:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 22:01:21 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Tue, 26 Apr 2022 22:01:17 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] drm/amd/display: Make OPTC3 function accessible to other
 DCN
Date: Wed, 27 Apr 2022 11:00:52 +0800
Message-ID: <20220427030059.1242868-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427030059.1242868-1-Wayne.Lin@amd.com>
References: <20220427030059.1242868-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ec510a4-138a-43a1-b958-08da27fa35d0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1122:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1122BF3A9DB1EEA792758383FCFA9@BN6PR12MB1122.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d9bRbqSYnz8BuNld5IwPTDnDu/hhMToeURKoCrogzFJBZQd+GOoaj8PAmTyi3qp+g1KtzrrAzZ2If60MOjapA6pDF6rtyzO9OYfUiMgG8k7dzveAHpwrq0kKEyOBk5gVREfIDLLDgvl+I1GlCrilsgIDKi6HEsAgN5QXK5sbgBaqHW/wd/Sp/eYlbyY/2QVMwqlADexBKr7Ja4/L3BhmB9DvhgC4L+Ho76xqU4e4QRlkDkXH8OKKAj8geXYehjF5tjHNFUiPZkARetpIjrPKpGw0PiyOIx2WACCG71BA80LlrlFTaHENhOEnC9mVH1ATgGnufZjeTwActqeD9hQvviPNODO7lPUf66EoqxEYwo/3afg827bD0u/MCEkIG5fFDcEcTZsG9hfOqHHYFi+9zfw7qlabB3alcxBwZkeOB8ecx5H/u6bYm1+u6Oo7rLpnng6sKkac6PCr4Yt7Rtk4t8s7Dyo5z+l9Oqm40AWG4uRcSL2IL9nAB73pj2OsIaUqTyYjnZUikr5/QCr3WyhOaqKh2/mQo3nNftQGY1hJcHuOcUGHvD2wHBkcjPxfCyUhzUiq4B3HXQfiI88u+ez4IFlLj/x7uTij15FWZtXHrl8/kCJzCurRe7a4hgwz8f1NHETz9ccMnKBjOcZ61WDjIpRJEsmQ1gzfju8H+AZYSKVATNaMVA3aLXbHaWqK5fH3c2z2uotZPJwT7LatDxacEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(1076003)(26005)(82310400005)(426003)(54906003)(7696005)(6666004)(508600001)(186003)(40460700003)(356005)(81166007)(83380400001)(2616005)(36860700001)(47076005)(336012)(86362001)(2906002)(6916009)(8936002)(36756003)(8676002)(4326008)(316002)(5660300002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 03:01:22.2650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec510a4-138a-43a1-b958-08da27fa35d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1122
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, "Lee,
 Alvin" <Alvin.Lee2@amd.com>, Harry Vanzylldejong <Harry.Vanzylldejong@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Lee, Alvin" <Alvin.Lee2@amd.com>

[Why]
Newer DCN should use optc3

[How]
Declare optc3 vmin/vmax function in header.

Reviewed-by: Harry Vanzylldejong <Harry.Vanzylldejong@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
index 736e63bc80c2..97f11ef6e9f0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
@@ -344,5 +344,5 @@ void optc3_set_timing_db_mode(struct timing_generator *optc, bool enable);
 void optc3_set_odm_bypass(struct timing_generator *optc,
 		const struct dc_crtc_timing *dc_crtc_timing);
 void optc3_tg_init(struct timing_generator *optc);
-
+void optc3_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max);
 #endif /* __DC_OPTC_DCN30_H__ */
-- 
2.36.0

