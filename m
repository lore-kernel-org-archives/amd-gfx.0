Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E2E606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VwVt2H95
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0E44112463;
	Thu, 22 Oct 2026 09:44:58 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59F74112222
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 21:47:46 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c315869241fso151297166b.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 14:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792619265; cv=none;
 d=google.com; s=arc-20260327;
 b=S4oOs5fxxj6JveKJk+kCrfD/NRmk8DCF+GUR4nhsm9TAgAKwPj3ZKqP3kDtLBM22Py
 +QxUzpymNg3k09G+YjqlAR3mXnKRKK1WfB6wyLZ3bQnjCrMgWFkWwSb2fnE4vF4Pmkkb
 6aXztBQQRlx7T8hgWGi7oyWCVza5zbnJS1HaU2+rVMvwkROveQdVxNxtGcS51SDmpoAH
 ntgXoSAdJ37txDxnyECRJqZ3LGXTnolFRXIdAW9u7tmm59+RbJsOhMG2QljEnPoyq88a
 v+caybrlJVJX5Jj8koHi5O5MrcIK6lSUjPVqaRPFoaWQtPXpDOILhbFzNrh9vBCFALYp
 X5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Nfuyv0XJXEbAmq50FWhFjJ94nQ4G+vWr3TYg/YVC61o=;
 fh=PlYZz6uQ4A2AEnLO1xxaw5fMarnt2JlR/eyR0kJoXCk=;
 b=Q7vc7B5EbtB8DSehQ1JiWJeqh7QF/EH6Xn4tlwnIJ/BMpYvSRHMTWKQcntMpNAveQY
 2OK04vDQ/xrhpXk7Im2Mep3n9ErmRoZrwlszdWJQhjOcTXoH3YcDwdUFMpESEfQHksRO
 PnUoMT+SAvFdCnG6EhiVKP9D+ktzpU8alePAGgI96DWt1ML4Wx0KQgTzKdxMuwI+17BQ
 w+WksLxzjWI/p9P+LTGBXe+YU53R4NCcRKhIPN+T6QlYB2jv/jFi1FWceym1qxbrUzmX
 pu0AsYjlOcfNkOAA0GAA69OrqQ3YrmgNjuzFfkb++M1xOl2EHbTAbGsZcqcxLR1Sfzwy
 e4NA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792619265; x=1793224065; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Nfuyv0XJXEbAmq50FWhFjJ94nQ4G+vWr3TYg/YVC61o=;
 b=VwVt2H95hJ8CQ57GOexous870mg9hQLyVJbDfWFaRtwUwwxTo9Kknhvyd7z+S03689
 8UKIZpJAES8MrTSvYCfn9M0ujHbm4h38gyjaoAG+U7QA5scZlVGqNaY0UXmdJ6mWZcGo
 LZV10jrk+Od2sgb5rLQyyx6/KGX8MqZRYFA48n/ahdWsJMxDxTGB5/uUxaAg4CmZXzQ0
 J9ad2aHAhv0bHKkVy8/q3tVyvax/LOULczlQEd+lnQFFW24TzI0NbOll/7JqbMqFKIay
 Gsd+j5fb0YBnefxcZMgD8W1+vGhlGl9r8A8a2t5JRGoJyxACBfaS8DjZdgaJdHcZUPJ1
 jfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792619265; x=1793224065;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nfuyv0XJXEbAmq50FWhFjJ94nQ4G+vWr3TYg/YVC61o=;
 b=FYI+iB5Whesjst6nhUjkEAMeKlr1APWI6Gbb5zI0fXWHZQVXtEx2FXAGEZBh3+CMDK
 6Lj7i6mTfMZNXSylxwAS01GcDHVBpoiqlHcgUsZs4suBcG2jsycRRcmaRPyRGIR4binO
 1jPdCGVoiEnmJ5wVvW1iyYo2upOFwJUk2Yf5opmNWRbka99N3v2/Wkt3WRbio3D20hDw
 4aUXBf/aHLAfI2zI579ch1+5ccTl++yVEFTFbEcqg5V4sBd4oLKL0bVSDHaaShuQhWBw
 dRmZ4g5I7PUJDLgYCGMRhtL3V50ksQIgzpaSBjSpvmvXizOooH616sa3PZU7Pepshb+g
 P/8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVH/fJbtwc3JQkzljkE9wtweWkxuW5C07sOkQIzR502ypvCmA9qS80O1tAkZ7iI6TwQ2C3bY3I@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIwycQwRpE8o1gOvPWQmAzwYBsjVoRW7cS+5qLgLSsd1IDj1Y+x
 6GDFureSHSBZUHcmPqV3glUCer4MSuNnsDTcvMadOkAoVsdaoRSqvkSWMDnQ//PNrTW3jYLyDVG
 Gi09T8Q35gmelrC2EvmPQlVWn36eW6T8=
