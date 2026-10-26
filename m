Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4409606A324
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gbQkrurB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AF6F10E23C;
	Mon, 26 Oct 2026 22:39:00 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C51E10E23C
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 22:38:54 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so26967175e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 15:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793054332; x=1793659132; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ExEBHL91AHZPccTTVsfV2RwDubl4U/MDnUzhNG5fhcQ=;
 b=gbQkrurBw8iBaGPvQlLzXaC+ebkNvshFJ6SI1fANcIRJtasGK5qyy0p1uh3GQCO4VI
 ahxXJdam+hDZdXc/T++79tocch7r4v/nP3EG2+6ZjLanGkTtJdxRFlUO/h6T2cfn6fs8
 h9ATno5fSbHz4l6oUzbslsqXOYIOpt7Zggt7L21KrgvvvvK4ybXk4DPdMslwNSyMiufl
 5Izo/iADOT+s2Azzv0yQNE1f1WEPiPfruA6KmFsLqdePSCpjAwAGm84pLkzKCefcaiOh
 BBLdWM6YlwqSxinMc2cbH8ibqlIHJy91fzLCK0o2Fy+SATUTNW+LxN+C1wnDj/RP8lxJ
 0sWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793054332; x=1793659132;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ExEBHL91AHZPccTTVsfV2RwDubl4U/MDnUzhNG5fhcQ=;
 b=c2Ta9LDABeHLD7D6fLs6uYlKRj/pbVTs8YWhJ+YrCPDP8k/HoMQ+tg3w+CPML7Fykn
 aLV7ViOyA49XhPoVCsME8N28eGjDlGHCWMZLQFwJh1XEc/uY8V59UL8XFKO5/Ud2r+iq
 b1D+OMgY1lxUuISQixWqmw6Kg9aksB0+9APBJiyUjuicbzJuXstQAaN2IfstYW5h+n+S
 +xFTpXOtV/VoO5uYLnpLPoAx5Xsw6wnOXu2R6cVdYUi/D2AJtmIs+HiDpjApnCHt7gYD
 60DlbP+9GRCLRuls07BQHhAuvhtbyRbGkSXD6UABWxUv72ZL2zrSe7WVYKQxISFX3H2N
 eu9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkNlfixZeEZz3ztpCYMBpAlDxYznNE29sCHpgmEpZoYL5eNUw5Ir25U0hptzFO3qS3PfKkxrkD@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJU5Yy3A9627DouApm9AirGqKFAQB8PVePalES9GG2o3d3aoaq0
 l60IAWYlThoiRRU4lapR6ki9iXau8N3Q9sewH0gXx6tzb/mnukabrCpW
X-Gm-Gg: AYBFou2LxNWqmkBUESZSZZ23ARF2I3B+PkEXWppJbT6+9SF/zXOJrzBJrGskdc2QriV
 0pL3OkSyiCOPa6OVMUGCs2CTGIVi0w7xG+2uGjuMMlP1FIGRzd7yEIBv8UMOB0YGvAksUmkcjip
 UE1a9jw5hzkw3IInZRLt6abSBB8ptJQTDMp4uSOtz7HUcrmT5+tGpmy+aRYjOUxsn2Mg/vDrFEN
 fsOj9VndL4uZ0NDmy25l37mIEwZ9NBtmaOB5Q2UopFUgqs231qlQvUsws+UnLSQ8qFtMy9nYciG
 Bn9N5gnjC7drnplh9YLoQ11n5H7HDf14tGGrgE0r5Vf+z+WxDumKDLWprtAE+NbclNns4yFYjJV
 8fe0twegUwc2czfTyXBh5PovPjHHkKsTU+TzOrm1IBr7STgwLTWmOFjymIzWgx2o8M+SL+9AuJ1
 d6M3pDdZR1emyDe2bUhBFuh9aNJih0XIIPWW8ACYT/I/6RzO+eR+Xlyt2RasUlAEF8CrTXh713V
 gI/KRHkPvY5yzw0mz1ovcziBxRwsoC+ZFUbs1S+s3Ex5bn4sl5dlmQScyZiq9ODVSzT1ynVkMdP
 qFkAfAhEUo2wUqw=
X-Received: by 2002:a5d:4f11:0:b0:48e:2f7e:bdbb with SMTP id
 ffacd0b85a97d-48e3ebb84b1mr11310145f8f.50.1793054332309; 
 Mon, 26 Oct 2026 15:38:52 -0700 (PDT)
Received: from [192.168.1.253] (4E5C1F56.dsl.pool.telekom.hu. [78.92.31.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd48fasm18791300f8f.31.2026.10.26.15.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 15:38:51 -0700 (PDT)
Message-ID: <f5baae8455d060493c72c68d160f8a5b61d9aa03.camel@gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vce1: Fix checking whether VCE1 is idle
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: David Rosca <david.rosca@amd.com>, amd-gfx@lists.freedesktop.org, 
 Alexander.Deucher@amd.com, Natalie Vock <natalie.vock@gmx.de>, Mario
 Limonciello	 <mario.limonciello@amd.com>
Date: Mon, 26 Oct 2026 23:38:50 +0100
In-Reply-To: <48b0f431-2abe-4e9b-b0bb-aff6f4fbf5d8@amd.com>
References: <20261006170352.26722-1-timur.kristof@gmail.com>
 <54fd40c6-f13f-45ed-ba55-ca38052cc3ad@amd.com>
 <Yxz3zvy3ScSroj40wKVDxA@gmail.com>
 <48b0f431-2abe-4e9b-b0bb-aff6f4fbf5d8@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-10-26 at 14:25 +0100, David Rosca wrote:
>=20
> On 10/26/26 14:00, Timur Krist=C3=B3f wrote:
> > On Sunday, October 25, 2026 7:22:04=E2=80=AFPM Central European Standar=
d
> > Time David
> > Rosca wrote:
> > > On 10/6/26 19:03, Timur Krist=C3=B3f wrote:
> > > > It turns out that the VCE_STATUS register bits that we
> > > > used to check whether VCE1 is idle are actually not useful:
> > > > VCE_STATUS.JOB_BUSY doesn't exist until VCE3
> > > > VCE_STATUS.UENC_BUSY seems to be stuck high on Cape Verde
> > > >=20
> > > > Instead, do the following:
> > > > Check that the read and write pointer matches for each ring.
> > > > Check VCE_STATUS.VCPU_REPORT bits to check busy status.
> > > > Finally, also check SRBM_STATUS2.VCE_BUSY just in case,
> > > > although this one seems bogus on VCE1.
> > > >=20
> > > > Fixes: d4a640d4b9f3 ("drm/amdgpu/vce1: Implement VCE1 IP block
> > > > (v2)")
> > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > There's still occasional warning that VCE is not idle on my cape
> > > verde,
> > > but it's much better than the current state where it prints it
> > > every time.
> > >=20
> > Hi David,
> >=20
> > Can you say what the remaining warning says?
> > Do you think we could fix the remaining warning by removing the
> > check for the
> > SRBM_STATUS bit entirely?
> VCE busy: VCE_STATUS=3D0x142, SRBM_STATUS2=3D0x80
> VCE busy: VCE_STATUS=3D0x152, SRBM_STATUS2=3D0x80
>=20
> which does look like VCE is indeed busy.
>=20
> David

It looks like 0x152 has the RB0_BUSY bit set, but 0x142 seems like it
doesn't have any of the busy bits set and only the SRBM thinks that the
VCE is busy but it may not be actually busy. It's hard to judge without
more information.

When do you see the warning? Does it happen after an encoding job or
after suspend/resume? Or...?

Thanks,
Timur
