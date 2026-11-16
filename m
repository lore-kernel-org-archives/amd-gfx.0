Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A86F606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=GYsNCDZi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66FC10EEC4;
	Mon, 16 Nov 2026 09:28:47 +0000 (UTC)
X-Greylist: delayed 364 seconds by postgrey-1.36 at gabe;
 Mon, 16 Nov 2026 07:03:48 UTC
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B0D10E0C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 07:03:48 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1794812626; mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg==; d=web.de;
 s=s29768273:rsa-sha256:P2ObArKricoaLiccjWsgbRHaycvx
 m9aMeMRCu7hz20HQ7LxmGAfcZVxtAkMy4B7ocamohmOs3omRXVbI4Fif+WPSacQVy96+MpzW1GZ
 B1ztpN7zcOHYq0Xy3Z8UAyj/wwZdQUPARtKGfPTMc0Vr1a/QaKOOT9KVaqDx8gcj6vBWfyMvrq4
 rYkFv7gkq/3hR+fMi6cfdwZyPuwG/F4TBLNDGBg00eAsQxDdHkodV/VYd6Gr+bfYuoYxO+/b3N2
 BwAyFldRsBm+a0pR0m3TMCb0foNUU6cczbPDIIjyTpXhZOaRKQAz+ZezpWPbP13LnvGr6730y2q
 QV/fQUF7CCC+DQ==;
Message-Instance: m=1; h=sha256: 99KkjLcaCFDu2XPr/TWRdIixALd8b32ykvqsz5A45Kg=:
 t+mbs+keLTTSyK0Feil2CBRManvZhxjbmljm+9Ohq70=, sha512:
 oXKMCe7dZm9WzGu/e7ka04doAtqAKO1DBbRXKZeWlMVOORgqVICvH660GXcqC6XceHa735quf7G3A+K/g4yVkg==:
 cYh5JZugFqlsGMvsWDj7aKykdZH3rcA0wMM3KTda8SEGzmtFQf7SHwgC8a9L7Sw3AxBRQwFQqKLDnR4EVL5gTw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1794812615; x=1795417415; i=markus.elfring@web.de;
 bh=t+mbs+keLTTSyK0Feil2CBRManvZhxjbmljm+9Ohq70=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=GYsNCDZitHDCIXX2dXE6QOw2TTv+ULE+3ULXuKuKlPPtL0Ar/zqpDKyyjwOpmz2W
 EvgUuNzpaly+Iad1D6Yj7AqSA9sUiiZPtsaL0o5csReBlihgaLU1sVqqFc9LHqrP3
 m2w29vxDXWkG+5Sno3Td0v1A0Lg5Nav6rIh9VqhJ1MWnGuPkC/Edyin1y4tKPy3xV
 eB0d7hJ+jMHihbISHaVh9XdqLF8OpHkNJ1cPhUFy4y2X/mmoiJboVQC8zwRsNKwL2
 nxUQMwQfiCIxQLe+ZGYqIlbYoCpUsF3Ev34S8kigj99N2mcne7BoX3VoeOzNGmS31
 uncNndCoZR46oc17Dg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mo6Nt-1wdoaM2AF1-00aJZz; Mon, 16
 Nov 2026 07:57:41 +0100
Message-ID: <ae04eef3-ec99-4728-be84-8a71e16c0b4e@web.de>
Date: Mon, 16 Nov 2026 07:57:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jackie Liu <liuyun01@kylinos.cn>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>
Cc: Jackie Liu <liu.yun@linux.dev>, LKML <linux-kernel@vger.kernel.org>
References: <20261026111047.97178-1-liu.yun@linux.dev>
Subject: Re: [PATCH] drm/amd/display: Fix logger leak on perf trace allocation
 failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261026111047.97178-1-liu.yun@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vBVVPVd4B50xeqlYqh6dAXCHmu1AmDfbSQlwYkbPZ/mBNNRZCa+
 oMIFvNKJFRbDQsKd0OA3+n6VoEgCLNNvZY5hzPWQL1LmyvIOi0EorFcrBQy/B38YTIpf0iH
 FAU9q1nljb7Eh+ySdJVGp/DwpZKZJGzNKzaCebIeJvRve8N/jE76J1DRG7PedbkCItJqxUx
 wNqqrArldI8Hbx0zh3VQw==
UI-OutboundReport: notjunk:1;M01:P0:DjfLjbXhNEc=;BYh4Ac9gA//WUTXX4Pf9/rujj2i
 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
 rgW1LQXx6AXfLXEeatvbsdaY4ow==
X-Mailman-Approved-At: Mon, 16 Nov 2026 09:28:41 +0000
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
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=E2=80=A6
> Free the logger before discarding dc_ctx and clear dc->dml.logger to avo=
id
> leaving a dangling alias after the failed construction.

Would there be a need to complete the exception handling also after a fail=
ed
link_create_link_service() call in the implementation of the function =E2=
=80=9Cdc_construct_ctx=E2=80=9D?
https://elixir.bootlin.com/linux/v7.4-rc1/source/drivers/gpu/drm/amd/displ=
ay/dc/core/dc.c#L990-L1037

How do you think about to avoid duplicate source code another bit?

Regards,
Markus
