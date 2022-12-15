Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558D6C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 15:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 432C310E38D;
	Thu, 15 Dec 2022 15:58:39 +0000 (UTC)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA9FA10E3C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 15:58:35 +0000 (UTC)
Received: by mail-ua1-x931.google.com with SMTP id q6so823107uao.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 07:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DW+2Ry0uXn+RlWRcmZHjDcgvpqXo7PEnj4h9c+epBZ4=;
 b=hZtcXxWO0EafnUmH7uQIW/KnKzkjsj379QjZB3ZcN37WMwdbSRNKT36mD4MY4VjRD8
 QHQrr92ApHlS9xQYIk/OKxINEYWtUe/+FLobIjhngZ0OtkMZtthtcJ8YWDUotZ2epILh
 /QGi1C8aCYRDM3QWd8DFaiHG1xjaAC5OgANOnR9igWVThGLWK7SbowYiQyffkP4/5P5J
 8oC+SM8Wwl5j6bnj9ZK2UUBXimuS12UIbgkfytyOJUEsy5mb7sJE8ne7JOxCImHonXed
 nyX3b5EVLao118ei82Oh9CsHK+x+HxTZOoyhIY3pC60lfZrM+kl8QPjgCdI0SajYzHzX
 llpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DW+2Ry0uXn+RlWRcmZHjDcgvpqXo7PEnj4h9c+epBZ4=;
 b=ZcqM6TbNjXsMsxQK9HVKnUHrlqCuJe+NcyddXv+D0IKSAAgvuUDA0qz6yN80B4K0r/
 1mnaV+FSKfqChonxj0iOzwUQpoAg02fKnDJ8d9XnQVt39ltXMrrslUzPKoV2rxZAymHp
 iUBO4b6zopAfCtYS47eQvO/DVIY1VV7rlloZDgFRJq3Y7kPjk7DA71saRpqQYsZVNf1v
 cUvRyYjQ7spqWudNz06LCIOXQQ2vQgFfrqHRwQ8eco+PsmP+gFuIAgIv/G6QeXJ6skLU
 BI5IifI1Dvayg1BZioLBnfaxZH0PH+5ThMLpDQZyneN6iqAKjf77/HMgaet+JYdw/5PU
 ZZwQ==
X-Gm-Message-State: ANoB5pmnJnde6OWzsiXn2ezzqTIqM9ferwk3M7YIRZFuurriMZA8VjZx
 XC5Vz9h9JHZaw+zxzaldK6XVWJb0kGIrsGdmc1Q=
X-Google-Smtp-Source: AA0mqf5FicaqszuVIF3fK64aZLYzlwLS8CzwceasyiO0gFVak5sdXDVq3fwGI1/sZMyWTuk1f0P6rypvWVcD3353oHo=
X-Received: by 2002:ab0:6601:0:b0:401:c732:b395 with SMTP id
 r1-20020ab06601000000b00401c732b395mr46556956uam.112.1671119914843; Thu, 15
 Dec 2022 07:58:34 -0800 (PST)
MIME-Version: 1.0
References: <20221214221654.1625194-1-alexander.deucher@amd.com>
 <20221214221654.1625194-6-alexander.deucher@amd.com>
 <867ec798-828e-a946-0d1a-50b2c23990c1@amd.com>
In-Reply-To: <867ec798-828e-a946-0d1a-50b2c23990c1@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Dec 2022 10:58:22 -0500
Message-ID: <CADnq5_NOqspiVN4zT3+Htf54tODLOJ+XOA75vFR2tU_wkW0_AA@mail.gmail.com>
Subject: Re: [PATCH 5/7] drm/amdgpu: for S0ix, skip SMDA 5.x+ suspend/resume
To: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 15, 2022 at 10:05 AM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@amd.com> wrote:
>
> Don't we need a similar check on resume_phase2?

The resume code looks to see if the IP was suspended in the first
place before trying to resume it so no need.

Alex

>
> Other than that, looks good to me.
>
> Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>
> On 12/14/2022 5:16 PM, Alex Deucher wrote:
> > SDMA 5.x is part of the GFX block so it's controlled via
> > GFXOFF.  Skip suspend as it should be handled the same
> > as GFX.
> >
> > v2: drop SDMA 4.x.  That requires special handling.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index a99b327d5f09..5c0719c03c37 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3028,6 +3028,12 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
> >                    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX))
> >                       continue;
> >
> > +             /* SDMA 5.x+ is part of GFX power domain so it's covered by GFXOFF */
> > +             if (adev->in_s0ix &&
> > +                 (adev->ip_versions[SDMA0_HWIP][0] >= IP_VERSION(5, 0, 0)) &&
> > +                 (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
> > +                     continue;
> > +
> >               /* XXX handle errors */
> >               r = adev->ip_blocks[i].version->funcs->suspend(adev);
> >               /* XXX handle errors */
