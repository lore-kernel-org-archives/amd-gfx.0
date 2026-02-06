Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77BEE78D4C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 08:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E4CD10E3A3;
	Mon,  9 Feb 2026 08:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mXLvoL6A";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6EFA10E8C6
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 18:55:08 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4806fbc6bf3so11884845e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Feb 2026 10:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770404107; x=1771008907; darn=lists.freedesktop.org;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:from:to:cc:subject:date:message-id
 :reply-to; bh=IYA5f+pziUiONlslby8EJFpkAX1gO6llOpk96yLwpKw=;
 b=mXLvoL6AJKnTxGLED/O3O0+7th5dmGqzjy0ZM77yg1lcMBmkSv7YBIToR0t3fbc386
 HFrUP9Qui4+zAldfFhmtY5YezQIZSudZRGpIDgeVevMbj4qhpP3B1Sq6AAMd/VC1zPUw
 G2tGUeVER26zafRmJSH+vS9eUmi845hi2ZQa62KjGg8RRqC15ETmrqXcYXUaoHU+lKh/
 IL5clm3OjEQam8SNZqVmkONAcouWLdUgEAUzI9IhJ23bPoCkyUEcSM/aElOXWBk+5oyC
 NZ8wkub2/jHgERlv8rRXSOlFi100jKjyxzbyxIQ8K/kfgkX6w9RY8ru5WjDVODR/xvC7
 FeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770404107; x=1771008907;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IYA5f+pziUiONlslby8EJFpkAX1gO6llOpk96yLwpKw=;
 b=k3sUW6lRu5ykIfc+VfB0129rcYOLKSZbC2a+rIiRc478UDn3JwQ7Vkpmxpq9YYpmf0
 1H3VYDcEbZ4aFLMA82BQsB5UXGeEJkvHhRfD3WwhvxJIbz9H3Y//R70qSfsifYdMoH3M
 bi9PwLBHkEzlSAer6NHy+1mSQzzWLgBKZc25kifrDoYe0yzfyiO4fGJ4J3XNkhZTPr7F
 XwlBaLIpHVddmvlzwgeZF4r4hAt03UveXkgq+2yVbZiuZBK65gYl5bjHHwLi4Ii5Tjzk
 lb9bii0qshAuBznFbGSo6Ekw1wyeRNYNH5NWeuXLDWbT61IL6wr3hrPwOAWftk0T/D9o
 URqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfBbzRLXW1DtKX5C3MhXwnO4kwo++4/40DS3GUAFEC7zaWALNW4SqevrnABPD08d20dZNumDIN@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2yf9gro6Dmvsv/Um0dqgRdzKpKzzhS53J3IptmZKIu7VPIpN0
 oT7O8oKOiklyalvZxtRsg6F+FW4N0g97vqDXXoXMIB1uRkXkHK1kSmt4
X-Gm-Gg: AZuq6aJ07gCWgg7ShpT1xkNA6VW8PlHKAl78Yquel3RwER0jxyqkmMBPCoYeajr2I71
 1IXmUEhNgfOz9eSCff3ftIahxPpS3Nh9RlCEs0lWLcunTCSGi1O0yaKMpP9T4HHS0Z5/u3gSjJL
 PzkRDorD8pvrKjkiHy9FrZKqMqSeQm8S2CykTwHwiPr+WVcOuRhenKPhgcxbusPeaoVpXpkZSzf
 PLap3hXu1rMkbcTRO0eB3mu1kc7Vv8lqYCDRKif+tiw6jYXPDafXVhw1+rXylaKO+FG/TuZUEJM
 WtOuCqVZO/QD1ye32tTGLTbWjZOy3vWwttWfCGw45bil8OO8aGECzDrr68tC7fgvNMZEcuWliup
 Wwr7/KgJBYCCXAlomYV/AHYkCjvOZfsXbTSzNjbQDc92qTSy+a3NgzM6ki0c4nas0tXAHjqFy2s
 150KbC1EHeG04tmFFHw+qvzeFe0npYmD54TdLotVq+xMBB4/Xd1Q==
X-Received: by 2002:a05:600c:4590:b0:47e:e20e:bbb2 with SMTP id
 5b1f17b1804b1-483201dc5c5mr54617565e9.7.1770404107101; 
 Fri, 06 Feb 2026 10:55:07 -0800 (PST)
