Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC624C77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 18:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FC7610E429;
	Tue, 25 Apr 2023 18:52:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4677410E104
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 18:52:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmT1aGuGQ6+cn+mIRC2YLPtSxHQg3+JpGR/jl053SJuuxR6AxsFp6CbYFpi8IcVWcCSFqgahtSpxAgPIP4+rrFT6wTCcsjKpQlVQwM/US/tOt17uc9K6Gvai53gBtwFq22GRA8m2//rWdnWQsF0xFDdOzTY4Dk6kleeLo5sIrkShldQuAUTiYDIZJHxQk+sHApROD3pyfH1JuAYAlQIYT5nmUOOqk5C9MuI4mM9UVL1w4Jhb60LfJA12vkV/5O9GvW4V2eJ5XK9vWAChTJNLjMUPtUcMPZjWcjgcmoNgUjVbQgnrXBo+C74dG8MDaeajM+ZpQoeTn61vhG9iQtP3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rntZg3BvepshAEvT7nmCsAw5Ml/LtdwlWBqR3iB4Lvg=;
 b=PSJrZB8HpytLP5tWREFiuouCQcr09yz8qTb25YHra0CFIwzjfPA/YEWLRtgmnSbqM7FER6ulpPh/ayTYXlzAUkE2n85loRorckGmdU47l1oNAPpuQRYA9sFMkHESNbmE3GQuVWnKls66bibZcl81sJ01BN/oNfHlQ9MM1866Mqe61VlAtq/dq2qWIhBZXucXpiSFk9G25G6x9YCs7qs3QOvk7qGGXT6ZPnTSLVmfZmpmQkeGFXMOJHpiNmS5ZkHaKrWHrTvePYd//Su8o4EIl/xTu0stzBZNHwZ0pzd7xJVa3hG/frHKMYG933KwvuNMK3RxDXxefeI0Dfhrjve9Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rntZg3BvepshAEvT7nmCsAw5Ml/LtdwlWBqR3iB4Lvg=;
 b=LIYrQUUpo+Tqv4/wB64RK5LBZy0uYr22kGSQ6s9daJuCzglMzYBpJVCsgKdmirHCVo5bJ5oxX13zMHLiE9jxsXqGLLTsUTFxk3/ur9UlReQmmV0U/byS1OCK/sLgRiIb7uHL2oIpdp0DxUL2WdTZLWnQ1+umnRNpnGw1GxqEY18=
