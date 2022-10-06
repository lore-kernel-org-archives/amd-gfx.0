Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AB1C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE5810E8C0;
	Thu,  6 Oct 2022 21:28:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B322210E8BC
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sr4qb4gzGsM8ALLIvGMprJ5ZsOgf2GF/GaccArAqvzuiDBUY6n9hWf57sGvouqKkAk35pUrdSsDHICxcdhVDsjFb6PnFU8A6yRkznl47MDsdT2u/mOxC2MbmtUiVE1kTGqn4EEuzvyHDs6606UAsBuHyyumIqMCcdnZIgsfwXOR/MjyOprtZ0aWHTU+ddoplIjPFboMVWCjH2A7DqgTMBoBxopuBEieitXI8GcwMAtqq1Ek7HpgNCWqxkgcC8wx0lh69/H08i9msLImJYqkLd44nysIWU5RZmx3MGgE/40wmS0XDoCOnhYYUpzosZu+kmDt9LcyaMc/YS53jlLXtgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4YIIQEkvdDPBcGQlPQmxWdmitnN25mLWD2pAnxA310=;
 b=WgTSKcUFZ8ObYbSnbT4wl4ntoFC10i8qd79RGvpnb52XTZZ1nA45iEvUzAqwu2slwAXSp4bZapS07eqmlSNlM7hL1Tgy10lIiNLDwXssvhr3/8JVyMmYTGqqE0cOhK4jqNddihgdeNsS87ezs0j+3NumH1KUtuxe9LDDh93CZdlsCGKPhgo8tETdErOONz/h0c6U+zFAOkzuwAmO03Z+ZPo/wMfx4uIWCxaphRX2yj8Oeowb9kgbr25iW9DDGwAI6JzMGBZ/LH0I1QzBmPJSNC2Z0LaLVH/mp3v87pm3fLp2whZ96LBARuS5OZctfiPvDpQKq/84/AIjFcHGWCh5GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4YIIQEkvdDPBcGQlPQmxWdmitnN25mLWD2pAnxA310=;
 b=z8Zq3tgnaeX4FP+lbj2HKpWfPP6W/PAG6TNNxKLm4mGvhebpNLkJglHIT2ZI9O9rPxAOD6qnEBR7eDuYeMhDRMvqmy5x1Fa2Jxh0+KU9fNUTKR9I8t/HycWJc3HOLcXLKZB+yl4fKcY7xRLyhZW+3hWCiLf+fK9Guvzhms3c1kA=
Received: from BN0PR02CA0059.namprd02.prod.outlook.com (2603:10b6:408:e5::34)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Thu, 6 Oct
 2022 21:27:58 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::3e) by BN0PR02CA0059.outlook.office365.com
 (2603:10b6:408:e5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:57 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:56 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/23] drm/amd/display: 3.2.207
Date: Thu, 6 Oct 2022 17:26:50 -0400
Message-ID: <20221006212650.561923-24-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT049:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 000b7db6-9f02-4723-f647-08daa7e1a378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GITizbAFzpMVVGfopd+tDsQckryigolc+koW/I6lDTsvd2L2eYpZRjDAxnJ4igLVjRtIQhwHMMUtaft7eOioMjyz8Fm74HGLWWHmp4OLy/gFgmeCxJ7Sh14/nB1NtXmf1bsSw63wzzjllwPTnM6g98uZqDohPndG6To4codB36rvnPztP6v5u+N63Efi7EuyYD9jNZVj51UsWjmZJkBViyLsm9RdoA18n/CXVjzikWkWZWYOEnAuSHCJ9utWkAlWyAwKhpdVY/0XJHPB7O2BuVOb0tGe+JlpZyroGGaZGq+CTw7SNW2z9GgvzPyzaPZvQMUA9O8HovrrNzHx5jNwSCwHUD0rvkAALBfPo19EJCGVApvTKdZrExR5GkwLcTK9fWwglCIxIZDQwvT0cR2+ltmb498fEEd66cN/jTkrOR7dtHb0TVnh+LaSVib4xrTywNdA6HlMg9or+PGr0vENApMBvzqfBn2VRXEnKL5P5/7n6RJJxGtgJTnMyWyensvC6rx+Hc10o2aw+JM54osGtUtmuN0qY3z4Au2YzCtzgNUsBMC5ClNAkgud5LOZ46n0ZjrGj7ORpgLcHfKSoKbNCWgEB1NawZi9pUO6oQ6v/qC5YnOCB+cv8HDuypSkS5LUeg1RNBVi2DS5Xy0VktLUw+7iEXPgB1+qsltOy3sALvU5h2OQyxTOJkT+70qFJLhXLV9ajEO28Zuq1d9dO0PFwHt0fjt/vT2lP5k7Rmidi90GqVk/vb/7gxnB8AY0Y6Ur5QD0I1/RP2qWlZg73pBoND6pWZGXjWGVZmuu5HYYJLM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(16526019)(186003)(356005)(82310400005)(2616005)(2906002)(1076003)(316002)(6666004)(41300700001)(40460700003)(70586007)(478600001)(86362001)(54906003)(70206006)(4326008)(8676002)(6916009)(4744005)(40480700001)(336012)(5660300002)(8936002)(83380400001)(426003)(44832011)(36860700001)(81166007)(26005)(47076005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:57.7659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 000b7db6-9f02-4723-f647-08daa7e1a378
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

DC version 3.2.207 brings along the following:
- PMFW z-state interface update
- Cursor update refactor
- Fixes to DSC validation, DCFCLK during Freesync, etc.
- Code cleanup

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5d0103e20412..bfc5474c0f4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.206"
+#define DC_VER "3.2.207"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

