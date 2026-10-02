Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4808CA5FDD
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 13:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B9810E5C1;
	Fri,  2 Oct 2026 13:48:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m+/Mq4Yc";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A743910E5EF
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 13:48:52 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-33e79c06622so864984eec.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2026 06:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790948932; cv=none;
 d=google.com; s=arc-20260327;
 b=Ru/uB8KzsFpK4D2rqVcRpIYkuW3rDvARNSeYxpvd8RRD4gZ5OxY4DdB+7BkpZrVZ8c
 /mNKq5ohHMQJg7HBGD5REuYNwm39kPoVhmcJN1FB3hvJaFMoV5i9Z+QO6gOczSjjNZE5
 xrEFrw/fLo4W8rkbb0XeMaPMLTncsaYC+a8BDq6KeDhD32ZlFrsenb2Q9KTNvT819jV0
 eemDD+L/NvTosb2tdt3EB5zz6wO18tNLeflonDXSCZfizJLD2LrNed50DbnaEB1Pui67
 YxWZIiOH/g1heDPZlYDddD/PFYfuxSPVpF497k8/6j4x9WmDbkc2yzYEl3twqndF13Wz
 e2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J2DKjRlAzAFGq6y1KL+4ocbnmqLb/iUOft+MhA4fQgo=;
 fh=FpmpzzOxBkLj+zEmutJhgoKduNTzRt0SSWp+AKxvzxI=;
 b=N6u9rv2f+8RZ7ks1CGdfEtCwKyAzijL8VbijQe22ac7BeR5KgRgcVUDRu+7sCy0VGI
 ylC5bEQ7XLTOZ3sE6X1Z5oaG4TVbKgxHorMZpSuqfWQ2D0ZyxlpaQ18tQDXO2Ulobyml
 SM9xSGcUjpw0sRncTjAHFe9sGKVP9OPB5ujhouic/SMtQrTbuX2Sezeir459D2TD2PQo
 Zmh/BHaxoe7MAieJJZABCWPXL9MX7mBQcz4TZ+12YW60HmODAx0u7lEvSFl9i9fdfNE8
 ijwRq8wuly0FxSKRhZcagMQHqOsrZysK3bBa7vqYIpt5EdkkMp+k3YBWESWYAdQy00pg
 5/Ew==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790948932; x=1791553732; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J2DKjRlAzAFGq6y1KL+4ocbnmqLb/iUOft+MhA4fQgo=;
 b=m+/Mq4YcFSfRmHAiNVWAAFIRhGyBbxgPDTDB5sw8miQsonGsMD5H4UGzj2YF2V9SDn
 c8sH06scQqAOxB7VOcutAcpDuw1rGUwGc7xzJSaMRA5up5GQ7TBK6airG0uv7i8Ch+NB
 9CV87jd+4X+rfGKSUrcXcnqrUagQPOp2TmS/wpUqXaa+MTwhDqkjj/uE7H7c4DBZaL7P
 pNHxvz6AvYYMNo1cHqSTCO/6vlk6RtoUMoJ4jCc3wzRRCD7s4pCaiPAuYcHxjTh2+oVN
 6Bqjazy5HCcQoD7BOJaqmpjpfj5EH5uYibvVEmFdk5Hgz+wtLSZSXM75xGU+NFdCOcCw
 rxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790948932; x=1791553732;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J2DKjRlAzAFGq6y1KL+4ocbnmqLb/iUOft+MhA4fQgo=;
 b=tMOQhxQa1zp9eULWl+hPKGaRd3d9dSMdY/XEG1euaypqHquRghxI7lSUo/41Bdm9Le
 s166iKstYzqsGLq5R9z8BXl8/GlSl8deKznuFbEY0PjWVnyIK6I5mZY8UFrk1hKXe7+F
 DSNh/TR2VT7jsNUI0AIJ978HfJIswt5BT83c72rwjXz5bNWcxpLSG91ErhKRiTiD2sXa
 qe9nE1RLWnmSua6g64335vqIWl0XE6K+lW1aKMMcBatVPqYOWnl3xMcUUgIhFy0I+1DA
 GOPh6K9B6D1L1cXEMHUAp8Fr3lFs47qcgKDF5ax3AsUVOjWV0b9s+5hXnXHFcViBFW4I
 HCBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByMKGaU6EdsGaeWPsKGwj8n8ONv+bf2y9Q72N5tsUSTxgdjdhLqM6rA4shg7sDUKfbaJPax3Guf@lists.freedesktop.org
X-Gm-Message-State: AFuF++kHsT2olqCyjiczwISNHJd23rqW1NVjcrHtXxccU/OhyhtzRrMC
 CgERpWFkUzy69eFD+GASfEfTgTJ+4Aa/jQ573SZK/GG++HMo9VoVOqr7CYnNvobJHOH3TO8SQcR
 ynlpPyj7zCscIEX5r1uev4OlIYiE/pBk=
X-Gm-Gg: AYBFou3kjG2mXg9vO+Pzi/2bXH8Pa+DrT2T/5YcEfTgA2jzx4FnihULO++Ybakj6ILz
 qsFksXHd07joAsnHAtMr6fsJkQAsbiKNDy2XXYxCIZzyIBRQfK/PVtB1Yp2cSEivDb3LzJh3aqk
 b3gTrIajCMl9D9m+4F7jSODWfEVnZ3xjeauaEMU6ESlAiBORKu/sC4oVIu1qlUit2SJ1QesHx1l
 IF47o/sARjpzePd0YAhCOrpEZsoFhHX1RI1u9FjJqZOy0OFbI1mfm5jUsJzmcgO1EtQIqteZ5Nc
 OIGXcW9AXZLUXxdyNyuc2xA5Cu1b25+YrmJKR7SEr28Zybi1vK1mRQBALF2co5jRwN+9h7y1GWz
 jmvlEuefvGgVXolsQszvq2SWBNqqI/Jg5I/VxU+uhONlPz46ZReUOfTUtJweAyGQ=
