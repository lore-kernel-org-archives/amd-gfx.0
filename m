Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E552DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Apr 2022 19:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CBE310E61A;
	Mon,  4 Apr 2022 19:18:14 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 800C010E61A
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Apr 2022 19:18:13 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-de3eda6b5dso11950209fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Apr 2022 12:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/coCW4Nu0lO/LUTjYj7YguahiSmlI7xtbcB8lwpYG9U=;
 b=eSEsrZZODtLuEfHBk5Cd/lgTF0HLXYD8klsMZJ6Joti2v4CLC/TkZKnRIHfSJZTuSB
 E/FCYI9WqAaPLwQFIG9BMxj+UpnUg8C1E0iZipABtbl7OwdYj/e9S0EaQgyxrCKcF/vF
 11YycsbwnrZEzL9IBFHLTuzWiknDCnmcDvw9QbZGpaay+H30kcCUis/lJS1Tnc0Sdyd5
 VWDkKHG8WCMwBtl/VdW93KcnEIpqkIdayUsH0E5aNJigZHlgTD6XkjF+l6bnG6wwY49d
 xwZGznvFrgG5I03g1g+JywZTIVrFlP5z46Wiv4YyW/67QsYk3EerdpWIgs/wa77skX25
 HuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/coCW4Nu0lO/LUTjYj7YguahiSmlI7xtbcB8lwpYG9U=;
 b=dyFEoObUr1fZ0V16+TqgRWNIelrsUeCalAfjZD4+YUp/y0vmKnDhgSV/zn5vBH1NCi
 ZRgvE3fVFjyjZ/kgeiWO6oRPfRjwn0zhVXGH3vE7m1CVwwOsQk5tDPEcSv7JVtTGgTmW
 CjwL6fbxI5EtPF0huD+jfhElu5a2Jz0jFktERNOxaJy1YtdW2I59Id6Lbd4XiBKMLXSV
 AeorVgonTeigdSqnR1uyQD14pqmlw2Iun0tDFqSF1ZKzGdGGjcA8+FmX6ThkcAtc+GMm
 jywI8Db9imb0HAuzxlcg+F1J9SahUdHkPuEGVCJ+iLl683KnDP6xQkRxsnRkv4CuUfjw
 Hg9w==
X-Gm-Message-State: AOAM531WJMt4goVu6HBsNChQhIiw9JRdPA4SHjN5jQ4P4j0OJ03OMZhX
 5WdLaRcD3bSS6I4bbPIBvVlTWmuD0GLVeDfmDBI=
X-Google-Smtp-Source: ABdhPJw5JTWq+cjH456TDLlpiyl2hSqZMshiwqa84WqeeYAP10rlW3MHiPtK1w2gMpPNS8zWm7Kc0LLbay8ZqOHa/MI=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr383015oap.253.1649099892736; Mon, 04 Apr
 2022 12:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220401195726.21436-1-Philip.Yang@amd.com>
 <3fce21b7-f1a0-28db-5322-6eb89a10fe8d@gmail.com>
In-Reply-To: <3fce21b7-f1a0-28db-5322-6eb89a10fe8d@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Apr 2022 15:18:01 -0400
Message-ID: <CADnq5_Mh+auV8yNSqAet-zsC8WC+8=NZWmsbg-uON_166bJ8gg@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: Flush TLB after mapping for VG20+XGMI
To: =?UTF-8?Q?Tomasz_Mo=C5=84?= <desowin@gmail.com>
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
Cc: Philip Yang <Philip.Yang@amd.com>, "Kuehling,
 Felix" <felix.kuehling@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 4, 2022 at 3:03 PM Tomasz Mo=C5=84 <desowin@gmail.com> wrote:
>
> On 4/1/22 21:57, Philip Yang wrote:
> > For VG20 + XGMI bridge, all mappings PTEs cache in TC, this may have
> > stall invalid PTEs in TC because one cache line has 8 pages. Need alway=
s
> > flush_tlb after updating mapping.
> >
> > Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index f0aec04111a3..687c9a140645 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -837,6 +837,12 @@ int amdgpu_vm_update_range(struct amdgpu_device *a=
dev, struct amdgpu_vm *vm,
> >               goto error_unlock;
> >       }
> >
> > +     /* Vega20+XGMI where PTEs get inadvertently cached in L2 texture =
cache,
> > +      * heavy-weight flush TLB unconditionally.
> > +      */
> > +     flush_tlb |=3D (adev->gmc.xgmi.num_physical_nodes &&
> > +                   adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, =
4, 0));
> > +
> >       memset(&params, 0, sizeof(params));
> >       params.adev =3D adev;
> >       params.vm =3D vm;
>
> On top of what commit does this work?
>
> It does not apply at top of v5.18-rc1.

This is stuff for drm-next
(https://gitlab.freedesktop.org/agd5f/linux/-/commits/drm-next).
E.g., 5.19.

Alex

>
> It does apply, but fails to compile, on top of "drm/amdkfd: Create file
> descriptor after client is added to smi_clients list" that is commit:
>    * cbe879c87245ce6272afe6456dbc8ce2c8f38d64 in amd-staging-drm-next
>    * e45422695c196dbc665a95526c85ff4b8752aff2 in drm-next
> fetched from https://gitlab.freedesktop.org/agd5f/linux.git
>
> The compile error is due to flush_tlb being undeclared.
>
> Best Regards,
> Tomasz Mon
