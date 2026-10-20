Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24164606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CwpKQ1SH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD67C10FCCD;
	Wed, 21 Oct 2026 08:53:28 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D339310E254
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 13:33:17 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2dd333d4b44so903315ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 06:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792503197; cv=none;
 d=google.com; s=arc-20260327;
 b=BBpm0hV/NlE+bPlLk/bwnodG+Owo6ZpdESQu/8ypEDNZDhZxZa497Rg0M5hmXcMHal
 1lzpHYxxa7+NuxFJxm3DktpW/FejHuD7QiKtcNwc07m8y3HyoAoOj4N7kgrY9/3Wt6cC
 OxuKDV2DN8ZG+Mhs3Rl7o69c2cWExyV0x15SJMEM4CnFE1Qgh6KIuYsDiS+C44SEHqZH
 65XWDoBby4eWE61tx1+9CJpEDpBUufTZT6QoulCb45P6pLf1EGfYeQLY+5/UgFw5A3WS
 TUSzb/HPMVVOaF/veysUXqyzdsaVfFDI3mfP5rzQgV4p+SeJpTObxOvjuocWFaTzIXnH
 KA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zXC9iLDMnD6a4O0wdA67ioapl8QmsIRQgQMJKpOu+qg=;
 fh=EoxG7sdPObBGSNKDXFWBFjN45YJcXEui+V1jSZXzFUc=;
 b=neAas2baG2OcgDNMUenYUcK5WURapH18bwQzgQioER42Az15QPX2kWfeupCaD1LNcO
 mKj96XeqsvbbMkeDLS/pRAugTdVr0QWdJqXOH6pP9YM/ENNNuR8LOurClUG1kyEf8dST
 9Uf29B1X2S9xmgQRxll+MlKec+09pU0JYDAnIXl/mSFufBbi077OTkO8RvcbrF5vDVI7
 jQ68e3HcFeDaENcUDoVkkswrOQ5IVLBcnECymSK1jwyNtOGpVSOoB1/NzYHNdXZrOJ8R
 pmXsQI3XNw+vcr3lpRuRMZe9KwPDF2VJOD5eRZReviNkXWJYLsfAMQ1ibyYqLECP0bRF
 5U6A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792503197; x=1793107997; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zXC9iLDMnD6a4O0wdA67ioapl8QmsIRQgQMJKpOu+qg=;
 b=CwpKQ1SHtahDIBDzAax0dqPdOZfiIJUjaV4nYYZbGST4IVTbhl38xxv9R7yRA77QCg
 J8170p2fbyFXYzCpfQRPo40UHng1js9NRVVfBRe5KoSrB8CGIupGBNz+8W0v6yPQZfea
 C+mM9ez6EQMpt1wWX5fXf23xUskT5GucKMXS/Z4c+KOSHcsIcw3HmICEM+R9jatOg3fE
 sANks/QRAixVmu6OgXuyUJPE3oTUMp01AuT6JNCxvxXSjSD6yc+69CJQ2Ggjt1XUYCnm
 jzVMwakvm1eTkKtaupozfUvVbCJgtM2dLcDquWj5764Ud8ILaW4YiZ3KYN9z4oka0rMU
 Kefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792503197; x=1793107997;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zXC9iLDMnD6a4O0wdA67ioapl8QmsIRQgQMJKpOu+qg=;
 b=o/Da0g6aPFT6ejdHtJ3b+aYGrO24o6XOGTH7Q4cMp+pfHEaILCBMzEEdWqD6eFXKuz
 8n1wOcsQvhok9EKA9tsVpwuofyHBEXfBcYT+2hz8AdEHAOySAIzLacIC4vuiB/sVd+hs
 /7b9LMbXpkyU4dZPtjIaKoSG/H6U7ksVSXfeo3SV3Mf5oXwGkWaF4tF8ADEz33uNgUFF
 TdeAagR8YFJFHLzGU8orrxhGtc8UwAZYacFNyHVk2/QcLJ+mIPXfmRgo/0NY0oXGC8/+
 hI4fuUNzpWP18ny0CBmjXgl21Mltqe3jMbBcWtp5axJWz9tnCqizNkKg8hhcUs1IxtTX
 jsjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcrPTQAe+x57yZxaJAQkUGcteDXk4+m6rq2ZqLx2wOaH08ZC2RoIUXJ9uNcQRHcEqspZZ1WGMB@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJD2k3Nyv6Ey9Sc/IpbVyEcm03LM1y65E4MsyTUWz7A+rDoQlkA
 qoW+JgrXc5WqlN6iyciQv3lj4lS0wtgoimCPmDZKSj2pDk1C+qWq9s9ernCKtMFWrOP08k8vH0c
 xHsIgmrqFYAWYI43580uXZtMagvdr2jQ=
