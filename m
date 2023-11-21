Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF0BC54FB9
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Nov 2023 07:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05BDC10E25C;
	Tue, 21 Nov 2023 07:32:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E360810E25C
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 07:32:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Epueu/Q0KbLehWxcITl27rdz6u0d+yu0n7o42/XZm53QW9WUnQeD7RoKaFoZUQh2LddaTmDcQOYTDS/aVdeTb/Pcvr4FlOjyRgqEIQrK357jfjmUN7E1A7YrxBoT7ZtwMOxy9jT6JZncOqCqtoxCFH5NJ23XBcCfU1J6cu5K2ttLPGANmw9qw5X8UPLxrTxYrK59jTsOv6fjpYHSvefb8AJS2Q3m0ATbTBhOOlOuwENVFYuNyRHChmyVtUj/kS+7xL73ZPh/v3+P/xy+G6EfzY0UgeEpIGgmMP+ThVG8tFR/RMx1im2FzJngFEra2JSWpU+y3qroA+lfhXj5a93Uiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGwyb+ru5jGE0lLwYegQgNuKayIKOYRDNuKPZwvhLHs=;
 b=dVUxZTrivs84hR0hFxUoqzsM5qqzkxwaDt0ZN/BgfulAtv4GKtENMmnA8qJAjOQjZS9GvNJt5xVOiIrKXmXe1MO0fTBk2mrU+5mroh34d2VF35l6ye3QPiA4jdWz8a490Ga7JPgjMF1HcCx3XfVcgQbQeP7cOiKvlBe3bZuDKyid23yUWvh+xfRe/38EgVf+x7zpXWzpJGfdPeer9wNPFTpl2NEuZHqzE7KpaCgLa9NTA/l6+Z/v+vqBjxDY8OeCrOzD4NEMa6YP2bQlt4BorVBBglKUrYnW7CppTAlfRyvUjFZqd1MgTJB+/jVvlq9MbBphyAZ3EH5UYwOe8s9rYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGwyb+ru5jGE0lLwYegQgNuKayIKOYRDNuKPZwvhLHs=;
 b=E7TUIUyBM21eNmtXSD9J6aUMTmUJxt2WRKhN9gzMYnyV5C3Fb4hhSsqFjwjvLh1ZlgVbrckr/n/v2veaeup5oDftsurSgAY7xwCI2lqQyiV9rlEUXuK4xNmKOx2W3j/EXabLX38arphXyopZB9ubVR+2W3hfb1k4KOVIfUU8N/w=
Received: from MN2PR22CA0006.namprd22.prod.outlook.com (2603:10b6:208:238::11)
 by MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 07:32:19 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::94) by MN2PR22CA0006.outlook.office365.com
 (2603:10b6:208:238::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.30 via Frontend
 Transport; Tue, 21 Nov 2023 07:32:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 07:32:19 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 01:32:15 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/6] drm/amdgpu: add lsdma interrupt src id
Date: Tue, 21 Nov 2023 15:30:10 +0800
Message-ID: <20231121073014.2984557-3-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231121073014.2984557-1-yifan1.zhang@amd.com>
References: <20231121073014.2984557-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb8f1d3-124c-4b4d-a136-08dbea63fe96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BbkiuAg2+u10kSPFjCkgGCkKqN6fNbZIS9g6DkZ+BFl5YON5v3rfnlCv8e71kMy7pHTEVdMRAQ/LoIsVSZRTAo+Jz1liIDUiT7YH+ddSerWBh8ZejSBYsB2F5DtQrJPy9Lu39MqH+Mzk2CmUW4th2g8ecuPDB9rtIWrCPYPtgsmSPa3Kpc9UCEj0rxLd3s6yl0Pz3hTdzt/os7gKo8ldwmJzlbfPm0NmRsyuHWtVU4p+vBWcxoPHYyUO7pN12ZiJ355uvi374/6ErDGoD/f+WYr8s+9IYKMlSNsRF2lkbaDygHyE1FanAi+aC69nZaf5zAdnffEKbeYBkkRKUWs+8FrFQ/IWPDQmfbMVjTLHXzauh6xZuN9dF0r411nmJQNS1+zcO7n7Sh7nsITaOxy7qU9YFydA8hj4E8jFxjin6eiSgH4JX4B6S5mIPZGs1WBkow0Kyj7BOm2I7wXnTqSimxIpWPmug6NJfL8EVmOeWps1q4sjozo0piTUIrvbTt2Is+vKpZVgNJAnL0BUaMaWEDNJSjUteVtvPrK75rRYc2CO5sOIpu4GoTtVEvolxUu+Mk1awB/FVoVO+TgKU7JBE1gcHmnwTVz0TSEnKx9LJ6YFl8MHyVm528lTZXbThvrVe5BvL4jgjmML6MGOsXATWVONEEQHHluchGDKBW7qp9bTFGWUm6r1tUbYa05AgT1YkP6YYdRtUnFWgrGNteLwRI8LVDaKTUP4BNgOE2xGY4s3rQITnqnSMndW9KFDo1sMNCr9/HuHV9eXy7LAkVUJQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(5660300002)(2906002)(4744005)(8936002)(4326008)(8676002)(316002)(41300700001)(6916009)(54906003)(70586007)(70206006)(6666004)(40480700001)(7696005)(478600001)(26005)(1076003)(2616005)(83380400001)(16526019)(336012)(426003)(40460700003)(36860700001)(81166007)(356005)(47076005)(82740400003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 07:32:19.6534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb8f1d3-124c-4b4d-a136-08dbea63fe96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343
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
Cc: Tim.Huang@amd.com, Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Alexander.Deucher@amd.com, Lang Yu <lang.yu@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to add lsdma interrupt src id.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h b/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h
index 3a4670bc4449..cbdf46a3c9ab 100644
--- a/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h
+++ b/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h
@@ -28,6 +28,8 @@
 #define GFX_11_0_0__SRCID__UTCL2_DATA_POISONING                 1       // UTCL2 for data poisoning
 
 #define GFX_11_0_0__SRCID__MEM_ACCES_MON		                10		// 0x0A EA memory access monitor interrupt
+																		//
+#define GFX_11_0_0__SRCID__LSDMA_TRAP                            49      // 0x31 Trap
 
 #define GFX_11_0_0__SRCID__SDMA_ATOMIC_RTN_DONE                 48      // 0x30 SDMA atomic*_rtn ops complete
 #define GFX_11_0_0__SRCID__SDMA_TRAP                            49      // 0x31 Trap
-- 
2.37.3

