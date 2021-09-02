Return-Path: <SRS0=HxPN=NY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A425C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 18:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0951E61139
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 18:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0951E61139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA48D6E7E6;
	Thu,  2 Sep 2021 18:48:02 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70F7C6E057
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Sep 2021 18:07:39 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id d17so1700526plr.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Sep 2021 11:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vRIjmhyCmvhzoncqRr/4/DZW11FScO6N7+EAyatLST8=;
 b=XMesfIC0+k3N01cWkq/7yrPStcBFfCtU0Xt5gHxmO6bSOqNzOd/s/+OIcyxTtPL0UB
 Zng0Xr0YFco/Xf9QMwJ1lFRNjwY2PQU2HaoU373axgK5j5uox9fzWYNliilkTt2b7635
 V91czhYOVkLyFSSHgMICNRA+1MUJvkWBhBtJCw+K3Pz7KZzwdTemN3cZWwl6TG6/x/VY
 gVXwVoSa8S7795y2jXzfuGxwg/3NV2fxcHJ+poYDNAV/6rPM1QeRY/Xp9i6iTn+hetnE
 jzukgzWZ2XX4nyFUgxq4UKt32X2sBiiT9MgweOPYXEtFj2L1DKwPsQuH2MLeX33munh9
 iWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vRIjmhyCmvhzoncqRr/4/DZW11FScO6N7+EAyatLST8=;
 b=NxmhTixuErNpsjJn/ywQ0rAmKM6Ng2ojlB6iQe+/OLrwNj8F38d+Wxzn97nvv/2Azr
 ybBlnIkJ+1HG9fMxPv7aT1ofjbrYZkxc8f2VY0E9Ogtd7H2gcNSg2Srr+oG2SpWfzKQF
 iD7fF5RXDFCAVUCus/YoWuan6buB9/jhSA20txLmcqztNpuAqUXLtOPO0dHBHsNf1SAc
 +NKUBKNGMzJzM858Iu2kgHfQRbYvjm4H3+/syNtarL3wLdDgrd08nkAgLhMSKXk1lP5T
 6HAC6IoO44kqOE5gsiUCLD9dZFWrkg+C0JkhY6khNy/A/sgKG2QT7fnjxWdBaM+oOuBR
 Ur4Q==
X-Gm-Message-State: AOAM531YtI7Lgi6OcklEDSZArCbehxQP3kLgXualajcP2MLsCvXDCUu6
 aEh/kbzJHbsbbFbspKompIHT9WJOtNEcp+r9dt7Q2g==
X-Google-Smtp-Source: ABdhPJzISzTRdHEt3HEJe+ostypx1drj+Ux+3k9nfUpn2fvhtymn5ZGWoVXBoZmcXh6gl6QtltkADP+8aToUdn6EVdg=
X-Received: by 2002:a17:902:e550:b0:137:734f:1d84 with SMTP id
 n16-20020a170902e55000b00137734f1d84mr4046482plf.27.1630606059035; Thu, 02
 Sep 2021 11:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210825034828.12927-1-alex.sierra@amd.com>
 <20210825034828.12927-4-alex.sierra@amd.com>
 <20210825074602.GA29620@lst.de> <c4241eb3-07d2-c85b-0f48-cce4b8369381@amd.com>
 <a9eb2c4a-d8cc-9553-57b7-fd1622679aaa@amd.com> <20210830082800.GA6836@lst.de>
 <e40b3b79-f548-b87b-7a85-f654f25ed8dd@amd.com> <20210901082925.GA21961@lst.de>
 <11d64457-9d61-f82d-6c98-d68762dce85d@amd.com> <20210902081826.GA16283@lst.de>
In-Reply-To: <20210902081826.GA16283@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 2 Sep 2021 11:07:28 -0700
Message-ID: <CAPcyv4gCbZikp1k+f3FA5HusSW8gGkpCAxzR70eKEASLcnMCRA@mail.gmail.com>
Subject: Re: [PATCH v1 03/14] mm: add iomem vma selection for memory migration
To: Christoph Hellwig <hch@lst.de>
Cc: Felix Kuehling <felix.kuehling@amd.com>, 
 "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, 
 Linux MM <linux-mm@kvack.org>, Ralph Campbell <rcampbell@nvidia.com>, 
 linux-ext4 <linux-ext4@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Jason Gunthorpe <jgg@nvidia.com>, 
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 02 Sep 2021 18:48:01 +0000
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

On Thu, Sep 2, 2021 at 1:18 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Sep 01, 2021 at 11:40:43AM -0400, Felix Kuehling wrote:
> > >>> It looks like I'm totally misunderstanding what you are adding here
> > >>> then.  Why do we need any special treatment at all for memory that
> > >>> has normal struct pages and is part of the direct kernel map?
> > >> The pages are like normal memory for purposes of mapping them in CPU
> > >> page tables and for coherent access from the CPU.
> > > That's the user page tables.  What about the kernel direct map?
> > > If there is a normal kernel struct page backing there really should
> > > be no need for the pgmap.
> >
> > I'm not sure. The physical address ranges are in the UEFI system address
> > map as special-purpose memory. Does Linux create the struct pages and
> > kernel direct map for that without a pgmap call? I didn't see that last
> > time I went digging through that code.
>
> So doing some googling finds a patch from Dan that claims to hand EFI
> special purpose memory to the device dax driver.  But when I try to
> follow the version that got merged it looks it is treated simply as an
> MMIO region to be claimed by drivers, which would not get a struct page.
>
> Dan, did I misunderstand how E820_TYPE_SOFT_RESERVED works?

The original implementation of "soft reserve" support depended on the
combination of the EFI special purpose memory type and the ACPI HMAT
to define the device ranges. The requirement for ACPI HMAT was relaxed
later with commit:

5ccac54f3e12 ACPI: HMAT: attach a device for each soft-reserved range

The expectation is that system software policy can then either use the
device interface, assign a portion of the reservation back to the page
allocator, ignore the reservation altogether. Is this discussion
asking for a way to assign this memory to the GPU driver to manage?
device-dax already knows how to hand off to the page-allocator, seems
reasonable for it to be able to hand-off to another driver.
