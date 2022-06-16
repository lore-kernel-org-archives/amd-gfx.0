Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518AAC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 03:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA85010E9F4;
	Thu, 16 Jun 2022 03:12:37 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC9C010E850
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 03:12:36 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-fe15832ce5so414812fac.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 20:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WABOVpxtXrSkKBDi76GMXTlkjMr70F64Mfb1A1letIQ=;
 b=S7l4M5CHWSDJKmFdJ7c7nj7y+IyfH0Hnvv9QG5Ijdt1ChqRlV0P+VBxyv91YJ07oft
 3xAeg4utxOxjXO3HRztp/ve+lugyU/iXWbKLljqeGWQGUuJdHn2ghwvDIBogAcZiaJ8I
 CBG3iVsO2twqLXjl3LOgzl5bJom5TzfrIAJ4VLajNe+8yMvN1SO4A1M5Cq1aTm3mOHx1
 oPzLqGiAu2k0iDrpfi16JlmzuUBqAW9ZxM/3TGqOHt7uja7wEj/Su8MJbHA4cTPnqmjM
 YElN0hSyfybM4ePRybSTwItUbxpvIJcRKyCmkr1TMCxaK+ZUgOBpkE0eB0lDQV6SFmKW
 vsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WABOVpxtXrSkKBDi76GMXTlkjMr70F64Mfb1A1letIQ=;
 b=8N4v9ruRXQyfi1d7ePDtUwHogeKf0BBh/xFWF9oO7T4v+HsmT4Ob0topgDF+QJGgV7
 pekihZtbHQ9EWzM/nlfgywGhoghVeEJHbdkS5PpsggYY+kdslO68baJ1wwK1iMcVfWgC
 Je3Eo8Podb4Etcq8LV4KVNRqox2XYBskTZ5q0CbOSAdcTiuiJwH8RszhRSOpPIhLCcPc
 GOC9UnQn5oCu3wTbPx9gY4g+5Fknh+SRQTVg5qgq01wPTsF8nAVLUArPxneveKFA9AYJ
 fqQZGT+LF4EsyXW4UC7/VYx+X3KnaBS7Jz+oNRCoj3LmmOufMgmQu7EpaoRFiC/uDeyL
 3/SQ==
X-Gm-Message-State: AJIora8pFT2pdJD4UGfBP2r2d5OaUkQK8mvBsvRY2WEvEwbL+F6isGG+
 gADr3QU62gqqCnLVa47TL8ne5P1L/laNOpqRAio=
X-Google-Smtp-Source: AGRyM1vFm7hjWG1Jw0bSTQtzf0ZNBaTz7/X2vX6y8HkgBMyvIBbMlDVHB7H+36M8IqwWydJjMRjCtqzfJMh8ZKCMerc=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr1654659oap.253.1655349155996; Wed, 15
 Jun 2022 20:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220614142220.19188-1-mario.limonciello@amd.com>
In-Reply-To: <20220614142220.19188-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Jun 2022 23:12:24 -0400
Message-ID: <CADnq5_PrgkeJvrGoYPNCEe3J1gYFB5G94W-j1yaCRViKGm9Stg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Don't show warning on reading vbios values for
 SMU13 3.1
To: Mario Limonciello <mario.limonciello@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
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

On Tue, Jun 14, 2022 at 10:22 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Some APUs with SMU13 are showing the following message:
> `amdgpu 0000:63:00.0: amdgpu: Unexpected and unhandled version: 3.1`
>
> This warning isn't relevant for smu info 3.1, as no bootup information
> is present in the table.
>
> Fixes: 6a73454350c0 ("drm/amd/pm: correct the way for retrieving bootup clocks")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index f18f9605e586..0e59ab2192bf 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -731,6 +731,8 @@ int smu_v13_0_get_vbios_bootup_values(struct smu_context *smu)
>                         smu->smu_table.boot_values.vclk = smu_info_v3_6->bootup_vclk_10khz;
>                         smu->smu_table.boot_values.dclk = smu_info_v3_6->bootup_dclk_10khz;
>                         smu->smu_table.boot_values.fclk = smu_info_v3_6->bootup_fclk_10khz;
> +               } else if ((frev == 3) && (crev == 1)) {
> +                       return 0;

I don't know if Evan has any comments, but it might be better to just
return if ((frev == 3) && (crev < 2)).  I'm not sure off hand which
smu_info table versions we might run into.  Evan or Kenneth would know
which smu_info table versions are valid on which SMU 13.x  asics.

A;ex


>                 } else if ((frev == 4) && (crev == 0)) {
>                         smu_info_v4_0 = (struct atom_smu_info_v4_0 *)header;
>
> --
> 2.25.1
>
