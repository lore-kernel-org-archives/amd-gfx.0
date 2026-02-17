Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71161E909DC
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 16:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1426610E51C;
	Tue, 17 Feb 2026 16:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dJFpzaJS";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B10410E51C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 16:47:22 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-1275750cfadso39610c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 08:47:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771346842; cv=none;
 d=google.com; s=arc-20240605;
 b=N44816ARyL4dOZgyspTHQSnKum0dvS7OStX8Ul2oUns75SICw36sm1BRIlD6NovM7x
 TdSnTbJJWyKYNo3bsfskehzHt8rFgJn/Zw1Kedj7bTlYLAOftnpgQ/TcJ/f00akn5XaQ
 Y10345rZcbLvcaowPrwc+rS5K5gGGrDURwvn9rjj+Pj+NTtpTkFhqXt+sZyATFgHwfhU
 QIeSbXlnXmkWvq2ojto+iN0swkuJY9kptY6K2ttiJmocAsGwt6ETLPYjeODOLOOJGbY1
 DECg20MOXAJ+33Xtd/FkqEZUq2GvrF98xg3Y6ZZj7NckUcOVOazE5k1R4QiCoGWcKTGs
 RCeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VokuTejaQBC0yTx29wLjFLNBukrHovvkoeyofn8ozM8=;
 fh=Ty9/+aIixTekS/uBgoKuZlEVebvpxxPjROidjxn69ZA=;
 b=cINbdPpX/VJNlJVqHe1lxu5sSSUEtUsJQk1AudDpqddlVyv3LnxQfjYsteEMfY4d7l
 0Tg5/bkw78Taio71m14b5wL0IMp7QMeZQUKgEwLGm+vanQDQ+zIZytwwasmmZAIbI9/3
 vTGX27cyK/277JQ7q+PfzCV+rWNXUnlkjuUdmwmCdc1s6e6YzY3t5d0Kd5o3+kjDVxbN
 olkskhTnyr4k3c5uiw90d8SXbOY8c6brWMQcZgKWu2L9BOGns2/QuWxYsT/2qoUuaLt6
 /exIPNWng5IsZ/8Ubk9nxmHI86gzkTNoAOEwmKkm+RmuuWrS66mkkHyvPTB06AXcaNQT
 XTXA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771346842; x=1771951642; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VokuTejaQBC0yTx29wLjFLNBukrHovvkoeyofn8ozM8=;
 b=dJFpzaJSLoyPOKPZ3/qLqsF7YVo5jT9XxDa7fLe0GruyzKArfnI09mhQflsTg+Fbzi
 XPb/YvlJWkb1rNWoUj3ZttRpDNOncb9dQmP5jfQPLZdnN1Qa9Ug2+UDBQlGzp6x4uqQZ
 7Z1Ym4HMO7k3ruqun4GRBhrZH78GinyJOgzXu2P5v6OMKZ6Y/UFERHnqfg7rbZC3CAOn
 cgi7UnBXWdtVpRkc5gZiMEXfWgUbSU2Hg/iykEA5DS6X/Bg0OY8KUIA+zX3i7nTO7Xz1
 26XXgeyzR9QqaISie730+wIcbXok+5wGNlDRVfxnL/v13iChqXAi7oIj8eQ0/vvfAM4a
 fPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771346842; x=1771951642;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VokuTejaQBC0yTx29wLjFLNBukrHovvkoeyofn8ozM8=;
 b=PirqBO9gDNFSS+9l3EF1GPM4gMOBXyLXd6zwSg25cKly/QrNjN/9vmpVv+hsk16tX+
 7yXmUzDuUMDrpMxBNv3zjf6rmyPbn/hnOBJ/3+5cIF8+0XDd3djhx5zGIoNkJoh7Dx2O
 h3Io6dzWehHT5gPYOFYTA7fD+N1y+7mwbGe4EMC3fw085HCfC/+ONDYYNsD/cRDyulrB
 2SVF5lF3STxNAuw8GEGZsKZFC0ZFhT6woAO02Glt+1OJNJYjFUSCnY15zSxf7pXRR2Td
 QusDMAUYnG5rbaPGZH3xddcMTQIHltk8kq307/Ij0/0FHcwTmn/UWXPrBwyBvfqYSDov
 NU9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCXXOUEOFf4CUjMxStvB2rt0LMB0JCCcfltA6m9XLlfYPYMGMEWNkop0Di6I5qUw8zcTUVEPTe@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxClzIKJ92x1h6wsjFJdgQUim7m3O5vrJw6+rII+/ItAQmM08a9
 I9MD6O/fHR01ltduu0P6bShj9ztE+FsknwNNW4/DeCscbSwf4bR+A7O8g/WI1j7sfO3Y05JFDGT
 6LyTdDw1BW29wXX1OYnXf6syaQl7l38A=
