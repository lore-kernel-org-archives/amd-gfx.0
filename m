Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5FCC56203
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 13:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2CFC10EE9C;
	Wed,  5 Aug 2026 13:55:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I4yu93y3";
	dkim-atps=neutral
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0C4410EE8A
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 13:55:40 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-455ca262ccbso570719fac.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Aug 2026 06:55:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785938140; cv=none;
 d=google.com; s=arc-20260327;
 b=kNQWpoU1x8RiOQY3/MBTUzKyEyjZwfLgw3MJSV0nWXw8fMu6EBC/U5REVOKNiOmUdf
 jgpgZlslYiAJ/OW0NO6ZSRS1WaRWDI8medMhPGwy0KUOxA6eOgZ88R0ES2gB9x6BkeQH
 FnWcp01SRw30HzP15h7Uvtgfw2awMKIpqjpfXms2NgkSS6mfTs9JL8LyCZq/TkNXJ8Vw
 YUGSVC1FkHZyZ/nelRRmYQHbYItkafdKOOPLHKFhfBcDW7qC4X1CjrbvMdKOEdIlg7Gj
 6bU/IpgzjhFfW0RWupDHbeSBmncTijawvZkpVuaH+2VDbfLieoD0L5WocmSPoqARfbhn
 UKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0T5/BwMbKCVTLYDKO3fObDhqOfeGegG11SJ0r26Jq64=;
 fh=OPX5SiPgHillB4skeawk+lrCV51RyRu2NyxE420j7So=;
 b=CdCYrOwEf8FGVCCLBRSHjro3z7od6cMBYWHOoDBp66KpyOkt0sYbQXcrp0/+DUYq8C
 v7y3y1brs0soTVsfShVaaw7ajqrmCeAR2SKKsypY9NStdopSXhzKDjND1rn0YFIh1taL
 hHFOTSe/9CT9guxB496fimfUf76d+Oq0gOsS+BWDaNkxybo6mmcegRhR7aA6EaZdeYWP
 r3lNJ52Iole2QllctspllA6xIhjw4Hdqb6xcqOKbutuMY3ikDCZLxpxSGXZAm7TuxDsw
 ahinuYXQyEEkSw4oRvegaAqrFMT8gZTBgTvuC2SAqbITwqQicyp9Uu1djmCyf+2czgmj
 mqyw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785938140; x=1786542940; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0T5/BwMbKCVTLYDKO3fObDhqOfeGegG11SJ0r26Jq64=;
 b=I4yu93y3/JKLqwoM8ILW8cNJmy4ZEX7zll+x/Kz/lkJtEjmKkFaebMEsrb/JCZzWvx
 PHYus5PW8rdnwZCcbWFuSCxJMGb5aHtY05s+rD7kWRB6S0Cp/zx/09rJ/AkpJYhpc20T
 fi3c43hh/6nqA37uoke5B2i8icfpTpH+H5ofd35Yo5SwKz/zkzcn8GVOUYD3vl99iOIq
 6CRyNNm7G5oNCVEj6dnKT+Jhs/tDaIMKvSo64aEc3Wo/8ba7fvRo6x/rupcblIcTi/kA
 HwLQmWBcwH96+K45wDuWMRu8uwkurprMBC7kvM/VQ386JA3cNBT0ku++MjcKlPcVkadb
 v5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785938140; x=1786542940;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0T5/BwMbKCVTLYDKO3fObDhqOfeGegG11SJ0r26Jq64=;
 b=H49m2dMTmm0YWAAV2Aprh++3dtHkQBdv2jfQmjQe9XT0QBWgFi5QFOKx3hWFD0XlNj
 rNccH4OCTCR5EMu1Kg0Ywxd+n94XOwgFR0wXUylhXLu/Mq2j2aH5W3ZNi8fUMaQMJe5V
 928OkcN13nAwN1+X1hvPvpGXNmhgey2xE0P7JfdFWcq0WUCnPe+X237jgIW6xap3mjWY
 fsWRD46leddIuiQ5iV1SCBoi+gMHu5rBtbmZMZmLXqyUWDS5eqV3Bon27wCs7bTagdpv
 NRivLTzcErIki/1X6MQdZN0dXZGDX9bXDy1plTjb/51/oNqxEGrXGojJQidxsBfzDLH0
 RtEg==
X-Gm-Message-State: AOJu0Yw7k30kOrIdXPrnlucaQQ6QlLPVhxYg69Xp5v0LtZbMfOdTVxd/
 +W5oyzEOejNmoVJcK6TsSC5y2kaH4Q8KnKXRalHL6oXK1uDEPzpDSnZhSkSAQ6nRMHLWPgXHeU2
 W/Z8u11sDZvDU0jiSMzpcbqFAWDLnCvI=
