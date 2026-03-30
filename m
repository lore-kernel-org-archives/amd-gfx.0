Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8390FF60DC
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 07:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DE8110E8B2;
	Tue, 31 Mar 2026 07:26:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OidhBKRx";
	dkim-atps=neutral
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A692F10E747
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 21:38:49 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5a126c8aab9so5923317e87.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 14:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774906728; cv=none;
 d=google.com; s=arc-20240605;
 b=HXADHNrdM7n736DASDniadir92PQDV0yLHMUX/W3xDRn7N+tMKVjWUcx7bChWibFIB
 +cM4es6bSKGRi71pZPZDvx+WZNoqYfoGW2Vv31ODwgPqEpLdilJHwuFkI2v0wKvPnG5I
 Q0TjGtjtZyQ6sRRK8reHXIJWkKtsVD4GA96i0TfRW3qvHgW1zEi/9eVRgoGUIFnd2KTQ
 976Pf6gppIofeDc8pTTZrN4WgkIR88iQwsHY2cYjl3/Vjx3AKldsUXaJl+VNeh7TxJD2
 7+peisJW8DghTAFwxoWARIqHuPKFUIjtFj7203Sz0YPlERQRp09MyBiPpDXA0kdJt7Nq
 NSsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RyXWT6CZTRjvrBzjlgkYqR6hvQZ/LcLxcXjlYxt3yys=;
 fh=+8sHxLrgr84wtjsDhUmjnZsb1YFesT6gN9NgQE8tzu0=;
 b=RnuhHgpLqnD/yvXqOGsY1HMaePsTVzNw8/xUOEmUdkwgrCrc7LVeTQzB2kQ5DVQ6RA
 1qe1XFSXbJakabc2MnaRq/NPbx4jVAxgHfNvu53vAEx+KtpBEU969aGxPw93tHQywyLZ
 EN+npS52nasuouVchhIq37zHhuSnzK7Z3XdXHm6E74voQuK1hTWROmZVQNLv2CRvYnjq
 dfV3X/f+rBEmOv7qx2aa8LQ/6sphUUiWGXJ1xgBBwIz0oR5Wp0YuF15d6ud55TM/qVBG
 blb0CdYX3uq/s1nXX6g4LL3u/iDqPLnuxoBaYLQqQySdhbiJtGXa5mu4moN89G5SfuFl
 DNgg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774906728; x=1775511528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RyXWT6CZTRjvrBzjlgkYqR6hvQZ/LcLxcXjlYxt3yys=;
 b=OidhBKRxAd3DSjgPGVt59s5wOrzVk/A1dRr/CC2v8RvK5pp1zmJheskeMFcFwhi04P
 MPBFH0cUGGC+Tw6BKFUaXccZ63lgFXDismdiZQ04VlCrT+HdMN3cMrl0XIjV2Xs4y7N2
 nPx5Lt4hyKTg2pEKIL6NJXtOzsSfx+xXpKnTzNTKemW2yYozrKD8/ORTLPbhZEPsnTgY
 bsF8AGEWg4QcsIb/a8OqEnB/yRHDR2EefyKZYcZoZrAJlaELFYvVHOaNgM7bt0Plw3vG
 oBj25HAs2DZa/5qj1HN7eMJRUrVgEEocBh8nOcoGnTvzzdxl3JSuaf38QhYv5PiSh2fH
 JaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774906728; x=1775511528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RyXWT6CZTRjvrBzjlgkYqR6hvQZ/LcLxcXjlYxt3yys=;
 b=NN8W1E6GHcVeot8hKUl1zOCbyovLuXcvu7sLqJchnm0z4vMi3O0c0OSMQepEpyCiIp
 Qsa8PZ/U2l2W3+6WEPEaYYd0CiJ93MFKjLsEHiN4jNoVx1Tcxs58SxYas07ui0eXtBzG
 Xzhg7GlmqNdr1V5LkOUidd8UNrIMh0NDZmMH8NOkjqKmba4H02wiwtklNtwRO5ZyahtD
 SqLMiPQkNw5P4rIsNcjfdHDZ5Zxc6/C8mBsO612aUCTmWWPWr0zPOc26YUcoVacKylCm
 L57Iz1q7QFBCPCYHCtAEhAjKoYuXRTipcYxbGz0QxaYsGkyo/gScGjvJtGjM8WMSBEkK
 EePw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjad9Dl9CuX9MvwBM7otY3VVHAPpv57cs8Ppg6YAfptLVxopV0T4ij8URcN9G3B94lSxpvaP3A@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwmSBXyAgAOJAks2lnBrO3kklNZth6W6XmwIuVqilGvqqVcfeW
 YEy/tlO8wkHFvP3fy5STQ0p1hJd/QXUYcGl9MWdg1fy4XAD/pBozMHZ87amKP0Qw4Ek+PGss7K3
 phn2nTjd92SvgSs5lp54YbZki3KAFktI=
X-Gm-Gg: ATEYQzzrsuR49DFuRveV8WLLMFh9NQs2uV1xtI5gBRzVPaFSXkXyJrLZdo5xcXK12o/
 m94RURh4MSG2ziA6RPQ8T5snFOTWYZ2z0eOAs835Gak2Pe9pgVCzRuz4W0VxaWlI+DWE/plpQWK
 xZfprBYR+adEW669Uw0/1WvoyJ9RS5H+buNKbHimZGffHckaNK7nxcwF6tNTz/zWNsoSHVNkfHS
 xocYjdeaFfkW46IAFgzPMrDYvixls/Al1VjH7ThusYmbghW2L4OpHkS6EeDwIJoPFyuNCsGR8jj
 rH3dPcSevsHXJiH4Lr/5KU75p149bl3j1GnWO76MwG16AHWNYIXGxwBfxTt3Vjr1QkonfzPZZHJ
 PTY3YUg==
X-Received: by 2002:a05:6512:1084:b0:5a1:4473:bb44 with SMTP id
 2adb3069b0e04-5a2ab92d9e4mr5216280e87.33.1774906727539; Mon, 30 Mar 2026
 14:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260326234716.16723-1-rosenp@gmail.com>
 <2312151.9o76ZdvQCi@timur-hyperion>
 <6b15401c-1fdf-4d3b-84aa-dfc47f430895@amd.com>
 <7351746.9J7NaK4W3v@timur-hyperion>
In-Reply-To: <7351746.9J7NaK4W3v@timur-hyperion>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 30 Mar 2026 14:38:35 -0700
X-Gm-Features: AQROBzClHbQKYMQEBk1N37wHNV8JfR61-qIixPaDukv245DWUjEWx7ElX5PJJLU
Message-ID: <CAKxU2N-CRua=kMVm8gdf2AnbCFyLsLTbf=-9NZHAkhL3sJC-tw@mail.gmail.com>
Subject: Re: [PATCH for 6.12 3/9] drm/amd/display: Disable fastboot on DCE 6
 too
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: stable@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, 
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bin Lan <bin.lan.cn@windriver.com>, 
 He Zhe <zhe.he@windriver.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, 
 Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>, 
 Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, 
 Tony Cheng <Tony.Cheng@amd.com>, Mauro Rossi <issor.oruam@gmail.com>, 
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 31 Mar 2026 07:26:04 +0000
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

On Mon, Mar 30, 2026 at 7:21=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On Monday, March 30, 2026 3:55:55=E2=80=AFPM Central European Summer Time=
 Christian
> K=C3=B6nig wrote:
> > On 3/30/26 15:16, Timur Krist=C3=B3f wrote:
> > > On Friday, March 27, 2026 12:47:10=E2=80=AFAM Central European Summer=
 Time Rosen
> > > Penev>
> > > wrote:
> > >> From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > >>
> > >> [ Upstream commit 7495962cbceb967e095233a5673ea71f3bcdee7e ]
> > >>
> > >> It already didn't work on DCE 8,
> > >> so there is no reason to assume it would on DCE 6.
> > >>
> > >> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > >> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
> > >> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > >> Reviewed-by: Alex Hung <alex.hung@amd.com>
> > >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > >> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > >
> > > This patch is incorrect and should not be backported.
> > >
> > > (Note that the error is already fixed upstream. For stable kernels IM=
O
> > > it's
> > > best to drop this one.)
> >
> > Is there some alternative which needs to be backported or should the ol=
d
> > kernel just work out of the box because we never enabled some feature
> > there?
> >
> > Apart from that the patch set looks good to me.
> >
>
> This patch had a typo and does the opposite of what it should, ie. it dis=
ables
> eDP fastboot on DCE10 and newer instead of disabling it on DCE8 and older=
.
>
> The upstream fix is here:
> https://lists.freedesktop.org/archives/amd-gfx/2026-February/138577.html
> which disables eDP fastboot on DCE10 and older.
Not sure what the process is here. I make sure everything can be git
cherry-pick ed. In that case, both should be present.
>
> >
> > >> ---
> > >>
> > >>  drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 6 ++---=
-
> > >>  1 file changed, 2 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq=
.c
> > >> b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c index
> > >> df69e0cebf78..7dc99c85b8ea 100644
> > >> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> > >> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> > >> @@ -1910,10 +1910,8 @@ void dce110_enable_accelerated_mode(struct dc=
 *dc,
> > >> struct dc_state *context)
> > >>
> > >>    get_edp_streams(context, edp_streams, &edp_stream_num);
> > >>
> > >> -  // Check fastboot support, disable on DCE8 because of blank
> > >
> > > screens
> > >
> > >> -  if (edp_num && edp_stream_num && dc->ctx->dce_version !=3D
> > >
> > > DCE_VERSION_8_0
> > >
> > >> && -                   dc->ctx->dce_version !=3D DCE_VERSION_8_1 &&
> > >> -              dc->ctx->dce_version !=3D DCE_VERSION_8_3) {
> > >> +  /* Check fastboot support, disable on DCE 6-8 because of blank
> > >
> > > screens */
> > >
> > >> +  if (edp_num && edp_stream_num && dc->ctx->dce_version <
> > >
> > > DCE_VERSION_10_0)
> > >
> > >> { for (i =3D 0; i < edp_num; i++) {
> > >>
> > >>                    edp_link =3D edp_links[i];
> > >>                    if (edp_link !=3D edp_streams[0]->link)
>
>
>
>
