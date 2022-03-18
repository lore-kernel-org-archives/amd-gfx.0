Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA95FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 15:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6892D10EB5D;
	Fri, 18 Mar 2022 15:26:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E4210EB60
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 15:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647617157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YgcqHRxTmDCbGkiSAVOP1j9BkIjlIyVpT+jmLkaAADU=;
 b=cNV2o/LG+1LpZ5MTmmssHJBDtAQQ2GXeeVUdjQ0rUYy6WVqkIkTMaYYrxwVSmNVRWVtOtn
 MzxfjE3hV2YsVf7kUXDKj0yTO5mKkJD8ngq1D7BqotEHY4fgLLQR6V9CenuoODT2qdrkE7
 YQmad2lRCqTWlN6j5AuOH+Xds7fQFk8=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-9O1M0A_cNeWMRMJGIbhrmg-1; Fri, 18 Mar 2022 11:25:56 -0400
X-MC-Unique: 9O1M0A_cNeWMRMJGIbhrmg-1
Received: by mail-io1-f69.google.com with SMTP id
 f11-20020a056602070b00b00645d08010fcso5279044iox.15
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 08:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=YgcqHRxTmDCbGkiSAVOP1j9BkIjlIyVpT+jmLkaAADU=;
 b=Xm2JinYysvKGBJFrl0hphy7JNa3077FUh5ia/9l2GBsJuFGXRxuZGti64bw9QfVmVH
 usoAkxiX3ZO06Yfg2MviliThqbB8UQekyB1GSg6ztkK73KpphEALTdLii8EMCa8cGQ2S
 lyNBnh/DZsToi8HKK/vEk4FT/e8r8H435/iWcKQQvyalgOFaqm3rjpAfJ6LTnZ7eT2a7
 SOqj9Uavm9vFqqLfhgau7EGhT4ho8dwDV2S6mg1yRt4hbVFYJjvPnT742RZB0HYUMJ6n
 apSkLkR+/LsWmRULa8f2sSQ/zOwUunb/Z00wMwmdUaTU/Y1MF5DhX6L+h1mbs62lv/g4
 q/oA==
X-Gm-Message-State: AOAM531lFzEjn0TjGNfsPoMuwn1tF87arJ6nWpNIU+SXXBtTW2DSyQ37
 /wu/YeIpwQAoPFQmIfPRsR2UoWfyhOnYtXDL3DI8JCzmMWdm6ui3TRwJkTBKwndjB3pOLN1Wu9B
 5xdPhE+SLvL3wDO6r3fqoy2T7aQ==
X-Received: by 2002:a5d:8714:0:b0:636:13bb:bc89 with SMTP id
 u20-20020a5d8714000000b0063613bbbc89mr4675375iom.126.1647617155689; 
 Fri, 18 Mar 2022 08:25:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcyHxS7oTYC5euABr1WRzoAYAf/D3IPiqrWGqWvUPQt0yOjkh75RYfZwdgiryk5BgacuoZcA==
X-Received: by 2002:a5d:8714:0:b0:636:13bb:bc89 with SMTP id
 u20-20020a5d8714000000b0063613bbbc89mr4675361iom.126.1647617155387; 
 Fri, 18 Mar 2022 08:25:55 -0700 (PDT)
Received: from redhat.com ([98.55.18.59]) by smtp.gmail.com with ESMTPSA id
 201-20020a6b14d2000000b00640df82a01csm4447795iou.3.2022.03.18.08.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Mar 2022 08:25:55 -0700 (PDT)
Date: Fri, 18 Mar 2022 09:25:52 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [REGRESSION] Too-low frequency limit for AMD GPU
 PCI-passed-through to Windows VM
Message-ID: <20220318092552.518a50ef.alex.williamson@redhat.com>
In-Reply-To: <CADnq5_OE7JpffYggKsu92DAjur1CCSqZQ7LbMqcfmAk68FerDA@mail.gmail.com>
References: <87ee57c8fu.fsf@turner.link>
 <87sftfqwlx.fsf@dmarc-none.turner.link>
 <BYAPR12MB4614E2CFEDDDEAABBAB986A0975E9@BYAPR12MB4614.namprd12.prod.outlook.com>
 <87ee4wprsx.fsf@turner.link>
 <4b3ed7f6-d2b6-443c-970e-d963066ebfe3@amd.com>
 <87pmo8r6ob.fsf@turner.link>
 <5a68afe4-1e9e-c683-e06d-30afc2156f14@leemhuis.info>
 <CADnq5_MCKTLOfWKWvi94Q9-d5CGdWBoWVxEYL3YXOpMiPnLOyg@mail.gmail.com>
 <87pmnnpmh5.fsf@dmarc-none.turner.link>
 <CADnq5_NG_dQCYwqHM0umjTMg5Uud6zC4=MiscH91Y9v7mW9bJA@mail.gmail.com>
 <092b825a-10ff-e197-18a1-d3e3a097b0e3@leemhuis.info>
 <877d96to55.fsf@dmarc-none.turner.link>
 <87lexdw8gd.fsf@turner.link>
 <d541b534-8b83-b566-56eb-ea8baa7c998e@leemhuis.info>
 <40b3084a-11b8-0962-4b33-34b56d3a87a3@molgen.mpg.de>
 <bc714e87-d1dc-cdda-5a29-25820faaff40@leemhuis.info>
 <20220318084625.27d42a51.alex.williamson@redhat.com>
 <CADnq5_OE7JpffYggKsu92DAjur1CCSqZQ7LbMqcfmAk68FerDA@mail.gmail.com>
