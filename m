Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4006CA0EC0
	for <amd-gfx@archiver.kernel.org>; Sun, 10 Aug 2025 14:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CD4110E26A;
	Sun, 10 Aug 2025 14:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=listout.xyz header.i=@listout.xyz header.b="1F16SOcH";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29F5810E2AE
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Aug 2025 09:36:50 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bzbQ65D7Kz9tDX;
 Sat,  9 Aug 2025 11:36:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
 t=1754732206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKLEcwImtnKbD3bvBMrqDUfNNLWPYRNY9MbQe4li21U=;
 b=1F16SOcHpl4/LfH/j3zeeDIX7kYnoMu8w8oDEK/wUJ/9LDq2JH76XmMiLtYg2To4gtfing
 1MfvTXMNepDW3YAPnNDAa30VQnoH4aVx8BXSkZVdnnAikW/atqdx0r88rm8yRZMIc+zoWu
 g19p4/nMSLbPTqcUAeP3DlZDxDv+ip0+PSXHhfJcRlo3a2vQ0paIf1+JiqAUYbZ5VByAxY
 c+kOnhMcXuUks6vypf4AMAtUH5tVVRXMdz9BU1ngtSk0NcoK5UGHyuC55tRYlXZ3MJu5Kb
 1whGfoGp//C9fpIjhtqwGqFW7v+5eFS2WyF4UQ6svCUdM5oT1X+nHwv0uugxyQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=listout@listout.xyz
Date: Sat, 9 Aug 2025 15:06:35 +0530
From: Brahmajit Das <listout@listout.xyz>
To: linux-next@vger.kernel.org, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
	airlied@redhat.com
Subject: Re: drm/radeon/r600_cs: Build failures with GCC 16
Message-ID: <smpcrwsua5kwutn5ynzz4eiupocvw5c7b4tmk3xugynvmnr53d@zxyraythnybm>
References: <pqpvdwxmqler2mg4ou665v56g6qe36vwi5jeavqeszj2mrk5m7@io6dy7jsvuhe>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pqpvdwxmqler2mg4ou665v56g6qe36vwi5jeavqeszj2mrk5m7@io6dy7jsvuhe>
X-Rspamd-Queue-Id: 4bzbQ65D7Kz9tDX
X-Mailman-Approved-At: Sun, 10 Aug 2025 14:43:41 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 09.08.2025 04:45, Brahmajit Das wrote:
> Hello Developers,
> 
> Building linux-next with GCC 16 results in this following build error
> 
> $ make
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   CC      drivers/gpu/drm/radeon/r600_cs.o
> drivers/gpu/drm/radeon/r600_cs.c: In function ‘r600_texture_size’:
> drivers/gpu/drm/radeon/r600_cs.c:1411:29: error: variable ‘level’ set but not used [-Werror=unused-but-set-variable=]
>  1411 |         unsigned offset, i, level;
>       |                             ^~~~~
> cc1: all warnings being treated as errors
> make[6]: *** [scripts/Makefile.build:287: drivers/gpu/drm/radeon/r600_cs.o] Error 1
> make[5]: *** [scripts/Makefile.build:556: drivers/gpu/drm/radeon] Error 2
> make[4]: *** [scripts/Makefile.build:556: drivers/gpu/drm] Error 2
> make[3]: *** [scripts/Makefile.build:556: drivers/gpu] Error 2
> make[2]: *** [scripts/Makefile.build:556: drivers] Error 2
> make[1]: *** [/home/listout/linux/Makefile:2011: .] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> I'm not sure whether this is kernel bug or GCC bug at the moment. But
> building with GCC 15 does not give this error, hence I'm more inclined
> towards the latter.
> Planning to also report this on GCC side, wanted to get some
> opinion/feedback from kernel devs as well.
> I'm on GCC 16.0.0_p2025080.
> 
> -- 
> Regards,
> listout

After giving a more thorough look, the level usage seems like dead code?
It's just set (level = blevel) and incremented in the loop (level++). I
don't see any other usage of the level variable. So if we do something
like

diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r600_cs.c
index ac77d1246b94..953ce0c57dfb 100644
--- a/drivers/gpu/drm/radeon/r600_cs.c
+++ b/drivers/gpu/drm/radeon/r600_cs.c
@@ -1408,7 +1408,7 @@ static void r600_texture_size(unsigned nfaces, unsigned blevel, unsigned llevel,
 			      unsigned block_align, unsigned height_align, unsigned base_align,
 			      unsigned *l0_size, unsigned *mipmap_size)
 {
-	unsigned offset, i, level;
+	unsigned offset, i;
 	unsigned width, height, depth, size;
 	unsigned blocksize;
 	unsigned nbx, nby;
@@ -1420,7 +1420,7 @@ static void r600_texture_size(unsigned nfaces, unsigned blevel, unsigned llevel,
 	w0 = r600_mip_minify(w0, 0);
 	h0 = r600_mip_minify(h0, 0);
 	d0 = r600_mip_minify(d0, 0);
-	for(i = 0, offset = 0, level = blevel; i < nlevels; i++, level++) {
+	for(i = 0, offset = 0; i < nlevels; i++) {
 		width = r600_mip_minify(w0, i);
 		nbx = r600_fmt_get_nblocksx(format, width);

I think it should be fine.

Would really appreciate some feedback.
(CC-ed Dave)

-- 
Regards,
listout
