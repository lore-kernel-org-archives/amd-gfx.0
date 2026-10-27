Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A2C606A31B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AsGCZShs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6616410F5F1;
	Tue, 27 Oct 2026 14:39:49 +0000 (UTC)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E26BE10F5F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 14:39:42 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-7be536cd40dso165583137.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 07:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793111982; cv=none;
 d=google.com; s=arc-20260327;
 b=co+wGXZNsPSVsu7aa/eF8vkhURGa5Vr7/9WmmaaL6JUzHflHCYjZl/JAT8DAEHDgvc
 lvxi9AkJK1/zmhcD28JmQnomfGCXv/FvBQPN1S1dX9+sO/bxXIvLgNQJY3LerCHLCGTk
 210Aye8DlvPvX+elX3bLgnh21Nj3fapH0nD64iI6munPrfJxO1TQwq19R5M+19rpHTKm
 navX3cQXfA7I5Rg5A6GNEIAqJVDc6nMu+k9CfAPesgNLGbHOqLc4O3vvnXh67b4pWdUB
 wP3uf0bUIHl/IIXqZIH+sU5H2CXLUHTyFJPlk8E79/phcWmxLQTRgcHZ/PSQEaZFT2PB
 QP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EPrxV4E3cA8qmso3bBNM8N5Yygid8H6mmV3NvCJ0NcY=;
 fh=GxAh9JJnpHshEy9LCOS40FouDB0Cy392XF4NAZMX8n4=;
 b=B/E4MqrgBH1jTv887DySUcODFpXGhp2FlIqyy0o40NhLEOv0RzTKV4yjlTcXSrAGVp
 yPtcpD2hGqr7ZKc3BYtplccxzc9OJB8A1zsFdE4CRQN3XMDqSHCQH3+8uWPuwD7UKEj2
 dssAEpZjNskQrdr/QEdrZyATxMq8jFS7FCQMkNYaD0hxTFTR2LTaAAKR7Owrrcsz6TxI
 /iLn1jMdc4hGlNKkvd4aU+ydEWovAB0eGiTp3WlTek3AdOvkNyq/MNWo8iBcI2X8X+Qt
 FmZ6GhSN4FolLdtj2LTIHFcnV6WxH5DlSNe9BNgHBZnHSj5Y+JvhQX4V/z2uI9IV4Vat
 83VA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793111982; x=1793716782; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EPrxV4E3cA8qmso3bBNM8N5Yygid8H6mmV3NvCJ0NcY=;
 b=AsGCZShsSWfv555+Uqazg5tPKeFsPI/s/hGFS469F6fbE1ROQRPrJhYArmcVpYxAcH
 2VnU96v6ZBlzoMrF2RSOPbomCED2g9Ya+Hz1TapqWtkJBa1x/ar3wTEa10S4RLuAeJgm
 UgCT1tvN2tjeaPJJSiJXkheWOckm2N9oIZdmEcmzSgdbdafNvePkIYDICbseCDhhI1O1
 slz2ekP/wYoHuNg4kM0qHifC2NZTWm/jGbylYW/7uhom+I8UVBnMNI1H5vIZrcnBLnJs
 8uh57CxxvoxlJ8Z6B+apRRL+7xdjxZqlCBTfXBU7i1pzp42H2IjPYwzbghMYzZdj2SIU
 zPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111982; x=1793716782;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EPrxV4E3cA8qmso3bBNM8N5Yygid8H6mmV3NvCJ0NcY=;
 b=kxJAi4HO16WxqsZcKpccWImZncE3KaEPJlg7keEWjepDH8N9NwzEsrZKJXZ7GaszpA
 zKbNXOiah3j5nJATnptMhi6oFZ1UzRmpiASU8ZDe4G/GOzuvOP/SZkuALRYPFBRodu5I
 p9CTqgFFzPAqW1Ccebj24+3gDSIk0hwVf1vpQdLH5twLK72cbtAijgSUHmXUHsK/35Tt
 /+nq7AFxkpR0mmZnNYv4XZZdOUdAjMtxETlQ/IkMNxZauEaWNVD11M/20/8OsMqIvfvD
 oNu1dnIRAEik//M2K/ba3+9Bxe9ZgY9a6XVHM3LeJeWXvccSCFgOV3kpDKVW3o5hFANl
 LV4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy26WFJ9qDdA+nfGNqAJbGiDUwTPlQg5iJZA6HVkWDceojo5/cUYoyor4tGHpc/muqCDavvHkly@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIZot9q02NiEjnZTpRgH/6ILRhM9JPW/hhn0cH1ptPmsB8ZyTgu
 7H22cG+DgRnBQ8toBnLk/iXPh1g99BOlCgXjdZ4DrhzqdOcVo4qFVGikDNXSDuCp0sGon9PE/dO
 SjlrUoVjdRTD/hdkp17WL5DQpg/uiKf4=
