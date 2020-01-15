Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945A7C33CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 07:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5AE222C3
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 07:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="TAhdPkwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5AE222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 002646E861;
	Wed, 15 Jan 2020 07:44:52 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F31A76E861
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 07:44:51 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id r14so14780027qke.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 23:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LTVIYeQ6AAaOMzE6Dr4mFcbzclaVh9FA4XP4/GSMGwo=;
 b=TAhdPkwdP+lOPnPQhyn6iJBFNZ4wBz8+zXiyysfz1KEJoDMd8LosaF14Eqgwle9Wvh
 /tYpzFKHdXMc3D+g96wMtv5pAv832YmU3YDFTIACU8Dc4qVMpbnV0cYIKkbRkzqqhkYF
 QE5ItFnyXfS0OBMjn0ypeGfDpP9kgJKcgmCcUJCsSFBeWtoG3AlLI68AminHhFwysxiP
 gHywwAvbjJfgjCBUKjLa01odKz7fc5uZUkUGDJM5tGRcN9X48V05EH1WeiTLDDooCSWj
 Bj++DInpQqRbYvRZPT4y2rxul5CzpnKF2xuAP8prwCcbXaSlUPUwU4UrIZZ96WRASX2T
 qdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LTVIYeQ6AAaOMzE6Dr4mFcbzclaVh9FA4XP4/GSMGwo=;
 b=pRvvBeituzTTfhCtyGdJbCtbAsSSfqxMgMh6XTrsVEMveOXmOcTFIkJccB6UoiihAT
 WsOolKrJdJe2hRSt98AZOXf5F3MGx1vl+C8YZBPZqcOKabiNYRMcw0NeqrgW6qWKLrSu
 nwr+rFKAEzIyr7tVZFzHtKuumY7IM8qF3vht3QEYdKqccrJLwaP5osol92OtXnRu9PZ8
 Ifp5sGo4k5ElJwb0c0PSpZPYo8Tj073cxn++kOG774VB4sUia5XWzV62NDYUQ8kMGF+2
 jxbIsG7Zc+PIougHNJlXiEixyqeTKFDDFUdp3mGE8SBNcQVakRgPRJTgrIMykyLEaKJM
 MqXg==
X-Gm-Message-State: APjAAAVwRAM/7Uk1KdQsEe6XzGm9HPFO8W6nNsNzjPBTef5KwBtyRRcd
 IDXBdPFiMz0QrNf0Ozeu7TY+Kc/q4B1v8GS14RRKQg==
X-Google-Smtp-Source: APXvYqwrUfbScoyVZBBbQjT7My45ZO3JYPfT0OQJZ0tiAMVJJkFQNgCiI1RYTDY1ZGHFHLvLSkzKWpV9AvEJ96llcck=
X-Received: by 2002:a37:9ec2:: with SMTP id h185mr25663168qke.14.1579074290928; 
 Tue, 14 Jan 2020 23:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20191015065002.18701-1-drake@endlessm.com>
 <CADnq5_M4Leu0raYS6M72MqTm1+PLg9BjHCHLAYuB2-dEVP56_A@mail.gmail.com>
 <CAD8Lp443ZhPEo0PJRxbTSB9DY9x92OvWBeH29m9Ehpyhg+2n5A@mail.gmail.com>
 <CADnq5_OaATVESAY9E2mtd7PoV2VjG=WLS56LCHVpieSHDTas0A@mail.gmail.com>
 <CAD8Lp46f9LR_VJ26BGfOGvj8sTjKZowkbjLNv6R4CsVMfRZQ=Q@mail.gmail.com>
 <CAD8Lp46+Te+AUQKLkLEcGf34izw=JzkU5w=CsZRf_UKJQ_k7qg@mail.gmail.com>
 <CADnq5_OObnKTP7-tBmPz75R5qXs8ubRxgfX-qkBnzqcox0TZyQ@mail.gmail.com>
In-Reply-To: <CADnq5_OObnKTP7-tBmPz75R5qXs8ubRxgfX-qkBnzqcox0TZyQ@mail.gmail.com>
From: Daniel Drake <drake@endlessm.com>
Date: Wed, 15 Jan 2020 15:44:39 +0800
Message-ID: <CAD8Lp44FKuEsmdK+zDX_-ZYQEnqjQM-z6nnfE-CJ62mutd+scA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always reset asic when going into suspend
To: Alex Deucher <alexdeucher@gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Chunming Zhou <David1.Zhou@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 19, 2019 at 10:08 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> I think there may be some AMD specific handling needed in
> drivers/acpi/sleep.c.  My understanding from reading the modern
> standby documents from MS is that each vendor needs to provide a
> platform specific PEP driver.  I'm not sure how much of that current
> code is Intel specific or not.

I don't think there is anything Intel-specific in drivers/acpi/sleep.c.

Reading more about PEP, I see that Linux supports PEP devices with
ACPI ID INT33A1 or PNP0D80. Indeed the Intel platforms we work with
have INT33A1 devices in their ACPI tables.

This product has a \_SB.PEP ACPI device with _HID AMD0004 and _CID
PNP0D80. Full acpidump:
https://gist.github.com/dsd/ff3dfc0f63cdd9eba4a0fbd9e776e8be (see
ssdt7)

This PEP device responds to a _DSM with UUID argument
"e3f32452-febc-43ce-9039-932122d37721", which is not the one
documented at https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf

Nevertheless, there is some data about the GPU:
                    Package (0x04)
                    {
                        One,
                        "\\_SB.PCI0.GP17.VGA",
                        Zero,
                        0x03
                    },

However since this data is identical to many other devices that
suspend and resume just fine, I wonder if it is really important.

The one supported method does offer two calls which may mirror the
Display Off/On Notifications in the above spec:
                        Case (0x02)
                        {
                            \_SB.PCI0.SBRG.EC0.CSEE (0xB7)
                            Return (Zero)
                        }
                        Case (0x03)
                        {
                            \_SB.PCI0.SBRG.EC0.CSEE (0xB8)
                            Notify (\_SB.PCI0.SBRG.EC0.LID, 0x80) //
Status Change
                            Return (Zero)
                        }

but I tried executing this code after suspending amdgpu, and the
problem still stands, amdgpu cannot wakeup correctly.

There's nothing else really interesting in the PEP device as far as I can see.

PEP things aside, I am still quite suspicious about the fact that
calling amdgpu_device_suspend() then amdgpu_device_resume() on
multiple products (not just this one) fails. It seems that this code
flow is relying on the BIOS doing something in the S3 suspend/resume
path in order to make the device resumable by amdgpu_device_resume(),
which is why we have only encountered this issue for the first time on
our first AMD platform that does not support S3 suspend.

With that in mind, and lacking any better info, wouldn't it make sense
for amdgpu_device_resume() to always call reset? Maybe it's not
necessary in the S3 case, but it shouldn't harm anything. Or perhaps
it could check if the device is alive and reset it if it's not?

Alternatively do you have any other contacts within AMD that could
help us figure out the underlying question of how to correctly suspend
and resume these devices? Happy to ship an affected product sample
your way.

Thanks
Daniel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
