Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D26BC11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 04:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2358361CEF
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 04:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2358361CEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B96126E096;
	Wed, 30 Jun 2021 04:45:05 +0000 (UTC)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 824086E924
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 04:18:18 +0000 (UTC)
Received: by mail-pg1-x542.google.com with SMTP id w15so918330pgk.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 21:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=r2hO+cn3x6slbhpi6gHl63S2Bv0jtkK/rrL+j+gb2XI=;
 b=U6f9QQjk9hm/fWcC/SE5eY3GJBUdiey2nY8wjm0f3PYa7sHzuDMNIoRcCuPklJ7VHD
 bfAxNJF4clNDUEkdD5vXmeWADsjAQodkbWG4eZvLvD0lfuW/sTcHg1Rqpf+pzjU8BH5t
 7eLcdncMzrXwFtcawGXKeKBgEPtpuYxcnXOTlCypE/GG7/1dHjzO4xsuXeVwntf2ke40
 /MdbFZKrW6F1IEDtQYOwCdQfWXyTRjwC4YKDJGFBHZDRLZAILgBcmDXxOZeFwYRAppJy
 59vsreGM/oevnccsHEYfRIvUiKAHKoS9hDvWiC1HZgLHBJ4Hiqcdp2lsQR4c99hIk1EB
 YpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=r2hO+cn3x6slbhpi6gHl63S2Bv0jtkK/rrL+j+gb2XI=;
 b=AxXv138ioTJO9A747AgcWLjWTsN8Bf+F+NI/EQiUQxm2iS8mr+viLuP8Ad9+S8u6LO
 un1BsixCJ8lt3GmwF0OJQIufAV4nvpW7i1v5CXYwfh72yEImHSZNs+6EOhpTDSDrvX//
 k2+L+F5epmN6vYmMRcO8mZTfBnGnk4xxK7FbG39k08Pp6NQmfF8Kn5Jmul/tYXwlwySq
 87JePykZ0hrai98P0E1wrqlAsIcodlVJ1I66BruceIrKZBqJwoPXVv8IqPBF8vf0jH7U
 eZgngreagi3Y2fwUxECiRUeHIzyj0Z1ntE8Ihz45rHp8etv+UTh2M3PcBpAlZW4Y7cLX
 ikhA==
X-Gm-Message-State: AOAM532Zvub4GwHKVeWahePSXBUF7F7eDWdrXGlSZbiPyYBI8+bg5zHj
 XayyhFJD6I9wHJM7YLumGzQ0I/iQShrFTN+1/FKOpj+I
X-Google-Smtp-Source: ABdhPJzJoX9XAUSvE30KyffUtZ6hBwa/BO7GIYcA5MrSEsElfIMJZkb5U3TaT9eWqLsqbg6u/Mx2qV3+33QdBv/p7XQ=
X-Received: by 2002:a63:921e:: with SMTP id o30mr32204651pgd.346.1625026698030; 
 Tue, 29 Jun 2021 21:18:18 -0700 (PDT)
MIME-Version: 1.0
From: Ketsui <esgwpl@gmail.com>
Date: Wed, 30 Jun 2021 11:18:07 +0700
Message-ID: <CAB3xKZ1VKgaP+Xg8kqwGkvqdmJD6BRjYSajbM7Udnt1iA9WubA@mail.gmail.com>
Subject: Re: AMDGPU error: "[drm:amdgpu_dm_atomic_commit_tail [amdgpu]]
 *ERROR* Waiting for fences timed out!"
To: amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Wed, 30 Jun 2021 04:45:04 +0000
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
Content-Type: multipart/mixed; boundary="===============1643036939=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1643036939==
Content-Type: multipart/alternative; boundary="00000000000016347b05c5f40317"

--00000000000016347b05c5f40317
Content-Type: text/plain; charset="UTF-8"

>I think the 3200G may be a raven or raven2 variant rather than
picasso.

Are you sure? Examining vbios_version yields this on my system:

$ cat /sys/class/drm/card0/device/vbios_version
113-PICASSO-114


>Can you try the latest firmware from upstream:>https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/log/amdgpu <https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/log/amdgpu>

Sure.

--00000000000016347b05c5f40317
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><pre>&gt;I think the 3200G may be a raven or raven2 variant rather than
picasso.<br></pre><pre>Are you sure? Examining vbios_version yields this on my system:<br><br></pre><pre>$ cat /sys/class/drm/card0/device/vbios_version<br>113-PICASSO-114<br></pre><pre><br>&gt;Can you try the latest firmware from upstream:
<a href="https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/log/amdgpu">&gt;https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/log/amdgpu</a><br></pre><pre>Sure.<br></pre></div>

--00000000000016347b05c5f40317--

--===============1643036939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1643036939==--
