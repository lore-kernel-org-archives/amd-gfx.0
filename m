Return-Path: <SRS0=cAof=3P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A2CC2D0DB
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Jan 2020 16:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2138C2071A
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Jan 2020 16:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdNlJV5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2138C2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4C56E9CC;
	Sun, 26 Jan 2020 16:13:22 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E245F6E21D
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Jan 2020 16:13:21 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id z3so7967977wru.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Jan 2020 08:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=i9ITdUEO2cn6Ok9f5FkP5ebbwAOWMbW7df48UYXfuOo=;
 b=hdNlJV5tDUfRZW755jTdW/2ShmKyXQ6jmzsKQhN4jGYwejSFhaP2u2ETMvzmV6K/l8
 tzvPDAQXc/h2gTsrhLwVhvH6psE+IcRgBLDeOkxeIbKRQbcN2YGbpzWbL3v2EZRJfi0l
 FF9Jdngsi+bnHLiJFZTHdqUc9MxMDTGNiItgqnGFvh/XjxXUKEC8tSL1UdrzJy7JgLI1
 QMR2b5ZAVfMpvMLglSqE/jkZkJHQU0cEAZ3CiHM2OJeF9XBCVgOx/LyGoF7mjZ6eKEEh
 prsMZjAsevkDYAyPjV9AooKMc1f2RekfYWN8nDIA96PkffbFiXsQMr8idmQ0CZi6IZ6F
 x9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=i9ITdUEO2cn6Ok9f5FkP5ebbwAOWMbW7df48UYXfuOo=;
 b=ORMOq6T8M1cjgveCEGyIEMj0LhydFZPv7cXpxcHKkN9i/x17KpsEUBJlLrJy8w0+MC
 hvoPIAASwvSQj2Kmgp1z33hN/9Q6VSlMdCFffjFTKa9qqlX91y6z/JCCz+paqrujxAEp
 Xl5o981Wip+aWqvQdmQ1Io52qjcfAGN8v8NC/+EsTWbyiMsYxFTVNkNfAqqa24DG3230
 o//mJjGWHGOnAV7wkHcDoFollRDrm1yhy8vf0D1oO7QpNYWPnJlY4Q0prSrR8qtyH04f
 bWcvDwQKJeaXli0S5bDetzpgbUUM4ufGqhWsGdtoSd57KeMipayqwZIge6HzCQ22BZ9E
 DrlQ==
X-Gm-Message-State: APjAAAUoiOc1vKx877KLVJLgoVIg9x8qag+G875VwnqchVfm7Sg4/gRY
 WMBYxdnHiS897+9bWuGsOVE1RZlw6W7VP11pJM1+47R39MQ=
X-Google-Smtp-Source: APXvYqzMsTzL+bAOh8QG91VpQs/BUiljaqHhw5o0H7U4PT5mUn3sVVmlMpyRhmK5DM5BeTexdf89wyKakMtkJEVoTHw=
X-Received: by 2002:adf:ffc5:: with SMTP id x5mr16542830wrs.92.1580055200118; 
 Sun, 26 Jan 2020 08:13:20 -0800 (PST)
MIME-Version: 1.0
From: Mauro Rossi <issor.oruam@gmail.com>
Date: Sun, 26 Jan 2020 17:13:09 +0100
Message-ID: <CAEQFVGa9tzYgZeGLs5UY6yHfSHNZ0+Uqo3rTUzPjO+d7E2o-bA@mail.gmail.com>
Subject: Raven: freeze at 'modprobe amdgpu' in early console with android-x86
To: amd-gfx@lists.freedesktop.org
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
Cc: Chih-Wei Huang <cwhuang@android-x86.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello,
I am having problem to load amdgpu module with Athlon 200GE, on a
motherboard MSI B450M-A Pro Max with latest BIOS and a DVI-D monitor.

The same HW setup  boots Ubuntu 19.10 Gnome Desktop Environment with
APU HW acceleration without any issue.

When issueing the command 'modprobe amdgpu' in early console the
screen just freezes, but I don't see any [drm] amdgpu output on the
screen and the modesetting has clearly failed.

I have tried with kernel 5.3, the same as the one used in Ubuntu
19.10, and replicated the %AMD% kernel config options extracted from
Ubuntu.
I have the same issue also with kernel 5.5rc7 and up to date linux-firmware.

In case you have experienced or know about similar issues,
could you please provide some info/suggestion for me to try to
overcome the problem?

Are there some implicit additional kernel config options required besides
CONFIG_DRM_AMDGPU=m, CONFIG_AMD_DC=y, CONFIG_AMD_DC_DCN1_0=y,

or some undocumented module dependencies, which are mandatory for the
Raven APUs correct detection?

Thanks for any info

Mauro Rossi
android-x86 team volunteer
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
