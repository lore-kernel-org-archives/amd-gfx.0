Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EA0606A329
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=iyNwQqxU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 766C510EBF7;
	Mon,  2 Nov 2026 08:06:59 +0000 (UTC)
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB6BD10E223
 for <amd-gfx@lists.freedesktop.org>; Sat, 31 Oct 2026 04:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1793420905; x=1793680105;
 bh=E+G0HGZzUqRcXrX+5EumoQTV9M5s3BX/zBpN/7uRepI=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=iyNwQqxURK1W52utEzNmEyVuU/cmMVMG25RKVPBm9n771h8r/VbiqpgTZxNLffYM1
 qrpeokxIQvILWQRIzMN89lbCchWxs0gkTJFfLdtQ0pcjclSC+XdIMqPSVqFtKt171L
 z7pE5SBfhIAPDmj1tWprLecZ8gX+ObnW8rAcodu+nvuC4Nd0XrZ9F01Stb9av5WtKw
 /06+Fp4Gal4OHTqHozG/93MYVp5vfeBrN8cFvMsGMR6jlD8hPi9GuCKp2XlUW6w/gw
 4NRMMuQHT4NERKidWmpN3OjhIV2FGks1zXZpyj0iAAATOMws02GlOrIXn1ts+GzFKi
 3b4q8kPIF9auQ==
Date: Sat, 31 Oct 2026 04:28:21 +0000
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: aarthex <aarthex@proton.me>
Cc: "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>
Subject: [RFC] amdkfd: Native integration with DRM fences/syncobjs
Message-ID: <6LGhg_Yb_ppPcBcic7UenLy4cBVr66GyWswWm0xLqKQZc04YxYzLkPxbPNQj_2LvHWaG-hSzXaFM2ERSYhJbEOEUYXVn_tWBUYfMP_KzQAI=@proton.me>
Feedback-ID: 83802568:user:proton
X-Pm-Message-ID: 3e4ae005bf1a4bc02e88094287d67706b1bb9813
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:06:53 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Hello people,

Currently, amdkfd provides no native way to integrate itself into a wider e=
vent loop (like epoll or Wayland explicit sync) using standard DRM fences o=
r syncobjs.


There are some workarounds, like creating a syncobj and then signaling it f=
rom the CPU side after the GPU is done, either via polling or hardware inte=
rrupts.=20

But none of these are very tasteful, especially for something that is ideal=
ly the driver's job.

I opened a feature request for this on GitLab a bit ago here: https://gitla=
b.freedesktop.org/drm/amd/-/issues/6013


Before I work on implementing it, it would be nice to know if the team was =
open to accepting this, or if anyone had any thoughts/architectural pointer=
s to leave.

Thanks,
Arthex



