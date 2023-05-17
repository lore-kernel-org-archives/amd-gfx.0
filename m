Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA07C77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 12:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 805A110E135;
	Wed, 17 May 2023 12:24:31 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F110310E135
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 12:24:28 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-552b65f527dso334443eaf.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 05:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684326267; x=1686918267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBsmQ3PKaQa8WpXcsh4hYcW8zy1CuUBpLxYXMdrkgj4=;
 b=LaMcsVHWtOT8lQU64Z+1wIy6bW58sV9gyhhjGnR7PKTSqAP7r7X/o+a0ZrphunKzCs
 rUqTh7juE5KIybsXqlB7BnZAFEQk1/zzb7zyr8pRYWJ2Wbbrw6Xifo1N9cVrAfbbEXyu
 lnfWKAKATqsJdLunv/bt4wL2tLtOH6BuBo+aja0gpkNURqkLd6jpiW2Rt7TDG2I776RR
 itUwFEEGPaa/JaBqO77PLKb2X9AwaTROf1OQu6IkCx98La74NBc9wMTLr9WmRkt+VlSK
 t6cP6Io0LwGRk0btneEYbtTmKpKoMS0NP5tAEVRW0f7XzSGNial0LcfoKGZBp6OPn9fE
 Mp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684326267; x=1686918267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vBsmQ3PKaQa8WpXcsh4hYcW8zy1CuUBpLxYXMdrkgj4=;
 b=Cn53U+rNEVCLK54wW8tQ0WcAlIQferQ7pzVbpU4GScGTO4dBCKW4lPBB3ZwcYEB/vo
 BWoAKWBkaGTpOewIVGCBN3kLA8ByKGEVlKxYQheI6JrGh7sWsbQX9ni9Agqj43DesKwh
 JrZTM3RdIRt/Dw0D2+W3Tkj94ITgFB5jwVJpQR4F2ikSpvfr3iHYeNp5Kf+31Xwhi9oa
 JsgDh/L/UvXjEayGiTrFM36ylWKn06tF9PwWfxE/qDoKBFfZ8Pl5jc4MdofnpaBNgHVo
 yQ3eQJCe//x7V08SNZ6C8z8whFbUOCKKX0BuadK9jZEw5lfocpk6OeMld4Vc0LGxgLid
 Pwqg==
X-Gm-Message-State: AC+VfDxxYYEsrNPP8+rZSEqnNCL9iTZvTW5rhifY/nZ/9pzoQ8yY00h2
 PQ/WFIm9tptmme3qNJatq1bMc9y/NN6moRmJ/8NOPZVVkxE=
X-Google-Smtp-Source: ACHHUZ7gkqFN4dGC+uk1j753eAmCWs5Dc0mzTWMcajo1NuzwolPIPCfwRC/8UnIx6ZPR7ZhbSLzkQuAheaaIlpFl9EQ=
X-Received: by 2002:a05:6808:1289:b0:395:f6da:1b5a with SMTP id
 a9-20020a056808128900b00395f6da1b5amr7012333oiw.39.1684326267683; Wed, 17 May
 2023 05:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230516175214.3491-1-mario.limonciello@amd.com>
 <20230516175214.3491-4-mario.limonciello@amd.com>
 <CADnq5_OH5vRico9MuegyEAM2SfQchdiXVgCSRLdf6jYmhTYO+A@mail.gmail.com>
 <fb607620-cbf4-e6fe-be24-aad12f530f66@amd.com>
 <CADnq5_N0Z=HzGZA_wXaDrXjYRMOSneOkmbcRnvguOUdLjAinKQ@mail.gmail.com>
 <207c617e-79b4-b5fe-c565-a9cd733b1bbf@amd.com>
In-Reply-To: <207c617e-79b4-b5fe-c565-a9cd733b1bbf@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 May 2023 08:24:16 -0400
Message-ID: <CADnq5_Pr5VNKKcg1avhn1PYCfcWE-tNF33rv5ozAdzMDrRmtgg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd: Add safety check to make sure RLC is only
 turned off while in GFXOFF
To: "Limonciello, Mario" <mlimonci@amd.com>
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
Cc: Tim Huang <tim.huang@amd.com>, richard.gong@amd.com, Juan.Martinez@amd.com,
 amd-gfx@lists.freedesktop.org, Mario Limonciello <mario.limonciello@amd.com>,
 anson.tsao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 16, 2023 at 10:23=E2=80=AFPM Limonciello, Mario <mlimonci@amd.c=
om> wrote:
>
>
> On 5/16/2023 4:57 PM, Alex Deucher wrote:
> > On Tue, May 16, 2023 at 5:50=E2=80=AFPM Limonciello, Mario <mlimonci@am=
d.com> wrote:
> >>
> >> On 5/16/2023 4:39 PM, Alex Deucher wrote:
> >>> On Tue, May 16, 2023 at 2:15=E2=80=AFPM Mario Limonciello
> >>> <mario.limonciello@amd.com> wrote:
> >>>> On GFX11 if RLC is stopped when not in GFXOFF the system will hang.
> >>>> Prevent this case from ever happening.
> >>>>
> >>>> Tested-by: Juan Martinez <Juan.Martinez@amd.com>
> >>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
> >>>>    1 file changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/dr=
m/amd/amdgpu/gfx_v11_0.c
> >>>> index dcbdb2641086..f1f879d9ed8d 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >>>> @@ -1766,6 +1766,10 @@ static void gfx_v11_0_rlc_stop(struct amdgpu_=
device *adev)
> >>>>    {
> >>>>           u32 tmp =3D RREG32_SOC15(GC, 0, regRLC_CNTL);
> >>>>
> >>>> +       if (!adev->gfx.gfx_off_state) {
> >>>> +               dev_err(adev->dev, "GFX is not in GFXOFF\n");
> >>>> +               return;
> >>>> +       }
> >>> This should move up before the RREG above?  Also, I think it would be
> >>> cleaner to just not mess with the RLC in S0i3.  Can we just return
> >>> early in smu_disable_dpms() for the APU case?  All of the DPM feature=
s
> >>> are controlled by the SMU so that function is mostly a nop of APUs
> >>> anyway.
> >>>
> >>> Alex
> >> That was what the original attempt did when we first identified this i=
ssue.
> >> Unfortunately though just skipping RLC (without patches 1 and 2) means
> >> that GFXOFF still either doesn't get toggled at suspend entry or isn't=
 fully
> >>
> >> off at suspend entry.
> >>
> >> This leads to the graphics core behaving erratically upon resume.
> >>
> >> So if you're OK with patches 1 and 2, I'll adjust patch 3 to also skip
> >> RLC for
> >> APU.
> > Sure.
> OK, let me double check RLC skip and I'll send out a v2.
> > I wonder if we need something similar as patch 2 for other APUs?
> I expect patch 1 "alone" to help Renoir and Cezanne hitting a similar
> circumstance.
> For Rembrandt and Mendocino, they don't have IMU, so what would you poll?

For older chips, mmPWR_MISC_CNTL_STATUS (smu10), mmSMUIO_GFX_MISC_CNTL
(smu12).  See smu_v12_0_gfx_off_control() and smu10_disable_gfx_off().
It looks like smu_v13_0_gfx_off_control() doesn't wait for gfxoff like
the other functions.

Alex

> >
> > Thinking out loud here, I wonder if we shouldn't just return early in
> > the top level suspend/resume functions for S0i3.
>
> I think this can make sense for GFX10 and GFX11 maybe, but as it's alread=
y
> bifurcated I think it's probably better to do case by case basis.
>
