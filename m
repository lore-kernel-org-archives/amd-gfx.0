Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11BFC5DF66
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 12:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8917210E7B7;
	Mon, 17 Aug 2026 12:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bOFYr5D4";
	dkim-atps=neutral
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE30F10E3E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 09:00:31 +0000 (UTC)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-39f1ac13687so19830411fa.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 02:00:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786957230; cv=none;
 d=google.com; s=arc-20260327;
 b=CMeiL3D9alcTFqu+2htASz0Wmu1FfkxS80+1ro5vTlzRvrse0imwXQCNCYvWxwMHwv
 0o71KOKjb1opYpbt4UNPJJrOLi8mYI6xDRy6EEAV0ioxGOYE+lliVM4agQ91pIz5QpHD
 MEhEbB0MFl8lyMilG1uyivGs8e3GPe6APtjkfCyWmHbFhB3QGE5o78hnR+QFBZ7zCihw
 2WBTt0EbnOAyJYrLtD/FIyJ1Ek7FHoUfMXxZSvv27YHyEh9Ntbso0bb5lznuSBLFL0Xm
 hvVE5peOwjCNH58MA5exNIp9aIZETHhgzX2DeAmZYGFPdlT6btyaNLeXoWkKahx34DDF
 pB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=KNqqJlI2REFZpUo7pV8swC9FJKKHYnkZc8NvSBnzIN8=;
 fh=9c6Qu4fMhoS3A6HgGA6VXMgtHuoeksIng+UGlhqF+YA=;
 b=hg12uyBlfYW6r1jY8ObNuBNR81LqQnx30F3j+vsd/ff2p6qa7/2DM15R9ZRFTubSkT
 o6+efNFIUie02TX5+JrwQ0pCMu1BeeHNit6lfiP9dG+kB3CvPO993Tek65x6SoEterNO
 tb4FGS373Y4hUHFvMj39K03UPeNcT4STtFiWk1apwRabG+CC3JQwykt/5tldipPzEdxG
 2X09qYht9vbE77BGfekvrULX2YTFoNN3GidJ4zF00CWQmxIiFX11EqCKw2RDg3hTJM7O
 GsRSW1UahFUOAywyAHkeBv89tMEC3mwAjDnLU7itq0ZV8REg1cI8P/FaW1GN4nDMnPsA
 rqpg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786957230; x=1787562030; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KNqqJlI2REFZpUo7pV8swC9FJKKHYnkZc8NvSBnzIN8=;
 b=bOFYr5D45OzYTepTz7WwavAsAVDVtr99Ufn1TCvb0d5iBTC4GGe7s49zPsJacwOOf3
 NhTi1MkvHwjNjmH8NXsEr2ySd6x2RO1a6jwcio5zu2CgsTAsY4KCHtKdxIp/4VrbeCfV
 PUqdHXW0JRz/LuAZbe9TutVV781Q7SvRhnrf7H9itDiCzB6iJmMfUhHD8CUNR+2179o3
 SycZnjHTC5wGPYK/LnABiH3knAi+iG6iGKc4qfDjvfPZmsxp2ATV5rntvjnNP1PHauxS
 OdFqw1sRB5eoMMl9MVSUUC0QUu+0FgRsoIXAs2XIMdSp2ZBn4o/6mNmK5ePthTbnqOvD
 SNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786957230; x=1787562030;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KNqqJlI2REFZpUo7pV8swC9FJKKHYnkZc8NvSBnzIN8=;
 b=WTVBJCPKyIen3+6XXfLSpUKA5okbB5Z9Kf1FAKwIonezlCYhICBJvRbALFAB0I2w0H
 OV5zpnFqd4d4M5ti2mATgNBDISPnJ27/wxqNPu/x+WzZdJUGFAKeI6FQmdyGICeK4niB
 1As+llctpwRy0n58LqAjPYydmTUVwb9S4CEnZBsO/jIIXdnrt35ZsjUKDqAkIWHBjG+h
 fhttK5uriMtUlCbpQoTfUpa2y2qZurOJ/SYVq/KPAiDEPlRVgKgyFQc7+3IB0TAD8rjh
 6hwMBRFDPRfXL/njQnMV8mzYKqEuNZiDYKKPeSyu6V1sqlNNHpTDHCsSe58TYX3jmDeE
 mT4g==
X-Forwarded-Encrypted: i=1;
 AHgh+RquhdL3k9uC/nZe9Uk6NcTbqa/7E/cj392q4lbKXK1hkzLQsuCDCS+/Xq48Ko1rww/7tmZsftUU@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGAbPrZTKiVd9d97keuIJsF9yclxLbo/4/QzdFmwaknOk4HOse
 VbC8XhADkCPV3jhPdAe9ioeyjVQxaH1jP1MZuWOLtH0Okkv7bPlQSO9rm3RL1DGj/Pz1H/6fiML
 QDM+2Iqn1N1w3yHAfMv6cJg+LDoT50bg=
X-Gm-Gg: AR+sD11HTPFj+EsarLaksAcG4iZcDzJQbcrbg6WKXIIjmCehfnaSLnyMaJdvcmLh5fu
 Xhvv7bAmesoNUFUu0u8txGd7t+M+AkDRSzZOJfSk4SKz60xnN28+gxolZssSlmnR+m6MLKJH0A+
 Ru0Njbo1lAEW0+JqBS2MzfbDyRLKwb3/y6cMuYQAtl7S245JR2oy1m18LBFVAtbWhkQy9i2aSjJ
 7rku+zJK9/wzDPfMxZBCV6m/r6onk5rbFd+dtKPxpne0MeFB7gMtgL1WV0DnsoHrB3VWfFgEuYh
 DqjQQWeeBqec1w5fP0t5Z1nUpx1zsfKQIpsy2xfimLpzMIYiIvBJlejaVhIjCKF6rCH1dmJt7Xj
 v