X-Gm-Gg: AYBFou2iHf6j6ovfeEBi0EykZKILgHVeM4rW/3cIr6fL6eYMMh2DM7bMlhNjVySWJLb
 YwHD6waXEVGvOBpmgF9/JnSY4OrmBRYEhR0kt+XW7x/wMf1xo0l5VLkD2ctVubksgRJUgvzJXim
 S5fKqjyZLkM1WuInRBIZTFKKYK8TeRhS0i9Ru2Ms2ApbnBUD/4P34yvhQO37qwLclqbcF2Z2du7
 QChYq/9t7qaskyuIxgBMO8ocrLKWEO41yORKKQEQrCzDr+SnpYKTuLUHCSQpCe7P5+AbO1PETv8
 SNN20NYumlk06DFn9h8TycxoHtzz9gd3i5JU7ArdsvXnlf/19I0=
X-Received: by 2002:a17:903:32c3:b0:2df:8909:f719 with SMTP id
 d9443c01a7336-2e9a6c0482bmr143724795ad.3.1792503196737; Tue, 20 Oct 2026
 06:33:16 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020-gmc6-writes-only-v3-v1-1-70730a302504@gmail.com>
 <36edbff3-fb61-4bc9-ac2f-0ba549ffe248@amd.com>
 <CADnq5_PtxMPr41RgUEeEDOeXQDWVvse8=3WayZcHHE85NFj+jA@mail.gmail.com>
In-Reply-To: <CADnq5_PtxMPr41RgUEeEDOeXQDWVvse8=3WayZcHHE85NFj+jA@mail.gmail.com>
From: Brad <drury.brad@gmail.com>
Date: Tue, 20 Oct 2026 21:32:02 +0800
X-Gm-Features: AclHuK933-kOikrNIKuAwFhFiTuD2q8fGiJR2fOFW5wlMmzN4XEHYX7aqj26dao
Message-ID: <CAPMJPtyZ7Qh_JA+DXZJUENY_yiQZ5pJO4nP-Erf7FgwE79HJFQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gmc6: restore FB location and HDP non-surface
 programming
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000004ce4e3065e45ac02"
X-Mailman-Approved-At: Wed, 21 Oct 2026 08:53:26 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000004ce4e3065e45ac02
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Great news. This was my first ever attempt at patching the kernel and it is
working swimmingly for me with the switcheroo config, so a bit nervous
sharing.

Thanks for checking it over. I=E2=80=99d be keen to know, Christian, how my
approach is dangerous because I genuinely want to learn. Email me if you
have time and feel so inclined.

Great that there=E2=80=99s contributions rowing in the same direction and l=
ooking
forward to seeing the outcome in future kernels.

Kind regards,
Brad

On Tue, 20 Oct 2026 at 8:50=E2=80=AFpm, Alex Deucher <alexdeucher@gmail.com=
> wrote:

> On Tue, Oct 20, 2026 at 7:40=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > On 10/20/26 10:40, Brad Drury via B4 Relay wrote:
> > > From: Brad Drury <drury.brad@gmail.com>
> > >
> > > On a MacBookPro11,5 (Radeon R9 M370X, Verde, PCI 1002:6821), used as =
a
> > > headless PRIME offload GPU with the panel on i915, every S3 resume wi=
th
> > > amdgpu fails:
> > >
> > >   amdgpu 0000:01:00.0: [drm] ring gfx test failed (-110)
> > >   amdgpu 0000:01:00.0: resume of IP block <gfx_v6_0> failed -110
> > >
> > > followed by SDMA timeouts and a failed GPU recovery.  The GPU stays
> > > unusable until reboot.  radeon resumes the same card fine.
> > >
> > > Instrumenting the resume path with a write/read-back VRAM probe throu=
gh
> > > MM_INDEX/MM_DATA shows that VRAM is still intact after the driver
> > > re-POSTs the card and at the start of gmc_v6_0_hw_init(), but is
> corrupt
> > > at the end of it.  The gfx ring test failure is a consequence.
> > >
> > > Commit 71086a3e8470 ("drm/amdgpu/gmc6: drop fb location programming")
> > > removed the MC_VM_FB_LOCATION and HDP_NONSURFACE_* writes from
> > > gmc_v6_0_mc_program(), on the grounds that the vbios sets these up.
> > > That holds after the system firmware POSTs the card at boot, but it
> does
> > > not appear to hold after S3, where the card is only re-POSTed via
> > > asic_init.  radeon's si_mc_program() still writes them on every init
> and
> > > resume.
> > >
> > > Write them again, with the same values as radeon, after the AGP
> aperture
> > > registers.  gmc_v8_0_mc_program() already does the same for SR-IOV VF=
s.
> > >
> > > Unlike radeon and the code removed by 71086a3e8470, this does not bla=
ck
> > > out the MC around the writes.  The old gmc_v6_0_mc_stop() relied on
> > > amdgpu_display_stop_mc_access() to blank the CRTCs first, and that wa=
s
> > > removed by commit e4f6b39e8bcd ("drm/amdgpu: remove *_mc_access from
> > > display funcs"), so restoring the blackout now would stop the MC unde=
r
> a
> > > live scanout.  On this machine the writes alone fix resume; a variant
> that
> > > also restored the blackout behaved the same.
> >
> > Yeah that is exactly the reason why this approach here doesn't work.
> >
> > We can't stop the MC access nor the EFI access to the PCI MMIO BAR. So
> what you try to do here is inherently dangerous.
> >
> > I think we just need to do an ASIC reset on load like we do for other
> Macs as well so that the FB config matches what the VBIOS programmed it t=
o.
> >
> > Alex any opinion on that?
>
> Should already be fixed with this patch:
> https://lists.freedesktop.org/archives/amd-gfx/2026-October/154974.html
>
> Alex
>
> >
> > Regards,
> > Christian.
> >
> > >
> > > It is not established which of these writes is the one that matters.
> > > At boot on this machine FB_LOCATION and HDP_NONSURFACE_BASE already
> hold
> > > the values written here, but HDP_NONSURFACE_INFO/SIZE do not.  The
> > > register state on a failing resume could not be captured.
> > >
> > > Tested on linux 7.3-rc7, MacBookPro11,5, amdgpu.si_support=3D1
> > > radeon.si_support=3D0, mem_sleep=3Ddeep, with this change alone on to=
p of
> > > the stock driver:
> > >  - 7/7 S3 cycles clean, from a few seconds to 10 h 49 min asleep, on
> > >    battery and on AC, including two back-to-back cycles woken by the
> > >    RTC alarm
> > >  - DRI_PRIME=3D1 glxinfo (radeonsi), glxgears and vkcube (RADV) work
> > >    after each resume; no ring, -110 or reset errors in the log
> > >  - cold boot unaffected
> > >
> > > The variant with the MC blackout passed a further 6/6 cycles, up to
> > > 9 h 40 min asleep.
> > >
> > > This patch applies to amd-staging-drm-next with only a line offset fr=
om
> > > the tested 7.3-rc7 change and has been build-tested there.
> > >
> > > Not tested: other SI parts (Tahiti, Pitcairn, Oland, Hainan), and an =
SI
> > > dGPU that drives a display.
> > >
> > > Fixes: 71086a3e8470 ("drm/amdgpu/gmc6: drop fb location programming")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: Claude:claude-opus-5-5
> > > Signed-off-by: Brad Drury <drury.brad@gmail.com>
> > > ---
> > > I can run further tests on this machine (MacBookPro11,5, R9 M370X /
> > > Verde) if that would help, e.g. register dumps or other variants.
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> > > index a7c353d1a..d6e315f4b 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> > > @@ -223,6 +223,17 @@ static void gmc_v6_0_mc_program(struct
> amdgpu_device *adev)
> > >       WREG32(mmMC_VM_AGP_BASE, 0);
> > >       WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
> > >       WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
> > > +     /*
> > > +      * Don't rely on the vbios having set these up.  After S3 the
> card is
> > > +      * only re-POSTed with asic_init, and without these (as written
> by
> > > +      * radeon's si_mc_program()) VRAM is corrupt by the end of
> hw_init.
> > > +      */
> > > +     WREG32(mmMC_VM_FB_LOCATION,
> > > +            (((adev->gmc.vram_end >> 24) & 0xFFFF) << 16) |
> > > +            ((adev->gmc.vram_start >> 24) & 0xFFFF));
> > > +     WREG32(mmHDP_NONSURFACE_BASE, adev->gmc.vram_start >> 8);
> > > +     WREG32(mmHDP_NONSURFACE_INFO, (2 << 7) | (1 << 30));
> > > +     WREG32(mmHDP_NONSURFACE_SIZE, 0x3FFFFFFF);
> > >
> > >       if (gmc_v6_0_wait_for_idle(ip_block))
> > >               dev_warn(adev->dev, "Wait for MC idle timedout !\n");
> > >
> > > ---
> > > base-commit: f307e9d20cc7bd6dd54a3fd8c2af767dd7ef2931
> > > change-id: 20261020-gmc6-writes-only-v3-33151aacabfb
> > >
> > > Best regards,
> > > --
> > > Brad Drury <drury.brad@gmail.com>
> > >
> > >
> >
>

--0000000000004ce4e3065e45ac02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Great news. This was my first ever attempt at patching th=
e kernel and it is working swimmingly for me with the switcheroo config, so=
 a bit nervous sharing.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Thanks for checking it over. I=E2=80=99d be keen to know, Christian, =
how my approach is dangerous because I genuinely want to learn. Email me if=
 you have time and feel so inclined.=C2=A0</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Great that there=E2=80=99s contributions rowing in the s=
ame direction and looking forward to seeing the outcome in future kernels.=
=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Kind regards,</di=
v><div dir=3D"auto">Brad</div><div><br><div class=3D"gmail_quote gmail_quot=
e_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 20 Oct 2026 at 8=
:50=E2=80=AFpm, Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">a=
lexdeucher@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On Tue, Oct 20, 2026 at 7:40=E2=80=AFAM Christian K=C3=
=B6nig<br>
&lt;<a href=3D"mailto:christian.koenig@amd.com" target=3D"_blank">christian=
.koenig@amd.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On 10/20/26 10:40, Brad Drury via B4 Relay wrote:<br>
&gt; &gt; From: Brad Drury &lt;<a href=3D"mailto:drury.brad@gmail.com" targ=
et=3D"_blank">drury.brad@gmail.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; On a MacBookPro11,5 (Radeon R9 M370X, Verde, PCI 1002:6821), used=
 as a<br>
&gt; &gt; headless PRIME offload GPU with the panel on i915, every S3 resum=
e with<br>
&gt; &gt; amdgpu fails:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0amdgpu 0000:01:00.0: [drm] ring gfx test failed (-110=
)<br>
&gt; &gt;=C2=A0 =C2=A0amdgpu 0000:01:00.0: resume of IP block &lt;gfx_v6_0&=
gt; failed -110<br>
&gt; &gt;<br>
&gt; &gt; followed by SDMA timeouts and a failed GPU recovery.=C2=A0 The GP=
U stays<br>
&gt; &gt; unusable until reboot.=C2=A0 radeon resumes the same card fine.<b=
r>
&gt; &gt;<br>
&gt; &gt; Instrumenting the resume path with a write/read-back VRAM probe t=
hrough<br>
&gt; &gt; MM_INDEX/MM_DATA shows that VRAM is still intact after the driver=
<br>
&gt; &gt; re-POSTs the card and at the start of gmc_v6_0_hw_init(), but is =
corrupt<br>
&gt; &gt; at the end of it.=C2=A0 The gfx ring test failure is a consequenc=
e.<br>
&gt; &gt;<br>
&gt; &gt; Commit 71086a3e8470 (&quot;drm/amdgpu/gmc6: drop fb location prog=
ramming&quot;)<br>
&gt; &gt; removed the MC_VM_FB_LOCATION and HDP_NONSURFACE_* writes from<br=
>
&gt; &gt; gmc_v6_0_mc_program(), on the grounds that the vbios sets these u=
p.<br>
&gt; &gt; That holds after the system firmware POSTs the card at boot, but =
it does<br>
&gt; &gt; not appear to hold after S3, where the card is only re-POSTed via=
<br>
&gt; &gt; asic_init.=C2=A0 radeon&#39;s si_mc_program() still writes them o=
n every init and<br>
&gt; &gt; resume.<br>
&gt; &gt;<br>
&gt; &gt; Write them again, with the same values as radeon, after the AGP a=
perture<br>
&gt; &gt; registers.=C2=A0 gmc_v8_0_mc_program() already does the same for =
SR-IOV VFs.<br>
&gt; &gt;<br>
&gt; &gt; Unlike radeon and the code removed by 71086a3e8470, this does not=
 black<br>
&gt; &gt; out the MC around the writes.=C2=A0 The old gmc_v6_0_mc_stop() re=
lied on<br>
&gt; &gt; amdgpu_display_stop_mc_access() to blank the CRTCs first, and tha=
t was<br>
&gt; &gt; removed by commit e4f6b39e8bcd (&quot;drm/amdgpu: remove *_mc_acc=
ess from<br>
&gt; &gt; display funcs&quot;), so restoring the blackout now would stop th=
e MC under a<br>
&gt; &gt; live scanout.=C2=A0 On this machine the writes alone fix resume; =
a variant that<br>
&gt; &gt; also restored the blackout behaved the same.<br>
&gt;<br>
&gt; Yeah that is exactly the reason why this approach here doesn&#39;t wor=
k.<br>
&gt;<br>
&gt; We can&#39;t stop the MC access nor the EFI access to the PCI MMIO BAR=
. So what you try to do here is inherently dangerous.<br>
&gt;<br>
&gt; I think we just need to do an ASIC reset on load like we do for other =
Macs as well so that the FB config matches what the VBIOS programmed it to.=
<br>
&gt;<br>
&gt; Alex any opinion on that?<br>
<br>
Should already be fixed with this patch:<br>
<a href=3D"https://lists.freedesktop.org/archives/amd-gfx/2026-October/1549=
74.html" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org=
/archives/amd-gfx/2026-October/154974.html</a><br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Regards,<br>
&gt; Christian.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; It is not established which of these writes is the one that matte=
rs.<br>
&gt; &gt; At boot on this machine FB_LOCATION and HDP_NONSURFACE_BASE alrea=
dy hold<br>
&gt; &gt; the values written here, but HDP_NONSURFACE_INFO/SIZE do not.=C2=
=A0 The<br>
&gt; &gt; register state on a failing resume could not be captured.<br>
&gt; &gt;<br>
&gt; &gt; Tested on linux 7.3-rc7, MacBookPro11,5, amdgpu.si_support=3D1<br=
>
&gt; &gt; radeon.si_support=3D0, mem_sleep=3Ddeep, with this change alone o=
n top of<br>
&gt; &gt; the stock driver:<br>
&gt; &gt;=C2=A0 - 7/7 S3 cycles clean, from a few seconds to 10 h 49 min as=
leep, on<br>
&gt; &gt;=C2=A0 =C2=A0 battery and on AC, including two back-to-back cycles=
 woken by the<br>
&gt; &gt;=C2=A0 =C2=A0 RTC alarm<br>
&gt; &gt;=C2=A0 - DRI_PRIME=3D1 glxinfo (radeonsi), glxgears and vkcube (RA=
DV) work<br>
&gt; &gt;=C2=A0 =C2=A0 after each resume; no ring, -110 or reset errors in =
the log<br>
&gt; &gt;=C2=A0 - cold boot unaffected<br>
&gt; &gt;<br>
&gt; &gt; The variant with the MC blackout passed a further 6/6 cycles, up =
to<br>
&gt; &gt; 9 h 40 min asleep.<br>
&gt; &gt;<br>
&gt; &gt; This patch applies to amd-staging-drm-next with only a line offse=
t from<br>
&gt; &gt; the tested 7.3-rc7 change and has been build-tested there.<br>
&gt; &gt;<br>
&gt; &gt; Not tested: other SI parts (Tahiti, Pitcairn, Oland, Hainan), and=
 an SI<br>
&gt; &gt; dGPU that drives a display.<br>
&gt; &gt;<br>
&gt; &gt; Fixes: 71086a3e8470 (&quot;drm/amdgpu/gmc6: drop fb location prog=
ramming&quot;)<br>
&gt; &gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">s=
table@vger.kernel.org</a><br>
&gt; &gt; Assisted-by: Claude:claude-opus-5-5<br>
&gt; &gt; Signed-off-by: Brad Drury &lt;<a href=3D"mailto:drury.brad@gmail.=
com" target=3D"_blank">drury.brad@gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; I can run further tests on this machine (MacBookPro11,5, R9 M370X=
 /<br>
&gt; &gt; Verde) if that would help, e.g. register dumps or other variants.=
<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 11 +++++++++++<br>
&gt; &gt;=C2=A0 1 file changed, 11 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/=
drm/amd/amdgpu/gmc_v6_0.c<br>
&gt; &gt; index a7c353d1a..d6e315f4b 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br>
&gt; &gt; @@ -223,6 +223,17 @@ static void gmc_v6_0_mc_program(struct amdgp=
u_device *adev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(mmMC_VM_AGP_BASE, 0);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(mmMC_VM_AGP_TOP, adev-&gt;gmc.ag=
p_end &gt;&gt; 22);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32(mmMC_VM_AGP_BOT, adev-&gt;gmc.ag=
p_start &gt;&gt; 22);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 * Don&#39;t rely on the vbios having set th=
ese up.=C2=A0 After S3 the card is<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 * only re-POSTed with asic_init, and withou=
t these (as written by<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 * radeon&#39;s si_mc_program()) VRAM is cor=
rupt by the end of hw_init.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0WREG32(mmMC_VM_FB_LOCATION,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((adev-&gt;gmc.vram_e=
nd &gt;&gt; 24) &amp; 0xFFFF) &lt;&lt; 16) |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((adev-&gt;gmc.vram_st=
art &gt;&gt; 24) &amp; 0xFFFF));<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0WREG32(mmHDP_NONSURFACE_BASE, adev-&gt;gmc.v=
ram_start &gt;&gt; 8);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0WREG32(mmHDP_NONSURFACE_INFO, (2 &lt;&lt; 7)=
 | (1 &lt;&lt; 30));<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0WREG32(mmHDP_NONSURFACE_SIZE, 0x3FFFFFFF);<b=
r>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (gmc_v6_0_wait_for_idle(ip_block))<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_warn(ad=
ev-&gt;dev, &quot;Wait for MC idle timedout !\n&quot;);<br>
&gt; &gt;<br>
&gt; &gt; ---<br>
&gt; &gt; base-commit: f307e9d20cc7bd6dd54a3fd8c2af767dd7ef2931<br>
&gt; &gt; change-id: 20261020-gmc6-writes-only-v3-33151aacabfb<br>
&gt; &gt;<br>
&gt; &gt; Best regards,<br>
&gt; &gt; --<br>
&gt; &gt; Brad Drury &lt;<a href=3D"mailto:drury.brad@gmail.com" target=3D"=
_blank">drury.brad@gmail.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
</blockquote></div></div>

--0000000000004ce4e3065e45ac02--
