Return-Path: <SRS0=vrAH=HG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8D9C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 04:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A458764E55
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 04:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A458764E55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF6D96EC70;
	Thu,  4 Feb 2021 04:31:17 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A92EE6EC70
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 04:31:16 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id h192so2473492oib.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Feb 2021 20:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o0fFHhEPkXXurRUkSJACJDZKbTyYnM0J3lU92NXqMqc=;
 b=X26CeS6I9frE5t9C08nDlQotixvRp7EeSf9nhsYNZ2KX+weBYyviITr108pL8BVbkS
 ZSn+IO0wiVeO1NngPCc8hO/eLbzAMOReLXffINW0uOINphqRR7yvUjS2XG7j8V5haKtP
 oIYFZcKnkdhd2x5uoYXe5ST8NWlDgPpb+b3ZRHi4OROu4BCMVPVORUAFkaZh4vI7fan9
 5Dv/pAClSrzdJtcn30bKU4EQ+uXC4VUo0GGPs3jEfokIYLPQVzkloOIA2f3FAEYEqM1a
 qbDbNRdrI0SSSpoq/ek5W/3nLP07ouFzxMAS/ORyLTUTOeMIHK3wHJ/ADjJ4zODYv6Ia
 yTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o0fFHhEPkXXurRUkSJACJDZKbTyYnM0J3lU92NXqMqc=;
 b=pJmc5c098Xni6eKOi+goTaLP/5IzNrVRuvyiaHg9r7ruAgEq0WkWOHLhrePQNys9gx
 6Ba+nKUy9y2EAsGcMmF5LAVpkiqVbQxDPAg2jSFCHgeu/03lV6dquos+wuCU2A1/r0Bu
 5aqJ8k7FfkBENhNRxRzdyBwKmL5jYklRVB84nzpGc2FIxTSR1da+DZ7TZ0uHZckCnpAe
 Uv0MWgryIDOFxxpu8Zc5iRjS/FCKfOHxRO8wQf+jIM28XLACdECnADHz9mYojYXdXWlN
 VmQgamT5+ESyV3r/KWzRTn1McwUPUer7ZdzvEVDVNvAo6gSZNJUmrbyfu5tAHFi6QcVv
 nn3Q==
X-Gm-Message-State: AOAM532uClkR0e9jKWuwonWeFdQoo4gxIQ9bvdCDyJr1bQsOngz661rj
 5kA/cNEsV8yPDr+Ukhczm/WbN6A0RPA2yXWSMRg=
X-Google-Smtp-Source: ABdhPJxeSXGhuhGaEDvo5lkdqolhwfL3T4de6CBoSQeOHmRSXin1qNNL1hn1OCDskfM7G8TUVpbUjcG8nfcnN+PGpfA=
X-Received: by 2002:aca:530f:: with SMTP id h15mr2952527oib.5.1612413076022;
 Wed, 03 Feb 2021 20:31:16 -0800 (PST)
MIME-Version: 1.0
References: <CAN_LGv3Go0DgKbjPVHFFXU+U8RRU15m-np3F6_RrVmx6FmBoHQ@mail.gmail.com>
 <20210128052924.GC2339@MiWiFi-R3L-srv>
 <20210203064849.GA11522@dhcp-128-65.nay.redhat.com>
 <CADnq5_MdLTLvVdwFQJxuRaQcQFNkLUNRt267zaxULNH0FUvFeA@mail.gmail.com>
 <87wnvoodny.fsf@x220.int.ebiederm.org>
In-Reply-To: <87wnvoodny.fsf@x220.int.ebiederm.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Feb 2021 23:31:05 -0500
Message-ID: <CADnq5_OBZmmieaUzMhtdVbJKhx5R34c8M669VKfcE0KSWcyv4A@mail.gmail.com>
Subject: Re: amdgpu problem after kexec
To: "Eric W. Biederman" <ebiederm@xmission.com>
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
Cc: kexec@lists.infradead.org, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Dave Young <dyoung@redhat.com>, "Alexander E. Patrakov" <patrakov@gmail.com>,
 Baoquan He <bhe@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 3, 2021 at 7:56 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Alex Deucher <alexdeucher@gmail.com> writes:
