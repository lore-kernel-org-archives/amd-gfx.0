Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B2ECD98CE
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 20:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E316910E716;
	Mon, 15 Jun 2026 20:56:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BwIha1n1";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42FE210E716
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 20:56:26 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-304eb0fc233so315027eec.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 13:56:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781556985; cv=none;
 d=google.com; s=arc-20240605;
 b=Ez1De7WmCW4s/qSwchF+TPCxwUxN8v+j+uUuChY6vmWYAzxzukP/tZzTFKVobRzdT0
 kZ5+eIoRD2WcMbqfREciEGTqFu3ewr00RTBNL+TD+DLubSeCS6vsHX04wo6bsyKycY7P
 OnUpdSYkdwQMpQhAKryiMWqyyjXhHvQYY/ARnTnWXohkPXHQKBQgaVxuJcQUrOejz0z/
 4zp/q6riKOpXFOVaquAjxF70QS1DLe9ZSBlrzlnczltxTND1Ci47bY4Ca4KYx2iOoLr7
 pRcdHxeF27rqagsOLLYk6aXyifDLkXSC2x8/FPhMyIzBNgBG+e1TGj5OCyvSa0AXdN9X
 lXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/hH57+opvniL1oBUGkoPL2gpqMC7lrSUNLhDyAWrHA0=;
 fh=PIlHwVLSgMnDtI9xCVYAylYxVFUdVdwY0VeMv3Nzy1M=;
 b=STrjoNYbLiZTZNbw8gb97+Akt6DTTJyWfaTZT8VZzSJyRVHk8tlVrGzydETLWG3F2U
 bqhHVuvkzsE3BkiuDBrA91Hr2FF5cu1c7NswXqqyMpiWh/wPJpd5NKEvsGvO/lJS/00t
 eb9vJkPJPtPxLZ/gWSJ8jMK3TBS6bJBmkNVXRQtag7Ks+4cud2Ii/xHKb/njlqfFrhvv
 iumYO70shDQZIbmaS27NtHNA3OynPYAEtLaW53UiTPucSGkwB91nKs4XE3akhgkXWgJ6
 3CVG1o1v9bu+OOnEDo5N6PIHXt4p4aoFx+HtvOvGabSjiM/3rHsXvOLdy2z1TGFQRv5Z
 SMdQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781556985; x=1782161785; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/hH57+opvniL1oBUGkoPL2gpqMC7lrSUNLhDyAWrHA0=;
 b=BwIha1n1o/Rsmxn2dc6eGUwE/F+sDQmypnfaa6+MFbA5eipLzvs6urG8jbpGK5Hpo5
 op80Djp1FnBy1ZcKcM8Oqu1eQ4r4Gw/59d32n+NerF5Vj3bm5mGrS9bcFewmhpU81ZcM
 wB8R7e9uu/QuekVCyQgCfqC7NcqZNVh8Sl6N4QJbYPuGgh9HJ5YZmOlFUrqz2c0MJhpx
 rqSCKketkHq5iuSOaHhCXroouv0brSrf9HkKNb0FC/GYVkebx4/81a2QzikIEFq8Ypc1
 Y6SlxRqiSmzSLL+0yyrkQnFFa1eFsSf+WCjFh2NrK8WHoOLCvYs45N9TmDnpN0cqIM4d
 7jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781556985; x=1782161785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/hH57+opvniL1oBUGkoPL2gpqMC7lrSUNLhDyAWrHA0=;
 b=Py+UHFQmfEtdkJNDOBW3nV5bN7zlBO3jQtUc9XFGOhJipPf4s0Ytspnd/sINibPbOW
 Ws57sLZwwZLZlbadJhgBbcpxLITCHpp3huM6zWtARD5rEWY+NL6qPQ6tZPCIGgr3hJth
 6okKmOcyDtQjXV/EWmNnvlauoqAt6nbVMPBzB4uDhtPZR6tgSuPj7xENyW+eUfo1rA9Y
 6i+q7FBrr8DUnMB5rB5uS5ET6LX3kldsI2ycINEFgUjmuhJU9FS1c9rXo0KKR3aHwY2b
 VNvKsOvZUu80xWOwz9vfc7IxnSkNKg5FAjcRNxBeO5cit4FMpZfzHshMnbeCxbsdQCgq
 kSwg==
