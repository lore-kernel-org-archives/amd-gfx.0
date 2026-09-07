Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C7FC79FAF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 07:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C53D10EA78;
	Tue,  8 Sep 2026 07:21:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rTo4JCOT";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 555C010E028
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 15:01:18 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f9c60d5so20517466b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2026 08:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788793277; cv=none;
 d=google.com; s=arc-20260327;
 b=GFASikyAnTOf9N39r0QORA8LS1wsIKR/KnI3a+q0i0+cszYwemE04nj9L6yjJ0cJmv
 h/+c6fyN6uIaFxX7o+ctOFkT0DecFi2hb8tI9m5b/t/VtcV4ssKJMdZFQMBXDBPogTX9
 bOo/adNXN4SKDCUYcER7aDzpX62stK1qRmL/iAcI7hYxXmd6XRA7LDuLxd11V+iZD+UX
 TvlINu1Thld+cEXLtDvfHrl6S3AColkQOwmE/DklibUT+KHj+8d/7LbQpFf2F9pXEfJg
 lhTHGdwaq4BHR/ub75+0cSsVW+d1LbpMsydiueVd41zhKv+x4/G7ahV4JM9RQvIHzFyn
 C7Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=C/5SbezyWi1anxyCL1WLStNOIqEcreSWVvPab6/As70=;
 fh=y+XMpPis0J1y1U7cBEt8viyZRoMEB5NxzCqR/01LRNI=;
 b=lHcG7XR0jb8Kd3zDf+eSHr7WdPwvaP1m/XuEWbZiijh1BKvZtAgV9qYAWyKhnhNhrA
 VmNpWe4dWyZaUv9eZOF7m6SO/+4dYVDz59Y02/LJsFNWLdVSPyQ8FvsTYCMWgJQcGZB2
 tya7pP6nJJCxr4v+XU3DNY9xTSM6rixt0WIrwduOm3Z9KMZ6MbsJIwykY8iQ4z4x7lbV
 5Vq+HTEkGMN3K8K2uvSq7tD+ec4RlfUd8F6qYxMA/Ji/AWcxWjt6VN4GJUU1P6I5s2ea
 oaApjMpVCgEm65LdtVmBJWkM3QPi8uR8nNfwZC6ZqcrvXxM6zMBEQ9x1YirzRxIzGfqX
 0j+Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788793277; x=1789398077; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C/5SbezyWi1anxyCL1WLStNOIqEcreSWVvPab6/As70=;
 b=rTo4JCOTrwxmKcf05e/C3YVuQUlBYgjET//cvjCpR0N8paT4Gkb3GS1mGVLDLXUiMk
 po/PK+f2s/eF36cHjvtv4XXuJgZklyKU5M/bB+/95bbsPnAv/SekdMPhbJ93tjaR7NDi
 +QhR/UbfYC9dPJmFcvBZuQ4XYSnXhmCrYuVTOF/QEO6SJ6Lh0gJq88z85qCYmi9Y2QzK
 Blx0m6IR4DL/b/7LOUrl+XBP1VSkyQPJPoa09xbIBI0gRDhkHf1UruRrtvA0JlXQsN3E
 tiw6uuEpVn02rUUHgs+W01dbbFGCPhAuJ4RSkXLxIMgIGT3mHWkh27C+SVMg7ofMmJo6
 cx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788793277; x=1789398077;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=C/5SbezyWi1anxyCL1WLStNOIqEcreSWVvPab6/As70=;
 b=K/oxeUJjuaBB71EB/CktGTObGQqO2A6KGE7WakIuWWiuksx9MPiJrfJo/H5kujqspP
 9DgpYhmQl9bWbCcOT+JGGM02iO0X0qy82k7j++9yHVHCq0iTXzYca1CPigKQ+BEzxpHL
 +FL14FUlERt603M6wYyXl8Ldkfq4iBrttm7pF4UtBD6+RRMGkQji3V5CBS9EjFhLXzVJ
 l3z+Ws8j+K+G7/j3XnLyrgMlGMVDMISqvVXQCEwrKnnwjuM4CAAsp/Z+PS5vqEQhPBbF
 fFhDmH/QEhW/FFMD04tsLCdnHTDW1fClWTd5zbQG2Hb1Ivzou0gf1fVvjBMCK4DJasQp
 kvyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQT90Q4wr9SPCF+Qpb9FaGKkpOKx77kbT4FJn8YEvtBFQ8KerTewA0mBwLUg5QnVKtJd86hQn9@lists.freedesktop.org