X-Gm-Gg: AYBFou1XZUzOb1UOOxzTKXDyn5JtLf4m2UjFzpcJzxZDKik3QPf8X6DIEHsUR7G/FB2
 jdOOatbuVDzMwmXPCt6JwtA7p/JVtTRawmzYMocgWypl3Rx6gXONSZ2XPjLhcx5PLGjRnD7lyqR
 T5tkdl/vbQ6Az+D0XIq5ZXethkxrcoseo5goEfCp0CgdJOCjoq9xYkGpgDAQe49UT3nmNNjSkod
 oRp4rTlVTYdWD3/Qa+zm2slsX4wmLx9snBFm9XkT8EaLu5sBngBrDpbI/Ta9ZLl/iRVGTkJxkgU
 cJfpGTHZxuKzE/q+ZwfzdH+YCVqv4WtjcPwpc3fYWisOiDJXvJRGC6LZQHguz25BFejmVuAORQ6
 Zjx6AjaPacDVFN62blDVBmvfgU0zph4qCPzIo05TdRrRoGqs7xV9npOeGNleeFtL/CaA1GWss0S
 ilXsiH8XekhiSth26SxvrbveU=
X-Received: by 2002:a05:6102:868b:20b0:7b4:f1cd:80dd with SMTP id
 ada2fe7eead31-7ce5ca0ced9mr3651871137.1.1793111981697; Tue, 27 Oct 2026
 07:39:41 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022114754.865669-1-mptagliari@gmail.com>
 <20261022114754.865669-2-mptagliari@gmail.com>
 <88c61950-125e-4109-955e-ce09ebaab7af@amd.com>
 <0c7e45a13fb78064390818bb501e754b62f16f6e.camel@gmail.com>
 <20261027001506.27266-1-mptagliari@gmail.com>
 <6e0b5af2-692a-4b2f-ae20-9c164e7e42ed@amd.com>
 <d451b9a185817c576ebb7943a604fd1952470412.camel@gmail.com>
In-Reply-To: <d451b9a185817c576ebb7943a604fd1952470412.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Oct 2026 10:39:28 -0400
X-Gm-Features: AclHuK9s3CHTU3bFA1ccuwGnhC7tFGFBKddQ8ABnYXLC2ngK0GiJr07BAJIqJaM
Message-ID: <CADnq5_OGgbFOJtBu7SwvvnaN01F=RSqtxZgBhJ1fty4pwBHmVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/radeon: process the VCE interrupt on SI and
 Trinity
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Matheus Tagliari <mptagliari@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 10:31=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> On Tue, 2026-10-27 at 11:21 +0100, Christian K=C3=B6nig wrote:
> > On 10/27/26 01:15, Matheus Tagliari wrote:
> > > Hi Timur, Christian,
> > >
> > > Thanks for the input, Timur.
> > >
> > > To be clear, I'm not opposed to a backport. Fixing VCE1 for people
> > > stuck
> > > on the radeon driver with an LTS kernel is exactly the case that
> > > made me
> > > look into this in the first place. But my goal is only to help, and
> > > as I
> > > said before, I do not want to push a change you don't want.
> > >
> > > Christian, if you'd rather keep this out of stable, I'll drop the
> > > "Cc: stable" tag in v3 and leave the decision to you. If there is a
> > > specific concern behind it (risk of regressions on other SI/Trinity
> > > parts, say), I'd be glad to hear it. I can also try to address it,
> > > for
> > > example with more testing, so that a backport can be reconsidered
> > > later.
> >
> > I was part of the Trinity bringup back (I still have the engineering
> > sample here :) and I filled a full swear jar bringing VCE up on that
> > HW.
> >
> > Interrupts were definitely not working correctly back then.
> >
> > I have no idea when they were fixed but I want to avoid that people
> > start streaming that this change made their system not boot any more
> > and we are forced to revert a patch on stable kernels everywhere.
>
> @Christian
> Are you saying that you are worried about the backport because it may
> regress Trinity?
>
> @Matheus
> Would it be possible to only use the interrupt on SI and not on Trinity
> so as to alleviate Christian's worry?

I've committed the patches already.  I don't think the stable really
matters that much.  If there is a problem, we can revert.

Alex
