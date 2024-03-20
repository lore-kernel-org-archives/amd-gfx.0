Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D002FC54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 13:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5376C10FBD0;
	Wed, 20 Mar 2024 13:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VhFBhJiL";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE7C810FBB8
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 13:31:53 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-414612cfd82so18382335e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710941512; x=1711546312; darn=lists.freedesktop.org;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X9j2dkiX+YZz5NgrHVxLgVXEb/5SU2coH0Zz/8mikLA=;
 b=VhFBhJiLYw3Mf1InB2FKDUcu1zIBbINeONZ6JkcUIlHTcjEDw8A3FBcnYZkWNnObXC
 ea06CChVtF7D9Mg6Rr/3k5wqUP0OEcPoBSysFANoYkf4EnHibFImKfXTsrY7Og3ARVDx
 T/p1FEEIgvwk6jCZpUVY4hMHOOyOH5dYrJ96icUoZ/julPBAjuXDvrbVT9e0yIpFkrGF
 WXB8Zu2FoA2cIPHd2laIgmpxkLr+1ayMlAjvxwdQLDRvptYixjomZFKF9ikjTipwTf1C
 j8XOpS4oeCjOqyCXQZNSgbCgzRk/2iDXbdpe2EnbaB6VcUgGc8RRLYNqYYm9picQlRU6
 QYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710941512; x=1711546312;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X9j2dkiX+YZz5NgrHVxLgVXEb/5SU2coH0Zz/8mikLA=;
 b=OSubkalYuvNQvsNFGsvCfhkvEkSUSb4qLp6cTE0QCu9AqcxnJ4WWnvESe3LXQJMKq7
 JxBi+oK9Q7oS5DN5T3TFJum0St8gL9Px//bkLEQdiCkxUdIuhQEU6v1PXPFwBb3D7fSc
 5mG8f7BKfAnRKGCHgDUoqgepgpX+Kjq3TQNQnxwuXkzVp7s5hASnGJu1nK8khGzdnv5C
 y13a0q7JLGYfPNjUe8MvPJXfqOOGBvBABn2ucsIx5uUx2UXeCLB+QFIwBPEhB8ziArTl
 88V/sjdAXPWPDfhMiQEi6LN4B9x7fH4GeXTwSh+I0jPGh8b4dbZdXsp91Z/CqZtF/dNZ
 D3Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCB6D41IdUJRVlRcavfTaCPhktVEytwwmq/lpSq3OoKC4j43v+rnKnQ7+9IGH5XKu+gFMHEk6JSYU0hO+WEdVMKLHoeq9xfefs70qmQA==
X-Gm-Message-State: AOJu0YxMhINgCGKMEflD0NnYSyRI3nS4IOxmJrh0j706dX9X+eHaaY2E
 5lq/iNyUkafRjlsr8aOXhRu+Fswe42f/CdLswWJMDMB3EiSeuOsF
X-Google-Smtp-Source: AGHT+IG5eYbS8s1hbCmZXpOfwQDD5flczfi1ZMJfXmrJkQpXjedwQLjYqbtdAHSWgu3WqmXcNN2A8g==
X-Received: by 2002:a05:600c:3b24:b0:414:6467:34a4 with SMTP id
 m36-20020a05600c3b2400b00414646734a4mr4235772wms.7.1710941511784; 
 Wed, 20 Mar 2024 06:31:51 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 k36-20020a05600c1ca400b00412f2136793sm2257166wms.44.2024.03.20.06.31.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 06:31:51 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------kNuRSk7kuK5eZsFsmlfpoxEw"
Message-ID: <8fcf6836-8c86-4072-b201-e8a62c438e2c@gmail.com>
Date: Wed, 20 Mar 2024 14:31:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Remove pci address checks from acpi_vfct_bios
Content-Language: en-US
To: Kurt Kartaltepe <kkartaltepe@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20240318065211.11097-1-kkartaltepe@gmail.com>
 <CADnq5_MxfDSaOoD9J2DfdkM2wzX_HfRPkLv8CSSVPzJSKi1aUQ@mail.gmail.com>
 <CACawnnzv5Ro32h3wJ_5EQ=9k=b8mGA4FEGjXbWTUP-jdmWERBg@mail.gmail.com>
 <CADnq5_N4eZ9LbDRLwbAv0NVnmp1GrMwp+cDs4tP0FHwf1r7YRg@mail.gmail.com>
 <CACawnnz17jd4f+VrVhx5oH_DmOSb7jSLGZnmj0PcOZeQ+=UD5A@mail.gmail.com>
 <CADnq5_Mj_9=hBC47K5urr5VLTiaUQsv1Lib0uPTq8-XGSDh-tw@mail.gmail.com>
 <CADnq5_OtProx-8d_0epm9TrYtE_rHLYDhEb6XrK9bgOPi7MicQ@mail.gmail.com>
 <CACawnnx8Z5jbBdzct9Omeq3Y6iJhMDTDy_C3DRPe9irjoHRn+Q@mail.gmail.com>
 <cbc7739a-21c3-4872-bcb0-4fceaf607d32@amd.com>
 <CACawnnwei18rsUPXcPW8iUBXyKBghoOHSzMMy6ndwi64ovF88g@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CACawnnwei18rsUPXcPW8iUBXyKBghoOHSzMMy6ndwi64ovF88g@mail.gmail.com>
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

