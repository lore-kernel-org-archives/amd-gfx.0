Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2232EC25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 22:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D37D810E8CB;
	Thu, 26 Oct 2023 22:43:09 +0000 (UTC)
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch
 [185.70.41.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D070110E8C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 22:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1698357962; x=1698617162;
 bh=ZHWR8RGw1Tu8dfLgsZT+os8IyR/7RgOkm8EHVSn2H3E=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=LPl7I0rGXwDsPVfFOKgBEVXrKPjnYAf6Qb7PUySw2UKvmC+XAoP1xQtVtVuFq9y/3
 82W3y2t2BG7mwvtWeC4YkMhIQwhPzMiJk6cABjGGLNF3nWLoPaqCjidVAo2p6K1GAk
 SpDtX2jubWgfyknWMtdVxeU0QBTajzGZisBEmq6YOwAT9tc5D5pz6t8mqoBZL6deN0
 sbEMmzLUNq6DDbq3tnFGIG+6Vc23N2NR5X05RhJLLr8jAAWbzwzZor81ahODCCw8ZQ
 KxRS0P7SGg0hCSpUiqX/K9L6sqk4R/yZ8ZemJNpAsXK5avhK7xNT3XfFjjSRZqh3dD
 wBnh4TbxVcQUQ==
Date: Thu, 26 Oct 2023 22:05:49 +0000
To: neil.armstrong@linaro.org
From: Umio Yasuno <coelacanth_dream@protonmail.com>
Subject: [PATCH 1/2] drm/amdgpu: Remove duplicate fdinfo fields
Message-ID: <20231026220525.23682-1-coelacanth_dream@protonmail.com>
Feedback-ID: 19510729:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 26 Oct 2023 22:43:05 +0000
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
Cc: robdclark@chromium.org, shashank.sharma@amd.com,
 amd-gfx@lists.freedesktop.org, robdclark@gmail.com, alexander.deucher@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rob Clark <robdclark@chromium.org>

Some of the fields that are handled by drm_show_fdinfo() crept back in
when rebasing the patch.  Remove them again.

Fixes: 376c25f8ca47 ("drm/amdgpu: Switch to fdinfo helper")
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: <alexander.deucher@amd.com>
Co-developed-by: Umio Yasuno <coelacanth_dream@protonmail.com>
Signed-off-by: Umio Yasuno <coelacanth_dream@protonmail.com>
---

This thread has been inactive for nearly 5 months, so I re-created the patc=
h.

 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_fdinfo.c
index 6038b5021..e9b5d1903 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -87,9 +87,6 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm=
_file *file)
 =09 */
=20
 =09drm_printf(p, "pasid:\t%u\n", fpriv->vm.pasid);
-=09drm_printf(p, "drm-driver:\t%s\n", file->minor->dev->driver->name);
-=09drm_printf(p, "drm-pdev:\t%04x:%02x:%02x.%d\n", domain, bus, dev, fn);
-=09drm_printf(p, "drm-client-id:\t%llu\n", vm->immediate.fence_context);
 =09drm_printf(p, "drm-memory-vram:\t%llu KiB\n", stats.vram/1024UL);
 =09drm_printf(p, "drm-memory-gtt: \t%llu KiB\n", stats.gtt/1024UL);
 =09drm_printf(p, "drm-memory-cpu: \t%llu KiB\n", stats.cpu/1024UL);
--=20
2.42.0