Received: from smtpclient.apple ([2a01:cb10:3a0:bf00:5dc6:926:30ec:c0e0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296b2d43sm7594818f8f.8.2026.02.06.10.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:55:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Maxime Schmitt <maxime.schmitt91@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: Accelerator/GPU top
Date: Fri, 6 Feb 2026 19:54:48 +0100
Message-Id: <0E8D538D-678A-4899-A44C-297A9F520103@gmail.com>
References: <3be1ec57-d078-40f3-8eb6-d25496fb7297@amd.com>
Cc: Vock Natalie <natalie.vock@gmx.de>, Deucher Alex <alexdeucher@gmail.com>,
 list DRI developers Maling <dri-devel@lists.freedesktop.org>,
 Airlie Dave <airlied@gmail.com>, Vetter Simona <simona@ffwll.ch>,
 list amd-gfx <amd-gfx@lists.freedesktop.org>,
 David Francis <David.Francis@amd.com>, coelacanth_dream@protonmail.com
In-Reply-To: <3be1ec57-d078-40f3-8eb6-d25496fb7297@amd.com>
To: =?utf-8?Q?K=C3=B6nig_Christian?= <christian.koenig@amd.com>
X-Mailer: iPhone Mail (23C71)
X-Mailman-Approved-At: Mon, 09 Feb 2026 08:41:30 +0000
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

Hello,

Indeed it=E2=80=99s not efficient but that=E2=80=99s the only exposed way we=
 have to retrieve the information at this point (for drm drivers exposing me=
trics through fdinfo).
It doesn=E2=80=99t require any extra privileges if one is only interested in=
 the user owned processes (which is most use cases as far as I know).

I think that there was a discussion at some years ago from Intel on the kern=
el mailing list to expose the process list using drm.=20
Maybe having a way to query which processes (and file descriptor) use drm an=
d then only going through the relevant fdinfo files would alleviate most of t=
he inefficiencies (modulo privilege problems for other user processes).

Also I haven=E2=80=99t implemented use cases where the GPU doesn=E2=80=99t u=
se DRM, e.g., AMD CDNA that is going through rocm (I don=E2=80=99t have acce=
ss to a card to test it).
I also noticed some instances, where the driver doesn=E2=80=99t report any u=
sage, although it=E2=80=99s actually using the encode/decode engine through V=
A-API with a DRM handle.

Cheers,
Maxime

> On 6 Feb 2026, at 14:38, Christian K=C3=B6nig <christian.koenig@amd.com> w=
rote:
>=20
> =EF=BB=BFOn 2/5/26 20:25, Natalie Vock wrote:
>>> On 2/5/26 19:58, Alex Deucher wrote:
>>> Has anyone given any thought on how to support something like top for
>>> accelerators or GPUs?
>>=20
>> top for accelerators/GPUs kind of exists already, see [1] or [2].
>> Clearly, this problem has some kind of solution (looking through the code=
, it seems like they check every fd if it has a DRM fdinfo file associated (=
which is indeed not particularly efficient)).
>>=20
>> Maybe it's worth asking the authors of the respective tools for their opi=
nions here?
>=20
> That is a really good point. Adding Maxime Schmitt and Umio Yasuno on CC.
>=20
> Let's hope I've picked the correct mail addresses.
>=20
> Christian.
>=20
>>=20
>> Natalie
>>=20
>> [1] https://github.com/Umio-Yasuno/amdgpu_top
>> [2] https://github.com/Syllo/nvtop
>>> We have fdinfo, but using fdinfo requires extra
>>> privileges (CAP_SYS_PTRACE) and there is not a particularly efficient
>>> way to even discover what processes are using the GPU.  There is the
>>> clients list in debugfs, but that is also admin only.  Tools like ps
>>> and top use /proc/<pid>/stat and statm.  Do you think there would be
>>> an appetite for something like /proc/<pid>/drm/stat, statm, etc.?
>>> This would duplicate much of what is in fdinfo, but would be available
>>> to regular users.
>>>=20
>>> Thanks,
>>>=20
>>> Alex
>>=20
>=20
