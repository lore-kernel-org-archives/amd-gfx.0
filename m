Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B878C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 14:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D135610E059;
	Fri, 18 Mar 2022 14:46:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A43EA10E059
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 14:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647614790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TNP/cfaogRB9CjpdHZApi9zDHXNx0ATc+DZIQOXTyTo=;
 b=H5+6DWtNzk2hJYLxAOqgOGZNOVS4w9gFbAa+TIWc35vvcodBpZBxOmilsuEAInE6rO5SKC
 +gsm/olYGRguFKPMYgfacq3jE6zXy0JDcipBvEPtUzCJikN+5IXwZ+8qN19wE/OIdm33cj
 e7dFHFAgm9z/52SPoH6fMF9Xekfdvq8=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-vH7pNyZ2Mbq3DFfWpbjUPg-1; Fri, 18 Mar 2022 10:46:29 -0400
X-MC-Unique: vH7pNyZ2Mbq3DFfWpbjUPg-1
Received: by mail-il1-f199.google.com with SMTP id
 s14-20020a056e021a0e00b002c7c03a5d81so4923965ild.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 07:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=TNP/cfaogRB9CjpdHZApi9zDHXNx0ATc+DZIQOXTyTo=;
 b=0w2RE0RY8wsSNvx7ibebh+jCOHcJ/zTmKX/IMvAFVsUF1mRT03ug9oLhkpG5l/RMob
 nq6sEzBA/ZQyACz5OL+0xzrtbRdwJB1h4WydNVbjcHi7pBS35NTPgCT1xLdV7vfWd9pw
 EOpDSx7lraQlxqAWpi6MDELDSh0dHcXhoyfb7nG4M2Pg3M9IGsz9Zs+LTNyxFlKhYNvg
 wT3PuQ0PYd3IS3JW76/ZHjaMm3YHN9nXnDqSJOrJt2B25E9T1itt3yKs+vZbHjIXr2dT
 qqHfDQ44ABuEunTiC/AJd0oa0ATRDnZM8zfI/0JXkK0gYBSAew9N9UCXQYG7+TKPsMjp
 tS2Q==
X-Gm-Message-State: AOAM5323zKwOrYuhhyCOe2mydWV4s5AuxnvMNSX+tYNve2hdcF6KumfV
 95y6P3o7wnPm61Wpa9p+qAnEDHWgwiVYy1MB+es+WVttEx4umBDsD5DfMfmXBSGhGmVnXVnbwSp
 2mGIy8xLzQZZ3B/p9ntYp4aPTVg==
X-Received: by 2002:a05:6602:1414:b0:63d:d5fd:c16e with SMTP id
 t20-20020a056602141400b0063dd5fdc16emr4602191iov.39.1647614788624; 
 Fri, 18 Mar 2022 07:46:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2qPUaZR4EQmbFM5xc0105G4QoXfxLhmJxgudtGO9Haizky/1u+FIGD6yx423M2Oe8NioUxg==
X-Received: by 2002:a05:6602:1414:b0:63d:d5fd:c16e with SMTP id
 t20-20020a056602141400b0063dd5fdc16emr4602182iov.39.1647614788331; 
 Fri, 18 Mar 2022 07:46:28 -0700 (PDT)
Received: from redhat.com ([98.55.18.59]) by smtp.gmail.com with ESMTPSA id
 q7-20020a5d87c7000000b0064132d5bd73sm4433845ios.4.2022.03.18.07.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Mar 2022 07:46:27 -0700 (PDT)
Date: Fri, 18 Mar 2022 08:46:25 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [REGRESSION] Too-low frequency limit for AMD GPU
 PCI-passed-through to Windows VM
Message-ID: <20220318084625.27d42a51.alex.williamson@redhat.com>
In-Reply-To: <bc714e87-d1dc-cdda-5a29-25820faaff40@leemhuis.info>
References: <87ee57c8fu.fsf@turner.link>
 <CADnq5_Nr5-FR2zP1ViVsD_ZMiW=UHC1wO8_HEGm26K_EG2KDoA@mail.gmail.com>
 <87czkk1pmt.fsf@dmarc-none.turner.link>
 <BYAPR12MB46140BE09E37244AE129C01A975C9@BYAPR12MB4614.namprd12.prod.outlook.com>
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
 regressions@lists.linux.dev, kvm@vger.kernel.org,
 Greg KH <gregkh@linuxfoundation.org>, Xinhui Pan <Xinhui.Pan@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexdeucher@gmail.com>,
 James Turner <linuxkernel.foss@dmarc-none.turner.link>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 18 Mar 2022 08:01:31 +0100
Thorsten Leemhuis <regressions@leemhuis.info> wrote:

> On 18.03.22 06:43, Paul Menzel wrote:
> >
> > Am 17.03.22 um 13:54 schrieb Thorsten Leemhuis:  
> >> On 13.03.22 19:33, James Turner wrote:  
> >>>  
> >>>> My understanding at this point is that the root problem is probably
> >>>> not in the Linux kernel but rather something else (e.g. the machine
> >>>> firmware or AMD Windows driver) and that the change in f9b7f3703ff9
> >>>> ("drm/amdgpu/acpi: make ATPX/ATCS structures global (v2)") simply
> >>>> exposed the underlying problem.  
> >>
> >> FWIW: that in the end is irrelevant when it comes to the Linux kernel's
> >> 'no regressions' rule. For details see:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/admin-guide/reporting-regressions.rst
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/process/handling-regressions.rst
> >>
> >>
> >> That being said: sometimes for the greater good it's better to not
> >> insist on that. And I guess that might be the case here.  
> > 
> > But who decides that?  
> 
> In the end afaics: Linus. But he can't watch each and every discussion,
> so it partly falls down to people discussing a regression, as they can
> always decide to get him involved in case they are unhappy with how a
> regression is handled. That obviously includes me in this case. I simply
> use my best judgement in such situations. I'm still undecided if that
> path is appropriate here, that's why I wrote above to see what James
> would say, as he afaics was the only one that reported this regression.
> 
> > Running stuff in a virtual machine is not that uncommon.  
> 
> No, it's about passing through a GPU to a VM, which is a lot less common
> -- and afaics an area where blacklisting GPUs on the host to pass them
> through is not uncommon (a quick internet search confirmed that, but I
> might be wrong there).

Right, interference from host drivers and pre-boot environments is
always a concern with GPU assignment in particular.  AMD GPUs have a
long history of poor behavior relative to things like PCI secondary bus
resets which we use to try to get devices to clean, reusable states for
assignment.  Here a device is being bound to a host driver that
initiates some sort of power control, unbound from that driver and
exposed to new drivers far beyond the scope of the kernel's regression
policy.  Perhaps it's possible to undo such power control when
unbinding the device, but it's not necessarily a given that such a
thing is possible for this device without a cold reset.

IMO, it's not fair to restrict the kernel from such advancements.  If
the use case is within a VM, don't bind host drivers.  It's difficult
to make promises when dynamically switching between host and userspace
drivers for devices that don't have functional reset mechanisms.
Thanks,

Alex

