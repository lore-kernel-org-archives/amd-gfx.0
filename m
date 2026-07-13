Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721E0C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 11:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E52B710E5A0;
	Mon, 13 Jul 2026 11:11:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lv1Xqs+W";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16F6B10E5A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 11:11:48 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so11034065e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 04:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783941106; x=1784545906; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M613pkaKer9S+db3Hp+sqeIRTe9YrFMGUhpdDvMiEU8=;
 b=Lv1Xqs+Wxk9M+SSjvn2NzQD+dEcPtNK8lB8gn3B62eELdLDFtqZNRTGG8ASFwSsW0s
 cJ/xaCC+TRLuoRjshpJOTc7yn/b1ECxyuPnBjue5Gwc9B2839XCiXTsWevHgniP+PnKl
 6yWfIuQjVnEtm0fpeWQFim1yHpYSEXKqFW3d+gzSS1KpLQSQn9hfxey7J6fWQoQXWIcT
 UfE3sd978mGqu2D3sXP5kzWkh0Wigk1dA4/StSvTzSiaXut+0ms9r8F6vVlA4ikiH11/
 mhwWMwepVK7V6rlB/Gz91BLlLmx5lMo4eGfnzlc4r71kD5raHTLRRLOY1bqC2UUAZ61y
 y2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783941106; x=1784545906;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M613pkaKer9S+db3Hp+sqeIRTe9YrFMGUhpdDvMiEU8=;
 b=YBowE+yK0EDua8en9ZmBh05ngI0Oi6vMROep9puvZPx+P//11mh2QWDoHZigcaPyht
 LhM3a0L4/Yr5bhfSU5bqw9wpcfr4A+tikH7Vgro8xzEregKXQIfqgK1Qc7uvl+DGbo8a
 83bblKGOltZ7IuZoHKvhVB15XMgLNU+9wFTffD6I+PJU8JdCT/DQjaLJYXdnD4AR36cA
 dd1t0dFJdqqpnDV0TcHkjEFksE22lrlxvr9H0DK+RlMMbKmHS/M+vScNZB4cvfihpOb8
 Do3VDoqRQ4Op1V2e2ys0G4Ib3IPSzGekhtKEFFvSGDNqYQegXtEShodkCAeVcC5xqrGZ
 1Yqw==
X-Gm-Message-State: AOJu0Yxwz0slBAz1qt6t9265qstlb216vGgLRBJW65FimRWHzJXl4Nz1
 Xn3QNYHw+3O7SZdbO7Rt7Z/o1r4wrbKFU+3k2za7won1187wBydf98LBgP+XvQ==
X-Gm-Gg: AfdE7cnjH6GnGib59vS1UttuRyQBSD06ptKMaS0V5znvm+y/wKnDua4lauDgdJWGi1/
 n7zbYk9fxRuGAEDKYGo+pIMqBQ1XmMyw+1fliRMMJ5fVHtAMf8c4T0qw/Dq05yqvFCIzNb0zE5g
 WaaDtcwunqY7kGZFPxZz4N/RFDUBVrntluXAdR9Zvo7QsoAk6ev/nxK3HsDWTBELS++X+3ZLtMs
 WUd/PUHIw/PN+eTNLIWU0Oaqsa+skwcLW4LYY+mjuKLGH3ls71Iga2OxS3O/NL8hWJghyh5jiQD
 F7jRD19sNuG9g+8/ISvl2j73LaOBCBHqV4L4YCBhr1HcTZ4lEcUO+EzNgTH6UCzb+Vb2a7w3ITl
 LkliPIK3yIjKzys7HT6Xw6m9dmpkCxFFdaEY8moO0vpf/xAJk+1eTnnnTY3lsG16Hr/+7f9xJvl
 9Ig9AywnK3sSZl8QWl4wAwWLD71h0EZzqWVn74XK1FzL80xFkyoUFekKpcnxI=
X-Received: by 2002:a05:600c:468e:b0:493:de89:61b with SMTP id
 5b1f17b1804b1-493f882d74cmr98580265e9.26.1783941106288; 
 Mon, 13 Jul 2026 04:11:46 -0700 (PDT)
