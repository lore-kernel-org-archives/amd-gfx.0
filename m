Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE8EECAAD5
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 16:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C0F10E08B;
	Tue,  6 Sep 2022 16:46:43 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B5A10E08B
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 16:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8ziHEHsf4QITxWJvff8Ziud7VMsJUnhHWcQv9Bcyu74=; b=J0BQNWX27IazqDiZJHwIMrzDHs
 7ONKQnC5VHVqlBjEfDT+3KAG1HFV2Yn11oMOO8hsTHCVZ7j2WnBE0n1FgkHMn+R2mMsBrJAoLiH4f
 B2XXcEOFyOffn7CYBweV7WHjyFk/ShmwmUROaHK8L2tFYmy+esEW83JKT6fy22tnV2L3Ge8QaO4cy
 9H+kYD01HquavRmHS30ucgy1HjPyzkBsYud7t7kDhMUppNqqunuaBAPesFV4GImKyzAzuFaPvHhBr
 TIQjxtb/0mHW7zkSp2qJxsxVYaVscs27ex7+LcwWnEUMyqiDVEP0JWVD++mdxmEKlfGrrASdH1Dkx
 m4L5Wlrw==;
Received: from [38.44.74.92] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1oVbih-00CALM-6a; Tue, 06 Sep 2022 18:46:39 +0200
From: Melissa Wen <mwen@igalia.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 alex.hung@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 Rodrigo.Siqueira@amd.com
Subject: [RFC PATCH v2 0/9] Enable 3D LUT to AMD display drivers 
Date: Tue,  6 Sep 2022 15:46:19 -0100
Message-Id: <20220906164628.2361811-1-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: amd-gfx@lists.freedesktop.org, nikola.cornij@amd.com, kernel-dev@igalia.com,
 bhawanpreet.lakha@amd.com, nicholas.kazlauskas@amd.com, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

From all feedback at [3DLUT_RFC] and an extensive AMD driver
examination, here I am back with a first attempt to wire up a user 3D
LUT (post-blending) to DC interface via DM CRTC color mgmt :)

I'm following some specific approaches to handle user shaper LUT and
user 3D LUT that I would like to validate if the path taken is correct.

I used a modified version [igt_tests] of Ville's IGT 3D LUT test to
verify that the shaper and 3D LUT programming is happening. However, I
still have doubts about hw behavior and DC MPC's current implementation
for 3D LUT.

Despite some initial patches for code cleanup and DRM interface, my
focus here is the inclusion of a user 3D LUT in the Display Manager,
which is done in the last five patches of this series:

- drm/amd/display: enable DRM shaper and 3D LUT properties
- drm/amd/display: update lut3d and shaper lut to stream
- drm/amd/display: add user shaper LUT support to amdgpu_dm color pipeline
- drm/amd/display: add user 3D LUT support to the amdgpu_dm color pipeline
- drm/amd/display: encapsulate atomic regamma operation

Things to take into account:

- 3D LUT (and shaper LUT) is only available in the atomic pipeline (I
  didn't work on any implicit conversions that are done in the legacy
  path)

- Therefore, I'm not doing any implicit conversions for shaper LUT
  considering the input space, which means: it's set or not. When there
  is no shaper LUT, it's set to BYPASS, but unfortunately, it seems that
  the BYPASS mode for shaper LUT is not supported in the current DC
  dcn30_set_mpc_shaper_3dlut(), since it returns false when
  mpc3_program_shaper returns false (no params). Is the combination of a
  user 3D LUT with a bypassed shaper LUT accepted by the hw?

- I also see in dcn30_set_mpc_shaper_3dlut() that some bits need to be
  set in lut3d_func to have the 3D LUT programmed on the MPC block. In
  this sense, I used the dc_acquire_release_mpc_3dlut() function to get
  the lut3d_func from the resource pool, but I'm not sure if the timing to
  acquire and release the lut3d_func from the resource pool is correct
  (and if I can really use it directly or I should make a copy).

- Still, on this topic, I use for lut3d the same bit.out_tf to update
  the stream in the commit_tail because it triggers
  .set_output_transfer_func that is in charge of setting both OGAM and 3D
  LUT on MPC. There is a chance I got it wrong here, so I appreciate any
  input on this topic.

- Finally, in set_output_transfer_func, AFAIU, even if a user OGAM is
  set, it won't be programmed if the shaper LUT and 3D LUT programming
  are successful. However, if shaper/3DLUT programming fails, OGAM can be
  considered. Should DM only accept DRM regamma if no DRM 3D LUT is
  passed, or allowing the programming of both is still desirable?

Regarding the other patches:

- drm/drm_color_mgmt: add 3D LUT to color mgmt properties
- drm/drm_color_mgmt: add shaper LUT to color mgmt properties

Here, an initial DRM 3D LUT interface is exposed to enable the entire
kernel path and is only available for the atomic pipeline. So far, it
only includes the LUT data and its size, but improvements on this
interface may also add stride and bit depth [VA_API].
Additionally, I'm aware of the current work on exposing a color pipeline
API [KMS_pipe_API].

I'm including some minor changes in this series that I made to better
understand the current DM color mgmt behavior:

- drm/amd/display: add comments to describe DM crtc color mgmt behavior
- drm/amd/display: remove unused regamma condition

...but, there are other code cleanup patches that I'm not including in
this series to avoid unnecessary noise.

You can check the entire work here:
https://gitlab.freedesktop.org/mwen/linux-amd/-/commits/drm_lut3d

[igt_tests] IGT exploratory tests here:
https://gitlab.freedesktop.org/mwen/igt-gpu-tools/-/commits/kms_color_3dlut

[3DLUT_RFC] https://lore.kernel.org/amd-gfx/20220619223104.667413-1-mwen@igalia.com/
[VA_API] http://intel.github.io/libva/structVAProcFilterParameterBuffer3DLUT.html
[KMS_pipe_API] https://gitlab.freedesktop.org/pq/color-and-hdr/-/issues/11

Let me know your thoughts.

Thanks in advance,

Melissa

Melissa Wen (9):
  drm/amd/display: remove unused regamma condition
  drm/amd/display: add comments to describe DM crtc color mgmt behavior
  drm/drm_color_mgmt: add shaper LUT to color mgmt properties
  drm/drm_color_mgmt: add 3D LUT to color mgmt properties
  drm/amd/display: encapsulate atomic regamma operation
  drm/amd/display: add user 3D LUT support to the amdgpu_dm color
    pipeline
  drm/amd/display: add user shaper LUT support to amdgpu_dm color
    pipeline
  drm/amd/display: update lut3d and shaper lut to stream
  drm/amd/display: enable DRM shaper and 3D LUT properties

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 297 ++++++++++++++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   6 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  10 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  13 +
 drivers/gpu/drm/drm_atomic_state_helper.c     |   7 +
 drivers/gpu/drm/drm_atomic_uapi.c             |  20 ++
 drivers/gpu/drm/drm_color_mgmt.c              |  89 +++++-
 drivers/gpu/drm/drm_fb_helper.c               |   5 +
 drivers/gpu/drm/drm_mode_config.c             |  28 ++
 include/drm/drm_color_mgmt.h                  |   4 +
 include/drm/drm_crtc.h                        |  24 +-
 include/drm/drm_mode_config.h                 |  25 ++
 14 files changed, 495 insertions(+), 44 deletions(-)

-- 
2.35.1