X-Gm-Message-State: AFuF++l5r1VnoYk/xeJ6kFTHoRmxBM5VzJgPa+l0O+vFsGer3+PNqhGR
 l1FroapIihZhVIlwGy7DonTGj73qnLTx9txb7G4oZN6vbmWn+WZ/eSZxc8PUxED/f2tQ8w18F6P
 zENwUaAh5b1J4pKnH5CW2MC98zdYEzg==
X-Gm-Gg: AYBFou3tAWp3bu7L5CdrbMyC+DVm1Qu9pxqlkOI4J93us6kFo5MnMpnsnAw30YY9gDf
 1oMilXg6vfXv+ox0xETyxJnTTN67TU4KXOk+E3W144XLWEeGGlhJmaso1VHUQvkSF73BIlsOl/k
 PaU6ZTnYrvtm9Qg3GAnJMp4yBNerDO7VARIa3mV8JdB3VNO284irm5epfeofmNugBNldq7L6oMm
 nK3xxHyyudjA5cYX/nVSSf0fSJUl6Qxj9Ox+RqB2hR40hkDMPEGiWQsKe8PdQbQbC9dbVvxQBSH
 IqxhB1eOpoGxyyYhqDRh7zHRhqVghe+UNkhLg3+3fSzMJunDiyZ20bxXhaQb03cI5fcvrUrCesN
 WDQ==
X-Received: by 2002:a17:906:c155:b0:c25:8b1e:3750 with SMTP id
 a640c23a62f3a-c29044392d5mr61538766b.12.1788793276384; Mon, 07 Sep 2026
 08:01:16 -0700 (PDT)
MIME-Version: 1.0
From: Danilo Machado <danilomachado2002@gmail.com>
Date: Mon, 7 Sep 2026 12:01:04 -0300
X-Gm-Features: AcwNN1UiCuTQvo7sl7tJPmxlZo-IKKg34erNkbCORKYwkqa5XlsrWnMFLo27VyM
Message-ID: <CAJ9xWr+xGevB00DzELbFK+LLGTn7Oj_ZbJ7OBN05+kHe-D-vNQ@mail.gmail.com>
Subject: Re: [BUG REPORT] AMD Radeon R9 380 (Tonga) - HDMI no signal after
 suspend / regression tracking update
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, dri-devel@lists.freedesktop.org, 
 linux@leemhuis.info
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:21:13 +0000
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

#regzbot back in-progress
#regzbot monitor https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389
#regzbot monitor https://gitlab.freedesktop.org/drm/amd/-/work_items/5123

Hi Thorsten, Alex, and Linux Kernel Maintainers,

I am writing to update the status of this regression after checking
the Regzbot tracking dashboard:
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAOnW2VTGBP=MMWM=W41uPDLrzTVHM1sw8P1myvftnNk0vEMMFw@mail.gmail.com/

The dashboard currently lists this issue as "fizzled out / resolved:
inconclusive", but I want to clarify that this bug is ACTIVE,
UNRESOLVED, and actively tracked. The lack of recent email activity on
LKML was due to ongoing technical data collection on Launchpad and
GitLab while awaiting upstream feedback.

Current Status & Verification:

1. Launchpad Report (#2142389):
   - Status: Confirmed (assigned to maintainer Timo Aaltonen).
   - Heat/Users: 220 Bug Heat points with 44+ explicitly confirmed
affected users across various AMD architectures (Tonga R9 380, Polaris
RX 400/500, and recent Vega APUs).
   - Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389

2. Freedesktop GitLab Issue (#5123):
   - Status: Open.
   - Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5123

3. Technical Summary:
   - I have executed 3 full git bisect routines on hardware
testbenches, isolating the regression behavior between kernel
transitions.
   - Recent user reports confirm the same black screen / no EDID
handshake failure upon resume and DPMS display wake-up across multiple
Linux distributions (Ubuntu, Fedora, Void Linux) and kernel versions
(up to kernel 7.0).

Please re-open and maintain active tracking for this regression on
Regzbot. I remain available to test candidate patches, kernel builds,
or debug flags on physical hardware.

Best regards,
Danilo Machado