Received: from timur-hyperion.localnet (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f87b03ebsm175017945e9.7.2026.07.13.04.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 04:11:45 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <natalie.vock@gmx.de>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] drm/amd/pm/ci: Don't disable MCLK DPM on Bonaire 0x6658
 (R7 260X)
Date: Mon, 13 Jul 2026 13:11:43 +0200
Message-ID: <5CyapnyQRMWqVd6eVa9xiw@gmail.com>
In-Reply-To: <f903ef1d-0d2d-4b71-afc2-e86207db7e8a@leemhuis.info>
References: <20260713061443.32561-1-timur.kristof@gmail.com>
 <fMZgsndLRnm1-Yt6VBK1JA@gmail.com>
 <f903ef1d-0d2d-4b71-afc2-e86207db7e8a@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Monday, July 13, 2026 12:56:39=E2=80=AFPM Central European Summer Time T=
horsten=20
Leemhuis wrote:
> On 7/13/26 12:00, Timur Krist=C3=B3f wrote:
> > On Monday, July 13, 2026 10:28:08=E2=80=AFAM Central European Summer Ti=
me Thorsten
> >=20
> > Leemhuis wrote:
> >> On 7/13/26 08:14, Timur Krist=C3=B3f wrote:
> >>> What I expected to happen is that the GPU would simply use
> >>> its maximum memory clock, and indeed this is what seemed
> >>> to happen according to amdgpu_pm_info which reads the
> >>> current MCLK value from the SMU.
> >>> However, some users reported a huge perf regression
> >>=20
> >> Were those private reports? If not, please consider linking them in the
> >> trailers using Link: or Closes: tags, as explained in the patch
> >> submission guidelines (and mandated by Linus, see the quotes and links
> >> in
> >> https://www.kernel.org/doc/html/latest/process/handling-regressions.ht=
ml#
> >> on-> the-importance-of-pointing-to-bug-reports-using-link-closes-tags =
for
> >> details).
>=20
> Thx for the reply!
>=20
> > There is no bug report. I had a conversation on Reddit which brought my
> > attention to this issue, then I actually plugged in the GPU, tested it =
and
> > noticed that there is indeed a problem,
>=20
> FWIW, we occasionally link to reddit threads as well, but sounds like
> this would not make sense here.

There are no details about this on Reddit. I just heard that somebody=20
experienced a slowdown with this specific GPU starting from the time when m=
y=20
previous patch was backported and I realized the PCI ID matches what I adde=
d=20
in my previous patch. So I got suspicious that maybe it doesn't work as I h=
ad=20
thought. Then I just tested it for myself and found what I explained in the=
=20
commit message here.

I apologize for the trouble.

>=20
> BTW (feel free to ignore this if you have no idea): I first had wondered
> if there is a bug report about this in
> https://gitlab.freedesktop.org/drm/amd/-/work_items and wanted to search
> if the culprit was mentioned anywhere. Do you by chance know if that is
> somehow possible?

GitLab can show when a commit was mentioned, if it's a commit hash that the=
=20
specific GitHub instance knows about. However I'm not sure how reliable tha=
t=20
is, because the same commit may have a different hash depending on which tr=
ee=20
you are working with. It may not know that the different hashes are really =
the=20
same commit.

>=20
> To provide an example of what I want:
>=20
> https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16043#note_35=
638
> 09 mentions commit-id 2914709c (Revert "drm/i915/backlight: Remove
> try_vesa_interface"") -- but I didn't find a way to find tickets then
> refer to that commit, for example with a search like this:
> https://gitlab.freedesktop.org/search?search=3D2914709c&nav_source=3Dnavb=
ar&sear
> ch_code=3Dtrue
>=20
> Is there some trick to do this?

=46or that example, if you open the commit link:
https://gitlab.freedesktop.org/drm/i915/kernel/-/commit/
2914709c914101eb704e01bed2351070d4161ccf

You can scroll down and see that the commit was mentioned, and you can then=
=20
click on the issues where it was mentioned.

Hope this helps,
Timur




