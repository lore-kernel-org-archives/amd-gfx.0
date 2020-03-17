Return-Path: <SRS0=ZDaT=5C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74A7C2BB1D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 13:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F7520757
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 13:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="JPgYX9TL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F7520757
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E53F66E154;
	Tue, 17 Mar 2020 13:50:09 +0000 (UTC)
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch
 [185.70.40.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB991898C4;
 Tue, 17 Mar 2020 07:51:34 +0000 (UTC)
Date: Tue, 17 Mar 2020 07:51:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=default; t=1584431492;
 bh=EMEzGbH6WJQeMEfxN2A/GbEd2U+BF9wqqyChVAQMkhE=;
 h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
 b=JPgYX9TLqIoTOB7e7l2l6ATtohqNCUVI1trv340NRMugeAsRquBaoHRfaauHFCwQV
 yILKLrmsiEBt73+YXTJqXtLKqEdqPjMZMbrHDcYm4e/xuhXcLa4Q49zi1beD/IWdWS
 fPJO/0OqEwrTFjNVh1JElFyygc1T8K+NKuX/06JA=
To: "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "David1.Zhou@amd.com" <David1.Zhou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@linux.ie" <airlied@linux.ie>, "daniel@ffwll.ch" <daniel@ffwll.ch>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH] Remove stable HAINAN board from max_sclk override check in
 radeon and amdgpu modules
Message-ID: <SXhX80OoFKMCVNQM9khl9rN_3bsGdi2f6kiyvATRPj9w6_VqgIMqDqd5pPYK3OMFlHFaW1ln8wYqg2DXk4yyZIHJHeaCoaYj8EMmR52vf1U=@protonmail.com>
Feedback-ID: v3gTakqywBIYXeKntrQ6yy6583pNqH_nSJEjbgzjmBjMaZTDq3nLe0D-jSYppQY2NgolnS_R3Ad-LHjkRMDnTQ==:Ext:ProtonMail
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 17 Mar 2020 13:50:08 +0000
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
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/gpu/drm/amd/amdgpu/si_dpm.c | 1 -
 drivers/gpu/drm/radeon/si_dpm.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
index 4cb4c891120b..0860e85a2d35 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -3439,7 +3439,6 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,

 	if (adev->asic_type == CHIP_HAINAN) {
 		if ((adev->pdev->revision == 0x81) ||
-		    (adev->pdev->revision == 0x83) ||
 		    (adev->pdev->revision == 0xC3) ||
 		    (adev->pdev->device == 0x6664) ||
 		    (adev->pdev->device == 0x6665) ||
diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 05e8b4d0af3f..2cb85dbe728f 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -2979,7 +2979,6 @@ static void si_apply_state_adjust_rules(struct radeon_device *rdev,

 	if (rdev->family == CHIP_HAINAN) {
 		if ((rdev->pdev->revision == 0x81) ||
-		    (rdev->pdev->revision == 0x83) ||
 		    (rdev->pdev->revision == 0xC3) ||
 		    (rdev->pdev->device == 0x6664) ||
 		    (rdev->pdev->device == 0x6665) ||
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
