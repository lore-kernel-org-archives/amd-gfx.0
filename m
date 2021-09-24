Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16683C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22B66103D
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C22B66103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ABA26E245;
	Fri, 24 Sep 2021 19:58:32 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BFE96E245
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:58:32 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 77-20020a9d0ed3000000b00546e10e6699so14702829otj.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=By51bhPXmF5v7P0VuXtEzVMMD3zJ6kKSJafoqorFTE0=;
 b=iyDGZpHyqLAr+rTBg8HrmyGg7GEnn38qvI6SFKg57GZH4AZ/+bBflRQ/UpaxxNygni
 mA3Z+0bJw9DPXgEbeZjUdmf46MU66WmMoG5Bfau4+V+YCrR+z+teLkh2mfrxgCUoyXLZ
 b/GIqYThFvRvnstSpsHV9fxMYtgQYHtrLU60WW5Cyr8iS3y25OSX64OD12VfEl16c9yV
 yxmOnPXIixLmvUA9rF2LDC9UsmWeoJmYzidNWSocuKihEd3xCGm1Y+z5t/332SKxgZnq
 Qexwlh6gUJbWMOopBBMmhoenBNjVq6mGcaSRuFb169XoVcx6Kam7yR3tUXFpmjYa3MtJ
 S1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=By51bhPXmF5v7P0VuXtEzVMMD3zJ6kKSJafoqorFTE0=;
 b=ZysgY2zWbzSkhoST/U6RIKDxdDpESMb+zBN4LZbWGvDqjEG8shYoFW4tVEQbAS+cj6
 XlCmf1EeEqTCuyIIQ39V3SLOAB+dyQAVrFnmcqLXDNbYu/6aqsoTmoeJnK7SPLt0rpL6
 8caNUVK9TYAMdcsNU9nxG9N2xI4q0hqNRWWp44sWvdhF67eZ9Ck/wve2yj5bnUaLwNpE
 GY8b72Fv5eH+pFtDOLvOdEsg8xRmxYjcRp1hPDoP0khn7Azg1Y669p+t5a39X722+l0h
 N8cfZ7g2XPHVudnaViBNBc4jfZqimWigsvHOmcxIhNJ8T3VNxqnvCzKo5rGCOsQIa4Hb
 N6Ig==
X-Gm-Message-State: AOAM530STqjM87tEK0dIJ7IVO0tT7gtt9RMyL92bt0CaQQdoX/OuX0m/
 10xz/tSCQmtRiZ6oceDc193jsnLC9yYCHpZf54M=
X-Google-Smtp-Source: ABdhPJyGjNhV+JSzlSVT3DbjyY9mw7lXBa+ZfOID5uk7bdpxmLUBP/xoGm7e4az1Q+JIlkLcyIBE0N6z8GsH+xgNL4M=
X-Received: by 2002:a05:6830:25d3:: with SMTP id
 d19mr5783619otu.357.1632513511377; 
 Fri, 24 Sep 2021 12:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-31-alexander.deucher@amd.com>
 <ebe17aa2-bf8e-c305-e275-d80e1f01537e@amd.com>
In-Reply-To: <ebe17aa2-bf8e-c305-e275-d80e1f01537e@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Sep 2021 15:58:20 -0400
Message-ID: <CADnq5_PXO43XBRjCg99=CqUQtYKbVfF7b_8h+K+98N=yP7HASA@mail.gmail.com>
Subject: Re: [PATCH 30/66] drm/amdgpu: add DCI HWIP
To: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Thu, Sep 23, 2021 at 11:43 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2021-09-21 14:06, Alex Deucher wrote:
> > So we can track grab the appropriate DCE info out of the
> > IP discovery table.  This is a separare IP from DCN.
> >
>
> I've never looked at the HWID stuff before. Do I understand it correctly
> that DCI_HWID is for DCE IP and DMU_HWID for DCN IP?

yes.

>
> In that case it might be good to rename DCE_HWIP to DCN_HWIP to avoid
> confusion. Ideally as a prep patch so as to avoid excessive renames
> later.

The names align with what we use internally in the IP discovery
documentation.  I'd prefer to keep them aligned, but I guess it's not
a big deal.

Alex


>
> Harry
>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index 8df4be702870..815db33190ca 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -756,6 +756,7 @@ enum amd_hw_ip_block_type {
> >       UMC_HWIP,
> >       RSMU_HWIP,
> >       XGMI_HWIP,
> > +     DCI_HWIP,
> >       MAX_HWIP
> >  };
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > index 048a08d7f480..6a993043badc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -149,6 +149,7 @@ static int hw_id_map[MAX_HWIP] = {
> >       [CLK_HWIP]      = CLKA_HWID,
> >       [UMC_HWIP]      = UMC_HWID,
> >       [XGMI_HWIP]     = XGMI_HWID,
> > +     [DCI_HWIP]      = DCI_HWID,
> >  };
> >
> >  static int amdgpu_discovery_read_binary(struct amdgpu_device *adev, uint8_t *binary)
> >
>
