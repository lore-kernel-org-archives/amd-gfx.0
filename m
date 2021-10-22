Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8F9C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 15:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF7A60231
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 15:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EEF7A60231
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E1176E5C1;
	Fri, 22 Oct 2021 15:03:36 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79FE26E5C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 15:03:35 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 v2-20020a05683018c200b0054e3acddd91so2198236ote.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 08:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lF5HWTiRAvLcFi+VPh21i4lba3HTX4PZFP31zvCijhY=;
 b=pJlq4jucRE05x0ke/DqiXC3oYen3sjmR7njgYDKntSDsNavLnMWP/rDvcZvhLOVHQn
 MlqX9B+ATXC9DPu+kHOel7pbPU438H9qa+iACuJbex9zLc1fKU3m/LX/LOMii8RydvYA
 0sYf1V1ZqW6NMOQ/IjLb7q2MSoHuZhPH+JjXiX67c3XzPjn1CNdzrsU34Cqlzkd1+qJB
 uaYePM5sfjOliVb9egYTXDov4Hgkful+1sSuo/oaI62Scfd5G1fj9vsGVkc6K4eFyGio
 cr3OEuL/n/cRf0No8QFuMy+0P733IUr0DgqJEcy+SsMxg+Jy7xQ5eqTN3rRW6RZN1kkL
 LaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lF5HWTiRAvLcFi+VPh21i4lba3HTX4PZFP31zvCijhY=;
 b=6egMznNVIvenmEcnqXRd1pQUwIWx9dSoJF813Z4rRKxvP0aVcBFXz1IYcdKxoib/wt
 TlI3ux0aH5Ne1XanB07/fkzKMiRJe3bN7SJ+c07NVPKsrLpwDCpgvT2nqaI9lepqNQMg
 KyOGgFeIHDkWPerjikLt841aAHkANZz4lQzM+qSd3EuglE8uDEgKJrEjT2ce62cfLJeO
 6+JZrnYWkkxRcNEUNEDdF+Wrq6jMabpRFzkGnrdDOKb9ywiVjUsoaTTcwjBzVSr/tWZx
 gVszJSdZ3qONcMlLHulRkwVEy8RvOlmovEBNHxjWAz6PY1v7/rRcGmei81cnQpuK/BDg
 KpaA==
X-Gm-Message-State: AOAM532zHx3sDJDfwVXdn4lOkY0b/PkFpdYS6kiFc95Xf7T3a4Y1XYoR
 2M0q4SD97HxLLjcMbxll6hLIvO1MWkB/qZjb0ms=
X-Google-Smtp-Source: ABdhPJw9nKe27bkjmVtRo9a6WW9+ca1uGpVYKaUNN56SGOmDEKpJQ5wSD/c0JhrCG2E244Oh76ggC+0iF/z5dzRSoTU=
X-Received: by 2002:a9d:718e:: with SMTP id o14mr308353otj.299.1634915014773; 
 Fri, 22 Oct 2021 08:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211014153433.169454-1-contact@emersion.fr>
 <f6993cb2-53e0-b4c8-48f2-c5bf4eaaf511@amd.com>
 <25eb363b-e97f-0762-f39a-a8a459ba019f@amd.com>
 <CADnq5_NBpCm8fpueH2LF+Tepm9i33bp_nf-BbLo2pGXqkP3QiA@mail.gmail.com>
 <tI6GUqleTpv-LaeBR8URB2_AvRUbdOGhaqcjrg4kTGwLwKDso4x-SUhj5zAgg-4MoxbvJFrujGHnjhH4fNxn8125F1-sfrZB_2-YDTV2xlI=@emersion.fr>
In-Reply-To: <tI6GUqleTpv-LaeBR8URB2_AvRUbdOGhaqcjrg4kTGwLwKDso4x-SUhj5zAgg-4MoxbvJFrujGHnjhH4fNxn8125F1-sfrZB_2-YDTV2xlI=@emersion.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Oct 2021 11:03:23 -0400
Message-ID: <CADnq5_OtKTLRScqUj36LSUJpiT_Zq5jd0LZRPFt4Yav54p7M1g@mail.gmail.com>
Subject: Re: [PATCH] amd/display: remove ChromeOS workaround
To: Simon Ser <contact@emersion.fr>
Cc: Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira Jordao <rjordrigo@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Harry Wentland <hwentlan@amd.com>,
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@chromium.org>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Oct 22, 2021 at 11:02 AM Simon Ser <contact@emersion.fr> wrote:
>
> On Friday, October 22nd, 2021 at 15:58, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> > > Agreed that this patch is good but we'll need to also revert the is_chromeos w/a.
> >
> > I've reverted that and applied this one. Thanks!
>
> Ah, didn't realize I needed to revert that one too. Thank you!

Well it was only applied to our amd-staging-drm-next branch, not to upstream.

Alex
