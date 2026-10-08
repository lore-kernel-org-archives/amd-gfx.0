Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB23CA600C
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 19:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1AD310E936;
	Thu,  8 Oct 2026 19:23:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a433ev6S";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4765310E936
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 19:23:47 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-3535dd9a601so23189eec.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Oct 2026 12:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791487426; cv=none;
 d=google.com; s=arc-20260327;
 b=PD2jHbDXkK3WezbGG8qxVXLnI3zwD1jHekQNL4eC3gu0W2rTk9F6mowrWP4ZYXDVm4
 yDbxHk3V6falfwCODbVPMWRa0xLH2I+tvaeCqnKxk1wTDO55hk+jc4x5eVeYbijOPMv1
 eLvbXQv+L+shZAo8DO4szPZOcj5OM6V+HAOzaVIg7OtbYm4O75dj76WFaJHoot1TGEfe
 S0qcrKiFPYyTaY98eniex2Ms947KSyS72zK7mN73DzIu/Y6qZxF9f2IqY3lIQPwqFs22
 GNd3ICNVBUJfjR0FJXkgqQf3NzWaGMgEENHg3G4Vi4mtBSTJZtkXku2TnyIZ3FS9gX7Y
 Xt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WHO6i2IO1cdf5Kp1Y2GcYe9pGO81oa3PqBFRgoAXgiI=;
 fh=X2ejhVr3wGiPDNBNviapyj7ANpGyZEKS8jS4Hsl3pKQ=;
 b=fT2/EIkjcCqdC+1x07Te4CXLEMUggNOBOYcRGM8c3nwPe9YootZlC7FF7Cxb+TJq9M
 sMmjjmTPVPqzdHV/s1IdMKaOAYtJKrP9qyfsRu55gV5Hoj3FZliGE4RkxhBcn2INAyin
 q97YyY6zQSbWUI4qafNQUZB+bsd+lWbZdL9qHg37Ck8R1xNfNcmOd0J6Vi7/3aiByHZB
 LWDtClzyFC30N0SWpYLzjPlhfzHnlls001OKG/pqPmcDwickv9eecpbzD8URDOZ4BOtc
 YpptH8aPxOGMdHgN/vO4mDi9b238rvHO1s3UPdwkBWra6XS1sI8JNgvcBhijB0xWqTTz
 EVQQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791487426; x=1792092226; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WHO6i2IO1cdf5Kp1Y2GcYe9pGO81oa3PqBFRgoAXgiI=;
 b=a433ev6SduZ1u52+bMaEnBfkML4SLQVkTIq1JXRGEtW165Bpdkr8ej9mKvDeZ+TTfp
 F+eT4iEimYiaMxbegRY7Dj1+ajV53C9hCnjNUUrXcAK7dVK/r9sipQLeoS06+k3JPtkQ
 dyycsy6YEXBh+Zg1hk3kySFJFpONZ5Ri/+Mr/1A0ptrrPduAnbipBbfT1gyXBqy3bbzz
 I/DFjS7xY42OVt+ccMISgHuZ87kdFAOTC4PEUxCD0hhtfTTFk1CfFn14M9E+C6kLD3hL
 lBQMLa4pGKDwnkYoWBgTb9Q2gjvl/P5hZQrT2KvROXSOb9nKxjP+JLMcKWWN25kJbWVK
 lsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791487426; x=1792092226;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WHO6i2IO1cdf5Kp1Y2GcYe9pGO81oa3PqBFRgoAXgiI=;
 b=jCM0r57flywSv+5VivfnT3TGNeuUN9AZHVaxM7uNiABw+ldn9qWoGnpnKD4dgoGzwh
 0mn1n1tosk/sY1td1AnLK1ATvAbeYC5a+DEq5F8DmYY4NAhUIDwfkwPWWmjMkbMPhk6H
 bRJKCwr68p9P61t6JojdvNmNHf83CgQ+KXKj6otChtuD9q0dLdVIA/CBKV3McJUIdMgK
 8YhtrgYcM/dh7NnRhPV7+RylDvAU6HxTJROP/Eb6PGTZc3CwM+YoycTQ7gckBSKALSvc
 dFyQV0r9Mb3rJ+HyaUrlURqh5IVL+JE6ZkJO5NNBDBaoV2sF5TSgiU8g8AoV5E2Gn6hk
 T8YA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVJ4oL7Jd5n58SBxFU5f6WOomqBlsItfRNNMDgw5xX6MQdHd+7HShCFw31ZfydObKSan6xf/zx@lists.freedesktop.org
