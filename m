Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CC3CD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E900D10F5D4;
	Fri, 19 Jun 2026 13:37:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RWz9OiUe";
	dkim-atps=neutral
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com
 [209.85.222.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 565BD10F5D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:37:02 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id
 a1e0cc1a2514c-963e45a7426so48105241.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 06:37:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781876221; cv=none;
 d=google.com; s=arc-20240605;
 b=hZ3DsA7EatARJ2D/qzkhQ7490tTw4Cq2Hii21s8E+6jR30khJs+lqCIteK+adxNKUf
 RpjfSxSBYtzWN/ySEBjDdbeF1MN+02LtBufSaWaiNL0N1s2ThwHKLDZJDS49NnGUVHkr
 CFg5O8cY0CNcP+YaQq0LUVpWIbSaQEJmTUrsT7RxCsWaNGJtMiPTYm/oSINv8PSSd7q+
 rxjYAWECyhmPTgE7prRmZfBqIDs3bxWDaBfo/umtwQsnktcRF80ZvvJBKSlRnOw6OFMO
 dBFuYELdNdU61oG/SAhlvGNidRXi+SbSmu4e62R1027NE64WnD+BsHz8X2gM9KQVlX+H
 19Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WFd+JExtpscOcekqSR/fVMmirAIv+XD3AaKIEkpeqFo=;
 fh=QwLKCiv4DmXaZZ0RIKVKTBkfr/k9h8y9e82+eV4moMQ=;
 b=i813LqY9HxjJUFb8h30qFKzQv/HXnU8MYNTgLHWO6WQfFSHH7wX98lgn9N+rraMgsT
 0fc0qTWaIB3yDnqFNxxxqL+mkyAYcKXqQw+jYu50bme34rncTTwGu0skKUQLk/eG78ko
 DNE4xCLzBluOLaI/WoGPdm8oJjK39ZlTvvrhfte5MHa5NGsodRU2/vqPfwdQBs3BEUpN
 qlck7tZ/3EZg8rZC8YiKP9SQJXacOQHZ8vUQ5lyXBXQUQoS5BeMM0glOZITcaIJjvGys
 2XJh6PbbIuEc8lqpodJGE/ww/+1k0hClOoAaA9C7wEGybpiXCPH+XEo9Me60BHrII7R7
 MA+g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781876221; x=1782481021; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WFd+JExtpscOcekqSR/fVMmirAIv+XD3AaKIEkpeqFo=;
 b=RWz9OiUecHYdiGf3c3R2dvjDj54Svi0chsvWrhS1hOQ6XtVh4ZOfbwxchX64ziPuxa
 q6QDyDBEOX7Bzy1HeD57Aze/SsoKV3a9039m4/+LBjAbBdGS+OyhRzU7hBRTV+1f7hLi
 bV4i8l3i6yjZC0t6p+tc4HvUZFMgq95znTW8XxqEHmPd0doGl3IbmUmehBwRz3CU6Egy
 tajc6FK3lFg6FHTdGBiDNO6wfwxBSAF4Hdf0+6SaN0iT/1+Juar7dxaKs1VxzYWpdd+L
 UGIxoYOXH3Nd6dEphxLhsQCzLZarU1+e6Xw+2nZYrKLz0lZO588CV8ZT2DRigHLciztW
 oFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781876221; x=1782481021;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WFd+JExtpscOcekqSR/fVMmirAIv+XD3AaKIEkpeqFo=;
 b=K3j+L2AZUtfFjbMverhcx512U0FP6jHghN9D+1iZaE6lOZU7dNz2evT7FANRS9eQir
 248Ckmo322CL0VPo0AnCLbtSc6F++7lDiwShuCs1bZ5kv7AcqMnmOmZcbaWU4yvPh67E
 +/DFqpDZDv7SaTKseIYMwQ0rFZBKpj1tS3CLzZkl9KFJpGVqlz8Kbh+HjWvxVcrKRjtK
 SF53ofl4ykpTjpw/R0PCLcN5DxlurmAzhOi42Gxbuhj5Jid0eb5fFdkZ6RCDGowfv8mF
 SRSm3uqAHCrVHXIMAlVIjcMKYPWq7ZLTJ2/yIUz1MMc+XRCGnlgiPta9WMk3vl02cjwJ
 JH+g==
X-Gm-Message-State: AOJu0YwjIFDKucq3mQY27Gsq9UiRJxEQYY+Z4Th58F8VkLcKtvQ+mQYQ
 6ZSzI39qiCdE25jRjq5b70jdlJ1/cplDJb9i/IeB3tgCMP81impRxiliKnyr+BTL8OucGDNrvNJ
 FO1n6PobNUEjXH7eI+E3r3hMlhDEb+A3CSA==
X-Gm-Gg: AfdE7clUVSHEJj0NL+++qVdw7xAt2v2n3RD+/t/Bu32BsWrAbj5tisXNkXsKHeAbvGA
 aVfPIrwFSbwLgJkrzcsldMREj0ogxVtAVlE6tXBtudxitRmT8eUx5L9/9Ib5SwQQXOJdpuoqi50
 EgdaCUCQb2gx6RtFGaXUvsjvuuSnczvKny83fkY53vBNnY2CncCOnmCe8nb3QAIS8WXquQncSxw
 mnKi43spq0NUnDGP1+9t+b/NT+DHWlv1wBWh/hMkwtGs9vI73WrUFHI34fIdk8Vaw3c15h2Ubeq
 ypZh3bp8Vo8O2T0T3jDATP7JmrdNlDWYR8sbRTL05yK/x3l8PgGWhjppfZQ=
X-Received: by 2002:a05:6102:3e2a:b0:633:3bf6:977c with SMTP id
 ada2fe7eead31-72b1402325fmr189301137.1.1781876221215; Fri, 19 Jun 2026
 06:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260617093518.753118-1-lijo.lazar@amd.com>
 <a123025c-c748-4f8d-8ddb-e19ceafc1e27@amd.com>
In-Reply-To: <a123025c-c748-4f8d-8ddb-e19ceafc1e27@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Jun 2026 09:36:48 -0400
X-Gm-Features: AVVi8CeKgpyzsfOYKbj9GKOwIVTpu16uDeDaz6IHFV4WvoKZIamqzIOoLwHVUxY
Message-ID: <CADnq5_MUC=0hdVSNOArAB7N5X8ETFKRymqvLA-dLaCX1bXLXbA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Guard reads in pcie state readout
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com, candice.li@amd.com
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

On Fri, Jun 19, 2026 at 9:20=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
> <ping>
>
> On 17-Jun-26 3:05 PM, Lijo Lazar wrote:
> > Internal US/DS switch may not be exposed in passthrough. Guard the
> > upstream port reads to avoid a NULL dereference.
> >
> > Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> > ---
> >   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 59 +++++++++++++++------=
-
> >   1 file changed, 42 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/d=
rm/amd/amdgpu/aqua_vanjaram.c
> > index 72ea37dbfea8..5f1389901504 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> > @@ -589,6 +589,29 @@ static struct aqua_reg_list pcie_reg_addrs[] =3D {
> >       { smreg_0x1A380088, 6, DW_ADDR_INCR },
> >   };
> >
> > +/*
> > + * Return the GPU's internal US switch port, or NULL if it is not visi=
ble
> > + * (e.g. passthrough) or the EP is parented under an unrelated bridge.
> > + */
> > +static struct pci_dev *aqua_vanjaram_get_us_pdev(struct amdgpu_device =
*adev)
> > +{
> > +     struct pci_dev *ds_pdev, *us_pdev;
> > +
> > +     ds_pdev =3D pci_upstream_bridge(adev->pdev);
> > +     if (!ds_pdev || ds_pdev->vendor !=3D PCI_VENDOR_ID_ATI ||
> > +         pci_pcie_type(ds_pdev) !=3D PCI_EXP_TYPE_DOWNSTREAM)
> > +             return NULL;
> > +
> > +     us_pdev =3D pci_upstream_bridge(ds_pdev);
> > +     if (!us_pdev ||
> > +         (us_pdev->vendor !=3D PCI_VENDOR_ID_ATI &&
> > +          us_pdev->vendor !=3D PCI_VENDOR_ID_AMD) ||
> > +         pci_pcie_type(us_pdev) !=3D PCI_EXP_TYPE_UPSTREAM)
> > +             return NULL;
> > +
> > +     return us_pdev;
> > +}
> > +
> >   static ssize_t aqua_vanjaram_read_pcie_state(struct amdgpu_device *ad=
ev,
> >                                            void *buf, size_t max_size)
> >   {
> > @@ -596,7 +619,7 @@ static ssize_t aqua_vanjaram_read_pcie_state(struct=
 amdgpu_device *adev,
> >       uint32_t start_addr, incrx, num_regs, szbuf;
> >       struct amdgpu_regs_pcie_v1_0 *pcie_regs;
> >       struct amdgpu_smn_reg_data *reg_data;
> > -     struct pci_dev *us_pdev, *ds_pdev;
> > +     struct pci_dev *us_pdev;
> >       int aer_cap, r, n;
> >
> >       if (!buf || !max_size)
> > @@ -628,25 +651,27 @@ static ssize_t aqua_vanjaram_read_pcie_state(stru=
ct amdgpu_device *adev,
> >               }
> >       }
> >
> > -     ds_pdev =3D pci_upstream_bridge(adev->pdev);
> > -     us_pdev =3D pci_upstream_bridge(ds_pdev);
> > +     us_pdev =3D aqua_vanjaram_get_us_pdev(adev);
> > +     if (us_pdev) {
> > +             pcie_capability_read_word(us_pdev, PCI_EXP_DEVSTA,
> > +                                       &pcie_regs->device_status);
> > +             pcie_capability_read_word(us_pdev, PCI_EXP_LNKSTA,
> > +                                       &pcie_regs->link_status);
> > +
> > +             aer_cap =3D pci_find_ext_capability(us_pdev, PCI_EXT_CAP_=
ID_ERR);
> > +             if (aer_cap) {
> > +                     pci_read_config_dword(us_pdev,
> > +                                           aer_cap + PCI_ERR_COR_STATU=
S,
> > +                                           &pcie_regs->pcie_corr_err_s=
tatus);
> > +                     pci_read_config_dword(us_pdev,
> > +                                           aer_cap + PCI_ERR_UNCOR_STA=
TUS,
> > +                                           &pcie_regs->pcie_uncorr_err=
_status);
> > +             }
> >
> > -     pcie_capability_read_word(us_pdev, PCI_EXP_DEVSTA,
> > -                               &pcie_regs->device_status);
> > -     pcie_capability_read_word(us_pdev, PCI_EXP_LNKSTA,
> > -                               &pcie_regs->link_status);
> > -
> > -     aer_cap =3D pci_find_ext_capability(us_pdev, PCI_EXT_CAP_ID_ERR);
> > -     if (aer_cap) {
> > -             pci_read_config_dword(us_pdev, aer_cap + PCI_ERR_COR_STAT=
US,
> > -                                   &pcie_regs->pcie_corr_err_status);
> > -             pci_read_config_dword(us_pdev, aer_cap + PCI_ERR_UNCOR_ST=
ATUS,
> > -                                   &pcie_regs->pcie_uncorr_err_status)=
;
> > +             pci_read_config_dword(us_pdev, PCI_PRIMARY_BUS,
> > +                                   &pcie_regs->sub_bus_number_latency)=
;
> >       }
> >
> > -     pci_read_config_dword(us_pdev, PCI_PRIMARY_BUS,
> > -                           &pcie_regs->sub_bus_number_latency);
> > -
> >       pcie_reg_state->common_header.structure_size =3D szbuf;
> >       pcie_reg_state->common_header.format_revision =3D 1;
> >       pcie_reg_state->common_header.content_revision =3D 0;
>
