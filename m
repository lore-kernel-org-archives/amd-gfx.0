Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EB0606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G0e1c4gr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 383E411243C;
	Thu, 29 Oct 2026 16:05:41 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7946A11243D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 16:05:34 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2e853a56bb4so2002805ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 09:05:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793289934; cv=none;
 d=google.com; s=arc-20260327;
 b=kyv2l0dSOYFbVtX7x55hrAtBYnUg2fQhNb4cjKDMqEDg9JRZXaeO/ougvmlH3aERks
 oSz/iR8GObW4SH11ISe+CcueAosB6wc6RTeFO83uDMTaxbWCgDSbxt3uYQkn3kHYz9d/
 zFY+yo/AmtyX1lxhlhheeErRWZDFCd0Gr6TxOG7eagUsmptg2jldGLB7ZpzTJkWR2c6x
 61JwhiNVH898XRcZrYP044YCsKTi/I7TBiQLiLuyj+TItp+bE+AGTlGslW7T6wUfompt
 tNUp0SEUdedG7oj05pn2NmRvSOYsQ/DMjDsfzDLdv2YGhZ4XWS0pXIrlEJ5xr4q1Li5X
 o2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0JXYX5EZ25gVw84vUFaQsahBWpllYocPrdhCQ3cIQzo=;
 fh=q8iQkQGpaGlx7lAJ2YOrEE5eWz0gJEL49KptoTDvkd0=;
 b=nX3j5Dm1RMgF3ojQfCUpDSal8RzudK8S0Y7czwVB0pNekaBF9RI/UXjMx9+giBzPAK
 GEOMr2ojbAuh/NRup+gKuAkWLtMmaU0/YWPb7jWofhptrB6Dfc6PRBikdDVV46An+pki
 kaCQhqGpImIFWFygFiTwldIbLuSvsSSAg99/bfSxMO//REQ9QpCryr2CH81xhR6vfXUU
 1QfbZ/A/qeSfXHaiA6nlitEkRZfsWu1+FFjDXJc1rZ4oE4CfRKXmE77z7C2UgMkRjfKi
 XVe3Js4j8FimdG/bdwWofB2xb2EnDgTAzWeocBjz76tJpxD7tvyBXXgFioQ2+TOZ+rQj
 42Jw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793289934; x=1793894734; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0JXYX5EZ25gVw84vUFaQsahBWpllYocPrdhCQ3cIQzo=;
 b=G0e1c4gr+qg7y/CFBNBOVoe6BnSBmgRedXcfhZk2L7mHC2wUkvHpCTDxJUJpy5MRSL
 78NYrAIP+R6iNhfPV0OPUSMaefXpcTxOp3Pb/T1mukWuxN7giuNhv4TkUuZWcMzFQKIJ
 AVMYzcJddamObjxkPfz48ql3UiNXAs/NARaWJd/n4a0XbDTtnVCOd6fRhowes+PwRhIY
 Ym97ETuWvg/qJmTmG7j99EUCiO5a7TxuB/i3rUNJyrTGrnKABxluCrFY3x2mvTL/4WwU
 Q1wgcRxmfn9Yl5NpeoG2YTt8OObluyhvDoTEvDAtXkxE+OPiYav8RIjfZ/NQcfWKj5v7
 B6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793289934; x=1793894734;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0JXYX5EZ25gVw84vUFaQsahBWpllYocPrdhCQ3cIQzo=;
 b=fiTb9GhQRNbNB1jfQzLi+hVbIahCDRBaf2H8Z+/9mIf45r0vKwf+Y14mtlqSi+6inY
 qxldSy5StX2TrSfnmb5tSMZXvhNPii5aDPX0x9E7VNxFcqK7zY0YUfMtDRsAUQuYxnXf
 lmijHvFUyrahdswcCkFNmiMoVaFMelJHXFSp3y3Lqa1/t8EycbrEX6zVOqFpCcu1QIlT
 ulASGlvvTS8W1hpMzaDsyc722rDUzgfBkigx2/tCQAZHrXA+K6toGV+ZXaNpZzyNx4zT
 +m63ma/CWiLf06Onla+oVmgmi3nsb+bo4+T5iFshj7O0CfDQ2B245EGoqRlaBuYwcC5J
 7n+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFgeR//GrzfoMZWlwpu5aWPhNDmSz9cBi9Ifwhk+duA8CoAFSRr6QsHoKDFTZ15vS0v7weu6ld@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIoxAQeXI8vK0ByqKybxsbgEFJXaynyGuhNtSyjVNU62tP+X7zT
 FIMd7xAld8XVzHRnVfa5TM0ERQVLs4XoPHfPypJva6HwssTtcrDRU3972KuiCpdHHw/EgVIdGlQ
 x0qkSDdVP+1ue79rYL1S5XiLMheg0Qyc=
