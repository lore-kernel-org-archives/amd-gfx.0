Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20ED1C54E67
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F45D112C1C;
	Tue, 12 Mar 2024 09:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qzuxV6jg";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75ADA112BF6
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:23:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXRHC5Gh4rxWFdSJH3O9T/mRNvGVH1jsSvEjyxQsnZDx0G5CElxbuQbHUNAnLmu0HiKh2IrqoINKm3RVYiZZQtafoVGHbvhUHD6G3YGg12QS02HVBhz/cYZgwX5JKBBHzI2Mn0RlQpGRZNGzKNac4FXuyjJVpuRim8w6/nImIT72X+clKoTPcixockcmosVIZdJvnK0Vcerk13gYA3o79dzYDh3ybmKmOj4asBLjpXwTRo2VFItjL4o1CrFUwjRJoklnBxxHjBOPV/vMTeEGqhOiKGsJ1INHSOQbNuuLwnqpvMxxvr66LaUDUUFp/AwjXOBepLm6xFMD7yr6huYzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2iUsASyw9C7Lpwm4vMZSQCDcT0yoyf3n9rMsxBJz/g=;
 b=mLi+0ETZuNOVy9NLqu1jNbqjLzsX0cnTRM6jYKyFtISdejy1ZNPOnwDxjXjX2TZmnOtAQD0xTkreuE0guzzw1ykw3gUQbUxOOa2AoUS+bZbBtA/vtBlGgRkUJvqZKbNAhlqPM93nokO8daBzXvONOU7/LmCgy5K+h4vyhr7Am+x7mRtYQG4kXVSkbZ/ux6dnaiV0gSGK7VYBFlKXvlbz1WfJaPwWwNLK5MY10vGag1u0Kv/VSLKPOpPJZLrUBdK67E3j/SUtIG0zE5nSaAebzkGP2RciG04gggDurBfWWj6dxTSE+WfYAwoDZHCTrm6pHlrnqeqTg6Knf+66k6q/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2iUsASyw9C7Lpwm4vMZSQCDcT0yoyf3n9rMsxBJz/g=;
 b=qzuxV6jgfIPDjUNF/6t1q22JfeAjhosCq+r6tzzk5eoCtgSBhkHGS7HgDtxhQjeU/drOorsgiIMWgUObNUVKjfZUvInAjeqo6Yn4D5v/gXTUclcSZOYs27Dj8v1MkJM5LHwXSR4IanET7wtl9wB6uyomqIz0/JWnbKlWrGkXD8M=
Received: from CY8P220CA0035.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::19)
 by IA1PR12MB6482.namprd12.prod.outlook.com (2603:10b6:208:3a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:23:15 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:47:cafe::49) by CY8P220CA0035.outlook.office365.com
 (2603:10b6:930:47::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 09:23:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:23:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:23:13 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:23:13 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:23:08 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chris Park <chris.park@amd.com>
Subject: [PATCH 22/43] drm/amd/display: Program pixclk according to dcn
 revision
Date: Tue, 12 Mar 2024 17:20:15 +0800
Message-ID: <20240312092036.3283319-23-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|IA1PR12MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c39fd0f-78a3-4988-f718-08dc42760b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVhR/IgwyZxM9hreriZkeVgiiBzZ5JHWjn99cJomJP1/JOUtT0M/2udjEBdMatpnlnp9R+l2jokAj9yVIJo5EzA4aPOIYZxgwU4Z0JzTXTZ842XMzrHiopmkQbmwb80XIpYyOSnNZ56XBrtQF7kceemM52CyOyaoqa1cW8KyewLQOlJ0RR0qVK4NByBP1gsv7SvK2xoGio6IHw3P2E0OgovApwrdLhhW235w4ad+ySRuxSD73RThZ/pbbgAsTxgXUZO12jAOLOt2uYhlD8ZeZeWwqcvdduLFAot493Og8UDVaB1K0Pm+BFkPoHOqItHIXM/V2f7gfvgh3Z/Ae3lb16KP0UzzStMaDlhRecM0cesr1nNVMfZ1KLxxEmeLMZFMmcWNFIlcXBIc6blhJRZLonGbon630XQLDCCDIePeuV4OkL+RY+VB3Eig2T/t1h0VTC656lq7nQ+6Z3l4bsKaIMYDHvr1+fkH2TsjK1ssX6sbcu80nDMf2P7HQFA9zcYTSd1loWKwCY9qDgEWKNjl+Nc+wmkFfRd2MKmvlbFDJ0a+AMBULoIuvSlRtBUgx0jn5eDPln8cMj3d4YkxkM4C0yZ2+Kh2jYZjdqH0kaTsSQJ/Pba9DFt7Fr+E5NqbmovUbURodGZtPDqcB6gEsUrrZkTYXisfYYbNXoS1DFbZ/fX0hzVUvWS5xjrhpuDNrKj3BLL5VT3ae1nXza0aWyS4GdA7YF7ZqJzYzXg9TtgplL28XsvYh6GqiuUM303iwJlH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:23:14.1841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c39fd0f-78a3-4988-f718-08dc42760b4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6482
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Pixel clock programming should be built per dcn revision, not hardcoded to use
dcn20.

Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index a2387cea1af9..d521fc65afe3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -1282,8 +1282,13 @@ void dcn20_build_pipe_pix_clk_params(struct pipe_ctx *pipe_ctx)
 
 static enum dc_status build_pipe_hw_param(struct pipe_ctx *pipe_ctx)
 {
+	struct resource_pool *pool = pipe_ctx->stream->ctx->dc->res_pool;
 
-	dcn20_build_pipe_pix_clk_params(pipe_ctx);
+	if (pool->funcs->build_pipe_pix_clk_params) {
+		pool->funcs->build_pipe_pix_clk_params(pipe_ctx);
+	} else {
+		dcn20_build_pipe_pix_clk_params(pipe_ctx);
+	}
 
 	pipe_ctx->stream->clamping.pixel_encoding = pipe_ctx->stream->timing.pixel_encoding;
 
-- 
2.37.3

