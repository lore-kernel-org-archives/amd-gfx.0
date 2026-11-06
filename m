Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6368C606CE50
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Nov 2026 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=00dtEYtU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DBA210EB9C;
	Sat,  7 Nov 2026 15:04:14 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5902E10EAA8
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 16:25:31 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-4ed6d69bdfaso502189b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Nov 2026 08:25:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793982330; cv=none;
 d=google.com; s=arc-20260327;
 b=RqptOIqr5hwhAtIHwbnpugUq0Mp40rRDzUlrZWgrGfSUcOzWS3qwcQXQ7N2oYGBeCc
 AEpLqni8M7f1gTF08owJZ+DeFkoLaV3mtPjqys7Wrb/0ud0TuHZOEHttVwCW8dBUmMte
 7tmQ1+8CqgHJeoDLXh2m3+61gwmRzxnn8IX6BB1FHTxt1aIfkfK6sH+Sz2QeBDzWdEK+
 InNvoxL68YFX5B0gPjQMniQM/7c+SXwSfa7Ix/aVp1Px8qJCOcuFQ8ZiLwbHsCnBSBCQ
 RXCPEJwj4lJD2IjHcyiVbrDFsl12iRKviH6OkiJjp2+6p+9tHF1Xk91ovOHe+BQ1Xkli
 80HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=DJ0d0h72fqSWvtMIpeQzTHGWj3XUsIGrYIUYA578KNw=;
 fh=hs9oynQb3YjZT40omR8IZyt+l0QN8nu4Bye5abBVWug=;
 b=szXzsfkGnsYp6zNluTJ7+/ob70W9y+9CNqATjWSEYaNxpTG8L8DdAG+Dq1cwMaLijA
 u2HCz2yb9vG9olL6r+aysgCMFvh4MhZ9u5Qiq22hM9Ye5zZOCP2Emu38baULi/vGgZcX
 k7p71L/uqM1vK6GWFtpYx5u53Lynfl5VxeBrsc5npqdXMgqA2HXIVEM/9lEGCsdB/pLD
 OgLiXXUtW0F01NtKJW2QdqKeNGXRMiJ/uwvavymNByNSZzHBRY/3qn8i+Bp5EDv+Ohwg
 zQs/Ase3lRzBm9xHoyVLGrxEzG4I8LBkqnvdVtai0eol2Gxm88xW4y9ZQD2TAt4pxgYi
 LLKw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793982330; x=1794587130; darn=lists.freedesktop.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DJ0d0h72fqSWvtMIpeQzTHGWj3XUsIGrYIUYA578KNw=;
 b=00dtEYtUeyjUGwHOuuWf6CV4IZU4XJR7vAiXLYK8UdzpGZtSGHTxYzGFW/13PkVXOF
 2LjubekKnSMOmDC+xKCbv6qeWP/xZqP71KTVCznpmeLAh0/PeCGCyxZVK/rrOMKcxI+U
 vEw1/Ak/+rxw6zSw4Gf2mFdGENiN7znUmGZCf/EfH44hNYvbDbGlBBSZ1a1n6qieIUOi
 ZMKhhQHgbAzZaIlN9v/JrA65PahM9UOjqkqm1DR9kA8Vq2YmGuf64bOKoDBseVXS0X5d
 BSGGp2CsVCaCYiqonG6LSLKm1VUEsCzkSC/Ezw6Pm2OLbU3ThU9Vgx3NSnoq8jfPGMVk
 LVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793982330; x=1794587130;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DJ0d0h72fqSWvtMIpeQzTHGWj3XUsIGrYIUYA578KNw=;
 b=t+2kLNflOp+luGJQjmMJ3yScnbg0e8/3k7sPpNE1k9vV/s0JdBxcLke11KUS8rlDNa
 gSFRDOcgFV1hYzVzmurQf7agOrEWo/xfchsEiZhZ9iFkhZeKk9YBbCzm+4BFtVFVM8k4
 2HC73SyLAZfB8RdTcfWwB+KsqchqJOEdWXPzdMsBWg/AFNrP103YWm6au6gqvVuf3OsS
 SNiXhCKV7MDS0wy8qf4TMP3rGgyf7QIRhUX8LPTANVzBTxYNqJLmyWMrebgAgMGaJFZc
 x81dBT+H1/LaTvW7KfuO27lIYUufXNLaNgUFQEWgFqka4wUgVKhW7zf3hjUIQPPD07cQ
 5MCQ==
