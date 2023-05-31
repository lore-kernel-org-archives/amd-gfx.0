Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1ECC7EE23
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 14:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3152510E4E3;
	Wed, 31 May 2023 14:01:44 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3E6310E4CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 14:01:41 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-39a55e5cfc0so446969b6e.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 07:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685541700; x=1688133700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NmSohdWMnAe81p4GCNaatbOvCm/b5tb8VhjgYuv4c5c=;
 b=hCBeeo2sDvO3d7msyiApn9UO5v1hokT3kYgu6hZVxtFFfOkZvwKJa2obY5qnvXp4NT
 CM9K9RB23xSvd3je3HDPfLw2MR21NYhGnCz/9LSJ7UChbd8M9m572nLgw1vFvZ3k4h1Z
 ZdV5FwA/2B7MjZ8ygPB3qnNcMSS4s2nj1UkH66le2zH18SXGgy1p7zPhtnFPEFGCaljj
 au/I7vKqn6fE583PeR+C/t4Vb8eybijuA/5RH/+xNte+JrFDn7dP2UvUqGpw9QULHXQK
 m4I7Nx/mnNo8mKuJkNTAhRdJfwNVghOZWmLYAtHVrMd5a6u+MVLB5Mi3vLf+yTdusVKJ
 xyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685541700; x=1688133700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NmSohdWMnAe81p4GCNaatbOvCm/b5tb8VhjgYuv4c5c=;
 b=M3d/uaqrJSp2x4HSbufLEs3O9sEpXENAS14SY2h+GfSpZ7RCgV+sh0/PHmC1nPi9h1
 IwHixFJCio7eU3lHoIGTMdfltxJ7IkaoxFPprry3p2Oa8hyj+ZOSX57rgIDoRXmZuCRC
 Cd0YSpqB9zqG0fj6ui0R8+VtSJYxaBoMIld0BYFvtk6btgYKEvqnfoX0Ra79hwpuRTtJ
 cAAfM6nWk+BxOP/aH2YbC/sm5TZwyPHQgoPoN36AFWXUQAS2a183zjvQieBM6RbasNgo
 tmlJpQnk21nCLTqdkRY1RMSP2kljeuJAT20181eUILtPZm/bfwOlCHycqcr5EsHpYucU
 vN/Q==
X-Gm-Message-State: AC+VfDzzycHnBhymAcoCTqmDeEU33y6PIiuKkZ3nFSGZZmix7fEX7FUI
 CGRzqlJ/dTVAnOpF9FhxVmuqaE2CahrLmY7jqW6lk5R+yQE=
X-Google-Smtp-Source: ACHHUZ5j5RsGk/68qtJQV5RUzbdCFKKKXXnpUpKKDzDambF8EdbW/2zUoR+OR8vPWNr4oXZpEko8uegNL2CSPJn1d8E=
X-Received: by 2002:a05:6808:634d:b0:398:282e:4c81 with SMTP id
 eb13-20020a056808634d00b00398282e4c81mr4191292oib.19.1685541700649; Wed, 31
 May 2023 07:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <DM4PR12MB515262B810158F1D3C6E8324E39B9@DM4PR12MB5152.namprd12.prod.outlook.com>
 <70baf20a-dd86-af46-5d4d-d807d537ef68@daenzer.net>
In-Reply-To: <70baf20a-dd86-af46-5d4d-d807d537ef68@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 31 May 2023 10:01:28 -0400
Message-ID: <CADnq5_OXU6AC7JZm8bfM=eQuDEbMgnk3YmFCh2Gn1cEspfh_Lg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx9: switch to golden tsc registers for
 raven/raven2
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Zhang, Jesse\(Jie\)" <Jesse.Zhang@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 29, 2023 at 5:45=E2=80=AFAM Michel D=C3=A4nzer <michel@daenzer.=
net> wrote:
>
> On 4/12/23 03:23, Zhang, Jesse(Jie) wrote:
> >
> >   Due to raven/raven2 maybe enable  sclk slow down,
> >     they cannot get clock count by the RLC at the auto level of dpm per=
formance.
> >     So switch to golden tsc register.
>
> At least on this ThinkPad E595 with Picasso, the issue with this change (=
and the corresponding fbc24293ca16 "drm/amdgpu: change the reference clock =
for raven/raven2" & 9d2d1827af29 "drm/amdgpu: Differentiate between Raven2 =
and Raven/Picasso according to revision id") is that the GPU timestamps rep=
orted via the AMDGPU_INFO ioctl are no longer consistent with those reporte=
d via asynchronous GPU queries (e.g. via glQuery with GL_TIMESTAMP). The la=
tter are still affected by clock changes, and even when the clock doesn't s=
top altogether, they still tick at 25 MHz, so the two kinds of GPU timestam=
ps keep diverging further.
>

fbc24293ca16 "drm/amdgpu: change the reference clock for raven/raven2"
would also affect that.  Were you seeing the same results with that
patch as well?

Alex


> This makes it impossible to determine the wall clock time at which a cert=
ain GPU job finished. GNOME's mutter uses this for adaptive frame schedulin=
g.
>
> You can see the issue with the piglit test arb_timer_query-timestamp-get =
or with the Vulkan CTS tests dEQP-VK.pipeline.monolithic.timestamp.calibrat=
ed.*. (Note that some of these tests could already fail before with GFXOFF =
enabled, the symptoms are slightly different though)
>
>
> An ideal long-term solution for this might be to modify the GPU microcode=
 to use the golden registers for asynchronous timestamp queries as well.
>
> In the meantime though, these changes need to be reverted for 6.4, at lea=
st for Picasso.
>
>
> --
> Earthling Michel D=C3=A4nzer            |                  https://redhat=
.com
> Libre software enthusiast          |         Mesa and Xwayland developer
>
