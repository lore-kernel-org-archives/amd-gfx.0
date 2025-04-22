Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF90C369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 13:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13ECA890BB;
	Tue, 22 Apr 2025 13:01:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OCrVwQPE";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5257F890BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 13:01:03 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2ff73032ac0so536513a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 06:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745326863; x=1745931663; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMQaVeR3x4YkFMJA2BzDkkwgCbMHhGjo7H0lhGLmoyA=;
 b=OCrVwQPEeX9tM2NFXS+Vrb+6q0g3Pz14+EOwhtzIDwzEdRxdD5EC2ik+mt53u9vlxD
 ZFPhGnAHf90EpC+2DM8Me1C8DkG/vp/atmCIjBMo2+QBf7ntf9IwUgGqqsHjkyZMcs8V
 DVwH7qHUl3ppecFY8tCK1l7WUrQ1cME+k75E0H+dv3dIQM2EY49KTysTpg14djcub669
 F452FB8A49Mh2PTeXWA8dUehKTCge5w9EAJoAuxqGkzE2G7KL3LqCT7KDSWfwg8BpSjC
 6CAyXpNPt1/d+CzAVs0fyMqyhQ8X/fTHPyfiL0qNY1fK0ZRdLNi3Z79GvYAN2p/6myRS
 K4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745326863; x=1745931663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GMQaVeR3x4YkFMJA2BzDkkwgCbMHhGjo7H0lhGLmoyA=;
 b=mv81k+woNzQLltUCFIzmAU07I5gFTvRUUgmpCXKxrcg6tNGO/5nmJ/+hVBloS/r8t6
 krt0mT4pMTI3Ni++9iPHuMXJInxIp60N6TWXgq7BksYwzGqoZCqrmfRM4cT2qZEoD9WQ
 ilXll/0gyJBp/QY+sg1LRg1NQbAzt6GZUV3tpcUI8XMpph0X0Aj7QsnBEbONk9r8i6OY
 M6WnDKLL1OH88d0+0kUdAa/MNJW14cjowQyBGPOjcCmPTyonSD/fAiZxOmal85iY2SYO
 qk+yUxMqh+xF3m4pXb4XKrQd9Mkmj0nLCsEPXMIoSwIVVCmniRTTSlnlU9JGyoDKACZ8
 8OFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZCWxt5EnTa3mGC2aRcsSUUx8ZOv3VRI7ME3oyH7fgKRGt+FLpupU3tU081kX9rl8bOItu51pp@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzU4TOLbkNgUU5yi7hhnYbRRZ9hgbtcCyBakZCWgbgQEiWo3njz
 RmyMFt8R/z8gjG9jB1LrqqMIKTwOgs/+TnhaWT3Razo49TTbxugCbdWhkW3s/AOUtOC5CeJGkeb
 BjuhcP93C1fzf0QY5w5eMMlVVAT+S9w==
X-Gm-Gg: ASbGnctldO+BlME0miQqdevRAqcBUK7t0lMgOBXdlJRlcA+dvyfj9cKEr9VoM0smovO
 VnctHGT7Xcey26bOsPzneJYcilqPZBvLd+4CcUruxsg4ug71N6vO8AFAyRqGk3Oc73Oseom0d8C
 /78GvkjJx9dVoft3ckH52kkw==
X-Google-Smtp-Source: AGHT+IE2rBFaVyNkbpbvryC/1IsZvy1wKkM+KnDrUqSyaIMMwOtvPffaka1pMn5zR7USL3XmQIxDElZFWPTj2vbI4Js=
X-Received: by 2002:a17:90b:1b44:b0:2fe:b972:a2c3 with SMTP id
 98e67ed59e1d1-3087ba5ea96mr8603347a91.0.1745326862532; Tue, 22 Apr 2025
 06:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
 <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <D980Y4WDV662.L4S7QAU72GN2@linaro.org>
 <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com>
 <SI2PR06MB504138A5BEA1E1B3772E8527F1BC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CADnq5_M=YiMVvMpGaFhn2T3jRWGY2FrsUwCVPG6HupmTzZCYug@mail.gmail.com>
 <D9CT4HS7F067.J0GJHAGHI9G9@linaro.org>
