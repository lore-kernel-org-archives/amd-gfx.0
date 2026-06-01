Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE140CD6E55
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 14:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A318113482;
	Mon,  1 Jun 2026 14:56:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o+XqAs+3";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AAB0113469
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 14:56:49 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-13644e164cbso333354c88.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2026 07:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780325809; cv=none;
 d=google.com; s=arc-20240605;
 b=PJ2zT2gNFqsW1UmBSBSnLuplmDQ8/JYC/uogHEY8JUBR6hdfrJMwRzQkHnROXercMC
 jvSJ1FYPUtpnypDh8wSuxeMo1H2zuHg8ZZhPxt/NLpgnPeYEuJCqpPd6kRtfVyo7s4EQ
 D1hk5LQSrlkRbs1M/JVvMQWBgQtCiKiPpHaaqeLS5QEKuGeTntaP8ZP5HS41QjT0z4Zo
 fqcTR63cunhX/JUcyoz/WIuhKN082oClyXrcZGP3Oy6/wy8OXTwlBW2QqpMLx3h43uAJ
 hG9uTlE2eQQCOeg0NipDUQFCgafSEvrdfAtqwizYHg3WAVRGOWiZBvJYzP6kgxFlhkch
 KdPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eqT4EIZiuuV2Qd1zMHxFTMUG0TX37mxoI/hYfi/toBI=;
 fh=2Aumocn4enbF+rqa8HeyYEHG5Y+KXm8+NGQHyV8eOSk=;
 b=foUm59riYFzbXoZAPd7J79V78H/CwgnFoed8ezePrOfnVmnxw6IHEP6qdRM6dGZgQm
 dRgMnqfx5nJe2ihS57gX7eqbb6WAFB3DsA/VPHUonyi1GnyTk74BMJ7QDcM5ewiI7mjN
 JZ17MVFqQYBq80IWwai+PPFu3Ws3022+XPDGYf/814RQyz6JhAsbA0hf4kbTM3u/2PQF
 vEOq+HCvaH5uY2OtdEyIiEqrgpt/PXGc32Phh0P/L5crXRwnbtIqkMepZyVx7hf4FbK1
 O7DBW0XukL0FE+mQ14H4z2em+032ssqvD3lWQeqlwbeSIE30HWdqwrBqKzL9rOqZFVQQ
 5pfw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780325809; x=1780930609; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eqT4EIZiuuV2Qd1zMHxFTMUG0TX37mxoI/hYfi/toBI=;
 b=o+XqAs+3k1Sb/ag5jOveFvafXQ6LWuzHbYIswzZRkS1ivgqnG2E4S5aN2/N6G3G1pK
 NNeRSeuyh7HiM9caL+BxXn9rucpJZqG57zHCn2O4g+Up47WXzkLI9JyCWJy0tRxB7B3q
 aZGx+vQyo6whe8zexBRHcH6WJm9Vs8783lR6HBNiFhXXAw4Xi52q/GTg9Vjxr7HgB9Fw
 4sAK9UYCw7HlMPXnC3D+Fbe2AMhN5pLoVNKo7AKZpMkvnD7u2xlupeSMXu1Ke1iVayl/
 IqvZBF/h+tgPkJyv1m6kkiqxvtGzvUDX+aa4Mr/IT7FvX0reZDCd/6OxDTBxD/FKh3Ig
 PNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780325809; x=1780930609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eqT4EIZiuuV2Qd1zMHxFTMUG0TX37mxoI/hYfi/toBI=;
 b=aB0I+O42fi9A07f0QvSJRjcSHj3J2ETx6xzUhdNCIjLlbv0JfV7Ff0or/SWlDcntJi
 Uz3BVooBij7vDdES1up+KD/ViHlltKUQWAMYUD+Pz0k7lPUgifDk85vkPddWRQGGcZ+c
 iOX1QOwfQizVlTZobUtmY4wOu1jYswarq+oKojt921Oc8jzSNojPg4ricOJw9mAHxraa
 4R7sM1/+FXjJOluV+7bZatCZ/JgEiP4JprK/VTnKF09qrLszlGOBpjlBj2G4TpAw37wN
 +JqTHv79F712S2jQbJ09YrLLwNVO3kFqYHYll3iGLXBhWzo73TKCYRergaQ83rrLXeHF
 UK8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8dI+jqKF4OBqAULtjusAoQ+pHhkFBKXAbrE3DQrnztCjaRcth9Kof/LMsVlyEr51TwJjJtf+rT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YynxRFLABjK2bBqxFGBV1fVShLihwFaZz5+qWYYQHwgFUogZjAw
 ALnZPYKKl/r8SWswlg9ZMlazLvFxbpOr1lDVTagFcmmBHD15UtNu6m2zPRYwDH3G1aLCZV+IEkl
 NASdclNKd0V7wUgdGZQj7VSrhR/Lrxro=
X-Gm-Gg: Acq92OEtFlsYLzSX3F3YaSF2VWdETVMzXTMmpy21oukL8SsKh2H98quxczQQr8HK5qV
 3RumadqNPjXv5ynJJMFxhXNHH67Z440sbVPQI521yzvAurI5ZcJRakCbosOEy9v+dkxu5xe6Bz+
 znWKaIhJDlGmuU0zdDn1SXGpnGeUT4z5RoGCD0CwhfjH8LETj/aNNPWrise7++kYaaTIfJLUnrs
 djFbNXGffsKZenr3CSK44S62EYlJHBjBiFgI02VOQbwKkZRL0la37upLG9H9L25esOR0orRD5ob
 UYP6hJX0CBNN4R3mCVuz1lM5nNjdiFjFY+J/4G/Bzak+r2AeFsBrBjcRvuWeYm28Z7fDsV1pPJV
 gfelw
X-Received: by 2002:a05:7022:692:b0:12d:c389:ae54 with SMTP id
 a92af1059eb24-137d3bfdf0fmr1955571c88.2.1780325808750; Mon, 01 Jun 2026
 07:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260527233504.1830940-1-Yunxiang.Li@amd.com>
 <20260527233504.1830940-3-Yunxiang.Li@amd.com>
 <CADnq5_N9tz-NR0o3WCod+=7j+oqZsMjX4RT6P__Cu-2DSLuy6g@mail.gmail.com>
 <SA1PR12MB85997618DC44E4FB68187865ED162@SA1PR12MB8599.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB85997618DC44E4FB68187865ED162@SA1PR12MB8599.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Jun 2026 10:56:36 -0400
X-Gm-Features: AVHnY4JKl9BRgpzm46KqGXLqcdvUFJwnBWVwxFYWPLK32hvqDN_v76jxc-ekGa4
Message-ID: <CADnq5_OB2bFEhto915DxOOHvtOyfEyWPCu1-BCLh9CwzR7=6cQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx: move fault and EOP IRQ get/put to
 hw_init/hw_fini
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Fri, May 29, 2026 at 7:15=E2=80=AFPM Li, Yunxiang (Teddy)
<Yunxiang.Li@amd.com> wrote:
>
> AMD General
>
> > From: Alex Deucher <alexdeucher@gmail.com>
> >
> > Wasn't there a reason (sequencing maybe?) these were in late_init()?
> > Are you sure it's ok to move them into hw_init()?
>
> Not as far as I could tell, from the code all the dependencies are satisf=
ied in hw_init by the IP block order, it was just put in late_init since th=
e beginning of time. I did test this change on gfx9 as well.
>
> The same pattern of late_init get hw_fini put seems to be used for other =
IPs as well though, so it could be that some hardware related reason exists=
 at some point.

Patches are:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Teddy
