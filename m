Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739C7C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 17:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2F9610EA
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 17:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F2F9610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C28DA6E0E4;
	Wed, 13 Oct 2021 17:09:10 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C76AD6EA68
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 17:09:09 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id o83so4765089oif.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 10:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yDIKlh7uv8KuuHqr/rc/tLq48bWRP7UJm6UeoZVk95c=;
 b=R6kZ4t6NkKzvWG0gkz+IWVDoT1tVgySvHEncbUEx+m6yvMQHL2PLg7Pp14xvAOu5/N
 vgQmp96QcXUa0ZTapbpEOAtIOLKzIAZxIj4LrYeKgUcpDKzoftTC1+FlYmAeG/JUtw93
 Ip6332oIpSdyljDFmKyYdY8o7LLlLj/0dt6oA/Rd/xZKPDnpBKj9v1AyOtCBWGminIcc
 e2u2uNzAQ8gPSQ701QclvHy9fqxeKzWB35pANqLXMkljDSFKRWhjj2dVpoqpAD1wPGnh
 NbL5ueb/h+0VyQnLNZefYn1dQq/5kTUCzCu0xxyI0ZHYu4UeyZqA7GsZ4YzKph5bbgZ+
 TG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yDIKlh7uv8KuuHqr/rc/tLq48bWRP7UJm6UeoZVk95c=;
 b=5hRATh6HH+Ukb29MJInEPgBjRJvmS8D6NVXZ9aZ2N/nTePNpShXLP5rUfMoR9XhFpT
 8aRZ16vAu+JT1nMXazh789Ua+4JfMqtVFhwTI0+Fj7BJZb+9DOzi/k8r+U1Vodo0kBm/
 fI4Xygp/znCN2LtbC5U6kP9AgQYmqS72dUINulG5p9e8TkqeyZBTtEnTJrvQ8oN5C4iu
 45UngZ/mzgutTeXuq0gFYlPAGzj42/UzB/vYna7Gi4LhPAQvKnNuaw+jOnH7zBRGNlP8
 H6YE/DzSGldM0xcl95NZseQ+Q06nYRsvOPWleWePRcf0zHrWnOXJbHvUhXsri9dREj/a
 9K0g==
X-Gm-Message-State: AOAM533sSAHtufDTSPB/yqpbL2/uwtMiomL+zT9oJ3WYbN0Q9FcDUm+M
 blBAph87yuePBIfxm0JhbZtUSf08tsnSr7CT/S8=
X-Google-Smtp-Source: ABdhPJzQy8hmIsi9zxSJMWc37izLCp0r8xWIsmhGRD5jY3DJuq0GzF5SgcjR+TZFI7XRDSUAMbIvjBifvETNF4fwtMI=
X-Received: by 2002:aca:d6d2:: with SMTP id n201mr200838oig.120.1634144949026; 
 Wed, 13 Oct 2021 10:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211012155307.1059170-1-alexander.deucher@amd.com>
 <DM6PR12MB2619661366999CD638EB3C79E4B79@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619661366999CD638EB3C79E4B79@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Oct 2021 13:08:58 -0400
Message-ID: <CADnq5_NBXZXdJenv=acUL-Yck3NCW1yav=Vrt+tkvfCa_wZ8OQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/smu11: fix firmware version check for
 vangogh
To: "Quan, Evan" <Evan.Quan@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Wed, Oct 13, 2021 at 3:12 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only]
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>

Is this for just this patch or the series?

Alex

>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Tuesday, October 12, 2021 11:53 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: [PATCH 1/3] drm/amdgpu/smu11: fix firmware version check for
> > vangogh
> >
> > Was missed in the conversion to IP version checking.
> >
> > Fixes: af3b89d3a639d5 ("drm/amdgpu/smu11.0: convert to IP version
> > checking")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > index 3470c33ee09d..6d008e9c2f65 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > @@ -255,7 +255,7 @@ int smu_v11_0_check_fw_version(struct
> > smu_context *smu)
> >       case IP_VERSION(11, 0, 11):
> >               smu->smc_driver_if_version =
> > SMU11_DRIVER_IF_VERSION_Navy_Flounder;
> >               break;
> > -     case CHIP_VANGOGH:
> > +     case IP_VERSION(11, 5, 0):
> >               smu->smc_driver_if_version =
> > SMU11_DRIVER_IF_VERSION_VANGOGH;
> >               break;
> >       case IP_VERSION(11, 0, 12):
> > --
> > 2.31.1
