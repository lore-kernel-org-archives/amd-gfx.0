Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A9AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 17:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B8710E22B;
	Tue, 15 Mar 2022 17:09:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F90610E149
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 17:09:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R45oquo64qE7iMWPWRV39t47KhFp3RIMA5b8AHoWF2Q0SmyzK0cknYqqsTqeo7oiw2qtDHDiVPXksqQj+e9XhUhgFmh6UAyqe3f97VS659nYs4PIMlst9YWd+/Ue6oemjz+tU49s3yyyZZNgjdbLoKcoGesYo+hXqvOdJn8leUgIWu8YW/xZTcCIOxyeFJWwDRbT1fKVyP2cDNjgIvW3p8C+GFCbFL2xjO+WjKhgSSiti+qDyHXs0tOcgVC6oSgm3oGv3Ng5EhHlDCb+EAADWDu37zFv0ytUElJi5m9WJrsChMFTMDMP8SgiqM/WSdlRfEmIRHtpchg6dJJW3bSKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmyoWkikeDm08h2uU6tNZ0IklrZ8q/NCtcF9euSaNrU=;
 b=EVyS5VaeIIGW2aMTM36H6uWMKMs6mI3feFuVKJBKIFlvRvmjHKapto1ISxq3BBrdr/HIbeG30b+s5PyHDGwMzkN0I+HP+namTabtTb9In/cbsilG78gGkT/GaS2OMEuGMpyVmPbk93SMqeiJHOT3I61FrRPlmbahaLXTqT2/FhbpYzCSc7hlWtmOqSMCdSJUExlMh4mPYrqCTYY42SBfa2gIIQHf7FKHNQ+815FTviuqhp4tR1ExpSHBz5yWyPqiK5WKDsE/KIczbYXRyrMVPSsO/xTj0N/IlelboXJfYLVrh8dzMLc10Y3X1HJN7YUY5TaEeVyJKExMn+lA/1wN1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmyoWkikeDm08h2uU6tNZ0IklrZ8q/NCtcF9euSaNrU=;
 b=4pPYXedZkFHNdcB6l7FAJfJUFHCgv0uC7oCzn1kWR07ik/vyO1FeZ0htMl3kuer/arNCco5+VgdMq98veUTLWdSYLOrPwmEPW/IFzwI8Ad9UBRIobh6BRv+nLkF8xUiYRxRPsM+VQ+sLsODlQOTDcZ7tqFJkyYF6TDxyXOgne7Y=
Received: from BN9PR03CA0391.namprd03.prod.outlook.com (2603:10b6:408:111::6)
 by BN6PR12MB1217.namprd12.prod.outlook.com (2603:10b6:404:20::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Tue, 15 Mar
 2022 17:09:28 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::2e) by BN9PR03CA0391.outlook.office365.com
 (2603:10b6:408:111::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28 via Frontend
 Transport; Tue, 15 Mar 2022 17:09:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 17:09:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 15 Mar
 2022 12:09:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: drop amdgpu_display_gem_fb_init()
Date: Tue, 15 Mar 2022 13:09:13 -0400
Message-ID: <20220315170914.2804385-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315170914.2804385-1-alexander.deucher@amd.com>
References: <20220315170914.2804385-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f82ae2ab-dcb8-4432-7f2d-08da06a6904c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1217:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1217BBA0300E62F0249CF313F7109@BN6PR12MB1217.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rigE+o682scT+mLsHGT7OyGsD2k4cg6n6fhAMpbGvPaIh1TPRx178HooebHE5OutQOIY9uVk9eW6CH/JTL/EcBcTfj7yD7IwKOO5I+sHO8XIFTXgS2pXWyL0L2fILTGh4TCNS3LsgLzkcAid7D/FWgHFde++7Ce57RhWDl5EnTTkhMg3/rmFL3X0RvzQBpsc8RNCACw2jzrkEXlv/yZssaC2p75/15/IYbRXRph7CN5kMeVLi0pGbjGCt4G9vO/sZQKxobTYDlHN9QmXwk2J36H+mWTRWQkyNrgZ64y8J06/K9W9CiTwwNvSXl8g1pVRh19rq1hOAm2LKP15IrYD6EN/1NrsLy+XWj2wRRMZxeSMMzllyNsXpFq/DZ2Epdgn07eYwfU5B0XWq+KXnyDeUPbCOvmAcFMSawMYnYGZGBaqIDyyIs6X65gw9QX3fMl3r04PZaLwPA7PvJlk/HGwaNPsCOAwMdIVGIUcEgMknLpnV/QtlR69X3Rh0hIxqp4pLM+5cO00cKGo2tiu2Dg276GfN4n3t7ftcpgB9q4lnBc3JWt/lnlG//6vySYLlJDejN1mzqgxtyZkPQUFP9oOeKPVOLEvOqK7Rt4xEKWyQeN4GcZ3xjePh+J4SxHAPqI/dLxeMZKPxz4c+fNXbi5lP7b70/PqwYMho9AOXUlieU29ApayZn06+4dMgMdr7/hXNiTjBM7/jDLAIMZkJ2T3qA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(82310400004)(81166007)(2616005)(356005)(7696005)(8936002)(5660300002)(6666004)(47076005)(86362001)(36860700001)(336012)(426003)(1076003)(186003)(26005)(16526019)(40460700003)(83380400001)(6916009)(316002)(70586007)(70206006)(36756003)(8676002)(4326008)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 17:09:28.0835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f82ae2ab-dcb8-4432-7f2d-08da06a6904c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1217
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

Unused.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 25 ---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    |  4 ----
 2 files changed, 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index cb78ba396672..6af7a5e9b28d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1042,31 +1042,6 @@ static int amdgpu_display_get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb
 	return r;
 }
 
-int amdgpu_display_gem_fb_init(struct drm_device *dev,
-			       struct amdgpu_framebuffer *rfb,
-			       const struct drm_mode_fb_cmd2 *mode_cmd,
-			       struct drm_gem_object *obj)
-{
-	int ret;
-
-	rfb->base.obj[0] = obj;
-	drm_helper_mode_fill_fb_struct(dev, &rfb->base, mode_cmd);
-
-	ret = amdgpu_display_framebuffer_init(dev, rfb, mode_cmd, obj);
-	if (ret)
-		goto err;
-
-	ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
-	if (ret)
-		goto err;
-
-	return 0;
-err:
-	drm_dbg_kms(dev, "Failed to init gem fb: %d\n", ret);
-	rfb->base.obj[0] = NULL;
-	return ret;
-}
-
 int amdgpu_display_gem_fb_verify_and_init(
 	struct drm_device *dev, struct amdgpu_framebuffer *rfb,
 	struct drm_file *file_priv, const struct drm_mode_fb_cmd2 *mode_cmd,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 69ce2eeb782e..2d2f01eb2521 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -592,10 +592,6 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 			int *hpos, ktime_t *stime, ktime_t *etime,
 			const struct drm_display_mode *mode);
 
-int amdgpu_display_gem_fb_init(struct drm_device *dev,
-			       struct amdgpu_framebuffer *rfb,
-			       const struct drm_mode_fb_cmd2 *mode_cmd,
-			       struct drm_gem_object *obj);
 int amdgpu_display_gem_fb_verify_and_init(
 	struct drm_device *dev, struct amdgpu_framebuffer *rfb,
 	struct drm_file *file_priv, const struct drm_mode_fb_cmd2 *mode_cmd,
-- 
2.35.1

