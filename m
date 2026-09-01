Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D13C624DE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 07:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6F310F447;
	Thu,  3 Sep 2026 07:35:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=mark.filion@collabora.com header.b="E8LzgajA";
	dkim-atps=neutral
X-Greylist: delayed 2704 seconds by postgrey-1.36 at gabe;
 Tue, 01 Sep 2026 20:42:03 UTC
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com
 [136.143.188.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A960410E555
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788292618; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SZfXuGcuK3qZmfGz0nXRAVJShDB+pelcGo3tq7Z+KqnxqI1tTZTNlQuvxynqRdcwUlTapZez0kBhogEHRmbSX8cHK7/GsEFVq9X5a72qnJtf1oYpWsjqEigGh1tNxXzcc0FAu8mr0KiHpnZcX8gcy/PjHNGDJpzr+OCnUOr8cAs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788292618;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=/qHEHJKZk4x+utXQVy6Oy+Uc44nyD4jHGrqzfQUFDl4=; 
 b=d4LNM2KzeAAU7f7K9XNstw8lEeBMUHD4l/qNpssD7jp/aJm8fAzC5jLPvsRor2iMhgLrzrUr6I6VoEUg/vRIjHaRpi+IJ2eaAdnwDtkyAitjimx8qMvWzIZax6xepMIpRB3Mbdn53Rj2YRH8L2faWg50MYLjQYEj3s9CPNZcb1I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=mark.filion@collabora.com;
 dmarc=pass header.from=<mark.filion@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788292618; 
 s=zohomail; d=collabora.com; i=mark.filion@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To:Cc;
 bh=/qHEHJKZk4x+utXQVy6Oy+Uc44nyD4jHGrqzfQUFDl4=;
 b=E8LzgajAQEufpn0gbD0NrtuFOf0WmrVL76g7/kUu4MiRJXARMuuGswDVHyXe21+O
 WW74yrpPq7vi7GvZPLmgFnHafyWbm7pwf4GPz3TSRMcdAxc6TKCwGDdbHlZOJWq34L5
 ptbsKmuRcdZzOnu9xj37a5uLpvJYVSy5Hq+Q1pCE=
Received: by mx.zohomail.com with SMTPS id 1788292616797740.7937852299198;
 Tue, 1 Sep 2026 12:56:56 -0700 (PDT)
Message-ID: <f7b51ac3c5656e1bb4b62d6c8e078159c438057c.camel@collabora.com>
Subject: XDC 2026: Full schedule now available
From: Mark Filion <mark.filion@collabora.com>
To: amd-gfx@lists.freedesktop.org
Date: Tue, 01 Sep 2026 15:56:55 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44app2) 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:34:48 +0000
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

Hello everyone,

Only a few weeks to go before XDC 2026 kicks off in Toronto, Canada!

The full schedule of talks is now available! Check out the schedule to
start planning which talks you don't want to miss.

https://xdc2026.x.org

The CfP has also reopened for Lightning Talks, Workshops, Meetings &
Hacking Sessions. Submissions are welcome, though acceptance is subject
to available time in the schedule.

https://indico.freedesktop.org/event/12/abstracts/

If you are planning to attend, please make sure to register.
Registration is free, and helps us plan for catering, evening events,
and nametags.

https://indico.freedesktop.org/event/12/registrations/

Best,

Mark
