Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28B7CA5FD2
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 19:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 223BF10E31C;
	Thu,  1 Oct 2026 19:19:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GPK37y5e";
	dkim-atps=neutral
Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com
 [74.125.224.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45FBA10E26C
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 18:41:14 +0000 (UTC)
Received: by mail-yx2-f43.google.com with SMTP id
 00721157ae682-895eaf31683so72308007b3.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Oct 2026 11:41:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790880073; cv=none;
 d=google.com; s=arc-20260327;
 b=l6/ub9csLnuQy118xF+FORNWlVthzcM77NFpFKEF4z7lGIA9Rl+TY9zRZRzaZaAoQa
 Ax72lSPaq0HIU7ZaU77Csl7lOKplLridmOMTNV20Qs0g/GEbnEhQTv9P9ahV5fmbeGwU
 fHRVD1+4wRJCCpMp/hUVWCAtNa+9oQVyFAHa7lG+V+UsF7bhP0RoK+H8uwWYHYR6O5ws
 tagULdPqtyiV0xGQtOdLK4LG5W3UZv46tARPU6rB50x8pi8rK7jJiUhV4CYjyXhWvbZJ
 z8t20aXbDyT0QrGjbFkjxJxTSRO/uxE6R7/zlm3nM3Ow/tr1D5wNEBnLEEkhiyA96enx
 TylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=GsEf+Fo/Nm83KwjTiTwDORBQboxBUEL4sfZSNqu1hb4=;
 fh=UOs4AE4qjGd21zFslyBEqQZetRrW593aa1+yYb021Fo=;
 b=Pd8z25aBDyTBV8FApiwJ9GqUxNM3OVnWDxsyf/3VmMHPtShD+iNEaP8OrL9YYjI3Xm
 ABB0H96Rdo59D1kUmKr76fvyaWT94DlZu+jyQTFBHFDAi2YFrGj166lj2pmi4PS3LjTi
 lle4tP7YvVBI7jgBr/9xzACNNhH8Qn/M3HIFRY4IwkB1CZqVmeXZLsQOy2U/eMBZCdRj
 tMIlmy6J+XMxT9TJOFbkVHGcHTWFw+DZsU6B1t/nxUrrS6gZLNDnqE+BDlVRiehSCAbO
 lemFrj/C13rtRcIjAT+EiBZ5tjJz/Z9D/i5W1vMXnwckrgKaIfThjKksea0jceU8+cC5
 CdUw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790880073; x=1791484873; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GsEf+Fo/Nm83KwjTiTwDORBQboxBUEL4sfZSNqu1hb4=;
 b=GPK37y5e/kOK6IIucYzmPCx2UmvRxUuqbLE/9wGnBvpzQzsldEZuAZ6cNHFNUgUC5q
 69/tHx/QrLUpsNGETLNWYmWa1ZFNVHmPMRLFlWzYywQBfLIRHwuNxwKZV3o8z7kAUKYv
 nygHzidWDubY4T9lnQ3H5zssqOPH3lGY7AqWUekHF8Eiu0x0hN+vxYLyd0VWJQinHRrJ
 l2Ui4eOuxsWPBSz+Lek2ymnOWjq3HpC5H0vn/Typ5mSPpUnhvV+CQgfTgXJawgJB1US1
 sbHt3WLMGHQNp5rZT4IXN5x5vcvqG4jW8gsz7xM/hZ0giYW1O4YA+mtQWod2xs0SkGaF
 zAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790880073; x=1791484873;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GsEf+Fo/Nm83KwjTiTwDORBQboxBUEL4sfZSNqu1hb4=;
 b=sZtNRvgHJjW44FiHd24RNAJInN8ZElPy8hDLkEBRQjB4B+Or635sUFQZdh0yl+jphO
 ohSdQ+6Z8CHwI50dG96Uo5fmUrNW5WcEBghmfuAAO7tteushT9sOjDBWPcz2F8srK6+J
 TkPdp9/uyMVFBSE16hGRDP+9n3/vtTlFjOKFtcepEk/XsT1KADGUP2qcznN1YY7wymJM
 F3mvW5FtpnbTjhuRneRqdSXFZ71sl04ICzROSxLufd1Y9FTI2XDzpuk+VFUz6lw9B9dL
 RKL4vOAJeHM46is19/6v4HLBu+oqbT3nJGd44ZaqfeOrF3Hvjy26e0Dq8nX8V050H12H
 7D6A==
X-Gm-Message-State: AFq9FYKnLQlXWptiePL40xTrC6uNV/pW+hzayscmnaCZu9FJID98cmVI
 yAeIlJQ+VVSQH0etZwe5fiyRjFKvtkWnw9hTkeF2WrPSN6wBMDm/dh6BSKcF5fbySeBCHYpPKX7
 63M4vPsqagl3U66Vo8xMhkgFVsZZtI4W64Q==
X-Gm-Gg: AYBFou19Hq7t4g8Oad7t7rDce0s619/jC0TRXt7ro9NrpsNhvPFrlwg4CSoquMo4Nb/
 ThRQefCKGqEsKIBEoUzfqWkq30TqM4KA07i3AmTQDrOAbgQmqJY+uxMB7jyNabW5RWWPjRQDlM5
 6/y0id+Wv/gY4acD5qR0X3oT+N3jkWKNxt11rlUCRLOEMg9UeY9lcm2Stv3ABtuq83fnM44nTAo
 KvsvtZdtAKT6ufwVJ3ke2oayJaQS9hC+Hc9AkiRmRIBw+qVllwZBNwyg4r4zChCCGwZsN3a5It8
 2Gh+zqOEsCyDQbcZlgt2TLTyEGIUNupJUSW97WLqD3n/ek1vEWRdsIYW8TzPXCoRE+83YNXtZPe
 z+SkwxBUN
X-Received: by 2002:a05:690c:6607:b0:8ab:33d2:1534 with SMTP id
 00721157ae682-8ae39c0aac1mr814467b3.40.1790880073054; Thu, 01 Oct 2026
 11:41:13 -0700 (PDT)
Received: from unknown named unknown by gmailapi.google.com with HTTPREST;
 Thu, 1 Oct 2026 11:41:12 -0700
Received: from unknown named unknown by gmailapi.google.com with HTTPREST;
 Thu, 1 Oct 2026 11:41:12 -0700
MIME-Version: 1.0
From: Amd Alba <amdalba97@gmail.com>
Date: Thu, 1 Oct 2026 11:41:12 -0700
X-Gm-Features: AclHuK_nXdhDmIP54EAHn2l6HTJxCzbea50IPaC6LEuDAALUxfL6ZwLBH61MuZg
Message-ID: <CAJN0=HzowNF=GLUh8_smX5_+0u46JrzJaSJVQ5pm-8wiuYEErg@mail.gmail.com>
Subject: [Bug Report] Black screen on Lenovo 14W (AMD Stoney / DCE 11.0) after
 updating to Kernel 7.x
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 01 Oct 2026 19:19:30 +0000
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

Hello AMD Graphics Team,

I am writing to report an issue after updating my Linux kernel to
version 7.x (specifically tested on 7.0.0-34 and 7.2.6) on my Lenovo
14W laptop.

When booting into Kernel 7.x, the internal laptop screen stays
completely black, whereas everything works perfectly on Kernel
6.14.0-37.

System Details:
- Laptop: Lenovo 14W
- Processor/GPU: AMD A6-9220C Radeon R5 (Stoney / DCE 11.0)
- Operating System: Ubuntu 26.04

The diagnostic logs show that the AMDGPU driver initializes, but the
display output fails on DCE 11.0 hardware in Kernel 7.x.

Please consider fixing this driver regression in upcoming kernel
releases so that users with Stoney/DCE 11.0 hardware can run Kernel
7.x smoothly.

Thank you for your support.
