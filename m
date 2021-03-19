Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922AEC433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 18:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C2361953
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 18:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C2361953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1B6F6EA66;
	Fri, 19 Mar 2021 18:11:50 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C55C16EA66
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 18:11:49 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id l79so5705473oib.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3z4Ip00lYdJc5oGJqkZi/FZJHg9JJdinGpv4fGHlXnw=;
 b=UixOYv8kqZcjzaQfODhZIaIjkiRC8MjI3+jqaUXIxPOE4992q28tK6qKadLqopGvZd
 N27kPwRT+DSqVr+tgh7KWbJZ7Wh7f6ytHrgwoeukn8wD+diDdgLSM1I7vMq+vJKPxUNB
 xgxSOAHpiop/KQQgOBSuYnCodc9jLkXzZThrafS50p3+OMwWGQjkZva2TtN+ECQod3Wc
 p7rP0KlEmiszGtBarclnpYPR6BPz0DpW8ZYJ5iI2OtYNdsNBAEJjMD6t/tiEAoXScL2O
 ybdW5UezcZUeW7b6u8qZwxKIaPEUmoXXTYXJV3/FZeemwV6r0RBp/3unV+RuHuPaT/3Y
 ynBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3z4Ip00lYdJc5oGJqkZi/FZJHg9JJdinGpv4fGHlXnw=;
 b=UXlZIw/TXOgt8QynmYeMiMObTuPLpgx7kN2rytipw1uCGpc/EervMTOB5pM1n4ui93
 EF/nu0w7KkhkwdTgbZvuYLzBsNv5lwq5TJEKkDyfDRS2yzA6G/Q1XgtVFZvda82Zlm0n
 /xKCJElWBIx5TUAd8/9++rwafTkZ3fYqeiCP9mbUkgH5fkGVF9UJsf6wDrQYKoTmSebu
 eDoNfJ3/BZSlIFSkoTYoyFxCvtdJC5rtyocP2sFj36PZxVs2b/K8xlX9pBQMlmQmxPwB
 eNPHFPaOIZlu+xjEFsD8pCtmOJ3Pfy4SyunjT8w44oTmhuv4Pf4QGJlRXOadZ+It5JON
 iL3g==
X-Gm-Message-State: AOAM532tf0QZca+ysRSADL0oNj1czDE4yzCs1pdG+SOOTJZAbRwJNmpW
 b3Pb8F+5BMAHFRJyMDk6uQ2IR7n3hwpqcdVl//E=
X-Google-Smtp-Source: ABdhPJzR86QWoDCxkQPmd3OBmR0ZOm9XTHhyFOBjEE8EgTr803+bjwp5hjJCpgZmhh+gnkoJRo2w5rKGA94slJ2PAVA=
X-Received: by 2002:aca:af10:: with SMTP id y16mr1910455oie.120.1616177509039; 
 Fri, 19 Mar 2021 11:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210316192851.286563-1-alexander.deucher@amd.com>
 <20210318183639.GA158657@bjorn-Precision-5520>
In-Reply-To: <20210318183639.GA158657@bjorn-Precision-5520>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Mar 2021 14:11:38 -0400
Message-ID: <CADnq5_NN=Of+b4N6gUFsLiOuTkEznp8f5aVW4fuJX3sOZpHy5w@mail.gmail.com>
Subject: Re: [PATCH] PCI: quirks: Quirk PCI d3hot delay for AMD xhci
To: Bjorn Helgaas <helgaas@kernel.org>
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
Cc: Shyam-sundar.S-k@amd.com, Linux PCI <linux-pci@vger.kernel.org>,
 Marcin Bachry <hegel666@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Prike Liang <Prike.Liang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 18, 2021 at 2:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Mar 16, 2021 at 03:28:51PM -0400, Alex Deucher wrote:
> > From: Marcin Bachry <hegel666@gmail.com>
> >
> > Renoir needs a similar delay.
>
> See https://lore.kernel.org/linux-pci/20210311125322.GA2122226@bjorn-Precision-5520/
>
> This is becoming a problem.  We shouldn't have to merge a quirk for
> every new device.  Either the devices are defective, and AMD should
> publish errata and have a plan for fixing them, or Linux is broken and
> we should fix that.
>
> There are quite a few mechanisms for controlling delays like this
> (Config Request Retry Status (PCIe r5.0, sec 2.3.1), Readiness
> Notifications (sec 6.23), ACPI _DSM for power-on delays (PCI Firmware
> Spec r3.3)), but most are for *reducing* delay, not for extending it.
>
> Linux supports CRS, but not all the others.  Maybe we're missing
> something we should support?
>
> How do you deal with these issues for Windows?  If it works on Windows
> without quirks, we should be able to make it work on Linux as well.

It works fine in windows.  Unfortunately, it's hard to tell what
windows does exactly since MS supplies the USB driver in that case.
Also, the extended delays are not necessary on our reference
platforms, these seem to only be an issue on some OEM platforms.  I
did confirm with the windows team that we use d3hot for USB on our
current platforms due to bios bugs, but this is fixed on upcoming
platforms.  Still digging for any more details.

>
> > Signed-off-by: Marcin Bachry <hegel666@gmail.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/pci/quirks.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 653660e3ba9e..36e5ec670fae 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -1904,6 +1904,9 @@ static void quirk_ryzen_xhci_d3hot(struct pci_dev *dev)
> >  }
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e0, quirk_ryzen_xhci_d3hot);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e1, quirk_ryzen_xhci_d3hot);
> > +/* Renoir XHCI requires longer delay when transitioning from D0 to
> > + * D3hot */
>
> No need for "me too" comments that add no additional information.

Will drop that.

Alex

>
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1639, quirk_ryzen_xhci_d3hot);
> >
> >  #ifdef CONFIG_X86_IO_APIC
> >  static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
> > --
> > 2.30.2
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
