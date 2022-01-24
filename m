Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B14BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 17:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF4C910E349;
	Mon, 24 Jan 2022 17:30:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDD8D10E198
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 17:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643045453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dgmheP820PSeiT2ULGO4Onqs77vyCkC2g7OOa3oPHLc=;
 b=NhTS1YswEsrD34u7lozDjjXt3XS25arLkhk/wQuIH2hWZ7gYXruevf4e/SSxJcj/hooTUm
 kv5uF262WjAyGfLEk80r0LzUMheiZXS4BrAoVaNf+f+vW7SSuaW/HOkcTyGiKw/bZClAjt
 3gDLm4MHDYBG3h3CAVw0qEHslQD9sgI=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-JBY-vinHM6aw2e1_ZaQW-A-1; Mon, 24 Jan 2022 12:30:52 -0500
X-MC-Unique: JBY-vinHM6aw2e1_ZaQW-A-1
Received: by mail-oi1-f200.google.com with SMTP id
 s127-20020aca5e85000000b002c807e9c48aso9478952oib.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 09:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dgmheP820PSeiT2ULGO4Onqs77vyCkC2g7OOa3oPHLc=;
 b=0NsWmu78Wb7GIQ8ot1Ckwwqd0OqECOqQvz1+PgwXqM2mOuhCYgUmpkcQWr2l3zS7i5
 c99jVi6MtEkI/OA+1BsEWJLrqYi0tSsTJ7U2lsk5tF4OkaE6kdTJ0lU0rRG1mWoLygVe
 HJKxi2skaVRAcDRdoD8wVniUDPH2u5WfzkA2496375l02nVMOWpicJBI9WsHFzNLu9Cf
 EbGEhxeXbSvBkrA+amYbd4vw+bEf5DrVuFXHCQzk0ACiZeNQoECHMJKm4BK8TngelPN5
 AH8VfHKZnKAspzu8i94b4xtCgX/8gBm++WPDaXKEONylgRS0Q2+TeEu3KBpggKkATo5B
 RQ3Q==
X-Gm-Message-State: AOAM533B5zBVzsS97g7ALPvGgfbA4iDogjwbpTvQXwdYvPWHktoDhFHG
 7ScU66HDDiAL45RIXmeWwbRRBU7Fn1S44L49iosASZRP1oAIBMQ7HZYDlylVi0RDPmGu5LnCUHa
 UnxvFthALsg0dVUeeY8eQ0CxvDQ==
X-Received: by 2002:a05:6830:1e89:: with SMTP id
 n9mr9311770otr.304.1643045451896; 
 Mon, 24 Jan 2022 09:30:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNbG8a1p/Pz9Hx4D54aH1sfIRemdv4XTKC6BeBEnOC4SSSFVBa1s73P8JKhNP8tqDgM4SGJw==
X-Received: by 2002:a05:6830:1e89:: with SMTP id
 n9mr9311753otr.304.1643045451658; 
 Mon, 24 Jan 2022 09:30:51 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
 by smtp.gmail.com with ESMTPSA id bj19sm6167338oib.9.2022.01.24.09.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jan 2022 09:30:51 -0800 (PST)
Date: Mon, 24 Jan 2022 10:30:50 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [REGRESSION] Too-low frequency limit for AMD GPU
 PCI-passed-through to Windows VM
Message-ID: <20220124103050.0229ae92.alex.williamson@redhat.com>
In-Reply-To: <CADnq5_P5RAJxKWCQBmJae8eWjJ5_wPG01uJYOpXMGsieWqUDvw@mail.gmail.com>
References: <87ee57c8fu.fsf@turner.link>
 <acd2fd5e-d622-948c-82ef-629a8030c9d8@leemhuis.info>
 <87a6ftk9qy.fsf@dmarc-none.turner.link>
 <87zgnp96a4.fsf@turner.link>
 <fc2b7593-db8f-091c-67a0-ae5ffce71700@leemhuis.info>
 <CADnq5_Nr5-FR2zP1ViVsD_ZMiW=UHC1wO8_HEGm26K_EG2KDoA@mail.gmail.com>
 <87czkk1pmt.fsf@dmarc-none.turner.link>
 <BYAPR12MB46140BE09E37244AE129C01A975C9@BYAPR12MB4614.namprd12.prod.outlook.com>
 <87sftfqwlx.fsf@dmarc-none.turner.link>
 <CADnq5_P5RAJxKWCQBmJae8eWjJ5_wPG01uJYOpXMGsieWqUDvw@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Greg KH <gregkh@linuxfoundation.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 James Turner <linuxkernel.foss@dmarc-none.turner.link>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, 24 Jan 2022 12:04:18 -0500
Alex Deucher <alexdeucher@gmail.com> wrote:

> On Sat, Jan 22, 2022 at 4:38 PM James Turner
> <linuxkernel.foss@dmarc-none.turner.link> wrote:
> >
> > Hi Lijo,
> >  
> > > Could you provide the pp_dpm_* values in sysfs with and without the
> > > patch? Also, could you try forcing PCIE to gen3 (through pp_dpm_pcie)
> > > if it's not in gen3 when the issue happens?  
> >
> > AFAICT, I can't access those values while the AMD GPU PCI devices are
> > bound to `vfio-pci`. However, I can at least access the link speed and
> > width elsewhere in sysfs. So, I gathered what information I could for
> > two different cases:
> >
> > - With the PCI devices bound to `vfio-pci`. With this configuration, I
> >   can start the VM, but the `pp_dpm_*` values are not available since
> >   the devices are bound to `vfio-pci` instead of `amdgpu`.
> >
> > - Without the PCI devices bound to `vfio-pci` (i.e. after removing the
> >   `vfio-pci.ids=...` kernel command line argument). With this
> >   configuration, I can access the `pp_dpm_*` values, since the PCI
> >   devices are bound to `amdgpu`. However, I cannot use the VM. If I try
> >   to start the VM, the display (both the external monitors attached to
> >   the AMD GPU and the built-in laptop display attached to the Intel
> >   iGPU) completely freezes.
> >
> > The output shown below was identical for both the good commit:
> > f1688bd69ec4 ("drm/amd/amdgpu:save psp ring wptr to avoid attack")
> > and the commit which introduced the issue:
> > f9b7f3703ff9 ("drm/amdgpu/acpi: make ATPX/ATCS structures global (v2)")
> >
> > Note that the PCI link speed increased to 8.0 GT/s when the GPU was
> > under heavy load for both versions, but the clock speeds of the GPU were
> > different under load. (For the good commit, it was 1295 MHz; for the bad
> > commit, it was 501 MHz.)
> >  
> 
> Are the ATIF and ATCS ACPI methods available in the guest VM?  They
> are required for this platform to work correctly from a power
> standpoint.  One thing that f9b7f3703ff9 did was to get those ACPI
> methods executed on certain platforms where they had not been
> previously due to a bug in the original implementation.  If the
> windows driver doesn't interact with them, it could cause performance
> issues.  It may have worked by accident before because the ACPI
> interfaces may not have been called, leading the windows driver to
> believe this was a standalone dGPU rather than one integrated into a
> power/thermal limited platform.

None of the host ACPI interfaces are available to or accessible by the
guest when assigning a PCI device.  Likewise the guest does not have
access to the parent downstream ports of the PCIe link.  Thanks,

Alex

