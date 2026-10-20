Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCC3606A319
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pDCUUa8O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED4EF10E0B9;
	Tue, 20 Oct 2026 12:50:42 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF2510E0B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 12:50:36 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-34c522572bfso326685eec.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 05:50:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792500635; cv=none;
 d=google.com; s=arc-20260327;
 b=gfts0UNb350+2WSq+YMSHYwlFptTfaJ0FrqJ+lqWAN9JfskmzGlVOMKwKjXa8yvGbI
 VrP/Gv2h0nxgJ55Yt8aDP7dlsxh51CAOvCpE4Ym9ghiabCB483h8TA37ome11/8y42GB
 IMwcaRDRv0KT8W0oVZcDzsxphPhktOaHSZjJrknraL/id9TTWte32b3Y800BE16IdLip
 w3wsG4m7cEHBdo3ReQWNsBycqLPQqWT2h+Z8WgvdHQ3BjvcUETK21mHJQDHmHfX06j/9
 oipJ9Csey2rnjSG49LIrsWGk8xoPjMl5sGpEPT9SSkg/LZ2J1f0WftDxWj7j8UHftJrR
 eSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=r2GFX3sHh1KRCB1444YP2uLVlY4It4wzUFS+sYA9Cdw=;
 fh=B1dUO+etxt87EsmiJ4P+iH8i9VeXw7Z6fEv5ePu2NDU=;
 b=LXrUB3PPamQUzj/CQY5PGnFEqvsIvHMhx5DAQNy8W1qdKDaeV2RhTEMLllE/VsNGSK
 RXQ73evYXagLCQewFq+BynZofjV7MP4KHw4/rwoUY/FqxE0PGoZECrDFvj4EMY3BUjIv
 dX6+l1Zf7aNwcapamwo/77ecXt8W9yR5X7zLbUHgP1reGb2mZUiCkIGRkWMpxsdBZ1V+
 oQD5U6A1QXOvPcZPFARuwgm+p/TCnAOZeh26itu0qluNsAHh3csM61pISEAxFN6sLAeo
 5RafMWdrikZLPo7nocGULnwnJvb6TbdfLrW2aR4a2PtgJgnVHfmVZRBs9k5E4yTyOEO9
 /SDw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792500635; x=1793105435; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r2GFX3sHh1KRCB1444YP2uLVlY4It4wzUFS+sYA9Cdw=;
 b=pDCUUa8O1csHGU6wVyQXJsJmpomgUHha1+D8bYHzGD7m9nLaBRzZcEmCG+ykw9jniS
 bECHVIwh8pDQJc/Z+YM9e9tfYn0r6bhZnQjttBuw75Ro7zKyPCPcUuACltnqz0hUcpa2
 cLRrzrOcKY/2UFrGMSpZ0lJ3C09X25ro/0xNp8WUmNk69qnoQqbvqcSV733eUhMxKgk2
 X4SxYJuzyHAAPlBDstD8Wz+b6vDqwFN0/KZyoji0iagfR9lQVs5gtfb21qeSS7TDMUqa
 Nkc/q3c3nk/6nudbeoJP21Vr1lbqOw3dRGscI1ASUryk1jyQhe+O9R6ga2eDEkYydN2U
 hC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792500635; x=1793105435;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r2GFX3sHh1KRCB1444YP2uLVlY4It4wzUFS+sYA9Cdw=;
 b=EVGw6q7CyQ/W9bG8/HVV0Or6pnioVkQaqJIe/ueRs7BV79m4TPd3MJZfU4KOZVczhT
 qX6pNXirmT0wO6xIhgzIter7GDxm1+vd06m07HSxfKvCnijnxf0hcjQbDRqu1iSwGwAr
 jXY8bi88vw9Wmus0k254IOznsM/qjI8wch47dIK5wm9ZwDZJdBqT8z8+2bHPMQgvZbG1
 gz2LSh/NsWGXITGzfnr7EM+jPFM3nM5N93df0P2eoHmhiu7A4YF+IkeceWIYSIiyIzwK
 +JNTfN/3T6V2PhDdKbGR/TbUrxxBye5ldWSawOX+pxo7GGrzB3HLTtgXD6BHOkjaMpVf
 hRow==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9r+kMPtWx5Uh3/knWPuOMKFtnwk2fJs1pnPD8/YXO6ExK4uVuitT74W+b+na4E20Nw/qPdLR0@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI8kLEng/SlLdhKh8NBZLfWZmmgiolfm2WECbkKA9OPQnHPGf3j
 /Zln+GTb5OK1neHYc2I1wYZuSJJkXpTJfilQx0tIDkaiqDpZ1g3d4IPCrewY9orfbRO2FgXr6kS
 cnWsj0z/m8SfokO86KGxrsgQqXX1vzBo=
