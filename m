Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DACAC5DF82
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 10:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 836BC10EFAD;
	Thu, 20 Aug 2026 10:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q+cwq43U";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5395110EFA3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 10:04:17 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-499a4d1d7f1so17302645e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 03:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787220256; x=1787825056; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7fMXPZhQqX8YEquMN843sRWTw5lxxLVgHy7woxM6MPA=;
 b=q+cwq43UhxYautzHkP8P5Qj/E7q6FD0k0Ko3PziL1m9ZOjtV2tFkMxn/FlnWZrzm5U
 EXOcOSvhl99ST5Rp1gzYeZ+ZnNVbxJNYlEtyGjk35ARgkIzsXJQ6N196xDdP6iGMk2YZ
 M2OE1759OCE0RLQysfLUD52UfrOHr1YoemooVRjaS9lOEw6MkLi4378bhnpY/L0H9fMN
 NDGnI8r421euFEXqPkvrWPfjXKP0B+o9Kl5REGyq46MEjgTjQIOedxZjO6mWbmnu/U5W
 Dak2RNnfJPTxx79UXB8R3NyXzRTRxgmS54TTG3wWPD903SjrqeaM6c2aMLsjTx3Z2ZLJ
 4rEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220256; x=1787825056;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7fMXPZhQqX8YEquMN843sRWTw5lxxLVgHy7woxM6MPA=;
 b=HCsGqKvaxReAUfUYQg7nI+PXD9BQFocryQABIc3dtEVNHPX2x8BdGpRr5Pkec8QtU4
 6ON/X0RytW81F4m15M+mlm++a1jPn3WLklAtxKGJqVNQxp6mqBdyG2G28L2fgk7h+S8o
 gKdoCTADIgWmxV2hNhGDZWRKOOdjRaDoO1VqApix/n20ejPx/TX1/IB/2JMa5TNh28ft
 /0pKOzIxWVLXhsc3dOHMq7JzRKo3FLSeki7yXzEaAZz5yIUBC3t4pGjEHOzN/0Lhz2jM
 0d7Nh7FB3tbZKJBCnXGyzyqRhVejJ1/BuacmN1eeIWh1Yh1tSCInH5EQ1Qyz4mTNrPCV
 Qu1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsJJYQIbCr2HaShPYFz2NfFJF8EZtsjvLnbUu77UI4ROyOkjVzo+2SGLdATShXL1mumfQZ0z4u@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyc1MDWOY7UaOK7i+0NmSO9xDMNshszk/yLnTVqfaNdl6pvOSCk
 xcHH+EFEIC9DojZsOVj3l5+n4Yz4Xu7ZSsStKwQ0yhEwvjarOgkOEGXn
X-Gm-Gg: AR+sD11XXKLatIMSsdCSyiTHruYYtj4p3p9x0DR0jqsRUrIiIVLmR4RwmLkjOttkrhK
 tWyaUlntv7EqMkO4Q2nAaAaeFs5m083/vU/nLH+qZ2yLdqLnSdRwpFksKwT4jrxRRWv4k7nHN0q
 DK34wX5Qj7ejrZ2n5VdH6KM39Lep8WHdSNBXCEjWUr27oCXZX8lSM5ux7w8mOtGupjqi3uX2Wxz
 mFcVHT/t/VBp+17eyNUf+zjOfIXBrwDZC9X0gTehOoFldLFyOePgpC9B9F5nB2JG+XmMjzvbEza
 7QbO5KI9KW5eket20E81BvESfTy/4igrT9+N2i63MW6sUUJjFlNbmCs7kIXcQC023UtOtvQnnsO
 Ku6Cl8ux1g2a+3ukzcltFyMrLX5XnF9FcmCvTJgI+OcJdiMruPUIE2iqFjRoNUi+mATKixjrDjA
 kP1+82b7WBYPyVRydi0k6jYylnVCX43v9Cc5/99+gOPjWbLq3M1FjMAywe0XYqyXDRKlKtLz8dq
 RGg20I+cfE+3jDm9BaZ9zwhdw+dUOokpreyEiGzpVn3sEFINsoJ2L42z7+Z
X-Received: by 2002:a05:600c:1c22:b0:499:9240:9a1c with SMTP id
 5b1f17b1804b1-499aa1f5589mr190759105e9.15.1787220255306; 
 Thu, 20 Aug 2026 03:04:15 -0700 (PDT)
