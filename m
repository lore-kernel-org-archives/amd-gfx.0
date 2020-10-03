Return-Path: <SRS0=Wqu9=DK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732A4C4363D
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2020 09:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149A8206DB
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2020 09:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149A8206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B4136E3D0;
	Sat,  3 Oct 2020 09:25:54 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com
 [209.85.166.207])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 589986EA20
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2020 02:33:06 +0000 (UTC)
Received: by mail-il1-f207.google.com with SMTP id o18so2574651ilm.16
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2020 19:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
 :from:to;
 bh=huAQ2XNxNk0+JP0caungu+yrhrmWz2OAWIUz9RtSlI4=;
 b=UniwmnyJ8c0uneXuxoiYQhA48vR2EMU/F6tWysoaTKz2tZjwyWykT8lCvNujY11/mT
 H3pljeBN9Htyj/40vmpXSK52SjfWCoM3+cpIr7+aOFSU0/7vol915yDyWnBaA5loVWbJ
 yWxSP0eFovaC14K0VltljxePJ9kehpUwrPwbaaeM3JRgfJOlgc46KIavZ9fjcvZEhu8A
 0wW77LyOgYiahRi6BShdteQmn256PFIZU1eZ1fTHuj/wM/2y0UR0bybwSsrBa0PYSwDT
 eFepGAJ9+oWheAjqcE6nZgv7wlXqXPnziXL5G2SYrJ6KmKrfeYysa4htatjNu2m4AfRE
 W9wg==
X-Gm-Message-State: AOAM533Vbp7DQlzPovjTgetk+QIG/d1GNsdrRjaKJCYGjJpotbA81Cdt
 tOuEa1wmCDCKiuhDrOKLEjSGjmXQvjIE4QNxprmE57vq4QuD
X-Google-Smtp-Source: ABdhPJzrlAP5imDWEPKyVGiLnhg0plpe3Pjdz0K8YSADKul87MvIbS1OPbnv7c/HZQJfp1argFlx9wEiLJU/BiWVN/BRncyNJ03n
MIME-Version: 1.0
X-Received: by 2002:a02:5d85:: with SMTP id w127mr4693509jaa.76.1601692385603; 
 Fri, 02 Oct 2020 19:33:05 -0700 (PDT)
Date: Fri, 02 Oct 2020 19:33:05 -0700
In-Reply-To: <000000000000ed022605b0b1efaa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aef3fc05b0bb11ce@google.com>
Subject: Re: WARNING in ieee80211_bss_info_change_notify
From: syzbot <syzbot+09d1cd2f71e6dd3bfd2c@syzkaller.appspotmail.com>
To: airlied@linux.ie, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, davem@davemloft.net, dieter@nuetzel-hh.de, 
 dri-devel@lists.freedesktop.org, johannes@sipsolutions.net, kuba@kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
X-Mailman-Approved-At: Sat, 03 Oct 2020 09:25:53 +0000
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

syzbot has bisected this issue to:

commit 135f971181d779c96ff3725c1a350a721785cc66
Author: Alex Deucher <alexander.deucher@amd.com>
Date:   Mon Nov 20 22:49:53 2017 +0000

    drm/amdgpu: don't skip attributes when powerplay is enabled

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=120f55bd900000
start commit:   fcadab74 Merge tag 'drm-fixes-2020-10-01-1' of git://anong..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=110f55bd900000
console output: https://syzkaller.appspot.com/x/log.txt?x=160f55bd900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e672827d2ffab1f
dashboard link: https://syzkaller.appspot.com/bug?extid=09d1cd2f71e6dd3bfd2c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161112eb900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124fc533900000

Reported-by: syzbot+09d1cd2f71e6dd3bfd2c@syzkaller.appspotmail.com
Fixes: 135f971181d7 ("drm/amdgpu: don't skip attributes when powerplay is enabled")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
