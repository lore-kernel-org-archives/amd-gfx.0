Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A77BD49C84
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 09:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F06E310E94E;
	Fri, 30 Jan 2026 09:22:57 +0000 (UTC)
Received: from h5.fbrelay.privateemail.com (h5.fbrelay.privateemail.com
 [162.0.218.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 680FE10E1AA;
 Thu, 29 Jan 2026 14:05:09 +0000 (UTC)
Received: from MTA-05-3.privateemail.com (mta-05.privateemail.com
 [198.54.127.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by h5.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4f219v04nZz2y4L;
 Thu, 29 Jan 2026 14:05:07 +0000 (UTC)
Received: from hal-station (unknown [23.129.64.159])
 by mta-05.privateemail.com (Postfix) with ESMTPA id 4f21986cmPz3hhT6;
 Thu, 29 Jan 2026 09:04:28 -0500 (EST)
Date: Thu, 29 Jan 2026 09:04:23 -0500
From: Hamza Mahfooz <someguy@effective-light.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
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
 Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm: introduce page_flip_timeout()
Message-ID: <aXto53g2mSNsNmFM@hal-station>
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <2719069.vYhyI6sBWr@timur-hyperion>
 <30f2480d-016f-417e-9ddf-7805e4943e7b@amd.com>
 <2285353.hkbZ0PkbqX@timur-hyperion>
 <2f9bc706-02d6-4dec-a56c-53abc5d43f46@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f9bc706-02d6-4dec-a56c-53abc5d43f46@amd.com>
X-Rspamd-Queue-Id: 4f219v04nZz2y4L
X-Mailman-Approved-At: Fri, 30 Jan 2026 09:22:26 +0000
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

On Thu, Jan 29, 2026 at 01:59:00PM +0100, Christian König wrote:
> > How do you propose to do that?
> 
> I need to dig a bit into the DAL/DC code and see how the signaling path actually goes.
> 
> Going to give that a try tomorrow.
> 

For recent ASICs, something along the lines of the following should do
the trick:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index dc8d2f52c7d6..fac668c2fcfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -510,6 +510,7 @@ struct amdgpu_crtc {
 	bool wb_pending;
 	bool wb_enabled;
 	struct drm_writeback_connector *wb_conn;
+	int pflip_cnt;
 };
 
 struct amdgpu_encoder_atom_dig {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 740711ac1037..1c3b7fbab1c6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -427,6 +427,18 @@ static inline bool update_planes_and_stream_adapter(struct dc *dc,
 					   stream_update);
 }
 
+static inline bool update_pflip_cnt(struct amdgpu_crtc *acrtc)
+{
+	int cnt = acrtc->pflip_cnt++;
+
+	if (cnt == 300) {
+		acrtc->pflip_cnt = 0;
+		return true;
+	}
+
+	return false;
+}
+
 /**
  * dm_pflip_high_irq() - Handle pageflip interrupt
  * @interrupt_params: ignored
@@ -454,6 +466,9 @@ static void dm_pflip_high_irq(void *interrupt_params)
 		return;
 	}
 
+	if (update_pflip_cnt(amdgpu_crtc))
+		return;
+
 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 
 	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
@@ -589,6 +604,9 @@ static void dm_vupdate_high_irq(void *interrupt_params)
 	acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VUPDATE);
 
 	if (acrtc) {
+		if (update_pflip_cnt(acrtc))
+			return;
+
 		vrr_active = amdgpu_dm_crtc_vrr_active_irq(acrtc);
 		drm_dev = acrtc->base.dev;
 		vblank = drm_crtc_vblank_crtc(&acrtc->base);
@@ -659,6 +677,9 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	if (!acrtc)
 		return;
 
+	if (update_pflip_cnt(acrtc))
+		return;
+
 	if (acrtc->wb_conn) {
 		spin_lock_irqsave(&acrtc->wb_conn->job_lock, flags);
