Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C37C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA31010E4E0;
	Wed,  2 Nov 2022 16:03:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AD6810E4E4
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:03:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BR5Qcbm0PWFSfya7aKDvXX7rBvoVDyIl9ckQsKZ9uYbEnEiMNpwz3XJ4CLhwmnkweOPpSqTSG99f18t2M5Dd6bhquEWidiWDmunYhHwx0sUx2ZroGR0sCSLmnGtybP/IMkAh96oZXT+w0iYUn7eqUM2I5G3/o1ABnd3CIyhudiw47yIXVz+hW8m5b+9pswaAdzpYFCfVfgm2hTxAXPP9XbJ92nc+doNJgAAmpnD3ZcJc1zaYAGOZBq5PIok8Md4Ol77gW2uyAXY3jI2XAxf3/Yub3oL8QnUIym/8c3DZcCz9N6W2KZEGseukFzr7FaIK0xaZva91VuhA+1KODsfeUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/K5QNCK7+kBPYvedhuHewsZDp1/J2+Q2jpsMNkWwrik=;
 b=hXX5P5qYIeWTamSQfAl3ozmO80J5RYwNA66bPVbs7KYaSilL6bFeq5B0/QVIogwfYU/DL9M/HsQKHgS4q5EJHaiqQc0ASWn/4DUMoEE3lEjit2U0fYm9fWW9ZQmPZ00XZx2JPxl0bor+2KjMCxSoi1a6HIRIC489QqTEtp2N8JHSQ9Ky3IjnAbGC0SEIOIEEAQlDq7udwr0XplYxlY5wUZVeSn3WvLFfrFVM/OmAVITijIel9m7cCpscJnsiUuLt0cR+mlJtdaIhk0rytvh3xYzg4ZLyqNxB1V0Nwbmo9PNr3GQmwqjn1L9afwH5VqOj1XdS+chYFC+Omdyrv61z7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K5QNCK7+kBPYvedhuHewsZDp1/J2+Q2jpsMNkWwrik=;
 b=tIycJioH4c3O3PkTFs4SkKota5PCvR8r6D8JEGlT+DlN7zdnr7ZTGtTZ7dafticFvHqfPcF+DUn6Y7DfQhLXmzZnWCJ92SsaMVJVN+3/aSMPzByAte4NQoe+aWN/5SL/GIxKPiA9iOcR7jyiViqEPiVyTIN347t3LUFBATslNyM=
Received: from DM6PR18CA0006.namprd18.prod.outlook.com (2603:10b6:5:15b::19)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 16:03:35 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::e9) by DM6PR18CA0006.outlook.office365.com
 (2603:10b6:5:15b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20 via Frontend
 Transport; Wed, 2 Nov 2022 16:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:03:35 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:03:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 09:03:34 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:03:25 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/22] drm/amd/display: Zeromem mypipe heap struct before
 using it
Date: Thu, 3 Nov 2022 00:01:04 +0800
Message-ID: <20221102160117.506511-10-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: afa7f4ee-2f3e-4096-0d30-08dabcebcc2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/rfUpSZg69rAvlan1KNyxeQ6xFTz0U3EiU+3/d6ZTuErAPKDgKd0RfrH7AT7HL7+K5b0Clg+Vi1wma0hZTOIFxgwd+G7ZhU4tuVhIiMyg6SPYXsxrWSoZHwWjtoTo4UT7vJgK+rGJVEhINU+4yyzftAxG/G8st1RgNE03Xlc2+r+UKn9SzxmY296G0C9KagljmpcapobYl9Fp1MeXgt2mWDXBXyggLHHQiUjntIqqhz8dgI6sS/0xsFGoa5oGsj9NJS1rwIf2bQzfSqEdYVBU8Gah0rZ7UNdDAFhQBLteS5CG7ozZhbm8o21pnZJ5+qyFe+s+nj+x5gOGVbviVknryFepzwkfmAaG/sr7QmC6reD9ep3DgysDj5rUZTFPH7wc37XUdTQxLIgkkX1DdMc/OdWxBcmX8HlVtVBJkquMKcLJKOC1e6sY93S01TArMnWKYspiswta0RoTqFMNvuh7b2khPTFMdOHJ058Uu7nid7EI9Ovfh2iFVMZfSfOQN7upOIjhJEZrfdRgQJmqZ5+Ezqmd9o4QePA/O5q7JCa/46fmZ+gEg/Dft3D4D6ENrMrFrILM3NumJ/FaAnxoSxIQzsCpuIKwY45nJsHWCpgTiIxReu01omjZcF4wiMe4DVHO3zhsyG/V7Qb3pTGeo4fx8b4n4aXdTNbxCZdfPd5k0rBvXqoq1BmFaHSjab0Om4Y3EFXx1ttH86dRr8JbhYPFLUmqBECNUOV2lwrText53IqW771cCWedYEr87NCzMYbPhIj/yKUUtkwHwM4TIXSk1Nehiqty4uhfTPxjf0cVxrzGypAoUDg7M2YW387cR1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(36756003)(426003)(36860700001)(82740400003)(81166007)(356005)(83380400001)(86362001)(47076005)(2906002)(5660300002)(336012)(40460700003)(186003)(26005)(1076003)(2616005)(6666004)(478600001)(54906003)(316002)(4326008)(6916009)(7696005)(41300700001)(8676002)(70206006)(8936002)(70586007)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:03:35.4471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afa7f4ee-2f3e-4096-0d30-08dabcebcc2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Bug was caused when moving variable from stack to heap because it was reusable
and garbage was left over, so we need to zero mem.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 3d184679f129..ae6e6abc620b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -3192,6 +3192,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							mode_lib->vba.FCLKChangeLatency, mode_lib->vba.UrgLatency[i],
 							mode_lib->vba.SREnterPlusExitTime);
 
+					memset(&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull, 0, sizeof(DmlPipe));
 					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.Dppclk = mode_lib->vba.RequiredDPPCLK[i][j][k];
 					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.Dispclk = mode_lib->vba.RequiredDISPCLK[i][j];
 					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.PixelClock = mode_lib->vba.PixelClock[k];
-- 
2.25.1

