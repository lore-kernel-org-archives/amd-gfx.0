Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD59CA6007
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 15:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5851210E45C;
	Thu,  8 Oct 2026 15:19:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sHgOO3iu";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64A3710E45C
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 15:19:35 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-150b2fbd784so56923c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Oct 2026 08:19:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791472774; cv=none;
 d=google.com; s=arc-20260327;
 b=Q5P2qWMQPGlDJva5bJiuCkqOUHd/JqpGbTkM6uTMjLpMTn/BndzL4IW6is0t09VGM2
 psB2vHUSyJiCJhY5kFtybD8/VfF/J+EDkIJxc+MGQ4G6qsK8kGbZCfHHvCv9YWU1neud
 xwQBKBtuKnKj5P5oalXCvTajsshcaf501bHTDnZP+r2ln+4LGz6O3rK3m7/9CaghSNyI
 jnK/ejjlpjhz6dlqvmPKte+7igBEmi5SOVUY//z+ZI0GbGKm5E4mkL1BSSOUOCErDuR2
 9NoDTA1QVZyg1n/JQhYLBAUAt502d4OMom1ZIfSP8o9Ko95gOdVSe98Zt/Yngssk9MHn
 /jXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=npfelcdpyTnvOtpnktEjaeVdPI171st1+yAn0CtmD5k=;
 fh=GfD5FIX1FDIfpPlBSWCweuN81+Owaqq8jzGQMMasyNg=;
 b=H9vDK6B+JWNqYpAFfmt86nyPy8CUCE0EXbOGUrwGr4wx8O7yzTcyFlFDRYPteyzi2j
 c0iKJ2pERBsbfTC9GT7h9xOmDhBSPaIgmj6SrpXOYQVzh29ezIpBryHNec9mC3S6MWKS
 raeOo97sxZvuAymM2GUt5SxPbGhRJhdo5o5ht4ACKj+4xXZJ8cMRoOP1AL5L0oQeF0tn
 PzrtbpqF4qfBbgBs2lwzNkc4jOIWz3q2FNrc5RG4f9pP/ddCzUmmYTZydMxvKlBRBN47
 LK+luzPDPAPzxUJMRDdZd2To24/8f7fwsHh90ldeh7W/7WE2i+0A3E/aObrla/52AU8B
 xd3Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791472774; x=1792077574; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=npfelcdpyTnvOtpnktEjaeVdPI171st1+yAn0CtmD5k=;
 b=sHgOO3iuTnn6iRJ0ypJeMxYow0ly223Lwe4wmLzVrBt8yh/i+c5xZ+2MQSrBstyAjG
 FyQZ8/hzti65p5vkJON1zb+Rv1jM1rCDTXadZBJGd7FeKhMxpH46s3BPaBfUtUsdVAR/
 2BMGl0J0Nj28YChWllHG6vCHnuAv9AzSJWHK3nk7vLf16L3HjBPSwQ58B0lT8mMIFC6w
 8aeoa0ZKuVNfZkczrDNIDQpFU0fU309d3dqNWz/6udKJa+Thi8rqS0du7Kls8T1BT+U1
 +G+bxkVgUTPI4ruVTuxU9d6NU2cVENMOGBtRW12wHKEuXcyf7AVbDyyrpGrBMyOwU4sE
 O4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791472774; x=1792077574;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=npfelcdpyTnvOtpnktEjaeVdPI171st1+yAn0CtmD5k=;
 b=OQ2h30tScf7rDFyQ6q6odjZrmD4lYcfcRcJB4ZDinxOUxy6bkRJUW4Ztqi9yrnXOfA
 aB7+Y2ji9nNyb6WznrgICxhy2Zf7Rv3SRTzE0+xdmEumlyEmlY6NS/qA7LcjIn6eICgL
 hJIAJ+71QwKuhlBtK7Pi2fDigG40ybty3mtlQXJNwl/4Sr4TtepOOjmUPBbLmMAt9kGm
 YrNga1I51gSkZ0kZhXWHG6Ey4MSa0zyt8x2OiWSOnHSS5TTRFffyI3xtu2iNIxlMSHrR
 wOb6uhy82AVS8E9H9Hz3iwlwf8ixloVplOqACcXVOufnuEXqD6DQsSWSIMQm7jQxz5oG
 b9EA==
X-Forwarded-Encrypted: i=1;
 AKwUvByxj4gz0YC8GOYUZ6bCp73zqYeg4K6O5B5Gesq1K3Tuhb2fJUGS4qpRc1AFRQ7YYLdivO4aLtOG@lists.freedesktop.org
X-Gm-Message-State: AFuF++lkbXa34tGOqnnPlk6s/6weAnqJ2P+7CCr/hoqF2t2efRys8Uc+
 OWcgR5qU7F6ktnf7kuuRJKGQaK9RQmRrolRIEm3cAQSZb6Mk3FfucJ13/YIrWICP92+/HUNRJSK
 uvjl/NUR4AoIGHs9bqymRM4tBcS/ZLII=
X-Gm-Gg: AYBFou0ZwbshQDM16mcNetKs6RhZ3vLPZ1aWgNaRwvPxwfINfezm0EcjOeiasMvJZsR
 n8XJbUsiCnZt++VCau9+kkNGU71wYFnmRBUYd85LJG/48utVphvJ7kyME2GN+lXfS3QLy9SL4bZ
 WmfDVZ5EUUa+JEsGG2da8NHt1B7QyDTcm3aJ0YMrtfqssc+Ic2U5mLGKfUNjTUTlNLrjDYPhuvM
 xE8IqVw/nhhvgqqndd2TcCIQEigzQ8D8pYh4tj0UoUfuLfZzNjgmNHW1kerGo86N3U3vbT/BxtA
 1bxdPFrxt6gXmTDj8vNzA0ksruYyHpMNT5eq0doOijWa458l77Y0sjo6nsZMbKdk9XxJG8n3EGZ
 LZgYSDXxiz51N5HZJDGFUI4SakKCr1jL8GMBdFRoBxA==
