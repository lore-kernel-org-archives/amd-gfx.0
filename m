Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE7DC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 22:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5C318D6EA;
	Thu, 21 Jul 2022 22:04:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D55498D699
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 22:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwfCf+OBdHkxLBlgRrjessBp7IG2lcdAOBmXGSU//kdbJ9qXDhS6/6qOJ0JdEVjXmGlo+FLNxY8NPQaMOXAS7NP6po01VHfOIKhD/sfgpKbI9Q6jxVouSK16lc2bCFRzmhND/9Yeae+VPlJiZ6bIncSh6r3C2HFdWa6w+PYa0Y72j0MFZDXGu0JhwLoAImJubOE5DaQAvXXGeNcHSIq1qqOzymrqQLrqn5bfgMpL9qRDkQ2SEKDi90wh9u9+OESKUa1vahznc3dcdouhwLUEzDBH9aWWtfykbjdKRB50K0sZyV2B0RKXtaofSmMkXQUnpiO6XT90YPj+6FLzoEbsCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=139AnBTE6K7nlaK6VcfVIl7bxBorPBmsBPYAtfgxXoo=;
 b=RnslQiPxAqMpAd/uPQmr3k8Q/kCzZlbpvOaDkxwnSQXSAfoF0kLl+tVNQ5TSa3JqhJrTi/t7iqScCZHkS0IYwt+lCOGpylEwLgAAEHE9j79DripcHpP7B1M7mgp6GE8EtOB+mzg59t02m88xquDuwOwLwLO2E19ZRpNncwESkWTgiV1bKo9o6j8WRY5D3T4x4QXdYYuBKUswpmjR46xWa4T77o2MLe5KSGVB+5pWTNqVLtqoZ8BlR/3DAfyu3K+6AuZ2seTCmRx5+NBU3zou9rJBsiMOe/WjigceoXcAdr4ihkP5ser6bNRC1/Tte3IupD//j4iHC96Qs2G7vZOV0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=139AnBTE6K7nlaK6VcfVIl7bxBorPBmsBPYAtfgxXoo=;
 b=eW1II8GaR8tdo06CW+bWFPOvdHzgiWTNpidGGCb2neVFCrjgwrANGcID9lY0YPhIugGPRvHGtUACjrSKAewf99l0OT7Y4spnzEteLNifNVMcnKj02VNnc84T/LuifqI7IywOHNz04ceu1TMr7MV1+mQwBMpYyjf2yy4IaDk4vHs=
Received: from BN0PR04CA0052.namprd04.prod.outlook.com (2603:10b6:408:e8::27)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Thu, 21 Jul
 2022 22:04:29 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::6) by BN0PR04CA0052.outlook.office365.com
 (2603:10b6:408:e8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Thu, 21 Jul 2022 22:04:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 22:04:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 17:04:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 17:04:28 -0500
Received: from roma-vbox.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 21 Jul 2022 17:04:28 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Specify supported modifiers for dcn314
Date: Thu, 21 Jul 2022 18:04:23 -0400
Message-ID: <20220721220423.32618-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721220423.32618-1-Roman.Li@amd.com>
References: <20220721220423.32618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b8f5cbe-3576-40a3-fec4-08da6b64fbe2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4456:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBdLGEIcoUmx72QHk9AtVLVk/NC8O2vE38VpQzJ/XpIXM8qpwbKBXGbj/N+2LWOkAuwWLG9srZ6FOAPfpti+GQQkq0RYWQy0LnD1uAHdZnwd6poPLwQROQGDd7CIBYCKAcUla3pev1meKWfgP/yTzht+msdWorMafYcPdQ/53WAoJJ8tyb+MOpNPJ/FeaCVp2RwksHvi09y/oVXErLF+D8UatBEzOzOkGCKoZYTdpWgrkUrOr+/AGdFwwqf7QTWG0/pG0i9wJ4s9fWAH9azn501ipVIi3mEMnden022LDYsqXkLsrigzvci7bcEAsIbDg3vniLgfgzhztuJHGIgMaUKGTCf3AA7FlPl2kmTQcgJKOUtV5TzM117BmDYGIJ3bwgDEDuJoyCqcJDLD6P1zIpaBMF+DX0TMA2Ac1EC8A5r3eFYTuvUKeurbC2QBtYIh0M9MhFL/KDtnkEk4fdKlGIQQRMJ14GzycCdBIpgKbcAA2YlxmryNb3u7q4rog5FgVBi0WkWS1bnOOHOI/g9MfOLnecN+NwHsskqi+svdA8LQm5WqSoOdgSu8MwwWouXGXGm7WM1eIYqTi5sn0Dw7xnzzWxTs9Vv6SqKE/VrNylKqg0EQs6BbM65jbFliETWilj+5eCWew9C45Gixx/E4fburyB7amwT2Y2B40q6VduPRvgYuzkwgddSsc8+o2l6PCtIUTzVf/YXQjM5VsBwCRZrkTVtJKNGYJ60kuTZgqAcE8ABLu7eDh8crWjE6kZYU/9pI8C72TiPE9M5Kn1qFe0zuk+Wry2T+CUvGAUZh3RdxJOjgseQctU6Q0QhOEaXYsGvhqr1XhFaY4tCsiKykKxUFpv2om6Ay0bJQPF6uhQg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(136003)(39860400002)(346002)(36840700001)(46966006)(40470700004)(5660300002)(478600001)(110136005)(8936002)(356005)(6636002)(82740400003)(81166007)(316002)(336012)(40460700003)(426003)(86362001)(70586007)(8676002)(4326008)(70206006)(186003)(47076005)(2876002)(7696005)(2616005)(36860700001)(26005)(1076003)(41300700001)(6666004)(4744005)(36756003)(82310400005)(40480700001)(2906002)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 22:04:29.2580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8f5cbe-3576-40a3-fec4-08da6b64fbe2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
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
Cc: Roman Li <roman.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

Use same modifiers as for AMDGPU_FAMILY_GC_11_0_0

Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index e27621e11947..2b3de9d0d3f3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1404,6 +1404,7 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 		}
 		break;
 	case AMDGPU_FAMILY_GC_11_0_0:
+	case AMDGPU_FAMILY_GC_11_0_2:
 		switch (AMD_FMT_MOD_GET(TILE, modifier)) {
 		case AMD_FMT_MOD_TILE_GFX11_256K_R_X:
 		case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
-- 
2.17.1

