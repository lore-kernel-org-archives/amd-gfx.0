Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573EEC38145
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 18:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A3A10EBB9;
	Thu,  8 Sep 2022 18:43:55 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53C8910EBB2
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 18:43:51 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-12ab0eaa366so7359230fac.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Sep 2022 11:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=m9DNFd/RvG8ZGFZwL7vVXrAKxFIBVGba5hF86xP4+6A=;
 b=OirnrheIUS7edu0DpKhFCsK2jJk9vIjEn2SmgtlBQeX5oc3zAJk7bDaNqIOz8shZ7b
 9wSk9zLWXuMdc6osLGiZd6H4Xmo1Ph7OXsmbp/AJhzdHrnWkKwwpRBeZ+BhGjj0Iv7bi
 JwFySMvD3ZLVVrOmxcRYKsUGrqQKDCQdR37mEy86gg4ux0Crkg1GGgxghHAF79bfTte1
 WLRnCqMhkc9dbsDfOtpXFZLznE/QHLhUKogeD1iWR2KKGwpTzNLOe+h+Tjf3ONg0Qutg
 HtD3x3EeeF39JNfeNRx8piScTr0LTd8IrReacjzO36f5CUQIMzsq5xEj18BF9afzADCD
 tRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=m9DNFd/RvG8ZGFZwL7vVXrAKxFIBVGba5hF86xP4+6A=;
 b=M/zuZvg7OFbBumwvQfJtsAglWz0XSBQ7sXZsf2xJ9+jxv8udfYNVpajIyo0T4D6Inv
 Aj0I4CqhFlQfo2NZ1pqLqtFoR5+LNLybTgB4W4T61q1jwQ3CFQnNKdD4cWXSRNG3ZjVp
 uKtpj5I9w9YKE8Ks4AtV2woZtynTxkXiWW5G55YQq35vr8/m2bgOv5FUqA8N4gzUSIJp
 3jlwckVrLmGLF2xk9VC2h0BZZkkgPZ8H5bxd6wck4cyAAqrHy40BUFkTMLRAGK2PM44x
 jdjFdrBeVWb+J9n8UWj/+RkgpBA9VLxbCI04zny5o56LxUMJefYTUDOKEfzxwpJVxDm8
 H/Qw==
X-Gm-Message-State: ACgBeo2WOq+8jL7+JqwFR6+XnHjJJm2qA+aIStYNk8KD0+5zckSW3bkD
 Z35fGmYNhm9f6shh0IwrSHD3b2aWJh0FR6qNCZs=
X-Google-Smtp-Source: AA6agR4SXBfwLeBtdl0ICYzar40shXRYoDKyMEDELR/KRUk0dFOSfc7hzZJFhPNFugFhIxSsg5p1DV8b19Cq8NgLkkM=
X-Received: by 2002:a05:6870:738d:b0:125:1b5:420f with SMTP id
 z13-20020a056870738d00b0012501b5420fmr2768725oam.96.1662662630449; Thu, 08
 Sep 2022 11:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR12MB461445ADFB5D36D863AA3C3C97409@BYAPR12MB4614.namprd12.prod.outlook.com>
 <20220908175713.GA206965@bhelgaas>
In-Reply-To: <20220908175713.GA206965@bhelgaas>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Sep 2022 14:43:39 -0400
Message-ID: <CADnq5_NT=nXg3kVkFQL7uiLeDxBWrcejtNC4N6MOsgEpJ=jQAA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Don't enable LTR if not supported
To: Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "wielkiegie@gmail.com" <wielkiegie@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 8, 2022 at 1:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Sep 08, 2022 at 04:42:38PM +0000, Lazar, Lijo wrote:
> > I am not sure if ASPM settings can be generalized by PCIE core.
> > Performance vs Power savings when ASPM is enabled will require some
> > additional tuning and that will be device specific.
>
> Can you elaborate on this?  In the universe of drivers, very few do
> their own ASPM configuration, and it's usually to work around hardware
> defects, e.g., L1 doesn't work on some e1000e devices, L0s doesn't
> work on some iwlwifi devices, etc.
>
> The core does know how to configure all the ASPM features defined in
> the PCIe spec, e.g., L0s, L1, L1.1, L1.2, and LTR.
>
> > In some of the other ASICs, this programming is done in VBIOS/SBIOS
> > firmware. Having it in driver provides the advantage of additional
> > tuning without forcing a VBIOS upgrade.
>
> I think it's clearly the intent of the PCIe spec that ASPM
> configuration be done by generic code.  Here are some things that
> require a system-level view, not just an individual device view:
>
>   - L0s, L1, and L1 Substates cannot be enabled unless both ends
>     support it (PCIe r6.0, secs 5.4.1.4, 7.5.3.7, 5.5.4).
>
>   - Devices advertise the "Acceptable Latency" they can accept for
>     transitions from L0s or L1 to L0, and the actual latency depends
>     on the "Exit Latencies" of all the devices in the path to the Root
>     Port (sec 5.4.1.3.2).
>
>   - LTR (required by L1.2) cannot be enabled unless it is already
>     enabled in all upstream devices (sec 6.18).  This patch relies on
>     "ltr_path", which works now but relies on the PCI core never
>     reconfiguring the upstream path.
>
> There might be amdgpu-specific features the driver needs to set up,
> but if drivers fiddle with architected features like LTR behind the
> PCI core's back, things are likely to break.
>
> > From: Alex Deucher <alexdeucher@gmail.com>
> > On Thu, Sep 8, 2022 at 12:12 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> > > Do you know why the driver configures ASPM itself?  If the PCI core is
> > > doing something wrong (and I'm sure it is, ASPM support is kind of a
> > > mess), I'd much prefer to fix up the core where *all* drivers can
> > > benefit from it.
> >
> > This is the programming sequence we get from our hardware team and it
> > is used on both windows and Linux.  As far as I understand it windows
> > doesn't handle this in the core, it's up to the individual drivers to
> > enable it.  I'm not familiar with how this should be enabled
> > generically, but at least for our hardware, it seems to have some
> > variation compared to what is done in the PCI core due to stability,
> > etc. It seems to me that this may need asic specific implementations
> > for a lot of hardware depending on the required programming sequences.
> > E.g., various asics may need hardware workaround for bugs or platform
> > issues, etc.  I can ask for more details from our hardware team.
>
> If the PCI core has stability issues, I want to fix them.  This
> hardware may have its own stability issues, and I would ideally like
> to have drivers use interfaces like pci_disable_link_state() to avoid
> broken things.  Maybe we need new interfaces for more subtle kinds of
> breakage.

I'm not sure what, if anything is wrong with the current generic PCIe
ASPM code in Linux.  I was speaking more from a hardware validation
standpoint.  E.g., our silicon validation and hardware teams run a lot
of tests on a bunch of platforms and tune the programming sequence for
speed/power/stability.  Then they hand the programming sequence off to
the software teams as sort of a golden config or rule set for ASPM
enablement in the OS for each device.  I'm not exactly sure how far
these sequences stray from what the core PCI code does.  Will try and
find out more.

Alex
