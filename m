Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAC6FA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 21:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B916D10E714;
	Thu, 27 Oct 2022 21:53:54 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447A910E6B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 17:44:26 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 fn7-20020a05600c688700b003b4fb113b86so1771428wmb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 10:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XwpKT/OXB7N7mrTeT3Xlmap4y+VEeDdex/xqsHim6hg=;
 b=M7OGysE9hg2D1ANK/gO6NdemMxl1RejHJEoHdyUNA6l68ij3zhKCG3kbpVZpk1Ty1b
 azuip2Zh+WKNL9iT8ZUn8vuoAx3GedErA5mWGueNHgZIwtz0QZ5lw5nFm2zM0Q00Y/1U
 euoli4MUVDF7MxYwlx0AlHgHjrFaB9rhkkRvfrl7hsjsA2k+26xgZLokdL1ASip0PTxx
 nBlcXw/34TVA1Dln+a0qjnUwM8uJMQnDl911VuDqZPyC8bSuS3IsvQesogHp28BN01X7
 9CSVgJdUkok7gLomOBpHy6yDCqNWtOw3Vhk5briCkksRCkaU7PVxZguLQmYPDhiUFzu0
 CgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XwpKT/OXB7N7mrTeT3Xlmap4y+VEeDdex/xqsHim6hg=;
 b=ipf7jOGclptXOiP/6pQ/21seGhMrihmgS3d44r/JKrdiBxFXoC+q1csxp2AttDMqk0
 wpGX0cZaS1bcMLu/zKLVH7A5FsHqdt24JZJBpQ/XRQii5j2Xtkj4q6UEcmLAxAdibP/D
 uThQNpRC5GAh0h+y2aNAUxW7ln+iTph9NLnltaF4zJaLgS+1ZCcC3H1aw34ZDv4hinwJ
 Gqa79UZFMANvrjOngctC81xFW5yryDpWt85KFjLkyikjv6VvyZzl5AuhgWekRV9bPKQc
 3dqVFtWowMiZEZbz6jNZclDnvAE1UZTIL7q4f4QP3F7bMafsok9mJUc73DWOpLr2ce4z
 kCZQ==
X-Gm-Message-State: ACrzQf0/sGMWzUNfJdZaFCAHxhfVD7z4NMAPK74Tjcqgrmj/2o2LOsp3
 Z2Fm66i5pXbK9PzBH/1fijQ=
X-Google-Smtp-Source: AMsMyM6DW6hXC8qyFqVH4b3KU1TFyCmc3jU4TrwAMM/1N5s/8PV54wqi8dWLcUuOSBiAHuhjHnOugA==
X-Received: by 2002:a05:600c:3488:b0:3c6:cf4d:472b with SMTP id
 a8-20020a05600c348800b003c6cf4d472bmr6790221wmq.73.1666892664425; 
 Thu, 27 Oct 2022 10:44:24 -0700 (PDT)
Received: from ?IPV6:2a02:908:4f6:d280::9a6? ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 4-20020a05600c26c400b003b31c560a0csm2030381wmv.12.2022.10.27.10.44.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Oct 2022 10:44:24 -0700 (PDT)
Message-ID: <72e23c01-c205-53dc-f41e-961a8f9f0de9@gmail.com>
Date: Thu, 27 Oct 2022 19:44:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RESEND 1/1] drm/amd/display: add DCN support for ARM64
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Arnd Bergmann
 <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20221027002528.15983-1-hacc1225@gmail.com>
 <20221027002528.15983-2-hacc1225@gmail.com>
 <c41b45cb-8a1a-4140-b7f9-08aa481a25c1@app.fastmail.com>
 <8eb69dfb-ae35-dbf2-3f82-e8cc00e5389a@amd.com>
Content-Language: en-US
From: Ao Zhong <hacc1225@gmail.com>
In-Reply-To: <8eb69dfb-ae35-dbf2-3f82-e8cc00e5389a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Oct 2022 21:53:48 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 linux-arm-kernel@lists.infradead.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Rodrigo,

I have done these tests.

CPU: Kunpeng 920 3211k x24 TSV110 Core

GPU: AMD RX 6400

Monitor on DP: Mi Curved Gaming Monitor 34" (support FreeSync and 3440x1440 at 144Hz on DP)

Monitor on HDMI: a cheap 1080P HDMI capture card (ID: 534d:2109)

Distro: Gentoo with Linux 6.0.5 kernel

Desktop Environment: KDE Plasma

KDE-Plasma-Version: 5.25.5

KDE-Frameworks-Version: 5.99.0

Qt-Version: 5.15.5

Graphics Platform: wayland

I tried to plug and unplug the monitor frequently and quickly on both HDMI and DP port.

Both port works very well. I've also tried various different resolutions on my monitor with no issues.

But I can't set my monitor's refresh rate to 144Hz at 3440x1440. With X11, the 144Hz option won't show up

in the system settings, even xrandr won't show this mode. But with wayland, I can set the refresh rate to 144Hz,

but it results in a black screen. Interestingly, under wayland, if I set the refresh rate to 120Hz, the system works

