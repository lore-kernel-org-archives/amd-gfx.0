Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB3DC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 14:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A648610E612;
	Thu, 17 Nov 2022 14:49:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97D1510E612
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 14:49:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2rW8t4Q6gtcukuFNM0fYPThKIhQtP06rzbd7nnCK2hjb4DTz8FRyHMeFFhZ8cyrS+3c+qwFdX94lrHrLNBfULMs106Pn9qbQlhU3zubv0enGNlNjIrsLV5Gt6WXxGEKvi17B8ZEdJ1pwLpzk88HwJeKtx978+aOVGe2AU7nk3193Wn6ekgo51vyOUG/yX3cLdzWB5fdxqxCwA2/Diqu91rDkA46271tCA+oYl/8yRxs6tB+GEgMV+SXJILR+h0dahEXsOgfq//+CLQ67bBYFtysVp7HmeTVqpPJtpiY58Sm/vFkVO/pKNx6rB6nuyqSwwXaEGKRNOlbJkGH1OwPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxuCsKY0CHi0p1TW/T1AcerupWhZvMjfVmiYhlmScW4=;
 b=KozhMnXzyC4Auz9RFK/mNa/y4BNi7STPigjvvuirHMhfUv5CAMKDFHcb/X8D4XjfUUupaWo1jwmlD9hXyHXfldbQLFbBXE6XXAcFdlGNJQItfD3Y14pn6gqhDT0Q9+DGS/JmSuSruv2xzbPzRjFt161MP1QuGq1AmEFkNkPGoZbC8cqYXqu7iSooMtaVnTGueQix3/vI+G6ne5GjUWQbl1A5VeooWkMb3Juggmk+JeVjg5EmyTm8RaU36xb4ymi6YhDrN+8AydFonkuujWDfewzoCkhtyEAkbkwJouNfhWHnIYDbU3wIXmW5Pt+dckGgXuCI3EsjIvuOc8N5n0ri4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxuCsKY0CHi0p1TW/T1AcerupWhZvMjfVmiYhlmScW4=;
 b=BiNw14up4IzB4cxLMc9FqXVZqSBhbNWOWPaUd1+rDWq54ieA4ZlDaLfny8DLr/HXwPpByR9Xv/qeG6ZIeLm1vLiAQV9qUkQNrT9yTk6CQSzjHmqD1TRQv3P5h9YAm0uW7XnAbneUyAFur4hvaVzMPGl8c+7dKD/g7IhcJYyVk9A=
Received: from BN9PR03CA0711.namprd03.prod.outlook.com (2603:10b6:408:ef::26)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 14:49:51 +0000
Received: from BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::92) by BN9PR03CA0711.outlook.office365.com
 (2603:10b6:408:ef::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 14:49:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT090.mail.protection.outlook.com (10.13.177.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 14:49:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 08:49:49 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amd/display: fix dpms_off issue when disabling
 bios mode"
Date: Thu, 17 Nov 2022 09:49:33 -0500
Message-ID: <20221117144933.1218097-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT090:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 81af5201-7014-4770-e384-08dac8aafb40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lm+pn2s+URNMGcQif75O1V1nUzRL6JcVVmtptymeNjwEIYDRgP39RQkA3VcVQlgqCTNJhtbDicXaCtL1Og7te+MxG9C0xIDRN3cR1NErSJgFPI37WBg96OYCwNy02Rp2v/hlBK0jcYxuRy1WJsU5WwKl8inN6G1mF4z4EEjslxMN+Waoyrg9DutybmaC2PZVn/DgsqhK+Gwjqyv8T2/dmmYbxbYHJ9tCB+L9XJJLU4ywwWNCeCLTJc6euoiPo+mpcBffWMhGqqFwfAz62Gp89p3V5ncj03arJ4Ka6wI0/uQDx4e/sj/zWfgp3UphNnTVeJJGGHFGrx52Jkty9K+7p6Op6Aqxzy+xbqQZKDrdYHI4TJYCZC4qyok//XkKjjc+1qsTMftM8a/8BsVpEdrPFA5TVZU7XZ1CFUgMr0sQLpP4X0XgD6qAoPEfaMg5lqU1sBwQi8WR3G7zG3MowuGsk2WIdyIqnJH3QllY9VLbN89f7yvv3InWv0Xu/MwY2OfDwED9g5tfJK9+X54r39e2zBoWDkcX+NSwUJGhmEJT6xYp6Z8KRf1zWPOTWeQv/Fp3BGXRfoL1TJA2zlc+a9f2gY/tfS8uk8SIV87ZzexKd3njFwDj9jaXr0GK4nFU8SMyEOuUay2z8xae4vE6xn5tQ82G60xkpisY6tDJbID4LlTgy3bG6CViPkplZORCk8B7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(36860700001)(6916009)(2616005)(81166007)(356005)(82740400003)(86362001)(966005)(70206006)(478600001)(6666004)(40480700001)(1076003)(8676002)(4326008)(316002)(54906003)(41300700001)(8936002)(70586007)(5660300002)(83380400001)(2906002)(426003)(40460700003)(47076005)(4744005)(336012)(186003)(7696005)(16526019)(36756003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 14:49:51.1050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81af5201-7014-4770-e384-08dac8aafb40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
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
 Zhongwei Zhang <Zhongwei.Zhang@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 5aa663752ff6f844c6bfc97d89231e98884ae769.

This causes a blank screen on boot on an Asus G513QY / 6800M laptop.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2259
Cc: Aric Cyr <Aric.Cyr@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Zhongwei Zhang <Zhongwei.Zhang@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1c3de3a1671e..049ef31ebf69 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1192,7 +1192,7 @@ static void disable_vbios_mode_if_required(
 
 					if (pix_clk_100hz != requested_pix_clk_100hz) {
 						core_link_disable_stream(pipe);
-						pipe->stream->dpms_off = true;
+						pipe->stream->dpms_off = false;
 					}
 				}
 			}
-- 
2.38.1

