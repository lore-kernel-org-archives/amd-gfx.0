Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1776C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 07:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34FF710E48B;
	Wed, 31 May 2023 07:07:48 +0000 (UTC)
X-Greylist: delayed 321 seconds by postgrey-1.36 at gabe;
 Tue, 30 May 2023 18:36:27 UTC
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 658FC10E3ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 18:36:27 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QW1Dk1zNlz9skj;
 Tue, 30 May 2023 20:31:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=espindo.la; s=MBO0001; 
 t=1685471462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/dRfvgqXDOCtlru+COJ7BHIxU6PlC3yYHYAbfmevy8=;
 b=y3drGNOpkXGi82zPK+25nep9bXPqN/Zt4/9NNbx3FVtc6jRLNo7UdQHPOekARsI/R4P8dz
 ysygVuT+L/iYQH0c/FzAJAImmrl7zd1V09/j3l2AyCl8OWP4q9NE+rql5mGl48LgY46bdp
 zR6VB5JkqlU9ga9OZafNnvY5d75kAVaKey1KLGKEyPJPLBRh0L8uJQclOAgCktFUo7TQ/z
 mX7SjVH2owky1yw4YVJ/6s7tICqklrchkWxOywDE9hheX0IdapGytR+P1RXmmgpvHO0ML6
 +GcOZaTrjkxNLJ/qtFiMJh9rflfjhXOpxtOPFOC+xbt+ROU1Xfp4t7Mz1nID/A==
From: Rafael =?utf-8?Q?=C3=81vila?= de =?utf-8?Q?Esp=C3=ADndola?=
 <rafael@espindo.la>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: RE: [PATCH 1/2] drm/amd: Disallow s0ix without BIOS support again
In-Reply-To: <MN0PR12MB610183E9EC20D68FE3670D24E24B9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230530175301.231070-1-mario.limonciello@amd.com>
 <CADnq5_M8XdDsyn0q-mM4CfFoMHH6g54VP_SG4cNztEYAwwB_hg@mail.gmail.com>
 <MN0PR12MB610183E9EC20D68FE3670D24E24B9@MN0PR12MB6101.namprd12.prod.outlook.com>
Date: Tue, 30 May 2023 18:30:58 +0000
Message-ID: <87ilc9acyl.fsf@espindo.la>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 31 May 2023 07:07:45 +0000
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As far as I know the "no S3 if SMT off" is just an oddity of the
particular BIOS I got on the "B550I AORUS PRO AX".

Also, what has changed that would prevent the same issue I was hitting
before?:

https://gitlab.freedesktop.org/drm/amd/-/issues/2364#note_1735422

Cheers,
Rafael

"Limonciello, Mario" <Mario.Limonciello@amd.com> writes:

> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Alex Deucher <alexdeucher@gmail.com>
>> Sent: Tuesday, May 30, 2023 1:16 PM
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Rafael =C3=81vila de Esp=C3=ADndola
>> <rafael@espindo.la>
>> Subject: Re: [PATCH 1/2] drm/amd: Disallow s0ix without BIOS support aga=
in
>>
>> On Tue, May 30, 2023 at 1:53=E2=80=AFPM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>> >
>> > commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support")
>> showed
>> > improvements to power consumption over suspend when s0ix wasn't
>> enabled in
>> > BIOS and the system didn't support S3.
>> >
>> > This patch however was misguided because the reason the system didn't
>> > support S3 was because SMT was disabled in OEM BIOS setup.
>> > This prevented the BIOS from allowing S3.
>> >
>> > Also allowing GPUs to use the s2idle path actually causes problems if
>> > they're invoked on systems that may not support s2idle in the platform
>> > firmware. `systemd` has a tendency to try to use `s2idle` if `deep` fa=
ils
>> > for any reason, which could lead to unexpected flows.
>> >
>> > To make this the behavior discoverable and expected, revert commit
>> > cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support") and offer
>> > a message if SMT appears to be disabled.
>> >
>> > Cc: Rafael =C3=81vila de Esp=C3=ADndola <rafael@espindo.la>
>> > Link:
>> https://github.com/torvalds/linux/blob/v6.1/drivers/gpu/drm/amd/amdgpu
>> /amdgpu_acpi.c#L1060
>> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2599
>> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> > ---
>> >  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 16 ++++++++++++++--
>> >  1 file changed, 14 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> > index 3a6b2e2089f6..a3523d03d769 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> > @@ -28,6 +28,7 @@
>> >  #include <linux/xarray.h>
>> >  #include <linux/power_supply.h>
>> >  #include <linux/pm_runtime.h>
>> > +#include <linux/sched/smt.h>
>> >  #include <linux/suspend.h>
>> >  #include <acpi/video.h>
>> >  #include <acpi/actbl.h>
>> > @@ -1473,6 +1474,13 @@ void amdgpu_acpi_release(void)
>> >   */
>> >  bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
>> >  {
>> > +#ifdef CONFIG_X86
>> > +       if (!sched_smt_active()) {
>> > +               dev_warn_once(adev->dev,
>> > +                             "SMT is disabled by the BIOS.\n"
>> > +                             "To use suspend-to-ram enable SMT in BIO=
S setup.\n");
>> > +       }
>> > +#endif
>>
>> Will this generate a spurious warning on platforms that are natively non=
-SMT?
>
> Yeah; it could.  I'm not sure how we can reliably detect this.  I thought=
 about looking for
> the 'ht' flag, but that probably wouldn't work for this case.
>
> Are there AMD Zen CPUs or APUs that are non-SMT?  Could gate the sched_sm=
t_active()
> check to only run when it's an AMD x86 Zen SoC.
>
>>
>> Alex
>>
>> >         return !(adev->flags & AMD_IS_APU) ||
>> >                 (pm_suspend_target_state =3D=3D PM_SUSPEND_MEM);
>> >  }
>> > @@ -1499,16 +1507,20 @@ bool amdgpu_acpi_is_s0ix_active(struct
>> amdgpu_device *adev)
>> >          * S0ix even though the system is suspending to idle, so retur=
n false
>> >          * in that case.
>> >          */
>> > -       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
>> > +       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
>> >                 dev_warn_once(adev->dev,
>> >                               "Power consumption will be higher as BIO=
S has not been
>> configured for suspend-to-idle.\n"
>> >                               "To use suspend-to-idle change the sleep=
 mode in BIOS
>> setup.\n");
>> > +               return false;
>> > +       }
>> >
>> >  #if !IS_ENABLED(CONFIG_AMD_PMC)
>> >         dev_warn_once(adev->dev,
>> >                       "Power consumption will be higher as the kernel =
has not been
>> compiled with CONFIG_AMD_PMC.\n");
>> > -#endif /* CONFIG_AMD_PMC */
>> > +       return false;
>> > +#else
>> >         return true;
>> > +#endif /* CONFIG_AMD_PMC */
>> >  }
>> >
>> >  #endif /* CONFIG_SUSPEND */
>> > --
>> > 2.34.1
>> >
