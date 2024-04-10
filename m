Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009CFCD128A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6767B10FB2E;
	Wed, 10 Apr 2024 21:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cfz3YI6H";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8564A10EFCF
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8x6O2LaHRYphTahoc5lShvkpNv5PLIZpyISWNM3UCgpnDe9uxpR4UI9inrKI5Tkw8CYEC6FtRYWlHxMB5l+W719y9pNg/3E9S+5MpdCbX10DK77pRBjJypYEnVBQTWcmfbD8UAah6RKVoyd8LTv7zw1GqScxRDdevSKWxjd9RkJlMXq0pdZnPxGaiUrqxqQ/bsl1BQ6GTXGyglKZvsmbhgnyX0oz/JOraUtvCYU/gySuCfK6Ap2Np8Y7tmvqvPHEOrB26lHnTSYvahm/gZT7Jm1vI9FpPxswQZ/MoyecNQlYEa5SK/PmQ2MRHH98s/N2041Uvm8nNbl3vhA6BD3Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KF9u52YOPkpQTTUgYvQMuvOeTri8AYXfI/kS6qyC03w=;
 b=C9Tvh4L2LVjVDFTDiMyQPpUCiOvgl7qEvpIVaOOKeODyVM4zdQDaxXpfAUoi+mhJGMPwfvj0DW1k30c6xuqrG2AAZOjjaKoExB/0CEbrTwU62Do/IVi99VMhxy98ISluiBawDbJLYBU8V1l8AMKKciPqRNmBwsKqx9jwhygRuNwZarCR/m8i7/573/yPAxIih0+r/uhZ/7QyajA4P1y0+qFOBhnItcpygvR77OKboda5y5fxd84PC53afwpRe1Qu9t9z/vnKvTRGaawdkj50nHBnvdAg0PDayJm1UClN7iyJuYqyVRSiuDtF5KMK8AZCNDzwoiRIJ59cFe9Qepjt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KF9u52YOPkpQTTUgYvQMuvOeTri8AYXfI/kS6qyC03w=;
 b=Cfz3YI6HbgZM7zAwhyqJCXHWZpdeUQjsJT+0KzHYtLx125ZH/dxbyB8JP+N/hACQ/pZrATKCncBTqoRCFKarqQZDdKhxZF8KZbu4MBfHbnv83xmM7rBQDOWsgqQ5mHEJCNij8aq8m+krHiyjGzYGpaqP01JHXshkcfaQ6ypvZH0=
Received: from BN0PR04CA0079.namprd04.prod.outlook.com (2603:10b6:408:ea::24)
 by DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 21:28:10 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::c1) by BN0PR04CA0079.outlook.office365.com
 (2603:10b6:408:ea::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:09 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:28:07 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 11/25] drm/amd/display: Use dce_version instead of chip_id
Date: Wed, 10 Apr 2024 15:26:00 -0600
Message-ID: <20240410212726.1312989-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 724d6077-2dc2-41fe-58bc-08dc59a51e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dg+a4A8k7RtZI49nO22CcIVm+U4Ecyk3ixSiuwAlzSti6ixTl7XG6SMpkuLCTPd4HnWWLFrti59Ql+8WlffcupwGy+8vy7SPuR0U4PMldRy+8iPALgRQom6EobdlypkJWHPKDwCC3JP76Y5qJEGgNfw5JrniL2uOmAjlTupSsHVwTlI4Ju3p9A4RNFfNuikU0y1Yu741BfRorCXS1uvETgVZafFE5yEVO7VfSEdt1sHH0sXZYyqj499JmEGtx8stq3T9MGmeHUgtbzurwJYGpKsN8uEWr9cOPm58xmfCzaflAyaSsn4Ye4U9AEFzge8CLBi5RqHcQa1yrrnoV6oIIE3brWU5SIxMwM4/a3zxvEe6Ry4wSVon3uybaHPDWYC2x5f7PiSfBjJlAhS63NqMEIqLDMKr4C30QAVij2MKUkPXEwbnuXDxghpAHfKyMFGExK6U87DQRcFnnu24UfyCAEsHqkNv5cHCxqoHaWsMEm69Z37N80E3OD/uTzCDyujR5a/m/9ocl1WYbEXa4U/9mxYlRxtFQ53Ei9epAVLlzv4/l6MOibF+D5963Dt/IKTbRnHVT3UR/jaqDKptYIcJMoC6K6lCQh4YGFtsLOM1/cTBQI6+3v6SvIph7kiY9LVuVEX+oNea+Pa5VYFxxGQNE5M/tQAUKLJQTzBBG5mdM0Zsxjre3vbXSQsGSFQ2rup8U8Pn80BhXdEO2a4DopWUf9r34AA08hBq+bl4SyWnTJJ0D5vh7AvGhOVT0OqTgXVf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:09.6984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 724d6077-2dc2-41fe-58bc-08dc59a51e99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766
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

The chip ID DEVICE_ID_NV_13FE is not meaningful and represents a legacy
way of dealing with chip ID. This commit uses dc_version instead of
chip_id and also DCN_VERSION_2_01 instead of DEVICE_ID_NV_13FE.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index c1a5908b97c8..a2b4ff2cff16 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -272,7 +272,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			dcn3_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 			return &clk_mgr->base;
 		}
-		if (asic_id.chip_id == DEVICE_ID_NV_13FE) {
+		if (ctx->dce_version == DCN_VERSION_2_01) {
 			dcn201_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 			return &clk_mgr->base;
 		}
-- 
2.43.0

