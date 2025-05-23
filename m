Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E154C54ED0
	for <amd-gfx@archiver.kernel.org>; Fri, 23 May 2025 15:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C55B010E822;
	Fri, 23 May 2025 15:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GCJsCffg";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4868810E822
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 15:23:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5EDC35C669A
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 15:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2430EC4CEF0
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 15:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748013802;
 bh=kFU3z1d17iMrqF0O1FFEbAP/eJFJPhRHlEJ54J8XTVc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=GCJsCffgRhNgTzLNGrkWVTqYuBBNQ/lWpUEmNlhlp83i+95m07cdK0sAFWcIVVgEM
 yR8LOtAlNeJgUXGjEKmUJ7qwsXCbLjPdU4/8oR+1qNkbZ5ZXIA4GrKSB7VwIWqSr1n
 wSdui4eTHkUOdHKC0yzmwPpxybRkGbfGu7HysgHOLWOjSLNJDe8ZjzpYHGfg+yhB4i
 LrtqDgptpItwARSUi4xjwQRh59eWlDwpC+atan9vaDkxJc7qxlNUByj0uUKulP8dwx
 +g7s3+d1zu8Y1Qq5qD7LM9fvG/8Wm0+4jp9PtOpdQrCcKaocYFGiZAgyaNbo+f/U95
 Yn7xDniI2fpZw==
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-3fa6c54cdb2so43780b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 08:23:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCV2dfHiwyyIf5e/hTHYkBV7NSy5VtCdnxIM5HO03IFLJ6pBRwYZyGGwnzKDP2XIbHppupjgdt0x@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGk8/QqZU8WFlRfz3xlxZlYwunXT6Zl20S/WCVDM3xIVPJ7niF
 jvCSs464PNU0lH3SiRUuREwN3jzR/f5AEdxS4PElZ6cyJrO49W5Ih9EvXWeLx3xrW5Upyfpi6A2
 JcBmiQG44W/uUOlaAZH1/qyRwcUPatwk=
X-Google-Smtp-Source: AGHT+IG9dA09OaN9HtIb2OLTnzHuR8/YfJGjkAyo0F64F9F+D/ugyJViXIDcuj3kmD60w5kMaMWohRGoKSaB9drV7kY=
X-Received: by 2002:a05:6808:1596:b0:401:e933:5de9 with SMTP id
 5614622812f47-4063d9f0c99mr2288054b6e.18.1748013801425; Fri, 23 May 2025
 08:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <aCsK743YSuahPtnH@black.fi.intel.com>
 <85ed0b91-c84f-4d24-8e19-a8cb3ba02b14@gmail.com>
 <aCxP6vQ8Ep9LftPv@black.fi.intel.com>
 <a8c83435-4c91-495c-950c-4d12b955c54c@kernel.org>
 <aCyj9nbnIRet93O-@black.fi.intel.com>
 <552d75b2-2736-419f-887e-ce2692616578@kernel.org>
 <ee1117cf-6367-4e9a-aa85-ccfc6c63125d@gmail.com>
 <6f23d82c-10cc-4d70-9dce-41978b05ec9a@kernel.org>
 <aCzNL9uXGbBSdF2S@black.fi.intel.com>
 <fea86161-2c47-4b0f-ac07-b3f9b0f10a03@kernel.org>
 <aC2UzG-eycjqYQep@black.fi.intel.com>
 <CAJZ5v0gRFwKhq21ima3kT0zzFLk4=47ivvzJqARksV7nYHTJAQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gRFwKhq21ima3kT0zzFLk4=47ivvzJqARksV7nYHTJAQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 17:23:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h9--jFVBtQ5F7Gee3Cy8P3TeSLdiHEWykQ=EsZdoffmg@mail.gmail.com>
