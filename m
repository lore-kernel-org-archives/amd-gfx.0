Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773AEC04A68
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 22:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECA9EC7D81;
	Wed, 27 Jul 2022 22:23:00 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FC23C7D7F
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 22:22:59 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id o13so166925edc.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 15:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1rDMiNsqNYdUp4hbscUMz6GFgxAcsHaTRwuLKZOfruk=;
 b=H6DXNiRDuvuoxI+EaPhIVaAozEqkIfI5iZfFxoHN7tv+WbTwv2Q45k+7DQLj7Fh2y9
 6NVQpibda45o7tYMVw2607e3rK6DWMS1y82D+WoggvLJM1rzcRg7eyOg8rlAHTF0kkgL
 Bt9M97xbShfY/GQP9rD38Cip0Hlm+zDjDxJYk+dh9aCw0Mh/KhfA/O73+vhCylh8JkGU
 ozc03t6tlQrILqsq6+rlb6WIrGQvNDYUqde1Ejfs9OTrz1jOzllfdZ7O/Bc+wSGevjW4
 VUGSoFE+JZyYZEQIwHleL5mzL0pJX/0KNTVPjkxM2jctGXWBjTpjaaFcsN7Vgm4viQt4
 DA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1rDMiNsqNYdUp4hbscUMz6GFgxAcsHaTRwuLKZOfruk=;
 b=2GLRs5EELZ/dThgwMAqF/gB0lj38zCtdcGXGfY53aOdYkocu/fc9hRrsWf0s8rdlVQ
 +9SmSLmqK12fjLMzhCy0gp/idOfR9ne98AWWJmX82OGmx5xgNWLCBli3coXchO0w8Aj7
 SWYDWYjpYbk8x5chUurCRnk9O6Df/Y6Q3grZxLTj91sxy6E8qlcG6UgvcMsDf/+yg628
 3NJFNotA8w7GJVcxGhyKrANOnB6nNHAIXi44WAx3AauWWJ4/p/O9bfnX+oD82KAGZuuC
 pSTqaMbX6iPERFqAHtT8gL1ioJoRW+kfW0yG9QNOGX6lndEbyS8xlZurTp2X7G7ijqxX
 nhrw==
X-Gm-Message-State: AJIora9oFwDjiKB7HzTpq8GsV55JNQP/CiwzfZ2nEkkJtsZ8goPsScRB
 FgQ76PUE7OqKuYZ24y7PjkCFXOD+EDGa0upX+J57xEIt
X-Google-Smtp-Source: AGRyM1sy8u1mfDDmuFvhVS/GHmc1n3VHYPfpbUTk582UIn4NJk+hd2zpAElY1ePygQ/sZwCB6HCd6UlK1IBwOD0pIBI=
X-Received: by 2002:a05:6402:510a:b0:43c:3bb9:8578 with SMTP id
 m10-20020a056402510a00b0043c3bb98578mr12050124edd.248.1658960577474; Wed, 27
 Jul 2022 15:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220727221855.324361-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220727221855.324361-1-Rodrigo.Siqueira@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Jul 2022 18:22:45 -0400
Message-ID: <CADnq5_MJnDcMr2-zQ2Uwcj-QVFubm8QAdfr5X6AP6ONkZA-cfA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Revert reduce stack size for DML code
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Leo Li <sunpeng.li@amd.com>,
 amd-gfx@lists.freedesktop.org, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


On Wed, Jul 27, 2022 at 6:19 PM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> We had a stack size issue on DML, and we tried to fix it by moving some
> of the local variables to some of the DML struct. In this process of
> reducing the stack size, we sent some other patches that fixed the issue
> reported by Stephen, and the below set of patches become unnecessary:
>
> 987949933127 drm/amd/display: reduce stack for dml32_CalculatePrefetchSchedule
> 8f08cd32b767 drm/amd/display: reduce stack for dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport
> 5d526d124fe3 drm/amd/display: reduce stack for dml32_CalculateVMRowAndSwath
> f6ceebcc7825 drm/amd/display: reduce stack for dml32_CalculateSwathAndDETConfiguration
>
> For this reason, this patchset reverts all of the above patches.
>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Alex Deucher <alexander.deucher@amd.com>
>
> Thanks
> Siqueira
>
> Rodrigo Siqueira (4):
>   Revert "drm/amd/display: reduce stack for
>     dml32_CalculatePrefetchSchedule"
>   Revert "drm/amd/display: reduce stack for
>     dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport"
>   Revert "drm/amd/display: reduce stack for
>     dml32_CalculateVMRowAndSwath"
>   Revert "drm/amd/display: reduce stack for
>     dml32_CalculateSwathAndDETConfiguration"
>
>  .../dc/dml/dcn32/display_mode_vba_32.c        |  12 +-
>  .../dc/dml/dcn32/display_mode_vba_util_32.c   | 812 ++++++++++--------
>  .../dc/dml/dcn32/display_mode_vba_util_32.h   |   5 -
>  .../drm/amd/display/dc/dml/display_mode_vba.h | 106 ---
>  4 files changed, 441 insertions(+), 494 deletions(-)
>
> --
> 2.35.1
>
