Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3E1CEB2D0
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Oct 2024 13:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB43B10E044;
	Tue,  1 Oct 2024 13:19:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AQT7jYAd";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5055E10E620
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Oct 2024 13:19:26 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2e0b46df34eso745804a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Oct 2024 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727788766; x=1728393566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mXiXIWwgmR0UfmkFz9FwQzFMESqlLTZEekI6B5j9d5s=;
 b=AQT7jYAdX9EUbxSn4nE+7v/87hh120U6BLaa03gnqGN0YB77rMb57Mzl0+q/gV3M9D
 2/j0nyQhqziORI3NKaAiRzZrwI56G3zhsUz8L0TbNHPWK4asmu+MN3LsWvwyXnD5RKmr
 bktzws0MARwCu16a1JipztQ3GoTffLdLitD8E3mer1lXQDgC4GmYRwNMqpKwcdp2AOeu
 EE4YEVHLplSpjeJWS8yVQVcrxZSmYyLZb8GJJhVnM/qN0A6hJxFn34c0Z2umLPSdgCQl
 XWycIQ5z3uj3FzIKmH1pSsjMqFHQuzZ5J4Qsu52Bbl4EDmaSxVL+YKqDH1oT/PMh2YX2
 V0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727788766; x=1728393566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mXiXIWwgmR0UfmkFz9FwQzFMESqlLTZEekI6B5j9d5s=;
 b=NIKRTsxruxkzv61hCaHg5NMfNg0AggDD7yCwG6PdBgmHf/8cN/JPp3E4+j2YLmL5Fa
 iisk9lTpyBh9BXvK4iDfP4VvpUtTq/W51du8nlvUE0NWkUEkfxhzfUtzajkolelq6Hbk
 ddsWjMc1A0is2iNBXftrudQj+CsNBalZNB7iTpRcwaqvc8B0oN2ZMTLHokzmg9ashYUD
 tSpnehier9Bt5vinwZO2IUNDO8AW4IcLRygAt67VSwTQrdcprnuS5AC91L+j6noyO8TC
 Z8wSb02Vvv1SnnvE7afKwoaLKfNO3EKpu3ozLXbW5ap8TfvWQ9BhZ2zPphH87RjYHmRp
 6JKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUAlgriDU7uJnfDUK1Ea+GINk8W+RZ30cXQ7S5JuThD1AW4UBdW5I5Twy5sbD3bA+qptIKYuAb@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyrl4aXqBNcorE2eiRY81wS5vg3aomiahDR8+ohMQUX4gPvX6KQ
 FtMz5AiluBx1DORxx5OzdKO3NTGskiUI6bR3qvBBz+KP0AwXhK0e49aNfQ1xUqpkT/7n4IaxqcZ
 cWvtwfF+fhkmxgjioJTGemxWhKvU=
X-Google-Smtp-Source: AGHT+IEmWCaMTr25cM8kV4jqwmHIiN2Dhczo4uoIMhMQguhRTriR+KjemXPpW3xTGHMkWnbULIeT2pUlUvZBsJAumXs=
X-Received: by 2002:a17:90b:128b:b0:2db:60b:697e with SMTP id
 98e67ed59e1d1-2e0e70f2160mr6270753a91.8.1727788765715; Tue, 01 Oct 2024
 06:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <2024081247-until-audacious-6383@gregkh>
 <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
 <CADnq5_MXBZ_WykSMv-GtHZv60aNzvLFVBOvze09o6da3-4-dTQ@mail.gmail.com>
 <2024081558-filtrate-stuffed-db5b@gregkh>
 <CADnq5_OFxhxrm-cAfhB8DzdmEcMq_HbkU52vbynqoS1_L0rhzg@mail.gmail.com>
 <2024082439-extending-dramatize-09ca@gregkh>
 <CADnq5_OeJ7LD0DvXjXmr-dV2ciEhfiEEEZsZn3w1MKnOvL=KUA@mail.gmail.com>
 <2024090447-boozy-judiciary-849b@gregkh>
 <CADnq5_MZ8s=jcCt_-=D2huPA=X3f5PWNjMhr88xoiKc_JFwQtw@mail.gmail.com>
 <2024100112-flounder-paralysis-eb25@gregkh>
In-Reply-To: <2024100112-flounder-paralysis-eb25@gregkh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Oct 2024 09:19:13 -0400
Message-ID: <CADnq5_OKw-N6sXuX7hvfE7Agb5HStBjGxwjS-2x3AbghWyqMEg@mail.gmail.com>
Subject: Re: AMD drm patch workflow is broken for stable trees
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org, 
 stable@vger.kernel.org
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

On Tue, Oct 1, 2024 at 6:04=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Mon, Sep 30, 2024 at 10:10:25AM -0400, Alex Deucher wrote:
> > Resending now that rc1 is out.  These should be ignored for stable.
> >
> > 8151a6c13111 drm/amd/display: Skip Recompute DSC Params if no Stream on=
 Link
> > fbfb5f034225 drm/amdgpu: fix contiguous handling for IB parsing v2
> > ec0d7abbb0d4 drm/amd/display: Fix Potential Null Dereference
> > 332315885d3c drm/amd/display: Remove ASSERT if significance is zero in
> > math_ceil2
> > 295d91cbc700 drm/amd/display: Check for NULL pointer
> > 6472de66c0aa drm/amd/amdgpu: Fix uninitialized variable warnings
> > 93381e6b6180 drm/amdgpu: fix a possible null pointer dereference
> > 7a38efeee6b5 drm/radeon: fix null pointer dereference in radeon_add_com=
mon_modes
>
> Thanks, that helped a lot.
>
> However the following two commits did not apply, is that because they
> are already in the tree or do they need someone to properly backport them=
?
>
> c2ed7002c061 ("drm/amd/display: Use SDR white level to calculate matrix c=
oefficients")
> b74571a83fd3 ("drm/amd/display: Use full update for swizzle mode change")

Looks like they will need backports.

Alex

>
> thanks,
>
> greg k-h
