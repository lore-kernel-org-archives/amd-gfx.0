Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB83C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 22:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 598F710E4E0;
	Mon, 21 Feb 2022 22:46:09 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90EB810E4E0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 22:46:07 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id z7so9516495oid.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 14:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2DyAdKsWD8K4J8wxKwkHFReWnZ/Uy2/g0Ouak1ubGqc=;
 b=DmVd6cbjhL8iTHWC+VPcb5DOGoKzSAthuG7IX5TGgHm3IzTVG4rPmzEnOnSuTQ+R8a
 /K9Ul+SH3nct92kgXSqIzBri8fSPPh6SYw9vQe6LFdqfYz+2r9jWGKpkj/Z1cPTIRBvu
 gEMvoHBMLLvYt3RKrNRv9U3FyRQMjd9F+7V8howWcvDRXFA1y90RGqyhbLbHm1DlWHvJ
 lXsCQ+mlEPZ7MBGVkhLEiulwVJXL70jkgTIwDOC/1VMqDrhoX7JXAo+GGFfs3HoYQSha
 4KCmdWucYDlvj4hLvWBWt0wy4SSvZLrKVKQqDVnMDZiFJ5MJPIMFFNos4LVztLTOaOfF
 t1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2DyAdKsWD8K4J8wxKwkHFReWnZ/Uy2/g0Ouak1ubGqc=;
 b=CmTIinHisNPKrFGESWycqwTl0HYfIFodFdFb+7O+Po4eci+nqIIxcHFZIVwsw7dbGq
 /UDDVEVCIyZBSUff4Vi9YOvjNERCtiltTWF1xWu5UOJLzIYRwTUem6xC/soJ8avDpsX2
 a2dPUOW3ciqXShgBL2WZNqdeVGT/HM+wxRk9H1PJi5VHv91Vr60pjVIi9IWU091Oy/EI
 7s3oSTyXxQFcJifmZNy8YvSZ3/p2T7bUxHJX032B8O/YGgLUEk5w1px6LECXwd+kyiQJ
 tC2kLTBEUeiP5A1Wtb7ZIuedpH9/W0uMv45Jw8/i5t7mbcT7P1LFtbVklZ/9rGWHXkBE
 2aGg==
X-Gm-Message-State: AOAM530i7nfwZ25vdvOTeVOm4z5jlaRD6sKCOertmRj4znDQsfdM0n6G
 TpQ8z4lOIJZYPtllOmtZO6pNT+hHrpDUapkBwBw=
X-Google-Smtp-Source: ABdhPJxXcNAFwPFVh/KwZoWtNCcEiIUjU7MBKELyFAT7hjwuTXtvA9XrhBVtbpjJ+MKMS8LjtbuAONU3qg/rlREO8zA=
X-Received: by 2002:a05:6808:612:b0:2d5:1c6a:db4 with SMTP id
 y18-20020a056808061200b002d51c6a0db4mr632340oih.199.1645483566899; Mon, 21
 Feb 2022 14:46:06 -0800 (PST)
MIME-Version: 1.0
References: <20220218204248.830299-1-alexander.deucher@amd.com>
 <90dd45cd-9cf4-d79f-dc32-76169fe10ee7@molgen.mpg.de>
In-Reply-To: <90dd45cd-9cf4-d79f-dc32-76169fe10ee7@molgen.mpg.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Feb 2022 17:45:55 -0500
Message-ID: <CADnq5_OewXLcg-xD2Dzet_4uCVKoFVzA6ZqXegnQK+aNu_-LgQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: make CRAT table missing message informational
 only
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 18, 2022 at 11:25 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Alex,
>
>
> Thank you for the patch.
>
> Am 18.02.22 um 21:42 schrieb Alex Deucher:
> > The driver has a fallback, to make the message informational
>
> s/to/so/?

fixed up locally.

>
> > rather than a warning.
>
> Maybe extend it a little?

Done.

>
> Component Resource Association Table (CRAT) are only applicable on some
> AMD APUs. The message is perfectly expected. Even on AMD APUs we can now
> fall back to treating it like a dGPU when the CRAT table is missing.
>
> > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1906
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > index 24898238b024..1eaabd2cb41b 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > @@ -1569,7 +1569,7 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
> >       /* Fetch the CRAT table from ACPI */
> >       status = acpi_get_table(CRAT_SIGNATURE, 0, &crat_table);
> >       if (status == AE_NOT_FOUND) {
> > -             pr_warn("CRAT table not found\n");
> > +             pr_info("CRAT table not found\n");
>
> Maybe make it even a debug message, or only print it, when a
> corresponding AMD APU is found like in `kfd_is_acpi_crat_invalid()`?
> Especially since Linux logs
>
>          amdgpu: Virtual CRAT table created for CPU
>
>      later on.
>

I think it's still valid so you know that no CRAT table was found on
the platform.  @Kuehling, Felix any opinion?

Alex

> >               return -ENODATA;
> >       } else if (ACPI_FAILURE(status)) {
> >               const char *err = acpi_format_exception(status);
>
>
> Kind regards,
>
> Paul