X-Received: by 2002:a05:651c:19a4:b0:3a1:1d3b:67e8 with SMTP id
 38308e7fff4ca-3a13240a3f5mr27421201fa.12.1786957229563; Mon, 17 Aug 2026
 02:00:29 -0700 (PDT)
MIME-Version: 1.0
From: Antoine Richermoz <antoinerichermoz@gmail.com>
Date: Mon, 17 Aug 2026 11:00:18 +0200
X-Gm-Features: AcwNN1VIBU6ZcOgP70o4UU2CTtcY8WxIfzKLycfZkq4q9FwwT4gtB0dOgjos7hY
Message-ID: <CALLjWgau9HxiiTuOYnMWrwCT1st5CzfBTQQZ9qo4NLQRyPtwXw@mail.gmail.com>
Subject: HDMI FRL: EDID max bit depth is preferred even when it forces DSC
To: harry.wentland@amd.com
Cc: Jerry.Zuo@amd.com, tomasz.pakula.oficjalny@gmail.com, 
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 17 Aug 2026 12:55:07 +0000
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

Hi Harry,

A question about the bit depth and DSC policy for HDMI FRL, with test
data from an RX 6800 (DCN 3.0) driving an LG 42C2 at 3840x2160p120,
stock v7.2-rc7 with amdgpu.dcfeaturemask=0x402, direct HDMI, no PCON.
As an aside, with Tomasz's out of tree HDMI VRR patches on top of the
same base, FRL and native HDMI VRR come up and stay active together on
this DCN generation, which I had not seen reported anywhere before.

By default the stream ends up at 12bpc with DSC on, at 3 lanes and
6Gbps. The path there:

- FRL verification trains at rate 5 (4 lanes at 10Gbps) on the first
  attempt with no fallback, so the link is not the constraint.
- Color depth is committed before DSC is considered and defaults to
  the EDID maximum, 12bpc. At this timing
  dc_bandwidth_in_kbps_from_timing() gives 42.77 Gbps for 12bpc RGB,
  above the 40 Gbps dc_link_frl_bandwidth_kbps() reports for rate 5,
  so apply_dsc_policy_for_stream() enables DSC.
- Nothing afterwards reconsiders the depth. dc_dsc_compute_config()
  is called with the 12bpc timing and the sink advertises DSC decode
  at 12bpc, so it succeeds. The DSC target comes from
  frl_dsc_max_frl_rate, which is 3 on this sink, so 24 Gbps, and
  hdmi_frl_decide_link_settings() then walks up from the lowest rate
  and stops at the first one that validates, 3 lanes at 6Gbps.

Capping GNOME's max bpc setting to 10, via a maxbpc element in the
monitor entry of monitors.xml, gives the other outcome on the same
kernel, cable and display: 10bpc RGB needs 35.64 Gbps, fits the
verified rate uncompressed, so no DSC, and the stream runs at 4 lanes
and 10Gbps.

I am honestly not sure which of the two is preferable. I have not done
careful side by side testing and I cannot see a difference between
12bpc with DSC and 10bpc without it. What made me look in the first
place is that the AMD Windows driver ends up at YCbCr444 10bpc at 4
lanes and 10Gbps on the same GPU, cable and TV, and without DSC. The
TV's info panel flags DSC when it is active, and it does flag it in the
default Linux case but not on Windows. So I thought you should know the
Linux default lands somewhere else. One other detail that may matter:
this sink advertises DSC decode at 12bpc only, with a DSC FRL rate cap
of 3, so uncompressed 12bpc at this timing is not reachable on this
link at all, and the panel is 10 bit in any case.

So the question: is preferring the maximum advertised depth deliberate
policy for HDMI FRL, or would it make sense to try lower depths
against the verified link rate before enabling DSC? The max bpc
property does get there, but it needs the user to know that, and on a
GNOME desktop it means hand editing a config file that configuration
tools can rewrite, while the driver already has the information.

One thing worth flagging, since it bears on any step down: for
DC_LINK_ENCODING_HDMI_FRL, dc_bandwidth_in_kbps_from_timing() returns
the raw pixel rate times bpp product and it is compared against the
raw FRL line rate, with no 16b/18b coding overhead on either side, so
the comparison is optimistic by about 12 percent. 10bpc at this timing
is therefore a lot closer to the rate 5 limit than 35.64 against 40
Gbps makes it look. What actually gates the mode is the capacity check
reached from frl_validate_mode_timing(), which did accept it, so
nothing unsafe happens today. Two related loose ends there: the
dc_crtc_timing field that would supply the accurate figure,
frl_uncompressed_video_bandwidth_in_kbps, is read in
dc_bandwidth_in_kbps_from_timing() but never assigned anywhere in the
tree, and dc_link_frl_margin_check_uncompressed_video() is exported in
dc.h and wired up in link_factory.c but has no callers. If a depth
step down were ever added, gating it on that check rather than on the
coarse comparison seems like the right basis.

I also have a debugfs proof of concept that does the step down inside
apply_dsc_policy_for_stream(), written quickly with Claude Sonnet while
I was diagnosing this, which I am happy to send if it is useful. It is
not needed to reproduce any of the above.

Happy to run further tests or provide EDID and FRL logs from this
hardware.

Thanks,
Antoine Richermoz (rcmz)