X-Gm-Message-State: AFuF++mtm+ibhepiHjZr6er8myfewA0N6PCWNvVjvR25AglgsC+Vb2e/
 vGqTcbF+wzplF/fJaIUMFpdcdsuYniRk7AcPHGst8pPHqtbJEHZSQPR87dDGUeJX1E4q05FUf+g
 X/yCMT24DmuPL/jV1Jqlum4gPMGAuxRM=
X-Gm-Gg: AYBFou2n8P024x/Mov+5MaZvsx5ZAhpFxMZ7S/M0GkvYKJ6iKYpXncJVIPsBinV2P4U
 a5rfZoZKIfFuK53WYqyfisvoCKmp2cHHybJcdQ7kuUJmCuDT6vB/j+cp5pOoau1v2ZxDNTnN1r0
 Mus2O4P62BHrRR9fGJSN5sZhAcB3TiFCLEwaDm20tUteNid49+1D6QZlNHNHpBL71+pYJMOwNTI
 Ovcfa8wfCQ5+iyAg49gCBsc5ebYNGDltshFKTSqhcguqMfWrrRL0xN2Oo1F9wjTX23TVZQPCwHx
 L0+AneKH9TaxHM4Ec4CshUsPthZa3Ro3wXtersJQyi/uDn3Ph54aW7PtOLx46T9gAmVmv+d9vnb
 5qgQfX6ibN1H8nmQRTxC1TwLzVhyfrS7G8oTuv/oEdA==
X-Received: by 2002:a05:701b:42d3:10b0:14c:f3ae:c1a1 with SMTP id
 a92af1059eb24-1657b80bf6emr6467363c88.0.1791487425985; Thu, 08 Oct 2026
 12:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>
 <20261008191705.GA917105@bhelgaas>
In-Reply-To: <20261008191705.GA917105@bhelgaas>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Oct 2026 15:23:34 -0400
X-Gm-Features: AclHuK-jV3SbZUxMOMQXs-rSTId7Jf-E2wheC8RGkrqRF9AJfJ4NNMx1Hsaj4Lw
Message-ID: <CADnq5_P_y-6Ra4Swoxz-CmL1Q3nGhM3RVJUAB2iw1E1D-r1cjQ@mail.gmail.com>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, 
 Christian Koenig <christian.koenig@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, 
 amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>, 
 Jason Perlow <jperlow@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>
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

