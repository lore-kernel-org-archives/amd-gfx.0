Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7751C54EE9
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 14:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E81AA10EB1C;
	Thu,  8 Sep 2022 14:14:08 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE18910EB1C
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 14:14:05 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-11e9a7135easo44671637fac.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Sep 2022 07:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=xapq8hOysSubtyNreknAbNwb98q6I8ybh28+NsZXyJg=;
 b=DqFe0frNxPw8kbzy8vVsRmhZEJUtqxHDy7/K7rsr+3dpG7sjtRtsgjNmlsP/ZtPS/T
 fKATIDnsWaziQ/2shGaulYPL6+vv7DL32h8LRHhrN86CsfrGRxycrZ6psDqUhpRyegLt
 3FQ38BIMppheu5jQKcm/JRfUt3Wf8SHRLVjAG3Qm3Hi2r/U6lUr5vnm2QF5G0kO6c0WM
 sbWJqqyD+YZDRdKtZ6NVSGMfIUxBIb8XSfzQdKFaHsGU/O+3f8136mIGdGqXwsokM8uh
 Scf+INcXMxa6tKtXQ+lPCKHC2YpnQhz5bx+Ju2h3Egwa++pvuWQ3yQFMPleNFZXzJI2Z
 sdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=xapq8hOysSubtyNreknAbNwb98q6I8ybh28+NsZXyJg=;
 b=rWznFCT1e9Ulqwlh9ZpcuauofYfzuNp5t/UMLxRHsQWrVgHD7xbkFTssvLyx6e6t0g
 NuQiQMAHVMm30Gq6pmQHu8V0DJm2DQ/ouJ3Sge65D+CD95cN0fogM8NUH14pAgJWjdHR
 rvgQ4znDrFE6CEoFQiHCfhjxZpnc+6X7nxISUiadPEuydUm49/TFiGY6bx9vxg4qP003
 XVrhhvqq6l54JlSA7b/FN2PeiQmazXFrfHRV1l9q6I0emwVHXd7PPOv2k+jMchurNAmT
 vM/BVNOCIvgA0OKL4gjHxJcAthCeBe4u5fDR0lBO1paygeC78jmcgx7eA8AU6PzwkHxp
 hVrg==
X-Gm-Message-State: ACgBeo0RSTDWlUns9HsuIu5qmu8jS70sghsljo89ongb5CJ33cJgfHvX
 MId08Ty7UkkTnKoX8A+p85ai4coSqJvu38qNS4E=
X-Google-Smtp-Source: AA6agR7hmmkM1oZIe3eilTW1VQo5wukZ8Rq0+dbvmMqBPatAX7lWPwfTZqSsO1qsCz53eX3UrriGpvW5q575tV0x6Bg=
X-Received: by 2002:a05:6870:1783:b0:12a:f442:504d with SMTP id
 r3-20020a056870178300b0012af442504dmr509300oae.46.1662646444960; Thu, 08 Sep
 2022 07:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220825085820.1228641-1-lijo.lazar@amd.com>
 <20220825180134.GA2857782@bhelgaas>
 <BL1PR12MB5144986E6FBDC106E49B2F8EF7409@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144986E6FBDC106E49B2F8EF7409@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Sep 2022 10:13:53 -0400
Message-ID: <CADnq5_OwO0Hnw0JQLM9Lw4By=C6VHo9tuAVhq1TcJAv0wqhqaw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Move HDP remapping earlier during init
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "tseewald@gmail.com" <tseewald@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 "sr@denx.de" <sr@denx.de>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 8, 2022 at 10:08 AM Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Bjorn Helgaas
> > Sent: Thursday, August 25, 2022 2:02 PM
> > To: Lazar, Lijo <Lijo.Lazar@amd.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Kuehling, Felix
> > <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org;
> > tseewald@gmail.com; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; sr@denx.de; Koenig, Christian
> > <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> > Subject: Re: [PATCH 1/2] drm/amdgpu: Move HDP remapping earlier during
> > init
> >
> > [+cc Greg, no action needed yet, just FYI that stable will want these]
> >
> > On Thu, Aug 25, 2022 at 02:28:19PM +0530, Lijo Lazar wrote:
> > > HDP flush is used early in the init sequence as part of memory
> > > controller block initialization. Hence remapping of HDP registers
> > > needed for flush needs to happen earlier.
> > >
> > > This also fixes the AER error reported as Unsupported Request during
> > > driver load.
> >
> > I would say something like:
> >
> >   This prevents writes to unimplemented space, which would cause
> >   Unsupported Request errors.  Prior to 8795e182b02d ("PCI/portdrv:
> >   Don't disable AER reporting in get_port_device_capability()"), these
> >   errors occurred but were ignored.
> >
> > The write is the error; AER is just the reporting mechanism.
> >
> > > Link:
> > >
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugz
> > >
> > illa.kernel.org%2Fshow_bug.cgi%3Fid%3D216373&amp;data=05%7C01%7Cal
> > exan
> > >
> > der.deucher%40amd.com%7C3306aa3e6a834f2d394808da86c3dfb1%7C3dd8
> > 961fe48
> > >
> > 84e608e11a82d994e183d%7C0%7C0%7C637970473081942953%7CUnknown%
> > 7CTWFpbGZ
> > >
> > sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
> > n0%3
> > >
> > D%7C3000%7C%7C%7C&amp;sdata=DFqggIRt4sKNjJB5bY14yi5oJ8I4szzndQD
> > blr6Vcr
> > > c%3D&amp;reserved=0
> >
> > We need a cc: stable because 8795e182b02d ("PCI/portdrv: Don't disable AER
> > reporting in get_port_device_capability()") has already been backported to
> > at lealst these stable kernels:
> >
> >   5.10.137 5.15.61 5.18.18 5.19.2
> >
> > and these fixes need to go there as well.  So add something like this:
> >
> >   Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in
> > get_port_device_capability()")
> >   cc: stable@vger.kernel.org
> >
> > It's not that there was something wrong with 8795e182b02d and these
> > patches fix it; it's just that 8795e182b02d *exposed* an amdgpu problem
> > that was there all along.  But we need some way to connect with it.
>
> Will update the patch with these comments.  Also @tseewald@gmail.com can you please test this patch and confirm that it fixes things for you as well?

Sorry, ignore this.  This old email showed up at the top of my inbox
for some reason and I mixed up the threads.

Alex

>
> Alex
>
> >
> > > Reported-by: Tom Seewald <tseewald@gmail.com>
> > > Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
