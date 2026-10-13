Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08917CC6B08
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 13:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E7B10E797;
	Tue, 13 Oct 2026 13:02:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56F8210F7B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 12:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791892862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MTh6w3t1LI7cFHlFOA6EXonuQhJfRF96d/zfPpAsgQU=;
 b=a/95T1FPuX85mJFWFDgcjLHrZPEtoGnGRXl9+nA0z9mt+Qd2svR7V6zv0leBQZR3y5L7fW
 iaeTSuQMCJ9ztb2w5eaUYq3zqWrrjjJswURNW7859oIMsO6YpOPB92oRhP9K55tOnoHrEv
 Wq/GprrbDYEn7fG5g4HxB6K9UGua/8o=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-AUxjRfmUPBy_fLbd8LiIBg-1; Tue, 13 Oct 2026 12:01:01 +0000
X-MC-Unique: AUxjRfmUPBy_fLbd8LiIBg-1
X-Mimecast-MFC-AGG-ID: AUxjRfmUPBy_fLbd8LiIBg_1791892860
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-6768c955661so3102900d50.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 05:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892860; x=1792497660;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MTh6w3t1LI7cFHlFOA6EXonuQhJfRF96d/zfPpAsgQU=;
 b=X8S+egHG51tXFCqzTGqTtfTtXgMbi3QgFqbQKWHjnWyW0XZt4W7G4PlEr6yE2Fw0FZ
 jWSQinvIdQ6SBbwmgGpb/ZxFR/gUi1M+eFKGg9zLG6G6o14fW32mfV320CRtAsreB4UB
 HIpJ+p9dTANfQE51d0BUugSbT0lGrzZgoVeMpkFVXn12aBNpUX50FnrfU8kboZf8zLgz
 My7Eum29TN2iClp30ZZlS4trkWLyS9smAZV565TLQ2jiPI+66BPXxtwsczjosU7RXRZ4
 PiVPzE5rD7QqBA2HorqH7NbwJKkLY2N9PHL/cYiJJJydgZw3HdN3sJ7ge5vIGBAkZ/Sb
 uuqg==
X-Gm-Message-State: AFq9FYLYUnUsxH72B2Kzs/dH1qL5pmgowf7GQ//PczSupcU4E0clV0ms
 C0vzlM7qhFYdEAJcoQZrAcsLqro+pQ16gLYWExgAdQcU17gFnBE/KhtZMXct/w9LGLyyKAuMfFU
 fE47ihWWSUBiV/wS0AxrVRHmRbcqwutlZ1c8T0DkU+uTfRphRf3MfggD5NPsUbmC66WcoQn/WNq
 /QFw555DJ9Wi5Gf6i0WXFtwxzojxaD/lFYSFh3fnKQfA==
X-Gm-Gg: AYBFou2/BZ1qCtjeRgKVfQ29L5imWux9/Uib6C25oh/Nj2ZT8HihdZMif9dkkafmYV0
 3jjP54/tZfIC3uEE6PmJ29WUbweqvW/5M/dvvj8Ac8sDzGg2TwCS8+bU44WopaVe+GhF1pY5uEk
 C2tmDNMcC9SzABjG8nxTZRMkBWkdgFpiu8MSRywxE0dykDxJ7JPGqToQ==
X-Received: by 2002:a05:690e:13cb:b0:677:d4b0:47fd with SMTP id
 956f58d0204a3-67936270e69mr5009413d50.23.1791892855767; 
 Tue, 13 Oct 2026 05:00:55 -0700 (PDT)
X-Received: by 2002:a05:690e:13cb:b0:677:d4b0:47fd with SMTP id
 956f58d0204a3-67936270e69mr5009396d50.23.1791892855071; Tue, 13 Oct 2026
 05:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20261013-visibility-unification-v2-0-3ce8d458bddf@redhat.com>
In-Reply-To: <20261013-visibility-unification-v2-0-3ce8d458bddf@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 13 Oct 2026 14:00:44 +0200
X-Gm-Features: AclHuK_UoITZRIQAG7eVGfp71MDQ0WSmjY7r-ItFN0NvYj_P9B_KTR-tMkVwVj0
Message-ID: <CADSE00JuXFx3vBiUty1A69K8ONuL2DMjCREGmDsW4MxobemVtA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/amd/display: use kunit/visibility.h for test
 helpers
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UW-yip4xWdQ19cQyOkCYZ3_aUjVZWkyxNMcX2imqp2o_1791892860
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 13 Oct 2026 13:02:05 +0000
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