This is a multi-part message in MIME format.
--------------kNuRSk7kuK5eZsFsmlfpoxEw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.03.24 um 16:04 schrieb Kurt Kartaltepe:
> On Tue, Mar 19, 2024 at 2:54 AM Christian König
> <christian.koenig@amd.com>  wrote:
>>
>> Well what problems do you run into? The ACPI and BIOS assignments
>> usually work much better than whatever the Linux PCI subsystem comes up
>> with.
> Perhaps its easier to show the lspci output for the BIOS assignment
> and we can agree it's far from helpful
>
>             +-04.1-[64-c3]----00.0-[65-68]--+-01.0-[66]----00.0-[67]----00.0
>   Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge
> DD 2018]
>             |                               +-02.0-[67]--
>             |                               \-04.0-[68]--
>
> In this case the bios has assigned the upstream port 65-68, for its 3
> downstreams 66,67,68, and then assigned the upstream port of the
> device's own bridge to 67.
>
> In this case not only did BIOS produce an invalid topology but it also
> does not provide any space at the first upstream or downstream ports
> which the current PCI implementation would require to assign bus
> numbers if I understand it correctly.

Can you provide the full output of lspci -vvvv. As far as I can see that 
doesn't looks so invalid to me.

>> The PCI subsystem in the Linux kernel for example can't handle back to
>> back resources behind multiple downstream bridges.
>>
>> So when the BIOS fails to assign something it's extremely unlikely that
>> the Linux kernel will do the right thing either.
> I'm not sure this is still the case, the PCI subsystem with realloc
> (and assign-busses for x86) deals with enumerating this topology which
> reports multiple bridges just fine.

Well that is just a very very old workaround for a buggy BIOS on 20 year 
old laptops. The last reference I could find for hardware which actually 
needed it is this:

commit 8c4b2cf9af9b4ecc29d4f0ec4ecc8e94dc4432d7
Author: Bernhard Kaindl <bk@suse.de>
Date:   Sat Feb 18 01:36:55 2006 -0800

     [PATCH] PCI: PCI/Cardbus cards hidden, needs pci=assign-busses to fix


So as far as I know nobody had to use that in ages and I wouldn't expect 
that this option actually works correctly on any modern hardware.

Especially not anything PCIe based since it messes up the ACPI to PCIe 
device mappings. That amdgpu doesn't work is just the tip of the iceberg 
here.

>   The same configuration as above
> produces this bus numbering (with hpbussize=20)
>
>             +-04.1-[24-66]----00.0-[25-66]--+-01.0-[26-45]----00.0-[27-29]--+-01.0-[28]----00.0
>   Intel Corporation DG2 [Arc A750]
>             |                               |
>      \-04.0-[29]----00.0  Intel Corporation DG2 Audio Controller
>             |                               +-02.0-[46]----00.0  Intel
> Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge DD 2018]
>             |                               \-04.0-[47-66]--
>
> The Linux kernel doesnt do the right thing without these features, and
> these are not the default. So you may be right that by default it does
> not recover from the situation of well.
>
>
> Given the bus allocation at the root port I can imagine a more
> aggressive than default but less aggressive than `assign-busses`
> reallocation scheme could deal with both preserving root allocations
> like the APU and renumbering things behind upstream ports. That might
> be a better approach than renumbering even the root bus devices.

The bus assignment code in the PCI subsystem is made to support hotplug, 
not completely re-number the root hubs from scratch. That is just a hack 
somebody came up with two decades ago to get some Cardbus slots in 
laptops working.

I'm not sure yet what's going wrong with the Thunderbold controller, but 
completely re-assigning bus numbers is certainly the wrong approach.

Regards,
Christian.

>
>> Regards,
>> Christian.

--------------kNuRSk7kuK5eZsFsmlfpoxEw
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 19.03.24 um 16:04 schrieb Kurt Kartaltepe:<br>
    <blockquote type="cite"
