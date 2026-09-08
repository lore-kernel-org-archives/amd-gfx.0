Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6CAC79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8459B10EB7A;
	Tue,  8 Sep 2026 11:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Imiq8C9l";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013045.outbound.protection.outlook.com
 [40.93.196.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 523D210EB7A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8EpWIpi6sd49qB7w3ur7zqg0Hm3IGgiJaLeknkuow0KPuDajcZPW2DPviHTOpUE5DjF70yNpet45EnPrC6BVGf4VByexDsQun4aXZQx9wlcQrSQ1A76yRIsM2iyIgJ1yjFFTpK79szVETZ6KywAdHXX/ZVNpOzNLRurJ2FBJSFiI6r8JLWJzg2gdqfUZTBB8HzjOdtN2IpyFgd01jlPWW8Hes5Fsz0t16mlpQAp4Q1BF4Z4JKc26fl9CkabhZG6uu6Bne0P6v0RuMdWaVhk5e/hQEx1jkGxeRu0GuGsrQpADN1FwoKYS3ZPFT9tjohq3D65H9Qqtvr18L8KAvOYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paaqtzrgk71mRHUpZszVb8nZspxjYcBNd+XwRLqJHWs=;
 b=ACErkEJXMpThwjo6bUbXbKOahn3Kyu6iP5WAR2y24qO9qLe9xC2XYxF6eTbWaKjLa5X4k5ZjFlx1chYUJmew+tJkmog0bvh9oCg7YztDFJmu0lkpALw5+uLYYePhug8bqzM1iXFBgZCFdCZEbXWhd42hgbWeaerwME0LsnG7UX4qqKa107RI5bvbVNX1pBa/hHaQPfoQucsxXqNE76QRkv1H0tgn2/VagrkVTOfExzGD/necJu3WB1vn8/XOGbbcGbUUCpJqKlhNv5AVA0pxB2ysZ+2YIUTHST3RqzVq7mRQLMq30lOgNEfdDv+W+U48Zx7yr+kGzZygnIxy5PqpBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paaqtzrgk71mRHUpZszVb8nZspxjYcBNd+XwRLqJHWs=;
 b=Imiq8C9lQBdPR6MMpzPhXBx6SEQR2mLMPQINwPhaK+5cyfcm2TFfpCdX7LVp8gfyF35klMXqhbD+1W9Df7yu+oNyhS2KLt9bQeFRVfAJ0KdUjAZL4gl7KKz2nlo63T4ZU/k6sgfxFFrQ6ydqlB1Ui3UDiyaayD8BvYfvEiUFUfs=
Received: from BN0PR04CA0135.namprd04.prod.outlook.com (2603:10b6:408:ed::20)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:44:19 +0000
Received: from BN7PEPF0000009E.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::5e) by BN0PR04CA0135.outlook.office365.com
 (2603:10b6:408:ed::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009E.mail.protection.outlook.com (10.167.248.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:44:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:44:17 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:44:09 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 66/66] drm/amd/display: Promote DC to 3.2.398
Date: Tue, 8 Sep 2026 19:31:59 +0800
Message-ID: <20260908113338.2433445-67-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009E:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: f8da72a9-c570-4519-5eed-08df0d9e849d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|30052699003|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: KuSrV1Gknwq5THpi33hHuo2T1yclvrq1XxyX/KNxmdY81Yp15qdazdgKtnXF72c2YIHI7Cim0oSlzNHQ4ah4og4ya0e/zyHnokUo4/Dlv/9PIXvrbgrkh3Cf+8nNxpDp7DWoQWlVx+EKLJRI042Y6dQiv5Z9Tsl1tlLuGcPEOvLwqyfVpeQN85J8H08OTsA8rf94lzX7g2chrFHDb/9Kz1MjoXUC5yWeCfuFNrFZh974S+ueshIfdEAG4GbOfpl7J91Thldw+rIvYLwvdtzmF+7yEWLlgSh8pTD+mk4t2yaJupVXkm4ntnufwJwfSNb46nJSyg+uPpRgR/StxhmJfgo/UWvC99xKGK9tR19nC/SxThApgJ+JoWSCNNx/kZsVe4SEh6jNwwyim5SAEfytMDCAav3ozFWadHl5zw5y6NHilcwWRTONv6hh9xjVblQJuv1oHSGHZ72KjAckz7f04FwC/EdQJozLmrbqogkxvHKCPkbjbggX+T+YSmcE734C07Lh+Tr8MOfAoQ7QhXCbaV+EV1JKGo2KQE5k2RwOphhyUNAJQ7zOYZBX29DOY0rkl2bSlRP0hqyzhcRTVsgD3pGRnw9CHire3BGZ2+5imz0vER1ySrKa+NLUulJtD2jSmaguNi+5NFH88tQNDNWmmf32DOWp3TGflKUPa/OnrlapPHCT+p7LnZSHfxDkCuKU14kxC06BtLAoBX9nSnJ/6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(30052699003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u43/xIW2di8GNb5Y+sl+BZLIKIMQm1D3CKohKANsQNeBHcXpog7SM7NSjfbgjZJQBU9pWJ7XH/rA7goBYhIdShjVCpS3nFs6tgDlSuMISnYZYDvlOplK6mInptyY0l8gNi2jwFSVH0YQOWk922ahynoA1+pA7ZlFNRZhG6zQjPIHPIf3wP2ePidtcEArltRtkV8YJ/TZy6zpcfph4fU5xZvKeulrlLALmLTWkRi4hCAAwWeXYQ48wD670Ua6Lr266z3QcU+T/w4W+2eWk7mmx8DYk1HkQDOLEan+7fb7DRksMgz7SN0YSprs75daAkBGyJ1bhYahMD31hDCf6Mpl1Fuojtbwndpzs1jzZF1CDpUu4vqFDbHsjOkXQtnZxWr5VOfIG0+u0xhfftmt9JJGNtui85UNRIFAuv3Fc+aTYf81rOYJZJJKkiqHoXAaukt1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:44:19.0362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8da72a9-c570-4519-5eed-08df0d9e849d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:

 - Expand amdgpu_dm KUnit coverage across connector init, sink stream
   creation, FreeSync caps, forced atomic commit, plane modifiers, cursor
   updates, panic flush, MST connector creation, AUX transfers, link
   bandwidth readback and MST DSC configuration.
 - Refactor RMCM into a separate module.
 - Decouple cursor offload hwss executors from pipe context.
 - Decouple HUBP_UPDATE_PLANE_ADDR from pipe_ctx.
 - Rename lock_and_validation_needed to needs_dc_state_realloc.
 - Drop the dead update_type param from update_planes_and_stream_adapter.
 - Attach only plane updates and stream updates that actually changed.
 - Unify fast update classification paths.
 - Request DMUB HW cursor offload.
 - Program DCC as part of address update.
 - Update LLS and UPSP programming paths.
 - Add lock-free memory pool.
 - Add instance field to struct mpc and struct dccg.
 - Cleanup DMUB command submission interfaces.
 - Add inbox0 HW lock helpers for DCN35.
 - Atomize IRQ register read/modify/write ops.
 - Add Replay cumulative residency query.
 - Add urgent assertion counter probe.
 - Add debug option to force optional UCLK support.
 - Force DSC to 8bpp for SST and MST DP tunneling over USB4.
 - Honor forced RGB pixel encoding.
 - Add option for certain panels to disable FEC.
 - Cap DML2.1 vmin ODM combine at 2:1 for eDP.
 - Add is_odm_enabled callback to skip init_odm on active ODM pipes.
 - Remove MALL capabilities from DCN42B.
 - Skip MALL calculations when there is no MALL.
 - Enable power gating on dcn42b.
 - Remove SDPIF_PORT_CONTROL programming for DCN31/35/42.
 - Enable back alt-ch.
 - Flush ISM work before releasing the stream.
 - Fix HDMI FRL audio enable.
 - Fix peak bandwidth measurement sequence.
 - Bound the DSC power gating loop by num_dsc.
 - Cast DP DTO pixel clock math to avoid overflow and narrowing.
 - Use unsigned types for FRL cap check params and HPO read_state.
 - Return success status from check_mode_supported.
 - Add SPDX license identifier to dcn30_dpp_cm.c.

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b6c71ebb7ea7..5174a0098e75 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -67,7 +67,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.397"
+#define DC_VER "3.2.398"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

