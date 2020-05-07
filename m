Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB5EC38A2A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 19:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2DF521582
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 19:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mrns.nl header.i=@mrns.nl header.b="RcxboRx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DF521582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mrns.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 620546E1AA;
	Thu,  7 May 2020 19:36:32 +0000 (UTC)
X-Greylist: delayed 932 seconds by postgrey-1.36 at gabe;
 Thu, 07 May 2020 19:35:11 UTC
Received: from smtpq3.tb.mail.iss.as9143.net (smtpq3.tb.mail.iss.as9143.net
 [212.54.42.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1261989C93
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 19:35:10 +0000 (UTC)
Received: from [212.54.42.110] (helo=smtp7.tb.mail.iss.as9143.net)
 by smtpq3.tb.mail.iss.as9143.net with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.90_1)
 (envelope-from <dmarinus@mrns.nl>) id 1jWm3V-0001G2-Ak
 for amd-gfx@lists.freedesktop.org; Thu, 07 May 2020 21:19:37 +0200
Received: from ip-213-127-66-85.ip.prioritytelecom.net ([213.127.66.85]
 helo=routi.mrns.nl) by smtp7.tb.mail.iss.as9143.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <dmarinus@mrns.nl>) id 1jWm3U-0003je-7Z
 for amd-gfx@lists.freedesktop.org; Thu, 07 May 2020 21:19:37 +0200
Received: by routi.mrns.nl (sSMTP sendmail emulation);
 Thu, 07 May 2020 21:19:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mrns.nl;
 i=@mrns.nl; q=dns/txt; s=mail; t=1588879175; h=date : from : to :
 subject : message-id : mime-version : content-type : from;
 bh=UZmoGkw+HU2ldfgaUO+Vyb+OJJjJkdiVNrSi7jIizKY=;
 b=RcxboRx+fOshD8zAw7Ahq2aN7CZWMJH8MwmwEhUCruudHHny1U/jIXHNio5hBjy49ODJx
 HLEG2/aONOQ5ZklTEVkB9Xyhh4p08cHAb5eU9gR6QqhkP7EE4sN+bOMuYE3B20YKMSptpoU
 FYn2CrZXucRW5M0UDA+SDhlu2FBvNtI=
Date: Thu, 7 May 2020 21:19:35 +0200
From: D Marinus <dmarinus@mrns.nl>
To: amd-gfx@lists.freedesktop.org
Subject: builtin display using amdgpu gives a black screen on macbook pro 13, 3
Message-ID: <20200507191935.GD1799@routi.mrns.nl>
MIME-Version: 1.0
Content-Disposition: inline
X-SourceIP: 213.127.66.85
X-Authenticated-Sender: boeierlaan60@ziggo.nl (via SMTP)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=Ne99K1L4 c=1 sm=1 tr=0
 a=QzIsuD3EoHw0lHU0NZQLAw==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
 a=kj9zAlcOel0A:10 a=sTwFKg_x9MkA:10 a=dnA_Z5UOAAAA:20 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=pz_Te4hhSMQWMs0xVaoA:9 a=CjuIK1q_8ugA:10 a=VlZU0XKO32wA:10
 a=AjGcO6oz07-iQ99wixmX:22
X-Ziggo-Spam-Status: No
X-Mailman-Approved-At: Thu, 07 May 2020 19:36:31 +0000
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

Hi!

Since I've updated the linux kernel to 5.6 my builtin display of my
Apple Macbook Pro 13,3 is blank. The following bug reports have been
opened:

https://github.com/Dunedan/mbp-2016-linux/issues/142
https://bugzilla.kernel.org/show_bug.cgi?id=207589
https://bugzilla.redhat.com/show_bug.cgi?id=1829174


xrandr gives the following message
xrandr: Output eDP is not disconnected but has no modes

the /sys/kernel/debug/vgaswitcheroo/switch entry is missing

lspci gives:
01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Baffin [Radeon RX 460/560D / Pro
450/455/460/555/555X/560/560X] (rev ef)

Any thoughts on the cause or fix? What would be helpful information?

Thanks a lot!
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
