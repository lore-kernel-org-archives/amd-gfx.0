Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E9BD65C69
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 15:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E56C010E722;
	Wed, 17 Dec 2025 15:46:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nmjWlLPF";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DCD010E581
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 15:46:44 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-bc0d28903c9so247855a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 07:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765986404; x=1766591204; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wV0ZmSQtWT4T4cO89/t5szkEfFx0tbX7xefiwZqLdg=;
 b=nmjWlLPFE1Aw96LbfoRwxU/RmIClmzY1avpQpqP3lV87x5wRuH1FCT5PmXg5fBSPMl
 ryRK7yk4PMPyvct43MshLBQ6po9YLAimfRB5jU79A2J8KfdyaSN7Vroytns/wAz3h1xs
 t5q7pV52RFv+WZHF5TLMWhWulCIpF1bppa9/IN402uqche+99bSOdhqL5ElnGhu6JM86
 JAqD+IwWxSiwRd6Mske8P4DBSOTWQsPygGVjrdlW6bjgkvZJXPmrlsy1PsdUovcuEeOT
 OlgLUg4qPLfzWZcDhEJZR8mxoX6EudOcreKZ/QhGqoOjm9f0kpeT90jlsU52/fQaQTr3
 s7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765986404; x=1766591204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+wV0ZmSQtWT4T4cO89/t5szkEfFx0tbX7xefiwZqLdg=;
 b=M/OsGQaM9USJAgNGxcNVs7qDoXUrqHksIKMu55jplIK/BboH0oCvys0q8mz0/LafUX
 Tf9z0mo5s06bZSLLaMqZdfxKOGhD+1RJrrJ45Uyja0g/smTnll00QVgI/IbvXK7gwXay
 O7FIBj9zJetYaWFcLA7A0clDig9KK4V6AlS6ppqkC8ED1h6ifhLrHXtk/yo+ezMPl25R
 9qAMtJZ9amp+zoI9IAkbj1Ye9Pc6cHexZCOmDxJ0D9R/lhjSl3qTuCG8SRWxt8oUxkM6
 IZdpPaHZ8PuSwMbEw9cpbeJdU1k1c0cKL0u2apQggh1/qu7+eE06S4D81wzFTfZ/tfDk
 1znQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWETSDHBEJDvlDPn02WCz8EoTbaIOdNoe/RaqocJQzx6RWO3zAYn+I6QLmq3vDjp99gFv0aU4na@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdF85ibG7pUMNyFwSBvQ5CcbeWrSVvKfS9CNqqFt5MeaxlmPVV
 mya+r6IamHwi5L28nhFrAnInlGw9TUw65lf+yVc8Ox7e+6sjDlMIW+YyHyHA47BRQelqsFCyxdZ
 UX0YHtt/NCTJ0Vm/4upLi2R6ycScArB8=
X-Gm-Gg: AY/fxX4LLZRW+eIubT1H6RjhFDUI7ToQTKgP1ulZzd9O+WdlM0+JtC/TwSxfj7Qe1qi
 tkCo5e47y8vc9zDxI1jS7yBGTBirKwOgms0hbqFo8UMlwdwR59Qe3KrCP1j1CVQYYEX6qVFbTPu
 LB3H9g63B+fTP3v+PtBEBFs9t2UCf1eK/g/j4igEFlNCSQz/kTWw14JBkTIzEUxnWd4PmIJi09/
 g9kepiMil4TJtHpJfO6xIHwqZvPQex9SACggGHLrnGSxk3/4H9pzrnWrabT3ulq/5nReWOx
X-Google-Smtp-Source: AGHT+IHfzq169OSSiD5AHUI84fWlWrVIj/O2puINeznx5Eqf1SZdqvPcpNHzjoceq/VGjjpWqLcBH4oPjGJMjPEnEa4=
X-Received: by 2002:a05:7022:fa2:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-11f34874285mr7879825c88.0.1765986403925; Wed, 17 Dec 2025
 07:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20251217154151.2018978-1-alexander.deucher@amd.com>
 <20251217154151.2018978-3-alexander.deucher@amd.com>
 <3721bd77-a1e1-48b4-afe1-d0a9845c7b2f@amd.com>
In-Reply-To: <3721bd77-a1e1-48b4-afe1-d0a9845c7b2f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Dec 2025 10:46:30 -0500
X-Gm-Features: AQt7F2oCbgobFwbStcvdCRG0Ur4wg-jZ82eZIT_ftSxJLGi3AD58tQIfiaSa0I8
Message-ID: <CADnq5_Pvmyq8hEgZWe+otDwz=Mr2KVPVTgF3MeA0xMM_vSGhSg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Skip SMU init for backdoor loading
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
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

On Wed, Dec 17, 2025 at 10:44=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 17-Dec-25 9:11 PM, Alex Deucher wrote:
> > From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> >
> > Handle backdoor firmware loading in smu init.
> >
>
> This is in common code and doesn't look to be universally applicable
> across all SOCs.

I'll drop this one.

Thanks,

Alex

>
> Thanks,
> Lijo
>
> > Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/dr=
m/amd/pm/swsmu/amdgpu_smu.c
> > index b7dfd98d387d3..6ff593dd163da 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -1921,7 +1921,10 @@ static int smu_hw_init(struct amdgpu_ip_block *i=
p_block)
> >               smu->pm_enabled =3D false;
> >               return 0;
> >       }
> > -
> > +     if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP) {
> > +             dev_info(adev->dev, "Do minimal SMU init for backdoor loa=
ding case\n");
> > +             return 0;
> > +     }
> >       ret =3D smu_start_smc_engine(smu);
> >       if (ret) {
> >               dev_err(adev->dev, "SMC engine is not correctly up!\n");
>
