Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2814DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 15:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BECB910E189;
	Wed, 16 Feb 2022 15:11:17 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5202A10E25A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 15:11:16 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 u25-20020a4ad0d9000000b002e8d4370689so2764842oor.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 07:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bVdJXuQqm5x/OrwdnzMHj/UO6YaJME7/tA7dQo0jK8M=;
 b=pTCOsm344KJN20Gi24sJ4pCpOmnv7DsjC7y7WJLfno3hSvue8OtVfRS3P2KL+NbDSk
 +qHLvQXyng/i+H7FctnfXW8miNZ+u2zjtEcFLab22NKpTTFFWbQZCD4u4c386KTgD4Y9
 eq3aY2t29DjFffwCbN0QI2ZAJmxweBf5ZGqnEycDPxLSaG3iwVQKb68lf8UaQu0Fvqta
 HIoYLnsKg5ebyQPWahR/4fHxe/Uhij9ECWq2QCsIe2fZmLbg7GINiLE0amCNBgTIq0/4
 9ibVVQHG90hysHn7+MMJT7bEtrIFSxJ5D1xVv0cz5kiIXup2ZsI4em4o2iKqlrt0BqBT
 PjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bVdJXuQqm5x/OrwdnzMHj/UO6YaJME7/tA7dQo0jK8M=;
 b=aznlhoilGJuEYXDm+4j+8c2JIEExz1H5jj3uDRY9UVmLCZxjXL5jHlIuuf3ZtDlI90
 EeIaKDtYFKhpZP/kjL0B8nAZlCZb8/gN176KKnZAWFJ4GZ4dtUFNUZ99Kk2agLA84veH
 bLou/4CJhDBIb9nAfE6DFRTDDgKJbDSsTAMVhviKuQhmlP6goWBuZFVRcJx+IPsqr4oj
 sd1klvHsHJKrqUA0uL3cD9lZRabg7gXYyY7qkmXIm+6lo0YJIRUaWxdS2JfHfdT412EF
 4Qugmb6ffVsWi0Wu7IarMkjd9CBHuRJQRkmFiaNzTL695wkvadVQxsqukezAbR40mrNG
 Eyng==
X-Gm-Message-State: AOAM533XPINcjOf4evJFRKD7OqneNgaRvurBZ00BmlYDz3HfCYnEZw00
 owahlzCzetDXCkaICQqppglZfxZMar2Hr6YpxzQ=
X-Google-Smtp-Source: ABdhPJw6tD3FbexXBkPBSa5+YDiLp4qxapW0zrQ5089Rq3aVnTsdVQa8eBCVrW08WNBgR80rmqpn1JjDBD/IXmCxQkI=
X-Received: by 2002:a05:6870:b281:b0:d3:e9c:811d with SMTP id
 c1-20020a056870b28100b000d30e9c811dmr640672oao.225.1645024275540; Wed, 16 Feb
 2022 07:11:15 -0800 (PST)
MIME-Version: 1.0
References: <20220216150755.2770674-1-mario.limonciello@amd.com>
In-Reply-To: <20220216150755.2770674-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Feb 2022 10:11:03 -0500
Message-ID: <CADnq5_NnFcbdCTyYSajnsbq+f-MTiKyDB-nh4QA+7wwAn55nYw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: smu7: downgrade voltage error to info
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 16, 2022 at 10:10 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The message `Voltage value looks like a Leakage ID but it's not patched`
> shows up as an error on Dell Precision 3540.  This doesn't cause functional
> problems and should be downgraded to info.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1162
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index a1e11037831a..e4fcbf8a7eb5 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -2109,7 +2109,7 @@ static void smu7_patch_ppt_v1_with_vdd_leakage(struct pp_hwmgr *hwmgr,
>         }
>
>         if (*voltage > ATOM_VIRTUAL_VOLTAGE_ID0)
> -               pr_err("Voltage value looks like a Leakage ID but it's not patched \n");
> +               pr_info("Voltage value looks like a Leakage ID but it's not patched\n");
>  }
>
>  /**
> @@ -2592,7 +2592,7 @@ static void smu7_patch_ppt_v0_with_vdd_leakage(struct pp_hwmgr *hwmgr,
>         }
>
>         if (*voltage > ATOM_VIRTUAL_VOLTAGE_ID0)
> -               pr_err("Voltage value looks like a Leakage ID but it's not patched \n");
> +               pr_info("Voltage value looks like a Leakage ID but it's not patched\n");
>  }
>
>
> --
> 2.34.1
>
