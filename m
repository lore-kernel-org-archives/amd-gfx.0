Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7587BC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 13:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0152110E3B7;
	Tue,  1 Nov 2022 13:25:35 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB49310E3B7
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 13:25:31 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-13ba9a4430cso16741137fac.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Nov 2022 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QVLGElr1Jl1dl2ocpR4yNYNltP2tfOat3a1+4xelfAQ=;
 b=OuhDfZUSDGa2f5mG1MYJqLIN8o8zq34GH4vaUKkSzlu6grW4wNkvkjTm4Gm/wkwSXJ
 uvoLqo1H/7hqRVFaqcbAFjdeDwar3Px9UtBpElrJWu+vnINg9m3zo/sBPUOV0H1GX0PG
 MgLhlehVGaKqBXQzRaxTe+TwLLr4lM0bbECUYBAbaQALDIhJsRLIQwyJpqbuAJNrQAiJ
 6XmPHv4n8+TsRhXfr1M6kiCN61dAsKPlDaUKXIkoxIQRcZuexLRoo6v3qntY2byXb2XW
 76xk778P/TZ+RScJLF4tjrS7e/j+arta2x3e3J9/URhfg3oI9R2gxpXk6hRTjiRBiHOC
 sFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QVLGElr1Jl1dl2ocpR4yNYNltP2tfOat3a1+4xelfAQ=;
 b=0/VsZLmMOr3Bc4DW1p/gCwHTTz71hpkgFHosTFhOKGdaIRXmkhS6gmt9yYPYhe81Rm
 D8VuDqrgoj46jL2tILmdoT1WUT51kZ59Z2FcPZToxQXo7B9FcZ9tKKXlJPKWaEsB2wP2
 d6VcS7UddY3yDj7EXSMmkfLz1rBJJGNeAByDZ9ASraFycVJ/VCOZ2yQFQ3n6yLjHcHFZ
 3vcdGuyRUG8/vNqMdxGqEsOE0HiCdCreKIv9ksh8zxaQDfazvuHSHKfXuRiugO9L9aD0
 ffUBr1GNPpDLetXCnv4BT1vM52hV3M3m/DJrX6SRMkMyx+dySbNIxKNJmpf8YRr5GUOd
 p5eA==
X-Gm-Message-State: ACrzQf2dQdy9fZzNvC84HeZWQjqmEHW9Z8c7yqnFBQmzgGqV/ke2XxSO
 lYMd2XxmB8vDklQdaTqDW8EitPr/+b4LcbZY+yFj1nxRANM=
X-Google-Smtp-Source: AMsMyM5CSvrCNynqeTNUjo+as3B0moCOKcYofh9v0AjnZBUEHqCgMXHAtGqbbpar33TarC/qVI7cBwkWefpV0mjnhWM=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr11215411oao.96.1667309130987; Tue, 01
 Nov 2022 06:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221101051450.1261693-1-Perry.Yuan@amd.com>
 <20221101051450.1261693-2-Perry.Yuan@amd.com>
 <CADnq5_M-Xa=4E5M8HdBrYnd4CT2cRabwJ=2kNrBTbFj81ETdag@mail.gmail.com>
In-Reply-To: <CADnq5_M-Xa=4E5M8HdBrYnd4CT2cRabwJ=2kNrBTbFj81ETdag@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Nov 2022 09:25:19 -0400
Message-ID: <CADnq5_MtoWMSy-YWp3mL805SOdpS0hJnbV0xo61YvtDFZ4RB_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add Vangogh APU flag to IP discovery path
To: Perry Yuan <Perry.Yuan@amd.com>
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
Cc: Alexander.Deucher@amd.com, ray.huang@amd.com, Shimmer.Huang@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 1, 2022 at 9:23 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Tue, Nov 1, 2022 at 1:16 AM Perry Yuan <Perry.Yuan@amd.com> wrote:
> >
> > Add the missing apu flag for Vangogh when using IP discovery code path
> > to initialize IPs
> >
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
>
> Swap the order of the patches.  With that, the series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Actually, you also need to fix up check_seamless_boot_capability() in
amdgpu_dm.c.  Switch that to an IP version check.

Alex


>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > index 3993e6134914..52a92add12ea 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -2161,6 +2161,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >                 break;
> >         case IP_VERSION(10, 3, 1):
> >                 adev->family = AMDGPU_FAMILY_VGH;
> > +               adev->apu_flags |= AMD_APU_IS_VANGOGH;
> >                 break;
> >         case IP_VERSION(10, 3, 3):
> >                 adev->family = AMDGPU_FAMILY_YC;
> > --
> > 2.34.1
> >