X-Gm-Gg: AZuq6aIHIKkr0dka0GrHM+xbeL/v/3vGxauFWeGOPUqiTURgu6tYPP2tRwBq28Bg4DX
 H0KxooEAFHPdSrUh0du1YbDRj2g6CoQbSjFMJasJ8dXALBeDsdz8QPC6TQ1D/LD3g0vpxyGGVzd
 J5mAwbEQXh+bl4fcXYp9bpolTasRRerw0y1iS689UQikfk30yR3m53tag7u2qVSaqAW/t8flxDy
 Ib7eSyKhvs7wICTeghnmA3CMbjmqJOXr4Dz3Mnk8cWNR7qqG1ByqyQw7ITKc+1iHz73oBSRA1zE
 tp5VefCL5ttDVhNYrFSO7RMjnos5Pe4RNwBuDyf2dk4UaySGyiz/QIsOvkgGDXT1of17NQ==
X-Received: by 2002:a05:7022:2228:b0:124:9e46:830e with SMTP id
 a92af1059eb24-12739793825mr3442314c88.1.1771346841830; Tue, 17 Feb 2026
 08:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20260211102657.4180-1-pierre-eric.pelloux-prayer@amd.com>
 <20260211102657.4180-6-pierre-eric.pelloux-prayer@amd.com>
 <CADnq5_Ndh2zaQ5VcoA1jNjAohkurqofd5_TweCfX+iaKz9h+vA@mail.gmail.com>
 <78b10f62-60d1-4dee-94a0-fa2eaf139cb6@damsy.net>
