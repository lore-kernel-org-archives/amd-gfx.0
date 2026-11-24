Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF62B606A688
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vn4+G3rI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C44510F744;
	Tue, 24 Nov 2026 15:54:46 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2403710E822
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 10:43:35 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-8a9f9473029so3243309b3a.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 02:43:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795517014; cv=none;
 d=google.com; s=arc-20260327;
 b=kd+fBMArROjyrMW9jxjMjAcEl37lYn1lDMVSH4AbL3LrB0yEozIPLVieBkIMgiGfTE
 RQxPKtsOnn5HKK54c+e5ro2YGQqCEGNDKY50XsMk8FNhk2be5KHAU0Y1xu/bEdiRnvdc
 AdzWw+SMIneUx/xyDQ7Jont1AGbdR7zMRH0gQg9uoiS6n1JIJsI6g5tucbz5ycyjJyqL
 9IfgHvQswr+LXZPs4QYRAetNc3asSpliUFxxcj+UFqnE+2b2VU2+NbpVYoW+bBUuwI++
 4ZoeTs6hrgIklstFqE+jvdugW6NzGPz3yG+SvZSKmV3ie21PKoLCGFi5BNGMU2ngrd2Q
 Ehiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zw8MhdrCRw4Anjf2J55DnBkyqIRRMXumfxb086Ftrkk=;
 fh=uNrDyZ4Z0PwcDlJzyXftuy6IP6LYjoQtMYJ2TsASHpo=;
 b=KbCwBIFgvrd+oOpkwpB/uliUzqWXdjLfT1lYGiR4E7l+VEdkKeb37DtqnaXD0h9yZ+
 EDxjADPRvd+87hLHpIYksCKXrt7IhJ9/rxIhhkVCg0lGsL1he9ZCw4rfkFcmnIVJHr5g
 Vz1AxR8NENy+xmrgpXU87Jj4enVVMfy4ZHC4yj9lhoRLOcYcVUUpgDZDdPtV+DKqVKac
 8mxph2EWqfA4207N04R4py7HsH17mVhye0CnAxPNF7aJ6pzcLAPi2PRhhasQEKIUEFcR
 H6KANwPmps8b9mj1cM9N4Gaxs4xb/wsYoWJM5PtHxYX4p2LW6NDJRgg4uHVR5FQeWwhA
 KAbw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795517014; x=1796121814; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zw8MhdrCRw4Anjf2J55DnBkyqIRRMXumfxb086Ftrkk=;
 b=vn4+G3rINunPP9jlRO9hKreHzwUP+JoG8Vj1ZUdJCQQUIU6zZayvcrg4VU2pY336FX
 HE1V40nEyRds1HiDGE4UaZtjgWMAt9DUxCRUcJreXdRh4lU7xnKAhe1Tw70SHgRrXvQ7
 odCIIUNfTBoZFKgMHK8Z39QYOSKxOGtiwji1gKu4ylCMgAZrnJlwd5xjh2YZzZuNfMem
 CkFbLv10Px5DmCoeK8/EDlmxiq2rML3bV/DO4YQvRK+7fAiifYqsFgdksZHWL/GcDXc7
 sGRZFJNrUoi04gpUqwM8dZSe+yHaY55igNkv/uEAsIxZWd7jd+0ys4Bfkg4WOgw9A/tQ
 U+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795517014; x=1796121814;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zw8MhdrCRw4Anjf2J55DnBkyqIRRMXumfxb086Ftrkk=;
 b=1TU3TVGjO6oOmig0S6pfjS6d2w2vp5CKpBrt02DJ6LyaOviRBOI0er82Qn+APb9iDY
 yV6ac19vUjH5aBm+AAp2AGp0taREXDHKsgC77487CgO1qgFcEPLrLRL7N+StUpVISzj0
 w4JOaygefHIDWmFHq9g5tQM3yVZtQm2Mbi5GouAyUqaO9j63z1EniyChxG5yKPCtMe+B
 zFWTFcpFoFI/Zs6Gk8PihnbLRqGRTjIDtAkIH6uBszcA/dwDBhO1NClJnJXsgHIsG9bh
 Zps5rUHTPFXSAomjCOU8Et+BhX5j37Q3FrCfPFDgU9PzMgnoxgFN3dQus0tAifo8OFQe
 Y/Gw==
X-Gm-Message-State: APuU4Z/tI3mVQLmugP1NwqTY8SUVEhwcpW56C6Mhuit2BW0rttif4X7c
 ihuuVes/EZ2S2UhdHRMPwuJ9yQ/E899f7zcA3PXvZsWSbnSqhZrcAPjb0Q6WHS4wwxaxsLkGsVl
 +RZn1kFWHTEWFdZZwqhSlNZ3zetuIX34=
