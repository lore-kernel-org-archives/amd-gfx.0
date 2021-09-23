Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9E5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 12:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 726E9610C8
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 12:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 726E9610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01DE56E07D;
	Thu, 23 Sep 2021 12:51:15 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5920F6E07D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 12:51:14 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 5-20020a9d0685000000b0054706d7b8e5so8376323otx.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 05:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9CHS1O+cEwMgtNPWMkMVIXdzPqFOMtHQzrQjr/oc9As=;
 b=qu+vB8+NjbhSF0fRdyslXzUhnJl2otRJzn2/tIbESUAgkiEsbc1V6qBIhNexwSm9qq
 7vGAUtW7fOOHnNxXLlPRWKmvxmfTxvSWFnEN/9GihYy9uvXNXt+LFlFMxmBnMSp6Bj10
 LonnjZNzEmSRZfU+OXrLc2hx2GOmWeRIoF8CJe0o0Skz3s4y308aBuqh+5yr+c/Y7Zdi
 oqAgPmWKgR6IRAQY+VIj4vJhQp3qt2bgupPZTPg5DsR9Yiu524ZFlfGDzW/PlFy9be+q
 uMGjChtfUlp84UD5fB5IHV7o+IzQ5b39x11PBCRyjiLbLATbICsYjKhfG+V5x8X+p2JL
 CksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9CHS1O+cEwMgtNPWMkMVIXdzPqFOMtHQzrQjr/oc9As=;
 b=6eJfPMLvNYAgn2vrVxJWaEasM/dXrGEPoITVFdh9HBAEfitaeglFHueY8UEtqErU6H
 DICwrmceXOgFCKYLUjokrzxtrBmhCadCq2AMqFbxQDm7qQLAhU7lKxCO5U1YoOgwJOKm
 tudYEKw0urhAcKhq/1Arn3SBO2fGCxxO1iB07+F2GAcGxkQxCcbPeZeHeds2gU+RsYfV
 BJSf4OD9VrJSm/23fsRIrUQI0wGMeaQ9Lsk04YS/kttWi8Dffep7x9xl7gnVWj8b9n+s
 q2yxUf1KnzxVy4qDDWgCNhElecpIOI/L7Sn2rpw9veu/xFlW/5f1RsBG61Tj7goyLOvG
 vhfQ==
X-Gm-Message-State: AOAM530rOM0rK7Jq9XA4kRBoqohfhm/+/79p0Fw8OWbEtrAt92wXMQrN
 1P1YZmSRagUrHlLwVOzF5uEmNfH1S8/91Qmtplg=
X-Google-Smtp-Source: ABdhPJwQXca7g9b7xrSpl5kQuHc1B/anCPF0sFTsznG3HfKVqsVl5bGVGdmthgytV8f+DIOS5+6XA4Qcg4mTZyZONes=
X-Received: by 2002:a05:6830:25d3:: with SMTP id
 d19mr4183352otu.357.1632401473489; 
 Thu, 23 Sep 2021 05:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210923042937.16385-1-lijo.lazar@amd.com>
In-Reply-To: <20210923042937.16385-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Sep 2021 08:51:01 -0400
Message-ID: <CADnq5_NBP4ZGJ+gzDuWoiTMu8iD1yQ8N--QxGDzmb6-C82aJ2g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Update intermediate power state for SI
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, 
 Kevin Wang <Kevin1.Wang@amd.com>, Kenneth Feng <Kenneth.Feng@amd.com>, 
 "Quan, Evan" <Evan.Quan@amd.com>
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Fixes: f9b7f3703ff9 ("drm/amdgpu/acpi: make ATPX/ATCS structures global (v2)")

Thanks!

On Thu, Sep 23, 2021 at 12:30 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>
> Update the current state as boot state during dpm initialization.
> During the subsequent initialization, set_power_state gets called to
> transition to the final power state. set_power_state refers to values
> from the current state and without current state populated, it could
> result in NULL pointer dereference.
>
> Bug:https://gitlab.freedesktop.org/drm/amd/-/issues/1698
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/si_dpm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> index bdbbeb959c68..81f82aa05ec2 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> @@ -6867,6 +6867,8 @@ static int si_dpm_enable(struct amdgpu_device *adev)
>         si_enable_auto_throttle_source(adev, AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL, true);
>         si_thermal_start_thermal_controller(adev);
>
> +       ni_update_current_ps(adev, boot_ps);
> +
>         return 0;
>  }
>
> --
> 2.17.1
>
