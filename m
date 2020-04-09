Return-Path: <SRS0=3NI5=5Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF41C2BA19
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 23:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF98F2072F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 23:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ANPsVH7n";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RbrGXbC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF98F2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fastmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1AD6E19B;
	Thu,  9 Apr 2020 23:52:25 +0000 (UTC)
X-Greylist: delayed 342 seconds by postgrey-1.36 at gabe;
 Thu, 09 Apr 2020 23:52:23 UTC
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF69D6E19B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2020 23:52:23 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id DE6DA5C01B9
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2020 19:46:40 -0400 (EDT)
Received: from imap3 ([10.202.2.53])
 by compute4.internal (MEProxy); Thu, 09 Apr 2020 19:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
 mime-version:message-id:date:from:to:subject:content-type; s=
 fm2; bh=oLrWM1x0ys/SwjJhbhz2GoauKZrsYC4VVYxinoCSROs=; b=ANPsVH7n
 btRVV9PGIGx/hrzancE4Bwg1qfNlO/GikKbwm1rIBfMbTVIvDBVr0wl66kPccA1M
 A2eJnlI6yYU/MQXJhDNVLr/xY8VJ8IzIdnVUFvSwRvOgs2DjuRb5mA9ntZxiGa8n
 FqT87vHMkjdLb/pVcRc+6sS1AknPApGamNq2NPk12QcjAR76TIXkoLNbTqXhsKAs
 /22wdagg0/PJtoRv57mPdadbzWWpgWrwE7JLwTbK75kWvuyKMJD1oVJWe1O53xEL
 k5r9n2xAyF4KzuWkDofi7qsdtZqOjjI+1YfYm6ISjaDV4bIUv2n5wNTGFt3gMNRu
 pn4ecNK3wxBckg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=content-type:date:from:message-id
 :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; bh=oLrWM1x0ys/SwjJhbhz2GoauKZrsY
 C4VVYxinoCSROs=; b=RbrGXbC/gFNr9P3q8Lqy0bkbQ/TNgxRehiWenwtnYeHeW
 XVvBlzh9U/WV06jaehGJgv0S/jZBs1zlXIUFICWKgkwJ69xsPvxkEsnJV5LFKmFu
 3Uk0QmKVDVV2bXAp5mvArUZuk2V8a+lEVDTY7peOTWH4vh1BdF8ZKZqsozd7LQI6
 qJIrFaZZU9LlRW15lfVdsG8Chqo6SIoXQwC6d6HJpEKfNhl+IGJDz4z+yBTT/2JL
 cfQUV0FqoTQQMp+pkd/3XPc1eHNEFZkYjFqqHmAX53/o+FEPge73nXo1o0rhjFW4
 /14O4CFVxQ/wypG8ZAu+52qJQpii/Wn/+eIgLphoQ==
X-ME-Sender: <xms:4LOPXgmV-eakHeou3HsGN-ex1zhqk2cwn2krQBbjkX2PCkeh6WVbbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrvddugddvhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtredtre
 erjeenucfhrhhomhepfdevhhgvnhcuvehhvghnfdcuoegthhgvnhgthhgvnhesfhgrshht
 mhgrihhlrdgtohhmqeenucffohhmrghinhepfedurdhsohenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhgvnhgthhgvnhesfhgrshhtmhgr
 ihhlrdgtohhm
X-ME-Proxy: <xmx:4LOPXrY0rtS6k1i_5eI57ecA_RkApv-yZc68JNVPR8Xj2R-s_Bi1sA>
 <xmx:4LOPXl4_H7Io0k2w9cuaW1IOIHaGibt1iyEw5SJ7FArwlMeXzYzufw>
 <xmx:4LOPXk-yuCjR3uOy7hpHf5sKGOe6XCm7W905VPnkB191Wo2bwgaBIw>
 <xmx:4LOPXhkMLTSehoYEsIiEf36zKQ4jHBzrKIbrYfWltlSWXfH8Ip3v0w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 700EF4E009F; Thu,  9 Apr 2020 19:46:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-1104-g203475c-fmstable-20200408v2
Mime-Version: 1.0
Message-Id: <36b6e024-9704-475e-8b35-1fb26b22ec27@www.fastmail.com>
Date: Thu, 09 Apr 2020 18:46:20 -0500
From: "Chen Chen" <chenchen@fastmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: =?UTF-8?Q?Significant_window_rendering_time_of_GPU-accelerated_apps_on_x?=
 =?UTF-8?Q?org_with_Ryzen_7_Pro_3700U?=
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi all,

Greetings!

I'm using a laptop with Ryzen 7 Pro 3700U APU with xorg. However, I'm facing a high latency on those GPU-accelerated programs.

My system config:
---
Kernel: 5.6.2-arch1-2 x86_64 bits: 64 compiler: gcc v: 9.3.0 Desktop: i3 4.18 dm: startx
           Distro: Arch Linux
CPU:       Topology: Quad Core model: AMD Ryzen 7 PRO 3700U w/ Radeon Vega Mobile Gfx bits: 64 type: MT MCP arch: Zen+ rev: 1
           L2 cache: 2048 KiB
           flags: avx avx2 lm nx pae sse sse2 sse3 sse4_1 sse4_2 sse4a ssse3 svm bogomips: 36751
           Speed: 1183 MHz min/max: 1400/2300 MHz Core speeds (MHz): 1: 1177 2: 1176 3: 1177 4: 1177 5: 1178 6: 1177 7: 2931
           8: 2944
Graphics:  Device-1: Advanced Micro Devices [AMD/ATI] Picasso vendor: Lenovo driver: amdgpu v: kernel bus ID: 05:00.0
           chip ID: 1002:15d8
           Display: server: X.Org 1.20.8 driver: amdgpu resolution: 3840x2160~60Hz
           OpenGL: renderer: AMD RAVEN (DRM 3.36.0 5.6.2-arch1-2 LLVM 9.0.1) v: 4.6 Mesa 20.0.4 direct render: Yes
