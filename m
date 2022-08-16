Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1CAC2BB41
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Aug 2022 08:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D56BF101;
	Tue, 16 Aug 2022 08:50:38 +0000 (UTC)
X-Greylist: delayed 374 seconds by postgrey-1.36 at gabe;
 Tue, 16 Aug 2022 08:50:31 UTC
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4797932B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Aug 2022 08:50:31 +0000 (UTC)
Received: from kaveri ([85.2.99.24])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202208161044124613; Tue, 16 Aug 2022 10:44:12 +0200
Received: from daenzer by kaveri with local (Exim 4.96)
 (envelope-from <michel@daenzer.net>) id 1oNsBG-0001Zj-2m;
 Tue, 16 Aug 2022 10:44:10 +0200
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH] Revert "drm/amd/amdgpu: add pipe1 hardware support"
Date: Tue, 16 Aug 2022 10:44:10 +0200
Message-Id: <20220816084410.6048-1-michel@daenzer.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F22.62FB58DD.0064,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
 Spam="Unknown"; VOD="Unknown"
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 amd-gfx@lists.freedesktop.org, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michel Dänzer <mdaenzer@redhat.com>

This reverts commit 4c7631800e6bf0eced08dd7b4f793fcd972f597d.

Triggered GFX hangs with GNOME Wayland on Navi 21.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2117
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index fafbad3cf08d..a2a4dc1844c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4846,7 +4846,7 @@ static int gfx_v10_0_sw_init(void *handle)
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 2;
+		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
-- 
2.36.1

