Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D351DC5B549
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 18:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F45110E782;
	Wed,  4 Jun 2025 18:19:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f0g3rxno";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1439410E782
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 18:19:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 04AACA5071D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 18:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991E5C4CEF0
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 18:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749061186;
 bh=HEARLMHSlGAJvxpt66oclxxZn67jUYESwoOn9OnHHSs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=f0g3rxnon+OGy8uW/iBIcJwV9YE3hO0oHNm6DDZ55HCCz/LTH/+bD0xMJF6BurkaC
 /Rr9eRIrxbTkEJGbzLfmQBNf+cUNufZb7M47RX0Xik1voyeJTnBbwDHWSaTRxU5brb
 44/UFu9+0KAecoLEoobh5H18cmwR9thpc0TMefFNW66Y2Uz0uA4rjJB65IMMktbAYm
 RpEpzRYzxTSZMTJUiZjEsk2vuZ8DMG1h9i+FewdeKvrnr72COBjhF2fe74JMn6F3nE
 iiA7ouEZFfzRDUqFmY8vZ+PsMs4/NU7j8MljD036etrx2sshzectjBaMg58McQOCzR
 dpgcLnHOwVK2A==
Received: by mail-oi1-f177.google.com with SMTP id
 5614622812f47-401c43671ecso132446b6e.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Jun 2025 11:19:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWwUWsrwyBCwjtYn1TzxXHPHyl1Hl71jARz41N7oUpUzkcHKpXScOBU86TA4G9d7GQbSf4mRE9/@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKjQwYDcK4JzxVfgTLZKQ3AQy67E91RQ54FCU1PCv52+kwnZW5
 urnZw4n+DoxyoUAGVqDJObjAB2giwrokrBxrOfNMFnZTUYBuHbHi0gkJ6iSCoxvouB1woIofjBo
 VMKmGvlq4Ae871HFe290mShSmQ/W2P7o=
X-Google-Smtp-Source: AGHT+IFzTiHFsMcNwEDy6J6DzLls3gsM6anKsUoGKN8wkS7W1gW9kVqAPb6jp1/ZPEVu8ZqkTyPj+gUXdCirNDH6nRE=
X-Received: by 2002:a05:6808:22a2:b0:3f3:d699:e1a8 with SMTP id
 5614622812f47-408fac108c5mr484765b6e.13.1749061185873; Wed, 04 Jun 2025
 11:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <552d75b2-2736-419f-887e-ce2692616578@kernel.org>
 <ee1117cf-6367-4e9a-aa85-ccfc6c63125d@gmail.com>
 <6f23d82c-10cc-4d70-9dce-41978b05ec9a@kernel.org>
 <aCzNL9uXGbBSdF2S@black.fi.intel.com>
 <fea86161-2c47-4b0f-ac07-b3f9b0f10a03@kernel.org>
 <aC2UzG-eycjqYQep@black.fi.intel.com>
 <CAJZ5v0gRFwKhq21ima3kT0zzFLk4=47ivvzJqARksV7nYHTJAQ@mail.gmail.com>
 <CAJZ5v0h9--jFVBtQ5F7Gee3Cy8P3TeSLdiHEWykQ=EsZdoffmg@mail.gmail.com>
 <aDnpfKvLwRZsKxhH@black.fi.intel.com>
 <CAJZ5v0gjA2B4AnaYpfYpaNDo49k4LM2FGSrPFFuOCJ62bCMmkA@mail.gmail.com>
 <aEBpdwMfxp5M4Hxr@black.fi.intel.com>
In-Reply-To: <aEBpdwMfxp5M4Hxr@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Jun 2025 20:19:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hhoh0Fqnph6ZcbyZBj1Wp0t8UqnLr27TAVW31ZyKPL3Q@mail.gmail.com>
X-Gm-Features: AX0GCFsu9AnuhJSn72E2Tb6mBLfmajSBROpQVego6uWW9V1aoDEJzIL15ch0Xhg
Message-ID: <CAJZ5v0hhoh0Fqnph6ZcbyZBj1Wp0t8UqnLr27TAVW31ZyKPL3Q@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Prevent power state transition of erroneous device
To: Raag Jadav <raag.jadav@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Mario Limonciello <superm1@kernel.org>, 
 Denis Benato <benato.denis96@gmail.com>, mahesh@linux.ibm.com, oohall@gmail.com,
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

On Wed, Jun 4, 2025 at 5:43=E2=80=AFPM Raag Jadav <raag.jadav@intel.com> wr=
ote:
>
> On Fri, May 30, 2025 at 07:49:26PM +0200, Rafael J. Wysocki wrote:
> > On Fri, May 30, 2025 at 7:23=E2=80=AFPM Raag Jadav <raag.jadav@intel.co=
m> wrote:
> > > On Fri, May 23, 2025 at 05:23:10PM +0200, Rafael J. Wysocki wrote:
> > > > On Wed, May 21, 2025 at 1:27=E2=80=AFPM Rafael J. Wysocki <rafael@k=
ernel.org> wrote:
> > > > > On Wed, May 21, 2025 at 10:54=E2=80=AFAM Raag Jadav <raag.jadav@i=
ntel.com> wrote:
> > > > > > On Tue, May 20, 2025 at 01:56:28PM -0500, Mario Limonciello wro=
te:
> > > > > > > On 5/20/2025 1:42 PM, Raag Jadav wrote:
> > > > > > > > On Tue, May 20, 2025 at 12:39:12PM -0500, Mario Limonciello=
 wrote:
>
> ...
>
> > > > > > > From the driver perspective it does have expectations that th=
e parts outside
> > > > > > > the driver did the right thing.  If the driver was expecting =
the root port
> > > > > > > to be powered down at suspend and it wasn't there are hardwar=
e components
> > > > > > > that didn't power cycle and that's what we're seeing here.
> > > > > >
> > > > > > Which means the expectation set by the driver is the opposite o=
f the
> > > > > > purpose of this patch, and it's going to fail if any kind of er=
ror is
> > > > > > detected under root port during suspend.
> > > > >
> > > > > And IMV this driver's expectation is questionable at least.
> > > > >
> > > > > There is no promise whatsoever that the device will always be put=
 into
> > > > > D3cold during system suspend.
> > > >
> > > > For instance, user space may disable D3cold for any PCI device via =
the
> > > > d3cold_allowed attribute in sysfs.
> > > >
> > > > If the driver cannot handle this, it needs to be fixed.
> > >
> > > Thanks for confirming. So should we consider this patch to be valid
> > > and worth moving forward?
> >
> > It doesn't do anything that would be invalid in principle IMV.
> >
> > You need to consider one more thing, though: It may be necessary to
> > power-cycle the device in order to kick it out of the erroneous state
> > and the patch effectively blocks this if I'm not mistaken.
> >
> > But admittedly I'm not sure if this really matters.
>
> Wouldn't something like bus reset (SBR) be more predictable?

Maybe.

The device state is most likely inconsistent in that case, so it depends.
