Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DA0C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0856D10E3A4;
	Wed, 22 Feb 2023 06:41:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F222410E3B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJmp5ApMldrTq3//3C3MGikMXDJchdy9l5R0mxGhA5FN/PeqLmmdqP4BzCgOwV90d8EoMHtYx3i50VkxquCvWUmsGNHDWxA7xtQtADIyuG/9B7rVA9Z+n7Gt02QVMMo7+VmPw3rr/d0TVYfdZGTQy6/mbiHb1daj/5RF4A7Mcu4wxPp7medWrlSynPuy0hBfhaTzKLpJgNRDGPBelEThMfUA2nflGopvO8GJuZGkn4gjtP6VkHpDqJmEqgkmXOM3NfmTVIQWp21DfyDO3Q4O37AZMU3SJjYdyBRWERdZt/2k5rceI//CSZtHXPdJe5zlvrfcjYIJ0ph3W4PcsKCsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtiYLQFffXa2aRUTjuCDOtOSx8HN4MDv01i1bPGH/gk=;
 b=b090Pq8AqNRS1zOSHO0l4oZGctcgOPs0f8B4au3tuXWoS+z2VhiTvaiz3KRE6yWkXSS/zrJmTh30GRGdYp5Us/Iwcm1CRnW+JP4/hVi2AIvkw+jiyf579Q9yFePu2t/ggogsWY79RKGfXkT6RLhSlGgjVn9FddQ58O6WKMq6ZnbLF+ZGP4tHtDGe8usJAvrQXC6HloVrCoCFZL2tnwuIL1jtigyVR/0BoHhmZgkBExOkXCqXYwHrkNMvSh9FgFnquXcUXu0eKKwGWK/2LcSOancaBojR35neaaXuGXWk00xo65YSLo3Nis6v1/Y6j56OljidXrExCk4Ky7+cIBDR/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtiYLQFffXa2aRUTjuCDOtOSx8HN4MDv01i1bPGH/gk=;
 b=hh79PFvYz2dbfdLuxwQb3gghgKAqz6/3du9PITV0REixEfVahpRDBe2RhzdQrE7AbqnTdUtoOoc3Cc4vgbF6YYZeOhnBQPlBFr4ZxKtEBi/f66OETi/kWIMkVvfvxvPQd6TEPjhF1Fc5xWLWj8FMQqr0GUrgY+/wZTQdS4OFLKE=
Received: from DS7P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::7) by
 MN0PR12MB5809.namprd12.prod.outlook.com (2603:10b6:208:375::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.21; Wed, 22 Feb 2023 06:41:22 +0000
Received: from DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::bf) by DS7P222CA0001.outlook.office365.com
 (2603:10b6:8:2e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Wed, 22 Feb 2023 06:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT108.mail.protection.outlook.com (10.13.172.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.19 via Frontend Transport; Wed, 22 Feb 2023 06:41:21 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 00:41:12 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/20] drm/amd/display: fix shift-out-of-bounds in
 CalculateVMAndRowBytes
Date: Wed, 22 Feb 2023 01:40:23 -0500
Message-ID: <20230222064041.2824-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222064041.2824-1-qingqing.zhuo@amd.com>
References: <20230222064041.2824-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT108:EE_|MN0PR12MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2d4de8-0af5-4004-f862-08db149fcf9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhQUY9s1GA2vGLrvDF7EeXuTdZK9fsVkhJzRF4v4Rgk/VD8JuNOAUpcanIb120T0rTZyn7CmcYDcRj050jgctNOux18qut02TwpM/MuUHsBUipagAMLKn1Zc+0IRhZsNvLbaY8dWa0YLsL0DRnXmT8HcTbab5oKvYb8zr5bPHQupYv32twI0M30TsiDD30KxwXxD+4fEhEIUAOja3TEozMee2UHnE4jeKBzBlBXbHC82dpbz0WSFCoIAfgy7I+rwmvPGuArZrr8nfhtXRGMIytgOA1BwiRfTKFjBWiXo9u72lfksfUKo06b5Wg5XmT9MNv3BNjAN5wOl43dB2y35gU/yZ/fjKjBkZIRS/VcKgXqDlkts6hyXdAEtdkCdXafdv2M//zimmh8MPAIGZhr6Nm3O0wPskrf5PGEfXupO6D2qOAuKZWEldsRfImffuU4bVcS9743MXWFsoOI4xQecC8ytMOYGdBwlKlAfnIw7Nu0G+Eeb4lzBg/DLYPjTeq3UNqW7G0VdkbGKWKtSbg7G+gupXa+mZZ59KWT47IHve+AjrOisdB9f61k0HowcKoQykorPQPdQRJLRjO06d/B8gL5/B5eAnqyXWFWA+cgGZy7+0YFDmzIDktC2e2W4f6sRrInYIDvD1LP7qnCUeQpvQAfwdRvm1mR/kdxbqvOuXbuL5+zo9DytNCMG4wSUf5JUuJi6XgP4cHl8DWOamYMBqE5KLn/3IwchDrTU5y6RuNhX7Opwx5xg3sWIWas4t9fI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199018)(46966006)(40470700004)(36840700001)(356005)(2906002)(40460700003)(16526019)(2616005)(36756003)(47076005)(426003)(336012)(82310400005)(36860700001)(81166007)(83380400001)(40480700001)(82740400003)(86362001)(4326008)(6916009)(8676002)(70206006)(70586007)(478600001)(5660300002)(44832011)(8936002)(41300700001)(186003)(1076003)(54906003)(6666004)(26005)(316002)(145603002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 06:41:21.7671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2d4de8-0af5-4004-f862-08db149fcf9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5809
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[WHY]
When PTEBufferSizeInRequests is zero, UBSAN reports the following
warning because dml_log2 returns an unexpected negative value:

  shift exponent 4294966273 is too large for 32-bit type 'int'

[HOW]

In the case PTEBufferSizeInRequests is zero, skip the dml_log2() and
assign the result directly.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c   | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 379729b02847..c3d75e56410c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -1802,7 +1802,10 @@ static unsigned int CalculateVMAndRowBytes(
 	}
 
 	if (SurfaceTiling == dm_sw_linear) {
-		*dpte_row_height = dml_min(128, 1 << (unsigned int) dml_floor(dml_log2(PTEBufferSizeInRequests * *PixelPTEReqWidth / Pitch), 1));
+		if (PTEBufferSizeInRequests == 0)
+			*dpte_row_height = 1;
+		else
+			*dpte_row_height = dml_min(128, 1 << (unsigned int) dml_floor(dml_log2(PTEBufferSizeInRequests * *PixelPTEReqWidth / Pitch), 1));
 		*dpte_row_width_ub = (dml_ceil(((double) SwathWidth - 1) / *PixelPTEReqWidth, 1) + 1) * *PixelPTEReqWidth;
 		*PixelPTEBytesPerRow = *dpte_row_width_ub / *PixelPTEReqWidth * *PTERequestSize;
 	} else if (ScanDirection != dm_vert) {
-- 
2.34.1