cite="mid:CACawnnwei18rsUPXcPW8iUBXyKBghoOHSzMMy6ndwi64ovF88g@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Tue, Mar 19, 2024 at 2:54 AM Christian König
<a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

Well what problems do you run into? The ACPI and BIOS assignments
usually work much better than whatever the Linux PCI subsystem comes up
with.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Perhaps its easier to show the lspci output for the BIOS assignment
and we can agree it's far from helpful

           +-04.1-[64-c3]----00.0-[65-68]--+-01.0-[66]----00.0-[67]----00.0
 Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge
DD 2018]
           |                               +-02.0-[67]--
           |                               \-04.0-[68]--

In this case the bios has assigned the upstream port 65-68, for its 3
downstreams 66,67,68, and then assigned the upstream port of the
device's own bridge to 67.

In this case not only did BIOS produce an invalid topology but it also
does not provide any space at the first upstream or downstream ports
which the current PCI implementation would require to assign bus
numbers if I understand it correctly.</pre>
    </blockquote>
    <br>
    Can you provide the full output of lspci -vvvv. As far as I can see
    that doesn't looks so invalid to me.<br>
    <br>
    <span style="white-space: pre-wrap">
</span>
    <blockquote type="cite"
cite="mid:CACawnnwei18rsUPXcPW8iUBXyKBghoOHSzMMy6ndwi64ovF88g@mail.gmail.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
The PCI subsystem in the Linux kernel for example can't handle back to
back resources behind multiple downstream bridges.

So when the BIOS fails to assign something it's extremely unlikely that
the Linux kernel will do the right thing either.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I'm not sure this is still the case, the PCI subsystem with realloc
(and assign-busses for x86) deals with enumerating this topology which
reports multiple bridges just fine.</pre>
    </blockquote>
    <br>
    Well that is just a very very old workaround for a buggy BIOS on 20
    year old laptops. The last reference I could find for hardware which
    actually needed it is this:<br>
    <br>
    commit 8c4b2cf9af9b4ecc29d4f0ec4ecc8e94dc4432d7<br>
    Author: Bernhard Kaindl <a class="moz-txt-link-rfc2396E" href="mailto:bk@suse.de">&lt;bk@suse.de&gt;</a><br>
    Date:   Sat Feb 18 01:36:55 2006 -0800<br>
    <br>
        [PATCH] PCI: PCI/Cardbus cards hidden, needs pci=assign-busses
    to fix<br>
    <br>
    <br>
    So as far as I know nobody had to use that in ages and I wouldn't
    expect that this option actually works correctly on any modern
    hardware.<br>
    <br>
    Especially not anything PCIe based since it messes up the ACPI to
    PCIe device mappings. That amdgpu doesn't work is just the tip of
    the iceberg here.<br>
    <br>
    <blockquote type="cite"
cite="mid:CACawnnwei18rsUPXcPW8iUBXyKBghoOHSzMMy6ndwi64ovF88g@mail.gmail.com">
      <pre class="moz-quote-pre" wrap=""> The same configuration as above
produces this bus numbering (with hpbussize=20)

           +-04.1-[24-66]----00.0-[25-66]--+-01.0-[26-45]----00.0-[27-29]--+-01.0-[28]----00.0
 Intel Corporation DG2 [Arc A750]
           |                               |
    \-04.0-[29]----00.0  Intel Corporation DG2 Audio Controller
           |                               +-02.0-[46]----00.0  Intel
Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge DD 2018]
           |                               \-04.0-[47-66]--

The Linux kernel doesnt do the right thing without these features, and
these are not the default. So you may be right that by default it does
not recover from the situation of well.


Given the bus allocation at the root port I can imagine a more
aggressive than default but less aggressive than `assign-busses`
reallocation scheme could deal with both preserving root allocations
like the APU and renumbering things behind upstream ports. That might
be a better approach than renumbering even the root bus devices.</pre>
    </blockquote>
    <br>
    The bus assignment code in the PCI subsystem is made to support
    hotplug, not completely re-number the root hubs from scratch. That
    is just a hack somebody came up with two decades ago to get some
    Cardbus slots in laptops working.<br>
    <br>
    I'm not sure yet what's going wrong with the Thunderbold controller,
    but completely re-assigning bus numbers is certainly the wrong
    approach.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CACawnnwei18rsUPXcPW8iUBXyKBghoOHSzMMy6ndwi64ovF88g@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Regards,
Christian.
</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------kNuRSk7kuK5eZsFsmlfpoxEw--
