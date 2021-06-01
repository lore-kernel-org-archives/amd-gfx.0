Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C1BC4708F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 15:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A28A66139A
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 15:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28A66139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3925E6E06B;
	Tue,  1 Jun 2021 15:28:19 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C617D6E06B
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 15:28:17 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id v22so15859336oic.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Jun 2021 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iAptGz4h1RyI/0dGTY4YZwyDaz9rVkrvyRMaJshfCKc=;
 b=kXbp/eNpd9S8DWrS2ryUEndi7XHk8jvL0OFRyPZgHIFkc3ootNvlUR8XHx6KkKWxl0
 15FtiCxlM0phNBNzSk0E3+w2UJ1wPMtK+wlvIPxmJLo/e4Slbr1RgLk/LwArldgbQ89I
 LKBhVtjBqP4RAH3rBAjfqm2jJGZr/e4n0XRR4DLzG53Gn5pJJH+uk4HMATRxrZW/YwfK
 Lm7ZExj2V60ifSyclpY5sfWX7h6opYf6325EUSqEa9ZPJhQbe7DmkVGB8kDEs/lsdRh7
 SWkHkxNWqZs1XO6/GTVqRnc+6xnV8k7bFHgwKVsH2gWONjl2uL7L+YaCPDn/GrJhrpuP
 ewAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iAptGz4h1RyI/0dGTY4YZwyDaz9rVkrvyRMaJshfCKc=;
 b=BX5jgewr+aidx3DnT3jmPgqfLNTtpVIIsWDhXnDfJXvg4FIJfs3YO3RgmXK5ayau4O
 B06kK5+zgYJEhBIpitHEWzH2xvr2GUsuOC1/oUnXGd7o0yqr1lU0Mm8ISktCUjeFVZRq
 OcZkqatr7BptMoxn1wK8rKigad8AyeNlT2ULrxuAL18Hnzcy2UHJD8f3rw62CESOBMuM
 IKo/U2ziM59/cAlQDyext9S7pTVdQ/9NfbL21ulGQGxotY4UHGM9fm17Y9le/cs/KII8
 N6sgMONI4B6BsL3AHBXcGbXv8IPI8VdmMXyaJ5t49bZ94RNA0ldYdjKRHhqXaMmJl7WZ
 u8Jw==
X-Gm-Message-State: AOAM532gGrxVlHCEDmrEH6E/io7myy8iyLEzjRWMfmhDZ7STlYWnz5zo
 V0pi0UX+qTG9xse3zHtNt2T+tsOlq8Viuueib7qmGchV
X-Google-Smtp-Source: ABdhPJzApx7WmEpOsAj8RUgADQP6emIIzwtxxLbngWbOF/f/KaJgIfrpPs5w35yM5ld55ifc5dgj3SYHxZ/jCyH+yNQ=
X-Received: by 2002:a05:6808:1592:: with SMTP id
 t18mr18206898oiw.123.1622561297088; 
 Tue, 01 Jun 2021 08:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210529134054.099661dc@schienar>
In-Reply-To: <20210529134054.099661dc@schienar>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Jun 2021 11:28:05 -0400
Message-ID: <CADnq5_PdVAtR_y_1ywJhp6JCuJcx_RonJ74KsmQHpapa9ePxsg@mail.gmail.com>
Subject: Re: 5.13-rc3 Renoir (ChipID = 0x1636): error GPU reset, fences timed
 out, failed to initialize parser -125
