Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F45CC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 07:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5BCD10E6C7;
	Mon, 25 Apr 2022 07:33:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 998E610E1EB;
 Sat, 23 Apr 2022 01:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=x2bd6S4bmTTvHUq69Na2qRGHtShuyYBXZEOPRIIgd8E=; b=hn+LOYPKMgtXSUvCJARi8nm8Ap
 /jovlbudM4XvOs3vv2peO9+0ewMjqvx6sl43o7E0XBcPv9RJ7ApMXWSOeiSRKigkC90RZm6u9/2or
 ZNG2sQRK1CvHX2o3qwAFJwIPt/qErClQsyp+Ai0DMMAQFdEac/3sba3iNf2Zxh8cvtalNw2bgLftg
 9sOr7cgX66O5MsJW27sMKFTKKkOjklM9RiSBiqJTpASv4xUdcDQlhZmOM9oHNjQVoFwW8MhVcUHlQ
 Qdo+uVQhVB3aylrTd42+F5G0eK9aqZvCi52jo79x9mmOtIW/N1ZAeHEb7g4LVaqt/J/yTdirK9C2N
 b4oBG80Q==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ni4an-00377U-9S; Sat, 23 Apr 2022 01:29:45 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix non-kernel-doc comment warnings
Date: Fri, 22 Apr 2022 18:29:43 -0700
Message-Id: <20220423012943.12133-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 Apr 2022 07:33:10 +0000
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
Cc: Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>,
 David Airlie <airlied@linux.ie>, Harry Wentland <harry.wentland@amd.com>,
 Robin Chen <po-tchen@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix kernel-doc warnings for a comment that should not use
kernel-doc notation:

dmub_psr.c:235: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Set PSR power optimization flags.
dmub_psr.c:235: warning: missing initial short description on line:
 * Set PSR power optimization flags.

Fixes: e5dfcd272722 ("drm/amd/display: dc_link_set_psr_allow_active refactoring")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Robin Chen <po-tchen@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -231,7 +231,7 @@ static void dmub_psr_set_level(struct dm
 	dc_dmub_srv_wait_idle(dc->dmub_srv);
 }
 
-/**
+/*
  * Set PSR power optimization flags.
  */
 static void dmub_psr_set_power_opt(struct dmub_psr *dmub, unsigned int power_opt, uint8_t panel_inst)