On Tue, Oct 13, 2026 at 1:58=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> amdgpu_dm grew its own STATIC_IFN_KUNIT / EXPORT_IF_KUNIT /
> INLINE_IFN_KUNIT macros instead of using kunit/visibility.h. This
> series switches the KUnit helpers over to the common API.
>
> VISIBLE_IF_KUNIT is gated on CONFIG_KUNIT rather than
> CONFIG_DRM_AMD_DC_KUNIT_TEST, so the helpers are non-static whenever
> KUnit is enabled. EXPORT_SYMBOL_IF_KUNIT places the symbols in the
> EXPORTED_FOR_KUNIT_TESTING namespace; the AMD DC test files import
> that namespace with MODULE_IMPORT_NS().
>
> INLINE_IFN_KUNIT is dropped rather than generalized. It was only used
> on amdgpu_dm_fixpt_from_s3132(), inverted the original static inline,
> and is unnecessary for tests in another translation unit.
>
> Previous version failed with specific configuration combination
> (KUNIT=3Dy, DRM_AMD_DC_KUNIT_TEST=3Dn). Fixed by changing header
> declaration guards from CONFIG_DRM_AMD_DC_KUNIT_TEST to
> CONFIG_KUNIT to match VISIBLE_IF_KUNIT.
>
> Tested with:
>     # Full test run (KUNIT=3Dy, DRM_AMD_DC_KUNIT_TEST=3Dy):
>     ./tools/testing/kunit/kunit.py run --arch=3Dx86_64 \
>       --kunitconfig=3Ddrivers/gpu/drm/amd/display/amdgpu_dm/tests \
>       --kconfig_add CONFIG_GCOV=3Dn
>
>     # Build-only, tests disabled (KUNIT=3Dy, DRM_AMD_DC_KUNIT_TEST=3Dn):
>     ./tools/testing/kunit/kunit.py build --arch=3Dx86_64 \
>       --kconfig_add CONFIG_KUNIT=3Dy \
>       --kconfig_add CONFIG_PCI=3Dy \
>       --kconfig_add CONFIG_DRM=3Dy \
>       --kconfig_add CONFIG_DRM_AMDGPU=3Dy \
>       --kconfig_add CONFIG_DRM_AMD_DC=3Dy \
>       --kconfig_add CONFIG_WERROR=3Dy
>
> (CONFIG_GCOV omitted; it is not available on x86_64.)
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>

I have accidentally dropped all Acked-by trailers from Maxime from the
previous version :(

>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
> Changes in v2:
> - Fix build when CONFIG_KUNIT=3Dy and CONFIG_DRM_AMD_DC_KUNIT_TEST=3Dn
> - Fix two missed EXPORT_IF_KUNIT in amdgpu_dm_irq.c
> - Rebased to v7.3-rc7
> - Link to v1: https://lore.kernel.org/r/20260907-visibility-unification-v=
1-0-6a962e5b3351@redhat.com
>
> ---
> Albert Esteve (3):
>       drm/amd/display: replace STATIC_IFN_KUNIT with VISIBLE_IF_KUNIT
>       drm/amd/display: replace EXPORT_IF_KUNIT with EXPORT_SYMBOL_IF_KUNI=
T
>       drm/amd/display: drop INLINE_IFN_KUNIT
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  79 ++++-----
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c    |  26 +--
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h    |   2 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  74 ++++----
>  .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |   2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    | 133 +++++++--------
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.h    |   2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |  12 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h  |   2 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 190 ++++++++++-----=
------
>  .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |   2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |  38 ++---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h  |   2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  52 +++---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h |   2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c   |  10 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h   |   4 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |  30 ++--
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h |   2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |  10 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 105 ++++++------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h |   2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 140 +++++++--------
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h  |   4 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 150 ++++++++-------=
-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h  |   2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |  40 ++---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h  |   2 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  60 +++----
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |   2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 104 +++++------
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h    |   2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   | 116 ++++++-------
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h   |   2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |  22 +--
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h  |   2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c   |   4 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c   |   9 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |  10 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |  18 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h   |   2 +-
>  .../display/amdgpu_dm/tests/amdgpu_dm_audio_test.c |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_color_test.c |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c       |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c        |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c  |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c      |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c  |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_ism_test.c   |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c        |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_psr_test.c   |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c        |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_replay_test.c        |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_services_test.c      |   1 +
>  .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |   1 +
>  drivers/gpu/drm/amd/display/dc/core/dc_sink.c      |   6 +-
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   2 +-
>  drivers/gpu/drm/amd/display/dc/dm_helpers.h        |  13 +-
>  tools/lib/python/kdoc/xforms_lists.py              |   3 +-
>  70 files changed, 771 insertions(+), 751 deletions(-)
> ---
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
> change-id: 20260907-visibility-unification-fd358c580447
>
> Best regards,
> --
> Albert Esteve <aesteve@redhat.com>
>

