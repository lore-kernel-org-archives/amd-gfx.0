Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCF9CA6007
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 14:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AF1010E092;
	Thu,  8 Oct 2026 14:17:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bCaKTjX4";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE9B10E092
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 14:17:31 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-35179d0747fso56899eec.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Oct 2026 07:17:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791469051; cv=none;
 d=google.com; s=arc-20260327;
 b=LEqs6CTZ/RKMspTNLPrp/FX4gC57kTgGdUcV1XAqNa3WCXfElQj1vIHrX70U290XAr
 MY9aBKbMtpGDN1IuhzV04zNOekz6bw7W+UINXBDMvFu3IslMiO8Fas/HtZFt37AV+mHo
 mc2IvyPiQel9QoC5/0fRo3EVFTu+qxqZicbEbN7ysLit3vmxExFh5HSCx0fTKPTwDinp
 FXcLIdgkCpOFZnibl/r+bhbuwnXDjMSdaztMJvQAl3FPNvCdgBbtiPp9i3sq2Ir9DmTM
 ionPKReoafcwrrqK6ZXFc4N4CUrL4lx+USAx/pwHZELHS4oQbXHn9p5s7y5prXSI8EYu
 G27Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KDb7cAKDvbzwZi7ebR+v1AmBrrZjRmurUspT1IHBNTw=;
 fh=BB64UYH3LKZLg6FCw8YE6OdNd9pDx+/0a9bd9c+atp4=;
 b=Kk5zwhEKpoh6Ns2FyjP7W6Fp6rbf1TWM2BEqAuaWWJfK25zeM3Oe+91BISEqho0rRD
 x6Bu4CGN2tFIq8AAV28RqbcS+220QCvA9mbl1iyspIC4b/sFkFLKpUepkQZzCf7+ynPV
 bykrr+oDI9rhxDusplJ7l3Sogjb3jFrMBHCtxB7aDWhTNAQlvC30mu7aAj+mX++eQsd8
 zx5m/BpfavlYmO6HOjDDCknD49lcJ/VU/0mY4tfpd0OVTmaN9ZlLIrsXheKTGZdVxy4O
 Tlw/whyo6GFt2uswfRKRnBznhcBJOta+9ZNayZ3wkHF7R+urDpJ1PPsqNXm/ABIKyNsW
 NUbA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791469051; x=1792073851; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KDb7cAKDvbzwZi7ebR+v1AmBrrZjRmurUspT1IHBNTw=;
 b=bCaKTjX4Y3VC6Au5Ig2J8OGrcbbCNCMWAQCihegxVfP07NumNtHfQ+Ct1JwxIfa9mg
 ODB2zQCgNhcJUMP+7yaXhCXHDvd08IbvK8khGYMYYeJr3xhaVhvl4QXkqCZuKUHAdE2S
 NS9+8IGJMU0CEopdeWcim1oMCrLvvXDlEzLscn+fl9YA6dDGd6aPXll+nlK4r4S+w/Wd
 1HXeTHe+FNNh4IggjEchE8CvCQuUi3K3Eubt1vc3sGxgSLx3n3/k9mym3fpJ2XVuVaKt
 XuMpMqBQ4SW4yCcaCLuK3rAexsK5ix3bfQr9rDcTO/OhDZiC6z5wKoUXZzyBgEWTPq+c
 RRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791469051; x=1792073851;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KDb7cAKDvbzwZi7ebR+v1AmBrrZjRmurUspT1IHBNTw=;
 b=Dso+TlxWYzJk9huCwVknc4xbcO8x0xcae5b4t0I30+NGrro5opKqFvC0B2yf3hO/3u
 y+lKp0Q1MxB2sG4MGadBSC3W5qS87H+r2Pj5dYAHbLP8ewPHFnWVPnBTikFTOBplNpAM
 Cv3uZxFLqXw942xbGhKHWwWyHS621Pj92aiUWzUJFW6WVJn2RrI8UtSbxVIjKlMAcoOB
 +qMPx0HRdI9nXDw8E8AQx+CjH7Hlj/tYiQA9WHXn4Q4aTICmwNwPJwHBjnfglk0fA1cj
 p1ONAYZdW47DBCMNMaiXQBY1exgiCzslHdM6DXB4uXgazMm9e36bVI8h3rrIj58s1m7I
 Kq6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3lBLIHhhC1kdNaGU8fcd8i8mjfgwPjSTteEnJryHUPmJgdJo4y6i0uk7d0fjclD9axHWYzm8/@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIRcKfRrAacq5WADbBkhwlHIbyQ+IG93C8b0qSkA2S8D9roI9yo
 8DV2Wm4BDo8+UKsnE0Vca3h0uqanqDuSB/G/4eH7ERDLjkCxODuAaXLGe3OGMJjs6Cd6wmUmeTz
 IknwXmycCU2Sncsn8AS4YBe5X6OElZ5c=