X-Gm-Gg: AYBFou0npuxH7XbpNZKdjoV11EL/mTmn94XGfSivJoHs+0dXIs6wx5kFgASnNMdBQBn
 wX3lOg9yCLuTqyC/Xqf7S3r/eN50k/6N9QXGdZcVU2ufbBygaObKytObOhmFc9dzY8PY3YADNpk
 dwPhRnHflYzOxhfidhs0xMreh3LprVSpKNuL5ofxf/ZZbGVdVeU2yG5CFRivbgG/s13eRQcLYWv
 bdJ1nIGfZit0aWQ5QV3mrKIKAx58uySPoeRcB9FlVNV5wujx4q92V0sPNSubWX3YFSnFFLFD8Q/
 a6KBoYXY92o7//wMiZHId9wRe5BDXZEYcMdLD1vZl526a51Nm3bT0UcemGVYTF+D+e2/BDUvjJu
 kipoktHucneiZSyqZYt/i2w0tdmS4nqmQ0DsnyddA13vdcvPMemnnwh5UVB08fkjYYiekznxZ+L
 QCtVma8lcZv0NMd/FWXbpFrMKOzbrjadQ7hgLy1lrsuWo=
X-Received: by 2002:a17:907:96a1:b0:c42:5363:38dc with SMTP id
 a640c23a62f3a-c4679753a54mr300922666b.25.1792619264509; Wed, 21 Oct 2026
 14:47:44 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019144916.108589-1-kolomiiec@gmail.com>
 <CADnq5_Nabpz1U+taZX7-Adc+ZtCKCvyPsz7etBYkewpnRpgC+g@mail.gmail.com>
 <dbaf07c4-9d14-41a1-a943-0ce5e9c7eff8@amd.com>
In-Reply-To: <dbaf07c4-9d14-41a1-a943-0ce5e9c7eff8@amd.com>
From: =?UTF-8?B?0J4g0Jo=?= <kolomiiec@gmail.com>
Date: Thu, 22 Oct 2026 00:47:07 +0300
X-Gm-Features: AclHuK_XnaUYo6AaPUrR3jIzbU1MZJglpcci8l8tDxVHI9qp8wpozrchlCEiY0c
Message-ID: <CA+e2gLu+tUWXgQ5F08W9L8FY3K12bMQKPAqaPdzb14NxKVdOFA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon: retry UVD v1 init on failure after resume
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, Leo Liu <leo.liu@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 dri-devel@lists.freedesktop.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:44:57 +0000
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

Hello everybody,

> That HW is ancient!

It is =E2=80=94 and still in daily service here, which is exactly why I car=
e. :)

> The question is really if that works reliable or if that could break anyt=
hing?

Fair frame, so let me answer it directly.

1) The success path is bit-identical to stock. When the first attempt
works (cold boot, healthy resumes), the added code executes zero extra
instructions =E2=80=94 the loop breaks immediately.

2) The failure path cannot leave the system worse than stock. Today a
failed ring test already ends in -EINVAL with UVD dead for the session.
The patch only adds up to two more bounded attempts (~250 ms each:
start, ring test, stop, 20 ms settle) and then falls through to the
same failure state. The display rings (0/3) and the rest of the resume
path never touch this code =E2=80=94 and years of stock behavior prove the
machine resumes fine with UVD dead.

3) The one real hazard =E2=80=94 MMIO to an unclocked UVD block in the retr=
y's
stop path =E2=80=94 was caught by the Sashiko review and is fixed in the
[PATCH v3] already on the list: stop is now called only when clock
setup succeeded. v3 also drops the warm-up cycle and the widened poll
window I had in v2 =E2=80=94 both reviews were right that they didn't belon=
g;
our measurements agree (neither prevented first-attempt failures).

Measured on the target machine (HD 5650M, kernel 7.0.0): stock survives
resume with working UVD in ~50% of 42 measured cycles; patched has been
12/12 on the test stand plus every daily resume since.

