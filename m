Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A24C2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 15:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2447D10E51E;
	Wed, 26 Jan 2022 15:41:01 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14C3C10E346
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 15:41:00 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id bb37so341234oib.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 07:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7AlhR1SI5zkpU+jWQ1V+szurw4uOC7/Te0lS6PilgII=;
 b=Y1C9LML7pbYi8z5zlGaiG7mIOlC14/SFIYOStjLaaz3P7XTeRXNw3RGrCRWTGmmPmX
 miIJc/16Jugw6cnVkKt2lcCr/c4sATDv/WeCtoLBMrLOMLl0gjP9GIeCHC2Nj6+r3VlZ
 sjWOndzQ/1IYtOxB70bLSDd4F6L07I+gMs2m7pbfB8J8AFTiuF7/0vQU8ywBkUMUAEou
 TnVhnI3yiBimRd/5al3JU7rB3wVSLHKogtfvUyG5kgda7XruIPR1aqWpCLXEL7qX5HDP
 4fEWdYlfUY3tqDpaNkm/wki01Iz+d7qnE0SbgQu3cyG835u+EY+uOKRmBC0RJzeinZuN
 WOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7AlhR1SI5zkpU+jWQ1V+szurw4uOC7/Te0lS6PilgII=;
 b=jMw2Of9Gbz2MOTJ0z8jHA3QR1wI3mKo+zd6UkZ15Y+c+Cv3vmwqNX3m2TTvof8NVbT
 aCrn32shaVJ6iMbRTUiKd0zE/wXavqvaQTcL+Ocac4M/Cc/uCqSZjYnk3ner0Jae2ZKP
 PYVBkdNdOYQODYpwRaQ/CdBJrjINBy+AXd9UlMR2JPl6WiwBUU+JTMKrHJYtRBJbXKIq
 WiI7j8xz1x7tgTAYcVKbTUU+tjVynK9XFiztlnlzHBbJ1CxfOHrpJDzXSazXQENRt2Oi
 iWt3QUmlGhgpRqTBVbHVuk0T5ytKikT0iZfacj8XsM3XMee6WJi6mnj0zXjKi4MaIl9F
 otMA==
X-Gm-Message-State: AOAM533att221n3fLtDDNJ0W2xs0JzIMPf9J3kaytljtLI8WoqqfL+G3
 A1I//SOZMRtVReLgz34UWDcT64H6+41PSaRztaA=
X-Google-Smtp-Source: ABdhPJwBPw6Xj9qz4lngK//CuIATp8gEGAVU43BES8J8Sq/f5mWNcYY5ykzihNq9XBRk2Gq/efU2ZO7ETomckaLK0bQ=
X-Received: by 2002:a05:6808:2097:: with SMTP id
 s23mr4046825oiw.132.1643211659201; 
 Wed, 26 Jan 2022 07:40:59 -0800 (PST)
MIME-Version: 1.0
References: <20220126040944.4324-1-mario.limonciello@amd.com>
 <20220126040944.4324-2-mario.limonciello@amd.com>
 <BYAPR12MB46142C4338D620EE1F7977FB97209@BYAPR12MB4614.namprd12.prod.outlook.com>
 <BL1PR12MB5157001FFC7CC78C6AA12DF4E2209@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BYAPR12MB46143045A2226B863E1CCB2997209@BYAPR12MB4614.namprd12.prod.outlook.com>
 <BL1PR12MB515774822861EC1850C31F98E2209@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BYAPR12MB4614586B64F8A716DE4D987597209@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB4614586B64F8A716DE4D987597209@BYAPR12MB4614.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Jan 2022 10:40:48 -0500
Message-ID: <CADnq5_POyZpODYcpD6WyyUYE6y+RCzX0L=N9hU4Y7b7qTHVKxg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] drm/amd: add support to check whether the system
 is set to s3
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
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
Cc: "Liang, Prike" <Prike.Liang@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I don't think smart suspend works as expected.  I asked Raphael about
it several times, but he never got around to following up with me.  I
think that is probably the preferred way to go, but the tricky part is
that the dGPUs have integrated bridges and audio and usb and all of
that probably needs proper smart suspend support for this to work
properly.  Alternatively, the OS needs to properly use the ACPI _PR3
methods to power down all of the devices on suspend if the system
doesn't automatically take down the power rails when the system enters
suspend.  I'm not sure Linux does this today.

Alex

