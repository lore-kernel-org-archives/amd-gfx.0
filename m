Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDE5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 09:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B5E110E391;
	Tue,  8 Feb 2022 09:34:47 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE41110E391
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 09:34:45 +0000 (UTC)
Received: by mail-yb1-xb33.google.com with SMTP id g14so48013541ybs.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Feb 2022 01:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=noI1PcHzCdkqKtF+a8s3ELESPLsfd1ymjI1ROP4v338=;
 b=FNn5U/WRMTf3NQHm3srAVMpNnDU+RVeSGZdSBvoAlqexPj14vl+cahh5QyFYU6i1Pb
 9S+75ILZj24KjgyHRgLs45/IcqgBd4wsNouNycqJdHx2TVoKhBfxC/DK6JT73CiVs/9m
 U28+ATV/uVOWF0pDed0rmSeffwD8LKjQlovRAycsgodp5DvraB8HxouNWkvkRDgUEdT4
 Ys6XRSf5svLSbGYaCKX4/7QZo5EhCfMnLMCpJ5g7WpE4KuDCALZUYJuosIjRo5uJA3wU
 3TvKbub4Xfkrw35GOs3kTPb++d2oGPmGVTcMH0kIE4NE+KllZd/sSDo9gDfSZD1jujLS
 0KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=noI1PcHzCdkqKtF+a8s3ELESPLsfd1ymjI1ROP4v338=;
 b=4KoDdX7O+1tbjMD7Xxdr8a/4SBBhmC2xJn+G4DBQe4gHQ+h5BUZugYcqQBPhgWm+2t
 IOoYP+h7ds3KfHeo9eQuk8rW3Y5HIYqR4yF437jsF/SbF8sdOAa5NTQTv7PztZVgLJBv
 YX1GH7VgHLLXBjrtEfur+818tvsySy04X1je/B93/nFFY/uI++UiP3H8P2Od0T2KWx+q
 jvwshHp294yqVovgj1/kfNy5v0DLGNkcLHvwpWUh95uiedOTGVL8f9uVGsKdcUz0u5dg
 qKZcH16MVS2TvqgrEHaD/BeCxFeMm8pW5illptCrpk/wj+AShcgcEwyYZgwj3r1SmZ4y
 WnnQ==
X-Gm-Message-State: AOAM530U5LVPZnUyXyFnQs74nLguU1xH19BWbYMGbo4iugJi6ecujaBv
 0HItQFBKm1rdESTsN2j4cH+6KMO9F3vnVxLzCoZE+La/TS4=
X-Google-Smtp-Source: ABdhPJxJqrkW6iqR+XEJ+yOkrV8ILMkQnGtorZzWsxnoAIyir0lAmhU+tyoS+yAp10GGDztVKDlire2aIxqlHqBPbGo=
X-Received: by 2002:a81:cb05:: with SMTP id q5mr3833949ywi.486.1644312884796; 
 Tue, 08 Feb 2022 01:34:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:3601:0:0:0:0 with HTTP; Tue, 8 Feb 2022 01:34:44
 -0800 (PST)
In-Reply-To: <BL1PR12MB514403668180CB26983C25A7F72C9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <CA+nuEB_u4G-Nf_nHODoY86anP6s0vRyh=0-yPxphbksbCPJ1Yg@mail.gmail.com>
 <BL1PR12MB514403668180CB26983C25A7F72C9@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Amol <suratiamol@gmail.com>
Date: Tue, 8 Feb 2022 15:04:44 +0530
Message-ID: <CA+nuEB_DBc77-UCsE-fgVJHn5-StUj+h3EUR0kBQxjj+sTi=3Q@mail.gmail.com>
Subject: Re: Minimal GPU setup
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thank you Alex.

On 07/02/2022, Deucher, Alexander <Alexander.Deucher@amd.com> wrote:
> [AMD Official Use Only]
>
> Most of the register programming in evergreen_gpu_init is required.  That
> code handles things like harvesting (e.g., disabling bad hardware resources)
> and setting sane asic specific settings in some registers.  If you don't do
> it, work may get scheduled to bad or incorrectly configured hardware blocks
> which will lead to hangs or corrupted results.  You can probably skip some
> of them, but I don't remember what is minimally required off hand.  It's
> generally a good idea to re-initialize those registers anyway in case
> someone has previously messed with them (e.g., manual register munging or
> GPU passed through to a VM etc.).

Understood.

>
> Posting the bios is enough to get you a working memory controller and enough
> asic setup to light up displays (basically what you need for pre-OS
> console).  As Christian mentioned, loading the ucodes will get the
> associated engines working so that you can start feeding commands to the
> GPU, but without proper configuration of the various hardware blocks on the
> GPU, you may not have success in feeding data to the GPU.

Understood. I think I wanted a confirmation that the steps I took so far are not
completely incorrect and may be just enough to see some GPU activity,
before I spend more effort programming other blocks. The feedback and a small
but working test helps restore the motivation.

Thanks,
Amol

>
> Alex
>
>
> ________________________________
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Amol
> <suratiamol@gmail.com>
> Sent: Saturday, February 5, 2022 4:47 AM
> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Subject: Minimal GPU setup
>
> Hello,
>
> I am learning to program Radeon HD 7350 by reading the radeon
> driver source in Linux, and the guides/manuals from AMD.
>
> I understand the general flow of initialization the driver performs. I
> have also been able to understand and re-implement the ATOM
> BIOS virtual machine.
>
> I am trying to program the device up from scratch (i.e. bare-metal).
> Do I need to perform all those steps that the driver does? Reading
> the evergreen_gpu_init function is demotivating; it initializes many
> fields and registers which I suspect may not be required for a minimal
> setup.
>
> Is posting the BIOS and loading the microcode enough to get me started
> with running basic tasks (DMA transfers, simple packet processing, etc.)?
>
> Thanks,
> Amol
>
