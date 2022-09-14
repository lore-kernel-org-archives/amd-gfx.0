Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF65BECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E9F510E7F3;
	Wed, 14 Sep 2022 03:32:40 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 378BA10E7F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:32:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jm0MxScgB6ZDe8vjhhM/1L0U7UfIOx250gj+/03HB7lP+iviZcy5hRso00Z434pFOmZc/xzKUVTV6YEu9PO57cKPYlTVfgTgp7+v+b+YcWhYmZUzbQ5nxGtvuGDBmWelGZ+/T1q9c/YUy1bZ2+vWCgPpnj7ftGfFGxHaIenP7ZUaa8edl7nrNgvdE99d71t+nxPQ5kvTJe1USH0T31QZ14isKWZ+UjBNSu3lxw1bVlKgDBmfUoyuvEvPoRrOr+23QP5UvoGyZc53Fa6eA0vyqzgzO2rY422GeDud8jEOOEJ3yf1sP3RCAIuqCcoIldVA9AZNqT3wnhlNU2NyEUp25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPBBu7yceNxS/6oq8QiXYEGvTmTzFcYvX3DzZEUbDnw=;
 b=Vhe9tUNJWRQrnokzQbzbRbVFzvyV3+/CsosOgmpst8JqwvIutcewBkjbwkNYlLhpas8Nldrkq+3LMEt8U7t7LwwY6aWl8ooTfACojnCmqVTpTKhFqZXs4APos5J7MXl9afEz76XbHcW2t2zBcuIu7D1rLzMqeqcT/rUCO0wdhXnGZ0DQ/YEC7FzfIgkUJokx6QjTY27GDx6n9tiF1NVM1TlHtpFIQU+nqx97De3ED5lp6vV9EbeENCCSqEwqsnHDRkuETLgwEaHYJfyPQB89pHIQakevSYzMd2DxeIQIqyrjlU7oFEIL9ffSAfLQH+Snt2612UZgLgGiNYS3xj0F3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPBBu7yceNxS/6oq8QiXYEGvTmTzFcYvX3DzZEUbDnw=;
 b=SgLVHBtKwV8K5WGR4wpTGzAab0RzcTVh7+S+4vzbiQkH0GM7VK9TK83MhxjCzyh8nlPnnHD/8vCaLAdcpFD6w5WAnula0gXOApVE49U+l5gNOjp7eqrKB6JBm5opQR0yXBVW6Cl0vBbPgET+1zCy0joUt8Dg5D/CkGcdIbIpWq4=
Received: from BN0PR04CA0060.namprd04.prod.outlook.com (2603:10b6:408:e8::35)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Wed, 14 Sep
 2022 03:32:35 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::dd) by BN0PR04CA0060.outlook.office365.com
 (2603:10b6:408:e8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:32:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:32:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:32:15 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:32:12 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/47] drm/amd/display: update gamut remap if plane has changed
Date: Wed, 14 Sep 2022 11:24:14 +0800
Message-ID: <20220914032441.1075031-21-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT014:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: 4504d60e-0118-4ce5-e6f0-08da9601c3b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrpMQHzD7zElHOw2Jj0te44SJU+f+/WvQu1A2Bvmx996fEf2D6zx6eUTRe6A6RVscCxcBm1Zkt/tfGYGNoAxI23DwIwWFODHolPvSBM/yJpicPSWjUz0OKjAv/Qmq9rOzZnnHe3Rx55mrxPf7b9H5Ul/20X9j8kfmluzTOi0J4rPV7nh7uUy1fsQk/wE6cS0glr4K12e8v6n13sSa+2qZOB5oP6+FtKJTbnVDQ5lQZhT9YyGoMynxbRTSNRxzKEcjEcwxQSJ5MC8FYTupOjJifVX4F1LrFTorONc73YuYeQI5UimDRKS5A3Q9WQ7vXWljZH7nm/FptKcydlMFHHLnalvSKJYHQAa8a1vfvoFjTMm0z4PTCYUGhXSWYCZmG0ZQNzSstXcyhsxU0XvOpVIinfE26c7PPBT1T6gq7IcL39r7ychPzZw0j4M3JnaHbCd6wzfsinWz1OeuZ9rGAIzd2RhtNZpnUaB52Yukp06YgogJAVNaSsD6xUsLQYQV5h0SqKnpxVqzi9ki3LP/stD+daTDPZW3PYZ0rGzgCURF9otJfWWGsSoutufiiyXuUrW0WXIArpPGJ+Pg2FlyFTjcP3s9iS6mQuM4AQeV2IFZhTxQsa+B3BK+Brjv1zK/y99KHD93GAP+M+wujhSFgu+5J6zwtDyQzD6hLrzeiwei2YWe2DwzsubgVQXnIsI6tAarH6x4217FN/8FJgVjwsLs2/y2ks37pXaBUdP6+vYzkQoEtxNlzSX4eNZpWv56nd3QHS+gvPs0alyJuWP4SaVAS3f/pps9Ka4WCDCtYzBREe31QyxlI9+pcQHrSMOnWkg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(36840700001)(46966006)(40470700004)(478600001)(40480700001)(1076003)(81166007)(426003)(26005)(83380400001)(8936002)(336012)(36860700001)(316002)(41300700001)(5660300002)(82740400003)(8676002)(15650500001)(70206006)(54906003)(70586007)(47076005)(2906002)(82310400005)(6916009)(7696005)(186003)(2616005)(356005)(4326008)(86362001)(40460700003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:32:34.8267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4504d60e-0118-4ce5-e6f0-08da9601c3b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Hugo Hu <hugo.hu@amd.com>, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hugo Hu <hugo.hu@amd.com>

[Why]
The desktop plane and full-screen game plane may have different
gamut remap coefficients, if switching between desktop and
full-screen game without updating the gamut remap will cause
incorrect color.

[How]
Update gamut remap if planes change.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Hugo Hu <hugo.hu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index ab56f14d6247..e1d271fe9e64 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1573,6 +1573,7 @@ static void dcn20_update_dchubp_dpp(
 	/* Any updates are handled in dc interface, just need
 	 * to apply existing for plane enable / opp change */
 	if (pipe_ctx->update_flags.bits.enable || pipe_ctx->update_flags.bits.opp_changed
+			|| pipe_ctx->update_flags.bits.plane_changed
 			|| pipe_ctx->stream->update_flags.bits.gamut_remap
 			|| pipe_ctx->stream->update_flags.bits.out_csc) {
 		/* dpp/cm gamut remap*/
-- 
2.37.3