X-Gm-Message-State: AOJu0YwPNo8FTS1VH2u1aLETAFVaQ6UWt8smUfDW67WT1j8+HrKjjoXI
 DS/SotLeEsWD15/XmF485Xu3jwIU4z0xtfrI0eblN88eazX/4ScZRlFNYf6DqI0DtILMqisBOWD
 gxc0YYdGWxHoQHWge0GWr82wBngjBBvGDdA==
X-Gm-Gg: Acq92OF/GTcAD4rTL3UErHD9n87BlclGT1HGyP+3RbvrWk+PZL3F2RxieVibRAPJn+y
 zoTif1FL7u6LNW7jAqQe0Q5g0FW3ZDiQbED4/JLfWc106+1md0wfYsJsmd99A1s+Ynz1N2YrDwS
 9JIAPyf8HVMD+o/VE4RWFUPRvXxSAIk6OC8tIMaImxy9C62NV2tth2I/mB0lMvLq7neTd1pYbra
 8p/P0JEPF+LMPjjAdG5ClDdAj/9s/lltqOIIa7Q04oniYhLDKhhPrW2wKw3Ieq8hyQIkITSQ4CY
 lL/43SPRZeoA6ZiUMTsHWPsA20ZUmuXDgLz/K/u0vHbBy7Z6TmdHmvNT3e2fMlRijyxgCg==
X-Received: by 2002:a05:7022:fd07:b0:137:f2f4:ff76 with SMTP id
 a92af1059eb24-1384bb850a6mr3330666c88.3.1781556985264; Mon, 15 Jun 2026
 13:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260528184656.123149-1-xiaogang.chen@amd.com>
 <bd4aaf16-e2e6-475c-af8e-a696c1bb67a5@amd.com>
In-Reply-To: <bd4aaf16-e2e6-475c-af8e-a696c1bb67a5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 16:56:13 -0400
X-Gm-Features: AVVi8CdscD-g26cpEv77fq0clD3yHpYLGVgqUtzppjcBr347NFiFb-GXYWubdDA
Message-ID: <CADnq5_O4UPa2XWhSX+JdJRr9_kmpiv65veNEkB9R1XGBD3sjOQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdkfd: Let driver decide buffer size at
 AMDKFD_IOC_GET_DMABUF_INFO ioctl
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Jun 11, 2026 at 6:57=E2=80=AFPM Chen, Xiaogang <xiaogang.chen@amd.c=
om> wrote:
>
>
> ping
>
> On 5/28/2026 1:46 PM, Xiaogang.Chen wrote:
> > From: Xiaogang Chen <xiaogang.chen@amd.com>
> >
> > amdkfd driver needs allocate buffer to return bo metadata to user space=
. The
> > buffer size is controlled by user currently. It is a potential security=
 issue
> > that hostile value (e.g. 2 GiB) lets any render-group user trigger orde=
r-MAX
> > allocation / OOM in kernel context.
> >
> > This patch first finds bo metadata size. If the size is smaller than us=
er
> > provided value drive can safely allocate buffer in kernel space and cop=
y to
> > user space buffer. If not, driver will let user know, not allocate and =
copy.
> > User will redo with new buffer in user space.
> >
> > This patch lets driver decide buffer allocation size to avoid potential=
 hostile
