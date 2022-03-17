Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C19C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 10:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E0A510E777;
	Thu, 17 Mar 2022 10:31:51 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 973BB10E775
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 10:31:49 +0000 (UTC)
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-2d07ae0b1c0so53026377b3.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 03:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+6rubepE5fHPh6eaHtS29OzoXOf/Is2/IKhJ3XCCu74=;
 b=c9tJVuG5fV8b0t6vN8KcsbxKW16PtXQhBnxDXLrNrN+wJ/bO1dbMBYzNW5tyeGqKt1
 pKS8KRz8GjqdCyJWTY4Qu3RRhi5m1gzPKXQS0y9551QuQUnDGORAupsscLlRXMpIDRtI
 hDPDaflLOg3AA8tgeRiyzSGPAni9aqJO/0J4t3uAfHzdy26+TdajhtFcqwl/4S0huiAg
 2x8Kw0/rChpayjBE+lha9S8t3gv+xWXe5p5LxnTs9MZQsydd/XkpzBMMnue9fvPuvE0I
 2lD88TdQUhciEuMkdp+5KJ9FNH/2s9iuYbA2W6S1gdw3hUd07xYdzsAUPJ1bT6muvccw
 frIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+6rubepE5fHPh6eaHtS29OzoXOf/Is2/IKhJ3XCCu74=;
 b=Jv7myR4OxKajNiLJvFw5t6IywOsKxkhXD0MdHKh4jeJ7SwJogIqfUkhPmAfk0N2xSV
 ioOuRB2ABDTZIpohUH4F9Q1d672sIhH7ZE5IzjWarUzHTFm/qBeEc1MwKKotnhlKcmR4
 FCI7Vq5vInX/KUeaCPCtULuR4JJ+/w5TYURNV19l/ModUzmI+4X9iUmjQjZTcoOp9zo2
 8kPOjO/huEvMXbDpzeXfIf4Frmh0n0K4W+OrsFsY+tSwQHynLDAvLc3aGxEO4I0tKAUK
 MLS0tqTOm0Cb+7fmmVYIKiAJhb21XvR+kauFKNuwWFhiToejP8JEqRYOSx6ABzEewkYE
 1I2Q==
X-Gm-Message-State: AOAM532CScJ06m/Wm0j5VLl2Uts5cpddik8gRzTvYS4kmFXMZAuUP+6g
 Ru9XBY3U3o1246sldMIV5SL05pbbyySoqVR3TLgvhQ==
X-Google-Smtp-Source: ABdhPJwfTnded2WRRk7XkfsFR8fdNGlv99Lrq4XWK4lx+aeuze8/cx8IYsrAABNleBujFPMxZZCRr7IvWDPUxrMfaVQ=
X-Received: by 2002:a81:e503:0:b0:2db:6996:1f97 with SMTP id
 s3-20020a81e503000000b002db69961f97mr4875340ywl.423.1647513108644; Thu, 17
 Mar 2022 03:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220308180403.75566-1-contactshashanksharma@gmail.com>
 <CAF6AEGtnXvo=-fKbgSRtAtZ80igqJM2bTKefiLPUsSohU9idNQ@mail.gmail.com>
 <4d768cc9-9a47-473c-b344-4ed34bcb5556@amd.com>
 <f291b94d-b981-5cfb-5422-ca4317d24eda@amd.com>
In-Reply-To: <f291b94d-b981-5cfb-5422-ca4317d24eda@amd.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 17 Mar 2022 10:31:37 +0000
Message-ID: <CAPj87rNUJzTtRSM62aq2ssLY0F673dpaFw2SGh8oMuf3yE6wBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm: Add GPU reset sysfs event
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Rob Clark <robdclark@chromium.org>, "Sharma,
 Shashank" <shashank.sharma@amd.com>,
 Amaranath Somalapuram <amaranath.somalapuram@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alexandar Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On Thu, 17 Mar 2022 at 09:21, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
> Am 17.03.22 um 09:42 schrieb Sharma, Shashank:
> >> AFAIU you probably want to be passing around a `struct pid *`, and
> >> then somehow use pid_vnr() in the context of the process reading the
> >> event to get the numeric pid.  Otherwise things will not do what you
> >> expect if the process triggering the crash is in a different pid
> >> namespace from the compositor.
> >
> > I am not sure if it is a good idea to add the pid extraction
> > complexity in here, it is left upto the driver to extract this
> > information and pass it to the work queue. In case of AMDGPU, its
> > extracted from GPU VM. It would be then more flexible for the drivers
> > as well.
>
> Yeah, but that is just used for debugging.
>
> If we want to use the pid for housekeeping, like for a daemon which
> kills/restarts processes, we absolutely need that or otherwise won't be
> able to work with containers.

100% this.

Pushing back to the compositor is a red herring. The compositor is
just a service which tries to handle window management and input. If
you're looking to kill the offending process or whatever, then that
should go through the session manager - be it systemd or something
container-centric or whatever. At least that way it can deal with
cgroups at the same time, unlike the compositor which is not really
aware of what the thing on the other end of the socket is doing. This
ties in with the support they already have for things like coredump
analysis, and would also be useful for other devices.

Some environments combine compositor and session manager, and a lot of
them have them strongly related, but they're very definitely not the
same thing ...

Cheers,
Daniel