X-Gm-Gg: AYBFou3aQe15vJBJFMTs4KoyiGvWl7ETeZ4juIr3wIzCLEEGBpcjFa4vxP14G7Y+X78
 ibDNy7XimD07xMxp6F3mDPftCLq11lGPBQH1J/SR5IMzeDfRcqxhUyesdEb0LiNWsIVd9YRH7aT
 cEHuLlJNz6naF4dqDmv6dnbbXK+CTcY72hiQbKs2FzKx5bEoiw5RSyMel6+odU8BKwUNN5QBHH2
 H3GGb9tZoVhnYvsQbJ7zGkSwnfWPWejvvPasX5fjkk0nDTHuQEguqk0WlDZMDLuJBv0g+AVpCoG
 eslofJGaGxx9b8aOUgIDJfZQ9R4LK4giiXrGj68Gm4W2zhtE2h17gjZRYsGy3oxm6QTPkA/+ErP
 2RHDRI958WSZtlXbKVUgWhHW+inGTAh0hRYA4Z2ZpUNO4yQHYx5+bhipN61bwxwLLgBfV80tFhW
 3ibbG2Qs88ZHAVy5XCu9EU9Z9EnD5Qos/tmmfyr1nmnbst
X-Received: by 2002:a05:701b:455c:20b0:14b:edb2:c3bc with SMTP id
 a92af1059eb24-18506e5ac63mr23192173c88.0.1792500635306; Tue, 20 Oct 2026
 05:50:35 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020-gmc6-writes-only-v3-v1-1-70730a302504@gmail.com>
 <36edbff3-fb61-4bc9-ac2f-0ba549ffe248@amd.com>