X-Gm-Gg: AYBFou34RZA4hM/Nd+eRVvbDx4qXjLlC5iyX3Z/g2SUPHzB7+zRYCZ2fP+honKvRNGk
 Ir7laOeq3F5czVwtLAzRMEuDTs3wM6f87trCizwUr8t4E9Qa2T5i1hapMV21nH5vSW11MkF+b2w
 lfIdb6cwSXRSEvwcFOuk93YFLbHju738ayg1Ob1iBHOZTbh8vxlKSfNlz6/XfHZVjHGgJOzEpdR
 rrLHsBG1kKF5TRJD2qxClnSZrjNdaoNFN3fubeU0DzsVnv0khraRzJGsr4Q4J/XgAn7G9T3aatg
 82mcRxmbGUXxc0mycYJYrPvu0Nq7dPXDofFVVBoSa8qidHRaYZyVe98dxb7+wHhkrqPuh8sZFBJ
 M9jKxejJDXmQdLKJd+w5DpjgOaC9V3lHEBJ6YaUtTYiaksHJKMki4Ks4IIWV2eK+GI8o713RYzR
 ZIy/PAwuOp987ZiCWUQVM649k=
X-Received: by 2002:a17:903:2f0c:b0:2df:8909:f719 with SMTP id
 d9443c01a7336-2eb004ec779mr101640265ad.3.1793289933884; Thu, 29 Oct 2026
 09:05:33 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029151422.56791-1-mike@fireburn.co.uk>
 <20261029151422.56791-2-mike@fireburn.co.uk>
 <06b18cb4-cd1d-48b8-8944-dd1139ad18ad@kernel.org>
In-Reply-To: <06b18cb4-cd1d-48b8-8944-dd1139ad18ad@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Oct 2026 12:05:21 -0400
X-Gm-Features: AclHuK_SzmCZ77Ax6albOg9ENipNfBXsoIiRBPAplK8_vOS9447MyCGtIC5RQss
Message-ID: <CADnq5_PbewORwc3Wsqw3VQESz3RNAKJy+KdnWHx9J1rKg35-Hw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: runtime resume dGPU on ACPI notify from
 its own node
To: Mario Limonciello <superm1@kernel.org>
Cc: Mike Lothian <mike@fireburn.co.uk>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, christian.koenig@amd.com, 
 dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 11:26=E2=80=AFAM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> On 10/29/26 10:14, Mike Lothian wrote:
> > On BOCO platforms the SBIOS can signal a display hotplug on a powered
> > off dGPU by notifying the dGPU's ACPI node. On the ASUS ROG Strix G513Q=
Y
> > the USB-C DP alt mode lanes are driven by the Navi 22, and the CPM
> > D3cold table handles the HPD GPE with only:
> >
> >    Method (_L05) { Notify (\_SB.PCI0.GPP0.VGA, 0x81) }
> >
> > Nothing in Linux listens on that node: ATIF is bound to the iGPU and th=
e
> > dGPU node is not an ACPI video bus. If the dGPU is in D3cold when a doc=
k
> > is attached it stays off, no hotplug reaches userspace, the external
> > displays stay dark, and the level-triggered GPE keeps firing until the
> > dock is removed.
> >
> > Install an ACPI device notify handler on the dGPU's companion when BOCO
> > is used, and request a runtime resume on 0x81. Runtime resume already
> > re-detects all links and sends a hotplug event, so the new displays are
> > picked up; the device autosuspends again if nothing is enabled.
> >
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 31 +++++++++++++++++++++++=
+
> >   2 files changed, 32 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index 7974f9b7944f..deb63122828d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -641,6 +641,7 @@ struct amdgpu_device {
> >       bool                            need_swiotlb;
> >       bool                            accel_working;
> >       struct notifier_block           acpi_nb;
> > +     bool                            acpi_dgpu_notify;
> >       struct notifier_block           pm_nb;
> >       struct amdgpu_i2c_chan          *i2c_bus[AMDGPU_MAX_I2C_BUS];
> >       struct debugfs_blob_wrapper debugfs_vbios_blob;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_acpi.c
> > index 7f5abb03be1b..a4041f90b374 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > @@ -1280,6 +1280,23 @@ static int amdgpu_acpi_event(struct notifier_blo=
ck *nb,
> >       return amdgpu_atif_handler(adev, entry);
> >   }
> >
> > +/*
> > + * On BOCO platforms the SBIOS signals display hotplug on a powered-of=
f dGPU
>
> Although your system is a BOCO platform; I do think this same thing for
> this signaling to wakeup could apply to a BACO system too.
>

I would doubt it.  In the BOCO case, the OEM has a mux on the HPD pins
and redirects them to the EC when the dGPU is powered off.  For BACO,
in most cases that is just PCIe add in board so there is no way to
redirect the HPD pins.

@Mike Lothian does your system have ATIF?  This is already code to
handle this.  It sounds like it's just registering the wrong ACPI
node.  You should be able to use the existing handler.

Alex

> > + * (e.g. USB-C DP alt mode HPD wired to the dGPU) with Notify(<dGPU>, =
0x81)
> > + * on the dGPU's own ACPI node. Nothing else listens there, so wake th=
e
> > + * device; runtime resume re-detects all links and sends a hotplug eve=
nt.
> > + */
> > +static void amdgpu_acpi_dgpu_notify(acpi_handle handle, u32 event, voi=
d *data)
> > +{
> > +     struct amdgpu_device *adev =3D data;
> > +
> > +     if (event !=3D ACPI_VIDEO_NOTIFY_PROBE)
> > +             return;
> > +
> > +     dev_dbg(adev->dev, "ACPI notify 0x%x, requesting runtime resume\n=
", event);
> > +     pm_request_resume(adev->dev);
> > +}
> > +
> >   /* Call all ACPI methods here */
> >   /**
> >    * amdgpu_acpi_init - init driver acpi support
> > @@ -1325,6 +1342,14 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
> >       adev->acpi_nb.notifier_call =3D amdgpu_acpi_event;
> >       register_acpi_notifier(&adev->acpi_nb);
> >
> > +     if (!(adev->flags & AMD_IS_APU) && ACPI_COMPANION(adev->dev) &&
> > +         adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO)
>
> I'd install the notifier for BACO as well.
> > +             adev->acpi_dgpu_notify =3D
> > +                     !acpi_dev_install_notify_handler(ACPI_COMPANION(a=
dev->dev),
> > +                                                      ACPI_DEVICE_NOTI=
FY,
> > +                                                      amdgpu_acpi_dgpu=
_notify,
> > +                                                      adev);
> > +
> >       return 0;
> >   }
> >
> > @@ -1344,6 +1369,12 @@ void amdgpu_acpi_get_backlight_caps(struct amdgp=
u_dm_backlight_caps *caps)
> >    */
> >   void amdgpu_acpi_fini(struct amdgpu_device *adev)
> >   {
> > +     if (adev->acpi_dgpu_notify) {
> > +             acpi_dev_remove_notify_handler(ACPI_COMPANION(adev->dev),
> > +                                            ACPI_DEVICE_NOTIFY,
> > +                                            amdgpu_acpi_dgpu_notify);
> > +             adev->acpi_dgpu_notify =3D false;
> > +     }
> >       unregister_acpi_notifier(&adev->acpi_nb);
> >   }
> >
>