Received: from BN0PR10CA0008.namprd10.prod.outlook.com (2603:10b6:408:143::27)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 18:52:13 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::57) by BN0PR10CA0008.outlook.office365.com
 (2603:10b6:408:143::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Tue, 25 Apr 2023 18:52:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.21 via Frontend Transport; Tue, 25 Apr 2023 18:52:13 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 25 Apr
 2023 13:52:11 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix style errors in amdgpu_display`.c
Date: Wed, 26 Apr 2023 00:21:57 +0530
Message-ID: <20230425185157.1736681-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|DS0PR12MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c15421-0371-44a3-2ec4-08db45be2ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G6LTydt5d1XZZpzCX4QLziu/HoinF4DXx/AIlQxRKP/o/8QYcEFh+usv9T7hZ/W0fvyzUfobBg4OoyCXkzZcbjLbvvLc6r6ePcxJgKFle8jhAE7HlgrqLkJG62a1EleB0j4CTKDnUYyLdy5buZJD6FJxWCxve1WI+kgRC2iU2J6cTYT8Z2ZOZT1kpYNCL9UyzMw06NY3pz/rb7qGxPWX+5wVEg42l2pcNat2eaMpQFr1ayKOGoWQmz8lq/z3Zy9TUlm2eV3u/ej5oiliHhEWbq0sr3WteADeXB5GMpm7Hv6wsHJRxlQLfq1bh5YxaLWh8XTBxvU80jTY1b4lRYm4Hnz5Qx+aKGw6WQ+xNNoLGMffbOARHlYEEp14jIEfF+TUEuJshlkgk6gJ0J7WBa43KYGNzasIUje2M2wQw0vFF07OHwM5UBx2D9+nOL23nT8lAtVpVWVslQQsoDnvLrV/Z0gnwuNdYBNO1tD6EjMwVfh6T8Ms3Izm+E332eHcf1EpHExdcEnShHiGavhxSIWEfCb/mYu2hFh+kLNJdLlwJny0s5Vv7jNQzggxitD+9JZhw95LWvue5IywfnoRPTL36Hk6ey4iqaY2/lG9UqBT96VQ81IiHHp0SwuTMESt4KUvfxNFibFW0u5Ndq6llOhMjY24il6bWPlgqGfcf+j+5Le/UHqeRNP0A2QtZgKvpnTWc/Bok8apr0hFo+Xam9WL+ji6GjsUvyIEcGXdt74gvUFVOf37bO6yp8jdevk9LDGdIuKTKi9WflytnEKOuzJGUO2cZsMCD+pYQH7vA7utrCQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(36756003)(8676002)(8936002)(54906003)(110136005)(40460700003)(478600001)(70586007)(6636002)(4326008)(70206006)(40480700001)(356005)(81166007)(44832011)(316002)(41300700001)(82740400003)(2906002)(5660300002)(2616005)(86362001)(36860700001)(186003)(16526019)(336012)(426003)(26005)(1076003)(7696005)(6666004)(83380400001)(47076005)(66574015)(82310400005)(21314003)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 18:52:13.2972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c15421-0371-44a3-2ec4-08db45be2ebf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7747
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix following checkpatch errors in amdgpu_display.c

ERROR: spaces required around that '=' (ctx:VxW)
ERROR: that open brace { should be on the previous line
ERROR: else should follow close brace '}'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 8632ab695a6c..389396eac222 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -97,7 +97,7 @@ static void amdgpu_display_flip_callback(struct dma_fence *f,
 static bool amdgpu_display_flip_handle_fence(struct amdgpu_flip_work *work,
 					     struct dma_fence **f)
 {
-	struct dma_fence *fence= *f;
+	struct dma_fence *fence = *f;
 
 	if (fence == NULL)
 		return false;
@@ -1251,21 +1251,21 @@ const struct drm_mode_config_funcs amdgpu_mode_funcs = {
 	.fb_create = amdgpu_display_user_framebuffer_create,
 };
 
-static const struct drm_prop_enum_list amdgpu_underscan_enum_list[] =
-{	{ UNDERSCAN_OFF, "off" },
+static const struct drm_prop_enum_list amdgpu_underscan_enum_list[] = {
+	{ UNDERSCAN_OFF, "off" },
 	{ UNDERSCAN_ON, "on" },
 	{ UNDERSCAN_AUTO, "auto" },
 };
 
-static const struct drm_prop_enum_list amdgpu_audio_enum_list[] =
-{	{ AMDGPU_AUDIO_DISABLE, "off" },
+static const struct drm_prop_enum_list amdgpu_audio_enum_list[] = {
+	{ AMDGPU_AUDIO_DISABLE, "off" },
 	{ AMDGPU_AUDIO_ENABLE, "on" },
 	{ AMDGPU_AUDIO_AUTO, "auto" },
 };
 
 /* XXX support different dither options? spatial, temporal, both, etc. */
-static const struct drm_prop_enum_list amdgpu_dither_enum_list[] =
-{	{ AMDGPU_FMT_DITHER_DISABLE, "off" },
+static const struct drm_prop_enum_list amdgpu_dither_enum_list[] = {
+	{ AMDGPU_FMT_DITHER_DISABLE, "off" },
 	{ AMDGPU_FMT_DITHER_ENABLE, "on" },
 };
 
@@ -1495,8 +1495,7 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 		ret |= DRM_SCANOUTPOS_ACCURATE;
 		vbl_start = vbl & 0x1fff;
 		vbl_end = (vbl >> 16) & 0x1fff;
-	}
-	else {
+	} else {
 		/* No: Fake something reasonable which gives at least ok results. */
 		vbl_start = mode->crtc_vdisplay;
 		vbl_end = 0;
-- 
2.25.1

