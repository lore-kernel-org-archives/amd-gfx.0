Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5270BE8782A
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 13:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC7F710E0F8;
	Tue,  3 Feb 2026 13:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="fHbY1CtR";
	dkim-atps=neutral
X-Greylist: delayed 384 seconds by postgrey-1.36 at gabe;
 Tue, 03 Feb 2026 10:53:55 UTC
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A22589343
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 10:53:55 +0000 (UTC)
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx1.riseup.net (Postfix) with ESMTPS id 4f50Yb22grzDqTj
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 10:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
 t=1770115651; bh=teogo22SBnzjiifRiqraUzkwbM/PeVFhxiqkGsYrV14=;
 h=Date:From:To:Subject:From;
 b=fHbY1CtRfsvfI6tSFpGN/NlZUenYSkpqtm9XVd6C5N6rUyKDj/yKaACYxwmuLxZkO
 O9nyV7wwnAZeQG90LAMoW3GNueVNn+t15cMWoyXAQnOsj2/96bt9aqMTpcu1ruINNG
 061AKZa9BOR7Gd/1/ntM04KbRpoKO34IXm+hvxW0=
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4f50YZ6Kngz9trM
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 10:47:30 +0000 (UTC)
X-Riseup-User-ID: CAB3ADBAFDA91247DA236A2263D7A6D7C1C520A0A7365EFEC10413DAB585860E
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4f50YZ1Bzhz20mr
 for <amd-gfx@lists.freedesktop.org.>; Tue,  3 Feb 2026 10:47:29 +0000 (UTC)
Date: Tue, 3 Feb 2026 10:47:28 +0000
From: donoban <donoban@riseup.net>
To: amd-gfx@lists.freedesktop.org
Subject: amdgpu GTT memory leak
Message-ID: <aYHIsX28jR1TNTAs@b1c030cc0be7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 03 Feb 2026 13:32:04 +0000
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

Hi,

I have an AMD Radeon 780M Graphics running AlpineLinux on a Thinkpad 
T14 G3 and I noticed a memory leak related to GTT and amdgpu. In few
days is easy to reach gb's of GTT usage while any process reporting
tool shows no extreme memory usage of any process.

Looking at 'dmesg' I see many messages like:

amdgpu: VM memory stats for proc alacritty(32519) task alacritty:cs0(32514) is non-zero when fini

So I ended reaching this mail list. Could you help me to debug this and
maybe found some fix or workaround?

Regards!
