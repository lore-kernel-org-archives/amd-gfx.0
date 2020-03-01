Return-Path: <SRS0=OcZx=4S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB16EC3F2CD
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Mar 2020 19:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3EC2246BE
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Mar 2020 19:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVMauUgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EC2246BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1A676E22D;
	Sun,  1 Mar 2020 19:51:30 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA78D6E047;
 Sun,  1 Mar 2020 19:51:29 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id a5so8903312wmb.0;
 Sun, 01 Mar 2020 11:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+L26IBHSSuDNPkGPY6uq9gwJQV3iz4Ht1sQEj6t4RQI=;
 b=KVMauUgHe6RdY6kh5gS0Gu+Vt4tH0RAvCbN9y09j254AkbKIiOVbh0OM/E2bsnASqr
 Xg9VYji/zg9LVzIkVtK6U5FPoLSWvzV5bujevL3DDbmggtWigSbKawhNZW+AFhE0y+YK
 Qvo3D/u45xWCYTKyvwDitNnT9e9W0mjCjSDmSKNZgW8/vgcDHYW7KCCe9iGpzbr6/+9g
 TnNYiMqLQbBBMsp/BYdA7ZWZllltWdxTotesF8ZYNZISvaG+TeBNrok9AnfX+kI6Ik7Z
 BROOBLsmXTI1LwuOkutxgEwyk+q/KeZjd01EkwpUwZz731QTpa/DvZKdpFYOI9BwVEcy
 jPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+L26IBHSSuDNPkGPY6uq9gwJQV3iz4Ht1sQEj6t4RQI=;
 b=M0KiMgmM2ceHtF58gzFuIppJdzB8bhfA1fVCXjk/B7Y+p5MtYPT+eiea6ErJzF9QuB
 zeFbobRc+0lDqV9KQTCThVcU+UWpsz4YS7+xB++CBdmsMKOu8szhhntXX/KU7uUQnKFj
 G7Aw+giiWEMwIppaBFzsQmn2sWRzvV+tch/4sY9b7TVw+SkSUaO9mWyilKD+qxKo/zLi
 zXbBCmazP+EQofK7up+SMJqGy3Gqtng3ZVDXl8TyIj45V1lw7Q37PKUz8GdMgxn/3wYs
 2t5HqXaV09q+zLUocFV6K+fTb0AAYhmojmxzrGssXupRk3II+cCH14nmVkMWCMs4fYcZ
 mNVw==
X-Gm-Message-State: APjAAAUHLdTIKiK87DXu/50U6NruPFIB533yPKGp+OqWg+7girwosgqK
 sySw0ewCkdiQemhnJYzRO8MIRJEA2aWAUnBLdZI=
X-Google-Smtp-Source: APXvYqyoCA8xAHSUFppGU14VYQGo0Uodv8I++KrZLQ0C7kG9VaODUW2PJZRvap8Vb/HbXbe5EgV0ee7S4ZcC3Sf4Ovs=
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr15359438wml.173.1583092288239; 
 Sun, 01 Mar 2020 11:51:28 -0800 (PST)
MIME-Version: 1.0
References: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
 <CAPM=9txcGPvFdSzMtYZXyqLKnWyacSMuHdoXdV63M53fLFVFpw@mail.gmail.com>
 <b398161ff7d0268454413058dc6c194cf93f5990.camel@collabora.com>
 <ece8ebe3-40ec-2457-02da-4fef19cbe8f6@intel.com>
 <6d2ec570f957b4504fb70e0b1f0632712a99dc0c.camel@collabora.com>
 <CAPj87rO7BuKQj2Kei3T7RdkFq5=TiuShBvtrPU2sn0iqMfXSTg@mail.gmail.com>
 <59f4ea1f13a9a9d37f7801b93061b4ae7dd595e2.camel@gmail.com>
 <d0ef47e45c83b342494e6781b808b4831a008836.camel@ndufresne.ca>
 <9b0b31b8-7610-d5c5-790a-617178cc8c1e@daenzer.net>
 <93d7158b1ab49e51d14d991d5bdb2dba38ad6025.camel@ndufresne.ca>
In-Reply-To: <93d7158b1ab49e51d14d991d5bdb2dba38ad6025.camel@ndufresne.ca>
From: Jacob Lifshay <programmerjake@gmail.com>
Date: Sun, 1 Mar 2020 11:51:15 -0800
Message-ID: <CAC2bXD5OzDYtAcWAhpM_7Wwkbp2hpRszejjA7d0rqoypVdyDvA@mail.gmail.com>
Subject: Re: [Mesa-dev] [Intel-gfx] gitlab.fd.o financial situation and impact
 on services
To: Nicolas Dufresne <nicolas@ndufresne.ca>
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
Cc: Erik Faye-Lund <erik.faye-lund@collabora.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 "X.Org development" <xorg-devel@lists.x.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 wayland <wayland-devel@lists.freedesktop.org>,
 "X.Org Foundation Board" <board@foundation.x.org>,
 Xorg Members List <members@x.org>,
 Discussion of the development of and with GStreamer
 <gstreamer-devel@lists.freedesktop.org>,
 Mesa Dev <mesa-dev@lists.freedesktop.org>,
 Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
 Daniel Stone <daniel@fooishbar.org>,
 intel-gfx <intel-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1273776123=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1273776123==
Content-Type: multipart/alternative; boundary="0000000000007cbece059fd065cd"

--0000000000007cbece059fd065cd
Content-Type: text/plain; charset="UTF-8"

One idea for Marge-bot (don't know if you already do this):
Rust-lang has their bot (bors) automatically group together a few merge
requests into a single merge commit, which it then tests, then, then the
tests pass, it merges. This could help reduce CI runs to once a day (or
some other rate). If the tests fail, then it could automatically deduce
which one failed, by recursive subdivision or similar. There's also a
mechanism to adjust priority and grouping behavior when the defaults aren't
sufficient.

Jacob

--0000000000007cbece059fd065cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">One idea for Marge-bot (don&#39;t know if you already do =
this):<div dir=3D"auto">Rust-lang has their bot (bors) automatically group =
together a few merge requests into a single merge commit, which it then tes=
ts, then, then the tests pass, it merges. This could help reduce CI runs to=
 once a day (or some other rate). If the tests fail, then it could automati=
cally deduce which one failed, by recursive subdivision or similar. There&#=
39;s also a mechanism to adjust priority and grouping behavior when the def=
aults aren&#39;t sufficient.</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Jacob</div></div>

--0000000000007cbece059fd065cd--

--===============1273776123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1273776123==--
