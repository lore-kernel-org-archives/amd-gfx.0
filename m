Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F708C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jun 2022 14:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADBA610F793;
	Mon, 27 Jun 2022 14:32:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBE7210F793
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 14:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQJ6OjOGLhZaCJPMtu7rYjt1HCRyFKtsTXZB7Q3/am4ZUBfhkhKBAjraKZ6smEWhKhQ+yvIODj8kqu41ZJ9SNUmKl+1f12SB0jxxxNZfxQqi/cxp153yELrExtplCQKmRvs78eet/x2DHWdcVmPkhXUEMjAoctswr4t8D/p7ZhFjz3u6tl3FmukGjYv98feqXdohUf0F4bmC5JKLgFzgHj844Hgq+fu1RIzcEcebe7AJNZx8aCvnYRh/kD7Oagk9dmEnK7pzHNcSGsTBOukg15loTzUGGyPAGZ+m0l2fYw0fuppwZZnu1spMLW8KxhhdL0vs7AnkL60+JRmPncHRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40CLiE0hAPG8K2MEbMJZAjaONhXynBVTDX1OXNIAUb4=;
 b=l9xzwDedgtcHrosASi++ajwO7rH2LjGVagLRRZhjx3R9+f/wF1O/OlNR8Uh5++e6/1ahpUv9LewfCS6PPFIat1+TbjFCqlF/v1Td51laQnuXZbD2uaxiIYlYoAXofSc6ndE8sMY2vWjmLuXlU7/ZSTTQDAKthFpuwOqgJh7t9DMYlMHFYwpdQy7TeJwh+WZuLfR/Wx5d8eDS/qb/dfMlumCDrPlcIxkuuryzqShN5Q/0gQfCxMWY9D3WyuUiu+qrJKQKCMeb0RKLeUOqKZ4J9VrW6AF0V5YOV5RW7JlVFrFSg34trJ3kkgc+YcoR/c2mvVQLEIC8JrSHIEpaM2aRtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40CLiE0hAPG8K2MEbMJZAjaONhXynBVTDX1OXNIAUb4=;
 b=KM9U6MYZEc8V2KN7GSHY1vQyZjUXStCnJFwnFHdaJEt71mQkrmETBlMjTjImhSPVW83wPncFsHdNI2J4ZAi7GgBQpuUtZXtql3KKkSX4/6eDNcO9LzReQcRgJkLCE/AKERhIamuZMd0lVwDo/gtEKgFR355rsDU3Qbl7dcncvxE=
