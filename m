Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C92BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 14:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B417C1120A7;
	Wed,  8 Jun 2022 14:03:57 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C96011207D
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 14:03:55 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 r12-20020a056830448c00b0060aec7b7a54so15165143otv.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jun 2022 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yWrttoIscIPxOD063SWtdpN0QZ9IhgZatLZatyaSIFk=;
 b=LFGAzYNYJaFPBcpBfoHkwMA+3YxoiWTPDiJpOhwYKqrNj2Lhx8/sJnKDr0z7e2QZ9D
 ks+dEuhXR+n7XyyMsI4AUEpYFqse4bvbqZl+rMtUsCaaozTz3ljmfY9xk6R/OpgsYc/Z
 +mQ5xycE6HYWa7EZzQE3bfqUyDSODj3SHyeDaZ9fpH+WLvxyWzO+JMBcw8RQZgy0WNFA
 glTQP3xv5tc+xhOkGGFJ9+NzN39MPVH7elb9IMtS0ls8CTh+AaMuR0E0awPU0OmLSzkt
 F/H7iNy96ue7gvEh6uGC3i3+xQKJbO6gUnWy7tUsB9JhTwP0h1DQ3onC8bKvyRNUO4WV
 zcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yWrttoIscIPxOD063SWtdpN0QZ9IhgZatLZatyaSIFk=;
 b=T+GZbBqZXD9f1iRPdopnBvMuxUu8u/NFGaz628MJzDrqzUbsPMWVxwGcZ47iBc4ZcY
 WvFDJ9sw9nHmArQYKe45qJFV11SjSkYmMxmt7wVn/8EYXxZuB2kpj1Raau/cqliSeUpF
 JZPJ4PlLbuisaOnsCtj8UXd0Gdl7Rw+fDLfbJodozPu5tBHMC9e+EBNOd27FeX9jAs4L
 P8MZ/lCG6ibNvxh8SmGy9px9JBepIwmyrLGZSkc4iE94HC2zGXr8Zg+LNcO33LGsqDZn
 wD4j3UEIamZDGetupRKO7m+FcWWrgH2L5zgIet8LfyARB9aeSFgF7dqFbOsKIDaiFt7Z
 CYPA==
X-Gm-Message-State: AOAM5321TqT3O6erSeodKMGch7y0JZd+nSoErRyTWDdu3959/tgEfdzs
 C3y/8/xhxY4UC2FyQ8vKVhES76fJEjFGWF5kIO4GhsmC
X-Google-Smtp-Source: ABdhPJzkQvYeEi7cn4rIL9x1652DRhCL9OHGVJPLV0Ix0uaA/6zCArU64kkdvyvjPxv3BtAoT7p0qeAppcIjgc2l6go=
X-Received: by 2002:a9d:7853:0:b0:60c:2ab:624d with SMTP id
 c19-20020a9d7853000000b0060c02ab624dmr5041702otm.357.1654697034909; Wed, 08
 Jun 2022 07:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220603130504.81147-1-christian.koenig@amd.com>
 <CADnq5_OxrThyuAa0z9pK7FxJ=NoOj9yoezM4aC0_sL=UUPOXBw@mail.gmail.com>
 <eaf1d004-4386-2008-071b-abbabeb0cc81@gmail.com>
In-Reply-To: <eaf1d004-4386-2008-071b-abbabeb0cc81@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jun 2022 10:03:43 -0400
Message-ID: <CADnq5_ObxN5Y0r2CKtabYXNTWNzb+U2R0c-Mdk8VEpQEpXZyAA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always flush the TLB on gfx8
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Arunpravin <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

yes. will do.

Alex

On Wed, Jun 8, 2022 at 9:58 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 07.06.22 um 22:27 schrieb Alex Deucher:
> > On Fri, Jun 3, 2022 at 9:05 AM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >> The TLB on GFX8 stores each block of 8 PTEs where any of the valid bit=
s
> >> are set.
> >>
> >> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> Alex could you push this? It's an important fix, but I'm seriously not
> feeling well at the moment.
>
> Thanks,
> Christian.
>
> >
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c
> >> index 9596c22fded6..b747488c28ad 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >> @@ -847,6 +847,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *=
adev, struct amdgpu_vm *vm,
> >>          flush_tlb |=3D adev->gmc.xgmi.num_physical_nodes &&
> >>                       adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(=
9, 4, 0);
> >>
> >> +       /*
> >> +        * On GFX8 and older any 8 PTE block with a valid bit set ente=
rs the TLB
> >> +        */
> >> +       flush_tlb |=3D adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0=
, 0);
> >> +
> >>          memset(&params, 0, sizeof(params));
> >>          params.adev =3D adev;
> >>          params.vm =3D vm;
> >> --
> >> 2.25.1
> >>
>
