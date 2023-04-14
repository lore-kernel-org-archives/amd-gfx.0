Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2637C77B72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A024F10EDE6;
	Fri, 14 Apr 2023 15:55:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01D2810EDE3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1PBjWDDZrp+5a4MBDBg3ixPMKG65kjum3/qLe+9BLLE1VNlTdZ1KMOE62l1/Lj1QVN8PoPytqT2lRFiwZeyPgYZ+lX6bxJikYSIjbjhmXdx6Ol+ZfcvTRPaKEviHJ1louheqUJ4f6cJysc81mTlmleQ3lkN9Y7S0Cukbxz8WlDgRTHfGXomFcEawm/r6ukK2Vs10arumSaRVkI48sTtiG/GU0iUzCbWAxzod9E90z/tQuDPJPiqYJZ9TR7I/P1rcp5KPlUQWMzqKeO+4QQaDkvKsk1Jj7EKsoKNlZ56M5LBWi69P7g+WMm61p91kMbtt42Fs6r1uMFBJ0GyFbc+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOOJohuBEzEbJUk/OdKGaYTVxihepYZ3pmif3CzAbd0=;
 b=juEvf2Zr+L+hxyT8dpG8xibyKUICuW4kyBF2D1Jn8pWY1oBC+5ZyNbv1IeaakIuERTKLn/R6XjmDynPIf8G+eTw/f7ek8X51gL/CcKh9aODlDy6+uAKEAbYOMYSq4aXcks5gOwt3oGnibpKrqO5ekG+FoZboeRendaISwh57+/vxo/mzdVhKfK1vFiEzjWwQm0wc7EOtmTjeAZmEHvFUk77Am6RjbJdewhmHDWO42WuA4jBlIw8W6WyX62rmfj05bK8lZhb3G3UxM4gu8fxAS2bLHSwjXsnKub4IHtgLVzNKDjgYCcs4hCnolxAgeWRTedBGj342Xe6B9XTl+ChkFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOOJohuBEzEbJUk/OdKGaYTVxihepYZ3pmif3CzAbd0=;
 b=zptmfnhmoNBMiOrC5QFW8w7q19QPC+BoPeBk4odkErLS0n5LRIlg9a9ZPJi4Vn48J9zJft1LCCDSiRbxKc5U2i/vJ7rGfaaSXllndsH+zFaZxUtFwjHn1yhBeKOvFX+XwckB5O7cMdxjyIee6L3qSEHE5mx5lR9YT8KnPlS0+mo=
Received: from BN9PR03CA0434.namprd03.prod.outlook.com (2603:10b6:408:113::19)
 by DM4PR12MB7575.namprd12.prod.outlook.com (2603:10b6:8:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:55:01 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::ec) by BN9PR03CA0434.outlook.office365.com
 (2603:10b6:408:113::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:55:00 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:57 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 47/66] drm/amd/display: Do not clear GPINT register when
 releasing DMUB from reset
Date: Fri, 14 Apr 2023 11:53:11 -0400
Message-ID: <20230414155330.5215-48-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|DM4PR12MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 0360d15d-f2b9-4c04-982b-08db3d009ad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bkxor3ehvaxdejPZcG/kIa5Mlm3w+TsrsYuqABk02MRlI2WgO+edSzFuqxv1GA90KgcG16h4uX1b1UaXMM4S6eipCslCBsNkRGtui7lOUkt7H7cahqELsUvsdOAisTJDeHE3J4PR0pBBlfvBBC/crNIjrsUPHicVHd9pl2rO59cG7/P9xSm4VJtWsrtU9+yAWVcp3m1g1kLO1TmZaDwmP0A2JXRRJdrL3DVBOlfICAFwnyvrL+HDRDzNNV0QKr9kAZYOGA9gEDHSmLDiEzjAIIHsRhDhVVNzk7eEfFrMFBfGjqBUc3HSSKocXGxn5ra35wt43ey5KenPummVvoPzGFHgy3qvQKWnFQndlYjTUY7+n4MZ5nvsHjQlKTNQafXqCLMM0v01M04TE2XbaW5YTSexKmnx+gz01Qy/NeejAI3SpF3xI1Up+6K0pbUypsrzCxIg0bwmcdtMdJlqD/usrHy/yb7FjR2kapzNYxDv0v1tksBiZaBdvtHGRuMjMZFDMl79prXdR5+5ga6LyHaSlAKJauOgnmdA8xYQx7FTesK9tS4/lmKjLqnkI1IW8nfl20gDdYJJ6xwLtBjwoDEa1pO3lSwBfv4L/h2kJa4rGITcBlKUM3Uvgo6m2tkUNiYCZUJ3RDeQRGDhoqGoBX/TLkb0F96fIr4keHR07woi9+q1fgpwsJlsnv+gNmYZvNwuYLAovDszH+Vo2+bBlxmpPScKqcMuRZomWljF8h35+XM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(336012)(426003)(2616005)(47076005)(2906002)(40460700003)(82310400005)(36756003)(40480700001)(82740400003)(86362001)(356005)(81166007)(36860700001)(41300700001)(83380400001)(6916009)(6666004)(70586007)(316002)(70206006)(4326008)(8676002)(8936002)(5660300002)(54906003)(478600001)(26005)(1076003)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:55:00.9244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0360d15d-f2b9-4c04-982b-08db3d009ad0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7575
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
Cc: stylon.wang@amd.com, Leo Li <sunpeng.li@amd.com>, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why & How]
There's no need to clear GPINT register for DMUB
when releasing it from reset. Fix that.

Fixes: ac2e555e0a7f ("drm/amd/display: Add DMCUB source files and changes for DCN32/321")
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index b45ac31ba555..a7d5607459ed 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -137,7 +137,6 @@ void dmub_dcn32_reset(struct dmub_srv *dmub)
 
 void dmub_dcn32_reset_release(struct dmub_srv *dmub)
 {
-	REG_WRITE(DMCUB_GPINT_DATAIN1, 0);
 	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 0);
 	REG_WRITE(DMCUB_SCRATCH15, dmub->psp_version & 0x001100FF);
 	REG_UPDATE_2(DMCUB_CNTL, DMCUB_ENABLE, 1, DMCUB_TRACEPORT_EN, 1);
-- 
2.34.1

