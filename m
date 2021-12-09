Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E80C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 848BE10E5E7;
	Thu,  9 Dec 2021 16:53:10 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23F810E939
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 05:52:50 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id o4so7255314oia.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Dec 2021 21:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c+9uD9OWRDFrlyLRWZeGp6wRYESuGpG+9RAJOoYnaEM=;
 b=GvCL7ltKG2075eZYwhoFp7JGOXvIiIex2kv+u0KDr1enlJ2qIzQhRaAzVsac0+vY6/
 Tis16cPfhexSL4zEXNSlEiMblrCxUJm0DJmxNr+GY7fgYSiJNgHPlSqF1E8uq3zYFVIs
 GnqZzHxD0cIGauOLegV5BUYyNlsJa7kvIn3tCQ/EYwOK7OEGHA9y/O9ystJzMnuAMXyy
 QnFqRcXebV8d7UafsNaMpi5hoK/e32BFG5o/eVYoltXlTt/V1FjXVY7eFcqNLwQQsy/i
 6V6I6j0gQzRX/Y0fVWJmn3X3sJP1Z0cQxlaIcgX1Z6y4wxN79W45vmpI1c1hMCFZPPNp
 lZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c+9uD9OWRDFrlyLRWZeGp6wRYESuGpG+9RAJOoYnaEM=;
 b=Ab4zvimG0eYX+d98H4cxRXs4yhKm6WfedVp3RapRsOraeUfEzL7eHGMIPAvfSGHqMd
 hGx99epsJTP6XAJWDFel6wIeZCm498xJ5/1b7IGboWUHo4alID4HA2TwW8puMNqpZBey
 B/6gha0GWZ+jVzurfu4toLrz5z4n7Yya5MBapAqRq2ctlomJGlQn5/4sE/sE980KOwUB
 lvdVCsgh5x5R9Y3QTTSAgohnKJ+s3yjPx6XlLA77GxyflFgLOud6Bfzu6HsVLAuo377/
 ML0MQLWMmQOcLIbi3hdRSZVGVj2M/9RuCY9rzl3bsDV1z7BtRH/oXrAv97C5mITOVOVL
 SM0Q==
X-Gm-Message-State: AOAM531dqSKclUrv0qDlKe1SX502CxSXU41m7Zl/xRmS2Ar7Jf8sN5k4
 K55gnYc2ZFkHb1yIWA8dx6JUqM2arU0xkqcAPQqxM1Jq8qY=
X-Google-Smtp-Source: ABdhPJxLM3ix5hRN+yK/3mLrp+9KeLDyJ91CVdmPFzgj4qJuXueAPCdPuhxZuRnMjdxfCgcwVs4XXL8tikK5StzoLQA=
X-Received: by 2002:a05:6808:300b:: with SMTP id
 ay11mr3734832oib.120.1639025388738; 
 Wed, 08 Dec 2021 20:49:48 -0800 (PST)
MIME-Version: 1.0
References: <CADnq5_MQnX6dRJ4-YHjWaSS5PYb1f6BQ4FXNkw9wzDmwQarkrA@mail.gmail.com>
 <662096311.37428400.1638914853388.JavaMail.root@zimbra39-e7>
In-Reply-To: <662096311.37428400.1638914853388.JavaMail.root@zimbra39-e7>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Dec 2021 23:49:37 -0500
Message-ID: <CADnq5_MpXRbKBVQ-8uRJPncHO_2byVmhHZxb95=Hff6Anuqa3g@mail.gmail.com>
Subject: Re: gpu block diagram
To: Yann Dirson <ydirson@free.fr>
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
Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 7, 2021 at 5:07 PM Yann Dirson <ydirson@free.fr> wrote:
>
> Thanks for the details Alex!
>
> Here is an attempt to formalize the decomposition of a
> (mostly Renoir) APU, using plantuml.  That's highly preliminary,
> focusing on blocks/sub-blocks/firmware, based on my current
> partial (and surely incorrect at places) understanding.
> I focused on getting contents quickly, so the formalism itself
> is shaky.
>
> Can you spot any error ?  Fill those holes (usually marked with
> "?") ?  What additional blocks would make sense (caches at least,
> I guess) ?  What additional information would help understand how
> they work together (control/data flows, busses...) ?

Each asic is a collection of hardware blocks.  We refer to them as
"IPs" (Intellectual Property blocks).  Each IP encapsulates certain
functionality. IPs are versioned and can also be mixed and matched.
E.g., you might have two different asics that both have SDMA 5.x IPs.
The driver is arranged by IPs.  There are driver components to handle
the initialization and operation of each IP.  There are also a bunch
of smaller IPs that don't really need much if any driver interaction.
Those end up getting lumped into the common stuff in the soc files.
The soc files (e.g., vi.c, soc15.c nv.c) contain code for aspects of
the SoC itself rather than specific IPs.  E.g., things like GPU resets
and register access functions are SoC dependent.