X-Gm-Gg: AZFdTZd0neRKy9UIWVAHf6VZ7xeN4RqIO8ognd0Vv3RidKZKbp11JZFHZHvn3J51jYG
 kSEc4N9X7lcpCEDm2waagT75osFufkOxrUXnHhQau2QyLPX0w/6YWJFkjCyRza/OqiGZMaPrru+
 RFXJ2FIN+3rDRd9sEnmIjZbMdWOJCCfr36Mp5g9+cF13rK4agexIFuTaQe77a13xy/wa7AAjGiM
 8h52e8V8KY1ESVuSLw8bxBEVlEd6dwFyqnDyfMhWeTszVqMDVMa+Niq+uqyITysYLoOofRl73l/
 JMnC7FvhwGN5dTbWe/uUMSPSaata/P+buKLtJTRlkKuplDKspdwyV1h0l56m2smzmKsyMMhNdE5
 gOXh7JyIHXcga5ROHxlnlQFaAfnJIc0n8Q4H9etrWh36qrJw/zR76ehTpggUaAgIgmatJi9g1MJ
 E+nHqg62G8weS+BN8TK5kYOHrh
X-Received: by 2002:a05:6300:6bdc:b0:3e2:86b6:9beb with SMTP id
 adf61e73a8af0-4014e06961emr11677858637.74.1795517014565; Tue, 24 Nov 2026
 02:43:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1795482456.git.arisa.snowbell@gmail.com>
 <2ba4e27796fb1777481bd91d8467439a85542a42.1795482456.git.arisa.snowbell@gmail.com>
 <sashiko-outbox-230755@kernel.org>
In-Reply-To: <sashiko-outbox-230755@kernel.org>
From: Arisa Snowbell <arisa.snowbell@gmail.com>
Date: Tue, 24 Nov 2026 11:43:23 +0100
X-Gm-Features: Aa3M54qP-NAC3_Km_uflhMRaAjWtVrFKLmGDZhabjv91y7rOlkT9jOilb95geBc
Message-ID: <CABpa4MCdAqTFmThGHjcDt+7RuJuH=iTJ-ccUvNEfjCNoY6NyoA@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu/userq: don't restore user queues during
 system sleep
To: sashiko-reviews@lists.linux.dev
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 24 Nov 2026 15:54:45 +0000
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

It needs ensure_ev_fence() to return an error to its ioctl callers. I
can look at it as a separate patch.

On Tue, Nov 24, 2026 at 9:56=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [High] drm/amdgpu: infinite retry loop in
>   amdgpu_userq_ensure_ev_fence() [1]
> --
>
> commit 1073e972cefe081a3547954bcb099da6f1184516
> Author: Arisa Snowbell <arisa.snowbell@gmail.com>
>
> drm/amdgpu/userq: don't restore user queues during system sleep
>
> This commit blocks user queue restore work from being scheduled during
> system sleep preparation and moves the restore worker to
> system_freezable_wq so restores do not race with VRAM eviction.
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_userq.c
> > index ed6f3b67e8720..7960341f7f84f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>
> [ ... ]
>
> > @@ -453,7 +464,7 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mg=
r *uq_mgr,
> >                * Looks like there was no pending resume work,
> >                * add one now to create a valid eviction fence
> >                */
> > -             schedule_delayed_work(&uq_mgr->resume_work, 0);
> > +             amdgpu_userq_queue_restore(uq_mgr);
> >               goto retry;
>
> [Severity: High]
> This problem wasn't introduced by this patch, but can
> amdgpu_userq_ensure_ev_fence() loop forever [1] if
> amdgpu_userq_restore_worker() fails to install a new eviction fence?
>
> When amdgpu_userq_vm_validate_and_restore_queue() fails (for example
> with -ENOMEM), amdgpu_userq_restore_worker() exits without replacing
> the signaled eviction fence:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c:amdgpu_userq_restore_worker() {
>     ...
>         ret =3D amdgpu_userq_vm_validate_and_restore_queue(uq_mgr);
>         if (ret) {
>                 drm_file_err(uq_mgr->file, "Failed to validate BOs to res=
tore ret=3D%d\n", ret);
>                 goto put_fence;
>         }
>     ...
> }
>
> amdgpu_userq_ensure_ev_fence() then sees the same signaled fence on the
> next iteration and re-queues resume_work in an unkillable loop.
>
> [1] https://sashiko.dev/#/bug/linux-d9fc724f-ccb0-417c-8973-b83fdfc48280
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795482456.=
git.arisa.snowbell@gmail.com?part=3D1