If you prefer a tighter bound, I'm fine with 2 attempts instead of 3.

> when resume doesn't work at all any more then that would be really bad

Agreed =E2=80=94 and that scenario is exactly what the v3 guard is about.

Thanks,
Oleg

=D1=81=D1=80, 21 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 17:2=
8 Christian K=C3=B6nig <christian.koenig@amd.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> That HW is ancient!
>
> The question is really if that works reliable or if that could break anyt=
hing?
>
> I mean when UVD doesn't work after resume is ugly, but when resume doesn'=
t work at all any more then that would be really bad.
>
> Regards,
> Christian.
>
> On 10/21/26 15:29, Alex Deucher wrote:
> > + Leo, Christian
> >
> > On Tue, Oct 20, 2026 at 3:46=E2=80=AFAM ukrainer8 <kolomiiec@gmail.com>=
 wrote:
> >>
> >> On Evergreen/Redwood (and likely other UVD v1/v2 hardware), resume fro=
m
> >> suspend intermittently fails the UVD ring test:
> >>
> >>     radeon 0000:01:00.0: [drm] *ERROR* radeon: ring 5 test failed (0xC=
AFEDEAD)
> >>     radeon 0000:01:00.0: failed initializing UVD (-22).
> >>
> >> Cold boot always succeeds; resume succeeds only in about half of the c=
ycles
> >> (42 measured suspend/resume cycles on a Radeon HD 5650M: OK counts per
> >> 6-cycle run were 2, 3, 5, 6, 1, 5, 3). Once the ring test fails, UVD s=
tays
> >> dead for the rest of the session and hardware video decode silently fa=
lls
> >> back to CPU.
> >>
> >> The resume path runs the same full asic startup as cold boot
> >> (evergreen_resume() -> evergreen_startup()), so the difference is the
> >> hardware state at entry, not a skipped call. Field data shows the firs=
t
> >> ring instance after resume is dead functionally, not by timeout: the r=
ing
> >> test fails fast and deterministically, and only a full stop+init cycle
> >> revives the engine.
> >>
> >> Fix this the way the Windows driver effectively does it: silently cycl=
e
> >> the engine once (clocks up, start, stop, 20 ms settle) before testing,
> >> then run the init sequence in a retry loop - on failure of clock setup=
,
> >> VCPU start or the ring test, fully stop UVD, let it settle for 20 ms a=
nd
> >> try again (up to 3 attempts). Each retry logs the failing step and the
> >> attempt number, which also makes future reports of this failure mode
> >> self-diagnosing. The ring-test polling window is widened from 100 ms t=
o
> >> 2000 ms as spare capacity; the early-exit poll keeps healthy hardware =
on
> >> the fast path.
> >>
> >> On the same machine the patched driver went 6/6 OK across repeated tes=
t
> >> runs, with the warm-up absorbing the dead first instance and zero erro=
r
> >> lines in dmesg.
> >>
> >> v2: guard uvd_v1_0_stop() behind successful clock setup, per Sashiko A=
I
> >> review - MMIO writes to an unclocked UVD block can cause a PCI bus mas=
ter
> >> abort and hard-hang the system.
> >>
> >> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1867
> >> Link: https://bugs.launchpad.net/bugs/1865130
> >> Tested-by: ukrainer8 <kolomiiec@gmail.com>   # Radeon HD 5650M, kernel=
 7.0.0
