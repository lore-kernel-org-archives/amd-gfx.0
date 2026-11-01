Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F1E606A326
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jcGFSo3n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E55E010EBF5;
	Mon,  2 Nov 2026 08:06:58 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDBEE10E3B6
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 Nov 2026 23:31:55 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so1153738f8f.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Nov 2026 15:31:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793575914; cv=none;
 d=google.com; s=arc-20260327;
 b=INQc9DyRjuZBYeXCvAo8XI8fusVHS9EJZDF0is/jtC0QBoFa/Nk240bl2zgQQZwOF5
 DaCzTFM5yOin9jeLuUQT0Rmtfr29y58/itcgsAFKR/p7ZJ6CBgtu/6wrc5wY3x9OefO4
 WsBSeFeby3QUC9INg84wM6WnyX5AsEA8D2GPd2I2oa+FB6WVJCVlzVqM2vwQqkwlly5e
 gmU3oyggxYi1iFnabKgl6VU1kBYQOX1ABeosmuHmKx1Hyrt7hxux4Tfqk2DYd+6M7Bbb
 6jTgOR2Bf36+pWmywS34I2VPsb8ZYzxtgUhnVxfskR1SoUW7K3gP8FbfTO5NYxkkb06R
 Lf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=O2dW7ANLcbwksfoB36b2BZaSwVJZbGyuN6/j0lvaHEA=;
 fh=nmBmiQzXJWXJoT+h+Z3zon4s4UPDGLfqzpmnuvYk1x4=;
 b=lVjr4BfmSyIkSCggV91uvdjVpocncDD651IstTdrdmQWqB9PjEpMG++n6ppZpohpkQ
 TahlZMs9nTeQym+7ryKcBQltfORtq6ZYgjRsCDiApnt59iSCxAe4TioIcbSmm9IXL8Qg
 RMjHqdE7c3sw0iY/QEHXsc5y+SUjWoTmBBEfEg9E9TsYGXt+PYKJV4RBs1RaPzJiLEjR
 IqD8Fobgp8pqw8BkFFOiZ8QnsB6L1GI1agAJqS2Q4B3C9YZLHeXBOutYXSksX79mYMNC
 Mt5XUcSYM7LQtjtArYstHI6GUn8zMu6Ipjz73fatfBaowfBMVxJi+21+VMJT38mMo0s6
 25zQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793575914; x=1794180714; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O2dW7ANLcbwksfoB36b2BZaSwVJZbGyuN6/j0lvaHEA=;
 b=jcGFSo3n2t+KEJVvYIn5IGXa3LWNnKCB6QMQ6QlbvkbRsLayfWk3jPiGIpk1vlVtpF
 1sUgh8L3R7Gr5iidMWb4G7XG5rYxgjhEjENs7K011hZkyPEYKz3u9nm4m95vPaF00lrT
 /exVCs+WvsFX+VK4/cyYOD7K74KRZdbTpStboI/yTXx3TlcC1iq8cKBsQPisdObveJVm
 DlOzVjJzOqC9zhFW/3fP0DGHfc9pN3jm6Mk2+KQmru9PoCGH2rq0RCXa6xcSCF6rKTdd
 5xFrngMgDHItnPzKLkxdRhQP6ABJ05YWyGyjvP8zNjmc2VeRA20ljglsAOWHXcN4D7LP
 2tTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793575914; x=1794180714;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=O2dW7ANLcbwksfoB36b2BZaSwVJZbGyuN6/j0lvaHEA=;
 b=uromXZqNN0ZgEHlr+cbdMBYslw7zL1AwoCjZXe+1Dol8NaGFRslMdaZWKnROzRgw5Z
 PBewBW9HU1g/EuVgh+qZqb1D5qOpiFci8sDoCqybPIjWTadfXc5OuZ14M3fjn2qwt6hm
 lg2YARpI1KQAbk6ZrwoF8vptQFnNzcSHWdkf0XMsbSxG8lzQZFKCPTW9K1v06+gIu+L2
 GrEXq8N3iVh3lCmm/JSjmlAEGAKHlVOVZVSVii78KsBSy4p5WwUs5qT7u2EygZ9OKwvd
 cHi5VADRjLtezkfmE9sxN4oTm3EhvnfrCXwRI0LravwAZMSPWiGxsR/3uzMdeOrcEat6
 Yc2A==