On Wed, Jan 26, 2022 at 10:32 AM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>
> I remember Alex adding a patch for smart suspend such that it skips the s=
uspend call if runtime pm suspended.
>
> In summary, the resume doesn't work with/without reset?
>
> Thanks,
> Lijo
> ________________________________
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Wednesday, January 26, 2022 8:47:05 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
> Cc: Liang, Prike <Prike.Liang@amd.com>
> Subject: RE: [PATCH v5 2/4] drm/amd: add support to check whether the sys=
tem is set to s3
>
>
> [Public]
>
>
>
> Right -from an API perspective both amdgpu_acpi_is_s0ix_active and amdgpu=
_acpi_is_s3_active are only in suspend ops.
>
>
>
> But so coming back to the 4th patch (and the associated bug), what is sup=
posed to happen with a dGPU on an Intel system that does s2i?
>
> For AMD APU w/ dGPU in the system doing s2i I would expect that power rai=
ls have been cut off for the dGPU so putting it into S3 and doing a reset m=
akes sense, but I don=E2=80=99t know about on an Intel system if that is lo=
gical.
>
> It seems like Intel expects more that the card is going to be in runtime =
pm and putting it into S3 and doing reset might not be the right move.
>
>
>
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, January 26, 2022 09:11
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedes=
ktop.org
> Cc: Liang, Prike <Prike.Liang@amd.com>
> Subject: Re: [PATCH v5 2/4] drm/amd: add support to check whether the sys=
tem is set to s3
>
>
>
> Talking from generic API perspective - S3 is considered active for dGPU o=
nly if it's going to non-S0 state. If called from anywhere else than suspen=
d op, this should return false.
>
>
>
> Thanks,
> Lijo
>
> ________________________________
>
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Wednesday, January 26, 2022 8:37:28 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
> Cc: Liang, Prike <Prike.Liang@amd.com>
> Subject: RE: [PATCH v5 2/4] drm/amd: add support to check whether the sys=
tem is set to s3
>
>
>
> [Public]
>
>
>
> That was intentional =E2=80=93 shouldn=E2=80=99t dGPU always be going thr=
ough S3 path currently?
>
>
>
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, January 26, 2022 09:06
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedes=
ktop.org
> Cc: Liang, Prike <Prike.Liang@amd.com>; Limonciello, Mario <Mario.Limonci=
ello@amd.com>
> Subject: Re: [PATCH v5 2/4] drm/amd: add support to check whether the sys=
tem is set to s3
>
>
>
> [Public]
>
>
>
> Returns true for dGPU always. Better to keep the whole check under someth=
ing like this.
>
>
>
> if (pm_suspend_target_state !=3D PM_SUSPEND_ON)
>
>
>
> Thanks,
> Lijo
>
> ________________________________
>
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario =
Limonciello <mario.limonciello@amd.com>
> Sent: Wednesday, January 26, 2022 9:39:42 AM
> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Liang, Prike <Prike.Liang@amd.com>; Limonciello, Mario <Mario.Limonci=
ello@amd.com>
> Subject: [PATCH v5 2/4] drm/amd: add support to check whether the system =
is set to s3
>
>
>
> This will be used to help make decisions on what to do in
> misconfigured systems.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 3bc76759c143..f184c88d3d4f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1409,11 +1409,13 @@ int amdgpu_acpi_smart_shift_update(struct drm_dev=
ice *dev, enum amdgpu_ss ss_sta
>  int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
>
>  void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *cap=
s);
> +bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
>  bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
>  void amdgpu_acpi_detect(void);
>  #else
>  static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return =
0; }
>  static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
> +static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) =
{ return false };
>  static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev=
) { return false; }
>  static inline void amdgpu_acpi_detect(void) { }
>  static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { =
return false; }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index 2531da6cbec3..df673062bc03 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1031,6 +1031,23 @@ void amdgpu_acpi_detect(void)
>          }
>  }
>
> +/**
> + * amdgpu_acpi_is_s3_active
> + *
> + * @adev: amdgpu_device_pointer
> + *
> + * returns true if supported, false if not.
> + */
> +bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
> +{
> +#if IS_ENABLED(CONFIG_SUSPEND)
> +       return !(adev->flags & AMD_IS_APU) ||
> +               pm_suspend_target_state =3D=3D PM_SUSPEND_MEM;
> +#else
> +       return false;
> +#endif
> +}
> +
>  /**
>   * amdgpu_acpi_is_s0ix_active
>   *
> --
> 2.25.1
