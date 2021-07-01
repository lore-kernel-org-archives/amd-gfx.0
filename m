Return-Path: <SRS0=TGuI=LZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72590C11F66
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 02:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1832261469
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 02:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1832261469
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DB2C6E9A9;
	Thu,  1 Jul 2021 02:58:19 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9353F6E9A9
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jul 2021 02:58:18 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id t3so5651052oic.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 19:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OzJHgERyUOz9BJDA5t3pUyLMipxKKYJMUA/EuMZtk2o=;
 b=Pf+iQibKjz6N+b+Go2j7hxPgnIbcSLOEG8o2czckGsAp6r9B7B1quOzmNbEtuFeyVz
 h1C0OBMwT7H3+yL+EmiiG/2I1Gu1wp3iTg0lYmhdnoaxUzlT3cNFyhha2WPUWuTLgt7z
 hBNUQFlulUDEPiuzzYhHgApt9zv4YVSEjEehI5FiapHNYFbIGa7RskPgLdeDPsSxqlYM
 7FjO1/yXolhZ+uLM+eDX0FLvI8FoGvrdnuSmkqERW+xyN3OK0F+n+0qfUDWStYBmajb3
 WibMOGURTXSowbPDccijCJPJgXyKBE9XJEQUe8mlK5QQ/tLJIg5vZd9V3hgMnhcIRz3y
 6Kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OzJHgERyUOz9BJDA5t3pUyLMipxKKYJMUA/EuMZtk2o=;
 b=QpSo8YP1DXcv4S7OCzDx8H3OjaKX9vGLF+EcogjylIF+qGYIZcfuHepn5lzjL6KV4Y
 73KUjqbk2RXxqEQyMhAuBzC1pbSdwSGYNBVrr74Eek2mBM3SLiAHu4aFGiYOiNRLcFM2
 F8fUezOipcOWAEFTRptdXpaD2dTLip3t9aByWjUV8TkU9Qo3/7tVrJDsXpg4ubN11FKM
 zyfp/uUGvP2Lycqb6F4LmQ6sYCS+qSnShyFIoYJWT/Zvp5dT/LP0/r72ecyY/cQUNVhh
 Q48kf+OJDJcOxV1yiIZgjdh/QEjd5tW8EmKE1O0iPgd0ZBfTa6L27ws6rVUqQRUleKiF
 SiwQ==
X-Gm-Message-State: AOAM5308crbp8OUL5Muleom+HO+GpFzD5x9BopYjgPGNXBvBvTHqmXF5
 Er0trpHO/pIitwbdbTUukZgzEez23Uhqof84wSU=
X-Google-Smtp-Source: ABdhPJzx1U36loKTfLXOdSDvcydIoVui9OmgQn9fjKdEgleD1oM36Wvp9ksi/D9AoSk6ICvvV55yOu49hXpduiwfkSE=
X-Received: by 2002:aca:3446:: with SMTP id b67mr17286990oia.120.1625108297661; 
 Wed, 30 Jun 2021 19:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210625064422.30590-1-PengJu.Zhou@amd.com>
 <CADnq5_NYoJeuvX8GY3qvkZyErXBtuBKhv4LT4TFtmasibG5ioQ@mail.gmail.com>
 <DM8PR12MB5478BB6C80599B4195C551DAF8009@DM8PR12MB5478.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5478BB6C80599B4195C551DAF8009@DM8PR12MB5478.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Jun 2021 22:58:06 -0400
Message-ID: <CADnq5_Pe0P0_3NJxwL2z_Ti4JmjCSy+g=jBOMixvixoj2aN7ww@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Restore msix after FLR
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 30, 2021 at 10:34 PM Zhou, Peng Ju <PengJu.Zhou@amd.com> wrote:
>
> [AMD Official Use Only]
>
> Hi Alex
> The function amdgpu_restore_msix is used for reset the msix during board reset(sriov reset or asic reset), it moves from host to guest, so I think a flag to indicate if msix enabled is not needed.
>

The function ultimately enables MSIX.  What if it was not enabled in
the first place?

Alex

>
> ----------------------------------------------------------------------
> BW
> Pengju Zhou
>
>
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Tuesday, June 29, 2021 10:28 PM
> > To: Zhou, Peng Ju <PengJu.Zhou@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deng, Emily
> > <Emily.Deng@amd.com>
> > Subject: Re: [PATCH v3] drm/amdgpu: Restore msix after FLR
> >
> > On Fri, Jun 25, 2021 at 2:44 AM Peng Ju Zhou <PengJu.Zhou@amd.com> wrote:
> > >
> > > From: "Emily.Deng" <Emily.Deng@amd.com>
> > >
> > > After FLR, the msix will be cleared, so need to re-enable it.
> >
> > Do we need to store whether we enabled msix in the first place and then
> > decide whether to enable it again in this case?
> >
> > Alex
> >
> > >
> > > Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
> > > Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > > index 90f50561b43a..26e63cb5d8d5 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > > @@ -277,6 +277,16 @@ static bool amdgpu_msi_ok(struct amdgpu_device
> > *adev)
> > >         return true;
> > >  }
> > >
> > > +void amdgpu_restore_msix(struct amdgpu_device *adev) {
> > > +       u16 ctrl;
> > > +
> > > +       pci_read_config_word(adev->pdev, adev->pdev->msix_cap +
> > PCI_MSIX_FLAGS, &ctrl);
> > > +       ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
> > > +       pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
> > PCI_MSIX_FLAGS, ctrl);
> > > +       ctrl |= PCI_MSIX_FLAGS_ENABLE;
> > > +       pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
> > > +PCI_MSIX_FLAGS, ctrl); }
> > >  /**
> > >   * amdgpu_irq_init - initialize interrupt handling
> > >   *
> > > @@ -558,6 +568,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct
> > > amdgpu_device *adev)  {
> > >         int i, j, k;
> > >
> > > +       amdgpu_restore_msix(adev);
> > >         for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
> > >                 if (!adev->irq.client[i].sources)
> > >                         continue;
> > > --
> > > 2.17.1
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> > gfx&amp;data=04%7C01%7CPe
> > >
> > ngJu.Zhou%40amd.com%7C409895f80e0d43ecba3808d93b0a15fc%7C3dd8961
> > fe4884
> > >
> > e608e11a82d994e183d%7C0%7C0%7C637605736778199787%7CUnknown%7C
> > TWFpbGZsb
> > >
> > 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> > 3D%
> > >
> > 7C1000&amp;sdata=w%2FgDzhoAjDraAMiyfx3XTPxx1QNff3OY%2BZWn1NYq%
> > 2Ffo%3D&
> > > amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