Received: from BN9PR03CA0119.namprd03.prod.outlook.com (2603:10b6:408:fd::34)
 by MWHPR12MB1485.namprd12.prod.outlook.com (2603:10b6:301:4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 14:32:42 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::3b) by BN9PR03CA0119.outlook.office365.com
 (2603:10b6:408:fd::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Mon, 27 Jun 2022 14:32:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Mon, 27 Jun 2022 14:32:41 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 27 Jun
 2022 09:32:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 27 Jun
 2022 07:32:41 -0700
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Mon, 27 Jun 2022 09:32:40 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <marek.olsak@amd.com>
Subject: [PATCH] drm/amd/display: expose additional modifier for DCN32/321
Date: Mon, 27 Jun 2022 10:32:40 -0400
Message-ID: <20220627143240.1644836-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af3625b6-304d-487d-7681-08da5849e4a6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1485:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3eXPLycN7T6RASUtW1/2h1Xr3MuNzwLnHCfBmrZGkn0v0d9wBhJsUCHDTYyHtgfAWZarRZknf8JWi25HpUv47Dj78jgnhr5N964EhuQ/wn7O+zoaPy4H3tFSZ7RHMWLFw1cVNxQsgs8d9o9qCRLdKqP3WYiJZXKOdphOXNDHOzyXKWmxVgw776dfwaLGEX+9Hmf0n9TyzJdwGriB6Xi97sigITIo+kZc2jvHipmjC3R29ooBBKSe/oaybhNpYexmXAU+em+MFFfpm2+ZPMFqIoIMQWwATWFAw4PkSTG6MAIERsbWgPc/geGqramYzFFdFfQeTYt43YJVw/+HTz2+s0PDnhp7BBYfgZuCHfwdG5zNzwZWnMSAoPwv+jAbHEMG5BnHd7iCkXM056C7lcNrv3ToeY1jfvSCRg/VskscKvppoJ0QQuydZdu3SeTK4iqvZ4UTAIfbLoxajfgiQ4OzhxqPyjS+x+e+oeCrQC+OYuigrra3kqalwYn/P4mr8rBnDmJ2wPqivEalNKkWNKvu/IrzamrwWo77SCSNF86YT8NoPZmDiuPkf2jK8m4Ner1l3ESVdpwW7Gw5MC093pl9w8YDRFUOG4Dx42j3JlYE92cWVHk6XC2zR8JYve0G2eRkrNPnOMzZYUF4CGThmhkFO5cNBigC3oDA+iX+ottLGH7xh0NovgCz5rsiTFEvGI7bRSOF24K+dEodc9TcKD5ChVRwEAWygjNBtB+zxaw0FbshTBPED4ZyjAy9sQYzh14Zzu9FLlro1flx3CEGek7EV955uduboay4WC2E5l9yttzR5+Bxh38Vyv5JUyOtOoKJfYJwgSYumFoy1xW5hH+GYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(36840700001)(46966006)(40470700004)(44832011)(36756003)(6636002)(40480700001)(4326008)(5660300002)(82310400005)(8936002)(40460700003)(110136005)(2906002)(316002)(26005)(7696005)(54906003)(336012)(83380400001)(8676002)(86362001)(478600001)(41300700001)(47076005)(426003)(70586007)(186003)(70206006)(82740400003)(2616005)(356005)(1076003)(81166007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 14:32:41.7692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af3625b6-304d-487d-7681-08da5849e4a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1485
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
Cc: alexdeucher@gmail.com, aurabindo.pillai@amd.com, harry.wentland@amd.com,
 bas@basnieuwenhuizen.nl
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Some userspace expect a backwards compatible modifier on DCN32/321. For
hardware with num_pipes more than 16, we expose the most efficient
modifier first. As a fall back method, we need to expose slightly inefficient
modifier AMD_FMT_MOD_TILE_GFX9_64K_R_X after the best option.

Also set the number of packers to fixed value as required per hardware
documentation. This value is cached during hardware initialization and
can be read through the base driver.

Fixes: 0a2c19562ffe ('Revert "drm/amd/display: ignore modifiers when checking for format support"')
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       | 3 +--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 1a512d78673a..0f5bfe5df627 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -743,8 +743,7 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 			switch (version) {
 			case AMD_FMT_MOD_TILE_VER_GFX11:
 				pipe_xor_bits = min(block_size_bits - 8, pipes);
-				packers = min(block_size_bits - 8 - pipe_xor_bits,
-						ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs));
+				packers = ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs);
 				break;
 			case AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS:
 				pipe_xor_bits = min(block_size_bits - 8, pipes);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c9145864ed2b..bea9cee37f65 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5203,6 +5203,7 @@ add_gfx11_modifiers(struct amdgpu_device *adev,
 	int pkrs = 0;
 	u32 gb_addr_config;
 	unsigned swizzle_r_x;
+	uint64_t modifier_r_x_best;
 	uint64_t modifier_r_x;
 	uint64_t modifier_dcc_best;
 	uint64_t modifier_dcc_4k;
@@ -5223,10 +5224,12 @@ add_gfx11_modifiers(struct amdgpu_device *adev,
 
 	modifier_r_x = AMD_FMT_MOD |
 		AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX11) |
-		AMD_FMT_MOD_SET(TILE, swizzle_r_x) |
 		AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
 		AMD_FMT_MOD_SET(PACKERS, pkrs);
 
+	modifier_r_x_best = modifier_r_x | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX11_256K_R_X);
+	modifier_r_x = modifier_r_x | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X);
+
 	/* DCC_CONSTANT_ENCODE is not set because it can't vary with gfx11 (it's implied to be 1). */
 	modifier_dcc_best = modifier_r_x |
 		AMD_FMT_MOD_SET(DCC, 1) |
@@ -5247,6 +5250,9 @@ add_gfx11_modifiers(struct amdgpu_device *adev,
 	add_modifier(mods, size, capacity, modifier_dcc_best | AMD_FMT_MOD_SET(DCC_RETILE, 1));
 	add_modifier(mods, size, capacity, modifier_dcc_4k | AMD_FMT_MOD_SET(DCC_RETILE, 1));
 
+	if (num_pipes > 16)
+		add_modifier(mods, size, capacity, modifier_r_x_best);
+
 	add_modifier(mods, size, capacity, modifier_r_x);
 
 	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-- 
2.36.1

