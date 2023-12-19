Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A82DC46CA2
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Dec 2023 17:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F68010E4D4;
	Tue, 19 Dec 2023 17:01:26 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46DB010E4D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 17:01:24 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1f066fc2a2aso1564410fac.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 09:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703005283; x=1703610083; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A86hRA+Z/z0c3itpc9F8Zb+jzXF87R/S8fePRsyMfBI=;
 b=ci+fLuE0EjXHGWHCoSmbrhItXajkMN25nNR49ddi63RsemNv8I8K+m/wXG4aUudo+n
 nxwtXsMv62p3qVF0eN+rzkKDse+ltB7JEBeb1SoMK0AzDtxMpqumcHc0hkluomRijWma
 gYf2+nub1DJnKWPZtD3bG6411x9U9pRNWK1b//9AVHHIMAvbbvS7tVVDg91X7l3irmDR
 kUpZGzKMm+afmp2pu5le+wepPu5rgNtXb8VCK3eQC1LuB5v5CoSJwOnnKtfnfEL7p9M9
 9SGPDm+6EoOQIzB5C9Q2rXBctQQmFhrkrPWgkLJoWJ7HbxtSdAa29iY8CPaVQebdqCZN
 1DJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703005283; x=1703610083;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A86hRA+Z/z0c3itpc9F8Zb+jzXF87R/S8fePRsyMfBI=;
 b=i+LM8lYNvEjpcFrB+Cll/zNv3FFvlYkzCxYlP4Ubl2XIUOQvP03zUyYYVg0mtvzKmG
 YJHam0YNPma6X0Q9bmZGWovwjmydZaL5wsnqAcCRtP2uTNFz3zXRzQ+/pApe2HFVLUwX
 iSRwGEDuEvUF/kOP09JWgv+ETY48JvkkoExmVRP98enr///uc3gFjnKk7JQryTzKCtEL
 64wj1pfNYu0yDBCiHedoMZMwTVPlcgyhO6kBnqX8KLUuQQ7TJCGeqcQ1g9ApjC2sW5U8
 sdTxU5XtUkQv7V5ReyON42mIBdT4QrLjWseP2HTXvtUHpFLZ3bOaVH3Ehiy2OsUS6Qbo
 45mA==
X-Gm-Message-State: AOJu0YwFjENNmaqJGSTUhO6jMxp6u8p3Z0DBKOlBjaZy9d24hmBrkM28
 4qWr+v9FKOMsgDPXq8Og1bZALwmeJPipP39uMj8=
X-Google-Smtp-Source: AGHT+IGeUl1MbfNOrgjTYrpo1XVU9xDLT+jahGnrtMt7bHVd/782HmAf9UnjIXS2bvOujgh/sfDglT+PmJ4FtTz/qzI=
X-Received: by 2002:a05:6870:6ec7:b0:1fb:75b:2ba4 with SMTP id
 qv7-20020a0568706ec700b001fb075b2ba4mr10647440oab.96.1703005283322; Tue, 19
 Dec 2023 09:01:23 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
 <886c29fc-0b0c-4f7c-a2fa-f015a2b51fa3@amd.com>
 <CABXGCsNY2aR93pX0AtWUZ1v0QLj3ANoDmS13HCcdN-c4htHbtg@mail.gmail.com>
In-Reply-To: <CABXGCsNY2aR93pX0AtWUZ1v0QLj3ANoDmS13HCcdN-c4htHbtg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Dec 2023 12:01:11 -0500
Message-ID: <CADnq5_Nj3pP4MNnGz+WZZFOtWrXE5-jYQsbkHyCkxWYV-HJrCw@mail.gmail.com>
Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, daniel.wheeler@amd.com,
 hersenxs.wu@amd.com, alvin.lee2@amd.com, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 18, 2023 at 1:31=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Fri, Dec 15, 2023 at 9:14=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd.=
com> wrote:
> >
> > Can you try the following patch with old fw (version 0x07002100 should
> > be fine)?: https://patchwork.freedesktop.org/patch/572298/
> >
>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> on 7900XTX har=
dware.
>
> Can I ask?
> What does SubVP actually do?
> I read on Phoronix that this is new feature of DCN 3.2 hardware
> https://www.phoronix.com/news/AMDGPU-Linux-6.5-Improvements
> But I didn't notice that anything began to work better after enabling
> this feature.
> On the contrary, my kernel logs began to become overgrown with
> unpleasant errors.
> See here: https://gitlab.freedesktop.org/drm/amd/-/issues/2796
> I bisected this issue and bisect heads me to commit
> 299004271cbf0315da327c4bd67aec3e7041cb32 which enables SubVP high
> refresh rate.
> But without SubVP I also had 120Hz and 4K. So I ask again what is the
> profit of SubVP?

IIRC, SubVP is a power saving feature which allows us to dynamically
adjust the memory clocks in more cases with narrow blanking periods.

Alex
