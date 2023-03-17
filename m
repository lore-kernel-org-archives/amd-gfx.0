Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1B3C74A5B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 17:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09BF310E3EF;
	Fri, 17 Mar 2023 17:18:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9632A10EF6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 17:18:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjmOs6j55gUVGHx8GaFckAO2fUd0alsnQmFJAD3JSlt68260bH7Xi4NErLhQp2HQJZw2nc8gfWiaTPKaPLrtY9f44XgdQvqHHaQvO5TW3AQMgWX31wvZlMuBuBJ6ni2qQvWVvsjVwBvPwuRRnJ7dSpKLhf8KgtKhDUJWnECyYeA2eny1QyzyeZLEyKpntz2M83/TIAVksGH+X7sy8jaB5igO2sYuAG+KktJbTxo8wBeGnETFoWWRWjj+uLfUT43aXkDQXFpXd1goWZ2WK4AaV6r8lbGuc3HD4Z34G23382TcQPKmBDtM3ncI2bl8EDK8LMA2SIDANosgE20qxYkvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdXYbJFNmL4vNmBsCXT150gOmbjisDSif/U3tHKu00c=;
 b=g2C0QgXj7+CLKpZ6nfFQqPCmJj7Q91as+We9ayQuft/GxZzJDevPKgXpv+inM1o7eX+5OA5Ypxfzm9rokbqENHSDA2c/4+Qwcnju6PMfd4hCCVIuwUnolhGuUio8pPcJU+cvh/O6/kos/5/aAAI0/eOZBOjKnzSjNnJy8jy8Ob3DPX3y0T2BTTKlgZyVs48aYmGGnKDXpi5dsDUekHXZdteLWRNWg6qtvFOR6KN1DgKw5Ebgh1m8mokW3omKx/9MeS5GSDJpUdM8mZYYVCc2iy7lacXai4j3WF7YcNcmQUnd/0U2PIEt8rGtlC7gF1FXpsH9+/hwKdhkIFslywvSUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdXYbJFNmL4vNmBsCXT150gOmbjisDSif/U3tHKu00c=;
 b=zu9G8m3lDXiGNslnCkRY3UpAS1oqk5OQ54Eu5gqf63Ib5SB0AVr24GoRtGpXNAntfCCCM+wQdSCfxPO5SC6HalOfmpvwuiYSyHT+q1DAciscEqilq9YXYSel4Xi/a7ItazS0FR634YhKYzlEG1V9smzweiCNTAnp66W3dAVFlBU=
Received: from DM6PR08CA0023.namprd08.prod.outlook.com (2603:10b6:5:80::36) by
 PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 17:18:13 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::1e) by DM6PR08CA0023.outlook.office365.com
 (2603:10b6:5:80::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Fri, 17 Mar 2023 17:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.16 via Frontend Transport; Fri, 17 Mar 2023 17:18:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 12:18:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/10] drm/amdgpu: bump driver version number for CP GFX shadow
Date: Fri, 17 Mar 2023 13:17:48 -0400
Message-ID: <20230317171748.682691-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317171748.682691-1-alexander.deucher@amd.com>
References: <20230317171748.682691-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: ca200e5e-2a25-4cc9-bf55-08db270b9713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Dro0mC5c2tLfPrATj2XitbBLZOc3+npnFKNUuQjwe11vPzpKFh6g7f8oOjIm0xlF/Ow8B2oXJkdmy1obHLYTtVfoEvbPQtfxTbPsFQfKo0UXrFgaUWTNSBe/OJ0gaq+eiD4cqwKfO49GQVdeGyM2cb/sXLlsGXInLYpc1vCzsdwGuu4C8a0A8kLddjJpQkmP7ZXhBQh6WcABDEwY2cTU8RSNGsi37ZqNi8g2xUVozGG1N8kTcpVpASBe6duz0j9n0KepvNKrgkooi8mbevx9y2CfASgJ5TWwf/ZhteJnC0VLxUlNobuyfXptrtpk+5HXOrKq4pg7gD2heYJ2yiWtyzj2ubzVAqvzCbSOEYtkuwCF8Eye0/j5PrLgOY9zh6QQtOzIc8x0ZV4nNM+PcVeqmDhp9TFgU5L4W9kqhlFyPqLC4wqx3HCn/LePIh/5fTEMkT/Zj/bI0Ls5KZLRTpuB9Ba3evB+kHfcD8qU/Kiu+bXvS+LxPTkBUIcRC8uvvVdOQL1M2vv8oMNXlNiPsyr5rQrCTxxVTeFPCWcJGfPvjobt7soRfTtM8bj6Nrzs7yVAHhfWZ5PNzLUzPHjQcne9GPAcFADDv89QINicLHxB1Ujy038qOB7w66thq/mlGG43HTnREuljgXr/HmZqRwW/pUpqaRoRnpylVR68CpJX1JJBryoKRaiV2PAug/Ickv2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199018)(36840700001)(40470700004)(46966006)(316002)(82740400003)(40480700001)(81166007)(26005)(1076003)(2906002)(478600001)(36756003)(41300700001)(40460700003)(70586007)(70206006)(4326008)(356005)(8676002)(6916009)(82310400005)(6666004)(5660300002)(16526019)(83380400001)(36860700001)(4744005)(336012)(8936002)(86362001)(966005)(2616005)(426003)(186003)(47076005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 17:18:13.5053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca200e5e-2a25-4cc9-bf55-08db270b9713
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818
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
index 5f02c530e2cc..9caa7b7f52dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -110,9 +110,10 @@
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

