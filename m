Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A177C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB1F02073B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1F02073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A82AF6E99C;
	Tue, 10 Dec 2019 21:36:55 +0000 (UTC)
X-Greylist: delayed 308 seconds by postgrey-1.36 at gabe;
 Tue, 10 Dec 2019 20:04:56 UTC
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AFF76E923
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 20:04:56 +0000 (UTC)
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MjSPq-1htqK43Row-00l1Jv; Tue, 10 Dec 2019 20:59:42 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/amd/display: include linux/slab.h where needed
Date: Tue, 10 Dec 2019 20:59:24 +0100
Message-Id: <20191210195941.931745-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:OrcnEQHu5wIVElyPLtj9cM/U8i3tJsEHQqMgWD9iAttxajBL+4Y
 PRozQipVEPM78uWvddh6kjFJP0m9W7Xl2iyfwMr6le8zEOqtUcR3YqBbcY0m8NmbwLj4gij
 nH91rockYuPliucDJPwxBaK0+/s8ZLF4ilxO0+TiyEzKKY8itGLkPD8DVvHiCm1DACaRXts
 wksFhEsGXgNsaguRsbwew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BOgTBsXjGhc=:em08V6fo6mQDzI2P/1XnQl
 NYACd6z+rtbrlPACO4rOnJIL93HmbBqc2ef4o8GimHBrcMbiCpmj3swjYzLrkB6uwEsRi/Amg
 yY5paBK6p7ttdviX9bWGmMZz9Q9TRLozNtJdJ22cLbL87keprpN79I388GwOOoZIGYeRBsDIc
 yyhKF61U7zsNfhu6ZmXNSIftM0YLsCEEgwJly6rX7K5Olf2MfKxJ+1UjKC647cqmU1+4kNz+f
 qNhwON3bmrcBdbRttsHpmCZMwlOO7E/9QGfqAh3dcTwVKsuJIBiEE0cQNzgR1u4HZfVDEtxYO
 OeXs8U/qdKlPW2y9Xl1+huNT4X6n8LnMT3fwvdknhA7WNAbcJ9JD2ANShwFOd4kj4bMqZpcpV
 8BA2xjWDPascHT7GiHQUBLEXTS4ZTBtx00NfwVEZMheRAJ2yjne5sNQVsEHySvFqOoO4QKqg8
 a4ddA9y7sYO6QPjpPiNZpQv3azlTZkc0ZPiFXUoN4uI2JNCj1zNJEvS2kWcmx6tiM6cRlmh5H
 fUMEou0drdbfgIbXqPuQNELCfB6lkFmwHBmQ8mXtPcdkcceLWiLc4jaS1USUaO7pTCnZjFQIL
 c2/4SU0KeKbubWEm7/JsDZj0D5DBthsRveDBXF5i5Rv8KJOIVe5EENgE6VD2j+6xGPT1kiAHv
 tF9XXziHZSHoKlHf5ulJNm0unSodFb0oXsG4HKyaF9/YU6rJl6OCvYOEajGVYPj+CaatdCpaW
 m8tUTCl0HLS5R/2p30PKDFTEhll/muN1O1IEBIXlm8Q4IUpCbKRQxsc0U5/ZC6/XqyXJ0J2OJ
 MPUNQ4R/uDavnS9DApb8qjTQ6HaFnc/Z3nFJQmBpxVWZT89HUSsY3LU5Vx1i1xPX/p8PvN2Qd
 oJyiy1KE19BpAS8W0qKg==
X-Mailman-Approved-At: Tue, 10 Dec 2019 21:36:55 +0000
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
Cc: Eric Yang <Eric.Yang2@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Roman Li <Roman.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Michael Strauss <michael.strauss@amd.com>,
 dri-devel@lists.freedesktop.org, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Calling kzalloc() and related functions requires the
linux/slab.h header to be included:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c: In function 'dcn21_ipp_create':
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:679:3: error: implicit declaration of function 'kzalloc'; did you mean 'd_alloc'? [-Werror=implicit-function-declaration]
   kzalloc(sizeof(struct dcn10_ipp), GFP_KERNEL);

A lot of other headers also miss a direct include in this file,
but this is the only one that causes a problem for now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 906c84e6b49b..af57885bbff2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -23,6 +23,8 @@
  *
  */
 
+#include <linux/slab.h>
+
 #include "dm_services.h"
 #include "dc.h"
 
-- 
2.20.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
