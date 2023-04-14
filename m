Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6796BC77B72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06B6710EDF5;
	Fri, 14 Apr 2023 15:55:34 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D937510EE00
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSwPByhfxcq1+TwD3AmA6bQY7tRg6Az7qySnwh0F02VlQcxiDmjkTITCt+ZbldOate9HbufogWZIfdXkDj/CIV/loG0Mx3nn34ZbMhWqYuDu2oX9D1cTM7+GwFygKN1wlrkQLBJp3OrUIMHaoE47rDqKx8NBJj3xyuSHpQ1JBKQzPoFM1dumq3sXgbs6dETrYgkwKz0muOUKfPdEZz6t4SvHD/AZ2RT8GLfDoCcJOkjOwUAxitOcxXuHv7xN2MSzrK4Yxi1qAHannuqiJJ0kBEgFDGGAJMnXOsDswjer2V8/Zic3iYorBmfX47VJ6iH0E33YYBPcOI5Z9X2im24NTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDdXd6dGiiWtDJSWfng/d/lcBweX8VbRr61RhEupcP0=;
 b=R75ADdrNgRkDCN64fB7WGlhff0iL/iKecxE0ndXqSAXaD1Fzxu3g6GTonCebF1hR0qwryxCgXAjB9QJAI8x9r/WIaA7Bu6ijniZ1eATgJmne+WjiyGAboCqKMFFDD5QepfspARyR1QUo3BJdZ0eEAtK09KXWNF2zSAKiRXhvQXaKXeVRHfGlewJ5YEEMcN2c6zJpBPHdAGhKfORdbyq/9A2iykC8GP/58sdw30gAHN/ggaFZmx9CXPGGh1h+rhuaypW3zkVs1EmSTlFom/sMNRDbRmywbEsxGqbPXkR6pMQavwMLKR92Rx0ts8zT09DTM1HnU+ejdjzVQNfh3Ap7pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDdXd6dGiiWtDJSWfng/d/lcBweX8VbRr61RhEupcP0=;
 b=J9+CmlFfAGDncJ4SsJLhGAuCH/2I5W7YRNNNaQnhiL58QBVKuHvp4R231baE7rf1ejydwT9zD8HH4rVcboTN3r5uYpfvnIYUCvl6hHrR0Jnlg2D1weFon/G9Yv4+we1igv8RctxpUUlVSY+29ih+m0KNv9MiSDwQHzfrVV1d/E8=
Received: from BN9PR03CA0255.namprd03.prod.outlook.com (2603:10b6:408:ff::20)
 by PH0PR12MB5450.namprd12.prod.outlook.com (2603:10b6:510:e8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:55:25 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::e3) by BN9PR03CA0255.outlook.office365.com
 (2603:10b6:408:ff::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:55:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:55:25 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:55:23 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 65/66] drm/amd/display: remove some unused variables
Date: Fri, 14 Apr 2023 11:53:29 -0400
Message-ID: <20230414155330.5215-66-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|PH0PR12MB5450:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a07280-d843-4d4a-c614-08db3d00a936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2zRhK1SxyIAWVNigxDvWtMng5TkglG+bIYZXCRupeXJ4t5XW43jz+BuyvY3cOelv4Be8ilC+yEeH7KRcHJPE/78cwxyNcgC+ZDvpSIt6eViUa1uLGsUPL6Jo+RYqj83LVQrwrYsb5AHGUKS6Wd5YNdQTQGDNVo2F/3dGXzVyNINVAEwFEFmM81TDOT1gDdrfThS4AeMQ5CrgvUAt5wq4o3CLnSRACamq9wHrS9hgdXkgOwYxkzszaq/FID4xrjkvsgRxa2jsKbAoNcHF5QrqQuuhB5XlZvR9NIfRne5AF9k/uUd27G/Ow4li7fHQCqoDapfesUPKceezKf3I7QSeHzEh62YUmKcfjUPxyugjWX+WIMNW6vzfK9QzRKDWB6QxbCAmnnztA7+nE691FBxQaCitLbCO+FmUpR9F/2Gxa1W4X7eD5wkIxrx0Xp4u8TWOrartH8f9lGpMdFYA+S5ybTlIZDTV9xim3/5jp+npmoSXQlZDQsBNEX/rLwTZMpTBgrLFXagBmzNYqFhKoHMPmEiZurgZJTstgkG+STjwCMmSSpCSskPpqIphhV6BY6AUkuqzXgcHHH3lN8+34tuD85Wff69EGhxMi9tNWMs9D9wT0ucHh2IQ5CsclqY3XG9FY5jnzcJJZeOpCx3rE40vynXxeLcipb3Pfb5/RQOAIqYiBEEGd9WA/0edxIzzmtGnEp1FxAXEd/r4qq7fKm4DUBgqBF6XatzQvndVLgdiKk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(26005)(336012)(426003)(1076003)(54906003)(40480700001)(186003)(47076005)(83380400001)(2616005)(16526019)(36860700001)(40460700003)(5660300002)(41300700001)(316002)(8936002)(82740400003)(82310400005)(8676002)(356005)(86362001)(81166007)(478600001)(70586007)(36756003)(4326008)(70206006)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:55:25.0821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a07280-d843-4d4a-c614-08db3d00a936
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5450
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

[Why&How]
Fixes the following warnings:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hwseq.c: In function ‘dcn21_set_backlight_level’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hwseq.c:229:18: warning: unused variable ‘otg_inst’ [-Wunused-variable]
  229 |         uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
      |                  ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hwseq.c:226:27: warning: unused variable ‘cmd’ [-Wunused-variable]
  226 |         union dmub_rb_cmd cmd;

Reviewed-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
index 55a464a39529..43463d08f21b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
@@ -223,10 +223,8 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 		uint32_t backlight_pwm_u16_16,
 		uint32_t frame_ramp)
 {
-	union dmub_rb_cmd cmd;
 	struct dc_context *dc = pipe_ctx->stream->ctx;
 	struct abm *abm = pipe_ctx->stream_res.abm;
-	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
 
 	if (dc->dc->res_pool->dmcu) {
-- 
2.34.1

