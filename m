Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32912C00140
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 15:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BAC98D544;
	Tue, 26 Jul 2022 15:28:12 +0000 (UTC)
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch
 [185.70.41.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03ACD8D0E9
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 15:28:10 +0000 (UTC)
Date: Tue, 26 Jul 2022 15:27:54 +0000
Authentication-Results: mail-41104.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="PN1M+mgT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1658849284; x=1659108484;
 bh=mcDgxxRX0bvs8RItV5Grlg79lKuUssBexSgAIX0Iz4U=;
 h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
 References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
 Feedback-ID:Message-ID;
 b=PN1M+mgTP3rPNM0Fu3CkEAm0q7ThdMbWrqeVDXn/leYnYfK8hmrqFFOgYpYn9Xp6Z
 LI1lIWaukry1eFv2JodoAH1mUEKtzO7DILHALEuDWiDjPZgI+4rAb4nSn0BlS9/J/I
 jddpBQkBTiY3G0cNXkiTfKBr31k54rrqm2gqomUJgHhkyDtVSpRn3lbO3qePGwEBcn
 JXh+VgbfNoQ9oS8sFrVJt4Rh/AjNui77mppLpp6p8uSxLy2SBsnj0XYGSF8wl7SqrT
 E93AN0/fMS0+NRXo0pJ5SMGvRyENWxdFivLl4EbglS7/S9fx0yPk8j08hpEsStYh/n
 HdoDE+8r+G6EA==
To: Dan Carpenter <dan.carpenter@oracle.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [bug report] drm/amd/display: use FB pitch to fill
 dc_cursor_attributes
Message-ID: <1JPWbfs9ltu7lsg8hK1KCCiKY9S6tjFGGGF13vR28hS9_FtOSHoSoS9rmHM4suOoa9fs8H8zcQiz0uFiuCpx8uOfV0CoRKBVwbKp8rKeozs=@emersion.fr>
In-Reply-To: <YuAGLYvbtrrgBH0U@kili>
References: <YuAGLYvbtrrgBH0U@kili>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

plane->state->fb is NULL iff afb is NULL. There is an early return to
make sure the dereferences don't cause a segfault.

Simon
