Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63557CCD183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 17:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CAAA10E4A8;
	Mon, 13 Oct 2025 17:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z+h24AI3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 834C710E4A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 17:58:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2CEFD450E4
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 17:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5BAC4CEFE
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 17:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760378327;
 bh=aG01wiT09yJPj6CFynmVBe9UW2Xxkvjj/sdmA1JN2pU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Z+h24AI3l/ONm1HulZZFly1Gpj1OcGcZ37YhWxl0OHd4N7MkuH7mAJ5tsLEXgY0Hh
 m4XilcvJNumef6NaHDUd97wOEtQnH3/pC1n94dvGjQgHkdwqKsv6AoZzWq66lGMSpF
 vgmZlblGXvsMq14drfG1kqzmRsMQ72mcmKNNgHClgr6flUfH+WCybH3HKLGvUM21FL
 dBlVsimjHOeFZ6EoSG/OrcIEJx3uv8IICcYzfnzZmu5eEvrm5GX+/vKqBFmojrFTbQ
 J/ZS0Od+2TxEtIQjkDwj0zHKwXyCnw4AGgsK/wug+MD6kwbH+w5f71ERZ7kud/2vOy
 e7PBC7dyaHRqA==
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7bcfafec537so3536347a34.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 10:58:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWAnvEFQrby6EisHFdEh813MCWFlBeR9zrIQcQQZz4M3c9elvQcEZSs/BHUFcnvUUvn/O4tZSb1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsYXW67KWspid1d4FPPpYeELfjSqI58QqVXMzDamn1NU2E4zM6
 w6wTD9y5YHDz1gSQwf/FD2urA9BYsEZDzZEHsIgJ54Tlq5/8ODLRhk4qJxHlYfrT195nKRaJ6mn
 9FB1RYo/szY0P5P1IdI1Sa9VzaozpVGU=
X-Google-Smtp-Source: AGHT+IEynNHHTpJPmKSFYHMy2PMRkXPOr2eqd2WUbNoaH67iuh5dKRXgRjCqZxoBlc66XFt/Fz4k+Vj3WXJ7uVBWhQ0=
X-Received: by 2002:a05:6808:1527:b0:441:8f74:fbd with SMTP id
 5614622812f47-4418f7420e0mr8480039b6e.58.1760378326313; Mon, 13 Oct 2025
 10:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20251013174729.1101186-1-superm1@kernel.org>
 <20251013174729.1101186-2-superm1@kernel.org>
In-Reply-To: <20251013174729.1101186-2-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Oct 2025 19:58:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jC9BBniDkODH-RnfvPNP8yYZd2QyYSAOiANfO-jCeyPw@mail.gmail.com>
X-Gm-Features: AS18NWAt8GNlmxH_RQQptsjdD2xFu1WC6QLsI13KgULPzB9ZVQqwCK6NHrsULS4
Message-ID: <CAJZ5v0jC9BBniDkODH-RnfvPNP8yYZd2QyYSAOiANfO-jCeyPw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] PM: hibernate: Nominally skip thaw sequence for
 all devices
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, airlied@gmail.com, alexander.deucher@amd.com, 
 christian.koenig@amd.com, dakr@kernel.org, gregkh@linuxfoundation.org, 
 lenb@kernel.org, pavel@kernel.org, rafael@kernel.org, simona@ffwll.ch, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-pm@vger.kernel.org
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

On Mon, Oct 13, 2025 at 7:48=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> After the hibernation snapshot is created all devices will have
> their thaw() callback called before the next stage.  For the most
> common scenarios of hibernation this is not necessary because the
> device will be powered off anyway.

And how exactly is the image going to be saved?

It is only in memory when the "thaw" callbacks are invoked.

> If the hibernation snapshot was successfully created skip thawing
> devices until it's needed for userspace created hibernation image
> or hybrid sleep. To accomplish this use PMSG_INVALID in
> hibernation_snapshot() and set the dpm functions to skip running.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/base/power/main.c |  6 ++++++
>  kernel/power/hibernate.c  | 13 ++++++++++---
>  kernel/power/user.c       |  3 +++
>  3 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 8179fd53171dc..58f5270a173e8 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1143,6 +1143,9 @@ void dpm_resume(pm_message_t state)
>         struct device *dev;
>         ktime_t starttime =3D ktime_get();
>
> +       if (state.event =3D=3D PM_EVENT_INVALID)
> +               return;
> +
>         trace_suspend_resume(TPS("dpm_resume"), state.event, true);
>
>         pm_transition =3D state;
> @@ -1245,6 +1248,9 @@ void dpm_complete(pm_message_t state)
>  {
>         struct list_head list;
>
> +       if (state.event =3D=3D PM_EVENT_INVALID)
> +               return;
> +
>         trace_suspend_resume(TPS("dpm_complete"), state.event, true);
>
>         INIT_LIST_HEAD(&list);
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index aadf82f57e868..7af2e392c574a 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -480,13 +480,14 @@ int hibernation_snapshot(int platform_mode)
>         if (error || !in_suspend)
>                 swsusp_free();
>
> -       msg =3D in_suspend ? (error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RE=
STORE;
> +       msg =3D in_suspend ? (error ? PMSG_RECOVER : PMSG_INVALID) : PMSG=
_RESTORE;
>         dpm_resume(msg);
>
> -       if (error || !in_suspend)
> +       if (error || !in_suspend) {
>                 pm_restore_gfp_mask();
> +               console_resume_all();
> +       }
>
> -       console_resume_all();
>         dpm_complete(msg);
>
>   Close:
> @@ -707,7 +708,13 @@ static void power_down(void)
>
>  #ifdef CONFIG_SUSPEND
>         if (hibernation_mode =3D=3D HIBERNATION_SUSPEND) {
> +               /* recover from hibernation_snapshot() */
> +               dpm_resume(PMSG_THAW);
> +               console_resume_all();
> +               dpm_complete(PMSG_THAW);
>                 pm_restore_gfp_mask();
> +
> +               /* run suspend sequence */
>                 error =3D suspend_devices_and_enter(mem_sleep_current);
>                 if (!error)
>                         goto exit;
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 3f9e3efb9f6e7..d70c963b1ba88 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -310,6 +310,9 @@ static long snapshot_ioctl(struct file *filp, unsigne=
d int cmd,
>                 pm_restore_gfp_mask();
>                 error =3D hibernation_snapshot(data->platform_support);
>                 if (!error) {
> +                       dpm_resume(PMSG_THAW);
> +                       console_resume_all();
> +                       dpm_complete(PMSG_THAW);
>                         error =3D put_user(in_suspend, (int __user *)arg)=
;
>                         data->ready =3D !freezer_test_done && !error;
>                         freezer_test_done =3D false;
> --
> 2.43.0
>
