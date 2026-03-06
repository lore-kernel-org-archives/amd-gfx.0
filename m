Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1581F0182F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 12:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76BC810ED17;
	Fri,  6 Mar 2026 12:16:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pp3345.net header.i=@pp3345.net header.b="5CoYmw8d";
	dkim-atps=neutral
X-Greylist: delayed 573 seconds by postgrey-1.36 at gabe;
 Fri, 06 Mar 2026 12:16:28 UTC
Received: from mail-244103.protonmail.ch (mail-244103.protonmail.ch
 [109.224.244.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26F3110ED17
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 12:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pp3345.net;
 s=protonmail; t=1772798801; x=1773058001;
 bh=sY10cI0Yc6VSJ62O1HxjimWLrNVHzBFl2lxlcN0A/oc=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=5CoYmw8ds9dPiUtIAk/UieusrsxDrveHP77HtMRlFv1grySIu8DNPF+JTDG3I4pFG
 hSApb57XTYyj1nDsd4rENp3Um4djNGL8KI0WClN9LwPjoyLu//wsu3iHJBhJYH7Q50
 PnUVdD4+DVMFbOoqgJsP9ZLpJkId0xf7EcfN1V+e5QGXDOncrLhLJSN3P5nDFcEpMc
 Cz4teqBQ15rmEd291zk/AVrjUW485ReQvWvtNpuZw2Zjryl/clRRVe5DG6h8TyDIoF
 6MB6Y7PbBOFZ/cq3lzbLAxpoq513UwiIhr7hDdUXPZ8kZ+k4sWbt0UGg1kP5gbdgsn
 anvVMJP/YtpSw==
Date: Fri, 06 Mar 2026 12:06:35 +0000
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org
From: Yussuf Khalil <dev@pp3345.net>
Cc: Yussuf Khalil <dev@pp3345.net>
Subject: [PATCH] drm/amd/display: Do not skip unrelated mode changes in DSC
 validation
Message-ID: <20260306120513.57826-1-dev@pp3345.net>
Feedback-ID: 115742593:user:proton
X-Pm-Message-ID: 841f2f9da501eb7c17e8583ed57a72410761f27c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Starting with commit 17ce8a6907f7 ("drm/amd/display: Add dsc pre-validation=
 in
atomic check"), amdgpu resets the CRTC state mode_changed flag to false whe=
n
recomputing the DSC configuration results in no timing change for a particu=
lar
stream.

However, this is incorrect in scenarios where a change in MST/DSC configura=
tion
happens in the same KMS commit as another (unrelated) mode change. For exam=
ple,
the integrated panel of a laptop may be configured differently (e.g., HDR
enabled/disabled) depending on whether external screens are attached. In th=
is
case, plugging in external DP-MST screens may result in the mode_changed fl=
ag
being dropped incorrectly for the integrated panel if its DSC configuration
did not change during precomputation in pre_validate_dsc().

At this point, however, dm_update_crtc_state() has already created new stre=
ams
for CRTCs with DSC-independent mode changes. In turn,
amdgpu_dm_commit_streams() will never release the old stream, resulting in =
a
memory leak. amdgpu_dm_atomic_commit_tail() will never acquire a reference =
to
the new stream either, which manifests as a use-after-free when the stream =
gets
disabled later on:

BUG: KASAN: use-after-free in dc_stream_release+0x25/0x90 [amdgpu]
Write of size 4 at addr ffff88813d836524 by task kworker/9:9/29977

Workqueue: events drm_mode_rmfb_work_fn
Call Trace:
 <TASK>
 dump_stack_lvl+0x6e/0xa0
 print_address_description.constprop.0+0x88/0x320
 ? dc_stream_release+0x25/0x90 [amdgpu]
 print_report+0xfc/0x1ff
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __virt_addr_valid+0x225/0x4e0
 ? dc_stream_release+0x25/0x90 [amdgpu]
 kasan_report+0xe1/0x180
 ? dc_stream_release+0x25/0x90 [amdgpu]
 kasan_check_range+0x125/0x200
 dc_stream_release+0x25/0x90 [amdgpu]
 dc_state_destruct+0x14d/0x5c0 [amdgpu]
 dc_state_release.part.0+0x4e/0x130 [amdgpu]
 dm_atomic_destroy_state+0x3f/0x70 [amdgpu]
 drm_atomic_state_default_clear+0x8ee/0xf30
 ? drm_mode_object_put.part.0+0xb1/0x130
 __drm_atomic_state_free+0x15c/0x2d0
 atomic_remove_fb+0x67e/0x980

Since there is no reliable way of figuring out whether a CRTC has unrelated
mode changes pending at the time of DSC validation, remember the value of t=
he
mode_changed flag from before the point where a CRTC was marked as potentia=
lly
affected by a change in DSC configuration. Reset the mode_changed flag to t=
his
earlier value instead in pre_validate_dsc().

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5004
Fixes: 17ce8a6907f7 ("drm/amd/display: Add dsc pre-validation in atomic che=
ck")
Signed-off-by: Yussuf Khalil <dev@pp3345.net>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           | 5 +++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h           | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 4 +++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b3d6f2cd8..4efd77477 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12523,6 +12523,11 @@ static int amdgpu_dm_atomic_check(struct drm_devic=
e *dev,
 =09}
=20
 =09if (dc_resource_is_dsc_encoding_supported(dc)) {
+=09=09for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_=
state, i) {
+=09=09=09dm_new_crtc_state =3D to_dm_crtc_state(new_crtc_state);
+=09=09=09dm_new_crtc_state->mode_changed_independent_from_dsc =3D new_crtc=
_state->mode_changed;
+=09=09}
+
 =09=09for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_=
state, i) {
 =09=09=09if (drm_atomic_crtc_needs_modeset(new_crtc_state)) {
 =09=09=09=09ret =3D add_affected_mst_dsc_crtcs(state, crtc);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 800813671..d15812d51 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -984,6 +984,7 @@ struct dm_crtc_state {
=20
 =09bool freesync_vrr_info_changed;
=20
+=09bool mode_changed_independent_from_dsc;
 =09bool dsc_force_changed;
 =09bool vrr_supported;
 =09struct mod_freesync_config freesync_config;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 7be50e8c0..5d8c4c702 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1744,9 +1744,11 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 =09=09=09int ind =3D find_crtc_index_in_state_by_stream(state, stream);
=20
 =09=09=09if (ind >=3D 0) {
+=09=09=09=09struct dm_crtc_state *dm_new_crtc_state =3D to_dm_crtc_state(s=
tate->crtcs[ind].new_state);
+
 =09=09=09=09DRM_INFO_ONCE("%s:%d MST_DSC no mode changed for stream 0x%p\n=
",
 =09=09=09=09=09=09__func__, __LINE__, stream);
-=09=09=09=09state->crtcs[ind].new_state->mode_changed =3D 0;
+=09=09=09=09dm_new_crtc_state->base.mode_changed =3D dm_new_crtc_state->mo=
de_changed_independent_from_dsc;
 =09=09=09}
 =09=09}
 =09}
--=20
2.53.0


