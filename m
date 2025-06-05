Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B7EC5AE59
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 12:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E8710E84C;
	Thu,  5 Jun 2025 12:26:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O+zn3CsB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A98E10E84C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 12:26:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4BE86614B8
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 12:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C84C4CEF2
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 12:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749126377;
 bh=4WJhgjAnEtUFXmL2GWy4353pkE5BMV7J2KFQCgkngak=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=O+zn3CsBROu139GaMTH2Gt5k+eiWkb+LdTiPJmFaaOamXAjtOUN2p1QqF2r1/p/cn
 VMtS9KbPYXgnkmyY91qnrOJgUuCE6Nz/jVDquP4uDqCT2YjbUyKbcmz4nmH/2V20Ia
 SY/5Xn9zaMjMxN7RZ0rNyMrr4YqZA7KUWNYWr2+C24+Uja5xkGBMZoPPkqbyGTCFTj
 tp2WB/UCOxYbEm+PWKaWLuoqMjdI5gGhVPdBsfOM0nK/q67r7oor+COShHn/NtCtfi
 EOv43U2jlakyV5dKfpBsOEzzwRee6ijbSsQji6AM+0irX9rOQd8GuWZ922nqDWPZmO
 PixHwvdpR+6Xg==
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-2c76a1b574cso321499fac.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Jun 2025 05:26:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUHftO6O+VqVbp8FkwSvibpgvSP1ThfAcaXid4DJaU7a5DDkfypmIuiRI9Yv3sKdMiOz3WcjT+p@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPHa/UHNxb6ThD03NkQBMyZljXWeDz1YJyeJqF2k6efZUMAzCw
 ngAhRCf+kWl3V2TGABXc5X8z1ccGN6z/4BURl61tzwVReeEUVVkWNM4VRjC45AhAo13ngld1GgW
 PdpOhAJ2OkhRg994VMsDjusU1eKHxdus=
X-Google-Smtp-Source: AGHT+IEwbhB9q1U38/ArzbcpRN42CjSWVC8jtUlFCNmZf81r5ZGmE3b9Dt8Woywq+2BbQRtB4ZT/AhAYyuYovBSyi2U=
X-Received: by 2002:a05:6870:8e07:b0:2d6:2a40:fbe7 with SMTP id
 586e51a60fabf-2e9bf31d024mr4658964fac.6.1749126377202; Thu, 05 Jun 2025
 05:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <6f23d82c-10cc-4d70-9dce-41978b05ec9a@kernel.org>
 <aCzNL9uXGbBSdF2S@black.fi.intel.com>
 <fea86161-2c47-4b0f-ac07-b3f9b0f10a03@kernel.org>
 <aC2UzG-eycjqYQep@black.fi.intel.com>
 <CAJZ5v0gRFwKhq21ima3kT0zzFLk4=47ivvzJqARksV7nYHTJAQ@mail.gmail.com>
 <CAJZ5v0h9--jFVBtQ5F7Gee3Cy8P3TeSLdiHEWykQ=EsZdoffmg@mail.gmail.com>
 <aDnpfKvLwRZsKxhH@black.fi.intel.com>
 <CAJZ5v0gjA2B4AnaYpfYpaNDo49k4LM2FGSrPFFuOCJ62bCMmkA@mail.gmail.com>
 <aEBpdwMfxp5M4Hxr@black.fi.intel.com>
 <CAJZ5v0hhoh0Fqnph6ZcbyZBj1Wp0t8UqnLr27TAVW31ZyKPL3Q@mail.gmail.com>
 <aEGDL0IF10QX3Abr@black.fi.intel.com>
In-Reply-To: <aEGDL0IF10QX3Abr@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Jun 2025 14:26:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hJbKEJKRKv67bcQaHbL7h5e_WDGNPg4BA_P4JY-mk_nw@mail.gmail.com>
X-Gm-Features: AX0GCFszkKfoW0b4kUz_tjavfz2i9S_MK1cS4vEFCRJbyuk-B48Ya0tiCbJ8hOg
Message-ID: <CAJZ5v0hJbKEJKRKv67bcQaHbL7h5e_WDGNPg4BA_P4JY-mk_nw@mail.gmail.com>
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

On Thu, Jun 5, 2025 at 1:44=E2=80=AFPM Raag Jadav <raag.jadav@intel.com> wr=
ote:
>
> On Wed, Jun 04, 2025 at 08:19:34PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 4, 2025 at 5:43=E2=80=AFPM Raag Jadav <raag.jadav@intel.com=
> wrote:
> > > On Fri, May 30, 2025 at 07:49:26PM +0200, Rafael J. Wysocki wrote:
> > > > On Fri, May 30, 2025 at 7:23=E2=80=AFPM Raag Jadav <raag.jadav@inte=
l.com> wrote:
> > > > > On Fri, May 23, 2025 at 05:23:10PM +0200, Rafael J. Wysocki wrote=
:
> > > > > > On Wed, May 21, 2025 at 1:27=E2=80=AFPM Rafael J. Wysocki <rafa=
el@kernel.org> wrote:
> > > > > > > On Wed, May 21, 2025 at 10:54=E2=80=AFAM Raag Jadav <raag.jad=
av@intel.com> wrote:
> > > > > > > > On Tue, May 20, 2025 at 01:56:28PM -0500, Mario Limonciello=
 wrote:
> > > > > > > > > On 5/20/2025 1:42 PM, Raag Jadav wrote:
> > > > > > > > > > On Tue, May 20, 2025 at 12:39:12PM -0500, Mario Limonci=
ello wrote:
> > >
> > > ...
> > >
> > > > > > > > > From the driver perspective it does have expectations tha=
t the parts outside
> > > > > > > > > the driver did the right thing.  If the driver was expect=
ing the root port
> > > > > > > > > to be powered down at suspend and it wasn't there are har=
dware components
> > > > > > > > > that didn't power cycle and that's what we're seeing here=
.
> > > > > > > >
> > > > > > > > Which means the expectation set by the driver is the opposi=
te of the
> > > > > > > > purpose of this patch, and it's going to fail if any kind o=
f error is
> > > > > > > > detected under root port during suspend.
> > > > > > >
> > > > > > > And IMV this driver's expectation is questionable at least.
> > > > > > >
> > > > > > > There is no promise whatsoever that the device will always be=
 put into
> > > > > > > D3cold during system suspend.
> > > > > >
> > > > > > For instance, user space may disable D3cold for any PCI device =
via the
> > > > > > d3cold_allowed attribute in sysfs.
> > > > > >
> > > > > > If the driver cannot handle this, it needs to be fixed.
> > > > >
> > > > > Thanks for confirming. So should we consider this patch to be val=
id
> > > > > and worth moving forward?
> > > >
> > > > It doesn't do anything that would be invalid in principle IMV.
> > > >
> > > > You need to consider one more thing, though: It may be necessary to
> > > > power-cycle the device in order to kick it out of the erroneous sta=
te
> > > > and the patch effectively blocks this if I'm not mistaken.
> > > >
> > > > But admittedly I'm not sure if this really matters.
> > >
> > > Wouldn't something like bus reset (SBR) be more predictable?
> >
> > Maybe.
> >
> > The device state is most likely inconsistent in that case, so it depend=
s.
>
> My limited understanding is that if SBR doesn't help, at that point all
> bets are off including PMCSR configuration and probably a cold boot is
> needed.

I'm not talking about PMCSR, I'm talking about power removal (D3cold).
This should be equivalent to a cold boot for the particular device
except that cold boot would also reset the hierarchy above it.
