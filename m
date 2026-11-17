Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B06606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BZSPXta8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD0310E19B;
	Tue, 17 Nov 2026 15:07:10 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E36910E19B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 15:07:04 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-4e5c8b3facaso418317b6e.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 07:07:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794928023; cv=none;
 d=google.com; s=arc-20260327;
 b=WdIA9OEUaKRSBq4F5KXllO38pD3t6TDb6iYqdkXfrRDV/fF3okStP+KWdnzKKygSRS
 CAFZTVEHwVFQoDBq3Xpua2Znre9SH9TXI4XxXb3LPdjaM1/iaEC8meU7+D0SzAgtkrNG
 NXcaonoL/R3CWvYrR1jxuPT12Dst+WmLUa8m2trQOsnLuvFcIU3MRJLV+nxfZCieMcys
 Qs+jeos5TFAn2BqUEa6aogblUQNqmC8yiS5QZ8j6G5WOR7hIVGUlDiEiksYqin6ZIzui
 4EMbBZTPHQw0dqbpsnL4pHxIr2V5j9YAizrI1oFh01254SLsUBv3KdkGUD5s68sB/Dr1
 ST+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IUMLp8DW9eaFkkdVF5qGXntdxe8hA0oNla+2z13dcGw=;
 fh=s6RzS+6PVffuKvVs6B9i29NdvF/vobOUvYRSVHQ82ik=;
 b=Cpu5AGUjMXOsmBuYCEwr9DLG8hu3TBhN2gZ3WJNaDhdFAmHTPbVSwCWEAo2fdHQeGv
 msS2HzoIHeJtI63UgsD8r8gyhFZN0bLqjFAZzSpHAc7C68BYYQskeWOsD65lw9WbYO4w
 TXKgTdAGr5PaEysGKy4cODryo0yJIz3xlsPOepMmSnfyHtEs+uLdxBmWHFSPONNH1XvE
 HpDsnaWen8RfoVKImRK+XV0YWsBHz26bsnEHOHo7epn6vhtukTzXYMQfgpCl5CP1o3kA
 iFlki47QIi3GYrdEL1Ldr8l+hKPX9Lw4OuE3PS3IG/ZB9CW0+RoY62HvzGAHw6kjbVcV
 nOEQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794928023; x=1795532823; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IUMLp8DW9eaFkkdVF5qGXntdxe8hA0oNla+2z13dcGw=;
 b=BZSPXta8oC8E9pFqfPxC5ilpN1B6duooePW7Hea2y17TCbuKIolxZSIozZkcnm6iE7
 qb4y/AZKD0sFuMuMPS44c79YhH3MIwQcer+afQ1+vzJ+ySPOT8cW1AS4kuYUJUodnB0x
 Q47WC0t089Q6cuyASjj4cwcAVFGrpt4d9YOxf4+dcOvyoZi9HDqaqbx7dm5Ik0TbkeqY
 KaA6o1AxYNuH+r603YI/JK3bWGkWObu8ZgpM485x2hMbygUbSloxTl6XWFrxsJpnCs5D
 9eQ+RRjfBBXkQMMw9WdvKZGXpfbkA8RjokeYdhJ8QCQdp1Ed4hYOSradY+pZUkjZiw9+
 Zpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794928023; x=1795532823;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IUMLp8DW9eaFkkdVF5qGXntdxe8hA0oNla+2z13dcGw=;
 b=BCb2RG52+02YgOHBFUhrsQCMjIOoconqIjilHAlTmHIWW/2JNcRP+Wg5XCKx4Vkjx+
 RgBk5W5bypCh3jb1EU0Ct/TLVVD0C4DnnXs+RnXK5mm3+S+JUlKCzOEl+rGGwBfXfKUc
 qtqAUoghWeqTbkwfCluehqPI1+lVK2zT3/XlboY9NQ4R6Ml1up0UbU1QllqVcJjK4/GL
 dg0fjlSoi/ZHO8kMIlvQqaALvHJgtP8takjmwUJy53PrXTqs2x1l2ty+ld+h4CABXJWT
 pTklNuYRc7eycvdB9peMgpZqd7lbBEISTlK3lS1+itL5AkH9qY7vnSgvOMl8niKKg2Op
 hvrg==
X-Forwarded-Encrypted: i=1;
 AL+hErHwau24pGWytF6BGKOvMx4CCHCaNarbLDgR/2dVtSvMO6IJx5IWdianMo5v5fbNFUEe6/9HRBLe@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8RDAavERghFKAImSodXmxAciV2TQbyYO18fw+B7Pt3ZAepfFbl
 PDbflNTjvRqCH50r7MuCX/RXG7K4MWcGmOev/iuJz4fK16BmEncxzQKdIVeqcL0lwrsq5/9i6z9
 DUUOg1FjDQXkcpbpZZV49+rVKPsQupo8=
