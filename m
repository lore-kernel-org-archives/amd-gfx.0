Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B495C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 13:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC0A960ED4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 13:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BC0A960ED4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6649F6E9CA;
	Fri, 23 Jul 2021 13:28:12 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0335A6E044
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 13:28:10 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 z3-20020a4a98430000b029025f4693434bso331179ooi.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 06:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WsnjIAwZDMXzdI161gVyxbq+xsSLo4R/uHvEgyuNbdI=;
 b=PbYTI0P+reE1d/NQZw+bEHSAfAy1fd8EdMS4IrNTHHaObUPvMaEdlRtrDu7iLkkw8Y
 IR83akhjuWtktXmPBS52xISyrzx/mEDz+3kx3uEpRhf7JilepAoHujfoDsHoC1YBQeML
 tynp56oDCGr2RLq7gFeN+U2MyCS4V5N/IbbffTIBmu/bQ/Sz0j/lKTCKUA12VtY0rcRJ
 rBxoNLDGD73lJDBr8uP9Ls0hAfG3R9J3Phk8GcYMCO0YyIC0lxCfBp34e5WIP0y7Y+zK
 9yw0PrK34Z5tSdKwHYs/rnxAHxy01s2jo5iAoRI8IqFrevmj7r4lwiLqhOtbpKOLdhB7
 vx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WsnjIAwZDMXzdI161gVyxbq+xsSLo4R/uHvEgyuNbdI=;
 b=UveguTv0/2jqT4ypt/65t64jg4piNSh4jDfJXhPPRKMbPT8VgCU79pn1Ds4YEV5Jlf
 c0LZRreyArSwKvpleOeCQlDm4+LpRb7Ji2wlmSmXC2wYSlcrDZBY4GdD7PsztPldrUD7
 wIoeJ3EB9vlgy0VKkqEGYMCEX+f4+vRLMHqVSRMYbw8z++5zZ0N5sjHa2nrfJTsQt4LE
 bPJxFN+up6EpgmzO5FRJkqj9zaoPM/vt4B6rYgAouvkbs1Z7sBt1DGZs5Tf7IjOIyJrg
 R3KJAgwv8f17Z4J4Pt1YfKK+AzI3VdmD6r/Pr5YxvBd4SeaJgtCdN1AoHWIR553Niw4a
 yw0w==
X-Gm-Message-State: AOAM532ny9CybR2pNN8f2rIoa0ky2UHylJdF0Iod62ZgWoG/DgrYTD0C
 O99SxYYttj8SziNVqkEwqcrmKJw6bGIiZ0ueYww=
X-Google-Smtp-Source: ABdhPJyixkb/J/CYZ/Dfq6R0XrU2lI0O8QeBuAUIZSQh/DEd5hDF9giCMMPILAZrGwxX2XPFz3JfS6eZE9/YmWqV2Uo=
X-Received: by 2002:a4a:e3cb:: with SMTP id m11mr2660995oov.72.1627046890316; 
 Fri, 23 Jul 2021 06:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210723124822.1137722-1-Pratik.Vishwakarma@amd.com>
 <8c44059b-4cbd-b0e7-34db-54c394df1b23@amd.com>
In-Reply-To: <8c44059b-4cbd-b0e7-34db-54c394df1b23@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Jul 2021 09:27:59 -0400
Message-ID: <CADnq5_NjyGNhmAg=aX=tb4yK5iAX2JGMz1JPdjz=ordr7G=Zsg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Check pmops for desired suspend state
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 23, 2021 at 9:08 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 7/23/2021 6:18 PM, Pratik Vishwakarma wrote:
> > [Why]
> > User might change the suspend behaviour from OS.
> >
> > [How]
> > Check with pm for target suspend state and set s0ix
> > flag only for s2idle state.
> >
> > v2: User might change default suspend state, use target state
> > Suggested-by: Lijo Lazar <Lijo.Lazar@amd.com>
> > Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > index 84a1b4bc9bb4..bf59bb263816 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > @@ -1042,7 +1042,7 @@ bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)
> >   #if defined(CONFIG_AMD_PMC) || defined(CONFIG_AMD_PMC_MODULE)
> >       if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
> >               if (adev->flags & AMD_IS_APU)
> > -                     return true;
> > +                     return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;
>
> Not sure if this is the right place, the name _is_s0ix_supported() gives
> the sense of a static check - whether the feature is supported.
>
> pm_suspend_target_state is a dynamic one - actual suspend state to which
> transition happens. Ex: s0ix may be supported, but user may choose
> suspend to RAM.
>
> Maybe rename to is_s0ix_transition? Will let Alex to comment as he added
> this function originally.

Maybe change it to amdgpu_acpi_is_s0ix_active()?  That better reflects
how it's used.  But please do that as a separate follow up patch so
that we can more easily backport this patch to older kernels.  Thanks.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
> Thanks,
> Lijo
>
> >       }
> >   #endif
> >       return false;
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