X-Gm-Message-State: APuU4Z+Lplz2T28x0gwOGXdvtFtw5Lbudb3Ky59oeEZrNAnYLrwbU6o8
 pzN4M/XqDXXXtwE27HEG8LjES4KkD2wj2MZ+QAwQH5R0UPDdYnQxOTOBiQxLq/m6vMtMP3AnYmt
 /9aNBBCs5AgWp5Yr3BiiTHGxNPWvuoaI=
X-Gm-Gg: AYBFou1vIYpBMtlbRJWfBOYO6eqlSq3+5Eibg+hwwFww6TM6f/2Pb0U6/dvzR3OU0TX
 8xzDIb9xeZfm3ldYgBh1K9eI8xtgiPWwdAG+PBp8PUo2FSDim6Fiv3PaQiXlUE2lyndbQpKI/R8
 9ILUUSn8R0Kp+p8ldgUUbOhRlPsFEuwOQDHwVoPSitQxYewWicufidxhaep0Qz2VtddnzKewsDe
 i6IuJqib3qhJFF9/2Wp6z3lXv6wh/0IILVFB6ruThueAUkHCzWUkx7G6yDP0OURdBmC/jU66l89
 lkjlXXfClBelj9h224qJN1od1SEU6lgV/wEl3EHbtaB/xBmYRmIeoTCb1pjxTqLaVB3Wem5ueel
 qjqrP6NA0f6mrHMZU4Ii6ZO5uBQ0FQvzwsEacSvP2cG/j9msKPRlA10+sCeoddA==
X-Received: by 2002:adf:e001:0:10b0:48d:f470:6b3e with SMTP id
 ffacd0b85a97d-48e6e30722amr14512940f8f.13.1793575914027; Sun, 01 Nov 2026
 15:31:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Arnaud BERTRAND <arnaud078@gmail.com>
Date: Mon, 2 Nov 2026 00:31:42 +0100
X-Gm-Features: AclHuK_KIdBX_UwH_WtDT3ovTG1iRA6ym5LzcTwWz_yv77CTIDTVYQQiG5byNdY
Message-ID: <CAGxFSwnJYc03fN+XWU8oLW9EbXhmetQuj1s3-m8UdZHoBdGJ8Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/amdgpu: add firmware file fallback for APU
 VBIOS discovery
To: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Oz Tiram <oz@shift-computing.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000003bbed7065f3f6f61"
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
X-Spam-Status: No, score=1.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000003bbed7065f3f6f61
Content-Type: text/plain; charset="UTF-8"

Hi Mario, Alex,

I have two dGPUs : a Radeon RX 6800
XT and a Radeon RX 6800. They both report the same PCI identity
1002:73bf and each has a different VBIOS.
I hit the same VFCT bus-number mismatch on 7.2.10, but with a different
outcome: on my machine the device-identity fallback actively breaks the
second
dGPU.
I patched my kernel to remove the fallback, but I would like to have a
better solution for my use case.
Would it be possible to apply the patch only to APUs ? That would keep Oz's
APU case working but a dGPU with a stale bus number would fall through to
its own ROM, which is the source that is
guaranteed to match the card in the slot.
I can provide more details if needed, I am out of my depth here.
Thanks
Arnaud

--0000000000003bbed7065f3f6f61
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Mario, Alex,</div><div><br></div><div></div><div>I=
 have two dGPUs : a Radeon RX 6800</div>XT and a Radeon RX 6800. They both =
report the same PCI identity<br><div>1002:73bf and each has a different VBI=
OS.</div>I hit the same VFCT bus-number mismatch on 7.2.10, but with a diff=
erent<br>outcome: on my machine the device-identity fallback actively break=
s the second<div>dGPU.=C2=A0</div><div>I patched my kernel to remove the fa=
llback, but I would like to have a better solution for my use case.</div><d=
iv>Would it be possible to apply the patch only to APUs ?=C2=A0That would k=
eep Oz&#39;s APU case working but a dGPU with a stale bus number would fall=
 through to its own ROM, which is the source that is<br>guaranteed to match=
 the card in the slot.=C2=A0</div><div>I can provide more details if needed=
, I am out of my depth here.</div><div>Thanks</div><div>Arnaud</div></div>

--0000000000003bbed7065f3f6f61--
