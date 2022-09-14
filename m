Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783B6ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67BE210E81B;
	Wed, 14 Sep 2022 03:56:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4F6010E819
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGInZBhIUcd25v/gYA8grVJ2AGnlus8KjG36B+yLyCxfzNkQwrISoZd29OGC3XPIxib56g8B+n51n30qP0yPe1x46owCW+ev3tFsY5MS4V8RJNIdB4f3oMGN80/2+WWhQZk+i5hA1wRdH+dPeoDYhQOP69apuc61eLNvN3z259Rk/yythfq2P7mdgJfj1zyk1AuGu8ggsLQbKyW3GObtK/i+mp5iZcULDqy320kWA2gqAFVtAP6NVrLGrB5bwqnvNNkPrKkO5ALO0mKIduk/eLmLNc3ABE6ZC6darD2Xnp021VsbdTQur2n9ML5JGPpL1SN0/y0x3gXz/rnlJ0rc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bR8eBPJyA+j6n3PlCReJALakn2M1jc9GnqaRXaIF48g=;
 b=jM5bVeOhFN2HE6Mk5Fct9lofYcRDj0hz/1KUCYb+Ry2UlmFsmCNcaYJiiGQMoMhm6LjXbnBJ+HAWaLpErE9Xb54nyJvIKFvlNguluG+/qMNSQ9pjAVWLfkEcgdfpvsWMurBja/tXVFEKtTtPUFt47cXYLLRx5N0Z7qH0kH1K9AI4xzb2blJjoLetOV3Jg/0nqRlk6B+9ppD3uFhOXR+CZsgXVWA4H/JEDGuQM41R6kQjgQfGdKeNOrr5S9FjiW8J4x+ktau7J9BCbMstQbmHBpUxPw6EDUIcyii09ZstgOfZAhu3YLY3aQUMc9yrpeUiLYsVSJcx/hUECJJ8Tb+7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bR8eBPJyA+j6n3PlCReJALakn2M1jc9GnqaRXaIF48g=;
 b=yWMfneSnDdAbbWYYwCSmWx9jKdUM/enEXilAgAP67er6cFWgSxdrTtYKcMhl2qrzAa/BooTaTm+1YDq53llEP2NNOtb6q8xOMRv07X29u9tgGOoGFcDT5dw4ims92pr2XHSJg4YkLwmvY7mZTYqcZcWKWzMIfn3bbtr1SBy2udA=
Received: from BN0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:408:e4::28)
 by SJ0PR12MB5422.namprd12.prod.outlook.com (2603:10b6:a03:3ac::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 03:56:25 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::ba) by BN0PR02CA0023.outlook.office365.com
 (2603:10b6:408:e4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:56:25 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:56:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:56:24 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:56:20 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 38/47] drm/amd/display: Disable OTG WA for the plane_state
 NULL case on DCN314
Date: Wed, 14 Sep 2022 11:47:59 +0800
Message-ID: <20220914034808.1093521-39-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|SJ0PR12MB5422:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ee7dd4-6f96-41d3-b8b4-08da96051869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i5YEFiZY1G1yNrG/P61Wkf0Tsg9YX1bZOvlf4/+LL8aXYXP8t/ZOGPHQ1mkAfKjxEg54vagrA5Zji/O++KH/cGlLNZ8hXoxrYy4OkAsnGU8wEVPMUfFnIQwFDsY1i8FQ3ei5zGtJVZBMEJpbEy2zB6Q0808ZoZMdjynN5vIN/o4b0f8JEF6BMW24YO49xoFah6wMDhAYmWejbztRW3RxWBxfMBmXhnDThARJcO1P63gUOMrGHXTyRmGy8288mGqvSxWnOweMxrQ1vXNVukkQWmuO4/hzTkK3ri1jA0KPBZLvYyXKGnznDtOcwyzsesZchMf6UApvG/GAG/f1gv6jApBK7a5+7Esdh2aZttm/TkMxOzag7+0UDSZyI02YtDlnzWUFORwMPJdkiP82uzTHrFm8yzvCDgcnRo+7wyCHEtmwK+MbjpTS9hVJU9pP3dzdYaXDlBUPpZb+REfdChSAquwtwzOp6uZnHXIMMPjTLpJWwxS3Crte921xh5Zd+urc1ZnLXmgJ0eYBPBRxiM0wOYfugwXaXBhK4JTModOEVLiyHvtDF43hwBmYLX1+2qb8JsWAHLhjGKYAAfxIYfsgU/gMlh5l+DooK2cV/azs7SBV9jg4+967xjm/n1uzrbHREU+m7MSPPAJREj2jIJ5dzFys4dmaz0JDI1ve3V3dI4LRwbYCabbme2jFzFJ3zD9z0N/kVOPTNdlvVA+bRmS2C+gWgyZTeyYN4dsjdYx4Z0mTLHYg/4PE6g2uL/KTUMp0ipOEFdnyBISx+Wb6KepEuATgFzm5BZPhffSWFZL1ViY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(8936002)(47076005)(186003)(81166007)(356005)(40480700001)(82310400005)(1076003)(86362001)(316002)(41300700001)(36756003)(36860700001)(478600001)(7696005)(54906003)(82740400003)(83380400001)(6916009)(6666004)(40460700003)(4326008)(70206006)(70586007)(2616005)(5660300002)(26005)(426003)(336012)(8676002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:56:25.4306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ee7dd4-6f96-41d3-b8b4-08da96051869
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5422
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
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
This shouldn't trigger during tiled display hotplug/unplug but it does
because one of the tiles can end up with a NULL plane state.

This also doesn't guard against the hang that it was originally trying
to resolve, and can instead cause DIO corruption due to OTG sync
being lost.

[How]
This was reverted at one point out of DCN31 so revert it here too.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index fd4b79746f4b..193a0f3de18d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -136,8 +136,7 @@ static void dcn314_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state
 
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
-		if (pipe->stream && (pipe->stream->dpms_off || pipe->plane_state == NULL ||
-				     dc_is_virtual_signal(pipe->stream->signal))) {
+		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))) {
 			if (disable) {
 				pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
 				reset_sync_context_for_pipe(dc, context, i);
-- 
2.37.3

