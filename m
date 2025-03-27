Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95C1C3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 13:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 807A510E8D6;
	Thu, 27 Mar 2025 13:21:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M929m+fr";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8FD110E8D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 13:21:23 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2ff67f44fcaso223963a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 06:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743081683; x=1743686483; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXLmKhldHcaRU1ROzFC03QGx0qvGh6kIqGs5Rn/VVeA=;
 b=M929m+frXpe1PWRs1G/ROfWxUQ3qQI/+es1K5f8ynm7oqhnsX7FUkQ79O3wtaM7Hd5
 Hu+WO3VxjHm6lAGBmMtSkO6tbW27m4/NhGMYVfTXauDT8FDEA04M27VbayCsRMmLvd4e
 J9J0A3htNCwwCV2PtJkEAzuHmvjzx/BNTOihvCaYQtTks5BvLuhziWrLV0pAlOqYVC78
 uEOr2ut+7ds3mbi4Ic3nShR5zpMS4FGtTcAANUnNXGDCmEqld+NhIDRFfd01i3VfM14l
 llmUdRnMwMCbcTkx37gdNYmg5YCAIRB/jwmgrd6xNdnyE4G2YL76S07TuU4PxWyZmvWN
 EIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743081683; x=1743686483;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oXLmKhldHcaRU1ROzFC03QGx0qvGh6kIqGs5Rn/VVeA=;
 b=LF2VaGG3mGnlYOBXGhTbrlFMDvv2vs0KQ7/hK19sdMOhFT917XN7Q8mSujrqJ6hmMw
 se7yhz6gy0w20fK6bLfDY2/6IjCkl5hvXAVmU4bHv6zgNxI3/kDwF013a4c0afmJcp8d
 V6gfaBSERGKy43aehqyfsbCpi2GqCcyNQs/LnN7/wE7Q+qlCDqc9ob0BBAw6yX13/RyU
 kRIFseG1PrvqNTOn2r+83qgf/v/mhKw5jDCsaPMQOhw+zOZT7LvaKbwpH5BO0KknsgaV
 aR416TTLQxQuoMvMLb4bXE3xMOw6bYGZEfGzMbrsahwNAXSvn9xz0FOeAn28sVsr4IfX
 8aTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsZHEzRQd7oMSQ8kUe05DvMdCW87XsOAAgy11D6LN4IcS/Hkx7Jo+u7mQuxIhf3X4izPKHG0lC@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkWk4F9cQWulJhr6XLJFKa8/r5ettNODHx6etDOP8dv8cPqtMo
 Ml0Kj1jwQDNabnnkpdQyj5y8q5EJZVWVDAzFqeq9EHo4LoeFHyjNQE0GXKLicukOx0xN1CKZi40
 EdWtbPl+VjSIlk32LlUH1yAhi2xP8Cg==
X-Gm-Gg: ASbGncvS+TNy4+Kv2thMKovdhd7HfLsYLKfawKCftmkOHTFiqdpQ/EjsqKxVyNK4VCK
 bkgP/168Aop6njN5i/8L1yEIicvKUCrDg4SmELR5ByA5eXka+hrvY8eAWjUbDDDARjZPTWy1bNd
 l9LtdXz4vmrhWpSfQDVj3gMJvpfqRqj0rlBynD
X-Google-Smtp-Source: AGHT+IFGjFI0h7gtabND5jTjOkupbQeUI2156tnZYTj32c8sPKbiIE72kfO/5KOI5WF1bqdTxsAxF4hfjKfTuRzj39M=
X-Received: by 2002:a17:90b:1d04:b0:2fe:8fa0:e7a1 with SMTP id
 98e67ed59e1d1-303b211144dmr1603499a91.2.1743081682968; Thu, 27 Mar 2025
 06:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250325152407.2543116-1-srinivasan.shanmugam@amd.com>
 <b30810ba-3e16-4f52-8b4a-070bda1bc129@amd.com>
 <CADnq5_PcPDULfTjtkWGXRVpuJ3Wc770Be3QjrxkRDsw1E-VUeQ@mail.gmail.com>
 <740940f4-055b-483b-88b7-072907539167@amd.com>
 <fc461f19-44b8-4699-b3e6-c37e1b7dc76f@amd.com>
 <5a04ac1b-6b83-40c4-b9f1-ca42bd53763c@amd.com>
In-Reply-To: <5a04ac1b-6b83-40c4-b9f1-ca42bd53763c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Mar 2025 09:21:10 -0400
X-Gm-Features: AQ5f1JrSS_j-U6jHcVPniPU4buZimhR0Kqe5aDTD4brJ98ct6TmW8R0KAEsWg1E
Message-ID: <CADnq5_M6BhcHyQ9o7zsNgZU+8A0hwYugtaBr0GPCXH=z7mkGkQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix Manual Execution of Cleaner Shader in
 Gang Submissions
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Thu, Mar 27, 2025 at 5:37=E2=80=AFAM SRINIVASAN SHANMUGAM
<srinivasan.shanmugam@amd.com> wrote:
>
>
> On 3/27/2025 2:54 PM, Christian K=C3=B6nig wrote:
>
>
> Over all this change doesn't seem to make much sense to me.
>
> Why exactly is isolation->spearhead not pointing to the dummy kernel job =
we submit?
>
> Does the owner check or gang_submit check in
> amdgpu_device_enforce_isolation() fail to set up the spearhead?
>
> I'm currently debugging exactly that.
>
> Good news is that I can reproduce the problem.
>
>
> I have to take that back. I've tested the cleaner shader functionality a =
bit this morning and as far as I can see this works exactly as intended.
>
> Srini, what exactly is your use case which doesn't work?
>
> Hi Christian, Good Morning!
>
> The usecase is to trigger the cleaner shader, using sysfs "run_cleaner_sh=
ader" independent of  enabling "enforce_isolation", so that cleaner shader =
packet gets submitted to COMP_1.0.0 ring by default, without prior enabling=
 any enforce_isolation via sysfs,

Right.  We want to be able to manually run the cleaner shader via
sysfs regardless of whether runtime enforce isolation is enabled or
not.

Alex

>
> AFAIK, this "isolation->spearhead" initialization is not being takencare =
in this path "amdgpu_gfx_run_cleaner_shader -> amdgpu_gfx_run_cleaner_shade=
r_job" (ie., when we trigger cleaner shader, using sysfs "run_cleaner_shade=
r"), and this check "&job->base.s_fence->scheduled =3D=3D isolation->spearh=
ead;"  is having the problem ie., "&job->base.s_fence->scheduled" address a=
re is not matching with "isolation->spearhead" address, which results into =
zero & thus fails to emit cleaner shader, when running using "run_cleaner_s=
hader" sysfs entry, in "amdgpu_vm_flush()" function
>
> Best regards,
>
> Srini
>
>
> Regards,
> Christian.
>
> Regards,
> Christian.
