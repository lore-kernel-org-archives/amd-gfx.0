Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865F9C7618D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 13:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7034E10E18E;
	Mon, 20 Mar 2023 13:10:23 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4A5210E42D
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 12:00:13 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id a32so11798752ljr.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 05:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679313612;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vpKyMTDmTQQkWX4IuLuwKzrbrXmAD+4d8idvwvkaVrk=;
 b=Gi/E/jmdKrkFDWJV7RD5RA9qOxbvzizWJhL9WRRn0PmxEjTjvNevVyXT5kxrT2+Qct
 iFPaKcJUScTddmsXfISTVJcE3nkPviQ0nGwjSaxCYXqaDBWBL3Y/NV20rmTFOHaF8XrB
 Tr/aNAX5JXtY8KIPYTv4/qbF4aqQv9whekqzE7gpaIDoXhHcuuM4SXUQzp3wpV3Ono2D
 4ot2v0nDwYcUyt54kA4/7LvfNeXPfmws8CKFb8P2vyZSVPPS50D2R9UoecW7GUfSTz7P
 TyBhzeNZJYVxIDkfkXl3irBTfCzvBYsOT1I/Zkm+3w1gZPZztwrekUHaNy76IeJvyV+O
 zY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679313612;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vpKyMTDmTQQkWX4IuLuwKzrbrXmAD+4d8idvwvkaVrk=;
 b=TPMkFJjH/bodW7zhLyFbcBBP1rWVMxuEsv13ar2wC41B/B0O36PXzAp+tPzrgNqLYy
 CXrg+v9m/KH6FHWeRGRYmpPC0rd+MLwslgq/KyZLJyNplpk7Qw9GeF8Ii8xbqyPQULDU
 bhqEItBesE2e7HUVQ2bSmaOWOTiNfIHpvUQo/46iOg9C7EUNkNoL2lqc9+un95mzIckO
 YOdmLwvBXbt+PX6S+gUuaX8JanqX3FyfTCp69wBvpJTV3kX+IVPHHWR3oCNHIyJzSuAe
 n5xjePsggtGYTBSsSeqtmOzfNbUt31xttOoW1WHKKsLUA5BE4Ykxfx4qCCC/HQgyTV17
 VO7w==
X-Gm-Message-State: AO0yUKWfQzCwH4xpwjpk/LXJVeKBpAJX6fIhQzSGwmvT3z7sBX45oxz+
 J2oeX8RqDAXnW1o6O9hCou4jha+hTBC1KayXN86OSIEM
X-Google-Smtp-Source: AK7set9Rcet110OjWev8CmOkBHAHH4MqA8jkce66CsKGtHFiYBMSDtNOjMANhkqL0KN2W/V0+Ly3WfDxVdPgpQJLbNQ=
X-Received: by 2002:a2e:8e2a:0:b0:298:8ac5:da28 with SMTP id
 r10-20020a2e8e2a000000b002988ac5da28mr5991790ljk.9.1679313612002; Mon, 20 Mar
 2023 05:00:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:7550:0:b0:224:109:c464 with HTTP; Mon, 20 Mar 2023
 05:00:11 -0700 (PDT)
From: Tom Psyborg <pozega.tomislav@gmail.com>
Date: Mon, 20 Mar 2023 13:00:11 +0100
Message-ID: <CAKR_QV+XEki==PT9LP+ZpnnhjeQf73Z-efkNsv3kAd_bwZLsnw@mail.gmail.com>
Subject: [RFC] VRM setting in a mobile system
To: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 20 Mar 2023 13:10:21 +0000
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

Hello

How can i verify the driver is engageing both phases in a mobile RX460 system?
I see there are PSI0_VID, PSI0_EN and PSI1 bits defined for use,
according to VRM specs they are active low and the VBIOS voltageobject
table is not setting any of these bits. Does that mean my system is
running 1-phase DE mode? Or there is some logic in driver that
switches to 2-phase CCM?

Regards, Tom
