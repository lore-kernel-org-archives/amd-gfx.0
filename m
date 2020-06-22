Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC39C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 09:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62432206F1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 09:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YwuSPeN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62432206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F25D86E14D;
	Mon, 22 Jun 2020 09:46:59 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 013C16E13B
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 09:46:58 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id 17so479071wmo.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 02:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=miFL2961FbncsSScUNeK360vgCDlWzuEunNQejl5RPM=;
 b=YwuSPeN3ZvN7UaijlAaE6eayg9M9jTGKQ50rQ0CXlUMIjgPT3KKdPoHZHXSsiyQme1
 jTAvdlJPtFl9FiMvQLfx5NL/CZ3ZcDlfMhlCdbGSpeBSSTjD3NZilT/lspxiF42xDwGw
 KAk8wrI81KOvQViRMejKa2DxRS0/IrfJhJAqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=miFL2961FbncsSScUNeK360vgCDlWzuEunNQejl5RPM=;
 b=rQILtAjqBPfVntGXXGC45SAO9O2sF3MPS+cP4G10rPiyS7FCP6giBOIi9tq1xTyQ9H
 WGplqqZoW5WuO0ZMqcccbRTJlSusU+mvbqsKVyDHlNpuE7LQDSH5XRUKt129IHST4wk7
 EnF/hu7zQ8HjpF1N5M1BzhB/PC4q3z04IzE0IIndtNuyfHbb3NwywErLt8KhkUI4UPNm
 g9D3hJ+ybkHbrZjobptfCgEIB08BAaoccdvwstnLg9iJ/Ciu/WgZS5B1V8opHEuIeJxi
 SJw3Y5kMMquTuHPpsjkmquv42xync8U2Yf7HQydYt98JHBzUVRsSS9I1Jen9HXhKaE/C
 HKeg==
X-Gm-Message-State: AOAM533thxpN+O4FjAxcfUjgSLDPW0bUR5TEqcbUCdg+MyLQ+1H1m48y
 aMPQ+XaiD6gHXUQsV6HIZ5Zm3A==
X-Google-Smtp-Source: ABdhPJyOyy0GLvbc2/RmwDCo+XeRVGIipqXPcMIMIBQpR2iTAL9ZvsWDzrV/SOt9m/Dle6OpXYwFjQ==
X-Received: by 2002:a1c:2485:: with SMTP id
 k127mr14952635wmk.138.1592819217607; 
 Mon, 22 Jun 2020 02:46:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id c65sm15927903wme.8.2020.06.22.02.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 02:46:57 -0700 (PDT)
Date: Mon, 22 Jun 2020 11:46:55 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: Re: [PATCH v2 0/8] RFC Support hot device unplug in amdgpu
Message-ID: <20200622094655.GC20149@phenom.ffwll.local>
References: <1592719388-13819-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1592719388-13819-1-git-send-email-andrey.grodzovsky@amd.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
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
Cc: daniel.vetter@ffwll.ch, michel@daenzer.net, dri-devel@lists.freedesktop.org,
 ppaalanen@gmail.com, amd-gfx@lists.freedesktop.org,
 ckoenig.leichtzumerken@gmail.com, alexdeucher@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Jun 21, 2020 at 02:03:00AM -0400, Andrey Grodzovsky wrote:
> This RFC is more of a proof of concept then a fully working solution as t=
here are a few unresolved issues we are hoping to get advise on from people=
 on the mailing list.
> Until now extracting a card either by physical extraction (e.g. eGPU with=
 thunderbolt connection or by emulation through syfs -> /sys/bus/pci/device=
s/device_id/remove)
> would cause random crashes in user apps. The random crashes in apps were =
mostly due to the app having mapped a device backed BO into its address spa=
ce was still
> trying to access the BO while the backing device was gone.
> To answer this first problem Christian suggested to fix the handling of m=
apped memory in the clients when the device goes away by forcibly unmap all=
 buffers
> the user processes has by clearing their respective VMAs mapping the devi=
ce BOs. Then when the VMAs try to fill in the page tables again we check in=
 the fault handler
> if the device is removed and if so, return an error. This will generate a=
 SIGBUS to the application which can then cleanly terminate.
