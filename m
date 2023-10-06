Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734F4E92FE4
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 05:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEF6910E4B2;
	Fri,  6 Oct 2023 05:00:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D484310E4B2
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 05:00:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8lmHzJLT6fcHzsYhKqVGzpQSSG/XVrBaZUA1jMDUYfxKHh+Yu6SKGlBWNl2eClkAujDLDlwWsoiWSsBNjtv+ud92k2lcOyfuxgi/PEK5K6GkeUOAIWoZONOrMID3r5tnbtDBnFP79839G0nOBaqrbN6ID7eEJmT+KBO2p7GpST9g5Y3kfm72ROSswHpFqs5CV7BNBm3U3fQSk3uT33bmmA4ZNFLZmPglBKv2T5Dyp2LOUvgjKSnT3X/9lzckIuDOALQyDkI7JrHWz6fI4pslw7jRCX8KVO15pwDGSXbh+Ed1Sra5mt105+NqpzGHfhuYCytOn/Wc+URwAOkkOngvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srML/Nc5yJbEyjV5sUoc/tENwJXTtTRPKBCM59Bc89k=;
 b=iT6lNVstUOmB0TxFOVB7j7zt6HmLmYLgpQV+hOzfby6cDxrzUQLY4njfTZY5MgGuqE0AUu3TGfzx29vhHaWAY7gnCOSH3haBz7BizZAO6em84wexITQpbnaYR9q0Z0ojMZVdYm0KTB7S/jY5ht+dnBtIphKHSjkDuj2/wqDBiFHqy3r0QrldBfb0RffDXAiT9ZV7cLnjazK0b7ymtn4W8pSggfbFun5FniTleQMcij9C+njRRZ11wot6jPw6vZA3A7fPRFbM5n4i6Tyr+qGWpenOOUFFsmZsCRhF45bu776/yQLxNGLyQlwhrdHDrmxjL8qXZkm41oZyDlmgv3saqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srML/Nc5yJbEyjV5sUoc/tENwJXTtTRPKBCM59Bc89k=;
 b=4XwUg1DT6iGdL6nLddlV5ZKYjZ/Yp+BgKYqo4VySc7uHFf4uZJeiMczvfCXdBKZV2yX0HeW2zf4pyxSNTY39zU+ReATl/PZ/rP6PIqzRmX1HifNSycXYCUv5DeHlb5xrrA9m2cjFvqjrgk46xDggqt8BSaTYGl6NAE315ABzFwA=
Received: from CH2PR18CA0039.namprd18.prod.outlook.com (2603:10b6:610:55::19)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Fri, 6 Oct
 2023 05:00:34 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:610:55:cafe::1) by CH2PR18CA0039.outlook.office365.com
 (2603:10b6:610:55::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 05:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 05:00:33 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 00:00:29 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Increase IP discovery region size
Date: Fri, 6 Oct 2023 10:30:04 +0530
Message-ID: <20231006050004.1556697-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 065bb639-e0e6-4fa1-056d-08dbc6292bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZaw+tMR1cZj2sqXNRGFDvcjwpIFYXFftTk9E7m+3tiJlyd/YA2wy4sRxPJoKpK0px0mf0VZrMKD3YLQ3fGpbGbgSbaHx2CuYA+qwZeLxIejgb8e3odTebL48ZnsdoSLgEnx4bB/dC4x6KE1GVSEGMIF5J4IRG2eNa/VjJNIn2yzJtFI6/dC6KWugcBj9kXydiheDnzkXJGobvv5EbBrTVCMG8DiMz0MAq5HiaZ4KiGlEf48NS9+ZCI/MGorsT6MUurlp0CqO/QnPUklJGMwc4mwq6OT3oUz0mSgXoCEQnc54Z9IrwcCuVrEGKu5HtANXUP8oKyBh1TvFTnrCcBT4cBVu8yAlQMyYWW6BgA8H3pM19uu/RSPAjbnYU6SQZlLzPNEFyTapuJPa+g3Zo1CB2B8pW29Z3BnQyatHd3D5Ob6Rjf0SQlwOFamlwNmDk51paP8JKSXUP6+I3DZuMwAhV3DEjgp+dfb58F1+fqQLI7Ix7tux0my3vYZ4cVy4YJHVMWMsa6zAEw3z5wuijmd34syMF5Nqug1cFRZSaYEkmjokEV+X0YRtMhjh3z1ruzZjt2ytOh49PhXgsqqCxx1pQQXM2m02GvGlSYx1Pxd3cyn6SdkQyW+hzzNyk5Q4QM9HkRyiTPIeIBMZ7vvMH8iWnk18jGlBr2lT+W+4K13YEZjFjawxkFrcJRk6M35TEtjvx2kmm9M+2TG9qix8TtB0WGTX2tUtlsJF548UJ0Mg/k9xTdF03xGJwCy6IFKqzEZIOvIX4coKiRrVlgsyDbmKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(83380400001)(2616005)(1076003)(70206006)(336012)(426003)(26005)(16526019)(47076005)(36860700001)(70586007)(54906003)(6916009)(316002)(8676002)(8936002)(4326008)(5660300002)(41300700001)(44832011)(82740400003)(7696005)(6666004)(4744005)(2906002)(478600001)(40480700001)(36756003)(356005)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 05:00:33.2335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 065bb639-e0e6-4fa1-056d-08dbc6292bcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

IP discovery region has increased to > 8K on some SOCs.Maximum reserve
size is upto 12K, but not used. For now increase to 10K.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 3a2f347bd50d..4d03cd5b3410 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -24,7 +24,7 @@
 #ifndef __AMDGPU_DISCOVERY__
 #define __AMDGPU_DISCOVERY__
 
-#define DISCOVERY_TMR_SIZE      (8 << 10)
+#define DISCOVERY_TMR_SIZE      (10 << 10)
 #define DISCOVERY_TMR_OFFSET    (64 << 10)
 
 void amdgpu_discovery_fini(struct amdgpu_device *adev);
-- 
2.25.1

