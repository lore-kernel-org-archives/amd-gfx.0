Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FDAC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Oct 2022 15:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F90010E6B9;
	Wed,  5 Oct 2022 15:47:15 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 318FA10E6B9
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Oct 2022 15:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qwwpbi2vHPrqfVkhtTVNiNTa5SPw9oSORSFNofPH6pa5y6xzNcQ9ZvBYX+P2dJ8SPXLl+JSs+V6qdE/LivG+GPXVG9wWtofy1JjDlA8erjicpmW39y7lbYMtvQXsv5N/S69vozbv2PfGnH27UmIX5nNrNB+95HqcWU9EJ9csMOaKu0sbLhG/n6S+iWcw/MLNo7hia+V02IPx+5fkHfv/hfpCiV/hSnuJOkrk4/ixijJhenlvFCvGledkoIiRtzEZMg2VmREWYzXL27o8HPOq5Y+zeHZp//7uBVx32xli88A0cu4jCLEtNx4YeRxzGDntC5rJNXayRlgHjVjv+Bt0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nh0IZy4EuRbteJ+N10iPXVxER21PTUAKRL38RFVndk0=;
 b=J2qfmXswrL9V/YgEAd4ziKGjyc46hqjHwcEpCTB951CB3fyDPRdwndqRQ7RDM4hA+EOby18BptHQsqHuEwTK/ApT8cyB2ePGijFXTWzhuPrsHKdI9XyJDOZjBA1A62ja1MBT2t0apxeYLvkc7xgMH1tkcfm/Ah3P9VuKDEjNTAQmp0X4lreOn+N4uNH/5kbINe6qfFJ54qWs9ih3lX70io9XGve6rSQn/Ss3p0zOmiwaUsoFLeESab6pu1ld/0uAaheQoAlCcFCs56F4eVzowW1jOEdADcDC7GIjMRkZIzM6zlgvbquwehFK3fNbML4WhusindRh4eu1NQJ6smEB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nh0IZy4EuRbteJ+N10iPXVxER21PTUAKRL38RFVndk0=;
 b=UTPoS5/q4MBhr17hoW1W6XLMZWVwZTqBLSWwevX0ZdHqp5fWaJH+qH7jd0tcqoG5yUorct6LBiNHPZ/ix8nc9TB6tuDyoYzLiUzTot6UXGqQ4lXMCXSXxlVNbThGw14lv2LtFhDXjmq6zsxk/LRzT1DPMO7i9Xlkwnlr8/gGdQc=
Received: from MW4PR03CA0198.namprd03.prod.outlook.com (2603:10b6:303:b8::23)
 by BY5PR12MB4869.namprd12.prod.outlook.com (2603:10b6:a03:1d9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Wed, 5 Oct
 2022 15:47:10 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::85) by MW4PR03CA0198.outlook.office365.com
 (2603:10b6:303:b8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28 via Frontend
 Transport; Wed, 5 Oct 2022 15:47:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 15:47:09 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 5 Oct
 2022 10:47:08 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amdgpu: use dirty framebuffer helper"
Date: Wed, 5 Oct 2022 11:47:19 -0400
Message-ID: <20221005154719.57566-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|BY5PR12MB4869:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a6d3e4-3e0f-4eca-a8f9-08daa6e8dd3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ptErXn03mAROnX4QhoSfpYhFQE/NobTyfuQnjQYFBoVAs+e2n6sLH3FafTbO64YQLW9YV/5MOpM/JU9X2dnb57pM428avri6yk6cV4pYF335Qcjd0G4UjEmw6uC0sfqm+CZOXoLYdGkBidPC543eKy2O1qfwZKJaknxal9S6Sc+7lH+KkNUko0Ae8grrTnq1J2FI3bFRWy+alSHZxvln50oku5LKDfqqoD7vPdoqpQUCv56JDH3EjPcX2w2k2PD6K3Q9NyMnz4gi3fb7qdSrs/k1qzP5ODHznFPXiH3lRgi9LWhaMyM9lN531N42tTqhbJxiS1UGiq3vH3dswKDE0nxpE8LFvczilc0oG52Xtrio2Wwhv628uxDSuNDgCNaOV3k17w57b7NFi4ON28+Ql8MhAuTxerS+iDMUn7EuNWRYyCo0yXTyg6khA7vChprYmpjih7yd91ox52u2QmKOy271gywlOB1STYhF5rtfgpQeqiCzgG6jAhRFEmRZ3cSw3Z/s8UcUMb/zTVKWuX+6WVSu9nb9l1s6d6dGR0QQO9KWUTUFm78hHdiB+DPyp6jFAf5t7Z6kLL5Zlpp661ztIoZXxaMhwRwmzUBwob284UC19122o6ClWi9aboc2DHc6mZSkPoCrUefwsC+36Txs6vTZTTC/M0SpR8CqNTzJawVaeAw9y3Fx8QmlpgZScmIw1mZrn8j5U+sSWX+nsX72PogzoNaikF4TtmWerhFwPfeTn4+He/WCHNiU/WnP23Dw8/Mu4JvUl3yxNQqxcCdHTgF70k//rHM+9Ud9AulkN82P0EaeL3kJkTPKWq8KsTki
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(4326008)(82740400003)(356005)(81166007)(54906003)(2906002)(316002)(6916009)(8676002)(70206006)(40480700001)(26005)(86362001)(70586007)(16526019)(8936002)(47076005)(44832011)(2616005)(1076003)(7696005)(186003)(5660300002)(336012)(6666004)(83380400001)(36860700001)(478600001)(966005)(40460700003)(426003)(41300700001)(82310400005)(36756003)(14143004)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 15:47:09.8835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a6d3e4-3e0f-4eca-a8f9-08daa6e8dd3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4869
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 10b6e91bd1ee9cd237ffbc244ad9c25b5fd3e167.

Unfortunately, this commit causes performance regressions on non-PSR
setups. So, just revert it until FB_DAMAGE_CLIPS support can be added.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2189
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 23998f727c7f..1a06b8d724f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -38,8 +38,6 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <drm/drm_crtc_helper.h>
-#include <drm/drm_damage_helper.h>
-#include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fb_helper.h>
@@ -500,12 +498,6 @@ static const struct drm_framebuffer_funcs amdgpu_fb_funcs = {
 	.create_handle = drm_gem_fb_create_handle,
 };
 
-static const struct drm_framebuffer_funcs amdgpu_fb_funcs_atomic = {
-	.destroy = drm_gem_fb_destroy,
-	.create_handle = drm_gem_fb_create_handle,
-	.dirty = drm_atomic_helper_dirtyfb,
-};
-
 uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 					  uint64_t bo_flags)
 {
@@ -1108,10 +1100,8 @@ static int amdgpu_display_gem_fb_verify_and_init(struct drm_device *dev,
 	if (ret)
 		goto err;
 
-	if (drm_drv_uses_atomic_modeset(dev))
-		ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs_atomic);
-	else
-		ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
+	ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
+
 	if (ret)
 		goto err;
 
-- 
2.37.3

