Return-Path: <SRS0=TD2D=DN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0B0C47095
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2020 07:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA96820789
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2020 07:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m1TmLnvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA96820789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6859A6E3EF;
	Tue,  6 Oct 2020 07:35:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A9406E0E4;
 Tue,  6 Oct 2020 04:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Date:Message-ID:Subject:Cc:From:To:Sender:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=Dt6GxUiiNucMJVb8insT90iPuGdOD6EG4FZ0RccNAMI=; b=m1TmLnvP1zb+gBR5X8PaSFHKAQ
 LgPis6cwWOZTnfJm2d22Cz6eTicstsnc9GrWWPi8Nap0uFabAaCeqneFSMqS7LDWNzUC4nUqAkJbl
 wnKF4vP5M+cJpKYAqlSrMxeCZBkeYXeaJAG1UpNXfsr+Mn7eSY8GM2lV93MrsoiDmfZpC+Kk5aDs/
 v3TdzyPj7KsTU0d7yyaUeF+sS8IaG3OkTBTagEe3wpAH1A+ZIHNBOZYZDZE9uDHSyoKQWClXh24FG
 FcJciAgxOSqEuHahBeSS2JyqHAFegQpGCwPUOq7OloHiP8IOxkWj5zN/8LfZjHAlGiWkthTmhYKls
 iEYLfUNA==;
Received: from [2601:1c0:6280:3f0::2c9a]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPevb-0008JQ-K8; Tue, 06 Oct 2020 04:50:19 +0000
To: LKML <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [RFC PATCH] DRM: amd: powerplay: don't undef pr_warn() {causes ARC
 build errors}
Message-ID: <9c86375d-34a9-6584-0069-452b193076d6@infradead.org>
Date: Mon, 5 Oct 2020 21:50:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Language: en-US
X-Mailman-Approved-At: Tue, 06 Oct 2020 07:35:21 +0000
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
Cc: Evan Quan <evan.quan@amd.com>, kernel test robot <lkp@intel.com>,
 Vineet Gupta <vgupta@synopsys.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Randy Dunlap <rdunlap@infradead.org>

arch/arc/ implements BUG_ON() with BUG(). ARC has its own BUG()
function and that function uses pr_warn() as part of its implementation.

Several (8) files in amd/powerplay/ #undef various pr_xyz() functions so
that they won't be used by these drivers, since dev_() functions are
preferred here and the #undefs make the pr_() functions unavailable.

Hence the following build errors are reported in ARC builds:

../drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c: In function 'navi10_fill_i2c_req':
../arch/arc/include/asm/bug.h:24:2: error: implicit declaration of function 'pr_warn'; did you mean 'drm_warn'? [-Werror=implicit-function-declaration]

../drivers/gpu/drm/amd/amdgpu/../powerplay/sienna_cichlid_ppt.c: In function 'sienna_cichlid_fill_i2c_req':
../arch/arc/include/asm/bug.h:24:2: error: implicit declaration of function 'pr_warn'; did you mean 'drm_warn'? [-Werror=implicit-function-declaration]

Fixes: 55084d7f4022 ("drm/amd/powerplay: forbid to use pr_err/warn/info/debug")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Evan Quan <evan.quan@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
---
Another alternative is for amd/powerplay/ drivers not to use BUG()
or BUG_ON().
A third alternative is to ask the ARC developers to implement BUG()
without using any pr_() functions.

 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         |    2 +-
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- lnx-59-rc7.orig/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ lnx-59-rc7/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -52,7 +52,7 @@
  * They are more MGPU friendly.
  */
 #undef pr_err
-#undef pr_warn
+//#undef pr_warn
 #undef pr_info
 #undef pr_debug
 
--- lnx-59-rc7.orig/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ lnx-59-rc7/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -54,7 +54,7 @@
  * They are more MGPU friendly.
  */
 #undef pr_err
-#undef pr_warn
+//#undef pr_warn
 #undef pr_info
 #undef pr_debug
 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
