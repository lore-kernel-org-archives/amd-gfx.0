Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0A0C61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 07:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C3A10EBC5;
	Tue,  1 Sep 2026 07:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KPFa9duw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E07F10E637
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788201180; x=1819737180;
 h=from:date:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=qhsge+/69E4jNcWl7mZmEyCtLeMfahz3yWtH0cXD0tc=;
 b=KPFa9duwaYRhiy7P24d5TLPuD+MHXm21B6wyuqLjhYgEHlLIMZh50E7b
 y5vOOfCIiIfJMLF+0nc47w89uX4+6CL2RKynMD/konp+/7QtE4026IPjp
 1pEjfki/UcMD9PMdZR8Ma4OF2tZDIUP0FRNmgnlWuP5JchfNZS0qPP/8H
 TITKTPuNA0/8EQW+VtiCgqpubLWCHOl99rkgUD8o1faX8MfG/tZRq4lyO
 FsOPm3HVs/gcgh8/Ov7Yp8taYOHdjHOZMIZ6gHlv7XTSSeUY6kxEcQzWq
 b57W7uxFrKwBnRyTsmVYqZHZrd8bhE35CqC56AgDm6NsQkmgwK037wiCR A==;
X-CSE-ConnectionGUID: Z35hGF8cTLyCykBF19v7zA==
X-CSE-MsgGUID: 7YazbvL1T4qDp/GzybG7WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88667384"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="88667384"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 11:33:00 -0700
X-CSE-ConnectionGUID: Vkz1x03HQ5+hjPCvMPu67g==
X-CSE-MsgGUID: f6oTpFKnRCqEacANzmAPrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="293708209"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.121])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 11:32:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 31 Aug 2026 21:32:51 +0300 (EEST)
To: Geramy Loveless <gloveless@jqluv.com>
cc: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, mario.limonciello@amd.com, 
 nra3088@gmail.com, meiling.leung@embeddedllm.com, 
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Reserve prefetchable window headroom for Resizable
 BARs
In-Reply-To: <1eb85efc-43f4-4929-8390-467308522236@jqluv.com>
Message-ID: <7366a0bc-360b-0667-ee94-af839374dfed@linux.intel.com>
References: <39e09dd8-f73e-4dc2-ba36-8a9228516d26@jqluv.com>
 <d4c3ea40-d92a-49c4-ab2c-925fc70c4bb9@amd.com>
 <d6c56ff3-0b83-4d2e-7e6f-f3e65a284341@linux.intel.com>
 <1eb85efc-43f4-4929-8390-467308522236@jqluv.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-633456053-1788201171=:2637"
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:59:19 +0000
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-633456053-1788201171=:2637
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 31 Aug 2026, Geramy Loveless wrote:
> On 8/31/26 9:58 AM, Ilpo J=C3=A4rvinen wrote:
> > On Mon, 31 Aug 2026, Christian K=C3=B6nig wrote:
> >
> >> On 8/28/26 23:37, Geramy Loveless wrote:
> >>> Firmware typically sizes prefetchable bridge windows for the boot-tim=
e
> >>> BAR size. Behind a fixed (non-hotplug) PCIe switch fabric, there is t=
hen
> >>> no room for a driver to grow a Resizable BAR afterwards: every window
> >>> from the leaf up to the root is sized for the small BAR, so
> >>> pci_resize_resource() fails with -ENOSPC.=20
> >>>
> >>> Furthermore, a small prefetchable BAR (e.g., a 2 MiB doorbell) sharin=
g a=20
> >>> bridge's single prefetchable window with a much larger one (e.g., a 3=
2 GiB=20
> >>> VRAM BAR) pushes the required window size past the large BAR's alignm=
ent.=20
> >>> Because bridge windows round up to a power of two, this forces a mass=
ive=20
> >>> alignment waste (e.g., 32 GiB + 2 MiB rounds up to a 64 GiB window,=
=20
> >>> wasting ~32 GiB per GPU).
> >>>
> >>> This patch solves both issues to enable ReBAR on cascaded switch fabr=
ics:
> >>>
> >>> 1. Reserve Headroom:=20
> >>> Reserve prefetchable window headroom for the maximum size of each=20
> >>> downstream Resizable BAR during the bridge sizing pass. The device BA=
R=20
> >>> and hardware ReBAR are left at their boot size to prevent tearing dow=
n=20
> >>> firmware-loaded state (e.g., AMD R9700 PSP) before the driver binds.
> >> Yeah that was suggested before but that is clearly not something you c=
an=20
> >> do in common code.
> >>
> >> The ReBAR fields often doesn't reflect the actual needed space but=20
> >> rather the maximum the HW address logic can resolve.
> >>
> >> So what you end up with is allocating multiple TiB for a window which=
=20
> >> just needs few GiB, sometimes even completely overflowing the 64bit=20
> >> address space made available by the root complex.
>=20
> Yeah I could imagine that would be bad, hence I tried to compact the=20
> 64-bit space as well. As far as I understand PCI/PCIe standards its=20
> making this patch difficult.=20

No compacting will save you in some cases. There are setups with many GPUs=
=20
and with VF BARs, the space requirement to fit full-sized ReBARs is way=20
beyond what the root bus resource can hold. Where's your fallback for such=
=20
cases? What are the failure modes of that fallback?

> Christian I'm not sure if you could share these reference documents but=
=20
> that probably would be a better start for me to look at before I update=
=20
> the patch or make changes, also I need to wait for a review on the last=
=20
> patch I submitted too, so that leaves me with some time to review some=20
> standards if you know specifically where to look, if not thats fine too.
>=20
> > Yes. A naive approach to (only) go to the max ReBAR allows just doesn't=
=20
> > work well enough to be usable in general case.
>
> I did not know the max would report above the amount is actually needed=
=20
> because of vendors decisions in the cards, that's interesting.=20

Not just that, using too large size has ripple effects on other resources=
=20
in the system, and those failures are hard to correct (your code doesn't=20
even try to do that).

> > A general algorithm to pick the largests fitting sizes for ReBARs is st=
ill=20
> > under works, a few steps away still, and more if I discover more=20
> > challenges I need address before I can take that final step.
>
> So then I would assume instead of doing the "hack" i'm having to use I=20
> would change it to your new algorithm?

Assuming you meant we apply this kind of naive approach first and later=20
changing to the new algorithm, the problem with that approach is this
"hack" must not break working setups either, but it surely would. If it=20
does break things, the change will just end up reverted. And that end=20
result is same as not doing the "hack" at all.

It's not enough it doesn't break your setup. It generally must not break=20
any setup, which is unfortunately very very high bar.


--=20
 i.

--8323328-633456053-1788201171=:2637--