> This indeed was done but this in turn created a problem of kernel OOPs we=
re the OOPSes were due to the fact that while the app was terminating becau=
se of the SIGBUS
> it would trigger use after free in the driver by calling to accesses devi=
ce structures that were already released from the pci remove sequence.
> This was handled by introducing a 'flush' sequence during device removal =
were we wait for drm file reference to drop to 0 meaning all user clients d=
irectly using this device terminated.
> With this I was able to cleanly emulate device unplug with X and glxgears=
 running and later emulate device plug back and restart of X and glxgears.
> =

> v2:
> Based on discussions in the mailing list with Daniel and Pekka [1] and ba=
sed on the document produced by Pekka from those discussions [2] the whole =
approach with returning SIGBUS
> and waiting for all user clients having CPU mapping of device BOs to die =
was dropped. Instead as per the document suggestion the device structures a=
re kept alive until the last
> reference to the device is dropped by user client and in the meanwhile al=
l existing and new CPU mappings of the BOs belonging to the device directly=
 or by dma-buf import are rerouted
> to per user process dummy rw page.
> Also, I skipped the 'Requirements for KMS UAPI' section of [2] since i am=
 trying to get the minimal set of requiremnts that still give useful soluti=
on to work and this is the
> 'Requirements for Render and Cross-Device UAPI' section and so my test ca=
se is removing a secondary device, which is render only and is not involved=
 in KMS.
>  =

> This iteration is still more of a draft as I am still facing a few unsolv=
ed issues such as a crash in user client when trying to CPU map imported BO=
 if the map happens after device was
> removed and HW failure to plug back a removed device. Also since i don't =
have real life setup with external GPU connected through TB I am using sysf=
s to emulate pci remove and i
> expect to encounter more issues once i try this on real life case. I am a=
lso expecting some help on this from a user who volunteered to test in the =
related gitlab ticket.
> So basically this is more of a  way to get feedback if I am moving in the=
 right direction.
> =

> [1] - Discussions during v1 of the patchset https://lists.freedesktop.org=
/archives/dri-devel/2020-May/265386.html
> [2] - drm/doc: device hot-unplug for userspace https://www.spinics.net/li=
sts/dri-devel/msg259755.html
> [3] - Related gitlab ticket https://gitlab.freedesktop.org/drm/amd/-/issu=
es/1081

A few high-level commments on the generic parts, I didn't really look at
the amdgpu side yet.

Also a nit: Please tell your mailer to break long lines, it looks funny
and inconsistent otherwise, at least in some of the mailers I use here :-/
-Daniel
> =A0
> =

> Andrey Grodzovsky (8):
>   drm: Add dummy page per device or GEM object
>   drm/ttm: Remap all page faults to per process dummy page.
>   drm/ttm: Add unampping of the entire device address space
>   drm/amdgpu: Split amdgpu_device_fini into early and late
>   drm/amdgpu: Refactor sysfs removal
>   drm/amdgpu: Unmap entire device address space on device remove.
>   drm/amdgpu: Fix sdma code crash post device unplug
>   drm/amdgpu: Prevent any job recoveries after device is unplugged.
> =

>  drivers/gpu/drm/amd/amdgpu/amdgpu.h          | 19 +++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c |  7 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 50 +++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      | 23 ++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c  | 12 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c      | 24 ++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h      |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c      |  8 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      | 23 +++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c      |  8 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c      |  3 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c  | 21 ++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 17 +++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c     | 13 +++++-
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c         | 10 +++--
>  drivers/gpu/drm/drm_file.c                   |  8 ++++
>  drivers/gpu/drm/drm_prime.c                  | 10 +++++
>  drivers/gpu/drm/ttm/ttm_bo.c                 |  8 +++-
>  drivers/gpu/drm/ttm/ttm_bo_vm.c              | 65 ++++++++++++++++++++++=
++----
>  include/drm/drm_file.h                       |  2 +
>  include/drm/drm_gem.h                        |  2 +
>  include/drm/ttm/ttm_bo_driver.h              |  7 +++
>  22 files changed, 286 insertions(+), 55 deletions(-)
> =

> -- =

> 2.7.4
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
