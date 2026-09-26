Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14748C98324
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Sep 2026 13:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9726010E5DE;
	Sun, 27 Sep 2026 13:26:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EyDJEwU/";
	dkim-atps=neutral
Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com
 [74.125.231.167])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B776910E2CB
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Sep 2026 00:33:12 +0000 (UTC)
Received: by mail-oo2-f39.google.com with SMTP id
 006d021491bc7-6c24d19ebcfso836320eaf.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 17:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790382792; x=1790987592; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uq5HTYQ+QJ+sfMcCNifMvchBjccmyTR8flj2eR6m/n0=;
 b=EyDJEwU/ZQvcLxCvT0YnUt3kDZBkemgfUbsAw6vUea4s1VNXijr8I32PfbPoc6IbY7
 IS7iKuK0xmQBsG3whvBfdjqgApVB9RMNIv/ZvYuvho5i8+X4cnPek4ow5C9m5Tmu5Gw2
 pmDetW/qXNyoJuzVZ8OHHINWtSqS0VmDeS53tFz15vjHx47ybB4f8XKNXHBMIZNfQ3Ng
 f6Am5pSgoAOlCjdsTQhIDCrE4wlqzRLbKZ/qWbX/uHu/BI0L1saqqT/NjYsPmyn6zN7s
 3hzFO9ib9xvkA58SSOK+F6iG8Pr8ahZxC6JVZIBicgPmkxxiOiezdxgy/MkzzMbYdb/H
 D0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790382792; x=1790987592;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uq5HTYQ+QJ+sfMcCNifMvchBjccmyTR8flj2eR6m/n0=;
 b=j8/Qlkgpy1jCa9yO9M4snf5zWf8stHrAruiE3EE0u7kdWfAwznekP85VgU/SDySWfr
 DR5NmZD13Wsu0rncrtcNGajo0Kvfl0dyPe1EYX3YrXbpT3yY0ITh9odF95XmS9NG20u9
 h/Qi40PidD4UgkD9uzb/dt5bqcEOncE1FeIoNvT0voG9CuLtrT7EblandZiSdxPBd0RT
 TQrA+76ayNgxzC5ZqSj8GsGRPBEAgl1OXVoFiDNQTxmSN/ZhY7GTTTF0MyC9ogbCz/9+
 gRYW0O3QxtYt9ud4iHliegCCTTglrZMIeM5mPD3AxBOr+NzfmwZxIMAtSq1Q2J21QZjb
 Ek2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz52d59i45sU6lGGk7UoH/X4muS2G91oFWrfEiZxaJvFsZBZCXBbEbIOWkx+N5sg5V+NsHs6ydt@lists.freedesktop.org
X-Gm-Message-State: AFuF++nuUqcAJVrf3dEt3GVT5ZeKbfP2Mb+pf8/U9PaflwTpT+K/9WAz
 WX9lSgbempBXS992DuJGv280solQHSMev9iWmTsf0JVl0hYTbBOMC8P9
X-Gm-Gg: AYBFou194Ctk3FtQdcdn0exMC+1qGxHqCiWdDEBAsmIRx6R++0DJ7qyA5CoVHbpfga3
 I2BQLPEW7VNdyVIYvwUq01XSQO+eR1jExh7t28uItX4BPi2mTm7SSvVit04qZtZzYq7egf1HR46
 A4ikI7bdDNLVawkScbjkhv28xtqP+/0VaRiAagoJFDWVtJlCIgXw/iIlbx1zYjrjc5h3PGTOM+b
 frtWR8TlQpVanm8N02L9ywkOjztRcDxYHBD024v7piJkLwtF/SbZzdI+ny06iBUngAeXWKfBiM3
 zWY5X9UHkRkes9gcmKnZLED+aeI1kNCuYDLSnSq5TrFbrOZt/7FUvedVHBkC2CsL+mQWRbvKW8r
 qtZG7rqSOsTD7DJMlzBCVCk7hfdxXiI3l3odNO53p7YctdOxB4ANWg8qa4K/KrwcxjZvMhazuM8
 UVFPAuxcPYL/9KEXrHg/e+w7SAJ+V8UitCZaSWHTfDHEAg4Wa9YdDHDHW4OhTRrAcF3SGij7GPv
 7gg3p1UWyGji0GA1XDPDkF7ABdtDEiwscsOMc/piyf2I1kgcu1Id0twYlsctb3Cw5O4UnfkxsSF
 lRmdxy11ZiEUY9jZPMZXl5qcZA+H/7j5DdKBkmk9Nkdj7zgkjqM7EIe5Sw==
X-Received: by 2002:a05:6820:308d:b0:6c9:80d8:a1f7 with SMTP id
 006d021491bc7-6d440fe1a19mr7415011eaf.52.1790382791612; 
 Fri, 25 Sep 2026 17:33:11 -0700 (PDT)
Received: from ?IPV6:2603:80a0:3900:aa00:abba:f323:b886:8886?
 ([2603:80a0:3900:aa00:abba:f323:b886:8886])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d582b792dbsm4199062eaf.11.2026.09.25.17.33.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 17:33:11 -0700 (PDT)
Message-ID: <ab1cdd64-3390-480a-8d41-a942e8b2e120@gmail.com>
Date: Fri, 25 Sep 2026 19:33:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>, Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
 Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca> <arYf3iJW7hfTua__@8bytes.org>
 <20260925122848.GD163130@ziepe.ca>
 <4560d7d3-4d67-457d-bcd7-2176bd850bd4@amd.com>
 <20260925223928.GE163130@ziepe.ca>
Content-Language: en-US
From: Mario Limonciello <superm1@gmail.com>
Autocrypt: addr=superm1@gmail.com; keydata=
 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
In-Reply-To: <20260925223928.GE163130@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 27 Sep 2026 13:26:05 +0000
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



On 9/25/26 5:39 PM, Jason Gunthorpe wrote:
> On Fri, Sep 25, 2026 at 08:11:41AM -0500, Mario Limonciello wrote:
>>
>>
>> On 9/25/26 07:28, Jason Gunthorpe wrote:
>>> On Fri, Sep 25, 2026 at 09:20:02AM +0200, Joerg Roedel wrote:
>>>> On Thu, Sep 24, 2026 at 07:50:18PM -0300, Jason Gunthorpe wrote:
>>>>> Why does the GPU driver have to request this? Why can't the iommu
>>>>> driver know that this is a special device that can use this magic fast
>>>>> path and then auto set it when identity is asked for?
>>>>
>>>> This is a layering violation either way. Either the IOMMU driver needs to poke
>>>> into device details and their relations or the device driver needs to poke into
>>>> IOMMU details.
>>>
>>> There are no device details, this is just a module option in the gpu
>>> driver.
>>
>> Well the GPU driver has knowledge whether it's a GPU inside of an APU to
>> decide if it's valid.  That information is part of the discovery table
>> setup.
> 
> Where was that in patch 2?

amdgpu_device_use_perfopt()

> 
> The right way for this to work is to quirk it through the iommu driver
> so it can choose the fast mode, and not involve the GPU driver at
> all. Like we've done for every other GPU weirdness. And AMD should be
> making this work better by providing ACPI support so the iommu driver
> can understand how it should work without inspecting PCI IDs.

There is a heuristic that Vasant added recently that we detect APU from 
the IOMMU driver.  We might be able to use that for now.

I'll take a look at what an incremental patch looks like on top of 
iommu/next that I think reworks all these paths the way you want.  I 
should be able to post something next week.