X-Gm-Gg: AR+sD10Y/exjb/FPCCyZcbyteY1F8ix4DqAR+ULrlH4HnMwH+sZUoJSnfFRk9oXJyXl
 ESEB0oRKBpW0bS0TYevYM1hptkKJ33QyTegydsOq86zvyiI0hUd43+YcWURrYfzDQC4do1aO+68
 ogGMbVRpY/dGrMHLvPUYS7KpyXaDm3ib1QIsJlv8z4uh4YR+Xhh+zmj6IYfsoWp/bJei9ZzfMG0
 XrIZtw8slCLlBH+3npk4kNb3e9O6bCJGOLpCOA0GAP9QvdSUB1nPO8RSoQqgo3gbCtUaqrAj8zq
 NX3K03EwY/g307g4f3tOkH/2EHIiAgN1smqaEfJ7dO7B7Q==
X-Received: by 2002:a05:6870:c145:b0:448:7ecd:583c with SMTP id
 586e51a60fabf-4599ef66e57mr3421197fac.17.1785938139558; Wed, 05 Aug 2026
 06:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <15b28cafab1b55f3e4cad9bb542847d22e776bda.1785616749.git.nlucasgit@gmail.com>
 <20260803152533.9008-1-royalnet026@gmail.com>
In-Reply-To: <20260803152533.9008-1-royalnet026@gmail.com>
From: Nathan Lucas <nlucasgit@gmail.com>
Date: Wed, 5 Aug 2026 07:55:28 -0600
X-Gm-Features: AUfX_mzExbPGJJsBny-YZnnSr1GCs-6bfdue8MaTV1Rrsd66Jj3Gf72et43uSvY
Message-ID: <CACNCB+=APzutjqirzBCfkt-t5QRMOnr9j3pWT0RxEOkH3mkEug@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: fix BT.2020 YCbCr output CSC
 matrices for DCE
To: Igor Paunovic <royalnet026@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
 siqueira@igalia.com, alexander.deucher@amd.com, joshua@froggi.es, 
 mwen@igalia.com, leorize+oss@disroot.org, alex.hung@amd.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi Igor,

Thank you for taking the time to test the patches.  Your RX 580 should hit
the new limited-range matrix in dce_transform.c which I was not able to
directly test.

Thanks again,
Nathan

On Mon, Aug 3, 2026 at 9:25=E2=80=AFAM Igor Paunovic <royalnet026@gmail.com=
> wrote:
>
> Hi Nathan,
>
> I hit exactly this on a DCE 11.2 part, so here is a data point for the
> path you could not test.
>
> Setup: XFX RX 580 8GB (Polaris10, DCE 11.2) as an external GPU on an
> Orange Pi 5 Plus (RK3588, arm64) over PCIe Gen3 x4, driving a Sony 65"
> HDR10 TV at 3840x2160@60 with HDR enabled under KWin/Wayland. The sink
> lists 3840x2160@60 only in its YCbCr 4:2:0 video data block and caps
> TMDS at 300 MHz, so the stream comes out as PIXEL_ENCODING_YCBCR420
> (confirmed in hardware: FMT_CONTROL =3D 0x002a0000, FMT_PIXEL_ENCODING =
=3D 2),
> and with the compositor setting Colorspace=3DBT2020_RGB the output color
> space ends up COLOR_SPACE_2020_YCBCR_LIMITED.
>
> My tree predates 51e6668ab4ba, so global_color_matrix[] had no BT.2020
> row at all. That is worth recording as its own failure mode: with no
> matching entry, dce110_opp_set_csc_default() programs no matrix and
> configure_graphics_mode() leaves OUTPUT_CSC_GRPH_MODE at 0, so the
> output CSC stays bypassed and plain RGB is fed to the 4:2:0 formatter
> while the AVI infoframe declares YCbCr 4:2:0 with BT.2020 colorimetry.
> The sink then applies a BT.2020 YCbCr to RGB matrix to RGB data: luma
> lands on green, Cb/Cr sit near mid scale, and the picture is washed out
> with a heavy green cast. SDR on the same link was fine, since it stays
> on the BT.709 entry.
>
> Applying 51e6668ab4ba plus this series on top of 7.0 fixes it: colors
> are correct on that TV in HDR, across a reboot, with no amdgpu errors in
> the log. As a cross-check, the same desktop on a second monitor driven
> by a completely different pipeline (the SoC's own display controller)
> now matches it.
>
> I also booted 51e6668ab4ba without this series on the same setup and
> could not tell the two apart by eye. That is not a counter-argument to
> the fix, just a note on sensitivity: the compositor maps SDR content to
> around 350 nits, so nothing gets near the top of the PQ range where the
> full-range luma scaling would clip, and the residual difference stays
> below what this TV's processing reveals.
>
> Tested-by: Igor Paunovic <royalnet026@gmail.com>
>
> Thanks,
> Igor
