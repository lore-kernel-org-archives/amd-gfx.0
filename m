Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37C7CA6012
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 08:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E539810FF63;
	Fri,  9 Oct 2026 08:12:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RzIx+Lb0";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E453A10E09B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 19:52:06 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6ae305e3bd9so3214507a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Oct 2026 12:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791489125; cv=none;
 d=google.com; s=arc-20260327;
 b=DnZamTA1YLExmYnaeK1huEZIJXVsZ1g2h+5DAL9J5GnN/NHXc7VPhapLNJJK0s1yr+
 7ZA3DKXX25Z5yLWOMXwpiQbHoZZArUbmU6xWEiKyEFhtQmsMuxvByDMHGZ+Bsas/u9wx
 HZ7/Y0T5jswePRZZoJP16hy5AyKVMGvjWniOvBnPxU35xylch23x6jYPLr1Qlh5eo3kV
 W2uPMDp44+YfbltkHucmfdr/hU1bWCTKnaPCATWyrlGDwu/un19e+fzUNj0QAszX7Vlh
 KREIQrfVf2ceTwjUxGttHLzZP8BGQPJcTXUShgCFA2QzhK1oKxwi+ZMZR2obVC51XlKD
 /CeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IBn8UBl59QaQ8yJvSSYhTj/Sj9vsUATA1ocADrmat4c=;
 fh=E8qKdUYpHqE6lHBdxOjk8qSbXAbdTlfa+tH7tsbYeJ8=;
 b=Ijpbb/oQky+RfqYTLWx9QIfmQh/U92WHxjEWr1IkmuLFUmCO+BjW5HiZUAMjunDWbW
 Fn/hFaOtJwbX9W5vfhs0R8e6jTA17oM4IXfbnBqx+UohTx3xA6BI+U3GGowG41x2dlkF
 CeVM25Oz1JNECQP2E0L90mP0X0e6W3LG4omTjSPmbVRsnzWJ1qUog1m41p3ckwOsumyv
 A84GDJvyAa4NdV9fEbmW2To6zOHYnvgBCg2IY0u9whheGqKOwQlk3sRoEEQOnmpSJDBN
 hQHNvvOg5mIjG1rDF4U/foEqEbmlkJoDSU0SQSGugxLTucoPSBNt9VOntoK5AJJ0SJJc
 LAiQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791489125; x=1792093925; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IBn8UBl59QaQ8yJvSSYhTj/Sj9vsUATA1ocADrmat4c=;
 b=RzIx+Lb0E56NhZDRMQWZGzng5mRay2cKXBwk+2fj0demIt+ZUxHoMUcuLm0s0fJt2x
 tNX+QPDTmTgPEB06gIJZRwpLklbWKL3/tL8wv2cvocF1JOLlq+RGWHRo0iSuNqUv3PeQ
 K8Bod/ctVchML0NEVjevec2+cRh05HeYf3/6xlKnFn42Rz5RfBrA6gsoD8H6wpwfuKRh
 8CsGVXV4eaazPevdypK/ryZaJmhHudSKwXrl6lG8sQQk8TzaseR1ylOjedt4uG2Fnyjy
 TsHqxF01hssd6xtLFNWVO9a68zcs4jY3Q1JWjuHR9n+2hkUjcNx51+Y7DRdNgsBaZdX3
 AGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791489125; x=1792093925;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IBn8UBl59QaQ8yJvSSYhTj/Sj9vsUATA1ocADrmat4c=;
 b=JcSg0JyNNA1Pz29SP2+4+m+AGqRR3LmiHyTEBSzdBMxcFYovqXcSN/zEoXfQKM5pbi
 filLh3l8QEJvYvATe1UrlZj66ymH8KsdVkW9fEQpMpiTs6fhKKXUUPWdF+l5q7txmODL
 gq6MDxIS9WFsFiwQPotGMH+fNoqBGi2rRcxDaFW/VoU9s86Co2sIXo1vFosvGc9x/g6q
 386er9MYF9Co9Pq/h3LEmy3NMk/cw2vLx79Xd+ENWpS+qetO6C/GAZf5JcQBBoLxmxoq
 Z13VFNQQTnkjG4PWNTC430fQu213+h0ToUieKn+FNKaf19tFIjTQDO03I0WJIm+69sTD
 h8yA==
X-Forwarded-Encrypted: i=1;
 AKwUvByJcCwKSf9q0Q4CecA+VWCKbgE6O7QB0KX+KFWFOvWgCGtKKsh3L7d4JeYibqS6gN3zKaTKl6M1@lists.freedesktop.org
X-Gm-Message-State: AFuF++nmx7pryHPufcZkBllmHpg15ddnup8i4tW47OS3zJYScjK0R3ol
 qYg6CarMBdFWOJaSxl1HixxkxU3p6KwDojD6ZEp0RTpiW3qS04vLsF8pfNHpRrj0n5uN5S7JDOP
 fHzTbIRSK5IaGCqhNdKoJ/gPGPKH306w=