X-Gm-Gg: AYBFou3NylibJyBTEQ9WmoyjB/iVBX+a22iannA+vUS5ugWp3SNj1/MjyQzg1d17zgK
 jdGxNCA8LpQEI5xkTCdqO1PZCW3+RNRNGxux4OSQoBQuXb2KA9bEA28RQrJj0uw3xr+27aSho+p
 6U9vpAlsM3V4ceLGgeT/w+enKppBpMshlqJbdNzgKDG4UZBcTzuxUQwwtBZ0wiZJdwS0mQOg28O
 ZcJBiPDwE/HkuKFuJlf4zJIHpz/DTi4kcg8TgKliyLEOGaxf7aECiM0t3VtZgYlbGdn7/M70EY4
 J5kMuzu90odBybO2sLqp6F7nFS6JdIrdNYndIaWfWS/B0LFmrqOgn5EDM1dPElFs0SwwMbLDCrf
 mMFE2GINzIT3zeKSzgdh9ynP5dn9utzWW6nzmKVh7lA==
X-Received: by 2002:a05:693c:630c:b0:351:d38e:6c0a with SMTP id
 5a478bee46e88-351d38e6d5cmr3014494eec.0.1791469050804; Thu, 08 Oct 2026
 07:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260831150211.1486154-1-sunil.khatri@amd.com>
 <CADnq5_Mz1KrT70mLEbJ4EqikmFGGRiJLXXEWF++pfu2LQC+wQQ@mail.gmail.com>
 <DM4PR12MB5152CAC197B2A15B4D43596FE3932@DM4PR12MB5152.namprd12.prod.outlook.com>
 <622cc749-f196-404f-b130-8c909b69d1b6@amd.com>
In-Reply-To: <622cc749-f196-404f-b130-8c909b69d1b6@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Oct 2026 10:17:19 -0400
X-Gm-Features: AclHuK9Jy1XA6QUgIJ6eYWYlzpqKmyAT4ntBm8C_N80Oj-WMWZK8zBaZ10qbbXg
Message-ID: <CADnq5_O0CjqLNvQZX6VQYzyXWpdsJNHoJ6QNj_uqXdbjoPntGg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] drm/amdgpu: update the fw version for gfx11
 userqueues
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Khatri,
 Sunil" <Sunil.Khatri@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Thu, Oct 8, 2026 at 6:09=E2=80=AFAM Khatri, Sunil <sukhatri@amd.com> wro=
te:
>
>
> On 08-10-2026 01:36 pm, Zhang, Jesse(Jie) wrote:
> > AMD General
> >
> > Hi Sunil,
> >
> > Could you please help confirm whether the firmware version check in thi=
s patch is correct?
> >
> > For example, the latest gfx11 ME firmware version I can see is 2550, bu=
t the patch requires me_fw_version >=3D 3090. That's quite a big gap, so I'=
d like to make sure these thresholds are intended for gfx11.
> >
> > I also noticed that the new values (ME 3090 / PFP 3190 / MEC 3450) matc=
h the versions in our recent gfx12 (navi48) CP firmware builds. Could they =
have been taken from gfx12 by mistake?
> >
> > If these numbers are correct, could you let me know which gfx11 firmwar=
e release they correspond to?
> I see the same fixes merged for gfx11 too, i did not validate on gfx11
> myself but the assumption was to have that same version... probably i
> might have made a mistake not confirm on gfx11 target... I would say use
> the brahma utils and check the fw version on the target and update the
> patch ....

They use different versioning.  Please double check the correct versions.

Thanks!

Alex

>
> Regards
> Sunil Khatri
> >
> > Thanks,
> > Jesse
> >
> >> -----Original Message-----
> >> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ale=
x
> >> Deucher
> >> Sent: Monday, August 31, 2026 11:13 PM
> >> To: Khatri, Sunil <Sunil.Khatri@amd.com>
> >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> >> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> >> Subject: Re: [PATCH v1 1/3] drm/amdgpu: update the fw version for gfx1=
1
> >> userqueues
> >>
> >> Patches 1 and 2:
> >> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> >>
> >> On Mon, Aug 31, 2026 at 11:02=E2=80=AFAM Sunil Khatri <sunil.khatri@am=
d.com>
> >> wrote:
> >>> Update to the latest stable fw versions where userqueues is working a=
s
> >>> it is expected with major fixes.
> >>>
> >>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++----
> >>>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >>> index d704ce328e6e..2c160ec9dc57 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >>> @@ -1655,10 +1655,10 @@ static int gfx_v11_0_sw_init(struct
> >> amdgpu_ip_block *ip_block)
> >>>          case IP_VERSION(11, 0, 2):
> >>>          case IP_VERSION(11, 0, 3):
> >>>                  if (!adev->gfx.disable_uq &&
> >>> -                   adev->gfx.me_fw_version  >=3D 2420 &&
> >>> -                   adev->gfx.pfp_fw_version >=3D 2580 &&
> >>> -                   adev->gfx.mec_fw_version >=3D 2650 &&
> >>> -                   adev->mes.fw_version[0] >=3D 120) {
> >>> +                   adev->gfx.me_fw_version  >=3D 3090 &&
> >>> +                   adev->gfx.pfp_fw_version >=3D 3190 &&
> >>> +                   adev->gfx.mec_fw_version >=3D 3450 &&
> >>> +                   adev->mes.fw_version[0] >=3D 147) {
> >>>                          adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D
> >> &userq_mes_funcs;
> >>>                          adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D
> >> &userq_mes_funcs;
> >>>                  }
> >>> --
> >>> 2.34.1
> >>>
