Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17137C43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 15:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 986A810E9D1;
	Mon,  6 Jul 2026 15:01:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LCHMzun4";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E7F10E789
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 15:01:25 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-380f3c1b087so226184a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jul 2026 08:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783350085; cv=none;
 d=google.com; s=arc-20260327;
 b=b5iDgrL/O5/c1Ttk3VBl4UbubuKigEWb1MBdmZOe1YLhIIhMek2M9vrLwww5DF5kuI
 I138HFAg5u9qo7eC2CKjT6IaAbflXWSt1HG7lAyGBTHHC6Yh/XU7JeBW2FoHzAI/nH4K
 6ivEwGtms7RSvXdjVjDpSwQJs2uBWs6eEAsywkMjayWu+Rvb4pl5PtP0qPXBgciyQ3EL
 brD5n3QZq2lDkV5eRkeqKLmOSr6Hpo7zg0Z1j9NInUmCkU01SZh5DpMTFt/g/GouxZK5
 PeqOvKW83Qyc6I+RF/+0ARviMuxYBznrz0dK21v/E2Mos24jBbUQ8FFy/lq7+XXjNZtK
 3H3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5cs9fY76ZfcTUxH8Y7Yp1VT4qqPd2PXLsGA+gsbgSd8=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=tBD3R3wA7XV5tC/RZ/l4Mi/HATRH8rMfMxT+cjp3+M3maSlHZ5qkDCxStu99trgKEf
 oAdZrujVJN18pBoGNfCQZxqgmsclwB5k+1uW7PqyMIXUUVwjj2U4HJdo6EwOKbGe5/+M
 gtl5cJ2vtbPOzlntT8q3U+7nr/EP0R8gdHDLKTse/+kiangTC2oGxD+FsUiHC8li6Xta
 9KRJFHEPM8QorGtv9p5GMOrJN0rnxfu3Ey7CDZDGgJOAuBE+63X+0EfV9a1lxT9MBZY/
 eQCx/eYZhv4Oy0FAueKoYSQyEZ2l3asZuP0dkM3RjypYY4zfm9LdGV+Fio9Ag5bM7oEq
 3TyA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783350085; x=1783954885; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5cs9fY76ZfcTUxH8Y7Yp1VT4qqPd2PXLsGA+gsbgSd8=;
 b=LCHMzun4zNHRNbs0bqJN3k1gtbjNy931fnzADLuB6JEKWRgyD4BDSg7U31Jry8CeQA
 WIXQ/c9cbda8CTIqoZA0P+YmfbHVaCCUdpE4yHxZu4MSIPLaITRBK6Q6hqONK6Zv3YyJ
 axbfCPuYeee6K3RFUklegzWtdWGG26THQwuRppERHBdX7A9IUZWxbcImKcXoLYTFyBeW
 7s7Mr/j3ZHjb/lm7dYNoiYkfKEcIZZJB+gxDERUQqnOh85O0rcVqU4vQiGskcXBcZfQU
 YxUdXPx32vcFgLPX1e4D44ui3QiwGkBPoVvJW8BYX36q/26E34oy+SQ3j2v8oVVMpbbc
 xTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783350085; x=1783954885;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5cs9fY76ZfcTUxH8Y7Yp1VT4qqPd2PXLsGA+gsbgSd8=;
 b=tWqRb6Esc8M6QAil36fmIcGw8ivM89MtSSnlHfZLMpJe6CH5vtXqy2u9AQrDdD65ma
 ChrnMblsyzB7lcOEFXO+spCiz7AmJ6SOC/4/JbmFOzjXzeYMJwcdcbajBYTrYzHmXrJy
 qpBqf3BsBbstBsV3WmTj/6WzekIAj1ZWfLSiLcrAiS3+Ac5KSxG2k3xuuSiUQ2h+EsT7
 7HwJKJp5rGIWn22LYZudv4Eq++d189T6FKPNyMAtkkFgTke6mETF6fFvPidTHDDaLfDu
 iPY+DOIHXep2tJ9yc03/1WSTpLVL2KBcktfRpypbaUN0Xv3Orj1SuLdJhwcsSOwwROE3
 Diww==
X-Gm-Message-State: AOJu0Yy4otW/fpXeONq8xfQTMBTJ0nXxs45He1t+13k+Lqb7cH2wP2k1
 bASZV2afWIqGjU21GW+LPR44CsF6dId1LDh4xKvCaAwkPscYgc4ugIuY3REUz4EyewLFmz6Oo52
 xD6N2D3cdl1SIDtR/P96EKc7buR1/Jng=
X-Gm-Gg: AfdE7ck1Z4pfbHk95XeBM6BCozIpReNmkPYlo4oeoG1vAMG1hUp0PejTVmICH5ul5BF
 Eju/xBG3nuz9N79yELo27mZeC1Xr5ZgPvZi6py0sF9FpWENkZezfvnq4t+ECcVykecR/Xlkx6Gt
 NFsj+4ShPD2KfIrYYq8JargNL34VjdaI68RcNzSglMqSGVcIECd7C2ypHJsYnbRj+CAqOaL1ECu
 Nl/mrtFWABwta3/yn+Ya/VCeu8Kk8oQdsQlw7khJoT1O20VDkL98a+B0WPx1gfouFbSJ5ikjMSq
 zw/GstBzInQdVs14bxm+Nkag3FhLReMjOC0i014RrXjPp758x827nZ4M9P0=
