Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23EACD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 15:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E6810E7A0;
	Tue, 16 Jun 2026 15:50:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="aQE+sKHc";
	dkim-atps=neutral
X-Greylist: delayed 23927 seconds by postgrey-1.36 at gabe;
 Tue, 16 Jun 2026 15:50:01 UTC
Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch
 [109.224.244.121])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C959F10E7A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 15:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1781625000; x=1781884200;
 bh=BWs5SL/v81EtVQn7ZUw4+xRoFdcPwPEKr0cQz6Jkwug=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=aQE+sKHcU4RNLiy/lKG7laLU6A15duE+iDrNY8UU05eKVKoL3OGUBkVVUx59cORvD
 TeV/KQFXg2ymTE5JlBSH2bb4+PLoXPdE88dRMO2V7Z7sFxPP1wFnFwlHTGmu5R0IgQ
 /lLfw+camJU+Q6f8yk2tDugzU55Z6BS8+QZI+5Ry4NbEWORDdFUazCVU6s6HdaHdDv
 Ijx2kjsvDwxGc/dzlnOsaVyvQGFBIw4wRPr3+7jtR4JMdAV8MwIOrjdtqnK8Q5DZ/I
 nR+X/2i9K8XJMKsMHoM7gBjpGrWmk4ahEVjYPFZRlKXyUOg1qI2zmtJZYZUvN3H9Y4
 XRTTpnWEuRqJQ==
Date: Tue, 16 Jun 2026 15:49:53 +0000
To: Xiaogang Chen <xiaogang.chen@amd.com>
From: Gerhard Schwanzer <geschw@pm.me>
Cc: amd-gfx@lists.freedesktop.org,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Use last + 1 of vm range to check 2MB huge
 page alignment
Message-ID: <20260616154941.68673-1-geschw@pm.me>
Feedback-ID: 110185885:user:proton
X-Pm-Message-ID: 75347ba2fb1adbf4a6cff4e1263f8d4c6a22953a
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

Hi Xiaogang, Alex,

threading note: my clarification after Alex's ack is archived on lore,
but not attached to this patch instance there. Repeating only the
essential point here because this patch carries my Tested-by tag.

My Tested-by covers the reproduced split-tail fault on RX 7600 XT. It
does not validate the head-side boundary condition in this exact patch.

This version still uses head->last on the head side. In
svm_range_split_head(), the generated head range is [old_start,
new_start - 1], so the split boundary is new_start, i.e. head->last + 1.

Technical details and boundary examples:
https://lore.kernel.org/all/20260616152320.60210-1-geschw@pm.me/

Please either use an exclusive-boundary version for the head-side
condition, e.g. new_start as in v2, or drop my Tested-by from this exact
version.

v2:
https://lore.kernel.org/all/20260616105553.13062-1-geschw@pm.me/

Thanks,
Gerhard

