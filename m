Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DD5C77B7F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 21:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D8BC10E129;
	Tue, 16 May 2023 21:57:37 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD92F10E129
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 21:57:35 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-39446801ca6so113150b6e.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 14:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684274254; x=1686866254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jgc42XrU4hn3+hD8zYA6/0yzAG6UzchdV7Eq7NzcAc=;
 b=eD5bjuOvU7a+zaxi/4BWzVyQMb4VQLHUoFoNLZo4hB7dfdyuNchian28XO8QOAHkNn
 B3sicis2Wgo+nW0dmffTPma3ANTrZYXrSub7pnXWZzSM7f/bLYdqJ4SpNrir5uaQDmmK
 8LvUnNBSSl2v0wVJaQfHN44ECTgkSLj8arBThX/02soG9RUb2S9GSNeBR8dnnBJ3LkOh
 HlBtczKGkin1iW/+Xhbv61A3DHxq6Ucq0N70U/Fd2yQBFswly/7M4mg/S50d6NP4csdQ
 yY/YJplmMcbnvFJLV5G3UiPlg0XZv3RKONscTDJxBsBjdY1/3B3Xd6eNnYtfdt8lHo0G
 5gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684274254; x=1686866254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jgc42XrU4hn3+hD8zYA6/0yzAG6UzchdV7Eq7NzcAc=;
 b=Njd256V16JDMlKdSWt62bLIIBPDo5951LwTGeD3WgQK+FQnRlWGybD5jZa1srsiytp
 9LydVj5xsJJjR34WuhI9iGqHaTZsRy0Piv2TiGNfSyG0CxFNCW/OXRujIw86xebP0W40
 HzhVTrJpwnUgoQcPG8N3y9jrn6/o9KDS2w/Ck2L56T4JFGgpu9c6fUovffmLhJZbFqim
 WOnpDDDTfeOZT/69mu8OQ0TajDt3t+NtDJbL+kwUUQYTH1/arjBhDfBikaKvGr1VBus0
 IBIVaeykICL6Y6Rrm6HNJB8s3KI4H/5wUF2roTAmo3DPKqVxtNkdIv0x7/HwCu5FHRoV
 B49A==
X-Gm-Message-State: AC+VfDyuZyplCVkNg2IQzwbVfu8iDCRCr9ksuhW2FJcPzNR40FVji8U/
 vK3ytb4vhYvVljCWfL4lLiQAHHjOPR3umsXwj4861nn1
X-Google-Smtp-Source: ACHHUZ45W9NL5LAeXJYPLvePWxN/nsKTiBNLcpDAG7fV5GZozgSYHAOAxn+UaPdFA/5DnGLvGE3hKS0buRZNPZiIh0o=
X-Received: by 2002:aca:2118:0:b0:394:292c:b77d with SMTP id
 24-20020aca2118000000b00394292cb77dmr11800587oiz.53.1684274253732; Tue, 16
 May 2023 14:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230516175214.3491-1-mario.limonciello@amd.com>
 <20230516175214.3491-4-mario.limonciello@amd.com>
 <CADnq5_OH5vRico9MuegyEAM2SfQchdiXVgCSRLdf6jYmhTYO+A@mail.gmail.com>
 <fb607620-cbf4-e6fe-be24-aad12f530f66@amd.com>
In-Reply-To: <fb607620-cbf4-e6fe-be24-aad12f530f66@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 May 2023 17:57:22 -0400
Message-ID: <CADnq5_N0Z=HzGZA_wXaDrXjYRMOSneOkmbcRnvguOUdLjAinKQ@mail.gmail.com>
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

On Tue, May 16, 2023 at 5:50=E2=80=AFPM Limonciello, Mario <mlimonci@amd.co=
m> wrote:
>
>
> On 5/16/2023 4:39 PM, Alex Deucher wrote:
> > On Tue, May 16, 2023 at 2:15=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >> On GFX11 if RLC is stopped when not in GFXOFF the system will hang.
> >> Prevent this case from ever happening.
> >>
> >> Tested-by: Juan Martinez <Juan.Martinez@amd.com>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v11_0.c
> >> index dcbdb2641086..f1f879d9ed8d 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >> @@ -1766,6 +1766,10 @@ static void gfx_v11_0_rlc_stop(struct amdgpu_de=
vice *adev)
> >>   {
> >>          u32 tmp =3D RREG32_SOC15(GC, 0, regRLC_CNTL);
> >>
> >> +       if (!adev->gfx.gfx_off_state) {
> >> +               dev_err(adev->dev, "GFX is not in GFXOFF\n");
> >> +               return;
> >> +       }
> > This should move up before the RREG above?  Also, I think it would be
> > cleaner to just not mess with the RLC in S0i3.  Can we just return
> > early in smu_disable_dpms() for the APU case?  All of the DPM features
> > are controlled by the SMU so that function is mostly a nop of APUs
> > anyway.
> >
> > Alex
> That was what the original attempt did when we first identified this issu=
e.
> Unfortunately though just skipping RLC (without patches 1 and 2) means
> that GFXOFF still either doesn't get toggled at suspend entry or isn't fu=
lly
>
> off at suspend entry.
>
> This leads to the graphics core behaving erratically upon resume.
>
> So if you're OK with patches 1 and 2, I'll adjust patch 3 to also skip
> RLC for
> APU.

Sure.  I wonder if we need something similar as patch 2 for other APUs?

Thinking out loud here, I wonder if we shouldn't just return early in
the top level suspend/resume functions for S0i3.

Alex
