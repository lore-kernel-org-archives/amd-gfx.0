Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD3CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 07:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B2B310E61E;
	Fri, 10 Dec 2021 07:19:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CB910E61E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 07:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639120774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xIuU9cNPwfmUgDmeC7P+PpkBhwlP92g1vruFU5WPOts=;
 b=JjW6DMY+pQ0QCacOWlARFVaFXE5sjnErRgWi0FQJF0xsEuo8zpGkkiT6ByQHIHf+dIINH3
 tEFD2KnXAfk9LC4gY/hstZVEvVTYbaN3eAoXqf24eTUaaMJKztgJKgqL/GWOrMyNlpAomd
 wEEO5rSG22OgFNAjgYhnNN7mD9TmwHE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-174-7GsQF46PO4KbUQg82WERKA-1; Fri, 10 Dec 2021 02:19:31 -0500
X-MC-Unique: 7GsQF46PO4KbUQg82WERKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CADF5100C660;
 Fri, 10 Dec 2021 07:19:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23AB519C59;
 Fri, 10 Dec 2021 07:19:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8FC981800397; Fri, 10 Dec 2021 08:19:14 +0100 (CET)
Date: Fri, 10 Dec 2021 08:19:14 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
Message-ID: <20211210071914.n4l2mdknbv3yeqtq@sirius.home.kraxel.org>
References: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
 <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
 <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com>
 <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
 <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
 xinhui pan <Xinhui.Pan@amd.com>, Baoquan He <bhe@redhat.com>,
 Samuel Iglesias =?utf-8?Q?Gons=C3=A1lvez?= <siglesias@igalia.com>,
 kernel@gpiccoli.net, kexec@lists.infradead.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, pjones@redhat.com,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>, Dave Young <dyoung@redhat.com>,
 Christian Koenig <christian.koenig@amd.com>, Vivek Goyal <vgoyal@redhat.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

  Hi,

> > The drivers are asic and platform specific.  E.g., the driver for
> > vangogh is different from renoir is different from skylake, etc.  The
> > display programming interfaces are asic specific.
> 
> Cool, that makes sense! But if you (or anybody here) know some of these
> GOP drivers, e.g. for the qemu/qxl device,

OvmfPkg/QemuVideoDxe in tianocore source tree.

> I'm just curious to see/understand how complex is the FW driver to
> just put the device/screen in a usable state.

Note that qemu has a paravirtual interface for vesa vga mode programming
where you basically program a handful of registers with xres, yres,
depth etc. (after resetting the device to put it into vga compatibility
mode) and you are done.

Initializing physical hardware is an order of magnitude harder than
that.

With qxl you could also go figure the current state of the hardware and
fill screen_info with that to get a working boot framebuffer in the
kexec'ed kernel.

Problem with this approach is this works only in case the framebuffer
happens to be in a format usable by vesafb/efifb.  So no modifiers
(tiling etc.) and continuous in physical address space.  That is true
for qxl.  With virtio-gpu it wouldn't work though (framebuffer can be
scattered), and I expect with most modern physical hardware it wouldn't
work either.

take care,
  Gerd

