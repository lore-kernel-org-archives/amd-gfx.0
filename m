Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C606CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 15:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D568110E124;
	Wed,  8 Oct 2025 15:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NkAP6ARa";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5074010E124
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 15:40:22 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-b62ce661342so263396a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Oct 2025 08:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759938022; x=1760542822; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wjhPCNjjPmw0vlWQXC8t+3BMXqrZ3TzRvKzgCdFFvRg=;
 b=NkAP6ARaEisajPDumfL3iwT+ZtS+KLFMHw/JppwJYSeFeYdTd9kmKYLyZvfLq7LFlG
 +LU+vlI/W2MjYrA6FryAgLrXIeenQP7Oim5B1dAzJDOJhy7XLLl8pZqv4yQU8af7UJW9
 jQVnT06jWJlmtNzbT/lLUE6NCow9mnBPrmc/YOmZPJaMxjThbifl7IGoW1eH0vYloMgu
 1w/Y5tuL8LKQaW5LCvzf/ZRGY6KSPDtX50rvnIbLe1Zc5Wcs5f6oRs8/eUlqy6GgtOeq
 G+wNKigTg3SLOtfpwiipAUhmBpuSs7qArHPXH+THkPI0lI1YShQtLP36o2aLgqvZTynY
 ibvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759938022; x=1760542822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wjhPCNjjPmw0vlWQXC8t+3BMXqrZ3TzRvKzgCdFFvRg=;
 b=ns79s/JkD8PW5O9l4BiH/U6cVNqGduuuGHyn8r3POT9q3gGr4jBrEVL07R2HE/YMa3
 IaiCJzh8QkgmVw7OcdVMIENDbS7P44i0advqy9WZs8p285oc5NGwc4FbUE5I4lnB+sxc
 vYGOePpFSqyVSTb3R1f2I2vQ834af527JiXjqEdneBDPbhGvwrj6w6xFKr1aGmKVUlvm
 aJw/TXoHgjs8QDm9n+V8/e2zb1S2xlyeKHDM2debjkMKycrVKwf0Bjnj4lve3SLWd8Kk
 xkv65jzOsvjj/t+ENmcZA83UA7b4QoLbuHV2tVlsEklo2mG/0cnxEv+zQ3TPQEEtj2Zk
 ZRQQ==
X-Gm-Message-State: AOJu0Yy4H8CIZR3gJ+wCooVUplww32/YMLOvmKyNH5bhlPm5tkHsuoav
 Ko7Pim3SeqDg06oY/wZuXUooYaC6MLHve7wE34DVtT39ZAHwlC8g8BTiZho0MbcWu5UFvjrn/Um
 CMZXbICs7yn7z6dcMjC3039Y4ThhcrZizkA==
X-Gm-Gg: ASbGncvbFJ+OanmHP5cmzB1TVhgPZVYH89tlxDhQxKC/7hUZXgKdMY2Pmx2eWxsVo6E
 a5X20sLUx9ryXCHiGl6SO8FAX4NpBIRS3A/B0Dw4ooK20fBCFjUm+NyIPblhNk1eOahrhhrGfKX
 zsIaG6RZfH0TyAWsIq1dAeen/st5oGtXEnAdBeleXl7yh4KYk7FD4OsqHZnuYaWxHcYViJDtaUf
 tY+/PAlzEtEXrW9z4mChibkUwMZIhA=
X-Google-Smtp-Source: AGHT+IG43mO80cAgGfmZylkSHdWSSA6Xq+LvfKFiiaZXUiPMJJ0DzomxI6m/e+j5C/fQxliDf7evWNHt+cBqMQWKoo8=
X-Received: by 2002:a17:902:c94c:b0:28e:aacb:e6f7 with SMTP id
 d9443c01a7336-2902723ca5dmr28208175ad.3.1759938021708; Wed, 08 Oct 2025
 08:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20251002174245.1691343-1-mario.limonciello@amd.com>
 <20251002174245.1691343-2-mario.limonciello@amd.com>
 <CADnq5_P3wW=89cuFUgs493jdU1tHiovCLCTMv=ygNo=g3yXdBQ@mail.gmail.com>
 <1462e3a3-dd43-4903-9371-32d3245542aa@amd.com>
In-Reply-To: <1462e3a3-dd43-4903-9371-32d3245542aa@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Oct 2025 11:40:10 -0400
X-Gm-Features: AS18NWDliBkWn2c-wIIIWOUFdS7YmC8HxfEsvaBRPmVcNSBw6_9OhOMjZq1G1H8
Message-ID: <CADnq5_MsueGakGufGS=_fzeTfzbtxDxGGr=Yjzfr8FxXbfKWkQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/amd: Unify shutdown() callback behavior
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Wed, Oct 8, 2025 at 11:33=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 10/8/25 10:31 AM, Alex Deucher wrote:
> > On Thu, Oct 2, 2025 at 1:51=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> [Why]
> >> The shutdown() callback uses amdgpu_ip_suspend() which doesn't notify
> >> drm clients during shutdown.  This could lead to hangs.
> >>
> >> [How]
> >> Change amdgpu_pci_shutdown() to call the same sequence as suspend/resu=
me.
> >>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c
> >> index 4905efa63ddc..e377fbb43e96 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> @@ -2558,7 +2558,8 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
> >>           */
> >>          if (!amdgpu_passthrough(adev))
> >>                  adev->mp1_state =3D PP_MP1_STATE_UNLOAD;
> >> -       amdgpu_device_ip_suspend(adev);
> >> +       amdgpu_device_prepare(dev);
> >> +       amdgpu_device_suspend(dev, true);
> >
> > I think we did this before, but users complained that it took longer
> > to shut down their systems.
>
> That's presumably from the evictions.  I think that it should be
> improved because we now have:
>
> drm/amd: Avoid evicting resources at S5

That makes sense.  The series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


>
> >
> > Alex
> >
> >>          adev->mp1_state =3D PP_MP1_STATE_NONE;
> >>   }
> >>
> >> --
> >> 2.51.0
> >>
>
