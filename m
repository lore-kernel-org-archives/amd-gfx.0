Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305E5C11F67
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 08:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F226461DC4
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 08:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F226461DC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F38EC89F2D;
	Tue, 29 Jun 2021 08:13:00 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8318489F2D;
 Tue, 29 Jun 2021 08:12:59 +0000 (UTC)
Date: Tue, 29 Jun 2021 08:12:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1624954376;
 bh=Wt1VzxpUKhVa3HzTLpE5SfzFn/YP4YxfPtnwrLRl/ko=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=kT+JW4ZQ/XLWZcl11bQR37x0+KSRaeQZh+kE4omXiV6BfWIXtXDd9WyZtDYY/JY9Q
 1zd79RntcYijrdG1waxiPh2nou/ZvBfvcZypHdKrnM3PwLNucQr0OzCcTVrq4rh8Ni
 m00QGUE0GcaCzer16iFx8ghVLePzrSLxcbmBR4jKdOIvbVxdAc9OX7/52DB/6bp8/J
 0WoLL0L4vGQIbORx3tk9vDc6XpknNlwi+5ZDIdukmY8s898XGiSCv8U8BfB9vVj2WN
 cqt8zTHmvFnErL8LXt3H3nz10WMmR/gSmecxKqQLAOoPnTlcU59248/yhsU0VgsSln
 j3LySWnSFt73Q==
To: Pekka Paalanen <ppaalanen@gmail.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v4 12/17] drm/uAPI: Add "preferred color format" drm
 property as setting for userspace
Message-ID: <jIDQ2rRRMWlhDDPf08Z8xZlEE8HTBx7fHsylFdK0joSSFVyES8D444Giyiji9zbIm7dU4QpbsXZLvIDTbGW0wEoUWKsMEI4evizn0UdGMvM=@emersion.fr>
In-Reply-To: <20210622101516.6a53831c@eldfell>
References: <20210618091116.14428-1-wse@tuxedocomputers.com>
 <20210618091116.14428-13-wse@tuxedocomputers.com>
 <20210622101516.6a53831c@eldfell>
MIME-Version: 1.0
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
Cc: Werner Sembach <wse@tuxedocomputers.com>, sunpeng.li@amd.com,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, airlied@linux.ie,
 amd-gfx@lists.freedesktop.org, tzimmermann@suse.de, rodrigo.vivi@intel.com,
 alexander.deucher@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tuesday, June 22nd, 2021 at 09:15, Pekka Paalanen <ppaalanen@gmail.com> wrote:

> yes, I think this makes sense, even if it is a property that one can't
> tell for sure what it does before hand.
>
> Using a pair of properties, preference and active, to ask for something
> and then check what actually worked is good for reducing the
> combinatorial explosion caused by needing to "atomic TEST_ONLY commit"
> test different KMS configurations. Userspace has a better chance of
> finding a configuration that is possible.
>
> OTOH, this has the problem than in UI one cannot tell the user in
> advance which options are truly possible. Given that KMS properties are
> rarely completely independent, and in this case known to depend on
> several other KMS properties, I think it is good enough to know after
> the fact.
>
> If a driver does not use what userspace prefers, there is no way to
> understand why, or what else to change to make it happen. That problem
> exists anyway, because TEST_ONLY commits do not give useful feedback
> but only a yes/no.

By submitting incremental atomic reqs with TEST_ONLY (i.e. only changing one
property at a time), user-space can discover which property makes the atomic
commit fail.

I'm not a fan of this "preference" property approach. The only way to find out
whether it's possible to change the color format is to perform a user-visible
change (with a regular atomic commit) and check whether it worked
after-the-fact. This is unlike all other existing KMS properties.

I'd much rather see a more general approach to fix this combinatorial explosion
than to add special-cases like this.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
