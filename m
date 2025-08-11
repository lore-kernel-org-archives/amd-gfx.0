Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4BDCA0EDA
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 22:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACF0410E065;
	Mon, 11 Aug 2025 22:22:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HzYkxwHV";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DDF110E065
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 22:22:41 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-24286ed4505so9515505ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 15:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754950961; x=1755555761; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i3dFa/jBrWSUlGrd5Kh1JhkjVK+ut5oAK7dHoJX73XI=;
 b=HzYkxwHVq8p0j8MQ5r9d35q1NLtGJ7yyFxYiuVdBuZXrG6QEhzRCgmAZq1lMqPvSav
 xnssZbjPWOCyqM0xETEFK0wa5mLJ8fCkMiXYgXjE3iQWr7Emtyq3N7rutgNToC5ss1YU
 CIspm7wCpdBTMiUO2DwTJw69NI5xgtepiQMoc+5a1Rbj6iklAJuxbqiA67xmGxOH6ouC
 3GUFYiLc0fLcYgVIpqyIdHSg//iyoeuVE2k/1Tn50qapxAKVRatYdis+6lNJNyboBdWs
 vwXBassjkpTUwc99IRt0nIhOvzj7DS75q+ebH0HDneGJ7+CYKyDOXve8tl5ub2++tAJ2
 BCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754950961; x=1755555761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i3dFa/jBrWSUlGrd5Kh1JhkjVK+ut5oAK7dHoJX73XI=;
 b=AwsJB29RNiF4epWVF//asHhDgUtlDWknelrx+V4Y/NXgsHj5EOc/jn5at1HQtgTXn4
 roX5H7GBop2/VLTLV9TICiVLTcPiMcliEx/xHx3cv6coKygun9qqckkssce7Jp53kOmE
 LEWVfScI4UnZehTge+xrYYPpmKBeDMgj3HejJWvURAvVqyr00hRBbziM/VTrVS6VP5f+
 ofTySvdgjNsCu/7TLvSY9xVNKI1T8CqBb2AFkfRbxx1B/Vi3X9+qkUrkVQe629ub0fPJ
 y6N9qoIoVA37R+Nr9gaivvCqdae3WFZDYecLHdKEKpN/eaYaoaCLdX+F0NPDNJM9t8+2
 bwpQ==
X-Gm-Message-State: AOJu0Yy5DiaTR9l+c8P9kBqSIZ35QtyQksT/4395Q3pk8Nek/giBI/Lh
 ZV7ABe7KCeH4WTktADakOud+wVQASjILCF1S4sdzW/CNoMLN4AgyzYt5UOF50GNKWRuXGLTe2mW
 fjHSO1+s60mGEZUruJ8YR5mWby1Jz8So=
X-Gm-Gg: ASbGncvB/aod7hZkwDaik1JCfO2yHP11kpwURcYUXa39ipvdE1H+cKFFJhZQfojqqON
 12HwAnKPFw7ghX98xG1vR8wfw91yQ1ShiNzns2GzxgV5a/1ZQZhIXoY/Qhpaa9A7WQ4nhskiNc+
 gbgkAUcrzc9Y7EaaT6byHMg8i4dGn82zZrvCfuTaZ9Qd8URBjTlXQ21Gqa0waPKNQKpW4hLhFJN
 gZCtKg=
X-Google-Smtp-Source: AGHT+IHS71FPq2o7Tk0X3qK6VQYtvhMym8vm24St5chgaPIBfFlAAsthIXDKRma2iJHoFIeJ3pnYszSdSti993YnCXc=
X-Received: by 2002:a17:902:d4cc:b0:240:280a:5443 with SMTP id
 d9443c01a7336-242d381093emr71122755ad.3.1754950960999; Mon, 11 Aug 2025
 15:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAPEhTTH90Rz-UFVJCdsi=vP5BSuQxVB3W-Qe1yVKH93txBLFsA@mail.gmail.com>
In-Reply-To: <CAPEhTTH90Rz-UFVJCdsi=vP5BSuQxVB3W-Qe1yVKH93txBLFsA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Aug 2025 18:22:29 -0400
X-Gm-Features: Ac12FXwLosyP_TSRTZ5OjDL_wy6ROYtFfDCkqHbDLZS73-fJa_7uweXWc5j2js4
Message-ID: <CADnq5_PuR5V2DzSow2EibdykmqwyOAd7q2K51uawumbo1naTGQ@mail.gmail.com>
Subject: Re: AMDGPU's rings VS Radeon's
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: Freedesktop - AMD-gfx <amd-gfx@lists.freedesktop.org>, 
 Alexander Deucher <alexander.deucher@amd.com>
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

On Mon, Aug 11, 2025 at 6:08=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> Hi,
>
> For those who know, I'm still working on VCE1 enablement under AMDGPU. Pr=
ogress is happening, slowly but surely. While investigating the ring init c=
alls, a few elements catched my attention and I'd like some help in figurin=
g out the differences between AMDGPU's ring sizes and Radeon's ones.
>
> 1- I understand that the size parameter changed from bytes under radeon_r=
ing_init to dword under amdgpu_ring_init. That being said, some values don'=
t seem to be equivalent between Radeon and AMDGPU. For example, GFX ring si=
ze went from 1024 * 1024 bytes to 1024 dwords (for most GFX versions), whic=
h seems off even when taking into account how amdgpu_ring_init calculates t=
he final allocated size. This question is more about understanding than a p=
roblem strictly speaking.

You can make the ring any size you want.  It's specified in the queue
descriptor.  I don't remember why we picked the sizes we did in radeon
off hand.

>
> 2- Under AMDGPU, SI's GFX (GFX6) ring size is 2048, while this value is 1=
024 for all the other GFX versions. Under Radeon, the GFX ring size values =
are all the same (1024 * 1024) under Evergreen/SI/CIK/NI and others. Is the=
re any reason why SI's GFX6 ring size would be twice the size of the other =
values under AMDGPU?
>

From the git history:
commit 97041ed37718dc9ba30aa23ca74093dc93ac89fb
Author: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date:   Thu Apr 13 16:22:51 2023 +0200

    drm/amdgpu: Increase GFX6 graphics ring size.

    To ensure it supports 192 IBs per submission, so we can keep a
    simplified IB limit in the follow up patch without having to
    look at IP or GPU version.

    Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
    Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>



> 3- Would it be acceptable to add names to rings under Radeon, the same na=
mes as the ones used under AMDGPU? I think it is more talkative for the ave=
rage user and for debugging purposes to deal with ring names than indexes. =
I already have patches in my code to address this suggestion.
>

If you think there is value there.  It seems like it would generate a
lot of churn in that driver for little gain.

Alex

> That's all for now.
>
> Cheers
> Alexandre Demers
