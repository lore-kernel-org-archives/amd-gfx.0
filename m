Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE2CC04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 17:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5481410E4E5;
	Wed, 28 Sep 2022 17:27:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7616410E4E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 17:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUTDKjvBulE7B47fJU+R0OTvZGcDhn1k3/GJMCtwNX0tpFEU7kPSqe3+io+eulyCO52qxENOQwWkX0oXv3SV8+Qi3wRiw/LTNb1yMuv9hWNJ2daIU/APDrJC9U79fsoegm4miaP6wBEpoZlRikoCJum/GmP6lvDgeNX8nXrAlDc70QluMlzLJoTwlzebeBg1ZO4LvkdZQcubF76QT4E/wMHLNv1En3joEVsQMU8MN4/lKoC/Ly033fYUrmNk9UYVTLaB02sEnVhDo6Wj29NgmlrJXCeKxDuO8AXoo+834D80VvD/3/i2yAEakRIyI4sSN7pUCdq2MhyF/0jBnHh55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRHUZvDuYHqXPy+RGccIACzjgOilsUIJcZyJD/QTnAM=;
 b=PtULlwZvtLPuAxnWW7MInPd6bJHPTO0Afdx1KyHAiupqaUcBi+Bfp8/ixuY9TRQp2lM2BECYJUYeC4+Er+uPJ8vPmXH/nh+jxlWEXFm3vhyXx2ORm4zUbWLQfogieAv8DbzlB1NF39QcyS/NQPEJnGQORu2N+CvM9/HuDoog+fn+LfJQwE3romglAuiCfJAylp+5CDlBJ790ZcBkOVOm82yihX73P1JnxobTQvBCLU4n+w8KOMVRtCZC385Ght4TRydf6J+v5Qb9G7s1i0KKP902+CKghBN18j1JAzun9EiDJHo/cBXKSVimD5w/o/nsbNaDc9t4Pp6Ugs3eWSpIaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRHUZvDuYHqXPy+RGccIACzjgOilsUIJcZyJD/QTnAM=;
 b=HrVzE8GcerNCne8Hsfvwz+oPjzaonwghejuy7C0PB0oZC1TVjxAnq0bXasFeKt5pWUrWEC4B8p8Afv4ebHLKlhgKRo+q8THmxIYylQJuvbJ+l5rIN9pN27McXRwqp1zBGOcBgEXtovqtveJXf1DSt/yu1mv3GpMqQL746nBCMp4=
Received: from DS7PR07CA0002.namprd07.prod.outlook.com (2603:10b6:5:3af::8) by
 DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.20; Wed, 28 Sep 2022 17:27:41 +0000
