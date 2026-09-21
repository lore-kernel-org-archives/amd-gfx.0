Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7456C982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 604AF10E0EE;
	Mon, 21 Sep 2026 20:45:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TzW+yMFc";
	dkim-atps=neutral
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6704110E0EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:45:25 +0000 (UTC)
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-39e4a0daf4eso488449a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 13:45:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790023525; cv=none;
 d=google.com; s=arc-20260327;
 b=ObrLBmOGJVTGav9H/jq4qnNEcgrhwnkZZ1mmOI4nwEt95yWjWbViXtlicoPj7SJ7t7
 PcpcOV4Hq/MnPPAHsQSaEFniX/l9st+caDbrWfE4V0Ij+vFlpASzsSOTI4oiqvk3ztW/
 jn437768B/Tk7NV3oAxZ3sqLVAakfVhcu/3njaleH1CIwALjw8jGpuuFRqdYz65tAHSj
 l1SiZR4CQhwF5/JbHerRRuCSe9GxIfoxNcPVyE4cKKyU9/ivm17C+W9hFNfCaUaMYst8
 7n0wuLp6gOyKn9Eo/gcBt+SHckHOcR+f0G4wmdRH2dhfA1JXkyAAP7/n3lpUfDoFrqOT
 33UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I4QHtGsXEDIBYrv4oXNiyUMBAfVoweOXlyS/7zXAe24=;
 fh=mS0BshGvVy0+b/w8rFOcxxQ3uu92LJoS3DSUm4V8j98=;
 b=WsSHy1fqBVmGFa2YrWUksD9ILGrNPtIRVs1rLQGMSHWKM73zmwYjdGt0bMMXTUO3fS
 4+610nhoFtJLGM8dgbrF0SfozE1ELH7+j1EcwcPklYodmHQ5b36gb2oJEMrVEbkdUGtR
 QfFDFtOJQ6Fo+0C9LnsScl0x5gvHrHEcR1fMjJmGBdEzgJhl3Clajirdcq3M84OtuALt
 AnfBazXW9QppsibE9YPbFQEUnAKxxRuif1XgiIyMjnM1vlCaOiW3psmeFRxvG4IjIyS6
 HSu7ib0E4jK3PUNHd5w/SlFJ6FGf/Bkd/nX1nqXpAMb0EAGEd+Z98UChTvycBERG32+T
 yEYw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790023525; x=1790628325; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I4QHtGsXEDIBYrv4oXNiyUMBAfVoweOXlyS/7zXAe24=;
 b=TzW+yMFcn1Qljlnl2S9+YQ5E4WnmcFHD6yz1CZDXdYmR+YG+nWou2UKjaP5B5dGi0K
 2WT88AghTLnGw69ZUCOkxQDlLZvdhqYrk5yxyhxxIKyB7GaSzxJILWAhqsHhVpUFntUY
 F2XMxiEZ/ZGmPfU01P+VeauSPmdMYvBSctNIErrTDV7ff/VcMC5Kji37tmM2zAhQEmWB
 l5hMblipmePGECEq/Ifuk3wHhBDBWY6UbUbCCc7Azo2ixZ6kvWZdRU0dXKnBRIfsIsub
 pcfCh5u1A1mrgMbemQXQk4pp/mDUCNaUGOvchRkwXVZTSCZsJDRHkQiM4qAUfjBRmPF3
 joqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790023525; x=1790628325;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I4QHtGsXEDIBYrv4oXNiyUMBAfVoweOXlyS/7zXAe24=;
 b=u5qXr4xLtOroQg/CHfjMWhKmaUVcUp0wjrHQRS/qFGELeWPbjbtKsHRoP2Z8jVA9UG
 VDLNalcOHMX11ZjZxqIotEVH/MFxwyde1sZ3LB+WU4Ms/HtHogY2BgymFj0LU4kWMqOW
 7XVL69M6qKbtnUn4yzxzv/uuI+Fu8nC/8WGvQS425p56p7k8uM9cOGqf9LSZaCOg58pW
 NIeaSxggf5iFTFgOyRSdCiJ1sCEqz3D8Nyz7rJBLl1LPnVcmItSHuGhsguyY9PLeu6Vo
 a+VejncM+N7LrOe5pXh/lE6aqWs8Z/aU55HpS5I2W+PyF5t+pJ4MZ6GRGMePHRQNn3WU
 M2VQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLa0zMdYCXxT8AZdY7zKin+lmh6ZRyzcB2uFiaW7bbr1lJ4Yw6aMHD8BnCZp0fDrK0wqsHpP/x@lists.freedesktop.org
X-Gm-Message-State: AFuF++mKv09uF7uGLX/5ok+kwkmlG1hfQrGxmCq3AkkJRuuIdmxfHcpF
 5sMHOYXvCr7UdDoeWJ1WUoa5Ipe0XjGuKNvuwxt8xTRcyxH6mTuKLrnhX6Qcwd9GPf9BEox5I2L
 Nrb5QJp6Eu40prE0fWgLvtdlRak/5Hls=