X-Gm-Gg: AYBFou37GGMeQNJN934sHq8MnGG9+POcKMKS8hSgJvHp37l0vBbwv0MJmGDVTLKNmWJ
 06G8tfe1rXA7E571BzvUSMukFE1CGTEtmTuL+kPu1Fi0Ws9cJQxcf/qWYndQdwziyxnKMTud08h
 wQXFAX9YwMVb0NiIKNnh6WXmnWw7LZD3scfifLfCsfVP34idf6doQOiyIJodtNdVGTfd6wZBeXj
 07a90MHN1Lp/Zzig3ftaIA6mRQaSchGzv7oWmiQUhA9pcWmR8XsNdpVBl0Kuy9/w5aw9y/TTgqb
 3fB9lT12WnEqfKP/uYxCzip+hMywHuAf3COL/ONGXgdU7qdNJByIWSmwMHKMgWo9ZAi0n6TqcaF
 kuIoYPZ1dI2WYbt8QKCN6jqKgOaY1f6zxJj/AuDP1S3EQUMx9uHF+qk2ZrwfEqaStnMOVxsyGvW
 rhemRYhROyN3KIXvXpuw+r
X-Received: by 2002:a17:907:97c2:b0:c25:5faf:b207 with SMTP id
 a640c23a62f3a-c317bb259bemr616599466b.3.1791489125110; Thu, 08 Oct 2026
 12:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_P_y-6Ra4Swoxz-CmL1Q3nGhM3RVJUAB2iw1E1D-r1cjQ@mail.gmail.com>
 <20261008193356.GA920772@bhelgaas>
In-Reply-To: <20261008193356.GA920772@bhelgaas>
From: "Perlow, Jason" <jperlow@gmail.com>
Date: Thu, 8 Oct 2026 15:51:51 -0400
X-Gm-Features: AclHuK_zMRWk7ASXID34xVSxpJcH7wIRiAis5r8LGwSDA4hkaCnUCpps2BIgt-w
Message-ID: <CABZrw2GqV53Th=QNMZa5+hA0TcAJ1vHyPjKgqMykFxhTCp=2WA@mail.gmail.com>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Deucher <alexdeucher@gmail.com>, Lukas Wunner <lukas@wunner.de>,
 linux-pci@vger.kernel.org, 
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, 
 Christian Koenig <christian.koenig@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, 
 amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>, 
 Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 09 Oct 2026 08:12:18 +0000
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

I will test the patch on MacBook 16,1 on RC6. Stand by.


On Thu, Oct 8, 2026 at 3:33=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Thu, Oct 08, 2026 at 03:23:34PM -0400, Alex Deucher wrote:
> > On Thu, Oct 8, 2026 at 3:17=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > > On Thu, Oct 08, 2026 at 02:26:00PM +0200, Lukas Wunner wrote:
> > > > Alex is seeing a probe failure of the amdgpu driver after the Root =
Port
> > > > above an AMD Navi10 GPU has been reset.  The reset was performed to
> > > > recover from a Firmware First reported Fatal Error.
> > > >
> > > > However all status registers in the Root Port's AER Extended Capabi=
lity
> > > > are blank, so apparently the platform firmware raised a false alarm=
.
> > > >
> > > > The issue is only occurring since commit eddba19b8b5f ("PCI/AER: Su=
pport
> > > > Advisory Non-Fatal Errors").  It looks like enabling Advisory Non-F=
atal
> > > > Errors causes code paths to be exercised in platform firmware which
> > > > were never validated before.
> > > >
> > > > Skip error recovery on false alarms, i.e. if no unmasked errors wer=
e
> > > > actually signaled.
> > > >
> > > > Note that this will also skip recovery if both the Status and Mask
> > > > registers are "all ones", as would be the case for inaccessible dev=
ices.
> > > > However that seems justified because it would imply either a hot-un=
plug
> > > > event or a Surprise Down Error further up in the hierarchy.  Interf=
ering
> > > > with recovery from that seems uncalled for.
> > > >
> > > > Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> > > > Reported-by: Alex Deucher <alexander.deucher@amd.com>
> > > > Tested-by: Alex Deucher <alexander.deucher@amd.com>
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222095
> > > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > >
> > > Applied to pci/for-linus for v7.3, thanks!  I dropped Alex's Tested-b=
y
> > > since he hasn't tested this change by itself.
> >
> > FWIW, I just tested this patch by itself and it works as expected.
> > Feel free to add:
> > Tested-by: Alex Deucher <alexander.deucher@amd.com>
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> Added, thanks very much!



--=20
Jason Perlow | Argonaut Media Communications

Voice/Text  (954) 242-3484 | jperlow@gmail.com | Blog: techbroiler.net
Read my Tech and Food Industry articles: https://linktr.ee/jperlow
Bluesky: https://bsky.app/profile/jperlow.bsky.social

Need to schedule a meeting with me? https://bit.ly/3y8P3Gp
