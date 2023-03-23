Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381EDC7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 21:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A5A410EB77;
	Thu, 23 Mar 2023 21:41:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA1E010EB33
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 21:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INOZYJBj8sZDCzOav/M/qUVu4PhwHSNHupRk/3SkYbM2QCR1Y09b5Ll7QZS1pnqzBab0fZ+VSfCjc2K/EtUSflbsBv/7VhCg77vuhLf8eGPng82UehvPI9VxT4hLo/iDZx7PQeiHmuAao9LNpNEh1Pgn9PFZXGa1qOnBhO5AU/kZw50P1V0PWDIWJataASTFAIYe1rOn739D5ypYTsp1/hm/Can9wlxMUKTSqoqbrQeuIMcGKjYZKNXnGproHaOuyVkc425bH0Hxiwct+aBeRPoydb4hslHNdLBfNYLmkQ0zHioStGa7BKaJxTWFmCmtG9QZIojK3j3wHkmaMXXq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hpazb081GZq7uVg2fr2+sIlSSbx1wOblUHxjgV/nmo=;
 b=Qe9Mb5oslOvd/eKmhM01o6zP1ks2JYJbH6+C2GnM6g+LwKQxquAHfbjjNFF6Ozf8DF6fcnKOMYMqJhcQtblpfDgISCWEzse9Dk2AU5za5VkySsYIBYqbf+9u5DMUZc+XwZ0HA35joBFIISLPyvxz27ZpcHPCswBJakzrQ5OzOWHoyjAQee7lwnBNyIkuHXVLC397UmQDad2uupXb/7i51qNedENoNecd/z06g6d+hQ5m0OcdUwEiXp6ewAmgOv+yk5srEz7FJCXtbtr1zmPSvN+Awu1+xnO53D+vWaR2iMeumofOxMvzpg+lLo8e81ZlOIgeYL5Jor56V7jnhiJFTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hpazb081GZq7uVg2fr2+sIlSSbx1wOblUHxjgV/nmo=;
 b=kqopHvwnWFZearNWJ+9PXQRuZscQIoPxmVPVeV3Wh1BET7Kjwo4/nXcQBsCgIlPjijxKaazL5vdUN4gUGDWG+QGEdlyek0c1UHeODB1QjEliVyDCijn+ohM6+VCJY8fe4hvnF4mp8eLR6RG93TX+3oJLuzDBnWIHRXvYjBGlIQ0=
Received: from DM6PR06CA0097.namprd06.prod.outlook.com (2603:10b6:5:336::30)
 by BL0PR12MB4930.namprd12.prod.outlook.com (2603:10b6:208:1c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 21:40:54 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::70) by DM6PR06CA0097.outlook.office365.com
 (2603:10b6:5:336::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 21:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 21:40:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:40:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/13] drm/amdgpu: bump driver version number for CP GFX shadow
Date: Thu, 23 Mar 2023 17:40:32 -0400
Message-ID: <20230323214034.1169310-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323214034.1169310-1-alexander.deucher@amd.com>
References: <20230323214034.1169310-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|BL0PR12MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: e7909f18-2c66-413a-0cb2-08db2be747dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vwzfJj0Uo38GzUdnf8K1ia/qJFAt8ja/erGAP2V/CS24uicpDsExn9wTb2XxCKueFXa2ibBpHmXxEkn8n0+eQo7IBtRmFwxqANaJmnFRhjwAldzLxkcdkPQ56QQnkg1Mp7hvC6ErWI34y6Cbe9mugAAkyCJZEkRCds3GeN5XR8710qb+9WS1zr4JCQs1UxkWxlH/iVP92zOVyXiUIyMcsc2Qij2ZPUUulENt9+c5UBm3XRWzN+mzJhelxFStTJfw4U+1o6i2bpQV2ESGpox6fMw5qCFvpR1uOHOS/nLm97o2g0BaEaR+OPCr+9Xk2i8aMTQvMmsuyl+XC4lDDUP+p2pEROTzFVwJgCYes4sfg6eVdHHuF0/PZDaDcktA7Gc+5l+KxsPj7Imohk6VhuRpdqB3YswSabsl4TsbL9FWg95pV8U6VjkFKJrOpwiQc/ZXgi4N2rsqBptxZpziv3m8k2+NRwSiaNZT56+O7uHbRKGtK3XG4Bxw225q1EcGSMTYaCsykO5XTwLh/9+tlfhpQ/R8ixBXQYICoHWI9W7Wj+xsEr6HqhS9aN5gOvcJVle/Pd6FYNTHRDc9Foqc4MRKDNsJ0FcqyO3NCEdyhlzUjQp6Zgi+w79Vg1ZkDcAcljiuYo8a7LPlj8n7GgqnLzZ2NyefLRCDIwOQgeAaAqKKGz++PjlHjqDkOLplKq0wYKB5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(40460700003)(478600001)(8676002)(4326008)(5660300002)(70206006)(6916009)(70586007)(36860700001)(316002)(41300700001)(81166007)(82740400003)(47076005)(8936002)(6666004)(426003)(4744005)(26005)(1076003)(186003)(336012)(2616005)(16526019)(7696005)(83380400001)(966005)(36756003)(82310400005)(86362001)(40480700001)(356005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:40:54.5319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7909f18-2c66-413a-0cb2-08db2be747dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4930
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So UMDs can determine whether the kernel supports this.

Mesa MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21986

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 917926c8dc5f..c35baee082e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -111,9 +111,10 @@
  *   3.52.0 - Add AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD, add device_info fields:
  *            tcp_cache_size, num_sqc_per_wgp, sqc_data_cache_size, sqc_inst_cache_size,
  *            gl1c_cache_size, gl2c_cache_size, mall_size, enabled_rb_pipes_mask_hi
+ *   3.53.0 - Support for GFX11 CP GFX shadowing
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	52
+#define KMS_DRIVER_MINOR	53
 #define KMS_DRIVER_PATCHLEVEL	0
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
-- 
2.39.2

