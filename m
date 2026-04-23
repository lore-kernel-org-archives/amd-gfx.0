Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC66AF9937A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 11:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B56510EFA0;
	Thu, 23 Apr 2026 11:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hYFH0x0M";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E3FA10F0AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 11:34:46 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so106891025e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 04:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776944084; x=1777548884; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0WfnOZbXeCCnN3w3UE+Jw0ce/6J+iDbqFJsV/ehYRCw=;
 b=hYFH0x0MatPnO8keE0AFxfl7rODqHceF53KGDpXbd9nANQdJQEteQhWhpq2u9ammtz
 IXhKEUDxucmEwuS1VFk9iuodShEpihLHawh8S7QyiCrTSsD+f6OVNK4ciRz8lTdjnZ+W
 TUTRclGq+vvE4aa8wHfPr6U+5G8VyxgGMaNDiq/p63yydMoRC+vE+OdPVK5GaXjlYSOL
 FRH2JSmWahi/pW46meXKQ/FY310TorpfR4Ab7Cgrcte5VT1yuZWSUiX/P+A+OWjQjASF
 +xd1pQbtdcOGB0OTMJIvuqchTFtTH01AiwbhkJIyNkIGN3cTfk7qQ22XulG4UCHk1pGC
 /D7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776944084; x=1777548884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0WfnOZbXeCCnN3w3UE+Jw0ce/6J+iDbqFJsV/ehYRCw=;
 b=Ro2yTsdkvEPcd0of++T+oh6pi2d5hXWYtBJ0p6v2eVUENwEo/YXwABGt24EL6vNpLY
 0hVh+XrbA+EVgF4j2nr3pSTF2RH81vtAGeqUuiNe2fa0YuGAOc1L6eQjd3bECfiXDGp9
 94Kr7XPaQ2jgVTAAZmilYvRBHjMldycbW+XBO2HyobKLJkVJWBqvHyrtaul7GXfW4Zph
 bboKly3xwwYQxhDGmeR/FwCbBqVwFFWDMNpm4WMSEmGjqQvk5HVKaZ6t/ZUsCSBqQZ2p
 L1R7jSSW14LMKGH92qXaT/JnJELxjGjMtIUyeELYxoIrNaBaW5noRORL57C1+cIkKmR3
 8I7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KBNfUDPdUD2dhiJv/cMjhG+at9UNWeRkBzpiYM2YzFnBIB9P76YrGKCTR0zh2FOrJKAtlqewf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTHFjYqnpBFl4+Chz8O7GEW+osVA0VSMY/mPEeBbz3XS04kjKU
 lJ7+2X1EmFzdHH+/uOTnfUvmqllnaTOmFRekP3T/TPOShAaM7TOS2Q9d
X-Gm-Gg: AeBDieubxPk/3YWTs3QVZr50QN5npd3h9h9CL/IP4pZK/pXQVIZmeQYHEPFwGy2la9s
 KXEmILgMPgQpaBy2+/v3mX/CZ8S+1px4X2FOSY1A5F+vwAWhgRf/5X82zwLWY9WdwH/ZYwfYy7k
 CHOSudpcBAqxftlo6IoVRizgwn5vlF91PVrO02xiCZabCthwbg0l73oRlUySfgwrXQq1QGwZdSQ
 IhULyMVZDLlm6Kwo4EU3m/6vykUDkNceonCDBdXn5Gpy+dJpU96212QGTJOAzUJo76rPyKt4kJe
 uo5rOzZgwQ9GX6FZFX4EXerrxytpSVvSIdxXiTM0vC1sS7TtNeoPCI+w4rZbHvqdh9RTQYTShhm
 uIMEVYyCI+3DmJTkJi4oEtvMpCOH8ppNtwKP/uZDUt1fnYofaiJnuFn2GgucKi1kYzcOyqE3t3e
 JAFsstwtU4wL42rc9e0k4DTCGSYuoHYVUrng2akgjEzzoyCZhB7a6QCsIXwaGqTZNizIK8ZaneF
 F9KKF7G5E8=
X-Received: by 2002:a05:600c:620d:b0:489:1d23:4524 with SMTP id
 5b1f17b1804b1-4891d23468bmr239536185e9.5.1776944084219; 
 Thu, 23 Apr 2026 04:34:44 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c08faffsm552416145e9.1.2026.04.23.04.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 04:34:43 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Robert Garcia <rob_garcia@163.com>,
 Alex Deucher <alexander.deucher@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Yifan Zha <Yifan.Zha@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] drm/amdgpu: remove two invalid BUG_ON()s
Date: Thu, 23 Apr 2026 13:34:42 +0200
Message-ID: <4885687.vXUDI8C0e8@timur-hyperion>
In-Reply-To: <2026042335-probation-heftiness-7399@gregkh>
References: <20260417074010.1607496-1-rob_garcia@163.com>
 <6064b45a-b8de-4848-856f-383d2d06680d@amd.com>
 <2026042335-probation-heftiness-7399@gregkh>
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

On Thursday, April 23, 2026 1:22:22=E2=80=AFPM Central European Summer Time=
 Greg=20
Kroah-Hartman wrote:
> On Wed, Apr 22, 2026 at 04:11:15PM +0200, Christian K=C3=B6nig wrote:
> > Those points are certainly valid.
> >=20
> > I've also up-streamed a patch which completely rejects userspace
> > submissions who try to use the CE.
> >=20
> > The problem is that those BUG_ON() can lead to a deny of service because
> > they crash the whole kernel.
> >=20
> > A BUG_ON() is only justified if it prevents even worse things to happen,
> > e.g. data corruption or it would crash later on anyway just not so
> > obvious on what is wrong.
> >=20
> > Otherwise we should use WARN_ON().
>=20
> WARN_ON() crashes the kernel as well when panic-on-warn is enabled, as
> it is in a few billion Linux systems :(
>=20
> As this commit is upstream, and in other stable trees, I'll apply this
> as it's not nice to have a simple way for userspace to crash the system.
>=20
> thanks,
>=20
> greg k-h

Sounds reasonable, if you feel this improves stability.

That being said, there are many other ways besides this one for userspace t=
o=20
crash the system equally easily.

Timur