> > size from user space.
> >
> > Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 23 ++++++++++++++++++---=
-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 +-
> >   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 10 ++--------
> >   3 files changed, 22 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_amdkfd.c
> > index 7b10bbe28caf..1b4d1a974143 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > @@ -533,7 +533,7 @@ uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(=
struct amdgpu_device *adev)
> >
> >   int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma=
_buf_fd,
> >                                 struct amdgpu_device **dmabuf_adev,
> > -                               uint64_t *bo_size, void *metadata_buffe=
r,
> > +                               uint64_t *bo_size, void **metadata_buff=
er,
> >                                 size_t buffer_size, uint32_t *metadata_=
size,
> >                                 uint32_t *flags, int8_t *xcp_id)
> >   {
> > @@ -568,9 +568,24 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_de=
vice *adev, int dma_buf_fd,
> >               *dmabuf_adev =3D adev;
> >       if (bo_size)
> >               *bo_size =3D amdgpu_bo_size(bo);
> > -     if (metadata_buffer)
> > -             r =3D amdgpu_bo_get_metadata(bo, metadata_buffer, buffer_=
size,
> > -                                        metadata_size, &metadata_flags=
);
> > +     if (metadata_buffer) {
> > +             /* first get metadata_size by buffer =3D NULL */
> > +             r =3D amdgpu_bo_get_metadata(bo, NULL, 0,
> > +                                        metadata_size, NULL);
> > +
> > +             /* user buf_size is bigger than bo metadata_size
> > +              * allocate a buf at kernel space and copy */
> > +             if (*metadata_size <=3D buffer_size) {
> > +                     *metadata_buffer =3D kzalloc(*metadata_size, GFP_=
KERNEL);
> > +
> > +                     if (!*metadata_buffer)
> > +                             return -ENOMEM;
> > +
> > +                     r =3D amdgpu_bo_get_metadata(bo, *metadata_buffer=
, *metadata_size,
> > +                                                NULL, &metadata_flags)=
;
> > +             } else
> > +                     r =3D -EINVAL;
> > +     }
> >       if (flags) {
> >               *flags =3D (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRA=
M) ?
> >                               KFD_IOC_ALLOC_MEM_FLAGS_VRAM
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_amdkfd.h
> > index 2bf6a31c194d..7b67367a9a53 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > @@ -262,7 +262,7 @@ uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct=
 amdgpu_device *adev);
> >   uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct amdgpu_devi=
ce *adev);
> >   int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma=
_buf_fd,
> >                                 struct amdgpu_device **dmabuf_adev,
> > -                               uint64_t *bo_size, void *metadata_buffe=
r,
> > +                               uint64_t *bo_size, void **metadata_buff=
er,
> >                                 size_t buffer_size, uint32_t *metadata_=
size,
> >                                 uint32_t *flags, int8_t *xcp_id);
> >   int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *ade=
v, bool is_min);
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_chardev.c
> > index 881ea252b3ad..fc75d0009a57 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > @@ -1545,16 +1545,10 @@ static int kfd_ioctl_get_dmabuf_info(struct fil=
e *filep,
> >       if (!dev)
> >               return -EINVAL;
> >
> > -     if (args->metadata_ptr) {
> > -             metadata_buffer =3D kzalloc(args->metadata_size, GFP_KERN=
EL);
> > -             if (!metadata_buffer)
> > -                     return -ENOMEM;
> > -     }
> > -
> >       /* Get dmabuf info from KGD */
> >       r =3D amdgpu_amdkfd_get_dmabuf_info(dev->adev, args->dmabuf_fd,
> >                                         &dmabuf_adev, &args->size,
> > -                                       metadata_buffer, args->metadata=
_size,
> > +                                       &metadata_buffer, args->metadat=
a_size,
> >                                         &args->metadata_size, &flags, &=
xcp_id);
> >       if (r)
> >               goto exit;
> > @@ -1566,7 +1560,7 @@ static int kfd_ioctl_get_dmabuf_info(struct file =
*filep,
> >       args->flags =3D flags;
> >
> >       /* Copy metadata buffer to user mode */
> > -     if (metadata_buffer) {
> > +     if (metadata_buffer && args->metadata_ptr) {
> >               r =3D copy_to_user((void __user *)args->metadata_ptr,
> >                                metadata_buffer, args->metadata_size);
> >               if (r !=3D 0)
