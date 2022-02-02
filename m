Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CEBC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Feb 2022 16:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044B910E2F6;
	Wed,  2 Feb 2022 16:09:43 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A199810E2F6
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Feb 2022 16:09:41 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id t199so23904474oie.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Feb 2022 08:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v/QTQPcEHdpWqaFG7eNmMHvHsmhoC733KhMGO02MkRA=;
 b=euOGYUSqjJh9ft+zR7Cy55DhXPCAvtD0Opq//voqrIUE3lilO4sgBHHC0QHF5Amzs9
 Ozyzxp1FoE5hAZzbn2o0+yiBqJ2+14LQz2KtM8P6hPXAHuxn/Ur5sQnwWWsL/jiRfc9C
 8rn6sRA0A/+iFdL9jU8xoxa+f2V9A/whs4hvqAh9oR/4bCfQQ3mbULa5tYG9dmzKgIfZ
 yDpxl6vkv0l3JgsYTEg9vZLzoTVJenCARFyMnHFL95uR0IBZEexYQxFrurk6Uw5bt1U+
 tDXnC/WVXtII+Xp2LlnR9qD3iQrfqqtNSENHqDS+IXMMJTzHvdwhSDjSpoTAfiSxk/77
 44fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v/QTQPcEHdpWqaFG7eNmMHvHsmhoC733KhMGO02MkRA=;
 b=N3YuXfuVxSnZ3q7UtBIx1Q+U8wfdBdWTjpIK2cC38eZcDGiAhstcK7vvyuiNsi7b4z
 qkdXMD3PY03CvEpg+9QD7vtsHANfdoHz1a7rSofgIzJinxpcp9lyYrT1fQUc1awnwh2s
 WZxkSOaAmuz8PVCZazEcOyomlE4bLQk5TBG8bYLK4bDK21bUlPduNPNlg4hd9IHh+0kV
 /EvcgU6E2xkS15rfPH2RZUreqmv07ZKtVR/Kr3XkGLzBsw62b9a6uFR36wlGjkeyKt/U
 J2Ujp0Pat9dYmVzsHMK9tT5HJLn1tYdw87zu8SNBJq1GFO7h/2GfoMk6LJjsebDVOJb7
 qAKQ==
X-Gm-Message-State: AOAM532rL5IYGFClwYqrlja+lQP5gjSuHRpG/WqkNymgVGPSCFob30Lg
 tfpq621aj0R5Ks/LIrsR8CZ+qhkjxxJUz7An+HwMPMn3
X-Google-Smtp-Source: ABdhPJxbzXH32rDdVPMTHKHbojDiXAYFbiujjtOAYwClFMKVtkYHh4lOEo7M0YkD6iFdLxPIVYQlbFTm6baEwqZmD44=
X-Received: by 2002:a05:6808:159e:: with SMTP id
 t30mr2614344oiw.132.1643818180842; 
 Wed, 02 Feb 2022 08:09:40 -0800 (PST)
MIME-Version: 1.0
References: <20220202090644.1031115-1-rajib.mahapatra@amd.com>
 <CADnq5_OhwAXQgNFAmavobSbYEyv6CJ2XeKQ6etot=VqHuGnCjQ@mail.gmail.com>
 <da52e706-ea62-8362-f658-7d34e0ed0e31@amd.com>
In-Reply-To: <da52e706-ea62-8362-f658-7d34e0ed0e31@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Feb 2022 11:09:29 -0500
Message-ID: <CADnq5_NVE7_YMxZ0XY6TXpJCx5qj7-jpxE6UNveqO1iZBA5-Dg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: skipping SDMA IP suspend for S0ix.
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Rajib Mahapatra <rajib.mahapatra@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "S, Shirish" <shirish.s@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 2, 2022 at 10:29 AM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 2/2/2022 08:16, Alex Deucher wrote:
> > On Wed, Feb 2, 2022 at 4:07 AM Rajib Mahapatra <rajib.mahapatra@amd.com> wrote:
> >>
> >> [Why]
> >> amdgpu error observed if suspend is aborted during S0i3
> >> resume.
> >>
> >> [How]
> >> If suspend is aborted for some reason during S0i3 resume
> >> cycle, it follows amdgpu errors in resume.
> >> Skipping SDMA ip in suspend solves the issue on RENOIR
> >> (green sardine apu) chip. This time, the system is
> >> able to resume gracefully even the suspend is aborted.
> >>
> >> Signed-off-by: Rajib Mahapatra <rajib.mahapatra@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
> >>   1 file changed, 10 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> index 7931132ce6e3..f01b1dffff7f 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -2927,6 +2927,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
> >>                       adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX))
> >>                          continue;
> >>
> >> +               /* skip suspend of sdma for S0ix
> >> +                * Resume has issues if the suspend is aborted during S0i3 cycle.
> >> +                * Skipping sdma for RN/CZN/BRC chip - green sardine apu.
> >> +                */
> >> +               if (adev->in_s0ix &&
> >> +                   (adev->asic_type == CHIP_RENOIR &&
> >> +                    (adev->pdev->device == 0x15e7 || adev->pdev->device == 0x1638) &&
> >
> > The check here seems to contradict the comment above.  Is this all
> > Renoir based APUs or just green sardine?  If it's just green sardine,
> > you can check the APU flags rather than the PCI ids.  E.g.,
> > (adev->apu_flags & AMD_APU_IS_GREEN_SARDINE)
> > Also move this to sdma 4 code as Mario suggested.
>
> Both RN and green sardine share the same flows for SMU, I would think it
> should just be match (adev->in_s0xi && (adev->flags & AMD_IS_APU)) when
> it's moved to skip suspend.

The SDMA 4.0 code is shared with Raven1/2 and Picasso as well.  We
should verify that it's required for them as well.

Alex

>
> >
> > Alex
> >
> >> +                    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
> >> +                       continue;
> >> +
> >>                  /* XXX handle errors */
> >>                  r = adev->ip_blocks[i].version->funcs->suspend(adev);
> >>                  /* XXX handle errors */
> >> --
> >> 2.25.1
> >>
>