X-Gm-Message-State: APuU4Z8DcKD9x3Q2esYNj06xl9MZ1hU0AorW0LKHVQYrzrF/mN6AATVF
 QkXhG1eVsEWDgZjSsRE87WDeSRlxrgSc2oFLtErsubT9jZl/KxU46Hs0XR1hXBJjJEDBng46/Lb
 T65C0NXR1Iheh6SC2cBnlpPREUK2UKay0zw==
X-Gm-Gg: AYBFou0lisRIlgcDI1ylO/UgZSJLXH2uCHb2lOHFdpFy4OTPIXdNfK4K7q3uT8rundx
 6SPhU5dUm2fhgv9tN0Xs1FsLnJui26sfAQ9unqCWjUkXFVj7n50PN0lnXCKNOt3ExUE5lDYc4TH
 cfaAc0Jb/pDBX//c+qidFUJBFozc7zd8YuBsAfxsbIPBYfCQ1Tq/J9WpA0K0vNXMRmYbyZaBzmP
 VDEIKWHcxCh+QgfsXY7pCqYZOJ3is5Vt4v5H3vwXJk1WxDNPN2ctZ7K/uKjy8sodRA0PfBsEDWw
 aNHr1A4Q3DVK0vyZRIBSgwJ4YofkiGhBMcyW/8iP/z7hMLbvhSzXGuPXmTbhHnyuh9QNRSnryIi
 ul8tvXpvC7395jy7UFwOQLa8TUDZLGNppGks=
X-Received: by 2002:a05:6808:3088:b0:4f8:4ec9:b170 with SMTP id
 5614622812f47-567e0997aa3mr2751605b6e.2.1793982330246; Fri, 06 Nov 2026
 08:25:30 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 6 Nov 2026 08:25:29 -0800
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 6 Nov 2026 08:25:29 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Nazar Kazakov <kazakov.2000.nazar@gmail.com>
Date: Fri, 6 Nov 2026 08:25:29 -0800
X-Gm-Features: AclHuK_ChBOb2AL10fTKmLkiGVhsy-_kfJPafd26dtT6atYaMQXQ2EOs75Qp3vE
Message-ID: <CALJcJEUEYjBW22UyOc4kiptRp2BFwxtgFXf6UY+V5OC4GpOBKQ@mail.gmail.com>
Subject: =?UTF-8?Q?=5BNavi22_=2F_RX_6700_XT=5D_Repeated_UTCL2=2FTCP_GPUVM_fault?=
 =?UTF-8?Q?s_=E2=80=94_request_for_kernel=2Dside_triage_guidance?=
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000871c7a065f9e0fdc"
X-Mailman-Approved-At: Sat, 07 Nov 2026 15:04:12 +0000
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
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000871c7a065f9e0fdc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello AMDGPU maintainers,

I=E2=80=99m investigating recurring GPUVM faults on an RX 6700 XT (Navi 22)=
, with
symptoms closely matching the October 5 report about UTCL2/TCP permission
faults on the same GPU.

The issue has persisted across two physical RX 6700 XT cards, multiple
kernel/Mesa/firmware versions, KDE Plasma and Hyprland. Our retained
evidence index identifies 33 separate gfxhub fault episodes through
November 5, 2026.

Recurring signature:

   - gfxhub, UTCL2/TCP shader client
   - Non-zero PASID/VMID
   - READ faults with PERMISSION_FAULTS=3D0x3
   - WRITE faults with PERMISSION_FAULTS=3D0x5
   - MAPPING_ERROR=3D0
   - gfx ring timeout typically 10=E2=80=9312 seconds after the first fault=