>
> > On Wed, Feb 3, 2021 at 3:36 AM Dave Young <dyoung@redhat.com> wrote:
> >>
> >> Hi Baoquan,
> >>
> >> Thanks for ccing.
> >> On 01/28/21 at 01:29pm, Baoquan He wrote:
> >> > On 01/11/21 at 01:17pm, Alexander E. Patrakov wrote:
> >> > > Hello,
> >> > >
> >> > > I was trying out kexec on my new laptop, which is a HP EliteBook 735
> >> > > G6. The problem is, amdgpu does not have hardware acceleration after
> >> > > kexec. Also, strangely, the lines about BlueTooth are missing from
> >> > > dmesg after kexec, but I have not tried to use BlueTooth on this
> >> > > laptop yet. I don't know how to debug this, the relevant amdgpu lines
> >> > > in dmesg are:
> >> > >
> >> > > amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB
> >> > > test failed on gfx (-110).
> >> > > [drm:process_one_work] *ERROR* ib ring test failed (-110).
> >> > >
> >> > > The good and bad dmesg files are attached. Is it a kexec problem (and
> >> > > amdgpu is only a victim), or should I take it to amdgpu lists? Do I
> >> > > need to provide some extra kernel arguments for debugging?
>
> The best debugging I can think of is can you arrange to have the amdgpu
> modules removed before the final kexec -e?
>
> That would tell us if the code to shutdown the gpu exist in the rmmod
> path aka the .remove method and is simply missing in the kexec path aka
> the .shutdown method.
>
>
> >> > I am not familiar with graphical component. Add Dave to CC to see if
> >> > he has some comments. It would be great if amdgpu expert can have a look.
> >>
> >> It needs amdgpu driver people to help.  Since kexec bypass
> >> bios/UEFI initialization so we requires drivers to implement .shutdown
> >> method and test it to make 2nd kernel to work correctly.
> >
> > kexec is tricky to make work properly on our GPUs.  The problem is
> > that there are some engines on the GPU that cannot be re-initialized
> > once they have been initialized without an intervening device reset.
> > APUs are even trickier because they share a lot of hardware state with
> > the CPU.  Doing lots of extra resets adds latency.  The driver has
> > code to try and detect if certain engines are running at driver load
> > time and do a reset before initialization to make this work, but it
> > apparently is not working properly on your system.
>
> There are two cases that I think sometimes get mixed up.
>
> There is kexec-on-panic in which case all of the work needs to happen in
> the driver initialization.
>
> There is also a simple kexec in which case some of the work can happen
> in the kernel that is being shutdown and sometimes that is easer.
>
> Does it make sense to reset your device unconditionally on driver removal?

I think we tried that at some point in the past but users complained
that it added latency or artifacts on the display at shutdown or
reboot time.

> Would it make sense to reset your device unconditionally on driver add?

Pretty much the same issue there.  It adds latency and you get
artifacts on the display when the reset happens.

>
> How can someone debug the smart logic of reset on driver load?

See this block of code in amdgpu_device.c:
        /* check if we need to reset the asic
         *  E.g., driver was not cleanly unloaded previously, etc.
         */
    if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
        r = amdgpu_asic_reset(adev);
                if (r) {
                        dev_err(adev->dev, "asic reset on init failed\n");
                        goto failed;
                }
        }

You'll want to see if amdgpu_asic_need_reset_on_init() was able to
determine that the asic needs a reset.  If it does,
amdgpu_asic_reset() getds called to reset it.
The tricky thing is that some reset methods require a fair amount of
driver state and so, they are only possible when the driver is up and
running.  Those methods are not necessarily available at driver load
time because we need to reset the GPU before we can initialize it and
determine that state so we end up in a kind of catch 22.
Unfortunately, generic PCI resets don't necessarily work on many of
our GPUs so that's not an option either.

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