In-Reply-To: <D9CT4HS7F067.J0GJHAGHI9G9@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Apr 2025 09:00:49 -0400
X-Gm-Features: ATxdqUH2hkViMgnErFFpI6VX1e4K3fATFOHKYd1vBRtymzw7NTvXXweUuy0lPgM
Message-ID: <CADnq5_ML25QA7xD+bLqNprO3zzTxJYLkiVw-KmeP-N6TqNHRYA@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1JFR1JFU1NJT05dIGFtZGdwdTogYXN5bmMgc3lzdGVtIGVycm9yIA==?=
 =?UTF-8?B?ZXhjZXB0aW9uIGZyb20gaGRwX3Y1XzBfZmx1c2hfaGRwKCk=?=
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Fugang Duan <fugang.duan@cixtech.com>, 
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "frank.min@amd.com" <frank.min@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "david.belanger@amd.com" <david.belanger@amd.com>, 
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 Peter Chen <peter.chen@cixtech.com>, 
 cix-kernel-upstream <cix-kernel-upstream@cixtech.com>, 
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Apr 21, 2025 at 10:21=E2=80=AFPM Alexey Klimov <alexey.klimov@linar=
o.org> wrote:
>
> On Thu Apr 17, 2025 at 2:08 PM BST, Alex Deucher wrote:
> > On Wed, Apr 16, 2025 at 8:43=E2=80=AFPM Fugang Duan <fugang.duan@cixtec=
h.com> wrote:
> >>
> >> =E5=8F=91=E4=BB=B6=E4=BA=BA: Alex Deucher <alexdeucher@gmail.com> =E5=
=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816=E6=97=A5 22:49
> >> >=E6=94=B6=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.org>
> >> >On Wed, Apr 16, 2025 at 9:48=E2=80=AFAM Alexey Klimov <alexey.klimov@=
linaro.org> wrote:
> >> >>
> >> >> On Wed Apr 16, 2025 at 4:12 AM BST, Fugang Duan wrote:
> >> >> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.=
org> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816
> >> >=E6=97=A5 2:28
> >> >> >>#regzbot introduced: v6.12..v6.13
> >> >>
> >> >> [..]
> >> >>
> >> >> >>The only change related to hdp_v5_0_flush_hdp() was
> >> >> >>cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing H=
DP
> >> >> >>
> >> >> >>Reverting that commit ^^ did help and resolved that problem. Befo=
re
> >> >> >>sending revert as-is I was interested to know if there supposed t=
o
> >> >> >>be a proper fix for this or maybe someone is interested to debug =
this or
> >> >have any suggestions.
> >> >> >>
> >> >> > Can you revert the change and try again
> >> >> > https://gitlab.com/linux-kernel/linux/-/commit/cf424020e040be35df=
05b
> >> >> > 682b546b255e74a420f
> >> >>
> >> >> Please read my email in the first place.
> >> >> Let me quote just in case:
> >> >>
> >> >> >The only change related to hdp_v5_0_flush_hdp() was
> >> >> >cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing HD=
P
> >> >>
> >> >> >Reverting that commit ^^ did help and resolved that problem.
> >> >
> >> >We can't really revert the change as that will lead to coherency prob=
lems.  What
> >> >is the page size on your system?  Does the attached patch fix it?
> >> >
> >> >Alex
> >> >
> >> 4K page size.  We can try the fix if we got the environment.
> >
> > OK.  that patch won't change anything then.  Can you try this patch ins=
tead?
>
> Config I am using is basically defconfig wrt memory parameters, yeah, i u=
se 4k.
>
> So I tested that patch, thank you, and some other different configuration=
s --
> nothing helped. Exactly the same behaviour with the same backtrace.

Did you test the first (4k check) or the second (don't remap on ARM) patch?

>
> So it seems that it is firmware problem after all?

There is no GPU firmware involved in this operation.  It's just a
posted write.  E.g., we write to a register to flush the HDP write
queue and then read the register back to make sure the write posted.
If the second patch didn't help, then perhaps there is some issue with
MMIO access on your platform?

Alex

>
> Thanks,
> Alexey