X-Gm-Features: AX0GCFvmhrWJv8M4OR1VsD9co8m93QCOsuTIdV_4nAnEkTPTvlMlfZZIe0IaoEo
Message-ID: <CAJZ5v0h9--jFVBtQ5F7Gee3Cy8P3TeSLdiHEWykQ=EsZdoffmg@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Prevent power state transition of erroneous device
To: Raag Jadav <raag.jadav@intel.com>, Mario Limonciello <superm1@kernel.org>
Cc: Denis Benato <benato.denis96@gmail.com>, mahesh@linux.ibm.com,
 oohall@gmail.com, 
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com, lukas@wunner.de, 
 aravind.iddamsetty@linux.intel.com, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>
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

On Wed, May 21, 2025 at 1:27=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, May 21, 2025 at 10:54=E2=80=AFAM Raag Jadav <raag.jadav@intel.com=
> wrote:
> >
> > On Tue, May 20, 2025 at 01:56:28PM -0500, Mario Limonciello wrote:
> > > On 5/20/2025 1:42 PM, Raag Jadav wrote:
> > > > On Tue, May 20, 2025 at 12:39:12PM -0500, Mario Limonciello wrote:
> > > > > On 5/20/2025 12:22 PM, Denis Benato wrote:
> > > > > > On 5/20/25 17:49, Mario Limonciello wrote:
> > > > > > > On 5/20/2025 10:47 AM, Raag Jadav wrote:
> > > > > > > > On Tue, May 20, 2025 at 10:23:57AM -0500, Mario Limonciello=
 wrote:
> > > > > > > > > On 5/20/2025 4:48 AM, Raag Jadav wrote:
> > > > > > > > > > On Mon, May 19, 2025 at 11:42:31PM +0200, Denis Benato =
wrote:
> > > > > > > > > > > On 5/19/25 12:41, Raag Jadav wrote:
> > > > > > > > > > > > On Mon, May 19, 2025 at 03:58:08PM +0530, Raag Jada=
v wrote:
> > > > > > > > > > > > > If error status is set on an AER capable device, =
most likely either the
> > > > > > > > > > > > > device recovery is in progress or has already fai=
led. Neither of the
> > > > > > > > > > > > > cases are well suited for power state transition =
of the device, since
> > > > > > > > > > > > > this can lead to unpredictable consequences like =
resume failure, or in
> > > > > > > > > > > > > worst case the device is lost because of it. Leav=
e the device in its
> > > > > > > > > > > > > existing power state to avoid such issues.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >
> > > > > > > > > > > > > v2: Synchronize AER handling with PCI PM (Rafael)
> > > > > > > > > > > > > v3: Move pci_aer_in_progress() to pci_set_low_pow=
er_state() (Rafael)
> > > > > > > > > > > > >         Elaborate "why" (Bjorn)
> > > > > > > > > > > > > v4: Rely on error status instead of device status
> > > > > > > > > > > > >         Condense comment (Lukas)
> > > > > > > > > > > > Since pci_aer_in_progress() is changed I've not inc=
luded Rafael's tag with
> > > > > > > > > > > > my understanding of this needing a revisit. If this=
 was a mistake, please