X-Gm-Gg: AYBFou0CphXCgbpUqpZEslLE5vaeH+B1qEN2mdGlNoN69daIfGHRsXsgrUu+QsCUBlE
 K/fSZHof5ZZqbZVjog/XartfxYeN1+Fmn2nkY85VFncdPW3UXuDBJI8TZn1iZdy9YFY51jzGfrw
 yuh5ZQ5pdxxvfnNaMV12O1pERl6yUnkkC08eqQpPgta0tKhWGhmrXlRU/xqdjj5uc2ek6eiuEPt
 cH/TO9vM0EMYM2RagKgBqfQDSuBjC44rGGkSratzJXTA32eBHqoKj0I1qbF1rFxaoWPUEPBIxKu
 RDpZSsRXoJN90qScqvFwwAuKDWuGeDT1/jTvFNLuzWOEngHNKuLQm6u2E/1pfdV23lvFeYAkwsI
 ift5LPmS3qFj/TD7bg2gNgf7MumivQNhpyZZQSqgpDdaDVApScziiKxW0zw7XCottEHOJ66f3FM
 Q8F24v73e3Y1+h2EV0+cVvfw0rCYfThULLzpndhENndT+xFAbRUSlq+ENY018yI3i7bbqkt+yXK
 ec3/JxT
X-Received: by 2002:a05:6808:10cf:b0:4e8:b729:3ebe with SMTP id
 5614622812f47-56e64f0d1c5mr20586809b6e.4.1794928023175; Tue, 17 Nov 2026
 07:07:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116144744.1904011-1-alexander.deucher@amd.com>
 <SN7PR12MB843595F0DF8CE5095E5A4DCA8C7C2@SN7PR12MB8435.namprd12.prod.outlook.com>
 <CH1PR12MB9598891F8CD8F48B636AE4049A7B2@CH1PR12MB9598.namprd12.prod.outlook.com>
In-Reply-To: <CH1PR12MB9598891F8CD8F48B636AE4049A7B2@CH1PR12MB9598.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Nov 2026 10:06:50 -0500
X-Gm-Features: AclHuK-pjwcbQEQwtn0zHkn_bmIAHjRBIvzpC1vf1F1Ws1BnPbocY3kB_qBxYvs
Message-ID: <CADnq5_NxT8hFgmhHgDKLAunnVFFBrjhz9xxzNFPCcq3=027kZA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdkfd: move TBA/TMA back to system memory
To: "Indic, Vladimir" <Vladimir.Indic@amd.com>
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhu,
 James" <James.Zhu@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 7:04=E2=80=AFAM Indic, Vladimir <Vladimir.Indic@amd=
.com> wrote:
>
> AMD General
>
> Hi Alex,
>
> Thanks for the patch. I have provided some comments offline.
>
> I'm overall fine with the change, although would recommend we use KFD_GC_=
VERSION(dev) >=3D IP_VERSION(12, 1, 0)).
>

I think the underlying problem is that the TBA/TMA buffers are not
properly saved and restored across a suspend and resume.  @James Zhu
can you double check this?

Alex

> Thanks,
> Vladimir
>
> Reviewed-by: Vladimir Indic <Vladimir.Indic@amd.com>
> ________________________________
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Monday, November 16, 2026 10:00 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedes=
ktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Zhu, James <James.Zhu@amd.com>; Indic, Vladimir <Vladimir.Indic@amd.c=
om>; Yang, Philip <Philip.Yang@amd.com>
> Subject: Re: [PATCH v2] drm/amdkfd: move TBA/TMA back to system memory
>
> AMD General
>
> Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
>
>
> ________________________________
> From: Alex Deucher <alexander.deucher@amd.com>
> Sent: Monday, November 16, 2026 9:47 AM
> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhu, James <James.Zhu=
@amd.com>; Indic, Vladimir <Vladimir.Indic@amd.com>; Kasiviswanathan, Haris=
h <Harish.Kasiviswanathan@amd.com>; Yang, Philip <Philip.Yang@amd.com>
> Subject: [PATCH v2] drm/amdkfd: move TBA/TMA back to system memory
>
> For non-MI parts, move TBA/TMA back to system memory.
> Results in GPU resets in some apps after suspend.
>
> v2: add additional IP versions
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6116
> Fixes: fe5966d4fdcb ("drm/amdkfd: move TBA/TMA from system to device memo=
ry")
> Cc: James Zhu <James.Zhu@amd.com>
> Cc: Vladimir Indic <vladimir.indic@amd.com>
> Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Cc: Philip Yang <philip.yang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 546721b4d59ac..b1b641ddbcf68 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1554,7 +1554,12 @@ static int kfd_process_device_init_cwsr_dgpu(struc=
t kfd_process_device *pdd)
>          if (!dev->kfd->cwsr_enabled || !iosys_map_is_null(&qpd->cwsr_map=
) || !qpd->cwsr_base)
>                  return 0;
>
> -       if (KFD_GC_VERSION(dev) >=3D IP_VERSION(9, 4, 2) && !dev->adev->a=
pu_prefer_gtt)
> +       if ((KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 2) ||
> +            KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 3) ||
> +            KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 4) ||
> +            KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 5, 0) ||
> +            KFD_GC_VERSION(dev) =3D=3D IP_VERSION(12, 1, 0)) &&
> +           !dev->adev->apu_prefer_gtt)
>                  flags |=3D KFD_IOC_ALLOC_MEM_FLAGS_VRAM;
>          else
>                  flags |=3D KFD_IOC_ALLOC_MEM_FLAGS_GTT;
> --
> 2.56.0
>