,
   sometimes followed by MODE1 reset and VRAM loss

On October 13, a GPUVM lifecycle trace captured 18,386 events without
reported loss, starting before VM creation. It did not show a software
mapping/PTE update for the first faulting VA (0x800901108000, PASID 14,
VMID 3). However, we cannot confirm the actual hardware PTE/TLB state, or
which shader instruction issued the access.

We have also built an isolated RadeonSI command/descriptor recorder and
verified it with a real EGL test, but have not yet captured the operation
responsible for a desktop fault.

Mesa report: https://gitlab.freedesktop.org/mesa/mesa/-/work_items/16584

Related Navi 22 report:
https://mail-archive.com/amd-gfx@lists.freedesktop.org/msg152661.html

Could you advise:

   1. Does this signature suggest an invalid shader-generated VA, a
   GPUVM/PTE update or invalidation race, or a known Navi 22 issue?
   2. Which kernel tracepoints or diagnostics would reliably establish PTE
   update and TLB invalidation completion for the faulting PASID?
   3. Is there a known patch or a targeted, reversible workaround worth
   testing?

We can provide sanitized journal excerpts, incident timelines and selected
devcoredump metadata. We would prefer not to publish raw VRAM or
user-memory contents.

Thank you.

--000000000000871c7a065f9e0fdc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>Hello AMDGPU maintainers,</p>
<p>I=E2=80=99m investigating recurring GPUVM faults on an RX 6700 XT (Navi =
22), with symptoms closely matching the October 5 report about UTCL2/TCP pe=
rmission faults on the same GPU.</p>
<p>The issue has persisted across two physical RX 6700 XT cards, multiple k=
ernel/Mesa/firmware versions, KDE Plasma and Hyprland. Our retained evidenc=
e index identifies 33 separate gfxhub fault episodes through November 5, 20=
26.</p>
<p>Recurring signature:</p>
<ul>
<li>gfxhub, UTCL2/TCP shader client</li>
<li>Non-zero PASID/VMID</li>
<li>READ faults with PERMISSION_FAULTS=3D0x3</li>
<li>WRITE faults with PERMISSION_FAULTS=3D0x5</li>
<li>MAPPING_ERROR=3D0</li>
<li>gfx ring timeout typically 10=E2=80=9312 seconds after the first fault,=
 sometimes followed by MODE1 reset and VRAM loss</li>
</ul>
<p>On October 13, a GPUVM lifecycle trace captured 18,386 events without re=
ported loss, starting before VM creation. It did not show a software mappin=
g/PTE update for the first faulting VA (0x800901108000, PASID 14, VMID 3). =
However, we cannot confirm the actual hardware PTE/TLB state, or which shad=
er instruction issued the access.</p>
<p>We have also built an isolated RadeonSI command/descriptor recorder and =
verified it with a real EGL test, but have not yet captured the operation r=
esponsible for a desktop fault.</p>
<p>Mesa report: <a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/work_=
items/16584">https://gitlab.freedesktop.org/mesa/mesa/-/work_items/16584</a=
></p>
<p>Related Navi 22 report: <a href=3D"https://mail-archive.com/amd-gfx@list=
s.freedesktop.org/msg152661.html">https://mail-archive.com/amd-gfx@lists.fr=
eedesktop.org/msg152661.html</a></p>
<p>Could you advise:</p>
<ol>
<li>Does this signature suggest an invalid shader-generated VA, a GPUVM/PTE=
 update or invalidation race, or a known Navi 22 issue?</li>
<li>Which kernel tracepoints or diagnostics would reliably establish PTE up=
date and TLB invalidation completion for the faulting PASID?</li>
<li>Is there a known patch or a targeted, reversible workaround worth testi=
ng?</li>
</ol>
<p>We can provide sanitized journal excerpts, incident timelines and select=
ed devcoredump metadata. We would prefer not to publish raw VRAM or user-me=
mory contents.</p>
<p>Thank you.</p>

--000000000000871c7a065f9e0fdc--
