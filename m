Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E0BD339BC
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Dec 2025 16:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB1B610E2B5;
	Sat,  6 Dec 2025 16:30:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eXzADbit";
	dkim-atps=neutral
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3EA910E2B5
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Dec 2025 16:30:42 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-6571763793bso1688415eaf.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 06 Dec 2025 08:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765038641; x=1765643441; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pkMbwFh0DMrMdIeAxee0GgkLevKr8HKcraJI9LxfhJY=;
 b=eXzADbitcQmBuStWgtIWAxhCYWk5Eg3Bb4c0Hoy0Wjee/zNtp4ifCDbOJkHyeFQ9CU
 Zgelcro8xX6mv4q5PMAkjhlbVimgIRt4aTAmbhs4h8GOsSG2IWVojCITUKCe7SJR0KIC
 RD2yQkQQIiI0Qiw7sGiR6tb/M3uTG5EThgFdAPtP3YRG/fA7P+xXvI+A4QBpmsI0eSZT
 bP/WiATLH4296aERImr37aJJMh31y/URGrYUjpLMoZPG9lwmEDMGhMmN15uX7w+Ssgpa
 4ps6qCI+qywItfEYyTDEJ5ZYWFpWFsQMJAnKYmx5yjP2193uogqCgp88KmNxU2SeZ/qw
 1mLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765038641; x=1765643441;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pkMbwFh0DMrMdIeAxee0GgkLevKr8HKcraJI9LxfhJY=;
 b=FYQNimfziBUjUtdJByIeIgxE7tS2wrfGGgPlF40rlG2+MzYKwEMGrfuHxwc0kQTdFy
 tdLocU0YI0C6e8XH9XDMMPtnKf0281jRg/JET5q4fkjmdJnH4zbWZj8e29vi2/+XjKRq
 7Rs+0eZLG567uZQx/3TZNwCn3WjHDBX2b47QEtOqQOp0P9dadPQuprATNy9jYwo9b3SC
 SnGIE1nn5MqC1Z+4O9qiEfZYRpGAkdiEvAkvWkDXlUnGv8G4aKIcMWUsAIDwbbaciz1i
 6BNcsPk1SRSVj21kixp/6upPA14iuUujMRm/4HyKGI6o7UQyBu6OEr1jpIMlPml9p2NM
 fqxQ==
X-Gm-Message-State: AOJu0YybxeW7A3rljsdkK3FkjwzuZFrwqLKRkPk+n4yP1tsMmnobayuC
 iS4UdllpwL/CkTkW1w8RZl5KxOJuGPVkoeuTRK8whSIt4HkAMXbuySeRN15L+ILmDXON4PkQYK9
 1F4koUNaCXHsMoH0YqVXv+yGgzy3VDFk=
X-Gm-Gg: ASbGncsDuDMnpF30XsC2Vi9O7xhpNmuEtRKuQHfdCDSdkuVgIYkIv+fwAjiW4w79ch7
 FzcYrXRSfa+KjTeqYllG9ftZx3Cu0oWf0CDdjIYIqqOopHYW1Dd7lM7BYbc5vWh8MkBLp/iWlM/
 xZezHaskbd4USMqDPZjD8Q5gnfhjPKGsp1jS5XG4+C6upqXxUY2JJC+Co07lSVH3f4dYzriyO1I
 Lfz7Zvy3591Zlwk1alG7O/PHK+sHTLDHbsEAp4/kG7hjbnUDGYCuVx8LdyQ729wA692hCsF
X-Google-Smtp-Source: AGHT+IFPza1S3VNx9dRKv0O3eq2MX4VOf9uhEPIWo3z41oPcmW4APvkiEwfCyN4ShRUJHZpWJtZu5VgT7oVcZAH2TzQ=
X-Received: by 2002:a05:6820:138b:b0:659:9a49:8f1f with SMTP id
 006d021491bc7-6599a94ba84mr1132899eaf.48.1765038640626; Sat, 06 Dec 2025
 08:30:40 -0800 (PST)
MIME-Version: 1.0
References: <CAPEhTTGamEFapOA4pKgMQxDz9Go1k0QeGRkk5bR-X2jR+iBCcg@mail.gmail.com>
 <CADnq5_Mh7M=019sJ274GLtMyKDH5MSMfR=k6pVTS1z2DV1tQCw@mail.gmail.com>
In-Reply-To: <CADnq5_Mh7M=019sJ274GLtMyKDH5MSMfR=k6pVTS1z2DV1tQCw@mail.gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Sat, 6 Dec 2025 11:30:28 -0500
X-Gm-Features: AQt7F2pHgZCQoZJ8y3b5gP9VfoAJo3Of_D6vyU5VRSdvQ5HsY0aer_miUeRCwNA
Message-ID: <CAPEhTTGJb85fP4iJXAWVkg+vai2xDi-76RFhbmuG0Gc-XT+dKg@mail.gmail.com>
Subject: Re: SI - are power and voltage readings supported by the hardware
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Freedesktop - AMD-gfx <amd-gfx@lists.freedesktop.org>, 
 Alexander Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

OK, I was hoping for a similar SMU7 implementation never completed.

I see both VDDC and VDDCI (for Evergreen+) values available. When
looking at amdgpu_pm_info, VDDC would be reported as VDDGFX I suppose
(and inX_label under /sys/class/drm/cardX/device/hwmon/hwmonY/), isn't
it?

What would VDDCI correspond to? I mean, how should it be displayed
(maybe it has its specific inX_label)?

Cheers,
Alexandre

On Mon, Dec 1, 2025 at 10:26=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Sat, Nov 29, 2025 at 8:44=E2=80=AFPM Alexandre Demers
> <alexandre.f.demers@gmail.com> wrote:
> >
> > Hi,
> >
> > I was wondering if SI GPUs support reporting power and voltage values
> > at the hardware level? I read somewhere that it was supported from
> > GCN1.2 (Tonga and over), but I haven't found anything on prior
> > generations. Going through the register names, I wasn't able to
> > identify any who may correspond to power or voltage level.
> >
> > So I'm asking, just in case it is supported and I missed the
> > information while searching for it.
>
> Correct.  There is no interface to query the power.  For voltages you
> can look at mmTARGET_AND_CURRENT_PROFILE_INDEX to find out the current
> DPM level and then convert that into struct si_ps to look up the
> voltages, similar to what is done for sclk and mclk.  See
> si_dpm_read_sensor().
>
> Alex
