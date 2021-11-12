Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69E2C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88ED060FBF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 88ED060FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 048776E4DE;
	Fri, 12 Nov 2021 00:55:02 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA4D36E4DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 00:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZ7VTYgv1AwevJmC9tTnkX6kzE7F9UqKqeofLd/QmQOqmlUGGUGiP6ppcFaQUf1O87Vi01H7LQMa1JJbQfE6F8gWCnTqCZ68WSdM0UdgCij/Qt+0ROFbEYSt/XJwnbZiGyRvFngNOEG/+yY+dCw6BU7r2x3DGtQKnsndujmGN78GN8Cr7/oHg1+CmftAblARjqedN5H2oOhs2cWE4/rdeGzxNn0RDKpHEpwDteresRuq9AddYlymV+RC43XgkmB0WGsUdSKRrW2+z8XQyOsvyUNKGOYOzwwHyQJVOh/tWV7bb3rZ/U5EUc+pPgyPFH/77ygHEEcswbn0Ry43AjD1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y746pqi59u9hluZCFTknXH044M4JXzKRGAKpHqQMD3k=;
 b=KhfQpFlA/mDaknksKuRl4sjvk5lVCbDCWnk4w0ngYr6h2An34pEoCgDBJGX10vOla698uj4OqFTK11bGBNZyIJyLLXGXbjwhJNJApjL0Jmzi71pR5+VfcV0sUhWnQxm3KOhC/tzOqzdoxhYp10B7e4q7V3r0E62nC+GJmY6n16v2i53jx+4ZAyppD1sh+fsw2sivyEeGFV6DIyEqpZKw8lq39pxzFlk9HfaI/hP6oSxqSTQmoK8Bq1ZF0qrpr+JbonRlqG3MvttNANzEsaOhwJIQDOV56gPcrMLTHVlV10MzEXTOK7DxqlbzjVilFdkM9ervBH+ixUdHsge6Gg/trw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y746pqi59u9hluZCFTknXH044M4JXzKRGAKpHqQMD3k=;
 b=GdCvONWLno0pEsyAv6B7sYaXbRGrsAJS1DE4addvIiETzVSUFy48wpFTr6xB01aGrvNmf00TTPqYqp3dLdtRDwFJhRePnLr0y7izd8uT4de8UPggEiTr1JZ2TwVIQSI3nPrOLB46vIuf6dAnLQnJM3H5DarhyETjyZ0OTIFE/b4=
Received: from MW4PR03CA0283.namprd03.prod.outlook.com (2603:10b6:303:b5::18)
 by DM6PR12MB3753.namprd12.prod.outlook.com (2603:10b6:5:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 12 Nov
 2021 00:54:58 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::93) by MW4PR03CA0283.outlook.office365.com
 (2603:10b6:303:b5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Fri, 12 Nov 2021 00:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 00:54:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:54:56 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:54:55 -0600
Received: from wayne-Bilby-RV1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Thu, 11 Nov 2021 18:54:52 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/14] drm/amd/display: Secondary display goes blank on Non
 DCN31
Date: Fri, 12 Nov 2021 08:54:25 +0800
Message-ID: <20211112005438.5505-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112005438.5505-1-Wayne.Lin@amd.com>
References: <20211112005438.5505-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5773289-83c6-49ca-8b53-08d9a5770c67
X-MS-TrafficTypeDiagnostic: DM6PR12MB3753:
X-Microsoft-Antispam-PRVS: <DM6PR12MB37533D82DC60F12F24739B39FC959@DM6PR12MB3753.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SJpeetNld6EBslaptDos4uOaywpIQhQYLz3tby2NYaXWhSEIHOGx7qSYtIPFHoXozIGIJQw17lFgQL+sDqgquM3ZyUeSHIYJUb5h5PGbKTrXMkdyQRd0dICgvEP349oa1V8ksFpc6HNKB/t5OEneLL+mwelFzsO5DysV0eGxi6R9rCNXZ+YV1/S2Mji+u9xc3KAFY8GXr2yQ4CfAvCIQZn12VE7uY0rtOp/Cu+Z7hVegrZllOeI/khPFGBloT6j0RT51nNoAzMvv1sRWQuR1itT0nR38ntzhYV3a9uywsDkSZ4wlUmQwSuN6PNW18yo74BGK5gYR+e1JrIE8KggbDL1ljqs7r2a/8QxqeyZ/HwseGS31R0iapLwBBVCr0wB8N70XIlzec8tvStnCLC9rcORR/5icHzNf/NnFjZNJ17G5LWYS2R1HN6a78QRuFMKLeIVV6egDwxSNupKkuG1y6lvgpHAr0x/iKjXy7opyzzGqIw7OjEVwnlmIEB1J1d86iVCEZ596XuNkzBjojVjL6t9S0xb3UdeXYHguRorN6cidWwAsYr0IfgDBzcxv/PVihidZjM/+1NOTjH7uXOreGioG4Z68PDhK+wgA296GkP9tVUzbW6cPWF5tO5jBKSnP3+4Szur6JzZG9Yddtx6kinIVubPV4OdNY4uVUe4mFJZ9kfCjqc9dRXuq7SjV2o5HNgWmgyGtSf+SUovJ6XuXvan/rxmqY6WKuXwmTzhJBc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(186003)(336012)(7696005)(70586007)(36756003)(8936002)(47076005)(356005)(2616005)(82310400003)(6916009)(2906002)(70206006)(5660300002)(86362001)(316002)(508600001)(426003)(6666004)(36860700001)(4326008)(83380400001)(54906003)(26005)(1076003)(8676002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 00:54:57.5840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5773289-83c6-49ca-8b53-08d9a5770c67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3753
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Ahmad Othman <Ahmad.Othman@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ahmad Othman <Ahmad.Othman@amd.com>

[Why]
Due to integration issues with branch merging,
a regression happened that prevented secondary
displays from lighting up or enabling certain features

[How]
Separated the new logic to be for DCN31 only and retained
pre DCN31 logic for all other ASICs

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Ahmad Othman <Ahmad.Othman@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 2e2dcd5518da..8a8a5aead34d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3997,7 +3997,8 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 			config.phy_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
 
 			// Add flag to guard new A0 DIG mapping
-			if (pipe_ctx->stream->ctx->dc->enable_c20_dtm_b0 == true) {
+			if (pipe_ctx->stream->ctx->dc->enable_c20_dtm_b0 == true &&
+					pipe_ctx->stream->link->dc->ctx->dce_version == DCN_VERSION_3_1) {
 				config.dig_be = link_enc->preferred_engine;
 				config.dio_output_type = pipe_ctx->stream->link->ep_type;
 				config.dio_output_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
-- 
2.25.1