On Thu, Oct 8, 2026 at 3:17=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> [+cc Thorsten]
>
> On Thu, Oct 08, 2026 at 02:26:00PM +0200, Lukas Wunner wrote:
> > Alex is seeing a probe failure of the amdgpu driver after the Root Port
> > above an AMD Navi10 GPU has been reset.  The reset was performed to
> > recover from a Firmware First reported Fatal Error.
> >
> > However all status registers in the Root Port's AER Extended Capability
> > are blank, so apparently the platform firmware raised a false alarm.
> >
> > The issue is only occurring since commit eddba19b8b5f ("PCI/AER: Suppor=
t
> > Advisory Non-Fatal Errors").  It looks like enabling Advisory Non-Fatal
> > Errors causes code paths to be exercised in platform firmware which
> > were never validated before.
> >
> > Skip error recovery on false alarms, i.e. if no unmasked errors were
> > actually signaled.
> >
> > Note that this will also skip recovery if both the Status and Mask
> > registers are "all ones", as would be the case for inaccessible devices=
.
> > However that seems justified because it would imply either a hot-unplug
> > event or a Surprise Down Error further up in the hierarchy.  Interferin=
g
> > with recovery from that seems uncalled for.
> >
> > Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> > Reported-by: Alex Deucher <alexander.deucher@amd.com>
> > Tested-by: Alex Deucher <alexander.deucher@amd.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222095
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
>
> Applied to pci/for-linus for v7.3, thanks!  I dropped Alex's Tested-by
> since he hasn't tested this change by itself.

FWIW, I just tested this patch by itself and it works as expected.
Feel free to add:
Tested-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Thanks,

Alex

>
> If we're confident that this also fixes the MacBookPro16,1 power-off
> issue reported by Jason (it would be ideal if you could test this,
> Jason), maybe it's ok to keep eddba19b8b5f plus this patch for v7.3.
> If so, I'd like to add Jason's Reported-by and link.
>
> But if we're not sure whether this fixes the MacBookPro16,1 power-off
> issue, I think we'll have to revert eddba19b8b5f for v7.3, then squash
> it with this fix and try again for v7.4.
>
> As far as I'm aware, the reports are:
>
>   https://lore.kernel.org/all/CADnq5_MO+ZNOzW+_EH+gUYZ27X_ggWJJ0XdK6m2QW5=
3m_ThtUQ@mail.gmail.com/
>     Alex's report for AMD Navi10 and Vega20
>
>   https://lore.kernel.org/all/CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R=
7rME35_Q@mail.gmail.com
>     Jason's report of power-off issue on MacBookPro16,1
>
> > ---
> >  When applied to pci/for-linus, this will cause a conflict during the
> >  merge window with a commit queued on pci/aer, d4c842c3af5b ("PCI/AER:
> >  Fix memory leak in aer_recover_work_func() when pci_dev is missing").
> >
> >  To resolve the conflict, change "if (pdev)" to "if (pdev && err)"
> >  and move the pci_dev_put() out of the if-clause (so that it gets
> >  called if pdev !=3D NULL but err =3D=3D 0).
> >
> >  If this is all too complicated and/or late, I can respin on top of
> >  pci/aer or v7.4-rc1.
> >
> >  drivers/pci/pcie/aer.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index d8dcd238fda1..922a726a52a5 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1360,8 +1360,10 @@ static DEFINE_KFIFO(aer_recover_ring, struct aer=
_recover_entry,
> >
> >  static void aer_recover_work_func(struct work_struct *work)
> >  {
> > +     struct aer_capability_regs *regs;
> >       struct aer_recover_entry entry;
> >       struct pci_dev *pdev;
> > +     u32 err;
> >
> >       while (kfifo_get(&aer_recover_ring, &entry)) {
> >               pdev =3D pci_get_domain_bus_and_slot(entry.domain, entry.=
bus,
> > @@ -1375,6 +1377,12 @@ static void aer_recover_work_func(struct work_st=
ruct *work)
> >               }
> >               pci_print_aer(pdev, entry.severity, entry.regs);
> >
> > +             regs =3D entry.regs;
> > +             if (entry.severity =3D=3D AER_CORRECTABLE)
> > +                     err =3D regs->cor_status & ~regs->cor_mask;
> > +             else
> > +                     err =3D regs->uncor_status & ~regs->uncor_mask;
> > +
> >               /*
> >                * Memory for aer_capability_regs(entry.regs) is being
> >                * allocated from the ghes_estatus_pool to protect it fro=
m
> > @@ -1385,12 +1393,14 @@ static void aer_recover_work_func(struct work_s=
truct *work)
> >               ghes_estatus_pool_region_free((unsigned long)entry.regs,
> >                                           sizeof(struct aer_capability_=
regs));
> >
> > -             if (entry.severity =3D=3D AER_NONFATAL)
> > -                     pcie_do_recovery(pdev, pci_channel_io_normal,
> > -                                      aer_root_reset);
> > -             else if (entry.severity =3D=3D AER_FATAL)
> > -                     pcie_do_recovery(pdev, pci_channel_io_frozen,
> > -                                      aer_root_reset);
> > +             if (err) {
> > +                     if (entry.severity =3D=3D AER_NONFATAL)
> > +                             pcie_do_recovery(pdev, pci_channel_io_nor=
mal,
> > +                                              aer_root_reset);
> > +                     else if (entry.severity =3D=3D AER_FATAL)
> > +                             pcie_do_recovery(pdev, pci_channel_io_fro=
zen,
> > +                                              aer_root_reset);
> > +             }
> >               pci_dev_put(pdev);
> >       }
> >  }
> > --
> > 2.53.0
> >