X-Gm-Gg: AYBFou3YefLzTzaxWRFzNAEfpq4/CRYU5Aniupj1QBICILUm8S8ArEksbagmgT4MWEH
 Q0zKNghBdvbYVpNfiaGzNKQ/CdPMdPcUl+MtPNfyedPdIsyOryXHlwabRFPpZquI6BTGLq/+4CB
 jiwc+msScIJk0eWH3uiQO+hqS4kDsx5NWaeZDJw3f6GhxdFxOA29N+p8y5uZvfHLUGjEANd53ab
 +W1gPdOFJ9oH6h3aVxVMQ2Se3OOkUa5rBQIPS9W5Hd9UXxe5ssdJldJkFAyNb57+ESyWgAzasIA
 wtfxlrxjHkgPS3/v1LBquqE03U2dVqdm5Sl430NZsDAmu+CphcfYVmAPPTozuAmG4P1jpaS3d1f
 dKcgcb17GndLkoWxmpwSXnLLqHjmx3zyxnlhG4p47hQ==
X-Received: by 2002:a17:90b:1a92:b0:39e:55ce:af15 with SMTP id
 98e67ed59e1d1-39e599fb4d1mr22212621a91.5.1790023524732; Mon, 21 Sep 2026
 13:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260916225549.282123-1-timur.kristof@gmail.com>
 <eecffa03-ba11-4952-a208-6d528e94bdf5@ursulin.net>
In-Reply-To: <eecffa03-ba11-4952-a208-6d528e94bdf5@ursulin.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Sep 2026 16:45:13 -0400
X-Gm-Features: AcwNN1UlIoYrBKX3cTtDM-EowGi11BhViZT3m-sXjhsjRguNolWaYOZmJgi9Cro
Message-ID: <CADnq5_PEDAiM3if2kKFokrjbyGAHFWrxbDJSSR8kxnhDvU1TOg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gmc: Use amdgpu_gmc_handle_retry_fault() for
 GMC v12.1
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Natalie Vock <natalie.vock@gmx.de>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>
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

Applied.  Thanks!

On Thu, Sep 17, 2026 at 4:51=E2=80=AFAM Tvrtko Ursulin <tursulin@ursulin.ne=
t> wrote:
>
>
>
> On 16/09/2026 23:55, Timur Krist=C3=B3f wrote:
> > Use the same helper for GMC v12.1 that is used by other
> > GMC IP block versions.
> >
> > No functional changes intended. Just code cleanup.
> >
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 45 ++++---------------------=
-
> >   1 file changed, 7 insertions(+), 38 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v12_1.c
> > index 3349e8bc1c20..cfc46f912d47 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> > @@ -131,7 +131,7 @@ static int gmc_v12_1_process_interrupt(struct amdgp=
u_device *adev,
> >       struct amdgpu_vmhub *hub;
> >       uint32_t cam_index =3D 0;
> >       const char *hub_name;
> > -     int ret, xcc_id =3D 0;
> > +     int xcc_id =3D 0;
> >       uint32_t status =3D 0, status_hi =3D 0;
> >       const char *die_name;
> >       char die_name_buf[32];
> > @@ -164,44 +164,13 @@ static int gmc_v12_1_process_interrupt(struct amd=
gpu_device *adev,
> >       hub =3D &adev->vmhub[vmhub];
> >
> >       if (retry_fault) {
> > -             if (adev->irq.retry_cam_enabled) {
> > -                     /* Delegate it to a different ring if the hardwar=
e hasn't
> > -                      * already done it.
> > -                      */
> > -                     if (entry->ih =3D=3D &adev->irq.ih) {
> > -                             amdgpu_irq_delegate(adev, entry, 8);
> > -                             return 1;
> > -                     }
> > -
> > -                     cam_index =3D entry->src_data[3] & 0x3ff;
> > -
> > -                     ret =3D amdgpu_vm_handle_fault(adev, entry->pasid=
, entry->vmid, node_id,
> > -                                                     addr, entry->time=
stamp, write_fault);
> > -                     WDOORBELL32(adev->irq.retry_cam_doorbell_index, c=
am_index);
> > -                     if (ret)
> > -                             return 1;
> > -             } else {
> > -                     /* Process it onyl if it's the first fault for th=
is address */
> > -                     if (entry->ih !=3D &adev->irq.ih_soft &&
> > -                             amdgpu_gmc_filter_faults(adev, entry->ih,=
 addr, entry->pasid,
> > -                                                      entry->timestamp=
))
> > -                             return 1;
> > -
> > -                     /* Delegate it to a different ring if the hardwar=
e hasn't
> > -                      * already done it.
> > -                      */
> > -                     if (entry->ih =3D=3D &adev->irq.ih) {
> > -                             amdgpu_irq_delegate(adev, entry, 8);
> > -                             return 1;
> > -                     }
> > +             cam_index =3D entry->src_data[3] & 0x3ff;
> >
> > -                     /* Try to handle the recoverable page faults by f=
illing page
> > -                      * tables
> > -                      */
> > -                     if (amdgpu_vm_handle_fault(adev, entry->pasid, en=
try->vmid, node_id,
> > -                                                addr, entry->timestamp=
, write_fault))
> > -                             return 1;
> > -             }
> > +             int ret =3D amdgpu_gmc_handle_retry_fault(adev, entry, ad=
dr, cam_index, node_id,
> > +                                                     write_fault);
> > +             /* Returning 1 here also prevents sending the IV to the K=
FD */
> > +             if (ret =3D=3D 1)
> > +                     return 1;
> >       }
> >
> >       if (kgd2kfd_vmfault_fast_path(adev, entry, retry_fault))
>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Regards,
>
> Tvrtko
