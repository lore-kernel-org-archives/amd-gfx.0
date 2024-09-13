Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB31FC6172
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Sep 2024 20:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE8AE10ED84;
	Fri, 13 Sep 2024 20:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PA6AbzrC";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A89D810ED84
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 20:36:54 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-71923694bcfso157310b3a.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 13:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726259814; x=1726864614; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pwR3UZKARt/YaO1otmnIpbIO+tVdZ/QNmvmkFC9E/is=;
 b=PA6AbzrCRCvUOY+6YEGSs573kvRmScCXLClFu+E8mPR6abn6ETJlHkOAHNjVlPIsfN
 51swizm2sowvCrsJu0RtfYvwP/O456QeqVIi707KZymqJmDAoKQ2bx7QqhC7pqje0Cx6
 /bFVXoqQ0ktgxpHRGg6q1idP7t/45fy731B0aqKXbDSurgEtT+2ayvZ0ZTUJDCK31mpL
 KL15TVLupGeHETXXq/YaARX8OrySg50MSKeVZrypHESY7nkxQxJXRu/nFprou8arvV6n
 e3J1R09YxiTKi2Eo2eZ2fwc2uP895jhwEGPo7p+UZ2dpXUAfuNWgOpKc3U8udJgr4wg8
 HcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726259814; x=1726864614;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pwR3UZKARt/YaO1otmnIpbIO+tVdZ/QNmvmkFC9E/is=;
 b=aQ+A0Z3IFCuYc03t1tA/gYuHkQSsECkgR4o2iQ+2++P+QxQtJF1ptOc/oa/GCi86w4
 BcokyBcf1Gfk/NifpPk/XibRTGj/Uq2t9Jj+bMmgvRu4xxHu2Nyl5ssi7Lp/Bvc++S8Y
 EUXi1idDxyGLD1QFxxzFyIDFMr8m8x0jhbgtdaXDu8cpp8NQAbuqu5Jot+jPK5E/cCjW
 emOOSX69p3D0gox6ZnUJtVc8BZYrUaaHbg0GsrcwfZJxFrpu/V0SM7rP/PKpQjEttuOs
 GkZbb7TqQN8YhKoM1dX9vbK4hyJsdbRv1L3g9ixb74B3IG5zRYKuIhhsuRQ6cppzJMDY
 KaUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnIbJWc69oVLPQ/TeCJJMG4qiBCJhdONPkDxdV4Ts7qPKgdThuY18faPHB87U3ayH83/Lg4IG3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjbWiTqzYpGJQg002ztkoT3T3dc7nryRRHnbDxMAFidHnnL546
 ZTsKMU7Frb1fyxKMzJkDEa7pKoECusTspYf08sMi/m7AL2diHwO0GEqSiCY83VIp5UK4yixTx8r
 o7OpO7i21XN59DN4UgPTv8ziF4C0=
X-Google-Smtp-Source: AGHT+IEXRXPRI9LKi6RPhSPEAXHxSwJB4TKm3RWoYqrhCh1x179rJZqDfivEx8vW5BXvMWyi3j+vUENfiVK8frQbhRY=
X-Received: by 2002:a05:6a20:1581:b0:1cf:2be2:6524 with SMTP id
 adf61e73a8af0-1cf76358ce6mr5288527637.10.1726259813916; Fri, 13 Sep 2024
 13:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240913180039.38146-1-mario.limonciello@amd.com>
 <db78e83a-6b4b-4d87-a2b7-8a2a912e63b2@amd.com>
 <04ca46bd-c734-4fe8-9244-bbc138b55b57@amd.com>
In-Reply-To: <04ca46bd-c734-4fe8-9244-bbc138b55b57@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Sep 2024 16:36:42 -0400
Message-ID: <CADnq5_Pw6CKn-La4kUu0YL=M_4KdZ6PFL7+26pU421kEc30O=g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Validate backlight caps are sane
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 amd-gfx@lists.freedesktop.org
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

On Fri, Sep 13, 2024 at 2:51=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 9/13/2024 13:47, Harry Wentland wrote:
> >
> >
> > On 2024-09-13 14:00, Mario Limonciello wrote:
> >> Currently amdgpu takes backlight caps provided by the ACPI tables
> >> on systems as is.  If the firmware sets maximums that are too low
> >> this means that users don't get a good experience.
> >>
> >> To avoid having to maintain a quirk list of such systems, do a sanity
> >> check on the values.  Check that the spread is at least half of the
> >> values that amdgpu would use if no ACPI table was found and if not
> >> use the amdgpu defaults.
> >>
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3020
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++++++++=
++
> >>   1 file changed, 16 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> index 5942fc4e1c86..ad66f09cd0bb 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> @@ -4428,6 +4428,7 @@ static int amdgpu_dm_mode_config_init(struct amd=
gpu_device *adev)
> >>
> >>   #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
> >>   #define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
> >> +#define AMDGPU_DM_MIN_SPREAD ((AMDGPU_DM_DEFAULT_MAX_BACKLIGHT - AMDG=
PU_DM_DEFAULT_MIN_BACKLIGHT) / 2)
> >>   #define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
> >>
> >>   static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_ma=
nager *dm,
> >> @@ -4442,6 +4443,21 @@ static void amdgpu_dm_update_backlight_caps(str=
uct amdgpu_display_manager *dm,
> >>              return;
> >>
> >>      amdgpu_acpi_get_backlight_caps(&caps);
> >> +
> >> +    /* validate the firmware value is sane */
> >> +    if (caps.caps_valid) {
> >> +            int spread =3D caps.max_input_signal - caps.min_input_sig=
nal;
> >> +
> >> +            if (caps.max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIG=
HT ||
> >> +                caps.min_input_signal < AMDGPU_DM_DEFAULT_MIN_BACKLIG=
HT ||
> >
> > Would we still want to allow signals below AMDGPU_DM_DEFAULT_MIN_BACKLI=
GHT
> > (but above 0)? The min backlight value of 12 is a bit conservative and
> > I wouldn't be surprised if systems set it lower via ACPI.
> >
> > The rest looks like great checks that we should absolutely have.
>
> I'm waffling about that one because Thomas' testing showed that there
> was some problems with panel power savings when he quirked the Framework
> panels below their ACPI default (12) in his v6 series of the Framework
> quirks.

What about systems without the need for a quirk?  E.g., the vendor put
a value less than AMDGPU_DM_DEFAULT_MIN_BACKLIGHT in the ACPI tables
because they validated it and it works.  Won't this break that?

Alex

>
> So my thought process was we should put in an explicit check for now and
> then when we have panel power savings working without a modeset landed
> then we can also add code to the backlight set callback to turn off
> panel power savings when set below AMDGPU_DM_DEFAULT_MIN_BACKLIGHT to
> prevent the issue he found.
>
> >
> > Harry
> >
> >> +                spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
> >> +                spread < AMDGPU_DM_MIN_SPREAD) {
> >> +                    DRM_DEBUG_KMS("DM: Invalid backlight caps: min=3D=
%d, max=3D%d\n",
> >> +                                  caps.min_input_signal, caps.max_inp=
ut_signal);
> >> +                    caps.caps_valid =3D false;
> >> +            }
> >> +    }
> >> +
> >>      if (caps.caps_valid) {
> >>              dm->backlight_caps[bl_idx].caps_valid =3D true;
> >>              if (caps.aux_support)
> >
>
