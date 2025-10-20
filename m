Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A347ECCD199
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 17:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B5F710E490;
	Mon, 20 Oct 2025 17:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="esCKnBGZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0EE310E2B1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 17:39:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8DF9A48E36
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 17:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3DCC19424
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 17:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760981987;
 bh=wT1Y0qfI1uM/2GtV+FQhAIBMo9jpLEUnAXNhpAS02FE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=esCKnBGZ6tc7fXkUNN0JMOBxu4pT8vQeT0lTR5kZUFWi+3eMrJIJJBjRCN85L+Nba
 oQpck0TBqIfTz0bdA27GzRuRMDrlPQYiN+8itrLY2Bg4xX3JMsd3oqo0dUym8iRseY
 kHyQUsYhahuf50qjT0r2elMPjfOeOjT8t1Mq09jIc8WLS6U+ql/aSTJwekhaXUN+eu
 hJ3Sg5z7uInlb/xr6vLmnxZ3SlFZjE1QUhtFyQoJ3+oCOLGgx29OwbJgxrr0XlOAas
 R1kCWqalRAZ3NA3aBPyrgqXuvAJfIEUnZG39F9IUByVkYfl/QOt5LKcIq0zCyjnSk+
 6Op2Pp9/4GVvw==
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-443a58904efso1664427b6e.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 10:39:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVnyqnn1nJLOhkv7x62Wz5C1x6tI/xSXIpD3UvUJOBYdU54KT8r9YVPVES4gVR8Zl4kcWndenNO@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9GN/Il51KPaRj6rTtV3xQm5XisOoTqRh58QE4iACquEjmKKcf
 XR8Vo/lxGxeJvNVewq1AEDsdVzCto6Y7sh7Z2KCLciDvRT1egYMGTCSV7OZc85PBQv0NP2/mBnG
 f7LKoskBE9fuwwq3JhQEtdD2i32jL3hM=
X-Google-Smtp-Source: AGHT+IG2Rxr5g0ETdapUPV9rmvM1DRXwrnwlcoW74xA8ZYJcZOIYF2AKB8oeuOlCh0+q7dU4hWkh88h8bpa+Do93q4Y=
X-Received: by 2002:a05:6808:138b:b0:441:8f74:fb1 with SMTP id
 5614622812f47-443a31ef503mr6101556b6e.62.1760981986716; Mon, 20 Oct 2025
 10:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20251020165317.3992933-1-superm1@kernel.org>
 <20251020165317.3992933-4-superm1@kernel.org>
 <CAJZ5v0gsdmfXUJuLW8Ogt2jKDunx4g51LqCfSVMWQ6WHXBw_zg@mail.gmail.com>
 <85c039ef-e189-48c1-8bf7-50ac0c2484e2@kernel.org>
In-Reply-To: <85c039ef-e189-48c1-8bf7-50ac0c2484e2@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 19:39:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gT9BG5QPcwg6jJ1Jghny2YxC9_HY542LTBy-aVc_2T_w@mail.gmail.com>
X-Gm-Features: AS18NWAGFArtUw2iag6c7zcOb_ybIi_pg36NhodGLq9MnSrMsDZdX75ZsN_KO40
Message-ID: <CAJZ5v0gT9BG5QPcwg6jJ1Jghny2YxC9_HY542LTBy-aVc_2T_w@mail.gmail.com>
Subject: Re: [RFC 3/3] drm/amd: Return -EBUSY for amdgpu_pmops_thaw() on
 success
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, mario.limonciello@amd.com,
 airlied@gmail.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, dakr@kernel.org, 
 gregkh@linuxfoundation.org, lenb@kernel.org, pavel@kernel.org, 
 simona@ffwll.ch, Muhammad Usama Anjum <usama.anjum@collabora.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
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

On Mon, Oct 20, 2025 at 7:28=E2=80=AFPM Mario Limonciello (AMD) (kernel.org=
)
<superm1@kernel.org> wrote:
>
>
>
> On 10/20/2025 12:21 PM, Rafael J. Wysocki wrote:
> > On Mon, Oct 20, 2025 at 6:53=E2=80=AFPM Mario Limonciello (AMD)
> > <superm1@kernel.org> wrote:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> The PM core should be notified that thaw was skipped for the device
> >> so that if it's tried to be resumed (such as an aborted hibernate)
> >> that it gets another chance to resume.
> >>
> >> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c
> >> index 61268aa82df4d..d40af069f24dd 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> @@ -2681,7 +2681,7 @@ static int amdgpu_pmops_thaw(struct device *dev)
> >>
> >>          /* do not resume device if it's normal hibernation */
> >>          if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_=
suspend())
> >> -               return 0;
> >> +               return -EBUSY;
> >
> > So that's why you need the special handling of -EBUSY in the previous p=
atch.
>
> Yup.
>
> >
> > I think that you need to save some state in this driver and then use
> > it in subsequent callbacks instead of hacking the core to do what you
> > want.
> >
>
> The problem is the core decides "what" to call and more importantly
> "when" to call it.
>
> IE if the core thinks that something is thawed it will never call
> resume, and that's why you end up in a bad place with Muhammad's
> cancellation series and why I proposed this one to discuss.
>
> We could obviously go back to dropping this case entirely:
>
> if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())
>
> But then the display turns on at thaw(), you do an unnecessary resource
> eviction, it takes a lot longer if you have a ton of VRAM etc.

The cancellation series is at odds with this code path AFAICS because
what if hibernation is canceled after the entire thaw transition?

Some cleanup would need to be done before thawing user space I suppose.
