Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B45606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q/QNKYjx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44BBF10E252;
	Mon, 26 Oct 2026 14:55:17 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C122210E252
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 14:55:11 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-35ca5244753so420236eec.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 07:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793026511; cv=none;
 d=google.com; s=arc-20260327;
 b=BuCkQullXfibYXiz2eiAhpdGlYpz0eynvHBT42kT4RlukSWPqSEaPtW8q0Oq/VeZJD
 T9slp7jEJWQJnyPeb67cLB6d8JKHT/mI/G5iQBU03NXCEEmtkBzQ5bMMizMt9p8w+1At
 hwTWFu8EWft0GKQJl9jrtnwpYsqCFBhKU7rc9d8jOqTBg2zkrc/J3cL+Be26uXf5ZycA
 g+GMJumTudYrEdH5aJZv1AzDAxeBCRcqi8qgeO/ETsO+XcxrFvrNB+ajxLfM22PBUn+Q
 YpXF8S+D3uimuzA3gHpkbrSlSbJNemGDr74whl0HyfWvKpnidl2BV6q/SpyrSDWHlV5Z
 L23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oBuBvSLwAgs0fyiCrRPUQSShG6ve1axZYAN5ydZHiko=;
 fh=tnQVB6+p8IfkUQao1UgEoUuuPy1y0ZcXjD3FPE3iLio=;
 b=PXmQkWdXolEpMoX3Bu99xL7tG2GOgTaB0Aqvu/2wEUeEluEaJ+WTOpKJnuSIYiw/kN
 6XofibOWnbQNF/INWthOmpDNIjZkkd/igYSXczmLTOOaN7EjSva4PkviSf3FemCkXpuc
 6TWZEtbU4uvRlfcV2x6BpujWHrWWwkZE80fiFzdgLjhDKyS6Yo6XYrhgVi/yvFW/LZNu
 n10srwrcWkkADO31k0Xdv1dC+3NcRu/6AL5Y6JMD15boQ+VAeJUyle+fgs9LJ9QsjPah
 9E9CNbS4Qe+ucb2IeGEUVKV8E7mrwXCD+wxko0PmtAgUHVuF0rMtnTM9iFslAdELJMAn
 IUDQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793026511; x=1793631311; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oBuBvSLwAgs0fyiCrRPUQSShG6ve1axZYAN5ydZHiko=;
 b=Q/QNKYjxUSgivJbSf6a3pICLRLABqGLNMZsm7Zx3fBVtf0Vwo1sBfpji5H2ys6HpQe
 oT0d7DMxZ/WAoAnuFdDVZVuFdWQRJRg0Q8v93J7l+vva7suacmAtgRKtn9sL20slAGi4
 JVDWtCUNyydcjyaw0v3aQvmsKH8ISJ2SfBoJi6a8PEIEVgz4RaEOvV+oFftDGH6fl8zj
 1HEaF49zQJ8s1TwqpdNIEBR0jSVMzSYqzfkfAr2w0aXyv7rHQAeKPiFU0LVoU3uJ+/vX
 Q39HbzBXrwytzH9z/5cw4MMYafxpQFvBlQkopVBxJdbpKzvuQR/dKAe1uUphu/IpWWEW
 XDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793026511; x=1793631311;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oBuBvSLwAgs0fyiCrRPUQSShG6ve1axZYAN5ydZHiko=;
 b=iyF2QYy5SmpEJZQAxJpXBg7amfvexMvdb/aac+OF/XDFPQ56KU/IdBH+E7HoysikXa
 EUSTZcq/9MZBsSJRAqKtZdsCdjM6WCQIPace3Hrr/VtFo2hBriCcvMnkg5AaQSedFjPu
 +CtiLjFtL2QeU8aCJwpo1is3ey+VudQFh2wf81PGU1inAaR4jSWC48Fcw1Rm9+nlCTat
 unoQe7Gx/sOyO/fwjRXlh5QWi1jdLagPjPDubauI0BorZz3Igdore3thEmxq9v6atpjc
 74Pe11JapNDPHM+N6jfpzrKLMxmDYPBFUqiHOeiUR3OEggt8Twt0Vp8M6F0PiS4k62F3
 9WgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBEBdEc/1M1keT1BWdhN7USvhSiyRONryy3Bjv0A/5FRWPe/jmaDZD3Ac30F/KyEZ1WzL6IpxC@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI/i1u1lXraNZ3cQKYWRwapnz9rcwiZIOG0QFJMhiuo446d06Va
 kdgbqhu3p6RUcx6oIDsbMyzkysA6BMwQc/NrhkKw117J6bQSWb0tMgRY5cygbf+xVQBeAj+PA8R
 DRf4c4DqGG9EOgeSshsgMOe6K/u4H1Ac=
