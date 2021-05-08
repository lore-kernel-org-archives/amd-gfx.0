Return-Path: <SRS0=y248=KD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BFBC433B4
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0DC613F1
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0DC613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E6286E880;
	Sat,  8 May 2021 11:52:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3283F6E880
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 May 2021 11:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLrf0J0LDR8p/bMepViWke+HoWc3S02YpBlI09oFyK2RFVJGOn1G/vjrt27ITsgxPEgCqVTJJFfxLhJhrRmaW03aDI5SkXQxSy0nzQWyoSX502UBQuOw+yE0Y1sqeSUt6EDAHAGO6inqOpJSxKpE8RyPWU2bjUi5h/YrBsNXwPOPLn8Vvms5HHTOIb5bo1ET3I7jKBRHvt6NGhS/zJIacfG/NvRUbH/I+q1NC+l8FyVwkoB+cJR28Obzv4gQWNR2HkSYr+H7g6rPhXbMv7R29WlDfJTy64E9Kl1xSWtgsmvfnVS5O7gEk/Gqoh/MWhoaYMbNRJF/vVcP9NVzkShrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1WoJYW6pszxS5+7JhPzXa2gHzs8/v6y3xTwqjOkeDs=;
 b=Dggg9tS4iI9agOft5/angC5Cas4c8pOLvmvjm6mAlD0O/lmBiPd/QDDLDmlr/oViUr650hWeUVUsTB3+m/4MT6hb1VIxev4B6P3Z/JozIkFMH9r78JuyaL0zVN+8O2c6mhUXf9i9caYXpI27iJQQpfVLDfKHU+PwfccpZ5QY29VbDDg5HruQaPZhUj0DvmosGxa2p3STbIKtsYYkTBZdqheUroEJlaSid6yq65VwDpVjN1CZzRotEUr9Js8l3yQX66kQAsVVV0bUh862Qu3ZonqZkR47uUYf3PQoDr57pju9iHpBBfKBaXDmp9uCgsq/U5qUtfdyisTVrLImLzrslQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1WoJYW6pszxS5+7JhPzXa2gHzs8/v6y3xTwqjOkeDs=;
 b=Y6RhLfj78EJgB+3TzHvP2WApGCzWS2R6Y2xEhQ+xATnYD4o8m7WY2044PGkDglDf4AH7BhJSvl9YP0FaVnExB9ZzADKxeIaEvfCBkl8zFEi4UtDvuUT/BAE+nTdPHftehuGeBNv3uvy4DBjZbJM9ni/cJmZb/zlCWugzLy5kPtk=
Received: from BN6PR19CA0081.namprd19.prod.outlook.com (2603:10b6:404:133::19)
 by BN6PR12MB1121.namprd12.prod.outlook.com (2603:10b6:404:1c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Sat, 8 May
 2021 11:52:08 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::37) by BN6PR19CA0081.outlook.office365.com
 (2603:10b6:404:133::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Sat, 8 May 2021 11:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Sat, 8 May 2021 11:52:08 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 06:52:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 04:52:07 -0700
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Sat, 8 May 2021 06:52:06 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 13/13] drm/amdgpu: Update gfx_v9 rlcg interface
Date: Sat, 8 May 2021 19:51:45 +0800
Message-ID: <20210508115145.758-13-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210508115145.758-1-PengJu.Zhou@amd.com>
References: <20210508115145.758-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5422cf78-3290-405b-638c-08d91217b52e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1121:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1121E853914D23D6D48114D1F8569@BN6PR12MB1121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++CfWxlcBcYxpoU6An25VOqxOgZCq8Gh+tbOH3B10hYkszjOq3w6LQXwrYc/6/icleO37j6RSIvlBM7QPfoevwWNZLi8uU0xreA5gMQOD6e95vpsUC7hD2vPYkzMmMgo+kCrjpyfT5mV1hiCh5RNvOILlo/DzUJTJqA9jaoJGIAzwghyQywe1iKfzzZb2UQxKXgGqI66HAL4oYYM2Co6QctRPpPlUbJ0U6qSDqtM6644/4B/tw7lHNZyLsx0yq0bipl9WxABwEz3ZXHacXReEuqkvnVuCOcSte1+FXH7zPVChnuxRs+I1bGrCbffPZzoxNDZIzw6wz24gC/uRkiMmAZIlosi4pSg8OtzvvX9QV+DLhJ7HtiYNuTiAt5HfEynAWPebQr8owoOKPifXfvd0K23soxaAdf7MkP/ee45aIQF0EpvIx5/AU7zLKd4VRvnMH8rajJtgM63H6hJp75y81dlpVBo19L+ynGF0/t9kjcf3d2s6/r6UecHXfyhFHqZM5AXE8U604B9CADdEYKTX6xmNxhemdp2q2MJ2h3UnhEJEHmsey9Nu/hXvUOvJcKNF5mI7OtKhL6vIgxx7UTeczY/Vy5cL11r4o1q8sKMyMKy0+gHonOBYqHZLdeDyofvnwZjY5ZWkHxAxXXRiSKXaU3IKZbRp1vepdZQfdg8isCXsRZTFvNx4r2Vt1jWoXS6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39850400004)(36840700001)(46966006)(82310400003)(426003)(8676002)(478600001)(6666004)(186003)(47076005)(6916009)(36756003)(2616005)(70206006)(26005)(70586007)(15650500001)(4326008)(81166007)(316002)(83380400001)(336012)(86362001)(1076003)(2906002)(82740400003)(5660300002)(7696005)(36860700001)(8936002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2021 11:52:08.2460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5422cf78-3290-405b-638c-08d91217b52e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1121
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the interface on gfx v10 updated, the gfx v9 and v10
share the same interface, update v9's interface.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 9 +++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 357f9405f1aa..ce7f9d01083b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -490,7 +490,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 	    adev->gfx.rlc.funcs &&
 	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
 		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
-			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0);
+			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0, 0);
 	} else {
 		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2b065a9ba448..fc9040dbff40 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1453,7 +1453,7 @@ static bool gfx_v10_get_rlcg_flag(struct amdgpu_device *adev, u32 acc_flags, u32
 
 		break;
 	default:
-		DRM_INFO("Not program register by RLCG\n");
+		DRM_DEBUG("reg in IP 0x%x doesn't been programed by RLCG\n", hwip);
 	}
 
 	return false;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 16a3b279a9ef..59f3d8f922cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -734,7 +734,7 @@ static const u32 GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
 	mmRLC_SRM_INDEX_CNTL_DATA_7 - mmRLC_SRM_INDEX_CNTL_DATA_0,
 };
 
-static void gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
+static void gfx_v9_0_rlcg_w(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
 {
 	static void *scratch_reg0;
 	static void *scratch_reg1;
@@ -787,15 +787,16 @@ static void gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32
 
 }
 
-static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
+static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset,
+			       u32 v, u32 acc_flags, u32 hwip)
 {
 	if (amdgpu_sriov_fullaccess(adev)) {
-		gfx_v9_0_rlcg_rw(adev, offset, v, flag);
+		gfx_v9_0_rlcg_w(adev, offset, v, acc_flags);
 
 		return;
 	}
 
-	if (flag & AMDGPU_REGS_NO_KIQ)
+	if (acc_flags & AMDGPU_REGS_NO_KIQ)
 		WREG32_NO_KIQ(offset, v);
 	else
 		WREG32(offset, v);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
