Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F12CD98E3
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 15:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BD5110E595;
	Tue, 16 Jun 2026 15:23:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="n7LOGgqy";
	dkim-atps=neutral
X-Greylist: delayed 22347 seconds by postgrey-1.36 at gabe;
 Tue, 16 Jun 2026 15:23:37 UTC
Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch
 [79.135.106.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0483710E595
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 15:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1781623415; x=1781882615;
 bh=ZiSGzLFLLQon9GbxRQF1ztUhVOP73mQj8rFsjiRIRgM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=n7LOGgqyDN81rmga4TUmR2NAKJW/QWyEVUF/41yIUxu4mteld678FicepJvObZyCw
 qEtxXM+iJJOGbZiLMuI5ZRsLahcAtrvFzPsvKIpn6rAy4KHCo9pE2R/4eB18VuEeJC
 QrHMBeErWKevBt3D9vYWkjBzKjbaaDQSaWvBT4oeVVl+3L3Ejjexj3mR8nHON9mTky
 8tNwhpj4MAlC51SdXopJOjF3wRxzWezkiTOOJhQfBWkA0aydSOM2Jin+ZOqnt7KDm6
 iYuPg7GHAeYiq4VbqPBWlSDhKGpTf3gKKiexe8yPzShWyOnU5MB5Y/H367K4x2JeXK
 RcSc/3Bp4aiAw==
Date: Tue, 16 Jun 2026 15:23:30 +0000
To: Xiaogang Chen <xiaogang.chen@amd.com>
From: Gerhard Schwanzer <geschw@pm.me>
Cc: amd-gfx@lists.freedesktop.org,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Use last + 1 of vm range to check 2MB huge
 page alignment
Message-ID: <20260616152320.60210-1-geschw@pm.me>
In-Reply-To: <20260616150713.301236-1-xiaogang.chen@amd.com>
References: <20260616150713.301236-1-xiaogang.chen@amd.com>
Feedback-ID: 110185885:user:proton
X-Pm-Message-ID: 4a6618b2fa0d9b824aaf4ede69440316816a8af5
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Xiaogang,

thanks for sending this.

The last + 1 change to last_align_down matches the reproduced split-tail
failure and fixes the inclusive-last issue there. I think the head-side
condition still uses the inclusive end of the generated head range in
places where the exclusive split boundary is needed.

In svm_range_split_head() the call is:

=09r =3D svm_range_split(prange, new_start, prange->last, &head);

This is case 2 in svm_range_split(): the generated range is
[old_start, new_start - 1], where old_start is the original prange start.
So for the head range:

=09head->last + 1 =3D=3D new_start

and new_start is the split boundary that should be checked for 2MB
alignment. That would make the head-side condition:

=09if (huge_page_mapping && new_start > start_align &&
=09    new_start < last_align_down && !IS_ALIGNED(new_start, 512))
=09=09list_add(&head->update_list, remap_list);

With an original page range [0, 1023], start_align is 0 and
last_align_down is 1024 after the last + 1 change.

For new_start =3D 512, the generated head is [0, 511]. The split boundary
is 512-page aligned, so this condition should not add the head to
remap_list, but checking !IS_ALIGNED(head->last, 512) checks 511 and
evaluates true.

For new_start =3D 513, the generated head is [0, 512]. The split boundary
is not 512-page aligned, so this condition should add the head to
remap_list, but checking !IS_ALIGNED(head->last, 512) checks 512 and
evaluates false.

This is the head-side issue Philip pointed out in the review of the
original change:

https://lore.kernel.org/all/32ce2b72-aa16-4202-9f99-92e3cd4408bc@amd.com/

I posted a v2 that keeps your tail-side last + 1 fix and uses new_start
for the head-side split-boundary checks:

https://lore.kernel.org/all/20260616105553.13062-1-geschw@pm.me/

Thanks,
Gerhard