In-Reply-To: <78b10f62-60d1-4dee-94a0-fa2eaf139cb6@damsy.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Feb 2026 11:47:10 -0500
X-Gm-Features: AaiRm50GcYHyj25MurjIg32rg_RXR15XSO2HmWEmfm3sOAkyfluuePJnNxPb9kA
Message-ID: <CADnq5_OJ3jS8yUN6yih5UaydOKHUr=-dxW9+anBFgniOV0UqNg@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] drm/amdgpu: dump job ibs in the devcoredump
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 17, 2026 at 11:38=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric@damsy.net> wrote:
>
>
>
> Le 17/02/2026 =C3=A0 17:20, Alex Deucher a =C3=A9crit :
> > On Wed, Feb 11, 2026 at 6:07=E2=80=AFAM Pierre-Eric Pelloux-Prayer
> > <pierre-eric.pelloux-prayer@amd.com> wrote:
> >>
> >> Now that we have a worker thread, we can try to access the
> >> IBs of the job. The process is:
> >> * get the VM from the PASID
> >> * get the BO from its VA and the VM
> >> * map the BO for CPU access
> >> * copy everything, then add it to the dump
> >> Each step can fail so we have to be cautious.
> >> These operations can be slow so when amdgpu_devcoredump_format
> >> is called only to determine the size of the buffer we skip all
> >> of them and assume they will succeed.
> >>
> >> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@=
amd.com>
> >> ---
> >>   .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 84 +++++++++++++++++=
+-
> >>   1 file changed, 83 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> >> index d0af8a294abf..d576518c212d 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> >> @@ -200,12 +200,20 @@ static void amdgpu_devcoredump_fw_info(struct am=
dgpu_device *adev,
> >>   static ssize_t
> >>   amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_=
coredump_info *coredump)
> >>   {
> >> +       struct amdgpu_device *adev =3D coredump->adev;
> >>          struct drm_printer p;
> >>          struct drm_print_iterator iter;
> >>          struct amdgpu_vm_fault_info *fault_info;
> >> +       struct amdgpu_bo_va_mapping *mapping;
> >>          struct amdgpu_ip_block *ip_block;
> >> +       struct amdgpu_res_cursor cursor;
> >> +       struct amdgpu_bo *abo, *root;
> >> +       uint64_t va_start, offset;
> >>          struct amdgpu_ring *ring;
> >> -       int ver, i, j;
> >> +       struct amdgpu_vm *vm;
> >> +       u32 *ib_content;
> >> +       uint8_t *kptr;
> >> +       int ver, i, j, r;
> >>          u32 ring_idx, off;
> >>
> >>          iter.data =3D buffer;
> >> @@ -323,6 +331,80 @@ amdgpu_devcoredump_format(char *buffer, size_t co=
unt, struct amdgpu_coredump_inf
> >>          else if (coredump->reset_vram_lost)
> >>                  drm_printf(&p, "VRAM is lost due to GPU reset!\n");
> >>
> >> +       if (coredump->num_ibs) {
> >> +               if (buffer)
> >> +                       vm =3D amdgpu_vm_lock_by_pasid(adev, &root, co=
redump->pasid);
> >> +               else
> >> +                       vm =3D NULL;
> >
> > Is there any point in doing the loop if the vm is NULL?
>
> Yes : when doing the first pass to size the final buffer I skip the
> buffers mapping + read operations that might be slow and instead just
> account for the outputting of ib_size_dw dwords.

But if you don't map the buffer, you'll just be dumping the random
content from ib_content[].

>
> >
> >> +
> >> +               for (int i =3D 0; i < coredump->num_ibs && (!buffer ||=
 vm); i++) {
> >> +                       ib_content =3D kvmalloc_array(coredump->ibs[i]=
.ib_size_dw, 4,
> >> +                                                   GFP_KERNEL);
> >
> > Shouldn't this be GFP_NOWAIT?
>
> This is executed by a worker so GFP_KERNEL should be ok?

Oh, right.  Yeah, should be ok.

Alex

>
> Pierre-Eric
>
> >
> > Alex
> >
> >> +                       if (!ib_content)
> >> +                               continue;
> >> +
> >> +                       if (!vm)
> >> +                               goto output_ib_content;
> >> +
> >> +                       va_start =3D coredump->ibs[i].gpu_addr & AMDGP=
U_GMC_HOLE_MASK;
> >> +                       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, va=
_start / AMDGPU_GPU_PAGE_SIZE);
> >> +                       if (!mapping)
> >> +                               goto free_ib_content;
> >> +
> >> +                       offset =3D va_start - (mapping->start * AMDGPU=
_GPU_PAGE_SIZE);
> >> +                       abo =3D amdgpu_bo_ref(mapping->bo_va->base.bo)=
;
> >> +                       r =3D amdgpu_bo_reserve(abo, false);
> >> +                       if (r)
> >> +                               goto free_ib_content;
> >> +
> >> +                       if (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCE=
SS) {
> >> +                               off =3D 0;
> >> +
> >> +                               if (abo->tbo.resource->mem_type !=3D T=
TM_PL_VRAM)
> >> +                                       goto unreserve_abo;
> >> +
> >> +                               amdgpu_res_first(abo->tbo.resource, of=
fset,
> >> +                                                coredump->ibs[i].ib_s=
ize_dw * 4,
> >> +                                                &cursor);
> >> +                               while (cursor.remaining) {
> >> +                                       amdgpu_device_mm_access(adev, =
cursor.start / 4,
> >> +                                                               &ib_co=
ntent[off], cursor.size / 4,
> >> +                                                               false)=
;
> >> +                                       off +=3D cursor.size;
> >> +                                       amdgpu_res_next(&cursor, curso=
r.size);
> >> +                               }
> >> +                       } else {
> >> +                               r =3D ttm_bo_kmap(&abo->tbo, 0,
> >> +                                               PFN_UP(abo->tbo.base.s=
ize),
> >> +                                               &abo->kmap);
> >> +                               if (r)
> >> +                                       goto unreserve_abo;
> >> +
> >> +                               kptr =3D amdgpu_bo_kptr(abo);
> >> +                               kptr +=3D offset;
> >> +                               memcpy(ib_content, kptr,
> >> +                                      coredump->ibs[i].ib_size_dw * 4=
);
> >> +
> >> +                               amdgpu_bo_kunmap(abo);
> >> +                       }
> >> +
> >> +output_ib_content:
> >> +                       drm_printf(&p, "\nIB #%d 0x%llx %d dw\n",
> >> +                                  i, coredump->ibs[i].gpu_addr, cored=
ump->ibs[i].ib_size_dw);
> >> +                       for (int j =3D 0; j < coredump->ibs[i].ib_size=
_dw; j++)
> >> +                               drm_printf(&p, "0x%08x\n", ib_content[=
j]);
> >> +unreserve_abo:
> >> +                       if (vm)
> >> +                               amdgpu_bo_unreserve(abo);
> >> +free_ib_content:
> >> +                       kfree(ib_content);
> >> +               }
> >> +               if (vm) {
> >> +                       amdgpu_bo_unreserve(root);
> >> +                       amdgpu_bo_unref(&root);
> >> +               }
> >> +       }
> >> +
> >>          return count - iter.remain;
> >>   }
> >>
> >> --
> >> 2.43.0
> >>