---

xorg config:
---
Section "Device"
    Identifier "AMD"
    Driver "amdgpu"
    Option "TearFree" "true"
    Option "VariableRefresh" "true"
EndSection
---

When I'm using GPU-accelerated terminal emulators (e.g. alacritty and kitty), the initial window rendering time is significantly high. For instance, `time alacritty -e false` gave 0.24s user 0.04s system 54% cpu 0.531 total, which means the window rendering costs ~500ms. This is weird for a GPU-accelerated application. In comparison, a laptop with Intel Core i7-1065G7 using the same config could render the window of this kind of applications within ~130ms, which is snappy.

For other programs, like the picom compositor, if I use "glx" as its backend, the whole rendering is extremely laggy. If I use "xrender" instead (which means no hw-acceleration I guess), it runs snappy.

After some basic profiling I thought this is a amdgpu-xorg related issue. I used callgrind to record the trace of `alacritty -e false` with xorg-amdgpu, xorg-modesetting and wayland and got different results (I will just show the first few lines, which is the hot spot in the program I think):

xorg-amdgpu:
---
280,109,580  ???:0x00000000008cd930 [/usr/lib/dri/radeonsi_dri.so]
107,423,760  ???:0x00000000008cd9e0 [/usr/lib/dri/radeonsi_dri.so]
 99,890,145  ???:do_lookup_x [/usr/lib/ld-2.31.so]
 71,160,050  ???:0x0000000000042210 [/usr/lib/libGLX_mesa.so.0.0.0]
 54,633,060  ???:0x00000000008acca0 [/usr/lib/dri/radeonsi_dri.so]
 50,114,882  ???:0x00000000000251c0 [/usr/lib/libfontconfig.so.1.12.0]
 49,050,274  ???:0x000000000001d8b0 [/usr/lib/libfontconfig.so.1.12.0]
 45,988,140  ???:0x00000000008a7600 [/usr/lib/dri/radeonsi_dri.so]
 40,037,150  ???:0x000000000001d790 [/usr/lib/libfontconfig.so.1.12.0]
 34,129,137  ???:__memcpy_avx_unaligned_erms [/usr/lib/libc-2.31.so]
 30,595,302  ???:_dl_lookup_symbol_x [/usr/lib/ld-2.31.so]
---

xorg-modesetting (similar results):
---
281,058,300  ???:0x00000000008cd930 [/usr/lib/dri/radeonsi_dri.so]
107,787,600  ???:0x00000000008cd9e0 [/usr/lib/dri/radeonsi_dri.so]
 99,890,145  ???:do_lookup_x [/usr/lib/ld-2.31.so]
 71,160,050  ???:0x0000000000042210 [/usr/lib/libGLX_mesa.so.0.0.0]
 54,818,100  ???:0x00000000008acca0 [/usr/lib/dri/radeonsi_dri.so]
 50,112,204  ???:0x00000000000251c0 [/usr/lib/libfontconfig.so.1.12.0]
 49,050,274  ???:0x000000000001d8b0 [/usr/lib/libfontconfig.so.1.12.0]
 46,143,900  ???:0x00000000008a7600 [/usr/lib/dri/radeonsi_dri.so]
 40,037,150  ???:0x000000000001d790 [/usr/lib/libfontconfig.so.1.12.0]
 35,147,037  ???:__memcpy_avx_unaligned_erms [/usr/lib/libc-2.31.so]
 30,595,302  ???:_dl_lookup_symbol_x [/usr/lib/ld-2.31.so]
---

wayland:
---
69,189,362  ???:do_lookup_x [/usr/lib/ld-2.31.so]
50,111,905  ???:0x00000000000251c0 [/usr/lib/libfontconfig.so.1.12.0]
49,050,274  ???:0x000000000001d8b0 [/usr/lib/libfontconfig.so.1.12.0]
40,946,389  ???:__memcpy_avx_unaligned_erms [/usr/lib/libc-2.31.so]
40,037,150  ???:0x000000000001d790 [/usr/lib/libfontconfig.so.1.12.0]
37,270,021  ???:fread [/usr/lib/libc-2.31.so]
30,019,946  ???:_dl_lookup_symbol_x [/usr/lib/ld-2.31.so]
23,285,006  /build/rust/src/rustc-1.42.0-src/src/libcore/iter/range.rs:core::iter::range::<impl core::iter::traits::iterator::Iterator for core::ops::range::Range<A>>::next [/home/chen/Downloads/alacritty-master/target/debug/alacritty]
22,951,556  ???:_IO_file_xsgetn [/usr/lib/libc-2.31.so]
21,423,383  ???:_int_malloc [/usr/lib/libc-2.31.so]
20,091,007  /build/rust/src/rustc-1.42.0-src/src/libcore/slice/mod.rs:<core::ops::range::Range<usize> as core::slice::SliceIndex<[T]>>::index [/home/chen/Downloads/alacritty-master/target/debug/alacritty]
19,161,509  ???:__strchr_avx2 [/usr/lib/libc-2.31.so]
...
2,936,304  ???:0x0000000000632910 [/usr/lib/dri/radeonsi_dri.so]
---

Sorry I am not using a source based distro so the debug symbols are not available. What I could see here is that when I'm running GPU-accelerated programs under xorg a same symbol in radeonsi_dri is overwhelmingly called. However, I do not know where the issue is. I did not see many similar issues so if this is related to xorg and amdgpu, this might be model-specific.

I don't know if this is a correct way to use this mailing list. If you have any advice, please let me know. I am also happy to provide more information if needed.

Thanks!
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
