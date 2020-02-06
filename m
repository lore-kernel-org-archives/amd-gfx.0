Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468FDC35247
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 19:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D4B21741
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 19:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=octaforge.org header.i=@octaforge.org header.b="OnQYKhxT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="32WVdG0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D4B21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=octaforge.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF622892AE;
	Thu,  6 Feb 2020 19:21:10 +0000 (UTC)
X-Greylist: delayed 334 seconds by postgrey-1.36 at gabe;
 Thu, 06 Feb 2020 19:21:09 UTC
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16CD8892AE
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 19:21:09 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 4760121731;
 Thu,  6 Feb 2020 14:15:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Thu, 06 Feb 2020 14:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=octaforge.org;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm2; bh=2cSolfTFS0MNdZLoUmIL51OUVO
 KO7P4LZCjQvIMJaTA=; b=OnQYKhxTxouTD77+oJP4EfnPiMBEmHJcfMoUQtbmdp
 gGv7QmvfBxeOL83HtJfwda3R0Bg6Cq4maceCYI7grI3Aao+J449WwVA0AhC6ykzC
 GMXNfJosklqXCWK9aosmL73rS0TqycFqIuhBqwf2sSASMKURdFc9Ju5dxajGIF0o
 MKVSMrCKIUFcs1MOOIA1i2tIFg5rZnatWWQXobzAcNKu9NDopeIueo1J9JrRpOTz
 A7eYED1R847UyTxvNxty/osWrjDWtuoxblszYO2dJS9eocuWRFrTaqATza8t/Q7b
 ZdpCXF/JFTvJ56WVxtc7WoL+I2PtZxhlSHKuJ3VzgIvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=2cSolfTFS0MNdZLoU
 mIL51OUVOKO7P4LZCjQvIMJaTA=; b=32WVdG0Mbk4w3/ob5x/3wMn0MjRcbyZbx
 PNHuFu1UtqGZIB+ipp14Dm2Bs1q0JlA1tNoHsxFlVnfNPMxHJRtd7lAFEWj7yA+3
 2sIi/zV2A+IiQS+PHfqJuFrGbhpzFX8enHEd8gjHtsC2tavsra5m8genMweArnmV
 Nagg4VP9stK5Oyy1uipwNvGtj4kWj/UYasbj5Bc8+5S2D7XhKs2h4LbBS/SCEJwh
 GIu9SUvwqq5ioQCbDGMtFqdnzdIYAE9Omq3EruAOqRRVxBS+leMBvEiY8+tiOxXO
 gn7Jl1qRFr1pewuiAeVzSLf/DK7k/K9DprF++gWGQMvsA+ln2X2gw==
X-ME-Sender: <xms:1GU8XpzRG7AExdsnfOJjlXAwakrh99WKnoE1HInd7v0oHs85Ze6AxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrheefgdduvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomhepffgrnhhivghlucfmohhlvghsrgcuoegurghnihgvlhesohgtthgr
 fhhorhhgvgdrohhrgheqnecukfhppeelgedrudduvddruddvkedrudekleenucevlhhush
 htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegurghnihgvlhesohgt
 thgrfhhorhhgvgdrohhrgh
X-ME-Proxy: <xmx:1GU8XmrnjtgxwtCY3aEHXzYrN16WdT5vQWy6C2jK5vpgAdQGjIcxQg>
 <xmx:1GU8Xoh-d-YHEjOus1e0cwTGwVfKmh76sxs92-YyzPCuu7csbWa4rw>
 <xmx:1GU8Xo4qxGTUDPgUzsJqlkANmLrjhKYAfiWFxI9b6c92Hh4oiTZ_-w>
 <xmx:1GU8Xr0nFlopiue3Akp0I3e6obPjl0nR2v7rksiycNNU1VhDL-N27A>
Received: from localhost.localdomain (ip-94-112-128-189.net.upcbroadband.cz
 [94.112.128.189])
 by mail.messagingengine.com (Postfix) with ESMTPA id 81F15328005A;
 Thu,  6 Feb 2020 14:15:31 -0500 (EST)
From: Daniel Kolesa <daniel@octaforge.org>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amdgpu: Prevent build errors regarding soft/hard-float FP ABI
 tags
Date: Thu,  6 Feb 2020 20:14:35 +0100
Message-Id: <20200206191435.12715-1-daniel@octaforge.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
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
Cc: Daniel Kolesa <daniel@octaforge.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On PowerPC, the compiler will tag object files with whether they
use hard or soft float FP ABI and whether they use 64 or 128-bit
long double ABI. On systems with 64-bit long double ABI, a tag
will get emitted whenever a double is used, as on those systems
a long double is the same as a double. This will prevent linkage
as other files are being compiled with hard-float.

On ppc64, this code will never actually get used for the time
being, as the only currently existing hardware using it are the
Renoir APUs. Therefore, until this is testable and can be fixed
properly, at least make sure the build will not fail.

Signed-off-by: Daniel Kolesa <daniel@octaforge.org>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index b864869..6fa7422 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -91,6 +91,12 @@ ifdef CONFIG_DRM_AMD_DC_DCN2_1
 ###############################################################################
 CLK_MGR_DCN21 = rn_clk_mgr.o rn_clk_mgr_vbios_smu.o
 
+# prevent build errors regarding soft-float vs hard-float FP ABI tags
+# this code is currently unused on ppc64, as it applies to Renoir APUs only
+ifdef CONFIG_PPC64
+CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn21/rn_clk_mgr.o := $(call cc-option,-mno-gnu-attribute)
+endif
+
 AMD_DAL_CLK_MGR_DCN21 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn21/,$(CLK_MGR_DCN21))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN21)
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