> > > > > > > > > > > > let me know.
> > > > > > > > > > > >
> > > > > > > > > > > > Denis, Mario, does this fix your issue?
> > > > > > > > > > > >
> > > > > > > > > > > Hello,
> > > > > > > > > > >
> > > > > > > > > > > Unfortunately no, I have prepared a dmesg but had to =
remove the bootup process because it was too long of a few kb: https://past=
ebin.com/1uBEA1FL
> > > > > > > > > >
> > > > > > > > > > Thanks for the test. It seems there's no hotplug event =
this time around
> > > > > > > > > > and endpoint device is still intact without any PCI rel=
ated failure.
> > > > > > > > > >
> > > > > > > > > > Also,
> > > > > > > > > >
> > > > > > > > > > amdgpu 0000:09:00.0: PCI PM: Suspend power state: D3hot
> > > > > > > > > >
> > > > > > > > > > Which means whatever you're facing is either not relate=
d to this patch,
> > > > > > > > > > or at best exposed some nasty side-effect that's not ha=
ndled correctly
> > > > > > > > > > by the driver.
> > > > > > > > > >
> > > > > > > > > > I'd say amdgpu folks would be of better help for your c=
ase.
> > > > > > > > > >
> > > > > > > > > > Raag
> > > > > > > > >
> > > > > > > > > So according to the logs Denis shared with v4
> > > > > > > > > (https://pastebin.com/1uBEA1FL) the GPU should have been =
going to BOCO. This
> > > > > > > > > stands for "Bus off Chip Off"
> > > > > > > > >
> > > > > > > > > amdgpu 0000:09:00.0: amdgpu: Using BOCO for runtime pm
> > > > > > > > >
> > > > > > > > > If it's going to D3hot - that's not going to be BOCO, it =
should be going to
> > > > > > > > > D3cold.
> > > > > > > >
> > > > > > > > Yes, because upstream port is in D0 for some reason (might =
be this patch
> > > > > > > > but not sure) and so will be the root port.
> > > > > > > >
> > > > > > > > pcieport 0000:07:00.0: PCI PM: Suspend power state: D0
> > > > > > > > pcieport 0000:07:00.0: PCI PM: Skipped
> > > > > > > >
> > > > > > > > and my best guess is the driver is not able to cope with th=
e lack of D3cold.
> > > > > > >
> > > > > > > Yes; if the driver is configured to expect BOCO (D3cold) if i=
t doesn't get it, chaos ensues.
> > > > > > >
> > > > > > > I guess let's double check the behavior with CONFIG_PCI_DEBUG=
 to verify this patch is what is changing that upstream port behavior.
> > > > > >
> > > > > >
> > > > > > This is the very same exact kernel, minus the patch in question=
:  https://pastebin.com/rwMYgG7C
> > > > > >
> > > > > >
> > > > > > Both previous kernel and this one have CONFIG_PCI_DEBUG=3Dy.
> > > > > >
> > > > > > Removed the initial bootup sequence to be able to use pastebin.
> > > > >
> > > > > Thanks - this confirms that the problem is the root port not goin=
g to D3.
> > > > > This new log shows:
> > > > >
> > > > > pcieport 0000:07:00.0: PCI PM: Suspend power state: D3hot
> > > > >
> > > > > So I feel we should fixate on solving that.
> > > >
> > > > Which means what you're looking for is error flag being set somewhe=
re in
> > > > the hierarchy that is preventing suspend.
> > >
> > > Is the issue perhaps that this is now gated on both correctable and
> > > uncorrectable errors?
> > >
> > > Perhaps should *correctable errors* be emitted with a warning and the
> > > *uncorrectable errors* be fatal?
> >
> > That'd be more or less inline with hiding the issue, and it can also ra=
ce
> > with err_handler callback if driver has registered it.
> >
> > > > But regardless of it, my understanding is that root port suspend de=
pends
> > > > on a lot of factors (now errors flags being one of them with this p=
atch)
> > > > and endpoint driver can't possibly enforce or guarantee it - the be=
st it
> > > > can do is try.
> > > >
> > > > What's probably needed is D3cold failure handling on driver side, b=
ut I'm
> > > > no PCI PM expert and perhaps Rafael can comment on it.
> > > >
> > > > Raag
> > >
> > > From the driver perspective it does have expectations that the parts =
outside
> > > the driver did the right thing.  If the driver was expecting the root=
 port
> > > to be powered down at suspend and it wasn't there are hardware compon=
ents
> > > that didn't power cycle and that's what we're seeing here.
> >
> > Which means the expectation set by the driver is the opposite of the
> > purpose of this patch, and it's going to fail if any kind of error is
> > detected under root port during suspend.
>
> And IMV this driver's expectation is questionable at least.
>
> There is no promise whatsoever that the device will always be put into
> D3cold during system suspend.

For instance, user space may disable D3cold for any PCI device via the
d3cold_allowed attribute in sysfs.

If the driver cannot handle this, it needs to be fixed.