X-Received: by 2002:a05:701b:4550:10b0:143:8212:a43 with SMTP id
 a92af1059eb24-14f5a93aa43mr4045234c88.1.1790948931622; Fri, 02 Oct 2026
 06:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-visibility-unification-v1-0-6a962e5b3351@redhat.com>
 <CADnq5_MZZje5XGfYgJ1v4Ts_k+ZyyBtSrSqB5upTEt+AqBi9Yg@mail.gmail.com>
 <CADSE00L=KGCXqpjm3aiOQ-JwzirXTrvVsd-mNXpb9QDggVs=pw@mail.gmail.com>
In-Reply-To: <CADSE00L=KGCXqpjm3aiOQ-JwzirXTrvVsd-mNXpb9QDggVs=pw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 Oct 2026 09:48:39 -0400
X-Gm-Features: AclHuK9HlnwREQSprOE2OEafwiRXDdiofJf8sSV8e9OU00tSYzj35_B2cG2A_YM
Message-ID: <CADnq5_PEun0nB3in17GyBSy2qSF_fWf=40-m2csv=9f1rmr5XA@mail.gmail.com>
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

On Fri, Oct 2, 2026 at 9:46=E2=80=AFAM Albert Esteve <aesteve@redhat.com> w=
rote:
>
> On Fri, Oct 2, 2026 at 3:34=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
> >
> > On Mon, Sep 7, 2026 at 9:45=E2=80=AFAM Albert Esteve <aesteve@redhat.co=
m> wrote:
> > >
> > > amdgpu_dm grew its own STATIC_IFN_KUNIT / EXPORT_IF_KUNIT /
> > > INLINE_IFN_KUNIT macros instead of using kunit/visibility.h. This
> > > series switches the KUnit helpers over to the common API.
> > >
> > > VISIBLE_IF_KUNIT is gated on CONFIG_KUNIT rather than
> > > CONFIG_DRM_AMD_DC_KUNIT_TEST, so the helpers are non-static whenever
> > > KUnit is enabled. EXPORT_SYMBOL_IF_KUNIT places the symbols in the
> > > EXPORTED_FOR_KUNIT_TESTING namespace; the AMD DC test files import
> > > that namespace with MODULE_IMPORT_NS().
> > >
> > > INLINE_IFN_KUNIT is dropped rather than generalized. It was only used
> > > on amdgpu_dm_fixpt_from_s3132(), inverted the original static inline,
> > > and is unnecessary for tests in another translation unit.
> > >
> > > Tested with:
> > >   ./tools/testing/kunit/kunit.py run --arch=3Dx86_64 \
> > >     --kunitconfig=3Ddrivers/gpu/drm/amd/display/amdgpu_dm/tests
> > >
> > > (CONFIG_GCOV omitted; it is not available on x86_64.)
> > >
> > > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > >
> > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >
> > I've reverted this series.  It breaks the build when CONFIG_KUNIT=3Dy a=
nd
> > CONFIG_DRM_AMD_DC_KUNIT_TEST=3Dn. When CONFIG_KUNIT=3Dy,
> > the functions are not static, but when CONFIG_DRM_AMD_DC_KUNIT_TEST=3Dn=
,
> > they should be, resulting in build errors.
>
> Oops! I'm very sorry. What's the procedure now? I see you posted a
> series containing the revert. Can I send another version of this
> series after that lands to fix it?

Yes, that would be fine.

Alex

>
> BR,
> Albert.
>
> >
> > Alex
> >
> > > ---
> > > Albert Esteve (3):
> > >       drm/amd/display: replace STATIC_IFN_KUNIT with VISIBLE_IF_KUNIT
> > >       drm/amd/display: replace EXPORT_IF_KUNIT with EXPORT_SYMBOL_IF_=
KUNIT
> > >       drm/amd/display: drop INLINE_IFN_KUNIT
> > >
> > >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  79 ++++-----
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c    |  26 +--
> > >  .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  74 ++++----
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    | 133 +++++++----=
----
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |  12 +-
> > >  .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 190 ++++++++++-=
----------
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |  38 ++---
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  52 +++---
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c   |  10 +-
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |  30 ++--
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |  10 +-
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 105 ++++++-----=
-
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 140 +++++++----=
----
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 146 ++++++++---=
-----
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |  40 ++---
> > >  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  60 +++----
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 104 +++++------
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   | 116 ++++++-----=
--
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |  22 +--
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c   |   4 +-
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c   |   9 +-
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |  10 +-
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |  18 +-
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_audio_test.c |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_color_test.c |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c       |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c        |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c  |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c      |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c  |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_ism_test.c   |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c        |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_psr_test.c   |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c        |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_replay_test.c        |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_services_test.c      |   1 +
> > >  .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |   1 +
> > >  drivers/gpu/drm/amd/display/dc/core/dc_sink.c      |   6 +-
> > >  drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   2 +-
> > >  drivers/gpu/drm/amd/display/dc/dm_helpers.h        |  13 +-
> > >  tools/lib/python/kdoc/xforms_lists.py              |   3 +-
> > >  51 files changed, 748 insertions(+), 728 deletions(-)
> > > ---
> > > base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
> > > change-id: 20260907-visibility-unification-fd358c580447
> > >
> > > Best regards,
> > > --
> > > Albert Esteve <aesteve@redhat.com>
> > >
> >
>
