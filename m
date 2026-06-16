Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB319CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 15:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 599DB10E7BB;
	Tue, 16 Jun 2026 15:42:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="OojBAbqr";
	dkim-atps=neutral
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9BE310E7BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 15:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1781624538; x=1781883738;
 bh=+oKTVJXIqijwrbl5Sd4QMiLl8gU26y5uU8LzNVyH+Vw=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=OojBAbqr2npX4+dEUe9tBXBYHDwa4cZm+FignIGgmgHsV0eV5vBqflKPQDyRmwdqU
 NoW24dIYLAJo4SZ/itA+0wWjv5nArShnUfiDr3DKYrlV6XmNPvAenq9mGvvCBvXfGJ
 d5Ni25h5uqap8BPeKWvEtzVHpDsX0QIIipL5IQ4Vsg6OTIGzBGnjx/jvoCNjpudWWg
 1Ll5oxc68t4hDHX80vi8mtaPbw0UsCnVXdPsAxl376na/GQ7W/bmtFrA9rgQbBBG0j
 pg/vYarL32lD1H2ePJO3EHKmsJ908QSuyTjNRoblNnnpJbpeqHhaBW6m0lK7hK5T0C
 NI7bTPhAT9ZNA==
Date: Tue, 16 Jun 2026 15:42:11 +0000
To: Alex Deucher <alexdeucher@gmail.com>
From: Gerhard Schwanzer <geschw@pm.me>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Use last + 1 of vm range to check 2MB huge
 page alignment
Message-ID: <20260616154200.66824-1-geschw@pm.me>
Feedback-ID: 110185885:user:proton
X-Pm-Message-ID: e0639863b9f42eca51c1dce08d1066afa0e7d5d0
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

Hi Alex, Xiaogang,

thanks for looking at this quickly.

Replying here because this patch instance carries my Tested-by tag.
One clarification: my runtime testing covers the reproduced split-tail
fault on the RX 7600 XT. It does not validate the head-side boundary
condition in this exact patch.

The remaining concern is the head-side condition: this version still uses
head->last there. In svm_range_split_head(), the generated head range is
[old_start, new_start - 1], so the split boundary is new_start, i.e.
head->last + 1. I replied with the concrete boundary examples here:

https://lore.kernel.org/all/20260616152320.60210-1-geschw@pm.me/

For that reason I think the head-side condition should use the exclusive
split boundary, e.g. new_start as in v2:

https://lore.kernel.org/all/20260616105553.13062-1-geschw@pm.me/

To avoid my Tested-by tag being read as covering the head-side boundary
logic, please either use an exclusive-boundary version or drop my
Tested-by from this exact version. My test result covers the reproduced
split-tail regression, not the head-side boundary logic.

Thanks,
Gerhard

