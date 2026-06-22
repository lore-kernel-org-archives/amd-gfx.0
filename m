Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99503CDB47D
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 08:07:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F17F310E9D9;
	Tue, 23 Jun 2026 08:07:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=mark.filion@collabora.com header.b="GDru0r2H";
	dkim-atps=neutral
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com
 [136.143.188.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88BF910E72C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 14:52:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782139927; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fo5zT1N3c5uvMGLBLi+mRRPLOB147EFGNjQ7igmRQUTq87ycz4mmP6xJwgv1WAdUyl4V8naJKpgjs0eOPL0k4Hw5hGp4t5hX8Zg7jfalr0myumQbcZI2x6aTBgtv9MA68zQiBx+nbNxgSZtLEUPG9oGXoxdNkCjxY8DSnXoEwc0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782139927;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=63C3hkJcUAjLx1Wo5SqhN4nguOHicwdTIcrGRX6qKsE=; 
 b=UNQoosjdMb35pz4C/uY2w+5MbCIPKeyOaVJbGRWucwf6Q3HWi1GkYmPjq7oqmPU/u0C04WaBZLnBWujiDkTRF6Z4SADoF7/q/k1bKfcSdJBkipQ+yMQ14aASNCLbzJz2P9zylweiwpSakavZlFY5QSQPtLIEQyTw69Zmq0wHfRI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=mark.filion@collabora.com;
 dmarc=pass header.from=<mark.filion@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782139927; 
 s=zohomail; d=collabora.com; i=mark.filion@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To:Cc;
 bh=63C3hkJcUAjLx1Wo5SqhN4nguOHicwdTIcrGRX6qKsE=;
 b=GDru0r2HYOJMvdB2SCrMhA1ECCdq4TKSQ5C6awjuNityu1ox0j3Tcw/2ZgOV8N2E
 e7HeGqTPIiTGmjsxaPdS1p99ly8WaS1xEg+fBuF87QB5mKy0oIyEoeFIwPTEaWQNfq6
 rxEHIApfkq8kWR8h5umNir38DdVCAiz75/qbqUdA=
Received: by mx.zohomail.com with SMTPS id 1782139926249364.62421601122753;
 Mon, 22 Jun 2026 07:52:06 -0700 (PDT)
Message-ID: <85f5db922b9a34d03104b265ca3155c5bbe2443a.camel@collabora.com>
Subject: Reminder: Call for Proposals open for XDC 2026
From: Mark Filion <mark.filion@collabora.com>
To: amd-gfx@lists.freedesktop.org
Date: Mon, 22 Jun 2026 10:52:04 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44app2) 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:07:15 +0000
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

Reminder - The CfP is now open for talks, workshops and demos at XDC
2026. The deadline for submissions is Friday, 3 July 2026.

    https://xdc2026.x.org

While any serious proposal will be gratefully considered, topics of
interest to X.Org and freedesktop.org developers are encouraged. The
program focus is on new development, ongoing challenges and anything
else that will spark discussions among attendees in the hallway track.

We are open to talks across all layers of the graphics stack, from the
kernel to desktop environments / graphical applications and about how
to make things better for the developers who build them. Head to the
CfP page to learn more!
  =20
As usual, the conference is free of charge and open to the general
public. If you plan on attending, please make sure to register as early
as possible!

Best,

Mark
