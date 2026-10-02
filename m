Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDC7CA5FDD
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 13:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DFF810E5F4;
	Fri,  2 Oct 2026 13:34:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D3cWyX6I";
	dkim-atps=neutral
Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com
 [74.125.229.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F24410F837
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 13:34:46 +0000 (UTC)
Received: by mail-dy2-f42.google.com with SMTP id
 5a478bee46e88-350e6de7dfeso57921eec.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2026 06:34:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790948086; cv=none;
 d=google.com; s=arc-20260327;
 b=iuCmXxhu9KnC2gAQJMtuLN4Iz4JRlrwX8IFCg52Y5Ek5rkpeeCp0SzyBvAm7htR8WU
 bS6aRs1OnbNns35kqa2M9zJKNdNhu2fT4tpVXRosQlk32yV3UpUDzA1l8PP4uN73Y6Pi
 uCutyQb9E3lji5HTkHnMXf7Yno1eVYBGuHv/4ZrJUs0iUXfyfzjbSRI8wzB8dj/AdQ4Z
 ucJjENGEWTRHyY/68/v5/L0GskM2ygIZc8bpZonhYv8ToXyZ78E7P4V9Aoq0bSxA8h7l
 GAhIVc67NHVcUNl7MoxkBCVzJT3IfTJoFrlMTh1kZpuIPlh8IW9hBbSuzS6mCd228Dxy
 Lzmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yx6G1AW+nvvITgzsA9b25EAkpoWe5JEuWuaZEwVI7YQ=;
 fh=5zKtID1MnxpWWgNpSNnrmdZb/wKNudG/e3wLwgp0Umg=;
 b=WhB3tdgik4PF6yeRlAopZN8sWG02rk+rROg5SBxktP6ZaQkYylG9ALnXGNw0d81ZYe
 Q56mCMH1nVU5g0pP4NLPnoZKGCeRAzC2cJuyyCgRATUwY8YKPgYG5SrcNkaBRGTpMhIM
 /suT8bvOMrzRP5m5hJ7zWh4NsktN1WECQ5yB4zQwa4Pap80dcmGsUpSxCo95xdexSJgu
 oEd80FJnOD0mcFotCkmU4KSVg0aoKZc4hsOxGkxQroK1N4NunHHDFKwvoxsmjlHscJsi
 MVYbLZ3usFGogEF/4qSghFC4ezXPlod1u1qpxtEBZap4n/3iASZlHpGiI+txeEIvwcCN
 FZqQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790948086; x=1791552886; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yx6G1AW+nvvITgzsA9b25EAkpoWe5JEuWuaZEwVI7YQ=;
 b=D3cWyX6IHokLUUTeeSIuKSOOFVAFlYNeY+YTDtnSWxDZCYJ8eoJywdjT6qI1+WKUVe
 pgFv9Vs5l3y4QcmmqMtGannA36FkwbS1GcGau74i4Bsrp1xsVfQnb+O6Rl0gF1SZBxVC
 QxM1LOGwbTsneMHza0oUQoI1TOkC5G/nnBKa6eVr3qLuN5HneCVx7s4JAUOtk+CxBuYl
 eb/zK5KjKReRlgiKXHyVrirF+1Vv9Li7CJeIGIoCvMykXQAYcjONUGji6+LCc0FyF/54
 j+e2utunDQ3A97JwU5DGLZhEPr6+QHaDk6QFqveJllGrqkxrWBkzpDNk69ZN7FTM/U8h
 lIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790948086; x=1791552886;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yx6G1AW+nvvITgzsA9b25EAkpoWe5JEuWuaZEwVI7YQ=;
 b=Spje7btpspbrhlR25ONkZfmmblrn6RUe6g/RnCYU4oTCGCpBWOvY7eFQ1damUoScSN
 1YqRoXB21YE/IGi35Cp65rMRXC3GX8q8MTqc9FDNljulEQsxIRIhbd9olKnZVv8+AF0h
 4elZRZV4050jJqBHy+S/KODiTMh0S3wch0sECPAvFCy1W2r+cRq9S5GAAv0FfaVtoBR+
 Gyuf1yuUF4Jqx549Tts+z2JgPb3RB2nYVtmIk5so+2fx9uxZ+RwX51rquYPwfP+Rteb1
 NKv94n1MBYdS6C++zS6U6tnb2Rqqe/92kRcteioSufOXy7vHFS3n5EseGB6N4ZolzhH4
 uINA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzETS34SN0l5X/qS93OyapDqU5Ny5SdbhsCi3HTBgwwGb/pyosP9Kzt8wiJTA7Q4KrnFxdzmzWQ@lists.freedesktop.org
X-Gm-Message-State: AFuF++lXjjgdjCZhhtl+ph1133upWcQ3kGvQvHBWPL7v5D+h7LD0lVKB
 t2zPWfTEOOsJEji9jQbsmieMv+UTSKP3s8geQAPXxq1TzXDxDqhOXOxwOLRArSFaq0ReOz5qmyz
 KhVH+ESjQNEoGqbvgXmJrCMJ2iCRHbRY=
X-Gm-Gg: AYBFou3dBdTOJ5v6QoeYCICaDTcY+xYnOwNLNQPABPTT15tqNG88LgfVOy32tJ7xtnC
 6lkWsKYP4B9Ps8fGxzSvaFTl9USE6Kh5vSQqou6H2tk8hcrw/bbz7Jmm+f6TsIurPLN7nHfA/Pa
 aM6fOkBoEqGWdMszNdNsIlkdHowH7cIvLhIM/EH5XQdY7k5V1SoGfcICuIOwsOGJ/DJndhlDx5g
 gY1V0XizSnSqFQn2D+sV794KkbeBOEm4tz7ifly22EcTsar2LHPHPKm1bQQEqF9UZTIqkeaZcfL
 AoWVzqmYLUTbLBjtAGdYWtYLQ6xg/bBi/4/3Jrsg9dW08UmDYbckdu55aeVfat5Cw4yb5/0GbuK
 HfIWYQlF5j8crG1t4Ugdn+T0vrFIag73w5CtQjNdFhUJBDZV5pVPt
X-Received: by 2002:a05:701b:424d:20b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-14f5aa4188fmr4688728c88.1.1790948085630; Fri, 02 Oct 2026
 06:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-visibility-unification-v1-0-6a962e5b3351@redhat.com>
In-Reply-To: <20260907-visibility-unification-v1-0-6a962e5b3351@redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 Oct 2026 09:34:33 -0400
X-Gm-Features: AclHuK_TcjLVEROGMJB5lyBOvzPZSfQv2eIf90DD5P5QCDVjEATvEIscfiIQFpg
Message-ID: <CADnq5_MZZje5XGfYgJ1v4Ts_k+ZyyBtSrSqB5upTEt+AqBi9Yg@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/amd/display: use kunit/visibility.h for test
 helpers
To: Albert Esteve <aesteve@redhat.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Sep 7, 2026 at 9:45=E2=80=AFAM Albert Esteve <aesteve@redhat.com> w=
rote:
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
> Tested with:
>   ./tools/testing/kunit/kunit.py run --arch=3Dx86_64 \
>     --kunitconfig=3Ddrivers/gpu/drm/amd/display/amdgpu_dm/tests
>
> (CONFIG_GCOV omitted; it is not available on x86_64.)
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>

I've reverted this series.  It breaks the build when CONFIG_KUNIT=3Dy and
CONFIG_DRM_AMD_DC_KUNIT_TEST=3Dn. When CONFIG_KUNIT=3Dy,
the functions are not static, but when CONFIG_DRM_AMD_DC_KUNIT_TEST=3Dn,
they should be, resulting in build errors.

Alex

> ---
> Albert Esteve (3):
>       drm/amd/display: replace STATIC_IFN_KUNIT with VISIBLE_IF_KUNIT
>       drm/amd/display: replace EXPORT_IF_KUNIT with EXPORT_SYMBOL_IF_KUNI=
T
>       drm/amd/display: drop INLINE_IFN_KUNIT
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  79 ++++-----
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c    |  26 +--
>  .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  74 ++++----
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    | 133 +++++++--------
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |  12 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 190 ++++++++++-----=
------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |  38 ++---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  52 +++---
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c   |  10 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |  30 ++--
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |  10 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 105 ++++++------
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 140 +++++++--------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 146 ++++++++-------=
-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |  40 ++---
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  60 +++----
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 104 +++++------
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   | 116 ++++++-------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |  22 +--
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c   |   4 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c   |   9 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |  10 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |  18 +-
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
>  51 files changed, 748 insertions(+), 728 deletions(-)
> ---
> base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
> change-id: 20260907-visibility-unification-fd358c580447
>
> Best regards,
> --
> Albert Esteve <aesteve@redhat.com>
>
