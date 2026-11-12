Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06151606A321
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=eAxqybbY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47CAD11212C;
	Thu, 12 Nov 2026 13:56:21 +0000 (UTC)
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03A1110E1DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 07:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1794467851; x=1794727051;
 bh=QW4sENIMwR8MNEKJj6gHiTwQIJhtyyl5wg/RcVDWz2o=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=eAxqybbYdRlzx+gH63jGpYf9B9S7crMeprqJgXwPmf13TiKtT1PcIgva7sEcAkS7d
 K7uFPlZxe8YojsFNQH/4jLqdsrfKTUwMsEAjAzmBZjQZmUjHleDT8VzgaLdYGBv13N
 JwHeTcD2LMHNFFmMGvUZvaUzWDZXQ/wVG7FU914T2tbF64hf9Y6pPQ32Qb2OY+0/Vd
 Jp3G+B9c42qUtDd2m8W/vWcl4IVc8sUDFcn0HpNaldWa9UyinwGjNw1/cuVAnBVHfs
 qJ5lvcgtskMHLhCjj7prVHsKb+5g5PxKazGtqw26c2wjRB28MIZwgoMQj7d4zfxBkd
 zWTIMnCjmy2yg==
Date: Thu, 12 Nov 2026 07:17:27 +0000
To: Wayne Lin <Wayne.Lin@amd.com>
From: =?utf-8?Q?Eren_=C3=96zen?= <erenozen@protonmail.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Roman Li <roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>,
 Chenyu Chen <Chen-Yu.Chen@amd.com>, Tony Qi <haoming.qi@amd.com>
Subject: Re: [PATCH 44/74] drm/amd/display: Fix KUnit tiled EDID size
Message-ID: <lUsA9VgO10K5HoejQbJb_cHwktMV2xMLFEqiWTN6siXkWFpXozVjkiP04I3UPUje1vVwTt7d3eUDc6s70KLVR9bstdtphhfTML9bzO45LNo=@protonmail.com>
In-Reply-To: <20261111014100.3596072-45-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
 <20261111014100.3596072-45-Wayne.Lin@amd.com>
Feedback-ID: 19860221:user:proton
X-Pm-Message-ID: c58cbbd5a2d06962b640185349f11325a21f981d
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 12 Nov 2026 13:56:07 +0000
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 09:28:50AM +0800, Wayne Lin wrote:
> dm_test_detect_hides_secondary_tile fails because its synthesized
> DisplayID tiled display block is 21 bytes, built around an 8-byte
> topology ID.

I hit this failure too. Ran the amdgpu_dm KUnit suite on UML
(kunit.py, amdgpu_dm/tests .kunitconfig, GCC 16, CONFIG_GCOV=3Dn) on
amd-staging-drm-next 47df73aa49:

  before: 1910/1912 passed (detect returned connected, expected
          disconnected)
  after this patch and 63/74: 1912/1912 passed

Tested-by: Eren =C3=96zen <erenozen@protonmail.com>

