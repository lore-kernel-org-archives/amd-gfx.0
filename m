Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E36CA5FC6
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15BDC10ED9A;
	Tue, 29 Sep 2026 08:23:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="lvPlznOx";
	dkim-atps=neutral
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20C7D10E0D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 12:08:36 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-8121458be2dso4047354a34.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 05:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1790597315; x=1791202115; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XwKmdtQOuxKsyeiO9lNp8K96cGh02KL4kBovEXTexcM=;
 b=lvPlznOx18dPFR0B3LD0xDWn265k4JEh+sv2SlpDhjInnlYLH+JgkJRsAD1AhE+CoB
 02vSW+76Jh6sZyg2aBlTaAY/Dxi4IhpK8nX1u7WhZ9nfj0oHXJK5tuFn39OsX+/I768Z
 /3h7DGBGaehqH/G9Zu0nT2E1FhbO8FH0jzTmVyezWVweCbSG2vzHh2v/S14XBlhht7Iv
 Kn4IYYJv6n7hIshXpK7gnHcnRgGUGRvQ0AePgsUDrzym2lCKtMcHi+0OZuq3Ku8DkhJk
 rrPmMGAHY7CITS7oMXuIC+qJt6WA5xU2X+7WGldDA6UOFkdNGS8eqO+YzjZL2aqkps5m
 abWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790597315; x=1791202115;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XwKmdtQOuxKsyeiO9lNp8K96cGh02KL4kBovEXTexcM=;
 b=U0caxANqnSCc7kIuwfme9AwORYAzjtGt4GwQ5DuF5N4K9UTaqpU/dK0Xgg0A6OOtfS
 iuUC1L7MuVWlTbR7K47oIKTHOolyQsE2u8OzDR25IOG1HiAdSEz4aYQa1PVPGvXNmF1P
 mF6/MbhHLVDcNJbxyMXd7f4+YTU68J6ujLgozZ7fFPBiOpFp3DxVbHwOF0Uttw+154H2
 gmSustoTlA9VlwvSIfAA22yUc5kj0s9sDxxP3pHpTXNJEbEPNFg7y2zU8mJV7NfYbRL0
 WP/yz7FkehM8vS3dAdutQpOG99aYj5nJbHX3L9XAaxfjxVHFC3BWNcVU54BxNG77RQs6
 h2Kg==
X-Forwarded-Encrypted: i=1;
 AKwUvBweU7pJZvwZpZau9XyTPKE/PHjNnpEUQjY2JDWQQwsmYQX6q8k4BTUPOrwhTXJk8bu6P7cDXKwH@lists.freedesktop.org
X-Gm-Message-State: AFuF++mWZSl7jO6YpwoD/0QhRgxKMNwpfM4OZE5wM/NLKLfQQ8CnWp9W
 vQbhVCY6j3hrLAxiui77Ux/71DlKgEYcmzjSdqQoskzHctKMd0kKiLvszdfmaDutsuU=
X-Gm-Gg: AYBFou28jhqC6ae43YSYvSGLIjIbliE+VI640Ek6WEaUbNAdkLCiJUThXfgiDzfvtKf
 02t9dB+h1pTzxDg0oD5Mbog+QxXYCrsVxsFifPuslNIvfzGkubooJVioglY7b2lRfSz33pJ4P9w
 ZHkTQ0ZkqkV4ZG+jEvgIJmqEbuCG1nldx3BuOLB6feBjWW45i/roNqq9iZJgTo7nZs0enq2ViaB
 bjppCebWHyk54tqBo2IvOM3ei6yWAS0EjjL+yzduYOSOwGE9Rw/57HJu+RjxCp/V8y2ds0+/F6i
 0OM4cwax4JSanShhGi3Rq7qUAQJEKyGuBHruaPhqqLyj89R8qhaxE4Y0Z+5ZSYuVE8uQMd/wDrL
 5glkg9LFRRDUaqKEE5zHbrLIcSlXpKA8M3Dw2/UFvDGeAAW5xgE2td/uhxcc8zgOeX7ZEhxNn39
 XkIWOv3fHzznPbpVabFMdUgA1r46Hol60XL7k3Wn4wbUeiEQ==
X-Received: by 2002:a05:6830:8312:b0:81a:a8dc:3103 with SMTP id
 46e09a7af769-81aa8dc3643mr3416653a34.37.1790597315104; 
 Mon, 28 Sep 2026 05:08:35 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81d57ef0155sm1271472a34.9.2026.09.28.05.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 05:08:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xBA9n-00000006hK3-2U74;
 Mon, 28 Sep 2026 09:08:31 -0300
Date: Mon, 28 Sep 2026 09:08:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mario Limonciello <superm1@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
 Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Message-ID: <20260928120831.GF163130@ziepe.ca>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca> <arYf3iJW7hfTua__@8bytes.org>
 <20260925122848.GD163130@ziepe.ca>
 <4560d7d3-4d67-457d-bcd7-2176bd850bd4@amd.com>
 <20260925223928.GE163130@ziepe.ca>
 <ab1cdd64-3390-480a-8d41-a942e8b2e120@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1cdd64-3390-480a-8d41-a942e8b2e120@gmail.com>
X-Mailman-Approved-At: Tue, 29 Sep 2026 08:23:02 +0000
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

On Fri, Sep 25, 2026 at 07:33:08PM -0500, Mario Limonciello wrote:
> 
> 
> On 9/25/26 5:39 PM, Jason Gunthorpe wrote:
> > On Fri, Sep 25, 2026 at 08:11:41AM -0500, Mario Limonciello wrote:
> > > 
> > > 
> > > On 9/25/26 07:28, Jason Gunthorpe wrote:
> > > > On Fri, Sep 25, 2026 at 09:20:02AM +0200, Joerg Roedel wrote:
> > > > > On Thu, Sep 24, 2026 at 07:50:18PM -0300, Jason Gunthorpe wrote:
> > > > > > Why does the GPU driver have to request this? Why can't the iommu
> > > > > > driver know that this is a special device that can use this magic fast
> > > > > > path and then auto set it when identity is asked for?
> > > > > 
> > > > > This is a layering violation either way. Either the IOMMU driver needs to poke
> > > > > into device details and their relations or the device driver needs to poke into
> > > > > IOMMU details.
> > > > 
> > > > There are no device details, this is just a module option in the gpu
> > > > driver.
> > > 
> > > Well the GPU driver has knowledge whether it's a GPU inside of an APU to
> > > decide if it's valid.  That information is part of the discovery table
> > > setup.
> > 
> > Where was that in patch 2?
> 
> amdgpu_device_use_perfopt()

Ah, sneaky, that looks like it just decodes from a a giant list of PCI IDs
 
> > The right way for this to work is to quirk it through the iommu driver
> > so it can choose the fast mode, and not involve the GPU driver at
> > all. Like we've done for every other GPU weirdness. And AMD should be
> > making this work better by providing ACPI support so the iommu driver
> > can understand how it should work without inspecting PCI IDs.
> 
> There is a heuristic that Vasant added recently that we detect APU from the
> IOMMU driver.  We might be able to use that for now.
> 
> I'll take a look at what an incremental patch looks like on top of
> iommu/next that I think reworks all these paths the way you want.  I should
> be able to post something next week.

ACPI is the right answer to these kinds of problems.

Jason
