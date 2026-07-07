Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106C6C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 13:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA2810F073;
	Wed,  8 Jul 2026 13:12:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=mark.filion@collabora.com header.b="g8O3V0kq";
	dkim-atps=neutral
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com
 [136.143.188.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 144FE10ED61
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 14:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783433317; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZgMRKuO2SkGOwdSNndPnEnSr6zqWlqL4bVD8ez3VpdYW19kMAXeTPzdwyr8GLyvjQpV83z8nDX3NGBpCgBEa2CrwuXyirVZh7vLXchhL47eSMTVHz5B+K/HOOOfLTv0lEODoMNwF8fJvAKSn/+Ufq+cJfV+R/CATZ8wphEe9gmA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783433317;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=OuwODL/Y0Ylpe2Edfe8HjsUVpS8t3ywZf1afa7GP1VQ=; 
 b=d/PZbfGyzynS1WJ6d1yGUz9otaxHAnyvxTDpfL6yf72YBycXXglso5GP84TuqX34RlkzaMae7L+2sZ2Hq0ZRXESpcepOOyNWL0e9rl2nxpNp/+1HHak+KUXkHgn+BsMallM+zB5O7X0v5hey9CrauYv9F6K8LZ8Pdun2gjPK2zI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=mark.filion@collabora.com;
 dmarc=pass header.from=<mark.filion@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783433317; 
 s=zohomail; d=collabora.com; i=mark.filion@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To:Cc;
 bh=OuwODL/Y0Ylpe2Edfe8HjsUVpS8t3ywZf1afa7GP1VQ=;
 b=g8O3V0kqLIl9de7HAwyaYNnJRig1F432wfBUHdrDPLjfuLvQfL0TOWw0OAwjQYud
 B2LUR5p7/fC/59LiFmrcogjCdVZ6QDGuzVZ0Zxce2D3PY2FpTwVB7DwD5houw3fa7gZ
 6Y+fQdp2oELfjpeojWWSsRM9uPvTU2+WUFa+yFwY=
Received: by mx.zohomail.com with SMTPS id 1783433315298807.4520016200222;
 Tue, 7 Jul 2026 07:08:35 -0700 (PDT)
Message-ID: <865b7c9df10c6b35bd1e90e93ccc8b07ad1ce9b8.camel@collabora.com>
Subject: XDC 2026: CfP deadline extended to July 15. Submit your talk,
 workshop or demo!
From: Mark Filion <mark.filion@collabora.com>
To: amd-gfx@lists.freedesktop.org
Date: Tue, 07 Jul 2026 10:08:34 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44app2) 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Mailman-Approved-At: Wed, 08 Jul 2026 13:12:03 +0000
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

Hello!

The CfP deadline for talks, workshops and demos at XDC 2026 has been
extended to next Wednesday, 15 July 2026. You have one more week to
submit, don't wait!

https://indico.freedesktop.org/event/12/abstracts/

We're especially interested in talks across all layers of the graphics
stack, from the kernel to desktop environments and graphical
applications, and about how to make things better for the developers
who build them.=20

Worked on a cool project? Don't let the bar seem too high, you don't
need a polished, groundbreaking result to have something worth sharing.
If you're excited about it, chances are others will be too, so don't be
shy: submit your talk! Head to the CfP page to learn more.

As usual, the conference is free of charge and open to the general
public. If you plan on attending, please make sure to register as early
as possible!

And don't forget, you can follow us on Mastodon for all the latest
updates and to stay connected:

https://floss.social/@XOrgDevConf

Best,

Mark
