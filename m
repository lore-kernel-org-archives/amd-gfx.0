Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F34C83003
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 07:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F612073E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 07:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F612073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F17146ED10;
	Wed, 29 Apr 2020 07:29:15 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3AF56ED12
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 07:29:14 +0000 (UTC)
Received: by mail-lj1-f177.google.com with SMTP id f18so1463108lja.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 00:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:openpgp:autocrypt:message-id
 :date:user-agent:mime-version:content-language
 :content-transfer-encoding;
 bh=ZULs35QrIOCrUWSoio2TY2qESNezPY77OrX0tXeO8Lk=;
 b=TxJ8L1Hs9+ASakWebt9XXCJK2bhf5Q1V23QsQkYgTislb5ZV+wtkUsZmxN/yR2TTum
 BfwqrAru/r10ZBICJy7/k8a++7XF1S4fRY+wUf+xyAw86TX5Q7Xmf/3TqR2BM3AiImZu
 GD8Z9UzwxaV1u76b45LqtNAne9VeYCrcZ397tPl4YUNHyxTlrdjm9Egb0gtY8rFG6k9M
 RDTCvrCWp14YH328a1FeR15TqhzJy4iIYMBbK7PZF4TtIRVphDYGR+DDwB0sJUul0+o7
 6/Ke9KUx4i9wQZuWDZMFp11Bh/nB+zwUWrj5duuaaAjHuWr61wu4cq/M1EMiuYJEeeax
 /C4w==
X-Gm-Message-State: AGi0PuZ3VgAC02jLYD7YZra+YHnx9lLY/FFSE/fhSuNQ9LwymECw/OG1
 2s6F7O75bQE9Sa0uDNPJFvU+qxy4lLY=
X-Google-Smtp-Source: APiQypIU8mL8N+lHk/4ct34aFvZpoQ7HT4cxx2XM9UkjERcZScAzjWA4FCdOcObl0P5KE2505elHpw==
X-Received: by 2002:a2e:700e:: with SMTP id l14mr20501936ljc.135.1588145352721; 
 Wed, 29 Apr 2020 00:29:12 -0700 (PDT)
Received: from [192.168.0.88] (east.meadow.volia.net. [93.72.151.96])
 by smtp.googlemail.com with ESMTPSA id o25sm1804303lfg.41.2020.04.29.00.29.11
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 00:29:11 -0700 (PDT)
To: amd-gfx@lists.freedesktop.org
From: Andriy Gapon <avg@FreeBSD.org>
Subject: amdgpu, dc, backlight brightness
Openpgp: preference=signencrypt
Autocrypt: addr=avg@FreeBSD.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8db5ae80-0b9d-7d44-18b6-5641eab0ac0d@FreeBSD.org>
Date: Wed, 29 Apr 2020 10:29:10 +0300
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Language: en-US
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


I see that amdgpu_atif_handler() has this comment and code:
                /* todo: add DC handling */
                if ((req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) &&
                    !amdgpu_device_has_dc_support(adev)) {
...
                }

So, this makes me curious how a typical Linux distribution handles backlight
brightness change via special keys hooked to ACPI.

This is what I see on FreeBSD.
- a special key is pressed
- there is a bunch of uninteresting ACPI and kernel stuff involving EC
- ACPI notification 0x86 on VGA.LCD device is handled by acpi_video driver
- the driver invokes VGA.LCD._BCM method
- if I read the ASL of my system correctly, ACPI does not touch any hardware
  but simply saves some things like the requested brightness level
- then ACPI posts notification 0x81 on VGA device
- the notification gets routed to amdgpu
- amdgpu invokes VGA.ATIF and gets some interesting data from ACPI
- and this is where things stop in the DC case (because of the code above)

In the non-DC case amdgpu would actually set the brightness based on the data
returned from ATIF.  radeon driver also did the same as far as I can see.

So, how things work in the DC case?

I see that Linux acpi_video does something that FreeBSD doesn't do, it posts
KEY_BRIGHTNESSUP / KEY_BRIGHTNESSDOWN / etc.  I guess that in the end this is
similar to just having the corresponding multimedia keys on a keyboard.
Is this how the brightness control supposed to work?
So, there must be some userland program listening for those keys and somehow
knowing about amdgpu backlight controls (e.g., /sys/class/backlight/amdgpu_bl0).
Is that correct?

I tried a live image of Void Linux (LXQT flavor).  While it does handle the
special brightness keys it seems to do it without actually controlling the
backlight.  That is, it makes the picture lighter / darker, but values under
/sys/class/backlight/amdgpu_bl0 do not change.  If I set brightness under
/sys/class/backlight/amdgpu_bl0 to some low level then the brightness up key
cannot make the screen brighter.  So, it appears to be just a rendering /
composition trick.

Thank you.
-- 
Andriy Gapon
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