Organization: Red Hat
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Lijo Lazar <lijo.lazar@amd.com>,
 kvm@vger.kernel.org, Thorsten Leemhuis <regressions@leemhuis.info>,
 Greg KH <gregkh@linuxfoundation.org>, Xinhui Pan <Xinhui.Pan@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 James Turner <linuxkernel.foss@dmarc-none.turner.link>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <Christian.Koenig@amd.com>,
 regressions@lists.linux.dev
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 18 Mar 2022 11:06:00 -0400
Alex Deucher <alexdeucher@gmail.com> wrote:

> On Fri, Mar 18, 2022 at 10:46 AM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > On Fri, 18 Mar 2022 08:01:31 +0100
> > Thorsten Leemhuis <regressions@leemhuis.info> wrote:
> >  
> > > On 18.03.22 06:43, Paul Menzel wrote:  
> > > >
> > > > Am 17.03.22 um 13:54 schrieb Thorsten Leemhuis:  
> > > >> On 13.03.22 19:33, James Turner wrote:  
> > > >>>  
> > > >>>> My understanding at this point is that the root problem is probably
> > > >>>> not in the Linux kernel but rather something else (e.g. the machine
> > > >>>> firmware or AMD Windows driver) and that the change in f9b7f3703ff9
> > > >>>> ("drm/amdgpu/acpi: make ATPX/ATCS structures global (v2)") simply
> > > >>>> exposed the underlying problem.  
> > > >>
> > > >> FWIW: that in the end is irrelevant when it comes to the Linux kernel's
> > > >> 'no regressions' rule. For details see:
> > > >>
> > > >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/admin-guide/reporting-regressions.rst
> > > >>
> > > >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/process/handling-regressions.rst
> > > >>
> > > >>
> > > >> That being said: sometimes for the greater good it's better to not
> > > >> insist on that. And I guess that might be the case here.  
> > > >
> > > > But who decides that?  
> > >
> > > In the end afaics: Linus. But he can't watch each and every discussion,
> > > so it partly falls down to people discussing a regression, as they can
> > > always decide to get him involved in case they are unhappy with how a
> > > regression is handled. That obviously includes me in this case. I simply
> > > use my best judgement in such situations. I'm still undecided if that
> > > path is appropriate here, that's why I wrote above to see what James
> > > would say, as he afaics was the only one that reported this regression.
> > >  
> > > > Running stuff in a virtual machine is not that uncommon.  
> > >
> > > No, it's about passing through a GPU to a VM, which is a lot less common
> > > -- and afaics an area where blacklisting GPUs on the host to pass them
> > > through is not uncommon (a quick internet search confirmed that, but I
> > > might be wrong there).  
> >
> > Right, interference from host drivers and pre-boot environments is
> > always a concern with GPU assignment in particular.  AMD GPUs have a
> > long history of poor behavior relative to things like PCI secondary bus
> > resets which we use to try to get devices to clean, reusable states for
> > assignment.  Here a device is being bound to a host driver that
> > initiates some sort of power control, unbound from that driver and
> > exposed to new drivers far beyond the scope of the kernel's regression
> > policy.  Perhaps it's possible to undo such power control when
> > unbinding the device, but it's not necessarily a given that such a
> > thing is possible for this device without a cold reset.
> >
> > IMO, it's not fair to restrict the kernel from such advancements.  If
> > the use case is within a VM, don't bind host drivers.  It's difficult
> > to make promises when dynamically switching between host and userspace
> > drivers for devices that don't have functional reset mechanisms.
> > Thanks,  
> 
> Additionally, operating the isolated device in a VM on a constrained
> environment like a laptop may have other adverse side effects.  The
> driver in the guest would ideally know that this is a laptop and needs
> to properly interact with APCI to handle power management on the
> device.  If that is not the case, the driver in the guest may end up
> running the device out of spec with what the platform supports.  It's
> also likely to break suspend and resume, especially on systems which
> use S0ix since the firmware will generally only turn off certain power
> rails if all of the devices on the rails have been put into the proper
> state.  That state may vary depending on the platform requirements.

Good point, devices with platform dependencies to manage thermal
budgets, etc. should be considered "use at your own risk" relative to
device assignment currently.  Thanks,

Alex

