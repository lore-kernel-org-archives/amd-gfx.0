Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACC6C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E83962073B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83962073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE8856E9A3;
	Tue, 10 Dec 2019 21:37:00 +0000 (UTC)
X-Greylist: delayed 770 seconds by postgrey-1.36 at gabe;
 Tue, 10 Dec 2019 20:44:01 UTC
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 338906E176
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 20:44:01 +0000 (UTC)
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mw8gc-1hpI030rKO-00s44T; Tue, 10 Dec 2019 21:31:03 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Zhan Liu <zhan.liu@amd.com>
Subject: [PATCH] drm/amd/display: fix undefined struct member reference
Date: Tue, 10 Dec 2019 21:30:46 +0100
Message-Id: <20191210203101.2663341-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:6Y2/uQlFVUAl2FLpNaMIEOkGmiPd6/841XgCPxFoFzLNddBwEXH
 Gv0mA5U4F2XyfY5t7Irv9sGvE7omtf7B7anfrVJBcEa6nJh0oGgFa3a8TjQPfIv9chsmwPT
 jvm00bAGb9IDmiVsEt/HDimufrl4EuajG0pezWC+Cd9W5Z3cXKjNuVPnbUu6xNF5mo57oYn
 vjtK9SqzVDqza+VajFYtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vdsCwXbpzhg=:2/m5Z7ZQQBf3seyl4RgIjA
 kEgFyOHJByuNzd7+4YEk0taGPGNshYjpBoswGFxCc9SECIhb4FmUjgGEBjHTBoQEWAseRmZLa
 eSHGC8oaoaFgfHQ2vBTorrXoKwPKb634wEqE1U92NrLaNfSV+1bUDBf0xWyGgFzwL5gPEIh2Q
 B6n3RT+Zrg14GLvnjX3En0Ji7HP8nuQk4lXzwxHmTFWIxLXgNNq3Qju5xE1daM6ut6e4JATpk
 5wQMRYeQ6wf7z1F1V+IgL4LpCYqFshlxwKe6gpafF0JwzKVQxoxFY+FsQI8wXIH1qfK8BWDWU
 E7dfdOKXSTRFMwlwxxozxebF5bE25OfvCPdbvZBdv6enrzpOmaiGstXcqggQkyUSVR6I4fUGV
 45wyWTNqJHOxuO6wS10sJN+3IJ6zrvavEpex+apxGq6z4cyCY8gUOfXoVNW0ohOuwqa7QCD9/
 xGrA7PSqRusqpjeXtcgvrxxDlf0NoqJYT8iGCiCFd9F+QgNbxSOzTDwiF0H7RNrvqqu3poMKk
 nIi5jUJK8+Ri/7xN2uxMOTlVtpvugx87AroAKTbRcwhBDovlbntaT/VbTAaW4JKE83Yw5GXWg
 NYmvHJxC5K1WdV+Ov5NWz3OkVqwJHlfSgXVR5Fn7NIMmPWq2lv+UlfXrZpkua+RDqlQKss0xX
 ycmDGkhWGIoblsA7wwl8nnupnmNxKjPLkyI+RQejIXCQOAYIu8V+UzRWEHKTlW15vexfArmaI
 B9CuCd/zJ937l/rYfxkOzDvu9OWHk54wJgxcKEuTxxenU3PBW3Qrdl3TYeZDtaHWVo/8hj3qP
 +aPeMRhawu4ypdVHhvtZJGSw6UWK13MvQKu4guS3mf40Cc9glcCqtpdCxKNhhQ4oYW5Y75vxZ
 qe1+jdqi280uRh10rrow==
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
Cc: Charlene Liu <charlene.liu@amd.com>, Eric Yang <Eric.Yang2@amd.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Nikola Cornij <nikola.cornij@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 dri-devel@lists.freedesktop.org, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

An initialization was added for two optional struct members.  One of
these is always present in the dcn20_resource file, but the other one
depends on CONFIG_DRM_AMD_DC_DSC_SUPPORT and causes a build failure if
that is missing:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:926:14: error: excess elements in struct initializer [-Werror]
   .num_dsc = 5,

Add another #ifdef around the assignment.

Fixes: c3d03c5a196f ("drm/amd/display: Include num_vmid and num_dsc within NV14's resource caps")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index faab89d1e694..fdf93e6edf43 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -923,7 +923,9 @@ static const struct resource_caps res_cap_nv14 = {
 		.num_dwb = 1,
 		.num_ddc = 5,
 		.num_vmid = 16,
+#ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT
 		.num_dsc = 5,
+#endif
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
-- 
2.20.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