In-Reply-To: <36edbff3-fb61-4bc9-ac2f-0ba549ffe248@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Oct 2026 08:50:20 -0400
X-Gm-Features: AclHuK_rWC3C1b3gKg4AIEaR0gHppx4UYjUcnHdBYSrohQh-2dJwkEjnWtvuzTI
Message-ID: <CADnq5_PtxMPr41RgUEeEDOeXQDWVvse8=3WayZcHHE85NFj+jA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gmc6: restore FB location and HDP non-surface
 programming
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: drury.brad@gmail.com, Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 7:40=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 10/20/26 10:40, Brad Drury via B4 Relay wrote:
> > From: Brad Drury <drury.brad@gmail.com>
> >
> > On a MacBookPro11,5 (Radeon R9 M370X, Verde, PCI 1002:6821), used as a
> > headless PRIME offload GPU with the panel on i915, every S3 resume with
> > amdgpu fails:
> >
> >   amdgpu 0000:01:00.0: [drm] ring gfx test failed (-110)
> >   amdgpu 0000:01:00.0: resume of IP block <gfx_v6_0> failed -110
> >
> > followed by SDMA timeouts and a failed GPU recovery.  The GPU stays
> > unusable until reboot.  radeon resumes the same card fine.
> >
> > Instrumenting the resume path with a write/read-back VRAM probe through
> > MM_INDEX/MM_DATA shows that VRAM is still intact after the driver
> > re-POSTs the card and at the start of gmc_v6_0_hw_init(), but is corrup=
t
> > at the end of it.  The gfx ring test failure is a consequence.
> >
> > Commit 71086a3e8470 ("drm/amdgpu/gmc6: drop fb location programming")
> > removed the MC_VM_FB_LOCATION and HDP_NONSURFACE_* writes from
> > gmc_v6_0_mc_program(), on the grounds that the vbios sets these up.
> > That holds after the system firmware POSTs the card at boot, but it doe=
s
> > not appear to hold after S3, where the card is only re-POSTed via
> > asic_init.  radeon's si_mc_program() still writes them on every init an=
d
> > resume.
> >
> > Write them again, with the same values as radeon, after the AGP apertur=
e
> > registers.  gmc_v8_0_mc_program() already does the same for SR-IOV VFs.
> >
> > Unlike radeon and the code removed by 71086a3e8470, this does not black
> > out the MC around the writes.  The old gmc_v6_0_mc_stop() relied on
> > amdgpu_display_stop_mc_access() to blank the CRTCs first, and that was
> > removed by commit e4f6b39e8bcd ("drm/amdgpu: remove *_mc_access from
> > display funcs"), so restoring the blackout now would stop the MC under =
a
> > live scanout.  On this machine the writes alone fix resume; a variant t=
hat
> > also restored the blackout behaved the same.
>
> Yeah that is exactly the reason why this approach here doesn't work.
>
> We can't stop the MC access nor the EFI access to the PCI MMIO BAR. So wh=
at you try to do here is inherently dangerous.
>
> I think we just need to do an ASIC reset on load like we do for other Mac=
s as well so that the FB config matches what the VBIOS programmed it to.
>
> Alex any opinion on that?

Should already be fixed with this patch:
https://lists.freedesktop.org/archives/amd-gfx/2026-October/154974.html

Alex

>
> Regards,
> Christian.
>
> >
> > It is not established which of these writes is the one that matters.
> > At boot on this machine FB_LOCATION and HDP_NONSURFACE_BASE already hol=
d
> > the values written here, but HDP_NONSURFACE_INFO/SIZE do not.  The
> > register state on a failing resume could not be captured.
> >
> > Tested on linux 7.3-rc7, MacBookPro11,5, amdgpu.si_support=3D1
> > radeon.si_support=3D0, mem_sleep=3Ddeep, with this change alone on top =
of
> > the stock driver:
> >  - 7/7 S3 cycles clean, from a few seconds to 10 h 49 min asleep, on
> >    battery and on AC, including two back-to-back cycles woken by the
> >    RTC alarm
> >  - DRI_PRIME=3D1 glxinfo (radeonsi), glxgears and vkcube (RADV) work
> >    after each resume; no ring, -110 or reset errors in the log
> >  - cold boot unaffected
> >
> > The variant with the MC blackout passed a further 6/6 cycles, up to
> > 9 h 40 min asleep.
> >
> > This patch applies to amd-staging-drm-next with only a line offset from
> > the tested 7.3-rc7 change and has been build-tested there.
> >
> > Not tested: other SI parts (Tahiti, Pitcairn, Oland, Hainan), and an SI
> > dGPU that drives a display.
> >
> > Fixes: 71086a3e8470 ("drm/amdgpu/gmc6: drop fb location programming")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: Brad Drury <drury.brad@gmail.com>
> > ---
> > I can run further tests on this machine (MacBookPro11,5, R9 M370X /
> > Verde) if that would help, e.g. register dumps or other variants.
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/gmc_v6_0.c
> > index a7c353d1a..d6e315f4b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> > @@ -223,6 +223,17 @@ static void gmc_v6_0_mc_program(struct amdgpu_devi=
ce *adev)
> >       WREG32(mmMC_VM_AGP_BASE, 0);
> >       WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
> >       WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
> > +     /*
> > +      * Don't rely on the vbios having set these up.  After S3 the car=
d is
> > +      * only re-POSTed with asic_init, and without these (as written b=
y
> > +      * radeon's si_mc_program()) VRAM is corrupt by the end of hw_ini=
t.
> > +      */
> > +     WREG32(mmMC_VM_FB_LOCATION,
> > +            (((adev->gmc.vram_end >> 24) & 0xFFFF) << 16) |
> > +            ((adev->gmc.vram_start >> 24) & 0xFFFF));
> > +     WREG32(mmHDP_NONSURFACE_BASE, adev->gmc.vram_start >> 8);
> > +     WREG32(mmHDP_NONSURFACE_INFO, (2 << 7) | (1 << 30));
> > +     WREG32(mmHDP_NONSURFACE_SIZE, 0x3FFFFFFF);
> >
> >       if (gmc_v6_0_wait_for_idle(ip_block))
> >               dev_warn(adev->dev, "Wait for MC idle timedout !\n");
> >
> > ---
> > base-commit: f307e9d20cc7bd6dd54a3fd8c2af767dd7ef2931
> > change-id: 20261020-gmc6-writes-only-v3-33151aacabfb
> >
> > Best regards,
> > --
> > Brad Drury <drury.brad@gmail.com>
> >
> >
>
