Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE132C7EE2F
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 14:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FD9B10E4E7;
	Wed, 31 May 2023 14:25:56 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83CD010E4E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 14:25:54 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6af8b25fc72so2828426a34.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685543153; x=1688135153;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k7aeK6cVH0FedAt0ktz0qiQ8k/9eV6aBnsh+NQhFEYY=;
 b=k+2s09MJgnrop9NicTodHEehwcBIsQq93DB/YDgqhrGJtoBxBoiCXVKvYYs6wVSGPA
 Uedc/awLzd4rnuiYsvfeVKQgaP2on2jKgRH2aRqnOIzsOcaPUzJJ2Y1LAPuD9pGKPZOW
 LUM4aIcXIhFt88kZ6U5P6z+3W31WCNk1TDiOMCoUeVasFRZN5iUJH07X1Q5iVz6ZVzNq
 tPlK/b+r4TOBrCCH2q6UO5BZOf5Z/AiPMO7QSYOtjvmzk5rwSO/hr+S0lsdFAcPclAHo
 hjmFKh2EqVL73TfJnm6harTra5EqycNFCd980X7kA6tImIeuOoaBeXznS2qEr4R/cl0E
 Q9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685543153; x=1688135153;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k7aeK6cVH0FedAt0ktz0qiQ8k/9eV6aBnsh+NQhFEYY=;
 b=Rc75zf0Nk1H2Ysk5UE7rr3Ea/IVBslZjJST7v9PnMgl9BbYQ3yKJn6/yEXTicbF/Na
 XDd45I3ZVyPwtoGtbS5M4bBMl+Memg0OUXwal602G3vhyW+VQbEdJLRCK+JGhN5Q2RYl
 +lzfcEcPNyR+3xkyDiUg410fM6AjygFLJOAN6bRcw7IpbEq8NT/FayS1rDXYjtvrX2am
 3+9t2y5sIdIP/LmUg7s5+q75HhDl6KWR/EKQiFcWe5j0H0PQjxRmt48+mAl5M7RUizlP
 7mjjdONktiG7bKxLz4V03Y0NX8xHmtVQ3QhIEcHAs2ZRhATP+9fjUWb++jwiH0aF7iiY
 2xVg==
X-Gm-Message-State: AC+VfDynv0606tUJfTa1yJGxfREbFvl4fkph7an5HA90I4q/yYsMbSt7
 C+aePYOubSDFf4jD+VnVXGrcjwMXIcp5wciyu/0=
X-Google-Smtp-Source: ACHHUZ7azDbc9nw4LU0nbaSQzRU69uoh1bcLveZGLsRKXB+PWRQPfb/hAemQ1x6A1wyonC0CDiq3fy3TvUCkN+HRNME=
X-Received: by 2002:a05:6870:a8b0:b0:163:3be0:1195 with SMTP id
 eb48-20020a056870a8b000b001633be01195mr3586978oab.11.1685543153397; Wed, 31
 May 2023 07:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230530204848.231842-1-mario.limonciello@amd.com>
 <CADnq5_N64zscFAjTj2JtBGqyoZRUjazSrW75NGAJqPKWBXL68Q@mail.gmail.com>
 <952d351a-58fe-93e2-db68-2f4abab66b37@amd.com>
In-Reply-To: <952d351a-58fe-93e2-db68-2f4abab66b37@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 31 May 2023 10:25:42 -0400
Message-ID: <CADnq5_McwR_b7LjdHKF5fv1AUCxmWT=hLZLTUwzWv7ZUpp8BNQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amd: Disallow s0ix without BIOS support again
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: =?UTF-8?Q?Rafael_=C3=81vila_de_Esp=C3=ADndola?= <rafael@espindo.la>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 31, 2023 at 10:20=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 5/31/23 08:26, Alex Deucher wrote:
> > On Tue, May 30, 2023 at 6:34=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support") showe=
d
> >> improvements to power consumption over suspend when s0ix wasn't enable=
d in
> >> BIOS and the system didn't support S3.
> >>
> >> This patch however was misguided because the reason the system didn't
> >> support S3 was because SMT was disabled in OEM BIOS setup.
> >> This prevented the BIOS from allowing S3.
> >>
> >> Also allowing GPUs to use the s2idle path actually causes problems if
> >> they're invoked on systems that may not support s2idle in the platform
> >> firmware. `systemd` has a tendency to try to use `s2idle` if `deep` fa=
ils
> >> for any reason, which could lead to unexpected flows.
> >>
> >> The original commit also fixed a problem during resume from suspend to=
 idle
> >> without hardware support, but this is no longer necessary with commit
> >> ca4751866397 ("drm/amd: Don't allow s0ix on APUs older than Raven")
> >>
> >> Revert commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support"=
)
> >> to make it match the expected behavior again.
> >>
> >> Cc: Rafael =C3=81vila de Esp=C3=ADndola <rafael@espindo.la>
> >> Link: https://github.com/torvalds/linux/blob/v6.1/drivers/gpu/drm/amd/=
amdgpu/amdgpu_acpi.c#L1060
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2599
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >
> > Patch 1 is:
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> Thx.
>
> > Patch 2 seems a bit much, but I could be convinced if you think it
> > will actually help more than a warn would.  Users already assume warn
> > is a kernel crash.  I'm not sure the average user makes a distinction
> > between warn and err.
>
> warn and WARN are two different things.  I think you're right about
> WARN, that does look like a crash to most people.
>
> Modern versions of both util-linux (for dmesg command) and systemd (for
> journalctl command) will apply coloring for different message levels.
>
> For both specifically there is red coloring when there is an 'err' and
> "bold" white coloring when it's 'warn'.

Ah, right.  Thanks for the reminder.  You can add my RB to patch 2 as well.

Alex

>
> >
> > Alex
> >
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 8 ++++++--
> >>   1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_acpi.c
> >> index aeeec211861c..e1b01554e323 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> >> @@ -1092,16 +1092,20 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_=
device *adev)
> >>           * S0ix even though the system is suspending to idle, so retu=
rn false
> >>           * in that case.
> >>           */
> >> -       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> >> +       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
> >>                  dev_warn_once(adev->dev,
> >>                                "Power consumption will be higher as BI=
OS has not been configured for suspend-to-idle.\n"
> >>                                "To use suspend-to-idle change the slee=
p mode in BIOS setup.\n");
> >> +               return false;
> >> +       }
> >>
> >>   #if !IS_ENABLED(CONFIG_AMD_PMC)
> >>          dev_warn_once(adev->dev,
> >>                        "Power consumption will be higher as the kernel=
 has not been compiled with CONFIG_AMD_PMC.\n");
> >> -#endif /* CONFIG_AMD_PMC */
> >> +       return false;
> >> +#else
> >>          return true;
> >> +#endif /* CONFIG_AMD_PMC */
> >>   }
> >>
> >>   #endif /* CONFIG_SUSPEND */
> >> --
> >> 2.34.1
> >>
>