X-Gm-Gg: AYBFou2g4tGgnHQcm153DNQ/hKJupDLWpLh0QN9zPJ0UlUdUw0eaEwJridzNN67BKdy
 l0CaB7pim7bmeY2cv6JeAOKhB88wtQNK0Euiy7b/NkyNYGszxbQ5am81akWscJFvaOH61RkGIgI
 kK8wReYQySxRicy65JkmKoQhkjqzsTKOKN4pMLKIstcFWj3JwiDXPoeJ7VNdLmqchKUS2prmWo2
 QHN7HV4sjvR1a57v7g12wB/Ae/TgxuHmjiXjhbuDrbXmQM5pA3DVOeaVFbXK7eoc2xoEE36vzBP
 qlGKr4J2UGs1bthA2ARGa31sj+eYRSPnRH8VsXPAPgaFVwEotIk1VyjZHWaGiqvNMm2IvZU1AHC
 Vmlaywe9uSTxeZwHlsVuCb6GkmZgJkjIaILuSrfWZHaEtBzKHvVzrI14wSFVFmaoej5uWSKQNvC
 +7deRSBEUVfEqvc3k02trtisg=
X-Received: by 2002:a05:7022:4582:b0:190:e602:c769 with SMTP id
 a92af1059eb24-19933e0f4e9mr19650454c88.1.1793026510536; Mon, 26 Oct 2026
 07:55:10 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023101246.937830-1-Jesse.Zhang@amd.com>
 <20261023101246.937830-2-Jesse.Zhang@amd.com>
 <4121d6f0-c22e-4527-b2ed-acba18f70fe1@amd.com>
In-Reply-To: <4121d6f0-c22e-4527-b2ed-acba18f70fe1@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2026 10:54:58 -0400
X-Gm-Features: AclHuK_IYgUQKKTjCLTt6qGgy1Hp7_SkKzRvbppkqO2jfaI6zAWpR53F5ChCAhs
Message-ID: <CADnq5_PMWVGBtKvgC7PAUavTTmeHfjk=-gFtHH67rU4hr-gDQA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: parse CS IBs at the BO offset their VA
 mapping starts at
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org, 
 Alexander.Deucher@amd.com, David.Francis@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 7:16=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 10/23/26 12:12, Jesse Zhang wrote:
> > For rings which parse or patch the IBs on the CPU, like JPEG and VCN,
> > the CS looks the IB up through its VA mapping and maps the BO, but
> > ignores the offset in the BO the mapping starts at. It then parses
> > other data than the GPU executes. On navi31, an IB of JPEG NOPs in the
> > second page of a BO, mapped with offset_in_bo 4096, is parsed from the
> > zeros in the first page and rejected:
> >
> >   amdgpu 0000:03:00.0: Invalid packet [0x00000000]!
> >
> > while the same IB submitted through a mapping of the whole BO works.
> >
> > Add the mapping offset when locating the IB in the BO.
> >
> > Fixes: 4802ce117786 ("drm/amdgpu: fix UVD/VCE VM emulation")
> > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>
> IIRC that was brought up before, I wonder why that patch wasn't merged.
>
> @Alex do you remember?

I think the last time this was found was in the IB dumping code,
which, IIRC, we fixed?  The patch looks good to me:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
> Regards,
> Christian.
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index fa301c71b782..4a277f04cde5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -1073,7 +1073,7 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_p=
arser *p,
> >               if (r)
> >                       return r;
> >
> > -             kptr +=3D va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);
> > +             kptr +=3D va_start - (m->start * AMDGPU_GPU_PAGE_SIZE) + =
m->offset;
> >
> >               if (ring->funcs->parse_cs) {
> >                       memcpy(ib->ptr, kptr, ib->length_dw * 4);
>