> >> Signed-off-by: ukrainer8 <kolomiiec@gmail.com>
> >> ---
> >> v1 -> v2: keep the clock-setup result in a separate variable and only
> >> call uvd_v1_0_stop() when clocks were actually raised (Sashiko AI revi=
ew).
> >> Also folded in the silent warm-up cycle and the wider ring-test window
> >> validated in field testing since v1.
> >>  drivers/gpu/drm/radeon/uvd_v1_0.c | 57 ++++++++++++++++++++++++++----=
---------
> >> --- a/drivers/gpu/drm/radeon/uvd_v1_0.c
> >> +++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
> >> @@ -158,24 +158,58 @@
> >>  {
> >>         struct radeon_ring *ring =3D &rdev->ring[R600_RING_TYPE_UVD_IN=
DEX];
> >>         uint32_t tmp;
> >> -       int r;
> >> +       int r, retry, clk_err;
> >>
> >> -       /* raise clocks while booting up the VCPU */
> >> +       /* warm-up: silently cycle the engine once (like the Windows d=
river),
> >> +        * the first ring instance after resume is dead functionally *=
/
> >>         if (rdev->family < CHIP_RV740)
> >>                 radeon_set_uvd_clocks(rdev, 10000, 10000);
> >>         else
> >>                 radeon_set_uvd_clocks(rdev, 53300, 40000);
> >> +       uvd_v1_0_start(rdev);
> >> +       uvd_v1_0_stop(rdev);
> >> +       mdelay(20);
> >>
> >> -       r =3D uvd_v1_0_start(rdev);
> >> -       if (r)
> >> -               goto done;
> >> +       /* after resume the first ring test can race with the hardware=
; retry */
> >> +       for (retry =3D 0; retry < 3; retry++) {
> >> +               /* raise clocks while booting up the VCPU */
> >> +               if (rdev->family < CHIP_RV740)
> >> +                       clk_err =3D radeon_set_uvd_clocks(rdev, 10000,=
 10000);
> >> +               else
> >> +                       clk_err =3D radeon_set_uvd_clocks(rdev, 53300,=
 40000);
> >> +               r =3D clk_err;
> >> +               if (r)
> >> +                       drm_warn(&rdev->ddev, "radeon: raising UVD clo=
cks failed (%d), attempt %d\n",
> >> +                                r, retry + 1);
> >> +
> >> +               if (!r) {
> >> +                       r =3D uvd_v1_0_start(rdev);
> >> +                       if (r)
> >> +                               drm_warn(&rdev->ddev, "radeon: startin=
g UVD failed (%d), attempt %d\n",
> >> +                                        r, retry + 1);
> >> +               }
> >>
> >> -       ring->ready =3D true;
> >> -       r =3D radeon_ring_test(rdev, R600_RING_TYPE_UVD_INDEX, ring);
> >> -       if (r) {
> >> -               ring->ready =3D false;
> >> -               goto done;
> >> +               if (!r) {
> >> +                       ring->ready =3D true;
> >> +                       r =3D radeon_ring_test(rdev, R600_RING_TYPE_UV=
D_INDEX, ring);
> >> +                       if (r) {
> >> +                               ring->ready =3D false;
> >> +                               drm_warn(&rdev->ddev, "radeon: UVD rin=
g test failed (%d), attempt %d\n",
> >> +                                        r, retry + 1);
> >> +                       }
> >> +               }
> >> +
> >> +               if (!r)
> >> +                       break;
> >> +
> >> +               /* MMIO is only safe when the block is actually clocke=
d */
> >> +               if (!clk_err)
> >> +                       uvd_v1_0_stop(rdev);
> >> +               if (retry < 2)
> >> +                       mdelay(20);
> >>         }
> >> +       if (r)
> >> +               goto done;
> >>
> >>         r =3D radeon_ring_lock(rdev, ring, 10);
> >>         if (r) {
> >> @@ -421,7 +455,8 @@
> >>  int uvd_v1_0_ring_test(struct radeon_device *rdev, struct radeon_ring=
 *ring)
> >>  {
> >>         uint32_t tmp =3D 0;
> >> -       unsigned i;
> >> +       /* after resume the ring buffer controller needs ~1.5-2s to se=
ttle */
> >> +       unsigned i, timeout =3D 2000000;
> >>         int r;
> >>
> >>         WREG32(UVD_CONTEXT_ID, 0xCAFEDEAD);
> >> @@ -434,14 +469,14 @@
> >>         radeon_ring_write(ring, PACKET0(UVD_CONTEXT_ID, 0));
> >>         radeon_ring_write(ring, 0xDEADBEEF);
> >>         radeon_ring_unlock_commit(rdev, ring, false);
> >> -       for (i =3D 0; i < rdev->usec_timeout; i++) {
> >> +       for (i =3D 0; i < timeout; i++) {
> >>                 tmp =3D RREG32(UVD_CONTEXT_ID);
> >>                 if (tmp =3D=3D 0xDEADBEEF)
> >>                         break;
> >>                 udelay(1);
> >>         }
> >>
> >> -       if (i < rdev->usec_timeout) {
> >> +       if (i < timeout) {
> >>                 drm_info(&rdev->ddev, "ring test on %d succeeded in %d=
 usecs\n",
> >>                          ring->idx, i);
> >>         } else {
>
