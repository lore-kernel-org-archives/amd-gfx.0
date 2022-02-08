Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB8DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 09:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A170610E326;
	Tue,  8 Feb 2022 09:34:39 +0000 (UTC)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 041DF10E326
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 09:34:38 +0000 (UTC)
Received: by mail-yb1-xb2b.google.com with SMTP id y129so11783666ybe.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Feb 2022 01:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+LOpBwqxaWMPb0TQHpfHeLAksUGuFTbvj5sLD9uywvk=;
 b=K5qQES1AJ0pbYsevwi5Kpsm056yLJpPxjul8pzbG0GwMCQvpFJLxqktvf7bJT6JqoU
 T0PoPwqJzrzO6ScvfSwfDZQhvafGUwrNe493Llg4n7rsAFWWhHpYiZsNHeNnWVNxT0H1
 nBhLNkdt32TET5iGzaOBcjrBnQO83GJk6qV1w4/MrHCR/f3Fqb+t4G7O4ooTNfkvpgGU
 FiR7QBgNAwH1ui8SXccxJSBFZByap+5gZy4c0HF4+w1oVI8L1OrEKxiaLatot3xIvU1P
 b7tpBfvkIiw3SD3WgmoXI79UEx96FgRd0IDu5vpJMlcBE+9GwMI559T/jQ9wWyAUwM6c
 tn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+LOpBwqxaWMPb0TQHpfHeLAksUGuFTbvj5sLD9uywvk=;
 b=hSq9ADSWEafvWwWC7ai/FT3xVS3LV2a8YyasVInMddaR1Fx/qW7dL/ED2ECmeC3Act
 ADo12vAhQX2x5Hl5HgYblz1pOAt0RmnVE3dJO4noH6OeLo9ifGGV8qT4pKfqNbljLb0m
 HzaHNDuK/KcVdb1TeHgRYeRUkLLRzVOU/6bOka8KY1DILcwOAwaPFQqdRlUyvp5Y07R4
 oqnyird3Lcg+0JvQm+CSv7LxdboZrfm5V/62hgu2RQUtwWXVuIcBfHR9pAuUgFMrvzEj
 VQgexOHmKm+cysCmQ5OEx9Q77CPBBwayKH0p/CtewtYLtMyYFDL1uaRax4rybXinDLhU
 +XHg==
X-Gm-Message-State: AOAM531xdkTw4aa6NP0Vn6Gbxb8r9ggcBg6vDhIgZ3F5XaMycreY6b27
 Ly3vgQrd2+elfB2TvM0rCz8l1hZ3yqKS7P7nJ5bUb0k2M9w=
X-Google-Smtp-Source: ABdhPJygoTOrerqI2+EXOcZpyXyHxJXKuA6NaZWsxc1mq0DAVQM/Rf90QZ/dn+d8UXIwvsJewV6hvHn62C7ake2FwMw=
X-Received: by 2002:a81:a805:: with SMTP id f5mr3566131ywh.477.1644312876813; 
 Tue, 08 Feb 2022 01:34:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:3601:0:0:0:0 with HTTP; Tue, 8 Feb 2022 01:34:36
 -0800 (PST)
In-Reply-To: <7190426d-0300-da40-963d-af1cc280cd69@amd.com>
References: <CA+nuEB_u4G-Nf_nHODoY86anP6s0vRyh=0-yPxphbksbCPJ1Yg@mail.gmail.com>
 <7190426d-0300-da40-963d-af1cc280cd69@amd.com>
From: Amol <suratiamol@gmail.com>
Date: Tue, 8 Feb 2022 15:04:36 +0530
Message-ID: <CA+nuEB_p5ssS0HLnbDbPfwnEuPj9B45m8gvU_xci-+k32BJzYQ@mail.gmail.com>
Subject: Re: Minimal GPU setup
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thank you Christian.

On 06/02/2022, Christian K=C3=B6nig <christian.koenig@amd.com> wrote:
> Hi Amol,
>
> Am 05.02.22 um 10:47 schrieb Amol:

. . .

>> Is posting the BIOS and loading the microcode enough to get me started
>> with running basic tasks (DMA transfers, simple packet processing, etc.)=
?
>
> Well yes and no. As bare minimum you need the following:
> 1. Firmware loading
> 2. Memory management
> 3. Ring buffer setup
> 4. Hardware initialization
>
> When that is done you can write commands into the ring buffers of the CP
> or SDMA and see if they are executed (see the *_ring_test() functions in
> the driver). SDMA is usually easier to get working.

The DMA-ring-test of making the SDMA write into a WB location in the
system RAM succeeded.

The sequence followed mimics what the Linux driver does for the most part,
until evergreen_gpu_init. That and the portions of power mgmt, interrupt mg=
mt,
indirect buffer mgmt, the entire _modeset_init were skipped for now.

The WB and the CP, DMA ring buffers are PAGE_SIZE buffers in the system
RAM. GTT is a 512-entries table, in the BAR0 aperture, appropriately filled=
 in
to map the WB, CP and DMA buffers.

>
> When you got that working you can worry about IB (indirect buffers)
> which are basically subroutines calls written into the ring buffers.
>
> Most commands (like copy from A to B, fill something, write value X to
> memory or write X into register Y) can be used from the ring buffers
> directly, but IIRC some context switching commands which are part of the
> rendering process require special handling.
>
> But keep in mind that all of this will just be horrible slow because the
> ASIC runs with the bootup clocks which are something like 100Mhz or even
> only 17Mhz on very old models. To change that you need to implement
> power management, interrupt handling etc etc....

Understood. Yes, the DPM and the IH portions. I think by programming only
for the hardware I have I can manage to set them up with comparatively less
effort.

Thanks,
Amol

>
> Good luck,
> Christian.
>
>>
>> Thanks,
>> Amol
>
>
