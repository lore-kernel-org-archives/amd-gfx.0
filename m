Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D04FC48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 11:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8AC761374
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 11:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AC761374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 744C86E4AF;
	Tue, 22 Jun 2021 11:48:57 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5966789BF4
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 11:48:56 +0000 (UTC)
Date: Tue, 22 Jun 2021 11:48:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1624362533;
 bh=YdiN0pT6LyBBXp45IM63KSqansKLfPR5K/ejEZVcIBA=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=WbqU/TJmgJewteirDgKWtXUv0FH+QXBu1SHamMgLkS0HVsbvqLQ2nchnWmxn/xsnx
 TVww0VIqHVKCAsuXBu9w7KN/kF3V2QKJJ6faG/iwa2IRRkDBelS5R5wY5VCpbnNRyz
 Smk65uNzdhYkWBuvBq29T9kEPOzQEEDQLooOVaN+JEzw335DKSeu9hLrns0x7C0y3B
 6JRXTkaEnM5NnPx9qGwNEagF8keFI6+QbyKusJeQj4C+X9YT5LPQVSjn7vdEgOnwoj
 uTIkjev5CMGbJ+cmnNZsD5c543GUnYBYhTwqA/+cEWLGW4Zy+VKTgux6JqbqXFEzTA
 3LnjzwDkuj4hw==
To: Werner Sembach <wse@tuxedocomputers.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v4 09/17] drm/uAPI: Add "active color range" drm property
 as feedback for userspace
Message-ID: <k_QeCRpur3SNNIspBiTHOTT6Oj1pSteEO3MzyQFUG0lSXmEqJUI2tMXJ6wR9chzUHGahdQApJZrUxdJvIv6s8aXr2DBdoHg-2PsGH4kEMyA=@emersion.fr>
In-Reply-To: <56d079d4-841a-0ca5-b8a6-d2c10f91d211@tuxedocomputers.com>
References: <20210618091116.14428-1-wse@tuxedocomputers.com>
 <20210618091116.14428-10-wse@tuxedocomputers.com>
 <20210622100042.4041624a@eldfell>
 <56d079d4-841a-0ca5-b8a6-d2c10f91d211@tuxedocomputers.com>
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
Cc: sunpeng.li@amd.com, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 airlied@linux.ie, Pekka Paalanen <ppaalanen@gmail.com>,
 amd-gfx@lists.freedesktop.org, tzimmermann@suse.de, rodrigo.vivi@intel.com,
 alexander.deucher@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tuesday, June 22nd, 2021 at 11:50, Werner Sembach <wse@tuxedocomputers.com> wrote:

> Unknown is when no monitor is connected or is when the
> connector/monitor is disabled.

I think the other connector props (link-status, non-desktop, etc) don't
have a special "unset" value, and instead the value is set to a random
enum entry. User-space should ignore the prop on these disconnected
connectors anyways.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