To: Julian Wollrath <jwollrath@web.de>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 31, 2021 at 4:17 AM Julian Wollrath <jwollrath@web.de> wrote:
>
> Hello,
>
> on 5.13-rc3 with a 4650U (Renoir, ChipID = 0x1636) I am able to
> reliably get the GPU to reset under X11/Xorg with the amdgpu driver
> (current from git) and having persistent problems afterwards. I
> achieve this in the following way (using ROOT (root.cern.ch) to draw a
> histogram):
>
> $ root
> # TH1 *t = new TH1I("test", "test", 2, -.5, 1.5)
> # t->Fill(1)
> # t->Draw()
>
>
> this opens a window showing the histogram and results in
>
> kernel: [  370.709485] [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR* Waiting for fences timed out!
> kernel: [  375.820701] [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR* Waiting for fences timed out!
> kernel: [  375.830689] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout, signaled seq=3783, emitted seq=3785
> kernel: [  375.831015] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process Xorg pid 1028 thread Xorg
> :cs0 pid 1029
> kernel: [  375.831174] amdgpu 0000:03:00.0: amdgpu: GPU reset begin!
> kernel: [  375.924610] [drm] free PSP TMR buffer
> kernel: [  375.951409] amdgpu 0000:03:00.0: amdgpu: MODE2 reset
> kernel: [  375.951531] amdgpu 0000:03:00.0: amdgpu: GPU reset succeeded, trying to resume
> kernel: [  375.951712] [drm] PCIE GART of 1024M enabled.
> kernel: [  375.951715] [drm] PTB located at 0x000000F400900000
> kernel: [  375.951957] [drm] PSP is resuming...
> kernel: [  375.971811] [drm] reserve 0x400000 from 0xf41f800000 for PSP TMR
> kernel: [  376.277979] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not available
> kernel: [  376.288823] amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucode is not available
> kernel: [  376.288830] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
> kernel: [  376.288836] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
> kernel: [  376.290539] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
> kernel: [  376.648574] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  376.649562] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  376.721210] [drm] kiq ring mec 2 pipe 1 q 0
> kernel: [  376.722457] [drm] DMUB hardware initialized: version=0x01020008
> kernel: [  376.936133] [drm] VCN decode and encode initialized successfully(under DPG Mode).
> kernel: [  376.936628] [drm] JPEG decode initialized successfully.
> kernel: [  376.936635] amdgpu 0000:03:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
> kernel: [  376.936639] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
> kernel: [  376.936641] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
> kernel: [  376.936643] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
> kernel: [  376.936645] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
> kernel: [  376.936646] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
> kernel: [  376.936648] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
> kernel: [  376.936649] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
> kernel: [  376.936650] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
> kernel: [  376.936652] amdgpu 0000:03:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
> kernel: [  376.936654] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
> kernel: [  376.936656] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
> kernel: [  376.936657] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
> kernel: [  376.936659] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
> kernel: [  376.936660] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
> kernel: [  376.945068] amdgpu 0000:03:00.0: amdgpu: recover vram bo from shadow start
> kernel: [  376.945075] amdgpu 0000:03:00.0: amdgpu: recover vram bo from shadow done
> kernel: [  376.945081] [drm] Skip scheduling IBs!
> kernel: [  376.945084] [drm] Skip scheduling IBs!
> kernel: [  376.945119] amdgpu 0000:03:00.0: amdgpu: GPU reset(2) succeeded!

The GPU reset was successful.  You'll need to restart your GUI
environment.  Unfortunately no current desktop environments on Linux
properly handle lost contexts.

Alex


> kernel: [  376.945161] [drm] Skip scheduling IBs!
> kernel: [  376.945169] [drm] Skip scheduling IBs!
> kernel: [  376.945172] [drm] Skip scheduling IBs!
> kernel: [  376.945235] [drm] Skip scheduling IBs!
> kernel: [  376.945243] [drm] Skip scheduling IBs!
> kernel: [  376.945246] [drm] Skip scheduling IBs!
> kernel: [  376.945248] [drm] Skip scheduling IBs!
> kernel: [  376.945251] [drm] Skip scheduling IBs!
> kernel: [  376.945253] [drm] Skip scheduling IBs!
> kernel: [  376.948659] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  381.640053] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  381.641067] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  381.641510] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  382.795658] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  382.796462] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  383.157991] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  383.224317] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  383.225321] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  383.226164] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  383.226836] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  383.227294] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  383.227573] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  383.228525] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  391.623243] amdgpu_cs_ioctl: 13 callbacks suppressed
> kernel: [  391.623250] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  391.623979] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  396.615491] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  396.616130] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> kernel: [  398.242898] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> [...]
>
> I guess, that this might not be detailed enough information but I am
> happy to provide more, if you tell me, what exactly is needed.
>
>
> With best regards,
> Julian Wollrath
>
> --
>  ()  ascii ribbon campaign - against html e-mail
>  /\                        - against proprietary attachments
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
