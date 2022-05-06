Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF2CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 02:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DDC10EC10;
	Fri,  6 May 2022 02:41:09 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BDC310EC10
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 02:41:08 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id w19so10386166lfu.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 May 2022 19:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=bTDdYA7ttUpE3afDCnwYs3W0g7SfceV3dsixHGQ7hOE=;
 b=OQrhEObwUtlynUEwwN6L121MQ1CBGcUHqMkkpcUl6epZSCig94Jdc13UJuP5gPYx8L
 eVskDso9AeRO/4zMZsNukTWyg4EcyK4u8Todlef7s/y2yym0REtde0W1DxzPVG0SeWh2
 8VyofhRffIZ7RKngibGotQ9Z2L+eDVDg1XAA7sDJU556Vp8jdjcy1h8uHxbAojUq9R22
 ZOCeaX/49lvesuMIVMGGb8FY5K6OpBfSGmuWt29R6JgFt7peQLq9vs34j1a0wNXYJZHN
 1KbEBVXi38Ae3vJQ8yRM72v9ZkEwgwBTe5r/domrcWkRPSDA69He5nXfDwOovqIuQmEw
 IyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=bTDdYA7ttUpE3afDCnwYs3W0g7SfceV3dsixHGQ7hOE=;
 b=qy4qnIDvjdyAlAnq3Jwj6TW6dVB0Eo49j0Vd9wWdWxA3lRgy15YdGIdhjiqqQzjwYO
 mNcq9sAHWcfN+cZM8xTTJcJ/rZNUHe1nNX0pZT3uGVXnBtgmSP68VLlcERncjaripM39
 QEVsASZWb4yu2dAeG50HkSHAZOqb+1Y+SIxpv2lsxVXkgr1laXK/G6hY70Kiebw3W1er
 6h79nSaZ/kiEWBbeqbcEdIZPMLjH5yyFxGd7QlbvrCAkBQ2JRUgOzsNPLDi3IqOR5WpN
 DYEfcD+P8246stP1ss/hupZccXZKFq3yFEUr0eHbuWGiyDqg9PCtoCbawI7YqrFm5saV
 bCFw==
X-Gm-Message-State: AOAM532HLKUIBR8QVFA4oJn1C4ctEV/DLU+DZGF0VrU1YPOJ47lohpjc
 sJ6sziHgbNf+aqJXEdZwFky9/GKeSbvZjm6aSk14MH08IL8=
X-Google-Smtp-Source: ABdhPJzUE8dhcSGq3RvBdSdeF0lt0LOkXcrHn+5DSpBsm5BriLoJL7gwZfhXUxNOx+1KD2DwaxbzyH5NQeYkaWPxKX0=
X-Received: by 2002:a05:6512:2308:b0:473:da88:ea2b with SMTP id
 o8-20020a056512230800b00473da88ea2bmr913369lfu.339.1651804866067; Thu, 05 May
 2022 19:41:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6500:a81:b0:13c:1acf:f8c9 with HTTP; Thu, 5 May 2022
 19:41:05 -0700 (PDT)
From: Amol <suratiamol@gmail.com>
Date: Fri, 6 May 2022 08:11:05 +0530
Message-ID: <CA+nuEB8stQK8eJeR7mFjQCTkqUvSY+2NwQ_E5i2K9DAmDcwEkw@mail.gmail.com>
Subject: [cedar] DMA ring test timeout
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: suratiamol@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello,

While trying to program the HD 7350 Cedar GPU to run with DPM
under the 157MHz/200MHz sclk/mclk powerstate, for single_display,
and with forced LOW performance on the SMC, the DMA ring seems
to hang.

After the desired power state is programmed, the DMA and CP rings
0xcafedead tests are run. The CP ring test succeeds but the DMA ring
test times out. Note that the Linux radeon driver does not wait so late
during its initialization to run these tests.

The GPU's DMA ring RPTR is found to be at index 3 (it should be at
index 4 after consuming all 4 32-bit words, when starting at index 0).
Since the write-back of GPU's RPTR is successful, the DMA from
GPU to system RAM works.

Contents of some registers, before and after running the DMA test:

DMA_STATUS: 0x44c83d57, 0x44c83156 (IDLE bit is off in the after
status)
GRBM_STATUS: 0x3828, 0x3828
SRBM_STATUS: 0x200000c0, 0x200000c0

If the DMA WRITE(2) cmd is replaced with a TRAP(7), the DMA
RPTR does not even move a single step - after the timeout, it is
found to be still at 0. And the IDLE status is found to be OFF.
The expected interrupt isn't generated.

If, instead, 4 NOPs(15) are sent, the DMA ring is again found to be
stuck at RPTR=3 with IDLE status as OFF. It seems to have an
affinity towards the 3rd position from the start.

I also ran the CP ring test with a MEM_WRITE operation instead of the
default SET_CONFIG_REG op. The test succeeds, thus proving that
the CP ring can indeed DMA into the system RAM at the lowest perf
profile.

Does this mean that the GPU doesn't support running DMA ring at the
lowest perf profile (157Mhz/200MHz)? I do still believe that this
situation might be a result of faulty/missing programming on my part,
though I am not sure what exactly it is that is at fault or is missing.

The machine is a kvm-vfio-enabled VM; the current ArchLinux ISO fails
to initialize the passthru device (-22 from radeon_device_init).

Thanks,
Amol
