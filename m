Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7CBC43334
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C2FE10E9D7;
	Sat, 16 Jul 2022 14:36:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA87810E383
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5hRRHwKtcywEPpkD3KLuil62CB23MMHXMeVKdr533NsmQrV3+sLKd7Oo2IxWuswe6eNEN1dpEcLIJgGEEzig2qai7WCPry9HYKtQOCSW6zEqXy6GB/DLS1Ge/zBPMz88kt80kFOvZSTkWzGzaZU1FS3AzfhYng6uLG/WfeI/e4n3z7SEn4GwwZ4DTpwbFUuCv08k1xQ+D5dQ6Yh5VSsD2SgJQDlqkXc98Mamip3UHbIlDX5o5WW8OrV0HURlAFF9jhToUo6sJTV8zWL9qF8J9+SIKEw8et3FDCJGnXmrWxSYtHACE9Nu1S1oOiS9GgkaXOXPPb+NqKJhivGgC442Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpaulEUXlhkFrodhWz0w/I5wF/TvN6qk+U6jPMLKvsE=;
 b=GD00nYoCcDd8u9PO7Vz87IS/8yn4zvZmBaCr7Ir781e4wdVIQrrb2uE31NDfS4O7neA/36Jqf/q1wFLchedGFhvG1cUwLmT5RbULyY9uyMSWn4jl5QuGFkhHs2GEhfZyw0nfDPg6OdsFvUCwBl0hSCLDPEigFIJvvetXoWv813Y/F3Ejs5iE+lqp06+ke4was4ZYPrI/bQtndX+SB+8Z4XW+INbj3XpZy8KA/T2M5bJRM6UYH07PW6eusWX05eHkKvgYwYMVwEv6uj4NPR9Go4ke6W1w+RcsxjoyJb6VDD2IqKebc/BuDDQGUL55LB4hxrYQpd8FcmX73JVGqSbzPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpaulEUXlhkFrodhWz0w/I5wF/TvN6qk+U6jPMLKvsE=;
 b=XY32E5EWZfE9C3t9WIJ7g+yfKjcuqMDfNWQiAporZKQuJGgkIGBEEKiFmRfY/eMUrz25/uk7Cv/ndj3TNLEpYtdGS4riMrBcsDgxfVT5z48V+J7P5WSjKbzVvj3Km3ovOFCZN+ThM9aRXdonBUW1BBl43HG3cHiSXELvJBsR0gk=
Received: from DM6PR21CA0018.namprd21.prod.outlook.com (2603:10b6:5:174::28)
 by MN2PR12MB3024.namprd12.prod.outlook.com (2603:10b6:208:cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Fri, 15 Jul
 2022 18:17:11 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::85) by DM6PR21CA0018.outlook.office365.com
 (2603:10b6:5:174::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.11 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:10 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:09 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/31] drm/amd/display: Update in dml
Date: Fri, 15 Jul 2022 14:16:37 -0400
Message-ID: <20220715181705.1030401-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 075b6f6e-0cf7-4ffe-7bfc-08da668e3c9f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3024:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pz2qc6Llh5O8I7LG16auhXpWak/p3pwtB1DFe7Td9d1JpvoF3/FrFWFZVJ0l0B66HiRrq8gi552zTpfFt8kKe81mWlmfSMDHp4GH++W78Z3oiwLlJTbQRe/kRcE7NMxTL7im695/8l9czPnibNRLoEUL0jHKzx4NAqFQp2il8LRizsStFi1i0UeHQh6+NEpn7wFdDf72yoG1S9wBYRR5mR2kO7W7otOquNAuW+4R6pYdWXqoof3GDfs3RqAx+AFR9IYAPBhKQey9Er3mxDRQMx5/Z5dAtBdQSH3hjxE9RITx9g9vmjljhOD9bUtFXBZ5TzfDrOB8LW0yALa3rCQ6xhgWMlA8yJOX5uhrJ4OB7jwK1eY0XxcnApDRcI8Bg+7FE5x1Yl6lJh8goXQ6QdzUf8cTAWrABEtx1Q5Cvr/OYq2yFG787n9rZHercMGQIdINK0093aoyjbvx0ufvP3UK1WK0rN2xHpHsyl7FGUwBLi0cmke3cv1aFtrM/CnxsKcMRUt9uA9Cyo9IDACldBf4gmxBUZfz77KuvL0lTn0BTMOBq9jSZUYjQeR6OXtgr4DKueO+qJXRX2w1xa2hEsapf/bkeDrvzAfLKjOP2V3A/S/t11M4dKO0ubuGOjsmEcIn/adJfEU9WEWkhc+ZCe1bvevwCS2gQ9BcZu12nL3LasFvSv0RVJEs5IPvpfQXe74TxV8HDrlv07EwPPav/7dTpSkf3X5H9rpG1C3gn7+b14+7cJhhsKG+meuqIg+ndhzLUiHBdQayrOWTQX+DiMg63NmGTrmFypoACqcJedYVT/Iu7oKuR75jEmJ9rrqW6RpIG73HJWSfzpWFg9ROdYv0POUQofNGBR44L4zCgayH/WA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(40470700004)(40480700001)(426003)(2906002)(336012)(40460700003)(54906003)(1076003)(82740400003)(15650500001)(36756003)(8936002)(5660300002)(186003)(6916009)(41300700001)(2616005)(70586007)(86362001)(83380400001)(8676002)(478600001)(316002)(356005)(81166007)(82310400005)(36860700001)(70206006)(47076005)(4326008)(26005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:11.3883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 075b6f6e-0cf7-4ffe-7bfc-08da668e3c9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3024
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
Cc: stylon.wang@amd.com, Alan
 Liu <HaoPing.Liu@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

Update DML to configure drr_display in vba struct.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h | 1 +
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 87c9b9f9976e..e8b094006d95 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -499,6 +499,7 @@ struct _vcs_dpi_display_pipe_dest_params_st {
 	unsigned int refresh_rate;
 	bool synchronize_timings;
 	unsigned int odm_combine_policy;
+	bool drr_display;
 };
 
 struct _vcs_dpi_display_pipe_params_st {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 39f93072b5e0..083f89e276d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -697,6 +697,7 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 		mode_lib->vba.PixelClock[mode_lib->vba.NumberOfActivePlanes] = dst->pixel_rate_mhz;
 		mode_lib->vba.PixelClockBackEnd[mode_lib->vba.NumberOfActivePlanes] = dst->pixel_rate_mhz;
 		mode_lib->vba.DPPCLK[mode_lib->vba.NumberOfActivePlanes] = clks->dppclk_mhz;
+		mode_lib->vba.DRRDisplay[mode_lib->vba.NumberOfActiveSurfaces] = dst->drr_display;
 		if (ip->is_line_buffer_bpp_fixed)
 			mode_lib->vba.LBBitPerPixel[mode_lib->vba.NumberOfActivePlanes] =
 					ip->line_buffer_fixed_bpp;
-- 
2.37.0