An APU contains more than just CPU and GPU, it also contains all of
the platform stuff (audio, usb, gpio, etc.).  Also, a lot of
components are shared between the CPU, platform, and the GPU (e.g.,
SMU, PSP, etc.).  Specific components (CPU, GPU, etc.) usually have
their interface to interact with those common components.  For things
like S0i3 there is a ton of coordination required across all the
components, but that is probably a bit beyond the scope of this
thread.

With respect to the GPU, we have the following major IPs:

1. GMC (Graphics Memory Controller).  This was a dedicated IP on older
pre-vega chips, but has since become somewhat decentralized on vega
and newer chips.  They now have dedicated memory hubs for specific IPs
or groups of IPs.  We still treat it as a single component in the
driver however since the programming model is still pretty similar.
This is how the different IPs on the GPU get the memory (VRAM or
system memory).  It also provides the support for per process GPU
virtual address spaces.
2. IH (Interrupt Handler).  This is the interrupt controller on the
GPU.  All of the IPs feed their interrupts into this IP and it
aggregates them into a set of ring buffers that the driver can parse
to handle interrupts from different IPs.
3. PSP (Platform Security Processor).  This handles security policy
for the SoC and executes trusted applications, and validates and loads
firmwares for other blocks.
4. SMU (System Management Unit).  This is the power management
microcontroller.  It manages the entire SoC.  The driver interacts
with it to control power management features like clocks, voltages,
power rails, etc.
5. DCN (Display Controller Next).  This is the display controller.  It
handles the display hardware.
6. SDMA (System DMA).  This is a multi-purpose DMA engine.  The kernel
driver uses it for various things including paging and GPU page table
updates.  It's also exposed to userspace for use by user mode drivers
(OpenGL, Vulkan, etc.)
7. GC (graphics and Compute).  This is the graphics and compute
engine, i.e., the block that encompasses the 3D pipeline and and
shader blocks.  The is by far the largest block on the GPU.  The 3D
pipeline has tons of sub-blocks.  In addition to that, it also
contains the CP microcontrollers (ME, PFP, CE, MEC) and the RLC
microcontroller.  It's exposed to userspace for user mode drivers
(OpenGL, Vulkan, OpenCL, etc.)
7. VCN (Video Core Next).  This is the multi-media engine.  It handles
video and image encode and decode.  It's exposed to userspace for user
mode drivers (VA-API, OpenMAX, etc.)

In general, the driver has a list of all of the IPs on a particular
SoC and for things like init/fini/suspend/resume, more or less just
walks the list and handles each IP.

Alex


>
> Indentation is shaky too, better format it to read (e.g. by
> pasting in http://www.plantuml.com/plantuml/uml/)
>
> ------ >8 -------
> @startuml
> package "APU" {
>  package CPU {
>  }
>  package GPU {
>   package common? [[{"GPU Family"?}]] {
>   }
>   package GFX [[{Graphics and Compute Engine}]] {
>    package CP [[{Command Processor}]] {
>     package PFP [[{MicroEngine Compute}]] {
>       package "pfp fw" #cccccc {
>       }
>     }
>     package ME [[{MicroEngine ?}]] {
>       package "me fw" #cccccc {
>       }
>     }
>     package CE [[{?}]] {
>       package "ce fw" #cccccc {
>       }
>     }
>     package MEC [[{MicroEngine Compute}]] {
>       package "mec fw" #cccccc {
>       }
>       package "mec2 fw?" #cccccc {
>       }
>     }
>    }
>    package RLC [[{RunList Controller (pm)}]] {
>       package "rlc fw" #cccccc {
>       }
>    }
>   }
>
>   package '"management"'<<Cloud>>  {
>   package MES [[{Micro-Engine Scheduler}]] {
>   }
>   package SMU [[{System Mamagement Unit}]] {
>   }
>   package PSP [[{Platform Security Processor}]] {
>     package "asd fw" #cccccc {
>     }
>     package "ta fw" #cccccc {
>     }
>   }
>
>   package IH [[{Interrupt Handler}]] {
>   }
>   package GMC [[{Graphics Memory Controller}]] {
>   }
>   package SDMA [[{System DMA}]] {
>     package "sdma fw" #cccccc {
>     }
>   }
>   }
>
>   package DM [[{Display Manager, link to...}]] {
>    package "DMUB? DMU?" [[{Display Micro-Controller Unit}]] {
>     package "dmcub fw" #cccccc {
>     }
>    }
>    package ... {
>    }
>   }
>
>   package multimedia <<Cloud>> {
>    package .... {
>    }
>    package VCN {
>     package "vcn fw" #cccccc {
>     }
>    }
>    package JPEG {
>    }
>   }
>  }
> }
> @enduml
> ------ >8 -------