X-Received: by 2002:a05:7022:1505:b0:12d:c389:ae54 with SMTP id
 a92af1059eb24-1658abf47cfmr6616040c88.2.1791472774454; Thu, 08 Oct 2026
 08:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>
In-Reply-To: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Oct 2026 11:19:22 -0400
X-Gm-Features: AclHuK8eqqZZwcxfnGYDRIjGfmIuea5RApPlIzK4ZWhRJY1bOeK92MqHIl3h3To
Message-ID: <CADnq5_PVD6G_VMepJ3mAz=60vM1PHtun51Kccxyz9sdBsx_7wA@mail.gmail.com>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, 
 Christian Koenig <christian.koenig@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, 
 amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>, 
 Jason Perlow <jperlow@gmail.com>
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

On Thu, Oct 8, 2026 at 8:26=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrote=
:
>
> Alex is seeing a probe failure of the amdgpu driver after the Root Port
> above an AMD Navi10 GPU has been reset.  The reset was performed to
> recover from a Firmware First reported Fatal Error.
>
> However all status registers in the Root Port's AER Extended Capability
> are blank, so apparently the platform firmware raised a false alarm.
>
> The issue is only occurring since commit eddba19b8b5f ("PCI/AER: Support
> Advisory Non-Fatal Errors").  It looks like enabling Advisory Non-Fatal
> Errors causes code paths to be exercised in platform firmware which
> were never validated before.
>
> Skip error recovery on false alarms, i.e. if no unmasked errors were
> actually signaled.
>
> Note that this will also skip recovery if both the Status and Mask
> registers are "all ones", as would be the case for inaccessible devices.
> However that seems justified because it would imply either a hot-unplug
> event or a Surprise Down Error further up in the hierarchy.  Interfering
> with recovery from that seems uncalled for.
>
> Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> Reported-by: Alex Deucher <alexander.deucher@amd.com>
> Tested-by: Alex Deucher <alexander.deucher@amd.com>

FWIW, I only tested this patch in conjunction with the other two
patches you had posted on the ticket.  I haven't tried just this patch
alone.

Alex

> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222095
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  When applied to pci/for-linus, this will cause a conflict during the
>  merge window with a commit queued on pci/aer, d4c842c3af5b ("PCI/AER:
>  Fix memory leak in aer_recover_work_func() when pci_dev is missing").
>
>  To resolve the conflict, change "if (pdev)" to "if (pdev && err)"
>  and move the pci_dev_put() out of the if-clause (so that it gets
>  called if pdev !=3D NULL but err =3D=3D 0).
>
>  If this is all too complicated and/or late, I can respin on top of
>  pci/aer or v7.4-rc1.
>
>  drivers/pci/pcie/aer.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d8dcd238fda1..922a726a52a5 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1360,8 +1360,10 @@ static DEFINE_KFIFO(aer_recover_ring, struct aer_r=
ecover_entry,
>
>  static void aer_recover_work_func(struct work_struct *work)
>  {
> +       struct aer_capability_regs *regs;
>         struct aer_recover_entry entry;
>         struct pci_dev *pdev;
> +       u32 err;
>
>         while (kfifo_get(&aer_recover_ring, &entry)) {
>                 pdev =3D pci_get_domain_bus_and_slot(entry.domain, entry.=
bus,
> @@ -1375,6 +1377,12 @@ static void aer_recover_work_func(struct work_stru=
ct *work)
>                 }
>                 pci_print_aer(pdev, entry.severity, entry.regs);
>
> +               regs =3D entry.regs;
> +               if (entry.severity =3D=3D AER_CORRECTABLE)
> +                       err =3D regs->cor_status & ~regs->cor_mask;
> +               else
> +                       err =3D regs->uncor_status & ~regs->uncor_mask;
> +
>                 /*
>                  * Memory for aer_capability_regs(entry.regs) is being
>                  * allocated from the ghes_estatus_pool to protect it fro=
m
> @@ -1385,12 +1393,14 @@ static void aer_recover_work_func(struct work_str=
uct *work)
>                 ghes_estatus_pool_region_free((unsigned long)entry.regs,
>                                             sizeof(struct aer_capability_=
regs));
>
> -               if (entry.severity =3D=3D AER_NONFATAL)
> -                       pcie_do_recovery(pdev, pci_channel_io_normal,
> -                                        aer_root_reset);
> -               else if (entry.severity =3D=3D AER_FATAL)
> -                       pcie_do_recovery(pdev, pci_channel_io_frozen,
> -                                        aer_root_reset);
> +               if (err) {
> +                       if (entry.severity =3D=3D AER_NONFATAL)
> +                               pcie_do_recovery(pdev, pci_channel_io_nor=
mal,
> +                                                aer_root_reset);
> +                       else if (entry.severity =3D=3D AER_FATAL)
> +                               pcie_do_recovery(pdev, pci_channel_io_fro=
zen,
> +                                                aer_root_reset);
> +               }
>                 pci_dev_put(pdev);
>         }
>  }
> --
> 2.53.0
>