Received: from DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::5d) by DS7PR07CA0002.outlook.office365.com
 (2603:10b6:5:3af::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 17:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT112.mail.protection.outlook.com (10.13.173.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 17:27:41 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 12:27:39 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/display: Prevent OTG shutdown during PSR SU
Date: Wed, 28 Sep 2022 13:27:26 -0400
Message-ID: <20220928172726.128863-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <2e35ddaf-92c8-7289-31b0-4b85429a001a@leemhuis.info>
References: <2e35ddaf-92c8-7289-31b0-4b85429a001a@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT112:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: e61e5772-c133-4835-b0b9-08daa176bf28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gF5NDsabZO002UStDP7vIJ9NDbOi9dcHThXBpOR/s4OSYI3acbmBXxkYGiU5/Iq/XbRlZKXIAIp3knuQ6xN2Zgm+Bo3fYlqj/UCS7s7gMAN26zcBkDC2aacIjBeu/YBagcg3KY9WPD+wzlQoWgSYgqgU6uhBWt64DJ/er/fReXwBcWP4EZwBwdqzshZaaPQRgl7urzNa8OfIYtJvrH/B44srjb0xHrRBm96HOoKdk0KRHkAal8lXYtUSAlWXdddinENNAwDwpZfg/qATCvPL7mJ+BOfk61T8oQmCnir+TcMoreEt8PPmBoqr6nkVadbN5zOfGMxvQkYpaj6GHfq2gS7wyH+BjTihLIrIj0FAsNRmQTXtYOQxyoo5lXrMXbBv3O2E56gmqGJ5Wg2cgfwnOTY8DSSmUxI9BCZ8Mp3MwAmTa0wrJgD/KrTOAXddeJxq/q2aNI0P2Wuzsa1XO6v0P1BtxyCfzB7EUxTZ09RrjLwMuP+C4OrzpnPNwhoTK25r3q67o72Tk3IK0WHp2jnhZl4sIgYsrtHpj8crljZi/TnqkSM//itjsVNy/k8Q1XvhjxXV6yf2q/IpzBCg3WBONTyxg6nGt+PEGzRbJ6SOXURmJVokkYXJfmrY/VOs/pHXMlj66VPrBKklF/8psIDlIAGyBG3iXMqFcTQcqadVmgRs95YcFaf/23/yOK3htrilcoEOUezcd5TSIUlPW/z3DaBi/weAwZUoDLvSKncW+0niasJXLBT9EOxWhprFFVvg8mExTIkVGeeAhoWAJ8VwD9vzPKyi0gI6yNuvC/+Q9IlN15voBdV2oFZNxEjxR7D1RdqODM3XuhRKK/O7iYKZYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(16526019)(82740400003)(40460700003)(1076003)(40480700001)(81166007)(336012)(47076005)(478600001)(966005)(8936002)(426003)(2906002)(356005)(26005)(41300700001)(8676002)(6916009)(70586007)(86362001)(6666004)(2616005)(36756003)(186003)(54906003)(5660300002)(2876002)(316002)(70206006)(82310400005)(4326008)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 17:27:41.0580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e61e5772-c133-4835-b0b9-08daa176bf28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889
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
Cc: regressions@lists.linux.dev, Leo Li <sunpeng.li@amd.com>,
 Rodrigo.Siqueira@amd.com, regressions@leemhuis.info, git@augustwikerfors.se,
 alexander.deucher@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

[Why]

Enabling Z10 optimizations allows DMUB to disable the OTG during PSR
link-off. This theoretically saves power by putting more of the display
hardware to sleep. However, we observe that with PSR SU, it causes
visual artifacts, higher power usage, and potential system hang.

This is partly due to an odd behavior with the VStartup interrupt used
to signal DRM vblank events. If the OTG is toggled on/off during a PSR
link on/off cycle, the vstartup interrupt fires twice in quick
succession. This generates incorrectly timed vblank events.
Additionally, it can cause cursor updates to generate visual artifacts.

Note that this is not observed with PSR1 since PSR is fully disabled
when there are vblank event requestors. Cursor updates are also
artifact-free, likely because there are no selectively-updated (SU)
frames that can generate artifacts.

[How]

A potential solution is to disable z10 idle optimizations only when fast
updates (flips & cursor updates) are committed. A mechanism to do so
would require some thoughtful design. Let's just disable idle
optimizations for PSR2 for now.

Fixes: 7cc191ee7621 ("drm/amd/display: Implement MPO PSR SU")
Reported-by: August Wikerfors <git@augustwikerfors.se>
Link: https://lore.kernel.org/r/c1f8886a-5624-8f49-31b1-e42b6d20dcf5@augustwikerfors.se/
Tested-by: August Wikerfors <git@augustwikerfors.se>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index c8da18e45b0e..8ca10ab3dfc1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -170,7 +170,13 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
 					   &stream, 1,
 					   &params);
 
-	power_opt |= psr_power_opt_z10_static_screen;
+	/*
+	 * Only enable static-screen optimizations for PSR1. For PSR SU, this
+	 * causes vstartup interrupt issues, used by amdgpu_dm to send vblank
+	 * events.
+	 */
+	if (link->psr_settings.psr_version < DC_PSR_VERSION_SU_1)
+		power_opt |= psr_power_opt_z10_static_screen;
 
 	return dc_link_set_psr_allow_active(link, &psr_enable, false, false, &power_opt);
 }
-- 
2.37.3

