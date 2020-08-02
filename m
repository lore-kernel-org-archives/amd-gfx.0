Return-Path: <SRS0=/NoH=BM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEEBC433DF
	for <amd-gfx@archiver.kernel.org>; Sun,  2 Aug 2020 23:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52F1C2070A
	for <amd-gfx@archiver.kernel.org>; Sun,  2 Aug 2020 23:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen-nl.20150623.gappssmtp.com header.i=@basnieuwenhuizen-nl.20150623.gappssmtp.com header.b="HuMl3B+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F1C2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EEAE89DD8;
	Sun,  2 Aug 2020 23:46:38 +0000 (UTC)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BB8389DD8
 for <amd-gfx@lists.freedesktop.org>; Sun,  2 Aug 2020 23:46:37 +0000 (UTC)
Received: by mail-io1-xd35.google.com with SMTP id k23so36774303iom.10
 for <amd-gfx@lists.freedesktop.org>; Sun, 02 Aug 2020 16:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen-nl.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=BmjoxHc1zlu21CTjiRIcfA9t7yGCj9KfnB/EvOJbJPI=;
 b=HuMl3B+LAYU+7/+OQbOrqvEGzT4hEeSSAsv6ctM9GZRvDlzzAxZhnHdySny5hGKt5w
 DSEb1MvZzMwAYHCH8q+1dvtF1bGwMOWZdfvHgoi2wklrLvMXlxtND7eTgay1XRDu9cbv
 65ER06QaWr2wpvIrXBT07jIHGmvRG9et8mY2fsc3cVDXvJoUV34ZplXV9KVHSYprXsV+
 Kek/78jpl82rvxRhOurM3rT03I1svm4KVE+Dr7lD/pFnXtQiHMkyGP3dn9gpZaWg9YWh
 F/H/OD6TljgAPCMb9lQerx2+k9scaab4A7Mjxdne3B8EeGzIY1IS47EjgAbN7d33fcnj
 kX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=BmjoxHc1zlu21CTjiRIcfA9t7yGCj9KfnB/EvOJbJPI=;
 b=qxg96gcjfjw73eKoeitsCMueA4ippyyz3k5NzZx7sRAWbVO1PAiThmwNSzKPV6ANCC
 v3geVM2VApyCg0Aouj1vFWBF8OgtSOE7/J2rtyemGzqHbVCODb4kx4lt3Rnw2i/GF+zZ
 HN0vTcHcj+xnBbScG4rYxESs0ZieBEtzzDWAy8XUkxmCCnGm6w09o2WvvgYclmbyG8fE
 PuOjJSW073gfB/VdvDp4trr33fyfABTneNRSMcjc5AHJZZIeOahCAkGN+uXXcQmUwKRC
 KM79ildkFci287/FK2NItFnL13XysUBPZxeQLgJkSdK6V4pWdLWPLhXao5zmz4TU+XKj
 HYew==
X-Gm-Message-State: AOAM532nf8E51D8yGI8HGRFkSb8kbRnRWQmuaGKakUVjDJvr53tDzySI
 MUye0Z7nuaULyl2JYJQOtsjZmSiX2cPaKDyxg6f5YfNYgHPiDw==
X-Google-Smtp-Source: ABdhPJwN8D9Z+Yw99hOUeS21Mot71amOU51RiepN7cTh2lhtNVguAPI91I8LUHnWN9HflMCiBOPpAxuTaeYkdzn5OZM=
X-Received: by 2002:a05:6638:621:: with SMTP id
 h1mr17260998jar.143.1596411996292; 
 Sun, 02 Aug 2020 16:46:36 -0700 (PDT)
MIME-Version: 1.0
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Mon, 3 Aug 2020 01:45:37 +0200
Message-ID: <CAP+8YyHwMPPTiPAEs0CV+K+NSWtQmKQ-1hL0CmoGvUjA=P_1+Q@mail.gmail.com>
Subject: Enabling AMDGPU by default for SI & CIK
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, "Koenig,
 Christian" <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi all,

Now that we have recently made some progress on getting feature parity
with the Radeon driver for SI, I'm wondering what it would take to
make AMDGPU the default driver for these generations.

As far as I understand AMDGPU has had these features for CIK for a
while already but it is still not the default driver. What would it
take to make it the default? What is missing and/or broken?

- Bas

(I did some statistics on the Steam Survey, and both SI and CIK have
around 9% marketshare for Linux+ AMD there:
https://gitlab.freedesktop.org/snippets/1128 Would be cool if we could
enable Vulkan and VR out of the box on these cards)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