X-Received: by 2002:a17:90a:d406:b0:37f:ea8e:ab79 with SMTP id
 98e67ed59e1d1-382802bea9emr6565538a91.2.1783350082413; Mon, 06 Jul 2026
 08:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260618204550.753250-1-alexander.deucher@amd.com>
 <20260618204550.753250-2-alexander.deucher@amd.com>
 <CADnq5_PNXLwpcZCHF+q9ZLMgHwq5DWK=Z6BzR+VRGi9KPUE=9Q@mail.gmail.com>
In-Reply-To: <CADnq5_PNXLwpcZCHF+q9ZLMgHwq5DWK=Z6BzR+VRGi9KPUE=9Q@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jul 2026 11:01:09 -0400
X-Gm-Features: AVVi8CeiLV22klSE0MoShO1REDqodAKafxtmMIQ0RqI00pIUN_pl2abNiqF_sQA
Message-ID: <CADnq5_M1A9b5D-L8U6cc5DXWOCSh8+neNuBvBrofJMGPkZV64w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: update mmhub 4.2.0 client list
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping?

On Mon, Jun 29, 2026 at 4:27=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Ping?
>
> On Thu, Jun 18, 2026 at 4:54=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > Update to the proper client list for mmhub 4.2.0.
> >
> > v2: fix typo (Alex)
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 65 ++++++++++++-----------
> >  1 file changed, 33 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/dr=
m/amd/amdgpu/mmhub_v4_2_0.c
> > index 49b7f16a941f6..5827c758b373d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> > @@ -36,40 +36,41 @@
> >
> >  static const char *mmhub_client_ids_v4_2_0[][2] =3D {
> >         [0][0] =3D "VMC",
> > -       [4][0] =3D "DCEDMC",
> > -       [5][0] =3D "DCEVGA",
> > -       [6][0] =3D "MP0",
> > -       [7][0] =3D "MP1",
> > +       [2][0] =3D "MPNHT",
> > +       [7][0] =3D "MPIFOE",
> >         [8][0] =3D "MPIO",
> > -       [16][0] =3D "HDP",
> > -       [17][0] =3D "LSDMA",
> > -       [18][0] =3D "JPEG",
> > -       [19][0] =3D "VCNU0",
> > -       [21][0] =3D "VSCH",
> > -       [22][0] =3D "VCNU1",
> > -       [23][0] =3D "VCN1",
> > -       [32+20][0] =3D "VCN0",
> > -       [2][1] =3D "DBGUNBIO",
> > -       [3][1] =3D "DCEDWB",
> > -       [4][1] =3D "DCEDMC",
> > -       [5][1] =3D "DCEVGA",
> > -       [6][1] =3D "MP0",
> > -       [7][1] =3D "MP1",
> > +       [11][0] =3D "JPEG0",
> > +       [12][0] =3D "VCN0",
> > +       [13][0] =3D "VCNU0",
> > +       [14][0] =3D "VSCH0",
> > +       [15][0] =3D "LSDMA",
> > +       [32+5][0] =3D "MPRAS",
> > +       [32+6][0] =3D "MP1",
> > +       [32+7][0] =3D "MP0",
> > +       [32+11][0] =3D "JPEG1",
> > +       [32+12][0] =3D "VCN1",
> > +       [32+13][0] =3D "VCNU1",
> > +       [32+14][0] =3D "VSCH1",
> > +       [2][1] =3D "MPNHT",
> > +       [3][1] =3D "DBGU0",
> > +       [7][1] =3D "MPIFOE",
> >         [8][1] =3D "MPIO",
> > -       [10][1] =3D "DBGU0",
> > -       [11][1] =3D "DBGU1",
> > -       [12][1] =3D "DBGU2",
> > -       [13][1] =3D "DBGU3",
> > -       [14][1] =3D "XDP",
> > -       [15][1] =3D "OSSSYS",
> > -       [16][1] =3D "HDP",
> > -       [17][1] =3D "LSDMA",
> > -       [18][1] =3D "JPEG",
> > -       [19][1] =3D "VCNU0",
> > -       [20][1] =3D "VCN0",
> > -       [21][1] =3D "VSCH",
> > -       [22][1] =3D "VCNU1",
> > -       [23][1] =3D "VCN1",
> > +       [10][1] =3D "UTCL2_NHT",
> > +       [11][1] =3D "JPEG0",
> > +       [12][1] =3D "VCN0",
> > +       [13][1] =3D "VCNU0",
> > +       [14][1] =3D "VSCH0",
> > +       [15][1] =3D "LSDMA",
> > +       [32+3][1] =3D "DBGU1",
> > +       [32+4][1] =3D "DBGU2",
> > +       [32+5][1] =3D "MPRAS",
> > +       [32+6][1] =3D "MP1",
> > +       [32+7][1] =3D "MP0",
> > +       [32+8][1] =3D "IH",
> > +       [32+11][1] =3D "JPEG1",
> > +       [32+12][1] =3D "VCN1",
> > +       [32+13][1] =3D "VCNU1",
> > +       [32+14][1] =3D "VSCH1",
> >  };
> >
> >  static int mmhub_v4_2_0_get_xgmi_info(struct amdgpu_device *adev)
> > --
> > 2.54.0
> >