fine, and the monitor shows that the current refresh rate is 120Hz, but if I restart the system, after re-entering the

desktop, the monitor shows that the current refresh rate is 144Hz. Under X11, the current refresh rate showed

by the monitor is the same as that in system settings. I don't know if that is a hardware limitation of the rx6400

or a software bug.

Am 27.10.22 um 16:29 schrieb Rodrigo Siqueira:
> Hi Ao/Arnd/Stephen/Nathan,
>
> Ao,
>
> Thanks a lot for this new patch.
>
> Since you have an ARM64 + AMD GPU, could you also run a couple of tests in your setup? If so, this is a good set of tests imho:
>
> 1. Check plug and unplug displays (let says 5x)
> 2. Change resolutions
> 3. (most wanted test) Could you run some IGT tests?
>
> About IGT, this is the official repository:
>
> https://gitlab.freedesktop.org/drm/igt-gpu-tools
>
> It should be easy to run IGT in your system. Follow a brief summary:
>
> 1. Install dependencies
>
> (maybe I missed something)
>
> Debian
> apt install flex bison pkg-config x11proto-dri2-dev python-docutils valgrind peg libpciaccess-dev libkmod-dev libprocps-dev libunwind-dev libdw-dev zlib1g-dev liblzma-dev libcairo-dev libpixman-1-dev libudev-dev libgsl-dev libasound2-dev libjson-c-dev libcurl4-openssl-dev libxrandr-dev libxv-dev meson libdrm-dev qemu-user qemu-user-static
>
> ArchLinux
> pacman -S gcc flex bison pkg-config libpciaccess kmod procps-ng libunwind libdwarf zlib xz cairo pixman libudev0-shim gsl alsa-lib xmlrpc-c json-c curl libxrandr libxv xorgproto python-docutils valgrind peg meson libdrm libtool make autoconf automake gtk-doc python-docutils git vim sudo
>
> 2. Build IGT
>
> meson build && ninja -C build
>
> 3. Turn off your GUI
>
> (You must run IGT without any GUI)
>
> sudo systemctl isolate multi-user.target
>
> After run this command, you should see the TTY.
>
> 4. Try to run this IGT test
>
> sudo ./build/tests/kms_flip
>
> And let me know if this test looks ok for you.
>
> On 10/27/22 06:52, Arnd Bergmann wrote:
>> On Thu, Oct 27, 2022, at 02:25, Ao Zhong wrote:
>>> After moving all FPU code to the DML folder, we can enable DCN support
>>> for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG from the
>>> code in the DML folder that needs to use hardware FPU, and add a control
>>> mechanism for ARM Neon.
>
> I recommend you to add the following info in your commit:
>
> 1. System that you use to validate this change (CPU name, monitor, distro, wayland/X, etc).
> 2. Describe the set of tests that you tried.
>
>>>
>>> Signed-off-by: Ao Zhong <hacc1225@gmail.com>
>>
>> There have been problems with stack frame overflows on this code
>> in the past, how much have you tested this with random configurations
>> to see if we still hit them in corner cases on arm64 that may not
>> show up on x86 or powerpc? I would expect to see a few more of them
>> for every new architecture port.
>
> Hi Arnd,
>
> We followed your suggestion to isolate all FPU code inside a single place (DML), and we recently completed most of this task. As a result, all FPU flags are only used in the DML code. I guess we might have issues in other non-x86 platforms, but this is something that we can improve over time, and from Ao message, it looks like that DCN is working on ARM.
>
> At this point, my main concern is that enabling ARM64 may causes some compilation issues that we did not reproduce yet. I cross-compiled amd-staging-drm-next + this patch with aarch64-linux-gnu-gcc version 12.2.0 and everything looks fine.
>
> Nathan/Stephen,
>
> Maybe I'm wrong, but I think you have access to some sort of CI that tests multiple builds with different compiles and configs, right? Is it possible to check this patch + amd-staging-drm-next in the CI to help us to anticipate any compilation issue if we merge this change?
>
> Or should we merge it and wait until it gets merged on the mainline? In case of a problem, we can easily revert a small patch like this, right?
>
> Thanks
> Siqueira
>
>>> index d0c6cf61c676..3cdd109189e0 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>> @@ -33,6 +33,12 @@ ifdef CONFIG_PPC64
>>>   dml_ccflags := -mhard-float -maltivec
>>>   endif
>>>
>>> +ifdef CONFIG_ARM64
>>> +ifdef CONFIG_DRM_AMD_DC_DCN
>>> +dml_rcflags_arm64 := -mgeneral-regs-only
>>> +endif
>>> +endif
>>> +
>>
>>>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
>>>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
>>>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags)
>>> -Wno-tautological-compare
>>> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
>>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o :=
>>> $(dml_rcflags) $(dml_rcflags_arm64)
>>
>> Why do you need separate $(dml_rcflags) and $(dml_rcflags_arm64)
>> rather than adding -mgeneral-regs-only to $(dml_rcflags) directly?
>>
>>      Arnd
