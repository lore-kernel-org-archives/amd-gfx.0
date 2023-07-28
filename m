Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75DFC001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 16:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60CEB10E726;
	Fri, 28 Jul 2023 16:43:22 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FFFA10E726
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 16:43:19 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6bb14015560so1996126a34.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690562599; x=1691167399;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3J265gu/8FQfCRdoUcvQuQsZLZApH12qQl8/EPKTQ48=;
 b=j/+XvjDIsgL9hgBV1+3T50LXFh6t5O1tTAqr8ecR1EgRiuwnfMS0XyALyXYWWe4gOL
 XlKgddLevD0Gxkv7z8e3hWhlagGHllcaMXBFQT5vVs0BZL2d9jI4Gip026s2fkpaNycO
 zSnEXUIX0BCTjsHAF/vCQPdd6aMdP1KyLM/kfhilG0oqHnziCKdqaBwCRkXyxJ0nlcFi
 iRUTWJxJyWTesXqv5X2uTeCTzITaqMcriFWa3ocu6OrlGUG1/FXE8cRhRuhRb0VpRW5F
 6xw6puorIaqHMjGID++X/Tnkv4xL4n1aFFLBgEdF2wu//gY2GhkC9PqQR8WX3eNvdCfJ
 E1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690562599; x=1691167399;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3J265gu/8FQfCRdoUcvQuQsZLZApH12qQl8/EPKTQ48=;
 b=ajQ2ahAt4yTw5Ze/MLwlERzuxu0oQSBiiiotTch3F6maQDN8tICoWdAP2UtK+PATRc
 9lA5azFw2prD05XXO6lCiyq/1rkObV+338cu3MUFEPjRO4exgbXo5PwqGap/Z5Vcc0/X
 HzePxYEviLF05Sf1HsFQe9D0YX+YRY5iBiBFCHtVPbYyVze0/N9YUrmsLoh1ruJ6LOOh
 NwmWt+wV5KZOjn9n0SFDErXUxQWeiP7PnfoiWMRhCWuDZjKFcnck4qhMReUKm3usFBI0
 exiFtekdjSf0JGPv2qImuqvC15HP/2NDGSalon0uMwSNsWMfnrct0LapETxCtOPEYfjG
 ZD8g==
X-Gm-Message-State: ABy/qLYq7hwSsK7osexLT56TFka1W914NXF2dJl2ZvahHPpRSUnt/iRg
 h7MoLHFd3E2HBrGn+CoLticm8GcZU73f4eFToPXkBou/Ulk=
X-Google-Smtp-Source: APBJJlEyUAfuE4CT9BC7UZQBPqu0w9oE0VsTdV3fjdaHl5uajAoAbpta8AyOZY074SQFswl9fPa9imC/TiN+1jiummk=
X-Received: by 2002:a05:6870:3510:b0:1bb:6ee1:114e with SMTP id
 k16-20020a056870351000b001bb6ee1114emr3572253oah.28.1690562598859; Fri, 28
 Jul 2023 09:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230510212333.2071373-28-alexander.deucher@amd.com>
 <647beed4-9d0b-e351-6f66-756f73eb73a5@daenzer.net>
 <1da36164-7cd9-c2a3-a42f-558942257727@daenzer.net>
 <f8c83922-f3d4-34d8-6ae1-3112b52bcdf3@amd.com>
 <d515206e-ab58-a8c4-ef3a-e93fc61ba37d@daenzer.net>
 <0a99c609-c5c2-25fc-4ceb-52a0b4a49f29@amd.com>
 <219fc41b-13f2-8517-1720-eb92fe02083c@amd.com>
 <DM4PR12MB5152DC2873CB6726977F45C9E301A@DM4PR12MB5152.namprd12.prod.outlook.com>
 <DM4PR12MB5152E173B970C3974F071E76E306A@DM4PR12MB5152.namprd12.prod.outlook.com>
 <063f67cc-241d-f92f-1c6b-1ec20795690a@daenzer.net>
 <493a9ab5-1665-0188-8bab-69086f7d94a6@daenzer.net>
In-Reply-To: <493a9ab5-1665-0188-8bab-69086f7d94a6@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Jul 2023 12:43:07 -0400
Message-ID: <CADnq5_N-5MNq1YjU1w5AgsqFVTc0_nJ+XWgkifhRAzKKiftHZg@mail.gmail.com>
Subject: Re: [PATCH 28/29] drm/amdkfd: Refactor migrate init to support
 partition switch
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Zhang, Jesse\(Jie\)" <Jesse.Zhang@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 28, 2023 at 10:25=E2=80=AFAM Michel D=C3=A4nzer <michel@daenzer=
.net> wrote:
>
> On 7/28/23 11:30, Michel D=C3=A4nzer wrote:
> > On 7/28/23 03:38, Zhang, Jesse(Jie) wrote:
> >>
> >> Could you try the patch again ?  That work for me.
> >>
> >> https://patchwork.freedesktop.org/patch/549605/ <https://patchwork.fre=
edesktop.org/patch/549605/>
> >
> > This patch fixes the symptoms described in https://gitlab.freedesktop.o=
rg/drm/amd/-/issues/2659 for me as well.
> >
> > However, it does not fix the IOMMU page faults[0] or the IB test failur=
es on the compute rings. Should I try amdgpu.ignore_crat=3D1 for these symp=
toms as well?
>
> I tried ignore_crat=3D1, it avoids the remaining symptoms as well.

The first 3 patches of this set may also fix it:
https://patchwork.freedesktop.org/series/121538/

Alex
