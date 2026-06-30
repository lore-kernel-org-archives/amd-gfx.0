Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BBAC43602
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 07:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 334C210EDFD;
	Wed,  1 Jul 2026 07:11:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=mark.filion@collabora.com header.b="H9AtX5gv";
	dkim-atps=neutral
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com
 [136.143.188.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0188510ED40
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 20:28:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782851306; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QeshbaSU6hizs4JI6RTD0I+xIOKSfJ+BzzRbbaXOoh36dtqA83XU7zY63DiOtPtDdK9EnAvyCNOP+Mym34E5UeWNCMCfx/GdBba3hiaTAEHYtdauiMifofYhkcigp8T43O09N/pTTw2Bmw5ta/SJM3vLTZaXCd5urxuZtjCqHns=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782851306;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=/xxStwIF61bn3ZqA6+M8xNVE8MJdolxYpTE31ogRu80=; 
 b=Q27/1FCC1Yecxiu8Ycjcn0we7lyb1KuRCzPLUau1a3PyQs6CcGSZXJADxY6krCcnoG1CRL7eJOcDPp4ifDyzcwfe8D0uBpXxmvbj+vEs+jiZGcdwZLjYM4zXWBpUwZQkPK1yxrHpAKTiX5GGDZfjnoDDBZzdcbrXIbbdArIO4ak=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=mark.filion@collabora.com;
 dmarc=pass header.from=<mark.filion@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782851306; 
 s=zohomail; d=collabora.com; i=mark.filion@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To:Cc;
 bh=/xxStwIF61bn3ZqA6+M8xNVE8MJdolxYpTE31ogRu80=;
 b=H9AtX5gvsE/h6k/VgvBl0++qclp1i6kMqdsXkXgoGl5+fDL+UbnmnDKjaNYFMXLS
 9HIOrsYzBf3wvVkz40VodOmY9lssOPVb4CrMSVy0Qt3uLhsZgxikHjKKBGPWVcJrMVA
 IAMCVLa/d57+NSZzSDegNvdvrW8OYekyPozQOg18=
Received: by mx.zohomail.com with SMTPS id 178285130449927.213119788359222;
 Tue, 30 Jun 2026 13:28:24 -0700 (PDT)
Message-ID: <102a923307828ec347c99fc982cf2665097218c9.camel@collabora.com>
Subject: Reminder: Call for Proposals closing soon for XDC 2026!
From: Mark Filion <mark.filion@collabora.com>
To: amd-gfx@lists.freedesktop.org
Date: Tue, 30 Jun 2026 16:28:23 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44app2) 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Mailman-Approved-At: Wed, 01 Jul 2026 07:11:03 +0000
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

Reminder - The deadline for submissions for XDC 2026 is this coming
Friday, 3 July 2026.

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
