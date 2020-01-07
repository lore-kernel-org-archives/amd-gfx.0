Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA30CC33C99
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 05:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4EC207FD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 05:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZ8ewcZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4EC207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 325BF897E3;
	Tue,  7 Jan 2020 05:15:07 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B27B6897E3
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 05:15:06 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id c9so52454058wrw.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jan 2020 21:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1K0FtBJVbB2Gg2VGC3a4pbpyIb/tsNUwEVD3Jd2FGxA=;
 b=rZ8ewcZ07/VsOB1BzY0YnDoogCPsG6SyrrpG5dLeIHdFyW7grSN/TDnk3XyyvIg96P
 YeZGmi1IAXRUCNewb7prPzw1cDftdh5GAIKLmknwsODgYBEQihqyh2LrlF0D3qhsbBw8
 6XPorWmCA3pF90wxYZqdZ38o3YShoCCf0z0z7X6dSJdUQEc+5UvCHcktg6NM++P8YdXF
 KyFaxsmCadbvOYCSTas8oNRX4PDocdfVl+yfZg3mYvN0FSFOzcYo031ULkLvzhl0Yy/I
 nu469BbueZ8F7wnbfsHkaifriHSdIofqX518AJ4rUvNOD37vYC9aR45oPP2U5MM0vun5
 lqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1K0FtBJVbB2Gg2VGC3a4pbpyIb/tsNUwEVD3Jd2FGxA=;
 b=nvygTlyLTPmi5/m8tAfa9EgPEHN+1PcIUbKVtRbkv/yxyDs7GDjBmX689YmlMaezcH
 HxbhU7e01ALxfI9+JWDZDeKH7T3FCddjn3Y98BhyREPuk3zVqNV3gQuVbh+uP3NpZyGW
 qmNPezd9Fq/0ukkMuccyHl2HrcVLs4T/BzkGr8PwalAjk/1JylIGaBE02q51re81he1E
 RgRwY7ZESHRRCke23AcDhBTyY/qZ7Rgu6x73OgCdZ2oGkeVkPfgaZHQGd1zkaj86dnN9
 JXwfjMIungBwixVQ5jp9oqcqt5DrGm6tcvnc27HNEzPDN/sOyiYL5wUDNfLLwnmuy8iA
 BFsA==
X-Gm-Message-State: APjAAAVHOJgfCc4eEPxfo4vLV6QZu3PCqZ1/h500IRGI1E5541K3ODze
 uoMxQu+HEH0NcQCdkJ/fOuOYwpMB6hgWHMmO+BPtVw==
X-Google-Smtp-Source: APXvYqwbrrdwWN2qZS0TJIeR1yFm52VLN9IK5BDP0ye8B9y+IVsXaoq1esRnE5HPb6Rn/591cWzdazSV+cXBRhZ1Nng=
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr105816965wrs.11.1578374105281; 
 Mon, 06 Jan 2020 21:15:05 -0800 (PST)
MIME-Version: 1.0
References: <bc6634bc-a7a6-d71a-8127-31fed3cd3d81@fripost.org>
In-Reply-To: <bc6634bc-a7a6-d71a-8127-31fed3cd3d81@fripost.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jan 2020 00:14:52 -0500
Message-ID: <CADnq5_NmEwiGaPhu-Zh=7+jnEprW1tSWoaDrak82H2v0ErsmnQ@mail.gmail.com>
Subject: Re: RX 5500 XT hangs kernel on boot
To: Arvid Brodin <arvidb@fripost.org>
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

On Mon, Jan 6, 2020 at 11:59 PM Arvid Brodin <arvidb@fripost.org> wrote:
>
> Hi,
>
> So I tried to use my RX 5500 XT for the first time today. Kernel updated to 5.4.8, fresh navi14 firmware files fetched from the linux-firmware repo, and of course power cable connected to the card.
>
> Booting the kernel hangs when the graphics are initialized (on two different OS:es: Ubuntu 18.04 and Gentoo, Ubuntu with linux-5.4.7 and firmware updated today, Gentoo with 5.4.8 and firmware from 2019-12-15). There's nothing on the screen except sometimes a non-blinking cursor - I get no error messages.
>
> So I tried to boot with the iGPU as primary with the RX 5500 XT still in the box. This works, the card is detected by the kernel, firmware loads etc, and it shows up in xrandr. But when enabling the output (something like 'xrandr --output DisplayPort-1-2 --preferred --same-as HDMI-1') the computer "half-freezes", as in, I get a little bit of reaction every 10 seconds or so - caps lock change, a kernel log line is printed, etc. Mouse cursor moves but system does not react to clicks.
>
> Kernel logs at this time looks like this (copied by hand from photo):
>
> kernel: [drm:amdgpu_dm_commit_planes.constprop.0 [amdgpu]] *ERROR* Waiting for fences timed out!
> kernel: Asynchronous wait on fence drm_sched:gfx_0.0.0:11 timed out (hint:submit_notify+0x0/0x80 [i915])
> kernel: [drm:amdgpu_dm_commit_planes.constprop.0 [amdgpu]] *ERROR* Waiting for fences timed out!
> kernel: Asynchronous wait on fence drm_sched:gfx_0.0.0:12 timed out (hint:submit_notify+0x0/0x80 [i915])
>
> etc... (a new pair of lines appear about every 11 seconds).
>
> I also get noise/nonsense output on the RX 5500 XT's DisplayPort at this time.
>
>
> I'd like to get my graphics card working... :-/ Any ideas?

Please try a 5.5 kernel.  Some users are reporting problems on 5.4.

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
