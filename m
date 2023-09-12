Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59649CA0EEB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 15:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7CC410E42C;
	Tue, 12 Sep 2023 15:08:17 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1D2E10E42C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 15:08:14 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1d53ab187e8so4189159fac.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 08:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694531294; x=1695136094; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3AWZ1gP/z6dTODdUc1eJRTYZMGOcHgNx5jKPIdl6pNE=;
 b=nQZvpOKfXkj+RiG2dZ1XcUd3u8meRNcVq6O60PAjGGMMeNgWG84kMvOO38CB8amQO5
 gHDAQ3HJ9yXtwojfQz9g3wReCKlh3iw5uNMnB0c3ARqxu2/i1jPaKZ/OspUgjfpxlFQe
 NfDsDOWoenhHk3Cyz4H3RAcSM7tFrm4fZjZbwDtNIJoI/Sh0Kty4e3WNYDzwrldfALVh
 4IymYYdH8LPYpZy8b1wfVYXDIAQAXDfPgOCHz+xnfRKKUyMRE2vBdPszHsxPlomdC2EV
 4xlLv0Te5Rp1sQCcU8XGS7SV5p7Squ9YAAbgIvrUsr0GTpGAUoS45T8/FNxqMgnz6q8P
 sA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694531294; x=1695136094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3AWZ1gP/z6dTODdUc1eJRTYZMGOcHgNx5jKPIdl6pNE=;
 b=UKrlUEut7OZj8PQHtnztIlh5lCs031du56BvcHviKpyeHwb+rWTyXIxQIuMukySRRm
 /1xGls0ewg84o9uTL/4grI9uq0xefN4OdSHllJGzODE6x6J0/brI/Pafwf83Rwd+cxEP
 owWDx6OFn8PjDmI8l1ckvWEU6hJP/L4RUqay02ZBPpbRsmanlWVTkbAK4ZFDSN4H/Pkt
 dloZgMquc7BJCv2Fg8N/zkGhVQgtOahb3x+Jqbh+UMnX3JsN8Ocbi8PRhjUwgI28Vld4
 liL6LurGdRhh9oLsG1FgRQJW8Xx+A1inCr6qFI6y9Pd7QP8BgeeV4bio1t0Ke0EMEUwK
 dSwA==
X-Gm-Message-State: AOJu0YzfKIWs5Bp228cTb5Ysb7RJ5yIL/POWQt277WF4+6GaYfLFSqwT
 k4eW/H05YNsifpxKPyLD5tQlxSwinImgfd/mpu8=
X-Google-Smtp-Source: AGHT+IEc7GoQL5DMifTAnthIOUF1agNfowq9zci0PvZG0OCmtS+m94B89Nwjh9aVvEE8zOeBkkJk/UVEAyVKpDUKz80=
X-Received: by 2002:a05:6870:3291:b0:1be:fcb8:6a48 with SMTP id
 q17-20020a056870329100b001befcb86a48mr14716923oac.58.1694531293616; Tue, 12
 Sep 2023 08:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230904131027.912234-1-lijo.lazar@amd.com>
 <20230904131027.912234-3-lijo.lazar@amd.com>
 <CADnq5_MGGCEgSHM4-ZdFZiLX+b50P-bEC=EgB3ZrW7=Zp94GUw@mail.gmail.com>
 <a91e575b-c334-b0d6-a475-400ace0953a9@amd.com>
In-Reply-To: <a91e575b-c334-b0d6-a475-400ace0953a9@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Sep 2023 11:08:02 -0400
Message-ID: <CADnq5_NwMEeRQ6ZhgAjjU0A_knk-VUu-akP8zn-vJgboOBMP2g@mail.gmail.com>
Subject: Re: [PATCH 3/3] Documentation/amdgpu: Modify pp_dpm_*clk details
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 12, 2023 at 11:06=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 9/5/2023 8:20 PM, Alex Deucher wrote:
> > On Mon, Sep 4, 2023 at 9:20=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> =
wrote:
> >>
> >> pp_dpm_*clk nodes also could show the frequencies when a clock is in
> >> 'sleep' state. Add documentation related to that.
> >>
> >> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 10 +++++++++-
> >>   1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/=
pm/amdgpu_pm.c
> >> index 84e1af6a6ce7..3dca1aa473c8 100644
> >> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> >> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> >> @@ -983,7 +983,15 @@ static ssize_t amdgpu_get_pp_features(struct devi=
ce *dev,
> >>    * pp_dpm_fclk interface is only available for Vega20 and later ASIC=
s.
> >>    *
> >>    * Reading back the files will show you the available power levels w=
ithin
> >> - * the power state and the clock information for those levels.
> >> + * the power state and the clock information for those levels. If dee=
p sleep is
> >> + * applied to a clock, the level will be denoted by a special level '=
S:'
> >> + * E.g.,
> >> + *     S: 19Mhz *
> >> + *     0: 615Mhz
> >> + *     1: 800Mhz
> >> + *     2: 888Mhz
> >> + *     3: 1000Mhz
> >> + *
> >>    *
> >>    * To manually adjust these states, first select manual using
> >>    * power_dpm_force_performance_level.
> >
> > Might be nice to update older asics to follow this model as well at som=
e point.
> >
>
> Hi Alex,
>
> Can I go ahead with this doc update, or you want to hold till other
> ASICs support this type of reporting (with the patches, only SMU v13.0.6
> SOCs have this behavior)?

Yes, please go ahead.  It was just a suggestion for a future clean up
on older chips.

Alex

>
> Thanks,
> Lijo
>
> > Alex
> >
> >> --
> >> 2.25.1
> >>
