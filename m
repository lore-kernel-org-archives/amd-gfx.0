Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885CCCA0EC1
	for <amd-gfx@archiver.kernel.org>; Sun, 10 Aug 2025 14:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDE9010E26D;
	Sun, 10 Aug 2025 14:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=listout.xyz header.i=@listout.xyz header.b="aXlq+E4G";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF50D10E09B
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 23:15:44 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bzKdT4m8Mz9tCJ;
 Sat,  9 Aug 2025 01:15:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
 t=1754694941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=e6Jw1zDVtjTA2grbtCPb82zxpM0vKtOPY3V4HAN/9GA=;
 b=aXlq+E4GuZQDVxVshkb1a47xbWzfnSNnuOWmTkYUuLeH7BHPYDEy3wL7jZoq7bBcpn2leT
 bVZiaM9r7tHWVgafy+917E08EuPBpnCUbgLt4bIic51TzfALx0lJ1Uwrn5PDoU366TVBiR
 P7wmQ3gMh6hY81C2ygLV/3nt3z4socOLGj2LzIhsMdcVlDBgMzW36qYTzroKhgktMe7stG
 mj6UJv8cymD6dqld4WgclI5XxK6BOsrHkFgN3hGP07D7i4KIQUB+Hpw74pLcVJmyJrDD4+
 Tv31nK5bx2crWqaEhlIoFGaq7H+whaSSYCjWJr7864a00i+sMwy8TXR+jsJ+5g==
Date: Sat, 9 Aug 2025 04:45:38 +0530
From: Brahmajit Das <listout@listout.xyz>
To: linux-next@vger.kernel.org, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Subject: drm/radeon/r600_cs: Build failures with GCC 16
Message-ID: <pqpvdwxmqler2mg4ou665v56g6qe36vwi5jeavqeszj2mrk5m7@io6dy7jsvuhe>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Hello Developers,

Building linux-next with GCC 16 results in this following build error

$ make
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  CC      drivers/gpu/drm/radeon/r600_cs.o
drivers/gpu/drm/radeon/r600_cs.c: In function ‘r600_texture_size’:
drivers/gpu/drm/radeon/r600_cs.c:1411:29: error: variable ‘level’ set but not used [-Werror=unused-but-set-variable=]
 1411 |         unsigned offset, i, level;
      |                             ^~~~~
cc1: all warnings being treated as errors
make[6]: *** [scripts/Makefile.build:287: drivers/gpu/drm/radeon/r600_cs.o] Error 1
make[5]: *** [scripts/Makefile.build:556: drivers/gpu/drm/radeon] Error 2
make[4]: *** [scripts/Makefile.build:556: drivers/gpu/drm] Error 2
make[3]: *** [scripts/Makefile.build:556: drivers/gpu] Error 2
make[2]: *** [scripts/Makefile.build:556: drivers] Error 2
make[1]: *** [/home/listout/linux/Makefile:2011: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

I'm not sure whether this is kernel bug or GCC bug at the moment. But
building with GCC 15 does not give this error, hence I'm more inclined
towards the latter.
Planning to also report this on GCC side, wanted to get some
opinion/feedback from kernel devs as well.
I'm on GCC 16.0.0_p2025080.

-- 
Regards,
listout
