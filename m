Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAFA606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hF/4u+qa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E447F10F84A;
	Tue, 17 Nov 2026 17:18:03 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010025.outbound.protection.outlook.com
 [40.93.198.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37F0810F842
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:17:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FghPj/Zmh9DgCGTXVFG+bmMZsZnM0CUzM1oJ8aOQELvK9SyWbVuDLEUJD3ojbpir1W3yRw2UFw+nRkDEScHsgQbM8p9PIyco0WJzZY0T2aeU6MVaVhJ1MiVwx6bVWHBR3SULgE0UAoCRIh1fC/ZPD9hZYHM46TvvToUu26Mz2P+j5jBp5yRN6T0Arb8QgdOEee0nkmXNa9UDu29RRW/s3gTPSh6zxrZA6wMlROtX7xRcnRzq5W4ab8hEv6myWcCtcVTZ2uGSYXP547q/YJjpveJJ8b7Dr/cVcvthgs0k6hc9E1PsB/kBZJbbjpgA7O5G5pi1vHkE8+EUfJ0ARtRP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5ObktjC/+DzXz4mnJpV3zM0XJamluqLt/XSp+Hef9c=;
 b=zBHZHVLvUVR8BtvndmldvYisgyppz28WkG9GWC+vxnwG6NpIMC5vkTSLVj8wpsBgHI6dC0/t50ZrK/EKHAdKoyf1x9vBBrbSmWK/XdXSShQGIjSqBxYdJ+z7YRhTRJ+m40Odn447N1fW9Kd9jL5mDvAEP2EaeoCFFEaRgwoM/qdsI3mMi73nt6eW0vRQHfW9rbDmMzxsludXMii8pqvo9LHMyP/j72kExsxs56cOH/qOE/ZOzS+k5kdinE5afWkZdmBC17ybxPmFPtO2xO5blvr4mSsZqlzGY3mhTfZzk3RVjFZMSBG6Vguh0dzImAh0LLNXq4Ps76s7FMGyiSuboQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5ObktjC/+DzXz4mnJpV3zM0XJamluqLt/XSp+Hef9c=;
 b=hF/4u+qax17eRN0s4I5B/KEO5Q9ZuiQnMepeOIK8U7UYRMneSyK2OwCiltf6/ft7D8T+xYBCEnFoKrdjALng0t8wDbTebQobT816/6sj69qz2W9OTDQDEEyaGF9DOJF8PZF2bykBia7ULTGi6pjTq82wmv553WJ3exC+1o5vzb0=
Received: from CH0PR03CA0248.namprd03.prod.outlook.com (2603:10b6:610:e5::13)
 by IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:17:50 +0000
Received: from BN1PEPF00018073.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::73) by CH0PR03CA0248.outlook.office365.com
 (2603:10b6:610:e5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 17:17:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018073.mail.protection.outlook.com (10.167.245.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:17:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:17:47 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:17:38 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 33/33] drm/amd/display: Promote DC to 3.2.408
Date: Tue, 17 Nov 2026 05:51:10 +0800
Message-ID: <20261116215641.2800595-34-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018073:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: a6944c81-cd9c-4b73-0a54-08df44ceb549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|261022105027099003|10067099003|56012099006|261026140227099003|11063799006|261028144727099003|261022075727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: XM0XKHC5IPQlXq+vixYekq4hNiIgtJEX7wGbNYVMRiLkgeFRpWhQosnlRT+0lfA3RW2IO7d6EqD0UDxC36pRV6J07Li6VuoENgbo9rZm1cwCWAyD9C38JUUlnJHtfPFjcMgdY25He4sD90Ckz6iMSSQ2Rimlizj5+poSeDfcPGwnNm5fTCzDNseVxQdnGxzfuDJc+oFJyrWe+MlHG4pitid4BulEyUGG0qcgvvkN9DyxtJ+HgGp36XUE0kl3evtNhX7ixlcc77S6/KwumQkFmnPcIGAhy97DhlLrYCAUV0vq2cQqoPpjaZCNFS3Hq4Wx0OE8YqD+hkIqae3lO/iYRMdNwWlRhOC1845Xfuj5piuZSLZAc2eREBvMlGgpbBu/CUEFnj6FqzhnBjRXFxVKhvF3EipeLr3hyF2qujuSbduThjMNGwM7+bbziOXzOmLlXtmTcDATLBc1EdQ3Cpa7qYpcJyDaR/fy8XCXGXzTEgPA0imKyGFK6H/XHX0Rq6ARsLgALH6G5OHzGq8wChSOocoe4ujp3I3ZRkrbxnZ5HBz+RLgxI1Cg3M5Mwzlg6kO8+EFLFEcsDkFztYwvdZFigDJhL1imgGA/Vsz9/Lv7cexi6B56ZpOTJkTDD/0khAb/3ZGZ6YgfIgx8sdRKqy5W8a56pZQgxq7OGk1mUuQXAAWkE4rzNWtkt1i6/9e79/ELd3Wm41jMOeAxcivurQNTig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(261022105027099003)(10067099003)(56012099006)(261026140227099003)(11063799006)(261028144727099003)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nDMFz2Lm+DzYlZIrBGGoRYAvj5OmxugzwR0URnQvqYU2PaBZJjymbTA5HtTgWt8Tt0VwZRQRbP/afSGxDZX3RhocBuc6+o8S8h7U0pFRnyaMDJeqIJWAaSlVp/aVod/4rpXP61GKk7/X40FXxM6ztOeRCoU/fSy/mJCxG4CDx/Pe5R/8by0iwNaYTbvJszw1Il8v5bkcwL44rWgz3/1Qrf1FiBV61TGaW2nzZ9nGPf3ZlL6V8p6VNUZjWim2XNsGKh1l/55dZOj/E/3GQRAn/ReGDVn0LHkncfKtxOStSm8nzTJUdiIkAhwzGavJ/eSDBsoOfwvunJ4s+2Zlk/flEonRJiB0s3fxklvFJXu9FFDmQ6adzlpGHVUtzGLhw9Lpiy7iUi6nd3Fp2FcQmDvBRpYpJSOtmnKXK8NlPBYuyfVAmbKmY/XdKcplYDgIspYR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:17:50.4805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6944c81-cd9c-4b73-0a54-08df44ceb549
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URG_BIZ,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:
- Rename DPMS to DPMS_v1
- Power up eDP when detect link
- Add DPMS-v2 files
- Refactor DP retrain link HW sequence
- Add extra 0.25 line reserved for TSetup/TCalc inefficiency
- Use panel luminance range for AUX backlight in power module
- Read PWM back linearly with the linear backlight curve
- Add API to set brightness percent
- Pass linear brightness percent to power module
- Add DPMS-v2 types
- Always apply 0ppm pixel clock adjustment
- Add otg versions of get_vblank_counter/scanoutpos
- Queue vblank control work to sleepable context
- Fix KUnit tests for vblank control rework
- Add urgent request and assertion probes
- Fix G7 P-state aperture addresses
- Set stream min/max refresh from VRR config
- Add DC2 wrapped initialization for DCN401
- Honor the Replay stream regeneration wait event
- Disable Replay when link off frame count is below 2
- Skip DSC padding borrow estimate for zero padding
- Drop unused DC interfaces
- Let the DC2 commit replace or keep a stream
- Support two streams in the dcn401 DC2 builders
- Add a plane beside a kept plane in DC2 update
- Keep an unchanged stream in the DC2 commit
- Change the ODM and MPC layout in DC2 update
- Give the DC2 builders State pipe facts
- Add RGBA8888 surface pixel format support
- Fix DCE crossbar for RGBA8888 surface format

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7d0a47e7bc1a..908021f1ee36 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -69,7 +69,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.407"
+#define DC_VER "3.2.408"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

