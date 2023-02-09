Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A374C61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 17:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF4110E056;
	Thu,  9 Feb 2023 17:03:42 +0000 (UTC)
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch
 [185.70.41.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 045EC10E056
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 17:03:38 +0000 (UTC)
Date: Thu, 09 Feb 2023 17:03:19 +0000
Authentication-Results: mail-41104.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="HGPyzlb1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1675962212; x=1676221412;
 bh=vCvCm4zvHaVmosobR79bwhctMyOD5K8CGlU9v/VJu9U=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=HGPyzlb1BPEknFv+W2hpg71t4z5EBGULNXNVh7P6gwS+L5tTLt0AIN+D027fcdo/W
 g1RBEeyG9LovHy9pe1561/Itdbjr4rJMoukAqGXbRrhhw8T0ZkqBrKTmN3lHLuC/JE
 OgizxGdncZVDhb1ahQ6UqQtqyr9SzjQhteIxQpdF2UeFxz8/hY9TIygyfaMjI7H7ke
 ytmDMkOJgaC37coHzH85nIuO8YUUhxk335Va8YCHmYeRjPnY1aaJQiD8XUYTq9429M
 iBG3wKZyk/pFAFsm8n/IynjrL0rgmUCd3wRlan0arFoSab12OsOHX1WHN5aBy/sh0n
 +6v1z6/qGIJlQ==
To: Joshua Ashton <joshua@froggi.es>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 3/3] drm/connector: Deprecate split for BT.2020 in
 drm_colorspace enum
Message-ID: <hlhk2_vNweAm7d8c2FK8GlUEi1-JHOZTU2W8unUHLoyTtyjXQnnAoGur8KqYgrbw6nsP9Yy91k8OzgiP1k_zwIX4JB0Qt5W178zqOgHilZY=@emersion.fr>
In-Reply-To: <54695463-3e7f-4e4a-cd76-fa6f9de1d8e8@froggi.es>
References: <20230203020744.30745-1-joshua@froggi.es>
 <20230203020744.30745-3-joshua@froggi.es> <20230208113041.70691449@eldfell>
 <54695463-3e7f-4e4a-cd76-fa6f9de1d8e8@froggi.es>
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
Cc: Sebastian Wick <sebastian.wick@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Pekka Paalanen <ppaalanen@gmail.com>,
 Uma Shankar <uma.shankar@intel.com>, Vitaly.Prosyak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thursday, February 9th, 2023 at 17:38, Joshua Ashton <joshua@froggi.es> =
wrote:

> > I mean, the strings are the uAPI, not the integers, right?
>
> Both are uAPI these days.

Yes. The integers are uAPI, if you change them you'll break libliftoff
users. There is an old thread discussing this somewhere. The tl;dr was
that there is no use-case for exposing the same string with a different
integer, so no good reason to justify the substantial complexity of
handling this case.