Received: from timur-max.localnet (161.red-79-154-233.dynamicip.rima-tde.net.
 [79.154.233.161]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aaef1665sm136515495e9.5.2026.08.20.03.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:04:14 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: IVAN.LIPSKI@amd.com,
 Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>,
 James Lin <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 01/82] drm/amd/display: Fall back to overlay cursor on
 dcn4x when top plane doesn't fill CRTC
Date: Thu, 20 Aug 2026 12:04:12 +0200
Message-ID: <sotcygwHR2GSzLrndBGZEQ@gmail.com>
In-Reply-To: <bec41455-2fbd-40fc-ade6-bc908c4e9045@mailbox.org>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
 <20260818202139.4172592-2-IVAN.LIPSKI@amd.com>
 <bec41455-2fbd-40fc-ade6-bc908c4e9045@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. augusztus 19., szerda 9:27:20 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=C3=
=A1ri id=C5=91 Michel D=C3=A4nzer=20
wrote:
> [ Adding Timur ]

Thank you for your consideration!

>=20
> On 8/18/26 22:14, IVAN.LIPSKI@amd.com wrote:
> > From: James Lin <PingLei.Lin@amd.com>
> >=20
> > [why]
> > amdgpu_dm_crtc_get_cursor_mode() returns DM_CURSOR_NATIVE_MODE early and
> > unconditionally for dcn4.x. That early return was added because these
> > ASICs no longer have the cursor-on-scaled-plane or cursor-on-yuv-plane
> > restrictions of older DCN, so native cursor is fine in those cases.
> > However, it also bypasses the "does the top plane fill the CRTC?" (hole)
> > evaluation further down. When the top/primary plane does not cover the
> > whole CRTC, the cursor must fall back to an overlay plane so it is
> > composited over the uncovered region; keeping the native cursor there
> > produces an incorrect result. As a consequence
> > igt@amdgpu/amd_cursor_overlay@non-full, which verifies exactly this
> > native->overlay fallback, fails on dcn42.
> >=20
> > [how]
> > Change unconditional early return with a skip_fmt_scale_restrictions fl=
ag.
> > For dcn4.x keep skipping the YUV / active-color-pipeline / different-sc=
ale
> > overlay triggers (genuinely unnecessary on this hardware), but fall
> > through to the existing entire_crtc_covered check so a top plane that d=
oes
> > not fill the CRTC still selects DM_CURSOR_OVERLAY_MODE. Native mode is
> > still chosen when the plane covers the whole CRTC.
> >=20
> > Update the amdgpu_dm_cursor KUnit tests accordingly: exercise the dcn4x
> > path with a full atomic state fixture (full coverage -> native) and add=
 a
> > dcn4x hole case (top plane does not fill the CRTC -> overlay).
> >=20
> > Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
> > Signed-off-by: James Lin <PingLei.Lin@amd.com>
> > Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
> > ---
> >=20
> >  .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  | 28 ++++++++--------
> >  .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   | 32 +++++++++++++------
> >  2 files changed, 38 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c index
> > 9534848ed240c..c41fce07b8fa8 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
> > [...]
> > @@ -300,15 +297,17 @@ int amdgpu_dm_crtc_get_cursor_mode(struct
> > amdgpu_device *adev,>=20
> >  	 */
> >  =09
> >  	if (amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 0, 1) ||
> >  =09
> >  	    amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 2, 0) ||
> >=20
> > -#if defined(CONFIG_DRM_AMD_DC_DCN6_0)
> >=20
> >  	    amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 2, 1) ||
> >  	    amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(6, 0, 0) ||
> >=20
> > -#else
> > -	    amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 2, 1) ||
> > -#endif
> >=20
> >  	    !dm_crtc_state->base.enable) {
> >=20
> > -		*cursor_mode =3D DM_CURSOR_NATIVE_MODE;
> > -		return 0;
> > +		/*
> > +		 * Newer DCN has no cursor-on-scaled/yuv-plane=20
restriction, so
> > +		 * skip those overlay triggers below. A plane that does=20
not fill
> > +		 * the CRTC still needs overlay mode so the cursor=20
renders over
> > +		 * the hole, so fall through to the coverage check=20
instead of
> > +		 * unconditionally forcing native mode here.
> > +		 */
> > +		skip_fmt_scale_restrictions =3D true;
> >=20
> >  	}
>=20
> Timur, looks like this might break your fix in cea54c52d82d
> ("drm/amd/display: Set native cursor mode for disabled CRTCs") again.
>=20
> Maybe the CRTC disabled case should be handled separately from the DCE ca=
ses
> after all.

I think the cleanest solution may be to just move this check:
!dm_crtc_state->base.enable
into a separate if statement above this one.

What do you think, would that fix it?

Thanks,
Timur


