Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17133C88E75
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 08:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FD2610E3E0;
	Mon, 26 Jan 2026 08:09:30 +0000 (UTC)
Received: from MTA-06-4.privateemail.com (mta-06-4.privateemail.com
 [198.54.122.146])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD7010E275;
 Sat, 24 Jan 2026 18:32:45 +0000 (UTC)
Received: from hal-station.localdomain
 (bras-base-toroon4332w-grc-44-142-112-152-160.dsl.bell.ca [142.112.152.160])
 by mta-06.privateemail.com (Postfix) with ESMTPA id 4dz3LR0R8Yz3hhTL;
 Sat, 24 Jan 2026 13:32:14 -0500 (EST)
Date: Sat, 24 Jan 2026 13:32:09 -0500
From: Hamza Mahfooz <someguy@effective-light.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 dri-devel@lists.freedesktop.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sunil Khatri <sunil.khatri@amd.com>, Ce Sun <cesun102@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Melissa Wen <mwen@igalia.com>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <mdaenzer@redhat.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm: introduce page_flip_timeout()
Message-ID: <aXUQKSJGkz7nzHJ4@hal-station.localdomain>
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <2de6d428-b997-4ba8-8766-a211e5612e72@amd.com>
 <2349754.vFx2qVVIhK@timur-hyperion>
 <a8b972be-7265-492f-9855-cdec94a0e0dc@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8b972be-7265-492f-9855-cdec94a0e0dc@amd.com>
X-Mailman-Approved-At: Mon, 26 Jan 2026 08:09:08 +0000
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

On Fri, Jan 23, 2026 at 04:30:12PM -0600, Mario Limonciello wrote:
> Hamza - since you seem to have a "workload" that can run overnight and this
> series recovers, can you try what Alex said and do a dc_suspend() and
> dc_resume() for failure?
> 
> Make sure you log a message so you can know it worked.

Sure, I'll try something along the lines of:

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 492457c86393..bc7abd00f5f4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -579,11 +579,28 @@ amdgpu_dm_atomic_crtc_get_property(struct drm_crtc *crtc,
 }
 #endif

-static void amdgpu_dm_crtc_handle_timeout(struct drm_crtc *crtc)
+static void amdgpu_dm_crtc_handle_timeout(struct drm_crtc *crtc,
+					  struct drm_crtc_commit *commit)
 {
 	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
 	struct amdgpu_reset_context reset_ctx;
+	struct amdgpu_ip_block *ip_block;

+	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE);
+	if (!ip_block)
+		goto full_reset;
+
+	ip_block->version->funcs->suspend(ip_block);
+	ip_block->version->funcs->resume(ip_block);
+
+	if (drm_crtc_commit_wait(commit)) {
+		drm_err(crtc->dev, "suspend-resume failed!\n");
+		goto full_reset;
+	}
+
+	return;
+
+full_reset:
 	if (amdgpu_device_should_recover_gpu(adev)) {
 		memset(&reset_ctx, 0, sizeof(reset_ctx));

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 7175294ccb57..b38c4ee2fc95 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1961,7 +1961,7 @@ void drm_atomic_helper_wait_for_flip_done(struct drm_device *dev,
 				crtc->base.id, crtc->name);

 			if (crtc->funcs->page_flip_timeout)
-				crtc->funcs->page_flip_timeout(crtc);
+				crtc->funcs->page_flip_timeout(crtc, commit);
 		}
 	}

diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 45dc5a76e915..47a34a05f6de 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -616,7 +616,8 @@ struct drm_crtc_funcs {
 	 * and can be used by drivers to attempt to recover from a page flip
 	 * timeout.
 	 */
-	void (*page_flip_timeout)(struct drm_crtc *crtc);
+	void (*page_flip_timeout)(struct drm_crtc *crtc,
+				  struct drm_crtc_commit *commit);

 	/**
 	 * @set_property:
