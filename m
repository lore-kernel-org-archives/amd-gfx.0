Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B187ECD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D77D10E088;
	Fri, 19 Jun 2026 13:30:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MxiYJK4E";
	dkim-atps=neutral
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0581410E088
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:30:17 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-59ebc9135edso67066e0c.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 06:30:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781875816; cv=none;
 d=google.com; s=arc-20240605;
 b=au/SWYUO42IluBfJidpI/2pMg+SHKVbhK774UebKdf5srx7BGX40D0hBjs740OeF0G
 GWytzn4S15+nHH50EhgbHAeNJ2n6wg61Pr21hAldI25Rc+U22bHDtUXnQPVWb4GONNWP
 32eE/r4T92eHWNGIBl1oeRsTqoKIBQ6+v7Ti5YHEgZsayP8vZIyP72R+wqz5y83rP6ec
 pCAId2J9R96zTIaFPrtNalGCI2mkGINQpAGqZgSxD+CIbrWLJq2SrDrdpgWiOldM+erg
 qverbr87LhR149Tux5MX3gwDpwgNFBMYfyWG14eIrBFz0+fSXoxPZbvYIbfTqwY/Z+dw
 ZPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+BAkjpfWQowdjBsNdaaNxgIzUMsqo46Arsowlr/gjUc=;
 fh=zhfJp64LGfjTDkTFiBkkrx4gm132SO5yqXuHnDwZggY=;
 b=D5u+6BOfzfcHVVMFI03U05GNMfm39uF5I1Tkq8pd9gmV5g07O2lp4Tcu2KpkmyBokV
 1eUZjtuqMGqMPdvVxVD1iWZ3NDsx/fUbKmYX1RcAixdhT4ZzjfKByG0yLHypuQtm+3h4
 MPXIYmKzo3zMAwakS1QtUbVW5wLxSNK/FLDU7s3ZUcrxJXCr4P9bNzDTFbBaiAAShhlg
 Uv8Xf9TzZ1QdxsEtUjydXQ9LOzUrAYiLGCWIdMuWXEd8idzPZzmOZ69Il4JWwnO1s5vX
 VBpoBOXKysYduIdBcyuOh0Dqvm2vP7d+33YCtzG2M5L/5bPv7aOmBtcjPerS0EFA1Pk4
 cihQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781875816; x=1782480616; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BAkjpfWQowdjBsNdaaNxgIzUMsqo46Arsowlr/gjUc=;
 b=MxiYJK4E7LO7WpPp+VcNsM/B3/oOCBcjOnezmaYE51fH+k/lCSGQRQhFZE4BrnijNI
 Op6j3PKx0ISp1E53ASi8r82/CGPVWnIi+sVwgqBUfJVmdR58M7/ijfZg+xvyTpXMq5dr
 6rOJUo599cnlx+4a0XY6ExI7lC4YyQY2lPKVJRFCIIf8e84Qh5JyBvY408JqOV0gdp3b
 mrKvXX0X5O65kH08pGVXF3cEt1rW5ucNoRpoc1hTt+Y4dR9moL9ajd2r4XMIwTVDVhhc
 SBPTKuz91J05VaIah9LJCSWbc7CtL7qaRBpS0oHVfUZN59gH2H8DnL7SDYpJx6zvPOBw
 UhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781875816; x=1782480616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+BAkjpfWQowdjBsNdaaNxgIzUMsqo46Arsowlr/gjUc=;
 b=Nlbw0J/Y+D0bEQG4CO8ZYqgTs18rYKDnPC9HeXdGhiz7zvbG0J46TFyT+D147WwYBc
 yuG23O1iQF2bu37LFz/RLZgP9Q5ibu47/n8KWiJMMk4R7GnkXICkdzSSCBKRAJnvn4i8
 51IPYH0HS6tsoTZIGx3rVuwt6sHL4/bRkNep7nicEBx6mfUbBc2xYviv0DGS7lvsNpSV
 086lj9XaLy4tbd4X7oQCazwHXCmc5FA4JkflUYAz4Jb9+e6/bDrYqKzbn9bvj0G0NoJY
 +YmQmbCeBkuAMR18FteokCi9G6Lu5iSRwymhIRleB3CVARLJnkv919IqHxBedMSwWEn9
 Knjw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8MEdaFyBfF4FCq3Vj05DP53KPi0W5ar8xLDTnmwi3ig6Iyu/G8D6UL0po4V2SZPSIqc672D3rj@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3rQmyZCnel9t4U7X2vVLCMTFVQNflcmDlc8OGAI0aTAM6nUtg
 rHLa+SKeNZ9jwvKFmhx6lsA+KU1y76S2U4x6TqfzeqcIYCUIieSOWjq3sQUH5X/4aZZWD5Ih24b
 haU3TroBWCAPcJJnONhKKNWGQZfLtM+Q=
X-Gm-Gg: AfdE7cnEK+iPzQlwaiQYoMxh9JjLJh14+DfyXJ/v9SRzoBin6ffjVb1Ho8KgPq9usOe
 w9n/3S61t3Q3CdeAb8/FT/oGJjvT7iYIOiPJfv4hOTp0+DCE0g+9W6k6F94L3Mm1u8IfFeyTsdV
 mmPsVBUERGJUrbu5gAVg7ITH7sO13ZdCsIYdE/1UtZVPQ7zucCPz/8v4INIjHsfmyheMHvOjOnu
 axbD+w6OAG7XtffH9x8Oddkanx6BUkQccaAkBTOuh4xFJFo5jw+hRNV6S7+5GIqUrlNaXxNHQTj
 n10KjncmJrs3JQCV01jodQuWp0ZgGbSf6FxWEHuvoziV+dHrCtGEbsk+Wwg=
X-Received: by 2002:a05:6102:1620:b0:674:84bf:8e0a with SMTP id
 ada2fe7eead31-72b16d7a278mr196403137.7.1781875815754; Fri, 19 Jun 2026
 06:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260519030624.51613-1-leorize+oss@disroot.org>
 <20260519030624.51613-2-leorize+oss@disroot.org>
 <CADnq5_MrUaLRP70hwb5YGawjfft9qUaH4h_t4TQ17AEgAwj3ww@mail.gmail.com>
 <1f24aee4-8588-4d54-ba5a-cc5e9c002a54@disroot.org>
In-Reply-To: <1f24aee4-8588-4d54-ba5a-cc5e9c002a54@disroot.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Jun 2026 09:30:02 -0400
X-Gm-Features: AVVi8CeVOSc_6Z1h6askeKyU8KcBbZJ7fycBobyYUlTtvuSIqWN8dX11pHGRATM
Message-ID: <CADnq5_NHskZySwM3pt9yPkAGRmS6JHGnh=TyKv4==dkL+9wR=w@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amd/display: set MSA MISC1 bit 6 when using VSC
 SDP for DCE 11.x
To: Leorize <leorize+oss@disroot.org>
Cc: "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, 
 linux-kernel@vger.kernel.org, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

Applied.  Thanks!

Alex

On Thu, Jun 18, 2026 at 10:03=E2=80=AFPM Leorize <leorize+oss@disroot.org> =
wrote:
>
> Friendly ping. Should I resend this patch?
>
> On 5/26/26 7:52 AM, Alex Deucher wrote:
> > @Leo (Sunpeng) Li
> > , @Wentland, Harry
> >
> > Can you take a look at this?
> >
> > On Tue, May 19, 2026 at 3:19=E2=80=AFAM Leorize <leorize+oss@disroot.or=
g> wrote:
> >> When BT.2020 colorimetry is selected, the driver sends information usi=
ng
> >> VSC SDP but does not set "ignore MSA colorimetry" bit on older GPUs wi=
th
> >> DCE-based IPs. This causes certain sinks to prefer colorimetry
> >> information in DP MSA, resulting in terrible color rendering ("dull"
> >> colors) when HDR is enabled.
> >>
> >> This commit wires up the MISC1 bit 6 for GPUs with DCE 11.x based IPs =
to
> >> correctly configure sinks to ignore colorimetry information in MSA,
> >> resolving the color rendering issue.
> >>
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4849
> >> Assisted-by: oh-my-pi:GPT-5.5
> >> Signed-off-by: Leorize <leorize+oss@disroot.org>
> >> ---
> >>  .../drm/amd/display/dc/dce/dce_stream_encoder.c   | 15 ++++++++++++++=
-
> >>  .../drm/amd/display/dc/dce/dce_stream_encoder.h   |  3 ++-
> >>  2 files changed, 16 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b=
/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> >> index ed407e779c12..2c3a20d35fe9 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> >> @@ -271,7 +271,6 @@ static void dce110_stream_encoder_dp_set_stream_at=
tribute(
> >>         bool use_vsc_sdp_for_colorimetry,
> >>         uint32_t enable_sdp_splitting)
> >>  {
> >> -       (void)use_vsc_sdp_for_colorimetry;
> >>         (void)enable_sdp_splitting;
> >>         uint32_t h_active_start;
> >>         uint32_t v_active_start;
> >> @@ -334,6 +333,16 @@ static void dce110_stream_encoder_dp_set_stream_a=
ttribute(
> >>         if (REG(DP_MSA_MISC))
> >>                 misc1 =3D REG_READ(DP_MSA_MISC);
> >>
> >> +       /* For YCbCr420 and BT2020 Colorimetry Formats, VSC SDP shall =
be used.
> >> +        * When MISC1, bit 6, is Set to 1, a Source device uses a VSC =
SDP to indicate the
> >> +        * Pixel Encoding/Colorimetry Format and that a Sink device sh=
all ignore MISC1, bit 7,
> >> +        * and MISC0, bits 7:1 (MISC1, bit 7, and MISC0, bits 7:1, bec=
ome "don't care").
> >> +        */
> >> +       if (use_vsc_sdp_for_colorimetry)
> >> +               misc1 =3D misc1 | 0x40;
> >> +       else
> >> +               misc1 =3D misc1 & ~0x40;
> >> +
> >>         /* set color depth */
> >>
> >>         switch (hw_crtc_timing.display_color_depth) {
> >> @@ -499,6 +508,10 @@ static void dce110_stream_encoder_dp_set_stream_a=
ttribute(
> >>                                 hw_crtc_timing.h_addressable + hw_crtc=
_timing.h_border_right,
> >>                                 DP_MSA_VHEIGHT, hw_crtc_timing.v_borde=
r_top +
> >>                                 hw_crtc_timing.v_addressable + hw_crtc=
_timing.v_border_bottom);
> >> +       } else {
> >> +               /* DCE-only path */
> >> +               if (REG(DP_MSA_MISC))
> >> +                       REG_WRITE(DP_MSA_MISC, misc1);   /* MSA_MISC1 =
*/
> >>         }
> >>  }
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h b=
/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
> >> index 342c0afe6a94..88d6044904d1 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
> >> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
> >> @@ -96,7 +96,8 @@
> >>
> >>  #define SE_COMMON_REG_LIST(id)\
> >>         SE_COMMON_REG_LIST_DCE_BASE(id), \
> >> -       SRI(AFMT_CNTL, DIG, id)
> >> +       SRI(AFMT_CNTL, DIG, id), \
> >> +       SRI(DP_MSA_MISC, DP, id)
> >>
> >>  #define SE_DCN_REG_LIST(id)\
> >>         SE_COMMON_REG_LIST_BASE(id),\
> >> --
> >> 2.54.0
> >>
