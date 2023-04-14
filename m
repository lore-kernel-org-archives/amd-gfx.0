Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926B3C77B72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E08910EDDE;
	Fri, 14 Apr 2023 15:54:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0F8910EDDE
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XW76aclY6g1N/x4hT5m93sTol+vrDtKDh/w0p6ZBntpl711tP3MZdP9gaYdnfLWlZ1zVAUVPnwXi9Hk2bpmTw2+VN3M5yhTb3yI8mwb1RuIdajzMe4zmpSy8F3zS5Ybh1uz5l0uY+dlxk52OG6Z+qUcQjmJBZ5CUojjsfClGLHVRg+zw4zkE6y2yVfucCYh8BihQ2uSOmrZ8yA3uYz8j0CR4w3fkkhmCtqDNBeCuPeNhjSI23tH7z3Y9HVVb3ooUKSR+wAt7s8izY2U+alBaZd2EyS0YJVNaH20cYn+xqTKZtyEACSOb5t+hpdV/4uGP8QDJu9Zh8WlWWkeFQ55elg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SXsXEHMxpBLYXDWTbFxrCla79vR9zcRZcOyito05IU=;
 b=ih1+WBj94qamLpyztPUx31JdFQ55l0HboLROll0w0Vw6che0jey/VkVKABOB+KrDLlbRZxHqdII0gVVV0OEl3qNOaNbNBaWMU7O1F7N/8XUJ3QWIUrvhY2okoQeEuOV8IHx2v16q+UJcdDrmr3EJpAp+YfOwljQHJLw7bTpd42/MsmYOJ1VohjVY612qaETHJuoCPNDOKA0EwPBqh9zJmlBusiROQo591NZP2r/FX0v1wL1abLJnwTo/+X+NOMTgmsmEsFDHMJR2Q1LTpbV2h5e7ZZbVzW+qrxsVuXgwQvCYys/OvoxL0rxpTH8KjXANJkFkj3RaokOUmhZcXfocTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SXsXEHMxpBLYXDWTbFxrCla79vR9zcRZcOyito05IU=;
 b=1/bdxk/btP24VH/zHPPbyLuIuU7Zsc5+siIGIPVp+NOYEJ66PwGTyEqRHCI+yeDXA9NOAFcaRiL4XpDHjstJ8pNWPAe7KbLsN/cH1HqgccisQoLEuY7HQVZhWGIwvt52sgVRb8RK22yXIOieINNTjJTlsfEJXSFdK5ijl8Px6rg=
Received: from BN8PR16CA0008.namprd16.prod.outlook.com (2603:10b6:408:4c::21)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:39 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::d9) by BN8PR16CA0008.outlook.office365.com
 (2603:10b6:408:4c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 15:54:39 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:37 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 35/66] drm/amd/display: limit timing for single dimm memory
Date: Fri, 14 Apr 2023 11:52:59 -0400
Message-ID: <20230414155330.5215-36-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8d828a-8bf4-44f5-59c5-08db3d008df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NrniwBshRXX6w8A0T15mZ2Gxhy5HcW3BqCXxRub6rN9Z5wwLlWQUCFBS5RhxpRpjXGn8GufrWYvXr27I6cx+IDge01tFGwcsWmHuvcisgLjgmiOx7qsRtcAJ8tLBSdwS3LSip71CFD+Sm26jWW/qnvfbLYya/oB+DvuIwfahGH+12YY/PppLRrkScbaEy7j9lcXKez8yfO8h2FSZeRpms9h6mrt4YjJmTUGd5Tri65d7Ty9oKYre98kgl1t6oLtPlLKng+zBAIPAA5BiL8zTLrQfbueazVXoa+kVSXCHIVVr8oEjb4sQyW7Pa+RTK1Wb73Clddt81WySUFT+SjnPvi0L7pOxSADfWP66UMcKvguxAv/HdDPChBi4cCgO43JSQjXyFZsRbzqag4pIQuefOpeYsezQwHunLp1n+jjBaaK5iQJyIOpVfnhlHAKGMkdQ9rt6RdB0VN4MNGymc+5APMTNl+mAfgMpM1lm9ZNW+qgElVjaHWKyXEi3pDrP4KNWAfvugPMo+rpC7vXJD9bmqduinWDUXXPMPsV/jhtmSXumQY1H+n3OQMYQ6ylCQAV9CXdRLT1YzAuKxuM+ubIqOuCai3IvM3XPuxTf1lR/jfiEIZUrjPPi5rK+nl6cI/NFor1PSXgLxyXqFvYMFfYaAMZ22lVGTIxsRtS7shuPEY1GMc48wSMUfkdLDeM6TPV7I0mSvXKxKFHfnJ+yAPhkxWOansrK/dm+MHTP+ijT27s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(336012)(426003)(1076003)(26005)(70586007)(70206006)(36756003)(40480700001)(2906002)(6666004)(83380400001)(82310400005)(47076005)(2616005)(186003)(16526019)(36860700001)(4326008)(6916009)(82740400003)(40460700003)(54906003)(86362001)(5660300002)(8676002)(8936002)(81166007)(316002)(356005)(478600001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:39.3615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8d828a-8bf4-44f5-59c5-08db3d008df6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
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
Cc: stylon.wang@amd.com, Daniel Miess <Daniel.Miess@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <Daniel.Miess@amd.com>

[Why]
1. It could hit bandwidth limitdation under single dimm
memory when connecting 8K external monitor.
2. IsSupportedVidPn got validation failed with
2K240Hz eDP + 8K24Hz external monitor.
3. It's better to filter out such combination in
EnumVidPnCofuncModality
4. For short term, filter out in dc bandwidth validation.

[How]
Force 2K@240Hz+8K@24Hz timing validation false in dc.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Daniel Miess <Daniel.Miess@amd.com>
---
 .../amd/display/dc/dcn314/dcn314_resource.c   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 50ed7e09d5ba..24806acc8438 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1696,6 +1696,23 @@ static void dcn314_get_panel_config_defaults(struct dc_panel_config *panel_confi
 	*panel_config = panel_config_defaults;
 }
 
+static bool filter_modes_for_single_channel_workaround(struct dc *dc,
+		struct dc_state *context)
+{
+	// Filter 2K@240Hz+8K@24fps above combination timing if memory only has single dimm LPDDR
+	if (dc->clk_mgr->bw_params->vram_type == 34 && dc->clk_mgr->bw_params->num_channels < 2) {
+		int total_phy_pix_clk = 0;
+
+		for (int i = 0; i < context->stream_count; i++)
+			if (context->res_ctx.pipe_ctx[i].stream)
+				total_phy_pix_clk += context->res_ctx.pipe_ctx[i].stream->phy_pix_clk;
+
+		if (total_phy_pix_clk >= (1148928+826260)) //2K@240Hz+8K@24fps
+			return true;
+	}
+	return false;
+}
+
 bool dcn314_validate_bandwidth(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate)
@@ -1711,6 +1728,9 @@ bool dcn314_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (filter_modes_for_single_channel_workaround(dc, context))
+		goto validate_fail;
+
 	DC_FP_START();
 	// do not support self refresh only
 	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, false);
-- 
2.34.1

